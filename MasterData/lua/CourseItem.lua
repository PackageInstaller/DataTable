local cfg = nil
local dungeonData = nil
local canvasGroup = nil
local isLock = false
local lockStr = ""

function Awake()
    canvasGroup = ComUtil.GetCom(node,"CanvasGroup")

    SetSelect(false)
end

function SetIndex(idx)
    index= idx
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data)
    cfg = _data
    if cfg then
        dungeonData = DungeonMgr:GetDungeonData(cfg.id)
        SetName()
        SetIcon()
        SetDesc()
        SetFinish()
        SetLock()
    end
end

function SetName()
    CSAPI.SetText(txtName, cfg.name or "")
end

function SetIcon()
    if cfg.modelId then
        local cfgModel = Cfgs.character:GetByID(cfg.modelId)
        if cfgModel and cfgModel.List_head then
            ResUtil.Card:Load(icon, cfgModel.List_head)
        end
    end
end

function SetDesc()
    CSAPI.SetText(txtDesc, cfg.desc or "")
end

function SetFinish()
    CSAPI.SetGOActive(txtFinish,dungeonData and dungeonData:IsPass())
end

function SetLock()
    isLock,lockStr = false,""
    if cfg.preChapterID then
        for i, v in ipairs(cfg.preChapterID) do
            local preCfg = Cfgs.MainLine:GetByID(v)
            if not cfg then
                LogError("不存在对应ID的配置表数据！" .. v)
                isLock = true
                break
            end
            local preDungeonData = DungeonMgr:GetDungeonData(preCfg.id)
            if not DungeonMgr:IsDungeonOpen(preCfg.id) or not preDungeonData or not preDungeonData:IsPass() then
                isLock = true
                if preCfg.type == eDuplicateType.MainNormal or preCfg.type == eDuplicateType.MainElite then
                    lockStr = LanguageMgr:GetByID(44006,StringUtil:SetByColor(preCfg.chapterID,"FFC146"))
                elseif preCfg.type == eDuplicateType.Teaching then
                    lockStr = LanguageMgr:GetByID(44005)
                end
                break
            end
        end
    end
    CSAPI.SetGOActive(lockObj,isLock)
    CSAPI.SetGOActive(desc,not isLock)
    CSAPI.SetText(txtLock, lockStr)
    canvasGroup.alpha = isLock and 0.3 or 1
end

function SetSelect(b)
    CSAPI.SetGOActive(select, b)
end

function GetIndex()
    return index
end

function GetCfg()
    return cfg
end

function GetID()
    return cfg and cfg.id
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