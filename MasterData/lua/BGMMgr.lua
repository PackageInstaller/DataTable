local this = MgrRegister("BGMMgr")

function this:Init()
    self:Clear()
    PlayerProto:GetAllMusic()
end

function this:Clear()
    self.viewID = nil
    self.fightID = nil
    self.bgmLockKey = nil  
    self.curCueName = nil
    self.datas = {}
end

function this:GetAllMusicRet(proto)
    for k, v in pairs(proto.data) do
        self.datas[v] = v
    end
end
-- type  1：界面 2：战斗
function this:GetIDByInitialType(type)
    local cfgs = Cfgs.CfgMusic:GetAll()
    for k, v in pairs(cfgs) do
        if (v.InitialType == type) then
            return v.id
        end
    end
    return nil
end

-- 主城音乐cfg  音乐表
function this:GetMajorCityMusicCfg()
    local id = self:GetViewMusicID() or 1
    return Cfgs.CfgMusic:GetByID(id)
end

-- 当前界面音乐id
function this:GetViewMusicID()
    if (not self.viewID) then
        local key = PlayerClient:GetUid() .. "_viewmusicid"
        local _id = PlayerPrefs.GetInt(key)
        if (_id == 0) then
            _id = self:GetIDByInitialType(1) or 1
            self:SetViewMusicID(_id)
        end
        self.viewID = _id
    end
    return self.viewID
end
function this:SetViewMusicID(id)
    self.viewID = id
    local key = PlayerClient:GetUid() .. "_viewmusicid"
    PlayerPrefs.SetInt(key, id)
    EventMgr.Dispatch(EventType.BGM_Set)
end

-- 当前战斗（训练）音乐id
function this:GetFightMusicID()
    if (not self.fightID) then
        local key = PlayerClient:GetUid() .. "_fightmusicid"
        local _id = PlayerPrefs.GetInt(key)
        if (_id == 0) then
            _id = self:GetIDByInitialType(2) or 2
            self:SetFightMusicID(_id)
        end
        self.fightID = _id
    end
    return self.fightID
end
function this:SetFightMusicID(id)
    self.fightID = id
    local key = PlayerClient:GetUid() .. "_fightmusicid"
    PlayerPrefs.SetInt(key, id)
end

-- 根据专辑获取所有音乐(需要拥有道具的则要判断)
function this:GetMusics(group)
    local arr = {}
    local _arr = Cfgs.CfgMusic:GetGroup(group)
    for k, v in pairs(_arr) do
        if(v.display==nil or BagMgr:GetCount(v.item_id)>0)then 
            table.insert(arr, v)
        end 
    end
    if (#arr > 1) then
        table.sort(arr, function(a, b)
            return a.id < b.id
        end)
    end
    return arr
end

------------------------------------------------------bgm播放---------------------------------------------------------

function this:SetBGMLock(key)
    self.bgmLockKey = key
end
function this:GetBGMLock()
    return self.bgmLockKey
end
function this:GetCueName()
    return self.curCueName
end

function this:PlayBGM(cueSheet, cueName, fadeDelay, volumeCoeff, lockKey, isLoop, startTime,completeCallBack)
    if (self.bgmLockKey and self.bgmLockKey ~= lockKey) then
        return
    end
    if (self.curCueName and self.curCueName == cueName) then
        return
    end
    self.curCueName = cueName
    volumeCoeff = volumeCoeff or 100
    local cueSheet = "bgms/" .. cueSheet .. ".acb"
    isLoop = isLoop or false
    return CSAPI.PlaySound(cueSheet, cueName, isLoop, false, "bgm", 0.5, nil, fadeDelay, volumeCoeff, startTime,completeCallBack)
end

function this:StopBGM(fadeSpeed)
    self.curCueName = nil
    local isLoop = false
    CSAPI.PlaySound("", "", isLoop, false, "bgm", fadeSpeed or 0.5)
end

function this:RemoveCueSheet(id)
    local cfg = Cfgs.CfgMusic:GetByID(id)
    local cueSheet = "bgms/" .. cfg.cue_sheet .. ".acb"
    CSAPI.RemoveCueSheet(cueSheet)
end
-- 试听
function this:PlayBGM2_CB(_id, startTime, completeCallBack)
    local id = _id or self:GetViewMusicID()
    local cfg = Cfgs.CfgMusic:GetByID(id)
    startTime = startTime or 0
    return self:PlayBGM(cfg.cue_sheet, cfg.cue_name, 0, nil, nil, true, startTime,completeCallBack)
end
-- 试听
function this:PlayBGM2(_id, startTime)
    local id = _id or self:GetViewMusicID()
    local cfg = Cfgs.CfgMusic:GetByID(id)
    startTime = startTime or 0
    return self:PlayBGM(cfg.cue_sheet, cfg.cue_name, 0, nil, nil, true, startTime)
end
-- 中途设置前先暂停
function this:StopBGM2()
    self.curCueName = nil
    CSAPI.PlaySound("", "", false, false, "bgm", 0)
end

-- 播放或者恢复bgm
function this:ReplayBGM()
    local id = self:GetViewMusicID()
    local cfg = Cfgs.CfgMusic:GetByID(id)
    CSAPI.bgmLast = nil
    EventMgr.Dispatch(EventType.Play_BGM_New, {
        bgm = cfg.cue_name_2,
        fadeTime = 0
    })
end

---------------------------------------------------------------------------------------------------------------

return this
