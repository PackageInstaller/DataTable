ActivityManageLayer = {}

local activity_conf_data = require("data.activity_conf_data")
local activity_manager = require("controller.activity_manager")
local pop_layer_infos = require("controller.layerconfig.pop_layer_infos")
local network = require("network.network")

function ActivityManageLayer:create(arg_1_1)
	if arg_1_1.jumpToLayer then
		if pop_layer_infos[arg_1_1.jumpToLayer] then
			LayerManager:pushInLayer(arg_1_1.jumpToLayer)
		else
			LayerManager:switchShowLayer(arg_1_1.jumpToLayer, arg_1_1.jumpConfig)
		end
	elseif arg_1_1.systemid then
		require("controller.goto_system_manager")

		local var_1_0 = arg_1_1.jumpbackID
		local var_1_1

		if not arg_1_1.jumpbackID then
			var_1_0 = 1200
			var_1_1 = {}
		end

		var_1_1.jump_to_system = arg_1_1.systemid
		var_1_1.config = {
			exitCallbackType = "function",
			activityID = arg_1_1.activityID,
			id = arg_1_1.id,
			activity_type = arg_1_1.activity_type
		}

		if var_1_1.config and var_1_1.config.exitCallbackType == "function" and var_1_1.config.activity_type ~= nil then
			local var_1_2, var_1_3 = self:getBackParams(arg_1_1.activity_type, arg_1_1.activityID)

			var_1_1.config.exitCallback = createExitCallback({
				jump_to_system = var_1_0
			}, {
				exitCallbackType = "function",
				activityID = arg_1_1.activityID,
				id = var_1_2,
				activity_type = var_1_3
			})
		end

		goto_complete_system(var_1_1)
	elseif arg_1_1.createLayer then
		arg_1_1:createLayer()
	else
		self.layer_type = arg_1_1.type

		self:init(arg_1_1)
	end
end

function ActivityManageLayer:init(arg_2_1)
	self:pushInLayer(arg_2_1)
end

function ActivityManageLayer:pushInLayer(arg_3_1)
	if self.layer_type == "PopLayer" then
		print("PopLayer")
		print(dump(arg_3_1))
		arg_3_1:createLayer()
	elseif self.layer_type == "SwitchLayer" then
		require("controller.goto_system_manager")

		local var_3_0 = arg_3_1.jumpbackID
		local var_3_1

		if not arg_3_1.jumpbackID then
			var_3_0 = 1200
			var_3_1 = {}
		end

		var_3_1.jump_to_system = arg_3_1.systemID
		var_3_1.config = {
			exitCallbackType = "function",
			activityID = arg_3_1.activityID,
			id = arg_3_1.id,
			activity_type = arg_3_1.activity_type
		}

		if var_3_1.config and var_3_1.config.exitCallbackType == "function" then
			local var_3_2, var_3_3 = self:getBackParams(arg_3_1.activity_type, arg_3_1.activityID)

			var_3_1.config.exitCallback = createExitCallback({
				jump_to_system = var_3_0
			}, {
				exitCallbackType = "function",
				activityID = arg_3_1.activityID,
				id = var_3_2,
				activity_type = var_3_3
			})
		end

		goto_complete_system(var_3_1)
	end

	self.curLayer = self
end

function ActivityManageLayer:switch(...)
	if self.curLayer then
		self:deletecurLayer()
	end

	local var_4_0 = layerinfo.createLayer(intconfig)

	var_4_0:setName(layerinfo.Name)

	self.curLayer = var_4_0

	self:addChild(var_4_0)
end

function ActivityManageLayer:deleteLayer()
	self:runAction(cc.RemoveSelf:create())
end

function ActivityManageLayer:deletecurLayer()
	if self.layer_type == "PopLayer" then
		if self.curLayer then
			self.curLayer:runAction(cc.RemoveSelf:create())
		end
	elseif self.layer_type == "SwitchLayer" and self.curLayer then
		self.curLayer:runAction(cc.RemoveSelf:create())
	end
end

function ActivityManageLayer.getBackParams(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0
	local var_7_1
	local var_7_2 = string.match(arg_7_1, "task_id(%d+)")

	if var_7_2 then
		var_7_1 = "proceed_id" .. var_7_2
		var_7_0 = activity_conf_data[arg_7_2].back_activity_type
	end

	return var_7_0, var_7_1
end
