-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/BattleHeroShowPopMediator.lua

BattleHeroShowPopMediator = class("BattleHeroShowPopMediator", PopupViewMediator, _M)

local kBtnHandlers = {
	mTouchLayout = "onTouchLayout"
}
local kBgAndImage = {
	[GalleryPartyType.kBSNCT] = "loading_img_bsn_new.png",
	[GalleryPartyType.kXD] = "loading_img_xd_new.png",
	[GalleryPartyType.kMNJH] = "loading_img_mnjh.png",
	[GalleryPartyType.kDWH] = "loading_img_dwh_new.png",
	[GalleryPartyType.kWNSXJ] = "loading_img_vnsxj.png",
	[GalleryPartyType.kSSZS] = "loading_img_smzs.png",
	[GalleryPartyType.kUNKNOWN] = "loading_img_unknown.png"
}
local kBgAndImageOffset = {
	[GalleryPartyType.kBSNCT] = 15,
	[GalleryPartyType.kXD] = 15,
	[GalleryPartyType.kMNJH] = 0,
	[GalleryPartyType.kDWH] = 12,
	[GalleryPartyType.kWNSXJ] = 8,
	[GalleryPartyType.kSSZS] = 0,
	[GalleryPartyType.kUNKNOWN] = 0
}

function BattleHeroShowPopMediator:initialize()
	super.initialize(self)
end

function BattleHeroShowPopMediator:dispose()
	if self._enterHeroAudio then
		AudioEngine:getInstance():stopEffect(self._enterHeroAudio)

		self._enterHeroAudio = nil
	end

	super.dispose(self)
end

function BattleHeroShowPopMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function BattleHeroShowPopMediator:enterWithData(data)
	self._data = data

	local action1 = cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(function()
		self.___canClose = true

		local view = self:getView()
		local closeLabel = view:getChildByFullName("content.closeLabel")

		closeLabel:setVisible(true)
		closeLabel:setOpacity(0)
		closeLabel:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeIn:create(0.5), cc.DelayTime:create(1), cc.FadeOut:create(0.5))))
		closeLabel:setLocalZOrder(100)
	end))

	self:getView():runAction(action1)
	self:initView()
end

function BattleHeroShowPopMediator:leaveWithData()
	self:onTouchLayout()
end

function BattleHeroShowPopMediator:onTouchLayout(sender, eventType)
	if self.___canClose then
		self:close()
	end
end

local kOffsetX = {
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
	-20,
	-20,
	-15,
	0,
	0
}
local kOffsetY = {
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
	-3,
	-3,
	-0.5,
	-0.5,
	-0.5
}

function BattleHeroShowPopMediator:initView()
	local view = self:getView()
	local heroId = self._data.heroId

	self._enterHeroAudio = AudioEngine:getInstance():playEffect("Voice_" .. heroId .. "_25", false)

	local heroConfig = ConfigReader:getRecordById("HeroBase", heroId)
	local model = heroConfig.RoleModel
	local img = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = model
	})
	local infoNode = self:getView():getChildByFullName("content.infoNode.node")

	self:initSkillInfo(heroConfig.UniqueSkill)
	self:initRoleInfo(infoNode, heroConfig)

	local genderNode = self:getView():getChildByFullName("content.genderNode.node")

	self:initGenderNode(genderNode, heroConfig)

	local nameNode = self:getView():getChildByFullName("content.nameNode.heroName")

	nameNode:setString(Strings:get(heroConfig.Name))

	local energy_lab = self:getView():getChildByFullName("content.Node_energy.energy_lab")

	energy_lab:setString(heroConfig.Cost)

	if not heroConfig.Rareity then
		local rarity = 14
		local rarityAnim = IconFactory:getHeroRarityAnim(rarity)

		rarityAnim:setScale(1.21)

		local anim = cc.MovieClip:create("xinyinghunjieshao_xinyinghunjieshao")

		anim:addEndCallback(function(cid, mc)
			mc:stop()
		end)
		infoNode:changeParent(anim:getChildByFullName("bsj"))
		infoNode:setPosition(cc.p(8.5, -4.5))
		genderNode:changeParent(anim:getChildByFullName("zy"))
		genderNode:setPosition(cc.p(6, 3))
		nameNode:changeParent(anim:getChildByFullName("name"))
		nameNode:setPosition(cc.p(-90, 10))
		rarityAnim:posite(kOffsetX[rarity], kOffsetY[rarity]):addTo(anim:getChildByFullName("r"))
		img:addTo(anim:getChildByFullName("role"))
		img:offset(0, -100):setScale(0.8)
		anim:play()
		anim:addTo(view:getChildByFullName("content")):posite(568, 320)

		local node_energy = self:getView():getChildByFullName("content.Node_energy")

		node_energy:changeParent(anim:getChildByFullName("c"))
		node_energy:setPosition(cc.p(-6, 3))
	end
end

function BattleHeroShowPopMediator:initSkillInfo(skillId)
	if skillId then
		::label_10_0::

		local config = ConfigReader:getRecordById("Skill", skillId)
		local skillIcon = self:getView():getChildByFullName("content.genderNode.node.skillIcon")

		skillIcon:loadTexture("asset/skillIcon/" .. config.Icon .. ".png", ccui.TextureResType.localType)
	end
end

function BattleHeroShowPopMediator:initRoleInfo(node, config)
	local heroShowIntro = config.HeroShowIntro
	local desc = node:getChildByFullName("Desc")
	local name = node:getChildByFullName("Name")

	if getCurrentLanguage() ~= GameLanguageType.CN then
		name:setPositionY(name:getPositionY() + 8)
	end

	desc:setVisible(false)

	local richText = ccui.RichText:createWithXML(Strings:get(heroShowIntro, {
		fontSize = 16,
		fontName = TTF_FONT_FZYH_R
	}), {})

	richText:setAnchorPoint(cc.p(0, 1))
	richText:setPosition(cc.p(desc:getPositionX(), name:getPositionY() - 10))
	richText:addTo(desc:getParent())

	local descWidth = desc:getContentSize().width + 20

	richText:renderContent(descWidth, 0)

	local partyImage = kBgAndImage[config.Party or ""]

	if partyImage then
		local node = node:getChildByFullName("NodeParty")
		local pic = ccui.ImageView:create(partyImage, ccui.TextureResType.plistType)

		pic:setScale(0.5)
		pic:setPositionY(kBgAndImageOffset[config.Party or ""])
		pic:addTo(node)
	end
end

function BattleHeroShowPopMediator:initGenderNode(node, config)
	local genderName = node:getChildByFullName("genderName")
	local genderIcon = node:getChildByFullName("genderIcon")
	local genderDesc = node:getChildByFullName("genderDesc")
	local name, image, imageType = GameStyle:getBatleHeroOccupation(config.Type)

	genderName:setString(Strings:get(name))
	genderIcon:loadTexture(image, imageType or ccui.TextureResType.localType)
	genderDesc:setString(Strings:get(config.Position))
	genderIcon:setPositionX(genderName:getPositionX() + genderName:getContentSize().width + 25)
end
