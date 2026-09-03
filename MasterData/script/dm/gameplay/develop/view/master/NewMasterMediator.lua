-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/master/NewMasterMediator.lua

NewMasterMediator = class("NewMasterMediator", DmPopupViewMediator, _M)

NewMasterMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kHandlerBtn = {}
local GalleryPartyType = {
	kBSNCT = "BSNCT",
	kWNSXJ = "WNSXJ",
	kUNKNOWN = "UNKNOWN",
	kMNJH = "MNJH",
	kDWH = "DWH",
	kXD = "XD",
	kSSZS = "SSZS"
}
local kBgAnimAndImage = {
	[GalleryPartyType.kBSNCT] = {
		"businiao_choukahuodeyinghun",
		"asset/scene/party_bg_businiao",
		"asset/ui/gallery/party_icon_businiao.png"
	},
	[GalleryPartyType.kXD] = {
		"xide_choukahuodeyinghun",
		"asset/scene/party_bg_xide",
		"asset/ui/gallery/party_icon_xide.png"
	},
	[GalleryPartyType.kMNJH] = {
		"monv_choukahuodeyinghun",
		"asset/scene/party_bg_monv",
		"asset/ui/gallery/party_icon_monv.png"
	},
	[GalleryPartyType.kDWH] = {
		"dongwenhui_choukahuodeyinghun",
		"asset/scene/party_bg_dongwenhui",
		"asset/ui/gallery/party_icon_dongwenhui.png"
	},
	[GalleryPartyType.kWNSXJ] = {
		"weinasi_weinasixianjing",
		"asset/scene/party_bg_weinasi"
	},
	[GalleryPartyType.kSSZS] = {
		"weinasi_weinasixianjing",
		"asset/scene/party_bg_weinasi",
		"asset/ui/gallery/party_icon_she.png"
	},
	[GalleryPartyType.kUNKNOWN] = {
		"weinasi_weinasixianjing",
		"asset/scene/party_bg_unknown",
		"asset/ui/gallery/party_icon_unknown.png"
	}
}

function NewMasterMediator:initialize()
	super.initialize(self)
end

function NewMasterMediator:dispose()
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)

	storyDirector:notifyWaiting("dispose_newHero_view")
	super.dispose(self)
end

function NewMasterMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kHandlerBtn)

	self._heroSystem = self._developSystem:getHeroSystem()
end

function NewMasterMediator:enterWithData(data)
	if data == nil then
		return
	end

	self:showResult(data)
end

function NewMasterMediator:showResult(data)
	local callback = data.callback
	local masterId = data.masterId
	local masterConfig = ConfigReader:getRecordById("MasterBase", masterId)

	if masterConfig == nil then
		return
	end

	local newHero = true
	local canClose = not newHero
	local soundId

	AudioEngine:getInstance():playEffect("Se_Alert_New_Hero", false)

	local view = self:getView()
	local main = view:getChildByFullName("main")

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
	main:getChildByName("soundDesc"):setVisible(true)
	main:getChildByName("cvname"):setVisible(false)
	main:getChildByName("costLabel"):setVisible(false)

	local nameText = main:getChildByName("nameLabel")

	nameText:setString(Strings:get(masterConfig.Name))

	local costLabel = main:getChildByName("costLabel")

	costLabel:setString("")

	local cvnameLabel = main:getChildByName("cvname")

	cvnameLabel:setString("")

	local soundDesc = main:getChildByName("soundDesc")
	local masterConfig = ConfigReader:getRecordById("MasterBase", masterId)
	local str = Strings:get(masterConfig.Desc)

	soundDesc:setString(str)

	local partyData = kBgAnimAndImage[masterConfig.ShowGallery]
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
				frameId = "bustframe2_1",
				id = masterConfig.RoleModel
			})

			realImage:setAnchorPoint(0.5, 0.5)
			realImage:addTo(roleNode)
			realImage:setPosition(cc.p(0, 160))
			heroAnim:addTo(heroNode)
			heroAnim:setPosition(cc.p(0, 0))
		end
	end)

	local nameNode = anim:getChildByName("nameNode")

	nameText:changeParent(nameNode)
	nameText:setAnchorPoint(cc.p(0, 0.5))
	nameText:setPosition(cc.p(-100, 6))

	local bgNode = anim:getChildByName("bgNode")
	local cvnameBg = main:getChildByName("cvnameBg")

	cvnameBg:setVisible(false)

	local nameBg = main:getChildByName("nameBg")

	nameBg:changeParent(bgNode)
	nameBg:setPosition(cc.p(-173, 20))
	nameBg:setContentSize(cc.size(nameText:getContentSize().width + 100, 102))
	anim:addCallbackAtFrame(13, function()
		return
	end)

	local descNode = anim:getChildByName("descNode")

	soundDesc:changeParent(descNode)
	soundDesc:setPosition(cc.p(-180, 70))

	local partyNode = anim:getChildByName("partyNode")

	if partyData[3] then
		local partyImage = ccui.ImageView:create(partyData[3])

		partyImage:addTo(partyNode):posite(0, 0)
	end

	anim:addCallbackAtFrame(23, function()
		canClose = true
	end)
	anim:gotoAndPlay(0)

	if newHero then
		local new1 = anim:getChildByName("new1")
		local new2 = anim:getChildByName("new2")
		local new3 = anim:getChildByName("new3")
		local newImage1 = ccui.ImageView:create("new_word_1.png", 1)

		newImage1:addTo(new1)

		local newImage1 = ccui.ImageView:create("new_word_1.png", 1)

		newImage1:addTo(new2)

		local newImage1 = ccui.ImageView:create("new_word_2.png", 1)

		newImage1:addTo(new3):posite(2, 5)
	end

	self:setupClickEnvs()
end

function NewMasterMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end
end
