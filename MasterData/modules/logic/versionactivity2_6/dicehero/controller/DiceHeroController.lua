-- chunkname: @modules/logic/versionactivity2_6/dicehero/controller/DiceHeroController.lua

module("modules.logic.versionactivity2_6.dicehero.controller.DiceHeroController", package.seeall)

local DiceHeroController = class("DiceHeroController", BaseController)

function DiceHeroController:addConstEvents()
	OpenController.instance:registerCallback(OpenEvent.GetOpenInfoSuccess, self._onGetOpenInfoSuccess, self)
	MainController.instance:registerCallback(MainEvent.OnFuncUnlockRefresh, self._onGetOpenInfoSuccess, self)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, self._newFuncUnlock, self)
end

function DiceHeroController:_onGetOpenInfoSuccess()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DiceHero) then
		self:_getInfo()
	end
end

function DiceHeroController:_newFuncUnlock(newIds)
	for i, id in ipairs(newIds) do
		if id == OpenEnum.UnlockFunc.DiceHero then
			self:_getInfo()

			break
		end
	end
end

function DiceHeroController:_getInfo()
	DiceHeroRpc.instance:sendDiceHeroGetInfo()
end

DiceHeroController.instance = DiceHeroController.New()

return DiceHeroController
