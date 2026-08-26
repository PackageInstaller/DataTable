-- chunkname: @modules/logic/signin/controller/SignInEvent.lua

module("modules.logic.signin.controller.SignInEvent", package.seeall)

local SignInEvent = {}

SignInEvent.GetSignInInfo = 1
SignInEvent.GetSignInReply = 2
SignInEvent.GetSignInAddUp = 3
SignInEvent.GetHistorySignInSuccess = 4
SignInEvent.OnSignInTotalRewardReply = 5
SignInEvent.OnReceiveSignInTotalRewardAllReply = 6
SignInEvent.OnReceiveSupplementMonthCardReply = 7
SignInEvent.ClickSignInMonthItem = 2002
SignInEvent.SignInItemClick = 2003
SignInEvent.SwitchBirthdayState = 3001
SignInEvent.GetHeroBirthday = 3002
SignInEvent.CloseSignInView = 4001
SignInEvent.CloseSignInDetailView = 4002
SignInEvent.OnSignInPopupFlowUpdate = 5001
SignInEvent.OnSignInPopupFlowFinish = 5002

return SignInEvent
