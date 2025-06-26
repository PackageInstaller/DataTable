-- chunkname: @IQIGame\\UIExternalApi\\MazeTroopSpChangeUIApi.lua

MazeTroopSpChangeUIApi = BaseLangApi:Extend()

function MazeTroopSpChangeUIApi:Init()
	self:RegisterApi("LabelText", self.GetLabelText)
	self:RegisterApi("ValueText", self.GetValueText)
end

function MazeTroopSpChangeUIApi:GetLabelText(isAdd)
	if isAdd then
		return self:GetCfgText(2300066) .. self.TextColor[101] .. self:GetCfgText(1210018) .. "+" .. self.TextColor[0]
	else
		return self:GetCfgText(2300066) .. self.TextColor[105] .. self:GetCfgText(1210018) .. "-" .. self.TextColor[0]
	end
end

function MazeTroopSpChangeUIApi:GetValueText(percentage)
	if percentage > 0 then
		return self.TextColor[101] .. percentage .. "%" .. self.TextColor[0]
	else
		return self.TextColor[105] .. -percentage .. "%" .. self.TextColor[0]
	end
end

MazeTroopSpChangeUIApi:Init()
