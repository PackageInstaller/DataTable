-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/BuildingInfoMediator.lua

BuildingInfoMediator = class("BuildingInfoMediator", DmPopupViewMediator)

BuildingInfoMediator:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")
BuildingInfoMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
BuildingInfoMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local clickEventMap = {
	["main.Node_bg.btn_close"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickClose"
	}
}

function BuildingInfoMediator:initialize()
	super.initialize(self)
end

function BuildingInfoMediator:dispose()
	super.dispose(self)
end

function BuildingInfoMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(clickEventMap)
end

function BuildingInfoMediator:mapEventListeners()
	return
end

function BuildingInfoMediator:enterWithData(data)
	self._buildingId = data.buildingId
	self._roomId = data.roomId
	self._id = data.id

	self:setupView()
	self:refreshView()
end

function BuildingInfoMediator:setupView()
	self._mainPanel = self:getView():getChildByFullName("main")

	local config = self._buildingSystem:getBuildingConfig(self._buildingId)
	local node_name = self._mainPanel:getChildByFullName("Node_bg.title_node")
	local text_name = self._mainPanel:getChildByFullName("Text_name")

	bindWidget(self, node_name, PopupNormalTitle, {
		title = Strings:get("Building_UI_Detile"),
		title1 = Strings:get("UITitle_EN_Xiangqing")
	})
	text_name:setString(Strings:get(config.Name))

	self._text_des = self._mainPanel:getChildByFullName("Text_des")
	self._node_des = self._mainPanel:getChildByFullName("Node_des")
	self._buildinglevel = self._mainPanel:getChildByFullName("buildinglevel")

	self._mainPanel:getChildByFullName("lv"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	self._node_building = self._mainPanel:getChildByFullName("Node_building")
	self._layout3 = self._mainPanel:getChildByFullName("layout3")
end

function BuildingInfoMediator:refreshView()
	local skinId = self._buildingSystem:getBuildingSkinId(self._roomId, self._buildingId, self._id)
	local lv = self._buildingSystem:getBuildingLevel(self._roomId, self._id) or 1
	local config = self._buildingSystem:getBuildingConfig(self._buildingId)

	self._node_des:removeAllChildren()

	local desc = Strings:get(config.Desc, {
		fontSize = 18,
		fontName = TTF_FONT_FZYH_M
	})
	local contentText = ccui.RichText:createWithXML(desc, {})

	contentText:setAnchorPoint(cc.p(0, 1))
	contentText:ignoreContentAdaptWithSize(true)
	contentText:rebuildElements()
	contentText:formatText()
	contentText:renderContent(self._text_des:getContentSize().width, 0, true)
	self._node_des:addChild(contentText)
	self._buildinglevel:setString(lv)

	local buildingDecorate = self:getInjector():instantiate("BuildingDecorate", {
		view = self._node_building
	})

	buildingDecorate:setBuildingInfo(self._roomId, self._buildingId, self._id)
	buildingDecorate:setIsInRoom(false)
	buildingDecorate:enterWithData()

	local skinConfig = ConfigReader:getRecordById("VillageBuildingSurface", skinId)

	if skinConfig then
		buildingDecorate:getView():setScale(skinConfig.PicScale[2])
	end

	local nodeBase_1 = self._layout3:getChildByFullName("node1")
	local nodeBase_2 = self._layout3:getChildByFullName("node2")
	local text_heroBuff = self._layout3:getChildByFullName("Text_heroBuff")
	local text_heroBuffNum = self._layout3:getChildByFullName("Text_heroBuffNum")

	nodeBase_1:getChildByFullName("action"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	nodeBase_1:getChildByFullName("Text_1"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	nodeBase_2:getChildByFullName("action"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	nodeBase_2:getChildByFullName("Text_1"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	nodeBase_1:setVisible(false)
	nodeBase_2:setVisible(false)
	text_heroBuff:setVisible(false)
	text_heroBuffNum:setVisible(false)

	local room = self._buildingSystem:getRoom(self._roomId)
	local heroList = room:getHeroList()
	local buffNum, buffDes = self._buildingSystem:getBuildPutHeroAddBuff(self._roomId, heroList)
	local buildingData = self._buildingSystem:getBuildingData(self._roomId, self._id)

	if buildingData and buildingData._type == KBuildingType.kCardAcademy then
		nodeBase_1:setVisible(true)

		local text = nodeBase_1:getChildByFullName("action")
		local text_1 = nodeBase_1:getChildByFullName("Text_1")

		text_1:setString(Strings:get("Building_UI_Card"))
		text:setString(self._stageSystem:getPlayerInit() + self._buildingSystem:getBuildingBuildCardBuf())

		local resImage = nodeBase_1:getChildByFullName("Image")

		resImage:setContentSize(cc.size(50, 50))
		resImage:loadTexture("chengjian_icon_lanwei.png", ccui.TextureResType.plistType)
		text_heroBuff:setVisible(true)
		text_heroBuffNum:setVisible(true)
		text_heroBuff:setString(Strings:get("Lay_Increase_Title"))
		text_heroBuffNum:setString(Strings:get("Lay_Increase_CardAcademy", {
			num = buffDes
		}))
	elseif buildingData and buildingData._type == KBuildingType.kCrystalOre then
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
		text_heroBuff:setVisible(true)
		text_heroBuffNum:setVisible(true)
		text_heroBuff:setString(Strings:get("Lay_Increase_Title"))
		text_heroBuffNum:setString(Strings:get("Lay_Increase_CrystalOre", {
			num = buffDes
		}))
	elseif buildingData and buildingData._type == KBuildingType.kExpOre then
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
		text_heroBuff:setVisible(true)
		text_heroBuffNum:setVisible(true)
		text_heroBuff:setString(Strings:get("Lay_Increase_Title"))
		text_heroBuffNum:setString(Strings:get("Lay_Increase_ExpOre", {
			num = buffDes
		}))
	elseif buildingData and buildingData._type == KBuildingType.kGoldOre then
		local resImage = nodeBase_1:getChildByFullName("Image")

		resImage:setContentSize(cc.size(50, 50))
		resImage:loadTexture("icon_jinbi_1.png", ccui.TextureResType.plistType)
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
		text_heroBuff:setVisible(true)
		text_heroBuffNum:setVisible(true)
		text_heroBuff:setString(Strings:get("Lay_Increase_Title"))
		text_heroBuffNum:setString(Strings:get("Lay_Increase_GoldOre", {
			num = buffDes
		}))
	elseif buildingData and buildingData._type == KBuildingType.kCamp then
		nodeBase_1:setVisible(true)

		local text = nodeBase_1:getChildByFullName("action")
		local text_1 = nodeBase_1:getChildByFullName("Text_1")

		text:setString(self._buildingSystem:getBuildingBuildCostBuf())
		text_1:setString(Strings:get("Building_CostLimit"))

		local resImage = nodeBase_1:getChildByFullName("Image")

		resImage:setContentSize(cc.size(50, 50))
		resImage:loadTexture("icon_bg_ka_xiyoudi_new.png", ccui.TextureResType.plistType)
		resImage:setPosition(cc.p(4, -4))
		text_heroBuff:setVisible(true)
		text_heroBuffNum:setVisible(true)
		text_heroBuff:setString(Strings:get("Lay_Increase_Title"))
		text_heroBuffNum:setString(Strings:get("Lay_Increase_Camp", {
			num = buffDes
		}))
	elseif buildingData and buildingData._type == KBuildingType.kMainCity then
		text_heroBuff:setVisible(true)
		text_heroBuffNum:setVisible(true)
		text_heroBuff:setString(Strings:get("Lay_Increase_Title"))
		text_heroBuffNum:setString(Strings:get("Lay_Increase_Maincity", {
			num = buffDes
		}))
	end
end

function BuildingInfoMediator:onClickClose(sender, eventType)
	self:close()
end
