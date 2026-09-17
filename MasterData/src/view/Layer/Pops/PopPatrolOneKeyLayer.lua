PopPatrolOneKeyLayer = class("PopPatrolOneKeyLayer", function()
	return PopBaseLayer:create()
end)

local Utility = require("common.Utility")
local playermodel = require("model.playermodel")
local patrol_manager = require("controller.patrol_manager")
local var_0_3 = config._DEBUG and 0 or 1
local var_0_4 = "patrol_fight/"
local var_0_5 = {
	{
		off = "img_easy_off.png",
		on = "img_easy_on.png",
		difficulty = 1
	},
	{
		off = "img_normal_off.png",
		on = "img_normal_on.png",
		difficulty = 2
	},
	{
		off = "img_hard_off.png",
		on = "img_hard_on.png",
		difficulty = 3
	},
	{
		off = "img_hell_off.png",
		on = "img_hell_on.png",
		difficulty = 4
	}
}

function PopPatrolOneKeyLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopPatrolOneKeyLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopPatrolOneKeyLayer:init(arg_3_1)
	self:initData(arg_3_1)
	self:initUI()
	self:registerEvents()
	self:show()
end

function PopPatrolOneKeyLayer.initData(arg_4_0, arg_4_1)
	if arg_4_1 then
		arg_4_0.confirmCallBack = arg_4_1.confirmCallBack or nil
	end

	local var_4_0 = {}

	for iter_4_0 in string.gmatch(RoleDefault:getInstance():getStringForKey("PatrcolOneKey", ""), "%d+") do
		var_4_0[#var_4_0 + 1] = tonumber(iter_4_0)
	end

	arg_4_0.difficulties = {}
end

function PopPatrolOneKeyLayer:initUI()
	self.rootNode = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopPatrolOneKeyLayer.json" or "PopPatrolOneKeyLayer.ExportJson")

	self.rootNode:setContentSize(GameDisplay.size)
	self:addChild(self.rootNode)
	self.rootNode:setPositionY(-GameDisplay.fix_y)

	self.rootpanel = self.rootNode:getChildByName("panelRoot")

	self.rootpanel:setContentSize(GameDisplay.size)
	self.rootpanel:setAnchorPoint(0.5, 0.5)
	self.rootpanel:setPositionX(GameDisplay.size.width / 2)
	self.rootpanel:setPositionY(GameDisplay.size.height / 2)
	self.rootpanel:setTouchEnabled(false)

	self.panelMain = self.rootpanel:getChildByName("panelMain")

	Utility:alignPanelByParent(self.panelMain, self.rootpanel)

	self.listView = self.panelMain:getChildByName("listView")
	self.panelItem = self.panelMain:getChildByName("panelItem")

	self.panelItem:retain()
	self.panelItem:removeFromParent()

	self.btnCancel = self.panelMain:getChildByName("btnCancel")
	self.btnConfirm = self.panelMain:getChildByName("btnConfirm")

	patrol_manager:getAllPatrolCitys(function(arg_6_0)
		self:updateLayout()
	end)
end

function PopPatrolOneKeyLayer:registerEvents()
	Utility:registerNodeEvent(self)
	Utility:addClickEventListener(self.rootNode, handler(self, self.hide))
	Utility:addClickEventListener(self.btnCancel, handler(self, self.onBtnCancel))
	Utility:addClickEventListener(self.btnConfirm, handler(self, self.onBtnConfirm))
end

function PopPatrolOneKeyLayer:updateLayout()
	self.listView:removeAllChildren()

	for iter_8_0, iter_8_1 in ipairs(var_0_5) do
		local var_8_0 = self.panelItem:clone()

		self:updateOneItem(var_8_0, iter_8_1.difficulty)
		self.listView:pushBackCustomItem(var_8_0)
	end
end

function PopPatrolOneKeyLayer:updateOneItem(arg_9_1, arg_9_2)
	local var_9_0 = arg_9_1:getChildByName("btnCheck")

	Utility:addClickEventListener(var_9_0, handler(self, self.onBtnCheck), arg_9_2)
	self:onBtnCheck(var_9_0, arg_9_2)
end

function PopPatrolOneKeyLayer:onBtnCheck(arg_10_1, arg_10_2)
	local var_10_0 = arg_10_1:getParent()
	local var_10_1 = var_10_0:getChildByName("imgInfo")
	local var_10_2 = var_10_0:getChildByName("btnCheck")
	local var_10_3 = var_10_2:getChildByName("imgHook")
	local var_10_4 = Utility:indexOf(self.difficulties, arg_10_2)

	if var_10_4 < 0 then
		var_10_2:loadTextures(var_0_4 .. "check_box_1.png", nil, var_0_4 .. "check_box_1.png", var_0_3)
		var_10_1:loadTexture(var_0_4 .. var_0_5[arg_10_2].on, var_0_3)

		self.difficulties[#self.difficulties + 1] = arg_10_2
	else
		var_10_1:loadTexture(var_0_4 .. var_0_5[arg_10_2].off, var_0_3)
		var_10_2:loadTextures(var_0_4 .. "check_box_2.png", nil, var_0_4 .. "check_box_2.png", var_0_3)
		Utility:removeElement(self.difficulties, arg_10_2)
	end

	var_10_3:setVisible(var_10_4 < 0)
end

function PopPatrolOneKeyLayer:onBtnConfirm(arg_11_1)
	table.sort(self.difficulties, function(arg_12_0, arg_12_1)
		return arg_12_1 < arg_12_0
	end)

	local var_11_0 = patrol_manager:queryCanPatrolModes(self.difficulties)

	if not var_11_0 or not next(var_11_0) then
		global_ShowBlockWords("没有满足条件的关卡可驻守")

		return
	end

	local var_11_1 = patrol_manager:filterPatrolArray(var_11_0)

	if not var_11_1 or not next(var_11_1) then
		global_ShowBlockWords("没有可派遣的队伍，请班长仔细检查人员配置")

		return
	end

	if self.confirmCallBack then
		self.confirmCallBack(var_11_1)
	end

	self:hide()
end

function PopPatrolOneKeyLayer:onBtnCancel(arg_13_1)
	if self.cancelCallBack then
		self.cancelCallBack()
	end

	self:hide()
end

function PopPatrolOneKeyLayer.onEnter(arg_14_0)
	return
end

function PopPatrolOneKeyLayer:onExit()
	local var_15_0 = ""

	for iter_15_0, iter_15_1 in ipairs(self.difficulties) do
		var_15_0 = var_15_0 .. iter_15_1

		if iter_15_0 ~= #self.difficulties then
			var_15_0 = var_15_0 .. ","
		end
	end

	require("controller.RoleDefault"):getInstance():setStringForKey("PatrcolOneKey", var_15_0)
end

function PopPatrolOneKeyLayer:show()
	self.showActions.extendVertical(self)
end

function PopPatrolOneKeyLayer:hide()
	self.hideActions.shrinkVertical(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end
