local data = nil
local cfgDungeon = nil
local dungeonData = nil
local isLock = false
local lockStr = ""
local isSelect = false
local currLevel = 1
local colors = {{145, 185, 63, 255}, {211, 68, 218, 255}}
local starColors = {{255, 193, 70, 255}, {98, 98, 98, 255}, {49, 49, 49, 255}}
local ids = nil

function Awake()
    SetSelect(false)
    InitAnim()
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function SetSelect(b)
    isSelect = b
    local levelColor = currLevel == 1 and colors[1] or colors[2]
    local color = isSelect and levelColor or {98, 98, 98, 255}
    CSAPI.SetImgColor(numImg, color[1], color[2], color[3], color[4])
    if b then
        CSAPI.SetGOActive(selImg, false)
        CSAPI.SetGOActive(selAnim, true)
        FuncUtil:Call(function()
            CSAPI.SetGOActive(selAnim, false)
            if isSelect then
                CSAPI.SetGOActive(selImg, true)
            end
        end, this, 500)
    else
        CSAPI.SetGOActive(selImg, false)
        CSAPI.SetGOActive(selAnim, false)
    end
end

function Refresh(_data, _elseData)
    data = _data
    currLevel = _elseData
    if data then
        ids = data:GetDungeonGroups()
        if ids then
            cfgDungeon = Cfgs.MainLine:GetByID(ids[1])
            dungeonData = DungeonMgr:GetDungeonData(cfgDungeon.id)
            local isOpen,_lockStr = data:IsOpen()
            isLock,lockStr = not isOpen,_lockStr
            CSAPI.SetGOActive(dangerObj, #ids > 1)
            CSAPI.SetGOActive(starObj, #ids < 2)
            SetBG()
            SetTitle()
            SetStar()
            SetPlot()
            SetLock()
            SetNew(dungeonData and dungeonData:IsOpen() and not dungeonData:IsPass())
        end
    end
end

function SetBG()
    local name1, name2 = "normal", "unLock"
    name1 = currLevel == 2 and "hard" or name1
    name2 = isLock and "lock" or name2
    CSAPI.LoadImg(bg, "UIs/DungeonActivity4/" .. name1 .. "_" .. name2 .. ".png", true, nil, true)
end

function SetTitle()
    CSAPI.SetText(txtLevel, LanguageMgr:GetByID(15124) .. " " .. index)
    CSAPI.SetText(txtTitle, cfgDungeon.name)
    CSAPI.SetText(txtIndex, index .. "")
    CSAPI.SetText(txtEnTitle, LanguageMgr:GetByID(15125) .. "-" .. index)
end

function SetStar()
    CSAPI.SetGOActive(starObj,not IsStory() and not IsDanger())
    local completeInfo = dungeonData and dungeonData:GetNGrade() or {0, 0, 0}
    local color = nil
    for i = 1, 3 do
        color = completeInfo[i] == 1 and starColors[1] or starColors[2]
        color = isLock and starColors[3] or color
        CSAPI.SetImgColor(this["star" .. i].gameObject, color[1], color[2], color[3], color[4])
    end
end

function SetPlot()
   CSAPI.SetGOActive(plotObj, IsStory()) 
end

function SetLock()
    local color1 = isLock and {146, 146, 150, 255} or {255, 255, 255, 255}
    CSAPI.SetTextColor(txtLevel, color1[1], color1[2], color1[3], color1[4])
    CSAPI.SetTextColor(txtIndex, color1[1], color1[2], color1[3], color1[4])
    CSAPI.SetTextColor(txtEnTitle, color1[1], color1[2], color1[3], color1[4])
    local color2 = isLock and {49, 49, 49, 255} or {98, 98, 98, 255}
    CSAPI.SetImgColor(numImg, color2[1], color2[2], color2[3], color2[4])
    local color3 = isLock and {49, 49, 49, 255} or {37, 37, 37, 255}
    CSAPI.SetTextColor(txtTitle, color3[1], color3[2], color3[3], color3[4])
end

function SetNew(b)
    CSAPI.SetGOActive(newImg, b)
end

function SetIsLock(b)
    isLock = b
end

function GetTargetInfo()
    local infos = nil
    if data:GetTargetJson() then
        infos = data:GetTargetJson()
    end
    return infos
end

function GetCfg()
    return cfgDungeon
end

function GetID()
    return cfgDungeon and cfgDungeon.id
end

function GetName()
    return data and data:GetName() or ""
end

function IsDanger()
    return ids and #ids > 1
end

function IsStory()
    return cfgDungeon and cfgDungeon.sub_type == DungeonFlagType.Story;
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

function GetType()
    local type = DungeonInfoType.Normal 
    if IsDanger() then
        type = DungeonInfoType.Danger
    elseif IsStory() then
        type = DungeonInfoType.Plot
    end
    return type
end

function OnClick()
    if isLock then
        Tips.ShowTips(lockStr)
        return
    end
    if cb then
        cb(this)
    end
end

-----------------------------------------------anim-----------------------------------------------
function InitAnim()
    CSAPI.SetGOActive(bgUnLockAnim, false)
end

function PlayUnLockAnim(callBack)
    CSAPI.SetGOActive(bgUnLockAnim, true)
    FuncUtil:Call(function()
        CSAPI.SetGOActive(bgUnLockAnim, false)
        if callBack then
            callBack()
        end
    end, this, 400)
end
