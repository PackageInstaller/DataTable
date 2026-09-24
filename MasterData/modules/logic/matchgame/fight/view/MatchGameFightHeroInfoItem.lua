-- chunkname: @modules/logic/matchgame/fight/view/MatchGameFightHeroInfoItem.lua

module("modules.logic.matchgame.fight.view.MatchGameFightHeroInfoItem", package.seeall)

local MatchGameFightHeroInfoItem = class("MatchGameFightHeroInfoItem", LuaCompBase)

function MatchGameFightHeroInfoItem:ctor(param)
	self.param = param
	self.posIndex = param.posIndex
	self.fightView = param.fightView
end

function MatchGameFightHeroInfoItem:init(go)
	self:__onInit()

	self.go = go
	self.simageHero = gohelper.findChildSingleImage(self.go, "root/HeadMask/simage_hero")
	self.imageSkillBar = gohelper.findChildImage(self.go, "root/skillBar/image_skillBar")
	self.imageCareer = gohelper.findChildImage(self.go, "root/image_career")
	self.imageCareerBg = gohelper.findChildImage(self.go, "root/image_careerBg")
	self.goSkillFull = gohelper.findChild(self.go, "root/go_skillFull")
	self.btnClick = gohelper.findChildButtonWithAudio(self.go, "root/btn_click")
	self.goLock = gohelper.findChild(self.go, "root/go_lock")
	self.lockAnim = self.goLock:GetComponent(typeof(UnityEngine.Animator))
	self.anim = self.go:GetComponent(typeof(UnityEngine.Animator))
	self.skillFullAnim = self.goSkillFull:GetComponent(typeof(UnityEngine.Animator))
	self.lastSkillFullState = false

	gohelper.setActive(self.goLock, false)
end

function MatchGameFightHeroInfoItem:addEventListeners()
	self.btnClick:AddClickListener(self._btnHeroItemClick, self)
end

function MatchGameFightHeroInfoItem:removeEventListeners()
	self.btnClick:RemoveClickListener()
end

function MatchGameFightHeroInfoItem:_btnHeroItemClick()
	if self.heroFightMo.giddyState then
		GameFacade.showToast(ToastEnum.MatchGameFightRoleGiddy)

		return
	end

	local isRoundEnding = self.fightView:getIsRoundEnding()
	local isHeroSkillShowing = self.fightView:getHeroSkillShowingState()

	if isRoundEnding or isHeroSkillShowing then
		return
	end

	if self.heroFightMo.energy >= self.heroFightMo.maxEnergy then
		self.heroFightMo:updateFightInfo({
			energy = 0
		})
		MatchGameFightModel.instance:addTotalSkillUseNum(1)
		self:refreshUI()

		local skillConfig = MatchGameConfig.instance:getHeroSkillConfig(self.heroFightMo.skillId)

		MatchGameFightModel.instance:addPendingSkill(skillConfig, self.heroFightMo)

		if not string.nilorempty(skillConfig.skillText) then
			self.fightView:showSkillDesc(skillConfig)
			self.fightView:playRoleAnim("hit_skill", self.heroFightMo.id, false)

			if skillConfig.skillTextType == MatchGameFightEnum.SkillToastType.DropRate then
				if not MatchGameFightEnum.DropSkillDescShowTime then
					local descShowTime = MatchGameFightEnum.SkillDescShowTime

					TaskDispatcher.runDelay(self.doHeroSkill, self, descShowTime)
				end
			end
		else
			self.fightView:playRoleAnim("hit_skill", self.heroFightMo.id, false)
			self:doHeroSkill()
		end

		AudioMgr.instance:trigger(MatchGameAudioEnum.play_ui_yingmen_skill_release)
	end
end

function MatchGameFightHeroInfoItem:doHeroSkill()
	local params = {
		conditionId = MatchGameFightEnum.SkillConditionType.None,
		heroFightMo = self.heroFightMo
	}

	MatchGameController.instance:dispatchEvent(MatchGameFightEvent.OnSkillNoneCondition, params)

	local params = {
		conditionId = MatchGameFightEnum.SkillConditionType.OnSkillCast,
		heroFightMo = self.heroFightMo
	}

	MatchGameController.instance:dispatchEvent(MatchGameFightEvent.OnSkillCastCondition, params)
	MatchGameController.instance:dispatchEvent(MatchGameFightEvent.BeginGameStartRoundTime)
end

function MatchGameFightHeroInfoItem:refreshUI(heroFightMo)
	self.heroFightMo = heroFightMo or self.heroFightMo

	gohelper.setActive(self.go, self.heroFightMo.id ~= 0)

	if self.heroFightMo.id ~= 0 then
		UISpriteSetMgr.instance:setMatchGameSprite(self.imageCareer, "icon_career" .. self.heroFightMo.career)

		local energyFillAmount = Mathf.Min(self.heroFightMo.energy, self.heroFightMo.maxEnergy) / self.heroFightMo.maxEnergy

		self.imageSkillBar.fillAmount = Mathf.Lerp(MatchGameFightEnum.MinEnergyFillAmount, MatchGameFightEnum.MaxEnergyFillAmount, energyFillAmount)

		local isSkillFull = self.heroFightMo.energy >= self.heroFightMo.maxEnergy

		if not self.lastSkillFullState and isSkillFull then
			self:playSkillFullAnim()
		elseif not isSkillFull and self.lastSkillFullState then
			self:closeSkillFullAnim()
		elseif isSkillFull then
			gohelper.setActive(self.goSkillFull, true)
		end

		self.lastSkillFullState = isSkillFull

		local careerBgColor = MatchGameFightEnum.CareerColor[self.heroFightMo.career]

		SLFramework.UGUI.GuiHelper.SetColor(self.imageCareerBg, careerBgColor)
		self.simageHero:LoadImage(ResUrl.getHeadIconSmall(self.heroFightMo.config.icon))

		local barResName = string.format("matchgamefight_skill_bar%s_%s", self.heroFightMo.career, isSkillFull and 2 or 1)

		UISpriteSetMgr.instance:setMatchGameSprite(self.imageSkillBar, barResName)
	else
		self.imageSkillBar.fillAmount = 0

		gohelper.setActive(self.goSkillFull, false)
	end
end

function MatchGameFightHeroInfoItem:refreshEnergy(addEnergy)
	self:cleanEnergyTween()

	local lastEnergy = self.heroFightMo.energy
	local curEnergy = self.heroFightMo.energy + addEnergy

	self.anim:Play("add", 0, 0)
	self.anim:Update(0)
	self.heroFightMo:updateFightInfo({
		energy = curEnergy
	})

	local isSkillFull = self.heroFightMo.energy >= self.heroFightMo.maxEnergy
	local barResName = string.format("matchgamefight_skill_bar%s_%s", self.heroFightMo.career, isSkillFull and 2 or 1)

	UISpriteSetMgr.instance:setMatchGameSprite(self.imageSkillBar, barResName)

	self.energyTweenId = ZProj.TweenHelper.DOTweenFloat(lastEnergy, curEnergy, 0.1, self.doSetEnergyAnim, self.doSetEnergyAnimFinish, self, nil, EaseType.Linear)
end

function MatchGameFightHeroInfoItem:doSetEnergyAnim(value)
	local energyFillAmount = Mathf.Min(value, self.heroFightMo.maxEnergy) / self.heroFightMo.maxEnergy

	self.imageSkillBar.fillAmount = Mathf.Lerp(MatchGameFightEnum.MinEnergyFillAmount, MatchGameFightEnum.MaxEnergyFillAmount, energyFillAmount)
end

function MatchGameFightHeroInfoItem:doSetEnergyAnimFinish()
	local energyFillAmount = Mathf.Min(self.heroFightMo.energy, self.heroFightMo.maxEnergy) / self.heroFightMo.maxEnergy

	self.imageSkillBar.fillAmount = Mathf.Lerp(MatchGameFightEnum.MinEnergyFillAmount, MatchGameFightEnum.MaxEnergyFillAmount, energyFillAmount)

	local isSkillFull = self.heroFightMo.energy >= self.heroFightMo.maxEnergy

	if not self.lastSkillFullState and isSkillFull then
		self:playSkillFullAnim()
	elseif not isSkillFull and self.lastSkillFullState then
		self:closeSkillFullAnim()
	elseif isSkillFull then
		gohelper.setActive(self.goSkillFull, true)
	end

	self.lastSkillFullState = isSkillFull
end

function MatchGameFightHeroInfoItem:playLockAnim()
	gohelper.setActive(self.goLock, false)
	gohelper.setActive(self.goLock, true)
	self.lockAnim:Play("open", 0, 0)
	self.lockAnim:Update(0)
end

function MatchGameFightHeroInfoItem:closeLockAnim()
	self.lockAnim:Play("close", 0, 0)
	self.lockAnim:Update(0)
end

function MatchGameFightHeroInfoItem:playSkillFullAnim()
	gohelper.setActive(self.goSkillFull, false)
	gohelper.setActive(self.goSkillFull, true)
	self.skillFullAnim:Play("open", 0, 0)
	self.skillFullAnim:Update(0)
	AudioMgr.instance:trigger(MatchGameAudioEnum.play_ui_yingmen_skill_fullof)
end

function MatchGameFightHeroInfoItem:closeSkillFullAnim()
	self.skillFullAnim:Play("close", 0, 0)
	self.skillFullAnim:Update(0)
	TaskDispatcher.cancelTask(self.hideSkillFull, self)
	TaskDispatcher.runDelay(self.hideSkillFull, self, 0.333)
end

function MatchGameFightHeroInfoItem:hideSkillFull()
	gohelper.setActive(self.goSkillFull, false)
end

function MatchGameFightHeroInfoItem:cleanEnergyTween()
	if self.energyTweenId then
		ZProj.TweenHelper.KillById(self.energyTweenId)

		self.energyTweenId = nil
	end
end

function MatchGameFightHeroInfoItem:onDestroy()
	self:cleanEnergyTween()
	TaskDispatcher.cancelTask(self.doHeroSkill, self)
	TaskDispatcher.cancelTask(self.hideSkillFull, self)
	self.simageHero:UnLoadImage()
end

return MatchGameFightHeroInfoItem
