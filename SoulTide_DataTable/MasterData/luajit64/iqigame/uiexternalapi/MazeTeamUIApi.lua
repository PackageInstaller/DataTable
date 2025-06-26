-- chunkname: @IQIGame\\UIExternalApi\\MazeTeamUIApi.lua

MazeTeamUIApi = BaseLangApi:Extend()

function MazeTeamUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("LvLabelText", self.GetLvLabelText)
	self:RegisterApi("DeadLabelText", self.GetDeadLabelText)
	self:RegisterApi("ExploreAttrIcon", self.GetExploreAttrIcon)
	self:RegisterApi("AttrTabBtnText", self.GetAttrTabBtnText)
	self:RegisterApi("SkillEquipTabBtnText", self.GetSkillEquipTabBtnText)
end

function MazeTeamUIApi:GetTitleText()
	return self:GetCfgText(2300066)
end

function MazeTeamUIApi:GetLvLabelText()
	return self:GetCfgText(2300068)
end

function MazeTeamUIApi:GetDeadLabelText()
	return self:GetCfgText(2300067)
end

function MazeTeamUIApi:GetExploreAttrIcon(attrId)
	if attrId < 10 then
		if attrId == 1 then
			return self:GetResUrl(1103001)
		elseif attrId == 2 then
			return self:GetResUrl(1103002)
		elseif attrId == 3 then
			return self:GetResUrl(1103003)
		elseif attrId == 4 then
			return self:GetResUrl(1103006)
		elseif attrId == 5 then
			return self:GetResUrl(1103004)
		elseif attrId == 6 then
			return self:GetResUrl(1103005)
		end
	else
		return self:GetResUrl(1105003)
	end
end

function MazeTeamUIApi:GetAttrTabBtnText()
	return self:GetCfgText(1314340)
end

function MazeTeamUIApi:GetSkillEquipTabBtnText()
	return self:GetCfgText(2300069)
end

MazeTeamUIApi:Init()
