local data = nil
local currLevel = 1
local isOpen = false
local lockStr = ""
local ids = nil
local cfgDungeon = nil
local dungeonData = nil
local isPlot = false
local isPass = false
local anim = nil

function Awake()
    InitAnim()
end

function OnEnable()
    -- if not IsNil(anim) then
    --     anim.enabled = true
    -- end
end

function OnDisable()
    -- if not IsNil(anim) then
    --     anim.enabled = false
    -- end
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function SetSelect(b)
    CSAPI.SetGOActive(selImg.gameObject, b)
end

function Refresh(_data, _elseData)
    data = _data
    currLevel = _elseData or 1
    if data then
        isOpen, lockStr = data:IsOpen()
        ids = data:GetDungeonGroups()
        cfgDungeon = Cfgs.MainLine:GetByID(ids[1])
        dungeonData = DungeonMgr:GetDungeonData(cfgDungeon.id)
        isPlot = cfgDungeon and cfgDungeon.sub_type ~= nil
        isPass = dungeonData and dungeonData:IsPass()
        SetTitle()
        SetPass()
        SetPlot()
        SetDungeon()
        SetLock()
        SetStar()
        SetNew()
        SetAnim()
    end
end

function SetTitle()
    CSAPI.SetText(txtTitle, isOpen and data:GetName() or "")
end

function SetPlot()
    CSAPI.SetGOActive(plotImg, isPlot and isOpen)
end

function SetPass()
    CSAPI.SetGOActive(passImg, isPass)
end

function SetDungeon()
    CSAPI.LoadImg(icon, "UIs/DungeonActivity18/" .. "nol_0" ..currLevel .. "_01.png", true, nil, true)
    CSAPI.LoadImg(nolMask, "UIs/DungeonActivity18/" .. "nol_0" ..currLevel .. ".png", true, nil, true)
end

function SetLock()
    CSAPI.SetGOActive(nolMask,not isOpen)
end

function SetStar()
    CSAPI.SetGOActive(starObj, not isPlot and not IsDanger() and not IsSpecial() and isOpen)
    if not isPlot and not IsDanger() and not IsSpecial() and isOpen then
        local starNum = 0
        if dungeonData then
            starNum = dungeonData:GetStar()
        end
        local iconName = ""
        for i = 1, 3 do
            iconName = currLevel == 1 and "star1" or "star2"
            CSAPI.LoadImg(this["star" .. i].gameObject, "UIs/DungeonActivity18/" .. iconName .. ".png", true, nil, true)
            CSAPI.SetGOActive(this["star" .. i].gameObject, i <= starNum)
        end
    end
end

function SetNew()
    CSAPI.SetGOActive(newImg, isOpen and not isPass)
end

function GetCfg()
    return cfgDungeon
end

function GetType()
    if cfgDungeon and cfgDungeon.sub_type and cfgDungeon.sub_type == 1 then
        return DungeonInfoType.DesirePlot
    elseif IsDanger() then
        return DungeonInfoType.DesireDanger
    elseif IsSpecial() then
        return DungeonInfoType.DesireSpecial
    end
    return DungeonInfoType.Desire
end

function GetCfgs()
    local cfgs = {}
    if ids and #ids > 0 then
        for _, cfgId in ipairs(ids) do
            local cfg = Cfgs.MainLine:GetByID(cfgId)
            if cfg then
                table.insert(cfgs, cfg)
            end
        end
    end
    return cfgs
end

function IsPlot()
    return cfgDungeon and cfgDungeon.sub_type
end

function IsDanger()
    return ids and #ids > 1
end

function IsSpecial()
    return cfgDungeon and cfgDungeon.diff and cfgDungeon.diff == 4
end

function OnClick()
    if not isOpen then
        Tips.ShowTips(lockStr)
        return
    end
    if cb then
        cb(this)
    end
end

-----------------------------------------------info-----------------------------------------------
function GetInfo()
    return data and data:GetTargetJson() and data:GetTargetJson()[1]
end

-----------------------------------------------anim-----------------------------------------------
function InitAnim()
    anim = ComUtil.GetCom(node, "Animator")
end

function SetAnim()

end

function ShowEffect(go)
    CSAPI.SetGOActive(go, false)
    CSAPI.SetGOActive(go, true)
end

function PlayAnim(str)
    if not IsNil(anim) then
        anim:Play(str)
    end
end

function ShowEnterAnim(time)
    CSAPI.SetGOAlpha(gameObject,0)
    FuncUtil:Call(function ()
        CSAPI.SetGOAlpha(gameObject,1)
        PlayAnim("item_entry")
    end,this,time)
end

function ShowQuitAnim()
    
end

function ShowSelAnim(b)
    CSAPI.SetGOActive(selImg, b)
    if not IsNil(anim) then
        anim:Play(b and "item_sel" or "item_Nsel")
    end
end

function ShowUnLockAnim()
    
end
