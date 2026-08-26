-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackBoxTipsView.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackBoxTipsView", package.seeall)

local Rouge2_BackpackBoxTipsView = class("Rouge2_BackpackBoxTipsView", BaseView)

function Rouge2_BackpackBoxTipsView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._imageprogress = gohelper.findChildImage(self.viewGO, "progress/#image_progress")
	self._txtprogress = gohelper.findChildText(self.viewGO, "info/#txt_progress")
	self._gobase = gohelper.findChild(self.viewGO, "info/base")
	self._gobaseitem = gohelper.findChild(self.viewGO, "info/base/#go_baseitem")
	self._imagebase = gohelper.findChildImage(self.viewGO, "info/base/#go_baseitem/#image_base")
	self._txtdec = gohelper.findChildText(self.viewGO, "info/scroll_dec/Viewport/Content/#txt_dec")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm", AudioEnum.Rouge2.ClickBXSPoint)
	self._goBtnLight = gohelper.findChild(self.viewGO, "#btn_confirm/ani/lightbg")
	self._goBtnDark = gohelper.findChild(self.viewGO, "#btn_confirm/ani/darkbg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_BackpackBoxTipsView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnUpdateRougeInfo, self._onUpdateRougeInfo, self)
end

function Rouge2_BackpackBoxTipsView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
end

function Rouge2_BackpackBoxTipsView:_btncloseOnClick()
	self:closeThis()
end

function Rouge2_BackpackBoxTipsView:_btnconfirmOnClick()
	local curBoxPoint = Rouge2_BackpackModel.instance:getCurBoxPoint()
	local maxBoxPoint = Rouge2_MapConfig.instance:BXSMaxBoxPoint()

	if curBoxPoint < maxBoxPoint then
		GameFacade.showToast(ToastEnum.Rouge2LackBoxPoint)

		return
	end

	Rouge2_Rpc.instance:sendRouge2GainCareer1RewardRequest()
end

function Rouge2_BackpackBoxTipsView:_editableInitView()
	local goprogress = gohelper.findChild(self.viewGO, "progress")

	self._animator = gohelper.onceAddComponent(goprogress, gohelper.Type_Animator)

	local goConfirmAnim = gohelper.findChild(self.viewGO, "#btn_confirm/ani")

	self._confirmAnimator = gohelper.onceAddComponent(goConfirmAnim, gohelper.Type_Animator)
	self._isFirst = true

	NavigateMgr.instance:addEscape(self.viewName, self.closeThis, self)
end

function Rouge2_BackpackBoxTipsView:onUpdateParam()
	return
end

function Rouge2_BackpackBoxTipsView:onOpen()
	self:refreshUI()
end

function Rouge2_BackpackBoxTipsView:refreshUI()
	self:refreshProgress()
	self:refreshAttrList()
end

function Rouge2_BackpackBoxTipsView:refreshProgress()
	local curPoint = Rouge2_BackpackModel.instance:getCurBoxPoint()
	local maxPoint = Rouge2_MapConfig.instance:BXSMaxBoxPoint()

	self._txtprogress.text = string.format("%s/<size=52>%s</size>", curPoint, maxPoint)

	if maxPoint ~= 0 then
		self._imageprogress.fillAmount = curPoint / maxPoint or 0
	end

	local isLight = maxPoint <= curPoint

	gohelper.setActive(self._goBtnLight, isLight)
	gohelper.setActive(self._goBtnDark, not isLight)

	if isLight then
		local animName = self._isFirst and "full" or "fullloop"
		local confirmAnim = self._isFirst and "light" or "idle"

		self._animator:Play(animName, 0, 0)
		self._confirmAnimator:Play(confirmAnim, 0, 0)

		self._isFirst = false

		AudioMgr.instance:trigger(AudioEnum.Rouge2.HasBXSPoint)
	else
		self._animator:Play("normal", 0, 0)
		self._confirmAnimator:Play("idle", 0, 0)
	end
end

function Rouge2_BackpackBoxTipsView:refreshAttrList()
	local attrIdList = Rouge2_MapConfig.instance:getBXSAttrIdList()

	gohelper.CreateObjList(self, self._refreshAttrItem, attrIdList, self._gobase, self._gobaseitem)
end

function Rouge2_BackpackBoxTipsView:_refreshAttrItem(obj, attrId, index)
	local imagebase = gohelper.findChildImage(obj, "#image_base")

	Rouge2_IconHelper.setAttributeIcon(attrId, imagebase)
end

function Rouge2_BackpackBoxTipsView:_onUpdateRougeInfo()
	self:refreshUI()
end

function Rouge2_BackpackBoxTipsView:onDestroyView()
	return
end

return Rouge2_BackpackBoxTipsView
