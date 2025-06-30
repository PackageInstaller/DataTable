-- chunkname: @IQIGame\\UIExternalApi\\MazeChallengeBonusUIApi.lua

MazeChallengeBonusUIApi = BaseLangApi:Extend()

function MazeChallengeBonusUIApi:Init()
	self:RegisterApi("TextMoneyNeed", self.GetTextMoneyNeed)
	self:RegisterApi("TextDefault", self.GetTextDefault)
	self:RegisterApi("TextCanGetReward", self.GetTextCanGetReward)
	self:RegisterApi("TextFinish", self.GetTextFinish)
	self:RegisterApi("TaskItemProgressText", self.GetTaskItemProgressText)
end

function MazeChallengeBonusUIApi:GetTaskItemProgressText(finishNum, targetNum)
	return string.format("(<size=22>%s</size>/%s)", finishNum, targetNum)
end

function MazeChallengeBonusUIApi:GetTextFinish(num, targetNum)
	return string.format("%s/%s", num, targetNum)
end

function MazeChallengeBonusUIApi:GetTextCanGetReward(num, targetNum)
	return string.format("%s/%s", num, targetNum)
end

function MazeChallengeBonusUIApi:GetTextDefault(num, targetNum)
	return string.format("%s/%s", num, targetNum)
end

function MazeChallengeBonusUIApi:GetTextMoneyNeed(num)
	return string.format("x%s", num)
end

MazeChallengeBonusUIApi:Init()
