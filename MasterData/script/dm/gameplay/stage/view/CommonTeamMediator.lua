-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/CommonTeamMediator.lua

CommonTeamMediator = class("CommonTeamMediator", DmAreaViewMediator, _M)

CommonTeamMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
CommonTeamMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
CommonTeamMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
CommonTeamMediator:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")

local costType = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Init_Cost_Type", "content")
local kHeroRarityBgAnim = {
	[15] = "spzong_urequipeff",
	[13] = "srzong_yingxiongxuanze",
	[14] = "ssrzong_yingxiongxuanze"
}
local kSortBtnHandlers = {
	["main.my_pet_bg.sortPanel.sortBtn"] = {
		clickAudio = "Se_Click_Fold_1",
		func = "onClickSort"
	},
	["main.my_pet_bg.sortPanel.screenBtn"] = {
		clickAudio = "Se_Click_Fold_1",
		func = "onClickScreen"
	},
	["main.my_pet_bg.sortPanel.setBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickTeamSetBtn"
	}
}

function CommonTeamMediator:initialize()
	super.initialize(self)
end

function CommonTeamMediator:dispose()
	if self._specialSound then
		AudioEngine:getInstance():stopEffect(self._specialSound)
	end

	super.dispose(self)
end

function CommonTeamMediator:onRegister()
	self:mapButtonHandlersClick(kSortBtnHandlers)

	self._presetTeamPetNum = 0
	self._masterSystem = self._developSystem:getMasterSystem()

	local setButton = self:getView():getChildByFullName("main.my_pet_bg.sortPanel.setBtn")

	setButton:setVisible(false)
end

function CommonTeamMediator:resumeWithData()
	local preMaxTeamPetNum = self._maxTeamPetNum

	self._maxTeamPetNum = self._stageSystem:getPlayerInit() + self._developSystem:getBuildingCardEffValue()
	self._maxTeamPetNum = self._maxTeamPetNum - self._presetTeamPetNum

	self:initLockIcons(preMaxTeamPetNum)
end

function CommonTeamMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("Hero_Group")
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
		title = Strings:get("Stage_Team_UI5")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
	self:setLeadStageInfo()
end

function CommonTeamMediator:setLeadStageInfo()
	local node = self:getView():getChildByFullName("main.bg.node_leadStage")

	if not node then
		return
	end

	node:removeAllChildren()

	local id, lv = self._masterSystem:getMasterLeadStatgeLevel(self._curMasterId)

	if not id then
		return
	end

	local icon = IconFactory:createLeadStageIconHor(id, lv)

	if icon then
		icon:addTo(node)
	end
end

function CommonTeamMediator:leaveWithData()
	self:onClickBack()
end

function CommonTeamMediator:updateTopInfoTitle(title)
	self._topInfoWidget:updateTitle(title)
end

function CommonTeamMediator:setLabelEffect()
	return
end

function CommonTeamMediator:initView()
	local function scrollViewDidScroll(view)
		self._isReturn = false
	end

	local function cellSizeForTable(table, idx)
		if idx + 1 == 1 then
			return self._petSize.width - 40, self._petSize.height
		end

		return self._petSize.width, self._petSize.height
	end

	local function numberOfCellsInTableView(table)
		return #self._petListAll + 1
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local node = self._myPetClone:clone()

			node:setVisible(true)
			cell:addChild(node)
			node:setAnchorPoint(cc.p(0, 0))
			node:setPosition(cc.p(0, 0))
			node:setTag(12138)
		end

		self:createTeamCell(cell, idx + 1)

		return cell
	end

	local tableView = cc.TableView:create(self._heroPanel:getContentSize())

	tableView:setTag(1234)

	self._teamView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	tableView:setMaxBounceOffset(20)
	self._heroPanel:addChild(tableView, 1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)

	self._bgImg = self:getView():getChildByFullName("main.bgImg")

	self._bgImg:loadTexture("asset/scene/bd_bg_bj.jpg", ccui.TextureResType.localType)
end

function CommonTeamMediator:initLockIcons(preMaxTeamPetNum)
	preMaxTeamPetNum = preMaxTeamPetNum or self._maxTeamPetNum

	local lockDesc = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Init_DeckNum_Desc", "content")
	local lockCondition = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Init_DeckNum_Condition", "content")
	local lockBuildIdCondition = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Init_DeckNum_Building", "content")
	local maxShowNum = 10
	local initAnim = false

	if preMaxTeamPetNum < self._maxTeamPetNum then
		for i = preMaxTeamPetNum + 1, maxShowNum do
			local iconBg = self._teamBg:getChildByName("pet_" .. i)

			iconBg:removeAllChildren()

			local emptyIcon = GameStyle:createEmptyIcon(true)

			emptyIcon:addTo(iconBg):center(iconBg:getContentSize())
		end
	end

	for i = self._maxTeamPetNum + 1 + self._presetTeamPetNum, maxShowNum do
		local condition, buildId
		local type, showAnim, unlockLevel, conditions = "", false, 0, {}
		local unlock, tips = self._buildingSystem:checkEnabled()

		if lockCondition[i] ~= "" then
			condition = lockCondition[i]
			type, showAnim, unlockLevel, conditions = self._buildingSystem:checkByBuildLv(lockCondition[i], lockBuildIdCondition[i])
		end

		local lockTip = Strings:get(lockDesc[i])

		if type ~= "" and not showAnim then
			lockTip = self:getLockTip(conditions)
		elseif not unlock then
			local conditionsTemp = ConfigReader:getDataByNameIdAndKey("UnlockSystem", "Village_Building", "Condition")

			lockTip = self:getLockTip(conditionsTemp)
		end

		local iconBg = self._teamBg:getChildByName("pet_" .. i)

		iconBg:removeAllChildren()

		local emptyIcon = GameStyle:createEmptyIcon(true)

		emptyIcon:addTo(iconBg):center(iconBg:getContentSize())

		local tipLabel = emptyIcon:getChildByName("TipText")

		tipLabel:setString(lockTip)

		local width, height = iconBg:getContentSize().width, iconBg:getContentSize().height
		local widget = ccui.Widget:create()

		widget:setContentSize(cc.size(width, height))
		widget:setTouchEnabled(lockCondition[i] == "" or showAnim)
		widget:addClickEventListener(function()
			self:onClickUnlockDeck(showAnim, type, unlockLevel)
		end)
		widget:addTo(iconBg):center(iconBg:getContentSize())

		if showAnim and not initAnim then
			local anim = cc.MovieClip:create("texiao_bianduijihuo")

			anim:addTo(iconBg):posite(width / 2, 11)
			anim:addEndCallback(function()
				anim:stop()
			end)

			initAnim = true
		elseif not showAnim and condition then
			local lockImg = ccui.ImageView:create("suo_icon_s_battle.png", 1)

			lockImg:addTo(iconBg):posite(width - 7, height - 6)
		end
	end
end

function CommonTeamMediator:getLockTip(conditions)
	if conditions.Block or conditions.STAGE then
		if not conditions.Block then
			do
				local pointId = conditions.STAGE
				local openState, str = self._systemKeeper:checkStagePointLock(pointId)

				if not openState then
					return Strings:get("Team_BuildText5", {
						stage = str
					})
				end
			end

			if conditions.Level or conditions.LEVEL then
				local targetLevel = conditions.Level and tonumber(conditions.Level) or tonumber(conditions.LEVEL)
				local player = self._developSystem:getPlayer()
				local level = player:getLevel()

				if level < targetLevel then
					return Strings:get("Team_BuildText4", {
						level = targetLevel
					})
				end
			end
		end
	end
end

function CommonTeamMediator:onClickUnlockDeck(showAnim, type, unlockLevel)
	local unlock, tips = self._buildingSystem:checkEnabled()

	if not unlock then
		local url = ConfigReader:getDataByNameIdAndKey("UnlockSystem", "Village_Building", "Link")

		if url then
			local context = self:getInjector():instantiate(URLContext)
			local entry, params = UrlEntryManage.resolveUrlWithUserData(url)

			if not entry then
				self:dispatch(ShowTipEvent({
					tip = Strings:get("Function_Not_Open")
				}))
			else
				entry:response(context, params)
			end
		end
	else
		self._buildingSystem:tryEnterOverview({
			roomId = "Room5"
		})
	end
end

function CommonTeamMediator:showCostBtn()
	if self._spStageType and costType[self._spStageType] ~= "-1" then
		return false
	end

	return (self._buildingSystem:getCostBuildLvOrBuildSta())
end

function CommonTeamMediator:onClickCost()
	local data = {
		isRich = true,
		title = Strings:get("SHOP_REFRESH_DESC_TEXT1"),
		content = Strings:get("Stage_Team_CostUpTips", {
			fontName = TTF_FONT_FZYH_R
		}),
		sureBtn = {
			text = Strings:get("Stage_Team_Goto"),
			text1 = Strings:get("UITitle_EN_Lijiqianwang")
		}
	}
	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" then
			outSelf._buildingSystem:tryEnter()
		elseif data.response == "cancel" then
			-- block empty
		elseif data.response == "close" then
			-- block empty
		end
	end

	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function CommonTeamMediator:onClickInfo(eventType, fightTip, isDouble)
	local fightInfoTip = fightTip and fightTip or self._fightInfoTip
	local leadConfig = self._masterSystem:getMasterCurLeadStageConfig(self._curMasterId)

	if not leadConfig then
		return
	end

	if eventType == ccui.TouchEventType.began then
		fightInfoTip:removeAllChildren()

		local effectRate = ConfigReader:getDataByNameIdAndKey("ConfigValue", "LeadStage_Effective_Rate", "content")

		if isDouble then
			if not (leadConfig.LeadFightHero * effectRate) then
				local addPer = leadConfig.LeadFightHero
				local config = ConfigReader:getRecordById("MasterBase", self._curMasterId)
				local desc = Strings:get("LeadStage_TeamCombatInfo", {
					fontSize = 20,
					fontName = TTF_FONT_FZYH_M,
					leader = Strings:get(config.Name),
					stage = Strings:get(leadConfig.RomanNum) .. Strings:get(leadConfig.StageName),
					percent = math.ceil(addPer * 100) .. "%"
				})
				local richText = ccui.RichText:createWithXML(desc, {})

				richText:setAnchorPoint(cc.p(0, 0))
				richText:setPosition(cc.p(10, 10))
				richText:addTo(fightInfoTip)
				richText:renderContent(440, 0, true)

				local size = richText:getContentSize()

				fightInfoTip:setContentSize(460, size.height + 20)
				fightInfoTip:setVisible(true)
			end
		end
	elseif eventType == ccui.TouchEventType.moved then
		-- block empty
	elseif eventType == ccui.TouchEventType.canceled then
		fightInfoTip:setVisible(false)
	elseif eventType == ccui.TouchEventType.ended then
		fightInfoTip:setVisible(false)
	end
end

function CommonTeamMediator:initHero(node, info)
	local heroImg = IconFactory:createRoleIconSpriteNew({
		id = info.roleModel
	})

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

	local cost = node:getChildByFullName("costBg.cost")

	cost:setString(info.cost)

	local occupationName, occupationImg = GameStyle:getHeroOccupation(info.type)
	local occupation = node:getChildByName("occupation")

	occupation:loadTexture(occupationImg)

	local levelImage = node:getChildByName("levelImage")
	local level = node:getChildByName("level")

	level:setString(Strings:get("Strenghten_Text78", {
		level = info.level
	}))

	local levelImageWidth = levelImage:getContentSize().width
	local levelWidth = level:getContentSize().width

	levelImage:setScaleX((levelWidth + 20) / levelImageWidth)

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

			if i <= info.identityAwakenLevel then
				path = "yinghun_img_awake_star.png"
			end
		end

		star:ignoreContentAdaptWithSize(true)
		star:setScale(0.4)
		star:loadTexture(path, 1)
	end

	local namePanel = node:getChildByFullName("namePanel")
	local name = namePanel:getChildByName("name")
	local qualityLevel = namePanel:getChildByName("qualityLevel")

	name:setString(info.name)
	qualityLevel:setString(info.qualityLevel == 0 and "" or " +" .. info.qualityLevel)
	name:setPositionX(0)
	qualityLevel:setPositionX(name:getContentSize().width)
	namePanel:setContentSize(cc.size(name:getContentSize().width + qualityLevel:getContentSize().width, 30))
	GameStyle:setHeroNameByQuality(name, info.quality)
	GameStyle:setHeroNameByQuality(qualityLevel, info.quality)

	local nameBg = node:getChildByFullName("nameBg")
	local nameWidth = name:getContentSize().width + qualityLevel:getContentSize().width
	local w = math.max(104, nameWidth + 25)

	nameBg:setContentSize(cc.size(w, nameBg:getContentSize().height))
	nameBg:setPositionX(namePanel:getPositionX())
end

function CommonTeamMediator:initTeamHero(node, info)
	local weak = node:getChildByName("weak")
	local weakTop = node:getChildByName("weak")

	weak:removeAllChildren()
	weakTop:removeAllChildren()

	if info and info.awakenLevel and info.awakenLevel > 0 then
		local anim = cc.MovieClip:create("dikuang_yinghunxuanze")

		anim:addTo(weak):center(weak:getContentSize())
		anim:setScale(2)
		anim:offset(-5, 18)

		anim = cc.MovieClip:create("shangkuang_yinghunxuanze")

		anim:addTo(weakTop):center(weakTop:getContentSize())
		anim:setScale(2)
		anim:offset(-5, 18)
	end
end

function CommonTeamMediator:playInsertEffect(heroId)
	local specialSound = self._heroSystem:getTeamSpecialSound(heroId, self._teamPets)

	self._qipao:setVisible(false)

	if self._specialSound then
		AudioEngine:getInstance():stopEffect(self._specialSound)
	end

	if specialSound then
		local desc = ConfigReader:getDataByNameIdAndKey("Sound", specialSound, "SoundDesc")

		desc = Strings:get(desc)

		if desc ~= "" then
			self._qipao:setVisible(true)

			self._qipao.id = heroId

			local content = self._qipao:getChildByName("content")

			content:getVirtualRenderer():setDimensions(114, 0)
			content:setString(desc)
			self._qipao:setContentSize(cc.size(126, content:getContentSize().height + 24))

			for i = 1, #self._teamPets do
				local node = self._petNodeList[i]

				if node and node.id and node.id == heroId then
					local targetPos = node:getParent():convertToWorldSpace(cc.p(node:getPosition()))

					targetPos = self._qipao:getParent():convertToNodeSpace(targetPos)

					self._qipao:setPosition(cc.p(targetPos.x - 50, targetPos.y + 60))
				end
			end
		end

		self._specialSound = AudioEngine:getInstance():playRoleEffect(specialSound, false, function()
			self._qipao:setVisible(false)
		end)
	else
		self._specialSound = AudioEngine:getInstance():playRoleEffect("Voice_" .. heroId .. "_61", false)
	end
end

function CommonTeamMediator:checkMasterSkillActive()
	self._masterSkillPanel:removeAllChildren()

	self._skillActive = {}

	local skills = self._masterSystem:getMasterLeaderSkillList(self._curMasterId)

	for i = 1, #skills do
		local skill = skills[i]
		local skillId = skill:getId()
		local info = {
			levelHide = true,
			id = skillId,
			skillType = skill:getSkillType()
		}
		local newSkillNode = IconFactory:createMasterSkillIcon(info)

		newSkillNode:setScale(0.36)
		self._masterSkillPanel:addChild(newSkillNode, 2)

		local index = i <= 3 and i or i - 3
		local posX = 20 + (index - 1) * 55
		local posY = i <= 3 and 61 or 10

		newSkillNode:setPosition(cc.p(posX, posY))

		local conditions = skill:getActiveCondition()
		local isActive = self._stageSystem:checkIsKeySkillActive(conditions, self._teamPets, {
			masterId = self._curMasterId
		})

		newSkillNode:setGray(not isActive)

		if isActive then
			self._skillActive[i] = true

			local shangceng = cc.MovieClip:create("shangceng_jinengjihuo")

			shangceng:addTo(newSkillNode)
			shangceng:setPosition(cc.p(46.5, 46.5))
			shangceng:setScale(1.42)
		else
			newSkillNode:setGray(true)

			self._skillActive[i] = false
		end
	end
end

function CommonTeamMediator:checkTouchType(pos1, pos2)
	local xOffset = math.abs(pos1.x - pos2.x)
	local yOffset = math.abs(pos1.y - pos2.y)

	if xOffset > 10 or yOffset > 10 then
		local dragDeg1 = math.deg((math.atan(yOffset / xOffset)))
		local dragDeg2 = math.deg((math.atan(xOffset / yOffset)))

		if dragDeg1 > 30 or dragDeg2 > 30 then
			return true
		end
	end

	return false
end

function CommonTeamMediator:checkCellTouchType(pos1, pos2)
	local xOffset = math.abs(pos1.x - pos2.x)
	local yOffset = math.abs(pos1.y - pos2.y)

	if xOffset > 10 or yOffset > 10 then
		local dragDeg1 = math.deg((math.atan(yOffset / xOffset)))

		if dragDeg1 > 30 then
			return true
		end
	end

	return false
end

function CommonTeamMediator:changeMovingPetPos(pos)
	local movedPos = self._movingPet:getParent():convertToNodeSpace(pos)

	self._movingPet:setPosition(movedPos)
end

function CommonTeamMediator:checkCollision(targetPanel)
	local checkPos = cc.p(self._movingPet:getPositionX(), self._movingPet:getPositionY())

	checkPos = self._movingPet:getParent():convertToWorldSpace(checkPos)
	checkPos = targetPanel:getParent():convertToNodeSpace(checkPos)

	if cc.rectContainsPoint(targetPanel:getBoundingBox(), checkPos) then
		return true
	end

	return false
end

function CommonTeamMediator:cleanMovingPet()
	self._movingPet:removeAllChildren()
	self._movingPet:setPositionX(-500)
end

function CommonTeamMediator:getHeroInfoById(id)
	local heroInfo = self._heroSystem:getHeroById(id)

	if not heroInfo then
		return nil
	end

	return {
		id = heroInfo:getId(),
		level = heroInfo:getLevel(),
		star = heroInfo:getStar(),
		quality = heroInfo:getQuality(),
		rareity = heroInfo:getRarity(),
		qualityLevel = heroInfo:getQualityLevel(),
		name = heroInfo:getName(),
		roleModel = heroInfo:getModel(),
		type = heroInfo:getType(),
		cost = heroInfo:getCost(),
		littleStar = heroInfo:getLittleStar(),
		combat = heroInfo:getCombat(),
		maxStar = heroInfo:getMaxStar(),
		awakenLevel = heroInfo:getAwakenStar(),
		identityAwakenLevel = heroInfo:getIdentityAwakenLevel()
	}
end

function CommonTeamMediator:isSelectCanceledByClick(id)
	if #self._teamPets >= self._maxTeamPetNum then
		if not self._runInsertPetAction and self._isReturn then
			AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Stage_Team_UI7")
			}))
		end

		return true
	end

	return false
end

function CommonTeamMediator:isSelectCanceledByDray(addId, removeId)
	local selectCanceled = false

	if selectCanceled and self._isReturn then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Stage_Team_Overload")
		}))
	end

	return selectCanceled
end

function CommonTeamMediator:checkIsInTeamArea()
	local targetIndex

	for i = 1, self._maxTeamPetNum do
		local iconBg = self._teamBg:getChildByName("pet_" .. i)

		if self:checkCollision(iconBg) then
			targetIndex = i

			break
		end
	end

	return targetIndex
end

function CommonTeamMediator:checkIsInOwnArea()
	local targetId
	local children = self._teamView:getContainer():getChildren()

	for i = 1, #children do
		local node = children[i]:getChildByTag(12138)

		if node and node:getChildByFullName("myPetClone") then
			node = node:getChildByFullName("myPetClone")

			if self:checkCollision(node) then
				targetId = children[i].id

				break
			end
		end
	end

	return targetId
end

function CommonTeamMediator:onClickChangeMaster()
	if not self._showChangeMaster then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		outSelf:setLeadStageInfo()
	end

	local var_39_0 = self:getInjector():getInstance("ChangeMasterView")
	local var_39_1 = {
		masterId = self._curMasterId,
		masterList = self._masterList
	}

	var_39_1.recomandList = self._recomandMasterList or {}
	var_39_1.forbidMasters = self._forbidMasters or {}
	var_39_1.sys = self._masterSystem

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, var_39_1, delegate))
end

function CommonTeamMediator:onClickOneKeyEmbattle()
	self._teamView:stopScroll()
	self:showOneKeyHeros()

	self._teamPets = {}
	self._petList = {}

	table.deepcopy(self._orderPets, self._teamPets)
	table.deepcopy(self._leavePets, self._petList)
	self:refreshListView(true)
	self:refreshPetNode()

	for i = 1, self._maxTeamPetNum do
		if self._petNodeList[i] then
			local iconBg = self._teamBg:getChildByName("pet_" .. i)

			if iconBg:getChildByName("EmptyIcon") then
				iconBg:getChildByName("EmptyIcon"):setVisible(false)
			end
		end
	end
end

function CommonTeamMediator:onClickHeroDetail(id, attrAdds)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local view = self:getInjector():getInstance("HeroShowNotOwnView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		showType = 2,
		id = id,
		attrAdds = attrAdds
	}))
end

function CommonTeamMediator:createSortView()
	local sortType = self._stageSystem:getCardSortType()

	local function callBack(data)
		local sortStr = self._stageSystem:getSortTypeStr(data.sortType)

		self._sortType:setString(sortStr)
		self._stageSystem:setCardSortType(data.sortType)
		self._teamView:stopScroll()
		self:refreshListView(true)
	end

	self._sortComponent = SortHeroListComponent:new({
		sortType = sortType,
		mediator = self,
		callBack = callBack
	})

	local sortStr = self._stageSystem:getSortTypeStr(sortType)

	self._sortType:setString(sortStr)
	self._sortComponent:getRootNode():addTo(self._myPetPanel:getChildByFullName("sortPanel"))
end

function CommonTeamMediator:onClickSort()
	self._stageSystem:setSortExtand(0)
	self._sortComponent:getRootNode():setVisible(true)
	self._sortComponent:showNormal()
	self._teamView:stopScroll()
	self:refreshListView(true)
end

function CommonTeamMediator:onClickScreen()
	self._stageSystem:setSortExtand(0)
	self._sortComponent:getRootNode():setVisible(true)
	self._sortComponent:showExtand()
	self._teamView:stopScroll()
	self:refreshListView(true)
end

function CommonTeamMediator:onClickMasterSkill()
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local params = {
		masterId = self._curMasterId,
		active = self._skillActive
	}
	local view = self:getInjector():getInstance("MasterLeaderSkillView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, params))
end

function CommonTeamMediator:onClickHeroSkill(skill, sender, adjustPos)
	self._skillDescPanel:setVisible(true)

	if not self._skillWidget then
		self._skillWidget = self:autoManageObject(self:getInjector():injectInto(SkillTipWidget:new(SkillTipWidget:createWidgetNode(), {
			skill = skill,
			mediator = self
		})))

		self._skillWidget:getView():addTo(self._skillDescPanel)
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self._skillWidget:refreshInfo(skill, true)

	local targetPos = sender:getParent():convertToWorldSpace(cc.p(sender:getPosition()))

	targetPos = self._skillWidget:getView():getParent():convertToNodeSpace(targetPos)

	local posX = targetPos.x - 15
	local viewHeight = self._skillWidget:getHeight()

	if viewHeight > 350 then
		if not (viewHeight - 350) then
			local offset = 0
			local posY = 330 + self._skillWidget:getHeight() - offset

			if adjustPos then
				posX = targetPos.x - self._skillWidget:getWidth() - 20
				posY = targetPos.y + 60
			end

			self._skillWidget:getView():setPosition(cc.p(posX, posY))
		end
	end
end

function CommonTeamMediator:createCostTip()
	local panel = self:getView():getChildByFullName("CostTip")

	if not panel then
		panel = ccui.Widget:create()

		panel:setAnchorPoint(cc.p(0.5, 0.5))
		panel:setContentSize(cc.size(1386, 852))
		panel:setTouchEnabled(true)
		panel:setSwallowTouches(false)
		panel:addClickEventListener(function()
			if panel:isVisible() then
				panel:setVisible(false)
			end
		end)
		panel:addTo(self:getView()):posite(568, 320)

		local bg = ccui.Scale9Sprite:createWithSpriteFrameName("common_bg_tips.png")

		bg:setCapInsets(cc.rect(5, 5, 5, 5))
		bg:setAnchorPoint(cc.p(0, 1))
		bg:addTo(panel):setPosition(cc.p(365, 603))
		bg:setName("CostTipBg")

		local value = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Fight_MaxCostBuff_Rule", "content")
		local contentText = ccui.RichText:createWithXML(Strings:get(value, {
			fontName = TTF_FONT_FZYH_R
		}), {})

		contentText:setAnchorPoint(cc.p(0, 1))
		contentText:renderContent(486, 0)

		local size = contentText:getContentSize()
		local height = size.height

		bg:setContentSize(cc.size(516, height + 30))
		contentText:addTo(bg):posite(15, height + 15)
	end

	panel:setVisible(true)
end

function CommonTeamMediator:refreshTeamName()
	if self._teamName then
		self._oldName = self._nowName

		self._teamName:setString(self._nowName)

		local posX2 = self._teamName:getPositionX()

		self._editBox:setPositionX(posX2 - self._teamName:getContentSize().width / 2)
	end
end

function CommonTeamMediator:runStartAction()
	for i = 1, self._maxTeamPetNum do
		if self._petNodeList[i] then
			local iconBg = self._teamBg:getChildByName("pet_" .. i)

			if iconBg:getChildByName("EmptyIcon") then
				iconBg:getChildByName("EmptyIcon"):setVisible(false)
			end
		end
	end

	local children = self._teamView:getContainer():getChildren()
	local delayTime = 0.1
	local length = #children
	local index = 2

	self._touchPanel:setVisible(index <= length)

	for i = index, length do
		local child = children[i]:getChildByTag(12138)

		if child then
			child = child:getChildByFullName("myPetClone")

			child:stopAllActions()
			child:setOpacity(0)
		end
	end

	for i = index, length do
		local child = children[i]:getChildByTag(12138)

		if child then
			child = child:getChildByFullName("myPetClone")

			child:stopAllActions()

			local delayAction = cc.DelayTime:create((i - index) * delayTime)
			local callfunc = cc.CallFunc:create(function()
				CommonUtils.runActionEffect(child, "Node_1.myPetClone", "BlockTeamEffect", "anim1", false)
			end)
			local callfunc1 = cc.CallFunc:create(function()
				if i == length then
					self._touchPanel:setVisible(false)
				end

				child:stopAllActions()
				child:setOpacity(255)
				child:setPosition(cc.p(94, 105))
			end)
			local seq = cc.Sequence:create(delayAction, callfunc, callfunc1)

			self:getView():runAction(seq)
		end
	end
end

function CommonTeamMediator:runRemoveAction(id)
	local index
	local children = self._teamView:getContainer():getChildren()

	for i = 2, #children do
		if id == children[i].id then
			index = i

			break
		end
	end

	if not index then
		return
	end

	index = index + 1

	local length = #children

	self._touchPanel:setVisible(index <= length)

	for i = index, length do
		local child = children[i]:getChildByTag(12138)

		if child then
			child = child:getChildByFullName("myPetClone")

			child:stopAllActions()
			child:setPositionX(-77)
		end
	end

	local delayTime = 0.2

	for i = index, length do
		local child = children[i]:getChildByTag(12138)

		if child then
			child = child:getChildByFullName("myPetClone")

			child:stopAllActions()

			local callfunc = cc.CallFunc:create(function()
				CommonUtils.runActionEffect(child, "Node_1.myPetClone", "BlockTeamEffect", "anim2", false)
			end)
			local delayAction = cc.DelayTime:create(delayTime)
			local callfunc1 = cc.CallFunc:create(function()
				if i == length then
					self._touchPanel:setVisible(false)
				end

				child:stopAllActions()
				child:setOpacity(255)
				child:setPosition(cc.p(94, 105))
			end)
			local seq = cc.Sequence:create(callfunc, delayAction, callfunc1)

			self:getView():runAction(seq)
		end
	end
end

function CommonTeamMediator:runRemovePetAction(id)
	do return end

	local index, child
	local children = self._teamView:getContainer():getChildren()

	for i = 2, #children do
		if id == children[i].id then
			index = i

			break
		end
	end

	if not index then
		return
	end

	print(" runRemovePetAction child______ " .. index)

	if not self._removeAction then
		self._touchPanel:setVisible(true)
	end

	local node = children[index]:getChildByTag(12138)

	child = node:getChildByFullName("myPetClone")

	if child then
		child:setVisible(false)
		self._main:removeChildByName("CloneNode2")

		local cloneNode = child:clone()

		cloneNode:setVisible(true)
		cloneNode:addTo(self._main)
		cloneNode:setAnchorPoint(cc.p(0.5, 0.5))
		cloneNode:setName("CloneNode2")

		local targetPos = child:getParent():convertToWorldSpace(cc.p(child:getPosition()))

		targetPos = cloneNode:getParent():convertToNodeSpace(targetPos)

		cloneNode:setPosition(cc.p(targetPos.x, targetPos.y))

		local heroNode = cloneNode:getChildByFullName("hero")

		heroNode:removeAllChildren()

		local anim = cc.MovieClip:create("changkapianfanzhuan_biandui")

		anim:addTo(heroNode)
		anim:setPosition(cc.p(65, 100))

		heroNode = anim:getChildByFullName("hero")

		heroNode:removeAllChildren()

		local id = child.id
		local heroInfo = self:getHeroInfoById(id)

		heroInfo.id = heroInfo.roleModel

		local heroImg = IconFactory:createRoleIconSpriteNew(heroInfo)

		heroImg:setScale(0.68)
		heroImg:addTo(heroNode)
		heroImg:offset(2.5, -31.5)

		local starBg_node = cloneNode:getChildByFullName("starBg")
		local levelImage_node = cloneNode:getChildByFullName("levelImage")
		local level_node = cloneNode:getChildByFullName("level")
		local costBg_node = cloneNode:getChildByFullName("costBg")
		local bg_bg = cloneNode:getChildByFullName("bg1")
		local bg2_bg = cloneNode:getChildByFullName("bg2")
		local rarity_node = cloneNode:getChildByFullName("rarityBg")
		local nameBg1_node = cloneNode:getChildByFullName("nameBg")
		local occupationBg_node = cloneNode:getChildByFullName("occupationBg")
		local occupation_node = cloneNode:getChildByFullName("occupation")
		local skillPanel_node = cloneNode:getChildByFullName("skillPanel")
		local nameBg_node = cloneNode:getChildByFullName("namePanel")
		local recommond_node = cloneNode:getChildByFullName("recommond")
		local except_node = cloneNode:getChildByFullName("except")
		local detailBtn_node = cloneNode:getChildByFullName("detailBtn")
		local teamNum_node = cloneNode:getChildByFullName("teamNum")
		local image_combat_bg_node = cloneNode:getChildByFullName("image_combat_bg")

		anim:gotoAndPlay(4)
		anim:setPlaySpeed(1.2)

		local starBg = anim:getChildByName("starBg")
		local level = anim:getChildByName("level")
		local costBg = anim:getChildByName("costBg")
		local bg = anim:getChildByFullName("bg")
		local rarity = anim:getChildByFullName("rarity")
		local occupation = anim:getChildByFullName("occupation")
		local nodeToActionNodeMap = {}

		nodeToActionNodeMap[levelImage_node] = level
		nodeToActionNodeMap[level_node] = level
		nodeToActionNodeMap[costBg_node] = costBg
		nodeToActionNodeMap[bg_bg] = bg
		nodeToActionNodeMap[bg2_bg] = bg
		nodeToActionNodeMap[rarity_node] = rarity
		nodeToActionNodeMap[occupation_node] = occupation
		nodeToActionNodeMap[skillPanel_node] = occupation
		nodeToActionNodeMap[occupationBg_node] = occupation
		nodeToActionNodeMap[nameBg1_node] = occupation
		nodeToActionNodeMap[nameBg_node] = occupation

		if starBg_node then
			nodeToActionNodeMap[starBg_node] = starBg
		end

		if recommond_node then
			nodeToActionNodeMap[recommond_node] = occupation
		end

		if except_node then
			nodeToActionNodeMap[except_node] = occupation
		end

		if teamNum_node then
			nodeToActionNodeMap[teamNum_node] = occupation
		end

		if detailBtn_node then
			nodeToActionNodeMap[detailBtn_node] = occupation
		end

		if image_combat_bg_node then
			nodeToActionNodeMap[image_combat_bg_node] = occupation
		end

		local startfunc, stopfunc = CommonUtils.bindNodeToActionNode(nodeToActionNodeMap, self._main)

		startfunc()
		anim:addCallbackAtFrame(17, function()
			anim:stop()
			child:setVisible(true)
			stopfunc()
			self._main:removeChildByName("CloneNode2")

			if self._removeAction then
				self._removeAction = false
			else
				self._touchPanel:setVisible(false)
			end
		end)
	end
end

function CommonTeamMediator:runInsertAction(id)
	local index
	local children = self._teamView:getContainer():getChildren()

	for i = 2, #children do
		if id == children[i].id then
			index = i

			break
		end
	end

	if not index then
		self._runInsertAction = true

		return
	end

	print(" runInsertAction index_______ " .. index)
	self._touchPanel:setVisible(true)

	local delayTime = 0.13333333333333333
	local length = #children

	for i = index, length do
		local child = children[i]:getChildByTag(12138)

		if child then
			child = child:getChildByFullName("myPetClone")

			child:setPositionX(227)
		end
	end

	for i = index, length do
		local child = children[i]:getChildByTag(12138)

		if child then
			child = child:getChildByFullName("myPetClone")

			child:stopAllActions()

			local callfunc = cc.CallFunc:create(function()
				CommonUtils.runActionEffect(child, "Node_1.myPetClone", "BlockTeamEffect", "anim3", false)
			end)
			local delayAction = cc.DelayTime:create(delayTime)
			local callfunc1 = cc.CallFunc:create(function()
				if i == length then
					self._touchPanel:setVisible(false)
				end

				child:stopAllActions()
				child:setOpacity(255)
				child:setPosition(cc.p(94, 105))
			end)
			local seq = cc.Sequence:create(callfunc, delayAction, callfunc1)

			self:getView():runAction(seq)
		end
	end
end

function CommonTeamMediator:runInsertPetAction(child, callback)
	if callback then
		callback()
	end

	do return end

	if child then
		self._runInsertPetAction = true

		child:setVisible(false)
		print(" runInsertPetAction child______ ")
		self._main:removeChildByName("CloneNode")

		local cloneNode = child:clone()

		cloneNode:setVisible(true)
		cloneNode:addTo(self._main)
		cloneNode:setAnchorPoint(cc.p(0.5, 0.5))
		cloneNode:setName("CloneNode")

		local targetPos = child:getParent():convertToWorldSpace(cc.p(child:getPosition()))

		targetPos = cloneNode:getParent():convertToNodeSpace(targetPos)

		cloneNode:setPosition(cc.p(targetPos.x, targetPos.y))

		local heroNode = cloneNode:getChildByFullName("hero")

		heroNode:removeAllChildren()

		local anim = cc.MovieClip:create("changkapian_biandui")

		anim:addTo(heroNode)
		anim:setPosition(cc.p(65, 100))

		heroNode = anim:getChildByFullName("hero")

		heroNode:removeAllChildren()

		local id = child.id
		local heroInfo = self:getHeroInfoById(id)

		heroInfo.id = heroInfo.roleModel

		local heroImg = IconFactory:createRoleIconScreateRoleIconSpriteNewprite(heroInfo)

		heroImg:setScale(0.68)
		heroImg:addTo(heroNode)
		heroImg:offset(2.5, -31.5)

		local starBg_node = cloneNode:getChildByFullName("starBg")
		local level_node = cloneNode:getChildByFullName("level")
		local costBg_node = cloneNode:getChildByFullName("costBg")
		local nameBg1_node = cloneNode:getChildByFullName("nameBg")
		local bg_bg = cloneNode:getChildByFullName("bg1")
		local bg2_bg = cloneNode:getChildByFullName("bg2")
		local rarity_node = cloneNode:getChildByFullName("rarityBg")
		local occupation_node = cloneNode:getChildByFullName("occupation")
		local occupationBg_node = cloneNode:getChildByFullName("occupationBg")
		local skillPanel_node = cloneNode:getChildByFullName("skillPanel")
		local nameBg_node = cloneNode:getChildByFullName("namePanel")
		local detailBtn_node = cloneNode:getChildByFullName("detailBtn")
		local recommond_node = cloneNode:getChildByFullName("recommond")
		local except_node = cloneNode:getChildByFullName("except")
		local teamNum_node = cloneNode:getChildByFullName("teamNum")
		local image_combat_bg_node = cloneNode:getChildByFullName("image_combat_bg")

		anim:gotoAndPlay(0)
		anim:setPlaySpeed(1.2)

		local starBg = anim:getChildByName("starBg")
		local level = anim:getChildByName("level")
		local costBg = anim:getChildByName("costBg")
		local bg = anim:getChildByFullName("bg")
		local rarity = anim:getChildByFullName("rarity")
		local occupation = anim:getChildByFullName("occupation")
		local nodeToActionNodeMap = {}

		nodeToActionNodeMap[level_node] = level
		nodeToActionNodeMap[costBg_node] = costBg
		nodeToActionNodeMap[bg_bg] = bg
		nodeToActionNodeMap[bg2_bg] = bg
		nodeToActionNodeMap[rarity_node] = rarity
		nodeToActionNodeMap[occupation_node] = occupation
		nodeToActionNodeMap[occupationBg_node] = occupation
		nodeToActionNodeMap[skillPanel_node] = occupation
		nodeToActionNodeMap[nameBg_node] = occupation
		nodeToActionNodeMap[nameBg1_node] = occupation

		if starBg_node then
			nodeToActionNodeMap[starBg_node] = starBg
		end

		if recommond_node then
			nodeToActionNodeMap[recommond_node] = occupation
		end

		if except_node then
			nodeToActionNodeMap[except_node] = occupation
		end

		if teamNum_node then
			nodeToActionNodeMap[teamNum_node] = occupation
		end

		if detailBtn_node then
			nodeToActionNodeMap[detailBtn_node] = occupation
		end

		if image_combat_bg_node then
			nodeToActionNodeMap[image_combat_bg_node] = occupation
		end

		local startfunc, stopfunc = CommonUtils.bindNodeToActionNode(nodeToActionNodeMap, self._main)

		startfunc()
		anim:addCallbackAtFrame(12, function()
			anim:stop()
			child:setVisible(true)
			stopfunc()

			if callback then
				callback()
			end

			self._main:removeChildByName("CloneNode")
		end)
	end
end

function CommonTeamMediator:runInsertTeamAction(id)
	do return end

	local index

	for i = 1, #self._petNodeList do
		local node = self._petNodeList[i]

		if node and node.id == id then
			index = i

			break
		end
	end

	if not index then
		return
	end

	self._runInsertTeamAction = true

	self._touchPanel:setVisible(true)
	self._petNodeList[index]:setVisible(false)
	print(" runInsertTeamAction child______ ")
	self._main:removeChildByName("CloneNode1")

	local cloneNode = self._petNodeList[index]:clone()

	cloneNode:setVisible(true)
	cloneNode:addTo(self._main)
	cloneNode:setAnchorPoint(cc.p(0.5, 0.5))
	cloneNode:setName("CloneNode1")

	local targetPos = self._petNodeList[index]:getParent():convertToWorldSpace(cc.p(self._petNodeList[index]:getPosition()))

	targetPos = cloneNode:getParent():convertToNodeSpace(targetPos)

	cloneNode:setPosition(cc.p(targetPos.x, targetPos.y))

	local heroNode = cloneNode:getChildByFullName("hero")

	heroNode:removeAllChildren()

	local anim = cc.MovieClip:create("rubian_biandui")

	anim:addTo(heroNode)
	anim:setPosition(cc.p(68, 63.5))

	heroNode = anim:getChildByFullName("hero")

	heroNode:removeAllChildren()

	local heroInfo = self:getHeroInfoById(id)

	heroInfo.id = heroInfo.roleModel

	local heroImg = IconFactory:createRoleIconSpriteNew(heroInfo)

	heroImg:addTo(heroNode)
	heroImg:setScale(0.68)

	local costBg_node = cloneNode:getChildByFullName("costBg")
	local bg_bg1 = cloneNode:getChildByFullName("bg1")
	local bg_bg2 = cloneNode:getChildByFullName("bg2")
	local rarity_node = cloneNode:getChildByFullName("rarityBg")
	local occupationBg = cloneNode:getChildByFullName("occupationBg")
	local occupation_node = cloneNode:getChildByFullName("occupation")
	local skillPanel_node = cloneNode:getChildByFullName("skillPanel")
	local recommond_node = cloneNode:getChildByFullName("recommond")

	anim:gotoAndPlay(0)
	anim:setPlaySpeed(1.2)

	local costBg = anim:getChildByName("costBg")
	local bg = anim:getChildByFullName("bg")
	local rarity = anim:getChildByFullName("rarity")
	local occupation = anim:getChildByFullName("occupation")
	local nodeToActionNodeMap = {}

	nodeToActionNodeMap[costBg_node] = costBg
	nodeToActionNodeMap[bg_bg1] = bg
	nodeToActionNodeMap[bg_bg2] = bg
	nodeToActionNodeMap[rarity_node] = rarity
	nodeToActionNodeMap[occupation_node] = occupation
	nodeToActionNodeMap[occupationBg] = occupation
	nodeToActionNodeMap[skillPanel_node] = occupation

	if recommond_node then
		nodeToActionNodeMap[recommond_node] = occupation
	end

	local startfunc, stopfunc = CommonUtils.bindNodeToActionNode(nodeToActionNodeMap, self._main)

	startfunc()
	anim:addCallbackAtFrame(19, function()
		anim:stop()
		self._petNodeList[index]:setVisible(true)

		if self._petNodeList[index]:getParent():getChildByName("EmptyIcon") then
			self._petNodeList[index]:getParent():getChildByName("EmptyIcon"):setVisible(false)
		end

		stopfunc()
		self._main:removeChildByName("CloneNode1")

		self._runInsertTeamAction = false

		if self._runInsertAction then
			self._touchPanel:setVisible(false)

			self._runInsertPetAction = nil
			self._runInsertAction = false
		end
	end)
end

function CommonTeamMediator:showSetButton(show)
	local setButton = self:getView():getChildByFullName("main.my_pet_bg.sortPanel.setBtn")
	local sortBtn = self:getView():getChildByFullName("main.my_pet_bg.sortPanel.sortBtn")
	local screenBtn = self:getView():getChildByFullName("main.my_pet_bg.sortPanel.screenBtn")
	local initY = 144
	local height = 85
	local btnList = {
		sortBtn,
		screenBtn
	}

	if show then
		setButton:setVisible(true)

		initY = 160
		height = 65
		btnList[#btnList + 1] = setButton
	else
		setButton:setVisible(false)
	end

	for i, btn in pairs(btnList) do
		btn:setPositionY(initY - (i - 1) * height)
	end
end

function CommonTeamMediator:onClickTeamSetBtn()
	local view = self:getInjector():getInstance("ChangeTeamModelView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {}))
end
