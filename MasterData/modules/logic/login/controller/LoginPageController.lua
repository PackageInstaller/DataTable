-- chunkname: @modules/logic/login/controller/LoginPageController.lua

module("modules.logic.login.controller.LoginPageController", package.seeall)

local LoginPageController = class("LoginPageController", BaseController)

function LoginPageController:resetPageCfg()
	self._curPageCfg = nil
end

function LoginPageController:getCurPageCfg()
	self._curPageCfg = self._curPageCfg or self:_getResetPageCfg()

	return self._curPageCfg
end

function LoginPageController:isShowLoginVideo()
	local pageCfg = self:getCurPageCfg()

	if pageCfg and not string.nilorempty(pageCfg.video) then
		return true
	end

	return false
end

function LoginPageController:_getResetPageCfg()
	local pid = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GameLoginViewPageSettingKey, 0)
	local cfg = LoginConfig.instance:getPageCfgById(pid)

	if cfg and (cfg.episodeId == 0 or self:isPassDungeonById(cfg.episodeId)) then
		return cfg
	end

	local pCoList = {}
	local list = LoginConfig.instance:getPageCfgList()

	for _, co in ipairs(list) do
		if co.episodeId == 0 or self:isPassDungeonById(co.episodeId) then
			table.insert(pCoList, co)
		end
	end

	local var_4_0 = pCoList[(pid == SettingsEnum.LoginPageType.Random or nil) and math.random(1, #pCoList)]

	return (not pCoList[(pid == SettingsEnum.LoginPageType.Random or nil) and math.random(1, #pCoList)] or nil) and list[1]
end

function LoginPageController:isPassDungeonById(episodeId)
	return LoginController.instance:isPassDungeonById(episodeId)
end

LoginPageController.instance = LoginPageController.New()

return LoginPageController
