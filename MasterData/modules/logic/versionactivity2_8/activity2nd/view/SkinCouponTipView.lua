-- chunkname: @modules/logic/versionactivity2_8/activity2nd/view/SkinCouponTipView.lua

module("modules.logic.versionactivity2_8.activity2nd.view.SkinCouponTipView", package.seeall)

local SkinCouponTipView = class("SkinCouponTipView", BaseView)

function SkinCouponTipView:onInitView()
	self._goreward = gohelper.findChild(self.viewGO, "root/#go_reward")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SkinCouponTipView:addEvents()
	self._btnclose:AddClickListener(self.closeThis, self)
end

function SkinCouponTipView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function SkinCouponTipView:_btncloseOnClick()
	return
end

function SkinCouponTipView:_editableInitView()
	return
end

function SkinCouponTipView:onUpdateParam()
	return
end

function SkinCouponTipView:onOpen()
	self._itemMo = self.viewParam and self.viewParam[1]
	self._item = self:getUserDataTb_()
	self._itemcomp = IconMgr.instance:getCommonPropItemIcon(self._goreward)

	if self._itemMo then
		self._itemcomp:setMOValue(self._itemMo.materilType, self._itemMo.materilId, self._itemMo.quantity, nil, true)
		self._itemcomp:isShowCount(false)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards)
end

function SkinCouponTipView:onClose()
	return
end

function SkinCouponTipView:onDestroyView()
	return
end

return SkinCouponTipView
