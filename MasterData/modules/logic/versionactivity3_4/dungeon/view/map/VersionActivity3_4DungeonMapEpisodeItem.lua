-- chunkname: @modules/logic/versionactivity3_4/dungeon/view/map/VersionActivity3_4DungeonMapEpisodeItem.lua

module("modules.logic.versionactivity3_4.dungeon.view.map.VersionActivity3_4DungeonMapEpisodeItem", package.seeall)

local VersionActivity3_4DungeonMapEpisodeItem = class("VersionActivity3_4DungeonMapEpisodeItem", VersionActivityFixedDungeonMapEpisodeItem)

function VersionActivity3_4DungeonMapEpisodeItem:addEvents()
	VersionActivity3_4DungeonMapEpisodeItem.super.addEvents(self)
	self.addEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivity3_4DungeonEvent.V3a2ClickEpisodeItem, self._onV3a2ClickEpisodeItem, self)
end

function VersionActivity3_4DungeonMapEpisodeItem:_onV3a2ClickEpisodeItem(episodeId)
	if episodeId == self._config.id then
		self:onClick()
	end
end

function VersionActivity3_4DungeonMapEpisodeItem:_showAllElementTipView()
	if not self._map or self._config.chapterId == VersionActivityFixedHelper.getVersionActivityDungeonEnum(self._bigVersion, self._smallVersion).DungeonChapterId.Hard then
		gohelper.setActive(self._gotipcontent, false)

		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DungeonHideElementTip) then
		return
	end

	local finishElementCoList, mapAllElementList = VersionActivityFixedDungeonModel.instance:getElementCoListWithFinish(self._map.id)

	if not mapAllElementList or #mapAllElementList < 1 then
		gohelper.setActive(self._gotipcontent, false)

		self._showAllElementTip = false
	else
		local finishCount = GameUtil.getTabLen(finishElementCoList)
		local elementItem

		for index, _ in ipairs(mapAllElementList) do
			elementItem = self.elementItemList[index]

			if not self.elementItemList[index] then
				elementItem = self:getUserDataTb_()
				elementItem.go = gohelper.cloneInPlace(self._gotipitem)
				elementItem.goNotFinish = gohelper.findChild(elementItem.go, "type1")
				elementItem.goFinish = gohelper.findChild(elementItem.go, "type2")
				elementItem.animator = elementItem.go:GetComponent(typeof(UnityEngine.Animator))
				elementItem.status = nil

				table.insert(self.elementItemList, elementItem)
			end

			gohelper.setActive(elementItem.go, true)

			if self.pass then
				local isFinish = index <= finishCount

				gohelper.setActive(elementItem.goNotFinish, not isFinish)
				gohelper.setActive(elementItem.goFinish, isFinish)

				if elementItem.status == false and isFinish then
					gohelper.setActive(elementItem.goNotFinish, true)
					elementItem.animator:Play("switch", 0, 0)
					AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_light_up)
				end

				elementItem.status = isFinish
			end
		end

		local oldStatus = self._showAllElementTip

		self._showAllElementTip = self.pass and finishCount ~= #mapAllElementList

		if oldStatus and not self._showAllElementTip then
			TaskDispatcher.cancelTask(self._hideAllElementTip, self)
			TaskDispatcher.runDelay(self._hideAllElementTip, self, 0.8)
		else
			gohelper.setActive(self._gotipcontent, self._showAllElementTip)
		end
	end
end

return VersionActivity3_4DungeonMapEpisodeItem
