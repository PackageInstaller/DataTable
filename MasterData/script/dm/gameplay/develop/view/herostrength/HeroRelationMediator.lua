-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/HeroRelationMediator.lua

HeroRelationMediator = class("HeroRelationMediator", DmPopupViewMediator, _M)

HeroRelationMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
HeroRelationMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
HeroRelationMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")

local kBtnHandlers = {
	["main.arrownode.leftbtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onLeftClicked"
	},
	["main.arrownode.rightbtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onRightClicked"
	},
	["main.sharebtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickShare"
	},
	["main.sharenode.clubbtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickClubShare"
	},
	["main.sharenode.worldbtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickWorldShare"
	},
	backBtn = {
		clickAudio = "Se_Click_Close_1",
		func = "onClickBack"
	}
}
local kRelationWidgetPos = {
	cc.p(360, 172),
	cc.p(711, 172),
	cc.p(360, 56),
	cc.p(711, 56),
	cc.p(360, 292),
	cc.p(595, 292),
	cc.p(829, 292),
	cc.p(360, 436)
}

function HeroRelationMediator:initialize()
	super.initialize(self)
end

function HeroRelationMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function HeroRelationMediator:adjustLayout(targetFrame)
	super.adjustLayout(self, targetFrame)
end

function HeroRelationMediator:dispose()
	super.dispose(self)
end

function HeroRelationMediator:enterWithData(data)
	self:initNodes()
	self:refreshData(data.heroId)
	self:createRelationView()
	self:refreshView()
	self:createMapEvent()
end

function HeroRelationMediator:createMapEvent()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_HERORELATION_LEVELUP_SUCC, self, self.refreshView)
end

function HeroRelationMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._relationNode = self._mainPanel:getChildByFullName("relationnode")

	self._relationNode:setLocalZOrder(1)

	self._shareNode = self._mainPanel:getChildByFullName("sharenode")

	self._shareNode:setVisible(false)
	self._shareNode:setLocalZOrder(22)

	self._leftBtn = self._mainPanel:getChildByFullName("arrownode.leftbtn")
	self._rightBtn = self._mainPanel:getChildByFullName("arrownode.rightbtn")

	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()
	local touchLayer = ccui.Layout:create()

	touchLayer:setContentSize(cc.size(winSize.width, winSize.height))
	touchLayer:setTouchEnabled(true)
	touchLayer:addClickEventListener(function()
		self:onCloseShareClicked()
	end)
	touchLayer:addTo(self._mainPanel, 10):center(self._mainPanel:getContentSize())

	self._touchLayer = touchLayer

	self._touchLayer:setVisible(false)
	GameStyle:setGreenCommonEffect(self._mainPanel:getChildByFullName("sharenode.clubbtn.text"))
	GameStyle:setGreenCommonEffect(self._mainPanel:getChildByFullName("sharenode.worldbtn.text"))
end

function HeroRelationMediator:refreshArrowState()
	return
end

function HeroRelationMediator:refreshData(heroId)
	local developSystem = self:getInjector():getInstance("DevelopSystem")

	self._player = developSystem:getPlayer()
	self._bagSystem = developSystem:getBagSystem()
	self._heroSystem = developSystem:getHeroSystem()
	self._heroId = heroId or self._heroId
	self._heroPro = PrototypeFactory:getInstance():getHeroPrototype(heroId)
	self._heroData = self._heroSystem:getHeroById(heroId)
	self._heroConfig = ConfigReader:getRecordById("HeroBase", tostring(heroId))
	self._idList = self._heroSystem:getOwnHeroIds()

	for i = 1, #self._idList do
		if self._idList[i].id == self._heroId then
			self._curIdIndex = i

			break
		end
	end

	self._relationList = self._heroData:getRelationList()
	self._relationArr = self._relationList:getRelationArr()
end

function HeroRelationMediator:refreshView()
	self:refreshHeroInfoWidget()
	self._mainPanel:getChildByFullName("sharebtn"):setVisible(self._systemKeeper:canShow("Chat_System"))
	self:refreshArrowState()

	for i = 1, #self._relationArr do
		local relationData = self._relationArr[i]

		self:updateRelationByIndex(i, relationData:getLevel(), relationData:getLockState(), relationData)
	end
end

function HeroRelationMediator:createRelationView()
	self._relationNode:removeAllChildren(true)

	self._relationCahce = {}

	local injector = self:getInjector()

	local function upCallBack()
		for index = 1, #self._relationArr do
			local widget = self._relationCahce[index]

			if widget then
				local relationData = self._relationArr[index]
				local factor1 = widget.lockState ~= relationData:getLockState()
				local factor2 = widget.level ~= relationData:getLevel()

				if factor1 or factor2 then
					self:updateRelationByIndex(index, relationData:getLevel(), relationData:getLockState(), relationData)
				end
			end
		end
	end

	for i = 1, #self._relationArr do
		local relationId = self._relationArr[i]:getId()
		local relationData = self._relationArr[i]
		local config = ConfigReader:getRecordById("HeroRelation", tostring(relationId))

		if config.Type ~= RelationType.kEquip then
			local widget = self:autoManageObject(injector:injectInto(RelationInfoWidget:new(RelationInfoWidget:createWidgetNode(), {
				index = i,
				config = config,
				clickInfoFunc = function(index)
					AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

					local view = self:getInjector():getInstance("RelationInfoTipView")

					self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
						index = index,
						heroId = self._heroId
					}))
				end,
				clickUpFunc = function(index, anim)
					AudioEngine:getInstance():playEffect("Se_Click_Active_Team", false)

					relationId = self._relationArr[index]:getId()
					relationData = self._relationArr[index]

					local function func()
						upCallBack()
					end

					if relationData:getLevel() == 0 then
						self._heroSystem:requestRelationUnlock(self._heroId, relationId, index, func)
					else
						self._heroSystem:requestRelationLvlUp(self._heroId, relationId, index, func)
					end
				end
			})))

			widget:getView():addTo(self._relationNode, 999)
			widget:getView():setPosition(kRelationWidgetPos[i])

			self._relationCahce[i] = widget

			self:updateRelationByIndex(i, relationData:getLevel(), relationData:getLockState(), relationData)
		end
	end
end

function HeroRelationMediator:updateRelationByIndex(index, level, lockState, relationData)
	local config = relationData:getConfig()

	if config.Type == RelationType.kEquip then
		return
	end

	local widget = self._relationCahce[index]

	widget.lockState = lockState
	widget.level = level

	local data = {
		config = config
	}

	if config.Type == RelationType.kHero then
		data.heroes = {}

		local relationList = config.RelationList

		for i = 1, #relationList do
			local heroId = relationList[i]
			local heroData = {
				star = 0,
				id = heroId
			}
			local hasHero = self._heroSystem:hasHero(heroId)

			if hasHero then
				local hero = self._heroSystem:getHeroById(heroId)

				heroData.star = hero:getStar()
			end

			data.heroes[#data.heroes + 1] = heroData
		end
	elseif config.Type == RelationType.kGlobal then
		local unlockNum = 0
		local relationList = self._heroData:getRelationList()
		local lists = relationData:getRelationTargets()

		for i = 1, #lists do
			local id = lists[i]
			local dataRes = relationList:getRelationById(id)

			if dataRes:getLevel() ~= 0 then
				unlockNum = unlockNum + 1
			end
		end

		data.unlockNum = unlockNum
	end

	widget:updateView(level, lockState, data)
end

function HeroRelationMediator:refreshHeroInfoWidget()
	if not self._heroNode then
		local injector = self:getInjector()

		self._heroNode = self._mainPanel:getChildByFullName("heronode")
		self._heroInfoWidget = self:autoManageObject(injector:injectInto(RelationHeroWidget:new(self._heroNode)))
	end

	self._heroInfoWidget:updateRoleInfo({
		id = self._heroId,
		quality = self._heroData:getQuality(),
		star = self._heroData:getStar(),
		rariety = self._heroData:getRarity(),
		qualityLevel = self._heroData:getQualityLevel(),
		cost = self._heroData:getCost(),
		name = self._heroData:getName(),
		combat = self._heroData:getSceneCombatByType(SceneCombatsType.kAll)
	})
end

function HeroRelationMediator:onClickBack(sender, eventType)
	self:close()
end

function HeroRelationMediator:onClickShare(sender, eventType)
	self._shareNode:setVisible(not self._shareNode:isVisible())
	self._touchLayer:setVisible(true)
end

function HeroRelationMediator:onClickClubShare(sender, eventType)
	local club = self._developSystem:getPlayer():getClub():getInfo():getClubId()

	if club and club ~= "" then
		local function callback()
			self._heroSystem:getShareCDTime().clubShare = TimeUtil:timeByLocalDate()

			self._heroSystem:shareHeroRelation(self._heroId, ChatTabType.kUnion)
		end

		if not self._heroSystem:getShareCDTime().clubShare then
			callback()
		else
			local curTime = TimeUtil:timeByLocalDate()

			if curTime - self._heroSystem:getShareCDTime().clubShare < 60 then
				self:dispatch(ShowTipEvent({
					tip = Strings:get("HEROS_UI51")
				}))
			else
				callback()
			end
		end
	else
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Club_Text114")
		}))
	end
end

function HeroRelationMediator:onClickWorldShare(sender, eventType)
	local function callback()
		self._heroSystem:getShareCDTime().worldShare = TimeUtil:timeByLocalDate()

		self._heroSystem:shareHeroRelation(self._heroId, ChatTabType.kWorld)
	end

	if not self._heroSystem:getShareCDTime().worldShare then
		callback()
	else
		local curTime = TimeUtil:timeByLocalDate()

		if curTime - self._heroSystem:getShareCDTime().worldShare < 60 then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("HEROS_UI51")
			}))
		else
			callback()
		end
	end
end

function HeroRelationMediator:onCloseShareClicked()
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self._shareNode:setVisible(false)
	self._touchLayer:setVisible(false)
end

function HeroRelationMediator:onLeftClicked(sender, eventType)
	self._curIdIndex = self._curIdIndex - 1

	if self._curIdIndex < 1 then
		self._curIdIndex = #self._idList
	end

	local heroId = self._idList[self._curIdIndex].id

	self._heroSystem:setUiSelectHeroId(heroId)
	self:dispatch(Event:new(EVT_HEROES_REFRESH_ID))
	self:refreshData(heroId)
	self:refreshView()
end

function HeroRelationMediator:onRightClicked(sender, eventType)
	self._curIdIndex = self._curIdIndex + 1

	if self._curIdIndex > #self._idList then
		self._curIdIndex = 1
	end

	local heroId = self._idList[self._curIdIndex].id

	self._heroSystem:setUiSelectHeroId(heroId)
	self:dispatch(Event:new(EVT_HEROES_REFRESH_ID))
	self:refreshData(heroId)
	self:refreshView()
end
