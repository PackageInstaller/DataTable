-- chunkname: @modules/logic/dungeon/view/map/DungeonMapTaskInfo.lua

module("modules.logic.dungeon.view.map.DungeonMapTaskInfo", package.seeall)

local DungeonMapTaskInfo = class("DungeonMapTaskInfo", BaseView)

function DungeonMapTaskInfo:onInitView()
	self._gotasklist = gohelper.findChild(self.viewGO, "#go_tasklist")
	self._gotaskitem = gohelper.findChild(self.viewGO, "#go_tasklist/#go_taskitem")
	self._gounlocktip = gohelper.findChild(self.viewGO, "#go_unlocktip")
	self._txtunlocktitle = gohelper.findChildText(self.viewGO, "#go_unlocktip/#txt_unlocktitle")
	self._txtunlockprogress = gohelper.findChildText(self.viewGO, "#go_unlocktip/#txt_unlockprogress")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonMapTaskInfo:addEvents()
	return
end

function DungeonMapTaskInfo:removeEvents()
	return
end

function DungeonMapTaskInfo:_editableInitView()
	self._itemList = self:getUserDataTb_()
end

function DungeonMapTaskInfo:onUpdateParam()
	return
end

function DungeonMapTaskInfo:_onChangeFocusEpisodeItem(episodeItem)
	if episodeItem == self._episodeItem then
		return
	end

	self._episodeItem = episodeItem
	self._episodeId = self._episodeItem:getEpisodeId()

	self:_showTaskList(self._episodeId)
end

function DungeonMapTaskInfo:_showTaskList(episodeId, skipShowTaskList)
	local config = DungeonConfig.instance:getEpisodeCO(episodeId)
	local chapterId = config.chapterId
	local nextChapterCfg = DungeonConfig.instance:getUnlockChapterConfig(chapterId)

	if nextChapterCfg then
		::label_7_0::

		local var_7_0 = DungeonModel.instance:chapterIsLock(nextChapterCfg.id)

		if var_7_0 then
			var_7_0 = DungeonModel.instance:chapterIsPass(chapterId)

			local showUnlockTip = var_7_0

			gohelper.setActive(self._gotasklist, not showUnlockTip)
			gohelper.setActive(self._gounlocktip, showUnlockTip)

			if showUnlockTip then
				self._txtunlocktitle.text = formatLuaLang("dungeonmapview_unlocktitle", nextChapterCfg.name)

				local cur, max = DungeonMapModel.instance:getTotalRewardPointProgress(chapterId)
				local tag = {
					cur,
					max
				}

				self._txtunlockprogress.text = GameUtil.getSubPlaceholderLuaLang(luaLang("dungeonmapview_unlockprogress"), tag)

				return
			end

			if skipShowTaskList then
				return
			end

			self:_doShowTaskList(episodeId)
		end
	end
end

function DungeonMapTaskInfo:_doShowTaskList(episodeId)
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
			::label_8_0::

			local unfinished = not DungeonMapModel.instance:elementIsFinished(id)
			local elementConfig = lua_chapter_map_element.configDict[id]

			if unfinished and elementConfig and elementConfig.type ~= DungeonEnum.ElementType.UnLockExplore and elementConfig.type ~= DungeonEnum.ElementType.Investigate and not ToughBattleConfig.instance:isActEleCo(elementConfig) and not DungeonMapModel.instance:isImplicitElementType(elementConfig.type) then
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
end

function DungeonMapTaskInfo:_getItem(index)
	local item = self._itemList[index]

	if not item then
		local go = gohelper.cloneInPlace(self._gotaskitem)

		item = MonoHelper.addLuaComOnceToGo(go, DungeonMapTaskInfoItem)
		self._itemList[index] = item
	end

	return item
end

function DungeonMapTaskInfo:onOpen()
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnChangeFocusEpisodeItem, self._onChangeFocusEpisodeItem, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self._OnRemoveElement, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self._beginShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self._endShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.GuideShowElementAnimFinish, self._guideShowElementAnimFinish, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
end

function DungeonMapTaskInfo:_onUpdateDungeonInfo()
	self:_showTaskList(self._episodeId, true)
end

function DungeonMapTaskInfo:_guideShowElementAnimFinish()
	self:_updateTaskList()
end

function DungeonMapTaskInfo:_beginShowRewardView()
	self._showRewardView = true
end

function DungeonMapTaskInfo:_endShowRewardView()
	self._showRewardView = false

	TaskDispatcher.runDelay(self._updateTaskList, self, DungeonEnum.RefreshTimeAfterShowReward)
end

function DungeonMapTaskInfo:_updateTaskList()
	self:_showTaskList(self._episodeId)
end

function DungeonMapTaskInfo:_OnRemoveElement(id)
	if self._showRewardView then
		return
	end

	self:_updateTaskList()
end

function DungeonMapTaskInfo:onClose()
	TaskDispatcher.cancelTask(self._updateTaskList, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnChangeFocusEpisodeItem, self._onChangeFocusEpisodeItem, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self._OnRemoveElement, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self._beginShowRewardView, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self._endShowRewardView, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.GuideShowElementAnimFinish, self._guideShowElementAnimFinish, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
end

function DungeonMapTaskInfo:onDestroyView()
	return
end

return DungeonMapTaskInfo
