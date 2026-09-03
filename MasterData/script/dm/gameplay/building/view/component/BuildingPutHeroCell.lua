-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/component/BuildingPutHeroCell.lua

BuildingPutHeroCell = class("BuildingPutHeroCell", DmBaseUI)

BuildingPutHeroCell:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")
BuildingPutHeroCell:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kAwakenAnimTag = 1001
local kAwakenAnimTopTag = 1002

function BuildingPutHeroCell:initialize(data)
	super.initialize(self)
	self:setView(data.view)
end

function BuildingPutHeroCell:update(info)
	self._heroId = info.heroId
	self._roomId = info.roomId

	self:updateIcon()
end

function BuildingPutHeroCell:initView()
	return
end

function BuildingPutHeroCell:updateIcon()
	local view = self:getView()

	self._heroSystem = self._developSystem:getHeroSystem()

	local heroInfo = self._heroSystem:getHeroById(self._heroId)
	local heroPanel = view:getChildByName("hero")

	heroPanel:removeAllChildren()

	local heroImg = IconFactory:createRoleIconSpriteNew({
		id = heroInfo:getModel()
	})

	heroPanel:addChild(heroImg)
	heroImg:setScale(0.68)
	heroImg:setPosition(heroPanel:getContentSize().width / 2, heroPanel:getContentSize().height / 2)

	local bg1 = view:getChildByName("bg")
	local bg2 = view:getChildByName("bg1")
	local rarity = view:getChildByFullName("rarityBg.rarity")

	rarity:ignoreContentAdaptWithSize(true)
	rarity:removeAllChildren()

	local rarityAnim = IconFactory:getHeroRarityAnim(heroInfo:getRarity())

	if rarityAnim then
		rarityAnim:addTo(rarity):center(rarity:getContentSize())
		rarityAnim:offset(0, -6)
	end

	local cost = view:getChildByFullName("costBg.cost")

	cost:setString(heroInfo:getCost())
	bg1:loadTexture(GameStyle:getHeroRarityBg(heroInfo:getRarity())[1])
	bg2:loadTexture(GameStyle:getHeroRarityBg(heroInfo:getRarity())[2])

	local partyImg = view:getChildByFullName("partyImg")
	local partyPath = IconFactory:getHeroPartyPath(self._heroId, "building")

	if partyPath then
		partyImg:loadTexture(partyPath)
	end

	local starBg = view:getChildByName("starBg")
	local heroPrototype = PrototypeFactory:getInstance():getHeroPrototype(self._heroId)
	local heroConfig = heroPrototype:getConfig()
	local star = heroInfo:getStar()
	local maxStar = heroInfo:getMaxStar()
	local size = cc.size(148, 32)
	local width = size.width - (size.width / HeroStarCountMax - 2) * (HeroStarCountMax - maxStar)

	starBg:setContentSize(cc.size(width, size.height))

	for i = 1, HeroStarCountMax do
		local _star = starBg:getChildByName("star_" .. i)

		_star:setVisible(i <= maxStar)
		_star:loadTexture((heroInfo:getAwakenStar() > 0 or nil) and "jx_img_star.png", ccui.TextureResType.plistType)
	end

	local lovelevel = self._heroSystem:getLoveLevelById(self._heroId)
	local ll = view:getChildByFullName("heart.value")

	ll:setString(lovelevel)

	local loveExp = self._heroSystem:getHeroById(self._heroId):getLoveExp()
	local maxexp = self._heroSystem:getNextLoveExp(self._heroId, lovelevel)
	local percent = view:getChildByFullName("loading")
	local per = loveExp / maxexp

	percent:setPercent(per)

	local namePanel = view:getChildByName("namePanel")
	local name = namePanel:getChildByName("name")
	local qualityLevel = namePanel:getChildByName("qualityLevel")
	local nameDes = heroInfo:getName()

	name:setString(nameDes)
	qualityLevel:setString(heroInfo:getQualityLevel() == 0 and "" or " +" .. heroInfo:getQualityLevel())
	name:setPositionX(0)
	qualityLevel:setPositionX(name:getContentSize().width)
	namePanel:setContentSize(cc.size(name:getContentSize().width + qualityLevel:getContentSize().width, 30))
	GameStyle:setHeroNameByQuality(name, heroInfo:getQuality())
	GameStyle:setHeroNameByQuality(qualityLevel, heroInfo:getQuality())

	local nameBg = view:getChildByFullName("image")
	local nameWidth = name:getContentSize().width + qualityLevel:getContentSize().width
	local w = math.max(104, nameWidth + 25)

	nameBg:setContentSize(cc.size(w, nameBg:getContentSize().height))
	nameBg:setPositionX(namePanel:getPositionX())

	local buffAddNum, buffAddDesc = self._buildingSystem:getBuildPutHeroAddBuff(self._roomId, {
		self._heroId
	})
	local text_buffNum = view:getChildByName("Text_buffNum")

	text_buffNum:setString("+" .. buffAddDesc)

	local roomBg = view:getChildByFullName("roomBg")
	local roomPutId = self._buildingSystem:getHeroPutRoomId(self._heroId)

	if roomPutId then
		view:setGray(true)
		roomBg:setVisible(true)

		local textName = roomBg:getChildByFullName("Text")
		local textdes = Strings:get(ConfigReader:getDataByNameIdAndKey("VillageRoom", roomPutId, "Name"))

		textName:setString(textdes)
	else
		view:setGray(false)
		roomBg:setVisible(false)
	end

	local awakenAnim = bg1:getChildByTag(kAwakenAnimTag)
	local awakenAnimTop = heroPanel:getChildByTag(kAwakenAnimTopTag)

	if heroInfo:getAwakenStar() > 0 and not roomPutId then
		if not awakenAnim then
			awakenAnim = cc.MovieClip:create("dikuang_yinghunxuanze")

			awakenAnim:setTag(kAwakenAnimTag)
			awakenAnim:addTo(bg1):center(bg1:getContentSize()):offset(-2, 2)
			awakenAnim:setScale(2)
		end

		if not awakenAnimTop then
			local anim = cc.MovieClip:create("shangkuang_yinghunxuanze")

			anim:setTag(kAwakenAnimTopTag)
			anim:addTo(heroPanel):center(heroPanel:getContentSize()):offset(-2, 2)
			anim:setScale(2)
		end
	else
		if awakenAnim then
			awakenAnim:removeFromParent(true)
		end

		if awakenAnimTop then
			awakenAnimTop:removeFromParent(true)
		end
	end
end
