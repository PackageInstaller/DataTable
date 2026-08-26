-- chunkname: @modules/logic/versionactivity3_3/igor/view/comp/IgorSkillBaseItem.lua

module("modules.logic.versionactivity3_3.igor.view.comp.IgorSkillBaseItem", package.seeall)

local IgorSkillBaseItem = class("IgorSkillBaseItem", LuaCompBase)

function IgorSkillBaseItem:init(go)
	self.go = go
	self.transform = self.go.transform
	self.parentTransform = self.transform.parent
	self.imgMask = gohelper.findChildImage(self.go, "mask")
	self._inCDState = false
	self.imgBtn = gohelper.findChildImage(self.go, "image_btn")
	self.txtCost = gohelper.findChildTextMesh(self.go, "Cost/txtcost")

	self:onInit()
end

function IgorSkillBaseItem:onInit()
	return
end

function IgorSkillBaseItem:addEventListeners()
	self.addEventCb(self, IgorController.instance, IgorEvent.OnGamePause, self.onGamePause, self)
	self.addEventCb(self, IgorController.instance, IgorEvent.OnGameCostChange, self.onGameCostChange, self)
	self:addDrag(self.go)
end

function IgorSkillBaseItem:removeEventListeners()
	self.removeEventCb(self, IgorController.instance, IgorEvent.OnGamePause, self.onGamePause, self)
	self.removeEventCb(self, IgorController.instance, IgorEvent.OnGameCostChange, self.onGameCostChange, self)

	if self.longListener then
		self.longListener:RemoveClickListener()
		self.longListener:RemoveLongPressListener()

		self.longListener = nil
	end
end

function IgorSkillBaseItem:addDrag(go)
	if self.longListener then
		return
	end

	self.longListener = SLFramework.UGUI.UILongPressListener.Get(go)

	self.longListener:SetLongPressTime({
		0.5,
		99999
	})
	self.longListener:AddLongPressListener(self.onLongPress, self)
	self.longListener:AddClickListener(self.onClickCard, self)
end

function IgorSkillBaseItem:onGamePause(isPaused)
	if isPaused then
		self:pauseCD()
	else
		self:restartCD()
	end
end

function IgorSkillBaseItem:updateParam(param)
	self.param = param

	self:onUpdateParam()
end

function IgorSkillBaseItem:onUpdateParam()
	self:onCDComplete()

	self.skillType = self.param

	local gameMO = IgorModel.instance:getCurGameMo()
	local ourSideMO = gameMO:getOursideMo()

	self.skillData = ourSideMO:getSkillMO(self.skillType)

	self:refreshTimes()
	self:refreshCost()
	self:refreshSkill()
end

function IgorSkillBaseItem:refreshSkill()
	return
end

function IgorSkillBaseItem:refreshTimes()
	return
end

function IgorSkillBaseItem:hasRemainTimes()
	local remainTimes = self.skillData:getSkillRemainTimes()

	return remainTimes > 0
end

function IgorSkillBaseItem:getCost()
	return self.skillData:getSkillCost()
end

function IgorSkillBaseItem:getCd()
	return self.skillData:getSkillCD()
end

function IgorSkillBaseItem:onLongPress()
	self:showTips()
end

function IgorSkillBaseItem:onClickCard()
	self:onUseCard()
end

function IgorSkillBaseItem:onGameCostChange()
	self:refreshCost()
end

function IgorSkillBaseItem:refreshCost()
	local gameMO = IgorModel.instance:getCurGameMo()
	local curCost = gameMO:getGameCost()
	local cost = self:getCost()
	local isEnough = cost <= curCost

	self.txtCost.text = isEnough and tostring(cost) or string.format("<color=#B24444>%s</color>", cost)

	if gohelper.isNil(self.imgBtn) then
		return
	end

	SLFramework.UGUI.GuiHelper.SetColor(self.imgBtn, isEnough and "#FFFFFF" or "#7B7B7B")
end

function IgorSkillBaseItem:enterCD()
	local cd = self:getCd()

	if cd > 0 then
		self:clearCDTween()

		self._inCDState = true

		gohelper.setActive(self.goMask, self._inCDState)

		if not gohelper.isNil(self.imgMask) then
			self.imgMask.fillAmount = 1
			self.cdTweenId = ZProj.TweenHelper.DOFillAmount(self.imgMask, 0, cd, self.onCDComplete, self, nil, EaseType.Linear)
		end
	end
end

function IgorSkillBaseItem:onCDComplete()
	self._inCDState = false

	gohelper.setActive(self.goMask, self._inCDState)

	if not gohelper.isNil(self.imgMask) then
		self.imgMask.fillAmount = 0
	end

	self:clearCDTween()
end

function IgorSkillBaseItem:clearCDTween()
	if self.cdTweenId then
		ZProj.TweenHelper.KillById(self.cdTweenId)

		self.cdTweenId = nil
	end
end

function IgorSkillBaseItem:isInCD()
	return self._inCDState
end

function IgorSkillBaseItem:pauseCD()
	self:clearCDTween()
end

function IgorSkillBaseItem:restartCD()
	if self:isInCD() then
		self:clearCDTween()

		local cd = self:getCd()
		local curFillAmount = self.imgMask.fillAmount
		local remainCD = curFillAmount * cd

		self.cdTweenId = ZProj.TweenHelper.DOFillAmount(self.imgMask, 0, remainCD, self.onCDComplete, self, nil, EaseType.Linear)
	end
end

function IgorSkillBaseItem:isCostEnough()
	local gameMO = IgorModel.instance:getCurGameMo()
	local curCost = gameMO:getGameCost()
	local cardCost = self:getCost()

	return cardCost <= curCost
end

function IgorSkillBaseItem:onDestroy()
	self:clearCDTween()
end

return IgorSkillBaseItem
