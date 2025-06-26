-- chunkname: @IQIGame\\UIExternalApi\\GiftChoosePanelUIApi.lua

GiftChoosePanelUIApi = BaseLangApi:Extend()

function GiftChoosePanelUIApi:Init()
	self:RegisterApi("ChooseNumText", self.GetChooseNumText)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
	self:RegisterApi("CellItemNumText", self.GetCellItemNumText)
	self:RegisterApi("CellSelectLabel", self.GetCellSelectLabel)
	self:RegisterApi("UseNumText", self.GetUseNumText)
end

function GiftChoosePanelUIApi:GetChooseNumText(num)
	if num > 0 then
		return string.format(self:GetCfgText(2900303) .. "%s", num)
	else
		return string.format(self:GetCfgText(2900303) .. "%s", num)
	end
end

function GiftChoosePanelUIApi:GetConfirmBtnText()
	return self:GetCfgText(2900300)
end

function GiftChoosePanelUIApi:GetCellItemNumText(num)
	return self.TextColor[31] .. "x" .. num .. self.TextColor[0]
end

function GiftChoosePanelUIApi:GetCellSelectLabel(isSelect)
	if isSelect then
		return self.TextColor[12] .. self:GetCfgText(2900301) .. self.TextColor[0]
	else
		return self:GetCfgText(2900302)
	end
end

function GiftChoosePanelUIApi:GetUseNumText(num, maxNum)
	return string.format(self:GetCfgText(2900304) .. "：%s/%s", num, maxNum)
end

GiftChoosePanelUIApi:Init()
