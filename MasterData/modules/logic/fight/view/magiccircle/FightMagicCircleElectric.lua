-- chunkname: @modules/logic/fight/view/magiccircle/FightMagicCircleElectric.lua

module("modules.logic.fight.view.magiccircle.FightMagicCircleElectric", package.seeall)

local FightMagicCircleElectric = class("FightMagicCircleElectric", FightMagicCircleBaseItem)

function FightMagicCircleElectric:getUIType()
	return FightEnum.MagicCircleUIType.Electric
end

function FightMagicCircleElectric:initView()
	self.rectTr = self.go:GetComponent(gohelper.Type_RectTransform)
	self.sliderAnimator = gohelper.findChildComponent(self.go, "slider", gohelper.Type_Animator)
	self.textSlider = gohelper.findChildText(self.go, "slider/sliderbg/#txt_slidernum")
	self.goRoundHero = gohelper.findChild(self.go, "slider/round/hero")
	self.roundNumHero = gohelper.findChildText(self.go, "slider/round/hero/#txt_round")
	self.goRoundEnemy = gohelper.findChild(self.go, "slider/round/enemy")
	self.roundNumEnemy = gohelper.findChildText(self.go, "slider/round/enemy/#txt_round")
	self.imageSliderFlash = gohelper.findChildImage(self.go, "slider/sliderbg/slider_flashbg")
	self.imageSliderFlash.fillAmount = 0
	self.goVxRoot = gohelper.findChild(self.go, "go_survivalEffect")
	self.upVx = gohelper.findChild(self.goVxRoot, "up")
	self.upDown = gohelper.findChild(self.goVxRoot, "down")

	gohelper.setActive(self.goVxRoot, true)
	gohelper.setActive(self.upVx, false)
	gohelper.setActive(self.upDown, false)

	self.imageSlider = self:getUserDataTb_()

	for i = 1, 3 do
		local image = gohelper.findChildImage(self.go, "slider/sliderbg/slider_level" .. i)

		self.imageSlider[i] = image
		image.fillAmount = 0

		gohelper.setActive(image.gameObject, true)
	end

	self.energyList = {}

	for i = 1, 3 do
		local oneEnergy = self:getUserDataTb_()

		self.energyList[i] = oneEnergy

		local energyGo = gohelper.findChild(self.go, "slider/energy/" .. i)

		for j = 1, 3 do
			table.insert(oneEnergy, gohelper.findChild(energyGo, "light" .. j))
		end
	end

	self._click = gohelper.findChildClickWithDefaultAudio(self.go, "btn")

	self._click:AddClickListener(self.onClickSelf, self)

	self.levelVxDict = self:getUserDataTb_()
	self.levelVxDict[1] = gohelper.findChild(self.go, "slider/vx/1")
	self.levelVxDict[2] = gohelper.findChild(self.go, "slider/vx/2")
	self.levelVxDict[3] = gohelper.findChild(self.go, "slider/vx/3")
	self.preRecordProgress = 0

	self.addEventCb(self, FightController.instance, FightEvent.UpgradeMagicCircile, self.onUpgradeMagicCircle, self)
end

FightMagicCircleElectric.Upgrade2AnimatorName = {
	[2] = "upgrade_01",
	[3] = "upgrade_02"
}

function FightMagicCircleElectric:onUpgradeMagicCircle(magicMo)
	local magicConfig = lua_magic_circle.configDict[magicMo.magicCircleId]
	local curLevel = magicMo.electricLevel
	local anim = self.Upgrade2AnimatorName[curLevel]

	if anim then
		self.sliderAnimator:Play(anim, 0, 0)
	end

	self.preProgress = 0

	self:refreshUI(magicMo, magicConfig)
	AudioMgr.instance:trigger(20270001)
end

function FightMagicCircleElectric:onClickSelf()
	local preferredHeight = recthelper.getHeight(self.rectTr)
	local position = self.rectTr.position

	FightController.instance:dispatchEvent(FightEvent.OnClickMagicCircleText, preferredHeight, position)
end

function FightMagicCircleElectric:onCreateMagic(magicMo, magicConfig)
	FightMagicCircleElectric.super.onCreateMagic(self, magicMo, magicConfig)
	AudioMgr.instance:trigger(20270001)
end

function FightMagicCircleElectric:refreshUI(magicMo, magicConfig, fromId)
	self.magicMo = magicMo
	self.magicConfig = magicConfig

	self:refreshRound(magicMo, magicConfig)
	self:refreshSlider(magicMo, magicConfig)
	self:refreshEnergy(magicMo, magicConfig)
	self:playProgressChangeAnim(fromId)
end

FightMagicCircleElectric.ChangeProgressEffect = "buff/buff_dianneng_zr"
FightMagicCircleElectric.ChangeProgressEffectAudioId = 20280002
FightMagicCircleElectric.EffectDuration = 1

function FightMagicCircleElectric:playProgressChangeAnim(fromId)
	local curProgress = self.magicMo.electricProgress

	if self.preRecordProgress == curProgress then
		return
	end

	local isUp = curProgress > self.preRecordProgress

	if isUp then
		gohelper.setActive(self.upVx, false)
		gohelper.setActive(self.upVx, true)
	else
		gohelper.setActive(self.upDown, false)
		gohelper.setActive(self.upDown, true)
	end

	self.preRecordProgress = self.magicMo.electricProgress

	local entity = fromId and FightHelper.getEntity(fromId)

	if not entity then
		return
	end

	local effectWrap = entity.effect:addHangEffect(FightMagicCircleElectric.ChangeProgressEffect, ModuleEnum.SpineHangPoint.mountbottom, nil, FightMagicCircleElectric.EffectDuration)

	effectWrap:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(fromId, effectWrap)
	AudioMgr.instance:trigger(FightMagicCircleElectric.ChangeProgressEffectAudioId)
end

function FightMagicCircleElectric:refreshRound(magicMo, magicConfig)
	local round = magicMo.round == -1 and "∞" or magicMo.round

	self.roundNumHero.text = round
	self.roundNumEnemy.text = round

	local side = FightHelper.getMagicSide(magicMo.createUid)

	gohelper.setActive(self.goRoundHero, side == FightEnum.EntitySide.MySide)
	gohelper.setActive(self.goRoundEnemy, side == FightEnum.EntitySide.EnemySide)
end

FightMagicCircleElectric.FillAmountDuration = 0.5

function FightMagicCircleElectric:refreshSlider(magicMo, magicConfig)
	self.curMaxProgress = magicMo.maxElectricProgress

	if not self.preProgress then
		self:refreshSliderByProgressAndLevel(magicMo.electricProgress, magicMo.electricLevel)
		self:showCurLevelVx()

		self.preProgress = magicMo.electricProgress
		self.preLevel = magicMo.electricLevel

		return
	end

	local curProgress = magicMo.electricProgress
	local preProgress = self.preProgress

	self.preProgress = curProgress

	self:clearTween()

	self.tweenId = ZProj.TweenHelper.DOTweenFloat(preProgress, curProgress, FightMagicCircleElectric.FillAmountDuration, self.tweenProgress, self.onTweenFinish, self)
end

function FightMagicCircleElectric:tweenProgress(progress)
	progress = math.floor(progress)

	local level = self.magicMo.electricLevel

	self:refreshSliderByProgressAndLevel(progress, level)
end

function FightMagicCircleElectric:refreshSliderByProgressAndLevel(progress, level)
	for i, sliderImage in ipairs(self.imageSlider) do
		if i == level then
			if i == 3 then
				self.textSlider.text = "MAX"
				sliderImage.fillAmount = 1
			else
				local curMax = self.curMaxProgress

				if not curMax or curMax < 1 then
					local co = lua_fight_dnsz.configList[level + 1]

					curMax = 0

					if co then
						curMax = co.progress
					else
						logError("not found fight_dnsz co, level : " .. tostring(level))

						curMax = 1
					end
				end

				sliderImage.fillAmount = progress / curMax
				self.textSlider.text = string.format("%s/<#E3E3E3>%s</COLOR>", progress, curMax)
			end
		else
			sliderImage.fillAmount = 0
		end
	end
end

function FightMagicCircleElectric:onTweenFinish()
	self:showCurLevelVx()
	self:clearTween()
end

function FightMagicCircleElectric:showCurLevelVx()
	local level = self.magicMo.electricLevel

	for lv, goVx in pairs(self.levelVxDict) do
		gohelper.setActive(goVx, level and lv <= level)
	end
end

function FightMagicCircleElectric:refreshEnergy(magicMo, magicConfig)
	local level = magicMo.electricLevel

	for i, oneEnergy in ipairs(self.energyList) do
		for j, goEnergy in ipairs(oneEnergy) do
			gohelper.setActive(goEnergy, i <= level and j == level)
		end
	end
end

function FightMagicCircleElectric:getLevelByProgress(progress)
	local list = lua_fight_dnsz.configList
	local len = #list

	for i = len, 1, -1 do
		local co = list[i]

		if progress >= co.progress then
			return co.level
		end
	end

	return 1
end

function FightMagicCircleElectric:getLevelCo(level)
	local levelCo = lua_fight_dnsz.configDict[level]

	levelCo = levelCo or lua_fight_dnsz.configDict[1]

	return levelCo
end

function FightMagicCircleElectric:clearTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

function FightMagicCircleElectric:destroy()
	self:clearTween()

	if self._click then
		self._click:RemoveClickListener()
	end

	FightMagicCircleElectric.super.destroy(self)
end

return FightMagicCircleElectric
