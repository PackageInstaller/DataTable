-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/battle/UnitCompBattleUI.lua

module("logicscene.scene.unit.component.battle.UnitCompBattleUI", package.seeall)

local UnitCompBattleUI = class("UnitCompBattleUI", UnitComponentBase)
local NameBarRoot, NameBarCanvas, DamageHudRoot, DamageHudCanvas, UICamera, GameCamera, SkillCamera, NameBarSkillCamRoot, NameBarSkillCamCanvas, DamageHudSkillCamRoot, DamageHudSkillCamCanvas, UICameraOnSkillCam

UnitCompBattleUI.DamageWuli = 1
UnitCompBattleUI.DamageMofa = 2
UnitCompBattleUI.DamageWuliBaoji = 3
UnitCompBattleUI.DamageMofaBaoji = 4
UnitCompBattleUI.DamageKeZhi = 5
UnitCompBattleUI.DamageDidang = 6
UnitCompBattleUI.AddHp = 7
UnitCompBattleUI.DamageBuff = 8
UnitCompBattleUI.AddHpBuff = 9
UnitCompBattleUI.Text = 10
UnitCompBattleUI.BuffText = 11
UnitCompBattleUI.DeBuffText = 12
UnitCompBattleUI.TotalDamage = 31
UnitCompBattleUI.BuffVigourAdd = 41
UnitCompBattleUI.BuffVigourSub = 42
UnitCompBattleUI.ShieldChange = 43
UnitCompBattleUI.BattleDamages = CommonResPath.BattleDamages
UnitCompBattleUI.BattleUITotalDamageTxtPath = CommonResPath.BattleUITotalDamageTxtPath
UnitCompBattleUI.BattleUIDamageTxtPath = CommonResPath.BattleUIDamageTxtPath
UnitCompBattleUI.BattleUIBuffDamage = CommonResPath.BattleUIBuffDamage
UnitCompBattleUI.BattleBuffVigourText = CommonResPath.BattleBuffVigourText
UnitCompBattleUI.BattleUIShieldTxtPath = CommonResPath.BattleUIShieldTxtPath

local SkillText = {
	Critical = 0,
	StrickBack = 2,
	CantExecuteSkill = 5,
	Block = 3,
	Immunity = 4,
	Dodge = 1
}

UnitCompBattleUI.BuffDamageOrigin = {
	Rebound = 1,
	Vigour = 3,
	Poison = 2,
	Burn = 0
}

local newHudDebuffs, newHudBuffs
local BloodBarTweenSpeed = 0.8
local SPECIAL_BUFF_LIST = {
	[13031608] = 7,
	[12017651] = 4,
	[14015651] = 3,
	[15050608] = 10,
	[11009651] = 2,
	[14044608] = 9,
	[12046608] = 8,
	[13007651] = 5,
	[15016651] = 1,
	[11042608] = 6
}

function UnitCompBattleUI:ctor(unit)
	UnitCompBattleUI.super.ctor(self, unit)

	self._InfoGo = nil
	self._bloodbar = nil
	self._angerbar = nil
	self._attrIcon = nil
	self._levelLabel = nil
	self._nameLabel = nil
	self._spineHeadPointGo = nil
	self._spineCenterPointGo = nil
	self._spineFootPointGo = nil
	self._huds = nil
	self._hudsMap = nil
	self._bloodValue = 1
	self._bloodStartValue = 1
	self._bloodTweenTime = -1
	self._bloodTweenDuration = 0

	self:_initCameras()
	self:_initPools()

	self._skillCanvas = nil
	self._isLoaded = nil
	self._currDamageHud = nil
	self._stopVigourMaxEff = nil
end

function UnitCompBattleUI:setVisible(visible)
	if self._InfoGo then
		self._InfoGo:SetActive(visible)
	end

	if self._vigourMaxEff then
		if self._stopVigourMaxEff then
			self._vigourMaxEff:setScale(0)
		else
			self._vigourMaxEff:setScale(1)
		end

		self._vigourMaxEff:setVisible(visible)
	end
end

function UnitCompBattleUI:updateBattleInfoType(infoType)
	self._levelLabel.gameObject:SetActive(false)
	self._levelBg.gameObject:SetActive(false)
	self._starsContainer:SetActive(false)
	self._txtZdl.gameObject:SetActive(false)
	self._zdlBg:SetActive(false)

	if infoType == BattleModel.InfoType_Hp_None then
		self._attrIcon.gameObject:SetActive(true)
		self._nameLabel.gameObject:SetActive(false)
		self._bloodbar.gameObject:SetActive(true)
		self._angerbar.gameObject:SetActive(true)
		self._attrIconBg:SetActive(true)
		self._levelLabel.gameObject:SetActive(false)
		self._levelBg:SetActive(false)
		self._bloodbarBg.gameObject:SetActive(true)

		self._stopVigourMaxEff = nil

		if self._vigourMaxEff then
			self._vigourMaxEff:setScale(1)
		end
	elseif infoType == BattleModel.InfoType_Hp_Vigour then
		self._attrIcon.gameObject:SetActive(true)
		self._nameLabel.gameObject:SetActive(false)
		self._attrIconBg:SetActive(true)
		self._levelBg:SetActive(false)
		self._bloodbar.gameObject:SetActive(true)
		self._angerbar.gameObject:SetActive(true)
		self._bloodbarBg.gameObject:SetActive(true)

		self._stopVigourMaxEff = nil

		if self._vigourMaxEff then
			self._vigourMaxEff:setScale(1)
		end

		self._levelLabel.gameObject:SetActive(true)
		self._levelBg.gameObject:SetActive(true)
	elseif infoType == BattleModel.InfoType_Hp_Vigour_Attr_Name_Level then
		self._attrIcon.gameObject:SetActive(true)
		self._attrIconBg:SetActive(true)
		self._nameLabel.gameObject:SetActive(false)
		self._bloodbar.gameObject:SetActive(true)
		self._angerbar.gameObject:SetActive(true)
		self._bloodbarBg.gameObject:SetActive(true)

		self._stopVigourMaxEff = nil

		if self._vigourMaxEff then
			self._vigourMaxEff:setScale(1)
		end

		self._levelLabel.gameObject:SetActive(true)
		self._levelBg:SetActive(self._unit.attrs:getLevel() > 0)
		self._levelLabel.gameObject:SetActive(true)
		self._levelBg.gameObject:SetActive(true)
		self._txtZdl.gameObject:SetActive(true)
		self._zdlBg:SetActive(true)
	end

	self:onUpdateAwakenSkillStatus()
	self:_onUpdateBuffStatus()
end

function UnitCompBattleUI:enabledFollowTargets(enabled)
	local cnt = #self._unitUIGo

	for i = 1, cnt do
		local followCom = self._unitUIGo[i]:GetComponent(ComponentType.UIFollowTarget)

		followCom.enabled = enabled
	end

	if self._goNameBar then
		local followCom = self._goNameBar:GetComponent(ComponentType.UIFollowTarget)

		followCom.enabled = enabled
	end
end

function UnitCompBattleUI:onSkillCamera(isHide)
	self._skillCanvas = isHide and true or nil

	if self._unitUIGo then
		local cnt = #self._unitUIGo

		for i = 1, cnt do
			local go = self._unitUIGo[i]

			self:_setDamageUILayer(go)
			self:_setDamageUIFollowCam(go)
		end
	end

	if self._goNameBar then
		self:_setUILayer(self._goNameBar)
		self:_setUIFollowCam(self._goNameBar)
	end
end

function UnitCompBattleUI:onFadeSkillCameara(hide)
	if self._unitUIGo then
		local cnt = #self._unitUIGo

		for i = 1, cnt do
			local go = self._unitUIGo[i]

			UnityTweens.UITweenFadeTo.StartSharedFade(go)
		end
	end

	if self._goNameBar then
		UnityTweens.UITweenFadeTo.StartSharedFade(self._goNameBar)
	end

	if self._vigourMaxEff then
		if not hide then
			self._vigourMaxEff:setVisible(true)
		else
			self._vigourMaxEff:setVisible(false)
		end
	end
end

function UnitCompBattleUI:onFade(hide, time)
	if self._unitUIGo then
		local cnt = #self._unitUIGo

		for i = 1, cnt do
			local go = self._unitUIGo[i]

			UnityTweens.UITweenFadeTo.StartTween(go, hide and 0 or 1, time)
		end
	end

	if self._goNameBar then
		UnityTweens.UITweenFadeTo.StartTween(self._goNameBar, hide and 0 or 1, time)
	end

	if self._vigourMaxEff then
		if not hide then
			self._vigourMaxEff:setVisible(true)
		else
			self._vigourMaxEff:setVisible(false)
		end
	end
end

function UnitCompBattleUI:onStartFakeFmt(cam)
	if self._unitUIGo then
		local cnt = #self._unitUIGo

		for i = 1, cnt do
			local go = self._unitUIGo[i]
			local followCom = go:GetComponent(ComponentType.UIFollowTarget)

			followCom.gameCamera = cam
		end
	end

	if self._goNameBar then
		local followCom = self._goNameBar:GetComponent(ComponentType.UIFollowTarget)

		followCom.gameCamera = cam
	end
end

function UnitCompBattleUI:onStopFakeFmt()
	if self._unitUIGo then
		local cnt = #self._unitUIGo

		for i = 1, cnt do
			local go = self._unitUIGo[i]
			local followCom = go:GetComponent(ComponentType.UIFollowTarget)

			followCom.gameCamera = self._skillCanvas and SkillCamera or GameCamera
		end
	end

	if self._goNameBar then
		local followCom = self._goNameBar:GetComponent(ComponentType.UIFollowTarget)

		followCom.gameCamera = self._skillCanvas and SkillCamera or GameCamera
	end
end

function UnitCompBattleUI:_setUIFollowCam(go)
	local camUI, camGame, canvas, parent

	if self._skillCanvas then
		camUI = UICameraOnSkillCam
		canvas = NameBarSkillCamCanvas
		camGame = SkillCamera
		parent = NameBarSkillCamRoot.transform
	else
		camUI = UICamera
		canvas = NameBarCanvas
		camGame = GameCamera
		parent = NameBarRoot.transform
	end

	if go.transform.parent ~= parent then
		go.transform:SetParent(parent)
		Framework.TransformUtil.SetLocalScale(go.transform, 1, 1, 1)

		local followCom = go:GetComponent(ComponentType.UIFollowTarget)

		followCom.uiCamera = camUI
		followCom.gameCamera = camGame
		followCom.canvas = canvas
	end
end

function UnitCompBattleUI:_setDamageUIFollowCam(go)
	local camUI, camGame, canvas, parent

	if go.transform.parent ~= DamageHudSkillCamRoot.transform then
		go.transform:SetParent(DamageHudSkillCamRoot.transform)
		Framework.TransformUtil.SetLocalScale(go.transform, 1, 1, 1)

		local followCom = go:GetComponent(ComponentType.UIFollowTarget)

		followCom.uiCamera = UICameraOnSkillCam
		followCom.gameCamera = SkillCamera
		followCom.canvas = DamageHudSkillCamCanvas
	end
end

function UnitCompBattleUI:_setUILayer(go)
	local layer = self._skillCanvas and SceneLayer.UI_Value or SceneLayer.UI1_Value

	if go.layer ~= layer then
		Framework.GameObjectUtil.SetLayerRecursively(go, layer)

		if self._vigourMaxEff then
			self._vigourMaxEff:setLayer(layer)
		end
	end
end

function UnitCompBattleUI:_setDamageUILayer(go)
	local layer

	if go.layer ~= SceneLayer.UI1_Value then
		Framework.GameObjectUtil.SetLayerRecursively(go, SceneLayer.UI1_Value)
	end
end

function UnitCompBattleUI:_initCameras()
	if not NameBarRoot then
		NameBarRoot = GlobalModel.instance.skillHUDLower
		NameBarCanvas = GlobalModel.instance.skillHUDLowerCanvas
		UICamera = GlobalModel.instance.skillUICamera
		DamageHudRoot = GlobalModel.instance.skillHUDHigher
		DamageHudCanvas = GlobalModel.instance.skillHUDHigherCanvas
		NameBarSkillCamRoot = SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.NameBar)
		NameBarSkillCamCanvas = NameBarSkillCamRoot:GetComponent("Canvas")
		DamageHudSkillCamRoot = SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.Bubble)
		DamageHudSkillCamCanvas = DamageHudSkillCamRoot:GetComponent("Canvas")
		UICameraOnSkillCam = GlobalModel.instance.uiCamera
		SkillCamera = GlobalModel.instance.skillCamera

		local mainCamera = CameraTargetMgr.instance:getMainCameraTarget()

		GameCamera = mainCamera:getCamera()
	end
end

function UnitCompBattleUI:_initPools()
	local resDamage = rescache:GetResourceNoLoadIfNotExists(UnitCompBattleUI.BattleUIDamageTxtPath):GetMainAsset()
	local resTotalDamage = rescache:GetResourceNoLoadIfNotExists(UnitCompBattleUI.BattleUITotalDamageTxtPath):GetMainAsset()
	local resDamageBuff = rescache:GetResourceNoLoadIfNotExists(UnitCompBattleUI.BattleUIBuffDamage):GetMainAsset()
	local resSkillText = rescache:GetResourceNoLoadIfNotExists(CommonResPath.BattleUISkillTextPath):GetMainAsset()
	local interfaceSkinId = BattleController:getBattleUserInterfaceSkinId()
	local damagesPrefab = rescache:GetResourceNoLoadIfNotExists(UnitCompBattleUI.BattleDamages):GetMainAsset()
	local resBuffText = rescache:GetResourceNoLoadIfNotExists(CommonResPath.BattleBuffText):GetMainAsset()
	local resBuffDebuffText = rescache:GetResourceNoLoadIfNotExists(CommonResPath.BattleDebuffText):GetMainAsset()
	local buffVigourText = rescache:GetResourceNoLoadIfNotExists(UnitCompBattleUI.BattleBuffVigourText):GetMainAsset()
	local resShieldText = rescache:GetResourceNoLoadIfNotExists(UnitCompBattleUI.BattleUIShieldTxtPath):GetMainAsset()
	local damageAttack = goutil.findChild(damagesPrefab, "attack")
	local damageBaoji = goutil.findChild(damagesPrefab, "baoji")
	local damageKezhi = goutil.findChild(damagesPrefab, "kezhi")
	local damageDidang = goutil.findChild(damagesPrefab, "didang")
	local damageAdd = goutil.findChild(damagesPrefab, "jiaxue")
	local damageKz = goutil.findChild(damagesPrefab, "kezhi")

	self._hudPools = {}
	self._hudPools[UnitCompBattleUI.DamageWuli] = BattleHudPoolHurtNum.New(damageAttack, resDamage, UnitCompBattleUI.DamageWuli, 15)
	self._hudPools[UnitCompBattleUI.DamageMofa] = BattleHudPoolHurtNum.New(damageAttack, resDamage, UnitCompBattleUI.DamageMofa, 15)
	self._hudPools[UnitCompBattleUI.DamageWuliBaoji] = BattleHudPoolHurtNum.New(damageBaoji, resDamage, UnitCompBattleUI.DamageBaoji, 15)
	self._hudPools[UnitCompBattleUI.DamageMofaBaoji] = BattleHudPoolHurtNum.New(damageBaoji, resDamage, UnitCompBattleUI.DamageBaoji, 15)
	self._hudPools[UnitCompBattleUI.DamageKeZhi] = BattleHudPoolHurtNum.New(damageKezhi, resDamage, UnitCompBattleUI.DamageKeZhi, 15)
	self._hudPools[UnitCompBattleUI.DamageDidang] = BattleHudPoolHurtNum.New(damageDidang, resDamage, UnitCompBattleUI.DamageDidang, 15)
	self._hudPools[UnitCompBattleUI.AddHp] = BattleHudPoolHurtNum.New(damageAdd, resDamage, UnitCompBattleUI.AddHp, 15)
	self._hudPools[UnitCompBattleUI.DamageBuff] = BattleHudPoolBuffDamage.New(damageAttack, resDamageBuff, UnitCompBattleUI.DamageBuff, 15)
	self._hudPools[UnitCompBattleUI.AddHpBuff] = BattleHudPoolBuffDamage.New(damageAdd, resDamageBuff, UnitCompBattleUI.AddHpBuff, 15)
	self._hudPools[UnitCompBattleUI.TotalDamage] = BattleHudPoolTotalDamage.New(damageBaoji, resTotalDamage, UnitCompBattleUI.TotalDamageWuli, 15)
	self._hudPools[UnitCompBattleUI.Text] = BattleHudPoolText.New(resSkillText, UnitCompBattleUI.Text, 15)
	self._hudPools[UnitCompBattleUI.BuffText] = BattleHudBuffTextPool.New(resBuffText, UnitCompBattleUI.BuffText, 15)
	self._hudPools[UnitCompBattleUI.DeBuffText] = BattleHudBuffTextPool.New(resBuffDebuffText, UnitCompBattleUI.DeBuffText, 15)
	self._hudPools[UnitCompBattleUI.BuffVigourAdd] = BattleHudPoolVigourNum.New(damageAdd, buffVigourText, UnitCompBattleUI.BuffVigourAdd, 15)
	self._hudPools[UnitCompBattleUI.BuffVigourSub] = BattleHudPoolVigourNum.New(damageAttack, buffVigourText, UnitCompBattleUI.BuffVigourSub, 15)
	self._hudPools[UnitCompBattleUI.ShieldChange] = BattleHudPoolShieldNum.New(damageAttack, resShieldText, UnitCompBattleUI.ShieldChange, 15)
end

function UnitCompBattleUI:_clearPools()
	if self._hudPools then
		for k, v in pairs(self._hudPools) do
			v:clear()
		end

		self._hudPools = nil
	end
end

function UnitCompBattleUI:onDestroy()
	self:stopVigourMaxEffect()

	if self._InfoGo then
		goutil.destroy(self._InfoGo)

		self._InfoGo = nil
	end

	self._bloodValue = nil
	self._bloodTweenTime = nil
	self._bloodStartValue = nil
	self._bloodTweenDuration = nil
	self._bloodbar = nil
	self._bloodbarBg = nil
	self._angerbar = nil
	self._attrIcon = nil
	self._levelLabel = nil
	self._nameLabel = nil
	self._isLoaded = nil

	self:_clearHuds()
	self:_clearPools()
	self:_clearUIRootNodes()
end

function UnitCompBattleUI:playVigourMaxEffect()
	if not self._vigourMaxEff then
		self._vigourMaxEff = UIEffectManager.instance:playHUDEffect(CommonResPath.VigourMaxEffPath, self._angerbar, true)

		if self._stopVigourMaxEff then
			self._vigourMaxEff:setScale(0)
		else
			self._vigourMaxEff:setScale(1)
		end
	end
end

function UnitCompBattleUI:stopVigourMaxEffect()
	if self._vigourMaxEff then
		UIEffectManager.instance:stopEffect(self._vigourMaxEff)

		self._vigourMaxEff = nil
	end
end

function UnitCompBattleUI:onVigourChange(curVigour, maxVigour)
	self._angerbar:SetValue(curVigour / maxVigour)
end

function UnitCompBattleUI:onShieldChange(changeValue, isShow)
	self:_updateShieldBar()

	if isShow == true then
		local hud = self._hudPools[UnitCompBattleUI.ShieldChange]:getHud()

		if hud then
			hud.damage = changeValue

			goutil.addChildToParent(hud.go, self._unitUIGo[GameEnum.MountPointType.Center])
			GameUtil.setLocalPos(hud.go, 0, 0, 0)

			hud.sprite = 0
			hud.isLast = true

			self:_setDamageUILayer(hud.go)
		end

		self:_startHud(hud)
	end
end

function UnitCompBattleUI:_updateShieldBar(maxHp)
	local attrs = self._unit.attrs

	if maxHp == nil then
		maxHp = attrs:getMaxHp()
	end

	local curShield = attrs:getCurShield()
	local curHpBarValue = self._bloodbar:GetValue()
	local shieldValue = curShield / maxHp
	local totalValue = curHpBarValue + shieldValue

	if totalValue < 1 then
		self._shieldBomBar:SetValue(totalValue)
		self._shieldTopBar:SetValue(0)
	else
		self._shieldBomBar:SetValue(0)
		self._shieldTopBar:SetValue(shieldValue / totalValue)
	end
end

function UnitCompBattleUI:setHpValue(curHp, maxHp)
	local val = curHp / maxHp

	self._bloodbarBg:SetValue(val)
	self._bloodbar:SetValue(val)

	self._bloodTweenDuration = -1

	self:_updateShieldBar(maxHp)
end

function UnitCompBattleUI:onHpChange(curHp, maxHp)
	local val = curHp / maxHp
	local currVal = self._bloodbar:GetValue()
	local currBg = self._bloodbarBg:GetValue()

	self._bloodValue = val

	if val < currVal then
		if val < currBg then
			self._bloodStartValue = currVal
			self._bloodTweenDuration = (currVal - val) / BloodBarTweenSpeed
			self._bloodTweenTime = 0

			if self._bloodTweenDuration > 0.5 then
				self._bloodTweenDuration = 0.5
			end
		else
			self._bloodTweenDuration = -1
			self._bloodStartValue = val

			self._bloodbarBg:SetValue(val)
		end
	elseif currVal < val then
		if val < currBg then
			self._bloodStartValue = currVal

			if self._bloodTweenDuration <= 0 then
				self._bloodTweenDuration = (currVal - val) / BloodBarTweenSpeed
				self._bloodTweenTime = 0

				if self._bloodTweenDuration > 0.5 then
					self._bloodTweenDuration = 0.5
				end
			end
		else
			self._bloodTweenDuration = -1
			self._bloodStartValue = val

			self._bloodbarBg:SetValue(val)
		end
	end

	self._bloodbar:SetValue(val)
	self:_updateShieldBar(maxHp)
end

function UnitCompBattleUI:setName(name)
	return
end

function UnitCompBattleUI:_setName(name)
	self._nameLabel.text = name
end

function UnitCompBattleUI:setLevel(lv)
	self._levelLabel.text = ""
	self._levelLabel.text = lv <= 0 and "" or lv .. "级"
	self._txtZdl.text = self._unit.zdl

	local awakenLv = self._unit.awakenLv
	local awakenCfg = CharacterConfig.instance:getAwakenRareCfg(awakenLv)

	if awakenCfg then
		for k, v in ipairs(self._stars) do
			v:SetActive(k <= awakenCfg.starNum)
		end
	end
end

function UnitCompBattleUI:setAttrs(attrs)
	if self._attrIcon then
		if not GameEnum.Races[attrs[1]] then
			local attr = 1

			if GameEnum.Races[attrs[1]] > 10 then
				attr = GameEnum.Races[attrs[1]] - 10
			end

			self._attrIcon:ChangeStateNow(GameEnum.Races[attrs[1]] - 1)
		end
	end
end

function UnitCompBattleUI:load()
	if self._isLoaded then
		return
	end

	self:_createUIRootNodes()

	local res
	local dirTeamId = BattleModel.instance:getTeamDirection(self._unit.teamId)

	res = dirTeamId == GameEnum.BattleTeam.Left and rescache:GetResourceNoLoadIfNotExists(CommonResPath.BattleUnitUIPath) or rescache:GetResourceNoLoadIfNotExists(CommonResPath.BattleUnitUIPath_Enemy)

	if not res then
		return
	end

	local prefab = res:GetMainAsset()

	if not prefab then
		return
	end

	self._InfoGo = goutil.clone(prefab)
	self._bloodbar = Framework.SliderAdapter.GetFrom(self._InfoGo, "bloodbar")
	self._bloodbarBg = Framework.SliderAdapter.GetFrom(self._InfoGo, "bloodbarBg")
	self._shieldBomBar = Framework.SliderAdapter.GetFrom(self._InfoGo, "shieldBomBar")
	self._shieldTopBar = Framework.SliderAdapter.GetFrom(self._InfoGo, "shieldTopBar")
	self._angerbar = Framework.SliderAdapter.GetFrom(self._InfoGo, "angerbar")
	self._attrIcon = goutil.findChild(self._InfoGo, "attricon"):GetComponent("UIImageSpriteChange")
	self._bloodBgImg = goutil.findChildImageComponent(self._InfoGo, "bloodbar/Fill Area/FillBg")
	self._levelLabel = goutil.findChildTextComponent(self._InfoGo, "level")
	self._nameLabel = goutil.findChildTextComponent(self._InfoGo, "name")
	self._levelBg = goutil.findChild(self._InfoGo, "lvlBg")
	self._attrIconBg = goutil.findChild(self._InfoGo, "AttrBg")
	self._starsContainer = goutil.findChild(self._InfoGo, "stars")
	self._stars = GameUtil.getChildren(self._starsContainer)
	self._skllStarsGo = goutil.findChild(self._InfoGo, "skll_stars")

	GameUtil.SetActive(self._skllStarsGo, false)

	local childCount = self._skllStarsGo.transform.childCount

	self._skillStarList = {}

	for i = 1, childCount do
		local go = goutil.findChild(self._InfoGo, "skll_stars/star_" .. i)

		table.insert(self._skillStarList, go)
	end

	self._buffsGo = goutil.findChild(self._InfoGo, "buffs")

	GameUtil.SetActive(self._buffsGo, false)

	local childCount = self._buffsGo.transform.childCount

	self._buffGoList = {}

	for i = 1, childCount do
		local go = self._buffsGo.transform:GetChild(i - 1).gameObject

		table.insert(self._buffGoList, go)
	end

	self._txtZdl = goutil.findChildTextComponent(self._InfoGo, "zdlBg/zdl")
	self._zdlBg = goutil.findChild(self._InfoGo, "zdlBg")

	local petCO = CharacterConfig.instance:getPetCo(self._unit.raceId)
	local races = self._unit.attrs:getAttributes()

	if not races or #races == 0 then
		races = PetSkinConfig.instance:getAllElementAttrs(self._unit.modelId)
	end

	self._InfoGo.name = "battleunitui_" .. self._unit.teamId .. "_" .. self._unit.id

	goutil.addChildToParent(self._InfoGo, self._goNameBar)
	Framework.TransformUtil.SetLocalPos(self._InfoGo.transform, 0, 0, 0)
	self:setAttrs(races)
	self:_setUILayer(self._InfoGo)

	self._isLoaded = true
end

function UnitCompBattleUI:updateUIInfo()
	local petCO = CharacterConfig.instance:getPetCo(self._unit.raceId)
	local races = self._unit.attrs:getAttributes()

	if not races or #races == 0 then
		races = PetSkinConfig.instance:getAllElementAttrs(self._unit.modelId)
	end

	self._InfoGo.name = "battleunitui_" .. self._unit.teamId .. "_" .. self._unit.id

	self:setAttrs(races)

	local cnt = #self._unitUIGo

	for i = 1, cnt do
		local go = self._unitUIGo[i]
		local followCom = go:GetComponent(ComponentType.UIFollowTarget)

		followCom.target = self._unit:getMountPoint(i).transform
		followCom.enabled = true
	end

	if self._goNameBar then
		local followCom = self._goNameBar:GetComponent(ComponentType.UIFollowTarget)

		followCom.target = self._unit:getMountPoint(GameEnum.MountPointType.Head).transform
		followCom.enabled = true
	end
end

function UnitCompBattleUI:onUIFollowBone(boneName)
	if self._unitUIGo then
		local cnt = #self._unitUIGo

		for i = 1, cnt do
			local go = self._unitUIGo[i]
			local followCom = go:GetComponent(ComponentType.UIFollowTarget)

			followCom.boneName = boneName
			followCom.skeletonGo = self._unit.go
		end
	end

	if self._goNameBar then
		local followCom = self._goNameBar:GetComponent(ComponentType.UIFollowTarget)

		followCom.boneName = boneName
		followCom.skeletonGo = self._unit.go
	end
end

function UnitCompBattleUI:onUIStopFollowBone()
	if self._unitUIGo then
		local cnt = #self._unitUIGo

		for i = 1, cnt do
			local go = self._unitUIGo[i]
			local followCom = go:GetComponent(ComponentType.UIFollowTarget)

			followCom.boneName = nil
			followCom.skeletonGo = nil
		end
	end

	if self._goNameBar then
		local followCom = self._goNameBar:GetComponent(ComponentType.UIFollowTarget)

		followCom.boneName = nil
		followCom.skeletonGo = nil
	end
end

function UnitCompBattleUI:update(deltaTime)
	self:_updateHuds(deltaTime)
	self:_updateBloodbar(deltaTime)
end

function UnitCompBattleUI:_updateHuds(deltaTime)
	if self._huds then
		local cnt = #self._huds
		local idx = 1

		while idx <= cnt do
			self._huds[idx]:update(deltaTime)

			if self._huds[idx]:isDone() then
				if self._huds[idx] == self._currDamageHud then
					self._currDamageHud = nil

					self._unit.buffPerform:waitingHud()
				end

				self._huds[idx]:finish()
				self._huds[idx]:recycle()

				self._hudsMap[self._huds[idx]] = nil

				table.remove(self._huds, idx)

				cnt = cnt - 1
			else
				idx = idx + 1
			end
		end
	end
end

function UnitCompBattleUI:_updateBloodbar(deltaTime)
	if self._bloodTweenDuration and self._bloodTweenDuration > 0 then
		self._bloodTweenTime = self._bloodTweenTime + deltaTime

		local percent = math.max(math.min(1, self._bloodTweenTime / self._bloodTweenDuration), 0)

		percent = -1 * math.cos(percent * math.pi * 0.5) + 1

		local val = self._bloodStartValue + (self._bloodValue - self._bloodStartValue) * percent

		self._bloodbarBg:SetValue(val)

		if self._bloodTweenTime >= self._bloodTweenDuration then
			self._bloodTweenDuration = -1
			self._bloodTweenTime = 0
		end
	end
end

function UnitCompBattleUI:onVigour(vigour)
	return
end

function UnitCompBattleUI:onBuffVigour(buffId, vigour)
	local hud, sprite

	if vigour > 0 then
		hud = self._hudPools[UnitCompBattleUI.BuffVigourAdd]:getHud()
		sprite = 0
	elseif vigour < 0 then
		hud = self._hudPools[UnitCompBattleUI.BuffVigourSub]:getHud()
		sprite = 1
	end

	if hud then
		hud.damage = vigour

		goutil.addChildToParent(hud.go, self._unitUIGo[GameEnum.MountPointType.Center])
		GameUtil.setLocalPos(hud.go, 0, 0, 0)

		hud.sprite = sprite

		self:_setDamageUILayer(hud.go)
		self:_startHud(hud)
	end
end

function UnitCompBattleUI:onTreated(treat)
	local hud = self._hudPools[UnitCompBattleUI.AddHp]:getHud()

	if hud then
		hud.isTreated = true
		hud.damage = treat
		hud.sprite = UnitCompBattleUI.AddHp - 1

		goutil.addChildToParent(hud.go, self._unitUIGo[GameEnum.MountPointType.Center])
		GameUtil.setLocalPos(hud.go, 0, 0, 0)
		self:_setDamageUILayer(hud.go)
	end

	self:_startHud(hud)
end

function UnitCompBattleUI:onDamagedTotal(damageEvt)
	if not self._lastTotalIndex or damageEvt.totalIndex == 1 then
		self._lastTotalIndex = UnitCompBattleUI.TotalDamage
	end

	local hud = self._hudPools[self._lastTotalIndex]:getHud()

	if hud then
		hud.damage = (hud.damage or 0) + damageEvt.damage
		hud.teamId = self._unit.teamId
		hud.isLast = damageEvt.totalIndex >= damageEvt.totalNum
		hud.isHurt = true

		goutil.addChildToParent(hud.go, UnitCompBattleUI.totalDamage)
		GameUtil.setLocalPos(hud.go, 0, 0, 0)
		self:_setDamageUILayer(hud.go)
	end

	self:_startHud(hud)
end

function UnitCompBattleUI:onUpdateAwakenSkillStatus()
	local active, cur, total, isAwakening = BattleAwakeChangeSkillModel.instance:getAwakenSkillStatus(self._unit.teamId, self._unit.id)

	GameUtil.SetActive(self._skllStarsGo, active)

	for i, go in ipairs(self._skillStarList) do
		GameUtil.SetActive(go, i <= total)

		if i <= cur then
			if isAwakening then
				GameUtil.setUIImageSpriteIdx(go, 2)
			else
				GameUtil.setUIImageSpriteIdx(go, 1)
			end
		else
			GameUtil.setUIImageSpriteIdx(go, 0)
		end
	end
end

function UnitCompBattleUI:removeAllBuff()
	self._buffGoMap = nil

	self:_onUpdateBuffStatus()
end

function UnitCompBattleUI:addBuff(buffId)
	local idx = SPECIAL_BUFF_LIST[buffId]

	if idx ~= nil then
		self._buffGoMap = self._buffGoMap or {}
		self._buffGoMap[idx] = true
	end

	self:_onUpdateBuffStatus()
end

function UnitCompBattleUI:removeBuffById(buffId)
	local idx = SPECIAL_BUFF_LIST[buffId]

	if idx ~= nil then
		self._buffGoMap = self._buffGoMap or {}
		self._buffGoMap[idx] = false
	end

	self:_onUpdateBuffStatus()
end

function UnitCompBattleUI:_onUpdateBuffStatus()
	local active = false

	for i, go in ipairs(self._buffGoList) do
		if self._buffGoMap and self._buffGoMap[i] then
			active = true

			GameUtil.SetActive(go, true)
		else
			GameUtil.SetActive(go, false)
		end
	end

	GameUtil.SetActive(self._buffsGo, active)
end

function UnitCompBattleUI:onTreatedTotal(damageEvt)
	return
end

function UnitCompBattleUI:onDamaged(damageEvt)
	local idx
	local qxIdx = -1
	local isLast = damageEvt.totalIndex >= damageEvt.totalNum

	if damageEvt.isCritical then
		idx = CharactorFacade.instance:isMagicPet(damageEvt.curFaceId) and UnitCompBattleUI.DamageMofaBaoji or UnitCompBattleUI.DamageWuliBaoji
		qxIdx = idx - 1
	else
		idx = (not damageEvt.race or damageEvt.race == 1 or not damageEvt.attackerType) and (CharactorFacade.instance:isMagicPet(damageEvt.curFaceId) and UnitCompBattleUI.DamageMofa or UnitCompBattleUI.DamageWuli) or damageEvt.race < 1 and UnitCompBattleUI.DamageDidang or UnitCompBattleUI.DamageKeZhi
		qxIdx = idx - 1
	end

	local hud = self._hudPools[idx]:getHud()

	if hud then
		hud.damage = damageEvt.damage

		goutil.addChildToParent(hud.go, self._unitUIGo[GameEnum.MountPointType.Center])
		GameUtil.setLocalPos(hud.go, 0, 0, 0)

		hud.sprite = damageEvt.showDamageText and qxIdx >= 0 and qxIdx or nil
		hud.isLast = isLast

		self:_setDamageUILayer(hud.go)
	end

	self:_startHud(hud)
end

function UnitCompBattleUI:isPerformingHuds()
	if self._huds then
		local cnt = #self._huds

		for i = 1, cnt do
			if self._huds[i]:isFadingIn() then
				return true
			end
		end
	end

	if self._currDamageHud and self._currDamageHud:isFadingIn() then
		return true
	end
end

function UnitCompBattleUI:_startHud(hud)
	hud.unit = self._unit

	hud:start()

	self._huds = self._huds or {}
	self._hudsMap = self._hudsMap or {}

	if not self._hudsMap[hud] then
		self._hudsMap[hud] = true

		table.insert(self._huds, hud)

		if hud.pool.needCache then
			if self._currDamageHud then
				self._currDamageHud:forcePositionOut()
			end

			self._currDamageHud = hud

			self._unit.buffPerform:waitingHud(hud)
		end
	end

	hud.go.transform:SetAsLastSibling()
end

function UnitCompBattleUI:onCritialDamaged(damageEvt)
	self:onDamaged(damageEvt)
end

function UnitCompBattleUI:onBuffDamage(damage, sprite)
	local hud = damage > 0 and self._hudPools[UnitCompBattleUI.AddHp]:getHud() or self._hudPools[UnitCompBattleUI.DamageBuff]:getHud()

	if hud then
		hud.damage = damage
		hud.sprite = sprite

		goutil.addChildToParent(hud.go, self._unitUIGo[GameEnum.MountPointType.Center])
		GameUtil.setLocalPos(hud.go, 0, 0, 0)
		self:_setDamageUILayer(hud.go)
	end

	self:_startHud(hud)
end

function UnitCompBattleUI:onBuffText(textId, isDebuff)
	if not self._unit:haveBeenSummoned() or not self._unit:haveBeenSummoned() then
		return
	end

	local hud = isDebuff and self._hudPools[UnitCompBattleUI.DeBuffText]:getHud() or self._hudPools[UnitCompBattleUI.BuffText]:getHud()

	if hud then
		hud.textId = textId

		goutil.addChildToParent(hud.go, self._unitUIGo[GameEnum.MountPointType.Center])
		GameUtil.setLocalPos(hud.go, 0, 0, 0)
		self:_setDamageUILayer(hud.go)
	end

	self:_startHud(hud)
	self:_adjustBuffTextPosition()
end

function UnitCompBattleUI:_adjustBuffTextPosition()
	if self._huds then
		local cnt = #self._huds

		for i = 1, cnt do
			if self._huds[i].pool.hudType == UnitCompBattleUI.BuffText then
				if self._huds[i].time == 0 then
					newHudBuffs = newHudBuffs or {}

					table.insert(newHudBuffs, self._huds[i])
				end
			elseif self._huds[i].pool.hudType == UnitCompBattleUI.DeBuffText and self._huds[i].time == 0 then
				newHudDebuffs = newHudDebuffs or {}

				table.insert(newHudDebuffs, self._huds[i])
			end
		end
	end

	if newHudDebuffs then
		local cnt = #newHudDebuffs

		if cnt > 0 then
			self:_adjustHudsWithHorCenter(newHudDebuffs, cnt, 100)
			table.clear(newHudDebuffs)
		end
	end

	if newHudBuffs then
		local cnt = #newHudBuffs

		if cnt > 0 then
			self:_adjustHudsWithHorCenter(newHudBuffs, cnt, 100)
			table.clear(newHudBuffs)
		end
	end
end

function UnitCompBattleUI:_adjustHudsWithHorCenter(huds, cnt, horizontalSpace)
	if cnt <= 1 then
		return
	end

	local mod = cnt % 2
	local halfNum = math.floor(cnt / 2)
	local startPos = 0

	if mod == 0 then
		halfNum = halfNum - 1

		local halfSpace = 0.5 * horizontalSpace

		startPos = -(halfNum * horizontalSpace + halfSpace)
	else
		startPos = -halfNum * horizontalSpace
	end

	for i = 1, cnt do
		local tf = huds[i].go.transform
		local x = startPos + horizontalSpace * (i - 1)

		Framework.TransformUtil.SetLocalPos(tf, x, 0, 0)
	end
end

function UnitCompBattleUI:onTextHud(sprite, node, offsetX, offsetY)
	node = node or self._unitUIGo[GameEnum.MountPointType.Front]

	local hud = self._hudPools[UnitCompBattleUI.Text]:getHud()

	if hud then
		hud.offsetX = offsetX or 40
		hud.offsetY = offsetY or -20
		hud.sprite = sprite

		goutil.addChildToParent(hud.go, node)
		GameUtil.setLocalPos(hud.go, 0, 0, 0)
		self:_setDamageUILayer(hud.go)
	end

	self:_startHud(hud)
end

function UnitCompBattleUI:onDodge()
	self:onTextHud(SkillText.Dodge)
end

function UnitCompBattleUI:onStrickBack()
	self:onTextHud(SkillText.StrickBack)
end

function UnitCompBattleUI:onBlock()
	self:onTextHud(SkillText.Block)
end

function UnitCompBattleUI:onImmunity()
	self:onTextHud(SkillText.Immunity)
end

function UnitCompBattleUI:onCantExecuteSkill()
	self:onTextHud(SkillText.CantExecuteSkill)
end

function UnitCompBattleUI:_createUIRootNodes()
	local res = rescache:GetResourceNoLoadIfNotExists(CommonResPath.BattleUnitUIRoot)

	if not res then
		return
	end

	local prefab = res:GetMainAsset()

	if not prefab then
		return
	end

	self._unitUIGo = {}

	for i = 1, GameEnum.MountPointType.Count do
		local go = goutil.clone(prefab)

		goutil.addChildToParent(go, DamageHudSkillCamRoot)
		Framework.GameObjectUtil.SetLayerRecursively(go, SceneLayer.UI_Value)

		go.name = "battleunitui_" .. self._unit.teamId .. "_" .. self._unit.id

		local followCom = go:GetComponent(ComponentType.UIFollowTarget)

		followCom.uiCamera = UICamera
		followCom.gameCamera = GameCamera
		followCom.target = self._unit:getMountPoint(i).transform
		followCom.canvas = DamageHudCanvas
		self._unitUIGo[i] = go
	end

	local goNameBar = goutil.clone(prefab)
	local followCom = goNameBar:GetComponent(ComponentType.UIFollowTarget)

	goNameBar.name = "battleunitui_" .. self._unit.teamId .. "_" .. self._unit.id
	followCom.uiCamera = UICamera
	followCom.gameCamera = GameCamera
	followCom.target = self._unit:getMountPoint(GameEnum.MountPointType.Head).transform
	followCom.canvas = NameBarCanvas
	self._goNameBar = goNameBar

	goutil.addChildToParent(goNameBar, NameBarRoot)
	Framework.GameObjectUtil.SetLayerRecursively(goNameBar, SceneLayer.UI1_Value)
end

function UnitCompBattleUI:_clearUIRootNodes()
	if self._unitUIGo then
		for k, v in pairs(self._unitUIGo) do
			goutil.destroy(v, true)
		end

		self._unitUIGo = nil
	end

	if self._goNameBar then
		goutil.destroy(self._unitUIGo, true)

		self._goNameBar = nil
	end
end

function UnitCompBattleUI:_clearHuds()
	if self._huds then
		for k, v in pairs(self._huds) do
			local cnt = #v

			for i = 1, cnt do
				v[i]:finish()
				v[i]:recycle()
			end
		end

		self._huds = nil
	end

	self._hudsMap = nil
	self._currDamageHud = nil
end

return UnitCompBattleUI
