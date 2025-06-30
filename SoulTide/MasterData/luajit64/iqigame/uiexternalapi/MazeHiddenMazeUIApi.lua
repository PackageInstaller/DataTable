-- chunkname: @IQIGame\\UIExternalApi\\MazeHiddenMazeUIApi.lua

MazeHiddenMazeUIApi = BaseLangApi:Extend()

function MazeHiddenMazeUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("CellNameText", self.GetCellNameText)
	self:RegisterApi("CellSubNameText", self.GetCellSubNameText)
	self:RegisterApi("MazeItemNumText", self.GetMazeItemNumText)
	self:RegisterApi("TipText", self.GetTipText)
	self:RegisterApi("ClaimBtnText", self.GetClaimBtnText)
end

function MazeHiddenMazeUIApi:GetTitleText()
	return self:GetCfgText(1315303)
end

function MazeHiddenMazeUIApi:GetCellNameText(index)
	if index == 1 then
		return self:GetCfgText(1315304)
	elseif index == 2 then
		return self:GetCfgText(1315305)
	elseif index == 3 then
		return self:GetCfgText(1315306)
	elseif index == 4 then
		return self:GetCfgText(1315307)
	end

	return index
end

function MazeHiddenMazeUIApi:GetCellSubNameText()
	return self:GetCfgText(2300021)
end

function MazeHiddenMazeUIApi:GetMazeItemNumText(hasNum, needNum)
	local color

	color = hasNum < needNum and "#e33535" or "green"

	return "<color=" .. color .. ">" .. hasNum .. "</color>/" .. needNum
end

function MazeHiddenMazeUIApi:GetTipText()
	return self:GetCfgText(1315301)
end

function MazeHiddenMazeUIApi:GetClaimBtnText()
	return self:GetCfgText(1315302)
end

MazeHiddenMazeUIApi:Init()
