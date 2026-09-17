PopskillDetailLayer = class("PopskillDetailLayer", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")

local playermodel = require("model.playermodel")
local total_skill_data = require("data.total_skill_data")
local skill_data = require("data.skill_data")
local buff_data = require("data.buff_data")
local status_data = require("data.status_data")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local core_manager = require("controller.core_manager")
local var_0_8 = config._DEBUG and 0 or 1
local var_0_9 = 420

function PopskillDetailLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopskillDetailLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopskillDetailLayer:init(arg_3_1)
	self:initData(arg_3_1)
	self:initUI()
	self:initTitle()
	self:initBottomBtnList()
	self:fullScreen()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" and self.callback then
			self.callback()
		end
	end)
end

function PopskillDetailLayer:initTitle()
	local var_5_0 = TitleSprite:create("public/title/title_skill_detail.png", 2)

	var_5_0.title:setPositionX(0)
	var_5_0:setAnchorPoint(cc.p(0, 1))
	var_5_0:setPosition(0, GameDisplay.height)
	var_5_0:setName("titleBg")
	self.rootLayer:addChild(var_5_0, 5)
end

function PopskillDetailLayer:initBottomBtnList()
	local function var_6_0()
		local var_7_0 = self.rootLayer:getChildByName("titleBg")

		var_7_0:runAction(cc.MoveTo:create(0.2, cc.p(var_7_0:getPositionX(), var_7_0:getPositionY() + var_7_0:getContentSize().height)))
		self.bottomlist:runAction(cc.MoveTo:create(0.2, cc.p(self.bottomlist:getPositionX(), self.bottomlist:getPositionY() - self.bottomlist:getContentSize().height)))
		self.listView:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
			LayerManager:removePopLayer(self.__queueindex)
		end)))
	end

	self.bottomlist = BottomBtnList:create(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_6_0 then
			var_6_0()
		end
	end, {})

	self:addChild(self.bottomlist, 5)
end

function PopskillDetailLayer.initData(arg_10_0, arg_10_1)
	arg_10_0.returnLayer = arg_10_1.returnLayer
	arg_10_0.servantid = arg_10_1.servantid
end

function PopskillDetailLayer:initUI()
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.rootLayer:setBackGroundColor(cc.c3b(0, 0, 0))
	self.rootLayer:setBackGroundColorOpacity(0)
	self:addChild(self.rootLayer)

	local var_11_0 = ccui.ImageView:create("mainScenebg/equip_skillinfo_bg.png")

	var_11_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_11_0:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, self.rootLayer:getContentSize().height / 2))
	self.rootLayer:addChild(var_11_0)

	self.listView = ccui.ListView:create()

	self.listView:setName("listView")
	self.listView:setAnchorPoint(cc.p(0.5, 0.5))
	self.listView:setContentSize(cc.size(self.rootLayer:getContentSize().width - 40, self.rootLayer:getContentSize().height - 120))
	self.listView:setDirection(ccui.ListViewDirection.vertical)
	self.listView:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, self.rootLayer:getContentSize().height / 2))
	self.rootLayer:addChild(self.listView, 99)
	self.listView:setBounceEnabled(true)
	self:setSkillDes()
end

function PopskillDetailLayer:setSkillDes()
	local var_12_1 = servant_data[self.servantid].modelid
	local var_12_2 = self:createSkillSp()

	self:updateSkillSp(var_12_2, model_data[servant_data[self.servantid].modelid].sp, "sp")
	var_12_2:setName("sp4")
	self.listView:pushBackCustomItem(var_12_2)

	local var_12_3 = self:createSkillSp()

	self:updateSkillSp(var_12_3, model_data[var_12_1].passive, "passive")
	var_12_3:setName("sp3")
	self.listView:pushBackCustomItem(var_12_3)

	local var_12_4 = model_data[var_12_1]["skill1_" .. playermodel.skill1Level[self.servantid]] or 206201
	local var_12_5 = self:createSkillSp()

	self:updateSkillSp(var_12_5, var_12_4, "skill1")
	var_12_5:setName("sp2")
	self.listView:pushBackCustomItem(var_12_5)

	local var_12_6

	if model_data[servant_data[self.servantid].modelid].upgrade_skill_3 or model_data[servant_data[self.servantid].modelid].upgrade_skill_5 then
		self.listView:pushBackCustomItem((self:createUpgradeSkill()))

		var_12_6 = self:createSkillSp()
	end

	self:updateSkillSp(var_12_6, model_data[var_12_1].XP, "xp")
	var_12_6:setName("sp1")
	self.listView:pushBackCustomItem(var_12_6)

	local var_12_7

	if core_manager:getServantCoreRank(self.servantid) > SERVANT_CORE_BREAK_MAX then
		var_12_7 = SERVANT_CORE_BREAK_MAX or core_manager:getServantCoreRank(self.servantid)
	end

	local var_12_12
	local var_12_11
	local var_12_10
	local var_12_9

	if not model_data[var_12_1]["ex_" .. var_12_7] then
		var_12_9 = self:createSkillSp()
		var_12_10 = var_12_9
		var_12_11 = model_data[var_12_1]["ex_" .. var_12_7]
		var_12_12 = "ex"
	end

	self:updateSkillSp(var_12_10, var_12_11, var_12_12, "skill_new/skill/ex" .. var_12_7 .. ".png", var_12_7 == 0)
	var_12_9:setName("sp5")
	self.listView:pushBackCustomItem(var_12_9)

	local var_12_13 = playermodel.soulOverClock[self.servantid]

	if model_data[var_12_1].over_clocking_skill and not playermodel:isServantOverclockLockByTime(self.servantid) then
		local var_12_14 = self:createSkillSp()

		self:updateSkillSp(var_12_14, model_data[var_12_1].over_clocking_skill, "oc", nil, not var_12_13 or var_12_13 < 1)
		var_12_14:setName("sp6")
		var_12_14:getChildByName("skillLine"):setVisible(false)
		self.listView:pushBackCustomItem(var_12_14)
	end
end

function PopskillDetailLayer.createSkillSp(arg_13_0)
	local var_13_0 = ccui.Layout:create()

	var_13_0:setAnchorPoint(cc.p(0, 0))

	local var_13_1 = ccui.ImageView:create("EquipLayer/common_skill_frame.png", var_0_8)

	var_13_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_13_1:setName("skillbg")
	var_13_0:addChild(var_13_1)

	local var_13_2 = ccui.ImageView:create("skill_new/skill/20100.png", var_0_8)

	var_13_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_13_2:setPosition(cc.p(var_13_1:getPositionX(), var_13_1:getPositionY()))
	var_13_2:setName("Image_icon")
	var_13_0:addChild(var_13_2)

	local var_13_3 = cc.Label:createWithTTF("", FONT_W5, 21)

	var_13_3:setAnchorPoint(cc.p(0, 1))
	var_13_3:setColor(cc.c3b(0, 255, 6))
	var_13_3:setName("Label_skillName")
	var_13_0:addChild(var_13_3)

	local var_13_4 = cc.Label:createWithTTF("", FONT_DES, 20)

	var_13_4:setAnchorPoint(cc.p(1, 1))
	var_13_4:setName("Label_cd")
	var_13_0:addChild(var_13_4)

	local var_13_5 = ccui.ImageView:create("EquipLayer/tip_skill_xp.png", var_0_8)

	var_13_5:setAnchorPoint(cc.p(1, 0))
	var_13_5:setName("Image_skilltype")
	var_13_0:addChild(var_13_5)

	local var_13_6 = ccui.ImageView:create("EquipLayer/skill_line.png", var_0_8)

	var_13_6:setAnchorPoint(cc.p(0, 0))
	var_13_6:setName("skillLine")
	var_13_0:addChild(var_13_6)

	local var_13_7 = ccui.Layout:create()

	var_13_7:setName("Panel_lock")
	var_13_7:setAnchorPoint(cc.p(0.5, 0.5))
	var_13_7:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_13_7:setBackGroundColor(cc.c3b(0, 0, 0))
	var_13_7:setBackGroundColorOpacity(180)
	var_13_0:addChild(var_13_7, 10)
	var_13_7:setVisible(false)

	local var_13_8 = ccui.ImageView:create("public/currency/lock.png", var_0_8)

	var_13_8:setAnchorPoint(cc.p(1, 1))
	var_13_8:setName("lockTip")
	var_13_7:addChild(var_13_8)

	local var_13_9 = cc.Label:createWithTTF("", FONT_DES, 26)

	var_13_9:setAnchorPoint(cc.p(1, 1))
	var_13_9:setName("lockDes")
	var_13_7:addChild(var_13_9)

	local var_13_10 = ccui.Button:create("public/box/UI_touming.png", "public/box/UI_touming.png", "public/box/UI_touming.png", var_0_8)

	var_13_10:setName("Button_transparent")
	var_13_10:setScale9Enabled(true)
	var_13_10:setAnchorPoint(cc.p(0, 0))
	var_13_0:addChild(var_13_10)

	return var_13_0
end

function PopskillDetailLayer:createUpgradeSkill()
	local var_14_0 = {
		nil,
		nil,
		nil,
		"超快",
		"快",
		"标准"
	}
	local var_14_1 = servant_data[self.servantid].modelid
	local var_14_2 = model_data[servant_data[self.servantid].modelid].upgrade_skill_3
	local var_14_3 = ccui.Layout:create()

	var_14_3:setAnchorPoint(cc.p(0, 0))

	local var_14_4 = 0
	local var_14_5 = 0
	local var_14_6 = 0
	local var_14_7 = 0
	local var_14_8
	local var_14_9
	local var_14_10 = playermodel.soulContract[self.servantid]

	if var_14_2 then
		var_14_8 = RichTextPro:create()

		var_14_8:setMaxWidth(200)
		var_14_8:setSize(24)
		var_14_8:setColor(cc.c3b(220, 251, 241))
		var_14_8:setLineSpace(0)
		var_14_8:setText((transSkillDesToRichText(total_skill_data[var_14_2].description)))
		var_14_8:setName("richText1")
		var_14_3:addChild(var_14_8, 2)
	end

	if model_data[servant_data[self.servantid].modelid].upgrade_skill_5 then
		var_14_9 = RichTextPro:create()

		var_14_9:setMaxWidth(210)
		var_14_9:setSize(24)
		var_14_9:setColor(cc.c3b(220, 251, 241))
		var_14_9:setLineSpace(0)
		var_14_9:setText((transSkillDesToRichText(total_skill_data[model_data[servant_data[self.servantid].modelid].upgrade_skill_5].description)))
		var_14_9:setName("richText2")
		var_14_3:addChild(var_14_9, 2)
	end

	if var_14_2 then
		var_14_4, var_14_5 = var_14_8:getContentSize()
	end

	local var_14_11 = var_14_5 + 120

	if model_data[servant_data[self.servantid].modelid].upgrade_skill_5 then
		var_14_6, var_14_7 = var_14_9:getContentSize()
	end

	local var_14_12 = math.max(var_14_11, var_14_7 + 120)

	var_14_3:setContentSize(cc.size(self.listView:getContentSize().width, var_14_12))

	if var_14_2 then
		var_14_8:setPosition(cc.p(160, var_14_3:getContentSize().height - 70))
	end

	if model_data[servant_data[self.servantid].modelid].upgrade_skill_5 then
		var_14_9:setPosition(cc.p(380, var_14_3:getContentSize().height - 70))
	end

	local var_14_13 = ccui.Layout:create()

	var_14_13:setName("panel_lock")
	var_14_13:setAnchorPoint(cc.p(0.5, 0.5))
	var_14_13:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_14_13:setBackGroundColor(cc.c3b(0, 0, 0))
	var_14_13:setBackGroundColorOpacity(180)
	var_14_13:setContentSize(cc.size(var_0_9 + 30, var_14_12 - 40))
	var_14_13:setPosition(cc.p(160 + var_14_13:getContentSize().width / 2 - 15, var_14_3:getContentSize().height / 2 + 10))
	var_14_13:setVisible(false)
	var_14_3:addChild(var_14_13, 10)

	local var_14_14 = ccui.ImageView:create("EquipLayer/up_grade_skill.png", var_0_8)

	var_14_14:setAnchorPoint(cc.p(0.5, 0.5))
	var_14_14:setName("Image_icon")
	var_14_14:setPosition(cc.p(70, var_14_3:getContentSize().height - var_14_14:getContentSize().height / 2 - 60))
	var_14_3:addChild(var_14_14)

	local var_14_15 = cc.Label:createWithTTF("", FONT_DES, 20)

	var_14_15:setAnchorPoint(cc.p(0, 1))
	var_14_15:setName("Label_cd1")
	var_14_15:setVisible(false)
	var_14_15:setPosition(cc.p(250, var_14_3:getContentSize().height - 30))
	var_14_3:addChild(var_14_15)

	if var_14_2 then
		local var_14_16 = ccui.ImageView:create("public/currency/lock.png", var_0_8)

		var_14_16:setAnchorPoint(cc.p(1, 1))
		var_14_16:setName("lockTip")
		var_14_13:addChild(var_14_16)

		local var_14_17 = cc.Label:createWithTTF("3振次后获取", FONT_DES, 26)

		var_14_17:setAnchorPoint(cc.p(1, 1))
		var_14_17:setName("lockDes")
		var_14_13:addChild(var_14_17)
		var_14_17:setPosition(cc.p(var_14_13:getContentSize().width - 10, var_14_13:getContentSize().height - 10))
		var_14_16:setPosition(cc.p(var_14_13:getContentSize().width - var_14_17:getContentSize().width - 10, var_14_13:getContentSize().height))
		var_14_13:setVisible(var_14_10 < 3)

		if total_skill_data[var_14_2].cd and var_14_2 ~= model_data[var_14_1].XP then
			var_14_15:setVisible(true)
			var_14_15:setString(L_SKILL_CD .. ":" .. (var_14_0[total_skill_data[var_14_2].cd] or var_14_0[6]))
		end

		local var_14_18 = ccui.ImageView:create("EquipLayer/up_grade3_skill.png", var_0_8)

		var_14_18:setAnchorPoint(cc.p(0, 1))
		var_14_18:setName("Image_skill1type1")
		var_14_18:setPosition(cc.p(160, var_14_3:getContentSize().height - 20))
		var_14_3:addChild(var_14_18)

		local var_14_19 = ccui.ImageView:create("EquipLayer/skill_line.png", var_0_8)

		var_14_19:setAnchorPoint(cc.p(0, 0))
		var_14_19:setName("skillLine")
		var_14_3:addChild(var_14_19)

		local var_14_20 = ccui.Layout:create()

		var_14_20:setName("Panel_lock1")
		var_14_20:setAnchorPoint(cc.p(0.5, 0.5))
		var_14_20:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_14_20:setBackGroundColor(cc.c3b(0, 0, 0))
		var_14_20:setBackGroundColorOpacity(180)
		var_14_3:addChild(var_14_20, 10)
		var_14_20:setVisible(false)

		local var_14_21 = ccui.ImageView:create("public/currency/lock.png", var_0_8)

		var_14_21:setAnchorPoint(cc.p(1, 1))
		var_14_21:setName("lockTip1")
		var_14_20:addChild(var_14_21)

		local var_14_22 = cc.Label:createWithTTF("", FONT_DES, 26)

		var_14_22:setAnchorPoint(cc.p(1, 1))
		var_14_22:setName("lockDes1")
		var_14_20:addChild(var_14_22)

		local var_14_23 = ccui.Button:create("public/box/UI_touming.png", "public/box/UI_touming.png", "public/box/UI_touming.png", var_0_8)

		var_14_23:setName("Button_transparent1")
		var_14_23:setScale9Enabled(true)
		var_14_23:setAnchorPoint(cc.p(0, 1))
		var_14_23:setContentSize(var_14_4, var_14_5)
		var_14_23:setPositionX(var_14_8:getPositionX())
		var_14_23:setPositionY(var_14_8:getPositionY())
		var_14_23:addTouchEventListener(function(arg_15_0, arg_15_1)
			local var_15_0 = arg_15_0:getTouchEndPosition()

			if arg_15_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_15_0:getTouchBeganPosition().y - var_15_0.y) < 10 then
				local var_15_1 = self:getSkillDes(var_14_2)

				AnalyticManager.click_pop_equip_skill_layer_skillinfo({
					servantid = self.servantid,
					total_skillid = var_14_2
				})

				if var_15_1 and next(var_15_1) then
					self:showSkillDes(var_15_1, cc.p(var_15_0.x, var_15_0.y + 100))
				end
			end
		end)
		var_14_3:addChild(var_14_23, 100)
	end

	if model_data[servant_data[self.servantid].modelid].upgrade_skill_5 then
		local var_14_24 = cc.Label:createWithTTF("", FONT_DES, 20)

		var_14_24:setAnchorPoint(cc.p(0, 1))
		var_14_24:setName("Label_cd2")
		var_14_24:setPosition(cc.p(470, var_14_3:getContentSize().height - 30))
		var_14_3:addChild(var_14_24)

		if total_skill_data[model_data[servant_data[self.servantid].modelid].upgrade_skill_5].cd and model_data[servant_data[self.servantid].modelid].upgrade_skill_5 ~= model_data[var_14_1].XP then
			var_14_24:setVisible(true)
			var_14_24:setString(L_SKILL_CD .. ":" .. (var_14_0[total_skill_data[model_data[servant_data[self.servantid].modelid].upgrade_skill_5].cd] or var_14_0[6]))
		end

		local var_14_25 = ccui.ImageView:create("EquipLayer/up_grade5_skill.png", var_0_8)

		var_14_25:setAnchorPoint(cc.p(0, 1))
		var_14_25:setName("Image_skilltype2")
		var_14_25:setPosition(cc.p(380, var_14_3:getContentSize().height - 20))
		var_14_3:addChild(var_14_25)

		local var_14_26 = ccui.Layout:create()

		var_14_26:setName("Panel_lock2")
		var_14_26:setAnchorPoint(cc.p(0.5, 0.5))
		var_14_26:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_14_26:setBackGroundColor(cc.c3b(0, 0, 0))
		var_14_26:setBackGroundColorOpacity(180)
		var_14_26:setContentSize(cc.size(var_0_9 / 2 + 30, var_14_12 - 40))
		var_14_26:setPosition(cc.p(var_14_9:getPositionX() + var_14_26:getContentSize().width / 2 - 15, var_14_3:getContentSize().height / 2 + 10))
		var_14_3:addChild(var_14_26, 10)
		var_14_26:setVisible(false)

		local var_14_27 = ccui.ImageView:create("public/currency/lock.png", var_0_8)

		var_14_27:setAnchorPoint(cc.p(1, 1))
		var_14_27:setName("lockTip2")
		var_14_26:addChild(var_14_27)

		local var_14_28 = cc.Label:createWithTTF("5振次后获取", FONT_DES, 26)

		var_14_28:setAnchorPoint(cc.p(1, 1))
		var_14_28:setName("lockDes2")
		var_14_26:addChild(var_14_28)
		var_14_28:setPosition(cc.p(var_14_26:getContentSize().width - 10, var_14_26:getContentSize().height - 10))
		var_14_27:setPosition(cc.p(var_14_26:getContentSize().width - var_14_28:getContentSize().width - 10, var_14_26:getContentSize().height))

		local var_14_29 = ccui.Button:create("public/box/UI_touming.png", "public/box/UI_touming.png", "public/box/UI_touming.png", var_0_8)

		var_14_29:setName("Button_transparent2")
		var_14_29:setScale9Enabled(true)
		var_14_29:setAnchorPoint(cc.p(0, 1))
		var_14_29:setContentSize(var_14_6, var_14_7)
		var_14_29:setPositionX(var_14_9:getPositionX())
		var_14_29:setPositionY(var_14_9:getPositionY())
		var_14_29:addTouchEventListener(function(arg_16_0, arg_16_1)
			local var_16_0 = arg_16_0:getTouchEndPosition()

			if arg_16_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_16_0:getTouchBeganPosition().y - var_16_0.y) < 10 then
				local var_16_1 = self:getSkillDes(var_14_2)

				AnalyticManager.click_pop_equip_skill_layer_skillinfo({
					servantid = self.servantid,
					total_skillid = var_14_2
				})

				if var_16_1 and next(var_16_1) then
					self:showSkillDes(var_16_1, cc.p(var_16_0.x, var_16_0.y + 100))
				end
			end
		end)
		var_14_3:addChild(var_14_29, 100)

		if var_14_2 then
			var_14_26:setVisible(var_14_10 >= 3 and var_14_10 < 5)
		else
			var_14_13:setVisible(var_14_10 < 5)
			var_14_26:setVisible(false)

			local var_14_30 = ccui.ImageView:create("public/currency/lock.png", var_0_8)

			var_14_30:setAnchorPoint(cc.p(1, 1))
			var_14_30:setName("lockTip")
			var_14_13:addChild(var_14_30)

			local var_14_31 = cc.Label:createWithTTF("5振次后获取", FONT_DES, 26)

			var_14_31:setAnchorPoint(cc.p(1, 1))
			var_14_31:setName("lockDes")
			var_14_13:addChild(var_14_31)
			var_14_28:setPosition(cc.p(var_14_13:getContentSize().width - 10, var_14_13:getContentSize().height - 10))
			var_14_27:setPosition(cc.p(var_14_13:getContentSize().width - var_14_28:getContentSize().width - 10, var_14_13:getContentSize().height))
		end
	end

	return var_14_3
end

function PopskillDetailLayer:updateSkillSp(arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	local var_17_0 = playermodel.skill1Level[self.servantid]
	local var_17_1 = var_0_9

	ccui.Helper:seekWidgetByName(arg_17_1, "Panel_lock"):setVisible(arg_17_5)
	ccui.Helper:seekWidgetByName(arg_17_1, "Panel_lock"):getChildByName("lockDes"):setString(({
		ex = L_SKILL_BK_GET,
		oc = L_SKILL_OC_GET
	})[arg_17_3])

	local var_17_2 = cc.Label:createWithTTF(total_skill_data[arg_17_2].description, FONT_W5, 20)

	var_17_2:setMaxLineWidth(var_17_1)
	var_17_2:setLineBreakWithoutSpace(true)
	var_17_2:setColor(cc.c3b(211, 200, 255))

	if var_17_2:getContentSize().height + 20 < 75 then
		-- block empty
	end

	local var_17_4 = 0
	local var_17_5 = {
		oc = "EquipLayer/tip_skill_oc.png",
		xp = "EquipLayer/tip_skill_xp.png",
		sp = "EquipLayer/tip_skill_sp.png"
	}

	if var_17_5[arg_17_3] then
		arg_17_1:getChildByName("Image_skilltype"):loadTexture(var_17_5[arg_17_3], var_0_8)
		arg_17_1:getChildByName("Image_skilltype"):setVisible(true)
	else
		arg_17_1:getChildByName("Image_skilltype"):setVisible(false)
	end

	local var_17_6 = {
		xp = "EquipLayer/normal_skill_frame.png"
	}

	if var_17_6[arg_17_3] then
		arg_17_1:getChildByName("skillbg"):loadTexture(var_17_6[arg_17_3], var_0_8)
	else
		arg_17_1:getChildByName("skillbg"):loadTexture("EquipLayer/common_skill_frame.png", var_0_8)
	end

	local var_17_7 = arg_17_1:getChildByName("skillbg")

	arg_17_1:getChildByName("Image_icon"):setScale(0.84)
	arg_17_1:getChildByName("Image_icon"):setScale(0.84)

	if total_skill_data[arg_17_2].cd and arg_17_2 ~= model_data[servant_data[self.servantid].modelid].XP then
		local var_17_8 = {
			nil,
			nil,
			nil,
			"超快",
			"快",
			"标准"
		}

		arg_17_1:getChildByName("Label_cd"):setVisible(true)
		arg_17_1:getChildByName("Label_cd"):setString(L_SKILL_CD .. ":" .. (var_17_8[total_skill_data[arg_17_2].cd] or var_17_8[6]))
	end

	if arg_17_2 == model_data[servant_data[self.servantid].modelid].XP then
		local var_17_9 = {
			{
				name = "少",
				key = 90
			},
			{
				name = "标准",
				key = 120
			},
			{
				name = "多",
				key = 150
			}
		}
		local var_17_10 = var_17_9[1].name

		for iter_17_0, iter_17_1 in pairs(var_17_9) do
			if model_data[servant_data[self.servantid].modelid].maxrage >= iter_17_1.key then
				var_17_10 = iter_17_1.name
			end
		end

		arg_17_1:getChildByName("Label_cd"):setVisible(true)
		arg_17_1:getChildByName("Label_cd"):setString("需要能量:" .. var_17_10)
	end

	if arg_17_3 == "skill1" and var_17_0 > 0 then
		arg_17_1:getChildByName("Label_skillName"):setString(total_skill_data[arg_17_2].name .. "(+" .. var_17_0 .. ")")
	else
		arg_17_1:getChildByName("Label_skillName"):setString(total_skill_data[arg_17_2].name)
	end

	arg_17_1:getChildByName("Image_icon"):loadTexture(arg_17_4 or "skill_new/skill/" .. (total_skill_data[arg_17_2].icon or 22822) .. ".png", var_0_8)

	local var_17_11 = RichTextPro:create()

	var_17_11:setMaxWidth(var_17_1)
	var_17_11:setSize(24)
	var_17_11:setColor(cc.c3b(220, 251, 241))
	var_17_11:setLineSpace(0)
	var_17_11:setText((transSkillDesToRichText(total_skill_data[arg_17_2].description)))
	var_17_11:setName("richText")
	arg_17_1:addChild(var_17_11, 2)
	arg_17_1:getChildByName("Button_transparent"):setSwallowTouches(false)
	arg_17_1:getChildByName("Button_transparent"):addTouchEventListener(function(arg_18_0, arg_18_1)
		local var_18_0 = arg_18_0:getTouchEndPosition()

		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_18_0:getTouchBeganPosition().y - var_18_0.y) < 10 then
			local var_18_1 = self:getSkillDes(arg_17_2)

			AnalyticManager.click_pop_equip_skill_layer_skillinfo({
				servantid = self.servantid,
				total_skillid = arg_17_2
			})

			if var_18_1 and next(var_18_1) then
				self:showSkillDes(var_18_1, cc.p(var_18_0.x, var_18_0.y + 100))
			end
		end
	end)
	self:resetUISize(arg_17_1, var_17_4)

	return arg_17_1
end

function PopskillDetailLayer:resetUISize(arg_19_1, arg_19_2)
	local var_19_0 = arg_19_1:getChildByName("skillbg")
	local var_19_1 = arg_19_1:getChildByName("richText")
	local var_19_2 = arg_19_1:getChildByName("Panel_lock")
	local var_19_3, var_19_4 = var_19_1:getContentSize()

	arg_19_1:setContentSize(cc.size(self.listView:getContentSize().width, var_19_4 + 120))
	var_19_0:setPosition(cc.p(70, arg_19_1:getContentSize().height - var_19_0:getContentSize().height / 2 - 20))
	arg_19_1:getChildByName("Image_icon"):setPosition(cc.p(70, var_19_0:getPositionY() + arg_19_2))
	arg_19_1:getChildByName("Image_skilltype"):setPosition(cc.p(70 + var_19_0:getContentSize().width / 2, var_19_0:getPositionY() - var_19_0:getContentSize().height / 2 + 5))
	arg_19_1:getChildByName("Label_skillName"):setPosition(cc.p(70 + 90, arg_19_1:getContentSize().height - 20))
	arg_19_1:getChildByName("Label_cd"):setPosition(cc.p(arg_19_1:getContentSize().width - 30, arg_19_1:getContentSize().height - 25))
	var_19_1:setPosition(cc.p(70 + 90, arg_19_1:getContentSize().height - 70))
	arg_19_1:getChildByName("Button_transparent"):setContentSize(cc.size(arg_19_1:getContentSize().width, arg_19_1:getContentSize().height))
	arg_19_1:getChildByName("skillLine"):setPosition(cc.p(0, 5))
	var_19_2:setContentSize(cc.size(var_0_9 + 30, var_19_4 + 60))
	var_19_2:setPosition(cc.p(var_19_1:getPositionX() + var_19_2:getContentSize().width / 2 - 15, var_19_1:getPositionY() - var_19_4 / 2 + 25))
	var_19_2:getChildByName("lockDes"):setPosition(cc.p(var_19_2:getContentSize().width - 10, var_19_2:getContentSize().height - 10))
	var_19_2:getChildByName("lockTip"):setPosition(cc.p(var_19_2:getContentSize().width - var_19_2:getChildByName("lockDes"):getContentSize().width - 10, var_19_2:getContentSize().height))
end

function PopskillDetailLayer.getSkillDes(arg_20_0, arg_20_1)
	local var_20_0 = {}
	local var_20_1 = {}
	local var_20_2 = {}
	local var_20_3 = {}

	while total_skill_data[arg_20_1]["skill" .. 1] do
		table.insert(var_20_0, total_skill_data[arg_20_1]["skill" .. 1])
	end

	for iter_20_0, iter_20_1 in pairs(var_20_0) do
		local var_20_5 = 1

		while skill_data[iter_20_1]["status_add" .. var_20_5] do
			table.insert(var_20_1, skill_data[iter_20_1]["status_add" .. var_20_5])

			var_20_5 = var_20_5 + 1
		end
	end

	for iter_20_2, iter_20_3 in pairs(var_20_1) do
		local var_20_6 = 1

		while status_data[iter_20_3]["value" .. var_20_6] and buff_data[status_data[iter_20_3]["value" .. var_20_6]] do
			if not var_20_3[buff_data[status_data[iter_20_3]["value" .. var_20_6]].id] and buff_data[buff_data[status_data[iter_20_3]["value" .. var_20_6]].id].image_show ~= 0 then
				table.insert(var_20_2, buff_data[status_data[iter_20_3]["value" .. var_20_6]].id)

				var_20_3[buff_data[status_data[iter_20_3]["value" .. var_20_6]].id] = true
			end

			var_20_6 = var_20_6 + 1
		end
	end

	for iter_20_4, iter_20_5 in pairs(var_20_0) do
		local var_20_7 = 1

		while skill_data[iter_20_5]["buff_add" .. var_20_7] do
			if not var_20_3[skill_data[iter_20_5]["buff_add" .. var_20_7]] and buff_data[skill_data[iter_20_5]["buff_add" .. var_20_7]].image_show ~= 0 then
				table.insert(var_20_2, skill_data[iter_20_5]["buff_add" .. var_20_7])

				var_20_3[skill_data[iter_20_5]["buff_add" .. var_20_7]] = true
			end

			var_20_7 = var_20_7 + 1
		end
	end

	return var_20_2
end

function PopskillDetailLayer.getBuffDetails(arg_21_0, arg_21_1)
	local var_21_0 = buff_data[arg_21_1].detail .. "，" .. string.format(L_BUFF_CONTANT_TIME, buff_data[arg_21_1].time)

	if buff_data[arg_21_1].appendable ~= 1 then
		var_21_0 = var_21_0 .. "，" .. string.format(L_BUFF_SUPERPOSITION, buff_data[arg_21_1].appendable)
	end

	return var_21_0
end

function PopskillDetailLayer.getBuffName(arg_22_0, arg_22_1)
	return buff_data[arg_22_1].name
end

function PopskillDetailLayer.getBuffImage(arg_23_0, arg_23_1)
	return buff_data[arg_23_1].buff_image
end

function PopskillDetailLayer:showSkillDes(arg_24_1, arg_24_2)
	local var_24_0 = ccui.Layout:create()

	var_24_0:setTouchEnabled(true)
	var_24_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_24_0:setAnchorPoint(cc.p(0, 0))
	var_24_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_24_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_24_0:setBackGroundColorOpacity(140)
	var_24_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_24_0:setTouchEnabled(true)
	self:addChild(var_24_0, 100)
	var_24_0:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_24_0:runAction(cc.RemoveSelf:create())
	end)

	local var_24_1 = ccui.ImageView:create("EquipLayer/popup_buff_details.png", var_0_8)

	var_24_1:setPosition(cc.p(320, arg_24_2.y))
	var_24_1:setScale9Enabled(true)
	var_24_1:setCapInsets(cc.rect(20, 20, 20, 20))
	var_24_0:addChild(var_24_1)

	local var_24_2 = 370
	local var_24_3 = var_24_1:getContentSize().height
	local var_24_4 = cc.Label:createWithTTF("", FONT_DES, 24)

	var_24_4:setMaxLineWidth(370)
	var_24_4:setVisible(false)
	var_24_0:addChild(var_24_4)

	local var_24_5 = 0

	for iter_24_0, iter_24_1 in pairs(arg_24_1) do
		var_24_5 = var_24_5 + 26

		var_24_4:setString(self:getBuffDetails(iter_24_1))

		var_24_5 = var_24_5 + var_24_4:getContentSize().height + 6
	end

	if var_24_3 < var_24_5 then
		var_24_1:setContentSize(cc.size(var_24_1:getContentSize().width, var_24_5))
	else
		var_24_5 = var_24_3
	end

	for iter_24_2, iter_24_3 in pairs(arg_24_1) do
		local var_24_7 = cc.Label:createWithTTF(self:getBuffName(iter_24_3), FONT_DES, 24)

		var_24_7:setAnchorPoint(cc.p(0, 1))
		var_24_7:setColor(cc.c3b(64, 240, 95))
		var_24_7:setPosition(cc.p(60, var_24_5))
		var_24_1:addChild(var_24_7)

		var_24_5 = var_24_5 - 26

		local var_24_8 = cc.Label:createWithTTF(self:getBuffDetails(iter_24_3), FONT_DES, 24)

		var_24_8:setColor(cc.c3b(220, 235, 241))
		var_24_8:setAnchorPoint(cc.p(0, 1))
		var_24_8:setMaxLineWidth(var_24_2)
		var_24_8:setPosition(cc.p(4, var_24_5))
		var_24_8:setVisible(false)
		var_24_1:addChild(var_24_8)

		local var_24_9 = transSkillDesToRichText(self:getBuffDetails(iter_24_3))
		local var_24_10 = RichTextPro:create()

		var_24_10:setMaxWidth(var_24_2)
		var_24_10:setSize(24)
		var_24_10:setColor(cc.c3b(220, 251, 241))
		var_24_10:setLineSpace(0)
		var_24_10:setText(var_24_9)
		var_24_10:setPosition(cc.p(60, var_24_5))
		var_24_1:addChild(var_24_10)

		var_24_5 = var_24_5 - var_24_8:getContentSize().height
		var_24_5 = var_24_5 - 6

		local var_24_11 = ccui.ImageView:create("skill_new/skill/" .. self:getBuffImage(iter_24_3) .. ".png", var_0_8)

		var_24_11:setPositionX(32)
		var_24_11:setPositionY((var_24_5 + var_24_5) / 2)
		var_24_11:setScale(0.5)
		var_24_1:addChild(var_24_11)
	end
end

function PopskillDetailLayer:fullScreen()
	self.bottomlist.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.bottomlist:getPositionY(), TRANSFORM_UNIT.PX)

	self.bottomlist:setPositionY(self.bottomlist.full_posY)
end
