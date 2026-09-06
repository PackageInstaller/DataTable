-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/facade/LoginFacade.lua

module("logic.extensions.login.facade.LoginFacade", package.seeall)

local LoginFacade = class("LoginFacade", BaseFacade)

function LoginFacade:getAccount()
	return LoginModel.instance.accont
end

function LoginFacade:isMainUserId(userId)
	return LoginModel.instance.userId == userId
end

function LoginFacade:isMainUserId36(userId)
	return LoginModel.instance.userId36 == userId
end

function LoginFacade:isSceneLoaded()
	return LoginModel.instance.isSceneLoaded
end

LoginFacade.instance = LoginFacade.New()

return LoginFacade
