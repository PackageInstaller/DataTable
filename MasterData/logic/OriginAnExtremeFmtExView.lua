-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originan/view/OriginAnExtremeFmtExView.lua

module("logic.extensions.originan.view.OriginAnExtremeFmtExView", package.seeall)

local OriginAnExtremeFmtExView = class("OriginAnExtremeFmtExView", ViewComponent)

function OriginAnExtremeFmtExView:buildUI()
	OriginAnExtremeFmtExView.super.buildUI(self)

	self._fmt = self:getGo("fmt")
	self._fmtView = self:getGo("fmt/view")
	self._btnTip = self:getGo("btnTip")
end

function OriginAnExtremeFmtExView:bindEvents()
	OriginAnExtremeFmtExView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTips, self)
end

function OriginAnExtremeFmtExView:unbindEvents()
	OriginAnExtremeFmtExView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
end

function OriginAnExtremeFmtExView:onEnter()
	OriginAnExtremeFmtExView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._fmtMo = params[1]
	self._activityId = self._fmtMo:getActivityId()
	self._subMo = OriginAnController.instance:getSubMo(self._activityId)

	GameUtil.SetActive(self._fmt, true)
	self:_onUpdate()
end

function OriginAnExtremeFmtExView:onExit()
	OriginAnExtremeFmtExView.super.onExit(self)
end

function OriginAnExtremeFmtExView:_onUpdate()
	local dizzyCounts = {}

	for posId = 1, 9 do
		dizzyCounts[posId] = self._subMo:getDizzyCountExtreme(posId)
	end

	local childCount = self._fmtView.transform.childCount

	for index = 1, childCount do
		local count = checknumber(dizzyCounts[index])
		local mainGo = self._fmtView.transform:GetChild(index - 1).gameObject
		local txtCount = goutil.findChildTextComponent(mainGo, "txtCount")

		txtCount.text = count

		GameUtil.SetActive(txtCount.gameObject, count > 0)
	end
end

function OriginAnExtremeFmtExView:_onClickBtnTips()
	GameUtil.SetActive(self._fmt, not GameUtil.GetActive(self._fmt))
end

return OriginAnExtremeFmtExView
