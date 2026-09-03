-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/BuildingOverviewMediator.lua

BuildingOverviewMediator = class("BuildingOverviewMediator", DmPopupViewMediator)

BuildingOverviewMediator:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")
BuildingOverviewMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
BuildingOverviewMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
BuildingOverviewMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")

local clickEventMap = {
	["main.Node_bg.btn_close"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickClose"
	},
	["main.Button_info"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickShowTip"
	},
	["main.Node_Tip.touchLayer"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickHideTip"
	},
	["main.Node_queue.Node_close.timeBg"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickShowQueue"
	},
	["main.Node_queue.Node_open.timeBg"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickHideQueue"
	}
}

function BuildingOverviewMediator:initialize()
	super.initialize(self)
end

function BuildingOverviewMediator:dispose()
	if self._schedule_cd then
		LuaScheduler:getInstance():unschedule(self._schedule_cd)

		self._schedule_cd = nil
	end

	super.dispose(self)
end

function BuildingOverviewMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(clickEventMap)
end

function BuildingOverviewMediator:mapEventListeners()
	return
end

function BuildingOverviewMediator:enterWithData(data)
	self._roomId = data.roomId
	self._queueOpenSta = false
	self._roomNodeList = {}
	self._roomResNodeList = {}
	self._roomBuildList = {}
	self._buildNodeList = {}
	self._buildIndex = self:resetBuildList(self._roomId)

	self:setupView()
	self:initRoomShow()
	self:refreshRoomShow()
	self:refreshBuildList()
	self:refreshView()
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_LVUP_BUILDING_SUC, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_LVUP_CANEL_BUILDING_SUC, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_LVUP_FINISH_BUILDING_SUC, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_COLLECT_RESOUSE_SUC, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_COLLECT_RESOUSE_SUC, self, self.collectResSuc)

	self._schedule_cd = LuaScheduler:getInstance():schedule(function()
		self:refreshRoomShow()
		self:updateBuildList()
		self:updateBuildOperate()
		self:updateShowTip()
		self:refreshRedPoint()
		self:refreshQueue()
	end, 1, false)

	self:setupClickEnvs()
	self:addBuildingLootComponent()
	self:setupTopInfoWidget()
end

function BuildingOverviewMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("main.topinfo_node")
	local currencyInfo = {}
	local currencyInfoWidget = ConfigReader:requireDataByNameIdAndKey("UnlockSystem", "Village_Building", "ResourcesBanner")

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		title = "",
		style = 1,
		currencyInfo = currencyInfo,
		btnHandler = {}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function BuildingOverviewMediator:addBuildingLootComponent(endCallback)
	local lootComponent = cc.Node:create():addTo(self:getView(), 99999)

	self._lootComponent = self:getInjector():instantiate("BuildingLootWidget", {
		view = lootComponent
	})

	self._lootComponent:setBuildingMediator(self)
end

function BuildingOverviewMediator:setupView()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._node_tip = self._mainPanel:getChildByFullName("Node_Tip")

	self._node_tip:setVisible(false)
	self._node_tip:getChildByFullName("Node_3.Image_94"):loadTexture("asset/items/IM_ExpUp1.png")

	local buildListNode = self._mainPanel:getChildByFullName("Node_buildList")

	for i = 1, 6 do
		local buildNode = buildListNode:getChildByFullName("Panel_build_" .. i)

		self._buildNodeList[#self._buildNodeList + 1] = buildNode

		local image_bg = buildNode:getChildByFullName("Image_bg")

		image_bg:setTouchEnabled(true)
		image_bg:addClickEventListener(function()
			self:onClickSelectBuild(i)
		end)
	end

	self:bindWidget("main.Node_lvUp.button", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickLvUp, self)
		}
	})
	self:bindWidget("main.Node_lvSure.btncancel", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickBuildCanel, self)
		}
	})
	self:bindWidget("main.Node_lvSure.btnfinish", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickBuildFinish, self)
		}
	})
	self:bindWidget("main.Node_build.button", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickBuild, self)
		}
	})

	local node_name = self._mainPanel:getChildByFullName("Node_bg.title_node")

	bindWidget(self, node_name, PopupNormalTitle, {
		title = Strings:get("Building_UI_Construct"),
		title1 = Strings:get("UITitle_EN_Jianzao"),
		fontSize = getCurrentLanguage() ~= GameLanguageType.CN and 40 or nil
	})
end

function BuildingOverviewMediator:initRoomShow()
	local roomList = ConfigReader:getDataTable("VillageRoom")
	local baseRoomNode = self._mainPanel:getChildByFullName("Node_room")

	for k, v in pairs(roomList) do
		local nodeName = "Node_" .. k
		local baseNode = baseRoomNode:getChildByFullName(nodeName)

		if baseNode then
			self._roomNodeList[k] = baseNode

			local nodeIcon = baseNode:getChildByFullName("Node_icon")
			local textName = baseNode:getChildByFullName("Text_name")
			local buildList = self._buildingSystem:getBuildingResource(k, true)
			local buildConfigId = buildList[1]
			local config = self._buildingSystem:getBuildingConfig(buildConfigId)

			textName:setString(Strings:get(config.Name))

			local iamgeBuild = self:getBuildImage(k, buildConfigId)
			local scaleList = ConfigReader:getRecordById("ConfigValue", "Village_ALLSystemBuilding_Zoom").content

			iamgeBuild:setScale(scaleList[k] or 0.3)
			nodeIcon:addChild(iamgeBuild)

			local image_bg = baseNode:getChildByFullName("Image_bg")

			image_bg:setTouchEnabled(true)
			image_bg:addClickEventListener(function()
				self:onClickSelectRoom(k)
			end)

			local node_resouse = baseNode:getChildByFullName("Node_resouse")

			if node_resouse then
				local image_resouse = node_resouse:getChildByFullName("Image")
				local buildType = config.Type

				if buildType == KBuildingType.kExpOre then
					image_resouse:setContentSize(cc.size(50, 50))
					image_resouse:loadTexture("icon_jingyan.png", ccui.TextureResType.plistType)

					self._roomResNodeList[KBuildingType.kExpOre] = baseNode
				elseif buildType == KBuildingType.kGoldOre then
					image_resouse:setContentSize(cc.size(50, 50))
					image_resouse:loadTexture("asset/items/icon_jinbi_1.png", ccui.TextureResType.localType)

					self._roomResNodeList[KBuildingType.kGoldOre] = baseNode
				elseif buildType == KBuildingType.kCrystalOre then
					image_resouse:setContentSize(cc.size(50, 50))
					image_resouse:loadTexture("icon_shuijing_1.png", ccui.TextureResType.plistType)

					self._roomResNodeList[KBuildingType.kCrystalOre] = baseNode
				end

				local resouseImageBg = node_resouse:getChildByFullName("Image_bg")

				resouseImageBg:setTouchEnabled(true)
				resouseImageBg:addClickEventListener(function()
					if buildType == KBuildingType.kGoldOre then
						AudioEngine:getInstance():playEffect("Se_Click_Coin", false)
					elseif buildType == KBuildingType.kCrystalOre then
						AudioEngine:getInstance():playEffect("Se_Click_Jingsha", false)
					elseif buildType == KBuildingType.kExpOre then
						AudioEngine:getInstance():playEffect("Se_Click_Bottle", false)
					end

					self:onClickCollect()
				end)
			end
		end
	end
end

function BuildingOverviewMediator:refreshRoomShow()
	local baseRoomNode = self._mainPanel:getChildByFullName("Node_room")

	for k, v in pairs(self._roomNodeList) do
		local roomId = k
		local nodeBase = v
		local image_select = nodeBase:getChildByFullName("Image_select")

		if roomId == self._roomId then
			image_select:setVisible(true)
		else
			image_select:setVisible(false)
		end

		local node_resouse = nodeBase:getChildByFullName("Node_resouse")

		if node_resouse then
			if self._buildingSystem:getRoomCollectSta(roomId) then
				node_resouse:setVisible(true)
			else
				node_resouse:setVisible(false)
			end
		end

		local text_LvSta = nodeBase:getChildByFullName("Text_LvSta")

		if text_LvSta then
			if self._buildingSystem:getRoomLvUpSta(roomId) then
				text_LvSta:setVisible(true)
			else
				text_LvSta:setVisible(false)
			end
		end

		local image_unLock = nodeBase:getChildByFullName("Image_unlock")
		local image_lock = nodeBase:getChildByFullName("Image_lock")
		local image_sta_1 = baseRoomNode:getChildByFullName("Image_" .. roomId .. "_1")
		local image_sta_2 = baseRoomNode:getChildByFullName("Image_" .. roomId .. "_2")

		if image_sta_1 then
			image_sta_1:setVisible(true)
		end

		if image_sta_2 then
			image_sta_2:setVisible(false)
		end

		if self._buildingSystem:getRoomOpenSta(k) then
			image_unLock:setVisible(false)
			image_lock:setVisible(false)
			nodeBase:setGray(false)
			nodeBase:setOpacity(255)

			if image_sta_1 then
				image_sta_1:setVisible(false)
			end

			if image_sta_2 then
				image_sta_2:setVisible(true)
			end
		elseif self._buildingSystem:canUnlockRoom(k) then
			image_unLock:setVisible(true)
			image_lock:setVisible(false)
			nodeBase:setGray(false)
			nodeBase:setOpacity(255)
		else
			image_unLock:setVisible(false)
			image_lock:setVisible(true)
			nodeBase:setGray(true)
			nodeBase:setOpacity(140.25)
		end
	end
end

function BuildingOverviewMediator:refreshView()
	self:refreshRoomShow()
	self:updateBuildList()
	self:refrehBuildOperate()
	self:refreshBuildLvDes()
	self:refreshBuildDes()
	self:refreshRedPoint()
	self:refreshQueue()
end

function BuildingOverviewMediator:collectResSuc(event)
	local rewards = event:getData().rewards

	if not rewards then
		return
	end

	local expList = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ExpChargeItem", "content")
	local expIdList = {}

	for _, id in pairs(expList) do
		expIdList[id] = true
	end

	local function createAnim(baseNode, animName, lineGradiantVec2, lineGradiantDir, amount)
		if baseNode and animName then
			local outLineColor = cc.c4b(51, 24, 20, 219.29999999999998)
			local numLab = cc.Label:createWithTTF(amount or 0, TTF_FONT_FZYH_M, 25)

			numLab:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))
			numLab:enableOutline(outLineColor, 2)

			return numLab
		end
	end

	local expNum = 0

	for _, reward in pairs(rewards) do
		local id = reward.code
		local amount = reward.amount
		local baseNode, animName, lineGradiantVec2
		local lineGradiantDir = {
			x = 0,
			y = -1
		}
		local lootType = KBuildingType.kGoldOre

		if id == "IR_Gold" then
			lootType = KBuildingType.kGoldOre
			baseNode = self._roomResNodeList[KBuildingType.kGoldOre]
			animName = "jibi_lingquziyuan"
			lineGradiantVec2 = {
				{
					ratio = 0.3,
					color = cc.c4b(255, 255, 99, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(255, 253, 227, 255)
				}
			}
		elseif id == "IR_Crystal" then
			lootType = KBuildingType.kCrystalOre
			baseNode = self._roomResNodeList[KBuildingType.kCrystalOre]
			animName = "shuijing_lingquziyuan"
			lineGradiantVec2 = {
				{
					ratio = 0.3,
					color = cc.c4b(223, 145, 255, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(240, 227, 255, 255)
				}
			}
		elseif expIdList[id] then
			local prototype = ItemPrototype:new(id)
			local exp = prototype:getReward() and prototype:getReward()[1].amount or 1

			amount = amount * exp
			expNum = expNum + amount
		end

		if baseNode and animName then
			local numLab = createAnim(baseNode, animName, lineGradiantVec2, lineGradiantDir, amount)
			local buildWorldPos = baseNode:convertToWorldSpace(cc.p(0, 0))
			local lootWidget = self._lootComponent

			if lootWidget then
				lootWidget:dropLoot(cc.p(buildWorldPos.x, buildWorldPos.y), {
					numLab = numLab,
					type = lootType
				})
			end
		end
	end

	if expNum > 0 then
		local baseNode = self._roomResNodeList[KBuildingType.kExpOre]
		local animName = "pingzi_lingquziyuan"
		local lineGradiantVec2 = {
			{
				ratio = 0.3,
				color = cc.c4b(242, 185, 124, 255)
			},
			{
				ratio = 0.7,
				color = cc.c4b(255, 255, 227, 255)
			}
		}
		local lineGradiantDir = {
			x = 0,
			y = -1
		}

		if baseNode and animName then
			local numLab = createAnim(baseNode, animName, lineGradiantVec2, lineGradiantDir, expNum)
			local buildWorldPos = baseNode:convertToWorldSpace(cc.p(0, 0))
			local lootWidget = self._lootComponent

			if lootWidget then
				lootWidget:dropLoot(cc.p(buildWorldPos.x, buildWorldPos.y), {
					numLab = numLab,
					type = KBuildingType.kExpOre
				})
			end
		end
	end
end

function BuildingOverviewMediator:onClickClose(sender, eventType)
	self:close()
end

function BuildingOverviewMediator:onClickLvUp(sender, eventType)
	local buildData = self._roomBuildList[self._buildIndex]
	local roomId = buildData.roomId
	local id = buildData.id
	local buildingData = self._buildingSystem:getBuildingData(roomId, id)
	local levelConfigId = buildingData._levelConfigId
	local config = ConfigReader:getRecordById("VillageBuildingLevel", levelConfigId)
	local lvConfig = ConfigReader:getRecordById("VillageBuildingLevel", config.NextBuilding)

	if not lvConfig.BuildCondition then
		local buildCondition = {}
		local lvSta = self._buildingSystem:isMeetConditions(buildCondition)

		if lvSta then
			local upgradeCost = lvConfig.UpgradeCost

			for k, v in pairs(upgradeCost) do
				local canbuild = CurrencySystem:checkEnoughCurrency(self, v.type, v.amount)

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

			params.roomId = roomId
			params.buildId = id

			self._buildingSystem:sendBuildingLvUp(params, true)
			AudioEngine:getInstance():playEffect("Se_Alert_Build", false)
		else
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:get("Build_Condition_TIPS")
			}))
		end
	end
end

function BuildingOverviewMediator:onClickBuild(sender, eventType)
	local buildData = self._roomBuildList[self._buildIndex]
	local buildConfigId = buildData.buildConfigId
	local roomId = buildData.roomId
	local config = self._buildingSystem:getBuildingConfig(buildConfigId)
	local buildingLevel = config.BuildingLevel
	local lvConfig = ConfigReader:getRecordById("VillageBuildingLevel", buildingLevel)

	if not config.Condition then
		local condition = {}
		local conditionSta = self._buildingSystem:isMeetCondition(condition)

		if conditionSta then
			local upgradeCost = lvConfig.UpgradeCost

			for k, v in pairs(upgradeCost) do
				local canbuild = CurrencySystem:checkEnoughCurrency(self, v.type, v.amount)

				if not canbuild then
					AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

					return
				end
			end

			local revert = false
			local pos = self._buildingSystem:getBuildingPutPos(roomId, buildConfigId, true, revert)

			if pos then
				self._buildingSystem:dispatch(Event:new(BUILDING_BUY_PUT_TO_MAP, {
					roomId = roomId,
					buildingId = buildConfigId,
					pos = pos,
					revert = revert
				}))
			else
				AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
				self:dispatch(ShowTipEvent({
					duration = 0.5,
					tip = Strings:get("Building_Tips_PlaceFull")
				}))
			end

			self:onClickClose()
		else
			local infoDes = self._buildingSystem:getConditionDesInfo(condition)

			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:get(config.UnlockDesc, infoDes)
			}))
		end
	end
end

function BuildingOverviewMediator:onClickBuildCanel(sender, eventType)
	local buildData = self._roomBuildList[self._buildIndex]
	local buildConfigId = buildData.buildConfigId
	local roomId = buildData.roomId
	local id = buildData.id
	local data = {
		roomId = roomId,
		buildingId = buildConfigId,
		id = id
	}
	local view = self:getInjector():getInstance("BuildingCancelCheckView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data)

	self:dispatch(event)
	AudioEngine:getInstance():playEffect("Se_Click_Cancle", false)
end

function BuildingOverviewMediator:onClickBuildFinish(sender, eventType)
	local buildData = self._roomBuildList[self._buildIndex]
	local roomId = buildData.roomId
	local id = buildData.id
	local cost = self._buildingSystem:getLvUpImmediatelyNum(roomId, id)

	if CurrencySystem:checkEnoughDiamond(self, cost) then
		local params = {}

		params.roomId = roomId
		params.buildId = id
		params.type = 1

		self._buildingSystem:sendBuildingLvUpFinish(params, true)
		AudioEngine:getInstance():playEffect("Se_Alert_Build", false)
	end
end

function BuildingOverviewMediator:onClickSelectRoom(roomId)
	AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)

	if self._roomId == roomId then
		return
	end

	if self._buildingSystem:getRoomOpenSta(roomId) then
		self._roomId = roomId
		self._buildIndex = self:resetBuildList(self._roomId)

		self:refreshBuildList()
		self:refreshView()
		self:dispatch(Event:new(BUILDING_EVT_ENTER_ROOM, {
			time = 0.2,
			roomId = roomId
		}))
	elseif self._buildingSystem:canUnlockRoom(roomId) then
		self:dispatch(Event:new(BUILDING_EVT_ENTER_ROOM, {
			time = 0.2,
			roomId = roomId
		}))
		self:onClickClose()
	else
		local openState, str = self._buildingSystem:getRoomOpenSta(roomId)

		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = str
		}))
	end
end

function BuildingOverviewMediator:onClickSelectBuild(index)
	local buildData = self._roomBuildList[index]

	if buildData and (buildData.id or buildData.conditionSta) then
		AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)
	else
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
	end

	if self._buildIndex == index then
		return
	end

	self._buildIndex = index

	self:updateBuildList()
	self:refrehBuildOperate()
	self:refreshBuildLvDes()
end

function BuildingOverviewMediator:onClickCollect()
	self._buildingSystem:sendOneKeyCollectRes("overview")
end

function BuildingOverviewMediator:resetBuildList(roomId)
	local buildList = self._buildingSystem:getBuildingResource(roomId, true)
	local listAll = {}
	local list1 = {}
	local list2 = {}
	local room = self._buildingSystem:getRoom(roomId)

	for index, configId in ipairs(buildList) do
		local config = self._buildingSystem:getBuildingConfig(configId)
		local ownList = room and room:getOwnList(configId) or {}

		if not config.Amount then
			local maxNum = 1

			for i = 1, maxNum do
				if ownList[i] then
					local buildData = ownList[i]

					listAll[#listAll + 1] = {
						roomId = roomId,
						buildConfigId = configId,
						id = buildData._id
					}
				else
					local condition = config.Condition
					local conditionSta = self._buildingSystem:isMeetCondition(condition)

					if not room then
						conditionSta = false
					end

					local data = {
						roomId = roomId,
						buildConfigId = configId,
						conditionSta = conditionSta
					}

					if conditionSta then
						list1[#list1 + 1] = data
					else
						list2[#list2 + 1] = data
					end
				end
			end
		end
	end

	for k, v in ipairs(list1) do
		listAll[#listAll + 1] = v
	end

	for k, v in ipairs(list2) do
		listAll[#listAll + 1] = v
	end

	self._roomBuildList = listAll

	return 1
end

function BuildingOverviewMediator:refreshBuildList()
	for index, buildNode in ipairs(self._buildNodeList) do
		local buildData = self._roomBuildList[index]

		if buildData then
			buildNode:setVisible(true)

			local node_icon = buildNode:getChildByFullName("Node_icon")

			node_icon:removeAllChildren()

			local imageBuild = self:getBuildImage(buildData.roomId, buildData.buildConfigId, buildData.id)
			local scaleList = ConfigReader:getRecordById("ConfigValue", "Village_ALLSystemBuilding_Zoom").content
			local __scale = 1

			if self._roomId == "Room2" then
				__scale = 0.6
			end

			imageBuild:setScale((scaleList[self._roomId] or 0.3) * 0.8 * __scale)
			node_icon:addChild(imageBuild)

			local textName = buildNode:getChildByFullName("Text_name")
			local config = self._buildingSystem:getBuildingConfig(buildData.buildConfigId)

			textName:setString(Strings:get(config.Name))

			local image_lock = buildNode:getChildByFullName("Image_lock")

			if buildData.id or buildData.conditionSta then
				image_lock:setVisible(false)
			else
				image_lock:setVisible(true)
			end

			local image_lv = buildNode:getChildByFullName("Image_lv")

			if buildData.id then
				image_lv:setVisible(true)
			else
				image_lv:setVisible(false)
			end
		else
			buildNode:setVisible(false)
		end
	end

	self:updateBuildList()
	self:refrehBuildOperate()
end

function BuildingOverviewMediator:updateBuildList()
	local node_buildList = self._mainPanel:getChildByFullName("Node_buildList")
	local image_pos = node_buildList:getChildByFullName("Image_pos")

	image_pos:setVisible(false)

	for index, buildNode in ipairs(self._buildNodeList) do
		local image_select = buildNode:getChildByFullName("Image_select")
		local textName = buildNode:getChildByFullName("Text_name")

		if index == self._buildIndex then
			image_select:setVisible(true)
			image_pos:setVisible(true)
			image_pos:setPositionX(buildNode:getPositionX() + buildNode:getContentSize().width / 2)
			textName:setVisible(true)
		else
			image_select:setVisible(false)
			textName:setVisible(false)
		end

		local buildData = self._roomBuildList[index]

		if buildData and buildData.id then
			local buildingData = self._buildingSystem:getBuildingData(buildData.roomId, buildData.id)
			local buildLv = buildingData._level
			local text_level = buildNode:getChildByFullName("Image_lv.Text")

			text_level:setString(buildLv)
		end
	end
end

function BuildingOverviewMediator:refrehBuildOperate()
	local node_levelUp = self._mainPanel:getChildByFullName("Node_lvUp")
	local node_resouse = self._mainPanel:getChildByFullName("Node_resouse")
	local node_lvSure = self._mainPanel:getChildByFullName("Node_lvSure")
	local node_build = self._mainPanel:getChildByFullName("Node_build")
	local buildData = self._roomBuildList[self._buildIndex]

	if buildData and buildData.id then
		local buildingData = self._buildingSystem:getBuildingData(buildData.roomId, buildData.id)
		local timeNow = self._gameServerAgent:remoteTimestamp()
		local status = buildingData._status

		if status == KBuildingStatus.kNone then
			node_build:setVisible(false)
			node_resouse:setVisible(true)
			node_levelUp:setVisible(true)
			node_lvSure:setVisible(false)
			self:updateBuildLvUpRes(node_resouse, node_levelUp, buildData)
		else
			node_build:setVisible(false)
			node_resouse:setVisible(false)
			node_levelUp:setVisible(false)
			node_lvSure:setVisible(true)
		end
	elseif buildData then
		node_build:setVisible(true)
		node_resouse:setVisible(true)
		node_levelUp:setVisible(false)
		node_lvSure:setVisible(false)
		self:updateBuildLvUpRes(node_resouse, node_build, buildData)
	else
		node_levelUp:setVisible(false)
		node_resouse:setVisible(false)
		node_lvSure:setVisible(false)
		node_build:setVisible(false)

		local text_maxLv = self._mainPanel:getChildByFullName("Text_lvMax")

		text_maxLv:setVisible(false)
	end

	self:updateBuildOperate()
end

function BuildingOverviewMediator:updateBuildLvUpRes(nodeResouse, nodeBase, buildData)
	local id = buildData.id
	local buildConfigId = buildData.buildConfigId
	local roomId = buildData.roomId
	local text_maxLv = self._mainPanel:getChildByFullName("Text_lvMax")

	text_maxLv:setVisible(false)

	local function updataNeedRes(lvConfig)
		if not lvConfig then
			nodeResouse:setVisible(false)

			return
		end

		nodeResouse:setVisible(true)

		local sourcepanel_1 = nodeResouse:getChildByFullName("Node_1")

		sourcepanel_1:getChildByFullName("costBg.cost"):enableOutline(cc.c4b(0, 0, 0, 255), 1)

		local sourcepanel_2 = nodeResouse:getChildByFullName("Node_2")

		sourcepanel_2:getChildByFullName("costBg.cost"):enableOutline(cc.c4b(0, 0, 0, 255), 1)

		if not lvConfig.UpgradeCost then
			local upgradeCost = {}

			if upgradeCost[1] then
				local costData = upgradeCost[1]

				sourcepanel_1:setVisible(true)
				sourcepanel_1:getChildByFullName("costBg.cost"):setVisible(true)
				sourcepanel_1:getChildByFullName("costBg.cost"):setString(costData.amount)

				local iconPath = ConfigReader:getDataByNameIdAndKey("ResourcesIcon", costData.type, "Sicon")
				local newIcon = ccui.ImageView:create(iconPath .. ".png", 1)
				local iconpanel = sourcepanel_1:getChildByFullName("costBg.iconpanel")

				iconpanel:removeAllChildren()
				iconpanel:addChild(newIcon)

				local size = iconpanel:getContentSize()

				newIcon:setPosition(cc.p(size.width / 2, size.height / 2))
				newIcon:setScale(0.6)

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

				iconpanel:removeAllChildren()
				iconpanel:addChild(newIcon)

				local size = iconpanel:getContentSize()

				newIcon:setPosition(cc.p(size.width / 2, size.height / 2))
				newIcon:setScale(0.6)

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

	local function updateNeedDes(lvConfig)
		if not lvConfig then
			nodeBase:setVisible(false)

			return
		end

		nodeBase:setVisible(true)

		if not lvConfig.BuildCondition then
			local buildCondition = {}

			if not lvConfig.UpDesc then
				local upDesc = ""
				local button = nodeBase:getChildByFullName("button.button")
				local buttonBase = nodeBase:getChildByFullName("button")
				local node_des = nodeBase:getChildByFullName("Node_des")
				local bg_des = nodeBase:getChildByFullName("Image_bg")
				local lvSta = self._buildingSystem:isMeetConditions(buildCondition)

				node_des:setVisible(true)
				node_des:removeAllChildren()

				if lvSta then
					button:setGray(false)
					node_des:setVisible(false)
					bg_des:setVisible(false)
				else
					button:setGray(true)
					node_des:setVisible(true)
					bg_des:setVisible(true)

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

					contentText:setAnchorPoint(cc.p(0.5, 0.5))
					contentText:ignoreContentAdaptWithSize(true)
					contentText:rebuildElements()
					contentText:formatText()
					contentText:renderContent()
					node_des:addChild(contentText)

					local desWidth = contentText:getContentSize().width
					local bgWidth = desWidth + 46
					local btnPosX = buttonBase:getPositionX()

					bg_des:setContentSize(cc.size(bgWidth, bg_des:getContentSize().height))

					if bgWidth > 250 then
						bg_des:setPositionX(btnPosX - (bgWidth - 250) / 2)
						node_des:setPositionX(btnPosX - (bgWidth - 250) / 2)
					else
						bg_des:setPositionX(btnPosX)
						node_des:setPositionX(btnPosX)
					end
				end
			end
		end
	end

	local function updateCreateNeedDes(config)
		if not config then
			nodeBase:setVisible(false)

			return
		end

		nodeBase:setVisible(true)

		if not config.UnlockDescColor then
			local button = nodeBase:getChildByFullName("button.button")
			local buttonBase = nodeBase:getChildByFullName("button")
			local node_des = nodeBase:getChildByFullName("Node_des")
			local bg_des = nodeBase:getChildByFullName("Image_bg")

			if not config.Condition then
				local condition = {}
				local conditionSta = self._buildingSystem:isMeetCondition(condition)

				node_des:removeAllChildren()

				if conditionSta then
					button:setGray(false)
					node_des:setVisible(false)
					bg_des:setVisible(false)
				else
					button:setGray(true)
					node_des:setVisible(true)
					bg_des:setVisible(true)

					local infoDes = self._buildingSystem:getConditionDesInfo(condition)

					infoDes.fontName = TTF_FONT_FZYH_M
					infoDes.fontSize = 18
					infoDes.fontColor = "#FFFFFF"

					local index = 1

					for contitionKey, conditionValue in pairs(condition) do
						local conditionColorKey = "fontConditionColor" .. index

						infoDes[conditionColorKey] = self._buildingSystem:isMeetByKey(contitionKey, conditionValue) and "#AAF014" or "#f26f66"
						index = index + 1
					end

					local text_condition = Strings:get(config.UnlockDescColor, infoDes) or ""
					local contentText = ccui.RichText:createWithXML(text_condition, {})

					contentText:setAnchorPoint(cc.p(0.5, 0.5))
					contentText:ignoreContentAdaptWithSize(true)
					contentText:rebuildElements()
					contentText:formatText()
					contentText:renderContent()
					node_des:addChild(contentText)

					local desWidth = contentText:getContentSize().width
					local bgWidth = desWidth + 46
					local btnPosX = buttonBase:getPositionX()

					bg_des:setContentSize(cc.size(bgWidth, bg_des:getContentSize().height))

					if bgWidth > 250 then
						bg_des:setPositionX(btnPosX - (bgWidth - 250) / 2)
						node_des:setPositionX(btnPosX - (bgWidth - 250) / 2)
					else
						bg_des:setPositionX(btnPosX)
						node_des:setPositionX(btnPosX)
					end
				end
			end
		end
	end

	if id then
		local buildingData = self._buildingSystem:getBuildingData(roomId, id)
		local levelConfigId = buildingData._levelConfigId
		local config = ConfigReader:getRecordById("VillageBuildingLevel", levelConfigId)
		local lvConfig = ConfigReader:getRecordById("VillageBuildingLevel", config.NextBuilding)

		updateNeedDes(lvConfig)
		updataNeedRes(lvConfig)

		local text_timeDes = nodeBase:getChildByFullName("timeBg.des")
		local text_time = nodeBase:getChildByFullName("timeBg.time")

		nodeBase:getChildByFullName("timeBg"):setVisible(false)

		if lvConfig then
			local updateTime = lvConfig.UpgradeTime

			if updateTime > 0 then
				nodeBase:getChildByFullName("timeBg"):setVisible(true)

				local timeD1, timeD2 = self._buildingSystem:getTimeText(updateTime)

				text_timeDes:setString(Strings:get("Build_Worker_TimeText"))
				text_time:setString(timeD2)
			end
		else
			text_maxLv:setVisible(true)
		end
	else
		local config = self._buildingSystem:getBuildingConfig(buildConfigId)
		local buildingLevel = config.BuildingLevel
		local lvConfig = ConfigReader:getRecordById("VillageBuildingLevel", buildingLevel)

		updateCreateNeedDes(config)
		updataNeedRes(lvConfig)
	end
end

function BuildingOverviewMediator:updateBuildOperate()
	local buildData = self._roomBuildList[self._buildIndex]

	if buildData then
		local roomId = buildData.roomId
		local id = buildData.id

		if id then
			local buildingData = self._buildingSystem:getBuildingData(roomId, id)

			if buildingData then
				local status = buildingData._status

				if status == KBuildingStatus.kLvUp then
					local node_lvSure = self._mainPanel:getChildByFullName("Node_lvSure")
					local endTime = buildingData._finishTime
					local timeNow = self._gameServerAgent:remoteTimestamp()
					local des1, des2 = self._buildingSystem:getTimeText(endTime - timeNow)
					local text_timeNum = node_lvSure:getChildByFullName("timeBg.time")

					text_timeNum:setString(des2)

					local cost = self._buildingSystem:getLvUpImmediatelyNum(roomId, id)
					local costNum = node_lvSure:getChildByFullName("costvalue")

					costNum:setString(cost)
				end
			end
		end
	end
end

function BuildingOverviewMediator:getBuildImage(roomId, buildConfigId, id)
	local skinId = self._buildingSystem:getBuildingSkinId(roomId, buildConfigId, id)
	local skinConfig = ConfigReader:getRecordById("VillageBuildingSurface", skinId)
	local skinpath = skinConfig.Resource

	return (ccui.ImageView:create("asset/ui/building/" .. skinpath .. ".png"))
end

function BuildingOverviewMediator:refreshBuildLvDes()
	local buildData = self._roomBuildList[self._buildIndex]
	local node_lvDes = self._mainPanel:getChildByFullName("Node_lvDes")

	if buildData == nil then
		node_lvDes:setVisible(false)

		return
	end

	node_lvDes:setVisible(true)

	local buildConfigId = buildData.buildConfigId
	local roomId = buildData.roomId
	local id = buildData.id
	local buildingData = self._buildingSystem:getBuildingData(roomId, id)
	local config = self._buildingSystem:getBuildingConfig(buildConfigId)
	local buildType = config.Type
	local node_1 = node_lvDes:getChildByFullName("Node_1")
	local node_2 = node_lvDes:getChildByFullName("Node_2")
	local node_3 = node_lvDes:getChildByFullName("Node_3")

	node_1:setVisible(false)
	node_2:setVisible(false)
	node_3:setVisible(false)

	local function getNextLvConfig(levelConfigId)
		local config = ConfigReader:getRecordById("VillageBuildingLevel", levelConfigId)

		if config.NextBuilding then
			return ConfigReader:getRecordById("VillageBuildingLevel", config.NextBuilding)
		end

		return nil
	end

	local nextLvConfig
	local lvNow = 0
	local outNum = 0
	local limitNum = 0

	if buildingData then
		lvNow = buildingData._level
		outNum = buildingData:getOutput()
		limitNum = buildingData:getLimit()
		nextLvConfig = getNextLvConfig(buildingData._levelConfigId)
	else
		nextLvConfig = ConfigReader:getRecordById("VillageBuildingLevel", config.BuildingLevel)
	end

	if node_1 then
		node_1:setVisible(true)

		local text = node_1:getChildByFullName("Text")

		text:setString(Strings:get("BuildingTitle_LV"))

		local node_level = node_1:getChildByFullName("Node_lv")

		node_level:setVisible(true)

		local text_lv = node_level:getChildByFullName("Text_lv")
		local node_nextLv = node_level:getChildByFullName("Node_nextLv")

		node_nextLv:setVisible(false)
		text_lv:setString(lvNow)

		if nextLvConfig then
			node_nextLv:setVisible(true)

			local text_lv1 = node_nextLv:getChildByFullName("Text_lv")

			text_lv1:setString(nextLvConfig.Level)
		end
	end

	if buildType == KBuildingType.kCardAcademy then
		local nowCardNum = self._stageSystem:getPlayerInit() + self._buildingSystem:getBuildingBuildCardBuf()
		local nexCardtNum = 0

		if nextLvConfig then
			nexCardtNum = self._buildingSystem:getSpecialEffectSta(nextLvConfig.Id, buildConfigId) + nowCardNum

			if buildingData then
				nexCardtNum = nexCardtNum - self._buildingSystem:getSpecialEffectSta(buildingData._levelConfigId, buildConfigId)
			end
		end

		node_2:setVisible(true)

		local text = node_2:getChildByFullName("Text")

		text:setString(Strings:get("BuildingTitle_Place"))
		node_2:getChildByFullName("Text_des"):setVisible(false)

		local node_res = node_2:getChildByFullName("Node_res")

		node_res:setVisible(true)

		local textNum = node_res:getChildByFullName("Text")

		textNum:setString(nowCardNum)

		local node_nextRes = node_res:getChildByFullName("Node_next")

		node_nextRes:setVisible(false)

		if nexCardtNum > 0 then
			node_nextRes:setVisible(true)

			local text_nextNum = node_nextRes:getChildByFullName("Text")

			text_nextNum:setString(nexCardtNum)
		end
	elseif buildType == KBuildingType.kCrystalOre or buildType == KBuildingType.kExpOre or buildType == KBuildingType.kGoldOre then
		if buildingData then
			outNum, limitNum = self._buildingSystem:getSpecialEffectSta(buildingData._levelConfigId, buildConfigId)
		end

		local nextOutNum = 0
		local nextLimitNum = 0

		if nextLvConfig then
			nextOutNum, nextLimitNum = self._buildingSystem:getSpecialEffectSta(nextLvConfig.Id, buildConfigId)
		end

		node_2:setVisible(true)

		local text = node_2:getChildByFullName("Text")
		local node_res = node_2:getChildByFullName("Node_res")

		node_2:getChildByFullName("Text_des"):setVisible(false)
		node_res:setVisible(true)

		local textNum = node_res:getChildByFullName("Text")

		textNum:setString(Strings:get("Building_Rate", {
			num = outNum
		}))

		local node_nextRes = node_res:getChildByFullName("Node_next")

		node_nextRes:setVisible(false)

		if buildType == KBuildingType.kCrystalOre then
			text:setString(Strings:get("ProfitTips_Crystal"))
		elseif buildType == KBuildingType.kExpOre then
			text:setString(Strings:get("ProfitTips_Exp"))
		elseif buildType == KBuildingType.kGoldOre then
			text:setString(Strings:get("ProfitTips_Gold"))
		end

		if nextOutNum > 0 then
			node_nextRes:setVisible(true)

			local text_nextNum = node_nextRes:getChildByFullName("Text")

			text_nextNum:setString(Strings:get("Building_Rate", {
				num = nextOutNum
			}))
		end

		node_3:setVisible(true)

		local text = node_3:getChildByFullName("Text")
		local node_res = node_3:getChildByFullName("Node_res")

		node_3:getChildByFullName("Text_des"):setVisible(false)
		node_res:setVisible(true)

		local textNum = node_res:getChildByFullName("Text")

		textNum:setString(limitNum)

		local node_nextRes = node_res:getChildByFullName("Node_next")

		node_nextRes:setVisible(false)

		if buildType == KBuildingType.kCrystalOre then
			text:setString(Strings:get("BuildingTitle_Crystal_Store"))
		elseif buildType == KBuildingType.kExpOre then
			text:setString(Strings:get("BuildingTitle_Exp_Store"))
		elseif buildType == KBuildingType.kGoldOre then
			text:setString(Strings:get("BuildingTitle_Gold_Store"))
		end

		if nextLimitNum > 0 then
			node_nextRes:setVisible(true)

			local text_nextNum = node_nextRes:getChildByFullName("Text")

			text_nextNum:setString(nextLimitNum)
		end
	elseif buildType == KBuildingType.kCamp then
		local nexCosttNum = 0

		if nextLvConfig then
			nexCosttNum = self._buildingSystem:getSpecialEffectSta(nextLvConfig.Id, buildConfigId)
		end

		local nowCostNum = 0

		if buildingData then
			nowCostNum = self._buildingSystem:getSpecialEffectSta(buildingData._levelConfigId, buildConfigId)
		end

		node_2:setVisible(true)

		local text = node_2:getChildByFullName("Text")

		text:setString(Strings:get("BuildingTitle_Cost"))
		node_2:getChildByFullName("Text_des"):setVisible(false)

		local node_res = node_2:getChildByFullName("Node_res")

		node_res:setVisible(true)

		local textNum = node_res:getChildByFullName("Text")

		textNum:setString(nowCostNum)

		local node_nextRes = node_res:getChildByFullName("Node_next")

		node_nextRes:setVisible(false)

		if nexCosttNum > 0 then
			node_nextRes:setVisible(true)

			local text_nextNum = node_nextRes:getChildByFullName("Text")

			text_nextNum:setString(nexCosttNum)
		end
	elseif buildType == KBuildingType.kMainCity and nextLvConfig then
		node_2:setVisible(true)

		local text = node_2:getChildByFullName("Text")

		text:setString(Strings:get("BuildingTitle_Unlock"))
		node_2:getChildByFullName("Node_res"):setVisible(false)

		local text_des = node_2:getChildByFullName("Text_des")

		text_des:setVisible(true)
		text_des:setString(Strings:get(nextLvConfig.UnlockBuildingDesc or ""))
	end
end

function BuildingOverviewMediator:onClickHideTip(sender, eventType)
	self._node_tip:setVisible(false)
end

function BuildingOverviewMediator:onClickShowTip(sender, eventType)
	self._node_tip:setVisible(true)
	self:updateShowTip()
end

function BuildingOverviewMediator:onClickShowQueue(sender, eventType)
	self._queueOpenSta = true

	self:refreshQueue()
end

function BuildingOverviewMediator:onClickHideQueue(sender, eventType)
	self._queueOpenSta = false

	self:refreshQueue()
end

function BuildingOverviewMediator:refreshQueue()
	local node_queue = self._mainPanel:getChildByFullName("Node_queue")
	local node_close = node_queue:getChildByFullName("Node_close")
	local node_open = node_queue:getChildByFullName("Node_open")

	if self._queueOpenSta then
		node_close:setVisible(false)
		node_open:setVisible(true)

		local numLab = node_open:getChildByFullName("num")
		local num = self._buildingSystem:getBuildingQueueNum()
		local allNum = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Village_BuildingQueue_Free", "content")

		numLab:setString(num .. "/" .. allNum)

		local timeLab = node_open:getChildByFullName("time")
		local timeNow = self._gameServerAgent:remoteTimestamp()
		local timeDes = ""
		local index = 1

		for k, v in pairs(self._buildingSystem:getWorkers()) do
			local time = v / 1000 - timeNow

			if time < 0 then
				time = 0
			end

			local t1, t2 = self._buildingSystem:getTimeText(time)

			if index ~= 1 then
				timeDes = timeDes .. "/"
			end

			timeDes = timeDes .. t2
			index = index + 1
		end

		timeLab:setString(timeDes)
	else
		node_close:setVisible(true)
		node_open:setVisible(false)

		local numLab = node_close:getChildByFullName("num")
		local num = self._buildingSystem:getBuildingQueueNum()
		local allNum = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Village_BuildingQueue_Free", "content")

		numLab:setString(num .. "/" .. allNum)
	end
end

function BuildingOverviewMediator:updateShowTip()
	if self._node_tip:isVisible() then
		local allNum = self._buildingSystem:getRoomAllOutNum("Room3")

		self._node_tip:getChildByFullName("Node_1.Text"):setString((Strings:get("Building_GOLDRate", {
			num = allNum
		})))

		local allNum = self._buildingSystem:getRoomAllOutNum("Room4")

		self._node_tip:getChildByFullName("Node_2.Text"):setString((Strings:get("Building_CRYTALRate", {
			num = allNum
		})))

		local allNum = self._buildingSystem:getRoomAllOutNum("Room6")

		self._node_tip:getChildByFullName("Node_3.Text"):setString((Strings:get("Building_EXPRate", {
			num = allNum
		})))

		local allNum = self._buildingSystem:getBuildingBuildCostBuf()

		self._node_tip:getChildByFullName("Node_4.Text"):setString(allNum)

		local allNum = self._buildingSystem:getBuildingCardBuf()

		self._node_tip:getChildByFullName("Node_5.Text"):setString(allNum)
	end
end

function BuildingOverviewMediator:refreshBuildDes()
	local node_buildDes = self._mainPanel:getChildByFullName("Node_buildDes")
	local text_name = node_buildDes:getChildByFullName("Text_name")
	local panel = node_buildDes:getChildByFullName("Panel")
	local node_des = node_buildDes:getChildByFullName("Node_des")

	node_des:removeAllChildren()

	local buildData = self._roomBuildList[self._buildIndex]

	if buildData == nil then
		node_buildDes:setVisible(false)

		return
	end

	node_buildDes:setVisible(true)

	local buildConfigId = buildData.buildConfigId
	local config = self._buildingSystem:getBuildingConfig(buildConfigId)

	text_name:setString(Strings:get(config.Name))

	local desc = Strings:get(config.Desc, {
		fontSize = 18,
		fontName = TTF_FONT_FZYH_M
	})
	local contentText = ccui.RichText:createWithXML(desc, {})

	contentText:setAnchorPoint(cc.p(0, 1))
	contentText:ignoreContentAdaptWithSize(true)
	contentText:rebuildElements()
	contentText:formatText()
	contentText:renderContent(panel:getContentSize().width, 0, true)
	node_des:addChild(contentText)

	local localLanguage = getCurrentLanguage()

	if localLanguage ~= GameLanguageType.CN then
		text_name:setFontSize(32)
		text_name:setPositionY(41)
		contentText:renderContent(panel:getContentSize().width * 1.1, 65, true)
		contentText:offset(0, 35)
		contentText:setScale(0.88)
	end
end

function BuildingOverviewMediator:refreshRedPoint()
	for index, buildNode in ipairs(self._buildNodeList) do
		local redPoint = buildNode:getChildByFullName("redPoint")
		local buildData = self._roomBuildList[index]

		redPoint:setVisible(false)

		if buildData then
			if buildData.id then
				local lvSta = self._buildingSystem:getBuildingCanLvUp(buildData.roomId, buildData.id)

				if lvSta then
					redPoint:setVisible(true)
				end
			elseif buildData.conditionSta then
				local buildSta = self._buildingSystem:getBuildingBuildSta(buildData.buildConfigId, buildData.roomId)

				if buildSta then
					redPoint:setVisible(true)
				end
			end
		end
	end

	for k, v in pairs(self._roomNodeList) do
		local roomId = k
		local nodeBase = v
		local redPoint = nodeBase:getChildByFullName("redPoint")

		if self._buildingSystem:getRoomBuildLvOrBuildSta(nil, roomId) then
			redPoint:setVisible(true)
		else
			redPoint:setVisible(false)
		end
	end
end

function BuildingOverviewMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)

	for k, v in pairs(self._roomNodeList) do
		local key = "BuildingOverview." .. k

		if v then
			storyDirector:setClickEnv(key, v, function(sender, eventType)
				self:onClickSelectRoom(k)
			end)
		end
	end

	for index, buildNode in ipairs(self._buildNodeList) do
		local buildNode = buildNode:getChildByFullName("Image_select")

		storyDirector:setClickEnv("BuildingOverview.buildNode" .. index, buildNode, function(sender, eventType)
			self:onClickSelectBuild(index)
		end)
	end

	local buildBtn = self._mainPanel:getChildByFullName("Node_build.button")

	if buildBtn then
		storyDirector:setClickEnv("BuildingOverview.buildBtn", buildBtn, function(sender, eventType)
			self:onClickBuild()
		end)
	end

	local lvupBtn = self._mainPanel:getChildByFullName("Node_lvUp.button")

	if lvupBtn then
		storyDirector:setClickEnv("BuildingOverview.lvupBtn", lvupBtn, function(sender, eventType)
			self:onClickLvUp()
		end)
	end

	storyDirector:notifyWaiting("enter_buildingOver_view")
end

function BuildingOverviewMediator:getLoopWordPos(loopType)
	local topInfoWidget = self._topInfoWidget

	if topInfoWidget then
		if loopType == KBuildingType.kGoldOre then
			local node = topInfoWidget:getView():getChildByFullName("currency_bar_4")
			local worldPos = node:convertToWorldSpace(cc.p(0, 0))

			return cc.p(worldPos.x - 163, worldPos.y - 24)
		elseif loopType == KBuildingType.kCrystalOre then
			local node = topInfoWidget:getView():getChildByFullName("currency_bar_3")
			local worldPos = node:convertToWorldSpace(cc.p(0, 0))

			return cc.p(worldPos.x - 163, worldPos.y - 24)
		elseif loopType == KBuildingType.kExpOre then
			local worldPos = self._buildingSystem:getBagWorldPos() or cc.p(0, 0)

			return cc.p(worldPos.x, worldPos.y)
		end
	end
end
