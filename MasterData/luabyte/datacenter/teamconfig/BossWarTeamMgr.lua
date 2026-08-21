local M = BaseClass("BossWarTeamMgr", require("DataCenter.TeamConfig.BaseTeamDataGetter"))
local MessageId = Proto.MessageId

function M:GetInstance()
    if rawget(self, "Instance") == nil then
        rawset(self, "Instance", self.New())
    end
    assert(self.Instance ~= nil)
    return self.Instance
end

function M:__init()
    -- body
end

function M:LoadData(callback)
    if callback then
        callback()
    end
end

function M:SetBossData(data)
    self.m_bossData = data -- BossWarData
end

function M:GetBossData()
    return self.m_bossData
end

function M:GetBossWarId()
    if not self.m_bossData then return 0 end
    return self.m_bossData:BossWarId()
end

-- mType: bossWar表type字段
function M:GetTeamById(mType)
    --Boss战teamId无意义,bossWar表type字段区分
    return self.m_bossData:GetTeam()
end

--更新编队
function M:RequestUpdateTeam(teamData)
    if self.m_rsUpdateTeam then return end
    --此处要模拟添加角色
    local nRequest = {}
    nRequest.Type = self.m_bossData:BossType()
    nRequest.Heroes = teamData.Heroes
    nRequest.CommanderSkills = teamData.CommanderSkills

    self.m_requestData = nRequest
    local messageId = MessageId.ResponseBossBattleUpdateTeam
    local handler = Bind(self, self.OnRspBossBattleUpdateTeam)
    self.m_rsUpdateTeam = NetPack:RegistResponse(messageId, handler)
    NetPack:SendMessage(MessageId.RequestBossBattleUpdateTeam, nRequest)
end

function M:OnRspBossBattleUpdateTeam(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsUpdateTeam)
    self.m_rsUpdateTeam = nil
    if result ~= 0 then return end

    self.m_bossData:UpdateTeam(self.m_requestData)
    EventMgr:Broadcast(UIMessageNames.UPDATETEAM)
end

--创建编队
function M:RequestCreateTeam(CRoleTeam)
    --此处要模拟删除角色
    self:RequestUpdateTeam(CRoleTeam)
end

--开战前是否需要激活队伍
function M:NeedActiveTeam()
    return false
end

--获得team最大数据
function M:GetTeamMaxNum()
    return 1
end

--黑名单
function M:GetBlackList()
    return nil
end

--是否显示编队名称
function M:IsShowTeamName()
    return false
end

-- 是否显示好友助战
function M:IsShowFriendHero()
    return false
end

return M
