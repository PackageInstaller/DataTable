-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/TitleView.lua

module("logic.extensions.common.view.TitleView", package.seeall)

local M = class("TitleView", ViewComponent)

function M:ctor(manualKey)
	self._titleName = nil
	self._manualKey = manualKey
end

function M:setHideHomeBtn(hideHomeBtn)
	self._hideHomeBtn = hideHomeBtn

	return self
end

function M:blockOrgBtn(_return, _home, _explain)
	self._blockReturnBtn = _return
	self._blockHomeBtn = _home
	self._blockExplainBtn = _explain

	return self
end

function M:buildUI()
	self._btnReturn1 = self:getBtnByPath("title_view/layout/btnReturn_1")
	self._btnHome1 = self:getBtnByPath("title_view/layout/btnHome_1")
	self._btnHint = self:getBtnByPath("title_view/layout/btnExplain")
	self._txtTitle1 = self:getTextByPath("title_view/layout/btnReturn_1/txtTitle")

	goutil.setActive(self._btnHome1.gameObject, not self._hideHomeBtn)
end

function M:destroyUI()
	self._titleName = nil

	if self._returnHandler then
		self._returnHandler:clear()

		self._returnHandler = nil
	end
end

function M:onEnter()
	if self._titleName then
		self._txtTitle1.text = self._titleName
	end
end

function M:onExit()
	return
end

function M:bindEvents()
	self:registerLocalNotify(EventType.INNER_TITLE_CHANGE_EVENT, self._handleInnerChangeName, self)

	if not self._blockReturnBtn then
		if self._returnHandler then
			self._btnReturn1:AddClickListener(self._returnHandler:getCallBack(), self._returnHandler:getCallObj())
		else
			self._btnReturn1:AddClickListener(self._onClickBack, self)
		end
	end

	if not self._blockHomeBtn then
		self._btnHome1:AddClickListener(self._onClickHome, self)
	end

	if not self._blockExplainBtn then
		self._btnHint:AddClickListener(self._onClickHint, self)
	end
end

function M:unbindEvents()
	self:unregisterLocalNotify(EventType.INNER_TITLE_CHANGE_EVENT, self._handleInnerChangeName, self)
	self._btnReturn1:RemoveClickListener()
	self._btnHome1:RemoveClickListener()
	self._btnHint:RemoveClickListener()
end

function M:_onClickBack()
	self:back()
end

function M:_onClickHome()
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
end

function M:_onClickHint()
	if self._manualKey then
		ViewMgr.instance:open(ViewName.ImageGuide, {
			self._manualKey
		})
	end
end

function M:setReturnClickEvent(callFunc, callObj)
	self._returnHandler = Handler.New(callFunc, callObj)
end

function M:setTitle(titleName)
	self._titleName = titleName
end

function M:_handleInnerChangeName(key, nameStr)
	self:setTitle(nameStr)

	if self._txtTitle1 and not goutil.isNil(self._txtTitle1) then
		self._txtTitle1.text = nameStr
	end
end

return M
