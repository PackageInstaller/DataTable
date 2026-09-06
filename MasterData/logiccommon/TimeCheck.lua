-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/timeCheck/TimeCheck.lua

module("logiccommon.common.timeCheck.TimeCheck", package.seeall)

local TimeCheck = class("TimeCheck")

TimeCheck.startTime = 0
TimeCheck.endTime = 0

function TimeCheck:ctor()
	return
end

function TimeCheck:recordStartTime()
	self.startTime = os.clock()
end

function TimeCheck:printCostTime(content)
	self.endTime = os.clock()

	printInfo(string.format("%s  total time:%.2fms\n", content, (self.endTime - self.startTime) * 1000))
end

TimeCheck.instance = TimeCheck.New()

return TimeCheck
