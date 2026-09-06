-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/herotrial/view/HTVerifytipView.lua

module("logic.extensions.herotrial.view.HTVerifytipView", package.seeall)

local HTVerifytipView = class("HTVerifytipView", ViewComponent)

function HTVerifytipView:ctor()
	HTVerifytipView.super.ctor(self)
end

function HTVerifytipView:buildUI()
	HTVerifytipView.super.buildUI(self)

	self._content = self:getGo("content")
	self._verifyCell = self:getGo("verifyCell")
	self.btnVerify = self:getBtn("btnOk")
	self._cellList = {}
end

function HTVerifytipView:bindEvents()
	HTVerifytipView.super.bindEvents(self)
	self.btnVerify:AddClickListener(self.close, self)
end

function HTVerifytipView:unbindEvents()
	HTVerifytipView.super.unbindEvents(self)
	self.btnVerify:RemoveClickListener()
end

function HTVerifytipView:destroyUI()
	HTVerifytipView.super.destroyUI(self)
end

function HTVerifytipView:onEnter()
	HTVerifytipView.super.onEnter(self)
	self:_refresh()
end

function HTVerifytipView:onEnterFinished()
	HTVerifytipView.super.onEnterFinished(self)
end

function HTVerifytipView:onExit()
	for k, v in ipairs(self._cellList) do
		goutil.destroy(v)
	end

	table.clear(self._cellList)
	HTVerifytipView.super.onExit(self)
end

function HTVerifytipView:onExitFinished()
	HTVerifytipView.super.onExitFinished(self)
end

function HTVerifytipView:_refresh()
	local activityId = HerotrialModel.instance:getActivityId()
	local higestVerifiedZdl = HerotrialModel.instance:getHigestVerifiedZdl()
	local verifyCfg = HerotrialController.instance:getCurVerifyPlan(higestVerifiedZdl)

	if verifyCfg then
		self._curLevel = verifyCfg.level
	end

	if #self._cellList == 0 then
		local plans = HerotrialConfig.instance:getVerifyPlans(activityId)
		local plansArr = {}

		for k, v in pairs(plans) do
			table.insert(plansArr, v)
		end

		table.sort(plansArr, function(a, b)
			return a.level < b.level
		end)

		for k, v in pairs(plansArr) do
			local cell = goutil.cloneAndSetParent(self._verifyCell, self._content.transform)

			self:_setCell(cell, v, isOpen)
			table.insert(self._cellList, cell)
		end
	end
end

function HTVerifytipView:_setCell(cell, verifyCfg, isOpen)
	GameUtil.SetActive(cell, true)

	local goBG = goutil.findChild(cell, "onBg")

	goBG.gameObject:SetActive(verifyCfg.level == self._curLevel)

	local txtPower = goutil.findChildTextComponent(cell, "txtPower")

	txtPower.text = tostring(verifyCfg.leftZdl)

	local txtVerifyEffect = goutil.findChildTextComponent(cell, "txtVerifyEffect")
	local color = "60ee85"
	local verifyName = string.format(verifyCfg.name, color)
	local verifyDes = string.format(verifyCfg.des, color)

	txtVerifyEffect.text = string.format("%s     %s", verifyName, verifyDes)
end

return HTVerifytipView
