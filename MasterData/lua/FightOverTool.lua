--结算数据封装工具（结算协议太多了）
FightOverTool = {}
local this = FightOverTool

--封装data
function this.PushEnd(_data, _isWin, _team, _rewards, _jf, _exp, _nPlayerExp, _favor,isForceOver, _elseData)
	local data = _data or {}
	data.bIsWin = _isWin or false
	data.team = _team
	data.rewards = _rewards
	data.jf = _jf or 0
	data.exp = _exp or 0
	data.nPlayerExp = _nPlayerExp or 0
	data.favor = _favor
	data.elseData = _elseData
	if(isForceOver) then
		FightActionMgr:Surrender(data)
	else
		FightActionMgr:Push(FightActionMgr:Apply(FightActionType.FightEnd, data))
	end
end
--结果 RogueT
function this.RogueTInfoUpdate(proto,isForceOver)
	local team = this.GetTeamData(RogueTMgr:GetTeamIndex2(proto.nDuplicateID), false);
	local exp = this.GetExpList(proto, false);
	this.PushEnd(nil, proto.bIsWin, team, proto.rewards, 0, exp, 0,proto.cardsExp, isForceOver,proto)
end

--结果 RogueS
function this.RogueSInfoUpdate(proto,isForceOver)
	local team = this.GetTeamData(eTeamType.RogueS+proto.round, false);
	local exp = this.GetExpList(proto, false);
	this.PushEnd(nil, proto.bIsWin, team, nil, 0, exp, 0,proto.cardsExp, isForceOver,proto)
end

--结果 Rogue
function this.RogueInfoUpdate(proto)
	local team = this.GetTeamData(eTeamType.Rogue, false);
	local exp = this.GetExpList(proto, false);
	this.PushEnd(nil, proto.bIsWin, team, proto.fisrtPassReward, 0, exp, 0,proto.cardsExp, proto.isForceOver,proto)
end

--结果 TowerDeep
function this.TowerDeepInfoUpdate(proto,isForceOver)
	local team = this.GetTeamData(eTeamType.TowerDeep + proto.round - 1, false);
	local exp = this.GetExpList(proto, false);
	this.PushEnd(nil, proto.bIsWin, team, proto.reward, 0, exp, 0,proto.cardsExp, isForceOver,proto)
end

--结果 连锁战线
function this.Trials2InfoUpdate(proto,isForceOver)
	local team = this.GetTeamData(eTeamType.ChainFront + proto.round - 1, false);
	local exp = this.GetExpList(proto, false);
	this.PushEnd(nil, proto.bIsWin, team, proto.reward, 0, exp, 0,proto.cardsExp, isForceOver,proto)
end

--结果 实时pvp    proto.type:  RealArmyType.Friend  RealArmyType.Freedom
function this.RealTimeFightFinish(proto,score)
    --LogError(proto);
	local team = this.GetTeamData(proto.teamId, false);
	local exp = this.GetExpList(proto, false);
	this.PushEnd(nil, proto.bIsWin, team, nil, score or 0, exp, 0,proto.cardsExp, proto.isForceOver, {type =proto.type, bIsWin = proto.bIsWin})
end

--结果 演习
function this.PracticeInfoUpdate(proto, score)
	local team = this.GetTeamData(eTeamType.PracticeAttack, false);
	local exp = this.GetExpList(proto, false);
	this.PushEnd(nil, proto.bIsWin, team, nil, score, exp, 0,proto.cardsExp, proto.isForceOver,{bIsWin = proto.bIsWin})
end

--基地突袭 BuildingProto:AssualtAttackRet
function this.AssualtAttackRet(proto)
	local team = this.GetTeamData(proto.teamId, false);
	local exp = this.GetExpList(proto, false);
	this.PushEnd(nil, proto.bIsWin, team, proto.rewards, 0, exp, 0,proto.cardsExp, proto.isForceOver, RealArmyType.Matrix)
end

--世界boss  FightProto:OnBossOver
function this.OnBossOver(proto, isForceOver)
	local team = this.GetTeamData(eTeamType.DungeonFight, false)  --暂时默认队伍1 todo
	local exp = this.GetExpList(proto, false)
	local rewards = {}
	--封装奖励（击杀奖励会特殊显示）
	if(proto.winner and proto.winner == PlayerClient:GetID() and proto.killReward ~= nil) then
		rewards = proto.killReward or {}
		if(proto.reward and #proto.reward > 0) then
			for i, v in pairs(proto.reward) do
				v.isKill = true
				table.insert(rewards, v)
			end
		end
	else
		rewards = proto.reward
	end
	local bIsWin =(proto.winner ~= nil and proto.winner == PlayerClient:GetID()) and true or false
	local _data = {}
	if(bIsWin) then
		_data.forceDeadTeam = TeamUtil.enemyTeamId;
	end
	this.PushEnd(_data, bIsWin, team, rewards, 0, exp, 0, proto.cardsExp, isForceOver, proto.winner)
end

--战场boss  FightProto:OnBossOver
function this.OnFieldBossOver(proto, isForceOver)
	local team = this.GetTeamData(eTeamType.DungeonFight, false)  --暂时默认队伍1 todo
	local exp = this.GetExpList(proto, false)
	local bIsWin = true
	local _data = {}
	_data.damage = proto.nDamage
	_data.hDamage = proto.nHightest
	this.PushEnd(_data, bIsWin, team, proto.reward , 0, exp, 0, proto.cardsExp, isForceOver)
end

--公会战房间
function this.OnGuildBossOver(proto, isForceOver)
	Log("FightOverTool:OnGuildBossOver");
	Log(proto);
	local team = this.GetTeamData(eTeamType.GuildFight, false)  --暂时默认队伍1 todo
	local exp = this.GetExpList(proto, false)
	local rewards = {}
	--封装奖励（击杀奖励会特殊显示）
	if(proto.winner and proto.winner == PlayerClient:GetID() and proto.killReward ~= nil) then
		rewards = proto.killReward or {}
		if(proto.reward and #proto.reward > 0) then
			for i, v in pairs(proto.reward) do
				v.isKill = true
				table.insert(rewards, v)
			end
		end
	else
		rewards = proto.reward
	end
	local bIsWin =(proto.winner ~= nil and proto.winner == PlayerClient:GetID()) and true or false
	local _data = {}
	--造成的总伤害值
	_data.damage=0;
	if	g_FightMgr.tDamageStat and g_FightMgr.tDamageStat[1] then
		for k,v in pairs(g_FightMgr.tDamageStat[1]) do
			_data.damage=_data.damage+v;
		end
	end
	local fightRoom=GuildFightMgr:GetCurrFightRoomInfo();
	if fightRoom then
		_data.currHP=fightRoom:GetCurrHP();
		_data.totalHP=fightRoom:GetHP();
	end
	if(bIsWin) then
		_data.forceDeadTeam = TeamUtil.enemyTeamId;
	end
	this.PushEnd(_data, bIsWin, team, rewards, 0, exp, 0,proto.cardsExp, isForceOver, proto.winner)
end

--世界boss  FightProto:OnBossOver
function this.OnGlobalBossOver(proto, isForceOver)
	local team = this.GetTeamData(eTeamType.DungeonFight, false)  --暂时默认队伍1 todo
	local exp = this.GetExpList(proto, false)
	local bIsWin = true
	local _data = {}
	_data.damage = proto.nDamage
	_data.hDamage = proto.nHightest
	this.PushEnd(_data, bIsWin, team, proto.reward , 0, exp, 0, proto.cardsExp, isForceOver)
end

--主线、每日
function this.OnDuplicate(proto, isForceOver)
	local team = this.GetTeamData(DungeonMgr:GetFightTeamId(), true);
	local exp = this.GetExpList(proto, true);
	local rewards = this.GetDuplicateRewards(proto);
	this.PushEnd(nil, proto.bIsWin, team, rewards, 0, exp, proto.nPlayerExp, proto.cardsExp, isForceOver);
end


--强制退出（关卡和世界boss需要自己封装数据）
function this.ApplyEnd(sceneType)
	if(sceneType == SceneType.PVPMirror) then
		this.PracticeInfoUpdate({bIsWin = false, teamId = eTeamType.PracticeAttack, isForceOver = true}, 0)
	elseif(sceneType == SceneType.BOSS) then
		this.OnBossOver({}, true)
	elseif(sceneType==SceneType.GuildBOSS) then
		this.OnGuildBossOver({}, true)
	elseif (sceneType==SceneType.GlobalBoss) then
		this.OnGlobalBossOver({},true)
	elseif (sceneType == SceneType.RogueMap) then
		this.OnRogueMapOver({}, true)
	elseif (sceneType == SceneType.RogueMapSup) then
		this.OnRogueMapSupportOver({}, true)
	elseif (sceneType == SceneType.MultTeam) then
		this.OnMultTeamBattleOver({},true)
	elseif (sceneType == SceneType.PeriodicBoss) then
		this.OnPeriodicBossOver({},true)
	else
        this.OnDuplicate({bIsWin = false}, true)
	end
end

--在走格子界面失败时使用
function this.OnBattleViewLost()
	local team = this.GetTeamData(DungeonMgr:GetFightTeamId(), true);
	local data = {};
	data.bIsWin = false
	data.team = team
	data.rewards = {}
	data.jf = 0
	data.exp = {0}
	data.nPlayerExp = 0
	data.sceneType = SceneType.PVE
	CSAPI.OpenView("FightOverResult", data);
end

--扫荡使用
function this.OnSweepOver(proto, isForceOver)
	local team = this.GetTeamData(DungeonMgr:GetFightTeamId(), false); 
	local exp = this.GetExpList(proto, true);
	local data = {}
	data.bIsWin = true
	data.team = team
	data.exp = exp
	data.nPlayerExp = proto.nPlayerExp
	data.favor = proto.cardsExp
	data.elseData = {rewardList = proto.rewardList,bufRewardList = proto.passivBufRewardList or {},specialRewardList =proto.specialRewardList or {} ,isSweep = true,id = proto.id}
	data.rewards = this.GetSweepRewards(proto);
	CSAPI.OpenView("FightOverResult", data);
end

function this.OnGlobalBossSweepOver(proto, isForceOver)
	local team = this.GetTeamData(eTeamType.DungeonFight, false)  --暂时默认队伍1 todo
	local exp = this.GetExpList(proto, false)
	local bIsWin = true
	local _data = {}
	_data.bIsWin = true
	_data.team = team
	_data.exp = exp or 0
	_data.nPlayerExp = proto.nPlayerExp or 0
	_data.favor = proto.cardsExp
	_data.damage = proto.nDamage
	_data.hDamage = proto.nHightest
	_data.rewards = proto.reward
	_data.elseData = {isGlobalSweep = true}
	CSAPI.OpenView("FightOverResult", _data);
end

--模拟使用
function this.OnDirllOver(stage, winer)
	local team = this.GetTeamData(DungeonMgr:GetFightTeamId(), true); 
	local data = {}
	this.PushEnd(data,winer == 1,team,nil, 0, {}, 0,{},false,{isDirll = true,isWin = winer == 1})
end

--世界boss模拟使用
function this.OnGlobalBossDirllOver(stage, winer,damage)
	local team = this.GetTeamData(DungeonMgr:GetFightTeamId(), true); 
	local data = {}
	data.damage = damage
	this.PushEnd(data,true,team,nil, 0, {}, 0,{},false,{isBossDirll = true,isWin = true})
end

--递归沙河
function this.OnMultTeamBattleOver(proto,isForceOver,isDirll)
	local team = this.GetTeamData(eTeamType.MultBattle, false);
	local exp = this.GetExpList(proto, false);
	local _data=table.copy(proto)
	_data.sceneType=SceneType.MultTeam;
	this.PushEnd(_data, proto.bIsWin, team, nil, 0, exp, 0,{},isForceOver,{isMultTeam=true,isDirll=isDirll})
end

function this.OnRogueMapOver(proto, isForceOver)
	local team = this.GetTeamData(RogueMapMgr:GetTeamFightId(), true);
	local exp = this.GetExpList(proto, true);
	local rewards = this.GetDuplicateRewards(proto);
	RogueMapMgr:SetIsDirll(proto.isSimulated)
	this.PushEnd(nil, proto.bIsWin, team, rewards, 0, exp, proto.nPlayerExp, proto.cardsExp, isForceOver,{fightExp = proto.nExp,bIsWin = proto.bIsWin});
end

function this.OnRogueMapDungeonOver(proto, isForceOver)
	local team = this.GetTeamData(RogueMapMgr:GetTeamFightId(), true);
	local exp = this.GetExpList(proto, true);
	local _data = {}
	_data.bIsWin = true
	_data.sceneType =SceneType.RogueMap
	_data.team = team
	_data.exp = exp or 0
	_data.nPlayerExp = proto.nPlayerExp or 0
	_data.favor = proto.cardsExp
	_data.rewards = proto.rewards
	_data.elseData = {fightExp = proto.nExp}
	CSAPI.OpenView("FightOverResult", _data, {bIsWin = proto.bIsWin});
end

--秘境探索 支援战斗结束
function this.OnRogueMapSupportOver(proto, isForceOver)
	local team = this.GetTeamData(DungeonMgr:GetFightTeamId(), true);
	local exp = this.GetExpList(proto, true);
	local rewards = this.GetDuplicateRewards(proto);
	this.PushEnd(nil, proto.bIsWin, team, rewards, 0, exp, proto.nPlayerExp, proto.cardsExp, isForceOver,{bIsWin = proto.bIsWin});
end

function this.OnPeriodicBossOver(proto, isForceOver)
	local team = this.GetTeamData(DungeonMgr:GetFightTeamId());
	local rewards = this.GetDuplicateRewards(proto);
	local exp = this.GetExpList(proto, true);
	local info = proto.info or {}
	this.PushEnd(nil, proto.bIsWin, team, rewards, 0, exp, proto.nPlayerExp, proto.cardsExp, isForceOver,{bIsWin = proto.bIsWin,maxDamage = proto.maxDamage or 0,damage = proto.damage or 0});
end

function this.OnVirCatOver(proto, isForceOver)
	local team = this.GetTeamData(DungeonMgr:GetFightTeamId(), true);
	local rewards = this.GetDuplicateRewards(proto);
	local exp = this.GetExpList(proto, true);
	local info = proto.info or {}
	this.PushEnd(nil, proto.bIsWin, team, rewards, 0, exp, proto.nPlayerExp, proto.cardsExp, isForceOver,{bIsWin = proto.bIsWin,damage = proto.score,nodeId = proto.nodeId,isSimulated = proto.isSimulated});
end


--返回编队数据
function this.GetTeamData(teamID, isDuplicate)
	local teamData = nil;
	if isDuplicate then
		teamData = TeamMgr:GetFightTeamData(teamID);
	else
		teamData = TeamMgr:GetTeamData(teamID)
	end
	return teamData;
end

--返回经验值列表
function this.GetExpList(proto, isDuplicate)
	local exp = {};
	if isDuplicate and proto and proto.cards then
		for k, v in ipairs(proto.cards) do
			exp[v.id] = v.num;
		end
	else
		exp = {proto.exp or 0}
	end
	return exp
end

--返回关卡结算奖励信息
function this.GetDuplicateRewards(proto)
	local rewards = {};
	if proto then
		if proto.gold and proto.gold>0 then
			table.insert(rewards, {id = ITEM_ID.GOLD, num = proto.gold, type = 2});
		end
		if proto.reward then
			table.sort(proto.reward, this.SortReward);
			for k, v in ipairs(proto.reward) do
				if v.num>0 then
					table.insert(rewards, v);
				end
			end
		end
		if proto.sectionMultiReward then
			for k, v in ipairs(proto.sectionMultiReward) do
				for _, val in ipairs(rewards) do
					if val.type == v.type and val.id == v.id then
						if val.type == RandRewardType.EQUIP then
							table.insert(rewards, val);
							break;
						else
							val.multiNum = v.num / val.num + 1;
							val.num = val.num + v.num;
							v.id = - 1000;--代表已经匹配过
							break;
						end
					end
				end
			end
		end
		if proto.addReward then
			table.sort(proto.addReward, this.SortReward);
			for k, v in ipairs(proto.addReward) do
				v.isAdd = true;
				table.insert(rewards, v);
			end
		end
	end
	return rewards;
end

--返回扫荡结算奖励信息
function this.GetSweepRewards(proto)
	local rewards = {};
	if proto then
		-- if proto.gold and proto.gold>0 then
		-- 	table.insert(rewards, {id = ITEM_ID.GOLD, num = proto.gold, type = 2});
		-- end
		if proto.rewardList then
			for k, v in ipairs(proto.rewardList) do
				if v.reward then
					table.sort(v.reward, this.SortReward);
					for k, m in ipairs(v.reward) do
						if m.num>0 then
							table.insert(rewards, m);
						end
					end
				end				
			end
		end
		if proto.passivBufRewardList then
			for k, v in ipairs(proto.passivBufRewardList) do
				if v.reward then
					table.sort(v.reward, this.SortReward);
					for k, m in ipairs(v.reward) do
						if m.num>0 then
							table.insert(rewards, m);
						end
					end
				end				
			end
		end
		if proto.specialRewardList then
			for k, v in ipairs(proto.specialRewardList) do
				if v.reward then
					table.sort(v.reward, this.SortReward);
					for k, m in ipairs(v.reward) do
						if m.num>0 then
							m.tag = ITEM_TAG.TimeLimit
							table.insert(rewards, m);
						end
					end
				end				
			end
		end
	end
	return rewards;
end

--排序奖励物品
function this.SortReward(a, b)
	local dataA = this.GetData(a.id, a.type);
	local dataB = this.GetData(b.id, b.type);
	if dataA ~= nil and dataB ~= nil then
		if(a.type == b.type and a.type == RandRewardType.ITEM) then--都是物品的时候
			return this.SortItem(dataA, dataB);
		elseif(a.type == b.type) then--类型相等的时候
			return dataA:GetQuality() > dataB:GetQuality();
		else
			if(a.type == RandRewardType.CARD and b.type == RandRewardType.ITEM and dataB:GetType() == 5) or(b.type == RandRewardType.CARD and a.type == RandRewardType.ITEM and dataA:GetType() == 5) then --都是卡牌的时候
				return dataA:GetQuality() > dataB:GetQuality();
			else
				return a.type < b.type;--按类型排序
			end
		end
	else
		return false;
	end
end

--根据掉落类型和cfgid获取物品品质
function this.GetData(cid, type)
	local cfg = nil;
	if type == RandRewardType.ITEM then--物品
		cfg = GoodsData();
		cfg:InitCfg(cid);
	elseif type == RandRewardType.CARD then--卡牌
		cfg = CharacterCardsData();
		cfg:InitCfg(cid);
	elseif type == RandRewardType.EQUIP then--装备
		cfg = EquipData();
		cfg:InitCfg(cid);
	end
	return cfg;
end

--排序方法
function this.SortItem(a, b)
	if a:GetType() ~= b:GetType() and(a:GetType() == 5 or b:GetType() == 5) then
		return a:GetType() == 5;
	elseif(a:GetType() == b:GetType()) then
		return a:GetQuality() > b:GetQuality();
	else
		return a:GetType() > b:GetType();
	end
end


return this
