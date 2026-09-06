-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pickapet/view/PickResultView.lua

module("logic.extensions.pickapet.view.PickResultView", package.seeall)

local PickResultView = class("PickResultView", ViewComponent)

function PickResultView:ctor()
	PickResultView.super.ctor(self)

	self._success = false
end

function PickResultView:bindEvents()
	self._closeButton:AddClickListener(self._onRealClickClose, self)
	self._Btn_Great:AddClickListener(self._onClickClose, self)
	self._Btn_Over:AddClickListener(self._onClickClose, self)
	self._Btn_Continue:AddClickListener(self._onClickContinue, self)
end

function PickResultView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._Btn_Great:RemoveClickListener()
	self._Btn_Over:RemoveClickListener()
	self._Btn_Continue:RemoveClickListener()
end

function PickResultView:buildUI()
	self._closeButton = self:getBtn("Main/btnClose")
	self._Btn_Great = self:getBtn("Btn_Great")
	self._Btn_Over = self:getBtn("Btn_Over")
	self._Btn_Continue = self:getBtn("Btn_Continue")
	self._Txt_target = self:getTxt("img1/Txt_target")
	self._Txt_targetNum = self:getGo("img1/Txt_targetNum"):GetComponent(goutil.Type_UIText)
	self._txtNum2 = self:getGo("img2/txtNum2"):GetComponent(goutil.Type_UIText)
	self._img2 = self:getGo("img2")
end

function PickResultView:destroyUI()
	return
end

function PickResultView:onEnter()
	self.callBack = self._viewPresentor._openParam[2]
	self._gameType = PickAPetModel.instance:getGameType()
	self._success = self._viewPresentor:getFirstParam()

	self._Btn_Continue.gameObject:SetActive(true)
	self._Btn_Over.gameObject:SetActive(true)
	self._Btn_Great.gameObject:SetActive(true)

	if self._success then
		self._Btn_Continue.gameObject:SetActive(false)
		self._Btn_Over.gameObject:SetActive(false)
	else
		self._Btn_Great.gameObject:SetActive(false)
	end

	goutil.setActive(self._img2, self._gameType == PickAPetModel.GameType.QianNiaoZhenShen)
	self:_setText()
end

function PickResultView:_setText()
	local currentNum = PickAPetModel.instance:getCollect()

	self._Txt_targetNum.text = currentNum

	local pickAPetInfo = PickAPetModel.instance:getDataCls()
	local desc = pickAPetInfo:getViewDesc() .. "："

	self._Txt_target.text = desc

	if self._gameType == PickAPetModel.GameType.QianNiaoZhenShen then
		self._Txt_target.text = desc

		local collectNums = PickAPetModel.instance:getInitCollectNums()

		self._txtNum2.text = currentNum + collectNums[1] .. "/" .. collectNums[2]
	end
end

function PickResultView:onEnterFinished()
	return
end

function PickResultView:onExit()
	return
end

function PickResultView:onExitFinished()
	return
end

function PickResultView:_onClickClose()
	if not self._success then
		self._Btn_Continue.gameObject:SetActive(false)
		self._Btn_Over.gameObject:SetActive(false)
		self._Btn_Great.gameObject:SetActive(true)

		self._success = true

		return
	end

	local gameType = PickAPetModel.instance:getGameType()

	PickAPetModel.instance:onGameOverCallback(function()
		self:_defaultClose()
	end)
end

function PickResultView:_defaultClose()
	self:close()
	GameUtil.callBack(self.callBack)
end

function PickResultView:_onClickContinue()
	GlobalDispatcher:dispatch(GlobalNotify.PickPause, false)
	self:close()
end

function PickResultView:_onRealClickClose()
	if not self._success then
		self:_onClickContinue()
	else
		self:_onClickClose()
	end
end

return PickResultView
