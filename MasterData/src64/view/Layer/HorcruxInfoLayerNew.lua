HorcruxInfoLayerNew = class("HorcruxInfoLayerNew", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local horcrux_manager = require("controller.horcrux_manager")
local bag_manager = require("controller.bag_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local filter_config_manager = require("controller.filter_config_manager")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local alert_manager = require("controller.alert_manager")
local drop_manager = require("controller.drop_manager")
local var_0_10 = require("controller/horcrux_devour/horcrux_devour_manager"):getInstance()
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local total_skill_data = require("data.total_skill_data")
local horcrux_strength_data = require("data.horcrux_strength_data")
local horcrux_break_data = require("data.horcrux_break_data")
local var_0_16 = require("data.item_data")

require("view.Sprite.BottomBtnList")
require("view.Sprite.TitleSprite")
require("view.Sprite.FilterSprite")
require("view.Sprite.FilterListSprite")
require("view.Sprite.HorcruxSprite")
require("view.Sprite.ItemSprite")

local FilterHorcurxSelectSprite = require("view.Sprite.FilterHorcurxSelectSprite")
local var_0_18
local var_0_20 = 0.9
local var_0_22 = 20
local var_0_25 = 0.5
local var_0_26 = 0.2
local var_0_27 = {
	"HorcruxInfo/lock_new.png",
	"HorcruxInfo/unlock.png"
}

function HorcruxInfoLayerNew.getInstance()
	return var_0_18
end

function HorcruxInfoLayerNew.create(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = HorcruxInfoLayerNew.new()

	var_3_0:init(arg_3_1, arg_3_2, arg_3_3, arg_3_4)

	return var_3_0
end

function HorcruxInfoLayerNew:init(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_4 = arg_4_4 or {}
	self.entityid = arg_4_1
	self.showType = arg_4_2
	self.isDevour = arg_4_4.isDevour
	self.devourPos = arg_4_4.devourPos
	self.devourOwner = arg_4_4.servantId
	self.selectedHorcruxList = {}
	self.selectedExpList = {}
	self.bagManager = bag_manager.create()
	self.filterAniFlag = true
	self.filterAniFlag1 = true
	self.filterPopModel = false
	self.defaultSortType = 1
	self.sortOrder = 1
	var_0_18 = self
	self.showAttr = false
	self.curExp = horcrux_manager:getHorcruxExp(arg_4_1)
	self.curLevel = horcrux_manager:getHorcruxHLV(arg_4_1)
	self.curSelectedExp = 0
	self.breakNum = 0
	self.addHorcruxEntityList = {}
	self.listDataType = 1
	self.horcruxMaxLevel = false
	self.goto_back_system_id = 520
	self.itemid = playermodel.items[arg_4_1].itemid
	self.filterTbl = filter_config_manager:getDefaultFilterData(filter_config_manager.HORCRUX_LAYER)
	self.filterTbl.outSide = {
		self.entityid
	}

	local var_4_1 = horcrux_manager:getHorcruxAttr(self.entityid)

	self.filterTbl.filterConfig.isBusy = {
		false
	}
	self.filterTbl.filterConfig.lock = {
		false
	}
	self.horcruxList = self.bagManager:getBagData(self.filterTbl)

	if arg_4_3 then
		local explore_manager = require("controller.explore_manager")

		for iter_4_0 = #self.horcruxList, 1, -1 do
			if explore_manager:queryHorcruxIsUsed(self.horcruxList[iter_4_0]) then
				table.remove(self.horcruxList, iter_4_0)
			end
		end
	end

	self:sortHorcruxList()

	self.mainAdditionSkills = horcrux_manager:getHorcruxSkillConfig(self.entityid)

	self:initHorcruxExpItems()
	self:initUI()
	self:initBottomBtnList()
	self:initDisplayValue(self.rootLayer)
	self:updateData()
	self:updateDisplayMode()
	self:updateAlert()
	self:updateUpstarBtn()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			self.bagManager:clear()

			var_0_18 = nil
		end
	end)
end

function HorcruxInfoLayerNew:updateData()
	self.oldExp = self.curExp
	self.oldLevel = self.curLevel
	self.curExp = horcrux_manager:getHorcruxExp(self.entityid)
	self.curLevel = horcrux_manager:getHorcruxHLV(self.entityid)
	self.horcruxMaxLevel = math.min(horcrux_manager:getHorcruxBreakLv(self.entityid) * 10, horcrux_manager:get_max_level(self.entityid)) <= self.curLevel or self.curLevel >= horcrux_manager:get_max_level(self.entityid)
	self.selectModel = 0
end

function HorcruxInfoLayerNew:updateAlert()
	item_manager:playerOpenNewItem(self.entityid)
	alert_manager:check_new_horcrux(false)
end

function HorcruxInfoLayerNew:updateDisplayMode()
	local var_8_0 = horcrux_manager:getHorcruxStarLevel(self.entityid)
	local var_8_1 = var_0_16[self.itemid].max_star

	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_changeMode"):setTitleFontSize(32)

	if self.horcruxMaxLevel then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_changeMode"):setTitleText(L_BUTTON_TEXT.Horcrux_Btn.Break_Through)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_changeMode"):getChildByName("Image_redDot"):setVisible(horcrux_manager:horcruxCanBreakOut(self.entityid))
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_changeMode"):getChildByName("Image_redDot"):loadTexture("public/reddot/reddot2.png", var_0_0)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_changeMode"):addTouchEventListener(var_8_0 < var_8_1 and horcrux_manager:getHorcruxHLV(self.entityid) == horcrux_manager:get_max_level_with_star(var_8_0) and self:getStarupHanel() or self:getComposeHandler())
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_changeMode"):setTitleText(L_BUTTON_TEXT.Horcrux_Btn.Level_Up)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_changeMode"):getChildByName("Image_redDot"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_changeMode"):addTouchEventListener(function(arg_9_0, arg_9_1)
			if arg_9_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:showUpLevelPop(self.entityid)
		end)
	end

	if horcrux_manager:getHorcruxHLV(self.entityid) >= horcrux_manager:get_max_level(self.entityid) and var_8_0 == var_8_1 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_changeMode"):setVisible(false)
	elseif horcrux_manager:getHorcruxHLV(self.entityid) == horcrux_manager:get_max_level_with_star(var_8_0) and var_8_0 < var_8_1 and horcrux_manager:getHorcruxStarLevel(self.entityid) < 5 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_changeMode"):setVisible(false)
	elseif horcrux_manager:getHorcruxHLV(self.entityid) == horcrux_manager:get_max_level_with_star(var_8_0) and var_8_0 < var_8_1 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_changeMode"):setVisible(true)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_changeMode"):setTitleText(L_BUTTON_TEXT.Up_Star)
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_changeMode"):setVisible(true)
	end
end

function HorcruxInfoLayerNew:updateHClass()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_gradeNum"):loadTexture((horcrux_manager:getHorcruxMaxHclass(playermodel.items[self.entityid].itemid) <= horcrux_manager:getHorcruxHClass(self.entityid) or nil) and "public/rolebg/+5.png", var_0_0)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_upgrade"):getChildByName("Image_redPoint"):setVisible(horcrux_manager:isTipsHorcruxUpgrade(self.entityid))
end

function HorcruxInfoLayerNew:updateMainAttrPanel()
	self.mainAttrPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_main_attr")

	local var_11_0 = playermodel.items[self.entityid].itemid
	local var_11_1 = horcrux_manager:getHorcruxAssistConfig(self.entityid, 0)
	local var_11_2 = horcrux_manager:getHorcruxAssistConfig(self.entityid)

	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_infoDamage"):setString(global_trans_number(math.floor(var_11_1.damage)))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_infoHp"):setString(global_trans_number(math.floor(var_11_1.hp)))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_upstarDamageAdd"):setString("+" .. global_trans_number(math.floor(var_11_2.damage - var_11_1.damage)))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_upstarHpAdd"):setString("+" .. global_trans_number(math.floor(var_11_2.hp - var_11_1.hp)))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_upstarDamageAdd"):setVisible(math.floor(var_11_2.damage - var_11_1.damage) ~= 0)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_upstarHpAdd"):setVisible(math.floor(var_11_2.hp - var_11_1.hp) ~= 0)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_upstarHpAdd"):setPositionX(280)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_upstarDamageAdd"):setPositionX(280)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_infoDamage"):setPositionX(ccui.Helper:seekWidgetByName(self.rootLayer, "Label_upstarDamageAdd"):getPositionX() - ccui.Helper:seekWidgetByName(self.rootLayer, "Label_upstarDamageAdd"):getContentSize().width)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_infoHp"):setPositionX(ccui.Helper:seekWidgetByName(self.rootLayer, "Label_upstarHpAdd"):getPositionX() - ccui.Helper:seekWidgetByName(self.rootLayer, "Label_upstarHpAdd"):getContentSize().width)
	self:updateHClass()

	if var_0_16[var_11_0].upgrade_forbidden == 1 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_upgrade"):setVisible(false)
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_upgrade"):addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:showHorcruxUpgradePop()
	end)
	self:updateExpBar()
end

function HorcruxInfoLayerNew.updateFightCapacity(arg_13_0)
	return
end

function HorcruxInfoLayerNew:updateSelectedNum()
	local var_14_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_selectedNum")
	local var_14_1 = var_14_0:getChildByName("Label_maxSelectedNum")
	local var_14_2 = 0

	if self.listDataType == 1 then
		for iter_14_0, iter_14_1 in pairs(self.selectedHorcruxList) do
			var_14_2 = var_14_2 + 1
		end
	else
		for iter_14_2, iter_14_3 in pairs(self.selectedExpList) do
			var_14_2 = var_14_2 + 1
		end
	end

	var_14_1:setString(var_14_2 .. "/" .. var_0_22)
	var_14_0:getChildByName("Label_69"):setPositionX(var_14_1:getPositionX() - var_14_1:getContentSize().width)
	var_14_0:getChildByName("Label_69"):setString(L_HAVE_CHOOSE)
end

function HorcruxInfoLayerNew:updateExpBar()
	local var_15_0 = self:getSelectedHorcruxListExp() + self.curExp
	local var_15_1
	local var_15_2 = self.curLevel
	local var_15_3 = math.min(horcrux_manager:getHorcruxBreakLv(self.entityid) * 10, horcrux_manager:get_max_level(self.entityid))

	for iter_15_0 = self.curLevel, var_15_3 - 1 do
		var_15_1 = self.curLevel == var_15_3 - 1 and horcrux_strength_data[iter_15_0].exp or horcrux_strength_data[iter_15_0].exp

		if var_15_0 - var_15_1 > 0 then
			var_15_2 = var_15_2 + 1
			var_15_0 = var_15_0 - var_15_1
		else
			var_15_1 = var_15_1 + var_15_0

			break
		end
	end

	local var_15_6 = ccui.Helper:seekWidgetByName(self.mainAttrPanel, "Panel_level")
	local var_15_7 = ccui.Helper:seekWidgetByName(self.mainAttrPanel, "ProgressBar_cur")

	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_expDes"):setVisible(true)

	if var_15_3 > horcrux_manager:get_max_level(self.entityid) then
		var_15_3 = horcrux_manager:get_max_level(self.entityid)
	end

	if var_15_3 <= var_15_2 then
		var_15_2 = var_15_3

		var_15_7:setPercent(100)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_expDes"):setVisible(false)
	else
		local var_15_8 = math.ceil(var_15_0 / horcrux_strength_data[var_15_2].exp * 100)

		if var_15_8 > 100 then
			var_15_8 = 100
		end

		var_15_7:setPercent(var_15_8)
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_expDes"):setString(math.floor(var_15_0) .. "/" .. horcrux_strength_data[var_15_2].exp)
	var_15_6:getChildByName("Panel_levelNum"):getChildByName("Label_level"):setString(var_15_2)

	local var_15_11 = horcrux_manager:getHorcruxAssistConfig(self.entityid, 0)
	local var_15_12 = horcrux_manager:getHorcruxAssistConfig(self.entityid)

	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_infoDamage"):setString(global_trans_number(math.floor(var_15_11.damage)))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_infoHp"):setString(global_trans_number(math.floor(var_15_11.hp)))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_upstarDamageAdd"):setString("+" .. global_trans_number(math.floor(var_15_12.damage - var_15_11.damage)))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_upstarHpAdd"):setString("+" .. global_trans_number(math.floor(var_15_12.hp - var_15_11.hp)))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_upstarDamageAdd"):setVisible(math.floor(var_15_12.damage - var_15_11.damage) ~= 0)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_upstarHpAdd"):setVisible(math.floor(var_15_12.hp - var_15_11.hp) ~= 0)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_infoDamage"):setPositionX(ccui.Helper:seekWidgetByName(self.rootLayer, "Label_upstarDamageAdd"):getPositionX() - ccui.Helper:seekWidgetByName(self.rootLayer, "Label_upstarDamageAdd"):getContentSize().width)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_infoHp"):setPositionX(ccui.Helper:seekWidgetByName(self.rootLayer, "Label_upstarHpAdd"):getPositionX() - ccui.Helper:seekWidgetByName(self.rootLayer, "Label_upstarHpAdd"):getContentSize().width)

	local var_15_14 = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_infoAddDamage")
	local var_15_15 = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_infoAddHp")

	if horcrux_manager:getHorcruxHClass(self.entityid) > 0 then
		var_15_14:setString(horcrux_manager:getHorcruxDamageFac(self.entityid) / 100 + horcrux_manager:getHorcruxDamageFacAdditionByEntityid(self.entityid) / 100)
		var_15_15:setString((math.floor(horcrux_manager:getHorcruxHpFac(self.entityid) / 100 + horcrux_manager:getHorcruxHpFacAdditionByEntityid(self.entityid) / 100)))
	else
		var_15_14:setString(horcrux_manager:getHorcruxDamageFac(self.entityid) / 100)
		var_15_15:setString((math.floor(horcrux_manager:getHorcruxHpFac(self.entityid) / 100)))
	end

	local var_15_16 = {
		s = "public/rolebg/grade_s.png",
		a = "public/rolebg/grade_a.png",
		s_plus = "public/rolebg/grade_s_plus.png",
		b_minus = "public/rolebg/grade_b_minus.png",
		b_plus = "public/rolebg/grade_b_plus.png",
		a_minus = "public/rolebg/grade_a_minus.png",
		b = "public/rolebg/grade_b.png",
		c = "public/rolebg/grade_c.png",
		a_puls = "public/rolebg/grade_a_puls.png"
	}
	local var_15_17 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_damageGrade")

	var_15_17:loadTexture(var_15_16[horcrux_manager:getHorcruxDamageFacSectionGrade(self.entityid)], var_0_0)
	var_15_17:setPositionX(var_15_14:getPositionX() + var_15_14:getContentSize().width / 2 + var_15_17:getContentSize().width / 2)

	local var_15_18 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_hpGrade")

	var_15_18:loadTexture(var_15_16[horcrux_manager:getHorcruxHpFacSectionGrade(self.entityid)], var_0_0)
	var_15_18:setPositionX(var_15_15:getPositionX() + var_15_15:getContentSize().width / 2 + var_15_18:getContentSize().width / 2)
end

function HorcruxInfoLayerNew:getSelectedHorcruxListExp(arg_16_1)
	local var_16_0 = 0

	if self.listDataType == 1 then
		if arg_16_1 then
			for iter_16_0, iter_16_1 in pairs(arg_16_1) do
				var_16_0 = var_16_0 + horcrux_manager:getCompoundExp(iter_16_1.entityid) * iter_16_1.num or 1
			end
		else
			for iter_16_2, iter_16_3 in pairs(self.selectedHorcruxList) do
				var_16_0 = var_16_0 + horcrux_manager:getCompoundExp(iter_16_3.entityid) * iter_16_3.num or 1
			end
		end
	elseif arg_16_1 then
		for iter_16_4, iter_16_5 in pairs(arg_16_1) do
			var_16_0 = var_16_0 + var_0_16[playermodel.items[iter_16_5.entityid].itemid].gain_exp * iter_16_5.num
		end
	else
		for iter_16_6, iter_16_7 in pairs(self.selectedExpList) do
			var_16_0 = var_16_0 + var_0_16[playermodel.items[iter_16_7.entityid].itemid].gain_exp * iter_16_7.num
		end
	end

	return var_16_0
end

function HorcruxInfoLayerNew.getAttrIconPath(arg_17_0, arg_17_1)
	return global_get_model_attr(item_data[arg_17_1].model)
end

function HorcruxInfoLayerNew:initUI()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "HorcruxInfoLayer.json" or "HorcruxInfoLayer.ExportJson")

	self:addChild(self.rootLayer)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_attr"):loadTexture(CAREER_ICON[item_data[playermodel.items[self.entityid].itemid].career .. "_" .. self:getAttrIconPath(playermodel.items[self.entityid].itemid)], var_0_0)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_attr"):setTouchEnabled(true)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_attr"):addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_horcruxImage"):loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[item_data[playermodel.items[self.entityid].itemid].model].cute_Q .. ".png")
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_horcruxImage"):setScale(var_0_20)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_name"):setString(item_data[playermodel.items[self.entityid].itemid].name)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_rarity"):loadTexture(RARITY_LONG_ICON[item_data[playermodel.items[self.entityid].itemid].rarity], var_0_0)

	local var_18_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_lock")

	if self.isDevour then
		var_18_2:setVisible(false)
	else
		var_18_2:setVisible(true)
	end

	if horcrux_manager:isHorcruxLocked(self.entityid) then
		var_18_2:loadTexture(var_0_27[1], var_0_0)
	else
		var_18_2:loadTexture(var_0_27[2], var_0_0)
	end

	var_18_2:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_20_0:isBright() then
			return
		end

		arg_20_0:setBright(false)
		horcrux_manager:switchLockStatus(self.entityid, function(arg_21_0)
			arg_20_0:setBright(true)

			if horcrux_manager:isHorcruxLocked(self.entityid) then
				var_18_2:loadTexture(var_0_27[1], var_0_0)

				if arg_21_0 == 2 then
					global_ShowBlockWords(L_HORCRUX_TOUCH_MSG.Hasowner)
				else
					global_ShowBlockWords(L_HORCRUX_LOCK.Lock)
				end

				self:updateShowingCells()
			else
				var_18_2:loadTexture(var_0_27[2], var_0_0)

				if arg_21_0 == 2 then
					global_ShowBlockWords(L_HORCRUX_TOUCH_MSG.Hasowner)
				else
					global_ShowBlockWords(L_HORCRUX_LOCK.Unlock)
				end

				self:updateShowingCells()
			end
		end)
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_upgrade"):setVisible(self:isShowUpgradeBtn())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_upgrade"):setPositionX(70)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_changeMode"):setVisible(self:isShowUpgradeBtn())
	self:createHorcruxTableView()
	self:createExpListTableView()
	self:updateMainAttrPanel()
	self:updateFightCapacity()
	self:updateHorcruxStars()
	self:updateSelectedNum()
	self:initShowAttrBtn()
	self:initFilterBtn()
	self:updateModelUI()
	self:initSkillPanel()
	self:initTypeSkillPanel()
	self:initUpstarBtn()
end

function HorcruxInfoLayerNew:initUpstarBtn()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_star_up"):addTouchEventListener(self:getStarupHanel())

	if horcrux_manager:getHorcruxStarLevel(self.entityid) < 5 or var_0_16[self.itemid].rarity < 3 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_star_up"):setVisible(false)
	end
end

function HorcruxInfoLayerNew:updateUpstarBtn()
	if horcrux_manager:getHorcruxStarLevel(self.entityid) == var_0_16[self.itemid].max_star then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_star_up"):loadTexture("HorcruxInfo/star_max.png", var_0_0)
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_star_up"):loadTexture("HorcruxInfo/star_up.png", var_0_0)
	end
end

function HorcruxInfoLayerNew:initTypeSkillPanel()
	local var_24_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_name"):getPositionX()
	local var_24_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_name"):getContentSize().width
	local var_24_2 = "public/rolebg/" .. horcrux_manager:getRaceByEntityid(self.entityid) .. ".png"
	local var_24_3 = ccui.ImageView:create("public/rolebg/race_bg.png", var_0_0)

	var_24_3:setPositionX(ccui.Helper:seekWidgetByName(self.rootLayer, "Label_name"):getPositionX() + ccui.Helper:seekWidgetByName(self.rootLayer, "Label_name"):getContentSize().width + var_24_3:getContentSize().width / 2 + 8)
	var_24_3:setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "Label_name"):getPositionY())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_horcruxOrder2"):addChild(var_24_3)

	local var_24_4 = horcrux_manager:getTypeSkillByEntityid(self.entityid)
	local var_24_5 = ccui.ImageView:create(var_24_2, var_0_0)

	var_24_5:setScale(0.6)
	var_24_5:setPositionX(var_24_3:getPositionX())
	var_24_5:setPositionY(var_24_3:getPositionY())
	var_24_5:setTouchEnabled(true)
	var_24_5:setName("raceIcon")
	var_24_5:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_25_0 = var_24_4
		local var_25_1 = ccui.Layout:create()

		var_25_1:setTouchEnabled(true)
		var_25_1:setContentSize(cc.size(640, GameDisplay.height))
		var_25_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_25_1:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
		var_25_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_25_1:setBackGroundColor(cc.c3b(0, 0, 0))
		var_25_1:setBackGroundColorOpacity(120)
		var_25_1:addTouchEventListener(function(arg_26_0, arg_26_1)
			if arg_26_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_25_1:runAction(cc.RemoveSelf:create())
		end)

		local var_25_2 = ccui.ImageView:create("EquipLayer/skill_des_bg.png", var_0_0)

		var_25_2:setPosition(cc.p(320, 672))
		var_25_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_25_1:addChild(var_25_2)

		local var_25_3 = ccui.Layout:create()

		var_25_3:setContentSize(cc.size(500, 124))
		var_25_3:setAnchorPoint(cc.p(0, 0))
		var_25_3:setPosition(cc.p(70, 600))
		var_25_3:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_25_3:setBackGroundColor(cc.c3b(0, 0, 0))
		var_25_3:setBackGroundColorOpacity(0)
		var_25_1:addChild(var_25_3, 2)

		local var_25_4 = ccui.ImageView:create("EquipLayer/normal_skill_frame.png", var_0_0)

		var_25_4:setPosition(cc.p(58, 63))
		var_25_4:setAnchorPoint(cc.p(0.5, 0.5))
		var_25_3:addChild(var_25_4)

		local var_25_5 = ccui.ImageView:create(var_24_2, var_0_0)

		var_25_5:setScale(0.88)
		var_25_5:setPosition(cc.p(58, 63))
		var_25_3:addChild(var_25_5)

		local var_25_6 = cc.Label:createWithTTF(total_skill_data[var_25_0].name, FONT_DES, 24)

		var_25_6:setAnchorPoint(cc.p(0, 0.5))
		var_25_6:setPosition(cc.p(121, 96))
		var_25_3:addChild(var_25_6)

		if total_skill_data[var_25_0].cd then
			local var_25_7 = cc.Label:createWithTTF(L_SIKILL_CD .. total_skill_data[var_25_0].cd .. "s", FONT_DES, 20)

			var_25_7:setAnchorPoint(cc.p(1, 0.5))
			var_25_7:setPosition(cc.p(473, 96))
			var_25_3:addChild(var_25_7)
		end

		local var_25_8 = transSkillDesToRichText(total_skill_data[var_25_0].description)
		local var_25_9 = RichTextPro:create()

		var_25_9:setMaxWidth(380)
		var_25_9:setSize(20)
		var_25_9:setColor(cc.c3b(220, 251, 241))
		var_25_9:setLineSpace(0)
		var_25_9:setText(var_25_8)
		var_25_9:setName("richText")
		var_25_9:setPosition(cc.p(120, 86))
		var_25_3:addChild(var_25_9)
		self:addChild(var_25_1)
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_horcruxOrder2"):addChild(var_24_5)
end

function HorcruxInfoLayerNew:initSkillPanel()
	local var_27_0 = horcrux_manager:getHorcruxSkills(self.entityid)
	local var_27_1 = horcrux_manager:getHorcruxStarLevel(self.entityid) or 1
	local var_27_2 = var_27_0[1]

	if var_27_0[1] and playermodel.items[self.entityid].horcrux_attr.enable_skill_idxs then
		var_27_2 = false

		for iter_27_0, iter_27_1 in pairs(playermodel.items[self.entityid].horcrux_attr.enable_skill_idxs) do
			if iter_27_1 == 1 then
				var_27_2 = true

				break
			end
		end
	end

	if var_27_2 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_skill1"):setVisible(true)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_des1"):setVisible(true)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_skillName1"):setVisible(true)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_skill1Bg"):loadTexture("HorcruxInfo/skill_bg.png", var_0_0)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_skill1"):loadTexture("skill_new/skill/" .. total_skill_data[var_27_0[1]].icon .. ".png", var_0_0)

		local var_27_3 = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_skillName1")

		var_27_3:setString(total_skill_data[var_27_0[1]].name .. (({
			nil,
			nil,
			nil,
			nil,
			nil,
			"+",
			"++",
			"max"
		})[var_27_1] or ""))

		local var_27_4 = RichTextPro:create()

		var_27_4:setAnchorPoint(cc.p(0, 1))
		var_27_4:setPosition(cc.p(var_27_3:getPositionX() - 30, var_27_3:getPositionY() - var_27_3:getContentSize().height / 2 - 18))
		var_27_4:setMaxWidth(400)
		var_27_4:setSize(22)
		var_27_4:setLineSpace(0)
		var_27_4:setText((transSkillDesToRichText(total_skill_data[var_27_0[1]].description)))
		var_27_4:setName("Panel_skill1LabelBg")
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_skill1"):addChild(var_27_4, 2)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_des1"):setVisible(false)
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_skill1"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_des1"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_skillName1"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_skill1Bg"):loadTexture("HorcruxInfo/none_skill_bg.png", var_0_0)
	end

	if var_27_0[2] then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_skill2"):setVisible(true)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_des2"):setVisible(true)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_skillName2"):setVisible(true)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_skill2Bg"):loadTexture("HorcruxInfo/skill_bg.png", var_0_0)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_skill2"):loadTexture("skill_new/skill/" .. total_skill_data[var_27_0[2]].icon .. ".png", var_0_0)

		local var_27_5 = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_skillName2")

		var_27_5:setString(total_skill_data[var_27_0[2]].name)

		local var_27_6 = RichTextPro:create()

		var_27_6:setAnchorPoint(cc.p(0, 1))
		var_27_6:setPosition(cc.p(var_27_5:getPositionX() - 30, var_27_5:getPositionY() - var_27_5:getContentSize().height / 2 - 18))
		var_27_6:setMaxWidth(400)
		var_27_6:setSize(16)
		var_27_6:setLineSpace(0)
		var_27_6:setText((transSkillDesToRichText(total_skill_data[var_27_0[2]].description)))
		var_27_6:setName("Panel_skill1LabelBg")
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_skill2"):addChild(var_27_6, 2)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_des2"):setVisible(false)
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_skill2"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_des2"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_skillName2"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_skill2Bg"):loadTexture("HorcruxInfo/none_skill_bg.png", var_0_0)
	end
end

function HorcruxInfoLayerNew:updateSkillPanel()
	local var_28_0 = horcrux_manager:getHorcruxSkills(self.entityid)
	local var_28_1 = horcrux_manager:getHorcruxStarLevel(self.entityid) or 1
	local var_28_2 = var_28_0[1]

	if var_28_0[1] and playermodel.items[self.entityid].horcrux_attr.enable_skill_idxs then
		var_28_2 = false

		for iter_28_0, iter_28_1 in pairs(playermodel.items[self.entityid].horcrux_attr.enable_skill_idxs) do
			if iter_28_1 == 1 then
				var_28_2 = true

				break
			end
		end
	end

	if var_28_2 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_skill1"):setVisible(true)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_des1"):setVisible(true)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_skillName1"):setVisible(true)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_skill1Bg"):loadTexture("HorcruxInfo/skill_bg.png", var_0_0)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_skill1"):loadTexture("skill_new/skill/" .. total_skill_data[var_28_0[1]].icon .. ".png", var_0_0)

		local var_28_3 = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_skillName1")

		var_28_3:setString(total_skill_data[var_28_0[1]].name .. (({
			nil,
			nil,
			nil,
			nil,
			nil,
			"+",
			"++",
			"max"
		})[var_28_1] or ""))

		if ccui.Helper:seekWidgetByName(self.rootLayer, "Image_skill1"):getChildByName("Panel_skill1LabelBg") then
			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_skill1"):removeChildByName("Panel_skill1LabelBg")
		end

		local var_28_4 = transSkillDesToRichText(total_skill_data[var_28_0[1]].description)
		local var_28_5 = RichTextPro:create()

		var_28_5:setAnchorPoint(cc.p(0, 1))
		var_28_5:setPosition(cc.p(var_28_3:getPositionX() - 30, var_28_3:getPositionY() - var_28_3:getContentSize().height / 2 - 18))
		var_28_5:setMaxWidth(400)
		var_28_5:setSize(22)
		var_28_5:setLineSpace(0)
		var_28_5:setText(var_28_4)
		var_28_5:setName("Panel_skill1LabelBg")
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_skill1"):addChild(var_28_5, 2)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_des1"):setVisible(false)
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_skill1"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_des1"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_skillName1"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_skill1Bg"):loadTexture("HorcruxInfo/none_skill_bg.png", var_0_0)
	end
end

function HorcruxInfoLayerNew:updateModelUI()
	if self.listDataType == 1 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_horcruxBag"):loadTextures("HorcruxInfo/kaohe1.png", "HorcruxInfo/kaohe1.png", "HorcruxInfo/kaohe1.png", var_0_0)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_itemBag"):loadTextures("HorcruxInfo/kaohe2.png", "HorcruxInfo/kaohe2.png", "HorcruxInfo/kaohe2.png", var_0_0)
		self.listPanel:setVisible(true)
		self.expListPanel:setVisible(false)
		self.filterButton:setVisible(true)
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_horcruxBag"):loadTextures("HorcruxInfo/kaohe2.png", "HorcruxInfo/kaohe2.png", "HorcruxInfo/kaohe2.png", var_0_0)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_itemBag"):loadTextures("HorcruxInfo/kaohe1.png", "HorcruxInfo/kaohe1.png", "HorcruxInfo/kaohe1.png", var_0_0)
		self.listPanel:setVisible(false)
		self.expListPanel:setVisible(true)
		self.filterButton:setVisible(false)
	end
end

function HorcruxInfoLayerNew:initHorcruxExpItems()
	if self.horcruxExpItemList then
		return
	end

	self.horcruxExpItemList = {}

	for iter_30_0, iter_30_1 in pairs(playermodel.items) do
		if iter_30_1.itemtype == KITEM_HORCRUX_ITEM then
			self.horcruxExpItemList[#self.horcruxExpItemList + 1] = {}
			self.horcruxExpItemList[#self.horcruxExpItemList].itemid = iter_30_1.itemid
			self.horcruxExpItemList[#self.horcruxExpItemList].number = iter_30_1.number
			self.horcruxExpItemList[#self.horcruxExpItemList].entityid = iter_30_1.entityid
		end
	end

	table.sort(self.horcruxExpItemList, function(arg_31_0, arg_31_1)
		if arg_31_0.itemid > arg_31_1.itemid then
			return true
		else
			return false
		end
	end)
end

function HorcruxInfoLayerNew:updateHorcruxStars()
	local var_32_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_stars")
	local var_32_1 = playermodel.items[self.entityid].horcrux_attr.star
	local var_32_2 = playermodel.items[self.entityid].horcrux_attr.star % 5
	local var_32_3 = "Image_"

	for iter_32_0 = 1, 5 do
		local var_32_6 = var_32_0:getChildByName(var_32_3 .. iter_32_0)

		if var_32_6 then
			var_32_6:setVisible(var_32_1 >= 5 or iter_32_0 <= var_32_2)
			var_32_6:loadTexture(var_32_4, var_0_0)
		end
	end
end

local var_0_28 = 540
local var_0_29 = 398
local var_0_30 = 0
local var_0_31 = 0
local var_0_32 = 145
local var_0_33 = 400
local var_0_34 = 150
local var_0_35 = 360
local var_0_36 = {
	cc.p(2, 210),
	(cc.p(2, 5))
}
local var_0_37 = {
	cc.p(65, 250),
	(cc.p(65, 70))
}
local var_0_38 = 2
local var_0_39 = 0.5
local var_0_40 = 0.7

function HorcruxInfoLayerNew:createHorcruxTableView()
	self.listPanel = cc.TableView:create(cc.size(var_0_28, var_0_29))

	self.listPanel:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	self.listPanel:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.listPanel:setPosition(cc.p(var_0_30, var_0_31))
	self.listPanel:setDelegate()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_tableViewBg"):addChild(self.listPanel)
	self.listPanel:registerScriptHandler(function(arg_34_0, arg_34_1)
		return var_0_32, var_0_33
	end, cc.TABLECELL_SIZE_FOR_INDEX)

	local function var_33_0(arg_35_0, arg_35_1)
		if arg_35_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_35_0:getTouchBeganPosition().x - arg_35_0:getTouchEndPosition().x) > 50 then
			return
		end

		if not arg_35_0.entityid then
			return
		end

		local var_35_0 = arg_35_0.entityid

		if not self.selectedHorcruxList[arg_35_0.entityid] and self.curLevel >= horcrux_manager:getHorcruxBreakLv(self.entityid) * 10 then
			global_ShowBlockWords(L_HORCRUX_TOUCH_MSG.Level[1])
			audio_manager:playeffectMusicTest("sound/invalid")

			return
		end

		if not self.selectedHorcruxList[var_35_0] and self:getSelectedHorcruxListExp() > horcrux_manager:getHorcruxNextBreakLimitExp(self.entityid) then
			global_ShowBlockWords(L_HORCRUX_TOUCH_MSG.Level[2])
			audio_manager:playeffectMusicTest("sound/invalid")

			return
		end

		if self.curLevel >= horcrux_manager:get_max_level(self.entityid) then
			global_ShowBlockWords(L_HORCRUX_TOUCH_MSG.Level[3])
			audio_manager:playeffectMusicTest("sound/invalid")

			return
		end

		local function var_35_1()
			self:updateSelectedNum()

			if self.curIndex and self.curIndex ~= arg_35_0.index then
				self.listPanel:updateCellAtIndex(self.curIndex)
			end

			self.listPanel:updateCellAtIndex(arg_35_0.index)

			self.curIndex = arg_35_0.index

			if not next(self.selectedHorcruxList) then
				self.selectModel = 0
			end

			self:updateUpLevelPopExpBar(self.entityid)
		end

		if self.selectedHorcruxList[var_35_0] then
			self.selectedHorcruxList[var_35_0] = nil

			var_35_1()
		else
			local var_35_2 = 0

			for iter_35_0, iter_35_1 in pairs(self.selectedHorcruxList) do
				var_35_2 = var_35_2 + 1
			end

			if var_35_2 < var_0_22 then
				self.selectedHorcruxList[var_35_0] = {
					num = 1,
					entityid = arg_35_0.entityid
				}

				var_35_1()
			else
				global_ShowBlockWords(L_HORCRUX_TOUCH_MSG.Busy)
				audio_manager:playeffectMusicTest("sound/invalid")
			end
		end
	end

	local function var_33_1(arg_37_0, arg_37_1)
		if arg_37_1 ~= ccui.TouchEventType.ended then
			return
		end

		horcrux_manager:switchLockStatus(arg_37_0:getParent().entityid, function(arg_38_0)
			if arg_38_0 == 1 then
				global_ShowBlockWords(L_HORCRUX_TOUCH_MSG.Unlock)
				self:updateShowingCells()
			elseif arg_38_0 == 2 then
				global_ShowBlockWords(L_HORCRUX_TOUCH_MSG.Hasowner)
			else
				global_ShowBlockWords(L_HORCRUX_TOUCH_MSG.Error .. arg_38_0)
				audio_manager:playeffectMusicTest("sound/invalid")
			end
		end)
	end

	local function var_33_2(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
		local var_39_0 = HorcruxSprite:create({
			initType = "previewStyle"
		})

		var_39_0:setSwallowTouches(false)
		var_39_0:setName("sp_" .. arg_39_0)
		var_39_0:setPosition(var_0_36[arg_39_0])
		var_39_0:setScale(var_0_39)

		var_39_0.index = arg_39_3

		var_39_0:setScale(0.8)
		var_39_0:getChildByName("lvLabel"):setScale(0.8)
		var_39_0:addTouchEventListener(var_33_0)
		var_39_0:getChildByName("lock"):addTouchEventListener(var_33_1)

		if self.horcruxList[arg_39_2 + arg_39_0 * arg_39_1] then
			var_39_0:updateHorcruxInfos(self.horcruxList[arg_39_2 + arg_39_0 * arg_39_1], self.showAttr)

			var_39_0.entityid = self.horcruxList[arg_39_2 + arg_39_0 * arg_39_1]
			var_39_0.index = arg_39_3

			if self.selectCurHorcrux == self.horcruxList[arg_39_2 + arg_39_0 * arg_39_1] then
				if var_39_0:getChildByName("fightingtag") then
					if var_39_0:getChildByName("fightingtag"):isVisible() then
						var_39_0:getChildByName("fightingtag"):setVisible(false)
					end
				end

				if var_39_0:getChildByName("lock") then
					if var_39_0:getChildByName("lock"):isVisible() then
						var_39_0:getChildByName("lock"):setVisible(false)
					end
				end
			end
		else
			var_39_0:setVisible(false)
		end

		var_39_0:setReddotVisible(false)

		return var_39_0
	end

	local function var_33_3(arg_40_0, arg_40_1, arg_40_2, arg_40_3, arg_40_4)
		local var_40_0 = self.horcruxList[arg_40_3 + arg_40_1 * arg_40_2]

		if self.horcruxList[arg_40_3 + arg_40_1 * arg_40_2] then
			arg_40_0:updateHorcruxInfos(var_40_0, self.showAttr)
			arg_40_0:updateSelectHook(self.selectedHorcruxList[var_40_0] ~= nil)

			arg_40_0.entityid = var_40_0
			arg_40_0.index = arg_40_4

			arg_40_0:setVisible(true)

			if self.selectCurHorcrux == var_40_0 then
				if arg_40_0:getChildByName("fightingtag") then
					if arg_40_0:getChildByName("fightingtag"):isVisible() then
						arg_40_0:getChildByName("fightingtag"):setVisible(false)
					end
				end

				if arg_40_0:getChildByName("lock") then
					if arg_40_0:getChildByName("lock"):isVisible() then
						arg_40_0:getChildByName("lock"):setVisible(false)
					end
				end
			end
		else
			arg_40_0.entityid = nil
			arg_40_0.index = nil
			arg_40_0.horcruxindex = nil

			arg_40_0:setVisible(false)
		end

		arg_40_0:setReddotVisible(false)
	end

	self.listPanel:registerScriptHandler(function(arg_41_0, arg_41_1)
		local var_41_0 = arg_41_0:dequeueCell()
		local var_41_1
		local var_41_2 = 1

		if self.sortOrder == 1 then
			var_41_1 = var_0_38 * arg_41_1
		else
			var_41_1 = #self.horcruxList - var_0_38 * arg_41_1 + 1
			var_41_2 = -1
		end

		if not var_41_0 then
			var_41_0 = cc.TableViewCell:create()

			for iter_41_0 = 1, var_0_38 do
				var_41_0:addChild((var_33_2(iter_41_0, var_41_2, var_41_1, arg_41_1)))
			end
		end

		for iter_41_1 = 1, var_0_38 do
			var_33_3(var_41_0:getChildByName("sp_" .. iter_41_1), iter_41_1, var_41_2, var_41_1, arg_41_1)
		end

		return var_41_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.listPanel:registerScriptHandler(function(arg_42_0, arg_42_1)
		return math.ceil(#self.horcruxList / var_0_38)
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.listPanel:reloadData()
	self.listPanel:updateCellAtIndex(0)

	self.curIndex = 0
end

function HorcruxInfoLayerNew.startLongPressSelect(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = 1
	local var_43_1 = 1

	arg_43_1:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
		arg_43_2(var_43_1)

		var_43_1 = var_43_1 + math.floor(var_43_0 / 10)
		var_43_0 = var_43_0 + 1
	end), cc.DelayTime:create(0.1))))
end

function HorcruxInfoLayerNew:getExpListLimitNum(arg_45_1)
	return (math.ceil((self:getHorcruxNextBreakLimitExp(self.entityid) - self:getSelectedHorcruxListExp()) / var_0_16[playermodel.items[arg_45_1].itemid].gain_exp))
end

function HorcruxInfoLayerNew:createExpListTableView()
	self.expListPanel = cc.TableView:create(cc.size(var_0_28, var_0_29))

	self.expListPanel:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	self.expListPanel:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.expListPanel:setPosition(cc.p(var_0_30, var_0_31))
	self.expListPanel:setDelegate()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_tableViewBg"):addChild(self.expListPanel)
	self.expListPanel:registerScriptHandler(function(arg_47_0, arg_47_1)
		return var_0_34, var_0_35
	end, cc.TABLECELL_SIZE_FOR_INDEX)

	local var_46_0 = true

	local function var_46_1(arg_48_0, arg_48_1)
		local function var_48_0(arg_49_0)
			if not arg_48_0.entityid then
				return
			end

			local var_49_0 = arg_48_0.entityid

			local function var_49_1()
				self:updateSelectedNum()
				self:updateUpLevelPopExpBar(self.entityid)

				local var_50_0
				local var_50_1 = arg_48_0:getChildByName("selectedBg")

				if self.selectedExpList[var_49_0] then
					var_50_0 = self.selectedExpList[var_49_0].num or 0
				end

				if var_50_0 and var_50_0 > 0 then
					var_50_1:setVisible(true)
					var_50_1:getChildByName("label_num"):setString(var_50_0)
				else
					var_50_1:setVisible(false)
				end
			end

			if self.curLevel >= horcrux_manager:getHorcruxBreakLv(self.entityid) * 10 then
				global_ShowBlockWords(L_HORCRUX_TOUCH_MSG.Level[1])
				audio_manager:playeffectMusicTest("sound/invalid")

				return
			end

			if self:getSelectedHorcruxListExp() >= horcrux_manager:getHorcruxNextBreakLimitExp(self.entityid) then
				global_ShowBlockWords(L_HORCRUX_TOUCH_MSG.Level[2])
				audio_manager:playeffectMusicTest("sound/invalid")

				return
			end

			if self.curLevel >= horcrux_manager:get_max_level(self.entityid) then
				global_ShowBlockWords(L_HORCRUX_TOUCH_MSG.Level[3])
				audio_manager:playeffectMusicTest("sound/invalid")

				return
			end

			local var_49_2 = 0

			for iter_49_0, iter_49_1 in pairs(self.selectedExpList) do
				var_49_2 = var_49_2 + 1
			end

			if var_49_2 < var_0_22 then
				local var_49_3 = self:getExpListLimitNum(var_49_0)

				if var_49_3 < arg_49_0 then
					arg_49_0 = var_49_3
				end

				if self.selectedExpList[var_49_0] then
					if self.horcruxExpItemList[arg_48_0.dataIndex].number > self.selectedExpList[var_49_0].num then
						self.selectedExpList[var_49_0].num = self.selectedExpList[var_49_0].num + arg_49_0

						if self.horcruxExpItemList[arg_48_0.dataIndex].number < self.selectedExpList[var_49_0].num then
							self.selectedExpList[var_49_0].num = self.horcruxExpItemList[arg_48_0.dataIndex].number
						end
					else
						global_ShowBlockWords(L_HORCRUX_TOUCH_MSG.Material_Out)
						audio_manager:playeffectMusicTest("sound/invalid")
					end
				else
					self.selectedExpList[var_49_0] = {
						num = 1,
						entityid = arg_48_0.entityid
					}
				end

				var_49_1()
			else
				global_ShowBlockWords(L_HORCRUX_TOUCH_MSG.Busy)
				audio_manager:playeffectMusicTest("sound/invalid")
			end
		end

		if arg_48_1 == ccui.TouchEventType.began or arg_48_1 == ccui.TouchEventType.moved then
			local var_48_1 = arg_48_0:getTouchBeganPosition()
			local var_48_2 = arg_48_0:getTouchMovePosition()

			var_46_0 = true
			self.movePos = var_48_2
			arg_48_0.pos = arg_48_0.pos or global_deepCopy(var_48_2)

			if arg_48_1 == ccui.TouchEventType.began then
				self:startPress(function()
					if arg_48_0.pos and arg_48_0.pos.x == self.movePos.x and arg_48_0.pos.y == self.movePos.y or math.abs(var_48_1.y - self.movePos.y) < 10 and math.abs(var_48_1.x - self.movePos.x) < 10 then
						return true
					end

					return false
				end, function()
					self:endPress()
					self:startLongPressSelect(arg_48_0, var_48_0)

					var_46_0 = false
				end)
			end
		elseif arg_48_1 == ccui.TouchEventType.canceled then
			self:endPress()

			arg_48_0.pos = nil

			arg_48_0:stopAllActions()
		elseif arg_48_1 == ccui.TouchEventType.ended then
			if math.abs(arg_48_0:getTouchBeganPosition().x - arg_48_0:getTouchEndPosition().x) > 50 then
				self:endPress()

				arg_48_0.pos = nil

				arg_48_0:stopAllActions()

				return
			end

			if not arg_48_0.entityid then
				return
			end

			self:endPress()

			arg_48_0.pos = nil

			arg_48_0:stopAllActions()

			if var_46_0 then
				var_48_0(1)
			end
		end

		if math.abs(arg_48_0:getTouchBeganPosition().x - arg_48_0:getTouchEndPosition().x) > 50 then
			return
		end
	end

	local function var_46_2(arg_53_0, arg_53_1, arg_53_2, arg_53_3)
		local var_53_0 = ccui.Button:create(ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, var_0_0)

		var_53_0:setCascadeOpacityEnabled(false)
		var_53_0:setName("sp_" .. arg_53_0)
		var_53_0:setPosition(var_0_37[arg_53_0])
		var_53_0:setScale(var_0_40)

		var_53_0.index = arg_53_3

		var_53_0:addTouchEventListener(var_46_1)

		var_53_0.dataIndex = arg_53_2 + arg_53_0 * arg_53_1

		var_53_0:setSwallowTouches(false)

		local var_53_1

		if self.horcruxExpItemList[arg_53_2 + arg_53_0 * arg_53_1] then
			var_53_1 = self.horcruxExpItemList[arg_53_2 + arg_53_0 * arg_53_1].entityid

			local var_53_2 = ItemSprite:createBigWithEntityId(self.horcruxExpItemList[arg_53_2 + arg_53_0 * arg_53_1].entityid, self.horcruxExpItemList[arg_53_2 + arg_53_0 * arg_53_1].number)

			var_53_2:setName("item")
			var_53_2:setPosition(cc.p(var_53_0:getContentSize().width / 2, var_53_0:getContentSize().height / 2))
			var_53_0:addChild(var_53_2)
		elseif self.horcruxExpItemList[1] then
			var_53_1 = self.horcruxExpItemList[1].entityid

			local var_53_3 = ItemSprite:createBigWithEntityId(self.horcruxExpItemList[1].entityid, 1)

			var_53_3:setName("item")
			var_53_3:setPosition(cc.p(var_53_0:getContentSize().width / 2, var_53_0:getContentSize().height / 2))
			var_53_0:addChild(var_53_3)
		end

		local var_53_4

		if config._DEBUG then
			var_53_4 = cc.Sprite:create("public/box/new_item_bg_on.png") or cc.Sprite:createWithSpriteFrameName("public/box/new_item_bg_on.png")
		end

		var_53_4:setAnchorPoint(cc.p(0.5, 0.5))
		var_53_4:setPosition(cc.p(var_53_0:getContentSize().width / 2, var_53_0:getContentSize().height / 2))
		var_53_4:setName("selectedBg")
		var_53_4:setVisible(false)
		var_53_0:addChild(var_53_4, 1)

		local var_53_5 = cc.Label:createWithTTF("", "fonts/newkj.ttf", 20)

		var_53_5:setPosition(168, 218)
		var_53_5:setColor(cc.c3b(73, 58, 68))
		var_53_5:setAnchorPoint(cc.p(1, 0.5))
		var_53_5:setName("label_num")
		var_53_4:addChild(var_53_5)

		local var_53_6 = ccui.Button:create("public/box/new_item_bg_cancle.png", "public/box/new_item_bg_cancle.png", "public/box/new_item_bg_cancle.png", var_0_0)

		var_53_6:setName("canelBnt")

		var_53_6.entityid = var_53_1

		var_53_6:setPosition(10, var_53_0:getContentSize().height - 10)
		var_53_6:addTouchEventListener(function(arg_54_0, arg_54_1)
			if arg_54_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.selectedExpList[arg_54_0.entityid] then
				self.selectedExpList[arg_54_0.entityid].num = self.selectedExpList[arg_54_0.entityid].num - 1

				if self.selectedExpList[arg_54_0.entityid].num == 0 then
					self.selectedExpList[arg_54_0.entityid] = nil
				end
			end

			if not next(self.selectedExpList) then
				self.selectModel = 0
			end

			self:updateUpLevelPopExpBar(self.entityid)
			self:updateSelectedNum()
			self.expListPanel:updateCellAtIndex(var_53_0.index)
		end)
		var_53_4:addChild(var_53_6)

		if var_53_1 then
			if self.selectedExpList[var_53_1] then
				selectedNum = self.selectedExpList[var_53_1].num or 0
			end

			if selectedNum and selectedNum > 0 then
				var_53_4:setVisible(true)
				var_53_5:setString(selectedNum)
			else
				var_53_4:setVisible(false)
			end
		end

		if var_53_1 then
			var_53_0.entityid = var_53_1
			var_53_0.index = arg_53_3
		else
			var_53_0:setVisible(false)
		end

		return var_53_0
	end

	local function var_46_3(arg_55_0, arg_55_1, arg_55_2, arg_55_3, arg_55_4)
		arg_55_0.index = arg_55_4
		arg_55_0.dataIndex = arg_55_3 + arg_55_1 * arg_55_2

		local var_55_0

		if self.horcruxExpItemList[arg_55_3 + arg_55_1 * arg_55_2] then
			var_55_0 = self.horcruxExpItemList[arg_55_3 + arg_55_1 * arg_55_2].entityid
		end

		if var_55_0 then
			local var_55_1
			local var_55_2 = arg_55_0:getChildByName("selectedBg")

			if self.selectedExpList[var_55_0] then
				var_55_1 = self.selectedExpList[var_55_0].num or 0
			end

			if var_55_1 and var_55_1 > 0 then
				var_55_2:setVisible(true)
				var_55_2:getChildByName("label_num"):setString(var_55_1)
			else
				var_55_2:setVisible(false)
			end

			arg_55_0:getChildByName("item"):updateBigInfo(self.showAttr, var_55_0)

			arg_55_0.entityid = var_55_0
			arg_55_0.index = arg_55_4

			arg_55_0:setVisible(true)

			arg_55_0:getChildByName("selectedBg"):getChildByName("canelBnt").entityid = var_55_0
		else
			arg_55_0.entityid = nil
			arg_55_0.index = nil

			arg_55_0:setVisible(false)
		end
	end

	self.expListPanel:registerScriptHandler(function(arg_56_0, arg_56_1)
		local var_56_0 = arg_56_0:dequeueCell()
		local var_56_1
		local var_56_2 = 1

		if self.sortOrder == 1 then
			var_56_1 = var_0_38 * arg_56_1
		else
			var_56_1 = #self.horcruxExpItemList - var_0_38 * arg_56_1 + 1
			var_56_2 = -1
		end

		if not var_56_0 then
			var_56_0 = cc.TableViewCell:create()

			for iter_56_0 = 1, var_0_38 do
				local var_56_3 = var_46_2(iter_56_0, var_56_2, var_56_1, arg_56_1)

				var_46_3(var_56_3, iter_56_0, var_56_2, var_56_1, arg_56_1)
				var_56_0:addChild(var_56_3)
			end
		else
			for iter_56_1 = 1, var_0_38 do
				var_46_3(var_56_0:getChildByName("sp_" .. iter_56_1), iter_56_1, var_56_2, var_56_1, arg_56_1)
			end
		end

		return var_56_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.expListPanel:registerScriptHandler(function(arg_57_0, arg_57_1)
		return math.ceil(#self.horcruxExpItemList / var_0_38)
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.expListPanel:reloadData()
	self.expListPanel:updateCellAtIndex(0)
end

function HorcruxInfoLayerNew:deleteHorcruxList(arg_58_1)
	local var_58_0 = {}

	for iter_58_0, iter_58_1 in pairs(arg_58_1) do
		var_58_0[iter_58_1.entityid] = iter_58_0
	end

	while self.horcruxList[1] do
		local var_58_1

		if var_58_0[self.horcruxList[1]] then
			table.remove(self.horcruxList, 1)
		else
			var_58_1 = 1 + 1
		end
	end

	self.bagManager:update()
end

function HorcruxInfoLayerNew:horcruxUpLevel(arg_59_1)
	local var_59_0 = {}

	if self.listDataType == 1 then
		for iter_59_0, iter_59_1 in pairs(self.selectedHorcruxList) do
			var_59_0[#var_59_0 + 1] = global_deepCopy(iter_59_1)
		end
	else
		for iter_59_2, iter_59_3 in pairs(self.selectedExpList) do
			var_59_0[#var_59_0 + 1] = global_deepCopy(iter_59_3)
		end
	end

	if self.listDataType == 1 then
		if not next(self.selectedHorcruxList) then
			return
		end
	elseif not next(self.selectedExpList) then
		return
	end

	local function var_59_1(arg_60_0)
		for iter_60_0, iter_60_1 in pairs(arg_60_0) do
			local var_60_0 = horcrux_manager:getHorcruxItemid(iter_60_1.entityid)

			if horcrux_manager:isHorcruxLocked(iter_60_1.entityid) then
				return L_HORCRUX_LEVEL_UP_MSG.Locked
			end

			if horcrux_manager:getHorcruxHClass(iter_60_1.entityid) >= 1 then
				return string.format(L_HORCRUX_LEVEL_UP_MSG.Class, horcrux_manager:getHorcruxHClass(iter_60_1.entityid))
			end

			if horcrux_manager:getHorcruxHLV(iter_60_1.entityid) >= 1 then
				return string.format(L_HORCRUX_LEVEL_UP_MSG.Level, horcrux_manager:getHorcruxHLV(iter_60_1.entityid))
			end

			if item_data[var_60_0].rarity >= 4 and var_60_0 ~= 3050011 and var_60_0 ~= 3050012 and var_60_0 ~= 3050013 and var_60_0 ~= 3050014 then
				return L_HORCRUX_QUES
			end

			if horcrux_manager:getHorcruxStarLevel(iter_60_1.entityid) >= 5 then
				return string.format(L_HORCRUX_LEVEL_UP_MSG.Star, horcrux_manager:getHorcruxStarLevel(iter_60_1.entityid))
			end
		end
	end

	local function var_59_2()
		GuideListener.lockGuideTrigger(true)
		GuideListener.cleanCurGuides()
		self:saveCostMaterial()

		self.totalExp = self:getSelectedHorcruxListExp()

		horcrux_manager:horcruxLevelUp(self.entityid, var_59_0, function(arg_62_0)
			if arg_62_0 == 1 then
				self:updateData()

				self.selectModel = 0

				if self.listDataType == 1 then
					self.selectedHorcruxList = {}

					self:deleteHorcruxList(var_59_0)
					self.listPanel:reloadData()
					self:updateSelectedNum()
				else
					self.selectedExpList = {}

					self:deleteExpList(var_59_0)
					self.expListPanel:reloadData()
					self:updateSelectedNum()
				end

				self:updateFightCapacity()
				self:updateUpLevelPopExpBar(self.entityid)
				self:updateDisplayMode()
				self:updateSelectedNum()

				for iter_62_0, iter_62_1 in pairs(var_59_0) do
					if self.listDataType == 1 then
						self.addHorcruxEntityList[#self.addHorcruxEntityList + 1] = iter_62_1
					end
				end
			else
				global_ShowBlockWords(L_HORCRUX_LEVEL_UP_MSG.Error .. arg_62_0)
				audio_manager:playeffectMusicTest("sound/invalid")
				GuideListener.lockGuideTrigger(false)
				GuideListener.updateGuides(self)
			end

			if arg_59_1 then
				arg_59_1()
			end
		end)
	end

	if self.listDataType == 1 then
		if var_59_1(var_59_0) then
			require("view.Sprite.ConfirmDialogSprite")

			local var_59_4 = ConfirmDialogSprite:create(L_HORCRUX_LEVEL_UP_MSG.Dialog, var_59_1(var_59_0), {
				layerType = "HorcruxInfoLayerNew",
				surecallback = var_59_2
			})

			var_59_4:setPositionY(var_59_4:getPositionY() - GameDisplay.fix_y)
			self:addChild(var_59_4, 10)
		else
			var_59_2()
		end
	else
		var_59_2()
	end
end

function HorcruxInfoLayerNew:showHorcruxBreakLimit()
	local var_64_0 = horcrux_manager:getHorcruxBreakLv(self.entityid)
	local var_64_1 = horcrux_manager:getHorcruxDataWithPreset(self.entityid)
	local var_64_2
	local var_64_3
	local var_64_4
	local var_64_5
	local var_64_6
	local var_64_7
	local var_64_8
	local var_64_9 = true
	local var_64_10 = playermodel.items[self.entityid].itemid
	local var_64_12 = {}

	print(var_64_0, self:getMaxHorcruxBreak(self.entityid))

	if var_64_0 < self:getMaxHorcruxBreak(self.entityid) then
		var_64_2 = horcrux_manager:getHorcruxDataWithPreset(self.entityid, nil, var_64_0 + 1)
		var_64_3 = var_64_0 * 10
		var_64_4 = (var_64_0 + 1) * 10
		var_64_5 = math.floor(var_64_1.damage)
		var_64_6 = math.floor(var_64_2.damage)
		var_64_7 = math.floor(var_64_1.hp)
		var_64_8 = math.floor(var_64_2.hp)
	else
		var_64_3 = L_HORCRUX_BREAK_LIMIT.Level_Max
		var_64_4 = (var_64_0 + 1) * 10
		var_64_5 = math.floor(var_64_1.damage)
		var_64_6 = L_HORCRUX_BREAK_LIMIT.Level_Max
		var_64_7 = math.floor(var_64_1.hp)
		var_64_8 = L_HORCRUX_BREAK_LIMIT.Level_Max
	end

	local function var_64_13(arg_65_0)
		return
	end

	local var_64_14 = {}
	local var_64_15 = 1

	while var_0_16[var_64_10].break1_item1 and var_0_16[var_64_10]["break" .. var_64_0 .. "_item" .. var_64_15] do
		var_64_14[#var_64_14 + 1] = {}
		var_64_14[#var_64_14].itemid = var_0_16[var_64_10]["break" .. var_64_0 .. "_item" .. var_64_15]
		var_64_14[#var_64_14].needNum = var_0_16[var_64_10]["break" .. var_64_0 .. "_num" .. var_64_15]
		var_64_14[#var_64_14].ownNum = item_manager:getItemNumber(var_0_16[var_64_10]["break" .. var_64_0 .. "_item" .. var_64_15])

		if var_64_14[#var_64_14].needNum > var_64_14[#var_64_14].ownNum then
			var_64_9 = false
		else
			var_64_12[#var_64_12 + 1] = {}
			var_64_12[#var_64_12].entityid = var_0_16[var_64_10]["break" .. var_64_0 .. "_item" .. var_64_15]
			var_64_12[#var_64_12].num = var_0_16[var_64_10]["break" .. var_64_0 .. "_num" .. var_64_15]
		end

		var_64_15 = var_64_15 + 1
	end

	local var_64_16 = var_64_0
	local var_64_18 = {
		titlePath = "public/panelbg/title_girl_breakout.png",
		goto_back_system_id = 520,
		costDesPath = "public/panelbg/need_material.png",
		labels = {
			{
				{
					type = "text",
					str = L_HORCRUX_BREAK_LIMIT.Label_Str[1]
				},
				{
					type = "text",
					str = var_64_3
				},
				{
					path = "public/panelbg/strengen_arrow.png",
					type = "image"
				},
				{
					type = "text",
					str = var_64_4
				}
			},
			{
				{
					type = "text",
					str = L_HORCRUX_BREAK_LIMIT.Label_Str[2]
				},
				{
					type = "text",
					str = var_64_5
				},
				{
					path = "public/panelbg/strengen_arrow.png",
					type = "image"
				},
				{
					type = "text",
					str = var_64_6
				}
			},
			{
				{
					type = "text",
					str = L_HORCRUX_BREAK_LIMIT.Label_Str[3]
				},
				{
					type = "text",
					str = var_64_7
				},
				{
					path = "public/panelbg/strengen_arrow.png",
					type = "image"
				},
				{
					type = "text",
					str = var_64_8
				}
			}
		},
		cancelcallback = var_64_13,
		materials = var_64_14,
		cost = var_0_16[var_64_10]["cost_gold" .. var_64_0],
		bntstr = L_HORCRUX_BREAK_LIMIT.Btn_Str
	}

	var_64_18.limitDes = ""

	function var_64_18.grayBtnHandel()
		if var_64_0 >= self:getMaxHorcruxBreak(self.entityid) then
			return true, L_HORCRUX_BREAK_LIMIT.Level_Max
		end

		if not var_64_9 then
			return true, L_HORCRUX_BREAK_LIMIT.Warning[5]
		end

		if var_64_16 <= 4 and playermodel.class * 2 <= var_64_16 then
			return true, L_HORCRUX_BREAK_LIMIT.Warning[4]
		end
	end

	function var_64_18.surecallback(arg_67_0)
		horcrux_manager:horcruxBreakOut(self.entityid, var_64_12, var_64_18.cost, function(arg_68_0)
			if arg_68_0 == 1 then
				var_64_2 = horcrux_manager:getHorcruxDataWithPreset(self.entityid)

				self:updateMainAttrPanel()
				self:updateShowingCells()
				self:updateData()
				self:updateFightCapacity()
				self:updateDisplayMode()
				self:showBreakLimitAni({
					{
						L_HORCRUX_BREAK_LIMIT.Label_Str[3],
						L_HORCRUX_BREAK_LIMIT.Label_Str[2]
					},
					{
						var_64_7 .. "  →  " .. var_64_8,
						var_64_5 .. "  →  " .. var_64_6
					},
					{
						{
							g = 255,
							b = 145,
							r = 0
						},
						{
							g = 255,
							b = 145,
							r = 0
						}
					}
				}, {
					text = L_HORCRUX_BREAK_LIMIT.Label_Str[1],
					oldBreakNum = var_64_0 * 10,
					curBreakNum = (var_64_0 + 1) * 10
				})

				if arg_67_0 then
					arg_67_0()
				end
			elseif arg_68_0 == 2 then
				global_ShowBlockWords(L_HORCRUX_BREAK_LIMIT.Warning[2])
			elseif arg_68_0 == 3 then
				global_ShowBlockWords(L_HORCRUX_BREAK_LIMIT.Warning[3])
			elseif arg_68_0 == 4 then
				global_ShowBlockWords(L_HORCRUX_BREAK_LIMIT.Warning[4])
			elseif arg_68_0 == 5 then
				global_ShowBlockWords(L_HORCRUX_BREAK_LIMIT.Warning[5])
			elseif arg_68_0 == 6 then
				global_ShowBlockWords(L_HORCRUX_BREAK_LIMIT.Warning[6])
			end
		end)
	end

	local var_64_19 = self:createUpGradePop(var_64_18)
	local var_64_20 = ccui.Helper:seekWidgetByName(var_64_19, "button_sure")

	if horcrux_manager:horcruxCanBreakOut(self.entityid) then
		AlertManager:add_alert_by_config(var_64_20, true, {
			ALERT_SHOW_REDDOT,
			"",
			cc.p(var_64_20:getContentSize().width - 20, var_64_20:getContentSize().height)
		})
	end

	self:addChild(var_64_19, 998)
end

function HorcruxInfoLayerNew.updateBottomBtnList(arg_69_0)
	return
end

function HorcruxInfoLayerNew:initBottomBtnList()
	self.manager = require("controller/horcrux_devour/horcrux_devour_select_manager"):getInstance()

	local var_70_0 = {}

	if self:isShowDevourBtn() then
		var_70_0[1] = {
			texture = "public/button/public_button_orange.png",
			name = "unloadBtn",
			word = L_BUTTON_TEXT.Item_Panel_Btn.Switch,
			handler = function(arg_75_0, arg_75_1)
				if arg_75_1 ~= ccui.TouchEventType.ended then
					return
				end

				LayerManager:pushInLayer("HorcruxDevourSelectLayer", {
					isReplace = true,
					servantId = self.devourOwner,
					selectIndex = self.devourPos
				})

				local var_75_0 = require("controller.horcrux_devour.horcrux_devour_select_manager"):getInstance()
				local var_75_1 = 1
				local var_75_2 = {
					isHorcruxDevour = true,
					selectType = SELECT_HORCRUX_DEVOUR,
					outSide = {},
					selectGirlServantId = self.devourOwner,
					selectCallback = function()
						print("selectCallback")
					end,
					outSide = {}
				}
				local var_75_3 = {
					attrFilter = 1 == 1
				}

				var_75_3.index = 1
				var_75_3.selectIndex = self.devourPos

				local var_75_4 = var_75_0:getOutSideHorcruxs(self.devourOwner, var_75_3)

				var_75_2.outSide = var_75_4

				for iter_75_0 = 1, #var_75_2.outSide do
					var_75_4[#var_75_4 + 1] = var_75_2.outSide[iter_75_0]
				end

				var_75_2.mainHorcrux = var_75_1 == 1

				var_75_0:setSelectIndex(var_75_1)
				LayerManager:pushInLayer("HorcruxSelectLayer", var_75_2)
				LayerManager:removePopLayer(self.__queueindex)
			end
		}
		var_70_0[2] = {
			texture = "public/button/public_button_blue.png",
			name = "unloadBtn",
			word = L_BUTTON_TEXT.Horcrux_Btn.Unload,
			handler = function(arg_72_0, arg_72_1)
				if arg_72_1 ~= ccui.TouchEventType.ended then
					return
				end

				LayerManager:pushInLayer("PopDoLayer", {
					labels = {
						isHorizonalCenter = true,
						title = L_HORCRUX_DEVOUR[49],
						des = L_HORCRUX_DEVOUR[50],
						button = L_BATTLEPASS_BUY.button
					},
					own = item_manager:getItemNumber(3051001),
					surecallback = function()
						var_0_10:requestDisassembleHorcrux(self.devourOwner, self.devourPos, function()
							LayerManager:removePopLayer(self.__queueindex)
						end)
					end
				})
			end
		}
	elseif self:isShowDecomposeBtn() then
		var_70_0[1] = {
			texture = "public/button/public_button_blue.png",
			name = "sureBtn",
			word = L_BUTTON_TEXT.Horcrux_Btn.Decompose,
			handler = function(arg_71_0, arg_71_1)
				if arg_71_1 ~= ccui.TouchEventType.ended then
					return
				end

				self:perviewCompose()
			end
		}
	end

	self.bottomList = BottomBtnList:create(self:getReturnhandler(), var_70_0)

	self.bottomList:setName("bottomBtn")
	self.rootLayer:addChild(self.bottomList, 10)
end

function HorcruxInfoLayerNew:autoSelect()
	local var_77_0 = math.min(horcrux_manager:getHorcruxBreakLv(self.entityid) * 10, horcrux_manager:get_max_level(self.entityid))
	local var_77_1 = self:getHorcruxNextBreakLimitExp(self.entityid)
	local var_77_2 = {}
	local var_77_3 = {}
	local var_77_5 = 1
	local var_77_6 = {}

	if self.listDataType == 1 then
		for iter_77_0, iter_77_1 in pairs(self.horcruxList) do
			if item_data[playermodel.items[iter_77_1].itemid].rarity < 2 and not horcrux_manager:isHorcruxLocked(iter_77_1) and horcrux_manager:getHorcruxHLV(iter_77_1) == 0 and horcrux_manager:getHorcruxStarLevel(iter_77_1) <= 3 and horcrux_manager:getHorcruxHClass(iter_77_1) == 0 then
				var_77_3[#var_77_3 + 1] = {
					number = 1,
					entityid = iter_77_1,
					exp = horcrux_manager:getCompoundExp(iter_77_1)
				}
			end
		end
	else
		var_77_3 = global_deepCopy(self.horcruxExpItemList)

		for iter_77_2, iter_77_3 in pairs(var_77_3) do
			var_77_3[iter_77_2].exp = var_0_16[iter_77_3.itemid].gain_exp
		end
	end

	table.sort(var_77_3, function(arg_78_0, arg_78_1)
		if arg_78_0.exp > arg_78_1.exp then
			return true
		else
			return false
		end
	end)

	local function var_77_7(arg_79_0, arg_79_1)
		local var_79_0 = {}

		for iter_79_0, iter_79_1 in pairs(arg_79_0) do
			if arg_79_1 then
				if arg_79_1 <= iter_79_0 then
					var_79_0[iter_79_1.entityid] = {
						entityid = iter_79_1.entityid,
						num = iter_79_1.number
					}
				end
			else
				var_79_0[iter_79_1.entityid] = {
					entityid = iter_79_1.entityid,
					num = iter_79_1.number
				}
			end
		end

		return var_79_0
	end

	if var_77_1 >= self:getSelectedHorcruxListExp(var_77_7(var_77_3)) then
		var_77_2 = global_deepCopy(var_77_3)
	else
		while self:getSelectedHorcruxListExp(var_77_7(var_77_3)) > var_77_1 - self:getSelectedHorcruxListExp(var_77_7(var_77_2)) do
			if not var_77_3[var_77_5] then
				break
			end

			if var_77_3[var_77_5].number <= 0 then
				if var_77_5 > #var_77_3 then
					break
				else
					var_77_5 = var_77_5 + 1

					if not var_77_3[var_77_5] then
						break
					end
				end
			end

			if not var_77_6[var_77_3[var_77_5].entityid] then
				var_77_2[#var_77_2 + 1] = global_deepCopy(var_77_3[var_77_5])
				var_77_2[#var_77_2].number = 0
				var_77_6[var_77_3[var_77_5].entityid] = #var_77_2
			end

			var_77_3[var_77_5].number = var_77_3[var_77_5].number - 1
			var_77_2[var_77_6[var_77_3[var_77_5].entityid]].number = var_77_2[var_77_6[var_77_3[var_77_5].entityid]].number + 1

			if var_77_1 < self:getSelectedHorcruxListExp(var_77_7(var_77_2)) then
				var_77_3[var_77_5].number = var_77_3[var_77_5].number + 1
				var_77_2[var_77_6[var_77_3[var_77_5].entityid]].number = var_77_2[var_77_6[var_77_3[var_77_5].entityid]].number - 1

				if var_77_1 < self:getSelectedHorcruxListExp(var_77_7(var_77_3, var_77_5 + 1)) + self:getSelectedHorcruxListExp(var_77_7(var_77_2)) then
					var_77_5 = var_77_5 + 1

					if var_77_5 > #var_77_3 then
						break
					end
				else
					var_77_3[var_77_5].number = var_77_3[var_77_5].number - 1
					var_77_2[var_77_6[var_77_3[var_77_5].entityid]].number = var_77_2[var_77_6[var_77_3[var_77_5].entityid]].number + 1
				end
			elseif var_77_1 == self:getSelectedHorcruxListExp(var_77_7(var_77_2)) then
				break
			end
		end
	end

	local var_77_8 = self:getSelectedHorcruxListExp(var_77_7(var_77_2))

	return ((function(arg_80_0)
		local var_80_0 = {}

		for iter_80_0, iter_80_1 in pairs(arg_80_0) do
			if iter_80_1.number > 0 then
				var_80_0[iter_80_1.entityid] = {
					entityid = iter_80_1.entityid,
					num = iter_80_1.number
				}
			end
		end

		return var_80_0
	end)(var_77_2))
end

function HorcruxInfoLayerNew:autoSelectNew()
	if self.listDataType == 2 then
		return self:autoSelect()
	end

	local var_81_0 = self:getHorcruxNextBreakLimitExp(self.entityid)
	local var_81_1 = {}
	local var_81_2 = {}

	for iter_81_0, iter_81_1 in pairs(self.horcruxList) do
		if item_data[playermodel.items[iter_81_1].itemid].rarity < 10 and not horcrux_manager:isHorcruxLocked(iter_81_1) and not horcrux_manager:isInArrays(iter_81_1) and horcrux_manager:getHorcruxHLV(iter_81_1) == 0 and horcrux_manager:getHorcruxStarLevel(iter_81_1) <= 5 and horcrux_manager:getHorcruxHClass(iter_81_1) == 0 then
			var_81_2[#var_81_2 + 1] = {
				number = 1,
				entityid = iter_81_1,
				exp = horcrux_manager:getCompoundExp(iter_81_1)
			}
		end
	end

	for iter_81_2, iter_81_3 in pairs(var_81_2) do
		local var_81_3, var_81_4

		if 0 <= var_81_0 and 0 < 20 then
			var_81_3 = 0 + iter_81_3.exp
			var_81_4 = 0 + 1
			var_81_1[iter_81_3.entityid] = {
				entityid = iter_81_3.entityid,
				num = iter_81_3.number
			}
		else
			break
		end
	end

	return var_81_1
end

function HorcruxInfoLayerNew:deleteExpList(arg_82_1)
	local var_82_0 = {}

	for iter_82_0, iter_82_1 in pairs(arg_82_1) do
		var_82_0[iter_82_1.entityid] = {
			entityid = iter_82_1.entityid,
			num = iter_82_1.num
		}
	end

	while self.horcruxExpItemList[1] do
		v = self.horcruxExpItemList[1]

		if var_82_0[v.entityid] then
			self.horcruxExpItemList[1].number = self.horcruxExpItemList[1].number - var_82_0[v.entityid].num
		end

		local var_82_1

		if self.horcruxExpItemList[1].number <= 0 then
			table.remove(self.horcruxExpItemList, 1)
		else
			var_82_1 = 1 + 1
		end
	end
end

function HorcruxInfoLayerNew.getStarupHanel(arg_83_0)
	return function(arg_84_0, arg_84_1)
		if arg_84_0:getName() == "Image_star_up" then
			if arg_84_1 == ccui.TouchEventType.began then
				arg_84_0:setScale(1.1)
			elseif arg_84_1 == ccui.TouchEventType.canceled then
				arg_84_0:setScale(1)
			elseif arg_84_1 == ccui.TouchEventType.ended then
				arg_84_0:setScale(1)
			end
		end

		if arg_84_1 ~= ccui.TouchEventType.ended then
			return
		end

		if horcrux_manager:getHorcruxStarLevel(arg_83_0.entityid) == var_0_16[arg_83_0.itemid].max_star then
			global_ShowBlockWords(L_WEAPON_STAR.Star_Full)

			return
		end

		if horcrux_manager:getHorcruxStarLevel(arg_83_0.entityid) < 5 then
			global_ShowBlockWords(L_HORCRUX_CANT_STAR)

			return
		end

		LayerManager:pushInLayer("PopHorcruxUpstarLayer", {
			entityid = arg_83_0.entityid,
			callback = function(arg_85_0)
				if not var_0_18 then
					return
				end

				for iter_85_0, iter_85_1 in pairs(arg_85_0) do
					table.insert(arg_83_0.addHorcruxEntityList, iter_85_1)
				end

				arg_83_0:updateHorcruxStars()
				arg_83_0:updateSkillPanel()
				arg_83_0:updateMainAttrPanel()
				arg_83_0.bagManager:update()

				arg_83_0.horcruxList = arg_83_0.bagManager:getBagData(arg_83_0.filterTbl)

				arg_83_0:sortHorcruxList()
				arg_83_0.listPanel:reloadData()
				arg_83_0:updateUpstarBtn()
				arg_83_0:updateData()
				arg_83_0:updateDisplayMode()
			end
		})
	end
end

function HorcruxInfoLayerNew:showHorcruxUpgradePop()
	local var_86_0 = horcrux_manager:getHorcruxHClass(self.entityid)
	local var_86_1 = playermodel.items[self.entityid].itemid
	local var_86_2
	local var_86_3
	local var_86_4

	if var_86_0 > 0 then
		var_86_2 = horcrux_manager:getHorcruxDamageFac(self.entityid) / 100 + horcrux_manager:getHorcruxDamageFacAdditionByEntityid(self.entityid) / 100
		var_86_3 = horcrux_manager:getHorcruxHpFac(self.entityid) / 100 + horcrux_manager:getHorcruxHpFacAdditionByEntityid(self.entityid) / 100
	else
		var_86_2 = horcrux_manager:getHorcruxDamageFac(self.entityid) / 100
		var_86_3 = horcrux_manager:getHorcruxHpFac(self.entityid) / 100
	end

	local var_86_5
	local var_86_6
	local var_86_7
	local var_86_8
	local var_86_9 = true
	local var_86_10 = true

	if var_86_0 < horcrux_manager:getHorcruxMaxHclass(var_86_1) then
		if var_86_0 == 0 then
			var_86_5 = var_86_2 + horcrux_manager:getHorcruxDamageFacAdditionByEntityid(self.entityid, var_86_0 + 1) / 100
			var_86_6 = var_86_3 + horcrux_manager:getHorcruxHpFacAdditionByEntityid(self.entityid, var_86_0 + 1) / 100
		else
			var_86_5 = var_86_2 + (horcrux_manager:getHorcruxDamageFacAdditionByEntityid(self.entityid, var_86_0 + 1) - horcrux_manager:getHorcruxDamageFacAdditionByEntityid(self.entityid)) / 100
			var_86_6 = var_86_3 + (horcrux_manager:getHorcruxHpFacAdditionByEntityid(self.entityid, var_86_0 + 1) - horcrux_manager:getHorcruxHpFacAdditionByEntityid(self.entityid)) / 100
		end

		var_86_7 = var_86_2 .. " → " .. var_86_5
		var_86_8 = math.floor(var_86_3) .. " → " .. math.floor(var_86_6)
	else
		var_86_7 = var_86_2 .. " → " .. L_HORCRUX_ATTR_MAX
		var_86_8 = math.floor(var_86_3) .. " → " .. L_HORCRUX_ATTR_MAX
		var_86_5 = L_HORCRUX_ATTR_MAX
		var_86_6 = L_HORCRUX_ATTR_MAX
	end

	local function var_86_11(arg_87_0)
		return
	end

	print("text1", var_86_7)
	print("text2", var_86_7)

	local var_86_12 = "public/rolebg/horcrux_+" .. (var_86_0 + 1 > 5 and var_86_0 or var_86_0 + 1) .. ".png"
	local var_86_13 = "public/rolebg/horcrux_+" .. var_86_0 .. ".png"
	local var_86_14 = horcrux_manager:getHorcruxMaxHclass(playermodel.items[self.entityid].itemid)

	if var_86_14 <= var_86_0 then
		var_86_12 = "public/rolebg/horcrux_+5.png"
		var_86_13 = "public/rolebg/horcrux_+5.png"
	end

	local var_86_15 = {
		titlePath = "public/panelbg/title_horcrux_up_grade.png",
		costDesPath = "public/panelbg/need_material.png",
		labels = {
			{
				{
					path = "public/panelbg/next_class.png",
					type = "image"
				},
				{
					type = "image",
					path = var_86_13
				},
				{
					path = "public/panelbg/strengen_arrow.png",
					type = "image"
				},
				{
					type = "image",
					path = var_86_12
				}
			},
			{
				{
					type = "text",
					str = L_HORCRUX_BREAK_LIMIT.Aptitude_Str[2] .. var_86_2
				},
				{
					path = "public/panelbg/strengen_arrow.png",
					type = "image"
				},
				{
					type = "text",
					str = var_86_5
				}
			},
			{
				{
					type = "text",
					str = L_HORCRUX_BREAK_LIMIT.Aptitude_Str[3] .. var_86_3
				},
				{
					path = "public/panelbg/strengen_arrow.png",
					type = "image"
				},
				{
					type = "text",
					str = var_86_6
				}
			}
		},
		cancelcallback = var_86_11,
		materials = {},
		bntstr = L_BUTTON_TEXT.Horcrux_Btn.Advance,
		grayBtnHandel = function()
			if not var_86_9 then
				return true, L_HORCRUX_BREAK_LIMIT.Warning[5]
			end

			if not var_86_10 then
				return true, L_GOLD_LACK
			end

			if horcrux_manager:getHorcruxHClass(self.entityid) >= var_86_14 then
				return true, L_HORCRUX_BREAK_LIMIT.Warning[7]
			end
		end
	}

	if var_86_14 <= var_86_0 then
		table.remove(var_86_15.labels[1], 3)
		table.remove(var_86_15.labels[1], 2)
		table.remove(var_86_15.labels[2], 3)
		table.remove(var_86_15.labels[2], 2)
		table.remove(var_86_15.labels[3], 3)
		table.remove(var_86_15.labels[3], 2)
	end

	var_86_15.canUseSuperChip = item_data[var_86_1].use_superchip and tonumber(item_data[var_86_1].use_superchip)

	local var_86_18 = 0

	if item_data[var_86_1]["lv" .. var_86_0 + 1 .. "_material1"] then
		var_86_15.cost = item_data[var_86_1]["lv" .. var_86_0 + 1 .. "_gold"]

		if var_86_15.cost > playermodel.gold then
			var_86_10 = false
		end

		local var_86_19 = 1

		while item_data[var_86_1]["lv" .. var_86_0 + 1 .. "_material" .. var_86_19] do
			var_86_15.materials[#var_86_15.materials + 1] = {}
			var_86_15.materials[#var_86_15.materials].itemid = item_data[var_86_1]["lv" .. var_86_0 + 1 .. "_material" .. var_86_19]
			var_86_15.materials[#var_86_15.materials].ownNum = item_manager:getItemNumber(item_data[var_86_1]["lv" .. var_86_0 + 1 .. "_material" .. var_86_19])
			var_86_15.materials[#var_86_15.materials].needNum = item_data[var_86_1]["lv" .. var_86_0 + 1 .. "_material" .. var_86_19 .. "_num"]

			if var_86_15.materials[#var_86_15.materials].ownNum < var_86_15.materials[#var_86_15.materials].needNum then
				var_86_9 = false
				var_86_18 = var_86_18 + var_86_15.materials[#var_86_15.materials].needNum - var_86_15.materials[#var_86_15.materials].ownNum
			end

			var_86_19 = var_86_19 + 1
		end
	end

	if var_86_15.canUseSuperChip then
		if var_86_18 <= item_manager:getItemNumber(tonumber(item_data[var_86_1].use_superchip)) then
			var_86_9 = true
		end

		var_86_15.lackCount = var_86_18
		var_86_15.lackItem = tonumber(item_data[var_86_1].use_superchip)
		var_86_15.imgChip = "equipment/" .. item_data[tonumber(item_data[var_86_1].use_superchip)].image_id .. ".png"
	end

	local function var_86_21(arg_89_0)
		horcrux_manager:horcruxUpgrade(self.entityid, {}, function(arg_90_0)
			if not var_0_18 then
				return
			end

			if arg_90_0 == 1 then
				nextTbl = horcrux_manager:getHorcruxDataWithPreset(self.entityid)
				self.selectedHorcruxList = {}

				self:updateMainAttrPanel()
				self.listPanel:reloadData()
				self:updateFightCapacity()
				self:showUpGradeAni({
					{
						L_HORCRUX_BREAK_LIMIT.Aptitude_Str[1],
						L_HORCRUX_BREAK_LIMIT.Aptitude_Str[2],
						L_HORCRUX_BREAK_LIMIT.Aptitude_Str[3]
					},
					{
						var_86_0 .. " → " .. var_86_0 + 1,
						var_86_7,
						var_86_8
					}
				})

				if arg_89_0 then
					arg_89_0()
				end

				var_86_4:runAction(cc.RemoveSelf:create())
			elseif arg_90_0 == 3 then
				global_ShowBlockWords(L_HORCRUX_BREAK_LIMIT.Warning[5])
				audio_manager:playeffectMusicTest("sound/invalid")
			end
		end)
	end

	function var_86_15.surecallback(arg_91_0, arg_91_1)
		if not var_86_9 then
			global_ShowBlockWords(L_HORCRUX_BREAK_LIMIT.Warning[5])

			if arg_91_1 then
				arg_91_1()
			end

			return
		end

		if not var_86_10 then
			global_ShowBlockWords(L_GOLD_LACK)

			if arg_91_1 then
				arg_91_1()
			end

			return
		end

		if var_86_18 > 0 then
			LayerManager:pushInLayer("PopMsgLayer", {
				msgType = 1,
				strInfo = L_BREAKOUT_DO_DES,
				costInfo = {
					scaleIcon = 0.3,
					loadTextureType = 0,
					costImg = var_86_15.imgChip,
					costNum = var_86_15.lackCount,
					posIcon = cc.p(320, 80),
					posLabel = cc.p(75, -80),
					colorLabel = cc.c3b(0, 200, 0),
					ownNum = item_manager:getItemNumber(var_86_15.lackItem)
				},
				buttons = {
					confirm = {
						img = "public/button/public_button_orange_long.png",
						label = L_SERVANT_BREAKLIMIT.bntstr,
						color = cc.c3b(0, 0, 0)
					}
				},
				confirmCallBack = var_86_21,
				cancelCallBack = function()
					if arg_91_1 then
						arg_91_1()
					end
				end
			})
		else
			var_86_21(arg_91_0)
		end
	end

	var_86_4 = self:createUpGradePop(var_86_15)

	local var_86_22 = ccui.Helper:seekWidgetByName(var_86_4, "button_sure")

	if var_86_0 < horcrux_manager:getHorcruxMaxHclass(var_86_1) and var_86_10 and var_86_9 then
		AlertManager:add_alert_by_config(var_86_22, true, {
			ALERT_SHOW_REDDOT,
			"",
			cc.p(var_86_22:getContentSize().width - 20, var_86_22:getContentSize().height)
		})
	end

	self:addChild(var_86_4, 9)
end

function HorcruxInfoLayerNew:createUpGradePop(arg_93_1)
	local var_93_0 = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "horcrux_upgrade.json" or "horcrux_upgrade.ExportJson")
	local var_93_1 = ccui.Helper:seekWidgetByName(var_93_0, "panel_back")

	var_93_1:setScaleY(0)
	var_93_1:runAction(cc.ScaleTo:create(0.2, 1, 1))
	var_93_1:setTouchEnabled(true)
	require("controller.layer_manager"):createFullScreenMask(var_93_0, 180, function(arg_94_0, arg_94_1)
		if arg_94_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_93_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 0), cc.CallFunc:create(function()
			var_93_0:runAction(cc.RemoveSelf:create())
		end)))
	end)

	local var_93_2 = ccui.Helper:seekWidgetByName(var_93_0, "panel_intro")
	local var_93_3 = ccui.Helper:seekWidgetByName(var_93_0, "button_sure")
	local var_93_4 = ccui.Helper:seekWidgetByName(var_93_0, "panel_cost")
	local var_93_5 = ccui.Helper:seekWidgetByName(var_93_0, "Panel_icon")

	ccui.Helper:seekWidgetByName(var_93_0, "Label_itemName"):setString(var_0_16[playermodel.items[self.entityid].itemid].name)
	ccui.Helper:seekWidgetByName(var_93_0, "Label_limitDes"):setString(arg_93_1.limitDes)
	ccui.Helper:seekWidgetByName(var_93_0, "Image_costDes"):loadTexture("public/panelbg/need_material.png", var_0_0)
	ccui.Helper:seekWidgetByName(var_93_0, "Label_sureText"):setString(arg_93_1.bntstr)
	ccui.Helper:seekWidgetByName(var_93_0, "Image_title"):loadTexture(arg_93_1.titlePath, var_0_0)

	local var_93_6 = ccui.ImageView:create(CUTE_ROLE_IMAGE_PATH .. model_data[var_0_16[playermodel.items[self.entityid].itemid].model].cute_Q .. ".png")

	var_93_6:setPositionX(var_93_5:getContentSize().width / 2)
	var_93_6:setPositionY(0)
	var_93_6:setAnchorPoint(cc.p(0.5, 0))
	var_93_6:setScale(0.45)
	var_93_5:addChild(var_93_6)

	local function var_93_7(arg_96_0)
		local var_96_0 = cc.Label:createWithTTF(arg_96_0, FONT_DES, 22)

		var_96_0:setAnchorPoint(cc.p(0, 0.5))
		var_96_0:setColor(cc.c3b(0, 216, 255))

		return var_96_0
	end

	local function var_93_8(arg_97_0)
		local var_97_0 = ccui.ImageView:create(arg_97_0, var_0_0)

		var_97_0:setAnchorPoint(cc.p(0, 0.5))

		return var_97_0
	end

	local var_93_9, var_93_10 = arg_93_1.grayBtnHandel()

	if var_93_9 then
		var_93_3:loadTextures("public/button/public_button_gray_long.png", nil, "public/button/public_button_gray_long.png", var_0_0)
		ccui.Helper:seekWidgetByName(var_93_0, "Label_sureText"):setString(var_93_10)
	end

	if arg_93_1.cost and arg_93_1.materials then
		table.insert(arg_93_1.materials, {
			itemid = "gold",
			ownNum = playermodel.gold,
			needNum = arg_93_1.cost
		})
	end

	if arg_93_1.materials and next(arg_93_1.materials) then
		for iter_93_0, iter_93_1 in pairs(arg_93_1.materials) do
			local var_93_11 = ccui.Helper:seekWidgetByName(var_93_0, "Panel_costItem")
			local var_93_12 = var_93_11:clone()
			local var_93_13 = ItemSmallSprite:createSmallItem(iter_93_1.itemid, iter_93_1.ownNum, iter_93_1.needNum, self.goto_back_system_id)

			var_93_13.setScale(var_93_11, 0.7)
			var_93_13:setInfoTouchEvent(true)
			var_93_13:setPosition(cc.p(var_93_12:getContentSize().width / 2, var_93_12:getContentSize().height / 2))
			var_93_12:addChild(var_93_13)
			var_93_12:setName("Panel_costItem" .. iter_93_0)
			ccui.Helper:seekWidgetByName(var_93_0, "ListView_38"):pushBackCustomItem(var_93_12)
		end
	end

	local var_93_14 = ccui.Helper:seekWidgetByName(var_93_0, "Label_itemName"):getPositionX()
	local var_93_15 = var_93_14
	local var_93_16 = 150

	if arg_93_1.labels and next(arg_93_1.labels) then
		for iter_93_2, iter_93_3 in ipairs(arg_93_1.labels) do
			for iter_93_4, iter_93_5 in pairs(iter_93_3) do
				local var_93_17

				if iter_93_5.type == "image" then
					var_93_17 = var_93_8(iter_93_5.path)
				end

				if iter_93_5.type == "text" then
					var_93_17 = var_93_7(iter_93_5.str)
				end

				var_93_17:setPosition(cc.p(var_93_15, var_93_16))

				var_93_15 = var_93_17:getContentSize().width + var_93_15 + 5

				var_93_2:addChild(var_93_17)
			end

			var_93_16 = var_93_16 - 40
			var_93_15 = var_93_14
		end
	end

	local var_93_18 = ccui.ImageView:create(arg_93_1.imgChip)

	var_93_18:setPosition(var_93_2:getContentSize().width - 185, -190)
	var_93_18:setScale(0.2)
	var_93_2:addChild(var_93_18)
	var_93_18:setVisible(not not arg_93_1.canUseSuperChip)
	require("common.Utility"):addClickEventListener(var_93_18, function()
		LayerManager:pushInLayer("PopItemLayer", {
			itemid = arg_93_1.lackItem
		})
	end)

	local var_93_19 = ccui.Text:create("", "fonts/name.ttf", 24)

	var_93_19:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_LEFT)
	var_93_19:setTextVerticalAlignment(cc.TEXT_ALIGNMENT_CENTER)
	var_93_19:setAnchorPoint(0, 0.5)
	var_93_18:addChild(var_93_19)
	var_93_19:setScale(5)
	var_93_19:setString(L_GONGESUIPIAN .. item_manager:getItemNumber(arg_93_1.lackItem))
	var_93_19:setPosition(var_93_18:getContentSize().width, var_93_18:getContentSize().height / 2)
	var_93_3:addTouchEventListener(function(arg_99_0, arg_99_1)
		if arg_99_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not var_93_3:isBright() then
			return
		end

		var_93_3:setBright(false)

		if var_93_9 then
			global_ShowBlockWords(var_93_10)
			var_93_3:setBright(true)
		elseif arg_93_1.surecallback then
			arg_93_1.surecallback(function()
				var_93_0:runAction(cc.RemoveSelf:create())
			end, function()
				var_93_3:setBright(true)
			end)
		end
	end)

	return var_93_0
end

local function var_0_41(arg_102_0)
	return global_get_model_attr(arg_102_0)
end

function HorcruxInfoLayerNew:showUpGradeAni(arg_103_1, arg_103_2)
	local armature_manager = require("controller.armature_manager")

	print(dump(arg_103_1), dump(arg_103_2))

	local var_103_1 = ccui.Layout:create()

	var_103_1:setTouchEnabled(true)
	var_103_1:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_103_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_103_1:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_103_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_103_1:setBackGroundColor(cc.c3b(0, 0, 0))
	var_103_1:setBackGroundColorOpacity(200)
	cc.Director:getInstance():getRunningScene():addChild(var_103_1, 10000)
	audio_manager:playeffectMusic(CLASS_UPGRADE_EFFECT)

	local function var_103_2(arg_104_0, arg_104_1)
		local var_104_0 = ccui.Layout:create()

		var_104_0:setContentSize(640, 32)
		var_104_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_104_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_104_0:setBackGroundColorOpacity(0)

		local var_104_1 = cc.Label:createWithTTF(arg_104_0, FONT_DES, 32)

		var_104_1:setColor(cc.c3b(178, 194, 198))
		var_104_1:setAnchorPoint(cc.p(0, 0.5))
		var_104_1:setPosition(cc.p(110, var_104_0:getContentSize().height / 2))
		var_104_0:addChild(var_104_1)

		local var_104_2 = cc.Label:createWithTTF(arg_104_1, FONT_DES, 32)

		var_104_2:setColor(cc.c3b(255, 178, 77))
		var_104_2:setAnchorPoint(cc.p(0, 0.5))
		var_104_2:setPosition(cc.p(303, var_104_0:getContentSize().height / 2))
		var_104_0:addChild(var_104_2)

		return var_104_0
	end

	local function var_103_3()
		for iter_105_0 = 1, 3 do
			var_103_1:addChild((cc.Node:create()))

			local var_105_0 = var_103_2(arg_103_1[1][iter_105_0], arg_103_1[2][iter_105_0])

			var_105_0:setPosition(cc.p(-320, 466 - (iter_105_0 - 1) * 50))
			var_105_0:runAction(cc.Sequence:create(cc.DelayTime:create((iter_105_0 - 1) * 5 / 60), cc.MoveBy:create(0.2, cc.p(640, 0))))
			var_103_1:addChild(var_105_0)
		end
	end

	local var_103_4 = {
		img_girl1 = CUTE_ROLE_IMAGE_PATH .. model_data[item_data[playermodel.items[self.entityid].itemid].model].cute_Q .. ".png",
		img_girl2 = CUTE_ROLE_IMAGE_PATH .. model_data[item_data[playermodel.items[self.entityid].itemid].model].cute_Q .. ".png"
	}
	local var_103_5 = {}
	local var_103_6 = var_0_41(item_data[playermodel.items[self.entityid].itemid].model)

	if var_103_6 == "null" then
		var_103_6 = "wind"
	elseif var_103_6 == "imaginary" then
		var_103_6 = "dark"
	elseif var_103_6 == "devil" then
		var_103_6 = "dark"
	elseif var_103_6 == "shiling" then
		var_103_6 = "light"
	elseif not ({
		wind = true,
		water = true,
		fire = true,
		light = true,
		dark = true
	})[var_103_6] then
		var_103_6 = "wind"
	end

	var_103_1:addChild((armature_manager:createAndPlayArmature("horcruxUpClass", var_103_4, var_103_5, {
		["girl_attack_" .. var_103_6] = var_103_3
	}, var_103_6)))
	var_103_1:runAction(cc.Sequence:create(cc.DelayTime:create(10), cc.RemoveSelf:create()))
	var_103_1:addTouchEventListener(function(arg_106_0, arg_106_1)
		if arg_106_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_103_1:runAction(cc.RemoveSelf:create())
	end)
end

function HorcruxInfoLayerNew.showBreakLimitAni(arg_107_0, arg_107_1, arg_107_2)
	audio_manager:playeffectMusicTest("sound/upgrade_rank")

	local var_107_0 = ccui.Layout:create()

	var_107_0:setTouchEnabled(true)
	var_107_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_107_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_107_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_107_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_107_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_107_0:setBackGroundColorOpacity(180)
	global_basic_scene:addChild(var_107_0, 999)

	local var_107_1 = L2Skeleton:create("spine/ui/servant_break_limit/e_level_break_limit.json", "spine/ui/servant_break_limit/e_level_break_limit.atlas")

	var_107_1:refreshSkeleton()
	var_107_1.skeletonAnimation:setPosition(cc.p(320, 600))
	var_107_1:play("e_tupo", false)
	var_107_0:addChild(var_107_1)

	local var_107_3 = ccui.Text:create(arg_107_2.text .. arg_107_2.oldBreakNum, FONT_BUTTON, 30)

	var_107_3:setColor(cc.c3b(255, 150, 0))
	var_107_3:setOpacity(0)
	var_107_3:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.FadeIn:create(0), cc.DelayTime:create(0.38), cc.FadeOut:create(0), cc.DelayTime:create(0.06), cc.FadeIn:create(0), cc.CallFunc:create(function()
		var_107_3:setString(arg_107_2.text .. arg_107_2.curBreakNum)
	end), cc.ScaleTo:create(0.2, 1.2), cc.DelayTime:create(0.2), cc.FadeOut:create(0.1), cc.RemoveSelf:create()))
	var_107_3:setPositionX(320)
	var_107_3:setPositionY(630)
	var_107_0:addChild(var_107_3, 2)

	local function var_107_4()
		local var_109_0 = {}
		local var_109_1 = {}
		local var_109_2 = {}

		while #arg_107_1[1] > 0 do
			var_109_0[#var_109_0 + 1] = arg_107_1[1][#arg_107_1[1]]
			var_109_2[#var_109_2 + 1] = arg_107_1[2][#arg_107_1[1]]
			var_109_1[#var_109_1 + 1] = arg_107_1[3][#arg_107_1[1]]
		end

		local var_109_4 = 850

		;(function()
			local var_110_0 = ccui.Text:create(arg_107_2.text, FONT_DES, 26)

			var_110_0:setColor(cc.c3b(255, 150, 0))
			var_110_0:setPositionX(150)
			var_110_0:setPositionY(var_109_4 - 80)
			var_110_0:setOpacity(0)
			var_110_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.FadeIn:create(0.3)))
			var_107_0:addChild(var_110_0, 2)

			local var_110_1 = ccui.Text:create(arg_107_2.oldBreakNum, FONT_DES, 26)

			var_110_1:setColor(cc.c3b(255, 150, 0))
			var_110_1:setPositionX(350)
			var_110_1:setPositionY(var_109_4 - 80)
			var_110_1:setOpacity(0)
			var_110_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.FadeIn:create(0.3)))
			var_107_0:addChild(var_110_1, 2)

			local var_110_2 = ccui.Text:create(arg_107_2.curBreakNum, FONT_DES, 26)

			var_110_2:setColor(cc.c3b(255, 150, 0))
			var_110_2:setPositionX(500)
			var_110_2:setPositionY(var_109_4 - 80)
			var_110_2:setOpacity(0)
			var_110_2:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.FadeIn:create(0.3)))
			var_107_0:addChild(var_110_2, 2)
		end)()

		for iter_109_0, iter_109_1 in pairs(var_109_0) do
			local var_109_5 = ccui.Text:create(iter_109_1, FONT_DES, 26)

			var_109_5:setColor(var_109_1[iter_109_0])
			var_109_5:setPositionX(150)
			var_109_5:setPositionY(var_109_4 - iter_109_0 * 70)
			var_109_5:setOpacity(0)
			var_109_5:runAction(cc.Sequence:create(cc.DelayTime:create(0.3 * iter_109_0 + 1), cc.Spawn:create(cc.FadeIn:create(0.3), cc.MoveTo:create(0.2, cc.p(150, var_109_4 - (iter_109_0 + 1) * 70)))))
			var_107_0:addChild(var_109_5, 2)

			local var_109_6 = ccui.Text:create(var_109_2[iter_109_0], FONT_DES, 26)

			var_109_6:setColor(var_109_1[iter_109_0])
			var_109_6:setPositionX(420)
			var_109_6:setPositionY(var_109_4 - iter_109_0 * 70)
			var_109_6:setOpacity(0)
			var_109_6:runAction(cc.Sequence:create(cc.DelayTime:create(0.3 * iter_109_0 + 1), cc.Spawn:create(cc.FadeIn:create(0.3), cc.MoveTo:create(0.2, cc.p(420, var_109_4 - (iter_109_0 + 1) * 70)))))
			var_107_0:addChild(var_109_6, 2)
		end
	end

	local var_107_5 = false

	var_107_0:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
		var_107_5 = true

		var_107_4()
	end), cc.DelayTime:create(10), cc.RemoveSelf:create()))
	var_107_0:addTouchEventListener(function(arg_112_0, arg_112_1)
		if arg_112_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not var_107_5 then
			return
		end

		var_107_0:runAction(cc.RemoveSelf:create())
	end)
end

function HorcruxInfoLayerNew:initShowAttrBtn()
	local var_113_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_attrBtn")

	var_113_0:addTouchEventListener(function(arg_114_0, arg_114_1)
		if arg_114_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.showAttr = not self.showAttr

		self:updateShowingCells()

		if self.showAttr == false then
			var_113_0:loadTexture("public/filter/attr_icon_off.png", var_0_0)
		else
			var_113_0:loadTexture("public/filter/attr_icon_on.png", var_0_0)
		end
	end)
end

function HorcruxInfoLayerNew:initFilterBtn()
	self.filterButton = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_screenBtn")

	self.filterButton:addTouchEventListener(function(arg_116_0, arg_116_1)
		if arg_116_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:showFilterPopLayer()
	end)
end

function HorcruxInfoLayerNew:updateShowingCells()
	if self.listDataType == 1 then
		local var_117_0, var_117_1 = GetTableViewShowCellIdx(self.listPanel, {
			maxcount = math.ceil(#self.horcruxList / var_0_38),
			cellsize = cc.size(var_0_32, var_0_33)
		})

		for iter_117_0 = var_117_0, var_117_1 do
			self.listPanel:updateCellAtIndex(iter_117_0)
		end
	else
		local var_117_2, var_117_3 = GetTableViewShowCellIdx(self.expListPanel, {
			maxcount = math.ceil(#self.horcruxExpItemList / var_0_38),
			cellsize = cc.size(var_0_34, var_0_35)
		})

		for iter_117_1 = var_117_2, var_117_3 do
			self.expListPanel:updateCellAtIndex(iter_117_1)
		end
	end
end

function HorcruxInfoLayerNew:showFilterPopLayer()
	local var_118_0 = {
		{
			0
		},
		{
			0
		}
	}

	var_118_0 = self.sortOrder == 0 and {
		1,
		0
	} or {
		0,
		1
	}

	if self.filterSpritePop then
		self.filterSpritePop:playPopAni()
	else
		self.filterSpritePop = self:createFilterPop()

		self.rootLayer:addChild(self.filterSpritePop, 1000)
	end

	self.filterSpritePop:setSortOrderState(1, var_118_0)
	self.filterSpritePop:updateAllFilterBtn()
	self:updateTitleBottom(2)
end

function HorcruxInfoLayerNew:updateTitleBottom(arg_119_1)
	if self.filterPopModel == false and arg_119_1 == 2 or self.filterPopModel == true and arg_119_1 == 1 then
		self.filterPopModel = not self.filterPopModel

		if arg_119_1 == 1 then
			self.filterButton:loadTexture("public/filter/filter_icon_off.png", var_0_0)
			self.bottomList:runAction(cc.MoveBy:create(0.2, cc.p(0, 100)))
		else
			self.filterButton:loadTexture("public/filter/filter_icon_on.png", var_0_0)
			self.bottomList:runAction(cc.MoveBy:create(0.2, cc.p(0, -100)))
		end
	end
end

function HorcruxInfoLayerNew:createFilterPop()
	local var_120_0 = FilterHorcurxSelectSprite:create({
		filterType = filter_config_manager.HORCRUX_LAYER,
		filterCallback = function(arg_121_0)
			self:filterCallback(arg_121_0)
		end,
		maskTouchCallback = function(arg_122_0)
			if self.filterAniFlag1 then
				self.filterAniFlag1 = false

				self.filterSpritePop:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
					self.filterAniFlag1 = true
					self.filterAniFlag = true
				end)))
				self:updateTitleBottom(1)
				arg_122_0()
			end
		end,
		sortOrderChangeCallback = function(arg_124_0)
			self:sortCallback(arg_124_0)
		end,
		defaultSortOrder = self.curSortOrders
	})

	var_120_0:setPositionY(-GameDisplay.fix_y)

	return var_120_0
end

function HorcruxInfoLayerNew:sortCallback()
	self.sortOrder = 1 - self.sortOrder

	self:updateShowingCells()
end

function HorcruxInfoLayerNew:filterCallback(arg_126_1)
	self.filterTbl.sortType = arg_126_1.sortType or self.filterTbl

	for iter_126_0, iter_126_1 in pairs(arg_126_1.filterConfig) do
		self.filterTbl.filterConfig[iter_126_0] = global_deepCopy(iter_126_1)
	end

	self.curSort = self.filterTbl.sortType
	self.horcruxList = self.bagManager:getBagData(self.filterTbl)

	self:sortHorcruxList()

	self.selectedHorcruxList = {}
	self.selectModel = 0

	self:updateUpLevelPopExpBar(self.entityid)
	self:updateMainAttrPanel()
	self:updateSelectedNum()
	self.listPanel:reloadData()
end

function HorcruxInfoLayerNew:reSortOrder()
	self.sortOrder = 1 - self.sortOrder
end

function HorcruxInfoLayerNew:startCompoundAni()
	local var_128_0 = ccui.Layout:create()

	var_128_0:setTouchEnabled(true)
	var_128_0:setContentSize(GameDisplay.getScreenSize())
	var_128_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_128_0:setPosition(cc.p(GameDisplay.width / 2, GameDisplay.height / 2 - GameDisplay.fix_y))
	var_128_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_128_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_128_0:setBackGroundColorOpacity(255)
	var_128_0:addTouchEventListener(function(arg_129_0, arg_129_1)
		if arg_129_1 ~= ccui.TouchEventType.ended then
			return
		end

		GuideListener.lockGuideTrigger(false)
		GuideListener.updateGuides(self)
		var_128_0:runAction(cc.RemoveSelf:create())
	end)
	self:addChild(var_128_0, 10001)

	local var_128_1
	local var_128_2
	local var_128_3

	local function var_128_4(arg_130_0, arg_130_1)
		return math.ceil(arg_130_1 / horcrux_strength_data[arg_130_0].exp * 100)
	end

	local function var_128_5()
		local var_132_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_main_attr"):clone()

		var_132_0:setPosition(cc.p(0, 568 - var_132_0:getContentSize().height / 2))
		var_128_0:addChild(var_132_0)

		self.upLevelAniLevelLabel = ccui.Helper:seekWidgetByName(var_132_0, "Label_level")
		self.upLevelAniLevelbar = ccui.Helper:seekWidgetByName(var_132_0, "ProgressBar_cur")

		self.upLevelAniLevelLabel:setString(self.oldLevel)
		self.upLevelAniLevelbar:setPercent(var_128_4(self.oldLevel, self.oldExp))
	end

	function var_128_2()
		local var_136_0 = ccui.ImageView:create("HorcruxInfo/light.png", var_0_0)

		var_136_0:setPosition(cc.p(var_128_0:getContentSize().width / 2, var_128_0:getContentSize().height / 2))
		var_128_0:addChild(var_136_0)
		var_136_0:setScale(100)
		var_136_0:setOpacity(128)
		var_136_0:runAction(cc.Spawn:create(cc.FadeIn:create(0.1), cc.Sequence:create(cc.ScaleTo:create(0.3, 0, 0), cc.FadeOut:create(0.1)), cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
			var_128_5()
			var_128_1()
		end))))
	end

	function var_128_1()
		local var_138_0 = self.curLevel
		local var_138_1 = self.curExp
		local var_138_2 = math.min(horcrux_manager:getHorcruxBreakLv(self.entityid) * 10, horcrux_manager:get_max_level(self.entityid))

		if var_138_2 < self.curLevel then
			var_138_0 = var_138_2
			var_138_1 = 100
		end

		local var_138_3 = math.pow(var_138_0 - self.oldLevel + 1, 0.5)
		local var_138_4 = math.ceil(self.oldExp / horcrux_strength_data[self.oldLevel].exp * 100)
		local var_138_5 = math.ceil(var_138_1 / horcrux_strength_data[var_138_0].exp * 100)

		if var_138_5 > 100 then
			var_138_5 = 100
		end

		local var_138_6 = (var_138_0 - self.oldLevel) * 100 + var_138_5 - var_138_4
		local var_138_7 = ((var_138_0 - self.oldLevel) * 100 + var_138_5 - var_138_4) / var_138_3 * 0.016666666666666666
		local var_138_8 = math.ceil(self.oldExp / horcrux_strength_data[self.oldLevel].exp * 100)
		local var_138_9 = self.oldLevel
		local var_138_10 = cc.Node:create()

		var_128_0:addChild(var_138_10)

		local function var_138_11()
			local var_139_0 = ccui.ImageView:create("HorcruxInfo/exp_light.png", var_0_0)

			var_139_0:setPositionX(self.upLevelAniLevelbar:getContentSize().width / 2)
			var_139_0:setPositionY(self.upLevelAniLevelbar:getContentSize().height / 2)
			var_139_0:setAnchorPoint(cc.p(0.5, 0.5))
			var_139_0:runAction(cc.Sequence:create(cc.EaseOut:create(cc.FadeIn:create(0.1), 2), cc.EaseIn:create(cc.FadeOut:create(0.1), 2), cc.RemoveSelf:create()))
			self.upLevelAniLevelbar:addChild(var_139_0)
		end

		local var_138_12 = 0
		local var_138_13 = var_138_6 - ((var_138_0 - self.oldLevel) * 100 + var_138_5 - var_138_4) / var_138_3 * 0.016666666666666666

		var_138_10:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
			if var_138_12 < 0 then
				var_138_13 = var_138_13 - var_138_7
				var_138_8 = var_138_8 + var_138_7

				if tonumber(tostring(var_138_8)) > 100 then
					var_138_8 = var_138_8 % 100

					self.upLevelAniLevelbar:setPercent(var_138_8)

					var_138_9 = var_138_9 + 1

					audio_manager:playeffectMusic("sound/upgrade")
					var_138_11()

					var_138_12 = 0.15
				else
					self.upLevelAniLevelbar:setPercent(var_138_8)
				end

				if var_138_9 >= horcrux_manager:get_max_level(self.entityid) then
					var_138_9 = horcrux_manager:get_max_level(self.entityid)
				end

				self.upLevelAniLevelLabel:setString(var_138_9)

				if var_138_13 <= 0 then
					if var_138_9 >= horcrux_manager:get_max_level(self.entityid) then
						self.upLevelAniLevelbar:setPercent(100)
					end

					var_138_10:stopAllActions()
					var_128_3()
				end
			else
				var_138_12 = var_138_12 - 0.016666666666666666
			end
		end), cc.DelayTime:create(0.016666666666666666))))
	end

	function var_128_3()
		local function var_141_0(arg_142_0, arg_142_1)
			local var_142_0 = 0
			local var_142_1 = 0.1

			for iter_142_0, iter_142_1 in pairs(arg_142_0) do
				if iter_142_1.displayType == "string" then
					local var_142_2 = utfstrlen(iter_142_1.str)
					local var_142_3 = ccui.Text:create("", FONT_NAME, 36)

					var_142_3:setPosition(iter_142_1.pos)
					var_142_3:setAnchorPoint(cc.p(0, 0.5))
					var_142_3:setColor(iter_142_1.color)
					var_128_0:addChild(var_142_3)

					local var_142_4 = 0
					local var_142_6 = cc.Node:create()

					var_128_0:addChild(var_142_6)
					var_142_6:runAction(cc.Sequence:create(cc.DelayTime:create(var_142_0), cc.CallFunc:create(function()
						var_142_3:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
							if var_142_4 >= var_142_2 then
								var_142_3:stopAllActions()
							end

							var_142_3:setString(utfmatch(iter_142_1.str, var_142_4))

							var_142_4 = var_142_4 + 1
						end), cc.DelayTime:create(var_142_1))))
					end)))

					var_142_0 = var_142_0 + 0.1 * var_142_2
				else
					local var_142_7 = ccui.ImageView:create(iter_142_1.path, var_0_0)

					var_142_7:setVisible(false)
					var_142_7:setAnchorPoint(cc.p(0, 0.5))
					var_142_7:setPosition(iter_142_1.pos)
					var_128_0:addChild(var_142_7)
					var_142_7:runAction(cc.Sequence:create(cc.DelayTime:create(var_142_0), cc.CallFunc:create(function()
						var_142_7:setVisible(true)
					end)))

					var_142_0 = var_142_0 + 0.1
				end
			end

			local var_142_8 = cc.Node:create()

			var_128_0:addChild(var_142_8)
			var_142_8:runAction(cc.Sequence:create(cc.DelayTime:create(var_142_0), cc.CallFunc:create(function()
				if arg_142_1 then
					arg_142_1()
				end
			end)))
		end

		local var_141_1 = horcrux_manager:getHorcruxDataWithPreset(self.entityid)
		local var_141_2 = horcrux_manager:getHorcruxDataWithPreset(self.entityid, self.oldLevel)
		local var_141_3 = {
			{
				displayType = "image",
				path = "HorcruxInfo/font_img_22.png",
				pos = cc.p(50, 300)
			},
			{
				displayType = "image",
				path = "HorcruxInfo/font_img_21.png",
				pos = cc.p(96, 300)
			},
			{
				displayType = "image",
				path = "HorcruxInfo/font_img_0.png",
				pos = cc.p(142, 300)
			},
			{
				displayType = "string",
				str = tostring(var_141_2.hp),
				color = cc.c3b(255, 255, 255),
				pos = cc.p(175, 300)
			},
			{
				displayType = "image",
				path = "HorcruxInfo/arrow.png",
				pos = cc.p(300, 300)
			},
			{
				displayType = "string",
				str = tostring(var_141_1.hp),
				color = cc.c3b(255, 150, 0),
				pos = cc.p(460, 300)
			}
		}

		var_141_0({
			{
				displayType = "image",
				path = "HorcruxInfo/font_img_11.png",
				pos = cc.p(50, 400)
			},
			{
				displayType = "image",
				path = "HorcruxInfo/font_img_12.png",
				pos = cc.p(96, 400)
			},
			{
				displayType = "image",
				path = "HorcruxInfo/font_img_0.png",
				pos = cc.p(142, 400)
			},
			{
				displayType = "string",
				str = tostring(math.floor(var_141_2.damage)),
				color = cc.c3b(255, 255, 255),
				pos = cc.p(175, 400)
			},
			{
				displayType = "image",
				path = "HorcruxInfo/arrow.png",
				pos = cc.p(300, 400)
			},
			{
				displayType = "string",
				str = tostring(math.floor(var_141_1.damage)),
				color = cc.c3b(255, 150, 0),
				pos = cc.p(460, 400)
			}
		}, function()
			var_141_0(var_141_3)
		end)
	end

	;(function()
		local var_131_0 = ccui.ImageView:create("HorcruxInfo/bottom_light.png", var_0_0)

		var_131_0:setPosition(cc.p(var_128_0:getContentSize().width / 2, var_128_0:getContentSize().height / 2))
		var_128_0:addChild(var_131_0)

		self.horcruxImg = ccui.ImageView:create(CUTE_ROLE_IMAGE_PATH .. model_data[item_data[playermodel.items[self.entityid].itemid].model].cute_Q .. ".png")

		self.horcruxImg:setAnchorPoint(cc.p(0.5, 0))
		self.horcruxImg:setPositionX(var_131_0:getPositionX())
		self.horcruxImg:setPositionY(var_131_0:getPositionY())
		var_128_0:addChild(self.horcruxImg)
	end)()
	var_128_2()
end

function HorcruxInfoLayerNew:showMainAttrPanelAni()
	local var_148_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_main_attr")

	self.upLevelAniLevelLabel = ccui.Helper:seekWidgetByName(var_148_1, "Label_level")
	self.upLevelAniLevelbar = ccui.Helper:seekWidgetByName(var_148_1, "ProgressBar_cur")

	local function var_148_2()
		local var_149_0 = self.curLevel
		local var_149_1 = self.curExp
		local var_149_2 = math.min(horcrux_manager:getHorcruxBreakLv(self.entityid) * 10, horcrux_manager:get_max_level(self.entityid))

		if var_149_2 < self.curLevel then
			var_149_0 = var_149_2
			var_149_1 = 100
		end

		local var_149_3 = math.pow(var_149_0 - self.oldLevel + 1, 0.5)
		local var_149_4 = math.ceil(self.oldExp / horcrux_strength_data[self.oldLevel].exp * 100)
		local var_149_5 = math.ceil(var_149_1 / horcrux_strength_data[var_149_0].exp * 100)

		if var_149_5 > 100 then
			var_149_5 = 100
		end

		local var_149_6 = (var_149_0 - self.oldLevel) * 100 + var_149_5 - var_149_4
		local var_149_7 = ((var_149_0 - self.oldLevel) * 100 + var_149_5 - var_149_4) / var_149_3 * 0.016666666666666666
		local var_149_9 = math.ceil(self.oldExp / horcrux_strength_data[self.oldLevel].exp * 100)
		local var_149_10 = self.oldLevel
		local var_149_11 = cc.Node:create()

		var_149_11:setName("changeTimer")
		self.mainAttrPanel:addChild(var_149_11)

		local function var_149_12()
			local var_150_0 = ccui.ImageView:create("HorcruxInfo/exp_light.png", var_0_0)

			var_150_0:setPositionX(self.upLevelAniLevelbar:getContentSize().width / 2)
			var_150_0:setPositionY(self.upLevelAniLevelbar:getContentSize().height / 2)
			var_150_0:setAnchorPoint(cc.p(0.5, 0.5))
			var_150_0:runAction(cc.Sequence:create(cc.EaseOut:create(cc.FadeIn:create(0.1), 2), cc.EaseIn:create(cc.FadeOut:create(0.1), 2), cc.RemoveSelf:create()))
			self.upLevelAniLevelbar:addChild(var_150_0)
		end

		local function var_149_13()
			horcruxImage = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_stage")

			if not horcruxImage:getChildByName("Image_horcruxImage").flowlight then
				require("controller.l2utils"):flowlightNode(horcruxImage:getChildByName("Image_horcruxImage"):getVirtualRenderer(), {
					period = 1.5000000000000002,
					offset = 0.5,
					width = 0.3,
					strength = 0.05
				})

				horcruxImage:getChildByName("Image_horcruxImage").flowlight = true
			end
		end

		local function var_149_14()
			horcruxImage = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_stage")

			if horcruxImage:getChildByName("Image_horcruxImage").flowlight then
				horcruxImage:getChildByName("Image_horcruxImage").flowlight = false

				require("controller.l2utils"):removeNodeFlowlight(horcruxImage:getChildByName("Image_horcruxImage"):getVirtualRenderer())
			end
		end

		local var_149_15 = 0
		local var_149_16 = var_149_6 - ((var_149_0 - self.oldLevel) * 100 + var_149_5 - var_149_4) / var_149_3 * 0.016666666666666666

		var_149_11:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
			if var_149_15 < 0 then
				var_149_16 = var_149_16 - var_149_7
				var_149_9 = var_149_9 + var_149_7

				if tonumber(tostring(var_149_9)) > 100 then
					var_149_9 = var_149_9 % 100

					self.upLevelAniLevelbar:setPercent(var_149_9)

					var_149_10 = var_149_10 + 1

					ccui.Helper:seekWidgetByName(self.rootLayer, "Label_expDes"):setString(math.floor(0) .. "/" .. horcrux_strength_data[var_149_10].exp)
					audio_manager:playeffectMusic("sound/upgrade")
					var_149_12()

					var_149_15 = 0.15
				else
					self.upLevelAniLevelbar:setPercent(var_149_9)
					self.upLevelAniLevelLabel:setString(var_149_10)
					ccui.Helper:seekWidgetByName(self.rootLayer, "Label_expDes"):setString(math.floor(horcrux_strength_data[var_149_10].exp * var_149_9 / 100) .. "/" .. horcrux_strength_data[var_149_10].exp)
					ccui.Helper:seekWidgetByName(self.rootLayer, "Label_expDes"):setVisible(self.curLevel < horcrux_manager:get_max_level(self.entityid))

					local var_153_0 = horcrux_manager:getHorcruxAssistConfig(self.entityid, 0)
					local var_153_1 = horcrux_manager:getHorcruxDataWithPreset(self.entityid, var_149_10)

					ccui.Helper:seekWidgetByName(self.rootLayer, "Label_infoDamage"):setString(global_trans_number(math.floor(var_153_0.damage)))
					ccui.Helper:seekWidgetByName(self.rootLayer, "Label_infoHp"):setString(global_trans_number(math.floor(var_153_0.hp)))
					ccui.Helper:seekWidgetByName(self.rootLayer, "Label_upstarDamageAdd"):setString("+" .. global_trans_number(math.floor(var_153_1.damage - var_153_0.damage)))
					ccui.Helper:seekWidgetByName(self.rootLayer, "Label_upstarHpAdd"):setString("+" .. global_trans_number(math.floor(var_153_1.hp - var_153_0.hp)))
					ccui.Helper:seekWidgetByName(self.rootLayer, "Label_upstarDamageAdd"):setVisible(math.floor(var_153_1.damage - var_153_0.damage) ~= 0)
					ccui.Helper:seekWidgetByName(self.rootLayer, "Label_upstarHpAdd"):setVisible(math.floor(var_153_1.hp - var_153_0.hp) ~= 0)
					ccui.Helper:seekWidgetByName(self.rootLayer, "Label_infoDamage"):setPositionX(ccui.Helper:seekWidgetByName(self.rootLayer, "Label_upstarDamageAdd"):getPositionX() - ccui.Helper:seekWidgetByName(self.rootLayer, "Label_upstarDamageAdd"):getContentSize().width)
					ccui.Helper:seekWidgetByName(self.rootLayer, "Label_infoHp"):setPositionX(ccui.Helper:seekWidgetByName(self.rootLayer, "Label_upstarHpAdd"):getPositionX() - ccui.Helper:seekWidgetByName(self.rootLayer, "Label_upstarHpAdd"):getContentSize().width)
				end

				if var_149_10 >= horcrux_manager:get_max_level(self.entityid) then
					var_149_10 = horcrux_manager:get_max_level(self.entityid)
				end

				if var_149_16 <= 0 then
					if var_149_10 >= horcrux_manager:get_max_level(self.entityid) then
						self.upLevelAniLevelbar:setPercent(100)
					end

					var_149_11:stopAllActions()
					self:updateMainAttrPanel()

					horcruxImage = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_stage")

					horcruxImage:runAction(cc.Sequence:create(cc.CallFunc:create(function()
						var_149_13()
					end), cc.DelayTime:create(1.5), cc.CallFunc:create(function()
						var_149_14()
					end)))
				end
			else
				var_149_15 = var_149_15 - 0.016666666666666666
			end
		end), cc.DelayTime:create(0.016666666666666666))))
	end

	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("effect/horcrux_breakout/anim_horcrux_breakout.ExportJson")

	local var_148_3 = ccs.Armature:create("anim_horcrux_breakout")

	var_148_3:setPosition(320, GameDisplay.height / 2 - GameDisplay.fix_y)
	self.rootLayer:addChild(var_148_3, 999)
	var_148_3:getAnimation():play("anim_horcrux_breakout")
	var_148_3:getAnimation():setMovementEventCallFunc(function(arg_156_0, arg_156_1, arg_156_2)
		if arg_156_1 == ccs.MovementEventType.complete then
			var_148_2()
		end
	end)
end

function HorcruxInfoLayerNew:saveCostMaterial()
	self.selectItemid = {}

	if next(self.selectedHorcruxList) then
		for iter_157_0, iter_157_1 in pairs(self.selectedHorcruxList) do
			table.insert(self.selectItemid, playermodel.items[iter_157_1.entityid].itemid)
		end
	end

	if next(self.selectedExpList) then
		for iter_157_2, iter_157_3 in pairs(self.selectedExpList) do
			table.insert(self.selectItemid, playermodel.items[iter_157_3.entityid].itemid)
		end
	end
end

function HorcruxInfoLayerNew:startPress(arg_158_1, arg_158_2)
	local var_158_0 = 0.1

	self.timer = cc.Node:create()

	self:addChild(self.timer)

	self.timer1 = cc.Node:create()

	self:addChild(self.timer1)
	self.timer1:runAction(cc.Sequence:create(cc.DelayTime:create(var_0_26), cc.CallFunc:create(function()
		if arg_158_1() then
			self:showLongPressProgress()
			self.timer:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
				self:setLongPressProgressPercent(var_158_0 / var_0_25 * 100)

				if var_158_0 >= var_0_25 then
					self.timer:stopAllActions()

					if arg_158_2 then
						arg_158_2()
					end
				end

				var_158_0 = var_158_0 + 0.016666666666666666
			end))))
		else
			self:endPress()
		end
	end)))
end

function HorcruxInfoLayerNew:endPress()
	if self.timer then
		self.timer:stopAllActions()
		self.timer1:stopAllActions()
	end

	self:hideLongPressProgress()
end

function HorcruxInfoLayerNew:showLongPressProgress()
	if not self.progress then
		self.progressBg = ccui.Layout:create()

		self.progressBg:setTouchEnabled(true)
		self.progressBg:setContentSize(cc.size(640, GameDisplay.height))
		self.progressBg:setAnchorPoint(cc.p(0.5, 0.5))
		self.progressBg:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
		self.progressBg:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		self.progressBg:setBackGroundColor(cc.c3b(0, 0, 0))
		self.progressBg:setBackGroundColorOpacity(128)
		self.progressBg:setPosition(cc.p(320, GameDisplay.height / 2))
		self.rootLayer:addChild(self.progressBg, 10000)

		self.progress = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create("public/button/press_bar.png") or cc.Sprite:createWithSpriteFrameName("public/button/press_bar.png")))

		self.progress:setAnchorPoint(cc.p(0.5, 0.5))
		self.progress:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
		self.progress:setPositionX(self.progressBg:getContentSize().width / 2)
		self.progress:setPositionY(self.progressBg:getContentSize().height / 2)
		self.progress:setReverseDirection(false)
		self.progressBg:addChild(self.progress)
	end

	self.progressBg:setVisible(true)
	self.progress:setPercentage(50)
end

function HorcruxInfoLayerNew:setLongPressProgressPercent(arg_163_1)
	if self.progress then
		self.progress:setPercentage(arg_163_1)
	end
end

function HorcruxInfoLayerNew:hideLongPressProgress()
	if self.progress then
		self.progressBg:setVisible(false)
	end
end

function HorcruxInfoLayerNew:showUpLevelPop(arg_165_1)
	self.horcruxPopLayer = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_horcruxTableView")

	if not self.horcruxPopLayer:getChildByName("choosebg") then
		self:initBg(self.horcruxPopLayer)
	end

	self.horcruxPopLayer:getChildByName("Image_horcruxTableViewBg"):setScaleY(0)
	self.horcruxPopLayer:getChildByName("Image_horcruxTableViewBg"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 1), cc.CallFunc:create(function()
		GuideListener.cleanCurGuides()
		GuideListener.swallowEvent(false)
		GuideListener.lockGuideTrigger(false)
		GuideListener.updateGuides(self)
	end)))
	self.horcruxPopLayer:setVisible(true)
	self.horcruxPopLayer:addTouchEventListener(function(arg_167_0, arg_167_1)
		if arg_167_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.horcruxPopLayer:getChildByName("Image_horcruxTableViewBg"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 0), cc.CallFunc:create(function()
			self.horcruxPopLayer:setVisible(false)

			self.selectModel = 0
			self.selectedHorcruxList = {}
			self.selectedExpList = {}

			self:updateShowingCells()
			self:updateMainAttrPanel()
			self:updateModelUI()
			self:updateSelectedNum()
			GuideListener.cleanCurGuides()
			GuideListener.swallowEvent(false)
			GuideListener.lockGuideTrigger(false)
			GuideListener.updateGuides(self)
		end)))
	end)

	local var_165_1 = ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "ProgressBar_popExpBar")
	local var_165_2 = horcrux_manager:getHorcruxHLV(arg_165_1)

	if var_165_2 >= horcrux_manager:getHorcruxHClass(arg_165_1) + 10 then
		var_165_1:setPercent(100)
	else
		var_165_1:setPercent(math.ceil(horcrux_manager:getHorcruxExp(arg_165_1) / horcrux_strength_data[var_165_2].exp * 100))
	end

	local var_165_3 = horcrux_manager:getHorcruxAssistConfig(arg_165_1)

	ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_damage"):setString(L_HORCRUX_BREAK_LIMIT.Label_Str[2] .. math.floor(var_165_3.damage))
	ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_hp"):setString(L_HORCRUX_BREAK_LIMIT.Label_Str[3] .. math.floor(var_165_3.hp))
	ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_damageFac"):setString(L_HORCRUX_BREAK_LIMIT.Aptitude_Str[2])
	ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_hpFac"):setString(L_HORCRUX_BREAK_LIMIT.Aptitude_Str[3])

	if horcrux_manager:getHorcruxHClass(arg_165_1) > 0 then
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_damageFacNum"):setString(horcrux_manager:getHorcruxDamageFac(arg_165_1) / 100 + horcrux_manager:getHorcruxDamageFacAdditionByEntityid(self.entityid) / 100)
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_hpFacNum"):setString((math.floor(horcrux_manager:getHorcruxHpFac(arg_165_1) / 100 + horcrux_manager:getHorcruxHpFacAdditionByEntityid(self.entityid) / 100)))
	else
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_damageFacNum"):setString(horcrux_manager:getHorcruxDamageFac(arg_165_1) / 100)
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_hpFacNum"):setString((math.floor(horcrux_manager:getHorcruxHpFac(arg_165_1) / 100)))
	end

	self:updateUpLevelPopExpBar(arg_165_1)
	ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Button_horcruxBag"):addTouchEventListener(function(arg_169_0, arg_169_1)
		if arg_169_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.listDataType = 1
		self.selectModel = 0
		self.selectedHorcruxList = {}
		self.selectedExpList = {}

		self:updateShowingCells()
		self:updateMainAttrPanel()
		self:updateModelUI()
		self:updateSelectedNum()
		self:updateUpLevelPopExpBar(arg_165_1)
	end)
	ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Button_itemBag"):addTouchEventListener(function(arg_170_0, arg_170_1)
		if arg_170_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.listDataType = 2
		self.selectModel = 0
		self.selectedHorcruxList = {}
		self.selectedExpList = {}

		self:updateShowingCells()
		self:updateMainAttrPanel()
		self:updateModelUI()
		self:updateSelectedNum()
		self:updateUpLevelPopExpBar(arg_165_1)
	end)
	ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Button_autoSelect"):addTouchEventListener(self:getAutoSelectHadle())
	ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Button_sure"):addTouchEventListener(self:getPopComposeHandler(function()
		self.horcruxPopLayer:setVisible(false)
		self:showMainAttrPanelAni()
		cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("updateMainLineTaskUI"))
	end))
end

function HorcruxInfoLayerNew:updateUpLevelPopExpBar(arg_172_1)
	local var_172_0 = self:getSelectedHorcruxListExp() + horcrux_manager:getHorcruxExp(arg_172_1)
	local var_172_1
	local var_172_2 = horcrux_manager:getHorcruxHLV(arg_172_1)
	local var_172_3 = math.min(horcrux_manager:getHorcruxBreakLv(arg_172_1) * 10, horcrux_manager:get_max_level(arg_172_1))
	local var_172_4 = horcrux_manager:getHorcruxHLV(arg_172_1)

	for iter_172_0 = var_172_4, var_172_3 - 1 do
		var_172_1 = var_172_4 == var_172_3 - 1 and horcrux_strength_data[iter_172_0].exp or horcrux_strength_data[iter_172_0].exp

		if var_172_0 - var_172_1 >= 0 then
			var_172_2 = var_172_2 + 1
			var_172_0 = var_172_0 - var_172_1
		else
			var_172_1 = var_172_1 + var_172_0

			break
		end
	end

	local var_172_7 = ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Panel_level")
	local var_172_8 = ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "ProgressBar_popExpBar")

	if var_172_3 > horcrux_manager:get_max_level(self.entityid) then
		var_172_3 = horcrux_manager:get_max_level(self.entityid)
	end

	if var_172_3 < var_172_2 then
		var_172_2 = var_172_3

		var_172_8:setPercent(100)
	else
		local var_172_9 = math.ceil(var_172_0 / horcrux_strength_data[var_172_2].exp * 100)

		if var_172_9 > 100 then
			var_172_9 = 100
		end

		var_172_8:setPercent(var_172_9)
	end

	ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_expDes"):setString(math.floor(var_172_0) .. "/" .. horcrux_strength_data[var_172_2].exp)
	ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_expDes"):setVisible(var_172_4 < horcrux_manager:get_max_level(self.entityid))

	local var_172_10 = ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_lv")

	var_172_10:setString(L_EQUIPLAYER[6] .. var_172_4)

	if next(self.selectedHorcruxList) or next(self.selectedExpList) then
		local var_172_13 = horcrux_manager:getHorcruxDataWithPreset(arg_172_1, var_172_2)
		local var_172_14 = horcrux_manager:getHorcruxAssistConfig(arg_172_1)
		local var_172_15 = ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_damage")
		local var_172_16 = ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_hp")
		local var_172_17 = ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_damageCur")
		local var_172_18 = ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_hpCur")
		local var_172_19 = ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_hp_arrow")
		local var_172_20 = ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_damage_arrow")
		local var_172_21 = ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_lv_arrow")

		var_172_15:setString(L_HORCRUX_BREAK_LIMIT.Label_Str[2])
		var_172_16:setString(L_HORCRUX_BREAK_LIMIT.Label_Str[3])
		var_172_17:setString(math.floor(var_172_14.damage))
		var_172_17:setPositionX(var_172_15:getPositionX() + var_172_15:getContentSize().width)
		var_172_18:setString(math.floor(var_172_14.hp))
		var_172_18:setPositionX(var_172_16:getPositionX() + var_172_16:getContentSize().width)
		var_172_20:setAnchorPoint(cc.p(0, 0.5))
		var_172_20:setPositionX(var_172_17:getPositionX() + var_172_17:getContentSize().width + 10)
		var_172_20:setVisible(true)
		var_172_19:setAnchorPoint(cc.p(0, 0.5))
		var_172_19:setPositionX(var_172_18:getPositionX() + var_172_18:getContentSize().width + 10)
		var_172_19:setVisible(true)
		var_172_21:setAnchorPoint(cc.p(0, 0.5))
		var_172_21:setPositionX(var_172_10:getPositionX() + var_172_10:getContentSize().width + 10)
		var_172_21:setVisible(true)
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_damageAdd"):setVisible(true)
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_hpAdd"):setVisible(true)
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_damageAdd"):setString(math.floor(var_172_13.damage))
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_hpAdd"):setString(math.floor(var_172_13.hp))
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_damageAdd"):setPositionX(var_172_20:getPositionX() + var_172_20:getContentSize().width)
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_hpAdd"):setPositionX(var_172_19:getPositionX() + var_172_19:getContentSize().width)
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_damageAdd"):setVisible(true)
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_hpAdd"):setVisible(true)
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_lvAdd"):setString(var_172_2)
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_lvAdd"):setPositionX(var_172_21:getPositionX() + var_172_21:getContentSize().width)
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_lvAdd"):setVisible(true)
	else
		local var_172_22 = horcrux_manager:getHorcruxAssistConfig(arg_172_1)
		local var_172_23 = ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_damage")
		local var_172_24 = ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_hp")

		var_172_23:setString(L_HORCRUX_BREAK_LIMIT.Label_Str[2])
		var_172_24:setString(L_HORCRUX_BREAK_LIMIT.Label_Str[3])
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_damageCur"):setString(math.floor(var_172_22.damage))
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_damageCur"):setPositionX(var_172_23:getPositionX() + var_172_23:getContentSize().width)
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_hpCur"):setString(math.floor(var_172_22.hp))
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_hpCur"):setPositionX(var_172_24:getPositionX() + var_172_24:getContentSize().width)
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_damageAdd"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_hpAdd"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_damageAdd"):setString("")
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_hpAdd"):setString("")
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_lvAdd"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_hp_arrow"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_damage_arrow"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Label_lv_arrow"):setVisible(false)
	end

	if var_172_4 >= 100 then
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Button_sure"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Button_autoSelect"):setVisible(false)
	end

	for iter_172_1, iter_172_2 in pairs(ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Button_sure"):getChildren()) do
		print(iter_172_2:getName())
	end

	ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Button_sure"):setPositionX(400)
	ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Button_sure"):loadTextures("public/button/public_button_orange.png", "public/button/public_button_orange.png", "public/button/public_button_orange.png", var_0_0)
	ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Button_autoSelect"):setVisible(true)

	local var_172_25 = ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Button_sure"):getChildByName("Button_sure_label")

	var_172_25:setString(L_BUTTON_TEXT.Horcrux_Btn.Level_Up)
	var_172_25:setPositionX(ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Button_sure"):getContentSize().width / 2)
	var_172_25:setPositionY(ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Button_sure"):getContentSize().height / 2)

	if self.selectModel == 1 then
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Button_autoSelect"):loadTextures("HorcruxInfo/cancel_auto_select.png", nil, nil, var_0_0)
	else
		ccui.Helper:seekWidgetByName(self.horcruxPopLayer, "Button_autoSelect"):loadTextures("HorcruxInfo/auto_select.png", nil, nil, var_0_0)
	end
end

function HorcruxInfoLayerNew.getAutoSelectHadle(arg_173_0)
	return function(arg_174_0, arg_174_1)
		if arg_174_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_173_0.selectModel == 0 then
			if arg_173_0.listDataType == 1 then
				if not next(arg_173_0.horcruxList) then
					LayerManager:pushInLayer("PopDoLayer", {
						labels = {
							title = L_HORCRUX_NFO_GO.title,
							des = L_HORCRUX_NFO_GO.des,
							button = L_HORCRUX_NFO_GO.button
						},
						surecallback = function()
							LayerManager:switchShowLayer("TwisteggLayer")
						end
					})
					audio_manager:playeffectMusicTest("sound/invalid")

					return
				end

				if arg_173_0.curLevel >= horcrux_manager:getHorcruxBreakLv(arg_173_0.entityid) * 10 then
					global_ShowBlockWords(L_HORCRUX_TOUCH_MSG.Level[1])
					audio_manager:playeffectMusicTest("sound/invalid")

					return
				end

				if arg_173_0.curLevel >= horcrux_manager:get_max_level(arg_173_0.entityid) then
					global_ShowBlockWords(L_HORCRUX_TOUCH_MSG.Level[3])
					audio_manager:playeffectMusicTest("sound/invalid")

					return
				end

				arg_173_0.selectedHorcruxList = arg_173_0:autoSelectNew()

				if not next(arg_173_0.selectedHorcruxList) then
					global_ShowBlockWords(L_HORCRUX_LV_UP_AUTO_SELECT[3])
					audio_manager:playeffectMusicTest("sound/invalid")

					return
				end

				arg_173_0:updateMainAttrPanel()
				arg_173_0:updateShowingCells()

				arg_173_0.selectModel = 1 - arg_173_0.selectModel

				arg_173_0:updateUpLevelPopExpBar(arg_173_0.entityid)
				arg_173_0:updateSelectedNum()
			else
				if not next(arg_173_0.horcruxExpItemList) then
					global_ShowBlockWords(L_HORCRUX_LV_UP_AUTO_SELECT[3])
					audio_manager:playeffectMusicTest("sound/invalid")

					return
				end

				if arg_173_0.curLevel >= horcrux_manager:getHorcruxBreakLv(arg_173_0.entityid) * 10 then
					global_ShowBlockWords(L_HORCRUX_TOUCH_MSG.Level[1])
					audio_manager:playeffectMusicTest("sound/invalid")

					return
				end

				if arg_173_0.curLevel >= horcrux_manager:get_max_level(arg_173_0.entityid) then
					global_ShowBlockWords(L_HORCRUX_TOUCH_MSG.Level[3])
					audio_manager:playeffectMusicTest("sound/invalid")

					return
				end

				arg_173_0.selectedExpList = arg_173_0:autoSelectNew()

				arg_173_0:updateMainAttrPanel()
				arg_173_0:updateShowingCells()

				arg_173_0.selectModel = 1 - arg_173_0.selectModel

				arg_173_0:updateUpLevelPopExpBar(arg_173_0.entityid)
				arg_173_0:updateSelectedNum()
			end
		else
			arg_173_0.selectModel = 1 - arg_173_0.selectModel
			arg_173_0.selectedHorcruxList = {}
			arg_173_0.selectedExpList = {}

			arg_173_0:updateMainAttrPanel()
			arg_173_0:updateShowingCells()
			arg_173_0:updateUpLevelPopExpBar(arg_173_0.entityid)
			arg_173_0:updateSelectedNum()
		end
	end
end

function HorcruxInfoLayerNew.getComposeHandler(arg_176_0)
	return function(arg_177_0, arg_177_1)
		if arg_177_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_177_0:isBright() then
			return
		end

		if not arg_176_0.horcruxMaxLevel then
			if arg_176_0.listDataType == 1 then
				if not next(arg_176_0.selectedHorcruxList) then
					global_ShowBlockWords(L_HORCRUX_LV_UP_SELECT_NIL[1])
					audio_manager:playeffectMusicTest("sound/invalid")

					return
				end
			elseif not next(arg_176_0.selectedExpList) then
				global_ShowBlockWords(L_HORCRUX_LV_UP_SELECT_NIL[2])
				audio_manager:playeffectMusicTest("sound/invalid")

				return
			end
		end

		local function var_177_0()
			arg_177_0:setBright(true)
		end

		if arg_176_0.horcruxMaxLevel then
			arg_176_0:showHorcruxBreakLimit()
		else
			arg_177_0:setBright(false)
			arg_176_0:horcruxUpLevel(var_177_0)
		end
	end
end

function HorcruxInfoLayerNew.getMaxHorcruxBreak(arg_179_0, arg_179_1)
	local var_179_0 = 0

	while horcrux_break_data[var_179_0 + 1] and var_0_16[horcrux_manager:getHorcruxItemid(arg_179_1)]["break" .. var_179_0 + 1 .. "_item1"] do
		var_179_0 = var_179_0 + 1
	end

	return var_179_0 + 1
end

function HorcruxInfoLayerNew.getPopComposeHandler(arg_180_0, arg_180_1)
	return function(arg_181_0, arg_181_1)
		if arg_181_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_180_0.horcruxMaxLevel then
			if arg_180_0.listDataType == 1 then
				if not next(arg_180_0.selectedHorcruxList) then
					global_ShowBlockWords(L_HORCRUX_LV_UP_SELECT_NIL[1])
					audio_manager:playeffectMusicTest("sound/invalid")

					return
				end
			elseif not next(arg_180_0.selectedExpList) then
				global_ShowBlockWords(L_HORCRUX_LV_UP_SELECT_NIL[2])
				audio_manager:playeffectMusicTest("sound/invalid")

				return
			end
		end

		local function var_181_0()
			if arg_180_1 then
				arg_180_1()
			end
		end

		if arg_180_0.horcruxMaxLevel then
			global_ShowBlockWords(L_HORCRUX_LV_UP_SELECT_NIL[3])
			audio_manager:playeffectMusicTest("sound/invalid")
		else
			arg_180_0:horcruxUpLevel(var_181_0)
		end
	end
end

function HorcruxInfoLayerNew:getShowStat()
	if self:isShowUpgradeBtn() then
		return 2
	end

	if ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_horcruxTableView"):isVisible() then
		return 1
	end

	return 0
end

function HorcruxInfoLayerNew.getReturnhandler(arg_184_0)
	return function(arg_185_0, arg_185_1)
		if arg_185_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(arg_184_0.__queueindex)

		if HorcruxLayer and HorcruxLayer.getInstance() then
			HorcruxLayer.getInstance():deleteBagData(arg_184_0.addHorcruxEntityList)
			HorcruxLayer.getInstance():updateDecomposeAfterShowingCells()
		end

		local var_185_0 = cc.EventCustom:new("on_return_horcrux_layer")

		var_185_0.addHorcruxEntityList = arg_184_0.addHorcruxEntityList

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_185_0)

		if BattleArrayLayerNew and BattleArrayLayerNew.getInstance() and (not HorcruxSelectLayer or not HorcruxSelectLayer.getInstance()) then
			BattleArrayLayerNew.getInstance():updateAllCell()
			BattleArrayLayerNew.getInstance():showFightPowerChange(arg_184_0.entityid)
		end

		require("controller.formation.formation_manager"):getInstance():updateLayer()
		cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("substitutionArrayLayerEvent")))
	end
end

function HorcruxInfoLayerNew.getDecomposeHandle(arg_186_0)
	return function(arg_187_0, arg_187_1)
		if arg_187_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_187_0:isBright() then
			return
		end

		arg_187_0:setBright(false)
		horcrux_manager:decomposeHorcruxBatch({
			arg_186_0.entityid
		}, function(arg_188_0)
			if arg_188_0 == 1 then
				local var_188_0 = arg_186_0.mainAttrPanel:getChildByName("changeTimer")

				if var_188_0 then
					var_188_0:stopAllActions()
				end

				table.insert(arg_186_0.addHorcruxEntityList, arg_186_0.entityid)
				arg_186_0:getReturnhandler()(nil, ccui.TouchEventType.ended)
			elseif arg_188_0 == 2 then
				global_ShowBlockWords(L_HORCRUX_DECOMPOSE.Warning[2])
			elseif arg_188_0 == 3 then
				global_ShowBlockWords(L_HORCRUX_DECOMPOSE.Warning[3])
			end
		end)
	end
end

function HorcruxInfoLayerNew:getHorcruxNextBreakLimitExp(arg_189_1)
	return horcrux_strength_data[horcrux_manager:getHorcruxBreakLv(self.entityid) * 10].totalexp - horcrux_strength_data[horcrux_manager:getHorcruxHLV(arg_189_1)].totalexp - horcrux_manager:getHorcruxExp(arg_189_1)
end

function HorcruxInfoLayerNew:perviewCompose()
	local var_190_0 = horcrux_manager:getHorcruxDecomposeReturnMaterial(self.entityid)
	local var_190_1 = ccui.Layout:create()

	var_190_1:setTouchEnabled(true)
	var_190_1:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_190_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_190_1:setPosition(cc.p(GameDisplay.width / 2, GameDisplay.height / 2 - GameDisplay.fix_y))
	var_190_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_190_1:setBackGroundColor(cc.c3b(0, 0, 0))
	var_190_1:setBackGroundColorOpacity(180)
	self:addChild(var_190_1, 100)

	local var_190_2 = ccui.ImageView:create("public/panelbg/bg_pupup_level3.png", var_0_0)

	var_190_2:setPositionX(var_190_1:getContentSize().width / 2)
	var_190_2:setPositionY(var_190_1:getContentSize().height / 2)
	var_190_2:setScaleY(0)
	var_190_2:runAction(cc.ScaleTo:create(0.2, 1, 1))
	var_190_1:addChild(var_190_2)
	var_190_1:addTouchEventListener(function(arg_191_0, arg_191_1)
		if arg_191_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_190_2:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
			var_190_1:runAction(cc.RemoveSelf:create())
		end)))
	end)

	local var_190_3 = {
		cc.c3b(123, 255, 132),
		cc.c3b(39, 255, 252),
		cc.c3b(255, 150, 86),
		cc.c3b(255, 55, 55),
		(cc.c3b(255, 55, 55))
	}
	local var_190_4 = cc.Label:createWithTTF(L_HORCRUX_DECOMPOSE.Get_Material[1], FONT_NAME, 24)

	var_190_4:setColor(cc.c3b(216, 230, 246))
	var_190_4:setAnchorPoint(cc.p(0, 0.5))
	var_190_4:setPositionY(var_190_2:getContentSize().height - var_190_4:getContentSize().height)
	var_190_2:addChild(var_190_4)

	local var_190_5 = cc.Label:createWithTTF(({
		L_TWIST_LEVEL[4],
		[2] = "优秀",
		[3] = L_TWIST_LEVEL[3],
		[4] = L_TWIST_LEVEL[2],
		[5] = L_TWIST_LEVEL[1]
	})[var_0_16[playermodel.items[self.entityid].itemid].rarity], FONT_NAME, 24)

	var_190_5:setColor(var_190_3[var_0_16[playermodel.items[self.entityid].itemid].rarity] or var_190_3[4])
	var_190_5:setAnchorPoint(cc.p(0, 0.5))
	var_190_5:setPositionY(var_190_2:getContentSize().height - var_190_5:getContentSize().height)
	var_190_2:addChild(var_190_5)

	local var_190_6 = cc.Label:createWithTTF(L_HORCRUX_DECOMPOSE.Get_Material[2], FONT_NAME, 24)

	var_190_6:setColor(cc.c3b(216, 230, 246))
	var_190_6:setAnchorPoint(cc.p(0, 0.5))
	var_190_6:setPositionY(var_190_2:getContentSize().height - var_190_6:getContentSize().height)
	var_190_2:addChild(var_190_6)

	local var_190_7 = 320 - (var_190_6:getContentSize().width + (var_190_5:getContentSize().width + (var_190_4:getContentSize().width + 0))) / 2

	var_190_4:setPositionX(var_190_7)

	local var_190_8 = var_190_7 + var_190_4:getContentSize().width

	var_190_5:setPositionX(var_190_8)
	var_190_6:setPositionX(var_190_8 + var_190_5:getContentSize().width)

	local var_190_9 = ccui.ListView:create()

	var_190_9:setContentSize(cc.size(640, 120))
	var_190_9:setPosition(cc.p(0, 20))
	var_190_9:setDirection(ccui.ListViewDirection.horizontal)
	var_190_2:addChild(var_190_9)

	for iter_190_0, iter_190_1 in pairs(var_190_0) do
		local var_190_10 = ItemSmallSprite:createSmallItem(iter_190_1.itemid, iter_190_1.num, nil, self.goto_back_system_id)

		var_190_10:setScale(0.7)
		var_190_10:setPositionX(var_190_2:getContentSize().width / 2 - (iter_190_0 - (#var_190_0 + 1) / 2) * (var_190_10:getContentSize().width + 5))
		var_190_10:setPositionY(var_190_2:getContentSize().height / 2)
		var_190_10:setInfoTouchEvent(true)
		var_190_9:pushBackCustomItem(var_190_10)
	end

	local var_190_11 = ccui.Button:create("public/button/public_button_blue.png", nil, "public/button/public_button_blue.png", var_0_0)

	var_190_11:setPositionX(var_190_2:getContentSize().width / 2)
	var_190_11:setPositionY(-var_190_11:getContentSize().height / 2)
	var_190_2:addChild(var_190_11)

	local var_190_12 = cc.Label:createWithTTF(L_BUTTON_TEXT.Comfirm, FONT_BUTTON, 32)

	var_190_12:setPositionX(var_190_11:getContentSize().width / 2)
	var_190_12:setPositionY(var_190_11:getContentSize().height / 2)
	var_190_12:setColor(cc.c3b(24, 24, 24))
	var_190_11:addChild(var_190_12)
	var_190_11:addTouchEventListener(self:getDecomposeHandle())
end

function HorcruxInfoLayerNew:isShowUpgradeBtn()
	return self.showType ~= "twist_preview"
end

function HorcruxInfoLayerNew:isShowDevourBtn()
	return self.isDevour
end

function HorcruxInfoLayerNew:isShowDecomposeBtn()
	if self.showType == "horcruxlayer" then
		if item_data[playermodel.items[self.entityid].itemid].break_lock then
			return false
		end

		return true
	else
		return false
	end
end

function HorcruxInfoLayerNew:initDisplayValue(arg_196_1)
	self.displayPos = global_get_node_display_posy(arg_196_1, {
		Panel_horcruxOrder2 = {
			posY = 75,
			focusName = "Panel_horcruxOrder2",
			reference = TRANSFORM_REFERENCE.UP,
			unit = TRANSFORM_UNIT.PX
		},
		Image_downBg = {
			posY = 53,
			focusName = "Image_downBg",
			reference = TRANSFORM_REFERENCE.DOWN,
			unit = TRANSFORM_UNIT.PX
		},
		bottomBtn = {
			posY = 0,
			focusName = "bottomBtn",
			reference = TRANSFORM_REFERENCE.DOWN,
			unit = TRANSFORM_UNIT.PX
		}
	})

	for iter_196_0, iter_196_1 in pairs(self.displayPos) do
		local var_196_0 = ccui.Helper:seekWidgetByName(arg_196_1, iter_196_0)

		if var_196_0 then
			var_196_0:setPositionY(iter_196_1)
		end
	end

	local var_196_1 = ccui.Helper:seekWidgetByName(arg_196_1, "Image_downBg"):getContentSize()

	ccui.Helper:seekWidgetByName(arg_196_1, "Image_downBg"):setContentSize(cc.size(var_196_1.width, var_196_1.height + GameDisplay.fix_y * 2 - GameDisplay.notch_height))

	local var_196_2 = ccui.Helper:seekWidgetByName(arg_196_1, "Panel_horcruxTableView"):getContentSize()

	ccui.Helper:seekWidgetByName(arg_196_1, "Panel_horcruxTableView"):setContentSize(cc.size(var_196_2.width, var_196_2.height + GameDisplay.fix_y * 2))
	ccui.Helper:seekWidgetByName(arg_196_1, "Panel_horcruxTableView"):setAnchorPoint(cc.p(0, 0))
	ccui.Helper:seekWidgetByName(arg_196_1, "Panel_horcruxTableView"):setPositionY(-GameDisplay.fix_y)
	ccui.Helper:seekWidgetByName(arg_196_1, "Image_horcruxTableViewBg"):setPositionY(GameDisplay.height / 2)
end

function HorcruxInfoLayerNew:sortHorcruxList(...)
	local var_197_0 = {
		[3050031] = 1,
		[3050014] = 2,
		[3050021] = 1,
		[3050051] = 1,
		[3050011] = 1,
		[3050012] = 3,
		[3050041] = 1,
		[3050013] = 4
	}
	local var_197_1 = {}

	while self.horcruxList[1] do
		local var_197_2

		if var_197_0[playermodel.items[self.horcruxList[1]].itemid] then
			table.insert(var_197_1, table.remove(self.horcruxList, 1))
		else
			var_197_2 = 1 + 1
		end
	end

	table.sort(var_197_1, function(arg_198_0, arg_198_1)
		return (var_197_0[playermodel.items[arg_198_0].itemid] or 4) < (var_197_0[playermodel.items[arg_198_1].itemid] or 4)
	end)

	for iter_197_0, iter_197_1 in pairs(var_197_1) do
		table.insert(self.horcruxList, 1, iter_197_1)
	end
end

function HorcruxInfoLayerNew.initBg(arg_199_0, arg_199_1)
	local var_199_0 = ccui.Layout:create()

	var_199_0:setTouchEnabled(true)
	var_199_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_199_0:setAnchorPoint(cc.p(0, 0))
	var_199_0:setPosition(cc.p(0, 0))
	var_199_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_199_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_199_0:setOpacity(0)
	var_199_0:setName("choosebg")
	arg_199_1:addChild(var_199_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_200_0)
		arg_199_1:addChild(arg_200_0, -2)
		arg_200_0:setPositionY(arg_200_0:getPositionY())

		local var_200_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_200_0:setAnchorPoint(cc.p(0, 0))
		var_200_0:setPositionY(0)
		arg_199_1:addChild(var_200_0, -1)
		var_199_0:setOpacity(180)
		var_199_0:setTouchEnabled(false)
	end)
end

function HorcruxInfoLayerNew:exit()
	LayerManager:removePopLayer(self.__queueindex)

	if HorcruxLayer and HorcruxLayer.getInstance() then
		HorcruxLayer.getInstance():deleteBagData(self.addHorcruxEntityList)
		HorcruxLayer.getInstance():updateDecomposeAfterShowingCells()
	end

	local var_201_0 = cc.EventCustom:new("on_return_horcrux_layer")

	var_201_0.addHorcruxEntityList = self.addHorcruxEntityList

	cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_201_0)

	if BattleArrayLayerNew and BattleArrayLayerNew.getInstance() then
		BattleArrayLayerNew.getInstance():updateAllCell()
		BattleArrayLayerNew.getInstance():updateUI()
	end

	require("controller.formation.formation_manager"):getInstance():updateLayer()
end
