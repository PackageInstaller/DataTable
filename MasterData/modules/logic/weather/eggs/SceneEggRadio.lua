-- chunkname: @modules/logic/weather/eggs/SceneEggRadio.lua

module("modules.logic.weather.eggs.SceneEggRadio", package.seeall)

local SceneEggRadio = class("SceneEggRadio", SceneBaseEgg)

function SceneEggRadio:_onInit()
	self._heroOrSkinId = tonumber(self._eggConfig.actionParams)
	self._isMainScene = self._context and self._context.isMainScene

	if self._isMainScene then
		CharacterController.instance:registerCallback(CharacterEvent.ChangeMainHero, self._onChangeMainHero, self)
		CharacterController.instance:registerCallback(CharacterEvent.RandomMainHero, self._onRandomMainHero, self)
	end

	self:_onChangeMainHero()
end

function SceneEggRadio:_onChangeMainHero()
	if not self._isMainScene then
		self:setGoListVisible(true)

		return
	end

	local heroId, skinId = CharacterSwitchListModel.instance:getMainHero()

	self:setGoListVisible(self._heroOrSkinId ~= heroId and self._heroOrSkinId ~= skinId)
end

function SceneEggRadio:_onRandomMainHero(heroId, skinId)
	if not self._isMainScene then
		self:setGoListVisible(true)

		return
	end

	self:setGoListVisible(self._heroOrSkinId ~= heroId and self._heroOrSkinId ~= skinId)
end

function SceneEggRadio:_onSceneClose()
	if self._isMainScene then
		CharacterController.instance:unregisterCallback(CharacterEvent.ChangeMainHero, self._onChangeMainHero, self)
		CharacterController.instance:unregisterCallback(CharacterEvent.RandomMainHero, self._onRandomMainHero, self)
	end
end

return SceneEggRadio
