-- chunkname: @modules/logic/sp01/odyssey/controller/OdysseyDungeonController.lua

module("modules.logic.sp01.odyssey.controller.OdysseyDungeonController", package.seeall)

local OdysseyDungeonController = class("OdysseyDungeonController", BaseController)

function OdysseyDungeonController:onInit()
	return
end

function OdysseyDungeonController:reInit()
	return
end

function OdysseyDungeonController:addConstEvents()
	return
end

function OdysseyDungeonController:openDungeonView(viewParam)
	self.dungeonViewParam = viewParam

	OdysseyRpc.instance:sendOdysseyGetInfoRequest(self._openDungeonView, self)
end

function OdysseyDungeonController:_openDungeonView()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Odyssey
	}, function()
		ViewMgr.instance:openView(ViewName.OdysseyDungeonView, self.dungeonViewParam)
	end)
end

function OdysseyDungeonController:openDungeonInteractView(elementComp)
	self:dispatchEvent(OdysseyEvent.ShowInteractCloseBtn, true)
	OdysseyDungeonModel.instance:setCurInElementId(elementComp.config.id)
	ViewMgr.instance:openView(ViewName.OdysseyDungeonInteractView, elementComp)
end

function OdysseyDungeonController:openDungeonMapSelectInfoView(mapId)
	local viewParam = {}

	viewParam.mapId = mapId

	ViewMgr.instance:openView(ViewName.OdysseyDungeonMapSelectInfoView, viewParam)
end

function OdysseyDungeonController:openMembersView(viewParam)
	OdysseyMembersModel.instance:initLocalClueUnlockState()
	ViewMgr.instance:openView(ViewName.OdysseyMembersView, viewParam)
end

function OdysseyDungeonController:openMembersTipView(viewParam)
	ViewMgr.instance:openView(ViewName.OdysseyMembersTipView, viewParam)
end

function OdysseyDungeonController:openLevelRewardView()
	OdysseyTaskModel.instance:setCurSelectTaskTypeAndGroupId(OdysseyEnum.TaskType.LevelReward)
	OdysseyTaskModel.instance:refreshList()
	ViewMgr.instance:openView(ViewName.OdysseyLevelRewardView)
end

function OdysseyDungeonController:popupRewardView()
	local needPopup, rewardParam = self:checkNeedPopupRewardView()

	if needPopup then
		local viewParam = {}

		viewParam.showAddItemList = rewardParam.showAddItemList
		viewParam.showAddOuterItemList = rewardParam.showAddOuterItemList
		viewParam.heroCurLevel = rewardParam.heroCurLevel
		viewParam.heroOldLevel = rewardParam.heroOldLevel
		viewParam.heroCurExp = rewardParam.heroCurExp
		viewParam.levelAddTalentPoint = rewardParam.levelAddTalentPoint
		viewParam.rewardAddTalentPoint = rewardParam.rewardAddTalentPoint
		viewParam.addExp = rewardParam.addExp

		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.OdysseyDungeonRewardView, viewParam)
	end
end

function OdysseyDungeonController:checkNeedPopupRewardView()
	local itemMoUidMap = OdysseyItemModel.instance:getItemMoUidMap()
	local showAddItemList = {}

	for itemUid, itemMo in pairs(itemMoUidMap) do
		if itemMo.addCount > 0 then
			table.insert(showAddItemList, itemMo)
		end
	end

	local showAddOuterItemList = OdysseyItemModel.instance:getAddOuterItemList()
	local heroCurLevel, heroCurExp = OdysseyModel.instance:getHeroCurLevelAndExp()
	local heroOldLevel, heroOldExp = OdysseyModel.instance:getHeroOldLevelAndExp()
	local levelAddTalentPoint = OdysseyTalentModel.instance:getLevelAddTalentPoint()
	local rewardAddTalentPoint = OdysseyTalentModel.instance:getRewardAddTalentPoint()
	local addExp = OdysseyModel.instance:getHeroAddExp()
	local needPopup = #showAddItemList > 0 or #showAddOuterItemList > 0 or levelAddTalentPoint > 0 or rewardAddTalentPoint > 0 or heroCurLevel ~= heroOldLevel or addExp > 0
	local rewardParam = {
		showAddItemList = showAddItemList,
		showAddOuterItemList = showAddOuterItemList,
		heroCurLevel = heroCurLevel,
		heroOldLevel = heroOldLevel,
		heroCurExp = heroCurExp,
		levelAddTalentPoint = levelAddTalentPoint,
		rewardAddTalentPoint = rewardAddTalentPoint,
		addExp = addExp
	}

	return needPopup, rewardParam
end

function OdysseyDungeonController:openMythView()
	ViewMgr.instance:openView(ViewName.OdysseyMythView)
end

function OdysseyDungeonController:jumpToMapElement(elementId)
	local elementMo = OdysseyDungeonModel.instance:getElementMo(elementId)

	if not elementMo then
		logError(elementId .. "事件数据不存在,请检查")

		return
	end

	OdysseyDungeonModel.instance:setJumpNeedOpenElement(elementId)
	OdysseyRpc.instance:sendOdysseyMapSetCurrElementRequest(elementId)
	OdysseyDungeonModel.instance:setCurInElementId(elementId)
	self:dispatchEvent(OdysseyEvent.JumpNeedOpenElement, elementId)
end

function OdysseyDungeonController:jumpToHeroPos()
	self:dispatchEvent(OdysseyEvent.JumpToHeroPos)
end

function OdysseyDungeonController:setPlayerPrefs(key, value)
	if string.nilorempty(key) or not value then
		return
	end

	local isNumber = type(value) == "number"

	if isNumber then
		GameUtil.playerPrefsSetNumberByUserId(key, value)
	else
		GameUtil.playerPrefsSetStringByUserId(key, value)
	end
end

function OdysseyDungeonController:getPlayerPrefs(key, defaultValue)
	local value = defaultValue or ""

	if string.nilorempty(key) then
		return value
	end

	local isNumber = type(value) == "number"

	value = isNumber and GameUtil.playerPrefsGetNumberByUserId(key, value) or GameUtil.playerPrefsGetStringByUserId(key, value)

	return value
end

function OdysseyDungeonController:setFightHeroGroup()
	local fightParam = FightModel.instance:getFightParam()

	if not fightParam then
		return false
	end

	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()

	if not curGroupMO then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return false
	end

	local main, mainCount = curGroupMO:getMainList()
	local sub, subCount = curGroupMO:getSubList()
	local trialCount = 0

	if curGroupMO.trialDict ~= nil then
		for _, _ in pairs(curGroupMO.trialDict) do
			trialCount = trialCount + 1
		end
	end

	if (not curGroupMO.aidDict or #curGroupMO.aidDict <= 0) and mainCount + subCount + trialCount == 0 then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return false
	end

	local clothId = curGroupMO.clothId

	fightParam:setMySide(clothId, main, curGroupMO:getSubList(), curGroupMO:getAllHeroEquips(), nil, nil, nil, nil)

	return true
end

OdysseyDungeonController.instance = OdysseyDungeonController.New()

return OdysseyDungeonController
