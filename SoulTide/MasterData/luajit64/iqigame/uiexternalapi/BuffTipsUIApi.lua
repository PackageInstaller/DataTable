-- chunkname: @IQIGame\\UIExternalApi\\BuffTipsUIApi.lua

BuffTipsUIApi = BaseLangApi:Extend()

function BuffTipsUIApi:Init()
	self:RegisterApi("goBuffLayers", self.GetBuffLayers)
	self:RegisterApi("goTipsTitle", self.GetTipsTitle)
	self:RegisterApi("goDesc", self.GetDesc)
	self:RegisterApi("goEffectDesc", self.GetEffectDesc)
	self:RegisterApi("goEffectDescTitle", self.GetEffectDescTitle)
	self:RegisterApi("goRemoveBuffTitle", self.GetRemoveBuffTitle)
	self:RegisterApi("goRemoveBuffCost", self.GetRemoveBuffCost)
	self:RegisterApi("goBtnClearTxt", self.GetBtnClearTxt)
	self:RegisterApi("clearBuffCost", self.GetClearBuffCost)
end

function BuffTipsUIApi:GetBuffLayers(value)
	return value
end

function BuffTipsUIApi:GetTipsTitle()
	return self:GetCfgText(1318100)
end

function BuffTipsUIApi:GetDesc(desc)
	return self:SkillValueColor(desc, 29)
end

function BuffTipsUIApi:GetEffectDesc(desc)
	return self:SkillValueColor(desc, 29)
end

function BuffTipsUIApi:GetEffectDescTitle()
	return self:GetCfgText(1318101)
end

function BuffTipsUIApi:GetRemoveBuffTitle()
	return self:GetCfgText(1318102)
end

function BuffTipsUIApi:GetRemoveBuffCost(cost, own)
	if own == 0 then
		return self.TextColor[20] .. own .. self.TextColor[0] .. "/" .. cost
	else
		return own .. "/" .. cost
	end
end

function BuffTipsUIApi:GetBtnClearTxt()
	return self:GetCfgText(1318103)
end

function BuffTipsUIApi:GetClearBuffCost()
	return 1
end

BuffTipsUIApi:Init()
