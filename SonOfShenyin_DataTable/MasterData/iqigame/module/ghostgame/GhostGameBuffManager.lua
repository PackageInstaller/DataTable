-- chunkname: @IQIGame\\Module\\GhostGame\\GhostGameBuffManager.lua

local ghostGameBuff = require("IQIGame.Module.GhostGame.GhostGameBuff")

GhostGameBuffManager = {}

function GhostGameBuffManager.SlowEffect(target, strength, apply)
	if apply == true then
		target.moveSpeed = target.originalMoveSpeed * (1 - strength)
	else
		target.moveSpeed = target.originalMoveSpeed
	end
end

function GhostGameBuffManager.FrozenEffect(target, strength, apply)
	if apply == true then
		target.moveSpeed = 0
	else
		target.moveSpeed = target.originalMoveSpeed
	end
end

function GhostGameBuffManager.AttackBoostEffect(target, strength, apply)
	target:UpdateAttackPower(strength, apply)
end

function GhostGameBuffManager.AttackIntervalEffect(target, strength, apply)
	target:UpdateAttackInterval(strength, apply)
end

function GhostGameBuffManager.AttackAddNumEffect(target, strength, apply)
	target:UpdateAttackNum(strength, apply)
end

function GhostGameBuffManager.TriggerBuff(buffId)
	local buff = ghostGameBuff.New(buffId)

	if buff.buffCfg.Scope == 1 then
		GhostGameBuffManager.AddBuffForPlayer(buff)
	elseif buff.buffCfg.Scope == 2 and (buff.type == Constant.GhostGameBuffType.SlowDown or buff.type == Constant.GhostGameBuffType.Frozen) then
		GhostGameBuffManager.AddBuffForAll(ghostGameBuff.New(buffId))
	end

	log(string.format("触发Buff buffName:{%s}", buff.buffCfg.Name))
end

function GhostGameBuffManager.AddBuffForOnly(buff, target)
	return
end

function GhostGameBuffManager.AddBuffForAll(buff)
	for k, v in pairs(GhostGameModule.ghostGameScene.ghostGameCharacterList) do
		v:AddBuff(buff)
	end

	local tempBuff = GhostGameBuffManager.GetEnemyBuffByType(buff)

	tempBuff = tempBuff or buff

	EventDispatcher.Dispatch(EventID.GhostGameAddBuff, tempBuff)
	GhostGameModule.AddHoldBuffList(tempBuff)
end

function GhostGameBuffManager.GetEnemyBuffByType(buff)
	local existBuff

	for k, v in pairs(GhostGameModule.ghostGameScene.ghostGameCharacterList) do
		existBuff = v:GetBuff(buff.type)

		if existBuff then
			break
		end
	end

	return existBuff
end

function GhostGameBuffManager.AddBuffForPlayer(buff)
	GhostGameModule.ghostGameScene.ghostGamePlayer:AddBuff(buff)

	local existBuff = GhostGameBuffManager.GetPlayerBuffBuType(buff.type)

	if existBuff then
		EventDispatcher.Dispatch(EventID.GhostGameAddBuff, existBuff)
	else
		EventDispatcher.Dispatch(EventID.GhostGameAddBuff, buff)
	end
end

function GhostGameBuffManager.RemoveEnemyBuff(buff)
	GhostGameModule.RemoveHoldBuffList(buff)
end

function GhostGameBuffManager.GetPlayerBuffBuType(type)
	GhostGameModule.ghostGameScene.ghostGamePlayer:GetBuff(type)
end

return GhostGameBuffManager
