-- chunkname: @modules/logic/survival/view/map/SurvivalLoadingView.lua

module("modules.logic.survival.view.map.SurvivalLoadingView", package.seeall)

local SurvivalLoadingView = class("SurvivalLoadingView", BaseView)

function SurvivalLoadingView:onInitView()
	self.image_wuerlixi = gohelper.findChildImage(self.viewGO, "ani/image_wuerlixi")
end

function SurvivalLoadingView:onOpen()
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_loading)
	TaskDispatcher.runDelay(self.checkViewIsOpenFinish, self, 5)

	local random = math.random(1, 5)
	local path = "survival_stickericon_" .. random

	UISpriteSetMgr.instance:setSurvivalSprite2(self.image_wuerlixi, path)
end

function SurvivalLoadingView:_onOpenView(viewName)
	return
end

function SurvivalLoadingView:checkViewIsOpenFinish()
	logError("雨前漫游 超时关闭打印")
	self:closeThis()
end

function SurvivalLoadingView:onClose()
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.stop_ui_fuleyuan_tansuo_loading)
	TaskDispatcher.cancelTask(self.checkViewIsOpenFinish, self)
end

return SurvivalLoadingView
