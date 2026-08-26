-- chunkname: @modules/logic/fight/view/FightMonsterBossHpFor610414.lua

module("modules.logic.fight.view.FightMonsterBossHpFor610414", package.seeall)

local FightMonsterBossHpFor610414 = class("FightMonsterBossHpFor610414", FightBaseView)

function FightMonsterBossHpFor610414:onConstructor(bossHpView, bossHpGO, bossEntityMO)
	self.bossHpView = bossHpView
	self.bossHpGO = bossHpGO
	self.bossEntityMO = bossEntityMO
end

function FightMonsterBossHpFor610414:onOpen()
	gohelper.setActive(gohelper.findChild(self.viewGO, "bossHpRoot/Line"), false)
	gohelper.setActive(gohelper.findChild(self.viewGO, "bossHpRoot/BossHP/#bar/#max"), false)

	self.bgRoot = gohelper.findChild(self.viewGO, "BG")

	gohelper.setActive(self.bgRoot, false)

	self.txtTipsRoot = gohelper.findChild(self.viewGO, "txtTips")

	gohelper.setActive(self.txtTipsRoot, false)

	self.skillRoot = gohelper.findChild(self.viewGO, "skill")

	gohelper.setActive(self.skillRoot, false)

	self.bottomLeftRoot = gohelper.findChild(self.viewGO, "bottomLeft")

	gohelper.setActive(self.bottomLeftRoot, false)

	self.storyRoot = gohelper.findChild(self.viewGO, "stroy")

	gohelper.setActive(self.storyRoot, false)

	self.animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)

	self.animator:Play("idle", 0, 0)

	self.hpAnimator = gohelper.findChildComponent(self.viewGO, "bossHpRoot/BossHP", gohelper.Type_Animator)

	self.hpAnimator:Play("open", 0, 0)

	self.image = gohelper.findChildImage(self.viewGO, "bossHpRoot/BossHP/#bar")
	self.image.fillAmount = 0

	gohelper.setActive(self.bossHpView.maskRoot, false)

	self.bossHpView._imgbossHpbg.enabled = false
	self.imageTransform = self.viewGO.transform

	recthelper.setSize(self.imageTransform, 720, 22)
	recthelper.setAnchor(self.imageTransform, 0, 60)
	self:com_registFightEvent(FightEvent.OnHpChange, self._onHpChange)
	self:com_registFightEvent(FightEvent.BeforeDestroyEntity, self._onBeforeDestroyEntity)
	self:com_registMsg(FightMsgId.AfterDestroyEntity, self._onAfterDestroyEntity)

	self.tweenComp = self:addComponent(FightTweenComponent)
end

function FightMonsterBossHpFor610414:_onBeforeDestroyEntity(entityId)
	if entityId ~= self.bossEntityMO.id then
		return
	end

	self.bossHpView.lockHpBySkin = false

	gohelper.setActive(self.bossHpView.maskRoot, true)

	self.bossHpView._imgbossHpbg.enabled = true

	self:disposeSelf()
end

function FightMonsterBossHpFor610414:_onAfterDestroyEntity(entityId)
	if entityId ~= self.bossEntityMO.id then
		return
	end

	self.bossHpView.lockHpBySkin = false

	gohelper.setActive(self.bossHpView.maskRoot, true)

	self.bossHpView._imgbossHpbg.enabled = true

	self:disposeSelf()
end

function FightMonsterBossHpFor610414:_onHpChange(defender)
	if defender.id ~= self.bossEntityMO.id then
		return
	end

	if self.isFull then
		return
	end

	local hpFillAmount = self.bossEntityMO.currentHp / self.bossEntityMO.attrMO.hp

	self.tweenComp:DOFillAmount(self.image, 1 - hpFillAmount, 0.2)
	self.hpAnimator:Play("hit", 0, 0)

	if hpFillAmount == 0 then
		self.isFull = true
	end
end

function FightMonsterBossHpFor610414:onDestructor()
	gohelper.destroy(self.viewGO)
end

return FightMonsterBossHpFor610414
