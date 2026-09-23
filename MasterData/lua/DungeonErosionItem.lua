local data = nil
local currLevel = 1
local isOpen = false
local lockStr = ""
local ids = nil
local cfgDungeon = nil
local dungeonData = nil
local isPlot = false
local isPass = false
local isSel = false

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
    isSel = b
    CSAPI.SetGOActive(selImg, b)
    SetColor()
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
    end
end

function SetTitle()
    CSAPI.SetText(txtTitle, data:GetName())
    CSAPI.SetText(txtIndex, index .. "")
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
    CSAPI.SetGOActive(nolImg, isOpen)
    CSAPI.SetGOActive(easySel,currLevel == 1)
    CSAPI.SetGOActive(hardSel,currLevel == 2)
    CSAPI.SetGOActive(extraSel,currLevel == 3)
    CSAPI.SetGOActive(dangerImg, IsDanger() or IsSpecial())
end

function SetLock()
    CSAPI.SetGOActive(lockImg, not isOpen)
end

function SetStar()
    CSAPI.SetGOActive(starObj, not isPlot and not IsDanger() and not IsSpecial())
end

function SetNew()
    CSAPI.SetGOActive(newImg, DungeonMgr:IsDungeonOpen(cfgDungeon.id) and not dungeonData and not IsSpecial())
    -- CSAPI.SetGOActive(newImg, dungeonData and dungeonData:IsOpen() and not dungeonData:IsPass())
end

function SetColor()
    local code1,code2,code3,code4,code5 = "8d9693","8d9693","262b2d","8d9693","262b2d"
    if isSel then
        if currLevel == 1 then
            code1,code2,code3,code4 = "2e6e3c","0c3d17","244c2d","66fd85"
            code5 = isPass and "66fd85" or "244c2d"
        elseif currLevel == 2 then
            code1,code2,code3,code4 = "6e4f2e","3d240c","4d3b25","ffac40"
            code5 = isPass and "4d3b25" or "ffac40"
        elseif currLevel == 3 then
            code1,code2,code3,code4 = "6e2e2e","3d0c0c","4c2424","fd6666"
            code5 = isPass and "4c2424" or "fd6666"
        end
    end
    CSAPI.SetTextColorByCode(txtTitle,code2)
    CSAPI.SetTextColorByCode(txtIndex,code1)
    if isPlot then
        CSAPI.SetImgColorByCode(plotImg,code5)
    elseif not IsDanger() and not IsSpecial() then
        local starNum = 0
        if dungeonData then
            starNum = dungeonData:GetStar()
        end
        for i = 1, 3 do
            CSAPI.SetImgColorByCode(this["star" .. i].gameObject, isPass and code4 or code3)
        end
    else
        CSAPI.SetImgColorByCode(dangerImg,code5)
    end
end

function GetCfg()
    return cfgDungeon
end

function GetType()
    if cfgDungeon and cfgDungeon.sub_type and cfgDungeon.sub_type == 1 then
        return DungeonInfoType.ErosionPlot
    elseif IsDanger() then
        return DungeonInfoType.ErosionDanger
    elseif IsSpecial() then
        return DungeonInfoType.ErosionSpecial
    end
    return DungeonInfoType.Erosion
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

function GetMapId()
    return data and data:GetTargetContent("mapId")
end

function GetMoveTime()
    return data and data:GetTargetContent("time")
end
-----------------------------------------------anim-----------------------------------------------
local selAnim = nil

function InitAnim()
    selAnim= ComUtil.GetCom(selImg, "Animator")
end

function ShowEffect(go)
    CSAPI.SetGOActive(go, false)
    CSAPI.SetGOActive(go, true)
end

function PlayAnim(str)

end

function ShowEnterAnim(time)

end

function ShowQuitAnim()
    
end

function ShowSelAnim(b)
    isSel = b
    CSAPI.SetGOActive(selImg, b)
    if not IsNil(selAnim) then
        selAnim:Play(b and "Anim_ItemSelected" or "Anim_ItemSelect_out")
    end
    PlayAnim(b and "Anim_ItemButtonSelected" or "Anim_ItemButtonSelected_out")
    SetColor()
end

function ShowUnLockAnim()

end
