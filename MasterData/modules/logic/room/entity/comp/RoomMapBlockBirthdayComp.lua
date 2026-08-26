-- chunkname: @modules/logic/room/entity/comp/RoomMapBlockBirthdayComp.lua

module("modules.logic.room.entity.comp.RoomMapBlockBirthdayComp", package.seeall)

local RoomMapBlockBirthdayComp = class("RoomMapBlockBirthdayComp", LuaCompBase)

function RoomMapBlockBirthdayComp:ctor(entity)
	self.entity = entity
end

function RoomMapBlockBirthdayComp:init(go)
	self.go = go
end

function RoomMapBlockBirthdayComp:addEventListeners()
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function RoomMapBlockBirthdayComp:removeEventListeners()
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function RoomMapBlockBirthdayComp:_onDailyRefresh()
	self:refreshBirthday()
end

function RoomMapBlockBirthdayComp:onStart()
	return
end

function RoomMapBlockBirthdayComp:refreshBirthday()
	if self.__willDestroy then
		return
	end

	local blockMO = self.entity:getMO()
	local isBirthdayBlock = blockMO and blockMO.packageId == RoomBlockPackageEnum.ID.RoleBirthday

	if not isBirthdayBlock then
		return
	end

	if not self._birthdayAnimator then
		local birthdayGo = self.entity.effect:getGameObjectByPath(RoomEnum.EffectKey.BlockLandKey, RoomEnum.EntityChildKey.BirthdayBlockGOKey)

		if gohelper.isNil(birthdayGo) then
			return
		end

		self._birthdayAnimator = birthdayGo:GetComponent(RoomEnum.ComponentType.Animator)
	end

	if not self._birthdayAnimator then
		return
	end

	local spBlockCfg = RoomConfig.instance:getSpecialBlockConfig(blockMO.id)
	local isOnBirthday = RoomCharacterModel.instance:isOnBirthday(spBlockCfg and spBlockCfg.heroId)
	local animName = isOnBirthday and "v1a9_bxhy_terrain_role_birthday" or "shengri"

	self._birthdayAnimator:Play(animName, 0, 0)
end

function RoomMapBlockBirthdayComp:beforeDestroy()
	self.__willDestroy = true

	self:removeEventListeners()
end

function RoomMapBlockBirthdayComp:onDestroy()
	return
end

return RoomMapBlockBirthdayComp
