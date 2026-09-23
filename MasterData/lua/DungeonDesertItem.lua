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
    CSAPI.SetGOActive(selImg, b)
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
        -- CSAPI.SetAnchor(pos,0,index%2 == 0 and 14 or -44)
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
    CSAPI.SetText(txtTitle, data:GetName())
    local code = currLevel == 1 and "551212" or "E1C9AC"
    CSAPI.SetTextColorByCode(txtTitle, code)
    local indexStr = index < 10 and "0" .. index or index
    CSAPI.SetText(txtStage, LanguageMgr:GetByID(15124) .. " " .. indexStr)
end

function SetPlot()
    CSAPI.SetGOActive(plot_icon, isPlot)
    CSAPI.SetGOActive(ploticon_dec, isPlot)
    if isPlot then
        local iconName = currLevel == 1 and "nol" or "hard"
        iconName = currLevel == 3 and "extra" or iconName
        CSAPI.LoadImg(dungeon_icon, "UIs/DungeonActivity17/" .. iconName .. "_icon_1.png", true, nil, true)
        CSAPI.LoadImg(dungeonicon_dec, "UIs/DungeonActivity17/" .. iconName .. "_text_1.png", true, nil, true)
    end
end

function SetPass()
    CSAPI.SetGOActive(passImg, isPass)
end

function SetDungeon()
    local iconName = currLevel == 1 and "nol" or "hard"
    iconName = currLevel == 3 and "extra" or iconName
    CSAPI.LoadImg(img_bg, "UIs/DungeonActivity17/" .. iconName .. "_bg.png", true, nil, true)
    CSAPI.SetGOActive(dungeon_icon, not isPlot)
    CSAPI.SetGOActive(dungeonicon_dec, not isPlot)
    if not isPlot then
        CSAPI.LoadImg(dungeon_icon, "UIs/DungeonActivity17/" .. iconName .. "_icon_1.png", true, nil, true)
        CSAPI.LoadImg(dungeonicon_dec, "UIs/DungeonActivity17/" .. iconName .. "_text_1.png", true, nil, true)
    end
    local code = currLevel == 1 and "3d170e" or "921f1d"
    code = currLevel == 3 and "fff2d6" or code
    if not isOpen then
        code = currLevel < 3 and "2b221a" or "75695c"
    end
    CSAPI.SetTextColorByCode(txtTitle, code)
end

function SetLock()
    CSAPI.SetImgColorByCode(dec, isOpen and "ffffff" or "737373", true)
end

function SetStar()
    CSAPI.SetGOActive(starObj, not isPlot and not IsDanger() and not IsSpecial())
    if not isPlot and not IsDanger() and not IsSpecial() then
        local starNum = 0
        if dungeonData then
            starNum = dungeonData:GetStar()
        end
        local iconName = ""
        for i = 1, 3 do
            iconName = i <= starNum and "img_12_01" or "img_12_02"
            CSAPI.LoadImg(this["star" .. i].gameObject, "UIs/DungeonActivity17/" .. iconName .. ".png", true, nil, true)
        end
    end
end

function SetNew()
    CSAPI.SetGOActive(newImg, dungeonData and dungeonData:IsOpen() and not dungeonData:IsPass())
end

function SetLine(b)
    CSAPI.SetGOActive(lineObj, b)
    CSAPI.SetGOActive(lineLock, b)
end

function GetCfg()
    return cfgDungeon
end

function GetType()
    if cfgDungeon and cfgDungeon.sub_type and cfgDungeon.sub_type == 1 then
        return DungeonInfoType.DesertPlot
    elseif IsDanger() then
        return DungeonInfoType.DesertDanger
    elseif IsSpecial() then
        return DungeonInfoType.DesertSpecial
    end
    return DungeonInfoType.Desert
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
    return data and data:GetTargetJson()
end

-----------------------------------------------anim-----------------------------------------------
function InitAnim()
    anim = ComUtil.GetCom(gameObject, "Animator")
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
        PlayAnim("In")
    end,this,time)
end

function ShowQuitAnim()
    PlayAnim("Out")
end

function ShowSelAnim(b)
    CSAPI.SetGOActive(selImg, b)
    if not IsNil(anim) then
        anim:Play(b and "Selected" or "DeSelect")
    end
end

function ShowUnLockAnim()
    
end
