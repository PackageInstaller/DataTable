-- chunkname: @IQIGame\\UIExternalApi\\EndlessMazeRuneRemakeUIApi.lua

EndlessMazeRuneRemakeUIApi = BaseLangApi:Extend()

function EndlessMazeRuneRemakeUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("FilterBtnText", self.GetFilterBtnText)
	self:RegisterApi("RemakeBtnText", self.GetRemakeBtnText)
	self:RegisterApi("RuneNumText", self.GetRuneNumText)
	self:RegisterApi("CostItemNumText", self.GetCostItemNumText)
	self:RegisterApi("RemakeCountText", self.GetRemakeCountText)
	self:RegisterApi("TipText", self.GetTipText)
	self:RegisterApi("RuneSuitLabel", self.GetRuneSuitLabel)
end

function EndlessMazeRuneRemakeUIApi:GetTitleText()
	return self:GetCfgText(2200200)
end

function EndlessMazeRuneRemakeUIApi:GetFilterBtnText()
	return self:GetCfgText(2000004)
end

function EndlessMazeRuneRemakeUIApi:GetRemakeBtnText()
	return self:GetCfgText(2200200)
end

function EndlessMazeRuneRemakeUIApi:GetRuneNumText(filteredNum, originalNum, isFilterMode)
	if isFilterMode then
		return self:GetCfgText(2200043) .. filteredNum .. "/" .. originalNum
	else
		return self:GetCfgText(2200043) .. originalNum
	end
end

function EndlessMazeRuneRemakeUIApi:GetCostItemNumText(count, hasCount)
	if count <= hasCount then
		return "<color=#40d4ff>" .. count .. " </color> " .. "/" .. hasCount
	else
		return "<color=#e33533>" .. count .. "</color> " .. "/" .. hasCount
	end
end

function EndlessMazeRuneRemakeUIApi:GetRemakeCountText(count)
	if count > 0 then
		return self:GetCfgText(2200201) .. "：" .. count
	else
		return self:GetCfgText(2200201) .. "：" .. " <color=#e33533>" .. count .. "</color>"
	end
end

function EndlessMazeRuneRemakeUIApi:GetTipText()
	return "※" .. self:GetCfgText(2200202)
end

function EndlessMazeRuneRemakeUIApi:GetRuneSuitLabel()
	return self:GetCfgText(2200061)
end

EndlessMazeRuneRemakeUIApi:Init()
