local network = require("network.network")

require("view.Layer.PopLayer")
require("view.Layer.TopcostLayer")
require("view.Layer.ListButtonLayer")
require("view.Layer.DropDetailsLayer")
require("view.Layer.DetailsofHelpGirlLayer")
require("controller.goto_system_manager")
require("view.Sprite.ConfirmDialogSprite")

local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local horcrux_manager = require("controller.horcrux_manager")
local audio_manager = require("controller.audio_manager")
local component_manager = require("controller.component_manager")
local twist_manager = require("controller.twist_manager")
local weapon_manager = require("controller.weapon_manager")
local level_manager = require("controller.level_manager")
local autopop_manager = require("controller.autopop_manager")
local l2utils = require("controller.l2utils")
local time_check_manager = require("controller.time_check_manager")
local alert_manager = require("controller.alert_manager")
local activity_manager = require("controller.activity_manager")
local item_data = require("data.item_data")
local horcrux_data = require("data.horcrux_data")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local servant_data = require("data.servant_data")
local total_skill_data = require("data.total_skill_data")
local drop_data = require("data.drop_data")
local var_0_22 = config._DEBUG and 0 or 1
local var_0_23 = 1
local var_0_24 = 2
local var_0_25 = 3
local var_0_27 = "mainScenebg/bg.jpg"
local var_0_28 = "mainScenebg/resultbg.jpg"
local var_0_29 = "spine/ui/twist/twist"
local var_0_30 = "spine/ui/twist/fangkuai"
local var_0_32 = cc.size(514, 815)
local var_0_36 = {
	"public/rarity/r_long.png",
	"public/rarity/sr_long.png",
	"public/rarity/ur_long.png",
	"public/rarity/mr_long.png",
	"public/rarity/sp_long.png"
}
local var_0_37 = {
	"TwistEgg/star.png",
	"TwistEgg/star_dark.png"
}
local var_0_38 = {
	{
		"r1",
		"r2"
	},
	{
		"sr1",
		"sr2"
	},
	{
		"ur1",
		"ur2"
	},
	{
		"mr1",
		"mr2"
	},
	{
		"sp1",
		"sp2"
	}
}
local var_0_39 = {
	{
		"HQ-R",
		"HQ-R-R"
	},
	{
		"HQ-SR",
		"HQ-SR-R"
	},
	{
		"HQ-UR",
		"HQ-UR-R"
	},
	{
		"HQ-MR",
		"HQ-MR-R"
	},
	{
		"HQ-SP",
		"HQ-SP-R"
	}
}

local function var_0_40()
	local var_1_0 = ccui.ImageView:create(var_0_36[1], var_0_22)

	var_1_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_1_0:setVisible(false)

	return var_1_0
end

local function var_0_41()
	return (ccui.ImageView:create())
end

local function var_0_42()
	local var_3_0 = cc.Label:createWithTTF("", FONT_NAME, 40)

	var_3_0:setAnchorPoint(cc.p(0, 0.5))
	var_3_0:enableGlow(cc.c4b(30, 170, 255, 150), 2)
	var_3_0:setVisible(false)

	return var_3_0
end

local function var_0_43()
	local var_4_0 = cc.Label:createWithTTF("", FONT_DES, 20)

	var_4_0:setAnchorPoint(cc.p(0, 0.5))
	var_4_0:setVisible(false)

	return var_4_0
end

local function var_0_44()
	local var_5_0 = ccui.ImageView:create()

	var_5_0:setScale(0.9)

	return var_5_0
end

local function var_0_45()
	local var_6_0 = cc.Label:createWithTTF("", FONT_NAME, 50)

	var_6_0:enableGlow(cc.c4b(0, 205, 255, 150), 2)

	return var_6_0
end

local function var_0_46()
	local var_7_0 = cc.Label:createWithTTF("", FONT_NAME, 50)

	var_7_0:enableGlow(cc.c4b(250, 187, 15, 150), 2)

	return var_7_0
end

local var_0_47 = {
	cc.p(118, 213 + GameDisplay.fix_y),
	cc.p(118, 103 + GameDisplay.fix_y)
}

local function var_0_48(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.resultInfosPanel:getChildByName("skillicon" .. arg_8_1)

	if not var_8_0 then
		var_8_0 = ccui.ImageView:create()

		var_8_0:setName("skillicon" .. arg_8_1)
		var_8_0:setScale(0.85)
		var_8_0:setPosition(var_0_47[arg_8_1])
		arg_8_0.resultInfosPanel:addChild(var_8_0)
	end

	return var_8_0
end

local var_0_49 = {
	cc.p(168, 240 + GameDisplay.fix_y),
	cc.p(168, 130 + GameDisplay.fix_y)
}

local function var_0_50(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.resultInfosPanel:getChildByName("skillname" .. arg_9_1)

	if not var_9_0 then
		var_9_0 = cc.Label:createWithTTF("", FONT_NAME, 35)

		var_9_0:setName("skillname" .. arg_9_1)
		var_9_0:setAnchorPoint(cc.p(0, 0.5))
		var_9_0:setPosition(var_0_49[arg_9_1])
		arg_9_0.resultInfosPanel:addChild(var_9_0)
	end

	return var_9_0
end

local var_0_51 = {
	cc.p(172, 220 + GameDisplay.fix_y),
	cc.p(172, 110 + GameDisplay.fix_y)
}

local function var_0_52(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.resultInfosPanel:getChildByName("skilldes" .. arg_10_1)

	if not var_10_0 then
		var_10_0 = cc.Label:createWithTTF("", FONT_DES, 20)

		var_10_0:setName("skilldes" .. arg_10_1)
		var_10_0:setAnchorPoint(cc.p(0, 1))
		var_10_0:setDimensions(350, 0)
		var_10_0:setPosition(var_0_51[arg_10_1])
		arg_10_0.resultInfosPanel:addChild(var_10_0)
	end

	return var_10_0
end

local var_0_53 = {
	[kITEM_HERO] = function(arg_11_0, arg_11_1, arg_11_2)
		local var_11_0 = item_data[arg_11_1.dropid].servant
		local var_11_1 = servant_data[item_data[arg_11_1.dropid].servant].major
		local var_11_2 = servant_data[item_data[arg_11_1.dropid].servant].modelid
		local var_11_3 = arg_11_0.resultPanel:getChildByName("icon")

		if not var_11_3 then
			var_11_3 = cc.Sprite:create()

			var_11_3:setAnchorPoint(cc.p(0.5, 0))
			var_11_3:setVisible(false)
			var_11_3:setName("icon")
			arg_11_0.resultPanel:addChild(var_11_3)
		end

		local var_11_4 = model_data[var_11_2].egg_offset_x or 0
		local var_11_5 = model_data[var_11_2].egg_offset_y or 0

		var_11_3:setTexture("role/" .. model_data[servant_data[item_data[arg_11_1.dropid].servant].modelid].role_image .. ".png")

		if model_data[var_11_2].is_big_role_image then
			var_11_3:setPosition(cc.p(315, GameDisplay.cy - var_11_3:getContentSize().height / 2))
			var_11_3:setScale(1)
		else
			var_11_3:setPosition(cc.p(315 + var_11_4, 190 + GameDisplay.fix_y + var_11_5))
			var_11_3:setScale(0.8)
		end

		var_11_3:setVisible(false)
		var_11_3:setOpacity(0)

		local var_11_6 = arg_11_0.resultInfosPanel:getChildByName("rarity")

		if not var_11_6 then
			var_11_6 = var_0_40()

			var_11_6:setName("rarity")
			arg_11_0.resultInfosPanel:addChild(var_11_6)
		end

		local var_11_7 = servant_data[var_11_0].roll_rarity or 1

		var_11_6:loadTexture(var_0_36[var_11_7], var_0_22)
		var_11_6:setPosition(cc.p(130, 181 + GameDisplay.fix_y))
		var_11_6:setOpacity(0)
		var_11_6:setVisible(false)

		local var_11_8 = arg_11_0.resultInfosPanel:getChildByName("roleattricon")

		if not var_11_8 then
			var_11_8 = var_0_41()

			var_11_8:setName("roleattricon")
			var_11_8:setPosition(cc.p(525, 120 + GameDisplay.fix_y))
			arg_11_0.resultInfosPanel:addChild(var_11_8)
		end

		local var_11_9 = global_get_all_model_attrs(var_11_2)
		local var_11_10 = var_11_9.main

		if var_11_9.sub and next(var_11_9.sub) then
			for iter_11_0, iter_11_1 in ipairs(var_11_9.sub) do
				var_11_10 = var_11_10 .. "_" .. iter_11_1
			end
		end

		var_11_8:loadTexture(CAREER_ICON[servant_data[var_11_0].career .. "_" .. var_11_10], var_0_22)
		var_11_8:setOpacity(0)
		var_11_8:setVisible(false)

		local var_11_11 = arg_11_0.resultInfosPanel:getChildByName("name")

		if not var_11_11 then
			var_11_11 = var_0_42()

			var_11_11:setName("name")
			arg_11_0.resultInfosPanel:addChild(var_11_11)
		end

		var_11_11:setPosition(cc.p(90, 124 + GameDisplay.fix_y))
		var_11_11:setString(major_factor_data[servant_data[var_11_0].major].easy_name)
		var_11_11:setOpacity(0)
		var_11_11:setVisible(false)

		local var_11_12 = arg_11_0.resultInfosPanel:getChildByName("roledes")

		if not var_11_12 then
			var_11_12 = var_0_43()

			var_11_12:setName("roledes")
			arg_11_0.resultInfosPanel:addChild(var_11_12)
		end

		var_11_12:setString(GlobalShowRoleSaying(var_11_2, ROLE_SOUND_TYPE.home) or major_factor_data[var_11_1].descrip)
		var_11_12:setMaxLineWidth(512)
		var_11_12:setPosition(cc.p(97, 64 + GameDisplay.fix_y))
		var_11_12:setOpacity(0)
		var_11_12:setVisible(false)
		arg_11_0.skipBnt:setVisible(false)
		arg_11_0.resultAni:setVisible(true)
		arg_11_0.resultAni:play(var_0_38[var_11_7][1], false)
		arg_11_0.resultAni:addAnimation(var_0_38[var_11_7][2])
		var_11_3:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.Show:create(), cc.FadeIn:create(0.5)))
		var_11_3:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(function()
			l2utils:shakeNode(var_11_3, {
				scanlinethreshold = 0.025,
				scanlinedrift = 5,
				waitframe = 0,
				shakeframe = 24,
				driftpixel = 0,
				scanlinedriftfac = 5,
				restoreframe = 24,
				driftfac = 3
			})
		end)))
		var_11_3:runAction(cc.Sequence:create(cc.DelayTime:create(2.8), cc.CallFunc:create(function()
			l2utils:removeNodeShake(var_11_3)
			GlobalPlayRoleSound(var_11_2, ROLE_SOUND_TYPE.home)
		end)))
		var_11_6:runAction(cc.Sequence:create(cc.DelayTime:create(3.2666666666666666), cc.Show:create(), cc.FadeIn:create(0.5)))
		var_11_8:runAction(cc.Sequence:create(cc.DelayTime:create(3.2666666666666666), cc.Show:create(), cc.FadeIn:create(0.5)))
		var_11_11:runAction(cc.Sequence:create(cc.DelayTime:create(3.2666666666666666), cc.Show:create(), cc.FadeIn:create(0.5)))
		var_11_12:runAction(cc.Sequence:create(cc.DelayTime:create(3.6666666666666665), cc.Show:create(), cc.FadeIn:create(0.5)))

		local var_11_13 = arg_11_0.resultPanel:getChildByName("blackcardinfo")

		var_11_13:setPositionY(221 + GameDisplay.fix_y)

		if arg_11_0.lastTwistBlackCard == BLACK_CARD then
			if arg_11_2 and arg_11_2.elementcard then
				var_11_13:loadTexture("TwistEgg/panel_extra_award.png", var_0_22)
				var_11_13:getChildByName("num"):setString(string.format("x%d", arg_11_2.elementcard.itemcount))
				var_11_13:getChildByName("num"):setScale(1)
				var_11_13:getChildByName("icon"):loadTexture("equipment/" .. item_data[arg_11_2.elementcard.itemid].image_id .. ".png")

				if item_data[arg_11_2.elementcard.itemid].bag_item_type == kITEM_EQUIPMENT then
					var_11_13:getChildByName("icon"):setScale(0.3)
				else
					var_11_13:getChildByName("icon"):setScale(0.5)
				end

				var_11_13:getChildByName("icon"):setVisible(true)
				var_11_13:setVisible(false)
				var_11_13:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.Show:create()))
			else
				var_11_13:setVisible(false)
			end
		else
			var_11_13:loadTexture("TwistEgg/panel_blackcard_sp_bg2.png", var_0_22)
			var_11_13:getChildByName("num"):setString(string.format("SP" .. L_PLAYER_DATA_TYPE.Horcrux_Card .. "x%d", arg_11_1.dropnum - 1))
			var_11_13:getChildByName("num"):setScale(0.91)
		end

		arg_11_0.skipBnt:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.Show:create(), cc.CallFunc:create(function()
			arg_11_0.resultTouchEnabled = true
		end)))
		var_11_3:runAction(cc.Sequence:create(cc.DelayTime:create(7), cc.CallFunc:create(function()
			audio_manager:playeffectMusic(TWIST_CYCLE_EFFECT, true)
		end)))
	end,
	[kITEM_HORCRUX] = function(arg_16_0, arg_16_1)
		local var_16_0 = arg_16_1.dropid
		local var_16_2 = arg_16_0.resultPanel:getChildByName("icon")

		if not var_16_2 then
			var_16_2 = cc.Sprite:create()

			var_16_2:setAnchorPoint(cc.p(0.5, 0))
			var_16_2:setVisible(false)
			var_16_2:setName("icon")
			arg_16_0.resultPanel:addChild(var_16_2)
		end

		var_16_2:setTexture("role1/" .. model_data[horcrux_data[arg_16_1.dropid].model].cute_Q .. ".png")
		var_16_2:setPosition(cc.p(315, 525 + GameDisplay.fix_y))
		var_16_2:setScale(1)
		var_16_2:setOpacity(0)
		var_16_2:setVisible(false)

		local var_16_3 = arg_16_0.resultInfosPanel:getChildByName("rarity")

		if not var_16_3 then
			var_16_3 = var_0_40()

			var_16_3:setName("rarity")
			arg_16_0.resultInfosPanel:addChild(var_16_3)
		end

		local var_16_4 = horcrux_data[arg_16_1.dropid].rarity or 1

		var_16_3:loadTexture(var_0_36[var_16_4], var_0_22)
		var_16_3:setPosition(cc.p(210, 985 + GameDisplay.fix_y))
		var_16_3:setOpacity(0)
		var_16_3:setVisible(false)

		local var_16_5 = arg_16_0.resultInfosPanel:getChildByName("horcruxattricon")

		if not var_16_5 then
			var_16_5 = var_0_44()

			var_16_5:setName("horcruxattricon")
			var_16_5:setPosition(cc.p(42, 416 + GameDisplay.fix_y))
			arg_16_0.resultInfosPanel:addChild(var_16_5)
		end

		var_16_5:loadTexture(ATTRICONPATH[global_get_model_attr(item_data[arg_16_1.dropid].model)], var_0_22)
		var_16_5:setOpacity(0)
		var_16_5:setVisible(false)

		local var_16_6 = arg_16_0.resultInfosPanel:getChildByName("name")

		if not var_16_6 then
			var_16_6 = var_0_42()

			var_16_6:setName("name")
			arg_16_0.resultInfosPanel:addChild(var_16_6)
		end

		var_16_6:setPosition(cc.p(75, 420 + GameDisplay.fix_y))
		var_16_6:setString(item_data[arg_16_1.dropid].name)
		var_16_6:setOpacity(0)
		var_16_6:setVisible(false)

		local var_16_7 = arg_16_0.resultInfosPanel:getChildByName("dfaclabel")

		if not var_16_7 then
			var_16_7 = var_0_45()

			var_16_7:setName("dfaclabel")
			arg_16_0.resultInfosPanel:addChild(var_16_7)
		end

		var_16_7:setPosition(cc.p(250, 310 + GameDisplay.fix_y))
		var_16_7:setString("")
		var_16_7:setVisible(false)

		local var_16_8 = arg_16_0.resultInfosPanel:getChildByName("hfaclabel")

		if not var_16_8 then
			var_16_8 = var_0_46()

			var_16_8:setName("hfaclabel")
			arg_16_0.resultInfosPanel:addChild(var_16_8)
		end

		var_16_8:setPosition(cc.p(540, 310 + GameDisplay.fix_y))
		var_16_8:setString("")
		var_16_8:setVisible(false)

		local var_16_9 = horcrux_manager:getHorcruxSkillsByItemid(arg_16_1.dropid, arg_16_1.iteminfo.horcrux_attr.star)
		local var_16_10 = {}
		local var_16_11 = {}
		local var_16_12 = {}

		for iter_16_0 = 1, 2 do
			var_16_10[iter_16_0] = var_0_48(arg_16_0, iter_16_0)
			var_16_11[iter_16_0] = var_0_50(arg_16_0, iter_16_0)
			var_16_12[iter_16_0] = var_0_52(arg_16_0, iter_16_0)

			if var_16_9[iter_16_0] then
				local var_16_13 = var_16_9[iter_16_0]

				var_16_10[iter_16_0]:loadTexture((total_skill_data[var_16_9[iter_16_0]].icon or nil) and ("skill_new/skill/" .. total_skill_data[var_16_13].icon .. ".png" or "public/rolebg/skill_frame_bg.png"), var_0_22)
				var_16_11[iter_16_0]:setString(total_skill_data[var_16_13].name)
				var_16_12[iter_16_0]:setString(total_skill_data[var_16_13].description)
			else
				var_16_10[iter_16_0]:loadTexture("public/rolebg/skill_frame_bg.png", var_0_22)
				var_16_11[iter_16_0]:setString("")
				var_16_12[iter_16_0]:setString("")
			end

			var_16_10[iter_16_0]:setOpacity(0)
			var_16_10[iter_16_0]:setVisible(false)
			var_16_11[iter_16_0]:setOpacity(0)
			var_16_11[iter_16_0]:setVisible(false)
			var_16_12[iter_16_0]:setOpacity(0)
			var_16_12[iter_16_0]:setVisible(false)
		end

		local var_16_14 = arg_16_1.iteminfo.horcrux_attr.star

		arg_16_0.skipBnt:setVisible(false)
		arg_16_0.resultAni:setVisible(true)
		arg_16_0.resultAni:play(var_0_39[var_16_4][1] .. var_16_14, false)

		if var_16_14 == 1 then
			var_16_14 = ""
		end

		arg_16_0.resultAni:addAnimation(var_0_39[var_16_4][2] .. var_16_14)
		var_16_2:runAction(cc.Sequence:create(cc.DelayTime:create(1.6666666666666667), cc.Show:create(), cc.FadeIn:create(0.5)))
		var_16_2:runAction(cc.Sequence:create(cc.DelayTime:create(1.6666666666666667), cc.CallFunc:create(function()
			l2utils:shakeNode(var_16_2, {
				scanlinethreshold = 0.025,
				scanlinedrift = 5,
				waitframe = 0,
				shakeframe = 24,
				driftpixel = 0,
				scanlinedriftfac = 5,
				restoreframe = 24,
				driftfac = 3
			})
		end)))
		var_16_2:runAction(cc.Sequence:create(cc.DelayTime:create(2.466666666666667), cc.CallFunc:create(function()
			l2utils:removeNodeShake(var_16_2)
		end)))
		var_16_3:runAction(cc.Sequence:create(cc.DelayTime:create(3), cc.Show:create(), cc.FadeIn:create(0.5)))
		var_16_5:runAction(cc.Sequence:create(cc.DelayTime:create(1.6666666666666667), cc.Show:create(), cc.FadeIn:create(0.2)))
		var_16_6:runAction(cc.Sequence:create(cc.DelayTime:create(1.6666666666666667), cc.Show:create(), cc.FadeIn:create(0.2)))
		var_16_7:runAction(cc.Sequence:create(cc.DelayTime:create(2.2333333333333334), cc.Show:create(), cc.CallFunc:create(function()
			local var_19_0 = horcrux_manager:getHorcruxDamageFacByItemid(var_16_0, arg_16_1.iteminfo.horcrux_attr.dfac) / 100

			l2utils:numberlabelRandomAction(var_16_7, var_19_0 >= 10 and string.format("%.1f", var_19_0) or string.format("%.1f", var_19_0), 1, "outQuad", 20)
		end)))
		var_16_8:runAction(cc.Sequence:create(cc.DelayTime:create(2.2333333333333334), cc.Show:create(), cc.CallFunc:create(function()
			l2utils:numberlabelRandomAction(var_16_8, tostring(horcrux_manager:getHorcruxHpFacByItemid(var_16_0, arg_16_1.iteminfo.horcrux_attr.hfac) / 100), 1, "outQuad", 20)
		end)))

		for iter_16_1 = 1, 2 do
			var_16_10[iter_16_1]:runAction(cc.Sequence:create(cc.DelayTime:create(2.3333333333333335), cc.Show:create(), cc.FadeIn:create(0.1)))
			var_16_11[iter_16_1]:runAction(cc.Sequence:create(cc.DelayTime:create(2.533333333333333), cc.Show:create(), cc.FadeIn:create(0.5)))
			var_16_12[iter_16_1]:runAction(cc.Sequence:create(cc.DelayTime:create(2.533333333333333), cc.Show:create(), cc.FadeIn:create(0.5)))
		end

		arg_16_0.skipBnt:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.Show:create(), cc.CallFunc:create(function()
			arg_16_0.resultTouchEnabled = true
		end)))
		var_16_2:runAction(cc.Sequence:create(cc.DelayTime:create(7), cc.CallFunc:create(function()
			audio_manager:playeffectMusic(TWIST_CYCLE_EFFECT, true)
		end)))
	end,
	[kITEM_SKIN] = function(arg_23_0, arg_23_1, arg_23_2)
		if arg_23_0.resultPanel:getChildByName("icon") then
			arg_23_0.resultPanel:setVisible(false)
		end

		arg_23_0.resultAni:setVisible(false)
		require("view.Layer.GetRoleAnimationLayer")

		local var_23_0 = GetRoleAnimationLayer:create(arg_23_1.dropid, nil, true)

		var_23_0:setName("skinPanel")
		arg_23_0.resultPanel:addChild(var_23_0)

		local var_23_1 = arg_23_0.resultPanel:getChildByName("formatinfo")

		if arg_23_2.origina_itemid ~= arg_23_2.final_itemid then
			var_23_1:getChildByName("icon"):setVisible(true)
			var_23_1:getChildByName("icon"):loadTexture("equipment/" .. item_data[arg_23_2.final_itemid].image_id .. ".png")
			var_23_1:getChildByName("num"):setString(string.format("%sX%d", item_data[arg_23_2.final_itemid].name, arg_23_2.final_itemNum))
			var_23_1:setVisible(false)
			var_23_1:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.Show:create()))
			var_23_1:setPositionY(250)
		end

		arg_23_0.skipBnt:setVisible(false)
		arg_23_0.skipBnt:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.Show:create(), cc.CallFunc:create(function()
			arg_23_0.resultTouchEnabled = true
		end)))
	end
}

local function var_0_54(arg_28_0)
	if arg_28_0.resultPanel:getChildByName("skinPanel") then
		arg_28_0.resultPanel:getChildByName("skinPanel"):runAction(cc.RemoveSelf:create())
	end

	if arg_28_0.resultPanel:getChildByName("icon") then
		arg_28_0.resultPanel:getChildByName("icon"):stopAllActions()
		l2utils:removeNodeShake(arg_28_0.resultPanel:getChildByName("icon"))
		arg_28_0.resultPanel:getChildByName("icon"):setVisible(false)
	end

	arg_28_0.resultPanel:getChildByName("blackcardinfo"):setVisible(false)
	arg_28_0.resultPanel:getChildByName("formatinfo"):setVisible(false)

	for iter_28_0, iter_28_1 in pairs(arg_28_0.resultInfosPanel:getChildren()) do
		iter_28_1:stopAllActions()
		iter_28_1:setVisible(false)
	end
end

setmetatable(var_0_53, {
	__index = function(arg_25_0, arg_25_1)
		return function(arg_26_0, arg_26_1)
			local var_26_0 = arg_26_0.resultPanel:getChildByName("icon")

			if not var_26_0 then
				var_26_0 = cc.Sprite:create()

				var_26_0:setAnchorPoint(cc.p(0.5, 0))
				var_26_0:setVisible(false)
				var_26_0:setName("icon")
				arg_26_0.resultPanel:addChild(var_26_0)
			end

			var_26_0:setTexture("equipment/" .. item_data[arg_26_1.dropid].image_id .. ".png")
			var_26_0:setPosition(cc.p(257, 400 - var_26_0:getContentSize().height / 2))
			arg_26_0.resultAni:setVisible(false)
			var_26_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.Show:create()))
			var_26_0:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
				arg_26_0.resultTouchEnabled = true
			end)))
		end
	end,
	__call = function(self, arg_29_1, ...)
		var_0_54(...)
		self[arg_29_1](...)
	end
})

local var_0_55 = setmetatable({
	[1] = false,
	[4] = false
}, {
	__index = function(arg_30_0, arg_30_1)
		return true
	end
})

function TwisteggLayer:show_twist_result(arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_5)
	self.showPanel:setVisible(true)
	self.resultBg:setVisible(true)
	self:cleanShowResultPanelEvent()
	self.twistingRectPanel:getChildByName("blackcardinfo"):setVisible(false)

	if var_0_55[arg_31_1] then
		self:startTwistResultAni(arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_5)
	else
		self:showTwistFinalResult(arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_5)
	end
end

local function var_0_56()
	local var_32_0 = {}
	local var_32_1 = -1

	for iter_32_0 = 1, 10 do
		var_32_0[iter_32_0] = cc.p(320 + var_32_1 * 200, 950 - 0 * 250 + GameDisplay.fix_y)
		var_32_1 = var_32_1 + 1

		if var_32_1 > 1 then
			var_32_1 = -1
		end
	end

	return var_32_0
end

local function var_0_57(arg_33_0)
	if item_data[arg_33_0].bag_item_type == kITEM_HERO then
		return servant_data[item_data[arg_33_0].servant].roll_rarity > 3
	elseif item_data[arg_33_0].bag_item_type == kITEM_HORCRUX then
		return item_data[arg_33_0].rarity > 3
	elseif item_data[arg_33_0].bag_item_type == kITEM_SKIN then
		return true
	else
		return false
	end
end

local function var_0_58(arg_34_0)
	if item_data[arg_34_0].bag_item_type == kITEM_HERO then
		return servant_data[item_data[arg_34_0].servant].roll_rarity >= 3
	elseif item_data[arg_34_0].bag_item_type == kITEM_HORCRUX then
		return item_data[arg_34_0].rarity > 2
	else
		return item_data[arg_34_0].equip_quality >= 5
	end
end

local function var_0_59(arg_35_0)
	if item_data[arg_35_0].bag_item_type == kITEM_HERO then
		print(arg_35_0, item_data[arg_35_0].servant)

		if servant_data[item_data[arg_35_0].servant].roll_rarity >= 5 then
			return true
		end
	elseif item_data[arg_35_0].bag_item_type == kITEM_HORCRUX then
		if item_data[arg_35_0].rarity >= 5 then
			return true
		end
	elseif item_data[arg_35_0].bag_item_type == kITEM_SKIN then
		return item_data[arg_35_0].equip_quality >= 6
	end

	return false
end

function TwisteggLayer:startTwistResultAni(arg_36_1, arg_36_2, arg_36_3, arg_36_4, arg_36_5)
	self:cleanTwistRectPanel()
	self.resultBg:setTexture(var_0_28)
	self.twistingRectPanel:setVisible(true)
	self.skipBnt:setVisible(false)

	local var_36_0 = #arg_36_2 == 1 and {
		cc.p(320, GameDisplay.height / 2)
	} or var_0_56()

	local function var_36_1(arg_37_0)
		local var_37_0 = self.twistingRectPanel:getChildByName("rect" .. arg_37_0)

		if not var_37_0 then
			var_37_0 = L2Skeleton:create(var_0_30 .. ".json", var_0_30 .. ".atlas", nil, true)

			var_37_0:refreshSkeleton()
			var_37_0:setName("rect" .. arg_37_0)
			self.twistingRectPanel:addChild(var_37_0)
		end

		return var_37_0
	end

	local function var_36_2(arg_38_0)
		return (item_data[arg_38_0].bag_item_type == kITEM_HERO and "role_" or item_data[arg_38_0].bag_item_type == kITEM_SKIN and "new_role_" or "") .. (var_0_59(arg_38_0) and "red" or var_0_57(arg_38_0) and "orange" or var_0_58(arg_38_0) and "purple" or "blue")
	end

	local function var_36_3()
		return coroutine.create(function()
			for iter_40_0 = 1, #arg_36_2 do
				local var_40_0 = var_36_1(iter_40_0)

				var_40_0:setPosition(var_36_0[iter_40_0])
				var_40_0:setVisible(true)

				local var_40_1 = var_36_2(arg_36_2[iter_40_0].dropid)

				var_40_0:play(var_40_1, false)
				var_40_0:addAnimation(var_40_1 .. "2")
				audio_manager:playeffectMusic(TWIST_ADD_EFFECT)
				coroutine.yield(iter_40_0)
			end

			for iter_40_1 = 1, 3 do
				coroutine.yield("wait")
			end

			return "end"
		end)
	end

	if self.showAniScheduler then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.showAniScheduler)

		self.showAniScheduler = nil
	end

	local var_36_4 = var_36_3()

	self.showAniScheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_41_0)
		if not var_36_4 then
			var_36_4 = var_36_3()

			return
		end

		local var_41_0, var_41_1 = coroutine.resume(var_36_4)

		assert(var_41_0, var_41_1)

		if var_41_1 == "end" then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.showAniScheduler)

			self.showAniScheduler = nil
			var_36_4 = nil

			self.twistingRectPanel:setVisible(false)

			if var_0_55[arg_36_1] then
				self:showTwistItemsInfoAni(arg_36_1, arg_36_2, arg_36_3, arg_36_4, arg_36_5)
			else
				self:showTwistFinalResult(arg_36_1, arg_36_2, arg_36_3, arg_36_4, arg_36_5)
			end
		end
	end, 0.2, false)
end

function TwisteggLayer:showTwistItemsInfoAni(arg_42_1, arg_42_2, arg_42_3, arg_42_4, arg_42_5)
	self.resultBg:setTexture(var_0_27)
	self.resultPanel:setVisible(true)
	self.resultInfosPanel:setVisible(true)
	self.skipBnt:setVisible(true)
	var_0_54(self)

	local var_42_0 = (function()
		return coroutine.create(function()
			local var_44_0 = {}
			local var_44_1 = 0

			for iter_44_0, iter_44_1 in ipairs(arg_42_2) do
				if item_data[iter_44_1.dropid].bag_item_type == kITEM_HERO then
					if servant_data[item_data[iter_44_1.dropid].servant].roll_rarity >= 4 then
						var_44_1 = var_44_1 + 1

						table.insert(var_44_0, {
							item = iter_44_1,
							index = iter_44_0,
							extra = arg_42_5[var_44_1],
							rarity = servant_data[item_data[iter_44_1.dropid].servant].roll_rarity
						})
					end
				elseif item_data[iter_44_1.dropid].bag_item_type == kITEM_SKIN then
					table.insert(var_44_0, {
						item = iter_44_1,
						index = iter_44_0,
						rarity = item_data[iter_44_1.dropid].equip_quality,
						extra = iter_44_1.formatinfo
					})
				end
			end

			table.sort(var_44_0, function(arg_45_0, arg_45_1)
				if arg_45_0.rarity == arg_45_1.rarity then
					return arg_45_0.index < arg_45_1.index
				else
					return arg_45_0.rarity > arg_45_1.rarity
				end
			end)

			for iter_44_2, iter_44_3 in ipairs(var_44_0) do
				var_0_53(item_data[iter_44_3.item.dropid].bag_item_type, self, iter_44_3.item, iter_44_3.extra)
				audio_manager:stopAllEffects()
				audio_manager:playeffectMusic(TWIST_CHANGE_EFFECT)
				coroutine.yield(i)
			end

			audio_manager:stopAllEffects()

			return "end"
		end)
	end)()
	local var_42_1, var_42_2 = coroutine.resume(var_42_0)

	assert(var_42_1, var_42_2)

	if var_42_2 == "end" then
		var_42_0 = nil

		self.resultAni:setVisible(false)
		self.resultPanel:setVisible(false)
		self.resultInfosPanel:setVisible(false)
		var_0_54(self)
		self:showTwistFinalResult(arg_42_1, arg_42_2, arg_42_3, arg_42_4)
	end

	self.showPanel:addTouchEventListener(function(arg_46_0, arg_46_1)
		if arg_46_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.resultTouchEnabled then
			return
		end

		if not var_42_0 then
			return
		end

		self.resultTouchEnabled = false

		local var_46_0, var_46_1 = coroutine.resume(var_42_0)

		assert(var_46_0, var_46_1)

		if var_46_1 == "end" then
			var_42_0 = nil

			self.resultAni:setVisible(false)
			self.resultPanel:setVisible(false)
			self.resultInfosPanel:setVisible(false)
			var_0_54(self)
			self:showTwistFinalResult(arg_42_1, arg_42_2, arg_42_3, arg_42_4)
		end
	end)
	self.skipBnt:addTouchEventListener(function(arg_47_0, arg_47_1)
		if arg_47_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.resultTouchEnabled then
			return
		end

		self.resultTouchEnabled = false
		var_42_0 = nil

		self.resultAni:setVisible(false)
		self.resultPanel:setVisible(false)
		self.resultInfosPanel:setVisible(false)
		var_0_54(self)
		audio_manager:stopAllEffects()
		self:showTwistFinalResult(arg_42_1, arg_42_2, arg_42_3, arg_42_4)
	end)
end

local var_0_60 = {
	"public/box/new_item_bg1.png",
	"public/box/new_item_bg2.png",
	"public/box/new_item_bg3.png",
	"public/box/new_item_bg4.png",
	"public/box/new_item_bg5.png",
	"public/box/new_item_bg6.png"
}
local var_0_61 = {
	mimicry = "TwistEgg/bg_wind.png",
	fire = "TwistEgg/bg_fire.png",
	shiling = "TwistEgg/bg_wind.png",
	umaru = "TwistEgg/bg_wind.png",
	water = "TwistEgg/bg_water.png",
	light = "TwistEgg/bg_light.png",
	dark = "TwistEgg/bg_dark.png",
	imaginary = "TwistEgg/bg_wind.png",
	wind = "TwistEgg/bg_wind.png",
	null = "TwistEgg/bg_wind.png",
	devil = "TwistEgg/bg_wind.png"
}
local var_0_62 = "TwistEgg/shine_frame.png"
local var_0_63 = "TwistEgg/purple_frame.png"
local var_0_64 = "TwistEgg/red_frame.png"
local var_0_65 = {
	"TwistEgg/btn_sure.png",
	"TwistEgg/btn_sure_on.png"
}
local var_0_66 = {
	"TwistEgg/btn_again.png",
	"TwistEgg/btn_again.png"
}

setmetatable(var_0_61, {
	__index = function(arg_48_0, arg_48_1)
		return "TwistEgg/bg_dark.png"
	end
})

local var_0_68 = {
	[kITEM_HERO] = function(arg_49_0, arg_49_1)
		local var_49_1 = ccui.ImageView:create(var_0_61[global_get_model_attr(servant_data[item_data[arg_49_0.dropid].servant].modelid)] or var_0_61.wind, var_0_22)
		local var_49_2 = ccui.Layout:create()

		var_49_2:setClippingEnabled(true)
		var_49_2:setContentSize(var_49_1:getContentSize().width - 8, var_49_1:getContentSize().height - 8)
		var_49_2:setPosition(cc.p(4, 4))
		var_49_2:setCascadeOpacityEnabled(true)
		var_49_2:setName("clip")
		var_49_1:addChild(var_49_2)

		local var_49_3 = cc.Sprite:create("role/shop_image/" .. model_data[servant_data[item_data[arg_49_0.dropid].servant].modelid].role_image .. ".png")

		var_49_3:setAnchorPoint(cc.p(0.5, 0))
		var_49_3:setScale(0.9)
		var_49_3:setPosition(cc.p(var_49_2:getContentSize().width / 2, -100))
		var_49_3:setName("icon")
		var_49_2:addChild(var_49_3)

		local var_49_4 = servant_data[item_data[arg_49_0.dropid].servant].roll_rarity or 1
		local var_49_5 = ccui.ImageView:create(var_0_36[var_49_4], var_0_22)

		var_49_5:setScale(0.5)
		var_49_5:setAnchorPoint(cc.p(0, 1))
		var_49_5:setPosition(cc.p(0, var_49_1:getContentSize().height))
		var_49_1:addChild(var_49_5, 1)

		local var_49_6 = global_get_all_model_attrs(servant_data[item_data[arg_49_0.dropid].servant].modelid)
		local var_49_7 = var_49_6.main

		if var_49_6.sub and next(var_49_6.sub) then
			for iter_49_0, iter_49_1 in ipairs(var_49_6.sub) do
				var_49_7 = var_49_7 .. "_" .. iter_49_1
			end
		end

		local var_49_8 = ccui.ImageView:create(CAREER_ICON[servant_data[item_data[arg_49_0.dropid].servant].career .. "_" .. var_49_7], var_0_22)

		var_49_8:setScale(0.7)
		var_49_8:setAnchorPoint(cc.p(0, 0))
		var_49_8:setPosition(cc.p(0, 0))
		var_49_1:addChild(var_49_8, 1)

		local var_49_9

		if var_49_4 >= 5 then
			var_49_9 = var_0_64
		elseif var_49_4 >= 4 then
			var_49_9 = var_0_62
		elseif var_49_4 >= 3 then
			var_49_9 = var_0_63
		end

		if var_49_9 then
			for iter_49_2 = 1, 2 do
				local var_49_10 = ccui.ImageView:create(var_49_9, var_0_22)

				var_49_10:setPosition(cc.p(var_49_1:getContentSize().width / 2, var_49_1:getContentSize().height / 2))

				if iter_49_2 == 1 then
					var_49_10:setScale(1.1)
					var_49_10:setOpacity(0)
					var_49_10:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1)), cc.Spawn:create(cc.FadeOut:create(1), cc.ScaleTo:create(1, 1.1)), cc.Spawn:create(cc.FadeIn:create(1), cc.ScaleTo:create(1, 1)), cc.Spawn:create(cc.FadeOut:create(0.6), cc.ScaleTo:create(0.6, 1.1)))))
				else
					var_49_10:setScale(1)
					var_49_10:setOpacity(255)
					var_49_10:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.FadeOut:create(0.6), cc.ScaleTo:create(0.6, 1.1)), cc.Spawn:create(cc.FadeIn:create(1), cc.ScaleTo:create(1, 1)), cc.Spawn:create(cc.FadeOut:create(1), cc.ScaleTo:create(1, 1.1)), cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1)))))
				end

				var_49_1:addChild(var_49_10, 2)
			end
		end

		return var_49_1
	end,
	[kITEM_HORCRUX] = function(arg_50_0)
		local var_50_1 = item_data[arg_50_0.dropid].image_offset_y or 0
		local var_50_2 = (item_data[arg_50_0.dropid].image_offse_x or 0) * 0.65
		local var_50_3 = global_get_model_attr(horcrux_data[arg_50_0.dropid].model)
		local var_50_4 = ccui.ImageView:create(var_0_61[var_50_3], var_0_22)
		local var_50_5 = ccui.Layout:create()

		var_50_5:setClippingEnabled(true)
		var_50_5:setContentSize(var_50_4:getContentSize().width - 8, var_50_4:getContentSize().height - 8)
		var_50_5:setPosition(cc.p(4, 4))
		var_50_5:setCascadeOpacityEnabled(true)
		var_50_5:setName("clip")
		var_50_4:addChild(var_50_5)

		local var_50_6 = cc.Sprite:create("role1/" .. horcrux_manager:getHorcruxRoleImage(arg_50_0.dropid) .. ".png")

		var_50_6:setScale(0.65)
		var_50_6:setAnchorPoint(cc.p(0.5, 0))
		var_50_6:setPosition(cc.p(var_50_5:getContentSize().width / 2 + var_50_2, -40 + var_50_1 * 0.65))
		var_50_6:setName("icon")
		var_50_5:addChild(var_50_6)

		local var_50_7 = horcrux_data[arg_50_0.dropid].rarity or 1
		local var_50_8 = ccui.ImageView:create(var_0_36[var_50_7], var_0_22)

		var_50_8:setScale(0.5)
		var_50_8:setAnchorPoint(cc.p(0, 1))
		var_50_8:setPosition(cc.p(0, var_50_4:getContentSize().height))
		var_50_4:addChild(var_50_8, 1)

		local var_50_9 = ccui.ImageView:create(ATTRICONPATH[var_50_3], var_0_22)

		var_50_9:setScale(0.7)
		var_50_9:setAnchorPoint(cc.p(0, 0))
		var_50_9:setPosition(cc.p(0, 0))
		var_50_4:addChild(var_50_9, 1)

		for iter_50_0 = 1, arg_50_0.iteminfo.horcrux_attr.star do
			local var_50_10 = ccui.ImageView:create(var_0_37[1], var_0_22)

			var_50_10:setScale(0.5)
			var_50_10:setPosition(cc.p(var_50_4:getContentSize().width - 20, 20 + 30 * (iter_50_0 - 1)))
			var_50_4:addChild(var_50_10, 1)
		end

		if var_50_7 > 2 then
			for iter_50_1 = 1, 2 do
				local var_50_11

				if var_50_7 > 3 then
					var_50_11 = ccui.ImageView:create(var_0_62, var_0_22) or ccui.ImageView:create(var_0_63, var_0_22)
				end

				var_50_11:setPosition(cc.p(var_50_4:getContentSize().width / 2, var_50_4:getContentSize().height / 2))

				if iter_50_1 == 1 then
					var_50_11:setScale(1.1)
					var_50_11:setOpacity(0)
					var_50_11:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1)), cc.Spawn:create(cc.FadeOut:create(1), cc.ScaleTo:create(1, 1.1)), cc.Spawn:create(cc.FadeIn:create(1), cc.ScaleTo:create(1, 1)), cc.Spawn:create(cc.FadeOut:create(0.6), cc.ScaleTo:create(0.6, 1.1)))))
				else
					var_50_11:setScale(1)
					var_50_11:setOpacity(255)
					var_50_11:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.FadeOut:create(0.6), cc.ScaleTo:create(0.6, 1.1)), cc.Spawn:create(cc.FadeIn:create(1), cc.ScaleTo:create(1, 1)), cc.Spawn:create(cc.FadeOut:create(1), cc.ScaleTo:create(1, 1.1)), cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1)))))
				end

				var_50_4:addChild(var_50_11, 2)
			end
		end

		return var_50_4
	end,
	[kITEM_DRAWING] = function(arg_51_0)
		local var_51_0 = ccui.ImageView:create(var_0_60[item_data[arg_51_0.dropid].equip_quality], var_0_22)
		local var_51_1 = cc.Label:createWithTTF("", "fonts/number.ttf", 25)

		var_51_1:setString(item_data[arg_51_0.dropid].name)
		var_51_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_51_1:setPosition(cc.p(var_51_0:getContentSize().width / 2, var_51_0:getContentSize().height / 2 - 90))
		var_51_0:addChild(var_51_1, 1)

		local var_51_2 = ccui.Layout:create()

		var_51_2:setClippingEnabled(true)
		var_51_2:setContentSize(cc.size(170, 170))
		var_51_2:setPosition(cc.p(var_51_0:getContentSize().width / 2 - 85, var_51_0:getContentSize().height / 2 - 56))
		var_51_2:setCascadeOpacityEnabled(true)
		var_51_2:setName("clip")
		var_51_0:addChild(var_51_2)

		local var_51_3 = cc.Sprite:create("equipment/draw.png")

		var_51_3:setPosition(cc.p(84, 84))
		var_51_3:setName("icon")
		var_51_3:setCascadeOpacityEnabled(true)
		var_51_2:addChild(var_51_3)

		local var_51_4 = cc.Sprite:create("equipment/" .. item_data[arg_51_0.dropid].image_id .. ".png")

		var_51_4:setScale(0.46875)
		var_51_4:setPosition(cc.p(var_51_3:getContentSize().width / 2, var_51_3:getContentSize().height / 2))
		var_51_3:addChild(var_51_4)

		if item_data[arg_51_0.dropid].equip_quality >= 5 then
			local var_51_5 = cc.Sprite:createWithSpriteFrameName("eggegg_1.png")

			var_51_5:setScale(1.25)
			var_51_5:setName("eggEffect")
			var_51_5:setAnchorPoint(cc.p(0.5, 0.5))
			var_51_5:setPosition(var_51_0:getContentSize().width / 2, var_51_0:getContentSize().height / 2)

			local var_51_6 = cc.Animation:create()

			for iter_51_0 = 1, 8 do
				var_51_6:addSpriteFrame((cc.SpriteFrameCache:getInstance():getSpriteFrame("eggegg_" .. iter_51_0 .. ".png")))
			end

			var_51_6:setDelayPerUnit(0.1)
			var_51_6:setRestoreOriginalFrame(true)
			var_51_5:runAction(cc.RepeatForever:create(cc.Animate:create(var_51_6)))
			var_51_0:addChild(var_51_5)
		end

		return var_51_0
	end,
	[kITEM_HORCRUX_DRAWING] = function(arg_52_0)
		local var_52_0 = ccui.ImageView:create(var_0_60[item_data[arg_52_0.dropid].equip_quality], var_0_22)
		local var_52_1 = cc.Label:createWithTTF("", "fonts/number.ttf", 25)

		var_52_1:setString(item_data[arg_52_0.dropid].name)
		var_52_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_52_1:setPosition(cc.p(var_52_0:getContentSize().width / 2, var_52_0:getContentSize().height / 2 - 90))
		var_52_0:addChild(var_52_1, 1)

		local var_52_2 = ccui.Layout:create()

		var_52_2:setClippingEnabled(true)
		var_52_2:setContentSize(cc.size(170, 170))
		var_52_2:setPosition(cc.p(var_52_0:getContentSize().width / 2 - 85, var_52_0:getContentSize().height / 2 - 56))
		var_52_2:setCascadeOpacityEnabled(true)
		var_52_2:setName("clip")
		var_52_0:addChild(var_52_2)

		local var_52_3 = cc.Sprite:create("equipment/draw.png")

		var_52_3:setPosition(cc.p(84, 84))
		var_52_3:setName("icon")
		var_52_3:setCascadeOpacityEnabled(true)
		var_52_2:addChild(var_52_3)

		local var_52_4 = cc.Sprite:create("equipment/" .. item_data[arg_52_0.dropid].image_id .. ".png")

		var_52_4:setScale(0.46875)
		var_52_4:setPosition(cc.p(var_52_3:getContentSize().width / 2, var_52_3:getContentSize().height / 2))
		var_52_3:addChild(var_52_4)

		if item_data[arg_52_0.dropid].equip_quality >= 5 then
			local var_52_5 = cc.Sprite:createWithSpriteFrameName("eggegg_1.png")

			var_52_5:setScale(1.25)
			var_52_5:setName("eggEffect")
			var_52_5:setAnchorPoint(cc.p(0.5, 0.5))
			var_52_5:setPosition(var_52_0:getContentSize().width / 2, var_52_0:getContentSize().height / 2)

			local var_52_6 = cc.Animation:create()

			for iter_52_0 = 1, 8 do
				var_52_6:addSpriteFrame((cc.SpriteFrameCache:getInstance():getSpriteFrame("eggegg_" .. iter_52_0 .. ".png")))
			end

			var_52_6:setDelayPerUnit(0.1)
			var_52_6:setRestoreOriginalFrame(true)
			var_52_5:runAction(cc.RepeatForever:create(cc.Animate:create(var_52_6)))
			var_52_0:addChild(var_52_5)
		end

		return var_52_0
	end
}

local function var_0_69(arg_53_0, arg_53_1)
	return function(arg_54_0)
		local var_54_0 = item_data[arg_54_0.dropid].equip_quality
		local var_54_1 = ccui.ImageView:create(var_0_60[item_data[arg_54_0.dropid].equip_quality], var_0_22)
		local var_54_2 = cc.Label:createWithTTF("", "fonts/number.ttf", 25)

		if arg_54_0.dropnum > 1 then
			var_54_2:setString(item_data[arg_54_0.dropid].name .. " X" .. arg_54_0.dropnum)
		else
			var_54_2:setString(item_data[arg_54_0.dropid].name)
		end

		var_54_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_54_2:setPosition(cc.p(var_54_1:getContentSize().width / 2, var_54_1:getContentSize().height / 2 - 90))
		var_54_1:addChild(var_54_2, 1)

		local var_54_3 = ccui.Layout:create()

		var_54_3:setClippingEnabled(true)
		var_54_3:setContentSize(cc.size(170, 170))
		var_54_3:setPosition(cc.p(var_54_1:getContentSize().width / 2 - 85, var_54_1:getContentSize().height / 2 - 56))
		var_54_3:setCascadeOpacityEnabled(true)
		var_54_3:setName("clip")
		var_54_1:addChild(var_54_3)

		local var_54_4 = cc.Sprite:create("equipment/" .. item_data[arg_54_0.dropid].image_id .. ".png")

		var_54_4:setPosition(cc.p(84, 84))
		var_54_4:setName("icon")
		var_54_3:addChild(var_54_4)

		if var_54_0 >= 5 then
			local var_54_5 = cc.Sprite:createWithSpriteFrameName("eggegg_1.png")

			var_54_5:setScale(1.25)
			var_54_5:setName("eggEffect")
			var_54_5:setAnchorPoint(cc.p(0.5, 0.5))
			var_54_5:setPosition(var_54_1:getContentSize().width / 2, var_54_1:getContentSize().height / 2)

			local var_54_6 = cc.Animation:create()

			for iter_54_0 = 1, 8 do
				var_54_6:addSpriteFrame((cc.SpriteFrameCache:getInstance():getSpriteFrame("eggegg_" .. iter_54_0 .. ".png")))
			end

			var_54_6:setDelayPerUnit(0.1)
			var_54_6:setRestoreOriginalFrame(true)
			var_54_5:runAction(cc.RepeatForever:create(cc.Animate:create(var_54_6)))
			var_54_1:addChild(var_54_5)
		end

		if item_data[arg_54_0.dropid].bag_item_type == kITEM_WEAPON then
			var_54_4:setScale(0.65)
		end

		return var_54_1
	end
end

setmetatable(var_0_68, {
	__index = var_0_69,
	__call = function(self, arg_55_1, ...)
		return self[arg_55_1](...)
	end
})

function TwisteggLayer:showTwistFinalResult(arg_56_1, arg_56_2, arg_56_3, arg_56_4)
	self.skipBnt:setVisible(false)
	self.twistSureBtn:setVisible(false)
	self.twistAgainBtn:setVisible(false)
	self.twistLeftTimesLabel:setVisible(false)
	self.twistingRectPanel:setVisible(true)
	self.resultBg:setTexture(var_0_28)
	self.twistingRectPanel:getChildByName("blackcardinfo"):setVisible(false)
	cc.SpriteFrameCache:getInstance():addSpriteFrames("effect/twist_animation/eggegg.plist")

	self.resultTouchEnabled = false

	local var_56_0 = #arg_56_2 == 1 and {
		cc.p(320, GameDisplay.height / 2)
	} or var_0_56()

	local function var_56_1(arg_57_0)
		local var_57_0 = self.twistingRectPanel:getChildByName("rect" .. arg_57_0)

		if not var_57_0 then
			var_57_0 = L2Skeleton:create(var_0_30 .. ".json", var_0_30 .. ".atlas", nil, true)

			var_57_0:refreshSkeleton()
			var_57_0:setName("rect" .. arg_57_0)
			self.twistingRectPanel:addChild(var_57_0)
		end

		return var_57_0
	end

	local function var_56_2()
		return coroutine.create(function()
			for iter_59_0 = 1, #arg_56_2 do
				local var_59_0 = var_56_1(iter_59_0)

				var_59_0:setPosition(var_56_0[iter_59_0])
				var_59_0:setVisible(true)
				var_59_0:registerListener(SP_ANIMATION_COMPLETE, function(arg_60_0)
					if arg_60_0.animation == "blue-out" or arg_60_0.animation == "orange-out" or arg_60_0.animation == "red-out" or arg_60_0.animation == "purple-out" then
						var_59_0:setVisible(false)
					end
				end)

				local var_59_1 = arg_56_2[iter_59_0].dropid
				local var_59_2 = arg_56_2[iter_59_0].entityid
				local var_59_3, var_59_4 = var_59_0:getPosition()
				local var_59_5 = item_data[arg_56_2[iter_59_0].dropid].bag_item_type
				local var_59_6 = var_0_68(item_data[arg_56_2[iter_59_0].dropid].bag_item_type, arg_56_2[iter_59_0], self.twistBlackCard)

				var_59_6:setName("item" .. iter_59_0)
				var_59_6:setPosition(cc.p(var_59_3, var_59_4))
				var_59_6:setOpacity(0)

				local var_59_7 = var_59_6:getChildByName("clip"):getChildByName("icon")

				var_59_7:setOpacity(0)
				self.twistingRectPanel:addChild(var_59_6)
				var_59_6:setTouchEnabled(true)
				var_59_6:addTouchEventListener(function(arg_61_0, arg_61_1)
					if arg_61_1 ~= ccui.TouchEventType.ended then
						return
					end

					if not self.resultTouchEnabled then
						return
					end

					if var_59_5 == kITEM_HORCRUX then
						if self.twistConfig[arg_56_1].stat == 3 then
							local var_61_0 = -1

							for iter_61_0, iter_61_1 in pairs((require("data.photofile_HelpGirl_data"))) do
								if var_59_1 == iter_61_1.item_id then
									var_61_0 = iter_61_0

									break
								end
							end

							if var_61_0 == -1 then
								print("did not find id")

								return
							end

							require("view.Layer.DetailsofHelpGirlLayer")
							LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
								id = var_61_0,
								itemid = var_59_1,
								callback = callback
							})
						else
							LayerManager:pushInLayer("HorcruxInfoLayer", var_59_2, "twist_preview")
						end

						return
					end

					if var_59_5 == kITEM_HERO then
						if arg_56_2[iter_59_0].itemid == 1500001 then
							if not global_basic_scene:getChildByName("OTHER_LAYER") then
								local var_61_2 = PopLayer:Item({
									hideGainButton = true,
									itemid = arg_56_2[iter_59_0].itemid
								})
							end
						else
							LayerManager:pushInLayer("SoulsLayer", {
								showtype = SHOW_TYPE_TWISTEGG_PREVIEW,
								cursoul = item_data[var_59_1].servant
							})
						end

						return
					end

					if not global_basic_scene:getChildByName("OTHER_LAYER") then
						local var_61_3 = PopLayer:Item({
							hideGainButton = true,
							itemid = var_59_1
						})
					end
				end)

				if var_0_59(arg_56_2[iter_59_0].dropid) then
					var_59_0:play("red-out", false)
				elseif var_0_57(arg_56_2[iter_59_0].dropid) then
					var_59_0:play("orange-out", false)
				elseif var_0_58(arg_56_2[iter_59_0].dropid) then
					var_59_0:play("purple-out", false)
				else
					var_59_0:play("blue-out", false)
				end

				var_59_6:runAction(cc.Sequence:create(cc.DelayTime:create(0.6666666666666666), cc.FadeIn:create(0.2)))
				var_59_7:runAction(cc.Sequence:create(cc.DelayTime:create(0.6666666666666666), cc.FadeIn:create(0.2)))
				var_59_6:runAction(cc.Sequence:create(cc.DelayTime:create(0.6666666666666666), cc.CallFunc:create(function()
					audio_manager:playeffectMusic(TWIST_ADD_EFFECT_AFTER)
				end)))

				if not var_0_55[arg_56_1] then
					audio_manager:playeffectMusic(TWIST_ADD_EFFECT)
				end

				coroutine.yield(iter_59_0)
			end

			if arg_56_4 and arg_56_4 > 0 then
				self.twistingRectPanel:getChildByName("blackcardinfo"):setVisible(true)

				if self.lastTwistBlackCard == BLACK_CARD then
					self.twistingRectPanel:getChildByName("blackcardinfo"):loadTexture("TwistEgg/panel_blackcard_bg1.png", var_0_22)
					self.twistingRectPanel:getChildByName("blackcardinfo"):getChildByName("num"):setString(string.format(L_PLAYER_DATA_TYPE.Horcrux_Card .. "x%d", arg_56_4))
				else
					self.twistingRectPanel:getChildByName("blackcardinfo"):loadTexture("TwistEgg/panel_blackcard_sp_bg1.png", var_0_22)
					self.twistingRectPanel:getChildByName("blackcardinfo"):getChildByName("num"):setString(string.format("SP" .. L_PLAYER_DATA_TYPE.Horcrux_Card .. "x%d", arg_56_4))
				end
			end

			self.twistSureBtn:setOpacity(0)
			self.twistSureBtn:setVisible(true)
			self.twistSureBtn:runAction(cc.FadeIn:create(0.2))

			if arg_56_1 ~= 26 then
				self.twistAgainBtn:setOpacity(0)
				self.twistAgainBtn:setVisible(true)
				self.twistAgainBtn:runAction(cc.FadeIn:create(0.2))
			else
				self.twistAgainBtn:setVisible(false)
			end

			require("controller.condition_trigger_packs_manager"):check_trigger_condition({
				shop_type = BOOSTER_PACKS,
				hero_items = self.hero_items
			})
			require("controller.condition_trigger_packs_manager"):check_trigger_condition({
				shop_type = SKINS_PACKS,
				twistid = arg_56_1
			})

			return "end"
		end)
	end

	if self.showAniScheduler then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.showAniScheduler)
	end

	local var_56_3 = var_56_2()
	local var_56_4, var_56_5 = coroutine.resume(var_56_3)

	assert(var_56_4, var_56_5)

	self.showAniScheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_63_0)
		if not var_56_3 then
			var_56_3 = var_56_2()

			return
		end

		local var_63_0, var_63_1 = coroutine.resume(var_56_3)

		assert(var_63_0, var_63_1)

		if var_63_1 == "end" then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.showAniScheduler)

			self.showAniScheduler = nil
			var_56_3 = nil
			self.resultTouchEnabled = true
		end
	end, 0.2, false)

	self:registerFinalResultBntEvent(arg_56_1, arg_56_3)
end

function TwisteggLayer:registerFinalResultBntEvent(arg_64_1, arg_64_2)
	local function var_64_0()
		self.resultTouchEnabled = false
		self.isAlowOtherTouch = true
		self.tenBtnOtherLock = false

		self.twistingRectPanel:setVisible(false)
		self:cleanTwistRectPanel()
		self.showPanel:setVisible(false)
		self.resultPanel:setVisible(false)
		self.resultInfosPanel:setVisible(false)
		self:cleanShowResultPanelEvent()
	end

	if self.twistConfig[arg_64_1].stat == 3 then
		self.twistSureBtn:addTouchEventListener(function(arg_66_0, arg_66_1)
			if arg_66_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not self.resultTouchEnabled then
				return
			end

			if self.twistConfig[arg_64_1].stat ~= 3 then
				return
			end

			if arg_66_0.isLock then
				return
			end

			arg_66_0.isLock = true

			self:sureNaiveTwistResult(arg_64_1, function()
				arg_66_0.isLock = false

				var_64_0()
				self:showPurchaseLayer()
			end)
		end)
	else
		self.twistSureBtn:addTouchEventListener(function(arg_68_0, arg_68_1)
			if arg_68_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not self.resultTouchEnabled then
				return
			end

			var_64_0()
			self:showPurchaseLayer()
		end)
		self.twistAgainBtn:addTouchEventListener(function(arg_69_0, arg_69_1)
			if arg_69_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.twistConfig[arg_64_1].stat == 3 then
				return
			end

			var_64_0()
			LayerManager:showTopBottomLayer({
				TopcostLayer = true
			})

			if self.pay_type == "ten" then
				self:onTouchTenBtn(self.tenBtn, ccui.TouchEventType.ended)
			else
				self:onTouchOneBtn(self.oneBtn, ccui.TouchEventType.ended)
			end
		end)
	end
end

function TwisteggLayer:showPurchaseLayer()
	local function var_70_0()
		LayerManager:showTopBottomLayer({
			TopcostLayer = true
		})
		autopop_manager:resumeAchievementPop()
		self:setGuideLock(false)
		self:updateGuidesOnLayer()
	end

	local var_70_1 = {}
	local var_70_2 = {}

	for iter_70_0, iter_70_1 in pairs(self.totalAward) do
		table.insert(var_70_1, {
			dropid = iter_70_0,
			dropNum = iter_70_1,
			entityid = iter_70_0
		})
	end

	var_70_2.cancelcallback = var_70_0
	var_70_2.items = var_70_1
	var_70_2.layer = "TwisteggLayer"
	self.totalAward = {}

	if next(var_70_1) then
		local function var_70_3(arg_72_0)
			if item_data[arg_72_0.dropid].bag_item_type == kITEM_SCULTURE then
				return 1
			end

			if item_data[arg_72_0.dropid].bag_item_type == kITEM_SERVANT_CHIP then
				return 2
			end

			return 3
		end

		local var_70_4 = {
			{
				weight = 10,
				func = function(arg_73_0, arg_73_1)
					if var_70_3(arg_73_0) == var_70_3(arg_73_1) then
						return "=="
					else
						return var_70_3(arg_73_0) < var_70_3(arg_73_1)
					end
				end
			}
		}

		table.sort(var_70_4, function(arg_74_0, arg_74_1)
			return arg_74_0.weight > arg_74_1.weight
		end)
		table.sort(var_70_1, function(arg_75_0, arg_75_1)
			for iter_75_0 = 1, #var_70_4 do
				if var_70_4[iter_75_0].func(arg_75_0, arg_75_1) ~= "==" then
					return var_70_4[iter_75_0].func(arg_75_0, arg_75_1)
				end
			end
		end)
		cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("updateMainLineTaskUI"))
		LayerManager:pushInLayer("PopPurchaseResultLayer", var_70_2)
	else
		var_70_0()
	end
end

function TwisteggLayer:initShowResultPanel()
	self.skipBnt:setPositionY(self.skipBnt:getPositionY() - GameDisplay.fix_y)

	self.resultTouchEnabled = false
	self.resultBg = cc.Sprite:create(var_0_27)

	self.resultBg:setPosition(cc.p(320, GameDisplay.height / 2))
	self.resultBg:setVisible(false)
	self.showPanel:addChild(self.resultBg, 1)

	self.resultAni = L2Skeleton:create(var_0_29 .. ".json", var_0_29 .. ".atlas", nil, true)

	self.resultAni:refreshSkeleton()
	self.resultAni:setPosition(cc.p(-45, 638 + GameDisplay.fix_y))
	self.resultAni:setVisible(false)
	self.showPanel:addChild(self.resultAni, 3)

	self.resultPanel = ccui.Layout:create()

	self.resultPanel:setContentSize(cc.size(640, GameDisplay.height))
	self.resultPanel:setVisible(false)
	self.showPanel:addChild(self.resultPanel, 4)

	self.resultInfosPanel = ccui.Layout:create()

	self.resultInfosPanel:setContentSize(cc.size(640, GameDisplay.height))
	self.resultInfosPanel:setVisible(false)
	self.showPanel:addChild(self.resultInfosPanel, 5)

	local var_76_0 = ccui.ImageView:create("TwistEgg/panel_blackcard_bg2.png", var_0_22)

	var_76_0:setAnchorPoint(cc.p(1, 0.5))
	var_76_0:setPosition(cc.p(640, 221 + GameDisplay.fix_y))
	var_76_0:setName("blackcardinfo")
	self.resultPanel:addChild(var_76_0, 5)

	local var_76_1 = cc.Label:createWithTTF(L_PLAYER_DATA_TYPE.Horcrux_Card .. "x1", "fonts/number.ttf", 18)

	var_76_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_76_1:setPosition(cc.p(var_76_0:getContentSize().width / 2 + 32, var_76_0:getContentSize().height / 2 - 14))
	var_76_1:setName("num")
	var_76_0:addChild(var_76_1)

	local var_76_2 = ccui.ImageView:create("equipment/1502011.png")

	var_76_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_76_2:setPosition(cc.p(34, var_76_0:getContentSize().height / 2))
	var_76_2:setName("icon")
	var_76_2:setScale(0.5)
	var_76_0:addChild(var_76_2)

	local var_76_3 = ccui.ImageView:create("mainScenebg/other/format_twist.png")

	var_76_3:setAnchorPoint(cc.p(1, 0.5))
	var_76_3:setPosition(cc.p(640, 221 + GameDisplay.fix_y))
	var_76_3:setName("formatinfo")
	self.resultPanel:addChild(var_76_3, 5)

	local var_76_4 = cc.Label:createWithTTF("X1", "fonts/number.ttf", 22)

	var_76_4:setAnchorPoint(cc.p(0.5, 0.5))
	var_76_4:setPosition(cc.p(var_76_3:getContentSize().width / 2 + 45, var_76_3:getContentSize().height / 2 - 23))
	var_76_4:setName("num")
	var_76_3:addChild(var_76_4)

	local var_76_5 = ccui.ImageView:create("equipment/1502011.png")

	var_76_5:setAnchorPoint(cc.p(0.5, 0.5))
	var_76_5:setPosition(cc.p(60, var_76_3:getContentSize().height / 2))
	var_76_5:setName("icon")
	var_76_5:setScale(0.7)
	var_76_3:addChild(var_76_5)

	self.twistingRectPanel = ccui.Layout:create()

	self.twistingRectPanel:setContentSize(cc.size(640, GameDisplay.height))
	self.twistingRectPanel:setTouchEnabled(true)
	self.twistingRectPanel:setVisible(false)
	self.showPanel:addChild(self.twistingRectPanel, 2)

	local var_76_6 = ccui.ImageView:create("TwistEgg/panel_blackcard_bg1.png", var_0_22)

	var_76_6:setAnchorPoint(cc.p(1, 0.5))
	var_76_6:setPosition(cc.p(640, 306 + GameDisplay.fix_y))
	var_76_6:setScale(0.85)
	var_76_6:setName("blackcardinfo")
	var_76_6:setVisible(false)
	self.twistingRectPanel:addChild(var_76_6, 5)

	local var_76_7 = cc.Label:createWithTTF(L_PLAYER_DATA_TYPE.Horcrux_Card .. "x20", "fonts/number.ttf", 28)

	var_76_7:setAnchorPoint(cc.p(0.5, 0.5))
	var_76_7:setPosition(cc.p(var_76_6:getContentSize().width / 2 + 50, var_76_6:getContentSize().height / 2 - 36))
	var_76_7:setName("num")
	var_76_6:addChild(var_76_7)

	self.twistSureBtn = ccui.Button:create(var_0_65[1], var_0_65[2], var_0_65[1], var_0_22)

	self.twistSureBtn:setPressedActionEnabled(true)
	self.twistSureBtn:setPosition(cc.p(450, 100 + GameDisplay.fix_y))
	self.twistSureBtn:setVisible(false)
	self.twistingRectPanel:addChild(self.twistSureBtn)

	self.twistAgainBtn = ccui.Button:create(var_0_66[1], var_0_66[2], var_0_66[1], var_0_22)

	self.twistAgainBtn:setPressedActionEnabled(true)
	self.twistAgainBtn:setPosition(cc.p(450, 200 + GameDisplay.fix_y))
	self.twistAgainBtn:setVisible(true)
	self.twistingRectPanel:addChild(self.twistAgainBtn)

	self.twistAgainLabel = cc.Label:createWithTTF(L_TWISTRESUTL[1], "fonts/number.ttf", 36)

	self.twistAgainLabel:setPosition(115, 45)
	self.twistAgainLabel:setColor(cc.c3b(0, 0, 0))
	self.twistAgainBtn:addChild(self.twistAgainLabel)

	self.twistLeftTimesLabel = cc.Label:createWithTTF(L_TWISTRESUTL[2], "fonts/number.ttf", 28)

	self.twistLeftTimesLabel:setPosition(450, 40 + GameDisplay.fix_y)
	self.twistLeftTimesLabel:setVisible(false)
	self.twistingRectPanel:addChild(self.twistLeftTimesLabel)
end

function TwisteggLayer:cleanTwistRectPanel()
	self.resultTouchEnabled = false

	for iter_77_0 = 1, 10 do
		local var_77_0 = self.twistingRectPanel:getChildByName("rect" .. iter_77_0)

		if var_77_0 then
			var_77_0:setVisible(false)
		else
			break
		end
	end

	for iter_77_1 = 1, 10 do
		if self.twistingRectPanel:getChildByName("item" .. iter_77_1) then
			self.twistingRectPanel:removeChildByName("item" .. iter_77_1)
		else
			break
		end
	end

	self.twistSureBtn:setVisible(false)
	self.twistAgainBtn:setVisible(false)
	self.twistLeftTimesLabel:setVisible(false)
	self.twistSureBtn:setPosition(cc.p(450, 100 + GameDisplay.fix_y))
	self.twistAgainBtn:setPosition(cc.p(450, 200 + GameDisplay.fix_y))
	self.twistSureBtn:loadTextures(var_0_65[1], var_0_65[2], var_0_65[1], var_0_22)
end

function TwisteggLayer:cleanShowResultPanelEvent()
	self.resultTouchEnabled = false

	self.showPanel:addTouchEventListener(function(arg_79_0, arg_79_1)
		return
	end)
	self.skipBnt:addTouchEventListener(function(arg_80_0, arg_80_1)
		return
	end)
end

function TwisteggLayer:twistcost(arg_81_1, arg_81_2, arg_81_3, arg_81_4, arg_81_5, arg_81_6)
	local var_81_0 = self.twist_type_to_index[arg_81_2]
	local var_81_1 = self.curtwistData[self.twist_type_to_index[arg_81_2]].costtype

	if arg_81_1 == var_0_23 then
		self:updateTwistCount(arg_81_2, 1, arg_81_4, arg_81_5)

		if arg_81_2 == TWIST_TYPE_FREE then
			self.freetime = self.freetime - 1
		elseif self.curtwistData[self.twist_type_to_index[arg_81_2]].dailyfreeforone and self.curtwistData[self.twist_type_to_index[arg_81_2]].dailyfreeforone > 0 then
			self.curtwistData[self.twist_type_to_index[arg_81_2]].dailyfreeforone = self.curtwistData[self.twist_type_to_index[arg_81_2]].dailyfreeforone - 1
			var_81_1 = COST_FOR_FREE
		elseif self.curtwistData[self.twist_type_to_index[arg_81_2]].totalfreeforone and self.curtwistData[self.twist_type_to_index[arg_81_2]].totalfreeforone > 0 then
			self.curtwistData[self.twist_type_to_index[arg_81_2]].totalfreeforone = self.curtwistData[self.twist_type_to_index[arg_81_2]].totalfreeforone - 1
			var_81_1 = COST_FOR_FREE
		else
			if self.curtwistData[self.twist_type_to_index[arg_81_2]].once_twist_ticket then
				if (self.curtwistData[self.twist_type_to_index[arg_81_2]].costone or 1) <= item_manager:getItemNumber(self.curtwistData[self.twist_type_to_index[arg_81_2]].once_twist_ticket) then
					item_manager:deleteItem(self.curtwistData[self.twist_type_to_index[arg_81_2]].once_twist_ticket, self.curtwistData[self.twist_type_to_index[arg_81_2]].costone or 1)

					goto label_81_0
				end
			end

			if self.curtwistData[self.twist_type_to_index[arg_81_2]].once_twist_ticket_1 then
				if (self.curtwistData[self.twist_type_to_index[arg_81_2]].costone or 1) <= item_manager:getItemNumber(self.curtwistData[self.twist_type_to_index[arg_81_2]].once_twist_ticket_1) then
					item_manager:deleteItem(self.curtwistData[self.twist_type_to_index[arg_81_2]].once_twist_ticket_1, self.curtwistData[self.twist_type_to_index[arg_81_2]].costone or 1)

					goto label_81_0
				end
			end

			if self.curtwistData[self.twist_type_to_index[arg_81_2]].costtype > 2 then
				item_manager:deleteItem(self.curtwistData[self.twist_type_to_index[arg_81_2]].costtype, self.curtwistData[self.twist_type_to_index[arg_81_2]].costone)

				self.curtwistData[self.twist_type_to_index[arg_81_2]].twist_remain_count = arg_81_3

				if arg_81_2 == 2 then
					RoleDefault:getInstance():setIntegerForKey("twistType2_remain_count", arg_81_3)
				end
			elseif self.curtwistData[self.twist_type_to_index[arg_81_2]].costtype == COST_FOR_GOLD then
				playermodel.gold = playermodel.gold - self.curtwistData[var_81_0].costone

				global_update_gold_stone_diamond(playermodel.gold)

				self.curtwistData[self.twist_type_to_index[arg_81_2]].twist_remain_count = arg_81_3

				AnalyticManager.twistCostSuccess(self.curtwistData[var_81_0].costone)
			elseif self.curtwistData[self.twist_type_to_index[arg_81_2]].costtype == 0 then
				playermodel.diamond = playermodel.diamond - self.curtwistData[var_81_0].costone

				global_update_gold_stone_diamond(nil, nil, 1)

				self.curtwistData[self.twist_type_to_index[arg_81_2]].twist_remain_count = arg_81_3

				AnalyticManager.twistCostSuccess(nil, self.curtwistData[var_81_0].costone, 1)
			end
		end

		::label_81_0::

		AnalyticManager.twist_one_success({
			twisttype = arg_81_2,
			cost_type = var_81_1,
			cost_num = var_81_1 == COST_FOR_FREE and 1 or self.curtwistData[var_81_0].costone
		})

		if arg_81_2 == 4 then
			AnalyticManager.favor_twist_one({
				cost_type = var_81_1,
				cost_num = var_81_1 == COST_FOR_FREE and 1 or self.curtwistData[var_81_0].costone
			})
		end
	elseif arg_81_1 == var_0_24 then
		self:updateTwistCount(arg_81_2, 10, arg_81_4, arg_81_5)

		if arg_81_2 == TWIST_TYPE_FREE then
			self.freetime = self.freetime - 10
		elseif self.curtwistData[self.twist_type_to_index[arg_81_2]].dailyfreeforten and self.curtwistData[self.twist_type_to_index[arg_81_2]].dailyfreeforten > 0 then
			self.curtwistData[self.twist_type_to_index[arg_81_2]].dailyfreeforten = self.curtwistData[self.twist_type_to_index[arg_81_2]].dailyfreeforten - 1
			var_81_1 = COST_FOR_FREE
		elseif self.curtwistData[self.twist_type_to_index[arg_81_2]].totalfreeforten and self.curtwistData[self.twist_type_to_index[arg_81_2]].totalfreeforten > 0 then
			self.curtwistData[self.twist_type_to_index[arg_81_2]].totalfreeforten = self.curtwistData[self.twist_type_to_index[arg_81_2]].totalfreeforten - 1
			var_81_1 = COST_FOR_FREE
		elseif self.curtwistData[self.twist_type_to_index[arg_81_2]].costtype > 2 then
			local var_81_6 = self.curtwistData[self.twist_type_to_index[arg_81_2]].costten

			if self.curtwistData[self.twist_type_to_index[arg_81_2]].twist_remain_count then
				local var_81_7 = math.min(10, self.curtwistData[self.twist_type_to_index[arg_81_2]].twist_remain_count)

				var_81_6 = var_81_7 >= 10 and self.curtwistData[self.twist_type_to_index[arg_81_2]].costten or self.curtwistData[self.twist_type_to_index[arg_81_2]].costone * var_81_7
			end

			local var_81_8, var_81_9 = self:isBlendTwistTicket(var_81_6)

			print(dump(var_81_9))

			for iter_81_0, iter_81_1 in pairs(var_81_9) do
				item_manager:deleteItem(iter_81_1.itemid, iter_81_1.num)
			end

			self.curtwistData[self.twist_type_to_index[arg_81_2]].twist_remain_count = arg_81_3

			if arg_81_2 == 2 then
				RoleDefault:getInstance():setIntegerForKey("twistType2_remain_count", arg_81_3)
			end
		elseif self.curtwistData[self.twist_type_to_index[arg_81_2]].costtype == COST_FOR_GOLD then
			playermodel.gold = playermodel.gold - self.curtwistData[var_81_0].costten

			global_update_gold_stone_diamond(playermodel.gold)

			self.curtwistData[self.twist_type_to_index[arg_81_2]].twist_remain_count = arg_81_3

			AnalyticManager.twistCostSuccess(self.curtwistData[var_81_0].costten)
		elseif self.curtwistData[self.twist_type_to_index[arg_81_2]].costtype == 0 then
			playermodel.diamond = playermodel.diamond - self.curtwistData[var_81_0].costten

			global_update_gold_stone_diamond(nil, nil, 1)

			self.curtwistData[self.twist_type_to_index[arg_81_2]].twist_remain_count = arg_81_3

			AnalyticManager.twistCostSuccess(nil, self.curtwistData[var_81_0].costten, 10)
		end

		AnalyticManager.twist_ten_success({
			twisttype = arg_81_2,
			cost_type = var_81_1,
			cost_num = var_81_1 == COST_FOR_FREE and 1 or self.curtwistData[var_81_0].costten
		})

		if arg_81_2 == 4 then
			AnalyticManager.favor_twist_one({
				cost_type = var_81_1,
				cost_num = var_81_1 == COST_FOR_FREE and 1 or self.curtwistData[var_81_0].costten
			})
		end
	elseif arg_81_1 == var_0_25 then
		self:updateTwistCount(arg_81_2, arg_81_6, arg_81_4, arg_81_5)

		if arg_81_2 == TWIST_TYPE_FREE then
			self.freetime = self.freetime - arg_81_6
		elseif self.curtwistData[self.twist_type_to_index[arg_81_2]].costtype > 2 then
			local var_81_11, var_81_12 = self:isBlendTwistTicket((self.curtwistData[self.twist_type_to_index[arg_81_2]].twist_remain_count or nil) and self.curtwistData[self.twist_type_to_index[arg_81_2]].costone * math.min(arg_81_6, self.curtwistData[self.twist_type_to_index[arg_81_2]].twist_remain_count))

			print(dump(var_81_12))

			for iter_81_2, iter_81_3 in pairs(var_81_12) do
				item_manager:deleteItem(iter_81_3.itemid, iter_81_3.num)
			end

			self.curtwistData[self.twist_type_to_index[arg_81_2]].twist_remain_count = arg_81_3

			if arg_81_2 == 2 then
				RoleDefault:getInstance():setIntegerForKey("twistType2_remain_count", arg_81_3)
			end
		elseif self.curtwistData[self.twist_type_to_index[arg_81_2]].costtype == COST_FOR_GOLD then
			playermodel.gold = playermodel.gold - self.curtwistData[self.twist_type_to_index[arg_81_2]].costone * arg_81_6

			global_update_gold_stone_diamond(playermodel.gold)
			AnalyticManager.twistCostSuccess(self.curtwistData[self.twist_type_to_index[arg_81_2]].costone * arg_81_6)
		elseif self.curtwistData[self.twist_type_to_index[arg_81_2]].costtype == 0 then
			playermodel.diamond = playermodel.diamond - self.curtwistData[self.twist_type_to_index[arg_81_2]].costone * arg_81_6

			global_update_gold_stone_diamond(nil, nil, 1)
			AnalyticManager.twistCostSuccess(nil, self.curtwistData[self.twist_type_to_index[arg_81_2]].costone * arg_81_6, arg_81_6)
		end
	end

	print("Twist Remain Count: ", arg_81_3)

	if arg_81_3 then
		self:showTwistRemainCountLabel(arg_81_3, arg_81_2)
	end

	self:updateTimePanel()
	self:updateCostInfo(arg_81_2)
	self:checkBtnsAlert()

	if not self:checkIsHaveFreeTimes() then
		require("controller.alert_manager"):unregister_alert(ALERT_TWISTEGG)
	end
end

function TwisteggLayer.twist_one_result(arg_82_0, arg_82_1, arg_82_2)
	autopop_manager:pauseAchievementPop()

	arg_82_0.isAlowOtherTouch = false
	arg_82_0.pay_type = "one"

	network:rpc("add_twistegg_items", {
		twisttype = arg_82_1
	}, function(arg_83_0)
		if arg_83_0.result == 1 then
			arg_82_0.lastTwistBlackCard = arg_82_0.twistBlackCard

			LayerManager:showTopBottomLayer({
				TopcostLayer = false
			})
			arg_82_0:twistcost(var_0_23, arg_82_1, arg_83_0.twist_remain_count, arg_83_0.upcount, arg_83_0.guaranteeprob)
			arg_82_0:updateNoUpdropData(arg_83_0.no_dropup_stat, arg_83_0.totalCount, arg_83_0.no_updrop_count)

			arg_82_0.hero_items = {}

			if arg_83_0.item.itemtype == kITEM_HERO then
				table.insert(arg_82_0.hero_items, arg_83_0.item.itemid)

				if not playermodel.haveServant[item_data[arg_83_0.item.itemid].servant] then
					local var_83_0 = {
						servantid = item_data[arg_83_0.item.itemid].servant
					}

					var_83_0.rarity = servant_data[item_data[arg_83_0.item.itemid].servant].roll_rarity or 1

					AnalyticManager.gain_new_servant_by_twist(var_83_0)
				end
			end

			if arg_83_0.cost_diamond then
				playermodel.diamond = playermodel.diamond - arg_83_0.cost_diamond
			end

			if arg_83_0.consumes and next(arg_83_0.consumes) then
				for iter_83_0, iter_83_1 in ipairs(arg_83_0.consumes) do
					item_manager:deleteItem(iter_83_1.entityid, iter_83_1.num)
				end
			end

			arg_82_0.totalAward = arg_82_0.totalAward or {}

			local var_83_1 = item_manager:setItemByServerItem(arg_83_0.item)

			if arg_83_0.itemformat[1].origina_itemid ~= arg_83_0.itemformat[1].final_itemid then
				arg_82_0.totalAward[arg_83_0.item.entityid] = var_83_1
			elseif arg_83_0.item.entityid == 6800101 then
				arg_82_0.totalAward[arg_83_0.item.entityid] = (arg_82_0.totalAward[arg_83_0.item.entityid] or 0) + var_83_1
			end

			local var_83_3 = {}

			if arg_83_0.item_extra then
				for iter_83_2, iter_83_3 in pairs(arg_83_0.item_extra) do
					if iter_83_2 ~= "elementcard_info" then
						local var_83_4 = {}
						local var_83_5 = item_manager:setItemByServerItem(iter_83_3)
						local var_83_6 = {}
						local var_83_7 = {}

						if iter_83_2 == "servantcard" then
							var_83_6.itemid = iter_83_3.itemid
							var_83_6.itemcount = var_83_5
							var_83_4.servantcard = var_83_6
						end

						if iter_83_2 == "elementcard" then
							var_83_7.itemid = iter_83_3.itemid
							var_83_7.itemcount = var_83_5
							var_83_4.elementcard = var_83_7
						end

						arg_82_0.totalAward[iter_83_3.entityid] = not arg_82_0.totalAward[iter_83_3.entityid] and var_83_5 or var_83_5 + arg_82_0.totalAward[iter_83_3.entityid]

						table.insert(var_83_3, var_83_4)
					end
				end
			end

			if arg_83_0.item_other then
				for iter_83_4, iter_83_5 in ipairs(arg_83_0.item_other) do
					local var_83_8 = item_manager:setItemByServerItem(iter_83_5)

					if var_83_8 > 0 then
						arg_82_0.totalAward[iter_83_5.entityid] = (arg_82_0.totalAward[iter_83_5.entityid] or 0) + var_83_8
					end
				end
			end

			local var_83_10 = {}

			table.insert(var_83_10, {
				dropid = arg_83_0.itemformat[1].origina_itemid,
				dropnum = arg_83_0.dropitem.dropNum,
				itemid = arg_83_0.item.itemid,
				entityid = arg_83_0.item.entityid,
				iteminfo = arg_83_0.item,
				formatinfo = arg_83_0.itemformat[1]
			})

			local var_83_11, var_83_12 = arg_82_0:checkTwistResultDownloadResources(var_83_10)

			if var_83_11 then
				arg_82_0:showTwistResourceDownloadLayer(var_83_12, function()
					arg_82_0:show_twist_result(arg_82_1, var_83_10, nil, blackcardcount, var_83_3)
				end)
			else
				arg_82_0:show_twist_result(arg_82_1, var_83_10, nil, blackcardcount, var_83_3)
			end

			arg_82_0:updateByBlackCard(arg_82_1)
			arg_82_0:updateTwistMain()
			arg_82_0.twistList:removeReddot(arg_82_0:checkIsHaveFreeTimes(arg_82_1))

			if arg_82_0.twistConfig[arg_82_1].stat == 3 then
				arg_82_0:updateNaiveTwist(arg_82_1, "one")
			elseif arg_82_0.twistConfig[arg_82_1].stat == 4 then
				arg_82_0:updateFiniteTwist(arg_82_1, "one")
			elseif arg_82_0.twistConfig[arg_82_1].is_limit_twist_pool then
				arg_82_0:updateLimitTwist(arg_82_1, "one", arg_83_0.unlocktwist)
			end
		elseif arg_83_0.result == 2 then
			arg_82_0:lackofcost(var_0_23, arg_82_1)
		elseif arg_83_0.result == 3 then
			global_ShowBlockWords(L_TWISTEGG_ITEMS_MSG[3])
		elseif arg_83_0.result == 4 then
			global_ShowBlockWords(L_TWISTEGG_ITEMS_MSG[4])
		elseif arg_83_0.result == 5 then
			global_ShowBlockWords(L_TWISTEGG_ITEMS_MSG[5])
		elseif arg_83_0.result == 6 then
			global_ShowBlockWords(L_TWISTEGG_ITEMS_MSG[6])
		end

		if arg_82_2 then
			arg_82_2()
		end

		arg_82_0.isAlowOtherTouch = true
	end)
end

function TwisteggLayer.twist_ten_result(arg_86_0, arg_86_1, arg_86_2)
	autopop_manager:pauseAchievementPop()

	arg_86_0.isAlowOtherTouch = false
	arg_86_0.pay_type = "ten"

	network:rpc("add_twistegg_items_for_ten", {
		twisttype = arg_86_1
	}, function(arg_87_0)
		if arg_87_0.result == 1 then
			arg_86_0.lastTwistBlackCard = arg_86_0.twistBlackCard

			LayerManager:showTopBottomLayer({
				TopcostLayer = false
			})
			arg_86_0:twistcost(var_0_24, arg_86_1, arg_87_0.twist_remain_count, arg_87_0.upcount, arg_87_0.guaranteeprob)
			arg_86_0:updateNoUpdropData(arg_87_0.no_dropup_stat, arg_87_0.totalCount, arg_87_0.no_updrop_count)

			arg_86_0.totalAward = arg_86_0.totalAward or {}
			arg_86_0.hero_items = {}

			for iter_87_0, iter_87_1 in pairs(arg_87_0.items) do
				if iter_87_1.itemtype == kITEM_HERO then
					table.insert(arg_86_0.hero_items, iter_87_1.itemid)

					if not playermodel.haveServant[item_data[iter_87_1.itemid].servant] then
						local var_87_0 = {
							servantid = item_data[iter_87_1.itemid].servant
						}

						var_87_0.rarity = servant_data[item_data[iter_87_1.itemid].servant].roll_rarity or 1

						AnalyticManager.gain_new_servant_by_twist(var_87_0)
					end
				end

				local var_87_1 = item_manager:setItemByServerItem(iter_87_1)

				if arg_87_0.itemformat[iter_87_0].origina_itemid ~= arg_87_0.itemformat[iter_87_0].final_itemid then
					arg_86_0.totalAward[iter_87_1.entityid] = (arg_86_0.totalAward[iter_87_1.entityid] or 0) + var_87_1
				elseif iter_87_1.entityid == 6800101 then
					arg_86_0.totalAward[iter_87_1.entityid] = (arg_86_0.totalAward[iter_87_1.entityid] or 0) + var_87_1
				end
			end

			if arg_87_0.cost_diamond then
				playermodel.diamond = playermodel.diamond - arg_87_0.cost_diamond
			end

			if arg_87_0.consumes and next(arg_87_0.consumes) then
				for iter_87_2, iter_87_3 in ipairs(arg_87_0.consumes) do
					item_manager:deleteItem(iter_87_3.entityid, iter_87_3.num)
				end
			end

			local var_87_4 = {}

			if arg_87_0.item_extra then
				for iter_87_4, iter_87_5 in pairs(arg_87_0.item_extra) do
					local var_87_5 = {}

					for iter_87_6, iter_87_7 in pairs(iter_87_5) do
						if iter_87_6 ~= "elementcard_info" then
							local var_87_6 = item_manager:setItemByServerItem(iter_87_7)
							local var_87_7 = {}
							local var_87_8 = {}

							if iter_87_6 == "servantcard" then
								var_87_7.itemid = iter_87_7.itemid
								var_87_7.itemcount = var_87_6
								var_87_5.servantcard = var_87_7
							end

							if iter_87_6 == "elementcard" then
								var_87_8.itemid = iter_87_7.itemid
								var_87_8.itemcount = iter_87_5.elementcard_info.num
								var_87_5.elementcard = var_87_8
							end

							arg_86_0.totalAward[iter_87_7.entityid] = not arg_86_0.totalAward[iter_87_7.entityid] and var_87_6 or var_87_6 + arg_86_0.totalAward[iter_87_7.entityid]
						end
					end

					table.insert(var_87_4, var_87_5)
				end
			end

			if arg_87_0.item_other then
				for iter_87_8, iter_87_9 in ipairs(arg_87_0.item_other) do
					local var_87_9 = item_manager:setItemByServerItem(iter_87_9)

					if var_87_9 > 0 then
						arg_86_0.totalAward[iter_87_9.entityid] = (arg_86_0.totalAward[iter_87_9.entityid] or 0) + var_87_9
					end
				end
			end

			if arg_87_0.icon then
				local var_87_11 = item_manager:setItemByServerItem(arg_87_0.icon)

				if var_87_11 ~= 0 then
					arg_86_0.totalAward[arg_87_0.icon.entityid] = var_87_11
				end
			end

			local var_87_12 = {}

			for iter_87_10, iter_87_11 in ipairs(arg_87_0.dropitems) do
				table.insert(var_87_12, {
					dropid = arg_87_0.itemformat[iter_87_10].origina_itemid,
					dropnum = iter_87_11.dropNum,
					itemid = arg_87_0.items[iter_87_10].itemid,
					entityid = arg_87_0.items[iter_87_10].entityid,
					iteminfo = arg_87_0.items[iter_87_10],
					formatinfo = arg_87_0.itemformat[iter_87_10]
				})
			end

			local var_87_14, var_87_15 = arg_86_0:checkTwistResultDownloadResources(var_87_12)

			if var_87_14 then
				arg_86_0:showTwistResourceDownloadLayer(var_87_15, function()
					arg_86_0:show_twist_result(arg_86_1, var_87_12, arg_87_0.icon, blackcardcount, var_87_4)
				end)
			else
				arg_86_0:show_twist_result(arg_86_1, var_87_12, arg_87_0.icon, blackcardcount, var_87_4)
			end

			arg_86_0:updateByBlackCard(arg_86_1)
			arg_86_0:updateTwistMain()
			arg_86_0.twistList:removeReddot(arg_86_0:checkIsHaveFreeTimes(arg_86_1))

			if arg_86_0.twistConfig[arg_86_1].stat == 3 then
				arg_86_0:updateNaiveTwist(arg_86_1, "ten")
			elseif arg_86_0.twistConfig[arg_86_1].stat == 4 then
				arg_86_0:updateFiniteTwist(arg_86_1, "ten")
			elseif arg_86_0.twistConfig[arg_86_1].is_limit_twist_pool then
				arg_86_0:updateLimitTwist(arg_86_1, "ten", arg_87_0.unlocktwist)
			end

			AnalyticManager.twistSuccess(arg_86_1, "ten")
		elseif arg_87_0.result == 2 then
			arg_86_0:lackofcost(var_0_24, arg_86_1)
		elseif arg_87_0.result == 3 then
			global_ShowBlockWords(L_TWISTEGG_ITEMS_MSG[3])
		elseif arg_87_0.result == 4 then
			global_ShowBlockWords(L_TWISTEGG_ITEMS_MSG[4])
		elseif arg_87_0.result == 5 then
			global_ShowBlockWords(L_TWISTEGG_ITEMS_MSG[5])
		elseif arg_87_0.result == 6 then
			global_ShowBlockWords(L_TWISTEGG_ITEMS_MSG[6])
		end

		if arg_86_2 then
			arg_86_2()
		end

		arg_86_0.isAlowOtherTouch = true

		if arg_87_0.result ~= 1 then
			arg_86_0.tenBtnOtherLock = false
		end
	end)
end

function TwisteggLayer.twist_any_result(arg_89_0, arg_89_1, arg_89_2, arg_89_3, arg_89_4)
	autopop_manager:pauseAchievementPop()

	arg_89_0.isAlowOtherTouch = false

	network:rpc("add_twistegg_items_for_any", {
		twisttype = arg_89_1,
		twistcount = arg_89_2
	}, function(arg_90_0)
		if arg_90_0.result == 1 then
			arg_89_0.lastTwistBlackCard = arg_89_0.twistBlackCard

			LayerManager:showTopBottomLayer({
				TopcostLayer = false
			})
			arg_89_0:twistcost(var_0_25, arg_89_1, arg_90_0.twist_remain_count, arg_90_0.upcount, arg_90_0.guaranteeprob, arg_89_2)

			arg_89_0.totalAward = arg_89_0.totalAward or {}

			local var_90_0 = {}

			if arg_90_0.item_extra then
				for iter_90_0, iter_90_1 in pairs(arg_90_0.item_extra) do
					local var_90_1 = {}

					for iter_90_2, iter_90_3 in pairs(iter_90_1) do
						if iter_90_2 ~= "elementcard_info" then
							local var_90_2 = item_manager:setItemByServerItem(iter_90_3)
							local var_90_3 = {}
							local var_90_4 = {}

							if iter_90_2 == "servantcard" then
								var_90_3.itemid = iter_90_3.itemid
								var_90_3.itemcount = var_90_2
								var_90_1.servantcard = var_90_3
							end

							if iter_90_2 == "elementcard" then
								var_90_4.itemid = iter_90_3.itemid
								var_90_4.itemcount = iter_90_1.elementcard_info.num
								var_90_1.elementcard = var_90_4
							end

							arg_89_0.totalAward[iter_90_3.entityid] = not arg_89_0.totalAward[iter_90_3.entityid] and var_90_2 or var_90_2 + arg_89_0.totalAward[iter_90_3.entityid]
						end
					end

					table.insert(var_90_0, var_90_1)
				end
			end

			if arg_90_0.icon then
				local var_90_5 = item_manager:setItemByServerItem(arg_90_0.icon)

				if var_90_5 ~= 0 then
					arg_89_0.totalAward[arg_90_0.icon.entityid] = var_90_5
				end
			end

			if arg_89_4 then
				LayerManager:showTopBottomLayer({
					TopcostLayer = true
				})
				autopop_manager:resumeAchievementPop()
				global_gain({
					items = arg_90_0.items
				})
			else
				local var_90_6 = {}

				for iter_90_4, iter_90_5 in ipairs(arg_90_0.dropitems) do
					table.insert(var_90_6, {
						dropid = arg_90_0.items[iter_90_4].itemid,
						dropnum = iter_90_5.dropNum,
						itemid = arg_90_0.items[iter_90_4].itemid,
						entityid = arg_90_0.items[iter_90_4].entityid,
						iteminfo = arg_90_0.items[iter_90_4]
					})
				end

				for iter_90_6, iter_90_7 in pairs(arg_90_0.items) do
					if iter_90_7.itemtype == kITEM_HERO then
						if not playermodel.haveServant[item_data[iter_90_7.itemid].servant] then
							local var_90_7 = {
								servantid = item_data[iter_90_7.itemid].servant
							}

							var_90_7.rarity = servant_data[item_data[iter_90_7.itemid].servant].roll_rarity or 1

							AnalyticManager.gain_new_servant_by_twist(var_90_7)
						end
					end

					item_manager:setItemByServerItem(iter_90_7)
				end

				arg_89_0:show_twist_result(arg_89_1, var_90_6, arg_90_0.icon, arg_90_0.blackcard, var_90_0)
			end

			arg_89_0:updateByBlackCard(arg_89_1)
			arg_89_0:updateTwistMain()
			arg_89_0.twistList:removeReddot(arg_89_0:checkIsHaveFreeTimes(arg_89_1))

			if arg_89_0.twistConfig[arg_89_1].stat == 3 then
				arg_89_0:updateNaiveTwist(arg_89_1, "ten")
			elseif arg_89_0.twistConfig[arg_89_1].stat == 4 then
				arg_89_0:updateFiniteTwist(arg_89_1, "ten")
			elseif arg_89_0.twistConfig[arg_89_1].is_limit_twist_pool then
				arg_89_0:updateLimitTwist(arg_89_1, "ten")
			end

			AnalyticManager.twistSuccess(arg_89_1, "ten")
		elseif arg_90_0.result == 0 or arg_90_0.result == 2 then
			arg_89_0:lackofcost(var_0_25, arg_89_1)
		elseif arg_90_0.result == 3 then
			global_ShowBlockWords(L_TWISTEGG_ITEMS_MSG[3])
		elseif arg_90_0.result == 4 then
			global_ShowBlockWords(L_TWISTEGG_ITEMS_MSG[4])
		elseif arg_90_0.result == 5 then
			global_ShowBlockWords(L_TWISTEGG_ITEMS_MSG[5])
		end

		if arg_89_3 then
			arg_89_3()
		end

		arg_89_0.isAlowOtherTouch = true

		if arg_90_0.result ~= 1 then
			arg_89_0.isCanChangeTwist = false
		end
	end)
end

function TwisteggLayer.twist_ten_result_for_naive(arg_91_0, arg_91_1, arg_91_2)
	autopop_manager:pauseAchievementPop()

	local var_91_0 = {}

	arg_91_0.isAlowOtherTouch = false

	network:rpc("add_twistegg_items_for_navie_ten", {
		twisttype = arg_91_1
	}, function(arg_93_0)
		if arg_93_0.result == 1 then
			arg_91_0.naiveTwistTime = arg_91_0.naiveTwistTime + 1
			arg_91_0.lastTwistBlackCard = arg_91_0.twistBlackCard

			LayerManager:showTopBottomLayer({
				TopcostLayer = false
			})

			arg_91_0.totalAward = arg_91_0.totalAward or {}

			local var_93_0 = {}

			if arg_93_0.item_extra then
				for iter_93_0, iter_93_1 in pairs(arg_93_0.item_extra) do
					local var_93_1 = {}

					for iter_93_2, iter_93_3 in pairs(iter_93_1) do
						if iter_93_2 ~= "elementcard_info" then
							local var_93_2 = item_manager:setItemByServerItem(iter_93_3)
							local var_93_3 = {}
							local var_93_4 = {}

							if iter_93_2 == "servantcard" then
								var_93_3.itemid = iter_93_3.itemid
								var_93_3.itemcount = var_93_2
								var_93_1.servantcard = var_93_3
							end

							if iter_93_2 == "elementcard" then
								var_93_4.itemid = iter_93_3.itemid
								var_93_4.itemcount = iter_93_1.elementcard_info.num
								var_93_1.elementcard = var_93_4
							end

							arg_91_0.totalAward[iter_93_3.entityid] = not arg_91_0.totalAward[iter_93_3.entityid] and var_93_2 or var_93_2 + arg_91_0.totalAward[iter_93_3.entityid]
						end
					end

					table.insert(var_93_0, var_93_1)
				end
			end

			if arg_93_0.icon then
				local var_93_5 = item_manager:setItemByServerItem(arg_93_0.icon)

				if var_93_5 ~= 0 then
					arg_91_0.totalAward[arg_93_0.icon.entityid] = var_93_5
				end
			end

			local var_93_6 = {}

			for iter_93_4, iter_93_5 in ipairs(arg_93_0.dropitems) do
				table.insert(var_93_6, {
					dropid = iter_93_5.dropid,
					dropnum = iter_93_5.dropNum,
					itemid = arg_93_0.items[iter_93_4].itemid,
					entityid = arg_93_0.items[iter_93_4].entityid,
					iteminfo = arg_93_0.items[iter_93_4]
				})
			end

			arg_91_0:show_twist_result(arg_91_1, var_93_6, arg_93_0.icon, blackcardcount, var_93_0)
			AnalyticManager.twistSuccess(arg_91_1, "ten")
		elseif arg_93_0.result == 2 then
			arg_91_0:lackofcost(var_0_24, arg_91_1)
		elseif arg_93_0.result == 3 then
			global_ShowBlockWords(L_TWISTEGG_ITEMS_MSG[3])
		elseif arg_93_0.result == 4 then
			global_ShowBlockWords(L_TWISTEGG_ITEMS_MSG[4])
		elseif arg_93_0.result == 5 then
			global_ShowBlockWords(L_TWISTEGG_ITEMS_MSG[5])
		end

		if arg_91_2 then
			arg_91_2()
		end

		arg_91_0.isAlowOtherTouch = true

		if arg_93_0.result ~= 1 then
			arg_91_0.tenBtnOtherLock = false
		end
	end)
end

function TwisteggLayer.sureNaiveTwistResult(arg_94_0, arg_94_1, arg_94_2)
	network:rpc("gain_navie_twist_cache_items", {
		twisttype = arg_94_1
	}, function(arg_95_0)
		print(dump(arg_95_0))

		if arg_95_0.result == 1 then
			arg_94_0:twistcost(var_0_24, arg_94_1, arg_95_0.twist_remain_count, arg_95_0.consumes, arg_95_0.cost_diamond, arg_95_0.upcount)

			for iter_95_0, iter_95_1 in pairs(arg_95_0.items) do
				if iter_95_1.itemtype == kITEM_HERO then
					if not playermodel.haveServant[item_data[iter_95_1.itemid].servant] then
						local var_95_0 = {
							servantid = item_data[iter_95_1.itemid].servant
						}

						var_95_0.rarity = servant_data[item_data[iter_95_1.itemid].servant].roll_rarity or 1

						AnalyticManager.gain_new_servant_by_twist(var_95_0)
					end
				end

				item_manager:setItemByServerItem(iter_95_1)
			end

			if arg_95_0.icon then
				for iter_95_2, iter_95_3 in pairs(arg_95_0.icon) do
					local var_95_1 = item_manager:setItemByServerItem(iter_95_3)
				end
			end

			arg_94_0:updateByBlackCard(arg_94_1)
			arg_94_0:updateNaiveTwist(arg_94_1, "ten")

			if arg_94_2 then
				arg_94_2()
			end
		elseif arg_95_0.result == 2 then
			cclog("扭蛋类型不是新手扭蛋")
		elseif arg_95_0.result == 3 then
			cclog("扭蛋缓存数据不存在")
		end
	end)
end

function TwisteggLayer.onGetNewHead(arg_96_0, arg_96_1, arg_96_2)
	local var_96_0 = ccui.Layout:create()

	var_96_0:setContentSize(cc.size(640, GameDisplay.height))
	var_96_0:setTouchEnabled(true)
	var_96_0:setBackGroundImage("mainScenebg/head_get_bg.jpg")
	global_basic_scene:addChild(var_96_0, 999)
	var_96_0:runAction(cc.Sequence:create(cc.DelayTime:create(3), cc.RemoveSelf:create()))

	local var_96_1

	if config._DEBUG then
		var_96_1 = cc.Sprite:create("TwistEgg/xiao.png") or cc.Sprite:createWithSpriteFrameName("TwistEgg/xiao.png")
	end

	var_96_1:setPosition(cc.p(320, GameDisplay.height / 2))
	var_96_1:setScale(0.1)
	var_96_0:addChild(var_96_1)

	local var_96_2

	if config._DEBUG then
		var_96_2 = cc.Sprite:create("TwistEgg/zhong.png") or cc.Sprite:createWithSpriteFrameName("TwistEgg/zhong.png")
	end

	var_96_2:setPosition(cc.p(320, GameDisplay.height / 2))
	var_96_2:setScale(0.1)
	var_96_0:addChild(var_96_2, 5)

	local var_96_3

	if config._DEBUG then
		var_96_3 = cc.Sprite:create("TwistEgg/da.png") or cc.Sprite:createWithSpriteFrameName("TwistEgg/da.png")
	end

	var_96_3:setPosition(cc.p(320, GameDisplay.height / 2))
	var_96_3:setScale(0.1)
	var_96_0:addChild(var_96_3, 5)
	cc.SpriteFrameCache:getInstance():addSpriteFrames("effect/compose.plist")

	local var_96_4 = cc.Sprite:createWithSpriteFrameName("compose_1.png")

	var_96_4:setAnchorPoint(cc.p(0.5, 0.5))
	var_96_4:setPosition(cc.p(320, GameDisplay.height / 2))
	var_96_4:setVisible(false)
	var_96_0:addChild(var_96_4, 4)

	local var_96_5

	if config._DEBUG then
		var_96_5 = cc.Sprite:create("TwistEgg/kuang.png") or cc.Sprite:createWithSpriteFrameName("TwistEgg/kuang.png")
	end

	var_96_5:setPosition(cc.p(320, GameDisplay.height / 2))
	var_96_5:setVisible(false)
	var_96_0:addChild(var_96_5, 2)

	local var_96_6

	if config._DEBUG then
		var_96_6 = cc.Sprite:create("public/rolebg/icon_bg.png") or cc.Sprite:createWithSpriteFrameName("public/rolebg/icon_bg.png")
	end

	local var_96_7 = cc.Sprite:create("role/wuji/" .. item_data[arg_96_1].image_id .. ".png")

	var_96_7:setPosition(cc.p(var_96_6:getContentSize().width / 2, var_96_6:getContentSize().height / 2))
	var_96_6:addChild(var_96_7)
	var_96_6:setPosition(cc.p(320, GameDisplay.height / 2))
	var_96_6:setVisible(false)
	var_96_0:addChild(var_96_6, 300)
	var_96_1:runAction(cc.ScaleTo:create(0.2, 1))
	var_96_2:runAction(cc.ScaleTo:create(0.2, 1))
	var_96_3:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1), cc.CallFunc:create(function()
		var_96_3:runAction(cc.RepeatForever:create(cc.RotateBy:create(3, 360)))
		var_96_2:runAction(cc.RepeatForever:create(cc.RotateBy:create(3, -360)))
		var_96_1:runAction(cc.RepeatForever:create(cc.RotateBy:create(3, 360)))

		local var_97_0 = cc.Animation:create()

		for iter_97_0 = 1, 12 do
			var_97_0:addSpriteFrame((cc.SpriteFrameCache:getInstance():getSpriteFrame("compose_" .. iter_97_0 .. ".png")))
		end

		var_97_0:setDelayPerUnit(0.1)
		var_96_4:setVisible(true)
		var_96_4:runAction(cc.Sequence:create(cc.Animate:create(var_97_0), cc.Hide:create(), cc.CallFunc:create(function()
			local var_98_0 = cc.Label:createWithTTF(item_data[arg_96_1].name, FONT_NAME, 40)

			var_98_0:setAnchorPoint(cc.p(0, 0.5))
			var_98_0:setPosition(cc.p(320 - var_98_0:getContentSize().width / 2, 450 + GameDisplay.fix_y))
			var_96_0:addChild(var_98_0)
			var_96_0:addTouchEventListener(function(arg_99_0, arg_99_1)
				if arg_99_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_96_2 then
					arg_96_2()
				end

				var_96_0:runAction(cc.RemoveSelf:create())
			end)
		end)))

		local var_97_1 = cc.OrbitCamera:create(0.8, 180, 0, -180, 180, 0, 0)

		var_96_5:setVisible(true)
		var_96_5:runAction(cc.Spawn:create(var_97_1:clone(), cc.Sequence:create(cc.DelayTime:create(0.4), cc.Hide:create())))
		var_96_6:runAction(cc.Spawn:create(var_97_1:clone(), cc.Sequence:create(cc.DelayTime:create(0.4), cc.Show:create())))
	end)))
end

function TwisteggLayer.set_create_normal_item_icon_func(arg_100_0, arg_100_1)
	var_0_69 = arg_100_1

	setmetatable(var_0_68, {
		__index = var_0_69,
		__call = function(self, arg_101_1, ...)
			return self[arg_101_1](...)
		end
	})
end

function TwisteggLayer.checkTwistResultDownloadResources(arg_102_0, arg_102_1)
	local file_check_manager = require("controller.filedownloader.file_check_manager")
	local var_102_1 = {}

	for iter_102_0, iter_102_1 in ipairs(arg_102_1) do
		if item_data[iter_102_1.dropid].bag_item_type == kITEM_HERO then
			if file_check_manager:checkFileNeedDownload(ROLE_IMAGE_PATH .. model_data[servant_data[item_data[iter_102_1.dropid].servant].modelid].role_image .. ".png") then
				table.insert(var_102_1, file_check_manager:getFileDownloadInfo(ROLE_IMAGE_PATH .. model_data[servant_data[item_data[iter_102_1.dropid].servant].modelid].role_image .. ".png"))
			end

			if file_check_manager:checkFileNeedDownload("role/shop_image/" .. model_data[servant_data[item_data[iter_102_1.dropid].servant].modelid].role_image .. ".png") then
				table.insert(var_102_1, file_check_manager:getFileDownloadInfo("role/shop_image/" .. model_data[servant_data[item_data[iter_102_1.dropid].servant].modelid].role_image .. ".png"))
			end
		elseif item_data[iter_102_1.dropid].bag_item_type == kITEM_SKIN then
			if file_check_manager:checkFileNeedDownload("equipment/" .. item_data[iter_102_1.dropid].image_id .. ".png") then
				table.insert(var_102_1, file_check_manager:getFileDownloadInfo("equipment/" .. item_data[iter_102_1.dropid].image_id .. ".png"))
			end

			local var_102_2 = item_data[iter_102_1.dropid].model

			if global_canshow_live2d(item_data[iter_102_1.dropid].model) then
				local var_102_3, var_102_4 = file_check_manager:checkL2DFile(model_data[var_102_2].live2d)

				if var_102_3 then
					table.insertto(var_102_1, var_102_4)
				end
			elseif model_data[var_102_2].rolespine then
				local var_102_5, var_102_6 = file_check_manager:checkSpineFile(ROLE_SPINE_PATH .. model_data[var_102_2].rolespine .. ".json")

				if var_102_5 then
					table.insertto(var_102_1, var_102_6)
				end
			elseif file_check_manager:checkFileNeedDownload(ROLE_IMAGE_PATH .. model_data[var_102_2].role_image .. ".png") then
				table.insert(var_102_1, file_check_manager:getFileDownloadInfo(ROLE_IMAGE_PATH .. model_data[var_102_2].role_image .. ".png"))
			end
		elseif item_data[iter_102_1.dropid].bag_item_type == kITEM_HORCRUX then
			local var_102_7 = "role1/" .. horcrux_manager:getHorcruxRoleImage(iter_102_1.dropid) .. ".png"

			if file_check_manager:checkFileNeedDownload(var_102_7) then
				table.insert(var_102_1, file_check_manager:getFileDownloadInfo(var_102_7))
			end
		elseif item_data[iter_102_1.dropid].bag_item_type == kITEM_DRAWING then
			if file_check_manager:checkFileNeedDownload("equipment/draw.png") then
				table.insert(var_102_1, file_check_manager:getFileDownloadInfo("equipment/draw.png"))
			end

			if file_check_manager:checkFileNeedDownload("equipment/" .. item_data[iter_102_1.dropid].image_id .. ".png") then
				table.insert(var_102_1, file_check_manager:getFileDownloadInfo("equipment/" .. item_data[iter_102_1.dropid].image_id .. ".png"))
			end
		elseif item_data[iter_102_1.dropid].bag_item_type == kITEM_HORCRUX_DRAWING then
			if file_check_manager:checkFileNeedDownload("equipment/draw.png") then
				table.insert(var_102_1, file_check_manager:getFileDownloadInfo("equipment/draw.png"))
			end

			if file_check_manager:checkFileNeedDownload("equipment/" .. item_data[iter_102_1.dropid].image_id .. ".png") then
				table.insert(var_102_1, file_check_manager:getFileDownloadInfo("equipment/" .. item_data[iter_102_1.dropid].image_id .. ".png"))
			end
		elseif file_check_manager:checkFileNeedDownload("equipment/" .. item_data[iter_102_1.dropid].image_id .. ".png") then
			table.insert(var_102_1, file_check_manager:getFileDownloadInfo("equipment/" .. item_data[iter_102_1.dropid].image_id .. ".png"))
		end
	end

	if #var_102_1 > 0 then
		return true, file_check_manager:mergeDownloadList(var_102_1)
	else
		return false
	end
end

function TwisteggLayer:showTwistResourceDownloadLayer(arg_103_1, arg_103_2)
	if self:getChildByName("downloadlayer") then
		self:getChildByName("downloadlayer"):runAction(cc.RemoveSelf:create())
	end

	local var_103_0 = ccui.Layout:create()

	var_103_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_103_0:setTouchEnabled(true)
	var_103_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_103_0:setName("downloadlayer")
	self:addChild(var_103_0, 10000)

	local var_103_1 = cc.Sprite:create("loading/twwistdownloadbg.png")

	var_103_1:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	var_103_0:addChild(var_103_1)

	local var_103_2 = cc.Sprite:create("loading/downloadbarbg.png")

	var_103_2:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy - 250))
	var_103_0:addChild(var_103_2, 1)

	local var_103_3 = cc.ProgressTimer:create(cc.Sprite:create("loading/downloadbar.png"))

	var_103_3:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	var_103_3:setBarChangeRate(cc.p(1, 0))
	var_103_3:setMidpoint(cc.p(0, 0))
	var_103_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_103_3:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy - 250))
	var_103_3:setName("bar")
	var_103_3:setPercentage(5)
	var_103_0:addChild(var_103_3, 2)

	local var_103_4 = cc.Sprite:create("loading/downloadword.png")

	var_103_4:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy - 200))
	var_103_0:addChild(var_103_4, 3)

	var_103_0._downloadinglist = {}

	local var_103_5 = 0
	local var_103_6 = 0

	var_103_1:setVisible(false)
	var_103_2:setVisible(false)
	var_103_3:setVisible(false)
	var_103_4:setVisible(false)
	var_103_0:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("DOWNLOAD_EVENT_COMPLETE", function(arg_104_0)
		if var_103_0._downloadinglist[arg_104_0.fileName] then
			var_103_0._downloadinglist[arg_104_0.fileName] = nil
			var_103_6 = var_103_6 + 1

			if next(var_103_0._downloadinglist) then
				var_103_0:getChildByName("bar"):setPercentage((math.min(100, var_103_6 / var_103_5 * 100)))
			else
				var_103_0:runAction(cc.Sequence:create(cc.CallFunc:create(arg_103_2), cc.RemoveSelf:create()))
			end
		end
	end), var_103_0)

	for iter_103_0, iter_103_1 in ipairs(arg_103_1) do
		var_103_0._downloadinglist[iter_103_1.filename] = true
		var_103_5 = var_103_5 + 1
	end

	require("controller.filedownloader.download_manager"):insertDownloadTasks(arg_103_1)
end
