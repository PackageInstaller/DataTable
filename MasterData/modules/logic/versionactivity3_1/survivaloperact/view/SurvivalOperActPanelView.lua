-- chunkname: @modules/logic/versionactivity3_1/survivaloperact/view/SurvivalOperActPanelView.lua

module("modules.logic.versionactivity3_1.survivaloperact.view.SurvivalOperActPanelView", package.seeall)

local SurvivalOperActPanelView = class("SurvivalOperActPanelView", Activity101SignViewBase)

function SurvivalOperActPanelView:onInitView()
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_PanelBG")
	self._simageRightPanelBG = gohelper.findChildSingleImage(self.viewGO, "Root/Right/#simage_RightPanelBG")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Right/#btn_reward")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Right/#btn_Enter")
	self._goreddot = gohelper.findChild(self.viewGO, "Root/Right/#btn_Enter/#go_reddot")
	self._simageLeftPanelBG = gohelper.findChildSingleImage(self.viewGO, "Root/Left/#simage_LeftPanelBG")
	self._simageRole = gohelper.findChildSingleImage(self.viewGO, "Root/Left/#simage_Role")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/Left/image_LimitTimeBG/#txt_LimitTime")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/Left/#simage_Title")
	self._goicon = gohelper.findChild(self.viewGO, "Root/Left/Reward/image_dec")
	self._gocanget = gohelper.findChild(self.viewGO, "Root/Left/Reward/go_canget")
	self._btnClaim = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Left/Reward/go_canget/#btn_Claim")
	self._goreceive = gohelper.findChild(self.viewGO, "Root/Left/Reward/go_receive")
	self._gohasget = gohelper.findChild(self.viewGO, "Root/Left/Reward/go_receive/go_hasget")
	self._goItem = gohelper.findChild(self.viewGO, "Root/Left/Scroll View/Viewport/Content/#go_Item")
	self._txtItem = gohelper.findChildText(self.viewGO, "Root/Left/Scroll View/Viewport/Content/#go_Item/#txt_Item")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SurvivalOperActPanelView:addEvents()
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self._btnClaim:AddClickListener(self._btnClaimOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function SurvivalOperActPanelView:removeEvents()
	self._btnreward:RemoveClickListener()
	self._btnEnter:RemoveClickListener()
	self._btnClaim:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function SurvivalOperActPanelView:_btnrewardOnClick()
	local itemId = CommonConfig.instance:getConstNum(ConstEnum.SurvivalOperActItem)

	MaterialTipController.instance:showMaterialInfo(1, itemId)
end

function SurvivalOperActPanelView:_btnEnterOnClick()
	GameFacade.jump(JumpEnum.JumpView.SurvivalHandbook)
end

function SurvivalOperActPanelView:_btnClaimOnClick()
	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(self._actId, 1)

	if not couldGet then
		return
	end

	self._anim:Play("open", 0, 0)
	TaskDispatcher.runDelay(self._startGetReward, self, 1)
end

function SurvivalOperActPanelView:_startGetReward()
	gohelper.setActive(self._gocanget, false)
	gohelper.setActive(self._goreceive, true)
	Activity101Rpc.instance:sendGet101BonusRequest(self._actId, 1, self._refreshUI, self)
end

function SurvivalOperActPanelView:_btnCloseOnClick()
	self:closeThis()
end

function SurvivalOperActPanelView:_editableInitView()
	self._txtLimitTime.text = ""
end

function SurvivalOperActPanelView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_1.SurvivalOperAct.play_ui_diqiu_jinru)

	self._actId = VersionActivity3_1Enum.ActivityId.SurvivalOperAct
	self._anim = self._gohasget:GetComponent(typeof(UnityEngine.Animator))

	self:_refreshUI()
	self:_clearTimeTick()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
	TaskDispatcher.runRepeat(self._playClick, self, 1)
end

function SurvivalOperActPanelView:_playClick()
	return
end

function SurvivalOperActPanelView:onClose()
	return
end

function SurvivalOperActPanelView:onDestroyView()
	TaskDispatcher.cancelTask(self._startGetReward, self)
	TaskDispatcher.cancelTask(self._playClick, self)
	self:_clearTimeTick()
end

function SurvivalOperActPanelView:_clearTimeTick()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function SurvivalOperActPanelView:_refreshUI()
	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(self._actId, 1)

	gohelper.setActive(self._gocanget, couldGet)
	gohelper.setActive(self._goreceive, not couldGet)
	gohelper.setActive(self._goicon, couldGet)
end

function SurvivalOperActPanelView:_refreshTimeTick()
	self._txtLimitTime.text = self:getRemainTimeStr()
end

return SurvivalOperActPanelView
