-- chunkname: @modules/logic/sp02/dungeon/view/V3A10_HeroGroupFightViewLevel.lua

module("modules.logic.sp02.dungeon.view.V3A10_HeroGroupFightViewLevel", package.seeall)

local V3A10_HeroGroupFightViewLevel = class("V3A10_HeroGroupFightViewLevel", HeroGroupFightViewLevel)

function V3A10_HeroGroupFightViewLevel:onInitView()
	V3A10_HeroGroupFightViewLevel.super.onInitView(self)

	self._sp02targetList = {}
	self._gosp02conditionItem = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_atomicheartcondition")

	gohelper.setActive(self._gosp02conditionItem, false)

	self._gosp02Star1 = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/text/starcontainer/image_icon1")
	self._gosp02Star2 = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/text/starcontainer/image_icon2")
	self._gosp02Star3 = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/text/starcontainer/image_icon3")
end

function V3A10_HeroGroupFightViewLevel:_refreshTarget()
	self:_initStars()

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(self._episodeId)
	local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)

	gohelper.setActive(self._gotargetlist, true)

	local isHardMode = chapterConfig.type == DungeonEnum.ChapterType.Hard

	gohelper.setActive(self._gohardEffect, isHardMode)
	gohelper.setActive(self._gobalanceEffect, HeroGroupBalanceHelper.getIsBalanceMode())

	self._isHardMode = isHardMode

	local normalEpisodeId = self._episodeId

	if normalEpisodeId then
		::label_2_0::

		local normalEpisodeInfo = DungeonModel.instance:getEpisodeInfo(normalEpisodeId)

		if normalEpisodeId then
			::label_2_1::

			local passStory = DungeonModel.instance:hasPassLevelAndStory(normalEpisodeId)

			if normalEpisodeId then
				::label_2_2::

				local advancedConditionText = DungeonConfig.instance:getEpisodeAdvancedConditionText(normalEpisodeId)
				local isOnlyShowOneTarget = true
				local passNormal = normalEpisodeInfo and normalEpisodeInfo.star >= DungeonEnum.StarType.Normal and passStory
				local passAdvanced = normalEpisodeInfo and normalEpisodeInfo.star >= DungeonEnum.StarType.Advanced and passStory
				local condition = DungeonConfig.instance:getFirstEpisodeWinConditionText(normalEpisodeId)

				self:refreshTargetItem(1, condition, passNormal and 0.5 or 0)

				if not string.nilorempty(advancedConditionText) then
					self:refreshTargetItem(2, advancedConditionText, passAdvanced and 1 or 0)

					isOnlyShowOneTarget = false
				end

				gohelper.setActive(self._goplace, isOnlyShowOneTarget)
			end
		end
	end
end

function V3A10_HeroGroupFightViewLevel:_initStars()
	if self._starList then
		return
	end

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(self._episodeId)
	local mode = ActivityConfig.instance:getChapterIdMode(episodeConfig.chapterId)

	if mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		mode = VersionActivityDungeonBaseEnum.DungeonMode.Story3
	end

	gohelper.setActive(self._gosp02Star1, mode == VersionActivityDungeonBaseEnum.DungeonMode.Story)
	gohelper.setActive(self._gosp02Star2, mode == VersionActivityDungeonBaseEnum.DungeonMode.Story2)
	gohelper.setActive(self._gosp02Star3, mode == VersionActivityDungeonBaseEnum.DungeonMode.Story3)

	self._mode = mode
	self._starList = self:getUserDataTb_()
end

function V3A10_HeroGroupFightViewLevel:createTargetItem(index)
	local item = self._sp02targetList[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._gosp02conditionItem, tostring(index))
		item.txt = gohelper.findChildTextMesh(item.go, "#txt_normalcondition")
		item.progressList = {}

		for i = 1, 3 do
			local progressItem = self:getUserDataTb_()

			progressItem.go = gohelper.findChild(item.go, "#go_progressitem/image_icon" .. i)
			progressItem.img = gohelper.findChildImage(progressItem.go, "#image_fg")
			item.progressList[i] = progressItem
		end

		self._sp02targetList[index] = item
	end

	return item
end

function V3A10_HeroGroupFightViewLevel:refreshTargetItem(index, conditionText, progress)
	local item = self:createTargetItem(index)

	gohelper.setActive(item.go, true)

	item.txt.text = conditionText

	for i = 1, 3 do
		local progressItem = item.progressList[i]

		gohelper.setActive(progressItem.go, self._mode == i)

		if self._mode == i then
			progressItem.img.fillAmount = progress
		end
	end
end

return V3A10_HeroGroupFightViewLevel
