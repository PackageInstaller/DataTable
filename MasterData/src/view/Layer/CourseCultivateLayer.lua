local CourseCultivateLayer = class("CourseCultivateLayer", function()
	return cc.Layer:create()
end)
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local item_data = require("data.item_data")
local Utility = require("common.Utility")
local EventManager = require("common.EventManager")
local LocalEvent = require("common.LocalEvent")
local var_0_7 = require("controller.course_cultivate_manager").getInstance()

require("view.Layer.Pops.PopCourseLayer")

local var_0_8 = config._DEBUG and 0 or 1
local var_0_9 = {
	IMG_BOTTOM = 1,
	IMG_TOP = 1,
	LISTVIEW_BTN = 1,
	SCROLLVIEW_COURSE = 0
}
local var_0_10 = {
	THERMAL_ENERGY = 10,
	IMAGINARY = 1,
	LIGHT_ENERGY = 8,
	POSITIVE = 4,
	ZEROSUPPERESSION = 5,
	MIMICRY = 3,
	DEVIL = 2,
	DRAK_MATTER = 6,
	QUANTUM = 9,
	ELECTROMAGNETISM = 7
}
local var_0_11 = var_0_7.COURSE_TYPE
local var_0_12 = "gamecourse/title/"
local var_0_13 = {
	[var_0_7.COURSE_TYPE.BASE] = "title_base.png",
	[var_0_7.COURSE_TYPE.DRAK_MATTER] = "title_dark_matter.png",
	[var_0_7.COURSE_TYPE.ELECTROMAGNETISM] = "title_electromagnetism.png",
	[var_0_7.COURSE_TYPE.IMAGINARY] = "title_imaginary.png",
	[var_0_7.COURSE_TYPE.LIGHT_ENERGY] = "title_light_energy.png",
	[var_0_7.COURSE_TYPE.QUANTUM] = "title_quantum.png",
	[var_0_7.COURSE_TYPE.THERMAL_ENERGY] = "title_thermal_energy.png",
	[var_0_7.COURSE_TYPE.DEVIL] = "title_devil.png",
	[var_0_7.COURSE_TYPE.MIMICRY] = "title_mimicry.png",
	[var_0_7.COURSE_TYPE.POSITIVE] = "title_positive.png",
	[var_0_7.COURSE_TYPE.ZEROSUPPERESSION] = "title_other.png"
}
local var_0_14 = {
	[var_0_7.COURSE_TYPE.BASE] = "course_base",
	[var_0_7.COURSE_TYPE.DRAK_MATTER] = "course_5",
	[var_0_7.COURSE_TYPE.ELECTROMAGNETISM] = "course_1",
	[var_0_7.COURSE_TYPE.LIGHT_ENERGY] = "course_4",
	[var_0_7.COURSE_TYPE.QUANTUM] = "course_3",
	[var_0_7.COURSE_TYPE.THERMAL_ENERGY] = "course_2",
	[var_0_7.COURSE_TYPE.IMAGINARY] = "course_6",
	[var_0_7.COURSE_TYPE.DEVIL] = "course_7",
	[var_0_7.COURSE_TYPE.MIMICRY] = "course_8",
	[var_0_7.COURSE_TYPE.POSITIVE] = "course_9",
	[var_0_7.COURSE_TYPE.ZEROSUPPERESSION] = "course_10"
}
local var_0_15 = "gamecourse/btn/"
local var_0_16 = {
	[var_0_10.DRAK_MATTER] = {
		off = "btn_dark_matter_off.png",
		on = "btn_dark_matter_on.png",
		type = var_0_7.COURSE_TYPE.DRAK_MATTER
	},
	[var_0_10.ELECTROMAGNETISM] = {
		off = "btn_electromagnetism_off.png",
		on = "btn_electromagnetism_on.png",
		type = var_0_7.COURSE_TYPE.ELECTROMAGNETISM
	},
	[var_0_10.LIGHT_ENERGY] = {
		off = "btn_light_energy_off.png",
		on = "btn_light_energy_on.png",
		type = var_0_7.COURSE_TYPE.LIGHT_ENERGY
	},
	[var_0_10.QUANTUM] = {
		off = "btn_quantum_off.png",
		on = "btn_quantum_on.png",
		type = var_0_7.COURSE_TYPE.QUANTUM
	},
	[var_0_10.THERMAL_ENERGY] = {
		off = "btn_thermal_energy_off.png",
		on = "btn_thermal_energy_on.png",
		type = var_0_7.COURSE_TYPE.THERMAL_ENERGY
	},
	[var_0_10.IMAGINARY] = {
		off = "btn_imaginary_off.png",
		on = "btn_imaginary_on.png",
		type = var_0_7.COURSE_TYPE.IMAGINARY
	},
	[var_0_10.DEVIL] = {
		off = "btn_devil_off.png",
		on = "btn_devil_on.png",
		type = var_0_7.COURSE_TYPE.DEVIL
	},
	[var_0_10.MIMICRY] = {
		off = "btn_mimicry_off.png",
		on = "btn_mimicry_on.png",
		type = var_0_7.COURSE_TYPE.MIMICRY
	},
	[var_0_10.POSITIVE] = {
		off = "btn_positive_off.png",
		on = "btn_positive_on.png",
		type = var_0_7.COURSE_TYPE.POSITIVE
	},
	[var_0_10.ZEROSUPPERESSION] = {
		off = "btn_other_off.png",
		on = "btn_other_on.png",
		type = var_0_7.COURSE_TYPE.ZEROSUPPERESSION
	}
}
local var_0_17 = "gamecourse/line/"
local var_0_18 = {
	[var_0_7.COURSE_TYPE.BASE] = "base_line.png",
	[var_0_7.COURSE_TYPE.DRAK_MATTER] = "line_dark_matter.png",
	[var_0_7.COURSE_TYPE.ELECTROMAGNETISM] = "line_electromagnetism.png",
	[var_0_7.COURSE_TYPE.LIGHT_ENERGY] = "line_light_energy.png",
	[var_0_7.COURSE_TYPE.QUANTUM] = "line_quantum.png",
	[var_0_7.COURSE_TYPE.THERMAL_ENERGY] = "line_thermal_energy.png",
	[var_0_7.COURSE_TYPE.IMAGINARY] = "line_imaginary.png",
	[var_0_7.COURSE_TYPE.DEVIL] = "line_thermal_energy.png",
	[var_0_7.COURSE_TYPE.MIMICRY] = "base_line.png",
	[var_0_7.COURSE_TYPE.POSITIVE] = "line_light_energy.png",
	[var_0_7.COURSE_TYPE.ZEROSUPPERESSION] = "line_other.png"
}
local var_0_19 = "gamecourse/bg/"
local var_0_20 = {
	[var_0_7.COURSE_TYPE.BASE] = {
		max = "other_max.png",
		normal = "other_studied.png"
	},
	[var_0_7.COURSE_TYPE.DRAK_MATTER] = {
		max = "dark_matter_max.png",
		normal = "dark_matter_stuied.png"
	},
	[var_0_7.COURSE_TYPE.ELECTROMAGNETISM] = {
		max = "electromagnetism_max.png",
		normal = "electromagnetism_studied.png"
	},
	[var_0_7.COURSE_TYPE.LIGHT_ENERGY] = {
		max = "light_energy_max.png",
		normal = "light_energy_studied.png"
	},
	[var_0_7.COURSE_TYPE.QUANTUM] = {
		max = "quantum_max.png",
		normal = "quantum_studied.png"
	},
	[var_0_7.COURSE_TYPE.THERMAL_ENERGY] = {
		max = "thermal_energy_max.png",
		normal = "thermal_energy_studied.png"
	},
	[var_0_7.COURSE_TYPE.IMAGINARY] = {
		max = "imaginary_max.png",
		normal = "imaginary_studied.png"
	},
	[var_0_7.COURSE_TYPE.DEVIL] = {
		max = "thermal_energy_max.png",
		normal = "thermal_energy_studied.png"
	},
	[var_0_7.COURSE_TYPE.MIMICRY] = {
		max = "other_max.png",
		normal = "other_studied.png"
	},
	[var_0_7.COURSE_TYPE.POSITIVE] = {
		max = "light_energy_max.png",
		normal = "light_energy_studied.png"
	},
	[var_0_7.COURSE_TYPE.ZEROSUPPERESSION] = {
		max = "other_max.png",
		normal = "other_studied.png"
	}
}
local var_0_21 = "gamecourse/icon/"
local var_0_22 = {
	[var_0_7.ATTRIBUTE_TYPE.ATTACK] = "icon_attack.png",
	[var_0_7.ATTRIBUTE_TYPE.CRITICAL] = "icon_critical.png",
	[var_0_7.ATTRIBUTE_TYPE.DAMAGE] = "icon_damage.png",
	[var_0_7.ATTRIBUTE_TYPE.DEFEND] = "icon_defend.png",
	[var_0_7.ATTRIBUTE_TYPE.ENERGY_DEFEND] = "icon_energy_defend.png",
	[var_0_7.ATTRIBUTE_TYPE.HEALTH] = "icon_health.png",
	[var_0_7.ATTRIBUTE_TYPE.REDUCTION] = "icon_reduction.png",
	[var_0_7.ATTRIBUTE_TYPE.TACTICS] = "icon_tactics.png",
	[var_0_7.ATTRIBUTE_TYPE.CHARGE] = "icon_charge.png",
	[var_0_7.ATTRIBUTE_TYPE.DODGE] = "icon_dodge.png"
}
local var_0_23 = "gamecourse/logo/"
local var_0_24 = {
	[var_0_7.COURSE_TYPE.BASE] = "logo_base.png",
	[var_0_7.COURSE_TYPE.DRAK_MATTER] = "logo_dark_matter.png",
	[var_0_7.COURSE_TYPE.ELECTROMAGNETISM] = "logo_electromagnetism.png",
	[var_0_7.COURSE_TYPE.LIGHT_ENERGY] = "logo_light_energy.png",
	[var_0_7.COURSE_TYPE.QUANTUM] = "logo_quantum.png",
	[var_0_7.COURSE_TYPE.THERMAL_ENERGY] = "logo_thermal_energy.png",
	[var_0_7.COURSE_TYPE.IMAGINARY] = "logo_imaginary.png",
	[var_0_7.COURSE_TYPE.DEVIL] = "logo_other.png",
	[var_0_7.COURSE_TYPE.MIMICRY] = "logo_other.png",
	[var_0_7.COURSE_TYPE.POSITIVE] = "logo_other.png",
	[var_0_7.COURSE_TYPE.ZEROSUPPERESSION] = "logo_other.png"
}
local var_0_25
local var_0_26
local TempWidget = require("view/Sprite/TempWidget")

function CourseCultivateLayer:create(...)
	local var_2_0 = CourseCultivateLayer.new(...)

	var_2_0:init(...)

	return var_2_0
end

function CourseCultivateLayer:init(...)
	self:initData(...)
	self:initUI()
	self:registerEvents()
end

function CourseCultivateLayer:initData(arg_4_1)
	self.returnLayer = arg_4_1.returnLayer or "SchoolDeanOfficeLayer"
	self.courseType = arg_4_1.courseType or var_0_11.BASE
	self.switchBtns = {}
	self.curSelectCourse = nil
	self.curCoursesData = self:getCourseDatas()
	self.needItemId = 1502099
	self.panelCourses = {}
	self.contrastHierarchy = 2
	self.isManulSwitch = true
	self.isScroll = false
	self.isJump = var_0_26 and var_0_25
end

function CourseCultivateLayer:initUI()
	self.rootNode = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "CourseCultivateLayer.json" or "CourseCultivateLayer.ExportJson")

	self:addChild(self.rootNode)

	self.rootPanel = self.rootNode:getChildByName("rootPanel")
	self.imgBg = self.rootPanel:getChildByName("imgBg")

	self.imgBg:loadTexture("mainScenebg/bg_course.png")

	self.panelMain = self.rootPanel:getChildByName("panelMain")
	self.imgTop = self.panelMain:getChildByName("imgTop")
	self.btnDetail = self.imgTop:getChildByName("btnDetail")
	self.imgTitle = self.imgTop:getChildByName("imgTitle")
	self.btnReset = self.imgTop:getChildByName("btnReset")
	self.imgBottom = self.panelMain:getChildByName("imgBottom")
	self.btnBack = self.imgBottom:getChildByName("btnBack")
	self.labelOwn = Utility:seekChildByName(self.imgBottom, "labelOwn")

	Utility:addClickEventListener(self.labelOwn:getParent(), handler(self, self.onBtnItem))
	self.labelOwn:setFontSize(18)

	self.btnItem = Utility:seekChildByName(self.imgBottom, "btnItem")
	self.listviewBtns = self.panelMain:getChildByName("listViewBtns")
	self.scrollViewCourse = self.panelMain:getChildByName("scrollViewCourse")

	self.scrollViewCourse:setSwallowsTouches(false)
	self.imgTop:setLocalZOrder(var_0_9.IMG_TOP)
	self.imgBottom:setLocalZOrder(var_0_9.IMG_BOTTOM)
	self.scrollViewCourse:setLocalZOrder(var_0_9.SCROLLVIEW_COURSE)
	self.listviewBtns:setLocalZOrder(var_0_9.LISTVIEW_BTN)

	self.panelItem = self.panelMain:getChildByName("panelItem")

	self.panelItem:retain()
	self.panelItem:removeFromParent()

	self.btnSwitch = self.listviewBtns:getChildByName("btnSwitch")

	self.btnSwitch:retain()
	self.btnSwitch:removeFromParent()
	self:fullScreenAlign()
	self:updateTopUI()
	self:updateBottomUI()
	self:initListViewBtns()
	self:autoSwitchPage()
end

function CourseCultivateLayer:autoSwitchPage()
	local var_6_1, var_6_2 = self:queryBtnByType(var_0_26 or var_0_11.BASE)

	if not var_6_1 then
		self:onBtnSwitch(self.switchBtns[1], 1)
	else
		self:onBtnSwitch(var_6_1, var_6_2)
	end
end

function CourseCultivateLayer:queryBtnByType(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(self.switchBtns) do
		if iter_7_1.courseType == arg_7_1 then
			return iter_7_1, iter_7_0
		end
	end

	return nil
end

function CourseCultivateLayer:queryCourseDataByIndex(arg_8_1)
	if not arg_8_1 or arg_8_1 == 0 then
		return nil
	end

	local var_8_0 = 1

	for iter_8_0, iter_8_1 in ipairs(self.curCoursesData) do
		if iter_8_1.root then
			if var_8_0 == var_0_25 then
				return iter_8_1.root
			end

			var_8_0 = var_8_0 + 1
		end

		for iter_8_2, iter_8_3 in ipairs(iter_8_1.leafs) do
			if var_8_0 == var_0_25 then
				return iter_8_3
			end

			var_8_0 = var_8_0 + 1
		end
	end

	return nil
end

function CourseCultivateLayer:fullScreenAlign()
	self.rootPanel:setContentSize(self.rootPanel:getContentSize().width, GameDisplay.height)
	self.rootPanel:setPositionY(-GameDisplay.fix_y)
	self.panelMain:setContentSize(self.panelMain:getContentSize().width, GameDisplay.height)

	local var_9_0 = GameDisplay.height - self.imgTop:getContentSize().height - self.imgBottom:getContentSize().height - self.listviewBtns:getContentSize().height

	self.scrollViewCourse:setContentSize(self.scrollViewCourse:getContentSize().width, var_9_0)

	local var_9_1 = self.scrollViewCourse:getInnerContainer()

	var_9_1:setContentSize(self.scrollViewCourse:getContentSize().width + 500, math.max(var_9_0, #self:getCourseDatas() * 248) * 1.3)
	self.scrollViewCourse:setPositionY(self.listviewBtns:getPositionY() + self.listviewBtns:getContentSize().height)

	self.originX = (self.scrollViewCourse:getContentSize().width - var_9_1:getContentSize().width) / 2
	self.originY = self.scrollViewCourse:getContentSize().height - var_9_1:getContentSize().height
end

function CourseCultivateLayer:registerEvents()
	Utility:registerNodeEvent(self)
	Utility:addClickEventListener(self.btnBack, handler(self, self.onBtnBack))
	Utility:addClickEventListener(self.btnReset, handler(self, self.onBtnReset))
	Utility:addClickEventListener(self.btnDetail, handler(self, self.onBtnDetail))
	Utility:addClickEventListener(self.btnItem, handler(self, self.onBtnItem))
	Utility:addClickEventListener(self.panelMain, handler(self, self.onPanelMain))
	EventManager:subscribe(self, EventManager.EVENT_IDS.GET_COURSE_DATA, handler(self, self.handleGetCourseData))
	EventManager:subscribe(self, EventManager.EVENT_IDS.COURSE_LEVEL_UP, handler(self, self.handleCourseLevelUp))
	EventManager:subscribe(self, EventManager.EVENT_IDS.COURSE_RESET, handler(self, self.handleCourseReset))
	LocalEvent:registerEvent(self, LocalEvent.EVENT_IDS.UPDATE_USER_ITEMS, handler(self, self.handleUpdateUserItems))
end

function CourseCultivateLayer:onPanelMain()
	if self.isScroll then
		return
	end

	local var_11_0 = PopCourseLayer:getInstance()

	if var_11_0 then
		var_11_0:hide()
	end
end

function CourseCultivateLayer:onScrollViewCourse(arg_12_1, arg_12_2)
	local var_12_0 = self.scrollViewCourse:getContentSize()
	local var_12_1 = self.scrollViewCourse:getInnerContainerSize()

	print("scrollView", arg_12_2)
end

function CourseCultivateLayer:initListViewBtns()
	self.listviewBtns:removeAllChildren()

	for iter_13_0, iter_13_1 in ipairs(var_0_16) do
		local var_13_0 = self.btnSwitch:clone()

		var_13_0:loadTextures(var_0_15 .. iter_13_1.on, var_0_15 .. iter_13_1.on, var_0_15 .. iter_13_1.off, var_0_8)
		self.listviewBtns:pushBackCustomItem(var_13_0)
		Utility:addClickEventListener(var_13_0, handler(self, self.onBtnSwitch), iter_13_0)

		var_13_0.courseType = iter_13_1.type
		self.switchBtns[#self.switchBtns + 1] = var_13_0
	end
end

function CourseCultivateLayer:updateScrollViewCourses()
	if self.isManulSwitch then
		self:resetScrollViewCourses()
	else
		local var_14_0 = 1

		for iter_14_0, iter_14_1 in ipairs(self.curCoursesData) do
			if iter_14_1.root then
				self:updateOnePanelCourse(self.panelCourses[var_14_0], iter_14_1.root)

				var_14_0 = var_14_0 + 1
			end

			for iter_14_2, iter_14_3 in ipairs(iter_14_1.leafs) do
				self:updateOnePanelCourse(self.panelCourses[var_14_0], iter_14_3)

				var_14_0 = var_14_0 + 1
			end
		end
	end

	if self.isManulSwitch then
		self.scrollViewCourse:jumpToPercentHorizontal(50)
		self.scrollViewCourse:jumpToPercentVertical(0)

		local var_14_1 = self:queryCourseDataByIndex(var_0_25)

		if self.isJump and self.panelCourses[var_0_25] and var_14_1 then
			self:onPanelCourse(self.panelCourses[var_0_25], var_14_1)

			self.isJump = false
		end

		self.isManulSwitch = false
	end
end

function CourseCultivateLayer:resetScrollViewCourses()
	self.scrollViewCourse:removeAllChildren()

	self.panelCourses = {}
	self.curSelectCourse = nil
	self.curCoursesData = self:getCourseDatas()

	local var_15_0 = 1

	for iter_15_0, iter_15_1 in ipairs(self.curCoursesData) do
		local var_15_1

		if iter_15_1.root then
			var_15_1 = self:createOnePanelCourse(iter_15_1.root, 0)

			var_15_1:setName("panelCourseRoot_" .. iter_15_0)
			self:updatePanelCoursePosition(var_15_1, iter_15_0, 0)

			self.panelCourses[#self.panelCourses + 1] = var_15_1

			if iter_15_0 ~= #self.curCoursesData then
				self:createOneLine(var_15_1, 0)
			end

			var_15_1.index = var_15_0
			var_15_0 = var_15_0 + 1
		end

		for iter_15_2, iter_15_3 in ipairs(iter_15_1.leafs) do
			local var_15_2 = iter_15_2 == 1 and -1 or 1
			local var_15_3 = self:createOnePanelCourse(iter_15_3, iter_15_2 == 1 and -1 or 1)

			self:updatePanelCoursePosition(var_15_3, iter_15_0, iter_15_2 == 1 and -1 or 1)

			self.panelCourses[#self.panelCourses + 1] = var_15_3

			self:createOneLine(var_15_1, var_15_2)

			var_15_3.index = var_15_0
			var_15_0 = var_15_0 + 1
		end
	end
end

function CourseCultivateLayer:updatePanelCoursePosition(arg_16_1, arg_16_2, arg_16_3)
	local var_16_2 = self.scrollViewCourse:getInnerContainerSize()
	local var_16_3 = arg_16_1:getContentSize()

	arg_16_1:setAnchorPoint(0.5, 0.5)
	arg_16_1:setPositionY(var_16_2.height - var_16_3.height / 2 - 60 - (arg_16_2 - 1) * (var_16_3.height + 120))
	arg_16_1:setPositionX(var_16_2.width / 2 + arg_16_3 * (var_16_3.width + 95))

	arg_16_1.hierarchy = arg_16_2
end

function CourseCultivateLayer:createOnePanelCourse(arg_17_1, arg_17_2)
	local var_17_0 = self.panelItem:clone()

	self.scrollViewCourse:addChild(var_17_0)
	self:updateOnePanelCourse(var_17_0, arg_17_1)

	var_17_0.direction = arg_17_2

	return var_17_0
end

function CourseCultivateLayer:createOneLine(arg_18_1, arg_18_2)
	local var_18_0 = ccui.ImageView:create(var_0_17 .. var_0_18[self.courseType], var_0_8)

	var_18_0:setAnchorPoint(0.5, 1)
	var_18_0:setRotation(-arg_18_2 * 90)

	local var_18_1 = arg_18_1:getContentSize()
	local var_18_2 = arg_18_1:getPositionY()

	var_18_0:setPositionX(arg_18_1:getPositionX() + arg_18_2 * var_18_1.width / 2)
	var_18_0:setPositionY(var_18_2 - ((arg_18_2 == 0 or nil) and (var_18_1.height / 2 or 0)))
	self.scrollViewCourse:addChild(var_18_0)

	return var_18_0
end

function CourseCultivateLayer:updateOnePanelCourse(arg_19_1, arg_19_2)
	if not arg_19_1 then
		print("error: miss panelCourse")

		return
	end

	local var_19_0 = arg_19_1:getChildByName("imgBorder")
	local var_19_1 = arg_19_1:getChildByName("imgIcon")
	local var_19_2 = arg_19_1:getChildByName("labelCourse")
	local var_19_3 = arg_19_1:getChildByName("imgLevel")
	local var_19_4 = arg_19_1:getChildByName("imgLock")
	local var_19_5 = arg_19_1:getChildByName("imgMask")

	var_19_2:setString(arg_19_2.courseName)
	var_19_2:setFontSize(16)

	arg_19_1.courseId = arg_19_2.courseId
	arg_19_1.isRoot = arg_19_2.isRoot

	arg_19_1:setScale(arg_19_2.isRoot and 1 or 0.7)
	var_19_4:setVisible(not arg_19_2.unlock)

	if arg_19_2.courseLevel > 0 then
		var_19_3:setVisible(arg_19_2.unlock)

		if arg_19_2.courseLevel < #arg_19_2.courses then
			var_19_3:loadTexture("gamecourse/level_" .. arg_19_2.courseLevel .. ".png", var_0_8)
		else
			var_19_3:loadTexture("gamecourse/level_max.png", var_0_8)
		end
	else
		var_19_3:setVisible(false)
	end

	var_19_1:setOpacity(arg_19_2.unlock and 255 or 76.5)
	var_19_1:loadTexture(var_0_21 .. var_0_22[arg_19_2.courseIcon], var_0_8)
	var_19_2:setOpacity(arg_19_2.unlock and 255 or 38.25)
	var_19_0:loadTexture((arg_19_2.courseLevel == #arg_19_2.courses or nil) and (var_0_19 .. var_0_20[self.courseType].max or var_0_19 .. var_0_20[self.courseType].normal), var_0_8)
	Utility:addClickEventListener(arg_19_1, handler(self, self.onPanelCourse), arg_19_2)

	if arg_19_1 == self.curSelectCourse then
		arg_19_1:setScale(1)
	end
end

function CourseCultivateLayer:getCourseDatas()
	return var_0_7:getCourseDatasByType(self.courseType, true)
end

function CourseCultivateLayer:onPanelCourse(arg_21_1, arg_21_2)
	if self.isScroll then
		return
	end

	if not arg_21_2.unlock and var_0_7:hadLeafCourseLevelUp(arg_21_2) then
		global_ShowBlockWords("不能同时升级多个副课程")

		return
	end

	self:setSelectCourseStatus(self.curSelectCourse, false)

	self.curSelectCourse = arg_21_1

	self:setSelectCourseStatus(self.curSelectCourse, true)

	var_0_25 = arg_21_1.index

	local var_21_0 = PopCourseLayer:getInstance()

	if var_21_0 then
		var_21_0:updateCourseData(arg_21_2)
	else
		LayerManager:pushInLayer("PopCourseLayer", {
			courseData = arg_21_2,
			positionY = self.imgBottom:getContentSize().height,
			hideCallFunc = function()
				self:stopAllActions()
				self:runAction(cc.Sequence:create(cc.CallFunc:create(function()
					self.scrollViewCourse:setDirection(cc.SCROLLVIEW_DIRECTION_BOTH)
					self.scrollViewCourse:scrollToPercentHorizontal(50, 0.18, false)
				end), cc.DelayTime:create(0.2), cc.CallFunc:create(function()
					self.scrollViewCourse:setTouchEnabled(true)
					self.scrollViewCourse:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
				end)))
				self:setMaskVisible(false)
			end
		})
	end

	self.scrollViewCourse:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	self.scrollViewCourse:setTouchEnabled(false)
	self:updateScrollViewInnerPosition()
end

function CourseCultivateLayer:updateScrollViewInnerPosition()
	local var_25_0 = self.scrollViewCourse:getInnerContainer()
	local var_25_1 = self.curSelectCourse.hierarchy

	self:hideMask()

	self.isScroll = true

	var_25_0:runAction((cc.Sequence:create(cc.MoveTo:create(math.max(math.abs(self.originY + (self.curSelectCourse.hierarchy < self.contrastHierarchy and 0 or (var_25_1 - self.contrastHierarchy) * 248) - var_25_0:getPositionY()), math.abs(self.originX - self.curSelectCourse.direction * 238 - var_25_0:getPositionX())) / 600, cc.p(self.originX - self.curSelectCourse.direction * 238, self.originY + (self.curSelectCourse.hierarchy < self.contrastHierarchy and 0 or (var_25_1 - self.contrastHierarchy) * 248))), cc.CallFunc:create(function()
		self:setMaskVisible(true)

		self.isScroll = false
	end))))
end

function CourseCultivateLayer:showMask()
	if self.clipNode then
		self.clipNode:setVisible(true)
	end
end

function CourseCultivateLayer:hideMask()
	if self.clipNode then
		self.clipNode:setVisible(false)
	end
end

function CourseCultivateLayer:setMaskVisible(arg_29_1)
	if not self.clipNode then
		local var_29_0 = cc.DrawNode:create()

		var_29_0:drawSolidRect(cc.p(0, 0), cc.p(GameDisplay.size.width, GameDisplay.size.height), cc.c4f(0, 0, 0, 0.3))

		self.clipNode = cc.ClippingNode:create()

		self.clipNode:setInverted(true)

		self.stencilNode = cc.DrawNode:create()

		self.stencilNode:drawSolidRect(cc.p(0, 0), cc.p(GameDisplay.size.width, GameDisplay.size.height), cc.c4f(1, 1, 1, 1))
		self.clipNode:setStencil(self.stencilNode)
		self.clipNode:addChild(var_29_0)
		self.clipNode:setPositionY(-GameDisplay.fix_y)
		self:addChild(self.clipNode)
	end

	self.clipNode:setVisible(arg_29_1)

	if not self.curSelectCourse then
		return
	end

	self.curSelectCourse:getChildByName("imgMask"):setVisible(arg_29_1)

	if not arg_29_1 then
		self:setSelectCourseStatus(self.curSelectCourse, false, true)
	end

	self.stencilNode:clear()

	local var_29_1 = self:convertToNodeSpace(self.curSelectCourse:convertToWorldSpace(cc.p(0, 0)))

	var_29_1.y = var_29_1.y + GameDisplay.fix_y - 26
	var_29_1.x = var_29_1.x - 26

	self.stencilNode:drawSolidRect(var_29_1, cc.p(var_29_1.x + 180, var_29_1.y + 180), cc.c4f(1, 1, 1, 1))
end

function CourseCultivateLayer:findRootPanelByHierarchy(arg_30_1)
	local var_30_0 = Utility:indexOf(self.panelCourses, function(arg_31_0)
		return arg_31_0.hierarchy == arg_30_1 and arg_31_0.isRoot
	end)

	if var_30_0 < 0 then
		return nil
	end

	return self.panelCourses[var_30_0]
end

function CourseCultivateLayer:setSelectCourseStatus(arg_32_1, arg_32_2, arg_32_3)
	if not arg_32_1 then
		return
	end

	local var_32_0 = arg_32_1:getChildByName("sprSelect")

	if not var_32_0 then
		var_32_0 = cc.Sprite:create("gamecourse/pop/select_01.png")

		var_32_0:setPosition(arg_32_1:getContentSize().width / 2 - 4, arg_32_1:getContentSize().height / 2)
		var_32_0:setName("sprSelect")
		arg_32_1:addChild(var_32_0)
		var_32_0:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Animate:create((self:createSelectAni())), cc.DelayTime:create(1))))
	end

	var_32_0:setVisible(arg_32_2 or arg_32_3)
	arg_32_1:getChildByName("imgMask"):setVisible(arg_32_2)

	if arg_32_1.isReset and not arg_32_2 then
		return
	end

	if not arg_32_1.isRoot then
		if arg_32_2 then
			arg_32_1:setScale(1)
			arg_32_1:setPositionX(arg_32_1:getPositionX() + arg_32_1.direction * 15)

			arg_32_1.isReset = false
		else
			arg_32_1:setScale(0.7)
			arg_32_1:setPositionX(arg_32_1:getPositionX() - arg_32_1.direction * 15)

			arg_32_1.isReset = true
		end
	end
end

function CourseCultivateLayer:createSelectAni()
	local var_33_0 = cc.AnimationCache:getInstance():getAnimation("aniSelect")

	if var_33_0 then
		return var_33_0
	end

	local var_33_1 = {}

	if config._DEBUG then
		for iter_33_0 = 1, 9 do
			local var_33_2 = cc.Director:getInstance():getTextureCache():addImage("gamecourse/pop/select_0" .. iter_33_0 .. ".png")

			var_33_1[#var_33_1 + 1] = cc.SpriteFrame:createWithTexture(var_33_2, cc.rect(0, 0, var_33_2:getContentSize().width, var_33_2:getContentSize().height))
		end
	else
		for iter_33_1 = 1, 9 do
			var_33_1[#var_33_1 + 1] = cc.SpriteFrameCache:getInstance():getSpriteFrameByName("gamecourse/pop/select_0" .. iter_33_1 .. ".png")
		end
	end

	local var_33_3 = cc.Animation:createWithSpriteFrames(var_33_1)

	var_33_3:setRestoreOriginalFrame(false)
	var_33_3:setDelayPerUnit(0.05)
	cc.AnimationCache:getInstance():addAnimation(var_33_3, "aniSelect")

	return var_33_3
end

function CourseCultivateLayer:onBtnBack()
	var_0_25 = nil
	var_0_26 = nil

	LayerManager:switchShowLayer(self.returnLayer)
end

function CourseCultivateLayer:hasStudiedCourse()
	if not self.curCoursesData or #self.curCoursesData == 0 then
		return
	end

	if not self.curCoursesData[1].root then
		print("course data error")

		return false
	end

	if self.curCoursesData[1].root.unlock and self.curCoursesData[1].root.courseLevel > 0 then
		return true
	end

	for iter_35_0, iter_35_1 in ipairs(self.curCoursesData[1].leafs) do
		if iter_35_1.courseLevel > 0 then
			return true
		end
	end

	return false
end

function CourseCultivateLayer:onBtnReset()
	if not self:hasStudiedCourse() then
		global_ShowBlockWords("该课程未升级")

		return
	end

	if self.isRequesting then
		return
	end

	self.isRequesting = true

	LayerManager:pushInLayer("PopMsgLayer", {
		msgType = 1,
		costType = 1,
		strInfo = L_RESET[1],
		costNum = var_0_7:getResetCost(self.courseType),
		cancelCallBack = function()
			self.isRequesting = false
		end,
		confirmCallBack = function()
			self.isManulSwitch = true

			EventManager:requestCourseReset(self.courseType, 0)
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

function CourseCultivateLayer:onBtnDetail()
	LayerManager:pushInLayer("PopActivityDetail", {
		key = var_0_14[self.courseType]
	})
end

function CourseCultivateLayer:onBtnItem()
	LayerManager:pushInLayer("PopItemLayer", {
		itemid = self.needItemId
	})
end

function CourseCultivateLayer:onBtnSwitch(arg_41_1, arg_41_2)
	if PopCourseLayer:getInstance() then
		return
	end

	if self.courseType == var_0_11.BASE then
		return
	end

	for iter_41_0, iter_41_1 in ipairs(self.switchBtns) do
		if arg_41_1 ~= iter_41_1 then
			iter_41_1:setTouchEnabled(true)
			iter_41_1:setBright(false)
		else
			iter_41_1:setTouchEnabled(false)
			iter_41_1:setBright(true)
		end
	end

	self:showPageWithIndex(arg_41_2)

	self.isManulSwitch = true
end

function CourseCultivateLayer:showPageWithIndex(arg_42_1)
	if self.switchBtns[arg_42_1].courseType == self.courseType then
		return
	end

	self.courseType = self.switchBtns[arg_42_1].courseType
	var_0_26 = self.courseType

	self:updateTopUI()
	self:updateBottomUI()
	EventManager:requestGetCourseData(self.courseType)
end

function CourseCultivateLayer:updateTopUI()
	self.imgTitle:loadTexture(var_0_12 .. var_0_13[self.courseType], var_0_8)

	if self.courseType == var_0_11.DRAK_MATTER or self.courseType == var_0_11.DEVIL or self.courseType == var_0_11.POSITIVE then
		local var_43_0 = self.btnDetail:getPositionX()

		self.btnDetail:setPositionX(220)
	else
		self.btnDetail:setPositionX(188)
	end
end

function CourseCultivateLayer:updateBottomUI()
	self.listviewBtns:setVisible(self.courseType ~= var_0_11.BASE)

	if not self.imgLogo then
		self.imgLogo = ccui.ImageView:create(var_0_23 .. var_0_24[self.courseType], var_0_8)

		self.imgLogo:setLocalZOrder(-1)
		self.imgLogo:setPosition(self.panelMain:getContentSize().width / 2, self.panelMain:getContentSize().height / 2)
		self.panelMain:addChild(self.imgLogo)
	end

	self.imgLogo:setVisible(false)
	self.imgLogo:loadTexture(var_0_23 .. var_0_24[self.courseType], var_0_8)

	self.needItemId = self.curCoursesData[1].root.courses[1].needItem

	self.labelOwn:setString("x" .. item_manager:getItemNumber(self.needItemId))

	local var_44_0 = string.format("equipment/%d.png", item_data[self.needItemId].image_id)

	self.btnItem:loadTextures(var_44_0, var_44_0, var_44_0)
	self.btnItem:ignoreContentAdaptWithSize(false)
	self.btnItem:setContentSize(cc.size(60, 60))
end

function CourseCultivateLayer:onEnter()
	EventManager:requestGetCourseData(self.courseType)
end

function CourseCultivateLayer:onExit()
	self.panelItem:release()
	self.btnSwitch:release()
	EventManager:unsubscribe(self)
	LocalEvent:removeEvent(self)
end

function CourseCultivateLayer:handleGetCourseData(arg_47_1)
	if not arg_47_1 then
		return
	end

	if not arg_47_1.result or arg_47_1.result == 1 then
		var_0_7:updateCourseDatas(arg_47_1.course_data, self.courseType)
		LocalEvent:triggerEvent(LocalEvent.EVENT_IDS.UPDATE_COURSE_DATA)
		self:updateScrollViewCourses()
		self:updateTopUI()
		self:updateBottomUI()
	end

	print("handleGetCourseData", arg_47_1)
end

function CourseCultivateLayer:handleCourseLevelUp(arg_48_1)
	if not arg_48_1 then
		return
	end

	print("handleCourseLevelUp", arg_48_1)
end

function CourseCultivateLayer:handleCourseReset(arg_49_1)
	self.isRequesting = false

	if not arg_49_1 then
		return
	end

	if arg_49_1.result then
		if arg_49_1.result == 1 then
			global_gain({
				items = arg_49_1.items
			})

			playermodel.gold = playermodel.gold - arg_49_1.costdiamond

			global_update_gold_stone_diamond(nil, nil, -arg_49_1.costdiamond)
			EventManager:requestGetCourseData(self.courseType)
			self:updateBottomUI()
		elseif arg_49_1.result and arg_49_1.result == 2 then
			global_ShowBlockWords("该课程未升级")
		elseif arg_49_1.result and arg_49_1.result == 3 then
			global_ShowBlockWords("重置课程所需魂晶数量不足")
		elseif arg_49_1.result and arg_49_1.result == 4 then
			global_ShowBlockWords("需要先重置后置课程")
		end
	end
end

function CourseCultivateLayer:handleUpdateUserItems()
	self:updateBottomUI()
end

return CourseCultivateLayer
