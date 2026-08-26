-- chunkname: @modules/logic/survival/view/SurvivalEnterView.lua

module("modules.logic.survival.view.SurvivalEnterView", package.seeall)

local SurvivalEnterView = class("SurvivalEnterView", VersionActivityEnterBaseSubView)

function SurvivalEnterView:onInitView()
	self._btnAchievement = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_achievement")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Enter")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_reward")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "#simage_FullBG/image_LimitTimeBG/#txt_LimitTime")
	self._txtDescr = gohelper.findChildTextMesh(self.viewGO, "Right/#txt_Descr")
	self._gored = gohelper.findChild(self.viewGO, "Right/#btn_reward/#go_reddot")
	self.goCanget = gohelper.findChild(self.viewGO, "Right/#btn_reward/#canget")
	self.goNormal = gohelper.findChild(self.viewGO, "Right/#btn_reward/#normal")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SurvivalEnterView:addEvents()
	self._btnEnter:AddClickListener(self._onEnterClick, self)
	self._btnreward:AddClickListener(self._onRewardClick, self)
	self._btnAchievement:AddClickListener(self._btnAchievementOnClick, self)
end

function SurvivalEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnreward:RemoveClickListener()
	self._btnAchievement:RemoveClickListener()
end

function SurvivalEnterView:onOpen()
	SurvivalEnterView.super.onOpen(self)
	RedDotController.instance:addRedDot(self._gored, RedDotEnum.DotNode.V2a8Survival, false, self._refreshRed, self)
end

function SurvivalEnterView:_refreshRed(redDot)
	redDot:defaultRefreshDot()

	local isShow = redDot.show

	gohelper.setActive(self.goCanget, isShow)
	gohelper.setActive(self.goNormal, not isShow)
end

function SurvivalEnterView:_editableInitView()
	local curVersionActivityId = SurvivalModel.instance:getCurVersionActivityId()

	self.config = ActivityConfig.instance:getActivityCo(curVersionActivityId)
	self._txtDescr.text = self.config.actDesc
end

function SurvivalEnterView:_onEnterClick()
	SurvivalStatHelper.instance:statBtnClick("_onEnterClick", "SurvivalEnterView")
	SurvivalController.instance:openSurvivalView(nil)
end

function SurvivalEnterView:_btnAchievementOnClick()
	local jumpId = self.config.achievementJumpId

	JumpController.instance:jump(jumpId)
	SurvivalStatHelper.instance:statBtnClick("_btnAchievementOnClick", "SurvivalEnterView")
end

function SurvivalEnterView:everySecondCall()
	return
end

function SurvivalEnterView:_onRewardClick()
	ViewMgr.instance:openView(ViewName.SurvivalShelterRewardView)
	SurvivalStatHelper.instance:statBtnClick("_onRewardClick", "SurvivalEnterView")
end

return SurvivalEnterView
