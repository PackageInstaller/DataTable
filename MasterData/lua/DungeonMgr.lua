-- 副本管理
-- DungeonMgr = {};
-- local this = DungeonMgr;
DungeonMgr = MgrRegister("DungeonMgr")
local this = DungeonMgr;

-- 副本标志类型
DungeonFlagType = {
    Story = 1 -- 剧情关卡
}

-- 章节类型
SectionType = {
    -- 主线
    MainLine = 1,
    -- 每日
    Daily = 2,
    -- 活动
    Activity = 3,
    -- 教程
    Course = 4,
    -- 角斗场
    Colosseum = 5,
    -- 其他 
    Other = 6,
};

-- 章节活动类型
SectionActivityType = {
    Tower = 101,
    BattleField = 102,
    Plot = 103,
    TaoFa = 104,
    NewTower = 105, -- 新爬塔
    Trials = 106, -- 试炼
    TotalBattle = 107, -- 十二星宫
    Rogue = 108, -- 乱序演习
    Colosseum = 109, --
    GlobalBoss = 110, -- 世界boss
    RogueMap = 112, -- 秘境探索
    MultTeamBattle = 113, -- 递归沙盒
    TowerDeep = 114, -- 深塔计划
    EternityWarzone = 116, -- 永境战域
    StoryCollection = 117, --故事集
    VirtualCataclysm = 118, --虚数天灾
    PeriodicBoss = 119, --周期boss
}

-- 章节活动开启类型
SectionActivityOpenType = {
    BattleField = 1,
    Plot = 2,
    TaoFa = 3
}

-- 打开副本时状态
DungeonOpenType = {
    Normal = 1, -- 正常
    Finish = 2, -- 完成关卡
    Retreat = 3, -- 撤退
    Jump = 4 -- 跳转
}

-- 设置数据
function this:Set(proto)
    if (proto == nil) then
        return;
    end
    self.dungeonDatas = self.dungeonDatas or {};
    if (proto.mainLine) then
        for _, mainLineData in ipairs(proto.mainLine) do
            self:AddDungeonData(mainLineData);
        end
    end

    if (proto.is_finish) then
        EventMgr.Dispatch(EventType.Dungeon_Data_Setted) -- 副本数据设置完成
        if MenuMgr.isInit then
            self:CheckRedPointData()
        end
    end
end

-- 设置每日副本数据
function this:SetDailyData(proto)
    self.dailyData = proto;
end

-- 更新每日副本次数
function this:UpdateDailyData(proto)
    self.dailyData = self.dailyData or {};
    if (proto) then
        for k, v in pairs(proto) do
            self.dailyData[k] = v;
        end
        EventMgr.Dispatch(EventType.Dungeon_DailyData_Update)
    end
end

-- 判断是否开启时间内，副本刷新时间为g_ActivityDiffDayTime
function this:IsDailyOpenTime(openTime)
    local isTime = false;
    local isNextDayOpen = false -- 下一天是否开启
    if openTime then
        local weekIndex = CSAPI.GetWeekIndex();
        local hmsTime = TimeUtil:GetTimeHMS(CSAPI.GetServerTime())
        if hmsTime.hour < g_ActivityDiffDayTime then -- 没到刷新时间开启前一天的副本
            weekIndex = weekIndex - 1 <= 0 and 7 or weekIndex - 1;
        end
        isTime = openTime[weekIndex] == 1;

        local nextWeekIndex = weekIndex + 1 > 7 and 1 or (weekIndex + 1)
        isNextDayOpen = openTime[nextWeekIndex] == 1
    end
    return isTime, isNextDayOpen;
end

-- 设置多倍掉落开关
function this:SetMultiReward(b)
    self.isMultiReward = b
end

-- 更新副本中的多倍掉落使用信息
function this:UpdateSectionMultiInfo(proto)
    self.multiInfo = self.multiInfo or {};
    if proto then
        if proto.infos and #proto.infos > 0 then
            for i, v in ipairs(proto.infos) do
                self.multiInfo[v.id] = v.cnt;
                self.multiUpdateTime = v.pt
            end
        end
        self.limitMultiInfo = proto.cntInfos or nil
    end
    EventMgr.Dispatch(EventType.Dungeon_DailyData_Update)
end

-- 返回副本中的多倍掉落信息
function this:GetSectionMultiNum(_id)
    local num = 0;
    local limitTime = 0
    local id = self.sectionDatas[_id] and self.sectionDatas[_id]:GetMultiID() or 0
    if self.multiInfo and self.multiInfo[id] then
        num = self.multiInfo[id]
    end
    if self.limitMultiInfo and #self.limitMultiInfo > 0 then
        for i, v in ipairs(self.limitMultiInfo) do
            if v.time and v.time - TimeUtil:GetTime() > 0 then
                if limitTime <= 0 then
                    limitTime = v.time
                elseif limitTime > v.time then
                    limitTime = v.time
                end
                if v.cnt then
                    num = num - v.cnt
                end
            end
        end
    end
    return num, limitTime
end

function this:GetLimitMultiInfo()
    return self.limitMultiInfo
end

function this:GetMultiUpdateTime()
    return self.multiUpdateTime
end

-- 获取日常变量
function this:GetDailyData()
    return self.dailyData
end

-- 获取副本类型
function this:GetDungeonSectionType(id)
    local cfgDungeon = Cfgs.MainLine:GetByID(id);
    if (cfgDungeon) then
        local sectionData = self:GetSectionData(cfgDungeon.group);
        return sectionData and sectionData:GetSectionType();
    end
    return nil;
end

-- 返回当前开启的最后一个章节
function this:GetLastMainLineSection()
    local allSectionDatas = DungeonMgr:GetAllSectionDatas();
    local currSection = nil;
    local currIndex = 0;
    if allSectionDatas then
        for id, sectionData in pairs(allSectionDatas) do
            local state = sectionData:GetState();
            if (state == 1 or state == 2) and sectionData:GetSectionType() == SectionType.MainLine and
                sectionData:GetIndex() > currIndex then
                currSection = sectionData;
            end
        end
    end
    return currSection;
end

-- 添加副本数据
function this:AddDungeonData(data)
    local dungeonData = DungeonData.New();
    if data and data.star and data.star > 0 then
        data.isPass = true;
    else
        data.isPass = false;
    end
    dungeonData:SetData(data);
    self.dungeonDatas[data.id] = dungeonData;
    self.maxDungeonID = self.maxDungeonID or 0
    if data.id and data.id > self.maxDungeonID then
        local cfg = Cfgs.MainLine:GetByID(data.id)
        if cfg and cfg.type == eDuplicateType.MainNormal then
            self.maxDungeonID = data.id
        end
    end
end

-- 清除部分副本数据
function this:ClearDungeonData(ids)
    if ids and #ids > 0 then
        for i, id in ipairs(ids) do
            if self.dungeonDatas and self.dungeonDatas[id] then
                self.dungeonDatas[id] = nil
            end
        end
    end
end

function this:GetMaxDungeonID()
    return self.maxDungeonID or 0
end

-- 初始化章节
function this:InitSectionDatas()
    if self.sectionDatas == nil then
        self.sectionDatas = {};
        -- 初始化主线章节
        local cfgs = Cfgs.Section:GetAll();
        for _, cfg in pairs(cfgs) do
            local sectionData = SectionData.New();
            sectionData:Init(cfg);
            self.sectionDatas[cfg.id] = sectionData;
        end
    end
end

-- 获取章节数据
function this:GetSectionData(id)
    return self.sectionDatas and self.sectionDatas[id];
end
-- 获取全部章节数据
function this:GetAllSectionDatas()
    return self.sectionDatas;
end
-- 获取指定章节数据 sectionType
function this:GetScetionDatas(_group)
    if (self.sectionDatas) then
        local _datas = {}
        for i, v in pairs(self.sectionDatas) do
            if (v:GetGroup() == _group) then
                table.insert(_datas, v)
            end
        end
        if #_datas > 0 then
            table.sort(_datas, function(a, b)
                return a:GetID() < b:GetID()
            end)
        end
        return _datas
    end
end

-- 获取指定章节数据 --SectionActivityType
function this:GetActivitySectionDatas(_type, isOpen)
    if (self.sectionDatas) then
        local _datas = {}
        for i, v in pairs(self.sectionDatas) do
            if (v:GetType() == _type and (not isOpen or v:GetOpen())) then
                table.insert(_datas, v)
            end
        end
        if #_datas > 0 then
            table.sort(_datas, function(a, b)
                return a:GetID() < b:GetID()
            end)
        end
        return _datas
    end
end

-- 获取当前章节
function this:GetCurrSectionData()
    local allSectionDatas = DungeonMgr:GetAllSectionDatas();
    local currSection = nil;
    local currSectionID = nil;
    if self.currId then
        local cfg = Cfgs.MainLine:GetByID(self.currId);
        if self.isFirst and cfg.lasChapterID ~= nil then -- 第一次通关且有下一章ID
            local nextCfg = Cfgs.MainLine:GetByID(cfg.lasChapterID[1]);
            currSectionID = nextCfg.group;
        else
            currSectionID = cfg.group;
        end
    end
    if allSectionDatas then
        for id, sectionData in pairs(allSectionDatas) do
            if sectionData:GetSectionType() == SectionType.MainLine then
                local state = sectionData:GetState();
                if (state == 1 or state == 2) and sectionData:GetID() == currSectionID and sectionData:GetSectionType() ==
                    SectionType.MainLine then
                    currSection = sectionData;
                    break
                end
            else
                if sectionData:GetID() == currSectionID then
                    currSection = sectionData;
                    break
                end
            end

            -- if(state == 1) then --开启的
            -- 	currSection = sectionData;
            -- 	break;
            -- elseif(state == 2) then --完成的
            -- 	if(currSection == nil or(sectionData:GetID() == currSectionID and sectionData:GetSectionType() == SectionType.MainLine)) then
            -- 		currSection = sectionData;
            -- 		break;
            -- 	end
            -- end
        end
    end

    return currSection;
end

-- 获取指定类型的最后开启关卡 _type:eDuplicateType
function this:GetLastOpenDungeon(_type)
    local dungeonCfg = nil;
    local cfgs = Cfgs.MainLine:GetAll();
    if (cfgs) then
        for _, tmpCfg in pairs(cfgs) do
            if tmpCfg.type == _type then
                if (dungeonCfg == nil) or (dungeonCfg and dungeonCfg.id < tmpCfg.id) then
                    local dungeonData = DungeonMgr:GetDungeonData(tmpCfg.id);
                    if (dungeonData ~= nil and dungeonData:IsOpen() == true) then
                        if dungeonData:IsPass() and tmpCfg.lasChapterID then
                            dungeonCfg = Cfgs.MainLine:GetByID(tmpCfg.lasChapterID[1]);
                        else
                            dungeonCfg = tmpCfg
                        end
                    elseif tmpCfg.preChapterID then
                        local preData = DungeonMgr:GetDungeonData(tmpCfg.preChapterID[1]);
                        if preData ~= nil and preData:IsPass() == true then
                            dungeonCfg = tmpCfg;
                        end
                    end
                end
            end
        end
    end
    return dungeonCfg;
end

-- 获取当前最新关卡
function this:GetCurrMainLineProgress()
    if self.showCfgs == nil then
        self.showCfgs = {}
        local cfgs = Cfgs.CfgMainLineShow:GetAll()
        if cfgs then
            for k, cfg in pairs(cfgs) do
                table.insert(self.showCfgs, cfg)
            end
        end
        if #self.showCfgs > 0 then
            table.sort(self.showCfgs, function(a, b)
                if a.group ~= b.group then
                    return a.group < b.group
                else
                    return a.index < b.index
                end
            end)
        end
    end

    local cfgDungeon = nil
    local prograss = 0
    if #self.showCfgs > 0 then
        local dungeonData = nil
        for i, cfg in ipairs(self.showCfgs) do
            dungeonData = DungeonMgr:GetDungeonData(cfg.id)
            if dungeonData and dungeonData:IsPass() then
                if cfg.next then
                    cfgDungeon = Cfgs.MainLine:GetByID(cfg.next)
                else
                    cfgDungeon = dungeonData:GetCfg()
                end
                -- Log(string.format("关卡id：%s，所在组：%s，状态：已通关,主界面显示关卡id：%s", cfg.id, cfg.group,cfgDungeon.id) ..
                --         table.tostring(dungeonData:GetCfg()))
            else
                if not cfgDungeon then
                    cfgDungeon = Cfgs.MainLine:GetByID(cfg.id)
                end
                break
            end
        end
        -- 进度计算
        local currGroup = 1
        local curNum, maxNum = 0, 0
        for i, cfg in ipairs(self.showCfgs) do
            if cfg.group ~= currGroup then
                if curNum ~= maxNum then -- 上一组未通关完
                    break
                else -- 重置进度
                    curNum, maxNum = 0, 0
                    currGroup = cfg.group
                end
            end
            local dungeonData = DungeonMgr:GetDungeonData(cfg.id)
            if dungeonData and dungeonData:IsPass() then
                curNum = curNum + 1
            end
            maxNum = maxNum + 1
        end
        prograss = math.floor((curNum / maxNum) * 100)
    end
    return cfgDungeon, prograss
end

-- 获取最后通关的副本 --sid：章节id
function this:GetLastPassDungeon(sid)
    local cfgs = Cfgs.MainLine:GetGroup(sid)
    local cfg = nil
    if cfgs and #cfgs > 0 then
        for i, v in ipairs(cfgs) do
            local dungeonData = self:GetDungeonData(v.id)
            if dungeonData and dungeonData:IsPass() then
                if cfg == nil or cfg.id < v.id then
                    cfg = v
                end
            end
        end
    end
    return cfg
end

-- 主线进度
function this:GetMainLineOpenDungeon()
    local mainLineCfg = self:GetLastOpenDungeon(eDuplicateType.MainNormal)
    local teachCfg = self:GetLastOpenDungeon(eDuplicateType.Teaching)
    if mainLineCfg and teachCfg then -- 判断教程关和主线哪个是最新
        if teachCfg.preChapterID and teachCfg.preChapterID[1] >= mainLineCfg.id then
            return teachCfg
        end
    end
    return mainLineCfg
end

-- 获取副本数据
function this:GetDungeonData(id)
    return self.dungeonDatas and self.dungeonDatas[id];
end
-- 关卡是否已通关
function this:CheckDungeonPass(id)
    --    LogError("id" .. id);
    --    LogError(_data);
    local _data = self:GetDungeonData(id)
    return _data and _data:IsPass() or false
end

-- 章节是否开启
function this:CheckSectionOpen(id)
    local sectionData = self:GetSectionData(id);
    return sectionData and sectionData:GetType() or false;
end

-- 获取全部副本数据
function this:GetAlDungeonDatas()
    return self.dungeonDatas;
end

-- 更新副本条件数据
function this:UpdateDupGrade(id, star, nDupGrade)
    if self.dungeonDatas[id] then
        self.dungeonDatas[id].data.star = star;
        self.dungeonDatas[id].data.data = nDupGrade;
    elseif star and nDupGrade then
        self:AddDungeonData({
            id = id,
            star = star,
            data = nDupGrade
        });
    end

    -- EventMgr.Dispatch(EventType.Update_Dungeon_Data)
end

-- 副本是否开启
function this:IsDungeonOpen(id)
    if (id == nil) then
        LogError("检测副本开启状态失败！id无效");
    end

    local dungeonData = self:GetDungeonData(id);
    -- 存在副本数据，表示已经通关，自然就是开启了的
    if dungeonData and dungeonData:IsPass() then
        return true
    end
    local cfgDungeon = Cfgs.MainLine:GetByID(id);
    if (cfgDungeon) then
        if (cfgDungeon.LockLevel and PlayerClient:GetLv() < cfgDungeon.LockLevel) then
            -- 等级不满足
            local str = LanguageMgr:GetByID(15048, cfgDungeon.LockLevel)
            return false, str;
        end
        if cfgDungeon.LockMission then
            local finishNum = 0
            local str = ""
            for i, v in ipairs(cfgDungeon.LockMission) do
                if v[1] == eTaskType.GuideStage and v[2] < MissionMgr:GetGuideIndex() then
                    finishNum = finishNum + 1
                    str = str .. " " ..
                              LanguageMgr:GetByID(15107, v[2] + 1, cfgDungeon.chapterID .. " " .. cfgDungeon.name)
                end
            end
            if finishNum < #cfgDungeon.LockMission then
                return false, str
            end
        end
        if (cfgDungeon.preChapterID == nil) then
            -- 无前置关卡
            return true;
        else
            for _, preChapterId in ipairs(cfgDungeon.preChapterID) do
                local preDungeonData = self:GetDungeonData(preChapterId);
                if (preDungeonData == nil or preDungeonData:IsPass() == false) then
                    local dungeonName = "";
                    local cfg2 = Cfgs.MainLine:GetByID(preChapterId);
                    if not cfg2 then
                        LogError("当前关卡id：" .. id .. "，前置节点id中：" .. preChapterId ..
                                     "找不到对应关卡表数据！")
                    else
                        local sectionType = self:GetDungeonSectionType(preChapterId)
                        if sectionType == SectionType.MainLine then
                            -- local exStr = cfg2.type == 2 and string.format("(%s)", LanguageMgr:GetByID(15016)) or ""
                            local exStr = ""
                            dungeonName = cfg2.chapterID .. " " .. cfg2.name .. exStr;
                        elseif cfg2.diff then
                            dungeonName = cfg2.diff == 2 and LanguageMgr:GetByID(15016) .. "-" .. cfg2.name or cfg2.name
                        else
                            dungeonName = cfg2.name;
                        end
                    end
                    local str = LanguageMgr:GetTips(1010, dungeonName)
                    return false, str;
                end
            end
        end
    else
        LogError("找不到副本配置" .. id);
        return false;
    end

    return true;
end

-- 初始化关卡组
function this:InitDungeonGroupDatas()
    if self.dungeonGroupDatas == nil then
        self.dungeonGroupDatas = {}
        local cfgs = Cfgs.DungeonGroup:GetAll()
        if cfgs then
            for _, cfg in pairs(cfgs) do
                local data = DungeonGroupData.New()
                data:Init(cfg)
                self.dungeonGroupDatas[cfg.id] = data
            end
        end
    end
end

-- 获取关卡祖
function this:GetDungeonGroupData(id)
    return self.dungeonGroupDatas and self.dungeonGroupDatas[id]
end

-- 获取同一章节的关卡祖
function this:GetDungeonGroupDatas(group, ishard)
    local datas = {}
    if self.dungeonGroupDatas then
        for _, data in pairs(self.dungeonGroupDatas) do
            if data:GetGroup() == group then
                data:SetHard(ishard)
                table.insert(datas, data)
            end
        end
    end
    if #datas > 0 then
        table.sort(datas, function(a, b)
            return a:GetID() < b:GetID()
        end)
    end
    return datas
end

-- 获取指定id的关卡组信息
function this:GetDungeonGroupCfg(gid)
    if self.dungeonGroupCfgs and #self.dungeonGroupCfgs > 0 then
        for k, v in ipairs(self.dungeonGroupCfgs) do
            if v.id == gid then
                return v
            end
        end
    end
end

function this:GetMainSectionStar(id, hardLv)
    local sectionData = self.sectionDatas[id]
    local starNums = 0
    hardLv = hardLv or 1
    if sectionData then
        local _cfgs = sectionData:GetDungeonCfgs(hardLv)
        if _cfgs and #_cfgs > 0 then
            for _, _cfg in pairs(_cfgs) do
                if _cfg.sub_type ~= 1 then
                    local dungeonData = DungeonMgr:GetDungeonData(_cfg.id)
                    starNums = dungeonData == nil and starNums or starNums + dungeonData:GetStar()
                end
            end
        end
    end
    return starNums
end

function this:GetDungeonType(id)
    local dungeonData = self:GetDungeonData(id)
    if dungeonData and dungeonData:GetCfg() then
        return dungeonData:GetCfg().type
    end
    local cfg = Cfgs.MainLine:GetByID(id)
    return cfg and cfg.type
end

------------------------------------活动------------------------------------
function this:InitActivityOpenInfos()
    if self.ActiveOpenInfos == nil then
        self.ActiveOpenInfos = {}
        local cfgs = Cfgs.CfgActiveEntry:GetAll()
        if cfgs then
            for k, v in pairs(cfgs) do
                local info = DungeonOpenInfo.New()
                info:InitOpenCfg(v)
                self.ActiveOpenInfos[v.id] = info
            end
        end
    end
end

-- 添加活动开启信息 1-战场 2-剧情活动 3-讨伐活动
function this:AddActivityOpenInfo(proto)
    self:InitActivityOpenInfos()
    if proto and proto.id then
        if self.ActiveOpenInfos[proto.id] then
            self.ActiveOpenInfos[proto.id]:Init(proto)
        end
        EventMgr.Dispatch(EventType.Activity_Open_Refresh, proto.id)
    end
end

-- 获取所有活动开启信息
function this:GetActiveOpenInfos()
    return self.ActiveOpenInfos
end

-- 获取活动开启信息
function this:GetActiveOpenInfo(_id)
    return self.ActiveOpenInfos and self.ActiveOpenInfos[_id]
end

-- 获取活动开启信息 --章节id
function this:GetActiveOpenInfo2(_id)
    if self.ActiveOpenInfos then
        for k, v in pairs(self.ActiveOpenInfos) do
            if v:IsSelf(_id) then
                return v
            end
        end
    end
end

-- 活动开启
function this:IsActiveOpen(_id)
    local openInfo = self:GetActiveOpenInfo(_id)
    return openInfo and openInfo:IsOpen()
end

-- 活动开启 --章节id
function this:IsActiveOpen2(_id)
    local openInfo = self:GetActiveOpenInfo2(_id)
    return openInfo and openInfo:IsOpen()
end

-- 活动副本开启
function this:IsActiveDungeonOpen(_id)
    local openInfo = self:GetActiveOpenInfo(_id)
    return openInfo and openInfo:IsDungeonOpen()
end
-----------------------------------------------战斗中-----------------------------------------------
-- 使用默认队伍进入指定副本 默认为主线队伍1
function this:ApplyEnterByDefault(id)
    local defaultTeamID = 1;
    local list = {};
    local teamData = TeamMgr:GetTeamData(defaultTeamID);
    for k, v in ipairs(teamData.data) do
        local item = {
            cid = v.cid,
            row = v.row,
            col = v.col
        }
        local cardData = FormationUtil.FindTeamCard(v.cid);
        item.id = cardData:GetCfgID();
        item.index = v.index;
        item.nStrategyIndex = v:GetStrategyIndex();
        table.insert(list, item)
    end
    if list and #list > 6 then
        LogError("队伍数据有误！");
        LogError(teamData:GetData());
        return
    end
    TeamMgr:AddFightTeamData(teamData);
    UIUtil:AddFightTeamState(1, "DungeonMgr:ApplyEnterByDefault()")
    local duplicateTeamData = {
        nTeamIndex = teamData.index,
        team = list,
        nSkillGroup = teamData.skillGroupID
    }
    self:ApplyEnter(id, {defaultTeamID}, {duplicateTeamData});
end

function this:SetToCheckBattleFight()
    self.checkBattleFight = 1;
end

-- 进入副本
function this:ApplyEnter(id, indexList, duplicateTeamDatas,buffs)
    -- self.isContinueFightDungeon = self:GetCurrFightId() == id;
    indexList = indexList or {};
    duplicateTeamDatas = duplicateTeamDatas or {};
    -- 发送协议, 请求进入副本
    local data = {
        index = 1, -- 副本类型
        nDuplicateID = id, -- 副本id
        data = indexList, -- 队伍id
        list = duplicateTeamDatas, -- 编队信息
        selectBuffs = buffs -- 支援技能
    }
    local dungeonCfg = Cfgs.MainLine:GetByID(id);
    -- LogError(data.list)
    if (dungeonCfg and dungeonCfg.type == eDuplicateType.RogueS) then -- 直接进入战斗的副本
        FightProto:EnterRogueSFight()
    elseif (dungeonCfg and dungeonCfg.type == eDuplicateType.RogueT) then -- 直接进入战斗的副本
        FightProto:EnterRogueTFight(duplicateTeamDatas)
    elseif dungeonCfg and dungeonCfg.nGroupID ~= nil and dungeonCfg.nGroupID ~= "" then -- 直接进入战斗的副本
        self:SetFightTeamId(indexList[1]); -- 设置正在战斗中的队伍id

        self:SetCurrId(id)
        local groupCfg = Cfgs.MonsterGroup:GetByID(dungeonCfg.nGroupID);
        self:SetFightMonsterGroup(groupCfg);
        data.isMultiReward = self.isMultiReward -- 每日副本多倍奖励
        FightProto:EnterFightDuplicate(data)
    else
        FightProto:EnterDuplicate(data)
    end

    -- 副本消息超时提示
    EventMgr.Dispatch(EventType.Net_Msg_Wait, {
        msg = "fight",
        time = 5000,
        timeOutCallBack = function()
            local retryTime = DungeonMgr.retryTime or 0;
            local time = CSAPI.GetTime();
            if (time < retryTime + 10) then
                return;
            end
            DungeonMgr.retryTime = time;
            -- Tips.ShowTips("network delay!");      
            LogError(string.format("请求进入副本失败,id=%s,indexList=%s,duplicateTeamDatas=%s", id,
                table.tostring(indexList, true), table.tostring(duplicateTeamDatas, true)));
            DungeonMgr:ApplyEnter(id, indexList, duplicateTeamDatas);
        end
    });
end

-- 积分战斗
function this:ApplyBuffBattle(id, indexList, duplicateTeamDatas, buffs)
    indexList = indexList or {};
    duplicateTeamDatas = duplicateTeamDatas or {};
    -- 发送协议, 请求进入副本
    local data = {
        index = 1, -- 副本类型
        nDuplicateID = id, -- 副本id
        data = indexList, -- 队伍id
        list = duplicateTeamDatas, -- 编队信息
        buffs = buffs -- 选中的buff
    }
    local dungeonCfg = Cfgs.MainLine:GetByID(id);
    -- LogError(data.list)
    if dungeonCfg and dungeonCfg.nGroupID ~= nil and dungeonCfg.nGroupID ~= "" then -- 直接进入战斗的副本
        self:SetFightTeamId(indexList[1]); -- 设置正在战斗中的队伍id

        self:SetCurrId(id)
        local groupCfg = Cfgs.MonsterGroup:GetByID(dungeonCfg.nGroupID);
        self:SetFightMonsterGroup(groupCfg);
        data.isMultiReward = self.isMultiReward -- 每日副本多倍奖励
    end

    FightProto:EnterFightBuffBattleDuplicate(data)

    -- 副本消息超时提示
    EventMgr.Dispatch(EventType.Net_Msg_Wait, {
        msg = "fight",
        time = 5000,
        timeOutCallBack = function()
            local retryTime = DungeonMgr.retryTime or 0;
            local time = CSAPI.GetTime();
            if (time < retryTime + 10) then
                return;
            end
            DungeonMgr.retryTime = time;
            LogError(string.format("请求进入副本失败,id=%s,indexList=%s,duplicateTeamDatas=%s", id,
                table.tostring(indexList, true), table.tostring(duplicateTeamDatas, true)));
            DungeonMgr:ApplyBuffBattle(id, indexList, duplicateTeamDatas, buffs);
        end
    });
end

function this:ApplyDungeonFight(myOID, monsterOID)
    FightClient:Clean();

    local index = BattleMgr:GetDungeonIndex();
    local proto = {
        index = index,
        myOID = myOID,
        monsterOID = monsterOID,
        isMultiReward = self.isMultiReward
    };
    -- local proto = {index = index, myOID = myOID, monsterOID = monsterOID};
    FightProto:EnterFight(proto);
end

function this:EnterDungeon(proto)
    -- 不进副本，只是获取副本数据    
    if (self.gettingBattleData) then
        self.gettingBattleData = nil;
        BattleMgr:SetBattleData(proto)
        return;
    end

    self.currCompleteState = nil;
    for k, v in ipairs(proto.arrChar) do
        if v.type == 1 then -- 我方队伍
            TeamMgr:UpdateFightTeamData(v);
        end
    end
    -- LogError(proto);
    self.currId = proto.nDuplicateID;
    if (self.currId) then
        -- LogError("cc"..tostring(self.checkBattleFight));	
        if (self.checkBattleFight and self:TryEnterFighting(proto.arrChar)) then
            -- 有战斗进行中，直接进战斗
            BattleMgr:SetBattleData(proto)
        else
            if (not SceneMgr:IsBattleDungeon() or (proto and proto.nStep and proto.nStep == 0)) then
                BattleMgr:Reset();
                EventMgr.Dispatch(EventType.Scene_Load, "Battle");
                BattleMgr:PushData(proto, BattleMgr.Init);
            end
        end
    end

    self.checkBattleFight = nil;
end
-- 是否有战斗进行中
function this:TryEnterFighting(arr)
    if (not arr) then
        return;
    end

    --    local cacheBattleDatas = BattleMgr:GetDatas();
    --    if(cacheBattleDatas and #cacheBattleDatas > 0)then       
    --        return;
    --    end
    local playerTeamData = nil;
    local monsterTeamData = nil;

    for k, v in ipairs(arr) do
        if (v.state == eDungeonCharState.Fighting) then
            if v.type == 1 then -- 我方队伍
                if (monsterTeamData == nil or monsterTeamData.pos == v.pos) then
                    playerTeamData = v;
                    -- LogError("playerTeamData" .. table.tostring(playerTeamData));
                end
            else
                if (playerTeamData == nil or playerTeamData.pos == v.pos) then
                    monsterTeamData = v;
                    -- LogError("monsterTeamData" .. table.tostring(monsterTeamData));
                end
            end
        end
    end

    if (playerTeamData and monsterTeamData) then
        self:SetFightTeamId(playerTeamData.nTeamID); -- 设置正在战斗中的队伍id
        local groupCfg = Cfgs.MonsterGroup:GetByID(monsterTeamData.nMonsterGroupID);
        self:SetFightMonsterGroup(groupCfg);

        self:ApplyDungeonFight(playerTeamData.oid, monsterTeamData.oid);
        return true;
    end
end

-- 是否有战斗进行中
function this:HasFighting()
    local battleData = BattleMgr:GetBattleData()
    local arr = battleData and battleData.arrChar;

    if (not arr) then
        return false;
    end

    local playerTeamData = nil;
    local monsterTeamData = nil;

    for k, v in ipairs(arr) do
        if (v.state == eDungeonCharState.Fighting) then
            if v.type == 1 then -- 我方队伍
                if (monsterTeamData == nil or monsterTeamData.pos == v.pos) then
                    playerTeamData = v;
                    -- LogError("playerTeamData" .. table.tostring(playerTeamData));
                end
            else
                if (playerTeamData == nil or playerTeamData.pos == v.pos) then
                    monsterTeamData = v;
                    -- LogError("monsterTeamData" .. table.tostring(monsterTeamData));
                end
            end
        end
    end

    if (playerTeamData and monsterTeamData) then
        return true;
    end

    return false;
end

-- 战斗中的副本是否继续进行的（该副本进行中）
-- function this:IsContinueFightDungeon()
--    return self.isContinueFightDungeon;
-- end
function this:SetFightTeamId(fightTeamId)
    self.fightTeamId = fightTeamId;
end
function this:GetFightTeamId()
    return self.fightTeamId;
end

-- 缓存结算队伍信息
-- function this:SetRewardTeam(data)
-- 	if data then
-- 		local posData = {};
-- 		local fuid = nil;
-- 		local leaderID = nil;
-- 		for k,val in ipairs(data.data.data) do
-- 			local v=val.data
-- 			local item = {
-- 				cid = v.cuid,
-- 				row = v.row,
-- 				col = v.col,
-- 				fuid = v.fuid,
-- 				index = v.index,
-- 			};
-- 			if v.fuid then
-- 				item.cid = FormationUtil.FormatAssitID(v.fuid, v.cuid);
-- 				fuid = v.fuid;
-- 			elseif v.npcid then
-- 				item.bIsNpc = true;
-- 			end
-- 			if v.isLeader or v.index==1 then
-- 				leaderID = v.cuid;
-- 			end
-- 			table.insert(posData, item);
-- 		end
-- 		local currTeam = TeamMgr:GetTeamData(data.teamID);
-- 		local teamData = {
-- 			index = data.teamID,
-- 			leader = leaderID,
-- 			name = currTeam == nil and "" or currTeam.teamName,
-- 			data = posData,
-- 		};
-- 		self.rewardTeam = TeamData.New();
-- 		self.rewardTeam:SetData(teamData);
-- 		Log("RewardTeam");
-- 		Log(self.rewardTeam:GetData());
-- 	end
-- end
-- function this:GetRewardTeam()
-- 	return self.rewardTeam or nil;
-- end
-- 当前战斗的副本ID
function this:SetCurrFightId(id)
    self.currFightId = id;
end

-- 返回当前战斗的副本ID
function this:GetCurrFightId()
    return self.currFightId;
end

-- 返回当前战斗中的章节ID
function this:GetCurrFightSectionId()
    if self.currFightId then
        local cfgDungeon = Cfgs.MainLine:GetByID(self.currFightId);
        if cfgDungeon then
            return cfgDungeon.group;
        end
    end
    return nil;
end

-- 获取当前进行中的副本的配置
function this:GetCurrDungeonCfg()
    return Cfgs.MainLine:GetByID(self:GetCurrId());
end
-- 是否教程副本
function this:IsTutorialDungeon()
    local cfg = self:GetCurrDungeonCfg();
    return cfg and cfg.type == 4; -- 教程类型
end

-- 获取当前副本ID
function this:GetCurrId()
    return self.currId;
end

-- 获取当前副本ID
function this:SetCurrId(id)
    self.currId = id;

    if (id) then
        local dungeonCfg = Cfgs.MainLine:GetByID(id);
        if dungeonCfg.nGroupID ~= nil and dungeonCfg.nGroupID ~= "" then -- 直接进入战斗的副本
            return;
        end

        local battleData = BattleMgr:GetBattleData();
        if (not battleData and not self.gettingBattleData) then
            self:QueryDungeonData();
        end
    else
        BattleMgr:SetBattleData();
    end
end

-- 用于选关界面的寻路设置
function this:SetCurrId1(_id)
    self.currId = _id
end

function this:QueryDungeonData()
    if (self.currId) then
        self.gettingBattleData = 1;
        DungeonMgr:ApplyEnter(self.currId);
    end
end

-- 获取战棋副本数据
function this:GetBattleDungeonData(dungeonId)
    self.battleDungeonDatas = self.battleDungeonDatas or {};
    if (self.battleDungeonDatas[dungeonId] == nil) then
        self.battleDungeonDatas[dungeonId] = require("Dungeon_" .. dungeonId);
    end

    return self.battleDungeonDatas[dungeonId];
end

-- 当前副本是否为剧情关卡
function this:IsCurrStory()
    local targetId = self:GetCurrId();
    local cfgDungeon = targetId and Cfgs.MainLine:GetByID(targetId);
    return cfgDungeon and cfgDungeon.sub_type == DungeonFlagType.Story;
end

----------------------------------------战斗后返回--------------------------------------------------
-- 副本结束
function this:SetDungeonOver(dungeonOverData)
    if dungeonOverData and dungeonOverData.bIsWin then
        self.isFirst = true;
        self.isWin = true
        local dungeonData = self.dungeonDatas[self:GetCurrId()]
        if dungeonData ~= nil and dungeonData.data ~= nil and dungeonData.data.star ~= nil then
            self.isFirst = dungeonData.data.star == 0;
        elseif not dungeonOverData.fisrtPassReward then
            self.isFirst = false
        end
        local data = {
            id = self:GetCurrId(),
            star = dungeonOverData.star,
            data = dungeonOverData.data, -- 通关条件
            isHisPass = dungeonOverData.star > 0 -- 用于图鉴检测通关
        }
        -- 星数覆盖
        local star = data.star
        if dungeonData and dungeonData:GetStar() then
            star = star < dungeonData:GetStar() and dungeonData:GetStar() or star
        end
        data.star = star

        self:AddDungeonData(data);
        
        local cfg = Cfgs.MainLine:GetByID(self:GetCurrId())
        if cfg and cfg.type == eDuplicateType.SkinPass then
            OperationActivityMgr:CheckRedSkinPassPointData()
        end

        PlayerProto:DuplicateModUpData(self:GetCurrId()) -- 获取扫荡数据
        DungeonBoxMgr:CheckRedPointData() -- 关卡结束红点刷新
        MenuMgr:UpdateDatas() -- 刷新关卡解锁状态
        EventMgr.Dispatch(EventType.Update_Dungeon_Data)
        if self.isFirst then -- 只在第一次通关时刷新
            -- ArchiveMgr:CheckRedPoint(ArchiveType.Enemy) --解锁敌人图鉴刷新
        end
    end
    self.currCompleteState = 1;
    -- FriendMgr:ClearAssistData(); --清空助战缓存
    -- TeamMgr:ClearFightTeamData();--清空战斗中的队伍数据
    DungeonMgr:ClearDragList();

    BattleMgr:Clear();

    EventMgr.Dispatch(EventType.RedPoint_Refresh)
end

-- 当前副本是否结束
function this:IsCurrDungeonComplete()
    return self.currCompleteState;
end

-- 当前副本是否第一次通关
function this:GetCurrDungeonIsFirst()
    return self.isFirst;
end

-- 更改当前副本第一次通关状态
function this:SetCurrDungeonNoFirst()
    self.isFirst = false
end

-- 当前副本是否是通关返回
function this:GetCurrDungeonIsWin()
    if self.isWin then
        self.isWin = false
        return true
    end
    return false;
end

-- 回到主场并打开副本界面
function this:Quit(isExit, jumpType, callBack)
    DebugLog("副本结束退出，回到副本选择界面");
    SceneLoader:Load("MajorCity", function()
        -- MenuMgr:UpdateData()
        -- if(not MenuMgr:CheckOpenList()) then --如果存在功能解锁则不跳转
        self:OnQuit(isExit, jumpType);
        -- end
        if callBack then
            callBack()
        end
    end)
    -- EventMgr.Dispatch(EventType.Scene_Load,"MajorCity");
end
function this:OnQuit(isExit, jumpType)
    -- 引导忽略自动打开逻辑
    if (GuideMgr:HasMenuGuide()) then
        return;
    end

    if jumpType then -- 优先跳转
        Log(jumpType);
        if jumpType == 1 then
            JumpMgr:Jump(40001);
        elseif jumpType == 2 then
            JumpMgr:Jump(40001);
        elseif jumpType == 3 then
            JumpMgr:Jump(40001);
        elseif jumpType == 4 then
            JumpMgr:Jump(80002);
        end
        if jumpType < 5 then
            return
        end
    end

    isExit = isExit ~= nil and isExit or false;
    local cfg = Cfgs.MainLine:GetByID(self.currId)
    if cfg then
        local path1, path2 = DungeonUtil.GetViewPath(cfg.group)
        if DungeonMgr:GetDungeonSectionType(self.currId) == SectionType.Daily then
            CSAPI.OpenView("Section", {
                type = 2,
                group = cfg.group,
                id = cfg.id
            });
        elseif DungeonMgr:GetDungeonSectionType(self.currId) == SectionType.Activity then
            CSAPI.OpenView("Section", {
                type = 4
            });
            if cfg.type == eDuplicateType.Tower or cfg.type == eDuplicateType.EternalBattle then -- 爬塔
                CSAPI.OpenView(path1, {
                    id = cfg.group,
                    itemId = cfg.id
                })
            elseif cfg.type == eDuplicateType.BattleField then -- 战场
                CSAPI.OpenView(path1, {
                    id = cfg.group
                })
            elseif cfg.type == eDuplicateType.StoryActive then -- 剧情
                CSAPI.OpenView(path1, {
                    id = cfg.group
                }, {
                    isDungeonOver = true
                })
                CSAPI.OpenView(path2, {
                    id = cfg.group,
                    itemId = cfg.id
                }, {
                    isDungeonOver = true
                })
            elseif cfg.type == eDuplicateType.TaoFa then -- 讨伐
                local sectionData = self:GetSectionData(cfg.group)
                if sectionData and sectionData:GetType() == SectionActivityType.Trials then
                    CSAPI.OpenView("TrialsMenu")
                end
                CSAPI.OpenView(path1, {
                    id = cfg.group,
                    itemId = cfg.id
                }, {
                    isDungeonOver = true
                })
                if path2 and path2 ~= "" then -- 试炼
                    CSAPI.OpenView(path2, {
                        id = cfg.group,
                        itemId = cfg.id
                    }, {
                        isDungeonOver = true
                    })
                end
            elseif cfg.type == eDuplicateType.NewTower then
                CSAPI.OpenView("TowerView") -- 默认最新关卡        
                local datas = DungeonMgr:GetActivitySectionDatas(SectionActivityType.NewTower)
                if #datas > 0 then
                    for i, v in ipairs(datas) do
                        if v:GetID() == cfg.group then
                            CSAPI.OpenView("TowerListView", {
                                id = cfg.group
                            }, i)
                            break
                        end
                    end
                end
            elseif cfg.type == eDuplicateType.StarPalace then
                CSAPI.OpenView(path1, {
                    id = cfg.group,
                    itemId = cfg.id
                }, {
                    isDungeonOver = true
                })
            elseif cfg.type == eDuplicateType.MultTeam then -- 递归沙盒
                CSAPI.OpenView(path1, {
                    id = cfg.group
                })
            elseif cfg.type == eDuplicateType.TowerDeep then
                CSAPI.OpenView(path1, {
                    id = cfg.group
                })
            elseif cfg.type == eDuplicateType.ChainFront then
                CSAPI.OpenView("TrialsMenu")
                local openInfo2 = self:GetActiveOpenInfo2(cfg.group)
                if openInfo2 and openInfo2:IsOpen() then
                    CSAPI.OpenView(path1, {
                        id = cfg.group,
                        groupId = cfg.dungeonGroup
                    })
                end
            elseif cfg.type == eDuplicateType.PeriodicBoss then
                CSAPI.OpenView(path1, {
                    id = cfg.group
                })
            elseif cfg.type == eDuplicateType.CrossBoss then
                CSAPI.OpenView(path1, {
                    id = cfg.group,
                    itemId = cfg.id
                })
            else
                CSAPI.OpenView(path1)
            end
        elseif DungeonMgr:GetDungeonSectionType(self.currId) == SectionType.Course then
            CSAPI.OpenView("CourseView", 1)
        elseif DungeonMgr:GetDungeonSectionType(self.currId) == SectionType.Colosseum then
            CSAPI.OpenView("Section", {
                type = 3
            })
            ColosseumMgr:Quit(self.currId)
            self:SetCurrId()
            return
        elseif DungeonMgr:GetDungeonSectionType(self.currId) == SectionType.Other then
            if cfg.type == eDuplicateType.SkinPass then
                CSAPI.OpenView("SkinPassList", {
                    dungeonId = cfg.id
                })
            else
                local sectionData = self:GetSectionData(cfg.group)
                if sectionData then
                    if sectionData:GetType() == SectionActivityType.StoryCollection then
                        CSAPI.OpenView("ArchiveView")
                        CSAPI.OpenView("StoryCollection",{id = sectionData:GetID()})
                        CSAPI.OpenView("StoryCollectionList",{id = sectionData:GetID(),itemId = cfg.id},{isDungeonOver = true})
                    end
                end
            end
        else -- 主线章节
            if isExit and self.currFightId then
                -- 回到战斗中的章节
                local id = self:GetCurrFightSectionId();
                if id then
                    CSAPI.OpenView("Section", {
                        type = 1
                    })
                    CSAPI.OpenView("Dungeon", {
                        id = id
                    });
                end
            else
                local currSection = self:GetCurrSectionData();
                if currSection then
                    -- 设置打开界面后的状态
                    local _state = self:GetCurrDungeonIsWin() and DungeonOpenType.Finish or DungeonOpenType.Retreat
                    if _state == DungeonOpenType.Finish then
                        _state = self:GetCurrDungeonIsFirst() and DungeonOpenType.Normal or DungeonOpenType.Finish
                    end
                    CSAPI.OpenView("Section", {
                        type = 1
                    })
                    CSAPI.OpenView("Dungeon", {
                        id = currSection:GetID(),
                        state = _state
                    });
                end
            end
        end
        -- if cfg.dungeonGroup then
        --     local groupData= DungeonMgr:GetDungeonGroupData(cfg.dungeonGroup)
        --     if groupData and groupData:IsEx() then --积分战斗
        --         CSAPI.OpenView("BuffBattle",{id = groupData:GetID()})
        --     end
        -- end
    end

    if jumpType and (jumpType == 5 or jumpType == 6 or jumpType == 7) then -- 失败重开或下一关
        local cfgDungeon = Cfgs.MainLine:GetByID(self.currId)
        local OnFightOverCB = nil
        if jumpType == 6 then -- 模拟
            OnFightOverCB = function(stage, winer, nDamage)
                if self.currId then
                    DungeonMgr:SetCurrId1(self.currId)
                end
                FightOverTool.OnDirllOver(stage, winer)
            end
        elseif jumpType == 7 and cfgDungeon and cfgDungeon.lasChapterID then -- 下一关
            cfgDungeon =
                DungeonMgr:IsDungeonOpen(cfgDungeon.id) and Cfgs.MainLine:GetByID(cfgDungeon.lasChapterID[1]) or
                    cfgDungeon
        end
        if cfgDungeon then
            if cfgDungeon.type == eDuplicateType.SkinPass then
                CSAPI.OpenView("SkinPassTeam", {
                    dungeonId = cfgDungeon.id
                })
            elseif cfgDungeon.type == eDuplicateType.ChainFront then
                if TrialsMgr:IsFighting() then
                    CSAPI.OpenView("Trials2Team", cfgDungeon.dungeonGroup)
                end
            elseif cfgDungeon.arrForceTeam ~= nil then -- 强制上阵编队
                CSAPI.OpenView("TeamForceConfirm", {
                    dungeonId = cfgDungeon.id,
                    teamNum = cfgDungeon.teamNum or 1
                })
            else
                local type = TeamConfirmOpenType.Dungeon
                local _disChoosie = false
                local _isNotAssist = false
                if cfgDungeon.type == eDuplicateType.NewTower or cfgDungeon.type == eDuplicateType.EternalBattle then
                    type = TeamConfirmOpenType.Tower
                    _disChoosie = true
                    _isNotAssist = cfgDungeon.type == eDuplicateType.EternalBattle
                elseif cfgDungeon.type == eDuplicateType.Rogue then
                    type = TeamConfirmOpenType.Rogue
                    _disChoosie = true
                end
                CSAPI.OpenView("TeamConfirm", { -- 正常上阵
                    dungeonId = cfgDungeon.id,
                    teamNum = cfgDungeon.teamNum or 1,
                    isDirll = OnFightOverCB ~= nil,
                    disChoosie = _disChoosie,
                    overCB = OnFightOverCB,
                    isNotAssist = _isNotAssist,
                }, type)
            end
        end
    end
    self:SetCurrId()
end

-- 申请退出副本
function this:SendToQuit()
    local currId = self:GetCurrId();
    if (currId) then
        FightProto:QuitDuplicate({
            index = 1,
            nDuplicateID = currId
        });
    end
    -- self:SetCurrId()
end

-- 战斗结束数据
function this:FightOver(proto)
    if (FightActionUtil:HangupFightResult(proto)) then
        return;
    end
    local isSurrender = FightClient:IsSurrender();
    FightOverTool.OnDuplicate(proto, isSurrender);
    self:SetCurrFightId(); -- 清除正在战斗中的副本
    -- self:UpdateDupGrade(proto.id, proto.star, proto.nDupGrade);
end
-- 获取战斗结束
-- function this:GetFightOverData(proto)
--	return self.fightOverData;
-- end
-- 设置战斗的怪物组配置数据
function this:SetFightMonsterGroup(cfgFightMonsterGroup)
    self.cfgFightMonsterGroup = cfgFightMonsterGroup;
end
-- 获取战斗的怪物组配置数据
function this:GetFightMonsterGroup()
    return self.cfgFightMonsterGroup;
end

function this:Init()
    self:InitSectionDatas();
    FileUtil.SaveToFile("CurrID.txt", {
        id = 0
    }) -- 初始化本地缓存
    self:InitDungeonGroupDatas()
    PlayerProto:SectionMultiInfo();
end

-- 获取界面打开设置
function this:GetViewOpenSetting()
    self.viewOpenSetting = self.viewOpenSetting or {};
    return self.viewOpenSetting;
end

-- 缓存章节界面的滑动进度，重新进入之后会消失
function this:SetDungeonViewOffset(offset)
    self.dungeonOffset = offset or 0;
end

-- 返回章节界面的滑动进度
function this:GetDungeonViewOffset()
    return self.dungeonOffset or 0;
end

function this:GetHardPath()
    return "Dungeon_HardInfo_" .. PlayerClient:GetUid() .. ".txt"
end

-- 设置章节难度 id:sectionId
function this:SetDungeonHardLv(id, hardlv)
    if not id then
        return
    end
    if self.hardInfo == nil then
        self.hardInfo = FileUtil.LoadByPath(self:GetHardPath()) or {}
    end
    self.hardInfo[id] = hardlv
    FileUtil.SaveToFile(self:GetHardPath(id), self.hardInfo)
end

function this:GetDungeonHardLv(id)
    if self.hardInfo == nil then
        self.hardInfo = FileUtil.LoadByPath(self:GetHardPath()) or {}
    end
    return self.hardInfo[id] or 1
end

-- 返回当前关卡的特殊通关条件描述
function this:GetPassDesc(id)
    local str = ""
    local currId = id or self:GetCurrId()
    if currId then
        local dungeonCfg = Cfgs.MainLine:GetByID(currId);
        if dungeonCfg and dungeonCfg.jWinCon then
            local type = dungeonCfg.jWinCon[1];
            local paramStr = "";
            if type == 3 or type == 5 then
                paramStr = dungeonCfg.jWinCon[2];
            elseif type == 4 then
                for k, v in ipairs(dungeonCfg.jWinCon[2]) do
                    local cardInfo = Cfgs.CardData:GetByID(v);
                    if cardInfo then
                        local num = dungeonCfg.jWinCon[3] == nil and 1 or dungeonCfg.jWinCon[3];
                        paramStr =
                            k > 1 and paramStr .. "X" .. num .. "、" .. cardInfo.name or paramStr .. "X" .. num ..
                                cardInfo.name;
                    end
                end
            end
            local winCons = {27029, 15050, 15051, 15052, 15053, 15054}
            str = LanguageMgr:GetByID(winCons[type], paramStr)
        end
    end
    return str;
end

-- 战斗界面中改变站位的列表
function this:SetDragList(dragList)
    self.dragList = dragList;
end

function this:GetDragList()
    return self.dragList;
end

function this:ClearDragList()
    self.dragList = nil;
end

function this:ClearGettingBattleData()
    self.gettingBattleData = nil;
end

-- 记录AI战斗
function this:AddAIFightRewards(rewards)
    self.AIRewards = self.AIRewards or {};
    if rewards ~= nil then
        for key, val in ipairs(rewards) do
            if val.type == RandRewardType.ITEM or val.type == null then
                local info = self.AIRewards[val.id];
                if info == nil then
                    self.AIRewards[val.id] = val;
                else
                    info.num = info.num + val.num;
                end
            else
                self.AIRewards[val.c_id] = val;
            end
        end
    end
end

function this:GetAIFightRewards()
    local list = nil;
    if self.AIRewards then
        list = {};
        for key, val in pairs(self.AIRewards) do
            table.insert(list, val);
        end
    end
    return list;
end

function this:ClearAIFightInfo()
    self.AIRewards = nil;
    self.AIDungeonInfo = nil;
end

function this:AddAutoDungeonInfo(dungeonId, teams)
    self.AIDungeonInfo = {};
    self.AIDungeonInfo.id = dungeonId;
    self.AIDungeonInfo.teams = teams;
end

-- 当前战斗的副本是否是主线
function this:CurrSectionIsMainLine()
    local sectionData = self:GetCurrSectionData();
    if self.currId and DungeonMgr:GetDungeonSectionType(self.currId) == SectionType.MainLine then
        return true;
    end
    return false;
end

-- 获取当前副本类型
function this:GetCurrDungeonType()
    if self.currId then
        local cfgDungeon = Cfgs.MainLine:GetByID(self.currId)
        return cfgDungeon and cfgDungeon.type
    end
    return nil
end

function this:GetAutoDungeonInfo()
    return self.AIDungeonInfo;
end

function this:LoadNaviConfig()
    return FileUtil.LoadByPath("NaviConfig.txt");
end

function this:SaveNaviConfig(tab)
    if tab then
        FileUtil.SaveToFile("NaviConfig.txt", tab);
    end
end

function this:ShowAIMoveBtn(isShow)
    PlayerPrefs.SetInt("AIMove_ShowBtn", isShow and 1 or 0)
end

function this:AIMoveBtnShow()
    return PlayerPrefs.GetInt("AIMove_ShowBtn") > 0
end

-- 第一次提示双倍开启
function this:GetFisrtOpenDouble()
    return self.firstOpenDouble
end

function this:SetFisrtOpenDouble(b)
    self.firstOpenDouble = b
end

---------------------------------------------red---------------------------------------------
function this:CheckRedPointData()
    local isMainRed = DungeonMgr:IsMainLineRed()
    local isDaily = DungeonMgr:IsDailyRed()
    local isExercise = DungeonMgr:IsExerciseRed()
    local isActivity = DungeonMgr:IsActivityRed(true)

    DungeonMgr:CheckRedChange(RedPointType.Attack, isMainRed or isDaily or isExercise or isActivity)
    DungeonMgr:CheckRedChange(RedPointType.SectionMain, isMainRed)
    DungeonMgr:CheckRedChange(RedPointType.SectionDaily, isDaily)
    DungeonMgr:CheckRedChange(RedPointType.SectionExercise, isExercise)
    DungeonMgr:CheckRedChange(RedPointType.SectionActivity, isActivity)
end

function this:IsActivityRed(isUpdate)
    local isRed = DungeonMgr:CheckActivityRed(isUpdate)
    if not isRed then
        local sectionDatas = DungeonActivityMgr:GetSectionDatasByType(true)
        if #sectionDatas > 0 then
            for type, datas in ipairs(sectionDatas) do
                if datas[1]:GetOpen() then
                    if type == SectionActivityType.Rogue and
                        (RogueMgr:IsRed() or RogueSMgr:IsRed() or RogueTMgr:IsRed()) then
                        isRed = true
                        break
                    elseif type == SectionActivityType.GlobalBoss and GlobalBossMgr:IsRed() then
                        isRed = true
                        break
                    elseif type == SectionActivityType.MultTeamBattle and MultTeamBattleMgr:IsRed() then
                        isRed = true
                        break
                    elseif type == SectionActivityType.TotalBattle and MissionMgr:CheckRed({eTaskType.StarPalace}) then
                        isRed = true
                        break
                    elseif type == SectionActivityType.Tower and TowerMgr:IsTowerRed() then
                        isRed = true
                        break
                    end
                end
            end
        end
    end
    return isRed
end

function this:CheckActivityRed(isUpdate)
    local isRed = false
    local openInfos = self:GetActiveOpenInfos()
    if openInfos then
        for k, info in pairs(openInfos) do
            if info:IsOpen() and info:CheckIsRed() then
                local cfg = info:GetCfg()
                if cfg and cfg.sectionID then
                    local openCfg = info:GetOpenCfg()
                    local redData1 = RedPointMgr:GetData("ActiveEntry" .. openCfg.id)
                    local redData2 = DungeonActivityMgr:CheckRed(cfg.sectionID) and 1 or nil
                    if redData1 ~= redData2 and isUpdate then
                        RedPointMgr:UpdateData("ActiveEntry" .. openCfg.id, redData2)
                    end
                    if not isRed and redData2 ~= nil then
                        isRed = true
                    end
                end
            end
        end
    end
    return isRed
end

function this:IsMainLineRed()
    return DungeonBoxMgr:CheckRed()
end

function this:IsExerciseRed()
    local isRed = false

    -- 角斗场
    local isOpen = MenuMgr:CheckModelOpen(OpenViewType.main, "ExerciseLView")
    local sectionData = DungeonMgr:GetSectionData(13001)
    if isOpen and sectionData and sectionData:GetOpen() then
        isRed = ColosseumMgr:IsRed()
    end

    return isRed
end

function this:IsDailyRed()
    return false
end

function this:CheckRedChange(redType,b)
    if not redType then
        return
    end
    local redData = RedPointMgr:GetData(redType)
    local redData2 = b and 1 or nil
    if redData ~= redData2 then
        RedPointMgr:UpdateData(redType, redData2)
    end
end

---------------------------------------------new---------------------------------------------
-- 获取new 
function this:GetIsNew(id)
    if not self:IsDungeonOpen(id) then
        return false
    end
    local newInfo = FileUtil.LoadByPath("Dungeon_new_Info" .. PlayerClient:GetUid() .. ".txt") or {}
    if not newInfo[id] then
        return true
    end
    return newInfo[id] == 1
end

-- 设置new
function this:SetIsNew(id, b)
    if id == nil then
        return
    end
    local newInfo = FileUtil.LoadByPath("Dungeon_new_Info" .. PlayerClient:GetUid() .. ".txt") or {}
    newInfo[id] = b and 1 or 0
    FileUtil.SaveToFile("Dungeon_new_Info" .. PlayerClient:GetUid() .. ".txt", newInfo)
end

---------------------------------------------活动门票---------------------------------------------

function this:SetArachnidCount(proto)
    if proto and proto.can_buy_cnt then
        self.ArachnidCount = self.ArachnidCount or {}
        self.ArachnidCount[proto.sectionId] = proto.can_buy_cnt
    end
    EventMgr.Dispatch(EventType.Arachnid_Count_Refresh)
end

function this:GetArachnidCount(sid)
    return self.ArachnidCount and self.ArachnidCount[sid] or 0
end

function this:Clear()
    self.dragList = nil;
    self.dungeonHardLv = 1;
    self.dungeonOffset = 0;
    self.viewOpenSetting = {};
    self.cfgFightMonsterGroup = {};
    self.multiInfo = nil;
    self.limitMultiInfo = nil
    self.dungeonDatas = nil;
    self.dailyData = nil;
    self.multiUpdateTime = nil
    self.sectionDatas = nil;
    self.currCompleteState = nil;
    self.isFirst = false;
    self.isWin = false;
    self.currId = nil;
    self.fightTeamId = nil;
    self.currFightId = nil;
    self.battleDungeonDatas = nil;
    self.rewardTeam = nil;
    self.isMultiReward = false;
    self.isApplyEnter = false
    self.dungeonGroupDatas = nil
    self.ActivityPlotDatas = nil
    self.hardInfo = nil
    self.ActiveOpenInfos = nil
    self.ArachnidCount = {}
end

return this;
