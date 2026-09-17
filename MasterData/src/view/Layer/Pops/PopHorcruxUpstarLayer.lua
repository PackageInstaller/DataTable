PopHorcruxUpstarLayer = class("PopHorcruxUpstarLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

require("view.Sprite.ItemSprite")

local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local drop_manager = require("controller.drop_manager")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local horcrux_manager = require("controller.horcrux_manager")
local model_data = require("data.model_data")
local horcrux_strength_data = require("data.horcrux_strength_data")
local total_skill_data = require("data.total_skill_data")
local filter_config_manager = require("controller.filter_config_manager")
local bag_manager = require("controller.bag_manager")
local item_data = require("data.item_data")
local activity_conf_data = require("data.activity_conf_data")

function PopHorcruxUpstarLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopHorcruxUpstarLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopHorcruxUpstarLayer:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(false)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.rootLayer:setBackGroundColor(cc.c3b(0, 0, 0))
	self.rootLayer:setBackGroundColorOpacity(0)
	self:addChild(self.rootLayer, 2)

	self.rootpanel = ccui.ImageView:create("public/panelbg/normal_bg_new.png", var_0_0)

	self.rootpanel:setScale9Enabled(true)
	self.rootpanel:setCapInsets(cc.rect(0, 400, 510, 30))
	self.rootpanel:setPositionX(self.rootLayer:getContentSize().width / 2)
	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2 - GameDisplay.fix_y)
	self.rootLayer:addChild(self.rootpanel)
	self.showActions.extendVertical(self)
	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_4_0:isBright() then
			return
		end

		arg_4_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			if self.exitcallback then
				self.exitcallback(0)
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 0)
	self:initData(arg_3_1)
	self:initUI()
	self:updateUI()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" and arg_3_1.callback then
			arg_3_1.callback(self.consume)
		end
	end)
end

function PopHorcruxUpstarLayer:initData(arg_7_1)
	self.entityid = arg_7_1.entityid
	self.itemid = playermodel.items[self.entityid].itemid
	self.modelid = item_data[self.itemid].model
	self.cuteRole = model_data[self.modelid].cute_role
	self.star = horcrux_manager:getHorcruxStarLevel(self.entityid)
	self.nextstar = self.star + 1
	self.max_upstar = horcrux_manager:get_max_upstar(self.entityid)
	self.curSelectSelf = {}
	self.curSelectOther = {}
	self.consume = {}
end

function PopHorcruxUpstarLayer:initUI()
	self.title = ccui.ImageView:create("public/title/title_horcrux_upstar.png", var_0_0)

	self.title:setPosition(cc.p(104, self.rootpanel:getContentSize().height + self.title:getContentSize().height / 2 - 10))
	self.rootpanel:addChild(self.title)

	self.topPanel = ccui.Layout:create()

	self.topPanel:setAnchorPoint(cc.p(0, 1))
	self.topPanel:setPosition(cc.p(18, self.rootpanel:getContentSize().height - 80))
	self.rootpanel:addChild(self.topPanel)

	self.horcruxSp = HorcruxSprite:create({
		initType = "previewStyle"
	})

	self.horcruxSp:setScale(0.9)
	self.horcruxSp:setPositionX(0)
	self.horcruxSp:setPositionY(240)
	self.horcruxSp:update(self.entityid)
	self.topPanel:addChild(self.horcruxSp)

	self.labelPanel = ccui.Layout:create()

	self.labelPanel:setTouchEnabled(true)
	self.labelPanel:setContentSize(cc.size(310, 210))
	self.labelPanel:setAnchorPoint(cc.p(0, 1))
	self.labelPanel:setPosition(cc.p(160, self.labelPanel:getContentSize().height))
	self.labelPanel:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.labelPanel:setBackGroundColor(cc.c3b(0, 0, 0))
	self.labelPanel:setBackGroundColorOpacity(50)
	self.topPanel:addChild(self.labelPanel)

	self.star1Label = cc.Label:createWithTTF("", FONT_DES, 24)

	self.star1Label:setAnchorPoint(cc.p(0, 0.5))
	self.labelPanel:addChild(self.star1Label, 5)

	self.star2Label = cc.Label:createWithTTF("", FONT_DES, 24)

	self.star2Label:setAnchorPoint(cc.p(0, 0.5))
	self.star2Label:setColor(cc.c3b(5, 212, 70))
	self.labelPanel:addChild(self.star2Label, 5)

	self.level1Label = cc.Label:createWithTTF("", FONT_DES, 24)

	self.level1Label:setAnchorPoint(cc.p(0, 0.5))
	self.labelPanel:addChild(self.level1Label, 5)

	self.level2Label = cc.Label:createWithTTF("", FONT_DES, 24)

	self.level2Label:setAnchorPoint(cc.p(0, 0.5))
	self.level2Label:setColor(cc.c3b(5, 212, 70))
	self.labelPanel:addChild(self.level2Label, 5)

	self.damage1Label = cc.Label:createWithTTF("", FONT_DES, 24)

	self.damage1Label:setAnchorPoint(cc.p(0, 0.5))
	self.labelPanel:addChild(self.damage1Label, 5)

	self.damage2Label = cc.Label:createWithTTF("", FONT_DES, 24)

	self.damage2Label:setAnchorPoint(cc.p(0, 0.5))
	self.damage2Label:setColor(cc.c3b(5, 212, 70))
	self.labelPanel:addChild(self.damage2Label, 5)

	self.hp1Label = cc.Label:createWithTTF("", FONT_DES, 24)

	self.hp1Label:setAnchorPoint(cc.p(0, 0.5))
	self.labelPanel:addChild(self.hp1Label, 5)

	self.hp2Label = cc.Label:createWithTTF("", FONT_DES, 24)

	self.hp2Label:setAnchorPoint(cc.p(0, 0.5))
	self.hp2Label:setColor(cc.c3b(5, 212, 70))
	self.labelPanel:addChild(self.hp2Label, 5)

	self.skillGapLine = ccui.ImageView:create("HorcruxInfo/gapline.png", var_0_0)

	self.skillGapLine:setAnchorPoint(cc.p(0, 1))
	self.skillGapLine:setPosition(cc.p(18, 410))
	self.rootpanel:addChild(self.skillGapLine)

	self.skillHead = cc.Label:createWithTTF(L_SKILL_STRENGTH, FONT_DES, 20)

	self.skillHead:setAnchorPoint(cc.p(0, 1))
	self.skillHead:setPosition(cc.p(18, 380))
	self.skillHead:setColor(cc.c3b(166, 183, 203))
	self.rootpanel:addChild(self.skillHead)

	self.skillPanel = ccui.Layout:create()

	self.skillPanel:setTouchEnabled(true)
	self.skillPanel:setContentSize(cc.size(480, 120))
	self.skillPanel:setAnchorPoint(cc.p(0, 0))
	self.skillPanel:setPosition(cc.p(18, 260))
	self.skillPanel:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.skillPanel:setBackGroundColor(cc.c3b(0, 0, 0))
	self.skillPanel:setBackGroundColorOpacity(50)
	self.rootpanel:addChild(self.skillPanel)

	self.skillIconPanel = ccui.Layout:create()

	self.skillIconPanel:setTouchEnabled(true)
	self.skillIconPanel:setContentSize(cc.size(40, 40))
	self.skillIconPanel:setAnchorPoint(cc.p(0, 0))
	self.skillIconPanel:setPosition(cc.p(10, self.skillPanel:getContentSize().height - 10 - self.skillIconPanel:getContentSize().height))
	self.skillIconPanel:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.skillIconPanel:setBackGroundColor(cc.c3b(0, 0, 0))
	self.skillPanel:addChild(self.skillIconPanel)

	self.skillIcon = ccui.ImageView:create("skill_new/skill/9002181.png", var_0_0)

	self.skillIcon:setScale(0.4)
	self.skillIcon:setPositionX(self.skillIconPanel:getContentSize().width / 2)
	self.skillIcon:setPositionY(self.skillIconPanel:getContentSize().height / 2)
	self.skillIconPanel:addChild(self.skillIcon)

	self.skillName = cc.Label:createWithTTF("", FONT_DES, 20)

	self.skillName:setAnchorPoint(cc.p(0, 0.5))
	self.skillName:setPositionX(self.skillIconPanel:getPositionX() + self.skillIconPanel:getContentSize().width + 10)
	self.skillName:setPositionY(self.skillIconPanel:getPositionY() + self.skillIconPanel:getContentSize().width / 2)
	self.skillPanel:addChild(self.skillName)

	self.skillLevelNow = cc.Label:createWithTTF("", FONT_DES, 20)

	self.skillLevelNow:setAnchorPoint(cc.p(1, 0.5))
	self.skillLevelNow:setPositionY(self.skillName:getPositionY())
	self.skillPanel:addChild(self.skillLevelNow)

	self.skillArrow = ccui.ImageView:create("HorcruxInfo/change_arrow.png", var_0_0)

	self.skillArrow:setAnchorPoint(cc.p(0.5, 0.5))
	self.skillArrow:setPositionY(self.skillName:getPositionY())
	self.skillArrow:setPositionX(self.skillPanel:getContentSize().width / 2)
	self.skillPanel:addChild(self.skillArrow)

	self.skillLevelNext = cc.Label:createWithTTF("", FONT_DES, 20)

	self.skillLevelNext:setAnchorPoint(cc.p(0, 0.5))
	self.skillLevelNext:setColor(cc.c3b(5, 212, 70))
	self.skillLevelNext:setPositionY(self.skillName:getPositionY())
	self.skillPanel:addChild(self.skillLevelNext)

	self.skillDesArrow = ccui.ImageView:create("HorcruxInfo/change_arrow.png", var_0_0)

	self.skillDesArrow:setAnchorPoint(cc.p(0.5, 0.5))
	self.skillDesArrow:setPositionX(self.skillPanel:getContentSize().width / 2)
	self.skillPanel:addChild(self.skillDesArrow)

	self.materialGapLine = ccui.ImageView:create("HorcruxInfo/gapline.png", var_0_0)

	self.materialGapLine:setAnchorPoint(cc.p(0, 0))
	self.materialGapLine:setPosition(cc.p(18, 235))
	self.rootpanel:addChild(self.materialGapLine)

	self.materialdes = cc.Label:createWithTTF(L_NEED_MATERIAL, FONT_DES, 20)

	self.materialdes:setAnchorPoint(cc.p(0, 0.5))
	self.materialdes:setPosition(cc.p(18, 220))
	self.materialdes:setColor(cc.c3b(166, 183, 203))
	self.rootpanel:addChild(self.materialdes)

	self.sureBtn = ccui.Button:create("public/button/public_button_orange_big.png", nil, "public/button/public_button_orange_big.png", var_0_0)

	self.sureBtn:setPosition(cc.p(self.rootpanel:getContentSize().width / 2, -50))
	self.rootpanel:addChild(self.sureBtn)
	self.sureBtn:addTouchEventListener(self:getSureHanel())

	self.sureLabel = cc.Label:createWithTTF(L_BUTTON_TEXT.Up_Star, FONT_BUTTON, 32)

	self.sureLabel:setAnchorPoint(cc.p(0.5, 0.5))
	self.sureLabel:setColor(cc.c3b(12, 12, 12))
	self.sureLabel:setPosition(cc.p(self.sureBtn:getContentSize().width / 2, self.sureBtn:getContentSize().height / 2 - 5))
	self.sureBtn:addChild(self.sureLabel)
end

function PopHorcruxUpstarLayer:updatePos(arg_9_1)
	self.title:setPosition(cc.p(104, self.rootpanel:getContentSize().height + self.title:getContentSize().height / 2 - 10))
	self.topPanel:setPositionY(self.rootpanel:getContentSize().height - 230)
	self.horcruxSp:setPositionY(0)
	self.star1Label:setPositionX(15)
	self.star1Label:setPositionY(170)
	self.level1Label:setPositionX(15)
	self.level1Label:setPositionY(125)
	self.damage1Label:setPositionX(15)
	self.damage1Label:setPositionY(80)
	self.hp1Label:setPositionX(15)
	self.hp1Label:setPositionY(35)
	self.skillGapLine:setPositionY(self.rootpanel:getContentSize().height - 250)
	self.skillHead:setPositionY(self.skillGapLine:getPositionY())
	self.skillIconPanel:setPositionY(self.skillPanel:getContentSize().height - 10 - self.skillIconPanel:getContentSize().height)
	self.skillName:setPositionY(self.skillIconPanel:getPositionY() + self.skillIconPanel:getContentSize().width / 2)
	self.skillLevelNow:setPositionX(self.skillArrow:getPositionX() - self.skillArrow:getContentSize().width / 2 - 10)
	self.skillLevelNow:setPositionY(self.skillName:getPositionY())
	self.skillLevelNext:setPositionX(self.skillArrow:getPositionX() + self.skillArrow:getContentSize().width / 2 + 10)
	self.skillLevelNext:setPositionY(self.skillName:getPositionY())
	self.skillArrow:setPositionY(self.skillName:getPositionY())
end

function PopHorcruxUpstarLayer.getSureHanel(arg_10_0)
	return function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_11_0:isBright() then
			return
		end

		local var_11_0 = {}

		for iter_11_0, iter_11_1 in pairs(arg_10_0.curSelectSelf) do
			table.insert(var_11_0, iter_11_1)
		end

		for iter_11_2, iter_11_3 in pairs(arg_10_0.curSelectOther) do
			table.insert(var_11_0, iter_11_3)
		end

		local var_11_1 = arg_10_0.star

		for iter_11_4, iter_11_5 in pairs(var_11_0) do
			var_11_1 = math.max(var_11_1, horcrux_manager:getHorcruxStarLevel(iter_11_5))
		end

		local function var_11_2(...)
			arg_11_0:setBright(false)
			horcrux_manager:horcrux_upstar(arg_10_0.entityid, var_11_0, function(arg_13_0)
				if arg_13_0.result == 1 then
					arg_10_0.curSelectOther = {}
					arg_10_0.curSelectSelf = {}
					arg_10_0.star = horcrux_manager:getHorcruxStarLevel(arg_10_0.entityid)
					arg_10_0.nextstar = arg_10_0.star + 1

					arg_10_0:updateUI()

					for iter_13_0, iter_13_1 in pairs(arg_13_0.consumes) do
						table.insert(arg_10_0.consume, iter_13_1)
					end

					arg_10_0:playStarUpEffect(function(...)
						global_gain({
							gold = arg_13_0.gold,
							items = arg_13_0.items
						})
					end)
				elseif arg_13_0.result == 2 then
					global_ShowBlockWords(L_HORCRUX_UPSTAR_LACK)
				elseif arg_13_0.result == 4 then
					global_ShowBlockWords(L_HORCRUX_UPSTAR_LACK)
				elseif arg_13_0.result == 5 then
					global_ShowBlockWords(L_HORCRUX_UPSTAR_LACK)
				end

				arg_11_0:setBright(true)
			end)
		end

		if var_11_1 == arg_10_0.star then
			var_11_2()
		else
			local var_11_3 = {
				layerType = "HorcruxInfoLayerNew",
				surecallback = var_11_2
			}

			require("view.Sprite.ConfirmDialogSprite")

			local var_11_4 = ConfirmDialogSprite:create("魂器升星", "所选魂器有高星魂器，是否进行升星", var_11_3)

			var_11_4:setPositionY(var_11_4:getPositionY() - GameDisplay.fix_y)
			arg_10_0:addChild(var_11_4, 10)
		end
	end
end

function PopHorcruxUpstarLayer:updateUI()
	self.sureBtn:setVisible(self.star < item_data[self.itemid].max_star)
	self.horcruxSp:update(self.entityid)

	local var_15_0 = horcrux_manager:getHorcruxAssistConfig(self.entityid, 0)
	local var_15_1 = 0
	local var_15_2 = 0
	local var_15_3 = horcrux_manager:getHorcruxSkills(self.entityid, self.star)
	local var_15_4

	for iter_15_0, iter_15_1 in pairs(horcrux_strength_data) do
		if self.star >= iter_15_1.starlimit then
			var_15_1 = iter_15_0
		end

		if self.nextstar >= iter_15_1.starlimit then
			var_15_2 = iter_15_0
		end
	end

	self.star1Label:setString(L_STAR_LEVEL .. "：" .. self.star)
	self.level1Label:setString(L_WEAPON_UP_QUALITY_INFO.Level .. var_15_1)
	self.damage1Label:setString(L_SCIENCE_NAME.ATTACK .. "：" .. math.floor(var_15_0.damage))
	self.hp1Label:setString(L_SCIENCE_NAME.HP .. "：" .. math.floor(var_15_0.hp))

	local var_15_5 = {
		nil,
		nil,
		nil,
		nil,
		nil,
		"+",
		"++",
		"max"
	}

	if self.nextstar > self.max_upstar then
		self.star2Label:setString("(Max)")
		self.level2Label:setString("(Max)")
		self.damage2Label:setString("(Max)")
		self.hp2Label:setString("(Max)")
		self.skillName:setString(total_skill_data[var_15_3[1]].name)
		self.skillLevelNow:setString("LV." .. self.star .. "(Max)")
		self.skillLevelNext:setVisible(false)
		self.skillArrow:setVisible(false)
		self.skillDesArrow:setVisible(false)
		self.skillIcon:loadTexture("skill_new/skill/" .. total_skill_data[var_15_3[1]].icon .. ".png", var_0_0)
	else
		self.star2Label:setString(" → " .. self.nextstar)
		self.level2Label:setString(" → " .. var_15_2)
		self.damage2Label:setString("(+" .. horcrux_manager:getHorcruxDamageUpstarAddition(horcrux_manager:getHorcruxItemid(self.entityid), horcrux_manager:getHorcruxStarLevel(self.entityid) + 1) - horcrux_manager:getHorcruxDamageUpstarAddition(horcrux_manager:getHorcruxItemid(self.entityid), horcrux_manager:getHorcruxStarLevel(self.entityid)) .. ")")
		self.hp2Label:setString("(+" .. horcrux_manager:getHorcruxHpUpstarAddition(horcrux_manager:getHorcruxItemid(self.entityid), horcrux_manager:getHorcruxStarLevel(self.entityid) + 1) - horcrux_manager:getHorcruxHpUpstarAddition(horcrux_manager:getHorcruxItemid(self.entityid), horcrux_manager:getHorcruxStarLevel(self.entityid)) .. ")")

		var_15_4 = horcrux_manager:getHorcruxSkills(self.entityid, self.star + 1)

		self.skillName:setString(total_skill_data[var_15_3[1]].name)
		self.skillLevelNow:setString("LV." .. self.star)
		self.skillLevelNext:setString(total_skill_data[var_15_3[1]].name .. (var_15_5[self.star + 1] or ""))
		self.skillArrow:setVisible(true)
		self.skillDesArrow:setVisible(true)
		self.skillIcon:loadTexture("skill_new/skill/" .. total_skill_data[var_15_3[1]].icon .. ".png", var_0_0)
	end

	self.skillLevelNow:setVisible(false)

	if self.skillPanel:getChildByName("skillDesNow") then
		self.skillPanel:removeChildByName("skillDesNow", true)
	end

	if self.skillPanel:getChildByName("skillDesNext") then
		self.skillPanel:removeChildByName("skillDesNext", true)
	end

	local var_15_6 = transSkillDesToRichText(total_skill_data[var_15_3[1]].description)
	local var_15_7 = RichTextPro:create()

	var_15_7:setAnchorPoint(cc.p(0, 0))
	var_15_7:setMaxWidth(self.skillPanel:getContentSize().width / 2 - 30)
	var_15_7:setSize(18)
	var_15_7:setLineSpace(0)
	var_15_7:setText(var_15_6)
	var_15_7:setName("skillDesNow")
	self.skillPanel:addChild(var_15_7)

	if var_15_4 then
		local var_15_8 = RichTextPro:create()

		var_15_8:setAnchorPoint(cc.p(0, 0))
		var_15_8:setMaxWidth(self.skillPanel:getContentSize().width / 2 - 30)
		var_15_8:setSize(18)
		var_15_8:setLineSpace(0)
		var_15_8:setText((transSkillDesToRichText(total_skill_data[var_15_4[1]].description)))
		var_15_8:setName("skillDesNext")
		self.skillPanel:addChild(var_15_8)
	end

	local var_15_9, var_15_10 = var_15_7:getContentSize()

	self.skillPanel:setContentSize(cc.size(470, var_15_10 + 60))
	self.rootpanel:setContentSize(cc.size(510, 454 + var_15_10 + 150))
	var_15_7:setPosition(cc.p(10, self.skillPanel:getContentSize().height - self.skillIconPanel:getContentSize().height - 10))

	if self.skillPanel:getChildByName("skillDesNext") then
		self.skillPanel:getChildByName("skillDesNext"):setPosition(cc.p(self.skillPanel:getContentSize().width / 2 + 30, self.skillPanel:getContentSize().height - self.skillIconPanel:getContentSize().height - 10))
	end

	self.skillDesArrow:setPositionY(var_15_7:getPositionY() - self.skillArrow:getContentSize().height / 2 - var_15_10 / 2 + 10)
	self:updatePos(var_15_10)

	local var_15_11 = 2
	local var_15_12 = self.damage1Label:getPositionX()
	local var_15_13 = self.damage1Label:getContentSize().width

	while self["damage" .. var_15_11 .. "Label"] do
		self["damage" .. var_15_11 .. "Label"]:setPosition(cc.p(var_15_12 + var_15_13, self.damage1Label:getPositionY()))

		var_15_13 = self["damage" .. var_15_11 .. "Label"]:getContentSize().width + var_15_13
		var_15_11 = var_15_11 + 1
	end

	local var_15_14 = self.hp1Label:getPositionX()
	local var_15_15 = self.hp1Label:getContentSize().width

	while self["hp" .. 2 .. "Label"] do
		self["hp" .. 2 .. "Label"]:setPosition(cc.p(var_15_14 + var_15_15, self.hp1Label:getPositionY()))

		var_15_15 = self["hp" .. 2 .. "Label"]:getContentSize().width + var_15_15
	end

	local var_15_17 = self.star1Label:getPositionX()
	local var_15_18 = self.star1Label:getContentSize().width

	while self["star" .. 2 .. "Label"] do
		self["star" .. 2 .. "Label"]:setPosition(cc.p(var_15_17 + var_15_18, self.star1Label:getPositionY()))

		var_15_18 = self["star" .. 2 .. "Label"]:getContentSize().width + var_15_18
	end

	local var_15_20 = self.level1Label:getPositionX()
	local var_15_21 = self.level1Label:getContentSize().width

	while self["level" .. 2 .. "Label"] do
		self["level" .. 2 .. "Label"]:setPosition(cc.p(var_15_20 + var_15_21, self.level1Label:getPositionY()))

		var_15_21 = self["level" .. 2 .. "Label"]:getContentSize().width + var_15_21
	end

	if self.list then
		self.list:removeFromParent()
	end

	if self.nextstar <= self.max_upstar then
		self.list = ccui.ListView:create()

		self.list:setContentSize(cc.size(612, 240))
		self.list:setPosition(cc.p(18, 20))
		self.list:setDirection(ccui.ListViewDirection.horizontal)
		self.list:setScale(0.8)
		self.rootpanel:addChild(self.list)

		local var_15_23 = item_data[self.itemid]["upstar_" .. self.nextstar .. "_need_self"] or 0

		for iter_15_2 = 1, (item_data[self.itemid]["upstar_" .. self.nextstar .. "_need_other"] or 0) + var_15_23 do
			local var_15_24 = ccui.ImageView:create("public/rolebg/horcrux_rarity_1.png", var_0_0)

			var_15_24:setScale9Enabled(true)
			var_15_24:setCapInsets(cc.rect(40, 40, 20, 20))
			var_15_24:setContentSize(cc.size(168, 230))
			var_15_24:setScale(1)
			var_15_24:setTouchEnabled(true)
			self.list:pushBackCustomItem(var_15_24)

			if iter_15_2 <= var_15_23 then
				var_15_24.type = "need_self"

				if self.curSelectSelf[iter_15_2] then
					local var_15_25 = HorcruxSprite:create({
						initType = "previewStyle"
					})

					var_15_25:setPositionX(var_15_24:getContentSize().width / 2)
					var_15_25:setPositionY(var_15_24:getContentSize().height / 2)
					var_15_25:setAnchorPoint(cc.p(0.5, 0.5))
					var_15_25:update(self.curSelectSelf[iter_15_2])

					var_15_25.entityid = self.curSelectSelf[iter_15_2]

					var_15_25:setTouchEnabled(false)
					var_15_24:addChild(var_15_25)

					var_15_24.entityid = self.curSelectSelf[iter_15_2]
				else
					local var_15_26 = HorcruxSprite:create({
						initType = "previewStyle"
					})

					var_15_26:setPositionX(var_15_24:getContentSize().width / 2)
					var_15_26:setPositionY(var_15_24:getContentSize().height / 2)
					var_15_26:setAnchorPoint(cc.p(0.5, 0.5))
					var_15_26:setUnkonw(item_data[self.itemid].attr, item_data[self.itemid].rarity, self.star, self.itemid)
					var_15_26:setTouchEnabled(false)
					var_15_24:addChild(var_15_26)

					local var_15_27 = ccui.ImageView:create("public/button/need_add.png", var_0_0)

					var_15_27:setName("addimg")
					var_15_27:setPositionX(var_15_24:getContentSize().width / 2)
					var_15_27:setPositionY(var_15_24:getContentSize().height / 2)
					var_15_24:addChild(var_15_27)
					var_15_27:setVisible(self:haveHorcrux(var_15_24.type))
				end
			else
				var_15_24.type = "need_other"

				if self.curSelectOther[iter_15_2 - var_15_23] then
					local var_15_28 = HorcruxSprite:create({
						initType = "previewStyle"
					})

					var_15_28:setPositionX(var_15_24:getContentSize().width / 2)
					var_15_28:setPositionY(var_15_24:getContentSize().height / 2)
					var_15_28:setAnchorPoint(cc.p(0.5, 0.5))
					var_15_28:update(self.curSelectOther[iter_15_2 - var_15_23])

					var_15_28.entityid = self.curSelectOther[iter_15_2 - var_15_23]

					var_15_28:setTouchEnabled(false)
					var_15_24:addChild(var_15_28)

					var_15_24.entityid = self.curSelectOther[iter_15_2 - var_15_23]
				else
					local var_15_29 = HorcruxSprite:create({
						initType = "previewStyle"
					})

					var_15_29:setPositionX(var_15_24:getContentSize().width / 2)
					var_15_29:setPositionY(var_15_24:getContentSize().height / 2)
					var_15_29:setAnchorPoint(cc.p(0.5, 0.5))
					var_15_29:setUnkonw(item_data[self.itemid].attr, item_data[self.itemid].rarity, self.star)
					var_15_29:setTouchEnabled(false)
					var_15_24:addChild(var_15_29)

					local var_15_30 = ccui.ImageView:create("public/button/need_add.png", var_0_0)

					var_15_30:setName("addimg")
					var_15_30:setPositionX(var_15_24:getContentSize().width / 2)
					var_15_30:setPositionY(var_15_24:getContentSize().height / 2)
					var_15_24:addChild(var_15_30)
					var_15_30:setVisible(self:haveHorcrux(var_15_24.type))
				end
			end

			var_15_24:addTouchEventListener(function(arg_16_0, arg_16_1)
				if arg_16_1 ~= ccui.TouchEventType.ended then
					return
				end

				self.openType = arg_16_0.type

				self:changeHorcrux(arg_16_0.entityid, iter_15_2)
			end)
		end
	end
end

function PopHorcruxUpstarLayer:haveHorcrux(arg_17_1)
	local var_17_1 = {}

	for iter_17_0, iter_17_1 in pairs(self.curSelectOther) do
		table.insert(var_17_1, iter_17_1)
	end

	for iter_17_2, iter_17_3 in pairs(self.curSelectSelf) do
		table.insert(var_17_1, iter_17_3)
	end

	table.insert(var_17_1, self.entityid)

	local var_17_2 = {
		UIType = "HorcruxInfoLayerNew",
		selectType = SELECT_HORCRUX_COMPOUND,
		outSide = var_17_1,
		initFilterPop = {},
		initFilter = {
			isBusy = {
				false
			},
			stars = {
				(horcrux_manager:getHorcruxStarLevel(self.entityid))
			},
			lock = {
				false
			}
		},
		curHorcrux = self.entityid,
		selectCallback = function(arg_18_0)
			if arg_17_1 == "need_other" then
				local var_18_0 = {}

				for iter_18_0, iter_18_1 in pairs(self.curSelectOther) do
					var_18_0[iter_18_1] = iter_18_0
				end

				if var_18_0[arg_18_0] then
					table.remove(self.curSelectOther, var_18_0[arg_18_0])
				else
					table.insert(self.curSelectOther, arg_18_0)
				end

				if selectEntityid then
					for iter_18_2, iter_18_3 in pairs(self.curSelectOther) do
						if selectEntityid == iter_18_3 then
							table.remove(self.curSelectOther, iter_18_2)
						end
					end
				end
			else
				local var_18_1 = {}

				for iter_18_4, iter_18_5 in pairs(self.curSelectSelf) do
					var_18_1[iter_18_5] = iter_18_4
				end

				if var_18_1[arg_18_0] then
					table.remove(self.curSelectSelf, var_18_1[arg_18_0])
				else
					table.insert(self.curSelectSelf, arg_18_0)
				end

				if selectEntityid then
					for iter_18_6, iter_18_7 in pairs(self.curSelectSelf) do
						if selectEntityid == iter_18_7 then
							table.remove(self.curSelectSelf, iter_18_6)
						end
					end
				end
			end
		end
	}

	if arg_17_1 == "need_self" then
		var_17_2.initFilter.type = {
			item_data[self.itemid].select_type
		}
	else
		var_17_2.initFilter.attr = {
			item_data[self.itemid].attr
		}
	end

	local var_17_3 = bag_manager:create()
	local var_17_4 = filter_config_manager:getDefaultFilterData(filter_config_manager.HORCRUX_LAYER)

	var_17_4.outSide = {
		self.entityid
	}

	if var_17_1 then
		for iter_17_4, iter_17_5 in pairs(var_17_1) do
			var_17_4.outSide[#var_17_4.outSide + 1] = iter_17_5
		end
	end

	if var_17_2.initFilter then
		for iter_17_6, iter_17_7 in pairs(var_17_2.initFilter) do
			var_17_4.filterConfig[iter_17_6] = global_deepCopy(iter_17_7)
		end
	end

	var_17_3:generate_bag_data(var_17_4)

	return var_17_3:getDataCount() > 0
end

function PopHorcruxUpstarLayer:changeHorcrux(arg_19_1, arg_19_2)
	local var_19_1 = {}

	for iter_19_0, iter_19_1 in pairs(self.curSelectOther) do
		table.insert(var_19_1, iter_19_1)
	end

	for iter_19_2, iter_19_3 in pairs(self.curSelectSelf) do
		table.insert(var_19_1, iter_19_3)
	end

	table.insert(var_19_1, self.entityid)

	local var_19_2 = {
		UIType = "HorcruxInfoLayerNew",
		selectType = SELECT_HORCRUX_COMPOUND,
		outSide = var_19_1,
		initFilterPop = {},
		filtertype = filter_config_manager.HORCRUX_UPSTAR_LAYER,
		initFilter = {
			isBusy = {
				false
			},
			stars = {
				(horcrux_manager:getHorcruxStarLevel(self.entityid))
			},
			lock = {
				false
			}
		}
	}

	if arg_19_2 <= 1 then
		var_19_2.curHorcrux = self.curSelectSelf[arg_19_2] or self.curSelectOther[arg_19_2 - 1]
	end

	function var_19_2.selectCallback(arg_20_0)
		if self.openType == "need_other" then
			local var_20_0 = {}

			for iter_20_0, iter_20_1 in pairs(self.curSelectOther) do
				var_20_0[iter_20_1] = iter_20_0
			end

			if var_20_0[arg_20_0] then
				table.remove(self.curSelectOther, var_20_0[arg_20_0])
			else
				table.insert(self.curSelectOther, arg_20_0)
			end

			if arg_19_1 then
				for iter_20_2, iter_20_3 in pairs(self.curSelectOther) do
					if arg_19_1 == iter_20_3 then
						table.remove(self.curSelectOther, iter_20_2)
					end
				end
			end
		else
			local var_20_1 = {}

			for iter_20_4, iter_20_5 in pairs(self.curSelectSelf) do
				var_20_1[iter_20_5] = iter_20_4
			end

			if var_20_1[arg_20_0] then
				table.remove(self.curSelectSelf, var_20_1[arg_20_0])
			else
				table.insert(self.curSelectSelf, arg_20_0)
			end

			if arg_19_1 then
				for iter_20_6, iter_20_7 in pairs(self.curSelectSelf) do
					if arg_19_1 == iter_20_7 then
						table.remove(self.curSelectSelf, iter_20_6)
					end
				end
			end
		end

		self:updateUI()
	end

	if self.openType == "need_self" then
		var_19_2.initFilter.type = {
			item_data[self.itemid].select_type
		}
	else
		var_19_2.initFilter.attr = {
			item_data[self.itemid].attr
		}
	end

	function var_19_2.insertHandel(arg_21_0)
		local var_21_0 = {
			[self.entityid] = true
		}

		for iter_21_0, iter_21_1 in pairs(self.curSelectOther) do
			var_21_0[iter_21_1] = iter_21_0
		end

		for iter_21_2, iter_21_3 in pairs(self.curSelectSelf) do
			var_21_0[iter_21_3] = iter_21_2
		end

		if var_21_0[arg_21_0] then
			return false
		end

		local var_21_1 = playermodel.items[arg_21_0]

		if self.openType == "need_self" then
			if var_21_1.horcrux_attr.star >= playermodel.items[self.entityid].horcrux_attr.star and (item_data[var_21_1.itemid].select_type == item_data[playermodel.items[self.entityid].itemid].select_type or item_data[var_21_1.itemid].upstar_material == 1) then
				return true
			end
		elseif var_21_1.horcrux_attr.star >= playermodel.items[self.entityid].horcrux_attr.star and (item_data[var_21_1.itemid].attr == item_data[playermodel.items[self.entityid].itemid].attr or item_data[var_21_1.itemid].attr == 6) then
			return true
		end

		return false
	end

	LayerManager:pushInLayer("HorcruxSelectLayer", var_19_2)
end

function PopHorcruxUpstarLayer:initBg(arg_22_1)
	local var_22_0 = ccui.Layout:create()

	var_22_0:setTouchEnabled(true)
	var_22_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_22_0:setAnchorPoint(cc.p(0, 0))
	var_22_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_22_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_22_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_22_0:setOpacity(0)
	self:addChild(var_22_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_23_0)
		self:addChild(arg_23_0, -2)
		arg_23_0:setPositionY(arg_23_0:getPositionY() - GameDisplay.fix_y)

		local var_23_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_23_0:setAnchorPoint(cc.p(0, 0))
		var_23_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_23_0, -1)
		self:init(arg_22_1)
		var_22_0:setOpacity(102)
		var_22_0:setTouchEnabled(false)
	end)
end

function PopHorcruxUpstarLayer:playStarUpEffect(arg_24_1)
	local var_24_0 = self.entityid

	audio_manager:playeffectMusic("weapon_starup")

	local var_24_1 = ccui.Layout:create()

	var_24_1:setTouchEnabled(true)
	var_24_1:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_24_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_24_1:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_24_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_24_1:setBackGroundColor(cc.c3b(0, 0, 0))
	var_24_1:setBackGroundColorOpacity(220)
	global_basic_scene:addChild(var_24_1, 999)

	local function var_24_2()
		local var_25_0 = horcrux_manager:getHorcruxStarLevel(var_24_0)
		local var_25_1 = {}
		local var_25_2 = var_25_0
		local var_25_3 = var_25_0 % 5

		for iter_25_0 = 1, 5 do
			local var_25_5 = ccui.ImageView:create((var_25_3 < iter_25_0 and var_25_2 > 5 or iter_25_0 <= var_25_3 and var_25_2 <= 5) and "public/currency/weapon_star.png" or var_25_3 < iter_25_0 and var_25_2 <= 5 and "public/currency/weapon_star_empty.png" or "public/currency/pink_star.png", var_0_0)

			var_25_5:setPosition(cc.p(270 + (iter_25_0 - (var_25_3 + 1) / 2) * (var_25_5:getContentSize().width - 10), GameDisplay.height / 2 - 76))
			table.insert(var_25_1, var_25_5)
			var_25_5:setVisible(false)
			var_24_1:addChild(var_25_5)
		end

		for iter_25_1, iter_25_2 in pairs(var_25_1) do
			var_25_1[iter_25_1]:setScale(8)
			var_25_1[iter_25_1]:runAction(cc.Sequence:create(cc.DelayTime:create(iter_25_1 / 30), cc.CallFunc:create(function()
				var_25_1[iter_25_1]:setVisible(true)
			end), cc.Spawn:create(cc.RotateBy:create(0.55, 72), cc.Sequence:create(cc.ScaleTo:create(0.15, 1, 1), cc.ScaleTo:create(0.25, 2, 2), cc.ScaleTo:create(0.15, 1, 1)))))
		end
	end

	local var_24_3 = L2Skeleton:create("spine/ui/weapon_up_quality/horcrux_up.json", "spine/ui/weapon_up_quality/horcrux_up.atlas")

	var_24_3:refreshSkeleton()
	var_24_3:setSlotTexture("wuqi", "diergewuqi", "roleimage/role1/" .. model_data[item_data[playermodel.items[self.entityid].itemid].model].cute_role .. ".png")
	var_24_3:setSlotTexture("wuqi", "wuqishengjiewuqi", "roleimage/role1/" .. model_data[item_data[playermodel.items[self.entityid].itemid].model].cute_role .. ".png")
	var_24_3:setSlotTexture("wuqikuang", "wuqishengjiewuqikuang", ({
		"weaponIcon/weapon_bg_white.png",
		"weaponIcon/weapon_bg_green.png",
		"weaponIcon/weapon_bg_blue.png",
		"weaponIcon/weapon_bg_purple.png",
		"weaponIcon/weapon_bg_orange.png",
		"weaponIcon/weapon_bg_red.png"
	})[item_data[playermodel.items[self.entityid].itemid].rarity + 1])
	var_24_3.skeletonAnimation:setPosition(cc.p(320, GameDisplay.height / 2))
	var_24_3:play("unique_up", false)
	var_24_1:addChild(var_24_3)
	var_24_1:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
		var_24_2()
	end), cc.DelayTime:create(8), cc.RemoveSelf:create(), cc.CallFunc:create(function()
		if arg_24_1 then
			arg_24_1()
		end
	end)))
	var_24_1:addTouchEventListener(function(arg_29_0, arg_29_1)
		if arg_29_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_24_1 then
			arg_24_1()
		end

		var_24_1:runAction(cc.Sequence:create(cc.RemoveSelf:create(), cc.CallFunc:create(function()
			return
		end)))
	end)
end

function PopHorcruxUpstarLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		if self.exitcallback then
			self.exitcallback(0)
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end
