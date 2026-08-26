-- chunkname: @modules/logic/fight/entity/effect/FightEntityWadingEffect.lua

module("modules.logic.fight.entity.effect.FightEntityWadingEffect", package.seeall)

local FightEntityWadingEffect = class("FightEntityWadingEffect", FightBaseClass)
local FightHelper = FightHelper
local transformhelper = transformhelper
local gohelper = gohelper
local typeof = typeof
local MeshRenderer = UnityEngine.MeshRenderer
local mountbody = ModuleEnum.SpineHangPoint.mountbody
local string = string
local MaterialUtil = MaterialUtil

function FightEntityWadingEffect:onConstructor(entity)
	self.entity = entity
	self.entityTransform = self.entity.go.transform
	self.entityData = entity.entityData
	self.vector = Vector4.New(0, 0, 0, 0)

	self:com_registFightEvent(FightEvent.OnSceneLevelLoaded, self.onSceneLevelLoaded)
	self:com_registFightEvent(FightEvent.OnSkillPlayStart, self.onSkillPlayStart)
	self:com_registFightEvent(FightEvent.OnSkillPlayFinish, self.onSkillPlayFinish)
	self:com_registFightEvent(FightEvent.SetEntityAlpha, self.onSetEntityAlpha)
	self:showEffect()
end

function FightEntityWadingEffect:onSceneLevelLoaded()
	self:showEffect()
end

function FightEntityWadingEffect:showEffect()
	self:releaseEffect()

	local entity = self.entity
	local skinconfig = FightConfig.instance:getSkinCO(self.entityData.skin)

	if not skinconfig or skinconfig.isFly == 1 then
		return
	end

	local levelId = FightGameMgr.sceneLevelMgr:getCurLevelId()
	local levelCO = lua_scene_level.configDict[levelId]
	local wadeEffect = levelCO.wadeEffect

	if string.nilorempty(wadeEffect) then
		return
	end

	local foot = entity:getHangPoint(mountbody)

	if not foot then
		return
	end

	self.foot = foot

	local arr = string.split(wadeEffect, "#")
	local side = arr[1]

	if side == "1" then
		self.side = FightEnum.EntitySide.EnemySide
	elseif side == "2" then
		self.side = FightEnum.EntitySide.MySide
	elseif side == "3" then
		self.side = nil
	end

	if self.side and self.side ~= self.entity:getSide() then
		return
	end

	self.effectUrl = arr[2]

	local effectWrap = entity.effect:addHangEffect(self.effectUrl, ModuleEnum.SpineHangPointRoot)

	self.effectWrap = effectWrap

	effectWrap:setLocalPos(0, 0, 0)

	local entityId = self.entity.id

	FightRenderOrderMgr.instance:onAddEffectWrap(entityId, effectWrap)

	local x, y, z = FightHelper.getEntityStandPos(self.entityData)
	local offsetX, offsetY, offsetZ = transformhelper.getLocalPos(foot.transform)

	self.originPos = {
		x + offsetX,
		y + offsetY,
		z + offsetZ
	}
	self.standPos = {
		x,
		y,
		z
	}
	effectWrap = entity.effect:addGlobalEffect(self.effectUrl .. "_effect")

	effectWrap:setLocalPos(offsetX + x, 0, 0)

	self.effect2Wrap = effectWrap

	FightRenderOrderMgr.instance:onAddEffectWrap(entityId, effectWrap)

	self.updateItem = self:com_registUpdate(self.onUpdate)
end

local proName = "RolePos"

function FightEntityWadingEffect:onUpdate()
	local standPos = self.standPos
	local curPosX, curPosY, curPosz = transformhelper.getLocalPos(self.entityTransform)

	if curPosX ~= standPos[1] or curPosY ~= standPos[2] or curPosz ~= standPos[3] then
		local render = gohelper.findChildComponent(self.effectWrap.effectGO, "root/wave", typeof(MeshRenderer))

		if render and render.material then
			local footX, footY, footZ = transformhelper.getPos(self.foot.transform)
			local originPos = self.originPos
			local offsetX = footX - originPos[1]
			local offsetY = footY - originPos[2]
			local offsetZ = footZ - originPos[3]
			local posStr = string.format("%f,%f,%f,0", offsetX, offsetY, offsetZ)

			self.vector:Set(offsetX, offsetY, offsetZ, 0)
			MaterialUtil.setPropValue(render.material, proName, "Vector4", self.vector)

			if footX < 0 and offsetY < 1 then
				self.effect2Wrap:setLocalPos(footX, 0, footZ)
			end
		end
	end
end

local directCharacterHitEffectType = {
	[FightEnum.EffectType.MISS] = true,
	[FightEnum.EffectType.DAMAGE] = true,
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.SHIELD] = true,
	[FightEnum.EffectType.SHIELDDEL] = true
}

function FightEntityWadingEffect:onSkillPlayStart(entity, skillId, stepData)
	local showEffect2Entity = {
		[stepData.fromId] = true,
		[stepData.toId] = true
	}

	for i, actEffectMO in ipairs(stepData.actEffect) do
		if directCharacterHitEffectType[actEffectMO.effectType] then
			showEffect2Entity[actEffectMO.targetId] = true
		end
	end

	if self.effect2Wrap then
		if showEffect2Entity[self.entity.id] then
			self.effect2Wrap:setActive(true, "FightEntityWadingEffect")
		else
			self.effect2Wrap:setActive(false, "FightEntityWadingEffect")
		end
	end
end

function FightEntityWadingEffect:onSkillPlayFinish()
	if self.effect2Wrap then
		self.effect2Wrap:setActive(true, "FightEntityWadingEffect")
	end
end

function FightEntityWadingEffect:onSetEntityAlpha(entityId, state)
	if entityId == self.entity.id and self.effect2Wrap then
		self.effect2Wrap:setActive(state, "onSetEntityAlpha")
	end
end

function FightEntityWadingEffect:releaseEffect()
	if self.effectWrap then
		self.entity.effect:removeEffect(self.effectWrap)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(self.entity.id, self.effectWrap)

		self.effectWrap = nil
	end

	if self.effect2Wrap then
		self.entity.effect:removeEffect(self.effect2Wrap)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(self.entity.id, self.effect2Wrap)

		self.effect2Wrap = nil
	end

	if self.updateItem then
		self:com_cancelUpdate(self.updateItem)

		self.updateItem = nil
	end
end

return FightEntityWadingEffect
