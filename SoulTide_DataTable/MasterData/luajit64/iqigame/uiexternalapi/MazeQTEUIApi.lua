-- chunkname: @IQIGame\\UIExternalApi\\MazeQTEUIApi.lua

MazeQTEUIApi = BaseLangApi:Extend()

function MazeQTEUIApi:Init()
	self:RegisterApi("goTitle", self.GetTitle)
	self:RegisterApi("goTitle2", self.GetTitle2)
	self:RegisterApi("goDesc", self.GetDesc)
	self:RegisterApi("goSignNoSort", self.GetSignNoSortTxt)
	self:RegisterApi("goSignSort", self.GetSignSortTxt)
	self:RegisterApi("effectSuccessTime", self.GetEffectSuccessTime)
	self:RegisterApi("effectFailureTime", self.GetEffectFailureTime)
	self:RegisterApi("clickEffectSuccessTime", self.GetClickSuccessEffectTime)
	self:RegisterApi("clickEffectFailureTime", self.GetClickFailureEffectTime)
	self:RegisterApi("countDownTime", self.GetCountDownTime)
	self:RegisterApi("countDownDesc", self.GetCountDownDesc)
	self:RegisterApi("GoDesc", self.GetGoDesc)
	self:RegisterApi("areaSoundId", self.GetAreaSoundId)
end

function MazeQTEUIApi:GetAreaSoundId(index)
	return 10202
end

function MazeQTEUIApi:GetGoDesc()
	return "Go"
end

function MazeQTEUIApi:GetCountDownTime(num)
	return num
end

function MazeQTEUIApi:GetCountDownDesc()
	return self:GetCfgText(2300045)
end

function MazeQTEUIApi:GetTitle2(desc)
	return desc
end

function MazeQTEUIApi:GetClickSuccessEffectTime()
	return 1
end

function MazeQTEUIApi:GetClickFailureEffectTime()
	return 1
end

function MazeQTEUIApi:GetEffectSuccessTime()
	return 3
end

function MazeQTEUIApi:GetEffectFailureTime()
	return 1.5
end

function MazeQTEUIApi:GetSignSortTxt(sort)
	return tostring(sort)
end

function MazeQTEUIApi:GetSignNoSortTxt()
	return self:GetCfgText(2300044)
end

function MazeQTEUIApi:GetTitle(title)
	return title
end

function MazeQTEUIApi:GetDesc(desc)
	return desc
end

MazeQTEUIApi:Init()
