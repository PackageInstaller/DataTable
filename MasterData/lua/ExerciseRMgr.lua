require "ExerciseFriendTool" -- 管理邀请或被邀请的数据
local this = MgrRegister("ExerciseRMgr")

function this:Clear()
    self.proto = {}
    self.pvpBan = nil -- 当前赛季禁用的卡牌
    self.old_max_rank = nil -- 当前赛季最高的排名
    self.old_max_dw = nil -- 当前赛季最高段位
    self.oldRewards = nil -- 战斗胜利获得的奖励
    ExerciseFriendTool:Clear()
end

function this:Init()
    self:Clear()
    ArmyProto:FreeMatchInfo()
end

function this:FreeMatchInfoRet(proto)
    self.proto = proto
    if (self.proto.pre_cfg_id) then
        self.old_max_rank = 0
        self.old_max_dw = self.proto.reward_info.get_rank_lv_id or 1
    else
        if (self.old_max_rank == nil) then
            self.old_max_rank = self.proto.max_rank or 0
        end
        if (self.old_max_dw == nil) then
            self.old_max_dw = self.proto.reward_info.get_rank_lv_id or 1
        end
    end
    self:CheckRed()
end

function this:CheckBreak()
    if (self.proto.max_rank < self.old_max_rank) then
        return true
    end
    if (self.proto.reward_info.get_rank_lv_id > self.old_max_dw) then
        return true
    end
    return false
end

-- 是否突破历史最高排名
function this:IsRankBreak()
    if (self.proto.max_rank < self.old_max_rank) then
        local old_max_rank = self.old_max_rank
        self.old_max_rank = self.proto.max_rank
        return true, {self.proto.max_rank, old_max_rank}
    end
    return false
end

-- 新段位
function this:IsDWBreak()
    if (self.proto.reward_info.get_rank_lv_id > self.old_max_dw) then
        local old_max_dw = self.old_max_dw
        self.old_max_dw = self.proto.reward_info.get_rank_lv_id
        return true, self.proto.reward_info.get_rank_lv_id
    end
    return false
end

function this:GSetOldRewards()
    local rewards = nil
    if (self.oldRewards) then
        rewards = table.copy(self.oldRewards)
        self.oldRewards = nil
    end
    return rewards
end

function this:GetOldScore()
    return self.old
end

function this:GetProto()
    return self.proto or {}
end

function this:GetMainCfg()
    return Cfgs.CfgPvpCommon:GetByID(1)
end

-- 匹配时间
function this:GetPPTimer()
    if (not self.pvpMatchTime) then
        self.pvpMatchTime = self:GetMainCfg().pvpMatchTime
    end
    return self.pvpMatchTime
end

function this:GetCurCfg()
    local curCfg = nil
    if (self:GetProto().cfg_id and self:GetProto().cfg_id ~= 0) then
        curCfg = Cfgs.CfgPvpSeason:GetByID(self:GetProto().cfg_id)
    end
    return curCfg
end

-- 退出战斗，返回演习界面
function this:Quit(armyType)
    self.isFightNet = false
    ClientProto:DelayChangeLine()
    SceneLoader:Load("MajorCity", function()
        self:OnQuit(armyType)
    end)
end

function this:OnQuit(armyType)
    CSAPI.OpenView("Section", {
        type = 3
    })
    CSAPI.OpenView("ExerciseRMain", armyType)
end

-- 参加自由军演返回
function this:JoinFreeArmyRet(proto)

end

-- 开始实时对战
function this:StartRealArmy(_team)
    -- 实时对战要赋值卡牌数据 （会被玩家改数据）
    local _team2 = table.copy(_team)
    for k, v in pairs(_team2.data) do
        local cid = v.cid
        local data = RoleMgr:GetData(v.cid)
        local baseData = table.copy(data:GetData())
        local calData = data and data:GetTotalProperty() or {}
        for k, v in pairs(calData) do
            baseData[k] = v
        end
        local skills = data:GetEquipSkillPoint()
        baseData.equip_skills = skills.fightSkills
        _team2.data[k].pvp_card_info = baseData
    end
    -- 
    local proto = {"ArmyProto:StartRealArmy", {
        team = _team2
    }}
    self:GetCurNet():Send(proto)
end

-- 准备好
function this:StartRealArmyRet(proto)
    EventMgr.Dispatch(EventType.Exercise_Ready, proto)
end

-- 收到好友应答(这里只收到拒绝的应答)
function this:BeInviteRespond(proto)
    ExerciseFriendTool:BeInviteRespond(proto)
    EventMgr.Dispatch(EventType.Exercise_Yq_Refuse)
end

-- 开始倒计时
function this:FightServerInitRet(proto)
    local isInvite = proto.invite_uid == PlayerClient:GetID() -- 自己是不是邀请者
    local data = {
        auto_start_time = proto.auto_start_time,
        uid = isInvite and proto.agreed_uid or proto.invite_uid,
        type = proto.type
    }
    if (CSAPI.IsViewOpen("ExerciseRPP")) then
        EventMgr.Dispatch(EventType.Exercise_Pp_Success, data)
    else
        CSAPI.OpenView("ExerciseRPP", data, proto.type)
        CSAPI.CloseAllOpenned("ExerciseRPP")
    end

    -- 清除邀请的相关数据
    Tips.CleanInviteTips()
    ExerciseFriendTool:ClearFriendDatas()
end

-- 收到好友邀请(服务器推送)
function this:BeInvite(proto)
    ExerciseFriendTool:RefreshBeInviteDatas(proto)
end

-- 匹配/邀请到对手
function this:FightAddress(proto)
    -- 好友的数据
    ExerciseFriendTool:SetRespondData(proto.friend_invite_info)
    -- 对手的数据
    ExerciseFriendTool:FreeArmyMatch(proto.free_match_info)
    --
    self.addr = proto.addr
    local localIp, localPort = LoginProto:GetIpPort()
    -- Log("主网络Ip：" .. localIp .. "  " .. localPort)
    -- Log("游戏服Ip：" .. proto.ip .. "   " .. proto.port)
    if (localIp ~= self.addr.ip or localPort ~= self.addr.port) then
        Log("连接到游戏逻辑服")
        self.isFightNet = true
        self:OnConnectFightServer(function()
            self:FightServerInit()
        end)
    else
        Log("使用主网络")
        self.isFightNet = false
        self:FightServerInit()
    end
end

-- 连接到战斗服
function this:OnConnectFightServer(func)
    NetMgr.netFight:Connect(self.addr.ip, self.addr.port, func)
end

-- 连接战斗服后，推送数据
function this:FightServerInit()
    local proto = {"ArmyProto:FightServerInit", {
        uid = PlayerClient:GetID(),
        addr = self.addr
    }}
    local curNet = self:GetCurNet()
    curNet:Send(proto)
end

-- 获取当前网络
function this:GetCurNet()
    if (self.isFightNet) then
        return NetMgr.netFight
    else
        return NetMgr.net
    end
end

-- 是否需要重连
function this:CheckIsReconnect()
    return self.is_Login
end

function this:SetIsReconnect(b)
    self.is_Login = b
end

-- 如果战斗服未连接，则先连接，然后再告知服务器恢复战斗
function this:HadPvpInfo(proto)
    self.is_Login = not proto.is_reconnect
    self.addr = proto.addr
    local localIp, localPort = LoginProto:GetIpPort()
    if (localIp ~= self.addr.ip or localPort ~= self.addr.port) then
        self.isFightNet = true
        if (not self.is_Login) then -- 战斗中断线重连
            self:RecoverPvp()
        end
    else
        self.isFightNet = false
    end
end

-- 断线恢复
function this:RecoverPvp()
    local func = function()
        local proto = {"ArmyProto:RecoverPvp", {
            uid = PlayerClient:GetID(),
            addr = self.addr
        }}
        self:GetCurNet():Send(proto)
    end
    if (self.isFightNet) then
        if (NetMgr.netFight and not NetMgr.netFight:IsConnected()) then
            self:OnConnectFightServer(func)
        else
            func()
        end
    else
        func()
    end
end

-- 结果
function this:RealTimeFightFinish(proto)
    local newScore = proto.score or self.proto.score
    local newRank = proto.rank or self:GetProto().rank
    local score = newScore - self.proto.score
    self.isRankUp = newRank < self:GetProto().rank
    self.proto.rank = newRank
    self.proto.score = newScore
    self.oldRewards = nil
    if (proto.rewards and #proto.rewards > 0) then
        self.oldRewards = proto.rewards
    end
    -- 断线重连在主界面时不进行结算
    local scene = SceneMgr:GetCurrScene()
    if (scene.key ~= "MajorCity") then
        FightOverTool.RealTimeFightFinish(proto, score)
    end
end

-- 赛季刷新时间: 是否赛季中，刷新时间
function this:CheckTime1()
    local b, timer = false, nil
    local curCfg = self:GetCurCfg()
    if (curCfg) then
        local curTime = TimeUtil:GetTime()
        local startTime = curCfg.startTime and TimeUtil:GetTimeStampBySplit(curCfg.startTime) or nil
        local endTime = curCfg.endTime and TimeUtil:GetTimeStampBySplit(curCfg.endTime) or nil
        if ((not startTime or curTime > startTime) and (not endTime or endTime >= curTime)) then
            b = true
        end
        if (startTime and startTime > curTime) then
            timer = startTime
        elseif (endTime and endTime > curTime) then
            timer = endTime
        end
    end
    return b, timer
end

-- 开放刷新时间:是否开放中，刷新时间
function this:CheckTime2()
    local b, timer = false, nil
    local curCfg = self:GetCurCfg()
    if (curCfg and self:CheckTime1()) then
        local curTime = TimeUtil:GetTime()
        local timeData = TimeUtil:GetTimeHMS(curTime)
        local curHour = timeData.hour
        if (curHour >= curCfg.startBattleTime and curHour < curCfg.endBattleTime) then
            b = true
        end
        if (curCfg.startBattleTime > curHour) then
            timer = TimeUtil:GetTime2(timeData.year, timeData.month, timeData.day, curCfg.startBattleTime, 0, 0)
        elseif (curCfg.endBattleTime > curHour) then
            timer = TimeUtil:GetTime2(timeData.year, timeData.month, timeData.day, curCfg.endBattleTime, 0, 0)
        else
            -- 下一天的开始时间
            local _timer = TimeUtil:GetTime2(timeData.year, timeData.month, timeData.day, 24, 0, 0)
            timer = _timer - curTime + curCfg.startBattleTime * 3600
        end
    end
    return b, timer
end

-- pvp 赛季结束时间、开放结束时间
function this:CheckEerciseRTime()
    local exerciseRTime = nil
    local b1, timer1 = ExerciseRMgr:CheckTime1()
    local b2, timer2 = ExerciseRMgr:CheckTime2()
    if (b1) then
        if (b2) then
            exerciseRTime = timer1 > timer2 and timer2 or timer1
        else
            return timer2
        end
    end
    return exerciseRTime
end

function this:CardCanUse(cfgID)
    local canUse = true
    if (not self.pvpBan) then
        self.pvpBan = {}
        local curCfg = self:GetCurCfg()
        if (curCfg and curCfg.pvpBan) then
            local _pvpBan = curCfg.pvpBan
            for k, v in pairs(_pvpBan) do
                self.pvpBan[v] = 1
            end
        end
    end
    canUse = not self.pvpBan[cfgID]
    return canUse, 90036
end

-- 赛季检测
function this:IsChangeSJ()
    if (self:GetProto() and self:GetProto().pre_cfg_id) then
        return true
    end
    return false
end

function this:SetChangeSJ()
    if (self:GetProto()) then
        self:GetProto().pre_cfg_id = nil
    end
end

-- 红点检测
function this:CheckRed()
    local num1 = nil
    if (self:GetProto().reward_info) then
        local cfg = Cfgs.CfgPvpTaskReward:GetByID(1)
        local join_cnt = self:GetProto().reward_info.join_cnt or 0
        local get_join_cnt_id = self:GetProto().reward_info.get_join_cnt_id or 0
        local ids = self:GetIDs(cfg, join_cnt, get_join_cnt_id)
        num1 = #ids > 0 and 1 or nil
    end
    --
    local num2 = nil
    if (self:GetProto().reward_info) then
        local cfg = Cfgs.CfgPvpTaskReward:GetByID(2)
        local win_cnt = self:GetProto().reward_info.win_cnt or 0
        local get_win_cnt_ix = self:GetProto().reward_info.get_win_cnt_ix or 0
        local ids = self:GetIDs(cfg, win_cnt, get_win_cnt_ix)
        num2 = #ids > 0 and 2 or nil
    end
    local num = nil
    if (num1 ~= nil and num2 ~= nil) then
        num = 3
    elseif (num1 ~= nil or num2 ~= nil) then
        num = num1 or num2
    end
    local _num = RedPointMgr:GetData(RedPointType.PVP)
    if (_num ~= num) then
        RedPointMgr:UpdateData(RedPointType.PVP, num)
    end
end

function this:GetRewardInfo()
    return self:GetProto().reward_info or {}
end
function this:SetRewardInfo(_reward_info)
    self:GetProto().reward_info = _reward_info
    self:CheckRed()
end

-- 3个队伍都有角色才能接受邀请
function this:CheckCanAgree()
    for k = 0, 2 do
        local _teamData = TeamMgr:GetTeamData(eTeamType.PVPFriend + k)
        if (_teamData:GetRealCount() <= 0) then
            return false
        end
    end
    return true
end

-- 段位 （通过积分换算）
function this:GetRankLevel()
    return GCalHelp:CalFreeMatchRankLv(self:GetProto().score)
end

-- 段位图标
function this:GetDwIcon()
    local cfg = Cfgs.CfgPvpRankLevel:GetByID(self:GetRankLevel())
    return cfg.icon or ""
end
-- 排名
function this:GetRank()
    return self:GetProto().rank or 0
end

-- 段位是否升级
function this:IsRankUp()
    return self.isRankUp
end

-- 积分
function this:GetScore()
    return self:GetProto().score or 0
end

function this:GetPvpRewardRet(proto)
    self:GetProto().reward_info = proto.reward_info
end

function this:SetRolePanelRet(_role_panel_id, _live2d)
    self:GetProto().role_panel_id = _role_panel_id
    self:GetProto().live2d = _live2d
    -- EventMgr.Dispatch(EventType.Exercise_Role_Panel)
end

function this:GetIDs(cfg, cnt, id)
    local ids = {}
    for k, v in ipairs(cfg.infos) do
        if (k > id and cnt >= v.order) then
            table.insert(ids, k)
        end
    end
    return ids
end

return this
