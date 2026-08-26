-- chunkname: @modules/logic/signin/config/SignInEnum.lua

module("modules.logic.signin.config.SignInEnum", package.seeall)

local SignInEnum = _M
local kResPathRoot_LifeCircle = "ui/viewres/lifecircle/"

SignInEnum.ResPath = {
	lifecirclesignview = kResPathRoot_LifeCircle .. "lifecirclesignview.prefab",
	lifecirclesignrewardsitem = kResPathRoot_LifeCircle .. "lifecirclesignrewardsitem.prefab"
}

return SignInEnum
