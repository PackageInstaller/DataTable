require("view.Layer.LevelMapLayer")

function LevelMapLayer.only_create(arg_1_0, arg_1_1)
	return (LevelMapLayer.new())
end

LevelMapSingleLayer = class("LevelMapSingleLayer", function(...)
	return (LevelMapLayer:only_create(...))
end)

local patrol_manager = require("controller.patrol_manager")
local level_manager = require("controller.level_manager")
local var_0_2 = config._DEBUG and 0 or 1

function LevelMapSingleLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = LevelMapSingleLayer.new(arg_3_1)

	var_3_0:init(arg_3_1)

	return var_3_0
end

function LevelMapSingleLayer:init(arg_4_1)
	self:setInstance()

	self._playingani = false

	if arg_4_1 then
		self.initcity = arg_4_1.initcity
		self.initdifficulty = arg_4_1.initdifficulty
		self.jumpselet = arg_4_1.jumpselet
		self.hideBottomBtn = arg_4_1.hideBottomBtn
	end

	patrol_manager:reset()
	self:initTimers()
	level_manager:getModesLockState(function()
		self:initBasicUILayer()
		self:initListView()
		self:initCityMapLayer()
		self:initChangeBnt()
		self:playInitShowAni()
		self:fullScreen()
		self:initOther(arg_4_1)
	end)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			self.setInstance(nil)
		end
	end)
end

function LevelMapSingleLayer:playExitAni()
	self.maplayer:runAction(cc.MoveBy:create(0.4, cc.p(0, 8)))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		if self.hideBottomBtn then
			KeyCodeManager:onKeyReleasedCallFunc()
		else
			LayerManager:switchShowLayer("LevelMapBoxLayer")
		end
	end)))
end

function LevelMapSingleLayer.updateCityOnSelect(arg_9_0, ...)
	return
end

function LevelMapSingleLayer:initOther(arg_10_1)
	self.curcity = arg_10_1.cityid

	self:updateMapJsonInfo()
	self:updateCityOnSelect(self.curcity)
	self:cleanAllTimers()
	self:updateUIInfos()
	self:updateCityMapLayer()
	self.cityList:setVisible(false)
	self.cityList:registerSelectCityHandler(function(arg_11_0)
		return
	end)
	self.branchBnt:loadTextures("LevelMap/btn_branch_off.png", "", "LevelMap/btn_branch_off.png", var_0_2)
	self.branchBnt:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("LevelMapBoxLayer")
	end)
	self.mainBtn:loadTextures("LevelMap/goto_main.png", "", "LevelMap/goto_main.png", var_0_2)
	self.mainBtn:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("LevelMapLayer")
	end)
	self:getChildByName("left_tag"):setVisible(false)
	self:getChildByName("right_tag"):setVisible(false)

	if self.hideBottomBtn then
		self.branchBnt:setVisible(false)
		self.changeBnt:setVisible(false)
		self.mainBtn:setVisible(false)
	end
end
