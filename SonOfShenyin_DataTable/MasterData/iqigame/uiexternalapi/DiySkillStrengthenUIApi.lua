-- chunkname: @IQIGame\\UIExternalApi\\DiySkillStrengthenUIApi.lua

DiySkillStrengthenUIApi = BaseLangApi:Extend()

function DiySkillStrengthenUIApi:GetPreviewAddLevelText(level)
	return "+" .. level
end

function DiySkillStrengthenUIApi:GetPreviewMaterialAddExpText(exp)
	return "+" .. exp
end

function DiySkillStrengthenUIApi:GetStrengthenCostMoneyText(costMoney, ownerMoney)
	return costMoney
end

function DiySkillStrengthenUIApi:GetUpgradeCostMoneyText(costMoney, ownerMoney, isEnough)
	return costMoney
end

function DiySkillStrengthenUIApi:GetStrengthenNotEnoughText(isEnoughItem, isEnoughMoney)
	return self:GetCfgText(130001)
end

function DiySkillStrengthenUIApi:GetSkillRefineLevelImg(purifyLv)
	return UIGlobalApi.ImagePath .. "/DataResource/UIResource/DiyCommonImg/DiyCommonImg_RefineImg_0" .. tostring(purifyLv) .. ".png"
end

function DiySkillStrengthenUIApi:GetSkillRefineName()
	return self:GetCfgText(130002)
end

function DiySkillStrengthenUIApi:GetSkillRefineNumber(number)
	if number == 1 then
		return self:GetCfgText(1)
	elseif number == 2 then
		return self:GetCfgText(2)
	elseif number == 3 then
		return self:GetCfgText(3)
	elseif number == 4 then
		return self:GetCfgText(4)
	elseif number == 5 then
		return self:GetCfgText(5)
	end

	return self:GetCfgText(11)
end

function DiySkillStrengthenUIApi:GetRefinePresentTitle()
	return self:GetCfgText(130003)
end

function DiySkillStrengthenUIApi:GetRefineEmptyContent()
	return self:GetCfgText(130004)
end

function DiySkillStrengthenUIApi:GetRefineNextTitle()
	return self:GetCfgText(130005)
end

function DiySkillStrengthenUIApi:GetRefineMaxText()
	return self:GetCfgText(130006)
end

function DiySkillStrengthenUIApi:GetRefineButtonText()
	return self:GetCfgText(130007)
end

function DiySkillStrengthenUIApi:GetBasePropertyTitle()
	return self:GetCfgText(130008)
end

function DiySkillStrengthenUIApi:GetRefineEffectTitle()
	return self:GetCfgText(130008)
end

function DiySkillStrengthenUIApi:GetIntensityButtonText()
	return self:GetCfgText(6000006)
end

function DiySkillStrengthenUIApi:GetEquipBtnText(isEmpty)
	return isEmpty and self:GetCfgText(2000003) or self:GetCfgText(6000034)
end

function DiySkillStrengthenUIApi:GetDischargeBtnText()
	return self:GetCfgText(130010)
end

function DiySkillStrengthenUIApi:GetWareStateText(roleName)
	return roleName .. self:GetCfgText(6000016)
end

function DiySkillStrengthenUIApi:GetStrengthenSortingData()
	return {
		self:GetCfgText(1000002),
		self:GetCfgText(1000001),
		self:GetCfgText(130203)
	}
end

function DiySkillStrengthenUIApi:GetTextRefineLevel(level)
	return string.format(self:GetCfgText(130204), level)
end

function DiySkillStrengthenUIApi:GetTextMax()
	return "·MAX"
end

function DiySkillStrengthenUIApi:GetTextNext()
	return self:GetCfgText(130201)
end

function DiySkillStrengthenUIApi:GetRefineNext()
	return self:GetCfgText(130202)
end

function DiySkillStrengthenUIApi:GetTextRefine()
	return self:GetCfgText(130202)
end

function DiySkillStrengthenUIApi:GetTextEquipIsLock()
	return self:GetCfgText(6000046)
end

function DiySkillStrengthenUIApi:GetTextLevelUp(lv)
	return string.format(self:GetCfgText(6000047), lv)
end

function DiySkillStrengthenUIApi:GetAttrGrowUpTitle(type)
	if type == Constant.Attribute.TYPE_EXTRA_LIFE then
		return self:GetCfgText(130207)
	elseif type == Constant.Attribute.TYPE_EXTRA_ATTACK then
		return self:GetCfgText(130205)
	elseif type == Constant.Attribute.TYPE_EXTRA_DEFENSE then
		return self:GetCfgText(130206)
	end

	return "未知属性"
end
