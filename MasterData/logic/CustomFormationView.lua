-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/customfmt/view/CustomFormationView.lua

module("logic.extensions.customfmt.view.CustomFormationView", package.seeall)

local CustomFormationView = class("CustomFormationView", FormationView)

function CustomFormationView:unbindEvents()
	CustomFormationView.super.unbindEvents(self)
	self._backButton:RemoveClickListener()
	self._saveButton:RemoveClickListener()
	self._oneKeyBtn:RemoveClickListener()
	self._cleanBtn:RemoveClickListener()
	self._btnSetDefense:RemoveClickListener()
end

function CustomFormationView:bindEvents()
	CustomFormationView.super.bindEvents(self)
	self._backButton:AddClickListener(self._onClickClose, self)
	self._saveButton:AddClickListener(self._onClickSave, self)
	self._oneKeyBtn:AddClickListener(self._onClickOneKey, self)
	self._cleanBtn:AddClickListener(self._onClickClean, self)
	self._btnSetDefense:AddClickListener(self._onClickbtnSetDefense, self)
end

function CustomFormationView:buildUI()
	CustomFormationView.super.buildUI(self)

	self._saveRoot = self:getGo("saveRoot")

	goutil.setActive(self._saveRoot, false)

	self._oneKeyBtn = Framework.ButtonAdapter.GetFrom(self.mainGO, "Nego_Left/Btn_OneKey")
	self._cleanBtn = Framework.ButtonAdapter.GetFrom(self.mainGO, "Nego_Left/Btn_Clean")

	goutil.setActive(self._btnRecFormation.gameObject, false)
	goutil.setActive(self._btnShare.gameObject, false)
	self._btnSingleLine:Layout()

	self._extension = self:getGo("extension")
end

function CustomFormationView:onExit()
	CustomFormationView.super.onExit(self)
	self.customFmtMo:sendSaveMsg()
end

function CustomFormationView:onEnter()
	self.customFmtMo = self:getFirstParam()

	goutil.setActive(self._saveRoot, self.customFmtMo.isShowBtnSave)
	GameUtil.SetActive(self._BtnPet, self.customFmtMo.isShowPetBag)
	print("<color='#ff00ff'>>>>>###CustomFormationView</color>", self.customFmtMo.__cname)
	self.customFmtMo:updateData()
	self.customFmtMo:initSaveHandler()
	CustomFormationView.super.onEnter(self)

	local extViewName = self.customFmtMo:getFormationExtendViewName()

	if not string.nilorempty(extViewName) then
		self:showTabAt(self._extension, extViewName, self.customFmtMo)
	end

	FastFormation.instance:setCurFormFunc(function()
		return self:_getCurFormation()
	end)
	FastFormation.instance:setGetCurPetList(function()
		return self.customFmtMo:getAllShowPetList()
	end)
	self._tipObj.gameObject:SetActive(false)

	if not string.nilorempty(self.customFmtMo.formationTips) then
		self._tipObj.gameObject:SetActive(true)

		self._tipObj.text = self.customFmtMo.formationTips
	end

	self:_onValidateUI()
end

function CustomFormationView:_onClickSave()
	self.customFmtMo:sendSaveMsg(true)
end

function CustomFormationView:_onClickClose()
	if not self.customFmtMo:isClickCanCloseInFomation() then
		return
	end

	local handler = GameUtil.handler(CustomFormationView.super._onClickClose, self)

	self.customFmtMo:onClickCloseBtn(handler)
end

function CustomFormationView:_getCurFormation()
	return (self.customFmtMo:getCurFormation())
end

function CustomFormationView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
	FastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey(), GameUtil.handler(self.notFilterPet, self), function(posList, petPool)
		local needPets = FastFormation.instance.needPets

		posList, petPool = self.customFmtMo:getFinalFmoList(posList, petPool, needPets)

		return posList, petPool
	end)
	MissionModel.instance:setForceResetOneKey(false)
end

function CustomFormationView:notFilterPet(petMo)
	local forbit = self.customFmtMo:checkPetIsForbit(petMo)

	if forbit then
		return false
	end

	return true
end

function CustomFormationView:_onClickClean()
	local fixedPosDic = MissionModel.instance:getFixedPos()

	FastFormation.instance:clean(fixedPosDic)
end

function CustomFormationView:_onValidateUI()
	if self.customFmtMo then
		GameUtil.SetActive(self._oneKeyBtn.gameObject, self.customFmtMo.isShowOneKey)
		GameUtil.SetActive(self._cleanBtn.gameObject, self.customFmtMo.isShowClean)
		GameUtil.SetActive(self._btnSetDefense.gameObject, self.customFmtMo.showSetDefense)
		self._btnSingleLine:Layout()
	end
end

function CustomFormationView:_onClickbtnSetDefense()
	self.customFmtMo:onBeforeSetDefenseFmt()
	UIStateManager.instance:push(ViewName.FormationsetdefenseView)
end

function CustomFormationView:_onClickPet()
	if self.customFmtMo:checkIsCanJumpOut() then
		CustomFormationView.super._onClickPet(self)
	else
		self.customFmtMo:showIsNotCanJumpOutTip()
	end
end

function CustomFormationView:_maxPetNum()
	return self.customFmtMo.needUpPetCount
end

return CustomFormationView
