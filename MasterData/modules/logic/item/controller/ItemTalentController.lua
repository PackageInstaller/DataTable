-- chunkname: @modules/logic/item/controller/ItemTalentController.lua

module("modules.logic.item.controller.ItemTalentController", package.seeall)

local ItemTalentController = class("ItemTalentController", BaseController)

function ItemTalentController:onInit()
	self.registerCallback(self, ItemTalentEvent.UseTalentItemSuccess, self._onSuccessUseItemOnHero, self)
end

function ItemTalentController:_onSuccessUseItemOnHero(itemUid, heroUid)
	local heroMo = HeroModel.instance:getById(heroUid)

	self:openTalentLevelUpView(heroMo.heroId)
end

function ItemTalentController:openTalentLevelUpView(param)
	ViewMgr.instance:openView(ViewName.ItemTalentHeroUpView, param)
end

function ItemTalentController:openTalentChooseView(param)
	local upgradeHeroList = ItemTalentModel.instance:getCouldUpgradeTalentHeroList(param.itemId)

	if not upgradeHeroList or #upgradeHeroList < 1 then
		GameFacade.showToast(ToastEnum.CruiseNoHeroCouldUpgradeTalent)

		return
	end

	ViewMgr.instance:openView(ViewName.ItemTalentChooseView, param)
end

ItemTalentController.instance = ItemTalentController.New()

return ItemTalentController
