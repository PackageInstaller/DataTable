-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardpreheat2023/view/YearCardPreheat2023GameRuleView.lua

module("logic.extensions.yearcardpreheat2023.view.YearCardPreheat2023GameRuleView", package.seeall)

local YearCardPreheat2023GameRuleView = class("YearCardPreheat2023GameRuleView", ViewComponent)

function YearCardPreheat2023GameRuleView:buildUI()
	YearCardPreheat2023GameRuleView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtClose = goutil.findChildTextComponent(self._btnClose, "Text")
end

function YearCardPreheat2023GameRuleView:bindEvents()
	YearCardPreheat2023GameRuleView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function YearCardPreheat2023GameRuleView:unbindEvents()
	YearCardPreheat2023GameRuleView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function YearCardPreheat2023GameRuleView:onEnter()
	YearCardPreheat2023GameRuleView.super.onEnter(self)

	self._isAbleToClose = not YearCardPreheat2023Model.instance:isFirstShowRuleView()

	if not self._isAbleToClose then
		self._curTimer = 4

		self:_onTimer()
		settimer(1, self._onTimer, self)
	else
		self._txtClose.text = lang("知道了")
	end
end

function YearCardPreheat2023GameRuleView:onExit()
	YearCardPreheat2023GameRuleView.super.onExit(self)
	removetimer(self._onTimer, self)
end

function YearCardPreheat2023GameRuleView:_onClickClose()
	if self._isAbleToClose then
		self:close()
	end
end

function YearCardPreheat2023GameRuleView:_onTimer()
	if self._curTimer <= 0 then
		self._isAbleToClose = true

		removetimer(self._onTimer, self)

		self._txtClose.text = lang("知道了")

		YearCardPreheat2023Model.instance:saveFirstShowRuleData()
	else
		self._curTimer = self._curTimer - 1
		self._txtClose.text = langPara("<size=20>知道了（%sS）</size>", self._curTimer)
	end
end

return YearCardPreheat2023GameRuleView
