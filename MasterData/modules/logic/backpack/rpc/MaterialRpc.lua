-- chunkname: @modules/logic/backpack/rpc/MaterialRpc.lua

module("modules.logic.backpack.rpc.MaterialRpc", package.seeall)

local MaterialRpc = class("MaterialRpc", BaseRpc)

function MaterialRpc:onInit()
	self:reInit()
end

function MaterialRpc:reInit()
	self:set_onReceiveMaterialChangePushOnce(nil, nil)
end

function MaterialRpc.receiveMaterial(msg)
	local materialDataMOList = {}
	local faithCO = {}
	local equip_cards = {}
	local season123EquipCards = {}

	for _, v in ipairs(msg.dataList) do
		local uid
		local o = MaterialDataMO.New()

		if v.materilType == MaterialEnum.MaterialType.PowerPotion then
			local latestPowerCo = ItemPowerModel.instance:getLatestPowerChange()

			for _, power in pairs(latestPowerCo) do
				if tonumber(power.itemid) == tonumber(v.materilId) then
					uid = power.uid
				end
			end
		elseif v.materilType == MaterialEnum.MaterialType.NewInsight then
			local latestInsightCo = ItemInsightModel.instance:getLatestInsightChange()

			for _, insight in pairs(latestInsightCo) do
				if tonumber(insight.itemid) == tonumber(v.materilId) then
					uid = insight.uid
				end
			end
		end

		o:initValue(v.materilType, v.materilId, v.quantity, uid, v.roomBuildingLevel)

		if v.materilType == MaterialEnum.MaterialType.Faith then
			table.insert(faithCO, o)
		elseif v.materilType == MaterialEnum.MaterialType.EquipCard then
			for i = 1, v.quantity do
				table.insert(equip_cards, v.materilId)
			end
		elseif v.materilType == MaterialEnum.MaterialType.Season123EquipCard then
			for i = 1, v.quantity do
				table.insert(season123EquipCards, v.materilId)
			end
		elseif v.materilType == MaterialEnum.MaterialType.Act186Like then
			-- block empty
		else
			table.insert(materialDataMOList, o)
		end
	end

	return materialDataMOList, faithCO, equip_cards, season123EquipCards
end

function MaterialRpc:set_onReceiveMaterialChangePushOnce(cb, cbObj)
	self._materialChangePushOnceCb = cb
	self._materialChangePushOnceCbObj = cbObj
end

function MaterialRpc:onReceiveMaterialChangePush(resultCode, msg)
	local onceCb = self._materialChangePushOnceCb

	if onceCb then
		local onceCbObj = self._materialChangePushOnceCbObj

		self:set_onReceiveMaterialChangePushOnce(nil, nil)
		self._materialChangePushOnceCb(onceCbObj, resultCode, msg)

		return
	end

	if resultCode ~= 0 then
		return
	end

	local materialDataMOList, faithCO, equip_cards, season123EquipCards = MaterialRpc.receiveMaterial(msg)

	self:_onReceiveMaterialChangePush(msg, materialDataMOList, faithCO, equip_cards, season123EquipCards)
end

function MaterialRpc:_onReceiveMaterialChangePush(msg, materialDataMOList, faithCO, equip_cards, season123EquipCards)
	local getApproach = msg.getApproach

	if getApproach == MaterialEnum.GetApproach.Charge then
		PayController.instance:onReceiveMaterialChangePush(materialDataMOList)
	end

	local isIgnore = PopupCacheModel.instance:isIgnoreGetPropView(getApproach)

	if isIgnore then
		return
	end

	local isCache = PopupCacheController.instance:tryCacheGetPropView(getApproach, {
		materialDataMOList = materialDataMOList
	})

	if isCache then
		return
	end

	if getApproach == MaterialEnum.GetApproach.RoomProductLine then
		RoomController.instance:MaterialChangeByRoomProductLine(materialDataMOList)
	elseif getApproach == MaterialEnum.GetApproach.Explore then
		-- block empty
	elseif getApproach == MaterialEnum.GetApproach.BattlePass then
		BpController.instance:_showCommonPropView(materialDataMOList)
	elseif getApproach == MaterialEnum.GetApproach.DungeonRewardPoint then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnGetPointRewardMaterials, materialDataMOList)
	elseif getApproach == MaterialEnum.GetApproach.AstrologyStarReward then
		VersionActivity1_3AstrologyModel.instance:setStarReward(materialDataMOList)

		return
	elseif ItemApproachHelper.isTaskApproach(getApproach) then
		if ViewMgr.instance:isOpen(ViewName.WeekWalkRewardView) or ViewMgr.instance:isOpen(ViewName.WeekWalkLayerRewardView) then
			WeekWalkTaskListModel.instance:setTaskRewardList(materialDataMOList)

			return
		end

		if ViewMgr.instance:isOpen(ViewName.WeekWalk_2LayerRewardView) then
			WeekWalk_2TaskListModel.instance:setTaskRewardList(materialDataMOList)

			return
		end

		if ViewMgr.instance:isOpen(ViewName.AbyssTaskView) then
			AbyssTaskListModel.instance:setTaskRewardList(materialDataMOList)

			return
		end

		if self:isShowBadgeGetView(materialDataMOList) then
			return
		end

		if self:isTurnBackRewardMaterails(materialDataMOList) then
			return
		end

		TaskController.instance:getRewardByLine(getApproach, ViewName.CommonPropView, materialDataMOList)

		if #equip_cards > 0 then
			Activity104Model.instance:addCardGetData(equip_cards)
			Activity104Controller.instance:checkShowEquipSelfChoiceView()
		end

		if #season123EquipCards > 0 then
			Season123Model.instance:addCardGetData(season123EquipCards)
		end
	elseif getApproach == MaterialEnum.GetApproach.RoomInteraction then
		RoomController.instance:showInteractionRewardToast(materialDataMOList)

		if #faithCO > 0 then
			RoomCharacterController.instance:showGainFaithToast(faithCO)
		end
	elseif getApproach == MaterialEnum.GetApproach.NoviceStageReward then
		TaskModel.instance:setHasTaskNoviceStageReward(true)
	elseif getApproach == MaterialEnum.GetApproach.SignIn then
		-- block empty
	elseif getApproach == MaterialEnum.GetApproach.Birthday then
		SignInController.instance:setSigninReward(materialDataMOList)
	elseif getApproach == MaterialEnum.GetApproach.MonthCard or getApproach == MaterialEnum.GetApproach.SmallMonthCard or getApproach == MaterialEnum.GetApproach.SeasonCard then
		SignInController.instance:openSigninPropView(materialDataMOList)
	elseif getApproach == MaterialEnum.GetApproach.Act1_6SkillLvDown or getApproach == MaterialEnum.GetApproach.Act1_6SkillReset then
		VersionActivity1_6DungeonController.instance:dispatchEvent(VersionActivity1_6DungeonEvent.SkillPointReturnBack)

		return
	elseif getApproach == MaterialEnum.GetApproach.v1a8Act157ComponentReward then
		return
	elseif getApproach == MaterialEnum.GetApproach.v2a2Act169SummonNewPick and not SummonNewCustomPickChoiceListModel.instance:haveAllRole() then
		SummonNewCustomPickChoiceController.instance:setSummonReward(materialDataMOList)

		return
	elseif getApproach == MaterialEnum.GetApproach.LifeCircleSign then
		LifeCircleController.instance:openLifeCircleRewardView(materialDataMOList)
	elseif getApproach == MaterialEnum.GetApproach.AutoChessRankReward or getApproach == MaterialEnum.GetApproach.AutoChessPveReward then
		AutoChessController.instance:addPopupView(ViewName.CommonPropView, materialDataMOList)
	elseif getApproach == MaterialEnum.GetApproach.Activity197View then
		Activity197Controller.instance:setRummageReward(ViewName.CommonPropView, materialDataMOList)
	elseif getApproach == MaterialEnum.GetApproach.SkinCoupon then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.SkinCouponTipView, ViewName.SkinCouponTipView, materialDataMOList)
	elseif getApproach == MaterialEnum.GetApproach.PartyClothSummon then
		PartyClothController.instance:openSummonRewardView(materialDataMOList)
	elseif getApproach == MaterialEnum.GetApproach.CommandStationPaperReward then
		-- block empty
	elseif getApproach == MaterialEnum.GetApproach.ActBp then
		Anniversary3ActBpModel.instance:setWaitShowRewards(materialDataMOList)
	else
		self:_onReceiveMaterialChangePush_default(msg, materialDataMOList, faithCO, equip_cards, season123EquipCards)
	end

	local params = {
		msg = msg,
		materialDataMOList = materialDataMOList
	}

	PopupController.instance:dispatchEvent(PopupEvent.OnMaterialChangePush, params)
end

function MaterialRpc:_onReceiveMaterialChangePush_default(msg, materialDataMOList, faithCO, equip_cards, season123EquipCards)
	local getApproach = msg.getApproach

	if #faithCO > 0 and getApproach == MaterialEnum.GetApproach.RoomGainFaith then
		RoomCharacterController.instance:showGainFaithToast(faithCO)
	end

	if #equip_cards > 0 then
		Activity104Model.instance:addCardGetData(equip_cards)
	end

	if #season123EquipCards > 0 then
		Season123Model.instance:addCardGetData(season123EquipCards)
	end

	local materialCount = #materialDataMOList

	if #materialDataMOList == 1 and materialDataMOList[1].materilType == MaterialEnum.MaterialType.HeroSkin then
		return
	end

	if #materialDataMOList == 1 and materialDataMOList[1].materilType == MaterialEnum.MaterialType.Item then
		local sceneSkinConfig = MainSceneSwitchConfig.instance:getConfigByItemId(materialDataMOList[1].materilId)

		if sceneSkinConfig then
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.MainSceneSwitchInfoView, {
				sceneSkinId = sceneSkinConfig.id,
				materialDataMOList = materialDataMOList
			})

			return
		end
	end

	for _, mo in ipairs(materialDataMOList) do
		local sceneSkinConfig = MainSceneSwitchConfig.instance:getConfigByItemId(mo.materilId)

		if sceneSkinConfig then
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.MainSceneSwitchInfoView, {
				sceneSkinId = sceneSkinConfig.id,
				materialDataMOList = materialDataMOList
			})
		end

		local co = MainUISwitchConfig.instance:getUISwitchCoByItemId(mo.materilId)

		if co then
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.MainUISwitchInfoBlurMaskView, {
				SkinId = co.id
			})
		end

		local summonConfig = SummonUISwitchConfig.instance:getSummonSwitchConfigByItemId(mo.materilId)

		if summonConfig then
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SummonUISwitchInfoView, {
				sceneSkinId = summonConfig.id
			})
		end
	end

	for _, mo in ipairs(materialDataMOList) do
		local styleMo = FightUISwitchModel.instance:getStyleMoByItemId(mo.materilId)

		if styleMo then
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.FightUISwitchEquipView, {
				mo = styleMo
			})
		end
	end

	if self:isShowBadgeGetView(materialDataMOList) then
		return
	end

	local itemCnt = #materialDataMOList

	if itemCnt ~= 0 and materialDataMOList[1].materilType == MaterialEnum.MaterialType.Critter then
		CritterController.instance:popUpCritterGetView()

		if itemCnt == 1 then
			return
		end
	end

	for _, mo in ipairs(materialDataMOList) do
		local config = ItemConfig.instance:getItemConfig(mo.materilType, mo.materilId)

		if config and config.subType == ItemEnum.SubType.PlayerBg then
			if materialCount == 1 then
				PlayerCardController.instance:ShowChangeBgSkin(config.id, materialDataMOList)

				return
			else
				PlayerCardController.instance:showPropChangeBgSkin(config.id)
			end
		end
	end

	self:simpleShowView(materialDataMOList)
end

function MaterialRpc:isShowBadgeGetView(materialDataMOList)
	if not materialDataMOList then
		return
	end

	local showBadgeId

	for _, mo in ipairs(materialDataMOList) do
		local itemco = ItemConfig.instance:getItemCo(mo.materilId)

		if itemco and itemco.subType == ItemEnum.SubType.Badge and PlayerCardModel.instance:isShowBadgeGetView() and not string.nilorempty(itemco.effect) then
			local badgeId = tonumber(itemco.effect)

			if showBadgeId then
				local showCo = PlayerCardConfig.instance:getBageCoById(showBadgeId)
				local co = PlayerCardConfig.instance:getBageCoById(badgeId)

				if co then
					if showCo.level < co.level then
						showBadgeId = badgeId
					elseif showCo.level == co.level and showCo.id < co.id then
						showBadgeId = badgeId
					end
				end
			else
				showBadgeId = badgeId
			end
		end
	end

	if showBadgeId then
		PlayerCardController.instance:openBadgeGetView(showBadgeId, nil, materialDataMOList)

		return true
	end
end

function MaterialRpc:isTurnBackRewardMaterails(materialDataMOList)
	if not materialDataMOList or #materialDataMOList ~= 1 then
		return
	end

	local turnbackInfoMo = TurnbackModel.instance:getCurTurnbackMo()

	if not turnbackInfoMo then
		return
	end

	local resourceReturn = turnbackInfoMo:getReturnRewardInfo()

	if not resourceReturn or not resourceReturn.open then
		return
	end

	local currencyInfo = turnbackInfoMo:getCurRewardCurrencyInfo()

	if not currencyInfo then
		return
	end

	local material = materialDataMOList[1]

	return material.materilType == currencyInfo[1] and material.materilId == currencyInfo[2]
end

function MaterialRpc:simpleShowView(materialDataMOList)
	if not #materialDataMOList or #materialDataMOList == 0 then
		return
	end

	RoomController.instance:popUpRoomBlockPackageView(materialDataMOList)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, materialDataMOList)
end

function MaterialRpc:showItemConvertView(materialDataMO)
	if not materialDataMO then
		return
	end

	local param = {}

	param.convertMaterial = materialDataMO

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropConvertView, ViewName.CommonPropConvertView, param)
end

MaterialRpc.instance = MaterialRpc.New()

return MaterialRpc
