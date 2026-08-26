-- chunkname: @modules/logic/v3a8_dragonboat/view/V3a8_DragonBoatActivity_PanelView_Btn.lua

module("modules.logic.v3a8_dragonboat.view.V3a8_DragonBoatActivity_PanelView_Btn", package.seeall)

local V3a8_DragonBoatActivity_PanelView_Btn = class("V3a8_DragonBoatActivity_PanelView_Btn", RougeSimpleItemBase)

function V3a8_DragonBoatActivity_PanelView_Btn:onInitView()
	self._btnok = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_ok")
	self._txtnum = gohelper.findChildText(self.viewGO, "bg/#txt_num")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "bg/#btn_add")
	self._btndes = gohelper.findChildButtonWithAudio(self.viewGO, "bg/#btn_des")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a8_DragonBoatActivity_PanelView_Btn:addEvents()
	self._btnok:AddClickListener(self._btnokOnClick, self)
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
	self._btndes:AddClickListener(self._btndesOnClick, self)
end

function V3a8_DragonBoatActivity_PanelView_Btn:removeEvents()
	self._btnok:RemoveClickListener()
	self._btnadd:RemoveClickListener()
	self._btndes:RemoveClickListener()
end

function V3a8_DragonBoatActivity_PanelView_Btn:ctor(...)
	V3a8_DragonBoatActivity_PanelView_Btn.super.ctor(self, ...)

	self._num = 0
	self._settings = {
		minNum = 0,
		maxNum = 0,
		initNum = 0
	}
end

function V3a8_DragonBoatActivity_PanelView_Btn:onDestroyView()
	V3a8_DragonBoatActivity_PanelView_Btn.super.onDestroyView(self)
end

function V3a8_DragonBoatActivity_PanelView_Btn:_editableInitView()
	V3a8_DragonBoatActivity_PanelView_Btn.super._editableInitView(self)

	self._bgGo = gohelper.findChild(self.viewGO, "bg")

	gohelper.setActive(self._bgGo, true)
end

function V3a8_DragonBoatActivity_PanelView_Btn:_btnokOnClick()
	local p = self:parent()

	p:onNumOkClick(self)
end

function V3a8_DragonBoatActivity_PanelView_Btn:_btnaddOnClick()
	self:setNum(self._num + 1)
end

function V3a8_DragonBoatActivity_PanelView_Btn:_btndesOnClick()
	self:setNum(self._num - 1)
end

function V3a8_DragonBoatActivity_PanelView_Btn:_setNum(num)
	self._num = GameUtil.clamp(num, self:minNum(), self:maxNum())
end

function V3a8_DragonBoatActivity_PanelView_Btn:refreshNumText()
	self._txtnum.text = tostring(self._num)
end

function V3a8_DragonBoatActivity_PanelView_Btn:setNum(num)
	self:_setNum(num)
	self:refreshNumText()

	local p = self:parent()

	p:onNumChanged(self)
end

function V3a8_DragonBoatActivity_PanelView_Btn:minNum()
	return self._settings.minNum or 0
end

function V3a8_DragonBoatActivity_PanelView_Btn:maxNum()
	return self._settings.maxNum or 0
end

function V3a8_DragonBoatActivity_PanelView_Btn:num()
	return self._num
end

function V3a8_DragonBoatActivity_PanelView_Btn:setData(mo)
	V3a8_DragonBoatActivity_PanelView_Btn.super.setData(self, mo)
	self:refreshNumText()
end

function V3a8_DragonBoatActivity_PanelView_Btn:setSettings(minNum, maxNum, initNum)
	if minNum then
		self._settings.minNum = minNum
	end

	if maxNum then
		self._settings.maxNum = maxNum
	end

	if initNum then
		self._settings.initNum = initNum
	end

	self:_setNum(initNum or self._num)
	gohelper.setActive(self._bgGo, self:maxNum() > 1)
end

return V3a8_DragonBoatActivity_PanelView_Btn
