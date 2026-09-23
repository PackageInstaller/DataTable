--[[	-- 类型
eTaskType = {}
eTaskType.None = 0
eTaskType.Main = 1 -- 主线
eTaskType.Sub = 2 -- 支线
eTaskType.Daily = 3 -- 日常
eTaskType.Weekly = 4 -- 每周
eTaskType.Activity = 5 -- 活动
]] local MissionInfo = require "MissionInfo"
local MissionChangeInfo = require "MissionChangeInfo"
local this = MgrRegister("MissionMgr")

function this:Init()
    self.datas = nil
    self.infos = {}
    self.dailyResetTime = nil
    self.weeklyResetTime = nil

    self.changeDatas = {} -- tips列表

    self:GetResetTaskInfo()
    self:GetTasksData()
    self:GetSevenTaskDay(eTaskType.Guide)
    self.newYearIndex = 7
    -- self:GetSevenTaskDay(eTaskType.Seven)
end

function this:Clear()
    self.datas = nil
    self.infos = nil
    self.changeDatas = {}
    if (self.tipsTimer) then
        self.tipsTimer.Remove()
    end
    self.tipsTimer = nil
    self.isOpen = nil
end

-- 设置选中的标签索引
function this:SetSelTabIndex(index1, index2)
    self.tabIndex1 = index1;
    self.tabIndex2 = index2;
end

-- 类型
-- eTaskType = {}
-- eTaskType.None = 0
-- eTaskType.Main = 1 -- 主线
-- eTaskType.Sub = 2 -- 支线
-- eTaskType.Daily = 3 -- 日常
-- eTaskType.Weekly = 4 -- 每周
-- eTaskType.Activity = 5 -- 活动
-- 获取选中的标签索引
function this:GetSelTabIndex()
    local index1 = self.tabIndex1 ~= nil and self.tabIndex1 or 1
    local index2 = self.tabIndex2 ~= nil and self.tabIndex2 or 1
    return index1, index2
end

--集合，已领取的是否显示
function this:GetArr(indexs,showGet)
    local arr = {}
    if (self.datas) then
        for i, v in pairs(self.datas) do
            for p, q in ipairs(indexs) do
                if (q == v:GetType()) then
                    if (showGet or not v:IsGet()) then 
                        if (not self.CheckIsReset(v) and v:CheckIsOpen()) then 
                            table.insert(arr, v)
                        end
                    end
                end
            end
        end
    end
    if (arr and #arr > 1) then
        table.sort(arr, function(a, b)
            if (a:GetSortIndex() == b:GetSortIndex()) then
                return a:GetCfgID() < b:GetCfgID()
            else
                return a:GetSortIndex() > b:GetSortIndex()
            end
        end)
    end
    return arr
end

function this:GetDatas(type)
    local datas = {}
    if (self.datas) then
        for i, v in pairs(self.datas) do
            if (type == v:GetType()) then
                table.insert(datas, v)
            end
        end
    end
    return datas
end

function this:GetData(id)
    if (id == nil) then
        Log("获取数据失败！！id无效");
        return nil
    end
    if (self.datas) then
        return self.datas[id]
    end
    return nil;
end

function this:GetData2(cfgId)
    if cfgId == nil then
        Log("获取数据失败！！cfgId无效");
        return nil
    end
    if (self.datas) then
        for k, v in pairs(self.datas) do
            if v:GetCfgID() == cfgId then
                return v
            end
        end
    end
    return nil
end

-- 获取该任务配置表
function this:GetCfg(type, cfgID)
    -- if (self.Cfgs == nil) then
    --     self.Cfgs = {}
    --     self.Cfgs[1] = CfgTaskMain
    --     self.Cfgs[2] = CfgTaskSub
    --     self.Cfgs[3] = CfgTaskDaily
    --     self.Cfgs[4] = CfgTaskWeekly
    --     self.Cfgs[5] = CfgTaskActivity
    --     self.Cfgs[6] = CfgDupTower
    --     self.Cfgs[7] = CfgTmpDupTower
    --     self.Cfgs[8] = CfgDupTaoFa
    --     self.Cfgs[9] = CfgDupStory
    --     self.Cfgs[10] = CfgDupFight
    --     self.Cfgs[11] = CfgSevenDayTask
    --     self.Cfgs[12] = CfgSevenDayFinish
    --     self.Cfgs[13] = CfgTaskDayExploration
    --     self.Cfgs[14] = CfgTaskWeekExploration
    --     self.Cfgs[15] = CfgTaskExploration
    --     self.Cfgs[16] = CfgGuideFinish
    --     self.Cfgs[17] = CfgGuideTask
    --     self.Cfgs[18] = CfgNewYearFinish
    --     self.Cfgs[19] = CfgNewYearTask
    --     self.Cfgs[20] = CfgRegressionFundTask
    --     self.Cfgs[22] = CfgRegressionTask
    -- end
    --local cfg = type <= #self.Cfgs and self.Cfgs[type] or nil
    local cfgName = cTaskCfgNames[type]  
    local cfg = cfgName and Cfgs[cfgName]:GetAll() or nil 
    if (cfg) then
        return cfg[cfgID]
    end
    return nil
end

-- 是否有活动
function this:CheckHadActivity()
    local datas = self:GetArr(eTaskType.Activity)
    return #datas > 0
end

-- 是否过期
function this:CheckIsReset(missionInfo)
    if (missionInfo) then
        if (missionInfo:GetType() == eTaskType.Daily and self.infos.dailyResetTime ~= nil) then
            return TimeUtil:GetTime() > self.infos.dailyResetTime
        elseif (missionInfo:GetType() == eTaskType.Weekly and self.infos.weeklyResetTime ~= nil) then
            return TimeUtil:GetTime() > self.infos.weeklyResetTime
        end
    end
    return false
end

-- 每日任务，每周任务奖励奖励
function this:GetLArr(typeIndex)
    local datas = {}
    local stars = 0
    local cfgs = {}
    if (typeIndex == eTaskType.Daily) then
        stars = self.infos.dailyStar or 0
        cfgs = Cfgs.CfgTaskDailyStarReward:GetAll()
    else
        stars = self.infos.weeklyStar or 0
        cfgs = Cfgs.CfgTaskWeeklyStarReward:GetAll()
    end
    for k, v in pairs(cfgs) do
        if (v.star <= stars) then
            -- 已领取
            table.insert(datas, {
                cfg = v,
                index = 10000 + v.star
            })
        else
            -- 未领取
            table.insert(datas, {
                cfg = v,
                index = v.star
            })
        end
    end
    if (#datas > 1) then
        table.sort(datas, function(a, b)
            return a.index < b.index
        end)
    end
    return datas
end

function this:GetDayStars(typeIndex)
    local cur, max = 0, 0
    if (typeIndex == eTaskType.Daily) then
        cur = self.infos and self.infos.dailyStar or 0
        if (self.dayStarMax) then
            max = self.dayStarMax
        else
            local cfgs = Cfgs.CfgTaskDailyStarReward:GetAll()
            for i, v in pairs(cfgs) do
                if (v.star > max) then
                    max = v.star
                end
            end
            self.dayStarMax = max
        end
    else
        cur = self.infos and self.infos.weeklyStar or 0
        if (self.weekStarMax) then
            max = self.weekStarMax
        else
            local cfgs = Cfgs.CfgTaskWeeklyStarReward:GetAll()
            for i, v in pairs(cfgs) do
                if (v.star > max) then
                    max = v.star
                end
            end
            self.weekStarMax = max
        end
    end
    return cur or 0, max
end

function this:GetInfos()
    return self.infos
end

function this:GetAnniversaryInfo(groupId)
    if groupId then
        return (self.infos and self.infos.anniversrays and self.infos.anniversrays[groupId]) or 0
    end
    return 0
end

--检测任务全领取
function this:IsTaskGet(type,group)
    if (self.datas) then
        for i, v in pairs(self.datas) do
            if (v:GetType() == type and (not group or v:GetGroup() == group)) then
                if (v:CheckIsOpen() and not v:IsGet()) then
                    return false
                end
            end
        end
    end
    return true
end
---------------------------------------------勘探任务------------------------
function this:GetExplorationTasks(missionType)
    local arr = {}
    if (self.datas) then
        for i, v in pairs(self.datas) do
            if (missionType == v:GetType()) then
                if (not self.CheckIsReset(v) and v:CheckIsOpen()) then
                    table.insert(arr, v)
                end
            end
        end
    end
    if (arr and #arr > 1) then
        table.sort(arr, function(a, b)
            if (a:GetSortIndex() == b:GetSortIndex()) then
                return a:GetCfgID() < b:GetCfgID()
            else
                return a:GetSortIndex() > b:GetSortIndex()
            end
        end)
    end
    return arr
end

-- 是否有未领取的任务
function this:HasExplorationGet(missionType)
    local hasGet = false;
    if (self.datas) then
        for i, v in pairs(self.datas) do
            if (missionType == v:GetType()) then
                if (v:CheckIsOpen() and v:IsFinish() and v:IsGet() ~= true) then
                    hasGet = true;
                    break
                end
            end
        end
    end
    return hasGet;
end

---------------------------------------回归绑定任务--------------------------
--获取回归绑定任务相关的数据： _type:任务枚举类型，_val:筛选条件值，普通任务是type
function this:GetCollaborationData(_type,_val)
    local arr = {}
    if (self.datas) then
        for i, v in pairs(self.datas) do
            if (_type == v:GetType() and _type==eTaskType.RegressionBind) then
                if (not self.CheckIsReset(v) and v:CheckIsOpen()) and (_val==nil or (_val~=nil and _val==v:GetCfg().type)) then
                    table.insert(arr, v)
                end
            end
        end
    end
    if (arr and #arr > 1) then
        table.sort(arr, function(a, b)
            if (a:GetSortIndex() == b:GetSortIndex()) then
                return a:GetCfgID() < b:GetCfgID()
            else
                return a:GetSortIndex() > b:GetSortIndex()
            end
        end)
    end
    return arr
end

---------------------------------------------活动任务------------------------
-- 获取活动任务 _isNotIndexSort:只根据id排序
function this:GetActivityDatas(_type, _group, _day,_isNotIndexSort)
    local datas = {}
    local cfgIds = {}
    if not self.datas then
        return {}
    end
    for _, data in pairs(self.datas) do
        if (not self.CheckIsReset(data) and data:CheckIsOpen() and _type == data:GetType()) then
            if (_group and _group == data:GetGroup()) or not _group then
                table.insert(datas, data)
                cfgIds[data:GetCfgID()] = data:GetCfgID()
            end
        end
    end
    if _type == eTaskType.DupTower or _type == eTaskType.TmpDupTower then
        -- 塔副本任务需要全部展出，所以采用加入假数据来实现
        datas = self:GetTowerMissions(datas, _type, cfgIds, _group)
    elseif _day and (_type == eTaskType.Seven or _type == eTaskType.SevenStage) then
        -- 获取指定天数的任务
        datas = self:GetSevenMissions(datas, _type, _day)
    elseif _day and (_type == eTaskType.Guide or _type == eTaskType.GuideStage) then
        -- 获取指定阶段的任务
        datas = self:GetGuideMissions(datas, _type, _day)
    elseif _day and (_type == eTaskType.NewYear or _type == eTaskType.NewYearFinish) then
        -- 获取指定新年的任务
        datas = self:GetNewYearMissions(datas, _type, _day)
    elseif _type==eTaskType.Puzzle then
        datas = self:GetPuzzleTasks(datas, _group)
    elseif _type==eTaskType.MultTeam then
        datas=self:GetMultTeamTasks(datas,_group)
    elseif _type == eTaskType.LimitReward or _type == eTaskType.LimitRewardStage then
        datas=self:GetMissionLimits(datas, _type, _day)
    end
    if (datas and #datas > 1) then
        if _type == eTaskType.SevenStage or _type == eTaskType.GuideStage or _type == eTaskType.NewYearFinish or _isNotIndexSort then -- 按id排序
            table.sort(datas, function(a, b)
                return a:GetCfgID() < b:GetCfgID()
            end)
        else
            table.sort(datas, function(a, b)
                if (a:GetSortIndex() == b:GetSortIndex()) then
                    return a:GetCfgID() < b:GetCfgID()
                else
                    return a:GetSortIndex() > b:GetSortIndex()
                end
            end)
        end
    end
    return datas
end

-- 爬塔任务处理
function this:GetTowerMissions(datas, _type, cfgIds, _group)
    datas = datas or {}
    local cfgs = self:GetCfg(_type)
    if cfgs then
        for _, cfg in pairs(cfgs) do
            if not cfgIds[cfg.id] then
                if (_group and cfg.nGroup and _group == cfg.nGroup) or not _group then
                    local tInfo = { -- 假数据
                        id = cfg.id,
                        is_get = 1,
                        type = _type,
                        cfgid = cfg.id,
                        state = 2,
                        finish_ids = {{
                            id = cfg.aFinishIds[1],
                            num = 0
                        }},
                        rewards = {}
                    }
                    local mission = MissionInfo.New()
                    mission:InitData(tInfo)
                    table.insert(datas, mission)
                end
            end
        end
    end
    return datas
end

function this:GetActivityIndex(_type)
    if _type == eTaskType.Seven or _type == eTaskType.SevenStage then
        return self.dayIndex or 1
    elseif _type == eTaskType.Guide or _type == eTaskType.GuideStage then
        return self.guideIndex or 1
    elseif _type == eTaskType.NewYear or _type == eTaskType.NewYearFinish then
        return self.newYearIndex or 1
    end
    return 1
end

---------------------------------------------七日任务------------------------
-- 七日任务处理
function this:GetSevenMissions(_datas, _type, _day)
    local datas = {}
    if _datas then
        for k, data in ipairs(_datas) do
            if _type == eTaskType.Seven and data:GetCfg().nDay == _day then
                table.insert(datas, data)
            elseif _type == eTaskType.SevenStage and data:GetCfgID() == _day then
                table.insert(datas, data)
            end
        end
    end
    return datas
end

-- 当前开启天数
function this:GetDayIndex()
    return self.dayIndex or 1
end

-- 七日任务奖励全领取
function this:IsAllSevenMissionGet()
    if self.datas then
        for _, data in pairs(self.datas) do
            if data:GetType() == eTaskType.Seven or data:GetType() == eTaskType.SevenStage then
                if not data:IsGet() then
                    return false
                end
            end
        end
    end
    return true
end
---------------------------------------------阶段任务------------------------

-- 七日任务处理
function this:GetGuideMissions(_datas, _type, _stage)
    local datas = {}
    if _datas then
        for k, data in ipairs(_datas) do
            if _type == eTaskType.Guide and data:GetCfg().nStage == _stage then
                table.insert(datas, data)
            elseif _type == eTaskType.GuideStage and data:GetCfgID() == _stage then
                table.insert(datas, data)
            end
        end
    end
    return datas
end

function this:GetGuideIndex()
    return self.guideIndex or 1
end

-- 阶段任务奖励全领取
function this:IsAllGuideMissionGet()
    if self.datas then
        for _, data in pairs(self.datas) do
            if data:GetType() == eTaskType.Guide or data:GetType() == eTaskType.GuideStage then
                if not data:IsGet() then
                    return false
                end
            end
        end
    end
    return true
end

---------------------------------------------新年任务------------------------
-- 新年任务处理
function this:GetNewYearMissions(_datas, _type, _stage)
    local datas = {}
    if _datas then
        for k, data in ipairs(_datas) do
            if _type == eTaskType.NewYear and data:GetCfg().nStage == _stage then
                table.insert(datas, data)
            elseif _type == eTaskType.NewYearFinish and data:GetCfgID() == _stage then
                table.insert(datas, data)
            end
        end
    end
    return datas
end

function this:GetNewYearIndex()
    return self.newYearIndex or 1
end

-- 阶段任务奖励全领取
function this:IsAllNewYearMissionGet()
    if self.datas then
        for _, data in pairs(self.datas) do
            if data:GetType() == eTaskType.NewYear or data:GetType() == eTaskType.NewYearFinish then
                if not data:IsGet() then
                    return false
                end
            end
        end
    end
    return true
end

---------------------------------------------拼图任务------------------------
function this:GetPuzzleTasks(_datas,nGroup)
    local arr = {}
    if (_datas) then
        for i, v in pairs(_datas) do
            if (eTaskType.Puzzle == v:GetType() and v:GetCfg().nGroup==nGroup) then
                if (not self.CheckIsReset(v) and v:CheckIsOpen()) then
                    table.insert(arr, v)
                end
            end
        end
    end
    if (arr and #arr > 1) then
        table.sort(arr, function(a, b)
            return a:GetCfgID() < b:GetCfgID()
        end)
    end
    return arr
end

---------------------------------------------递归沙盒任务------------------------
function this:GetMultTeamTasks(_datas,nGroup)
    local arr = {}
    if (_datas) then
        for i, v in pairs(_datas) do
            if (eTaskType.MultTeam == v:GetType() and v:GetCfg().nGroup==nGroup) then
                if (not self.CheckIsReset(v) and v:CheckIsOpen()) then
                    table.insert(arr, v)
                end
            end
        end
    end
    if (arr and #arr > 1) then
        table.sort(arr, function(a, b)
            return a:GetCfgID() < b:GetCfgID()
        end)
    end
    return arr
end
---------------------------------------------限量任务------------------------
function this:GetMissionLimits(_datas, _type, _stage)
    if not _stage then
        return _datas
    end
    local datas = {}
    if _datas then
        for k, data in ipairs(_datas) do
            if _type == eTaskType.LimitRewardStage and data:GetCfg().id == _stage then
                table.insert(datas, data)
            elseif _type == eTaskType.LimitReward and data:GetCfgID() == _stage then
                table.insert(datas, data)
            end
        end
    end
    return datas
end
-----------------------------------------------协议发------------------------
-- 任务列表
function this:GetTasksData()
    local proto = {"TaskProto:GetTasksData"}
    NetMgr.net:Send(proto)
end
function this:GetTasksDataRet()
    EventMgr.Dispatch(EventType.Mission_List)
    ActivityMgr:RefreshOpenState() -- 用于到点刷新活动状态
end

-- 领取奖励
function this:GetReward(_id)
    local proto = {"TaskProto:GetReward", {
        id = _id
    }}
    NetMgr.net:Send(proto)
end

--领取指定组下的类型奖励
function this:GetRewardByType(types,group)
    local datas = {}
    if types and #types > 0 and group then
        for i, v in ipairs(types) do
            table.insert(datas,{type = v,nGroup = group})
        end
    end
    if #datas > 0 then
        TaskProto:GetRewardByTypes(datas)
    end
end

function this:GetSevenTaskDay(_type)
    local proto = {"TaskProto:GetSevenTasksDay", {
        type = _type
    }}
    NetMgr.net:Send(proto)
end

-----------------------------------------------协议收------------------------
-- 检查红点数据
function this:CheckRedPointData()
    -- local isHad = false
    -- if(self.datas) then
    -- 	for i, v in pairs(self.datas) do
    -- 		local get = v:IsGet()
    -- 		local finish = v:IsFinish()
    -- 		local b = self.CheckIsReset(v)
    -- 		local b2 = v:CheckIsOpen()
    -- 		if(not b and b2 and not get and finish) then
    -- 			isHad = true
    -- 			break
    -- 		end
    -- 	end
    -- end

    -- menu
    local hadNums = {0, 0}
    if (self.datas) then
        hadNums = self:CheckRed({eTaskType.Main, eTaskType.Sub, eTaskType.Daily, eTaskType.Weekly}) and {1, 0} or
                      hadNums
    end
    RedPointMgr:UpdateData(RedPointType.Mission, hadNums)

    -- tower
    local towerRed = {}
    towerRed[eTaskType.DupTower] = self:CheckRed({eTaskType.DupTower}) and 1 or 0
    RedPointMgr:UpdateData(RedPointType.MissionTower, towerRed)

    -- taofa
    local taoFaRed = self:CheckRed({eTaskType.DupTaoFa}) and 1 or 0
    RedPointMgr:UpdateData(RedPointType.MissionTaoFa, taoFaRed)

    -- 主界面红点
    local isTowerRed = self:CheckRed({eTaskType.DupTower, eTaskType.TmpDupTower}) and 1 or 0
    RedPointMgr:UpdateData(RedPointType.ActiveEntry1, isTowerRed)

    local isPlotTower = self:CheckRed({eTaskType.Story}) and 1 or 0
    RedPointMgr:UpdateData(RedPointType.ActiveEntry2, isPlotTower)
    RedPointMgr:UpdateData(RedPointType.ActiveEntry4, isPlotTower)

    RedPointMgr:UpdateData(RedPointType.ActiveEntry3, taoFaRed)

    if MenuMgr.isInit then --防止未初始化完成就检测数据
        -- 活动
        ActivityMgr:CheckRedPointData()

        --回归
        RegressionMgr:CheckRedPointData()

        MultTeamBattleMgr:CheckRedInfo();

        -- 关卡
        DungeonMgr:CheckRedPointData()
        --大富翁
        RichManMgr:CheckRed();
        --皮肤通行证
        OperationActivityMgr:CheckRedSkinPassPointData()
    end

    -- 勘探
    ExplorationMgr:CheckRedInfo();

    --rogue 
    local rogueRedNum =  self:CheckRed({eTaskType.Rogue}) and 1 or 0
    RedPointMgr:UpdateData(RedPointType.Rogue, rogueRedNum)

    --Colosseum
    ColosseumMgr:CheckMissionRed()
    --回归绑定
    CollaborationMgr:CheckRedInfo();

    --积分战斗
    RedPointMgr:UpdateData(RedPointType.BuffBattle,self:CheckRed({eTaskType.PointsBattle}) and 1 or 0)

    --周年活动
    AnniversaryMgr:CheckRedPointData()
    --培养活动
    CharacterRaisingMgr:CheckRed();
end

-- 任务添加通知
function this:TaskAdd(proto)
    if (proto) then
        self.datas = self.datas or {}
        for i, v in ipairs(proto.tasks) do
            local mission = MissionInfo.New()
            mission:InitData(v)
            self.datas[v.id] = mission
        end

        if (proto.is_finish) then
            EventMgr.Dispatch(EventType.Mission_List)
            self:CheckRedPointData()
        end
    end
end

-- 任务刷新通知
function this:TaskFlush(proto)
    if (proto) then
        for i, v in ipairs(proto.tasks) do
            self:UpdateData(v)
        end
        EventMgr.Dispatch(EventType.Mission_List) -- 刷新任务列表

        -- 通知tip顶部弹窗更新数据
        self:ApplyShowMisionTips()

        self:CheckRedPointData()
    end
end

function this:UpdateData(v)
    local data = self:GetData(v.id)
    if (data) then
        -- 插入需要变动的列表 改已完成的
        self:CheckNeedShowTips(data, v)

        -- 更新数据
        for key, value in pairs(v) do
            data[key] = value
        end
        data:Refresh()
    end
end

function this:GetSevenTaskDayRet(proto)
    if proto and proto.type then
        if proto.type == eTaskType.Seven or proto.type == eTaskType.SevenStage then
            self.dayIndex = proto.c_day
        elseif proto.type == eTaskType.Guide or proto.type == eTaskType.GuideStage then
            self.guideIndex = proto.c_day
        elseif proto.type == eTaskType.NewYearFinish or proto.type == eTaskType.NewYear then -- 写死全开
            -- self.newYearIndex = proto.c_day
        end
        if MenuMgr.isInit then --防止未初始化完成就检测数据
            -- 活动
            ActivityMgr:CheckRedPointData()
        end
        -- ActivityMgr:InitListOpenState()
    end
end

function this:ApplyShowMisionTips()
    if(not MenuMgr:CheckIsInit())then 
        return
    end
    if (self.applyShowMisionTips) then
        return
    end
    self.applyShowMisionTips = 1
    self.tipsTimer = FuncUtil:Call(function()
        self.applyShowMisionTips = nil
        Tips.ShowMisionTips()
        self.tipsTimer = nil
    end, nil, 500) -- 延迟是为了合并数据

    -- if (self.tipsTimer) then
    --     --有刷新则继续等待
    --     self.tipsTimer.Timer(function()
    --         self.applyShowMisionTips = nil
    --         Tips.ShowMisionTips()
    --         self.tipsTimer = nil
    --     end, nil, 300,0,1)
    -- else
    --     self.tipsTimer = FuncUtil:Timer(function()
    --         self.applyShowMisionTips = nil
    --         Tips.ShowMisionTips()
    --         self.tipsTimer = nil
    --     end, nil, 300,0,1) -- 延迟是为了合并数据
    -- end
end

function this:CheckNeedShowTips(old, new)
    if(not self:IsOpen())then 
        return
    end 
    local info = MissionChangeInfo.New()
    info:InitData(new)
    if (info:IsFinish()) then
        self.changeDatas[new.id] = info
    end
end

function this:IsOpen()
    if(self.isOpen)then 
        return self.isOpen
    end 
    self.isOpen = MenuMgr:CheckModelOpen(OpenViewType.main, "MissionView")
    return self.isOpen
end

--[[
-- function this:ShowMisionTips()
-- 	self.applyShowMisionTips = nil
-- 	Tips.ShowMisionTips()
-- end
-- 检测是否需要弹出提示
function this:CheckNeedShowTips(old, new)
    -- 去重复
    local newCnt = self.GetCnt(new)
    if (self.changeDatas[new.id]) then
        -- local changeData = self.changeDatas[new.id]
        -- if(new.state == changeData:GetState()) then
        -- 	if(newCnt == changeData:GetCnt()) then
        -- 		--状态一样，进度一样 重复数据
        -- 		return
        -- 	end
        -- end
        self.changeDatas[new.id]:InitData(new)
        return
    end
    -- 是否变动
    local oldCnt = old:GetState()
    if (oldCnt == newCnt) then
        -- 无变化
        return
    end
    local info = MissionChangeInfo.New()
    info:InitData(new)
    self.changeDatas[new.id] = info
end

function this.GetCnt(new)
    if (new.finish_ids) then
        if (#new.finish_ids > 1) then
            for i, v in ipairs(new.finish_ids) do
                local cfg = Cfgs.CfgTaskFinishVal:GetByID(v.id)
                if (cfg and v.num < cfg.nVal1) then
                    return 0
                end
            end
            return 1
        else
            return new.finish_ids[1].num
        end
    else
        return 1
    end
end
]]

-- 弹提示数据
function this:GetChangeDatas()
    if(not self.changeDatas)then 
        return {}
    end
    local arr = {}
    for i, v in pairs(self.changeDatas) do
        table.insert(arr, v)
    end
    if (#arr > 1) then
        table.sort(arr, function(a, b)
            if (a:GetSuccessNum() == b:GetSuccessNum()) then
                if (a:GetTypeCount() == b:GetTypeCount()) then
                    return a:GetCfgID() < b:GetCfgID()
                else
                    return a:GetTypeCount() < b:GetTypeCount()
                end
            else
                return a:GetSuccessNum() < b:GetSuccessNum()
            end
        end)
    end
    self.changeDatas = {}
    return arr
end

-- 任务奖励  
function this:GetRewardRet(datas, dailyStar, weeklyStar, rewards, anniversrays)
    if (self.infos) then
        self.infos.dailyStar = dailyStar
        self.infos.weeklyStar = weeklyStar
        if anniversrays then
            self.infos.anniversrays = self.infos.anniversrays or {}
            for _, v in ipairs(anniversrays) do
                self.infos.anniversrays[v.first] = v.second
            end
        end
    end
    local type = nil
    if (datas and #datas > 0) then
        for i, v in ipairs(datas) do
            local data = self:GetData(v.id)
            if (data) then
                data:SetIsGet(v.is_get)
                data:Refresh()
                type = data:GetType()
                if data:GetCfgID() == 20105 then
                    EventMgr.Dispatch(EventType.Guide_Trigger_Flag, "FinishMission") 
                end
            end
        end
    end
    if type and type==eTaskType.Puzzle then
        EventMgr.Dispatch(EventType.Mission_RewardRet, {type, rewards});
    else
        EventMgr.Dispatch(EventType.Mission_List, {type, rewards})
    end

    self:CheckRedPointData()
end

-- 获取重置任务信息(登录时和到刷新时间点时)
function this:GetResetTaskInfo()
    local proto = {"TaskProto:GetResetTaskInfo"}
    NetMgr.net:Send(proto)
end
function this:GetResetTaskInfoRet(proto)
    self.infos = proto or {}
    if proto.anvsStarInfo then
        self.infos.anniversrays = self.infos.anniversrays or {}
        for _, v in ipairs(proto.anvsStarInfo) do
            self.infos.anniversrays[v.first] = v.second
        end
        self.infos.anvsStarInfo = nil
    end
    -- EventMgr.Dispatch(EventType.Mission_List)    两条协议基本是同时请求的，所以由GetTasksDataRet来刷新界面
end

-- 是否有未领取
function this:CheckRed(types)
    local len = #types
    for i = len, 1, -1 do
        if (types[i] == eTaskType.Daily or types[i] == eTaskType.Weekly) then
            local cur, max = MissionMgr:GetDayStars(types[i])
            if (cur >= max) then
                table.remove(types, i)
            end
        elseif types[i] == eTaskType.SONICO then
            local cfgs = Cfgs.CfgSonicoTaskReward:GetAll()
            if cfgs and #cfgs > 0 and cfgs[#cfgs] and cfgs[#cfgs].star and self:GetAnniversaryInfo(eTaskType.SONICO) >= cfgs[#cfgs].star then
                table.remove(types, i)
            end
        elseif types[i] == eTaskType.StoryCollectionAct then
            local cfgs = Cfgs.CfgStoryCollectionActTaskReward:GetAll()
            if cfgs and #cfgs > 0 and cfgs[#cfgs] and cfgs[#cfgs].star and self:GetAnniversaryInfo(eTaskType.StoryCollectionAct) >= cfgs[#cfgs].star then
                table.remove(types, i)
            end
        end
    end

    if (self.datas) then
        for k, m in ipairs(types) do
            for i, v in pairs(self.datas) do
                if (m == v:GetType()) then
                    if (not self.CheckIsReset(v) and v:CheckIsOpen() and v:IsFinish() and not v:IsGet()) then
                        return true
                    end
                end
            end
        end
    end
    return false
end

function this:CheckRed2(_type,_nGroup)
    if (self.datas) then
        for i, v in pairs(self.datas) do
            if (_type == v:GetType()) then
                if (not self.CheckIsReset(v) and v:CheckIsOpen() and v:IsFinish() and not v:IsGet()) then
                    if v:GetCfg() and (v:GetCfg().nGroup == nil or v:GetCfg().nGroup == _nGroup) then
                        return true
                    end
                end
            end
        end
    end
    return false
end

function this:CheckRed3(_types,_nGroup)
    for k, v in pairs(_types) do
        if(self:CheckRed2(v,_nGroup)) then 
            return true
        end 
    end
    return false
end

-- 只检测开启天数内的领取
function this:CheckSevenRed()
    -- 天数任务
    local stageDatas = self:GetActivityDatas(eTaskType.SevenStage)
    if stageDatas then
        for _, v in ipairs(stageDatas) do
            -- 在开启天数内有完成但未领取的
            if v:GetID() <= self:GetDayIndex() and v:IsFinish() and not v:IsGet() then
                return true
            end
        end
    end

    -- 天数内具体任务
    local datas = self:GetActivityDatas(eTaskType.Seven)
    if datas then
        for _, v in ipairs(datas) do
            -- 在开启天数内有完成但未领取的
            if v:GetIndex() <= self:GetDayIndex() and v:IsFinish() and not v:IsGet() then
                return true
            end
        end
    end
    return false
end

function this:CheckGuideRed()
    -- 天数任务
    local stageDatas = self:GetActivityDatas(eTaskType.GuideStage)
    if stageDatas then
        for _, v in ipairs(stageDatas) do
            -- 在开启天数内有完成但未领取的      
            if v:GetCfg().id <= self:GetGuideIndex() and v:IsFinish() and not v:IsGet() then
                return true
            end
        end
    end

    -- 天数内具体任务
    local datas = self:GetActivityDatas(eTaskType.Guide)
    if datas then
        for _, v in ipairs(datas) do
            -- 在开启天数内有完成但未领取的
            if v:GetIndex() <= self:GetGuideIndex() and v:IsFinish() and not v:IsGet() then
                return true
            end
        end
    end
    return false
end

-- 只检测开启天数内的领取
function this:CheckNewYearRed()
    -- 天数任务
    local stageDatas = self:GetActivityDatas(eTaskType.NewYearFinish)
    if stageDatas and #stageDatas > 0 then
        for _, v in ipairs(stageDatas) do
            -- 在开启天数内有完成但未领取的
            if v:GetID() <= self:GetNewYearIndex() and v:IsFinish() and not v:IsGet() then
                return true
            end
        end
    end

    -- 天数内具体任务
    local datas = self:GetActivityDatas(eTaskType.NewYear)
    if datas and #datas > 0 then
        for _, v in ipairs(datas) do
            -- 在开启天数内有完成但未领取的
            if v:GetIndex() and v:GetIndex() <= self:GetNewYearIndex() and v:IsFinish() and not v:IsGet() then
                return true
            end
        end
    end
    return false
end

-- 活动副本任务红点
function this:CheckDungeonActivityRed(sectionId)
    if (self.datas) then
        for i, v in pairs(self.datas) do
            if v:GetType() == eTaskType.Story and v:GetGroup() == sectionId then
                if (not self.CheckIsReset(v) and v:CheckIsOpen() and v:IsFinish() and not v:IsGet()) then
                    return true
                end
            end
        end
    end
    return false
end

-- 日常的点击操作任务是否未完成
function this:CheckDoClickBoard()
    local datas = self:GetDatas(eTaskType.Daily)
    if (datas) then
        for k, v in pairs(datas) do
            if (v:GetFinishCfg() and v:GetFinishCfg().nType==10027 and not self.CheckIsReset(v) and v:CheckIsOpen() and not v:IsFinish()) then
                return 1 
            end
        end
    end
    return 0
end

function this:DoClickBoard()
    if(self:CheckDoClickBoard()==1) then 
        PlayerProto:ClickBoard()
    end 
end

function this:TaskDelete(proto)
    if self.datas and proto and proto.tasks and #proto.tasks > 0 then
        for i, v in ipairs(proto.tasks) do
            if self.datas[v.id] then
                self.datas[v.id] = nil
            end
        end
        EventMgr.Dispatch(EventType.Mission_Delete)
    end
end

return this
