RogueMapMgr = MgrRegister("RogueMapMgr")
RogueMapData = require "RogueMapData"
local this = RogueMapMgr

function this:Init()
    self:Clear()
    self:InitCfgs()
    FightProto:GetRogueMapInfo()
end

function this:Clear()
    self.exp = nil
    self.rollCount = nil
    self.isDungeonOver = false
    self.datas = {}
    self.assists = nil
    self.cfgFloatFonts = nil
    self.logs = nil
    self.logRefreshTime = nil
    self.rogueMapLvCB = nil
    self.isLastFightDirll = false
    self.assistDungeonId = false
    self.isRewardRed = false
    self.isAssistNew = false
    self.isLogNew = false
    self.assistRewardInfos = nil -- 支援奖励
    self.supports = nil
    self.friendTime = 0
    self:ClearDungeon()
end

function this:ClearDungeon()
    self.dungeonId = nil
    self.teamFightID = nil
    self.canRoll = nil
    self.buffs = nil
    self.stepNum = nil
    self.fightLv = nil
    self.fightExp = nil
    self.battleHelpInfo = nil
    self.needShowSupport = false
    self.needShowPass = false
    self.lockLevel = false
end

function this:InitCfgs()
    self.lvCfgs = {}
    local cfgs = Cfgs.CfgRogueMapLevel:GetAll()
    for _, cfg in ipairs(cfgs) do
        table.insert(self.lvCfgs, cfg)
    end
    if #self.lvCfgs > 0 then
        table.sort(self.lvCfgs, function(a, b)
            return a.id < b.id
        end)
    end
end

-- 获取小地图全局配置信息
function this:GetGlobal(key)
    local cfg = Cfgs.CfgRogueMapGlobal:GetByID(key)
    if cfg and cfg.value then 
        if cfg.type == "int[]" then
            local list = {}
            local ss = StringUtil:Split(cfg.value,',')
            for i, v in ipairs(ss) do
                table.insert(list,tonumber(v))
            end
            return list
        elseif cfg.type == "int" then 
            return tonumber(cfg.value)
        end
    end
    return nil
end

------------------------------------副本相关------------------------------------
function this:SetDatas(proto)
    if proto then
        self.maxDungeonId = proto.maxDupId
        self.rollCount = proto.rollCnt
        self.fightDungeonId = proto.nDuplicateID
        self.exp = proto.nDupExp
        self.isRewardRed = proto.hasRewardBubble
        self.isAssistNew = proto.hasSupportBubble
        self.requireNum = proto.nRequireTimes
        if proto.groupData then
            for i, v in ipairs(proto.groupData) do
                if not self.datas[v.id] then
                    local data = RogueMapData.New()
                    data:Init(v)
                    self.datas[v.id] = data
                else
                    self.datas[v.id]:Init(v)
                end
            end
        end
    end
    EventMgr.Dispatch(EventType.RogueMap_Update)
end

function this:GetData(id)
    if not id then
        return
    end
    local data = self.datas[id]
    if not data then
        data = RogueMapData.New()
        data:Init({
            id = id
        })
        self.datas[id] = data
    end
    return data
end

function this:GetArr(sid)
    local cfgs = Cfgs.DungeonGroup:GetGroup(sid)
    local datas = {}
    if cfgs then
        for _, cfg in pairs(cfgs) do
            table.insert(datas,self:GetData(cfg.id))
        end
    end
    if #datas > 0 then
        table.sort(datas,function (a,b)
            return a:GetID() < b:GetID()
        end)
    end
    return datas
end

-- 申请进入副本
function this:ApplyEnter(id, duplicateTeamDatas, isSimulated)
    duplicateTeamDatas = duplicateTeamDatas or {};
    isSimulated = isSimulated or false
    -- 发送协议, 请求进入副本
    local data = {
        nDuplicateID = id, -- 副本id
        -- isSimulated = isSimulated, -- 模拟
        list = duplicateTeamDatas -- 编队信息
    }
    local dungeonCfg = Cfgs.MainLine:GetByID(id);

    FightProto:EnterRogueMapDuplicate(data)

    -- 副本消息超时提示
    EventMgr.Dispatch(EventType.Net_Msg_Wait, {
        msg = "rogueMap_fight",
        time = 5000,
        timeOutCallBack = function()
            local retryTime = RogueMapMgr.retryTime or 0;
            local time = CSAPI.GetTime();
            if (time < retryTime + 10) then
                return;
            end
            RogueMapMgr.retryTime = time;
            LogError(string.format("请求进入副本失败,id=%s,indexList=%s,duplicateTeamDatas=%s", id,
                table.tostring(indexList, true), table.tostring(duplicateTeamDatas, true)));
            RogueMapMgr:ApplyEnter(id, duplicateTeamDatas, isSimulated);
        end
    });
end

-- 进入副本
function this:EnterDungeon(proto)
    -- LogError("进入秘境探索副本" .. table.tostring(proto))
    self.dungeonId = proto.nDuplicateID
    self.isSimulated = proto.isSimulated
    self.canRoll = proto.canRoll
    self.stepNum = proto.nStep
    self:UpdateBuff(proto.buffs)
    self:UpdateLevel(proto.nExp, true)
    self.isDungeonOver = false
    self.fightDungeonId = proto.nDuplicateID
    self.needShowSupport = proto.supportWindow
    self.requireNum = proto.nRequireTimes
    self.needShowPass = proto.passWindow
    self.lockLevel = proto.lockLevel
    for k, v in ipairs(proto.arrChar) do
        TeamMgr:UpdateFightTeamData(v);
    end
    if not SceneMgr:IsRogueMapDungeon() then
        RogueMapBattleMgr:Reset()
        EventMgr.Dispatch(EventType.Scene_Load, "RogueMap")
        RogueMapBattleMgr:PushData(proto, RogueMapBattleMgr.Init)
    end
end

-- 进入战斗
function this:ApplyFight(teamId, pos,isSimulated)
    self.teamFightID = teamId
    FightClient:Clean();
    FightProto:RogueMapEnterFight(teamId, pos,isSimulated)
end

function this:ApplyAssistFight(assistData,team)
    if not assistData or not team then
        return
    end
    self.assistDungeonId = assistData:GetDungeonId()
    local cfgDungeon = assistData:GetDungeonCfg()
    local data = {
        uid = assistData:GetUID(),
        s_ix = assistData:GetIndex(),
        list = {team},
        group = cfgDungeon and cfgDungeon.group
    }
    FightProto:RogueMapSupportApply(data)
end

-- 申请退出副本
function this:ApplyQuit()
    FightProto:RogueMapQuit()
end

function this:ApplyAssistQuit()
    SceneLoader:Load("MajorCity", function()
        self:BackToView(self.assistDungeonId,true)
    end)
end

-- 退出
function this:Quit(proto)
    self.isDungeonOver = true
    self.stepNum = proto.nStep
    self.exp = proto.nDupExp or self.exp
    if proto.isPass then
        local data = {
            id = self.fightDungeonId,
            star = 1,
            isHisPass = 1 --用于图鉴检测通关
        }
        DungeonMgr:AddDungeonData(data)
    end
    if proto.reward then --首通
        for k, v in ipairs(proto.reward) do
            v.tag = ITEM_TAG.FirstPass
        end
    end
    self.fightDungeonId = nil
    local data = {
        sceneType = SceneType.RogueMap,
        rewards = proto.reward,
        nExp = proto.nExp,
        bIsWin = proto.isPass
    }
    FightOverTool.OnRogueMapDungeonOver(data)
    -- self:SendToQuit()
end

-- 返回选关界面
function this:SendToQuit()
    local currID = self.dungeonId
    self:ClearDungeon()
    FriendMgr:ClearAssistData();
    TeamMgr:ClearAssistTeamIndex();
    TeamMgr:ClearFightTeamData();
    SceneLoader:Load("MajorCity", function()
        self:BackToView(currID)
    end)
end

--回到相关界面，isAssist：助战界面
function this:BackToView(dungeonId,isAssist)
    CSAPI.OpenView("Section",{type = 4})
    local cfg= Cfgs.MainLine:GetByID(dungeonId)
    if cfg then
        local path1,path2 = DungeonUtil.GetViewPath(cfg.group)
        CSAPI.OpenView(path1,{id = cfg.group})
        if isAssist then
            EventMgr.Dispatch(EventType.Net_Msg_Wait, {
                msg = "rogueMap_assist_open",
                time = 5000,
                timeOutCallBack = function()
                    isRequire = false
                    LanguageMgr:ShowTips(1008)
                end
            });
            FightProto:RogueMapSupportList(cfg.group,function ()
                EventMgr.Dispatch(EventType.Net_Msg_Getted, "rogueMap_assist_open")
                CSAPI.OpenView("RogueMapAssist",{id = cfg.group})       
            end)
        elseif self.fightDungeonId == nil then
            CSAPI.OpenView(path2, {group = cfg.group,groupId = cfg.dungeonGroup},{isDungeonOver = true})
        end
    end
end

function this:ApplyUpdateMistInfo(proto)
    if proto and proto.changePos then
        RogueMapBattleMgr:PushData(proto, RogueMapBattleMgr.UpdateMistDis)
    end
end

function this:SetDungeonId(id)
    self.dungeonId = id
end

function this:GetDungeonId()
    return self.dungeonId
end

function this:SetTeamFightId(id)
    self.teamFightID = id
end

function this:GetTeamFightId()
    return self.teamFightID or 1
end

function this:GetFightId()
    return self.fightDungeonId
end

function this:GetLv()
    local lv = 1
    local exp = self.exp or 0
    if #self.lvCfgs > 0 and exp > 0 then -- 获取当前等级
        for _, cfg in ipairs(self.lvCfgs) do
            if cfg.num then
                if exp - cfg.num < 0 then
                    lv = cfg.id
                    break
                end
            else
                lv = cfg.id
            end
        end
    end
    return lv
end

function this:GetLvLimit(dungeonId)
    local num = 1
    if not dungeonId then
        return num
    end
    local cfgDungeon = Cfgs.MainLine:GetByID(dungeonId)
    if cfgDungeon and cfgDungeon.dungeonGroup then
        local cfg = Cfgs.DungeonGroup:GetByID(cfgDungeon.dungeonGroup)
        if cfg and cfg.dungeonGroups then
            num = #cfg.dungeonGroups
        end
    end
    return num
end

function this:IsLockLv()
    return self.lockLevel
end

function this:IsDungeonOver()
    return self.isDungeonOver
end

function this:IsDungeonOpen(cfgId)
    local cfg = Cfgs.DungeonGroup:GetByID(cfgId)
    local isOpen, lockStr = false, ""
    if cfg then
        if cfg.perLevel == nil and cfg.unlock == nil then
            isOpen = true
        else
            isOpen, lockStr = MenuMgr:CheckModelOpen(OpenViewType.main, cfg.unlock)
            if cfg.perLevel and isOpen then
                isOpen, lockStr = self:IsDungeonPass(cfg.perLevel)
            end
        end
    end
    return isOpen, lockStr
end

function this:IsDungeonPass(cfgId)
    local data = self.datas and self.datas[cfgId]
    local isPass, str = false, ""
    if data then
        isPass = data:IsPass()
    end
    return isPass, str
end

function this:IsShowSupportView()
    return self.needShowSupport
end

function this:SetShowSupportView(b)
    self.needShowSupport = b
end

function this:IsShowPassView()
    return self.needShowPass
end

--已求援次数
function this:GetRequireNum()
    return self.requireNum or 0
end

--当前副本是不是模拟
function this:IsDirll()
    return self.isSimulated
end

function this:GetIsDirll()
    return self.isLastFightDirll == true
end

function this:SetIsDirll(b)
    self.isLastFightDirll = b
end

------------------------------------场景相关------------------------------------
-- 设置骰子
function this:SetRoll(proto)
    EventMgr.Dispatch(EventType.Net_Msg_Getted, "rogueMap_roll")
    if proto then
        self.canRoll = proto.canRoll
        self.rollCount = proto.rollCnt or self.rollCount
        RogueMapBattleMgr.isRollEffect = true
        self:UpdateLevel(proto.nExp)
        if proto.arrChar and proto.arrChar[1] then
            RogueMapBattleMgr:PushData(proto.arrChar[1], RogueMapBattleMgr.ShowRollEffect)
        end
    end
    -- EventMgr.Dispatch(EventType.RogueMap_Battle_View_Update)
end

function this:UpdateRollNum(proto)
    if proto and proto.rollCnt then
        self.rollCount = proto.rollCnt or self.rollCount
    end
end

-- 移动
function this:SetMove(proto)
    if proto then
        RogueMapBattleMgr:PushData(proto, RogueMapBattleMgr.AskMoveTo)
    end
end

-- 移动结束
function this:SetMoveEnd(proto)
    if proto then
        self.canRoll = proto.canRoll
        self.stepNum = proto.nStep or self.stepNum
        self.rollCount = proto.rollCnt or self.rollCount
        self:UpdateBuff(proto.buffs)
        self:UpdateLevel(proto.nExp)
        RogueMapBattleMgr:PushData(proto, RogueMapBattleMgr.MoveEndTrigger)
    end
    EventMgr.Dispatch(EventType.RogueMap_Battle_View_Update)
end

--设置场景等级
function this:SetChangeLevel(proto)
    if proto then
        self.lockLevel = proto.lockLevel
        self:UpdateLevel(proto.nExp, true)
    end
    EventMgr.Dispatch(EventType.RogueMap_Battle_View_Update)
end

-- 更新难度
function this:UpdateLevel(exp, isHide)
    if exp == nil then
        return
    end
    local newLv,str = self:GetNewLv(exp)
    if self.fightLv and newLv > self.fightLv and not isHide then -- 对比等级有差值则显示难度升级界面
        local max = self:GetLvLimit(self:GetFightId())
        if newLv <= max then
            if RogueMapBattleMgr:IsRollEffect() then --有骰子动画特殊处理
                local cur = self.fightLv
                self.rogueMapLvCB = function()
                    UIUtil:ShowRogueMapLv(self.fightLv, newLv, str)
                end
            else
                UIUtil:ShowRogueMapLv(self.fightLv, newLv, str)
            end
        end
    end
    self.fightLv = newLv
    self.fightExp = exp
end

function this:GetNewLv(exp)
    local newLv,str = 1,""
    if exp == nil then
        return newLv,str
    end
    if #self.lvCfgs > 0 then -- 获取当前等级
        local needExp = 0
        for _, cfg in ipairs(self.lvCfgs) do
            needExp = cfg.num
            if needExp then
                if exp < needExp then
                    newLv = cfg.id
                    str = cfg.tips
                    break
                end
            else
                newLv = cfg.id
                str = cfg.tips
            end
        end
        if needExp and needExp > 0 then
            Log(string.format("当前关卡难度等级：%s，经验：%s，升级到下一个等级所需经验：%s",
                newLv, exp, needExp - exp))
        end
    end
    return newLv,str
end

function this:ShowRogueMapLv()
    if self.rogueMapLvCB then
        self.rogueMapLvCB()
        self.rogueMapLvCB = nil
    end
end

function this:UpdateBuff(_buffs)
    self.buffs = {}
    if _buffs and #_buffs > 0 then
        local key = ""
        for i, v in ipairs(_buffs) do
            key = v.id .. "_" ..v.round
            if self.buffs[key] then
                self.buffs[key].count = self.buffs[key].count + 1
                self.buffs[key].index = v.index <self.buffs[key].index and v.index or self.buffs[key].index
            else
                self.buffs[key] = {
                    id = v.id,
                    num = v.round,
                    type = v.ty,
                    index = v.index,
                    count = 1
                }
            end
        end
    end
end

function this:UpdateBuffs(proto)
    if proto then
        self:UpdateBuff(proto.buffs)
    end
    EventMgr.Dispatch(EventType.RogueMap_Battle_View_Update)
end

function this:IsCanRoll()
    return self.canRoll
end

function this:GetFightLv()
    return self.fightLv
end

function this:GetFightExp()
    local cur, max = self.fightExp or 0, 0
    if #self.lvCfgs > 0 then
        for i, v in ipairs(self.lvCfgs) do
            max = v.num
            if v.id >= self.fightLv then
                break
            end
        end
    end
    return cur, max
end

-- 设置可用骰子数
function this:SetRollNum(value)
    self.rollCount = value
end

-- 获取可用骰子数和一天使用上限
function this:GetRollNum()
    return self.rollCount or 0, self:GetGlobal("dailyRollCnt") or 1
end

-- 设置已行走步数
function this:SetStepNum(value)
    self.stepNum = value
end

-- 获取已行走步数
function this:GetStepNum()
    return self.stepNum or 0
end

-- 获取已有buff
function this:GetBuffs(num)
    local infos = {}
    local _num = 0
    if self.buffs then
        for _, v in pairs(self.buffs) do
            if not num or _num <= num  then
                table.insert(infos, v)
                _num = _num + 1
            end
        end
    end
    if #infos > 0 then
        table.sort(infos, function(a, b)
            return a.index < b.index
        end)
    end
    return infos
end

function this:GetFloatFont(buffId)
    if self.cfgFloatFonts == nil then
        self.cfgFloatFonts = {}
        local cfgs = Cfgs.CfgRogueMapFloatFont:GetAll()
        if cfgs then
            for i, v in pairs(cfgs) do
                self.cfgFloatFonts[v.buffId] = v
            end
        end
    end

    return (self.cfgFloatFonts and self.cfgFloatFonts[buffId]) and self.cfgFloatFonts[buffId].content or ""
end

------------------------------------支援相关------------------------------------
-- 更新当前副本求援信息
function this:UpdateBattleHelpInfo(proto)
    EventMgr.Dispatch(EventType.Net_Msg_Getted, "rogueMap_battle_support")
    if proto then
        RogueMapBattleMgr:PushData(proto, RogueMapBattleMgr.UpdateSupportInfo)
        self.requireNum = proto.nRequireTimes
    end
end

function this:UpdateSupportDatas(proto)
    self.supports = {}
    if proto then
        if proto.arr and #proto.arr > 0 then
            for i, v in ipairs(proto.arr) do
                local data = RogueMapSupData.New()
                data:Init(v)
                self.supports[data:GetIndex()] = data
            end
        end
    end
    EventMgr.Dispatch(EventType.RogueMap_Assist_Refresh)
end

function this:GetSupportArr()
    local infos = {}
    if self.supports then
        for k, v in pairs(self.supports) do
            table.insert(infos,v)
        end
    end
    if #infos > 0 then
        table.sort(infos,function (a,b)
            return a:GetLv() > b:GetLv()
        end)
    end
    return infos
end

function this:RemoveSupportData(index)
    if self.supports and self.supports[index] then
        self.supports[index] = nil
    end
end

--刷新可支援数据列表
function this:UpdateAssistDatas(proto)
    if proto then
        self.assists = {}
        if proto.arr and #proto.arr > 0 then
            for i, v in ipairs(proto.arr) do
                local data = RogueMapSupData.New()
                data:Init(v)
                self.assists[data:GetIndex()] = data
            end
        end
        self.supports = {}
        if proto.myArr and #proto.myArr > 0 then
            for i, v in ipairs(proto.myArr) do
                local data = RogueMapSupData.New()
                data:Init(v)
                self.supports[data:GetIndex()] = data
            end
        end
        self.isLogNew = proto.hasNewLog
        self.assistRewardInfos = proto.supRewardLimit
        self.friendTime = proto.lastReqTime
    end
    EventMgr.Dispatch(EventType.RogueMap_Assist_Refresh)
end

--获取可支援数据
function this:GetAssistArr(group)
    local infos = {}
    if self.assists then
        for k, v in pairs(self.assists) do
            if not v:IsFinish() and not v:IsTimeEnd() then
                table.insert(infos,v)
            end
        end
    end
    if #infos > 0 then
        table.sort(infos,function (a,b)
            if a:GetType() == b:GetType() then
                return a:GetLv() > b:GetLv()
            else
                return a:GetType() < b:GetType()
            end
        end)
    end
    return infos
end

--更新支援相关信息
function this:UpdateAssistInfo(proto,isSelf)
    if proto then
        if proto.info then
            local data = RogueMapSupData.New()
            data:Init(proto.info)
            self.supports = self.supports or {}
            self.supports[data:GetIndex()] = data
            if not self.isRewardRed then --检测有没有红点
                self.isRewardRed = data:IsFinish()
                if self.isRewardRed then
                    self:CheckRedPointData()
                end
            end
            EventMgr.Dispatch(EventType.RogueMap_Assist_Refresh)
        end
        if proto.log then
            local data = RogueMapLogData.New()
            data:Init(proto.log)
            data:SetIsNew(proto.log.isNew)
            self:AddLogData(data)
            EventMgr.Dispatch(EventType.RogueMap_Log_Refresh)
        end
    end
end

function this:GetAssistRewardNums()
    local nums = {}
    nums[1] = self.assistRewardInfos and self.assistRewardInfos[1] or 0
    nums[2] = self.assistRewardInfos and self.assistRewardInfos[2] or 0
    return nums
end

--更新日志信息
function this:UpdateLogDatas(proto)
    if proto and proto.arr then
        self.logs = {}
        for i, v in ipairs(proto.arr) do
            local _data = RogueMapLogData.New()
            _data:Init(v)
            _data:SetIsNew(v.isNew)
            table.insert(self.logs,_data)
        end
        if #self.logs > 0 then
            table.sort(self.logs,function (a,b)
                return a:GetTime() > b:GetTime()
            end)
        end
    end

    EventMgr.Dispatch(EventType.RogueMap_Log_Refresh)
end

--设置日志信息
function this:AddLogData(data)
    if not data then
        return
    end
    self.logs = self.logs or {}
    table.insert(self.logs,data)
    if #self.logs > 0 then
        table.sort(self.logs,function (a,b)
            return a:GetTime() > b:GetTime()
        end)
        if #self.logs > self:GetGlobal("historyShowNum") then
            local infos = {}
            for i = 1, self:GetGlobal("historyShowNum") do
                table.insert(infos, self.logs[i])
            end
            self.logs = infos
        end
    end
    EventMgr.Dispatch(EventType.RogueMap_Log_Refresh)
end

--获取日志列表
function this:GetLogArr()
    local infos = {}
    if self.logs then --只取前20
        for i = 1, self:GetGlobal("historyShowNum") do
            table.insert(infos, self.logs[i])
        end
    end
    return infos
end

--检测日志列表是否为空
function this:CheckLogIsRefresh()
    local refreshTime = self:GetGlobal("historyRefreshTime") or 300 --秒
    local isRefresh = self.logs == nil
    if not isRefresh then
        isRefresh = self.logRefreshTime == nil or CSAPI.GetTime() > self.logRefreshTime
    end
    if isRefresh then
        self.logRefreshTime = CSAPI.GetTime() + refreshTime
    end
    return isRefresh
end

function this:CheckLogRed()
    if self.isLogNew then
        return true
    end
    if self.logs then
        for i = 1, self:GetGlobal("historyShowNum") do
            if self.logs[i] and self.logs[i]:GetIsNew() then
                return true
            end
        end
    end
    return false
end

function this:SaveLogNews()
    local logNews = {}
    if self.logs then
        for i = 1, self:GetGlobal("historyShowNum") do
            if self.logs[i] then
                self.logs[i]:SetIsNew(false)
            end
        end
    end
    self.isLogNew = false
end

function this:GetFriendTime()
    return self.friendTime
end

------------------------------------红点相关------------------------------------
function this:CheckRedPointData()
    RedPointMgr:UpdateData(RedPointType.RogueMap,self:CheckRed() and 1 or nil)
end

function this:CheckRed()
    return self:IsRewardRed() or self:IsAssistNew() or self:CheckRollCountRed()
end

function this:IsRewardRed()
    local isRed = self.isRewardRed
    if self.supports then
        for k, v in pairs(self.supports) do
            if v:IsFinish() then
                isRed = true
                break
            end
        end
    end
    return isRed
end

function this:SetRewardRed(b)
    self.isRewardRed = b
end

function this:SetAssistNew(b)
   self.isAssistNew = b 
end

function this:IsAssistNew()
    return self.isAssistNew
end

function this:CheckRollCountRed()
    local isRed = self.rollCount and self.rollCount > 0
    if isRed then
        isRed = RedPointMgr:GetDayRedState(RedPointDayOnceType.RogueMap)
    end
    return isRed
end

return this
