PopOpenChoosegiftLayer = class("PopOpenChoosegiftLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

require("view.Sprite.ItemSprite")

local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local drop_manager = require("controller.drop_manager")
local time_check_manager = require("controller.time_check_manager")
local item_data = require("data.item_data")
local choosegift_data = require("data.choosegift_data")

function PopOpenChoosegiftLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopOpenChoosegiftLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

local var_0_8 = 1
local var_0_9 = 2

function PopOpenChoosegiftLayer:init(arg_3_1)
	hx_print("PopOpenChoosegiftLayer")
	print_lua_table(arg_3_1)

	self.extheight = 100
	self.opentyp = arg_3_1.opentype
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(false)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.rootLayer:setBackGroundColor(cc.c3b(0, 0, 0))
	self.rootLayer:setBackGroundColorOpacity(0)
	self:addChild(self.rootLayer, 2)

	self.rootpanel = ccui.ImageView:create("public/panelbg/normal_bg_new.png", var_0_0)

	self.rootpanel:setPositionX(self.rootLayer:getContentSize().width / 2)
	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2 - GameDisplay.fix_y)
	self.rootpanel:setTouchEnabled(true)
	self.rootpanel:setScale9Enabled(true)
	self.rootpanel:setCapInsets(cc.rect(100, 400, 10, 10))
	self.rootpanel:setContentSize(cc.size(self.rootpanel:getContentSize().width, self.rootpanel:getContentSize().height + self.extheight))
	self.rootLayer:addChild(self.rootpanel, 100)
	self.showActions.extendVertical(self)
	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_4_0:isBright() then
			return
		end

		arg_4_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			if self.exitcallback then
				self.exitcallback(0)
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 0)

	self.itemid = arg_3_1.itemid
	self.select = 1
	self.exitcallback = arg_3_1.callback

	self:initData()
	self:initUI()
	self:updateUI()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" and arg_3_1.exitcallback then
			arg_3_1.exitcallback()
		end
	end)
end

function PopOpenChoosegiftLayer:initUI(...)
	self.nameLabel = cc.Label:createWithTTF("", FONT_DES, 30)

	self.nameLabel:setAnchorPoint(cc.p(0, 1))
	self.nameLabel:setPosition(cc.p(220, 410 + self.extheight))
	self.rootpanel:addChild(self.nameLabel)

	self.numLabel = cc.Label:createWithTTF("", FONT_DES, 22)

	self.numLabel:setAnchorPoint(cc.p(0, 1))
	self.numLabel:setPosition(cc.p(220, 360 + self.extheight))
	self.numLabel:setColor(cc.c3b(5, 191, 228))
	self.rootpanel:addChild(self.numLabel)

	self.desLabel = cc.Label:createWithTTF("", FONT_DES, 22)

	self.desLabel:setAnchorPoint(cc.p(0, 1))
	self.desLabel:setMaxLineWidth(300)
	self.desLabel:setPosition(cc.p(220, 320 + self.extheight))
	self.rootpanel:addChild(self.desLabel)

	self.detailBg = ccui.Layout:create()

	self.detailBg:setContentSize(cc.size(460, 30))
	self.detailBg:setPosition(cc.p(24, 140 + self.extheight))
	self.detailBg:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.detailBg:setBackGroundColor(cc.c3b(2, 5, 24))
	self.detailBg:setOpacity(60)
	self.rootpanel:addChild(self.detailBg)

	self.detailLabel = cc.Label:createWithTTF("", FONT_DES, 22)

	self.detailLabel:setAnchorPoint(cc.p(0, 1))
	self.detailLabel:setColor(cc.c3b(255, 158, 64))
	self.detailLabel:setPosition(cc.p(24, 168 + self.extheight))
	self.rootpanel:addChild(self.detailLabel)

	self.sureBtn = ccui.Button:create("public/button/public_button_normal_y.png", nil, "public/button/public_button_normal_y.png", var_0_0)

	self.sureBtn:setPosition(cc.p(424, -50))
	self.sureBtn:addTouchEventListener(self:getSurebtnHandler())
	self.rootpanel:addChild(self.sureBtn, 3)
	self.sureBtn:setVisible(self.opentyp ~= var_0_9)

	local var_7_0 = cc.Label:createWithTTF(L_BUTTON_TEXT.Use, FONT_BUTTON, 32)

	var_7_0:setPositionX(self.sureBtn:getContentSize().width / 2)
	var_7_0:setPositionY(self.sureBtn:getContentSize().height / 2)
	var_7_0:setColor(cc.c3b(12, 12, 12))
	self.sureBtn:addChild(var_7_0)

	self.touchPanel = ccui.Layout:create()

	self.touchPanel:setContentSize(cc.size(460, 50))
	self.touchPanel:setPosition(cc.p(self.sureBtn:getPositionX(), self.sureBtn:getPositionY()))
	self.touchPanel:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.touchPanel:setBackGroundColor(cc.c3b(2, 5, 24))
	self.touchPanel:setOpacity(60)
	self.touchPanel:setTouchEnabled(true)
	self.rootpanel:addChild(self.touchPanel)

	self.title = ccui.ImageView:create("public/panelbg/title_item.png", var_0_0)

	self.title:setPosition(cc.p(94, 580))
	self.rootpanel:addChild(self.title)
	self:createTableView()
	self:initProgress()
end

function PopOpenChoosegiftLayer:updateUI(...)
	local var_8_0

	if self.itemsp then
		self.itemsp:removeFromParent()

		self.itemsp = nil
		var_8_0 = item_manager:getItemNumber(self.itemid) > 0 and item_manager:getItemNumber(self.itemid) or nil
	end

	self.itemsp = ItemSprite:createNewWithItemId(self.itemid, var_8_0)

	self.itemsp:setPosition(cc.p(120, 300 + self.extheight))
	self.rootpanel:addChild(self.itemsp)
	self.nameLabel:setString(item_data[self.itemid].name)
	self.numLabel:setString(L_ITEM_NUMBER .. item_manager:getItemNumber(self.itemid))
	self.desLabel:setString(item_data[self.itemid].user_manual)
	self.detailLabel:setString(L_CHOOSE_LAYER_DES)

	if item_manager:getItemNumber(self.itemid) == 0 then
		self.sureBtn:setVisible(false)
	end

	self.progress:update()
end

function PopOpenChoosegiftLayer:initData(...)
	self.dataList = {}
	self.curSelect = 1
	self.maxSelect = item_manager:getItemNumber(self.itemid)

	assert(item_data[self.itemid].choosegift_group, "itemid:" .. self.itemid .. "没有配置choosegift_group")
	assert(choosegift_data[item_data[self.itemid].choosegift_group], "choosegift_data没有找到" .. item_data[self.itemid].choosegift_group)

	for iter_9_0 = 1, 1000 do
		if not choosegift_data[item_data[self.itemid].choosegift_group]["dropid_" .. iter_9_0] then
			break
		end

		table.insert(self.dataList, (drop_manager:getDropMsg(choosegift_data[item_data[self.itemid].choosegift_group]["dropid_" .. iter_9_0])))
	end
end

function PopOpenChoosegiftLayer.getSurebtnHandler(arg_10_0, ...)
	return function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_11_0:isBright() then
			return
		end

		arg_11_0:setBright(false)
		item_manager:open_choosegift(arg_10_0.itemid, arg_10_0.select, arg_10_0.curSelect, function(arg_12_0)
			if item_manager:getItemNumber(arg_10_0.itemid) < 1 or arg_10_0.opentyp ~= var_0_8 then
				arg_10_0:exit()
			elseif arg_12_0.result == 1 then
				arg_10_0.curSelect = 1
				arg_10_0.maxSelect = item_manager:getItemNumber(arg_10_0.itemid)

				arg_10_0:updateUI()
			end

			arg_11_0:setBright(true)
		end)
	end
end

function PopOpenChoosegiftLayer.createSp(arg_13_0, ...)
	local var_13_0 = ccui.Layout:create()

	var_13_0:setContentSize(cc.size(100, 100))
	var_13_0:setAnchorPoint(cc.p(0, 0))
	var_13_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_13_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_13_0:setOpacity(255)

	local var_13_1 = ccui.Button:create("GUI/button.png", "GUI/button.png", "GUI/button.png", var_0_0)

	var_13_1:setScale9Enabled(true)
	var_13_1:setCapInsets(cc.rect(20, 20, 10, 10))
	var_13_1:setContentSize(cc.size(100, 90))
	var_13_1:setSwallowTouches(false)
	var_13_1:setOpacity(0)
	var_13_1:setPositionX(var_13_0:getContentSize().width / 2)
	var_13_1:setPositionY(var_13_0:getContentSize().height / 2 + 10)
	var_13_1:setName("touchButton")
	var_13_0:addChild(var_13_1)
	var_13_1:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		if item_data[arg_14_0.itemid].bag_item_type == kITEM_HORCRUX then
			local var_14_0 = -1

			for iter_14_0, iter_14_1 in pairs((require("data.photofile_HelpGirl_data"))) do
				if arg_14_0.itemid == iter_14_1.item_id then
					var_14_0 = iter_14_0

					break
				end
			end

			if var_14_0 == -1 then
				print(string.format("itemid:%d 在data.photofile_HelpGirl_data里 条件itemid == v.item_id未为true", arg_14_0.itemid))

				return
			end

			require("view.Layer.DetailsofHelpGirlLayer")
			LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
				id = var_14_0,
				itemid = arg_14_0.itemid
			})
		else
			local var_14_1 = {}

			var_14_1.layer = cc.Layer:create()
			var_14_1.itemid = arg_14_0.itemid

			PopLayer:Item(var_14_1)
		end
	end)

	local var_13_2 = ccui.Button:create("GUI/button.png", "GUI/button.png", "GUI/button.png", var_0_0)

	var_13_2:setScale9Enabled(true)
	var_13_2:setCapInsets(cc.rect(20, 20, 10, 10))
	var_13_2:setContentSize(cc.size(100, 60))
	var_13_2:setSwallowTouches(false)
	var_13_2:setOpacity(0)
	var_13_2:setPositionX(var_13_0:getContentSize().width / 2)
	var_13_2:setPositionY(var_13_0:getContentSize().height / 2 - 60)
	var_13_2:setName("touchButton2")
	var_13_0:addChild(var_13_2)
	var_13_2:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_13_0.select = arg_15_0.index

		arg_13_0:updateShowingCells()
	end)

	local var_13_3 = ItemSpriteActivityRecharge:createSignItem()

	var_13_3:setName("sp")
	var_13_3:setPositionX(var_13_0:getContentSize().width / 2)
	var_13_3:setPositionY(var_13_0:getContentSize().height / 2)
	var_13_3:setSwallowTouches(false)
	var_13_0:addChild(var_13_3)

	local var_13_4 = ccui.ImageView:create("public/rolebg/horcrux_hook_frame.png", var_0_0)

	var_13_4:setPositionX(var_13_0:getContentSize().width / 2)
	var_13_4:setScale(0.6)
	var_13_4:setPositionY(-20)
	var_13_0:addChild(var_13_4)

	local var_13_5 = ccui.ImageView:create("public/rolebg/horcrux_hook.png", var_0_0)

	var_13_5:setPositionX(var_13_4:getPositionX())
	var_13_5:setPositionY(var_13_4:getPositionY())
	var_13_5:setScale(0.6)
	var_13_5:setName("hook")
	var_13_0:addChild(var_13_5)

	function var_13_0:update(arg_16_1)
		local var_16_0
		local var_16_1
		local var_16_2

		if arg_13_0.dataList[arg_16_1].gold and arg_13_0.dataList[arg_16_1].gold > 0 then
			var_16_0 = "gold"
			var_16_1 = arg_13_0.dataList[arg_16_1].gold
		elseif arg_13_0.dataList[arg_16_1].diamond and arg_13_0.dataList[arg_16_1].diamond > 0 then
			var_16_0 = "diamond"
			var_16_1 = arg_13_0.dataList[arg_16_1].diamond
		elseif arg_13_0.dataList[arg_16_1].sp and arg_13_0.dataList[arg_16_1].sp > 0 then
			var_16_0 = "sp"
			var_16_1 = arg_13_0.dataList[arg_16_1].sp
		elseif arg_13_0.dataList[arg_16_1].equips and next(arg_13_0.dataList[arg_16_1].equips) then
			var_16_0 = arg_13_0.dataList[arg_16_1].equips[1].dropid
			var_16_1 = arg_13_0.dataList[arg_16_1].equips[1].dropNum
			var_16_2 = arg_13_0.dataList[arg_16_1].equips[1].item_attr
		end

		self:getChildByName("sp"):updateSignItemByItemid(var_16_0, var_16_1, nil, nil, nil, nil, var_16_2)
		self:getChildByName("hook"):setVisible(arg_16_1 == arg_13_0.select)

		self:getChildByName("touchButton").index = arg_16_1
		self:getChildByName("touchButton").itemid = var_16_0
		self:getChildByName("touchButton2").index = arg_16_1
		self:getChildByName("touchButton2").itemid = var_16_0
	end

	return var_13_0
end

local var_0_10 = 560
local var_0_11 = 210
local var_0_12 = 10
local var_0_13 = 20
local var_0_14 = 145
local var_0_15 = 140
local var_0_16 = {
	cc.p(30, 40),
	cc.p(140, 40),
	cc.p(260, 40),
	(cc.p(370, 40))
}
local var_0_17 = 4
local var_0_18 = 1

function PopOpenChoosegiftLayer:createTableView()
	self.listPanel = cc.TableView:create(cc.size(var_0_10, var_0_11))

	self.listPanel:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.listPanel:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.listPanel:setPosition(cc.p(var_0_12, var_0_13))
	self.listPanel:setDelegate()
	self.rootpanel:addChild(self.listPanel)
	self.listPanel:registerScriptHandler(function(arg_18_0, arg_18_1)
		return var_0_14, var_0_15
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.listPanel:registerScriptHandler(function(arg_19_0, arg_19_1)
		local var_19_0 = arg_19_0:dequeueCell()

		if not var_19_0 then
			var_19_0 = cc.TableViewCell:create()

			for iter_19_0 = 1, var_0_17 do
				local var_19_1 = self:createSp()

				var_19_1:setScale(var_0_18)
				var_19_1:setName("sp_" .. iter_19_0)
				var_19_1:setPosition(var_0_16[iter_19_0])
				var_19_0:addChild(var_19_1)
			end
		end

		for iter_19_1 = 1, var_0_17 do
			local var_19_2 = var_19_0:getChildByName("sp_" .. iter_19_1)

			if self.dataList[arg_19_1 * var_0_17 + iter_19_1] then
				var_19_2:setVisible(true)
				var_19_2:update(arg_19_1 * var_0_17 + iter_19_1)
			else
				var_19_2:setVisible(false)
			end
		end

		return var_19_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.listPanel:registerScriptHandler(function(arg_20_0, arg_20_1)
		return math.ceil(#self.dataList / var_0_17)
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.listPanel:reloadData()
	self.listPanel:updateCellAtIndex(0)
end

function PopOpenChoosegiftLayer:updateShowingCells()
	local var_21_0, var_21_1 = GetTableViewShowCellIdx(self.listPanel, {
		cellsize = cc.size(var_0_14, var_0_15),
		maxcount = math.ceil(#self.dataList / var_0_17)
	})

	for iter_21_0 = var_21_0, var_21_1 do
		self.listPanel:updateCellAtIndex(iter_21_0)
	end
end

function PopOpenChoosegiftLayer:initBg(arg_22_1)
	local var_22_0 = ccui.Layout:create()

	var_22_0:setTouchEnabled(true)
	var_22_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_22_0:setAnchorPoint(cc.p(0, 0))
	var_22_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_22_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_22_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_22_0:setOpacity(0)
	self:addChild(var_22_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_23_0)
		self:addChild(arg_23_0, -2)
		arg_23_0:setPositionY(arg_23_0:getPositionY() - GameDisplay.fix_y)

		local var_23_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_23_0:setAnchorPoint(cc.p(0, 0))
		var_23_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_23_0, -1)
		self:init(arg_22_1)
		var_22_0:setOpacity(102)
		var_22_0:setTouchEnabled(false)
	end)
end

function PopOpenChoosegiftLayer:initProgress(...)
	self.num_bar_layer = ccui.Layout:create()

	self.num_bar_layer:setTouchEnabled(true)
	self.num_bar_layer:setContentSize(cc.size(640, 160))
	self.num_bar_layer:setAnchorPoint(cc.p(0.5, 0.5))
	self.num_bar_layer:setPosition(cc.p(320, self.sureBtn:getPositionY()))
	self.num_bar_layer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self.num_bar_layer:setBackGroundColor(cc.c3b(0, 0, 0))
	self.num_bar_layer:setBackGroundColorOpacity(180)
	self.rootpanel:addChild(self.num_bar_layer)

	self.progress = ccui.Button:create("public/panelbg/bag_blue_slider_bottom.png", "public/panelbg/bag_blue_slider_bottom.png", "public/panelbg/bag_blue_slider_bottom.png", var_0_0)

	self.progress:setPositionX(160)
	self.progress:setPositionY(self.sureBtn:getPositionY())

	function self.progress.update()
		self.progressbar:setScaleX(self.curSelect / self.maxSelect)
		self.progressPoint:setPositionX(self.progress:getContentSize().width * self.curSelect / self.maxSelect)
		self.curSelectLabel:setString(self.curSelect .. "/" .. self.maxSelect)
	end

	self.progress:addTouchEventListener(function(arg_26_0, arg_26_1)
		if arg_26_1 == ccui.TouchEventType.moved then
			local var_26_0 = arg_26_0:getTouchBeganPosition()

			self.curSelect = math.floor(self.maxSelect * (arg_26_0:convertToNodeSpace((arg_26_0:getTouchMovePosition())).x / arg_26_0:getContentSize().width))
			self.curSelect = math.max(self.curSelect, 1)
			self.curSelect = math.min(self.curSelect, self.maxSelect)

			self.progress:update()

			return
		elseif arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.curSelect = math.floor(self.maxSelect * (arg_26_0:convertToNodeSpace((arg_26_0:getTouchEndPosition())).x / arg_26_0:getContentSize().width))

		self.progress:update()
	end)

	self.progressbar = ccui.Button:create("public/panelbg/bag_blue_slider_bar.png", "public/panelbg/bag_blue_slider_bar.png", "public/panelbg/bag_blue_slider_bar.png", var_0_0)

	self.progressbar:setPositionX(self.progress:getPositionX() - self.progress:getContentSize().width / 2)
	self.progressbar:setPositionY(self.sureBtn:getPositionY())
	self.progressbar:setTouchEnabled(false)
	self.progressbar:setAnchorPoint(cc.p(0, 0.5))
	self.progressbar:setScaleX(self.curSelect / self.maxSelect)
	self.rootpanel:addChild(self.progressbar, 10)

	self.progressPoint = ccui.ImageView:create("public/button/blue_slider_node.png", var_0_0)

	self.progressPoint:setPositionX(self.curSelect / self.maxSelect * self.progress:getContentSize().width)
	self.progressPoint:setPositionY(self.progress:getContentSize().height / 2)
	self.progress:addChild(self.progressPoint, 20)

	self.subbtn = ccui.Button:create("public/button/sub_blue_btn.png", nil, "public/button/sub_blue_btn.png", var_0_0)

	self.subbtn:setPositionX(self.progress:getPositionX() - self.progress:getContentSize().width / 2 - self.subbtn:getContentSize().width)
	self.subbtn:setPositionY(self.progress:getPositionY())
	self.rootpanel:addChild(self.subbtn)

	self.addbtn = ccui.Button:create("public/button/add_blue_btn.png", nil, "public/button/add_blue_btn.png", var_0_0)

	self.addbtn:setPositionX(self.progress:getPositionX() + self.progress:getContentSize().width / 2 + self.addbtn:getContentSize().width)
	self.addbtn:setPositionY(self.progress:getPositionY())
	self.rootpanel:addChild(self.addbtn)

	self.curSelectLabel = cc.Label:createWithTTF("", FONT_DES, 24)

	self.curSelectLabel:setPositionX(self.progress:getPositionX())
	self.curSelectLabel:setPositionY(self.progress:getPositionY() + 20)
	self.rootpanel:addChild(self.curSelectLabel)
	self.curSelectLabel:setString(self.curSelect .. "/" .. self.maxSelect)
	self.subbtn:addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.curSelect = self.curSelect - 1
		self.curSelect = math.max(1, self.curSelect)

		self.progress:update()
	end)
	self.addbtn:addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.curSelect = self.curSelect + 1
		self.curSelect = math.min(self.curSelect, self.maxSelect)

		self.progress:update()
	end)
	self.rootpanel:addChild(self.progress)
end

function PopOpenChoosegiftLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		if self.exitcallback then
			self.exitcallback(0)
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end
