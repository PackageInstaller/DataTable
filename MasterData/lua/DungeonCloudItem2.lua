local data = nil
local easyAnim,hardAnim,extraAnim,birdAnim
local levelAnimName = {"easy","hard","extra"}
local levelAnims = {}
local currLevel = 1
local isSel =false

local BirdType = {}
BirdType.Enter = 1
BirdType.Idle = 2
BirdType.Quit = 3
local birdTimer,birdTime = 0,0
local birdOffsetTime = 5

function Awake()
    table.insert(levelAnims,ComUtil.GetCom(easyAnimObj,"Animator"))
    table.insert(levelAnims,ComUtil.GetCom(hardAnimObj,"Animator"))
    table.insert(levelAnims,ComUtil.GetCom(extraAnimObj,"Animator"))
    birdAnim = ComUtil.GetCom(Jige_pos,"Animator")
    CSAPI.SetGOActive(effectObj,false)
    CSAPI.SetGOActive(icon02,false)
end

function Update()
    UpdateBirdTime()
end

--DungeonGroupData
function Refresh(_data,_elseData)
    data = _data
    currLevel = _elseData or 1
    if data then
        SetPos()
        -- SetIcon()
        SetAnim()
    end
end

function Refresh2(lv)
    if lv then
        currLevel = lv
        SetAnim()
    end
end

function SetPos()
    local pos = data:GetPos()
    CSAPI.SetAnchor(gameObject,pos.x,pos.y)
end

function SetIcon()
    -- local iconName = data:GetIcon()
    -- if iconName and iconName~= "" then
    --     ResUtil.DungeonCloud:Load(icon01,iconName.."_01")
    --     ResUtil.DungeonCloud:Load(icon02,iconName.."_02")
    --     ResUtil.DungeonCloud:Load(icon02_glow,iconName.."_02")
    -- end
end

function SetAnim()
    CSAPI.SetGOActive(easyAnimObj,currLevel == 1)
    CSAPI.SetGOActive(hardAnimObj,currLevel == 2)
    CSAPI.SetGOActive(extraAnimObj,currLevel == 3)
end

function ShowAnim(b)
    isSel = b
    CSAPI.SetGOActive(effectObj,b)
    CSAPI.SetGOActive(icon02,b)
    if not IsNil(levelAnims[currLevel]) then
        levelAnims[currLevel]:SetBool("isSel",b)
    end
    ShowBirdAnim(b and BirdType.Enter or BirdType.Quit)
    birdTime = b and TimeUtil:GetTime() + birdOffsetTime or 0
end

---------------------------------------------birdAnim---------------------------------------------

local enterAnimNames = {"Jige_entry","Jige_entry1","Jige_entry2","Jige_entry3"}
local quitAnimNames = {"Jige_quit","Jige_quit1","Jige_quit2","Jige_quit3"}
local idleAnimNames = {"Jige_flying1","Jige_look","Jige_scream","Jige_standby2","Jige_flower"}

function ShowBirdAnim(type)
    local animName = ""
    if type == BirdType.Enter then
        animName = enterAnimNames[CSAPI.RandomInt(1,#enterAnimNames)]
    elseif type == BirdType.Idle then
        animName = idleAnimNames[CSAPI.RandomInt(1,#idleAnimNames)]
    elseif type == BirdType.Quit then
        animName = quitAnimNames[CSAPI.RandomInt(1,#quitAnimNames)]
    end
    if animName ~= "" and not IsNil(birdAnim) then
        birdAnim:Play(animName)
    end
end

function UpdateBirdTime()
    if isSel then
        return
    end

    if birdTime > 0 and Time.time > birdTimer then
        birdTimer = Time.time + 1
        if birdTime - TimeUtil:GetTime() <= 0 then
            birdTime = TimeUtil:GetTime() + birdOffsetTime
            ShowBirdAnim(BirdType.Idle)
        end
    end
end 