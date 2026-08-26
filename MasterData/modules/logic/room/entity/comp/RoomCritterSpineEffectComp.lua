-- chunkname: @modules/logic/room/entity/comp/RoomCritterSpineEffectComp.lua

module("modules.logic.room.entity.comp.RoomCritterSpineEffectComp", package.seeall)

local RoomCritterSpineEffectComp = class("RoomCritterSpineEffectComp", RoomBaseSpineEffectComp)

function RoomCritterSpineEffectComp:onInit(go)
	local roomCritterMO = self.entity:getMO()

	self._critterId = roomCritterMO.critterId
	self._skinId = roomCritterMO:getSkinId()
end

function RoomCritterSpineEffectComp:_logNotPoint(cfg)
	logNormal(string.format("[export_魔精交互特效] 魔精挂点找不到, critterId:%s skinId:%s  id:%s  animName:%s point:%s", self._critterId, cfg.skinId, cfg.id, cfg.animName, cfg.point))
end

function RoomCritterSpineEffectComp:_logResError(cfg)
	logError(string.format("RoomCritterSpineEffectComp 加载失败, critterId:%s skinId:%s  id:%s  animName:%s  effectRes:%s", self._critterId, cfg.skinId, cfg.id, cfg.animName, cfg.effectRes))
end

function RoomCritterSpineEffectComp:getEffectCfgList()
	local roomCritterMO = self.entity:getMO()

	if roomCritterMO then
		return CritterConfig.instance:getCritterEffectList(roomCritterMO:getSkinId())
	end
end

function RoomCritterSpineEffectComp:play(animState)
	RoomCritterSpineEffectComp.super.play(self, animState)

	local roomCritterMO = self.entity:getMO()
	local critterId = roomCritterMO and roomCritterMO.critterId
	local audioIdList = CritterConfig.instance:getCritterInteractionAudioList(critterId, animState)

	if audioIdList then
		for _, audioId in ipairs(audioIdList) do
			AudioMgr.instance:trigger(audioId, self.go)
		end
	end
end

function RoomCritterSpineEffectComp:getSpineComp()
	return self.entity.critterspine
end

return RoomCritterSpineEffectComp
