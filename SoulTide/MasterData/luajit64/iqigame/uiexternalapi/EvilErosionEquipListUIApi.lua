-- chunkname: @IQIGame\\UIExternalApi\\EvilErosionEquipListUIApi.lua

EvilErosionEquipListUIApi = BaseLangApi:Extend()

function EvilErosionEquipListUIApi:Init()
	self:RegisterApi("HasItemText", self.GetHasItemText)
	self:RegisterApi("HasItemLabel", self.GetHasItemLabel)
	self:RegisterApi("EnhanceTipText", self.GetEnhanceTipText)
	self:RegisterApi("DecomposeGetItemText", self.GetDecomposeGetItemText)
	self:RegisterApi("DecomposeGetItemLabel", self.GetDecomposeGetItemLabel)
	self:RegisterApi("DecomposeTipText", self.GetDecomposeTipText)
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("DecomposeToggleText", self.GetDecomposeToggleText)
	self:RegisterApi("EnhanceToggleText", self.GetEnhanceToggleText)
	self:RegisterApi("BatchDecomposeBtnText", self.GetBatchDecomposeBtnText)
	self:RegisterApi("OptimizeSortToggleText", self.GetOptimizeSortToggleText)
	self:RegisterApi("EquipCard_CanEnhanceTagText", self.GetEquipCard_CanEnhanceTagText)
	self:RegisterApi("EquipCard_CurIndexEquipTagText", self.GetEquipCard_CurIndexEquipTagText)
	self:RegisterApi("EquipCard_BeWearingTagText", self.GetEquipCard_BeWearingTagText)
	self:RegisterApi("EquipCard_EquipUniqueMarkText", self.GetEquipCard_EquipUniqueMarkText)
end

function EvilErosionEquipListUIApi:GetHasItemText(num)
	return "x" .. num
end

function EvilErosionEquipListUIApi:GetHasItemLabel()
	return self:GetCfgText(1213114)
end

function EvilErosionEquipListUIApi:GetEnhanceTipText()
	return ""
end

function EvilErosionEquipListUIApi:GetDecomposeGetItemText(num)
	return "x" .. num
end

function EvilErosionEquipListUIApi:GetDecomposeGetItemLabel()
	return self:GetCfgText(1213115)
end

function EvilErosionEquipListUIApi:GetDecomposeTipText()
	return self:GetCfgText(1213116)
end

function EvilErosionEquipListUIApi:GetTitleText()
	return self:GetCfgText(1213117)
end

function EvilErosionEquipListUIApi:GetDecomposeToggleText()
	return self:GetCfgText(1213118), self:GetCfgText(1213119)
end

function EvilErosionEquipListUIApi:GetEnhanceToggleText()
	return self:GetCfgText(1213118), self:GetCfgText(1213120)
end

function EvilErosionEquipListUIApi:GetBatchDecomposeBtnText()
	return self:GetCfgText(1213119)
end

function EvilErosionEquipListUIApi:GetOptimizeSortToggleText()
	return self:GetCfgText(1213121)
end

function EvilErosionEquipListUIApi:GetEquipCard_CanEnhanceTagText()
	return self:GetCfgText(1213122)
end

function EvilErosionEquipListUIApi:GetEquipCard_CurIndexEquipTagText()
	return self:GetCfgText(1213123)
end

function EvilErosionEquipListUIApi:GetEquipCard_BeWearingTagText()
	return self:GetCfgText(1213124)
end

function EvilErosionEquipListUIApi:GetEquipCard_EquipUniqueMarkText()
	return self:GetCfgText(1213125)
end

EvilErosionEquipListUIApi:Init()
