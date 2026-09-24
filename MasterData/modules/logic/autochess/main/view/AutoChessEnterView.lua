-- chunkname: @modules/logic/autochess/main/view/AutoChessEnterView.lua

module("modules.logic.autochess.main.view.AutoChessEnterView", package.seeall)

local AutoChessEnterView = class("AutoChessEnterView", VersionActivityEnterBaseSubView)

function AutoChessEnterView:onInitView()
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "#txt_LeftTime")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Enter")
	self._btnAchievement = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Achievement")
	self._goWarningContent = gohelper.findChild(self.viewGO, "simage_car/#go_WarningContent")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessEnterView:addEvents()
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self._btnAchievement:AddClickListener(self._btnAchievementOnClick, self)
end

function AutoChessEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnAchievement:RemoveClickListener()
end

function AutoChessEnterView:_btnEnterOnClick()
	AutoChessController.instance:enterMainView(self.actId)
end

function AutoChessEnterView:_btnAchievementOnClick()
	local jumpId = self.config.achievementJumpId

	JumpController.instance:jump(jumpId)
end

function AutoChessEnterView:_editableInitView()
	self.actId = self.viewContainer.activityId
	self.config = ActivityConfig.instance:getActivityCo(self.actId)
end

function AutoChessEnterView:everySecondCall()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

return AutoChessEnterView
