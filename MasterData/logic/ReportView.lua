-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/report/view/ReportView.lua

module("logic.extensions.report.view.ReportView", package.seeall)

local ReportView = class("ReportView", ViewComponent)

function ReportView:ctor()
	ReportView.super.ctor(self)
end

function ReportView:buildUI()
	ReportView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._name = goutil.findChildTextComponent(self.mainGO, "base/name/Text")
	self._id = goutil.findChildTextComponent(self.mainGO, "base/id/Text")
	self._reason = {}

	for i = 1, 8 do
		self._reason[i] = {
			btn = self:getBtn("reason/" .. i),
			checkbox = self:getGo("reason/" .. i .. "/checkbox")
		}
	end

	self._additional = self:getInput("additional/input")
	self._content = goutil.findChildTextComponent(self.mainGO, "content/Text")
	self._submitBtn = self:getBtn("submitBtn")
end

function ReportView:bindEvents()
	ReportView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)

	for index, value in ipairs(self._reason) do
		value.btn:AddClickListener(function()
			self:_onClickReasonType(index)
		end)
	end

	self._submitBtn:AddClickListener(self._onClickSubmit, self)
end

function ReportView:unbindEvents()
	ReportView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()

	for i, v in ipairs(self._reason) do
		v.btn:RemoveClickListener()
	end

	self._submitBtn:RemoveClickListener()
end

function ReportView:destroyUI()
	ReportView.super.destroyUI(self)
end

function ReportView:onEnter()
	ReportView.super.onEnter(self)

	local openParam = self:getOpenParam()

	self._name.text = openParam[1]
	self._id.text = openParam[2]
	self._content.text = openParam[3]

	self:_onClickReasonType(1)
end

function ReportView:onEnterFinished()
	ReportView.super.onEnterFinished(self)
end

function ReportView:onExit()
	ReportView.super.onExit(self)
end

function ReportView:onExitFinished()
	ReportView.super.onExitFinished(self)
end

function ReportView:_onClickReasonType(index)
	self._reasonType = index < 8 and index or 100

	for i, v in ipairs(self._reason) do
		goutil.setActive(v.checkbox.gameObject, index == i)
	end
end

function ReportView:_onClickSubmit()
	FeedbackAgent.instance:sendPM_ReportReq(tonumber(self._id.text), self._reasonType, self._additional:GetText(), self._content.text, function()
		FloatWordMgr.instance:show("举报成功")
		self:close()
	end)
end

return ReportView
