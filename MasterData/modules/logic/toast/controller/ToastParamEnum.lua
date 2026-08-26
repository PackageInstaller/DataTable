-- chunkname: @modules/logic/toast/controller/ToastParamEnum.lua

module("modules.logic.toast.controller.ToastParamEnum", package.seeall)

local ToastParamEnum = _M

ToastParamEnum.LifeTime = {
	[ToastEnum.PartyGameLobbyJoinTip] = 2,
	[ToastEnum.PartyGameLobbyInviteTip] = 11
}
ToastParamEnum.ToastHeight = {
	[ToastEnum.PartyGameLobbyInviteTip] = 325
}
ToastParamEnum.FixedToast = {
	[ToastEnum.PartyGameLobbyInviteTip] = true
}
ToastParamEnum.ClearToastHandler = {
	[ToastEnum.PartyGameLobbyInviteTip] = PartyGameLobbyController.clearInviteTip
}

return ToastParamEnum
