-- chunkname: @IQIGame\\UIExternalApi\\MazeTroopHpChangeUIApi.lua

MazeTroopHpChangeUIApi = BaseLangApi:Extend()

function MazeTroopHpChangeUIApi:Init()
	self:RegisterApi("LabelText", self.GetLabelText)
	self:RegisterApi("ValueText", self.GetValueText)
end

function MazeTroopHpChangeUIApi:GetLabelText(isAdd)
	if isAdd then
		return self:GetCfgText(2300066) .. self.TextColor[101] .. "HP+" .. self.TextColor[0]
	else
		return self:GetCfgText(2300066) .. self.TextColor[105] .. "HP-" .. self.TextColor[0]
	end
end

function MazeTroopHpChangeUIApi:GetValueText(percentage)
	if percentage > 0 then
		return self.TextColor[101] .. percentage .. "%" .. self.TextColor[0]
	else
		return self.TextColor[105] .. -percentage .. "%" .. self.TextColor[0]
	end
end

MazeTroopHpChangeUIApi:Init()
