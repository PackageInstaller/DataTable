-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/HeroStarUpTipMediator.lua

HeroStarUpTipMediator = class("HeroStarUpTipMediator", DmPopupViewMediator, _M)

HeroStarUpTipMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kHeroRarityAnim = {
	[15] = {
		"sp_urequipeff",
		17
	},
	[14] = {
		"ssr_choukahuodeyinghun",
		17
	},
	[13] = {
		"sr_choukahuodeyinghun",
		17
	},
	[12] = {
		"r_choukahuodeyinghun",
		17
	},
	[11] = {
		"r_choukahuodeyinghun",
		17
	}
}
local kStarPanelWidth = {
	60,
	60,
	130,
	230,
	320,
	400
}

function HeroStarUpTipMediator:initialize()
	super.initialize(self)
end

function HeroStarUpTipMediator:dispose()
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)

	storyDirector:notifyWaiting("exit_HeroStarUpTipMediator")

	if self._sound1 then
		AudioEngine:getInstance():stopEffect(self._sound1)
	end

	if self._sound2 then
		AudioEngine:getInstance():stopEffect(self._sound2)
	end

	super.dispose(self)
end

function HeroStarUpTipMediator:onRegister()
	super.onRegister(self)
end

function HeroStarUpTipMediator:mapEventListeners()
	return
end

function HeroStarUpTipMediator:onRemove()
	super.onRemove(self)
end

function HeroStarUpTipMediator:enterWithData(data)
	self._heroSystem = self._developSystem:getHeroSystem()
	data.skillData = nil

	self:createUI(data)
end

function HeroStarUpTipMediator:createUI(data)
	self._sound1 = AudioEngine:getInstance():playEffect("Se_Alert_Shengxing", false)
	self._sound2 = AudioEngine:getInstance():playRoleEffect("Voice_" .. data.heroId .. "_12", false)

	local hero = self._heroSystem:getHeroById(data.heroId)
	local star = hero:getStar()
	local littleStar = hero:getLittleStar()
	local rarity = hero:getRarity()
	local rairtyTip = self:getView():getChildByName("txt")

	rairtyTip:setVisible(false)
	rairtyTip:setLocalZOrder(999)

	self._touchLayer = self:getView():getChildByName("touchLayer")

	self._touchLayer:setVisible(false)

	self._mainpanel = self:getView():getChildByName("mainpanel")

	self._mainpanel:setLocalZOrder(2)

	local attrPanel = self._mainpanel:getChildByName("attrPanel")

	attrPanel:setOpacity(0)

	local skillPanel = self._mainpanel:getChildByFullName("panel1.newPanel")

	self._mainpanel:getChildByFullName("panel1"):setPositionX(461)

	local rarityPanel = self._mainpanel:getChildByFullName("panel2.newPanel")

	self._mainpanel:getChildByFullName("panel2"):setPositionX(461)

	if data.skillData and data.rarityData and data.rarityData ~= rarity then
		self._mainpanel:getChildByFullName("panel1"):setPositionX(329)
		self._mainpanel:getChildByFullName("panel2"):setPositionX(620)
	end

	local starPanel = self._mainpanel:getChildByName("starPanel")

	starPanel:setVisible(false)
	starPanel:setOpacity(0)

	local anim = cc.MovieClip:create("huodetishi_huodetishi")

	anim:addTo(self._mainpanel:getChildByName("animNode"))
	anim:addCallbackAtFrame(39, function()
		anim:stop()
	end)

	local cnText = anim:getChildByFullName("cnText")
	local enText = anim:getChildByFullName("enText")
	local title1 = cc.Label:createWithTTF(Strings:get("heroshow_UI18"), CUSTOM_TTF_FONT_1, 50)

	title1:enableOutline(cc.c4b(0, 0, 0, 255), 1)
	title1:addTo(cnText):offset(0, -3)

	local title2 = cc.Label:createWithTTF(Strings:get("UITitle_EN_Shengxingchenggong"), TTF_FONT_FZYH_M, 18)

	title2:setColor(cc.c3b(150, 160, 255))
	title2:addTo(enText)

	local curStarNode = starPanel:getChildByName("star_" .. star)
	local curStarNodeTemp = starPanel:getChildByName("star_" .. star + 1)

	anim:addCallbackAtFrame(14, function()
		local anim1 = cc.MovieClip:create("yh_aa_yinghunshengxing")

		if littleStar then
			anim1 = cc.MovieClip:create("shengdaobanxing_yinghunshengxing")

			anim1:addTo(curStarNodeTemp)
			anim1:setPosition(cc.p(-12, 1))
		else
			anim1:addTo(curStarNode)
			anim1:setPosition(cc.p(-10, 13))
		end

		anim1:addEndCallback(function()
			anim1:gotoAndPlay(20)
		end)
		anim1:gotoAndPlay(0)
		attrPanel:fadeIn({
			time = 0.2
		})
		starPanel:setVisible(true)
		starPanel:fadeIn({
			time = 0.2
		})
	end)
	anim:addCallbackAtFrame(2, function()
		if data.skillData then
			skillPanel:setVisible(true)
			skillPanel:stopAllActions()

			local action = cc.CSLoader:createTimeline("asset/ui/HeroUpTip.csb")

			skillPanel:runAction(action)
			action:gotoFrameAndPlay(0, 16, false)

			local panel1 = skillPanel:getChildByFullName("panel1")
			local panel = skillPanel:getChildByFullName("panel")

			panel1:setPosition(cc.p(panel:getContentSize().width, -5))

			local delay = cc.DelayTime:create(0.2)
			local moveto = cc.MoveTo:create(0.2, cc.p(-4, -6))
			local seq = cc.Sequence:create(delay, moveto)

			panel1:runAction(seq)
			panel:setScaleX(0)

			delay = cc.DelayTime:create(0.2)

			local scaleto = cc.ScaleTo:create(0.2, 1, 1)

			seq = cc.Sequence:create(delay, scaleto)

			panel:runAction(seq)
		end

		if data.rarityData and data.rarityData ~= rarity then
			rairtyTip:setVisible(true)
			rarityPanel:setVisible(true)
			rarityPanel:stopAllActions()

			local action = cc.CSLoader:createTimeline("asset/ui/HeroUpTip.csb")

			rarityPanel:runAction(action)
			action:gotoFrameAndPlay(0, 16, false)

			local panel1 = rarityPanel:getChildByFullName("panel1")
			local panel = rarityPanel:getChildByFullName("panel")

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
		end
	end)

	local width = kStarPanelWidth[hero:getMaxStar()]
	local height = starPanel:getContentSize().height

	starPanel:setContentSize(cc.size(width, height))

	for i = 1, HeroStarCountMax do
		local starNode = starPanel:getChildByName("star_" .. i)

		starNode:setVisible(i <= hero:getMaxStar())

		if i <= star then
			local anim1 = cc.MovieClip:create("yh_aa_yinghunshengxing")

			anim1:addTo(starNode)
			anim1:addEndCallback(function()
				anim1:gotoAndPlay(11)
			end)
			anim1:setPosition(cc.p(-10, 13))
			anim1:gotoAndPlay(11)
		end
	end

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
	local attack = hero:getAttack()
	local hp = hero:getHp()
	local defense = hero:getDefense()
	local speed = hero:getSpeed()

	desLab1:setString(data.attr.attack[1])
	desLab2:setString(data.attr.hp[1])
	desLab3:setString(data.attr.defense[1])
	desLab4:setString(data.attr.speed[1])
	extandText1:setString("+" .. attack - data.attr.attack[1])
	extandText2:setString("+" .. hp - data.attr.hp[1])
	extandText3:setString("+" .. defense - data.attr.defense[1])
	extandText4:setString("+" .. speed - data.attr.speed[1])
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

	if data.skillData then
		skillPanel:getChildByFullName("panel1.newType"):setString(Strings:get("heroshow_UI20"))

		local skillName = skillPanel:getChildByFullName("name")
		local skillIcon = skillPanel:getChildByFullName("icon")

		skillIcon:removeAllChildren()

		local skillId = data.skillData.skillId
		local skillConfig = ConfigReader:getRecordById("Skill", tostring(skillId))
		local newSkillNode = IconFactory:createHeroSkillIcon({
			isLock = false,
			id = skillId
		}, {
			hideLevel = true,
			isWidget = true
		})

		skillIcon:addChild(newSkillNode)
		newSkillNode:setPosition(cc.p(25, 25))
		skillName:setString(tostring(Strings:get(skillConfig.Name)))

		local panel = skillPanel:getChildByFullName("panel")
		local bg = panel:getChildByFullName("bg")
		local gap = skillName:getContentSize().width - 105
		local width = math.max(217, 217 + gap)

		skillPanel:setContentSize(cc.size(width, 68))
		panel:setContentSize(cc.size(width, 68))
		bg:setContentSize(cc.size(width, 66))
		panel:setPositionX(width)
	end

	if data.rarityData and data.rarityData ~= rarity then
		local rarity1 = rarityPanel:getChildByName("rarity1")
		local rarity2 = rarityPanel:getChildByName("rarity2")
		local rarityAnim = kHeroRarityAnim[data.rarityData]

		if rarityAnim then
			local rarity = cc.MovieClip:create(rarityAnim[1])

			rarity:addTo(rarity1):offset(0, rarityAnim[2])
		end

		local rarityAnim = kHeroRarityAnim[rarity]

		if rarityAnim then
			local rarity = cc.MovieClip:create(rarityAnim[1])

			rarity:addTo(rarity2):offset(0, rarityAnim[2])
		end
	end
end
