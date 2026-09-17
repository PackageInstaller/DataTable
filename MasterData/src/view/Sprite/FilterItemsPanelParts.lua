local FilterItemsPanelParts = class("FilterItemsPanelParts", function()
	return cc.Layer:create()
end)
local TempWidget = require("view.Sprite.TempWidget")
local filter_config_manager = require("controller.filter_config_manager")
local var_0_3 = filter_config_manager.ConfigTable
local var_0_4 = config._DEBUG and 0 or 1
local var_0_5 = 1
local var_0_6 = 1
local var_0_7 = 5
local var_0_8 = 40
local var_0_9 = 40
local var_0_10 = 60
local var_0_11 = {
	extraHeight = 140,
	maxBtnTotal = 100,
	panelWidth = 580,
	firstTitle = {
		height = 60,
		fontSzie = 26,
		bg = "public/filter/first_title_bg.png",
		size = 22,
		startPosX = 40,
		fontName = FONT_NAME,
		fontColor = cc.c3b(255, 255, 255),
		bgSize = cc.size(470, 30)
	},
	secondTitle = {
		height = 45,
		fontSzie = 24,
		size = 22,
		startPosX = 50,
		fontName = FONT_NAME,
		fontColor = cc.c3b(248, 243, 255),
		bgSize = cc.size(490, 25)
	},
	filterBtn = {
		height = 60,
		fontSzie = 20,
		selectedOffBg = "public/filter/filter_select_off_new_bg.png",
		startPosX = 40,
		bg = "public/filter/filter_select_new_bg.png",
		selectedBg = "public/filter/filter_selected_new_bg.png",
		width = 125,
		contentSize = cc.size(124, 62),
		fontColor = cc.c3b(255, 255, 255),
		fontName = FONT_NAME,
		selectedFontColor = cc.c3b(255, 255, 255)
	},
	sortBtnConfig = {
		sort_table = {
			0,
			1
		},
		sort_str = {
			[0] = L_DESCENDING,
			L_ASCENDING
		}
	},
	titleText = {
		"public/filter/filter_parts.png",
		"public/filter/filter_material.png",
		"public/filter/filter_furniture.png",
		"public/filter/filter_weapon.png",
		"public/filter/filter_horcrux.png",
		"public/filter/filter_parts.png",
		"public/filter/filter_weapon.png",
		"public/filter/filter_material.png",
		"public/filter/filter_weapon.png",
		"public/filter/filter_furniture.png",
		"public/filter/filter_medal.png",
		"public/filter/filter_major.png",
		"public/filter/filter_major.png",
		nil,
		nil,
		"public/filter/filter_major.png",
		"public/filter/filter_lab.png",
		"public/filter/filter_material.png",
		startPosX = 30,
		startPosY = 60
	},
	noneTitle = {
		startPosX = 25
	}
}
local var_0_12 = {
	{
		"ItemsPanelPartsLayer/attr_img_1.png",
		"ItemsPanelPartsLayer/attr_img_2.png",
		"ItemsPanelPartsLayer/attr_img_3.png",
		"ItemsPanelPartsLayer/attr_img_4.png",
		"ItemsPanelPartsLayer/attr_img_5.png",
		"ItemsPanelPartsLayer/attr_img_6.png",
		"ItemsPanelPartsLayer/attr_img_7.png",
		"ItemsPanelPartsLayer/attr_img_8.png",
		"ItemsPanelPartsLayer/attr_img_9.png"
	},
	{
		"ItemsPanelPartsLayer/pz_blue.png",
		"ItemsPanelPartsLayer/pz_purple.png",
		"ItemsPanelPartsLayer/pz_orange.png",
		"ItemsPanelPartsLayer/pz_red.png"
	},
	{
		"HorcruxSelectLayer/rarity2.png",
		"HorcruxSelectLayer/rarity3.png",
		"HorcruxSelectLayer/rarity4.png",
		"HorcruxSelectLayer/rarity5.png"
	}
}

function FilterItemsPanelParts:ctor()
	self:registerScriptHandler(function(arg_3_0)
		if arg_3_0 == "enter" then
			self:onEnter()
		elseif arg_3_0 == "exit" then
			self:onExit()
		end
	end)
end

function FilterItemsPanelParts:create(arg_4_1)
	local var_4_0 = FilterItemsPanelParts.new()

	if var_4_0:init(arg_4_1) then
		return var_4_0
	end

	return nil
end

function FilterItemsPanelParts:init(arg_5_1)
	self.data = arg_5_1 or {}
	self.filterType = self.data.filterType
	self.filterCallback = self.data.filterCallback
	self.initButtonConfig = self.data.initButtonConfig or {}
	self.sortOrderChangeCallback = self.data.sortOrderChangeCallback
	self.maskTouchCallback = self.data.maskTouchCallback
	self.bagType_partition = self.data.bagType_partition
	self.isDecomposeFilter = self.data.isDecomposeFilter or false

	if self.bagType_partition == 2 then
		self.filterType = 17
	elseif self.bagType_partition == 1 then
		self.filterType = 18
	end

	self.defaultSortType = self.data.defaultSortType or var_0_3[self.filterType].default_sort_type

	local var_5_0 = self.data.defaultSortOrder or var_0_3[self.filterType].default_sort_order

	self.defaultSortOrder = var_0_11.sortBtnConfig.sort_table[1] == var_5_0 and 1 or var_0_11.sortBtnConfig.sort_table[2] == var_5_0 and 2 or 1
	var_0_11.maxBtnTotal = math.floor(var_0_11.panelWidth / var_0_11.filterBtn.width)

	self:initData()
	self:initLayer()
	self:initListener()

	return true
end

function FilterItemsPanelParts:initLayer()
	local var_6_0 = TempWidget:CreateTempLayout(self)

	var_6_0:setContentSize(GameDisplay.getUiScreenSize())
	var_6_0:align(cc.p(0.5, 0.5), var_6_0:size().w / 2, var_6_0:size().h / 2)

	self._root = var_6_0

	local var_6_1 = TempWidget:CreateTempLayout(var_6_0)

	var_6_1:setContentSize(var_6_0:size())
	var_6_1:_setBack()
	var_6_1:setBackGroundColor(cc.c3b(0, 0, 0))
	var_6_1:setBackGroundColorOpacity(100)

	local var_6_2 = TempWidget:CreateTempImg("HorcruxSelectLayer/filterBg.png", var_6_0)

	var_6_2:setScale9Enabled(true)
	var_6_2:_addEvent(function()
		return
	end)
	var_6_2:setCapInsets(cc.rect(10, 50, var_6_2:size().w - 10, 20))
	var_6_2:setContentSize(cc.size(var_6_2:size().w, self:getSortBgHeight() + 80))
	var_6_2:align(cc.p(0.5, 1), var_6_0:size().w / 2, var_6_0:size().h * 0.85)
	TempWidget:CreateTempLabel(L_FILTER, FONT_NAME, 20, var_6_2):align(cc.p(0.5, 1), var_6_2:size().w / 2, var_6_2:size().h - 8)

	local var_6_3 = self:createSortLayout()

	var_6_2:addChild(var_6_3)
	var_6_3:align(cc.p(0.5, 1), var_6_2:size().w / 2, var_6_2:size().h - 40)

	local var_6_4 = self:createFilterLayout()

	var_6_2:addChild(var_6_4)
	var_6_4:align(cc.p(0.5, 1), var_6_2:size().w / 2, var_6_3:pos().y - var_6_3:size().h)
end

function FilterItemsPanelParts:initListener()
	self._root:_addEvent(function()
		local function var_9_0()
			self._root:runAction(cc.Sequence:create(cc.Spawn:create(cc.Sequence:create(cc.FadeTo:create(0.1, 20), cc.Blink:create(0.15, 1)), cc.ScaleTo:create(0.3, 1, 0.001)), cc.CallFunc:create(function()
				self:setVisible(false)
			end)))
		end

		if self.data.maskTouchCallback then
			self.data.maskTouchCallback(var_9_0)
		else
			var_9_0()
		end
	end)
end

function FilterItemsPanelParts:onEnter()
	self:setScaleY(0.01)
	self:runAction(cc.ScaleTo:create(0.3, 1, 1))
end

function FilterItemsPanelParts:onExit()
	return
end

function FilterItemsPanelParts:playPopAni()
	self:setVisible(true)
	self._root:setOpacity(255)
	self._root:setScaleY(0)
	self._root:runAction(cc.ScaleTo:create(0.3, 1))
end

function FilterItemsPanelParts:disPathCallback()
	if self.filterCallback then
		self.filterCallback({
			bag_type = self.filterType,
			filterConfig = self:getFilterData(),
			sortType = self:getSortType()
		})
	end
end

function FilterItemsPanelParts:setFilterBtnState(arg_16_1, arg_16_2)
	if next(arg_16_2) then
		self.btnState.filterType[arg_16_1] = arg_16_2
	end
end

function FilterItemsPanelParts:setSortOrderState(arg_17_1, arg_17_2)
	if next(arg_17_2) then
		self.btnState.sortOrder[arg_17_1] = arg_17_2
	end
end

function FilterItemsPanelParts:setSortTypestate(arg_18_1, arg_18_2)
	if next(arg_18_2) then
		self.btnState.sortType[arg_18_1] = arg_18_2
	end
end

function FilterItemsPanelParts:updateAllFilterBtn()
	local function var_19_0(arg_20_0)
		if type(arg_20_0) == "table" then
			for iter_20_0, iter_20_1 in pairs(arg_20_0) do
				var_19_0(iter_20_1)
			end
		elseif type(arg_20_0) == "userdata" then
			self:updateFilterBtn(arg_20_0)
		end
	end

	var_19_0(self.btnObj)
end

function FilterItemsPanelParts:initData()
	self.btnState = {
		filterType = {},
		sortType = {},
		sortOrder = {}
	}
	self.btnObj = {
		filterType = {},
		sortType = {},
		sortOrder = {}
	}
	self.btnFilterKey = {
		filterType = {},
		sortType = {},
		sortOrder = {}
	}

	for iter_21_0 = 1, #var_0_3[self.filterType].filter_table do
		self.btnState.filterType[iter_21_0] = {}
		self.btnObj.filterType[iter_21_0] = {}
		self.btnFilterKey.filterType[iter_21_0] = {}
	end

	for iter_21_1 = 1, var_0_5 do
		self.btnState.sortType[iter_21_1] = {}
		self.btnObj.sortType[iter_21_1] = {}
		self.btnFilterKey.sortType[iter_21_1] = {}
	end

	for iter_21_2 = 1, var_0_6 do
		self.btnState.sortOrder[iter_21_2] = {}
		self.btnObj.sortOrder[iter_21_2] = {}
		self.btnFilterKey.sortOrder[iter_21_2] = {}
	end

	local var_21_0 = self.defaultSortType or var_0_3[self.filterType].default_sort_type

	if var_21_0 then
		self.btnState.sortType[var_0_5][var_21_0] = 1
	end

	local var_21_1 = self.defaultSortOrder or var_0_3[self.filterType].default_sort_order

	if var_21_1 then
		self.btnState.sortOrder[var_0_6][var_21_1] = 1
	end

	for iter_21_3, iter_21_4 in pairs(self.initButtonConfig) do
		if iter_21_4 then
			for iter_21_5, iter_21_6 in pairs(iter_21_4) do
				self.btnState.filterType[iter_21_3][iter_21_5] = iter_21_6
			end
		end
	end
end

function FilterItemsPanelParts:updateFilterBtn(arg_22_1)
	if arg_22_1.buttonType == "sortType" or arg_22_1.buttonType == "sortOrder" then
		for iter_22_0, iter_22_1 in pairs(self.btnState[arg_22_1.buttonType][arg_22_1.col]) do
			if self.btnState[arg_22_1.buttonType][arg_22_1.col][iter_22_0] == 1 or self.btnState[arg_22_1.buttonType][arg_22_1.col][iter_22_0] == -2 then
				self.btnObj[arg_22_1.buttonType][arg_22_1.col][iter_22_0]:loadTexture(var_0_11.filterBtn.selectedBg, var_0_4)
				self.btnObj[arg_22_1.buttonType][arg_22_1.col][iter_22_0]:getChildByName("label"):setColor(var_0_11.filterBtn.selectedFontColor)
			elseif self.btnState[arg_22_1.buttonType][arg_22_1.col][iter_22_0] == 0 then
				self.btnObj[arg_22_1.buttonType][arg_22_1.col][iter_22_0]:loadTexture(var_0_11.filterBtn.bg, var_0_4)
				self.btnObj[arg_22_1.buttonType][arg_22_1.col][iter_22_0]:getChildByName("label"):setColor(var_0_11.filterBtn.fontColor)
			else
				self.btnObj[arg_22_1.buttonType][arg_22_1.col][iter_22_0]:loadTexture(var_0_11.filterBtn.selectedOffBg, var_0_4)
				self.btnObj[arg_22_1.buttonType][arg_22_1.col][iter_22_0]:getChildByName("label"):setColor(var_0_11.filterBtn.fontColor)
			end
		end
	elseif self.btnState[arg_22_1.buttonType][arg_22_1.col][arg_22_1.index] == 1 or self.btnState[arg_22_1.buttonType][arg_22_1.col][arg_22_1.index] == -2 then
		arg_22_1:loadTexture(var_0_11.filterBtn.selectedBg, var_0_4)
		arg_22_1:getChildByName("label"):setColor(var_0_11.filterBtn.selectedFontColor)
	elseif self.btnState[arg_22_1.buttonType][arg_22_1.col][arg_22_1.index] == 0 then
		arg_22_1:loadTexture(var_0_11.filterBtn.bg, var_0_4)
		arg_22_1:getChildByName("label"):setColor(var_0_11.filterBtn.fontColor)
	else
		arg_22_1:loadTexture(var_0_11.filterBtn.selectedOffBg, var_0_4)
		arg_22_1:getChildByName("label"):setColor(var_0_11.filterBtn.fontColor)
	end
end

function FilterItemsPanelParts:getSortBgHeight()
	return self:getSortLayoutHeight() + self:getFilterLayoutHeight()
end

function FilterItemsPanelParts:getSortLayoutHeight()
	local var_24_0 = 1

	while var_0_3[self.filterType].sort_table[var_24_0] do
		var_24_0 = var_24_0 + 1
	end

	return 0 + var_0_8 + var_0_9 * 2 + (var_0_10 + var_0_10 * math.ceil(var_24_0 / var_0_7))
end

function FilterItemsPanelParts:createSortLayout()
	local var_25_0 = self:getSortLayoutHeight()
	local var_25_1 = TempWidget:CreateTempLayout()

	var_25_1:setContentSize(cc.size(GameDisplay.width, var_25_0))

	local var_25_2 = TempWidget:CreateTempImg("HorcruxSelectLayer/template_bg.png", var_25_1)

	var_25_2:setScale9Enabled(true)
	var_25_2:setCapInsets(cc.rect(0, 0, var_25_2:size().w, var_25_2:size().h))
	var_25_2:setContentSize(cc.size(var_25_2:size().w, var_25_0))
	var_25_2:center()

	local var_25_3 = self:createTitleLayout(L_SORT)

	var_25_1:addChild(var_25_3)
	var_25_3:align(cc.p(0.5, 1), var_25_1:size().w / 2, var_25_1:size().h)

	local var_25_4 = self:createHeadLayout(L_ASCEN_OR_DESCEN)

	var_25_1:addChild(var_25_4)
	var_25_4:align(cc.p(0.5, 1), var_25_1:size().w / 2, var_25_3:pos().y - var_25_3:size().h)

	local var_25_5 = {}

	for iter_25_0, iter_25_1 in pairs(var_0_11.sortBtnConfig.sort_table) do
		var_25_5[#var_25_5 + 1] = iter_25_0
	end

	local var_25_6 = self:createTypeLayout(var_25_5, 3, var_0_6)

	var_25_1:addChild(var_25_6)
	var_25_6:align(cc.p(0.5, 1), var_25_1:size().w / 2, var_25_4:pos().y - var_25_4:size().h)

	local var_25_7 = self:createHeadLayout(L_SORT_TYPE)

	var_25_1:addChild(var_25_7)
	var_25_7:align(cc.p(0.5, 1), var_25_1:size().w / 2, var_25_6:pos().y - var_25_6:size().h)

	local var_25_8 = {}

	while var_0_3[self.filterType].sort_table[1] do
		var_25_8[#var_25_8 + 1] = 1
	end

	local var_25_10 = self:createTypeLayout(var_25_8, 2, var_0_5)

	var_25_1:addChild(var_25_10)
	var_25_10:align(cc.p(0.5, 1), var_25_1:size().w / 2, var_25_7:pos().y - var_25_7:size().h)

	return var_25_1
end

function FilterItemsPanelParts:createFilterLayout()
	local var_26_0 = self:getFilterLayoutHeight()
	local var_26_1 = TempWidget:CreateTempLayout()

	var_26_1:setContentSize(cc.size(GameDisplay.width, var_26_0))

	local var_26_2 = TempWidget:CreateTempImg("HorcruxSelectLayer/template_bg.png", var_26_1)

	var_26_2:setScale9Enabled(true)
	var_26_2:setCapInsets(cc.rect(0, 0, var_26_2:size().w, var_26_2:size().h))
	var_26_2:setContentSize(cc.size(var_26_2:size().w, var_26_0))
	var_26_2:center()

	local var_26_3 = self:createTitleLayout(L_FILTER)

	var_26_1:addChild(var_26_3)
	var_26_3:align(cc.p(0.5, 1), var_26_1:size().w / 2, var_26_1:size().h)

	local var_26_4 = var_26_3:pos().y - var_26_3:size().h

	for iter_26_0 = 1, #var_0_3[self.filterType].filter_table do
		local var_26_5 = self:createHeadLayout(var_0_3[self.filterType].filter_type_str[iter_26_0])

		var_26_1:addChild(var_26_5)
		var_26_5:align(cc.p(0.5, 1), var_26_1:size().w / 2, var_26_4)

		var_26_4 = var_26_4 - var_26_5:size().h

		local var_26_6 = {}

		for iter_26_1 = 1, #var_0_3[self.filterType].filter_table[iter_26_0] do
			var_26_6[#var_26_6 + 1] = iter_26_1
		end

		local var_26_7 = self:createTypeLayout(var_26_6, 1, iter_26_0)

		var_26_1:addChild(var_26_7)
		var_26_7:align(cc.p(0.5, 1), var_26_1:size().w / 2, var_26_4)

		var_26_4 = var_26_4 - var_26_7:size().h
	end

	return var_26_1
end

function FilterItemsPanelParts:getFilterLayoutHeight()
	local var_27_0 = 0

	for iter_27_0 = 1, #var_0_3[self.filterType].filter_table do
		var_27_0 = var_27_0 + var_0_10 * math.ceil(#var_0_3[self.filterType].filter_table[iter_27_0] / var_0_7)
	end

	return 0 + var_0_8 + var_0_9 * #var_0_3[self.filterType].filter_table + var_27_0
end

function FilterItemsPanelParts:createButton(arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = TempWidget:CreateTempImg(var_0_11.filterBtn.bg)
	local var_28_1
	local var_28_2 = 0

	if arg_28_2 == 1 then
		var_28_1 = cc.Label:createWithTTF(var_0_3[self.filterType].filter_str[arg_28_3][var_0_3[self.filterType].filter_table[arg_28_3][arg_28_1]], var_0_11.filterBtn.fontName, var_0_11.filterBtn.fontSzie)
		self.btnObj.filterType[arg_28_3][arg_28_1] = var_28_0
		self.btnFilterKey.filterType[arg_28_3][arg_28_1] = var_0_3[self.filterType].filter_table[arg_28_3][arg_28_1]
		var_28_0.buttonType = "filterType"
		self.btnState.filterType[arg_28_3][arg_28_1] = self.btnState.filterType[arg_28_3][arg_28_1] or 0
		var_28_2 = self.btnState.filterType[arg_28_3][arg_28_1]

		if self.filterType == filter_config_manager.COMPONENT_ITEMPANEL then
			var_0_12[2] = {
				"ItemsPanelPartsLayer/pz_blue.png",
				"ItemsPanelPartsLayer/pz_purple.png",
				"ItemsPanelPartsLayer/pz_orange.png",
				"ItemsPanelPartsLayer/pz_red.png"
			}

			var_28_1:setVisible(arg_28_3 == 3)

			if arg_28_3 ~= 3 then
				TempWidget:CreateTempImg(var_0_12[arg_28_3][arg_28_1], var_28_0):center()
			end
		elseif self.filterType == filter_config_manager.BASICMATRIAL_BAGLAYER or self.filterType == filter_config_manager.LABMATRIAL_BAGLAYER or self.filterType == filter_config_manager.FURNITURE_BAGLAYER then
			var_0_12[2] = {
				"ItemsPanelPartsLayer/pz_white.png",
				"ItemsPanelPartsLayer/pz_green.png",
				"ItemsPanelPartsLayer/pz_blue.png",
				"ItemsPanelPartsLayer/pz_purple.png",
				"ItemsPanelPartsLayer/pz_orange.png",
				"ItemsPanelPartsLayer/pz_red.png"
			}, var_28_1:setVisible(arg_28_3 ~= 2)

			if arg_28_3 == 2 then
				TempWidget:CreateTempImg(var_0_12[arg_28_3][arg_28_1], var_28_0):center()
			end
		elseif self.filterType == filter_config_manager.COMPONENT_BAGLAYER then
			var_0_12[2] = {
				"ItemsPanelPartsLayer/pz_blue.png",
				"ItemsPanelPartsLayer/pz_purple.png",
				"ItemsPanelPartsLayer/pz_orange.png",
				"ItemsPanelPartsLayer/pz_red.png"
			}

			var_28_1:setVisible(arg_28_3 == 3)

			if arg_28_3 ~= 3 then
				TempWidget:CreateTempImg(var_0_12[arg_28_3][arg_28_1], var_28_0):center()
			end
		end
	elseif arg_28_2 == 2 then
		var_28_1 = cc.Label:createWithTTF(var_0_3[self.filterType].sort_str[var_0_3[self.filterType].sort_table[arg_28_1]], var_0_11.filterBtn.fontName, var_0_11.filterBtn.fontSzie)
		self.btnObj.sortType[arg_28_3][arg_28_1] = var_28_0
		self.btnFilterKey.sortType[arg_28_3][arg_28_1] = var_0_3[self.filterType].sort_table[arg_28_1]
		var_28_0.buttonType = "sortType"
		self.btnState.sortType[arg_28_3][arg_28_1] = self.btnState.sortType[arg_28_3][arg_28_1] or 0
		var_28_2 = self.btnState.sortType[arg_28_3][arg_28_1]
	else
		local var_28_3 = var_0_11.sortBtnConfig.sort_table[arg_28_1]

		var_28_1 = cc.Label:createWithTTF(var_0_11.sortBtnConfig.sort_str[var_0_11.sortBtnConfig.sort_table[arg_28_1]], var_0_11.filterBtn.fontName, var_0_11.filterBtn.fontSzie)
		self.btnObj.sortOrder[arg_28_3][arg_28_1] = var_28_0
		self.btnFilterKey.sortOrder[arg_28_3][arg_28_1] = var_28_3
		var_28_0.buttonType = "sortOrder"
		self.btnState.sortOrder[arg_28_3][arg_28_1] = self.btnState.sortOrder[arg_28_3][arg_28_1] or 0
		var_28_2 = self.btnState.sortOrder[arg_28_3][arg_28_1]
	end

	if var_28_2 == 1 or var_28_2 == -2 then
		var_28_0:loadTexture(var_0_11.filterBtn.selectedBg, var_0_4)
		var_28_1:setColor(var_0_11.filterBtn.selectedFontColor)
	elseif var_28_2 == -1 then
		var_28_0:loadTexture(var_0_11.filterBtn.selectedOffBg, var_0_4)
		var_28_1:setColor(var_0_11.filterBtn.fontColor)
	end

	var_28_0.col = arg_28_3
	var_28_0.index = arg_28_1

	var_28_1:setPositionX(var_28_0:getContentSize().width / 2)
	var_28_1:setPositionY(var_28_0:getContentSize().height / 2)
	var_28_1:setName("label")
	var_28_0:addChild(var_28_1)
	var_28_0:setTouchEnabled(true)
	var_28_0:addTouchEventListener(function(arg_29_0, arg_29_1)
		if arg_29_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:BtnTouchEvent(arg_29_0)
	end)

	return var_28_0
end

function FilterItemsPanelParts:BtnTouchEvent(arg_30_1)
	if arg_30_1.buttonType == "sortType" or arg_30_1.buttonType == "sortOrder" then
		if self.btnState[arg_30_1.buttonType][arg_30_1.col][arg_30_1.index] == 1 or self.btnState[arg_30_1.buttonType][arg_30_1.col][arg_30_1.index] == -1 or self.btnState[arg_30_1.buttonType][arg_30_1.col][arg_30_1.index] == -2 then
			return
		else
			for iter_30_0, iter_30_1 in pairs(self.btnState[arg_30_1.buttonType][arg_30_1.col]) do
				self.btnState[arg_30_1.buttonType][arg_30_1.col][iter_30_0] = 0
			end

			self.btnState[arg_30_1.buttonType][arg_30_1.col][arg_30_1.index] = 1
		end

		if arg_30_1.buttonType == "sortOrder" and self.btnState[arg_30_1.buttonType][arg_30_1.col][arg_30_1.index] == 1 then
			if self.sortOrderChangeCallback then
				self.sortOrderChangeCallback(var_0_11.sortBtnConfig.sort_table[arg_30_1.index])
			end

			self:updateFilterBtn(arg_30_1)

			return
		end
	else
		if self.btnState[arg_30_1.buttonType][arg_30_1.col][arg_30_1.index] == -2 then
			return
		end

		if self.btnState[arg_30_1.buttonType][arg_30_1.col][arg_30_1.index] == 1 then
			self.btnState[arg_30_1.buttonType][arg_30_1.col][arg_30_1.index] = 0
		elseif self.btnState[arg_30_1.buttonType][arg_30_1.col][arg_30_1.index] == 0 then
			self.btnState[arg_30_1.buttonType][arg_30_1.col][arg_30_1.index] = 1
		else
			return
		end
	end

	self:updateFilterBtn(arg_30_1)
	self:disPathCallback()
end

function FilterItemsPanelParts:createTitleLayout(arg_31_1)
	local var_31_0 = TempWidget:CreateTempLayout()

	var_31_0:setContentSize(cc.size(GameDisplay.width, var_0_8))
	TempWidget:CreateTempImg("HorcruxSelectLayer/model_bg.png", var_31_0):move(var_31_0:size().w / 2, var_31_0:size().h / 2 - 8)
	TempWidget:CreateTempLabel(arg_31_1, FONT_NAME, 20, var_31_0):align(cc.p(0.5, 0.5), var_31_0:property().center)

	return var_31_0
end

function FilterItemsPanelParts:createHeadLayout(arg_32_1)
	local var_32_0 = TempWidget:CreateTempLayout()

	var_32_0:setContentSize(cc.size(GameDisplay.width, var_0_9))

	local var_32_1 = TempWidget:CreateTempImg("HorcruxSelectLayer/head_img.png", var_32_0)

	var_32_1:align(cc.p(0, 0.5), 50, var_32_0:size().h / 2 + 15)
	TempWidget:CreateTempLabel(arg_32_1, FONT_NAME, 20, var_32_0):align(cc.p(0, 0.5), var_32_1:pos().x + var_32_1:size().w + 5, var_32_1:pos().y)

	return var_32_0
end

function FilterItemsPanelParts:createTypeLayout(arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = TempWidget:CreateTempLayout()

	var_33_0:setContentSize(cc.size(GameDisplay.width, var_0_10 * math.ceil(#arg_33_1 / var_0_7)))

	local var_33_1 = var_33_0:size().h

	for iter_33_0 = 1, math.ceil(#arg_33_1 / var_0_7) do
		local var_33_2 = TempWidget:CreateTempLayout()

		var_33_2:setContentSize(cc.size(var_33_0:size().w, var_0_10))
		var_33_2:align(cc.p(0, 1), 0, var_33_1)
		var_33_0:addChild(var_33_2)

		for iter_33_1 = 1, var_0_7 do
			if not arg_33_1[iter_33_1 + (iter_33_0 - 1) * var_0_7] then
				break
			end

			local var_33_3 = self:createButton(arg_33_1[iter_33_1 + (iter_33_0 - 1) * var_0_7], arg_33_2, arg_33_3)

			var_33_2:addChild(var_33_3)
			var_33_3:align(cc.p(0, 0.5), 50 + (iter_33_1 - 1) * ((var_33_2:size().w - 50 * 2 - 10 * (var_0_7 - 1)) / var_0_7 + 10), var_33_2:size().h / 2 + 15)
		end

		var_33_1 = var_33_1 - var_33_2:size().h
	end

	return var_33_0
end

function FilterItemsPanelParts:getFilterData()
	local var_34_0 = {}

	for iter_34_0, iter_34_1 in pairs(self.btnState.filterType) do
		var_34_0[var_0_3[self.filterType].filter_key[iter_34_0]] = {}

		for iter_34_2, iter_34_3 in pairs(iter_34_1) do
			if iter_34_3 == 1 or iter_34_3 == -2 then
				var_34_0[var_0_3[self.filterType].filter_key[iter_34_0]][#var_34_0[var_0_3[self.filterType].filter_key[iter_34_0]] + 1] = self.btnFilterKey.filterType[iter_34_0][iter_34_2]
			end
		end
	end

	return var_34_0
end

function FilterItemsPanelParts:getSortType()
	for iter_35_0, iter_35_1 in pairs(self.btnState.sortType[var_0_5]) do
		if iter_35_1 == 1 then
			return iter_35_0
		end
	end
end

return FilterItemsPanelParts
