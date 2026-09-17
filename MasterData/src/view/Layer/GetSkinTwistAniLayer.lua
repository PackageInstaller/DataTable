GetSkinTwistAniLayer = class("GetSkinTwistAniLayer", function()
	return cc.Layer:create()
end)

local item_data = require("data.item_data")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local servant_data = require("data.servant_data")
local npc_data = require("data.npc_data")
local playermodel = require("model.playermodel")

require("view.Layer.BackGroundLayer")

local network = require("network.network")
local weapon_manager = require("controller.weapon_manager")
local audio_manager = require("controller.audio_manager")

require("data.constants")

local var_0_9 = {
	Star1 = {
		scale = 1,
		x = 14,
		y = 10
	},
	Star2 = {
		scale = 0.4,
		x = 37,
		y = 14
	},
	Star3 = {
		scale = 0.5,
		x = 23,
		y = 142
	},
	Star4 = {
		scale = 1,
		x = 610,
		y = 144
	},
	Star5 = {
		scale = 0.4,
		x = 580,
		y = 146
	},
	Star6 = {
		scale = 0.5,
		x = 610,
		y = 7
	}
}
local var_0_10 = config._DEBUG and 0 or 1
local var_0_11

function GetSkinTwistAniLayer.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	require("controller.texture_manager"):loadPopLayerTextures({
		"showNewRole"
	})

	local var_2_0 = GetSkinTwistAniLayer.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)

	return var_2_0
end

function GetSkinTwistAniLayer.getInstance()
	return var_0_11
end

function GetSkinTwistAniLayer:init(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	print("!!!!!!!!!!!!!!", arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)

	var_0_11 = self
	self.rootLayer = cc.Layer:create()

	self.rootLayer:setPosition(GameDisplay.fix_x, GameDisplay.fix_y)
	self.rootLayer:setCascadeOpacityEnabled(true)
	self:addChild(self.rootLayer)

	self.other_des = arg_4_4
	self.bg = ccui.Button:create(ROLEBG, ROLEBG, ROLEBG)

	self.bg:setAnchorPoint(cc.p(0.5, 0.5))
	self.bg:setPosition(cc.p(GameDisplay.width / 2 - GameDisplay.fix_x, GameDisplay.height / 2 - GameDisplay.fix_y))

	if not arg_4_3 then
		self.bg:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(function()
			self.bg:addTouchEventListener(function(arg_6_0, arg_6_1)
				if arg_6_1 ~= ccui.TouchEventType.ended then
					return
				end

				self:runAction(cc.RemoveSelf:create())
			end)
		end)))
	end

	self.rootLayer:addChild(self.bg, 0)
	self:showRole(arg_4_1)
	self:showInfo(arg_4_1)
	self:showEffect()
	self:showFormatDetial(arg_4_5)
	audio_manager:playeffectMusic(GAIN_NEW_ROLE_EFFECT)

	if not item_data[arg_4_1].servant then
		hx_print("item_data id " .. arg_4_1 .. " .servant is nil")
	end

	if item_data[arg_4_1].servant then
		if (servant_data[item_data[arg_4_1].servant].roll_rarity or 1) >= 4 then
			local var_4_1 = ccui.ImageView:create("public/rolebg/million_rare_img.png", var_0_10)

			var_4_1:setPosition(cc.p(var_4_1:getContentSize().width / 2, 1060 + GameDisplay.fix_y))
			self.rootLayer:addChild(var_4_1, 10)
		end
	end

	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			var_0_11 = nil

			if arg_4_2 then
				arg_4_2()
			end
		end
	end)
end

local function var_0_12(arg_8_0)
	local var_8_0, var_8_1 = arg_8_0:match("([^,]+),(.+)")

	return cc.p(checknumber(var_8_0), checknumber(var_8_1))
end

function GetSkinTwistAniLayer:showRole(arg_9_1)
	local var_9_0

	if item_data[arg_9_1] then
		if item_data[arg_9_1].bag_item_type == kITEM_HERO then
			var_9_0 = servant_data[item_data[arg_9_1].servant].modelid

			GlobalPlayRoleSound(servant_data[item_data[arg_9_1].servant].modelid, ROLE_SOUND_TYPE.home)
		elseif item_data[arg_9_1].bag_item_type == kITEM_SKIN then
			var_9_0 = item_data[arg_9_1].model

			GlobalPlayRoleSound(item_data[arg_9_1].model, ROLE_SOUND_TYPE.home)
		end
	else
		var_9_0 = servant_data[arg_9_1].modelid

		GlobalPlayRoleSound(servant_data[arg_9_1].modelid, ROLE_SOUND_TYPE.home)
	end

	local var_9_2 = 1

	if model_data[var_9_0].is_own_full_screen_background == 1 then
		var_9_2 = 2
	end

	local var_9_3 = model_data[var_9_0].backgroundid or 6300001

	if self.backGroundLayer ~= nil then
		self.backGroundLayer:update(var_9_3, var_9_2)
	else
		self.backGroundLayer = BackGroundLayer:create(var_9_3, var_9_2)

		self.bg:getParent():addChild(self.backGroundLayer)
	end

	local var_9_4 = model_data[var_9_0].role_image
	local var_9_5 = model_data[var_9_0].mainmidpos and var_0_12(model_data[var_9_0].mainmidpos) or cc.p(320, -50)
	local var_9_6 = model_data[var_9_0].mainmidoffset and var_0_12(model_data[var_9_0].mainmidoffset) or cc.p(0, 0)

	self.roleBrokenImg = TextureManager:createSprite("GetSkinTwistAniLayer", "role/" .. model_data[var_9_0].role_image .. ".png")

	self.roleBrokenImg:setAnchorPoint(cc.p(0.5, 0))
	self.roleBrokenImg:setPosition(cc.p(var_9_5.x + var_9_6.x + 30, var_9_5.y + var_9_6.y + 30))
	self.roleBrokenImg:setColor(cc.c3b(0, 0, 0))
	self.roleBrokenImg:setOpacity(80)
	self.roleBrokenImg:setCascadeOpacityEnabled(true)
	self.rootLayer:addChild(self.roleBrokenImg, 1)

	self.roleImg = TextureManager:createSprite("GetSkinTwistAniLayer", "role/" .. var_9_4 .. ".png")

	self.roleImg:setVisible(false)
	self.roleImg:setOpacity(0)
	self.roleImg:setCascadeOpacityEnabled(true)
	self.roleImg:setAnchorPoint(cc.p(0.5, 0))
	self.roleImg:setPosition(cc.p(var_9_5.x + var_9_6.x, var_9_5.y + var_9_6.y))
	self.rootLayer:addChild(self.roleImg, 1)
	self.roleImg:runAction(cc.Sequence:create(cc.Show:create(), cc.FadeTo:create(1, 255)))

	if item_data[arg_9_1].bag_item_type == kITEM_SKIN and model_data[var_9_0].is_big_role_image == 1 then
		self.roleImg:setPositionY(GameDisplay.cy - self.roleImg:getContentSize().height / 2 - GameDisplay.fix_y)
	else
		self.roleImg:runAction((cc.RepeatForever:create(cc.Sequence:create(cc.EaseInOut:create(cc.Spawn:create(cc.MoveBy:create(2, cc.p(0, 10)), cc.ScaleBy:create(2, 1.007)), 2), cc.EaseInOut:create(cc.Spawn:create(cc.MoveBy:create(2, cc.p(0, -10)), cc.ScaleBy:create(2, 0.99304865938431)), 2)))))
	end
end

function GetSkinTwistAniLayer:showInfo(arg_10_1)
	self.infoGrid = cc.NodeGrid:create()

	self.rootLayer:addChild(self.infoGrid, 1)
	self.infoGrid:runAction(cc.Sequence:create((cc.TurnOffTiles:create(1, cc.size(120, 120), 2):reverse())))

	self.infoBG = ccui.ImageView:create("showNewRole/huode_bg.png", var_0_10)

	self.infoBG:setScale9Enabled(true)
	self.infoBG:setAnchorPoint(cc.p(0.5, 0))
	self.infoBG:setCapInsets(cc.rect(75, 50, 1, 1))
	self.infoBG:setPosition(cc.p(SCREEN_WIDTH / 2, 50))
	self.infoGrid:addChild(self.infoBG)

	local var_10_1

	if item_data[arg_10_1] then
		if item_data[arg_10_1].bag_item_type == kITEM_HERO then
			var_10_1 = GlobalShowRoleSaying(servant_data[item_data[arg_10_1].servant].modelid, ROLE_SOUND_TYPE.home) or major_factor_data[item_data[arg_10_1].major].descrip
		elseif item_data[arg_10_1].bag_item_type == kITEM_SKIN then
			var_10_1 = GlobalShowRoleSaying(item_data[arg_10_1].model, ROLE_SOUND_TYPE.home) or item_data[arg_10_1].intro
		end
	else
		var_10_1 = major_factor_data[arg_10_1].descrip
	end

	local var_10_4 = item_data[arg_10_1].major
	local var_10_5

	if major_factor_data[item_data[arg_10_1].major] then
		var_10_5 = major_factor_data[var_10_4].easy_name or npc_data[var_10_4].easy_name

		if not major_factor_data[var_10_4] or not major_factor_data[var_10_4].role_type then
			-- block empty
		end
	end

	self.descLabel = cc.Label:createWithTTF("", FONT_DES, 32)

	self.descLabel:setString("    " .. var_10_1)
	self.descLabel:setAnchorPoint(cc.p(0, 0))

	self.nameLabel = cc.Label:createWithTTF("", FONT_DES, 48)

	self.nameLabel:setString(var_10_5)
	self.nameLabel:setAnchorPoint(cc.p(0, 0))

	local var_10_7 = self.nameLabel:getContentSize().width + 50
	local var_10_8 = self.nameLabel:getContentSize().height

	self.descLabel:setMaxLineWidth(570)
	self.descLabel:setPosition(cc.p(50, 10))
	self.descLabel:setColor(cc.c3b(37, 29, 59))
	self.infoBG:addChild(self.descLabel, 2)

	local var_10_9 = self.descLabel:getContentSize().height

	self.nameLabel:setPosition(cc.p(50, var_10_9 + 10))
	self.nameLabel:setColor(cc.c3b(54, 43, 76))
	self.infoBG:addChild(self.nameLabel, 2)

	if var_10_8 + var_10_9 + 20 > 96 then
		self.infoBG:setContentSize(cc.size(642, var_10_8 + var_10_9 + 20))
	end

	if self.other_des then
		local var_10_10 = cc.Label:createWithTTF(self.other_des, "fonts/new1.ttf", 22)

		var_10_10:setAnchorPoint(0, 0.5)
		var_10_10:setPosition(cc.p(4, var_10_10:getContentSize().height / 2))
		var_10_10:setColor(cc.c3b(47, 47, 47))
		self:addChild(var_10_10, 2)
	end

	local var_10_11

	if config._DEBUG then
		var_10_11 = cc.Sprite:create("showNewRole/bg_1.png") or cc.Sprite:createWithSpriteFrameName("showNewRole/bg_1.png")
	end

	var_10_11:setAnchorPoint(cc.p(1, 0.5))
	var_10_11:setPosition(cc.p(620, GameDisplay.height - 50))
	self:addChild(var_10_11, 2)

	if playermodel.soulContract[item_data[arg_10_1].servant] < 1 and playermodel.servantNum[item_data[arg_10_1].servant] < 1 then
		local var_10_12

		if config._DEBUG then
			var_10_12 = cc.Sprite:create("showNewRole/bg_new.png") or cc.Sprite:createWithSpriteFrameName("showNewRole/bg_new.png")
		end

		var_10_12:setAnchorPoint(cc.p(0.5, 0.5))
		var_10_12:setPosition(cc.p(var_10_11:getContentSize().width / 2, var_10_11:getContentSize().height / 2))
		var_10_11:addChild(var_10_12)
	else
		var_10_11:setVisible(false)
	end

	local var_10_13 = ccui.Button:create("showNewRole/button_share.png", "showNewRole/button_share_on.png", "", var_0_10)

	var_10_13:setAnchorPoint(cc.p(0, 0.5))
	var_10_13:setPosition(cc.p(10, GameDisplay.height - 50))
	self:addChild(var_10_13, 2)
	var_10_13:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:shareMyGoodLuck()
	end)
	var_10_13:setVisible(false)

	local var_10_14 = cc.Label:createWithTTF(L_CLICK_CONTINUE, FONT_DES, 28)

	var_10_14:setAnchorPoint(cc.p(1, 0))
	var_10_14:setPosition(cc.p(600, 10))
	self:addChild(var_10_14, 2)
	var_10_14:setOpacity(150)
	var_10_14:runAction(cc.RepeatForever:create((cc.Sequence:create(cc.FadeTo:create(1, 255), cc.FadeTo:create(1, 5)))))
end

function GetSkinTwistAniLayer:showEffect()
	for iter_12_0 = 1, 6 do
		self.starSprite = ccui.ImageView:create("showNewRole/star.png", var_0_10)

		self.starSprite:setScale(var_0_9["Star" .. iter_12_0].scale)
		self.starSprite:setPosition(var_0_9["Star" .. iter_12_0].x, var_0_9["Star" .. iter_12_0].y)
		self.infoBG:addChild(self.starSprite, 2)
	end
end

function GetSkinTwistAniLayer:showFormatDetial(arg_13_1)
	if not arg_13_1 then
		return
	end

	local var_13_0 = ccui.ImageView:create((string.format("mainScenebg/other/format_%d_%d.png", arg_13_1.itemid, arg_13_1.itemNum)))

	var_13_0:setAnchorPoint(cc.p(1, 0.5))
	var_13_0:setPosition(640, 450)
	self:addChild(var_13_0)
end

function GetSkinTwistAniLayer.shareMyGoodLuck(arg_14_0)
	global_ShowBlockWords(L_FUNCTION_NO_OPEN)
end
