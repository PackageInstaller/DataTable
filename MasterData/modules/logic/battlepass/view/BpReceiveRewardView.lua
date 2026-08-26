-- chunkname: @modules/logic/battlepass/view/BpReceiveRewardView.lua

module("modules.logic.battlepass.view.BpReceiveRewardView", package.seeall)

local BpReceiveRewardView = class("BpReceiveRewardView", BaseView)

function BpReceiveRewardView:onInitView()
	self.btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "mask")
	self.rewardicon = gohelper.findChildSingleImage(self.viewGO, "rewardicon")
	self.imgreward = gohelper.findChildImage(self.viewGO, "rewardicon")
	self.reward = gohelper.findChild(self.viewGO, "reward")
	self.txt = gohelper.findChildTextMesh(self.viewGO, "txt")
	self.txt_num = gohelper.findChildTextMesh(self.viewGO, "#txt_num")
end

function BpReceiveRewardView:addEvents()
	self.addClickCb(self, self.btnClose, self.closeThis, self)
end

function BpReceiveRewardView:onOpen()
	local cfg = BpModel.instance:getCurBpUpdatePopupCfg()

	if cfg then
		self.txt.text = cfg.txt

		local bonus = string.splitToNumber(cfg.showItem, "#")
		local config, icon = ItemModel.instance:getItemConfigAndIcon(bonus[1], bonus[2])

		self.rewardicon:LoadImage(icon, self.onImageLoaded, self)

		self.txt_num.text = luaLang("multiple") .. bonus[3]
	end

	AudioMgr.instance:trigger(AudioEnum3_4.BP.FaceView_play_ui_fuleyuan_nuodika_win)
end

function BpReceiveRewardView:onClose()
	return
end

function BpReceiveRewardView:onDestroyView()
	if self.rewardicon then
		self.rewardicon:UnLoadImage()

		self.rewardicon = nil
	end
end

function BpReceiveRewardView:onImageLoaded()
	self.imgreward:SetNativeSize()
end

return BpReceiveRewardView
