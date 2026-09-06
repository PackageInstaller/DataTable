-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liyangking/view/LiYangKingBenefitResultView.lua

module("logic.extensions.liyangking.view.LiYangKingBenefitResultView", package.seeall)

local LiYangKingBenefitResultView = class("LiYangKingBenefitResultView", ViewComponent)

function LiYangKingBenefitResultView:ctor()
	LiYangKingBenefitResultView.super.ctor(self)
end

function LiYangKingBenefitResultView:unbindEvents()
	LiYangKingBenefitResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function LiYangKingBenefitResultView:bindEvents()
	LiYangKingBenefitResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function LiYangKingBenefitResultView:buildUI()
	LiYangKingBenefitResultView.super.buildUI(self)

	self._txtResult = self:getTxt("txtResult")
	self._btnSure = self:getGo("btnSure")
end

function LiYangKingBenefitResultView:onExit()
	LiYangKingBenefitResultView.super.onExit(self)
end

function LiYangKingBenefitResultView:onEnter()
	LiYangKingBenefitResultView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 509001
	end

	self._reportInfo = params[2]

	self:_onSetUI()
end

function LiYangKingBenefitResultView:_onSetUI()
	if not self._reportInfo.attLevelUp then
		local attLevelUp = {}
		local kingLevel = LiYangKingController.instance:getCurKingLevel(self._activityId)
		local attrStr = "\n\n经过你的治理,离阳国的"

		for i, pair in ipairs(attLevelUp) do
			attrStr = attrStr .. string.format("%s提升了%d级,", pair.left, pair.right)
		end

		attrStr = attrStr .. string.format("你的国君水平也来到了%d级！", kingLevel)
		self._txtResult.text = string.format("勤劳的国君:\n昨日忙碌的你累计获得了%d个代币,累计花费了%d个代币,财大气粗!%s\n\n昨天你深思熟虑,处理好了%d件政务,无论大小事你都是亲力亲为!\n\n今天也和毛毛一起继续加油吧~", self._reportInfo.gainScore, self._reportInfo.useScore, attrStr, self._reportInfo.finishEvent)
	end
end

function LiYangKingBenefitResultView:_onClickBtnSure()
	LiYangKingController.instance:sendPM_PrinceLiyangInfoReq(self._activityId)
	self:close()
end

return LiYangKingBenefitResultView
