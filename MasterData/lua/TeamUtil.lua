local this = {};

--�������ҷ�����
this.myNetTeamId = 1;

--������ʹ�õĶ���ID
this.netTeamId1 = 1;
this.netTeamId2 = 2;

--�ҷ�����ID
this.ourTeamId = 1;
--�з�����ID
this.enemyTeamId = 2;

--�Ƿ��ҷ�
function this:IsOur(teamId)
    return teamId == self.ourTeamId;
end
--�Ƿ�з�
function this:IsEnemy(teamId)
    return teamId == self.enemyTeamId;
end

--��ȡ���ֶ���id
function this:GetOpponent(teamId)
    return self:IsEnemy(teamId) and self.ourTeamId or self.enemyTeamId;
end

--��ȡ���鷽��ֵ
function this:GetTeamDir(teamId)
    teamId = teamId or self.ourTeamId;
    return self:IsEnemy(teamId) and 1 or -1;
end
function this:GetTeamAngle(teamId)
    teamId = teamId or self.ourTeamId;
    return TeamUtil:IsEnemy(teamId) and 180 or 0;
end


--װ����ǰ�˶���Id
function this:ToClient(netTeamId)
    return netTeamId == self.myNetTeamId and self.ourTeamId or self.enemyTeamId;
end

--װ���ɺ�˶���Id
function this:ToNetwork(clientTeamId)  
    return clientTeamId == self.ourTeamId and self.myNetTeamId or (self.netTeamId1 + self.netTeamId2 - self.myNetTeamId);
end

--�����ҷ�����id
function this:SetMyNetTeamId(myTeamId)
    myTeamId = myTeamId or self.ourTeamId;  
    self.myNetTeamId = myTeamId;
end


--�Ƿ�з���Ӫ
function this:IsEnemyCamp(camp)
    return camp == 0;
end

return this;