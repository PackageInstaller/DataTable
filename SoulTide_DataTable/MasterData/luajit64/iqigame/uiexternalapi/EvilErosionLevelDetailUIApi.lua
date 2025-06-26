-- chunkname: @IQIGame\\UIExternalApi\\EvilErosionLevelDetailUIApi.lua

EvilErosionLevelDetailUIApi = BaseLangApi:Extend()

function EvilErosionLevelDetailUIApi:Init()
	self:RegisterApi("MonsterPanelLabel", self.GetMonsterPanelLabel)
	self:RegisterApi("RewardLabelText", self.GetRewardLabelText)
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("ChangeSoulBtnText", self.GetChangeSoulBtnText)
	self:RegisterApi("EnterLevelBtnText", self.GetEnterLevelBtnText)
	self:RegisterApi("SoulInfoView_LevelText", self.GetSoulInfoView_LevelText)
	self:RegisterApi("FormationCell_EquipTagPath", self.GetFormationCell_EquipTagPath)
	self:RegisterApi("SoulInfoView_NoSoulViewText", self.GetSoulInfoView_NoSoulViewText)
	self:RegisterApi("SoulInfoView_PositionToggleText", self.GetSoulInfoView_PositionToggleText)
	self:RegisterApi("SoulInfoView_SkillCell_Lv", self.GetSoulInfoView_SkillCell_Lv)
	self:RegisterApi("SoulInfoView_SuitTipText", self.GetSoulInfoView_SuitTipText)
end

function EvilErosionLevelDetailUIApi:GetMonsterPanelLabel()
	return self:GetCfgText(1213136)
end

function EvilErosionLevelDetailUIApi:GetRewardLabelText()
	return self:GetCfgText(1213137)
end

function EvilErosionLevelDetailUIApi:GetTitleText()
	return self:GetCfgText(1213138)
end

function EvilErosionLevelDetailUIApi:GetChangeSoulBtnText()
	return self:GetCfgText(1213139)
end

function EvilErosionLevelDetailUIApi:GetEnterLevelBtnText()
	return self:GetCfgText(1213140)
end

function EvilErosionLevelDetailUIApi:GetSoulInfoView_LevelText(level)
	return "Lv." .. "\n<size=24>" .. self.TextColor[45] .. level .. self.TextColor[0] .. "</size>"
end

function EvilErosionLevelDetailUIApi:GetFormationCell_EquipTagPath(quality)
	if quality == nil then
		return "Assets/05_Images/Common/ComImage/FormationUI_00.png"
	end

	if quality == 1 then
		return "Assets/05_Images/Common/ComImage/FormationUI_01.png"
	elseif quality == 2 then
		return "Assets/05_Images/Common/ComImage/FormationUI_02.png"
	elseif quality == 3 then
		return "Assets/05_Images/Common/ComImage/FormationUI_03.png"
	elseif quality == 4 then
		return "Assets/05_Images/Common/ComImage/FormationUI_04.png"
	elseif quality == 5 then
		return "Assets/05_Images/Common/ComImage/FormationUI_05.png"
	end
end

function EvilErosionLevelDetailUIApi:GetSoulInfoView_NoSoulViewText()
	return ""
end

function EvilErosionLevelDetailUIApi:GetSoulInfoView_PositionToggleText()
	return self:GetCfgText(1214061), self:GetCfgText(1214063)
end

function EvilErosionLevelDetailUIApi:GetSoulInfoView_SkillCell_Lv(lv, isMax)
	if lv == 0 then
		return ""
	end

	if isMax then
		lv = self.TextColor[29] .. "+" .. lv .. self.TextColor[0]
	else
		lv = "+" .. lv
	end

	return lv
end

function EvilErosionLevelDetailUIApi:GetSoulInfoView_SuitTipText(isSuitActive, quality)
	if isSuitActive then
		local color = UIGlobalApi.GetColorStrByQuality(quality)

		if quality == 1 then
			return "<color=" .. color .. ">" .. self:GetCfgText(1214304) .. "</color>"
		elseif quality == 2 then
			return "<color=" .. color .. ">" .. self:GetCfgText(1214304) .. "</color>"
		elseif quality == 3 then
			return "<color=" .. color .. ">" .. self:GetCfgText(1214304) .. "</color>"
		elseif quality == 4 then
			return "<color=" .. color .. ">" .. self:GetCfgText(1214304) .. "</color>"
		elseif quality == 5 then
			return "<color=" .. color .. ">" .. self:GetCfgText(1214304) .. "</color>"
		end

		return "品质错误：" .. quality
	else
		return ""
	end
end

EvilErosionLevelDetailUIApi:Init()
