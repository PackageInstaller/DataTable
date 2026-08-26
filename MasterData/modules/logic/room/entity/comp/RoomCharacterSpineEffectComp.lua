-- chunkname: @modules/logic/room/entity/comp/RoomCharacterSpineEffectComp.lua

module("modules.logic.room.entity.comp.RoomCharacterSpineEffectComp", package.seeall)

local RoomCharacterSpineEffectComp = class("RoomCharacterSpineEffectComp", RoomBaseSpineEffectComp)

function RoomCharacterSpineEffectComp:onInit(go)
	local roomCharacterMO = self.entity:getMO()

	self._skinId = roomCharacterMO.skinId
	self._heroId = roomCharacterMO.heroId
end

function RoomCharacterSpineEffectComp:_logNotPoint(cfg)
	logNormal(string.format("[export_角色交互特效] 角色挂点找不到, heroId:%s skinId:%s  id:%s  animName:%s point:%s", self._heroId, self._skinId, cfg.id, cfg.animName, cfg.point))
end

function RoomCharacterSpineEffectComp:_logResError(cfg)
	logError(string.format("RoomCharacterSpineEffectComp 加载失败, heroId:%s skinId:%s  id:%s  animName:%s  effectRes:%s", self._heroId, self._skinId, cfg.id, cfg.animName, cfg.effectRes))
end

function RoomCharacterSpineEffectComp:getEffectCfgList()
	local roomCharacterMO = self.entity:getMO()
	local list = {}
	local cfgList = RoomConfig.instance:getCharacterEffectList(roomCharacterMO and roomCharacterMO.skinId)

	if cfgList then
		for i, cfg in ipairs(cfgList) do
			if not RoomCharacterEnum.maskInteractAnim[cfg.animName] then
				table.insert(list, cfg)
			end
		end
	end

	return list
end

function RoomCharacterSpineEffectComp:getSpineComp()
	return self.entity.characterspine
end

function RoomCharacterSpineEffectComp:onPlayShowEffect(animState, effectGo, animId)
	self:_specialIdleEffect(animState, effectGo, animId)
end

function RoomCharacterSpineEffectComp:_specialIdleEffect(animState, effectGo, animId)
	if RoomCharacterEnum.CharacterAnimStateName.SpecialIdle == animState and self._prefabNameDict then
		local prefabName = self._prefabNameDict[animId]
		local lookDir = self.entity.characterspine:getLookDir()
		local leftGO = gohelper.findChild(effectGo, prefabName .. "_r")
		local rightGO = gohelper.findChild(effectGo, prefabName .. "_l")

		gohelper.setActive(leftGO, lookDir == SpineLookDir.Left)
		gohelper.setActive(rightGO, lookDir == SpineLookDir.Right)
	end
end

return RoomCharacterSpineEffectComp
