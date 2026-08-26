-- chunkname: @modules/logic/dungeon/model/DungeonChapterListModel.lua

module("modules.logic.dungeon.model.DungeonChapterListModel", package.seeall)

local DungeonChapterListModel = class("DungeonChapterListModel", ListScrollModel)

function DungeonChapterListModel:setFbList()
	local chapterType = DungeonModel.instance.curChapterType
	local isNormalType, isResourceType, isBreakType = DungeonModel.instance:getChapterListTypes()

	self._showNormal = isNormalType

	if self._showNormal then
		local list = DungeonConfig.instance:getChapterCOListByType(chapterType)

		self:refreshChaperIndexDict(list)
		self:clear()

		local sectionPreviewStatus = {}

		for i, v in ipairs(list) do
			if DungeonMainStoryModel.instance:isPreviewChapter(v.id) then
				local sectionId = DungeonConfig.instance:getChapterDivideSectionId(v.id)

				if sectionId then
					sectionPreviewStatus[sectionId] = v.id
				else
					logError("DungeonChapterListModel:setFbList #1 sectionId is nil, chapterId = ", v.id)
				end
			end
		end

		local firstChapterFinish = DungeonModel.instance:chapterIsPass(DungeonEnum.ChapterId.Main1_1)
		local firstSectionId = DungeonConfig.instance:getChapterDivideSectionId(DungeonEnum.ChapterId.Main1_1)
		local result = {}
		local sectionStatus = {}

		for i, v in ipairs(list) do
			local sectionId = DungeonConfig.instance:getChapterDivideSectionId(v.id)

			if not sectionId then
				logError("DungeonChapterListModel:setFbList #2 sectionId is nil, chapterId = ", v.id)
			end

			if sectionId and (sectionId == firstSectionId or firstChapterFinish) and (not sectionStatus[sectionId] or sectionPreviewStatus[sectionId]) then
				if not DungeonModel.instance:isSpecialMainPlot(v.id) then
					sectionStatus[sectionId] = DungeonModel.instance:chapterIsLock(v.id)
				end

				table.insert(result, v)

				if sectionPreviewStatus[sectionId] == v.id then
					sectionPreviewStatus[sectionId] = nil
				end
			end
		end

		list = result

		if VersionValidator.instance:isInReviewing() then
			local tmpList = {}
			local allChapterIds = ResSplitConfig.instance:getAllChapterIds()

			for i, v in ipairs(list) do
				if allChapterIds[v.id] then
					table.insert(tmpList, v)
				end
			end

			list = tmpList
		end

		self:setList(list)
		DungeonMainStoryModel.instance:setChapterList(list)
	else
		self._chapterList = {}

		if isResourceType then
			if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.GoldDungeon) then
				local list = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Gold)

				tabletool.addValues(self._chapterList, list)
			end

			if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.ExperienceDungeon) then
				local list = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Exp)

				tabletool.addValues(self._chapterList, list)
			end

			if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.EquipDungeon) then
				local config = DungeonConfig.instance:getChapterCO(DungeonEnum.EquipDungeonChapterId)

				table.insert(self._chapterList, config)
			end

			if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Buildings) then
				local list = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Buildings)

				tabletool.addValues(self._chapterList, list)
			end
		elseif isBreakType then
			self._chapterList = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Break)
		end

		table.sort(self._chapterList, DungeonChapterListModel._sortChapterList)
	end
end

function DungeonChapterListModel.getChapterListByType(isNormalType, isResourceType, isBreakType, chapterType)
	if isNormalType and chapterType then
		return (DungeonConfig.instance:getChapterCOListByType(chapterType))
	else
		local chapterList = {}

		if isResourceType then
			if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.GoldDungeon) then
				local list = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Gold)

				tabletool.addValues(chapterList, list)
			end

			if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.ExperienceDungeon) then
				local list = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Exp)

				tabletool.addValues(chapterList, list)
			end

			if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.EquipDungeon) then
				local config = DungeonConfig.instance:getChapterCO(DungeonEnum.EquipDungeonChapterId)

				table.insert(chapterList, config)
			end

			if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Buildings) then
				local list = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Buildings)

				tabletool.addValues(chapterList, list)
			end
		elseif isBreakType then
			chapterList = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Break)
		end

		table.sort(chapterList, DungeonChapterListModel._sortChapterList)

		return chapterList
	end
end

function DungeonChapterListModel._getCount(chapterCfg)
	local maxCount = DungeonConfig.instance:getDungeonEveryDayCount(chapterCfg.type)
	local curCount = DungeonModel.instance:getChapterTypeNum(chapterCfg.type)

	return maxCount - curCount, maxCount
end

function DungeonChapterListModel._getAdditionSortIdx(chapterCfg)
	if DungeonModel.instance:chapterListIsResType(chapterCfg.type) then
		if DoubleDropModel.instance:isShowDoubleByChapter(chapterCfg.id, true) then
			return 1
		end

		local isMultiDrop, limit, total, magnification = Activity217Model.instance:getShowTripleByChapter(chapterCfg.id)

		if isMultiDrop and limit > 0 then
			return 1
		end

		if TurnbackModel.instance:isShowTurnBackAddition(chapterCfg.id) then
			return 1
		end
	end

	return 0
end

function DungeonChapterListModel._sortChapterList(a, b)
	local countA, maxCountA = DungeonChapterListModel._getCount(a)
	local countB, maxCountB = DungeonChapterListModel._getCount(b)
	local freeA = math.max(0, countA)
	local freeB = math.max(0, countB)

	if freeA ~= freeB then
		return freeB < freeA
	end

	local valueA = DungeonModel.instance:getChapterOpenTimeValid(a)
	local valueB = DungeonModel.instance:getChapterOpenTimeValid(b)

	if valueA == valueB and valueA then
		local aAdditionIdx = DungeonChapterListModel._getAdditionSortIdx(a)
		local bAdditionIdx = DungeonChapterListModel._getAdditionSortIdx(b)

		if aAdditionIdx ~= bAdditionIdx then
			return bAdditionIdx < aAdditionIdx
		end
	end

	if countA ~= countB then
		return countB < countA
	end

	if maxCountA ~= maxCountB then
		return maxCountA < maxCountB
	end

	if valueA == valueB then
		return a.id < b.id
	end

	if valueA then
		return true
	end

	return false
end

function DungeonChapterListModel:getFbList()
	if self._showNormal then
		return self:getList()
	else
		return self._chapterList
	end
end

function DungeonChapterListModel:getChapterList(chapterId)
	local chapterConfig = DungeonConfig.instance:getChapterCO(chapterId)

	if chapterConfig.type == DungeonEnum.ChapterType.Break then
		return self._chapterList
	elseif chapterConfig.type == DungeonEnum.ChapterType.Equip then
		return (DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Equip))
	end

	return {}
end

function DungeonChapterListModel:getOpenTimeValidEquipChapterId(chapterId)
	if chapterId then
		local chapterConfig = DungeonConfig.instance:getChapterCO(chapterId)

		if chapterConfig.type ~= DungeonEnum.ChapterType.Equip then
			return chapterId
		end

		if DungeonModel.instance:getChapterOpenTimeValid(chapterConfig) then
			return chapterId
		end
	end

	local list = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Equip)

	for i, v in ipairs(list) do
		if DungeonModel.instance:getChapterOpenTimeValid(v) then
			return v.id
		end
	end

	return chapterId
end

function DungeonChapterListModel:getSelectedMO()
	local chapterType = DungeonModel.instance.curChapterType
	local list = DungeonConfig.instance:getChapterCOListByType(chapterType)

	for i, v in ipairs(list) do
		if v.id == DungeonModel.instance.curLookChapterId then
			return v
		end
	end
end

function DungeonChapterListModel:getInfoList(scrollGO)
	self._mixCellInfo = {}

	local list = self:getList()

	for i, mo in ipairs(list) do
		local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(i, (DungeonModel.instance:isSpecialMainPlot(mo.id) or nil) and DungeonEnum.ChapterWidth.Special, i)

		table.insert(self._mixCellInfo, mixCellInfo)
	end

	return self._mixCellInfo
end

function DungeonChapterListModel:getMixCellPos(chapterId)
	local width = 0

	for i, v in ipairs(self:getList()) do
		if v.id == chapterId then
			return width
		end

		width = width + self._mixCellInfo[i].lineLength
	end

	return width
end

function DungeonChapterListModel:getLastUnlockChapterId()
	local id

	for i, v in ipairs(self:getList()) do
		if DungeonModel.instance:chapterIsUnLock(v.id) then
			id = v.id
		end
	end

	return id
end

function DungeonChapterListModel:refreshChaperIndexDict(list)
	self.chapter2Index = {}

	if list then
		local index = 0

		for i, v in ipairs(list) do
			if not DungeonModel.instance:isSpecialMainPlot(v.id) then
				index = index + 1
				self.chapter2Index[v.id] = index
			end
		end
	end
end

function DungeonChapterListModel:getChapterIndex(chapterId)
	if not chapterId then
		return
	end

	return self.chapter2Index and self.chapter2Index[chapterId]
end

DungeonChapterListModel.instance = DungeonChapterListModel.New()

return DungeonChapterListModel
