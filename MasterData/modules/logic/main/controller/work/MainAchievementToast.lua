-- chunkname: @modules/logic/main/controller/work/MainAchievementToast.lua

module("modules.logic.main.controller.work.MainAchievementToast", package.seeall)

local MainAchievementToast = class("MainAchievementToast", BaseWork)

function MainAchievementToast:onStart(context)
	AchievementToastController.instance:dispatchEvent(AchievementEvent.LoginShowToast)
	self:onDone(true)
end

function MainAchievementToast:clearWork()
	return
end

return MainAchievementToast
