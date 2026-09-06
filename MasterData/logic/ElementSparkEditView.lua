-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkEditView.lua

module("logic.extensions.elementspark.view.ElementSparkEditView", package.seeall)

local ElementSparkEditView = class("ElementSparkEditView", ViewComponent)

function ElementSparkEditView:ctor()
	ElementSparkEditView.super.ctor(self)
end

function ElementSparkEditView:unbindEvents()
	ElementSparkEditView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	self._inputField:RemoveOnValueChanged()
end

function ElementSparkEditView:bindEvents()
	ElementSparkEditView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	self._inputField:AddOnValueChanged(self._onValueChange, self)
end

function ElementSparkEditView:buildUI()
	ElementSparkEditView.super.buildUI(self)

	self._txtTitle = self:getTxt("txtTitle")
	self._txtLimit = self:getTxt("txtLimit")
	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")
	self._inputField = self:getInput("inputField")
end

function ElementSparkEditView:onExit()
	ElementSparkEditView.super.onExit(self)
end

function ElementSparkEditView:onEnter()
	ElementSparkEditView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.EleSparkModifyBoardRes, self._refreshBoard, self)
	self.addGEvent(self, GlobalNotify.EleSparkPublishCommandRes, self._refreshOrder, self)

	self._activityId = ElementSparkController.instance:getActivityId()
	self._inputType = checknumber(self:getFirstParam())
	self._content = ""
	self._limitWordCount = 30
	self._curWordCount = 0

	if self._inputType == 1 then
		self._txtTitle.text = "阵营公告"
		self._limitWordCount = ElementSparkConfig.instance:getCommonCfgByKey("BOARD_MAX_LENGTH", true)
		self._content = ElementSparkModel.instance:getBoardInfo()
	elseif self._inputType == 2 then
		self._txtTitle.text = "发布指令"
		self._limitWordCount = ElementSparkConfig.instance:getCommonCfgByKey("COMMAND_MAX_LENGTH", true)
		self._content = "欢迎来到龙裔争夺战"
	end

	self._inputField:SetText(self._content)
	self._inputField:SetCharacterLimit(self._limitWordCount)
end

function ElementSparkEditView:_refreshBoard()
	FloatWordMgr.instance:show("修改公告成功")
	self:close()
end

function ElementSparkEditView:_refreshOrder()
	FloatWordMgr.instance:show("发布指令成功")
	self:close()
end

function ElementSparkEditView:_onValueChange()
	local text = self._inputField:GetText()
	local t = StringUtil.utf8split(text)
	local len = 0

	for i = 1, #t do
		if i > self._limitWordCount then
			break
		else
			len = len + 1
		end
	end

	self._txtLimit.text = string.format("%d/%d", len, self._limitWordCount)
end

function ElementSparkEditView:_onClickSure()
	self._content = self._inputField:GetText()

	if not string.nilorempty(self._content) then
		if self._inputType == 1 then
			if self._content == ElementSparkModel.instance:getBoardInfo() then
				FloatWordMgr.instance:show("公告没修改任何内容哦~")

				return
			end

			ElementSparkController.instance:sendPM_EleSparkModifyBoardReq(self._activityId, self._content)
		elseif self._inputType == 2 then
			ElementSparkController.instance:sendPM_EleSparkPublishCommandReq(self._activityId, self._content)
		end
	else
		FloatWordMgr.instance:show("请输入有效文字")
	end
end

return ElementSparkEditView
