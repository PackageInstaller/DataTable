-- chunkname: @IQIGame\\UI\\Battle\\BattleHUD\\BattleHUDItemView.lua

local BattleHUDFlyableTipsView = require("IQIGame/UI/Battle/BattleHUD/BattleHUDFlyableTipsView")
local BattleHUDBuffView = require("IQIGame/UI/Battle/BattleHUD/BattleHUDBuffView")
local BattleHUDRageView = require("IQIGame/UI/Battle/BattleHUD/BattleHUDRageView")
local BattleHUDWakeView = require("IQIGame/UI/Battle/BattleHUD/BattleHUDWakeView")
local BattleHUDWakeNumView = require("IQIGame/UI/Battle/BattleHUD/BattleHUDWakeNumView")
local BattleHUDHPView = require("IQIGame/UI/Battle/BattleHUD/BattleHUDHPView")
local BattleHUDEnergyView = require("IQIGame/UI/Battle/BattleHUD/BattleHUDEnergyView")
local BattleHUDElementView = require("IQIGame/UI/Battle/BattleHUD/BattleHUDElementView")
local BattleHUDBossView = require("IQIGame/UI/Battle/BattleHUD/BattleHUDBossView")
local m = {
	shieldMaterialPropertyName = "_ShieldRatio",
	hpReduceSpeedMin = 0.1,
	battleUnitID = 0,
	isEnergyEnable = false,
	hpReduceSpeedMax = 1,
	hpMaterialPropertyName = "_HPRatio",
	mpMaterialPropertyName = "_MPRatio",
	hpLeftMaterialPropertyName = "_HPLeftRatio",
	mpSplitMaterialPropertyName = "_MPSplit"
}

function m.New(view, rootGameObject)
	local obj = Clone(m)

	obj:__Init(view, rootGameObject)

	return obj
end

function m:__Init(view, rootGameObject)
	self.gameObject = view
	self.rootGameObject = rootGameObject
	self.__battleDamageDetail = BattleUIApi:GetBattleDamagePopupDetail()

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.flyableTipsView = BattleHUDFlyableTipsView.New(self.flyableTipsRoot)
	self.battleDamageEffectPanelComponent = BattleDamageEffectComponent.New(self.BattleDamageEffectPanel, 0)
	self.buffView = BattleHUDBuffView.New(self.buffPanel)
	self.rageView = BattleHUDRageView.New(self.ragePanel)
	self.wakeView = BattleHUDWakeView.New(self.wakePanel)
	self.wakeNumView = BattleHUDWakeNumView.New(self.levelItem)
	self.hpView = BattleHUDHPView.New(self.hpFrameImage)
	self.energyView = BattleHUDEnergyView.New(self.energyPanel)
	self.elememtView = BattleHUDElementView.New(self.elementItem)

	self:__InitSpecialBuff()

	self.battleDamageQueue = Queue.New()
end

function m:OnUpdate()
	if self.bossView ~= nil then
		self.bossView:OnUpdate()
	else
		self.hpView:OnUpdate()
	end

	self:__OnPopupBattleDamage()
end

function m:BindingBattleUnit(battleUnitID, bossHUD)
	self.battleUnitID = battleUnitID

	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)

	self:__ChangeToBattlePos(battleUnitData)

	local battleUnitView = BattleModule.battleScene:GetBattleUnitViewByID(battleUnitID)
	local followCom = self.gameObject:GetComponent(typeof(IQIGame.Onigao.Game.UIFollowSceneObject))

	followCom:SetFollowTarget(battleUnitView.hudFollowTarget, BattleModule.battleScene.battleCameraCom, battleUnitData.hudOffset)

	self.battleDamageEffectPanelComponent.battleUnitID = self.battleUnitID
	self.gameObject.name = battleUnitID
	self.buffView.battleUnitID = battleUnitID

	self.buffView:UpdateLayout(battleUnitData.isFriendly)

	if battleUnitData.isFriendly then
		self:__ShowBattleAttackState(battleUnitData)
	elseif bossHUD ~= nil then
		self:__ShowBossState(battleUnitData, bossHUD)
	else
		self:__ShowBattleDefineState(battleUnitData)
	end

	self:__ShowBattleUnitElement(battleUnitData)
	self:__InitHPView(battleUnitData.isFriendly)
	self:__InitBuffs(battleUnitData)
	self:OnBattleUnitHpChange()
	self:OnBattleUnitEnergyChange()
	self.gameObject:SetActive(true)
end

function m:__ShowBattleUnitElement(battleUnitData)
	local monsterConfig = CfgMonsterTable[battleUnitData.monsterConfigID]

	self.elememtView:Show()
	self.elememtView:SetData(monsterConfig)
end

function m:__ShowBattleAttackState(battleUnitData)
	self.canHideRoot.gameObject:SetActive(true)
	self:__DisableRageView()
	self:__DisableWakeView()
	self.energyView:HideEnergy()
end

function m:__ShowBattleDefineState(battleUnitData)
	self.canHideRoot.gameObject:SetActive(true)
	self:__DisableRageView()
	self:__EnableWakeView(battleUnitData)
	self.energyView:HideEnergy()
end

function m:__ShowBossState(battleUnitData, bossHUD)
	self.canHideRoot.gameObject:SetActive(false)
	self.energyView:HideEnergy()

	self.bossView = BattleHUDBossView.New(bossHUD)

	self.bossView:InitByUnitData(battleUnitData)
end

function m:SetActive(active)
	if self.bossView ~= nil then
		self.bossView:SetActiveEx(active)
	else
		if not active then
			self.wakeView:HideAllWakeEffect()
		end

		self.canHideRoot.gameObject:SetActive(active)
	end
end

function m:Release()
	self.battleDamageQueue:Clear()

	if self.bossView ~= nil then
		self.bossView:Dispose()
	end

	self.bossView = nil

	self.buffView:Clear()
	self.wakeView:Clear()

	self.battleUnitID = 0

	local followCom = self.gameObject:GetComponent(typeof(IQIGame.Onigao.Game.UIFollowSceneObject))

	followCom:SetFollowTarget(nil, nil, UnityEngine.Vector3.zero)
	self.flyableTipsView:Release()
	self.gameObject:SetActive(false)
end

function m:Dispose()
	self.battleDamageQueue:Clear()
	self.buffView:Dispose()
	self.flyableTipsView:Dispose()
	self.rageView:Dispose()
	self.wakeView:Dispose()
	self.hpView:Dispose()
	self.energyView:Dispose()
	self.elememtView:Dispose()
	self.battleDamageEffectPanelComponent:Dispose()

	if self.bossView ~= nil then
		self.bossView:Dispose()
	end

	self.rootGameObject = nil

	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	self.gameObject:SetActive(false)
	GameObject.Destroy(self.gameObject)

	self.gameObject = nil
end

function m:__ChangeToBattlePos(battleUnitData)
	if self.rootGameObject == nil then
		return
	end

	local parentTrans = self.rootGameObject.transform:Find(battleUnitData.battlePos)

	if parentTrans == nil then
		logError("找不到角色战斗单位位置 ------->>{0}", battleUnitData.battlePos)
	end

	self.gameObject.transform:SetParent(parentTrans)

	self.gameObject.transform.localScale = battleUnitData.hudScale
end

function m:OnBattleUnitPosChange()
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(self.battleUnitID)

	self:__ChangeToBattlePos(battleUnitData)
end

function m:OnBattleUnitChangeSkin()
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(self.battleUnitID)
	local battleUnitView = BattleModule.battleScene:GetBattleUnitViewByID(self.battleUnitID)

	self.gameObject.transform.localScale = battleUnitData.hudScale

	local followCom = self.gameObject:GetComponent(typeof(IQIGame.Onigao.Game.UIFollowSceneObject))

	followCom:SetFollowTarget(battleUnitView.hudFollowTarget, BattleModule.battleScene.battleCameraCom, battleUnitData.hudOffset)
end

function m:__InitHPView(isFriendly)
	if self.bossView ~= nil then
		return
	end

	self.hpView:OnInit(isFriendly)
end

function m:OnBattleUnitHpChange()
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(self.battleUnitID)

	if self.bossView ~= nil then
		self.bossView:UpdateHPAndShieldView(battleUnitData.hp, battleUnitData.maxHp, battleUnitData.shield)
	else
		self.hpView:UpdateHP(battleUnitData.hp, battleUnitData.maxHp, battleUnitData.shield)
	end
end

function m:OnBattleUnitEnergyChange()
	return
end

function m:__InitSpecialBuff()
	self:__HideSpecialBuff()
end

function m:__ShowSpecialBuff(tagId, stack)
	if self.bossView ~= nil then
		self.bossView:ShowSpecialBuff(tagId, stack)
	else
		self.specialBuffItem:SetActive(true)

		local path = BattleApi:GetSpecialBuffIcon(tagId)

		AssetUtil.LoadImage(self, path, self.specialBuffIcon:GetComponent(typeof(UnityEngine.UI.Image)))
	end

	self:__UpdateSpecialBuffStack(stack)
end

function m:__HideSpecialBuff()
	if self.bossView ~= nil then
		self.bossView:HideSpecialBuff()
	else
		self.specialBuffItem:SetActive(false)
	end
end

function m:__IsSpecialBuff(buffCfg)
	if buffCfg.BuffTag == nil then
		return false
	end

	return buffCfg.BuffTag[1] == BattleConstant.SpecialBuffTag
end

function m:__InitBuffs(battleUnitData)
	for _, buffData in pairs(battleUnitData.buffsData) do
		self:OnAddBuff(buffData, false)
	end
end

function m:OnAddBuff(battleBuffData, showNotice)
	if showNotice then
		self.flyableTipsView:AddBuffFlyableTips(battleBuffData.cid, 1)
	end

	local buffConfig = CfgBuffTable[battleBuffData.cid]

	if self:__IsSpecialBuff(buffConfig) then
		self:__ShowSpecialBuff(buffConfig.BuffTag[2], battleBuffData.stack)

		return
	end

	if not buffConfig.IsVisible then
		return
	end

	if self.bossView ~= nil then
		self.bossView:AddBuff(battleBuffData)
	else
		self.buffView:AddBuff(battleBuffData)
	end
end

function m:OnUpdateBuff(battleBuffData, stackDifference, roundDifference)
	if stackDifference < 0 then
		self.flyableTipsView:AddBuffFlyableTips(battleBuffData.cid, 2)
	elseif stackDifference > 0 then
		self.flyableTipsView:AddBuffFlyableTips(battleBuffData.cid, 5)
	end

	local buffConfig = CfgBuffTable[battleBuffData.cid]

	if self:__IsSpecialBuff(buffConfig) then
		self:__UpdateSpecialBuffStack(battleBuffData.stack)

		return
	end

	if not buffConfig.IsVisible then
		return
	end

	if self.bossView ~= nil then
		self.bossView:UpdateBuff(battleBuffData)
	else
		self.buffView:UpdateBuff(battleBuffData)
	end
end

function m:__UpdateSpecialBuffStack(stack)
	return
end

function m:OnTriggerBuff(buffCid)
	self.flyableTipsView:AddBuffFlyableTips(buffCid, 3)
end

function m:OnRemoveBuff(buffCid)
	self.flyableTipsView:AddBuffFlyableTips(buffCid, 4)

	local buffConfig = CfgBuffTable[buffCid]

	if self:__IsSpecialBuff(buffConfig) then
		self:__HideSpecialBuff()

		return
	end

	if not buffConfig.IsVisible then
		return
	end

	if self.bossView ~= nil then
		self.bossView:RemoveBuff(buffCid)
	else
		self.buffView:RemoveBuff(buffCid)
	end
end

function m:__EnableWakeView(battleUnitData)
	self.wakeView.battleUnitID = self.battleUnitID

	self.wakeView:Show()

	local wakeCount = 0

	for wakeCid, status in pairs(battleUnitData.PODData.WeakStatus) do
		self.wakeView:AddWake(wakeCid, status)

		wakeCount = wakeCount + 1
	end

	self.wakeNumView:Show()

	if wakeCount > 0 then
		self.wakeNumView:UpdateWakeNum(battleUnitData.PODData.WeakNum, false)
	end
end

function m:__DisableWakeView()
	self.wakeView:Hide()
	self.wakeNumView:Hide()
end

function m:OnBattleUnitAddWake(wakeCid)
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(self.battleUnitID)
	local status = battleUnitData:GetWakeStatus(wakeCid)

	if self.bossView ~= nil then
		self.bossView:AddWake(wakeCid, status)
	else
		self.wakeView:AddWake(wakeCid, status)
	end
end

function m:OnBattleUnitUpdateWakeStatus(wakeCid)
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(self.battleUnitID)
	local status = battleUnitData:GetWakeStatus(wakeCid)

	if self.bossView ~= nil then
		self.bossView:UpdateWakeStatus(wakeCid, status)
	else
		self.wakeView:UpdateWakeStatus(wakeCid, status)
	end
end

function m:OnBattleUnitRemoveWake(wakeCid)
	if self.bossView ~= nil then
		self.bossView:RemoveWake(wakeCid)
	else
		self.wakeView:RemoveWake(wakeCid)
	end
end

function m:OnBattleUnitUpdateWakeNum(num)
	if self.bossView ~= nil then
		self.bossView:UpdateWakeNum(num, true)
	else
		self.wakeNumView:UpdateWakeNum(num, true)
	end
end

function m:__EnableRageView(battleUnitData)
	self.rageView.isEnable = true

	self.rageView:Show()
end

function m:__DisableRageView()
	self.rageView.isEnable = false

	self.rageView:Hide()
end

function m:__OnBattleUnitRageChange(battleUnitID)
	if self.battleUnitID ~= battleUnitID then
		return
	end

	if not self.rageView.isEnable then
		return
	end

	self:__RefreshRageView()
end

function m:__RefreshRageView()
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(self.battleUnitID)

	self.rageView:Refresh(battleUnitData:GetEnergy2(), battleUnitData:GetEnergy2Max())
end

function m:ShowDamageEffect(battleDamageData)
	self.battleDamageQueue:Enqueue(battleDamageData)
end

function m:ShowEnergyNumber(energyNumber)
	self.battleDamageEffectPanelComponent:ShowEnergyNumber(energyNumber)
end

function m:__OnPopupBattleDamage()
	if self.battleDamageQueue.Size == 0 then
		self.__lastPopupTime = 0

		return
	end

	local __canPopup = true

	if self.__lastPopupTime > 0 and UnityEngine.Time.realtimeSinceStartup - self.__lastPopupTime < self.__battleDamageDetail then
		__canPopup = false
	end

	if not __canPopup then
		return
	end

	self.__lastPopupTime = UnityEngine.Time.realtimeSinceStartup

	local battleDamageData = self.battleDamageQueue:Dequeue()

	self.battleDamageEffectPanelComponent:ShowBattleDamageEffect(battleDamageData)
end

return m
