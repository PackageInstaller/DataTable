-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/msgdebugger/MsgDebuggerParamItem.lua

module("logic.extensions.msgdebugger.MsgDebuggerParamItem", package.seeall)

local MsgDebuggerParamItem = class("MsgDebuggerParamItem", ListBinderCell)

function MsgDebuggerParamItem:ctor(compContainer)
	MsgDebuggerParamItem.super.ctor(self, compContainer)
	self:Awake()
end

function MsgDebuggerParamItem:Awake()
	self._mo = nil
	self._itemClick = Framework.UIClickTrigger.Get(self._go)
	self._btnRemove = Framework.UIClickTrigger.Get(goutil.findChild(self._go, "btnRemove"))
	self._btnAdd = Framework.UIClickTrigger.Get(goutil.findChild(self._go, "btnAdd"))

	self._itemClick:AddClickListener(self._onClickItem, self)
	self._btnRemove:AddClickListener(self._onClickRemove, self)
	self._btnAdd:AddClickListener(self._onClickAdd, self)

	self._txtParamName = goutil.findChildTextComponent(self._go, "txtParamName")
	self._txtParamValue = goutil.findChildTextComponent(self._go, "txtParamValue")

	MsgDebugger.instance:registerLocalNotify(MsgDebugger.EvtModifyParam, self._onModifyParam, self)
end

function MsgDebuggerParamItem:onSetMo(mo)
	self._mo = mo

	self:_updateItem()
end

function MsgDebuggerParamItem:_onModifyParam(paramMO)
	self:_updateItem()
end

function MsgDebuggerParamItem:_updateItem()
	self._txtParamName.text = string.format("<size=16><color=#888888>%s </color></size> %s@%s", self._mo.paramLabelStr, self._mo.paramName, self._mo.paramTypeStr)
	self._txtParamValue.text = self._mo.hasModifyValue and "<color=red>" .. tostring(self._mo.msgValue) .. "</color>" or tostring(self._mo.msgValue)

	if self._mo.parentParamMO then
		local isParentRepeated = self._mo.parentParamMO:isRepeated()
		local isNilParam = self._mo:isNilParam()

		goutil.setActive(self._txtParamName.gameObject, not isNilParam)
		goutil.setActive(self._txtParamValue.gameObject, not isNilParam)
		goutil.setActive(self._btnAdd.gameObject, isParentRepeated and isNilParam)
		goutil.setActive(self._btnRemove.gameObject, isParentRepeated and not isNilParam)
	end
end

function MsgDebuggerParamItem:_onClickItem(eventData, param)
	print(">>>>>>>>> _onClickItem", self._mo:isRepeated(), self._mo:isProtoType())

	if self._mo:isRepeated() or self._mo:isProtoType() then
		MsgDebuggerParamModel.instance:enterMsg(self._mo.msgDebuggerMO, self._mo.id)
		MsgDebugger.instance:localNotify(MsgDebugger.EvtEnterMsg)
	else
		MsgDebuggerModifyView.instance:show(self._mo)
	end
end

function MsgDebuggerParamItem:_onClickAdd()
	MsgDebuggerParamModel.instance:addDefaultParam(self._mo)
end

function MsgDebuggerParamItem:_onClickRemove()
	MsgDebuggerParamModel.instance:removeParam(self._mo)
end

function MsgDebuggerParamItem:OnDestroy()
	MsgDebugger.instance:unregisterLocalNotify(MsgDebugger.EvtModifyParam, self._onModifyParam, self)

	if self._itemClick then
		self._itemClick:RemoveClickListener()

		self._itemClick = nil
	end

	if self._btnAdd then
		self._btnAdd:RemoveClickListener()

		self._btnAdd = nil
	end

	if self._btnRemove then
		self._btnRemove:RemoveClickListener()

		self._btnRemove = nil
	end
end

return MsgDebuggerParamItem
