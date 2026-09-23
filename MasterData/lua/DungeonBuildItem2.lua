local cfg = nil
local isBuild = false
local isPlot = false
local isSpecial = false
local isOpen = false
local lockStr = ""
local dungeonData = nil
local isPass = false
local currLevel = 1

function Awake()
    InitAnim()
end

function SetIndex(idx)
    index = idx
end

function SetSelect(b)
    CSAPI.SetGOAlpha(alphaObj,(isOpen and b) and 1 or 0.3)
end

function SetClickCB(_cb)
    cb = _cb
end

-- cfg:MainLine
function Refresh(_data, _level)
    cfg = _data
    currLevel = _level or 1
    if cfg then
        dungeonData = DungeonMgr:GetDungeonData(cfg.id)
        isOpen, lockStr = DungeonMgr:IsDungeonOpen(cfg.id)
        isPlot = cfg.sub_type ~= nil
        isPass = dungeonData and dungeonData:IsPass()
        isBuild = cfg.type == eDuplicateType.Building
        isSpecial = cfg.diff and cfg.diff >= 3
        SetDungeon()
        SetPlot()
        SetBuild()
        SetStar()
        SetTitle()
        SetPass()
        SetLock()
        SetHard()
    end
end

function SetDungeon()
    CSAPI.SetGOActive(dungeonBG, not isPlot and not isBuild)
end

function SetPlot()
    CSAPI.SetGOActive(plotBg, isPlot)
    CSAPI.SetGOActive(plotImg, isPlot)
end

function SetBuild()
    CSAPI.SetGOActive(bulidBg, isBuild)
    CSAPI.SetGOActive(bulidImg, isBuild)
end

function SetStar()
    CSAPI.SetGOActive(starObj, not isPlot and not isBuild and not isSpecial)
    if not isPlot and not isBuild and not isSpecial then
        local star = dungeonData and dungeonData:GetStar() or 0
        local code = ""
        for i = 1, 3 do
            code = i > star and "3c3531" or "b24133"
            CSAPI.SetImgColorByCode(this["star" .. i].gameObject, code)
        end
    end
end

function SetTitle()
    CSAPI.SetText(txtTitle, cfg.name or "")
    CSAPI.SetTextColorByCode(txtTitle, isBuild and "ffe3ae" or "3C3531")
end

function SetPass()
    CSAPI.SetGOActive(passImg, isPass)
end

function SetLock()
    CSAPI.SetGOActive(lockObj, not isOpen)
end

function SetFade(b)
    if isOpen then
        UIUtil:SetObjFade(alphaObj, b and 0.3 or 1, b and 1 or 0.3, nil, 200)
    end
end

function SetHard()
    CSAPI.SetGOActive(hardImg, currLevel == 2)
end

function GetType()
    if isPlot then
        return DungeonInfoType.BuildPlot
    elseif IsDanger() then
            return DungeonInfoType.Build
    elseif isSpecial then
        return DungeonInfoType.BuildSpecial
    end
    return DungeonInfoType.Build
end

function GetCfg()
    return cfg
end

function GetBuildCfg(index)
    if cfg and cfg.UnlockBuildingID then
        return Cfgs.Building:GetByID(cfg.UnlockBuildingID[index])
    end
end

function IsPlot()
    return cfg and cfg.sub_type
end

function IsDanger()
    return cfg and cfg.diff and cfg.diff == 3
end

function IsSpecial()
    return cfg and cfg.diff and cfg.diff == 4
end

function IsBuild()
    return cfg and cfg.type == eDuplicateType.Building
end

function IsOpen()
    return isOpen
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

------------------------------anim------------------------------
local anim, unLockAnim = nil, nil
function InitAnim()
    anim = ComUtil.GetCom(node, "Animator")
    unLockAnim = ComUtil.GetCom(lockImg, "Animator")
end

function PlayAnim(str)
    if not IsNil(anim) then
        anim:Play(str)
    end
end

function ShowEnterAnim()
    PlayAnim(isOpen and "sel" or "Nsel")
    UIUtil:SetObjFade(lockObj, 0, 1, nil, 300,300)
end

function ShowUnLockAnim()
    CSAPI.SetGOActive(lockObj, true)
    if not IsNil(unLockAnim) then
        unLockAnim:Play("unlock")
    end
    FuncUtil:Call(function()
        CSAPI.SetGOActive(lockObj, false)
    end, this, 800)
end
