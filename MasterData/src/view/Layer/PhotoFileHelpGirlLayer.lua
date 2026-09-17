PhotoFileHelpGirlLayer = class("PhotoFileHelpGirlLayer", function()
	return cc.Layer:create()
end)

require("data.constants")
require("view.Armature.L2Skeleton")
require("controller.goto_system_manager")

local network = require("network.network")
local var_0_1 = config._DEBUG and 0 or 1
local model_data = require("data.model_data")
local photofile_data = require("data.photofile_data")
local favorfile_data = require("data.favorfile_data")
local photofile_HelpGirl_data = require("data.photofile_HelpGirl_data")
local total_skill_data = require("data.total_skill_data")
local major_factor_data = require("data.major_factor_data")
local item_data = require("data.item_data")
local playermodel = require("model.playermodel")
local horcrux_data = require("data.horcrux_data")
local L2Actor = require("view.Sprite.L2Actor")
local horcrux_manager = require("controller.horcrux_manager")
local var_0_13
local var_0_15 = "file_player"
local var_0_16 = "file_weapon"
local var_0_23
local var_0_24
local var_0_25 = {}
local var_0_26 = L_PHOTOFILE_HELPGIRL_DES

function PhotoFileHelpGirlLayer:exit()
	if self.scheduler then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduler)
	end

	LayerManager:removePopLayer()

	var_0_23 = nil
end

function PhotoFileHelpGirlLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = PhotoFileHelpGirlLayer.new()

	var_3_0:init(arg_3_1)

	var_0_23 = var_3_0

	return var_3_0
end

function PhotoFileHelpGirlLayer:init(arg_4_1)
	self.count = 0
	var_0_24 = arg_4_1 or {}
	self.startPosX, self.endPosX = 0, 0
	self.info = arg_4_1.info
	self.id = arg_4_1.id
	self.modelid = arg_4_1.modelid
	self.index = arg_4_1.index
	self.type = arg_4_1.contentType.contentType

	self:changeData()

	self.init = false

	self:showContent(arg_4_1)

	local var_4_1 = ccui.Layout:create()

	var_4_1:setContentSize(GameDisplay.getScreenSize())
	var_4_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_4_1:setAnchorPoint(0, 0)
	var_4_1:setTouchEnabled(false)
	var_4_1:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(var_4_1, -1)

	self.itemid = 0

	if arg_4_1 then
		if arg_4_1.contentType.contentType == var_0_15 then
			self.itemid = photofile_data[self.id].item_id
		elseif arg_4_1.contentType.contentType == var_0_16 then
			self.itemid = photofile_HelpGirl_data[self.id].item_id
		end
	end

	return true
end

function PhotoFileHelpGirlLayer:changeData()
	if self.type == "file_enemy2" then
		var_0_13 = require("data.photofile_ai1_data")
	elseif self.type == "file_enemy3" then
		var_0_13 = require("data.photofile_ai2_data")
	elseif self.type == "file_enemy4" then
		var_0_13 = require("data.photofile_ai3_data")
	elseif self.type == "file_enemy5" then
		var_0_13 = require("data.photofile_ai4_data")
	elseif self.type == "file_enemy11" then
		var_0_13 = require("data.photofile_ai5_data")
	elseif self.type == "file_enemy7" then
		var_0_13 = require("data.photofile_militaryai_data")
	elseif self.type == "file_enemy9" then
		var_0_13 = require("data.photofile_foundationai_data")
	elseif self.type == "photofile_talk_level_data" then
		var_0_13 = require("data.photofile_talklevel_data")
	elseif self.type == "photofile_nightmare_xmasfile_data" then
		var_0_13 = require("data.photofile_nightmare_xmasfile_data")
	elseif self.type == "file_enemy_ai5" then
		var_0_13 = require("data.photofile_ai5_data")
	end
end

function PhotoFileHelpGirlLayer:showContent(arg_7_1)
	if not arg_7_1 or arg_7_1.contentType.contentType == var_0_15 then
		-- block empty
	elseif arg_7_1.contentType.contentType == var_0_16 then
		self:showWeaponDetail()
	else
		self:showAIDetail()
	end
end

function PhotoFileHelpGirlLayer.updateSoulDes(arg_8_0, ...)
	return
end

function PhotoFileHelpGirlLayer.moveToChange(arg_9_0, arg_9_1, arg_9_2)
	return
end

local var_0_27 = FONT_TITLE
local var_0_28 = FONT_DES

function PhotoFileHelpGirlLayer:initGirlDetailElement()
	if self.info and next(self.info) ~= nil then
		for iter_10_0, iter_10_1 in pairs(self.info) do
			if self.index == 0 or self.id == iter_10_1.id then
				self.index = iter_10_0
			end
		end
	else
		ccui.Helper:seekWidgetByName(self.rootlayer, "panel_back"):setBackGroundImage("mainScenebg/hocruxbg.jpg")
	end

	self.panel_root = ccui.Helper:seekWidgetByName(self.rootlayer, "panel_root")
	self.role = ccui.Helper:seekWidgetByName(self.rootlayer, "role")
	self.role_name = ccui.Helper:seekWidgetByName(self.rootlayer, "role_name")

	self.role_name:setString(major_factor_data[self.id].name)
	self.role_name:setFontName(var_0_27)

	self.role_detail = ccui.Helper:seekWidgetByName(self.rootlayer, "role_detail")

	self.role_detail:setFontName(var_0_27)

	self.button_love = ccui.Helper:seekWidgetByName(self.rootlayer, "button_love")

	self.button_love:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		network:rpc("vote_soul", {
			soulid = self.id
		}, function(arg_12_0)
			if arg_12_0.result == 1 then
				if playermodel.vote[self.id] == 1 then
					playermodel.vote[self.id] = 0

					self.button_love:loadTextures("photo_ui/fabulous_button.png", "photo_ui/fabulous_button.png", "", var_0_1)
				else
					playermodel.vote[self.id] = 1

					self.button_love:loadTextures("photo_ui/fabulous_button_on.png", "photo_ui/fabulous_button_on.png", "", var_0_1)
				end
			else
				global_ShowBlockWords(L_PHOTOFILE_OPERATE_FAIL)
			end
		end)
	end)

	var_0_25 = {}
	self.scheduler = nil

	local var_10_0 = 1
	local var_10_1 = 355

	function update(arg_13_0)
		local var_13_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "weapon"):clone()

		var_13_0:setVisible(true)
		var_13_0:setFontName(var_0_28)
		var_13_0:setString(var_0_26[var_10_0][1])

		var_0_25[var_0_26[var_10_0][2]] = var_13_0

		ccui.Helper:seekWidgetByName(self.rootlayer, "data_panel"):addChild(var_13_0)
		var_13_0:setPosition(cc.p(97, var_10_1))

		local var_13_1 = ccui.Helper:seekWidgetByName(self.rootlayer, "weapon_text"):clone()

		var_13_1:setVisible(true)
		var_13_1:setFontName(var_0_28)
		self:setGirlDetailText(var_13_1, var_0_26[var_10_0][2])
		ccui.Helper:seekWidgetByName(self.rootlayer, "data_panel"):addChild(var_13_1)
		var_13_1:setPosition(cc.p(268, var_10_1))

		var_10_1 = var_10_1 - 24
		var_10_0 = var_10_0 + 1

		if var_10_0 > #var_0_26 then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduler)
		end
	end

	self.scheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(update, 0.05, false)
	self.cute_icon = ccui.Helper:seekWidgetByName(self.rootlayer, "cute_icon")
end

function PhotoFileHelpGirlLayer:fullScreen()
	self.imageTalk:setPositionY(self.imageTalk:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)
	self.imageHeadBottom:setPositionY(self.imageHeadBottom:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)
	self.imageInfo:setPositionY(self.imageInfo:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)

	local var_14_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_23")

	var_14_0:setPositionY(var_14_0:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)
	self.image_21:setPositionY(self.image_21:getPositionY() - GameDisplay.fix_y)

	local var_14_1 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_skillPanelFrame")

	var_14_1:setPositionY(var_14_1:getPositionY() - GameDisplay.notch_height / 2)
	var_14_1:setContentSize(cc.size(var_14_1:getContentSize().width, var_14_1:getContentSize().height + GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT))

	local var_14_2 = ccui.Helper:seekWidgetByName(self.rootlayer, "ListView_skill")

	var_14_2:setContentSize(cc.size(var_14_2:getContentSize().width, var_14_2:getContentSize().height + GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT))
	var_14_2:setPositionY(var_14_2:getPositionY() - 10)

	local var_14_3 = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_50_0")

	var_14_3:setPositionY(var_14_3:getPositionY() + GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT)

	local var_14_4 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_22")

	var_14_4:setPositionY(var_14_4:getPositionY() - GameDisplay.fix_y)
	self.talking_text:setPositionY(self.talking_text:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)
end

function PhotoFileHelpGirlLayer:initHelpGirlDetailElementNew()
	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PhotoFile_helpGirl.json" or "PhotoFile_helpGirl.ExportJson")

	self:addChild(self.rootlayer)

	self.returnbtn = ccui.Helper:seekWidgetByName(self.rootlayer, "Button_return")

	self.returnbtn:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer()
	end)

	self.getWay = ccui.Helper:seekWidgetByName(self.rootlayer, "Button_getWay")
	self.help_name = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_name")
	self.imageRarity = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_rarity")
	self.imageHead = ccui.ImageView:create()
	self.imageHeadBottom = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_head")

	self.imageHead:setScale(0.8)
	self.imageHead:setPosition(cc.p(self.imageHeadBottom:getContentSize().width / 2, self.imageHeadBottom:getContentSize().height / 2 + 110))
	self.imageHeadBottom:addChild(self.imageHead, 999)

	self.panelSkill = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_skill")
	self.imageSkill = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_skill")
	self.imageInfo = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_info")
	self.panelStartOne = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_startOne")
	self.imageTalk = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_talk")
	self.talking_text = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_quotations")
	self.panelInfo = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_info")
	self.panelSkillContianer = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_skillContianer")
	self.imageAttr = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_attr")
	self.image_21 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_21")
	self.Panel_back = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_back")
end

PhotoFileHelpGirlLayer.initHelpGirlDetailElement = PhotoFileHelpGirlLayer.initHelpGirlDetailElementNew

function PhotoFileHelpGirlLayer.getAttrIconPath(arg_17_0, arg_17_1)
	return global_get_model_attr(horcrux_data[arg_17_1].model)
end

function PhotoFileHelpGirlLayer:showWeaponDetail()
	if not self.init then
		self.init = true

		self:initHelpGirlDetailElementNew()
	end

	local var_18_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_23")
	local var_18_1 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_skillPanelFrame")

	var_18_0:setOpacity(0)
	var_18_1:setOpacity(0)
	self.image_21:setOpacity(0)
	self:runAction(cc.Sequence:create(cc.CallFunc:create(function()
		var_18_0:runAction(cc.FadeIn:create(0.5))
	end), cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		var_18_1:runAction(cc.FadeIn:create(0.5))
	end), cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		self.image_21:runAction(cc.FadeIn:create(0.5))
	end)))
	ccui.Helper:seekWidgetByName(self.rootlayer, "Label_50_0"):setVisible(false)
	self.imageHead:loadTexture("roleimage/role1/" .. model_data[photofile_HelpGirl_data[self.id].model_id].cute_role .. ".png")

	local var_18_2 = split(photofile_HelpGirl_data[self.id].declaration, "—")[1]
	local var_18_3 = cc.Label:createWithTTF(var_18_2, FONT_NAME, 19)

	var_18_3:setMaxLineWidth(260)
	var_18_3:setAnchorPoint(cc.p(0, 1))
	self.Panel_back:addChild(var_18_3, 999)
	self.talking_text:setString(var_18_2)
	self.talking_text:setVisible(false)

	local var_18_4 = var_18_3:getContentSize()

	self.imageTalk:setScaleX(var_18_4.width / self.imageTalk:getContentSize().width + 0.1)
	self.imageTalk:setScaleY(var_18_4.height / self.imageTalk:getContentSize().height + 0.5)

	if photofile_HelpGirl_data[self.id].umaru then
		self.imageTalk:setVisible(false)
		var_18_3:setVisible(false)
	end

	var_18_3:setPositionX(self.imageTalk:getPositionX() - var_18_3:getContentSize().width / 2)
	var_18_3:setPositionY(self.imageTalk:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)

	local var_18_5 = photofile_HelpGirl_data[self.id].item_id or 3050926
	local var_18_7 = L_SHOW_HORCRUX_INFO.skill1Name
	local var_18_8 = L_SHOW_HORCRUX_INFO.skill2Name
	local var_18_9 = L_SHOW_HORCRUX_INFO.skill1Des
	local var_18_10 = L_SHOW_HORCRUX_INFO.skill2Des
	local var_18_11
	local var_18_12

	if horcrux_data[var_18_5].skill1 then
		var_18_7 = total_skill_data[horcrux_data[var_18_5].skill1].name
		var_18_11 = total_skill_data[horcrux_data[var_18_5].skill1].icon
		var_18_9 = total_skill_data[horcrux_data[var_18_5].skill1].description
	end

	if horcrux_data[var_18_5].skill2 then
		var_18_8 = total_skill_data[horcrux_data[var_18_5].skill2].name
		var_18_12 = total_skill_data[horcrux_data[var_18_5].skill2].icon
		var_18_10 = total_skill_data[horcrux_data[var_18_5].skill2].description
	end

	ccui.Helper:seekWidgetByName(self.rootlayer, "Image_line_role_frame"):setVisible(false)
	self.help_name:setString(horcrux_data[var_18_5].name)
	self.getWay:addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopGoGainLayer", {
			goto_back_system_id = 171,
			item = self.itemid,
			goto_back_system_config = {
				initPage = var_0_24.contentType.leftSelectIndex
			},
			surecallback = function(arg_23_0)
				if require("controller.layerconfig.pop_layer_infos")[arg_23_0] then
					-- block empty
				else
					self:exit()
				end

				AnalyticManager.clickGetWayBtn({
					HorcruxID = self.itemid
				})
			end
		})
	end)
	self.imageAttr:loadTexture(CAREER_ICON[horcrux_data[var_18_5].career .. "_" .. self:getAttrIconPath(var_18_5)], var_0_1)
	self.imageAttr:setPosition(cc.p(16, 390))

	local var_18_13 = "public/rolebg/" .. horcrux_manager:getRaceByItemid(var_18_5) .. ".png"
	local var_18_14 = ccui.ImageView:create("public/rolebg/race_bg.png", var_0_1)

	var_18_14:setPositionX(246)
	var_18_14:setPositionY(358)
	var_18_14:setVisible(true)
	self.imageInfo:addChild(var_18_14)

	local var_18_15 = ccui.ImageView:create(var_18_13, var_0_1)

	var_18_15:setVisible(true)
	var_18_15:setScale(0.6)
	var_18_15:setPositionX(var_18_14:getPositionX())
	var_18_15:setPositionY(var_18_14:getPositionY())
	self.imageInfo:addChild(var_18_15)
	var_18_15:setTouchEnabled(true)

	local var_18_16 = horcrux_manager:getTypeSkillByItemid(var_18_5)

	var_18_15:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_24_0 = var_18_16
		local var_24_1 = ccui.Layout:create()

		var_24_1:setTouchEnabled(true)
		var_24_1:setContentSize(cc.size(640, GameDisplay.height))
		var_24_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_24_1:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
		var_24_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_24_1:setBackGroundColor(cc.c3b(0, 0, 0))
		var_24_1:setBackGroundColorOpacity(120)
		var_24_1:addTouchEventListener(function(arg_25_0, arg_25_1)
			if arg_25_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_24_1:runAction(cc.RemoveSelf:create())
		end)

		local var_24_2 = ccui.ImageView:create("EquipLayer/skill_des_bg.png", var_0_1)

		var_24_2:setPosition(cc.p(320, 672))
		var_24_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_24_1:addChild(var_24_2)

		local var_24_3 = ccui.Layout:create()

		var_24_3:setContentSize(cc.size(500, 124))
		var_24_3:setAnchorPoint(cc.p(0, 0))
		var_24_3:setPosition(cc.p(70, 600))
		var_24_3:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_24_3:setBackGroundColor(cc.c3b(0, 0, 0))
		var_24_3:setBackGroundColorOpacity(0)
		var_24_1:addChild(var_24_3, 2)

		local var_24_4 = ccui.ImageView:create("EquipLayer/normal_skill_frame.png", var_0_1)

		var_24_4:setPosition(cc.p(58, 63))
		var_24_4:setAnchorPoint(cc.p(0.5, 0.5))
		var_24_3:addChild(var_24_4)

		local var_24_5 = ccui.ImageView:create(var_18_13, var_0_1)

		var_24_5:setScale(0.88)
		var_24_5:setPosition(cc.p(58, 63))
		var_24_3:addChild(var_24_5)

		local var_24_6 = cc.Label:createWithTTF(total_skill_data[var_24_0].name, FONT_DES, 24)

		var_24_6:setAnchorPoint(cc.p(0, 0.5))
		var_24_6:setPosition(cc.p(121, 96))
		var_24_3:addChild(var_24_6)

		if total_skill_data[var_24_0].cd then
			local var_24_7 = cc.Label:createWithTTF(L_SIKILL_CD .. total_skill_data[var_24_0].cd .. "s", FONT_DES, 20)

			var_24_7:setAnchorPoint(cc.p(1, 0.5))
			var_24_7:setPosition(cc.p(473, 96))
			var_24_3:addChild(var_24_7)
		end

		local var_24_8 = transSkillDesToRichText(total_skill_data[var_24_0].description)
		local var_24_9 = RichTextPro:create()

		var_24_9:setMaxWidth(380)
		var_24_9:setSize(20)
		var_24_9:setColor(cc.c3b(220, 251, 241))
		var_24_9:setLineSpace(0)
		var_24_9:setText(var_24_8)
		var_24_9:setName("richText")
		var_24_9:setPosition(cc.p(120, 86))
		var_24_3:addChild(var_24_9)
		self:addChild(var_24_1)
	end)
	self.imageInfo:getChildByName("Label_25"):setPositionX(65)
	self.imageInfo:getChildByName("Label_25"):setPositionY(287)
	self.imageInfo:getChildByName("Label_25_0"):setPositionY(287)

	while horcrux_data[var_18_5]["fac_range_damage_" .. 1] do
		if horcrux_data[var_18_5]["star_weight_" .. 1] and horcrux_data[var_18_5]["star_weight_" .. 1] > 0 then
			local var_18_17 = self.panelStartOne:clone()
			local var_18_18 = math.floor(tonumber(string.split(horcrux_data[var_18_5]["fac_range_hp_" .. 1], ",")[1]) / 100)
			local var_18_19 = math.floor(tonumber(string.split(horcrux_data[var_18_5]["fac_range_hp_" .. 1], ",")[2]) / 100)
			local var_18_20 = tonumber(string.split(horcrux_data[var_18_5]["fac_range_damage_" .. 1], ",")[1]) / 100
			local var_18_21 = tonumber(string.split(horcrux_data[var_18_5]["fac_range_damage_" .. 1], ",")[2]) / 100

			var_18_17:getChildByName("Label_start"):setString(1 .. L_QUALITY_STAR)
			var_18_17:getChildByName("Label_30"):setString(var_18_20 .. "~" .. var_18_21)
			var_18_17:getChildByName("Label_31"):setString(var_18_18 .. "~" .. var_18_19)
			var_18_17:setPosition(cc.p(14, 222))
			self.imageInfo:addChild(var_18_17, 999)
		end
	end

	self.imageRarity:loadTexture(FONT_RARITY_ICON[horcrux_data[photofile_HelpGirl_data[self.id].item_id].rarity], var_0_1)
	self.imageRarity:setPosition(cc.p(self.help_name:getPositionX() + self.help_name:getContentSize().width + 20, self.help_name:getPositionY()))
	self.imageSkill:getChildByName("Label_skillDesc"):setContentSize(cc.size(318, 90))
	self.imageSkill:getChildByName("Label_skillDesc"):setVisible(false)

	local var_18_24 = ccui.ScrollView:create()

	var_18_24:setContentSize(cc.size(330, 90))
	var_18_24:setDirection(ccui.ScrollViewDir.vertical)
	var_18_24:setBounceEnabled(true)
	var_18_24:setName("scrollView")
	var_18_24:setInnerContainerSize(cc.size(325, 90))
	var_18_24:setAnchorPoint(cc.p(0, 1))
	var_18_24:setPosition(113, 60)
	self.imageSkill:addChild(var_18_24)

	local var_18_25 = cc.Label:createWithTTF("", FONT_NAME, 20)

	var_18_25:setAnchorPoint(cc.p(0, 1))
	var_18_25:setMaxLineWidth(318)
	var_18_25:setPosition(cc.p(0, 90))
	var_18_25:setName("skillDes")
	var_18_24:addChild(var_18_25)

	local var_18_26 = cc.Label:createWithTTF("", FONT_NAME, 20)

	var_18_26:setMaxLineWidth(318)

	local var_18_28 = self.imageSkill:clone()
	local var_18_29

	if var_18_11 then
		var_18_29 = ccui.ImageView:create("skill_new/skill/" .. var_18_11 .. ".png", var_0_1) or ccui.ImageView:create("roleimage/role1/" .. model_data[photofile_HelpGirl_data[self.id].model_id].cute_role .. ".png")
	end

	var_18_29:setScale(0.85)

	if not var_18_11 then
		var_18_29:setAnchorPoint(cc.p(0.5, 0.5))
		var_18_29:setScale(0.35)
	end

	self.imageSkill:getChildByName("Panel_head"):addChild(var_18_29, 999)
	self.imageSkill:getChildByName("Label_skillName"):setString(var_18_7)
	self.imageSkill:getChildByName("scrollView"):getChildByName("skillDes"):setString(var_18_9)
	var_18_26:setString(var_18_9)
	var_18_24:setContentSize(cc.size(330, var_18_26:getContentSize().height > 90 and 90 or var_18_26:getContentSize().height + 10))
	var_18_24:setInnerContainerSize(cc.size(330, var_18_26:getContentSize().height + 10))
	var_18_25:setPositionY(var_18_26:getContentSize().height + 10)
	self.imageSkill:getChildByName("Label_skillDesc"):getVirtualRenderer():setMaxLineWidth(308)
	var_18_29:setPosition(cc.p(self.imageSkill:getChildByName("Panel_head"):getContentSize().width / 2, self.imageSkill:getChildByName("Panel_head"):getContentSize().height / 2))
	self.imageSkill:setPosition(cc.p(650, 65 + (GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT) / 2))

	local var_18_30

	if var_18_12 then
		var_18_30 = ccui.ImageView:create("skill_new/skill/" .. var_18_12 .. ".png", var_0_1) or ccui.ImageView:create("roleimage/role1/" .. model_data[photofile_HelpGirl_data[self.id].model_id].cute_role .. ".png")
	end

	var_18_30:setScale(0.85)

	if not var_18_12 then
		var_18_30:setAnchorPoint(cc.p(0.5, 0.5))
		var_18_30:setScale(0.35)
	end

	var_18_28:getChildByName("Panel_head"):addChild(var_18_30, 99)
	var_18_28:getChildByName("Label_skillName"):setString(var_18_8)

	local var_18_31 = cc.Label:createWithTTF("", FONT_NAME, 20)

	var_18_31:setAnchorPoint(cc.p(0, 1))
	var_18_31:setMaxLineWidth(318)
	var_18_31:setPosition(cc.p(0, 90))
	var_18_31:setName("skillDes")
	var_18_28:getChildByName("scrollView"):addChild(var_18_31)
	var_18_28:getChildByName("scrollView"):getChildByName("skillDes"):setString(var_18_10)
	var_18_26:setString(var_18_10)
	var_18_28:getChildByName("scrollView"):setContentSize(cc.size(330, var_18_26:getContentSize().height > 90 and 90 or var_18_26:getContentSize().height + 10))
	var_18_28:getChildByName("scrollView"):setInnerContainerSize(cc.size(330, var_18_26:getContentSize().height + 10))
	var_18_28:getChildByName("scrollView"):getChildByName("skillDes"):setPositionY(var_18_26:getContentSize().height + 10)
	var_18_28:getChildByName("Label_skillDesc"):getVirtualRenderer():setMaxLineWidth(308)
	var_18_30:setPosition(cc.p(var_18_28:getChildByName("Panel_head"):getContentSize().width / 2, var_18_28:getChildByName("Panel_head"):getContentSize().height / 2))
	var_18_28:setPosition(cc.p(650, -115 + (GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT) / 2))
	self.panelSkillContianer:addChild(var_18_28, 999)

	if not var_18_12 then
		local var_18_33 = item_data[var_18_5].image_offset_y or 0

		var_18_30:setPositionX(var_18_30:getPositionX() + (item_data[var_18_5].image_offse_x or 0))
		var_18_30:setPositionY(var_18_30:getPositionY() + var_18_33)
	end

	local var_18_34 = cc.ParticleSystemQuad:create("effect/particle/pop.plist")

	var_18_34:setAutoRemoveOnFinish(true)
	var_18_34:setPosition(cc.p(self.imageHeadBottom:getContentSize().width / 2, self.imageHeadBottom:getContentSize().height / 2 + 20 + GameDisplay.fix_y - GameDisplay.notch_height))
	self.imageHeadBottom:addChild(var_18_34, 999)
	self:fullScreen()
end

function PhotoFileHelpGirlLayer.addSpine(arg_26_0, arg_26_1, arg_26_2)
	local var_26_1 = L2Actor:create(ROLE_SPINE_PATH .. model_data[arg_26_2].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[arg_26_2].spine_model .. ".atlas", (model_data[arg_26_2].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[arg_26_2].clothes_model .. ".atlas" or nil))

	var_26_1:setScale(0.5, 0.5)
	var_26_1:playAni(nil, "idle", true)
	var_26_1:setPositionY(8)
	arg_26_1:addChild(var_26_1, 10)
end

function PhotoFileHelpGirlLayer:initFightInfo()
	self.panelInfos = {}

	local var_27_0 = 70
	local var_27_1 = 280
	local var_27_2 = 57

	for iter_27_0 = 1, #L_PHOTOFILE_FIGHT_ATTR_DATA do
		local var_27_3 = cc.Label:createWithTTF(L_PHOTOFILE_FIGHT_ATTR_DATA[iter_27_0], "fonts/name.ttf", 20)
		local var_27_4

		if self.type == "file_enemy2" or self.type == "file_enemy3" or self.type == "file_enemy4" or self.type == "file_enemy5" or self.type == "file_enemy7" or self.type == "file_enemy9" or self.type == "file_enemy11" or self.type == "file_enemy_ai5" then
			var_27_3:setColor(cc.c3b(250, 140, 188))

			var_27_4 = ccui.ImageView:create("PhotoFile_enemy_data/fight_bar_bottom.png", var_0_1)
		else
			var_27_3:setColor(cc.c3b(1, 181, 253))

			var_27_4 = ccui.ImageView:create("PhotoFile_role_file/fight_bar_bottom.png", var_0_1)
		end

		var_27_3:setPosition(cc.p(var_27_0, var_27_1))
		var_27_4:setPosition(cc.p(var_27_0 + 30, var_27_1))
		var_27_4:setAnchorPoint(cc.p(0, 0.5))
		var_27_4:setSkewY(30)

		var_27_1 = var_27_1 - var_27_2
		self.panelInfos[iter_27_0] = var_27_3

		self.panelInfo:addChild(var_27_3)
		self.panelInfo:addChild(var_27_4)
	end
end

function PhotoFileHelpGirlLayer:updateFightInfo(arg_28_1)
	local var_28_1 = {}

	var_28_1[1] = model_data[arg_28_1].Outreak or 5
	var_28_1[2] = model_data[arg_28_1].Survival or 5
	var_28_1[3] = model_data[arg_28_1].Control or 5
	var_28_1[4] = model_data[arg_28_1].Dexterity or 5
	var_28_1[5] = model_data[arg_28_1].Support or 5

	for iter_28_0 = 1, #var_28_1 do
		local var_28_3 = cc.ProgressTimer:create((self.type == "file_enemy2" or self.type == "file_enemy3" or self.type == "file_enemy4" or self.type == "file_enemy5" or self.type == "file_enemy7" or self.type == "file_enemy9" or self.type == "file_enemy11" or self.type == "file_enemy_ai5") and (config._DEBUG and cc.Sprite:create("PhotoFile_enemy_data/fight_bar.png") or cc.Sprite:createWithSpriteFrameName("PhotoFile_enemy_data/fight_bar.png")) or config._DEBUG and cc.Sprite:create("PhotoFile_role_file/fight_bar.png") or cc.Sprite:createWithSpriteFrameName("PhotoFile_role_file/fight_bar.png"))

		var_28_3:setType(cc.PROGRESS_TIMER_TYPE_BAR)
		var_28_3:setBarChangeRate(cc.p(1, 0))
		var_28_3:setMidpoint(cc.p(0, 0))
		var_28_3:setAnchorPoint(cc.p(0, 0.5))
		var_28_3:setName("fightBar")
		var_28_3:setSkewY(30)

		local var_28_4 = var_28_1[iter_28_0] / 10 * 100

		var_28_4 = var_28_1[iter_28_0] / 10 * 100 <= 100 and var_28_4 or 100

		var_28_3:setPercentage(var_28_4)
		var_28_3:setPosition(cc.p(self.panelInfos[iter_28_0]:getPositionX() + 30, self.panelInfos[iter_28_0]:getPositionY()))
		self.panelInfo:addChild(var_28_3, 999)
	end
end

function PhotoFileHelpGirlLayer:showAIDetail()
	if not self.init then
		self.init = true

		self:initHelpGirlDetailElementNew()
	end

	local var_29_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "ListView_skill")

	self.getWay:setVisible(false)
	self.imageAttr:setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootlayer, "Label_25"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootlayer, "Label_25_0"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootlayer, "Image_rarity"):setVisible(false)

	if self.type == "file_enemy2" or self.type == "file_enemy3" or self.type == "file_enemy4" or self.type == "file_enemy5" or self.type == "file_enemy7" or self.type == "file_enemy9" or self.type == "file_enemy11" or self.type == "file_enemy_ai5" then
		ccui.Helper:seekWidgetByName(self.rootlayer, "Image_line_role_frame"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootlayer, "Image_23"):loadTexture("PhotoFile_enemy_data/skill_name_bottom.png", var_0_1)
		ccui.Helper:seekWidgetByName(self.rootlayer, "Image_skillPanelFrame"):loadTexture("PhotoFile_enemy_data/info_bottom.png", var_0_1)
		ccui.Helper:seekWidgetByName(self.rootlayer, "Image_22"):loadTexture("PhotoFile_enemy_data/bar_code.png", var_0_1)
		ccui.Helper:seekWidgetByName(self.rootlayer, "Image_21"):loadTexture("PhotoFile_enemy_data/under_bottom.png", var_0_1)
		ccui.Helper:seekWidgetByName(self.rootlayer, "Label_50_0"):getChildByName("Image_51"):loadTexture("PhotoFile_weapon_frame/PhotoFile_enemy_skill_frame/more.png", var_0_1)
		self.imageInfo:loadTexture("PhotoFile_enemy_data/role_fight_info_frame.png", var_0_1)
		self.imageTalk:loadTexture("PhotoFile_enemy_data/quotations_frmae.png", var_0_1)
		self.imageHeadBottom:loadTexture("PhotoFile_enemy_data/qifen.png", var_0_1)
		self.help_name:setColor(cc.c3b(250, 140, 188))
	else
		ccui.Helper:seekWidgetByName(self.rootlayer, "Label_50_0"):getChildByName("Image_51"):loadTexture("PhotoFile_weapon_frame/PhotoFile_souls_skill_frame/more.png", var_0_1)
	end

	local var_29_1 = split(var_0_13[self.id].declaration, "—")[1]
	local var_29_2 = cc.Label:createWithTTF(var_29_1, FONT_NAME, 19)

	var_29_2:setMaxLineWidth(260)
	var_29_2:setAnchorPoint(cc.p(0, 1))
	self.Panel_back:addChild(var_29_2, 999)
	self.talking_text:setString(var_29_1)
	self.talking_text:setVisible(false)

	local var_29_3 = var_29_2:getContentSize()

	self.imageTalk:setScaleX(var_29_3.width / self.imageTalk:getContentSize().width + 0.1)
	self.imageTalk:setScaleY(var_29_3.height / self.imageTalk:getContentSize().height + 0.5)
	self.imageTalk:setPositionY(self.imageTalk:getPositionY() + 20)
	var_29_2:setPositionX(self.imageTalk:getPositionX() - var_29_2:getContentSize().width / 2)
	var_29_2:setPositionY(self.imageTalk:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)
	self.help_name:setString(model_data[self.modelid].name)
	self.imageHead:loadTexture("roleimage/role1/" .. model_data[self.modelid].cute_role .. ".png")
	self:initFightInfo()
	self:updateFightInfo(self.modelid)

	if self.type == "file_enemy2" or self.type == "file_enemy3" or self.type == "file_enemy4" or self.type == "file_enemy5" or self.type == "file_enemy7" or self.type == "file_enemy9" or self.type == "file_enemy11" or self.type == "file_enemy_ai5" then
		local var_29_4 = cc.ParticleSystemQuad:create("effect/particle/pop_ai.plist")

		var_29_4:setAutoRemoveOnFinish(true)
		var_29_4:setPosition(cc.p(self.imageHeadBottom:getContentSize().width / 2, self.imageHeadBottom:getContentSize().height / 2 + 20))
		self.imageHeadBottom:addChild(var_29_4, 999)
	else
		local var_29_5 = cc.ParticleSystemQuad:create("effect/particle/pop.plist")

		var_29_5:setAutoRemoveOnFinish(true)
		var_29_5:setPosition(cc.p(self.imageHeadBottom:getContentSize().width / 2, self.imageHeadBottom:getContentSize().height / 2 + 20))
		self.imageHeadBottom:addChild(var_29_5, 999)
	end

	local var_29_6 = 1

	local function var_29_7(arg_30_0)
		local var_30_0 = self.panelSkillContianer:clone()

		self.imageSkill:clone()

		local var_30_1 = var_30_0:getChildByName("Image_skill")
		local var_30_3 = total_skill_data[model_data[self.modelid][arg_30_0]].description or L_PHOTOFILE_HELPGIRL_FORBID_POINT
		local var_30_5 = var_30_1:getChildByName("Label_skillDesc")

		var_30_5:setVisible(false)

		local var_30_6 = RichTextPro:create()

		var_30_6:setMaxWidth(360)
		var_30_6:setSize(17)
		var_30_6:setLineSpace(1)
		var_30_6:setPosition(cc.p(var_30_5:getPositionX(), var_30_5:getPositionY() + 10))
		var_30_6:setName("richText")
		var_30_6:setAnchorPoint(cc.p(0, 0))
		var_30_6:setText((self.type == "file_enemy2" or self.type == "file_enemy3" or self.type == "file_enemy4" or self.type == "file_enemy5" or self.type == "file_enemy7" or self.type == "file_enemy9" or self.type == "file_enemy11" or self.type == "file_enemy_ai5") and transSkillDesToRichText(var_30_3, cc.c3b(178, 94, 222)) or transSkillDesToRichText(var_30_3, cc.c3b(54, 216, 189)))
		var_30_1:addChild(var_30_6, 999)
		var_30_1:getChildByName("Label_skillName"):setString(total_skill_data[model_data[self.modelid][arg_30_0]].name or L_PHOTOFILE_HELPGIRL_FORBID_POINT)

		if self.type == "file_enemy2" or self.type == "file_enemy3" or self.type == "file_enemy4" or self.type == "file_enemy5" or self.type == "file_enemy7" or self.type == "file_enemy9" or self.type == "file_enemy11" or self.type == "file_enemy_ai5" then
			var_30_1:loadTexture("PhotoFile_weapon_frame/PhotoFile_enemy_skill_frame/big_skill_frame.png", var_0_1)
			var_30_1:getChildByName("Image_17"):loadTexture("PhotoFile_enemy_data/skill_line.png", var_0_1)
			var_30_1:getChildByName("Label_skillName"):setColor(cc.c3b(250, 140, 188))
		else
			var_30_1:getChildByName("Label_skillName"):setColor(cc.c3b(1, 181, 253))
		end

		local var_30_8 = ccui.ImageView:create("skill_new/skill/" .. total_skill_data[model_data[self.modelid][arg_30_0]].icon .. ".png", var_0_1)

		var_30_8:setPosition(cc.p(var_30_1:getChildByName("Panel_head"):getContentSize().width / 2, var_30_1:getChildByName("Panel_head"):getContentSize().height / 2))
		var_30_8:setScale(0.85)
		var_30_1:getChildByName("Panel_head"):addChild(var_30_8, 999)

		local var_30_9, var_30_10 = var_30_6:getContentSize()
		local var_30_11 = math.max(0, var_30_10 - 62)

		var_30_0:setContentSize(cc.size(var_30_0:getContentSize().width, var_30_0:getContentSize().height + var_30_11))

		for iter_30_0, iter_30_1 in pairs(var_30_0:getChildren()) do
			iter_30_1:setPositionY(iter_30_1:getPositionY() + var_30_11)
		end

		var_29_0:pushBackCustomItem(var_30_0)
	end

	if model_data[self.modelid].passive then
		var_29_7("passive")
	end

	while model_data[self.modelid]["skill" .. var_29_6] do
		var_29_7("skill" .. var_29_6)

		var_29_6 = var_29_6 + 1
	end

	if model_data[self.modelid].XP then
		var_29_7("XP")
	end

	self:fullScreen()
end

function PhotoFileHelpGirlLayer.getAttrIconPath(arg_31_0, arg_31_1)
	return global_get_model_attr(horcrux_data[arg_31_1].model)
end

function PhotoFileHelpGirlLayer.getStageImageName(arg_32_0, arg_32_1)
	local var_32_0 = model_data[arg_32_1].wind and "wind_stage" or model_data[arg_32_1].fire and "fire_stage" or model_data[arg_32_1].water and "water_stage" or model_data[arg_32_1].light and "light_stage" or model_data[arg_32_1].dark and "dark_stage"

	var_32_0 = var_32_0 or "wind_stage"

	return var_32_0
end
