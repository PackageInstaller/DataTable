-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/challenge/view/challengescoreview/ClgScoreView.lua

module("logic.extensions.challenge.view.challengescoreview.ClgScoreView", package.seeall)

local ClgScoreView = class("ClgScoreView", ViewComponent)

function ClgScoreView:ctor()
	ClgScoreView.super.ctor(self)
end

function ClgScoreView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._maskButton:AddClickListener(self._onClickClose, self)

	for i = 1, 3 do
		self._btns[i]:AddClickListener(function()
			self:_onClickBtn(i)
		end, self)
	end
end

function ClgScoreView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._maskButton:RemoveClickListener()
end

function ClgScoreView:buildUI()
	self._closeButton = self:getBtn("Close")
	self._maskButton = self:getBtn("Mask")
	self._titleTxt = self:getGo("TxtTitle"):GetComponent("Text")
	self._msgTxt = self:getGo("TxtMsg"):GetComponent("Text")
	self._btns = {}

	for i = 1, 3 do
		self._btns[i] = self:getBtn("Btns/Btn" .. i)
	end
end

function ClgScoreView:destroyUI()
	self._btns = nil
end

function ClgScoreView:onEnter()
	local passed = self._viewPresentor._openParam[1]
	local msg = self._viewPresentor._openParam[2]

	self._funcs = self._viewPresentor._openParam[3]
	self._btnTxts = self._viewPresentor._openParam[4]
	self._titleTxt.text = passed and lang("挑战成功") or lang("挑战失败")
	self._msgTxt.text = msg

	for i = 1, 3 do
		local btnGo = self._btns[i].gameObject
		local txt = goutil.findChild(btnGo, "Text"):GetComponent("Text")

		if self._btnTxts[i] then
			btnGo:SetActive(true)

			txt.text = self._btnTxts[i]
		else
			btnGo:SetActive(false)
		end
	end
end

function ClgScoreView:onEnterFinished()
	return
end

function ClgScoreView:onExit()
	return
end

function ClgScoreView:onExitFinished()
	return
end

function ClgScoreView:_onClickClose()
	UIStateManager.instance:popByName(self._viewPresentor.viewName)
	BattleFacade.instance:endBattle()
end

function ClgScoreView:_onClickBtn(index)
	if self._funcs and self._funcs[index] then
		self._funcs[index](self)
	end
end

return ClgScoreView
