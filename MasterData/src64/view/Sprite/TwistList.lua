local var_0_0 = math.abs
local var_0_1 = math.pow
local var_0_3 = math.min
local tween = require("fight.tween")
local var_0_7 = 50
local var_0_8 = 0.6
local CircleList = require("view.Sprite.CircleList")
local l2utils = require("controller.l2utils")
local var_0_11 = config._DEBUG and 0 or 1
local TwistList = class("TwistList", function()
	return ccui.Layout:create()
end)
local var_0_13 = 130
local var_0_15 = 640
local var_0_17 = {
	left = 20,
	right = 120
}
local var_0_18 = {
	left = 20,
	right = 120
}
local var_0_19 = "default/small_default.png"
local file_check_manager = require("controller.filedownloader.file_check_manager")

function TwistList:create()
	local var_2_0 = TwistList.new()

	var_2_0:init()

	return var_2_0
end

function TwistList:ctor()
	self:setContentSize(cc.size(var_0_15, 140))
	self:setPosition(cc.p(0, 64))
	self:setTouchEnabled(false)

	self._container = nil
	self._curselected = nil
	self._slidtime = 0
	self._pressed = false
	self._twistGap = var_0_13
	self._totalnum = 0
	self._autoscroll = false
	self._autoscrollaction = nil
	self._autoscrollpos = nil
	self._scrollEnabled = true
	self._cities = {}
	self._selectcityHandler = nil
	self._checkAnimEnableHandler = nil
	self._circle = nil
end

function TwistList:init()
	self:initInnerContainer()
	self:registerTouchEvent()
	self:registerUpdateEvent()
	self:initShadePic()
	self:initDownload()
end

function TwistList:initInnerContainer()
	self._container = cc.Node:create()

	self._container:setPosition(cc.p(0, 0))
	self:addChild(self._container, -1)
end

function TwistList:initShadePic()
	local var_6_0 = ccui.ImageView:create("TwistEgg/twist_shade.png", var_0_11)

	var_6_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_6_0:setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height / 2))
	var_6_0:setName("img")
	self:addChild(var_6_0)
	var_6_0:setTouchEnabled(false)

	local var_6_1 = ccui.ImageView:create("TwistEgg/twist_title.png", var_0_11)

	var_6_1:setAnchorPoint(cc.p(0.5, 0))
	var_6_1:setPosition(cc.p(var_6_0:getContentSize().width / 2, -18))
	var_6_1:setName("titleBg")
	var_6_0:addChild(var_6_1)

	local var_6_2 = cc.Label:createWithTTF("", FONT_NAME, 24)

	var_6_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_6_2:setPosition(cc.p(var_6_1:getContentSize().width / 2, var_6_1:getContentSize().height / 2))
	var_6_2:setName("title")
	var_6_1:addChild(var_6_2)

	local var_6_3 = ccui.Layout:create()

	var_6_3:setContentSize(self:getContentSize())
	var_6_3:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_6_3:setAnchorPoint(0, 0)
	var_6_3:setTouchEnabled(true)
	var_6_3:setPosition(cc.p(0, 0))
	self:addChild(var_6_3, -3)
end

function TwistList:registerUpdateEvent()
	self:scheduleUpdateWithPriorityLua(function(arg_8_0)
		self:autoScroll(arg_8_0)
		self:recordSlidTime(arg_8_0)
	end, 0)
end

local function var_0_21(arg_9_0)
	if not arg_9_0 then
		return true
	end

	local var_9_0 = arg_9_0:getParent()

	if var_9_0 and not var_9_0:isVisible() then
		return false
	end

	return var_0_21(var_9_0)
end

function TwistList:registerTouchEvent()
	local var_10_0 = cc.EventListenerTouchOneByOne:create()

	var_10_0:setSwallowTouches(false)
	var_10_0:registerScriptHandler(function(arg_11_0, arg_11_1)
		if not self:checkTouchEnabled() then
			return false
		end

		if not self:isVisible() then
			return false
		end

		if not var_0_21(self) then
			return false
		end

		if cc.rectContainsPoint(cc.rect(0, 0, 640, 140), (self:convertToNodeSpace((arg_11_0:getLocation())))) then
			self:handlePressLogic(arg_11_0)

			return true
		else
			return false
		end
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_10_0:registerScriptHandler(function(arg_12_0, arg_12_1)
		if not self:checkTouchEnabled() then
			return
		end

		self:handleMoveLogic(arg_12_0)
	end, cc.Handler.EVENT_TOUCH_MOVED)
	var_10_0:registerScriptHandler(function(arg_13_0, arg_13_1)
		if not self:checkTouchEnabled() then
			return
		end

		self:handleReleaseLogic(arg_13_0)
	end, cc.Handler.EVENT_TOUCH_ENDED)
	var_10_0:registerScriptHandler(function(arg_14_0, arg_14_1)
		self:handleReleaseLogic(arg_14_0)
	end, cc.Handler.EVENT_TOUCH_CANCELLED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_10_0, self)
end

function TwistList:checkTouchEnabled()
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

	if self._checkAnimEnableHandler then
		return self._checkAnimEnableHandler()
	end

	return true
end

function TwistList:handlePressLogic(arg_16_1)
	self:startRecordSlidAction()

	self._pressed = true
end

function TwistList:handleMoveLogic(arg_17_1)
	self:scrollChildren((arg_17_1:getLocation().x - arg_17_1:getPreviousLocation().x) * var_0_8, arg_17_1:getLocation().x - arg_17_1:getStartLocation().x)
end

function TwistList:handleReleaseLogic(arg_18_1)
	self:endRecordSlidAction(arg_18_1:getLocation().x - arg_18_1:getStartLocation().x)

	self._pressed = false
end

function TwistList:startRecordSlidAction()
	self._slidtime = 0
end

function TwistList:endRecordSlidAction(arg_20_1)
	if self._slidtime <= 0.016 then
		self._slidtime = 0

		self:endAutoScrollChildren()

		return
	end

	local var_20_0 = 0

	if math.abs(arg_20_1) > 10 then
		local var_20_1 = math.abs(arg_20_1) / arg_20_1
		local var_20_2 = self._circle:getControlPoint()

		var_20_0 = self._circle:getControlPointNeedDis(var_20_1, var_0_1(var_0_3(var_0_0(arg_20_1) / self._slidtime, var_0_7), 2) / (2 * var_0_7) * var_20_1)
	else
		self:endAutoScrollChildren()

		return
	end

	self:startAutoScrollChildren(var_20_0)
end

function TwistList:recordSlidTime(arg_21_1)
	if self._pressed then
		self._slidtime = self._slidtime + arg_21_1
	end
end

function TwistList:scrollChildren(arg_22_1)
	local var_22_0 = var_0_0(arg_22_1) / arg_22_1
	local var_22_1 = self._circle:moveControlPoint(arg_22_1)
	local var_22_2 = 0

	if var_22_0 > 0 then
		for iter_22_0 = #self.startBtnList, 1, -1 do
			if self:checkChildStatus(self.startBtnList[iter_22_0], self.startBtnList[iter_22_0]:getPositionX() + arg_22_1) then
				var_22_2 = var_22_2 + 1
			end
		end
	else
		for iter_22_1 = 1, #self.startBtnList do
			if self:checkChildStatus(self.startBtnList[iter_22_1], self.startBtnList[iter_22_1]:getPositionX() + arg_22_1) then
				var_22_2 = var_22_2 + 1
			end
		end
	end

	self:updateStartBtnList(var_22_0, var_22_2)
	self:updateBtnListPos(var_22_1)
	self:updateChildren(var_22_0, var_22_2)
	self:updateTitle(var_22_2)
end

function TwistList:checkChildStatus(arg_23_1, arg_23_2)
	if arg_23_2 - 31.5 < self._circle:getInitX() - self._twistGap / 2 then
		return true
	elseif arg_23_2 + CircleList:getCellWidth() - 31.5 > self._circle:getInitX() + self._circle:getEnablePara().perimeter + self._twistGap / 2 then
		return true
	else
		return false
	end
end

function TwistList:updateStartBtnList(arg_24_1, arg_24_2)
	if arg_24_2 == 0 then
		return
	end

	for iter_24_0 = 1, arg_24_2 do
		if arg_24_1 > 0 then
			table.insert(self.startBtnList, 1, (table.remove(self.startBtnList)))
		else
			table.insert(self.startBtnList, (table.remove(self.startBtnList, 1)))
		end
	end
end

function TwistList:updateBtnListPos(arg_25_1)
	local var_25_0 = self._circle:getInitX()

	for iter_25_0, iter_25_1 in ipairs(self.startBtnList) do
		iter_25_1:setPositionX(var_25_0 + (iter_25_0 - 1) * self._twistGap + arg_25_1 + 31.5)
	end
end

function TwistList:updateChildren(arg_26_1, arg_26_2)
	self:updateChildrenZorder()
	self:updateFakeNode(arg_26_1, arg_26_2)

	self._curselected = self.startBtnList[self.middleVisualIndex].twistIndex

	if self._selectcityHandler and arg_26_2 ~= 0 then
		self._selectcityHandler(self._curselected, self.startBtnList[self.middleVisualIndex])
	end
end

function TwistList:updateChildrenZorder()
	for iter_27_0, iter_27_1 in ipairs(self.startBtnList) do
		iter_27_1:setLocalZOrder(self.zOrderList[iter_27_0])
		iter_27_1:setVisible(true)

		if iter_27_0 == self.middleVisualIndex then
			self:checkAndUpdateButton(iter_27_1, iter_27_1.imgPath .. "_on.png")
		else
			self:checkAndUpdateButton(iter_27_1, iter_27_1.imgPath .. "_off.png")
		end

		if iter_27_1.isAlertReddot then
			AlertManager:add_alert_by_config(iter_27_1, true, {
				ALERT_SHOW_REDDOT,
				"",
				cc.p(100, iter_27_1:getContentSize().height - 15)
			})
		else
			AlertManager:add_alert_by_config(iter_27_1, false, {
				ALERT_SHOW_REDDOT,
				""
			})
		end

		if iter_27_1:getChildByName("alert_reddot") then
			iter_27_1:getChildByName("alert_reddot"):setPositionX(var_0_17[var_27_0])
		end

		if iter_27_1:getChildByName("alert_new") then
			if iter_27_0 == self.middleVisualIndex then
				-- block empty
			else
				iter_27_1:getChildByName("alert_new"):setPositionX(var_0_18[var_27_0])
			end
		end
	end

	if self._totalnum == 2 then
		self.startBtnList[1]:setVisible(false)
	end
end

function TwistList:updateTitle(arg_28_1)
	if arg_28_1 == 0 then
		return
	end

	self:getChildByName("img"):getChildByName("titleBg"):getChildByName("title"):setString(self.startBtnList[self.middleVisualIndex].title)
end

function TwistList:updateFakeNode(arg_29_1, arg_29_2)
	if arg_29_2 == 0 then
		return
	end

	if not self._circle:checkIsHasFakeNode() then
		return
	end

	local var_29_0
	local var_29_1

	if arg_29_1 > 0 then
		var_29_0 = self.startBtnList[1]
		var_29_1 = self.startBtnList[#self.startBtnList]
	else
		var_29_0 = self.startBtnList[#self.startBtnList]
		var_29_1 = self.startBtnList[1]
	end

	var_29_0.twistIndex = var_29_1.twistIndex
	var_29_0.imgPath = var_29_1.imgPath
	var_29_0.isAlertReddot = var_29_1.isAlertReddot
	var_29_0.title = var_29_1.title

	self:checkAndUpdateButton(var_29_0, var_29_0.imgPath .. "_off.png")
end

function TwistList:resetScrollPos()
	local var_30_0 = self._circle:getInitX()

	for iter_30_0, iter_30_1 in ipairs(self.startBtnList) do
		iter_30_1:setPositionX(var_30_0 + (iter_30_0 - 1) * self._twistGap + 31.5)
		iter_30_1:setLocalZOrder(self.zOrderList[iter_30_0])
	end
end

function TwistList:startAutoScrollChildren(arg_31_1)
	if self._setAnimControllerHandler then
		self._setAnimControllerHandler(true)
	end

	local var_31_0 = self._circle:getControlPoint()

	self._autoscroll = true
	self._autoscrollpos = {
		pos = var_31_0
	}
	self._autoscrollaction = tween.new(0.3, self._autoscrollpos, {
		pos = var_31_0 + arg_31_1
	}, "outQuad")
end

function TwistList:endAutoScrollChildren()
	self._autoscroll = false
	self._autoscrollaction = nil

	if self._circle then
		self._circle:resetControlPoint()
	end

	if self._setAnimControllerHandler then
		self._setAnimControllerHandler(false)
	end

	self:resetScrollPos()
end

function TwistList:autoScroll(arg_33_1)
	if self._autoscroll then
		if self._autoscrollaction:update(arg_33_1) then
			self:scrollChildren(self._autoscrollpos.pos - self._circle:getControlPoint())
			self:endAutoScrollChildren()
		else
			self:scrollChildren(self._autoscrollpos.pos - self._circle:getControlPoint())
		end
	end
end

function TwistList:initTwistListCircle(arg_34_1)
	self._circle = CircleList:create(arg_34_1)

	self:addChild(self._circle)
end

function TwistList:pushInCells(arg_35_1, arg_35_2, arg_35_3)
	self._twistGap = self._circle:getGap()

	local var_35_0 = self._circle:getInitX()
	local var_35_1 = #arg_35_1

	self._totalnum = #arg_35_1

	local var_35_2 = {}
	local var_35_3 = self._circle:checkIsHasFakeNode()
	local var_35_4 = 0

	var_35_4 = not var_35_3 and arg_35_2 - math.floor(var_35_1 / 2 + 0.5) + 1 or arg_35_2 - math.floor(var_35_1 / 2 + 0.5)
	self.startBtnIndex = self:normalizeIndex(var_35_4, #arg_35_1)

	local var_35_5 = 0

	for iter_35_0 = 1, #arg_35_1 do
		local var_35_6 = self:normalizeIndex(var_35_4 + iter_35_0 - 1, #arg_35_1)

		table.insert(var_35_2, arg_35_1[var_35_6])

		var_35_5 = var_35_6 == arg_35_2 and iter_35_0 or var_35_5
	end

	if var_35_3 then
		local var_35_7 = var_35_2[1]:clone()

		table.insert(var_35_2, var_35_7)

		var_35_7.twistIndex = var_35_2[1].twistIndex
		var_35_7.imgPath = var_35_2[1].imgPath
		var_35_7.isAlertReddot = var_35_2[1].isAlertReddot
		var_35_7.title = var_35_2[1].title
	end

	self.startBtnList = var_35_2

	local var_35_8 = {}

	for iter_35_1, iter_35_2 in ipairs(self.startBtnList) do
		local var_35_9 = iter_35_1

		if var_35_5 < iter_35_1 then
			var_35_9 = 2 * var_35_5 - iter_35_1
		end

		iter_35_2:setPositionX(var_35_0 + (iter_35_1 - 1) * self._twistGap + 31.5)

		if arg_35_3 then
			iter_35_2:setLocalZOrder(var_35_9)
		else
			self._container:addChild(iter_35_2, var_35_9)
		end

		table.insert(var_35_8, var_35_9)

		if iter_35_2:getChildByName("alert_reddot") then
			iter_35_2:getChildByName("alert_reddot"):setPositionX(var_0_17[var_35_10])
		end

		if iter_35_2:getChildByName("alert_new") then
			if iter_35_1 == var_35_5 then
				-- block empty
			else
				iter_35_2:getChildByName("alert_new"):setPositionX(var_0_18[var_35_10])
			end
		end
	end

	if arg_35_3 and var_35_3 then
		self._container:addChild(self.startBtnList[#self.startBtnList], var_35_8[#self.startBtnList])
	end

	if var_35_1 == 2 then
		self.startBtnList[1]:setVisible(false)
	end

	self.zOrderList = var_35_8
	self.middleVisualIndex = var_35_5

	self:updateTitle(1)

	self._curselected = self._curselected or arg_35_2

	self:checkResource()
end

function TwistList:checkResource()
	local var_36_0 = {}

	for iter_36_0, iter_36_1 in ipairs(self.startBtnList) do
		if file_check_manager:checkFileNeedDownload(iter_36_1.imgPath .. "_on.png") then
			local var_36_1 = file_check_manager:getFileDownloadInfo(iter_36_1.imgPath .. "_on.png")

			table.insert(var_36_0, var_36_1)

			self._downloadinglist[var_36_1.filename] = true
			self._resourcelist[iter_36_1.imgPath .. "_on.png"] = true
			self._downloadfile2resource[var_36_1.filename] = self._downloadfile2resource[var_36_1.filename] or {}
			self._downloadfile2resource[var_36_1.filename][iter_36_1.imgPath .. "_on.png"] = true
		end

		if file_check_manager:checkFileNeedDownload(iter_36_1.imgPath .. "_off.png") then
			local var_36_2 = file_check_manager:getFileDownloadInfo(iter_36_1.imgPath .. "_off.png")

			table.insert(var_36_0, var_36_2)

			self._downloadinglist[var_36_2.filename] = true
			self._resourcelist[iter_36_1.imgPath .. "_off.png"] = true
			self._downloadfile2resource[var_36_2.filename] = self._downloadfile2resource[var_36_2.filename] or {}
			self._downloadfile2resource[var_36_2.filename][iter_36_1.imgPath .. "_off.png"] = true
		end
	end

	if #var_36_0 > 0 then
		require("controller.filedownloader.download_manager"):insertDownloadTasks(file_check_manager:mergeDownloadList(var_36_0))
	end

	self:updateAllButtons()
end

function TwistList:updateAllButtons()
	for iter_37_0, iter_37_1 in ipairs(self.startBtnList) do
		if iter_37_0 == self.middleVisualIndex then
			self:checkAndUpdateButton(iter_37_1, iter_37_1.imgPath .. "_on.png")
		else
			self:checkAndUpdateButton(iter_37_1, iter_37_1.imgPath .. "_off.png")
		end
	end
end

function TwistList:checkAndUpdateButton(arg_38_1, arg_38_2)
	if self._resourcelist[arg_38_2] then
		arg_38_1:loadTextures(var_0_19, nil, var_0_19)
	else
		arg_38_1:loadTextures(arg_38_2, nil, arg_38_2)
	end
end

function TwistList:initDownload()
	self._downloadinglist = {}
	self._resourcelist = {}
	self._downloadfile2resource = {}

	self:registerDownloadEventListener()
end

function TwistList:registerDownloadEventListener()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("DOWNLOAD_EVENT_COMPLETE", function(arg_41_0)
		if self._downloadinglist[arg_41_0.fileName] then
			self._downloadinglist[arg_41_0.fileName] = nil

			for iter_41_0, iter_41_1 in pairs(self._downloadfile2resource[arg_41_0.fileName]) do
				self._resourcelist[iter_41_0] = nil
			end

			if not next(self._downloadinglist) then
				self:onDownloadComplete()
			end
		end
	end), self)
end

function TwistList:onDownloadComplete()
	self:updateAllButtons()
end

function TwistList:scrollToIndex(arg_43_1)
	local var_43_0 = self.middleVisualIndex

	for iter_43_0, iter_43_1 in ipairs(self.startBtnList) do
		if iter_43_1.twistIndex == arg_43_1 then
			var_43_0 = iter_43_0

			break
		end
	end

	self:startAutoScrollChildren((self.middleVisualIndex - var_43_0) * self._twistGap)
end

function TwistList:scrollToIndexManual(arg_44_1)
	if arg_44_1 == self._curselected then
		return
	end

	if not self:checkTouchEnabled() then
		return
	end

	self:scrollToIndex(arg_44_1)
end

function TwistList:setScrollEnabled(arg_45_1)
	self._scrollEnabled = arg_45_1
end

function TwistList:registerSelectCityHandler(arg_46_1)
	self._selectcityHandler = arg_46_1
end

function TwistList:registerCheckAnimHandler(arg_47_1)
	self._checkAnimEnableHandler = arg_47_1
end

function TwistList:registerAnimControllerHandler(arg_48_1)
	self._setAnimControllerHandler = arg_48_1
end

function TwistList:normalizeIndex(arg_49_1, arg_49_2)
	if arg_49_1 < 1 then
		return arg_49_2 + arg_49_1
	elseif arg_49_2 < arg_49_1 then
		return arg_49_1 - arg_49_2
	else
		return arg_49_1
	end
end

function TwistList:getTotalNode()
	return #self.startBtnList
end

function TwistList:deleteNode(arg_51_1, arg_51_2, arg_51_3)
	local var_51_0 = self.middleVisualIndex

	for iter_51_0, iter_51_1 in ipairs(self.startBtnList) do
		if iter_51_1.twistIndex == arg_51_1 then
			var_51_0 = iter_51_0

			break
		end
	end

	table.remove(self.startBtnList, var_51_0):removeFromParent()

	if self._circle:checkIsHasFakeNode() then
		table.remove(self.startBtnList):removeFromParent()
	end

	if not arg_51_2 then
		self:resetTwistList((arg_51_1 == 1 or nil) and 2)
	else
		self:resetAndRedrawTwistList(arg_51_3)
	end
end

function TwistList:resetTwistList(arg_52_1)
	self._circle:reset(#self.startBtnList)

	local var_52_0 = {}
	local var_52_1 = 1

	for iter_52_0, iter_52_1 in ipairs(self.startBtnList) do
		if iter_52_1.twistIndex == arg_52_1 then
			var_52_1 = iter_52_0

			break
		end
	end

	for iter_52_2 = 1, #self.startBtnList do
		local var_52_3 = self.startBtnList[(var_52_1 + iter_52_2 - 1 > #self.startBtnList or nil) and var_52_1 + iter_52_2 - 1 - #self.startBtnList]

		var_52_3.twistIndex = iter_52_2

		table.insert(var_52_0, var_52_3)
	end

	self._curselected = nil

	self:pushInCells(var_52_0, 1, true)
end

function TwistList:resetAndRedrawTwistList(arg_53_1)
	self._circle:reset(#arg_53_1)

	self._curselected = nil

	self:pushInCells(arg_53_1, 1)
end

function TwistList:removeReddot(arg_54_1)
	if arg_54_1 then
		if self.startBtnList[self.middleVisualIndex]:getChildByName("alert_reddot") then
			local var_54_0 = self.startBtnList[self.middleVisualIndex]:getChildByName("alert_reddot")

			AlertManager:add_alert_by_config(self.startBtnList[self.middleVisualIndex], false, {
				ALERT_SHOW_REDDOT,
				"",
				cc.p(10, self.startBtnList[self.middleVisualIndex]:getContentSize().height - 30)
			})
		end
	end
end

function TwistList:getNodeObjBytwistIndex(arg_55_1)
	for iter_55_0, iter_55_1 in pairs(self.startBtnList) do
		if iter_55_1.twistIndex == arg_55_1 then
			return iter_55_1
		end
	end
end

return TwistList
