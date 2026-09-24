-- chunkname: @modules/logic/college/controller/CollegeController.lua

module("modules.logic.college.controller.CollegeController", package.seeall)

local CollegeController = class("CollegeController", BaseController)

function CollegeController:addConstEvents()
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, self._newFuncUnlock, self)
end

function CollegeController:_newFuncUnlock(newIds)
	for i, id in ipairs(newIds) do
		if id == OpenEnum.UnlockFunc.College then
			CollegeRpc.instance:sendCollegeSceneInfo()

			return
		end
	end
end

function CollegeController:enterCollegeCity(isImmediate)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.College) then
		logError("功能都没开！！！")

		return
	end

	self.isImmediate = isImmediate

	local hasTiped = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.CollegeEnterCityTips, 0) == 1

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.CollegeShow) or hasTiped then
		self:_realEnterCity()

		return
	end

	local episodeId = OpenConfig.instance:getOpenCo(OpenEnum.UnlockFunc.CollegeShow).episodeId
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
	local dungeonName = DungeonController.getEpisodeName(episodeCo)

	GameFacade.showMessageBox(MessageBoxIdDefine.CollegeEnterCityTips, MsgBoxEnum.BoxType.Yes_No, function()
		GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.CollegeEnterCityTips, 1)
		self:_realEnterCity()
	end, nil, nil, nil, nil, nil, dungeonName)
end

function CollegeController:_realEnterCity()
	CollegeRpc.instance:sendCollegeSceneInfo(self._onGetInfo, self)
end

function CollegeController:_onGetInfo(cmd, resultCode, msg)
	if resultCode == 0 then
		if self.isImmediate then
			ViewMgr.instance:openView(ViewName.CollegeMainView)
		else
			ViewMgr.instance:openView(ViewName.CollegeEnterAnimView)
		end
	end
end

function CollegeController:showToast(msg)
	if not ViewMgr.instance:isOpen(ViewName.CollegeToastView) then
		table.insert(CollegeModel.instance.toastList, msg)
		ViewMgr.instance:openView(ViewName.CollegeToastView)
	elseif ViewMgr.instance:isOpening(ViewName.CollegeToastView) then
		table.insert(CollegeModel.instance.toastList, msg)
	else
		self:dispatchEvent(CollegeEvent.ShowToast, msg)
	end
end

function CollegeController.getCollegeRelationChain(pageIndex)
	local lastChainId = CollegeModel.instance:getSceneMo().milestoneBox.lastChainId[pageIndex]

	return lua_college_character_chain.configDict[lastChainId]
end

function CollegeController.getRelationShipBoardReddot()
	for _, pageIndex in pairs(CollegeEnum.RelationShipBoardPage) do
		local config = CollegeController.getCollegeRelationChain(pageIndex)
		local stateList = config and config.stateId

		if stateList then
			for _, v in ipairs(stateList) do
				if not CollegeModel.instance:getCharacterState(v) then
					local stateCo = lua_college_character_state.configDict[v]

					if stateCo and stateCo.isClick ~= CollegeEnum.CharacterClickState.NoClick then
						return true
					end
				end
			end
		end
	end

	for i = 1, CollegeEnum.MaxCampLocationIndex do
		local camp = CollegeConfig.instance:getCampByLocation(i)
		local showNew = not CollegeController.hasOnceActionKey(CollegeEnum.PrefsKey.CampNewFlag, camp)
		local config = lua_college_character_camp.configDict[camp]

		if config then
			::label_9_0::

			local visible = DungeonModel.instance:hasPassLevelAndStory(config.unlockId)

			if showNew and visible then
				return true
			end
		end
	end

	return false
end

function CollegeController.noCharacterCamp(camp)
	return false
end

function CollegeController:openCollegeRelationShipBoard(param, isImmediate)
	local index = CollegeEnum.RelationShipBoardPage.Default

	if CollegeController.showNewChapterPage() then
		index = CollegeEnum.RelationShipBoardPage.Chapter13
	end

	param = param or {}
	param.defaultTabIds = {
		[2] = index
	}

	ViewMgr.instance:openView(ViewName.CollegeRelationShipBoard, param, isImmediate)
end

function CollegeController:openCollegeRelationShipDetail(param, isImmediate)
	ViewMgr.instance:openView(ViewName.CollegeRelationShipDetail, param, isImmediate)
end

function CollegeController:openCollegeTeamDetailView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.CollegeTeamDetailView, param, isImmediate)
end

function CollegeController.hasOnceActionKey(type, id)
	local key = CollegeController._getOnceAnimKey(type, id)

	return PlayerPrefsHelper.hasKey(key)
end

function CollegeController.setOnceActionKey(type, id)
	local key = CollegeController._getOnceAnimKey(type, id)

	PlayerPrefsHelper.setNumber(key, 1)
end

function CollegeController._getOnceAnimKey(type, id)
	return string.format("%s%s_%s_%s", PlayerPrefsKey.CollegeOnceAnim, PlayerModel.instance:getPlayinfo().userId, type, id)
end

function CollegeController.showNewChapterPage()
	local lastChainId = CollegeModel.instance:getSceneMo().milestoneBox.lastChainId[CollegeEnum.RelationShipBoardPage.Chapter13]

	return not not lastChainId
end

CollegeController.instance = CollegeController.New()

return CollegeController
