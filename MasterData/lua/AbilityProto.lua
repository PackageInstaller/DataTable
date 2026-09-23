--技能组协议
AbilityProto = {
	useCallBack = nil,
}

--获取技能组
function AbilityProto:GetSkillGroup()
	local proto = {"AbilityProto:GetSkillGroup"};
	NetMgr.net:Send(proto);
end

function AbilityProto:GetSkillGroupRet(proto)
	TacticsMgr:SetData(proto.groups);
end

--使用技能组
function AbilityProto:SkillGroupUse(id, teamId, func)
	self.useCallBack = func;
	local proto = {"AbilityProto:SkillGroupUse", {id = id, team_id = teamId}};
	NetMgr.net:Send(proto);
end

function AbilityProto:SkillGroupUseRet(proto)
	if self.useCallBack then
		self.useCallBack(proto);
		self.useCallBack = nil;
	end
end

--升级技能组
function AbilityProto:SkillGroupUpgrade(_id)
	local proto = {"AbilityProto:SkillGroupUpgrade", {id = _id}}
	NetMgr.net:Send(proto)
end

function AbilityProto:SkillGroupUpgradeRet(proto)
	TacticsMgr:UpdateData(proto.group)
	CSAPI.PlayUISound("ui_battle_victory_settlement")
	--EventMgr.Dispatch(EventType.Player_Ability_Refresh)
	--EventMgr.Dispatch(EventType.Player_Ability_Show)
end

--获取能力
function AbilityProto:GetAbility()
	local proto = {"AbilityProto:GetAbility"}
	NetMgr.net:Send(proto)
end

--添加能力
function AbilityProto:AddAbility(_id)
	local proto = {"AbilityProto:AddAbility", {id = _id}}
	NetMgr.net:Send(proto)
end

--重置能力（全部可重置的）
function AbilityProto:ResetAbility()
	local proto = {"AbilityProto:ResetAbility"}
	NetMgr.net:Send(proto)
end

--刷新能力
function AbilityProto:GetAbilityRet(proto)
	PlayerAbilityMgr:SetData(proto)
	EventMgr.Dispatch(EventType.Player_Ability_Refresh)
end

