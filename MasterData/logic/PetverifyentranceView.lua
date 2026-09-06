-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petverify/view/PetverifyentranceView.lua

module("logic.extensions.petverify.view.PetverifyentranceView", package.seeall)

local PetverifyentranceView = class("PetverifyentranceView", ViewComponent)

function PetverifyentranceView:ctor()
	PetverifyentranceView.super.ctor(self)
end

function PetverifyentranceView:buildUI()
	PetverifyentranceView.super.buildUI(self)

	self._btnVerify = self:getBtn("btnVerify")
	self._btnVerifyTip = self:getBtn("btnVerifyTip")
	self._txtVerifyEffect = goutil.findChildTextComponent(self.mainGO, "txtVerifyEffect")
	self._imgEffect = Framework.ImageBigBG.GetFrom(self.mainGO, "imgEffect")
	self._txtLv = goutil.findChildTextComponent(self.mainGO, "imgEffect/txtLv")
	self._txtVerifyPower = goutil.findChildTextComponent(self.mainGO, "left/bgleft/txtVerifyPower")
	self._petCell = goutil.findChild(self.mainGO, "iconHead")
	self._bgleftSizeTransform = self:getGo("left/bgleft"):GetComponent("RectTransform")
	self._goPet1 = self:getGo("left/bgleft/pet1")
	self._petCell_1_1 = goutil.findChild(self._goPet1, "cell")
	self._goPet2 = self:getGo("left/bgleft/pet2")
	self._petCell_2_1 = goutil.findChild(self._goPet2, "cell1")
	self._petCell_2_2 = goutil.findChild(self._goPet2, "cell2")
	self._goPet3 = self:getGo("left/bgleft/pet3")
	self._petCell3 = self:getGo("left/bgleft/pet3/cell")
	self._scrollPet3 = self:getGo("left/bgleft/pet3/scroll")
	self._pet3Tableview = ScrollerList.create(self._scrollPet3, self._petCell3, GameUtil.handler(self._updatePet3Cell, self))
	self._txtDes = goutil.findChildTextComponent(self.mainGO, "txtDes")
	self._txtContent = goutil.findChildTextComponent(self.mainGO, "bubble/txtDesc")
end

function PetverifyentranceView:bindEvents()
	PetverifyentranceView.super.bindEvents(self)
	self._btnVerify:AddClickListener(self._onClickVerify, self)
	self._btnVerifyTip:AddClickListener(self._onClickVerifyTip, self)
end

function PetverifyentranceView:unbindEvents()
	PetverifyentranceView.super.unbindEvents(self)
	self._btnVerify:RemoveClickListener()
	self._btnVerifyTip:RemoveClickListener()
end

function PetverifyentranceView:destroyUI()
	PetverifyentranceView.super.destroyUI(self)
end

function PetverifyentranceView:onEnter()
	PetverifyentranceView.super.onEnter(self)

	self.planId = self:getFirstParam()

	GlobalDispatcher:addListener(GlobalNotify.PetVerifySuccess, self._refresh, self)

	self.cbFlag = PetverifyController.instance:getVerifyInfo(self.planId, GameUtil.handler(self._refresh, self))
end

function PetverifyentranceView:onEnterFinished()
	PetverifyentranceView.super.onEnterFinished(self)
end

function PetverifyentranceView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.PetVerifySuccess, self._refresh, self)
	MaterialMgr.resetAll(self._petCell_1_1)
	MaterialMgr.resetAll(self._petCell_2_1)
	MaterialMgr.resetAll(self._petCell_2_2)
	self._imgEffect:ClearImage()
	PetverifyentranceView.super.onExit(self)
	PetverifyController.instance:rmVerifyInfoCallback(self.cbFlag)
	self._pet3Tableview:dispose()
end

function PetverifyentranceView:onExitFinished()
	PetverifyentranceView.super.onExitFinished(self)
end

function PetverifyentranceView:_refresh()
	local planId = self.planId
	local info = PetverifyController.instance:getInfo(planId)
	local higestVerifiedZdl = info.verifyValue
	local bossBuff = ""
	local plans = PetVerifyBuffConfig.instance:getBuffListById(planId)
	local verifyCfg = PetverifyController.instance:getCurrPlanBuff(planId)

	if verifyCfg then
		local color = "60ee85"
		local verifyName = string.format(verifyCfg.name, color)
		local verifyDes = string.format(verifyCfg.des, color)

		self._txtVerifyEffect.text = string.format("%s \n%s", verifyName, verifyDes)
		self._txtLv.text = string.format("Lv.%d", verifyCfg.level)
		bossBuff = verifyCfg.buffId

		local color = "11a568"
		local verifyDes = string.format(verifyCfg.des, color)

		self._txtContent.text = string.format("战斗鼓舞%d级！\n%s！\n自阵战力大幅提升！", verifyCfg.level, verifyDes)
	else
		self._txtVerifyEffect.text = "未激活鼓舞"
		self._txtLv.text = "Lv.0"
		bossBuff = plans[1].buffId
		self._txtContent.text = "战斗鼓舞<color=#11a568>0级</color>！\n验证精灵\n可大幅提升战力喔！"
	end

	local tempStr = string.split(bossBuff, ":")
	local buffId = tempStr[1]
	local buffIcon = BattleConfig.instance:getBuffCo(tonumber(buffId))

	if buffIcon then
		self._imgEffect:SetImage(GameUrl.getExpEventUrl(buffIcon.icon))
	end

	local verifyPlan = PetVerifyBuffConfig.instance:getPlanCfgById(planId)
	local validator = verifyPlan.validator
	local raceIds = string.split(validator, ",")
	local raceIdsList = {}

	for k, v in ipairs(raceIds) do
		table.insert(raceIdsList, checknumber(v))
	end

	GameUtil.SetActive(self._goPet1, #raceIdsList == 1)
	GameUtil.SetActive(self._goPet2, #raceIdsList == 2)
	GameUtil.SetActive(self._goPet3, #raceIdsList >= 3)

	if #raceIdsList == 1 then
		local raceId = raceIdsList[1]

		MaterialMgr.setCell(MatType.Pet, raceId, self._petCell_1_1)

		self._bgleftSizeTransform.sizeDelta = Vector2.New(250, self._bgleftSizeTransform.sizeDelta.y)
	elseif #raceIdsList == 2 then
		local raceId1 = raceIdsList[1]

		MaterialMgr.setCell(MatType.Pet, raceId1, self._petCell_2_1)

		local raceId2 = raceIdsList[2]

		MaterialMgr.setCell(MatType.Pet, raceId2, self._petCell_2_2)

		self._bgleftSizeTransform.sizeDelta = Vector2.New(280, self._bgleftSizeTransform.sizeDelta.y)
	elseif #raceIdsList >= 3 then
		self._pet3Tableview:reloadData(raceIdsList)

		self._bgleftSizeTransform.sizeDelta = Vector2.New(320, self._bgleftSizeTransform.sizeDelta.y)
	end

	self._txtVerifyPower.text = string.format("已验证最佳%s：%d", verifyPlan.typeShow, higestVerifiedZdl)

	local maxIdx = #plans
	local levellastDes = plans[maxIdx].des
	local maxLevel = plans[maxIdx].level
	local color = "20b376"
	local afterStr = string.format(levellastDes, color)

	self._txtDes.text = string.format("验证精灵，获得战斗鼓舞。\n达<color=#20b376>%d级</color>鼓舞难度大幅降低，\n我方", maxLevel) .. "<color=#20b376>" .. afterStr .. "</color>"
end

function PetverifyentranceView:_onClickVerifyTip()
	UIStateManager.instance:push(ViewName.PetverifytipView, self.planId)
end

function PetverifyentranceView:_onClickVerify()
	UIStateManager.instance:push(ViewName.PetverifyView, self.planId)
end

function PetverifyentranceView:_updatePet3Cell(view, cell, data)
	MaterialMgr.setCell(MatType.Pet, data, cell)
end

return PetverifyentranceView
