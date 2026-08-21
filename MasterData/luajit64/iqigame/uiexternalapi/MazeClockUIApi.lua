-- chunkname: @IQIGame\\UIExternalApi\\MazeClockUIApi.lua

MazeClockUIApi = BaseLangApi:Extend()

function MazeClockUIApi:Init()
	self:RegisterApi("Constants", self.GetConstants)
	self:RegisterApi("BrickImagePath", self.GetBrickImagePath)
	self:RegisterApi("PointLightDistance", self.GetPointLightDistance)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
	self:RegisterApi("RetryBtnText", self.GetRetryBtnText)
	self:RegisterApi("CloseBtnText", self.GetCloseBtnText)
	self:RegisterApi("StartBtnText", self.GetStartBtnText)
end

function MazeClockUIApi:GetConstants()
	local g = 4
	local radius = 0.15

	return g, radius
end

function MazeClockUIApi:GetBrickImagePath(type, level)
	if type == 1 then
		if level == 1 then
			return self:GetResUrl(1105003)
		elseif level == 2 then
			return self:GetResUrl(1105006)
		elseif level == 3 then
			return self:GetResUrl(1105008)
		end
	elseif type == 2 then
		if level == 1 then
			return self:GetResUrl(1105001)
		elseif level == 2 then
			return self:GetResUrl(1105004)
		elseif level == 3 then
			return self:GetResUrl(1105007)
		end
	elseif type == 3 then
		if level == 1 then
			return self:GetResUrl(1105002)
		elseif level == 2 then
			return self:GetResUrl(1105005)
		elseif level == 3 then
			return self:GetResUrl(1105009)
		end
	end
end

function MazeClockUIApi:GetPointLightDistance(level)
	if level == 1 then
		return 137
	elseif level == 2 then
		return 166
	elseif level == 3 then
		return 192
	elseif level == 0 then
		return 241
	end
end

function MazeClockUIApi:GetConfirmBtnText()
	return self:GetCfgText(2300001)
end

function MazeClockUIApi:GetRetryBtnText()
	return self:GetCfgText(2300002)
end

function MazeClockUIApi:GetCloseBtnText()
	return self:GetCfgText(2300003)
end

function MazeClockUIApi:GetStartBtnText()
	return self:GetCfgText(2300004)
end

MazeClockUIApi:Init()
