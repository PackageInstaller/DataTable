-- chunkname: @modules/logic/sp01/assassin2/story/dungeon/VersionActivity2_9DungeonMapChapterLayout.lua

module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9DungeonMapChapterLayout", package.seeall)

local VersionActivity2_9DungeonMapChapterLayout = class("VersionActivity2_9DungeonMapChapterLayout", VersionActivityFixedDungeonMapChapterLayout)

function VersionActivity2_9DungeonMapChapterLayout:onInitView()
	VersionActivity2_9DungeonMapChapterLayout.super.onInitView(self)

	self._gotimeline = gohelper.findChild(self.viewGO, "timeline")

	gohelper.setActive(self._gotimeline, false)

	self._nodeVectorList = {}
	self._nodeScreenPosList = {}
end

function VersionActivity2_9DungeonMapChapterLayout:addEvents()
	VersionActivity2_9DungeonMapChapterLayout.super.addEvents(self)
	self.addEventCb(self, VersionActivity2_9DungeonController.instance, VersionActivity2_9Event.OnAllWorkLoadDone, self._onAllWorkLoadDone, self, LuaEventSystem.Low)
	self.addEventCb(self, VersionActivity2_9DungeonController.instance, VersionActivity2_9Event.OnUpdateEpisodeNodePos, self._onUpdateEpisodeNodePos, self)
end

function VersionActivity2_9DungeonMapChapterLayout:_onUpdateEpisodeNodePos(index, posX, posY, posZ)
	self:_saveEpisodeNodePos(index, posX, posY, posZ)
	self:_setEpisodeItemAnchorX(index)
end

function VersionActivity2_9DungeonMapChapterLayout:_saveEpisodeNodePos(index, posX, posY, posZ)
	local nodeVector = self._nodeVectorList[index]

	if not nodeVector then
		nodeVector = Vector2()

		table.insert(self._nodeVectorList, nodeVector)
	end

	local nodePosX, nodePosY = recthelper.worldPosToAnchorPosXYZ(posX, posY, posZ, self.contentTransform)

	nodeVector:Set(nodePosX, nodePosY)
end

function VersionActivity2_9DungeonMapChapterLayout:_onAllWorkLoadDone()
	if self._isInited then
		return
	end

	self:refreshEpisodeNodes()

	self._isInited = true
end

function VersionActivity2_9DungeonMapChapterLayout:_setEpisodeItemAnchorX(index, item)
	if self._episodeContainerItemList then
		if self._nodeVectorList then
			local nodeVector = self._nodeVectorList[index]

			if not self._episodeContainerItemList or not nodeVector then
				return
			end

			recthelper.setAnchor(self._episodeContainerItemList.containerTr, nodeVector.x, nodeVector.y)
		end
	end
end

function VersionActivity2_9DungeonMapChapterLayout:refreshEpisodeNodes()
	VersionActivity2_9DungeonMapChapterLayout.super.refreshEpisodeNodes(self)

	if self._episodeContainerItemList then
		self._lastEpisodeIndex = #self._episodeContainerItemList or 0
	end

	self._contentWidth = 100000

	recthelper.setSize(self.contentTransform, self._contentWidth, self._rawHeight)
end

function VersionActivity2_9DungeonMapChapterLayout:setFocusItem(focusItemGo, tween)
	if not focusItemGo then
		return
	end

	local focusIndex = self:_getEpisodeItemIndex(focusItemGo)

	VersionActivity2_9DungeonController.instance:dispatchEvent(VersionActivity2_9Event.FocusEpisodeNode, focusIndex, tween)
end

function VersionActivity2_9DungeonMapChapterLayout:_getEpisodeItemIndex(focusItemGo)
	for index, item in ipairs(self._episodeContainerItemList) do
		if item.episodeItem.viewGO == focusItemGo then
			return index
		end
	end
end

function VersionActivity2_9DungeonMapChapterLayout:tryClickDNA(eventPosition)
	for _, containerItem in ipairs(self._episodeContainerItemList) do
		local isClick = containerItem.episodeItem:isScreenPosInDNAClickArea(eventPosition)

		if isClick then
			containerItem.episodeItem:onClick()

			return true
		end
	end
end

return VersionActivity2_9DungeonMapChapterLayout
