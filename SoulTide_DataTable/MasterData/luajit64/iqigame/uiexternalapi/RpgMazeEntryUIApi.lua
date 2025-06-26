-- chunkname: @IQIGame\\UIExternalApi\\RpgMazeEntryUIApi.lua

RpgMazeEntryUIApi = BaseLangApi:Extend()
RpgMazeEntryUIApi.CellBgPaths = nil
RpgMazeEntryUIApi.CellOrderPaths = nil

function RpgMazeEntryUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("ProgressText", self.GetProgressText)
	self:RegisterApi("RpgMazeUnlockTimeText", self.GetRpgMazeUnlockTimeText)
	self:RegisterApi("MazeCellBackground", self.GetMazeCellBackground)
	self:RegisterApi("MazeOrderImage", self.GetMazeOrderImage)
	self:RegisterApi("ShopBtnText", self.GetShopBtnText)
end

function RpgMazeEntryUIApi:GetTitleText(openCount)
	if openCount == 3 then
		return self:GetCfgText(2000060)
	elseif openCount == 4 then
		return self:GetCfgText(2000080)
	elseif openCount == 5 then
		return self:GetCfgText(2000060)
	else
		return self:GetCfgText(3100101)
	end
end

function RpgMazeEntryUIApi:GetProgressText(score)
	return score .. "%"
end

function RpgMazeEntryUIApi:GetRpgMazeUnlockTimeText(openTimeText, closeTimeText, timeState)
	if timeState == 1 then
		return string.format("%s " .. self:GetCfgText(3100102), openTimeText)
	elseif timeState == 3 then
		return string.format("%s " .. self:GetCfgText(3100103), closeTimeText)
	end

	return ""
end

function RpgMazeEntryUIApi:GetMazeCellBackground(isUnlock, openCount)
	local unlockIndex = isUnlock and 1 or 2

	if RpgMazeEntryUIApi.CellBgPaths == nil then
		RpgMazeEntryUIApi.CellBgPaths = {}
		RpgMazeEntryUIApi.CellBgPaths[1] = {
			self:GetResUrl(2900101),
			self:GetResUrl(2900102)
		}
		RpgMazeEntryUIApi.CellBgPaths[2] = {
			self:GetResUrl(2900101),
			self:GetResUrl(2900102)
		}
		RpgMazeEntryUIApi.CellBgPaths[3] = {
			self:GetResUrl(2900110),
			self:GetResUrl(2900110)
		}
		RpgMazeEntryUIApi.CellBgPaths[4] = {
			self:GetResUrl(2900120),
			self:GetResUrl(2900120)
		}
		RpgMazeEntryUIApi.CellBgPaths[5] = {
			self:GetResUrl(2900110),
			self:GetResUrl(2900110)
		}
	end

	return RpgMazeEntryUIApi.CellBgPaths[openCount][unlockIndex]
end

function RpgMazeEntryUIApi:GetMazeOrderImage(order, openCount)
	if RpgMazeEntryUIApi.CellOrderPaths == nil then
		RpgMazeEntryUIApi.CellOrderPaths = {}
		RpgMazeEntryUIApi.CellOrderPaths[1] = {
			self:GetResUrl(2900103),
			self:GetResUrl(2900104),
			self:GetResUrl(2900105),
			self:GetResUrl(2900106),
			self:GetResUrl(2900107),
			self:GetResUrl(2900108),
			self:GetResUrl(2900109)
		}
		RpgMazeEntryUIApi.CellOrderPaths[2] = {
			self:GetResUrl(2900103),
			self:GetResUrl(2900104),
			self:GetResUrl(2900105),
			self:GetResUrl(2900106),
			self:GetResUrl(2900107),
			self:GetResUrl(2900108),
			self:GetResUrl(2900109)
		}
		RpgMazeEntryUIApi.CellOrderPaths[3] = {
			self:GetResUrl(2900111),
			self:GetResUrl(2900112),
			self:GetResUrl(2900113),
			self:GetResUrl(2900114),
			self:GetResUrl(2900115)
		}
		RpgMazeEntryUIApi.CellOrderPaths[4] = {
			self:GetResUrl(2900121),
			self:GetResUrl(2900122),
			self:GetResUrl(2900123),
			self:GetResUrl(2900124),
			self:GetResUrl(2900125)
		}
		RpgMazeEntryUIApi.CellOrderPaths[5] = {
			self:GetResUrl(2900111),
			self:GetResUrl(2900112),
			self:GetResUrl(2900113),
			self:GetResUrl(2900114),
			self:GetResUrl(2900115)
		}
	end

	return RpgMazeEntryUIApi.CellOrderPaths[openCount][order]
end

function RpgMazeEntryUIApi:GetShopBtnText(openCount)
	if openCount == 3 then
		return self:GetCfgText(2000063)
	elseif openCount == 4 then
		return self:GetCfgText(2000076)
	elseif openCount == 5 then
		return self:GetCfgText(2000063)
	else
		return self:GetCfgText(2000021)
	end
end

RpgMazeEntryUIApi:Init()
