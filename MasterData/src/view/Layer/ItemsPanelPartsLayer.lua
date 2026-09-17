local ItemsPanelPartsLayer = class("ItemsPanelPartsLayer", (require("view.Layer.BaseUILayer")))
local var_0_1 = config._DEBUG and 0 or 1
local TempWidget = require("view.Sprite.TempWidget")
local network = require("network.network")
local item_data = require("data.item_data")
local var_0_5 = require("data.item_data")
local component_effect_data = require("data.component_effect_data")
local component_strengthen_weight_data = require("data.component_strengthen_weight_data")
local core_data = require("data.core_data")
local servant_data = require("data.servant_data")
local var_0_10 = require("data.item_data")
local furnituresuit_data = require("data.furnituresuit_data")
local furniture_data = require("data.furniture_data")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local rainbow_cost_data = require("data.rainbow_cost_data")
local playermodel = require("model.playermodel")
local component_manager = require("controller.component_manager")
local item_manager = require("controller.item_manager")
local weapon_manager = require("controller.weapon_manager")
local bag_manager = require("controller.bag_manager")
local filter_config_manager = require("controller.filter_config_manager")
local audio_manager = require("controller.audio_manager")
local core_manager = require("controller.core_manager")
local dormitory_manager = require("controller.dormitory_manager")
local shop_manager = require("controller.shop_manager")
local array_manager = require("controller.array_manager")
local discount_manager = require("controller.discount_manager")
local Utility = require("common.Utility")

require("view.Sprite.ItemSprite")
require("view.Sprite.FilterSprite")
require("view.Sprite.FilterListSprite")

local FilterItemsPanelParts = require("view.Sprite.FilterItemsPanelParts")
local var_0_30 = "ItemsPanelPartsLayer/"
local var_0_31 = GameDisplay.width
local var_0_32 = 550
local var_0_33 = GameDisplay.width
local var_0_34 = 165
local var_0_35 = 5
local var_0_36 = {
	cc.p(70, 165 / 2),
	cc.p(195, 165 / 2),
	cc.p(320, 165 / 2),
	cc.p(445, 165 / 2),
	(cc.p(570, 165 / 2))
}
local var_0_37
local var_0_38 = 1
local var_0_39 = 1
local var_0_41 = {}
local var_0_43 = {
	"public/panelbg/white.png",
	"public/panelbg/green.png",
	"public/panelbg/blue.png",
	"public/panelbg/purple.png",
	"public/panelbg/orange.png",
	"public/panelbg/red.png"
}
local var_0_44 = {
	[3] = cc.c3b(126, 189, 252),
	[4] = cc.c3b(182, 75, 243),
	[5] = cc.c3b(237, 152, 76)
}

local function var_0_45(arg_1_0)
	local var_1_0 = require("controller.dormitory_manager"):getUsedFurniture()

	if var_1_0[arg_1_0] then
		return playermodel.items[arg_1_0].number - var_1_0[arg_1_0]
	else
		return playermodel.items[arg_1_0].number
	end
end

function ItemsPanelPartsLayer:ctor()
	self.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller.items_panel_parts_manager"):getInstance()
	self.lastSelectedEntityid = nil
	self.itemBnts = {}
	self.componentMapServantid = {}
end

function ItemsPanelPartsLayer:create(arg_3_1, arg_3_2)
	local var_3_0 = ItemsPanelPartsLayer.new()

	var_0_38 = arg_3_2
	var_0_39 = arg_3_2
	var_0_37 = arg_3_1

	if var_3_0:init(arg_3_1, var_0_38) then
		return var_3_0
	end

	return nil
end

function ItemsPanelPartsLayer:getRainbowCostData()
	self.remakeUse = {}
	self.remakeUseNum = {}

	for iter_4_0 = 1, 5 do
		if rainbow_cost_data[1]["cost_" .. iter_4_0] then
			table.insert(self.remakeUse, rainbow_cost_data[1]["cost_" .. iter_4_0])
			table.insert(self.remakeUseNum, rainbow_cost_data[1]["cost_" .. iter_4_0 .. "_num"])
		else
			break
		end
	end

	if rainbow_cost_data[1].cost_gold then
		table.insert(self.remakeUse, "gold")
		table.insert(self.remakeUseNum, rainbow_cost_data[1].cost_gold)
	end
end

function ItemsPanelPartsLayer:init(arg_5_1, arg_5_2)
	UIHelpHideBlackMask(self)
	self:getRainbowCostData()
	self:initComponentMapServantid()

	self.lastSelected = nil
	self.choosedTag = false
	self.panelType = arg_5_1.paneltype
	self.itemType = arg_5_1.itemtype
	self.itemConditions = arg_5_1.itemConditions or nil
	self.usedcallback = arg_5_1.callbacklist.used or nil
	self.unusedcallback = arg_5_1.callbacklist.unused or nil
	self.goto_back_system_id = arg_5_1.goto_back_system_id
	self.usedItems = arg_5_1.usedItem and global_deepCopy(arg_5_1.usedItem) or nil

	if arg_5_1.itemConditions then
		self.servantid = arg_5_1.itemConditions.servantid or nil
	end

	if arg_5_1.itemConditions and arg_5_1.itemConditions.pos then
		self.componentPos = arg_5_1.itemConditions.pos[1] or 1
	end

	if playermodel.component[self.servantid] and playermodel.component[self.servantid][self.componentPos] then
		self.equipedEntityid = playermodel.component[self.servantid][self.componentPos].id or -1
	end

	self.initParamComponentScore = arg_5_1.componentScore or 0
	self.componentEffectid = arg_5_1.effectid
	self.bagManager = bag_manager.create()

	self:initLayer()
	self:initFilterPanelNew(self.panelType)
	self:createTypeList()
	self:initItemsList()
	self:initListener()

	return true
end

function ItemsPanelPartsLayer:initComponentMapServantid()
	for iter_6_0, iter_6_1 in pairs(playermodel.component) do
		for iter_6_2, iter_6_3 in ipairs(iter_6_1) do
			self.componentMapServantid[iter_6_3.id] = iter_6_0
		end
	end
end

function ItemsPanelPartsLayer:createChoosePanel()
	self.gouList = {}
	self.cover = cc.LayerColor:create(cc.c4b(0, 0, 0, 155), GameDisplay.width, GameDisplay.height)

	self.cover:setPosition(0, 0)
	self.cover:setTouchEnabled(true)
	self._root:addChild(self.cover, 100)

	self.touchCover = ccui.Layout:create()

	self.touchCover:setPosition(-GameDisplay.fix_x, -GameDisplay.fix_y - 70)
	self.touchCover:setContentSize(GameDisplay.width, GameDisplay.height + 10)
	self.touchCover:setTouchEnabled(true)
	self._root:addChild(self.touchCover, 101)
	self.touchCover:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.gouList = {}

		self.cover:setVisible(false)
		self.touchCover:setVisible(false)
		self._root:getChildByName("choosePanel"):setVisible(false)
	end)

	local var_7_0 = ccui.ImageView:create(var_0_30 .. "choose_bg.png", var_0_1)

	var_7_0:setTouchEnabled(true)

	local var_7_1 = var_7_0:getContentSize().height
	local var_7_2 = var_7_0:getContentSize().width

	for iter_7_0, iter_7_1 in pairs(var_0_44) do
		local var_7_3 = TempWidget:CreateTempLabel(L_COMPONENT_QUALITYS[iter_7_0], FONT_BUTTON, 28, var_7_0)

		var_7_3:setColor(iter_7_1)
		var_7_3:setPosition(var_7_2 / 5 * 2, var_7_1 / 5 * 3 - (iter_7_0 - 3) * var_7_0:getContentSize().height / 5 + 20)

		local var_7_4 = TempWidget:CreateTempImg(var_0_30 .. "choose_gou_off.png", var_7_0)

		var_7_4:setPosition(var_7_2 / 5 * 2 + var_7_3:getContentSize().width, var_7_1 / 5 * 3 - (iter_7_0 - 3) * var_7_1 / 5 + 20)
		var_7_4:setTouchEnabled(true)

		local var_7_5 = TempWidget:CreateTempImg(var_0_30 .. "choose_gou.png", var_7_0)

		var_7_5:setName("gou" .. iter_7_0)
		var_7_5:setVisible(self.gouList[iter_7_0])
		var_7_5:setPosition(var_7_2 / 5 * 2 + var_7_3:getContentSize().width, var_7_1 / 5 * 3 - (iter_7_0 - 3) * var_7_1 / 5 + 20)
		var_7_4:addTouchEventListener(function(arg_9_0, arg_9_1)
			if arg_9_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.gouList then
				self.gouList[iter_7_0] = not self.gouList[iter_7_0]
			else
				self.gouList = {}
				self.gouList[iter_7_0] = true
			end

			var_7_0:getChildByName("gou" .. iter_7_0):setVisible(self.gouList[iter_7_0])
		end)
	end

	local var_7_6 = ccui.Button:create(var_0_30 .. "choose_btnsure.png", nil, var_0_30 .. "choose_btnsure.png", var_0_1)

	var_7_0:addChild(var_7_6)
	var_7_6:setPosition(var_7_0:getContentSize().width / 2, -30)
	var_7_6:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_0_41 = {}

		for iter_10_0, iter_10_1 in pairs(self.resultList) do
			if not playermodel.items[iter_10_1].component_attr.use and self.gouList[var_0_5[playermodel.items[iter_10_1].itemid].equip_quality] and component_manager:getComponentAttrsInfo(iter_10_1).extra == 0 then
				table.insert(var_0_41, iter_10_1)
			end
		end

		self.listPanel:reloadData()

		self.gouList = {}

		self.cover:setVisible(false)
		self.touchCover:setVisible(false)
		self._root:getChildByName("choosePanel"):setVisible(false)
	end)

	return var_7_0
end

function ItemsPanelPartsLayer:initLayer()
	local var_11_0 = TempWidget:CreateTempLayout(self)

	var_11_0:setContentSize(GameDisplay.getUiScreenSize())
	var_11_0:_setBack()

	self._root = var_11_0

	local var_11_1 = TempWidget:CreateTempImg(var_0_30 .. "bg2.png", var_11_0)

	var_11_1:align(cc.p(0.5, 1), var_11_0:property().top_center)

	self.bg = var_11_1

	local var_11_2 = TempWidget:CreateTempImg(var_0_30 .. "top.png", var_11_0)

	var_11_2:align(cc.p(0.5, 1), var_11_0:property().top_center)
	var_11_2:setName("topBg")
	var_11_2:_addEvent(function()
		return
	end)

	local var_11_3 = TempWidget:CreateTempImg(var_0_30 .. "title.png", var_11_2)

	var_11_3:setName("title")
	var_11_3:align(cc.p(0, 0.5), 5, var_11_2:size().h / 2)

	local var_11_4 = TempWidget:CreateTempBtn(var_0_30 .. "plaint.png", var_11_2)

	var_11_4:align(cc.p(0, 0.5), var_11_3:pos().x + var_11_3:size().w, var_11_3:pos().y)
	var_11_4:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "rainbowchip_layer"
		})
	end)

	local var_11_5 = TempWidget:CreateTempBtn(var_0_30 .. "filter.png", var_11_2)

	var_11_5:align(cc.p(1, 0.5), var_11_2:size().w - 10, var_11_2:size().h / 2)

	self.filterBtn = var_11_5

	local var_11_6 = TempWidget:CreateTempBtn(var_0_30 .. "attr.png", var_11_2)

	var_11_6:align(cc.p(1, 0.5), var_11_5:pos().x - var_11_5:size().w - 20, var_11_5:pos().y)

	self.attrBtn = var_11_6

	local var_11_7 = TempWidget:CreateTempImg(var_0_30 .. "bottom.png", var_11_0)

	var_11_7:align(cc.p(0.5, 0), var_11_0:property().top_bottom)
	var_11_7:setLocalZOrder(10)
	var_11_7:_addEvent(function()
		return
	end)

	self.bottomBg = var_11_7

	local var_11_8 = TempWidget:CreateTempBtn(var_0_30 .. "back.png", var_11_7)

	var_11_8:align(cc.p(0, 0.5), 10, var_11_7:size().h / 2)

	self.backBtn = var_11_8

	local var_11_9 = TempWidget:CreateTempBtn(var_0_30 .. "btn2.png", var_11_7)

	var_11_9:setName("button2")
	var_11_9:align(cc.p(1, 0.5), var_11_7:size().w - 10, var_11_7:size().h / 2)

	self.bottomBtn2 = var_11_9

	self.bottomBtn2:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_15_0:isBright() then
			return
		end

		if self.equipedEntityid == -1 then
			audio_manager:playeffectMusicTest("sound/invalid")
			global_ShowBlockWords(L_COMPONENT_TEXT.No_equip)

			return
		end

		if self.usedcallback then
			arg_15_0:setBright(false)
			self.usedcallback(function()
				arg_15_0:setBright(true)
			end)
		end
	end)

	local var_11_10 = TempWidget:CreateTempLabel("", FONT_BUTTON, 22, var_11_9)

	var_11_10:_setColor("282f39")
	var_11_10:align(cc.p(0.5, 0.5), var_11_9:size().w / 2, var_11_9:size().h / 2 - 3)

	var_11_9.showLabel = var_11_10

	local var_11_11 = TempWidget:CreateTempBtn(var_0_30 .. "btn1.png", var_11_7)

	var_11_11:setName("button1")
	var_11_11:align(cc.p(1, 0.5), var_11_9:pos().x - var_11_9:size().w - 5, var_11_9:pos().y)

	self.bottomBtn1 = var_11_11

	local var_11_12 = TempWidget:CreateTempLabel(L_BUTTON_TEXT.Item_Panel_Btn.Strenthen, FONT_BUTTON, 22, var_11_11)

	var_11_12:_setColor("282f39")
	var_11_12:align(cc.p(0.5, 0.5), var_11_11:size().w / 2, var_11_11:size().h / 2 - 3)

	var_11_11.showLabel = var_11_12

	if var_0_38 == 1 then
		self:updateBottomLabel()
	end

	local var_11_13 = TempWidget:CreateTempLayout(var_11_0)

	var_11_13:setContentSize(cc.size(var_11_0:size().w, 180))
	var_11_13:setBackGroundColorOpacity(100)
	var_11_13:align(cc.p(0, 1), 0, var_11_2:pos().y - var_11_2:size().h - 5)

	self.itemEquiped = var_11_13

	cc.SpriteFrameCache:getInstance():addSpriteFrames("effect/parts_select/circuit.plist")

	local var_11_14 = cc.Sprite:createWithSpriteFrameName("circuit_00001.png")

	var_11_14:setAnchorPoint(cc.p(0.5, 0.5))
	var_11_14:setPosition(cc.p(var_11_13:size().w / 2, var_11_13:size().h / 2 - 4))
	var_11_13:addChild(var_11_14)

	local var_11_15 = cc.Animation:create()

	for iter_11_0 = 1, 78 do
		var_11_15:addSpriteFrame((cc.SpriteFrameCache:getInstance():getSpriteFrame(string.format("circuit_000%.2d.png", iter_11_0))))
	end

	var_11_15:setDelayPerUnit(0.04)
	var_11_15:setRestoreOriginalFrame(true)
	var_11_15:setLoops(-1)
	var_11_14:runAction(cc.Animate:create(var_11_15))

	local var_11_16 = TempWidget:CreateTempLayout(var_11_0)

	var_11_16:setContentSize(var_11_13:size())
	var_11_16:setBackGroundColorOpacity(100)
	var_11_16:_addEvent(function()
		return
	end)
	var_11_16:setLocalZOrder(1)
	var_11_16:align(cc.p(0, 1), var_11_13:pos().x, var_11_13:pos().y - var_11_13:size().h - 48)

	self.itemChoosed = var_11_16
	self.choosePosStartX = var_11_16:getPositionX()
	self.choosePosStartY = var_11_16:getPositionY()
end

function ItemsPanelPartsLayer:initListener()
	self._root:_addEvent(function()
		return
	end)
	self.backBtn:_addEvent(function()
		var_0_37.callbacklist.returnCallBack()
		LayerManager:removePopLayer()
	end)
	self.filterBtn:_addEvent(function()
		self:showFilterPop()
	end)
	self.attrBtn:_addEvent(function()
		self.isShowAttrs = not self.isShowAttrs

		self:updateShowingCells()
	end)
end

function ItemsPanelPartsLayer:onEnter()
	ItemsPanelPartsLayer.super.onEnter(self)
end

function ItemsPanelPartsLayer:onExit()
	ItemsPanelPartsLayer.super.onExit(self)
	cc.SpriteFrameCache:getInstance():removeSpriteFramesFromFile("effect/parts_select/circuit.plist")
	cc.Director:getInstance():getTextureCache():removeTextureForKey("effect/parts_select/circuit.png")
end

function ItemsPanelPartsLayer:initFilterPanelNew(arg_25_1)
	self.filterType = filter_config_manager.COMPONENT_ITEMPANEL
	self.curSortOrders = 1
	self.filterTbl = filter_config_manager:getDefaultFilterData(self.filterType, self.curSortOrders)
	self.curSort = self.filterTbl.sortType
	self.filterAniFlag = true
	self.filterAniFlag1 = true
	self.filterPopModel = false

	self:createFilterList()

	self.filterListData = self.filterList:getFilterData()
end

function ItemsPanelPartsLayer:createFilterList()
	self.filterList = FilterListSprite:create({
		defaultSelected = 1,
		style = "style_parts",
		bagLayerType = self.filterType,
		filterCallback = function(self)
			self.filterTbl.filterConfig[self.filterKey] = {
				self.filterValue
			}
			self.filterListData = self

			self:updateItemList()
		end
	})

	self.filterList:setAnchorPoint(cc.p(0, 0))
	self.filterList:setPositionY(self.bottomBg:size().h - 15)
	self._root:addChild(self.filterList)
	self.filterList:setLocalZOrder(1)
	self.filterList:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.MoveBy:create(0.1, cc.p(0, 15))))
end

function ItemsPanelPartsLayer:createTypeList()
	local var_28_0 = ccui.ImageView:create("ItemsPanelPartsLayer/typeBottom.png", var_0_1)

	self._root:addChild(var_28_0)
	var_28_0:setAnchorPoint(0, 0)
	var_28_0:setPosition(self.filterList:getPositionX(), self.bottomBg:size().h - 15 + 10)

	for iter_28_0 = 1, 3 do
		local var_28_1 = ccui.ImageView:create("ItemsPanelPartsLayer/type_" .. iter_28_0 .. "_off.png", var_0_1)

		var_28_1:setName("typeBtn" .. iter_28_0)
		self._root:addChild(var_28_1)
		var_28_1:setAnchorPoint(0, 0)
		var_28_1:setPosition(self.filterList:getPositionX() + (iter_28_0 - 1) * (var_28_1:getContentSize().width + 5), self.bottomBg:size().h - 15 + 10)
		var_28_1:setTouchEnabled(true)
		var_28_1:addTouchEventListener(function(arg_29_0, arg_29_1)
			if arg_29_1 ~= ccui.TouchEventType.ended then
				return
			end

			local level_manager = require("controller.level_manager")

			if iter_28_0 ~= 1 and not level_manager:isPlayerPassLevel(UNLOCK_RAINBOW_COMPONENT) then
				global_ShowBlockWords(string.format(L_LAYER_UNLOCKED, (level_manager:formatSystemUnlockLevel(UNLOCK_RAINBOW_COMPONENT))))

				return
			end

			for iter_29_0 = 1, 3 do
				self._root:getChildByName("typeBtn" .. iter_29_0):loadTexture("ItemsPanelPartsLayer/type_" .. iter_29_0 .. "_off.png", var_0_1)
			end

			self._root:getChildByName("typeBtn" .. iter_28_0):loadTexture("ItemsPanelPartsLayer/type_" .. iter_28_0 .. "_on.png", var_0_1)

			var_0_38 = iter_28_0

			self:UpdateUI()
		end)
	end

	self._root:getChildByName("typeBtn" .. var_0_38):loadTexture("ItemsPanelPartsLayer/type_" .. var_0_38 .. "_on.png", var_0_1)

	local var_28_2 = ccui.ImageView:create(var_0_30 .. "breakBottom.png", var_0_1)

	self._root:addChild(var_28_2, 100)
	var_28_2:setName("breakBottom")
	var_28_2:setAnchorPoint(cc.p(0, 0))
	var_28_2:setPosition(self.filterList:getPositionX(), self.bottomBg:size().h - 15 + 93)
	var_28_2:setTouchEnabled(true)

	local var_28_3 = ccui.Button:create(var_0_30 .. "breakBtn.png", nil, var_0_30 .. "breakBtn.png", var_0_1)

	var_28_2:addChild(var_28_3)
	var_28_3:setName("breakBtn")
	var_28_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_28_3:setPosition(var_28_2:getContentSize().width / 2, var_28_2:getContentSize().height / 2)
	var_28_3:setTouchEnabled(true)
	var_28_3:addTouchEventListener(function(arg_30_0, arg_30_1)
		if arg_30_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_30_0 = true

		if var_0_41 and type(var_0_41) == "table" and #var_0_41 > 0 then
			LayerManager:pushInLayer("PopDoLayer", {
				surecallback = function()
					for iter_31_0, iter_31_1 in ipairs(var_0_41) do
						if playermodel.items[iter_31_1].component_attr.use then
							component_manager:detachComponent(playermodel.items[iter_31_1].component_attr.use, var_0_5[playermodel.items[iter_31_1].itemid].pos)
						end
					end

					component_manager:BreakRemakeComponent(var_0_41, var_30_0, function(arg_32_0)
						if tolua.isnull(self) then
							return
						end

						for iter_32_0, iter_32_1 in ipairs(var_0_41) do
							if var_0_37.usedItem and var_0_37.usedItem[1] == iter_32_1 then
								var_0_37.usedItem = nil

								break
							end
						end

						self.itemChoosed:setVisible(false)
						self.bagManager:update()
						self:updateItemList()
						self.listPanel:reloadData()
					end)
				end,
				cancelcallback = function()
					return
				end,
				labels = {
					break_remake_bg = "public/panelbg/breakPopBg.png",
					isHorizonalCenter = true,
					button = L_COMPONENT_CHANGE.button,
					des = string.format(L_COMPONENT_BREAK_REMAKE.breakComponent1, #var_0_41),
					des2 = string.format(L_COMPONENT_BREAK_REMAKE.breakComponent2, component_manager:countNum(var_0_41))
				}
			})
		elseif var_30_0 then
			global_ShowBlockWords(L_COMPONENT_BREAK_REMAKE.chooseBreak)
		else
			global_ShowBlockWords(L_COMPONENT_BREAK_REMAKE.chooseRemake)
		end
	end)

	local var_28_4 = ccui.Button:create(var_0_30 .. "autoChooseBtn.png", nil, var_0_30 .. "autoChooseBtn.png", var_0_1)

	var_28_2:addChild(var_28_4)
	var_28_4:setName("breakBtn")
	var_28_4:setAnchorPoint(cc.p(0.5, 0.5))
	var_28_4:setPosition(var_28_2:getContentSize().width / 7 * 6, var_28_2:getContentSize().height / 2)
	var_28_4:setTouchEnabled(true)
	var_28_4:addTouchEventListener(function(arg_34_0, arg_34_1)
		if arg_34_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.gouList = {}

		if self._root:getChildByName("choosePanel") then
			self._root:getChildByName("choosePanel"):setVisible(true)
			self.cover:setVisible(true)
			self.touchCover:setVisible(true)

			for iter_34_0, iter_34_1 in pairs(var_0_44) do
				self._root:getChildByName("choosePanel"):getChildByName("gou" .. iter_34_0):setVisible(self.gouList[iter_34_0])
			end
		else
			local var_34_0 = self:createChoosePanel()

			var_34_0:setPosition(self._root:getContentSize().width / 2, self._root:getContentSize().height / 2)
			var_34_0:setName("choosePanel")
			self._root:addChild(var_34_0, 110)
		end
	end)
	var_28_2:setVisible(false)

	local var_28_5 = ccui.ImageView:create(var_0_30 .. "remakeBg.png", var_0_1)

	self._root:addChild(var_28_5, 10)
	var_28_5:setName("remakeBg")
	var_28_5:setAnchorPoint(cc.p(0.5, 1))
	var_28_5:setPosition(self._root:getChildByName("topBg"):getPositionX(), self._root:getChildByName("topBg"):getPositionY() - 273)

	local var_28_6 = ccui.Button:create(var_0_30 .. "remakeBtn.png", nil, var_0_30 .. "remakeBtn.png", var_0_1)

	var_28_5:addChild(var_28_6)
	var_28_6:setName("remakeBtn")
	var_28_6:setAnchorPoint(cc.p(0.5, 0.5))
	var_28_6:setPosition(var_28_5:getContentSize().width / 2, var_28_5:getContentSize().height / 2 - 90)
	var_28_6:addTouchEventListener(function(arg_35_0, arg_35_1)
		if arg_35_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_35_0 = {}

		table.insert(var_35_0, self.chooseNow)

		local function var_35_1(arg_36_0)
			if arg_36_0 == 1 then
				component_manager:BreakRemakeComponent(var_35_0, false, function(arg_37_0)
					if tolua.isnull(self) then
						return
					end

					for iter_37_0 = 1, #self.remakeUse do
						if type(self.remakeUse[iter_37_0]) == "number" then
							self._root:getChildByName("remakeBg"):getChildByName("remakeHavetext" .. iter_37_0):setString(global_trans_number(item_manager:getItemNumber(self.remakeUse[iter_37_0])))

							if item_manager:getItemNumber(self.remakeUse[iter_37_0]) < self.remakeUseNum[iter_37_0] then
								self._root:getChildByName("remakeBg"):getChildByName("remakeHavetext" .. iter_37_0):setColor(cc.c3b(255, 0, 0))
							else
								self._root:getChildByName("remakeBg"):getChildByName("remakeHavetext" .. iter_37_0):setColor(cc.c3b(255, 255, 255))
							end
						else
							self._root:getChildByName("remakeBg"):getChildByName("remakeHavetext" .. iter_37_0):setString(global_trans_number(playermodel.gold))

							if playermodel.gold < self.remakeUseNum[iter_37_0] then
								self._root:getChildByName("remakeBg"):getChildByName("remakeHavetext" .. iter_37_0):setColor(cc.c3b(255, 0, 0))
							else
								self._root:getChildByName("remakeBg"):getChildByName("remakeHavetext" .. iter_37_0):setColor(cc.c3b(255, 255, 255))
							end
						end
					end

					if var_0_37.usedItem and var_0_37.usedItem[1] == self.chooseNow then
						var_0_37.usedItem = nil
						self.usedItems = nil

						if playermodel.component[self.servantid] and playermodel.component[self.servantid][self.componentPos] then
							self.equipedEntityid = playermodel.component[self.servantid][self.componentPos].id or -1
						end
					end

					self.componentMapServantid[self.chooseNow] = nil
					self.chooseNow = nil

					self.bagManager:update()
					self:updateItemList()
					self.listPanel:reloadData()

					self.choosedTag = true

					self:updatePanelofCompareItems(arg_37_0.getitem.entityid)
				end)
			else
				return
			end
		end

		if self.chooseNow then
			LayerManager:pushInLayer("PopDoLayer", {
				surecallback = function()
					if playermodel.items[self.chooseNow].component_attr.use then
						component_manager:detachComponent(playermodel.items[self.chooseNow].component_attr.use, var_0_5[playermodel.items[self.chooseNow].itemid].pos, var_35_1)
					else
						var_35_1(1)
					end
				end,
				cancelcallback = function()
					return
				end,
				labels = {
					isHorizonalCenter = true,
					button = L_COMPONENT_CHANGE.button,
					des = string.format(L_COMPONENT_BREAK_REMAKE.remakeComponent, var_0_5[playermodel.items[self.chooseNow].itemid].name, playermodel.items[self.chooseNow].component_attr.extra)
				}
			})
		else
			global_ShowBlockWords(L_COMPONENT_BREAK_REMAKE.chooseRemake)
		end
	end)

	for iter_28_1 = 1, #self.remakeUse do
		local var_28_7 = ccui.ImageView:create(var_0_30 .. "remakeNeedBg.png", var_0_1)

		var_28_5:addChild(var_28_7)
		var_28_7:setAnchorPoint(cc.p(0.5, 0.5))
		var_28_7:setPosition(var_28_5:getContentSize().width / 4 * iter_28_1, var_28_5:getContentSize().height / 2 + 20)

		local var_28_8 = ccui.ImageView:create("equipment/" .. self.remakeUse[iter_28_1] .. ".png")

		var_28_8 = type(self.remakeUse[iter_28_1]) == "number" and ccui.ImageView:create("equipment/" .. self.remakeUse[iter_28_1] .. ".png") or ccui.ImageView:create("equipment/1000001.png")

		var_28_5:addChild(var_28_8)
		var_28_8:setScale(0.7)
		var_28_8:setAnchorPoint(cc.p(0.5, 0.5))
		var_28_8:setPosition(var_28_5:getContentSize().width / 4 * iter_28_1, var_28_5:getContentSize().height / 2 + 20)
		var_28_8:setTouchEnabled(true)

		local var_28_9 = cc.Label:createWithTTF("", FONT_DES, 18)

		var_28_9:setName("remakeHavetext" .. iter_28_1)
		var_28_5:addChild(var_28_9)
		var_28_9:setAnchorPoint(cc.p(1, 0.5))
		var_28_9:setPosition(var_28_5:getContentSize().width / 4 * iter_28_1 - 3, var_28_5:getContentSize().height / 2 - var_28_7:getContentSize().height / 2 + 10)

		if type(self.remakeUse[iter_28_1]) == "number" then
			var_28_9:setString(global_trans_number(item_manager:getItemNumber(self.remakeUse[iter_28_1])))

			if item_manager:getItemNumber(self.remakeUse[iter_28_1]) < self.remakeUseNum[iter_28_1] then
				var_28_9:setColor(cc.c3b(255, 0, 0))
			else
				var_28_9:setColor(cc.c3b(255, 255, 255))
			end

			var_28_8:addTouchEventListener(function(arg_40_0, arg_40_1)
				if arg_40_1 ~= ccui.TouchEventType.ended then
					return
				end

				LayerManager:pushInLayer("PopItemLayer", {
					itemid = self.remakeUse[iter_28_1]
				})
			end)
		else
			var_28_9:setString(global_trans_number(playermodel.gold))

			if playermodel.gold < self.remakeUseNum[iter_28_1] then
				var_28_9:setColor(cc.c3b(255, 0, 0))
			else
				var_28_9:setColor(cc.c3b(255, 255, 255))
			end
		end

		local var_28_10 = cc.Label:createWithTTF("", FONT_DES, 18)

		var_28_5:addChild(var_28_10)
		var_28_10:setString("/" .. global_trans_number(self.remakeUseNum[iter_28_1]))
		var_28_10:setAnchorPoint(cc.p(0, 0.5))
		var_28_10:setPosition(var_28_5:getContentSize().width / 4 * iter_28_1, var_28_5:getContentSize().height / 2 - var_28_7:getContentSize().height / 2 + 10)
	end

	var_28_5:setVisible(false)
end

function ItemsPanelPartsLayer:updateBottomLabel()
	self.bottomBtn1:show()
	self.bottomBtn2:show()

	if self.equipedEntityid == -1 then
		if self.lastSelectedEntityid then
			self.bottomBtn2.showLabel:setString(L_BUTTON_TEXT.Item_Panel_Btn.Switch)
		else
			self.bottomBtn1:hide()
			self.bottomBtn2:hide()
		end
	elseif self.lastSelectedEntityid then
		self.bottomBtn2.showLabel:setString(L_BUTTON_TEXT.Item_Panel_Btn.Switch)
	else
		self.bottomBtn1:hide()
		self.bottomBtn2.showLabel:setString(L_BUTTON_TEXT.Item_Panel_Btn.Unload)
	end
end

function ItemsPanelPartsLayer:initItemsList(arg_42_1)
	self:updateItemList()

	self.tableViewHeight = var_0_32 + GameDisplay.fix_y * 2 - GameDisplay.notch_height - 145

	self:createPanelofCompareItems()

	if arg_42_1 then
		if var_0_38 == 2 then
			self.listPanel = cc.TableView:create(cc.size(var_0_31, arg_42_1))

			self.listPanel:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
			self.listPanel:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
			self.listPanel:setDelegate()
			self._root:addChild(self.listPanel)
			self.listPanel:setName("itemList")
			self.listPanel:setPosition(cc.p(0, 230))
		else
			self.listPanel = cc.TableView:create(cc.size(var_0_31, arg_42_1))

			self.listPanel:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
			self.listPanel:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
			self.listPanel:setDelegate()
			self._root:addChild(self.listPanel)
			self.listPanel:setName("itemList")
			self.listPanel:setPosition(cc.p(0, 215))
		end
	else
		self.listPanel = cc.TableView:create(cc.size(var_0_31, self.tableViewHeight))

		self.listPanel:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
		self.listPanel:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
		self.listPanel:setDelegate()
		self._root:addChild(self.listPanel)
		self.listPanel:setName("itemList")
		self.listPanel:setPosition(cc.p(0, 220))
	end

	self.listPanel:registerScriptHandler(function(arg_43_0, arg_43_1)
		return var_0_33, var_0_34
	end, cc.TABLECELL_SIZE_FOR_INDEX)

	local function var_42_0(arg_44_0, arg_44_1)
		if arg_44_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.chooseNow = arg_44_0.entityid

		self.itemChoosed:setVisible(true)

		if math.abs(arg_44_0:getTouchBeganPosition().y - arg_44_0:getTouchEndPosition().y) > 50 then
			return
		end

		if var_0_38 == 2 then
			self:createBreakItemHightLight(arg_44_0)
		end

		if arg_44_0.selected then
			self.chooseNow = nil

			arg_44_0.selected:removeFromParent()
			self.itemChoosed:removeAllChildren()

			self.lastSelected.selected = nil
			self.choosedTag = false

			self:itemChangeUpdate(arg_44_0)

			if self.equipedEntityid == -1 then
				self.bottomBtn2:setVisible(false)
				self.bottomBtn2:setTouchEnabled(false)
			end

			self.bottomBtn1:setVisible(false)

			self.lastSelectedEntityid = nil

			GuideListener.cleanCurGuides()
			GuideListener.swallowEvent(false)
			GuideListener.lockGuideTrigger(false)
			GuideListener.updateGuides(self)

			return
		end

		if self.lastSelected and self.lastSelected.selected then
			self.lastSelected.selected:removeFromParent()

			self.lastSelected.selected = nil
		end

		self.lastSelected = arg_44_0
		self.lastSelectedNum = arg_44_0.index

		self:createItemHightLight(arg_44_0)
		self:updatePanelofCompareItems(arg_44_0.entityid)
		self:itemChangeUpdate(arg_44_0)

		if self.choosedTag == false then
			self.choosedTag = true
		end
	end

	self.listPanel:registerScriptHandler(function(arg_45_0, arg_45_1)
		local var_45_0 = arg_45_0:dequeueCell()

		if not var_45_0 then
			var_45_0 = cc.TableViewCell:create()

			for iter_45_0 = 1, var_0_35 do
				if self.itemList[var_0_35 * arg_45_1 + iter_45_0] then
					local var_45_1 = self:createItem(self.itemList[var_0_35 * arg_45_1 + iter_45_0])

					var_45_1:setCascadeOpacityEnabled(true)
					var_45_1:setName("sp_" .. arg_45_1 .. "_" .. iter_45_0)
					var_45_1:setPosition(var_0_36[iter_45_0])
					var_45_0:addChild(var_45_1)

					var_45_1.entityid = self.itemList[var_0_35 * arg_45_1 + iter_45_0]
					var_45_1.index = var_0_35 * arg_45_1 + iter_45_0
					self.itemBnts[var_0_35 * arg_45_1 + iter_45_0] = var_45_1

					if var_45_1:getChildByName("icon"):getChildByName("attr") then
						var_45_1:getChildByName("icon"):getChildByName("attr"):setVisible(self.isShowAttrs)
					end

					var_45_1:addTouchEventListener(var_42_0)

					if not self.lastSelected then
						-- block empty
					end
				end
			end
		else
			var_45_0:removeAllChildren()

			for iter_45_1 = 1, var_0_35 do
				if self.itemList[var_0_35 * arg_45_1 + iter_45_1] then
					local var_45_3 = self:createItem(self.itemList[var_0_35 * arg_45_1 + iter_45_1])

					var_45_3:setCascadeOpacityEnabled(true)
					var_45_3:setName("sp_" .. arg_45_1 .. "_" .. iter_45_1)
					var_45_3:setPosition(var_0_36[iter_45_1])
					var_45_0:addChild(var_45_3)

					var_45_3.entityid = self.itemList[var_0_35 * arg_45_1 + iter_45_1]

					for iter_45_2, iter_45_3 in pairs(var_0_41) do
						if iter_45_3 == var_45_3.entityid then
							local var_45_4 = TempWidget:CreateTempImg("ItemsPanelPartsLayer/breakChoosenImg.png")

							var_45_4:setScale(1.4)
							var_45_4:setPosition(var_45_3:getContentSize().width / 2, var_45_3:getContentSize().height / 2 + 1)
							var_45_3:addChild(var_45_4)

							var_45_3.breakSelected = var_45_4

							break
						end
					end

					var_45_3.index = var_0_35 * arg_45_1 + iter_45_1
					self.itemBnts[var_0_35 * arg_45_1 + iter_45_1] = var_45_3

					if var_45_3:getChildByName("icon"):getChildByName("attr") then
						var_45_3:getChildByName("icon"):getChildByName("attr"):setVisible(self.isShowAttrs)
					end

					var_45_3:addTouchEventListener(var_42_0)
				end
			end
		end

		if self.startRunOutAni then
			self.startIndex = self.startIndex or arg_45_1

			local var_45_5 = LAYER_OUT_TIME / math.ceil(self.tableViewHeight / var_0_34)

			for iter_45_4 = 1, var_0_35 do
				if var_45_0:getChildByName("sp_" .. arg_45_1 .. "_" .. iter_45_4) then
					var_45_0:getChildByName("sp_" .. arg_45_1 .. "_" .. iter_45_4):runAction(cc.Sequence:create(cc.DelayTime:create((arg_45_1 - self.startIndex) * var_45_5), cc.FadeOut:create(var_45_5)))
				end
			end
		end

		if self.selectTblAni then
			local var_45_6 = LAYER_OUT_TIME / math.ceil(self.tableViewHeight / var_0_34) * 1.5

			for iter_45_5 = 1, var_0_35 do
				if var_45_0:getChildByName("sp_" .. arg_45_1 .. "_" .. iter_45_5) then
					var_45_0:getChildByName("sp_" .. arg_45_1 .. "_" .. iter_45_5):setOpacity(0)
					var_45_0:getChildByName("sp_" .. arg_45_1 .. "_" .. iter_45_5):runAction(cc.Sequence:create(cc.DelayTime:create(arg_45_1 * var_45_6), cc.FadeIn:create(var_45_6)))
				end
			end
		else
			for iter_45_6 = 1, var_0_35 do
				if var_45_0:getChildByName("sp_" .. arg_45_1 .. "_" .. iter_45_6) then
					var_45_0:getChildByName("sp_" .. arg_45_1 .. "_" .. iter_45_6):setOpacity(255)
				end
			end
		end

		return var_45_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.listPanel:registerScriptHandler(function(arg_46_0, arg_46_1)
		return (math.ceil(#self.itemList / var_0_35))
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.listPanel:reloadData()
end

function ItemsPanelPartsLayer:updateItemList()
	local var_47_2 = {}
	local var_47_3 = {
		[ITEMPANEL_TYPE_ROLE_COMPONENT] = function()
			local var_48_0 = {}

			if var_0_38 == 1 then
				self.resultList = {}

				if self.itemConditions then
					self.filterTbl.filterConfig.pos = {
						self.itemConditions.pos[1]
					}
					self.filterTbl.filterConfig.soulid = {
						"soul_" .. servant_data[self.itemConditions.servantid].major,
						"all"
					}
					self.filterTbl.servantid = self.itemConditions.servantid
				end

				var_48_0 = self.bagManager:getBagData(self.filterTbl)

				local var_48_1

				for iter_48_0, iter_48_1 in pairs(var_48_0) do
					if iter_48_1 == self.equipedEntityid then
						var_48_1 = iter_48_0
					end
				end

				if var_48_1 then
					table.insert(var_48_0, 1, (table.remove(var_48_0, var_48_1)))
				end
			elseif var_0_38 == 2 then
				local var_48_2 = {}

				for iter_48_2, iter_48_3 in pairs(self.filterTbl) do
					var_48_2[iter_48_2] = iter_48_3
				end

				var_48_2.sortOrder = var_48_2.sortOrder == 0 and 1 or 0
				self.resultList = {}
				var_0_41 = {}
				var_47_2, var_48_0 = self.bagManager:getBagData(var_48_2)
			else
				self.resultList = {}

				local var_48_4

				var_47_2, var_48_4 = self.bagManager:getBagData(self.filterTbl)

				for iter_48_4, iter_48_5 in pairs(var_48_4) do
					if component_manager:getComponentInfo(iter_48_5).equip_quality == 6 then
						table.insert(var_48_0, iter_48_5)
					end
				end
			end

			self.resultList = var_48_0

			return self.resultList
		end
	}

	if var_47_3[self.panelType] then
		self.itemList = var_47_3[self.panelType]()
	end

	if self.usedItems and next(self.usedItems) then
		for iter_47_0, iter_47_1 in pairs(self.usedItems) do
			if tonumber(iter_47_1) ~= tonumber(self.equipedEntityid) then
				table.insert(self.itemList, 1, iter_47_1)
			end
		end
	end

	self.highestQuality = self:getHighestQuality()

	if self._root:getChildByName("itemList") then
		self.listPanel:reloadData()
	end
end

function ItemsPanelPartsLayer:getHighestQuality()
	local var_49_0

	for iter_49_0, iter_49_1 in pairs(self.itemList) do
		local var_49_1 = false

		if playermodel.items[iter_49_1].itemtype == kITEM_COMPONENT then
			if playermodel.items[iter_49_1].component_attr.use then
				var_49_1 = true
			end
		elseif playermodel.items[iter_49_1].itemtype == kITEM_WEAPON and playermodel.items[iter_49_1].weapon_attr.use then
			var_49_1 = true
		end

		if not var_49_1 then
			var_49_0 = math.max(var_49_0 or 1, var_0_5[playermodel.items[iter_49_1].itemid].equip_quality)
		end
	end

	return var_49_0
end

function ItemsPanelPartsLayer:createItemHightLight(arg_50_1)
	if arg_50_1.selected then
		return
	end

	local var_50_2 = TempWidget:CreateTempLayout()

	function var_50_2:play()
		self:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(1.25), cc.FadeIn:create(1.25))))
	end

	var_50_2:play()

	local var_50_3 = TempWidget:CreateTempImg("ItemsPanelPartsLayer/selecting.png")

	var_50_3:setScale(1.4)
	var_50_3:setPosition(arg_50_1:getContentSize().width / 2, arg_50_1:getContentSize().height / 2 + 1)
	var_50_2:addChild(var_50_3)
	var_50_2:setName("heightLight")
	arg_50_1:addChild(var_50_2)

	arg_50_1.selected = var_50_2
end

function ItemsPanelPartsLayer:createBreakItemHightLight(arg_52_1)
	if arg_52_1.breakSelected then
		for iter_52_0, iter_52_1 in pairs(var_0_41) do
			if iter_52_1 == arg_52_1.entityid then
				table.removebyvalue(var_0_41, iter_52_1)
			end
		end

		arg_52_1.breakSelected:removeFromParent()

		arg_52_1.breakSelected = nil

		return
	else
		table.insert(var_0_41, arg_52_1.entityid)

		local var_52_0 = TempWidget:CreateTempImg("ItemsPanelPartsLayer/breakChoosenImg.png")

		var_52_0:setScale(1.4)
		var_52_0:setPosition(arg_52_1:getContentSize().width / 2, arg_52_1:getContentSize().height / 2 + 1)
		arg_52_1:addChild(var_52_0)

		arg_52_1.breakSelected = var_52_0
	end
end

function ItemsPanelPartsLayer:updatePanelofCompareItems(arg_53_1)
	self.lastSelectedEntityid = arg_53_1

	GuideListener.cleanCurGuides()
	GuideListener.swallowEvent(false)
	GuideListener.lockGuideTrigger(false)
	GuideListener.updateGuides(self)

	if self.choosedTag == true then
		local var_53_6 = component_manager:getComponentAttrsInfo(arg_53_1)
		local var_53_8 = component_manager:getPotential(arg_53_1)
		local var_53_9 = ""

		for iter_53_0, iter_53_1 in ipairs(var_53_6.sub_attr) do
			if iter_53_0 > 1 then
				var_53_9 = var_53_9 .. "\n"
			end

			var_53_9 = var_53_9 .. iter_53_1
		end

		local var_53_10 = var_53_6.main_attr
		local var_53_12 = string.gsub(var_53_6.suit, L_COMPONENT_TEXT.Suit_Effect, L_COMPONENT_TEXT.Suit_Effect .. "\n")
		local var_53_13 = component_manager:getComponentAttrsInfo(arg_53_1, self.servantid)
		local var_53_14 = ""

		for iter_53_2, iter_53_3 in ipairs(var_53_13.sub_attr) do
			if iter_53_2 > 1 then
				var_53_14 = var_53_14 .. "\n"
			end

			var_53_14 = var_53_14 .. iter_53_3
		end

		local var_53_15 = var_53_13.main_attr
		local var_53_16 = var_53_14

		if playermodel.items[arg_53_1].component_attr.attr2 then
			self.itemChoosed:getChildByName("mainAttrImg"):loadTextureEx(string.format("ItemsPanelPartsLayer/main_attr_img%d.png", playermodel.items[arg_53_1].component_attr.attr1))
			self.itemChoosed:getChildByName("mainAttrImgBg2"):setAnchorPoint(cc.p(0.5, 0.5))
			self.itemChoosed:getChildByName("mainAttrImgBg2"):loadTexture("ItemsPanelPartsLayer/main_attr_img_bg.png", var_0_1)

			if self.itemChoosed:getChildByName("mainAttrImg2") then
				self.itemChoosed:getChildByName("mainAttrImg2"):loadTextureEx(string.format("ItemsPanelPartsLayer/main_attr_img%d.png", playermodel.items[arg_53_1].component_attr.attr2))
				self.itemChoosed:getChildByName("mainAttrImg2"):setVisible(true)
				self.itemChoosed:getChildByName("mainAttrLabel2"):setString(var_53_13.main_attr2)
				self.itemChoosed:getChildByName("mainAttrLabel2"):setVisible(true)
			else
				local var_53_17 = TempWidget:CreateTempImg(string.format("ItemsPanelPartsLayer/main_attr_img%d.png", playermodel.items[arg_53_1].component_attr.attr2), self.itemChoosed)

				var_53_17:setScale(0.7)
				var_53_17:move(self.itemChoosed:getChildByName("mainAttrImgBg2"):pos())
				var_53_17:setName("mainAttrImg2")
				self.itemChoosed:getChildByName("mainAttrImg2"):setVisible(true)

				local var_53_18 = TempWidget:CreateTempLabel(var_53_13.main_attr, FONT_DES, 20, self.itemChoosed)

				var_53_18:setName("mainAttrLabel2")
				var_53_18:setString(var_53_13.main_attr2)
				var_53_18:setLineBreakWithoutSpace(true)
				var_53_18:align(cc.p(0, 0.5), self.itemChoosed:getChildByName("otherDesLabel"):pos().x + 30, 3)
				self.itemChoosed:getChildByName("mainAttrLabel2"):setVisible(true)
			end
		else
			self.itemChoosed:getChildByName("mainAttrImg"):loadTextureEx(string.format("ItemsPanelPartsLayer/main_attr_img%d.png", var_53_13.main_attr_num))
			self.itemChoosed:getChildByName("mainAttrImgBg2"):setAnchorPoint(cc.p(0, 0.5))
			self.itemChoosed:getChildByName("mainAttrImgBg2"):loadTexture("ItemsPanelPartsLayer/isLocked.png", var_0_1)

			if self.itemChoosed:getChildByName("mainAttrImg2") then
				self.itemChoosed:getChildByName("mainAttrImg2"):setVisible(false)
				self.itemChoosed:getChildByName("mainAttrLabel2"):setVisible(false)
			end
		end

		self.itemChoosed:getChildByName("headBg"):setVisible(self.equipedEntityid == arg_53_1)
		self.itemChoosed:getChildByName("ItemIcon"):updateBigInfo(false, arg_53_1)

		if self.itemChoosed:getChildByName("ItemIcon"):getChildByName("use") then
			self.itemChoosed:getChildByName("ItemIcon"):getChildByName("use"):setOpacity(0)
		end

		self.itemChoosed:getChildByName("mainAttrLabel"):setString(var_53_10)
		self.itemChoosed:getChildByName("attributeLabel"):setString(var_53_13.suitName or "")
		self.itemChoosed:getChildByName("scoreLabel"):setString(var_53_8)
		self.itemChoosed:getChildByName("allScoreLabel"):setString("/" .. (component_manager:getMaxLevel(playermodel.items[arg_53_1].itemid) + 1) * 20)

		if COMPONENT_SERVANT_LIMIT[var_0_10[playermodel.items[arg_53_1].itemid].equip_quality] and core_manager:getServantCoreRank(self.servantid) < COMPONENT_SERVANT_LIMIT[var_0_10[playermodel.items[arg_53_1].itemid].equip_quality] or playermodel.items[arg_53_1].component_attr.extra < var_0_10[playermodel.items[arg_53_1].itemid].equip_quality * 5 then
			self.itemChoosed:getChildByName("limitMainAttrDesLabel"):setString(var_53_15)
			self.itemChoosed:getChildByName("limitSubAttrDesLabel"):setString(var_53_16)
		end

		if var_53_10 == var_53_15 then
			self.itemChoosed:getChildByName("limitTitleLabel"):setVisible(false)
			self.itemChoosed:getChildByName("limitMainAttrDesLabel"):setVisible(false)
			self.itemChoosed:getChildByName("limitSubAttrDesLabel"):setVisible(false)
			self.itemChoosed:getChildByName("line"):setVisible(false)
		else
			self.itemChoosed:getChildByName("limitTitleLabel"):setVisible(true)
			self.itemChoosed:getChildByName("limitMainAttrDesLabel"):setVisible(true)
			self.itemChoosed:getChildByName("limitSubAttrDesLabel"):setVisible(true)
			self.itemChoosed:getChildByName("line"):setVisible(true)
		end

		self.itemChoosed:getChildByName("otherDesLabel"):setString(string.sub(var_53_12, string.find(var_53_12, "：") + 3, -1))
		self.itemChoosed:getChildByName("mainTitleLabel"):setString(var_53_13.name)
		self.itemChoosed:getChildByName("reddotBg"):removeAllChildren()

		local var_53_19 = {}
		local var_53_20 = component_manager:getComponentStrengthenInfo(arg_53_1)

		for iter_53_4 = 1, 6 do
			if component_strengthen_weight_data[var_0_5[playermodel.items[arg_53_1].itemid].equip_quality]["add_weight" .. iter_53_4] > 0 then
				table.insert(var_53_19, iter_53_4)
			end
		end

		for iter_53_5 = 1, #var_53_19 do
			local var_53_21 = ccui.ImageView:create(var_0_43[var_53_19[iter_53_5]], var_0_1)

			var_53_21:setAnchorPoint(cc.p(0, 0.5))
			self.itemChoosed:getChildByName("reddotBg"):addChild(var_53_21)
			var_53_21:setPosition(0 - iter_53_5 * (var_53_21:getContentSize().width + 25), 0)

			local var_53_22 = cc.Label:createWithTTF("", FONT_DES, 22)

			var_53_22:setAnchorPoint(cc.p(0, 0.5))
			var_53_22:setString(var_53_20[var_53_19[iter_53_5]])
			var_53_22:setName("componentinfo_label_" .. var_53_19[iter_53_5])
			self.itemChoosed:getChildByName("reddotBg"):addChild(var_53_22)
			var_53_22:setPosition(var_53_21:getContentSize().width - iter_53_5 * (var_53_21:getContentSize().width + 25), 0)
		end
	else
		self:createItemDataPanel(self.itemChoosed, arg_53_1)
	end
end

function ItemsPanelPartsLayer:itemChangeUpdate(arg_54_1)
	if not arg_54_1 then
		return
	end

	local var_54_0 = arg_54_1.entityid

	if (not self.lastSelected and self.equipedEntityid ~= -1 or self.lastSelected and self.lastSelected.selected == nil and self.equipedEntityid ~= -1) and var_0_38 == 1 then
		self.bottomBtn1:setVisible(false)
		self.bottomBtn1:setTouchEnabled(false)

		if self.servantid then
			self.bottomBtn2:setVisible(true)
		else
			self.bottomBtn1:setPosition(self.bottomBtn2:getPosition())
		end

		self.bottomBtn2:setTouchEnabled(true)
		self.bottomBtn2.showLabel:setString(L_BUTTON_TEXT.Item_Panel_Btn.Unload)
		self.bottomBtn2:addTouchEventListener(function(arg_55_0, arg_55_1)
			if arg_55_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_55_0:isBright() then
				return
			end

			if self.equipedEntityid == -1 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_COMPONENT_TEXT.No_equip)

				return
			end

			if self.usedcallback then
				arg_55_0:setBright(false)

				if self.equipedEntityid == self.lastSelected.selected or self.equipedEntityid and not self.lastSelected.selected then
					self.usedcallback(function()
						arg_55_0:setBright(true)
					end)
				else
					self.usedcallback(self.equipedEntityid)
				end
			end
		end)
	elseif self.lastSelected and self.lastSelected.selected ~= nil and var_0_38 == 1 then
		if not arg_54_1 then
			return
		end

		self.bottomBtn1:setVisible(true)
		self.bottomBtn1:setTouchEnabled(true)

		if self.servantid then
			self.bottomBtn2:setVisible(true)
		else
			self.bottomBtn1:setPosition(self.bottomBtn2:getPosition())
		end

		self.bottomBtn2:setTouchEnabled(true)

		if self.lastSelected.entityid == self.equipedEntityid then
			self.bottomBtn2.showLabel:setString(L_BUTTON_TEXT.Item_Panel_Btn.Unload)
		elseif self.equipedEntityid ~= -1 and var_0_37.usedItem then
			self.bottomBtn2.showLabel:setString(L_BUTTON_TEXT.Item_Panel_Btn.Switch)
		else
			self.bottomBtn2.showLabel:setString(L_BUTTON_TEXT.Item_Panel_Btn.Equip)
		end

		self.bottomBtn2:addTouchEventListener(function(arg_57_0, arg_57_1)
			if arg_57_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_57_0:isBright() then
				return
			end

			if self.lastSelected.entityid == self.equipedEntityid then
				if self.usedcallback then
					arg_57_0:setBright(false)
					self.usedcallback(function()
						arg_57_0:setBright(true)
					end)
				end
			elseif arg_54_1.used then
				LayerManager:pushInLayer("PopDoLayer", {
					labels = {
						titleNewImage = "public/panelbg/title_item.png",
						title = L_COMPONENT_CHANGE.title,
						des = L_COMPONENT_CHANGE.des,
						button = L_COMPONENT_CHANGE.button
					},
					surecallback = function()
						if self.unusedcallback then
							arg_57_0:setBright(false)
							self.unusedcallback(var_54_0, function()
								arg_57_0:setBright(true)
							end)
						end
					end
				})
			elseif self.unusedcallback then
				arg_57_0:setBright(false)
				self.unusedcallback(var_54_0, function()
					arg_57_0:setBright(true)
				end)
			end
		end)
	else
		self.bottomBtn1:setVisible(false)
		self.bottomBtn1:setTouchEnabled(false)
		self.bottomBtn2:setVisible(false)
		self.bottomBtn2:setTouchEnabled(false)
	end

	if arg_54_1 then
		local var_54_1 = arg_54_1.entityid or -1

		if var_54_1 == -1 then
			return
		end
	end

	self.bottomBtn1:addTouchEventListener(function(arg_62_0, arg_62_1)
		if arg_62_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_54_1 == -1 then
			return
		end

		LayerManager:pushInLayer("PopComponentLayer", {
			entityid = var_54_1,
			itemid = playermodel.items[var_54_1].itemid,
			updateCallback = function(arg_63_0)
				if arg_63_0 == 1 then
					self.bagManager:update()
					self:updatePanelofCompareItems(var_54_1)
					self:updateItemList()
					self:updateShowingCells()
				elseif arg_63_0 == 4 then
					audio_manager:playeffectMusicTest("sound/invalid")
					global_ShowBlockWords(L_COMPONENT_TEXT.Warning[4])
					LayerManager:removePopLayer()
					LayerManager:pushInLayer("PopGoGainLayer", {
						item = "gold",
						goto_back_system_id = self.goto_back_system_id
					})
				end
			end
		})
	end)
end

function ItemsPanelPartsLayer:createItemDataPanel(arg_64_1, arg_64_2)
	local var_64_6 = component_manager:getComponentAttrsInfo(arg_64_2)
	local var_64_8 = component_manager:getPotential(arg_64_2)
	local var_64_9 = ""

	for iter_64_0, iter_64_1 in ipairs(var_64_6.sub_attr) do
		if iter_64_0 > 1 then
			var_64_9 = var_64_9 .. "\n"
		end

		var_64_9 = var_64_9 .. iter_64_1
	end

	local var_64_10 = var_64_6.main_attr
	local var_64_12 = string.gsub(var_64_6.suit, L_COMPONENT_TEXT.Suit_Effect, L_COMPONENT_TEXT.Suit_Effect .. "\n")
	local var_64_13 = component_manager:getComponentAttrsInfo(arg_64_2, self.servantid)
	local var_64_14 = ""

	for iter_64_2, iter_64_3 in ipairs(var_64_13.sub_attr) do
		if iter_64_2 > 1 then
			var_64_14 = var_64_14 .. "\n"
		end

		var_64_14 = var_64_14 .. iter_64_3
	end

	local var_64_15 = var_64_13.main_attr
	local var_64_16 = var_64_14
	local var_64_17 = var_64_13.main_attr_num

	if playermodel.items[arg_64_2].component_attr.attr2 then
		var_64_17 = playermodel.items[arg_64_2].component_attr.attr1
	end

	local var_64_18 = TempWidget:CreateTempLabel(var_64_13.suitName or "", FONT_DES, 24, arg_64_1)

	var_64_18:_setColor("08c3fb")
	var_64_18:align(cc.p(0, 0.5), 175, 123)
	var_64_18:setName("attributeLabel")

	local var_64_19 = TempWidget:CreateTempImg("ItemsPanelPartsLayer/suit_icon.png", arg_64_1)

	var_64_19:setName("suitIconImg")
	var_64_19:align(cc.p(0, 0.5), var_64_18:pos().x - var_64_19:size().w, var_64_18:pos().y)

	local var_64_20 = TempWidget:CreateTempLabel(string.sub(var_64_12, string.find(var_64_12, "：") + 3, -1), FONT_DES, 20, arg_64_1)

	var_64_20:setName("otherDesLabel")
	var_64_20:align(cc.p(0, 0.5), var_64_18:pos().x - 20, var_64_18:pos().y - 32)

	local var_64_21 = TempWidget:CreateTempImg("ItemsPanelPartsLayer/main_attr_img_bg.png", arg_64_1)

	var_64_21:move(165, 48)
	var_64_21:setName("mainAttrImgBg")

	local var_64_22 = TempWidget:CreateTempImg(string.format("ItemsPanelPartsLayer/main_attr_img%d.png", var_64_17), arg_64_1)

	var_64_22:setScale(0.7)
	var_64_22:move(var_64_21:pos())
	var_64_22:setName("mainAttrImg")

	local var_64_23 = TempWidget:CreateTempLabel(var_64_10, FONT_DES, 20, arg_64_1)

	var_64_23:setName("mainAttrLabel")
	var_64_23:setString(var_64_10)
	var_64_23:setLineBreakWithoutSpace(true)
	var_64_23:align(cc.p(0, 0.5), var_64_20:pos().x + 30, 48)

	if playermodel.items[arg_64_2].component_attr.attr2 then
		local var_64_24 = TempWidget:CreateTempImg("ItemsPanelPartsLayer/main_attr_img_bg.png", arg_64_1)

		var_64_24:move(165, 3)
		var_64_24:setName("mainAttrImgBg2")

		local var_64_25 = TempWidget:CreateTempImg(string.format("ItemsPanelPartsLayer/main_attr_img%d.png", playermodel.items[arg_64_2].component_attr.attr2), arg_64_1)

		var_64_25:setScale(0.7)
		var_64_25:move(var_64_24:pos())
		var_64_25:setName("mainAttrImg2")

		local var_64_26 = TempWidget:CreateTempLabel(var_64_13.main_attr, FONT_DES, 20, arg_64_1)

		var_64_26:setName("mainAttrLabel2")
		var_64_26:setString(var_64_13.main_attr2)
		var_64_26:setLineBreakWithoutSpace(true)
		var_64_26:align(cc.p(0, 0.5), var_64_20:pos().x + 30, 3)
	else
		local var_64_27 = TempWidget:CreateTempImg("ItemsPanelPartsLayer/isLocked.png", arg_64_1)

		var_64_27:setAnchorPoint(cc.p(0, 0.5))
		var_64_27:setName("mainAttrImgBg2")
		var_64_27:move(165, 3)
	end

	local var_64_28 = ItemSprite:createBigWithEntityId(arg_64_2)

	if var_64_28:getChildByName("use") then
		var_64_28:getChildByName("use"):setOpacity(255)
	end

	var_64_28:setAnchorPoint(cc.p(0.5, 0.5))
	var_64_28:setPosition(cc.p(85, arg_64_1:size().h / 2 - 20))
	var_64_28:setName("ItemIcon")
	var_64_28:setScale(0.7)
	arg_64_1:addChild(var_64_28)

	if var_64_28:getChildByName("lock") then
		var_64_28:getChildByName("lock"):setTouchEnabled(false)
	end

	local var_64_29 = TempWidget:CreateTempImg(var_0_30 .. "head_bg.png", arg_64_1)

	var_64_29:align(cc.p(0, 1), 27, arg_64_1:getContentSize().height - 33)
	var_64_29:setName("headBg")
	var_64_29:setVisible(self.equipedEntityid == arg_64_2)

	local var_64_30 = cc.ClippingNode:create()

	var_64_30:setAlphaThreshold(0.5)
	var_64_30:setContentSize(var_64_29:getContentSize())
	var_64_30:setAnchorPoint(cc.p(0, 0))
	var_64_30:setPosition(cc.p(0, 0))

	local var_64_31 = TempWidget:CreateTempSprite(var_0_30 .. "head_bg.png")

	var_64_31:align(cc.p(0, 0), 0, 0)
	var_64_30:setStencil(var_64_31)

	if self.servantid then
		local var_64_32 = TempWidget:CreateTempSprite("roleimage/role/portrait/" .. self.servantid .. ".png", nil, 0)

		var_64_32:setScale(0.5)
		var_64_32:align(cc.p(0, 0.5), -10, var_64_30:getContentSize().height / 2)
		var_64_30:addChild(var_64_32)
		var_64_29:addChild(var_64_30)
	end

	TempWidget:CreateTempImg(var_0_30 .. "head_bg_son.png", var_64_29):center()

	local var_64_33 = {
		lvLabel = cc.p(200, 350),
		weaponMainAttrLabel = cc.p(200, 330),
		weaponAttributeLabel = cc.p(200, 310),
		componentLabel = cc.p(200, 330),
		componentSubAttrDesLabel = cc.p(200, 290),
		componentLimitLabel = cc.p(200, 260),
		componentLimitMainAttrDesLabel = cc.p(200, 240),
		componentLimitSubAttrDesLabel = cc.p(200, 220)
	}

	local function var_64_34()
		local var_65_0 = TempWidget:CreateTempLabel(var_64_13.name, FONT_DES, 30, arg_64_1)

		var_65_0:setName("mainTitleLabel")
		var_65_0:align(cc.p(0, 0.5), var_64_20:pos().x, 155)

		local var_65_1 = cc.Label:createWithTTF(L_ATTR_EFFECT, FONT_DES, 20)

		var_65_1:setAnchorPoint(cc.p(0, 1))
		var_65_1:setPosition(var_64_33.componentLimitLabel)
		var_65_1:setMaxLineWidth(150)
		var_65_1:setColor(cc.c3b(255, 168, 0))
		var_65_1:setName("limitTitleLabel")
		arg_64_1:addChild(var_65_1)

		local var_65_2 = cc.Label:createWithTTF(var_64_15, FONT_DES, 20)

		var_65_2:setAnchorPoint(cc.p(0, 1))
		var_65_2:setPosition(var_64_33.componentLimitMainAttrDesLabel)
		var_65_2:setMaxLineWidth(150)
		var_65_2:setName("limitMainAttrDesLabel")
		arg_64_1:addChild(var_65_2)

		local var_65_3 = cc.Label:createWithTTF(var_64_16, FONT_DES, 20)

		var_65_3:setAnchorPoint(cc.p(0, 1))
		var_65_3:setPosition(var_64_33.componentLimitSubAttrDesLabel)
		var_65_3:setMaxLineWidth(150)
		var_65_3:setName("limitSubAttrDesLabel")
		arg_64_1:addChild(var_65_3)

		local var_65_4 = ccui.Layout:create()

		var_65_4:setTouchEnabled(true)
		var_65_4:setContentSize(cc.size(150, 2))
		var_65_4:setAnchorPoint(cc.p(0, 1))
		var_65_4:setPosition(cc.p(200, var_64_33.componentLimitLabel.y + 5))
		var_65_4:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_65_4:setBackGroundColor(cc.c3b(113, 119, 134))
		var_65_4:setBackGroundColorOpacity(255)
		var_65_4:setName("line")
		arg_64_1:addChild(var_65_4)
	end

	local var_64_35 = TempWidget:CreateTempLabel("/" .. (component_manager:getMaxLevel(playermodel.items[arg_64_2].itemid) + 1) * 20, FONT_NAME, 16, arg_64_1)

	var_64_35:setColor(cc.c3b(255, 255, 255))
	var_64_35:align(cc.p(1, 0), arg_64_1:size().w - 22, arg_64_1:size().h - 37)
	var_64_35:setName("allScoreLabel")

	local var_64_36 = TempWidget:CreateTempLabel(var_64_8, FONT_NAME, 20, arg_64_1)

	var_64_36:setName("scoreLabel")
	var_64_36:setColor(cc.c3b(252, 207, 8))
	var_64_36:align(cc.p(1, 0), var_64_35:pos().x - var_64_35:size().w, var_64_35:pos().y)

	if COMPONENT_SERVANT_LIMIT[var_0_10[playermodel.items[arg_64_2].itemid].equip_quality] and core_manager:getServantCoreRank(servantid) < COMPONENT_SERVANT_LIMIT[var_0_10[playermodel.items[arg_64_2].itemid].equip_quality] or playermodel.items[arg_64_2].component_attr.extra < var_0_10[playermodel.items[arg_64_2].itemid].equip_quality * 5 then
		var_64_34()
	end

	if var_64_10 == var_64_15 then
		if not arg_64_1:getChildByName("limitTitleLabel") then
			var_64_34()
		end

		arg_64_1:getChildByName("limitTitleLabel"):setVisible(false)
		arg_64_1:getChildByName("limitMainAttrDesLabel"):setVisible(false)
		arg_64_1:getChildByName("limitSubAttrDesLabel"):setVisible(false)
		arg_64_1:getChildByName("line"):setVisible(false)
	end

	local var_64_37 = ccui.Layout:create()

	var_64_37:setTouchEnabled(false)
	var_64_37:setAnchorPoint(1, 0.5)
	var_64_37:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_64_37:setName("reddotBg")
	arg_64_1:addChild(var_64_37, 100)
	var_64_37:setPosition(var_64_35:getPositionX() - 10, var_64_35:getPositionY() - 160)

	local var_64_38 = {}
	local var_64_39 = component_manager:getComponentStrengthenInfo(arg_64_2)

	for iter_64_4 = 1, 6 do
		if component_strengthen_weight_data[var_0_5[playermodel.items[arg_64_2].itemid].equip_quality]["add_weight" .. iter_64_4] > 0 then
			table.insert(var_64_38, iter_64_4)
		end
	end

	for iter_64_5 = 1, #var_64_38 do
		local var_64_40 = ccui.ImageView:create(var_0_43[var_64_38[iter_64_5]], var_0_1)

		var_64_40:setAnchorPoint(cc.p(0, 0.5))
		var_64_37:addChild(var_64_40)
		var_64_40:setPosition(0 - iter_64_5 * (var_64_40:getContentSize().width + 25), 0)

		local var_64_41 = cc.Label:createWithTTF("", FONT_DES, 22)

		var_64_41:setAnchorPoint(cc.p(0, 0.5))
		var_64_41:setString(var_64_39[var_64_38[iter_64_5]])
		var_64_41:setName("componentinfo_label_" .. var_64_38[iter_64_5])
		var_64_37:addChild(var_64_41)
		var_64_41:setPosition(var_64_40:getContentSize().width - iter_64_5 * (var_64_40:getContentSize().width + 25), 0)
	end
end

function ItemsPanelPartsLayer:createItem(arg_66_1)
	local var_66_1 = playermodel.items[arg_66_1]
	local var_66_2 = playermodel.items[arg_66_1] and "entityid" or "itemid"
	local var_66_3

	if playermodel.items[arg_66_1] then
		var_66_3 = var_0_5[var_66_1.itemid] or var_0_5[arg_66_1]
	end

	local var_66_4 = ccui.Button:create("public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", var_0_1)

	var_66_4:setScale(0.68)
	var_66_4:setSwallowTouches(false)

	local var_66_5

	if var_66_2 == "entityid" then
		var_66_5 = ItemSprite:createBigWithEntityId(arg_66_1, var_66_3.bag_item_type == kITEM_FURNITURE and var_0_45(arg_66_1) or nil, self.servantid)
	elseif var_66_2 == "itemid" then
		var_66_5 = ItemSprite:createNewWithItemId(arg_66_1)
	end

	var_66_5:setName("icon")

	if var_66_5:getChildByName("use") then
		var_66_5:getChildByName("use"):setOpacity(0)
	end

	var_66_5:setPosition(var_66_4:getContentSize().width / 2, var_66_4:getContentSize().height / 2)
	var_66_4:addChild(var_66_5)

	if var_66_5:getChildByName("lock") then
		var_66_5:getChildByName("lock"):setTouchEnabled(false)
		var_66_5:getChildByName("lock"):setVisible(false)
	end

	local var_66_6 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_1)

	var_66_6:setPositionX(var_66_4:getContentSize().width - 10)
	var_66_6:setPositionY(var_66_4:getContentSize().height - 10)
	var_66_6:setName("redDot")
	var_66_6:setVisible(self:isShowRedDot(arg_66_1))
	var_66_4:addChild(var_66_6, 100)

	if self.itemType == kITEM_COMPONENT and self.goto_back_system_id == 301 and self.servantid then
		local var_66_7, var_66_8 = component_manager:isRecommendComponent(self.servantid, arg_66_1)
		local var_66_9 = var_66_4:getChildByName("imgRecommend")

		if not var_66_9 and var_66_7 then
			var_66_9 = ccui.ImageView:create("itempanel/bg_recommend.png", var_0_1)

			local var_66_10 = ccui.ImageView:create(string.format("itempanel/recommend_%d.png", var_66_8), var_0_1)

			var_66_10:setPosition(var_66_9:getContentSize().width / 2 + 5, var_66_9:getContentSize().height / 2)
			var_66_9:addChild(var_66_10)
			var_66_9:setPosition(var_66_4:getContentSize().width / 2 + 35, var_66_4:getContentSize().height / 2 + 95)
			var_66_9:setName("imgRecommend")
			var_66_4:addChild(var_66_9, 99)
		end

		if var_66_9 then
			var_66_9:setVisible(var_66_7)
		end
	end

	if var_66_3.bag_item_type == kITEM_COMPONENT and var_66_1.component_attr.use then
		var_66_4.used = true
	end

	local function var_66_11(arg_67_0)
		local var_67_0 = TempWidget:CreateTempImg(var_0_30 .. "head_bg.png", var_66_5)

		var_67_0:align(cc.p(0, 1), 2, var_66_5:getContentSize().height - 2)
		var_67_0:setScale(1.5)

		local var_67_1 = cc.ClippingNode:create()

		var_67_1:setAlphaThreshold(0.5)
		var_67_1:setContentSize(var_67_0:getContentSize())
		var_67_1:setAnchorPoint(cc.p(0, 0))
		var_67_1:setPosition(cc.p(0, 0))

		local var_67_2 = TempWidget:CreateTempSprite(var_0_30 .. "head_bg.png")

		var_67_2:align(cc.p(0, 0), 0, 0)
		var_67_1:setStencil(var_67_2)

		local var_67_3 = TempWidget:CreateTempSprite("roleimage/role/portrait/" .. arg_67_0 .. ".png", nil, 0)

		var_67_3:setScale(0.5)
		var_67_3:align(cc.p(0, 0.5), -10, var_67_1:getContentSize().height / 2)
		var_67_1:addChild(var_67_3)
		var_67_0:addChild(var_67_1)
		TempWidget:CreateTempImg(var_0_30 .. "head_bg_son.png", var_67_0):center()
	end

	if self.equipedEntityid == arg_66_1 and var_0_37.usedItem then
		var_66_11(self.servantid)
	elseif self.componentMapServantid[arg_66_1] then
		var_66_11(self.componentMapServantid[arg_66_1])
	end

	return var_66_4
end

function ItemsPanelPartsLayer:isShowRedDot(arg_68_1)
	local var_68_0 = self.initParamComponentScore or 0

	if playermodel.items[arg_68_1].component_attr.use then
		return false
	end

	if var_68_0 < component_manager:getScore(arg_68_1) and (not self.componentEffectid or self.componentEffectid == playermodel.items[arg_68_1].component_attr.effect) then
		local var_68_2 = var_0_5[playermodel.items[arg_68_1].itemid].pos

		if self.componentEffectid and playermodel.component[self.servantid] and playermodel.component[self.servantid][var_68_2] then
			local var_68_3 = playermodel.component[self.servantid][var_68_2] and playermodel.component[self.servantid][var_68_2].id

			if var_68_3 and var_0_10[playermodel.items[arg_68_1].itemid].main_attr ~= var_0_10[playermodel.items[var_68_3].itemid].main_attr then
				return false
			end
		end

		if self.highestQuality then
			if var_0_5[playermodel.items[arg_68_1].itemid].equip_quality == self.highestQuality then
				return true
			end
		else
			return true
		end
	end

	return false
end

function ItemsPanelPartsLayer:createPanelofCompareItems()
	self.itemEquiped:setVisible(true)
	self.itemChoosed:setVisible(true)

	if not var_0_37.usedItem or self.equipedEntityid == -1 or var_0_38 ~= 1 then
		self.bg:loadTextureEx(var_0_30 .. "bg.png", var_0_1)
		self.itemEquiped:setVisible(false)
		self.itemChoosed:setPosition(cc.p(self.itemEquiped:getPosition()))

		self.tableViewHeight = self.tableViewHeight + 200
	elseif var_0_38 == 1 and var_0_38 ~= var_0_39 then
		self.itemEquiped:setVisible(true)
	else
		self:createItemDataPanel(self.itemEquiped, self.equipedEntityid)
	end
end

function ItemsPanelPartsLayer:getItemListLen()
	local var_70_0 = math.ceil(#self.itemList / var_0_35)

	if var_70_0 < 5 then
		var_70_0 = 5
	end

	return var_70_0
end

function ItemsPanelPartsLayer:updateShowingCells(arg_71_1)
	local var_71_0, var_71_1 = GetTableViewShowCellIdx(self.listPanel, {
		cellsize = cc.size(var_0_33, var_0_34),
		maxcount = self:getItemListLen()
	})

	for iter_71_0 = var_71_0, var_71_1 do
		self.listPanel:updateCellAtIndex(iter_71_0)
	end

	if self.furnitureSuitlist then
		local var_71_2, var_71_3 = GetTableViewShowCellIdx(self.furnitureSuitlist, {
			cellsize = cc.size(586, 320),
			maxcount = #self.shopList + #self.suitList
		})

		for iter_71_1 = var_71_2, var_71_3 do
			self.furnitureSuitlist:updateCellAtIndex(iter_71_1)
		end
	end
end

function ItemsPanelPartsLayer:showFilterPop()
	self.filterListData = self.filterList:getFilterData()

	local var_72_0 = self.filterListData.col
	local var_72_1 = {}

	if not self.filterListData.filterValue then
		if self.filterList:getTouchFlag() then
			for iter_72_0, iter_72_1 in pairs(self.filterListData.btnState) do
				var_72_1[iter_72_0] = 0
			end

			self.filterList:setTouchFlag(false)
		end
	else
		for iter_72_2, iter_72_3 in pairs(self.filterListData.btnState) do
			var_72_1[iter_72_2] = iter_72_3 == 1 and -2 or -1
		end
	end

	if self.filterSpritePop then
		self.filterSpritePop:setFilterBtnState(var_72_0, var_72_1)
		self.filterSpritePop:setSortOrderState(1, self.curSortOrders == 0 and {
			0,
			1
		} or {
			1,
			0
		})
		self.filterSpritePop:updateAllFilterBtn()
		self.filterSpritePop:playPopAni()
	else
		self.filterSpritePop = self:createFilterPop()

		self._root:addChild(self.filterSpritePop, 1000)
	end
end

function ItemsPanelPartsLayer:refreshFilterPop()
	local var_73_0 = {}

	for iter_73_0, iter_73_1 in pairs(self.filterListData.btnState) do
		var_73_0[iter_73_0] = 0
	end

	self.filterSpritePop:setFilterBtnState(self.filterListData.col, var_73_0)
	self.filterSpritePop:updateAllFilterBtn()
end

function ItemsPanelPartsLayer:createFilterPop()
	local function var_74_0(arg_76_0)
		if self.filterAniFlag1 then
			self.filterAniFlag1 = false

			self._root:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
				self.filterAniFlag1 = true
				self.filterAniFlag = true
			end)))
			arg_76_0()
		end
	end

	local function var_74_1(arg_78_0)
		self:sortCallback(arg_78_0)
	end

	local var_74_2 = self.filterListData.col or {}
	local var_74_3 = self.filterListData.btnState or {}
	local var_74_4 = {}
	local var_74_5 = false

	for iter_74_0, iter_74_1 in pairs(var_74_3) do
		if iter_74_1 == 1 then
			var_74_5 = true
		end
	end

	for iter_74_2, iter_74_3 in pairs(var_74_3) do
		var_74_4[iter_74_2] = var_74_5 and (iter_74_3 == 1 and -2 or -1) or iter_74_3
	end

	return (FilterItemsPanelParts:create({
		filterType = self.filterType,
		filterCallback = function(arg_75_0)
			self:filterCallback(arg_75_0)
		end,
		maskTouchCallback = var_74_0,
		sortOrderChangeCallback = var_74_1,
		initButtonConfig = {
			[var_74_2] = var_74_4
		},
		defaultSortOrder = self.curSortOrders == 1 and 0 or 1
	}))
end

function ItemsPanelPartsLayer:filterCallback(arg_79_1)
	self.filterTbl.sortType = arg_79_1.sortType or self.filterTbl

	for iter_79_0, iter_79_1 in pairs(arg_79_1.filterConfig) do
		self.filterTbl.filterConfig[iter_79_0] = global_deepCopy(iter_79_1)
	end

	self.curSort = self.filterTbl.sortType

	self:updateItemList()

	if self.panelType == ITEMPANEL_TYPE_ROLE_COMPONENT or self.panelType == ITEMPANEL_TYPE_ROLE_WEAPON then
		self:updateChoosedPanelbyRank()
	end
end

function ItemsPanelPartsLayer:updateChoosedPanelbyRank()
	self.choosedTag = false

	if self.lastSelected then
		self.lastSelected.selected = nil
	end

	self.itemChoosed:removeAllChildren()
	self:itemChangeUpdate(nil)
end

function ItemsPanelPartsLayer:sortCallback(arg_81_1)
	self.orderType = arg_81_1
	self.curSortOrders = arg_81_1

	self.bagManager:reverseOrder(self.resultList)
	self:updateShowingCells()
end

function ItemsPanelPartsLayer:UpdateUI()
	if var_0_38 == 1 and var_0_38 ~= var_0_39 then
		self.filterList:setFilterData(1)

		self.filterTbl = filter_config_manager:getDefaultFilterData(self.filterType, self.curSortOrders)

		if self.filterSpritePop then
			self:refreshFilterPop()
		end

		self.chooseNow = nil

		self._root:getChildByName("topBg"):getChildByName("title"):loadTexture("ItemsPanelPartsLayer/title.png", var_0_1)
		self._root:getChildByName("breakBottom"):setVisible(false)
		self._root:getChildByName("remakeBg"):setVisible(false)
		self.itemEquiped:setVisible(true)

		if var_0_37.usedItem then
			self.bg:loadTexture("ItemsPanelPartsLayer/bg2.png", var_0_1)
			self.itemChoosed:setPosition(self.choosePosStartX, self.choosePosStartY)
			self._root:getChildByName("itemList"):removeFromParent()
			self:initItemsList()
		else
			self._root:getChildByName("itemList"):removeFromParent()
			self:initItemsList()
		end

		self.itemChoosed:setVisible(false)
		self.filterList:setVisible(true)

		self.lastSelectedEntityid = nil
		var_0_41 = {}

		self:updateBottomLabel()

		var_0_39 = 1
	elseif var_0_38 == 2 and var_0_38 ~= var_0_39 then
		self.filterList:setFilterData(1)

		self.filterTbl = filter_config_manager:getDefaultFilterData(self.filterType, self.curSortOrders)

		if self.filterSpritePop then
			self:refreshFilterPop()
		end

		self.chooseNow = nil

		self:createPanelofCompareItems()
		self._root:getChildByName("topBg"):getChildByName("title"):loadTexture("ItemsPanelPartsLayer/breakTitle.png", var_0_1)
		self._root:getChildByName("breakBottom"):setVisible(true)
		self._root:getChildByName("remakeBg"):setVisible(false)
		self.bg:loadTexture("ItemsPanelPartsLayer/bg.png", var_0_1)
		self._root:getChildByName("itemList"):removeFromParent()
		self:initItemsList(var_0_32 + GameDisplay.fix_y * 2 - GameDisplay.notch_height + 55)
		self.itemChoosed:setVisible(false)
		self.filterList:setVisible(false)

		self.lastSelectedEntityid = nil

		self.bottomBtn1:hide()
		self.bottomBtn2:hide()

		var_0_41 = {}
		var_0_39 = 2
	elseif var_0_38 == 3 and var_0_38 ~= var_0_39 then
		self.filterList:setFilterData(1)

		self.filterTbl = filter_config_manager:getDefaultFilterData(self.filterType, self.curSortOrders)

		if self.filterSpritePop then
			self:refreshFilterPop()
		end

		self.chooseNow = nil

		self:createPanelofCompareItems()
		self._root:getChildByName("topBg"):getChildByName("title"):loadTexture("ItemsPanelPartsLayer/reMakeTitle.png", var_0_1)
		self.bg:loadTexture("ItemsPanelPartsLayer/bg.png", var_0_1)
		self._root:getChildByName("breakBottom"):setVisible(false)
		self._root:getChildByName("remakeBg"):setVisible(true)
		self._root:getChildByName("itemList"):removeFromParent()
		self:initItemsList(var_0_32 + GameDisplay.fix_y * 2 - GameDisplay.notch_height - 205)
		self.itemChoosed:setVisible(false)
		self.filterList:setVisible(true)

		self.lastSelectedEntityid = nil

		self.bottomBtn1:hide()
		self.bottomBtn2:hide()

		for iter_82_0 = 1, #self.remakeUse do
			if type(self.remakeUse[iter_82_0]) == "number" then
				self._root:getChildByName("remakeBg"):getChildByName("remakeHavetext" .. iter_82_0):setString(global_trans_number(item_manager:getItemNumber(self.remakeUse[iter_82_0])))

				if item_manager:getItemNumber(self.remakeUse[iter_82_0]) < self.remakeUseNum[iter_82_0] then
					self._root:getChildByName("remakeBg"):getChildByName("remakeHavetext" .. iter_82_0):setColor(cc.c3b(255, 0, 0))
				else
					self._root:getChildByName("remakeBg"):getChildByName("remakeHavetext" .. iter_82_0):setColor(cc.c3b(255, 255, 255))
				end
			else
				self._root:getChildByName("remakeBg"):getChildByName("remakeHavetext" .. iter_82_0):setString(global_trans_number(playermodel.gold))

				if playermodel.gold < self.remakeUseNum[iter_82_0] then
					self._root:getChildByName("remakeBg"):getChildByName("remakeHavetext" .. iter_82_0):setColor(cc.c3b(255, 0, 0))
				else
					self._root:getChildByName("remakeBg"):getChildByName("remakeHavetext" .. iter_82_0):setColor(cc.c3b(255, 255, 255))
				end
			end
		end

		var_0_41 = {}
		var_0_39 = 3
	end
end

return ItemsPanelPartsLayer
