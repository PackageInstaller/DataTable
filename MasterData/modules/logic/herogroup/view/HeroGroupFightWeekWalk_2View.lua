-- chunkname: @modules/logic/herogroup/view/HeroGroupFightWeekWalk_2View.lua

module("modules.logic.herogroup.view.HeroGroupFightWeekWalk_2View", package.seeall)

local HeroGroupFightWeekWalk_2View = class("HeroGroupFightWeekWalk_2View", BaseView)

function HeroGroupFightWeekWalk_2View:onInitView()
	self._dropherogroup = gohelper.findChildDropdown(self.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup")
end

function HeroGroupFightWeekWalk_2View:addEvents()
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, self._onModifyGroupSelectIndex, self)
end

function HeroGroupFightWeekWalk_2View:removeEvents()
	return
end

function HeroGroupFightWeekWalk_2View:_onModifyGroupSelectIndex()
	self:_updateWeekWalkGroupSelectIndex()
end

function HeroGroupFightWeekWalk_2View:onOpen()
	self._episodeId = HeroGroupModel.instance.episodeId
	self.episodeConfig = DungeonConfig.instance:getEpisodeCO(self._episodeId)
	self._chapterConfig = DungeonConfig.instance:getChapterCO(self.episodeConfig.chapterId)
end

function HeroGroupFightWeekWalk_2View:onOpenFinish()
	TaskDispatcher.cancelTask(self._setWeekWalkGroupSelectIndex, self)
	TaskDispatcher.runDelay(self._setWeekWalkGroupSelectIndex, self, 0)
end

function HeroGroupFightWeekWalk_2View:_setWeekWalkGroupSelectIndex()
	if self._chapterConfig.type ~= DungeonEnum.ChapterType.WeekWalk_2 then
		return
	end

	local mapInfo = WeekWalk_2Model.instance:getCurMapInfo()
	local layer = mapInfo:getLayer()
	local battleId = HeroGroupModel.instance.battleId
	local battleInfo = mapInfo:getBattleInfoByBattleId(battleId)
	local curGroupSelectIndex = HeroGroupModel.instance.curGroupSelectIndex
	local firstLayerUpdate = layer == WeekWalk_2Enum.FirstDeepLayer and battleInfo.heroGroupSelect ~= curGroupSelectIndex
	local otherLayerUpdate = layer ~= WeekWalk_2Enum.FirstDeepLayer and battleInfo.heroGroupSelect ~= 0 and battleInfo.heroGroupSelect ~= curGroupSelectIndex

	if firstLayerUpdate or otherLayerUpdate then
		Weekwalk_2Rpc.instance:sendWeekwalkVer2ChangeHeroGroupSelectRequest(mapInfo.id, battleId, curGroupSelectIndex)
	end

	if layer ~= WeekWalk_2Enum.FirstDeepLayer and battleInfo.heroGroupSelect == 0 then
		local prevBattleInfo = WeekWalk_2Model.instance:getBattleInfoByLayerAndIndex(layer - 1, battleInfo.index)

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
				UIBlockMgr.instance:startBlock("HeroGroupFightWeekWalk_2ViewChangeGroup")
				TaskDispatcher.cancelTask(self._changeGroupIndex, self)

				local time = self:_anyHeroInCd() and 2.2 or 0.8

				TaskDispatcher.runDelay(self._changeGroupIndex, self, time)
			end
		end
	end
end

function HeroGroupFightWeekWalk_2View:_anyHeroInCd()
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

function HeroGroupFightWeekWalk_2View:_changeGroupIndex()
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("HeroGroupFightWeekWalk_2ViewChangeGroup")

	local heroGroupFightView = self.viewContainer:getHeroGroupFightView()

	heroGroupFightView:setGroupChangeToast(ToastEnum.WeekWalkChangeGroup)
	HeroGroupPresetController.instance:dispatchEvent(HeroGroupPresetEvent.UseHeroGroup, {
		groupId = ModuleEnum.HeroGroupSnapshotType.Common,
		subId = self._changeIndex
	})
	heroGroupFightView:setGroupChangeToast(nil)
end

function HeroGroupFightWeekWalk_2View:_updateWeekWalkGroupSelectIndex()
	if self._chapterConfig.type ~= DungeonEnum.ChapterType.WeekWalk_2 then
		return
	end

	local mapInfo = WeekWalk_2Model.instance:getCurMapInfo()
	local layer = mapInfo:getLayer()
	local battleId = HeroGroupModel.instance.battleId
	local battleInfo = mapInfo:getBattleInfoByBattleId(battleId)
	local curGroupSelectIndex = HeroGroupModel.instance.curGroupSelectIndex

	if battleInfo.heroGroupSelect ~= curGroupSelectIndex then
		Weekwalk_2Rpc.instance:sendWeekwalkVer2ChangeHeroGroupSelectRequest(mapInfo.id, battleId, curGroupSelectIndex)
	end
end

function HeroGroupFightWeekWalk_2View:onClose()
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("HeroGroupFightWeekWalk_2ViewChangeGroup")
	TaskDispatcher.cancelTask(self._changeGroupIndex, self)
	TaskDispatcher.cancelTask(self._setWeekWalkGroupSelectIndex, self)
end

return HeroGroupFightWeekWalk_2View
