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
    if not IsNil(anim) then
        if b then
            anim:Play("animSel_loop")
        else
            anim:Play("idle")
        end
    end
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
    CSAPI.SetTextColorByCode(txtTitle,code)
    local indexStr = index < 10 and "0" .. index or index
    CSAPI.SetText(txtStage, LanguageMgr:GetByID(15124) .. " " .. indexStr)
end

function SetPlot()
    CSAPI.SetGOActive(plotImg, isPlot)
end

function SetPass()
    CSAPI.SetGOActive(passImg, isPass)
    CSAPI.SetGOActive(nolImg,not isPass)
    CSAPI.LoadImg(nolImg,"UIs/DungeonActivity16/icon1_" .. (currLevel == 1 and "2" or "3") .. ".png",true,nil,true)
end

function SetDungeon()
    local iconName= currLevel == 1 and "easy_01" or "hard_01"
    iconName = currLevel == 3 and "extra_01" or iconName
    CSAPI.LoadImg(icon,"UIs/DungeonActivity16/" .. iconName .. ".png",true,nil,true)
end

function SetLock()
    if currLevel < 3 then
        CSAPI.LoadImg(lockImg, "UIs/DungeonActivity16/img_09_0" .. (isPlot and 2 or 1) .. ".png", true, nil, true)
    end
    CSAPI.SetGOActive(lockObj, not isOpen)
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
            iconName = i <= starNum and "star_01" or "star_02"
            CSAPI.LoadImg(this["star" .. i].gameObject, "UIs/DungeonActivity16/" .. iconName .. ".png", true, nil, true)
        end
    end
end

function SetNew()
    CSAPI.SetGOActive(newImg, dungeonData and dungeonData:IsOpen() and not dungeonData:IsPass())
end

function SetLine(b)
    CSAPI.SetGOActive(lineObj,b)
    CSAPI.SetGOActive(lineLock,b)
end

function GetCfg()
    return cfgDungeon
end

function GetType()
    if cfgDungeon and cfgDungeon.sub_type and cfgDungeon.sub_type == 1 then
        return DungeonInfoType.ChristmasPlot
    elseif IsDanger() then
        return DungeonInfoType.ChristmasDanger
    elseif IsSpecial() then
        return DungeonInfoType.ChristmasSpecial
    end
    return DungeonInfoType.Christmas
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

function ShowEnterAnim()
    if not isOpen then
        UIUtil:SetObjFade(lockObj,0,1,nil,200,1100)
    end
    PlayAnim("Entry")
end

function ShowQuitAnim()
    PlayAnim("Quit")
end

function ShowSelAnim(b)
    if not IsNil(anim) then
        anim:Play(b and "animSel" or "animNsel")
    end
end

function ShowUnLockAnim()
    CSAPI.SetGOActive(lockObj, true)
    UIUtil:SetObjFade(lockObj, 1, 0, function()
        CSAPI.SetGOActive(lockObj, false)
    end, 200)
end
