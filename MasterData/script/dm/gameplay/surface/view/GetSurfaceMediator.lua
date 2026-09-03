-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/surface/view/GetSurfaceMediator.lua

GetSurfaceMediator = class("GetSurfaceMediator", DmPopupViewMediator, _M)

GetSurfaceMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
GetSurfaceMediator:has("_surfaceSystem", {
	is = "r"
}):injectWith("SurfaceSystem")

local kHandlerBtn = {}
local heroRect = "asset/heroRect/heroRarity/"
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

function GetSurfaceMediator:initialize()
	super.initialize(self)
end

function GetSurfaceMediator:dispose()
	super.dispose(self)
end

function GetSurfaceMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kHandlerBtn)

	self._heroSystem = self._developSystem:getHeroSystem()
end

function GetSurfaceMediator:enterWithData(data)
	self:showResult(data)
end

function GetSurfaceMediator:showResult(data)
	local callback = data.callback
	local surfaceId = data.surfaceId
	local surface = self._surfaceSystem:getSurfaceById(surfaceId)

	if not surface then
		self:close()

		return
	end

	local heroId = surface:getTargetHero()
	local heroConfig = ConfigReader:getRecordById("HeroBase", heroId)
	local soundId

	AudioEngine:getInstance():playEffect("Se_Alert_New_Hero", false)

	local view = self:getView()
	local main = view:getChildByFullName("main")

	main:addClickEventListener(function(sender, eventType)
		if soundId then
			AudioEngine:getInstance():stopEffect(soundId)
		end

		self:close()

		if callback then
			callback()
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

	nameText:setString(surface:getName())

	local text = main:getChildByName("text")

	text:setString(Strings:get("SURFACE_UI9"))

	local soundDesc = main:getChildByName("soundDesc")
	local desc = ConfigReader:getDataByNameIdAndKey("Sound", "Voice_" .. heroId .. "_01", "SoundDesc")
	local str = Strings:get(desc)

	soundDesc:setString(str)

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

	local anim = cc.MovieClip:create("zonghe_choukahuodeyinghun")

	anim:addTo(main:getChildByName("animPanel"))
	anim:setPosition(cc.p(100, 100))
	anim:addEndCallback(function()
		anim:stop()
	end)

	local heroNode = anim:getChildByName("heroNode")

	anim:addCallbackAtFrame(6, function()
		if heroNode then
			local heroAnim = cc.MovieClip:create("renwu_choukahuodeyinghun")

			heroAnim:addEndCallback(function()
				heroAnim:stop()
			end)

			local roleNode = heroAnim:getChildByName("roleNode")
			local realImage = IconFactory:createRoleIconSpriteNew({
				useAnim = true,
				frameId = "bustframe9",
				id = surface:getModel()
			})

			realImage:addTo(roleNode):posite(100, 70)
			heroAnim:addTo(heroNode)
			heroAnim:setPosition(cc.p(-10, -123))
		end
	end)

	local nameNode = anim:getChildByName("nameNode")

	nameText:changeParent(nameNode)
	nameText:setAnchorPoint(cc.p(0, 0.5))
	nameText:setPosition(cc.p(-145, 6))
	text:changeParent(nameNode)
	text:setAnchorPoint(cc.p(0, 0.5))
	text:setPosition(cc.p(-145, 65))

	local model = ConfigReader:getDataByNameIdAndKey("RoleModel", surface:getModel(), "Model")
	local role = RoleFactory:createRoleAnimation(model)

	role:addTo(nameNode):posite(-80, -160)
	role:setScale(0.6)

	local descNode = anim:getChildByName("descNode")

	soundDesc:changeParent(descNode)
	soundDesc:setPosition(cc.p(-180, 70))

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
	anim:gotoAndPlay(0)
end
