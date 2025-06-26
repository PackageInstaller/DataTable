-- chunkname: @IQIGame\\UIExternalApi\\MazeSelectLevelUIApi.lua

MazeSelectLevelUIApi = BaseLangApi:Extend()

function MazeSelectLevelUIApi:Init()
	self:RegisterApi("ChapterNameText", self.GetChapterNameText)
	self:RegisterApi("CompleteLevelNumText", self.GetCompleteLevelNumText)
	self:RegisterApi("MazeInstanceNameText", self.GetMazeInstanceNameText)
	self:RegisterApi("BackgroundColor", self.GetBackgroundColor)
	self:RegisterApi("RewardBoxType", self.GetRewardBoxType)
	self:RegisterApi("MazeInstanceTypeIcon", self.GetMazeInstanceTypeIcon)
	self:RegisterApi("ExploreTargetRewardLabel", self.GetExploreTargetRewardLabel)
	self:RegisterApi("RewardBoxValue", self.GetRewardBoxValue)
	self:RegisterApi("ChapterToggleOrderNameText", self.GetChapterToggleOrderNameText)
	self:RegisterApi("ChapterToggleNameText", self.GetChapterToggleNameText)
	self:RegisterApi("TextComplete", self.GetTextComplete)
end

function MazeSelectLevelUIApi:GetTextComplete(num, totalNum)
	return string.format("%s/%s", num, totalNum)
end

function MazeSelectLevelUIApi:GetChapterNameText(aliasName, name)
	return self:GetCfgText(1019062)
end

function MazeSelectLevelUIApi:GetCompleteLevelNumText(currentNum, totalNum)
	return math.floor(currentNum / totalNum * 100) .. "%"
end

function MazeSelectLevelUIApi:GetMazeInstanceNameText(isHiddenMaze, chapterOrder, order, name, pLv, requireLv)
	if pLv == nil or requireLv <= pLv then
		if isHiddenMaze then
			return name
		else
			if chapterOrder == 1 then
				if order <= 3 then
					return "0-" .. order
				else
					return chapterOrder .. "-" .. order - 3
				end
			elseif chapterOrder == 14 then
				if order == 2 then
					return chapterOrder .. "-" .. order .. self:GetCfgText(2300140)
				end
			elseif chapterOrder == 16 and order <= 4 then
				return chapterOrder .. "-?"
			end

			return chapterOrder .. "-" .. order
		end
	else
		return "<color=#ff5757>Lv." .. requireLv .. "</color>"
	end
end

function MazeSelectLevelUIApi:GetBackgroundColor(isAreaUnlock)
	if isAreaUnlock then
		return "#FFFFFF"
	else
		return "#505050"
	end
end

function MazeSelectLevelUIApi:GetRewardBoxType(index)
	return index
end

function MazeSelectLevelUIApi:GetMazeInstanceTypeIcon(mapCellRes)
	if mapCellRes == 1 then
		return self:GetResUrl(1101001)
	elseif mapCellRes == 2 then
		return self:GetResUrl(1101002)
	elseif mapCellRes == 3 then
		return self:GetResUrl(1101003)
	elseif mapCellRes == 4 then
		return self:GetResUrl(1101004)
	elseif mapCellRes == 5 then
		return self:GetResUrl(1101005)
	end
end

function MazeSelectLevelUIApi:GetExploreTargetRewardLabel()
	return self:GetCfgText(2300101)
end

function MazeSelectLevelUIApi:GetRewardBoxValue(boxTargetNum, maxTargetNum)
	return math.floor(boxTargetNum / maxTargetNum * 100) .. "%"
end

function MazeSelectLevelUIApi:GetChapterToggleOrderNameText(chapterTypeName, alias, order)
	return self:GetCfgText(2300100) .. " - " .. order
end

function MazeSelectLevelUIApi:GetChapterToggleNameText(chapterTypeName, alias, name)
	return name
end

MazeSelectLevelUIApi:Init()
