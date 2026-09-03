-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/BuildingLvUpMediator.lua

BuildingLvUpMediator = class("BuildingLvUpMediator", DmPopupViewMediator)

BuildingLvUpMediator:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")
BuildingLvUpMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
BuildingLvUpMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
BuildingLvUpMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local clickEventMap = {
	["main.Node_bg.btn_close"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickClose"
	}
}

function BuildingLvUpMediator:initialize()
	super.initialize(self)
end

function BuildingLvUpMediator:dispose()
	if self._schedule_cd then
		LuaScheduler:getInstance():unschedule(self._schedule_cd)

		self._schedule_cd = nil
	end

	super.dispose(self)
end

function BuildingLvUpMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(clickEventMap)
end

function BuildingLvUpMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_LVUP_BUILDING_SUC, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_LVUP_CANEL_BUILDING_SUC, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_LVUP_FINISH_BUILDING_SUC, self, self.refreshView)
end

function BuildingLvUpMediator:enterWithData(data)
	self._buildingId = data.buildingId
	self._roomId = data.roomId
	self._id = data.id
	self._levelUpSta = ""

	self:setupView()
	self:refreshView()
	self:mapEventListeners()
end

function BuildingLvUpMediator:tick()
	return
end

function BuildingLvUpMediator:setupView()
	self._mainPanel = self:getView():getChildByFullName("main")

	local config = self._buildingSystem:getBuildingConfig(self._buildingId)
	local node_name = self._mainPanel:getChildByFullName("Node_bg.title_node")

	bindWidget(self, node_name, PopupNormalTitle, {
		title = Strings:get("Building_UI_LevelUp"),
		title1 = Strings:get("Building_UI_LevelUp_EN")
	})

	local text_name = self._mainPanel:getChildByFullName("Text_name")

	text_name:setString(Strings:get(config.Name))

	self._buildinglevel = self._mainPanel:getChildByFullName("level")
	self._buildinglevelDes = self._mainPanel:getChildByFullName("lvDes")
	self._buildinglevelDesNext = self._mainPanel:getChildByFullName("lvDes_next")
	self._buildinglevelNext = self._mainPanel:getChildByFullName("level_next")
	self._image_lv = self._mainPanel:getChildByFullName("Image_lv")
	self._node_building = self._mainPanel:getChildByFullName("Node_building")
	self._layout1 = self._mainPanel:getChildByFullName("layout1")
	self._layout2 = self._mainPanel:getChildByFullName("layout2")
	self._layout3 = self._mainPanel:getChildByFullName("layout3")
	self._text_lvMax = self._mainPanel:getChildByFullName("Text_lvMax")
	self._node_time = self._mainPanel:getChildByFullName("timeBg")
	self._text_timeDes = self._node_time:getChildByFullName("des")
	self._text_timeNum = self._node_time:getChildByFullName("time")

	self._node_time:setVisible(false)

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

function BuildingLvUpMediator:refreshView()
	self._levelUpSta = ""

	local buildingData = self._buildingSystem:getBuildingData(self._roomId, self._id)
	local skinId = buildingData._skinId
	local lv = buildingData._level
	local levelConfigId = buildingData._levelConfigId
	local status = buildingData._status
	local lvConfig = ConfigReader:getRecordById("VillageBuildingLevel", levelConfigId)

	if lvConfig.NextBuilding and lvConfig.NextBuilding ~= "" then
		self._node_time:setVisible(false)

		if status == KBuildingStatus.kNone then
			self._layout1:setVisible(true)
			self._layout2:setVisible(false)
			self._text_lvMax:setVisible(false)

			local nextLvConfig = ConfigReader:getRecordById("VillageBuildingLevel", lvConfig.NextBuilding) or {}

			if not nextLvConfig.BuildCondition then
				local buildCondition = {}

				if not nextLvConfig.PreBuilding then
					local preBuildingSta = {}

					if not nextLvConfig.UpDesc then
						local upDesc = ""
						local btnlevelup = self._layout1:getChildByFullName("btnlevelup.button")
						local node_des = self._layout1:getChildByFullName("Node_des")
						local lvSta = self._buildingSystem:isMeetConditions(buildCondition)
						local preSta = self._buildingSystem:getPreBuildingSta(preBuildingSta)

						node_des:setVisible(true)
						node_des:removeAllChildren()

						if lvSta and preSta then
							btnlevelup:setGray(false)
							node_des:setVisible(false)

							self._levelUpSta = ""
						else
							btnlevelup:setGray(true)
							node_des:setVisible(true)

							self._levelUpSta = Strings:get("Build_Condition_TIPS")
						end

						local infoDes = self._buildingSystem:getConditionsDesInfo(buildCondition)

						infoDes.fontName = TTF_FONT_FZYH_M
						infoDes.fontSize = 18
						infoDes.fontColor = "#FFFFFF"

						local index = 1

						for __, ___v in pairs(buildCondition) do
							for contitionKey, conditionValue in pairs(___v) do
								local conditionColorKey = "fontConditionColor" .. index

								infoDes[conditionColorKey] = self._buildingSystem:isMeetByKey(contitionKey, conditionValue) and "#AAF014" or "#f26f66"
								index = index + 1
							end
						end

						local text_condition = Strings:get(upDesc, infoDes) or ""
						local contentText = ccui.RichText:createWithXML(text_condition, {})

						contentText:setAnchorPoint(cc.p(0, 0))
						contentText:ignoreContentAdaptWithSize(true)
						contentText:rebuildElements()
						contentText:formatText()
						contentText:renderContent(260, 0)
						contentText:setPositionY(contentText:getContentSize().height / 2)
						node_des:addChild(contentText)

						local updateTime = nextLvConfig.UpgradeTime

						if updateTime > 0 then
							self._node_time:setVisible(true)
						end

						local timeD1, timeD2 = self._buildingSystem:getTimeText(updateTime)

						self._text_timeDes:setString(Strings:get("Build_Worker_TimeText"))
						self._text_timeNum:setString(timeD2)

						local sourcepanel_1 = self._layout1:getChildByFullName("sourcepanel_1")

						sourcepanel_1:getChildByFullName("costBg.costPanel.cost"):enableOutline(cc.c4b(0, 0, 0, 255), 1)
						sourcepanel_1:getChildByFullName("costBg.costPanel.costLimit"):enableOutline(cc.c4b(0, 0, 0, 255), 1)
						sourcepanel_1:getChildByFullName("costBg.cost"):enableOutline(cc.c4b(0, 0, 0, 255), 1)

						local sourcepanel_2 = self._layout1:getChildByFullName("sourcepanel_2")

						sourcepanel_2:getChildByFullName("costBg.costPanel.cost"):enableOutline(cc.c4b(0, 0, 0, 255), 1)
						sourcepanel_2:getChildByFullName("costBg.costPanel.costLimit"):enableOutline(cc.c4b(0, 0, 0, 255), 1)
						sourcepanel_2:getChildByFullName("costBg.cost"):enableOutline(cc.c4b(0, 0, 0, 255), 1)

						if not nextLvConfig.UpgradeCost then
							local upgradeCost = {}

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

								sourcepanel_1:getChildByFullName("costBg.addImg"):setVisible(false)
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

								sourcepanel_2:getChildByFullName("costBg.addImg"):setVisible(false)
							end
						end
					end
				end
			end
		else
			self._layout1:setVisible(false)
			self._layout2:setVisible(true)
			self._text_lvMax:setVisible(false)

			self._levelUpSta = ""
		end
	else
		self._layout1:setVisible(false)
		self._layout2:setVisible(false)
		self._text_lvMax:setVisible(true)
		self._buildinglevelDesNext:setVisible(false)
		self._buildinglevelNext:setVisible(false)
		self._image_lv:setVisible(false)
		self._node_time:setVisible(false)

		self._levelUpSta = ""
	end

	self._buildinglevel:setString(lv)
	self._buildinglevelNext:setString(lv + 1)

	local buildingDecorate = self:getInjector():instantiate("BuildingDecorate", {
		view = self._node_building
	})

	buildingDecorate:setBuildingInfo(self._roomId, self._buildingId, self._id)
	buildingDecorate:enterWithData()

	local skinConfig = ConfigReader:getRecordById("VillageBuildingSurface", skinId)

	if skinConfig then
		buildingDecorate:getView():setScale(skinConfig.PicScale[2])
	end

	local nodeBase_1 = self._layout3:getChildByFullName("node1")
	local nodeBase_2 = self._layout3:getChildByFullName("node2")

	nodeBase_1:setVisible(false)
	nodeBase_2:setVisible(false)

	if buildingData._type == KBuildingType.kCardAcademy then
		nodeBase_1:setVisible(true)

		local text = nodeBase_1:getChildByFullName("action")
		local text_1 = nodeBase_1:getChildByFullName("Text_1")

		text:setString(self._buildingSystem:getBuildingBuildCostBuf())
		text_1:setString(Strings:get("Building_UI_Card"))
		text:setString(self._stageSystem:getPlayerInit() + self._buildingSystem:getBuildingBuildCardBuf())

		local resImage = nodeBase_1:getChildByFullName("Image")

		resImage:setContentSize(cc.size(50, 50))
		resImage:loadTexture("chengjian_icon_lanwei.png", ccui.TextureResType.plistType)
	elseif buildingData._type == KBuildingType.kCrystalOre then
		nodeBase_1:setVisible(true)
		nodeBase_2:setVisible(true)

		local resImage = nodeBase_1:getChildByFullName("Image")

		resImage:setContentSize(cc.size(50, 50))
		resImage:loadTexture("icon_shuijing_1.png", ccui.TextureResType.plistType)

		local text_1 = nodeBase_1:getChildByFullName("action")
		local text_2 = nodeBase_2:getChildByFullName("action")
		local outNum = 0
		local limitNum = 0

		if buildingData then
			outNum, limitNum = self._buildingSystem:getSpecialEffectSta(buildingData._levelConfigId, buildingData._configId)
		end

		text_1:setString(Strings:get("Building_CRYTALRate", {
			num = math.floor(outNum)
		}))
		text_2:setString(Strings:get("Building_CRYTALStore", {
			num = math.floor(limitNum)
		}))

		local textDes_1 = nodeBase_1:getChildByFullName("Text_1")
		local textDes_2 = nodeBase_2:getChildByFullName("Text_1")

		textDes_1:setString(Strings:get("Building_TotalBenefit"))
		textDes_2:setString(Strings:get("Building_Storage"))
	elseif buildingData._type == KBuildingType.kExpOre then
		local resImage = nodeBase_1:getChildByFullName("Image")

		resImage:setContentSize(cc.size(50, 50))
		resImage:loadTexture("icon_jingyan.png", ccui.TextureResType.plistType)
		nodeBase_1:setVisible(true)
		nodeBase_2:setVisible(true)

		local text_1 = nodeBase_1:getChildByFullName("action")
		local text_2 = nodeBase_2:getChildByFullName("action")
		local outNum = 0
		local limitNum = 0

		if buildingData then
			outNum, limitNum = self._buildingSystem:getSpecialEffectSta(buildingData._levelConfigId, buildingData._configId)
		end

		text_1:setString(Strings:get("Building_EXPRate", {
			num = math.floor(outNum)
		}))
		text_2:setString(Strings:get("Building_EXPStore", {
			num = math.floor(limitNum)
		}))

		local textDes_1 = nodeBase_1:getChildByFullName("Text_1")
		local textDes_2 = nodeBase_2:getChildByFullName("Text_1")

		textDes_1:setString(Strings:get("Building_TotalBenefit"))
		textDes_2:setString(Strings:get("Building_Storage"))
	elseif buildingData._type == KBuildingType.kGoldOre then
		local resImage = nodeBase_1:getChildByFullName("Image")

		resImage:loadTexture("icon_jinbi_1.png", ccui.TextureResType.plistType)
		resImage:setContentSize(cc.size(50, 50))
		nodeBase_1:setVisible(true)
		nodeBase_2:setVisible(true)

		local text_1 = nodeBase_1:getChildByFullName("action")
		local text_2 = nodeBase_2:getChildByFullName("action")
		local outNum = 0
		local limitNum = 0

		if buildingData then
			outNum, limitNum = self._buildingSystem:getSpecialEffectSta(buildingData._levelConfigId, buildingData._configId)
		end

		text_1:setString(Strings:get("Building_GOLDRate", {
			num = math.floor(outNum)
		}))
		text_2:setString(Strings:get("Building_GOLDStore", {
			num = math.floor(limitNum)
		}))

		local textDes_1 = nodeBase_1:getChildByFullName("Text_1")
		local textDes_2 = nodeBase_2:getChildByFullName("Text_1")

		textDes_1:setString(Strings:get("Building_TotalBenefit"))
		textDes_2:setString(Strings:get("Building_Storage"))
	elseif buildingData._type == KBuildingType.kCamp then
		nodeBase_1:setVisible(true)

		local text = nodeBase_1:getChildByFullName("action")
		local text_1 = nodeBase_1:getChildByFullName("Text_1")

		text:setString(self._buildingSystem:getBuildingBuildCostBuf())
		text_1:setString(Strings:get("Building_CostLimit"))

		local resImage = nodeBase_1:getChildByFullName("Image")

		resImage:setContentSize(cc.size(50, 50))
		resImage:loadTexture("icon_bg_ka_xiyoudi_new.png", ccui.TextureResType.plistType)
		resImage:setPosition(cc.p(4, -4))
	end

	self:tick()
end

function BuildingLvUpMediator:onClickClose(sender, eventType)
	self:close()
end

function BuildingLvUpMediator:onClicklevelup(sender, eventType)
	if self._levelUpSta ~= "" then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = self._levelUpSta
		}))

		return
	end

	local buildingData = self._buildingSystem:getBuildingData(self._roomId, self._id)
	local levelConfigId = buildingData._levelConfigId
	local lvConfig = ConfigReader:getRecordById("VillageBuildingLevel", levelConfigId)
	local nextLvConfig = ConfigReader:getRecordById("VillageBuildingLevel", lvConfig.NextBuilding)
	local upgradeCost = nextLvConfig.UpgradeCost

	for k, v in pairs(upgradeCost) do
		local canbuild = CurrencySystem:checkEnoughCurrency(self, v.type, v.amount, {
			tipType = "tip"
		})

		if not canbuild then
			AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

			return
		end
	end

	if self._buildingSystem:getBuildingQueueNum() <= 0 then
		local view = self:getInjector():getInstance("BuildingQueueBuyView")
		local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		})

		self:dispatch(event)

		return
	end

	local params = {}

	params.roomId = self._roomId
	params.buildId = self._id

	self._buildingSystem:sendBuildingLvUp(params, true)
	AudioEngine:getInstance():playEffect("Se_Alert_Build", false)
end

function BuildingLvUpMediator:onClicklevelFinish(sender, eventType)
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

function BuildingLvUpMediator:onClicklevelCanel(sender, eventType)
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
