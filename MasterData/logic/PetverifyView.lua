-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petverify/view/PetverifyView.lua

module("logic.extensions.petverify.view.PetverifyView", package.seeall)

local PetverifyView = class("PetverifyView", ViewComponent)

function PetverifyView:ctor()
	PetverifyView.super.ctor(self)
end

function PetverifyView:buildUI()
	PetverifyView.super.buildUI(self)

	self.btnClose = self:getBtn("btnClose")
	self.btnVerify = self:getBtn("btnVerify")
	self._content = self:getGo("content")
	self._verifyCell = self:getGo("verifyCell")
	self.ScrollView = self:getGo("ScrollView")
	self.scrollList = ScrollerList.create(self.ScrollView, self._verifyCell, GameUtil.handler(self.updateCell, self))
	self._txtVerifyEffect = goutil.findChildTextComponent(self.mainGO, "curEffect/txtVerifyEffect")
	self._txtTitle2 = goutil.findChildTextComponent(self.mainGO, "txtTitle2")
	self._imgEffect = Framework.ImageBigBG.GetFrom(self.mainGO, "curEffect/imgEffect")
	self._txtPower = goutil.findChildTextComponent(self.mainGO, "pet/txtPower")
	self._txtPetNum = goutil.findChildTextComponent(self.mainGO, "pet/txtPetNum")
	self._cellList = {}
	self._goPet1 = self:getGo("pet/pet1")
	self._petCell_1_1 = goutil.findChild(self._goPet1, "cell")
	self._goPet2 = self:getGo("pet/pet2")
	self._petCell_2_1 = goutil.findChild(self._goPet2, "cell1")
	self._petCell_2_2 = goutil.findChild(self._goPet2, "cell2")
	self._goPet3 = self:getGo("pet/pet3")
	self._petCell3 = self:getGo("pet/pet3/cell")
	self._scrollPet3 = self:getGo("pet/pet3/scroll")
	self._pet3Tableview = ScrollerList.create(self._scrollPet3, self._petCell3, GameUtil.handler(self._updatePet3Cell, self))
	self._imgTitle = goutil.findChildComponent(self.mainGO, "title/imgTitle", "UIImageSpriteChange")
	self._txtTip = goutil.findChildTextComponent(self.mainGO, "txtTip")
end

function PetverifyView:bindEvents()
	PetverifyView.super.bindEvents(self)
	self.btnClose:AddClickListener(self.close, self)
	self.btnVerify:AddClickListener(self._onAddPet, self)
end

function PetverifyView:unbindEvents()
	PetverifyView.super.unbindEvents(self)
	self.btnClose:RemoveClickListener()
	self.btnVerify:RemoveClickListener()
end

function PetverifyView:destroyUI()
	PetverifyView.super.destroyUI(self)
end

function PetverifyView:onEnter()
	PetverifyView.super.onEnter(self)

	self._curLevel = 0

	GlobalDispatcher:addListener(GlobalNotify.PetVerifySuccess, self._refresh, self)

	self.planId = self:getFirstParam()
	self.cbFlag = PetverifyController.instance:getVerifyInfo(self.planId, GameUtil.handler(self._refresh, self))
end

function PetverifyView:onEnterFinished()
	PetverifyView.super.onEnterFinished(self)
end

function PetverifyView:onExit()
	PetverifyView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PetVerifySuccess, self._refresh, self)
	self._imgEffect:ClearImage()
	PetverifyController.instance:rmVerifyInfoCallback(self.cbFlag)
	self.scrollList:dispose()
end

function PetverifyView:onExitFinished()
	PetverifyView.super.onExitFinished(self)
end

function PetverifyView:_refresh()
	local planId = self.planId
	local verifyPlan = PetVerifyBuffConfig.instance:getPlanCfgById(planId)
	local verifyPlanType = verifyPlan.typeShow
	local info = PetverifyController.instance:getInfo(planId)
	local higestVerifiedZdl = info.verifyValue
	local bossBuff = ""
	local plans = PetVerifyBuffConfig.instance:getBuffListById(planId)
	local verifyCfg = PetverifyController.instance:getCurrPlanBuff(planId)

	if verifyCfg then
		self._curLevel = verifyCfg.level

		local color = "11a568"
		local verifyName = langPara(verifyCfg.name, color)
		local verifyDes = langPara(verifyCfg.des, color)

		self._txtVerifyEffect.text = langPara("%s \n%s", verifyName, verifyDes)
		bossBuff = verifyCfg.buffId
		self._txtPower.text = langPara("已验证最佳%s：%d", verifyPlanType, higestVerifiedZdl)
	else
		self._txtVerifyEffect.text = "未激活鼓舞"
		bossBuff = plans[1].buffId
		self._txtPower.text = langPara("未激活鼓舞")
	end

	self.scrollList:reloadData(plans)

	local index = 1
	local isVerify = false

	if plans and #plans > 5 then
		for i = 1, #plans do
			if plans[i] and plans[i].level == self._curLevel then
				index = i
				isVerify = true

				break
			end
		end
	end

	self.scrollList:MoveCellInView(index - 1, false)

	local tempStr = string.split(bossBuff, ":")
	local buffId = tempStr[1]
	local buffIcon = BattleConfig.instance:getBuffCo(tonumber(buffId))

	self._imgEffect:SetImage(GameUrl.getExpEventUrl(buffIcon.icon))

	local validator = verifyPlan.validator
	local raceIds = string.split(validator, ",")
	local raceIdsList = {}

	for k, v in ipairs(raceIds) do
		table.insert(raceIdsList, checknumber(v))
	end

	self._txtPetNum.text = langPara("（可放入%d种精灵验证）", #raceIds)

	GameUtil.SetActive(self._goPet1, #raceIds == 1)
	GameUtil.SetActive(self._goPet2, #raceIds == 2)
	GameUtil.SetActive(self._goPet3, #raceIds >= 3)

	if #raceIdsList == 1 then
		local raceId = raceIdsList[1]

		MaterialMgr.setCell(MatType.Pet, raceId, self._petCell_1_1)
	elseif #raceIdsList == 2 then
		local raceId1 = raceIdsList[1]

		MaterialMgr.setCell(MatType.Pet, raceId1, self._petCell_2_1)

		local raceId2 = raceIdsList[2]

		MaterialMgr.setCell(MatType.Pet, raceId2, self._petCell_2_2)
	elseif #raceIdsList >= 3 then
		self._pet3Tableview:reloadData(raceIdsList)
	end

	self._txtTitle2.text = langPara("验证精灵%s达", verifyPlanType)

	self._imgTitle:SetState(PetverifyController.VERIFYTYPE[verifyPlan.type] - 1)

	self._txtTip.text = langPara("放入精灵验证，获得精灵鼓舞，%s越高鼓舞越强！", verifyPlanType)
end

function PetverifyView:_onAddPet()
	local function onSeletCallBack(petIds, petIdList)
		if petIdList and #petIdList > 0 then
			PetverifyController.instance:sendVerifyPetIds(self.planId, petIdList)
		end
	end

	local planId = self.planId
	local verifyPlan = PetVerifyBuffConfig.instance:getPlanCfgById(planId)
	local validator = verifyPlan.validator
	local raceIds = string.split(validator, ",")
	local raceIdsList = {}

	for k, v in ipairs(raceIds) do
		table.insert(raceIdsList, checknumber(v))
	end

	local function filterFunc(petMo)
		local ret = false

		for k, v in ipairs(raceIdsList) do
			if petMo.raceId == v then
				ret = true
			end
		end

		return ret
	end

	local strTitle = "请选择验证精灵"

	PetSelectController.instance:setOneRaceState()
	PetSelectController.instance:OpenView(#raceIdsList, strTitle, filterFunc, onSeletCallBack, nil)
end

function PetverifyView:_setCell(cell, verifyCfg, isOpen)
	GameUtil.SetActive(cell, true)

	local goBG = goutil.findChild(cell, "onBg")

	goBG.gameObject:SetActive(verifyCfg.level == self._curLevel)

	local txtPower = goutil.findChildTextComponent(cell, "txtPower")

	txtPower.text = tostring(verifyCfg.target)

	local txtVerifyEffect = goutil.findChildTextComponent(cell, "txtVerifyEffect")
	local color = "60ee85"
	local verifyName = langPara(verifyCfg.name, color)
	local verifyDes = langPara(verifyCfg.des, color)

	txtVerifyEffect.text = langPara("%s     %s", verifyName, verifyDes)

	local txtRcPower = goutil.findChildTextComponent(cell, "txtRcPower")

	txtRcPower.text = verifyCfg.zdl
end

function PetverifyView:updateCell(view, cell, data)
	self:_setCell(cell, data)
end

function PetverifyView:_updatePet3Cell(view, cell, data)
	MaterialMgr.setCell(MatType.Pet, data, cell)
end

return PetverifyView
