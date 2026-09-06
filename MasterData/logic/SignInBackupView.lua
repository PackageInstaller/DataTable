-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsignin/view/SignInBackupView.lua

module("logic.extensions.operationsignin.view.SignInBackupView", package.seeall)

local SignInBackupView = class("SignInBackupView", OperationSignInView)

function SignInBackupView:_getShowRaceId()
	return 10333
end

function SignInBackupView:_getEffectPath()
	return "20211028/1105_qiandao/fx_ui_qiandao_1105.prefab"
end

function SignInBackupView:_getYPos()
	return 2.7
end

return SignInBackupView
