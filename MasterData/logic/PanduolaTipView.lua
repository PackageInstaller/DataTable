-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tlctip/PanduolaTipView.lua

module("logic.extensions.timelimitedchallenge.view.tcpanduola.PanduolaTipView", package.seeall)

local PanduolaTipView = class("PanduolaTipView", TLChallengeTipView)

function PanduolaTipView:buildUI()
	PanduolaTipView.super.buildUI(self)

	self._btnOk = self:getBtn("btnGridLayoutGroup/btnOk")
	self._btnCancel = self:getBtn("btnGridLayoutGroup/btnCancel")
	self._textOk = goutil.findChildTextComponent(self._btnOk.gameObject, "Text")
	self._textCancel = goutil.findChildTextComponent(self._btnCancel.gameObject, "Text")
	self._imgBgSpriteChange = self:getGo("bg"):GetComponent(typeof(UIImageSpriteChange))
end

function PanduolaTipView:onEnter()
	PanduolaTipView.super.onEnter(self)

	local params = self:getFirstParam()

	self._textOk.text = params.okText or "确定"

	self._btnCancel.gameObject:SetActive(params.showCancel)

	self._textCancel.text = "取消"

	if params.bgSpriteName then
		self._imgBgSpriteChange:ChangeSprite(params.bgSpriteName)
	elseif params.imgState ~= nil then
		self._imgBgSpriteChange:SetState(params.imgState)
	else
		self._imgBgSpriteChange:SetState(0)
	end
end

return PanduolaTipView
