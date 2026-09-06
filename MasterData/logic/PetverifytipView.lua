-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petverify/view/PetverifytipView.lua

module("logic.extensions.petverify.view.PetverifytipView", package.seeall)

local PetverifytipView = class("PetverifytipView", ViewComponent)

function PetverifytipView:ctor()
	PetverifytipView.super.ctor(self)
end

function PetverifytipView:buildUI()
	PetverifytipView.super.buildUI(self)

	self._content = self:getGo("content")
	self._verifyCell = self:getGo("verifyCell")
	self.btnOk = self:getBtn("btnOk")
	self._txtDes = goutil.findChildTextComponent(self.mainGO, "txtTitle2")
	self.ScrollView = self:getGo("ScrollView")
	self.scrollList = ScrollerList.create(self.ScrollView, self._verifyCell, GameUtil.handler(self.updateCell, self))
	self._cellList = {}
end

function PetverifytipView:bindEvents()
	PetverifytipView.super.bindEvents(self)
	self.btnOk:AddClickListener(self.close, self)
end

function PetverifytipView:unbindEvents()
	PetverifytipView.super.unbindEvents(self)
	self.btnOk:RemoveClickListener()
end

function PetverifytipView:destroyUI()
	PetverifytipView.super.destroyUI(self)
end

function PetverifytipView:onEnter()
	PetverifytipView.super.onEnter(self)

	self.planId = self:getFirstParam()
	self.cbFlag = PetverifyController.instance:getVerifyInfo(self.planId, GameUtil.handler(self._refresh, self))
end

function PetverifytipView:onEnterFinished()
	PetverifytipView.super.onEnterFinished(self)
end

function PetverifytipView:onExit()
	PetverifytipView.super.onExit(self)
	PetverifyController.instance:rmVerifyInfoCallback(self.cbFlag)
	self.scrollList:dispose()
end

function PetverifytipView:onExitFinished()
	PetverifytipView.super.onExitFinished(self)
end

function PetverifytipView:_refresh()
	local planId = self.planId
	local verifyCfg = PetverifyController.instance:getCurrPlanBuff(planId)

	if verifyCfg then
		self._curLevel = verifyCfg.level
	end

	local plansArr = PetVerifyBuffConfig.instance:getBuffListById(planId)

	self.scrollList:reloadData(plansArr)

	local index = 1

	if plansArr and #plansArr > 5 then
		for i = 1, #plansArr do
			if plansArr[i] and plansArr[i].level == self._curLevel then
				index = i

				break
			end
		end
	end

	if index > 5 then
		self.scrollList:MoveCellInView(index, false)
	end

	local verifyPlan = PetVerifyBuffConfig.instance:getPlanCfgById(planId)

	self._txtDes.text = string.format("验证精灵%s达", verifyPlan.typeShow)
end

function PetverifytipView:_setCell(cell, verifyCfg, isOpen)
	GameUtil.SetActive(cell, true)

	local goBG = goutil.findChild(cell, "onBg")

	goBG.gameObject:SetActive(verifyCfg.level == self._curLevel)

	local txtPower = goutil.findChildTextComponent(cell, "txtPower")

	txtPower.text = tostring(verifyCfg.target)

	local txtVerifyEffect = goutil.findChildTextComponent(cell, "txtVerifyEffect")
	local color = "60ee85"
	local verifyName = string.format(verifyCfg.name, color)
	local verifyDes = string.format(verifyCfg.des, color)

	txtVerifyEffect.text = string.format("%s     %s", verifyName, verifyDes)

	local txtRcPower = goutil.findChildTextComponent(cell, "txtRcPower")

	txtRcPower.text = verifyCfg.zdl
end

function PetverifytipView:updateCell(view, cell, data)
	self:_setCell(cell, data)
end

return PetverifytipView
