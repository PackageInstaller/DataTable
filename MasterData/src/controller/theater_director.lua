local var_0_0 = {}
local playermodel = require("model.playermodel")
local L2Actor = require("view.Sprite.L2Actor")
local weapon_manager = require("controller.weapon_manager")
local dormitory_manager = require("controller.dormitory_manager")
local l2utils = require("controller.l2utils")
local model_data = require("data.model_data")
local dorm_script_class_data = require("data.dorm_script_class_data")
local dorm_script_data = require("data.dorm_script_data")
local script_lab_robot_class_data = require("data.script_lab_robot_class_data")
local major_factor_data = require("data.major_factor_data")
local script_npc_data = require("data.script_npc_data")
local script_npc_class_data = require("data.script_npc_class_data")
local train_script_data = require("data.train_script_data")
local train_script_class_data = require("data.train_script_class_data")
local var_0_15 = {
	main = require("data.script_data"),
	dorm = dorm_script_data,
	labRobot = require("data.script_lab_robot_data"),
	npc = script_npc_data,
	train = train_script_data
}

local function var_0_17(arg_1_0)
	local var_1_2 = {
		jsonFilePath = ROLE_SPINE_PATH .. model_data[arg_1_0].spine_model .. ".json",
		atlasFilePath = ROLE_SPINE_PATH .. model_data[arg_1_0].spine_model .. ".atlas"
	}

	if model_data[arg_1_0].clothes_model then
		var_1_2.clothesFilePath = CLOTHES_SPINE_PATH .. model_data[arg_1_0].clothes_model .. ".atlas" or nil
	end

	var_1_2.scale = (model_data[arg_1_0].modelscale or 1) * STANDARD_SCALE
	var_1_2.size = cc.size(model_data[arg_1_0].modelweight, model_data[arg_1_0].modelheight)

	return var_1_2
end

local function var_0_19(arg_3_0)
	if config._DEBUG and not playermodel.haveSuit[arg_3_0] then
		return nil
	end

	return dormitory_manager:getSoulDressModelid(arg_3_0) or major_factor_data[arg_3_0].model
end

local function var_0_20(arg_4_0)
	local var_4_0
	local var_4_1 = math.random(arg_4_0[#arg_4_0].totalweight)

	for iter_4_0 = 1, #arg_4_0 - 1 do
		if var_4_1 <= arg_4_0[iter_4_0].weight then
			var_4_0 = arg_4_0[iter_4_0].id

			break
		end
	end

	return var_4_0
end

local function var_0_21(arg_5_0)
	local var_5_0 = {}
	local var_5_1 = 0
	local var_5_2 = var_0_19(arg_5_0)
	local var_5_3 = dorm_script_class_data[var_5_2] and var_5_2 or arg_5_0

	while dorm_script_class_data[var_5_3]["class" .. 1] do
		var_5_0[1] = {}
		var_5_0[1].id = dorm_script_class_data[var_5_3]["class" .. 1]
		var_5_1 = var_5_1 + dorm_script_class_data[var_5_3]["weight" .. 1]
		var_5_0[1].weight = var_5_1
	end

	;(function()
		local var_6_0 = dormitory_manager:getRoomIdBySoulid(arg_5_0)

		for iter_6_0 = 1, 5 do
			while dorm_script_class_data[var_5_3]["class_furniture" .. iter_6_0 .. "_" .. 1] do
				assert(dorm_script_class_data[var_5_3]["class_furniture" .. iter_6_0 .. "_" .. 1 .. "_parameter"], "soulid: " .. var_5_3 .. ", class_furniture" .. iter_6_0 .. "_" .. 1 .. "_parameter is nil")

				if playermodel.dormRoomConfig[var_6_0].furnitures[iter_6_0] == dorm_script_class_data[var_5_3]["class_furniture" .. iter_6_0 .. "_" .. 1 .. "_parameter"] then
					assert(dorm_script_class_data[var_5_3]["class_furniture" .. iter_6_0 .. "_" .. 1 .. "_weight"], "soulid: " .. var_5_3 .. ", class_furniture" .. iter_6_0 .. "_" .. 1 .. "_weight is nil")

					var_5_1 = var_5_1 + dorm_script_class_data[var_5_3]["class_furniture" .. iter_6_0 .. "_" .. 1 .. "_weight"]
					var_5_0[#var_5_0 + 1] = {
						id = dorm_script_class_data[var_5_3]["class_furniture" .. iter_6_0 .. "_" .. 1],
						weight = var_5_1
					}

					break
				end
			end
		end
	end)()

	var_5_0[#var_5_0 + 1] = {}
	var_5_0[#var_5_0].totalweight = var_5_1

	return var_5_0, var_0_20(var_5_0)
end

local function var_0_22(arg_7_0, arg_7_1)
	local var_7_0 = {}
	local var_7_1 = 0
	local var_7_2 = arg_7_0

	;(function()
		while script_lab_robot_class_data[var_7_2]["class" .. 1] do
			if script_lab_robot_class_data[var_7_2]["status" .. 1] == arg_7_1 then
				var_7_1 = var_7_1 + script_lab_robot_class_data[var_7_2]["weight" .. 1]

				table.insert(var_7_0, {
					id = script_lab_robot_class_data[var_7_2]["class" .. 1],
					weight = var_7_1
				})
			end
		end
	end)()

	var_7_0[#var_7_0 + 1] = {}
	var_7_0[#var_7_0].totalweight = 0

	return var_7_0, var_0_20(var_7_0)
end

local function var_0_23(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = 0
	local var_9_2 = arg_9_0

	;(function()
		while script_npc_class_data[var_9_2]["class" .. 1] do
			var_9_1 = var_9_1 + script_npc_class_data[var_9_2]["weight" .. 1]

			table.insert(var_9_0, {
				id = script_npc_class_data[var_9_2]["class" .. 1],
				weight = var_9_1
			})
		end
	end)()

	var_9_0[#var_9_0 + 1] = {}
	var_9_0[#var_9_0].totalweight = 0

	return var_9_0, var_0_20(var_9_0)
end

local function var_0_24(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = 0
	local var_11_2 = arg_11_0

	;(function()
		while train_script_class_data[var_11_2]["class" .. 1] do
			var_11_1 = var_11_1 + train_script_class_data[var_11_2]["weight" .. 1]

			table.insert(var_11_0, {
				id = train_script_class_data[var_11_2]["class" .. 1],
				weight = var_11_1
			})
		end
	end)()

	var_11_0[#var_11_0 + 1] = {}
	var_11_0[#var_11_0].totalweight = 0

	return var_11_0, var_0_20(var_11_0)
end

local function var_0_25(arg_13_0, arg_13_1)
	local var_13_0 = {}
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in pairs(var_0_15[arg_13_1]) do
		if iter_13_1.classification == arg_13_0 then
			table.insert(var_13_0, iter_13_1.id)

			var_13_1[iter_13_1.actor] = var_13_1[iter_13_1.actor] or var_0_17(arg_13_1 == "main" and iter_13_1.model or arg_13_1 == "labRobot" and iter_13_1.model or arg_13_1 == "npc" and iter_13_1.model or arg_13_1 == "train" and iter_13_1.model or var_0_19(iter_13_1.actorsoulid))
		end
	end

	table.sort(var_13_0, function(arg_14_0, arg_14_1)
		return arg_14_0 < arg_14_1
	end)

	return var_13_0[1], var_13_1
end

var_0_0.filter_script = var_0_21
var_0_0.generate_theater_config = var_0_25
var_0_0.filter_lab_script = var_0_22
var_0_0.filter_npc_script = var_0_23
var_0_0.filter_train_script = var_0_24

local function var_0_26(arg_15_0)
	local var_15_0, var_15_1 = arg_15_0:match("([^,]+),(.+)")

	return tonumber(var_15_0), tonumber(var_15_1)
end

local function var_0_27(arg_16_0)
	local var_16_0, var_16_1 = var_0_26(arg_16_0[2])

	return tonumber(arg_16_0[1]), cc.p(var_16_0, var_16_1)
end

local function var_0_28(arg_17_0)
	local var_17_0 = tonumber(arg_17_0[1])
	local var_17_1, var_17_2 = var_0_26(arg_17_0[2])

	return var_17_0, cc.p(var_17_1, var_17_2), tonumber(arg_17_0[3]), arg_17_0[4] and checkint(arg_17_0[4]) or 1
end

local function var_0_29(arg_21_0)
	return nil
end

local var_0_30 = {
	moveTo = var_0_27,
	moveBy = var_0_27,
	jumpTo = var_0_28,
	jumpBy = var_0_28,
	playAni = function(self)
		return self[1], self[2] == "1"
	end,
	delayTime = function(self)
		return tonumber(self[1])
	end,
	talk = function(self)
		return self[1], (tonumber(self[2]))
	end,
	show = var_0_29,
	hide = var_0_29
}

local function var_0_31(arg_22_0, arg_22_1)
	if not arg_22_0["order_" .. arg_22_1] then
		return nil
	end

	local var_22_0 = {}

	while arg_22_0["order_" .. arg_22_1 .. "_param_" .. 1] do
		table.insert(var_22_0, arg_22_0["order_" .. arg_22_1 .. "_param_" .. 1])
	end

	return var_0_30[arg_22_0["order_" .. arg_22_1]](var_22_0)
end

local function var_0_32()
	return coroutine.create(function(arg_24_0, arg_24_1)
		while arg_24_0.running do
			arg_24_0:playScript(arg_24_1)

			arg_24_1 = coroutine.yield()
		end

		arg_24_0:removeSelf()
	end)
end

local function var_0_33()
	return coroutine.create(function(arg_26_0, arg_26_1)
		while arg_26_0.running do
			arg_26_0:playScript(arg_26_1)

			arg_26_1 = coroutine.yield()
		end
	end)
end

local function var_0_34()
	return coroutine.create(function(arg_28_0, arg_28_1)
		while arg_28_0.running do
			arg_28_0:playScript(arg_28_1)

			arg_28_1 = coroutine.yield()
		end
	end)
end

local function var_0_35()
	return coroutine.create(function(arg_30_0, arg_30_1)
		while arg_30_0.running do
			arg_30_0:playScript(arg_30_1)

			arg_30_1 = coroutine.yield()
		end
	end)
end

local var_0_36 = {}
local var_0_37 = {
	__index = var_0_36
}

function var_0_36.getCallback(arg_31_0, arg_31_1)
	if not arg_31_1 then
		return nil
	end

	return function()
		arg_31_0:resume(arg_31_1)
	end
end

function var_0_36:playScript(arg_33_1)
	local var_33_0 = config._DEBUG and assert(var_0_15[self.directorType][arg_33_1], "script " .. arg_33_1 .. " is nil!!!!") or var_0_15[self.directorType][arg_33_1]
	local var_33_1 = self:getActor(var_33_0.actor)

	if var_33_0.initpos then
		local var_33_2, var_33_3 = var_0_26(var_33_0.initpos)
		local var_33_4 = var_33_0.initzorder or 1
		local var_33_5 = var_33_0.direction or 1
		local var_33_6 = self.actorconfig[var_33_0.actor].scale

		var_33_1:setPosition(cc.p(var_33_2, var_33_3))
		var_33_1:setLocalZOrder(var_33_4)
		var_33_1:setScale(var_33_5 * var_33_6, var_33_6)
	end

	local var_33_7 = 1

	while var_33_0["order_" .. var_33_7] do
		var_33_1:execute(var_33_0["order_" .. var_33_7], self:getCallback(var_33_0["callback_" .. var_33_7]), var_0_31(var_33_0, var_33_7))

		var_33_7 = var_33_7 + 1
	end
end

function var_0_36:startPlay()
	local var_34_0, var_34_1 = coroutine.resume(self.co, self, self.startindex)

	if config._DEBUG then
		assert(var_34_0, var_34_1)
	end
end

function var_0_36:resume(arg_35_1)
	if arg_35_1 < 0 then
		self.running = false
	end

	local var_35_0, var_35_1 = coroutine.resume(self.co, arg_35_1)

	if config._DEBUG then
		assert(var_35_0, var_35_1)
	end
end

function var_0_36:addActor(arg_36_1)
	local var_36_0 = L2Actor:create(self.actorconfig[arg_36_1].jsonFilePath, self.actorconfig[arg_36_1].atlasFilePath, self.actorconfig[arg_36_1].clothesFilePath)

	var_36_0:setScale(self.actorconfig[arg_36_1].scale, self.actorconfig[arg_36_1].scale)
	var_36_0:setContentSize(self.actorconfig[arg_36_1].size)
	var_36_0:setPosition(cc.p(-100, 100))
	self.parent:addChild(var_36_0)

	self.actorlist[arg_36_1] = var_36_0

	return self.actorlist[arg_36_1]
end

function var_0_36:getActor(arg_37_1)
	if self.actorlist[arg_37_1] then
		return self.actorlist[arg_37_1]
	end

	return self:addActor(arg_37_1)
end

function var_0_36:removeActor(arg_38_1)
	if self.actorlist[arg_38_1] then
		self.actorlist[arg_38_1]:removeFromParent()

		self.actorlist[arg_38_1] = nil
	end
end

function var_0_36:removeSelf()
	self.running = false

	if self.exithandler then
		self.exithandler()
	end

	self = nil
end

function var_0_36.registerExitEvent(arg_40_0, arg_40_1)
	arg_40_0.exithandler = arg_40_1
end

function var_0_36:pausePerform()
	for iter_41_0, iter_41_1 in pairs(self.actorlist) do
		iter_41_1:pauseAni()
	end
end

function var_0_36:resumePerform()
	for iter_42_0, iter_42_1 in pairs(self.actorlist) do
		iter_42_1:resumeAni()
	end
end

function var_0_0.new(arg_43_0, arg_43_1)
	local var_43_0, var_43_1 = var_0_25(arg_43_0, "main")

	assert(var_43_0 ~= nil, "Theater StartIndex is Nil: " .. arg_43_0)

	return setmetatable({
		running = true,
		directorType = "main",
		startindex = var_43_0,
		actorconfig = var_43_1,
		parent = arg_43_1,
		co = var_0_32(),
		actorlist = {}
	}, var_0_37)
end

setmetatable(var_0_0, {
	__call = function(self, ...)
		return self.new(...)
	end
})

local var_0_38 = {}

setmetatable(var_0_38, var_0_37)

function var_0_38.getCallback(arg_45_0, arg_45_1)
	if not arg_45_1 then
		return nil
	end

	local var_45_0 = coroutine.running()

	return function()
		arg_45_0:resume(arg_45_1, var_45_0)
	end
end

function var_0_38:updateScriptconfig(arg_47_1)
	local var_47_1

	self.scriptconfig, var_47_1 = var_0_21(arg_47_1)

	for iter_47_0 = 1, #self.actorlist do
		self.actorlist[iter_47_0]:stopAllActions()
	end

	self.co = var_0_33()

	local var_47_2, var_47_3 = coroutine.resume(self.co, self, (var_0_25(var_47_1, "dorm")))

	assert(var_47_2, var_47_3)
end

function var_0_38:resume(arg_48_1, arg_48_2)
	if arg_48_2 ~= self.co then
		return
	end

	if arg_48_1 < 0 then
		if self.isfinish then
			self.running = false

			local var_48_0, var_48_1 = coroutine.resume(self.co, arg_48_1)

			assert(var_48_0, var_48_1)
		else
			arg_48_1 = var_0_25(var_0_20(self.scriptconfig), "dorm")

			if dorm_script_data[arg_48_1].initpos then
				local var_48_2 = self:getActor(dorm_script_data[arg_48_1].actor)
				local var_48_3, var_48_4 = var_0_26(dorm_script_data[arg_48_1].initpos)
				local var_48_5 = var_48_2:getPositionX()
				local var_48_6 = var_48_2:getPositionY()

				if math.abs(var_48_5 - var_48_3) > 0 then
					var_48_2.skeletonAnimation:setAnimation(0, "run", true)
					var_48_2:moveTo(function()
						local var_49_0, var_49_1 = coroutine.resume(self.co, arg_48_1)

						assert(var_49_0, var_49_1)
					end, math.abs(var_48_5 - var_48_3) / 50, cc.p(var_48_3, var_48_4))
					var_48_2:setScale(math.abs(var_48_3 - var_48_5) / (var_48_3 - var_48_5) * self.actorconfig[dorm_script_data[arg_48_1].actor].scale, self.actorconfig[dorm_script_data[arg_48_1].actor].scale)
				else
					local var_48_7, var_48_8 = coroutine.resume(self.co, arg_48_1)

					assert(var_48_7, var_48_8)
				end
			else
				local var_48_9, var_48_10 = coroutine.resume(self.co, arg_48_1)

				assert(var_48_9, var_48_10)
			end
		end
	else
		local var_48_11, var_48_12 = coroutine.resume(self.co, arg_48_1)

		assert(var_48_11, var_48_12)
	end
end

function var_0_38:insertScript(arg_50_1, arg_50_2)
	self.actorlist[1]:stopAllActions()

	local var_50_0 = var_0_25(arg_50_1, "dorm")

	if arg_50_2 then
		self.isfinish = true

		self:registerExitEvent(arg_50_2)

		self.co = var_0_32()

		local var_50_1, var_50_2 = coroutine.resume(self.co, self, var_50_0)

		assert(var_50_1, var_50_2)
	else
		self.co = var_0_33()

		local var_50_3, var_50_4 = coroutine.resume(self.co, self, var_50_0)

		assert(var_50_3, var_50_4)
	end
end

function var_0_38:deleteSelf()
	for iter_51_0 = 1, #self.actorlist do
		self.actorlist[iter_51_0]:removeFromParent()

		self.actorlist[iter_51_0] = nil
	end

	self = nil
end

function var_0_0.new_dorm(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0, var_52_1 = var_0_21(arg_52_0)

	var_52_1 = arg_52_2 or var_52_1

	local var_52_2, var_52_3 = var_0_25(var_52_1, "dorm")

	return setmetatable({
		running = true,
		directorType = "dorm",
		startindex = var_52_2,
		scriptconfig = var_52_0,
		actorconfig = var_52_3,
		parent = arg_52_1,
		co = var_0_33(),
		actorlist = {}
	}, {
		__index = var_0_38
	})
end

local var_0_39 = {}

setmetatable(var_0_39, var_0_37)

local var_0_40
local var_0_41
local var_0_42

function var_0_39.getCallback(arg_53_0, arg_53_1)
	if not arg_53_1 then
		return nil
	end

	local var_53_0 = coroutine.running()

	return function()
		arg_53_0:resume(arg_53_1, var_53_0)
	end
end

function var_0_39:resume(arg_55_1, arg_55_2)
	if arg_55_2 ~= self.co then
		return
	end

	if arg_55_1 < 0 then
		if self.isfinish then
			self.running = false

			local var_55_0, var_55_1 = coroutine.resume(self.co, arg_55_1)

			assert(var_55_0, var_55_1)
		else
			arg_55_1 = var_0_41(var_0_20(self.scriptconfig), "dorm")

			if dorm_script_data[arg_55_1].initpos then
				local var_55_2 = self:getActor(dorm_script_data[arg_55_1].actor)
				local var_55_3, var_55_4 = var_0_26(dorm_script_data[arg_55_1].initpos)
				local var_55_5 = var_55_2:getPositionX()
				local var_55_6 = var_55_2:getPositionY()

				if math.abs(var_55_5 - var_55_3) > 0 then
					var_55_2.skeletonAnimation:setAnimation(0, "run", true)
					var_55_2:moveTo(function()
						local var_56_0, var_56_1 = coroutine.resume(self.co, arg_55_1)

						assert(var_56_0, var_56_1)
					end, math.abs(var_55_5 - var_55_3) / 50, cc.p(var_55_3, var_55_4))
					var_55_2:setScale(math.abs(var_55_3 - var_55_5) / (var_55_3 - var_55_5) * self.actorconfig[dorm_script_data[arg_55_1].actor].scale, self.actorconfig[dorm_script_data[arg_55_1].actor].scale)
				else
					local var_55_7, var_55_8 = coroutine.resume(self.co, arg_55_1)

					assert(var_55_7, var_55_8)
				end
			else
				local var_55_9, var_55_10 = coroutine.resume(self.co, arg_55_1)

				assert(var_55_9, var_55_10)
			end
		end
	else
		local var_55_11, var_55_12 = coroutine.resume(self.co, arg_55_1)

		assert(var_55_11, var_55_12)
	end
end

function var_0_39:deleteSelf()
	for iter_57_0 = 1, #self.actorlist do
		self.actorlist[iter_57_0]:removeFromParent()

		self.actorlist[iter_57_0] = nil
	end

	self = nil
end

function var_0_0.new_dorm_visit(arg_58_0, arg_58_1, arg_58_2, arg_58_3, arg_58_4)
	local item_data = require("data.item_data")

	function var_0_40(arg_59_0)
		if arg_58_3[arg_59_0] and arg_58_3[arg_59_0] ~= -1 then
			return item_data[arg_58_3[arg_59_0]].model
		else
			return major_factor_data[arg_59_0].model
		end
	end

	function var_0_41(arg_60_0, arg_60_1)
		local var_60_0 = {}
		local var_60_1 = {}

		for iter_60_0, iter_60_1 in pairs(var_0_15[arg_60_1]) do
			if iter_60_1.classification == arg_60_0 then
				table.insert(var_60_0, iter_60_1.id)

				var_60_1[iter_60_1.actor] = var_60_1[iter_60_1.actor] or var_0_17((var_0_40(iter_60_1.actorsoulid)))
			end
		end

		table.sort(var_60_0, function(arg_61_0, arg_61_1)
			return arg_61_0 < arg_61_1
		end)

		return var_60_0[1], var_60_1
	end

	function var_0_42(arg_62_0)
		local var_62_0 = {}
		local var_62_1 = 0
		local var_62_2 = var_0_40(arg_62_0)
		local var_62_3 = dorm_script_class_data[var_62_2] and var_62_2 or arg_62_0

		while dorm_script_class_data[var_62_3]["class" .. 1] do
			var_62_0[1] = {}
			var_62_0[1].id = dorm_script_class_data[var_62_3]["class" .. 1]
			var_62_1 = var_62_1 + dorm_script_class_data[var_62_3]["weight" .. 1]
			var_62_0[1].weight = var_62_1
		end

		;(function()
			for iter_63_0 = 1, 5 do
				while dorm_script_class_data[var_62_3]["class_furniture" .. iter_63_0 .. "_" .. 1] do
					assert(dorm_script_class_data[var_62_3]["class_furniture" .. iter_63_0 .. "_" .. 1 .. "_parameter"], "soulid: " .. var_62_3 .. ", class_furniture" .. iter_63_0 .. "_" .. 1 .. "_parameter is nil")

					if arg_58_4.furnitures[iter_63_0] == dorm_script_class_data[var_62_3]["class_furniture" .. iter_63_0 .. "_" .. 1 .. "_parameter"] then
						assert(dorm_script_class_data[var_62_3]["class_furniture" .. iter_63_0 .. "_" .. 1 .. "_weight"], "soulid: " .. var_62_3 .. ", class_furniture" .. iter_63_0 .. "_" .. 1 .. "_weight is nil")

						var_62_1 = var_62_1 + dorm_script_class_data[var_62_3]["class_furniture" .. iter_63_0 .. "_" .. 1 .. "_weight"]
						var_62_0[#var_62_0 + 1] = {
							id = dorm_script_class_data[var_62_3]["class_furniture" .. iter_63_0 .. "_" .. 1],
							weight = var_62_1
						}

						break
					end
				end
			end
		end)()

		var_62_0[#var_62_0 + 1] = {}
		var_62_0[#var_62_0].totalweight = var_62_1

		return var_62_0, var_0_20(var_62_0)
	end

	local var_58_1, var_58_2 = var_0_42(arg_58_0)

	var_58_2 = arg_58_2 or var_58_2

	local var_58_3, var_58_4 = var_0_41(var_58_2, "dorm")

	return setmetatable({
		running = true,
		directorType = "dorm",
		startindex = var_58_3,
		scriptconfig = var_58_1,
		actorconfig = var_58_4,
		parent = arg_58_1,
		dress_config = arg_58_3,
		co = var_0_33(),
		actorlist = {}
	}, {
		__index = var_0_39
	})
end

local var_0_43 = {}

setmetatable(var_0_43, var_0_37)

function var_0_43.getCallback(arg_64_0, arg_64_1)
	if not arg_64_1 then
		return nil
	end

	local var_64_0 = coroutine.running()

	return function()
		arg_64_0:resume(arg_64_1, var_64_0)
	end
end

function var_0_43:resume(arg_66_1, arg_66_2)
	if arg_66_2 ~= self.co then
		return
	end

	if arg_66_1 < 0 then
		self.running = false
	end

	local var_66_0, var_66_1 = coroutine.resume(self.co, arg_66_1)

	assert(var_66_0, var_66_1)
end

function var_0_43:insertScript(arg_67_1)
	for iter_67_0 = 1, #self.actorlist do
		self.actorlist[iter_67_0]:stopAllActions()
	end

	self.co = var_0_32()

	local var_67_0, var_67_1 = coroutine.resume(self.co, self, (var_0_25(arg_67_1, "DR")))

	assert(var_67_0, var_67_1)
end

function var_0_43:removeSelf()
	for iter_68_0 = 1, #self.actorlist do
		self.actorlist[iter_68_0]:removeFromParent()

		self.actorlist[iter_68_0] = nil
	end

	if self.exithandler then
		self.exithandler()
	end
end

function var_0_43:deleteSelf()
	for iter_69_0 = 1, #self.actorlist do
		self.actorlist[iter_69_0]:removeFromParent()

		self.actorlist[iter_69_0] = nil
	end

	self = nil
end

function var_0_43:refreshDR(arg_70_1, arg_70_2)
	var_0_15.DR = require("data.food_production.script/restaurant_script" .. arg_70_2 .. "_data")

	local var_70_0, var_70_1 = var_0_25(arg_70_1, "DR")

	self.startindex = var_70_0
	self.actorconfig = var_70_1
	self.running = true
	self.co = var_0_32()
	self.actorlist = {}
	self.directorType = "DR"

	local var_70_2, var_70_3 = coroutine.resume(self.co, self, var_70_0)

	assert(var_70_2, var_70_3)
end

function var_0_43:playScript(arg_71_1)
	local var_71_0 = config._DEBUG and assert(var_0_15[self.directorType][arg_71_1], "script " .. arg_71_1 .. " is nil!!!!") or var_0_15[self.directorType][arg_71_1]
	local var_71_1 = self:getActor(var_71_0.actor)

	if var_71_0.initpos then
		local var_71_2, var_71_3 = var_0_26(var_71_0.initpos)
		local var_71_4 = var_71_0.initzorder or 1

		if not var_71_0.direction then
			-- block empty
		end

		var_71_1:setPosition(cc.p(var_71_2, var_71_3))
		var_71_1:setLocalZOrder(var_71_4)
	end

	if var_71_0.direction then
		var_71_1:setScale(var_71_0.direction * self.actorconfig[var_71_0.actor].scale, self.actorconfig[var_71_0.actor].scale)
	end

	local var_71_6 = 1

	while var_71_0["order_" .. var_71_6] do
		var_71_1:execute(var_71_0["order_" .. var_71_6], self:getCallback(var_71_0["callback_" .. var_71_6]), var_0_31(var_71_0, var_71_6))

		var_71_6 = var_71_6 + 1
	end
end

function var_0_0.new_DR(arg_72_0, arg_72_1, arg_72_2)
	var_0_15.DR = require("data.food_production.script/restaurant_script" .. arg_72_0 .. "_data")

	local var_72_0, var_72_1 = var_0_25(arg_72_2 or require("data.food_production.menu.menu" .. arg_72_0 .. "_data")[playermodel.soulsDRstatus[arg_72_0]].DR_script_wait, "DR")

	return setmetatable({
		running = true,
		directorType = "DR",
		startindex = var_72_0,
		actorconfig = var_72_1,
		parent = arg_72_1,
		co = var_0_32(),
		actorlist = {}
	}, {
		__index = var_0_43
	})
end

local var_0_44 = {}

setmetatable(var_0_44, var_0_37)

function var_0_44.getCallback(arg_73_0, arg_73_1)
	if not arg_73_1 then
		return nil
	end

	local var_73_0 = coroutine.running()

	return function()
		arg_73_0:resume(arg_73_1, var_73_0)
	end
end

function var_0_44:updateScriptconfig(arg_75_1, arg_75_2)
	local var_75_1

	self.scriptconfig, var_75_1 = var_0_22(arg_75_1, arg_75_2)

	for iter_75_0 = 1, #self.actorlist do
		self.actorlist[iter_75_0]:stopAllActions()
	end

	self.co = var_0_34()

	local var_75_2, var_75_3 = coroutine.resume(self.co, self, (var_0_25(var_75_1, "labRobot")))

	assert(var_75_2, var_75_3)
end

function var_0_44:resume(arg_76_1, arg_76_2)
	if arg_76_2 ~= self.co then
		return
	end

	if arg_76_1 < 0 then
		if self.isfinish then
			self.running = false

			local var_76_0, var_76_1 = coroutine.resume(self.co, arg_76_1)

			assert(var_76_0, var_76_1)
		else
			arg_76_1 = var_0_25(var_0_20(self.scriptconfig), "labRobot")

			if dorm_script_data[arg_76_1].initpos then
				local var_76_2 = self:getActor(dorm_script_data[arg_76_1].actor)
				local var_76_3, var_76_4 = var_0_26(dorm_script_data[arg_76_1].initpos)
				local var_76_5 = var_76_2:getPositionX()
				local var_76_6 = var_76_2:getPositionY()

				if math.abs(var_76_5 - var_76_3) > 0 then
					var_76_2.skeletonAnimation:setAnimation(0, "run", true)
					var_76_2:moveTo(function()
						local var_77_0, var_77_1 = coroutine.resume(self.co, arg_76_1)

						assert(var_77_0, var_77_1)
					end, math.abs(var_76_5 - var_76_3) / 50, cc.p(var_76_3, var_76_4))
					var_76_2:setScale(math.abs(var_76_3 - var_76_5) / (var_76_3 - var_76_5) * self.actorconfig[dorm_script_data[arg_76_1].actor].scale, self.actorconfig[dorm_script_data[arg_76_1].actor].scale)
				else
					local var_76_7, var_76_8 = coroutine.resume(self.co, arg_76_1)

					assert(var_76_7, var_76_8)
				end
			else
				local var_76_9, var_76_10 = coroutine.resume(self.co, arg_76_1)

				assert(var_76_9, var_76_10)
			end
		end
	else
		local var_76_11, var_76_12 = coroutine.resume(self.co, arg_76_1)

		assert(var_76_11, var_76_12)
	end
end

function var_0_44:insertScript(arg_78_1, arg_78_2)
	self.actorlist[1]:stopAllActions()

	local var_78_0 = var_0_25(arg_78_1, "labRobot")

	if arg_78_2 then
		self.isfinish = true

		self:registerExitEvent(arg_78_2)

		self.co = var_0_32()

		local var_78_1, var_78_2 = coroutine.resume(self.co, self, var_78_0)

		assert(var_78_1, var_78_2)
	else
		self.co = var_0_34()

		local var_78_3, var_78_4 = coroutine.resume(self.co, self, var_78_0)

		assert(var_78_3, var_78_4)
	end
end

function var_0_44:deleteSelf()
	for iter_79_0 = 1, #self.actorlist do
		self.actorlist[iter_79_0]:removeFromParent()

		self.actorlist[iter_79_0] = nil
	end

	self = nil
end

function var_0_0.new_lab_robot(arg_80_0, arg_80_1, arg_80_2, arg_80_3)
	local var_80_0, var_80_1 = var_0_22(arg_80_0, arg_80_3)

	var_80_1 = arg_80_2 or var_80_1

	local var_80_2, var_80_3 = var_0_25(var_80_1, "labRobot")

	return setmetatable({
		running = true,
		directorType = "labRobot",
		startindex = var_80_2,
		scriptconfig = var_80_0,
		actorconfig = var_80_3,
		parent = arg_80_1,
		co = var_0_34(),
		actorlist = {}
	}, {
		__index = var_0_44
	})
end

local var_0_45 = {}

setmetatable(var_0_45, var_0_37)

function var_0_45.getCallback(arg_81_0, arg_81_1)
	if not arg_81_1 then
		return nil
	end

	local var_81_0 = coroutine.running()

	return function()
		arg_81_0:resume(arg_81_1, var_81_0)
	end
end

function var_0_45:updateScriptconfig(arg_83_1)
	local var_83_1

	self.scriptconfig, var_83_1 = var_0_23(arg_83_1)

	for iter_83_0 = 1, #self.actorlist do
		self.actorlist[iter_83_0]:stopAllActions()
	end

	self.co = var_0_35()

	local var_83_2, var_83_3 = coroutine.resume(self.co, self, (var_0_25(var_83_1, "npc")))

	assert(var_83_2, var_83_3)
end

function var_0_45:resume(arg_84_1, arg_84_2)
	if arg_84_2 ~= self.co then
		return
	end

	if arg_84_1 < 0 then
		if self.isfinish then
			self.running = false

			local var_84_0, var_84_1 = coroutine.resume(self.co, arg_84_1)

			assert(var_84_0, var_84_1)
		else
			arg_84_1 = var_0_25(var_0_20(self.scriptconfig), "npc")

			if script_npc_data[arg_84_1].initpos then
				local var_84_2 = self:getActor(script_npc_data[arg_84_1].actor)
				local var_84_3, var_84_4 = var_0_26(script_npc_data[arg_84_1].initpos)
				local var_84_5 = var_84_2:getPositionX()
				local var_84_6 = var_84_2:getPositionY()

				if math.abs(var_84_5 - var_84_3) > 0 then
					var_84_2.skeletonAnimation:setAnimation(0, "run", true)
					var_84_2:moveTo(function()
						local var_85_0, var_85_1 = coroutine.resume(self.co, arg_84_1)

						assert(var_85_0, var_85_1)
					end, math.abs(var_84_5 - var_84_3) / 50, cc.p(var_84_3, var_84_4))
					var_84_2:setScale(math.abs(var_84_3 - var_84_5) / (var_84_3 - var_84_5) * self.actorconfig[script_npc_data[arg_84_1].actor].scale, self.actorconfig[script_npc_data[arg_84_1].actor].scale)
				else
					local var_84_7, var_84_8 = coroutine.resume(self.co, arg_84_1)

					assert(var_84_7, var_84_8)
				end
			else
				local var_84_9, var_84_10 = coroutine.resume(self.co, arg_84_1)

				assert(var_84_9, var_84_10)
			end
		end
	else
		local var_84_11, var_84_12 = coroutine.resume(self.co, arg_84_1)

		assert(var_84_11, var_84_12)
	end
end

function var_0_45:insertScript(arg_86_1, arg_86_2)
	self.actorlist[1]:stopAllActions()

	local var_86_0 = var_0_25(arg_86_1, "npc")

	if arg_86_2 then
		self.isfinish = true

		self:registerExitEvent(arg_86_2)

		self.co = var_0_32()

		local var_86_1, var_86_2 = coroutine.resume(self.co, self, var_86_0)

		assert(var_86_1, var_86_2)
	else
		self.co = var_0_35()

		local var_86_3, var_86_4 = coroutine.resume(self.co, self, var_86_0)

		assert(var_86_3, var_86_4)
	end
end

function var_0_45:deleteSelf()
	for iter_87_0 = 1, #self.actorlist do
		self.actorlist[iter_87_0]:removeFromParent()

		self.actorlist[iter_87_0] = nil
	end

	self = nil
end

function var_0_0.new_lab_npc(arg_88_0, arg_88_1, arg_88_2)
	local var_88_0, var_88_1 = var_0_23(arg_88_0)

	var_88_1 = arg_88_2 or var_88_1

	local var_88_2, var_88_3 = var_0_25(var_88_1, "npc")

	return setmetatable({
		running = true,
		directorType = "npc",
		startindex = var_88_2,
		scriptconfig = var_88_0,
		actorconfig = var_88_3,
		parent = arg_88_1,
		co = var_0_35(),
		actorlist = {}
	}, {
		__index = var_0_45
	})
end

local var_0_46 = {}

setmetatable(var_0_46, var_0_37)

function var_0_46.getCallback(arg_89_0, arg_89_1)
	if not arg_89_1 then
		return nil
	end

	local var_89_0 = coroutine.running()

	return function()
		arg_89_0:resume(arg_89_1, var_89_0)
	end
end

function var_0_46:updateScriptconfig(arg_91_1)
	local var_91_1

	self.scriptconfig, var_91_1 = var_0_24(arg_91_1)

	for iter_91_0 = 1, #self.actorlist do
		self.actorlist[iter_91_0]:stopAllActions()
	end

	self.co = var_0_35()

	local var_91_2, var_91_3 = coroutine.resume(self.co, self, (var_0_25(var_91_1, "train")))

	assert(var_91_2, var_91_3)
end

function var_0_46:resume(arg_92_1, arg_92_2)
	if arg_92_2 ~= self.co then
		return
	end

	if arg_92_1 < 0 then
		if self.isfinish then
			self.running = false

			local var_92_0, var_92_1 = coroutine.resume(self.co, arg_92_1)

			assert(var_92_0, var_92_1)
		else
			arg_92_1 = var_0_25(var_0_20(self.scriptconfig), "train")

			if train_script_data[arg_92_1].initpos then
				local var_92_2 = self:getActor(train_script_data[arg_92_1].actor)
				local var_92_3, var_92_4 = var_0_26(train_script_data[arg_92_1].initpos)
				local var_92_5 = var_92_2:getPositionX()
				local var_92_6 = var_92_2:getPositionY()

				if math.abs(var_92_5 - var_92_3) > 0 then
					var_92_2.skeletonAnimation:setAnimation(0, "run", true)
					var_92_2:moveTo(function()
						local var_93_0, var_93_1 = coroutine.resume(self.co, arg_92_1)

						assert(var_93_0, var_93_1)
					end, math.abs(var_92_5 - var_92_3) / 50, cc.p(var_92_3, var_92_4))
					var_92_2:setScale(math.abs(var_92_3 - var_92_5) / (var_92_3 - var_92_5) * self.actorconfig[train_script_data[arg_92_1].actor].scale, self.actorconfig[train_script_data[arg_92_1].actor].scale)
				else
					local var_92_7, var_92_8 = coroutine.resume(self.co, arg_92_1)

					assert(var_92_7, var_92_8)
				end
			else
				local var_92_9, var_92_10 = coroutine.resume(self.co, arg_92_1)

				assert(var_92_9, var_92_10)
			end
		end
	else
		local var_92_11, var_92_12 = coroutine.resume(self.co, arg_92_1)

		assert(var_92_11, var_92_12)
	end
end

function var_0_46:insertScript(arg_94_1, arg_94_2)
	self.actorlist[1]:stopAllActions()

	local var_94_0 = var_0_25(arg_94_1, "train")

	if arg_94_2 then
		self.isfinish = true

		self:registerExitEvent(arg_94_2)

		self.co = var_0_32()

		local var_94_1, var_94_2 = coroutine.resume(self.co, self, var_94_0)

		assert(var_94_1, var_94_2)
	else
		self.co = var_0_35()

		local var_94_3, var_94_4 = coroutine.resume(self.co, self, var_94_0)

		assert(var_94_3, var_94_4)
	end
end

function var_0_46:deleteSelf()
	for iter_95_0 = 1, #self.actorlist do
		self.actorlist[iter_95_0]:removeFromParent()

		self.actorlist[iter_95_0] = nil
	end

	self = nil
end

function var_0_0.new_train_npc(arg_96_0, arg_96_1, arg_96_2)
	local var_96_0, var_96_1 = var_0_24(arg_96_0)

	var_96_1 = arg_96_2 or var_96_1

	local var_96_2, var_96_3 = var_0_25(var_96_1, "train")

	return setmetatable({
		running = true,
		directorType = "train",
		startindex = var_96_2,
		scriptconfig = var_96_0,
		actorconfig = var_96_3,
		parent = arg_96_1,
		co = var_0_35(),
		actorlist = {}
	}, {
		__index = var_0_46
	})
end

return var_0_0
