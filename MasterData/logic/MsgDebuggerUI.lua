-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/msgdebugger/MsgDebuggerUI.lua

module("logic.extensions.msgdebugger.MsgDebuggerUI", package.seeall)

local MsgDebuggerUI = class("MsgDebuggerUI")
local ShowStatus = {
	Hide = 1,
	Show = 2
}

function MsgDebuggerUI:show()
	if not self._uigo then
		self._screenWidth, self._screenHeight = UnityEngine.Screen.width, UnityEngine.Screen.height
		self._showStatus = ShowStatus.Show
		self._selectMsg = nil

		getres(MsgDebuggerConfig.UIPath, self._onResourceLoaded, self, ResType.AssetBunble, false)
	end
end

function MsgDebuggerUI:_onResourceLoaded(res)
	if res.IsSuccess then
		self._res = res

		self._res:Retain()

		self._uigo = goutil.clone(res:GetMainAsset())

		goutil.addChildToParent(self._uigo, MsgDebugger.instance.parentGO)

		self._uiWidth = goutil.getWidth(self._uigo.transform)
		self._uiHeight = goutil.getHeight(self._uigo.transform)
		self._btnShow = Framework.ButtonAdapter.GetFrom(self._uigo, "btnShow")
		self._btnFunction = Framework.ButtonAdapter.GetFrom(self._uigo, "btnFunction")
		self._btnBlock = Framework.ButtonAdapter.GetFrom(self._uigo, "btnBlock")
		self._btnSend = Framework.ButtonAdapter.GetFrom(self._uigo, "btnSend")
		self._blockCountGO = goutil.findChild(self._uigo, "btnSend/blockCount")
		self._txtBlockCount = goutil.findChildTextComponent(self._uigo, "btnSend/blockCount/txtCount")
		self._dragTrigger = Framework.UIDragTrigger.Get(self._uigo)

		self._dragTrigger:AddDragListener(self._onDrag, self)
		self._btnShow:AddClickListener(self._onClickShow, self)
		self._btnFunction:AddClickListener(self._onClickFunction, self)
		self._btnBlock:AddClickListener(self._onClickBlock, self)
		self._btnSend:AddClickListener(self._onClickSend, self)
		self:_updateShowStatus()
		MsgDebugger.instance:registerLocalNotify(MsgDebugger.EvtStartBlock, self._updateShowStatus, self)
		MsgDebugger.instance:registerLocalNotify(MsgDebugger.EvtCancelBlock, self._updateShowStatus, self)
		MsgDebugger.instance:registerLocalNotify(MsgDebugger.EvtSend, self._updateShowStatus, self)
		MsgDebugger.instance:registerLocalNotify(MsgDebugger.EvtBlockOneMsg, self._updateShowStatus, self)
	end
end

function MsgDebuggerUI:_updateShowStatus()
	local _, anchorY = Framework.TransformUtil.GetAnchoredPos(self._uigo.transform, 0, 0)

	Framework.TransformUtil.SetAnchoredPos(self._uigo.transform, (self._showStatus == ShowStatus.Hide or nil) and (-self._uiWidth or 0), anchorY)
	goutil.setActive(self._btnFunction.gameObject, true)
	goutil.setActive(self._btnBlock.gameObject, not MsgDebugger.instance:isBlock())
	goutil.setActive(self._btnSend.gameObject, MsgDebugger.instance:isBlock())

	local blockCount = MsgDebuggerModel.instance:getHasBlockMsgCount()

	self._txtBlockCount.text = blockCount

	goutil.setActive(self._blockCountGO, MsgDebugger.instance:isBlock() and blockCount > 0)
end

function MsgDebuggerUI:_onClickShow()
	if self._showStatus == ShowStatus.Hide then
		self._showStatus = ShowStatus.Show or ShowStatus.Hide
	end

	self:_updateShowStatus()
end

function MsgDebuggerUI:_onClickFunction()
	MsgDebuggerView.instance:show()
end

function MsgDebuggerUI:_onClickBlock()
	MsgDebugger.instance:startBlock()
end

function MsgDebuggerUI:_onClickSend()
	MsgDebugger.instance:send()
end

function MsgDebuggerUI:_onDrag(eventData)
	if self._showStatus == ShowStatus.Hide then
		return
	end

	local tempPos = goutil.screenToLocalPos(eventData.position, MsgDebugger.instance.parentGO.transform)

	tempPos.x = tempPos.x < -self._screenWidth / 2 + self._uiWidth and -self._screenWidth / 2 or tempPos.x > self._screenWidth / 2 - self._uiWidth / 2 and self._screenWidth / 2 - self._uiWidth or tempPos.x - self._uiWidth / 2

	if tempPos.y < -self._screenHeight / 2 + self._uiHeight / 2 then
		tempPos.y = -self._screenHeight / 2 + self._uiHeight / 2
	elseif tempPos.y > self._screenHeight / 2 - self._uiHeight / 2 then
		tempPos.y = self._screenHeight / 2 - self._uiHeight / 2
	end

	Framework.TransformUtil.SetLocalPos(self._uigo.transform, tempPos.x, tempPos.y, 0)
end

function MsgDebuggerUI:destroy()
	MsgDebugger.instance:unregisterLocalNotify(MsgDebugger.EvtStartBlock, self._updateShowStatus, self)
	MsgDebugger.instance:unregisterLocalNotify(MsgDebugger.EvtCancelBlock, self._updateShowStatus, self)
	MsgDebugger.instance:unregisterLocalNotify(MsgDebugger.EvtSend, self._updateShowStatus, self)
	MsgDebugger.instance:unregisterLocalNotify(MsgDebugger.EvtBlockOneMsg, self._updateShowStatus, self)

	if self._uigo then
		self._btnShow:RemoveClickListener()
		self._btnFunction:RemoveClickListener()
		self._btnBlock:RemoveClickListener()
		self._btnSend:RemoveClickListener()
		self._dragTrigger:RemoveDragListener()
		goutil.destroy(self._uigo)

		self._uigo = nil
		self._btnShow = nil
		self._btnFunction = nil
		self._btnBlock = nil
		self._btnSend = nil
	end

	if self._res then
		self._res:Release()

		self._res = nil
	end
end

MsgDebuggerUI.instance = MsgDebuggerUI.New()

return MsgDebuggerUI
