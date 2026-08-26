-- chunkname: @modules/logic/versionactivity2_5/enter/view/subview/VersionActivity2_5AutoChessEnterView.lua

module("modules.logic.versionactivity2_5.enter.view.subview.VersionActivity2_5AutoChessEnterView", package.seeall)

local VersionActivity2_5AutoChessEnterView = class("VersionActivity2_5AutoChessEnterView", BaseView)

function VersionActivity2_5AutoChessEnterView:onInitView()
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "LimitTime/#txt_LimitTime")
	self._txtDesc = gohelper.findChildText(self.viewGO, "#txt_Desc")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Enter")
	self._btnAchievement = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Achievement")
	self._goTip = gohelper.findChild(self.viewGO, "#go_Tip")
	self._txtTip = gohelper.findChildText(self.viewGO, "#go_Tip/#txt_Tip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_5AutoChessEnterView:addEvents()
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self._btnAchievement:AddClickListener(self._btnAchievementOnClick, self)
end

function VersionActivity2_5AutoChessEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnAchievement:RemoveClickListener()
end

function VersionActivity2_5AutoChessEnterView:_btnEnterOnClick()
	local actMo = Activity182Model.instance:getActMo()

	if not actMo then
		return
	end

	AutoChessController.instance:openMainView()
end

function VersionActivity2_5AutoChessEnterView:_btnAchievementOnClick()
	local jumpId = self.config.achievementJumpId

	JumpController.instance:jump(jumpId)
end

function VersionActivity2_5AutoChessEnterView:_editableInitView()
	self.actId = self.viewContainer.activityId
	self.config = ActivityConfig.instance:getActivityCo(self.actId)
	self.animComp = VersionActivity2_5SubAnimatorComp.get(self.viewGO, self)
end

function VersionActivity2_5AutoChessEnterView:onOpen()
	self.animComp:playOpenAnim()

	self._txtDesc.text = self.config.actDesc

	self:_showLeftTime()
	TaskDispatcher.runRepeat(self._showLeftTime, self, 1)
	Activity182Rpc.instance:sendGetAct182InfoRequest(self.actId)
end

function VersionActivity2_5AutoChessEnterView:onDestroyView()
	self.animComp:destroy()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
end

function VersionActivity2_5AutoChessEnterView:_showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

return VersionActivity2_5AutoChessEnterView
