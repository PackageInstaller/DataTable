SchoolTrainLayer = class("SchoolTrainLayer", function()
	return cc.Layer:create()
end)

local servant_data = require("data.servant_data")
local model_data = require("data.model_data")
local skillup_cos_data = require("data.skillup_cos_data")
local total_skill_data = require("data.total_skill_data")
local drop_data = require("data.drop_data")
local core_manager = require("controller.core_manager")
local playermodel = require("model.playermodel")
local L2Actor = require("view.Sprite.L2Actor")
local train_manager = require("controller.train_manager")
local train_rooms_data = require("data.train_rooms_data")
local item_manager = require("controller.item_manager")
local alert_manager = require("controller.alert_manager")
local drop_manager = require("controller.drop_manager")
local audio_manager = require("controller.audio_manager")
local armature_manager = require("controller.armature_manager")
local level_manager = require("controller.level_manager")
local l2utils = require("controller.l2utils")
local major_factor_data = require("data.major_factor_data")
local RichTextPro = require("view.Sprite.RichTextPro")
local theater_director = require("controller.theater_director")
local role_conversation_data = require("data.role_conversation_data")
local conversation_class_data = require("data.conversation_class_data")
local var_0_22
local var_0_23 = config._DEBUG and 0 or 1
local var_0_25 = "mainScenebg/dorm_room_bg/91000011.png"
local var_0_26 = -1
local var_0_27 = 0
local var_0_28 = 1
local var_0_29 = 2
local var_0_30 = {}

var_0_30[0] = "SchoolTrainLayer/start_training.png"
var_0_30[1] = "SchoolTrainLayer/training.png"
var_0_30[2] = "SchoolTrainLayer/exp.png"

local var_0_31 = {
	ATHOME = 3,
	LOCK = 1,
	UNLOCK = 2
}

function SchoolTrainLayer.getInstance()
	return var_0_22
end

function SchoolTrainLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = SchoolTrainLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function SchoolTrainLayer:init(arg_4_1)
	var_0_22 = self
	self.initconfig = arg_4_1

	self:initUI()
	self:registeTouchEvent()
	self:initData(function()
		self:initWheel()
		self:updateRoom()
		self:updateWheelTiles()
		self:doorOpenAction()
		self:startScheduler()
	end)

	self.activity = true

	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			self.activity = false

			GlobalUpdateElectric()

			var_0_22 = nil

			if self.scheduler then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduler)

				self.scheduler = nil
			end

			local var_6_0 = 0

			for iter_6_0, iter_6_1 in pairs(self.roomListData) do
				if iter_6_1.status == var_0_29 then
					var_6_0 = var_6_0 + 1
				end
			end

			if var_6_0 == 0 then
				alert_manager:unregister_alert(ALERT_TRAIN, true)
			end
		end
	end)
	AnalyticManager.enterTrainRoom()
end

function SchoolTrainLayer:updateWheelTiles()
	for iter_7_0, iter_7_1 in pairs(self.wheelTiles) do
		iter_7_1:getChildByName("Image_redDot"):setVisible(false)
	end

	self.arrowUp:getChildByName("Image_redDot"):setVisible(false)
	self.arrowDown:getChildByName("Image_redDot"):setVisible(false)

	for iter_7_2 = 1, #self.wheelTiles do
		for iter_7_3 = 1, 4 do
			if self.roomListData[(iter_7_2 - 1) * 4 + iter_7_3] and self.roomListData[(iter_7_2 - 1) * 4 + iter_7_3].status == var_0_29 then
				for iter_7_4, iter_7_5 in pairs(self.wheelTiles) do
					if iter_7_5.id == iter_7_2 then
						iter_7_5:getChildByName("Image_redDot"):setVisible(true)
					end
				end

				if self.curFloorIndex >= iter_7_2 + 2 then
					self.arrowUp:getChildByName("Image_redDot"):setVisible(true)
				end

				if self.curFloorIndex <= iter_7_2 - 2 then
					self.arrowDown:getChildByName("Image_redDot"):setVisible(true)
				end
			end
		end
	end
end

function SchoolTrainLayer:selectRoomToMoveAway()
	self.maskPanel.usetype = "move_away"

	self.maskPanel:setVisible(true)
	self.arrowUp:setVisible(false)
	self.arrowDown:setVisible(false)
	self.wheelPanel:setVisible(false)

	for iter_8_0 = 1, 4 do
		if self.roomListObj[iter_8_0].state ~= var_0_31.ATHOME or self.roomListData[self.roomListObj[iter_8_0].index].status == var_0_29 then
			self.roomListObj[iter_8_0]:setLocalZOrder(0)
		else
			self.roomListObj[iter_8_0]:setLocalZOrder(2)
		end
	end

	local var_8_0 = ccui.ImageView:create("SchoolTrainLayer/move_away_logo.png", var_0_23)

	var_8_0:setPosition(320, 580)

	self.maskPanel.logo = var_8_0

	self.rootLayer:addChild(var_8_0, 10)

	function self.roomSelectCallBack(arg_9_0, arg_9_1)
		self.maskPanel:resetfun()

		if self.roomListObj[arg_9_0].state ~= var_0_31.ATHOME then
			return
		end

		local var_9_0 = self.roomListObj[arg_9_0]
		local var_9_1 = self.roomListObj[arg_9_0].index

		local function var_9_2()
			train_manager:remove_servant_train(var_9_0.index, function(arg_11_0)
				if arg_11_0.result == 1 then
					var_9_0:getChildByName("Panel_lockTouch1"):setTouchEnabled(false)

					local var_11_0 = require("data.train_script_class_data")[var_9_0.curSoul].class_move_out or (500 + wife) * 1000 + 2

					self:smallDoorOpen(var_9_0.index)

					self.roomListObj[arg_9_0].state = var_0_31.UNLOCK
					self.roomListObj[arg_9_0].soulid = nil

					table.remove(self.roomListData, arg_11_0.trainInfo.roomid)
					table.insert(self.roomListData, arg_11_0.trainInfo.roomid, arg_11_0.trainInfo)
					var_9_0.director:insertScript(var_11_0, function()
						self:smallDoorClose(var_9_0.index)
						self:updateRoomByRoomIndex(var_9_0.index)
						self:bntIsHideOrShow()
						var_9_0:getChildByName("Panel_lockTouch1"):setTouchEnabled(true)
					end)
				else
					var_9_0:getChildByName("Panel_lockTouch1"):setTouchEnabled(true)
				end
			end)

			self.isCanTouchScreen = true
		end

		popmsg = {
			surecallback = function()
				var_9_0:setTouchEnabled(false)

				self.isCanTouchScreen = false

				if core_manager:getServantCoreOfhundred(self.roomListData[var_9_0.index].servantid) == core_manager:getCoreMaxTotalLv() and (self.roomListData[var_9_0.index].status == var_0_29 or self.roomListData[var_9_0.index].status == var_0_28) then
					self:returnMaterial(var_9_1, {
						callback = var_9_2
					})

					return
				elseif arg_9_1 then
					train_manager:cancelTrain(var_9_0.index, function(arg_14_0)
						table.remove(self.roomListData, arg_14_0.trainInfo.roomid)
						table.insert(self.roomListData, arg_14_0.trainInfo.roomid, arg_14_0.trainInfo)
						LayerManager:pushInLayer("PopLevelUpLayer", {
							soulsid = self.roomListData[var_9_0.index].servantid,
							packageid = arg_14_0.trainInfo.packageid,
							exp = {
								oldLevel = core_manager:getServantCoreOfhundred(self.roomListData[var_9_0.index].servantid),
								oldExp = core_manager:getCoreExp(self.roomListData[var_9_0.index].servantid),
								oldMaxExp = core_manager:getCoreMaxExp(self.roomListData[var_9_0.index].servantid),
								coreid = playermodel.cores[self.roomListData[var_9_0.index].servantid].coreid
							},
							exitCallback = exitCallback,
							core = arg_14_0.core
						})
						self:updateWheelTiles()

						if var_9_2 then
							var_9_2()
						end
					end)

					return
				end

				train_manager:remove_servant_train(var_9_0.index, function(arg_15_0)
					if arg_15_0.result == 1 then
						var_9_0:getChildByName("Panel_lockTouch1"):setTouchEnabled(false)

						local var_15_0 = require("data.train_script_class_data")[var_9_0.curSoul].class_move_out or (500 + wife) * 1000 + 2

						self:smallDoorOpen(var_9_0.index)

						self.roomListObj[arg_9_0].state = var_0_31.UNLOCK
						self.roomListObj[arg_9_0].soulid = nil

						table.remove(self.roomListData, arg_15_0.trainInfo.roomid)
						table.insert(self.roomListData, arg_15_0.trainInfo.roomid, arg_15_0.trainInfo)
						var_9_0.director:insertScript(var_15_0, function()
							self:smallDoorClose(var_9_0.index)
							self:updateRoomByRoomIndex(var_9_0.index)
							self:bntIsHideOrShow()
							var_9_0:getChildByName("Panel_lockTouch1"):setTouchEnabled(true)
						end)
					else
						var_9_0:getChildByName("Panel_lockTouch1"):setTouchEnabled(true)
					end

					self.isCanTouchScreen = true
				end)
			end,
			soulid = self.roomListObj[arg_9_0].curSoul,
			roomid = self.roomListObj[arg_9_0].index
		}

		self:moveAwayPop(popmsg)
	end
end

function SchoolTrainLayer:initMoveAway()
	self.maskPanel = self.roomPanel:getChildByName("Panel_mask")

	self.maskPanel:setContentSize(cc.size(640, GameDisplay.height))
	self.maskPanel:setPositionY(-GameDisplay.fix_y)

	function self.maskPanel.resetfun(arg_18_0)
		if self.activity == true then
			self.maskPanel:setVisible(false)
			self.moveAwayBnt:setVisible(true)
			self.wheelPanel:setVisible(true)
			self.arrowUp:setVisible(true)
			self.arrowDown:setVisible(true)

			self.maskPanel.usetype = nil

			if self.activity == true and self.maskPanel.logo then
				self.maskPanel.logo:removeFromParent()
			end

			for iter_18_0 = 1, 4 do
				self.roomListObj[iter_18_0]:setLocalZOrder(2)
			end

			self.wheelPanel.action_state = nil
		end
	end

	self.maskPanel:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.maskPanel:resetfun()
	end)

	self.moveAwayBnt = self.rootLayer:getChildByName("Button_move_away")

	self.moveAwayBnt:setPositionY(self.moveAwayBnt:getPositionY() - GameDisplay.fix_y)
	self.moveAwayBnt:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.maskPanel.usetype == "move_away" then
			self.maskPanel:resetfun()
		else
			self:bntIsHideOrShow()

			if arg_20_0.ishide then
				global_ShowBlockWords(L_SCHOOL_TRAINROOM_HIDE)

				return
			else
				self.wheelPanel.action_state = "running"

				self:selectRoomToMoveAway()
			end
		end
	end)
end

function SchoolTrainLayer:initUI()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "SchoolTrainLayer.json" or "SchoolTrainLayer.ExportJson")

	self:addChild(self.rootLayer)
	self:initBottomList()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_backGround"):loadTexture("mainScenebg/train_bg.jpg")

	self.roomPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_roomPanel")

	self:initMoveAway()

	self.roomListObj = {}

	;(function()
		table.insert(self.roomListObj, ccui.Helper:seekWidgetByName(self.rootLayer, "roomCell_1"))

		for iter_22_0 = 2, 4 do
			local var_22_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "roomCell_1"):clone()

			var_22_0:setName("roomCell_" .. iter_22_0)
			self.roomPanel:addChild(var_22_0)
			table.insert(self.roomListObj, var_22_0)
		end

		local var_22_1 = (GameDisplay.height - self.bottomList:getContentSize().height) / 4 - 5

		self.roomListObj[1].full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, GameDisplay.height * ((config._DESIGN_HEIGHT - 997) / config._DESIGN_HEIGHT) + 160 * (GameDisplay.height / config._DESIGN_HEIGHT - 1), TRANSFORM_UNIT.PX)

		self.roomListObj[1]:setPositionY(self.roomListObj[1].full_posY)

		self.roomListObj[4].full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, GameDisplay.height * (179 / config._DESIGN_HEIGHT) + 160 * (GameDisplay.height / config._DESIGN_HEIGHT - 1), TRANSFORM_UNIT.PX)

		self.roomListObj[4]:setPositionY(self.roomListObj[4].full_posY)

		local var_22_2 = (self.roomListObj[1]:getPositionY() - self.roomListObj[4]:getPositionY()) / 3

		self.room_distance = var_22_2
		self.roomListObj[2].full_posY = self.roomListObj[1]:getPositionY() - var_22_2 * 1

		self.roomListObj[2]:setPositionY(self.roomListObj[2].full_posY)

		self.roomListObj[3].full_posY = self.roomListObj[1]:getPositionY() - var_22_2 * 2

		self.roomListObj[3]:setPositionY(self.roomListObj[3].full_posY)

		for iter_22_1 = 1, 4 do
			ccui.Helper:seekWidgetByName(self.rootLayer, "roomCell_" .. iter_22_1):getChildByName("Label_BAY"):setVisible(false)
		end
	end)()
	self:initCloneRoom()
end

function SchoolTrainLayer:registeTouchEvent()
	local var_23_0 = ccui.Layout:create()

	var_23_0:setContentSize(cc.size(640, 1136))
	var_23_0:setTouchEnabled(false)
	self:addChild(var_23_0, 999)

	listener = cc.EventListenerTouchOneByOne:create()

	listener:setSwallowTouches(false)
	listener:registerScriptHandler(function(arg_24_0, arg_24_1)
		if LayerManager:getCurrentLayerName() ~= "SchoolTrainLayer" then
			return false
		end

		if self.wheelPanel.action_state == "running" then
			return false
		end

		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	listener:registerScriptHandler(function(arg_25_0, arg_25_1)
		local var_25_0 = var_23_0:convertToNodeSpace(arg_25_0:getStartLocation())
		local var_25_1 = var_23_0:convertToNodeSpace(arg_25_0:getLocation())

		if var_25_1.y - var_25_0.y > 200 then
			self:switchGroup("up")
		elseif var_25_1.y - var_25_0.y < -200 then
			self:switchGroup("down")
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, var_23_0)
end

function SchoolTrainLayer.initData(arg_26_0, arg_26_1)
	local var_26_0 = 0

	for iter_26_0, iter_26_1 in pairs(train_rooms_data) do
		var_26_0 = var_26_0 + 1
	end

	arg_26_0.curFloorIndex = 1
	arg_26_0.maxLabRoomNum = var_26_0
	arg_26_0.roomListData = {}

	train_manager:getTrainInfos(function(arg_27_0)
		if arg_26_0.activity == true then
			if not var_0_22 and arg_26_0.scheduler then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(arg_26_0.scheduler)

				arg_26_0.scheduler = nil

				return
			end

			if not arg_26_0.roomListData then
				return
			end

			for iter_27_0, iter_27_1 in pairs(arg_27_0.trainInfos) do
				table.insert(arg_26_0.roomListData, global_deepCopy(iter_27_1))
			end

			if arg_26_1 then
				arg_26_1()
			end
		end
	end)
end

function SchoolTrainLayer:switchGroup(arg_28_1)
	if self.wheelPanel.action_state == "running" then
		return
	end

	self:bntIsHideOrShow()

	self.wheelPanel.action_state = "running"

	if arg_28_1 == "up" then
		if self.curFloorIndex == self.maxLabRoomNum / 4 then
			self.wheelPanel.action_state = nil

			return
		end

		self.curFloorIndex = self.curFloorIndex + 1
	elseif arg_28_1 == "down" then
		if self.curFloorIndex == 1 then
			self.wheelPanel.action_state = nil

			return
		end

		self.curFloorIndex = self.curFloorIndex - 1
	end

	self:runAction(cc.Sequence:create(cc.CallFunc:create(function()
		self:doorCloseAction()
		self:roomScrollAction(arg_28_1)
		self.wheelPanel.changeAction(arg_28_1)
	end), cc.DelayTime:create(1.1), cc.CallFunc:create(function()
		self:updateRoom()
		self:doorOpenAction()

		self.wheelPanel.action_state = nil

		self:bntIsHideOrShow()
	end)))
end

function SchoolTrainLayer:initWheel()
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

	local var_31_0 = {
		181,
		134,
		79,
		24,
		-23
	}
	local var_31_1 = {
		0.5,
		0.7,
		1,
		0.7,
		0.5
	}

	self.wheelTiles = {}

	for iter_31_0 = 1, 4 do
		local var_31_2 = self.wheelTile:clone()

		self.wheelPanel:addChild(var_31_2)
		var_31_2:setVisible(false)

		self.wheelTiles[iter_31_0] = var_31_2
	end

	if self.curFloorIndex == 1 then
		self.arrowUp:setOpacity(100)
	elseif self.curFloorIndex == self.maxLabRoomNum / 4 then
		self.arrowDown:setOpacity(100)
	end

	local function var_31_3(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
		arg_32_0:setPositionY(var_31_0[arg_32_1])
		arg_32_0:setScale(var_31_1[arg_32_1])
		arg_32_0:setVisible(true)
		arg_32_0:getChildByName("Image_num"):loadTexture(arg_32_2, var_0_23)
	end

	local function var_31_4()
		for iter_33_0, iter_33_1 in pairs(self.wheelTiles) do
			iter_33_1:setVisible(false)
		end

		if self.curFloorIndex == 1 then
			var_31_3(self.wheelTiles[1], 3, "room_widget/num_1.png")
			var_31_3(self.wheelTiles[2], 4, "room_widget/num_2.png")
			var_31_3(self.wheelTiles[3], 5, "room_widget/num_3.png")
		elseif self.curFloorIndex == self.maxLabRoomNum / 4 then
			var_31_3(self.wheelTiles[1], 1, "room_widget/num_" .. self.maxLabRoomNum / 4 - 2 .. ".png")
			var_31_3(self.wheelTiles[2], 2, "room_widget/num_" .. self.maxLabRoomNum / 4 - 1 .. ".png")
			var_31_3(self.wheelTiles[3], 3, "room_widget/num_" .. self.maxLabRoomNum / 4 .. ".png")
		else
			var_31_3(self.wheelTiles[1], 2, "room_widget/num_" .. self.curFloorIndex - 1 .. ".png")
			var_31_3(self.wheelTiles[2], 3, "room_widget/num_" .. self.curFloorIndex .. ".png")
			var_31_3(self.wheelTiles[3], 4, "room_widget/num_" .. self.curFloorIndex + 1 .. ".png")
		end
	end

	local function var_31_5()
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

	var_31_4()
	var_31_5()
	self:updateWheelTiles()

	function self.wheelPanel.changeAction(arg_35_0)
		if self.curFloorIndex == 1 then
			self.arrowUp:setOpacity(100)
		elseif self.curFloorIndex == self.maxLabRoomNum / 4 then
			self.arrowDown:setOpacity(100)
		else
			self.arrowUp:setOpacity(255)
			self.arrowDown:setOpacity(255)
		end

		local function var_35_0(arg_36_0, arg_36_1)
			arg_36_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.Spawn:create(cc.MoveTo:create(0.8, cc.p(arg_36_0:getPositionX(), var_31_0[arg_36_1])), cc.ScaleTo:create(0.8, var_31_1[arg_36_1])), cc.CallFunc:create(var_31_4)))
		end

		if arg_35_0 == "up" then
			if self.curFloorIndex ~= self.maxLabRoomNum / 4 then
				var_31_3(self.wheelTiles[4], 5, "room_widget/num_" .. self.curFloorIndex + 1 .. ".png", self.curFloorIndex + 1)
			end

			if self.curFloorIndex == 2 then
				var_35_0(self.wheelTiles[4], 5)
				var_35_0(self.wheelTiles[3], 4)
				var_35_0(self.wheelTiles[2], 3)
				var_35_0(self.wheelTiles[1], 2)
			else
				var_35_0(self.wheelTiles[4], 4)
				var_35_0(self.wheelTiles[3], 3)
				var_35_0(self.wheelTiles[2], 2)
				var_35_0(self.wheelTiles[1], 1)
			end
		elseif arg_35_0 == "down" then
			if self.curFloorIndex ~= 1 then
				var_31_3(self.wheelTiles[4], 1, "room_widget/num_" .. self.curFloorIndex - 1 .. ".png", self.curFloorIndex - 1)
			end

			if self.curFloorIndex == self.maxLabRoomNum / 4 - 1 then
				var_35_0(self.wheelTiles[4], 1)
				var_35_0(self.wheelTiles[3], 4)
				var_35_0(self.wheelTiles[2], 3)
				var_35_0(self.wheelTiles[1], 2)
			else
				var_35_0(self.wheelTiles[4], 2)
				var_35_0(self.wheelTiles[3], 5)
				var_35_0(self.wheelTiles[2], 4)
				var_35_0(self.wheelTiles[1], 3)
			end
		end

		self.wheelPanel:runAction(cc.Sequence:create(cc.DelayTime:create(1.1), cc.CallFunc:create(function()
			var_31_5()
			self:updateWheelTiles()
		end)))
	end

	self.arrowUp:addTouchEventListener(function(arg_38_0, arg_38_1)
		if arg_38_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_38_0:getOpacity() ~= 255 then
			return
		end

		self:switchGroup("down")
	end)
	self.arrowDown:addTouchEventListener(function(arg_39_0, arg_39_1)
		if arg_39_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_39_0:getOpacity() ~= 255 then
			return
		end

		self:switchGroup("up")
	end)
	self.arrowUp:addTouchEventListener(function(arg_40_0, arg_40_1)
		if arg_40_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_40_0:getOpacity() ~= 255 then
			return
		end

		self:switchGroup("down")
	end)
	self.arrowDown:addTouchEventListener(function(arg_41_0, arg_41_1)
		if arg_41_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_41_0:getOpacity() ~= 255 then
			return
		end

		self:switchGroup("up")
	end)
end

function SchoolTrainLayer:updateRoom(arg_42_1)
	if arg_42_1 then
		self:updateRoomByRoomIndex(arg_42_1)
	else
		for iter_42_0 = (self.curFloorIndex - 1) * 4 + 1, self.curFloorIndex * 4 do
			self:updateRoomByRoomIndex(iter_42_0)
		end
	end
end

function SchoolTrainLayer.popGoBuyTrainRoom(arg_43_0, arg_43_1)
	LayerManager:pushInLayer("PopUnlockTrainRoomLayer", {
		goto_back_system_id = 1302,
		roomid = arg_43_1,
		sureCallback = function(arg_44_0)
			train_manager:unlockTrainStation(function(arg_45_0)
				if arg_43_0.activity == true then
					if arg_45_0.result == 1 then
						global_ShowBlockWords(L_SCHOOL_TRAINROOM_UNLOCK_SLOT.Success)
						table.insert(arg_43_0.roomListData, arg_45_0.trainInfo)
						arg_43_0:updateRoomByRoomIndex(#arg_43_0.roomListData)
						audio_manager:playeffectMusic(DORM_UNLOCK_ROOM)
					end

					if arg_44_0 then
						arg_44_0(arg_45_0.result)
					end
				end
			end)
		end
	})
end

function SchoolTrainLayer.startScheduler(arg_46_0)
	local function var_46_0()
		arg_46_0.scheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_48_0)
			if not var_0_22 and arg_46_0.scheduler then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(arg_46_0.scheduler)

				arg_46_0.scheduler = nil

				return
			end

			if not arg_46_0.roomListData then
				return
			end

			arg_46_0.curTime = arg_46_0.curTime + arg_48_0

			for iter_48_0, iter_48_1 in ipairs(arg_46_0.roomListData) do
				if iter_48_1.status == var_0_28 then
					local var_48_0 = arg_46_0.roomListObj[(iter_48_0 % 4 ~= 0 or nil) and (iter_48_0 % 4 or 4)]

					iter_48_1.time = iter_48_1.time - 1
					arg_46_0.time = iter_48_1.time

					if iter_48_1.time == 0 then
						iter_48_1.status = var_0_29
						iter_48_1.time = 0

						ccui.Helper:seekWidgetByName(var_48_0, "Label_surplus_time"):setVisible(false)
						ccui.Helper:seekWidgetByName(var_48_0, "Label_train_time"):setVisible(false)
						arg_46_0:updateWheelTiles()
						arg_46_0:updateRoom()
					end
				elseif iter_48_1.status == var_0_26 then
					iter_48_1.time = iter_48_1.time - 1
					arg_46_0.time = iter_48_1.time

					if iter_48_0 % 4 ~= 0 then
						if iter_48_1.time <= 0 then
							iter_48_1.time = 0

							arg_46_0:updateRoom(iter_48_0 % 4 or 4)
						end
					end
				end
			end
		end, 1, false)
	end

	playermodel:getServerTime(function()
		arg_46_0.curTime = playermodel.onlineTime

		var_46_0()
	end)
end

function SchoolTrainLayer.returnMaterial(arg_50_0, arg_50_1, arg_50_2)
	train_manager:return_train_material(arg_50_1, function(arg_51_0)
		if arg_50_0.activity == true then
			if arg_51_0.result == 1 then
				global_ShowBlockWords(L_SCHOOL_TRAINROOM_RETURN_MATERIAL.Success)
				table.remove(arg_50_0.roomListData, arg_51_0.trainInfo.roomid)
				table.insert(arg_50_0.roomListData, arg_51_0.trainInfo.roomid, arg_51_0.trainInfo)
				arg_50_0:updateRoomByRoomIndex(arg_51_0.trainInfo.roomid)
				arg_50_0:updateWheelTiles()
			else
				global_ShowBlockWords(L_SCHOOL_TRAINROOM_RETURN_MATERIAL.Failure)
			end

			if arg_50_2 and arg_50_2.callback then
				arg_50_2.callback()
			end
		end
	end)
end

function SchoolTrainLayer.quickFinishedPopLayer(arg_52_0, arg_52_1, arg_52_2)
	LayerManager:pushInLayer("PopLabQuickFinish", {
		quality = 7,
		currency = "diamond",
		goto_back_system_id = 1302,
		sureCallback = function(arg_53_0, arg_53_1, arg_53_2)
			train_manager:quick_finish_train_unlock(arg_53_0, arg_53_1, function(arg_54_0)
				if arg_52_0.activity == true then
					if arg_54_0.result == 1 then
						table.remove(arg_52_0.roomListData)
						table.insert(arg_52_0.roomListData, arg_54_0.trainInfo)
						arg_52_0:updateRoomByRoomIndex(arg_54_0.trainInfo.roomid)

						if arg_54_0.trainInfo.roomid % 4 ~= 0 then
							if (arg_54_0.trainInfo.roomid % 4 or 4) ~= 4 then
								arg_52_0:updateRoomByRoomIndex(arg_54_0.trainInfo.roomid + 1)
							end
						end

						arg_52_0:doorOpenAction(arg_54_0.trainInfo.roomid)
						global_ShowBlockWords(L_SCHOOL_TRAINROOM_QUICK_FINISH.Success)

						if arg_53_2 then
							arg_53_2(arg_54_0.result)
						end
					else
						global_ShowBlockWords(L_SCHOOL_TRAINROOM_QUICK_FINISH.Failure)
						LayerManager:removePopLayer(arg_52_0.__queueindex)
					end
				end
			end)
		end,
		sumTime = arg_52_2
	})
end

function SchoolTrainLayer:smallDoorOpen(arg_55_1)
	local var_55_0 = self.roomListObj[(arg_55_1 % 4 ~= 0 or nil) and (arg_55_1 % 4 or 4)]

	self.roomListObj[(arg_55_1 % 4 ~= 0 or nil) and (arg_55_1 % 4 or 4)]:getChildByName("Panel_small_door"):stopAllActions()
	ccui.Helper:seekWidgetByName(var_55_0, "Image_door"):stopAllActions()
	ccui.Helper:seekWidgetByName(var_55_0, "Image_door"):runAction(cc.ScaleTo:create(0.2, 0, 1))
end

function SchoolTrainLayer:smallDoorClose(arg_56_1)
	local var_56_0 = self.roomListObj[(arg_56_1 % 4 ~= 0 or nil) and (arg_56_1 % 4 or 4)]

	self.roomListObj[(arg_56_1 % 4 ~= 0 or nil) and (arg_56_1 % 4 or 4)]:getChildByName("Panel_small_door"):stopAllActions()
	ccui.Helper:seekWidgetByName(var_56_0, "Image_door"):stopAllActions()
	ccui.Helper:seekWidgetByName(var_56_0, "Image_door"):runAction(cc.ScaleTo:create(0.2, 1, 1))
end

function SchoolTrainLayer.selectGirl(arg_57_0, arg_57_1)
	LayerManager:pushInLayer("GirlSelectLayer", {
		selectType = 7,
		sureCallBack = function(arg_58_0)
			if not var_0_22 then
				return
			end

			arg_57_0.isCanTouchScreen = false
			arg_57_0.wheelPanel.action_state = "running"

			train_manager:selectServantTrain(arg_57_1, arg_58_0, function(arg_59_0)
				if arg_57_0.activity == true then
					if arg_59_0.result == 1 then
						local var_59_0

						if arg_57_1 % 4 ~= 0 then
							var_59_0 = arg_57_1 % 4 or 4
						end

						local var_59_1 = arg_57_0.roomListObj[var_59_0]

						arg_57_0:smallDoorOpen(arg_57_1)

						var_59_1.state = var_0_31.ATHOME
						arg_57_0.roomListObj[var_59_0].soulid = arg_58_0

						local var_59_2 = require("data.train_script_class_data")[arg_58_0].class_move_in or (500 + arg_58_0) * 1000 + 2

						table.remove(arg_57_0.roomListData, arg_59_0.trainInfo.roomid)
						table.insert(arg_57_0.roomListData, arg_59_0.trainInfo.roomid, arg_59_0.trainInfo)
						var_59_1:getChildByName("Panel_small_door"):runAction(cc.Sequence:create(cc.DelayTime:create(4), cc.CallFunc:create(function()
							arg_57_0:smallDoorClose(arg_57_1)
						end)))
						arg_57_0:updateRoomByRoomIndex(arg_57_1, {
							initScriptClass = var_59_2
						})
						arg_57_0:bntIsHideOrShow()
					end
				end

				arg_57_0.wheelPanel.action_state = nil
			end)
		end
	})
end

function SchoolTrainLayer:updateLockStatus(arg_61_1, arg_61_2, arg_61_3, arg_61_4)
	self.timeTable = self.timeTable or {}

	if arg_61_2 == var_0_26 then
		arg_61_1.state = var_0_31.LOCK
		arg_61_1.curSoul = nil

		if arg_61_1.director then
			arg_61_1.director:deleteSelf()

			arg_61_1.director = nil
		end

		local var_61_0 = ccui.Helper:seekWidgetByName(arg_61_1, "Image_logo")

		var_61_0:removeAllChildren()
		ccui.Helper:seekWidgetByName(arg_61_1, "Panel_unlock"):setVisible(true)
		ccui.Helper:seekWidgetByName(arg_61_1, "Panel_unlock"):addTouchEventListener(function(arg_63_0, arg_63_1)
			if arg_63_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.roomListData[arg_61_3].time > 0 then
				self:quickFinishedPopLayer(arg_61_3, self.roomListData[arg_61_3].time)
			else
				self.roomListData[arg_61_3].status = var_0_27

				ccui.Helper:seekWidgetByName(arg_61_1, "Panel_unlock"):setVisible(false)
				self:updateRoomByRoomIndex(arg_61_3)
				self:doorOpenAction(arg_61_3)
			end
		end)

		local var_61_1 = ccui.ImageView:create("SchoolTrainLayer/img_clock.png", var_0_23)

		if self.roomListData[arg_61_3].time > 0 then
			var_61_0:loadTexture("room_widget/building.png", var_0_23)
		else
			var_61_0:loadTexture("room_widget/finish.png", var_0_23)
			var_61_1:setVisible(false)
		end

		var_61_1:setColor(cc.c3b(0, 0, 0))
		var_61_1:setName("imageClock")
		var_61_0:addChild(var_61_1, 999)

		labelTime = cc.Label:createWithTTF("", FONT_NAME, 24)

		labelTime:setName("labelTime")
		labelTime:setColor(cc.c3b(99, 99, 112))
		labelTime:setAnchorPoint(cc.p(0, 0.5))
		var_61_1:addChild(labelTime, 999)

		local var_61_2 = self.roomListData[arg_61_3].time

		var_61_1:setPosition(cc.p(var_61_0:getContentSize().width / 2 - 75, var_61_0:getContentSize().height / 2 - 18))
		labelTime:setPosition(cc.p(var_61_1:getContentSize().width + 10, var_61_1:getContentSize().height / 2))
		labelTime:setString(self:updateLockTime(self.roomListData[arg_61_3].time))
		labelTime:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
			var_61_2 = var_61_2 - 1

			labelTime:setString(self:updateLockTime(var_61_2))

			if var_61_2 == 0 then
				labelTime:stopAllActions()
			end
		end))))
	else
		if self.roomListData[arg_61_3].servantid then
			arg_61_1.state = var_0_31.ATHOME
			arg_61_1.curSoul = self.roomListData[arg_61_3].servantid

			;(function()
				local var_62_0

				if arg_61_3 % 4 ~= 0 then
					var_62_0 = arg_61_3 % 4 or 4

					if self.roomListObj[var_62_0].director then
						self.roomListObj[var_62_0].director:deleteSelf()

						self.roomListObj[var_62_0].director = nil
					end
				end

				self.roomListObj[var_62_0].director = theater_director.new_train_npc(self.roomListObj[var_62_0].curSoul, self.roomListObj[var_62_0]:getChildByName("Panel_show"), (arg_61_4 and arg_61_4.initScriptClass or nil) and arg_61_4.initScriptClass)

				self.roomListObj[var_62_0].director:startPlay()
			end)()
		else
			arg_61_1.state = var_0_31.UNLOCK
			arg_61_1.curSoul = nil

			if arg_61_1.director then
				arg_61_1.director:deleteSelf()

				arg_61_1.director = nil
			end
		end

		local var_61_3 = ccui.Helper:seekWidgetByName(arg_61_1, "Image_logo")

		if var_61_3:getChildByName("imageClock") then
			var_61_3:getChildByName("imageClock"):getChildByName("labelTime"):stopAllActions()
		end

		ccui.Helper:seekWidgetByName(arg_61_1, "Panel_lockTouch1"):setTouchEnabled(true)
		ccui.Helper:seekWidgetByName(arg_61_1, "Panel_unlock"):setVisible(false)
		ccui.Helper:seekWidgetByName(arg_61_1, "Panel_lockTouch1"):addTouchEventListener(function(arg_65_0, arg_65_1)
			if arg_65_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not self.roomListData[arg_61_3].servantid then
				self:selectGirl(arg_61_3)
			elseif self.roomListData[arg_61_3].status == var_0_27 then
				local var_65_0

				if self.maskPanel.usetype == "move_away" then
					self.roomSelectCallBack((arg_61_3 % 4 ~= 0 or nil) and (arg_61_3 % 4 or 4))

					do return end

					var_65_0 = {}
				end

				function var_65_0.sureCallback(arg_66_0, arg_66_1)
					train_manager:beginTrain(arg_66_0, arg_66_1, function(arg_67_0)
						if self.activity == true and arg_67_0.result == 1 then
							global_ShowBlockWords(L_SCHOOL_TRAINROOM_START)
							table.remove(self.roomListData, arg_67_0.trainInfo.roomid)
							table.insert(self.roomListData, arg_67_0.trainInfo.roomid, arg_67_0.trainInfo)
							self:updateRoomByRoomIndex(arg_61_3)
						end
					end)
				end

				var_65_0.roomid = arg_61_3
				var_65_0.soulsid = self.roomListData[arg_61_3].servantid

				LayerManager:pushInLayer("PopTrainPackageLayer", var_65_0)
			elseif self.roomListData[arg_61_3].status == var_0_28 then
				local var_65_2
				local var_65_1

				if self.maskPanel.usetype == "move_away" then
					self.roomSelectCallBack((arg_61_3 % 4 ~= 0 or nil) and (arg_61_3 % 4 or 4), true)

					do return end

					var_65_1 = math.ceil(self.roomListData[arg_61_3].time / 60) * 100
					var_65_2 = {
						costtype = "gold"
					}
				end

				function var_65_2.surecallback()
					if core_manager:getServantCoreOfhundred(self.roomListData[arg_61_3].servantid) == core_manager:getCoreMaxTotalLv() and self.roomListData[arg_61_3].status == var_0_28 then
						self:returnMaterial(arg_61_3)
					else
						train_manager:quickFinishTrain(arg_61_3, function(arg_69_0)
							if self.activity == true then
								table.remove(self.roomListData, arg_69_0.trainInfo.roomid)
								table.insert(self.roomListData, arg_69_0.trainInfo.roomid, arg_69_0.trainInfo)
								LayerManager:pushInLayer("PopLevelUpLayer", {
									soulsid = self.roomListData[arg_61_3].servantid,
									packageid = arg_69_0.trainInfo.packageid,
									exp = {
										oldLevel = core_manager:getServantCoreOfhundred(self.roomListData[arg_61_3].servantid),
										oldExp = core_manager:getCoreExp(self.roomListData[arg_61_3].servantid),
										oldMaxExp = core_manager:getCoreMaxExp(self.roomListData[arg_61_3].servantid),
										coreid = playermodel.cores[self.roomListData[arg_61_3].servantid].coreid
									},
									exitCallback = function()
										self:updateRoomByRoomIndex(arg_69_0.trainInfo.roomid)
									end,
									core = arg_69_0.core
								})
								self:updateWheelTiles()
							end
						end)
					end
				end

				var_65_2.own = playermodel.gold
				var_65_2.cost = var_65_1
				var_65_2.labels = {
					titleNewImage = "public/title/title_accelerate_train.png",
					title = L_SCHOOL_TRAINROOM_QUICK_LABEL.title,
					des = string.format(L_SCHOOL_TRAINROOM_QUICK_LABEL.des, var_65_1),
					button = L_SCHOOL_TRAINROOM_QUICK_LABEL.button
				}

				LayerManager:pushInLayer("PopDoLayer", var_65_2)
			elseif self.roomListData[arg_61_3].status == var_0_29 then
				if self.maskPanel.usetype == "move_away" then
					self.roomSelectCallBack((arg_61_3 % 4 ~= 0 or nil) and (arg_61_3 % 4 or 4), true)

					return
				end

				if core_manager:getServantCoreOfhundred(self.roomListData[arg_61_3].servantid) == core_manager:getCoreMaxTotalLv() and self.roomListData[arg_61_3].status == var_0_29 then
					self:returnMaterial(arg_61_3)
				else
					train_manager:finishTrain(arg_61_3, function(arg_71_0)
						if self.activity == true then
							table.remove(self.roomListData, arg_71_0.trainInfo.roomid)
							table.insert(self.roomListData, arg_71_0.trainInfo.roomid, arg_71_0.trainInfo)
							LayerManager:pushInLayer("PopLevelUpLayer", {
								soulsid = self.roomListData[arg_61_3].servantid,
								packageid = arg_71_0.trainInfo.packageid,
								exp = {
									oldLevel = core_manager:getServantCoreOfhundred(self.roomListData[arg_61_3].servantid),
									oldExp = core_manager:getCoreExp(self.roomListData[arg_61_3].servantid),
									oldMaxExp = core_manager:getCoreMaxExp(self.roomListData[arg_61_3].servantid)
								},
								core = arg_71_0.core
							})
							self:updateRoomByRoomIndex(arg_71_0.trainInfo.roomid)
							self:updateWheelTiles()
						end
					end)
				end
			end
		end)

		if self.roomListData[arg_61_3].time and self.roomListData[arg_61_3].time > 0 then
			ccui.Helper:seekWidgetByName(arg_61_1, "Label_surplus_time"):setVisible(true)
			ccui.Helper:seekWidgetByName(arg_61_1, "Label_train_time"):setVisible(true)
			ccui.Helper:seekWidgetByName(arg_61_1, "Label_train_time"):setString(self:updateLockTime(self.roomListData[arg_61_3].time))
		end
	end
end

function SchoolTrainLayer.updateLockTime(arg_72_0, arg_72_1)
	local var_72_0 = math.fmod(math.floor(arg_72_1 / 60 / 60), 24)
	local var_72_1 = math.fmod(math.floor(arg_72_1 / 60), 60)
	local var_72_2 = math.fmod(arg_72_1, 60)

	if var_72_0 == 0 then
		return string.format("%02d", var_72_1) .. ":" .. string.format("%02d", var_72_2)
	else
		return string.format("%02d", var_72_0) .. ":" .. string.format("%02d", var_72_1) .. ":" .. string.format("%02d", var_72_2)
	end
end

function SchoolTrainLayer:updateRoomByRoomIndex(arg_73_1, arg_73_2)
	local var_73_0

	if arg_73_1 <= #self.roomListData then
		local var_73_1

		if arg_73_1 % 4 ~= 0 then
			var_73_1 = arg_73_1 % 4 or 4
		end

		self.roomListObj[var_73_1].index = arg_73_1
		var_73_0 = self.roomListObj[var_73_1]

		ccui.Helper:seekWidgetByName(self.roomListObj[var_73_1], "Panel_lockTouch"):setVisible(false)
		ccui.Helper:seekWidgetByName(var_73_0, "Panel_lockTouch1"):setVisible(true)
		self:updateLockStatus(var_73_0, self.roomListData[arg_73_1].status, arg_73_1, arg_73_2)
	elseif arg_73_1 == #self.roomListData + 1 then
		local var_73_2

		if arg_73_1 % 4 ~= 0 then
			var_73_2 = arg_73_1 % 4 or 4
		end

		self.roomListObj[var_73_2].index = arg_73_1
		var_73_0 = self.roomListObj[var_73_2]
		var_73_0.state = var_0_31.LOCK
		var_73_0.curSoul = nil

		if var_73_0.director then
			var_73_0.director:deleteSelf()

			var_73_0.director = nil
		end

		if self.roomListData[#self.roomListData].status == var_0_26 then
			ccui.Helper:seekWidgetByName(var_73_0, "Panel_unlock"):setVisible(false)
		else
			ccui.Helper:seekWidgetByName(var_73_0, "Panel_unlock"):setVisible(true)
			ccui.Helper:seekWidgetByName(var_73_0, "Panel_lockTouch"):addTouchEventListener(function(arg_74_0, arg_74_1)
				if arg_74_1 ~= ccui.TouchEventType.ended then
					return
				end

				self:popGoBuyTrainRoom(arg_73_1)
			end)
		end

		ccui.Helper:seekWidgetByName(var_73_0, "Panel_lockTouch1"):setVisible(false)
		ccui.Helper:seekWidgetByName(var_73_0, "Panel_lockTouch"):setVisible(true)
	elseif arg_73_1 > #self.roomListData + 1 and arg_73_1 <= 16 then
		self.roomListObj[(arg_73_1 % 4 ~= 0 or nil) and (arg_73_1 % 4 or 4)].index = arg_73_1
		var_73_0 = self.roomListObj[(arg_73_1 % 4 ~= 0 or nil) and (arg_73_1 % 4 or 4)]
		var_73_0.state = var_0_31.LOCK
		var_73_0.curSoul = nil

		if var_73_0.director then
			var_73_0.director:deleteSelf()

			var_73_0.director = nil
		end

		ccui.Helper:seekWidgetByName(var_73_0, "Panel_unlock"):setVisible(false)
		ccui.Helper:seekWidgetByName(var_73_0, "Panel_lockTouch"):setVisible(false)
		ccui.Helper:seekWidgetByName(var_73_0, "Panel_lockTouch1"):setVisible(false)
	end

	self:updateScreen(arg_73_1)

	if self.roomListData[arg_73_1] and self.roomListData[arg_73_1].servantid then
		ccui.Helper:seekWidgetByName(var_73_0, "Label_str"):setString(major_factor_data[model_data[servant_data[self.roomListData[arg_73_1].servantid].modelid].major].easy_name)
	else
		ccui.Helper:seekWidgetByName(var_73_0, "Label_str"):setString("魂器学院")
	end

	ccui.Helper:seekWidgetByName(var_73_0, "Label_order"):setString(string.format("%2d", arg_73_1))
	ccui.Helper:seekWidgetByName(var_73_0, "Image_roomBg"):loadTexture(var_0_25)
	ccui.Helper:seekWidgetByName(var_73_0, "Image_door"):loadTexture("SchoolTrainLayer/train_door.png", var_0_23)
end

function SchoolTrainLayer:updateScreen(arg_75_1)
	local var_75_0

	if arg_75_1 % 4 ~= 0 then
		var_75_0 = arg_75_1 % 4

		local var_75_1

		if not (arg_75_1 % 4) then
			var_75_0 = 4
			var_75_1 = {
				170,
				310
			}
		end
	end

	local var_75_2 = ccui.Helper:seekWidgetByName(self.roomListObj[var_75_0], "Image_screen1")

	if self.roomListData[arg_75_1] and self.roomListData[arg_75_1].status ~= var_0_26 then
		var_75_2:setVisible(true)
	else
		var_75_2:setVisible(false)

		return
	end

	var_75_2.index = arg_75_1

	var_75_2:setPositionX(var_75_1[1])

	var_75_2.time = 0
	var_75_2.state = "down"
	var_75_2:getChildByName("Button_arrow").state = "down"
	var_75_2:getChildByName("Button_arrow").colour = "blue"

	var_75_2:setLocalZOrder(-1)

	if false then
		var_75_2:getChildByName("Button_arrow").state = "up"

		local var_75_3 = "room_widget/" .. var_75_2:getChildByName("Button_arrow").colour .. "_up.png"

		var_75_2:getChildByName("Button_arrow"):loadTextures(var_75_3, var_75_3, var_75_3, var_0_23)
		var_75_2:setPositionY(278)
	else
		var_75_2:getChildByName("Button_arrow").state = "down"

		local var_75_4 = "room_widget/" .. var_75_2:getChildByName("Button_arrow").colour .. "_down.png"

		var_75_2:getChildByName("Button_arrow"):loadTextures(var_75_4, var_75_4, var_75_4, var_0_23)
		var_75_2:setPositionY(182)
	end

	var_75_2:getChildByName("Button_fast"):addTouchEventListener(function(arg_76_0, arg_76_1)
		local var_76_0
		local var_76_1

		if arg_76_1 ~= ccui.TouchEventType.ended then
			do return end

			var_76_0 = math.ceil(self.roomListData[var_75_2.index].time / 60) * 100
			var_76_1 = {
				costtype = "gold"
			}
		end

		function var_76_1.surecallback()
			if core_manager:getServantCoreOfhundred(self.roomListData[var_75_2.index].servantid) == core_manager:getCoreMaxTotalLv() then
				self:returnMaterial(var_75_2.index)
			else
				train_manager:quickFinishTrain(var_75_2.index, function(arg_78_0)
					if self.activity == true then
						table.remove(self.roomListData, arg_78_0.trainInfo.roomid)
						table.insert(self.roomListData, arg_78_0.trainInfo.roomid, arg_78_0.trainInfo)
						LayerManager:pushInLayer("PopLevelUpLayer", {
							soulsid = self.roomListData[arg_75_1].servantid,
							packageid = arg_78_0.trainInfo.packageid,
							exp = {
								oldLevel = core_manager:getServantCoreOfhundred(self.roomListData[arg_75_1].servantid),
								oldExp = core_manager:getCoreExp(self.roomListData[arg_75_1].servantid),
								oldMaxExp = core_manager:getCoreMaxExp(self.roomListData[arg_75_1].servantid),
								coreid = playermodel.cores[self.roomListData[arg_75_1].servantid].coreid
							},
							exitCallback = function()
								self:updateRoomByRoomIndex(arg_78_0.trainInfo.roomid)
							end,
							core = arg_78_0.core
						})
						self:updateWheelTiles()
					end
				end)
			end
		end

		var_76_1.own = playermodel.gold
		var_76_1.cost = var_76_0
		var_76_1.labels = {
			titleNewImage = "public/title/title_accelerate_train.png",
			title = L_SCHOOL_TRAINROOM_QUICK_LABEL.title,
			des = string.format(L_SCHOOL_TRAINROOM_QUICK_LABEL.des, var_76_0),
			button = L_SCHOOL_TRAINROOM_QUICK_LABEL.button
		}

		LayerManager:pushInLayer("PopDoLayer", var_76_1)
	end)
	var_75_2:getChildByName("Button_arrow"):addTouchEventListener(function(arg_80_0, arg_80_1)
		if arg_80_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_80_0.state == "up" then
			arg_80_0.state = "running"

			arg_80_0:loadTextures("room_widget/" .. arg_80_0.colour .. "_down.png", "room_widget/" .. arg_80_0.colour .. "_down.png", "room_widget/" .. arg_80_0.colour .. "_down.png", var_0_23)
			var_75_2:runAction(cc.Sequence:create(cc.MoveTo:create(0.2, cc.p(var_75_1[1], 182)), cc.MoveTo:create(0.05, cc.p(var_75_1[1], 178)), cc.MoveTo:create(0.05, cc.p(var_75_1[1], 186)), cc.MoveTo:create(0.05, cc.p(var_75_1[1], 182)), cc.CallFunc:create(function()
				arg_80_0.state = "down"
			end)))
		elseif arg_80_0.state == "down" then
			arg_80_0.state = "running"

			arg_80_0:loadTextures("room_widget/" .. arg_80_0.colour .. "_up.png", "room_widget/" .. arg_80_0.colour .. "_up.png", "room_widget/" .. arg_80_0.colour .. "_up.png", var_0_23)
			var_75_2:runAction(cc.Sequence:create(cc.MoveTo:create(0.1, cc.p(var_75_1[1], 175)), cc.MoveTo:create(0.3, cc.p(var_75_1[1], 303)), cc.CallFunc:create(function()
				arg_80_0.state = "up"
			end)))
		end
	end)
	var_75_2:getChildByName("Image_reddot"):setVisible(self.roomListData[var_75_2.index] and self.roomListData[var_75_2.index].status == var_0_29)
	var_75_2:getChildByName("Button_fast"):setVisible(self.roomListData[var_75_2.index] and self.roomListData[var_75_2.index].status == var_0_28)
	var_75_2:getChildByName("Label_surplus_time"):setVisible(self.roomListData[var_75_2.index] and self.roomListData[var_75_2.index].status == var_0_28)
	var_75_2:getChildByName("Label_train_time"):setVisible(self.roomListData[var_75_2.index] and self.roomListData[var_75_2.index].status == var_0_28)

	if var_75_2:getChildByName("Label_train_time"):isVisible() == true then
		var_75_2:getChildByName("Label_train_time"):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
			var_75_2:getChildByName("Label_train_time"):setString(self:updateLockTime(self.roomListData[var_75_2.index].time))
		end))))
	else
		var_75_2:getChildByName("Label_train_time"):stopAllActions()
	end

	function var_75_2:update()
		if not self:isVisible() then
			return
		end

		local function var_84_0(arg_85_0)
			if arg_85_0 then
				if arg_85_0.servantid then
					self:getChildByName("Image_icon"):loadTexture(var_0_30[arg_85_0.status], var_0_23)
				else
					self:getChildByName("Image_icon"):loadTexture("SchoolTrainLayer/join_training.png", var_0_23)
				end

				self:getChildByName("Image_icon"):runAction(cc.Sequence:create(cc.Show:create(), cc.FadeIn:create(0.2)))
			end
		end

		self:getChildByName("Image_icon"):runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.Hide:create(), cc.CallFunc:create(function()
			self:setScale(1)
			var_84_0(self.roomListData[self.index])
		end)))
	end

	var_75_2:update()
end

function SchoolTrainLayer:roomScrollAction(arg_87_1)
	local var_87_0

	if arg_87_1 == "up" then
		var_87_0 = self.room_distance * 4 or -self.room_distance * 4

		if arg_87_1 == "up" then
			for iter_87_0 = 1, 4 do
				self.cloneRooms[iter_87_0]:setPositionY(self.roomListObj[4].full_posY - iter_87_0 * self.room_distance)
			end

			goto label_87_0
		end
	end

	for iter_87_1 = 1, 4 do
		self.cloneRooms[iter_87_1]:setPositionY(self.roomListObj[1].full_posY + (5 - iter_87_1) * self.room_distance)
	end

	::label_87_0::

	for iter_87_2 = 1, 4 do
		self.roomListObj[iter_87_2]:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.MoveBy:create(0.8, cc.p(0, var_87_0))))
		self.cloneRooms[iter_87_2]:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
			self.cloneRooms[iter_87_2]:setVisible(true)
		end), cc.MoveBy:create(0.8, cc.p(0, var_87_0)), cc.CallFunc:create(function()
			self.roomListObj[iter_87_2]:setPositionY(self.roomListObj[iter_87_2].full_posY)
			self.cloneRooms[iter_87_2]:setPositionY(self.roomListObj[4].full_posY - iter_87_2 * self.room_distance)
			self.cloneRooms[iter_87_2]:setVisible(false)
		end)))
	end
end

function SchoolTrainLayer:doorCloseAction()
	for iter_90_0, iter_90_1 in ipairs(self.roomListObj) do
		ccui.Helper:seekWidgetByName(iter_90_1, "Image_doorR"):stopAllActions()
		ccui.Helper:seekWidgetByName(iter_90_1, "Image_doorL"):stopAllActions()
		ccui.Helper:seekWidgetByName(iter_90_1, "Image_doorR"):runAction(cc.Sequence:create(cc.DelayTime:create((iter_90_0 - 1) * 0.1), cc.MoveTo:create(0.3, cc.p(303, 131))))
		ccui.Helper:seekWidgetByName(iter_90_1, "Image_doorL"):runAction(cc.Sequence:create(cc.DelayTime:create((iter_90_0 - 1) * 0.1), cc.MoveTo:create(0.3, cc.p(303, 131))))
	end
end

function SchoolTrainLayer:doorOpenAction(arg_91_1)
	local function var_91_0(arg_92_0)
		if self.roomListData[arg_92_0.index] and self.roomListData[arg_92_0.index].status ~= var_0_26 then
			return true
		end

		return false
	end

	local function var_91_1(arg_93_0, arg_93_1)
		ccui.Helper:seekWidgetByName(arg_93_0, "Image_doorR"):stopAllActions()
		ccui.Helper:seekWidgetByName(arg_93_0, "Image_doorL"):stopAllActions()

		if var_91_0(arg_93_0) then
			ccui.Helper:seekWidgetByName(arg_93_0, "Image_doorR"):runAction(cc.Sequence:create(cc.DelayTime:create((arg_93_1 - 1) * 0.1), cc.MoveTo:create(0.3, cc.p(643, 131))))
			ccui.Helper:seekWidgetByName(arg_93_0, "Image_doorL"):runAction(cc.Sequence:create(cc.DelayTime:create((arg_93_1 - 1) * 0.1), cc.MoveTo:create(0.3, cc.p(-37, 131))))
		end
	end

	if arg_91_1 then
		local var_91_2

		if arg_91_1 % 4 ~= 0 then
			var_91_2 = arg_91_1 % 4 or 4
		end

		self:smallDoorClose(arg_91_1)
		var_91_1(self.roomListObj[var_91_2], 2)
	else
		for iter_91_0, iter_91_1 in ipairs(self.roomListObj) do
			self:smallDoorClose(iter_91_0)
			var_91_1(iter_91_1, iter_91_0)
		end
	end
end

function SchoolTrainLayer:initCloneRoom()
	local var_94_0 = (GameDisplay.height - self.bottomList:getContentSize().height) / 4 + 10

	self.cloneRooms = {}

	local var_94_3 = self.roomListObj[4]:getPositionY() - self.room_distance

	for iter_94_0 = 1, 4 do
		local var_94_4 = ccui.ImageView:create("room_widget/room_bg_margin.png", var_0_23)

		var_94_4:setPosition(320, var_94_3 - (iter_94_0 - 1) * self.room_distance)
		self.rootLayer:addChild(var_94_4)

		local var_94_5 = var_94_4:getContentSize().width / 2
		local var_94_6 = var_94_4:getContentSize().height / 2
		local var_94_7 = ccui.ImageView:create("room_widget/door_L.png", var_0_23)

		var_94_7:setPosition(var_94_5, var_94_6)
		var_94_4:addChild(var_94_7)

		local var_94_8 = ccui.ImageView:create("room_widget/door_R.png", var_0_23)

		var_94_8:setPosition(var_94_5, var_94_6)
		var_94_4:addChild(var_94_8)

		self.cloneRooms[iter_94_0] = var_94_4

		var_94_4:setVisible(false)
	end
end

function SchoolTrainLayer.returnEvent(arg_95_0)
	KeyCodeManager:onKeyReleasedCallFunc()
end

function SchoolTrainLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_97_0, arg_97_1)
		if arg_97_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:returnEvent()
	end, conf)

	self.bottomList:setPositionY(-GameDisplay.fix_y)
	self.bottomList:setName("bottomlist")
	self:addChild(self.bottomList, 1000)
end

function SchoolTrainLayer.moveAwayPop(arg_98_0, arg_98_1)
	local var_98_0 = ccui.Layout:create()

	var_98_0:setTouchEnabled(true)
	var_98_0:setContentSize(cc.size(640, GameDisplay.height))
	var_98_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_98_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_98_0:setBackGroundColorOpacity(160)
	var_98_0:setCascadeOpacityEnabled(false)
	global_basic_scene:addChild(var_98_0, 999)
	var_98_0:addTouchEventListener(function(arg_99_0, arg_99_1)
		if arg_99_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_98_0:runAction(cc.RemoveSelf:create())
	end)

	local var_98_1 = ccui.ImageView:create("SchoolTrainLayer/move_away_pop.png", var_0_23)

	var_98_1:setPosition(320, GameDisplay.height / 2)
	var_98_0:addChild(var_98_1)

	local var_98_2 = ccui.Button:create("public/button/public_button_orange.png", nil, "public/button/public_button_orange.png", var_0_23)

	var_98_2:setTitleText(L_BUTTON_TEXT.Comfirm)
	var_98_2:setTitleFontSize(30)
	var_98_2:setTitleColor(cc.c3b(0, 0, 0))
	var_98_2:setTitleFontName(FONT_BUTTON)
	var_98_2:setPosition(180, GameDisplay.height / 2 - 100)
	var_98_0:addChild(var_98_2)
	var_98_2:addTouchEventListener(function(arg_100_0, arg_100_1)
		if arg_100_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_98_1.surecallback then
			arg_98_1.surecallback()
		end

		var_98_0:runAction(cc.RemoveSelf:create())
	end)

	local var_98_3 = ccui.Button:create("public/button/public_button_big_blue_y.png", nil, "public/button/public_button_big_blue_y.png", var_0_23)

	var_98_3:setTitleText(L_BUTTON_TEXT.Can_cel)
	var_98_3:setTitleFontSize(30)
	var_98_3:setTitleColor(cc.c3b(0, 0, 0))
	var_98_3:setTitleFontName(FONT_BUTTON)
	var_98_3:setPosition(460, GameDisplay.height / 2 - 100)
	var_98_0:addChild(var_98_3)
	var_98_3:addTouchEventListener(function(arg_101_0, arg_101_1)
		if arg_101_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_98_0:runAction(cc.RemoveSelf:create())

		if arg_98_1.cancelcallback then
			arg_98_1.cancelcallback()
		end
	end)
	print("popmsg.soulid===", arg_98_1.soulid)

	local var_98_4 = ccui.ImageView:create("roleimage/role1/" .. (model_data[servant_data[arg_98_1.soulid].modelid].cute_Q or model_data[servant_data[arg_98_1.soulid].modelid].cute_role) .. ".png")

	var_98_4:setAnchorPoint(cc.p(0.5, 0))
	var_98_4:setScale(0.4)
	var_98_4:setPosition(560, 10)
	var_98_1:addChild(var_98_4)

	local var_98_5 = cc.Label:createWithTTF(string.format(L_SCHOOL_TRAINROOM_REMOVE, major_factor_data[model_data[servant_data[arg_98_1.soulid].modelid].major].easy_name), FONT_TITLE, 26)

	var_98_5:setPosition(var_98_1:getContentSize().width / 2, 60)
	var_98_1:addChild(var_98_5)
end

function SchoolTrainLayer:bntIsHideOrShow()
	local var_102_0 = true

	for iter_102_0, iter_102_1 in pairs(self.roomListObj) do
		if iter_102_1.state == var_0_31.ATHOME then
			var_102_0 = false

			break
		end
	end

	if var_102_0 then
		self.moveAwayBnt:setOpacity(120)

		self.moveAwayBnt.ishide = true
	else
		self.moveAwayBnt:setOpacity(255)

		self.moveAwayBnt.ishide = false
	end
end
