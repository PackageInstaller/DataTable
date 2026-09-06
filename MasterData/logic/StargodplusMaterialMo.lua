-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargodplus/model/StargodplusMaterialMo.lua

module("logic.extensions.stargodplus.model.StargodplusMaterialMo", package.seeall)

local StargodplusMaterialMo = class("StargodplusMaterialMo")

function StargodplusMaterialMo:ctor()
	self._defineId = 0
	self.type = 0
	self.id = 0
	self._serverId = 0
	self._num = 0
end

function StargodplusMaterialMo:initData(info)
	self._info = info
	self.type = MatType.StarGodPlus
	self.id = info.defineId
	self._serverId = info.fillerId
	self._defineId = info.defineId
	self._cfg = StargodplusConfig.instance:getFillerCfg(info.defineId)
	self._bindRaceId = info.bindRaceId
end

function StargodplusMaterialMo:getMatType()
	return self.type
end

function StargodplusMaterialMo:getDefineId()
	return self._defineId
end

function StargodplusMaterialMo:getId()
	return self._serverId
end

function StargodplusMaterialMo:getQuality()
	if self._cfg then
		return self._cfg.quality
	end

	return 0
end

function StargodplusMaterialMo:getName()
	if not self._cfg then
		return ""
	end

	return self._cfg.name
end

function StargodplusMaterialMo:getEquipType()
	if not self._cfg then
		return 0
	end

	return self._cfg.type
end

function StargodplusMaterialMo:getUsePetId()
	return self._info.equippedPetId
end

function StargodplusMaterialMo:getUseRaceId()
	local petId = self:getUsePetId()
	local petMo = BagPetsController.instance:getPet(petId)

	if petMo == nil then
		return nil
	end

	return petMo.raceId
end

function StargodplusMaterialMo:getToStrenExp()
	if not self._cfg then
		return 0
	end

	return self._cfg.exp
end

function StargodplusMaterialMo:isWear()
	return self._info.equippedPetId > 0
end

function StargodplusMaterialMo:getBindPetId()
	return self._bindRaceId
end

function StargodplusMaterialMo:getEquipPetChecker()
	if not self._cfg then
		return ""
	end

	return self._cfg.equipPetChecker
end

return StargodplusMaterialMo
