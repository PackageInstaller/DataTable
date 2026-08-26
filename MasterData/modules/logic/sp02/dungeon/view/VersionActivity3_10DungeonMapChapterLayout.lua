-- chunkname: @modules/logic/sp02/dungeon/view/VersionActivity3_10DungeonMapChapterLayout.lua

module("modules.logic.sp02.dungeon.view.VersionActivity3_10DungeonMapChapterLayout", package.seeall)

local VersionActivity3_10DungeonMapChapterLayout = class("VersionActivity3_10DungeonMapChapterLayout", VersionActivityFixedDungeonMapChapterLayout)

function VersionActivity3_10DungeonMapChapterLayout:onInitView()
	VersionActivity3_10DungeonMapChapterLayout.super.onInitView(self)

	self._gotimeline = gohelper.findChild(self.viewGO, "timeline")

	gohelper.setActive(self._gotimeline, false)

	self._constDungeonNormalDeltaX = 0
	self._constDungeonNormalPosX = 660
	self._offsetX = 1260
end

function VersionActivity3_10DungeonMapChapterLayout:setFocusItem(focusItemGo, tween)
	if not focusItemGo then
		return
	end

	local focusIndex = self:_getEpisodeItemIndex(focusItemGo)

	VersionActivity3_10DungeonController.instance:dispatchEvent(VersionActivity3_10Event.FocusEpisodeNode, focusIndex, tween)
end

function VersionActivity3_10DungeonMapChapterLayout:_getEpisodeItemIndex(focusItemGo)
	for index, item in ipairs(self._episodeContainerItemList) do
		if item.episodeItem.viewGO == focusItemGo then
			return index
		end
	end
end

function VersionActivity3_10DungeonMapChapterLayout:getShowEpisodePercent()
	if not self._showEpisodeCount then
		local cur = 0

		if not self._allEpisodeCount then
			local all = 1

			if all <= 1 then
				return 1
			end

			local w2 = self:getContentWidth(all)

			if w2 <= 0 then
				return 0
			end

			local w1 = self:getContentWidth(cur)

			return w1 / w2
		end
	end
end

function VersionActivity3_10DungeonMapChapterLayout:getContentWidth(episodeCount)
	local startSpace = self._constDungeonNormalPosX + 100
	local itemWidth = 400
	local space = 0
	local endSpace = self._offsetX
	local contentWidth = (episodeCount - 1) * itemWidth + (episodeCount - 1) * space + startSpace + endSpace - self.viewWidth

	return math.max(contentWidth, 0)
end

function VersionActivity3_10DungeonMapChapterLayout:getEpisodePercent(index)
	local cur = index
	local all = self._showEpisodeCount

	if all <= 1 then
		return 1
	end

	return Mathf.Clamp((cur - 1) / (all - 1), 0, 1)
end

function VersionActivity3_10DungeonMapChapterLayout:getEpisodeContainerItem(index)
	local episodeContainerItem = self._episodeContainerItemList[index]

	if episodeContainerItem then
		gohelper.setActive(episodeContainerItem.containerTr.gameObject, true)
		episodeContainerItem.episodeItem:clearElementIdList()

		return episodeContainerItem
	end

	episodeContainerItem = self:getUserDataTb_()

	local go = gohelper.cloneInPlace(self._gotemplatenormal, tostring(index))

	gohelper.setAsFirstSibling(go)
	gohelper.setActive(go, true)

	episodeContainerItem.containerTr = go.transform

	local isSingle = index % 2 == 1
	local posY = isSingle and -540 or -340

	recthelper.setAnchorY(episodeContainerItem.containerTr, posY)

	local episodeItemViewGo = self.viewContainer:getResInst(self.episodeItemPath, go)
	local goLineup = gohelper.findChild(episodeItemViewGo, "#go_lineup")
	local goLinedown = gohelper.findChild(episodeItemViewGo, "#go_linedown")

	gohelper.setActive(goLineup, index ~= 1 and not isSingle)
	gohelper.setActive(goLinedown, index ~= 1 and isSingle)

	local episodeItem = self.activityDungeonMo:getEpisodeItemClass().New()

	episodeItem.viewContainer = self.viewContainer
	episodeItem.activityDungeonMo = self.activityDungeonMo

	episodeItem:initView(episodeItemViewGo, {
		self.contentTransform,
		self
	})

	episodeContainerItem.episodeItem = episodeItem

	table.insert(self._episodeContainerItemList, episodeContainerItem)

	return episodeContainerItem
end

return VersionActivity3_10DungeonMapChapterLayout
