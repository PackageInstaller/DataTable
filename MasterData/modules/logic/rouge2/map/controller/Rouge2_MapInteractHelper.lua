-- chunkname: @modules/logic/rouge2/map/controller/Rouge2_MapInteractHelper.lua

module("modules.logic.rouge2.map.controller.Rouge2_MapInteractHelper", package.seeall)

local Rouge2_MapInteractHelper = class("Rouge2_MapInteractHelper")

function Rouge2_MapInteractHelper.triggerInteractive()
	local cutInteract = Rouge2_MapModel.instance:getCurInteractive()

	if string.nilorempty(cutInteract) then
		return
	end

	local interactArr = string.splitToNumber(cutInteract, "#")
	local interactType, interactParam = interactArr[1], interactArr[2]

	Rouge2_MapInteractHelper._initInteractHandle()

	local handle = Rouge2_MapInteractHelper.handleDict[interactType]

	if not handle then
		logError("not found interact type .. " .. tostring(interactType))

		return
	end

	handle(interactParam)
end

function Rouge2_MapInteractHelper._initInteractHandle()
	Rouge2_MapInteractHelper.handleDict = Rouge2_MapInteractHelper.handleDict or {
		[Rouge2_MapEnum.InteractType.Drop] = Rouge2_MapInteractHelper.handleDrop,
		[Rouge2_MapEnum.InteractType.GainAttribute] = Rouge2_MapInteractHelper.handleGainAttribute,
		[Rouge2_MapEnum.InteractType.LossRareRelics] = Rouge2_MapInteractHelper.handleLossRareRelics,
		[Rouge2_MapEnum.InteractType.LossAttrRelics] = Rouge2_MapInteractHelper.handleLossAttrRelics,
		[Rouge2_MapEnum.InteractType.LossCoin] = Rouge2_MapInteractHelper.handleLossCoin,
		[Rouge2_MapEnum.InteractType.TransferCareer] = Rouge2_MapInteractHelper.handleTransferCareer,
		[Rouge2_MapEnum.InteractType.LossRareBuff] = Rouge2_MapInteractHelper.handleLossRareBuff,
		[Rouge2_MapEnum.InteractType.LossAttrBuff] = Rouge2_MapInteractHelper.handleLossAttrBuff,
		[Rouge2_MapEnum.InteractType.Band] = Rouge2_MapInteractHelper.handBand,
		[Rouge2_MapEnum.InteractType.ExchangeRelics] = Rouge2_MapInteractHelper.handleExchangeRelics,
		[Rouge2_MapEnum.InteractType.ResearchInstitute] = Rouge2_MapInteractHelper.handleResearchInstitute,
		[Rouge2_MapEnum.InteractType.SelectDrop] = Rouge2_MapInteractHelper.handleSelectDrop,
		[Rouge2_MapEnum.InteractType.Dice] = Rouge2_MapInteractHelper.handleDice
	}
end

function Rouge2_MapInteractHelper.handleDrop(dropId)
	logWarn("触发掉落")
end

function Rouge2_MapInteractHelper.handleGainAttribute()
	logNormal("获得属性")
	Rouge2_MapInteractHelper.addPopMapAttrUpView()
end

function Rouge2_MapInteractHelper.addPopMapAttrUpView()
	local isInQueue = Rouge2_PopController.instance:isViewInQueue(ViewName.Rouge2_MapAttributeUpView)

	if isInQueue then
		return
	end

	local hasAnyUpdate = Rouge2_MapAttrUpdateController.instance:hasAnyCareerAttrUpdate()
	local addAttrPoint = Rouge2_MapAttrUpdateController.instance:getAddAttrPoint()

	if not hasAnyUpdate and addAttrPoint <= 0 then
		return
	end

	Rouge2_PopController.instance:addPopViewWithViewName(ViewName.Rouge2_MapAttributeUpView)
end

function Rouge2_MapInteractHelper.handleLossRareRelics()
	logNormal("损失指定稀有度的造物")

	local curInteractive = Rouge2_MapModel.instance:getCurInteractiveJson()
	local filterParamMap = Rouge2_MapInteractHelper._buildFilterParamMap(curInteractive, Rouge2_Enum.ItemFilterType.EqualRare)

	filterParamMap[Rouge2_Enum.ItemFilterType.Remove] = {
		true
	}

	local itemList = Rouge2_BackpackModel.instance:getFilterItemList(Rouge2_Enum.BagType.Relics, filterParamMap)

	Rouge2_PopController.instance:addPopViewWithViewName(ViewName.Rouge2_MapRelicsAbandonView, {
		lossType = Rouge2_MapEnum.LossType.AbandonRare,
		lostNum = curInteractive.lostNum,
		itemList = itemList
	})
end

function Rouge2_MapInteractHelper.handleLossAttrRelics()
	logNormal("损失指定属性id的造物")

	local curInteractive = Rouge2_MapModel.instance:getCurInteractiveJson()
	local filterParamMap = Rouge2_MapInteractHelper._buildFilterParamMap(curInteractive, Rouge2_Enum.ItemFilterType.Attribute)
	local itemList = Rouge2_BackpackModel.instance:getFilterItemList(Rouge2_Enum.BagType.Relics, filterParamMap)

	Rouge2_PopController.instance:addPopViewWithViewName(ViewName.Rouge2_MapRelicsAbandonView, {
		lossType = Rouge2_MapEnum.LossType.AbandonAttr,
		lostNum = curInteractive.lostNum,
		itemList = itemList
	})
end

function Rouge2_MapInteractHelper.handleLossCoin()
	logNormal("损失金币")
end

function Rouge2_MapInteractHelper.handleTransferCareer()
	logNormal("转职")
	Rouge2_PopController.instance:addPopViewWithViewName(ViewName.Rouge2_MapCareerTransferView)
end

function Rouge2_MapInteractHelper.handleLossRareBuff()
	logNormal("损失指定稀有度的谐波")

	local curInteractive = Rouge2_MapModel.instance:getCurInteractiveJson()
	local filterParamMap = Rouge2_MapInteractHelper._buildFilterParamMap(curInteractive, Rouge2_Enum.ItemFilterType.EqualRare)
	local itemList = Rouge2_BackpackModel.instance:getFilterItemList(Rouge2_Enum.BagType.Buff, filterParamMap)

	Rouge2_PopController.instance:addPopViewWithViewName(ViewName.Rouge2_MapBuffAbandonView, {
		lossType = Rouge2_MapEnum.LossType.AbandonRare,
		lostNum = curInteractive.lostNum,
		itemList = itemList
	})
end

function Rouge2_MapInteractHelper.handleLossAttrBuff()
	logNormal("损失指定属性id的谐波")

	local curInteractive = Rouge2_MapModel.instance:getCurInteractiveJson()
	local filterParamMap = Rouge2_MapInteractHelper._buildFilterParamMap(curInteractive, Rouge2_Enum.ItemFilterType.Attribute)
	local itemList = Rouge2_BackpackModel.instance:getFilterItemList(Rouge2_Enum.BagType.Buff, filterParamMap)

	Rouge2_PopController.instance:addPopViewWithViewName(ViewName.Rouge2_MapBuffAbandonView, {
		lossType = Rouge2_MapEnum.LossType.AbandonAttr,
		lostNum = curInteractive.lostNum,
		itemList = itemList
	})
end

function Rouge2_MapInteractHelper._buildFilterParamMap(interactiveJson, filterType)
	local lostParam = interactiveJson and tonumber(interactiveJson.lostParam)
	local filterParamMap = {}

	if lostParam and lostParam ~= 0 then
		filterParamMap[filterType] = {
			lostParam
		}
	end

	return filterParamMap
end

function Rouge2_MapInteractHelper.handBand()
	logNormal("组乐队")

	local curInteractive = Rouge2_MapModel.instance:getCurInteractiveJson()
	local bandIdList = curInteractive.bandSet

	Rouge2_PopController.instance:addPopViewWithViewName(ViewName.Rouge2_BandRecruitView, {
		bandIdList = bandIdList
	})
end

function Rouge2_MapInteractHelper.handleExchangeRelics()
	logNormal("造物置换")

	local curInteractive = Rouge2_MapModel.instance:getCurInteractiveJson()
	local itemList = Rouge2_BackpackModel.instance:getFilterItemList(Rouge2_Enum.BagType.Relics)

	Rouge2_PopController.instance:addPopViewWithViewName(ViewName.Rouge2_MapRelicsAbandonView, {
		lossType = Rouge2_MapEnum.LossType.Exchange,
		lostNum = curInteractive.lostNum,
		itemList = itemList
	})
end

function Rouge2_MapInteractHelper.handleResearchInstitute()
	logNormal("科研所")

	local curInteractive = Rouge2_MapModel.instance:getCurInteractiveJson()

	Rouge2_PopController.instance:addPopViewWithViewName(ViewName.Rouge2_RelicsDropView, {
		viewEnum = Rouge2_MapEnum.ItemDropViewEnum.LevelUp,
		dataType = Rouge2_Enum.ItemDataType.Server,
		itemList = curInteractive.canUpdateUidSet
	})
end

function Rouge2_MapInteractHelper.handleSelectDrop()
	local curInteractive = Rouge2_MapModel.instance:getCurInteractiveJson()
	local viewName = Rouge2_BackpackHelper.dropType2ItemDropViewName(curInteractive.dropType)

	if viewName then
		Rouge2_PopController.instance:addPopViewWithViewName(viewName, {
			viewEnum = Rouge2_MapEnum.ItemDropViewEnum.Select,
			dataType = Rouge2_Enum.ItemDataType.Config,
			itemList = curInteractive.dropCollectList,
			interactive = curInteractive
		})
	end
end

function Rouge2_MapInteractHelper.handleDice()
	logNormal("属性检定")
	Rouge2_MapAttrCheckHelper.triggerCheckResult()
end

return Rouge2_MapInteractHelper
