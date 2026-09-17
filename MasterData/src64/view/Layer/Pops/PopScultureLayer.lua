PopScultureLayer = class("PopScultureLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local item_data = require("data.item_data")
local playermodel = require("model.playermodel")

require("view.Sprite.AvatarSprite")

function PopScultureLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopScultureLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopScultureLayer:init(arg_3_1)
	self:initInfo(arg_3_1)
	self:initUINode()
	self:fullScreen(self.rootLayer)
	self:schedulerWithCallback(function()
		self:initPanel()
	end)
end

function PopScultureLayer:initUINode()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_sculture.json" or "Pop_sculture.ExportJson")

	self:addChild(self.rootLayer)

	local var_5_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "bg")

	self.rootpanel = var_5_0

	local function var_5_1(arg_6_0)
		global_window_close_action(arg_6_0, function()
			self:clearItemNodePool()
			LayerManager:removePopLayer()
		end)
	end

	self.rootLayer:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.isClose == 0 then
			self.isClose = self.isClose + 1

			var_5_1(var_5_0)
		end
	end)
	global_window_open_action(ccui.Helper:seekWidgetByName(self.rootLayer, "bg"))

	local var_5_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_39")

	self.confirm_button = ccui.Helper:seekWidgetByName(self.rootLayer, "confirm_button")

	self.confirm_button:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_9_0:setTouchEnabled(false)
		self.rootLayer:setTouchEnabled(false)

		if not self.cur_selected then
			var_5_1(var_5_0)

			return
		end

		playermodel:setHeadSoul(self.curScultureInfo[self.cur_selected.key].itemid, function(arg_10_0)
			if self.callback then
				self.callback()
			end

			if arg_10_0 == 2 then
				global_ShowBlockWords("未拥有头像QAQ")
				audioManager:playeffectMusicTest("sound/invalid")
			elseif arg_10_0 == 3 then
				global_ShowBlockWords("头像已过期")
				audioManager:playeffectMusicTest("sound/invalid")
			end

			var_5_1(var_5_0)
		end)
	end)

	self.tableView = cc.TableView:create(cc.size(488, 395))

	self.tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableView:setAnchorPoint(cc.p(0, 0))
	self.tableView:setPosition(10, 25)
	self.tableView:setDelegate()
	self.rootLayer:getChildByName("bg"):addChild(self.tableView, 2)

	self.mainNode = self.rootLayer:getChildByName("main")

	self.mainNode:setVisible(true)
	self.mainNode:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.isClose == 0 then
			self.isClose = self.isClose + 1

			var_5_1(var_5_0)
		end
	end)
	self.mainNode:getChildByName("new_bg"):setTouchEnabled(true)

	self.btn_confirm = self.mainNode:getChildByName("btn_confirm")
	self.btn_select = self.mainNode:getChildByName("btn_select")

	self.btn_select:setPositionX(553)
	self.btn_confirm:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.cur_selected then
			var_5_1(var_5_0)

			return
		end

		playermodel:setHeadSoul(self.curScultureInfo[self.cur_selected].itemid, function(arg_13_0)
			if self.callback then
				self.callback()
			end

			if arg_13_0 == 2 then
				global_ShowBlockWords("未拥有头像QAQ")
				audioManager:playeffectMusicTest("sound/invalid")
			elseif arg_13_0 == 3 then
				global_ShowBlockWords("头像已过期")
				audioManager:playeffectMusicTest("sound/invalid")
			end

			var_5_1(var_5_0)
		end)
	end)
	self.btn_select:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.selectorNode:setVisible(true)
		self:initSelecterPanel()
	end)

	self.noneTipsNode = ccui.ImageView:create("ScultureLayer/none_tip.png", var_0_0)

	self.noneTipsNode:setPosition(cc.p(320, 600))
	self.noneTipsNode:setVisible(false)
	self.mainNode:addChild(self.noneTipsNode)
	self.mainNode:getChildByName("mask"):setLocalZOrder(1)

	self.selectorNode = self.rootLayer:getChildByName("selector")

	self.selectorNode:getChildByName("new_bg"):setTouchEnabled(true)
	self.selectorNode:setVisible(false)
	self.selectorNode:setLocalZOrder(1)
	self.selectorNode:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.selectorNode:setVisible(false)
	end)

	self.btn_sure = self.selectorNode:getChildByName("btn_sure")

	self.btn_sure:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.selectInfo[1].haveSelectedList = cloneconf(self.selectInfo[1].tempSelectedList)
		self.selectInfo[2].haveSelectedList = cloneconf(self.selectInfo[2].tempSelectedList)

		self:initPanel()
		self.selectorNode:setVisible(false)
	end)

	self.selectPanelNode = self.selectorNode:getChildByName("panel")

	self.selectPanelNode:setAnchorPoint(cc.p(0, 0))
	self.selectPanelNode:setPosition(cc.p(800, 785))
	self:initAllItemNode()
	self:initItemNodePool()
end

function PopScultureLayer:initInfo(arg_17_1)
	self.isClose = 0
	self.callback = arg_17_1.callback
	self.scultureInfo = {}

	for iter_17_0 = 1, #arg_17_1.scultures do
		arg_17_1.scultures[iter_17_0].isSpine = item_data[arg_17_1.scultures[iter_17_0].itemid].spine ~= nil
		arg_17_1.scultures[iter_17_0].type = item_data[arg_17_1.scultures[iter_17_0].itemid].class_type or 1
		arg_17_1.scultures[iter_17_0].index = iter_17_0

		table.insert(self.scultureInfo, arg_17_1.scultures[iter_17_0])
	end

	self.selectInfo = {
		{
			name = "类型",
			list = {
				{
					name = "动态"
				},
				{
					name = "静态"
				}
			},
			haveSelectedList = {},
			tempSelectedList = {}
		},
		{
			name = "类别",
			list = {},
			haveSelectedList = {},
			tempSelectedList = {}
		}
	}

	local var_17_1 = {}

	for iter_17_1 = 1, #L_SCULTURE_TYPE_LIST_NAME do
		table.insert(var_17_1, {
			name = L_SCULTURE_TYPE_LIST_NAME[iter_17_1]
		})
	end

	self.selectInfo[2].list = var_17_1
end

function PopScultureLayer:initAllItemNode()
	self.itemContentNode = ccui.Layout:create()

	self.itemContentNode:setContentSize(cc.size(500, 130))
	self.itemContentNode:setVisible(false)
	self.rootLayer:addChild(self.itemContentNode)

	self.headItemNode = ccui.Button:create("ScultureLayer/item_bg.png", "ScultureLayer/item_bg.png", "ScultureLayer/item_bg.png", var_0_0)

	self.headItemNode:setAnchorPoint(cc.p(0.5, 0.5))

	local var_18_0 = ccui.ImageView:create("ScultureLayer/kuang_off.png", var_0_0)

	var_18_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_18_0:setPosition(self.headItemNode:getContentSize().width / 2, 50)
	var_18_0:setName("selectedOff")
	self.headItemNode:addChild(var_18_0)

	local var_18_1 = ccui.ImageView:create("ScultureLayer/kuang.png", var_0_0)

	var_18_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_18_1:setPosition(self.headItemNode:getContentSize().width / 2, 50)
	var_18_1:setName("selected")
	var_18_1:setVisible(false)
	self.headItemNode:addChild(var_18_1)
	self.headItemNode:setVisible(false)
	self.rootLayer:addChild(self.headItemNode)

	self.detailItemNode = self.selectPanelNode:getChildByName("toggle")

	self.detailItemNode:setVisible(false)
end

function PopScultureLayer.updateSelectItemNode(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_1:getChildByName("title")

	if arg_19_2 == true then
		var_19_0:setColor(cc.c3b(255, 255, 255))
		arg_19_1:getChildByName("click"):setVisible(true)
	else
		var_19_0:setColor(cc.c3b(147, 148, 201))
		arg_19_1:getChildByName("click"):setVisible(false)
	end

	var_19_0:setFontSize(22)
end

function PopScultureLayer:initSelecterPanel()
	self.selectInfo[1].tempSelectedList = cloneconf(self.selectInfo[1].haveSelectedList)
	self.selectInfo[2].tempSelectedList = cloneconf(self.selectInfo[2].haveSelectedList)

	for iter_20_0 = 1, #self.selectInfo do
		local var_20_0 = self.selectPanelNode:getChildByName("item" .. iter_20_0)

		if var_20_0 then
			var_20_0:setVisible(true)

			local var_20_1 = var_20_0:getChildByName("detailItemPanel")

			var_20_1:removeAllChildren()

			if self.selectInfo[iter_20_0].list and #self.selectInfo[iter_20_0].list > 0 then
				for iter_20_1 = 1, #self.selectInfo[iter_20_0].list do
					local var_20_2 = self.detailItemNode:clone()

					var_20_2:setVisible(true)
					var_20_2:setPosition(cc.p(90 + (iter_20_1 - 1) % 4 * 115, 85 - math.floor((iter_20_1 - 1) / 4) * 40))
					var_20_2:getChildByName("title"):setString(self.selectInfo[iter_20_0].list[iter_20_1].name)
					var_20_1:addChild(var_20_2)
					self:updateSelectItemNode(var_20_2, self.selectInfo[iter_20_0].haveSelectedList[iter_20_1])
					var_20_2:setTouchEnabled(true)
					var_20_2:addTouchEventListener(function(arg_21_0, arg_21_1)
						if arg_21_1 ~= ccui.TouchEventType.ended then
							return
						end

						if self.selectInfo[iter_20_0].tempSelectedList[iter_20_1] == true then
							self.selectInfo[iter_20_0].tempSelectedList[iter_20_1] = nil
						else
							self.selectInfo[iter_20_0].tempSelectedList[iter_20_1] = true
						end

						self:updateSelectItemNode(arg_21_0, self.selectInfo[iter_20_0].tempSelectedList[iter_20_1])
					end)
				end
			end
		end
	end
end

function PopScultureLayer:doSelelctWithInfo()
	self.cur_selected = nil
	self.curScultureInfo = {}

	local var_22_0 = cloneconf(self.scultureInfo)
	local var_22_1 = self.selectInfo[2].haveSelectedList
	local var_22_2 = false

	if next(self.selectInfo[1].haveSelectedList) then
		if self.selectInfo[1].haveSelectedList[1] == true and self.selectInfo[1].haveSelectedList[2] ~= true then
			table.filter(var_22_0, function(arg_23_0)
				return arg_23_0.isSpine == true
			end)
		elseif self.selectInfo[1].haveSelectedList[1] ~= true and self.selectInfo[1].haveSelectedList[2] == true then
			table.filter(var_22_0, function(arg_24_0)
				return arg_24_0.isSpine == false
			end)
		end

		var_22_2 = true
	end

	if next(self.selectInfo[2].haveSelectedList) then
		table.filter(var_22_0, function(arg_25_0)
			return var_22_1[arg_25_0.type] == true
		end)

		var_22_2 = true
	end

	for iter_22_0, iter_22_1 in pairs(var_22_0) do
		table.insert(self.curScultureInfo, iter_22_1)
	end

	table.sort(self.curScultureInfo, function(arg_26_0, arg_26_1)
		return arg_26_0.index < arg_26_1.index
	end)

	for iter_22_2 = 1, #self.curScultureInfo do
		if self.curScultureInfo[iter_22_2].selected == true then
			self.cur_selected = iter_22_2
		end

		self.curScultureInfo[iter_22_2].index = iter_22_2
	end

	self.btn_select:loadTextures(var_22_2 == true and "ScultureLayer/btn_select_on.png" or "ScultureLayer/btn_select.png", var_22_2 == true and "ScultureLayer/btn_select_on.png" or "ScultureLayer/btn_select.png", var_22_2 == true and "ScultureLayer/btn_select_on.png" or "ScultureLayer/btn_select.png", var_0_0)
end

function PopScultureLayer:initPanel()
	self:doSelelctWithInfo()

	local var_27_0 = self.curScultureInfo
	local var_27_1 = 4
	local var_27_2 = math.ceil(#self.curScultureInfo / 4)
	local var_27_3 = 520
	local var_27_4 = 130

	if self.tableViewNode ~= nil then
		self:removeTableViewNodeSafe()
	end

	self.tableViewNode = self:getTableView(var_27_0, var_27_2, function(arg_28_0)
		if arg_28_0 + 1 == var_27_2 then
			return var_27_3, var_27_4 + 70
		else
			return var_27_3, var_27_4
		end
	end, cc.size(520, 690), function(arg_29_0, arg_29_1, arg_29_2)
		local var_29_0 = arg_29_0:dequeueCell()

		if var_29_0 == nil then
			var_29_0 = cc.TableViewCell:new()
		end

		local var_29_1 = var_29_0:getChildByName("itemContent")

		if var_29_1 then
			self:resumeItemContentNode(var_29_1, var_27_1)
		else
			var_29_1 = self.itemContentNode:clone()

			var_29_1:setName("itemContent")
			var_29_0:addChild(var_29_1)
		end

		var_29_1:setVisible(true)

		if arg_29_1 + 1 == var_27_2 then
			var_29_1:setPositionY(150)
		else
			var_29_1:setPositionY(80)
		end

		for iter_29_0 = arg_29_1 * var_27_1 + 1, arg_29_1 * var_27_1 + 1 + 3 do
			local var_29_2 = arg_29_2[iter_29_0]
			local var_29_4 = var_29_1:getChildByName("item" .. (iter_29_0 - 1) % var_27_1)

			if arg_29_2[iter_29_0] ~= nil then
				if var_29_4 == nil then
					var_29_4 = self.itemNodePool.get()

					var_29_1:addChild(var_29_4)
					var_29_4:setName("item" .. (iter_29_0 - 1) % var_27_1)
				end

				var_29_4:setVisible(true)
				var_29_4:setScale(0.5)
				var_29_4:getChildByName("selected"):setScale(1 / 0.5)
				var_29_4:getChildByName("selectedOff"):setScale(1 / 0.5)
				var_29_4:setSwallowTouches(false)
				var_29_4:setPosition(cc.p(58 + (iter_29_0 - 1) % var_27_1 * 132, -15))
				var_29_4:addTouchEventListener(function(arg_30_0, arg_30_1)
					if arg_30_1 ~= ccui.TouchEventType.ended then
						return
					end

					if math.abs(arg_30_0:getTouchBeganPosition().y - arg_30_0:getTouchEndPosition().y) > 50 then
						return
					end

					if self.cur_selected ~= nil then
						local var_30_0 = self.tableViewNode:cellAtIndex((math.floor((self.cur_selected - 1) / var_27_1)))

						if var_30_0 then
							var_30_0:getChildByName("itemContent"):getChildByName("item" .. (self.cur_selected - 1) % var_27_1):getChildByName("selected"):setVisible(false)
						end
					end

					self.cur_selected = var_29_2.index

					local var_30_1 = arg_30_0:getChildByName("selected")

					var_30_1:setPosition(cc.p(arg_30_0:getContentSize().width / 2, 50))
					var_30_1:setVisible(true)
				end)

				var_29_4.cInfo = arg_29_2[iter_29_0]

				self:updateItemNode(var_29_4)
			elseif var_29_4 then
				var_29_4:setVisible(false)
			end
		end

		return var_29_0
	end, function(arg_31_0, arg_31_1)
		print("click ")

		local var_31_0 = arg_31_1:getChildByName("item")
	end)

	self.tableViewNode:setPosition(cc.p(65, 210))
	self.tableViewNode:setPositionY(self.tableViewNode:getPositionY() + (GameDisplay.height + GameDisplay.fix_y - 1136) / 2)
	self.mainNode:addChild(self.tableViewNode)
	self.noneTipsNode:setVisible(#var_27_0 <= 0)
end

function PopScultureLayer:removeTableViewNodeSafe()
	local var_32_0 = self.tableViewNode:getContainer()
	local var_32_1 = var_32_0:getChildren()

	for iter_32_0 = 1, var_32_0:getChildrenCount() do
		local var_32_2 = var_32_1[iter_32_0]:getChildByName("itemContent")

		if var_32_2 then
			for iter_32_1, iter_32_2 in pairs((var_32_2:getChildren())) do
				self.itemNodePool.put(iter_32_2)
			end
		end
	end

	self.tableViewNode:removeFromParent()

	self.tableViewNode = nil
end

function PopScultureLayer:resumeItemContentNode(arg_33_1, arg_33_2)
	if arg_33_1 == nil then
		return
	end

	local var_33_0 = arg_33_1:getChildrenCount()

	if arg_33_2 - var_33_0 > 0 then
		for iter_33_0 = var_33_0 + 1, arg_33_2 do
			local var_33_1 = self.itemNodePool.get()

			arg_33_1:addChild(var_33_1)
			var_33_1:setName("item" .. iter_33_0)
			var_33_1:setPosition(cc.p(58 + iter_33_0 * 132, -15))
		end
	elseif arg_33_2 - var_33_0 < 0 then
		for iter_33_1 = var_33_0, arg_33_2 + 1, -1 do
			self.itemNodePool.put((arg_33_1:getChildByName("item" .. iter_33_1)))
		end
	end
end

function PopScultureLayer.getTableView(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4, arg_34_5, arg_34_6)
	local var_34_0 = cc.TableView:create(arg_34_4)

	var_34_0:setVisible(true)
	var_34_0:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	var_34_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_34_0:setDelegate()
	var_34_0:setName("tableView")
	var_34_0:registerScriptHandler(function(arg_35_0)
		return arg_34_2
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	var_34_0:registerScriptHandler(function(arg_36_0)
		arg_34_0:scrollViewDidScroll(arg_36_0)
	end, cc.SCROLLVIEW_SCRIPT_SCROLL)
	var_34_0:registerScriptHandler(function(arg_37_0, arg_37_1)
		arg_34_6(arg_37_0, arg_37_1)
	end, cc.TABLECELL_TOUCHED)
	var_34_0:registerScriptHandler(function(arg_38_0, arg_38_1)
		local var_38_0 = 520
		local var_38_1 = 130

		if type(arg_34_3) == "function" then
			var_38_0, var_38_1 = arg_34_3(arg_38_1)
		end

		return var_38_0, var_38_1
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	var_34_0:registerScriptHandler(function(arg_39_0, arg_39_1)
		return arg_34_5(arg_39_0, arg_39_1, arg_34_1)
	end, cc.TABLECELL_SIZE_AT_INDEX)
	var_34_0:reloadData()
	var_34_0:setAnchorPoint(cc.p(0, 1))

	return var_34_0
end

function PopScultureLayer.scrollViewDidScroll(arg_40_0, arg_40_1)
	return
end

function PopScultureLayer:updateItemNode(arg_41_1)
	if arg_41_1 == nil or arg_41_1.cInfo == nil then
		return
	end

	local var_41_0 = arg_41_1.cInfo
	local var_41_1 = arg_41_1:getChildByName("icon")

	if var_41_1 then
		var_41_1:switchShowAvatar(var_41_0.itemid)
	else
		local var_41_2 = AvatarSprite:create(var_41_0.itemid)

		var_41_2:setName("icon")
		var_41_2:setPosition(arg_41_1:getContentSize().width / 4 - 20, arg_41_1:getContentSize().height / 4 - 10)
		arg_41_1:addChild(var_41_2)
	end

	local var_41_3 = arg_41_1:getChildByName("selected")

	var_41_3:setPosition(cc.p(arg_41_1:getContentSize().width / 2, 50))
	var_41_3:setVisible(var_41_0.index == self.cur_selected)

	local var_41_4 = arg_41_1:getChildByName("selectedOff")

	var_41_4:setPosition(cc.p(arg_41_1:getContentSize().width / 2, 50))
	var_41_4:setVisible(true)
end

function PopScultureLayer.fullScreen(arg_42_0, arg_42_1)
	arg_42_1:setContentSize((GameDisplay.getScreenSize()))
	arg_42_1:setPositionY(arg_42_1:getPositionY() - GameDisplay.fix_y)
	arg_42_1:getChildByName("bg"):setPositionY(arg_42_1:getChildByName("bg"):getPositionY() + GameDisplay.fix_y)

	for iter_42_0, iter_42_1 in pairs(arg_42_1:getChildren()) do
		for iter_42_2, iter_42_3 in pairs(iter_42_1:getChildren()) do
			iter_42_3:setPositionY(iter_42_3:getPositionY() + (GameDisplay.height + GameDisplay.fix_y - 1136) / 2)
		end
	end
end

function PopScultureLayer.exit(arg_43_0)
	global_window_close_action(node, function()
		LayerManager:removePopLayer()
	end)
end

function PopScultureLayer:clearItemNodePool()
	for iter_45_0 = 1, self.itemNodePool.totalNum do
		local var_45_0 = self.itemNodePool[iter_45_0]:getReferenceCount()

		if self.itemNodePool[iter_45_0] and var_45_0 > 0 then
			for iter_45_1 = 1, var_45_0 do
				self.itemNodePool[iter_45_0]:release()
			end
		end
	end

	self.itemNodePool = {}
end

function PopScultureLayer:initItemNodePool()
	self.itemNodePool = {}
	self.itemNodePool.limitNum = 50
	self.itemNodePool.totalNum = 0

	function self.itemNodePool.get()
		local var_47_0

		if self.itemNodePool.totalNum > 0 then
			var_47_0 = table.remove(self.itemNodePool)
			self.itemNodePool.totalNum = math.max(self.itemNodePool.totalNum - 1, 0)
		else
			var_47_0 = self.headItemNode:clone()
		end

		return var_47_0
	end

	function self.itemNodePool:put()
		if self and self.itemNodePool.totalNum < self.itemNodePool.limitNum then
			self:retain()
			self:removeFromParent()
			table.insert(self.itemNodePool, self)

			self.itemNodePool.totalNum = self.itemNodePool.totalNum + 1
			self = nil
		end
	end

	for iter_46_0 = 1, 20 do
		self.itemNodePool.put((self.headItemNode:clone()))
	end
end

function PopScultureLayer:schedulerWithCallback(arg_49_1)
	if self.scheduler ~= nil then
		self.scheduler.unscheduleScriptEntry(self.scheduler, self.scheduler)
	end

	self.scheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
		if type(arg_49_1) == "function" then
			arg_49_1()
		end

		if self.scheduler ~= nil then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduler)
		end
	end, 0.2, false)
end
