CostumeRoomLayer = class("CostumeRoomLayer", (require("view.Layer.BaseUILayer")))

local TempWidget = require("view.Sprite.TempWidget")
local TableViewEx = require("view.Sprite.TableViewEx")
local var_0_2 = config._DEBUG and 0 or 1
local var_0_3 = "CostumeRoomLayer/"
local var_0_4 = GameDisplay.width
local var_0_5 = 80
local var_0_6 = 290
local var_0_7 = 4
local var_0_8

function CostumeRoomLayer:ctor()
	CostumeRoomLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller.costume_room_manager"):getInstance()
	self.oldFilterState = self.manager:getCurFilterState()
end

function CostumeRoomLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = CostumeRoomLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function CostumeRoomLayer:onEnter()
	self.super.onEnter(self)
end

function CostumeRoomLayer:onExit()
	self.super.onExit(self)
end

function CostumeRoomLayer:init()
	self.manager:initFilterData()
	self:initLayer()
	self:initListener()

	return true
end

function CostumeRoomLayer:initLayer()
	self._root = cc.Layer:create()

	self:addChild(self._root)

	local var_6_0 = TempWidget:CreateTempImg("mainScenebg/costume_room_bg.png", self._root, 0)

	var_6_0:align(cc.p(0, 0), 0, 0)

	self.bg = var_6_0

	local var_6_1 = TempWidget:CreateTempImg(var_0_3 .. "title.png", var_6_0)

	var_6_1:align(cc.p(1, 0), GameDisplay.width, GameDisplay.height - 100)

	local var_6_2 = TempWidget:CreateTempBtn(var_0_3 .. "check_have_off.png", var_6_0)

	var_6_2:align(cc.p(1, 0), GameDisplay.width - 10, var_6_1:getPositionY() - var_6_2:size().h)
	var_6_2:setLocalZOrder(99)

	self.checkHaveBtn = var_6_2

	self:updateCheckHaveBtn()

	local var_6_3 = TempWidget:CreateTempBtn(var_0_3 .. "check_l2d_off.png", var_6_0)

	var_6_3:align(cc.p(1, 0), var_6_2:getPositionX() - var_6_2:size().w - 50, var_6_1:getPositionY() - var_6_3:size().h)
	var_6_3:setLocalZOrder(99)

	self.checkL2dBtn = var_6_3

	self:updateCheckL2dBtn()

	local var_6_4 = TempWidget:CreateTempImg(var_0_3 .. "down_line.png", var_6_0)

	var_6_4:setLocalZOrder(99)
	var_6_4:align(cc.p(0, 0), 0, 0)

	self.backBg = var_6_4

	local var_6_5 = TempWidget:CreateTempBtn(var_0_3 .. "btn_back.png", var_6_4)

	var_6_5:align(cc.p(0, 0.5), 0, var_6_4:size().h / 2)

	self.backBtn = var_6_5

	local var_6_6 = TempWidget:CreateTempImg(var_0_3 .. "filter_off.png", var_6_4)

	var_6_6:align(cc.p(1, 0.5), GameDisplay.width - 10, var_6_4:size().h / 2)

	self.filterBtn = var_6_6

	self:updateFilterBtn()

	local var_6_7 = TempWidget:CreateTempBtn(var_0_3 .. "reward_btn.png", var_6_4)

	var_6_7:hide()
	var_6_7:align(cc.p(1, 0.5), var_6_6:pos().x - var_6_6:size().w, var_6_6:pos().y + 2)
	var_6_7:_addEvent(function()
		LayerManager:pushInLayer("CostumeRoomRewardLayer")
	end)

	local var_6_8 = TempWidget:CreateTempImg("public/reddot/reddot2.png", var_6_7)

	var_6_8:align(cc.p(1, 0.5), var_6_7:size().w + 15, var_6_7:size().h / 2)

	self.rewardLayerBtnRedImg = var_6_8

	self:updateTableView()

	local var_6_9 = TempWidget:CreateTempImg(var_0_3 .. "no_have.png", var_6_0)

	var_6_9:hide()
	var_6_9:move(var_6_0:size().w / 2, var_6_0:size().h / 2)

	self.noHaveBg = var_6_9

	self:updateNoHaveBg()

	local var_6_10 = TempWidget:CreateTempImg("mainScenebg/costume_room_filter_bg.png", self._root, 0)

	var_6_10:hide()
	var_6_10:setScaleY(0.01)
	var_6_10:center()
	var_6_10:setLocalZOrder(var_6_0:getLocalZOrder() + 1)

	self.filterBg = var_6_10

	self:initFilterBg()
	self:updateRed()
end

function CostumeRoomLayer:initListener()
	self.checkHaveBtn:_addEvent(function()
		local var_9_0 = self.manager:getSkinState(self.manager.FilterRule.SkinState)

		if var_9_0 == self.manager.SkinState.All then
			self.manager:setSkinState(self.manager.FilterRule.SkinState, self.manager.SkinState.Have)
		elseif var_9_0 == self.manager.SkinState.Have then
			self.manager:setSkinState(self.manager.FilterRule.SkinState, self.manager.SkinState.All)
		elseif var_9_0 == self.manager.SkinState.Not_Have then
			self.manager:setSkinState(self.manager.FilterRule.SkinState, self.manager.SkinState.Have)
		end

		self:updateCheckHaveBtn()
		self:updateFilterBtn()
		self:updateTableView()
		self:updateNoHaveBg()
	end)
	self.checkL2dBtn:_addEvent(function()
		self.manager:setFilterStateReverse(self.manager.FilterRule.Live2D)
		self:updateCheckL2dBtn()
		self:updateFilterBtn()
		self:updateTableView()
		self:updateNoHaveBg()
	end)
	self.backBtn:_addEvent(function()
		var_0_8 = nil

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.filterBg:_addEvent(function(arg_12_0)
		arg_12_0:stopAllActions()
		arg_12_0:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 0.01), cc.CallFunc:create(function()
			arg_12_0:hide()
		end)))
	end)
	self.filterBtn:_addEvent(function()
		self.oldFilterState = self.manager:getCurFilterState()

		self.filterBg:stopAllActions()
		self.filterBg:show()
		self.filterBg.updateTextureEx()
		self.filterBg.updateTexture1()
		self.filterBg:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 1)))
	end)
end

function CostumeRoomLayer:initFilterBg()
	local var_15_0 = self.filterBg
	local var_15_2 = self.filterBg:size().w - 10 * 2
	local var_15_3 = TempWidget:CreateTempImg(var_0_3 .. "sort_img.png", self.filterBg)

	var_15_3:align(cc.p(0, 1), 10, self.filterBg:size().h * 0.75)

	local var_15_4 = TempWidget:CreateTempListView()

	var_15_4:setContentSize(cc.size(self.filterBg:size().w, 50 * 3))
	var_15_4:align(cc.p(0, 1), 0, var_15_3:getPositionY() - var_15_3:size().h - 30)
	self.filterBg:addChild(var_15_4)

	local var_15_5 = {
		L_COSTUME_ROOM_SELECT[1],
		L_COSTUME_ROOM_SELECT[2],
		L_COSTUME_ROOM_SELECT[3]
	}
	local var_15_6 = {
		self.manager.MemberState.All,
		self.manager.MemberState.Have,
		self.manager.MemberState.Not_Have
	}
	local var_15_7 = {}

	local function var_15_8()
		local var_16_0 = self.manager:getMemberState(self.manager.FilterRule.MemberState)

		for iter_16_0 = 1, #var_15_7 do
			local var_16_1 = "select_off.png"

			if var_16_0 == var_15_6[iter_16_0] then
				var_16_1 = "select_on.png"
			end

			var_15_7[iter_16_0]:loadTextureNormal(var_0_3 .. var_16_1, var_0_2)
			var_15_7[iter_16_0]:loadTexturePressed(var_0_3 .. var_16_1, var_0_2)
			var_15_7[iter_16_0]:loadTextureDisabled(var_0_3 .. var_16_1, var_0_2)
		end
	end

	local var_15_9 = TempWidget:CreateTempLayout()

	var_15_9:setContentSize(cc.size(self.filterBg:size().w, 50))

	for iter_15_0 = 1, #var_15_5 do
		local var_15_10 = "select_off.png"

		if self.manager:getMemberState(self.manager.FilterRule.MemberState) == var_15_6[iter_15_0] then
			var_15_10 = "select_on.png"
		end

		local var_15_11 = TempWidget:CreateTempBtn(var_0_3 .. var_15_10, var_15_9)

		var_15_11:loadTexturePressed(var_0_3 .. var_15_10, var_0_2)
		var_15_11:loadTextureDisabled(var_0_3 .. var_15_10, var_0_2)
		var_15_11:align(cc.p(0, 0.5), 10 + (iter_15_0 - 1) * ((var_15_2 - var_15_11:size().w * var_0_7) / (var_0_7 - 1) + var_15_11:size().w), var_15_9:size().h / 2)

		local var_15_12 = TempWidget:CreateTempLabel(var_15_5[iter_15_0], FONT_W5, 19)

		var_15_11:addChild(var_15_12)
		var_15_12:move(var_15_11:size().w / 2, var_15_11:size().h / 2)
		var_15_11:_addEvent(function()
			if self.manager:getMemberState(self.manager.FilterRule.MemberState) ~= var_15_6[iter_15_0] then
				self.manager:setMemberState(self.manager.FilterRule.MemberState, var_15_6[iter_15_0])
				var_15_8()
				self:updateCheckHaveBtn()
				self:updateCheckL2dBtn()
				self:updateFilterBtn()
				self:updateTableView()
				self:updateNoHaveBg()
			end
		end)

		var_15_7[iter_15_0] = var_15_11
	end

	var_15_4:pushBackCustomItem(var_15_9)

	local var_15_13 = {
		L_COSTUME_ROOM_SELECT[4],
		L_COSTUME_ROOM_SELECT[5],
		L_COSTUME_ROOM_SELECT[6]
	}
	local var_15_14 = {
		self.manager.MemberState.All,
		self.manager.MemberState.Have,
		self.manager.MemberState.Not_Have
	}
	local var_15_15 = {}

	local function var_15_16()
		local var_18_0 = self.manager:getSkinState(self.manager.FilterRule.SkinState)

		for iter_18_0 = 1, #var_15_15 do
			local var_18_1 = "select_off.png"

			if var_18_0 == var_15_14[iter_18_0] then
				var_18_1 = "select_on.png"
			end

			var_15_15[iter_18_0]:loadTextureNormal(var_0_3 .. var_18_1, var_0_2)
			var_15_15[iter_18_0]:loadTexturePressed(var_0_3 .. var_18_1, var_0_2)
			var_15_15[iter_18_0]:loadTextureDisabled(var_0_3 .. var_18_1, var_0_2)
		end
	end

	self.filterBg.updateTexture1 = var_15_16

	local var_15_17 = TempWidget:CreateTempLayout()

	var_15_17:setContentSize(cc.size(self.filterBg:size().w, 50))

	for iter_15_1 = 1, #var_15_13 do
		local var_15_18 = "select_off.png"

		if self.manager:getSkinState(self.manager.FilterRule.SkinState) == var_15_14[iter_15_1] then
			var_15_18 = "select_on.png"
		end

		local var_15_19 = TempWidget:CreateTempBtn(var_0_3 .. var_15_18, var_15_17)

		var_15_19:loadTexturePressed(var_0_3 .. var_15_18, var_0_2)
		var_15_19:loadTextureDisabled(var_0_3 .. var_15_18, var_0_2)
		var_15_19:align(cc.p(0, 0.5), 10 + (iter_15_1 - 1) * ((var_15_2 - var_15_19:size().w * var_0_7) / (var_0_7 - 1) + var_15_19:size().w), var_15_17:size().h / 2)

		local var_15_20 = TempWidget:CreateTempLabel(var_15_13[iter_15_1], FONT_W5, 19)

		var_15_19:addChild(var_15_20)
		var_15_20:move(var_15_19:size().w / 2, var_15_19:size().h / 2)
		var_15_19:_addEvent(function()
			if self.manager:getSkinState(self.manager.FilterRule.SkinState) ~= var_15_14[iter_15_1] then
				self.manager:setSkinState(self.manager.FilterRule.SkinState, var_15_14[iter_15_1])
				var_15_16()
				self:updateCheckHaveBtn()
				self:updateCheckL2dBtn()
				self:updateFilterBtn()
				self:updateTableView()
				self:updateNoHaveBg()
			end
		end)

		var_15_15[iter_15_1] = var_15_19
	end

	var_15_4:pushBackCustomItem(var_15_17)

	local var_15_21 = TempWidget:CreateTempLayout()

	var_15_21:setContentSize(cc.size(self.filterBg:size().w, 50))
	var_15_4:pushBackCustomItem(var_15_21)

	local var_15_22 = {
		"Live2D",
		L_COSTUME_ROOM_SELECT[7]
	}
	local var_15_23 = {
		self.manager.FilterRule.Live2D,
		self.manager.FilterRule.UncolorClothes
	}
	local var_15_24 = {}

	local function var_15_25()
		for iter_20_0 = 1, #var_15_24 do
			local var_20_0 = "select_off.png"

			if self.manager:getFilterState(var_15_23[iter_20_0]) == self.manager.FilterState.On then
				var_20_0 = "select_on.png"
			end

			var_15_24[iter_20_0]:loadTextureNormal(var_0_3 .. var_20_0, var_0_2)
			var_15_24[iter_20_0]:loadTexturePressed(var_0_3 .. var_20_0, var_0_2)
			var_15_24[iter_20_0]:loadTextureDisabled(var_0_3 .. var_20_0, var_0_2)
		end
	end

	self.filterBg.updateTextureEx = var_15_25

	for iter_15_2 = 1, #var_15_22 do
		local var_15_26 = "select_off.png"

		if self.manager:getFilterState(var_15_23[iter_15_2]) == self.manager.FilterState.On then
			var_15_26 = "select_on.png"
		end

		local var_15_27 = TempWidget:CreateTempBtn(var_0_3 .. var_15_26, var_15_21)

		var_15_27:loadTexturePressed(var_0_3 .. var_15_26, var_0_2)
		var_15_27:loadTextureDisabled(var_0_3 .. var_15_26, var_0_2)
		var_15_27:align(cc.p(0, 0.5), 10 + (iter_15_2 - 1) * ((var_15_2 - var_15_27:size().w * var_0_7) / (var_0_7 - 1) + var_15_27:size().w), var_15_21:size().h / 2)

		local var_15_28 = TempWidget:CreateTempLabel(var_15_22[iter_15_2], FONT_W5, 19)

		var_15_27:addChild(var_15_28)
		var_15_28:move(var_15_27:size().w / 2, var_15_27:size().h / 2)
		var_15_27:_addEvent(function()
			self.manager:setFilterStateReverse(var_15_23[iter_15_2])
			var_15_25()
			self:updateCheckHaveBtn()
			self:updateCheckL2dBtn()
			self:updateFilterBtn()
			self:updateTableView()
			self:updateNoHaveBg()
		end)

		var_15_24[iter_15_2] = var_15_27
	end

	local var_15_29 = self.manager:getTypeFilter()
	local var_15_30 = TempWidget:CreateTempImg(var_0_3 .. "type_img.png", self.filterBg)

	var_15_30:align(cc.p(0, 1), var_15_3:getPositionX(), var_15_4:getPositionY() - var_15_4:getContentSize().height - 50)

	local var_15_31 = 50 * 4
	local var_15_32 = TempWidget:CreateTempListView()

	self.filterBg:addChild(var_15_32)

	if math.ceil(#var_15_29 / var_0_7) > 4 then
		var_15_31 = var_15_31 + (math.ceil(#var_15_29 / var_0_7) - 4) * 50
	end

	var_15_32:setContentSize(cc.size(var_15_4:getContentSize().width, var_15_31))
	var_15_32:align(cc.p(0, 1), 0, var_15_30:getPositionY() - var_15_30:size().h - 30)

	self.skinTypeFilterBtnTable = {}

	for iter_15_3 = 1, math.ceil(#var_15_29 / var_0_7) do
		local var_15_33 = TempWidget:CreateTempLayout()

		var_15_33:setContentSize(cc.size(self.filterBg:size().w, 50))

		for iter_15_4 = 1, var_0_7 do
			local var_15_34 = iter_15_4 + (iter_15_3 - 1) * var_0_7

			if var_15_29[iter_15_4 + (iter_15_3 - 1) * var_0_7] then
				local var_15_35 = TempWidget:CreateTempBtn(nil, var_15_33)

				local function var_15_36()
					local var_22_0 = "select_off.png"

					if self.manager:getFilterState(self.manager.FilterRule[self.manager.CustomSkinTypeStr .. var_15_29[var_15_34].group]) == self.manager.FilterState.On then
						var_22_0 = "select_on.png"
					end

					var_15_35:loadTextureNormal(var_0_3 .. var_22_0, var_0_2)
					var_15_35:loadTexturePressed(var_0_3 .. var_22_0, var_0_2)
					var_15_35:loadTextureDisabled(var_0_3 .. var_22_0, var_0_2)
				end

				var_15_35.updateTexture = var_15_36

				var_15_36()
				var_15_35:align(cc.p(0, 0.5), 10 + (iter_15_4 - 1) * ((var_15_2 - var_15_35:size().w * var_0_7) / (var_0_7 - 1) + var_15_35:size().w), var_15_33:size().h / 2)
				var_15_35:_addEvent(function()
					self.manager:setFilterStateReverse(self.manager.FilterRule[self.manager.CustomSkinTypeStr .. var_15_29[var_15_34].group])
					var_15_36()
					self:updateFilterBtn()
					self:updateTableView()
					self:updateNoHaveBg()
				end)

				local var_15_37 = TempWidget:CreateTempLabel(var_15_29[iter_15_4 + (iter_15_3 - 1) * var_0_7].groupName, FONT_W5, 19)

				var_15_35:addChild(var_15_37)
				var_15_37:move(var_15_35:size().w / 2, var_15_35:size().h / 2)
				table.insert(self.skinTypeFilterBtnTable, var_15_35)
			else
				break
			end
		end

		var_15_32:pushBackCustomItem(var_15_33)
	end

	local var_15_38 = TempWidget:CreateTempBtn(var_0_3 .. "sure_btn.png", self.filterBg)

	var_15_38:move(self.filterBg:size().w * 0.7, var_15_32:getPositionY() - var_15_32:size().h - 50)
	var_15_38:_addEvent(function()
		var_15_0:hide()
	end)

	local var_15_39 = TempWidget:CreateTempBtn(var_0_3 .. "cancel_btn.png", self.filterBg)

	var_15_39:move(self.filterBg:size().w * 0.3, var_15_32:getPositionY() - var_15_32:size().h - 50)
	var_15_39:_addEvent(function()
		if not self.manager:checkFilterStateIsSame(self.oldFilterState) then
			self.manager:setFilterStateTable(self.oldFilterState)

			for iter_25_0 = 1, #self.skinTypeFilterBtnTable do
				self.skinTypeFilterBtnTable[iter_25_0].updateTexture()
			end

			var_15_8()
			var_15_25()
			self:updateCheckL2dBtn()
			self:updateCheckHaveBtn()
			self:updateFilterBtn()
			self:updateTableView()
			self:updateNoHaveBg()
		else
			var_15_0:hide()
		end
	end)
end

function CostumeRoomLayer:updateCheckL2dBtn()
	if self.manager:getFilterState(self.manager.FilterRule.Live2D) == self.manager.FilterState.On then
		self.checkL2dBtn:loadTextureNormal(var_0_3 .. "check_l2d_on.png", var_0_2)
	else
		self.checkL2dBtn:loadTextureNormal(var_0_3 .. "check_l2d_off.png", var_0_2)
	end
end

function CostumeRoomLayer:updateCheckHaveBtn()
	if self.manager:getSkinState(self.manager.FilterRule.SkinState) == self.manager.FilterState.On then
		self.checkHaveBtn:loadTextureNormal(var_0_3 .. "check_have_on.png", var_0_2)
	else
		self.checkHaveBtn:loadTextureNormal(var_0_3 .. "check_have_off.png", var_0_2)
	end
end

function CostumeRoomLayer:updateFilterBtn()
	if self.manager:checkFilter() then
		self.filterBtn:loadTexture(var_0_3 .. "filter_on.png", var_0_2)
	else
		self.filterBtn:loadTexture(var_0_3 .. "filter_off.png", var_0_2)
	end
end

function CostumeRoomLayer:updateNoHaveBg()
	self.noHaveBg:hide()

	if self.manager:checkFilter() then
		if #self.showData == 0 then
			self.noHaveBg:show()
		else
			self.noHaveBg:hide()
		end
	end
end

function CostumeRoomLayer:updateTableView()
	self.showData = self.manager:getAdaptiveFilterShowSkin()

	if self.tableView then
		self.tableView:reloadData()

		return
	end

	local var_30_0 = {
		size = cc.size(var_0_4, self.checkHaveBtn:getPositionY() - self.backBg:size().h - 10),
		cellSizeForTable = function(arg_31_0, arg_31_1)
			if self.showData[arg_31_1 + 1].bTitle then
				return var_0_4, var_0_5
			else
				return var_0_4, var_0_6
			end
		end,
		tableCellAtIndex = function(self, arg_32_1)
			local var_32_0 = self:dequeueCell()

			if not var_32_0 then
				var_32_0 = cc.TableViewCell:new()
			else
				var_32_0:removeAllChildren()
			end

			var_32_0:addChild((self:createCell(arg_32_1 + 1)))

			return var_32_0
		end,
		numberOfCellsInTableView = function(arg_33_0)
			return #self.showData
		end
	}
	local var_30_1 = TempWidget:CreateTempLayout(self.bg)

	var_30_1:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))

	local var_30_2 = TableViewEx:create(var_30_0)

	var_30_2:setPosition(cc.p(0, self.backBg:size().h))
	var_30_1:addChild(var_30_2)

	self.tableView = var_30_2

	if var_0_8 then
		self.tableView:setContentOffset(var_0_8)
	end

	local var_30_3 = TempWidget:CreateTempLayout(var_30_1)

	var_30_3:setContentSize(cc.size(var_0_4, self.backBg:getContentSize().height))
	var_30_3:_addEvent(function()
		return
	end)

	local var_30_4 = TempWidget:CreateTempLayout(var_30_1)

	var_30_4:setContentSize(cc.size(var_0_4, GameDisplay.height - self.checkHaveBtn:getPositionY()))
	var_30_4:_addEvent(function()
		return
	end)
	var_30_4:align(cc.p(0, 1), 0, GameDisplay.height)
end

function CostumeRoomLayer:createCell(arg_36_1)
	local var_36_0 = TempWidget:CreateTempLayout()

	if self.showData[arg_36_1].bTitle then
		var_36_0:setContentSize(cc.size(var_0_4, var_0_5))

		if self.showData[arg_36_1].specialHeader then
			TempWidget:CreateTempImg(self.showData[arg_36_1].specialHeader, var_36_0):move(var_36_0:size().w / 2, var_36_0:size().h / 2)
		else
			local var_36_1 = TempWidget:CreateTempImg(var_0_3 .. "group_title.png", var_36_0)

			var_36_1:align(cc.p(0.5, 0.5), var_36_0:size().w / 2, var_36_0:size().h / 2 - 20)

			local var_36_2 = TempWidget:CreateTempLabel(self.showData[arg_36_1].titleName, FONT_W5, 24)

			var_36_2:align(cc.p(0, 0), var_36_1:getPositionX() - var_36_1:size().w / 2, var_36_1:getPositionY() + var_36_1:size().h / 2)
			var_36_0:addChild(var_36_2)

			local var_36_3 = TempWidget:CreateTempLabel(self.showData[arg_36_1].haveSkinNum .. "/" .. self.showData[arg_36_1].allSkinNum, FONT_W5, 22)

			var_36_3:align(cc.p(1, 0), var_36_0:size().w - 10, var_36_1:getPositionY() + var_36_1:size().h / 2 - 3)
			var_36_0:addChild(var_36_3)
		end
	else
		var_36_0:setContentSize(cc.size(var_0_4, var_0_6))

		local var_36_4 = self.showData[arg_36_1]
		local var_36_5 = var_36_0:size().w - 10 * 2

		for iter_36_0 = 1, #self.showData[arg_36_1] do
			local var_36_6 = TempWidget:CreateTempImg(var_0_3 .. "roleBg.png", var_36_0)
			local var_36_7 = TempWidget:CreateTempBtn(self.showData[arg_36_1][iter_36_0].iconPath, var_36_0, 0)

			var_36_7:setScale(0.75)
			var_36_7:loadTexturePressed(self.showData[arg_36_1][iter_36_0].iconPath, 0)
			var_36_7:loadTextureDisabled(self.showData[arg_36_1][iter_36_0].iconPath, 0)

			local var_36_8 = (var_36_5 - var_36_7:size().w * 0.75 * var_0_7) / (var_0_7 - 1)

			var_36_7:setSwallowTouches(false)
			var_36_7:align(cc.p(0, 0.5), 10 + (iter_36_0 - 1) * (var_36_7:size().w * 0.75 + var_36_8), var_36_0:size().h / 2)
			var_36_7:_addSuperEvent(function(arg_37_0, arg_37_1, arg_37_2)
				if arg_37_0 == TempWidget.Click then
					var_0_8 = self.tableView:getContentOffset()

					LayerManager:switchShowLayer("SkinShowPopLayer", {
						modelId = var_36_4[iter_36_0].modelId
					})
				end
			end)
			var_36_6:align(cc.p(0, 0.5), var_36_7:getPositionX(), var_36_7:getPositionY())

			local var_36_10 = TempWidget:CreateTempImg(var_0_3 .. ((self.showData[arg_36_1][iter_36_0].haveNum < 1 and self.showData[arg_36_1][iter_36_0].uncolorClothesHaveNum < 1 or nil) and "skin_name_off.png"), var_36_7)

			var_36_10:setScale(1.4)
			var_36_10:align(cc.p(0.5, 0), var_36_7:size().w / 2, 0)

			local var_36_11 = TempWidget:CreateTempLabel(self.showData[arg_36_1][iter_36_0].name, FONT_W5, 18)

			var_36_10:addChild(var_36_11)
			var_36_11:align(cc.p(0.5, 0.5), var_36_10:size().w / 2 - 8, var_36_10:size().h / 2 - 14)

			if self.showData[arg_36_1][iter_36_0].labelStr then
				local var_36_12 = TempWidget:CreateTempImg(var_0_3 .. "rect.png", var_36_7)

				var_36_12:align(cc.p(0, 1), 0, var_36_7:size().h)

				local var_36_13 = TempWidget:CreateTempLabel(self.showData[arg_36_1][iter_36_0].labelStr, FONT_W5, 14)

				var_36_12:addChild(var_36_13)
				var_36_12:setScale(1 / 0.75 * 1.3)
				var_36_13:move(var_36_12:size().w / 2, var_36_12:size().h / 2)
			end

			if self.showData[arg_36_1][iter_36_0].bLive2d then
				local var_36_14 = TempWidget:CreateTempImg(var_0_3 .. "live2d_sign.png", var_36_7)

				var_36_14:align(cc.p(0.5, 0.5), var_36_7:size().w - 20, var_36_7:size().h - 20)
				var_36_14:setScale(1 / 0.75)
			elseif self.showData[arg_36_1][iter_36_0].bRoleSpine then
				local var_36_15 = TempWidget:CreateTempImg(var_0_3 .. "dynamic.png", var_36_7)

				var_36_15:align(cc.p(0.5, 0.5), var_36_7:size().w - 20, var_36_7:size().h - 20)
				var_36_15:setScale(1 / 0.75)
			end
		end
	end

	var_36_0:setOpacity(0)
	var_36_0:runAction(cc.FadeIn:create(0.1))

	return var_36_0
end

function CostumeRoomLayer:updateLayer()
	self.showData = self.manager:getAdaptiveFilterShowSkin()

	self.tableView:reloadData()

	if var_0_8 then
		self.tableView:setContentOffset(var_0_8)
	end
end

function CostumeRoomLayer:updateRed()
	if require("controller.costume_room_cumulative_reward_manager"):getInstance():checkRed() then
		self.rewardLayerBtnRedImg:show()
	else
		self.rewardLayerBtnRedImg:hide()
	end
end

return CostumeRoomLayer
