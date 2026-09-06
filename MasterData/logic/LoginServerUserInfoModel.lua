-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/model/LoginServerUserInfoModel.lua

module("logic.extensions.login.model.LoginServerUserInfoModel", package.seeall)

local LoginServerUserInfoModel = class("LoginServerUserInfoModel", BaseListModel)

function LoginServerUserInfoModel:ctor()
	LoginServerUserInfoModel.super.ctor(self)
end

function LoginServerUserInfoModel:onInit()
	LoginServerUserInfoModel.super.onInit(self)
end

function LoginServerUserInfoModel:onReset()
	LoginServerUserInfoModel.super.onReset(self)
end

LoginServerUserInfoModel.instance = LoginServerUserInfoModel.New()

return LoginServerUserInfoModel
