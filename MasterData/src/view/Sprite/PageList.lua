local var_0_0 = math.abs
local var_0_1 = math.pow
local var_0_3 = math.min
local tween = require("fight.tween")
local PageList = class("PageList", function()
	return ccui.Layout:create()
end)
local var_0_6 = 130
local var_0_7 = 60
local var_0_8 = 100
local var_0_9 = 1000

function PageList:setPageListGap(arg_2_1)
	var_0_6 = arg_2_1
end

function PageList:create()
	local var_3_0 = PageList.new()

	var_3_0:init()

	return var_3_0
end

function PageList:ctor()
	self:setContentSize(cc.size(528, 140))
	self:setPosition(cc.p(112, 64))
	self:setTouchEnabled(false)

	self._initposy = 0
	self._container = nil
	self._curselected = nil
	self._slidtime = 0
	self._pressed = false
	self._is_quick_slide = false
	self._is_open_style1 = false
	self._autoscroll = false
	self._autoscrollaction = nil
	self._autoscrollpos = nil
	self._scrollEnabled = true
	self._cities = {}
	self._selectcityHandler = nil
end

function PageList:init()
	self:initInnerContainer()
	self:registerTouchEvent()
	self:registerUpdateEvent()
end

function PageList:setCityInitPosY(arg_6_1)
	self._initposy = arg_6_1
end

function PageList:initInnerContainer()
	self._container = cc.Node:create()

	self._container:setPosition(cc.p(0, 0))
	self:addChild(self._container, -1)
end

function PageList:registerUpdateEvent()
	self:scheduleUpdateWithPriorityLua(function(arg_9_0)
		self:autoScroll(arg_9_0)
		self:recordSlidTime(arg_9_0)
	end, 0)
end

local function var_0_10(arg_10_0)
	if not arg_10_0 then
		return true
	end

	local var_10_0 = arg_10_0:getParent()

	if var_10_0 and not var_10_0:isVisible() then
		return false
	end

	return var_0_10(var_10_0)
end

function PageList:registerTouchEvent()
	local var_11_0 = cc.EventListenerTouchOneByOne:create()

	var_11_0:setSwallowTouches(false)
	var_11_0:registerScriptHandler(function(arg_12_0, arg_12_1)
		if not self:checkTouchEnabled() then
			return false
		end

		if not var_0_10(self) then
			return false
		end

		if cc.rectContainsPoint(cc.rect(0, 64, 640, 140), (arg_12_0:getLocation())) then
			self:handlePressLogic(arg_12_0)

			return true
		else
			return false
		end
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_11_0:registerScriptHandler(function(arg_13_0, arg_13_1)
		if not self:checkTouchEnabled() then
			return
		end

		self:handleMoveLogic(arg_13_0)
	end, cc.Handler.EVENT_TOUCH_MOVED)
	var_11_0:registerScriptHandler(function(arg_14_0, arg_14_1)
		if not self:checkTouchEnabled() then
			return
		end

		self:handleReleaseLogic(arg_14_0)
	end, cc.Handler.EVENT_TOUCH_ENDED)
	var_11_0:registerScriptHandler(function(arg_15_0, arg_15_1)
		self:handleReleaseLogic(arg_15_0)
	end, cc.Handler.EVENT_TOUCH_CANCELLED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_11_0, self)
end

function PageList:checkTouchEnabled()
	if not self._container then
		return false
	end

	if not self._curselected then
		return false
	end

	if not self._scrollEnabled then
		return false
	end

	if self._autoscroll then
		return false
	end

	return true
end

function PageList:handlePressLogic(arg_17_1)
	self:startRecordSlidAction()

	self._pressed = true
end

function PageList:handleMoveLogic(arg_18_1)
	local var_18_0 = arg_18_1:getLocation().x - arg_18_1:getPreviousLocation().x

	if self._is_quick_slide == false then
		self:scrollChildren(var_18_0)
	else
		self:endRecordSlidAction(var_18_0)
	end
end

function PageList:handleReleaseLogic(arg_19_1)
	if self._is_quick_slide == false then
		self:endRecordSlidAction(arg_19_1:getLocation().x - arg_19_1:getStartLocation().x)
	end

	self._pressed = false
end

function PageList:startRecordSlidAction()
	self._slidtime = 0
end

function PageList:endRecordSlidAction(arg_21_1)
	if self._slidtime <= 0.016 then
		self._slidtime = 0

		self:scrollToIndex(self._curselected)

		return
	end

	local var_21_0

	if arg_21_1 > 0 then
		var_21_0 = 1
	elseif arg_21_1 < 0 then
		var_21_0 = -1
	end

	if not var_21_0 then
		self._slidtime = 0

		self:scrollToIndex(self._curselected)

		return
	end

	if var_0_0(arg_21_1 + var_21_0 * (var_0_1(var_0_3(var_0_0(arg_21_1) / self._slidtime, var_0_9), 2) / 2000)) >= var_0_6 / 4 then
		self._slidtime = 0

		local var_21_1 = self._curselected - var_21_0

		if self._curselected - var_21_0 < 1 then
			var_21_1 = 1
		end

		if var_21_1 > #self._cities then
			var_21_1 = #self._cities
		end

		self:scrollToIndex(var_21_1)
	else
		self._slidtime = 0

		self:scrollToIndex(self._curselected)
	end
end

function PageList:recordSlidTime(arg_22_1)
	if self._pressed then
		self._slidtime = self._slidtime + arg_22_1
	end
end

function PageList:scrollChildren(arg_23_1)
	local var_23_0 = arg_23_1
	local var_23_1 = self._container:getPositionX()
	local var_23_2 = self:getScrollLeftBound()

	if var_23_2 < var_23_1 + arg_23_1 then
		var_23_0 = var_23_2 - var_23_1
	end

	local var_23_3 = self:getScrollRightBound()

	self:moveChildren((var_23_3 > var_23_1 + arg_23_1 or nil) and var_23_3 - var_23_1)
	self:endRecordSlidAction(arg_23_1)
end

function PageList:moveChildren(arg_24_1)
	if self._is_quick_slide == true then
		return
	end

	self._container:setPositionX(self._container:getPositionX() + arg_24_1)
	self:updateCitiesYZ()
end

function PageList:getScrollLeftBound()
	return (1 - ((self._curselected - 1 > 0 or nil) and (self._curselected - 1 or 1))) * var_0_6
end

function PageList:getScrollRightBound()
	return (1 - ((self._curselected + 1 <= #self._cities or nil) and (self._curselected + 1 or #self._cities))) * var_0_6
end

local var_0_11 = 22 / math.pow(130, 2)

local function var_0_12(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0:getPositionX() + arg_27_0:getParent():getPositionX()

	if var_27_0 <= -30 or var_27_0 >= 230 then
		if var_27_0 <= -30 then
			arg_27_0:setLocalZOrder(arg_27_1)
		else
			arg_27_0:setLocalZOrder(100 - arg_27_1)
		end

		arg_27_0:setPositionY(var_0_7)
	else
		if var_27_0 < 165 and var_27_0 > 35 then
			arg_27_0:setLocalZOrder(100)
		elseif var_27_0 >= 165 then
			arg_27_0:setLocalZOrder(100 - arg_27_1)
		elseif var_27_0 <= 35 then
			arg_27_0:setLocalZOrder(arg_27_1)
		end

		arg_27_0:setPositionY(var_0_7)
	end
end

function PageList:updateCitiesYZ()
	if self._is_quick_slide == false then
		for iter_28_0, iter_28_1 in ipairs(self._cities) do
			var_0_12(iter_28_1, iter_28_0)
		end
	else
		for iter_28_2, iter_28_3 in ipairs(self._cities) do
			var_0_12(iter_28_3, iter_28_2)
			iter_28_3:setPositionY(var_0_7 + self._initposy)
			iter_28_3:setLocalZOrder(100 - math.abs(self._curselected - iter_28_2))
		end
	end
end

function PageList:pushInCity(arg_29_1)
	arg_29_1:setPositionX(var_0_8 + (#self._cities + 1 - 1) * var_0_6)
	self._container:addChild(arg_29_1, 100 - (#self._cities + 1))
	var_0_12(arg_29_1, #self._cities + 1)

	if self._is_quick_slide == true then
		arg_29_1:setPositionY(var_0_7 + self._initposy)
	end

	self._cities[#self._cities + 1] = arg_29_1

	arg_29_1:setTag(#self._cities + 1)

	self._curselected = self._curselected or #self._cities + 1
end

function PageList:getCityByIndex(arg_30_1)
	return self._cities[arg_30_1]
end

function PageList:scrollToIndex(arg_31_1)
	arg_31_1 = arg_31_1 or 1

	local var_31_0 = (1 - arg_31_1) * var_0_6

	if self._is_quick_slide == true then
		var_31_0 = (1 - arg_31_1) * var_0_6 - 100
	end

	if var_0_0(var_31_0 - self._container:getPositionX()) <= var_0_6 / 10 then
		self._container:setPositionX(var_31_0)
		self:updateCitiesYZ()
	else
		self:startAutoScrollChildren(var_31_0)
	end

	self._curselected = arg_31_1

	if self._is_open_style1 == true then
		self:updateCitiesProperties()
	end

	if self._selectcityHandler then
		self._selectcityHandler(arg_31_1)
	end
end

function PageList:scrollToIndexManual(arg_32_1)
	if arg_32_1 == self._curselected then
		return
	end

	if not self:checkTouchEnabled() then
		return
	end

	self:scrollToIndex(arg_32_1)
end

function PageList:jumpToIndex(arg_33_1)
	arg_33_1 = arg_33_1 or 1

	self._container:setPositionX((self._is_quick_slide == true or nil) and (1 - arg_33_1) * var_0_6 - 100)
	self:updateCitiesYZ()

	self._curselected = arg_33_1

	if self._is_open_style1 == true then
		self:updateCitiesProperties()
	end

	if self._is_quick_slide == true and self._selectcityHandler then
		self._selectcityHandler(arg_33_1)
	end
end

function PageList:updateCitiesProperties()
	for iter_34_0 = 1, #self._cities do
		local var_34_0 = self._cities[iter_34_0]

		if math.abs(self._curselected - iter_34_0) == 2 then
			var_34_0:setScale(0.65)
			var_34_0:setOpacity(153)
		elseif math.abs(self._curselected - iter_34_0) == 1 then
			var_34_0:setScale(0.8)
			var_34_0:setOpacity(153)
		elseif self._curselected == iter_34_0 then
			var_34_0:setScale(1)
			var_34_0:setOpacity(255)
		else
			var_34_0:setScale(0.65)
			var_34_0:setOpacity(153)
		end

		var_34_0:setLocalZOrder(100 - math.abs(self._curselected - iter_34_0))
	end
end

function PageList:autoScroll(arg_35_1)
	if self._autoscroll then
		if self._autoscrollaction:update(arg_35_1) then
			self:endAutoScrollChildren()
		end

		self._container:setPositionX(self._autoscrollpos.pos)
		self:updateCitiesYZ()
	end
end

function PageList:startAutoScrollChildren(arg_36_1)
	self._autoscroll = true
	self._autoscrollpos = {
		pos = self._container:getPositionX() - 100
	}
	self._autoscrollaction = tween.new(0.1, self._autoscrollpos, {
		pos = arg_36_1
	}, "outQuad")
end

function PageList:endAutoScrollChildren()
	self._autoscroll = false
	self._autoscrollaction = nil
end

function PageList:setScrollEnabled(arg_38_1)
	self._scrollEnabled = arg_38_1
end

function PageList:registerSelectCityHandler(arg_39_1)
	self._selectcityHandler = arg_39_1
end

function PageList:getCityBtnDirection(arg_40_1)
	if arg_40_1 < self._curselected - 1 then
		return 1
	elseif arg_40_1 > self._curselected + 2 then
		return 2
	else
		return 3
	end
end

function PageList:openSlideMode(arg_41_1)
	self._is_quick_slide = arg_41_1
end

function PageList:openCellStyle1(arg_42_1)
	self._is_open_style1 = arg_42_1
end

return PageList
