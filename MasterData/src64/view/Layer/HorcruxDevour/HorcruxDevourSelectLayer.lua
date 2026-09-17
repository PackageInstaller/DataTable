local HorcruxDevourSelectLayer = class("HorcruxDevourSelectLayer", (require("view.Layer.BaseUILayer")))
local TempWidget = require("view.Sprite.TempWidget")
local var_0_2 = config._DEBUG and 0 or 1
local var_0_3 = "HorcruxDevourSelectLayer/"
local total_skill_data = require("data.total_skill_data")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local var_0_7 = require("controller/horcrux_devour/horcrux_devour_manager"):getInstance()
local horcrux_manager = require("controller/horcrux_manager")
local item_manager = require("controller/item_manager")
local playermodel = require("model.playermodel")

require("view/Sprite/HorcruxSprite")
require("view/Sprite/RichTextPro")

local var_0_11 = {
	s = "public/rolebg/h_fac_s.png",
	a = "public/rolebg/h_fac_grade_a.png",
	s_plus = "public/rolebg/h_fac_s_plus.png",
	b_minus = "public/rolebg/h_fac_grade_b_minus.png",
	b_plus = "public/rolebg/h_fac_grade_b_plus.png",
	a_minus = "public/rolebg/h_fac_grade_a_minus.png",
	b = "public/rolebg/h_fac_grade_b.png",
	c = "public/rolebg/h_fac_grade_c.png",
	a_puls = "public/rolebg/h_fac_a_puls.png"
}

function HorcruxDevourSelectLayer:ctor()
	HorcruxDevourSelectLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller/horcrux_devour/horcrux_devour_select_manager"):getInstance()
end

function HorcruxDevourSelectLayer:create(arg_2_1)
	local var_2_0 = HorcruxDevourSelectLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function HorcruxDevourSelectLayer:onEnter()
	HorcruxDevourSelectLayer.super.onEnter(self)
	self.manager:registerNotification("HorcruxDevourSucceeded", function(arg_4_0)
		self:breakAnimation(self._servantId, arg_4_0)
		LayerManager:removePopLayer(self.__queueindex)
	end)
	self.manager:registerNotification("HorcruxLevelUpSucceeded", function(arg_5_0)
		self:horcruxLevelUpSucceeded(arg_5_0)
	end)
	self.manager:registerNotification("HorcruxBreakoutSucceeded", function(arg_6_0)
		self:horcruxBreakoutSucceeded(arg_6_0)
	end)
	self.manager:registerNotification("HorcruxUpStarSucceeded", function(arg_7_0)
		self:horcruxUpStarSucceeded(arg_7_0)
	end)

	for iter_3_0 = 1, HORCRUX_DEVOUR_MAX do
		local var_3_0 = var_0_7:getSkillInfo(self._servantId, iter_3_0)

		if var_3_0 and var_3_0.newskill then
			local var_3_1 = {
				isAddSkill = false
			}

			var_3_1.oldSkillInfo = var_3_0
			var_3_1.newSkillInfo = var_3_0
			var_3_1.oldHp = var_3_0.hp
			var_3_1.newHp = var_3_0.newhp
			var_3_1.oldDamage = var_3_0.damage
			var_3_1.newDamage = var_3_0.newdamage
			var_3_1.changedHp = var_3_0.newhp - var_3_0.hp
			var_3_1.changedDamage = var_3_0.newdamage - var_3_0.damage

			self:breakAnimation(self._servantId, var_3_1)

			break
		end
	end
end

function HorcruxDevourSelectLayer:onExit()
	HorcruxDevourSelectLayer.super.onExit(self)
end

function HorcruxDevourSelectLayer:init(arg_9_1)
	self._servantId = arg_9_1.servantId
	self._selectIndex = arg_9_1.selectIndex or 1
	self.isReplace = arg_9_1.isReplace

	self.manager:setServantId(arg_9_1.servantId)
	self.manager:setMaterials({})
	self.manager:setDevourEntityId(nil)
	self:initLayer()
	self:initListener()

	return true
end

function HorcruxDevourSelectLayer:initLayer()
	local var_10_0 = TempWidget:CreateTempLayout(self)

	var_10_0:_setBack()
	var_10_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_10_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_10_0:setBackGroundColorOpacity(150)
	var_10_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_10_0

	local var_10_1 = TempWidget:CreateTempImg(var_0_3 .. "bg.png", var_10_0)

	var_10_1:align(cc.p(0.5, 0.5), var_10_0:getContentSize().width / 2, var_10_0:getContentSize().height / 2 + 60)
	var_10_1:_addEvent(function()
		return
	end)

	self._bg = var_10_1
	self.exCount = not self.isReplace and (var_0_7:getMinExCount(self._servantId) and var_0_7:getMinExCount(self._servantId) or 2) or self._selectIndex - 1 <= 2 and self._selectIndex - 1 or 2

	local var_10_2 = TempWidget:CreateTempLabel(L_HORCRUX_DEVOUR[4], FONT_NAME, 22, var_10_1)

	var_10_2:_setColor("9794a6")
	var_10_2:align(cc.p(0, 1), 30, var_10_1:getContentSize().height - 102)
	self:initSelectFacGradeImg()

	local var_10_3 = TempWidget:CreateTempListView(var_10_1)

	var_10_3:setContentSize(cc.size(var_10_1:size().w - 100, 140))
	var_10_3:setDirection(ccui.ScrollViewDir.horizontal)
	var_10_3:align(cc.p(0.5, 1), var_10_1:size().w / 2, var_10_2:pos().y - var_10_2:size().h - 10)
	var_10_3:setItemsMargin(10)
	var_10_3:setClippingEnabled(false)

	self._skillImgList = var_10_3

	self:initListSkillImgList()

	local var_10_4 = TempWidget:CreateTempImg(var_0_3 .. "select_skill_bg.png", var_10_1)

	var_10_4:align(cc.p(0.5, 1), var_10_3:pos().x, var_10_3:pos().y - var_10_3:size().h - 25)

	local var_10_5 = TempWidget:CreateTempImg(var_0_3 .. "select_skill_bg.png", var_10_1)

	var_10_5:align(cc.p(0.5, 1), var_10_3:pos().x, var_10_3:pos().y - var_10_3:size().h - 115)

	local var_10_6 = TempWidget:CreateTempLabel("selectSkillNameLabel1", FONT_NAME, 24, var_10_4)

	var_10_6:_setColor("00ffle")
	var_10_6:align(cc.p(0, 1), 110, var_10_4:size().h - 2)

	local var_10_7 = TempWidget:CreateTempLabel("selectSkillNameLabel2", FONT_NAME, 24, var_10_5)

	var_10_7:_setColor("00ffle")
	var_10_7:align(cc.p(0, 1), 110, var_10_5:size().h - 2)

	self._selectSkillNameLabel1 = var_10_6
	self._selectSkillNameLabel2 = var_10_7

	self:updateSelectSkillNameLabel()

	local var_10_8 = RichTextPro:create()

	var_10_8:setAnchorPoint(cc.p(0, 1))
	var_10_8:setPosition(cc.p(var_10_6:pos().x, var_10_6:pos().y - var_10_6:size().h))
	var_10_8:setMaxWidth(450)
	var_10_8:setSize(20)
	var_10_8:setText("")
	var_10_8:setLineSpace(0)
	var_10_4:addChild(var_10_8)

	local var_10_9 = RichTextPro:create()

	var_10_9:setAnchorPoint(cc.p(0, 1))
	var_10_9:setPosition(cc.p(var_10_7:pos().x, var_10_7:pos().y - var_10_7:size().h))
	var_10_9:setMaxWidth(450)
	var_10_9:setSize(20)
	var_10_9:setText("")
	var_10_9:setLineSpace(0)
	var_10_5:addChild(var_10_9)

	self._selectSkillDesText1 = var_10_8
	self._selectSkillDesText2 = var_10_9

	local var_10_10 = TempWidget:CreateTempImg(var_0_3 .. "skill_rect.png", var_10_4)

	var_10_10:setScale(0.8)
	var_10_10:align(cc.p(0, 1), 0, var_10_4:size().h - 2)

	local var_10_11 = TempWidget:CreateTempImg("skill_new/skill/20100.png", var_10_10)

	var_10_11:setScale(0.84)
	var_10_11:center()

	local var_10_12 = TempWidget:CreateTempImg(var_0_3 .. "repeat.png", var_10_11)

	var_10_12:setScale(1.4)
	var_10_12:center()

	local var_10_13 = TempWidget:CreateTempImg(var_0_3 .. "skill_rect.png", var_10_5)

	var_10_13:setScale(0.8)
	var_10_13:align(cc.p(0, 1), 0, var_10_4:size().h - 2)

	local var_10_14 = TempWidget:CreateTempImg("skill_new/skill/20100.png", var_10_13)

	var_10_14:setScale(0.84)
	var_10_14:center()

	local var_10_15 = TempWidget:CreateTempImg(var_0_3 .. "repeat.png", var_10_14)

	var_10_15:setScale(1.4)
	var_10_15:center()

	self._skillFrame1 = var_10_10
	self._skillFrame2 = var_10_13
	self._skillImg1 = var_10_11
	self._skillImg2 = var_10_14
	self._repeatImg1 = var_10_12
	self._repeatImg2 = var_10_15

	self:updateSelectSkillDesText()

	local var_10_16 = TempWidget:CreateTempLabel(L_HORCRUX_DEVOUR[5], FONT_NAME, 22, var_10_1)

	var_10_16:_setColor("9794a6")
	var_10_16:align(cc.p(0, 1), var_10_2:pos().x, var_10_5:pos().y - var_10_5:size().h - 34)
	self:initDevourFacGradeImg()

	self._skillInheritLayoutTable = {}

	local var_10_17 = self:createSkillInheritLayout(1)

	var_10_1:addChild(var_10_17)
	var_10_17:align(cc.p(0.5, 1), var_10_1:size().w / 2, var_10_16:pos().y - var_10_16:size().h)
	table.insert(self._skillInheritLayoutTable, var_10_17)

	local var_10_18 = self:createSkillInheritLayout(2)

	var_10_1:addChild(var_10_18)
	var_10_18:align(cc.p(0.5, 1), var_10_1:size().w / 2, var_10_17:pos().y - var_10_17:size().h)
	table.insert(self._skillInheritLayoutTable, var_10_18)

	local var_10_19 = TempWidget:CreateTempLabel(L_HORCRUX_DEVOUR[7], FONT_NAME, 22, var_10_1)

	var_10_19:_setColor("9794a6")
	var_10_19:align(cc.p(0, 1), var_10_2:pos().x + 25, var_10_18:pos().y - var_10_18:size().h - 20)

	local var_10_20 = global_get_all_model_attrs(servant_data[self._servantId].modelid)
	local var_10_21

	if var_10_20 == "shiling" or var_10_20 == "umaru" or var_10_20 == "zerosupperession" then
		var_10_19:setString(L_HORCRUX_DEVOUR_SELECT[1])
	elseif var_10_20 == "imaginary" then
		var_10_19:setString(L_HORCRUX_DEVOUR_SELECT[2])
	else
		var_10_21 = ccui.ImageView:create(ATTRICONPATH[var_10_20.main], var_0_2)

		var_10_1:addChild(var_10_21)
		var_10_21:setPosition(var_10_19:getPositionX() + 115, 250)
		var_10_21:setScale(0.5, 0.5)
		var_10_21:setName("attrImg")

		if var_10_20.main == "mimicry" then
			var_10_21:loadTexture(ATTRICONPATH[var_10_20.sub[1]], var_0_2)
		end
	end

	local var_10_22 = TempWidget:CreateTempLabel(L_HORCRUX_DEVOUR[42], FONT_NAME, 22, var_10_1)

	var_10_22:_setColor("9794a6")
	var_10_22:align(cc.p(0, 1), var_10_19:pos().x + var_10_19:size().w + 230, var_10_19:pos().y)

	if self.exCount == 0 then
		var_10_22:hide()
		var_10_19:align(cc.p(0, 1), var_10_2:pos().x + 235, var_10_18:pos().y - var_10_18:size().h - 20)

		if var_10_21 then
			var_10_21:setPosition(var_10_19:getPositionX() + 115, 250)
		end
	end

	var_10_21:setVisible(false)

	local var_10_23 = TempWidget:CreateTempListView(var_10_1)

	var_10_23:setContentSize(cc.size(var_10_1:size().w - 100, 180))
	var_10_23:setDirection(ccui.ScrollViewDir.horizontal)
	var_10_23:align(cc.p(0.5, 1), var_10_1:size().w / 2, var_10_19:pos().y - var_10_19:size().h - 5)

	self._costList = var_10_23

	self:initCostList()

	local var_10_24 = TempWidget:CreateTempBtn("public/button/public_button_normal_y.png", var_10_1)

	var_10_24:align(cc.p(0.5, 1), 450, 0)
	var_10_24:setName("sureBtn")

	self._sureBtn = var_10_24

	local var_10_25 = TempWidget:CreateTempLabel(L_HORCRUX_DEVOUR[47], FONT_NAME, 30, var_10_24:getVirtualRenderer())

	var_10_25:_setColor("0a0a0a")
	var_10_25:center()

	self._sureLabel = var_10_25

	self:updateSureLabel()

	local var_10_26, var_10_27 = var_0_7:getCostItemId(self._servantId)
	local var_10_28 = item_manager:getItemNumber(var_10_26)
	local var_10_29 = TempWidget:CreateTempImg("equipment/" .. var_10_26 .. ".png", var_10_1, 0)

	var_10_29:setScale(0.5)
	var_10_29:align(cc.p(0.5, 0.5), var_10_24:pos().x - 340, var_10_24:pos().y - var_10_24:size().h / 2)
	var_10_29:setTouchEnabled(true)
	var_10_29:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopItemLayer", {
			itemid = var_10_26
		})
	end)

	local var_10_30 = TempWidget:CreateTempLabel(var_10_27 .. "/" .. var_10_28, FONT_NAME, 25, var_10_1)

	var_10_30:_setColor((var_10_28 < var_10_27 or nil) and "ff0000")
	var_10_30:align(cc.p(0.5, 0.5), var_10_29:pos().x + 60, var_10_29:pos().y)
end

function HorcruxDevourSelectLayer:initListener()
	self._root:_addEvent(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
	self._sureBtn:_addEvent(function()
		local var_15_0 = self.manager:getMaterialsNum()
		local var_15_1 = self.manager:getDevourEntityId()

		if not var_15_1 then
			self:selectCostHorcrux(1)

			return
		end

		if var_15_0 < self.exCount then
			if not self.manager:getMaterialsByIndex(1) then
				self:selectCostHorcrux(2)
			elseif not self.manager:getMaterialsByIndex(2) then
				self:selectCostHorcrux(3)
			end

			return
		end

		local var_15_2, var_15_3 = var_0_7:getCostItemId(self._servantId)

		if var_15_3 > item_manager:getItemNumber(var_15_2) then
			LayerManager:pushInLayer("PopItemLayer", {
				itemid = var_15_2
			})

			return
		end

		if var_15_1 and var_15_0 == self.exCount then
			self.manager:requestHorcruxDevour(self._selectIndex)
		end
	end)
end

function HorcruxDevourSelectLayer:initSelectFacGradeImg()
	local var_16_0 = TempWidget:CreateTempLayout(self._bg)

	var_16_0:setContentSize(cc.size(165, 25))
	var_16_0:align(cc.p(1, 1), self._bg:size().w - 20, self._bg:getContentSize().height - 102)

	self._selectFacGradeImg = var_16_0

	local var_16_1 = TempWidget:CreateTempImg(var_0_3 .. "atk.png", var_16_0)

	var_16_1:align(cc.p(0, 0.5), 0, var_16_0:size().h / 2)

	local var_16_2 = TempWidget:CreateTempImg(var_0_3 .. "value_bg.png", var_16_0)

	var_16_2:align(cc.p(0, 0.5), var_16_1:pos().x + var_16_1:size().w + 5, var_16_1:pos().y)
	var_16_2:setScale9Enabled(true)
	var_16_2:setCapInsets(cc.rect(0, 0, var_16_2:size().w, var_16_2:size().h))
	var_16_2:setContentSize(cc.size(40, var_16_2:size().h))

	local var_16_3 = TempWidget:CreateTempImg(var_0_11.c, var_16_2)

	var_16_3:align(cc.p(1, 0.5), var_16_2:size().w - 5, var_16_2:size().h / 2)

	local var_16_4 = TempWidget:CreateTempImg(var_0_3 .. "hp.png", var_16_0)

	var_16_4:align(cc.p(0, 0.5), var_16_2:pos().x + var_16_2:size().w + 10, var_16_2:pos().y)

	local var_16_5 = TempWidget:CreateTempImg(var_0_3 .. "value_bg.png", var_16_0)

	var_16_5:setScale9Enabled(true)
	var_16_5:setCapInsets(cc.rect(0, 0, var_16_5:size().w, var_16_5:size().h))
	var_16_5:setContentSize(cc.size(40, var_16_5:size().h))
	var_16_5:align(cc.p(0, 0.5), var_16_4:pos().x + var_16_4:size().w + 5, var_16_4:pos().y)

	local var_16_6 = TempWidget:CreateTempImg(var_0_11.c, var_16_5)

	var_16_6:align(cc.p(1, 0.5), var_16_5:size().w - 5, var_16_5:size().h / 2)

	function var_16_0._update()
		local var_17_0 = var_0_7:getSkillInfo(self._servantId, self._selectIndex)

		if var_17_0 then
			var_16_0:show()
			var_16_6:loadTextureEx(var_0_11[horcrux_manager:getHorcruxHpFacSectionGrade(var_17_0.horcrux)])
			var_16_3:loadTextureEx(var_0_11[horcrux_manager:getHorcruxDamageFacSectionGrade(var_17_0.horcrux)])
		else
			var_16_0:hide()
		end
	end

	var_16_0._update()
end

function HorcruxDevourSelectLayer:initDevourFacGradeImg()
	local var_18_0 = TempWidget:CreateTempLayout(self._bg)

	var_18_0:setContentSize(cc.size(165, 25))
	var_18_0:align(cc.p(1, 1), self._bg:size().w - 20, self._bg:getContentSize().height - 500)

	self._devourFacGradeImg = var_18_0

	local var_18_1 = TempWidget:CreateTempImg(var_0_3 .. "atk.png", var_18_0)

	var_18_1:align(cc.p(0, 0.5), 0, var_18_0:size().h / 2)

	local var_18_2 = TempWidget:CreateTempImg(var_0_3 .. "value_bg.png", var_18_0)

	var_18_2:align(cc.p(0, 0.5), var_18_1:pos().x + var_18_1:size().w + 5, var_18_1:pos().y)
	var_18_2:setScale9Enabled(true)
	var_18_2:setCapInsets(cc.rect(0, 0, var_18_2:size().w, var_18_2:size().h))
	var_18_2:setContentSize(cc.size(40, var_18_2:size().h))

	local var_18_3 = TempWidget:CreateTempImg(var_0_11.c, var_18_2)

	var_18_3:align(cc.p(1, 0.5), var_18_2:size().w - 5, var_18_2:size().h / 2)

	local var_18_4 = TempWidget:CreateTempImg(var_0_3 .. "hp.png", var_18_0)

	var_18_4:align(cc.p(0, 0.5), var_18_2:pos().x + var_18_2:size().w + 10, var_18_2:pos().y)

	local var_18_5 = TempWidget:CreateTempImg(var_0_3 .. "value_bg.png", var_18_0)

	var_18_5:setScale9Enabled(true)
	var_18_5:setCapInsets(cc.rect(0, 0, var_18_5:size().w, var_18_5:size().h))
	var_18_5:setContentSize(cc.size(40, var_18_5:size().h))
	var_18_5:align(cc.p(0, 0.5), var_18_4:pos().x + var_18_4:size().w + 5, var_18_4:pos().y)

	local var_18_6 = TempWidget:CreateTempImg(var_0_11.c, var_18_5)

	var_18_6:align(cc.p(1, 0.5), var_18_5:size().w - 5, var_18_5:size().h / 2)

	function var_18_0._update()
		local var_19_0 = self.manager:getDevourEntityId()

		if var_19_0 then
			var_18_0:show()
			var_18_6:loadTextureEx(var_0_11[horcrux_manager:getHorcruxHpFacSectionGrade(var_19_0)])
			var_18_3:loadTextureEx(var_0_11[horcrux_manager:getHorcruxDamageFacSectionGrade(var_19_0)])
		else
			var_18_0:hide()
		end
	end

	var_18_0._update()
end

function HorcruxDevourSelectLayer:initListSkillImgList()
	if HORCRUX_DEVOUR_MAX == 4 then
		self._skillImgList:setItemsMargin(28)
	end

	for iter_20_0 = 1, HORCRUX_DEVOUR_MAX do
		self._skillImgList:pushBackCustomItem((self:createSkillImgLayout(iter_20_0)))
	end
end

function HorcruxDevourSelectLayer:initCostList()
	for iter_21_0 = 1, 3 do
		self._costList:pushBackCustomItem((self:createHorcruxCostLayout(iter_21_0)))
	end
end

function HorcruxDevourSelectLayer:createSkillImgLayout(arg_22_1)
	local var_22_0 = TempWidget:CreateTempLayout()

	var_22_0:setContentSize(cc.size(115, 140))
	var_22_0:_addEvent(function()
		if var_0_7:isUnlock(self._servantId, arg_22_1) then
			if self._selectIndex > arg_22_1 then
				self.manager:setMaterials({})
				self.manager:setDevourEntityId(nil)
			end

			self._selectIndex = arg_22_1

			self:updateSkillImgLayout()
			self:updateSureLabel()
			self:updateSelectSkillNameLabel()
			self:updateSelectSkillDesText()
			self._selectFacGradeImg._update()

			self.exCount = var_0_7:getExCountByIndex(self._servantId, self._selectIndex)

			self:updateCostLayout()
		else
			global_ShowBlockWords(L_HORCRUX_DEVOUR[46])
		end
	end)

	local var_22_1 = TempWidget:CreateTempImg(var_0_3 .. "horcrux_bg.png", var_22_0)

	var_22_1:center()

	local var_22_2 = HorcruxSprite:create({
		initType = "previewStyle"
	})

	var_22_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_22_0:addChild(var_22_2)
	var_22_2:setPosition(cc.p(var_22_0:size().w / 2, var_22_0:size().h / 2))
	var_22_2:setScale(0.8)
	var_22_2:setTouchEnabled(false)

	local var_22_3 = TempWidget:CreateTempImg("public/currency/lock.png", var_22_1)

	var_22_3:center()

	local var_22_4 = TempWidget:CreateTempImg(var_0_3 .. "select_rect.png", var_22_0)

	var_22_4:center()
	var_22_4:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(0.75), cc.FadeIn:create(0.75))))
	var_22_4:hide()

	function var_22_0._update()
		var_22_2:setVisible(false)
		var_22_4:setVisible(self._selectIndex == arg_22_1)

		local var_24_0 = self.manager:getLayerSkillInfo(self._servantId, arg_22_1)

		if var_24_0 then
			var_22_2:setVisible(true)
			var_22_2:update(var_24_0.horcrux)
			ccui.Helper:seekWidgetByName(var_22_2, "lock"):setVisible(false)
			var_22_3:hide()
		elseif var_0_7:isUnlock(self._servantId, arg_22_1) then
			var_22_3:hide()
		else
			var_22_3:show()
		end
	end

	var_22_0._update()

	return var_22_0
end

function HorcruxDevourSelectLayer:createSkillInheritLayout(arg_25_1)
	local var_25_0 = TempWidget:CreateTempLayout()

	var_25_0:setContentSize(cc.size(self._bg:size().w, 120))

	local var_25_1 = TempWidget:CreateTempImg(var_0_3 .. "skill_inherit_bg.png", var_25_0)

	var_25_1:center()

	local var_25_2 = TempWidget:CreateTempLayout(var_25_0)

	var_25_2:setContentSize(cc.size(200, 50))
	var_25_2:align(cc.p(0.5, 0.5), var_25_0:size().w / 2, var_25_0:size().h / 2)

	local var_25_3 = TempWidget:CreateTempImg(var_0_3 .. "tip.png", var_25_2)

	var_25_3:align(cc.p(0.5, 0), var_25_2:size().w / 2, 10)

	local var_25_4 = TempWidget:CreateTempLabel(L_HORCRUX_DEVOUR[6], FONT_NAME, 22, var_25_2)

	var_25_4:_setColor("9794a6")
	var_25_4:align(cc.p(0.5, 0), var_25_2:size().w / 2, var_25_3:pos().y + var_25_3:size().h - 10)

	local var_25_5 = TempWidget:CreateTempImg(var_0_3 .. "none_skill_bg.png", var_25_1)

	var_25_5:center()

	local var_25_6 = TempWidget:CreateTempImg("skill_new/skill/20100.png", var_25_1)

	var_25_6:setScale(0.85)
	var_25_6:align(cc.p(0, 0.5), 10, var_25_1:getContentSize().height / 2)

	local var_25_7 = TempWidget:CreateTempLabel("name", FONT_NAME, 30, var_25_1)

	var_25_7:_setColor("00ffle")
	var_25_7:align(cc.p(0, 1), var_25_6:pos().x + var_25_6:size().w, var_25_6:pos().y + 50)

	local var_25_8 = RichTextPro:create()

	var_25_8:setAnchorPoint(cc.p(0, 1))
	var_25_8:setPosition(cc.p(var_25_6:pos().x + var_25_6:size().w, var_25_6:pos().y + 20))
	var_25_8:setMaxWidth(420)
	var_25_8:setSize(22)
	var_25_8:setLineSpace(0)
	var_25_1:addChild(var_25_8)

	function var_25_0._update()
		var_25_6:hide()
		var_25_7:hide()
		var_25_8:setVisible(false)
		var_25_5:hide()

		local var_26_0 = self.manager:getDevourEntityId()

		if var_26_0 then
			var_25_2:hide()

			local var_26_1 = false
			local var_26_2 = horcrux_manager:getHorcruxSkills(var_26_0)

			if var_26_2 and var_26_2[arg_25_1] then
				var_26_1 = true
			end

			local var_26_3 = playermodel.items[var_26_0].horcrux_attr.star or 0

			if playermodel.items[var_26_0].horcrux_attr.enable_skill_idxs then
				var_26_1 = false

				for iter_26_0, iter_26_1 in pairs(playermodel.items[var_26_0].horcrux_attr.enable_skill_idxs) do
					if iter_26_1 == arg_25_1 then
						var_26_1 = true

						break
					end
				end
			end

			if var_26_1 then
				var_25_7:show()
				var_25_8:setVisible(true)

				local var_26_4 = self.manager:getSkillReplaceProbability()

				var_25_6:show()
				var_25_6:loadTexture("skill_new/skill/" .. total_skill_data[var_26_2[arg_25_1]].icon .. ".png", var_0_2)
				var_25_8:clearText()
				var_25_8:setText((transSkillDesToRichText(total_skill_data[var_26_2[arg_25_1]].description)))

				local var_26_5 = total_skill_data[var_26_2[arg_25_1]].name

				if arg_25_1 == 1 then
					if var_26_3 == 6 then
						var_26_5 = var_26_5 .. "+"
					elseif var_26_3 == 7 then
						var_26_5 = var_26_5 .. "++"
					elseif var_26_3 == 8 then
						var_26_5 = var_26_5 .. "Max"
					end
				end

				var_25_7:setString(var_26_5)
			else
				var_25_5:show()
			end
		else
			var_25_2:show()
		end
	end

	var_25_0._update()

	return var_25_0
end

function HorcruxDevourSelectLayer:createHorcruxCostLayout(arg_27_1)
	local var_27_0 = var_0_7:getDevourHorcruxMinData(self._servantId, arg_27_1 >= 2)
	local var_27_1 = TempWidget:CreateTempLayout()

	var_27_1:setName("HorcruxCost" .. arg_27_1)
	var_27_1:setContentSize(cc.size(160, 190))

	local var_27_2 = TempWidget:CreateTempImg("public/rolebg/horcrux_rarity_1.png", var_27_1)

	var_27_2:setName("horcruxbg" .. arg_27_1)
	var_27_2:center()
	var_27_2:_addEvent(function()
		self:selectCostHorcrux(arg_27_1)
	end)

	if arg_27_1 == 2 then
		local var_27_3 = TempWidget:CreateTempLayout(var_27_1)

		var_27_3:setContentSize(cc.size(50, var_27_1:size().h))
		var_27_3:align(cc.p(0, 0), 0, 0)
		var_27_1:setContentSize(cc.size(210, 190))
		var_27_2:align(cc.p(0.5, 0.5), (var_27_1:size().w - 50) / 2 + 50, var_27_1:size().h / 2)
	end

	var_27_1._type = arg_27_1 == 1 and "devour" or "material"

	local var_27_4 = HorcruxSprite:create({
		initType = "previewStyle"
	})

	var_27_4:setPositionX(var_27_2:getContentSize().width / 2)
	var_27_4:setPositionY(var_27_2:getContentSize().height / 2)
	var_27_4:setAnchorPoint(cc.p(0.5, 0.5))
	var_27_4:setScale(0.8)
	var_27_4:setTouchEnabled(false)
	var_27_2:addChild(var_27_4)

	local var_27_5 = ccui.ImageView:create(var_0_3 .. "horcrux_null.png", var_0_2)

	var_27_5:setPosition(var_27_2:getContentSize().width / 2, var_27_2:getContentSize().height / 2)
	var_27_2:addChild(var_27_5)
	var_27_5:setVisible(false)

	function var_27_1._update()
		var_27_2:center()

		local var_29_0 = var_0_7:getDevourHorcruxMinDataFromIndex(self._servantId, self._selectIndex - 1, arg_27_1 >= 2)
		local var_29_1 = self.manager:getDevourEntityId()

		if arg_27_1 == 1 then
			if var_29_1 then
				var_27_4:update(var_29_1)
				var_27_4.horcrux:setScale(0.45)
				var_27_4:getChildByName("careerIcon"):setVisible(true)
				var_27_4:getChildByName("lvLabel"):setVisible(true)
			else
				var_27_4:setUnkonw(nil, nil, var_29_0.star)
				var_27_4:getChildByName("careerIcon"):setVisible(false)
				var_27_4:getChildByName("lvLabel"):setVisible(true)
				var_27_4:getChildByName("lvLabel"):setString(var_29_0.level)
			end
		else
			local var_29_2 = self.manager:getMaterialsByIndex(arg_27_1 - 1)

			if var_29_2 then
				var_27_4:update(var_29_2)
				var_27_4.horcrux:setScale(0.45)
				var_27_4:getChildByName("careerIcon"):setVisible(true)
				var_27_4:getChildByName("lvLabel"):setVisible(true)
			else
				var_27_4:setUnkonw(nil, nil, var_29_0.star)
				var_27_4:getChildByName("careerIcon"):setVisible(false)
				var_27_4:getChildByName("lvLabel"):setVisible(true)
				var_27_4:getChildByName("lvLabel"):setString(var_29_0.level)
			end
		end

		if self.exCount == 0 and (arg_27_1 == 2 or arg_27_1 == 3) or self.exCount == 1 and arg_27_1 == 3 then
			var_27_5:setVisible(true)
			var_27_2:setTouchEnabled(false)
		else
			var_27_5:setVisible(false)
			var_27_2:setTouchEnabled(true)
			var_27_1:setVisible(true)
		end

		if arg_27_1 > self.exCount + 1 then
			var_27_1:setVisible(false)
		elseif self.exCount == 0 then
			-- block empty
		end
	end

	var_27_1._update()

	return var_27_1
end

function HorcruxDevourSelectLayer:selectCostHorcrux(arg_30_1)
	local var_30_0 = self.manager:getDevourEntityId()

	if arg_30_1 > 1 and not var_30_0 then
		global_ShowBlockWords(L_HORCRUX_DEVOUR[8])

		return
	end

	local var_30_1 = {
		isHorcruxDevour = true,
		selectType = SELECT_HORCRUX_DEVOUR,
		outSide = {},
		selectGirlServantId = self._servantId,
		selectCallback = function()
			print("selectCallback")
		end
	}

	if arg_30_1 == 1 then
		var_30_1.curHorcrux = var_30_0
		var_30_1.outSide = {}

		table.insert(var_30_1.outSide, self.manager:getMaterialsByIndex(1))
		table.insert(var_30_1.outSide, self.manager:getMaterialsByIndex(2))
	else
		var_30_1.outSide = {
			var_30_0
		}

		if arg_30_1 == 2 then
			table.insert(var_30_1.outSide, self.manager:getMaterialsByIndex(2))
		elseif arg_30_1 == 3 then
			table.insert(var_30_1.outSide, self.manager:getMaterialsByIndex(1))
		end

		var_30_1.curHorcrux = self.manager:getMaterialsByIndex(arg_30_1 - 1)
	end

	local var_30_2 = self.manager:getOutSideHorcruxs(self._servantId, {
		attrFilter = arg_30_1 == 1,
		index = arg_30_1,
		selectIndex = self._selectIndex
	})

	for iter_30_0 = 1, #var_30_1.outSide do
		var_30_2[#var_30_2 + 1] = var_30_1.outSide[iter_30_0]
	end

	var_30_1.outSide = var_30_2
	var_30_1.mainHorcrux = arg_30_1 == 1

	self.manager:setSelectIndex(arg_30_1)
	LayerManager:pushInLayer("HorcruxSelectLayer", var_30_1)
end

function HorcruxDevourSelectLayer:updateLayer()
	return
end

function HorcruxDevourSelectLayer:updateRed()
	return
end

function HorcruxDevourSelectLayer:updateSkillImgLayout()
	local var_34_0 = self._skillImgList:getChildren()

	for iter_34_0 = 1, #var_34_0 do
		var_34_0[iter_34_0]._update()
	end
end

function HorcruxDevourSelectLayer:updateCostLayout()
	local var_35_0 = self._costList:getItems()

	for iter_35_0 = 1, #var_35_0 do
		var_35_0[iter_35_0]._update()
	end
end

function HorcruxDevourSelectLayer:setDevourHorcrux(arg_36_1)
	local var_36_0 = self.manager:getSelectIndex()
	local var_36_1 = self._costList:getItems()

	for iter_36_0 = 1, #var_36_1 do
		var_36_1[iter_36_0]._update()
	end

	for iter_36_1 = 1, #self._skillInheritLayoutTable do
		self._skillInheritLayoutTable[iter_36_1]._update()
	end

	self._devourFacGradeImg._update()
end

function HorcruxDevourSelectLayer:updateSureLabel()
	if var_0_7:getSkillInfo(self._servantId, self._selectIndex) then
		self._sureBtn:loadTextureNormal("public/button/public_button_blue.png", var_0_2)
		self._sureLabel:setString(L_HORCRUX_DEVOUR[48])
	else
		self._sureBtn:loadTextureNormal("public/button/public_button_normal_y.png", var_0_2)
		self._sureLabel:setString(L_HORCRUX_DEVOUR[47])
	end
end

function HorcruxDevourSelectLayer:breakAnimation(arg_38_1, arg_38_2)
	local var_38_0 = ccui.Layout:create()

	var_38_0:setTouchEnabled(true)
	var_38_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_38_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_38_0:setName("HorcruxDevourSelectLayerBreakAnimation")
	var_38_0:setPosition(cc.p(self._root:size().w / 2, self._root:size().h / 2))
	var_38_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_38_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_38_0:setBackGroundColorOpacity(180)
	global_basic_scene:addChild(var_38_0, 999)

	local var_38_1 = ccui.ImageView:create("roleimage/role1/" .. model_data[global_get_servant_skin(arg_38_1)].cute_role .. ".png")

	var_38_1:setPosition(cc.p(var_38_0:getContentSize().width / 2 + 15, var_38_0:getContentSize().height / 2 + 50))
	var_38_0:addChild(var_38_1, 100)
	var_38_1:setScale(0.7)

	local var_38_2 = false

	var_38_0:runAction(cc.Sequence:create(cc.CallFunc:create(function()
		local var_47_0 = L2Skeleton:create("spine/ui/upgrade/up.json", "spine/ui/upgrade/up.atlas")

		var_47_0:refreshSkeleton()
		var_47_0.skeletonAnimation:setPositionX(var_38_0:getContentSize().width / 2 + 20)
		var_47_0.skeletonAnimation:setPositionY(var_38_0:getContentSize().height / 2)
		var_47_0:setName("upSpine")
		var_47_0:setScale(2)
		var_47_0:play("tupo", false)
		var_38_0:addChild(var_47_0, 150)

		local var_47_1 = L2Skeleton:create("spine/ui/upgrade/down.json", "spine/ui/upgrade/down.atlas")

		var_47_1:refreshSkeleton()
		var_47_1.skeletonAnimation:setPositionX(var_38_0:getContentSize().width / 2 + 20)
		var_47_1.skeletonAnimation:setPositionY(var_38_0:getContentSize().height / 2 - 80)
		var_47_1:setName("downSpine")
		var_47_1:setScale(1.5)
		var_47_1:play("tupo", false)
		var_38_0:addChild(var_47_1, 50)
	end), cc.DelayTime:create(2.3), cc.CallFunc:create(function()
		local var_39_0 = TempWidget:CreateTempImg(var_0_3 .. "weapon_light.png")

		var_39_0:setPosition(cc.p(var_38_0:getContentSize().width / 2, var_38_0:getContentSize().height / 2))
		var_39_0:setScale(0.1)
		var_38_0:addChild(var_39_0, 999)
		var_39_0:runAction(cc.Sequence:create(cc.ScaleTo:create(0.3, 100), cc.RemoveSelf:create()))
		var_38_1:setVisible(false)
	end), cc.DelayTime:create(0.3), cc.CallFunc:create(function()
		local var_40_0 = var_38_0:getChildByName("upSpine")
		local var_40_1 = var_38_0:getChildByName("downSpine")

		if var_40_0 then
			var_40_0:setVisible(false)
		end

		if var_40_1 then
			var_40_1:setVisible(false)
		end

		local var_40_2 = TempWidget:CreateTempImg(var_0_3 .. "inherit_bg.png", var_38_0)

		var_40_2:align(cc.p(0.5, 0.5), var_38_0:getContentSize().width / 2, var_38_0:getContentSize().height / 2)

		local var_40_3 = TempWidget:CreateTempImg(var_0_3 .. "achievement_bg.png", var_40_2)

		var_40_3:align(cc.p(0.5, 1), var_40_2:getContentSize().width / 2, var_40_2:getContentSize().height + 20)
		var_40_3:setScale(0, 1)
		var_40_3:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 1), cc.CallFunc:create(function()
			local var_41_0 = cc.Label:createWithTTF(L_HORCRUX_DEVOUR[13], FONT_NAME, 30)

			var_41_0:setColor(cc.c3b(0, 0, 0))
			var_41_0:setPosition(cc.p(var_40_3:getContentSize().width / 2, var_40_3:getContentSize().height / 2))
			var_40_3:addChild(var_41_0, 999)
		end)))

		local var_40_4 = TempWidget:CreateTempImg(var_0_3 .. "title.png", var_40_2)

		var_40_4:align(cc.p(0.5, 1), var_40_2:getContentSize().width / 2, var_40_3:pos().y - var_40_3:size().h + 10)
		TempWidget:CreateTempLabel(L_HORCRUX_DEVOUR[16], FONT_DES, 18, var_40_4):center()

		local var_40_5 = "ffc000"
		local var_40_6 = "ffc000"

		if arg_38_2.changedHp < 0 then
			var_40_5 = "ff0000"
		end

		if arg_38_2.changedDamage < 0 then
			var_40_6 = "ff0000"
		end

		local var_40_7 = TempWidget:CreateTempImg(var_0_3 .. "base_attr_bg.png", var_40_2)

		var_40_7:align(cc.p(0.5, 1), var_40_2:getContentSize().width / 2, var_40_4:pos().y - var_40_4:size().h - 10)
		TempWidget:CreateTempImg(var_0_3 .. "hp.png", var_40_7):align(cc.p(1, 0.5), -10, var_40_7:getContentSize().height / 2)
		TempWidget:CreateTempLabel(arg_38_2.oldHp, FONT_DES, 22, var_40_7):align(cc.p(1, 0.5), var_40_7:size().w / 2 - 60, var_40_7:size().h / 2 - 3)

		if arg_38_2.oldSkillInfo then
			TempWidget:CreateTempImg(var_0_11[horcrux_manager:getHorcruxHpFacSectionGrade(arg_38_2.oldSkillInfo.horcrux)], var_40_7):align(cc.p(0, 0.5), 15, var_40_7:size().h / 2)
		end

		local var_40_8 = TempWidget:CreateTempLabel(arg_38_2.newHp, FONT_DES, 22, var_40_7)

		var_40_8:_setColor(var_40_5)
		var_40_8:align(cc.p(0, 0.5), var_40_7:size().w / 2 + 60, var_40_7:size().h / 2 - 3)
		TempWidget:CreateTempImg(var_0_11[horcrux_manager:getHorcruxHpFacSectionGrade(arg_38_2.newSkillInfo.horcrux)], var_40_7):align(cc.p(1, 0.5), var_40_7:size().w - 10, var_40_7:size().h / 2)

		local var_40_10 = TempWidget:CreateTempLabel((arg_38_2.changedHp > 0 or nil) and "+" .. arg_38_2.changedHp, FONT_DES, 18, var_40_7)

		var_40_10:_setColor(var_40_5)
		var_40_10:align(cc.p(0.5, 0.5), var_40_7:size().w / 2, var_40_7:size().h / 2 + 8)

		local var_40_11 = TempWidget:CreateTempImg(var_0_3 .. "base_attr_bg.png", var_40_2)

		var_40_11:align(cc.p(0.5, 1), var_40_2:getContentSize().width / 2, var_40_7:pos().y - var_40_7:size().h - 10)
		TempWidget:CreateTempImg(var_0_3 .. "atk.png", var_40_11):align(cc.p(1, 0.5), -10, var_40_11:getContentSize().height / 2)
		TempWidget:CreateTempLabel(arg_38_2.oldDamage, FONT_DES, 22, var_40_11):align(cc.p(1, 0.5), var_40_11:size().w / 2 - 60, var_40_11:size().h / 2 - 3)

		if arg_38_2.oldSkillInfo then
			TempWidget:CreateTempImg(var_0_11[horcrux_manager:getHorcruxDamageFacSectionGrade(arg_38_2.oldSkillInfo.horcrux)], var_40_11):align(cc.p(0, 0.5), 15, var_40_11:size().h / 2)
		end

		local var_40_12 = TempWidget:CreateTempLabel(arg_38_2.newDamage, FONT_DES, 22, var_40_11)

		var_40_12:_setColor(var_40_6)
		var_40_12:align(cc.p(0, 0.5), var_40_11:size().w / 2 + 60, var_40_11:size().h / 2 - 3)
		TempWidget:CreateTempImg(var_0_11[horcrux_manager:getHorcruxDamageFacSectionGrade(arg_38_2.newSkillInfo.horcrux)], var_40_11):align(cc.p(1, 0.5), var_40_11:size().w - 10, var_40_11:size().h / 2)

		local var_40_14 = TempWidget:CreateTempLabel((arg_38_2.changedDamage > 0 or nil) and "+" .. arg_38_2.changedDamage, FONT_DES, 18, var_40_11)

		var_40_14:_setColor(var_40_6)
		var_40_14:align(cc.p(0.5, 0.5), var_40_11:size().w / 2, var_40_11:size().h / 2 + 8)

		local var_40_15 = TempWidget:CreateTempImg(var_0_3 .. "title.png", var_40_2)

		var_40_15:align(cc.p(0.5, 1), var_40_2:getContentSize().width / 2, var_40_11:pos().y - var_40_11:size().h - 10)
		TempWidget:CreateTempLabel(L_HORCRUX_DEVOUR[17], FONT_DES, 18, var_40_15):center()

		local function var_40_16(arg_42_0)
			arg_42_0 = arg_42_0 or {}

			local var_42_0 = arg_42_0.tagStr
			local var_42_1 = math.abs(arg_42_0.showSkillId)
			local var_42_2 = math.abs(arg_42_0.showSkillId2)
			local var_42_3 = TempWidget:CreateTempLayout()

			var_42_3:setContentSize(cc.size(var_40_2:size().w, 130))

			local var_42_4 = HorcruxSprite:create({
				initType = "previewStyle"
			})

			var_42_4:setAnchorPoint(cc.p(0.5, 0.5))
			var_42_3:addChild(var_42_4)
			var_42_4:setPosition(cc.p(var_42_4:getContentSize().width / 2, var_42_3:size().h / 2))
			var_42_4:setScale(0.7)
			var_42_4:setTouchEnabled(false)
			var_42_4:update(arg_42_0.entityId)
			ccui.Helper:seekWidgetByName(var_42_4, "lock"):setVisible(false)

			local var_42_5 = TempWidget:CreateTempImg(var_0_3 .. "tag.png", var_42_3)

			var_42_5:hide()
			var_42_5:align(cc.p(0.5, 0.5), 40, var_42_3:getContentSize().height - 10)

			local var_42_6 = TempWidget:CreateTempLabel("", FONT_DES, 17, var_42_5)

			var_42_6:_setColor("0a0a0a")
			var_42_6:center()

			if var_42_0 then
				var_42_5:show()
				var_42_6:setString(var_42_0)
			end

			local var_42_7 = TempWidget:CreateTempImg(var_0_3 .. "show_skill_bg.png", var_42_3)

			var_42_7:align(cc.p(0.5, 0.5), var_42_3:getContentSize().width / 2 + 30, var_42_3:getContentSize().height / 2)

			local var_42_8 = TempWidget:CreateTempImg("skill_new/skill/" .. total_skill_data[var_42_1].icon .. ".png", var_42_7)

			var_42_8:align(cc.p(0.5, 0.5), var_42_8:getContentSize().width / 2, var_42_7:getContentSize().height / 4)
			var_42_8:setScale(0.7)

			local var_42_9 = TempWidget:CreateTempLabel(var_0_7:getHorcruxSkillName(var_42_1, arg_42_0.entityId), FONT_DES, 22, var_42_7)

			var_42_9:align(cc.p(0, 1), var_42_8:pos().x + var_42_8:size().w / 2 + 10, var_42_7:getContentSize().height - 10)
			var_42_9:_setColor("01f207")

			local var_42_10 = RichTextPro:create()

			var_42_10:setAnchorPoint(cc.p(0, 1))
			var_42_10:setPosition(cc.p(var_42_9:pos().x, var_42_9:pos().y - var_42_9:size().h - 5))
			var_42_10:setMaxWidth(340)
			var_42_10:setSize(18)
			var_42_10:setText((transSkillDesToRichText(total_skill_data[var_42_1].description)))
			var_42_10:setLineSpace(0)
			var_42_7:addChild(var_42_10)

			local var_42_11 = TempWidget:CreateTempImg("skill_new/skill/" .. total_skill_data[var_42_2].icon .. ".png", var_42_7)

			var_42_11:align(cc.p(0.5, 0.5), var_42_11:getContentSize().width / 2, var_42_7:getContentSize().height * 3 / 4)
			var_42_11:setScale(0.7)

			local var_42_12 = TempWidget:CreateTempLabel(var_0_7:getHorcruxSkillName(var_42_2, arg_42_0.entityId), FONT_DES, 22, var_42_7)

			var_42_12:align(cc.p(0, 1), var_42_11:pos().x + var_42_11:size().w / 2 + 10, var_42_7:getContentSize().height - 80)
			var_42_12:_setColor("01f207")

			local var_42_13 = RichTextPro:create()

			var_42_13:setAnchorPoint(cc.p(0, 1))
			var_42_13:setPosition(cc.p(var_42_12:pos().x, var_42_12:pos().y - var_42_12:size().h - 5))
			var_42_13:setMaxWidth(340)
			var_42_13:setSize(18)
			var_42_13:setText((transSkillDesToRichText(total_skill_data[var_42_2].description)))
			var_42_13:setLineSpace(0)
			var_42_7:addChild(var_42_13)

			return var_42_3
		end

		if arg_38_2.isAddSkill then
			local var_40_17 = var_40_16({
				tagStr = L_HORCRUX_DEVOUR[19],
				showSkillId = arg_38_2.newSkillInfo.skillid,
				entityId = arg_38_2.newSkillInfo.horcrux,
				showSkillId2 = arg_38_2.newSkillInfo.skillid2
			})

			var_40_2:addChild(var_40_17)
			var_40_17:align(cc.p(0.5, 1), var_40_2:getContentSize().width / 2, var_40_15:pos().y - var_40_15:size().h - 10)
		else
			local var_40_18

			for iter_40_0 = 1, HORCRUX_DEVOUR_MAX do
				if var_0_7:getSkillInfo(arg_38_1, iter_40_0).newskill then
					var_40_18 = iter_40_0

					break
				end
			end

			local var_40_19 = var_40_16({
				tagStr = L_HORCRUX_DEVOUR[18],
				showSkillId = arg_38_2.newSkillInfo.newskill,
				entityId = arg_38_2.newSkillInfo.newhorcrux,
				showSkillId2 = arg_38_2.newSkillInfo.newskill2
			})

			var_40_2:addChild(var_40_19)
			var_40_19:align(cc.p(0.5, 1), var_40_2:getContentSize().width / 2, var_40_15:pos().y - var_40_15:size().h - 10)

			local var_40_20 = TempWidget:CreateTempImg(var_0_3 .. "replace_img.png", var_40_2)

			var_40_20:align(cc.p(0.5, 1), var_40_2:getContentSize().width / 2, var_40_19:pos().y - var_40_19:size().h - 10)

			local var_40_21 = var_40_16({
				showSkillId = arg_38_2.oldSkillInfo.skillid,
				entityId = arg_38_2.oldSkillInfo.horcrux,
				showSkillId2 = arg_38_2.oldSkillInfo.skillid2
			})

			var_40_2:addChild(var_40_21)
			var_40_21:align(cc.p(0.5, 1), var_40_2:getContentSize().width / 2, var_40_20:pos().y - var_40_20:size().h - 10)

			local var_40_22 = TempWidget:CreateTempBtn("public/button/public_button_normal_y.png", var_40_2)

			var_40_22:align(cc.p(0.5, 1), var_40_2:getContentSize().width / 2 + 120, -50)
			var_40_22:_addEvent(function()
				require("controller/horcrux_devour/horcrux_devour_select_manager"):getInstance():confirmNewSkill({
					replace = true,
					servantid = arg_38_1,
					pos = var_40_18
				}, function()
					global_basic_scene:removeChildByName("HorcruxDevourSelectLayerBreakAnimation")
				end, {
					horcruxId = arg_38_2.newSkillInfo.newhorcrux
				})
			end)

			local var_40_23 = TempWidget:CreateTempLabel(L_HORCRUX_DEVOUR[43], FONT_DES, 26, var_40_22:getVirtualRenderer())

			var_40_23:_setColor("0f0f0f")
			var_40_23:center()

			local var_40_24 = TempWidget:CreateTempBtn("public/button/public_button_blue.png", var_40_2)

			var_40_24:align(cc.p(0.5, 1), var_40_2:getContentSize().width / 2 - 120, var_40_22:pos().y)
			var_40_24:_addEvent(function()
				require("controller/horcrux_devour/horcrux_devour_select_manager"):getInstance():confirmNewSkill({
					replace = false,
					servantid = arg_38_1,
					pos = var_40_18
				}, function()
					global_basic_scene:removeChildByName("HorcruxDevourSelectLayerBreakAnimation")
				end, {
					horcruxId = arg_38_2.newSkillInfo.newhorcrux
				})
			end)

			local var_40_25 = TempWidget:CreateTempLabel(L_HORCRUX_DEVOUR[44], FONT_DES, 26, var_40_24:getVirtualRenderer())

			var_40_25:_setColor("0f0f0f")
			var_40_25:center()
			TempWidget:CreateTempLabel("", FONT_DES, 22, var_40_24:getVirtualRenderer()):move(var_40_24:size().w / 2, -10)
		end
	end), cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		if arg_38_2.isAddSkill then
			var_38_2 = true
		end
	end)))
	var_38_0:addTouchEventListener(function(arg_49_0, arg_49_1)
		if arg_49_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not var_38_2 then
			return
		end

		var_38_0:runAction(cc.RemoveSelf:create())
	end)
end

function HorcruxDevourSelectLayer:horcruxChangedUpdateCostList(arg_50_1)
	local var_50_0 = self._costList:getItems()
	local var_50_1 = self.manager:getMaterials()
	local var_50_2 = var_50_1[1]
	local var_50_3 = var_50_1[2]

	if var_50_1[1] and not playermodel.items[var_50_2] then
		self.manager:setMaterialsByIndex(1, nil)

		var_50_2 = nil
	end

	if var_50_3 and not playermodel.items[var_50_3] then
		self.manager:setMaterialsByIndex(2, nil)

		var_50_3 = nil
	end

	local var_50_4 = self.manager:getDevourEntityId()

	if var_50_4 and arg_50_1.entityid == var_50_4 then
		if var_50_2 then
			if playermodel.items[var_50_2].horcrux_attr.star < playermodel.items[var_50_4].horcrux_attr.star or playermodel.items[var_50_2].horcrux_attr.hlv < playermodel.items[var_50_4].horcrux_attr.hlv then
				self.manager:setMaterialsByIndex(1, nil)
			end
		end

		if var_50_3 then
			if playermodel.items[var_50_3].horcrux_attr.star < playermodel.items[var_50_4].horcrux_attr.star or playermodel.items[var_50_3].horcrux_attr.hlv < playermodel.items[var_50_4].horcrux_attr.hlv then
				self.manager:setMaterialsByIndex(2, nil)
			end
		end

		for iter_50_0 = 1, #self._skillInheritLayoutTable do
			self._skillInheritLayoutTable[iter_50_0]._update()
		end

		self._devourFacGradeImg._update()
	end

	for iter_50_1 = 1, #var_50_0 do
		var_50_0[iter_50_1]._update()
	end
end

function HorcruxDevourSelectLayer:updateSelectSkillNameLabel()
	local var_51_0 = var_0_7:getSkillInfo(self._servantId, self._selectIndex)

	if var_51_0 then
		self._selectSkillNameLabel1:show()

		local var_51_1 = total_skill_data[math.abs(var_51_0.skillid)].name

		if playermodel.items[var_51_0.horcrux].horcrux_attr.enable_skill_idxs then
			local var_51_2 = playermodel.items[var_51_0.horcrux].horcrux_attr.star or 0

			if playermodel.items[var_51_0.horcrux].horcrux_attr.enable_skill_idxs[1] == 1 then
				if var_51_2 == 6 then
					var_51_1 = var_51_1 .. "+"
				elseif var_51_2 == 7 then
					var_51_1 = var_51_1 .. "++"
				elseif var_51_2 == 8 then
					var_51_1 = var_51_1 .. "Max"
				end
			end
		end

		self._selectSkillNameLabel1:setString(var_51_1)
		self._selectSkillNameLabel2:show()

		local var_51_3 = total_skill_data[math.abs(var_51_0.skillid2)].name

		if playermodel.items[var_51_0.horcrux].horcrux_attr.enable_skill_idxs then
			local var_51_4 = playermodel.items[var_51_0.horcrux].horcrux_attr.star or 0

			if playermodel.items[var_51_0.horcrux].horcrux_attr.enable_skill_idxs[1] == 1 then
				if var_51_4 == 6 then
					var_51_3 = var_51_3 .. "+"
				elseif var_51_4 == 7 then
					var_51_3 = var_51_3 .. "++"
				elseif var_51_4 == 8 then
					var_51_3 = var_51_3 .. "Max"
				end
			end
		end

		self._selectSkillNameLabel2:setString(var_51_3)
	else
		self._selectSkillNameLabel1:hide()
		self._selectSkillNameLabel2:hide()
	end
end

function HorcruxDevourSelectLayer:updateSelectSkillDesText()
	local var_52_0 = var_0_7:getSkillInfo(self._servantId, self._selectIndex)
	local var_52_1 = self._selectSkillDesText2
	local var_52_2 = self._skillFrame2
	local var_52_3 = self._skillImg2
	local var_52_4 = self._repeatImg1
	local var_52_5 = self._repeatImg2

	if var_52_0 then
		self._selectSkillDesText1:setVisible(true)

		local var_52_6 = math.abs(var_52_0.skillid)

		self._selectSkillDesText1:clearText()
		self._selectSkillDesText1:setText((transSkillDesToRichText(total_skill_data[var_52_6].description)))
		self._skillFrame1:setVisible(true)
		self._skillImg1:setVisible(true)
		self._skillImg1:loadTexture("skill_new/skill/" .. total_skill_data[var_52_6].icon .. ".png", var_0_2)

		if var_52_0.skillid < 0 then
			var_52_4:setVisible(true)
		else
			var_52_4:setVisible(false)
		end

		var_52_1:setVisible(true)

		local var_52_7 = math.abs(var_52_0.skillid2)

		var_52_1:clearText()
		var_52_1:setText((transSkillDesToRichText(total_skill_data[var_52_7].description)))
		var_52_2:setVisible(true)
		var_52_3:setVisible(true)
		var_52_3:loadTexture("skill_new/skill/" .. total_skill_data[var_52_7].icon .. ".png", var_0_2)

		if var_52_0.skillid2 < 0 then
			var_52_5:setVisible(true)
		else
			var_52_5:setVisible(false)
		end
	else
		self._selectSkillDesText1:setVisible(false)
		var_52_1:setVisible(false)
		self._skillFrame1:setVisible(false)
		var_52_2:setVisible(false)
		self._skillImg1:setVisible(false)
		var_52_3:setVisible(false)
		var_52_4:setVisible(false)
		var_52_5:setVisible(false)
	end
end

function HorcruxDevourSelectLayer:horcruxLevelUpSucceeded(arg_53_1)
	self:horcruxChangedUpdateCostList(arg_53_1)
end

function HorcruxDevourSelectLayer:horcruxBreakoutSucceeded(arg_54_1)
	self:horcruxChangedUpdateCostList(arg_54_1)
end

function HorcruxDevourSelectLayer:horcruxUpStarSucceeded(arg_55_1)
	self:horcruxChangedUpdateCostList(arg_55_1)
end

return HorcruxDevourSelectLayer
