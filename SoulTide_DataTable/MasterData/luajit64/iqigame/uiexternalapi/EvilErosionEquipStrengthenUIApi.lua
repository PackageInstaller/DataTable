-- chunkname: @IQIGame\\UIExternalApi\\EvilErosionEquipStrengthenUIApi.lua

EvilErosionEquipStrengthenUIApi = BaseLangApi:Extend()

function EvilErosionEquipStrengthenUIApi:Init()
	self:RegisterApi("CostItemNumText", self.GetCostItemNumText)
	self:RegisterApi("CostItemNumText2", self.GetCostItemNumText2)
	self:RegisterApi("CostLabel", self.GetCostLabel)
	self:RegisterApi("CostLabel2", self.GetCostLabel2)
	self:RegisterApi("PreviewAttrUpRateLabel", self.GetPreviewAttrUpRateLabel)
	self:RegisterApi("AttrUpRateLabel", self.GetAttrUpRateLabel)
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
	self:RegisterApi("CancelBtnText", self.GetCancelBtnText)
	self:RegisterApi("NoHigherStarLvViewText", self.GetNoHigherStarLvViewText)
	self:RegisterApi("TipText", self.GetTipText)
end

function EvilErosionEquipStrengthenUIApi:GetCostItemNumText(hasNum, needNum)
	if hasNum < needNum then
		hasNum = self.TextColor[44] .. hasNum .. self.TextColor[0]
	else
		hasNum = self.TextColor[45] .. hasNum .. self.TextColor[0]
	end

	return string.format("x%s/%s", hasNum, needNum)
end

function EvilErosionEquipStrengthenUIApi:GetCostItemNumText2(hasNum, needNum)
	if hasNum < needNum then
		hasNum = self.TextColor[44] .. hasNum .. self.TextColor[0]
	else
		hasNum = self.TextColor[45] .. hasNum .. self.TextColor[0]
	end

	return string.format("x%s/%s", hasNum, needNum)
end

function EvilErosionEquipStrengthenUIApi:GetCostLabel()
	return self:GetCfgText(1213129)
end

function EvilErosionEquipStrengthenUIApi:GetCostLabel2()
	return self:GetCfgText(1213129)
end

function EvilErosionEquipStrengthenUIApi:GetPreviewAttrUpRateLabel()
	return ""
end

function EvilErosionEquipStrengthenUIApi:GetAttrUpRateLabel()
	return ""
end

function EvilErosionEquipStrengthenUIApi:GetTitleText()
	return self:GetCfgText(1213130)
end

function EvilErosionEquipStrengthenUIApi:GetConfirmBtnText()
	return self:GetCfgText(1213130)
end

function EvilErosionEquipStrengthenUIApi:GetCancelBtnText()
	return self:GetCfgText(1213131)
end

function EvilErosionEquipStrengthenUIApi:GetNoHigherStarLvViewText()
	return self:GetCfgText(1213132)
end

function EvilErosionEquipStrengthenUIApi:GetTipText()
	return self:GetCfgText(1213133)
end

EvilErosionEquipStrengthenUIApi:Init()
