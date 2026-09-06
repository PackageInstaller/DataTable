-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/herotrial/view/HerotrialverifybtnView.lua

module("logic.extensions.herotrial.view.HerotrialverifybtnView", package.seeall)

local HerotrialverifybtnView = class("HerotrialverifybtnView", ViewComponent)

function HerotrialverifybtnView:ctor()
	HerotrialverifybtnView.super.ctor(self)
end

function HerotrialverifybtnView:buildUI()
	HerotrialverifybtnView.super.buildUI(self)

	self.btnVerify = self:getBtn("btnVerify")
	self.txtVerifyEffect = goutil.findChildTextComponent(self.mainGO, "txtVerifyEffect")
	self.imgEffect = Framework.ImageBigBG.GetFrom(self.mainGO, "btnVerify")
end

function HerotrialverifybtnView:bindEvents()
	HerotrialverifybtnView.super.bindEvents(self)
	self.btnVerify:AddClickListener(self._onClickVerify, self)
end

function HerotrialverifybtnView:unbindEvents()
	HerotrialverifybtnView.super.unbindEvents(self)
	self.btnVerify:RemoveClickListener()
end

function HerotrialverifybtnView:destroyUI()
	HerotrialverifybtnView.super.destroyUI(self)
end

function HerotrialverifybtnView:onEnter()
	HerotrialverifybtnView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.HeroTrialVerifySuccess, self._refresh, self)
	self:_refresh()
end

function HerotrialverifybtnView:onEnterFinished()
	HerotrialverifybtnView.super.onEnterFinished(self)
end

function HerotrialverifybtnView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.HeroTrialVerifySuccess, self._refresh, self)
	self.imgEffect:ClearImage()

	self.txtVerifyEffect.text = ""

	HerotrialverifybtnView.super.onExit(self)
end

function HerotrialverifybtnView:onExitFinished()
	HerotrialverifybtnView.super.onExitFinished(self)
end

function HerotrialverifybtnView:_refresh()
	local higestVerifiedZdl = HerotrialModel.instance:getHigestVerifiedZdl()
	local verifyCfg = HerotrialController.instance:getCurVerifyPlan(higestVerifiedZdl)

	if verifyCfg then
		local color = "60ee85"
		local verifyName = string.format(verifyCfg.name, color)
		local verifyDes = string.format(verifyCfg.des, color)

		self.txtVerifyEffect.text = string.format("%s \n%s", verifyName, verifyDes)
	else
		self.txtVerifyEffect.text = "未激活鼓舞"
	end

	local activityId = HerotrialModel.instance:getActivityId()
	local plans = HerotrialConfig.instance:getVerifyPlans(activityId)
	local tempStr = string.split((verifyCfg or nil) and verifyCfg.bossBuff, ":")
	local buffId = tempStr[1]
	local buffIcon = BattleConfig.instance:getBuffCo(tonumber(buffId))

	self.imgEffect:SetImage(GameUrl.getExpEventUrl(buffIcon.icon))
end

function HerotrialverifybtnView:_onClickVerify()
	HerotrialController.instance:realTimeUpdate(function()
		UIStateManager.instance:push(ViewName.HerotrialverifyView)
	end)
end

return HerotrialverifybtnView
