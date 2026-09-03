-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/popup/NewHeroMediator.lua

NewHeroMediator = class("NewHeroMediator", DmPopupViewMediator, _M)

NewHeroMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kHandlerBtn = {}
local showRarityTipHero = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_WivesTeam", "content")
local heroRect = "asset/heroRect/heroRarity/"
local kHeroRarityAnim = {
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	"r_choukahuodeyinghun",
	"r_choukahuodeyinghun",
	"sr_choukahuodeyinghun",
	"ssr_choukahuodeyinghun",
	"sp_urequipeff"
}
local kHeroRarityBg1 = {
	[15] = heroRect .. "hero_rarity_bg_sp.png",
	[14] = heroRect .. "hero_rarity_bg_ssr.png",
	[13] = heroRect .. "hero_rarity_bg_sr.png",
	[12] = heroRect .. "hero_rarity_bg_r.png",
	[11] = heroRect .. "hero_rarity_bg_r.png"
}
local kHeroRarityBg2 = {
	[15] = heroRect .. "hero_rarity_bg_1_sp.png",
	[14] = heroRect .. "hero_rarity_bg_1_ssr.png",
	[13] = heroRect .. "hero_rarity_bg_1_ssr.png",
	[12] = heroRect .. "hero_rarity_bg_1_r.png",
	[11] = heroRect .. "hero_rarity_bg_1_r.png"
}
local kHeroRarityBgGuang = {
	[15] = "ssrdonghuaguang_choukahuodeyinghun",
	[13] = "srdonghuaguang_choukahuodeyinghun",
	[14] = "ssrdonghuaguang_choukahuodeyinghun"
}

function NewHeroMediator:initialize()
	super.initialize(self)
end

function NewHeroMediator:dispose()
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)

	storyDirector:notifyWaiting("dispose_newHero_view")
	super.dispose(self)
end

function NewHeroMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kHandlerBtn)

	self._heroSystem = self._developSystem:getHeroSystem()
end

function NewHeroMediator:enterWithData(data)
	data = data or {}

	local heroId = data.heroId

	assert(heroId ~= nil, "No heroId")

	local heroConfig = ConfigReader:getRecordById("HeroBase", heroId)

	assert(heroConfig ~= nil, string.format("英魂 ID：%s 在 HeroBase 中没有对应数据", heroId))

	self._heroId = heroId

	if heroConfig.GainAnim == 1 then
		local videoSprite = VideoSprite.create("video/hero/video_" .. heroId .. ".usm", function(sprite, eventName)
			if eventName == "complete" then
				sprite:removeFromParent()
				self:showResult(data)
			end
		end)

		self:getView():addChild(videoSprite)
		videoSprite:setPosition(cc.p(568, 320))
	else
		self:showResult(data)
	end
end

function NewHeroMediator:addShare()
	local data = {
		enterType = ShareEnterType.KRecruitOneHero,
		node = self:getView(),
		preConfig = function()
			return
		end,
		endConfig = function()
			return
		end
	}

	self._shareNode = DmGame:getInstance()._injector:getInstance(ShareSystem):addShare(data)
end

function NewHeroMediator:showResult(data)
	local callback = data.callback
	local heroId = data.heroId
	local ignoreNewRed = data.ignoreNewRed
	local heroConfig = ConfigReader:getRecordById("HeroBase", heroId)
	local newHero = true

	if data.newHero ~= nil then
		newHero = data.newHero
	end

	if not ignoreNewRed and newHero then
		cc.UserDefault:getInstance():setBoolForKey(UserDefaultKey.kGetNewHeroRed, true)
	end

	local canClose = not newHero

	if not data.animFrame then
		local soundId

		AudioEngine:getInstance():playEffect("Se_Alert_New_Hero", false)

		local view = self:getView()
		local main = view:getChildByFullName("main")

		self._rarityPanel = main:getChildByFullName("panel")

		self._rarityPanel:setVisible(false)
		main:addClickEventListener(function(sender, eventType)
			if canClose then
				if soundId then
					AudioEngine:getInstance():stopEffect(soundId)
				end

				self:close()

				if callback then
					callback()
				end
			end
		end)

		local delay = cc.DelayTime:create(1)
		local callfunc = cc.CallFunc:create(function()
			soundId = AudioEngine:getInstance():playRoleEffect("Voice_" .. heroId .. "_01", false)
		end)
		local seq = cc.Sequence:create(delay, callfunc)

		main:stopAllActions()
		main:runAction(seq)

		local nameText = main:getChildByName("nameLabel")

		nameText:setString(Strings:get(heroConfig.Name))

		local costLabel = main:getChildByName("costLabel")

		costLabel:setString(heroConfig.Cost)

		local cvnameLabel = main:getChildByName("cvname")

		cvnameLabel:setString(Strings:get("Recruit_UI13") .. Strings:get(heroConfig.CVName))

		local length = utf8.len(Strings:get(heroConfig.CVName))

		if length > 10 then
			cvnameLabel:setFontSize(22)
		else
			cvnameLabel:setFontSize(26)
		end

		local soundDesc = main:getChildByName("soundDesc")
		local desc = ConfigReader:getDataByNameIdAndKey("Sound", "Voice_" .. heroId .. "_01", "SoundDesc")
		local str = Strings:get(desc)

		soundDesc:setString(str)
		GameStyle:setCommonOutlineEffect(soundDesc)

		if getCurrentLanguage() ~= GameLanguageType.CN then
			soundDesc:setLineSpacing(-5)
		end

		local partyData = GameStyle:getHeroPartyBgData(heroConfig.Party)
		local bgPanel = main:getChildByName("bgPanel")
		local bgAnim = cc.MovieClip:create(partyData[1])

		bgAnim:addTo(bgPanel)
		bgAnim:setPosition(cc.p(100, 100))

		local bg1 = bgAnim:getChildByFullName("bg1")
		local bg2 = bgAnim:getChildByFullName("bg2")
		local bg3 = bgAnim:getChildByFullName("bg3")

		if bg1 then
			local bgImage = ccui.ImageView:create(partyData[2] .. ".jpg")

			bgImage:addTo(bg1)

			if bg2 and bg3 then
				local bgImage = ccui.ImageView:create(partyData[2] .. "mohu.jpg")

				bgImage:addTo(bg2)

				local bgImage = ccui.ImageView:create(partyData[2] .. "mohu.jpg")

				bgImage:addTo(bg3)
			end
		end

		bgPanel:setScale(1.2)
		bgPanel:runAction(cc.ScaleTo:create(0.2, 1))

		if not newHero and data.fragmentCount then
			local text = ccui.Text:create(Strings:get("DrawcardUI1", {
				value = data.fragmentCount
			}), TTF_FONT_FZYH_M, 18)

			text:setAnchorPoint(cc.p(0.5, 0.5))
			text:addTo(main):center(main:getContentSize()):offset(0, -280)
			text:setOpacity(0)
			text:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.FadeIn:create(0.5)))
		end

		local anim = cc.MovieClip:create("zonghe_choukahuodeyinghun")

		anim:addTo(main:getChildByName("animPanel"))
		anim:setPosition(cc.p(100, 100))
		anim:addEndCallback(function()
			anim:stop()
		end)

		local heroNode = anim:getChildByName("heroNode")

		anim:addCallbackAtFrame(6, function()
			if heroNode then
				local roleModel = IconFactory:getRoleModelByKey("HeroBase", heroId)

				if kHeroRarityBgGuang[heroConfig.Rareity] then
					local ssrdonghuaguang = cc.MovieClip:create(kHeroRarityBgGuang[heroConfig.Rareity])

					ssrdonghuaguang:addTo(heroNode):posite(0, 0)
					ssrdonghuaguang:addEndCallback(function()
						ssrdonghuaguang:stop()
					end)

					local function createRoleIcon(parent)
						local realImage = IconFactory:createRoleIconSpriteNew({
							useAnim = true,
							frameId = "bustframe6_5",
							id = roleModel
						})

						realImage:addTo(parent):posite(-300, -250)
					end

					local roleNode = ssrdonghuaguang:getChildByFullName("roleNode")

					if roleNode then
						createRoleIcon(roleNode)
					end

					local roleNode1 = ssrdonghuaguang:getChildByFullName("roleNode1")

					if roleNode1 then
						createRoleIcon(roleNode1)
					end

					local roleNode2 = ssrdonghuaguang:getChildByFullName("roleNode2")

					if roleNode2 then
						createRoleIcon(roleNode2)
					end

					anim:addCallbackAtFrame(30, function()
						self:addShare()
					end)
				else
					local heroAnim = cc.MovieClip:create("renwu_choukahuodeyinghun")

					heroAnim:addEndCallback(function()
						heroAnim:stop()
					end)

					local roleNode = heroAnim:getChildByName("roleNode")
					local realImage = IconFactory:createRoleIconSpriteNew({
						useAnim = true,
						frameId = "bustframe6_5",
						id = roleModel
					})

					realImage:addTo(roleNode)
					heroAnim:addTo(heroNode)
					heroAnim:setPosition(cc.p(-300, -300))
					anim:addCallbackAtFrame(20, function()
						self:addShare()
					end)
				end
			end
		end)

		local nameNode = anim:getChildByName("nameNode")

		nameText:changeParent(nameNode)
		nameText:setAnchorPoint(cc.p(0, 0.5))
		nameText:setPosition(cc.p(-100, 6))

		local cvnameNode = anim:getChildByName("cvnameNode")

		cvnameLabel:changeParent(cvnameNode)
		cvnameLabel:setAnchorPoint(cc.p(0, 0.5))
		cvnameLabel:setPosition(cc.p(-235, -2))

		local bgNode = anim:getChildByName("bgNode")
		local cvnameBg = main:getChildByName("cvnameBg")

		cvnameBg:changeParent(bgNode)
		cvnameBg:setPosition(cc.p(-173, -36))
		cvnameBg:setContentSize(cc.size(cvnameLabel:getContentSize().width + 40, 76))

		local nameBg = main:getChildByName("nameBg")

		nameBg:changeParent(bgNode)
		nameBg:setPosition(cc.p(-173, 20))
		nameBg:setContentSize(cc.size(nameText:getContentSize().width + 100, 102))

		local costAnim = cc.MovieClip:create("feiyong_choukahuodeyinghun")

		costAnim:addEndCallback(function()
			costAnim:stop()
		end)
		costAnim:addTo(cvnameNode):posite(-180, -76)

		local costNode = costAnim:getChildByName("costNode")

		costLabel:changeParent(costNode)
		costLabel:setAnchorPoint(cc.p(0.5, 0.5))
		costLabel:setPosition(cc.p(-3, 0))
		costAnim:setVisible(false)
		costAnim:setScale(0.7)
		anim:addCallbackAtFrame(13, function()
			costAnim:setVisible(true)
			costAnim:gotoAndPlay(0)
		end)

		local descNode = anim:getChildByName("descNode")

		soundDesc:changeParent(descNode)
		soundDesc:setPosition(cc.p(-180, 70))

		local occuNode = anim:getChildByName("occuNode")
		local occupationName, occupationImg = GameStyle:getHeroOccupation(heroConfig.Type)
		local occupation = ccui.ImageView:create(occupationImg)

		occupation:addTo(occuNode):posite(45, 5)

		local partyNode = anim:getChildByName("partyNode")

		if partyData[3] then
			local partyImage = ccui.ImageView:create(partyData[3])

			partyImage:addTo(partyNode):posite(0, 0)
		end

		local rarityBg1 = anim:getChildByName("rarityBg1")
		local rarity1BgImg1 = ccui.ImageView:create(kHeroRarityBg1[heroConfig.Rareity])

		rarity1BgImg1:addTo(rarityBg1)

		local rarityBg2 = anim:getChildByName("rarityBg2")
		local rarity1BgImg2 = ccui.ImageView:create(kHeroRarityBg2[heroConfig.Rareity])

		rarity1BgImg2:addTo(rarityBg2)

		local rarityNode = anim:getChildByName("rarityNode")
		local rarityAnim = kHeroRarityAnim[heroConfig.Rareity]

		if rarityAnim then
			local rarity1 = cc.MovieClip:create(rarityAnim)

			rarity1:addTo(rarityNode)
		end

		anim:addCallbackAtFrame(23, function()
			canClose = true
		end)
		anim:gotoAndPlay(0)

		if newHero then
			local new1 = anim:getChildByName("new1")
			local new2 = anim:getChildByName("new2")
			local new3 = anim:getChildByName("new3")

			if not table.indexof(showRarityTipHero, heroId) then
				local newImage1 = ccui.ImageView:create("new_word_1.png", 1)

				newImage1:addTo(new1)

				local newImage1 = ccui.ImageView:create("new_word_1.png", 1)

				newImage1:addTo(new2)

				local newImage1 = ccui.ImageView:create("new_word_2.png", 1)

				newImage1:addTo(new3):posite(0, 5)
			else
				self:showRarityUpEffect(new1, heroId)
			end
		end

		self:setupClickEnvs()
	end
end

function NewHeroMediator:showRarityUpEffect(parent, heroId)
	local hero = self._heroSystem:getHeroById(heroId)
	local rarity = hero:getRarity()
	local star = hero:getStar()
	local starAttr = self:checkIsShowSkill(hero)

	if not starAttr then
		return
	end

	if not starAttr[2] then
		table.insert(starAttr, {
			rarity = rarity,
			star = star
		})
	end

	if starAttr[1].rarity > hero:getRarity() then
		self._rarityPanel:setVisible(true)
		self._rarityPanel:changeParent(parent)
		self._rarityPanel:setPosition(cc.p(-200, -82))

		local node = self._rarityPanel:getChildByFullName("node")

		node:removeAllChildren()

		local anim = RoleFactory:createHeroAnimation(hero:getModel())

		node:addChild(anim)
		anim:setPosition(cc.p(0, -45))
		anim:setScale(0.46)

		local function createStar(panel, star)
			panel:removeAllChildren()

			local width = 0

			for i = 1, star do
				local image = ccui.ImageView:create("common_icon_star.png", 1)

				image:setScale(0.25)
				image:setAnchorPoint(cc.p(0, 0))
				image:setPosition(cc.p(width, -3))
				image:addTo(panel)

				width = width + image:getContentSize().width * 0.18
			end

			panel:setContentSize(cc.size(width, 10))
		end

		local star1 = self._rarityPanel:getChildByFullName("star1")

		createStar(star1, starAttr[2].star)

		local star2 = self._rarityPanel:getChildByFullName("star2")

		createStar(star2, starAttr[1].star)

		local rarity1 = self._rarityPanel:getChildByFullName("rarity1")
		local rarity2 = self._rarityPanel:getChildByFullName("rarity2")

		rarity1:ignoreContentAdaptWithSize(true)
		rarity2:ignoreContentAdaptWithSize(true)
		rarity1:loadTexture(GameStyle:getHeroRarityImage(starAttr[2].rarity), 1)
		rarity2:loadTexture(GameStyle:getHeroRarityImage(starAttr[1].rarity), 1)
	end
end

function NewHeroMediator:checkIsShowSkill(hero)
	local tipData = {}
	local list = self._heroSystem:getSkillShowList(hero:getId())

	for i = 1, #list do
		local data = list[#list - i + 1]

		if data and hero:getStar() < data.star and data.effectType and data.effectType == SpecialEffectType.kChangeRarity then
			local dataTemp = {
				rarity = data.parameter.value,
				star = data.star
			}

			table.insert(tipData, dataTemp)
		end
	end

	return #tipData > 0 and tipData or nil
end

function NewHeroMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)

		storyDirector:notifyWaiting("enter_newHero_view")

		local guideAgent = storyDirector:getGuideAgent()

		if guideAgent:isGuiding() and guideAgent:getCurrentScriptName() == "guide_chapterOne1_4" and self._heroId == "CLMan" then
			StatisticSystem:send({
				point = "guide_main_recruit_14",
				type = "loginpoint"
			})
		end
	end))

	self:getView():runAction(sequence)
end
