-- chunkname: @modules/logic/tips/controller/MaterialTipController.lua

module("modules.logic.tips.controller.MaterialTipController", package.seeall)

local MaterialTipController = class("MaterialTipController", BaseController)

function MaterialTipController:onInit()
	return
end

function MaterialTipController:addConstEvents()
	return
end

function MaterialTipController:showMaterialInfo(type, id, inpack, uid, cantJump, recordFarmItem, fakeQuantity, needQuantity, isConsume, jumpFinishCallback, jumpFinishCallbackObj, jumpFinishCallbackParam, extraParam)
	type = tonumber(type)
	id = tonumber(id)

	local data = {}

	data.type = type
	data.id = id
	data.inpack = inpack
	data.uid = uid
	data.canJump = not cantJump
	data.recordFarmItem = recordFarmItem
	data.fakeQuantity = fakeQuantity
	data.needQuantity = needQuantity
	data.isConsume = isConsume
	data.jumpFinishCallback = jumpFinishCallback
	data.jumpFinishCallbackObj = jumpFinishCallbackObj
	data.jumpFinishCallbackParam = jumpFinishCallbackParam
	data.roomBuildingLevel = extraParam and extraParam.roomBuildingLevel

	self:showMaterialInfoWithData(type, id, data)
end

function MaterialTipController:showMaterialInfoWithData(type, id, data)
	data.type = type
	data.id = id

	local inpack = data.inpack

	if type == MaterialEnum.MaterialType.Item then
		local config = ItemModel.instance:getItemConfig(type, id)

		if config.subType == ItemEnum.SubType.MainSceneSkin then
			ViewMgr.instance:openView(ViewName.MainSceneSkinMaterialTipView, data)

			return
		end

		if config.subType == ItemEnum.SubType.MainUISkin then
			ViewMgr.instance:openView(ViewName.MainUISkinMaterialTipView, data)

			return
		end

		if config.subType == ItemEnum.SubType.FightCard or config.subType == ItemEnum.SubType.FightFloatType then
			ViewMgr.instance:openView(ViewName.FightUISkinMaterialTipView, data)

			return
		end

		if config.subType == ItemEnum.SubType.SummonUISkin then
			ViewMgr.instance:openView(ViewName.SummonUISkinMaterialTipView, data)

			return
		end

		if inpack ~= true and MaterialEnum.SubTypePackages[config.subType] then
			ViewMgr.instance:openView(ViewName.MaterialPackageTipView, data)
		elseif ItemEnum.RoomBackpackPropSubType[config.subType] then
			ViewMgr.instance:openView(ViewName.RoomManufactureMaterialTipView, data)
		elseif config.subType == ItemEnum.SubType.PlayerBg then
			ViewMgr.instance:openView(ViewName.DecorateStoreGoodsTipView, data)
		else
			data.isReturnLastTipView = true

			ViewMgr.instance:openView(ViewName.MaterialTipView, data)
		end
	elseif type == MaterialEnum.MaterialType.Currency then
		data.inpack = false

		if id ~= CurrencyEnum.CurrencyType.Act186 then
			ViewMgr.instance:openView(ViewName.MaterialTipView, data)
		end
	elseif type == MaterialEnum.MaterialType.Hero then
		data.hero = true

		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			heroId = id
		})
	elseif type == MaterialEnum.MaterialType.HeroSkin then
		CharacterController.instance:openCharacterSkinTipView({
			skinId = id
		})
	elseif type == MaterialEnum.MaterialType.Equip then
		EquipController.instance:openEquipView({
			equipId = id
		})
	elseif type == MaterialEnum.MaterialType.PlayerCloth then
		data.isTip = true

		ViewMgr.instance:openView(ViewName.PlayerClothView, data)
	elseif type == MaterialEnum.MaterialType.Building or type == MaterialEnum.MaterialType.BlockPackage then
		ViewMgr.instance:openView(ViewName.RoomMaterialTipView, data)
	elseif type == MaterialEnum.MaterialType.EquipCard then
		Activity104Controller.instance:openSeasonCelebrityCardTipView(data)
	elseif type == MaterialEnum.MaterialType.Season123EquipCard then
		Season123Controller.instance:openSeasonCelebrityCardTipView(data)
	elseif type == MaterialEnum.MaterialType.Antique then
		AntiqueController.instance:openAntiqueView(id)
	elseif type == MaterialEnum.MaterialType.Critter then
		local config = ItemModel.instance:getItemConfig(type, id)
		local critterMo = CritterHelper.buildFakeCritterMoByConfig(config)

		CritterController.instance:openRoomCritterDetailView(true, critterMo, true)
	else
		data.special = true

		ViewMgr.instance:openView(ViewName.MaterialTipView, data)
	end
end

function MaterialTipController:onUseOptionalHeroGift(viewParam, selectHeroIdList)
	if not selectHeroIdList or #selectHeroIdList < 0 then
		return
	end

	local data = {}
	local o = {}

	o.materialId = viewParam.id
	o.quantity = viewParam.quantity

	table.insert(data, o)
	ItemRpc.instance:sendUseItemRequest(data, selectHeroIdList[1])
	CustomPickChoiceController.instance:dispatchEvent(CustomPickChoiceEvent.onCustomPickComplete)
end

function MaterialTipController:onUseSelfSelectSixHeroGift(viewParam, selectHeroIdList)
	if not selectHeroIdList or #selectHeroIdList < 0 then
		return
	end

	local data = {}
	local o = {}

	o.materialId = viewParam.id
	o.quantity = viewParam.quantity

	table.insert(data, o)
	ItemRpc.instance:sendUseItemRequest(data, selectHeroIdList[1])
	V2a7_SelfSelectSix_PickChoiceController.instance:dispatchEvent(V2a7_SelfSelectSix_PickChoiceEvent.onCustomPickComplete)
end

function MaterialTipController:onUseOptionalTurnbackEquipGift(viewParam, selectEquipIdList)
	if not selectEquipIdList or #selectEquipIdList < 0 then
		return
	end

	local data = {}
	local o = {}

	o.materialId = viewParam.id
	o.quantity = viewParam.quantity

	local index = selectEquipIdList[1]

	table.insert(data, o)
	ItemRpc.instance:sendUseItemRequest(data, index)
	TurnbackPickEquipController.instance:dispatchEvent(TurnbackEvent.onCustomPickComplete)
end

function MaterialTipController:openView_LifeCirclePickChoice(itemType, itemId, quantity)
	local itemCO = ItemConfig.instance:getItemConfig(itemType, itemId)

	self:_openView_LifeCirclePickChoice(itemCO, quantity)
end

function MaterialTipController:_openView_LifeCirclePickChoice(itemCO, quantity)
	quantity = quantity or 1

	if quantity <= 0 then
		return
	end

	local effect = itemCO.effect

	if string.nilorempty(effect) then
		return
	end

	local strList = string.split(effect, "|")
	local heroIdList = {}
	local isCustomSelect
	local maxHeroCnt = #strList

	for i, heroIdStr in ipairs(strList) do
		local characterId = tonumber(heroIdStr)

		table.insert(heroIdList, characterId)

		if isCustomSelect == nil then
			local heroMO = HeroModel.instance:getByHeroId(characterId)

			if not heroMO then
				isCustomSelect = false
			elseif i == maxHeroCnt then
				isCustomSelect = true
			end
		end
	end

	local title = isCustomSelect and luaLang("lifecirclepickchoice_txt_Title_custom") or luaLang("lifecirclepickchoice_txt_Title_random")
	local confirmDesc = isCustomSelect and luaLang("lifecirclepickchoice_txt_confirm_custom") or luaLang("lifecirclepickchoice_txt_confirm_random")
	local viewParam = {
		heroIdList = heroIdList,
		title = title,
		confirmDesc = confirmDesc,
		isCustomSelect = isCustomSelect,
		callback = function(viewObj)
			local targetId = isCustomSelect and viewObj:selectedHeroId() or 0

			if isCustomSelect and targetId == 0 then
				GameFacade.showToast(ToastEnum.MaterialTipController_LifeCirclePickChoiceSelectOneTips)

				return
			end

			local materialId = itemCO.id

			MaterialRpc.instance:set_onReceiveMaterialChangePushOnce(self._onReceiveMaterialChangePush_LifeCirclePickChoice, self)
			HeroRpc.instance:set_onReceiveHeroGainPushOnce(self._onReceiveHeroGainPush_LifeCirclePickChoice, self)
			CharacterModel.instance:setGainHeroViewShowState(true)
			ItemRpc.instance:simpleSendUseItemRequest(materialId, quantity, targetId, viewObj.closeThis, viewObj)
		end
	}

	ViewMgr.instance:openView(ViewName.LifeCirclePickChoice, viewParam)
end

function MaterialTipController:_onReceiveMaterialChangePush_LifeCirclePickChoice(resultCode, msg)
	CharacterModel.instance:setGainHeroViewShowState(false)

	if resultCode ~= 0 then
		return
	end

	LifeCircleController.instance:onReceiveMaterialChangePush(msg)
end

function MaterialTipController:_onReceiveHeroGainPush_LifeCirclePickChoice(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	LifeCircleController.instance:onReceiveHeroGainPush(msg)
end

function MaterialTipController:onUseInfallibleSummonItem(viewParam)
	local data = {}
	local o = {}

	o.materialId = viewParam.id
	o.quantity = viewParam.quantity

	table.insert(data, o)
	ItemRpc.instance:sendUseItemRequest(data, 0)
end

function MaterialTipController:openExchangeTipView(costMatData, targetMatData, exchangeFunc, exchangeFuncObj, getMaxTimeFunc, getMaxTimeFuncObj, getExchangeNumFunc, getExchangeNumFuncObj)
	ViewMgr.instance:openView(ViewName.CommonExchangeView, {
		costMatData = costMatData,
		targetMatData = targetMatData,
		exchangeFunc = exchangeFunc,
		exchangeFuncObj = exchangeFuncObj,
		getMaxTimeFunc = getMaxTimeFunc,
		getMaxTimeFuncObj = getMaxTimeFuncObj,
		getExchangeNumFunc = getExchangeNumFunc,
		getExchangeNumFuncObj = getExchangeNumFuncObj
	})
end

function MaterialTipController:openPackageRewardDetailView(rewardList)
	local data = {}

	data.rewardList = rewardList

	ViewMgr.instance:openView(ViewName.PackageRewardDetailView, data)
end

function MaterialTipController:isSpecifiedGift(config)
	return config.subType == ItemEnum.SubType.SpecifiedGift and config.clientDisplayType == ItemEnum.clientDisplayType.SpecifiedGift
end

function MaterialTipController:isBpCustomSelect(config)
	return config.subType == ItemEnum.SubType.SpecifiedGift and config.clientDisplayType == ItemEnum.clientDisplayType.BpCustomSelect
end

function MaterialTipController:isHeroSelect(config)
	return config.subType == ItemEnum.SubType.SpecifiedGift and config.clientDisplayType == ItemEnum.clientDisplayType.HeroSelect
end

MaterialTipController.instance = MaterialTipController.New()

return MaterialTipController
