-- chunkname: @modules/logic/autochess/main/view/AutoChessEnterView.lua

module("modules.logic.autochess.main.view.AutoChessEnterView", package.seeall)

local AutoChessEnterView = class("AutoChessEnterView", VersionActivityEnterBaseSubView)

function AutoChessEnterView:onInitView()
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "LimitTime/#txt_LimitTime")
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
	local actMo = Activity182Model.instance:getActMo()

	if actMo then
		AutoChessController.instance:openMainView()
	end
end

function AutoChessEnterView:_btnAchievementOnClick()
	local jumpId = self.config.achievementJumpId

	JumpController.instance:jump(jumpId)
end

function AutoChessEnterView:_editableInitView()
	self.actId = self.viewContainer.activityId
	self.config = ActivityConfig.instance:getActivityCo(self.actId)
	self.warningItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._goWarningContent, AutoChessWarningItem)
end

function AutoChessEnterView:onOpen()
	AutoChessEnterView.super.onOpen(self)
	Activity182Rpc.instance:sendGetAct182InfoRequest(self.actId, self.refreshUI, self)
end

function AutoChessEnterView:refreshUI(_, resultCode)
	if resultCode == 0 then
		self.warningItem:refresh(true)
	end
end

function AutoChessEnterView:everySecondCall()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

return AutoChessEnterView
