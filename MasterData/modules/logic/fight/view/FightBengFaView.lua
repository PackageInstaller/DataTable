-- chunkname: @modules/logic/fight/view/FightBengFaView.lua

module("modules.logic.fight.view.FightBengFaView", package.seeall)

local FightBengFaView = class("FightBengFaView", FightBaseView)

function FightBengFaView:onConstructor(bloodView)
	self.bloodView = bloodView
	self.bloodViewGO = bloodView.viewGO
	self.bloodViewRoot = bloodView.root
	self.bengFaRoot = gohelper.create2d(self.bloodViewGO, "bengFaRoot")

	self:setRootAnchor(self.bengFaRoot)

	self.bengFaChangeRoot = gohelper.create2d(self.bloodViewGO, "bengFaChangeRoot")

	self:setRootAnchor(self.bengFaChangeRoot)
	self:com_registFightEvent(FightEvent.Blood2BengFa, self.onBlood2BengFa)
	self:com_registFightEvent(FightEvent.BloodPool_MaxValueChange, self.onMaxValueChange)
	self:com_registFightEvent(FightEvent.BloodPool_ValueChange, self.onValueChange)
	self:com_registFightEvent(FightEvent.StageChanged, self.onStageChanged)
end

function FightBengFaView:onStageChanged(stage)
	if stage == FightStageMgr.StageType.Operate then
		self.lastVisible = false

		gohelper.setActive(self.bengFaRoot, false)
		gohelper.setActive(self.bloodViewRoot, true)
	end
end

function FightBengFaView:setRootAnchor(gameObject)
	local transform = gameObject.transform

	transform.anchorMin = Vector2.zero
	transform.anchorMax = Vector2.one
	transform.offsetMin = Vector2.zero
	transform.offsetMax = Vector2.zero
end

function FightBengFaView:onValueChange(teamType)
	if teamType ~= FightEnum.TeamType.MySide then
		return
	end

	self:refreshBlood()
end

function FightBengFaView:onMaxValueChange(teamType)
	if teamType ~= FightEnum.TeamType.MySide then
		return
	end

	self:refreshBlood()
end

function FightBengFaView:onBlood2BengFa(actEffectData)
	local showState = actEffectData.effectNum1 == 1

	self.curVisible = showState
	self.actEffectData = actEffectData

	if self.lastVisible ~= showState then
		gohelper.setActive(self.bengFaRoot, showState)
		gohelper.setActive(self.bloodViewRoot, not showState)

		if not self.changeLoad then
			self.changeLoad = true

			self:com_loadAsset("ui/viewres/fight/fight_switch_bloodview.prefab", self.onChangeEffectLoaded)
		elseif self.changeEffect then
			gohelper.setActive(self.normal2NuoDiKa, self.curVisible)
			gohelper.setActive(self.nuoDiKa2Normal, not self.curVisible)
		end
	end

	if showState then
		if self.viewGO then
			self:refreshUI()
		elseif not self.load then
			self.load = true

			self:com_loadAsset("ui/viewres/fight/fight_nuodika_bloodview.prefab", self.onLoaded)
		end

		AudioMgr.instance:trigger(20280403)
	end

	self.lastVisible = showState
end

function FightBengFaView:onChangeEffectLoaded(success, loader)
	if not success then
		return
	end

	local obj = loader:GetResource()

	self.changeEffect = gohelper.clone(obj, self.bengFaChangeRoot)
	self.nuoDiKa2Normal = gohelper.findChild(self.changeEffect, "normal")
	self.normal2NuoDiKa = gohelper.findChild(self.changeEffect, "ndk")

	gohelper.setActive(self.normal2NuoDiKa, self.curVisible)
	gohelper.setActive(self.nuoDiKa2Normal, not self.curVisible)
end

function FightBengFaView:onLoaded(success, loader)
	if not success then
		return
	end

	local obj = loader:GetResource()

	self.viewGO = gohelper.clone(obj, self.bengFaRoot)

	local viewGO = self.viewGO

	self.bengFaText = gohelper.findChildText(viewGO, "root/heart/unbroken/#txt_num")
	self.bottomNumTxt = gohelper.findChildText(viewGO, "root/num/bottom/#txt_num")
	self.leftMaxTxt = gohelper.findChildText(self.viewGO, "root/num/left/#txt_num1")
	self.leftCurTxt = gohelper.findChildText(self.viewGO, "root/num/left/#txt_num1/#txt_num2")
	self.leftEffMaxTxt = gohelper.findChildText(self.viewGO, "root/num/left/#txt_num1eff")
	self.leftEffCurTxt = gohelper.findChildText(self.viewGO, "root/num/left/#txt_num1eff/#txt_num2")

	gohelper.setActive(gohelper.findChild(viewGO, "root/num/bottom/txt_preparation"), false)

	self.imageHeart = gohelper.findChildImage(viewGO, "root/heart/unbroken/#image_heart")
	self.imageHeartPre = gohelper.findChildImage(viewGO, "root/heart/unbroken/#image_heart_broken")
	self.imageHeartMat = self.imageHeart.material
	self.imageHeartPreMat = self.imageHeartPre.material
	self.heightPropertyId = UnityEngine.Shader.PropertyToID("_LerpOffset")
	self.leftPart = gohelper.findChild(viewGO, "root/num/left")

	gohelper.setActive(self.leftPart, false)
	self:refreshUI()
end

function FightBengFaView:refreshUI()
	local curBengFa = self.actEffectData.effectNum

	self.bengFaText.text = curBengFa == 0 and "" or curBengFa

	self:refreshBlood()
end

function FightBengFaView:refreshBlood()
	if not self.bottomNumTxt then
		return
	end

	local bloodPool = FightDataHelper.getBloodPool(FightEnum.TeamType.MySide)
	local curValue = bloodPool.value
	local maxValue = bloodPool.max

	self.bottomNumTxt.text = string.format("%s/%s", curValue, maxValue)

	local rate = curValue / maxValue

	self.imageHeartMat:SetFloat(self.heightPropertyId, rate)
	self.imageHeartPreMat:SetFloat(self.heightPropertyId, rate)
	gohelper.setActive(self.leftPart, true)

	self.leftCurTxt.text = curValue
	self.leftMaxTxt.text = maxValue
	self.leftEffCurTxt.text = curValue
	self.leftEffMaxTxt.text = maxValue

	self:com_registSingleTimer(self.hideLeftPart, 1)
end

function FightBengFaView:hideLeftPart()
	gohelper.setActive(self.leftPart, false)
end

function FightBengFaView:onDestroyView()
	return
end

return FightBengFaView
