BuryingPointMgr = {}
local this = BuryingPointMgr
local SDKType = {
    TA = 1, -- 数数
    Shiryu = 2, -- 紫龙
    Domestic = 3 -- 国内
}
---当前打点类型
local curType = nil;
if CSAPI.IsADV() then
    curType = SDKType.Shiryu
elseif CSAPI.IsDomestic() then
    curType = SDKType.Domestic
else
    curType = SDKType.TA
end
-- 打点用
function this:BuryingPoint(_eventName, _stepID)
    local uid = PlayerClient:GetUid() or 0
    local infos = FileUtil.LoadByPath("BuryingPoint.txt", true) or {}
    if not infos[_eventName .. "_" .. _stepID] then
        local datas = {}
        if _eventName ~= "before_login" then
            datas = self:GetDefautDatas()
        end
        datas.step_id = _stepID
        if curType == SDKType.TA or curType == SDKType.Domestic then
            self:TrackEvents(_eventName, datas, nil, nil, _eventName == "before_login")
        elseif curType == SDKType.Shiryu then
            ---  LogError("输出ID："..tostring(_stepID))
        end
        self:SDKTrack(_eventName, _stepID)
        -- Log("打点上报，事件名：" .._eventName .. ",步骤id：" .. _stepID)
        infos[_eventName .. "_" .. _stepID] = 1
        FileUtil.SaveToFile("BuryingPoint.txt", infos, true)
    end
end

function this:GetDefautDatas()
    local datas = {}
    datas.account_id = PlayerClient:GetAccount()
    datas.time = TimeUtil:GetTimeStr2(TimeUtil:GetTime(), true)
    -- datas.ip = LoginProto.ip or ""
    -- datas.zone_offset = g_TimeZone or 8
    datas.app_id = 0
    -- datas.device_id = ThinkingAnalyticsMgr:GetpresetProperty("device_id")
    -- datas.device_model = ThinkingAnalyticsMgr:GetpresetProperty("device_model")
    datas.open_id = self.openID or 0
    datas.user_id = PlayerClient:GetUid()
    local info = GetCurrentServer()
    datas.zone_id = info and info.id or 0
    return datas
end

-- 其他上报
function this:SDKTrack(_eventName, _stepID)
    if _stepID == nil or _stepID == 0 then
        return
    end
    local cfg = Cfgs.UpdateData:GetByID(tonumber(_stepID))
    if cfg and cfg.HC_event and cfg.HC_argument and cfg.TE_event == _eventName then
        local data = {}
        data[cfg.HC_argument] = _stepID
        if CSAPI.GetADID() > 0 and ReYunSDK and ReYunSDK.SetCustomEvent then
            ReYunSDK:SetCustomEvent(cfg.HC_event, data);
        end
    end
end

function this:SetOpenID(_id)
    self.openID = _id
end

-- 上报事件
function this:TrackEvents(_eventName, _datas, _type, _eventId, isNoRefresh)
    if curType == SDKType.TA then
        ThinkingAnalyticsMgr:TrackEvents(_eventName, _datas, _type, _eventId, isNoRefresh)
    elseif curType == SDKType.Shiryu then
        ShiryuSDK.TrackEvent(_eventName, nil, _datas)
    elseif curType == SDKType.Domestic then
        -- ThinkingAnalyticsMgr:TrackEvents(_eventName, _datas, _type, _eventId,isNoRefresh)
        -- ShiryuSDK.TrackEvent(_eventName, nil, _datas)
        -- 区别与紫龙，中台国内的打点需要兼容数数，数数的打点需要正常发送，同时也需要将数数的打点加上adid等信息
        -- 同步发给中台  
        if _datas then
            ThinkingAnalyticsMgr:TrackEvents(_eventName, _datas, _type, _eventId, isNoRefresh)
        end

        local ZTPreStr = "mj_"
        if _datas or string.sub(_eventName, 1, string.len(ZTPreStr)) == ZTPreStr then
            local cache = nil
            if _datas then
                cache = self:DeepCopy(_datas)
                cache = self:GetDomesticPointData(cache)
            end
            ShiryuSDK.TrackEvent(_eventName, nil, cache)
            -- LogError("上报事件 " .. _eventName)
        end
    end
end

function this:DeepCopy(obj)
    local InTable = {};
    local function Func(obj)
        if type(obj) ~= "table" then -- 判断表中是否有表
            return obj;
        end
        local NewTable = {}; -- 定义一个新表
        InTable[obj] = NewTable; -- 若表中有表，则先把表给InTable，再用NewTable去接收内嵌的表
        for k, v in pairs(obj) do -- 把旧表的key和Value赋给新表
            NewTable[Func(k)] = Func(v);
        end
        return setmetatable(NewTable, getmetatable(obj)) -- 赋值元表
    end
    return Func(obj) -- 若表中有表，则把内嵌的表也复制了
end

function this:GetDomesticPointData(_datas)
    if PlayerClient then
        _datas.level = tostring(PlayerClient:GetLv())
        _datas.exp = tostring(PlayerClient:GetExp())
        _datas.uid = tostring(PlayerClient:GetID())
        _datas.role_id = tostring(PlayerClient:GetUid())
        _datas.role_name = tostring(PlayerClient:GetName())
        _datas.gold = tostring(PlayerClient:GetGold())
        _datas.diamond = tostring(PlayerClient:GetDiamond())
        _datas.max_battle_id = tostring(DungeonMgr:GetMaxDungeonID())
        _datas.channel = tostring(CSAPI.GetChannelType())
        _datas.ADID = tostring(CSAPI.GetADID())
    end
    return _datas;
end

-- 按天上传，当天已上报过则忽略 _compareStr:对比内容，如果内容相同则忽略
function this:TrackEventsByDay(_eventName, _datas, _compareStr)
    if not _eventName or _eventName == "" then
        return
    end
    local recordInfo = FileUtil.LoadByPath("BuryingPointRecord.txt") or {}

    if recordInfo[_eventName] and type(recordInfo[_eventName]) == "table" and
        not TimeUtil:CheckRefreshByDay(recordInfo[_eventName].time) then
        if _compareStr and recordInfo[_eventName].str ~= nil then
            if _compareStr == recordInfo[_eventName].str then
                return
            end
        else
            return
        end
    end
    recordInfo[_eventName] = recordInfo[_eventName] or {}
    recordInfo[_eventName].time = TimeUtil:GetTime()
    recordInfo[_eventName].str = _compareStr
    FileUtil.SaveToFile("BuryingPointRecord.txt", recordInfo)
    self:TrackEvents("mj_" .. _eventName, _datas)
end

return this
