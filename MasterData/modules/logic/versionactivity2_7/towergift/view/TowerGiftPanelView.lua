-- chunkname: @modules/logic/versionactivity2_7/towergift/view/TowerGiftPanelView.lua

module("modules.logic.versionactivity2_7.towergift.view.TowerGiftPanelView", package.seeall)

local TowerGiftPanelView = class("TowerGiftPanelView", BaseView)

function TowerGiftPanelView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._btncheck = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_check")
	self._goClaim = gohelper.findChild(self.viewGO, "root/reward1/go_canget/#btn_Claim")
	self._goreceive = gohelper.findChild(self.viewGO, "root/reward1/go_receive")
	self._btn1Claim = gohelper.findChildButtonWithAudio(self.viewGO, "root/reward1/go_canget/#btn_Claim")
	self._btngoto = gohelper.findChildButtonWithAudio(self.viewGO, "root/reward2/go_goto/#btn_goto")
	self._btnicon = gohelper.findChildButtonWithAudio(self.viewGO, "root/reward2/icon/click")
	self._goreceive2 = gohelper.findChild(self.viewGO, "root/reward2/go_receive")
	self._gogoto = gohelper.findChild(self.viewGO, "root/reward2/go_goto")
	self._golock = gohelper.findChild(self.viewGO, "root/reward2/go_lock")
	self._txttime = gohelper.findChildText(self.viewGO, "root/simage_fullbg/#txt_time")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerGiftPanelView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btncheck:AddClickListener(self._btncheckOnClick, self)
	self._btn1Claim:AddClickListener(self._btn1ClaimOnClick, self)
	self._btngoto:AddClickListener(self._btngotoOnClick, self)
	self._btnicon:AddClickListener(self._btniconOnClick, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self.refreshUI, self)
end

function TowerGiftPanelView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btncheck:RemoveClickListener()
	self._btn1Claim:RemoveClickListener()
	self._btngoto:RemoveClickListener()
	self._btnicon:RemoveClickListener()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self.refreshUI, self)
end

function TowerGiftPanelView:_btncloseOnClick()
	self:closeThis()
end

function TowerGiftPanelView:_btncheckOnClick()
	local param = {
		showType = VersionActivity2_3NewCultivationDetailView.DISPLAY_TYPE.Effect,
		heroId = TowerGiftEnum.ShowHeroList
	}

	ViewMgr.instance:openView(ViewName.VersionActivity2_3NewCultivationDetailView, param)
end

function TowerGiftPanelView:_btn1ClaimOnClick()
	if not self:checkReceied() and self:checkCanGet() then
		Activity101Rpc.instance:sendGet101BonusRequest(self._actId, 1)
	end
end

function TowerGiftPanelView:_btngotoOnClick()
	self:closeThis()
	ActivityModel.instance:setTargetActivityCategoryId(ActivityEnum.Activity.V2a7_TowerGift)
	ActivityController.instance:openActivityBeginnerView()
end

function TowerGiftPanelView:_btniconOnClick()
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Item, TowerGiftEnum.StoneUpTicketId)
end

function TowerGiftPanelView:checkReceied()
	return (ActivityType101Model.instance:isType101RewardGet(self._actId, 1))
end

function TowerGiftPanelView:checkCanGet()
	return (ActivityType101Model.instance:isType101RewardCouldGet(self._actId, 1))
end

function TowerGiftPanelView:_editableInitView()
	return
end

function TowerGiftPanelView:onUpdateParam()
	return
end

function TowerGiftPanelView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)

	self._actId = self.viewParam.actId

	self:refreshUI()
end

function TowerGiftPanelView:refreshUI()
	local received = self:checkReceied()
	local canget = self:checkCanGet()

	gohelper.setActive(self._goClaim, canget)
	gohelper.setActive(self._goreceive, received)

	self._txttime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)

	local actRewardTaskMO = TowerTaskModel.instance:getActRewardTask()
	local hasget = actRewardTaskMO and actRewardTaskMO:isClaimed() or false

	gohelper.setActive(self._goreceive2, hasget)
	gohelper.setActive(self._gogoto, true)
	gohelper.setActive(self._golock, false)
end

function TowerGiftPanelView:onClose()
	return
end

function TowerGiftPanelView:onDestroyView()
	return
end

return TowerGiftPanelView
