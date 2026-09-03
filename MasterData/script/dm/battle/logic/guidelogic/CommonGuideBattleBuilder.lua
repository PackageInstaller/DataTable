-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/guidelogic/CommonGuideBattleBuilder.lua

CommonGuideBattleBuilder = class("CommonGuideBattleBuilder", GuideBattleBuilder)

function CommonGuideBattleBuilder:initialize()
	super.initialize(self)
end

function CommonGuideBattleBuilder:startBattle(guideThread, battleContext)
	if not super.startBattle(self, guideThread, battleContext) then
		return nil
	end

	self:newTimeline(kBRMainLine, "BattleMainLine")
	self:newTimeline(kBRGuideLine, "BattleGuideLine")
	self:addObjectEvent(kBRMainLine, "Start", {
		timeLimit = 180000,
		time = 0,
		breakDisabled = true,
		fieldCapacity = kBFCapacity6
	})

	return self
end

function CommonGuideBattleBuilder:finishBattle(result)
	if not self._guideLogic:finish(result) then
		return false
	end

	self:addObjectEvent(kBRMainLine, "Finish", {
		result = result,
		endframe = self._battleRecorder:getTotalFrames()
	})

	return true
end

function CommonGuideBattleBuilder:leaveBattle(data)
	self:addObjectEvent(kBRGuideLine, "LeaveBattle", data)

	return true
end

function CommonGuideBattleBuilder:addPlayer(playerInfo)
	self:newTimeline(playerInfo.id, "BattlePlayer")
	self:addObjectEvent(playerInfo.id, "NewPlayer", playerInfo)

	return self
end

function CommonGuideBattleBuilder:spawnUnit(unitInfo)
	self:newTimeline(unitInfo.id, "BattleUnit")
	self:addObjectEvent(unitInfo.id, "SpawnUnit", unitInfo)

	return self
end

function CommonGuideBattleBuilder:settleUnit(unitInfo)
	self:addObjectEvent(unitInfo.id, "Settled")

	return self
end

function CommonGuideBattleBuilder:syncEnergy(playerId, data)
	self:addObjectEvent(playerId, "SyncE", data)

	return self
end

function CommonGuideBattleBuilder:nextCard(playerId, data)
	self:addObjectEvent(playerId, "Card", data)

	return self
end

function CommonGuideBattleBuilder:startSkill(unitId, skillInfo)
	self:_beginSkill(unitId, skillInfo)

	return self
end

function CommonGuideBattleBuilder:performSkill(unitId, animation, targets, data)
	self:_perform(unitId, animation)

	if targets then
		for k, v in pairs(targets) do
			self:_addRoles(v, data)
		end
	end

	return self
end

function CommonGuideBattleBuilder:harmTargetView(unitId, data)
	self:addObjectEvent(unitId, "HarmTargetView", data)

	return self
end

function CommonGuideBattleBuilder:focus(unitId, data)
	self:addObjectEvent(unitId, "Focus", data)

	return self
end

function CommonGuideBattleBuilder:damageUnit(targetId, damage, actId)
	local data = {
		eft = damage.eft,
		raw = damage.raw,
		val = damage.val,
		crit = damage.crit,
		block = damage.block,
		act = actId
	}

	self:_hurt(targetId, data)

	return self
end

function CommonGuideBattleBuilder:cureUnit(targetId, cure, actId)
	local data = {
		eft = cure.eft,
		raw = cure.raw,
		val = cure.val,
		act = actId
	}

	self:_cure(targetId, data)

	return self
end

function CommonGuideBattleBuilder:dieUnit(targetId)
	self:addObjectEvent(targetId, "Die")

	return self
end

function CommonGuideBattleBuilder:_beginSkill(unitId, skillInfo)
	self:addObjectEvent(unitId, "BeginSkill", skillInfo)
end

function CommonGuideBattleBuilder:_perform(unitId, animation)
	self:addObjectEvent(unitId, "Perform", animation)
end

function CommonGuideBattleBuilder:_addRoles(targetId, roles)
	self:addObjectEvent(targetId, "AddRoles", roles)
end

function CommonGuideBattleBuilder:_hurt(targetId, data)
	self:addObjectEvent(targetId, "Hurt", data)
end

function CommonGuideBattleBuilder:_cure(targetId, data)
	self:addObjectEvent(targetId, "Cured", data)
end

function CommonGuideBattleBuilder:popBubble(unitId, data)
	self:addObjectEvent(unitId, "Speak", data)

	return self
end

function CommonGuideBattleBuilder:syncRage(unitId, result)
	self:addObjectEvent(unitId, "Sync", result)

	return self
end

function CommonGuideBattleBuilder:endSkill(unitId, actId)
	self:addObjectEvent(unitId, "EndSkill", {
		act = actId
	})

	return self
end

function CommonGuideBattleBuilder:addBuff(targetId, data)
	self:addObjectEvent(targetId, "AddBuff", data)

	return self
end

function CommonGuideBattleBuilder:endBattle(callback)
	if callback then
		callback()
	end

	return self
end
