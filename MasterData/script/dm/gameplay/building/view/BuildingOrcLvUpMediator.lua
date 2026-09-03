-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/BuildingOrcLvUpMediator.lua

BuildingOrcLvUpMediator = class("BuildingOrcLvUpMediator", DmPopupViewMediator)

BuildingOrcLvUpMediator:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")
BuildingOrcLvUpMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
BuildingOrcLvUpMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local clickEventMap = {
	["main.Button_1"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickClose"
	}
}

function BuildingOrcLvUpMediator:initialize()
	super.initialize(self)

	self._buildingTab = {
		ExpOre_Normal = "Village_ExpOre_Level",
		Camp = "Village_Camp_Level",
		CrystalOre_Normal = "Village_CrystalOre_Level",
		GoldOre_Normal = "Village_GoldOre_Level"
	}
end

function BuildingOrcLvUpMediator:dispose()
	if self._schedule_cd then
		LuaScheduler:getInstance():unschedule(self._schedule_cd)

		self._schedule_cd = nil
	end

	super.dispose(self)
end

function BuildingOrcLvUpMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(clickEventMap)
end

function BuildingOrcLvUpMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_LVUP_BUILDING_SUC, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_LVUP_CANEL_BUILDING_SUC, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_LVUP_FINISH_BUILDING_SUC, self, self.refreshView)
end

function BuildingOrcLvUpMediator:enterWithData(data)
	self._buildingId = data.buildingId
	self._roomId = data.roomId
	self._id = data.id

	self:setupView()
	self:refreshView()
	self:mapEventListeners()

	self._schedule_cd = LuaScheduler:getInstance():schedule(function()
		self:tick()
	end, 1, false)
end

function BuildingOrcLvUpMediator:tick()
	local buildingData = self._buildingSystem:getBuildingData(self._roomId, self._id)
	local status = buildingData._status

	if status == KBuildingStatus.kLvUp then
		local endTime = buildingData._finishTime
		local timeNow = self._gameServerAgent:remoteTimestamp()
		local des1, des2 = self._buildingSystem:getTimeText(endTime - timeNow)

		self._text_timeNum:setString(des2)

		local cost = self._buildingSystem:getLvUpImmediatelyNum(self._roomId, self._id)
		local costNum = self._layout2:getChildByFullName("cost.costvalue1")

		costNum:setString(cost)
	end
end

function BuildingOrcLvUpMediator:setupView()
	self._mainPanel = self:getView():getChildByFullName("main")

	self:bindBackBtnFlash(self._mainPanel, cc.p(915, 485))

	self._sysBuildingConfig = self._buildingSystem:getBuildingConfig(self._buildingId)
	self._bgWidget = bindWidget(self, "main.tipNode", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get(self._sysBuildingConfig.Name),
		bgSize = {
			width = 841,
			height = 485
		}
	})
	self._buildinglevel = self._mainPanel:getChildByFullName("level")
	self._buildinglevelDes = self._mainPanel:getChildByFullName("lvDes")
	self._buildinglevelDesNext = self._mainPanel:getChildByFullName("lvDes_next")
	self._buildinglevelNext = self._mainPanel:getChildByFullName("level_next")
	self._image_lv = self._mainPanel:getChildByFullName("Image_lv")
	self._node_building = self._mainPanel:getChildByFullName("Node_building")
	self._layout1 = self._mainPanel:getChildByFullName("layout1")
	self._layout2 = self._mainPanel:getChildByFullName("layout2")
	self._text_lvMax = self._mainPanel:getChildByFullName("Text_lvMax")
	self._node_time = self._mainPanel:getChildByFullName("timeBg")
	self._text_timeDes = self._node_time:getChildByFullName("des")
	self._text_timeNum = self._node_time:getChildByFullName("time")
	self._cloneCell = self:getView():getChildByName("cloneCell")
	self._viceOrcView = self._mainPanel:getChildByName("viceOrcView")

	self._viceOrcView:setScrollBarEnabled(false)

	self._viceOrcViewSize = self._viceOrcView:getContentSize()
	self._initViceOrcView = false

	local sourcepanel_1 = self._layout1:getChildByFullName("sourcepanel_1")
	local sourcepanel_2 = self._layout1:getChildByFullName("sourcepanel_2")

	GameStyle:runCostAnim(sourcepanel_1)
	GameStyle:runCostAnim(sourcepanel_2)
	self:bindWidget("main.layout1.btnlevelup", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClicklevelup, self)
		}
	})
	self:bindWidget("main.layout2.btncancel", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClicklevelCanel, self)
		}
	})
	self:bindWidget("main.layout2.btnfinish", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClicklevelFinish, self)
		}
	})
end

function BuildingOrcLvUpMediator:refreshView()
	local buildingData = self._buildingSystem:getBuildingData(self._roomId, self._id)
	local skinId = buildingData._skinId
	local lv = buildingData._level
	local levelConfigId = buildingData._levelConfigId
	local status = buildingData._status
	local lvConfig = ConfigReader:getRecordById("VillageBuildingLevel", levelConfigId)

	if lvConfig.NextBuilding and lvConfig.NextBuilding ~= "" then
		self._node_time:setVisible(true)

		if status == KBuildingStatus.kNone then
			self._layout1:setVisible(true)
			self._layout2:setVisible(false)
			self._text_lvMax:setVisible(false)

			local buildCondition = ConfigReader:getDataByNameIdAndKey("VillageBuildingLevel", lvConfig.NextBuilding, "BuildCondition") or {}
			local preBuildingSta = ConfigReader:getDataByNameIdAndKey("VillageBuildingLevel", lvConfig.NextBuilding, "PreBuilding") or {}
			local btnlevelup = self._layout1:getChildByFullName("btnlevelup.button")
			local levelDes = self._layout1:getChildByFullName("Text_des")

			levelDes:removeAllChildren()

			local lvSta = self._buildingSystem:isMeetConditions(buildCondition)
			local preSta = self._buildingSystem:getPreBuildingSta(preBuildingSta)

			if lvSta and preSta then
				btnlevelup:setGray(false)
				btnlevelup:setTouchEnabled(true)
			else
				btnlevelup:setGray(true)
				btnlevelup:setTouchEnabled(false)

				local infoDes = self._buildingSystem:getConditionsDesInfo(buildCondition)

				infoDes.fontName = TTF_FONT_FZYH_R

				local text = Strings:get(lvConfig.UpDesc, infoDes) or ""
				local contentText = ccui.RichText:createWithXML(text, {})

				contentText:addTo(levelDes)
				contentText:setAnchorPoint(cc.p(0.5, 0.5))
				contentText:setPosition(cc.p(0, 0))
			end

			local updateTime = ConfigReader:getDataByNameIdAndKey("VillageBuildingLevel", lvConfig.NextBuilding, "UpgradeTime")
			local timeD1, timeD2 = self._buildingSystem:getTimeText(updateTime)

			self._text_timeDes:setString(Strings:get("Building_UI_UpgradeTime"))
			self._text_timeNum:setString(timeD2)

			local sourcepanel_1 = self._layout1:getChildByFullName("sourcepanel_1")
			local sourcepanel_2 = self._layout1:getChildByFullName("sourcepanel_2")
			local upgradeCost = ConfigReader:getDataByNameIdAndKey("VillageBuildingLevel", lvConfig.NextBuilding, "UpgradeCost") or {}

			sourcepanel_1:setVisible(false)

			if upgradeCost[1] then
				local costData = upgradeCost[1]

				sourcepanel_1:setVisible(true)
				sourcepanel_1:getChildByFullName("costBg.cost"):setVisible(true)
				sourcepanel_1:getChildByFullName("costBg.cost"):setString(costData.amount)

				local iconPath = ConfigReader:getDataByNameIdAndKey("ResourcesIcon", costData.type, "Sicon")
				local newIcon = ccui.ImageView:create(iconPath .. ".png", 1)
				local iconpanel = sourcepanel_1:getChildByFullName("costBg.iconpanel")

				iconpanel:addChild(newIcon)

				local size = iconpanel:getContentSize()

				newIcon:setPosition(cc.p(size.width / 2, size.height / 2))
				newIcon:setScale(0.8)

				local count = self._developSystem:getBagSystem():getItemCount(costData.type)

				if count >= costData.amount then
					sourcepanel_1:getChildByFullName("costBg.bg.enoughImg"):setVisible(true)
				else
					sourcepanel_1:getChildByFullName("costBg.bg.enoughImg"):setVisible(false)
				end
			end

			sourcepanel_2:setVisible(false)

			if upgradeCost[2] then
				local costData = upgradeCost[2]

				sourcepanel_2:setVisible(true)
				sourcepanel_2:getChildByFullName("costBg.cost"):setVisible(true)
				sourcepanel_2:getChildByFullName("costBg.cost"):setString(costData.amount)

				local iconPath = ConfigReader:getDataByNameIdAndKey("ResourcesIcon", costData.type, "Sicon")
				local newIcon = ccui.ImageView:create(iconPath .. ".png", 1)
				local iconpanel = sourcepanel_2:getChildByFullName("costBg.iconpanel")

				iconpanel:addChild(newIcon)

				local size = iconpanel:getContentSize()

				newIcon:setPosition(cc.p(size.width / 2, size.height / 2))
				newIcon:setScale(0.8)

				local count = self._developSystem:getBagSystem():getItemCount(costData.type)

				if count >= costData.amount then
					sourcepanel_2:getChildByFullName("costBg.bg.enoughImg"):setVisible(true)
				else
					sourcepanel_2:getChildByFullName("costBg.bg.enoughImg"):setVisible(false)
				end
			end
		else
			self._layout1:setVisible(false)
			self._layout2:setVisible(true)
			self._text_lvMax:setVisible(false)
			self._text_timeDes:setString(Strings:get("Building_UI_Upgrading"))
		end
	else
		self._layout1:setVisible(false)
		self._layout2:setVisible(false)
		self._text_lvMax:setVisible(true)
		self._buildinglevelDesNext:setVisible(false)
		self._buildinglevelNext:setVisible(false)
		self._image_lv:setVisible(false)
		self._node_time:setVisible(false)
	end

	self._buildinglevel:setString(lv)
	self._buildinglevelNext:setString(lv + 1)
	self:setOrcLevelInfo(buildingData, lvConfig)

	local buildingDecorate = self:getInjector():instantiate("BuildingDecorate", {
		view = self._node_building
	})

	buildingDecorate:setBuildingInfo(self._roomId, self._buildingId, self._id)
	buildingDecorate:enterWithData()

	local skinConfig = ConfigReader:getRecordById("VillageBuildingSurface", skinId)

	if skinConfig then
		buildingDecorate:getView():setScale(skinConfig.PicScale[2])
	end

	self:tick()
end

function BuildingOrcLvUpMediator:setOrcLevelInfo(buildData, lvInfo)
	self:enableViceOrcView(buildData)

	local nextOreCountNode = self._mainPanel:getChildByFullName("layout3.node1")
	local expendLevelNode = self._mainPanel:getChildByFullName("layout3.node2")
	local subOrcList = buildData._subOreList
	local curSubOrcCount = table.nums(subOrcList)

	if lvInfo.NextBuilding and lvInfo.NextBuilding ~= "" then
		local nextEffectCfg = ConfigReader:getDataByNameIdAndKey("VillageBuildingLevel", lvInfo.NextBuilding, "Factor1")
		local nextOrePoolCount = curSubOrcCount

		for k, v in ipairs(nextEffectCfg) do
			local config = ConfigReader:getRecordById("SkillSpecialEffect", v)

			if config.EffectType == SpecialEffectType.kOrePool then
				nextOrePoolCount = SpecialEffectFormula:getAddNumByConfig(config, 1, buildData._level + 1)
			end
		end

		if curSubOrcCount < nextOrePoolCount then
			local mul = nextOrePoolCount - curSubOrcCount

			nextOreCountNode:getChildByName("action"):setString(curSubOrcCount .. "+" .. mul)

			local selectImgParent = self._viceOrcView:getChildByTag(nextOrePoolCount)
			local selectImg = selectImgParent:getChildByName("select")

			selectImg:setVisible(true)
			selectImg:stopAllActions()
			selectImg:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(0.4), cc.FadeIn:create(0.4))))
		else
			nextOreCountNode:getChildByName("action"):setString(curSubOrcCount)
		end

		if self._buildingTab[lvInfo.SystemBuilding] then
			local _tabInfo = ConfigReader:getDataByNameIdAndKey("ConfigValue", self._buildingTab[lvInfo.SystemBuilding], "content")
			local cur = _tabInfo[tonumber(buildData._level)]
			local next = _tabInfo[tonumber(buildData._level + 1)]
			local num = next - cur

			if num ~= 0 then
				expendLevelNode:getChildByName("action"):setString(cur .. "+" .. num)
			else
				expendLevelNode:getChildByName("action"):setString(cur)
			end
		end
	else
		nextOreCountNode:getChildByName("action"):setString(curSubOrcCount)

		if self._buildingTab[lvInfo.SystemBuilding] then
			local _tabInfo = ConfigReader:getDataByNameIdAndKey("ConfigValue", self._buildingTab[lvInfo.SystemBuilding], "content")
			local cur = _tabInfo[tonumber(buildData._level)]

			expendLevelNode:getChildByName("action"):setString(buildData._level)
		end
	end
end

function BuildingOrcLvUpMediator:enableViceOrcView(buildData)
	if not self._initViceOrcView then
		self._viceOrcView:removeAllChildren()

		local maxLevelId = self._sysBuildingConfig.MaxLevel
		local maxLevel = ConfigReader:getDataByNameIdAndKey("VillageBuildingLevel", maxLevelId, "Level")
		local nextEffectCfg = ConfigReader:getDataByNameIdAndKey("VillageBuildingLevel", maxLevelId, "Factor1")
		local config = ConfigReader:getRecordById("SkillSpecialEffect", nextEffectCfg[1])
		local attrNum = SpecialEffectFormula:getAddNumByConfig(config, 1, maxLevel)
		local allSize = 10 + 82 * attrNum

		if allSize > self._viceOrcViewSize.width then
			self._viceOrcView:setInnerContainerSize(cc.size(allSize, self._viceOrcViewSize.height))
		else
			self._viceOrcView:setInnerContainerSize(cc.size(self._viceOrcViewSize))
		end

		local defSubOrcId = config.Parameter.ID
		local defImg = ConfigReader:getDataByNameIdAndKey("VillageSubOre", defSubOrcId, "Img")

		for i = 1, attrNum do
			local cell = self._cloneCell:clone()

			cell:addTo(self._viceOrcView):setTag(i)
			cell:setPosition(cc.p(5 + 82 * (i - 1), 5))

			local onGrayPanel = cell:getChildByName("onGray")

			onGrayPanel:setSaturation(-100)
			onGrayPanel:getChildByName("Lv"):setVisible(false)

			local buildImage = onGrayPanel:getChildByName("buildImage")

			buildImage:loadTexture("asset/ui/building/" .. defImg .. ".png", ccui.TextureResType.localType)
		end

		self._initViceOrcView = true
	end

	local subOrcList = buildData._subOreList
	local _ordersubOrcList = {}

	for k, v in pairs(subOrcList) do
		_ordersubOrcList[#_ordersubOrcList + 1] = v
	end

	table.sort(_ordersubOrcList, function(a, b)
		return a.level > b.level
	end)

	for i = 1, #_ordersubOrcList do
		local childCell = self._viceOrcView:getChildByTag(i)

		childCell:getChildByName("onGray"):setSaturation(0)

		local lvStr = childCell:getChildByFullName("onGray.Lv")

		lvStr:setVisible(true)
		lvStr:setString("Lv" .. _ordersubOrcList[i].level)

		local selectImg = childCell:getChildByName("select")

		selectImg:stopAllActions()
		selectImg:setVisible(false)

		local curLevel = _ordersubOrcList[i].levelConfigId
		local curImage = ConfigReader:getDataByNameIdAndKey("VillageSubOre", curLevel, "Img")
		local buildImage = childCell:getChildByFullName("onGray.buildImage")

		buildImage:loadTexture("asset/ui/building/" .. curImage .. ".png", ccui.TextureResType.localType)
	end
end

function BuildingOrcLvUpMediator:onClickClose(sender, eventType)
	self:close()
end

function BuildingOrcLvUpMediator:onClicklevelup(sender, eventType)
	local buildingData = self._buildingSystem:getBuildingData(self._roomId, self._id)
	local levelConfigId = buildingData._levelConfigId
	local lvConfig = ConfigReader:getRecordById("VillageBuildingLevel", levelConfigId)
	local upgradeCost = lvConfig.UpgradeCost

	for k, v in pairs(upgradeCost) do
		local canbuild = CurrencySystem:checkEnoughCurrency(self, v.type, v.amount)

		if not canbuild then
			AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

			return
		end
	end

	local params = {}

	params.roomId = self._roomId
	params.buildId = self._id

	self._buildingSystem:sendBuildingLvUp(params, true)
	AudioEngine:getInstance():playEffect("Se_Alert_Build", false)
end

function BuildingOrcLvUpMediator:onClicklevelFinish(sender, eventType)
	local cost = self._buildingSystem:getLvUpImmediatelyNum(self._roomId, self._id)

	if CurrencySystem:checkEnoughDiamond(self, cost) then
		local params = {}

		params.roomId = self._roomId
		params.buildId = self._id
		params.type = 1

		self._buildingSystem:sendBuildingLvUpFinish(params, true)
		AudioEngine:getInstance():playEffect("Se_Alert_Build", false)
	end
end

function BuildingOrcLvUpMediator:onClicklevelCanel(sender, eventType)
	local data = {
		roomId = self._roomId,
		buildingId = self._buildingId,
		id = self._id
	}
	local view = self:getInjector():getInstance("BuildingCancelCheckView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data)

	self:dispatch(event)
	AudioEngine:getInstance():playEffect("Se_Click_Cancle", false)
end
