-- chunkname: @modules/logic/summon/controller/SummonLuckyBagChoiceController.lua

module("modules.logic.summon.controller.SummonLuckyBagChoiceController", package.seeall)

local SummonLuckyBagChoiceController = class("SummonLuckyBagChoiceController", BaseController)

function SummonLuckyBagChoiceController:onOpenView(luckyBagId, poolId)
	SummonLuckyBagChoiceListModel.instance:initDatas(luckyBagId, poolId)
end

function SummonLuckyBagChoiceController:onCloseView()
	return
end

function SummonLuckyBagChoiceController:trySendChoice()
	local poolId = SummonLuckyBagChoiceListModel.instance:getPoolId()
	local poolMO = SummonMainModel.instance:getPoolServerMO(poolId)

	if not poolMO or not poolMO:isOpening() then
		return false
	end

	local selectHeroId = SummonLuckyBagChoiceListModel.instance:getSelectId()

	if not selectHeroId then
		GameFacade.showToast(ToastEnum.SummonLuckyBagNotSelect)

		return false
	end

	if self:isLuckyBagOpened() then
		GameFacade.showToast(ToastEnum.SummonLuckyBagAlreadyReceive)

		return false
	end

	local msgId, heroName, duplicateItemName, duplicateItemCount = self:getDuplicatePopUpParam(selectHeroId)

	GameFacade.showMessageBox(msgId, MsgBoxEnum.BoxType.Yes_No, self.realSendChoice, nil, nil, self, nil, nil, heroName, duplicateItemName, duplicateItemCount)
end

function SummonLuckyBagChoiceController:realSendChoice()
	local heroId = SummonLuckyBagChoiceListModel.instance:getSelectId()
	local luckyBagId = SummonLuckyBagChoiceListModel.instance:getLuckyBagId()

	if heroId and heroId ~= 0 then
		SummonRpc.instance:sendOpenLuckyBagRequest(luckyBagId, heroId)
	end
end

function SummonLuckyBagChoiceController:getDuplicatePopUpParam(heroId)
	local heroMo = HeroModel.instance:getByHeroId(heroId)
	local heroConfig = HeroConfig.instance:getHeroCO(heroId)
	local msgId = MessageBoxIdDefine.SummonLuckyBagSelectChar

	if heroConfig then
		if not heroConfig.name then
			local heroName = ""
			local duplicateItemName = ""
			local duplicateItemCount = ""

			if heroMo and heroConfig then
				local itemParams = {}
				local isMaxExSkill = HeroModel.instance:isMaxExSkill(heroId, true)

				if not isMaxExSkill then
					local duplicateItem1List = GameUtil.splitString2(heroConfig.duplicateItem, true)

					itemParams = duplicateItem1List and duplicateItem1List[1] or itemParams
					msgId = MessageBoxIdDefine.SummonLuckyBagSelectCharRepeat
				else
					itemParams = string.splitToNumber(heroConfig.duplicateItem2, "#") or itemParams
					duplicateItemCount = itemParams[3] or ""
					msgId = MessageBoxIdDefine.SummonLuckyBagSelectCharRepeat2
				end

				local itemType = itemParams[1]
				local itemId = itemParams[2]

				if itemType and itemId then
					local itemConfig, _ = ItemModel.instance:getItemConfigAndIcon(itemParams[1], itemParams[2])

					duplicateItemName = itemConfig and itemConfig.name or ""
				end
			end

			return msgId, heroName, duplicateItemName, duplicateItemCount
		end
	end
end

function SummonLuckyBagChoiceController:isLuckyBagOpened()
	local poolId = SummonLuckyBagChoiceListModel.instance:getPoolId()
	local luckyBagId = SummonLuckyBagChoiceListModel.instance:getLuckyBagId()

	if SummonLuckyBagModel.instance:isLuckyBagOpened(poolId, luckyBagId) then
		return true
	end

	return false
end

function SummonLuckyBagChoiceController:setSelect(heroId)
	SummonLuckyBagChoiceListModel.instance:setSelectId(heroId)
	SummonLuckyBagChoiceListModel.instance:onModelUpdate()
	self:dispatchEvent(SummonEvent.onLuckyListChanged)
end

SummonLuckyBagChoiceController.instance = SummonLuckyBagChoiceController.New()

LuaEventSystem.addEventMechanism(SummonLuckyBagChoiceController.instance)

return SummonLuckyBagChoiceController
