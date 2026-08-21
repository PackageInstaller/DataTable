-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/facade/LoginFacade.lua

module("logic.extensions.login.facade.LoginFacade", package.seeall)

local LoginFacade = class("LoginFacade", BaseFacade)
local kLoadingViewName = "login"
local kReadConfidentiality = "confidentiality"

function LoginFacade:init()
	ViewMgr.instance:preCreate(kLoadingViewName)
end

function LoginFacade:showLogin()
	if ViewMgr.instance:isOpen(kLoadingViewName) then
		ViewMgr.instance:close(kLoadingViewName)
	end

	ViewMgr.instance:jumpToMainView(kLoadingViewName)
end

function LoginFacade:hideLogin()
	ViewMgr.instance:close(kLoadingViewName)
end

function LoginFacade:checkShowConfidentialityTip()
	if not enableDebug and false then
		local isRead = self:getReadConfidentiality()

		if not isRead then
			ViewMgr.instance:open(ViewName.ConfidentialityTip)

			return true
		end
	end

	return false
end

function LoginFacade:closeConfidentialityTip()
	if ViewMgr.instance:isOpen(ViewName.ConfidentialityTip) then
		ViewMgr.instance:close(ViewName.ConfidentialityTip)
	end
end

function LoginFacade:getReadConfidentiality()
	if not enableDebug then
		local key = kReadConfidentiality .. PlayerModel.instance:getId()

		return Astral.LocalStorage.Instance:GetInt(key, 0) == 1
	end

	return true
end

function LoginFacade:setReadConfidentiality()
	local key = kReadConfidentiality .. PlayerModel.instance:getId()

	Astral.LocalStorage.Instance:SetInt(key, 1)
end

LoginFacade.instance = LoginFacade.New()

return LoginFacade
