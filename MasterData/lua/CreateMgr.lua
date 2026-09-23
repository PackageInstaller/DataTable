-- 卡牌建造
require "CreateData"
local this = MgrRegister("CreateMgr")

function this:Init()
    self:Clear()
    self:InitCfg()

    self:CardFactoryInfo()
    self:FirstCardCreateLogs()

    -- 关卡更新
    EventMgr.AddListener(EventType.Dungeon_PlotPlay_Over, this.LevelUpdate)
    EventMgr.AddListener(EventType.Dungeon_Data_Setted, this.LevelUpdate)
    EventMgr.AddListener(EventType.Update_Dungeon_Data, this.LevelUpdate)
end

function this:Clear()
    self.datas = {}
    self.daily_use_cnt = 0
    self.create_cnts = {} -- 抽卡次数记录

    EventMgr.RemoveListener(EventType.Dungeon_PlotPlay_Over, this.LevelUpdate)
    EventMgr.RemoveListener(EventType.Dungeon_Data_Setted, this.LevelUpdate)
    EventMgr.RemoveListener(EventType.Update_Dungeon_Data, this.LevelUpdate)
end

-- 特装构建是否已解锁
function this.LevelUpdate()
    local curData = CreateMgr:GetData(1003)
    if (curData and not curData:CheckIsRemove()) then
        local cfg = curData:GetCfg()
        local _isOpen, lockStr = MenuMgr:CheckConditionIsOK(cfg.conditions or {})
        local num = _isOpen and 1 or nil
        RedPointMgr:UpdateData(RedPointType.Create, num)
    else
        RedPointMgr:UpdateData(RedPointType.Create, nil)
    end
end

-- 初始化表数据
function this:InitCfg()
    local _list = Cfgs.CfgCardPool:GetAll()
    for i, v in pairs(_list) do
        -- if(v.nType == 3 or(v.nType == 1 and(v.sEnd == nil or TimeUtil:GetTime() < GCalHelp:GetTimeStampBySplit(v.sEnd)))) then
        -- 直接获取卡池，卡池在有效时间内
        local _data = CreateData.New()
        _data:SetData(v)
        self.datas[v.id] = _data
        -- end
    end
end

-- 首抽是否已完成
function this:CheckFirstNeed(_poolId)
    local data = self.datas[_poolId]
    return data and data:NeedFirst10() or false
end

function this:GetData(_poolId)
    return self.datas[_poolId]
end

--是否显示卡池
function this:CheckPoolActive(_poolId)
    local v = self:GetData(_poolId)
    if (v:CheckIsRemove()) then
        return false
    end
    if (_poolId ~= 1003 and not v:CheckConditions()) then
        return false
    end
    if (v:CheckIsStart() and not v:CheckIsEnd()) then
        return true
    end
    return false
end

-- 获取直接构建的卡池 (已移除的不加入)
function this:GetArr()
    local arr = {}
    for i, v in pairs(self.datas) do
        if (self:CheckPoolActive(v:GetId())) then
            table.insert(arr, v)
        end
    end
    if (#arr > 1) then
        table.sort(arr, function(a, b)
            return a:GetCfg().nSort < b:GetCfg().nSort
        end)
    end
    return arr
end

-- 刷新时间点
function this:GetRefreshTime()
    local minStartTime, minEndTime = nil, nil
    local arr = self.datas or {} -- self:GetArr()
    if (arr) then
        local curTime = TimeUtil:GetTime()
        for i, v in pairs(arr) do
            local _endTime = v:GetEndTime()
            if (_endTime and curTime < _endTime) then
                if (minEndTime == nil or minEndTime > _endTime) then
                    minEndTime = _endTime
                end
            end
            -- 
            local _startTime = v:GetStartTime()
            if (_startTime and curTime < _startTime) then
                if (minStartTime == nil or minStartTime > _startTime) then
                    minStartTime = _startTime
                end
            end
        end
    end
    return minStartTime, minEndTime
end

-- 卡牌构建
function this:CardCreate(_card_pool_id, _cnt)
    if (self.createTime == nil or Time.time > (self.createTime + 2)) then
        self.createTime = Time.time
        if (_cnt == 10 and self:CheckFirstNeed(_card_pool_id)) then
            self:FirstCardCreate(_card_pool_id)
        else
            self:CreateNormal(_card_pool_id, _cnt)
        end
    end
end

-- 个人某卡池构建次数
function this:GetCreateCnt(id)
    local num = self.create_cnts[id] and self.create_cnts[id].num or 0
    return num
end

-- 全服某卡池构建次数
function this:GetTotalCreateCnt(id)
    local num = self.sum_pool_cnts[id] and self.sum_pool_cnts[id].num or 0
    return num
end

-- 卡牌厂区信息
function this:CardFactoryInfo(cb)
    self.CardFactoryInfoCB = cb
    local proto = {"PlayerProto:CardFactoryInfo", {}}
    NetMgr.net:Send(proto)
end
function this:CardFactoryInfoRet(proto)
    -- 当日抽卡次数
    self.daily_use_cnt = proto.daily_use_cnt

    self.sum_pool_cnts = self.sum_pool_cnts or {}
    if (proto.sum_pool_cnts) then
        for i, v in ipairs(proto.sum_pool_cnts) do
            self.sum_pool_cnts[v.id] = v
        end
    end
    self.create_cnts = self.create_cnts or {}
    if (proto.create_cnts) then
        for i, v in pairs(proto.create_cnts) do
            self.create_cnts[i] = v
        end
    end

    local infos = proto.firt_create_infos
    if (infos) then
        for i, v in pairs(infos) do
            if (self.datas[v.card_pool_id]) then
                self.datas[v.card_pool_id]:InitFirstInfo(v)
            end
        end
    end

    -- 保底
    local sel_infos = proto.sel_infos or {}
    for i, v in pairs(self.datas) do
        local per = sel_infos[v:GetId()]
        local perID = per and per.num or nil
        local newCardPoolID = GCalHelp:GetCardPoolSelectId(v:GetCfg())
        local _data = table.copy(sel_infos[newCardPoolID])
        v:InitBD(_data, perID)
    end

    -- --移除已达成抽卡次数的卡池
    -- for i, v in pairs(self.create_cnts) do
    -- 	self:RemoveData(i)
    -- end

    -- 动态开启的卡池
    self.dy_open_pool = proto.dy_open_pool -- 动态开启的卡池
    if (self.dy_open_pool) then
        for k, v in pairs(self.dy_open_pool) do
            if (type(k) == "number" and self.datas[k] ~= nil) then
                self.datas[k]:InitDyOpenPool(v[1])
            end
        end
    end

    self.free_cnt = proto.free_cnt

    -- 自选构建卡池信息
    if (proto.choice_infos) then
        for k, v in pairs(proto.choice_infos) do
            if (self.datas[k]) then
                self.datas[k]:SetChoiceInfos(v)
            end
        end
    end
end

-- 获取首次抽卡logs
function this:FirstCardCreateLogs(_card_pool_id)
    local proto = {"PlayerProto:FirstCardCreateLogs", {
        card_pool_id = _card_pool_id
    }}
    NetMgr.net:Send(proto)
end
function this:FirstCardCreateLogsRet(proto)
    local logs = proto.logs
    if (logs) then
        for i, v in pairs(logs) do
            if (self.datas[v.card_pool_id]) then
                self.datas[v.card_pool_id]:InitLogInfo(v)
            end
        end
    end
    EventMgr.Dispatch(EventType.Role_Refresh_Logs, proto)
end

-- 正常抽
function this:CreateNormal(_card_pool_id, _cnt)
    local proto = {"PlayerProto:CardCreate", {
        card_pool_id = _card_pool_id,
        cnt = _cnt
    }}
    NetMgr.net:Send(proto)
end
-- 下发CardFactoryInfoRet
function this:CardCreateFinishRet(proto)
    EventMgr.Dispatch(EventType.Role_Create_Finish, proto)

    -- rui数数 构造（抽卡)
    if (proto.infos == nil or #proto.infos < 1) then
        return
    end
    local curData = self:GetData(proto.card_pool_id)
    local self_info = curData:GetBDData()
    local _datas = {}
    _datas.reason = proto.cnt == 1 and "单抽" or "十连抽"
    _datas.lottery_id = curData:GetCfg().sName
    _datas.lottery_hero = self_info and self_info.num or "无保底角色"
    _datas.add_num = self:GetCreateCnt(proto.card_pool_id)
    _datas.item_gain = proto.infos -- {}
    -- for i, v in ipairs(proto.infos) do
    --     for k, m in ipairs(v.items) do
    --         table.insert(_datas.item_gain, m)
    --     end
    -- end
    _datas.item_use = proto.costs
    if CSAPI.IsADV() == false then
        BuryingPointMgr:TrackEvents("draw_card", _datas)
    end
end

-- 首抽
function this:FirstCardCreate(_card_pool_id)
    local proto = {"PlayerProto:FirstCardCreate", {
        card_pool_id = _card_pool_id
    }}
    NetMgr.net:Send(proto)
end
function this:FirstCardCreateRet(proto)
    if (self.datas[proto.card_pool_id]) then
        self.datas[proto.card_pool_id]:RefreshInfo() -- 刷新信息
    end
    EventMgr.Dispatch(EventType.Role_FirstCreate_Finish, proto)

    -- rui数数 构造（抽卡)
    if (proto.hadGetLog == nil or #proto.hadGetLog < 1) then
        return
    end
    local curData = self:GetData(proto.card_pool_id)
    local self_info = curData:GetBDData()
    local _datas = {}
    _datas.reason = proto.cnt == 1 and "单抽" or "十连抽"
    _datas.lottery_id = curData:GetCfg().sName
    _datas.lottery_hero = self_info and self_info.num or "无保底英雄"
    _datas.add_num = proto.create_cnt
    _datas.item_gain = proto.hadGetLog -- {}
    -- for i, v in ipairs(proto.hadGetLog) do
    --     table.insert(_datas.item_gain, v)
    -- end
    _datas.item_use = proto.costs
    if CSAPI.IsADV() or CSAPI.IsDomestic() then
        BuryingPointMgr:TrackEvents("draw_card", _datas)
    end
end

-- 首次抽卡添加最后一次为log(返回PlayerProto:FirstCardCreateLogsRet)
function this:FirstCardCreateAddLog(_card_pool_id)
    local proto = {"PlayerProto:FirstCardCreateAddLog", {
        card_pool_id = _card_pool_id
    }}
    NetMgr.net:Send(proto)
end

-- 首次抽卡确认(确认后会删除抽卡记录)
function this:FirstCardCreateAffirm(_card_pool_id, _ix)
    local proto = {"PlayerProto:FirstCardCreateAffirm", {
        card_pool_id = _card_pool_id,
        ix = _ix
    }}
    NetMgr.net:Send(proto)
    -- 标记首次完成
    local data = self:GetData(_card_pool_id)
    data:IsOverFirst10()
end
function this:FirstCardCreateAffirmRet(proto)
    -- 卡池抽卡次数
    self.create_cnts = self.create_cnts or {}
    self.create_cnts[proto.card_pool_id] = self.create_cnts[proto.card_pool_id] or {}
    self.create_cnts[proto.card_pool_id].num = proto.create_cnt
    -- 当日抽卡次数
    self.daily_use_cnt = proto.daily_use_cnt

    -- 完成回调
    EventMgr.Dispatch(EventType.Role_FirstCreate_Finish)
    EventMgr.Dispatch(EventType.Role_FirstCreate_End)

    self.LevelUpdate()

    MenuBuyMgr:ConditionCheck(2, "create30Finish") -- MenuMgr:Crate30Finish() -- 30抽第一次打开记录 rui
end

-- 累计抽卡统计更新
function this:CardPoolOpen(cnts)
    for i, v in ipairs(cnts) do
        self.sum_pool_cnts[v.id] = v
    end
    EventMgr.Dispatch(EventType.CardCool_Cnts_Update)
end

-- --移除类型为1并且已达成抽卡次数的卡池
-- function this:RemoveData(id)
-- 	local data = self:GetData(id)
-- 	if(data and data:GetCfg().nType == 1 and data:GetCfg().nUseCntLimt ~= nil) then
-- 		local num = self:GetCreateCnt(data:GetCfg().id)
-- 		if(num >= data:GetCfg().nUseCntLimt) then
-- 			self.datas[id] = nil
-- 		end
-- 	end
-- end
function this:SetCardPoolSelCardRet(proto)
    if (self.datas[proto.card_pool_id]) then
        self.datas[proto.card_pool_id]:SetBDCid(proto.cid)
    end
    EventMgr.Dispatch(EventType.Role_Create_SetCard)
end

-- 可兑换的数量
function this:GetExchangeCount(cfgID)
    local cfg = Cfgs.CfgItemExchange:GetByID(cfgID)
    local cost = cfg.costs[1]
    local curNum = BagMgr:GetCount(cost[1])
    return math.floor(curNum / cost[2]) -- 可兑换数量
end

-- 是否在免费抽空时间段内
function this:IsFreeInTime()
    local cfg = Cfgs.CfgActiveList:GetByID(1021) -- 固定1021
    if (cfg) then
        local curTime = TimeUtil:GetTime()
        local sTime = TimeUtil:GetTimeStampBySplit(cfg.sTime)
        if (sTime and curTime < sTime) then
            return false, sTime
        end
        local eTime = TimeUtil:GetTimeStampBySplit(cfg.eTime)
        if (eTime and curTime >= eTime) then
            return false
        end
        return true, eTime
    end
    return false
end

-- 要 IsFreeInTime 为true才能用
function this:FreeRemainDay()
    local cfg = Cfgs.CfgActiveList:GetByID(1021) -- 固定1021
    if (cfg and cfg.eTime) then
        local eTime = TimeUtil:GetTimeStampBySplit(cfg.eTime)
        local time = eTime - TimeUtil:GetTime()
        return math.ceil(time / 86400)
    end
    return 1
end

-- 免费抽总次数
function this:GetFreeCnt()
    return self.free_cnt or 0
end
-- 服务器3点更新
function this:SetFreeCnt(free_cnt)
    self.free_cnt = free_cnt
end
function this:SetDailyUseCnt(daily_use_cnt)
    self.daily_use_cnt = daily_use_cnt
end

-- 设置自选构建卡池返回
function this:SetSelfChoiceCardPoolCardRet(proto)
    if (self.datas[proto.id]) then
        self.datas[proto.id]:SetChoiceInfos(proto)
    end
    EventMgr.Dispatch(EventType.Choice_Card_Ret)
end

-- 是不是首选卡
function this:CheckISSelectCard(poolID, cardID)
    local data = self:GetData(poolID)
    if (data) then
        return data:IsFirstSelectCard(cardID)
    end
    return false
end

return this
