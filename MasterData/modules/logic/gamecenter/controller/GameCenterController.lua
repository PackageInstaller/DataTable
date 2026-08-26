-- chunkname: @modules/logic/gamecenter/controller/GameCenterController.lua

module("modules.logic.gamecenter.controller.GameCenterController", package.seeall)

local GameCenterController = class("GameCenterController", BaseController)

function GameCenterController:onInit()
	return
end

function GameCenterController:onInitFinish()
	return
end

function GameCenterController:addConstEvents()
	if BootNativeUtil.isIOS() or GameResMgr.IsFromEditorDir then
		AchievementController.instance:registerCallback(AchievementEvent.UpdateAchievements, self._onUpdateAchievements, self)
		LoginController.instance:registerCallback(LoginEvent.OnSdkLoginReturn, self._onSdkLoginReturn, self)
	end
end

function GameCenterController:reInit()
	self._idCacheDict = nil
end

function GameCenterController:_onUpdateAchievements()
	local cfgList = AchievementConfig.instance:getGameCenterCfgList()

	if not cfgList then
		return
	end

	self._idCacheDict = self._idCacheDict or {}

	local tAchievementModel = AchievementModel.instance

	for _, cfg in ipairs(cfgList) do
		if not self._idCacheDict[cfg.id] and tAchievementModel:isAchievementTaskFinished(cfg.achievementId) then
			self._idCacheDict[cfg.id] = true

			self:updateAchievement(cfg.id, cfg.category)
		end
	end
end

function GameCenterController:_onSdkLoginReturn(success, msg)
	if success and self._lastChannerUserId ~= LoginModel.instance.channelUserId then
		self._lastChannerUserId = LoginModel.instance.channelUserId

		SDKMgr.instance:authenticatePlayer()
	end
end

function GameCenterController:updateAchievement(id, percent)
	local param = {
		id = tostring(id),
		percentComplete = tonumber(percent)
	}
	local jsonStr = cjson.encode(param)

	logNormal("GameCenterController updateAchievement ==> " .. jsonStr)
	SDKMgr.instance:updateAchievement(jsonStr)
end

GameCenterController.instance = GameCenterController.New()

return GameCenterController
