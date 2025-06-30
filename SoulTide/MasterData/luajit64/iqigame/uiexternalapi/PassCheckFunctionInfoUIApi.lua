-- chunkname: @IQIGame\\UIExternalApi\\PassCheckFunctionInfoUIApi.lua

PassCheckFunctionInfoUIApi = BaseLangApi:Extend()

function PassCheckFunctionInfoUIApi:Init()
	self:RegisterApi("title", self.GetTitle)
	self:RegisterApi("desc", self.GetDesc)
	self:RegisterApi("ruleDesc", self.GetRuleDesc)
end

function PassCheckFunctionInfoUIApi:GetTitle()
	return self:GetCfgText(3501200)
end

function PassCheckFunctionInfoUIApi:GetRuleDesc(desc)
	return desc
end

function PassCheckFunctionInfoUIApi:GetDesc()
	return self:GetCfgText(3501201)
end

PassCheckFunctionInfoUIApi:Init()
