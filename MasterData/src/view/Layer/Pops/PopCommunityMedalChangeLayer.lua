PopCommunityMedalChangeLayer = class("PopCommunityMedalChangeLayer", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")
require("view.Layer.PopLayer")
require("view.Sprite.ConfirmDialogSprite")

local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local item_data = require("data.item_data")
local servant_data = require("data.servant_data")
local community_system_manager = require("controller.community_system_manager")
local level_manager = require("controller.level_manager")
local playermodel = require("model.playermodel")
local var_0_7 = config._DEBUG and 0 or 1
local family_medal_data = require("data.family_medal_data")
local var_0_9 = {
	{
		off = "community_system/joinCommunityLayer/meadal_top_change_off.png",
		on = "community_system/joinCommunityLayer/meadal_top_change_on.png"
	}
}
local var_0_10 = {
	off = "community_system/joinCommunityLayer/meadal_useing.png",
	on = "community_system/joinCommunityLayer/meadal_use.png"
}
local var_0_11 = 546
local var_0_12 = 160
local var_0_13 = {
	cc.p(10, 0),
	cc.p(160, 0),
	cc.p(310, 0),
	(cc.p(460, 0))
}

function PopCommunityMedalChangeLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopCommunityMedalChangeLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopCommunityMedalChangeLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopCommunityMedalChangeLayer.json" or "PopCommunityMedalChangeLayer.ExportJson")

	self.rootLayer:setBackGroundColorOpacity(0)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.tablelayer = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_2")
	self.btn_sure = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_3")
	self.items = ccui.Helper:seekWidgetByName(self.rootLayer, "items")
	self.itemsbtn = ccui.Helper:seekWidgetByName(self.rootLayer, "items_btn")
	self.listview = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_68")
	self.medalimg = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_69")
	self.medalname = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_72")
	self.medaldes = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_74")

	self.medalname:setString("")
	self.medaldes:setString("")

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_1")

	self.rootpanel:setCascadeOpacityEnabled(false)
	self.rootpanel:setPositionY(GameDisplay.getScreenSize().height / 2)
	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 0)

	self.topbtnindex = 1
	self.medalindex = 1
	self.medaldata = {}

	if arg_3_1 then
		self.usemedalid = arg_3_1.medalid or 1
	end

	if arg_3_1 then
		self.callback = arg_3_1.callback or nil
	end

	self:initUI()
	global_window_open_action(self.rootpanel)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			-- block empty
		end
	end)
end

function PopCommunityMedalChangeLayer:initUI()
	self.listview:removeAllChildren()
	self.listview:setItemsMargin(1)

	self.topbtns = {}

	for iter_7_0, iter_7_1 in ipairs(var_0_9) do
		local var_7_0 = self.itemsbtn:clone()

		var_7_0.id = iter_7_0
		var_7_0:getChildByName("Button_12").id = iter_7_0

		var_7_0:getChildByName("Button_12"):loadTextures(var_0_9[iter_7_0].off, nil, var_0_9[iter_7_0].off, var_0_7)
		var_7_0:getChildByName("Button_12"):addTouchEventListener(function(arg_8_0, arg_8_1)
			if arg_8_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.topbtnindex == arg_8_0.id then
				return
			end

			self.topbtnindex = arg_8_0.id

			self:updateTopBtnStatus()
		end)
		table.insert(self.topbtns, var_7_0)
		self.listview:pushBackCustomItem(var_7_0)
	end

	self:updateTopBtnStatus()
	self:initSureBtn()
end

function PopCommunityMedalChangeLayer:updateTopBtnStatus()
	for iter_9_0, iter_9_1 in ipairs(self.topbtns) do
		if iter_9_0 == self.topbtnindex then
			iter_9_1:getChildByName("Button_12"):loadTextures(var_0_9[iter_9_0].on, nil, var_0_9[iter_9_0].on, var_0_7)
			self:updateSelectLayer()
		else
			iter_9_1:getChildByName("Button_12"):loadTextures(var_0_9[iter_9_0].off, nil, var_0_9[iter_9_0].off, var_0_7)
		end
	end
end

function PopCommunityMedalChangeLayer:updateSelectLayer()
	if self.topbtnindex == 1 then
		self:initMedalLayer()
	end
end

function PopCommunityMedalChangeLayer:initSureBtn()
	self.btn_sure:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self:checkIsVialid() then
			self:exit()
		end
	end)
end

function PopCommunityMedalChangeLayer:checkIsVialid()
	if self.medaldata[self.medalindex].levelunlock then
		if community_system_manager:getCommityLevel() >= self.medaldata[self.medalindex].levelunlock then
			return true
		else
			global_ShowBlockWords(COMMUNITY_POPCOMMUNITYMEDALCHANGELAYER.tips1)

			return false
		end
	else
		return true
	end
end

function PopCommunityMedalChangeLayer:initMedalLayer()
	self.medaldata = family_medal_data

	if self.tablelayer:getChildByName("tableview_medal") then
		self.tablelayer:removeAllChildren()

		self.tableviewmedal = nil
	end

	if not self.medaldata or not next(self.medaldata) then
		return
	end

	local var_14_0 = cc.TableView:create(cc.size(self.tablelayer:getContentSize().width, self.tablelayer:getContentSize().height))

	var_14_0:setPosition(0, 0)
	var_14_0:setDelegate()
	var_14_0:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	var_14_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_14_0:setName("tableview_medal")
	self.tablelayer:addChild(var_14_0, 99)

	self.tableviewmedal = var_14_0

	self:initMedalTableView()
	self:updateMedalInfo()
end

function PopCommunityMedalChangeLayer:updateMedalInfo()
	local var_15_0 = self.medaldata[self.medalindex].name or ""
	local var_15_1 = self.medaldata[self.medalindex].des or ""

	self.medalimg:loadTexture("equipment/family/" .. self.medaldata[self.medalindex].image_id .. ".png")
	self.medalname:setString(var_15_0)
	self.medaldes:setString(var_15_1)

	if self.usemedalid == self.medalindex then
		self.btn_sure:loadTextures(var_0_10.off, nil, var_0_10.off, var_0_7)
		self.btn_sure:setTouchEnabled(false)
	else
		self.btn_sure:loadTextures(var_0_10.on, nil, var_0_10.on, var_0_7)
		self.btn_sure:setTouchEnabled(true)
	end
end

function PopCommunityMedalChangeLayer:createMedalNode()
	return (self.items:clone())
end

function PopCommunityMedalChangeLayer:updateMedalTableViewPanel()
	if not self.tableviewmedal or not self.medaldata then
		return
	end

	local var_17_0, var_17_1 = GetTableViewShowCellIdx(self.tableviewmedal, {
		cellsize = cc.size(var_0_11, var_0_12),
		maxcount = self:getCurDataListLen()
	})

	for iter_17_0 = var_17_0, var_17_1 do
		self.tableviewmedal:updateCellAtIndex(iter_17_0)
	end
end

function PopCommunityMedalChangeLayer:getCurDataListLen()
	local var_18_0 = math.ceil(#self.medaldata / 4)

	if var_18_0 < 3 then
		var_18_0 = 3
	end

	return var_18_0
end

function PopCommunityMedalChangeLayer:initMedalTableView()
	self.tableviewmedal:registerScriptHandler(function(arg_22_0, arg_22_1)
		return var_0_11, var_0_12
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableviewmedal:registerScriptHandler(function(arg_20_0, arg_20_1)
		local var_20_0 = arg_20_0:dequeueCell()

		if not var_20_0 then
			var_20_0 = cc.TableViewCell:create()

			local var_20_1 = 4

			for iter_20_0 = 1, 4 do
				local var_20_2 = self:createMedalNode()

				var_20_2:setName("sp_" .. iter_20_0)
				var_20_2:setPosition(var_0_13[iter_20_0])

				var_20_2:getChildByName("Button_12").selectindex = var_20_1 * arg_20_1 + iter_20_0

				var_20_2:getChildByName("Button_12"):setSwallowTouches(false)
				var_20_2:getChildByName("Button_12"):addTouchEventListener(function(arg_21_0, arg_21_1)
					if arg_21_1 ~= ccui.TouchEventType.ended then
						return
					end

					if math.abs(arg_21_0:getTouchBeganPosition().y - arg_21_0:getTouchEndPosition().y) > 50 then
						return
					end

					self.medalindex = arg_21_0.selectindex

					self:updateMedalTableViewPanel()
					self:updateMedalInfo()
				end)

				if self.medaldata[var_20_1 * arg_20_1 + iter_20_0] then
					local var_20_3 = self.medaldata[var_20_1 * arg_20_1 + iter_20_0].image_id or nil

					if var_20_3 then
						var_20_2:setVisible(true)

						var_20_2:getChildByName("Button_12").selectindex = var_20_1 * arg_20_1 + iter_20_0

						var_20_2:getChildByName("medal"):loadTexture("equipment/family/" .. var_20_3 .. ".png")

						local var_20_4 = community_system_manager:getCommityLevel()

						if var_20_4 and var_20_4 < self.medaldata[var_20_1 * arg_20_1 + iter_20_0].levelunlock then
							var_20_2:getChildByName("mask"):setVisible(true)
						else
							var_20_2:getChildByName("mask"):setVisible(false)
						end

						goto label_20_0
					end
				end

				var_20_2:setVisible(false)

				::label_20_0::

				if self.medalindex == var_20_1 * arg_20_1 + iter_20_0 then
					var_20_2:getChildByName("select"):setVisible(true)
				else
					var_20_2:getChildByName("select"):setVisible(false)
				end

				var_20_0:addChild(var_20_2)
			end
		else
			local var_20_5 = 4

			for iter_20_1 = 1, 4 do
				local var_20_6 = var_20_0:getChildByName("sp_" .. iter_20_1)

				if self.medaldata[var_20_5 * arg_20_1 + iter_20_1] then
					local var_20_7 = self.medaldata[var_20_5 * arg_20_1 + iter_20_1].image_id or nil

					if var_20_7 then
						var_20_6.index = arg_20_1
						var_20_6:getChildByName("Button_12").selectindex = var_20_5 * arg_20_1 + iter_20_1

						var_20_6:setVisible(true)
						var_20_6:getChildByName("medal"):loadTexture("equipment/family/" .. var_20_7 .. ".png")

						local var_20_8 = community_system_manager:getCommityLevel()

						if var_20_8 and var_20_8 < self.medaldata[var_20_5 * arg_20_1 + iter_20_1].levelunlock then
							var_20_6:getChildByName("mask"):setVisible(true)
						else
							var_20_6:getChildByName("mask"):setVisible(false)
						end

						goto label_20_1
					end
				end

				var_20_6:setVisible(false)

				::label_20_1::

				if self.medalindex == var_20_5 * arg_20_1 + iter_20_1 then
					var_20_6:getChildByName("select"):setVisible(true)
				else
					var_20_6:getChildByName("select"):setVisible(false)
				end
			end
		end

		return var_20_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableviewmedal:registerScriptHandler(function(arg_23_0, arg_23_1)
		return self:getCurDataListLen()
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableviewmedal:reloadData()
end

function PopCommunityMedalChangeLayer:initBg(arg_24_1)
	local var_24_0 = ccui.Layout:create()

	var_24_0:setTouchEnabled(true)
	var_24_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_24_0:setAnchorPoint(cc.p(0, 0))
	var_24_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_24_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_24_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_24_0:setOpacity(0)
	var_24_0:setCascadeOpacityEnabled(false)
	self:addChild(var_24_0, -1)

	local var_24_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_24_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_24_1:setPositionX(var_24_0:getContentSize().width / 2)
	var_24_1:setPositionY(var_24_0:getContentSize().height / 2)
	var_24_0:addChild(var_24_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_25_0)
		self:addChild(arg_25_0, -2)
		arg_25_0:setPositionY(arg_25_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_24_1)
		var_24_0:setOpacity(102)
		var_24_0:setTouchEnabled(false)
	end)
end

function PopCommunityMedalChangeLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		if self.callback then
			self.callback(family_medal_data[self.medalindex].id)
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end
