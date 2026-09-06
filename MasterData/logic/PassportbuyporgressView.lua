-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportbuyporgressView.lua

module("logic.extensions.passport.view.PassportbuyporgressView", package.seeall)

local PassportbuyporgressView = class("PassportbuyporgressView", ViewComponent)

function PassportbuyporgressView:ctor()
	PassportbuyporgressView.super.ctor(self)
end

function PassportbuyporgressView:buildUI()
	PassportbuyporgressView.super.buildUI(self)

	self._closeBtn = self:getBtn("BG/Close")
	self._txt_Title = self:getTxt("BG/txt_Title")
	self._defalutTitle = self._txt_Title.text
	self._m10Btn = self:getBtn("Tip/Marks/BtnM10")
	self._minusBtn = self:getBtn("Tip/Marks/BtnMs")
	self._addBtn = self:getBtn("Tip/Marks/BtnAdd")
	self._a10Btn = self:getBtn("Tip/Marks/BtnA10")
	self._procNumText = self:getInput("Tip/IptItem")
	self._agreeBtn = self:getBtn("Tip/BtnAgree")
	self._cancelBtn = self:getBtn("Tip/BtnCancel")
	self._buyText = goutil.findChildTextComponent(self.mainGO, "Tip/TxtBuy")
	self._supText = goutil.findChildTextComponent(self.mainGO, "Tip/supCountTxt")
	self._supText.text = ""

	GameUtil.SetActive(self._supText, false)

	self.txtDes = self:getGo("Tip/txtDes")

	GameUtil.SetActive(self.txtDes, false)

	self._costCount = self:getTxt("imgCostDiamond/txtNum")
	self._imgIcon1 = self:getGo("imgCostDiamond/img")
	self._curCount = self:getTxt("imgMyDiamond/txtNum")
	self._imgIcon2 = self:getGo("imgMyDiamond/img")
end

function PassportbuyporgressView:bindEvents()
	PassportbuyporgressView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._m10Btn:AddClickListener(function()
		self:_changeNumText(-10)
	end)
	self._minusBtn:AddClickListener(function()
		self:_changeNumText(-1)
	end)
	self._addBtn:AddClickListener(function()
		self:_changeNumText(1)
	end)
	self._a10Btn:AddClickListener(function()
		self:_changeNumText(10)
	end)
	self._procNumText:AddOnValueChanged(self._onValueChanged, self)
	self._agreeBtn:AddClickListener(self._onClickAgree, self)
	self._cancelBtn:AddClickListener(self.close, self)
end

function PassportbuyporgressView:unbindEvents()
	PassportbuyporgressView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._m10Btn:RemoveClickListener()
	self._minusBtn:RemoveClickListener()
	self._addBtn:RemoveClickListener()
	self._a10Btn:RemoveClickListener()
	self._procNumText:RemoveOnValueChanged()
	self._agreeBtn:RemoveClickListener()
	self._cancelBtn:RemoveClickListener()
end

function PassportbuyporgressView:destroyUI()
	PassportbuyporgressView.super.destroyUI(self)
end

function PassportbuyporgressView:onEnter()
	PassportbuyporgressView.super.onEnter(self)

	self._lastNum = -1
	self._params = self:getOpenParam()

	if self._params == nil or #self._params < 2 then
		self:close()

		return
	end

	self._funcCfg = self._params[1]
	self._actCfg = self._params[2]
	self._abletToBuy = self._params[3]
	self._titleName = self._params[4]

	if self._abletToBuy <= 0 then
		self:close()

		return
	end

	self._costNum = self:_getMatNum(self._actCfg.consume)
	self._getNum = checkint(self._actCfg.incProgress)
	self._numMax = math.ceil(self._abletToBuy / self._getNum)
	self._txt_Title.text = not string.nilorempty(self._titleName) and self._titleName or self._defalutTitle

	local matType, matId = MaterialMgr.getMatParams(self._actCfg.consume)

	MaterialMgr.setIcon(self._imgIcon1.gameObject, matType, matId)
	MaterialMgr.setIcon(self._imgIcon2.gameObject, matType, matId)

	self._myMatNums = MaterialModel.instance:getMaterialsNumber(matType, matId)

	if matType == MatType.Diamond or matType == MatType.PayDiamond then
		self._myMatNums = RoleModel.instance:getPayDiamond() + RoleModel.instance:getPresentDiamond()
	end

	self._costNums = self._costNum
	self._curCount.text = self._myMatNums
	self._costCount.text = self._lastNum * self._costNum

	self:_chargeNum(1)
end

function PassportbuyporgressView:onEnterFinished()
	PassportbuyporgressView.super.onEnterFinished(self)
end

function PassportbuyporgressView:onExit()
	PassportbuyporgressView.super.onExit(self)
end

function PassportbuyporgressView:onExitFinished()
	PassportbuyporgressView.super.onExitFinished(self)
end

function PassportbuyporgressView:_changeNumText(delta)
	local num = checkint(self._lastNum) + delta

	self:_chargeNum(num)
end

function PassportbuyporgressView:_onValueChanged(strNum)
	local num = checkint(strNum)

	self:_chargeNum(num)
end

function PassportbuyporgressView:_chargeNum(inputNum)
	local newNum = checkint(inputNum)

	if self._lastNum ~= newNum then
		newNum = Mathf.Clamp(newNum, 0, self._numMax)
		self._lastNum = newNum

		self._procNumText:SetText(tostring(self._lastNum))

		local matName = MaterialMgr.getMaterialsNameByCfg(self._actCfg.consume)

		self._buyText.text = langPara(self._funcCfg.buyTips, matName, self._lastNum * self._costNum, self._lastNum * self._getNum)
		self._costCount.text = self._lastNum * self._costNum
	end
end

function PassportbuyporgressView:_onClickAgree()
	if checkint(self._lastNum) > 0 then
		local info = PassportModel.instance:getInfo(self._funcCfg.id)
		local type, id = MaterialMgr.getMatParams(self._actCfg.consume)

		if not MaterialFacade.instance:checkMatEnough(type, id, self._lastNum * self._costNum) then
			-- block empty
		else
			self:close()
			PassportController.instance:sendBuyProgressReq(info.actId, info.funcId, checkint(self._lastNum))
		end
	else
		self:close()
	end
end

function PassportbuyporgressView:_getMatNum(matStr)
	local info = string.split(matStr, ":")

	if info == nil or #info == 0 then
		return 0
	end

	return checkint(info[#info])
end

return PassportbuyporgressView
