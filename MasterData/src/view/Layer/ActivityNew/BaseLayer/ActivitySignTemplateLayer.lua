ActivitySignTemplateLayer = class("ActivitySignTemplateLayer", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")
require("view.Sprite.ConfirmDialogSprite")

local item_data = require("data.item_data")
local drop_data = require("data.drop_data")
local activity_sign_data = require("data.activity_sign_data")
local activity_conf_data = require("data.activity_conf_data")
local time_check_manager = require("controller.time_check_manager")
local activity_manager = require("controller.activity_manager")
local drop_manager = require("controller.drop_manager")
local var_0_10 = 1
local var_0_11 = 2
local var_0_12 = 3

function ActivitySignTemplateLayer:getPath(arg_2_1)
	return self.activityPath .. arg_2_1
end

function ActivitySignTemplateLayer:getUiPositionConf(arg_3_1)
	local activity_sign_uiconfig_data = require("data.activity_template_ui_conf.activity_sign_uiconfig_data")

	return not activity_sign_uiconfig_data["sign_" .. self.activityid] and (require("data.activity_template_ui_conf.sign.activity_sign_uiconfig_" .. self.activityid .. "_data")[arg_3_1] or activity_sign_uiconfig_data.template[arg_3_1]) or activity_sign_uiconfig_data["sign_" .. self.activityid] and (activity_sign_uiconfig_data["sign_" .. self.activityid][arg_3_1] or activity_sign_uiconfig_data.template[arg_3_1]) or activity_sign_uiconfig_data.template[arg_3_1]
end

function ActivitySignTemplateLayer.create(arg_4_0, arg_4_1)
	local var_4_0 = ActivitySignTemplateLayer.new()

	var_4_0:init(arg_4_1)

	return var_4_0
end

function ActivitySignTemplateLayer:init(arg_5_1)
	self.initparams = arg_5_1
	self.activityid = self.initparams.activityid
	self.templatePath = "activitiesRes/activitytemplate/sign/"
	self.activityPath = activity_manager:isNewVersionActivity(self.activityid) and "activitiesRes/activity" .. self.activityid .. "/sign/" or "mainScenebg/activity/sign/sign_" .. self.activityid .. "/"
	self.exitcallback = arg_5_1.exitcallback
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(false)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2 - GameDisplay.fix_y))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self:addChild(self.rootLayer, 2)

	self.rootpanel = ccui.Layout:create()

	self.rootpanel:setTouchEnabled(false)
	self.rootpanel:setContentSize(self.rootLayer:getContentSize())
	self.rootpanel:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootpanel:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, self.rootLayer:getContentSize().height / 2))
	self.rootpanel:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self.rootLayer:addChild(self.rootpanel)
	self.showActions.extendVertical(self)
	self:createFullScreenMask(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_6_0:isBright() then
			return
		end

		arg_6_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			if self.exitcallback and MainLayer and MainLayer.getInstance() then
				self.exitcallback(0)

				self.exitcallback = nil
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 180)
	self:initData(function(...)
		self:createTableView()
		self:updateUI()
		self:scrollTableView()
	end)
	self:initUI()
	self:registerScriptHandler(function(arg_9_0)
		if arg_9_0 == "exit" and self.exitcallback and MainLayer and MainLayer.getInstance() then
			self.exitcallback()

			self.exitcallback = nil
		end
	end)
	hx_print("UI文件夹:" .. self.activityPath, CONSOLE_COLOR_LIGHT_GOLD)
end

function ActivitySignTemplateLayer:initData(arg_10_1)
	self.activitySingCallback = nil
	self.startTime = nil
	self.endTime = nil
	self.signdrop = nil
	self.signdate = nil
	self.signstats = nil
	self.signTag = nil

	activity_manager:getActivitySignData(self.activityid, function(arg_11_0)
		print(dump(arg_11_0))

		self.activitySingCallback = arg_11_0.activitySingCallback
		self.startTime = arg_11_0.otherData.startTime
		self.endTime = arg_11_0.otherData.endTime
		self.signdrop = arg_11_0.otherData.drops
		self.signdate = arg_11_0.signdate
		self.signstats = arg_11_0.signstats
		self.signType = activity_manager:getSignType(self.activityid)
		self.signTag = arg_11_0.signTag or arg_11_0.cansign

		if not self.signstats or type(self.signstats) == "number" then
			self.signstats = {}

			for iter_11_0, iter_11_1 in pairs(self.signdrop) do
				table.insert(self.signstats, iter_11_0 <= arg_11_0.signTime)
			end
		end

		if arg_10_1 then
			arg_10_1()
		end
	end)
end

function ActivitySignTemplateLayer:initUI()
	self.bg = ccui.ImageView:create(self:getPath("bg.png"))

	self.bg:setAnchorPoint(cc.p(0.5, 0.5))
	self.bg:setPositionX(self:getUiPositionConf("bg").pos.x)
	self.bg:setPositionY(self:getUiPositionConf("bg").pos.y + (self:getUiPositionConf("bg").pos.fix_y or 0) * GameDisplay.fix_y)
	self.bg:setTouchEnabled(true)
	self.rootpanel:addChild(self.bg, self:getUiPositionConf("bg").zorder)

	local var_12_0 = ccui.Layout:create()

	var_12_0:setTouchEnabled(true)
	var_12_0:setContentSize(cc.size(500, 100))
	var_12_0:setAnchorPoint(cc.p(0.5, 1))
	var_12_0:setPosition(cc.p(320, self.bg:getPositionY() - self.bg:getContentSize().height / 2))
	var_12_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self.rootpanel:addChild(var_12_0, 9999)
	var_12_0:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			if self.exitcallback and MainLayer and MainLayer.getInstance() then
				self.exitcallback(0)

				self.exitcallback = nil
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)

	self.title = ccui.ImageView:create(self:getPath("title.png"))

	self.title:setAnchorPoint(cc.p(0.5, 0.5))
	self.title:setPositionX(self:getUiPositionConf("title").pos.x)
	self.title:setPositionY(self:getUiPositionConf("title").pos.y + (self:getUiPositionConf("title").pos.fix_y or 0) * GameDisplay.fix_y)
	self.rootpanel:addChild(self.title, self:getUiPositionConf("title").zorder)

	self.label_time = cc.Label:createWithTTF("", FONT_DES, self:getUiPositionConf("label_time").fontsize)

	self.label_time:setColor(self:getUiPositionConf("label_time").color)
	self.label_time:setAnchorPoint(self:getUiPositionConf("label_time").anchorpoint)
	self.label_time:setPositionX(self:getUiPositionConf("label_time").pos.x)
	self.label_time:setPositionY(self:getUiPositionConf("label_time").pos.y + (self:getUiPositionConf("label_time").pos.fix_y or 0) * GameDisplay.fix_y)

	if self:getUiPositionConf("label_time").visible ~= nil then
		self.label_time:setVisible(self:getUiPositionConf("label_time").visible)
	end

	self.rootpanel:addChild(self.label_time, self:getUiPositionConf("label_time").zorder)

	self.time_bg = ccui.ImageView:create(self:getPath("time_bg.png"))

	self.time_bg:setAnchorPoint(self:getUiPositionConf("time_bg").anchorpoint)
	self.time_bg:setPositionX(self:getUiPositionConf("time_bg").pos.x)
	self.time_bg:setPositionY(self:getUiPositionConf("time_bg").pos.y + (self:getUiPositionConf("time_bg").pos.fix_y or 0) * GameDisplay.fix_y)
	self.time_bg:setVisible(self:getUiPositionConf("time_bg").visible)
	self.rootpanel:addChild(self.time_bg, self:getUiPositionConf("time_bg").zorder)

	if cc.FileUtils:getInstance():isFileExist(self:getPath("cover.png")) then
		self.cover = ccui.ImageView:create(self:getPath("cover.png"))

		self.cover:setPosition(cc.p(self.rootpanel:getContentSize().width / 2, self.rootpanel:getContentSize().height / 2))
		self.rootpanel:addChild(self.cover, 1000)
	end

	if self:getUiPositionConf("label_des") then
		self.label_des = cc.Label:createWithTTF(self:getUiPositionConf("label_des").text or "", FONT_DES, self:getUiPositionConf("label_des").fontsize)

		self.label_des:setColor(self:getUiPositionConf("label_des").color)
		self.label_des:setAnchorPoint(self:getUiPositionConf("label_des").anchorpoint)
		self.label_des:setPositionX(self:getUiPositionConf("label_des").pos.x)
		self.label_des:setPositionY(self:getUiPositionConf("label_des").pos.y + (self:getUiPositionConf("label_des").pos.fix_y or 0) * GameDisplay.fix_y)
		self.rootpanel:addChild(self.label_des, self:getUiPositionConf("label_des").zorder)
	end
end

function ActivitySignTemplateLayer:createTableView()
	self.tableView = cc.TableView:create(self:getUiPositionConf("tableView").size)

	self.tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableView:setPositionX(self:getUiPositionConf("tableView").pos.x)
	self.tableView:setPositionY(self:getUiPositionConf("tableView").pos.y + (self:getUiPositionConf("tableView").pos.fix_y or 0) * GameDisplay.fix_y)
	self.tableView:setDelegate()
	self.rootpanel:addChild(self.tableView, self:getUiPositionConf("tableView").zorder)
	self.tableView:registerScriptHandler(function(arg_17_0, arg_17_1)
		local var_17_0 = self:getUiPositionConf("cell").size

		return var_17_0.width, var_17_0.height + ((arg_17_1 + 1 == #self.signstats or nil) and (self:getUiPositionConf("tableView").cell_bottom_space or 0))
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableView:registerScriptHandler(function(arg_16_0, arg_16_1)
		local var_16_0 = arg_16_0:dequeueCell() or cc.TableViewCell:create()

		if not var_16_0:getChildByName("sp") then
			local var_16_1 = self:createSp()

			var_16_1:setName("sp")
			var_16_0:addChild(var_16_1)
		end

		local var_16_2 = var_16_0:getChildByName("sp")

		var_16_2:update(arg_16_1 + 1)

		if arg_16_1 + 1 == #self.signstats then
			var_16_2:setPositionY(self:getUiPositionConf("tableView").cell_bottom_space)
		else
			var_16_2:setPositionY(0)
		end

		return var_16_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableView:registerScriptHandler(function(arg_18_0, arg_18_1)
		return #self.signstats
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableView:reloadData()
end

function ActivitySignTemplateLayer:scrollTableView()
	local var_19_0 = 1

	if self.signType == var_0_12 or self.signType == var_0_10 then
		for iter_19_0, iter_19_1 in pairs(self.signstats) do
			if iter_19_1 then
				var_19_0 = iter_19_0 + 1
			end
		end

		var_19_0 = math.min(var_19_0, #self.signstats)
	elseif self.signType == var_0_11 then
		for iter_19_2, iter_19_3 in pairs(self.signdate) do
			if os.time(parse_time(iter_19_3 .. " 00:00:00")) == os.time(parse_time((os.date("%Y-%m-%d 00:00:00", time_check_manager:getCurTime())))) then
				var_19_0 = iter_19_2
			end
		end
	end

	self.tableView:scrollToPercent(var_19_0 / #self.signstats * 100, nil, false)
end

function ActivitySignTemplateLayer:createSp()
	local var_20_0 = ccui.Layout:create()

	var_20_0:setContentSize(self:getUiPositionConf("cell").size)
	var_20_0:setAnchorPoint(cc.p(0, 0))
	var_20_0:setPosition(cc.p(0, 0))
	var_20_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)

	local var_20_1 = ccui.ImageView:create(self:getPath("cell_bg.png"))

	var_20_1:setPositionX(var_20_0:getContentSize().width / 2)
	var_20_1:setPositionY(var_20_0:getContentSize().height / 2)
	var_20_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_20_0:addChild(var_20_1)

	local var_20_2 = ccui.ImageView:create(self:getPath("1.png"))

	var_20_2:setName("numimg")
	var_20_2:setPosition(self:getUiPositionConf("numimg").pos)
	var_20_0:addChild(var_20_2, self:getUiPositionConf("numimg").zorder)

	local var_20_3 = ccui.ImageView:create(self:getPath("sign_des.png"))

	var_20_3:setName("sign_des")
	var_20_3:setPosition(self:getUiPositionConf("sign_des").pos)
	var_20_0:addChild(var_20_3, self:getUiPositionConf("sign_des").zorder)

	local var_20_4 = {
		self:getUiPositionConf("sp_bg").white,
		self:getUiPositionConf("sp_bg").green,
		self:getUiPositionConf("sp_bg").blue,
		self:getUiPositionConf("sp_bg").purple,
		self:getUiPositionConf("sp_bg").orange,
		self:getUiPositionConf("sp_bg").red
	}
	local var_20_5 = self:getUiPositionConf("sp_num_lab").size
	local var_20_6 = self:getUiPositionConf("sp_num_lab").color

	if self:getUiPositionConf("cellscrollview") and self:getUiPositionConf("cellscrollview").iscreate then
		local var_20_7 = ccui.ScrollView:create()

		var_20_7:setBounceEnabled(true)
		var_20_7:setContentSize(self:getUiPositionConf("cellscrollview").size)
		var_20_7:setInnerContainerSize(self:getUiPositionConf("cellscrollview").containersize)
		var_20_7:setPosition(self:getUiPositionConf("cellscrollview").pos)
		var_20_7:setDirection(ccui.ScrollViewDir.horizontal)
		var_20_7:setName("cellscrollview")
		var_20_7:setTouchEnabled(false)
		var_20_0:addChild(var_20_7)

		for iter_20_0 = 1, 4 do
			local var_20_8 = ccui.Layout:create()

			var_20_8:setName("item_" .. iter_20_0)
			var_20_8:setContentSize(cc.size(96, 111))
			var_20_8:setAnchorPoint(cc.p(0.5, 0.5))
			var_20_8:setPosition(self:getUiPositionConf("item_" .. iter_20_0).pos)
			var_20_8:setScale(self:getUiPositionConf("item_" .. iter_20_0).scale)
			var_20_8:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
			var_20_7:addChild(var_20_8, self:getUiPositionConf("item_" .. iter_20_0).zorder)

			local var_20_9 = ItemSpriteSign:createSignItem()

			var_20_9:setItemUIConf({
				bgpath = var_20_4,
				labelSize = var_20_5,
				labelColor = var_20_6
			})
			var_20_9:setName("sp")
			var_20_9:setPositionX(var_20_8:getContentSize().width / 2)
			var_20_9:setPositionY(var_20_8:getContentSize().height / 2)
			var_20_8:addChild(var_20_9)
			var_20_9:setInfoTouchEvent(true)
			var_20_9:setSwallowTouches(false)
		end
	else
		for iter_20_1 = 1, 3 do
			local var_20_10 = ccui.Layout:create()

			var_20_10:setName("item_" .. iter_20_1)
			var_20_10:setContentSize(cc.size(96, 111))
			var_20_10:setAnchorPoint(cc.p(0.5, 0.5))
			var_20_10:setPosition(self:getUiPositionConf("item_" .. iter_20_1).pos)
			var_20_10:setScale(self:getUiPositionConf("item_" .. iter_20_1).scale)
			var_20_10:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
			var_20_0:addChild(var_20_10, self:getUiPositionConf("item_" .. iter_20_1).zorder)

			local var_20_11 = ItemSpriteSign:createSignItem()

			var_20_11:setItemUIConf({
				bgpath = var_20_4,
				labelSize = var_20_5,
				labelColor = var_20_6
			})
			var_20_11:setName("sp")
			var_20_11:setPositionX(var_20_10:getContentSize().width / 2)
			var_20_11:setPositionY(var_20_10:getContentSize().height / 2)
			var_20_10:addChild(var_20_11)
			var_20_11:setInfoTouchEvent(true)
			var_20_11:setSwallowTouches(false)
		end
	end

	local var_20_12 = ccui.Layout:create()

	var_20_12:setTouchEnabled(false)
	var_20_12:setContentSize(self:getUiPositionConf("cell_mask").size)
	var_20_12:setAnchorPoint(cc.p(0.5, 0.5))
	var_20_12:setPosition(cc.p(var_20_0:getContentSize().width / 2, var_20_0:getContentSize().height / 2))
	var_20_12:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_20_12:setBackGroundColor(cc.c3b(0, 0, 0))
	var_20_12:setBackGroundColorOpacity(85)
	var_20_12:setName("cell_mask")
	var_20_0:addChild(var_20_12, self:getUiPositionConf("cell_mask").zorder)

	local var_20_13 = ccui.Button:create(self:getPath("btn_sign.png"))

	var_20_13:setName("btn_sign")
	var_20_13:setPosition(self:getUiPositionConf("btn_sign").pos)
	var_20_13:setSwallowTouches(false)
	var_20_0:addChild(var_20_13, self:getUiPositionConf("btn_sign").zorder)
	var_20_13:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_21_0:getTouchBeganPosition().y - arg_21_0:getTouchEndPosition().y) > 50 then
			return
		end

		if self.signstats[arg_21_0.id] then
			return
		end

		if not arg_21_0:isBright() then
			return
		end

		arg_21_0:setBright(false)
		self:sign(arg_21_0.id, function()
			arg_21_0:setBright(true)
		end)
	end)

	function var_20_0:update(arg_23_1)
		self.id = arg_23_1
		self:getChildByName("btn_sign").id = arg_23_1

		self:getChildByName("numimg"):loadTexture(self:getPath(arg_23_1 .. ".png"))
		assert(self.signdrop[arg_23_1], "没从服务器拿到签到的填掉落id！！！！")

		local var_23_0 = {}

		if self.activityid == TGV_SIGN_ACTIVITYID then
			var_23_0 = {
				{
					itemid = 6800601,
					num = self.signdrop[arg_23_1],
					name = item_data[6800601].name
				}
			}
		else
			local var_23_1 = drop_manager:getDropMsg(self.signdrop[arg_23_1])

			if var_23_1.diamond > 0 then
				table.insert(var_23_0, {
					itemid = "diamond",
					num = var_23_1.diamond,
					name = L_DIAMOND
				})
			end

			if var_23_1.gold > 0 then
				table.insert(var_23_0, {
					itemid = "gold",
					num = var_23_1.gold,
					name = L_GOLD
				})
			end

			local var_23_2 = {}

			for iter_23_0, iter_23_1 in pairs(var_23_1.equips) do
				table.insert(var_23_2, {
					itemid = iter_23_1.dropid,
					num = iter_23_1.dropNum,
					name = item_data[iter_23_1.dropid].name
				})
			end

			for iter_23_2, iter_23_3 in pairs(var_23_2) do
				table.insert(var_23_0, iter_23_3)
			end
		end

		if self:getChildByName("cellscrollview") and self:getUiPositionConf("cellscrollview").iscreate then
			for iter_23_4 = 1, 4 do
				local var_23_3 = self:getChildByName("cellscrollview"):getChildByName("item_" .. iter_23_4):getChildByName("sp")

				var_23_3:setVisible(false)

				if var_23_0[iter_23_4] then
					var_23_3:setVisible(true)
					var_23_3:updateSignItemByItemid(var_23_0[iter_23_4].itemid, var_23_0[iter_23_4].num)
				end
			end
		else
			for iter_23_5 = 1, 3 do
				local var_23_4 = self:getChildByName("item_" .. iter_23_5):getChildByName("sp")

				var_23_4:setVisible(false)

				if var_23_0[iter_23_5] then
					var_23_4:setVisible(true)
					var_23_4:updateSignItemByItemid(var_23_0[iter_23_5].itemid, var_23_0[iter_23_5].num)
				end
			end
		end

		self:getChildByName("sign_des"):setVisible(true)
		self:getChildByName("btn_sign"):loadTextures(self:getPath("btn_sign.png"), self:getPath("btn_sign.png"), self:getPath("btn_sign.png"))
		self:getChildByName("btn_sign"):setVisible(true)

		if self.signType == var_0_12 or self.signType == var_0_10 then
			local var_23_5 = 1

			for iter_23_6, iter_23_7 in pairs(self.signstats) do
				if iter_23_7 then
					var_23_5 = iter_23_6 + 1
				end
			end

			local var_23_6 = math.min(var_23_5, #self.signstats)

			self:getChildByName("cell_mask"):setVisible(true)

			if var_23_6 == self.id and self.signTag then
				self:getChildByName("cell_mask"):setVisible(false)
			end

			if var_23_6 < self.id or self.id == var_23_6 and not self.signTag then
				self:getChildByName("btn_sign"):setVisible(false)
			end

			if self.signType == var_0_10 and self.id == var_23_6 and not self.signTag then
				self:getChildByName("btn_sign"):setVisible(false)
			end

			if var_23_6 >= self.id and self.signTag then
				self:getChildByName("sign_des"):setVisible(false)
			end
		elseif self.signType == var_0_11 then
			local var_23_7 = os.time(parse_time((os.date("%Y-%m-%d 00:00:00", time_check_manager:getCurTime()))))
			local var_23_8 = os.time(parse_time(self.signdate[self.id] .. " 00:00:00"))

			if var_23_8 == var_23_7 then
				self:getChildByName("btn_sign"):loadTextures(self:getPath("btn_sign.png"), self:getPath("btn_sign.png"), self:getPath("btn_sign.png"))
				self:getChildByName("cell_mask"):setVisible(false)
			elseif var_23_8 < var_23_7 then
				if activity_sign_data[self.activityid .. "-" .. self.id].cansupplement then
					self:getChildByName("btn_sign"):loadTextures(self:getPath("btn_supple.png"), self:getPath("btn_supple.png"), self:getPath("btn_supple.png"))
					self:getChildByName("cell_mask"):setVisible(false)
				else
					self:getChildByName("btn_sign"):setVisible(false)
					self:getChildByName("sign_des"):setVisible(false)
					self:getChildByName("cell_mask"):setVisible(true)
				end
			else
				self:getChildByName("btn_sign"):setVisible(false)
				self:getChildByName("cell_mask"):setVisible(true)
			end
		end

		if self.signstats[self.id] then
			self:getChildByName("btn_sign"):loadTextures(self:getPath("btn_got.png"), self:getPath("btn_got.png"), self:getPath("btn_got.png"))
			self:getChildByName("sign_des"):setVisible(false)
			self:getChildByName("btn_sign"):setVisible(true)
			self:getChildByName("cell_mask"):setVisible(true)
		end

		if self:getUiPositionConf("sign_des").visible == false then
			var_20_3:setVisible(false)
		end
	end

	return var_20_0
end

function ActivitySignTemplateLayer:sign(arg_24_1, arg_24_2)
	print("ActivitySignTemplateLayer:sign", arg_24_1)

	local function var_24_0(...)
		self.activitySingCallback(arg_24_1, function(arg_28_0)
			if arg_28_0 == 1 then
				self.signstats[arg_24_1] = true
			elseif arg_28_0 == 7 then
				global_ShowBlockWords("签到时间未到")
			end

			self:updateUI()
			activity_manager:update_alert(self.activityid, "sign", {
				signType = self.signType,
				signTag = self.signTag,
				signstats = self.signstats,
				signdate = self.signdate
			})

			if arg_24_2 then
				arg_24_2()
			end
		end)
	end

	if self.signType == var_0_10 then
		(function(...)
			self.activitySingCallback(arg_24_1, function(arg_26_0)
				if arg_26_0 == 1 then
					self.signstats[arg_24_1] = true
					self.signTag = false
				elseif arg_26_0 == 7 then
					global_ShowBlockWords("签到时间未到")
				end

				self:updateUI()
				activity_manager:update_alert(self.activityid, "sign", {
					signType = self.signType,
					signTag = self.signTag,
					signstats = self.signstats,
					signdate = self.signdate
				})

				if arg_24_2 then
					arg_24_2()
				end
			end)
		end)()
	elseif os.time(parse_time((os.date("%Y-%m-%d 00:00:00", time_check_manager:getCurTime())))) > os.time(parse_time(self.signdate[arg_24_1] .. " 00:00:00")) and not self.signstats[arg_24_1] and activity_sign_data[self.activityid .. "-" .. arg_24_1].cansupplement and activity_sign_data[self.activityid .. "-" .. arg_24_1].cansupplement == 1 and activity_sign_data[self.activityid .. "-" .. arg_24_1].supplementcost > 0 then
		require("view.Sprite.ConfirmDialogSprite")

		local var_24_1 = ConfirmDialogSprite:create("操作确认", "消耗" .. activity_sign_data[self.activityid .. "-" .. arg_24_1].supplementcost .. "魂晶进行补签", {
			layerType = "HorcruxInfoLayerNew",
			surecallback = var_24_0,
			cancelCallback = arg_24_2
		}, nil, nil, arg_24_2)

		var_24_1:setPositionY(var_24_1:getPositionY() - GameDisplay.fix_y)
		self:addChild(var_24_1, 10)
	else
		var_24_0()
	end
end

function ActivitySignTemplateLayer:updateUI()
	local var_29_5 = global_get_time_by_date(self.endTime) - time_check_manager:getCurTime()
	local var_29_6 = math.floor(var_29_5 / 24 / 3600)
	local var_29_7 = math.floor((var_29_5 - var_29_6 * 24 * 3600) / 3600)
	local var_29_8 = math.floor((var_29_5 - var_29_6 * 24 * 3600 - var_29_7 * 3600) / 60)

	self.label_time:setString(L_TIME_REST2 .. L_TIME .. (0 ~= 0 and string.format(L_TIME_TEXT[1], var_29_6, var_29_7) or var_29_7 ~= 0 and string.format(L_TIME_TEXT[2], var_29_7, var_29_8) or string.format(L_TIME_TEXT[3], var_29_8)))
	self:updateShowingCells()
end

function ActivitySignTemplateLayer:updateShowingCells()
	local var_30_0, var_30_1 = GetTableViewShowCellIdx(self.tableView, {
		cellsize = self:getUiPositionConf("cell").size,
		maxcount = #self.signstats
	})

	for iter_30_0 = var_30_0, var_30_1 do
		self.tableView:updateCellAtIndex(iter_30_0)
	end
end

function ActivitySignTemplateLayer.createBaseClass(arg_31_0, arg_31_1)
	local var_31_0 = ActivitySignTemplateLayer.new()

	var_31_0:init(arg_31_1)
	var_31_0:getChildByName("fullScreenMask"):setVisible(false)

	return var_31_0
end

ActivitySignTemplateSpLayer = class("ActivitySignTemplateSpLayer", function(...)
	return ActivitySignTemplateLayer:createBaseClass(...)
end)

function ActivitySignTemplateSpLayer.create(arg_33_0, arg_33_1)
	return (ActivitySignTemplateSpLayer.new(arg_33_1))
end
