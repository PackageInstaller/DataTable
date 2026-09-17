PopCourseLayer = class("PopCourseLayer", function()
	return PopBaseLayer:create()
end)

local Utility = require("common.Utility")
local EventManager = require("common.EventManager")
local LocalEvent = require("common.LocalEvent")
local var_0_3 = require("controller.course_cultivate_manager").getInstance()
local item_manager = require("controller.item_manager")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local var_0_7 = config._DEBUG and 0 or 1
local var_0_8 = {
	LOCK = 0,
	UNLOCK = 1
}
local var_0_9 = var_0_3.COURSE_TYPE
local var_0_10 = var_0_3.UNLOCK_TYPE
local var_0_11 = "gamecourse/logo/"
local var_0_12 = {
	[var_0_3.COURSE_TYPE.BASE] = "logo_base.png",
	[var_0_3.COURSE_TYPE.DRAK_MATTER] = "logo_dark_matter.png",
	[var_0_3.COURSE_TYPE.ELECTROMAGNETISM] = "logo_electromagnetism.png",
	[var_0_3.COURSE_TYPE.LIGHT_ENERGY] = "logo_light_energy.png",
	[var_0_3.COURSE_TYPE.QUANTUM] = "logo_quantum.png",
	[var_0_3.COURSE_TYPE.THERMAL_ENERGY] = "logo_thermal_energy.png",
	[var_0_3.COURSE_TYPE.IMAGINARY] = "logo_imaginary.png",
	[var_0_3.COURSE_TYPE.DEVIL] = "logo_devil.png",
	[var_0_3.COURSE_TYPE.MIMICRY] = "logo_mimicry.png",
	[var_0_3.COURSE_TYPE.POSITIVE] = "logo_positive.png",
	[var_0_3.COURSE_TYPE.ZEROSUPPERESSION] = "logo_other.png"
}
local var_0_13 = var_0_3.ATTRIBUTE_TYPE
local var_0_14 = "gamecourse/pop/"
local var_0_15 = {
	[var_0_3.ATTRIBUTE_TYPE.ATTACK] = "title_attack.png",
	[var_0_3.ATTRIBUTE_TYPE.CRITICAL] = "title_critical.png",
	[var_0_3.ATTRIBUTE_TYPE.DAMAGE] = "title_damage.png",
	[var_0_3.ATTRIBUTE_TYPE.DEFEND] = "title_defend.png",
	[var_0_3.ATTRIBUTE_TYPE.ENERGY_DEFEND] = "title_energy_defend.png",
	[var_0_3.ATTRIBUTE_TYPE.HEALTH] = "title_health.png",
	[var_0_3.ATTRIBUTE_TYPE.REDUCTION] = "title_reduction.png",
	[var_0_3.ATTRIBUTE_TYPE.TACTICS] = "title_tactics.png"
}
local var_0_16

function PopCourseLayer.getInstance(arg_2_0)
	return var_0_16
end

function PopCourseLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = PopCourseLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function PopCourseLayer:init(arg_4_1)
	self:initData(arg_4_1)
	self:initUI()
	self:registerEvents()
	self:show()
end

function PopCourseLayer:initData(arg_5_1)
	if arg_5_1 then
		self.courseData = arg_5_1.courseData or {}
	end

	self.courseType = self.courseData.courseType or var_0_9.BASE

	if self.courseData.unlock then
		self.btnStatus = var_0_8.UNLOCK or var_0_8.LOCK
	end

	self.attributeType = self.courseData.courseIcon or var_0_13.ATTACK

	if arg_5_1 then
		self.panelPosY = arg_5_1.positionY or nil
	end

	if arg_5_1 then
		self.hideCallFunc = arg_5_1.hideCallFunc or nil
	end
end

function PopCourseLayer:initUI()
	self.rootNode = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopCourseLayer.json" or "PopCourseLayer.ExportJson")

	self.rootNode:setContentSize(GameDisplay.size)
	self.rootNode:setPositionY(-GameDisplay.fix_y)
	self.rootNode:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self:addChild(self.rootNode)

	self.rootpanel = self.rootNode:getChildByName("rootPanel")

	self.rootpanel:setContentSize(GameDisplay.size)
	self.rootpanel:setAnchorPoint(0.5, 0)
	self.rootpanel:setPositionX(GameDisplay.size.width / 2)
	self.rootpanel:setPositionY(0)
	self.rootpanel:setTouchEnabled(false)
	self.rootNode:setTouchEnabled(false)

	self.panelMain = self.rootpanel:getChildByName("panelMain")

	Utility:alignPanelByParent(self.panelMain, self.rootpanel)

	if self.panelPosY then
		self.panelMain:setPositionY(self.panelPosY)
	end

	self.listViewCourse = self.panelMain:getChildByName("listViewCourse")
	self.panelItem = self.panelMain:getChildByName("panelItem")

	self.panelItem:retain()
	self.panelItem:removeFromParent()

	self.imgLogo = self.panelMain:getChildByName("imgLogo")
	self.imgTitle = self.panelMain:getChildByName("imgTitle")
	self.labelTitle = self.panelMain:getChildByName("labelTitle")
	self.imgCost = self.panelMain:getChildByName("imgCost")

	self.imgCost:setTouchEnabled(true)

	self.labelCost = Utility:seekChildByName(self.panelMain, "labelCost")
	self.imgItem = self.imgCost:getChildByName("imgItem")

	self.imgItem:setTouchEnabled(true)
	self.labelCost:setFontSize(20)

	self.btnStudy = self.panelMain:getChildByName("btnStudy")
	self.btnReset = self.panelMain:getChildByName("btnReset")
	self.imgCondition = self.panelMain:getChildByName("imgCondition")
	self.listViewConditions = self.imgCondition:getChildByName("listViewConditions")

	self.listViewConditions:setItemsMargin(10)

	self.labelCondition = self.listViewConditions:getChildByName("labelCondition")

	self.labelCondition:retain()
	self.labelCondition:removeFromParent()

	self.labelMaxTip = cc.Label:createWithTTF(L_POPCOURSELAYER[1], "fonts/newkj.ttf", 18)

	self.labelMaxTip:setAnchorPoint(0.5, 0.5)
	self.labelMaxTip:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
	self.panelMain:addChild(self.labelMaxTip)
	self.labelMaxTip:setPosition(self.btnStudy:getPositionX(), 60)

	self.imgStudied = ccui.ImageView:create("gamecourse/pop/img_studied.png", var_0_7)

	self.panelMain:addChild(self.imgStudied)
	self.imgStudied:setPosition(self.btnStudy:getPositionX() - 80, 100)
	self:updateLayout()
end

function PopCourseLayer:registerEvents()
	Utility:registerNodeEvent(self)
	Utility:addClickEventListener(self.btnStudy, handler(self, self.onBtnStudy))
	Utility:addClickEventListener(self.btnReset, handler(self, self.onBtnReset))
	Utility:addClickEventListener(self.imgCost, handler(self, self.onBtnItem))
	Utility:addClickEventListener(self.imgItem, handler(self, self.onBtnItem))
	EventManager:subscribe(self, EventManager.EVENT_IDS.COURSE_LEVEL_UP, handler(self, self.handleCourseLevelUp))
	EventManager:subscribe(self, EventManager.EVENT_IDS.COURSE_RESET, handler(self, self.handleCourseReset))
	LocalEvent:registerEvent(self, LocalEvent.EVENT_IDS.UPDATE_COURSE_DATA, handler(self, self.handleGetCourseData))
end

function PopCourseLayer:onBtnItem()
	if self.courseData.courseLevel < #self.courseData.courses then
		LayerManager:pushInLayer("PopItemLayer", {
			itemid = self.courseData.courses[self.courseData.courseLevel + 1].needItem
		})
	end
end

function PopCourseLayer:updateLayout()
	self.imgLogo:loadTexture(var_0_11 .. var_0_12[self.courseType], var_0_7)
	self.imgLogo:setVisible(false)
	self.imgTitle:loadTexture(var_0_14 .. (var_0_15[self.attributeType] or var_0_15[var_0_13.ATTACK]), var_0_7)
	self.btnStudy:setBright(self.btnStatus ~= var_0_8.LOCK)
	self.btnStudy:setVisible(self.courseData.courseLevel < #self.courseData.courses)
	self.btnReset:setVisible(self.courseData.courseLevel > 0)
	self.labelMaxTip:setVisible(false)
	self.imgStudied:setVisible(self.courseData.courseLevel == #self.courseData.courses)
	self.imgCost:setVisible(self.btnStatus ~= var_0_8.LOCK and self.courseData.courseLevel < #self.courseData.courses)
	self.imgCondition:setVisible(self.btnStatus == var_0_8.LOCK)

	if #self.courseData.courses > self.courseData.courseLevel then
		self.labelCost:setString("x" .. self.courseData.courses[self.courseData.courseLevel + 1].needNum)
		self.imgItem:loadTexture((string.format("equipment/%d.png", item_data[self.courseData.courses[self.courseData.courseLevel + 1].needItem].image_id)))
		self.imgItem:setContentSize(cc.size(64, 64))
		self.imgItem:ignoreContentAdaptWithSize(false)
	end

	self.labelTitle:setString(self.courseData.courseName)
	self:updateListViewCourses()
	self:updateListViewConditions()
end

function PopCourseLayer:updateListViewCourses()
	self.listViewCourse:removeAllChildren()

	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs(self.courseData.courses) do
		local var_10_1 = self.panelItem:clone()
		local var_10_2 = var_10_1:getChildByName("imgStatus")

		var_10_2:loadTexture(iter_10_1.level > self.courseData.courseLevel and string.format("gamecourse/pop/img_un_studied_%d.png", iter_10_0) or string.format("gamecourse/pop/img_studied_%d.png", iter_10_0), var_0_7)

		local var_10_3 = var_10_1:getChildByName("labelInfo")

		var_10_3:setFontSize(18)
		var_10_3:setString(var_0_3:getBuffInfo(iter_10_1.refBuff).detail or "")
		var_10_3:setTextAreaSize(cc.size(var_10_1:getContentSize().width, 0))

		local var_10_4 = var_10_3:getContentSize().height + var_10_2:getContentSize().height + 20

		var_10_1:setContentSize(var_10_1:getContentSize().width, var_10_4)
		var_10_2:setPositionY(var_10_4 - 4)
		var_10_3:setPositionY(var_10_2:getPositionY() - 40)
		self.listViewCourse:pushBackCustomItem(var_10_1)

		var_10_0 = var_10_0 + var_10_4
	end

	self.imgCondition:setPositionY((math.min(54 + self.listViewCourse:getContentSize().height - var_10_0, 176)))
end

function PopCourseLayer:updateListViewConditions()
	self.listViewConditions:removeAllChildren()

	for iter_11_0, iter_11_1 in ipairs(self.courseData.conditions) do
		self.listViewConditions:pushBackCustomItem((self:createOneText((var_0_3:transformConditionToString(iter_11_1)))))
	end
end

function PopCourseLayer.createOneText(arg_12_0, arg_12_1)
	local var_12_0 = ccui.RichText:create()

	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		var_12_0:pushBackElement((ccui.RichElementText:create(iter_12_0, iter_12_1.color or cc.c3b(255, 255, 255), iter_12_1.opacity or 255, iter_12_1.str or "", iter_12_1.font or "fonts/newkj.ttf", iter_12_1.fontSize or 17)))
	end

	var_12_0:formatText()

	return var_12_0
end

function PopCourseLayer:onBtnStudy(arg_13_1)
	if self.btnStatus == var_0_8.LOCK then
		self:showUnlockTips()

		return
	end

	if self.isRequesting then
		return
	end

	if self.courseData.courses[self.courseData.courseLevel + 1].needNum > item_manager:getItemNumber(self.courseData.courses[self.courseData.courseLevel + 1].needItem) then
		LayerManager:pushInLayer("PopGoGainLayer", {
			item = self.courseData.courses[self.courseData.courseLevel + 1].needItem
		})

		return
	end

	self.isRequesting = true

	EventManager:requestCourseLevleUp(self.courseData.courseId)
end

function PopCourseLayer:showUnlockTips()
	for iter_14_0, iter_14_1 in ipairs(self.courseData.conditions) do
		if not var_0_3:queryConditionComplete(iter_14_1) then
			if iter_14_1.type == var_0_10.SPECIFIED_COURSE_LEVEL then
				global_ShowBlockWords(L_POPCOURSELAYER[3])

				break
			end

			if iter_14_1.type == var_0_10.OWN_SOUL_GIRL_NUM then
				LayerManager:pushInLayer("PopMsgLayer", {
					msgType = 1,
					strInfo = L_POPCOURSELAYER[2],
					confirmCallBack = function()
						Utility:executeLayerJump({
							systemid = 180
						})
					end,
					buttons = {
						confirm = {
							color = cc.c3b(0, 0, 0)
						}
					}
				})

				break
			end

			if iter_14_1.type == var_0_10.OWN_SPECIFIED_SOUL_GIRL then
				LayerManager:pushInLayer("PopMsgLayer", {
					msgType = 1,
					strInfo = L_POPCOURSELAYER[2],
					confirmCallBack = function()
						Utility:executeLayerJump({
							systemid = 180
						})
					end,
					buttons = {
						confirm = {
							color = cc.c3b(0, 0, 0)
						}
					}
				})

				break
			end

			if iter_14_1.type == var_0_10.PLAYER_LEVEL then
				LayerManager:pushInLayer("PopMsgLayer", {
					msgType = 1,
					strInfo = L_POPCOURSELAYER[4],
					confirmCallBack = function()
						Utility:executeLayerJump({
							systemid = 250
						})
					end,
					buttons = {
						confirm = {
							color = cc.c3b(0, 0, 0)
						}
					}
				})
			end

			break
		end
	end
end

function PopCourseLayer:onBtnReset(arg_18_1)
	if self.btnStatus == var_0_8.LOCK then
		global_ShowBlockWords(L_POPCOURSELAYER[5])

		return
	end

	if self.isRequesting then
		return
	end

	if self.courseData.courseLevel == 0 then
		global_ShowBlockWords(L_POPCOURSELAYER[5])

		return
	end

	self.isRequesting = true

	LayerManager:pushInLayer("PopMsgLayer", {
		msgType = 1,
		costType = 1,
		strInfo = L_POPCOURSELAYER[6],
		costNum = self.courseData.diamond,
		cancelCallBack = function()
			self.isRequesting = false
		end,
		confirmCallBack = function()
			EventManager:requestCourseReset(self.courseType, self.courseData.courseId)
		end,
		buttons = {
			cancel = {
				color = cc.c3b(0, 0, 0)
			},
			confirm = {
				color = cc.c3b(0, 0, 0)
			}
		}
	})
end

function PopCourseLayer.onEnter(arg_21_0)
	var_0_16 = arg_21_0
end

function PopCourseLayer:onExit()
	var_0_16 = nil

	self.panelItem:release()
	self.labelCondition:release()
	LocalEvent:removeEvent(self)
	EventManager:unsubscribe(self)
end

function PopCourseLayer:show()
	self.showActions.extendVertical(self)
end

function PopCourseLayer:hide()
	self.hideActions.shrinkVertical(self, function()
		if self.hideCallFunc then
			self.hideCallFunc()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopCourseLayer:handleCourseLevelUp(arg_26_1)
	self.isRequesting = false

	if not arg_26_1 then
		return
	end

	if not arg_26_1.result or arg_26_1.result == 1 then
		for iter_26_0, iter_26_1 in ipairs(arg_26_1.consumes) do
			item_manager:deleteItem(iter_26_1.entityid, iter_26_1.num)
		end

		EventManager:requestGetCourseData(self.courseType)
		LocalEvent:triggerEvent(LocalEvent.EVENT_IDS.UPDATE_USER_ITEMS)
	elseif arg_26_1.result and arg_26_1.result == 2 then
		global_ShowBlockWords(L_POPCOURSELAYER[7])
	elseif arg_26_1.result and arg_26_1.result == 3 then
		global_ShowBlockWords(L_POPCOURSELAYER[8])
	elseif arg_26_1.result and arg_26_1.result == 4 then
		global_ShowBlockWords(L_POPCOURSELAYER[9])
	elseif arg_26_1.result and arg_26_1.result == 5 then
		global_ShowBlockWords(L_POPCOURSELAYER[10])
	elseif arg_26_1.result and arg_26_1.result == 6 then
		global_ShowBlockWords(L_POPCOURSELAYER[11])
	end
end

function PopCourseLayer:handleCourseReset(arg_27_1)
	self.isRequesting = false

	if not arg_27_1 then
		return
	end

	if not arg_27_1.result or arg_27_1.result == 1 then
		self:hide()
	elseif arg_27_1.result and arg_27_1.result == 2 then
		global_ShowBlockWords(L_POPCOURSELAYER[5])
	elseif arg_27_1.result and arg_27_1.result == 3 then
		global_ShowBlockWords(L_POPCOURSELAYER[12])
	elseif arg_27_1.result and arg_27_1.result == 4 then
		global_ShowBlockWords(L_POPCOURSELAYER[13])
	end
end

function PopCourseLayer:handleGetCourseData()
	if var_0_16 then
		self:updateLayout()
	end
end

function PopCourseLayer:updateCourseData(arg_29_1)
	if not arg_29_1 then
		return
	end

	self.courseData = arg_29_1
	self.courseType = self.courseData.courseType or var_0_9.BASE

	if self.courseData.unlock then
		self.btnStatus = var_0_8.UNLOCK or var_0_8.LOCK
	end

	self.attributeType = self.courseData.courseIcon or var_0_13.ATTACK

	self:updateLayout()
end
