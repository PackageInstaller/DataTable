-- chunkname: @modules/logic/versionactivity3_1/survivaloperact/view/SurvivalOperActFullView.lua

module("modules.logic.versionactivity3_1.survivaloperact.view.SurvivalOperActFullView", package.seeall)

local SurvivalOperActFullView = class("SurvivalOperActFullView", Activity101SignViewBase)

function SurvivalOperActFullView:onInitView()
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

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SurvivalOperActFullView:addEvents()
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self._btnClaim:AddClickListener(self._btnClaimOnClick, self)
end

function SurvivalOperActFullView:removeEvents()
	self._btnreward:RemoveClickListener()
	self._btnEnter:RemoveClickListener()
	self._btnClaim:RemoveClickListener()
end

function SurvivalOperActFullView:_btnrewardOnClick()
	local itemId = CommonConfig.instance:getConstNum(ConstEnum.SurvivalOperActItem)

	MaterialTipController.instance:showMaterialInfo(1, itemId)
end

function SurvivalOperActFullView:_btnEnterOnClick()
	GameFacade.jump(JumpEnum.JumpView.SurvivalHandbook)
end

function SurvivalOperActFullView:_btnClaimOnClick()
	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(self._actId, 1)

	if not couldGet then
		return
	end

	self._anim:Play("open", 0, 0)
	TaskDispatcher.runDelay(self._startGetReward, self, 1)
end

function SurvivalOperActFullView:_startGetReward()
	gohelper.setActive(self._gocanget, false)
	gohelper.setActive(self._goreceive, true)
	Activity101Rpc.instance:sendGet101BonusRequest(self._actId, 1, self._refreshUI, self)
end

function SurvivalOperActFullView:_editableInitView()
	self._txtLimitTime.text = ""
end

function SurvivalOperActFullView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)
	AudioMgr.instance:trigger(AudioEnum3_1.SurvivalOperAct.play_ui_diqiu_jinru)

	self._actId = VersionActivity3_1Enum.ActivityId.SurvivalOperAct
	self._anim = self._gohasget:GetComponent(typeof(UnityEngine.Animator))

	self:_refreshUI()
	self:_clearTimeTick()
	Activity101Rpc.instance:sendGet101InfosRequest(self._actId, self._refreshUI, self)
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
end

function SurvivalOperActFullView:_clearTimeTick()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function SurvivalOperActFullView:_refreshUI()
	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(self._actId, 1)

	gohelper.setActive(self._gocanget, couldGet)
	gohelper.setActive(self._goreceive, not couldGet)
	gohelper.setActive(self._goicon, couldGet)
end

function SurvivalOperActFullView:_refreshTimeTick()
	self._txtLimitTime.text = self:getRemainTimeStr()
end

function SurvivalOperActFullView:onClose()
	TaskDispatcher.cancelTask(self._startGetReward, self)
	self:_clearTimeTick()
end

function SurvivalOperActFullView:onDestroyView()
	return
end

return SurvivalOperActFullView
