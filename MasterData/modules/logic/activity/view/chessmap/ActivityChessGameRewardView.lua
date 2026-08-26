-- chunkname: @modules/logic/activity/view/chessmap/ActivityChessGameRewardView.lua

module("modules.logic.activity.view.chessmap.ActivityChessGameRewardView", package.seeall)

local ActivityChessGameRewardView = class("ActivityChessGameRewardView", BaseView)

function ActivityChessGameRewardView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg2")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#simage_icon")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._txtrewardnamecn = gohelper.findChildText(self.viewGO, "inforoot/#txt_rewardnamecn")
	self._txtrewardnameen = gohelper.findChildText(self.viewGO, "inforoot/#txt_rewardnamecn/#txt_rewardnameen")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityChessGameRewardView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function ActivityChessGameRewardView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function ActivityChessGameRewardView:_editableInitView()
	self._simagebg1:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))
end

function ActivityChessGameRewardView:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._simageicon:UnLoadImage()
end

function ActivityChessGameRewardView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.ChessGame.PickUpItem)

	local interactCo = self.viewParam.config

	if not string.nilorempty(interactCo.showParam) then
		self._simageicon:LoadImage(ResUrl.getVersionactivitychessIcon(interactCo.showParam))
	end

	self._txtrewardnamecn.text = interactCo.name
	self._txtrewardnameen.text = interactCo.name_en or ""
end

function ActivityChessGameRewardView:onClose()
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.RewardIsClose)
end

function ActivityChessGameRewardView:_btncloseOnClick()
	self:closeThis()
end

return ActivityChessGameRewardView
