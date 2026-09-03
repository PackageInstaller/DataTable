-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/dreamChallenge/view/DreamChallengeBuffDetailMediator.lua

DreamChallengeBuffDetailMediator = class("DreamChallengeBuffDetailMediator", DmPopupViewMediator, _M)

DreamChallengeBuffDetailMediator:has("_dreamSystem", {
	is = "r"
}):injectWith("DreamChallengeSystem")
DreamChallengeBuffDetailMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
DreamChallengeBuffDetailMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {}
local kHeroRarityBgAnim = {
	[15] = "spzong_urequipeff",
	[13] = "srzong_yingxiongxuanze",
	[14] = "ssrzong_yingxiongxuanze"
}

function DreamChallengeBuffDetailMediator:initialize()
	super.initialize(self)
end

function DreamChallengeBuffDetailMediator:dispose()
	super.dispose(self)
end

function DreamChallengeBuffDetailMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function DreamChallengeBuffDetailMediator:enterWithData(data)
	self._heroSystem = self._developSystem:getHeroSystem()

	self:initWigetInfo()
	self:initData(data)
	self:setupInfoView()
end

function DreamChallengeBuffDetailMediator:initWigetInfo()
	self._view = self:getView()
	self._main = self._view:getChildByName("main")
	self._listBg = self._main:getChildByFullName("listBg")
	self._list = self._main:getChildByFullName("listBg.list")
	self._content = self._view:getChildByName("content")
	self._masterHead = self._view:getChildByName("masterHeadClone")
	self._tiredPanel = self._view:getChildByName("tiredPanelClone")
	self._myPet = self._view:getChildByName("myPetClone")
	self._contentChildClone = self._view:getChildByName("contentChildClone")
	self._infoCellClone = self._view:getChildByName("infoCellClone")
	self._contentAddClone = self._view:getChildByName("contentAddClone")
	self._contentBuffClone = self._view:getChildByName("contentBuffClone")

	local bgNode = self:getView():getChildByFullName("main.bg")
	local widget = self:bindWidget(bgNode, PopupNormalWidget, {
		bg = "bg_popup_dark.png",
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onCloseClicked, self)
		},
		title = Strings:get("DreamChallenge_Point_Title"),
		title1 = Strings:get("DreamChallenge_Point_Title_En"),
		bgSize = {
			width = 840,
			height = 538
		}
	})

	self._listBg:setContentSize(cc.size(680, 380))
	self._list:setContentSize(cc.size(680, 370))
end

function DreamChallengeBuffDetailMediator:initData(data)
	self._mapId = data.mapId
	self._pointId = data.pointId
end

function DreamChallengeBuffDetailMediator:setupInfoView()
	self._list:removeAllChildren()
	self._list:setScrollBarEnabled(false)

	local teamNumPanel = self:createTiredInfo()

	if teamNumPanel then
		self._list:pushBackCustomItem(teamNumPanel)
	end

	local masterPanel = self:createMasterInfo()

	if masterPanel then
		self._list:pushBackCustomItem(masterPanel)
	end

	local partenerPanel = self:createPartenerInfo()

	if partenerPanel then
		self._list:pushBackCustomItem(partenerPanel)
	end

	local addPanel = self:createAddInfo()

	if addPanel then
		self._list:pushBackCustomItem(addPanel)
	end

	local buffPanel = self:createBUFFInfo()

	if buffPanel then
		self._list:pushBackCustomItem(buffPanel)
	end

	local geroPanel = self:createHeroInfo()

	if teamNumPanel then
		self._list:pushBackCustomItem(geroPanel)
	end
end

function DreamChallengeBuffDetailMediator:setInfoCellBg(view, rowHeight, rowWidth)
	local bg = view:getChildByFullName("Image_38")

	view:setContentSize(cc.size(rowWidth, rowHeight))
	bg:setContentSize(cc.size(rowWidth, rowHeight))
	bg:setPositionY(rowHeight)
	view:getChildByFullName("mTopLayout"):setPositionY(rowHeight + 8)
	view:getChildByFullName("Image_31"):setPositionY(rowHeight - 5)
end

function DreamChallengeBuffDetailMediator:createMasterInfo()
	local masters = self._dreamSystem:getMasterList(self._mapId, self._pointId)

	if #masters > 0 then
		local view = self._content:clone()
		local name = view:getChildByFullName("mTopLayout.mExtraRewardLabel")

		name:setString(Strings:get("DreamChallenge_Point_Master_Title"))
		self:setInfoCellBg(view, 180, 688)

		for i = 1, #masters do
			local head = self._masterHead:clone()
			local itemIcon = IconFactory:createMasterIcon({
				scale = 0.3,
				id = masters[i]
			})
			local headBase = head:getChildByName("Panel_2")

			itemIcon:addTo(headBase):center(headBase:getContentSize())

			local nameStr = ConfigReader:getDataByNameIdAndKey("MasterBase", masters[i], "Name")

			head:getChildByName("name"):setString(Strings:get(nameStr))
			head:addTo(view)
			head:setPosition(cc.p(55 + (i - 1) * 123, 25))
		end

		return view
	end

	return nil
end

function DreamChallengeBuffDetailMediator:createAddInfo()
	local view = self._contentAddClone:clone()

	self:setInfoCellBg(view, 210, 688)

	local name = view:getChildByFullName("Image_31.mExtraRewardLabel")

	name:setString(Strings:get("DreamChallenge_Point_Addition_Title"))

	local addTable = {}
	local infoView = view:getChildByFullName("mTopLayout")

	infoView:removeAllChildren()

	local heros, skill = self._dreamSystem:getRecomandHero(self._mapId, self._pointId)
	local index = 1

	for i = 1, #heros do
		local config = ConfigReader:getRecordById("HeroBase", heros[i])
		local node3 = self._infoCellClone:clone()
		local attackText = node3:getChildByFullName("text")
		local icon = node3:getChildByFullName("icon")

		attackText:setString("")

		local effectConfig = ConfigReader:getRecordById("Skill", skill)

		if effectConfig then
			attackText:setString(Strings:get(effectConfig.Desc_short))
			attackText:setColor(cc.c3b(255, 159, 48))
		end

		icon:removeAllChildren()
		icon:loadTexture((config.Rareity == 15 or nil) and "asset/commonRaw/common_bd_sp01.png", ccui.TextureResType.localType)
		icon:setContentSize(cc.size(88, 88))

		local config = ConfigReader:getRecordById("HeroBase", heros[i])
		local heroImg = IconFactory:createRoleIconSpriteNew({
			id = config.RoleModel
		})

		heroImg:addTo(icon):center(icon:getContentSize())
		heroImg:setName("iconHero")
		heroImg:setScale(0.25)
		node3:addTo(infoView)
		table.insert(addTable, node3)
	end

	local partys, skill = self._dreamSystem:getRecomandParty(self._mapId, self._pointId)

	for i = 1, #partys do
		local node4 = self._infoCellClone:clone()
		local attackText = node4:getChildByFullName("text")
		local icon = node4:getChildByFullName("icon")

		attackText:setString("")

		local effectConfig = ConfigReader:getRecordById("Skill", skill)

		if effectConfig then
			attackText:setString(Strings:get(effectConfig.Desc_short))
			attackText:setColor(cc.c3b(255, 159, 48))
		end

		icon:removeAllChildren()

		local skillIcon = "asset/skillIcon/" .. effectConfig.Icon .. ".png"

		icon:loadTexture(skillIcon, ccui.TextureResType.localType)
		node4:addTo(infoView)
		table.insert(addTable, node4)
	end

	local jobs, skill = self._dreamSystem:getRecomandJob(self._mapId, self._pointId)

	for i = 1, #jobs do
		local node5 = self._infoCellClone:clone()
		local attackText = node5:getChildByFullName("text")
		local icon = node5:getChildByFullName("icon")

		attackText:setString("")

		local effectConfig = ConfigReader:getRecordById("Skill", skill)

		if effectConfig then
			attackText:setString(Strings:get(effectConfig.Desc_short))
			attackText:setColor(cc.c3b(255, 159, 48))
		end

		icon:removeAllChildren()

		local skillIcon = "asset/skillIcon/" .. effectConfig.Icon .. ".png"

		icon:loadTexture(skillIcon, ccui.TextureResType.localType)
		node5:addTo(infoView)
		table.insert(addTable, node5)
	end

	local recommendHero2 = self._view:getChildByFullName("recommendHero2")

	recommendHero2:changeParent(infoView)

	local attackText = recommendHero2:getChildByFullName("attackText")

	attackText:setString("")

	local skill = self._dreamSystem:getFullStarSkill(self._mapId, self._pointId)
	local effectConfig = ConfigReader:getRecordById("Skill", skill)

	if effectConfig then
		attackText:setString(Strings:get(effectConfig.Desc_short))
		attackText:setColor(cc.c3b(255, 159, 48))
	end

	table.insert(addTable, recommendHero2)

	local recommendHero3 = self._view:getChildByFullName("recommendHero3")
	local attackText = recommendHero3:getChildByFullName("attackText")

	attackText:setString("")

	local skill = self._dreamSystem:getAwakenSkill(self._mapId, self._pointId)
	local effectConfig = ConfigReader:getRecordById("Skill", skill)

	if effectConfig then
		attackText:setString(Strings:get(effectConfig.Desc_short))
		attackText:setColor(cc.c3b(255, 159, 48))
	end

	recommendHero3:changeParent(infoView)
	table.insert(addTable, recommendHero3)

	local size = #addTable
	local row = math.ceil(size / 5)
	local line = math.fmod(index, 5)
	local bgImage = view:getChildByFullName("Image_38")
	local title = view:getChildByFullName("Image_31")

	view:setContentSize(cc.size(688, row * 100 + 90))
	infoView:setContentSize(cc.size(625, row * 100))
	bgImage:setContentSize(cc.size(689, row * 100 + 90))
	bgImage:setPositionY(view:getContentSize().height)
	title:setPositionY(view:getContentSize().height - 5)

	for i = 1, size do
		local r = math.ceil(i / 5) + 1
		local w = math.fmod(i, 5)

		if w == 0 then
			w = 5
		end

		addTable[i]:setPosition(cc.p(10 + 120 * (w - 1), (row - r) * 110 + 30))
	end

	return view
end

function DreamChallengeBuffDetailMediator:createBUFFInfo()
	local view = self._contentAddClone:clone()
	local name = view:getChildByFullName("Image_31.mExtraRewardLabel")

	name:setString("BUFF")

	local infoView = view:getChildByFullName("mTopLayout")

	infoView:removeAllChildren()

	local buffIndex = 0
	local battleIds = self._dreamSystem:getBattleIds(self._mapId, self._pointId)

	for i = 1, #battleIds do
		local buff = self._dreamSystem:getBattleRewardBuff(battleIds[i])

		if buff then
			local buffInfo = buff
			local node = self._contentBuffClone:clone()
			local icon = node:getChildByFullName("icon")

			icon:removeAllChildren()

			local info = {}

			info.id = buffInfo.value

			local buffIcon = IconFactory:createBuffIcon(info, {
				scale = 0.65
			})

			buffIcon:addTo(icon):center(icon:getContentSize())

			local effectConfig = ConfigReader:getRecordById("Skill", buffInfo.value)
			local nameLab = node:getChildByFullName("title")

			nameLab:setString(Strings:get(effectConfig.Name))

			local descLab = node:getChildByFullName("desc")
			local desc = Strings:get(effectConfig.Desc)
			local richText = ccui.RichText:createWithXML(desc, {})

			richText:setAnchorPoint(descLab:getAnchorPoint())
			richText:setPosition(cc.p(descLab:getPosition()))
			richText:addTo(descLab:getParent())
			richText:renderContent(descLab:getContentSize().width, 0, true)

			local tipImg = node:getChildByFullName("tag")
			local tipText = node:getChildByFullName("tag.text")

			if buffInfo.Type == "OneTimeBuff" then
				tipImg:setVisible(true)
				tipImg:loadTexture("bg_mjt_jilibiaoshi.png", ccui.TextureResType.plistType)
				tipText:setString(Strings:get("DreamChallenge_Buff_Type_JL"))
			elseif buffInfo.Type == "TimeBuff" then
				tipImg:setVisible(true)
				tipImg:loadTexture("bg_mjt_xianshi.png", ccui.TextureResType.plistType)
				tipText:setString(Strings:get("DreamChallenge_Buff_Type_XS"))
			else
				tipImg:setVisible(false)
			end

			tipImg:setPositionX(135 + nameLab:getContentSize().width)

			local effectLab = node:getChildByFullName("effect")
			local isLock = self._dreamSystem:checkBuffLock(self._mapId, self._pointId, buffInfo.value)
			local isUsed = self._dreamSystem:checkBuffUsed(self._mapId, self._pointId, buffInfo.value)

			effectLab:setVisible(false)

			if isLock then
				local pointName = self._dreamSystem:getPointName(self._pointId)
				local battleName = self._dreamSystem:getBattleName(battleIds[i])

				effectLab:setVisible(true)
				effectLab:setString(Strings:get("DreamChallenge_Buff_Lock_Desc", {
					point = pointName,
					battle = battleName
				}))
			elseif isUsed then
				effectLab:setVisible(true)
				effectLab:setString(Strings:get("DreamChallenge_Buff_Used"))
			elseif buffInfo.Type == "OneTimeBuff" then
				local buffs = self._dreamSystem:getBuffs(self._mapId, self._pointId)

				if buffs and buffs[buffInfo.value] then
					effectLab:setVisible(true)
					effectLab:setString(Strings:get("DreamChallenge_Buff_End_Num", {
						num = buffs[buffInfo.value].duration
					}))
				end
			elseif buffInfo.Type == "TimeBuff" then
				local buffs = self._dreamSystem:getBuffs(self._mapId, self._pointId)

				if buffs and buffs[buffInfo.value] then
					effectLab:setVisible(true)

					local str = ""
					local fmtStr = "${d}:${H}:${M}:${S}"
					local timeStr = TimeUtil:formatTime(fmtStr, buffs[buffInfo.value].time)
					local parts = string.split(timeStr, ":", nil, true)
					local timeTab = {}

					timeTab.day = tonumber(parts[1])
					timeTab.hour = tonumber(parts[2])
					timeTab.min = tonumber(parts[3])
					timeTab.sec = tonumber(parts[4])
					str = timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") .. timeTab.hour .. Strings:get("TimeUtil_Hour") or timeTab.hour > 0 and timeTab.hour .. Strings:get("TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec")

					effectLab:setString(Strings:get("DreamChallenge_Buff_End_Time", {
						time = str
					}))
				end
			end

			effectLab:setPositionX(170 + nameLab:getContentSize().width)
			node:addTo(view)
			node:setPosition(cc.p(20, 100 * (i - 1) + 40))

			buffIndex = buffIndex + 1
		end
	end

	if buffIndex == 0 then
		return nil
	end

	self:setInfoCellBg(view, 80 + buffIndex * 100, 688)

	return view
end

function DreamChallengeBuffDetailMediator:createTiredInfo()
	local tiredNum = self._dreamSystem:getPointFatigue(self._mapId, self._pointId)
	local mapName = self._dreamSystem:getMapName(self._mapId)
	local pointName = self._dreamSystem:getPointName(self._pointId)
	local view = self._content:clone()
	local name = view:getChildByFullName("mTopLayout.mExtraRewardLabel")

	name:setString(Strings:get("DreamChallenge_Point_Tired_Title"))
	self:setInfoCellBg(view, 140, 688)

	local head = self._tiredPanel:clone()

	head:getChildByName("icon"):loadTexture("icon_pilao1.png", ccui.TextureResType.plistType)
	head:getChildByName("info"):setString(Strings:get("DreamChallenge_Point_Tired_Info", {
		mapName = mapName,
		pointName = pointName,
		num = tiredNum
	}))
	head:addTo(view)
	head:setPosition(cc.p(20, 95))

	return view
end

function DreamChallengeBuffDetailMediator:createPartenerInfo()
	local view = self._content:clone()
	local name = view:getChildByFullName("mTopLayout.mExtraRewardLabel")

	name:setString(Strings:get("DreamChallenge_Point_Partener_Title"))

	local hight = 75
	local rowIndex = 0
	local battles = self._dreamSystem:getBattleIds(self._mapId, self._pointId)

	for j = #battles, 1, -1 do
		local npcs = self._dreamSystem:getNpc(self._mapId, self._pointId, battles[j])

		if npcs and #npcs > 0 then
			hight = hight + 157
			rowIndex = rowIndex + 1

			local battleName = self._dreamSystem:getBattleName(battles[j])
			local title = self._contentChildClone:clone()

			title:getChildByFullName("mTopLayout.mExtraRewardLabel"):setString(battleName)
			title:addTo(view)
			title:setPosition(cc.p(0, (rowIndex - 1) * 157 + 200))

			for i = 1, #npcs do
				local info = self._dreamSystem:getNpcInfo(npcs[i])
				local node = self._myPet:clone()

				self:setHero(node, info)
				node:addTo(title)
				node:setPosition(cc.p((i - 1) * 121 + 100, 20))
				node:setScale(0.55)
			end
		end
	end

	self:setInfoCellBg(view, hight, 688)

	if rowIndex == 0 then
		return nil
	end

	return view
end

function DreamChallengeBuffDetailMediator:createHeroInfo()
	local view = self._content:clone()
	local heros = self._heroSystem:getHeroShowIds()
	local petList = self:removeLockedHeros(heros)
	local ownHeros = self._heroSystem:getOwnHeroIds(true)
	local ownIds = {}

	for i = 1, #ownHeros do
		ownIds[#ownIds + 1] = ownHeros[i].id
	end

	self._dreamSystem:sortHerosByType(petList, 2, ownIds)

	local rowMax = math.ceil(#petList / 5)

	self:setInfoCellBg(view, 105 + 120 * rowMax, 688)

	local name = view:getChildByFullName("mTopLayout.mExtraRewardLabel")

	name:setString(Strings:get("DreamChallenge_Point_Hero_Title"))

	for i = 1, #petList do
		local info = petList[i]
		local row = rowMax - math.ceil(i / 5) + 1
		local line = math.fmod(i, 5)

		if line == 0 then
			line = 5
		end

		local node = self._myPet:clone()

		self:setHero(node, info)
		node:addTo(view)
		node:setPosition(cc.p((line - 1) * 121 + 100, 120 * row - 15))
		node:setScale(0.55)
	end

	return view
end

function DreamChallengeBuffDetailMediator:removeLockedHeros(heros)
	local showHeros = {}
	local index = 1

	for k, v in pairs(heros) do
		if not self._dreamSystem:checkHeroLocked(self._mapId, self._pointId, v.id) then
			showHeros[index] = v
			index = index + 1
		end
	end

	return showHeros
end

function DreamChallengeBuffDetailMediator:setHero(node, info)
	local heroId = info.id
	local modelInfo = {}

	modelInfo.id = info.roleModel

	local heroImg = IconFactory:createRoleIconSpriteNew(modelInfo)

	heroImg:setScale(0.68)

	local heroPanel = node:getChildByName("hero")

	heroPanel:removeAllChildren()
	heroImg:addTo(heroPanel):center(heroPanel:getContentSize())

	local weak = node:getChildByName("weak")
	local weakTop = node:getChildByName("weakTop")
	local bg1 = node:getChildByName("bg1")
	local bg2 = node:getChildByName("bg2")

	bg1:loadTexture(GameStyle:getHeroRarityBg(info.rareity)[1])
	bg2:loadTexture(GameStyle:getHeroRarityBg(info.rareity)[2])
	bg1:removeAllChildren()
	bg2:removeAllChildren()
	weak:removeAllChildren()
	weakTop:removeAllChildren()

	if kHeroRarityBgAnim[info.rareity] then
		local anim = cc.MovieClip:create(kHeroRarityBgAnim[info.rareity])

		anim:addTo(bg1):center(bg1:getContentSize())
		anim:setPosition(cc.p(bg1:getContentSize().width / 2 - 1, bg1:getContentSize().height / 2 - 30))

		if info.rareity == 15 then
			anim:setPosition(cc.p(bg1:getContentSize().width / 2 - 3, bg1:getContentSize().height / 2))
		end

		if info.rareity >= 14 then
			local anim = cc.MovieClip:create("ssrlizichai_yingxiongxuanze")

			anim:addTo(bg2):center(bg2:getContentSize()):offset(5, -20)
		end
	else
		local sprite = ccui.ImageView:create(GameStyle:getHeroRarityBg(info.rareity)[1])

		sprite:addTo(bg1):center(bg1:getContentSize())
	end

	if info.awakenLevel and info.awakenLevel > 0 then
		local anim = cc.MovieClip:create("dikuang_yinghunxuanze")

		anim:addTo(weak):center(weak:getContentSize())
		anim:setScale(2)
		anim:offset(-5, 18)

		anim = cc.MovieClip:create("shangkuang_yinghunxuanze")

		anim:addTo(weakTop):center(weakTop:getContentSize())
		anim:setScale(2)
		anim:offset(-5, 18)
	end

	local rarity = node:getChildByFullName("rarityBg.rarity")

	rarity:removeAllChildren()

	local rarityAnim = IconFactory:getHeroRarityAnim(info.rareity)

	rarityAnim:addTo(rarity):posite(25, 15)

	local costBg = node:getChildByFullName("costBg")
	local cost = node:getChildByFullName("costBg.cost")

	cost:setString(info.cost)

	local occupationName, occupationImg = GameStyle:getHeroOccupation(info.type)
	local occupation = node:getChildByName("occupation")

	occupation:loadTexture(occupationImg)

	local namePanel = node:getChildByFullName("nameBg.name")

	namePanel:setString(info.name)

	local starBg = node:getChildByName("starBg")
	local size = cc.size(148, 32)
	local width = size.width - (size.width / HeroStarCountMax - 2) * (HeroStarCountMax - info.maxStar)

	starBg:setContentSize(cc.size(width, size.height))

	for i = 1, HeroStarCountMax do
		local star = starBg:getChildByName("star_" .. i)

		star:setVisible(i <= info.maxStar)

		local path = i <= info.star and "img_yinghun_img_star_full.png" or i == info.star + 1 and info.littleStar and "img_yinghun_img_star_half.png" or "img_yinghun_img_star_empty.png"

		if info.awakenLevel > 0 then
			path = "jx_img_star.png"
		end

		star:ignoreContentAdaptWithSize(true)
		star:setScale(0.4)
		star:loadTexture(path, 1)
	end

	local brightNess = (self._heroSystem:hasHero(heroId) or info.isNpc) and 0 or -75
	local saturation = (self._heroSystem:hasHero(heroId) or info.isNpc) and 0 or -80

	heroPanel:setBrightness(brightNess)
	heroPanel:setSaturation(saturation)
	bg1:setBrightness(brightNess)
	bg1:setSaturation(saturation)
	bg2:setBrightness(brightNess)
	bg2:setSaturation(saturation)
	rarity:setBrightness(brightNess)
	rarity:setSaturation(saturation)
	costBg:setBrightness(brightNess)
	costBg:setSaturation(saturation)
	starBg:setBrightness(brightNess)
	starBg:setSaturation(saturation)
	occupation:setBrightness(brightNess)
	occupation:setSaturation(saturation)
end

function DreamChallengeBuffDetailMediator:onCloseClicked()
	self:close()
end
