PopServantUpgradeLayer = class("PopServantUpgradeLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local L2Actor = require("view.Sprite.L2Actor")
local playermodel = require("model.playermodel")
local audio_manager = require("controller.audio_manager")
local autopop_manager = require("controller.autopop_manager")
local armature_manager = require("controller.armature_manager")
local core_manager = require("controller.core_manager")
local item_manager = require("controller.item_manager")
local souls_manager = require("controller.souls_manager")
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local total_skill_data = require("data.total_skill_data")
local major_factor_data = require("data.major_factor_data")
local favorfile_data = require("data.favorfile_data")
local l2utils = require("controller.l2utils")
local servant_advance_data = require("data.servant.servant_advance_data")
local var_0_17
local var_0_18 = "role/"
local var_0_19 = {
	x = 148,
	y = 148
}
local var_0_20 = {
	{
		x = var_0_19.x - 1,
		y = var_0_19.y + 1
	},
	{
		x = -15 + var_0_19.x,
		y = 14 + var_0_19.y
	},
	{
		x = -15 + var_0_19.x,
		y = -33 + var_0_19.y
	},
	{
		x = 28 + var_0_19.x,
		y = -4 + var_0_19.y
	},
	{
		x = var_0_19.x - 1,
		y = var_0_19.y - 8
	}
}
local var_0_21 = {}
local var_0_22 = 1
local var_0_23 = 2

function PopServantUpgradeLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopServantUpgradeLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopServantUpgradeLayer:init(arg_3_1)
	var_0_17 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopServantUpgradeLayer.json" or "PopServantUpgradeLayer.ExportJson")

	self:addChild(self.rootLayer, 2)

	self.rootpanel = self.rootLayer
	self.layout = ccui.Layout:create()

	self.layout:setContentSize(cc.size(640, GameDisplay.height))
	self.layout:setAnchorPoint(cc.p(0.5, 0.5))
	self.layout:setBackGroundImage(DATABASEBG)
	self.layout:setPosition(cc.p(320, GameDisplay.height / 2 - GameDisplay.fix_y))
	self:addChild(self.layout)

	self.mask = ccui.Layout:create()

	self.mask:setContentSize(cc.size(640, GameDisplay.height))
	self.mask:setAnchorPoint(cc.p(0.5, 0.5))
	self.mask:setBackGroundImage("mainScenebg/blur_mask.png")
	self.mask:setPosition(cc.p(320, GameDisplay.height / 2 - GameDisplay.fix_y))
	self:addChild(self.mask)

	self.panel = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_back")
	self.panel_jinjie = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_upgrade")
	self.surebutton = ccui.Helper:seekWidgetByName(self.rootLayer, "button_sure")
	self.upgradecost_bg = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_cost")
	self.panel_grade = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_grade")
	self.materialbg = ccui.Helper:seekWidgetByName(self.upgradecost_bg, "equip_4")
	self.ExitButton = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_25")
	self.label_intro = ccui.Helper:seekWidgetByName(self.rootLayer, "label_intro")
	self.panel_intro = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_intro")
	self.image_Role = ccui.Helper:seekWidgetByName(self.rootLayer, "image_Role")
	self.image_shadow = ccui.Helper:seekWidgetByName(self.rootLayer, "image_shadow")
	self.partBottom = ccui.Helper:seekWidgetByName(self.rootLayer, "upgrade_bg")
	self.ocDetailPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_oc_detail")

	self.panel:setAnchorPoint(cc.p(0.5, 0.5))
	self.panel:setPosition(cc.p(320, 568))
	self.panel_intro:getChildByName("value_new"):setVisible(false)
	self.panel_intro:getChildByName("value_old"):setVisible(false)
	self.panel_intro:getChildByName("Image_Arrow"):setVisible(false)
	self.label_intro:setVisible(false)
	self:ActionofAccess(self.panel)
	self.panel_jinjie:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		local function var_4_0()
			if arg_3_1.cancelcallback then
				arg_3_1.cancelcallback()
			end

			LayerManager:removePopLayer(self.__queueindex)
		end

		self.panel:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
			if var_4_0 then
				var_4_0()
			end
		end)))
	end)
	self:initData(arg_3_1)
	self:updateData(arg_3_1)
	self:initSwitchBtn()
	self:setAttr()
	self:setGirl()
	self:setNowGrade()
	self:setSureButton(arg_3_1)
	self:fullScreen(self.rootLayer)
	self:registerOnGetNewMaterial()
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			var_0_17 = nil
		end
	end)
end

function PopServantUpgradeLayer:initData(arg_8_1)
	self.curSoul = arg_8_1.curSoul
	self.goto_back_system_id = arg_8_1.goto_back_system_id
	self.cancelcallback = arg_8_1.cancelcallback
	self.surecallback = arg_8_1.surecallback

	self:updateShowType(arg_8_1.showtype)
end

function PopServantUpgradeLayer:updateShowType(arg_9_1)
	self.isAdvance = false
	self.isOC = false

	if arg_9_1 then
		self.showtype = arg_9_1

		return
	end

	local var_9_1 = souls_manager:get_total_contract(self.curSoul)

	if not playermodel.soulOverClock[self.curSoul] then
		-- block empty
	end

	self.showtype = souls_manager:check_is_can_upgrade(self.curSoul) and var_0_22 or souls_manager:check_is_can_OC(self.curSoul) and var_0_23 or souls_manager:check_is_can_avance(self.curSoul) and var_0_22 or var_0_22
end

function PopServantUpgradeLayer:updateData()
	self.msg = {}
	self.soulContract = playermodel.soulContract[self.curSoul]
	self.totalContract = souls_manager:get_total_contract(self.curSoul)
	self.addRollRarity = playermodel.addRollRarity[self.curSoul]
	self.overclock = playermodel.soulOverClock[self.curSoul] or 0

	local var_10_0 = model_data[servant_data[self.curSoul].modelid].hpFactor + (servant_data[self.curSoul]["hpOverPlus" .. self.overclock] or 0)
	local var_10_1 = model_data[servant_data[self.curSoul].modelid].damageFactor + (servant_data[self.curSoul]["damageOverPlus" .. self.overclock] or 0) + souls_manager:get_add_damage_factor(self.curSoul)
	local var_10_2 = model_data[servant_data[self.curSoul].modelid].damageFactor + (servant_data[self.curSoul]["damageOverPlus" .. self.overclock] or 0)
	local var_10_3 = var_10_0 + souls_manager:get_add_hp_factor(self.curSoul)
	local var_10_4 = var_10_0
	local var_10_6 = souls_manager:get_roll_rarity_str(self.curSoul)
	local Utility = require("common.Utility")
	local var_10_8 = souls_manager:get_total_contract_attr()
	local var_10_9 = var_10_8 + souls_manager:get_contract_attr_add(self.curSoul, self.showtype)

	if self.showtype == var_0_22 then
		if self.soulContract >= 5 then
			var_10_4 = L_SOULS_BREAK_LIMIT.Level_Max
			var_10_2 = L_SOULS_BREAK_LIMIT.Level_Max
		else
			var_10_2 = var_10_2 + (servant_data[self.curSoul]["damageFactorPlus" .. self.soulContract + 1 .. var_10_6] or 0)
			var_10_4 = var_10_4 + (servant_data[self.curSoul]["hpFactorPlus" .. self.soulContract + 1 .. var_10_6] or 0)
		end
	elseif self.showtype == var_0_23 then
		if self.overclock > 0 then
			var_10_4 = L_SOULS_BREAK_LIMIT.Level_Max
			var_10_2 = L_SOULS_BREAK_LIMIT.Level_Max
		else
			var_10_2 = var_10_2 + souls_manager:get_add_damage_factor(self.curSoul) + ((not servant_data[self.curSoul]["damageOverPlus" .. self.overclock + 1] or nil) and 0)
			var_10_4 = var_10_4 + souls_manager:get_add_hp_factor(self.curSoul) + (servant_data[self.curSoul]["hpOverPlus" .. self.overclock + 1] or 0)
		end
	end

	self.curRaity = souls_manager:get_servant_cur_roll_rarity(self.curSoul)
	self.curContract = playermodel.soulContract[self.curSoul]
	self.nextRaity = self.curRaity + 1
	self.nextContract = 0

	local var_10_12 = {
		var_10_3,
		var_10_4
	}
	local var_10_13 = {
		var_10_1,
		var_10_2
	}
	local var_10_14 = {
		var_10_8,
		var_10_9
	}
	local var_10_15 = {
		core_manager:getStrengthenValue(self.curSoul, playermodel.cores[self.curSoul].coreid, core_manager:getCoreLv(self.curSoul)),
		(core_manager:getNextOcPointAdd(self.curSoul, playermodel.cores[self.curSoul].coreid, core_manager:getCoreLv(self.curSoul)))
	}

	self.msg = {
		showIntro = true,
		labels = {
			{
				newvalue = var_10_13,
				name = L_SOULS_BREAK_LIMIT.Aptitude[2] .. "：",
				isHide = var_10_13[1] == 0 and text[2] == 0
			},
			{
				newvalue = var_10_12,
				name = L_SOULS_BREAK_LIMIT.Aptitude[1] .. "：",
				isHide = var_10_12[1] == 0 and var_10_12[2] == 0
			},
			{
				newvalue = var_10_14,
				name = L_SOULS_BREAK_LIMIT.Science .. "：",
				isHide = var_10_14[1] == 0 and var_10_14[2] == 0
			},
			{
				newvalue = var_10_15,
				name = L_SOULS_BREAK_LIMIT.Point .. "：",
				isHide = var_10_15[1] == 0 and var_10_15[2] == 0
			}
		},
		materials = {}
	}
	self.msg.goto_back_system_id = self.goto_back_system_id

	local var_10_16 = core_manager:getUpgradeCostRoleCardNum(self.curSoul, self.soulContract + 1) or 0

	if var_10_16 > 0 then
		self.msg.materials[#self.msg.materials + 1] = {}
		self.msg.materials[#self.msg.materials].ownnum = playermodel.servantNum[self.curSoul]
		self.msg.materials[#self.msg.materials].neednum = var_10_16
		self.msg.materials[#self.msg.materials].id = servant_data[self.curSoul].itemid
	end

	self.msg.bntstr = L_BUTTON_TEXT.Up_Grade
	self.msg.curSoul = self.curSoul

	function self.msg:surecallback()
		if not var_0_17 then
			return
		end

		if self.showtype == var_0_22 and not self.isAdvance then
			self:showUpGradeAni(self)
		elseif self.showtype == var_0_22 and self.isAdvance and self.result == 1 then
			self:showAdvanceAni()
		end

		if self.surecallback then
			self.surecallback()
		end

		self:updateShowType()
		self:updatePanel()
	end

	if self.showtype == var_0_22 then
		self:updateAdvanceData()
	elseif self.showtype == var_0_23 then
		self:updateocData()
	end
end

function PopServantUpgradeLayer:updateocData()
	if not servant_data[self.curSoul]["oc_isopen" .. self.overclock + 1] then
		self.isOC = false

		return
	end

	if self.totalContract < 5 then
		self.isOC = false

		return
	end

	if playermodel:isServantOverclockLockByTime(self.curSoul) then
		self.isOC = false

		return
	end

	self.isOC = true

	local var_12_0 = core_manager:getOcCostCardNum(self.curSoul, self.overclock + 1) or 0
	local var_12_1 = core_manager:getOcCpuId(self.curSoul, self.overclock + 1)

	self.msg.materials = {}

	if var_12_0 > 0 then
		self.msg.materials[#self.msg.materials + 1] = {}
		self.msg.materials[#self.msg.materials].ownnum = playermodel.servantNum[self.curSoul]
		self.msg.materials[#self.msg.materials].neednum = var_12_0
		self.msg.materials[#self.msg.materials].id = servant_data[self.curSoul].itemid
	end

	if var_12_1 then
		self.msg.materials[#self.msg.materials + 1] = {}
		self.msg.materials[#self.msg.materials].ownnum = item_manager:getItemNumber(var_12_1)
		self.msg.materials[#self.msg.materials].neednum = core_manager:getOcCostCpuNum(self.curSoul, self.overclock + 1) or 0
		self.msg.materials[#self.msg.materials].id = var_12_1
	end

	self.msg.bntstr = L_BUTTON_TEXT.OC
end

function PopServantUpgradeLayer:updateAdvanceData()
	if not souls_manager:is_can_advance(self.curSoul) then
		self.isAdvance = false

		return
	end

	if self.soulContract < 5 then
		self.isAdvance = false

		return
	end

	self.isAdvance = true

	local var_13_0 = souls_manager:get_servant_cur_roll_rarity(self.curSoul) + 1

	self.msg.materials = {}

	while servant_advance_data[self.curSoul]["advance" .. var_13_0 .. "_cost_itemid" .. 1] do
		table.insert(self.msg.materials, {
			id = servant_advance_data[self.curSoul]["advance" .. var_13_0 .. "_cost_itemid" .. 1],
			neednum = servant_advance_data[self.curSoul]["advance" .. var_13_0 .. "_cost_itemnum" .. 1],
			ownnum = item_manager:getItemNumber(servant_advance_data[self.curSoul]["advance" .. var_13_0 .. "_cost_itemid" .. 1])
		})
	end

	self.msg.bntstr = L_BUTTON_TEXT.Advance
end

function PopServantUpgradeLayer:initSwitchBtn()
	self.swtichBtn = ccui.Button:create("PopServantUpgradeLayer/switch_oc.png", nil, "PopServantUpgradeLayer/switch_oc.png", var_0_0)

	self.swtichBtn:setPosition(560, 100)
	self.surebutton:getParent():addChild(self.swtichBtn, 1000)
	self:updateSwithBtn()
	self.swtichBtn:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.showtype == var_0_22 then
			self:updateShowType(var_0_23)
		elseif self.showtype == var_0_23 then
			self:updateShowType(var_0_22)
		end

		self:updatePanel()
	end)
end

function PopServantUpgradeLayer:updateSwithBtn()
	local var_16_0

	if not souls_manager:check_is_can_avance(self.curSoul) then
		var_16_0 = souls_manager:check_is_can_upgrade(self.curSoul)

		if var_16_0 then
			var_16_0 = souls_manager:check_is_can_OC(self.curSoul)
		end
	end

	self.swtichBtn:setVisible(var_16_0)

	if self.showtype == var_0_23 then
		if souls_manager:check_is_can_avance(self.curSoul) then
			self.swtichBtn:loadTextures("PopServantUpgradeLayer/switch_advance.png", nil, "PopServantUpgradeLayer/switch_advance.png", var_0_0)
		else
			self.swtichBtn:loadTextures("PopServantUpgradeLayer/switch_upgrade.png", nil, "PopServantUpgradeLayer/switch_upgrade.png", var_0_0)
		end
	elseif self.showtype == var_0_22 then
		self.swtichBtn:loadTextures("PopServantUpgradeLayer/switch_oc.png", nil, "PopServantUpgradeLayer/switch_oc.png", var_0_0)
	end
end

function PopServantUpgradeLayer:setAttr()
	if souls_manager:check_is_can_avance(self.curSoul) or souls_manager:check_is_can_upgrade(self.curSoul) or souls_manager:check_is_can_OC(self.curSoul) then
		local var_17_0, var_17_1 = self.label_intro:getPosition()
		local var_17_2 = var_17_0 - 25

		var_17_1 = #self.msg.labels >= 4 and var_17_1 + 40 or var_17_1

		local var_17_3 = 40
		local var_17_4 = ccui.Helper:seekWidgetByName(self.panel_grade, "grade_old")
		local var_17_5 = ccui.Helper:seekWidgetByName(self.panel_grade, "grade_new")

		var_17_4:setAnchorPoint(cc.p(0.5, 0.5))
		var_17_4:setPosition(cc.p(5, 10))

		if self.soulContract == 0 then
			var_17_4:setString(string.format(""))
		else
			var_17_4:setString(string.format(L_SOULS_GRADE, self.soulContract))
		end

		var_17_5:setVisible(false)
		ccui.Helper:seekWidgetByName(self.panel_grade, "grade_arrow"):setVisible(false)

		if self.msg.labels then
			for iter_17_0, iter_17_1 in ipairs(self.msg.labels) do
				local var_17_6 = self.label_intro:clone()
				local var_17_7 = self.panel_intro:getChildByName("value_new")
				local var_17_8 = var_17_7:clone()
				local var_17_9 = self.panel_intro:getChildByName("value_old").clone(var_17_7)
				local var_17_10 = self.panel_intro:getChildByName("Image_Arrow"):clone()

				var_17_10:loadTexture("public/panelbg/strengen_arrow.png", var_0_0)

				local var_17_11 = iter_17_0 == 3

				if iter_17_0 == 3 and servant_data[self.curSoul] and servant_data[self.curSoul].linkage and servant_data[self.curSoul].linkage == 1 then
					break
				end

				local var_17_12 = var_17_11 and "+" or ""

				var_17_8:setVisible(not iter_17_1.isHide)
				var_17_9:setVisible(not iter_17_1.isHide)
				var_17_10:setVisible(not iter_17_1.isHide)
				var_17_6:setVisible(not iter_17_1.isHide)
				var_17_6:setPosition(cc.p(var_17_2, var_17_1 - var_17_3 * (iter_17_0 - 1)))
				var_17_6:setName("strlabel_" .. iter_17_0)
				self.panel_intro:addChild(var_17_6)
				var_17_6:setString(iter_17_1.name)
				var_17_8:setString(var_17_12 .. iter_17_1.newvalue[2])
				var_17_8:setPositionX(var_17_6:getPositionX() + 130)
				var_17_8:setPositionY(var_17_6:getPositionY())
				var_17_8:setName("value_new_" .. iter_17_0)
				var_17_9:setString(var_17_12 .. iter_17_1.newvalue[1])
				var_17_9:setPositionX(var_17_6:getPositionX() + 5)
				var_17_9:setPositionY(var_17_6:getPositionY())
				var_17_9:setName("value_old_" .. iter_17_0)
				var_17_10:setAnchorPoint(cc.p(0.5, 0.5))
				var_17_10:setPosition(cc.p(var_17_6:getPositionX() + 90, var_17_6:getPositionY()))
				var_17_10:setName("Image_Arrow_" .. iter_17_0)
				self.panel_intro:addChild(var_17_8)
				self.panel_intro:addChild(var_17_9)
				self.panel_intro:addChild(var_17_10)

				if self.isOC then
					var_17_10:loadTexture("public/panelbg/strengen_arrow2.png", var_0_0)
				end
			end
		end

		if souls_manager:check_is_can_avance(self.curSoul) then
			self:updateAttrHide()
		end

		local var_17_13

		if self.soulContract < 3 and model_data[servant_data[self.curSoul].modelid].upgrade_skill_3 then
			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_upgrade"):loadTexture("PopServantUpgradeLayer/up_grade3_skill.png", var_0_0)

			var_17_13 = model_data[servant_data[self.curSoul].modelid].upgrade_skill_3

			ccui.Helper:seekWidgetByName(self.rootLayer, "LabelUpgrade"):setString(string.format(L_SOULS_BREAK_LIMIT.NeedContent, L_NUMBER_TEXT[3]))
		elseif self.soulContract < 5 and model_data[servant_data[self.curSoul].modelid].upgrade_skill_5 then
			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_upgrade"):loadTexture("PopServantUpgradeLayer/up_grade5_skill.png", var_0_0)

			var_17_13 = model_data[servant_data[self.curSoul].modelid].upgrade_skill_5

			ccui.Helper:seekWidgetByName(self.rootLayer, "LabelUpgrade"):setString(string.format(L_SOULS_BREAK_LIMIT.NeedContent, L_NUMBER_TEXT[5]))
		end

		if var_17_13 then
			ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_upgradeskill"):setVisible(true)

			if ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_upgradeskill"):getChildByName("richText") then
				ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_upgradeskill"):getChildByName("richText"):removeFromParent()
			end

			local var_17_14 = RichTextPro:create()

			var_17_14:setMaxWidth(300)
			var_17_14:setSize(24)
			var_17_14:setPosition(cc.p(20, 50))
			var_17_14:setColor(cc.c3b(220, 251, 241))
			var_17_14:setLineSpace(0)
			var_17_14:setName("richText")
			ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_upgradeskill"):addChild(var_17_14)
			ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_upgradeskill"):getChildByName("richText"):setText((transSkillDesToRichText(total_skill_data[var_17_13].description)))
		else
			ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_upgradeskill"):setVisible(false)
		end

		if self.isOC then
			ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_upgradeskill"):setVisible(false)
		end
	else
		self:setMaxAttr()
	end
end

function PopServantUpgradeLayer:setMaxAttr()
	local var_18_0, var_18_1 = self.label_intro:getPosition()
	local var_18_2 = 40
	local var_18_3 = ccui.Helper:seekWidgetByName(self.panel_grade, "grade_old")

	var_18_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_18_3:setPosition(cc.p(5, 0))
	var_18_3:setString(string.format(L_SOULS_GRADE, self.soulContract))
	ccui.Helper:seekWidgetByName(self.panel_grade, "grade_new"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.panel_grade, "grade_arrow"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "shine_Image"):loadTexture("PopServantUpgradeLayer/shine_Purple.png", var_0_0)

	if self.msg.labels then
		for iter_18_0, iter_18_1 in ipairs(self.msg.labels) do
			local var_18_4 = iter_18_0 == 3

			if iter_18_0 == 3 and servant_data[self.curSoul] and servant_data[self.curSoul].linkage and servant_data[self.curSoul].linkage == 1 then
				break
			end

			local var_18_5 = var_18_4 and "+" or ""
			local var_18_6 = self.label_intro:clone()
			local var_18_7 = self.panel_intro:getChildByName("value_old"):clone()

			var_18_7:setVisible(not iter_18_1.isHide)
			var_18_6:setVisible(not iter_18_1.isHide)
			var_18_6:setPosition(cc.p(var_18_0 + 64, var_18_1 - var_18_2 * (iter_18_0 - 1)))
			var_18_6:setFontSize(24)
			self.panel_intro:addChild(var_18_6)
			var_18_6:setString(iter_18_1.name)
			var_18_7:setString(var_18_5 .. iter_18_1.newvalue[1])
			var_18_7:setPositionX(var_18_6:getPositionX() + 5)
			var_18_7:setPositionY(var_18_6:getPositionY())
			var_18_7:setFontSize(24)
			self.panel_intro:addChild(var_18_7)
		end
	end

	if self.overclock > 0 then
		var_18_3:setVisible(false)

		local var_18_8 = ccui.ImageView:create("PopServantUpgradeLayer/ocRankPic.png", var_0_0)

		var_18_8:setAnchorPoint(cc.p(0.5, 0.5))
		var_18_8:setPosition(var_18_3:getPositionX(), var_18_3:getPositionY())
		self.panel_grade:addChild(var_18_8)
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_upgradeskill"):setVisible(false)
end

function PopServantUpgradeLayer:setGirl()
	local var_19_0 = self:getOffset(servant_data[self.curSoul].modelid, 1)
	local var_19_1 = model_data[servant_data[self.curSoul].modelid].database_girl_scale or 1
	local var_19_2 = servant_data[self.curSoul].model_oc

	self.ocDetailPanel:setVisible(false)

	if self.overclock == 0 and self.isOC then
		self.image_shadow:setVisible(false)
		self.ocDetailPanel:setVisible(true)

		if var_19_2 then
			local var_19_4 = self:getOffset(var_19_2, 1, true)

			if not model_data[var_19_2].database_girl_scale then
				-- block empty
			end

			self.image_Role:setPosition(cc.p(var_19_4.x, var_19_4.y))
			self.image_shadow:setVisible(false)
		end

		local var_19_6 = self.ocDetailPanel:getChildByName("img_skill_cover")
		local var_19_7 = self.ocDetailPanel:getChildByName("btn_detail")

		var_19_7:setVisible(false)

		local var_19_8 = path or "skill_new/skill/" .. (total_skill_data[model_data[servant_data[self.curSoul].modelid].over_clocking_skill].icon or 22822) .. ".png"

		self.ocDetailPanel:getChildByName("img_skill"):loadTexture(var_19_8, var_0_0)
		self.ocDetailPanel:getChildByName("img_skill"):setScale(0.5)

		if not self.ocDetailPanel:getChildByName("skillName") then
			local var_19_9 = cc.Label:createWithTTF(L_UNLOCK .. "：", FONT_DES, 20)

			var_19_9:setAnchorPoint(cc.p(0, 0))
			var_19_9:setPosition(cc.p(var_19_6:getPositionX() + var_19_6:getContentSize().width / 2 + 10, var_19_6:getPositionY() - var_19_6:getContentSize().height / 2))
			self.ocDetailPanel:addChild(var_19_9)

			local var_19_10 = cc.Label:createWithTTF(total_skill_data[model_data[servant_data[self.curSoul].modelid].over_clocking_skill].name, FONT_DES, 24)

			var_19_10:setAnchorPoint(cc.p(0, 0))
			var_19_10:setPosition(cc.p(var_19_9:getPositionX() + var_19_9:getContentSize().width, var_19_9:getPositionY()))
			var_19_10:setName("skillName")
			self.ocDetailPanel:addChild(var_19_10)

			self.msg.skillpath = var_19_8
			self.msg.skillName = total_skill_data[model_data[servant_data[self.curSoul].modelid].over_clocking_skill].name
		end

		self.ocDetailPanel:getChildByName("img_skill"):setTouchEnabled(true)
		self.ocDetailPanel:getChildByName("img_skill"):addTouchEventListener(function(arg_20_0, arg_20_1)
			if arg_20_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopskillDetailLayer", {
				servantid = self.curSoul
			})
		end)
		var_19_7:addTouchEventListener(function(arg_21_0, arg_21_1)
			local var_21_0

			if arg_21_1 ~= ccui.TouchEventType.ended then
				do return end

				var_21_0 = {}
			end

			var_21_0.itemid = major_factor_data[servant_data[self.curSoul].major].item_oc

			LayerManager:pushInLayer("PopShowGilrPreviewLayer", {
				modelid = item_data[var_21_0.itemid].model
			})
		end)

		if var_19_2 then
			self.image_Role:loadTexture(var_0_18 .. model_data[var_19_2].role_image .. ".png")
		end
	elseif self.overclock > 0 then
		local var_19_11 = self:getOffset(var_19_2, 1)

		self.image_shadow:setPosition(var_19_11.x, var_19_11.y)
		self.image_Role:setVisible(true)
		self.image_shadow:setVisible(false)

		if var_19_2 then
			self.image_Role:loadTexture(var_0_18 .. model_data[var_19_2].role_image .. ".png")

			local var_19_12 = self:getOffset(var_19_2, 1, true)
			local var_19_13 = model_data[var_19_2].database_girl_scale or 1

			self.image_Role:setPosition(cc.p(var_19_12.x, var_19_12.y))
			self.image_shadow:setVisible(false)
			self.image_Role:setScale(var_19_13)
		end
	else
		self.image_Role:loadTexture(var_0_18 .. model_data[servant_data[self.curSoul].modelid].role_image .. ".png")
		self.image_Role:setScale(var_19_1)
		self.image_Role:setPosition(cc.p(var_19_0.x, var_19_0.y))
	end
end

function PopServantUpgradeLayer:setNowGrade()
	self.partBottom:removeAllChildren()

	for iter_22_0 = 1, self.soulContract do
		local var_22_0 = ccui.ImageView:create("PopServantUpgradeLayer/part_white" .. iter_22_0 .. ".png", var_0_0)

		var_22_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_22_0:setName("rank_" .. iter_22_0)
		var_22_0:setPosition(var_0_20[iter_22_0].x, var_0_20[iter_22_0].y)
		self.partBottom:addChild(var_22_0)
	end

	if self.soulContract < 5 then
		local var_22_1 = ccui.ImageView:create("PopServantUpgradeLayer/part_blue" .. self.soulContract + 1 .. ".png", var_0_0)

		var_22_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_22_1:setPosition(var_0_20[self.soulContract + 1].x, var_0_20[self.soulContract + 1].y)
		var_22_1:setName("breath_Image")
		self.partBottom:addChild(var_22_1)
		self.partBottom:getChildByName("breath_Image"):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(0.8, 0), cc.FadeTo:create(0.8, 255))))
	elseif self.isOC then
		for iter_22_1 = 1, 5 do
			local var_22_2 = ccui.ImageView:create("PopServantUpgradeLayer/part_purple" .. iter_22_1 .. ".png", var_0_0)

			var_22_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_22_2:setPosition(var_0_20[iter_22_1].x, var_0_20[iter_22_1].y)
			var_22_2:setName("breath_Image")
			self.partBottom:addChild(var_22_2)
			var_22_2:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(0.8, 0), cc.FadeTo:create(0.8, 255))))
			ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_upgradeskill"):setVisible(false)
		end

		self.partBottom:loadTexture("PopServantUpgradeLayer/upgrade_bottom_oc.png", var_0_0)
	elseif self.overclock > 0 then
		for iter_22_2 = 1, 5 do
			local var_22_3 = self.partBottom:getChildByName("rank_" .. iter_22_2):loadTexture("PopServantUpgradeLayer/part_purple" .. iter_22_2 .. ".png", var_0_0)
		end

		self.partBottom:loadTexture("PopServantUpgradeLayer/upgrade_bottom_oc.png", var_0_0)
	end
end

function PopServantUpgradeLayer:setSureButton()
	if playermodel:isServantOverclockLockByTime(self.curSoul) or not servant_data[self.curSoul]["oc_isopen" .. self.overclock + 1] then
		-- block empty
	end

	self.surebutton:setPressedActionEnabled(true)

	if self.showtype == var_0_23 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "button_sure"):loadTextures("PopServantUpgradeLayer/sure_oc.png", nil, "PopServantUpgradeLayer/sure_oc.png", var_0_0)
		ccui.Helper:seekWidgetByName(self.rootLayer, "button_sure"):getChildByName("Label_21"):setVisible(false)
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "button_sure"):loadTextures("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_0)
		ccui.Helper:seekWidgetByName(self.rootLayer, "button_sure"):getChildByName("Label_21"):setVisible(true)

		if self.isAdvance then
			ccui.Helper:seekWidgetByName(self.rootLayer, "button_sure"):getChildByName("Label_21"):setString(L_BUTTON_TEXT.Advance)
		else
			ccui.Helper:seekWidgetByName(self.rootLayer, "button_sure"):getChildByName("Label_21"):setString(L_BUTTON_TEXT.Up_Grade)
		end
	end

	if self.msg.bntstr then
		local var_23_1 = self.surebutton:getChildByName("Label_21")

		var_23_1:setString(self.msg.bntstr)
		var_23_1:setFontSize(34)
		var_23_1:setPosition(cc.p(self.surebutton:getContentSize().width / 2, self.surebutton:getContentSize().height / 2 - 3))
	else
		self.surebutton:setVisible(false)
	end

	if self.showtype == var_0_22 and playermodel.soulContract[self.curSoul] < 5 then
		self.surebutton:setVisible(true)
	elseif self.showtype == var_0_22 and self.isAdvance then
		self.surebutton:setVisible(true)
	elseif self.showtype == var_0_23 and self.isOC then
		self.msg.isOcOpen = true

		self.surebutton:setVisible(true)
	else
		self.surebutton:setVisible(false)
	end

	self.surebutton:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not playermodel.haveServant[self.curSoul] then
			return
		end

		if self.showtype == var_0_22 and playermodel.soulContract[self.curSoul] < 5 then
			LayerManager:pushInLayer("PopServantUpgradeMaterialLayer", self.msg)
		elseif self.showtype == var_0_22 and self.isAdvance then
			LayerManager:pushInLayer("PopServantAdvanceLayer", self.msg)
		elseif self.showtype == var_0_23 and self.isOC then
			LayerManager:pushInLayer("PopServantUpgradeMaterialLayer", self.msg)
		end
	end)
end

function PopServantUpgradeLayer:updatePanel()
	self:updateData()
	self:updateSwithBtn()
	self:updateAttr()
	self:setNowGrade()
	self:setSureButton()
	self:setGirl()
end

function PopServantUpgradeLayer:updateAttr()
	if souls_manager:check_is_can_avance(self.curSoul) or souls_manager:check_is_can_upgrade(self.curSoul) or souls_manager:check_is_can_OC(self.curSoul) then
		local var_26_0, var_26_1 = self.label_intro:getPosition()
		local var_26_3 = ccui.Helper:seekWidgetByName(self.panel_grade, "grade_old")

		var_26_3:setString(string.format(L_SOULS_GRADE, self.soulContract))
		var_26_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_26_3:setPosition(cc.p(5, 0))
		ccui.Helper:seekWidgetByName(self.panel_grade, "grade_new"):setVisible(false)

		if self.msg.labels then
			for iter_26_0, iter_26_1 in ipairs(self.msg.labels) do
				local var_26_4 = self.panel_intro:getChildByName("value_new_" .. iter_26_0)
				local var_26_5 = self.panel_intro:getChildByName("value_old_" .. iter_26_0)
				local var_26_6 = self.panel_intro:getChildByName("Image_Arrow_" .. iter_26_0)
				local var_26_7 = self.panel_intro:getChildByName("strlabel_" .. iter_26_0)
				local var_26_8 = iter_26_0 == 3

				if iter_26_0 == 3 and servant_data[self.curSoul] and servant_data[self.curSoul].linkage and servant_data[self.curSoul].linkage == 1 then
					break
				end

				local var_26_9 = var_26_8 and "+" or ""

				var_26_7:setVisible(not iter_26_1.isHide)
				var_26_5:setVisible(not iter_26_1.isHide)
				var_26_4:setVisible(not iter_26_1.isHide)
				var_26_6:setVisible(not iter_26_1.isHide)
				var_26_4:setString(var_26_9 .. iter_26_1.newvalue[2])
				var_26_5:setString(var_26_9 .. iter_26_1.newvalue[1])

				if self.isOC then
					var_26_6:loadTexture("public/panelbg/strengen_arrow2.png", var_0_0)
				end
			end

			local var_26_10 = #self.msg.labels + 1

			while self.panel_intro:getChildByName("value_new_" .. var_26_10) do
				self.panel_intro:getChildByName("value_new_" .. var_26_10):setVisible(false)
				self.panel_intro:getChildByName("value_old_" .. var_26_10):setVisible(false)
				self.panel_intro:getChildByName("Image_Arrow_" .. var_26_10):setVisible(false)
				self.panel_intro:getChildByName("strlabel_" .. var_26_10):setVisible(false)

				var_26_10 = var_26_10 + 1
			end
		end

		local function var_26_11()
			local var_27_0

			if self.soulContract < 3 then
				ccui.Helper:seekWidgetByName(self.rootLayer, "Image_upgrade"):loadTexture("PopServantUpgradeLayer/up_grade3_skill.png", var_0_0)

				var_27_0 = model_data[servant_data[self.curSoul].modelid].upgrade_skill_3
			elseif self.soulContract < 5 then
				ccui.Helper:seekWidgetByName(self.rootLayer, "Image_upgrade"):loadTexture("PopServantUpgradeLayer/up_grade5_skill.png", var_0_0)

				var_27_0 = model_data[servant_data[self.curSoul].modelid].upgrade_skill_5
			end

			if var_27_0 then
				ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_upgradeskill"):setVisible(true)

				if ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_upgradeskill"):getChildByName("richText") then
					ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_upgradeskill"):getChildByName("richText"):removeFromParent()
				end

				local var_27_1 = RichTextPro:create()

				var_27_1:setMaxWidth(300)
				var_27_1:setSize(24)
				var_27_1:setPosition(cc.p(20, 50))
				var_27_1:setColor(cc.c3b(220, 251, 241))
				var_27_1:setLineSpace(0)
				var_27_1:setName("richText")
				ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_upgradeskill"):addChild(var_27_1)
				ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_upgradeskill"):getChildByName("richText"):setText((transSkillDesToRichText(total_skill_data[var_27_0].description)))
			end
		end

		if souls_manager:check_is_can_avance(self.curSoul) then
			var_26_11()

			if souls_manager:check_is_can_avance(self.curSoul) then
				self:updateAttrHide()
			end
		else
			ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_upgradeskill"):setVisible(false)
			var_26_11()
		end
	else
		self:updateMaxAttr()
	end
end

function PopServantUpgradeLayer:updateAttrHide()
	if self.msg.labels then
		for iter_28_0, iter_28_1 in ipairs(self.msg.labels) do
			if iter_28_0 >= 3 then
				break
			end

			local var_28_0 = self.panel_intro:getChildByName("strlabel_" .. iter_28_0)
			local var_28_1 = self.panel_intro:getChildByName("value_new_" .. iter_28_0)
			local var_28_2 = self.panel_intro:getChildByName("value_old_" .. iter_28_0)
			local var_28_3 = self.panel_intro:getChildByName("Image_Arrow_" .. iter_28_0)

			var_28_0:setVisible(false)
			var_28_1:setVisible(false)
			var_28_2:setVisible(false)
			var_28_3:setVisible(false)
		end
	end
end

function PopServantUpgradeLayer:updateNowGrade()
	self.partBottom:removeAllChildren()

	for iter_29_0 = 1, self.soulContract do
		local var_29_0 = ccui.ImageView:create("PopServantUpgradeLayer/part_white" .. iter_29_0 .. ".png", var_0_0)

		var_29_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_29_0:setPosition(var_0_20[iter_29_0].x, var_0_20[iter_29_0].y)
		self.partBottom:addChild(var_29_0)
	end

	if self.soulContract < 5 then
		local var_29_1 = ccui.ImageView:create("PopServantUpgradeLayer/part_blue" .. self.soulContract + 1 .. ".png", var_0_0)

		var_29_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_29_1:setPosition(var_0_20[self.soulContract + 1].x, var_0_20[self.soulContract + 1].y)
		var_29_1:setName("breath_Image")
		self.partBottom:addChild(var_29_1)
		self.partBottom:getChildByName("breath_Image"):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(0.8, 0), cc.FadeTo:create(0.8, 255))))
	end
end

function PopServantUpgradeLayer:updateSureButton(arg_30_1)
	self.surebutton:setPressedActionEnabled(true)

	if arg_30_1.bntstr then
		self.surebutton:getChildByName("Label_21"):setString(arg_30_1.bntstr)
	else
		self.surebutton:setVisible(false)
	end

	self.surebutton:addTouchEventListener(function(arg_31_0, arg_31_1)
		if arg_31_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not playermodel.haveServant[arg_30_1.curSoul] then
			return
		end

		LayerManager:pushInLayer("PopServantUpgradeMaterialLayer", arg_30_1)
	end)
end

function PopServantUpgradeLayer:updateMaxAttr(arg_32_1)
	local var_32_0, var_32_1 = self.label_intro:getPosition()
	local var_32_2 = ccui.Helper:seekWidgetByName(self.panel_grade, "grade_old")

	var_32_2:setString(string.format(L_SOULS_GRADE, self.soulContract))
	var_32_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_32_2:setPosition(cc.p(5, 0))
	ccui.Helper:seekWidgetByName(self.panel_grade, "grade_new"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.panel_grade, "grade_arrow"):setVisible(false)
	self.surebutton:setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "shine_Image"):loadTexture("PopServantUpgradeLayer/shine_Purple.png", var_0_0)

	if self.overclock < 1 and self.msg.labels then
		for iter_32_0, iter_32_1 in ipairs(self.msg.labels) do
			if not self.panel_intro:getChildByName("strlabel_" .. iter_32_0) then
				break
			end

			local var_32_3 = self.label_intro:clone()

			self.panel_intro:getChildByName("strlabel_" .. iter_32_0):setVisible(false)
			self.panel_intro:getChildByName("value_new_" .. iter_32_0):setVisible(false)
			self.panel_intro:getChildByName("Image_Arrow_" .. iter_32_0):setVisible(false)

			local var_32_4 = self.panel_intro:getChildByName("value_old_" .. iter_32_0)

			var_32_4:setVisible(true)
			var_32_3:setVisible(true)
			var_32_3:setPosition(cc.p(var_32_0 + 64, var_32_1 - 40 * (iter_32_0 - 1)))
			var_32_3:setFontSize(24)
			self.panel_intro:addChild(var_32_3)
			var_32_3:setString(iter_32_1.name)
			var_32_4:setString(iter_32_1.newvalue[1])
			var_32_4:setPositionX(var_32_3:getPositionX() + 5)
			var_32_4:setPositionY(var_32_3:getPositionY())
			var_32_4:setFontSize(24)
		end
	end

	if self.overclock > 0 then
		var_32_2:setString(string.format(L_SOULS_OVERCLOCK, self.overclock))
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_upgradeskill"):setVisible(false)
end

function PopServantUpgradeLayer.getOffset(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local var_34_0
	local var_34_1

	if false then
		var_34_0 = model_data[arg_34_1].shadow_girl_offset_x or 0
		var_34_1 = model_data[arg_34_1].shadow_girl_offset_y or 0
	else
		var_34_0 = model_data[arg_34_1].upgrade_offset_x or model_data[arg_34_1].database_girl_offset_x or 0
		var_34_1 = model_data[arg_34_1].upgrade_offset_y or model_data[arg_34_1].database_girl_offset_y or 0

		hx_print("modelid:" .. arg_34_1 .. " " .. model_data[arg_34_1].name .. " 使用偏移 upgrade_offset_x or database_girl_offset_x = " .. (var_34_0 or 0) .. " upgrade_offset_y or database_girl_offset_y = " .. (var_34_1 or 0), CONSOLE_COLOR_GREEN)
	end

	return (cc.p(var_34_0 + 320, var_34_1 + GameDisplay.height / 2))
end

function PopServantUpgradeLayer:DealSoulBreak(arg_35_1, arg_35_2)
	if arg_35_1 < 5 then
		if not arg_35_2 then
			local var_35_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "button_sure")

			var_35_0:loadTextures("public/button/public_button_gray_long.png", nil, "public/button/public_button_gray_long.png", var_0_0)
			var_35_0:getChildByName("Label_21"):setPosition(cc.p(var_35_0:getContentSize().width / 2, var_35_0:getContentSize().height / 2 - 5))
			var_35_0:getChildByName("Label_21"):setString(L_SOULS_BREAK_LIMIT.Warning[4])
			var_35_0:getChildByName("Label_21"):setColor(cc.c3b(12, 12, 12))
		end
	else
		local var_35_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "button_sure")

		var_35_1:getChildByName("Label_21"):setPosition(cc.p(var_35_1:getContentSize().width / 2, var_35_1:getContentSize().height / 2 - 5))
		var_35_1:getChildByName("Label_21"):setString(L_SOULS_BREAK_LIMIT.Level_Max)
		var_35_1:getChildByName("Label_21"):setColor(cc.c3b(12, 12, 12))
	end
end

function PopServantUpgradeLayer:fullScreen(arg_36_1)
	self.rootLayer:setPositionY(-GameDisplay.fix_y)
end

function PopServantUpgradeLayer:showSoulGirlPop(arg_37_1)
	local var_37_0 = item_data[arg_37_1.itemid].model

	if not model_data[item_data[arg_37_1.itemid].model].background then
		-- block empty
	end

	local var_37_1 = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "SoulGirlPop.json" or "SoulGirlPop.ExportJson")
	local var_37_2 = ccui.Helper:seekWidgetByName(var_37_1, "Panel_26")

	var_37_2:setLocalZOrder(1)
	self:addChild(var_37_1, 99)

	self.showSoulGirlScenePanel = ccui.Helper:seekWidgetByName(var_37_1, "Image_back")

	self.showSoulGirlScenePanel:setPosition(cc.p(320, 568))
	self.showSoulGirlScenePanel:setTouchEnabled(true)
	self.showSoulGirlScenePanel:setLocalZOrder(0)

	local var_37_3 = ccui.Helper:seekWidgetByName(var_37_1, "Button_return")

	if model_data[var_37_0].background and model_data[var_37_0].background == "dark" then
		var_37_3:loadTextures("MarketLayer/return_btn_dark.png", nil, "MarketLayer/return_btn_dark.png", var_0_0)
	else
		var_37_3:loadTextures("MarketLayer/return_btn_bright.png", nil, "MarketLayer/return_btn_bright.png", var_0_0)
	end

	var_37_3:setLocalZOrder(2)

	local function var_37_4(arg_38_0, arg_38_1)
		if arg_38_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.showgirlLayer:resetCurTalkConfig()
		var_37_1:runAction(cc.RemoveSelf:create())

		var_37_1 = nil
	end

	var_37_3:setTouchEnabled(false)
	self.showSoulGirlScenePanel:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function(...)
		var_37_3:setTouchEnabled(true)
		var_37_3:addTouchEventListener(var_37_4)
	end)))

	local var_37_5 = ccui.Helper:seekWidgetByName(var_37_1, "Panel_cute_role")
	local var_37_6 = ccui.Helper:seekWidgetByName(var_37_1, "Image_cute_role")

	var_37_6:loadTexture("roleimage/role1/" .. model_data[var_37_0].cute_role .. ".png")
	var_37_6:setPosition(cc.p(var_37_5:getContentSize().width / 2, var_37_5:getContentSize().height / 2 + 30))
	var_37_6:setScale(0.4)
	var_37_6:setVisible(false)

	local var_37_7 = ccui.Helper:seekWidgetByName(var_37_1, "Panel_up"):setPositionY(568 + GameDisplay.fix_y)
	local var_37_8 = ccui.Helper:seekWidgetByName(var_37_1, "Panel_down"):setPositionY(568 - GameDisplay.fix_y)

	ccui.Helper:seekWidgetByName(var_37_1, "Panel_down"):setLocalZOrder(3)
	ccui.Helper:seekWidgetByName(var_37_1, "Panel_up"):setLocalZOrder(3)

	L2ActorSprite = L2Actor:create(ROLE_SPINE_PATH .. model_data[var_37_0].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[var_37_0].spine_model .. ".atlas", (model_data[var_37_0].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[var_37_0].clothes_model .. ".atlas" or nil))

	local var_37_9 = model_data[var_37_0].actorScale or 0.4

	L2ActorSprite:setScale(var_37_9, var_37_9)
	L2ActorSprite:setContentSize(cc.size(100, 200))
	L2ActorSprite:setPosition(cc.p(var_37_5:getContentSize().width / 2, var_37_5:getContentSize().height / 2 - 60))
	var_37_5:addChild(L2ActorSprite, 99)
	L2ActorSprite:playAni(nil, "idle", true)
	var_37_5:addTouchEventListener(function(arg_40_0, arg_40_1)
		if arg_40_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_40_0 = math.random(2, 5)

		local function var_40_1()
			L2ActorSprite:playAni(nil, "idle", true)
		end

		if var_40_0 == 2 then
			L2ActorSprite:playAni(var_40_1, "run", false)
		elseif var_40_0 == 3 then
			L2ActorSprite:playAni(var_40_1, "yule", false)
		elseif var_40_0 == 4 then
			L2ActorSprite:playAni(var_40_1, "chihe", false)
		else
			L2ActorSprite:playAni(var_40_1, "fadai", false)
		end
	end)

	local var_37_10 = ccui.Helper:seekWidgetByName(var_37_1, "Label_name")
	local var_37_11 = ccui.Helper:seekWidgetByName(var_37_1, "Image_cv")

	var_37_11:loadTexture("public/panelbg/cv_bg.png", var_0_0)

	if favorfile_data[3][model_data[var_37_0].photofile_model] then
		var_37_11:setVisible(favorfile_data[3][model_data[var_37_0].photofile_model] ~= L_CV_UNSURE)

		local var_37_12 = cc.Label:createWithTTF("CV/" .. favorfile_data[3][model_data[var_37_0].photofile_model], FONT_DES, 28)

		var_37_12:setPosition(cc.p(var_37_11:getContentSize().width / 2, var_37_11:getContentSize().height / 2 - 3))
		var_37_11:addChild(var_37_12)
	else
		var_37_11:setVisible(false)
	end

	var_37_10:setFontSize(global_change_fontsize_by_length(model_data[var_37_0].name, 40, 4, 6))
	var_37_10:setString(model_data[var_37_0].name)
	var_37_10:setLocalZOrder(9999)

	local var_37_13 = ccui.Helper:seekWidgetByName(var_37_1, "Label_name_bottom")
	local var_37_14 = ccui.Helper:seekWidgetByName(var_37_1, "Label_name_top")

	var_37_13:setString(model_data[var_37_0].main_name)
	var_37_14:setString(model_data[var_37_0].main_name)

	if model_data[var_37_0].background and model_data[var_37_0].background == "bright" then
		var_37_13:setColor(cc.c3b(40, 125, 205))
		var_37_14:setColor(cc.c3b(0, 255, 246))
	end

	local var_37_15 = ccui.Helper:seekWidgetByName(var_37_1, "Image_type")
	local var_37_16

	if model_data[var_37_0].live2d and not model_data[var_37_0].origin then
		var_37_16 = "MarketLayer/skin_type_live2d.png"
	elseif model_data[var_37_0].rolespine then
		var_37_16 = "MarketLayer/skin_type_spine.png"
	else
		var_37_15:setVisible(false)
	end

	var_37_15:loadTextures(var_37_16, nil, var_37_16, var_0_0)
	var_37_15:addTouchEventListener(function(arg_42_0, arg_42_1)
		if arg_42_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:tisPanel()
	end)

	local var_37_17 = ccui.Helper:seekWidgetByName(var_37_1, "Image_cost_bottom")

	var_37_17:loadTexture("MarketLayer/cost_bottom_bright.png", var_0_0)
	ccui.Helper:seekWidgetByName(var_37_1, "Image_name"):loadTexture("MarketLayer/skin_name_bottom_bright.png", var_0_0)
	ccui.Helper:seekWidgetByName(var_37_1, "Button_buy"):setVisible(false)
	var_37_17:setVisible(false)

	local var_37_18 = ccui.Layout:create()

	var_37_18:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_37_18:setAnchorPoint(cc.p(0.5, 0.5))
	var_37_18:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_37_18:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_37_18:setBackGroundColor(cc.c3b(0, 0, 0))
	var_37_18:setBackGroundColorOpacity(0)
	var_37_2:addChild(var_37_18, 2)

	local var_37_19 = cc.EventListenerTouchOneByOne:create()

	var_37_19:setSwallowTouches(false)
	var_37_19:registerScriptHandler(function(arg_43_0, arg_43_1)
		if var_0_21[playermodel.playerid][var_37_0] > PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT + 1 and arg_37_1.have_bought_num ~= 1 then
			global_ShowBlockWords(L_DORMROOM_SEND_GIFT.Interaciton_Used_Up)

			return true
		elseif var_0_21[playermodel.playerid][var_37_0] >= PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT then
			var_0_21[playermodel.playerid][var_37_0] = var_0_21[playermodel.playerid][var_37_0] + 1

			global_ShowBlockWords(L_DORMROOM_SEND_GIFT.Interaciton_Used_Up)

			return false
		else
			return true
		end
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_37_19:registerScriptHandler(function(arg_44_0, arg_44_1)
		return false
	end, cc.Handler.EVENT_TOUCH_ENDED)
	var_37_18:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_37_19, var_37_18)

	function handler(arg_45_0, arg_45_1)
		if arg_45_1 ~= ccui.TouchEventType.ended then
			return
		end

		global_ShowBlockWords(L_DORMROOM_SEND_GIFT.Interaciton_Used_Up)
	end

	self.showSoulGirlScenePanel:setVisible(true)

	self.showgirlLayer = require("view.Layer.ShowGirlLayer"):create(var_37_0, 3)

	self.showgirlLayer:resetCurTalkConfig()

	if not var_0_21[playermodel.playerid] then
		var_0_21[playermodel.playerid] = {}
		var_0_21[playermodel.playerid][var_37_0] = var_0_21[playermodel.playerid][var_37_0] or 0
	else
		var_0_21[playermodel.playerid][var_37_0] = var_0_21[playermodel.playerid][var_37_0] or 0
	end

	self.showgirlLayer:setTalkEnabled(var_0_21[playermodel.playerid][var_37_0] < PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT)
	self.showgirlLayer:setTouchTalkCallback(function()
		var_0_21[playermodel.playerid][var_37_0] = var_0_21[playermodel.playerid][var_37_0] + 1

		self.showgirlLayer:setTalkEnabled(var_0_21[playermodel.playerid][var_37_0] < PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT)
	end)
	var_37_2:addChild(self.showgirlLayer, 1)

	if model_data[var_37_0].backgroundid then
		var_37_2:addChild(BackGroundLayer:create(model_data[var_37_0].backgroundid, (model_data[var_37_0].is_own_full_screen_background == 1 or nil) and 2), 0)
	end
end

function PopServantUpgradeLayer:exit()
	global_window_close_action(self.panel, function()
		if self.cancelcallback then
			self.cancelcallback()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopServantUpgradeLayer:registerOnGetNewMaterial()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("ON_GET_XINXIYA_TOTAL_RECHARGE_AWARD", function()
		self:updateData()
	end), self)
end

function PopServantUpgradeLayer:showUpGradeAni(arg_51_1)
	self.panel:setVisible(false)

	msg = arg_51_1.msg
	breakTbl = arg_51_1.breakTbl

	audio_manager:playeffectMusicTest("sound/upgrade_rank")

	local var_51_0 = ccui.Layout:create()

	var_51_0:setTouchEnabled(true)
	var_51_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_51_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_51_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_51_0:setBackGroundColorOpacity(0)
	var_51_0:setPositionY(-GameDisplay.fix_y)
	self:addChild(var_51_0, 999)

	local var_51_1 = self:getOffset(servant_data[self.curSoul].modelid, 1)
	local var_51_2 = model_data[servant_data[self.curSoul].modelid].database_girl_scale or 1
	local var_51_3 = ccui.ImageView:create(var_0_18 .. model_data[servant_data[self.curSoul].modelid].role_image .. ".png")

	var_51_3:setPosition(var_51_1)
	var_51_3:setScale(var_51_2)
	var_51_0:addChild(var_51_3, 1)
	l2utils:shaderDarkPicNode(var_51_3:getVirtualRenderer(), {
		z = 0.1,
		x = 0.1,
		y = 0.1
	})

	local var_51_4 = L2Skeleton:create("spine/ui/girl_upgrade/ui_xia_ceng.json", "spine/ui/girl_upgrade/ui_xia_ceng.atlas")

	var_51_4:refreshSkeleton()
	var_51_4:setPosition(cc.p(320, 568))
	var_51_4:play("animation", false)
	var_51_0:addChild(var_51_4, 2)

	local var_51_5 = ccui.ImageView:create(var_0_18 .. model_data[servant_data[self.curSoul].modelid].role_image .. ".png")

	var_51_5:setPosition(var_51_1)
	var_51_5:setScale(var_51_2)
	var_51_5:setVisible(false)
	var_51_0:addChild(var_51_5, 3)
	var_51_5:runAction(cc.Sequence:create(cc.DelayTime:create(1.8), cc.CallFunc:create(function(...)
		var_51_3:setVisible(false)
		var_51_5:setVisible(true)
		var_51_5:setOpacity(0)
		var_51_5:runAction(cc.FadeTo:create(0.2, 120))
	end)))

	local var_51_6 = L2Skeleton:create("spine/ui/girl_upgrade/ui_shang_ceng.json", "spine/ui/girl_upgrade/ui_shang_ceng.atlas")

	var_51_6:refreshSkeleton()
	var_51_6:setPosition(cc.p(320, 568))
	var_51_6:play("animation", false)
	var_51_0:addChild(var_51_6, 4)
	var_51_6:registerListener(SP_ANIMATION_COMPLETE, function(arg_53_0)
		return
	end)

	local var_51_9 = false

	var_51_0:runAction(cc.Sequence:create(cc.DelayTime:create(1.6), cc.CallFunc:create(function()
		var_51_9 = true
	end), cc.CallFunc:create(function()
		local var_54_0 = {}
		local var_54_1 = {}
		local var_54_2 = {}

		while #msg[1] > 0 do
			var_54_0[#var_54_0 + 1] = msg[1][#msg[1]]
			var_54_2[#var_54_2 + 1] = msg[2][#msg[1]]
			var_54_1[#var_54_1 + 1] = msg[3][#msg[1]]
		end

		local var_54_4 = 680

		;(function()
			local var_55_0 = ccui.Text:create(breakTbl.text .. ":", FONT_DES, 24)

			var_55_0:setColor(cc.c3b(255, 192, 0))
			var_55_0:setPositionX(240)
			var_55_0:setPositionY(var_54_4 + 80)
			var_55_0:setOpacity(0)
			var_55_0:runAction(cc.Sequence:create(cc.FadeIn:create(0.3)))
			var_51_0:addChild(var_55_0, 5)

			local var_55_1 = ccui.Text:create(breakTbl.oldBreakNum, FONT_DES, 24)

			var_55_1:setColor(cc.c3b(255, 192, 0))
			var_55_1:setPositionX(315)
			var_55_1:setPositionY(var_54_4 + 80)
			var_55_1:setOpacity(0)
			var_55_1:runAction(cc.Sequence:create(cc.FadeIn:create(0.3)))
			var_51_0:addChild(var_55_1, 5)

			local var_55_2 = ccui.ImageView:create("PopServantUpgradeLayer/arrow_yellow.png", var_0_0)

			var_55_2:setPositionX(370)
			var_55_2:setPositionY(var_54_4 + 80)
			var_55_2:setOpacity(0)
			var_55_2:runAction(cc.Sequence:create(cc.FadeIn:create(0.3)))
			var_51_0:addChild(var_55_2, 5)

			local var_55_3 = ccui.Text:create(breakTbl.curBreakNum, FONT_DES, 24)

			var_55_3:setColor(cc.c3b(255, 192, 0))
			var_55_3:setPositionX(415)
			var_55_3:setPositionY(var_54_4 + 80)
			var_55_3:setOpacity(0)
			var_55_3:runAction(cc.Sequence:create(cc.FadeIn:create(0.3)))
			var_51_0:addChild(var_55_3, 5)
		end)()

		for iter_54_0, iter_54_1 in pairs(var_54_0) do
			local var_54_5 = tonumber(iter_54_0) == 3

			if var_54_5 and servant_data[self.curSoul] and servant_data[self.curSoul].linkage and servant_data[self.curSoul].linkage == 1 then
				break
			end

			if var_54_2[iter_54_0][1] == 0 and var_54_2[iter_54_0][2] == 0 then
				break
			end

			local var_54_6 = 50
			local var_54_7 = var_54_5 and "+" or ""
			local var_54_8 = ccui.Text:create(iter_54_1 .. ":", FONT_DES, 24)

			var_54_8:setColor(var_54_1[iter_54_0])
			var_54_8:setPositionX(240)
			var_54_8:setPositionY(var_54_4 + 80 - iter_54_0 * var_54_6)
			var_54_8:setOpacity(0)
			var_54_8:runAction(cc.Sequence:create(cc.DelayTime:create(iter_54_0 * 0.2), cc.Spawn:create(cc.FadeIn:create(0.3))))
			var_51_0:addChild(var_54_8, 5)

			local var_54_9 = ccui.Text:create(var_54_7 .. var_54_2[iter_54_0][1], FONT_DES, 24)

			var_54_9:setColor(var_54_1[iter_54_0])
			var_54_9:setPositionX(320)
			var_54_9:setPositionY(var_54_4 + 80 - iter_54_0 * var_54_6)
			var_54_9:setOpacity(0)
			var_54_9:runAction(cc.Sequence:create(cc.DelayTime:create(iter_54_0 * 0.2), cc.FadeIn:create(0.3)))
			var_51_0:addChild(var_54_9, 5)

			local var_54_10 = ccui.ImageView:create("public/panelbg/strengen_arrow.png", var_0_0)

			var_54_10:setPositionX(370)
			var_54_10:setPositionY(var_54_4 + 80 - iter_54_0 * var_54_6)
			var_54_10:setOpacity(0)
			var_54_10:runAction(cc.Sequence:create(cc.DelayTime:create(iter_54_0 * 0.2), cc.FadeIn:create(0.3)))
			var_51_0:addChild(var_54_10, 5)

			local var_54_11 = ccui.Text:create(var_54_7 .. var_54_2[iter_54_0][2], FONT_DES, 24)

			var_54_11:setColor(var_54_1[iter_54_0])
			var_54_11:setPositionX(420)
			var_54_11:setPositionY(var_54_4 + 80 - iter_54_0 * var_54_6)
			var_54_11:setOpacity(0)
			var_54_11:runAction(cc.Sequence:create(cc.DelayTime:create(iter_54_0 * 0.2), cc.FadeIn:create(0.3)))
			var_51_0:addChild(var_54_11, 5)
		end
	end), cc.DelayTime:create(10), cc.CallFunc:create(function()
		autopop_manager:resumeAchievementPop()
		self.panel:setVisible(true)
	end), cc.RemoveSelf:create()))
	var_51_0:addTouchEventListener(function(arg_58_0, arg_58_1)
		if arg_58_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not var_51_9 then
			return
		end

		autopop_manager:resumeAchievementPop()
		var_51_0:runAction(cc.RemoveSelf:create())
		self.panel:setVisible(true)
	end)
end

function PopServantUpgradeLayer:showAdvanceAni()
	self.panel:setVisible(false)
	audio_manager:playeffectMusicTest("sound/upgrade_rank")

	local var_59_0 = ccui.Layout:create()

	var_59_0:setTouchEnabled(true)
	var_59_0:setContentSize(cc.size(640, GameDisplay.height))
	var_59_0:setPosition(0, -GameDisplay.fix_y)
	var_59_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self:addChild(var_59_0, 999)

	local var_59_3 = cc.Sequence:create(cc.DelayTime:create(1.5), cc.FadeIn:create(0.3))
	local var_59_4 = ccui.ImageView:create("PopServantAdvanceLayer/arrow_yellow.png", var_0_0)

	var_59_4:setPosition(320, 660)
	var_59_4:setOpacity(0)
	var_59_4:runAction(var_59_3)
	var_59_0:addChild(var_59_4, 5)

	local var_59_5 = ccui.ImageView:create("public/rarity/" .. RARITY_STR_TBL[self.curRaity] .. "_short.png", var_0_0)

	var_59_5:setPosition(210, 660)
	var_59_5:setOpacity(0)
	var_59_5:runAction(var_59_3:clone())
	var_59_0:addChild(var_59_5, 5)

	local var_59_6 = ccui.ImageView:create("public/rolebg/+" .. self.curContract .. ".png", var_0_0)

	var_59_6:setPosition(260, 660)
	var_59_6:setOpacity(0)
	var_59_6:runAction(var_59_3:clone())
	var_59_0:addChild(var_59_6, 5)

	local var_59_7 = ccui.ImageView:create("public/rarity/" .. RARITY_STR_TBL[self.nextRaity] .. "_short.png", var_0_0)

	var_59_7:setPosition(380, 660)
	var_59_7:setOpacity(0)
	var_59_7:runAction(var_59_3:clone())
	var_59_0:addChild(var_59_7, 5)

	local var_59_8 = ccui.ImageView:create("public/rolebg/+" .. self.nextContract .. ".png", var_0_0)

	var_59_8:setPosition(430, 660)
	var_59_8:setOpacity(0)
	var_59_8:runAction(var_59_3:clone())
	var_59_0:addChild(var_59_8, 5)

	local var_59_9 = self:getOffset(servant_data[self.curSoul].modelid, 1)
	local var_59_10 = model_data[servant_data[self.curSoul].modelid].database_girl_scale or 1
	local var_59_11 = ccui.ImageView:create(var_0_18 .. model_data[servant_data[self.curSoul].modelid].role_image .. ".png")

	var_59_11:setPosition(var_59_9)
	var_59_11:setScale(var_59_10)
	var_59_0:addChild(var_59_11, 1)
	l2utils:shaderDarkPicNode(var_59_11:getVirtualRenderer(), {
		z = 0.1,
		x = 0.1,
		y = 0.1
	})

	local var_59_12 = L2Skeleton:create("spine/ui/girl_upgrade/ui_xia_ceng.json", "spine/ui/girl_upgrade/ui_xia_ceng.atlas")

	var_59_12:refreshSkeleton()
	var_59_12:setPosition(cc.p(320, 568))
	var_59_12:play("animation", false)
	var_59_0:addChild(var_59_12, 2)

	local var_59_13 = ccui.ImageView:create(var_0_18 .. model_data[servant_data[self.curSoul].modelid].role_image .. ".png")

	var_59_13:setPosition(var_59_9)
	var_59_13:setScale(var_59_10)
	var_59_13:setVisible(false)
	var_59_0:addChild(var_59_13, 3)
	var_59_13:runAction(cc.Sequence:create(cc.DelayTime:create(1.8), cc.CallFunc:create(function(...)
		var_59_11:setVisible(false)
		var_59_13:setVisible(true)
		var_59_13:setOpacity(0)
		var_59_13:runAction(cc.FadeTo:create(0.2, 120))
	end)))

	local var_59_14 = L2Skeleton:create("spine/ui/girl_upgrade/ui_shang_ceng.json", "spine/ui/girl_upgrade/ui_shang_ceng.atlas", nil, true)

	var_59_14:refreshSkeleton()
	var_59_14:setPosition(cc.p(320, 568))
	var_59_14:play("animation", false)
	var_59_0:addChild(var_59_14, 4)
	var_59_14:setSlotTexture("图层 5", "图层 5", "mainScenebg/other/advance_title.png")
	var_59_14:registerListener(SP_ANIMATION_COMPLETE, function(arg_61_0)
		return
	end)

	local var_59_15 = false

	var_59_0:runAction(cc.Sequence:create(cc.DelayTime:create(1.6), cc.CallFunc:create(function()
		var_59_15 = true
	end), cc.DelayTime:create(10), cc.CallFunc:create(function()
		autopop_manager:resumeAchievementPop()
		self.panel:setVisible(true)
	end), cc.RemoveSelf:create()))
	var_59_0:addTouchEventListener(function(arg_64_0, arg_64_1)
		if arg_64_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not var_59_15 then
			return
		end

		autopop_manager:resumeAchievementPop()
		var_59_0:runAction(cc.RemoveSelf:create())
		self.panel:setVisible(true)
	end)
end
