-- chunkname: @modules/logic/versionactivity1_3/armpipe/view/ArmRewardView.lua

module("modules.logic.versionactivity1_3.armpipe.view.ArmRewardView", package.seeall)

local ArmRewardView = class("ArmRewardView", BaseView)

function ArmRewardView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._simageclosebtn = gohelper.findChildSingleImage(self.viewGO, "#btn_Close")
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_PanelBG")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Root/Title/#txt_Title")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "Root/#scroll_TaskList")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArmRewardView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function ArmRewardView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function ArmRewardView:_btnCloseOnClick()
	self:closeThis()
end

function ArmRewardView:_editableInitView()
	self._simageclosebtn:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_igfullmask"))
	self._simagePanelBG:LoadImage(ResUrl.getV1a3ArmSinglebg("v1a3_arm_reward_pop_bg"))
end

function ArmRewardView:onUpdateParam()
	return
end

function ArmRewardView:onOpen()
	self.addEventCb(self, Activity124Controller.instance, ArmPuzzlePipeEvent.RefreshMapData, self.refreshUI, self)
	self.addEventCb(self, Activity124Controller.instance, ArmPuzzlePipeEvent.RefreshReceiveReward, self.refreshUI, self)
	self:refreshUI()
end

function ArmRewardView:onClose()
	return
end

function ArmRewardView:onDestroyView()
	self._simageclosebtn:UnLoadImage()
	self._simagePanelBG:UnLoadImage()
end

function ArmRewardView:refreshUI()
	Activity124RewardListModel.instance:init(VersionActivity1_3Enum.ActivityId.Act305)
end

return ArmRewardView
