-- chunkname: @modules/logic/college/gm/CollegeGMExtend.lua

module("modules.logic.college.gm.CollegeGMExtend", package.seeall)

local CollegeGMExtend = class("CollegeGMExtend", GMServerCommandExtendBase)

function CollegeGMExtend:initUI()
	local obj = self.obj

	obj:addLineIndex()
	obj:addButton(obj:getLineGroup(), "打印属性", self._printAttrs, self)
	obj:addButton(obj:getLineGroup(), "清空每日气泡对话", self._clearBubble, self)
	obj:addLabel(obj:getLineGroup(), "状态ID")

	self._stateInput = obj:addInputText(obj:getLineGroup())

	obj:addButton(obj:getLineGroup(), "改变状态", self._changeState, self)
	obj:addLineIndex()

	self._storyInput = obj:addInputText(obj:getLineGroup())

	obj:addButton(obj:getLineGroup(), "播放剧情", self._playStory, self)
	obj:addButton(obj:getLineGroup(), "预览所有路线", self._showAllPaths, self)
end

function CollegeGMExtend:_playStory()
	local storyId = tonumber(self._storyInput:GetText()) or 0

	self.obj:closeThis()
	CollegeStoryHelper.instance:playStory(storyId)
end

function CollegeGMExtend:_showAllPaths()
	local view = ViewMgr.instance:getContainer(ViewName.CollegeMainView)

	if not view then
		return
	end

	for i, v in ipairs(view._views) do
		if v.class == CollegeChessMoveRouteView then
			v:debugShowChess()

			break
		end
	end
end

function CollegeGMExtend:_changeState()
	local stateId = tonumber(self._stateInput:GetText())
	local sceneMo = CollegeModel.instance:getSceneMo()

	if not sceneMo then
		return
	end

	local chainCo = lua_college_character_chain.configDict[stateId]

	if not chainCo then
		ToastController.instance:showToastWithString("不存在的状态ID")

		return
	end

	sceneMo.milestoneBox:updateLastChainId(stateId)
	CollegeController.instance:dispatchEvent(CollegeEvent.UpdateLastChainId)

	if ViewMgr.instance:isOpen(ViewName.CollegeRelationShipBoard) then
		ViewMgr.instance:closeView(ViewName.CollegeRelationShipBoard)
		TaskDispatcher.runDelay(function()
			ViewMgr.instance:openView(ViewName.CollegeRelationShipBoard)
		end, {}, 0.5)
		self.obj:closeThis()
	end
end

function CollegeGMExtend:_printAttrs()
	for itemId in pairs(CollegeEnum.ItemIdToAttrSuffix) do
		local buildingAdd = CollegeAttrHelper.getBuildingProduce(itemId)
		local areaAdd = CollegeAttrHelper.getAreaProduce(itemId)
		local otherAdd = CollegeAttrHelper.getOtherProduce(itemId)
		local itemCo = lua_college_item.configDict[itemId]

		logError(string.format("%s{%s}建筑加成: %s, 区域加成: %s, 其他加成: %s。总共: %s", itemCo.name, itemId, buildingAdd, areaAdd, otherAdd, buildingAdd + areaAdd + otherAdd))
	end

	local refinedBuildingMo = CollegeModel.instance:getBuildingMoByType(CollegeEnum.BuildingType.TrainCharacter)

	if refinedBuildingMo then
		local rate1 = 1 + refinedBuildingMo.attributeContainer:getAttrVal(CollegeEnum.AttrId.BuildingRefineCostFix) / 1000
		local rate2 = refinedBuildingMo.attributeContainer:getAttrVal(CollegeEnum.AttrId.RoleRefineCostFix) / 1000
		local rate3 = CollegeModel.instance:getSceneMo().player.attributeContainer:getAttrVal(CollegeEnum.AttrId.PlayerRefineCostFix) / 1000

		logError(string.format("洗练消耗加成: 建筑：%s%%, 角色：%s%%, 全局：%s%%。总共: %s%%", rate1 * 100, rate2 * 100, rate3 * 100, (rate1 + rate2 + rate3) * 100))
	end

	local recruitBuildingMo = CollegeModel.instance:getBuildingMoByType(CollegeEnum.BuildingType.RecruitCharacter)

	if recruitBuildingMo then
		local rate1 = 1 + recruitBuildingMo.attributeContainer:getAttrVal(CollegeEnum.AttrId.BuildingRecruitCostFix) / 1000
		local rate2 = recruitBuildingMo.attributeContainer:getAttrVal(CollegeEnum.AttrId.RoleRecruitCostFix) / 1000
		local rate3 = CollegeModel.instance:getSceneMo().player.attributeContainer:getAttrVal(CollegeEnum.AttrId.PlayerRecruitCostFix) / 1000

		logError(string.format("招募消耗加成: 建筑：%s%%, 角色：%s%%, 全局：%s%%。总共: %s%%", rate1 * 100, rate2 * 100, rate3 * 100, (rate1 + rate2 + rate3) * 100))
	end
end

function CollegeGMExtend:_clearBubble()
	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.CollegeBubbleGroupPlayedTime, "")
	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.CollegeSceneBubbleGroupPlayedTime, "")
end

function CollegeGMExtend:getInput_cgaddItem_1(inputData, lastInput)
	local obj = self.obj
	local allItems = {}
	local itemNames = {}
	local selectVal = 1

	for i, v in ipairs(lua_college_item.configList) do
		table.insert(allItems, v)
		table.insert(itemNames, v.name .. "\n" .. v.id)

		if tonumber(lastInput) == v.id then
			selectVal = i
		end
	end

	local dropDown = obj:addDropDown(obj:getLineGroup(), "", itemNames)

	dropDown:SetValue(selectVal - 1)
	recthelper.setWidth(dropDown.transform, 300)

	inputData.items = allItems
	inputData.input = dropDown

	return inputData
end

function CollegeGMExtend:getText_cgaddItem_1(input)
	local index = input.input:GetValue() + 1

	return tostring(input.items[index].id)
end

function CollegeGMExtend:onCommandClick_cgreset()
	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.CollegeEnterCityTips, 0)
	CollegeRpc.instance:sendCollegeSceneInfo()
end

function CollegeGMExtend:onCommandClick_cgsetCurrentEventBox()
	self.obj:closeThis()
end

return CollegeGMExtend
