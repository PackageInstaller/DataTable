-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seniorarena/view/SeniorFormsView.lua

module("logic.extensions.seniorarena.view.SeniorFormsView", package.seeall)

local SeniorFormsView = class("SeniorFormsView", ViewComponent)

function SeniorFormsView:unbindEvents()
	SeniorFormsView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnOk:RemoveClickListener()
end

function SeniorFormsView:bindEvents()
	SeniorFormsView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
	self._btnCancel:AddClickListener(self.close, self)
	self._btnOk:AddClickListener(self._onClickOk, self)
end

function SeniorFormsView:onExit()
	SeniorFormsView.super.onExit(self)

	for _, v in ipairs(self._points) do
		MaterialMgr.resetAll(v)
	end

	self._points = nil

	MaterialMgr.resetAll(self._headPoint)
	SeniorArenaController.instance:clearHandler()
end

function SeniorFormsView:buildUI()
	SeniorFormsView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._btns = self:getGo("verticalLayoutGroup/btns")
	self._player = self:getGo("verticalLayoutGroup/player")
	self._btnOk = self:getBtn("verticalLayoutGroup/btns/btnOk")
	self._btnCancel = self:getBtn("verticalLayoutGroup/btns/btnCancel")
	self._formations = self:getGo("verticalLayoutGroup/formations")
	self._txtName = goutil.findChildTextComponent(self._player, "txtName")
	self._headPoint = goutil.findChild(self._player, "head")
	self._txtPower = goutil.findChildTextComponent(self._player, "txtTotalForce")
	self._txtScore = goutil.findChildTextComponent(self._player, "txtScore")
end

function SeniorFormsView:onEnter()
	self._points = {}

	SeniorFormsView.super.onEnter(self)

	local params = self:getOpenParam()

	self._formMos = params[1]
	self._isDefend = params[2] == true

	local playerMo = params[3]

	self._btns.gameObject:SetActive(playerMo == nil)
	self._player:SetActive(playerMo ~= nil)

	self._txtPower.text = "0"

	GameUtil.updateCellsWithLen(self._formations, 3, self._updateForm, self)

	if playerMo then
		self._txtScore.text = playerMo.score

		HeadItemController.instance:setHeadCellByInfo(self._headPoint, playerMo.headInfo)

		self._txtName.text = playerMo.headInfo.userName
	end
end

function SeniorFormsView:_updateForm(cell, idx)
	local formMo = self._formMos[idx]
	local txtTitle = goutil.findChildTextComponent(cell, "txtTitle")
	local txtForce = goutil.findChildTextComponent(cell, "txtForce")
	local pets = goutil.findChild(cell, "pets")

	txtTitle.text = self._isDefend and "守阵" .. formMo:getFormId() or "攻阵" .. formMo:getFormId()

	local totalPower = formMo:getTotalPower()

	txtForce.text = totalPower
	self._txtPower.text = checknumber(self._txtPower.text) + totalPower

	GameUtil.updateCellsWithLen(pets, 9, function(cell, idx)
		self:_updateOnePet(cell, formMo:getPetMoByIdx(idx), idx)
	end)
end

function SeniorFormsView:_updateOnePet(cell, data, idx)
	local pointPet = goutil.findChild(cell, "pointPet")

	MaterialMgr.resetAll(pointPet)

	if data then
		local proxy = MaterialMgr.setCellByData(MatType.Pet, data, pointPet)

		if proxy then
			proxy.binder:setIconDirection(not self._isDefend)
			proxy.binder:setCallBack(function()
				CommonTipsMgr.instance:showPetTips(data)
			end)
		end
	end

	table.insert(self._points, pointPet)
end

function SeniorFormsView:_onClickOk()
	local ticketCfg = SeniorArenaConfig.instance:getTicketCfg()
	local curNum = MaterialModel.instance:getMaterialsNumber(MatType.Item, ticketCfg.id)

	if curNum <= 0 then
		SeniorArenaController.instance:popBuyTicketWindow()
	else
		SeniorArenaController.instance:reqGetMyAttackForm(self._enterSeniorMissionView, self)
	end
end

function SeniorFormsView:_enterSeniorMissionView()
	SeniorArenaController.instance:setCurFormTab(1)
	SeniorArenaController.instance:initCacheForms(true)
	self:close()

	local fmtMo = SeniorAttackFmtMo.New()

	CustomFmtController.instance:showMissionView(fmtMo)
end

return SeniorFormsView
