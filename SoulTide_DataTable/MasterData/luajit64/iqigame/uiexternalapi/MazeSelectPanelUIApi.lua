-- chunkname: @IQIGame\\UIExternalApi\\MazeSelectPanelUIApi.lua

MazeSelectPanelUIApi = BaseLangApi:Extend()

function MazeSelectPanelUIApi:Init()
	self:RegisterApi("BtnText", self.GetBtnSelectTxt)
end

function MazeSelectPanelUIApi:GetBtnSelectTxt(name, selectable, conditionText)
	local text

	if conditionText ~= nil and conditionText ~= "" then
		conditionText = "（" .. conditionText .. "）"
	else
		conditionText = ""
	end

	if not selectable then
		text = name .. conditionText
	else
		text = name .. conditionText
	end

	return text
end

MazeSelectPanelUIApi:Init()
