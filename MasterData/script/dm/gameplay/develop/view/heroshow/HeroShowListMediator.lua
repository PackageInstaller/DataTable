-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/heroshow/HeroShowListMediator.lua

HeroShowListMediator = class("HeroShowListMediator", DmAreaViewMediator, _M)

HeroShowListMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
HeroShowListMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
HeroShowListMediator:has("_chooseHeroId", {
	is = "rw"
})
HeroShowListMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local kHeroRarityBgAnim = {
	[15] = "spzong_urequipeff",
	[13] = "srzong_yingxiongxuanze",
	[14] = "ssrzong_yingxiongxuanze"
}
local kHeroWeakemAnim = "dikuang_yinghunxuanze"
local kHeroWeakemShangAnim = "shangkuang_yinghunxuanze"
local kNum = 3
local kBtnHandlers = {
	["main.sortBtnPanel.sortBtn"] = {
		clickAudio = "Se_Click_Tab_1",
		func = "onClickSort"
	},
	["main.heroNode.nameBg.strengthenNode.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickEquip"
	}
}
local kEquipTypeToImage = {
	[HeroEquipType.kWeapon] = "img_yinghun_weapon",
	[HeroEquipType.kDecoration] = "img_yinghun_accessories",
	[HeroEquipType.kTops] = "img_yinghun_clothes",
	[HeroEquipType.kShoes] = "img_yinghun_shoes"
}
local TargetOccupation = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Team_TypeOrder", "content")
local SortExtendFunc = {
	{
		func = function(sortExtendType, hero)
			return hero.rareity == 17 - sortExtendType
		end
	},
	{
		func = function(sortExtendType, hero)
			return hero.type == TargetOccupation[sortExtendType - 5]
		end
	}
}

function HeroShowListMediator:initialize()
	super.initialize(self)
end

function HeroShowListMediator:dispose()
	self._selectImage:release()
	super.dispose(self)
end

function HeroShowListMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._bagSystem = self._developSystem:getBagSystem()
	self._heroSystem = self._developSystem:getHeroSystem()

	self.mapEventListener(self, self:getEventDispatcher(), EVT_HEROCOMPOSE_SUCC, self, self.refreshView)
end

function HeroShowListMediator:enterWithData(data)
	self._subSortType = {}

	self._stageSystem:setSortType(1)
	cc.UserDefault:getInstance():setBoolForKey(UserDefaultKey.kGetNewHeroRed, false)

	self._showHeroAnim = false
	self._updateDataList = {}
	self._teamHeroes = {}

	local teamList = self._developSystem:getAllUnlockTeams()

	for i = 1, #teamList do
		local heroes = teamList[i]:getHeroes()

		for j = 1, #heroes do
			self._teamHeroes[heroes[j]] = self._teamHeroes[heroes[j]] or 1
		end
	end

	self:initData()
	self:initWidgetInfo()
	self:setupTopInfoWidget()
	self:initView()
	self:initHeroInfo()
	self:refreshEquip()
	self:runStartAnim()
end

function HeroShowListMediator:resumeWithData(data)
	self._showHeroAnim = false
	self._chooseHeroId = self._heroSystem:getUiSelectHeroId() or self._chooseHeroId

	self:refreshView()
	self:runResumeAnim()
end

function HeroShowListMediator:initWidgetInfo()
	self._progressPanel = self:getView():getChildByName("progressPanel")

	self._progressPanel:setVisible(false)

	self._cellClone = self:getView():getChildByName("cellClone")

	self._cellClone:setVisible(false)

	self._touchLayer = self:getView():getChildByName("touchLayer")
	self._main = self:getView():getChildByFullName("main")
	self._heroNode = self._main:getChildByFullName("heroNode")
	self._unownPanel = self._heroNode:getChildByFullName("nameBg.unownPanel")
	self._strengthenNode = self._heroNode:getChildByFullName("nameBg.strengthenNode")

	self._unownPanel:setVisible(false)
	self._strengthenNode:setVisible(false)

	self._listNode = self._main:getChildByFullName("heroList")
	self._buttonTip = self._heroNode:getChildByFullName("nameBg.buttonTip")
	self._sortType = self._main:getChildByFullName("sortBtnPanel.sortBtn.text")

	self._heroNode:setTouchEnabled(true)
	self._heroNode:addClickEventListener(function()
		local heroInfo = self._heroSystem:getHeroInfoById(self._chooseHeroId)

		if not heroInfo then
			return
		end

		if heroInfo.showType == HeroShowType.kHas then
			self:onClickStrength()
		elseif heroInfo.showType == HeroShowType.kNotOwn then
			self:onClickDetail()
		end
	end)

	local sortType = self._stageSystem:getSortType()
	local sortStr = self._stageSystem:getSortTypeStr(sortType)

	self._sortType:setString(sortStr)
	self._unownPanel:getChildByFullName("leftPanel.loadingBg.loadingBar"):setScale9Enabled(true)
	self._unownPanel:getChildByFullName("leftPanel.loadingBg.loadingBar"):setCapInsets(cc.rect(1, 1, 1, 1))

	self._cellWidth = 630
	self._cellHeight = self._cellClone:getContentSize().height
	self._iconWidth = self._cellClone:getContentSize().width

	self._heroNode:getChildByFullName("nameBg.rarity"):ignoreContentAdaptWithSize(true)
	CommonUtils.runActionEffect(self._buttonTip:getChildByFullName("rightBtn"), "Node_2.rightBtn", "LeftRightArrowEffect", "anim1", true)

	self._selectImage = self:createSelectImage()

	self:adjustView()
end

function HeroShowListMediator:createSelectImage()
	local selectImage = ccui.ImageView:create("asset/common/yh_bd_selected.png")

	selectImage:addTo(self:getView())
	selectImage:setName("SelectImage")
	selectImage:setVisible(false)
	selectImage:retain()
	selectImage:removeFromParent(false)

	return selectImage
end

function HeroShowListMediator:refreshBg()
	local heroData = self._heroSystem:getHeroInfoById(self._chooseHeroId)
	local bgPanel = self._main:getChildByFullName("animPanel")

	bgPanel:stopAllActions()
	bgPanel:removeAllChildren()

	local hero = self._heroSystem:getHeroById(self._chooseHeroId)

	if hero then
		local var_11_0 = GameStyle:getHeroPartyByHeroInfo(hero)

		if not var_11_0 then
			var_11_0 = GameStyle:getHeroPartyBg(heroData.party)

			local bgAnim = var_11_0

			bgAnim:addTo(bgPanel)
			bgPanel:setScale(1.2)
			bgPanel:runAction(cc.ScaleTo:create(0.2, 1))

			self._bgAnim = bgAnim
		end
	end
end

function HeroShowListMediator:adjustView()
	local leftNode = self._main:getChildByFullName("leftNode")

	AdjustUtils.ignorSafeAreaRectForNode(leftNode:getChildByFullName("listBg.image1"), AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(leftNode:getChildByFullName("listBg.image2"), AdjustUtils.kAdjustType.Right)
	AdjustUtils.ignorSafeAreaRectForNode(leftNode:getChildByFullName("listBg.image3"), AdjustUtils.kAdjustType.Bottom)
	AdjustUtils.addSafeAreaRectForNode(self._heroNode, AdjustUtils.kAdjustType.Bottom)
	AdjustUtils.ignorSafeAreaRectForNode(self._heroNode, AdjustUtils.kAdjustType.Right)

	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()

	self._listNode:setContentSize(cc.size(self._cellWidth, winSize.height - 65))
end

function HeroShowListMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("Hero_Quality")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		style = 1,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("HEROS_UI1"),
		fontSize = getCurrentLanguage() ~= GameLanguageType.CN and 36 or nil
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function HeroShowListMediator:initData()
	self._kLayerTag = 99999
	self._showList, self._inactiveHeroes = self._heroSystem:getCanActiveHeroes()
	self._ownHeroList = self._heroSystem:getOwnHeroIds()
	self._isShowLine = #self._inactiveHeroes > 0

	for i = 1, #self._ownHeroList do
		self._showList[#self._showList + 1] = self._ownHeroList[i]
	end

	self._chooseHeroId = self._ownHeroList[1].id
end

function HeroShowListMediator:updateData()
	for i, v in pairs(self._updateDataList) do
		self._updateDataList[i] = true
	end

	self._showList, self._inactiveHeroes = self._heroSystem:getCanActiveHeroes()
	self._ownHeroList = self._heroSystem:getOwnHeroIds()
	self._isShowLine = #self._inactiveHeroes > 0

	for i = 1, #self._ownHeroList do
		self._showList[#self._showList + 1] = self._ownHeroList[i]
	end

	if next(self._subSortType) and self._subSortType[1] ~= 1 then
		local retList = {}
		local sub1 = {}
		local sub2 = {}

		for i, v in ipairs(self._subSortType) do
			if v ~= 1 and v <= 5 then
				table.insert(sub1, v)
			elseif v ~= 1 then
				table.insert(sub2, v)
			end
		end

		if next(sub1) then
			for i, hero in pairs(self._showList) do
				for i, sort in ipairs(sub1) do
					if SortExtendFunc[1].func(sort, hero) then
						table.insert(retList, hero)

						break
					end
				end
			end

			self._showList = retList
		else
			retList = self._showList
		end

		local retList2 = {}

		if next(sub2) then
			for i, hero in pairs(retList) do
				for i, sort in ipairs(sub2) do
					if SortExtendFunc[2].func(sort, hero) then
						table.insert(retList2, hero)

						break
					end
				end
			end

			self._showList = retList2
		end
	end

	local heroInfo = self._heroSystem:getHeroInfoById(self._chooseHeroId)

	if heroInfo.showType == HeroShowType.kCanComp then
		self._chooseHeroId = self._ownHeroList[1].id
	end
end

function HeroShowListMediator:initView()
	local function scrollViewDidScroll(view)
		self._isReturn = false
	end

	local function cellSizeForTable(table, idx)
		if idx == 0 then
			return self._cellWidth, self._cellHeight + 55
		end

		return self._cellWidth, self._cellHeight + 5
	end

	local function numberOfCellsInTableView(table)
		local num1 = math.ceil(#self._showList / kNum)
		local num2 = math.ceil(#self._inactiveHeroes / kNum)

		return num1 + num2
	end

	local function tableCellAtIndex(table, idx)
		local index = idx + 1
		local cell = table:dequeueCellByTag(index)

		if cell and not self._updateDataList[index] then
			local layoutPanel = cell:getChildByTag(self._kLayerTag)

			for i = 1, kNum do
				if layoutPanel:getChildByTag(i) then
					local isSelected = layoutPanel:getChildByTag(i).id == self._chooseHeroId

					layoutPanel:getChildByTag(i):setScale(1)

					if isSelected then
						layoutPanel:getChildByTag(i):setLocalZOrder(1)
					else
						layoutPanel:getChildByTag(i):setLocalZOrder(2)
					end
				end
			end

			return cell
		end

		if cell == nil then
			cell = cc.TableViewCell:new()

			local layoutPanel = ccui.Layout:create()

			layoutPanel:setTouchEnabled(false)
			layoutPanel:setAnchorPoint(cc.p(0.5, 0))
			layoutPanel:addTo(cell)
			layoutPanel:setTag(self._kLayerTag)
			layoutPanel:setContentSize(cc.size(self._cellWidth, self._cellHeight))
			layoutPanel:setPosition(cc.p(self._cellWidth / 2, 0))
		end

		cell:setTag(index)
		self:createTeamCell(cell, index)

		self._updateDataList[index] = false

		return cell
	end

	local tableView = cc.TableView:create(self._listNode:getContentSize())

	self._heroView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	tableView:setBounceable(false)

	local baseNode = cc.GroupedNode:create()

	self._listNode:addChild(baseNode)
	baseNode:addChild(tableView)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)

	local leftPanel = self._unownPanel:getChildByFullName("leftPanel")

	leftPanel:setTouchEnabled(true)
	leftPanel:addClickEventListener(function()
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local config = PrototypeFactory:getInstance():getHeroPrototype(self._chooseHeroId):getConfig()
		local needCount = self._heroSystem:getHeroComposeFragCount(self._chooseHeroId)
		local hasCount = self._heroSystem:getHeroDebrisCount(self._chooseHeroId)
		local param = {
			isNeed = true,
			hasWipeTip = true,
			itemId = config.ItemId,
			hasNum = hasCount,
			needNum = needCount
		}
		local view = self:getInjector():getInstance("sourceView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, delegate, param))
	end)
end

function HeroShowListMediator:createTeamCell(cell, index)
	local layoutPanel = cell:getChildByTag(self._kLayerTag)
	local list = {}
	local index_ = index

	if self._isShowLine and index <= math.ceil(#self._showList / kNum) or not self._isShowLine then
		list = self._showList
	elseif self._isShowLine and index > math.ceil(#self._showList / kNum) then
		index_ = index - math.ceil(#self._showList / kNum)
		list = self._inactiveHeroes
	end

	cell.heroData = {}

	for i = 1, kNum do
		if layoutPanel:getChildByTag(i) then
			layoutPanel:getChildByTag(i):setVisible(false)

			layoutPanel:getChildByTag(i).id = nil
		end

		local heroData = list[kNum * (index_ - 1) + i]

		if heroData then
			cell.heroData[i] = heroData

			local heroIcon = layoutPanel:getChildByTag(i)

			if not heroIcon then
				heroIcon = self._cellClone:clone()

				heroIcon:addTo(layoutPanel)
				heroIcon:setTag(i)
				heroIcon:setAnchorPoint(cc.p(0.5, 0))
				heroIcon:setPosition(cc.p(30 + self._iconWidth / 2 + (self._iconWidth + 15) * (i - 1), 0))
			end

			heroIcon.id = heroData.id

			local actionNode = heroIcon:getChildByName("actionNode")
			local heroPanel = actionNode:getChildByName("hero")

			heroPanel:removeAllChildren()

			local heroImg = IconFactory:createRoleIconSpriteNew({
				id = heroData.roleModel
			})

			heroPanel:addChild(heroImg)
			heroImg:setScale(0.68)
			heroImg:setPosition(heroPanel:getContentSize().width / 2, heroPanel:getContentSize().height / 2)

			local costBg = actionNode:getChildByFullName("costBg")
			local cost = actionNode:getChildByFullName("cost")

			if not costBg then
				costBg = cc.Sprite:create("asset/common/common_bd_fei_big.png")

				costBg:addTo(actionNode):posite(153, 167)
				costBg:setScale(0.52)
				costBg:setName("costBg")
				costBg:setGlobalZOrder(104)
				cost:getVirtualRenderer():setGlobalZOrder(200)
			end

			local namePanel = actionNode:getChildByName("namePanel")
			local name = namePanel:getChildByName("name")
			local qualityLevel = namePanel:getChildByName("qualityLevel")
			local nameBg = actionNode:getChildByFullName("nameBg")

			if not nameBg then
				nameBg = ccui.ImageView:create("asset/common/common_bd_jsmd.png", ccui.TextureResType.localType)

				nameBg:setScale9Enabled(true)
				nameBg:setAnchorPoint(cc.p(0.5, 0))
				nameBg:addTo(actionNode):posite(91, -8.6)
				nameBg:setName("nameBg")
				nameBg:setGlobalZOrder(91)
				name:getVirtualRenderer():setGlobalZOrder(101)
				qualityLevel:getVirtualRenderer():setGlobalZOrder(101)
			end

			local occupationBg = actionNode:getChildByName("occupationBg")

			if not occupationBg then
				occupationBg = cc.Sprite:create("asset/common/yh_bd_zyd.png")

				occupationBg:addTo(actionNode):posite(38, 61)
				occupationBg:setGlobalZOrder(93)
				occupationBg:setName("occupationBg")

				local baseNode = cc.GroupedNode:create()

				baseNode:addTo(occupationBg)
				baseNode:setGlobalZOrder(94)
				baseNode:setName("baseNode")

				local occupation = ccui.ImageView:create()

				occupation:addTo(baseNode):posite(23.7, 32)
				occupation:setScale(0.64)
				occupation:setName("occupation")
				occupation:setGlobalZOrder(94)
			end

			local occupation = occupationBg:getChildByFullName("baseNode.occupation")

			actionNode:removeChildByName("rarityBg")

			local rarityBg = cc.Sprite:create("asset/common/" .. ((heroData.rareity == 15 or nil) and "common_bd_xydd_sp.png"))

			rarityBg:addTo(actionNode):posite(32, 167)
			rarityBg:setGlobalZOrder(95)
			rarityBg:setName("rarityBg")

			local baseNode = cc.GroupedNode:create()

			baseNode:addTo(rarityBg)
			baseNode:setGlobalZOrder(96)
			baseNode:setName("baseNode")

			local rarityAnim = IconFactory:getHeroRarityAnim(heroData.rareity)

			rarityAnim:addTo(baseNode):posite(36, 40)

			if heroData.rareity == 15 then
				rarityAnim:setPosition(cc.p(38, 55))
			end

			local levelImage = actionNode:getChildByName("levelImage")
			local level = actionNode:getChildByFullName("level")

			if not levelImage then
				levelImage = cc.Sprite:create("asset/common/common_bd_djd.png")

				levelImage:addTo(actionNode):posite(151, 60)
				levelImage:setName("levelImage")
				levelImage:setGlobalZOrder(102)
				level:getVirtualRenderer():setGlobalZOrder(103)
			end

			level:setVisible(false)
			levelImage:setVisible(false)

			local starBg = actionNode:getChildByFullName("starBg")

			if not starBg then
				starBg = cc.Sprite:create("asset/common/common_icon_stard.png")

				starBg:addTo(actionNode):posite(91.6, 35.5)
				starBg:setGlobalZOrder(97)
				starBg:setName("starBg")

				self._starBgWidth = starBg:getContentSize().width
			end

			local selectImage = actionNode:getChildByName("selectImage")
			local weak = actionNode:getChildByName("weak")
			local weakTop = actionNode:getChildByName("weakTop")
			local bg1 = actionNode:getChildByName("bg")
			local bg2 = actionNode:getChildByName("bg1")
			local occupationName, occupationImg = GameStyle:getHeroOccupation(heroData.type)

			occupation:loadTexture(occupationImg)
			cost:setString(heroData.cost)
			bg2:loadTexture(GameStyle:getHeroRarityBg(heroData.rareity)[2])
			weak:removeAllChildren()
			weakTop:removeAllChildren()
			bg1:removeAllChildren()
			bg2:removeAllChildren()

			if kHeroRarityBgAnim[heroData.rareity] and heroData.showType ~= HeroShowType.kNotOwn then
				local anim = cc.MovieClip:create(kHeroRarityBgAnim[heroData.rareity])

				anim:addTo(bg1):center(bg1:getContentSize())

				if heroData.rareity <= 14 then
					anim:offset(-1, -30)
				else
					anim:offset(-3, 0)
				end

				if heroData.rareity >= 14 then
					local anim = cc.MovieClip:create("ssrlizichai_yingxiongxuanze")

					anim:addTo(bg2):center(bg2:getContentSize()):offset(5, -20)
				end
			else
				local sprite = ccui.ImageView:create(GameStyle:getHeroRarityBg(heroData.rareity)[1])

				sprite:addTo(bg1):center(bg1:getContentSize())
			end

			if heroData.awakenLevel > 0 then
				local anim = cc.MovieClip:create(kHeroWeakemAnim)

				anim:addTo(weak):center(weak:getContentSize())
				anim:setScale(2)
				anim:offset(-5, 18)

				anim = cc.MovieClip:create(kHeroWeakemShangAnim)

				anim:addTo(weakTop):center(weakTop:getContentSize())
				anim:setScale(2)
				anim:offset(-5, 18)
			end

			name:setString(heroData.name)
			GameStyle:setHeroNameByQuality(name, heroData.quality)
			GameStyle:setHeroNameByQuality(qualityLevel, heroData.quality)
			name:disableEffect(1)
			qualityLevel:disableEffect(1)
			starBg:removeAllChildren()

			local offsetX = (HeroStarCountMax - heroData.maxStar) * self._starBgWidth / 14

			for i = 1, heroData.maxStar do
				local path, zOrder

				if i <= heroData.star then
					path = "img_yinghun_img_star_full.png"
					zOrder = 105
				elseif i == heroData.star + 1 and heroData.littleStar then
					path = "img_yinghun_img_star_half.png"
					zOrder = 100
				else
					path = "img_yinghun_img_star_empty.png"
					zOrder = 99
				end

				if heroData.awakenLevel > 0 then
					path = "jx_img_star.png"
					zOrder = 100
				end

				if i <= heroData.identityAwakenLevel then
					path = "yinghun_img_awake_star.png"
					zOrder = 100
				end

				local star = cc.Sprite:createWithSpriteFrameName(path)

				star:addTo(starBg)
				star:setGlobalZOrder(zOrder)
				star:setPosition(cc.p(offsetX + i / 7 * self._starBgWidth, 22))
				star:setScale(0.4)
			end

			bg2:removeChildByName("OnTeamMark")
			actionNode:removeChildByName("ProgressMark")

			local brightNess = heroData.showType == HeroShowType.kNotOwn and -75 or 0
			local saturation = heroData.showType == HeroShowType.kNotOwn and -80 or 0

			heroPanel:setBrightness(brightNess)
			heroPanel:setSaturation(saturation)
			bg1:setBrightness(brightNess)
			bg1:setSaturation(saturation)
			bg2:setBrightness(brightNess)
			bg2:setSaturation(saturation)
			rarityBg:setBrightness(brightNess)
			rarityBg:setSaturation(saturation)
			costBg:setBrightness(brightNess)
			costBg:setSaturation(saturation)
			cost:setBrightness(brightNess)
			cost:setSaturation(saturation)
			starBg:setBrightness(brightNess)
			starBg:setSaturation(saturation)
			occupationBg:setBrightness(brightNess)
			occupationBg:setSaturation(saturation)

			local redPoint = actionNode:getChildByFullName("RedPoint")

			if redPoint then
				redPoint:setVisible(false)
			end

			if heroData.showType == HeroShowType.kHas then
				level:setVisible(true)
				levelImage:setVisible(true)

				local hasRedPoint = self._heroSystem:hasRedPointInStrengthen(heroData.id)

				if hasRedPoint then
					if not redPoint then
						redPoint = cc.Sprite:createWithSpriteFrameName(IconFactory.redPointPath)

						redPoint:addTo(actionNode):posite(139, 191)
						redPoint:setName("RedPoint")
						redPoint:setGlobalZOrder(201)
					end

					redPoint:setVisible(true)
				end

				level:setString(Strings:get("Strenghten_Text78", {
					level = heroData.level
				}))

				local levelImageWidth = levelImage:getContentSize().width
				local levelWidth = level:getContentSize().width

				levelImage:setScaleX((levelWidth + 20) / levelImageWidth)
				qualityLevel:setString(heroData.qualityLevel == 0 and "" or " +" .. heroData.qualityLevel)

				if self:isOnTeam(heroData.id) then
					self:createOnTeamPanel(bg2)
				end
			else
				local hasNum = self._heroSystem:getHeroDebrisCount(heroData.id)
				local heroPrototype = PrototypeFactory:getInstance():getHeroPrototype(heroData.id)
				local needNum = heroPrototype:getStarNumByCompose()

				qualityLevel:setString("")
				self:showDebrisProgress(actionNode, hasNum, needNum)
			end

			name:setPositionX(0)
			qualityLevel:setPositionX(name:getContentSize().width)
			namePanel:setContentSize(cc.size(name:getContentSize().width + qualityLevel:getContentSize().width, 30))

			local nameWidth = name:getContentSize().width + qualityLevel:getContentSize().width
			local w = math.max(104, nameWidth + 25)

			nameBg:setContentSize(cc.size(w, nameBg:getContentSize().height))
			nameBg:setPositionX(namePanel:getPositionX())
			heroIcon:setVisible(true)

			if heroData.id == self._chooseHeroId then
				self._selectImage:setVisible(true)
				self._selectImage:removeFromParent(false)
				self._selectImage:addTo(selectImage):center(selectImage:getContentSize())
			end

			heroIcon:setScale(1)
			heroIcon:setSwallowTouches(false)
			heroIcon:addTouchEventListener(function(sender, eventType)
				self:onClickHeroIcon(sender, eventType, heroData)
			end)
		end
	end
end

function HeroShowListMediator:showDebrisProgress(parent, hasNum, needNum)
	local baseNode = cc.GroupedNode:create()

	baseNode:setName("ProgressMark")
	baseNode:addTo(parent)
	baseNode:setGlobalZOrder(300)

	local panel = self._progressPanel:clone()

	panel:setVisible(true)
	panel:addTo(baseNode):posite(91, 54)

	local activeImg = panel:getChildByName("activeImg")
	local debrisLabel = panel:getChildByName("label")
	local numBg = panel:getChildByName("numBg")

	if needNum <= hasNum then
		activeImg:setVisible(true)
		numBg:removeFromParent()
		debrisLabel:removeFromParent()
		activeImg:removeAllChildren()

		local anim = cc.MovieClip:create("dh_zhaohuantishi")

		anim:addEndCallback(function()
			anim:stop()
		end)
		anim:addTo(activeImg):posite(23, -15)
	else
		activeImg:setVisible(false)
		numBg:setVisible(true)
		debrisLabel:setVisible(true)
		debrisLabel:setString(hasNum .. "/" .. needNum)

		local numBgWidth = numBg:getContentSize().width
		local width = debrisLabel:getContentSize().width

		numBg:setScaleX((width + 20) / numBgWidth)
	end
end

function HeroShowListMediator:isOnTeam(id)
	return not not self._teamHeroes[id]
end

function HeroShowListMediator:createOnTeamPanel(parent)
	local image = cc.Sprite:create("asset/common/yh_bd_yszd.png")

	image:addTo(parent):posite(116, 168)
	image:setName("OnTeamMark")

	local text = ccui.Text:create(Strings:get("heroshow_UI29"), TTF_FONT_FZYH_M, 16)

	GameStyle:setCommonOutlineEffect(text, 255)
	text:addTo(image):posite(72, 20)
	text:setOpacity(204)
end

function HeroShowListMediator:initHeroInfo()
	local heroInfo = self._heroSystem:getHeroInfoById(self._chooseHeroId)
	local name = self._heroNode:getChildByFullName("nameBg.name")

	GameStyle:setHeroNameByQuality(name, heroInfo.quality)
	name:disableEffect(1)

	local nameString = heroInfo.name

	name:setString(nameString)

	local rarity = self._heroNode:getChildByFullName("nameBg.rarity")

	rarity:loadTexture(GameStyle:getHeroRarityImage(heroInfo.rareity), 1)

	local occupation = self._heroNode:getChildByFullName("nameBg.occupation")
	local occupationName, occupationImg = GameStyle:getHeroOccupation(heroInfo.type)

	occupation:loadTexture(occupationImg)

	local combat = self._heroNode:getChildByFullName("nameBg.combat")

	self._unownPanel:setVisible(false)
	self._strengthenNode:setVisible(false)

	local roleModel = heroInfo.roleModel

	if heroInfo.showType == HeroShowType.kHas then
		self._buttonTip:setVisible(true)

		local unlock = self._systemKeeper:isUnlock("Hero_Equip")

		self._strengthenNode:setVisible(unlock)
		combat:setVisible(true)
		combat:getChildByFullName("text"):setString(heroInfo.combat)
	elseif heroInfo.showType == HeroShowType.kNotOwn then
		self._buttonTip:setVisible(false)
		self._unownPanel:setVisible(true)
		combat:setVisible(false)

		local loadingBar = self._unownPanel:getChildByFullName("leftPanel.loadingBg.loadingBar")
		local progress = self._unownPanel:getChildByFullName("leftPanel.loadingBg.progress")
		local heroPrototype = PrototypeFactory:getInstance():getHeroPrototype(self._chooseHeroId)
		local hasNum = self._heroSystem:getHeroDebrisCount(self._chooseHeroId)
		local needNum = 0

		needNum = heroPrototype:getStarNumByCompose()

		loadingBar:setPercent(hasNum / needNum * 100)
		progress:setString(hasNum .. "/" .. needNum)
	end

	local length = utf8.len(nameString)

	if length > 12 then
		name:setFontSize(26)
	else
		name:setFontSize(30)
	end

	local Image_bg = self._heroNode:getChildByFullName("nameBg.Image_bg")
	local size = name:getVirtualRendererSize()

	if length >= 5 and size.width > 190 then
		name:setPositionX(70 - size.width + 190)
		occupation:setPositionX(name:getPositionX() - 20)
		Image_bg:setContentSize(cc.size(size.width + 80, Image_bg:getContentSize().height))
	else
		name:setPositionX(70)
		occupation:setPositionX(50)
		Image_bg:setContentSize(cc.size(267, Image_bg:getContentSize().height))
	end

	if self._showHeroAnim then
		local heroIcon = self._main:getChildByFullName("heroIcon")

		heroIcon:getChildByName("HeroAnim"):gotoAndPlay(0)

		local iconNode = heroIcon:getChildByName("HeroAnim"):getChildByName("heroIcon")

		iconNode:removeAllChildren()

		local img, path, spineani, picInfo = IconFactory:createRoleIconSpriteNew({
			useAnim = true,
			frameId = "bustframe9",
			id = roleModel
		})

		img:addTo(iconNode)
		img:setPosition(cc.p(55, -143))

		self._heroAnim = img
		self._heroPicInfo = picInfo

		self:refreshBg()
	end

	local redPoint = self._buttonTip:getChildByFullName("RedPoint")

	if not redPoint then
		redPoint = ccui.ImageView:create(IconFactory.redPointPath, 1)

		redPoint:addTo(self._buttonTip):posite(0, 55)
		redPoint:setName("RedPoint")
	end

	local surfaceSystem = self:getInjector():getInstance(SurfaceSystem)
	local isRed = surfaceSystem:getRedPointByHeroId(self._chooseHeroId)

	redPoint:setVisible(isRed)
end

function HeroShowListMediator:refreshView()
	self:updateData()
	self:resetSelectImg()

	local offsetY = self._heroView:getContentOffset().y
	local innerSizeHeight1 = self._heroView:minContainerOffset().y

	self._heroView:reloadData()

	local innerSizeHeight2 = self._heroView:minContainerOffset().y

	if innerSizeHeight2 == innerSizeHeight1 or innerSizeHeight2 < innerSizeHeight1 and offsetY == 0 then
		self._heroView:setContentOffset(cc.p(0, offsetY))
	else
		self._heroView:setContentOffset(cc.p(0, offsetY + (innerSizeHeight2 - innerSizeHeight1)))
	end

	self:initHeroInfo()
	self:refreshEquip()
end

function HeroShowListMediator:refreshEquip()
	local hero = self._heroSystem:getHeroById(self._chooseHeroId)

	if not hero then
		return
	end

	local hasRed = true
	local teamHeroes = self._heroSystem:getTeamHeroes()

	if not teamHeroes[self._chooseHeroId] then
		hasRed = false
	end

	hasRed = hasRed and self._heroSystem:hasRedPointByEquip(self._chooseHeroId)

	self._strengthenNode:getChildByFullName("redPoint"):setVisible(hasRed)

	for index = 1, #EquipPositionToType do
		local bg = self._strengthenNode:getChildByFullName("bg" .. index)
		local image = self._strengthenNode:getChildByFullName("equip" .. index)
		local equipType = EquipPositionToType[index]
		local equipId = hero:getEquipIdByType(equipType)
		local hasEquip = not not equipId

		bg:setVisible(hasEquip)

		if hasEquip then
			if not (kEquipTypeToImage[equipType] .. "_yizhuangbei.png") then
				local equipIcon = kEquipTypeToImage[equipType] .. ".png"

				image:loadTexture(equipIcon, 1)
			end
		end
	end
end

function HeroShowListMediator:refreshByClick()
	self:initHeroInfo()
	self:refreshEquip()
end

function HeroShowListMediator:refreshSortView()
	self:updateData()
	self:resetSelectImg()

	local offsetY = self._heroView:getContentOffset().y

	self._heroView:reloadData()
	self._heroView:setContentOffset(cc.p(0, offsetY))
end

function HeroShowListMediator:resetSelectImg()
	self._selectImage:setVisible(false)
	self._selectImage:removeFromParent(false)
	self._selectImage:addTo(self:getView())
end

local sortEnum = {
	1,
	7,
	2,
	3
}

function HeroShowListMediator:createSortView()
	if self._main:getChildByFullName("SortPanel") then
		return
	end

	local sortType = self._stageSystem:getSortType()

	local function callBack(data)
		self._sortType:setString(data.sortStr)
		self._stageSystem:setSortType(sortEnum[data.sortType])

		self._subSortType = data.subSortType

		self:refreshSortView()
	end

	self._sortComponent = SortHeroListNewComponent:new({
		isHide = false,
		sortType = sortType,
		mediator = self,
		callBack = callBack
	})

	local sortStr = self._stageSystem:getSortTypeStr(sortType)

	self._sortType:setString(sortStr)
	self._sortComponent:getRootNode():setVisible(false)
	self._sortComponent:getRootNode():addTo(self._main):posite(400, 148)
	self._sortComponent:getRootNode():setName("SortPanel")
end

function HeroShowListMediator:onClickHeroIcon(sender, eventType, heroData)
	if eventType == ccui.TouchEventType.began then
		if self._clickCD then
			return
		end

		self._isReturn = true

		local scaleTo1 = cc.ScaleTo:create(0.13, 0.9)

		sender:runAction(scaleTo1)
	elseif eventType == ccui.TouchEventType.ended then
		if self._isReturn then
			if self._clickCD then
				return
			end

			performWithDelay(self:getView(), function()
				self._clickCD = false
			end, 0.18)

			self._clickCD = true

			AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)
			self._touchLayer:setVisible(true)
			sender:stopAllActions()
			sender:setScale(0.9)

			local scaleTo2 = cc.ScaleTo:create(0.05, 1)
			local callfunc = cc.CallFunc:create(function()
				if heroData.showType == HeroShowType.kCanComp then
					local config = PrototypeFactory:getInstance():getHeroPrototype(heroData.id):getConfig()

					local function callBack(data)
						local view = self:getInjector():getInstance("newHeroView")

						self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
							ignoreNewRed = true,
							heroId = data.id
						}))
					end

					self._bagSystem:requestHeroCompose(config.ItemId, callBack)

					self._chooseHeroId = heroData.id
				elseif heroData.showType == HeroShowType.kHas then
					if self._chooseHeroId == heroData.id then
						self:runEndAnim()
					else
						self._chooseHeroId = heroData.id

						local selectImage = sender:getChildByFullName("actionNode.selectImage")

						self._selectImage:setVisible(true)
						self._selectImage:removeFromParent(false)
						self._selectImage:addTo(selectImage):center(selectImage:getContentSize())
						self:refreshByClick()
					end
				elseif heroData.showType == HeroShowType.kNotOwn then
					self._chooseHeroId = heroData.id

					local selectImage = sender:getChildByFullName("actionNode.selectImage")

					self._selectImage:setVisible(true)
					self._selectImage:removeFromParent(false)
					self._selectImage:addTo(selectImage):center(selectImage:getContentSize())
					self:refreshByClick()
				end

				self._touchLayer:setVisible(false)
			end)
			local seq = cc.Sequence:create(scaleTo2, callfunc)

			sender:runAction(seq)

			self._isReturn = true
		else
			sender:stopAllActions()
			sender:setScale(1)
		end
	elseif eventType == ccui.TouchEventType.canceled then
		sender:stopAllActions()
		sender:setScale(1)
	end
end

function HeroShowListMediator:onClickSort()
	self:createSortView()
	self._stageSystem:setSortExtand(0)
	self._sortComponent:getRootNode():setVisible(true)
	self._sortComponent:refreshView()
	self:refreshSortView()
end

function HeroShowListMediator:onClickStrength()
	if not self._heroSystem:getHeroById(self._chooseHeroId) then
		self:dispatch(ShowTipEvent({
			tip = "Error_10101"
		}))

		return
	end

	if self._clickCD then
		return
	end

	self._clickCD = true

	performWithDelay(self:getView(), function()
		self._clickCD = false
	end, 0.18)
	self:runEndAnim()
end

function HeroShowListMediator:onClickEquip()
	self._heroSystem:tryEnterShowMain({
		tabType = 5,
		id = self._chooseHeroId
	})
end

function HeroShowListMediator:onClickDetail()
	local view = self:getInjector():getInstance("HeroShowNotOwnView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		showType = 1,
		id = self._chooseHeroId
	}))
end

function HeroShowListMediator:onClickBack()
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)

	storyDirector:notifyWaiting("exit_heroShowList_view")
	self._main:stopAllActions()

	local heroPanel = self._main:getChildByFullName("heroIcon")

	heroPanel:stopAllActions()
	self:dismissWithOptions({
		transition = ViewTransitionFactory:create(ViewTransitionType.kCommonAreaView)
	})
end

function HeroShowListMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()
	local scriptName = guideAgent:getCurrentScriptName()
	local heroIcon, heroData
	local guideHeroId = "ZTXChang"

	if guideAgent:isGuiding() then
		local heroIndex = 0

		for k in pairs(self._showList) do
			local data = self._showList[k]
			local id = data.id

			if id == guideHeroId then
				heroIndex = k
				heroData = data

				break
			end
		end

		if heroIndex > 0 and heroData then
			local x = (heroIndex - 1) % kNum + 1
			local y = math.ceil(heroIndex / kNum) - 1
			local offset = self._heroView:getContentOffset()

			offset.y = offset.y + y * 231

			self._heroView:setContentOffset(offset)

			local cellBar = self._heroView:cellAtIndex(y)

			if cellBar then
				local panelBase = cellBar:getChildByTag(99999)

				if panelBase and panelBase:getChildByTag(x) then
					heroIcon = panelBase:getChildByTag(x)
					self._isReturn = true
					self._chooseHeroId = ""

					self:onClickHeroIcon(heroIcon, ccui.TouchEventType.began, heroData)
					self:onClickHeroIcon(heroIcon, ccui.TouchEventType.ended, heroData)
				end
			end
		end
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local heroNode = self._main:getChildByFullName("heroIcon")

		storyDirector:setClickEnv("heroShowList.heroNode", heroNode, function(sender, eventType)
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

			self._chooseHeroId = guideHeroId

			self:onClickStrength()
		end)

		local btnBack = self:getView():getChildByFullName("topinfo_node.back_btn")

		storyDirector:setClickEnv("heroShowList.btnBack", btnBack, function(sender, eventType)
			self:onClickBack()
		end)
		storyDirector:notifyWaiting("enter_heroShowList_view")
	end))

	self:getView():runAction(sequence)
end

function HeroShowListMediator:runResumeAnim()
	self:refreshBg()
	self._heroView:stopScroll()
	self._touchLayer:setVisible(true)
	self._main:stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/HeroListMain.csb")

	self._main:runAction(action)
	action:clearFrameEventCallFunc()
	action:gotoFrameAndPause(40)

	local heroPanel = self._main:getChildByFullName("heroIcon")

	heroPanel:stopAllActions()
	heroPanel:setPosition(cc.p(544, 320))

	local heroAnim = heroPanel:getChildByName("HeroAnim")

	if not heroAnim then
		heroAnim = cc.MovieClip:create("renwu_yingling")

		heroAnim:addTo(heroPanel)
		heroAnim:setName("HeroAnim")
		heroAnim:addCallbackAtFrame(25, function()
			heroAnim:stop()
		end)
		heroAnim:gotoAndPlay(0)
		heroAnim:setPlaySpeed(0.7)
	end

	heroAnim:gotoAndStop(25)

	local iconNode = heroAnim:getChildByName("heroIcon")

	iconNode:removeAllChildren()

	local roleModel = IconFactory:getRoleModelByKey("HeroBase", self._chooseHeroId)
	local hero = self._heroSystem:getHeroById(self._chooseHeroId)
	local img, path, spineani, picInfo = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = (hero or nil) and hero:getModel()
	})

	img:setScale(1.15)
	img:addTo(iconNode)
	img:setPosition(cc.p(55, -143))

	self._heroAnim = img
	self._heroPicInfo = picInfo

	local moveto1 = cc.MoveTo:create(0.2, cc.p(898, 298))
	local callFunc = cc.CallFunc:create(function()
		if DisposableObject:isDisposed(self) or tolua.isnull(action) then
			return
		end

		action:gotoFrameAndPlay(0, 25, false)
	end)
	local seq = cc.Sequence:create(moveto1, callFunc)

	heroPanel:runAction(seq)

	local cells = self:getShowCells()

	local function onFrameEvent(frame)
		if frame == nil then
			return
		end

		local str = frame:getEvent()

		if str == "IconAnim1" then
			self:showStartAction(cells, 1)
		end

		if str == "IconAnim2" then
			self:showStartAction(cells, 2)
		end

		if str == "IconAnim3" then
			self:showStartAction(cells, 3)
		end

		if str == "IconAnim4" then
			self:showStartAction(cells, 4)
		end

		if str == "IconAnim5" then
			self:showStartAction(cells, 5)
		end

		if str == "HeroAnim" then
			-- block empty
		end

		if str == "EndAnim" then
			self._touchLayer:setVisible(false)

			self._showHeroAnim = true

			self:setupClickEnvs()
		end
	end

	action:setFrameEventCallFunc(onFrameEvent)
end

function HeroShowListMediator:runStartAnim()
	self:refreshBg()
	self._touchLayer:setVisible(true)
	self._main:stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/HeroListMain.csb")

	self._main:runAction(action)
	action:clearFrameEventCallFunc()

	local cells = {}

	self._heroView:reloadData()

	cells = self:getShowCells()

	local heroPanel = self._main:getChildByFullName("heroIcon")

	heroPanel:stopAllActions()
	heroPanel:removeChildByName("HeroAnim")
	heroPanel:setPosition(cc.p(898, 298))
	performWithDelay(heroPanel, function()
		action:gotoFrameAndPlay(0, 25, false)
	end, 1e-06)

	local function onFrameEvent(frame)
		if frame == nil then
			return
		end

		local str = frame:getEvent()

		if str == "ReloadData" then
			-- block empty
		end

		if str == "IconAnim1" then
			self:showStartAction(cells, 1)
		end

		if str == "IconAnim2" then
			self:showStartAction(cells, 2)
		end

		if str == "IconAnim3" then
			self:showStartAction(cells, 3)
		end

		if str == "IconAnim4" then
			self:showStartAction(cells, 4)
		end

		if str == "IconAnim5" then
			self:showStartAction(cells, 5)
		end

		if str == "HeroAnim" then
			local heroAnim = cc.MovieClip:create("renwu_yingling")

			heroAnim:addTo(heroPanel)
			heroAnim:setName("HeroAnim")
			heroAnim:addCallbackAtFrame(25, function()
				heroAnim:stop()
			end)
			heroAnim:gotoAndPlay(0)
			heroAnim:setPlaySpeed(0.7)

			local iconNode = heroAnim:getChildByName("heroIcon")

			iconNode:removeAllChildren()

			local roleModel = IconFactory:getRoleModelByKey("HeroBase", self._chooseHeroId)
			local hero = self._heroSystem:getHeroById(self._chooseHeroId)
			local img, path, spineani, picInfo = IconFactory:createRoleIconSpriteNew({
				useAnim = true,
				frameId = "bustframe9",
				id = (hero or nil) and hero:getModel()
			})

			img:setScale(1.15)
			img:addTo(iconNode)
			img:setPosition(cc.p(55, -143))

			self._heroAnim = img
			self._heroPicInfo = picInfo
		end

		if str == "EndAnim" then
			self._touchLayer:setVisible(false)

			self._showHeroAnim = true

			self:setupClickEnvs()
		end
	end

	action:setFrameEventCallFunc(onFrameEvent)
end

function HeroShowListMediator:showStartAction(cells, cellIndex)
	if not cells or not cellIndex then
		return
	end

	local cell = cells[cellIndex]

	if cell then
		local delayTime = 0.06666666666666667
		local layoutPanel = cell:getChildByTag(self._kLayerTag)

		for i = 1, kNum do
			local index = kNum - i + 1
			local cloneNode = layoutPanel:getChildByTag(index)

			if cloneNode then
				local delayAction = cc.DelayTime:create((i - 1) * delayTime)
				local callfunc1 = cc.CallFunc:create(function()
					if cloneNode.id then
						cloneNode:setVisible(true)
					end
				end)
				local callfunc2 = cc.CallFunc:create(function()
					CommonUtils.runActionEffect(cloneNode:getChildByName("actionNode"), "Node_1.actionNode", "HeroListEffect", "anim1", false)
				end)
				local seq = cc.Sequence:create(delayAction, callfunc1, callfunc2)

				self:getView():runAction(seq)
			end
		end
	end
end

function HeroShowListMediator:getShowCells()
	local children = self._heroView:getContainer():getChildren()
	local cells = {}

	for index = 1, #children do
		local cell = children[index]

		if cell then
			cells[#cells + 1] = cell

			local layoutPanel = cell:getChildByTag(self._kLayerTag)

			for i = 1, kNum do
				local cloneNode = layoutPanel:getChildByTag(i)

				if cloneNode then
					cloneNode:setVisible(false)
				end
			end
		end
	end

	return cells
end

function HeroShowListMediator:runEndAnim()
	self._heroView:stopScroll()
	self._touchLayer:setVisible(true)
	self._main:stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/HeroListMain.csb")

	self._main:runAction(action)
	action:gotoFrameAndPlay(25, 45, false)

	local transition = {}
	local tempFunc

	function transition:runTransitionAnimation(topNode, coverNode, endCallFunc)
		tempFunc = endCallFunc
	end

	self._heroSystem:setUiSelectHeroId(self._chooseHeroId)

	local param = {
		ignoreInit = true,
		id = self._chooseHeroId
	}
	local view = self:getInjector():getInstance("HeroShowMainView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, {
		transition = transition
	}, param))

	param.ignoreInit = false

	view:setVisible(false)

	local cells = self:getEndShowCells()

	local function onFrameEvent(frame)
		if frame == nil then
			return
		end

		local str = frame:getEvent()

		if str == "IconAnim1" then
			self:showEndAction(cells, 1)
			self:showEndAction(cells, 2)
		end

		if str == "IconAnim2" then
			self:showEndAction(cells, 3)
			self:showEndAction(cells, 4)
		end

		if str == "IconAnim3" then
			self:showEndAction(cells, 5)
		end

		if str == "IconAnim4" then
			local heroPanel = self._main:getChildByFullName("heroIcon")

			heroPanel:setPosition(cc.p(898, 298))

			local moveto = cc.MoveTo:create(0.2, cc.p(500, 315))

			heroPanel:runAction(moveto)
		end

		if str == "EndAnim1" then
			local scene = cc.Director:getInstance():getRunningScene()

			self._heroAnim:setVisible(false)
			self._bgAnim:setVisible(false)
			self._heroAnim:changeParent(scene)
			self._bgAnim:changeParent(scene)
			self._heroSystem:setHeroAnim(self._heroAnim)
			self._heroSystem:setHeroBgAnim(self._bgAnim)
			self._heroSystem:setHeroPicInfo(self._heroPicInfo)
			view:setVisible(true)

			local mediator = self:getMediatorMap():retrieveMediator(view)

			if mediator then
				mediator:initByController()
			end

			self._touchLayer:setVisible(false)
			tempFunc()
		end
	end

	action:setFrameEventCallFunc(onFrameEvent)
end

function HeroShowListMediator:showEndAction(cells, index)
	if not cells or not index then
		return
	end

	local cell = cells[index]

	if cell then
		local layoutPanel = cell:getChildByTag(self._kLayerTag)

		for i = 1, kNum do
			local cloneNode = layoutPanel:getChildByTag(i)

			if cloneNode then
				local callFunc = cc.CallFunc:create(function()
					CommonUtils.runActionEffect(cloneNode:getChildByName("actionNode"), "Node_1.actionNode", "HeroListEffect", "anim2", false)
				end)

				self:getView():runAction(callFunc)
			end
		end
	end
end

function HeroShowListMediator:getEndShowCells()
	local children = self._heroView:getContainer():getChildren()
	local cells = {}

	for index = 1, #children do
		local cell = children[index]

		if cell then
			cells[#cells + 1] = cell
		end
	end

	return cells
end
