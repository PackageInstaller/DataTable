PopEquipSkillLayer = class("PopEquipSkillLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

require("view.Sprite.ItemSprite")

local playermodel = require("model.playermodel")
local l2utils = require("controller.l2utils")
local total_skill_data = require("data.total_skill_data")
local skill_data = require("data.skill_data")
local buff_data = require("data.buff_data")
local status_data = require("data.status_data")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local core_manager = require("controller.core_manager")

function PopEquipSkillLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopEquipSkillLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopEquipSkillLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Souls_skill.json" or "Souls_skill.ExportJson")

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.rootLayer, 2)

	self.Image_Title = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_64")

	self.Image_Title:loadTexture("public/panelbg/title_skill_details.png", var_0_0)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg")

	self.rootpanel:setPositionY(GameDisplay.getScreenSize().height / 2)
	self.rootLayer:setTouchEnabled(false)
	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_4_0:isBright() then
			return
		end

		arg_4_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 0)
	self.showActions.extendVertical(self)
	self:initData(arg_3_1)
	self:initUI()
	AnalyticManager.click_pop_equip_skill_layer({
		servantid = self.servantid
	})
end

function PopEquipSkillLayer.initData(arg_6_0, arg_6_1)
	arg_6_0.servantid = arg_6_1.servantid
end

function PopEquipSkillLayer:initUI()
	local var_7_0 = 370
	local var_7_1 = 125
	local var_7_2 = 15
	local var_7_3 = 550
	local var_7_4 = 8
	local var_7_7 = playermodel.skill1Level[self.servantid]

	local function var_7_8()
		local var_8_0 = ccui.Helper:seekWidgetByName(self.rootpanel, "Panel_skillNode"):clone()

		var_8_0:setVisible(true)

		return var_8_0
	end

	local function var_7_9(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
		ccui.Helper:seekWidgetByName(arg_9_0, "Panel_lock"):setVisible(arg_9_4 == true)

		local var_9_0 = cc.Label:createWithTTF(total_skill_data[arg_9_1].description, FONT_DES, 20)

		var_9_0:setMaxLineWidth(var_7_0)
		var_9_0:setLineBreakWithoutSpace(true)

		local var_9_1 = var_9_0:getContentSize().height + 20

		if var_9_1 < 75 then
			var_9_1 = 75
		end

		local var_9_3 = 0
		local var_9_4 = {
			xp = "EquipLayer/tip_skill_xp.png",
			sp = "EquipLayer/tip_skill_sp.png"
		}

		if var_9_4[arg_9_2] then
			arg_9_0:getChildByName("Image_skilltype"):loadTexture(var_9_4[arg_9_2], var_0_0)
			arg_9_0:getChildByName("Image_skilltype"):setVisible(true)
		else
			arg_9_0:getChildByName("Image_skilltype"):setVisible(false)
		end

		local var_9_5 = {
			xp = "EquipLayer/normal_skill_frame.png"
		}

		if var_9_5[arg_9_2] then
			arg_9_0:getChildByName("Image_154"):loadTexture(var_9_5[arg_9_2], var_0_0)
		else
			arg_9_0:getChildByName("Image_154"):loadTexture("EquipLayer/common_skill_frame.png", var_0_0)
		end

		arg_9_0:getChildByName("ScrollView_34"):setInnerContainerSize(cc.size(370, var_9_1))
		arg_9_0:setContentSize(cc.size(arg_9_0:getContentSize().width, var_7_1 + var_9_3))

		local var_9_6 = arg_9_0:getChildByName("Image_154")

		arg_9_0:getChildByName("Image_icon"):setPositionY(62 + var_9_3 / 2)
		arg_9_0:getChildByName("Image_icon"):setScale(0.88)
		arg_9_0:getChildByName("Label_cd"):setPositionY(104 + var_9_3)

		if total_skill_data[arg_9_1].cd and arg_9_1 ~= model_data[global_get_servant_skin(self.servantid)].XP then
			arg_9_0:getChildByName("Label_cd"):setVisible(true)
			arg_9_0:getChildByName("Label_cd"):setString(string.format(L_SKILL_CD, total_skill_data[arg_9_1].cd))
		else
			arg_9_0:getChildByName("Label_cd"):setVisible(false)
		end

		arg_9_0:getChildByName("Label_skillName"):setPositionY(98 + var_9_3)
		arg_9_0:getChildByName("Label_cd"):setPositionY(98 + var_9_3)

		if arg_9_2 == "skill1" and var_7_7 > 0 then
			arg_9_0:getChildByName("Label_skillName"):setString(total_skill_data[arg_9_1].name .. "(+" .. var_7_7 .. ")")
		else
			arg_9_0:getChildByName("Label_skillName"):setString(total_skill_data[arg_9_1].name)
		end

		arg_9_0:getChildByName("Image_icon"):loadTexture(arg_9_3 or "skill_new/skill/" .. total_skill_data[arg_9_1].icon .. ".png", var_0_0)

		if arg_9_0:getChildByName("ScrollView_34"):getChildByName("richText") then
			arg_9_0:getChildByName("ScrollView_34"):getChildByName("richText"):removeFromParent()
		end

		local var_9_7 = arg_9_0:getChildByName("ScrollView_34"):getInnerContainer():getContentSize()
		local var_9_8 = RichTextPro:create()

		var_9_8:setMaxWidth(var_7_0)
		var_9_8:setSize(20)
		var_9_8:setColor(cc.c3b(220, 251, 241))
		var_9_8:setLineSpace(0)
		var_9_8:setText((transSkillDesToRichText(total_skill_data[arg_9_1].description)))
		var_9_8:setName("richText")
		var_9_8:setPosition(cc.p(0, var_9_7.height))
		arg_9_0:getChildByName("ScrollView_34"):addChild(var_9_8, 2)
		arg_9_0:getChildByName("Button_transparent"):setSwallowTouches(false)
		arg_9_0:getChildByName("Button_transparent"):addTouchEventListener(function(arg_10_0, arg_10_1)
			local var_10_0 = arg_10_0:getTouchEndPosition()

			if arg_10_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_10_0:getTouchBeganPosition().y - var_10_0.y) < 10 then
				local var_10_1 = self:getSkillDes(arg_9_1)

				AnalyticManager.click_pop_equip_skill_layer_skillinfo({
					servantid = self.servantid,
					total_skillid = arg_9_1
				})

				if var_10_1 and next(var_10_1) then
					self:showSkillDes(var_10_1, cc.p(var_10_0.x, var_10_0.y + 100))
				end
			end
		end)
		arg_9_0:setPosition(cc.p(var_7_2, var_7_3 - var_9_3))

		var_7_3 = var_7_3 - arg_9_0:getContentSize().height - var_7_4

		return arg_9_0
	end

	local var_7_10 = servant_data[self.servantid].modelid

	if self.rootpanel:getChildByName("sp4") then
		var_7_9(self.rootpanel:getChildByName("sp4"), model_data[servant_data[self.servantid].modelid].sp, "sp")
	else
		local var_7_11 = var_7_8()

		var_7_9(var_7_11, model_data[servant_data[self.servantid].modelid].sp, "sp")
		var_7_11:setName("sp4")
		self.rootpanel:addChild(var_7_11)
	end

	local var_7_12 = model_data[var_7_10].passive

	if self.rootpanel:getChildByName("sp3") then
		var_7_9(self.rootpanel:getChildByName("sp3"), var_7_12, "passive")
	else
		local var_7_13 = var_7_8()

		var_7_9(var_7_13, var_7_12, "passive")
		var_7_13:setName("sp3")
		self.rootpanel:addChild(var_7_13)
	end

	local var_7_14 = model_data[var_7_10]["skill1_" .. playermodel.skill1Level[self.servantid]] or 206201

	if self.rootpanel:getChildByName("sp2") then
		var_7_9(self.rootpanel:getChildByName("sp2"), var_7_14, "skill1")
	else
		local var_7_15 = var_7_8()

		var_7_9(var_7_15, var_7_14, "skill1")
		var_7_15:setName("sp2")
		self.rootpanel:addChild(var_7_15)
	end

	local var_7_16 = model_data[var_7_10].XP

	if self.rootpanel:getChildByName("sp1") then
		var_7_9(self.rootpanel:getChildByName("sp1"), var_7_16, "xp")
	else
		local var_7_17 = var_7_8()

		var_7_9(var_7_17, var_7_16, "xp")
		var_7_17:setName("sp1")
		self.rootpanel:addChild(var_7_17)
	end

	local var_7_18 = core_manager:getServantCoreRank(self.servantid) > 3 and 3 or core_manager:getServantCoreRank(self.servantid)
	local var_7_19 = model_data[var_7_10]["ex_" .. var_7_18] or model_data[var_7_10].ex_1

	if self.rootpanel:getChildByName("sp5") then
		var_7_9(self.rootpanel:getChildByName("sp5"), var_7_19, nil, "skill_new/skill/ex" .. var_7_18 .. ".png", var_7_18 == 0)
	else
		local var_7_20 = var_7_8()

		var_7_9(var_7_20, var_7_19, nil, "skill_new/skill/ex" .. var_7_18 .. ".png", var_7_18 == 0)
		var_7_20:setName("sp5")
		self.rootpanel:addChild(var_7_20)
	end
end

function PopEquipSkillLayer.getSkillDes(arg_11_0, arg_11_1)
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = {}

	while total_skill_data[arg_11_1]["skill" .. 1] do
		table.insert(var_11_0, total_skill_data[arg_11_1]["skill" .. 1])
	end

	for iter_11_0, iter_11_1 in pairs(var_11_0) do
		local var_11_4 = 1

		while skill_data[iter_11_1]["status_add" .. var_11_4] do
			table.insert(var_11_1, skill_data[iter_11_1]["status_add" .. var_11_4])

			var_11_4 = var_11_4 + 1
		end
	end

	for iter_11_2, iter_11_3 in pairs(var_11_1) do
		local var_11_5 = 1

		while status_data[iter_11_3]["value" .. var_11_5] and buff_data[status_data[iter_11_3]["value" .. var_11_5]] do
			table.insert(var_11_2, buff_data[status_data[iter_11_3]["value" .. var_11_5]].id)

			var_11_5 = var_11_5 + 1
		end
	end

	for iter_11_4, iter_11_5 in pairs(var_11_0) do
		local var_11_6 = 1

		while skill_data[iter_11_5]["buff_add" .. var_11_6] do
			table.insert(var_11_2, skill_data[iter_11_5]["buff_add" .. var_11_6])

			var_11_6 = var_11_6 + 1
		end
	end

	return var_11_2
end

function PopEquipSkillLayer.getBuffDetails(arg_12_0, arg_12_1)
	local var_12_0 = buff_data[arg_12_1].detail .. "，" .. string.format(L_BUFF_CONTANT_TIME, buff_data[arg_12_1].time)

	if buff_data[arg_12_1].appendable ~= 1 then
		var_12_0 = var_12_0 .. "，" .. string.format(L_BUFF_SUPERPOSITION, buff_data[arg_12_1].appendable)
	end

	return var_12_0
end

function PopEquipSkillLayer.getBuffName(arg_13_0, arg_13_1)
	return buff_data[arg_13_1].name
end

function PopEquipSkillLayer.getBuffImage(arg_14_0, arg_14_1)
	return buff_data[arg_14_1].buff_image
end

function PopEquipSkillLayer:showSkillDes(arg_15_1, arg_15_2)
	local var_15_0 = ccui.Layout:create()

	var_15_0:setTouchEnabled(true)
	var_15_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_15_0:setAnchorPoint(cc.p(0, 0))
	var_15_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_15_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_15_0:setBackGroundColorOpacity(140)
	var_15_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_15_0:setTouchEnabled(true)
	self:addChild(var_15_0, 100)
	var_15_0:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_15_0:runAction(cc.RemoveSelf:create())
	end)

	local var_15_1 = ccui.ImageView:create("EquipLayer/popup_buff_details.png", var_0_0)

	var_15_1:setPosition(cc.p(320, arg_15_2.y))
	var_15_1:setScale9Enabled(true)
	var_15_1:setCapInsets(cc.rect(20, 20, 20, 20))
	var_15_0:addChild(var_15_1)

	local var_15_2 = 370
	local var_15_3 = var_15_1:getContentSize().height
	local var_15_4 = cc.Label:createWithTTF("", FONT_DES, 24)

	var_15_4:setMaxLineWidth(370)
	var_15_4:setVisible(false)
	var_15_0:addChild(var_15_4)

	local var_15_5 = 0

	for iter_15_0, iter_15_1 in pairs(arg_15_1) do
		var_15_5 = var_15_5 + 26

		var_15_4:setString(self:getBuffDetails(iter_15_1))

		var_15_5 = var_15_5 + var_15_4:getContentSize().height + 6
	end

	if var_15_3 < var_15_5 then
		var_15_1:setContentSize(cc.size(var_15_1:getContentSize().width, var_15_5))
	else
		var_15_5 = var_15_3
	end

	for iter_15_2, iter_15_3 in pairs(arg_15_1) do
		local var_15_7 = cc.Label:createWithTTF(self:getBuffName(iter_15_3), FONT_DES, 24)

		var_15_7:setAnchorPoint(cc.p(0, 1))
		var_15_7:setColor(cc.c3b(64, 240, 95))
		var_15_7:setPosition(cc.p(60, var_15_5))
		var_15_1:addChild(var_15_7)

		var_15_5 = var_15_5 - 26

		local var_15_8 = cc.Label:createWithTTF(self:getBuffDetails(iter_15_3), FONT_DES, 24)

		var_15_8:setColor(cc.c3b(220, 235, 241))
		var_15_8:setAnchorPoint(cc.p(0, 1))
		var_15_8:setMaxLineWidth(var_15_2)
		var_15_8:setPosition(cc.p(4, var_15_5))
		var_15_8:setVisible(false)
		var_15_1:addChild(var_15_8)

		local var_15_9 = transSkillDesToRichText(self:getBuffDetails(iter_15_3))
		local var_15_10 = RichTextPro:create()

		var_15_10:setMaxWidth(var_15_2)
		var_15_10:setSize(24)
		var_15_10:setColor(cc.c3b(220, 251, 241))
		var_15_10:setLineSpace(0)
		var_15_10:setText(var_15_9)
		var_15_10:setPosition(cc.p(60, var_15_5))
		var_15_1:addChild(var_15_10)

		var_15_5 = var_15_5 - var_15_8:getContentSize().height
		var_15_5 = var_15_5 - 6

		local var_15_11 = ccui.ImageView:create("skill_new/skill/" .. self:getBuffImage(iter_15_3) .. ".png", var_0_0)

		var_15_11:setPositionX(32)
		var_15_11:setPositionY((var_15_5 + var_15_5) / 2)
		var_15_11:setScale(0.5)
		var_15_1:addChild(var_15_11)
	end
end

function PopEquipSkillLayer:initBg(arg_17_1)
	local var_17_0 = ccui.Layout:create()

	var_17_0:setTouchEnabled(true)
	var_17_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_17_0:setAnchorPoint(cc.p(0, 0))
	var_17_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_17_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_17_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_17_0:setOpacity(0)
	self:addChild(var_17_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_18_0)
		self:addChild(arg_18_0, -2)
		arg_18_0:setPositionY(arg_18_0:getPositionY() - GameDisplay.fix_y)

		local var_18_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_18_0:setAnchorPoint(cc.p(0, 0))
		var_18_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_18_0, -1)
		self:init(arg_17_1)
		var_17_0:setOpacity(102)
		var_17_0:setTouchEnabled(false)
	end)
end

function PopEquipSkillLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end
