-- chunkname: @modules/logic/versionactivity3_3/igor/view/comp/IgorCampHpComp.lua

module("modules.logic.versionactivity3_3.igor.view.comp.IgorCampHpComp", package.seeall)

local IgorCampHpComp = class("IgorCampHpComp", LuaCompBase)

function IgorCampHpComp:init(go)
	self.go = go
	self.transform = self.go.transform
end

function IgorCampHpComp:setCampRoot(campRoot)
	self.campRoot = campRoot
	self.campAnim = self.campRoot:GetComponent(typeof(UnityEngine.Animator))
	self.goHitLight = gohelper.findChild(self.campRoot, "image/image_light")
end

function IgorCampHpComp:initOur()
	self.imgHp = gohelper.findChildImage(self.go, "hp/hp1")
	self.imgHpTween = gohelper.findChildImage(self.go, "hp/hp3")
	self.txtHp = gohelper.findChildTextMesh(self.go, "hp/txthp")
	self.txtSkillTimes1 = gohelper.findChildTextMesh(self.go, "skill1/txtTimes")
	self.txtSkillTimes2 = gohelper.findChildTextMesh(self.go, "skill2/txtTimes")
	self.goLevelup = gohelper.findChild(self.campRoot, "vx_up/levelup")
	self.goAttackup = gohelper.findChild(self.campRoot, "vx_up/attackup")
	self.goShieldup = gohelper.findChild(self.campRoot, "vx_up/shieldup")
	self.goLevelupIcon = gohelper.findChild(self.campRoot, "Icons/Icon1")
	self.goAttackupIcon = gohelper.findChild(self.campRoot, "Icons/Icon2")
	self.goShieldupIcon = gohelper.findChild(self.campRoot, "Icons/Icon3")
end

function IgorCampHpComp:initEnemy()
	self.txtName = gohelper.findChildTextMesh(self.go, "txtname")
	self.imgHpTween = gohelper.findChildImage(self.go, "hp/image")
	self.txtHp = gohelper.findChildTextMesh(self.go, "hp/txthp")
	self.txtSkillTimes1 = gohelper.findChildTextMesh(self.go, "skill1/txtTimes")
	self.txtSkillTimes2 = gohelper.findChildTextMesh(self.go, "skill2/txtTimes")
end

function IgorCampHpComp:addEventListeners()
	self.addEventCb(self, IgorController.instance, IgorEvent.OnCampAttrChange, self.onCampAttrChange, self)
end

function IgorCampHpComp:removeEventListeners()
	self.removeEventCb(self, IgorController.instance, IgorEvent.OnCampAttrChange, self.onCampAttrChange, self)
end

function IgorCampHpComp:onCampAttrChange(comp, skillType)
	if skillType == IgorEnum.SkillType.Transfer then
		return
	end

	if comp == self.campMo then
		self:refreshSkillTimes()
		self:playBuff(skillType)
	end
end

function IgorCampHpComp:setData(campMo)
	self.campMo = campMo

	if self:isOurSide() then
		self:initOur()
	else
		self:initEnemy()
	end

	self:refresh()
end

function IgorCampHpComp:refresh()
	self:refreshSkillTimes()
	self:refreshHp()
end

function IgorCampHpComp:refreshSkillTimes()
	local times1 = 1
	local times2 = 1

	if self:isOurSide() then
		local skillData = self.campMo:getSkillMO(IgorEnum.SkillType.Attack)

		times1 = self.campMo.level
		times2 = skillData:getSkillUseTimes()
	end

	self.txtSkillTimes1.text = string.format("<size=14>LV.</size>%s", times1)
	self.txtSkillTimes2.text = string.format("<size=14>LV.</size>%s", times2)
end

function IgorCampHpComp:refreshHp(tween)
	local hp = self.campMo:getHealth()

	hp = math.max(0, hp)

	local maxHp = self.campMo:getMaxHealth()

	if hp == self.lastHp and maxHp == self.lastMaxHp then
		return
	end

	if self.lastHp then
		local isHit = hp < self.lastHp

		self:clearTween()

		self.lastHp = hp
		self.lastMaxHp = maxHp
		self.txtHp.text = string.format("%s/%s", hp, maxHp)

		local endValue = hp / maxHp

		if tween then
			self.hpTweenId = ZProj.TweenHelper.DOFillAmount(self.imgHpTween, endValue, 0.2, self.onHpTweenComplete, self, nil, EaseType.Linear)
		else
			self.imgHpTween.fillAmount = endValue
		end

		if isHit then
			self:onHit()
		end

		if not gohelper.isNil(self.imgHp) then
			self.imgHp.fillAmount = endValue
		end
	end
end

function IgorCampHpComp:onHpTweenComplete()
	if self.lastHp and self.lastHp <= 0 then
		self:onDead()
	end
end

function IgorCampHpComp:isOurSide()
	return self.campMo.campType == IgorEnum.CampType.Ourside
end

function IgorCampHpComp:clearTween()
	if self.hpTweenId then
		ZProj.TweenHelper.KillById(self.hpTweenId)

		self.hpTweenId = nil
	end
end

function IgorCampHpComp:getEntityMo()
	return self.campMo
end

function IgorCampHpComp:onUpdate(deltaTime)
	self:updateState()
end

function IgorCampHpComp:updateState()
	local mo = self:getEntityMo()

	if not mo then
		return
	end

	local isStateChange = mo:getIsStateChange()

	if not isStateChange then
		return
	end

	local state = mo:getCurState()

	if state == IgorEnum.EntityState.Attack then
		self:playAnimation(IgorEnum.EntityAnimName.Attack, 0.33)
		AudioMgr.instance:trigger(AudioEnum3_3.Igor.play_ui_yuanzheng_igor_artillery)
	elseif state == IgorEnum.EntityState.WaitAttack then
		if not self.state then
			self:playAnimation(IgorEnum.EntityAnimName.Idle)
		end
	elseif state == IgorEnum.EntityState.Die then
		self:onDead()
	else
		self:playAnimation(IgorEnum.EntityAnimName.Idle)
	end
end

function IgorCampHpComp:playBuff(skillType)
	AudioMgr.instance:trigger(AudioEnum3_3.Igor.play_ui_yuanzheng_igor_upgrade)
	self:setBuffActive(skillType)
	self:playAnimation("buff", 1, true)
end

function IgorCampHpComp:setBuffActive(skillType)
	gohelper.setActive(self.goLevelup, false)
	gohelper.setActive(self.goAttackup, false)
	gohelper.setActive(self.goShieldup, false)
	gohelper.setActive(self.goLevelupIcon, false)
	gohelper.setActive(self.goAttackupIcon, false)
	gohelper.setActive(self.goShieldupIcon, false)
	gohelper.setActive(self.goLevelup, skillType == IgorEnum.SkillType.Levup)
	gohelper.setActive(self.goAttackup, skillType == IgorEnum.SkillType.Attack)
	gohelper.setActive(self.goShieldup, skillType == IgorEnum.SkillType.Defense)
	gohelper.setActive(self.goLevelupIcon, skillType == IgorEnum.SkillType.Levup)
	gohelper.setActive(self.goAttackupIcon, skillType == IgorEnum.SkillType.Attack)
	gohelper.setActive(self.goShieldupIcon, skillType == IgorEnum.SkillType.Defense)
end

function IgorCampHpComp:playAnimation(state, time, force)
	if self.state == state and not force then
		return
	end

	if self.state == "buff" then
		self.waitState = state
		self.waitStateTime = time

		return
	end

	self.state = state

	self.campAnim:Play(state, 0, 0)
	TaskDispatcher.cancelTask(self.onAnimationDone, self)

	if time and time > 0 then
		TaskDispatcher.runDelay(self.onAnimationDone, self, time)
	end
end

function IgorCampHpComp:onAnimationDone()
	if self.state == IgorEnum.EntityAnimName.Damage then
		GameUtil.setActiveUIBlock("IgorGameView", false, false)

		local gameMO = IgorModel.instance:getCurGameMo()

		IgorController.instance:openGameResultView(not self:isOurSide(), gameMO.episodeCo)
	end

	self.state = nil

	if self.waitState then
		local waitState = self.waitState
		local waitStateTime = self.waitStateTime

		self.waitState = nil
		self.waitStateTime = nil

		self:playAnimation(waitState, waitStateTime)
	end
end

function IgorCampHpComp:onDead()
	AudioMgr.instance:trigger(AudioEnum3_3.Igor.play_ui_yuanzheng_igor_destroy)
	self:playAnimation(IgorEnum.EntityAnimName.Damage, 0.67)
	GameUtil.setActiveUIBlock("IgorGameView", true, false)
end

function IgorCampHpComp:onHit()
	gohelper.setActive(self.goHitLight, false)
	gohelper.setActive(self.goHitLight, true)
end

function IgorCampHpComp:onDestroy()
	self:clearTween()
	GameUtil.setActiveUIBlock("IgorGameView", false, false)
end

return IgorCampHpComp
