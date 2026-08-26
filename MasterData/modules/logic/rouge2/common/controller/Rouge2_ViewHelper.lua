-- chunkname: @modules/logic/rouge2/common/controller/Rouge2_ViewHelper.lua

module("modules.logic.rouge2.common.controller.Rouge2_ViewHelper", package.seeall)

local Rouge2_ViewHelper = class("Rouge2_ViewHelper")

function Rouge2_ViewHelper.openDifficultySelectView(params)
	ViewMgr.instance:openView(ViewName.Rouge2_DifficultySelectView, params)
end

function Rouge2_ViewHelper.openCareerSelectView(params)
	ViewMgr.instance:openView(ViewName.Rouge2_CareerSelectView, params)
end

function Rouge2_ViewHelper.openCareerSkillTipsView(dataType, dataId, tipPos, usage, extraParams)
	local params = {
		dataType = dataType,
		dataId = dataId,
		tipPos = tipPos,
		usage = usage,
		extraParams = extraParams
	}

	ViewMgr.instance:openView(ViewName.Rouge2_CareerSkillTipsView, params)
end

function Rouge2_ViewHelper.openCareerAttributeTipsView(careerId, attributeId, attributeValue, pos, offset, clickCallback, clickCallbackObj)
	local params = {
		careerId = careerId,
		attributeId = attributeId,
		attributeValue = attributeValue,
		pos = pos,
		offset = offset,
		clickCallback = clickCallback,
		clickCallbackObj = clickCallbackObj
	}

	ViewMgr.instance:openView(ViewName.Rouge2_CareerAttributeTipsView, params)
end

function Rouge2_ViewHelper.openMainView(params)
	ViewMgr.instance:openView(ViewName.Rouge2_MainView, params)
end

function Rouge2_ViewHelper.openEnterView(params)
	ViewMgr.instance:openView(ViewName.Rouge2_EnterView, params)
end

function Rouge2_ViewHelper.openStoreView(params)
	ViewMgr.instance:openView(ViewName.Rouge2_StoreView, params)
end

function Rouge2_ViewHelper.openBackpackTabView(tabId, extraParams)
	local params = {
		defaultTabIds = {
			[Rouge2_Enum.BackpackTabContainerId] = tabId
		},
		extraParams = extraParams
	}

	ViewMgr.instance:openView(ViewName.Rouge2_BackpackTabView, params)
end

function Rouge2_ViewHelper.openAttributeDetailView(careerId, attrInfoList, otherParams)
	careerId = careerId or Rouge2_Model.instance:getCareerId()
	attrInfoList = attrInfoList or Rouge2_Model.instance:getHeroAttrInfoList()

	local params = {
		careerId = careerId,
		attrInfoList = attrInfoList
	}

	if otherParams then
		for key, value in pairs(otherParams) do
			params[key] = value
		end
	end

	ViewMgr.instance:openView(ViewName.Rouge2_AttributeDetailView, params)
end

function Rouge2_ViewHelper.openTalentTreeView(params)
	ViewMgr.instance:openView(ViewName.Rouge2_TalentTreeView, params)
end

function Rouge2_ViewHelper.openTalentTreeOverView(params)
	ViewMgr.instance:openView(ViewName.Rouge2_TalentTreeOverView, params)
end

function Rouge2_ViewHelper.openIllustrationMainView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.Rouge2_IllustrationMainView, param, isImmediate)
end

function Rouge2_ViewHelper.openRougeIllustrationDetailView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.Rouge2_IllustrationDetailView, param, isImmediate)
end

function Rouge2_ViewHelper.openRougeCareerHandBookView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.Rouge2_CareerHandBookMainView, param, isImmediate)
end

function Rouge2_ViewHelper.openRougeCareerHandBookDetailView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.Rouge2_CareerHandBookDetailView, param, isImmediate)
end

function Rouge2_ViewHelper.openRouge2UnlockInfoView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.Rouge2_ResultUnlockInfoView, param, isImmediate)
end

function Rouge2_ViewHelper.openItemTipsView(dataType, dataIdList, extraParamMap)
	local dataId = dataIdList and dataIdList[1]
	local itemId = Rouge2_BackpackHelper.getItemIdAndUid(dataType, dataId)
	local bagType = Rouge2_BackpackHelper.itemId2BagType(itemId)
	local showViewName = Rouge2_BackpackHelper.itemType2ShowViewName(bagType)
	local params = {
		viewEnum = Rouge2_MapEnum.ItemDropViewEnum.Tips,
		dataType = dataType,
		itemList = dataIdList
	}

	if extraParamMap then
		for key, paramValue in pairs(extraParamMap) do
			params[key] = paramValue
		end
	end

	ViewMgr.instance:openView(showViewName, params)
end

function Rouge2_ViewHelper.openBossBattleView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.Rouge2_BossBattleView, param, isImmediate)
end

function Rouge2_ViewHelper.openBossBattleDetailView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.Rouge2_BossBattleDetailView, param, isImmediate)
end

function Rouge2_ViewHelper.openSaveInfoView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.Rouge2_SaveInfoView, param, isImmediate)
end

function Rouge2_ViewHelper.openSaveInfoDetailView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.Rouge2_SaveInfoDetailView, param, isImmediate)
end

function Rouge2_ViewHelper.openActiveSkillAttrUpdateTipsView(dataType, dataId)
	local params = {
		dataType = dataType,
		dataId = dataId
	}

	ViewMgr.instance:openView(ViewName.Rouge2_ActiveSkillAttrUpdateTipsView, params)
end

return Rouge2_ViewHelper
