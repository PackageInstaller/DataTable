-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/controller/MissionController.lua

module("logic.extensions.mission.controller.MissionController", package.seeall)

local MissionController = class("MissionController")

function MissionController:ctor()
	return
end

function MissionController:onInit()
	return
end

function MissionController:onReset()
	return
end

function MissionController:getFmtEvaluate(score)
	score = checknumber(score)

	local curPower = MissionModel.instance:getLeftPower()
	local rightPower = checknumber(MissionModel.instance:getRightPower())

	rightPower = rightPower > 0 and rightPower or 1

	local calculateScore = score * curPower / (500 * rightPower) * 100

	printInfo("test 分数转化 score, curPower, rightPower, calculateScore", score, curPower, rightPower, calculateScore)

	if calculateScore > 300 then
		calculateScore = 300
	end

	if calculateScore >= 100 then
		return "S", 0, calculateScore
	elseif calculateScore >= 80 then
		return "A", 1, calculateScore
	elseif calculateScore >= 60 then
		return "B", 2, calculateScore
	elseif calculateScore >= 40 then
		return "C", 3, calculateScore
	else
		return "D", 4, calculateScore
	end
end

MissionController.instance = MissionController.New()

return MissionController
