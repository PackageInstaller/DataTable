PopBuyChatEmotationGiftLayer = class("PopBuyChatEmotationGiftLayer", function()
	return PopBaseLayer:create()
end)

require("view.Layer.PopLayer")

local item_data = require("data.item_data")
local drop_data = require("data.drop_data")
local level_manager = require("controller.level_manager")
local playermodel = require("model.playermodel")
local account_manager = require("controller.account_manager")
local chat_system_manager = require("controller.chat_system_manager")
local activity_manager = require("controller.activity_manager")
local chat_emotion_item_data = require("data.chat_emotion_item_data")
local var_0_8 = config._DEBUG and 0 or 1
local var_0_9 = 600
local var_0_10 = 160
local var_0_11 = {
	cc.p(6, 20),
	cc.p(146, 20),
	cc.p(286, 20),
	(cc.p(426, 20))
}

function PopBuyChatEmotationGiftLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopBuyChatEmotationGiftLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopBuyChatEmotationGiftLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopBuyChatEmotationGiftLayer.json" or "PopBuyChatEmotationGiftLayer.ExportJson")

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	local var_3_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "topimg")
	local var_3_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "botttomimg")
	local var_3_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_29")

	var_3_2:getChildByName("Label_30"):setString("确 定")

	self.items = ccui.Helper:seekWidgetByName(self.rootLayer, "items")

	if arg_3_1 then
		self.ShopSliderCallback = arg_3_1.ShopSliderCallback or nil
	end

	if arg_3_1 then
		self.limtbuy = arg_3_1.limit_buy_num or 0
	end

	if arg_3_1 then
		self.havebuy = arg_3_1.have_bought_num or 0
	end

	if arg_3_1 then
		self.iconpath = arg_3_1.costIcon or nil
	end

	if arg_3_1 then
		self.costnum = arg_3_1.cost_old or nil
	end

	if arg_3_1 then
		self.itemid = arg_3_1.itemid or nil
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_1"):addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)

	local var_3_3 = ccui.Layout:create()

	var_3_3:setTouchEnabled(true)
	var_3_3:setContentSize(cc.size(640, 570))
	var_3_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_3_3:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2))
	var_3_3:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_3_3:setBackGroundColor(cc.c3b(0, 0, 0))
	var_3_3:setBackGroundColorOpacity(255)
	self.rootLayer:addChild(var_3_3, 2)

	self.rootpanel = var_3_3
	self.itemtop = var_3_0:clone()
	self.bottomtop = var_3_1:clone()
	self.surebtn = var_3_2:clone()
	self.tableviewlayer = ccui.Helper:seekWidgetByName(self.bottomtop, "tableviewlayer")

	self.rootpanel:addChild(self.itemtop)
	self.rootpanel:addChild(self.bottomtop)
	self.itemtop:setPosition(cc.p(var_3_3:getContentSize().width / 2, var_3_3:getContentSize().height - self.itemtop:getContentSize().height / 2))
	self.bottomtop:setPosition(cc.p(self.bottomtop:getContentSize().width / 2 + 10, self.itemtop:getPositionY() - self.itemtop:getContentSize().height / 2 - 30))
	self.surebtn:setPosition(cc.p(320, -self.surebtn:getContentSize().height / 2 + 10))
	self.rootpanel:addChild(self.surebtn)

	self.timelable = ccui.Helper:seekWidgetByName(self.itemtop, "Label_limit")

	self:initUI()
	global_window_open_action(self.rootpanel)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			-- block empty
		end
	end)
end

function PopBuyChatEmotationGiftLayer:initUI()
	self.data = self:getDataFromDrop()

	self:updateLeftTime()
	self.surebtn:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.ShopSliderCallback then
			self.ShopSliderCallback(arg_8_0, arg_8_1, function()
				self.hideActions.shrinkVertical(self, function()
					LayerManager:removePopLayer(self.__queueindex)
				end)
			end)
		end
	end)
	self:createCostIcon()

	local var_7_0 = cc.TableView:create(cc.size(self.tableviewlayer:getContentSize().width, self.tableviewlayer:getContentSize().height))

	var_7_0:setPosition(0, 0)
	var_7_0:setDelegate()
	var_7_0:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	var_7_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_7_0:setName("tableview_emotion")
	self.tableviewlayer:addChild(var_7_0, 99)

	self.tableviewemotion = var_7_0

	self:initEmotionTableView()
end

function PopBuyChatEmotationGiftLayer:createCostIcon()
	local var_11_9000

	if self.iconpath then
		local var_11_0 = ccui.ImageView:create(self.iconpath, var_0_8)

		var_11_0:setPosition(cc.p(self.surebtn:getContentSize().width / 2 - 40, -10))
		var_11_0:setName("costicon")
		self.surebtn:addChild(var_11_0)

		if self.costnum then
			local var_11_1 = cc.Label:createWithTTF("x" .. self.costnum, "fonts/number.ttf", 20)

			var_11_1:setAnchorPoint(cc.p(0, 0.5))
			var_11_1:setPosition(cc.p(self.surebtn:getChildByName("costicon"):getPositionX() + var_11_9000 + 10, self.surebtn:getChildByName("costicon").getPositionY(self.surebtn:getChildByName("costicon"):getContentSize().width / 2)))
			var_11_1:setName("costnum")
			self.surebtn:addChild(var_11_1)
		end
	end
end

function PopBuyChatEmotationGiftLayer:updateLeftTime()
	self.timelable:setString(self.havebuy .. "/" .. self.havebuy + self.limtbuy)
end

function PopBuyChatEmotationGiftLayer:createEmotionNode(arg_13_1)
	local var_13_0 = self.items:clone()
	local var_13_1 = ChatEmotionSprite:create(tonumber((arg_13_1 or nil) and (arg_13_1.id or chat_system_manager:getDefulatFaceid())))

	if arg_13_1 and arg_13_1.image_id then
		var_13_1:setPosition(cc.p(-34, -30))
		var_13_1:setScale(var_13_0:getContentSize().height / var_13_1:getContentSize().height)
	else
		var_13_1:setPosition(cc.p(26, 14))
		var_13_1:setScale(140 / var_13_1:getContentSize().height)
	end

	var_13_1:setName("emotionavatar")
	var_13_0:addChild(var_13_1, 1)
	self:adjustEmationPos(var_13_0, arg_13_1)

	local var_13_2 = var_13_0:getChildByName("Panel_10"):getChildByName("Label_11")

	if arg_13_1 and arg_13_1.name then
		var_13_2:setString(arg_13_1.name)
	else
		var_13_2:setString("")
	end

	return var_13_0
end

function PopBuyChatEmotationGiftLayer:initEmotionTableView()
	self.tableviewemotion:registerScriptHandler(function(arg_16_0, arg_16_1)
		return var_0_9, var_0_10
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableviewemotion:registerScriptHandler(function(arg_15_0, arg_15_1)
		local var_15_0 = arg_15_0:dequeueCell()

		if not var_15_0 then
			var_15_0 = cc.TableViewCell:create()

			for iter_15_0 = 1, 4 do
				local var_15_1 = self:createEmotionNode(self.data[4 * arg_15_1 + iter_15_0])

				var_15_1:setName("sp_" .. iter_15_0)
				var_15_1:setPosition(var_0_11[iter_15_0])
				var_15_0:addChild(var_15_1)

				if self.data[4 * arg_15_1 + iter_15_0] then
					if self.data[4 * arg_15_1 + iter_15_0].id or nil then
						var_15_1:setVisible(true)

						goto label_15_0
					end
				end

				var_15_1:setVisible(false)

				::label_15_0::
			end
		else
			local var_15_3 = 4

			for iter_15_1 = 1, 4 do
				local var_15_4 = var_15_0:getChildByName("sp_" .. iter_15_1)

				if self.data[var_15_3 * arg_15_1 + iter_15_1] then
					local var_15_5 = self.data[var_15_3 * arg_15_1 + iter_15_1].id or nil

					if var_15_5 then
						if var_15_4:getChildByName("emotionavatar") then
							var_15_4:getChildByName("emotionavatar"):removeFromParent()
						end

						local var_15_6 = ChatEmotionSprite:create(tonumber(var_15_5))

						if self.data[var_15_3 * arg_15_1 + iter_15_1].image_id then
							var_15_6:setPosition(cc.p(-34, -30))
							var_15_6:setScale(var_15_4:getContentSize().height / var_15_6:getContentSize().height)
						else
							var_15_6:setPosition(cc.p(26, 14))
							var_15_6:setScale(140 / var_15_6:getContentSize().height)
						end

						var_15_6:setName("emotionavatar")
						var_15_4:addChild(var_15_6, 100)
						var_15_4:setVisible(true)
						self:adjustEmationPos(var_15_4, self.data[var_15_3 * arg_15_1 + iter_15_1])

						local var_15_7 = var_15_4:getChildByName("Panel_10"):getChildByName("Label_11")

						if self.data[var_15_3 * arg_15_1 + iter_15_1].name then
							var_15_7:setString(self.data[var_15_3 * arg_15_1 + iter_15_1].name)
						else
							var_15_7:setString("")
						end

						goto label_15_1
					end
				end

				var_15_4:setVisible(false)
				var_15_4:getChildByName("Panel_10"):getChildByName("Label_11"):setString("")

				::label_15_1::
			end
		end

		return var_15_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableviewemotion:registerScriptHandler(function(arg_17_0, arg_17_1)
		return #self.data
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableviewemotion:reloadData()
end

function PopBuyChatEmotationGiftLayer:getDataFromDrop()
	local var_18_0 = {}

	if self.itemid and item_data[self.itemid] and item_data[self.itemid].mode_id and drop_data[item_data[self.itemid].mode_id] then
		while drop_data[item_data[self.itemid].mode_id]["drop_id" .. 1] and drop_data[item_data[self.itemid].mode_id]["drop_num" .. 1] and drop_data[item_data[self.itemid].mode_id]["drop_rate" .. 1] and item_data[drop_data[item_data[self.itemid].mode_id]["drop_id" .. 1]] do
			table.insert(var_18_0, item_data[drop_data[item_data[self.itemid].mode_id]["drop_id" .. 1]])
		end
	end

	return var_18_0
end

function PopBuyChatEmotationGiftLayer.adjustEmationPos(arg_19_0, arg_19_1, arg_19_2)
	if not arg_19_2 or not arg_19_1 then
		return
	end

	local var_19_0 = arg_19_1:getChildByName("emotionavatar")

	if not var_19_0 then
		return
	end

	local var_19_1 = arg_19_2.id

	local function var_19_2(arg_20_0, arg_20_1, arg_20_2)
		if not arg_20_0 or not arg_20_1 or not arg_20_2 then
			return
		end

		if arg_20_0 and arg_20_0.image_id then
			arg_20_1:setPosition(cc.p(arg_20_2[1].x, arg_20_2[1].y))
		else
			arg_20_1:setPosition(cc.p(arg_20_2[2].x, arg_20_2[2].y))
		end
	end

	local var_19_3 = {
		[123201005] = function()
			var_19_2(arg_19_2, var_19_0, {
				{
					x = -34,
					y = -30
				},
				{
					x = 26,
					y = -16
				}
			})
		end
	}

	if arg_19_2.id and var_19_3[var_19_1] then
		var_19_3[var_19_1]()
	end
end
