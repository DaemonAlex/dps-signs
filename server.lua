-- DPS sign rotation: cycles a message deck across every SmartSigns board.
-- SmartSigns rules: each line must be UNDER 15 characters; server-originated
-- SmartSigns:apiUpdateSign calls bypass player permission checks.

local ROTATE_MINUTES = 12

-- { line1, line2, line3, icon } - all lines <= 14 chars
local DECK = {
    { 'WELCOME TO',   'DEL PERRO',    'SANDS',        'bv_smart_drivecare' },
    { 'SEAT BELTS',   'SAVE LIVES',   'BUCKLE UP',    'bv_smart_drivecare' },
    { 'DONT DRINK',   'AND DRIVE',    'CALL A TAXI',  'bv_smart_alcohol' },
    { 'WATCH FOR',    'TRAINS AT',    'CROSSINGS',    'bv_smart_stop' },
    { 'GANG ACTIVITY','IN SOUTH LS',  'STAY ALERT',   'bv_smart_drivecare' },
    { 'PHONE DOWN',   'EYES UP',      '',             'bv_smart_nophone' },
    { 'ROADWORK',     'EXPECT',       'DELAYS',       'bv_smart_roadwork' },
    { 'MOVE OVER',    'FOR EMERGENCY','VEHICLES',     'bv_smart_moveover' },
    { 'PEDESTRIANS',  'CROSSING',     'SLOW DOWN',    'bv_smart_pedestrian' },
    { 'TIRED?',       'TAKE A BREAK', '',             'bv_smart_tiredness' },
    { 'REPORT CRIME', 'DIAL 911',     '',             'bv_smart_drivecare' },
    { 'HEAVY TRAFFIC','AHEAD',        'PLAN ROUTE',   'bv_smart_trafficahead' },
}

local signCount = 0
local step = 0

local function countSigns()
    local raw = LoadResourceFile('SmartSigns', 'locations.json')
    if not raw then return 0 end
    local ok, data = pcall(json.decode, raw)
    return (ok and type(data) == 'table') and #data or 0
end

local function applyRotation()
    for id = 1, signCount do
        local m = DECK[((id + step) % #DECK) + 1]
        TriggerEvent('SmartSigns:apiUpdateSign', id, {
            firstLine  = m[1],
            secondLine = m[2],
            thirdLine  = m[3],
        }, m[4])
        Wait(50)  -- don't flood the sign resource
    end
    step = step + 1
end

CreateThread(function()
    -- let SmartSigns finish mounting before the first pass
    while GetResourceState('SmartSigns') ~= 'started' do Wait(1000) end
    Wait(5000)
    signCount = countSigns()
    if signCount == 0 then
        print('^1[dps-signs]^7 could not read SmartSigns locations.json - rotation disabled')
        return
    end
    print(('^2[dps-signs]^7 rotating %d messages across %d signs every %d min'):format(#DECK, signCount, ROTATE_MINUTES))
    while true do
        applyRotation()
        Wait(ROTATE_MINUTES * 60 * 1000)
    end
end)
