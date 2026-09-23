local cfg = nil
local textL = nil
local textR = nil
local lockState = false
local lockStr = nil
local isSelect = false
local index =0
local cb = nil
local isNew = false

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function Awake()
    textL = ComUtil.GetCom(txtTitleL,"Text")
    textR = ComUtil.GetCom(txtTitleR,"Text")
end

function Refresh(_cfg)
    cfg = _cfg
    if cfg then       
        lockState,lockStr =GetLockState()
        local strs = StringUtil:split(cfg.name,"-")
        CSAPI.SetGOActive(lockImg, lockState > 1)
        strs[1] = lockState == 1 and LanguageMgr:GetByID(15092,cfg.LockLevel) or strs[1]
        SetTitle(strs[1],strs[2])
        SetSelect(false)
        SetNew()
        CSAPI.SetGOActive(whiteImg,index % 2 ~= 0)
    end 
end

function SetTitle(lStr,rStr)
    textL.text = lStr
    textR.text = rStr
end

function SetSelect(_isSelect)
    isSelect = _isSelect
    CSAPI.SetGOActive(selectObj,_isSelect)
    SetColor()
end

function SetColor()
    local textSize = 34
    local color = {255,255,255,255}
    if isSelect then
        textSize = 40
        color={255,193,70,255}
    elseif lockState > 0 then
        color={255,255,255,77}
    end
    textL.fontSize = textSize
    textR.fontSize = textSize

    CSAPI.SetTextColor(textL.gameObject,color[1],color[2],color[3],color[4])
    CSAPI.SetTextColor(textR.gameObject,color[1],color[2],color[3],color[4])
end


function GetLockState()
    local _lockState = 0
    local tipsStr = ""
    if cfg.LockLevel and PlayerClient:GetLv() < cfg.LockLevel then
        _lockState = 1
        tipsStr = LanguageMgr:GetTips(8000, cfg.LockLevel)
    elseif cfg.preChapterID then
        for _, preCfgID in ipairs(cfg.preChapterID) do
            local preCfg = Cfgs.MainLine:GetByID(preCfgID)
            local dungeonData = DungeonMgr:GetDungeonData(preCfgID)
            if not dungeonData or not dungeonData:IsPass() then
                if preCfg.type == eDuplicateType.MainNormal or preCfg.type == eDuplicateType.MainElite then
                    local str = preCfg.chapterID .. " " .. preCfg.name
                    tipsStr = LanguageMgr:GetTips(1010, str)
                    _lockState = 2
                else
                    tipsStr = LanguageMgr:GetTips(24004)
                    _lockState = 3
                end
                break
            end
        end
    end
    return _lockState,tipsStr
end

function GetCfg()
    return cfg
end

function GetIndex()
    return index
end

function OnClick()
    if lockState > 0 then
        Tips.ShowTips(lockStr)
        return 
    end
    if cb then
        cb(this)
    end
    -- RefreshNew()
end

function SetNew()
    UIUtil:SetNewPoint(newParent, false)
    if lockState > 0 then
        return
    end
    RefreshNew()
    if DungeonMgr:GetIsNew(cfg.id) then
        DungeonMgr:SetIsNew(cfg.id)
    end
end

function RefreshNew()
    UIUtil:SetNewPoint(newParent, DungeonMgr:GetIsNew(cfg.id))
end
