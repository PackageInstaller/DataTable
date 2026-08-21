-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/equipdungeon/EquipExploreSeedView.lua

module("logic.extensions.dungeon.view.equipdungeon.EquipExploreSeedView", package.seeall)

local M = class("EquipExploreSeedView", ViewComponent)

function M:buildUI()
	self._scrollEntrance = self:getUIComponent("equip_explore_seed_view_-1546688835", UIComponentType.ScrollRect)
	self._goEntryItem = self:getGo("equip_explore_tab_739774101")

	goutil.setActive(self._goEntryItem, false)
end

function M:destroyUI()
	self:setEvent(false)

	self._scrollEntrance = nil
	self._goEntryItem = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self:setEvent(true)
end

function M:onExit()
	self._nowTabSelect = nil
	self._nowTabDungeonId = nil
	self._defaultTabDungeonId = nil
	self._chapterCfgMo = nil
	self._canOpenMulti = nil
	self._dungeonData = nil

	for _, tweener in ipairs(self._cacheTweenLst or {}) do
		if tweener then
			tweener:Kill(false)
		end
	end
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.EQUIP_EXPLORE_CHAPTER_SELECT, self._handleEquipExploreChapterSelect, self)
	else
		GlobalDispatcher:removeEventListener(EventType.EQUIP_EXPLORE_CHAPTER_SELECT, self._handleEquipExploreChapterSelect, self)
	end
end

function M:_handleEquipExploreChapterSelect(e, chapterId)
	self:setChapterId(chapterId)
end

function M:setChapterId(chapterId)
	if not chapterId then
		self:onExit()

		return
	end

	if self._chapterId and self._chapterId ~= chapterId then
		self:onExit()
	end

	self._chapterId = chapterId

	self:_enterDungeonGroup(self._chapterId)
end

function M:isExpire(withPopup)
	if self._chapterCfgMo:getIsInWeekDay() then
		return false
	else
		if withPopup then
			local expireStr = string.format(lang("tip_copy_s"), self._chapterCfgMo:getWeekDayStr())

			FloatWordMgr.instance:show(expireStr)
		end

		return true
	end
end

function M:_enterDungeonGroup(chapterId)
	self._chapterCfgMo = DungeonEquipExploreChapterModel.instance:getChapterMoByChapterId(chapterId)
	self._canOpenMulti = self._chapterCfgMo:getCanOpenMulti()

	self:_duelDungeonGroupData(self._chapterCfgMo)
	self:_updateEntryTab(self._chapterCfgMo)
	self:_refreshEntryTab()
end

function M:_duelDungeonGroupData(chapterCfgMo)
	local dungeonIds = chapterCfgMo:getDungeonIds()
	local len = dungeonIds and #dungeonIds or 0
	local allDungeonClear = true

	self._dungeonData = {}

	if len > 0 then
		for _, dungeonId in ipairs(dungeonIds) do
			local mDungeonMo = DungeonEquipExploreChapterModel.instance:getDungeonMoById(dungeonId)

			if mDungeonMo then
				self._dungeonData[dungeonId] = mDungeonMo

				if not mDungeonMo:getIsClear() then
					allDungeonClear = false
				end

				if not mDungeonMo:getIsLock() and (self._defaultTabDungeonId == nil or dungeonId >= self._defaultTabDungeonId) then
					self._defaultTabDungeonId = dungeonId
				end
			else
				printError(string.format("无法从ChapterModel找到dungeonId[%d]的数据", dungeonId))
			end
		end

		if not self._defaultTabDungeonId then
			self._defaultTabDungeonId = dungeonIds[1]
		end
	end

	print(string.format("duelDungeonData,chapterId[%s] defaultTabDungeonId[%s]", chapterCfgMo:getChapterId(), self._defaultTabDungeonId))
end

function M:_getDungeonData(dungeonId)
	if self._dungeonData[dungeonId] then
		return self._dungeonData[dungeonId]
	end

	printError("无法找到dungeonData数据,DungeonId->", dungeonId)

	return nil
end

function M:_updateEntryTab(chapterCfgMo)
	for _, tweener in ipairs(self._cacheTweenLst or {}) do
		if tweener then
			tweener:Kill(false)
		end
	end

	self._cellTab = {}
	self._cacheTweenLst = {}

	local rootTr = self._scrollEntrance.content
	local dungeonIds = chapterCfgMo:getDungeonIds()
	local len = dungeonIds and #dungeonIds or 0

	while rootTr.childCount < len + 1 do
		goutil.cloneAndSetParent(self._goEntryItem, rootTr)
	end

	if len > 0 then
		for index, dungeonId in ipairs(dungeonIds) do
			local delay = index * 0.05 + 0.05

			delay = delay > 1 and 1 or delay

			local dungeonMo = self:_getDungeonData(dungeonId)
			local tmpGo = rootTr:GetChild(index).gameObject
			local cellBehavior = Astral.SimpleLuaComponentContainer.Add(tmpGo, EquipExploreSeedTabCell)

			cellBehavior:setData(index, dungeonMo)
			cellBehavior:setChapterMo(chapterCfgMo)
			cellBehavior:setHandler(self)
			cellBehavior:setSelected(false)
			goutil.setActive(tmpGo, false)

			self._cellTab[dungeonId] = cellBehavior

			local tweenDelay = DoTweenUtil.DelayedCall(delay, function()
				goutil.setActive(tmpGo, true)
			end)

			table.insert(self._cacheTweenLst, tweenDelay)
		end
	end

	local defaultTabDungeonId = self._defaultTabDungeonId

	if defaultTabDungeonId then
		self:_selectTabByMatDungeonId(defaultTabDungeonId)

		local tweenDelay = DoTweenUtil.DelayedCall(0, function()
			self:_scrollJumpToTab(defaultTabDungeonId)
		end)

		table.insert(self._cacheTweenLst, tweenDelay)
	end

	self._defaultTabDungeonId = nil
end

function M:_scrollJumpToTab(dungeonId)
	if not dungeonId then
		return
	end

	local tab = self:_getTab(dungeonId)

	if tab and self._scrollEntrance then
		self._scrollEntrance:StopMovement()

		local limit = goutil.getHeight(self._scrollEntrance.content) - goutil.getHeight(self._scrollEntrance.viewport)
		local posY = tab:getMainGo().transform.anchoredPosition.y * -1

		posY = limit < posY and limit or posY

		Astral.TransformUtil.SetAnchoredPos(self._scrollEntrance.content, 0, posY)
	end
end

function M:_getTab(dungeonId)
	if self._cellTab[dungeonId] then
		return self._cellTab[dungeonId]
	end

	printError(string.format("无法找到DungeonId[%d]的tab", dungeonId))

	return nil
end

function M:_refreshEntryTab()
	for dungeonId, shower in pairs(self._cellTab or {}) do
		local dungeonData = self:_getDungeonData(dungeonId)

		if dungeonData then
			shower:setIsLock(not dungeonData:getIsUnlock())
		end
	end
end

function M:cellCallSelectTab(tabCellBehavior)
	local dungeonId = tabCellBehavior:getCommonDungeonId()

	self:_selectTabByMatDungeonId(dungeonId)
end

function M:_selectTabByMatDungeonId(dungeonId)
	if self._nowTabDungeonId and self._nowTabDungeonId == dungeonId then
		return
	end

	if self:isExpire(true) then
		return
	end

	self._nowTabDungeonId = dungeonId

	self:_updateTabShowAfterTabSelect()
	GlobalDispatcher:dispatchEvent(EventType.EQUIP_EXPLORE_DUNGEON_SELECT, dungeonId)

	if false then
		printError(string.format("没有tab dungeonId[%d]数据", dungeonId))
	end
end

function M:_formatLevel(level)
	local a = math.floor(level / 10)
	local b = level % 10

	return string.format("%s-%s", a, b)
end

function M:_updateTabShowAfterTabSelect()
	if self._nowTabSelect then
		self._nowTabSelect:setSelected(false)
	end

	local tab = self:_getTab(self._nowTabDungeonId)

	if tab then
		tab:setSelected(true)
	end

	self._nowTabSelect = tab
end

return M
