-- chunkname: @modules/logic/herogroup/view/HeroGroupFightWeekWalkView.lua

module("modules.logic.herogroup.view.HeroGroupFightWeekWalkView", package.seeall)

local HeroGroupFightWeekWalkView = class("HeroGroupFightWeekWalkView", BaseView)

function HeroGroupFightWeekWalkView:onInitView()
	self._dropherogroup = gohelper.findChildDropdown(self.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup")
end

function HeroGroupFightWeekWalkView:addEvents()
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, self._onModifyGroupSelectIndex, self)
end

function HeroGroupFightWeekWalkView:removeEvents()
	return
end

function HeroGroupFightWeekWalkView:_onModifyGroupSelectIndex()
	self:_updateWeekWalkGroupSelectIndex()
end

function HeroGroupFightWeekWalkView:onOpen()
	self._episodeId = HeroGroupModel.instance.episodeId
	self.episodeConfig = DungeonConfig.instance:getEpisodeCO(self._episodeId)
	self._chapterConfig = DungeonConfig.instance:getChapterCO(self.episodeConfig.chapterId)
end

function HeroGroupFightWeekWalkView:onOpenFinish()
	TaskDispatcher.cancelTask(self._setWeekWalkGroupSelectIndex, self)
	TaskDispatcher.runDelay(self._setWeekWalkGroupSelectIndex, self, 0)
end

function HeroGroupFightWeekWalkView:_setWeekWalkGroupSelectIndex()
	if self._chapterConfig.type ~= DungeonEnum.ChapterType.WeekWalk then
		return
	end

	local mapInfo = WeekWalkModel.instance:getCurMapInfo()

	if not mapInfo then
		return
	end

	local layer = mapInfo:getLayer()

	if layer < WeekWalkEnum.FirstDeepLayer then
		return
	end

	local battleId = HeroGroupModel.instance.battleId
	local battleInfo = mapInfo:getBattleInfo(battleId)

	if not battleInfo then
		return
	end

	local curGroupSelectIndex = HeroGroupModel.instance.curGroupSelectIndex
	local firstLayerUpdate = layer == WeekWalkEnum.FirstDeepLayer and battleInfo.heroGroupSelect ~= curGroupSelectIndex
	local otherLayerUpdate = layer ~= WeekWalkEnum.FirstDeepLayer and battleInfo.heroGroupSelect ~= 0 and battleInfo.heroGroupSelect ~= curGroupSelectIndex

	if firstLayerUpdate or otherLayerUpdate then
		WeekwalkRpc.instance:sendChangeWeekwalkHeroGroupSelectRequest(mapInfo.id, battleId, curGroupSelectIndex)
	end

	if layer ~= WeekWalkEnum.FirstDeepLayer and battleInfo.heroGroupSelect == 0 then
		local prevBattleInfo = WeekWalkModel.instance:getBattleInfoByLayerAndIndex(layer - 1, battleInfo.index)

		if prevBattleInfo and prevBattleInfo.heroGroupSelect ~= 0 then
			local presetIndex = prevBattleInfo.heroGroupSelect

			presetIndex = HeroGroupPresetHeroGroupChangeController.instance:getValidHeroGroupId(HeroGroupModel.instance:getPresetHeroGroupType(), presetIndex)

			if presetIndex then
				self._changeIndex = presetIndex

				if presetIndex == curGroupSelectIndex then
					self:_updateWeekWalkGroupSelectIndex()

					return
				end

				UIBlockMgrExtend.setNeedCircleMv(false)
				UIBlockMgr.instance:startBlock("HeroGroupFightWeekWalkViewChangeGroup")
				TaskDispatcher.cancelTask(self._changeGroupIndex, self)

				local time = self:_anyHeroInCd() and 2.2 or 0.8

				TaskDispatcher.runDelay(self._changeGroupIndex, self, time)
			end
		end
	end
end

function HeroGroupFightWeekWalkView:_anyHeroInCd()
	for i = 1, ModuleEnum.MaxHeroCountInGroup do
		local mo = HeroSingleGroupModel.instance:getById(i)
		local heroMo = mo and mo:getHeroMO()

		if heroMo then
			::label_8_0::

			local cd = WeekWalkModel.instance:getCurMapHeroCd(heroMo.config.id)

			if cd and cd > 0 then
				return true
			end
		end
	end
end

function HeroGroupFightWeekWalkView:_changeGroupIndex()
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("HeroGroupFightWeekWalkViewChangeGroup")

	local heroGroupFightView = self.viewContainer:getHeroGroupFightView()

	heroGroupFightView:setGroupChangeToast(ToastEnum.WeekWalkChangeGroup)
	HeroGroupPresetController.instance:dispatchEvent(HeroGroupPresetEvent.UseHeroGroup, {
		groupId = ModuleEnum.HeroGroupSnapshotType.Common,
		subId = self._changeIndex
	})
	heroGroupFightView:setGroupChangeToast(nil)
end

function HeroGroupFightWeekWalkView:_updateWeekWalkGroupSelectIndex()
	if self._chapterConfig.type ~= DungeonEnum.ChapterType.WeekWalk then
		return
	end

	local mapInfo = WeekWalkModel.instance:getCurMapInfo()

	if not mapInfo then
		return
	end

	local layer = mapInfo:getLayer()

	if layer < WeekWalkEnum.FirstDeepLayer then
		return
	end

	local battleId = HeroGroupModel.instance.battleId
	local battleInfo = mapInfo:getBattleInfo(battleId)

	if not battleInfo then
		return
	end

	local curGroupSelectIndex = HeroGroupModel.instance.curGroupSelectIndex

	if battleInfo.heroGroupSelect ~= curGroupSelectIndex then
		WeekwalkRpc.instance:sendChangeWeekwalkHeroGroupSelectRequest(mapInfo.id, battleId, curGroupSelectIndex)
	end
end

function HeroGroupFightWeekWalkView:onClose()
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("HeroGroupFightWeekWalkViewChangeGroup")
	TaskDispatcher.cancelTask(self._changeGroupIndex, self)
	TaskDispatcher.cancelTask(self._setWeekWalkGroupSelectIndex, self)
end

return HeroGroupFightWeekWalkView
