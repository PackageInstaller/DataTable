ArmyProto = {}

-- 获取军演信息
function ArmyProto:GetPracticeInfoRet(proto)
    ExerciseMgr:GetPracticeInfoRet(proto)
end

-- 信息刷新(结算)
function ArmyProto:PracticeInfoUpdate(proto)
    ExerciseMgr:PracticeInfoUpdate(proto)
end

-- 刷新对手
function ArmyProto:FlushPracticeObjRet(proto)
    ExerciseMgr:FlushPracticeObjRet(proto)
end

-- 查看对手卡牌信息
function ArmyProto:GetPracticeOtherTeamRet(proto)
    ExerciseMgr:GetPracticeOtherTeamRet(proto)
end

-- 查看对手卡牌信息
function ArmyProto:GetPracticeListRet(proto)
    ExerciseMgr:GetPracticeListRet(proto)
end

-- 准备好
function ArmyProto:StartRealArmyRet(proto)
    ExerciseRMgr:StartRealArmyRet(proto)
end

-- 开始模拟
function ArmyProto:Practice(_uid, _is_robot)
    local proto = {"ArmyProto:Practice", {
        uid = _uid,
        is_robot = _is_robot
    }}
    NetMgr.net:Send(proto)
end

-- 邀请军演信息返回
-- function ArmyProto:InviteFriendRet(proto)
--     ExerciseMgr:InviteFriendRet(proto)
-- end

-- 被好友邀请军演(服务器推送)
function ArmyProto:BeInvite(proto)
    ExerciseRMgr:BeInvite(proto)
end

-- 收到好友应答
function ArmyProto:BeInviteRespond(proto)
    ExerciseRMgr:BeInviteRespond(proto)
end

-- 参加自由军演
function ArmyProto:JoinFreeArmy(_JoinFreeArmyCB)
    self.JoinFreeArmyCB = _JoinFreeArmyCB
    local proto = {"ArmyProto:JoinFreeArmy", {}}
    NetMgr.net:Send(proto)
end
function ArmyProto:JoinFreeArmyRet(proto)
    ExerciseRMgr:JoinFreeArmyRet(proto)
    if (self.JoinFreeArmyCB) then
        self.JoinFreeArmyCB()
    end
    self.JoinFreeArmyCB = nil 
end

-- 退出自由军演
function ArmyProto:QuitFreeArmy(_QuitFreeArmyCB)
    self.QuitFreeArmyCB = _QuitFreeArmyCB
    local proto = {"ArmyProto:QuitFreeArmy"}
    NetMgr.net:Send(proto)
end
function ArmyProto:QuitFreeArmyRet()
    if (self.QuitFreeArmyCB) then
        self.QuitFreeArmyCB()
    end
    self.QuitFreeArmyCB = nil
end

-- 实时军演战斗地址服务器
function ArmyProto:FightAddress(proto)
    ExerciseRMgr:FightAddress(proto)
end

-- 实时军演战斗服报道返回
function ArmyProto:FightServerInitRet(proto)
    ExerciseRMgr:FightServerInitRet(proto)
end

-- -- 实时军演开始倒计时
-- function ArmyProto:RealArmyStarCountDown(proto)
--     ExerciseMgr:RealArmyStarCountDown(proto)
-- end

-- 实时军演结果
function ArmyProto:RealTimeFightFinish(proto)
    ExerciseRMgr:RealTimeFightFinish(proto)
end

-- 不重进战斗
function ArmyProto:NotReEntryRealFight()
    local proto = {"ArmyProto:NotReEntryRealFight"}
    NetMgr.net:Send(proto)
end

-- 不重进战斗
function ArmyProto:NotReEntryRealFightRet(proto)

end

-- 请求自由军演对战列表
function ArmyProto:FreeArmyFightList()
    local proto = {"ArmyProto:FreeArmyFightList"}
    NetMgr.net:Send(proto)
end
function ArmyProto:FreeArmyFightListRet(proto)
    EventMgr.Dispatch(EventType.Exercise_WaringList, proto)
end

-- 退出军演
function ArmyProto:QuitArmy()
    local proto = {"ArmyProto:QuitArmy"}
    --NetMgr.net:Send(proto)
    if(ExerciseRMgr.GetCurNet)then 
        ExerciseRMgr:GetCurNet():Send(proto)
    end 
end
-- 实时军演对手已经下线
function ArmyProto:RealArmyLogout(proto)
    EventMgr.Dispatch(EventType.Exercise_Army_Out)
end

-- 请求自己的数据（仅在倒计时用）
function ArmyProto:GetSelfPracticeInfo(GetSelfPracticeInfoCB)
    self.GetSelfPracticeInfoCB = GetSelfPracticeInfoCB
    local proto = {"ArmyProto:GetSelfPracticeInfo"}
    NetMgr.net:Send(proto)
end
function ArmyProto:GetSelfPracticeInfoRet(proto)
    local datas = {
        info = proto.info,
        selfInfo = true
    }
    ExerciseMgr:GetPracticeInfoRet(datas)
    if (self.GetSelfPracticeInfoCB) then
        self.GetSelfPracticeInfoCB()
    end
    self.GetSelfPracticeInfoCB = nil
end

-- 购买军演次数
function ArmyProto:BuyAttackCnt(_cnt)
    local proto = {"ArmyProto:BuyAttackCnt", {
        cnt = _cnt
    }}
    NetMgr.net:Send(proto)
end
function ArmyProto:BuyAttackCntRet(proto)
    ExerciseMgr:BuyAttackCntRet(proto)
    LanguageMgr:ShowTips(33008)
end


--军演立绘
function ArmyProto:SetRolePanel(_role_panel_id,_live2d)
    local proto = {"ArmyProto:SetRolePanel", {
        role_panel_id = _role_panel_id,
        live2d = _live2d
    }}
    NetMgr.net:Send(proto)
end
function ArmyProto:SetRolePanelRet(proto)
    ExerciseRMgr:SetRolePanelRet(proto.role_panel_id,proto.live2d)
    ExerciseMgr:SetRolePanelRet(proto.role_panel_id,proto.live2d)
    LanguageMgr:ShowTips(33020)
end

--军演战报
function ArmyProto:GetFightLogs(_ix,_cnt,_cb)
    self.GetFightLogsCB = _cb
    local proto = {"ArmyProto:GetFightLogs", {
        ix = _ix,
        cnt = _cnt
    }}
    NetMgr.net:Send(proto)
end
function ArmyProto:GetFightLogsRet(proto)
    if(self.GetFightLogsCB)then 
        self.GetFightLogsCB(proto)
    end
    self.GetFightLogsCB = nil
end

--服务器通知pvp需要重连
function ArmyProto:HadPvpInfo(proto)
    ExerciseRMgr:HadPvpInfo(proto)
end

--战斗服通知战斗已结束
function ArmyProto:RecoverPvpRet(proto)
    if(proto.finish)then 
        ArmyProto:DelPvpInfo()
    end 
end
--告知游戏服战斗已结束
function ArmyProto:DelPvpInfo()
    local proto = {"ArmyProto:DelPvpInfo"}
    NetMgr.net:Send(proto)
end

-- 邀请好友  _is_cancel:true 取消邀请   false：邀请
function ArmyProto:InviteFriend(_ops, _YQCB)
    self.YQCB = _YQCB
    local proto = {"ArmyProto:InviteFriend", {
        ops = _ops
    }}
    NetMgr.net:Send(proto)
end

-- 邀请回调
function ArmyProto:InviteFriendRet(proto)
   ExerciseFriendTool:RefreshInviteDatas(proto)
    if (self.YQCB) then
        self.YQCB(proto)
    end
    self.YQCB = nil
end

-- 应答好友
function ArmyProto:BeInviteRet(_ops)
    local proto = {"ArmyProto:BeInviteRet", {
        ops = _ops
    }}
    NetMgr.net:Send(proto)
end

--自由匹配界面信息
function ArmyProto:FreeMatchInfo(_cb)
    self.FreeMatchInfoCB = _cb
    local proto = {"ArmyProto:FreeMatchInfo"}
    NetMgr.net:Send(proto)
end

function ArmyProto:FreeMatchInfoRet(proto)
    ExerciseRMgr:FreeMatchInfoRet(proto)
    if(self.FreeMatchInfoCB)then 
        self.FreeMatchInfoCB()
    end 
    self.FreeMatchInfoCB = nil
end

function ArmyProto:GetFreeMatchRankList(_beg_rank,_end_rank,_cb)
    self.GetFreeMatchRankListCB  = _cb
    local proto = {"ArmyProto:GetFreeMatchRankList",{beg_rank = _beg_rank,rank_cnt = _end_rank}}
    NetMgr.net:Send(proto)
end
function ArmyProto:GetFreeMatchRankListRet(proto)
    if(self.GetFreeMatchRankListCB)then 
        self.GetFreeMatchRankListCB(proto)
    end 
    self.GetFreeMatchRankListCB = nil 
end

--确认赛季切换了
function ArmyProto:FreeMatchCfgChangeFix()
    local proto = {"ArmyProto:FreeMatchCfgChangeFix"}
    NetMgr.net:Send(proto)
end

function ArmyProto:GetPvpReward(_type,_ids,_cb)
    self.GetPvpRewardCB = _cb
    local proto = {"ArmyProto:GetPvpReward",{type = _type,ids = _ids}}
    NetMgr.net:Send(proto)
end
function ArmyProto:GetPvpRewardRet(proto)
    ExerciseRMgr:SetRewardInfo(proto.reward_info)
    if(self.GetPvpRewardCB)then 
        self.GetPvpRewardCB()
    end 
    self.GetPvpRewardCB = nil 
end