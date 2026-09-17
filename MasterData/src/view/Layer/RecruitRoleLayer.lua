RecruitRoleLayer = class("RecruitRoleLayer", function()
	return cc.Layer:create()
end)

local playermodel = require("model.playermodel")
local activity_manager = require("controller.activity_manager")
local servant_data = require("data.servant_data")
local photofile_data = require("data.photofile_data")
local favorfile_data = require("data.favorfile_data")
local activity_recruit_servant_data = require("data.activity_recruit_servant_data")
local model_data = require("data.model_data")
local Utility = require("common.Utility")
local EventManager = require("common.EventManager")
local level_manager = require("controller.level_manager")
local var_0_10 = config._DEBUG and 0 or 1
local var_0_11 = 640
local var_0_13 = 640
local var_0_14 = 262
local var_0_15 = {
	"RecruitRoleLayer/btn_lock.png",
	"RecruitRoleLayer/btn_go_recruit.png",
	"RecruitRoleLayer/btn_can_recruit.png",
	"RecruitRoleLayer/btn_have_gotted.png"
}
local var_0_16 = {
	CAN_RECRUIT = 3,
	LOCK = 1,
	GO_RECRUIT = 2,
	HAVE_GOTTED = 4
}

function RecruitRoleLayer.create(arg_2_0, ...)
	local var_2_0 = RecruitRoleLayer.new(...)

	var_2_0:init(...)

	return var_2_0
end

function RecruitRoleLayer:init(...)
	self:initInfo(...)
	self:onLoad()
	self:fullscreen()
end

function RecruitRoleLayer:fullscreen()
	self.rootNode:setPosition(cc.p(0, -GameDisplay.fix_y))

	for iter_4_0, iter_4_1 in pairs({
		"btn_back"
	}) do
		local var_4_0 = self.rootNode:getChildByName(iter_4_1)

		var_4_0:setLocalZOrder(1)

		var_4_0.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, var_4_0:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

		var_4_0:setPositionY(var_4_0.full_posY)
	end

	for iter_4_2, iter_4_3 in pairs({
		"title"
	}) do
		local var_4_1 = self.rootNode:getChildByName(iter_4_3)

		var_4_1:setLocalZOrder(1)

		var_4_1.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - var_4_1:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

		var_4_1:setPositionY(var_4_1.full_posY)
	end
end

function RecruitRoleLayer.initInfo(arg_5_0, arg_5_1)
	arg_5_0.activityId = 200
	arg_5_0.layerName = "RecruitRoleLayer"
end

function RecruitRoleLayer:onLoad()
	self.rootNode = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "RecruitRoleLayer.json" or "RecruitRoleLayer.ExportJson")

	self:addChild(self.rootNode)

	function self.onBtnBackCallback(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end

	self.btn_back = BottomBtnList:create(self.onBtnBackCallback, nil, "RecruitRoleLayer/di.png", {
		img = "public/button/bottom_return_btn_archives.png",
		pos = cc.p(56, 35)
	})

	self.btn_back:setName("btn_back")
	self.rootNode:addChild(self.btn_back, 1)

	self.panelItem = self.rootNode:getChildByName("item")

	self.panelItem:retain()
	self.panelItem:removeFromParent()

	self.titleNode = self.rootNode:getChildByName("title")

	self.titleNode:setTouchEnabled(true)
	self.titleNode:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "recruit_role"
		})
	end)
	self:registerEvents()
end

function RecruitRoleLayer:registerEvents()
	Utility:registerNodeEvent(self)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.GET_RECURIT_INFOS, handler(self, self.handleGetRecuritInfos))
end

function RecruitRoleLayer.initUI(arg_10_0)
	return
end

function RecruitRoleLayer:initTableView()
	self.tableView = cc.TableView:create(cc.size(var_0_11, GameDisplay.height - 170))

	self.tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableView:setDelegate()
	self.tableView:setPosition(cc.p(0, 77))
	self.rootNode:addChild(self.tableView)
	self.tableView:registerScriptHandler(handler(self, self.numberOfCells), cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableView:registerScriptHandler(handler(self, self.cellSizeForIndex), cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableView:registerScriptHandler(handler(self, self.updateCellAtIndex), cc.TABLECELL_SIZE_AT_INDEX)
	self.tableView:registerScriptHandler(function(arg_12_0, arg_12_1)
		self:cellTouchCallback(arg_12_0, arg_12_1)
	end, cc.TABLECELL_TOUCHED)
	self.tableView:setLocalZOrder(0)
	self.tableView:reloadData()
end

function RecruitRoleLayer:initPanel()
	if not self.tableView then
		self:initTableView()
	end

	self.recuritRoles = activity_manager:get_recurit_roles(self.activityId)

	self.tableView:reloadData()
end

function RecruitRoleLayer:numberOfCells(arg_14_1)
	return #(self.recuritRoles or {})
end

function RecruitRoleLayer.cellSizeForIndex(arg_15_0, arg_15_1, arg_15_2)
	return var_0_13, var_0_14
end

function RecruitRoleLayer:updateCellAtIndex(arg_16_1, arg_16_2)
	local var_16_0 = arg_16_1:dequeueCell()
	local var_16_1 = true

	if not var_16_0 then
		var_16_0 = cc.TableViewCell:create()
		var_16_1 = false
	end

	if var_16_1 then
		self:updateOneItem(var_16_0, arg_16_2)
	else
		self:createOneItem(var_16_0, arg_16_2)
	end

	return var_16_0
end

function RecruitRoleLayer:createOneItem(arg_17_1, arg_17_2)
	local var_17_0 = self.panelItem:clone()

	var_17_0:setTouchEnabled(false)
	var_17_0:setName("panelRole")
	var_17_0:getChildByName("photo"):setTouchEnabled(false)
	var_17_0:getChildByName("dec"):setTouchEnabled(false)
	arg_17_1:addChild(var_17_0)
	self:updateOneItem(arg_17_1, arg_17_2)
end

function RecruitRoleLayer:updateOneItem(arg_18_1, arg_18_2)
	local var_18_0 = self.recuritRoles[arg_18_2 + 1]
	local var_18_1 = activity_manager:get_recurit_data(self.activityId, self.recuritRoles[arg_18_2 + 1])
	local var_18_2 = arg_18_1:getChildByName("panelRole")

	if not var_18_1 then
		var_18_2:setVisible(false)
	else
		var_18_2:setVisible(true)
	end

	var_18_2.data = var_18_1

	local var_18_3 = var_18_2:getChildByName("btn_operate")

	var_18_3:loadTextures(var_0_15[var_18_1.state], var_0_15[var_18_1.state], var_0_15[var_18_1.state], var_0_10)
	var_18_3:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:onBtnStatus(var_18_1)
	end)
	assert(servant_data[var_18_0], string.format("curServantData is nil,the servantId is %d", var_18_0))

	local var_18_5 = model_data[tostring(var_18_0)]

	assert(var_18_5, string.format("curModelData is nil,the servantId is %d", var_18_0))

	local var_18_6 = var_18_2:getChildByName("photo")
	local var_18_7 = var_18_6:getChildByName("name")

	var_18_7:setLocalZOrder(1)
	var_18_6:getChildByName("second_name"):setLocalZOrder(1)
	var_18_6:getChildByName("bg"):loadTexture("RecruitRoleLayer/di_item" .. servant_data[var_18_0].roll_rarity .. ".png", var_0_10)

	local var_18_8 = var_18_2:getChildByName("mask")
	local var_18_9 = var_18_2:getChildByName("btn_operate")
	local var_18_10 = var_18_2:getChildByName("dec")
	local var_18_11 = var_18_2:getChildByName("process")

	var_18_7:setString(photofile_data[var_18_5.photofile_model].easy_name)
	var_18_6:getChildByName("second_name"):getChildByName("name"):setString(photofile_data[var_18_5.photofile_model].title)

	local var_18_12 = {
		5,
		8,
		9,
		10,
		11,
		2,
		14,
		13,
		20
	}

	for iter_18_0 = 1, #var_18_12 do
		var_18_10:getChildByName("string" .. iter_18_0):setString((not favorfile_data[var_18_12[iter_18_0]][var_18_5.photofile_model] or nil) and "")
	end

	if var_18_6:getChildByName("clip") then
		var_18_6:getChildByName("clip"):removeFromParent()
	end

	local var_18_14 = "RecruitRoleLayer/mask.png"
	local var_18_15 = "roleimage/role/shop_image/" .. servant_data[var_18_0].role_image .. ".png"
	local var_18_16

	if config._DEBUG then
		var_18_16 = cc.Sprite:create(var_18_14) or cc.Sprite:createWithSpriteFrameName(var_18_14)
	end

	local var_18_17 = cc.Sprite:create(var_18_15)

	var_18_17:setName("player")
	var_18_17:setScale(0.7)
	var_18_17:setPositionY(-30)

	local var_18_18 = cc.ClippingNode:create(var_18_16)
	local var_18_19 = var_18_16:getContentSize()

	var_18_18:setName("clip")
	var_18_18:setAlphaThreshold(0)
	var_18_18:addChild(var_18_17)
	var_18_18:setPosition(cc.p(var_18_19.width / 2 + 21, var_18_19.height / 2 + 50))
	var_18_6:addChild(var_18_18)

	local var_18_20 = var_18_2:getChildByName("mask")

	var_18_20:setLocalZOrder(99)
	var_18_20:setVisible(var_18_1.state == var_0_16.HAVE_GOTTED)

	local var_18_21 = ""

	if var_18_1.state == var_0_16.LOCK then
		var_18_11:setColor(cc.c3b(222, 0, 255))

		var_18_21 = L_CLEAR_CHAPTER .. level_manager:formatSystemUnlockLevel(activity_recruit_servant_data[var_18_0].mode .. "-" .. activity_recruit_servant_data[var_18_0].chapter) .. "解锁"
	elseif var_18_1.state == var_0_16.GO_RECRUIT then
		var_18_11:setColor(cc.c3b(69, 64, 240))

		var_18_21 = L_TASK_INFO .. var_18_1.complete_num .. "/" .. var_18_1.total_num
	elseif var_18_1.state == var_0_16.CAN_RECRUIT then
		var_18_11:setColor(cc.c3b(140, 38, 255))

		var_18_21 = L_TASK_ALL_COM
	elseif var_18_1.state == var_0_16.HAVE_GOTTED then
		var_18_11:setColor(cc.c3b(222, 0, 255))

		var_18_21 = L_TASK_ALL_COM
	end

	var_18_11:setFontName(FONT_NAME)
	var_18_11:setFontSize(18)
	var_18_11:setString(var_18_21)
	var_18_11:setVisible(var_18_1.state ~= var_0_16.HAVE_GOTTED)
	self:updateAlert(var_18_3, var_18_1)
end

function RecruitRoleLayer:updateAlert(arg_20_1, arg_20_2)
	local var_20_0 = false

	if arg_20_2.status == var_0_16.CAN_RECRUIT then
		var_20_0 = true
	elseif arg_20_2.status == var_0_16.GO_RECRUIT then
		for iter_20_0, iter_20_1 in pairs((activity_manager:get_recurit_tasks(self.activityId, self.servantId))) do
			if iter_20_1.status == 2 then
				var_20_0 = true

				break
			end
		end
	end

	if var_20_0 then
		global_add_alert_tag(arg_20_1)
	else
		global_remove_alert_tag(arg_20_1)
	end
end

function RecruitRoleLayer:cellTouchCallback(arg_21_1, arg_21_2)
	self:onBtnStatus(arg_21_2:getChildByName("panelRole").data)
end

function RecruitRoleLayer:onBtnStatus(arg_22_1)
	if arg_22_1.state == var_0_16.LOCK then
		global_ShowBlockWords(L_CLEAR_CHAPTER .. level_manager:formatSystemUnlockLevel(activity_recruit_servant_data[arg_22_1.servantid].mode .. "-" .. activity_recruit_servant_data[arg_22_1.servantid].chapter) .. "解锁")

		return
	elseif arg_22_1.state == var_0_16.HAVE_GOTTED then
		return
	elseif arg_22_1.state == var_0_16.GO_RECRUIT then
		LayerManager:pushInLayer("PopRecruitTasksLayer", {
			activityId = self.activityId,
			servantId = arg_22_1.servantid
		})
	elseif arg_22_1.state == var_0_16.CAN_RECRUIT then
		activity_manager:get_recurit_reward(self.activityId, arg_22_1.servantid)
	end
end

function RecruitRoleLayer:onEnter()
	activity_manager:get_recruit_info(self.activityId)
end

function RecruitRoleLayer:onExit()
	self.panelItem:release()
	activity_manager:releaseEventListenerByName(self.layerName)
end

function RecruitRoleLayer:handleGetRecuritInfos(arg_25_1)
	if not arg_25_1 then
		return
	end

	if arg_25_1.result == 1 then
		self:initPanel()
	end
end
