-- chunkname: @modules/logic/versionactivity2_7/v2a7_selfselectsix_1/view/V2a7_SelfSelectSix_PanelView.lua

module("modules.logic.versionactivity2_7.v2a7_selfselectsix_1.view.V2a7_SelfSelectSix_PanelView", package.seeall)

local V2a7_SelfSelectSix_PanelView = class("V2a7_SelfSelectSix_PanelView", BaseView)

function V2a7_SelfSelectSix_PanelView:onInitView()
	self._goClaim = gohelper.findChild(self.viewGO, "root/simage_panelbg/reward/#btn_Claim")
	self._gohasget = gohelper.findChild(self.viewGO, "root/simage_panelbg/reward/#go_hasget")
	self._btnClaim = gohelper.findChildButtonWithAudio(self.viewGO, "root/simage_panelbg/reward/#btn_Claim")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Close")
	self._btnemptyTop = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_emptyTop")
	self._btnemptyBottom = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_emptyBottom")
	self._btnemptyLeft = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_emptyLeft")
	self._btnemptyRight = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_emptyRight")
	self._btnGo = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Go")
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/simage_panelbg/#txt_desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a7_SelfSelectSix_PanelView:addEvents()
	self._btnClaim:AddClickListener(self._btnClaimOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnemptyTop:AddClickListener(self._btnemptyTopOnClick, self)
	self._btnemptyBottom:AddClickListener(self._btnemptyBottomOnClick, self)
	self._btnemptyLeft:AddClickListener(self._btnemptyLeftOnClick, self)
	self._btnemptyRight:AddClickListener(self._btnemptyRightOnClick, self)
	self._btnGo:AddClickListener(self._btnGoOnClick, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self.refreshUI, self)
end

function V2a7_SelfSelectSix_PanelView:removeEvents()
	self._btnClaim:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnemptyTop:RemoveClickListener()
	self._btnemptyBottom:RemoveClickListener()
	self._btnemptyLeft:RemoveClickListener()
	self._btnemptyRight:RemoveClickListener()
	self._btnGo:RemoveClickListener()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self.refreshUI, self)
end

function V2a7_SelfSelectSix_PanelView:_btnClaimOnClick()
	if not self:checkReceied() and self:checkCanGet() then
		Activity101Rpc.instance:sendGet101BonusRequest(self._actId, 1)
	end
end

function V2a7_SelfSelectSix_PanelView:_btnCloseOnClick()
	self:closeThis()
end

function V2a7_SelfSelectSix_PanelView:_btnemptyTopOnClick()
	self:closeThis()
end

function V2a7_SelfSelectSix_PanelView:_btnemptyBottomOnClick()
	self:closeThis()
end

function V2a7_SelfSelectSix_PanelView:_btnemptyLeftOnClick()
	self:closeThis()
end

function V2a7_SelfSelectSix_PanelView:_btnemptyRightOnClick()
	self:closeThis()
end

function V2a7_SelfSelectSix_PanelView:_btnGoOnClick()
	self:closeThis()

	local actMo = ActivityModel.instance:getActMO(self._actId)

	if actMo and actMo.centerId then
		ActivityModel.instance:setTargetActivityCategoryId(self._actId)

		local isActivity = actMo.centerId == ActivityEnum.ActivityType.Beginner

		if isActivity then
			ActivityController.instance:openActivityBeginnerView()
		else
			ActivityController.instance:openActivityWelfareView()
		end
	end
end

function V2a7_SelfSelectSix_PanelView:_editableInitView()
	return
end

function V2a7_SelfSelectSix_PanelView:onUpdateParam()
	return
end

function V2a7_SelfSelectSix_PanelView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_day_night)

	self._actId = self.viewParam.actId
	self._actCo = ActivityConfig.instance:getActivityCo(self._actId)
	self._txtdesc.text = self._actCo.actDesc
end

function V2a7_SelfSelectSix_PanelView:refreshUI()
	local received = self:checkReceied()
	local canget = self:checkCanGet()

	gohelper.setActive(self._goClaim, not received and canget)
	gohelper.setActive(self._gohasget, received)
end

function V2a7_SelfSelectSix_PanelView:checkReceied()
	return (ActivityType101Model.instance:isType101RewardGet(self._actId, 1))
end

function V2a7_SelfSelectSix_PanelView:checkCanGet()
	return (ActivityType101Model.instance:isType101RewardCouldGet(self._actId, 1))
end

function V2a7_SelfSelectSix_PanelView:onClose()
	return
end

function V2a7_SelfSelectSix_PanelView:onDestroyView()
	return
end

return V2a7_SelfSelectSix_PanelView
