-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/crossword/view/CrosswordinputView.lua

module("logic.extensions.crossword.view.CrosswordinputView", package.seeall)

local CrosswordinputView = class("CrosswordinputView", ViewComponent)

function CrosswordinputView:ctor()
	CrosswordinputView.super.ctor(self)
end

function CrosswordinputView:unbindEvents()
	CrosswordinputView.super.unbindEvents(self)
	self._input:RemoveOnValueChanged()
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._BtnClear)
end

function CrosswordinputView:bindEvents()
	CrosswordinputView.super.bindEvents(self)
	self._input:AddOnValueChanged(self._onTextChanged, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._BtnClear, self._onClickClear, self)
end

function CrosswordinputView:buildUI()
	CrosswordinputView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._txtDesc = self:getTxt("txtDesc")
	self._input = self:getInput("Input")
	self._BtnClear = self:getGo("Input/BtnClear")
end

function CrosswordinputView:onExit()
	CrosswordinputView.super.onExit(self)
end

function CrosswordinputView:onEnter()
	CrosswordinputView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = params[1]
	self._sentenceId = params[2]
	self._selectGridId = params[3]

	self:_onClickClear()

	local cfg = CrossWordConfig.instance:getPrizeCfgById(self._activityId, self._sentenceId) or {}

	self._txtDesc.text = cfg.tips
end

function CrosswordinputView:_onClickSure()
	if string.nilorempty(self._currInputStr) then
		TipsFacade.instance:openCommonTips("请先输入文字")
	else
		local cfg = CrossWordConfig.instance:getGridCfgById(self._activityId, self._selectGridId) or {}

		if self._currInputStr == cfg.word then
			CrossWrodController.instance:sendFinishGrid(self._activityId, self._selectGridId)
			self:close()
		else
			TipsFacade.instance:openCommonTips("填入文字不正确，请重新填入")
		end
	end
end

function CrosswordinputView:_onTextChanged()
	local text = self._input:GetText()

	if text ~= self._currInputStr then
		self._currInputStr = text
	end
end

function CrosswordinputView:_onClickClear()
	self._input.input.text = ""
	self._currInputStr = ""
end

return CrosswordinputView
