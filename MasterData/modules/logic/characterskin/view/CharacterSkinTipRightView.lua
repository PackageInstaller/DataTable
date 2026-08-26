-- chunkname: @modules/logic/characterskin/view/CharacterSkinTipRightView.lua

module("modules.logic.characterskin.view.CharacterSkinTipRightView", package.seeall)

local CharacterSkinTipRightView = class("CharacterSkinTipRightView", BaseView)

function CharacterSkinTipRightView:onInitView()
	self._simageskinSwitchBg = gohelper.findChildSingleImage(self.viewGO, "container/#simage_skinSwitchBg")
	self._simageskinicon = gohelper.findChildSingleImage(self.viewGO, "container/skinTip/skinSwitch/skinmask/skinicon")
	self._btnBpPay = gohelper.findChildButtonWithAudio(self.viewGO, "container/skinTip/skinSwitch/#btn_bpPay", AudioEnum.UI.UI_vertical_first_tabs_click)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterSkinTipRightView:addEvents()
	self._btnBpPay:AddClickListener(self._jumpBpCharge, self)
end

function CharacterSkinTipRightView:removeEvents()
	self._btnBpPay:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.OnOpenViewFinish, self)
end

function CharacterSkinTipRightView:refreshRightContainer()
	self.goSkinNormalContainer = gohelper.findChild(self.viewGO, "container/normal")
	self.goSkinTipContainer = gohelper.findChild(self.viewGO, "container/skinTip")
	self.goSkinStoreContainer = gohelper.findChild(self.viewGO, "container/skinStore")

	gohelper.setActive(self.goSkinNormalContainer, false)
	gohelper.setActive(self.goSkinTipContainer, true)
	gohelper.setActive(self.goSkinStoreContainer, false)
end

function CharacterSkinTipRightView:_editableInitView()
	self:refreshRightContainer()
	self._simageskinSwitchBg:LoadImage(ResUrl.getCharacterSkinIcon("img_yulan_bg"))
end

function CharacterSkinTipRightView:initViewParam()
	if LuaUtil.isTable(self.viewParam) then
		local skinId = self.viewParam.skinId

		self.skinCo = SkinConfig.instance:getSkinCo(skinId)

		self.viewContainer:setHomeBtnVisible(self.viewParam.isShowHomeBtn)
	else
		self.skinCo = SkinConfig.instance:getSkinCo(self.viewParam)
	end
end

function CharacterSkinTipRightView:onUpdateParam()
	self:initViewParam()
	self:refreshView()
end

function CharacterSkinTipRightView:onOpen()
	self:initViewParam()
	self:refreshView()
end

function CharacterSkinTipRightView:refreshView()
	self:refreshLeftUI()
	self:refreshRightUI()
end

function CharacterSkinTipRightView:_jumpBpCharge()
	if ViewMgr.instance:isOpen(BpController.instance:getBpChargeView()) then
		self:closeThis()
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self.OnOpenViewFinish, self)
	end

	BpController.instance:openBattlePassView(false, nil, true)
end

function CharacterSkinTipRightView:OnOpenViewFinish(viewName)
	if viewName == BpController.instance:getBpChargeView() then
		self:closeThis()
	end
end

function CharacterSkinTipRightView:refreshLeftUI()
	CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSkin, self.skinCo, self.viewName)
end

function CharacterSkinTipRightView:refreshRightUI()
	self._simageskinicon:LoadImage(ResUrl.getHeadSkinSmall(self.skinCo.id))
	gohelper.setActive(self._btnBpPay, false)

	if self.skinCo.id == BpConfig.instance:getCurSkinId(BpModel.instance.id) and not BpModel.instance:isEnd() and BpModel.instance.payStatus == BpEnum.PayStatus.NotPay then
		gohelper.setActive(self._btnBpPay, true)
	end
end

function CharacterSkinTipRightView:onClose()
	return
end

function CharacterSkinTipRightView:onDestroyView()
	self._simageskinSwitchBg:UnLoadImage()
	self._simageskinicon:UnLoadImage()
end

return CharacterSkinTipRightView
