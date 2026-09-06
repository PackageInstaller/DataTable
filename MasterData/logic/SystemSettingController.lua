-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemsetting/controller/SystemSettingController.lua

module("logic.extensions.systemsetting.controller.SystemSettingController", package.seeall)

local SystemSettingController = class("SystemSettingController", BaseController)

SystemSettingController.BGM_MODE_RAND = 0
SystemSettingController.BGM_MODE_MOBILE = 1
SystemSettingController.BGM_MODE_YEYOU = 2
SystemSettingController.BGM_MODE_YUEJU = 3
SystemSettingController.BGM_MODE_XINGSHI_1 = 4
SystemSettingController.BGM_MODE_XINGSHI_2 = 5

function SystemSettingController:ctor()
	return
end

function SystemSettingController:onInit()
	self:onReset()
end

function SystemSettingController:onReset()
	self._bgmMode = nil

	self:regfirstSettingRed()
end

function SystemSettingController:regfirstSettingRed()
	RedPointController.instance:regUserOnceRedPoint(RedPointModel.ID_First_GameSetViewSharetask)
	RedPointController.instance:regUserOnceRedPoint(RedPointModel.ID_First_GameSetViewFormBond)
end

function SystemSettingController:setBattleBGMMode(mode)
	self._bgmMode = mode

	GameUtil.saveUserData("fight_bgm_mode", mode)
end

function SystemSettingController:getBattleBGMMode()
	if self._bgmMode == nil then
		self._bgmMode = GameUtil.getUserData("fight_bgm_mode")
	end

	return checknumber(self._bgmMode)
end

SystemSettingController.instance = SystemSettingController.New()

return SystemSettingController
