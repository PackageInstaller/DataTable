-- chunkname: @modules/logic/signin/model/SignInMonthCardHistoryMo.lua

module("modules.logic.signin.model.SignInMonthCardHistoryMo", package.seeall)

local SignInMonthCardHistoryMo = pureTable("SignInMonthCardHistoryMo")

function SignInMonthCardHistoryMo:ctor()
	self.id = 0
	self.startTime = 0
	self.endTime = 0
end

function SignInMonthCardHistoryMo:init(info)
	self.id = info.id
	self.startTime = info.startTime
	self.endTime = info.endTime
end

return SignInMonthCardHistoryMo
