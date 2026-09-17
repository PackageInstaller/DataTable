PhotoFileRoleImageLayer = class("PhotoFileRoleImageLayer", function()
	return cc.Layer:create()
end)

require("data.constants")

local role_conversation_index_data = require("data.role_conversation_index_data")
local item_data = require("data.item_data")
local role_conversation_data = require("data.role_conversation_data")
local playermodel = require("model.playermodel")
local audio_manager = require("controller.audio_manager")
local major_factor_data = require("data.major_factor_data")
local model_data = require("data.model_data")
local favorfile_data = require("data.favorfile_data")
local npc_data = require("data.npc_data")
local servant_data = require("data.servant_data")
local photofile_xmas_data = require("data.photofile_xmas_data")
local photofile_xmasfile_data = require("data.photofile_xmasfile_data")
local photofile_data = require("data.photofile_data")
local photofile_npc_data = require("data.photofile_npc_data")
local photofile_npcfiles_data = require("data.photofile_npcfiles_data")
local photofile_military_data = require("data.photofile_military_data")
local photofile_role_military_data = require("data.photofile_role_military_data")
local photofile_role_foundation_data = require("data.photofile_role_foundation_data")
local photofile_foundation_data = require("data.photofile_foundation_data")
local photofile_role_killer_data = require("data.photofile_role_killer_data")
local photofile_killer_data = require("data.photofile_killer_data")
local item_manager = require("controller.item_manager")

function PhotoFileRoleImageLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PhotoFileRoleImageLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

local var_0_24 = {
	ROLE_CONVERSATION_TYPE.home,
	ROLE_CONVERSATION_TYPE.changeShowgilr,
	ROLE_CONVERSATION_TYPE.mainTouch,
	ROLE_CONVERSATION_TYPE.fight,
	ROLE_CONVERSATION_TYPE.passlevel,
	ROLE_CONVERSATION_TYPE.lose,
	ROLE_CONVERSATION_TYPE.dormTouch,
	ROLE_CONVERSATION_TYPE.favorUpgrade,
	ROLE_CONVERSATION_TYPE.gift,
	ROLE_CONVERSATION_TYPE.changeDress,
	ROLE_CONVERSATION_TYPE.angry,
	ROLE_CONVERSATION_TYPE.win,
	ROLE_CONVERSATION_TYPE.dormDaily,
	ROLE_CONVERSATION_TYPE.dormFirst,
	ROLE_CONVERSATION_TYPE.xp
}
local var_0_25 = {
	[ROLE_CONVERSATION_TYPE.home] = 1,
	[ROLE_CONVERSATION_TYPE.changeShowgilr] = 2,
	[ROLE_CONVERSATION_TYPE.mainTouch] = 16,
	[ROLE_CONVERSATION_TYPE.fight] = 4,
	[ROLE_CONVERSATION_TYPE.passlevel] = 5,
	[ROLE_CONVERSATION_TYPE.lose] = 6,
	[ROLE_CONVERSATION_TYPE.dormTouch] = 7,
	[ROLE_CONVERSATION_TYPE.favorUpgrade] = 8,
	[ROLE_CONVERSATION_TYPE.gift] = 9,
	[ROLE_CONVERSATION_TYPE.changeDress] = 10,
	[ROLE_CONVERSATION_TYPE.angry] = 11,
	[ROLE_CONVERSATION_TYPE.win] = 12,
	[ROLE_CONVERSATION_TYPE.dormDaily] = 13,
	[ROLE_CONVERSATION_TYPE.dormFirst] = 14,
	[ROLE_CONVERSATION_TYPE.xp] = 15
}

function PhotoFileRoleImageLayer:fullScreen()
	local var_5_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_name")

	var_5_0:setPositionY(var_5_0:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)

	local var_5_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_painter")

	var_5_1:setPositionY(var_5_1:getPositionY() - GameDisplay.fix_y)

	local var_5_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_cvBottom")

	var_5_2:setPositionY(var_5_2:getPositionY() - GameDisplay.fix_y)
end

function PhotoFileRoleImageLayer:init(arg_6_1)
	print(dump(arg_6_1))

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PhotoFile_roleImage.json" or "PhotoFile_roleImage.ExportJson")

	self:addChild(self.rootLayer)

	self.id = arg_6_1.id
	self.type = arg_6_1.type
	self.indexId = arg_6_1.indexId
	self.modelid = tostring(self.id)
	self.servantid = tonumber(arg_6_1.servantid) or tonumber(self.modelid)
	self.background = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_role")
	self.panel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel")

	self.background:loadTexture("mainScenebg/image_choose_background.png")

	self.activity = true
	self.roleName = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_name")
	self.imageRole = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_vd")

	self.imageRole:setLocalZOrder(11)
	self.imageRole:loadTexture("roleimage/role/" .. model_data[self.modelid].role_image .. ".png")
	self.imageRole:setAnchorPoint(cc.p(0.5, 0.6))
	self:changeData()

	if self.type == "file_player" or self.type == "file_overclock" then
		self:initData()
	elseif self.type == "file_teacher" then
		self:initNpcData()
	end

	self:initUI()
	self:updateUI()
	self.background:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer()

		self.activity = false
	end)
	self:fullScreen()

	if not self.cvName then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_servant_info"):getChildByName("Image_painter"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_cvName1"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_cvName2"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_microphone"):setVisible(false)
	end
end

function PhotoFileRoleImageLayer:changeData()
	if self.type == "file_player" or self.type == "file_overclock" then
		self.face = ccui.ImageView:create("expression/" .. model_data[self.modelid].expression .. ".png")

		self.face:setLocalZOrder(12)
		self.face:setAnchorPoint(cc.p(0.5, 0.6))
		self.panel:addChild(self.face)
		self.roleName:setString(favorfile_data[1][self.indexId])

		self.labelcv = cc.Label:createWithTTF(favorfile_data[3][self.indexId] or "", FONT_NAME, 40)

		local var_8_0 = photofile_data[self.indexId].image_offset_x or 0
		local var_8_1 = photofile_data[self.indexId].image_offset_y or 0
		local var_8_2 = photofile_data[self.indexId].size or 0.8

		self.imageRole:setScale(var_8_2)
		self.imageRole:setPositionX(self.background:getContentSize().width / 2 + var_8_0)
		self.imageRole:setPositionY(568 + var_8_1)
		self.face:setPosition(self.imageRole:getPosition())
		self.face:setScale(var_8_2)
	elseif self.type == "file_enemy1" then
		self.roleName:setString(photofile_xmas_data[2][self.indexId])

		self.labelcv = cc.Label:createWithTTF(photofile_xmas_data[4][self.indexId], FONT_NAME, 40)

		local var_8_3 = photofile_xmasfile_data[self.indexId].image_offset_y or 0

		self.imageRole:setPositionX(self.background:getContentSize().width / 2 + (photofile_xmasfile_data[self.indexId].image_offset_x or 0))
		self.imageRole:setPositionY(568 + var_8_3)
		self.imageRole:setScale(photofile_xmasfile_data[self.indexId].size or 0.8)
	elseif self.type == "file_enemy6" then
		self.roleName:setString(photofile_role_military_data[2][self.indexId])

		self.labelcv = cc.Label:createWithTTF(photofile_role_military_data[14][self.indexId], FONT_NAME, 40)

		local var_8_4 = photofile_military_data[self.indexId].image_offset_y or 0

		self.imageRole:setPositionX(self.background:getContentSize().width / 2 + (photofile_military_data[self.indexId].image_offset_x or 0))
		self.imageRole:setPositionY(568 + var_8_4)
		self.imageRole:setScale(photofile_military_data[self.indexId].size or 0.8)
	elseif self.type == "file_enemy8" then
		self.roleName:setString(photofile_role_foundation_data[2][self.indexId])

		self.labelcv = cc.Label:createWithTTF(photofile_role_foundation_data[14][self.indexId], FONT_NAME, 40)

		local var_8_5 = photofile_foundation_data[self.indexId].image_offset_y or 0

		self.imageRole:setPositionX(self.background:getContentSize().width / 2 + (photofile_foundation_data[self.indexId].image_offset_x or 0))
		self.imageRole:setPositionY(568 + var_8_5)
		self.imageRole:setScale(photofile_foundation_data[self.indexId].size or 0.8)
	elseif self.type == "file_enemy10" then
		self.roleName:setString(photofile_role_killer_data[2][self.indexId])

		self.labelcv = cc.Label:createWithTTF(photofile_role_killer_data[14][self.indexId], FONT_NAME, 40)

		local var_8_6 = photofile_killer_data[self.indexId].image_offset_y or 0

		self.imageRole:setPositionX(self.background:getContentSize().width / 2 + (photofile_killer_data[self.indexId].image_offset_x or 0))
		self.imageRole:setPositionY(568 + var_8_6)
		self.imageRole:setScale(photofile_killer_data[self.indexId].size or 0.8)
	elseif self.type == "file_teacher" then
		self.roleName:setString(photofile_npcfiles_data[self.indexId].name)

		self.labelcv = cc.Label:createWithTTF(photofile_npc_data[3][self.indexId], FONT_NAME, 40)
		self.face = ccui.ImageView:create("expression/" .. model_data[self.modelid].expression .. ".png")

		self.face:setLocalZOrder(12)
		self.face:setAnchorPoint(cc.p(0.5, 0.6))
		self.panel:addChild(self.face)

		local var_8_7 = photofile_npcfiles_data[self.indexId].image_offset_y or 0

		self.imageRole:setPositionX(self.background:getContentSize().width / 2 + (photofile_npcfiles_data[self.indexId].image_offset_x or 0))
		self.imageRole:setPositionY(568 + var_8_7)

		local var_8_8 = photofile_npcfiles_data[self.indexId].size or 0.8

		self.imageRole:setScale(var_8_8)
		self.face:setPosition(self.imageRole:getPosition())
		self.face:setScale(var_8_8)
	end
end

function PhotoFileRoleImageLayer:getAllSound()
	local var_9_1 = {}

	for iter_9_0, iter_9_1 in pairs(role_conversation_index_data[tostring(servant_data[self.servantid].major)]) do
		for iter_9_2, iter_9_3 in pairs(ROLE_CONVERSATION_TYPE_TO_STR) do
			if not var_9_1[iter_9_1] and string.find(iter_9_0, iter_9_3) then
				var_9_1[iter_9_1] = {}
				var_9_1[iter_9_1].classification = iter_9_1
				var_9_1[iter_9_1].talktype = iter_9_3
				var_9_1[iter_9_1].major = servant_data[self.servantid].major
				var_9_1[iter_9_1].talkid = iter_9_2
			end
		end
	end

	while major_factor_data[servant_data[self.servantid].major]["item" .. 1] do
		if major_factor_data[servant_data[self.servantid].major]["item" .. 1 .. "_hide"] ~= 1 then
			if not role_conversation_index_data[tostring(item_data[major_factor_data[servant_data[self.servantid].major]["item" .. 1]].model)] then
				break
			end

			for iter_9_4, iter_9_5 in pairs(role_conversation_index_data[tostring(item_data[major_factor_data[servant_data[self.servantid].major]["item" .. 1]].model)]) do
				for iter_9_6, iter_9_7 in pairs(ROLE_CONVERSATION_TYPE_TO_STR) do
					if not var_9_1[iter_9_5] and string.find(iter_9_4, iter_9_7) then
						var_9_1[iter_9_5] = {}
						var_9_1[iter_9_5].classification = iter_9_5
						var_9_1[iter_9_5].talktype = iter_9_7
						var_9_1[iter_9_5].itemid = major_factor_data[servant_data[self.servantid].major]["item" .. 1]
						var_9_1[iter_9_5].modelid = item_data[major_factor_data[servant_data[self.servantid].major]["item" .. 1]].model
						var_9_1[iter_9_5].talkid = iter_9_6
					end
				end
			end
		end
	end

	local var_9_3 = {}

	for iter_9_8, iter_9_9 in pairs(servant_data) do
		if iter_9_9.major == servant_data[self.servantid].major and iter_9_9.id == self.servantid then
			table.insert(var_9_3, iter_9_9.id)
		end
	end

	for iter_9_10, iter_9_11 in pairs(var_9_3) do
		if role_conversation_index_data[servant_data[iter_9_11].modelid] then
			for iter_9_12, iter_9_13 in pairs(role_conversation_index_data[tostring(servant_data[iter_9_11].modelid)]) do
				for iter_9_14, iter_9_15 in pairs(ROLE_CONVERSATION_TYPE_TO_STR) do
					if not var_9_1[iter_9_13] and string.find(iter_9_12, iter_9_15) then
						var_9_1[iter_9_13] = {}
						var_9_1[iter_9_13].classification = iter_9_13
						var_9_1[iter_9_13].talktype = iter_9_15
						var_9_1[iter_9_13].modelid = servant_data[iter_9_11].modelid
						var_9_1[iter_9_13].servantid = iter_9_11
						var_9_1[iter_9_13].talkid = iter_9_14
					end
				end
			end
		end
	end

	local var_9_4 = {}

	for iter_9_16, iter_9_17 in pairs(var_9_1) do
		for iter_9_18, iter_9_19 in pairs(role_conversation_data) do
			if iter_9_19.classification == iter_9_17.classification and iter_9_19.sound and not var_9_4[iter_9_19.sound] then
				local var_9_5 = {
					type = iter_9_17.talkid
				}

				var_9_5.des = L_ROLE_CONVERSATION_TYPE_DES[iter_9_17.talkid] or ""
				var_9_5.sound = iter_9_19.sound
				var_9_5.talkDec = iter_9_19.dec
				var_9_5.talkid = iter_9_17.talkid
				var_9_5.talktype = iter_9_17.talktype
				var_9_5.itemid = iter_9_17.itemid
				var_9_5.major = iter_9_17.major
				var_9_5.id = iter_9_19.id
				var_9_5.expression = iter_9_19.expression
				var_9_4[iter_9_19.sound] = var_9_5
			end
		end
	end

	return var_9_4
end

function PhotoFileRoleImageLayer:initData()
	self.showType = "info"

	local var_10_0 = 1

	for iter_10_0, iter_10_1 in pairs(photofile_data) do
		if tonumber(iter_10_1.servant_id) == self.servantid then
			var_10_0 = iter_10_1.id
		end
	end

	self.cvName = favorfile_data[3][var_10_0] or L_CV_UNSURE
	self.painterName = model_data[self.modelid].painter or L_CV_UNSURE
	self.voiceList = {}
	self.playing = {}

	if role_conversation_index_data[tostring(servant_data[self.servantid].major)] then
		for iter_10_2, iter_10_3 in pairs((self:getAllSound())) do
			table.insert(self.voiceList, iter_10_3)
		end
	end

	local var_10_6
	local var_10_7

	do
		print("这个对话还在读“三层结构”", self.servantid)

		local var_10_1 = {}

		table.insert(var_10_1, servant_data[self.servantid].modelid)

		while servant_data[self.servantid]["modelid" .. 1] do
			table.insert(var_10_1, servant_data[self.servantid]["modelid" .. 1])
		end

		local var_10_3 = {}

		for iter_10_4, iter_10_5 in pairs(var_0_24) do
			for iter_10_6, iter_10_7 in pairs(var_10_1) do
				local var_10_4 = GenerateRoleConversationClass(iter_10_7, iter_10_5)

				for iter_10_8, iter_10_9 in pairs(role_conversation_data) do
					if iter_10_9.classification == var_10_4 and iter_10_9.sound and not var_10_3[iter_10_9.sound] then
						var_10_3[iter_10_9.sound] = iter_10_9.sound

						local var_10_5 = {
							type = iter_10_5
						}

						var_10_5.des = L_ROLE_CONVERSATION_TYPE_DES[iter_10_5] or ""
						var_10_5.sound = iter_10_9.sound
						var_10_5.talkDec = iter_10_9.dec

						table.insert(self.voiceList, var_10_5)
					end
				end
			end
		end

		var_10_6 = {
			[3] = {
				weight = 3,
				func = function(self, arg_13_1)
					local var_13_0 = 0
					local var_13_1 = 0

					if self.itemid and item_manager:getItemNumber(self.itemid) == 0 then
						var_13_0 = 1
					end

					if arg_13_1.itemid and item_manager:getItemNumber(arg_13_1.itemid) == 0 then
						var_13_1 = 1
					end

					if var_13_0 == var_13_1 then
						return "=="
					else
						return var_13_0 < var_13_1
					end
				end
			},
			[2] = {
				weight = 1,
				func = function(self, arg_12_1)
					return tonumber(self.id or 10000000) < tonumber(arg_12_1.id or 10000000)
				end
			}
		}
		var_10_7 = {
			weight = 2
		}
	end

	function var_10_7:func(arg_11_1)
		local var_11_0 = var_0_25[self.type] or 100
		local var_11_1 = var_0_25[arg_11_1.type] or 100

		if var_11_0 == var_11_1 then
			return "=="
		else
			return var_11_0 < var_11_1
		end
	end

	var_10_6[1] = var_10_7

	table.sort(var_10_6, function(arg_14_0, arg_14_1)
		return arg_14_0.weight > arg_14_1.weight
	end)
	table.sort(self.voiceList, function(arg_15_0, arg_15_1)
		for iter_15_0 = 1, #var_10_6 do
			if var_10_6[iter_15_0].func(arg_15_0, arg_15_1) ~= "==" then
				return var_10_6[iter_15_0].func(arg_15_0, arg_15_1)
			end
		end
	end)

	local var_10_8 = 0
	local var_10_9

	for iter_10_10, iter_10_11 in pairs(self.voiceList) do
		if not var_10_9 then
			var_10_9 = iter_10_11.type
			var_10_8 = 1
		end

		if var_10_9 ~= iter_10_11.type then
			var_10_9 = iter_10_11.type
			var_10_8 = 1
		end

		iter_10_11.tag = var_10_8
		var_10_8 = var_10_8 + 1
	end

	local var_10_10 = {}

	for iter_10_12, iter_10_13 in pairs(self.voiceList) do
		var_10_10[iter_10_13.type] = var_10_10[iter_10_13.type] or 0
		var_10_10[iter_10_13.type] = var_10_10[iter_10_13.type] + 1
	end

	for iter_10_14, iter_10_15 in pairs(self.voiceList) do
		if var_10_10[iter_10_15.type] == 1 then
			iter_10_15.tag = nil
		end
	end
end

function PhotoFileRoleImageLayer:initNpcData()
	self.showType = "info"
	self.npcModelid = tostring(self.modelid)

	local var_16_0 = 1

	for iter_16_0, iter_16_1 in pairs(photofile_npcfiles_data) do
		if iter_16_1.model_id == self.npcModelid then
			var_16_0 = iter_16_1.id
		end
	end

	self.cvName = photofile_npc_data[3][var_16_0] or L_CV_UNSURE
	self.painterName = model_data[self.npcModelid].painter or L_CV_UNSURE
	self.voiceList = {}
	self.playing = {}

	self:initNpcSound()
end

function PhotoFileRoleImageLayer:initNpcSound()
	local var_17_0 = {}

	table.insert(var_17_0, self.npcModelid)

	local var_17_1 = {}

	for iter_17_0, iter_17_1 in pairs(var_0_24) do
		for iter_17_2, iter_17_3 in pairs(var_17_0) do
			local var_17_2 = GenerateRoleConversationClass(iter_17_3, iter_17_1)

			for iter_17_4, iter_17_5 in pairs(role_conversation_data) do
				if iter_17_5.classification == var_17_2 and iter_17_5.sound and not var_17_1[iter_17_5.sound] then
					var_17_1[iter_17_5.sound] = iter_17_5.sound

					local var_17_3 = {
						type = iter_17_1
					}

					var_17_3.des = L_ROLE_CONVERSATION_TYPE_DES[iter_17_1] or ""
					var_17_3.sound = iter_17_5.sound
					var_17_3.talkDec = iter_17_5.dec

					table.insert(self.voiceList, var_17_3)
				end
			end
		end
	end

	local var_17_4 = {
		[3] = {
			weight = 3,
			func = function(self, arg_20_1)
				local var_20_0 = 0
				local var_20_1 = 0

				if self.itemid and item_manager:getItemNumber(self.itemid) == 0 then
					var_20_0 = 1
				end

				if arg_20_1.itemid and item_manager:getItemNumber(arg_20_1.itemid) == 0 then
					var_20_1 = 1
				end

				if var_20_0 == var_20_1 then
					return "=="
				else
					return var_20_0 < var_20_1
				end
			end
		},
		[2] = {
			weight = 1,
			func = function(self, arg_19_1)
				return tonumber(self.id or 10000000) < tonumber(arg_19_1.id or 10000000)
			end
		},
		{
			weight = 2,
			func = function(self, arg_18_1)
				local var_18_0 = var_0_25[self.type] or 100
				local var_18_1 = var_0_25[arg_18_1.type] or 100

				if var_18_0 == var_18_1 then
					return "=="
				else
					return var_18_0 < var_18_1
				end
			end
		}
	}

	table.sort(var_17_4, function(arg_21_0, arg_21_1)
		return arg_21_0.weight > arg_21_1.weight
	end)
	table.sort(self.voiceList, function(arg_22_0, arg_22_1)
		for iter_22_0 = 1, #var_17_4 do
			if var_17_4[iter_22_0].func(arg_22_0, arg_22_1) ~= "==" then
				return var_17_4[iter_22_0].func(arg_22_0, arg_22_1)
			end
		end
	end)

	local var_17_5 = 0
	local var_17_6

	for iter_17_6, iter_17_7 in pairs(self.voiceList) do
		if not var_17_6 then
			var_17_6 = iter_17_7.type
			var_17_5 = 1
		end

		if var_17_6 ~= iter_17_7.type then
			var_17_6 = iter_17_7.type
			var_17_5 = 1
		end

		iter_17_7.tag = var_17_5
		var_17_5 = var_17_5 + 1
	end

	local var_17_7 = {}

	for iter_17_8, iter_17_9 in pairs(self.voiceList) do
		var_17_7[iter_17_9.type] = var_17_7[iter_17_9.type] or 0
		var_17_7[iter_17_9.type] = var_17_7[iter_17_9.type] + 1
	end

	for iter_17_10, iter_17_11 in pairs(self.voiceList) do
		if var_17_7[iter_17_11.type] == 1 then
			iter_17_11.tag = nil
		end
	end
end

function PhotoFileRoleImageLayer:initUI()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_servant_info"):setPositionY(69 - GameDisplay.fix_y)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_voice"):setPositionY(-GameDisplay.fix_y)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_voice"):setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg"):setPositionY(-600)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_voice"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_cellBg"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_talkBg"):setVisible(false)

	local var_23_0 = cc.Label:createWithTTF("", FONT_DES, 26)

	var_23_0:setColor(cc.c3b(232, 238, 248))
	var_23_0:setAnchorPoint(cc.p(0, 1))
	var_23_0:setName("label")
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_talkBg"):addChild(var_23_0)

	local var_23_1 = cc.Label:createWithTTF(string_split(model_data[self.modelid].name, "】")[#string_split(model_data[self.modelid].name, "】")], FONT_DES, 40)

	var_23_1:setPositionX(0)
	var_23_1:setPositionY(5)
	var_23_1:setAnchorPoint(cc.p(0, 0))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_name"):addChild(var_23_1)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_name"):setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_name"):getPositionY() + GameDisplay.fix_y)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_englishName"):setPositionY(var_23_1:getPositionY() + var_23_1:getContentSize().height)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_englishName"):setString("")

	local var_23_3 = {}

	for iter_23_0 in string.gmatch("132,135,143", "([^,]+)") do
		var_23_3[#var_23_3 + 1] = tonumber(iter_23_0)
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_englishName"):setColor(cc.c3b(var_23_3[1], var_23_3[2], var_23_3[3]))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_Big"):setPositionY(GameDisplay.height - GameDisplay.fix_y - 60)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_cv"):addTouchEventListener(function()
		if touchType ~= ccui.TouchEventType.ended then
			return
		end

		self.showType = "voice"

		self:updateUI()
		self:changeType()
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_voice"):addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.showType = "info"

		self:updateUI()
		self:changeType()
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_microphone"):addTouchEventListener(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.voiceList or #self.voiceList == 0 then
			return
		end

		self.showType = "voice"

		self:updateUI()
		self:changeType()
		AnalyticManager.clickCvBtn({
			servantID = self.servantid
		})
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_microphone"):setVisible(self.voiceList and #self.voiceList > 0 or false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_painter"):addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.voiceList or #self.voiceList == 0 then
			return
		end

		self.showType = "voice"

		self:updateUI()
		self:changeType()
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_Big"):addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopShowGirl", {
			servantid = self.servantid,
			modelid = self.modelid
		})
	end)
	self:createTableView()
end

function PhotoFileRoleImageLayer:updateUI()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_cvName1"):setString(self.cvName or L_CV_UNSURE)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_cvName2"):setString(self.cvName or L_CV_UNSURE)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_painterName"):setString(self.painterName or L_CV_UNSURE)
end

function PhotoFileRoleImageLayer:changeType()
	if self.showType == "voice" then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg"):runAction(cc.MoveTo:create(0.1, cc.p(320, 194)))
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_servant_info"):runAction(cc.MoveTo:create(0.1, cc.p(124, -600)))
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_voice"):setVisible(true)
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg"):runAction(cc.MoveTo:create(0.1, cc.p(320, -600)))
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_servant_info"):runAction(cc.MoveTo:create(0.1, cc.p(124, 69)))
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_voice"):setVisible(false)
	end
end

function PhotoFileRoleImageLayer:playVoice(arg_31_1, arg_31_2, arg_31_3)
	if audio_manager:isPlayerSoundValid() then
		self.playing[arg_31_1] = self.playing[arg_31_1] or 0
		self.playing[arg_31_1] = self.playing[arg_31_1] + 1

		audio_manager:stopAllRoleSound()
		self:startPlayVoiceAni(arg_31_2)
		self:setFace(arg_31_3)
		audio_manager:playPlayerSound("sound/role_voice/" .. arg_31_1, nil, nil, function()
			if self.activity then
				self.playing[arg_31_1] = self.playing[arg_31_1] - 1

				if self.playing[arg_31_1] == 0 then
					self.playing[arg_31_1] = nil
				end

				local var_32_0 = 0

				for iter_32_0, iter_32_1 in pairs(self.playing) do
					var_32_0 = var_32_0 + 1
				end

				if var_32_0 == 0 then
					self:stopPlayVoiceAni()
					self:resetFace()
				end

				self:updateShowingCells()
			end
		end)
	else
		if not self.timer then
			self.timer = cc.Node:create()

			self:addChild(self.timer)
		end

		local var_31_0 = 0

		for iter_31_0, iter_31_1 in pairs(self.playing) do
			var_31_0 = var_31_0 + 1
		end

		if var_31_0 > 0 then
			self.timer:stopAllActions()

			self.playing = {}
		end

		self.playing[arg_31_1] = arg_31_1

		self:startPlayVoiceAni(arg_31_2)
		self:setFace(arg_31_3)
		self.timer:runAction(cc.Sequence:create(cc.DelayTime:create(3), cc.CallFunc:create(function()
			if self.activity then
				self.playing = {}

				self:updateShowingCells()
				self:stopPlayVoiceAni()
				self:resetFace()
			end
		end)))
	end
end

function PhotoFileRoleImageLayer:setFace(arg_34_1)
	if not arg_34_1 then
		self:resetFace()
	else
		self.face:loadTexture("expression/" .. model_data[self.modelid][arg_34_1] .. ".png")
	end
end

function PhotoFileRoleImageLayer:resetFace()
	print("path======", "expression/" .. model_data[self.modelid].expression .. ".png")
	self.face:loadTexture("expression/" .. model_data[self.modelid].expression .. ".png")
end

function PhotoFileRoleImageLayer:startPlayVoiceAni(arg_36_1)
	local var_36_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_talkBg")

	var_36_0:setVisible(true)

	local var_36_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_talkBg"):getChildByName("label")

	var_36_1:setMaxLineWidth(450)
	var_36_1:setString(arg_36_1)

	local var_36_2 = math.max(var_36_1:getContentSize().height + 30, 88)

	var_36_0:setContentSize(cc.size(var_36_0:getContentSize().width, var_36_2))
	var_36_1:setPosition(cc.p(10, var_36_2 - 20))
end

function PhotoFileRoleImageLayer:stopPlayVoiceAni()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_talkBg"):setVisible(false)
end

local var_0_26 = 32
local var_0_27 = 20
local var_0_28 = 554
local var_0_29 = 271
local var_0_30 = 70
local var_0_31 = 271

function PhotoFileRoleImageLayer:createTableView()
	self.voiceTableView = cc.TableView:create(cc.size(var_0_28, var_0_29))
	self.voiceTableView.displayheight = tv_height

	self.voiceTableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	self.voiceTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.voiceTableView:setPosition(cc.p(var_0_26, var_0_27))
	self.voiceTableView:setDelegate()
	self.voiceTableView:setName("voiceTableView")

	self.voiceTableView.anchorPoint = cc.p(0, 0)

	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg"):addChild(self.voiceTableView)
	self.voiceTableView:registerScriptHandler(function(arg_39_0, arg_39_1)
		return var_0_30, var_0_31
	end, cc.TABLECELL_SIZE_FOR_INDEX)

	local function var_38_0()
		local var_40_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_cellBg"):clone()

		var_40_0:setVisible(true)
		var_40_0:setSwallowTouches(false)
		var_40_0:addTouchEventListener(function(arg_41_0, arg_41_1)
			if math.abs(arg_41_0:getTouchBeganPosition().x - arg_41_0:getTouchEndPosition().x) > 50 then
				return
			end

			if arg_41_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.voiceList[arg_41_0.index].itemid and item_manager:getItemNumber(self.voiceList[arg_41_0.index].itemid) == 0 then
				return
			end

			self:playVoice(arg_41_0.sound, arg_41_0.talkDec, arg_41_0.expression)
			self:updateShowingCells()
		end)

		function var_40_0:update(arg_42_1)
			if self.voiceList[arg_42_1] then
				self:setVisible(true)

				self.des = self.voiceList[arg_42_1].des
				self.sound = self.voiceList[arg_42_1].sound
				self.talkDec = self.voiceList[arg_42_1].talkDec
				self.expression = self.voiceList[arg_42_1].expression
				self.index = arg_42_1

				self:getChildByName("Label_vioceDes"):setString(glabal_trans_text_horizontal_to_vertical(self.des .. ((self.voiceList[arg_42_1].tag or nil) and self.voiceList[arg_42_1].tag)))
				self:getChildByName("Label_vioceDes"):setVisible(true)
				self:getChildByName("Panel_lock"):setVisible(false)

				if self.voiceList[arg_42_1].itemid and item_manager:getItemNumber(self.voiceList[arg_42_1].itemid) == 0 then
					self:getChildByName("Panel_lock"):setVisible(true)
					self:getChildByName("Label_vioceDes"):setVisible(false)
					self:getChildByName("Panel_lock"):getChildByName("Label_lockDes"):setString(glabal_trans_text_horizontal_to_vertical(string.format(L_STRING_FORMATH_UNLOCK, (string.gsub(item_data[self.voiceList[arg_42_1].itemid].name, "[%z\x01-\x7F\xC2-\xF4][\x80-\xBF]*", {
						】 = "﹄",
						【 = "﹃"
					})))))
				end

				if self.playing[self.sound] then
					self:getChildByName("Image_playing"):setOpacity(64)
					self:getChildByName("Image_playing"):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(0.6, 255), cc.FadeTo:create(0.6, 64))))
				else
					self:getChildByName("Image_playing"):setOpacity(0)
					self:getChildByName("Image_playing"):stopAllActions()
				end
			else
				self:setVisible(false)
			end
		end

		return var_40_0
	end

	self.voiceTableView:registerScriptHandler(function(arg_43_0, arg_43_1)
		local var_43_0 = arg_43_0:dequeueCell()

		if not var_43_0 then
			var_43_0 = cc.TableViewCell:create()

			local var_43_1 = var_38_0()

			var_43_1:setAnchorPoint(cc.p(0, 0))
			var_43_1:setVisible(true)
			var_43_1:setName("sp")
			var_43_1:setPosition(3, 0)
			var_43_0:addChild(var_43_1)
			var_43_1:update(arg_43_1 + 1)
		else
			var_43_0:getChildByName("sp"):update(arg_43_1 + 1)
		end

		return var_43_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.voiceTableView:registerScriptHandler(function(arg_44_0, arg_44_1)
		return (self.voiceList or nil) and (#self.voiceList or 0)
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.voiceTableView:reloadData()
end

function PhotoFileRoleImageLayer:updateShowingCells(arg_45_1)
	local var_45_0, var_45_1 = GetTableViewShowCellIdx(self.voiceTableView, {
		cellsize = cc.size(var_0_30, var_0_31),
		maxcount = #self.voiceList
	})

	for iter_45_0 = var_45_0, var_45_1 do
		self.voiceTableView:updateCellAtIndex(iter_45_0)
	end
end

function PhotoFileRoleImageLayer.exit(arg_46_0)
	LayerManager:removePopLayer()
end
