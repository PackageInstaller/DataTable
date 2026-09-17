PhotoFileRoleFileLayer = class("PhotoFileRoleFileLayer", function()
	return cc.Layer:create()
end)

require("data.constants")

local deeparchive_data = require("data.deeparchive_data")
local photo_manager = require("controller.photo_manager")
local photofile_data = require("data.photofile_data")
local major_factor_data = require("data.major_factor_data")
local model_data = require("data.model_data")
local var_0_5 = config._DEBUG and 0 or 1
local favorfile_data = require("data.favorfile_data")
local photofile_xmas_data = require("data.photofile_xmas_data")
local photofile_xmasfile_data = require("data.photofile_xmasfile_data")
local var_0_9 = require("data.model_data")
local servant_data = require("data.servant_data")
local total_skill_data = require("data.total_skill_data")
local playermodel = require("model.playermodel")
local favor_data = require("data.favor_data")
local weapon_manager = require("controller.weapon_manager")
local weapon_data = require("data.weapon_data")
local var_0_16 = require("data.servant_data")
local photofile_npc_data = require("data.photofile_npc_data")
local photofile_npcfiles_data = require("data.photofile_npcfiles_data")
local photofile_role_military_data = require("data.photofile_role_military_data")
local photofile_military_data = require("data.photofile_military_data")
local photofile_role_foundation_data = require("data.photofile_role_foundation_data")
local photofile_foundation_data = require("data.photofile_foundation_data")
local photofile_role_killer_data = require("data.photofile_role_killer_data")
local photofile_killer_data = require("data.photofile_killer_data")
local photofile_role_activity_data = require("data.photofile_role_activity_data")
local photofile_activity_data = require("data.photofile_activity_data")
local photofile_nightmare_xmasfile_data = require("data.photofile_nightmare_xmasfile_data")
local photofile_nightmare_xmas_data = require("data.photofile_nightmare_xmas_data")
local photofile_overclock_data = require("data.photofile_overclock_data")
local profile_overclock_data = require("data.profile_overclock_data")
local var_0_31 = L_PHOTOFILE_ROLE_DES.Girls
local var_0_32 = L_PHOTOFILE_ROLE_DES.Boss
local var_0_33 = L_PHOTOFILE_ROLE_DES.NPC
local var_0_34 = L_PHOTOFILE_ROLE_DES.Enemy
local var_0_35 = L_PHOTOFILE_ROLE_DES.NIGHTMARE
local var_0_36 = {
	"valuation",
	"resume",
	"record",
	"file_1",
	"file_2",
	"file_3",
	"file_4"
}

function PhotoFileRoleFileLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PhotoFileRoleFileLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PhotoFileRoleFileLayer:init(arg_3_1)
	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PhotoFile_role_file.json" or "PhotoFile_role_file.ExportJson")

	self:addChild(self.rootlayer)

	self.panel = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel")

	ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_back"):addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.infoTable then
			for iter_4_0 = 1, #self.infoTable do
				self.infoTable[iter_4_0]:stopAllActions()
				self.infoTable[iter_4_0]:setVisible(true)
				self.infoTable[iter_4_0]:setString(self.infoTableStr[iter_4_0])
			end
		end
	end)

	self.indexId = arg_3_1.id
	self.modelId = arg_3_1.modelid
	self.type = arg_3_1.contentType.contentType

	print("self.typeself.typeself.typeself.type######", self.type)

	self.PhotoFileLayer = arg_3_1.PhotoFileLayer
	self.servantid = arg_3_1.servantid

	if self.type == "file_player" or self.type == "file_overclock" then
		if arg_3_1.servantid then
			self.id = arg_3_1.servantid
			self.id = tonumber(self.id)
		else
			for iter_3_0, iter_3_1 in pairs(servant_data) do
				if iter_3_1.modelid == arg_3_1.modelid then
					self.id = iter_3_1.id
				end

				local var_3_0 = 1

				while iter_3_1["modelid" .. var_3_0] do
					if iter_3_1["modelid" .. var_3_0] == arg_3_1.modelid then
						self.id = iter_3_1.id
					end

					var_3_0 = var_3_0 + 1
				end
			end
		end

		self.id = self.id or tonumber(arg_3_1.modelid)
	else
		self.id = arg_3_1.modelid
	end

	self.bntReturn = ccui.Helper:seekWidgetByName(self.rootlayer, "Button_return")

	self.bntReturn:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.panelAttack then
			self.panelAttack:release()
		end

		if self.bntStatus then
			self.bntStatus:release()
		end

		LayerManager:removePopLayer()
	end)

	self.panelBottom = ccui.Helper:seekWidgetByName(self.rootlayer, "bottom")
	self.panelAttr = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_attr")
	self.panelInfo = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_fightInfo")
	self.labelNameOne = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_nameOne")

	self:changeData()
	self:initButtonStatus()
	self:initFightInfo()
	self:initPanelBottom()
	self:initImageHead()
	self:initPanelInfo()
	self:switchStatus(1)
	self:showText(self.infoTable)
	self:updateFightInfo((self.type == "file_player" or self.type == "file_overclock") and servant_data[self.id].modelid or self.id)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" and self.panelSkillInfo then
			self.panelSkillInfo:release()
		end
	end)
	self:fullScreen()
end

function PhotoFileRoleFileLayer:fullScreen()
	local var_7_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_41")

	var_7_0:setPositionY(var_7_0:getPositionY() - GameDisplay.fix_y)

	local var_7_1 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_21")

	var_7_1:setPositionY(var_7_1:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)

	local var_7_2 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_23")

	var_7_2:setPositionY(var_7_2:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)

	local var_7_3 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_head_portrait_bottom")

	var_7_3:setPositionY(var_7_3:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)

	local var_7_4 = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_fightInfo")

	var_7_4:setPositionY(var_7_4:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)
	self.panelAttr:setPositionY(self.panelAttr:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)

	local var_7_5 = ccui.Helper:seekWidgetByName(self.rootlayer, "bar_code")

	var_7_5:setPositionY(var_7_5:getPositionY() - GameDisplay.fix_y)

	local var_7_6 = ccui.Helper:seekWidgetByName(self.rootlayer, "bottom")

	var_7_6:setPositionY(var_7_6:getPositionY() - GameDisplay.fix_y)
	self.panelStatus:setPositionY(self.panelStatus:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)

	local var_7_7 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_26")

	var_7_7:setContentSize(cc.size(var_7_7:getContentSize().width, var_7_7:getContentSize().height + GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT))
	var_7_7:setPositionY(var_7_7:getPositionY() + (GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT) / 2)

	local var_7_8 = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_50")

	var_7_8:setPositionY(var_7_8:getPositionY() + (GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT) / 2)
end

local var_0_37

function PhotoFileRoleFileLayer:changeData()
	self.imageLogo = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_logo")
	self.skillTable = {}

	if self.type == "file_player" or self.type == "file_overclock" then
		self.path = "PhotoFile_role_file"
		self.pathSkill = "PhotoFile_weapon_frame/PhotoFile_souls_skill_frame"
		self.tablePhotoFile = var_0_31
		self.btnName = L_PHOTOFILE_DATA_BTN[1]
		self.fileInfo = favorfile_data

		self.labelNameOne:setString(major_factor_data[servant_data[self.id].major].easy_name)

		local var_8_0 = servant_data[self.id].modelid

		self.modelid = servant_data[self.id].modelid

		local var_8_1

		if not playermodel:isServantOverclockLockByTime(self.id) then
			var_8_1 = servant_data[self.id].oc_isopen1 or 0
		end

		self.skillTable = {
			model_data[var_8_0].passive,
			model_data[var_8_0].skill1,
			model_data[var_8_0].XP,
			model_data[var_8_0].ex_3
		}
		self.posY = 160
		self.btnTex = {
			self.path .. "/no_choice_btn_short.png",
			self.path .. "/choice_btn_short.png"
		}
		self.btnPos = {
			80,
			230,
			380,
			530
		}
		self.btnVisible = {
			1,
			1,
			1,
			1
		}
		self.redDotNeed = {
			0,
			0,
			0,
			var_8_1
		}
		self.redRule = {
			nil,
			"oc",
			nil,
			"oc"
		}

		if not playermodel:isServantOverclockLockByTime(self.id) then
			self.skillTable[#self.skillTable + 1] = model_data[var_8_0].over_clocking_skill
		end
	elseif self.type == "file_enemy1" then
		ccui.Helper:seekWidgetByName(self.rootlayer, "Image_line_role_frame"):setVisible(false)

		self.path = "PhotoFile_enemy_data"
		self.pathSkill = "PhotoFile_weapon_frame/PhotoFile_enemy_skill_frame"
		self.tablePhotoFile = var_0_32
		self.btnName = L_PHOTOFILE_DATA_BTN[2]

		self.labelNameOne:setString(photofile_xmas_data[2][self.indexId])
		self.labelNameOne:setColor(cc.c3b(250, 140, 188))

		self.fileInfo = photofile_xmas_data
		self.posY = 120

		local var_8_2 = 1

		var_0_37 = require("data.photofile_xmasfile_data")

		print("self.id======", self.id)

		if model_data[self.id].passive then
			self.skillTable[#self.skillTable + 1] = model_data[self.id].passive
		end

		while model_data[self.id]["skill" .. var_8_2] do
			self.skillTable[#self.skillTable + 1] = model_data[self.id]["skill" .. var_8_2]
			var_8_2 = var_8_2 + 1
		end

		if model_data[self.id].XP then
			self.skillTable[#self.skillTable + 1] = model_data[self.id].XP
		end

		self.btnPos = {
			150,
			450
		}
		self.btnTex = {
			self.path .. "/no_choice_btn.png",
			self.path .. "/choice_btn.png"
		}
		self.btnVisible = {
			1,
			1
		}
		self.redDotNeed = {
			0,
			0
		}

		self.imageLogo:loadTexture("PhotoFile_enemy_data/ai_logo.png", var_0_5)
	elseif self.type == "file_enemy6" then
		self.path = "PhotoFile_role_file"
		self.pathSkill = "PhotoFile_weapon_frame/PhotoFile_souls_skill_frame"
		self.tablePhotoFile = var_0_34
		self.btnName = L_PHOTOFILE_DATA_BTN[2]
		self.fileInfo = photofile_role_military_data

		self.labelNameOne:setString(photofile_role_military_data[1][self.indexId])

		local var_8_3 = 1

		var_0_37 = require("data.photofile_military_data")

		if model_data[self.id].passive then
			self.skillTable[#self.skillTable + 1] = model_data[self.id].passive
		end

		while model_data[self.id]["skill" .. var_8_3] do
			self.skillTable[#self.skillTable + 1] = model_data[self.id]["skill" .. var_8_3]
			var_8_3 = var_8_3 + 1
		end

		if model_data[self.id].XP then
			self.skillTable[#self.skillTable + 1] = model_data[self.id].XP
		end

		self.posY = 160
		self.btnPos = {
			150,
			450
		}
		self.btnTex = {
			self.path .. "/no_choice_btn.png",
			self.path .. "/choice_btn.png"
		}
		self.btnVisible = {
			1,
			1
		}
		self.redDotNeed = {
			0,
			0
		}

		self.imageLogo:loadTexture("PhotoFile_enemy_data/army_logo.png", var_0_5)
	elseif self.type == "file_enemy8" then
		self.path = "PhotoFile_role_file"
		self.pathSkill = "PhotoFile_weapon_frame/PhotoFile_souls_skill_frame"
		self.tablePhotoFile = var_0_34
		self.btnName = L_PHOTOFILE_DATA_BTN[2]
		self.fileInfo = photofile_role_foundation_data

		self.labelNameOne:setString(photofile_role_foundation_data[1][self.indexId])

		local var_8_4 = 1

		var_0_37 = require("data.photofile_foundation_data")

		if model_data[self.id].passive then
			self.skillTable[#self.skillTable + 1] = model_data[self.id].passive
		end

		while model_data[self.id]["skill" .. var_8_4] do
			self.skillTable[#self.skillTable + 1] = model_data[self.id]["skill" .. var_8_4]
			var_8_4 = var_8_4 + 1
		end

		if model_data[self.id].XP then
			self.skillTable[#self.skillTable + 1] = model_data[self.id].XP
		end

		self.posY = 160
		self.btnPos = {
			150,
			450
		}
		self.btnTex = {
			self.path .. "/no_choice_btn.png",
			self.path .. "/choice_btn.png"
		}
		self.btnVisible = {
			1,
			1
		}
		self.redDotNeed = {
			0,
			0
		}

		self.imageLogo:loadTexture("PhotoFile_enemy_data/foundation_logo.png", var_0_5)
	elseif self.type == "file_enemy10" then
		self.path = "PhotoFile_role_file"
		self.pathSkill = "PhotoFile_weapon_frame/PhotoFile_souls_skill_frame"
		self.tablePhotoFile = var_0_34
		self.btnName = L_PHOTOFILE_DATA_BTN[2]
		self.fileInfo = photofile_role_killer_data

		self.labelNameOne:setString(photofile_role_killer_data[1][self.indexId])

		local var_8_5 = 1

		var_0_37 = require("data.photofile_killer_data")

		if model_data[self.id].passive then
			self.skillTable[#self.skillTable + 1] = model_data[self.id].passive
		end

		while model_data[self.id]["skill" .. var_8_5] do
			self.skillTable[#self.skillTable + 1] = model_data[self.id]["skill" .. var_8_5]
			var_8_5 = var_8_5 + 1
		end

		if model_data[self.id].XP then
			self.skillTable[#self.skillTable + 1] = model_data[self.id].XP
		end

		self.posY = 160
		self.btnPos = {
			150,
			450
		}
		self.btnTex = {
			self.path .. "/no_choice_btn.png",
			self.path .. "/choice_btn.png"
		}
		self.btnVisible = {
			1,
			1
		}
		self.redDotNeed = {
			0,
			0
		}

		self.imageLogo:loadTexture("PhotoFile_enemy_data/killer_logo.png", var_0_5)
	elseif self.type == "file_enemy12" then
		self.path = "PhotoFile_enemy_data"
		self.pathSkill = "PhotoFile_weapon_frame/PhotoFile_enemy_skill_frame"
		self.tablePhotoFile = var_0_34
		self.btnName = L_PHOTOFILE_DATA_BTN[2]
		self.fileInfo = photofile_role_activity_data

		self.labelNameOne:setString(photofile_role_activity_data[1][self.indexId])

		local var_8_6 = 1

		var_0_37 = require("data.photofile_activity_data")

		if model_data[self.id].passive then
			self.skillTable[#self.skillTable + 1] = model_data[self.id].passive
		end

		while model_data[self.id]["skill" .. var_8_6] do
			self.skillTable[#self.skillTable + 1] = model_data[self.id]["skill" .. var_8_6]
			var_8_6 = var_8_6 + 1
		end

		if model_data[self.id].XP then
			self.skillTable[#self.skillTable + 1] = model_data[self.id].XP
		end

		self.posY = 160
		self.btnPos = {
			150,
			450
		}
		self.btnTex = {
			self.path .. "/no_choice_btn.png",
			self.path .. "/choice_btn.png"
		}
		self.btnVisible = {
			1,
			1
		}
		self.redDotNeed = {
			0,
			0
		}

		self.imageLogo:loadTexture("PhotoFile_enemy_data/ai_logo.png", var_0_5)
	elseif self.type == "file_teacher" then
		self.path = "PhotoFile_role_file"
		self.pathSkill = "PhotoFile_weapon_frame/PhotoFile_souls_skill_frame"
		self.tablePhotoFile = var_0_33
		self.btnName = {}
		self.fileInfo = photofile_npc_data

		self.labelNameOne:setString(model_data[self.id].name)

		self.posY = 160
		self.btnPos = {}
		self.btnTex = {
			self.path .. "/no_choice_btn.png",
			self.path .. "/choice_btn.png"
		}
		self.btnVisible = {}
		self.skillTable = {}

		local var_8_7 = ccui.ImageView:create("PhotoFile_role_file/title_data.png", var_0_5)

		var_8_7:setPosition(cc.p(320, 598 + GameDisplay.fix_y - GameDisplay.notch_height))
		ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_back"):addChild(var_8_7, 999)
	elseif self.type == "file_nightmare_xmasfile" then
		self.path = "PhotoFile_enemy_data"
		self.pathSkill = "PhotoFile_weapon_frame/PhotoFile_enemy_skill_frame"
		self.tablePhotoFile = var_0_35
		self.btnName = L_PHOTOFILE_DATA_BTN[2]
		self.fileInfo = photofile_nightmare_xmas_data

		self.labelNameOne:setString(photofile_nightmare_xmas_data[1][self.indexId])
		self.labelNameOne:setColor(cc.c3b(250, 140, 188))

		local var_8_8 = 1

		var_0_37 = require("data.photofile_nightmare_xmasfile_data")

		if model_data[self.id].passive then
			self.skillTable[#self.skillTable + 1] = model_data[self.id].passive
		end

		while model_data[self.id]["skill" .. var_8_8] do
			self.skillTable[#self.skillTable + 1] = model_data[self.id]["skill" .. var_8_8]
			var_8_8 = var_8_8 + 1
		end

		if model_data[self.id].XP then
			self.skillTable[#self.skillTable + 1] = model_data[self.id].XP
		end

		self.posY = 160
		self.btnPos = {
			150,
			450
		}
		self.btnTex = {
			self.path .. "/no_choice_btn.png",
			self.path .. "/choice_btn.png"
		}
		self.btnVisible = {
			1,
			1
		}
		self.redDotNeed = {
			0,
			0
		}

		self.imageLogo:loadTexture("PhotoFile_enemy_data/ai_logo.png", var_0_5)
	end
end

local var_0_38 = {
	file_player = function(arg_9_0)
		return photofile_data[arg_9_0].collect_offset_x or 0, photofile_data[arg_9_0].collect_offset_y or 0, photofile_data[arg_9_0].roleSize or 0.8
	end,
	file_overclock = function(arg_10_0)
		return profile_overclock_data[arg_10_0].collect_offset_x or 0, profile_overclock_data[arg_10_0].collect_offset_y or 0, profile_overclock_data[arg_10_0].roleSize or 0.6
	end,
	file_enemy1 = function(arg_11_0)
		return photofile_xmasfile_data[arg_11_0].collect_offset_x or 0, photofile_xmasfile_data[arg_11_0].collect_offset_y or 0, photofile_xmasfile_data[arg_11_0].roleSize or 0.8
	end,
	file_teacher = function(arg_12_0)
		return photofile_npcfiles_data[arg_12_0].collect_offset_x or 0, photofile_npcfiles_data[arg_12_0].collect_offset_y or 0, photofile_npcfiles_data[arg_12_0].roleSize or 0.8
	end,
	file_enemy6 = function(arg_13_0)
		return photofile_military_data[arg_13_0].collect_offset_x or 0, photofile_military_data[arg_13_0].collect_offset_y or 0, photofile_military_data[arg_13_0].roleSize or 0.8
	end,
	file_enemy8 = function(arg_14_0)
		return photofile_foundation_data[arg_14_0].collect_offset_x or 0, photofile_foundation_data[arg_14_0].collect_offset_y or 0, photofile_foundation_data[arg_14_0].roleSize or 0.8
	end,
	file_enemy10 = function(arg_15_0)
		return photofile_killer_data[arg_15_0].collect_offset_x or 0, photofile_killer_data[arg_15_0].collect_offset_y or 0, photofile_killer_data[arg_15_0].roleSize or 0.8
	end,
	file_enemy12 = function(arg_16_0)
		return photofile_activity_data[arg_16_0].collect_offset_x or 0, photofile_activity_data[arg_16_0].collect_offset_y or 0, photofile_activity_data[arg_16_0].roleSize or 0.8
	end,
	file_nightmare_xmasfile = function(arg_17_0)
		return photofile_nightmare_xmasfile_data[arg_17_0].collect_offset_x or 0, photofile_nightmare_xmasfile_data[arg_17_0].collect_offset_y or 0, photofile_nightmare_xmasfile_data[arg_17_0].roleSize or 0.8
	end
}

function PhotoFileRoleFileLayer:initImageHead()
	self.imageHeadPortraitBottom = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_bottom")

	self.imageHeadPortraitBottom:loadTexture(self.path .. "/role_head_frame.png", var_0_5)
	self.imageHeadPortraitBottom:setTouchEnabled(true)
	self.imageHeadPortraitBottom:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_19_0 = {
			id = self.id,
			type = self.type,
			indexId = self.indexId,
			PhotoFileLayer = self.PhotoFileLayer,
			servantid = self.servantid
		}

		if self.type == "file_overclock" then
			var_19_0.id = self.modelId
		end

		AnalyticManager.enterImageRoleFile({
			servantID = self.servantid
		})
		LayerManager:pushInLayer("PhotoFileRoleImageLayer", var_19_0)
	end)

	self.panelHeadPortrait = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_head_portrait")
	self.btnMag = ccui.Helper:seekWidgetByName(self.rootlayer, "Button_scaleToBig")

	self.btnMag:loadTextures(self.path .. "/scale_big.png", nil, nil, var_0_5)
	self.btnMag:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_20_0 = {
			id = self.id,
			type = self.type,
			indexId = self.indexId,
			PhotoFileLayer = self.PhotoFileLayer,
			servantid = self.servantid
		}

		if self.type == "file_overclock" then
			var_20_0.id = self.modelId
		end

		AnalyticManager.enterImageRoleFile({
			servantID = self.servantid
		})
		LayerManager:pushInLayer("PhotoFileRoleImageLayer", var_20_0)
	end)

	local var_18_1 = self.type ~= "file_overclock" and cc.Sprite:create("roleimage/role/" .. model_data[(self.type == "file_player" or self.type == "file_overclock") and servant_data[self.id].modelid or self.id].role_image .. ".png") or cc.Sprite:create("roleimage/role/" .. model_data[tostring(self.modelId)].role_image .. ".png")

	var_18_1:setOpacity(204)

	local var_18_2, var_18_3, var_18_4 = var_0_38[self.type](self.indexId)

	var_18_1:setScale(var_18_4)
	var_18_1:setPosition(cc.p(self.panelHeadPortrait:getContentSize().width / 2 + var_18_2, self.panelHeadPortrait:getContentSize().height / 2 + var_18_3))
	self.panelHeadPortrait:addChild(var_18_1, 999)
	var_18_1:setAnchorPoint(cc.p(0.48, 0.75))

	self.activityRay = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_ray")

	self.activityRay:loadTexture(self.path .. "/sweep_light.png", var_0_5)
	self.activityRay:setScale(1.1)
	self.activityRay:setLocalZOrder(9999)

	local var_18_5 = self.activityRay:getPositionX()

	self.activityRay:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveTo:create(0, cc.p(var_18_5, self.panelHeadPortrait:getContentSize().height + 100)), cc.MoveTo:create(5, cc.p(var_18_5, -159)))))
end

function PhotoFileRoleFileLayer:initFightInfo()
	self.panelInfos = {}

	local var_21_0 = 26
	local var_21_1 = 267
	local var_21_2 = 58

	for iter_21_0 = 1, #L_PHOTOFILE_FIGHT_ATTR_DATA do
		local var_21_3 = cc.Label:createWithTTF(L_PHOTOFILE_FIGHT_ATTR_DATA[iter_21_0], "fonts/name.ttf", 20)

		if self.type == "file_enemy1" then
			var_21_3:setColor(cc.c3b(250, 140, 188))
		else
			var_21_3:setColor(cc.c3b(1, 181, 253))
		end

		var_21_3:setPosition(cc.p(var_21_0, var_21_1))

		local var_21_4 = ccui.ImageView:create(self.path .. "/fight_bar_bottom.png", var_0_5)

		var_21_4:setPosition(cc.p(var_21_0 + 30, var_21_1))
		var_21_4:setAnchorPoint(cc.p(0, 0.5))
		var_21_4:setSkewY(30)

		var_21_1 = var_21_1 - var_21_2
		self.panelInfos[iter_21_0] = var_21_3

		self.panelInfo:getChildByName("Image_32"):loadTexture(self.path .. "/role_fight_info_frame.png", var_0_5)
		self.panelAttr:addChild(var_21_3)
		self.panelAttr:addChild(var_21_4)
	end
end

function PhotoFileRoleFileLayer:initButtonStatus()
	self.panelStatus = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_status")
	self.btnStatus = ccui.Helper:seekWidgetByName(self.panelStatus, "Button_status")
	self.statusBnts = {}

	self.btnStatus:retain()
	self.btnStatus:removeFromParent()

	for iter_22_0 = 1, #self.btnName do
		local var_22_0 = self.btnStatus:clone()

		var_22_0:loadTextures(self.btnTex[1], self.btnTex[2], self.btnTex[2], var_0_5)
		var_22_0:setPositionX(self.btnPos[iter_22_0])
		var_22_0:getChildByName("Label_status"):setString(self.btnName[iter_22_0])
		var_22_0:getChildByName("Label_status"):setPosition(cc.p(var_22_0:getContentSize().width / 2, var_22_0:getContentSize().height / 2))
		self.panelStatus:addChild(var_22_0)

		self.statusBnts[iter_22_0] = var_22_0

		var_22_0:addTouchEventListener(function(arg_23_0, arg_23_1)
			if arg_23_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:switchStatus(iter_22_0)

			if arg_23_0:getChildByName("reddot") then
				arg_23_0:getChildByName("reddot"):removeFromParent()
			end
		end)
		var_22_0:setVisible(self.btnVisible[iter_22_0] == 1)

		if self.redDotNeed[iter_22_0] == 1 then
			self:initRedDot(var_22_0, iter_22_0, {
				x = 140,
				y = 50
			})
		end
	end
end

function PhotoFileRoleFileLayer:initRedDot(arg_24_1, arg_24_2, arg_24_3)
	if self.redRule[arg_24_2] then
		({
			oc = function(self, arg_25_1)
				if not playermodel.soulOverClock[self.id] or playermodel.soulOverClock[self.id] < 1 then
					return
				end

				if RoleDefault:getInstance():getBoolForKey("is_oc_first_" .. arg_24_2 .. "_" .. self.id, false) then
					return
				end

				local var_25_0 = ccui.ImageView:create("public/reddot/reddot0.png", var_0_5)

				var_25_0:setName("reddot")
				var_25_0:setAnchorPoint(cc.p(0.5, 0))
				var_25_0:setPosition(cc.p(arg_25_1.x, arg_25_1.y))
				self:addChild(var_25_0, 5)
			end
		})[self.redRule[arg_24_2]](arg_24_1, arg_24_3)
	end
end

function PhotoFileRoleFileLayer:switchStatus(arg_26_1)
	self.statusID = arg_26_1

	for iter_26_0, iter_26_1 in pairs(self.statusBnts) do
		if iter_26_0 == self.statusID then
			iter_26_1:setBright(false)
			iter_26_1:getChildByName("Label_status"):setColor(cc.c3b(40, 47, 57))
		else
			iter_26_1:setBright(true)
			iter_26_1:getChildByName("Label_status"):setColor(cc.c3b(40, 47, 57))
			self:switchPanelInfo()
		end
	end

	if self.infoTable then
		for iter_26_2 = 1, #self.infoTable do
			self.infoTable[iter_26_2]:stopAllActions()
			self.infoTable[iter_26_2]:setVisible(true)
			self.infoTable[iter_26_2]:setString(self.infoTableStr[iter_26_2])
		end
	end
end

function PhotoFileRoleFileLayer:initPanelBottom()
	self.panels = {}

	local var_27_0 = {
		"Panel_fightStatus",
		"Panel_fightA",
		"Panel_fightB",
		"Panel_oc"
	}

	for iter_27_0 = 1, #var_27_0 do
		self.panels[iter_27_0] = ccui.Helper:seekWidgetByName(self.panelBottom, var_27_0[iter_27_0])

		self.panels[iter_27_0]:setPosition(cc.p(self.panels[iter_27_0]:getPositionX(), self.panels[iter_27_0]:getPositionY() + (GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT) / 2))
	end
end

function PhotoFileRoleFileLayer:switchPanelInfo()
	for iter_28_0, iter_28_1 in pairs(self.panels) do
		if iter_28_0 == self.statusID then
			iter_28_1:setVisible(true)
		else
			iter_28_1:setVisible(false)
		end
	end
end

function PhotoFileRoleFileLayer.animation(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_1.labelObj
	local var_29_1 = arg_29_1.str
	local var_29_2 = utfstrlen(arg_29_1.str)
	local var_29_3 = 1

	arg_29_1.labelObj:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0.01), cc.CallFunc:create(function()
		var_29_0:setString(utfmatch(var_29_1, var_29_3))
		var_29_0:setVisible(true)

		var_29_3 = var_29_3 + 1

		if var_29_3 > var_29_2 then
			var_29_0:stopAllActions()
		end
	end))))
end

function PhotoFileRoleFileLayer.showText(arg_31_0, arg_31_1)
	for iter_31_0 = 1, #arg_31_1 do
		arg_31_1[iter_31_0]:setVisible(false)
		arg_31_1[iter_31_0]:runAction(cc.Sequence:create(cc.DelayTime:create(iter_31_0 * 0.1), cc.CallFunc:create(function()
			local var_32_0 = {
				[iter_31_0] = {}
			}

			var_32_0[iter_31_0].labelObj = arg_31_1[iter_31_0]
			var_32_0[iter_31_0].str = arg_31_1[iter_31_0]:getString()

			arg_31_0:animation(var_32_0[iter_31_0])
		end)))
	end
end

function PhotoFileRoleFileLayer:initPanelInfo()
	self.bntSkills = {}

	ccui.Helper:seekWidgetByName(self.rootlayer, "Image_21"):loadTexture(self.path .. "/top_dec.png", var_0_5)
	ccui.Helper:seekWidgetByName(self.rootlayer, "Image_23"):loadTexture(self.path .. "/top_right_dec.png", var_0_5)
	ccui.Helper:seekWidgetByName(self.rootlayer, "Image_26"):loadTexture(self.path .. "/info_bottom.png", var_0_5)
	ccui.Helper:seekWidgetByName(self.rootlayer, "Image_42"):loadTexture(self.path .. "/electric.png", var_0_5)
	ccui.Helper:seekWidgetByName(self.rootlayer, "Image_44"):loadTexture(self.path .. "/electric.png", var_0_5)
	ccui.Helper:seekWidgetByName(self.rootlayer, "bar_code"):loadTexture(self.path .. "/bar_code.png", var_0_5)

	if self.path == "PhotoFile_enemy_data" then
		ccui.Helper:seekWidgetByName(self.rootlayer, "Image_41"):loadTexture(self.path .. "/under_bottom.png", var_0_5)
	end

	ccui.Helper:seekWidgetByName(self.rootlayer, "Image_51"):loadTexture(self.pathSkill .. "/more.png", var_0_5)

	for iter_33_0, iter_33_1 in pairs(self.panels) do
		if iter_33_0 == 1 then
			self.infoTable = {}

			local var_33_0 = 40
			local var_33_1 = 240
			local var_33_2 = 40
			local var_33_3 = ccui.Helper:seekWidgetByName(iter_33_1, "Panel_info_one")

			var_33_3:retain()
			var_33_3:removeFromParent()

			local var_33_4 = 0

			for iter_33_2 = 1, #self.tablePhotoFile do
				if self.fileInfo[self.tablePhotoFile[iter_33_2][2]][self.indexId] then
					var_33_4 = var_33_4 + 1
				end
			end

			local var_33_5 = self.posY - math.ceil((#self.tablePhotoFile - var_33_4) / 2)
			local var_33_6 = 1

			for iter_33_3 = 1, #self.tablePhotoFile do
				local var_33_7 = var_33_3:clone()

				if self.modelid and global_get_model_attr(self.modelid) == "umaru" then
					var_33_7:setPosition(cc.p(var_33_0, var_33_5))

					if self.fileInfo[self.tablePhotoFile[iter_33_3][2]][self.indexId] ~= "未知" then
						var_33_7:getChildByName("Label_info"):setString(self.tablePhotoFile[iter_33_3][1] .. ":")
						var_33_7:getChildByName("Label_71"):setString(self.fileInfo[self.tablePhotoFile[iter_33_3][2]][self.indexId] or L_NO_BRIEF_INTRO)

						if self.tableColor then
							var_33_7:getChildByName("Label_info"):setColor(self.tableColor)
						else
							var_33_7:getChildByName("Label_info"):setColor(cc.c3b(1, 181, 253))
						end

						var_33_0 = var_33_0 + var_33_1

						local var_33_8 = var_33_7:getChildByName("Label_info")

						if utfstrlen(var_33_8:getString()) + utfstrlen(var_33_7:getChildByName("Label_71").getString(var_33_8)) >= 13 then
							var_33_0 = var_33_0 + 40
						end

						if var_33_6 % 2 == 0 then
							var_33_5 = var_33_5 - var_33_2
							var_33_0 = 40
						end

						var_33_7:getChildByName("Label_71"):setPositionX(var_33_7:getChildByName("Label_info"):getContentSize().width + var_33_7:getChildByName("Label_info"):getPositionX() + 5)

						self.infoTable[#self.infoTable + 1] = var_33_7:getChildByName("Label_71")

						iter_33_1:addChild(var_33_7)

						var_33_6 = var_33_6 + 1
					end
				else
					var_33_7:setPosition(cc.p(var_33_0, var_33_5))
					var_33_7:getChildByName("Label_info"):setString(self.tablePhotoFile[iter_33_3][1] .. ":")
					var_33_7:getChildByName("Label_71"):setString(self.fileInfo[self.tablePhotoFile[iter_33_3][2]][self.indexId] or L_NO_BRIEF_INTRO)

					if self.tableColor then
						var_33_7:getChildByName("Label_info"):setColor(self.tableColor)
					else
						var_33_7:getChildByName("Label_info"):setColor(cc.c3b(1, 181, 253))
					end

					var_33_0 = var_33_0 + var_33_1

					local var_33_11 = var_33_7:getChildByName("Label_info")

					if utfstrlen(var_33_11:getString()) + utfstrlen(var_33_7:getChildByName("Label_71").getString(var_33_11)) >= 13 then
						var_33_0 = var_33_0 + 40
					end

					if iter_33_3 % 2 == 0 then
						var_33_5 = var_33_5 - var_33_2
						var_33_0 = 40
					end

					var_33_7:getChildByName("Label_71"):setPositionX(var_33_7:getChildByName("Label_info"):getContentSize().width + var_33_7:getChildByName("Label_info"):getPositionX() + 5)

					self.infoTable[#self.infoTable + 1] = var_33_7:getChildByName("Label_71")

					iter_33_1:addChild(var_33_7)
				end
			end

			local var_33_14 = ccui.Helper:seekWidgetByName(iter_33_1, "Label_bgStory")
			local var_33_15 = 0

			if self.type ~= "file_player" then
				if self.type == "file_overclock" then
					var_33_14:setString(self.fileInfo[20][self.indexId] or L_NO_BRIEF_INTRO)

					var_33_15 = utfstrlen(self.fileInfo[20][self.indexId] or L_NO_BRIEF_INTRO)
				elseif self.type == "file_enemy1" then
					var_33_14:setString(self.fileInfo[9][self.indexId] or L_NO_BRIEF_INTRO)

					var_33_15 = utfstrlen(self.fileInfo[9][self.indexId] or L_NO_BRIEF_INTRO)
				elseif self.type == "file_teacher" then
					var_33_14:setString(self.fileInfo[12][self.indexId] or L_NO_BRIEF_INTRO)

					var_33_15 = utfstrlen(self.fileInfo[12][self.indexId] or L_NO_BRIEF_INTRO)
				elseif self.type == "file_nightmare_xmasfile" then
					var_33_14:setString(self.fileInfo[9][self.indexId] or L_NO_BRIEF_INTRO)

					var_33_15 = utfstrlen(self.fileInfo[9][self.indexId] or L_NO_BRIEF_INTRO)
				end
			end

			var_33_14:setString(self.fileInfo[13][self.indexId] or L_NO_BRIEF_INTRO)

			var_33_15 = utfstrlen(self.fileInfo[13][self.indexId] or L_NO_BRIEF_INTRO)

			if var_33_15 / 24 > 9 then
				local var_33_20 = (math.ceil(var_33_15 / 24) - 9) * 27

				var_33_14:setContentSize(cc.size(var_33_14:getContentSize().width, var_33_14:getContentSize().height + var_33_20))
				ccui.Helper:seekWidgetByName(iter_33_1, "ScrollView_bg"):setInnerContainerSize(cc.size(var_33_14:getContentSize().width, var_33_14:getContentSize().height + var_33_20))
				var_33_14:setPositionY(var_33_14:getContentSize().height + var_33_20)
			end

			self.infoTable[#self.infoTable + 1] = var_33_14
			self.infoTableStr = {}

			for iter_33_4 = 1, #self.infoTable do
				self.infoTableStr[iter_33_4] = self.infoTable[iter_33_4]:getString()
			end

			var_33_3:release()

			if iter_33_0 == #self.statusBnts or #self.statusBnts == 0 then
				break
			end
		elseif iter_33_0 == 2 then
			self.listViewSkill = ccui.Helper:seekWidgetByName(iter_33_1, "ListView_skill")

			self.listViewSkill:setPositionY(self.listViewSkill:getPositionY() - (GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT) / 2)
			self.listViewSkill:setContentSize(cc.size(self.listViewSkill:getContentSize().width, self.listViewSkill:getContentSize().height + GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT))
			self.listViewSkill:setItemsMargin(10)

			self.panelSkillInfo = ccui.Helper:seekWidgetByName(iter_33_1, "Panel_skillInfo")

			self.panelSkillInfo:retain()
			self.panelSkillInfo:removeFromParent()

			local var_33_21 = self.skillTable

			for iter_33_5 = 1, #self.skillTable do
				local var_33_22 = self.panelSkillInfo:clone()
				local var_33_23 = var_33_22:getChildByName("Image_skillFrame")

				if self.type == "file_enemy1" then
					var_33_23:getChildByName("Image_46"):loadTexture("PhotoFile_enemy_data/skill_line.png", var_0_5)
				end

				var_33_23:loadTexture(self.pathSkill .. "/normal_skill_frame.png", var_0_5)

				if iter_33_5 == 1 then
					var_33_23:loadTexture(self.pathSkill .. "/big_skill_frame.png", var_0_5)
				end

				local var_33_24 = var_33_23:getChildByName("Label_skillName")
				local var_33_25 = var_33_23:getChildByName("Label_desc")

				var_33_25:setVisible(false)

				local var_33_27 = ccui.ImageView:create("skill_new/skill/" .. (total_skill_data[var_33_21[iter_33_5]].icon and total_skill_data[var_33_21[iter_33_5]].icon or "ex3") .. ".png", var_0_5)

				var_33_27:setPosition(cc.p(var_33_23:getContentSize().width / 2, var_33_23:getContentSize().height / 2))
				var_33_23:addChild(var_33_27, 999)
				var_33_27:setScale(0.85)
				var_33_24:setString(total_skill_data[var_33_21[iter_33_5]].name)

				local var_33_28 = RichTextPro:create()

				var_33_28:setMaxWidth(360)
				var_33_28:setSize(17)
				var_33_28:setLineSpace(1)
				var_33_28:setPosition(cc.p(var_33_25:getPositionX(), var_33_25:getPositionY() + 10))
				var_33_28:setName("richText")
				var_33_28:setAnchorPoint(cc.p(0, 0))

				local var_33_29

				if self.type == "file_enemy1" then
					var_33_29 = transSkillDesToRichText(total_skill_data[var_33_21[iter_33_5]].description, cc.c3b(178, 94, 222))

					var_33_24:setColor(cc.c3b(250, 140, 188))
				else
					var_33_29 = transSkillDesToRichText(total_skill_data[var_33_21[iter_33_5]].description, cc.c3b(54, 216, 189))
				end

				var_33_28:setText(var_33_29)

				local var_33_30, var_33_31 = var_33_28:getContentSize()

				var_33_23:addChild(var_33_28, 999)
				self.listViewSkill:pushBackCustomItem(var_33_22)

				if var_33_31 > 60 then
					local var_33_32 = ccui.Layout:create()

					var_33_32:setContentSize(cc.size(320, var_33_31 - 60))
					var_33_32:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
					var_33_32:setAnchorPoint(0, 0)
					var_33_32:setTouchEnabled(false)
					self.listViewSkill:pushBackCustomItem(var_33_32)
				end
			end

			if 116 * #var_33_21 > self.listViewSkill:getContentSize().height then
				ccui.Helper:seekWidgetByName(self.rootlayer, "Label_50"):setVisible(true)
			else
				ccui.Helper:seekWidgetByName(self.rootlayer, "Label_50"):setVisible(false)
			end

			if (playermodel.soulOverClock[self.id] or 0) >= 1 and not RoleDefault:getInstance():getBoolForKey("is_oc_first_" .. iter_33_0 .. "_" .. self.id, false) then
				RoleDefault:getInstance():setBoolForKey("is_oc_first_" .. iter_33_0 .. "_" .. self.id, true)
			end

			if iter_33_0 == #self.statusBnts then
				break
			end
		elseif iter_33_0 == 3 then
			local var_33_33 = var_0_16[tonumber(photofile_data[self.indexId].servant_id)].recommend_weapon2

			self.weaponName = ccui.Helper:seekWidgetByName(iter_33_1, "Label_weaponName")

			self.weaponName:setString(weapon_data[var_33_33].name)

			self.imageWeapon = ccui.Helper:seekWidgetByName(iter_33_1, "Image_weapon")

			self.imageWeapon:loadTexture("equipment/" .. weapon_data[var_33_33].image_id .. ".png")
			self.imageWeapon:setScale(0.75)

			local var_33_34 = weapon_manager:initWeaponInfowithItemid(var_33_33, {
				nowStars = 6,
				level = weapon_manager:getWeaponMaxLevelByItemid(var_33_33)
			})
			local var_33_35 = ccui.Helper:seekWidgetByName(iter_33_1, "Label_str1")
			local var_33_37 = 60

			if next(var_33_34) then
				self.info_label = {}

				local var_33_39 = {}

				table.insert(var_33_39, {
					key = "mainAttrDes",
					value = L_WEAPON_MAIN_ATTR .. "(满级)"
				})

				for iter_33_6, iter_33_7 in pairs(var_33_34.mainAttr) do
					table.insert(var_33_39, {
						key = iter_33_7.key,
						value = iter_33_7.value
					})
				end

				table.insert(var_33_39, {
					key = "subAttrDes",
					value = L_WEAPON_SUB_ATTR .. "(满级)"
				})

				for iter_33_8, iter_33_9 in pairs(var_33_34.subAttr) do
					table.insert(var_33_39, {
						key = iter_33_9.key,
						value = iter_33_9.value
					})
				end

				local var_33_40 = #var_33_34.mainAttr * 26 + 25

				for iter_33_10, iter_33_11 in pairs(var_33_39) do
					self.info_label[iter_33_10] = cc.Label:createWithTTF(iter_33_11.value, FONT_DES, 20)

					self.info_label[iter_33_10]:setAnchorPoint(cc.p(0, 1))

					if iter_33_11.key == "mainAttrDes" or iter_33_11.key == "subAttrDes" then
						self.info_label[iter_33_10]:setColor(cc.c3b(0, 216, 255))

						if iter_33_11.key == "subAttrDes" then
							var_33_40 = 10
						end
					else
						self.info_label[iter_33_10]:setColor(cc.c3b(203, 218, 235))
					end

					self.info_label[iter_33_10]:setPosition(cc.p(var_33_37, var_33_40))

					self.info_label[iter_33_10].key = iter_33_11.key

					iter_33_1:addChild(self.info_label[iter_33_10], 99)

					var_33_40 = var_33_40 - self.info_label[iter_33_10]:getContentSize().height
				end
			end

			if iter_33_0 == #self.statusBnts then
				break
			end
		elseif iter_33_0 == 4 then
			local var_33_41 = not playermodel.soulOverClock[self.id] or playermodel.soulOverClock[self.id] < 1
			local var_33_42 = RoleDefault:getInstance():getBoolForKey("is_oc_first_" .. iter_33_0 .. "_" .. self.id, false)

			ccui.Helper:seekWidgetByName(iter_33_1, "label_lock"):setVisible(false)
			RoleDefault:getInstance():setBoolForKey("is_oc_first_" .. iter_33_0 .. "_" .. self.id, true)

			if not self.oclistView then
				self.oclistView = ccui.ListView:create()

				self.oclistView:setName("oclistView")
				self.oclistView:setContentSize(cc.size(480, 330 + (GameDisplay.height + GameDisplay.fix_y - 1136) / 2))
				self.oclistView:setDirection(ccui.ListViewDirection.vertical)
				self.oclistView:setPosition(cc.p(50, -180 - (GameDisplay.height + GameDisplay.fix_y - 1136) / 4))
				iter_33_1:addChild(self.oclistView, 99)
				self.oclistView:setBounceEnabled(true)

				local var_33_43 = {}
				local var_33_44 = 1

				while photofile_overclock_data[var_0_16[self.id].major] and photofile_overclock_data[var_0_16[self.id].major]["des_" .. var_33_44] and photofile_overclock_data[var_0_16[self.id].major]["des_" .. var_33_44] ~= L_NO_BRIEF_INTRO do
					local var_33_45 = {
						title = photofile_overclock_data[var_0_16[self.id].major]["title_" .. var_33_44],
						des = photofile_overclock_data[var_0_16[self.id].major]["des_" .. var_33_44],
						order = photofile_overclock_data[var_0_16[self.id].major]["order_" .. var_33_44]
					}

					if var_33_41 then
						var_33_45.des = "超频后解锁"
					end

					table.insert(var_33_43, var_33_45)

					var_33_44 = var_33_44 + 1
				end

				local var_33_46 = playermodel.favor[var_0_16[self.id].major].favorlevel
				local var_33_47 = 1

				while deeparchive_data[self.id] and deeparchive_data[self.id]["level_" .. var_33_47] and deeparchive_data[self.id][var_0_36[var_33_47]] do
					local var_33_48 = {
						title = L_PHOTO_DEEP_FILE_NAME[var_33_47],
						des = deeparchive_data[self.id][var_0_36[var_33_47]]
					}

					var_33_48.order = deeparchive_data[self.id]["order" .. var_33_47] or #var_33_43 + 1

					if var_33_46 >= deeparchive_data[self.id]["level_" .. var_33_47] then
						table.insert(var_33_43, var_33_48)
					else
						var_33_48.des = "好感等级达到" .. deeparchive_data[self.id]["level_" .. var_33_47] .. "级后解锁"

						table.insert(var_33_43, var_33_48)
					end

					var_33_47 = var_33_47 + 1
				end

				for iter_33_12, iter_33_13 in pairs(var_33_43) do
					local var_33_49 = ccui.Layout:create()

					var_33_49:setTouchEnabled(true)
					var_33_49:setAnchorPoint(cc.p(0, 1))

					local var_33_50 = cc.Label:createWithTTF(iter_33_13.title, FONT_DES, 24)

					var_33_50:setAnchorPoint(cc.p(0, 1))
					var_33_50:setColor(cc.c3b(3, 129, 175))
					var_33_49:addChild(var_33_50)

					local var_33_51 = cc.Label:createWithTTF(iter_33_13.des, FONT_DES, 22)

					var_33_51:setMaxLineWidth(460)
					var_33_51:setAnchorPoint(cc.p(0, 0))
					var_33_49:addChild(var_33_51)
					var_33_49:setContentSize(cc.size(480, var_33_50:getContentSize().height + var_33_51:getContentSize().height + 50))
					var_33_50:setPosition(cc.p(10, var_33_49:getContentSize().height - 10))
					var_33_51:setPosition(cc.p(10, 10))
					self.oclistView:pushBackCustomItem(var_33_49)
				end
			end

			if iter_33_0 == #self.statusBnts then
				break
			end
		end
	end
end

function PhotoFileRoleFileLayer:updateFightInfo(arg_34_1)
	local var_34_1 = {}

	var_34_1[1] = model_data[arg_34_1].Outreak or 0
	var_34_1[2] = model_data[arg_34_1].Survival or 0
	var_34_1[3] = model_data[arg_34_1].Control or 0
	var_34_1[4] = model_data[arg_34_1].Dexterity or 0
	var_34_1[5] = model_data[arg_34_1].Support or 0

	for iter_34_0 = 1, #var_34_1 do
		local var_34_2 = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create(self.path .. "/fight_bar.png") or cc.Sprite:createWithSpriteFrameName(self.path .. "/fight_bar.png")))

		var_34_2:setType(cc.PROGRESS_TIMER_TYPE_BAR)
		var_34_2:setBarChangeRate(cc.p(1, 0))
		var_34_2:setMidpoint(cc.p(0, 0))
		var_34_2:setAnchorPoint(cc.p(0, 0.5))
		var_34_2:setName("fightBar")
		var_34_2:setSkewY(30)

		local var_34_3 = var_34_1[iter_34_0] / 10 * 100

		var_34_3 = var_34_1[iter_34_0] / 10 * 100 <= 100 and var_34_3 or 100

		var_34_2:setPercentage(var_34_3)
		var_34_2:setPosition(cc.p(self.panelInfos[iter_34_0]:getPositionX() + 30, self.panelInfos[iter_34_0]:getPositionY()))
		self.panelAttr:addChild(var_34_2, 999)
	end
end

function PhotoFileRoleFileLayer:exit()
	if self.panelAttack then
		self.panelAttack:release()
	end

	if self.bntStatus then
		self.bntStatus:release()
	end

	LayerManager:removePopLayer()
end
