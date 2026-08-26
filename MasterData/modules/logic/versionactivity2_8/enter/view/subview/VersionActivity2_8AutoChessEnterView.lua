-- chunkname: @modules/logic/versionactivity2_8/enter/view/subview/VersionActivity2_8AutoChessEnterView.lua

module("modules.logic.versionactivity2_8.enter.view.subview.VersionActivity2_8AutoChessEnterView", package.seeall)

local VersionActivity2_8AutoChessEnterView = class("VersionActivity2_8AutoChessEnterView", BaseView)

function VersionActivity2_8AutoChessEnterView:onInitView()
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "LimitTime/#txt_LimitTime")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Enter")
	self._btnAchievement = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Achievement")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_8AutoChessEnterView:addEvents()
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self._btnAchievement:AddClickListener(self._btnAchievementOnClick, self)
end

function VersionActivity2_8AutoChessEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnAchievement:RemoveClickListener()
end

function VersionActivity2_8AutoChessEnterView:_btnEnterOnClick()
	local actMo = Activity182Model.instance:getActMo()

	if not actMo then
		return
	end

	AutoChessController.instance:openMainView()
end

function VersionActivity2_8AutoChessEnterView:_btnAchievementOnClick()
	local jumpId = self.config.achievementJumpId

	JumpController.instance:jump(jumpId)
end

function VersionActivity2_8AutoChessEnterView:_editableInitView()
	self.actId = self.viewContainer.activityId
	self.config = ActivityConfig.instance:getActivityCo(self.actId)
	self.animComp = VersionActivity2_5SubAnimatorComp.get(self.viewGO, self)
end

function VersionActivity2_8AutoChessEnterView:onOpen()
	self.animComp:playOpenAnim()
	self:_showLeftTime()
	TaskDispatcher.runRepeat(self._showLeftTime, self, 1)
	Activity182Rpc.instance:sendGetAct182InfoRequest(self.actId)
end

function VersionActivity2_8AutoChessEnterView:onDestroyView()
	self.animComp:destroy()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
end

function VersionActivity2_8AutoChessEnterView:_showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

return VersionActivity2_8AutoChessEnterView
