-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/newArena/view/ArenaNewTeamListMediator.lua

ArenaNewTeamListMediator = class("ArenaNewTeamListMediator", DmAreaViewMediator, _M)

ArenaNewTeamListMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
ArenaNewTeamListMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ArenaNewTeamListMediator:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")
ArenaNewTeamListMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
ArenaNewTeamListMediator:has("_arenaNewSystem", {
	is = "r"
}):injectWith("ArenaNewSystem")

function ArenaNewTeamListMediator:initialize()
	super.initialize(self)
end

function ArenaNewTeamListMediator:dispose()
	super.dispose(self)
end

function ArenaNewTeamListMediator:onRegister()
	super.onRegister(self)

	self._heroSystem = self._developSystem:getHeroSystem()
	self._masterSystem = self._developSystem:getMasterSystem()
	self._systemKeeper = self:getInjector():getInstance(SystemKeeper)
end

function ArenaNewTeamListMediator:enterWithData(data)
	self._rivalIndex = data.index
	self._changeAni = data.anim
	self._myHeroIds = data.myHeroIds

	self:initWidgetInfo()
	self:initData()
	self:initView()
	self:setChagneAni()
end

function ArenaNewTeamListMediator:setChagneAni()
	self._changeAniBg = self:getView():getChildByName("animNode")

	local topInfoNode = self:getView():getChildByFullName("topinfo_node")

	topInfoNode:setVisible(false)

	if self._changeAni ~= nil then
		self._main:setVisible(false)
		self._changeAni:changeParent(self._changeAniBg)
		self._changeAni:addCallbackAtFrame(20, function()
			self._main:setVisible(true)
			self:setupTopInfoWidget()
			self:runStartAction()
		end)
	else
		self:setupTopInfoWidget()
		self:runStartAction()
	end
end

function ArenaNewTeamListMediator:runStartAction()
	self._main:stopAllActions()

	local bg = self._main:getChildByFullName("bg")
	local x, y = self._main:getPosition()

	self._main:setPositionY(y - 100)

	local moveto = cc.MoveTo:create(0.26666666666666666, cc.p(x, y))
	local callFunc2 = cc.CallFunc:create(function()
		return
	end)
	local seq = cc.Sequence:create(moveto, callFunc2)

	self._main:runAction(seq)
end

function ArenaNewTeamListMediator:resumeWithData(data)
	return
end

function ArenaNewTeamListMediator:initWidgetInfo()
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

	self._starBg = self:getView():getChildByFullName("starBg")

	self._main:getChildByFullName("bg"):loadTexture("asset/scene/bd_bg_bj.jpg", ccui.TextureResType.localType)
end

function ArenaNewTeamListMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")

	topInfoNode:setVisible(true)

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
		title = Strings:get("Stage_Team_UI6")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function ArenaNewTeamListMediator:initData()
	self._teamList = {}
	self._teamList[1] = self._arenaNewSystem:getArenaNew():getRivalList()[self._rivalIndex]
	self._teamList[2] = self._developSystem:getSpTeamByType(StageTeamType.CHESS_ARENA_ATK)
	self._cellNum = #self._teamList
	self._maxTeamPetNum = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Init_DeckNum", "content") + self._developSystem:getBuildingCardEffValue()
	self._costLimit = self._stageSystem:getCostInit() + self._developSystem:getBuildingCostEffValue()
	self._lockDesc = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Init_DeckNum_Desc", "content")
	self._lockCondition = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Init_DeckNum_Condition", "content")
	self._lockBuildIdCondition = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Init_DeckNum_Building", "content")
end

function ArenaNewTeamListMediator:initView()
	self:showRivalTeam(self._teamList[1])
	self:showMyTeam(self._teamList[2])

	local effectScene = ConfigReader:getDataByNameIdAndKey("ConfigValue", "LeadStage_Effective", "content")
	local effectRate = ConfigReader:getDataByNameIdAndKey("ConfigValue", "LeadStage_Effective_Rate", "content")
	local panel = {
		self._main:getChildByFullName("panel.atackPanel"),
		self._main:getChildByFullName("panel.defendPanel")
	}

	for i = 1, 2 do
		self:createHeroes(panel[i], self._teamList[i], i)

		local unlockPanel = panel[i]:getChildByFullName("showTeam")
		local data = self._teamList[i]
		local isDouble = table.indexof(effectScene, "ChessArena")
		local leadConfig = i == 1 and self._masterSystem:getMasterLeadStatgeInfoById(data:getLeadStageId()) or self._masterSystem:getMasterCurLeadStageConfig(data:getMasterId())

		if leadConfig then
			if not (leadConfig.LeadFightHero * (isDouble and effectRate or 1)) then
				local addPercent = 0
				local combatInfoBtn = unlockPanel:getChildByFullName("infoBtn")

				combatInfoBtn:setVisible(leadConfig ~= nil and addPercent > 0)
				combatInfoBtn:addTouchEventListener(function(sender, eventType)
					if not leadConfig then
						return
					end

					self._fightInfoTip:setPositionY(i == 1 and 293 or 12)

					if eventType == ccui.TouchEventType.began then
						self._fightInfoTip:removeAllChildren()

						local name = ConfigReader:getDataByNameIdAndKey("MasterBase", data:getMasterId(), "Name")
						local desc = Strings:get("LeadStage_TeamCombatInfo", {
							fontSize = 20,
							fontName = TTF_FONT_FZYH_M,
							leader = Strings:get(name),
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

function ArenaNewTeamListMediator:showRivalTeam(data)
	local panel = self._main:getChildByFullName("panel.atackPanel")
	local unlockPanel = panel:getChildByFullName("showTeam")

	unlockPanel:getChildByFullName("nameBg.teamName"):setString(Strings:get("ClassArena_UI30"))

	local masterPanel = unlockPanel:getChildByFullName("masterPanel")

	masterPanel:removeAllChildren()

	local master = self:createMaster(data)

	masterPanel:addChild(master)
	master:setAnchorPoint(cc.p(0, 0))
	master:setPosition(cc.p(0, 0))

	local node = cc.Node:create()

	node:addTo(masterPanel):posite(90, 50)
	node:removeAllChildren()

	local icon = IconFactory:createLeadStageIconVer(data:getLeadStageId(), data:getLeadStageLevel(), {
		needBg = 2
	})

	if icon then
		icon:addTo(node)
	end

	local ids = data:getHeroes()
	local totalCost = 0
	local averageCost = 0

	for k, v in pairs(ids) do
		local heroCfg = ConfigReader:getRecordById("HeroBase", v[1])

		totalCost = totalCost + heroCfg.Cost
	end

	averageCost = #ids == 0 and 0 or math.floor(totalCost * 10 / #ids + 0.5) / 10

	local infoBg = unlockPanel:getChildByFullName("info_bg")
	local cost1 = infoBg:getChildByFullName("cost1")
	local cost2 = infoBg:getChildByFullName("cost2")

	cost1:setString(totalCost)
	cost2:setString("")
	cost2:setPositionX(cost1:getPositionX() + cost1:getContentSize().width)

	local color = totalCost <= self._costLimit and cc.c3b(255, 255, 255) or cc.c3b(255, 65, 51)

	cost1:setTextColor(color)
	infoBg:getChildByFullName("averageLabel"):setString(averageCost)

	local totalCombat = data:getCombat()

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
end

function ArenaNewTeamListMediator:showMyTeam(data)
	local panel = self._main:getChildByFullName("panel.defendPanel")
	local unlockPanel = panel:getChildByFullName("showTeam")

	unlockPanel:getChildByFullName("nameBg.teamName"):setString(Strings:get("ClassArena_UI29"))

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

	local ids = self._myHeroIds
	local totalCost = 0
	local averageCost = 0

	for k, v in pairs(ids) do
		local heroInfo = self._heroSystem:getHeroById(v)

		totalCost = totalCost + heroInfo:getCost()
	end

	averageCost = #ids == 0 and 0 or math.floor(totalCost * 10 / #ids + 0.5) / 10

	local infoBg = unlockPanel:getChildByFullName("info_bg")
	local cost1 = infoBg:getChildByFullName("cost1")
	local cost2 = infoBg:getChildByFullName("cost2")

	cost1:setString(totalCost)
	cost2:setString("/" .. self._costLimit)
	cost2:setPositionX(cost1:getPositionX() + cost1:getContentSize().width)

	local color = totalCost <= self._costLimit and cc.c3b(255, 255, 255) or cc.c3b(255, 65, 51)

	cost1:setTextColor(color)
	infoBg:getChildByFullName("averageLabel"):setString(averageCost)

	local effectScene = ConfigReader:getDataByNameIdAndKey("ConfigValue", "LeadStage_Effective", "content")
	local effectRate = ConfigReader:getDataByNameIdAndKey("ConfigValue", "LeadStage_Effective_Rate", "content")
	local isDouble = table.indexof(effectScene, "ChessArena")
	local leadConfig = self._masterSystem:getMasterCurLeadStageConfig(data:getMasterId())

	if leadConfig then
		if not (leadConfig.LeadFightHero * (isDouble and effectRate or 1)) then
			local addPercent = 0
			local totalCombat = 0

			for k, v in pairs(ids) do
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
		end
	end
end

function ArenaNewTeamListMediator:createMaster(data)
	local developSystem = self:getInjector():getInstance("DevelopSystem")
	local masterSystem = developSystem:getMasterSystem()
	local masterData = masterSystem:getMasterById(data:getMasterId())
	local roleModel = masterData:getModel()

	return (IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe6_1",
		id = roleModel
	}))
end

function ArenaNewTeamListMediator:teamCostDes(data, index)
	local ids = data:getHeroes()
	local totalCost = 0

	if index == 1 then
		for k, v in pairs(ids) do
			local heroCfg = ConfigReader:getRecordById("HeroBase", v[1])

			totalCost = totalCost + heroCfg.Cost
		end
	else
		for k, v in pairs(ids) do
			local heroInfo = self._heroSystem:getHeroById(v)

			totalCost = totalCost + heroInfo:getCost()
		end
	end

	return totalCost, #ids == 0 and 0 or math.floor(totalCost * 10 / #ids + 0.5) / 10
end

function ArenaNewTeamListMediator:createHeroes(panel, data, index)
	local herosList = panel:getChildByFullName("team_bg")
	local showHeros = data:getHeroes()
	local length = 10

	for i = 1, length do
		local iconPanel = herosList:getChildByFullName("pet_" .. i)

		iconPanel:removeAllChildren()

		local heroInfo = self:getHeroInfoById(((index == 2 or nil) and self._myHeroIds)[i], index)

		if heroInfo then
			local petNode = IconFactory:createHeroLargeIcon(heroInfo, {
				hideLevel = true,
				hideStarBg = true,
				hideName = true,
				rarityAnim = true
			})

			petNode:setScale(0.64)
			petNode:addTo(iconPanel):center(iconPanel:getContentSize())
			petNode:offset(0, -9)
		else
			local emptyIcon = GameStyle:createEmptyIcon(true)

			emptyIcon:addTo(iconPanel):center(iconPanel:getContentSize())

			if i > self._maxTeamPetNum and index == 2 then
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

		if not herosList:getChildByName("TeamNum" .. i) then
			local bg = cc.Sprite:create("asset/common/bd_bg_bhd.png")

			bg:setPosition(iconPanel:getPosition())
			bg:offset(32, -36):addTo(herosList)

			local num = cc.Label:createWithTTF(i, TTF_FONT_FZYH_M, 30)

			num:setAnchorPoint(cc.p(1, 0))
			num:setPosition(iconPanel:getPosition())
			num:addTo(herosList)
			num:offset(39, -52)
			num:enableOutline(cc.c4b(35, 15, 5, 255), 2)
			num:setName("TeamNum" .. i)
		end
	end
end

function ArenaNewTeamListMediator:getLockTip(conditions)
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

function ArenaNewTeamListMediator:getHeroInfoById(id, index)
	local heroData

	if index == 1 then
		local heroInfo = id

		if not heroInfo then
			return nil
		end

		heroData = {
			id = heroInfo[1],
			rarity = tonumber(heroInfo[5]),
			awakenLevel = tonumber(heroInfo[7]),
			star = tonumber(heroInfo[3])
		}
	else
		local heroInfo = self._heroSystem:getHeroById(id)

		if not heroInfo then
			return nil
		end

		heroData = {
			id = id,
			rarity = heroInfo:getRarity(),
			type = heroInfo:getType(),
			cost = heroInfo:getCost(),
			roleModel = heroInfo:getModel(),
			awakenLevel = heroInfo:getAwakenStar(),
			star = heroInfo:getStar()
		}
	end

	return heroData
end

function ArenaNewTeamListMediator:onClickBack()
	self:dismiss()
end
