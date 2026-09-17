ThreeVsThreeHistoryLayer = class("ThreeVsThreeHistoryLayer", (require("view.Layer.BaseUILayer")))

local QuickCell = require("view.Sprite.QuickCell")

require("view.Sprite.AvatarSprite")

local TempWidget = require("view.Sprite.TempWidget")
local var_0_2 = config._DEBUG and 0 or 1
local var_0_3 = "ThreeVsThreeHistoryLayer/"
local var_0_4 = string.split

function ThreeVsThreeHistoryLayer:ctor()
	ThreeVsThreeHistoryLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller.three_vs_three_history_manager"):getInstance()
end

function ThreeVsThreeHistoryLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ThreeVsThreeHistoryLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function ThreeVsThreeHistoryLayer:onEnter()
	ThreeVsThreeHistoryLayer.super.onEnter(self)
	self:showOpnAction()
	self.manager:requestInfo()
end

function ThreeVsThreeHistoryLayer.onExit(arg_4_0)
	ThreeVsThreeHistoryLayer.super.onExit(arg_4_0)
end

function ThreeVsThreeHistoryLayer:init(arg_5_1)
	self:initLayer()
	self:initListener()

	return true
end

function ThreeVsThreeHistoryLayer:initLayer()
	local var_6_0 = TempWidget:CreateTempLayout(self)

	var_6_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_6_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_6_0:setBackGroundColorOpacity(150)
	var_6_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_6_0:center()
	var_6_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_6_0

	local var_6_1 = TempWidget:CreateTempImg(var_0_3 .. "bg.png", var_6_0)

	var_6_1:align(cc.p(0.5, 0.5), var_6_0:size().w / 2, var_6_0:size().h * 0.55)

	self.bg = var_6_1

	self:initFrontLayout()
	self:initListView()
	self:initSeasonView()
end

function ThreeVsThreeHistoryLayer:initFrontLayout()
	self.frontWidget = {}

	local var_7_0 = TempWidget:CreateTempLayout(self.bg)

	var_7_0:setLocalZOrder(10)
	var_7_0:setContentSize(cc.size(self._root:size().w, 480))
	var_7_0:align(cc.p(0.5, 1), self.bg:size().w / 2, self.bg:size().h - 70)
	var_7_0:_addEvent(function()
		return
	end)

	local var_7_1 = {
		{
			rankFontSize = 17,
			pos = cc.p(var_7_0:size().w / 2, var_7_0:size().h * 0.75),
			bgPath = var_0_3 .. "rank1_bg.png",
			rankFontColor = cc.c4b(94, 32, 32, 255)
		},
		{
			rankFontSize = 20,
			pos = cc.p(var_7_0:size().w * 0.2, var_7_0:size().h * 0.25),
			bgPath = var_0_3 .. "rank_2-3_bg.png",
			rankFontColor = cc.c4b(98, 70, 15, 255)
		},
		{
			rankFontSize = 20,
			pos = cc.p(var_7_0:size().w * 0.8, var_7_0:size().h * 0.25),
			bgPath = var_0_3 .. "rank_2-3_bg.png",
			rankFontColor = cc.c4b(98, 70, 15, 255)
		}
	}

	for iter_7_0 = 1, #var_7_1 do
		local var_7_2 = TempWidget:CreateTempImg(var_7_1[iter_7_0].bgPath, var_7_0)

		var_7_2:move(var_7_1[iter_7_0].pos)

		local var_7_3 = TempWidget:CreateTempLayout(var_7_2)

		var_7_3:setContentSize(cc.size(98, 90))
		var_7_3:setClippingEnabled(true)
		var_7_3:align(cc.p(0.5, 0.5), var_7_2:size().w / 2, var_7_2:size().h * 0.662)

		local var_7_4 = TempWidget:CreateTempLabel("999", FONT_W5, 17, var_7_2)

		var_7_4:move(cc.p(var_7_2:size().w / 2, var_7_2:size().h * 0.43))

		local var_7_5 = TempWidget:CreateTempLabel(iter_7_0, FONT_W5, var_7_1[iter_7_0].rankFontSize, var_7_2)

		var_7_5:setTextColor(var_7_1[iter_7_0].rankFontColor)
		var_7_5:move(cc.p(var_7_2:size().w / 2, var_7_2:size().h * 0.3))

		self.frontWidget[iter_7_0] = {}
		self.frontWidget[iter_7_0].headLayout = var_7_3
		self.frontWidget[iter_7_0].nameText = var_7_4
	end
end

function ThreeVsThreeHistoryLayer:initListView()
	local var_9_0 = TempWidget:CreateTempListView(self.bg)

	var_9_0:setContentSize(cc.size(self._root:size().w - 55, 278))
	var_9_0:align(cc.p(0.5, 0), self.bg:size().w / 2, 72)

	self.listView = var_9_0

	local var_9_1 = cc.size(var_9_0:size().w, 110)

	local function var_9_2(arg_10_0)
		local var_10_0 = self.manager:getSeasonInfoByRank(arg_10_0)
		local var_10_1 = TempWidget:CreateTempLayout()

		var_10_1:setContentSize(var_9_1)

		local var_10_2 = TempWidget:CreateTempImg(var_0_3 .. "rank_4-10_bg.png", var_10_1)

		var_10_2:center()
		var_10_2:setName("bg")

		if var_10_0 then
			local var_10_3 = AvatarSprite:create(var_10_0.head_sculpture)

			var_10_3:setScale(0.5)
			var_10_3:setName("avatar")
			var_10_3:addTouchEventListener(function(arg_11_0, arg_11_1)
				if arg_11_1 ~= ccui.TouchEventType.ended then
					return
				end

				local var_11_0

				if math.abs(arg_11_0:getTouchBeganPosition().y - arg_11_0:getTouchEndPosition().y) > 50 then
					do return end

					var_11_0 = {
						pvptype = 3,
						playeruid = var_10_0.playerid
					}
				end

				function var_11_0.callback()
					return
				end

				LayerManager:pushInLayer("PopFriendIntroduceLayer", var_11_0)
			end)
			var_10_3:setPosition(cc.p(50, 5))
			var_10_2:addChild(var_10_3)
		end

		local var_10_5 = TempWidget:CreateTempLabel((var_10_0 or nil) and var_10_0.name, FONT_W5, 18)

		var_10_5:setName("nameText")
		var_10_2:addChild(var_10_5)
		var_10_5:_setColor("8CA0AB")
		var_10_5:move(cc.p(var_10_2:size().w / 2, var_10_2:size().h / 2))

		local var_10_6 = TempWidget:CreateTempLabel(arg_10_0, FONT_W5, 20)

		var_10_6:_setColor("51227E")
		var_10_2:addChild(var_10_6)
		var_10_6:move(var_10_2:size().w - 72, var_10_2:size().h / 2 + 5)

		return var_10_1
	end

	for iter_9_0 = 4, self.manager.LookNum do
		var_9_0:pushBackCustomItem((QuickCell:Create({
			wid = var_9_1.width,
			hei = var_9_1.height,
			createCell = function()
				return var_9_2(iter_9_0)
			end
		})))
	end
end

function ThreeVsThreeHistoryLayer:initSeasonView()
	local var_14_0 = TempWidget:CreateTempListView(self.bg)

	var_14_0:setDirection(ccui.ListViewDirection.horizontal)
	var_14_0:setContentSize(cc.size(self._root:size().w, 60))
	var_14_0:align(cc.p(0.5, 0), self.bg:size().w / 2, 5)

	self.seasonView = var_14_0
end

function ThreeVsThreeHistoryLayer:initListener()
	self._root:_addEvent(function()
		self:showCloseAction(function()
			KeyCodeManager:onKeyReleasedCallFunc()
		end)
	end)
	self.bg:_addEvent(function()
		return
	end)
end

function ThreeVsThreeHistoryLayer:showOpnAction()
	self.bg:stopAllActions()
	self.bg:setScaleY(0.5)
	self.bg:runAction(cc.ScaleTo:create(0.1, 1, 1))
end

function ThreeVsThreeHistoryLayer:showCloseAction(arg_20_1)
	self.bg:stopAllActions()
	self.bg:setScaleY(1)
	self.bg:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 0.01), cc.CallFunc:create(function()
		if arg_20_1 then
			arg_20_1()
		end
	end)))
end

function ThreeVsThreeHistoryLayer:updateLayer()
	self:updateSeasonView()
end

function ThreeVsThreeHistoryLayer.updateRed(arg_23_0)
	return
end

function ThreeVsThreeHistoryLayer:updateFrontLayout()
	local var_24_0 = self.manager:getSeasonInfo()

	for iter_24_0 = 1, #self.frontWidget do
		self.frontWidget[iter_24_0].headLayout:removeAllChildren()

		local var_24_1 = AvatarSprite:create(var_24_0[iter_24_0].head_sculpture)

		var_24_1:setScale(0.5)
		var_24_1:addTouchEventListener(function(arg_25_0, arg_25_1)
			if arg_25_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_25_0

			if math.abs(arg_25_0:getTouchBeganPosition().y - arg_25_0:getTouchEndPosition().y) > 50 then
				do return end

				var_25_0 = {
					pvptype = 3,
					playeruid = var_24_0[iter_24_0].playerid
				}
			end

			function var_25_0.callback()
				return
			end

			LayerManager:pushInLayer("PopFriendIntroduceLayer", var_25_0)
		end)
		self.frontWidget[iter_24_0].headLayout:addChild(var_24_1)
		self.frontWidget[iter_24_0].nameText:setString(var_24_0[iter_24_0].name)
	end
end

function ThreeVsThreeHistoryLayer:updateListView()
	local var_27_0 = self.listView:getItems()
	local var_27_1 = cc.size(self.listView:size().w, 110)
	local var_27_2 = self.manager:getSeasonInfo()

	for iter_27_0 = 4, #var_27_2 do
		if var_27_0[iter_27_0 - 3]:IsEnter() then
			local var_27_3 = ui_delegate(var_27_0[iter_27_0 - 3])

			var_27_3.nameText:setString(var_27_2[iter_27_0].name)
			var_27_3.bg:removeChildByName("avatar")

			local var_27_4 = AvatarSprite:create(var_27_2[iter_27_0].head_sculpture)

			var_27_4:setScale(0.5)
			var_27_4:setName("avatar")
			var_27_4:addTouchEventListener(function(arg_28_0, arg_28_1)
				if arg_28_1 ~= ccui.TouchEventType.ended then
					return
				end

				local var_28_0

				if math.abs(arg_28_0:getTouchBeganPosition().y - arg_28_0:getTouchEndPosition().y) > 50 then
					do return end

					var_28_0 = {
						pvptype = 3,
						playeruid = var_27_2[iter_27_0].playerid
					}
				end

				function var_28_0.callback()
					return
				end

				LayerManager:pushInLayer("PopFriendIntroduceLayer", var_28_0)
			end)
			var_27_4:setPosition(cc.p(50, 5))
			var_27_3.bg:addChild(var_27_4)
		end
	end
end

function ThreeVsThreeHistoryLayer:updateSeasonView()
	self.seasonView:removeAllItems()

	local var_30_0 = self.manager:getSeasonIdTable()
	local var_30_1 = self.manager:getSeasonId()
	local var_30_2 = cc.size(150, self.seasonView:size().h)

	local function var_30_3(arg_31_0)
		local var_31_0 = TempWidget:CreateTempLayout()

		var_31_0:setContentSize(var_30_2)

		local var_31_2 = TempWidget:CreateTempBtn((var_30_0[arg_31_0].id == var_30_1 or nil) and var_0_3 .. "btn_on.png", var_31_0)

		var_31_2:setName("btn")
		var_31_2:center()
		var_31_2:_addEvent(function()
			if self.manager:getSeasonId() ~= var_30_0[arg_31_0].id then
				self.manager:requestSeasonRankInfo(var_30_0[arg_31_0].id)
			end
		end)

		var_31_2._childData = {}

		local var_31_3 = "7A7979"
		local var_31_4 = "8CA0AB"

		if var_30_0[arg_31_0].id == var_30_1 then
			var_31_3 = "ABABAB"
			var_31_4 = "DEF4FF"
		end

		local var_31_5 = var_0_4(var_0_4(var_30_0[arg_31_0].starttime, " ")[1], "-")
		local var_31_6 = var_0_4(var_0_4(var_30_0[arg_31_0].finishtime, " ")[1], "-")
		local var_31_7 = TempWidget:CreateTempLabel((var_31_5[1] .. "." .. var_31_5[2]) .. "-" .. var_31_6[1] .. "." .. var_31_6[2], FONT_W5, 18, var_31_2)

		var_31_7:_setColor(var_31_3)
		var_31_7:align(cc.p(0.5, 0), var_31_2:size().w / 2, var_31_2:size().h * 0.1)

		var_31_2._childData.timeText = var_31_7

		local var_31_8 = TempWidget:CreateTempLabel("赛季" .. var_30_0[arg_31_0].id, FONT_W5, 18, var_31_2)

		var_31_8:_setColor(var_31_4)
		var_31_8:align(cc.p(0.5, 1), var_31_2:size().w / 2, var_31_2:size().h * 0.9)

		var_31_2._childData.seasonNameText = var_31_8

		return var_31_0
	end

	for iter_30_0 = 1, #var_30_0 do
		self.seasonView:pushBackCustomItem((QuickCell:Create({
			wid = var_30_2.width,
			hei = var_30_2.height,
			createCell = function()
				return var_30_3(iter_30_0)
			end
		})))
	end
end

function ThreeVsThreeHistoryLayer:updateSeasonId()
	self:updateSeasonViewSelect()
	self:updateFrontLayout()
	self:updateListView()
end

function ThreeVsThreeHistoryLayer:updateSeasonViewSelect()
	local var_35_0 = self.seasonView:getItems()
	local var_35_1 = self.manager:getSeasonId()
	local var_35_2 = self.manager:getSeasonIdTable()

	for iter_35_0 = 1, #var_35_0 do
		if var_35_0[iter_35_0]:IsEnter() then
			local var_35_3 = ui_delegate(var_35_0[iter_35_0]).btn

			var_35_3:loadTextureNormal((var_35_2[iter_35_0].id == var_35_1 or nil) and var_0_3 .. "btn_on.png", var_0_2)

			local var_35_5 = "7A7979"
			local var_35_6 = "8CA0AB"

			if var_35_2[iter_35_0].id == var_35_1 then
				var_35_5 = "ABABAB"
				var_35_6 = "DEF4FF"
			end

			var_35_3._childData.timeText:_setColor(var_35_5)
			var_35_3._childData.seasonNameText:_setColor(var_35_6)
		end
	end
end

return ThreeVsThreeHistoryLayer
