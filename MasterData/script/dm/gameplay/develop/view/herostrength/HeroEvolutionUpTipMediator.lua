-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/HeroEvolutionUpTipMediator.lua

HeroEvolutionUpTipMediator = class("HeroEvolutionUpTipMediator", DmPopupViewMediator, _M)

HeroEvolutionUpTipMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

function HeroEvolutionUpTipMediator:initialize()
	super.initialize(self)
end

function HeroEvolutionUpTipMediator:dispose()
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)

	storyDirector:notifyWaiting("exit_heroEvolutionUpTip_view")

	if self._sound1 then
		AudioEngine:getInstance():stopEffect(self._sound1)
	end

	if self._sound2 then
		AudioEngine:getInstance():stopEffect(self._sound2)
	end

	super.dispose(self)
end

function HeroEvolutionUpTipMediator:onRegister()
	super.onRegister(self)
end

function HeroEvolutionUpTipMediator:mapEventListeners()
	return
end

function HeroEvolutionUpTipMediator:onRemove()
	super.onRemove(self)
end

function HeroEvolutionUpTipMediator:enterWithData(data)
	self._heroSystem = self._developSystem:getHeroSystem()

	self:dispatch(Event:new(EVT_HEROEVOLUTIONLUP_SUCC))
	self:createUI(data)
	self:setupClickEnvs()
end

function HeroEvolutionUpTipMediator:createUI(data)
	self._sound1 = AudioEngine:getInstance():playEffect("Se_Alert_Shengpin", false)
	self._sound2 = AudioEngine:getInstance():playRoleEffect("Voice_" .. data.heroId .. "_13", false)

	local hero = self._heroSystem:getHeroById(data.heroId)
	local name = hero:getName()

	self._touchLayer = self:getView():getChildByName("touchLayer")

	self._touchLayer:setVisible(true)

	self._mainpanel = self:getView():getChildByName("mainpanel")
	self._qualityPanel = self._mainpanel:getChildByName("qualityPanel")

	self._qualityPanel:setVisible(true)
	self._mainpanel:setLocalZOrder(2)

	local attrPanel = self._mainpanel:getChildByName("attrPanel")

	self._qualityPanel:setOpacity(0)
	attrPanel:setOpacity(0)

	local levelPanel = self._mainpanel:getChildByFullName("panel3.newPanel")

	levelPanel:setVisible(false)

	local newTypeLabel = levelPanel:getChildByFullName("panel1.newType")

	newTypeLabel:setString(Strings:get("HEROS_UI64"))

	local str1 = Strings:get("HEROS_UI65", {
		level = data.levelRequest
	})
	local str2 = Strings:get("HEROS_UI65", {
		level = hero:getCurMaxLevel()
	})

	levelPanel:getChildByFullName("level1"):setString(str1)
	levelPanel:getChildByFullName("level2"):setString(str2)

	local anim = cc.MovieClip:create("huodetishi_huodetishi")

	anim:addTo(self._mainpanel:getChildByName("animNode"))
	anim:addCallbackAtFrame(39, function()
		self._touchLayer:setVisible(false)
		anim:stop()
	end)

	local cnText = anim:getChildByFullName("cnText")
	local enText = anim:getChildByFullName("enText")
	local title1 = cc.Label:createWithTTF(Strings:get("Tips_3010019"), CUSTOM_TTF_FONT_1, 50)

	title1:enableOutline(cc.c4b(0, 0, 0, 255), 1)
	title1:addTo(cnText):offset(0, -3)

	local title2 = cc.Label:createWithTTF(Strings:get("UITitle_EN_Shengpinchenggong"), TTF_FONT_FZYH_M, 18)

	title2:setColor(cc.c3b(150, 160, 255))
	title2:addTo(enText)
	anim:addCallbackAtFrame(13, function()
		local anim = cc.MovieClip:create("jiantoudonghua_jiantoudonghua")

		anim:addCallbackAtFrame(50, function()
			anim:stop()
		end)
		anim:addTo(self._mainpanel)
		anim:setPosition(cc.p(577, 370))
		anim:setScale(0.8)
	end)
	anim:addCallbackAtFrame(13, function()
		attrPanel:fadeIn({
			time = 0.2
		})
		self._qualityPanel:fadeIn({
			time = 0.2
		})
	end)
	anim:addCallbackAtFrame(13, function()
		levelPanel:setVisible(true)
		levelPanel:stopAllActions()

		local action = cc.CSLoader:createTimeline("asset/ui/HeroUpTip.csb")

		levelPanel:runAction(action)
		action:gotoFrameAndPlay(0, 16, false)

		local panel1 = levelPanel:getChildByFullName("panel1")
		local panel = levelPanel:getChildByFullName("panel")

		panel1:setPosition(cc.p(panel:getContentSize().width, -5))

		local delay = cc.DelayTime:create(0.2)
		local moveto = cc.MoveTo:create(0.2, cc.p(-2, -6))
		local seq = cc.Sequence:create(delay, moveto)

		panel1:runAction(seq)
		panel:setScaleX(0)

		delay = cc.DelayTime:create(0.2)

		local scaleto = cc.ScaleTo:create(0.2, 1, 1)

		seq = cc.Sequence:create(delay, scaleto)

		panel:runAction(seq)
	end)

	local heroIconL = self._qualityPanel:getChildByName("heroIconL")

	heroIconL:removeAllChildren()

	local iconL = IconFactory:createHeroSmallIcon({
		id = data.heroId,
		quality = data.quality[1]
	}, {
		hideAll = true,
		scale = 0.6
	})

	iconL:addTo(heroIconL)

	local heroIconR = self._qualityPanel:getChildByName("heroIconR")

	heroIconR:removeAllChildren()

	local iconR = IconFactory:createHeroSmallIcon({
		id = data.heroId,
		quality = data.quality[2]
	}, {
		hideAll = true,
		scale = 0.6
	})

	iconR:addTo(heroIconR)

	local name1 = name .. (data.qualityLevel[1] == 0 and "" or "+" .. data.qualityLevel[1])
	local heroNameL = self._qualityPanel:getChildByName("heroNameL")

	heroNameL:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	heroNameL:setString(name1)
	GameStyle:setHeroNameByQuality(heroNameL, data.quality[1])
	heroNameL:setPositionX(heroIconL:getPositionX())

	local name2 = name .. (data.qualityLevel[2] == 0 and "" or "+" .. data.qualityLevel[2])
	local heroNameR = self._qualityPanel:getChildByName("heroNameR")

	heroNameR:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	heroNameR:setString(name2)
	GameStyle:setHeroNameByQuality(heroNameR, data.quality[2])
	heroNameR:setPositionX(heroIconR:getPositionX())

	local desNode1 = attrPanel:getChildByFullName("des_1")
	local desNode2 = attrPanel:getChildByFullName("des_2")
	local desNode3 = attrPanel:getChildByFullName("des_3")
	local desNode4 = attrPanel:getChildByFullName("des_4")
	local desLab1 = attrPanel:getChildByFullName("des_1.text")
	local desLab2 = attrPanel:getChildByFullName("des_2.text")
	local desLab3 = attrPanel:getChildByFullName("des_3.text")
	local desLab4 = attrPanel:getChildByFullName("des_4.text")
	local extandText1 = attrPanel:getChildByFullName("des_1.extandText")
	local extandText2 = attrPanel:getChildByFullName("des_2.extandText")
	local extandText3 = attrPanel:getChildByFullName("des_3.extandText")
	local extandText4 = attrPanel:getChildByFullName("des_4.extandText")
	local attrDi1 = attrPanel:getChildByFullName("des_1.Image_6")
	local attrDi2 = attrPanel:getChildByFullName("des_2.Image_6")
	local attrDi3 = attrPanel:getChildByFullName("des_3.Image_6")
	local attrDi4 = attrPanel:getChildByFullName("des_4.Image_6")

	desLab1:setString(data.attr.attack[1])
	desLab2:setString(data.attr.hp[1])
	desLab3:setString(data.attr.defense[1])
	desLab4:setString(data.attr.speed[1])

	local attack = hero:getAttack()
	local hp = hero:getHp()
	local defense = hero:getDefense()
	local speed = hero:getSpeed()

	if attack - data.attr.attack[1] > 0 then
		if not (attack - data.attr.attack[1]) then
			local addAtk = 0

			if hp - data.attr.hp[1] > 0 then
				if not (hp - data.attr.hp[1]) then
					local addHp = 0

					if defense - data.attr.defense[1] > 0 then
						if not (defense - data.attr.defense[1]) then
							local addDef = 0

							if speed - data.attr.speed[1] > 0 then
								if not (speed - data.attr.speed[1]) then
									local addSpeed = 0

									extandText1:setString("+" .. addAtk)
									extandText2:setString("+" .. addHp)
									extandText3:setString("+" .. addDef)
									extandText4:setString("+" .. addSpeed)
									desLab1:setPositionX(35)
									desLab2:setPositionX(35)
									desLab3:setPositionX(35)
									desLab4:setPositionX(35)
									extandText1:setPositionX(desLab1:getPositionX() + desLab1:getContentSize().width + 5)
									extandText2:setPositionX(desLab2:getPositionX() + desLab2:getContentSize().width + 5)
									extandText3:setPositionX(desLab3:getPositionX() + desLab3:getContentSize().width + 5)
									extandText4:setPositionX(desLab4:getPositionX() + desLab4:getContentSize().width + 5)
									attrDi1:setContentSize(cc.size(desLab1:getContentSize().width + extandText1:getContentSize().width + 50, 23))
									attrDi2:setContentSize(cc.size(desLab2:getContentSize().width + extandText2:getContentSize().width + 50, 23))
									attrDi3:setContentSize(cc.size(desLab3:getContentSize().width + extandText3:getContentSize().width + 50, 23))
									attrDi4:setContentSize(cc.size(desLab4:getContentSize().width + extandText4:getContentSize().width + 50, 23))

									local starX = (1046 - attrDi1:getContentSize().width - attrDi2:getContentSize().width - attrDi3:getContentSize().width - attrDi4:getContentSize().width) / 2

									desNode1:setPositionX(starX)
									desNode2:setPositionX(desNode1:getPositionX() + attrDi1:getContentSize().width + 30)
									desNode3:setPositionX(desNode2:getPositionX() + attrDi2:getContentSize().width + 30)
									desNode4:setPositionX(desNode3:getPositionX() + attrDi3:getContentSize().width + 30)
								end
							end
						end
					end
				end
			end
		end
	end
end

function HeroEvolutionUpTipMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)

		storyDirector:notifyWaiting("enter_heroEvolutionUpTip_view")
	end))

	self:getView():runAction(sequence)
end

function HeroEvolutionUpTipMediator:onTouchMaskLayer()
	self:getEventDispatcher():dispatchEvent(Event:new(EVT_HEROEVOLUTION_FINISH))
	AudioEngine:getInstance():playEffect("Se_Click_Close_2", false)
	self:close()
end
