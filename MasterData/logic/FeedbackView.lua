-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/feedback/view/FeedbackView.lua

module("logic.extensions.feedback.view.FeedbackView", package.seeall)

local FeedbackView = class("FeedbackView", TableViewComponent)

function FeedbackView:_getPath()
	return {
		cellPath = "Cell",
		viewPath = "ChatView"
	}
end

local CharacterLimit = 200

function FeedbackView:ctor()
	FeedbackView.super.ctor(self)
end

function FeedbackView:bindEvents()
	self._btnHome:AddClickListener(self._onClickHome, self)
	self._txtInput:AddOnValueChanged(self._onInputValueChange, self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._chooseBtn:AddClickListener(self._onClickChoose, self)
	self._sendButton:AddClickListener(self._onClickSend, self)
end

function FeedbackView:unbindEvents()
	self._btnHome:RemoveClickListener()
	self._txtInput:RemoveOnValueChanged()
	self._closeButton:RemoveClickListener()
	self._chooseBtn:RemoveClickListener()
	self._sendButton:RemoveClickListener()
end

function FeedbackView:buildUI()
	FeedbackView.super.buildUI(self)

	self._btnHome = self:getBtn("btn_home")
	self._closeButton = self:getBtn("Close")
	self._sendButton = self:getBtn("BtnSend")
	self._chooseBtn = self:getBtn("BtnChoose")
	self._txtInput = self:getInput("Input")
	self._chooseTxt = goutil.findChildTextComponent(self.mainGO, "BtnChoose/Txt")
	self._TxtC_Test = goutil.findChildTextComponent(self.mainGO, "TxtC_Test")

	self._txtInput:SetCharacterLimit(CharacterLimit)

	self._chooseCfg = {
		"BUG反馈",
		"投诉建议"
	}

	self:_onPopupMenuSelectChooseIndex(1)
end

function FeedbackView:destroyUI()
	return
end

function FeedbackView:onEnter()
	FeedbackView.super.onEnter(self)
	FeedbackController.instance:registerLocalNotify("RefreshFeedBackData", self._refreshData, self)
	FeedbackController.instance:loadFeedbackInfos()
end

function FeedbackView:onEnterFinished()
	return
end

function FeedbackView:onExit()
	FeedbackView.super.onExit(self)
	FeedbackController.instance:unregisterLocalNotify("RefreshFeedBackData", self._refreshData, self)
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = nil
end

function FeedbackView:onExitFinished()
	return
end

function FeedbackView:_onReloadFinish()
	self._tableview:SetOffset(self._tableview:GetMaxOffset(), true)
end

function FeedbackView:_cellSize(view, index)
	return 1130, self:getCellHeight(index + 1)
end

function FeedbackView:_cellAtIndex(view, idx)
	local cell = view:DequeueCell()
	local comp

	if not cell then
		cell = view:AddChild(self._tableCell)

		FeedbackCell.AddOnce(cell.gameObject)
	end

	local data = self._curViewDatas[idx + 1]

	cell.data = idx + 1
	cell.index = idx

	self:_updateCell(view, cell, data)

	return cell
end

function FeedbackView:_updateCell(view, cell, data)
	local comp = FeedbackCell.Get(cell.gameObject)

	comp:updateData(data)
end

function FeedbackView:_clearTableview(cell)
	return
end

function FeedbackView:getCellHeight(index)
	local data = self._curViewDatas[index]
	local msgType = data.msgType

	if msgType == GameEnum.ChatItemType.ItemTime then
		return 100
	else
		self._TxtC_Test.text = data.content

		return 80 + self._TxtC_Test.preferredHeight
	end
end

function FeedbackView:_OnMenuCloseChoose()
	CommonPopupMenuFacade.instance:removeListener(CommonPopupMenuFacade.OnPopupClick, self._onPopupMenuSelectChooseIndex, self)
	CommonPopupMenuFacade.instance:removeListener(CommonPopupMenuFacade.OnViewClose, self._OnMenuCloseChoose, self)
end

function FeedbackView:_onClickChoose()
	CommonPopupMenuFacade.instance:addListener(CommonPopupMenuFacade.OnViewClose, self._OnMenuCloseChoose, self)
	CommonPopupMenuFacade.instance:addListener(CommonPopupMenuFacade.OnPopupClick, self._onPopupMenuSelectChooseIndex, self)

	local t = {}

	for i, name in ipairs(self._chooseCfg) do
		t[i] = {
			name = name,
			value = i
		}
	end

	CommonPopupMenuFacade.instance:OpenView(self._chooseBtn.transform.position, t, false, "", true)
end

function FeedbackView:_onPopupMenuSelectChooseIndex(idx)
	self._chooseTxt.text = self._chooseCfg[idx]
	self._chooseType = idx
end

function FeedbackView:_onInputValueChange()
	local len = string.utf8len(self._txtInput:GetText())

	if len >= CharacterLimit then
		FloatWordMgr.instance:show("消息太长啦！")
	end
end

function FeedbackView:_onClickClose()
	UIStateManager.instance:pop()
end

function FeedbackView:_onClickSend()
	local text = self._txtInput:GetText()

	if not text or #text == 0 then
		FloatWordMgr.instance:show("请输入内容再发送哦！")

		return
	end

	self._txtInput:SetText("")
	FeedbackController.instance:sendFeedback(self._chooseType, text)
end

function FeedbackView:_refreshData()
	self._curViewDatas = FeedbackModel.instance:getMsgs()

	self._tableview:ReloadData()
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_FEEDBACK, false)
end

function FeedbackView:_onClickHome()
	UIStateManager.instance:clear(true)
end

return FeedbackView
