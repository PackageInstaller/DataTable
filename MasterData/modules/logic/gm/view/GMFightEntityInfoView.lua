-- chunkname: @modules/logic/gm/view/GMFightEntityInfoView.lua

module("modules.logic.gm.view.GMFightEntityInfoView", package.seeall)

local GMFightEntityInfoView = class("GMFightEntityInfoView", BaseView)

function GMFightEntityInfoView:onInitView()
	self.name_input = gohelper.findChildTextMeshInputField(self.viewGO, "info/Scroll View/Viewport/Content/name/input")
	self.id_input = gohelper.findChildTextMeshInputField(self.viewGO, "info/Scroll View/Viewport/Content/id/input")
	self.uid_input = gohelper.findChildTextMeshInputField(self.viewGO, "info/Scroll View/Viewport/Content/uid/input")
	self.hp_input = gohelper.findChildTextMeshInputField(self.viewGO, "info/Scroll View/Viewport/Content/hp/input")
	self.hp_max = gohelper.findChildText(self.viewGO, "info/Scroll View/Viewport/Content/hp/max")
	self.expoint_input = gohelper.findChildTextMeshInputField(self.viewGO, "info/Scroll View/Viewport/Content/power/expoint/input")
	self.expoint_max = gohelper.findChildText(self.viewGO, "info/Scroll View/Viewport/Content/power/expoint/max")
	self.expoint_go = gohelper.findChild(self.viewGO, "info/Scroll View/Viewport/Content/power/expoint")
	self.emitterEnergy_input = gohelper.findChildTextMeshInputField(self.viewGO, "info/Scroll View/Viewport/Content/power/emitterenergy/input")
	self.emitterEnergy_go = gohelper.findChild(self.viewGO, "info/Scroll View/Viewport/Content/power/emitterenergy")
	self.shield_input = gohelper.findChildTextMeshInputField(self.viewGO, "info/Scroll View/Viewport/Content/power/shield/input")
	self.bloodPool_input = gohelper.findChildTextMeshInputField(self.viewGO, "info/Scroll View/Viewport/Content/power/bloodpool/input")
	self.bloodPool_max = gohelper.findChildText(self.viewGO, "info/Scroll View/Viewport/Content/power/bloodpool/max")
	self.bloodPool_go = gohelper.findChild(self.viewGO, "info/Scroll View/Viewport/Content/power/bloodpool")
	self.heatScale_input = gohelper.findChildTextMeshInputField(self.viewGO, "info/Scroll View/Viewport/Content/power/heatscale/input")
	self.heatScale_max = gohelper.findChildText(self.viewGO, "info/Scroll View/Viewport/Content/power/heatscale/max")
	self.heatScale_go = gohelper.findChild(self.viewGO, "info/Scroll View/Viewport/Content/power/heatscale")
	self.health_input = gohelper.findChildTextMeshInputField(self.viewGO, "info/Scroll View/Viewport/Content/power/health/input")
	self.health_max = gohelper.findChildText(self.viewGO, "info/Scroll View/Viewport/Content/power/health/max")
	self.health_go = gohelper.findChild(self.viewGO, "info/Scroll View/Viewport/Content/power/health")
	self.toughness_go = gohelper.findChild(self.viewGO, "info/Scroll View/Viewport/toughness")
	self.toughness_input = gohelper.findChildTextMeshInputField(self.viewGO, "info/Scroll View/Viewport/toughness/input")
	self._icon = gohelper.findChildSingleImage(self.viewGO, "info/image")
	self._imgIcon = gohelper.findChildImage(self.viewGO, "info/image")
	self._imgCareer = gohelper.findChildImage(self.viewGO, "info/image/career")
	self.powerItem = gohelper.findChild(self.viewGO, "info/Scroll View/Viewport/Content/new_power/power_item")

	gohelper.setActive(self.powerItem, false)

	self.powerItemList = {}
end

function GMFightEntityInfoView:addEvents()
	self.addEventCb(self, GMController.instance, GMFightEntityView.Evt_SelectHero, self._onSelectHero, self)
	self.hp_input:AddOnEndEdit(self._onEndEditHp, self)
	self.expoint_input:AddOnEndEdit(self._onEndEditExpoint, self)
	self.emitterEnergy_input:AddOnEndEdit(self._onEndEditEmitterEnergy, self)
	self.bloodPool_input:AddOnEndEdit(self._onEndEditBloodPool, self)
	self.heatScale_input:AddOnEndEdit(self._onEndEditHearScale, self)
	self.health_input:AddOnEndEdit(self._onEndEditHealth, self)
	self.toughness_input:AddOnEndEdit(self._onEndEditToughness, self)
end

function GMFightEntityInfoView:removeEvents()
	self.removeEventCb(self, GMController.instance, GMFightEntityView.Evt_SelectHero, self._onSelectHero, self)
	self.hp_input:RemoveOnEndEdit()
	self.expoint_input:RemoveOnEndEdit()
	self.emitterEnergy_input:RemoveOnEndEdit()
	self.bloodPool_input:RemoveOnEndEdit()
	self.heatScale_input:RemoveOnEndEdit()
	self.health_input:RemoveOnEndEdit()
	self.toughness_input:RemoveOnEndEdit()

	for _, powerItem in ipairs(self.powerItemList) do
		powerItem.input:RemoveOnEndEdit()
	end
end

function GMFightEntityInfoView:onOpen()
	return
end

function GMFightEntityInfoView:onClose()
	return
end

function GMFightEntityInfoView:_onSelectHero(entityMO)
	self._entityMO = entityMO

	self.name_input:SetText(entityMO:getEntityName())
	self.id_input:SetText(tostring(entityMO.modelId))
	self.uid_input:SetText(tostring(entityMO.id))
	self.hp_input:SetText(tostring(entityMO.currentHp))

	self.hp_max.text = "/" .. tostring(entityMO.attrMO.hp)

	local expointVisible = true
	local assistBoss = entityMO:isAssistBoss()

	if assistBoss then
		expointVisible = false
	end

	if entityMO:isAct191Boss() then
		expointVisible = false
	end

	gohelper.setActive(self.expoint_go, expointVisible)

	if expointVisible then
		self.expoint_input:SetText(tostring(entityMO.exPoint))

		self.expoint_max.text = "/" .. tostring(entityMO:getMaxExPoint())
	end

	local isASFDEmitter = entityMO:isASFDEmitter()

	gohelper.setActive(self.emitterEnergy_go, isASFDEmitter)

	local teamType = FightEnum.TeamType.MySide
	local bloodPool = FightDataHelper.getBloodPool(teamType)
	local showBloodPool = self._entityMO.id == FightEntityScene.MySideId and bloodPool

	if showBloodPool then
		self.bloodPool_input:SetText(bloodPool.value)

		self.bloodPool_max.text = "/" .. tostring(bloodPool.max)
	end

	gohelper.setActive(self.bloodPool_go, showBloodPool)

	local heatScale = FightDataHelper.getHeatScale(teamType)
	local showHeatScale = self._entityMO.id == FightEntityScene.MySideId and heatScale

	if showHeatScale then
		self.heatScale_input:SetText(heatScale.value)

		self.heatScale_max.text = "/" .. tostring(heatScale.max)
	end

	gohelper.setActive(self.heatScale_go, showHeatScale)

	local health = FightHelper.getSurvivalEntityHealth(entityMO.id)
	local showHealth = health ~= nil

	gohelper.setActive(self.health_go, showHealth)

	if showHealth then
		self.health_input:SetText(health)

		self.health_max.text = "/" .. tostring(FightHelper.getSurvivalMaxHealth())
	end

	local monsterConfig = lua_monster.configDict[entityMO.modelId]

	if monsterConfig and not string.nilorempty(monsterConfig.toughness) then
		gohelper.setActive(self.toughness_go, true)
		self:showToughness(entityMO, monsterConfig)
	else
		gohelper.setActive(self.toughness_go, false)
	end

	self.shield_input:SetText(entityMO.shieldValue)
	self._icon:UnLoadImage()

	if entityMO:isMonster() then
		if not lua_monster.configDict[entityMO.modelId] then
			local skinCO = FightConfig.instance:getSkinCO(entityMO.originSkin)

			if entityMO:isCharacter() then
				local iconPath = ResUrl.getHeadIconSmall(skinCO.retangleIcon)

				self._icon:LoadImage(iconPath)
			elseif entityMO:isMonster() then
				gohelper.getSingleImage(self._imgIcon.gameObject):LoadImage(ResUrl.monsterHeadIcon(skinCO.headIcon))

				self._imgIcon.enabled = true
			end

			local career = entityMO:getCareer()

			if career ~= 0 then
				UISpriteSetMgr.instance:setEnemyInfoSprite(self._imgCareer, "sxy_" .. tostring(career))
			end

			self:refreshPowerList(entityMO)
		end
	end
end

function GMFightEntityInfoView:showToughness(entityMO, monsterConfig)
	self.toughness_input:SetText(entityMO.toughnessPoint .. "_" .. entityMO.toughnessValue)
end

function GMFightEntityInfoView:_onEndEditToughness(inputStr)
	local entityMO = GMFightEntityModel.instance.entityMO
	local arr = string.splitToNumber(inputStr, "_")

	GMRpc.instance:sendGMRequest(string.format("fightToughness %s %d %d", entityMO.id, arr[1], arr[2]))

	entityMO.toughnessPoint = arr[1]
	entityMO.toughnessValue = arr[2]

	local localEntityData = FightLocalDataMgr.instance:getEntityById(entityMO.id)

	localEntityData.toughnessPoint = arr[1]
	localEntityData.toughnessValue = arr[2]

	FightMsgMgr.sendMsg(FightMsgId.ChangeEntityToughness, entityMO.id)
end

GMFightEntityInfoView.PowerId2Name = {
	[FightEnum.PowerType.Power] = "灵光",
	[FightEnum.PowerType.Energy] = "BOSS能量",
	[FightEnum.PowerType.Stress] = "压力",
	[FightEnum.PowerType.AssistBoss] = "量普",
	[FightEnum.PowerType.PlayerFinisherSkill] = "主角终结技",
	[FightEnum.PowerType.Alert] = "警戒值",
	[FightEnum.PowerType.Act191Boss] = "斗蛐蛐",
	[FightEnum.PowerType.SurvivalDot] = "探索dot流派",
	[FightEnum.PowerType.ZongMaoBossEnergy] = "鬃毛boss",
	[FightEnum.PowerType.ZongMaoYinNiZhi] = "隐匿值"
}
GMFightEntityInfoView.PowerItemInputWidth = 50

function GMFightEntityInfoView:initPowerOnEndEditHandleDict()
	GMFightEntityInfoView.PowerId2OnEndEditFuncDict = GMFightEntityInfoView.PowerId2OnEndEditFuncDict or {
		[FightEnum.PowerType.Power] = self._onEndEditPower,
		[FightEnum.PowerType.Alert] = self._onEndEditAlert,
		[FightEnum.PowerType.Stress] = self._onEndEditStress,
		[FightEnum.PowerType.AssistBoss] = self._onEndEditAssistBoss,
		[FightEnum.PowerType.SurvivalDot] = self._onEndEditSurvivalDot,
		[FightEnum.PowerType.ZongMaoBossEnergy] = self._onEndEditZongMaoBossEnergy,
		[FightEnum.PowerType.ZongMaoYinNiZhi] = self._onEndEditZongMaoYinNiZhi,
		[FightEnum.PowerType.Atomic] = self._onEndEditAtomic
	}
end

function GMFightEntityInfoView:refreshPowerList(entityMo)
	self:initPowerOnEndEditHandleDict()

	self.powerId2PowerItemDict = self.powerId2PowerItemDict or {}

	tabletool.clear(self.powerId2PowerItemDict)

	local powerCount = 0

	for powerName, power in pairs(FightEnum.PowerType) do
		local powerInfo = entityMo:getPowerInfo(power)

		if powerInfo then
			powerCount = powerCount + 1

			local powerItem = self.powerItemList[powerCount]

			if not powerItem then
				powerItem = self:getUserDataTb_()
				powerItem.go = gohelper.cloneInPlace(self.powerItem)
				powerItem.rectGo = powerItem.go:GetComponent(gohelper.Type_RectTransform)
				powerItem.txtLabel = gohelper.findChildText(powerItem.go, "label")
				powerItem.rectLabel = powerItem.txtLabel:GetComponent(gohelper.Type_RectTransform)
				powerItem.input = gohelper.findChildTextMeshInputField(powerItem.go, "input")
				powerItem.rectInput = powerItem.input:GetComponent(gohelper.Type_RectTransform)
				powerItem.txtMax = gohelper.findChildText(powerItem.go, "max")
				powerItem.rectMax = powerItem.txtMax:GetComponent(gohelper.Type_RectTransform)

				table.insert(self.powerItemList, powerItem)
			end

			powerItem.input:RemoveOnEndEdit()

			local onEndEdit = GMFightEntityInfoView.PowerId2OnEndEditFuncDict[power]

			if onEndEdit then
				powerItem.input:AddOnEndEdit(onEndEdit, self)
			end

			gohelper.setActive(powerItem.go, true)

			powerItem.txtLabel.text = self.PowerId2Name[power] or powerName

			powerItem.input:SetTextWithoutNotify(tostring(powerInfo.num))

			powerItem.txtMax.text = "/" .. tostring(powerInfo.max)

			local labelWidth = GameUtil.getTextRenderSize(powerItem.txtLabel)
			local maxWidth = GameUtil.getTextRenderSize(powerItem.txtMax)

			recthelper.setAnchorX(powerItem.rectInput, labelWidth)
			recthelper.setAnchorX(powerItem.rectMax, labelWidth + self.PowerItemInputWidth)

			local totalWidth = labelWidth + self.PowerItemInputWidth + maxWidth

			recthelper.setWidth(powerItem.rectGo, totalWidth)

			self.powerId2PowerItemDict[power] = powerItem
		end
	end

	for i = powerCount + 1, #self.powerItemList do
		local powerItem = self.powerItemList[i]

		if powerItem then
			gohelper.setActive(powerItem.go, false)
		end
	end
end

function GMFightEntityInfoView:_onEndEditHp(inputStr)
	local entityMO = GMFightEntityModel.instance.entityMO
	local targetHp = tonumber(inputStr)

	if targetHp then
		local old = entityMO.currentHp
		local maxHp = entityMO.attrMO.hp
		local fixedHp = Mathf.Clamp(targetHp, 0, maxHp)

		if targetHp ~= fixedHp then
			self.hp_input:SetTextWithoutNotify(tostring(fixedHp))
		end

		entityMO.currentHp = fixedHp

		local localEntityMO = FightLocalDataMgr.instance:getEntityById(entityMO.id)

		if localEntityMO then
			localEntityMO.currentHp = fixedHp
		end

		FightController.instance:dispatchEvent(FightEvent.OnCurrentHpChange, entityMO.id, old, fixedHp)
		GMRpc.instance:sendGMRequest(string.format("fightChangeLife %s %d", entityMO.id, fixedHp))
	end
end

function GMFightEntityInfoView:_onEndEditExpoint(inputStr)
	local entityMO = GMFightEntityModel.instance.entityMO
	local targetExpoint = tonumber(inputStr)

	if targetExpoint then
		local maxExpoint = entityMO:getMaxExPoint()
		local fixedExpoint = Mathf.Clamp(targetExpoint, 0, maxExpoint)

		if targetExpoint ~= fixedExpoint then
			self.expoint_input:SetTextWithoutNotify(tostring(fixedExpoint))
		end

		local oldNum = entityMO.exPoint

		entityMO.exPoint = fixedExpoint

		local localEntityMO = FightLocalDataMgr.instance:getEntityById(entityMO.id)

		if localEntityMO then
			localEntityMO.exPoint = fixedExpoint
		end

		FightController.instance:dispatchEvent(FightEvent.UpdateExPoint, entityMO.id, oldNum, entityMO.exPoint)
		GMRpc.instance:sendGMRequest(string.format("fightChangeExPoint %s %d", entityMO.id, fixedExpoint))
	end
end

function GMFightEntityInfoView:_onEndEditPower(inputStr)
	self:onEndEditPower(FightEnum.PowerType.Power, inputStr)
end

function GMFightEntityInfoView:_onEndEditAlert(inputStr)
	self:onEndEditPower(FightEnum.PowerType.Alert, inputStr)
end

function GMFightEntityInfoView:_onEndEditStress(inputStr)
	self:onEndEditPower(FightEnum.PowerType.Stress, inputStr)
end

function GMFightEntityInfoView:_onEndEditAssistBoss(inputStr)
	self:onEndEditPower(FightEnum.PowerType.AssistBoss, inputStr)
end

function GMFightEntityInfoView:_onEndEditSurvivalDot(inputStr)
	self:onEndEditPower(FightEnum.PowerType.SurvivalDot, inputStr)
end

function GMFightEntityInfoView:_onEndEditZongMaoBossEnergy(inputStr)
	self:onEndEditPower(FightEnum.PowerType.ZongMaoBossEnergy, inputStr)
end

function GMFightEntityInfoView:_onEndEditZongMaoYinNiZhi(inputStr)
	self:onEndEditPower(FightEnum.PowerType.ZongMaoYinNiZhi, inputStr)
end

function GMFightEntityInfoView:_onEndEditAtomic(inputStr)
	self:onEndEditPower(FightEnum.PowerType.Atomic, inputStr)
end

function GMFightEntityInfoView:onEndEditPower(powerId, text)
	local entityMO = GMFightEntityModel.instance.entityMO
	local value = tonumber(text)

	if value then
		local powerInfo = entityMO:getPowerInfo(powerId)

		if powerInfo then
			if not powerInfo.num then
				local oldPowerValue = 0

				if powerInfo then
					if not powerInfo.max then
						local maxPowerValue = 0
						local fixedPowerValue = Mathf.Clamp(value, 0, maxPowerValue)

						if value ~= fixedPowerValue then
							local powerItem = self.powerId2PowerItemDict[powerId]

							powerItem.input:SetTextWithoutNotify(tostring(fixedPowerValue))
						end

						powerInfo.num = fixedPowerValue

						local localEntityMO = FightLocalDataMgr.instance:getEntityById(entityMO.id)

						if localEntityMO then
							local localPowerInfo = localEntityMO:getPowerInfo(powerId)

							if localPowerInfo then
								localPowerInfo.num = fixedPowerValue
							end
						end

						FightController.instance:dispatchEvent(FightEvent.PowerChange, entityMO.id, powerId, oldPowerValue, fixedPowerValue)
						GMRpc.instance:sendGMRequest(string.format("fightChangePower %s %s %d", entityMO.id, powerId, fixedPowerValue))
					end
				end
			end
		end
	end
end

function GMFightEntityInfoView:_onEndEditEmitterEnergy(inputStr)
	local entityMO = GMFightEntityModel.instance.entityMO

	if not entityMO:isASFDEmitter() then
		return
	end

	local energy = tonumber(inputStr)

	if not energy then
		return
	end

	GMRpc.instance:sendGMRequest(string.format("fightChangeEmitterEnergy %s %d", entityMO.id, energy))
	FightDataHelper.ASFDDataMgr:changeEmitterEnergy(FightEnum.EntitySide.MySide, energy)
end

function GMFightEntityInfoView:_onEndEditBloodPool(inputStr)
	local value = tonumber(inputStr)

	if not value then
		return
	end

	local teamType = FightEnum.TeamType.MySide
	local bloodPool = FightDataHelper.getBloodPool(teamType)
	local max = bloodPool.max

	value = math.min(math.max(0, value), max)
	bloodPool.value = value

	GMRpc.instance:sendGMRequest(string.format("setBloodPoolValue %d", value))
	FightController.instance:dispatchEvent(FightEvent.BloodPool_ValueChange, teamType)
end

function GMFightEntityInfoView:_onEndEditHearScale(inputStr)
	local value = tonumber(inputStr)

	if not value then
		return
	end

	local teamType = FightEnum.TeamType.MySide
	local heatScale = FightDataHelper.getHeatScale(teamType)
	local max = heatScale.max

	value = math.min(math.max(0, value), max)
	heatScale.value = value

	GMRpc.instance:sendGMRequest(string.format("setBloodPoolValue %d", value))
	FightController.instance:dispatchEvent(FightEvent.HeatScale_ValueChange, teamType)
end

function GMFightEntityInfoView:_onEndEditHealth(inputStr)
	local value = tonumber(inputStr)
end

return GMFightEntityInfoView
