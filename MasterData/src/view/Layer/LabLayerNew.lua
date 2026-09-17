LabLayerNew = class("LabLayerNew", function()
	return cc.Layer:create()
end)

local playermodel = require("model.playermodel")
local audio_manager = require("controller.audio_manager")
local theater_director = require("controller.theater_director")
local lab_manager = require("controller.lab_manager")
local alert_manager = require("controller.alert_manager")
local l2utils = require("controller.l2utils")
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local lab_workshop_data = require("data.lab_workshop_data")
local lab_recipe_data = require("data.lab_recipe_data")
local var_0_10
local var_0_11 = config._DEBUG and 0 or 1
local var_0_12 = {
	[RECIPE_FREE] = "lab_main_screen/room_status_free.png",
	[RECIPE_WORKING] = "lab_main_screen/room_status_making.png",
	[RECIPE_COMPLETE] = "lab_main_screen/room_status_complete.png"
}
local var_0_14 = 1
local var_0_15 = 2
local var_0_16 = {
	"mainScenebg/dorm_room_bg/81000001.png",
	"mainScenebg/dorm_room_bg/81000002.png",
	"mainScenebg/dorm_room_bg/81000003.png"
}
local var_0_17 = 950

function LabLayerNew.create(arg_2_0, arg_2_1)
	local var_2_0 = LabLayerNew.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function LabLayerNew.getInstance()
	return var_0_10
end

function LabLayerNew:init(arg_4_1)
	var_0_10 = self
	self.initParam = arg_4_1
	self.goto_back_system_id = 810

	self:initUI()
	self:registeTouchEvent()
	self:initData(function()
		self:initWheel()
		self:updateRoom()
		self:updateWheelTiles()
		self:doorOpenAction()
		self:startScheduler()
	end)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			if self.wheelTile then
				self.wheelTile:release()
			end

			var_0_10 = nil

			if self.scheduler then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduler)

				self.scheduler = nil
			end
		end
	end)
end

function LabLayerNew.initData(arg_7_0, arg_7_1)
	arg_7_0.curFloorIndex = 1
	arg_7_0.maxLabRoomNum = math.ceil(#lab_workshop_data / 4) * 4
	arg_7_0.roomListData = {}
	arg_7_0.curTime = os.time()

	lab_manager:get_recipe_list(true, function(arg_8_0)
		if not var_0_10 and arg_7_0.scheduler then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(arg_7_0.scheduler)

			arg_7_0.scheduler = nil

			return
		end

		if not arg_7_0.roomListData then
			return
		end

		arg_7_0.roomListData = arg_8_0.list

		for iter_8_0 = 1, arg_7_0.maxLabRoomNum do
			if not arg_7_0.roomListData[iter_8_0] then
				table.insert(arg_7_0.roomListData, {
					locked = true,
					modelid = 999901,
					type = var_0_15,
					slot = iter_8_0
				})
			else
				arg_7_0.roomListData[iter_8_0].modelid = 999901
			end
		end

		arg_7_0:updateGuidesOnLayer()

		if arg_7_1 then
			arg_7_1()
		end
	end)
end

function LabLayerNew:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:returnEvent()
	end, conf)

	self.bottomList:setName("bottomlist")
	self.bottomList:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.bottomList, 1000)
end

function LabLayerNew:returnEvent()
	local var_11_0

	for iter_11_0, iter_11_1 in pairs(self.roomListData) do
		if not iter_11_1.locked and iter_11_1.cacheItemCount and iter_11_1.status and iter_11_1.cacheItemCount > 0 and iter_11_1.status == RECIPE_COMPLETE then
			var_11_0 = true

			break
		end
	end

	if not var_11_0 then
		alert_manager:unregister_alert(ALERT_LAB)
	end

	KeyCodeManager:onKeyReleasedCallFunc()
end

function LabLayerNew:initUI()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "LabLayerNew.json" or "LabLayerNew.ExportJson")

	self:addChild(self.rootLayer)
	self:initBottomList()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_backGround"):loadTexture("mainScenebg/processing_factory_bg.jpg")

	self.roomPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_roomPanel")

	self:initCloneRoom()

	self.roomListObj = {}

	;(function()
		table.insert(self.roomListObj, ccui.Helper:seekWidgetByName(self.rootLayer, "roomCell_1"))

		for iter_13_0 = 2, 4 do
			local var_13_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "roomCell_1"):clone()

			var_13_0:setName("roomCell_" .. iter_13_0)
			self.roomPanel:addChild(var_13_0)
			table.insert(self.roomListObj, var_13_0)
		end

		local var_13_1 = (GameDisplay.height - self.bottomList:getContentSize().height) / 4 - 15

		for iter_13_1 = 1, 4 do
			local var_13_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "roomCell_" .. iter_13_1)

			var_13_2:getChildByName("Label_BAY"):setVisible(false)
			var_13_2:setPositionY((GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, config._DESIGN_HEIGHT - (var_0_17 - (iter_13_1 - 1) * var_13_1), TRANSFORM_UNIT.PX)))
			var_13_2:setTouchEnabled(true)
			var_13_2:addTouchEventListener(function(arg_14_0, arg_14_1)
				if arg_14_1 ~= ccui.TouchEventType.ended then
					return
				end

				self:roomTouchEvent(arg_14_0.index)
			end)
			ccui.Helper:seekWidgetByName(var_13_2, "Panel_unlock"):addTouchEventListener(function(arg_15_0, arg_15_1)
				if arg_15_1 ~= ccui.TouchEventType.ended then
					return
				end

				self:showUnlockRoomPop()
			end)
		end
	end)()
end

function LabLayerNew:roomTouchEvent(arg_16_1)
	if self.roomListData[arg_16_1].locked then
		global_ShowBlockWords(L_LAB_LOCK)
	else
		LayerManager:pushInLayer("LabLineLayer", {
			goto_back_system_id = 180,
			slotInfo = self.roomListData[arg_16_1],
			exitcallback = function()
				if var_0_10 then
					self:updateRoom()
					self:updateWheelTiles()
				end
			end
		})
	end
end

function LabLayerNew:initWheel()
	self.wheelPanel = self.rootLayer:getChildByName("Panel_wheel")
	self.wheelTile = self.wheelPanel:getChildByName("Image_tile")

	self.wheelTile:retain()
	self.wheelTile:removeFromParent()

	self.arrowUp = self.rootLayer:getChildByName("Button_arrow_up")

	self.arrowUp:setPositionY(self.arrowUp:getPositionY() - 20)
	self.arrowUp:setAnchorPoint(cc.p(0.5, 0))
	self.arrowUp:setPositionX(self.wheelTile:getPositionX() + 11)
	self.arrowUp:setScale(1.5)

	self.arrowDown = self.rootLayer:getChildByName("Button_arrow_down")

	self.arrowDown:setPositionY(self.arrowDown:getPositionY() + 20)
	self.arrowDown:setAnchorPoint(cc.p(0.5, 1))
	self.arrowDown:setPositionX(self.wheelTile:getPositionX() + 11)
	self.arrowDown:setScale(1.5)

	local var_18_0 = {
		181,
		134,
		79,
		24,
		-23
	}
	local var_18_1 = {
		0.5,
		0.7,
		1,
		0.7,
		0.5
	}

	self.wheelTiles = {}

	for iter_18_0 = 1, 4 do
		local var_18_2 = self.wheelTile:clone()

		self.wheelPanel:addChild(var_18_2)
		var_18_2:setVisible(false)

		self.wheelTiles[iter_18_0] = var_18_2
	end

	if self.curFloorIndex == 1 then
		self.arrowUp:setOpacity(100)
	elseif self.curFloorIndex == self.maxLabRoomNum / 4 then
		self.arrowDown:setOpacity(100)
	end

	local function var_18_3(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
		arg_19_0:setPositionY(var_18_0[arg_19_1])
		arg_19_0:setScale(var_18_1[arg_19_1])
		arg_19_0:setVisible(true)
		arg_19_0:getChildByName("Image_num"):loadTexture(arg_19_2, var_0_11)
	end

	local function var_18_4()
		for iter_20_0, iter_20_1 in pairs(self.wheelTiles) do
			iter_20_1:setVisible(false)
		end

		if self.curFloorIndex == 1 then
			var_18_3(self.wheelTiles[1], 3, "room_widget/num_1.png")
			var_18_3(self.wheelTiles[2], 4, "room_widget/num_2.png")
			var_18_3(self.wheelTiles[3], 5, "room_widget/num_3.png")
		elseif self.curFloorIndex == self.maxLabRoomNum / 4 then
			var_18_3(self.wheelTiles[1], 1, "room_widget/num_" .. self.maxLabRoomNum / 4 - 2 .. ".png")
			var_18_3(self.wheelTiles[2], 2, "room_widget/num_" .. self.maxLabRoomNum / 4 - 1 .. ".png")
			var_18_3(self.wheelTiles[3], 3, "room_widget/num_" .. self.maxLabRoomNum / 4 .. ".png")
		else
			var_18_3(self.wheelTiles[1], 2, "room_widget/num_" .. self.curFloorIndex - 1 .. ".png")
			var_18_3(self.wheelTiles[2], 3, "room_widget/num_" .. self.curFloorIndex .. ".png")
			var_18_3(self.wheelTiles[3], 4, "room_widget/num_" .. self.curFloorIndex + 1 .. ".png")
		end
	end

	local function var_18_5()
		if self.curFloorIndex == 1 then
			self.wheelTiles[1].id = 1
			self.wheelTiles[2].id = 2
			self.wheelTiles[3].id = 3
		elseif self.curFloorIndex == self.maxLabRoomNum / 4 then
			self.wheelTiles[1].id = self.maxLabRoomNum / 4 - 2
			self.wheelTiles[2].id = self.maxLabRoomNum / 4 - 1
			self.wheelTiles[3].id = self.maxLabRoomNum / 4
		else
			self.wheelTiles[1].id = self.curFloorIndex - 1
			self.wheelTiles[2].id = self.curFloorIndex
			self.wheelTiles[3].id = self.curFloorIndex + 1
		end
	end

	var_18_4()
	var_18_5()
	self:updateWheelTiles()

	function self.wheelPanel.changeAction(arg_22_0)
		if self.curFloorIndex == 1 then
			self.arrowUp:setOpacity(100)
		elseif self.curFloorIndex == self.maxLabRoomNum / 4 then
			self.arrowDown:setOpacity(100)
		else
			self.arrowUp:setOpacity(255)
			self.arrowDown:setOpacity(255)
		end

		local function var_22_0(arg_23_0, arg_23_1)
			arg_23_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.Spawn:create(cc.MoveTo:create(0.8, cc.p(arg_23_0:getPositionX(), var_18_0[arg_23_1])), cc.ScaleTo:create(0.8, var_18_1[arg_23_1])), cc.CallFunc:create(var_18_4)))
		end

		if arg_22_0 == "up" then
			if self.curFloorIndex ~= self.maxLabRoomNum / 4 then
				var_18_3(self.wheelTiles[4], 5, "room_widget/num_" .. self.curFloorIndex + 1 .. ".png", self.curFloorIndex + 1)
			end

			if self.curFloorIndex == 2 then
				var_22_0(self.wheelTiles[4], 5)
				var_22_0(self.wheelTiles[3], 4)
				var_22_0(self.wheelTiles[2], 3)
				var_22_0(self.wheelTiles[1], 2)
			else
				var_22_0(self.wheelTiles[4], 4)
				var_22_0(self.wheelTiles[3], 3)
				var_22_0(self.wheelTiles[2], 2)
				var_22_0(self.wheelTiles[1], 1)
			end
		elseif arg_22_0 == "down" then
			if self.curFloorIndex ~= 1 then
				var_18_3(self.wheelTiles[4], 1, "room_widget/num_" .. self.curFloorIndex - 1 .. ".png", self.curFloorIndex - 1)
			end

			if self.curFloorIndex == self.maxLabRoomNum / 4 - 1 then
				var_22_0(self.wheelTiles[4], 1)
				var_22_0(self.wheelTiles[3], 4)
				var_22_0(self.wheelTiles[2], 3)
				var_22_0(self.wheelTiles[1], 2)
			else
				var_22_0(self.wheelTiles[4], 2)
				var_22_0(self.wheelTiles[3], 5)
				var_22_0(self.wheelTiles[2], 4)
				var_22_0(self.wheelTiles[1], 3)
			end
		end

		self.wheelPanel:runAction(cc.Sequence:create(cc.DelayTime:create(1.1), cc.CallFunc:create(function()
			var_18_5()
			self:updateWheelTiles()
		end)))
	end

	self.arrowUp:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_25_0:getOpacity() ~= 255 then
			return
		end

		self:switchGroup("down")
	end)
	self.arrowDown:addTouchEventListener(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_26_0:getOpacity() ~= 255 then
			return
		end

		self:switchGroup("up")
	end)
	self.arrowUp:addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_27_0:getOpacity() ~= 255 then
			return
		end

		self:switchGroup("down")
	end)
	self.arrowDown:addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_28_0:getOpacity() ~= 255 then
			return
		end

		self:switchGroup("up")
	end)
end

function LabLayerNew:initCloneRoom()
	local var_29_0 = (GameDisplay.height - self.bottomList:getContentSize().height) / 4 - 15

	self.cloneRooms = {}

	for iter_29_0 = 5, 8 do
		local var_29_3 = ccui.ImageView:create("room_widget/room_bg_margin.png", var_0_11)

		var_29_3:setPosition(320, GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, config._DESIGN_HEIGHT - (var_0_17 - (iter_29_0 - 1) * var_29_0), TRANSFORM_UNIT.PX) - 200)
		self.rootLayer:addChild(var_29_3)

		local var_29_4 = var_29_3:getContentSize().width / 2
		local var_29_5 = var_29_3:getContentSize().height / 2
		local var_29_6 = ccui.ImageView:create("room_widget/door_L.png", var_0_11)

		var_29_6:setPosition(var_29_4, var_29_5)
		var_29_3:addChild(var_29_6)

		local var_29_7 = ccui.ImageView:create("room_widget/door_R.png", var_0_11)

		var_29_7:setPosition(var_29_4, var_29_5)
		var_29_3:addChild(var_29_7)

		self.cloneRooms[iter_29_0 - 4] = var_29_3
	end
end

function LabLayerNew:switchGroup(arg_30_1)
	if self.wheelPanel.action_state == "running" then
		return
	end

	self.wheelPanel.action_state = "running"

	if arg_30_1 == "up" then
		if self.curFloorIndex == self.maxLabRoomNum / 4 then
			self.wheelPanel.action_state = nil

			return
		end

		self.curFloorIndex = self.curFloorIndex + 1
	elseif arg_30_1 == "down" then
		if self.curFloorIndex == 1 then
			self.wheelPanel.action_state = nil

			return
		end

		self.curFloorIndex = self.curFloorIndex - 1
	end

	self:runAction(cc.Sequence:create(cc.CallFunc:create(function()
		self:doorCloseAction()
		self:roomScrollAction(arg_30_1)
		self.wheelPanel.changeAction(arg_30_1)
	end), cc.DelayTime:create(1.1), cc.CallFunc:create(function()
		self:updateRoom()
		self:doorOpenAction()
		self:updateGuidesOnLayer()

		self.wheelPanel.action_state = nil
	end)))
end

function LabLayerNew:roomScrollAction(arg_33_1)
	local var_33_0 = (GameDisplay.height - self.bottomList:getContentSize().height) / 4 - 15
	local var_33_1

	if arg_33_1 == "up" then
		var_33_1 = var_33_0 * 4 or -var_33_0 * 4
	end

	local var_33_2 = 0

	if arg_33_1 == "up" then
		var_33_2 = 100

		for iter_33_0 = 1, 4 do
			self.cloneRooms[iter_33_0]:setPositionY((GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, config._DESIGN_HEIGHT - (var_0_17 - (iter_33_0 - 1 + 4) * var_33_0) + var_33_2, TRANSFORM_UNIT.PX)))
		end
	else
		for iter_33_1 = 1, 4 do
			self.cloneRooms[iter_33_1]:setPositionY((GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, config._DESIGN_HEIGHT - (var_0_17 - (iter_33_1 - 1 - 4) * var_33_0), TRANSFORM_UNIT.PX)))
		end
	end

	for iter_33_2 = 1, 4 do
		self.roomListObj[iter_33_2]:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.MoveBy:create(0.8, cc.p(0, var_33_1))))
		self.cloneRooms[iter_33_2]:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
			self.cloneRooms[iter_33_2]:setVisible(true)
		end), cc.MoveBy:create(0.8, cc.p(0, var_33_1 + var_33_2)), cc.CallFunc:create(function()
			self.roomListObj[iter_33_2]:setPositionY((GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, config._DESIGN_HEIGHT - (var_0_17 - (iter_33_2 - 1) * var_33_0), TRANSFORM_UNIT.PX)))
			self.cloneRooms[iter_33_2]:setPositionY((GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, config._DESIGN_HEIGHT - (var_0_17 - (iter_33_2 - 1 - 4) * var_33_0), TRANSFORM_UNIT.PX)))
			self.cloneRooms[iter_33_2]:setVisible(false)
		end)))
	end
end

function LabLayerNew:doorCloseAction()
	for iter_36_0, iter_36_1 in ipairs(self.roomListObj) do
		ccui.Helper:seekWidgetByName(iter_36_1, "Image_doorR"):stopAllActions()
		ccui.Helper:seekWidgetByName(iter_36_1, "Image_doorL"):stopAllActions()
		ccui.Helper:seekWidgetByName(iter_36_1, "Image_doorR"):runAction(cc.Sequence:create(cc.DelayTime:create((iter_36_0 - 1) * 0.1), cc.MoveTo:create(0.3, cc.p(303, 129))))
		ccui.Helper:seekWidgetByName(iter_36_1, "Image_doorL"):runAction(cc.Sequence:create(cc.DelayTime:create((iter_36_0 - 1) * 0.1), cc.MoveTo:create(0.3, cc.p(303, 129))))
	end
end

function LabLayerNew:doorOpenAction(arg_37_1)
	local function var_37_0(arg_38_0)
		if self.roomListData[arg_38_0.index].type == var_0_14 then
			return true
		end

		if self.roomListData[arg_38_0.index].locked or self.roomListData[arg_38_0.index].status == RECIPE_LOCK or self.roomListData[arg_38_0.index].status == RECIPE_UNLOCK then
			return false
		end

		return true
	end

	local function var_37_1(arg_39_0, arg_39_1)
		ccui.Helper:seekWidgetByName(arg_39_0, "Image_doorR"):stopAllActions()
		ccui.Helper:seekWidgetByName(arg_39_0, "Image_doorL"):stopAllActions()

		if var_37_0(arg_39_0) then
			ccui.Helper:seekWidgetByName(arg_39_0, "Image_doorR"):runAction(cc.Sequence:create(cc.DelayTime:create((arg_39_1 - 1) * 0.1), cc.MoveTo:create(0.3, cc.p(643, 129))))
			ccui.Helper:seekWidgetByName(arg_39_0, "Image_doorL"):runAction(cc.Sequence:create(cc.DelayTime:create((arg_39_1 - 1) * 0.1), cc.MoveTo:create(0.3, cc.p(-37, 129))))
		end
	end

	if arg_37_1 then
		var_37_1(self.roomListObj[arg_37_1], arg_37_1 % 4 + 1)
	else
		for iter_37_0, iter_37_1 in ipairs(self.roomListObj) do
			var_37_1(iter_37_1, iter_37_0)
		end
	end
end

function LabLayerNew:updateRoom()
	for iter_40_0 = (self.curFloorIndex - 1) * 4 + 1, self.curFloorIndex * 4 do
		self:updateRoomByRoomIndex(iter_40_0)
	end
end

function LabLayerNew:updateRoomByRoomIndex(arg_41_1)
	local var_41_0

	for iter_41_0, iter_41_1 in pairs(self.roomListData) do
		if iter_41_1.locked or iter_41_1.status == RECIPE_LOCK or iter_41_1.status == RECIPE_UNLOCK then
			var_41_0 = iter_41_1.slot

			break
		end
	end

	local var_41_1 = self.roomListObj[arg_41_1 - (self.curFloorIndex - 1) * 4]
	local var_41_2 = arg_41_1

	var_41_1.index = arg_41_1

	ccui.Helper:seekWidgetByName(var_41_1, "Label_time"):setVisible(false)
	ccui.Helper:seekWidgetByName(var_41_1, "Image_clock"):setVisible(false)

	if not var_41_0 then
		ccui.Helper:seekWidgetByName(var_41_1, "Panel_unlock"):setVisible(false)
	else
		ccui.Helper:seekWidgetByName(var_41_1, "Panel_unlock"):setVisible(arg_41_1 == var_41_0)

		if self.roomListData[arg_41_1].status == RECIPE_LOCK then
			ccui.Helper:seekWidgetByName(var_41_1, "Image_logo"):loadTexture("room_widget/building.png", var_0_11)
			ccui.Helper:seekWidgetByName(var_41_1, "Label_time"):setVisible(true)
			ccui.Helper:seekWidgetByName(var_41_1, "Image_clock"):setVisible(true)
			ccui.Helper:seekWidgetByName(var_41_1, "Image_logo"):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
				local var_42_9001
				local var_42_9000

				ccui.Helper:seekWidgetByName(var_41_1, "Label_time"):setString(global_get_time_by_second((math.max(math.floor(self.roomListData[var_41_2].startTime + lab_workshop_data[var_41_2].cost_time - self.roomListData[var_41_2].addTime - math.ceil(self.curTime)), 0))))
				ccui.Helper:seekWidgetByName(var_41_1, "Image_clock").setPositionX(ccui.Helper:seekWidgetByName(var_41_1, "Image_clock").getContentSize(ccui.Helper:seekWidgetByName(var_41_1, "Label_time"):getContentSize().width / 2).width / 2, ccui.Helper:seekWidgetByName(var_41_1, "Label_time"):getPositionX() - var_42_9001 - var_42_9000 - 5)
			end), cc.DelayTime:create(1))))
		elseif self.roomListData[arg_41_1].status == RECIPE_UNLOCK then
			ccui.Helper:seekWidgetByName(var_41_1, "Image_logo"):loadTexture("room_widget/finish.png", var_0_11)
			ccui.Helper:seekWidgetByName(var_41_1, "Image_logo"):stopAllActions()
		else
			ccui.Helper:seekWidgetByName(var_41_1, "Image_logo"):loadTexture("room_widget/unlock.png", var_0_11)
			ccui.Helper:seekWidgetByName(var_41_1, "Image_logo"):stopAllActions()
		end
	end

	ccui.Helper:seekWidgetByName(var_41_1, "Panel_lockTouch"):setVisible(self.roomListData[arg_41_1].locked == true)
	ccui.Helper:seekWidgetByName(var_41_1, "Panel_lockTouch"):addTouchEventListener(function(arg_43_0, arg_43_1)
		if arg_43_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.roomListData[arg_41_1].locked then
			global_ShowBlockWords(L_LAB_LOCK)
		end
	end)
	ccui.Helper:seekWidgetByName(var_41_1, "Label_order"):setString(string.format("%2d", arg_41_1))
	ccui.Helper:seekWidgetByName(var_41_1, "Label_str"):setString(L_LAB_ROOM_KIND.Produce)
	self:updateScreen(arg_41_1)
	ccui.Helper:seekWidgetByName(var_41_1, "Image_roomBg"):loadTexture(var_0_16[(arg_41_1 - 1) % 3 + 1])
	ccui.Helper:seekWidgetByName(var_41_1, "Image_door"):loadTexture("lab_main_screen/recipe_door.png", var_0_11)

	if var_41_1.director then
		if not self.roomListData[arg_41_1].locked and self.roomListData[arg_41_1].modelid then
			if self.roomListData[arg_41_1].modelid ~= var_41_1.modelid or var_41_1.status ~= self.roomListData[arg_41_1].status + 1 and self.roomListData[arg_41_1].status > -1 then
				var_41_1.director:updateScriptconfig(self.roomListData[arg_41_1].modelid, self.roomListData[arg_41_1].status + 1)

				var_41_1.modelid = self.roomListData[arg_41_1].modelid
				var_41_1.status = self.roomListData[arg_41_1].status + 1
			end
		else
			var_41_1.director:deleteSelf()

			var_41_1.director = nil
		end
	elseif not self.roomListData[arg_41_1].locked and self.roomListData[arg_41_1].modelid and self.roomListData[arg_41_1].status ~= -1 and self.roomListData[arg_41_1].status ~= -2 then
		local var_41_3 = theater_director.new_lab_robot(self.roomListData[arg_41_1].modelid, ccui.Helper:seekWidgetByName(var_41_1, "Panel_show"), nil, self.roomListData[arg_41_1].status + 1)

		var_41_1.director = var_41_3

		var_41_3:startPlay()

		var_41_1.modelid = self.roomListData[arg_41_1].modelid
		var_41_1.status = self.roomListData[arg_41_1].status + 1
	end
end

function LabLayerNew:updateScreen(arg_44_1)
	local var_44_0 = {
		170,
		310
	}
	local var_44_1 = ccui.Helper:seekWidgetByName(self.roomListObj[arg_44_1 - (self.curFloorIndex - 1) * 4], "Image_screen1")

	var_44_1.index = arg_44_1

	var_44_1:setPositionX(var_44_0[1])

	var_44_1.time = 0
	var_44_1.state = "down"
	var_44_1:getChildByName("Button_arrow").state = "down"
	var_44_1:getChildByName("Button_arrow").colour = "blue"

	var_44_1:setLocalZOrder(-1)

	if false then
		var_44_1:getChildByName("Button_arrow").state = "up"

		local var_44_2 = "room_widget/" .. var_44_1:getChildByName("Button_arrow").colour .. "_up.png"

		var_44_1:getChildByName("Button_arrow"):loadTextures(var_44_2, var_44_2, var_44_2, var_0_11)
		var_44_1:setPositionY(278)
	else
		var_44_1:getChildByName("Button_arrow").state = "down"

		local var_44_3 = "room_widget/" .. var_44_1:getChildByName("Button_arrow").colour .. "_down.png"

		var_44_1:getChildByName("Button_arrow"):loadTextures(var_44_3, var_44_3, var_44_3, var_0_11)
		var_44_1:setPositionY(182)
	end

	var_44_1:getChildByName("Button_arrow"):addTouchEventListener(function(arg_45_0, arg_45_1)
		if arg_45_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_45_0.state == "up" then
			arg_45_0.state = "running"

			arg_45_0:loadTextures("room_widget/" .. arg_45_0.colour .. "_down.png", "room_widget/" .. arg_45_0.colour .. "_down.png", "room_widget/" .. arg_45_0.colour .. "_down.png", var_0_11)
			var_44_1:runAction(cc.Sequence:create(cc.MoveTo:create(0.2, cc.p(var_44_0[1], 182)), cc.MoveTo:create(0.05, cc.p(var_44_0[1], 178)), cc.MoveTo:create(0.05, cc.p(var_44_0[1], 186)), cc.MoveTo:create(0.05, cc.p(var_44_0[1], 182)), cc.CallFunc:create(function()
				arg_45_0.state = "down"
			end)))
		elseif arg_45_0.state == "down" then
			arg_45_0.state = "running"

			arg_45_0:loadTextures("room_widget/" .. arg_45_0.colour .. "_up.png", "room_widget/" .. arg_45_0.colour .. "_up.png", "room_widget/" .. arg_45_0.colour .. "_up.png", var_0_11)
			var_44_1:runAction(cc.Sequence:create(cc.MoveTo:create(0.1, cc.p(var_44_0[1], 175)), cc.MoveTo:create(0.3, cc.p(var_44_0[1], 303)), cc.CallFunc:create(function()
				arg_45_0.state = "up"
			end)))
		end
	end)
	var_44_1:getChildByName("Image_numBg"):setVisible(self.roomListData[var_44_1.index].status == RECIPE_WORKING)
	var_44_1:getChildByName("Label_progress"):setVisible(self.roomListData[var_44_1.index].cacheItemCount and self.roomListData[var_44_1.index].cacheItemCount > 0)
	var_44_1:getChildByName("Image_makingItem"):setVisible(self.roomListData[var_44_1.index].status == RECIPE_WORKING or self.roomListData[var_44_1.index].status == RECIPE_COMPLETE)
	var_44_1:getChildByName("Image_reddot"):setVisible(self.roomListData[var_44_1.index].cacheItemCount and self.roomListData[var_44_1.index].cacheItemCount > 0)

	if self.roomListData[var_44_1.index].id then
		if self.roomListData[var_44_1.index].status == RECIPE_WORKING then
			if var_44_1:getChildByName("Image_makingItem").flowlight then
				var_44_1:getChildByName("Image_makingItem").flowlight = false

				l2utils:removeNodeFlowlight(var_44_1:getChildByName("Image_makingItem"):getVirtualRenderer())
			end

			if not var_44_1:getChildByName("Image_makingItem").shake then
				l2utils:shakeNode(var_44_1:getChildByName("Image_makingItem"):getVirtualRenderer())

				var_44_1:getChildByName("Image_makingItem").shake = true
			end
		end

		if self.roomListData[var_44_1.index].status == RECIPE_COMPLETE then
			if var_44_1:getChildByName("Image_makingItem").shake then
				var_44_1:getChildByName("Image_makingItem").shake = false

				l2utils:removeNodeShake(var_44_1:getChildByName("Image_makingItem"):getVirtualRenderer())
			end

			if not var_44_1:getChildByName("Image_makingItem").flowlight then
				l2utils:flowlightNode(var_44_1:getChildByName("Image_makingItem"):getVirtualRenderer(), {
					period = 3.332665417256012,
					offset = 0.5,
					width = 0.1,
					strength = 0.05
				})

				var_44_1:getChildByName("Image_makingItem").flowlight = true
			end
		end

		var_44_1:getChildByName("Label_progress"):setString(L_LAB_GET .. self.roomListData[var_44_1.index].cacheItemCount)
		var_44_1:getChildByName("Image_makingItem"):loadTexture("equipment/" .. item_data[lab_recipe_data[self.roomListData[var_44_1.index].id].target].image_id .. ".png")

		if lab_recipe_data[self.roomListData[var_44_1.index].id].target == 3050011 then
			var_44_1:getChildByName("Image_makingItem"):setScale(0.4)
		else
			var_44_1:getChildByName("Image_makingItem"):setScale(1)
		end
	else
		if var_44_1:getChildByName("Image_makingItem").shake then
			var_44_1:getChildByName("Image_makingItem").shake = false

			l2utils:removeNodeShake(var_44_1:getChildByName("Image_makingItem"):getVirtualRenderer())
		end

		if var_44_1:getChildByName("Image_makingItem").flowlight then
			var_44_1:getChildByName("Image_makingItem").flowlight = false

			l2utils:removeNodeFlowlight(var_44_1:getChildByName("Image_makingItem"):getVirtualRenderer())
		end
	end

	function var_44_1:update()
		if not self:isVisible() then
			return
		end

		local function var_48_0(arg_49_0)
			self:getChildByName("Image_icon"):loadTexture(var_0_12[arg_49_0], var_0_11)
			self:getChildByName("Image_icon"):runAction(cc.Sequence:create(cc.Show:create(), cc.FadeIn:create(0.2)))
		end

		self:getChildByName("Image_icon"):runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.Hide:create(), cc.CallFunc:create(function()
			self:setScale(1)
			var_48_0(self.roomListData[self.index].status)
		end)))
	end

	var_44_1:update()
	var_44_1:addTouchEventListener(self:getScreenHandel())
end

function LabLayerNew.updateGuidesOnLayer(arg_51_0)
	LayerManager:updateGuidesOnSwitchLayer()
end

function LabLayerNew:showUnlockRoomPop()
	for iter_52_0, iter_52_1 in pairs(self.roomListData) do
		if iter_52_1.status == RECIPE_LOCK then
			LayerManager:pushInLayer("PopRoomQuickFinishLayer", {
				sureCallback = function(arg_53_0, arg_53_1, arg_53_2)
					lab_manager:add_recipe_unlock_speed(arg_53_0, arg_53_1, function(arg_54_0)
						for iter_54_0, iter_54_1 in pairs(arg_54_0.recipe_single) do
							self.roomListData[arg_54_0.recipe_single.slot][iter_54_0] = iter_54_1
						end

						self:updateRoom()

						if arg_53_2 then
							arg_53_2(arg_54_0.result)
						end

						if arg_54_0.recipe_single.status == 0 then
							audio_manager:playeffectMusic(DORM_UNLOCK_ROOM)
							self:doorOpenAction()
						end
					end)
				end,
				surplus = math.floor(self.roomListData[iter_52_1.slot].startTime + lab_workshop_data[iter_52_1.slot].cost_time - self.roomListData[iter_52_1.slot].addTime - self.curTime),
				goto_back_system_id = self.goto_back_system_id
			})

			return
		end

		if iter_52_1.status == RECIPE_UNLOCK then
			lab_manager:unlock_cur_recipe_slot(function(arg_55_0)
				for iter_55_0, iter_55_1 in pairs(arg_55_0.recipe_single) do
					self.roomListData[arg_55_0.recipe_single.slot][iter_55_0] = iter_55_1
				end

				self:doorOpenAction()
				self:updateRoom()
				audio_manager:playeffectMusic(DORM_UNLOCK_ROOM)
			end)

			return
		end
	end

	for iter_52_2, iter_52_3 in pairs(self.roomListData) do
		if iter_52_3.locked then
			slotid = iter_52_3.slot

			break
		end
	end

	LayerManager:pushInLayer("PopUnlockLabSlotLayer", {
		datePath = "data.lab_workshop_data",
		title = "public/title/unlock_factory.png",
		sureCallback = function(arg_56_0)
			self:unlockRoom(arg_56_0)
		end,
		slotid = slotid,
		goto_back_system_id = self.goto_back_system_id
	})
end

function LabLayerNew.unlockRoom(arg_57_0, arg_57_1)
	lab_manager:unlock_new_recipe_slot(function(arg_58_0)
		if arg_58_0.result == 1 then
			for iter_58_0, iter_58_1 in pairs(arg_58_0.recipe_single) do
				arg_57_0.roomListData[arg_58_0.recipe_single.slot][iter_58_0] = iter_58_1
			end

			arg_57_0.roomListData[arg_58_0.recipe_single.slot].locked = false

			arg_57_0:updateRoom(arg_58_0.recipe_single.slot - (arg_57_0.curFloorIndex - 1) * 4)
		end

		if arg_57_1 then
			arg_57_1(arg_58_0.result)
		end
	end)
end

function LabLayerNew.getScreenHandel(arg_59_0)
	return function(arg_60_0, arg_60_1)
		if arg_60_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_60_0:isBright() then
			return
		end

		if arg_59_0.roomListData[arg_60_0.index].cacheItemCount > 0 then
			arg_60_0:setBright(false)
			lab_manager:collect_recipe_slot(arg_59_0.roomListData[arg_60_0.index].slot, function(arg_61_0)
				if arg_61_0.result == 1 then
					arg_59_0:collectUpdate(arg_61_0)
				end

				arg_60_0:setBright(true)
			end)
		else
			LayerManager:pushInLayer("LabLineLayer", {
				slotInfo = arg_59_0.roomListData[arg_60_0.index],
				exitcallback = function()
					arg_59_0:updateRoom()
				end
			})
		end
	end
end

function LabLayerNew:collectUpdate(arg_63_1)
	for iter_63_0, iter_63_1 in pairs(self.roomListData) do
		if iter_63_1.slot == arg_63_1.recipe_single.slot then
			for iter_63_2, iter_63_3 in pairs(arg_63_1.recipe_single) do
				self.roomListData[iter_63_0][iter_63_2] = iter_63_3
			end
		end
	end

	self:updateRoom()
	self:updateWheelTiles()
end

function LabLayerNew:updateWheelTiles()
	for iter_64_0, iter_64_1 in pairs(self.wheelTiles) do
		iter_64_1:getChildByName("Image_redDot"):setVisible(false)
	end

	self.arrowUp:getChildByName("Image_redDot"):setVisible(false)
	self.arrowDown:getChildByName("Image_redDot"):setVisible(false)

	for iter_64_2 = 1, #self.wheelTiles do
		for iter_64_3 = 1, 4 do
			if self.roomListData[(iter_64_2 - 1) * 4 + iter_64_3] and self.roomListData[(iter_64_2 - 1) * 4 + iter_64_3].cacheItemCount and self.roomListData[(iter_64_2 - 1) * 4 + iter_64_3].cacheItemCount > 0 then
				for iter_64_4, iter_64_5 in pairs(self.wheelTiles) do
					if iter_64_5.id == iter_64_2 then
						iter_64_5:getChildByName("Image_redDot"):setVisible(true)
					end
				end

				if self.curFloorIndex >= iter_64_2 + 2 then
					self.arrowUp:getChildByName("Image_redDot"):setVisible(true)
				end

				if self.curFloorIndex <= iter_64_2 - 2 then
					self.arrowDown:getChildByName("Image_redDot"):setVisible(true)
				end
			end
		end
	end
end

function LabLayerNew:registeTouchEvent()
	local var_65_0 = ccui.Layout:create()

	var_65_0:setContentSize(cc.size(640, GameDisplay.height))
	var_65_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_65_0:setTouchEnabled(false)
	self:addChild(var_65_0, 999)

	listener = cc.EventListenerTouchOneByOne:create()

	listener:setSwallowTouches(false)
	listener:registerScriptHandler(function(arg_66_0, arg_66_1)
		if LayerManager:getCurrentLayerName() ~= "LabMenuLayer" then
			return false
		end

		if self.wheelPanel.action_state == "running" then
			return false
		end

		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	listener:registerScriptHandler(function(arg_67_0, arg_67_1)
		local var_67_0 = var_65_0:convertToNodeSpace(arg_67_0:getStartLocation())
		local var_67_1 = var_65_0:convertToNodeSpace(arg_67_0:getLocation())

		if var_67_1.y - var_67_0.y > 200 then
			self:switchGroup("up")
		elseif var_67_1.y - var_67_0.y < -200 then
			self:switchGroup("down")
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, var_65_0)
end

function LabLayerNew.startScheduler(arg_68_0)
	local function var_68_0()
		arg_68_0.scheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_70_0)
			if not var_0_10 and arg_68_0.scheduler then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(arg_68_0.scheduler)

				arg_68_0.scheduler = nil

				return
			end

			if not arg_68_0.roomListData then
				return
			end

			arg_68_0.curTime = arg_68_0.curTime + arg_70_0

			for iter_70_0, iter_70_1 in ipairs(arg_68_0.roomListData) do
				if iter_70_1.status == RECIPE_WORKING then
					if iter_70_1.startTime + lab_recipe_data[iter_70_1.id].recipe_time * iter_70_1.allNum <= arg_68_0.curTime + iter_70_1.addTime then
						iter_70_1.status = RECIPE_COMPLETE
						iter_70_1.completeNum = iter_70_1.allNum
						iter_70_1.time = nil
						iter_70_1.cacheItemCount = iter_70_1.cacheItemCount + 1

						arg_68_0:updateWheelTiles()
						arg_68_0:updateRoom()
					else
						local var_70_0 = math.floor((arg_68_0.curTime - iter_70_1.startTime + iter_70_1.addTime) / lab_recipe_data[iter_70_1.id].recipe_time)

						if var_70_0 > iter_70_1.completeNum then
							iter_70_1.cacheItemCount = iter_70_1.cacheItemCount + var_70_0 - iter_70_1.completeNum
							iter_70_1.completeNum = var_70_0

							arg_68_0:updateWheelTiles()
							arg_68_0:updateRoom()
						end
					end
				end

				if iter_70_1.status == RECIPE_LOCK and math.floor(iter_70_1.startTime + lab_workshop_data[iter_70_1.slot].cost_time - iter_70_1.addTime - arg_68_0.curTime) <= 0 then
					iter_70_1.status = RECIPE_UNLOCK
					iter_70_1.time = nil

					arg_68_0:doorOpenAction()
					arg_68_0:updateRoom()
				end
			end
		end, 1, false)
	end

	playermodel:getServerTime(function()
		arg_68_0.curTime = playermodel.onlineTime

		var_68_0()
	end)
end
