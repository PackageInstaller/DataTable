-- chunkname: @modules/logic/currency/view/PowerMakerPatFaceView.lua

module("modules.logic.currency.view.PowerMakerPatFaceView", package.seeall)

local PowerMakerPatFaceView = class("PowerMakerPatFaceView", BaseView)

function PowerMakerPatFaceView:onInitView()
	self._btntouchClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_touchClose")
	self._txtdesc1 = gohelper.findChildText(self.viewGO, "desc/#txt_desc_1")
	self._txtdesc2 = gohelper.findChildText(self.viewGO, "desc/#txt_desc_2")
	self._txtdesc3 = gohelper.findChildText(self.viewGO, "desc/#txt_desc_3")
	self._goleftitem = gohelper.findChild(self.viewGO, "#go_leftitem")
	self._gorightitem = gohelper.findChild(self.viewGO, "#go_rightitem")
	self._txtoverflowcount = gohelper.findChildText(self.viewGO, "#go_rightitem/#txt_overflowcount")
	self._txtoverfloweffect = gohelper.findChildText(self.viewGO, "#go_rightitem/#txt_overfloweffect")
	self._btnoverflowitem = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rightitem/#btn_overflowitem")
	self._gooverflowdeatline = gohelper.findChild(self.viewGO, "#go_rightitem/#go_overflowdeadline")
	self._txtoverflowtime = gohelper.findChildText(self.viewGO, "#go_rightitem/#go_overflowdeadline/#txt_overflowtime")
	self._txtoverflowicon = gohelper.findChildImage(self.viewGO, "#go_rightitem/#go_overflowdeadline/#txt_overflowtime/overflowtimeicon")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_buy")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PowerMakerPatFaceView:addEvents()
	self._btntouchClose:AddClickListener(self._btntouchCloseOnClick, self)
	self._btnoverflowitem:AddClickListener(self._btnoverflowitemOnClick, self)
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function PowerMakerPatFaceView:removeEvents()
	self._btntouchClose:RemoveClickListener()
	self._btnoverflowitem:RemoveClickListener()
	self._btnbuy:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function PowerMakerPatFaceView:_btnoverflowitemOnClick()
	return
end

function PowerMakerPatFaceView:_btntouchCloseOnClick()
	return
end

function PowerMakerPatFaceView:_btnbuyOnClick()
	CurrencyController.instance:openPowerView()
	self:closeThis()
end

function PowerMakerPatFaceView:_btncloseOnClick()
	self:closeThis()
end

function PowerMakerPatFaceView:_editableInitView()
	return
end

function PowerMakerPatFaceView:onUpdateParam()
	return
end

function PowerMakerPatFaceView:onOpen()
	self:_refreshPowerMakerInfo()
	self:_ofMakerFlyPower()
end

function PowerMakerPatFaceView:_refreshPowerMakerInfo()
	self._ofMakerInfo = ItemPowerModel.instance:getPowerMakerInfo()

	if not self._ofMakerInfo then
		return
	end

	local descLang1 = luaLang("PowerMakerPatFaceView_desc_1")
	local timeStr = TimeUtil.SecondToActivityTimeFormat(self._ofMakerInfo.logoutSecond)

	self._txtdesc1.text = GameUtil.getSubPlaceholderLuaLangOneParam(descLang1, timeStr)

	local descLang2 = luaLang("PowerMakerPatFaceView_desc_2")

	self._txtdesc2.text = GameUtil.getSubPlaceholderLuaLangOneParam(descLang2, self._ofMakerInfo.makeCount)

	local powerId = MaterialEnum.PowerId.OverflowPowerId
	local count = ItemPowerModel.instance:getPowerCount(powerId)
	local powerConfig = ItemConfig.instance:getPowerItemCo(powerId)
	local limitSec = ItemPowerModel.instance:getPowerMinExpireTimeOffset(powerId)

	self:refreshTxtCount(self._txtoverflowcount, count)
	self:refreshTxtEffect(self._txtoverfloweffect, powerConfig.effect)
	self:refreshDeadLine(self._gooverflowdeatline, self._txtoverflowtime, self._txtoverflowicon, limitSec, count)
end

function PowerMakerPatFaceView:refreshTxtCount(textComp, count)
	textComp.text = GameUtil.numberDisplay(count)
end

function PowerMakerPatFaceView:refreshTxtEffect(textComp, effect)
	textComp.text = GameUtil.getSubPlaceholderLuaLang(luaLang("powerview_addpower"), {
		effect
	})
end

function PowerMakerPatFaceView:refreshDeadLine(goDeadline, textComp, icon, limitSec, count)
	if not limitSec or limitSec <= 0 then
		gohelper.setActive(goDeadline, false)

		return
	end

	if count and count <= 0 then
		gohelper.setActive(goDeadline, false)

		return
	end

	gohelper.setActive(goDeadline, true)

	if limitSec <= TimeUtil.OneDaySecond then
		SLFramework.UGUI.GuiHelper.SetColor(icon, "#EA6868")

		textComp.text = string.format("<color=#EA6868>%s%s</color>", TimeUtil.secondToRoughTime(limitSec))
	else
		SLFramework.UGUI.GuiHelper.SetColor(icon, "#FFFFFF")

		textComp.text = string.format("<color=#FFFFFF>%s%s</color>", TimeUtil.secondToRoughTime(limitSec))
	end
end

function PowerMakerPatFaceView:_ofMakerFlyPower()
	local makeCount = self._ofMakerInfo.makeCount

	if makeCount <= 0 then
		return
	end

	if not self._ofMakerFlyGroup then
		local go = gohelper.findChild(self.viewGO, "flygroup")

		self._ofMakerFlyGroup = MonoHelper.addNoUpdateLuaComOnceToGo(go, PowerItemFlyGroup)
	end

	self._ofMakerFlyGroup:flyItems(makeCount)

	self._ofMakerInfo.makeCount = 0
end

function PowerMakerPatFaceView:onClose()
	if self._ofMakerFlyGroup then
		self._ofMakerFlyGroup:cancelTask()
	end
end

function PowerMakerPatFaceView:onDestroyView()
	return
end

return PowerMakerPatFaceView
