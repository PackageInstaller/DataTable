-- chunkname: @modules/logic/fight/view/FightMonsterBossHpFor610416.lua

module("modules.logic.fight.view.FightMonsterBossHpFor610416", package.seeall)

local FightMonsterBossHpFor610416 = class("FightMonsterBossHpFor610416", FightBaseView)

function FightMonsterBossHpFor610416:onConstructor(bossHpView, bossHpGO, bossEntityMO)
	self.bossHpView = bossHpView
	self.bossHpGO = bossHpGO
	self.bossEntityMO = bossEntityMO
end

function FightMonsterBossHpFor610416:onOpen()
	gohelper.setActive(gohelper.findChild(self.viewGO, "bossHpRoot/Line"), false)
	gohelper.setActive(gohelper.findChild(self.viewGO, "bossHpRoot/BossHP/#bar/#max"), true)

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
	self.bossHpRoot = gohelper.findChild(self.viewGO, "bossHpRoot/BossHP")
	self.hpAnimator = SLFramework.AnimatorPlayer.Get(self.bossHpRoot)
	self.image = gohelper.findChildImage(self.viewGO, "bossHpRoot/BossHP/#bar")
	self.image.fillAmount = 1
	self.imageTransform = self.viewGO.transform

	recthelper.setSize(self.imageTransform, 720, 22)
	recthelper.setAnchor(self.imageTransform, 0, 60)
	self:com_registMsg(FightMsgId.Before3_7BossQte, self.onBefore3_7BossQte)
	self:com_registFightEvent(FightEvent.OnHpChange, self._onHpChange)
	self:com_registMsg(FightMsgId.OnAddBuff, self.onAddBuff)
	gohelper.setActive(self.viewGO, false)
end

function FightMonsterBossHpFor610416:onAddBuff(buff)
	if buff.buffId ~= 117371036 then
		return
	end

	self:com_registTimer(self.showView, 0.5)
end

function FightMonsterBossHpFor610416:showView()
	gohelper.setActive(self.viewGO, true)
	self.animator:Play("idle", 0, 0)
	self.hpAnimator:Play("max", self.onHpEnterFinish, self)
end

function FightMonsterBossHpFor610416:onHpEnterFinish()
	gohelper.setActive(self.bossHpView.maskRoot, false)

	self.bossHpView._imgbossHpbg.enabled = false
end

function FightMonsterBossHpFor610416:onBefore3_7BossQte()
	self.bossHpView.lockHpBySkin = false

	gohelper.setActive(self.bossHpView.maskRoot, true)

	self.bossHpView._imgbossHpbg.enabled = true

	self:disposeSelf()
end

function FightMonsterBossHpFor610416:_onHpChange(defender)
	if defender.id ~= self.bossEntityMO.id then
		return
	end

	self.hpAnimator:Play("maxhit", nil, nil)
end

function FightMonsterBossHpFor610416:onDestructor()
	gohelper.destroy(self.viewGO)
end

return FightMonsterBossHpFor610416
