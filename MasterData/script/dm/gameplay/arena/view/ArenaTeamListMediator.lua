-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/arena/view/ArenaTeamListMediator.lua

ArenaTeamListMediator = class("ArenaTeamListMediator", DmAreaViewMediator, _M)

ArenaTeamListMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
ArenaTeamListMediator:has("_arenaSystem", {
	is = "r"
}):injectWith("ArenaSystem")
ArenaTeamListMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ArenaTeamListMediator:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")

local ArenaTeamType = {
	StageTeamType.ARENA_ATK,
	StageTeamType.ARENA_DEF
}
local ArenaTeamTypeString = {
	[1] = "bd_bg_gong.png",
	[2] = "bd_bg_fang.png"
}

function ArenaTeamListMediator:initialize()
	super.initialize(self)
end

function ArenaTeamListMediator:dispose()
	super.dispose(self)
end

function ArenaTeamListMediator:onRegister()
	super.onRegister(self)

	self._heroSystem = self._developSystem:getHeroSystem()
	self._masterSystem = self._developSystem:getMasterSystem()
	self._systemKeeper = self:getInjector():getInstance(SystemKeeper)
end

function ArenaTeamListMediator:enterWithData(data)
	self:initWidgetInfo()
	self:setupTopInfoWidget()
	self:initData()
	self:initView()
	self:setupClickEnvs()
end

function ArenaTeamListMediator:resumeWithData(data)
	self:initData()
	self:refreshView()
end

function ArenaTeamListMediator:initWidgetInfo()
	self._main = self:getView():getChildByFullName("main")
	self._fightInfoTip = self._main:getChildByFullName("panel.fightInfo")

	self._fightInfoTip:setVisible(false)

	self._skillDescPanel = self:getView():getChildByFullName("skillDescPanel")

	self._skillDescPanel:setSwallowTouches(false)
	self._skillDescPanel:addClickEventListener(function()
		if self._skillDescPanel:isVisible() then
			self._skillDescPanel:setVisible(false)
		end
	end)
end

function ArenaTeamListMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("Arena_System")
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
		title = Strings:get("Stage_Team_UI6")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function ArenaTeamListMediator:initData()
	self._teamList = {}

	for i, v in ipairs(ArenaTeamType) do
		self._teamList[i] = self._developSystem:getSpTeamByType(v)
	end

	self._cellNum = #self._teamList
	self._maxTeamPetNum = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Init_DeckNum", "content") + self._developSystem:getBuildingCardEffValue()
	self._costLimit = self._stageSystem:getCostInit() + self._developSystem:getBuildingCostEffValue()
	self._lockDesc = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Init_DeckNum_Desc", "content")
	self._lockCondition = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Init_DeckNum_Condition", "content")
	self._lockBuildIdCondition = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Init_DeckNum_Building", "content")
	self._selectIndex = 0
	self._showHerosTeamId = 0
end

function ArenaTeamListMediator:initView()
	local text = self._main:getChildByFullName("text")
	local text1 = self._main:getChildByFullName("text1")
	local rankLabel = self._main:getChildByFullName("rankLabel")
	local scoreLabel = self._main:getChildByFullName("scoreLabel")

	text:setString("")
	text1:setString("")
	rankLabel:setString("")
	scoreLabel:setString("")
	self:refreshView()
end

function ArenaTeamListMediator:createTeamInfo(panel, data, index)
	local showTeam = panel:getChildByFullName("touchPanel")

	showTeam:setTouchEnabled(true)
	showTeam:addClickEventListener(function()
		self:onClickEditTeam(data:getId(), ArenaTeamType[index])
	end)
	self:createHeroes(panel, data)
end

function ArenaTeamListMediator:createMaster(data)
	local developSystem = self:getInjector():getInstance("DevelopSystem")
	local masterSystem = developSystem:getMasterSystem()
	local masterData = masterSystem:getMasterById(data:getMasterId())
	local roleModel = masterData:getModel()

	return (IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe6_1",
		id = roleModel
	}))
end

function ArenaTeamListMediator:teamCostDes(data)
	local ids = data:getHeroes()
	local totalCombat = 0
	local totalCost = 0
	local averageCost = 0
	local isShow = false

	for k, v in pairs(ids) do
		local heroInfo = self._heroSystem:getHeroById(v)

		totalCost = totalCost + heroInfo:getCost()
		totalCombat = totalCombat + heroInfo:getSceneCombatByType(SceneCombatsType.kAll)
	end

	local masterData = self._masterSystem:getMasterById(self._curMasterId)

	totalCombat = masterData and totalCombat + masterData:getCombat() or totalCombat
	averageCost = #ids == 0 and 0 or math.floor(totalCost * 10 / #ids + 0.5) / 10

	local petList = self._stageSystem:getNotOnTeamPet(data:getHeroes())

	if #ids < self._maxTeamPetNum then
		for i = 1, #petList do
			local cost = self._heroSystem:getHeroById(petList[i]):getCost()

			if totalCost + cost < self._costLimit then
				isShow = true

				break
			end
		end
	end

	return totalCost, averageCost, isShow, totalCombat
end

function ArenaTeamListMediator:createHeroes(panel, data)
	local herosList = panel:getChildByFullName("team_bg")
	local showHeros = data:getHeroes()
	local length = 10

	for i = 1, length do
		local iconPanel = herosList:getChildByFullName("pet_" .. i)

		iconPanel:removeAllChildren()

		local heroInfo = self:getHeroInfoById(showHeros[i])

		if heroInfo then
			local petNode = IconFactory:createHeroLargeIcon(heroInfo, {
				hideStar = true,
				hideName = true,
				rarityAnim = true,
				hideLevel = true
			})

			petNode:setScale(0.64)
			petNode:addTo(iconPanel):center(iconPanel:getContentSize())
			petNode:offset(0, -9)
		else
			local emptyIcon = GameStyle:createEmptyIcon(true)

			emptyIcon:addTo(iconPanel):center(iconPanel:getContentSize())

			if i > self._maxTeamPetNum then
				local condition, buildId
				local type, showAnim, unlockLevel, conditions = "", false, 0, {}
				local unlock, tips = self._buildingSystem:checkEnabled()

				if self._lockCondition[i] ~= "" then
					type, showAnim, unlockLevel, conditions = self._buildingSystem:checkByBuildLv(self._lockCondition[i], self._lockBuildIdCondition[i])
				end

				local lockTip = Strings:get(self._lockDesc[i])

				if type ~= "" and not showAnim then
					lockTip = self:getLockTip(conditions)
				elseif not unlock then
					local conditionsTemp = ConfigReader:getDataByNameIdAndKey("UnlockSystem", "Village_Building", "Condition")

					lockTip = self:getLockTip(conditionsTemp)
				end

				local tipLabel = emptyIcon:getChildByName("TipText")

				tipLabel:setString(lockTip)
			end
		end
	end
end

function ArenaTeamListMediator:getLockTip(conditions)
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

function ArenaTeamListMediator:getHeroInfoById(id)
	local heroInfo = self._heroSystem:getHeroById(id)

	if not heroInfo then
		return nil
	end

	return {
		id = id,
		rarity = heroInfo:getRarity(),
		type = heroInfo:getType(),
		cost = heroInfo:getCost(),
		roleModel = heroInfo:getModel(),
		awakenLevel = heroInfo:getAwakenStar()
	}
end

function ArenaTeamListMediator:refreshView()
	local panel = {
		self._main:getChildByFullName("panel.atackPanel"),
		self._main:getChildByFullName("panel.defendPanel")
	}

	for i, v in ipairs(ArenaTeamType) do
		self:createTeamInfo(panel[i], self._teamList[i], i)

		local data = self._teamList[i]
		local unlockPanel = panel[i]:getChildByFullName("showTeam")

		unlockPanel:getChildByFullName("teamType"):loadTexture(ArenaTeamTypeString[i], 1)
		unlockPanel:getChildByFullName("nameBg.teamName"):setString(data:getName())

		local masterPanel = unlockPanel:getChildByFullName("masterPanel")

		masterPanel:removeAllChildren()

		local master = self:createMaster(data)

		masterPanel:addChild(master)
		master:setAnchorPoint(cc.p(0, 0))
		master:setPosition(cc.p(0, 0))

		local node = cc.Node:create()

		node:addTo(masterPanel):posite(90, 50)
		node:removeAllChildren()

		local id, lv = self._masterSystem:getMasterLeadStatgeLevel(data:getMasterId())
		local icon = IconFactory:createLeadStageIconVer(id, lv, {
			needBg = 2
		})

		if icon then
			icon:addTo(node)
		end

		local limit, average, isShow, combat = self:teamCostDes(data)

		unlockPanel:getChildByFullName("redPoint"):setVisible(isShow)

		local infoBg = unlockPanel:getChildByFullName("info_bg")
		local cost1 = infoBg:getChildByFullName("cost1")
		local cost2 = infoBg:getChildByFullName("cost2")

		cost1:setString(limit)
		cost2:setString("/" .. self._costLimit)
		cost2:setPositionX(cost1:getPositionX() + cost1:getContentSize().width)

		local color = limit <= self._costLimit and cc.c3b(255, 255, 255) or cc.c3b(255, 65, 51)

		cost1:setTextColor(color)
		infoBg:getChildByFullName("averageLabel"):setString(average)

		local effectScene = ConfigReader:getDataByNameIdAndKey("ConfigValue", "LeadStage_Effective", "content")
		local effectRate = ConfigReader:getDataByNameIdAndKey("ConfigValue", "LeadStage_Effective_Rate", "content")
		local isDouble = table.indexof(effectScene, "ARENA") and table.indexof(effectScene, "ARENA") > 0 or 0
		local leadConfig = self._masterSystem:getMasterCurLeadStageConfig(data:getMasterId())

		if leadConfig then
			if not (leadConfig.LeadFightHero * (isDouble and effectRate or 1)) then
				local addPercent = 0
				local totalCombat = 0

				for k, v in pairs(data:getHeroes()) do
					local heroInfo = self._heroSystem:getHeroById(v)

					totalCombat = totalCombat + heroInfo:getSceneCombatByType(SceneCombatsType.kAll)
				end

				totalCombat = leadConfig and math.ceil((addPercent + 1) * totalCombat) or totalCombat

				local masterData = self._masterSystem:getMasterById(data:getMasterId())

				totalCombat = masterData and totalCombat + masterData:getCombat() or totalCombat

				infoBg:getChildByFullName("combatLabel"):setString(totalCombat)

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

				infoBg:getChildByFullName("combatLabel"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
					x = 0,
					y = -1
				}))

				local combatInfoBtn = unlockPanel:getChildByFullName("infoBtn")

				combatInfoBtn:setVisible(leadConfig ~= nil and addPercent > 0)
				combatInfoBtn:addTouchEventListener(function(sender, eventType)
					if not leadConfig then
						return
					end

					self._fightInfoTip:setPositionY(i == 1 and 293 or 12)

					if eventType == ccui.TouchEventType.began then
						self._fightInfoTip:removeAllChildren()

						local desc = Strings:get("LeadStage_TeamCombatInfo", {
							fontSize = 20,
							fontName = TTF_FONT_FZYH_M,
							leader = masterData:getName(),
							stage = Strings:get(leadConfig.RomanNum) .. Strings:get(leadConfig.StageName),
							percent = math.ceil(addPercent * 100) .. "%"
						})
						local richText = ccui.RichText:createWithXML(desc, {})

						richText:setAnchorPoint(cc.p(0, 0))
						richText:setPosition(cc.p(10, 10))
						richText:addTo(self._fightInfoTip)
						richText:renderContent(440, 0, true)

						local size = richText:getContentSize()

						self._fightInfoTip:setContentSize(460, size.height + 20)
						self._fightInfoTip:setVisible(true)
					elseif eventType == ccui.TouchEventType.moved then
						-- block empty
					elseif eventType == ccui.TouchEventType.canceled then
						self._fightInfoTip:setVisible(false)
					elseif eventType == ccui.TouchEventType.ended then
						self._fightInfoTip:setVisible(false)
					end
				end)
			end
		end
	end
end

function ArenaTeamListMediator:onClickEditTeam(teamId, stageType)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local view = self:getInjector():getInstance("ArenaTeamView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		teamId = teamId,
		stageType = stageType
	}))
end

function ArenaTeamListMediator:onClickBack()
	self:dismiss()
end

function ArenaTeamListMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local atackPanel = self._main:getChildByFullName("panel.atackPanel")
		local herosList = atackPanel:getChildByFullName("team_bg")
		local iconPanel2 = herosList:getChildByFullName("pet_2")

		storyDirector:setClickEnv("ArenaTeamListMediator.iconPanel2", iconPanel2, function(sender, eventType)
			self:onClickEditTeam(self._teamList[1]:getId(), ArenaTeamType[1])
		end)

		local defendPanel = self._main:getChildByFullName("panel.defendPanel")
		local herosList2 = defendPanel:getChildByFullName("team_bg")
		local pet2 = herosList2:getChildByFullName("pet_2")

		storyDirector:setClickEnv("ArenaTeamListMediator.defendPanel2", pet2, function(sender, eventType)
			self:onClickEditTeam(self._teamList[2]:getId(), ArenaTeamType[2])
		end)

		local back_btn = self._topInfoWidget:getView():getChildByFullName("back_btn")

		storyDirector:setClickEnv("ArenaTeamListMediator.back_btn", back_btn, function(sender, eventType)
			AudioEngine:getInstance():playEffect("Se_Click_Close_1", false)
			self:onClickBack()
		end)
		storyDirector:notifyWaiting("enter_ArenaTeamListMediator")
	end))

	self:getView():runAction(sequence)
end
