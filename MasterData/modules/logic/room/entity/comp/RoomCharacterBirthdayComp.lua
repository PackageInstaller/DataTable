-- chunkname: @modules/logic/room/entity/comp/RoomCharacterBirthdayComp.lua

module("modules.logic.room.entity.comp.RoomCharacterBirthdayComp", package.seeall)

local RoomCharacterBirthdayComp = class("RoomCharacterBirthdayComp", LuaCompBase)
local EFFECT_SCALE = 0.1

function RoomCharacterBirthdayComp:ctor(entity)
	self.entity = entity
end

function RoomCharacterBirthdayComp:init(go)
	self.go = go
	self.birthdayRes = nil
	self.birthdayEffKey = RoomEnum.EffectKey.CharacterBirthdayEffKey
	self.goTrs = go.transform
	self._scene = GameSceneMgr.instance:getCurScene()
end

function RoomCharacterBirthdayComp:addEventListeners()
	RoomCharacterController.instance:registerCallback(RoomEvent.UpdateCharacterMove, self._updateCharacterMove, self)
	RoomMapController.instance:registerCallback(RoomEvent.ConfirmCharacter, self.onPlaceCharacter, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function RoomCharacterBirthdayComp:removeEventListeners()
	RoomCharacterController.instance:unregisterCallback(RoomEvent.UpdateCharacterMove, self._updateCharacterMove, self)
	RoomMapController.instance:unregisterCallback(RoomEvent.ConfirmCharacter, self.onPlaceCharacter, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function RoomCharacterBirthdayComp:_updateCharacterMove()
	if self.entity.isPressing then
		return
	end

	local mo = self.entity:getMO()

	if not mo then
		return
	end

	if self._scene.character:isLock() then
		return
	end

	local curState = mo:getMoveState()

	if curState == self._lastAnimState then
		return
	end

	self._lastAnimState = curState
	self._curBlockMO = self:_findBlockMO()

	self:checkBirthday()
end

function RoomCharacterBirthdayComp:onPlaceCharacter()
	self._curBlockMO = self:_findBlockMO()

	self:checkBirthday()
end

function RoomCharacterBirthdayComp:_findBlockMO()
	if self.__willDestroy then
		return
	end

	if self.goTrs then
		local x, y, z = transformhelper.getPos(self.goTrs)
		local vector2 = Vector2(x, z)
		local hexPoint = HexMath.positionToRoundHex(vector2, RoomBlockEnum.BlockSize)

		return RoomMapBlockModel.instance:getBlockMO(hexPoint.x, hexPoint.y)
	end
end

function RoomCharacterBirthdayComp:_onDailyRefresh()
	if self.__willDestroy then
		return
	end

	local mo = self.entity:getMO()

	if not mo then
		return
	end

	local isOnBirthday = RoomCharacterModel.instance:isOnBirthday(mo.id)

	if not isOnBirthday then
		mo:replaceIdleState()
	end
end

function RoomCharacterBirthdayComp:onStart()
	return
end

function RoomCharacterBirthdayComp:onEffectRebuild()
	local effectComp = self.entity.effect
	local isHasBirthdayEff = effectComp:isHasEffectGOByKey(self.birthdayEffKey)

	if not isHasBirthdayEff then
		return
	end

	local effGo = effectComp:getEffectGO(self.birthdayEffKey)

	self:setEffGoDict(effGo)

	if self.tmpMeetingYear then
		self:playBirthdayFirework(self.tmpMeetingYear)

		self.tmpMeetingYear = nil
	end
end

function RoomCharacterBirthdayComp:setEffGoDict(effectRootGo)
	self.effGoDict = {}

	if gohelper.isNil(effectRootGo) then
		return
	end

	local rootGo = gohelper.findChild(effectRootGo, "root")
	local rootTrans = rootGo.transform
	local itemCount = rootTrans.childCount

	for i = 1, itemCount do
		local child = rootTrans:GetChild(i - 1)
		local name = child.name
		local year = tonumber(name)

		if not string.nilorempty(year) then
			local go = child.gameObject

			self.effGoDict[year] = go

			gohelper.setActive(go, false)
		end
	end
end

function RoomCharacterBirthdayComp:checkBirthday()
	if self.__willDestroy then
		return
	end

	local replaceAnimState
	local mo = self.entity:getMO()
	local heroId = mo and mo.heroId
	local isOnBirthday = RoomCharacterModel.instance:isOnBirthday(heroId)
	local inSelfBirthdayBlock = self:_isSelfBirthdayBlock(self._curBlockMO, heroId)

	if isOnBirthday and inSelfBirthdayBlock then
		local targetHeroId = HeroConfig.instance:getSPOriginalHero(heroId) or heroId
		local targetHeroMo = HeroModel.instance:getByHeroId(targetHeroId)
		local meetingYear = targetHeroMo and targetHeroMo:getMeetingYear()

		self:playBirthdayFirework(meetingYear)

		replaceAnimState = RoomCharacterEnum.CharacterMoveState.BirthdayIdle
	end

	mo:replaceIdleState(replaceAnimState)
end

function RoomCharacterBirthdayComp:_isSelfBirthdayBlock(blockMO, heroId)
	if not blockMO or blockMO:getDefineId() ~= blockMO:getDefineId(true) then
		return false
	end

	local cfg = RoomConfig.instance:getSpecialBlockConfig(blockMO.blockId)
	local targetHeroId = HeroConfig.instance:getSPOriginalHero(heroId) or heroId

	return cfg and cfg.heroId == targetHeroId
end

function RoomCharacterBirthdayComp:playBirthdayFirework(meetingYear)
	if not meetingYear then
		return
	end

	meetingYear = math.max(1, meetingYear)

	if not self.effGoDict then
		self:initEffect()

		self.tmpMeetingYear = meetingYear

		return
	end

	for year, effGo in pairs(self.effGoDict) do
		gohelper.setActive(effGo, false)

		if year == meetingYear then
			gohelper.setActive(effGo, true)
		end
	end
end

function RoomCharacterBirthdayComp:initEffect()
	local effectComp = self.entity.effect
	local isHasBirthdayEff = effectComp:isHasEffectGOByKey(self.birthdayEffKey)

	if isHasBirthdayEff then
		local effGo = effectComp:getEffectGO(self.birthdayEffKey)

		self:setEffGoDict(effGo)
	else
		local localScale = Vector3.one * EFFECT_SCALE

		effectComp:addParams({
			[self.birthdayEffKey] = {
				res = RoomScenePreloader.RecCharacterBirthdayEffect,
				localScale = localScale
			}
		})
	end

	effectComp:refreshEffect()
end

function RoomCharacterBirthdayComp:beforeDestroy()
	self.tmpMeetingYear = nil
	self.__willDestroy = true

	self:removeEventListeners()
end

function RoomCharacterBirthdayComp:onDestroy()
	self.effGoDict = nil
end

return RoomCharacterBirthdayComp
