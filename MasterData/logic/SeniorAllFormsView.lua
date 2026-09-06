-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seniorarena/view/SeniorAllFormsView.lua

module("logic.extensions.seniorarena.view.SeniorAllFormsView", package.seeall)

local SeniorAllFormsView = class("SeniorAllFormsView", ViewComponent)

function SeniorAllFormsView:unbindEvents()
	SeniorAllFormsView.super.unbindEvents(self)
	self._btnOk:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnSwapTop:RemoveClickListener()
	self._btnSwapBom:RemoveClickListener()
end

function SeniorAllFormsView:bindEvents()
	SeniorAllFormsView.super.bindEvents(self)
	self._btnOk:AddClickListener(self._onClickOk, self)
	self._btnClose:AddClickListener(self._onClickOk, self)
	self._btnSwapTop:AddClickListener(self._onClickSwapTop, self)
	self._btnSwapBom:AddClickListener(self._onClickSwapBom, self)
end

function SeniorAllFormsView:buildUI()
	SeniorAllFormsView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnOk = self:getBtn("btnOk")
	self._players = self:getGo("players")
	self._btnSwapTop = self:getBtn("btnSwapTop")
	self._btnSwapBom = self:getBtn("btnSwapBom")
end

function SeniorAllFormsView:onExit()
	SeniorAllFormsView.super.onExit(self)

	self._formIdxs = nil
end

function SeniorAllFormsView:onEnter()
	SeniorAllFormsView.super.onEnter(self)

	self._formIdxs = {
		1,
		2,
		3
	}
end

function SeniorAllFormsView:_onClickOk()
	local isChange = false

	for i = 1, 3 do
		if self._formIdxs[i] ~= i then
			isChange = true

			break
		end
	end

	if isChange then
		SeniorArenaController.instance:swapCacheForms(self._formIdxs)
	end

	self:close()
end

function SeniorAllFormsView:_onClickSwapBom()
	self:_swapForm(2, 3)
end

function SeniorAllFormsView:_onClickSwapTop()
	self:_swapForm(1, 2)
end

function SeniorAllFormsView:_swapForm(idx1, idx2)
	self._formIdxs[idx1] = self._formIdxs[idx2]
	self._formIdxs[idx2] = self._formIdxs[idx1]

	local leftPlayer = self._players.transform:GetChild(0)
	local forms = goutil.findChild(leftPlayer.gameObject, "forms")
	local form1 = forms.transform:GetChild(idx1 - 1)
	local form2 = forms.transform:GetChild(idx2 - 1)
	local pets1 = goutil.findChild(form1.gameObject, "formations")
	local pets2 = goutil.findChild(form2.gameObject, "formations")
	local txtTotalForce1 = goutil.findChildTextComponent(form1, "txtTotalForce")
	local txtTotalForce2 = goutil.findChildTextComponent(form2, "txtTotalForce")

	txtTotalForce1.text = txtTotalForce2.text
	txtTotalForce2.text = txtTotalForce1.text

	goutil.addChildToParent(pets1, form2)
	goutil.addChildToParent(pets2, form1)
end

return SeniorAllFormsView
