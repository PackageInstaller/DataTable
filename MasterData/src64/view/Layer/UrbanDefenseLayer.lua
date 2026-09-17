local UrbanDefenseLayer = class("UrbanDefenseLayer", (require("view.Layer.BaseUILayer")))
local TempWidget = require("view.Sprite.TempWidget")
local var_0_2 = config._DEBUG and 0 or 1
local var_0_3 = "UrbanDefenseLayer_%s/"
local texture_manager = require("controller.texture_manager")
local var_0_5 = require("controller/urban_defense_achievement_manager"):getInstance()

function UrbanDefenseLayer:ctor()
	UrbanDefenseLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller/urban_defense_manager"):getInstance()
end

function UrbanDefenseLayer:create(arg_2_1)
	local var_2_0 = UrbanDefenseLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function UrbanDefenseLayer:onEnter()
	UrbanDefenseLayer.super.onEnter(self)
	self.manager:setActivityId(self._id)
	self.manager:requestInfo()
	self.manager:registerStaticNotification("TowerDefenceSuccess", function(arg_4_0)
		require("controller/urban_defense_manager"):getInstance():towerDefenceSuccess(arg_4_0)
	end)
	self.manager:registerNotification("ActivityCityDefinedWin", function(arg_5_0)
		self:activityCityDefinedWin()
	end)
end

function UrbanDefenseLayer:onExit()
	UrbanDefenseLayer.super.onExit(self)

	if not config._DEBUG then
		texture_manager:removeLayerTextures({
			"UrbanDefenseLayer_" .. self._id
		})
		texture_manager:unloadPopLayerTextures()
	end
end

function UrbanDefenseLayer:init(arg_7_1)
	self:initData(arg_7_1)
	self:initLayer()
	self:initListener()

	return true
end

function UrbanDefenseLayer:initData(arg_8_1)
	self._id = arg_8_1.activityId
	var_0_3 = string.format(var_0_3, self._id)

	if not config._DEBUG then
		texture_manager:loadLayerTextures({
			"UrbanDefenseLayer_" .. self._id
		})
	end
end

function UrbanDefenseLayer:initLayer()
	local var_9_0 = TempWidget:CreateTempLayout(self)

	var_9_0:_setBack()
	var_9_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_9_0

	local var_9_1 = TempWidget:CreateTempImg("mainScenebg/urban_defense_bg_" .. self._id .. ".png", var_9_0, 0)

	var_9_1:center()

	function var_9_1.afterLoadSuccess()
		var_9_1:center()
	end

	var_9_1:_addEvent(function()
		return
	end)

	local var_9_2 = TempWidget:CreateTempImg(var_0_3 .. "top_bg.png", var_9_0)

	var_9_2:align(cc.p(0.5, 1), var_9_0:size().w / 2, var_9_0:size().h)

	local var_9_3 = TempWidget:CreateTempBtn(var_0_3 .. "title.png", var_9_2)

	var_9_3:align(cc.p(0, 0.5), 0, var_9_2:size().h / 2)

	self._titleBtn = var_9_3

	local var_9_4 = TempWidget:CreateTempImg(var_0_3 .. "bottom_bg.png", var_9_0)

	var_9_4:align(cc.p(0, 0), 0, 0)

	local var_9_5 = TempWidget:CreateTempLayout(var_9_4)

	var_9_5:setContentSize(cc.size(120, var_9_4:size().h))
	var_9_5:align(cc.p(0, 0), 0, 0)

	self._backBtn = var_9_5

	local var_9_6 = TempWidget:CreateTempBtn(var_0_3 .. "achievement_btn.png", var_9_4)

	var_9_6:align(cc.p(1, 0), var_9_4:size().w - 20, 5)
	var_9_6:setVisible(false)

	self._achievementBtn = var_9_6

	local var_9_7 = var_9_2:pos().y - var_9_2:size().h - var_9_4:size().h - 60

	print("height   " .. var_9_7)

	local var_9_8 = TempWidget:CreateTempLayout(var_9_0)

	var_9_8:setContentSize(cc.size(var_9_0:size().w, var_9_7))
	var_9_8:align(cc.p(0, 0), 0, var_9_4:size().h + 30)

	self._cityLayout = var_9_8

	self:initCityLayout()

	local var_9_9 = TempWidget:CreateTempBtn(var_0_3 .. "shop_btn.png", var_9_0)

	var_9_9:align(cc.p(1, 0), var_9_0:size().w - 20, var_9_4:size().h)

	self._shopBtn = var_9_9
end

function UrbanDefenseLayer:initListener()
	self._titleBtn:_addEvent(function()
		LayerManager:pushInLayer("PopActivityDetail", {
			key = "Activity_urbandefense_" .. self._id
		})
	end)
	self._backBtn:_addEvent(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self._achievementBtn:_addEvent(function()
		if var_0_5:haveData() then
			LayerManager:pushInLayer("UrbanDefenseAchievementLayer", {
				activityId = self._id
			})
		end
	end)
	self._shopBtn:_addEvent(function()
		LayerManager:switchShowLayer("ActivityMultiPtLayer", {
			activityId = self._id
		})
	end)
end

function UrbanDefenseLayer:initCityLayout()
	local var_17_9000
	local var_17_0 = self._cityLayout:size().w
	local var_17_1 = self._cityLayout:size().h
	local var_17_2
	local var_17_3 = {}

	self._cityBtnTable = {}

	for iter_17_0 = 1, 7 do
		local var_17_4 = TempWidget:CreateTempBtn(var_0_3 .. iter_17_0 .. "_" .. 1 .. ".png", self._cityLayout)

		if not var_17_2 then
			local var_17_5 = var_17_4:size().w
			local var_17_6 = var_17_4:size().h

			var_17_2 = var_17_9000 + var_17_6

			local var_17_7 = {
				30,
				var_17_0 / 2 - var_17_5 / 2,
				var_17_0 - var_17_5 - 30
			}
			local var_17_8 = setmetatable({}, {
				__index = function(arg_18_0, arg_18_1)
					rawset(arg_18_0, arg_18_1, var_17_1 - var_17_2 * (arg_18_1 - 1))

					return var_17_1 - var_17_2 * (arg_18_1 - 1)
				end
			})

			var_17_3[1] = cc.p(((var_17_1 - var_17_6 * 6) / 5)[1], var_17_8[1])
			var_17_3[2] = cc.p(var_17_7[3], var_17_8[1])
			var_17_3[3] = cc.p(var_17_7[2], var_17_8[2])
			var_17_3[4] = cc.p(var_17_7[3], var_17_8[3])
			var_17_3[5] = cc.p(var_17_7[1], var_17_8[4])
			var_17_3[6] = cc.p(var_17_7[3], var_17_8[5])
			var_17_3[7] = cc.p(var_17_7[1], var_17_8[6])
		end

		var_17_4:align(cc.p(0, 1), var_17_3[iter_17_0].x, var_17_3[iter_17_0].y)
		var_17_4:_addEvent(function()
			self.manager:requestBegin(iter_17_0)
		end)

		self._cityBtnTable[iter_17_0] = var_17_4
	end
end

function UrbanDefenseLayer:updateLayer()
	self:updateCityBtns()
end

function UrbanDefenseLayer:updateCityBtns()
	for iter_21_0 = 1, #self._cityBtnTable do
		local var_21_0 = self.manager:getStatus(iter_21_0)

		self._cityBtnTable[iter_21_0]:loadTextures(var_0_3 .. iter_21_0 .. "_" .. var_21_0 .. ".png", nil, var_0_3 .. iter_21_0 .. "_" .. var_21_0 .. ".png", var_0_2)
	end
end

function UrbanDefenseLayer:updateRed()
	return
end

function UrbanDefenseLayer:activityCityDefinedWin()
	self:updateCityBtns()
end

return UrbanDefenseLayer
