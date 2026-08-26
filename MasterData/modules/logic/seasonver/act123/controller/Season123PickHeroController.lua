-- chunkname: @modules/logic/seasonver/act123/controller/Season123PickHeroController.lua

module("modules.logic.seasonver.act123.controller.Season123PickHeroController", package.seeall)

local Season123PickHeroController = class("Season123PickHeroController", BaseController)

function Season123PickHeroController:onOpenView(actId, stage, finishCall, finishCallObj, entryMOList, selectUid)
	self._finishCall = finishCall
	self._finishCallObj = finishCallObj

	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.HeroGroup)
	Season123PickHeroModel.instance:init(actId, stage, entryMOList, selectUid)
end

function Season123PickHeroController:onCloseView()
	Season123PickHeroModel.instance:release()
	CharacterBackpackCardListModel.instance:clearCardList()
end

function Season123PickHeroController:setHeroSelect(heroUid, value)
	if value then
		local count = Season123PickHeroModel.instance:getSelectCount()
		local limitCount = Season123PickHeroModel.instance:getLimitCount()

		if limitCount <= count then
			logNormal("max hero count!")

			return
		end
	end

	Season123PickHeroModel.instance:setHeroSelect(heroUid, value)
	self:notifyView()
end

function Season123PickHeroController:pickOver()
	local list = Season123PickHeroModel.instance:getSelectMOList()

	if self._finishCall then
		self._finishCall(self._finishCallObj, list)
	end
end

function Season123PickHeroController:updateFilter()
	Season123PickHeroModel.instance:refreshList()
	Season123Controller.instance:dispatchEvent(Season123Event.PickViewRefresh)
end

function Season123PickHeroController:notifyView()
	Season123PickHeroModel.instance:onModelUpdate()
	Season123Controller.instance:dispatchEvent(Season123Event.PickViewRefresh)
end

Season123PickHeroController.instance = Season123PickHeroController.New()

return Season123PickHeroController
