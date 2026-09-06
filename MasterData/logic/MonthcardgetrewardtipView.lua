-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/MonthcardgetrewardtipView.lua

module("logic.extensions.monthcard.view.MonthcardgetrewardtipView", package.seeall)

local MonthcardgetrewardtipView = class("MonthcardgetrewardtipView", ViewComponent)

function MonthcardgetrewardtipView:ctor()
	MonthcardgetrewardtipView.super.ctor(self)
end

function MonthcardgetrewardtipView:buildUI()
	MonthcardgetrewardtipView.super.buildUI(self)

	self.timeText = goutil.findChildComponent(self.mainGO, "timeText", "Text")
	self.okBtn = self:getBtn("okBtn")
end

function MonthcardgetrewardtipView:bindEvents()
	MonthcardgetrewardtipView.super.bindEvents(self)
end

function MonthcardgetrewardtipView:unbindEvents()
	MonthcardgetrewardtipView.super.unbindEvents(self)
end

function MonthcardgetrewardtipView:destroyUI()
	MonthcardgetrewardtipView.super.destroyUI(self)
end

function MonthcardgetrewardtipView:onEnter()
	MonthcardgetrewardtipView.super.onEnter(self)
	self.okBtn:AddClickListener(self.onClickOk, self)
	self:initView()
end

function MonthcardgetrewardtipView:onEnterFinished()
	MonthcardgetrewardtipView.super.onEnterFinished(self)
end

function MonthcardgetrewardtipView:onExit()
	MonthcardgetrewardtipView.super.onExit(self)
	self.okBtn:RemoveClickListener()
end

function MonthcardgetrewardtipView:onExitFinished()
	MonthcardgetrewardtipView.super.onExitFinished(self)
end

function MonthcardgetrewardtipView:onClickOk()
	self:close()
end

function MonthcardgetrewardtipView:initView()
	local restDay = self:getFirstParam()

	self.timeText.text = "剩余可领取奖励天数：" .. restDay .. "天"
end

return MonthcardgetrewardtipView
