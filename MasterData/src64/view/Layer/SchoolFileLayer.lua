SchoolFileLayer = class("SchoolFileLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = {
	"SchoolFileLayer/btn_view_unlock.png",
	"SchoolFileLayer/btn_view_all.png",
	"SchoolFileLayer/btn_view_boss.png"
}
local var_0_1 = {
	"学员",
	"魂器",
	"势力",
	"超频",
	"羁绊"
}
local var_0_2 = {
	photofile_nightmare_xmasfile_data = 5,
	photofile_npcfiles_data = 3,
	photofile_ai2_data = 7,
	photofile_ai1_data = 6,
	photofile_foundationai_data = 14,
	photofile_ai5_data = 10,
	photofile_ai3_data = 8,
	photofile_military_data = 11,
	photofile_data = 1,
	photofile_foundation_data = 13,
	photofile_militaryai_data = 12,
	photofile_killer_data = 15,
	photofile_ai4_data = 9,
	profile_overclock_data = 16,
	photofile_xmasfile_data = 4,
	photofile_HelpGirl_data = 2
}
local var_0_3 = {
	"file_player",
	"file_weapon",
	"file_teacher",
	"file_enemy1",
	"file_nightmare_xmasfile",
	"file_enemy2",
	"file_enemy3",
	"file_enemy4",
	"file_enemy5",
	"file_enemy11",
	"file_enemy6",
	"file_enemy7",
	"file_enemy8",
	"file_enemy9",
	"file_enemy10",
	"file_overclock"
}
local var_0_4 = {
	FILE_HORCRUX = 2,
	FILE_AI1 = 6,
	FILE_AI4 = 9,
	FILE_NPC = 3,
	FILE_XMAS = 4,
	FILE_FOUNDATION = 13,
	FILE_AI2 = 7,
	FILE_NIGHTMARE_XMAS = 5,
	FILE_AI5 = 10,
	FILE_MILITARY_AI = 12,
	FILE_MILITARY = 11,
	FILE_FOUNDATION_AI = 14,
	FILE_AI3 = 8,
	FILE_KILLER = 15,
	FILE_STUDENT = 1,
	FILE_OVERCLICK = 16
}
local var_0_5 = {
	[var_0_4.FILE_XMAS] = 1,
	[var_0_4.FILE_NIGHTMARE_XMAS] = 11,
	[var_0_4.FILE_AI1] = 2,
	[var_0_4.FILE_AI2] = 3,
	[var_0_4.FILE_AI3] = 4,
	[var_0_4.FILE_AI4] = 5,
	[var_0_4.FILE_AI5] = 12,
	[var_0_4.FILE_MILITARY] = 6,
	[var_0_4.FILE_MILITARY_AI] = 7,
	[var_0_4.FILE_FOUNDATION] = 8,
	[var_0_4.FILE_FOUNDATION_AI] = 9,
	[var_0_4.FILE_KILLER] = 10
}
local var_0_6 = {
	{
		MASK = "SchoolFileLayer/student/mask.png",
		UNHAVE_MASK = "SchoolFileLayer/student/unhave_mask.png"
	},
	{
		MASK = "SchoolFileLayer/horcrux/mask.png",
		UNHAVE_MASK = "SchoolFileLayer/horcrux/unhave_mask.png"
	},
	{
		UNHAVE_MASK = {
			"SchoolFileLayer/power/unhave_mask1.png",
			"SchoolFileLayer/power/unhave_mask2.png",
			"SchoolFileLayer/power/unhave_mask3.png",
			"SchoolFileLayer/power/unhave_mask4.png",
			"SchoolFileLayer/power/unhave_mask5.png"
		},
		MASK = {
			"SchoolFileLayer/power/mask1.png",
			"SchoolFileLayer/power/mask2.png",
			"SchoolFileLayer/power/mask3.png",
			"SchoolFileLayer/power/mask4.png",
			"SchoolFileLayer/power/mask5.png"
		}
	},
	{
		MASK = "",
		UNHAVE_MASK = "SchoolFileLayer/overclock/unhave_mask.png"
	}
}
local var_0_7 = {
	nil,
	nil,
	4,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	2,
	2,
	3,
	3,
	5
}
local var_0_8 = {
	{
		namefont = 20,
		playerscale = 0.6,
		namepos = cc.p(80, 20),
		namecolor = cc.c3b(255, 255, 255),
		playerpos = cc.p(0, -25),
		maskpos = cc.p(-78, -109),
		clippos = cc.p(0, 0)
	},
	{
		namefont = 20,
		playerscale = 0.6,
		namepos = cc.p(80, 228),
		namecolor = cc.c3b(255, 255, 255),
		playerpos = cc.p(0, -25),
		maskpos = cc.p(-77, -126),
		clippos = cc.p(0, 0)
	},
	{
		namefont = 20,
		playerscale = 0.6,
		namepos = cc.p(80, 220),
		namecolor = cc.c3b(255, 255, 255),
		playerpos = cc.p(0, -25),
		maskpos = cc.p(-78, -121),
		clippos = cc.p(0, 5)
	},
	{
		namefont = 20,
		playerscale = 0.65,
		namebgishave = true,
		namepos = cc.p(80, 35),
		namecolor = cc.c3b(255, 255, 255),
		playerpos = cc.p(0, -25),
		maskpos = cc.p(-80, -116),
		clippos = cc.p(0, -5)
	},
	{
		namefont = 20,
		playerscale = 0.6,
		namepos = cc.p(80, 48),
		namecolor = cc.c3b(226, 226, 246),
		playerpos = cc.p(0, -25),
		maskpos = cc.p(-80, -130),
		clippos = cc.p(0, 22)
	}
}
local var_0_9 = {
	{
		namefont = 20,
		playerscale = 0.5,
		namepos = cc.p(80, 20),
		namecolor = cc.c3b(255, 255, 255),
		playerpos = cc.p(0, 0),
		maskpos = cc.p(-78, -109),
		clippos = cc.p(0, 0)
	},
	{
		namefont = 20,
		playerscale = 0.5,
		namepos = cc.p(80, 228),
		namecolor = cc.c3b(255, 255, 255),
		playerpos = cc.p(0, 0),
		maskpos = cc.p(-77, -126),
		clippos = cc.p(0, 0)
	},
	{
		namefont = 20,
		playerscale = 0.6,
		namepos = cc.p(80, 220),
		namecolor = cc.c3b(255, 255, 255),
		playerpos = cc.p(0, 0),
		maskpos = cc.p(-77, -121),
		clippos = cc.p(0, 5)
	},
	{
		namefont = 20,
		playerscale = 0.65,
		namepos = cc.p(80, 35),
		namecolor = cc.c3b(255, 255, 255),
		playerpos = cc.p(0, 5),
		maskpos = cc.p(-80, -116),
		clippos = cc.p(0, -5)
	},
	{
		namefont = 20,
		playerscale = 0.6,
		namepos = cc.p(80, 35),
		namecolor = cc.c3b(226, 226, 246),
		playerpos = cc.p(0, -25),
		maskpos = cc.p(-80, -116),
		clippos = cc.p(0, 5)
	}
}

require("data.constants")

local photo_manager = require("controller.photo_manager")
local account_manager = require("controller.account_manager")
local horcrux_data = require("data.horcrux_data")
local playermodel = require("model.playermodel")
local servant_data = require("data.servant_data")
local level_manager = require("controller.level_manager")
local hexie_manager = require("controller.hexie_manager")
local photofile_all_data = require("data.photofile_all_data")
local model_data = require("data.model_data")
local var_0_19 = config._DEBUG and 0 or 1
local var_0_20 = "ALL"
local var_0_21 = "UNLOCK"

function SchoolFileLayer.create(arg_2_0)
	return (SchoolFileLayer.new())
end

function SchoolFileLayer:getCListInfo(arg_3_1, arg_3_2)
	local var_3_0 = ""
	local var_3_1 = ""
	local var_3_2 = ""
	local var_3_3 = arg_3_2.model_id
	local var_3_4 = false
	local var_3_5 = 1
	local var_3_6 = 0
	local var_3_7 = 0
	local var_3_8 = cc.p(0.5, 0.5)
	local var_3_9 = 1
	local var_3_10 = 1
	local var_3_11 = 1
	local var_3_12 = 1
	local var_3_13 = ""
	local var_3_14 = false
	local var_3_15 = 0
	local var_3_16 = false

	if arg_3_1 == nil or var_0_2[arg_3_1] == nil or arg_3_2 == nil then
		return
	end

	local var_3_17 = var_0_2[arg_3_1]

	if var_0_2[arg_3_1] == var_0_4.FILE_STUDENT then
		var_3_0 = "roleimage/role/shop_image/" .. model_data[var_3_3].role_image .. ".png"
		var_3_1 = arg_3_2.easy_name
		var_3_2 = arg_3_2.title
		var_3_6 = 0
		var_3_7 = 0
		var_3_8 = cc.p(0.5, 0.8)
		var_3_4 = not playermodel.haveServant[tonumber(arg_3_2.servant_id)]
		var_3_9 = arg_3_2.sort
		var_3_10 = arg_3_2.id
		var_3_11 = arg_3_2.servant_id
		var_3_12 = servant_data[tonumber(arg_3_2.servant_id)].roll_rarity - 1 or 1
		var_3_13 = "SchoolFileLayer/student/di_item" .. var_3_12 .. ".png"
		var_3_14 = not not playermodel.newservantsArchives[tonumber(var_3_11)]
		var_3_15 = arg_3_2.class
	elseif var_3_17 == var_0_4.FILE_HORCRUX then
		var_3_0 = "roleimage/role1/" .. model_data[var_3_3].cute_role .. ".png"
		var_3_1 = arg_3_2.name
		var_3_4 = self.basicInfo.haveHorcrux[horcrux_data[arg_3_2.item_id].horcruxtype] ~= true or false
		var_3_5 = 1
		var_3_6 = arg_3_2.offset_x or 0
		var_3_7 = arg_3_2.offset_y or 0
		var_3_7 = var_3_7 - 12
		var_3_9 = arg_3_2.sort
		var_3_10 = arg_3_2.id
		var_3_15 = arg_3_2.class
		var_3_12 = horcrux_data[arg_3_2.item_id].rarity - 1 or 1
		var_3_13 = "SchoolFileLayer/horcrux/di_item" .. var_3_12 .. ".png"
	elseif var_3_17 == var_0_4.FILE_NPC or var_3_17 == var_0_4.FILE_XMAS or var_3_17 == var_0_4.FILE_MILITARY or var_3_17 == var_0_4.FILE_FOUNDATION or var_3_17 == var_0_4.FILE_KILLER or var_3_17 == var_0_4.FILE_NIGHTMARE_XMAS then
		var_3_0 = "roleimage/role/shop_image/" .. model_data[var_3_3].role_image .. ".png"
		var_3_1 = arg_3_2.name
		var_3_4 = var_3_17 ~= var_0_4.FILE_NPC and not level_manager:isPlayerPassLevel(arg_3_2.first_fight)
		var_3_5 = 1
		var_3_8 = cc.p(0.48, 0.75)
		var_3_6 = 0
		var_3_7 = 0
		var_3_9 = arg_3_2.sort
		var_3_10 = arg_3_2.id
		var_3_15 = arg_3_2.class
		var_3_12 = var_0_7[var_3_17] or 1
		var_3_13 = "SchoolFileLayer/power/di_item" .. var_3_12 .. ".png"
	elseif var_3_17 >= var_0_4.FILE_AI1 and var_3_17 <= var_0_4.FILE_AI5 or var_3_17 == var_0_4.FILE_MILITARY_AI or var_3_17 == var_0_4.FILE_FOUNDATION_AI then
		var_3_0 = "roleimage/role1/" .. model_data[var_3_3].cute_role .. ".png"
		var_3_1 = arg_3_2.name
		var_3_4 = not level_manager:isPlayerPassLevel(arg_3_2.first_fight) or false
		var_3_5 = 1
		var_3_8 = cc.p(0.48, 0.75)
		var_3_6 = 0
		var_3_7 = 0
		var_3_9 = arg_3_2.sort
		var_3_10 = arg_3_2.id
		var_3_15 = arg_3_2.class
		var_3_12 = var_0_7[var_3_17] or 1
		var_3_13 = "SchoolFileLayer/power/di_item" .. var_3_12 .. ".png"
		var_3_16 = true
	elseif var_3_17 == var_0_4.FILE_OVERCLICK then
		var_3_0 = "roleimage/role/shop_image/" .. model_data[var_3_3].role_image .. ".png"
		var_3_1 = arg_3_2.easy_name
		var_3_2 = arg_3_2.title
		var_3_6 = 20
		var_3_7 = 0
		var_3_8 = cc.p(0.5, 0.8)

		local var_3_18 = playermodel.soulOverClock[tonumber(arg_3_2.servant_id)]

		var_3_4 = not var_3_18 or var_3_18 < 1
		var_3_9 = arg_3_2.sort
		var_3_10 = arg_3_2.id
		var_3_11 = arg_3_2.servant_id
		var_3_12 = servant_data[tonumber(arg_3_2.servant_id)].roll_rarity - 1 or 1
		var_3_13 = "SchoolFileLayer/overclock/di_item" .. var_3_12 .. ".png"
		var_3_14 = false
		var_3_15 = arg_3_2.class
	else
		var_3_0 = "roleimage/role/shop_image/" .. model_data[var_3_3].role_image .. ".png"
		var_3_15 = arg_3_2.class
	end

	return {
		typePath = "",
		id = var_3_10,
		modelId = var_3_3,
		servantId = var_3_11,
		sort = var_3_9,
		rarity = var_3_12,
		class = var_3_15,
		name = var_3_1,
		rolePath = var_3_0,
		roleScale = var_3_5,
		roleOffSetX = var_3_6,
		roleOffSetY = var_3_7,
		anchorPoint = var_3_8,
		title = var_3_2,
		isNew = var_3_14,
		isLock = var_3_4,
		rarityPath = var_3_13,
		isAi = var_3_16
	}
end

function SchoolFileLayer:initBasicInfo()
	self.basicInfo = {}
	self.basicInfo.haveHorcrux = {}

	for iter_4_0, iter_4_1 in pairs(playermodel.items) do
		if iter_4_1.itemtype == kITEM_HORCRUX then
			self.basicInfo.haveHorcrux[horcrux_data[iter_4_1.itemid].horcruxtype] = self.basicInfo.haveHorcrux[horcrux_data[iter_4_1.itemid].horcruxtype] or true
		end
	end
end

function SchoolFileLayer:initInfo(arg_5_1, arg_5_2)
	self.allRoleInfo = {}
	self.allRoleInfo.index = arg_5_1 or 1
	self.allRoleInfo.curPanelInfo = {}

	local var_5_0 = {}
	local var_5_1 = 1

	while photofile_all_data[self.allRoleInfo.index]["data_name" .. var_5_1] do
		local var_5_2 = photofile_all_data[self.allRoleInfo.index]["data_name" .. var_5_1]
		local var_5_3 = var_0_3[var_0_2[photofile_all_data[self.allRoleInfo.index]["data_name" .. var_5_1]]]
		local var_5_4 = require("data." .. photofile_all_data[self.allRoleInfo.index]["data_name" .. var_5_1])

		if var_0_4.FILE_STUDENT == var_0_2[photofile_all_data[self.allRoleInfo.index]["data_name" .. var_5_1]] then
			for iter_5_0, iter_5_1 in pairs(var_5_4) do
				if (not servant_data[tonumber(iter_5_1.servant_id)].linkage or servant_data[tonumber(iter_5_1.servant_id)].linkage and playermodel.haveServant[tonumber(iter_5_1.servant_id)]) and not playermodel:isServantLockByTime(tonumber(iter_5_1.servant_id)) and (self.select_buttonMode == var_0_20 or playermodel.haveServant[tonumber(iter_5_1.servant_id)] and self.select_buttonMode == var_0_21) then
					local var_5_5 = self:getCListInfo(var_5_2, iter_5_1)

					var_5_5.index = #var_5_0 + 1
					var_5_5.contentType = var_5_3
					var_5_5.fileType = var_0_2[var_5_2]

					table.insert(var_5_0, var_5_5)
				end
			end
		elseif var_0_4.FILE_HORCRUX == var_0_2[var_5_2] then
			local var_5_6 = account_manager:getChannel()

			for iter_5_2, iter_5_3 in pairs(var_5_4) do
				if iter_5_3.show_channel and var_5_6 == iter_5_3.show_channel or not iter_5_3.show_channel then
					local var_5_7 = self:getCListInfo(var_5_2, iter_5_3)

					var_5_7.index = #var_5_0 + 1
					var_5_7.contentType = var_5_3
					var_5_7.fileType = var_0_2[var_5_2]

					table.insert(var_5_0, var_5_7)
				end
			end
		elseif var_0_4.FILE_NPC == var_0_2[var_5_2] then
			for iter_5_4, iter_5_5 in pairs(var_5_4) do
				local var_5_8 = self:getCListInfo(var_5_2, iter_5_5)

				var_5_8.index = #var_5_0 + 1
				var_5_8.contentType = var_5_3
				var_5_8.fileType = var_0_2[var_5_2]
				var_5_8.isBoss = true

				table.insert(var_5_0, var_5_8)
			end
		elseif var_0_4.FILE_OVERCLICK == var_0_2[var_5_2] then
			for iter_5_6, iter_5_7 in pairs(var_5_4) do
				if (not servant_data[tonumber(iter_5_7.servant_id)].linkage or servant_data[tonumber(iter_5_7.servant_id)].linkage and playermodel.haveServant[tonumber(iter_5_7.servant_id)]) and not playermodel:isServantLockByTime(tonumber(iter_5_7.servant_id)) and (self.select_buttonMode == var_0_20 or playermodel.haveServant[tonumber(iter_5_7.servant_id)] and self.select_buttonMode == var_0_21) and iter_5_7.overclock == 1 and not playermodel:isServantOverclockLockByTime(tonumber(iter_5_7.servant_id)) then
					local var_5_9 = self:getCListInfo(var_5_2, iter_5_7)

					var_5_9.index = #var_5_0 + 1
					var_5_9.contentType = var_5_3
					var_5_9.fileType = var_0_2[var_5_2]

					table.insert(var_5_0, var_5_9)
				end
			end
		else
			for iter_5_8, iter_5_9 in pairs(var_5_4) do
				local var_5_10 = var_5_3 == "file_enemy1" or var_5_3 == "file_enemy6" or var_5_3 == "file_enemy8" or var_5_3 == "file_enemy10" or var_5_3 == "file_nightmare_xmasfile"

				if var_5_10 == true and self.select_buttonMode == var_0_21 or self.select_buttonMode == var_0_20 then
					local var_5_11 = self:getCListInfo(var_5_2, iter_5_9)

					var_5_11.index = #var_5_0 + 1
					var_5_11.contentType = var_5_3
					var_5_11.isBoss = var_5_10
					var_5_11.fileType = var_0_2[var_5_2]

					table.insert(var_5_0, var_5_11)
				end
			end
		end

		var_5_1 = var_5_1 + 1
	end

	local var_5_12 = {
		totalNum = #var_5_0
	}

	var_5_12.unlockNum = 0

	for iter_5_10 = 1, #L_SCHOOL_FILE_LIST_NAME[self.allRoleInfo.index] do
		local var_5_13 = 0
		local var_5_14 = {}

		for iter_5_11, iter_5_12 in pairs(var_5_0) do
			if iter_5_12.class == iter_5_10 then
				if iter_5_12.isLock == false and self.select_buttonMode == var_0_20 then
					var_5_13 = var_5_13 + 1

					table.insert(var_5_14, iter_5_12)
				elseif iter_5_12.isLock == false and self.select_buttonMode == var_0_21 then
					var_5_13 = var_5_13 + 1

					table.insert(var_5_14, iter_5_12)
				elseif iter_5_12.isLock == true and self.select_buttonMode == var_0_20 then
					table.insert(var_5_14, iter_5_12)
				elseif iter_5_12.isLock == true and self.select_buttonMode == var_0_21 and iter_5_12.isBoss == true then
					table.insert(var_5_14, iter_5_12)
				end
			end
		end

		var_5_12.unlockNum = var_5_12.unlockNum + var_5_13

		local var_5_15 = #var_5_14
		local var_5_16 = var_5_13

		if arg_5_1 == 1 then
			table.sort(var_5_14, function(arg_6_0, arg_6_1)
				if arg_6_0.rarity ~= arg_6_1.rarity then
					return arg_6_0.rarity > arg_6_1.rarity
				else
					return arg_6_0.id > arg_6_1.id
				end
			end)
		else
			table.sort(var_5_14, function(arg_7_0, arg_7_1)
				return arg_7_0.sort < arg_7_1.sort
			end)
		end

		local var_5_17 = {
			index = iter_5_10
		}

		var_5_17.title = L_SCHOOL_FILE_LIST_NAME[self.allRoleInfo.index][iter_5_10] or "测试" .. iter_5_10
		var_5_17.list = var_5_14
		var_5_17.totalNum = var_5_15
		var_5_17.unlockNum = var_5_16

		if #var_5_14 > 0 then
			table.insert(var_5_12, var_5_17)
		end
	end

	self.allRoleInfo.curPanelInfo = var_5_12

	if type(arg_5_2) == "function" then
		arg_5_2()
	end
end

function SchoolFileLayer.getAllFileInfo(arg_8_0, arg_8_1)
	local var_8_0 = {}

	if arg_8_1 == var_0_4.FILE_STUDENT or arg_8_1 == var_0_4.FILE_OVERCLICK then
		photo_manager:initGirlData()

		var_8_0 = photo_manager:getGirlData()
	elseif arg_8_1 == var_0_4.FILE_HORCRUX then
		photo_manager:initHelpGirlData()

		var_8_0 = photo_manager:getHelpGirlData()
	elseif arg_8_1 == var_0_4.FILE_NPC then
		photo_manager:initTeacherData()

		var_8_0 = photo_manager:getTeacherData()
	else
		photo_manager:initEnemyData()

		var_8_0 = photo_manager:getEnemyData(var_0_5[arg_8_1] or 1)
	end

	return var_8_0
end

function SchoolFileLayer:setTglContainerCallback(arg_9_1, arg_9_2)
	if arg_9_1 == nil then
		return
	end

	self.toggleContainer = {}
	arg_9_2 = arg_9_2 or 1

	local function var_9_0(arg_10_0, arg_10_1)
		if arg_10_1 == arg_10_0.isShow then
			return
		end

		local var_10_0 = arg_10_0:getChildByName("click")

		if arg_10_0.isShow == true then
			arg_10_0.isShow = false

			var_10_0:setVisible(false)
		else
			arg_10_0.isShow = true

			var_10_0:setVisible(true)

			self.select_buttonMode = var_0_20

			self:initInfo(arg_10_0.index, function()
				self:initPanel()
			end)
		end
	end

	local function var_9_1(arg_12_0)
		if arg_12_0 == 5 then
			LayerManager:pushInLayer("BondLayer")

			return
		end

		for iter_12_0 = 1, #self.toggleContainer do
			if arg_12_0 == iter_12_0 then
				var_9_0(self.toggleContainer[iter_12_0], true)
			else
				var_9_0(self.toggleContainer[iter_12_0], false)
			end
		end
	end

	local var_9_2 = 1
	local var_9_3 = {}

	while self.toggleContainerNode:getChildByName("toggle" .. var_9_2) do
		local var_9_4 = self.toggleContainerNode:getChildByName("toggle" .. var_9_2)

		var_9_4:setVisible(var_0_1[var_9_2] ~= nil)

		if var_0_1[var_9_2] == "超频" and not hexie_manager:canShowAllPhoto() then
			var_9_4:setVisible(false)
		end

		if var_0_1[var_9_2] == "势力" and not hexie_manager:canShowAllPhoto() then
			var_9_4:setVisible(false)
		end

		if var_0_1[var_9_2] == "魂器" and not hexie_manager:canShowAllPhoto() then
			var_9_4:setVisible(false)
		end

		var_9_4.index = var_9_2
		var_9_4.isShow = false

		var_9_4:addTouchEventListener(function(arg_13_0, arg_13_1)
			if arg_13_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_9_1(arg_13_0.index)
		end)
		var_9_4:getChildByName("click"):setVisible(false)

		self.toggleContainer[var_9_2] = var_9_4
		var_9_2 = var_9_2 + 1

		if var_9_4:isVisible() then
			table.insert(var_9_3, var_9_4)
		end
	end

	for iter_9_0, iter_9_1 in ipairs(var_9_3) do
		iter_9_1:setPositionX(516 - 110 * (#var_9_3 - iter_9_0))
	end

	var_9_1(arg_9_2)
end

function SchoolFileLayer:ctor()
	local var_14_0 = cc.EventCustom:new("showTopBottomLayer")

	var_14_0.showconfig = {
		ListButtonLayer = false,
		TopcostLayer = false
	}

	cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_14_0)
	self:initBasicInfo()

	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "SchoolFileLayer.json" or "SchoolFileLayer.ExportJson")

	self:addChild(self.rootlayer)

	self.imgTopLine = ccui.Helper:seekWidgetByName(self.rootlayer, "num_line")

	self.imgTopLine:setScale(0.7)

	self.titleNode = self.rootlayer:getChildByName("title")
	self.unlockNumNode = self.rootlayer:getChildByName("unlock_num")

	self.unlockNumNode:setScale(0.7)

	self.allNumNode = self.rootlayer:getChildByName("all_num")

	self.allNumNode:setScale(0.7)

	self.itemNode = self.rootlayer:getChildByName("item")
	self.itemContentNode = self.rootlayer:getChildByName("itemContent")
	self.btn_view = self.rootlayer:getChildByName("Button_view_all")
	self.select_buttonMode = var_0_20
	self.labelInfo = ccui.Text:create("", FONT_NAME, 20)

	self.allNumNode:getParent():addChild(self.labelInfo)
	self.labelInfo:setLocalZOrder(10)
	self.labelInfo:setAnchorPoint(0, 0.5)
	self.labelInfo:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_LEFT)
	self.labelInfo:setPosition(self.allNumNode:getPositionX() - 240, self.allNumNode:getPositionY() + 10)
	self.btn_view:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.select_buttonMode = self.select_buttonMode == var_0_20 and var_0_21 or var_0_20

		self:updateBtnView()
		self:initInfo(self.allRoleInfo.index, function()
			self:initPanel()
		end)
	end)

	self.btn_return = self.rootlayer:getChildByName("Button_return")

	self.btn_return:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		playermodel:playerOpenNewServantArchives()
		photo_manager:releaseAllData()
		self:layerOutAni(function()
			KeyCodeManager:onKeyReleasedCallFunc()
		end)
	end)
	self.btn_return:setLocalZOrder(999)
	self:initItemNodePool()

	self.toggleContainerNode = self.rootlayer:getChildByName("toggleContainer")

	self.toggleContainerNode:setLocalZOrder(1)
	self:setTglContainerCallback(self.toggleContainerNode, 1)
	self:registerScriptHandler(function(arg_19_0)
		if arg_19_0 == "exit" then
			self:clearItemNodePool()
		end
	end)
	self:fullScreen()
end

function SchoolFileLayer:clearItemNodePool()
	for iter_20_0 = 1, self.itemNodePool.totalNum do
		local var_20_0 = self.itemNodePool[iter_20_0]:getReferenceCount()

		if self.itemNodePool[iter_20_0] and var_20_0 > 0 then
			for iter_20_1 = 1, var_20_0 do
				self.itemNodePool[iter_20_0]:release()
			end
		end
	end

	self.itemNodePool = {}
end

function SchoolFileLayer:initItemNodePool()
	self.itemNodePool = {}
	self.itemNodePool.limitNum = 50
	self.itemNodePool.totalNum = 0

	function self.itemNodePool.get()
		local var_22_0

		if self.itemNodePool.totalNum > 0 then
			var_22_0 = table.remove(self.itemNodePool)
			self.itemNodePool.totalNum = math.max(self.itemNodePool.totalNum - 1, 0)
		else
			var_22_0 = self.itemNode:clone()
		end

		var_22_0.isHaveInit = false

		return var_22_0
	end

	function self.itemNodePool:put()
		if self and self.itemNodePool.totalNum < self.itemNodePool.limitNum then
			self:retain()
			table.insert(self.itemNodePool, self)

			self.itemNodePool.totalNum = self.itemNodePool.totalNum + 1
		end

		self:removeFromParent()
	end

	for iter_21_0 = 1, 20 do
		self.itemNodePool.put((self.itemNode:clone()))
	end
end

function SchoolFileLayer:updateBtnView()
	local var_24_0 = var_0_0[1]

	var_24_0 = self.select_buttonMode == var_0_20 and self.allRoleInfo.index ~= 3 and var_0_0[1] or self.select_buttonMode == var_0_21 and var_0_0[2] or var_0_0[3]

	self.btn_view:loadTextures(var_24_0, var_24_0, var_24_0, var_0_19)
end

function SchoolFileLayer:initItemNode(arg_25_1, arg_25_2)
	if arg_25_1 == nil or arg_25_2 == nil then
		return
	end

	if arg_25_1:getChildByName("mask") then
		arg_25_1:getChildByName("mask"):removeFromParent()
	end

	if arg_25_1:getChildByName("Panel_roleImage"):getChildByName("clip") then
		arg_25_1:getChildByName("Panel_roleImage"):getChildByName("clip"):removeFromParent()
	end

	if arg_25_1:getChildByName("Panel_roleImage"):getChildByName("player") then
		arg_25_1:getChildByName("Panel_roleImage"):getChildByName("player"):removeFromParent()
	end

	if arg_25_1:getChildByName("name_bg") then
		arg_25_1:getChildByName("name_bg"):removeFromParent()
	end

	if arg_25_1:getChildByName("name") then
		arg_25_1:getChildByName("name"):removeFromParent()
	end

	if arg_25_1:getChildByName("title") then
		arg_25_1:getChildByName("title"):removeFromParent()
	end

	local var_25_0 = arg_25_1:getChildByName("Panel_roleImage")

	var_25_0:setContentSize(cc.size(arg_25_1:getContentSize().width, arg_25_1:getContentSize().height))

	local var_25_1 = var_25_0:getContentSize().width
	local var_25_2 = var_25_0:getContentSize().height
	local var_25_3 = arg_25_1:getChildByName("new")

	if var_25_3 == nil then
		var_25_3 = ccui.ImageView:create("SchoolFileLayer/new.png", var_0_19)

		var_25_3:setName("new")
		arg_25_1:addChild(var_25_3)
	end

	var_25_3:setPosition(cc.p(var_25_1 - 35, var_25_2 - 40))
	var_25_3:setVisible(arg_25_2.isNew == true)

	local var_25_4 = ccui.ImageView:create((self.allRoleInfo.index == 3 or nil) and (var_0_6[self.allRoleInfo.index].UNHAVE_MASK[arg_25_2.rarity] or var_0_6[self.allRoleInfo.index].UNHAVE_MASK), var_0_19)

	var_25_4:setName("mask")
	var_25_4:setAnchorPoint(cc.p(0, 0))

	local var_25_5 = arg_25_1:getChildByName("title_di")

	var_25_5:setPosition(cc.p(83, 61))
	arg_25_1:addChild(var_25_4, 2)

	local var_25_6 = ccui.Text:create(arg_25_2.title, FONT_NAME, 18)

	var_25_6:setPosition(cc.p(85, 61))
	var_25_6:setName("title")
	var_25_6:setAnchorPoint(cc.p(0.5, 0.5))
	arg_25_1:addChild(var_25_6, 1)

	local var_25_7 = ccui.Text:create(arg_25_2.name, FONT_NAME, 20)

	var_25_7:setName("name")
	arg_25_1:addChild(var_25_7, 1)
	var_25_4:setVisible(arg_25_2.isLock == true)

	if self.allRoleInfo.index ~= 4 then
		if self.allRoleInfo.index == 3 then
			local var_25_8 = var_0_6[self.allRoleInfo.index].MASK[arg_25_2.rarity] or var_0_6[self.allRoleInfo.index].MASK
			local var_25_9

			if config._DEBUG then
				var_25_9 = cc.Sprite:create(var_25_8) or cc.Sprite:createWithSpriteFrameName(var_25_8)
			end
		end

		local var_25_10 = cc.Sprite:create(arg_25_2.rolePath)

		var_25_10:setName("player")

		local var_25_11 = cc.ClippingNode:create(var_25_9)

		var_25_11:setName("clip")
		var_25_11:setAlphaThreshold(0)
		var_25_11:addChild(var_25_10)
		var_25_11:setScale(arg_25_2.roleScale)
		var_25_11:setAnchorPoint(arg_25_2.anchorPoint)
		var_25_11:setPosition(cc.p(var_25_1 / 2 + arg_25_2.roleOffSetX, var_25_2 / 2 + arg_25_2.roleOffSetY))
		var_25_0:addChild(var_25_11)

		if self.allRoleInfo.index == 1 then
			var_25_4:setPosition(cc.p(var_25_1 / 2 - 84, var_25_2 / 2 - 127))
			var_25_7:setPosition(cc.p(105, 28))
			var_25_7:setFontSize(20)
			var_25_7:setColor(cc.c3b(255, 255, 255))
			var_25_11:setPosition(cc.p(var_25_1 / 2 + arg_25_2.roleOffSetX, var_25_2 / 2 + arg_25_2.roleOffSetY + 6))
			var_25_10:setScaleX(0.65)
			var_25_10:setScaleY(0.6)
			var_25_10:setPositionY(-35)
			var_25_5:setVisible(true)
		elseif self.allRoleInfo.index == 2 then
			var_25_4:setPosition(cc.p(var_25_1 / 2 - 85, var_25_2 / 2 - 110))
			var_25_7:setPosition(cc.p(75, 20))
			var_25_7:setFontSize(20)
			var_25_7:setColor(cc.c3b(255, 255, 255))
			var_25_10:setScale(0.5)
			var_25_5:setVisible(false)
		elseif self.allRoleInfo.index == 3 then
			local var_25_12 = arg_25_2.isAi == true and var_0_9[arg_25_2.rarity] or var_0_8[arg_25_2.rarity]

			var_25_7:setPosition(var_25_12.namepos)

			local var_25_13 = var_25_7:getVirtualRenderer():getTTFConfig()

			var_25_13.fontSize = var_25_12.namefont

			var_25_7:getVirtualRenderer():setTTFConfig(var_25_13)
			var_25_7:getVirtualRenderer():setColor(var_25_12.namecolor)
			var_25_10:setPosition(var_25_12.playerpos)
			var_25_10:setScale(var_25_12.playerscale)
			var_25_4:setPosition(cc.p(var_25_1 / 2 + var_25_12.maskpos.x, var_25_2 / 2 + var_25_12.maskpos.y))
			var_25_11:setPosition(cc.p(var_25_1 / 2 + var_25_12.clippos.x + arg_25_2.roleOffSetX, var_25_2 / 2 + var_25_12.clippos.y + arg_25_2.roleOffSetY))

			if arg_25_2.isAi == false and arg_25_2.rarity == 4 then
				local var_25_14 = ccui.ImageView:create("SchoolFileLayer/power/name_bg4.png", var_0_19)

				var_25_14:setPosition(cc.p(15, 21))
				var_25_14:setAnchorPoint(cc.p(0, 0))
				var_25_14:setName("name_bg")
				arg_25_1:addChild(var_25_14)
			end

			var_25_5:setVisible(false)
		end
	else
		local var_25_15 = cc.Sprite:create(arg_25_2.rolePath)

		var_25_15:setScale(0.6)
		var_25_15:setPosition(cc.p(var_25_1 / 2 + arg_25_2.roleOffSetX, var_25_2 / 2 + arg_25_2.roleOffSetY))
		var_25_15:setName("player")
		var_25_15:setPosition(cc.p(96, 111))
		var_25_0:addChild(var_25_15)
		var_25_7:setFontSize(20)
		var_25_5:setVisible(false)
		var_25_6:setContentSize(cc.size(18, 100))
		var_25_6:ignoreContentAdaptWithSize(false)
		var_25_6:setAnchorPoint(cc.p(0, 0))
		var_25_6:setPosition(cc.p(18, -25))
		var_25_7:setContentSize(cc.size(20, 120))
		var_25_7:ignoreContentAdaptWithSize(false)
		var_25_7:setPosition(cc.p(15, 130))
		var_25_4:setPosition(cc.p(var_25_1 / 2 - 78, var_25_2 / 2 - 113))
	end
end

function SchoolFileLayer:resumeItemContentNode(arg_26_1, arg_26_2)
	if arg_26_1 == nil then
		return
	end

	local var_26_0 = 368 + 254 * (math.ceil(arg_26_2 / 3) - 1)
	local var_26_1 = arg_26_1:getChildrenCount()

	if arg_26_2 - var_26_1 > 0 then
		for iter_26_0 = var_26_1 + 1, arg_26_2 do
			local var_26_2 = self.itemNodePool.get()

			arg_26_1:addChild(var_26_2)
			var_26_2:setName("item" .. iter_26_0)
			var_26_2:setPosition(cc.p(110 + (iter_26_0 - 1) % 3 * 186, var_26_0 - 200 - math.floor((iter_26_0 - 1) / 3) * 259))
		end
	elseif arg_26_2 - var_26_1 < 0 then
		for iter_26_1 = var_26_1, arg_26_2 + 1, -1 do
			self.itemNodePool.put((arg_26_1:getChildByName("item" .. iter_26_1)))
		end
	end

	for iter_26_2 = 1, arg_26_1:getChildrenCount() do
		arg_26_1:getChildByName("item" .. iter_26_2).isHaveInit = false
	end
end

function SchoolFileLayer:initPanel()
	self.titleNode:loadTexture("SchoolFileLayer/title_" .. self.allRoleInfo.index .. ".png", var_0_19)
	self:updateBtnView()
	self.labelInfo:setVisible(self.allRoleInfo.index == 1)

	local var_27_0 = self.allRoleInfo.curPanelInfo

	if self.allRoleInfo.curPanelInfo == nil then
		return
	end

	local var_27_1 = require("controller.souls_manager"):get_total_contract_attr()

	self.labelInfo:setVisible(false)

	if self.tableViewNode ~= nil then
		self:removeTableViewNodeSafe()
	end

	self.tableViewNode = self:getTableView(var_27_0, #var_27_0, cc.size(604, 368), cc.size(604, GameDisplay.height - 105), function(arg_28_0, arg_28_1, arg_28_2)
		local var_28_0 = arg_28_0:dequeueCell()

		if var_28_0 == nil then
			var_28_0 = cc.TableViewCell:new()
		end

		local var_28_1 = arg_28_1 + 1
		local var_28_2 = arg_28_2[arg_28_1 + 1]
		local var_28_3 = 604
		local var_28_4 = 368 + 258 * (math.ceil(#arg_28_2[arg_28_1 + 1].list / 3) - 1)
		local var_28_5 = var_28_0:getChildByName("itemContent")

		if var_28_5 then
			self:resumeItemContentNode(var_28_5:getChildByName("player"), #var_28_2.list)
		else
			var_28_5 = self.itemContentNode:clone()

			var_28_5:setName("itemContent")
			var_28_0:addChild(var_28_5)
		end

		var_28_5:setVisible(true)

		if var_28_1 ~= #arg_28_2 then
			var_28_5:setPosition(cc.p(0, 0))
		else
			var_28_5:setPosition(cc.p(0, 30))
		end

		var_28_5:setContentSize(cc.size(var_28_3, var_28_4))

		local var_28_6 = var_28_5:getChildByName("bgNew")

		if var_28_6 == nil then
			var_28_6 = config._DEBUG and cc.Scale9Sprite:create("SchoolFileLayer/list_bg.png") or cc.Scale9Sprite:createWithSpriteFrameName("SchoolFileLayer/list_bg.png")

			var_28_6:setCapInsets(cc.rect(100, 250, 30, 30))
			var_28_6:setAnchorPoint(cc.p(0, 0))
			var_28_6:setName("bgNew")
			var_28_5:addChild(var_28_6, -1)
		end

		var_28_6:setContentSize(cc.size(var_28_3, var_28_4))

		local var_28_7 = var_28_5:getChildByName("info")

		var_28_7:setPositionY(var_28_4 - 368)
		var_28_7:getChildByName("title"):setString(var_28_2.title)
		var_28_7:getChildByName("unlock_num"):setString(var_28_2.unlockNum)
		var_28_7:getChildByName("all_num"):setString(var_28_2.totalNum)

		local var_28_8 = var_28_5:getChildByName("player")

		var_28_8:setContentSize(cc.size(var_28_3, var_28_4))

		for iter_28_0 = 1, #var_28_2.list do
			local var_28_9 = var_28_2.list[iter_28_0]

			if var_28_2.list[iter_28_0] ~= nil then
				local var_28_10 = var_28_8:getChildByName("item" .. iter_28_0)

				if var_28_10 == nil then
					var_28_10 = self.itemNodePool.get()

					var_28_8:addChild(var_28_10)
					var_28_10:setName("item" .. iter_28_0)
				end

				var_28_10:setVisible(true)
				var_28_10:setSwallowTouches(false)
				var_28_10:setPosition(cc.p(110 + (iter_28_0 - 1) % 3 * 186, var_28_4 - 200 - math.floor((iter_28_0 - 1) / 3) * 259))
				var_28_10:addTouchEventListener(function(arg_29_0, arg_29_1)
					if arg_29_1 ~= ccui.TouchEventType.ended then
						return
					end

					if math.abs(arg_29_0:getTouchBeganPosition().y - arg_29_0:getTouchEndPosition().y) > 50 then
						return
					end

					arg_29_0:getChildByName("new"):setVisible(false)
					self:showPhotoDetailLayer(var_28_9.id, var_28_9.modelId, {
						contentType = var_28_9.contentType
					}, self:getAllFileInfo(var_28_9.fileType), var_28_9.servantId)
				end)
				var_28_10:loadTextures(var_28_2.list[iter_28_0].rarityPath, var_28_2.list[iter_28_0].rarityPath, var_28_2.list[iter_28_0].rarityPath, var_0_19)

				if var_28_10.isHaveInit == false then
					var_28_10.cInfo = var_28_2.list[iter_28_0]
				end
			end
		end

		return var_28_0
	end, function(arg_30_0, arg_30_1)
		print("click ")

		local var_30_0 = arg_30_1:getChildByName("item")
	end)

	self.tableViewNode:setPosition(cc.p(20, 70))
	self.rootlayer:addChild(self.tableViewNode)

	if self.allRoleInfo.index == 4 and #var_27_0 == 0 then
		local var_27_2 = ccui.ImageView:create("SchoolFileLayer/overclock/tips.png", var_0_19)

		var_27_2:setPosition(self.rootlayer:getContentSize().width / 2, self.rootlayer:getContentSize().height / 2)
		var_27_2:setName("tips")
		self.rootlayer:addChild(var_27_2)
	else
		local var_27_3 = self.rootlayer:getChildByName("tips")

		if var_27_3 then
			var_27_3:removeFromParent()
		end
	end

	if self.select_buttonMode == var_0_21 and self.allRoleInfo.index == 3 or self.select_buttonMode == var_0_20 then
		self.allNumNode:setString(var_27_0.totalNum)
		self.unlockNumNode:setString(var_27_0.unlockNum)
	end
end

function SchoolFileLayer:removeTableViewNodeSafe()
	local var_31_0 = self.tableViewNode:getContainer()
	local var_31_1 = var_31_0:getChildren()

	for iter_31_0 = 1, var_31_0:getChildrenCount() do
		local var_31_2 = var_31_1[iter_31_0]:getChildByName("itemContent")

		if var_31_2 then
			for iter_31_1, iter_31_2 in pairs((var_31_2:getChildByName("player"):getChildren())) do
				self.itemNodePool.put(iter_31_2)
			end
		end
	end

	self.tableViewNode:removeFromParent()

	self.tableViewNode = nil
end

function SchoolFileLayer.getTableView(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4, arg_32_5, arg_32_6)
	local var_32_0 = arg_32_3.width
	local var_32_1 = arg_32_3.height
	local var_32_2 = cc.TableView:create(arg_32_4)

	var_32_2:setVisible(true)
	var_32_2:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	var_32_2:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_32_2:setDelegate()
	var_32_2:setName("tableView")
	var_32_2:registerScriptHandler(function(arg_33_0)
		return arg_32_2
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	var_32_2:registerScriptHandler(function(arg_34_0)
		arg_32_0:scrollViewDidScroll(arg_34_0)
	end, cc.SCROLLVIEW_SCRIPT_SCROLL)
	var_32_2:registerScriptHandler(function(arg_35_0, arg_35_1)
		arg_32_6(arg_35_0, arg_35_1)
	end, cc.TABLECELL_TOUCHED)
	var_32_2:registerScriptHandler(function(arg_36_0, arg_36_1)
		if arg_36_1 + 1 ~= #arg_32_1 then
			return var_32_0, var_32_1 + 258 * (math.ceil(#arg_32_1[arg_36_1 + 1].list / 3) - 1) + 40
		else
			return var_32_0, var_32_1 + 254 * (math.ceil(#arg_32_1[arg_36_1 + 1].list / 3) - 1) + 70
		end
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	var_32_2:registerScriptHandler(function(arg_37_0, arg_37_1)
		return arg_32_5(arg_37_0, arg_37_1, arg_32_1)
	end, cc.TABLECELL_SIZE_AT_INDEX)
	var_32_2:reloadData()
	var_32_2:setAnchorPoint(cc.p(0, 1))

	return var_32_2
end

function SchoolFileLayer:scrollViewDidScroll(arg_38_1)
	local var_38_0 = arg_38_1:getContainer()
	local var_38_1 = var_38_0:getPositionY()
	local var_38_2 = var_38_0:getChildren()
	local var_38_3 = cc.size(604, GameDisplay.height - 105).height

	for iter_38_0 = 1, var_38_0:getChildrenCount() do
		local var_38_6 = var_38_2[iter_38_0]:getChildByName("itemContent")

		if var_38_6 then
			local var_38_7 = var_38_6:getChildByName("player")

			for iter_38_1, iter_38_2 in pairs((var_38_7:getChildren())) do
				if not (iter_38_2:getPositionY() + var_38_1 + iter_38_2:getContentSize().height + var_38_7:getPositionY() + var_38_6:getPositionY() + var_38_2[iter_38_0]:getPositionY() < 0 or var_38_3 < iter_38_2:getPositionY() + var_38_1 + var_38_7:getPositionY() + var_38_6:getPositionY() + var_38_2[iter_38_0]:getPositionY()) == true and iter_38_2.isHaveInit == false then
					iter_38_2.isHaveInit = true

					self:initItemNode(iter_38_2, iter_38_2.cInfo)
				end
			end
		end
	end
end

function SchoolFileLayer:fullScreen()
	self.rootlayer:setPosition(cc.p(0, -GameDisplay.fix_y))

	self.titleNode.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - self.titleNode:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.titleNode:setPositionY(self.titleNode.full_posY)
	self.imgTopLine:setPositionX(self.imgTopLine:getPositionX() + 15)
	self.unlockNumNode:setPositionX(self.unlockNumNode:getPositionX() + 15)

	self.unlockNumNode.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - self.unlockNumNode:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.unlockNumNode:setPositionY(self.unlockNumNode.full_posY)
	self.allNumNode:setPositionX(self.allNumNode:getPositionX() + 10)

	self.allNumNode.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - self.allNumNode:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.allNumNode:setPositionY(self.allNumNode.full_posY)
	self.labelInfo:setPositionY(self.allNumNode:getPositionY() + 10)

	self.toggleContainerNode.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.toggleContainerNode:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.toggleContainerNode:setPositionY(self.toggleContainerNode.full_posY)

	self.btn_return.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.btn_return:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.btn_return:setPositionY(self.btn_return.full_posY)

	self.btn_view.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - self.btn_view:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.btn_view:setPositionY(self.btn_view.full_posY)
end

function SchoolFileLayer:layerOutAni(arg_40_1)
	self.startRunOutAni = true

	self.rootlayer:runAction(cc.Sequence:create(cc.DelayTime:create(LAYER_OUT_TIME), cc.CallFunc:create(arg_40_1)))
end

function SchoolFileLayer.showPhotoDetailLayer(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4, arg_41_5)
	if arg_41_3.contentType == "file_player" and not hexie_manager:canShowServant(tonumber(arg_41_5)) then
		return
	end

	local var_41_0 = {
		PhotoFileLayer = 1,
		id = arg_41_1,
		modelid = arg_41_2,
		contentType = arg_41_3,
		info = arg_41_4,
		servantid = arg_41_5
	}

	print("contentType==", arg_41_3.contentType)

	if arg_41_3.contentType == "file_weapon" or arg_41_3.contentType == "file_enemy2" or arg_41_3.contentType == "file_enemy3" or arg_41_3.contentType == "file_enemy4" or arg_41_3.contentType == "file_enemy5" or arg_41_3.contentType == "file_enemy11" or arg_41_3.contentType == "file_enemy7" or arg_41_3.contentType == "file_enemy9" then
		LayerManager:pushInLayer("PhotoFileHelpGirlLayer", var_41_0)
	else
		LayerManager:pushInLayer("PhotoFileRoleFileLayer", var_41_0)
	end
end
