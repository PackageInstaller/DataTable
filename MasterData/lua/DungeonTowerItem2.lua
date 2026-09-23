local cfg = nil
local data = nil
local isLock = false
local cb = nil
local max = 0
local cur = 0
local isRed = false

function Awake()
    SetSelect(false)
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data)
    data = _data
    if data and data.cfg then
        cfg = data.cfg
        isLock = not data.isUnLock
        SetTitle()
        SetIcon()
        SetItemIcon()
        SetReward()
        SetPrograss()
        SetLock()
        SetRed()
    end
end

function SetTitle()
    CSAPI.SetText(txtTitle, cfg.name or "")
end

function SetIcon()
    if cfg.enemyPreview and #cfg.enemyPreview > 0 then
        local cfgMonstor = Cfgs.MonsterData:GetByID(cfg.enemyPreview[1])
        if cfgMonstor and cfgMonstor.model then
            local cfgModel = Cfgs.character:GetByID(cfgMonstor.model)
            if cfgModel and cfgModel.List_head then
                ResUtil.Card:Load(icon, cfgModel.List_head)
            end
        end
    end
end

function SetItemIcon()
    ResUtil.IconGoods:Load(itemIcon, ITEM_ID.BIND_DIAMOND .. "_1", true)
end

function SetReward()
    if cfg.fangjing then
        CSAPI.SetText(txtReward, cfg.fangjing .. "")
    end
end

function SetPrograss()
    local missionDatas = MissionMgr:GetActivityDatas(eTaskType.TmpDupTower, cfg.missionID)
    max = 0
    cur = 0
    isRed = false
    if missionDatas then
        max = #missionDatas
        for _, missData in ipairs(missionDatas) do
            if missData:IsGet() then
                cur = cur + 1
            elseif missData:IsFinish() then
                isRed = true
            end
        end
    end
    local _cur = StringUtil:SetByColor(cur, "FFC146")
    CSAPI.SetText(txtPrograss, _cur .. "/" .. max)
end

function SetLock()
    CSAPI.SetGOActive(lockObj, isLock)
    if isLock and cfg.preChapterID then
        local cfgDungeon = Cfgs.MainLine:GetByID(cfg.preChapterID[1])
        if cfgDungeon and cfgDungeon.chapterID then
            local str = ""
            if cfgDungeon.type == eDuplicateType.MainNormal or cfgDungeon.type == eDuplicateType.MainElite then
                str = LanguageMgr:GetByID(15009) .. LanguageMgr:GetByID(6001) .. ":"
            end
            str = str .. cfg.chapterID
            CSAPI.SetText(txtLock,str)
        end
    end
end

function SetRed()
    UIUtil:SetRedPoint(node,isRed,274,76)
end

function SetSelect(isSel)
    CSAPI.SetGOActive(selObj, isSel)
end

function GetCfg()
    return cfg
end

function GetPrograssCount()
    return cur, max
end

function GetRed()
    return isRed
end

function GetFangJing()
    return cfg.fangjing
end

function IsLock()
    return isLock
end

function OnClick()
    if cb then
        cb(this)
    end
end
