-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petverify/view/PetverifybtnView.lua

module("logic.extensions.petverify.view.PetverifybtnView", package.seeall)

local PetverifybtnView = class("PetverifybtnView", ViewComponent)

function PetverifybtnView:ctor()
	PetverifybtnView.super.ctor(self)
end

function PetverifybtnView:buildUI()
	PetverifybtnView.super.buildUI(self)

	self._btnVerify = self:getBtn("btnVerify")
	self._txtVerifyEffect = goutil.findChildTextComponent(self.mainGO, "txtVerifyEffect")
	self._imgEffect = Framework.ImageBigBG.GetFrom(self.mainGO, "btnVerify")
	self._txtLv = goutil.findChildTextComponent(self.mainGO, "txtLv")
end

function PetverifybtnView:bindEvents()
	PetverifybtnView.super.bindEvents(self)
	self._btnVerify:AddClickListener(self._onClickVerify, self)
end

function PetverifybtnView:unbindEvents()
	PetverifybtnView.super.unbindEvents(self)
	self._btnVerify:RemoveClickListener()
end

function PetverifybtnView:destroyUI()
	PetverifybtnView.super.destroyUI(self)
end

function PetverifybtnView:onEnter()
	PetverifybtnView.super.onEnter(self)

	local param = self:getFirstParam()

	if param then
		self._challengeName = param.name
		self._tipDesc = param.tipDesc
	else
		self._challengeName = ""
		self._tipDesc = "今日不再自动提示"
	end

	self.planId = self:getOpenParam()[2]

	GlobalDispatcher:addListener(GlobalNotify.PetVerifySuccess, self._refresh, self)
	self:_refresh()
	self:_showVerifyPopup()
end

function PetverifybtnView:onEnterFinished()
	PetverifybtnView.super.onEnterFinished(self)
end

function PetverifybtnView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.PetVerifySuccess, self._refresh, self)
	self._imgEffect:ClearImage()

	self._txtVerifyEffect.text = ""

	PetverifybtnView.super.onExit(self)
end

function PetverifybtnView:onExitFinished()
	PetverifybtnView.super.onExitFinished(self)
end

function PetverifybtnView:_refresh()
	local planId = self.planId
	local verifyCfg = PetverifyController.instance:getCurrPlanBuff(self.planId)

	if verifyCfg then
		local color = "60ee85"
		local verifyName = string.format(verifyCfg.name, color)
		local verifyDes = string.format(verifyCfg.des, color)

		self._txtVerifyEffect.text = string.format("%s \n%s", verifyName, verifyDes)
		self._txtLv.text = string.format("Lv.%d", verifyCfg.level)
	else
		self._txtVerifyEffect.text = "未激活鼓舞"
		self._txtLv.text = "Lv.0"
	end

	local plans = PetVerifyBuffConfig.instance:getBuffListById(planId)
	local tempStr = string.split((verifyCfg or nil) and verifyCfg.buffId, ":")
	local buffId = tempStr[1]
	local buffIcon = BattleConfig.instance:getBuffCo(tonumber(buffId))

	self._imgEffect:SetImage(GameUrl.getExpEventUrl(buffIcon.icon))
end

function PetverifybtnView:_showVerifyPopup()
	local planId = self.planId
	local verifyCfg = PetverifyController.instance:getCurrPlanBuff(self.planId)
	local desc

	if verifyCfg then
		local color = "11a568"
		local verifyDes = langPara(verifyCfg.des, color)

		desc = langPara("当前战力鼓舞<color=#%s>%d级</color>！\n%s！\n自阵战力大幅提升！", color, verifyCfg.level, verifyDes)
	else
		desc = lang("当前战力鼓舞<color=#11a568>0级</color>！\n放入精灵验证！\n可大幅提升战力喔！")
	end

	local uiFlyTweenParam = UIFlyTweenParam.New()

	uiFlyTweenParam.endPosition = self._btnVerify.transform.position

	GameUtil.getUserDayData("PetverifybtnView_" .. planId, function(boo)
		if not boo then
			local param = {}

			param.descStr = desc
			param.nameStr = self._challengeName
			param.toggleDescStr = self._tipDesc

			function param.onToggleIsOnCallback()
				print(">>>>>>>>>>>>>>>>", "PetverifybtnView_" .. planId)
				GameUtil.saveUserDayData("PetverifybtnView_" .. planId, true)
			end

			param.uiFlyTweenParam = uiFlyTweenParam

			UIStateManager.instance:open(ViewName.PetVerifyPopupView, param)
		end
	end)
end

function PetverifybtnView:_onClickVerify()
	UIStateManager.instance:push(ViewName.PetverifyView, self.planId)
end

return PetverifybtnView
