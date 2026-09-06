-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petverify/view/PetverifysuccessView.lua

module("logic.extensions.petverify.view.PetverifysuccessView", package.seeall)

local PetverifysuccessView = class("PetverifysuccessView", ViewComponent)

PetverifysuccessView.VerifyType = {
	success = 1,
	exceed = 3,
	fail = 2,
	empty = 4
}

function PetverifysuccessView:ctor()
	PetverifysuccessView.super.ctor(self)
end

function PetverifysuccessView:buildUI()
	PetverifysuccessView.super.buildUI(self)

	self._goOn = goutil.findChild(self.mainGO, "on")
	self._goOff = goutil.findChild(self.mainGO, "off")
	self._txtContent = goutil.findChildTextComponent(self.mainGO, "off/txtContent")
	self._txtPower = goutil.findChildTextComponent(self.mainGO, "power/txtPower")
	self._txtVerifyEffect = goutil.findChildTextComponent(self.mainGO, "on/txtVerifyEffect")
	self._btnOk = self:getBtn("btnOk")
	self.imgEffect = Framework.ImageBigBG.GetFrom(self.mainGO, "on/iconHead")
	self._imgTitle = goutil.findChildComponent(self.mainGO, "imgTitle", "UIImageSpriteChange")
	self._txtPowerTitle = goutil.findChildTextComponent(self.mainGO, "power/txtPowerTitle")
end

function PetverifysuccessView:bindEvents()
	PetverifysuccessView.super.bindEvents(self)
	self._btnOk:AddClickListener(self._onClickOk, self)
end

function PetverifysuccessView:unbindEvents()
	PetverifysuccessView.super.unbindEvents(self)
	self._btnOk:RemoveClickListener()
end

function PetverifysuccessView:destroyUI()
	PetverifysuccessView.super.destroyUI(self)
end

function PetverifysuccessView:onEnter()
	PetverifysuccessView.super.onEnter(self)

	self.verifyType = nil

	local params = self:getOpenParam()

	self.planId = params[1]

	local exceed = params[2]
	local success = params[3]
	local plan = PetverifyController.instance:getCurrPlanBuff(self.planId)

	self.verifyType = plan and (exceed and (success and PetverifysuccessView.VerifyType.success or PetverifysuccessView.VerifyType.exceed) or PetverifysuccessView.VerifyType.fail) or PetverifysuccessView.VerifyType.empty

	self:_refresh()
end

function PetverifysuccessView:onEnterFinished()
	PetverifysuccessView.super.onEnterFinished(self)
end

function PetverifysuccessView:onExit()
	MaterialMgr.resetAll(self._pet)
	self.imgEffect:ClearImage()
	PetverifysuccessView.super.onExit(self)
end

function PetverifysuccessView:onExitFinished()
	PetverifysuccessView.super.onExitFinished(self)
end

function PetverifysuccessView:_refresh()
	local petIds = self:getOpenParam()[4]
	local planId = self.planId
	local verifyPlan = PetVerifyBuffConfig.instance:getPlanCfgById(planId)
	local type = verifyPlan.type
	local typeShow = verifyPlan.typeShow
	local power = PetverifyController.instance:calculateTargetSum(petIds, type)
	local plans = PetVerifyBuffConfig.instance:getBuffListById(planId)
	local verifyCfg = PetverifyController.instance:getCurrPlanBuff(planId)

	self._imgTitle:SetState(PetverifyController.VERIFYTYPE[type] - 1)

	self._txtPower.text = power
	self._txtPowerTitle.text = string.format("验证精灵%s:", verifyPlan.typeShow)

	if self.verifyType == PetverifysuccessView.VerifyType.success then
		GameUtil.SetActive(self._goOn, true)
		GameUtil.SetActive(self._goOff, false)

		local color = "11a568"
		local verifyName = string.format(verifyCfg.name, color)
		local verifyDes = string.format(verifyCfg.des, color)

		self._txtVerifyEffect.text = string.format("%s \n%s", verifyName, verifyDes)

		local tempStr = string.split((verifyCfg or nil) and verifyCfg.buffId, ":")
		local buffId = tempStr[1]
		local buffIcon = BattleConfig.instance:getBuffCo(tonumber(buffId))

		self.imgEffect:SetImage(GameUrl.getExpEventUrl(buffIcon.icon))
	elseif self.verifyType == PetverifysuccessView.VerifyType.fail then
		GameUtil.SetActive(self._goOn, false)
		GameUtil.SetActive(self._goOff, true)

		self._txtContent.text = string.format("本次验证%s未超过原记录，战斗鼓舞等级不变", typeShow)
	elseif self.verifyType == PetverifysuccessView.VerifyType.exceed then
		GameUtil.SetActive(self._goOn, false)
		GameUtil.SetActive(self._goOff, true)

		self._txtContent.text = string.format("本次验证%s未达下一档鼓舞等级所需%s，战斗鼓舞等级不变", typeShow, typeShow)
	elseif self.verifyType == PetverifysuccessView.VerifyType.empty then
		GameUtil.SetActive(self._goOn, false)
		GameUtil.SetActive(self._goOff, true)

		local diff = checknumber((plans and plans[1] or nil) and plans[1].target) - power

		self._txtContent.text = string.format("距离战斗鼓舞等级1级还差%d%s", diff, typeShow)
	end
end

function PetverifysuccessView:_onClickOk()
	self:close()
end

return PetverifysuccessView
