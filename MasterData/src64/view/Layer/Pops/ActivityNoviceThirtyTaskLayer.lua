require("view.Layer.Pops.PopBaseLayer")

ActivityNoviceThirtyTaskLayer = class("ActivityNoviceThirtyTaskLayer", function()
	return PopBaseLayer:create()
end)

local playermodel = require("model.playermodel")
local activity_manager = require("controller.activity_manager")
local drop_manager = require("controller.drop_manager")
local time_check_manager = require("controller.time_check_manager")
local item_data = require("data.item_data")
local ShowGirlLayer = require("view.Layer.ShowGirlLayer")
local activity_sign_data = require("data.activity_sign_data")
local var_0_7 = config._DEBUG and 0 or 1

function ActivityNoviceThirtyTaskLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = ActivityNoviceThirtyTaskLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function ActivityNoviceThirtyTaskLayer:init(arg_4_1)
	self._id = arg_4_1.activityid
	self._cansign = false

	local var_4_0 = config._DEBUG and "ActivityNoviceThirtyTaskLayer.json" or "ActivityNoviceThirtyTaskLayer.ExportJson"

	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setContentSize(cc.size(640, GameDisplay.height))
	self.rootLayer:setTouchEnabled(false)
	self:addChild(self.rootLayer)

	self.rootpanel = ccs.GUIReader:getInstance():widgetFromJsonFile(var_4_0)

	self.rootpanel:setPositionY(-100 + GameDisplay.fix_y)
	self.rootLayer:addChild(self.rootpanel, 10)
	self:initUI()
	self:initData()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			if self.taskPanel then
				self.taskPanel:release()
			end

			activity_manager:releaseEventListenerByName("ActivityNoviceThirtyTaskLayer")
		end
	end)
end

function ActivityNoviceThirtyTaskLayer:initUI()
	self.taskPanel = ccui.Helper:seekWidgetByName(self.rootpanel, "label_exp")

	self.taskPanel:retain()
	self.taskPanel:removeFromParent()
end

function ActivityNoviceThirtyTaskLayer.initData(arg_8_0)
	activity_manager:getActivitySignData(480, function(arg_9_0)
		arg_8_0.taskList = {}
		arg_8_0._signcount = 0

		for iter_9_0, iter_9_1 in pairs(arg_9_0.otherData.drops) do
			if arg_9_0.signstats[iter_9_0] then
				arg_8_0._signcount = arg_8_0._signcount + 1
			end

			table.insert(arg_8_0.taskList, {
				drops = iter_9_1,
				signstats = arg_9_0.signstats[iter_9_0],
				day = iter_9_0
			})
		end

		arg_8_0._cansign = arg_9_0.cansign

		arg_8_0:updateUI()
		arg_8_0:updateBanner()
	end)
end

function ActivityNoviceThirtyTaskLayer:updateUI()
	self:updateListView()
	self:notifyUpdate()
end

function ActivityNoviceThirtyTaskLayer:updateBanner()
	if activity_manager:getSignVersion(480) >= 4 then
		ccui.Helper:seekWidgetByName(self.rootpanel, "Image_banner"):loadTexture("ActivityNoviceThirtyTaskLayer/banner_replace.png", var_0_7)
	end
end

function ActivityNoviceThirtyTaskLayer.notifyUpdate(arg_12_0)
	cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("NOVICE_SUMMARY_UPDATE")))
end

function ActivityNoviceThirtyTaskLayer:updateListView()
	self.taskView = cc.TableView:create(cc.size(589, 960))

	self.taskView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.taskView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.taskView:setAnchorPoint(cc.p(0, 0))
	self.taskView:setPosition(196, 80)
	self.taskView:setDelegate()
	self.rootpanel:addChild(self.taskView, 1000)
	self.taskView:registerScriptHandler(function(arg_15_0, arg_15_1)
		return 640, 137
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.taskView:registerScriptHandler(function(arg_14_0, arg_14_1)
		local var_14_0 = arg_14_0:dequeueCell()

		if not var_14_0 then
			var_14_0 = cc.TableViewCell:create()

			var_14_0:setName("cell_" .. arg_14_1)

			local var_14_1 = self:createTaskInfoPanel(self.taskList[arg_14_1 + 1], arg_14_1)

			var_14_1:setName("taskinfo")
			var_14_1:setPosition(cc.p(0, 20))
			var_14_0:addChild(var_14_1)
		else
			var_14_0:getChildByName("taskinfo"):updateTaskInfo(self.taskList[arg_14_1 + 1])
		end

		return var_14_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.taskView:registerScriptHandler(function(arg_16_0, arg_16_1)
		return #self.taskList
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.taskView:reloadData()
	self.taskView:scrollToIndex(self._signcount + 6, false)
end

function ActivityNoviceThirtyTaskLayer:createTaskInfoPanel(arg_17_1, arg_17_2)
	local var_17_0 = self.taskPanel:clone()

	var_17_0.index = arg_17_2

	function var_17_0:updateTaskInfo(arg_18_1)
		local var_18_0 = self:getChildByName("label_day")

		if self:getChildByName("title_label") then
			self:getChildByName("title_label"):removeFromParent()
		end

		var_18_0:setVisible(false)

		local var_18_1 = cc.Label:createWithTTF(arg_18_1.day, FONT_DES, 60)

		var_18_1:setName("title_label")
		var_18_1:setPosition(var_18_0:getPositionX(), var_18_0:getPositionY())
		self:addChild(var_18_1)

		self.taskinfo = arg_18_1

		self:updateFinishedTask()
	end

	function var_17_0:updateFinishedTask()
		local var_19_0 = self.taskinfo
		local var_19_1 = drop_manager:getDropMsg(self.taskinfo.drops)

		if not next(var_19_1.equips) and var_19_1.diamond > 0 then
			var_19_1.equips[1] = {
				dropid = "diamond"
			}
		end

		self:getChildByName("button_getAwards"):setVisible(false)

		for iter_19_0, iter_19_1 in pairs(var_19_1.equips) do
			if self:getChildByName("item_sp_" .. iter_19_0) then
				self:getChildByName("item_sp_" .. iter_19_0):removeFromParent()
			end

			local var_19_2 = ItemPurchaseSprite:createPurchaseItem(var_19_1.equips[iter_19_0].dropid)
			local var_19_3 = self:getChildByName("Image_task_" .. iter_19_0)

			self:getChildByName("Image_task_" .. iter_19_0):setVisible(false)
			var_19_2:setName("item_sp_" .. iter_19_0)
			var_19_2:setScale(0.5)
			var_19_2:setPosition(cc.p(var_19_3:getPositionX(), var_19_3:getPositionY()))
			self:addChild(var_19_2)
			var_19_2:setTouchEnabled(true)
			var_19_2:addTouchEventListener(function(arg_20_0, arg_20_1)
				if arg_20_1 ~= ccui.TouchEventType.ended then
					return
				end

				showItemDetails(var_19_1.equips[iter_19_0].dropid)
			end)

			local var_19_4 = self:getChildByName("Label_name_" .. iter_19_0)

			if var_19_1.equips[iter_19_0] and var_19_1.equips[iter_19_0].dropid then
				if var_19_1.equips[iter_19_0].dropNum > 1 then
					var_19_4:setString("x" .. var_19_1.equips[iter_19_0].dropNum)
				end

				local var_19_6

				do
					var_19_4:setString(item_data[var_19_1.equips[iter_19_0].dropid].name)

					var_19_6 = var_19_4:getContentSize().width > 106 and 106 / var_19_4:getContentSize().width or 1
				end

				var_19_4:setScaleX(var_19_6)
			end
		end

		if self._signcount + 1 == self.taskinfo.day then
			if self._cansign then
				self:getChildByName("button_getAwards"):setVisible(true)
				self:getChildByName("button_done"):setVisible(false)
				self:getChildByName("button_getAwards"):addTouchEventListener(function(arg_21_0, arg_21_1)
					if arg_21_1 ~= ccui.TouchEventType.ended then
						return
					end

					activity_manager:activitySign(480, var_19_0.day, function(arg_22_0)
						self._cansign = false
						self._signcount = self._signcount + 1

						activity_manager:updateActivityAlert("sign", self._id, false)

						if self._signcount >= 30 then
							activity_manager:update_module_stat(self._id, "sign", true)
						end

						self.taskView:scrollToIndex(self._signcount + 6, false)
					end)
					self:getChildByName("button_getAwards"):setVisible(false)
					self:getChildByName("button_done"):setVisible(true)
				end)
			else
				self:getChildByName("button_getAwards"):setVisible(false)
				self:getChildByName("button_done"):setVisible(false)
			end
		end

		if self._signcount + 1 > self.taskinfo.day then
			self:getChildByName("button_getAwards"):setVisible(false)
			self:getChildByName("button_done"):setVisible(true)
		end

		if self._signcount + 1 < self.taskinfo.day then
			self:getChildByName("button_getAwards"):setVisible(false)
			self:getChildByName("button_done"):setVisible(false)
		end
	end

	var_17_0:updateTaskInfo(arg_17_1)

	return var_17_0
end
