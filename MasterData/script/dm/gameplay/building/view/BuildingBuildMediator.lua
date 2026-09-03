-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/BuildingBuildMediator.lua

BuildingBuildMediator = class("BuildingBuildMediator", DmPopupViewMediator)

BuildingBuildMediator:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")

local kCellWidth, kCellHeight = 260, 350
local kBtnHandlers = {
	button_back = {
		clickAudio = "Se_Click_Close_2",
		func = "onBackClicked"
	},
	["Node_comfort.btn_showTip1"] = {
		clickAudio = "Se_Click_Fold_1",
		func = "onClickShowComfortTip"
	},
	["Node_comfort.btn_showTip2"] = {
		clickAudio = "Se_Click_Fold_1",
		func = "onClickShowComfortTip"
	},
	["Node_comfort.Node_tips.Panel_touch"] = {
		clickAudio = "Se_Click_Fold_1",
		func = "onClickHideComfortTip"
	}
}
local kTab_button_width = 140

function BuildingBuildMediator:initialize()
	super.initialize(self)
end

function BuildingBuildMediator:dispose()
	super.dispose(self)
end

function BuildingBuildMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function BuildingBuildMediator:enterWithData(data)
	self._roomId = data.roomId
	self._buildButtonTypeList = {}

	if not self._buildingSystem:getRoomOpenSta(self._roomId) then
		self._roomId = self._buildingSystem:getFristRoomId()

		self:dispatch(Event:new(BUILDING_ROOM_MOVE, {
			time = 0.1,
			roomId = self._roomId
		}))
	end

	self._showType = data.showType or 1

	if self._showType == 1 then
		self._buildButtonTypeList[1] = KBuildingBuildType.kDecorate
		self._buildButtonType = KBuildingBuildType.kResource
	else
		self._buildButtonTypeList[1] = KBuildingBuildType.kDecorate
	end

	self._buildButtonType = self._buildButtonTypeList[1]
	self._curTabType = 1
	self._buildingList = {}

	self:setupView()
	self:createTableView()
	self:createTabControl()
	self:createBuildTypeBtn()
	self:refreshView()
	self:resetBuildingList()
	self:refreshBuildTypeBtn()
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_BUY_PUT_TO_MAP, self, self.close)
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_WAREHOUSE_TO_MAP, self, self.close)
	self:setupClickEnvs()
end

function BuildingBuildMediator:setupView()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._tabpanel = self._mainPanel:getChildByFullName("tabpanel")
	self._node_BuildBtn = self._mainPanel:getChildByFullName("Node_buildBtn")
	self._tabBuildBtn = self._mainPanel:getChildByFullName("Panel_tabBuildBtn")
	self._nodeNone = self._mainPanel:getChildByFullName("Node_none")
	self._bg_bx = self._mainPanel:getChildByFullName("bg_bx")

	self._nodeNone:setVisible(false)
	self._bg_bx:setVisible(true)

	local node_money = self:getView():getChildByFullName("Node_money")
	local bgNode = self._mainPanel:getChildByFullName("node_bg")

	if self._showType == 1 then
		local var_5_0 = bindWidget
		local var_5_1 = self
		local var_5_2 = bgNode
		local var_5_3 = PopupNormalTabWidget
		local var_5_4 = {
			fontSize = 35,
			btnHandler = {
				clickAudio = "Se_Click_Close_2",
				func = bind1(self.onBackClicked, self)
			},
			title = Strings:get("Building_UI_Decorate1")
		}

		var_5_4.title1 = getCurrentLanguage() ~= GameLanguageType.CN and "" or Strings:get("UITitle_EN_Zhuangshi")

		var_5_0(var_5_1, var_5_2, var_5_3, var_5_4)
		node_money:setVisible(true)

		local currencyInfoWidget = ConfigReader:getDataByNameIdAndKey("ConfigValue", "VillageDecorateShopIcon", "content") or {}

		for i = 1, #currencyInfoWidget do
			local id = currencyInfoWidget[i]
			local ownCount = CurrencySystem:getCurrencyCount(self._buildingSystem, id) or 0
			local nodeInfo = node_money:getChildByFullName("Image_" .. i)
			local image = nodeInfo:getChildByFullName("Image")
			local text_num = nodeInfo:getChildByFullName("Text_num")

			image:setContentSize(cc.size(36, 36))

			local numDes, huge = CurrencySystem:formatCurrency(ownCount)

			if huge then
				numDes = numDes and tostring(numDes) .. Strings:get("Common_Time_01")
			end

			text_num:setString(numDes or 0)

			local iconPath = ConfigReader:getDataByNameIdAndKey("ResourcesIcon", id, "Sicon")

			if iconPath and iconPath ~= "" then
				image:loadTexture(iconPath .. ".png", ccui.TextureResType.plistType)
			else
				iconPath = ConfigReader:getDataByNameIdAndKey("ItemConfig", id, "Icon")

				if iconPath and iconPath ~= "" then
					local path = "asset/items/" .. iconPath .. ".png"

					image:loadTexture(path, ccui.TextureResType.localType)
				end
			end
		end
	elseif self._showType == 2 then
		local var_5_5 = bindWidget
		local var_5_6 = self
		local var_5_7 = bgNode
		local var_5_8 = PopupNormalTabWidget
		local var_5_9 = {
			fontSize = 35,
			btnHandler = {
				clickAudio = "Se_Click_Close_2",
				func = bind1(self.onBackClicked, self)
			},
			title = Strings:get("Building_UI_StoreRoom")
		}

		var_5_9.title1 = getCurrentLanguage() ~= GameLanguageType.CN and "" or Strings:get("UITitle_EN_Cangku")

		var_5_5(var_5_6, var_5_7, var_5_8, var_5_9)
		node_money:setVisible(false)
	end

	self:getView():getChildByFullName("main.Text"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
end

function BuildingBuildMediator:createBuildTypeBtn()
	self._buildTypeBtnList = {}

	for k, v in pairs(self._buildButtonTypeList) do
		local panelNew = self._tabBuildBtn:clone()

		self._node_BuildBtn:addChild(panelNew)
		panelNew:setPosition((k - 1) * kTab_button_width, 0)
		panelNew:setName(v)

		local name = v
		local button = panelNew:getChildByFullName("Button")
		local textName = panelNew:getChildByFullName("name")

		if v == KBuildingBuildType.kResource then
			textName:setString(Strings:get("Building_Title_System"))
		elseif v == KBuildingBuildType.kDecorate then
			textName:setString(Strings:get("Building_UI_Decorate"))
		end

		button:addClickEventListener(function()
			self:onClickBuildType(name)
		end)

		self._buildTypeBtnList[v] = button
	end
end

function BuildingBuildMediator:onClickBuildType(name)
	if self._buildButtonType ~= name then
		self._buildButtonType = name

		self:refreshBuildTypeBtn()
		self:resetBuildingList()
	end
end

function BuildingBuildMediator:refreshBuildTypeBtn()
	local children = self._node_BuildBtn:getChildren()

	for index = 1, #children do
		local child = children[index]
		local image1 = child:getChildByFullName("Image_1")
		local image2 = child:getChildByFullName("Image_2")

		image1:setVisible(true)
		image2:setVisible(false)

		if child:getName() == self._buildButtonType then
			image1:setVisible(false)
			image2:setVisible(true)
		end
	end
end

function BuildingBuildMediator:onBackClicked(sender, eventType)
	self:close()
end

function BuildingBuildMediator:refreshView()
	self:refreshComfort()
end

function BuildingBuildMediator:createTabControl()
	local roomIdList = self._buildingSystem:getSortRoomIdList("PutSort", self._showType)

	self._tabBtnControl = roomIdList

	for k, v in pairs(roomIdList) do
		if v == self._roomId then
			self._curTabType = k
		end
	end

	if #roomIdList > 0 then
		local config = {
			onClickTab = function(name, tag)
				self:onClickTab(name, tag)
			end
		}
		local data = {}

		for i = 1, #roomIdList do
			local textdes = ConfigReader:getDataByNameIdAndKey("VillageRoom", roomIdList[i], "Name") or "Room_Store_Name"
			local textdes1 = ConfigReader:getDataByNameIdAndKey("VillageRoom", roomIdList[i], "ENName") or "UITitle_EN_Room_Store"

			data[#data + 1] = {
				tabText = Strings:get(textdes),
				tabTextTranslate = Strings:get(textdes1)
			}
		end

		config.btnDatas = data

		local injector = self:getInjector()
		local widget = TabBtnWidget:createWidgetNode()

		self._tabBtnWidget = self:autoManageObject(injector:injectInto(TabBtnWidget:new(widget)))

		self._tabBtnWidget:adjustScrollViewSize(0, 470)
		self._tabBtnWidget:initTabBtn(config, {
			ignoreSound = true,
			noCenterBtn = true,
			ignoreRedSelectState = true
		})
		self._tabBtnWidget:selectTabByTag(self._curTabType)
		self._tabBtnWidget:removeTabBg()

		local view = self._tabBtnWidget:getMainView()

		view:addTo(self._tabpanel):posite(0, 0)
		view:setLocalZOrder(1100)
	end
end

function BuildingBuildMediator:onClickTab(name, selectTag)
	if self._curTabType ~= selectTag then
		AudioEngine:getInstance():playEffect("Se_Click_Tab_1", false)

		self._curTabType = selectTag
		self._roomId = self._tabBtnControl[selectTag]

		self:resetBuildingList()
		self:refreshView()
		self:dispatch(Event:new(BUILDING_ROOM_MOVE, {
			time = 0.1,
			roomId = self._roomId
		}))
	end
end

function BuildingBuildMediator:getScrollViewOffSetY()
	return self._listView:getInnerContainer():getPositionY()
end

function BuildingBuildMediator:resetBuildingList()
	self._buildingList = self._showType == 1 and (self._buildButtonType == KBuildingBuildType.kResource and self._buildingSystem:getBuildingResource(self._roomId) or self._buildingSystem:getBuildingDecorate(self._roomId)) or self._buildingSystem:getBuildingRecycleList(self._roomId)

	self._tableView:reloadData()

	if self._showType ~= 1 then
		if self._buildingList and #self._buildingList > 0 then
			self._nodeNone:setVisible(false)
			self._bg_bx:setVisible(true)
		else
			self._bg_bx:setVisible(false)
			self._nodeNone:setVisible(true)
		end
	end
end

function BuildingBuildMediator:createTableView()
	local scrollLayer = self._mainPanel:getChildByName("Panel")
	local viewSize = scrollLayer:getContentSize()
	local tableView = cc.TableView:create(viewSize)

	local function numberOfCells(view)
		return #self._buildingList
	end

	local function cellTouched(table, cell)
		return
	end

	local function cellSize(table, idx)
		return kCellWidth, kCellHeight
	end

	local function cellAtIndex(table, idx)
		local index = idx + 1
		local data = self._buildingList[index]
		local cell = table:dequeueCell()

		if not cell then
			cell = cc.TableViewCell:new()

			local realCell = self:getInjector():getInstance("BuildingBuild")

			cell.m_cellMediator = self:getInjector():instantiate("BuildingBuildCell", {
				view = realCell
			})
			cell.m_cellMediator._buildingSystem = self._buildingSystem

			cell.m_cellMediator:intiView(self)
			cell:addChild(realCell)
		end

		local info = {}

		info.id = data
		info.roomId = self._roomId
		info.showType = self._showType

		cell.m_cellMediator:update(info)

		return cell
	end

	local function onScroll()
		return
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	tableView:setPosition(scrollLayer:getPosition())
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	scrollLayer:getParent():addChild(tableView)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(onScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	scrollLayer:removeFromParent(true)

	self._tableView = tableView
end

function BuildingBuildMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local cellTwo = self._tableView:cellAtIndex(0)

		if cellTwo and cellTwo.m_cellMediator then
			local btnbuy = cellTwo.m_cellMediator._btnbuy

			storyDirector:setClickEnv("BuildingBuild.btnbuy", btnbuy, function(sender, eventType)
				cellTwo.m_cellMediator:onClickBuild()
			end)
		end

		local decorateBtn = self._buildTypeBtnList[KBuildingBuildType.kDecorate]

		if decorateBtn then
			storyDirector:setClickEnv("BuildingBuild.decorateBtn", decorateBtn, function(sender, eventType)
				self:onClickBuildType(KBuildingBuildType.kDecorate)
				self:setupClickEnvs()
			end)
		end

		storyDirector:notifyWaiting("enter_buildingBuild_view")
	end))

	self:getView():runAction(sequence)
end

function BuildingBuildMediator:refreshComfort()
	local node_comfort = self:getView():getChildByFullName("Node_comfort")

	if self._roomId == kStoreRoomName then
		node_comfort:setVisible(false)
		self._mainPanel:getChildByFullName("Text"):setVisible(false)

		self._roomId = "Room2"
	else
		node_comfort:setVisible(true)
		self._mainPanel:getChildByFullName("Text"):setVisible(true)
	end

	local text_combat = node_comfort:getChildByFullName("Image_combat.Text_num")
	local text_love = node_comfort:getChildByFullName("Image_love.Text_num")
	local combat = self._buildingSystem:getRoomComfort(self._roomId)
	local love = self._buildingSystem:getRoomAddLove(self._roomId)

	text_combat:setString(combat)
	text_love:setString("+" .. love)
	text_combat:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	text_love:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
end

function BuildingBuildMediator:onClickShowComfortTip()
	local tipPanel = self:getView():getChildByFullName("Node_comfort.Node_tips")

	tipPanel:setVisible(true)
end

function BuildingBuildMediator:onClickHideComfortTip()
	local tipPanel = self:getView():getChildByFullName("Node_comfort.Node_tips")

	tipPanel:setVisible(false)
end
