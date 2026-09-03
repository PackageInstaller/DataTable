-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/StageTeamMediator.lua

require("dm.gameplay.stage.view.CommonTeamMediator")

StageTeamMediator = class("StageTeamMediator", CommonTeamMediator, _M)

StageTeamMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
StageTeamMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
StageTeamMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
StageTeamMediator:has("_spStageSystem", {
	is = "r"
}):injectWith("SpStageSystem")
StageTeamMediator:has("_crusadeSystem", {
	is = "r"
}):injectWith("CrusadeSystem")

local costType = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Init_Cost_Type", "content")
local kBtnHandlers = {
	["main.info_bg.costBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickCost"
	},
	["main.left.button"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickCardsTurnLeft"
	},
	["main.right.button"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickCardsTurnRight"
	},
	limittips = {
		func = "onClickLimitTipsPanel"
	}
}
local kHeroRarityBgAnim = {
	[15] = "spzong_urequipeff",
	[13] = "srzong_yingxiongxuanze",
	[14] = "ssrzong_yingxiongxuanze"
}

function StageTeamMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._fightBtn = self:bindWidget("main.btnPanel.fightBtn", TwoLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_2",
			func = bind1(self.onClickFight, self)
		}
	})
	self._oneKeyWidget = self:bindWidget("main.button_one_key_embattle", ThreeLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_2",
			func = bind1(self.onClickOneKeyEmbattle, self)
		}
	})
	self._oneKeyWidget = self:bindWidget("main.button_one_key_break", ThreeLevelMainButton, {
		handler = {
			clickAudio = "Se_Click_Common_2",
			func = bind1(self.onClickOneKeyBreak, self)
		}
	})
	self._oneKeyWidget = self:bindWidget("main.button_one_key_power", ThreeLevelMainButton, {
		handler = {
			clickAudio = "Se_Click_Common_2",
			func = bind1(self.onClickPowerBtn, self)
		}
	})
	self._oneKeyWidget = self:bindWidget("main.button_one_key_power_1", ThreeLevelMainButton, {
		handler = {
			clickAudio = "Se_Click_Common_2",
			func = bind1(self.onClickPowerBtn, self)
		}
	})
	self._heroSystem = self._developSystem:getHeroSystem()
	self._masterSystem = self._developSystem:getMasterSystem()

	self.mapEventListener(self, self:getEventDispatcher(), EVT_TEAM_CHANGE_MASTER, self, self.changeMasterId)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_TEAM_REFRESH_PETS, self, self.refreshViewBySort)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ARENA_CHANGE_TEAM_SUCC, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CRUSADE_RESET_DIFF, self, self.resetCrusade)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_STAGE_CHANGENAME_SUCC, self, self.refreshTeamName)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CHANGE_TEAM_BYMODE_SUCC, self, self.changeTeamByMode)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshCombatAndCost)

	local touchPanel = self:getView():getChildByFullName("main.bg.touchPanel")

	touchPanel:addClickEventListener(function()
		self:onClickChangeMaster()
	end)

	self._masterBtn = touchPanel
	self._skillDescPanel = self:getView():getChildByFullName("skillDescPanel")

	self._skillDescPanel:setSwallowTouches(false)
	self._skillDescPanel:addClickEventListener(function()
		if self._skillDescPanel:isVisible() then
			self._skillDescPanel:setVisible(false)
		end
	end)

	self._masterSkillPanel = self:getView():getChildByFullName("main.bg.masterSkillPanel")

	self._masterSkillPanel:setVisible(true)
	self:getView():getChildByFullName("main.bg.masterSkillBg"):setVisible(true)
	self._masterSkillPanel:addClickEventListener(function()
		self:onClickMasterSkill()
	end)
end

function StageTeamMediator:enterWithData(data)
	data = data or {}
	self._data = data

	if data and data.stageType then
		self._stageType = data.stageType or ""
	end

	if data and data.stageId then
		self._stageId = data.stageId or ""
	end

	if data and data.data then
		self._spData = data.data or {}
	end

	if self._spData.cardsExcept then
		self._cardsExcept = self._spData.cardsExcept or {}
	end

	self._limitHero = data.limitHero or {}
	self._isSpecialStage = data and data.isSpecialStage
	self._hideFightBtn = data and data.hideFightBtn

	if data and data.tabType then
		self._curTabType = data.tabType or 1
	end

	self._masterList = self._masterSystem:getShowMasterList()
	self._canChange = true

	local num = 0

	for i = 1, #self._masterList do
		if not self._masterList[i]:getIsLock() then
			num = num + 1
		end
	end

	self._showChangeMaster = num > 1
	self._isDrag = false
	self._costTotal = 0
	self._costMaxNum = self._stageSystem:getCostInit() + self._developSystem:getBuildingCostEffValue()
	self._maxTeamPetNum = self._stageSystem:getPlayerInit() + self._developSystem:getBuildingCardEffValue()
	self._teamUnlockConfig = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Stage_Team_Unlock", "content")

	self._stageSystem:setSortExtand(0)

	if data.spStageType and costType[data.spStageType] ~= "-1" then
		self._spStageType = data.spStageType
		self._costMaxNum = tonumber(costType[data.spStageType])
	end

	self._ignoreReloadData = true

	self:initData()
	self:setupTopInfoWidget()
	self:initWidgetInfo()
	self:createCardsGroupName()
	self:setupView()
	self:checkCardsTurnBtn()

	local delayTime = 0.001

	performWithDelay(self:getView(), function()
		local offsetX = self._teamView:getContentOffset().x + self._petSize.width

		if offsetX > 0 then
			offsetX = 0
		end

		self._teamView:reloadData()
		self._teamView:setContentOffset(cc.p(offsetX, 0))
		self:runStartAction()
		self:setupClickEnvs()
	end, delayTime)
	self._costBtn:setVisible(self:showCostBtn())
end

function StageTeamMediator:resumeWithData()
	super.resumeWithData(self)
	self._costBtn:setVisible(self:showCostBtn())

	self._costMaxNum = self._stageSystem:getCostInit() + self._developSystem:getBuildingCostEffValue()

	if self._spStageType and costType[self._spStageType] ~= "-1" then
		self._costMaxNum = tonumber(costType[self._spStageType])
	end

	self._costTotalLabel2:setString("/" .. self._costMaxNum)

	if self:isCrusadeStage() then
		self._limitHero = self._crusadeSystem:getCrusade():getLimitHero()

		self:initData()
		self:refreshPetNode()
		self:refreshListView()
	end
end

function StageTeamMediator:initData(team)
	self._teamList = self._developSystem:getAllUnlockTeams()

	if team then
		self._curTeam = team
	else
		self._curTeam = self._teamList[self._curTabType]

		if self:isSpecialStage() then
			self._curTeam = self._developSystem:getSpTeamByType(self._stageType)
		end
	end

	self._curTeamId = self._curTeam:getId()

	local modelTmp = {
		_heroes = self:removeExceptHeros(),
		_masterId = self._curTeam:getMasterId()
	}

	self._curMasterId = modelTmp._masterId

	if self._curMasterId == "" or self._curMasterId == 0 then
		self._curMasterId = self._developSystem:getStageTeamById(1):getMasterId()
	end

	self._oldMasterId = self._curMasterId

	local teamPetIndex = 1

	self._teamPets = {}
	self._tempTeams = {}
	self._recommondJob = {}

	if self._stageId ~= "" then
		self._recommondJob = self:getSpStageSystem():getIntroductionJob(self._stageId)
	end

	for _, v in pairs(modelTmp._heroes) do
		self._teamPets[teamPetIndex] = v
		self._tempTeams[teamPetIndex] = v
		teamPetIndex = teamPetIndex + 1
	end

	self._nowName = self._curTeam:getName()
	self._oldName = self._nowName
	self._petList = self._stageSystem:getNotOnTeamPet(self._teamPets)
	self._petListAll = {}

	table.copy(self._petList, {})

	self._recommondList = {}

	for _, v in pairs(self._teamPets) do
		if self:checkIsRecommend(v) then
			self._recommondList[#self._recommondList + 1] = v
		end
	end

	for _, v in pairs(self._petList) do
		if self:checkIsRecommend(v) then
			self._recommondList[#self._recommondList + 1] = v
		end
	end
end

function StageTeamMediator:updateData()
	self._petList = self._stageSystem:getNotOnTeamPet(self._teamPets)
	self._petListAll = {}

	table.copy(self._petList, {})
end

function StageTeamMediator:isLimitHero(heroId)
	for i, v in pairs(self._limitHero) do
		if v == heroId then
			return true
		end
	end

	return false
end

function StageTeamMediator:removeExceptHeros()
	local heros = self._curTeam:getHeroes()
	local showHeros = {}

	for i = 1, #heros do
		local isExcept = self._stageSystem:isHeroExcept(self._cardsExcept, heros[i])
		local isLimit = self:isLimitHero(heros[i])

		if not isExcept and not isLimit then
			showHeros[#showHeros + 1] = heros[i]
		end
	end

	return showHeros
end

function StageTeamMediator:showOneKeyHeros()
	local orderPets = self._heroSystem:getTeamPrepared(self._teamPets, self._petList, self._recommondList)

	self._orderPets = {}
	self._leavePets = {}

	for i = 1, #orderPets do
		local isExcept = self._stageSystem:isHeroExcept(self._cardsExcept, orderPets[i])
		local isLimit = self:isLimitHero(orderPets[i])

		if #self._orderPets < self._maxTeamPetNum and not isExcept and not isLimit then
			self._orderPets[#self._orderPets + 1] = orderPets[i]
		else
			self._leavePets[#self._leavePets + 1] = orderPets[i]
		end
	end
end

function StageTeamMediator:setupView()
	self:initLockIcons()
	self:refreshPetNode()
	self:refreshMasterInfo()
	self:initView()
	self:refreshListView()
	self:createSortView()
	self:showSetButton(true)
end

function StageTeamMediator:initWidgetInfo()
	self._main = self:getView():getChildByFullName("main")
	self._qipao = self:getView():getChildByFullName("qipao")

	self._qipao:setVisible(false)
	self._qipao:setLocalZOrder(100)

	self._touchPanel = self:getView():getChildByFullName("touchPanel")

	self._touchPanel:setVisible(false)

	self._bg = self:getView():getChildByFullName("main.bg")
	self._teamTurnLeft = self._main:getChildByName("left")
	self._teamTurnRight = self._main:getChildByName("right")
	self._myPetPanel = self._main:getChildByFullName("my_pet_bg")
	self._heroPanel = self._myPetPanel:getChildByFullName("heroPanel")
	self._sortType = self._myPetPanel:getChildByFullName("sortPanel.sortBtn.text")
	self._masterImage = self._bg:getChildByName("role")
	self._teamBg = self._bg:getChildByName("team_bg")
	self._labelCombat = self._main:getChildByFullName("info_bg.combatLabel")
	self._infoBtn = self._main:getChildByFullName("infoBtn")
	self._fightInfoTip = self._main:getChildByFullName("fightInfo")

	self._fightInfoTip:setVisible(false)

	self._costAverageLabel = self._main:getChildByFullName("info_bg.averageLabel")
	self._costTotalLabel1 = self._main:getChildByFullName("info_bg.cost1")
	self._costTotalLabel2 = self._main:getChildByFullName("info_bg.cost2")
	self._movingPet = self._main:getChildByFullName("moving_pet")
	self._spPanel = self._main:getChildByName("spStagePanel")

	self._spPanel:setVisible(false)

	self._btnPanel = self._main:getChildByName("btnPanel")
	self._teamBreakBtn = self._main:getChildByFullName("button_one_key_break")
	self._teamOneKeyBtn = self._main:getChildByFullName("button_one_key_embattle")
	self._powerBtn = self._main:getChildByFullName("button_one_key_power")
	self._powerBtn1 = self._main:getChildByFullName("button_one_key_power_1")
	self._costTouch = self._main:getChildByFullName("info_bg.costTouch")

	self._powerBtn:setVisible(false)
	self._powerBtn1:setVisible(false)
	self._costTouch:addClickEventListener(function()
		self:createCostTip()
	end)

	self._costBtn = self._main:getChildByFullName("info_bg.costBtn")
	self._myPetClone = self:getView():getChildByName("myPetClone")

	self._myPetClone:setVisible(false)

	self._petSize = self._myPetClone:getChildByFullName("myPetClone"):getContentSize()
	self._teamPetClone = self:getView():getChildByName("teamPetClone")

	self._teamPetClone:setVisible(false)
	self._teamPetClone:setScale(0.64)

	self._pageTipPanel = self._main:getChildByFullName("pageTipPanel")

	self._pageTipPanel:removeAllChildren()
	self._pageTipPanel:setTouchEnabled(true)

	self._limitTips = self:getView():getChildByName("limittips")

	self._limitTips:setVisible(false)
	self._limitTips:setLocalZOrder(999999)

	local width = 0

	for i = 1, #self._teamList do
		local layout = ccui.Layout:create()
		local img = ccui.ImageView:create("kazu_bg_dian_1.png", 1)

		layout:setAnchorPoint(cc.p(0, 0.5))
		layout:setContentSize(img:getContentSize())
		img:addTo(layout):center(layout:getContentSize())
		img:setName("img")
		layout:setTag(i)
		layout:addTo(self._pageTipPanel)
		layout:setPosition(cc.p((img:getContentSize().width + 25) * (i - 1), self._pageTipPanel:getContentSize().height / 2))
		layout:setTouchEnabled(true)
		layout:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				local tag = sender:getTag()

				if not self._canChange then
					return
				end

				self._canChange = false

				performWithDelay(self:getView(), function()
					self._canChange = true
				end, 0.3)

				local function func()
					local currentType = self._curTabType

					currentType = tonumber(tag)

					if currentType <= 1 then
						currentType = 1
					end

					if currentType >= #self._teamList then
						currentType = #self._teamList
					end

					self:checkTeamIsEmpty(self._teamList[currentType]:getId(), currentType)
				end

				if self:checkToExit(func, true, "Stage_Team_UI12") then
					func()
				end
			end
		end)

		width = (layout:getContentSize().width + 25) * i
	end

	self._pageTipPanel:setContentSize(cc.size(width, 50))

	if self:isCrusadeStage() then
		self:setPowerBtnVis()
		self._teamBreakBtn:setPositionX(954)
		self._teamOneKeyBtn:setPositionX(954)
	end

	self:setLabelEffect()
	self:checkStageType()
	self:ignoreSafeArea()
end

function StageTeamMediator:ignoreSafeArea()
	AdjustUtils.ignorSafeAreaRectForNode(self._heroPanel, AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(self._myPetPanel:getChildByName("sortPanel"), AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(self._main:getChildByFullName("btnPanel"), AdjustUtils.kAdjustType.Right)
	AdjustUtils.ignorSafeAreaRectForNode(self._spPanel:getChildByFullName("combatBg"), AdjustUtils.kAdjustType.Right)

	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()

	self._heroPanel:setContentSize(cc.size(winSize.width, 220))

	if self:isSpecialStage() and not self._hideFightBtn then
		self._heroPanel:setContentSize(cc.size(winSize.width - 177, 220))
	end
end

function StageTeamMediator:createTeamCell(cell, index)
	local petNode = cell:getChildByTag(12138)
	local node = petNode:getChildByFullName("myPetClone")

	petNode:setVisible(false)

	cell.id = nil

	if index == 1 then
		return
	end

	petNode:setVisible(true)

	local id = self._petListAll[index - 1]

	node.id = id
	cell.id = id

	local isExcept = self._stageSystem:isHeroExcept(self._cardsExcept, id)

	node:setTouchEnabled(not isExcept)
	node:setSwallowTouches(false)
	node:addTouchEventListener(function(sender, eventType)
		self:onClickCell(sender, eventType, index)
	end)

	local heroInfo = self:getHeroInfoById(id)

	self:initHero(node, heroInfo)

	local recomandNode = node:getChildByName("recommond")

	if recomandNode then
		local text = recomandNode:getChildByFullName("text")

		text:setColor(cc.c3b(255, 255, 255))

		if self._stageType == StageTeamType.CRUSADE then
			local recommendData = self._crusadeSystem:checkIsRecommend(id, heroInfo)

			recomandNode:setVisible(recommendData.isRecommend)
			text:setString(recommendData.recommendDesc)

			if recommendData.isMaxRecommend then
				text:setColor(cc.c3b(255, 203, 63))
			end
		else
			recomandNode:setVisible(self:checkIsRecommend(id))
		end

		if getCurrentLanguage() ~= GameLanguageType.CN then
			text:setScale(1.2)
		else
			text:setScale(1)
		end
	end

	local detailBtn = node:getChildByFullName("detailBtn")

	detailBtn:addClickEventListener(function()
		local attrAdds = {}

		if self._stageType == StageTeamType.CRUSADE then
			local recommendData = self._crusadeSystem:checkIsRecommend(id, heroInfo)

			attrAdds = recommendData.attrAdds
		elseif self:checkIsRecommend(id) then
			attrAdds[#attrAdds + 1] = {}
			attrAdds[#attrAdds].title = Strings:get("Team_Hero_Type_Title")
			attrAdds[#attrAdds].desc = Strings:get(self:getHeroAttrInfo())
			attrAdds[#attrAdds].type = StageAttrAddType.HERO_TYPE
		end

		self:onClickHeroDetail(id, attrAdds)
	end)
end

function StageTeamMediator:getHeroAttrInfo()
	if self:isSpStage() then
		if SpStageResetId[self._stageId] then
			local descs = ConfigReader:getDataByNameIdAndKey("BlockSp", self._stageId, "SpecialDesc")

			return descs[2]
		else
			return ""
		end
	elseif self:isCrusadeStage() then
		return self._spData.specialRule or ""
	end
end

function StageTeamMediator:checkStageType()
	if self:isSpStage() then
		self._spPanel:setVisible(true)
		self._btnPanel:setVisible(true)
		self._fightBtn:setVisible(true)

		local spRuleLabel = self._spPanel:getChildByFullName("ruleLabel")

		if SpStageResetId[self._stageId] then
			local descs = ConfigReader:getDataByNameIdAndKey("BlockSp", self._stageId, "SpecialDesc")

			spRuleLabel:setString(Strings:get(descs[2]))
		else
			spRuleLabel:setString("")
		end

		local spDescPanel = self._spPanel:getChildByName("spDescPanel")

		spDescPanel:removeAllChildren()
		spDescPanel:setVisible(true)
		spDescPanel:addTouchEventListener(function(sender, eventType)
			self:onClickSpDesc(sender, eventType)
		end)

		local spDescDi = self._spPanel:getChildByName("spDescDi")

		spDescDi:removeAllChildren()

		local width = 0
		local panelWidth = 0

		if self._spData.specialRule then
			for i = 1, #self._spData.specialRule do
				local data = self._spData.specialRule[i]
				local icon = ccui.ImageView:create(data[1] .. ".png", 1)

				icon:setAnchorPoint(cc.p(0, 0.5))
				icon:setPosition(cc.p(icon:getContentSize().width * (i - 1) + 3, 25))
				icon:addTo(spDescPanel)

				panelWidth = panelWidth + icon:getContentSize().width * (i - 1) + 3

				local data1 = self._spData.specialRule[#self._spData.specialRule + 1 - i]
				local icon1 = ccui.ImageView:create(data1[1] .. ".png", 1)

				icon1:setAnchorPoint(cc.p(0, 0))
				icon1:setPosition(cc.p(13, 13 + (icon:getContentSize().height + 2) * (i - 1)))
				icon1:addTo(spDescDi)

				local desc = cc.Label:createWithTTF(Strings:get(data1[2]), TTF_FONT_FZYH_R, 18)

				desc:setAnchorPoint(cc.p(0, 0))
				desc:setPosition(cc.p(icon1:getPositionX() + icon1:getContentSize().width + 5, icon1:getPositionY() + 15))
				desc:addTo(spDescDi)

				width = math.max(width, desc:getContentSize().width)
			end

			spDescDi:setContentSize(cc.size(width + 100, 50 * #self._spData.specialRule + 40))
			spDescPanel:setContentSize(cc.size(panelWidth, 50))
		end
	elseif self:isCrusadeStage() then
		self._spPanel:setVisible(true)
		self._btnPanel:setVisible(true)
		self._fightBtn:setVisible(true)

		local spRuleLabel = self._spPanel:getChildByFullName("ruleLabel")

		spRuleLabel:setString(self._spData.specialRule or "")
	end
end

function StageTeamMediator:isSpStage()
	if self._isSpstage == nil then
		self._isSpstage = false

		for i, v in pairs(kSpStageTeamAndPointType) do
			if self._stageType == v.teamType then
				self._isSpstage = true

				return self._isSpstage
			end
		end
	end

	return self._isSpstage
end

function StageTeamMediator:isCrusadeStage()
	if self._isCrusadeStage == nil then
		self._isCrusadeStage = self._stageType == StageTeamType.CRUSADE
	end

	return self._isCrusadeStage
end

function StageTeamMediator:isSpecialStage()
	return self:isSpStage() or self:isCrusadeStage() or self._isSpecialStage
end

function StageTeamMediator:setLabelEffect()
	local lineGradiantVec2 = {
		{
			ratio = 0.5,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(129, 118, 113, 255)
		}
	}

	self._labelCombat:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
end

function StageTeamMediator:createCardsGroupName()
	local nameDi = self._main:getChildByName("nameBg")

	self._editBox = nameDi:getChildByFullName("TextField")
	self._teamName = nameDi:getChildByFullName("teamName")

	self._teamName:setVisible(false)

	self._nowName = self._curTeam:getName()
	self._oldName = self._nowName

	self._teamName:setString(self._nowName)

	local posX1 = self._editBox:getPositionX()
	local posX2 = self._teamName:getPositionX()

	nameDi:getChildByFullName("nameBtn"):setTouchEnabled(not self:isSpecialStage())
	nameDi:getChildByFullName("nameBtn"):setVisible(not self:isSpecialStage())
	nameDi:getChildByFullName("nameBtn"):addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
			self._editBox:openKeyboard()
		end
	end)

	local maxLength = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Team_Name_MaxWords", "content")

	if self._editBox:getDescription() == "TextField" then
		self._editBox:setMaxLength(maxLength)
		self._editBox:setMaxLengthEnabled(true)
		self._editBox:setTouchAreaEnabled(not self:isSpecialStage())
		self._editBox:setString(self._nowName)
	end

	if not self:isSpecialStage() then
		self._editBox = convertTextFieldToEditBox(self._editBox, nil, MaskWordType.NAME)

		self._editBox:setText(self._nowName)
		self._editBox:setPositionX(posX2 - self._teamName:getContentSize().width / 2)
		self._editBox:onEvent(function(eventName, sender)
			if eventName == "began" then
				self._editBox:setPositionX(posX1)
			elseif eventName == "ended" then
				-- block empty
			elseif eventName == "return" then
				local spaceCount = string.find(self._nowName, "%s")

				if spaceCount ~= nil then
					self:dispatch(ShowTipEvent({
						tip = Strings:get("setting_tips1")
					}))

					self._nowName = self._oldName

					self._editBox:setText(self._oldName)
					self._teamName:setString(self._nowName)
					self._editBox:setPositionX(posX2 - self._teamName:getContentSize().width / 2)

					return
				end

				if self._nowName ~= self._oldName then
					local teaminfo = {
						name = self._nowName,
						teamId = self._curTeamId
					}

					self._stageSystem:requestChangeTeamName(teaminfo, nil, false)
				else
					self._teamName:setString(self._nowName)
					self._editBox:setPositionX(posX2 - self._teamName:getContentSize().width / 2)
				end
			elseif eventName == "changed" then
				self._nowName = self._editBox:getText()
			elseif eventName == "ForbiddenWord" then
				self:getEventDispatcher():dispatchEvent(ShowTipEvent({
					tip = Strings:get("Common_Tip1")
				}))
			elseif eventName == "Exceed" then
				self:dispatch(ShowTipEvent({
					tip = Strings:get("Tips_WordNumber_Limit", {
						number = sender:getMaxLength()
					})
				}))
			end
		end)
	end
end

function StageTeamMediator:onClickCell(sender, eventType, index)
	local isMovePetSucc = false

	if eventType == ccui.TouchEventType.began then
		self._isReturn = true
		self._isOnTeam = false

		if self:isLimitHero(sender.id) then
			self._isOnTeam = true
		end
	elseif eventType == ccui.TouchEventType.moved then
		local beganPos = sender:getTouchBeganPosition()
		local movedPos = sender:getTouchMovePosition()

		if self._isReturn and not self._isDrag then
			self._isDrag = self:checkCellTouchType(beganPos, movedPos)

			if self._isDrag and not self._isOnTeam then
				self:createMovingPet(sender, 2)
				self:changeMovingPetPos(beganPos)
				sender:setVisible(false)
				sender:setSwallowTouches(true)
			end
		elseif self._isDrag and not self._isOnTeam then
			self:changeMovingPetPos(movedPos)
		end
	elseif eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
		sender:setVisible(true)
		sender:setSwallowTouches(false)

		if self:isLimitHero(sender.id) then
			self._isDrag = false

			self._limitTips:setVisible(true)

			return
		end

		if self._guildCallback and not self._isDrag then
			self._isOnTeam = true
		end

		if not self._isOnTeam then
			if not self._isDrag then
				local selectCanceled = self:isSelectCanceledByClick(sender.id)

				if self._isReturn and not selectCanceled then
					self:insertTeamPet(sender)
				end
			elseif self:checkIsInTeamArea() then
				self:changeOwnPet(sender)

				isMovePetSucc = true
			end
		end

		self._isDrag = false

		self:cleanMovingPet()
	end

	return isMovePetSucc
end

function StageTeamMediator:changeOwnPet(cell)
	local id = cell.id
	local targetIndex

	for i = 1, self._maxTeamPetNum do
		local iconBg = self._teamBg:getChildByName("pet_" .. i)

		if self:checkCollision(iconBg) then
			targetIndex = i

			break
		end
	end

	if not targetIndex then
		return
	end

	if self._guildCallback and targetIndex ~= 2 then
		return
	end

	local iconBg = self._teamBg:getChildByName("pet_" .. targetIndex)
	local targetId = iconBg.id
	local selectCanceled = self:isSelectCanceledByDray(id, iconBg.id)

	if selectCanceled then
		return
	end

	self:playInsertEffect(id)
	AudioEngine:getInstance():playEffect("Se_Click_Pickup", false)

	if targetId then
		self._teamPets[targetIndex] = id

		local index = table.indexof(self._petList, id)

		if index then
			self._petList[index] = targetId
		end

		self:refreshPetNode()
		self:refreshListView()
	else
		local animId
		local index = table.indexof(self._petListAll, id)
		local cellIndex = table.indexof(self._petList, id)

		if cellIndex then
			table.remove(self._petList, cellIndex)
		end

		self._teamPets[#self._teamPets + 1] = id

		self:refreshPetNode()
		self:runInsertTeamAction(id)
		self:refreshListView()
		self:runInsertAction((index and self._petListAll[index + 1] or nil) and self._petListAll[index + 1])
	end

	if self._guildCallback then
		self._guildCallback()
	end
end

function StageTeamMediator:insertTeamPet(cell, isDrag)
	local id = cell.id
	local animId
	local index = table.indexof(self._petListAll, id)

	if index and self._petListAll[index + 1] then
		animId = self._petListAll[index + 1]
	end

	for k, v in pairs(self._petList) do
		if v == id then
			table.remove(self._petList, k)
		end
	end

	self._teamPets[#self._teamPets + 1] = id

	self:refreshPetNode()
	self:playInsertEffect(id)
	AudioEngine:getInstance():playEffect("Se_Click_Pickup", false)

	if isDrag then
		self:runInsertTeamAction(id)
		self:refreshListView()
		self:runInsertAction(animId)

		return
	end

	self:runInsertTeamAction(cell.id)
	self:runInsertPetAction(cell, function()
		self:refreshListView()
		self:runInsertAction(animId)
	end)
end

function StageTeamMediator:createMovingPet(cell, type)
	local petNode
	local heroInfo = self:getHeroInfoById(cell.id)

	if type == 1 then
		petNode = self._teamPetClone:clone()

		petNode:setVisible(true)
		self:initTeamHero(petNode, heroInfo)

		if cell:getChildByName("EmptyIcon") then
			cell:getChildByName("EmptyIcon"):setVisible(true)
		end
	elseif type == 2 then
		petNode = self._myPetClone:getChildByFullName("myPetClone"):clone()

		petNode:setVisible(true)
		self:initHero(petNode, heroInfo)
	end

	if petNode then
		self._movingPet:removeAllChildren()
		petNode:setAnchorPoint(cc.p(0.5, 0.5))
		petNode:addTo(self._movingPet):center(self._movingPet:getContentSize())
	end
end

function StageTeamMediator:sortOnTeamPets()
	self._heroSystem:sortOnTeamPets(self._teamPets)
end

function StageTeamMediator:checkIsRecommend(id)
	local heroType = ConfigReader:getDataByNameIdAndKey("HeroBase", id, "Type")

	if table.indexof(self._recommondJob, heroType) then
		return true
	end

	return false
end

function StageTeamMediator:onClickOnTeamPet(sender, eventType)
	if eventType == ccui.TouchEventType.began then
		self._isOnOwn = false
	elseif eventType == ccui.TouchEventType.moved then
		local beganPos = sender:getTouchBeganPosition()
		local movedPos = sender:getTouchMovePosition()

		if not self._isDrag then
			self._isDrag = self:checkTouchType(beganPos, movedPos)

			if self._isDrag and not self._isOnOwn then
				self:createMovingPet(sender, 1)
				self:changeMovingPetPos(beganPos)

				if self._petNodeList[sender:getTag()] then
					self._petNodeList[sender:getTag()]:setVisible(false)
				end
			end
		elseif self._isDrag and not self._isOnOwn then
			self:changeMovingPetPos(movedPos)
		end
	elseif eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
		if self._petNodeList[sender:getTag()] then
			self._petNodeList[sender:getTag()]:setVisible(true)
		end

		self:removeTeamPet(sender:getTag())

		self._isDrag = false

		self:cleanMovingPet()
	end
end

function StageTeamMediator:removeTeamPet(index)
	AudioEngine:getInstance():playEffect("Se_Click_Putdown", false)

	local id = self._teamPets[index]
	local cellId = self:checkIsInOwnArea()

	if cellId then
		local idIndex = table.indexof(self._petList, cellId)
		local selectCanceled = self:isSelectCanceledByDray(cellId, id)
		local isLimit = self:isLimitHero(cellId)

		if idIndex and not selectCanceled and not isLimit then
			table.remove(self._petList, idIndex)

			self._teamPets[index] = cellId
		else
			table.remove(self._teamPets, index)
		end
	else
		table.remove(self._teamPets, index)
	end

	self._petList[#self._petList + 1] = id

	if self._qipao:isVisible() and self._qipao.id == id then
		self._qipao:setVisible(false)

		if self._specialSound then
			AudioEngine:getInstance():stopEffect(self._specialSound)
		end
	end

	self:refreshListView()
	self:refreshPetNode()
	self:runRemoveAction(id)
	self:runRemovePetAction(id)
end

function StageTeamMediator:resetCrusade()
	if self:isCrusadeStage() then
		self:dismiss()
	end
end

function StageTeamMediator:refreshViewBySort()
	self:updateData()
	self:refreshMasterInfo()
	self:refreshListView()
	self:refreshPetNode()
end

function StageTeamMediator:refreshView()
	self:initData()
	self:refreshMasterInfo()
	self:refreshListView()
	self:refreshPetNode()

	if not self:isSpecialStage() then
		self._editBox:setText(self._nowName)
	end

	self._costBtn:setVisible(self:showCostBtn())
end

function StageTeamMediator:refreshListView(ignoreAdjustOffset)
	self._petListAll = self._stageSystem:getSortExtendIds(self._petList)

	local sortType = self._stageSystem:getCardSortType()

	self._heroSystem:sortHeroes(self._petListAll, sortType, nil, nil, nil, self._stageType, self._limitHero)

	if table.nums(self._cardsExcept) > 0 then
		local heros1 = {}
		local heros2 = {}

		for i = 1, #self._petListAll do
			local isExcept = self._stageSystem:isHeroExcept(self._cardsExcept, self._petListAll[i])

			if isExcept then
				heros2[#heros2 + 1] = self._petListAll[i]
			else
				heros1[#heros1 + 1] = self._petListAll[i]
			end
		end

		self._petListAll = {}

		table.copy(heros1, self._petListAll)

		for i = 1, #heros2 do
			self._petListAll[#self._petListAll + 1] = heros2[i]
		end
	end

	if not self._ignoreReloadData then
		local offsetX = self._teamView:getContentOffset().x + self._petSize.width

		if offsetX > 0 then
			offsetX = 0
		end

		self._teamView:reloadData()

		if not ignoreAdjustOffset then
			self._teamView:setContentOffset(cc.p(offsetX, 0))
		end
	end

	self._ignoreReloadData = false
end

function StageTeamMediator:initHero(node, info)
	local heroId = info.id

	super.initHero(self, node, info)
	node:getChildByName("except"):setVisible(false)

	if self._stageSystem:isHeroExcept(self._cardsExcept, heroId) then
		node:getChildByName("except"):setVisible(true)
	end

	local skillPanel = node:getChildByName("skillPanel")
	local recomandNode = node:getChildByName("recommond")

	if recomandNode then
		local text = recomandNode:getChildByFullName("text")

		text:setColor(cc.c3b(255, 255, 255))

		if self._stageType == StageTeamType.CRUSADE then
			local recommendData = self._crusadeSystem:checkIsRecommend(heroId, info)

			recomandNode:setVisible(recommendData.isRecommend)
			text:setString(recommendData.recommendDesc)

			if recommendData.isMaxRecommend then
				text:setColor(cc.c3b(255, 203, 63))
			end
		else
			recomandNode:setVisible(self:checkIsRecommend(heroId))
		end
	end

	local skill = self._heroSystem:checkHasKeySkill(heroId)

	skillPanel:setVisible(not not skill)

	if skill then
		skillPanel:setVisible(true)
		skillPanel:setSwallowTouches(true)
		skillPanel:addClickEventListener(function()
			self:onClickHeroSkill(skill, skillPanel)
		end)

		if not skillPanel:getChildByName("KeyMark") then
			local skillType = skill:getType()
			local icon1, icon2 = self._heroSystem:getSkillTypeIcon(skillType)
			local image = ccui.ImageView:create(icon1)

			image:addTo(skillPanel):center(skillPanel:getContentSize())
			image:setName("KeyMark")
			image:setScale(0.85)
			image:offset(0, -5)
		end
	end

	if self:isLimitHero(heroId) then
		node:setColor(cc.c3b(80, 80, 80))

		if node:getParent() then
			if node:getParent():getChildByName("Text_limit") then
				node:getParent():getChildByName("Text_limit"):setVisible(true)
			end
		end
	else
		node:setColor(cc.c3b(255, 255, 255))

		if node:getParent() then
			if node:getParent():getChildByName("Text_limit") then
				node:getParent():getChildByName("Text_limit"):setVisible(false)
			end
		end
	end
end

function StageTeamMediator:refreshPetNode()
	self:refreshCombatAndCost()
	self:refreshButtons()
	self:sortOnTeamPets()
	self:checkMasterSkillActive()

	self._petNodeList = {}

	for i = 1, self._maxTeamPetNum do
		local iconBg = self._teamBg:getChildByName("pet_" .. i)

		iconBg:removeAllChildren()
		iconBg:setTag(i)
		iconBg:addTouchEventListener(function(sender, eventType)
			self:onClickOnTeamPet(sender, eventType)
		end)

		local emptyIcon = GameStyle:createEmptyIcon()

		emptyIcon:addTo(iconBg):center(iconBg:getContentSize())
		emptyIcon:setName("EmptyIcon")

		iconBg.id = nil

		local id = self._teamPets[i]

		if id then
			local heroInfo = self:getHeroInfoById(id)

			self._petNodeList[i] = self._teamPetClone:clone()

			self._petNodeList[i]:setVisible(true)

			self._petNodeList[i].id = id

			self:initTeamHero(self._petNodeList[i], heroInfo)
			self._petNodeList[i]:addTo(iconBg):center(iconBg:getContentSize())
			self._petNodeList[i]:offset(0, -9)
			iconBg:setTouchEnabled(true)

			iconBg.id = self._teamPets[i]

			if self._qipao:isVisible() and self._qipao.id == id then
				local targetPos = self._petNodeList[i]:getParent():convertToWorldSpace(cc.p(self._petNodeList[i]:getPosition()))

				targetPos = self._qipao:getParent():convertToNodeSpace(targetPos)

				self._qipao:setPosition(cc.p(targetPos.x - 50, targetPos.y + 60))
			end
		else
			iconBg:setTouchEnabled(false)
		end
	end
end

function StageTeamMediator:initTeamHero(node, info)
	local heroId = info.id

	super.initTeamHero(self, node, info)

	info.id = info.roleModel

	local heroImg = IconFactory:createRoleIconSpriteNew(info)

	heroImg:setScale(0.68)

	local heroPanel = node:getChildByName("hero")

	heroPanel:removeAllChildren()
	heroPanel:addChild(heroImg)
	heroImg:setPosition(heroPanel:getContentSize().width / 2, heroPanel:getContentSize().height / 2)

	local bg1 = node:getChildByName("bg1")
	local bg2 = node:getChildByName("bg2")

	bg1:loadTexture(GameStyle:getHeroRarityBg(info.rareity)[1])
	bg2:loadTexture(GameStyle:getHeroRarityBg(info.rareity)[2])
	bg1:removeAllChildren()
	bg2:removeAllChildren()

	if kHeroRarityBgAnim[info.rareity] then
		local anim = cc.MovieClip:create(kHeroRarityBgAnim[info.rareity])

		anim:addTo(bg1):center(bg1:getContentSize())

		if info.rareity <= 14 then
			anim:offset(-1, -29)
		else
			anim:offset(-3, 0)
		end

		if info.rareity >= 14 then
			local anim = cc.MovieClip:create("ssrlizichai_yingxiongxuanze")

			anim:addTo(bg2):center(bg2:getContentSize()):offset(5, -20)
		end
	else
		local sprite = ccui.ImageView:create(GameStyle:getHeroRarityBg(info.rareity)[1])

		sprite:addTo(bg1):center(bg1:getContentSize())
	end

	local rarity = node:getChildByFullName("rarityBg.rarity")
	local rarityAnim = IconFactory:getHeroRarityAnim(info.rareity)

	rarityAnim:addTo(rarity):posite(25, 15)

	local cost = node:getChildByFullName("costBg.cost")

	cost:setString(info.cost)

	local occupationName, occupationImg = GameStyle:getHeroOccupation(info.type)
	local occupation = node:getChildByName("occupation")

	occupation:loadTexture(occupationImg)

	local levelImage = node:getChildByFullName("levelImage")
	local levelLabel = node:getChildByFullName("level")

	levelLabel:setString(Strings:get("Strenghten_Text78", {
		level = info.level
	}))

	local levelImageWidth = levelImage:getContentSize().width
	local levelWidth = levelLabel:getContentSize().width

	levelImage:setScaleX((levelWidth + 40) / levelImageWidth)

	local skillPanel = node:getChildByName("skillPanel")
	local skill, condition = self._heroSystem:checkHasKeySkill(heroId)
	local dicengEff, shangcengEff

	skillPanel:setVisible(not not skill)

	if skill then
		skillPanel:setVisible(true)
		skillPanel:setSwallowTouches(true)
		skillPanel:addClickEventListener(function()
			self:onClickHeroSkill(skill, skillPanel, true)
		end)

		if not skillPanel:getChildByName("KeyMark") then
			local skillType = skill:getType()
			local icon1, icon2 = self._heroSystem:getSkillTypeIcon(skillType)
			local image = ccui.ImageView:create(icon1)

			dicengEff = cc.MovieClip:create("diceng_jinengjihuo")

			dicengEff:setAnchorPoint(0.5, 0.5)
			dicengEff:setScale(0.38)
			dicengEff:setVisible(false)

			shangcengEff = cc.MovieClip:create("shangceng_jinengjihuo")

			shangcengEff:setAnchorPoint(0.5, 0.5)
			shangcengEff:setScale(0.38)
			shangcengEff:setVisible(false)
			dicengEff:addTo(skillPanel):center(skillPanel:getContentSize()):offset(-1.5, -2)
			image:addTo(skillPanel):center(skillPanel:getContentSize())
			shangcengEff:addTo(skillPanel):center(skillPanel:getContentSize()):offset(-1.5, -2)
			image:setName("KeyMark")
			image:setScale(0.85)
			image:offset(0, -5)
		end

		local isActive = self._stageSystem:checkIsKeySkillActive(condition, self._teamPets, {
			masterId = self._curMasterId
		})

		if dicengEff then
			dicengEff:setVisible(isActive)
		end

		if shangcengEff then
			shangcengEff:setVisible(isActive)
		end

		skillPanel:setGray(not isActive)
	end

	local recomandNode = node:getChildByName("recommond")

	if recomandNode then
		local text = recomandNode:getChildByFullName("text")

		text:setColor(cc.c3b(255, 255, 255))

		if self._stageType == StageTeamType.CRUSADE then
			local recommendData = self._crusadeSystem:checkIsRecommend(heroId, info)

			recomandNode:setVisible(recommendData.isRecommend)
			text:setString(recommendData.recommendDesc)

			if recommendData.isMaxRecommend then
				text:setColor(cc.c3b(255, 203, 63))
			end
		else
			recomandNode:setVisible(self:checkIsRecommend(heroId))
		end

		recomandNode:setContentSize(text:getContentSize())
		text:setPosition(cc.p(recomandNode:getContentSize().width / 2, recomandNode:getContentSize().height / 2 + 3))

		if getCurrentLanguage() ~= GameLanguageType.CN then
			text:setScale(1.5)
		else
			text:setScale(1)
		end
	end
end

function StageTeamMediator:refreshCombatAndCost()
	local leadConfig = self._masterSystem:getMasterCurLeadStageConfig(self._curMasterId)

	if leadConfig then
		if not leadConfig.LeadFightHero then
			local addPercent = 0
			local totalCombat = 0
			local totalCost = 0
			local averageCost = 0

			for k, v in pairs(self._teamPets) do
				local heroInfo = self._heroSystem:getHeroById(v)

				totalCost = totalCost + heroInfo:getCost()
				totalCombat = totalCombat + heroInfo:getSceneCombatByType(SceneCombatsType.kAll)
			end

			totalCombat = leadConfig and math.ceil((addPercent + 1) * totalCombat) or totalCombat

			local masterData = self._masterSystem:getMasterById(self._curMasterId)

			totalCombat = masterData and totalCombat + masterData:getCombat() or totalCombat
			self._costTotal = totalCost
			averageCost = #self._teamPets == 0 and 0 or math.floor(totalCost * 10 / #self._teamPets + 0.5) / 10

			self._labelCombat:setString(totalCombat)
			self._costAverageLabel:setString(averageCost)
			self._costTotalLabel1:setString(self._costTotal)

			local color = self._costTotal <= self._costMaxNum and cc.c3b(255, 255, 255) or cc.c3b(255, 65, 51)

			self._costTotalLabel1:setTextColor(color)
			self._costTotalLabel2:setString("/" .. self._costMaxNum)
			self._costTotalLabel2:setPositionX(self._costTotalLabel1:getPositionX() + self._costTotalLabel1:getContentSize().width)
			self._infoBtn:setVisible(leadConfig ~= nil and addPercent > 0)
			self._infoBtn:addTouchEventListener(function(sender, eventType)
				self:onClickInfo(eventType)
			end)
		end
	end
end

function StageTeamMediator:changeMasterId(event)
	self._oldMasterId = self._curMasterId
	self._curMasterId = event:getData().masterId

	self:refreshMasterInfo()
	self:checkMasterSkillActive()
	self:refreshPetNode()
end

function StageTeamMediator:refreshMasterInfo()
	local masterData = self._masterSystem:getMasterById(self._curMasterId)

	self._masterBtn:setVisible(self._showChangeMaster)
	self._masterImage:setVisible(true)
	self._masterImage:removeAllChildren()
	self._masterImage:addChild(masterData:getHalfImage())
	self:refreshCombatAndCost()
	self:refreshButtons()
end

function StageTeamMediator:refreshButtons()
	self._teamBreakBtn:setVisible(self:checkButtonVisible())
	self._teamOneKeyBtn:setVisible(not self:checkButtonVisible())
end

function StageTeamMediator:checkButtonVisible()
	if #self._teamPets < self._maxTeamPetNum then
		for i = 1, #self._petList do
			local isExcept = self._stageSystem:isHeroExcept(self._cardsExcept, self._petList[i])

			if not isExcept then
				return false
			end
		end
	end

	return true
end

function StageTeamMediator:checkToExit(func, isIgnore, translateId)
	local isCrusade = self:isCrusadeStage()

	if #self._teamPets < 1 then
		if isCrusade then
			return true
		end

		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:find("ARENA_TEMA_EMPTY")
		}))

		return false
	end

	if self:isSpecialStage() then
		self:sendSpChangeTeam(func)
	else
		self:sendChangeTeam(func)
	end

	return false
end

function StageTeamMediator:getSendData()
	local sendData = {}
	local hasHero = false

	for k, v in pairs(self._teamPets) do
		sendData[k] = {}
		sendData[k].id = v
		hasHero = true
	end

	if not hasHero then
		table.insert(sendData, {})
	end

	return {
		type = 0,
		teamId = self._curTeamId,
		masterId = self._curMasterId,
		heros = sendData
	}
end

function StageTeamMediator:hasChangeTeam()
	if self._oldMasterId ~= self._curMasterId then
		return true
	end

	if #self._tempTeams ~= #self._teamPets then
		return true
	end

	local tempTab = {}

	for k, v in pairs(self._tempTeams) do
		tempTab[v] = k
	end

	for k, v in pairs(self._teamPets) do
		if not tempTab[v] then
			return true
		end
	end

	return false
end

function StageTeamMediator:checkCardsTurnBtn()
	if self:isSpecialStage() then
		self._teamTurnLeft:setVisible(false)
		self._teamTurnRight:setVisible(false)
		self._pageTipPanel:setVisible(false)

		return
	end

	if #self._teamList <= 1 then
		self._teamTurnLeft:setVisible(false)
		self._teamTurnRight:setVisible(false)
		self._pageTipPanel:setVisible(false)
	else
		self._teamTurnRight:setVisible(self._curTabType ~= #self._teamList)
		self._teamTurnLeft:setVisible(self._curTabType ~= 1)
		self._pageTipPanel:setVisible(true)
	end

	for i = 1, #self._teamList do
		local image = i == self._curTabType and "kazu_bg_dian_2.png" or "kazu_bg_dian_1.png"

		self._pageTipPanel:getChildByTag(i):getChildByName("img"):loadTexture(image, ccui.TextureResType.plistType)

		if i == self._curTabType then
			local var_61_0 = self._pageTipPanel:getContentSize().height / 2 - 2

			if not var_61_0 then
				var_61_0 = self._pageTipPanel:getContentSize().height / 2

				local posY = var_61_0

				self._pageTipPanel:getChildByTag(i):setPositionY(posY)
			end
		end
	end
end

function StageTeamMediator:sendSpChangeTeam(callBack, ignoreTip)
	local sendData = {}
	local hasHero = false

	for k, v in pairs(self._teamPets) do
		sendData[k] = {}
		sendData[k].id = v
		hasHero = true
	end

	if not hasHero then
		table.insert(sendData, {})
	end

	local params = {
		teamType = self._stageType,
		masterId = self._curMasterId,
		heros = sendData
	}
	local hasChange = self:hasChangeTeam()

	self._stageSystem:requestSPChangeTeam(params, function()
		if DisposableObject:isDisposed(self) then
			return
		end

		if not ignoreTip and hasChange then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Team_StorageSuccessTips")
			}))
		end

		if callBack then
			callBack()
		end
	end, false, {
		ignoreTip = true
	})
end

function StageTeamMediator:sendChangeTeam(callBack)
	local hasChange = self:hasChangeTeam()
	local params = self:getSendData()

	self._stageSystem:requestChangeTeam(params, function()
		if DisposableObject:isDisposed(self) then
			return
		end

		if hasChange then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Team_StorageSuccessTips")
			}))
		end

		if callBack then
			callBack()
		end
	end, false)

	if self._stageType ~= "" then
		local teaminfo = {
			teamType = self._stageType,
			teamId = self._curTeamId
		}

		self._stageSystem:requestStageTeam(teaminfo, nil, true)
	end
end

function StageTeamMediator:onClickCardsTurnLeft()
	if not self._canChange then
		return
	end

	self._canChange = false

	performWithDelay(self:getView(), function()
		self._canChange = true
	end, 0.3)

	local function func()
		local currentType = self._curTabType

		currentType = currentType - 1

		if currentType == 0 then
			currentType = 1
		end

		self:checkTeamIsEmpty(self._teamList[currentType]:getId(), currentType)
	end

	if self:checkToExit(func, true, "Stage_Team_UI12") then
		func()
	end
end

function StageTeamMediator:onClickCardsTurnRight()
	if not self._canChange then
		return
	end

	self._canChange = false

	performWithDelay(self:getView(), function()
		self._canChange = true
	end, 0.3)

	local function func()
		local currentType = self._curTabType

		currentType = currentType + 1

		if currentType == #self._teamList + 1 then
			currentType = #self._teamList
		end

		self:checkTeamIsEmpty(self._teamList[currentType]:getId(), currentType)
	end

	if self:checkToExit(func, true, "Stage_Team_UI12") then
		func()
	end
end

function StageTeamMediator:checkTeamIsEmpty(teamId, currentType)
	local function callback()
		if DisposableObject:isDisposed(self) then
			return
		end

		self._curTabType = currentType

		self._stageSystem:setSortExtand(0)
		self:checkCardsTurnBtn()
		self:refreshView()
		self:setLeadStageInfo()
	end

	local team = self._teamList[currentType]

	if #team:getHeroes() == 0 then
		local view = self:getInjector():getInstance("ChangeTeamView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			teamId = teamId,
			callBack = callback
		}, nil))
	else
		callback()
	end
end

function StageTeamMediator:onClickOneKeyBreak()
	self._teamView:stopScroll()

	local ids = self._heroSystem:getTeamPrepared(self._teamPets, self._petList, self._recommondList)

	self._teamPets = {}
	self._petList = {}

	table.copy(ids, self._petList)
	self:refreshListView(true)
	self:refreshPetNode()
end

function StageTeamMediator:onClickFight(sender, eventType)
	if #self._teamPets < 1 then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:find("ARENA_TEMA_EMPTY")
		}))

		return false
	end

	self._fightBtn:getButton():setTouchEnabled(false)
	AudioEngine:getInstance():playEffect("Se_Click_Battle", false)

	local function func()
		local sendData = {}
		local hasHero = false

		for k, v in pairs(self._teamPets) do
			sendData[k] = {}
			sendData[k].id = v
			hasHero = true
		end

		if not hasHero then
			table.insert(sendData, {})
		end

		local data = {}

		data.heros = sendData
		data.masterId = self._curMasterId

		if self._spData.battleCallback then
			self._spData.battleCallback(data)
		end

		self._fightBtn:getButton():setTouchEnabled(true)
	end

	if self:isSpecialStage() then
		AudioTimerSystem:playStartBattleVoice(self._curTeam)
		self:sendSpChangeTeam(func, true)
	end
end

function StageTeamMediator:onClickSpDesc(sender, eventType)
	if eventType == ccui.TouchEventType.began then
		self._spPanel:getChildByName("spDescDi"):setVisible(true)
	elseif eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
		self._spPanel:getChildByName("spDescDi"):setVisible(false)
	end
end

function StageTeamMediator:onClickBack()
	local function func()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)

		storyDirector:notifyWaiting("exit_stageTeam_view")
		self:dispatch(Event:new(EVT_REFRESH_SPVIEW))
		self:dismissWithOptions({
			transition = ViewTransitionFactory:create(ViewTransitionType.kCommonAreaView)
		})
	end

	if self:checkToExit(func, false, "Stage_Team_UI10") then
		func()
	end
end

function StageTeamMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local masterSkillBtn = self._masterSkillPanel

	if masterSkillBtn then
		storyDirector:setClickEnv("StageTeam.masterSkillBtn", masterSkillBtn, function()
			self:onClickMasterSkill()

			local sequence = cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
				local skillWidget = self._skillWidget

				if skillWidget and skillWidget._descPanel then
					storyDirector:setClickEnv("StageTeam.skillWidget", skillWidget._descPanel, nil)
				end

				storyDirector:notifyWaiting("enter_stageTeam_skillWidget")
			end))

			self:getView():runAction(sequence)
		end)
	end

	local guideAgent = storyDirector:getGuideAgent()
	local scriptName = guideAgent:getCurrentScriptName()

	if guideAgent:isGuiding() and scriptName == "guide_chapterOne1_4" then
		local info_bg = self:getView():getChildByFullName("main.info_bg")

		if info_bg then
			storyDirector:setClickEnv("StageTeam.info_bg", info_bg, nil)
		end

		local guidePanel1 = self:getView():getChildByFullName("main.guidePanel1")

		if guidePanel1 then
			storyDirector:setClickEnv("StageTeam.guidePanel1", guidePanel1, nil)
		end

		local guidePanel2 = self._heroPanel

		if guidePanel2 then
			storyDirector:setClickEnv("StageTeam.guidePanel2", guidePanel2, nil)
		end

		local children = self._teamView:getContainer():getChildren()

		if children[2] and children[2]:getChildByTag(12138) then
			local card1Node = children[2]:getChildByTag(12138):getChildByFullName("myPetClone")
			local teamPet2 = self._teamBg:getChildByName("pet_2")

			if card1Node and teamPet2 then
				storyDirector:setClickEnv("StageTeam.card1Node", card1Node, function(sender, eventType)
					return self:onClickCell(card1Node, eventType, 2)
				end)
				storyDirector:setClickEnv("StageTeam.teamPet2", teamPet2, function()
					return
				end)

				function self._guildCallback()
					if self._teamPets[2] then
						storyDirector:notifyWaiting("StageTeam_endNode_dragEnd")

						self._guildCallback = nil
					end
				end
			end
		end
	end

	local teamPet5 = self._teamBg:getChildByName("pet_5")

	storyDirector:setClickEnv("StageTeam.teamPet5", teamPet5, function()
		return
	end)

	local btnBack = self:getView():getChildByFullName("topinfo_node.back_btn")

	storyDirector:setClickEnv("StageTeam.btnBack", btnBack, function(sender, eventType)
		AudioEngine:getInstance():playEffect("Se_Click_Close_1", false)
		self:onClickBack()
	end)

	local sequence = cc.Sequence:create(cc.DelayTime:create(0.001), cc.CallFunc:create(function()
		storyDirector:notifyWaiting("enter_stageTeam_view")
	end))

	self:getView():runAction(sequence)
end

function StageTeamMediator:changeTeamByMode(event)
	local teamData = event:getData()

	self:initData(teamData)
	self:refreshMasterInfo()
	self:refreshListView()
	self:refreshPetNode()

	self._hasForceChangeTeam = true

	if not self:isSpecialStage() then
		self._editBox:setText(self._nowName)
	end
end

function StageTeamMediator:onClickLimitTipsPanel()
	self._limitTips:setVisible(false)
end

function StageTeamMediator:setPowerBtnVis()
	self._powerBtn1:setVisible(next(self._limitHero) ~= nil)
	self._powerBtn:setVisible(next(self._limitHero) == nil)
end

function StageTeamMediator:onClickPowerBtn()
	if not next(self._limitHero) then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Crusade_Tips_Energy")
		}))

		return
	end

	local bagSystem = self._developSystem:getBagSystem()
	local Crusade_Energy = ConfigReader:getRecordById("ConfigValue", "Crusade_Energy").content
	local Crusade_Cost = ConfigReader:getRecordById("ConfigValue", "Crusade_CrusadeStamina_Up").content
	local curPower = bagSystem:getItemCount(Crusade_Cost.item)
	local freeNum = Crusade_Energy - self._crusadeSystem:getCrusade():getResetTimes()

	if freeNum > 0 then
		local var_92_0 = Strings:get("Crusade_Energy_Free", {
			num = Crusade_Energy
		})

		if not var_92_0 then
			var_92_0 = Strings:get("Crusade_Energy_Pay")

			local content = var_92_0
			local costText = freeNum > 0 and Strings:get("Crusade_Energy_Free_Button", {
				num = freeNum .. "/" .. Crusade_Energy
			}) or Crusade_Cost.num .. "/" .. curPower
			local outSelf, delegate = self, {}

			local function func()
				if freeNum <= 0 and curPower < Crusade_Cost.num then
					self:dispatch(ShowTipEvent({
						tip = Strings:get("Error_10223")
					}))

					return
				end

				self._crusadeSystem:requestResetCrusadePower(function()
					if checkDependInstance(self) then
						self._limitHero = self._crusadeSystem:getCrusade():getLimitHero()

						self:initData()
						self:refreshPetNode()
						self:refreshListView(true)
						self:setPowerBtnVis()
					end
				end)
			end

			function delegate:willClose(popupMediator, data)
				if data and data.response == "ok" then
					func()
				end
			end

			local data = {
				title = Strings:get("Crusade_Energy_Button"),
				content = content,
				costText = costText,
				isfree = freeNum > 0
			}
			local view = self:getInjector():getInstance("CrusadeAlertView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, data, delegate))
		end
	end
end
