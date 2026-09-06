-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/msgdebugger/MsgDebuggerItem.lua

module("logic.extensions.msgdebugger.MsgDebuggerItem", package.seeall)

local MsgDebuggerItem = class("MsgDebuggerItem", ListBinderCell)

function MsgDebuggerItem:Awake()
	self._mo = nil
	self._itemClick = Framework.UIClickTrigger.Get(self._go)

	self._itemClick:AddClickListener(self._onClickItem, self)

	self._txtMsgName = goutil.findChildTextComponent(self._go, "protoMsg/txtMsgName")
	self._txtTime = goutil.findChildTextComponent(self._go, "protoMsg/txtTime")
	self._txtSequence = goutil.findChildTextComponent(self._go, "protoMsg/txtSequence")
	self._imgMsgStatus = goutil.findChildImageComponent(self._go, "protoMsg/imgMsgStatus")

	MsgDebugger.instance:registerLocalNotify(MsgDebugger.EvtModifyParam, self._onModifyParam, self)
end

function MsgDebuggerItem:onSetMo(mo)
	self._mo = mo

	self:_updateItem()
end

function MsgDebuggerItem:_onModifyParam(paramMO)
	self:_updateItem()
end

function MsgDebuggerItem:_updateItem()
	local msgName = string.format("<size=16><color=#888888>%d_%d</color></size> %s@%d", self._mo.ext, self._mo.cmd, self._mo.pbUpStructName, self._mo.paramCount)

	self._txtMsgName.text = self._mo.hasModifyValue and "<color=red>" .. msgName .. "</color>" or msgName
	self._txtTime.text = GameUtil.formatTimeStamp("%H:%M:%S", self._mo.time)
	self._txtSequence.text = self._mo.id
	self._imgMsgStatus.color = Framework.ColorUtil.ParseColor(self._mo.isBlock and "#FF0000" or "#00CA34")
end

function MsgDebuggerItem:_onClickItem(eventData, param)
	if MsgDebuggerConfig.NeedPrintStackTrace then
		printWarn(self._mo.callStackTrace)
	end

	MsgDebuggerParamModel.instance:enterMsg(self._mo)
	MsgDebugger.instance:localNotify(MsgDebugger.EvtEnterMsg)
end

function MsgDebuggerItem:OnDestroy()
	MsgDebugger.instance:unregisterLocalNotify(MsgDebugger.EvtModifyParam, self._onModifyParam, self)

	if self._itemClick then
		self._itemClick:RemoveClickListener()

		self._itemClick = nil
	end
end

return MsgDebuggerItem
