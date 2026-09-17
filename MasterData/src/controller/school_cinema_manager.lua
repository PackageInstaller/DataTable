local organization_photo_data = require("data.organization_photo_data")
local photo_extension_data = require("data.photo_extension_data")
local photo_data = require("data.photo_data")
local major_factor_data = require("data.major_factor_data")
local servant_data = require("data.servant_data")
local favor_thing_data = require("data.favor_thing_data")
local travel_city_data = require("data.travel_city_data")
local travel_event_weight_data = require("data.travel_event_weight_data")
local travel_event_data = require("data.travel_event_data")
local postcard_data = require("data.postcard_data")
local travel_photo_data = require("data.travel_photo_data")
local photo_dream_data = require("data.photo_dream_data")
local activity_photo_data = require("data.activity_photo_data")
local explore_photo_data = require("data.explore_photo_data")
local playermodel = require("model.playermodel")
local network = require("network.network")
local time_check_manager = require("controller.time_check_manager")
local SchoolCinemaManager = class("SchoolCinemaManager")

function SchoolCinemaManager:init(arg_1_1)
	self.cinemaInfo = {}

	self:requestPostCardTaskInfo(function()
		self:requestCinemaInfo(arg_1_1)
	end)
end

function SchoolCinemaManager:getNeedPhotoData1ByChapter()
	local var_3_0 = {
		{}
	}
	local var_3_1 = {
		1,
		2,
		3,
		4,
		11,
		12,
		13,
		14,
		21,
		22,
		23,
		24
	}

	for iter_3_0 = 1, #var_3_1 do
		if postcard_data[var_3_1[iter_3_0]] then
			local var_3_2 = {
				isUnlock = true,
				index = iter_3_0,
				title = postcard_data[var_3_1[iter_3_0]].title,
				itemPath = "mainScenebg/postcard/" .. postcard_data[var_3_1[iter_3_0]].image .. ".png",
				des = postcard_data[var_3_1[iter_3_0]].info
			}

			var_3_2.posx = postcard_data[var_3_1[iter_3_0]].offset_x or 0
			var_3_2.posy = postcard_data[var_3_1[iter_3_0]].offset_y or 0

			table.insert(var_3_0[1], var_3_2)
		end
	end

	var_3_0[2] = {}

	for iter_3_1, iter_3_2 in pairs(organization_photo_data) do
		local var_3_3 = {}

		if iter_3_2.content_type ~= nil then
			for iter_3_3 = 1, iter_3_2.content_type do
				local var_3_5 = {
					index = #var_3_3 + 1
				}

				var_3_5.name = iter_3_2["name_" .. iter_3_3] or "测试名字"
				var_3_5.nameEn = iter_3_2["en_name_" .. iter_3_3] or "测试名字En"
				var_3_5.words = iter_3_2["word_" .. iter_3_3] or "台词巴拉巴拉"

				table.insert(var_3_3, var_3_5)
			end
		end

		table.insert(var_3_0[2], {
			index = iter_3_2.id,
			title = iter_3_2.introduction,
			iconPath = "SchoolCinemaLayer/plot_detail/plot1/item" .. iter_3_2.icon .. ".png",
			content_type = iter_3_2.content_type,
			studentList = var_3_3
		})
	end

	return var_3_0
end

function SchoolCinemaManager:isNew(arg_4_1)
	local var_4_0 = false

	if self.cinemaInfo[arg_4_1] then
		for iter_4_0, iter_4_1 in pairs(self.cinemaInfo[arg_4_1]) do
			if type(iter_4_1) == "table" and iter_4_1.isNew == true then
				var_4_0 = true

				break
			end
		end
	end

	return var_4_0
end

function SchoolCinemaManager:getNeedPhotoData2ByChapter()
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(photo_extension_data) do
		local var_5_1 = iter_5_1.chapter
		local var_5_2

		if var_5_0[iter_5_1.chapter] then
			var_5_2 = var_5_0[var_5_1].unlockNum or 0

			local var_5_3

			if var_5_0[var_5_1] then
				var_5_3 = var_5_0[var_5_1].allNum or 0
			end
		end

		local var_5_4 = true

		if true == true then
			var_5_2 = var_5_2 + 1
		end

		local var_5_5 = var_5_3 + 1

		if var_5_0[var_5_1] == nil then
			var_5_0[var_5_1] = {
				isNew = false,
				index = var_5_1,
				itemPath = iter_5_1.chapter_picture,
				title = iter_5_1.chapter_name,
				titleEn = iter_5_1.chapter_english,
				des = iter_5_1.chapter_preview,
				process = var_5_2 .. "/" .. var_5_5,
				unlockNum = var_5_2,
				allNum = var_5_5,
				limit = iter_5_1.unlock_condition,
				isUnlock = var_5_4,
				list = {}
			}
		end

		table.insert(var_5_0[var_5_1].list, {
			index = iter_5_0,
			title = iter_5_1.name,
			des = iter_5_1.section_preview,
			itemPath = "Photo/" .. iter_5_1.portrait .. ".png",
			limit = iter_5_1.unlock_condition,
			isUnlock = var_5_4,
			classification = iter_5_1.classification
		})

		var_5_0[var_5_1].process = var_5_2 .. "/" .. var_5_5
		var_5_0[var_5_1].unlockNum = var_5_2
		var_5_0[var_5_1].allNum = var_5_5
	end

	for iter_5_2 = 1, #var_5_0 do
		table.sort(var_5_0[iter_5_2].list, function(arg_6_0, arg_6_1)
			return arg_6_0.index < arg_6_1.index
		end)
	end

	return var_5_0
end

function SchoolCinemaManager:getNeedPhotoData3ByChapter()
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(photo_data) do
		if iter_7_1.unlock_level ~= nil then
			local var_7_1 = iter_7_1.chapter
			local var_7_2

			if var_7_0[iter_7_1.chapter] then
				var_7_2 = var_7_0[var_7_1].unlockNum or 0

				local var_7_3

				if var_7_0[var_7_1] then
					var_7_3 = var_7_0[var_7_1].allNum or 0
				end
			end

			local var_7_4 = false
			local var_7_5 = split(iter_7_1.unlock_level, "#")
			local var_7_6 = split(var_7_5[2], "-")
			local var_7_7 = tonumber(var_7_6[1])
			local var_7_8 = tonumber(var_7_6[2])

			if iter_7_1.pv or var_7_7 < playermodel.levelmode[tonumber(var_7_5[1])].status or var_7_7 <= tonumber(split(playermodel.levelmode[tonumber(var_7_5[1])].level, "-")[1]) and var_7_8 < tonumber(split(playermodel.levelmode[tonumber(var_7_5[1])].level, "-")[2]) then
				var_7_4 = true
			end

			if var_7_4 == true then
				var_7_2 = var_7_2 + 1
			end

			local var_7_11 = var_7_3 + 1
			local var_7_12 = not not (var_7_4 == true and (self.lastPlotId and iter_7_1.unlock_level > self.lastPlotId or self.lastPlotId == nil))

			if var_7_0[var_7_1] == nil then
				var_7_0[var_7_1] = {
					index = var_7_1,
					process = var_7_2 .. "/" .. var_7_11,
					unlockNum = var_7_2,
					allNum = var_7_11,
					list = {}
				}
			end

			table.insert(var_7_0[var_7_1].list, {
				index = iter_7_0,
				id = iter_7_1.unlock_level,
				title = iter_7_1.name,
				titleEn = iter_7_1.chapter_english,
				des = iter_7_1.section_preview,
				itemPath = "Photo/" .. iter_7_1.portrait .. ".png",
				limit = iter_7_1.unlock_condition,
				isUnlock = var_7_4,
				classification = iter_7_1.classification,
				isNew = var_7_12,
				chapterPath = iter_7_1.chapter_picture,
				chapterTitle = iter_7_1.chapter_name,
				chapterTitleEn = iter_7_1.chapter_english,
				chapterDes = iter_7_1.chapter_preview,
				pv = iter_7_1.pv
			})

			var_7_0[var_7_1].process = var_7_2 .. "/" .. var_7_11
			var_7_0[var_7_1].unlockNum = var_7_2
			var_7_0[var_7_1].allNum = var_7_11
		end
	end

	for iter_7_2 = 1, #var_7_0 do
		table.sort(var_7_0[iter_7_2].list, function(arg_8_0, arg_8_1)
			return arg_8_0.index < arg_8_1.index
		end)

		var_7_0[iter_7_2].itemPath = var_7_0[iter_7_2].list[1].chapterPath
		var_7_0[iter_7_2].title = var_7_0[iter_7_2].list[1].chapterTitle
		var_7_0[iter_7_2].titleEn = var_7_0[iter_7_2].list[1].chapterTitleEn
		var_7_0[iter_7_2].des = var_7_0[iter_7_2].list[1].chapterDes
		var_7_0[iter_7_2].limit = var_7_0[iter_7_2].list[1].limit
		var_7_0[iter_7_2].isUnlock = var_7_0[iter_7_2].list[1].isUnlock
		var_7_0[iter_7_2].isNew = var_7_0[iter_7_2].list[1].isNew
	end

	local var_7_13 = 0
	local var_7_14 = 0

	for iter_7_3 = 1, #var_7_0 do
		if var_7_0[iter_7_3] ~= nil then
			var_7_13 = var_7_13 + 1
			var_7_14 = var_7_14 + (var_7_0[iter_7_3].isUnlock and 1 or 0)
		end
	end

	var_7_0.process = var_7_14 .. "/" .. var_7_13
	var_7_0.unlockNum = var_7_14
	var_7_0.allNum = var_7_13
	var_7_0.photoInfo = {}

	for iter_7_4, iter_7_5 in pairs(postcard_data) do
		if iter_7_5.major == 0 then
			local var_7_15 = {
				isUnlock = true,
				index = i,
				title = iter_7_5.title,
				itemPath = "mainScenebg/postcard/" .. iter_7_5.image .. ".png",
				des = iter_7_5.info
			}

			var_7_15.posx = iter_7_5.offset_x or 0
			var_7_15.posy = iter_7_5.offset_y or 0

			table.insert(var_7_0.photoInfo, var_7_15)
		end
	end

	return var_7_0
end

function SchoolCinemaManager:getNeedPhotoData4ByChapter()
	local var_9_0 = {}
	local var_9_1 = 0
	local var_9_2 = 0

	for iter_9_0, iter_9_1 in pairs(major_factor_data) do
		local var_9_3 = iter_9_1.servant

		if servant_data[iter_9_1.servant] and (not servant_data[var_9_3].linkage or servant_data[var_9_3].linkage and playermodel.haveServant[var_9_3]) then
			local var_9_4 = servant_data[var_9_3] and servant_data[var_9_3].major
			local var_9_5 = favor_thing_data[var_9_4]
			local var_9_6 = playermodel.haveServant[var_9_3] == true and not playermodel:isServantLockByTime(var_9_3) or false

			if var_9_6 == true then
				var_9_1 = var_9_1 + 1
			end

			var_9_2 = var_9_2 + 1

			local var_9_7 = {
				favorList = {}
			}

			while var_9_5 and var_9_5["level_" .. 1] do
				local var_9_8 = playermodel.favor[var_9_4].favorlevel >= var_9_5["level_" .. 1]

				table.insert(var_9_7.favorList, {
					index = 1,
					limitLevel = "等级" .. var_9_5["level_" .. 1],
					title = var_9_5["des_" .. 1],
					classification = tonumber(var_9_5["classification_" .. 1]),
					drop = var_9_5["drop_" .. 1],
					isUnlock = var_9_8,
					limit = "好感度等级." .. var_9_5["level_" .. 1] .. "解锁"
				})
			end

			var_9_7.randomList = {}

			local var_9_10 = {}

			for iter_9_2, iter_9_3 in pairs(postcard_data) do
				if iter_9_3.major == var_9_4 then
					local var_9_11 = false
					local var_9_13

					for iter_9_4, iter_9_5 in pairs(travel_photo_data) do
						if iter_9_5.postcard_id == iter_9_2 then
							var_9_13 = iter_9_5

							break
						end
					end

					if var_9_13 and var_9_13.is_invalid ~= 1 and (not var_9_13.starttime or time_check_manager:getCurTime() >= os.time(parse_time(var_9_13.starttime))) and (var_9_13.isunlock == 1 or not var_9_13.isunlock and self.postcardTaskInfo[var_9_13.id]) then
						var_9_11 = true
					end

					if var_9_11 == false and iter_9_3.favorlevel ~= nil and playermodel.favor[var_9_4].favorlevel >= iter_9_3.favorlevel then
						var_9_11 = true
					end

					local var_9_15 = {
						unlockdes1 = "宿舍旅行事件解锁",
						index = iter_9_2,
						title = iter_9_3.title,
						itemPath = "mainScenebg/postcard/" .. iter_9_3.image .. ".png",
						isUnlock = var_9_11,
						des = iter_9_3.info
					}

					var_9_15.posx = iter_9_3.offset_x or 0
					var_9_15.posy = iter_9_3.offset_y or 0
					var_9_15.unlockdes2 = string.format("学员好感度%d级解锁", iter_9_3.favorlevel or 1)

					table.insert(var_9_10, var_9_15)
				end
			end

			var_9_7.randomList = var_9_10
			var_9_7.dreamList = {}

			local var_9_16 = {
				classification = 0,
				status = 1
			}

			for iter_9_6, iter_9_7 in pairs(photo_dream_data) do
				if iter_9_7.servant == var_9_3 then
					local var_9_18 = split(iter_9_7.unlock_level, "#")
					local var_9_19 = split(var_9_18[2], "-")
					local var_9_20 = tonumber(var_9_19[1])
					local var_9_21 = tonumber(var_9_19[2])

					var_9_16.status = ((iter_9_7.pv or var_9_20 < playermodel.levelmode[tonumber(var_9_18[1])].status or var_9_20 <= tonumber(split(playermodel.levelmode[tonumber(var_9_18[1])].level, "-")[1]) and var_9_21 < tonumber(split(playermodel.levelmode[tonumber(var_9_18[1])].level, "-")[2]) or nil) and true) == true and 3 or 2
					var_9_16.classification = iter_9_7.classification
					var_9_16.limit = iter_9_7.unlock_condition

					break
				end
			end

			var_9_7.dreamList = var_9_16

			table.insert(var_9_0, {
				index = var_9_6 == true and 1 or 0,
				sort = iter_9_1.sort,
				itemPath = "roleimage/role/shop_image/" .. iter_9_1.role_image .. ".png",
				title = iter_9_1.easy_name,
				isUnlock = var_9_6,
				list = var_9_7
			})
		end
	end

	table.sort(var_9_0, function(arg_10_0, arg_10_1)
		assert(arg_10_0.sort, string.format("info sort error,the major easy_name is %s", arg_10_0.title))
		assert(arg_10_1.sort, string.format("info sort error,the major easy_name is %s", arg_10_1.title))

		if arg_10_0.index ~= arg_10_1.index then
			return arg_10_0.index > arg_10_1.index
		else
			return arg_10_0.sort < arg_10_1.sort
		end
	end)

	var_9_0.unlockNum = var_9_1
	var_9_0.allNum = var_9_2
	var_9_0.process = var_9_1 .. "/" .. var_9_2

	return var_9_0
end

function SchoolCinemaManager:getNeedPhotoData5ByChapter()
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(activity_photo_data) do
		local var_11_1 = iter_11_1.chapter
		local var_11_2

		if var_11_0[iter_11_1.chapter] then
			var_11_2 = var_11_0[var_11_1].unlockNum or 0

			local var_11_3

			if var_11_0[var_11_1] then
				var_11_3 = var_11_0[var_11_1].allNum or 0
			end
		end

		local var_11_4 = true

		if true == true then
			var_11_2 = var_11_2 + 1
		end

		local var_11_5 = var_11_3 + 1
		local var_11_6 = false

		if var_11_0[var_11_1] == nil then
			var_11_0[var_11_1] = {
				index = var_11_1,
				itemPath = iter_11_1.chapter_picture,
				title = iter_11_1.chapter_name,
				titleEn = iter_11_1.chapter_english,
				des = iter_11_1.chapter_preview,
				process = var_11_2 .. "/" .. var_11_5,
				unlockNum = var_11_2,
				allNum = var_11_5,
				limit = iter_11_1.unlock_condition,
				isUnlock = var_11_4,
				isNew = var_11_6,
				list = {}
			}
		end

		local var_11_7 = {
			index = iter_11_0,
			title = iter_11_1.name,
			des = iter_11_1.section_preview
		}

		if iter_11_1.portrait then
			var_11_7.itemPath = "Photo/" .. iter_11_1.portrait .. ".png" or ""
		end

		var_11_7.limit = iter_11_1.unlock_condition
		var_11_7.isUnlock = var_11_4
		var_11_7.classification = iter_11_1.classification
		var_11_7.isNew = var_11_6

		table.insert(var_11_0[var_11_1].list, var_11_7)

		var_11_0[var_11_1].process = var_11_2 .. "/" .. var_11_5
		var_11_0[var_11_1].unlockNum = var_11_2
		var_11_0[var_11_1].allNum = var_11_5
	end

	for iter_11_2 = 1, #var_11_0 do
		table.sort(var_11_0[iter_11_2].list, function(arg_12_0, arg_12_1)
			return arg_12_0.index < arg_12_1.index
		end)
	end

	return var_11_0
end

function SchoolCinemaManager:getNeedPhotoData6ByChapter()
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(explore_photo_data) do
		local var_13_1 = iter_13_1.chapter
		local var_13_2

		if var_13_0[iter_13_1.chapter] then
			var_13_2 = var_13_0[var_13_1].unlockNum or 0

			local var_13_3

			if var_13_0[var_13_1] then
				var_13_3 = var_13_0[var_13_1].allNum or 0
			end
		end

		local var_13_4 = true

		if true == true then
			var_13_2 = var_13_2 + 1
		end

		local var_13_5 = var_13_3 + 1
		local var_13_6 = false

		if var_13_0[var_13_1] == nil then
			var_13_0[var_13_1] = {
				index = var_13_1,
				itemPath = iter_13_1.chapter_picture,
				title = iter_13_1.chapter_name,
				titleEn = iter_13_1.chapter_english,
				des = iter_13_1.chapter_preview,
				process = var_13_2 .. "/" .. var_13_5,
				unlockNum = var_13_2,
				allNum = var_13_5,
				limit = iter_13_1.unlock_condition,
				isUnlock = var_13_4,
				isNew = var_13_6,
				list = {}
			}
		end

		local var_13_7 = {
			index = iter_13_0,
			title = iter_13_1.name,
			des = iter_13_1.section_preview
		}

		if iter_13_1.portrait then
			var_13_7.itemPath = "Photo/" .. iter_13_1.portrait .. ".png" or ""
		end

		var_13_7.limit = iter_13_1.unlock_condition
		var_13_7.isUnlock = var_13_4
		var_13_7.classification = iter_13_1.classification
		var_13_7.isNew = var_13_6

		table.insert(var_13_0[var_13_1].list, var_13_7)

		var_13_0[var_13_1].process = var_13_2 .. "/" .. var_13_5
		var_13_0[var_13_1].unlockNum = var_13_2
		var_13_0[var_13_1].allNum = var_13_5
	end

	local var_13_8 = {}

	for iter_13_2, iter_13_3 in pairs(var_13_0) do
		table.insert(var_13_8, iter_13_3)
	end

	table.sort(var_13_8, function(arg_14_0, arg_14_1)
		return arg_14_0.index < arg_14_1.index
	end)

	for iter_13_4 = 1, #var_13_8 do
		if var_13_8[iter_13_4] and var_13_8[iter_13_4].list ~= nil then
			table.sort(var_13_8[iter_13_4].list, function(arg_15_0, arg_15_1)
				return arg_15_0.index < arg_15_1.index
			end)
		end
	end

	return var_13_8
end

function SchoolCinemaManager:initCinemaInfo(arg_16_1)
	self.cinemaInfo = {}
	self.cinemaInfo[3] = self:getNeedPhotoData3ByChapter()
	self.cinemaInfo[4] = self:getNeedPhotoData4ByChapter()
end

function SchoolCinemaManager:requestCinemaInfo(arg_17_1)
	network:rpc("get_main_plot_watched_info", nil, function(arg_18_0)
		if arg_18_0.result == 1 then
			self.lastPlotId = arg_18_0.lastplotid

			self:initCinemaInfo()

			if type(arg_17_1) == "function" then
				arg_17_1()
			end
		end
	end)
end

function SchoolCinemaManager:doPlayerStoryPlot(arg_19_1, arg_19_2)
	network:rpc("do_player_story_plot", {
		unlocklevel = arg_19_1.unlocklevel
	}, function(arg_20_0)
		if arg_20_0.result == 1 then
			self.lastPlotId = arg_19_1.unlocklevel
			self.cinemaInfo[arg_19_1.index][arg_19_1.dIndex].list[arg_19_1.cIndex].isNew = false

			local var_20_0 = false

			for iter_20_0, iter_20_1 in pairs(self.cinemaInfo[arg_19_1.index][arg_19_1.dIndex].list) do
				if iter_20_1.isNew == true then
					var_20_0 = true

					break
				end
			end

			self.cinemaInfo[arg_19_1.index][arg_19_1.dIndex].isNew = var_20_0

			if type(arg_19_2) == "function" then
				arg_19_2()
			end
		elseif arg_20_0.result == 2 then
			global_ShowBlockWords("观看剧情失败")
		elseif arg_20_0.result == 3 then
			global_ShowBlockWords("剧情未解锁")
		end
	end)
end

function SchoolCinemaManager:requestPostCardTaskInfo(arg_21_1)
	local bit = require("bit")

	self.postcardTaskInfo = {}

	network:rpc("get_travel_list", nil, function(arg_22_0)
		if arg_22_0.travel.photoCoding then
			for iter_22_0, iter_22_1 in pairs(travel_photo_data) do
				if iter_22_1.order ~= nil then
					local var_22_1 = math.floor((iter_22_1.order - 1) / 30) + 1

					if arg_22_0.travel.photoCoding[var_22_1] and bit.band(arg_22_0.travel.photoCoding[var_22_1], 2^((iter_22_1.order - 1) % 30 + 1 - 1)) > 0 then
						self.postcardTaskInfo[iter_22_1.order] = 1
					end
				end
			end
		end

		if arg_21_1 then
			arg_21_1()
		end
	end)
end

function SchoolCinemaManager:getCinemaInfo(arg_23_1)
	if arg_23_1 == nil then
		return self.cinemaInfo
	else
		if self.cinemaInfo[arg_23_1] == nil and arg_23_1 == 1 then
			self.cinemaInfo[1] = self:getNeedPhotoData1ByChapter()
		elseif self.cinemaInfo[arg_23_1] == nil and arg_23_1 == 2 then
			self.cinemaInfo[2] = self:getNeedPhotoData2ByChapter()
		elseif self.cinemaInfo[arg_23_1] == nil and arg_23_1 == 3 then
			self.cinemaInfo[3] = self:getNeedPhotoData3ByChapter()
		elseif self.cinemaInfo[arg_23_1] == nil and arg_23_1 == 4 then
			self.cinemaInfo[4] = self:getNeedPhotoData4ByChapter()
		elseif self.cinemaInfo[arg_23_1] == nil and arg_23_1 == 5 then
			self.cinemaInfo[5] = self:getNeedPhotoData5ByChapter()
		elseif self.cinemaInfo[arg_23_1] == nil and arg_23_1 == 6 then
			self.cinemaInfo[6] = self:getNeedPhotoData6ByChapter()
		end

		return self.cinemaInfo[arg_23_1]
	end
end

function SchoolCinemaManager:clearInfo()
	self.cinemaInfo = nil
end

return SchoolCinemaManager
