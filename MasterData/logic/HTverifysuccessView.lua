-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/herotrial/view/HTverifysuccessView.lua

module("logic.extensions.herotrial.view.HTverifysuccessView", package.seeall)

local HTverifysuccessView = class("HTverifysuccessView", ViewComponent)

HTverifysuccessView.VerifyType = {
	success = 1,
	exceed = 3,
	fail = 2,
	empty = 4
}

function HTverifysuccessView:ctor()
	HTverifysuccessView.super.ctor(self)
end

function HTverifysuccessView:buildUI()
	HTverifysuccessView.super.buildUI(self)

	self._goOn = goutil.findChild(self.mainGO, "on")
	self._goOff = goutil.findChild(self.mainGO, "off")
	self._txtContent = goutil.findChildTextComponent(self.mainGO, "off/txtContent")
	self._txtPower = goutil.findChildTextComponent(self.mainGO, "power/txtPower")
	self._txtVerifyEffect = goutil.findChildTextComponent(self.mainGO, "on/txtVerifyEffect")
	self._btnOk = self:getBtn("btnOk")
	self.imgEffect = Framework.ImageBigBG.GetFrom(self.mainGO, "on/iconHead")
end

function HTverifysuccessView:bindEvents()
	HTverifysuccessView.super.bindEvents(self)
	self._btnOk:AddClickListener(self._onClickOk, self)
end

function HTverifysuccessView:unbindEvents()
	HTverifysuccessView.super.unbindEvents(self)
	self._btnOk:RemoveClickListener()
end

function HTverifysuccessView:destroyUI()
	HTverifysuccessView.super.destroyUI(self)
end

function HTverifysuccessView:onEnter()
	HTverifysuccessView.super.onEnter(self)

	self.verifyType = nil

	local exceed = self:getOpenParam()[1]
	local success = self:getOpenParam()[2]
	local plan = HerotrialController.instance:getCurVerifyPlan()

	self.verifyType = plan and (exceed and (success and HTverifysuccessView.VerifyType.success or HTverifysuccessView.VerifyType.exceed) or HTverifysuccessView.VerifyType.fail) or HTverifysuccessView.VerifyType.empty

	self:_refresh()
end

function HTverifysuccessView:onEnterFinished()
	HTverifysuccessView.super.onEnterFinished(self)
end

function HTverifysuccessView:onExit()
	self.imgEffect:ClearImage()
	HTverifysuccessView.super.onExit(self)
end

function HTverifysuccessView:onExitFinished()
	HTverifysuccessView.super.onExitFinished(self)
end

function HTverifysuccessView:_refresh()
	local petId = self:getOpenParam()[3]
	local torf, nextPower = HerotrialController.instance:getIfCanVerify(petId)
	local petMo = BagPetsController.instance:getPet(petId)
	local power = FightingPowerFormula.instance:getPetFightingPowerByPetMo(petMo)
	local higestVerifiedZdl = HerotrialModel.instance:getHigestVerifiedZdl()
	local verifyCfg = HerotrialController.instance:getCurVerifyPlan(higestVerifiedZdl)

	self._txtPower.text = power

	if self.verifyType == HTverifysuccessView.VerifyType.success then
		GameUtil.SetActive(self._goOn, true)
		GameUtil.SetActive(self._goOff, false)

		local color = "11a568"
		local verifyName = string.format(verifyCfg.name, color)
		local verifyDes = string.format(verifyCfg.des, color)

		self._txtVerifyEffect.text = string.format("%s \n%s", verifyName, verifyDes)

		local activityId = HerotrialModel.instance:getActivityId()
		local plans = HerotrialConfig.instance:getVerifyPlans(activityId)
		local tempStr = string.split((verifyCfg or nil) and verifyCfg.bossBuff, ":")
		local buffId = tempStr[1]
		local buffIcon = BattleConfig.instance:getBuffCo(tonumber(buffId))

		self.imgEffect:SetImage(GameUrl.getExpEventUrl(buffIcon.icon))
	elseif self.verifyType == HTverifysuccessView.VerifyType.fail then
		GameUtil.SetActive(self._goOn, false)
		GameUtil.SetActive(self._goOff, true)

		self._txtContent.text = "本次验证战力等于低于原记录，战斗鼓舞等级不变"
	elseif self.verifyType == HTverifysuccessView.VerifyType.exceed then
		GameUtil.SetActive(self._goOn, false)
		GameUtil.SetActive(self._goOff, true)

		self._txtContent.text = "本次验证战力未达下一档鼓舞等级所需战力，战斗鼓舞等级不变"
	elseif self.verifyType == HTverifysuccessView.VerifyType.empty then
		GameUtil.SetActive(self._goOn, false)
		GameUtil.SetActive(self._goOff, true)

		local diff = nextPower - power

		self._txtContent.text = "距离战斗鼓舞等级1级还差" .. diff .. "战力"
	end
end

function HTverifysuccessView:_onClickOk()
	self:close()
end

return HTverifysuccessView
