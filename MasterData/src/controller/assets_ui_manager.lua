local var_0_0 = {
	"mainScenebg/updateload/1.jpg",
	"mainScenebg/updateload/3.jpg",
	"mainScenebg/updateload/4.jpg",
	"mainScenebg/updateload/5.jpg",
	"mainScenebg/updateload/7.jpg",
	"mainScenebg/updateload/8.jpg",
	"mainScenebg/updateload/10.jpg",
	"mainScenebg/updateload/11.jpg",
	"mainScenebg/updateload/12.jpg",
	"mainScenebg/updateload/13.jpg",
	"mainScenebg/updateload/14.jpg",
	"mainScenebg/updateload/15.jpg",
	"mainScenebg/updateload/17.jpg",
	"mainScenebg/updateload/18.jpg",
	"mainScenebg/updateload/19.jpg",
	"mainScenebg/updateload/23.jpg",
	"mainScenebg/updateload/29.jpg",
	"mainScenebg/updateload/30.png",
	"mainScenebg/updateload/1.jpg"
}
local var_0_1 = {
	"update/loadani",
	"update/loadani_1",
	"update/loadani_2",
	"update/loadani_4",
	"update/loadani_6",
	"update/loadani_7",
	"update/loadani_8",
	"update/loadani_9",
	"update/loadani_10",
	"update/loadani_11",
	"update/loadani_12",
	"update/26920_run",
	"update/loadani_27720"
}
local var_0_2 = {
	start = "2020-11-20 00:00:00",
	finish = "2020-12-17 23:59:59",
	bglist = {
		"mainScenebg/updateload/umaru1.png",
		"mainScenebg/updateload/umaru2.png",
		"mainScenebg/updateload/umaru3.png",
		"mainScenebg/updateload/umaru4.png",
		"mainScenebg/updateload/umaru5.png"
	}
}
local var_0_3 = {
	finish = "2021-02-13 23:59:59",
	start = "2021-01-21 00:00:00",
	loadani = {
		"update/26920_run"
	}
}

local function var_0_4()
	local var_1_0 = os.time()
	local var_1_1, var_1_2, var_1_3, var_1_4, var_1_5, var_1_6 = var_0_2.start:match("(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
	local var_1_7, var_1_8, var_1_9, var_1_10, var_1_11, var_1_12 = var_0_2.finish:match("(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")

	if os.time({
		year = var_1_1,
		month = var_1_2,
		day = var_1_3,
		hour = var_1_4,
		min = var_1_5,
		sec = var_1_6
	}) <= var_1_0 and var_1_0 <= os.time({
		year = var_1_7,
		month = var_1_8,
		day = var_1_9,
		hour = var_1_10,
		min = var_1_11,
		sec = var_1_12
	}) then
		if #var_0_2.bglist == 1 then
			return var_0_2.bglist[1]
		else
			return var_0_2.bglist[math.random(1, #var_0_2.bglist)]
		end
	else
		return nil
	end
end

local function var_0_5()
	local var_2_0 = os.time()
	local var_2_1, var_2_2, var_2_3, var_2_4, var_2_5, var_2_6 = var_0_3.start:match("(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
	local var_2_7, var_2_8, var_2_9, var_2_10, var_2_11, var_2_12 = var_0_3.finish:match("(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")

	if os.time({
		year = var_2_1,
		month = var_2_2,
		day = var_2_3,
		hour = var_2_4,
		min = var_2_5,
		sec = var_2_6
	}) <= var_2_0 and var_2_0 <= os.time({
		year = var_2_7,
		month = var_2_8,
		day = var_2_9,
		hour = var_2_10,
		min = var_2_11,
		sec = var_2_12
	}) then
		if #var_0_3.loadani == 1 then
			return var_0_3.loadani[1]
		else
			return var_0_3.loadani[math.random(1, #var_0_3.loadani)]
		end
	else
		return nil
	end
end

local var_0_6 = {
	{
		start = "2020-06-27 00:00:00",
		finish = "2020-06-29 00:00:00",
		bglist = {
			"mainScenebg/updateload/maliubirth.png"
		}
	},
	{
		start = "2020-07-31 00:00:00",
		finish = "2020-08-03 00:00:00",
		bglist = {
			"mainScenebg/updateload/xialuotebirth.png"
		}
	}
}
local var_0_7 = {
	["mainScenebg/updateload/xie.png"] = "update/loadani_27720",
	["mainScenebg/updateload/she.png"] = "update/loadani_27620",
	["mainScenebg/updateload/ying.png"] = "update/loadani_27820"
}
local var_0_8 = {}
local var_0_9
local var_0_10 = {}
local var_0_11 = 0
local var_0_12 = {}
local var_0_13

function var_0_12:gen_tips_data()
	if not self.initTipsData then
		var_0_8 = require("data.loading_define_data")

		for iter_3_0, iter_3_1 in pairs(var_0_8) do
			iter_3_1.content = iter_3_1.conten
		end

		self.initTipsData = true
	end
end

function var_0_12:getTipsDataList()
	self:gen_tips_data()

	local var_4_0 = os.time()

	if not var_0_9 then
		var_0_9 = {}

		for iter_4_0, iter_4_1 in ipairs(var_0_8) do
			if iter_4_1.start_time and iter_4_1.finish_time then
				local var_4_1, var_4_2, var_4_3, var_4_4, var_4_5, var_4_6 = iter_4_1.start_time:match("(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
				local var_4_7 = os.time({
					year = var_4_1,
					month = var_4_2,
					day = var_4_3,
					hour = var_4_4,
					min = var_4_5,
					sec = var_4_6
				})
				local var_4_8, var_4_9, var_4_10, var_4_11, var_4_12, var_4_13 = iter_4_1.finish_time:match("(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")

				if var_4_7 <= var_4_0 and var_4_0 <= os.time({
					year = var_4_8,
					month = var_4_9,
					day = var_4_10,
					hour = var_4_11,
					min = var_4_12,
					sec = var_4_13
				}) then
					table.insert(var_0_9, iter_4_1)
				end
			else
				table.insert(var_0_9, iter_4_1)
			end
		end
	end

	return var_0_9
end

function var_0_12:getTipsInfo()
	local var_5_0 = self:getTipsDataList()

	if var_5_0 and next(var_5_0) then
		if #var_5_0 == 1 then
			local var_5_1 = table.remove(var_5_0, 1)

			table.insert(var_0_10, var_5_1)

			return var_5_1
		else
			local GlobalConstantsManager = require("controller.GlobalConstantsManager")

			if GlobalConstantsManager then
				local var_5_3 = string.split(GlobalConstantsManager:getInstance():getValueById(4), "#")
				local var_5_4 = {}

				for iter_5_0 = 1, #var_5_3 do
					local var_5_5 = string.split(var_5_3[iter_5_0], "-")
					local var_5_6 = tonumber(var_5_5[1])
					local var_5_7 = tonumber(var_5_5[2])

					if var_5_6 and var_5_7 then
						var_5_4[var_5_6] = var_5_7
					end
				end

				local var_5_8 = {}

				for iter_5_1 = 1, #var_5_0 do
					local var_5_9 = false

					for iter_5_2, iter_5_3 in pairs(var_5_8) do
						if iter_5_3.iType == var_5_0[iter_5_1].type then
							var_5_9 = true

							break
						end
					end

					if var_5_4[var_5_0[iter_5_1].type] and not var_5_9 then
						if not next(var_5_8) then
							table.insert(var_5_8, {
								iType = var_5_0[iter_5_1].type,
								weight = var_5_4[var_5_0[iter_5_1].type]
							})
						else
							table.insert(var_5_8, {
								iType = var_5_0[iter_5_1].type,
								weight = var_5_4[var_5_0[iter_5_1].type] + var_5_8[#var_5_8].weight
							})
						end
					end
				end

				local var_5_10 = math.random(1, 100)

				if next(var_5_8) then
					var_5_10 = math.random(1, var_5_8[#var_5_8].weight)
				end

				local var_5_11

				for iter_5_4 = 1, #var_5_8 do
					if var_5_10 <= var_5_8[iter_5_4].weight then
						var_5_11 = var_5_8[iter_5_4].iType

						break
					end
				end

				if var_5_11 then
					local var_5_12 = {}

					for iter_5_5, iter_5_6 in pairs(var_5_0) do
						if iter_5_6.type == var_5_11 then
							table.insert(var_5_12, iter_5_6)
						end
					end

					if next(var_5_12) then
						local var_5_13 = table.remove(var_5_12, (math.random(1, #var_5_12)))

						for iter_5_7, iter_5_8 in pairs(var_5_0) do
							if iter_5_8.id == var_5_13.id then
								table.remove(var_5_0, iter_5_7)

								break
							end
						end

						table.insert(var_0_10, var_5_13)

						return var_5_13
					else
						local var_5_14 = table.remove(var_5_0, (math.random(1, #var_5_0)))

						table.insert(var_0_10, var_5_14)

						return var_5_14
					end
				else
					local var_5_15 = table.remove(var_5_0, (math.random(1, #var_5_0)))

					table.insert(var_0_10, var_5_15)

					return var_5_15
				end
			else
				local var_5_16 = table.remove(var_5_0, (math.random(1, #var_5_0)))

				table.insert(var_0_10, var_5_16)

				return var_5_16
			end
		end
	elseif var_0_10 and next(var_0_10) then
		var_0_11 = var_0_11 + 1

		if var_0_11 > #var_0_10 then
			var_0_11 = 1
		end

		return var_0_10[var_0_11]
	else
		return nil
	end
end

function var_0_12:gen_birthdaybg_data()
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs((require("data.loading_img_conf_data"))) do
		local var_6_1 = {}

		while iter_6_1["path" .. 1] do
			table.insert(var_6_1, iter_6_1["path" .. 1])
		end

		table.insert(var_6_0, {
			order = iter_6_1.order,
			start = iter_6_1.starttime,
			finish = iter_6_1.finishtime,
			bglist = var_6_1
		})
	end

	table.sort(var_6_0, function(arg_7_0, arg_7_1)
		return arg_7_0.order > arg_7_1.order
	end)

	if not self.initBirthdaybg then
		for iter_6_2, iter_6_3 in ipairs(var_6_0) do
			table.insert(var_0_6, iter_6_3)
		end

		self.initBirthdaybg = true
	end
end

function var_0_12:getBirthDayBGList()
	self:gen_birthdaybg_data()

	local var_8_0 = os.time()
	local var_8_1

	for iter_8_0, iter_8_1 in ipairs(var_0_6) do
		local var_8_2, var_8_3, var_8_4, var_8_5, var_8_6, var_8_7 = iter_8_1.start:match("(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
		local var_8_8 = os.time({
			year = var_8_2,
			month = var_8_3,
			day = var_8_4,
			hour = var_8_5,
			min = var_8_6,
			sec = var_8_7
		})
		local var_8_9, var_8_10, var_8_11, var_8_12, var_8_13, var_8_14 = iter_8_1.finish:match("(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")

		if var_8_8 <= var_8_0 and var_8_0 <= os.time({
			year = var_8_9,
			month = var_8_10,
			day = var_8_11,
			hour = var_8_12,
			min = var_8_13,
			sec = var_8_14
		}) then
			var_8_1 = var_8_1 or {}

			for iter_8_2, iter_8_3 in ipairs(iter_8_1.bglist) do
				table.insert(var_8_1, iter_8_3)
			end
		end
	end

	return var_8_1
end

function var_0_12:getBirthDayBG()
	local var_9_0 = self:getBirthDayBGList()

	if var_9_0 then
		if #var_9_0 == 1 then
			return var_9_0[1]
		else
			return var_9_0[math.random(1, #var_9_0)]
		end
	else
		return nil
	end
end

function var_0_12:getBG()
	local var_10_0 = self:getBirthDayBG()

	if var_10_0 then
		if var_0_7[var_10_0] then
			var_0_13 = var_0_7[var_10_0]
		end

		return var_10_0
	end

	local var_10_1 = var_0_4()

	if var_10_1 then
		return var_10_1
	end

	local var_10_2 = cc.UserDefault:getInstance():getIntegerForKey("UpdateBG", 1)
	local var_10_3 = var_0_0[var_10_2]

	if not var_0_0[var_10_2] then
		var_10_3 = var_0_0[1]
		var_10_2 = 1
	end

	cc.UserDefault:getInstance():setIntegerForKey("UpdateBG", (var_10_2 + 1 > #var_0_0 or nil) and 1)

	if DeviceManager.getPackageChannel() == "douyin" then
		return "mainScenebg/updateload/8.jpg"
	end

	return var_10_3
end

local var_0_14

function var_0_12.getLoadAni(arg_11_0)
	if var_0_13 then
		return var_0_13
	end

	local var_11_0 = var_0_5()

	if var_11_0 then
		return var_11_0
	end

	var_0_14 = var_0_14 or math.random(1, #var_0_1)

	return var_0_1[var_0_14]
end

return var_0_12
