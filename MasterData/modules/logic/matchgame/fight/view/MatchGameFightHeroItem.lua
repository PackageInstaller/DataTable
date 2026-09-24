-- chunkname: @modules/logic/matchgame/fight/view/MatchGameFightHeroItem.lua

module("modules.logic.matchgame.fight.view.MatchGameFightHeroItem", package.seeall)

local MatchGameFightHeroItem = class("MatchGameFightHeroItem", LuaCompBase)

function MatchGameFightHeroItem:ctor(param)
	self.param = param
	self.posIndex = param.posIndex
	self.fightView = param.fightView
	self.goAttackFlyItem = param.goAttackFlyItem
	self.startFlyPos = param.startFlyPos
	self.startFlyPos.x = self.startFlyPos.x + 60
	self.startFlyPos.y = self.startFlyPos.y + 100
	self.endFlyPos = param.endFlyPos
	self.roleMaterial = UnityEngine.GameObject.Instantiate(param.roleMaterial)
end

function MatchGameFightHeroItem:init(go)
	self:__onInit()

	self.go = go
	self.simageHero = gohelper.findChildSingleImage(self.go, "hero/ani/#simage_hero")
	self.imageHero = gohelper.findChildImage(self.go, "hero/ani/#simage_hero")
	self.goMesh = gohelper.findChild(self.go, "hero/ani/go_mesh")
	self.goAttack = gohelper.findChild(self.go, "go_attack")
	self.txtAttack = gohelper.findChildText(self.go, "go_attack/txt_attack")
	self.goAttackBgNormal = gohelper.findChild(self.go, "go_attack/bg_normal")
	self.gpAttackBgMax = gohelper.findChild(self.go, "go_attack/bg_max")
	self.goEffectContent = gohelper.findChild(self.go, "go_effectContent")
	self.anim = self.go:GetComponent(typeof(UnityEngine.Animator))

	local paramData = {
		fightView = self.fightView,
		goEffectContent = self.goEffectContent,
		roleAnim = self.anim
	}

	self.roleEffectComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.go, MatchGameFightRoleEffect, paramData)
	self.attackAnim = self.goAttack:GetComponent(typeof(UnityEngine.Animator))
end

function MatchGameFightHeroItem:loadEffect()
	return
end

function MatchGameFightHeroItem:addEventListeners()
	return
end

function MatchGameFightHeroItem:removeEventListeners()
	return
end

function MatchGameFightHeroItem:refreshUI(heroFightMo, isResetRoundData)
	self.heroFightMo = heroFightMo or self.heroFightMo

	gohelper.setActive(self.go, heroFightMo.id ~= 0)

	if isResetRoundData then
		self.lastDamage = heroFightMo.damage
	end

	if heroFightMo.damage > 0 then
		self.txtAttack.text = heroFightMo.damage or ""
	end

	self:playAttackTxtAnim()
	gohelper.setActive(self.goAttackBgNormal, heroFightMo.damage < MatchGameFightEnum.HeroHeavyDamage)
	gohelper.setActive(self.gpAttackBgMax, heroFightMo.damage >= MatchGameFightEnum.HeroHeavyDamage)
	self.simageHero:LoadImage(self.heroFightMo.config.image, self.setHeroImageSize, self)

	self.imageHero.material = self.roleMaterial
	self.heroMeshComp = self.heroMeshComp or MonoHelper.addNoUpdateLuaComOnceToGo(self.goMesh, MatchGameFightRoleMesh)

	self.heroMeshComp:refreshMesh(self.heroFightMo.config)
end

function MatchGameFightHeroItem:resetHeroItem(heroFightMo)
	self.heroFightMo = heroFightMo or self.heroFightMo

	gohelper.setActive(self.go, heroFightMo.id ~= 0)

	if heroFightMo.damage > 0 then
		self.txtAttack.text = heroFightMo.damage or ""
	end

	self.lastDamage = heroFightMo.damage

	gohelper.setActive(self.goAttackBgNormal, heroFightMo.damage < MatchGameFightEnum.HeroHeavyDamage)
	gohelper.setActive(self.gpAttackBgMax, heroFightMo.damage >= MatchGameFightEnum.HeroHeavyDamage)
end

function MatchGameFightHeroItem:playAttackTxtAnim()
	self.lastDamage = self.lastDamage or self.heroFightMo.damage
	self.lastGiddyState = self.lastGiddyState or self.heroFightMo.giddyState

	if self.lastDamage == 0 and self.heroFightMo.damage > 0 and not self.heroFightMo.giddyState then
		gohelper.setActive(self.goAttack, true)
		self:playAttackAnim("open")
	elseif self.lastDamage > 0 and self.heroFightMo.damage == 0 or not self.lastGiddyState and self.heroFightMo.giddyState then
		self:playAttackAnim("close")
		TaskDispatcher.runDelay(self.hideAttackGO, self, 0.167)
	elseif self.lastDamage < MatchGameFightEnum.HeroHeavyDamage and self.heroFightMo.damage >= MatchGameFightEnum.HeroHeavyDamage and not self.heroFightMo.giddyState then
		gohelper.setActive(self.goAttack, true)
		self:playAttackAnim("max")
	elseif self.lastDamage > 0 and self.heroFightMo.damage > self.lastDamage and not self.heroFightMo.giddyState then
		gohelper.setActive(self.goAttack, true)
		self:playAttackAnim("add")
	elseif self.lastDamage > 0 and self.heroFightMo.damage > 0 and not self.heroFightMo.giddyState then
		gohelper.setActive(self.goAttack, true)
	else
		gohelper.setActive(self.goAttack, false)
	end

	self.lastDamage = self.heroFightMo.damage
	self.lastGiddyState = self.heroFightMo.giddyState
end

function MatchGameFightHeroItem:playEffectFlying(attackNum)
	self.attackNum = attackNum

	gohelper.setActive(self.goAttack, false)

	self.txtAttack.text = ""

	gohelper.setActive(self.goAttackFlyItem.go, true)
	gohelper.setActive(self.goAttackFlyItem.flyGO, false)
	self.goAttackFlyItem.comp:SetOneFlyItemBeginCallback(self.onFlyBegin, self, self.goAttackFlyItem)
	self.goAttackFlyItem.comp:SetOneFlyItemDoneCallback(self.onFlyDone, self, self.goAttackFlyItem)

	self.goAttackFlyItem.comp.startPosition = self.startFlyPos
	self.goAttackFlyItem.comp.endPosition = self.endFlyPos

	gohelper.setActive(self.goAttackFlyItem.compGO, true)
	self.goAttackFlyItem.comp:StartFlying()
	AudioMgr.instance:trigger(MatchGameAudioEnum.play_ui_yingmen_skill_fly)
end

function MatchGameFightHeroItem:onFlyBegin(goAttackFlyItem, flyObjct)
	local normalBg = gohelper.findChild(flyObjct, "#fly_skillPoint/go_attack/bg_normal")
	local maxBg = gohelper.findChild(flyObjct, "#fly_skillPoint/go_attack/bg_max")
	local txtAttack = gohelper.findChildText(flyObjct, "#fly_skillPoint/go_attack/txt_attack")

	txtAttack.text = self.heroFightMo.damage

	gohelper.setActive(normalBg, self.heroFightMo.damage < MatchGameFightEnum.HeroHeavyDamage)
	gohelper.setActive(maxBg, self.heroFightMo.damage >= MatchGameFightEnum.HeroHeavyDamage)
end

function MatchGameFightHeroItem:onFlyDone(goAttackFlyItem, index, flyObject)
	self.flyObject = flyObject

	self.fightView:doEnemyRealHurt(self.attackNum)

	self.flyItem = goAttackFlyItem

	TaskDispatcher.cancelTask(self.hideAttackFlyItem, self)
	TaskDispatcher.runDelay(self.hideAttackFlyItem, self, 0.5)
end

function MatchGameFightHeroItem:hideAttackFlyItem()
	gohelper.setActive(self.flyItem.compGO, false)
	gohelper.setActive(self.flyItem.go, false)
	gohelper.setActive(self.flyObject, false)
end

function MatchGameFightHeroItem:playAttackAnim(animName)
	self.attackAnim:Play(animName, 0, 0)
	self.attackAnim:Update(0)
end

function MatchGameFightHeroItem:hideAttackGO()
	gohelper.setActive(self.goAttack, false)
end

function MatchGameFightHeroItem:setHeroImageSize()
	ZProj.UGUIHelper.SetImageSize(self.simageHero.gameObject)
end

function MatchGameFightHeroItem:onDestroy()
	self.simageHero:UnLoadImage()
	TaskDispatcher.cancelTask(self.hideAttackGO, self)
	TaskDispatcher.cancelTask(self.hideAttackFlyItem, self)

	if self.roleMaterial then
		UnityEngine.Object.Destroy(self.roleMaterial)
	end
end

return MatchGameFightHeroItem
