-- chunkname: @modules/versionactivitybase/fixed1/dungeon/view/map/VersionActivityFixedDungeonMapTaskInfo1.lua

module("modules.versionactivitybase.fixed1.dungeon.view.map.VersionActivityFixedDungeonMapTaskInfo1", package.seeall)

local VersionActivityFixedDungeonMapTaskInfo1 = class("VersionActivityFixedDungeonMapTaskInfo1", BaseView)

function VersionActivityFixedDungeonMapTaskInfo1:onInitView()
	self._txtTaskDesc = gohelper.findChildText(self.viewGO, "#scroll_task/Viewport/#go_taskContent/go_main/go_mainItem/txt_taskDesc")
	self._txtTaskDesc.text = luaLang("dungeon_element_name_index")
	self._goTaskTitle = gohelper.findChild(self.viewGO, "#scroll_task/Viewport/#go_taskContent/go_main")

	gohelper.setActive(self._goTaskTitle, false)

	self._goTaskContainer = gohelper.findChild(self.viewGO, "#scroll_task/Viewport/#go_taskContent/go_sub")
	self._gotaskitem = gohelper.findChild(self.viewGO, "#scroll_task/Viewport/#go_taskContent/go_sub/go_subItem")

	gohelper.setActive(self._gotaskitem, false)

	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#scroll_task/Viewport/#go_taskContent/go_main/go_mainItem/#btn_click")
	self._goArrow = gohelper.findChild(self.viewGO, "#scroll_task/Viewport/#go_taskContent/go_main/go_mainItem/#btn_click/icon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityFixedDungeonMapTaskInfo1:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function VersionActivityFixedDungeonMapTaskInfo1:removeEvents()
	self._btnclick:RemoveClickListener()
end

function VersionActivityFixedDungeonMapTaskInfo1:_btnclickOnClick()
	self._isUnFold = not self._isUnFold

	self:_updateFoldBtn()
end

function VersionActivityFixedDungeonMapTaskInfo1:_updateFoldBtn()
	gohelper.setActive(self._goTaskContainer, self._isUnFold)
	transformhelper.setLocalRotation(self._goArrow.transform, 0, 0, self._isUnFold and 90 or 270)
end

function VersionActivityFixedDungeonMapTaskInfo1:_editableInitView()
	self._itemList = self:getUserDataTb_()

	self.addEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent1.TimelineChange, self._onTimelineChange, self)
end

function VersionActivityFixedDungeonMapTaskInfo1:onUpdateParam()
	return
end

function VersionActivityFixedDungeonMapTaskInfo1:_showTaskList(episodeId, skipShowTaskList)
	local mapCfg = VersionActivityFixedDungeonConfig.instance:getEpisodeMapConfig(episodeId)

	if not mapCfg then
		return
	end

	self._curEpisodeId = episodeId

	local isHardMode = self.activityDungeonMo:isHardMode()

	if isHardMode then
		self:_doShowTaskList(self._curEpisodeId)

		return
	end

	self:_doShowAllTaskList()
end

function VersionActivityFixedDungeonMapTaskInfo1:_onTimelineChange(showMap)
	local isHardMode = self.activityDungeonMo:isHardMode()

	if isHardMode then
		return
	end

	self._showMap = showMap

	self:_doShowAllTaskList()
end

function VersionActivityFixedDungeonMapTaskInfo1:_doShowAllTaskList()
	local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	local scriptSuffix = VersionActivityFixedHelper.getVersionActivityScriptSuffix(bigVersion, smallVersion)
	local sceneElements = VersionActivityFixedHelper.getVersionActivityDungeonMapSceneElements(bigVersion, smallVersion, scriptSuffix)
	local list = sceneElements.getAllElementCoList()
	local index = 0

	for i, elementConfig in ipairs(list) do
		local id = elementConfig.id

		index = index + 1

		local item = self:_getItem(index)

		item:setParam({
			index,
			id
		})
		gohelper.setActive(item.viewGO, true)
	end

	for i = index + 1, #self._itemList do
		self._itemList[i]:playTaskOutAnim()
	end

	self._elementNum = index

	local showTitle = self._elementNum > 3

	self._isUnFold = true

	gohelper.setActive(self._goTaskTitle, showTitle)
	self:_updateFoldBtn()
end

function VersionActivityFixedDungeonMapTaskInfo1:_doShowTaskList(episodeId)
	local listStr = DungeonConfig.instance:getElementList(episodeId)
	local list = string.splitToNumber(listStr, "#")
	local config = DungeonConfig.instance:getEpisodeCO(episodeId)
	local map = DungeonMapEpisodeItem.getMap(config)

	for i = #list, 1, -1 do
		local elementCo = lua_chapter_map_element.configDict[list[i]]

		if elementCo and elementCo.mapId ~= map.Id then
			table.remove(list, i)
		end
	end

	if map and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DungeonHideElementTip) then
		local mapAllElementList = DungeonConfig.instance:getMapElements(map.id)

		if mapAllElementList then
			for i, v in ipairs(mapAllElementList) do
				if not tabletool.indexOf(list, v.id) then
					table.insert(list, v.id)
				end
			end
		end
	end

	local pass = DungeonModel.instance:hasPassLevelAndStory(episodeId)
	local index = 0

	for i, id in ipairs(list) do
		if pass then
			::label_11_0::

			local unfinished = not DungeonMapModel.instance:elementIsFinished(id)
			local elementConfig = lua_chapter_map_element.configDict[id]

			if unfinished and elementConfig and elementConfig.type ~= DungeonEnum.ElementType.UnLockExplore and elementConfig.type ~= DungeonEnum.ElementType.Investigate and not ToughBattleConfig.instance:isActEleCo(elementConfig) then
				index = index + 1

				local item = self:_getItem(index)

				item:setParam({
					index,
					id
				})
				gohelper.setActive(item.viewGO, true)
			end
		end
	end

	for i = index + 1, #self._itemList do
		self._itemList[i]:playTaskOutAnim()
	end

	self._elementNum = index

	local showTitle = self._elementNum > 3

	self._isUnFold = true

	gohelper.setActive(self._goTaskTitle, showTitle)
	self:_updateFoldBtn()
end

function VersionActivityFixedDungeonMapTaskInfo1:_getItem(index)
	local item = self._itemList[index]

	if not item then
		local go = gohelper.cloneInPlace(self._gotaskitem)

		item = MonoHelper.addLuaComOnceToGo(go, VersionActivityFixedDungeonMapTaskInfoItem1)
		self._itemList[index] = item
	end

	return item
end

function VersionActivityFixedDungeonMapTaskInfo1:onOpen()
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self._OnRemoveElement, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self._beginShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self._endShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.GuideShowElementAnimFinish, self._guideShowElementAnimFinish, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnInitElements, self.showElements, self)
end

function VersionActivityFixedDungeonMapTaskInfo1:showElements()
	self:_showTaskList(self.activityDungeonMo.episodeId)
end

function VersionActivityFixedDungeonMapTaskInfo1:_onUpdateDungeonInfo()
	self:_showTaskList(self.activityDungeonMo.episodeId, true)
end

function VersionActivityFixedDungeonMapTaskInfo1:_guideShowElementAnimFinish()
	self:_updateTaskList()
end

function VersionActivityFixedDungeonMapTaskInfo1:_beginShowRewardView()
	self._showRewardView = true
end

function VersionActivityFixedDungeonMapTaskInfo1:_endShowRewardView()
	self._showRewardView = false

	TaskDispatcher.runDelay(self._updateTaskList, self, DungeonEnum.RefreshTimeAfterShowReward)
end

function VersionActivityFixedDungeonMapTaskInfo1:_updateTaskList()
	self:_showTaskList(self.activityDungeonMo.episodeId)
end

function VersionActivityFixedDungeonMapTaskInfo1:_OnRemoveElement(id)
	if self._showRewardView then
		return
	end

	self:_updateTaskList()
end

function VersionActivityFixedDungeonMapTaskInfo1:onClose()
	TaskDispatcher.cancelTask(self._updateTaskList, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self._OnRemoveElement, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self._beginShowRewardView, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self._endShowRewardView, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.GuideShowElementAnimFinish, self._guideShowElementAnimFinish, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnInitElements, self.showElements, self)
end

function VersionActivityFixedDungeonMapTaskInfo1:onDestroyView()
	return
end

return VersionActivityFixedDungeonMapTaskInfo1
