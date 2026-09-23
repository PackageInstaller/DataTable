local data = nil
local currLevel = 1
local isOpen = false
local lockStr = ""
local ids = nil
local cfgDungeon = nil
local dungeonData = nil
local isPlot = false
local isPass = false

function Awake()
    InitAnim()
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
    end
end

function SetTitle()
    CSAPI.SetText(txtTitle1, data:GetName())
    CSAPI.SetText(txtTitle2, data:GetName())
    CSAPI.SetGOAlpha(titleObj, isOpen and 1 or 0.5)

    local iconName = isOpen and "img_05_0" or "img_06_0"
    CSAPI.SetGOActive(index2, index > 9)
    if index > 9 then
        CSAPI.LoadImg(index1,"UIs/DungeonActivity20/" .. iconName .. math.floor(index / 10) .. ".png",true,nil,true)
        CSAPI.LoadImg(index2,"UIs/DungeonActivity20/" .. iconName .. index % 10 .. ".png",true,nil,true)
    else
        CSAPI.LoadImg(index1,"UIs/DungeonActivity20/" .. iconName .. index .. ".png",true,nil,true)
    end
end

function SetPlot()
    CSAPI.SetGOActive(plotImg, isPlot)
    if isPlot then
        local code = not isOpen and "232323" or "747474"
        code = isPass and "ffbb00" or code
        CSAPI.SetImgColorByCode(plotImg, code)
    end
end

function SetPass()
    CSAPI.SetGOActive(passImg, isPass)
end

function SetDungeon()
    CSAPI.SetGOActive(nol,currLevel == 1 and isOpen)
    CSAPI.SetGOActive(hard,currLevel == 2 and isOpen)
    CSAPI.SetGOActive(extra,currLevel == 3 and isOpen)
end

function SetLock()
    CSAPI.SetGOActive(lock, not isOpen)
    CSAPI.SetGOActive(lockImg, not isOpen)
end

function SetStar()
    CSAPI.SetGOActive(starObj, not isPlot and not IsDanger() and not IsSpecial())
    if not isPlot and not IsDanger() and not IsSpecial() then
        local starNum = 0
        if dungeonData then
            starNum = dungeonData:GetStar()
        end
        local code = "232323"
        for i = 1, 3 do
            if isOpen then
                code = i <= starNum and "ffbb00" or "747474"
            end
            CSAPI.SetImgColorByCode(this["star" .. i].gameObject, code)
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
        return DungeonInfoType.HolidayPlot
    elseif IsDanger() then
        return DungeonInfoType.HolidayDanger
    elseif IsSpecial() then
        return DungeonInfoType.HolidaySpecial
    end
    return DungeonInfoType.Holiday
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
local anims = {}
local anim = nil
local selAnim = nil

function InitAnim()
    selAnim= ComUtil.GetCom(selImg, "Animator")
    anim= ComUtil.GetCom(gameObject, "Animator")
    if bg.transform.childCount > 0 then
        for i = 0, bg.transform.childCount - 1 do
            table.insert(anims,ComUtil.GetCom(bg.transform:GetChild(i).gameObject, "Animator"))
        end
    end
end

function ShowEffect(go)
    CSAPI.SetGOActive(go, false)
    CSAPI.SetGOActive(go, true)
end

function PlayAnim(str)
    local index = currLevel
    if not isOpen then
        index = 4
    end
    if anims[index] and not IsNil(anims[index]) then
        anims[index]:Play(str)
    end
end

function ShowEnterAnim(time)
    CSAPI.SetGOAlpha(gameObject, 0)
    FuncUtil:Call(function()
        CSAPI.SetGOAlpha(gameObject, 1)
        PlayAnim("Anim_ItemButtonEntry")
        if not IsNil(anim) then
            anim:Play("Anim_ItemButtonInfo")
        end
    end, this, time)
end

function ShowQuitAnim()
    
end

function ShowSelAnim(b)
    CSAPI.SetGOActive(selImg, b)
    if not IsNil(selAnim) then
        selAnim:Play(b and "Anim_ItemSelected" or "Anim_ItemSelect_out")
    end
    PlayAnim(b and "Anim_ItemButtonSelected" or "Anim_ItemButtonSelected_out")
end

function ShowUnLockAnim()

end
