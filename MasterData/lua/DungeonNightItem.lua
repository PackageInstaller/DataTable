local data = nil
local currLevel = 1
local isOpen = false
local lockStr = ""
local ids = nil
local cfgDungeon = nil
local dungeonData = nil
local isPlot = false
local isPass= false

function Awake()
    InitAnim()
    SetSelect(false)
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function SetSelect(b)
    CSAPI.SetGOActive(selImg1,b)
    CSAPI.SetGOActive(selImg2,b)
    CSAPI.SetGOActive(selImg3,b)
end

function Refresh(_data,_elseData)
    data = _data
    currLevel = _elseData or 1
    if data then
        isOpen,lockStr = data:IsOpen()
        ids = data:GetDungeonGroups()
        cfgDungeon = Cfgs.MainLine:GetByID(ids[1])
        dungeonData = DungeonMgr:GetDungeonData(cfgDungeon.id)
        isPlot = cfgDungeon and cfgDungeon.sub_type ~= nil  
        isPass =  dungeonData and dungeonData:IsPass()
        SetTitle()
        SetPass()
        SetPlot()
        SetDungeon()
        SetLock()
        SetStar()
        SetNew()
    end
end

function SetTitle()
    CSAPI.SetText(txtStage,LanguageMgr:GetByID(15124) .. (index < 10 and "0"..index or index))
    CSAPI.SetText(txtTitle,data:GetName())

    local code = currLevel == 1 and "55547C" or "3a0000"
    CSAPI.SetTextColorByCode(txtTitle,code)
    CSAPI.SetTextColorByCode(txt_title,code)
end

function SetPlot()
    CSAPI.SetGOActive(plotImg,isPlot)
end

function SetPass()
    CSAPI.SetGOActive(passObj,isPass)
end

function SetDungeon()
    local iconName1 = currLevel == 1 and "easy_02" or "hard_02"
    CSAPI.LoadImg(stageImg,"UIs/DungeonActivity9/" .. iconName1 .. ".png",true,nil,true)
    local iconName2 = currLevel == 1 and "easy_01" or "hard_01"
    CSAPI.LoadImg(icon1,"UIs/DungeonActivity9/" .. iconName2 .. ".png",true,nil,true)
    local iconName3 = currLevel == 1 and "easy_03" or "hard_03"
    CSAPI.LoadImg(passImg,"UIs/DungeonActivity9/" .. iconName3 .. ".png",true,nil,true)
end

function SetLock()
    CSAPI.SetGOActive(lockObj,not isOpen)
end

function SetStar()
    CSAPI.SetGOActive(starObj,not isPlot and not IsDanger() and not IsSpecial())
    if not isPlot and not IsDanger() and not IsSpecial() then
        local starNum = 0
        if dungeonData then
            starNum = dungeonData:GetStar()
        end
        local iconName = ""
        for i = 1, 3 do
            iconName = i <= starNum and "star_01" or "star_02"
            CSAPI.LoadImg(this["star" .. i].gameObject,"UIs/DungeonActivity9/" .. iconName .. ".png",true,nil,true)
        end
    end
end

function SetNew()
    CSAPI.SetGOActive(newImg,dungeonData and dungeonData:IsOpen() and not dungeonData:IsPass())
end

function SetLine(b)
    CSAPI.SetGOActive(lineImg,isOpen and b)
end

function GetCfg()
    return cfgDungeon
end

function GetType()
    if cfgDungeon and cfgDungeon.sub_type and cfgDungeon.sub_type == 1  then
        return DungeonInfoType.NightPlot
    elseif IsDanger() then
        return DungeonInfoType.NightDanger
    elseif IsSpecial() then
        return DungeonInfoType.NightSpecial
    end
    return DungeonInfoType.Night
end

function GetCfgs()
    local cfgs = {}
    if ids and #ids > 0 then
        for _, cfgId in ipairs(ids) do
            local cfg =Cfgs.MainLine:GetByID(cfgId)
            if cfg then
                table.insert(cfgs,cfg)
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
    return data and data:GetTargetJson()
end

-----------------------------------------------anim-----------------------------------------------
function InitAnim()
    CSAPI.SetGOActive(lockAnim,false)
end

function ShowEffect(go)
    CSAPI.SetGOActive(go,false)
    CSAPI.SetGOActive(go,true)
end

function ShowUnLockAnim()
    CSAPI.SetGOActive(lockObj, true)
    CSAPI.SetGOActive(lockImg, false)
    ShowEffect(lockAnim)
    FuncUtil:Call(function ()
        CSAPI.SetGOActive(lockObj,false)
        CSAPI.SetGOActive(lockImg, true)
    end,this,350)
end