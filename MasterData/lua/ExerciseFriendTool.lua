-- 组队攻击
ExerciseFriendTool = {}
local this = ExerciseFriendTool

this.inviteFriendDatas = {} -- 我邀请的好友的的数据(我离开界面时会取消所有邀请)
this.beInviteDatas = {} -- 邀请我的人的数据
this.emenyData_friend = nil -- 对手数据 sFriendInvite
this.emenyData_free = nil -- 对手数据 sFreeArmyMatch

function this:Clear()
    self:ClearFriendDatas()
    self.emenyData_free = nil
end

-- 换场景检测邀请
function this:CheckInvite()
    if (self:IsCanInvite() and self.beInviteDatas ~= nil) then
        for i, v in pairs(self.beInviteDatas) do
            if (not v.is_cancel and TimeUtil:GetTime() < (v.invite_time + ExerciseRMgr:GetPPTimer())) then
                Tips.ShowInviteTips(v)
            end
        end
    end
end

function this:ClearFriendDatas()
    self.inviteFriendDatas = {}
    self.beInviteDatas = {}
    --self.emenyData_friend = nil
end

-- ArmyProto:InviteFriendRet	ops   {uid	is_cancel invite_time}
function this:RefreshInviteDatas(proto)
    for i, v in ipairs(proto.ops) do
        self.inviteFriendDatas[v.uid] = v
    end
end

-- 邀请你的好友的数据
-- ArmyProto:BeInvite uid	is_cancel	team  rank  invite_time
function this:RefreshBeInviteDatas(proto)
    self.beInviteDatas[proto.uid] = proto
    -- 只在主场景接收
    if (self:IsCanInvite()) then
        if (TimeUtil:GetTime() < (proto.invite_time + ExerciseRMgr:GetPPTimer())) then
            Tips.ShowInviteTips(proto)
        end
    end
end

--能否弹出邀请框
function this:IsCanInvite()
    local scene = SceneMgr:GetCurrScene()
    if (scene.key == "MajorCity" and not CSAPI.IsViewOpen("ExerciseRPP") and not GuideMgr:IsGuiding() and
        not MenuMgr:IsSpineUI()) then
        return true
    end
    return false
end

-- 对手数据（好友）
function this:SetRespondData(_data)
    self.emenyData_friend = _data
end

-- 对手数据（自由匹配）
function this:FreeArmyMatch(proto)
    self.emenyData_free = proto
end

function this:GetInviteData(uid)
    return self.inviteFriendDatas[uid]
end

-- 取消所有申请（离开界面）
function this:CancelAllInvite()
    local curTime = TimeUtil:GetTime()
    local _ops = {}
    for i, v in pairs(self.inviteFriendDatas) do
        if (v.invite_time == nil or curTime < (v.invite_time + ExerciseRMgr:GetPPTimer())) then
            table.insert(_ops, {
                uid = v.uid,
                is_cancel = true
            })
        end
    end
    if (#_ops > 0) then
        ArmyProto:InviteFriend(_ops)
    end
    --self.inviteFriendDatas = {}
end

-- 自己的信息
function this:GetMyData(nType)
    local data = {}
    local teams = {}
    for k = 0, 2 do
        local teamData = TeamMgr:GetTeamData(nType + k)
        table.insert(teams, teamData)
    end
    data.uid = PlayerClient:GetID()
    data.name = PlayerClient:GetName()
    data.level = PlayerClient:GetLv()
    data.rank = ExerciseRMgr:GetProto().rank
    data.icon_id = PlayerClient:GetIconId()
    data.icon_frame = PlayerClient:GetHeadFrame()
    data.sel_card_ix = PlayerClient:GetSex()
    data.role_panel_id = ExerciseRMgr:GetProto().role_panel_id
    data.live2d = ExerciseRMgr:GetProto().live2d
    data.icon_title = PlayerClient:GetIconTitle()
    data.teams = teams
    data.score = ExerciseRMgr:GetProto().score or 0
    return data
end

-- 获取对手信息
function this:GetArmyData(type, uid)
    local data = {}
    if (type == RealArmyType.Friend) then
        local friendData = FriendMgr:GetData(uid)
        -- local attack = team.performance
        data.uid = uid
        data.name = friendData:GetName()
        data.level = friendData:GetLv()
        data.rank = self.emenyData_friend.rank
        data.icon_id = friendData:GetIconId()
        data.icon_frame = friendData:GetFrameId()
        data.sel_card_ix = friendData:GetSex()
        data.role_panel_id = self.emenyData_friend.role_panel_id
        data.live2d = self.emenyData_friend.live2d
        data.icon_title = friendData:GetTitle()
        data.teams = self:SetTeams(self.emenyData_friend.teams)
        data.score = self.emenyData_friend.score
        data.join_cnt = self.emenyData_friend.join_cnt or 0
    elseif (type == RealArmyType.Freedom) then
        if (self.emenyData_free.robot_cfg_id and self.emenyData_free.robot_cfg_id ~= 0) then
            -- 机器人
            local cfg = Cfgs.CfgPvpRobot:GetByID(self.emenyData_free.robot_cfg_id)
            data.name = cfg.nName
            data.level = cfg.nLevel
            data.rank = self.emenyData_free.rank
            data.icon_id = cfg.nIconId
            data.icon_frame = 1
            data.sel_card_ix = 1
            data.role_panel_id = cfg.nIconId
            data.live2d = false
            data.icon_title = 1
            local list = GCalHelp:GetFreeArmyRobotSimpleTeams(cfg.id)
            data.teams = self:SetTeams(list.teams)
            data.score = cfg.nScore
            data.join_cnt = self.emenyData_free.join_cnt or 0
        else
            data = self.emenyData_free
            data.teams = self:SetTeams(self.emenyData_free.teams)
        end
    end
    return data
end

function this:SetTeams(_teams)
    local teams = {}
    for k, v in ipairs(_teams) do
        local teamData = TeamData.New()
        teamData:SetData(v)
        table.insert(teams, teamData)
    end
    return teams
end

--对方拒绝
function this:BeInviteRespond(proto)
    self.inviteFriendDatas[proto.uid].is_cancel = proto.is_receive
    self.inviteFriendDatas[proto.uid].invite_time = TimeUtil:GetTime() --拒绝时间
end

--拒绝别人的邀请
function this:BeInviteRet(uid)
    if(self.beInviteDatas and self.beInviteDatas[uid])then 
        self.beInviteDatas[uid].is_cancel = true
    end 
end

return this
