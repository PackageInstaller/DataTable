-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/msgdebugger/MsgDebuggerView.lua

module("logic.extensions.msgdebugger.MsgDebuggerView", package.seeall)

local MsgDebuggerView = class("MsgDebuggerView")

function MsgDebuggerView:show()
	if not self._viewGO then
		self._multiLoader = MultiResLoader.New()

		self._multiLoader:addResPath(MsgDebuggerConfig.ViewPath)
		self._multiLoader:addResPath(MsgDebuggerConfig.ItemPath)
		self._multiLoader:addResPath(MsgDebuggerConfig.ItemParamPath)
		self._multiLoader:load(self._onAllResLoaded, nil, self)
	else
		goutil.setActive(self._viewGO, true)
		self._listView:onEnter()
		self._listParamView:onEnter()
		self:onEnter()
	end
end

function MsgDebuggerView:_onAllResLoaded()
	self._viewGO = goutil.clone(self._multiLoader:getResource(MsgDebuggerConfig.ViewPath):GetMainAsset())

	goutil.addChildToParent(self._viewGO, MsgDebugger.instance.parentGO)

	self._txtTitle = goutil.findChildTextComponent(self._viewGO, "imgTitleBg/txtTitle")
	self._imgMsgStatus = goutil.findChildImageComponent(self._viewGO, "imgTitleBg/txtTitle/imgMsgStatus")
	self._scrollGO = goutil.findChild(self._viewGO, "scrollView")
	self._scrollMsgParamGO = goutil.findChild(self._viewGO, "scrollMsgParamView")
	self._btnClose = Framework.ButtonAdapter.GetFrom(self._viewGO, "imgTitleBg/btnClose")

	self._btnClose:AddClickListener(self._onClickClose, self)

	self._btnBack = Framework.ButtonAdapter.GetFrom(self._viewGO, "imgTitleBg/btnBack")

	self._btnBack:AddClickListener(self._onClickBack, self)

	self._btnBlock = Framework.ButtonAdapter.GetFrom(self._viewGO, "imgBottomBg/btnBlock")
	self._btnResume = Framework.ButtonAdapter.GetFrom(self._viewGO, "imgBottomBg/btnResume")
	self._btnSend = Framework.ButtonAdapter.GetFrom(self._viewGO, "imgBottomBg/btnSend")
	self._btnClear = Framework.ButtonAdapter.GetFrom(self._viewGO, "imgBottomBg/btnClear")
	self._btnSendOneMore = Framework.ButtonAdapter.GetFrom(self._viewGO, "imgBottomBg/btnSendOneMore")

	self._btnBlock:AddClickListener(self._onClickBlock, self)
	self._btnResume:AddClickListener(self._onClickResume, self)
	self._btnSend:AddClickListener(self._onClickSend, self)
	self._btnClear:AddClickListener(self._onClickClear, self)
	self._btnSendOneMore:AddClickListener(self._onClickSendOneMore, self)

	self._closeTrigger = Framework.UIClickTrigger.Get(goutil.findChild(self._viewGO, "imgMask"))

	self._closeTrigger:AddClickListener(self._onClickMask, self)

	local scrollParams = {
		kScrollDirV,
		700,
		50,
		0,
		0,
		1
	}

	self._viewPresentor = ViewPresentor.New()
	self._viewPresentor.localDispatcher = MsgDebugger.instance.dispatcher
	self._listView = ListBinderView.New(MsgDebuggerModel.instance, "scrollView", "item", MsgDebuggerItem, scrollParams)
	self._listView.mainGO = self._viewGO

	self._listView:setViewPresentor(self._viewPresentor)

	function self._listView.getResInstance(url)
		return goutil.clone(self._multiLoader:getResource(MsgDebuggerConfig.ItemPath):GetMainAsset())
	end

	self._listView:buildUI()
	self._listView:onEnter()

	self._listParamView = ListBinderView.New(MsgDebuggerParamModel.instance, "scrollMsgParamView", "item", MsgDebuggerParamItem, scrollParams)
	self._listParamView.mainGO = self._viewGO

	self._listParamView:setViewPresentor(self._viewPresentor)

	function self._listParamView.getResInstance(url)
		return goutil.clone(self._multiLoader:getResource(MsgDebuggerConfig.ItemParamPath):GetMainAsset())
	end

	self._listParamView:buildUI()
	self._listParamView:onEnter()
	self:onEnter()
end

function MsgDebuggerView:destroy()
	if self._viewGO then
		self._btnClose:RemoveClickListener()
		self._btnBack:RemoveClickListener()
		self._closeTrigger:RemoveClickListener()
		self._btnBlock:RemoveClickListener()
		self._btnResume:RemoveClickListener()
		self._btnSend:RemoveClickListener()
		self._btnClear:RemoveClickListener()
		self._btnSendOneMore:RemoveClickListener()
		goutil.destroy(self._viewGO)

		self._viewGO = nil
		self._btnClose = nil
	end

	if self._multiLoader then
		self._multiLoader:clear()

		self._multiLoader = nil
	end

	self._listView:destroyUI()
	self._listParamView:destroyUI()
end

function MsgDebuggerView:_onClickMask()
	if not MsgDebuggerParamModel.instance:isModifingParam() then
		self:_close(false)
	end
end

function MsgDebuggerView:_onClickClose()
	self:_close(false)
end

function MsgDebuggerView:_close(isForce)
	MsgDebuggerParamModel.instance:exitMsg(isForce)
	goutil.setActive(self._viewGO, false)
	self._listView:onExitFinished()
	self._listParamView:onExitFinished()
	self:onExit()
end

function MsgDebuggerView:_onClickBack()
	MsgDebuggerParamModel.instance:exitMsg()
	MsgDebugger.instance:localNotify(MsgDebugger.EvtExitMsg)
end

function MsgDebuggerView:_onClickBlock()
	MsgDebugger.instance:startBlock()
	self:_updateUI()
end

function MsgDebuggerView:_onClickResume()
	MsgDebugger.instance:cancelBlock()
	self:_updateUI()
end

function MsgDebuggerView:_onClickSend()
	MsgDebugger.instance:send()
	self:_close(true)
end

function MsgDebuggerView:_onClickClear()
	MsgDebugger.instance:clear()
	self:_updateUI()
end

function MsgDebuggerView:_onClickSendOneMore()
	MsgDebugger.instance:sendOneMore(MsgDebuggerParamModel.instance.editingMsgMO)
	self:_close(true)
end

function MsgDebuggerView:onEnter()
	self:_updateUI()
	MsgDebugger.instance:registerLocalNotify(MsgDebugger.EvtEnterMsg, self._updateUI, self)
	MsgDebugger.instance:registerLocalNotify(MsgDebugger.EvtExitMsg, self._updateUI, self)
end

function MsgDebuggerView:onExit()
	MsgDebugger.instance:unregisterLocalNotify(MsgDebugger.EvtEnterMsg, self._updateUI, self)
	MsgDebugger.instance:unregisterLocalNotify(MsgDebugger.EvtExitMsg, self._updateUI, self)
end

function MsgDebuggerView:_updateUI()
	local isModifingParam = MsgDebuggerParamModel.instance:isModifingParam()
	local editingMsgMO = MsgDebuggerParamModel.instance.editingMsgMO

	goutil.setActive(self._scrollGO, not isModifingParam)
	goutil.setActive(self._scrollMsgParamGO, isModifingParam)
	goutil.setActive(self._btnClose.gameObject, not isModifingParam)
	goutil.setActive(self._btnBack.gameObject, isModifingParam)
	goutil.setActive(self._imgMsgStatus.gameObject, isModifingParam)
	goutil.setActive(self._btnBlock.gameObject, not MsgDebugger.instance:isBlock())
	goutil.setActive(self._btnResume.gameObject, MsgDebugger.instance:isBlock())
	goutil.setActive(self._btnSend.gameObject, MsgDebugger.instance:isBlock())
	goutil.setActive(self._btnClear.gameObject, not isModifingParam)
	goutil.setActive(self._btnSendOneMore.gameObject, editingMsgMO and not editingMsgMO.isBlock)

	if isModifingParam then
		self._txtTitle.text = editingMsgMO.pbUpStructName or "Msg List"
	end

	if isModifingParam then
		self._imgMsgStatus.color = Framework.ColorUtil.ParseColor(editingMsgMO.isBlock and "#FF0000" or "#00CA34")
	end
end

MsgDebuggerView.instance = MsgDebuggerView.New()

return MsgDebuggerView
