local QuickFormationLayer = class("QuickFormationLayer", (require("view.Layer.BaseUILayer")))
local TempWidget = require("view.Sprite.TempWidget")
local TableViewEx = require("view/Sprite/TableViewEx")
local var_0_3 = config._DEBUG and 0 or 1
local var_0_4 = "QuickFormationLayer/"

require("view.Sprite.FilterListSprite")

local FilterItemsPanelParts = require("view.Sprite.FilterItemsPanelParts")
local role_false_level_manager = require("controller.role_false_level_manager")
local level_manager = require("controller.level_manager")
local component_manager = require("controller.component_manager")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local servant_data = require("data.servant_data")
local component_effect_data = require("data.component_effect_data")
local activity_manager = require("controller.activity_manager")
local horcrux_manager = require("controller.horcrux_manager")
local weapon_manager = require("controller.weapon_manager")
local var_0_16 = string.format
local var_0_17 = 0.7
local var_0_18 = 3
local var_0_19 = {
	{
		TableViewCellHeight = 230,
		TableViewCol = 4,
		spriteScale = 1
	},
	{
		TableViewCellHeight = 190,
		TableViewCol = 5,
		spriteScale = 0.8
	},
	{
		TableViewCellHeight = 160,
		TableViewCol = 6,
		spriteScale = 0.7
	}
}

function QuickFormationLayer:ctor()
	QuickFormationLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller/quick_formation_manager"):getInstance()
	self._isShowAttrs = false
	self._selectShowType = 1
	self._showTableView = {}
	self._switchShowTypeBtnTable = {}
end

function QuickFormationLayer:create(arg_2_1)
	local var_2_0 = QuickFormationLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function QuickFormationLayer:onEnter()
	QuickFormationLayer.super.onEnter(self)

	if CONFIG_TYPE_TEST_FIGHT_EMPTY == self._data.layerType or CONFIG_TYPE_TEST_FIGHT_PLAYER == self._data.layerType then
		activity_manager:registerEventListener("QuickFormationLayer" .. self._data.layerType, activity_manager.activityEventId.CHANGE_TEST_E_FIGHT_ARRAY_SUCCESS, function(arg_4_0)
			require("controller/quick_formation_manager"):getInstance():testFightChangeRoleSuccess()
		end)
		activity_manager:registerEventListener("QuickFormationLayer" .. self._data.layerType, activity_manager.activityEventId.CHANGE_TEST_P_FIGHT_ARRAY_SUCCESS, function(arg_5_0)
			require("controller/quick_formation_manager"):getInstance():testFightChangeRoleSuccess()
		end)
	end

	self.manager:initFilterData()
end

function QuickFormationLayer:onExit()
	QuickFormationLayer.super.onExit(self)

	if CONFIG_TYPE_TEST_FIGHT_EMPTY == self._data.layerType or CONFIG_TYPE_TEST_FIGHT_PLAYER == self._data.layerType then
		activity_manager:releaseEventListenerByName("QuickFormationLayer" .. self._data.layerType)
	end
end

function QuickFormationLayer:init(arg_7_1)
	self:initData(arg_7_1)
	self:initLayer()
	self:initListener()

	return true
end

function QuickFormationLayer:initData(arg_8_1)
	arg_8_1 = arg_8_1 or {}
	self._data = arg_8_1

	self.manager:initData(arg_8_1)
end

function QuickFormationLayer:initLayer()
	local var_9_0 = TempWidget:CreateTempLayout(self)

	var_9_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_9_0

	TempWidget:CreateTempImg(var_0_4 .. "bg.png", var_9_0):center()

	local var_9_1 = TempWidget:CreateTempImg(var_0_4 .. "top.png", var_9_0)

	var_9_1:align(cc.p(0, 1), 0, var_9_0:size().h)

	self._top = var_9_1

	local var_9_2 = TempWidget:CreateTempBtn(var_0_4 .. "explain_btn.png", var_9_1)

	var_9_2:align(cc.p(0, 0.5), 150, var_9_1:size().h / 2)

	self._explainBtn = var_9_2

	local var_9_3 = TempWidget:CreateTempBtn(var_0_4 .. "btn_top_bg.png", var_9_1)

	var_9_3:align(cc.p(1, 0.5), var_9_1:size().w - 20, var_9_1:size().h / 2)

	self._filterBtnTopBg = var_9_3

	TempWidget:CreateTempImg(var_0_4 .. "filter_btn.png", var_9_3):align(cc.p(0, 0.5), 10, var_9_3:size().h / 2)
	TempWidget:CreateTempLabel(L_QUICKFORMATIONLAYER[10], FONT_NAME, 18, var_9_3):align(cc.p(0, 0.5), var_9_3:size().w / 2, var_9_3:size().h / 2)

	local var_9_4 = TempWidget:CreateTempBtn(var_0_4 .. "btn_top_bg.png", var_9_1)

	var_9_4:align(cc.p(1, 0.5), var_9_3:pos().x - var_9_3:size().w - 10, var_9_1:size().h / 2)

	self._attributeBtnTopBg = var_9_4

	TempWidget:CreateTempImg(var_0_4 .. "attribute_btn.png", var_9_4):align(cc.p(0, 0.5), 10, var_9_4:size().h / 2)
	TempWidget:CreateTempLabel(L_QUICKFORMATIONLAYER[9], FONT_NAME, 18, var_9_4):align(cc.p(0, 0.5), var_9_4:size().w / 2, var_9_4:size().h / 2)

	local var_9_5 = TempWidget:CreateTempImg(var_0_4 .. "buttom.png", var_9_0)

	var_9_5:align(cc.p(0, 0), 0, 0)
	var_9_5:_addEvent(function()
		return
	end)

	self._buttom = var_9_5

	local var_9_6 = TempWidget:CreateTempLayout(var_9_5)

	var_9_6:setContentSize(cc.size(60, var_9_5:size().h))
	var_9_6:align(cc.p(0, 0), 0, 0)
	var_9_6:setName("backBtn")

	self._backBtn = var_9_6

	local var_9_7 = TempWidget:CreateTempBtn("public/button/public_button_normal_y.png", var_9_5)

	var_9_7:hide()
	var_9_7:align(cc.p(1, 0.5), var_9_5:size().w - 10, var_9_5:size().h / 2)
	var_9_7:setScale(0.9)

	self._okBtn = var_9_7

	local var_9_8 = TempWidget:CreateTempLabel(L_QUICKFORMATIONLAYER[11], FONT_NAME, 26, var_9_7)

	var_9_8:_setColor("0f0f0f")
	var_9_8:center()
	self:initFilterListSprite()

	local var_9_9 = TempWidget:CreateTempBtn(var_0_4 .. "switch_show_type_btn.png", var_9_0)

	var_9_9:align(cc.p(0, 0), 20, self._filterList:getPositionY() + self._filterList:getContentSize().height + 20)

	self._switchShowTypeBtn = var_9_9

	local var_9_10 = TempWidget:CreateTempImg(var_0_4 .. "show_type_1.png", var_9_9)

	var_9_10:setVisible(self.manager:getShowType() == self.manager.SHOW_TYPE.NUM_FOUR)
	var_9_10:center()

	self._switchShowTypeBtnTable[self.manager.SHOW_TYPE.NUM_FOUR] = var_9_10

	local var_9_11 = TempWidget:CreateTempImg(var_0_4 .. "show_type_2.png", var_9_9)

	var_9_11:setVisible(self.manager:getShowType() == self.manager.SHOW_TYPE.NORMAL)
	var_9_11:center()

	self._switchShowTypeBtnTable[self.manager.SHOW_TYPE.NORMAL] = var_9_11

	local var_9_12 = TempWidget:CreateTempImg(var_0_4 .. "show_type_3.png", var_9_9)

	var_9_12:setVisible(self.manager:getShowType() ~= self.manager.SHOW_TYPE.MORE)
	var_9_12:center()

	self._switchShowTypeBtnTable[self.manager.SHOW_TYPE.MORE] = var_9_12

	self:initFormationIndexList()
	self:initFormationLayout()
end

function QuickFormationLayer:initAllTableView()
	self:initTableView(self.manager.SHOW_TYPE.NUM_FOUR)
	self:updateTableViewVisible()
	performWithDelay(self, function()
		self:initTableView(self.manager.SHOW_TYPE.NORMAL)
		self:updateTableViewVisible()
		performWithDelay(self, function()
			self:initTableView(self.manager.SHOW_TYPE.MORE)
			self:updateTableViewVisible()
			self._switchShowTypeBtn._update()
		end, 0.05)
	end, 0.05)
end

function QuickFormationLayer:initFilterSprite()
	local var_14_0, var_14_1 = self.manager:getFilterParam()
	local var_14_2

	if not self._filterSpritePop then
		var_14_2 = FilterItemsPanelParts:create(var_14_0)
		self._filterSpritePop = var_14_2

		var_14_2:setLocalZOrder(99)
		self._root:addChild(var_14_2)

		for iter_14_0, iter_14_1 in pairs(var_14_1.cols) do
			var_14_2:setFilterBtnState(iter_14_1, var_14_1.statTbl[iter_14_0])
		end

		var_14_2:setSortTypestate(1, var_14_1.sortTypeCol)
		var_14_2:updateAllFilterBtn()
	else
		var_14_2 = self._filterSpritePop
	end

	local var_14_3 = {}

	if not self.manager.filterListData.filterValue then
		if self._filterList:getTouchFlag() then
			for iter_14_2, iter_14_3 in pairs(self.manager.filterListData.btnState) do
				var_14_3[iter_14_2] = 0
			end

			self._filterList:setTouchFlag(false)
		end
	else
		for iter_14_4, iter_14_5 in pairs(self.manager.filterListData.btnState) do
			var_14_3[iter_14_4] = iter_14_5 == 1 and -2 or -1
		end
	end

	local var_14_4 = self.manager.sortOrder == 0 and 1 or 0
	local var_14_5 = {
		{
			0
		},
		{
			0
		}
	}

	var_14_5 = self.manager.curSortOrders == 1 and {
		0,
		1
	} or {
		1,
		0
	}

	var_14_2:setFilterBtnState(self.manager.filterListData.col, var_14_3)
	var_14_2:setSortOrderState(var_14_4, var_14_5)
	var_14_2:updateAllFilterBtn()
	var_14_2:playPopAni()
end

function QuickFormationLayer:initFilterListSprite()
	self._filterList = FilterListSprite:create(self.manager:getFilterListSpriteCallBack())

	self._filterList:setAnchorPoint(cc.p(0, 0))
	self._filterList:setPositionX(0)
	self._filterList:setPositionY(self._buttom:pos().y + self._buttom:size().h - 3)
	self._root:addChild(self._filterList)
end

function QuickFormationLayer:initListener()
	self._root:_addEvent(function()
		return
	end)
	self._backBtn:_addEvent(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
	self._explainBtn:_addEvent(function()
		LayerManager:pushInLayer("TipsLayer", {
			tips = {
				"mainScenebg/guide/16.jpg",
				"mainScenebg/guide/23.jpg",
				"mainScenebg/guide/24.jpg",
				"mainScenebg/guide/25.jpg",
				"mainScenebg/guide/26.jpg",
				"mainScenebg/guide/27.jpg",
				"mainScenebg/guide/28.jpg",
				"mainScenebg/guide/29.jpg"
			}
		})
	end)
	self._talentBg:_addEvent(function()
		if self.manager:isRegisterTeamSkill() then
			local var_20_0 = {}

			var_20_0.key = "teamSkill"
			var_20_0.teamSkill = self.manager:getTeamSkill()

			LayerManager:pushInLayer("PopActivityDetail", var_20_0)
		end
	end)
	self._switchShowTypeBtn:_addEvent(function()
		if table.nums(self._showTableView) >= 3 then
			self.manager:switchShowType()
			self._switchShowTypeBtn._update()
			self:reloadData()
			self:updateTableViewVisible()
		end
	end)

	function self._switchShowTypeBtn._update()
		local var_22_0 = self.manager:getShowType()

		for iter_22_0, iter_22_1 in pairs(self._switchShowTypeBtnTable) do
			iter_22_1:setVisible(var_22_0 == iter_22_0)
		end
	end

	self._filterBtnTopBg:_addEvent(function()
		self:initFilterSprite()
	end)
	self._attributeBtnTopBg:_addEvent(function()
		self._isShowAttrs = not self._isShowAttrs

		self:updateShowingCells()
	end)
	self._okBtn:_addEvent(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
	self.manager:registerNotification("ReplaceRoleWeaponSucceeded", handler(self, self.replaceRoleWeaponSucceeded))
	self.manager:registerNotification("StrengthenWeaponSucceeded", handler(self, self.strengthenWeaponSucceeded))
	self.manager:registerNotification("UpgradeWeaponSucceeded", handler(self, self.upgradeWeaponSucceeded))
end

function QuickFormationLayer:replaceRoleWeaponSucceeded(arg_26_1)
	local var_26_0 = self._roleList:getChildren()

	for iter_26_0 = 1, #var_26_0 do
		var_26_0[iter_26_0]._update()
	end
end

function QuickFormationLayer:strengthenWeaponSucceeded(arg_27_1)
	local var_27_0 = self._roleList:getChildren()

	for iter_27_0 = 1, #var_27_0 do
		var_27_0[iter_27_0]._update()
	end
end

function QuickFormationLayer:upgradeWeaponSucceeded(arg_28_1)
	local var_28_0 = self._roleList:getChildren()

	for iter_28_0 = 1, #var_28_0 do
		var_28_0[iter_28_0]._update()
	end
end

function QuickFormationLayer:initFormationIndexList()
	local var_29_0 = TempWidget:CreateTempListView(self._root)

	var_29_0:setLocalZOrder(10)
	var_29_0:setDirection(ccui.ListViewDirection.horizontal)
	var_29_0:setContentSize(cc.size(self._root:size().w, 50))
	var_29_0:align(cc.p(0, 1), 0, self._top:pos().y - self._top:size().h)

	self._formationIndexList = var_29_0

	self:initFormationIndexListWidget()
	performWithDelay(var_29_0, function()
		var_29_0:jumpToIndex(self.manager:getFormationIndex())
	end, 0.016666666666666666)
end

function QuickFormationLayer:initFormationIndexListWidget()
	local var_31_0 = cc.size(120, self._formationIndexList:size().h)

	for iter_31_0 = 1, self.manager:getFormationNum() do
		local var_31_1 = TempWidget:CreateTempLayout()

		var_31_1:setContentSize(var_31_0)
		var_31_1:_addEvent(function()
			if self.manager:getFormationIndex() ~= iter_31_0 then
				self.manager:setFormationIndex(iter_31_0)
				self:updateFormationSelectIndex()
			end
		end)

		local var_31_2 = TempWidget:CreateTempImg(var_0_4 .. "formation_select_btn_bg_on.png", var_31_1)

		var_31_2:center()
		var_31_2:setVisible(iter_31_0 == self.manager:getFormationIndex())

		var_31_1._onBg = var_31_2

		local var_31_3 = TempWidget:CreateTempImg(var_0_4 .. "formation_select_btn_bg_off.png", var_31_1)

		var_31_3:center()
		var_31_3:setVisible(iter_31_0 ~= self.manager:getFormationIndex())

		var_31_1._offBg = var_31_3

		local var_31_4 = TempWidget:CreateTempLabel(var_0_16(L_QUICKFORMATIONLAYER[1], iter_31_0), FONT_NAME, 22, var_31_1)

		var_31_4:_setColor(iter_31_0 == self.manager:getFormationIndex() and "ffffff" or "9992c4")
		var_31_4:center()

		var_31_1._text = var_31_4

		self._formationIndexList:pushBackCustomItem(var_31_1)
	end

	if self.manager:canExtendFormation() then
		local var_31_5 = TempWidget:CreateTempLayout()

		var_31_5:setContentSize((cc.size(150, var_31_0.height)))

		var_31_5._isExtend = true

		var_31_5:_addEvent(function()
			self.manager:requestExtend(function()
				require("controller/quick_formation_manager"):getInstance():extendSuccess()
			end)
		end)
		TempWidget:CreateTempImg(var_0_4 .. "formation_extend_btn.png", var_31_5):center()

		local var_31_6 = TempWidget:CreateTempLabel(L_QUICKFORMATIONLAYER[2], FONT_DES, 20, var_31_5)

		var_31_6:_setColor("102F10")
		var_31_6:center()
		self._formationIndexList:pushBackCustomItem(var_31_5)
	end
end

function QuickFormationLayer:initFormationLayout()
	local var_35_0 = TempWidget:CreateTempLayout(self._root)

	var_35_0:setContentSize(cc.size(self._root:size().w, 380))
	var_35_0:align(cc.p(0, 1), 0, self._formationIndexList:pos().y - self._formationIndexList:size().h)

	self._formationLayout = var_35_0

	self._formationLayout:setLocalZOrder(99)
	self:initFormationLayoutTop()
	self:initFormationLayoutRole()
end

function QuickFormationLayer:initFormationLayoutRole()
	local var_36_0 = TempWidget:CreateTempListView(self._formationLayout)

	var_36_0:setContentSize(cc.size(self._formationLayout:size().w - 20, self._formationLayout:size().h - self._topLayout:size().h))
	var_36_0:setDirection(ccui.ListViewDirection.horizontal)
	var_36_0:align(cc.p(0.5, 1), self._formationLayout:size().w / 2, self._topLayout:pos().y - self._topLayout:size().h)

	self._roleList = var_36_0

	local var_36_1 = self.manager:getSelectRoleInfo()
	local var_36_2 = cc.size(var_36_0:size().w / FORMATION_SHOW_GIRL_NUM, var_36_0:size().h)

	for iter_36_0 = 1, FORMATION_SHOW_GIRL_NUM do
		local var_36_3 = TempWidget:CreateTempLayout()

		var_36_3:setContentSize(var_36_2)

		local var_36_4 = {
			parent = var_36_3,
			info = var_36_1[iter_36_0]
		}

		self:createRoleFightLayout(var_36_4)
		self:createRoleInfoLayout(var_36_4)
		self:createRoleWeaponShowLayout(var_36_4)

		function var_36_3._update()
			var_36_3._fightLayout._update()
			var_36_3._roleLayout._update()
			var_36_3._weaponShowLayout._update()
		end

		var_36_0:pushBackCustomItem(var_36_3)
	end

	local var_36_5 = L2Skeleton:create("spine/quick_formation/flow3.json", "spine/quick_formation/flow3.atlas")

	var_36_5:refreshSkeleton()
	var_36_5:setPosition(cc.p(self._formationLayout:size().w / 2, var_36_0:pos().y - var_36_0:size().h / 2 + 50))
	var_36_5:play("animation", true)
	self._formationLayout:addChild(var_36_5, var_36_0:getLocalZOrder() - 1)
end

function QuickFormationLayer:createRoleFightLayout(arg_38_1)
	local var_38_0 = arg_38_1.info
	local var_38_1 = TempWidget:CreateTempLayout(arg_38_1.parent)

	var_38_1:setContentSize(cc.size(arg_38_1.parent:size().w, 30))
	var_38_1:align(cc.p(0.5, 1), arg_38_1.parent:size().w / 2, arg_38_1.parent:size().h)

	var_38_1._pos = var_38_0.pos

	var_38_1:setVisible(CONFIG_TYPE_TEST_FIGHT_EMPTY ~= self._data.layerType and CONFIG_TYPE_TEST_FIGHT_PLAYER ~= self._data.layerType)

	arg_38_1.parent._fightLayout = var_38_1

	TempWidget:CreateTempImg(var_0_4 .. "pos_img.png", var_38_1):align(cc.p(0, 0.5), 5, var_38_1:size().h / 2)
	TempWidget:CreateTempLabel(L_QUICKFORMATIONLAYER.INDEX[var_38_0.pos], FONT_NAME, 16, var_38_1):align(cc.p(0, 0.5), 10, var_38_1:size().h / 2)

	local var_38_2 = TempWidget:CreateTempLabel(self.manager:getFightingCapacityByIndex(var_38_0.pos), FONT_NAME, 16, var_38_1)

	var_38_2:align(cc.p(0, 0.5), 60, var_38_1:size().h / 2)

	function var_38_1._update()
		var_38_2:setString(self.manager:getFightingCapacityByIndex(var_38_0.pos))
	end
end

function QuickFormationLayer:createRoleInfoLayout(arg_40_1)
	local var_40_0 = arg_40_1.info.pos
	local var_40_2 = self.manager:getSelectChangeIndex()
	local var_40_4 = arg_40_1.info.isFixed
	local var_40_5 = TempWidget:CreateTempLayout(arg_40_1.parent)

	var_40_5:setContentSize(cc.size(arg_40_1.parent:size().w, 205))
	var_40_5:align(cc.p(0.5, 1), arg_40_1.parent:size().w / 2, arg_40_1.parent._fightLayout:pos().y - arg_40_1.parent._fightLayout:size().h)

	var_40_5._pos = var_40_0
	arg_40_1.parent._roleLayout = var_40_5

	local var_40_6 = TempWidget:CreateTempImg(var_0_4 .. "role_bg.png", var_40_5)

	var_40_6:center()
	var_40_6:setName("roleBg" .. var_40_0)

	local var_40_7 = self.manager:createGirlSprite()

	var_40_7:setScale(0.9)
	var_40_5:addChild(var_40_7)
	var_40_7:setPosition(cc.p(var_40_5:size().w / 2, var_40_5:size().h / 2))

	local var_40_8 = TempWidget:CreateTempImg(var_0_4 .. "add_img.png", var_40_5)

	var_40_8:setScale(2)
	var_40_8:center()

	local var_40_9 = TempWidget:CreateTempLayout(var_40_5)

	var_40_9:setContentSize(var_40_5:size())
	var_40_9:align(cc.p(0.5, 0.5), var_40_5:size().w / 2, var_40_5:size().h / 2)
	var_40_9:setVisible(var_40_0 == var_40_2)

	local var_40_10 = TempWidget:CreateTempImg(var_0_4 .. "mask_img.png", var_40_9)

	var_40_10:center()

	var_40_9._maskImg = var_40_10

	local var_40_11 = TempWidget:CreateTempLabel(L_QUICKFORMATIONLAYER[5], FONT_NAME, 16, var_40_10)

	var_40_11:setMaxLineWidth(60)
	var_40_11:align(cc.p(0.5, 0.5), var_40_10:size().w / 2, var_40_10:size().h / 2 - 26)

	local var_40_12 = TempWidget:CreateTempImg(var_0_4 .. "select_change_bg.png", var_40_9)

	var_40_12:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(1, 50), cc.FadeTo:create(1, 255))))
	var_40_12:center()

	local var_40_13 = TempWidget:CreateTempBtn(var_0_4 .. "quit_img.png", var_40_10)

	var_40_13:align(cc.p(0.5, 0), var_40_10:size().w / 2, 5)
	var_40_13:_addEvent(function()
		self.manager:requestChangeRole(nil, function()
			require("controller/quick_formation_manager"):getInstance():changeRoleSuccess(var_40_0)
		end)
	end)

	local var_40_14 = TempWidget:CreateTempLayout(var_40_5)

	var_40_14:setLocalZOrder(10)
	var_40_14:setContentSize(cc.size(var_40_5:size()))
	var_40_14:align(cc.p(0.5, 0.5), var_40_5:size().w / 2, var_40_5:size().h / 2)
	var_40_14:hide()
	TempWidget:CreateTempImg(var_0_4 .. "lock_img.png", var_40_14):align(cc.p(0.5, 0.5), var_40_14:size().w / 2, var_40_14:size().h / 2 + 20)

	local var_40_15 = TempWidget:CreateTempLabel(L_TEAM_TIPS.Lock, FONT_DES, 22, var_40_14)

	var_40_15:setScale(0.8333333333333334)
	var_40_15:align(cc.p(0.5, 0.5), var_40_14:size().w / 2 + 3, var_40_14:size().h / 2 - 5)
	var_40_15:setColor(cc.c3b(175, 191, 195))

	local var_40_16 = TempWidget:CreateTempLabel(level_manager:formatModeChapterLevelByPlayerLevel(BATTLEARRAY_HORCRUX_UNLOCK[var_40_0], true), FONT_DES, 30, var_40_14)

	var_40_16:setScale(0.8333333333333334)
	var_40_16:align(cc.p(0.5, 0.5), var_40_14:size().w / 2 + 3, var_40_14:size().h / 2 - 30)
	var_40_16:setColor(cc.c3b(255, 211, 115))

	local var_40_17 = TempWidget:CreateTempLayout(var_40_5)

	var_40_17:setLocalZOrder(var_40_14:getLocalZOrder() + 1)
	var_40_17:setContentSize(var_40_5:size())
	var_40_17:align(cc.p(0.5, 0.5), var_40_5:size().w / 2, var_40_5:size().h / 2)
	var_40_17:setVisible(var_40_4)
	TempWidget:CreateTempImg(var_0_4 .. "mask_img.png", var_40_17):center()

	local var_40_18 = TempWidget:CreateTempLabel(L_QUICKFORMATIONLAYER[4], FONT_NAME, 18, var_40_17)

	var_40_18:_setColor("ffd102")
	var_40_18:align(cc.p(0.5, 0.5), var_40_17:size().w / 2, var_40_17:size().h / 2 - 25)

	function var_40_5._update()
		var_40_5._updateSelectChangeLayout()
		var_40_5._updateGirlBtn()
		var_40_5._updateAddImg()
	end

	function var_40_5._updateSelectChangeLayout()
		local var_44_0 = self.manager:getSelectRoleInfo()

		var_40_9:setVisible(var_40_0 == self.manager:getSelectChangeIndex())
		var_40_9._maskImg:setVisible(var_44_0[var_40_0].fight_girl and true or false)
	end

	function var_40_5._updateGirlBtn()
		local var_45_0 = self.manager:getSelectRoleInfo()

		if var_45_0[var_40_5._pos] and var_45_0[var_40_5._pos].fight_girl then
			if CONFIG_TYPE_TEST_FIGHT_EMPTY == self._data.layerType or CONFIG_TYPE_TEST_FIGHT_PLAYER == self._data.layerType then
				var_40_7:update({
					rank = 5,
					contract = 5,
					level = 300,
					servantId = var_45_0[var_40_5._pos].fight_girl,
					modelid = self.manager:getCurFormationInfo()[var_40_5._pos].modelid
				})
			else
				var_40_7:update(var_45_0[var_40_5._pos].fight_girl)

				local var_45_1 = FORMATION_TYPE_TO_FIGHT_TYPE[self.manager:getLayerType()]

				if role_false_level_manager:isRoleFalseLevelMember(var_45_0[var_40_5._pos].fight_girl, var_45_1, self.manager:getLevelMode()) then
					local var_45_2, var_45_3, var_45_4 = role_false_level_manager:getRoleFalseAttrInfoByAllRole(var_45_0[var_40_5._pos].fight_girl, var_45_1, self.manager:getLevelMode())

					var_40_7:updateByFalseLevel(var_45_0[var_40_5._pos].fight_girl, var_45_2, var_45_3)
				else
					var_40_7:stopFalseLevelAni()
				end
			end

			var_40_7:setVisible(true)
		else
			var_40_7:setVisible(false)
		end
	end

	function var_40_5._updateAddImg()
		local var_46_0 = self.manager:getSelectRoleInfo()

		if var_46_0[var_40_5._pos] and var_46_0[var_40_5._pos].fight_girl then
			var_40_8:hide()
		else
			var_40_8:show()
		end
	end

	var_40_5._update()

	local var_40_19 = 0

	var_40_5:setTouchEnabled(true)
	var_40_5:addTouchEventListener(function(arg_47_0, arg_47_1)
		if arg_47_1 == ccui.TouchEventType.began then
			var_40_7:imgScaleTo(1.1, 0.1)
			arg_47_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
				var_40_7:startPressBar(function()
					if CONFIG_TYPE_TEST_FIGHT_EMPTY == self._data.layerType or CONFIG_TYPE_TEST_FIGHT_PLAYER == self._data.layerType then
						return
					end

					local var_49_1 = self.manager:getSelectRoleInfo()[var_40_0].fight_girl

					if var_49_1 then
						LayerManager:pushInLayer("SoulsLayer", {
							showtype = 6,
							cursoul = var_49_1,
							exitCallback = function()
								require("controller/quick_formation_manager"):getInstance():soulsLayerExitCallBack()
							end
						})

						var_40_19 = 0.2
					else
						var_40_19 = 0
					end

					var_40_7:endPressBar()
				end, function(arg_51_0)
					var_40_19 = var_40_19 + arg_51_0
				end)
			end)))
		elseif arg_47_1 == ccui.TouchEventType.canceled then
			var_40_7:imgScaleTo(1, 0.1)
			arg_47_0:stopAllActions()
			var_40_7:endPressBar()
		elseif arg_47_1 == ccui.TouchEventType.ended then
			arg_47_0:stopAllActions()

			if var_40_19 == 0 and var_40_0 ~= self.manager:getSelectChangeIndex() then
				self.manager:setSelectChangeIndex(var_40_0)
				self:updateSelectChnageIndex()
			end

			var_40_19 = 0

			var_40_7:endPressBar()
			var_40_7:imgScaleTo(1, 0.1)
		end
	end)
end

function QuickFormationLayer:createRoleWeaponShowLayout(arg_52_1)
	local var_52_0 = arg_52_1.info.pos
	local var_52_3 = self.manager:getSelectChangeIndex()
	local var_52_4 = TempWidget:CreateTempLayout(arg_52_1.parent)

	var_52_4:setContentSize(cc.size(arg_52_1.parent._roleLayout:size().w, 83))
	var_52_4:align(cc.p(0.5, 0), arg_52_1.parent:size().w / 2, 0)
	var_52_4:setVisible(self:isVisibleRoleHorcruxLayout())

	var_52_4._pos = arg_52_1.info.pos
	arg_52_1.parent._weaponShowLayout = var_52_4

	TempWidget:CreateTempImg(var_0_4 .. "horcrux_bg.png", var_52_4):center()

	local var_52_5 = TempWidget:CreateTempLayout(var_52_4)

	var_52_5:setContentSize(var_52_4:size())
	var_52_5:align(cc.p(0.5, 0.5), var_52_4:size().w / 2, var_52_4:size().h / 2)
	var_52_5:setVisible(not arg_52_1.info.isLockHorcrux)

	local var_52_6 = TempWidget:CreateTempLayout(var_52_5)

	var_52_6:setContentSize(cc.size(40, var_52_5:size().h))
	var_52_6:align(cc.p(0, 0.5), 0, var_52_5:size().h / 2)
	var_52_6:setBackGroundColorOpacity(100)
	var_52_6:_addEvent(function()
		self.manager:requestSelectParts(var_52_0, function()
			require("controller/quick_formation_manager"):getInstance():soulsLayerExitCallBack()
		end)
	end)

	local var_52_7 = var_52_6:size().h

	var_52_4._parts = {}

	for iter_52_0 = 1, var_0_18 do
		local var_52_8 = TempWidget:CreateTempImg(var_0_4 .. "part_add_img.png", var_52_6)

		var_52_8:align(cc.p(0.5, 0.5), var_52_6:size().w / 2, var_52_7 - var_52_7 / 3 / 2 - (iter_52_0 - 1) * var_52_7 / 3)

		var_52_8._initPos = var_52_8:pos()
		var_52_4._parts[iter_52_0] = var_52_8
	end

	local var_52_9 = TempWidget:CreateTempLayout(var_52_5)

	var_52_9:setContentSize(cc.size(77, var_52_5:size().h))
	var_52_9:align(cc.p(1, 0.5), var_52_5:size().w, var_52_5:size().h / 2)
	var_52_9:setBackGroundColorOpacity(100)

	local var_52_10 = self:createWeaponShowLayout(arg_52_1.info.pos)

	var_52_9:addChild(var_52_10)
	var_52_10:align(cc.p(1, 0), var_52_9:size().w, 0)

	function var_52_4._updatePart()
		local var_55_0 = self.manager:getSelectRoleInfo()
		local var_55_1

		if var_55_0[var_52_0] and var_55_0[var_52_0].fight_girl then
			var_55_1 = var_55_0[var_52_0].fight_girl
		end

		local var_55_2 = var_52_4._parts

		if not var_55_1 then
			for iter_55_0 = 1, #var_55_2 do
				var_55_2[iter_55_0]:setScale(1)
				var_55_2[iter_55_0]:loadTextureEx(var_0_4 .. "part_add_img.png")
				var_55_2[iter_55_0]:setPositionY(var_55_2[iter_55_0]._initPos.y)
			end
		elseif playermodel.component[var_55_1] then
			local var_55_3 = (self._data.layerType == CONFIG_TYPE_TEST_FIGHT_EMPTY or self._data.layerType == CONFIG_TYPE_TEST_FIGHT_PLAYER) and component_manager:createMaxComponentData(var_55_1) or component_manager:getSoulComponentlist(var_55_1)

			for iter_55_1 = 1, #var_55_2 do
				var_55_2[iter_55_1]:setPositionY(var_55_2[iter_55_1]._initPos.y)
			end

			for iter_55_2 = 1, var_0_18 do
				if self._data.layerType ~= CONFIG_TYPE_TEST_FIGHT_EMPTY then
					if self._data.layerType == CONFIG_TYPE_TEST_FIGHT_PLAYER then
						local var_55_4 = item_data[var_55_3[iter_55_2].itemid].main_attr and "equipment/component/shine_component/component" .. component_effect_data[var_55_3[iter_55_2].effect].image_id .. "_" .. item_data[var_55_3[iter_55_2].itemid].main_attr .. "_" .. iter_55_2 .. ".png" or "equipment/component/shine_component/component" .. component_effect_data[var_55_3[iter_55_2].effect].image_id .. "_" .. var_55_3[iter_55_2].component_attr.attr1 .. "_" .. iter_55_2 .. ".png"

						var_55_2[iter_55_2]:setScale(0.6)
						var_55_2[iter_55_2]:loadTexture(var_55_4)

						local var_55_5 = var_55_2[iter_55_2]._initPos.y
						local var_55_6 = 18

						if var_55_3[iter_55_2].effect then
							var_55_6 = 25
						end

						if iter_55_2 == 1 then
							var_55_5 = var_55_5 - var_55_6
						elseif iter_55_2 == 3 then
							var_55_5 = var_55_5 + var_55_6
						end

						var_55_2[iter_55_2]:setPositionY(var_55_5)
					elseif playermodel.component[var_55_1][iter_55_2] then
						local var_55_7 = item_data[playermodel.items[playermodel.component[var_55_1][iter_55_2].id].itemid].main_attr and "equipment/component/shine_component/component" .. component_effect_data[playermodel.items[playermodel.component[var_55_1][iter_55_2].id].component_attr.effect].image_id .. "_" .. item_data[playermodel.items[playermodel.component[var_55_1][iter_55_2].id].itemid].main_attr .. "_" .. iter_55_2 .. ".png" or "equipment/component/shine_component/component" .. component_effect_data[playermodel.items[playermodel.component[var_55_1][iter_55_2].id].component_attr.effect].image_id .. "_" .. playermodel.items[playermodel.component[var_55_1][iter_55_2].id].component_attr.attr1 .. "_" .. iter_55_2 .. ".png"

						var_55_2[iter_55_2]:setScale(0.6)
						var_55_2[iter_55_2]:loadTextureEx(var_55_7, 0)

						local var_55_8 = var_55_2[iter_55_2]._initPos.y
						local var_55_9 = 18

						if var_55_3.effect then
							var_55_9 = 25
						end

						if iter_55_2 == 1 then
							var_55_8 = var_55_8 - var_55_9
						elseif iter_55_2 == 3 then
							var_55_8 = var_55_8 + var_55_9
						end

						var_55_2[iter_55_2]:setPositionY(var_55_8)
					end
				end

				var_55_2[iter_55_2]:loadTextureEx(var_0_4 .. "part_add_img.png")
				var_55_2[iter_55_2]:setPositionY(var_55_2[iter_55_2]._initPos.y)
			end
		else
			for iter_55_3 = 1, #var_55_2 do
				var_55_2[iter_55_3]:setScale(1)
				var_55_2[iter_55_3]:loadTextureEx(var_0_4 .. "part_add_img.png")
				var_55_2[iter_55_3]:setPositionY(var_55_2[iter_55_3]._initPos.y)
			end
		end
	end

	function var_52_4._updateWeapon()
		var_52_10.update()
	end

	function var_52_4._update()
		var_52_4._updatePart()
		var_52_4._updateWeapon()
	end

	var_52_4._update()
	var_52_9:setTouchEnabled(true)
	var_52_9:_addEvent(function()
		self.manager:selectWeapon(var_52_0)
	end)
end

function QuickFormationLayer:initFormationLayoutTop()
	local var_59_0 = TempWidget:CreateTempLayout(self._formationLayout)

	var_59_0:setContentSize(cc.size(self._formationLayout:size().w, 50))
	var_59_0:align(cc.p(0, 1), 0, self._formationLayout:size().h)

	self._topLayout = var_59_0

	local var_59_1 = TempWidget:CreateTempImg(var_0_4 .. "fighting_capacity_bg.png", var_59_0)

	var_59_1:align(cc.p(0, 0.5), 0, var_59_0:size().h / 2)
	var_59_1:setVisible(CONFIG_TYPE_TEST_FIGHT_EMPTY ~= self._data.layerType and CONFIG_TYPE_TEST_FIGHT_PLAYER ~= self._data.layerType)

	local var_59_2 = TempWidget:CreateTempLabel(self.manager:getFightingCapacity(), FONT_NAME, 20, var_59_1)

	var_59_2:align(cc.p(0, 0.5), 40, var_59_1:size().h / 2)

	local var_59_3 = TempWidget:CreateTempImg(var_0_4 .. "talent_bg.png", var_59_0)

	var_59_3:align(cc.p(1, 0.5), var_59_0:size().w - 10, var_59_0:size().h / 2)

	self._talentBg = var_59_3

	local var_59_4 = TempWidget:CreateTempLayout(var_59_3)

	var_59_4:setContentSize(cc.size(var_59_3:size().w, var_59_3:size().h))
	var_59_4:align(cc.p(0, 0), 0, 0)

	self._defaultTipsLayout = var_59_4

	TempWidget:CreateTempLabel(L_QUICKFORMATIONLAYER[3], FONT_NAME, 20, var_59_4):align(cc.p(0, 0.5), 10, var_59_4:size().h / 2)
	TempWidget:CreateTempImg(var_0_4 .. "talent_img.png", var_59_4):align(cc.p(1, 0.5), var_59_4:size().w - 10, var_59_4:size().h / 2)

	local var_59_5 = TempWidget:CreateTempLayout(var_59_3)

	var_59_5:setContentSize(var_59_3:size())

	self._showTeamSkillLayout = var_59_5

	local var_59_6 = TempWidget:CreateTempImg(nil, var_59_5)

	var_59_6:align(cc.p(0.5, 0.5), 30, var_59_5:size().h / 2)
	var_59_6:setScale(var_0_17)

	self._iconBackImg = var_59_6

	local var_59_7 = TempWidget:CreateTempImg(nil, var_59_5)

	var_59_7:align(cc.p(0.5, 0.5), var_59_6:pos().x, var_59_5:size().h / 2)
	var_59_7:setScale(var_0_17)

	self._iconImg = var_59_7

	local var_59_8 = TempWidget:CreateTempLayout(var_59_5)

	var_59_8:setContentSize(var_59_5:size())

	self._teamSkillTextLayout = var_59_8

	self:updateShowTeamSkillLayout()

	function var_59_0._update()
		var_59_0._updateFight()
		self:updateShowTeamSkillLayout()
	end

	function var_59_0._updateFight()
		var_59_2:setString(self.manager:getFightingCapacity())
	end
end

function QuickFormationLayer:initTableView(arg_62_1)
	arg_62_1 = arg_62_1 or self.manager.SHOW_TYPE.NORMAL

	local var_62_0 = cc.size(self._formationLayout:size().w, self._formationLayout:pos().y - self._formationLayout:size().h - self._buttom:size().h - self._filterList:getContentSize().height - 10)

	if not self:isVisibleRoleHorcruxLayout() then
		var_62_0.height = var_62_0.height + 95
	end

	local var_62_1 = var_0_19[arg_62_1].TableViewCol
	local var_62_2 = var_0_19[arg_62_1].TableViewCellHeight
	local var_62_3 = TableViewEx:create({
		size = var_62_0,
		cellSizeForTable = function(arg_63_0, arg_63_1)
			return var_62_0.width, var_62_2
		end,
		tableCellAtIndex = function(self, arg_64_1)
			local var_64_0 = self:dequeueCell()

			if not var_64_0 then
				var_64_0 = cc.TableViewCell:new()

				local var_64_1 = self:createTableViewCell(arg_64_1 + 1, arg_62_1)

				var_64_0:addChild(var_64_1)

				var_64_0._cellLayout = var_64_1
			else
				var_64_0._cellLayout._update(arg_64_1 + 1)
			end

			return var_64_0
		end,
		numberOfCellsInTableView = function(arg_65_0)
			return math.ceil(#self.manager:getShowRoleInfo() / var_62_1)
		end
	})

	self._root:addChild(var_62_3)
	var_62_3:setPosition(cc.p(0, self._filterList:getContentSize().height + self._filterList:getPositionY()))
	self._buttom:setLocalZOrder(var_62_3:getLocalZOrder() + 1)
	self._switchShowTypeBtn:setLocalZOrder(var_62_3:getLocalZOrder() + 1)
	self._filterList:setLocalZOrder(var_62_3:getLocalZOrder() + 1)

	self._showTableView[arg_62_1] = var_62_3
end

function QuickFormationLayer:createTableViewCell(arg_66_1, arg_66_2)
	local var_66_0 = var_0_19[arg_66_2].TableViewCol
	local var_66_1 = self.manager:getShowRoleInfo()
	local var_66_2 = TempWidget:CreateTempLayout()

	var_66_2:setContentSize(cc.size(self._formationLayout:size().w, var_0_19[arg_66_2].TableViewCellHeight))

	var_66_2._spriteTable = {}
	var_66_2._inArrayBgTable = {}
	var_66_2._textTable = {}
	var_66_2._cellTable = {}
	var_66_2._inHelpBattleBgTable = {}
	var_66_2._inHelpBattleTextTable = {}
	var_66_2._inGroupFightBgTable = {}
	var_66_2._inGroupFightTextTable = {}
	var_66_2._dropUpIcon = {}

	local var_66_3 = cc.size(var_66_2:size().w / var_0_19[arg_66_2].TableViewCol, var_66_2:size().h)

	for iter_66_0 = 1, var_0_19[arg_66_2].TableViewCol do
		local var_66_4 = TempWidget:CreateTempLayout(var_66_2)

		var_66_4:setContentSize(var_66_3)
		var_66_4:move((iter_66_0 - 1) * var_66_3.width, 0)

		local var_66_5 = self.manager:createTableViewCellSprite()

		var_66_4:addChild(var_66_5)

		var_66_2._cellTable[iter_66_0] = var_66_4

		var_66_5:setAnchorPoint(cc.p(0.5, 0.5))
		var_66_5:setPosition(cc.p(var_66_4:size().w / 2 + 5, var_66_4:size().h / 2))
		var_66_5:setScale(var_0_19[arg_66_2].spriteScale)

		var_66_2._spriteTable[iter_66_0] = var_66_5

		local var_66_6 = TempWidget:CreateTempImg(var_0_4 .. "in_array_bg.png", var_66_4)

		var_66_6:setScale9Enabled(true)
		var_66_6:setCapInsets(cc.rect(0, 0, var_66_6:getContentSize().width, var_66_6:getContentSize().height))
		var_66_6:setContentSize(cc.size(var_66_4:size().w - 20, var_66_4:size().h - 10))
		var_66_6:align(cc.p(0.5, 0.5), var_66_4:size().w / 2, var_66_4:size().h / 2)

		var_66_2._inArrayBgTable[iter_66_0] = var_66_6

		local var_66_7 = TempWidget:CreateTempImg(var_0_4 .. "in_array.png", var_66_6)

		var_66_7:setScale9Enabled(true)
		var_66_7:setCapInsets(cc.rect(0, 0, var_66_7:getContentSize().width, var_66_7:getContentSize().height))
		var_66_7:setContentSize(cc.size(var_66_6:size().w, var_66_7:size().h))
		var_66_7:center()

		local var_66_8 = TempWidget:CreateTempLabel("", FONT_NAME, 23, var_66_7)

		var_66_8:center()

		var_66_2._textTable[iter_66_0] = var_66_8

		local var_66_9 = TempWidget:CreateTempImg(var_0_4 .. "in_array_bg.png", var_66_4)

		var_66_9:setScale9Enabled(true)
		var_66_9:setCapInsets(cc.rect(0, 0, var_66_9:getContentSize().width, var_66_9:getContentSize().height))
		var_66_9:setContentSize(cc.size(var_66_4:size().w - 20, var_66_4:size().h - 10))
		var_66_9:align(cc.p(0.5, 0.5), var_66_4:size().w / 2, var_66_4:size().h / 2)

		var_66_2._inHelpBattleBgTable[iter_66_0] = var_66_9

		local var_66_10 = TempWidget:CreateTempImg(var_0_4 .. "in_array.png", var_66_9)

		var_66_10:setScale9Enabled(true)
		var_66_10:setCapInsets(cc.rect(0, 0, var_66_10:getContentSize().width, var_66_10:getContentSize().height))
		var_66_10:setContentSize(cc.size(var_66_9:size().w, var_66_10:size().h))
		var_66_10:center()

		local var_66_11 = TempWidget:CreateTempLabel("", FONT_NAME, 23, var_66_9)

		var_66_11:center()

		var_66_2._inHelpBattleTextTable[iter_66_0] = var_66_11

		local var_66_12 = TempWidget:CreateTempImg(var_0_4 .. "in_array_bg.png", var_66_4)

		var_66_12:setScale9Enabled(true)
		var_66_12:setCapInsets(cc.rect(0, 0, var_66_12:getContentSize().width, var_66_12:getContentSize().height))
		var_66_12:setContentSize(cc.size(var_66_4:size().w - 20, var_66_4:size().h - 10))
		var_66_12:align(cc.p(0.5, 0.5), var_66_4:size().w / 2, var_66_4:size().h / 2)

		var_66_2._inGroupFightBgTable[iter_66_0] = var_66_12

		local var_66_13 = TempWidget:CreateTempImg(var_0_4 .. "in_array.png", var_66_12)

		var_66_13:setScale9Enabled(true)
		var_66_13:setCapInsets(cc.rect(0, 0, var_66_13:getContentSize().width, var_66_13:getContentSize().height))
		var_66_13:setContentSize(cc.size(var_66_12:size().w, var_66_13:size().h))
		var_66_13:center()

		local var_66_14 = TempWidget:CreateTempLabel("", FONT_NAME, 23, var_66_12)

		var_66_14:center()

		var_66_2._inGroupFightTextTable[iter_66_0] = var_66_14

		local var_66_15 = ccui.ImageView:create("weeklytower/reward_up_icon.png", var_0_3)

		var_66_15:setAnchorPoint(0, 1)
		var_66_15:setPosition(-10, var_66_5:getContentSize().height)
		var_66_5:addChild(var_66_15, 100)
		var_66_15:setName("drop_up_icon")

		var_66_2._dropUpIcon[iter_66_0] = var_66_15

		local var_66_16 = 0

		var_66_5:setTouchEnabled(true)
		var_66_5:setSwallowTouches(false)
		var_66_5:addTouchEventListener(function(arg_67_0, arg_67_1)
			if arg_67_1 == ccui.TouchEventType.began then
				var_66_5:imgScaleTo(1.1, 0.1)
				arg_67_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
					var_66_5:startPressBar(function()
						if self._data.layerType == CONFIG_TYPE_TEST_FIGHT_EMPTY or self._data.layerType == CONFIG_TYPE_TEST_FIGHT_PLAYER then
							return
						end

						local var_69_0 = var_66_5._id

						if var_66_5._id then
							LayerManager:pushInLayer("SoulsLayer", {
								showtype = 6,
								cursoul = var_69_0,
								exitCallback = function()
									require("controller/quick_formation_manager"):getInstance():soulsLayerExitCallBack()
								end
							})

							var_66_16 = 0.2
						else
							var_66_16 = 0
						end

						var_66_5:endPressBar()
					end, function(arg_71_0)
						var_66_16 = var_66_16 + arg_71_0
					end, 1.2)
				end)))
			elseif arg_67_1 == ccui.TouchEventType.canceled then
				var_66_5:imgScaleTo(1, 0.1)
				arg_67_0:stopAllActions()
				var_66_5:endPressBar()
			elseif arg_67_1 == ccui.TouchEventType.ended then
				arg_67_0:stopAllActions()

				if var_66_16 == 0 then
					self.manager:requestChangeRole(var_66_5._id, function()
						local var_72_0 = require("controller/quick_formation_manager"):getInstance()

						var_72_0:changeRoleSuccess(var_72_0:getSelectChangeIndex())
					end)
				end

				var_66_16 = 0

				var_66_5:endPressBar()
				var_66_5:imgScaleTo(1, 0.1)
			end
		end)

		if var_66_1[(arg_66_1 - 1) * var_0_19[arg_66_2].TableViewCol + iter_66_0] then
			var_66_4:show()
		else
			var_66_4:hide()
		end
	end

	function var_66_2._update(arg_73_0)
		local var_73_0 = self.manager:getShowRoleInfo()

		for iter_73_0 = 1, var_66_0 do
			var_66_2._cellTable[iter_73_0]:setName(arg_66_2 .. "_cell_index_" .. (arg_73_0 - 1) * var_66_0 + iter_73_0)

			if var_73_0[(arg_73_0 - 1) * var_66_0 + iter_73_0] then
				var_66_2._cellTable[iter_73_0]:show()

				local var_73_1 = var_73_0[(arg_73_0 - 1) * var_66_0 + iter_73_0].soulid

				var_66_2._spriteTable[iter_73_0]:update(var_73_0[(arg_73_0 - 1) * var_66_0 + iter_73_0].soulid, self._isShowAttrs)

				var_66_2._spriteTable[iter_73_0]._id = var_73_1

				local var_73_2 = false
				local var_73_3 = false
				local var_73_4 = false
				local var_73_5 = var_66_2._inArrayBgTable[iter_73_0]
				local var_73_6 = var_66_2._inHelpBattleBgTable[iter_73_0]
				local var_73_7 = var_66_2._inGroupFightBgTable[iter_73_0]
				local var_73_8 = var_66_2._dropUpIcon[iter_73_0]

				for iter_73_1, iter_73_2 in pairs((self.manager:getSelectRoleInfo())) do
					if iter_73_2.fight_girl == var_73_1 then
						var_73_2 = true

						var_66_2._textTable[iter_73_0]:setString(var_0_16(L_QUICKFORMATIONLAYER[8], iter_73_2.pos))
					end
				end

				if CONFIG_TYPE_GROUP_FIGHT == self._data.layerType then
					for iter_73_3 = 1, #self._data.allArray do
						if iter_73_3 ~= self.manager:getFormationIndex() then
							for iter_73_4, iter_73_5 in pairs(self._data.allArray[iter_73_3]) do
								if iter_73_5.fight_girl == var_73_1 then
									var_73_4 = true

									var_66_2._inGroupFightTextTable[iter_73_0]:setString(var_0_16(L_QUICKFORMATIONLAYER[1], iter_73_3))
								end
							end
						end
					end
				end

				if self.manager:isHelpBattle(var_73_1, self.manager:getFormationIndex()) then
					var_73_3 = true

					var_66_2._inHelpBattleTextTable[iter_73_0]:setString(L_QUICKFORMATIONLAYER[17])
				end

				local var_73_9 = var_66_2._textTable[iter_73_0]:getParent()

				if self._isShowAttrs then
					var_73_9:setOpacity(10)
				else
					var_73_9:setOpacity(255)
				end

				if var_73_2 then
					var_73_5:show()
				else
					var_73_5:hide()
				end

				if var_73_3 and not CONFIG_TYPE_GROUP_FIGHT == self._data.layerType then
					var_73_6:show()
				else
					var_73_6:hide()
				end

				if CONFIG_TYPE_GROUP_FIGHT == self._data.layerType and var_73_4 then
					var_73_7:show()
				else
					var_73_7:hide()
				end

				local var_73_10 = level_manager:getDropUpServants(self.manager._mode)

				var_73_8:setVisible(false)

				if var_73_10 then
					for iter_73_6, iter_73_7 in ipairs(var_73_10) do
						if var_73_1 == iter_73_7 then
							var_73_8:setVisible(true)
						end
					end
				end
			else
				var_66_2._cellTable[iter_73_0]:hide()
			end
		end
	end

	var_66_2._update(arg_66_1)

	return var_66_2
end

function QuickFormationLayer:updateLayer()
	return
end

function QuickFormationLayer:updateRed()
	return
end

function QuickFormationLayer:updateShowTeamSkillLayout()
	local var_76_0 = self.manager:getTeamSkill()
	local var_76_1 = self._iconBackImg
	local var_76_2 = self._iconImg

	self._teamSkillTextLayout:removeAllChildren()
	self._iconBackImg:stopAllActions()
	self._iconImg:stopAllActions()

	if #var_76_0 == 0 then
		self._defaultTipsLayout:show()
		self._showTeamSkillLayout:hide()
	else
		self._defaultTipsLayout:hide()
		self._showTeamSkillLayout:show()
		self._iconBackImg:loadTextureEx(var_0_4 .. "icon_" .. var_76_0[1].icon .. ".png")
		self._iconImg:loadTextureEx(var_0_4 .. "icon_" .. var_76_0[1].icon .. ".png")

		local var_76_3 = var_0_17

		self._iconBackImg:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(var_0_17 / 5), cc.CallFunc:create(function()
			var_76_1:setScale(var_76_3)
			var_76_1:setOpacity(255)
		end), cc.Spawn:create(cc.ScaleTo:create(0.5, var_0_17 * 2), cc.FadeOut:create(0.5)), cc.DelayTime:create(0.6))))

		local var_76_4 = {}

		for iter_76_0 = 1, #var_76_0 do
			local var_76_5 = TempWidget:CreateTempLabel(var_76_0[iter_76_0].des, FONT_NAME, 18, self._teamSkillTextLayout)

			var_76_5:setAnchorPoint(cc.p(0, 0.5))
			var_76_5:align(cc.p(0, 0.5), self._iconImg:pos().x + self._iconImg:size().w / 2, self._teamSkillTextLayout:size().h / 2)
			var_76_5:setOpacity(0)
			table.insert(var_76_4, var_76_5)
		end

		var_76_4[1]:setOpacity(255)

		if #var_76_4 > 1 then
			for iter_76_1 = 1, #var_76_4 do
				var_76_4[iter_76_1]:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create((iter_76_1 - 1) * 3), cc.CallFunc:create(function()
					var_76_2:loadTextureEx(var_0_4 .. "icon_" .. var_76_0[iter_76_1].icon .. ".png")
					var_76_1:loadTextureEx(var_0_4 .. "icon_" .. var_76_0[iter_76_1].icon .. ".png")
				end), cc.FadeTo:create(0.2, 255), cc.DelayTime:create(2.6), cc.FadeTo:create(0.2, 0), cc.DelayTime:create((#var_76_4 - 1) * 3 - (iter_76_1 - 1) * 3))))
			end
		end
	end
end

function QuickFormationLayer:updateFormationIndexList()
	local var_79_0 = self._formationIndexList

	self._formationIndexList:removeAllItems()
	self:initFormationIndexListWidget()
	performWithDelay(self._formationIndexList, function()
		var_79_0:jumpToRight()
	end, 0.016666666666666666)
end

function QuickFormationLayer:updateFormationSelectIndex()
	local var_81_0 = self.manager:getFormationIndex()
	local var_81_1 = self._formationIndexList:getChildren()

	for iter_81_0 = 1, #var_81_1 do
		local var_81_2 = var_81_1[iter_81_0]

		if not var_81_1[iter_81_0]._isExtend then
			local var_81_3 = var_81_2._offBg
			local var_81_4 = var_81_2._text

			var_81_2._onBg:setVisible(iter_81_0 == var_81_0)
			var_81_3:setVisible(iter_81_0 ~= var_81_0)
			var_81_4:_setColor(iter_81_0 == var_81_0 and "ffffff" or "9992c4")
		end
	end

	local var_81_5 = self._roleList:getChildren()

	for iter_81_1 = 1, #var_81_5 do
		var_81_5[iter_81_1]._update()
	end

	self._topLayout._update()
	self:reloadData()
end

function QuickFormationLayer:extendSuccess()
	self:updateFormationIndexList()
end

function QuickFormationLayer:updateSelectChnageIndex()
	local var_83_0 = self._roleList:getChildren()

	for iter_83_0 = 1, #var_83_0 do
		var_83_0[iter_83_0]._roleLayout._updateSelectChangeLayout()
	end
end

function QuickFormationLayer:soulsLayerExitCallBack()
	local var_84_0 = self._roleList:getChildren()

	for iter_84_0 = 1, #var_84_0 do
		var_84_0[iter_84_0]._update()
	end

	self._topLayout._updateFight()
	self:updateShowingCells()
end

function QuickFormationLayer:changeHorcruxSuccess()
	local var_85_0 = self._roleList:getChildren()

	for iter_85_0 = 1, #var_85_0 do
		var_85_0[iter_85_0]._update()
	end

	self._topLayout._updateFight()
end

function QuickFormationLayer:changeRoleSuccess(arg_86_1)
	local var_86_0 = self._roleList:getChildren()

	for iter_86_0 = 1, #var_86_0 do
		var_86_0[iter_86_0]._update()
	end

	self._topLayout._update()
	self:updateShowingCells()

	if self._data.selectGirlType == SELECT_GIRL_EXPEDITION and self._data[self._data.selectGirlType] and self._data[self._data.selectGirlType].sureCallBack then
		self._data[self._data.selectGirlType].sureCallBack()
	end
end

function QuickFormationLayer:reloadData()
	self._showTableView[self.manager:getShowType()]:reloadData()
end

function QuickFormationLayer:updateShowingCells()
	local var_88_0 = self.manager:getShowType()
	local var_88_1 = {
		cellsize = cc.size(self._showTableView[var_88_0]:getContentSize().width, var_0_19[var_88_0].TableViewCellHeight)
	}

	var_88_1.maxcount = math.ceil(#self.manager:getShowRoleInfo() / var_0_19[var_88_0].TableViewCol)

	local var_88_3, var_88_4 = GetTableViewShowCellIdx(self._showTableView[var_88_0]._tableView, var_88_1)

	for iter_88_0 = var_88_3, var_88_4 do
		self._showTableView[var_88_0]:updateCellAtIndex(iter_88_0)
	end
end

function QuickFormationLayer:updateFilterListSprite()
	self:reloadData()
end

function QuickFormationLayer:updateTableViewVisible()
	for iter_90_0, iter_90_1 in pairs(self._showTableView) do
		iter_90_1:setVisible(iter_90_0 == self.manager:getShowType())
	end
end

function QuickFormationLayer:isVisibleRoleHorcruxLayout()
	return self._data.layerType ~= CONFIG_TYPE_EXPEDITION
end

function QuickFormationLayer:createWeaponShowLayout(arg_92_1)
	local var_92_0 = self.manager:getSelectRoleInfo()
	local var_92_1 = TempWidget:CreateTempLayout()

	var_92_1:setContentSize(cc.size(80.39999999999999, 91.2))

	var_92_1._childData = {}

	local var_92_2 = TempWidget:CreateTempImg("weaponIcon/2200051.png", var_92_1, 0)

	var_92_2:setScale(0.2)
	var_92_2:center()

	var_92_1._childData.weaponImg = var_92_2

	local var_92_3 = TempWidget:CreateTempImg(var_0_4 .. "goto_gain_weapon.png", var_92_1)

	var_92_3:setScale(0.7)
	var_92_3:center()

	local var_92_4 = TempWidget:CreateTempImg(var_0_4 .. "weapon_unlocked.png", var_92_1)

	var_92_4:setScale(0.7)
	var_92_4:center()

	function var_92_1.update()
		var_92_2:hide()
		var_92_3:hide()
		var_92_4:hide()

		local var_93_0 = self.manager:getSelectRoleInfo()

		if var_93_0[arg_92_1] and var_93_0[arg_92_1].fight_girl then
			local var_93_1 = self.manager:getLayerType()

			if var_93_1 == CONFIG_TYPE_HANGUP or var_93_1 == CONFIG_TYPE_MODE or var_93_1 == CONFIG_TYPE_SCOREARENA or var_93_1 == CONFIG_TYPE_ARENA or var_93_1 == CONFIG_TYPE_ARENA_DEFENCE or var_93_1 == CONFIG_TYPE_SUBSTITUTION or var_93_1 == CONFIG_TYPE_EXPLORE or var_93_1 == CONFIG_TYPE_EXPEDITION or var_93_1 == CONFIG_TYPE_REFIGHT or var_93_1 == CONFIG_TYPE_EXPLORE_HP_INHERIT or var_93_1 == CONFIG_TYPE_GROUP_FIGHT then
				local var_93_2 = var_93_0[arg_92_1].fight_girl

				if playermodel.items[playermodel.weaponId[var_93_0[arg_92_1].fight_girl]] then
					var_92_2:loadTexture("weaponIcon/" .. item_data[playermodel.items[playermodel.weaponId[var_93_0[arg_92_1].fight_girl]].itemid].image_id .. ".png")
					var_92_2:setScale(0.2)
				else
					local var_93_3 = item_data[servant_data[var_93_2].recommend_weapon2]

					if weapon_manager:checkIsCanReplaceBetter(var_93_2) then
						var_92_2:loadTexture("weaponIcon/" .. var_93_3.image_id .. ".png")
						var_92_2:setScale(0.2)
						var_92_4:show()
					else
						var_92_2:loadTexture("weaponIcon/weapon_blue_shadow/" .. var_93_3.image_id .. ".png")
						var_92_2:setScale(0.45)
						var_92_3:show()
					end
				end

				var_92_2:show()
			end
		end
	end

	var_92_1.update()

	return var_92_1
end

function QuickFormationLayer:updateWeaponShowLayout()
	local var_94_0 = self._roleList:getChildren()

	for iter_94_0 = 1, #var_94_0 do
		var_94_0[iter_94_0]._weaponShowLayout._update()
	end
end

return QuickFormationLayer
