-- chunkname: @modules/logic/versionactivity3_9/bducklinkage/view/V3a9_BDuckLinkagePatFaceView.lua

module("modules.logic.versionactivity3_9.bducklinkage.view.V3a9_BDuckLinkagePatFaceView", package.seeall)

local V3a9_BDuckLinkagePatFaceView = class("V3a9_BDuckLinkagePatFaceView", V3a9_BDuckLinkageBaseView)

function V3a9_BDuckLinkagePatFaceView:_editableInitView()
	V3a9_BDuckLinkagePatFaceView.super._editableInitView(self)

	self._btngoto = gohelper.findChildButtonWithAudio(self.viewGO, "root/Btn/#btn_goto")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
end

function V3a9_BDuckLinkagePatFaceView:addEvents()
	V3a9_BDuckLinkagePatFaceView.super.addEvents(self)
	self._btngoto:AddClickListener(self._btngotoOnClick, self)
	self._btnclose:AddClickListener(self.closeThis, self)
end

function V3a9_BDuckLinkagePatFaceView:checkParam()
	self.signActId = self.viewParam and self.viewParam.actId or ActivityEnum.Activity.V3a9_BDuckLinkage

	if self.signActId then
		local activityConfig = ActivityConfig.instance:getActivityCo(self.signActId)
		local chargeConfig = StoreConfig.instance:getChargeGoodsConfig(tonumber(activityConfig.param))

		self._chargeGoodsRewardList = GameUtil.splitString2(chargeConfig.product, true)
		self.chargeConfig = chargeConfig
	end
end

function V3a9_BDuckLinkagePatFaceView:removeEvents()
	V3a9_BDuckLinkagePatFaceView.super.removeEvents(self)
	self._btngoto:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function V3a9_BDuckLinkagePatFaceView:_btngotoOnClick()
	ViewMgr.instance:openView(ViewName.StoreDecorateCombinationView, {
		canJump = true,
		goodsId = self.chargeConfig.id
	})
end

function V3a9_BDuckLinkagePatFaceView:onOpen()
	V3a9_BDuckLinkagePatFaceView.super.onOpen(self)
	AudioMgr.instance:trigger(AudioEnum3_9.BDuck.play_ui_chongran3_9_bduck_bp)
	self:refreshPrice()
end

function V3a9_BDuckLinkagePatFaceView:onClose()
	V3a9_BDuckLinkagePatFaceView.super.onClose(self)
	self._animator:Play("close", 0, 0)
end

function V3a9_BDuckLinkagePatFaceView:refreshPrice()
	V3a9_BDuckLinkagePatFaceView.super.refreshPrice(self)

	local storeGoodsMo = StoreModel.instance:getGoodsMO(self.chargeConfig.id)
	local isSoldOut = storeGoodsMo and storeGoodsMo:isSoldOut()

	gohelper.setActive(self._goowened, isSoldOut)
	gohelper.setActive(self._btngoto, not isSoldOut)
end

return V3a9_BDuckLinkagePatFaceView
