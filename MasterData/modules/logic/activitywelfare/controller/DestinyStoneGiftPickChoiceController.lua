-- chunkname: @modules/logic/activitywelfare/controller/DestinyStoneGiftPickChoiceController.lua

module("modules.logic.activitywelfare.controller.DestinyStoneGiftPickChoiceController", package.seeall)

local DestinyStoneGiftPickChoiceController = class("DestinyStoneGiftPickChoiceController", BaseController)

function DestinyStoneGiftPickChoiceController:onInit()
	self:reInit()
end

function DestinyStoneGiftPickChoiceController:reInit()
	return
end

function DestinyStoneGiftPickChoiceController:openHeroChoiceView(itemId)
	if itemId and itemId == DestinyStoneGiftPickChoiceEnum.V3a8ItemId then
		local isAllHeroDestinyLvMaxed = DestinyStoneGiftPickChoiceModel.instance:isAllHeroDestinyLvMaxed(itemId)

		if isAllHeroDestinyLvMaxed then
			GameFacade.showMessageBox(MessageBoxIdDefine.V3a8SelfSelectSixAllHeroLvMaxChangeItem, MsgBoxEnum.BoxType.Yes_No, self._onChangeStoneItem, nil, nil, self, nil)

			return
		end
	end

	local data = {}

	data.itemId = itemId

	ViewMgr.instance:openView(ViewName.DestinyStoneGiftPickChoiceView, data)
end

function DestinyStoneGiftPickChoiceController:_onChangeStoneItem()
	local data = {}
	local o = {}

	o.materialId = DestinyStoneGiftPickChoiceEnum.V3a8ItemId
	o.quantity = 1

	table.insert(data, o)
	ItemRpc.instance:sendUseItemRequest(data, 0)
end

function DestinyStoneGiftPickChoiceController:openHeroChoicePreview(heroId, itemId)
	local heroList = DestinyStoneGiftPickChoiceModel.instance:getAllPreviewHeroList(itemId)
	local param = {
		showType = VersionActivity2_3NewCultivationDetailView.DISPLAY_TYPE.Effect,
		heroId = heroList,
		targetHeroId = heroId,
		ignoreIds = DestinyStoneGiftPickChoiceModel.instance:getIgnoreIds()
	}

	ViewMgr.instance:openView(ViewName.VersionActivity2_3NewCultivationDetailView, param)
end

function DestinyStoneGiftPickChoiceController:openCharacterDestinyStoneDetailView(heroId, stoneId, stoneMo, type)
	local data = {}

	data.heroId = heroId
	data.stoneId = stoneId
	data.stoneMo = stoneMo
	data.type = type

	ViewMgr.instance:openView(ViewName.DestinyStoneGiftStoneDetailView, data)
end

function DestinyStoneGiftPickChoiceController:openCharacterDestinyStoneUpView(itemId, heroMo, stoneMo)
	local param = {
		materialId = itemId,
		heroMo = heroMo,
		stoneMo = stoneMo
	}

	ViewMgr.instance:openView(ViewName.CharacterDestinyStoneUpView, param)
end

DestinyStoneGiftPickChoiceController.instance = DestinyStoneGiftPickChoiceController.New()

return DestinyStoneGiftPickChoiceController
