-- chunkname: @IQIGame\\UIExternalApi\\FormationUIApi.lua

FormationUIApi = BaseLangApi:Extend()

function FormationUIApi:GetLockSkillInfo(Lv)
	return self:GetCfgText(2001007, Lv)
end

function FormationUIApi:GetSortTexts(index)
	if index == 1 then
		return self:GetCfgText(1000002)
	elseif index == 2 then
		return self:GetCfgText(1000001)
	end
end

function FormationUIApi:GetReNameViewTitle()
	return self:GetCfgText(140001)
end

function FormationUIApi:GetNameUnserviceableText()
	return self:GetCfgText(140002)
end

function FormationUIApi:GetMonsterTeamIndexText(index)
	local text = {
		"第一波",
		"第二波",
		"第三波"
	}

	return text[index]
end

function FormationUIApi:GetFormationSwitchBtn(selfFormation)
	if selfFormation then
		return "玩家编队"
	else
		return "怪物编队"
	end
end

function FormationUIApi:GetHeroIconDefaultSize()
	return 0.8
end

function FormationUIApi:GetHeroIconDragSize()
	return 1
end
