SchoolCinemaLayer = class("SchoolCinemaLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = {
	PLOT_DEEP = 4,
	PLOT_DETAIL = 3,
	PLOT = 2,
	MAIN = 1
}
local var_0_1 = {
	"SchoolCinemaLayer/plot_detail/plot4/dream_unknow.png",
	"SchoolCinemaLayer/plot_detail/plot4/dream_lock.png",
	"SchoolCinemaLayer/plot_detail/plot4/dream_play.png"
}
local var_0_2 = {
	cc.p(180, 105),
	cc.p(138, 133),
	cc.p(142, 130),
	cc.p(180, 101),
	cc.p(145, 104),
	cc.p(143, 106)
}
local var_0_3 = {
	cc.p(5, 155),
	cc.p(70, 25),
	cc.p(-5, 175),
	cc.p(10, -10),
	cc.p(90, 155),
	cc.p(80, 0)
}
local var_0_4 = {
	cc.p(150, 133),
	cc.p(165, 187),
	cc.p(150, 125),
	cc.p(210, 123),
	cc.p(150, 115),
	cc.p(145, 113)
}
local var_0_5 = {
	cc.p(150, 100),
	cc.p(165, 155),
	cc.p(150, 95),
	cc.p(210, 90),
	cc.p(150, 83),
	cc.p(145, 80)
}
local var_0_6 = "mainScenebg/schoolcinema/plot/bg.png"
local var_0_7 = {
	"SchoolCinemaLayer/plot/plot_title1.png",
	"SchoolCinemaLayer/plot/plot_title2.png",
	"SchoolCinemaLayer/plot/plot_title3.png",
	"SchoolCinemaLayer/plot/plot_title4.png",
	"SchoolCinemaLayer/plot/plot_title5.png",
	"SchoolCinemaLayer/plot/plot_title6.png"
}
local school_cinema_manager = require("controller.school_cinema_manager")
local level_manager = require("controller.level_manager")
local RichTextPro = require("view.Sprite.RichTextPro")
local var_0_11 = config._DEBUG and 0 or 1

function SchoolCinemaLayer:getExitParam()
	return cloneconf(self.initconfig)
end

function SchoolCinemaLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = SchoolCinemaLayer.new()

	var_3_0:onLoad(arg_3_1)

	return var_3_0
end

function SchoolCinemaLayer:fullscreen()
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))

	self.btn_return.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.btn_return:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.btn_return:setPositionY(self.btn_return.full_posY)

	local var_4_0 = self.rootLayer:getChildByName("di")

	var_4_0.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, var_4_0:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	var_4_0:setPositionY(var_4_0.full_posY)
	self.titleNode:setPositionY((GameDisplay.height + GameDisplay.fix_y - 1136) / 2 + self.titleNode:getPositionY())
	self.mainNode:setPositionY((GameDisplay.height + GameDisplay.fix_y - 1136) / 12 * 5 + self.mainNode:getPositionY())
	self.downTitleNode:setPositionY((GameDisplay.height + GameDisplay.fix_y - 1136) / 3 + self.downTitleNode:getPositionY())
	self.plotNode:setContentSize(cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y))

	self.plotNode.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.plotNode:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.plotNode:setPositionY(self.plotNode.full_posY)

	local var_4_1 = self.plotNode:getChildren()

	for iter_4_0 = 1, #var_4_1 do
		if var_4_1[iter_4_0]:getName() ~= "bg" then
			var_4_1[iter_4_0].full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - var_4_1[iter_4_0]:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

			var_4_1[iter_4_0]:setPositionY(var_4_1[iter_4_0].full_posY)
		end
	end

	self.plotDetailNode:setContentSize(cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y))

	self.plotDetailNode.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.plotDetailNode:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.plotDetailNode:setPositionY(self.plotDetailNode.full_posY)

	local var_4_2 = self.plotDetailNode:getChildren()

	for iter_4_1 = 1, #var_4_2 do
		if var_4_2[iter_4_1]:getName() ~= "bg" then
			var_4_2[iter_4_1].full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - var_4_2[iter_4_1]:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

			var_4_2[iter_4_1]:setPositionY(var_4_2[iter_4_1].full_posY)
		end
	end
end

function SchoolCinemaLayer:updateMainPanelRedDot(arg_5_1)
	if self.btnPlotList[arg_5_1] ~= nil then
		self.btnPlotList[arg_5_1]:getChildByName("new"):setVisible(school_cinema_manager:isNew(i))
	end
end

function SchoolCinemaLayer.updatePlotPanelRedDot(arg_6_0, arg_6_1)
	return
end

function SchoolCinemaLayer:initPanel()
	local var_7_0 = school_cinema_manager:getCinemaInfo()

	if var_7_0 == nil or next(var_7_0) == nil then
		return
	end

	self.curPanelIndex = var_0_0.MAIN

	for iter_7_0 = 1, #self.btnPlotList do
		local var_7_1 = self.btnPlotList[iter_7_0]:getChildByName("new")
		local var_7_2 = self.btnPlotList[iter_7_0]:getChildByName("num")

		var_7_1:setVisible(school_cinema_manager:isNew(iter_7_0))
		var_7_2:setString(var_7_0[iter_7_0] and var_7_0[iter_7_0].process)
	end

	if self.initconfig and next(self.initconfig) then
		self:showPlotPanel(self.initconfig.index or 2)

		if self.initconfig.detailIndex ~= nil then
			if self.initconfig.index == 1 then
				self:showPlotDetail1Panel(self.initconfig.index, self.initconfig.detailIndex)
			elseif self.initconfig.index == 2 then
				self:showPlotDetail2Panel(self.initconfig.index, self.initconfig.detailIndex)
			elseif self.initconfig.index == 3 then
				self:showPlotDetail3Panel(self.initconfig.index, self.initconfig.detailIndex)
			elseif self.initconfig.index == 4 then
				self:showPlotDetail4Panel(self.initconfig.index, self.initconfig.detailIndex)
			elseif self.initconfig.index == 5 then
				self:showPlotDetail5Panel(self.initconfig.index, self.initconfig.detailIndex)
			elseif self.initconfig.index == 6 then
				self:showPlotDetail6Panel(self.initconfig.index, self.initconfig.detailIndex)
			end
		end
	end
end

function SchoolCinemaLayer:onBtnPhotoCallback(arg_8_1)
	self.curPanelIndex = var_0_0.PLOT_DETAIL

	self.plotNode:setVisible(false)
	self.plotDetailNode:getChildByName("bg"):loadTexture(var_0_6)
	self.plotDetailNode:setVisible(true)
	self:removeNewTitleForServant()
	self.plotDetailNode:getChildByName("title_bg"):setVisible(false)
	self.plotDetailNode:getChildByName("title"):setVisible(false)
	self.plotDetailNode:getChildByName("title_en"):setVisible(false)
	self.plotDetailNode:getChildByName("bracket_top"):setVisible(false)
	self.plotDetailNode:getChildByName("bracket_down"):setVisible(false)
	self.plotDetailNode:getChildByName("des"):setVisible(false)

	local var_8_0 = ccui.ImageView:create("SchoolCinemaLayer/plot_detail/plot3/photo_title_2.png", var_0_11)

	var_8_0:setPosition(cc.p(490, GameDisplay.height - 76))
	var_8_0:setName("photoTitle")
	self.plotDetailNode:addChild(var_8_0)

	local var_8_1 = 640
	local var_8_2 = 420
	local var_8_3 = false
	local var_8_4 = 4
	local var_8_5 = {
		cc.p(165, 315),
		cc.p(475, 295),
		cc.p(165, 115),
		(cc.p(475, 95))
	}

	if self.detailViewNode ~= nil then
		self.detailViewNode:removeFromParent()

		self.detailViewNode = nil
	end

	self.detailViewNode = self:getTableView(arg_8_1, math.ceil(#arg_8_1 / 4), function(arg_9_0)
		if arg_9_0 == 0 then
			return var_8_1, var_8_2 + 60
		else
			return var_8_1, var_8_2 - 20
		end
	end, cc.size(640, GameDisplay.height), function(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = arg_10_0:dequeueCell()

		if var_10_0 == nil then
			var_10_0 = cc.TableViewCell:new()
		end

		local var_10_1 = var_10_0:getChildByName("detailItem")

		if var_10_1 then
			var_10_1:removeFromParent()
		end

		local var_10_3 = ccui.Layout:create()

		var_10_3:setContentSize(cc.size(var_8_1, var_8_2))
		var_10_3:setVisible(true)
		var_10_3:setName("detailItem")
		var_10_3:setTouchEnabled(false)
		var_10_0:addChild(var_10_3)

		for iter_10_0 = 1, var_8_4 do
			local var_10_4 = arg_10_2[arg_10_1 * var_8_4 + iter_10_0]
			local var_10_5 = var_10_3:getChildByName("item" .. iter_10_0)

			if var_10_5 == nil then
				var_10_5 = ccui.Layout:create()

				var_10_5:setContentSize(cc.size(640, 200))
				var_10_5:setName("item" .. iter_10_0)
				var_10_5:setPosition(var_8_5[iter_10_0])
				var_10_3:addChild(var_10_5)
			end

			if var_10_4 ~= nil then
				var_10_5:setVisible(true)

				local var_10_6 = ccui.Button:create("SchoolCinemaLayer/plot_detail/plot3/photo_clip" .. iter_10_0 .. ".png", "SchoolCinemaLayer/plot_detail/plot3/photo_clip" .. iter_10_0 .. ".png", "SchoolCinemaLayer/plot_detail/plot3/photo_clip" .. iter_10_0 .. ".png", var_0_11)

				var_10_6:setSwallowTouches(false)
				var_10_5:addChild(var_10_6)
				var_10_6:addTouchEventListener(function(arg_11_0, arg_11_1)
					if arg_11_1 ~= ccui.TouchEventType.ended then
						return
					end

					if math.abs(arg_11_0:getTouchBeganPosition().y - arg_11_0:getTouchEndPosition().y) > 30 then
						return
					end

					if var_8_3 == true then
						return
					end

					var_8_3 = true

					print("click")
					self:clickPostCardCallback(var_10_4)
					self:lateUpdate(function()
						var_8_3 = false
					end)
				end)

				local var_10_7

				if config._DEBUG then
					var_10_7 = cc.Sprite:create("SchoolCinemaLayer/plot_detail/plot3/photo_mask" .. iter_10_0 .. ".png") or cc.Sprite:createWithSpriteFrameName("SchoolCinemaLayer/plot_detail/plot3/photo_mask" .. iter_10_0 .. ".png")
				end

				local var_10_8 = cc.Sprite:create(var_10_4.itemPath)
				local var_10_9 = var_10_5:getChildByName("clip")

				if var_10_9 == nil then
					var_10_9 = cc.ClippingNode:create(var_10_7)

					var_10_9:setName("clip")
					var_10_5:addChild(var_10_9)
				end

				var_10_9:setAlphaThreshold(0)
				var_10_9:setScale(0.98)
				var_10_9:addChild(var_10_8)

				local var_10_10 = ccui.ImageView:create("SchoolCinemaLayer/plot_detail/plot3/photo_name_bg.png", var_0_11)

				var_10_10:setAnchorPoint(cc.p(0, 0))
				var_10_10:setPosition(cc.p(-160, 50))

				local var_10_11 = ccui.Text:create("", FONT_NAME, 22)

				var_10_11:setString(var_10_4.title)
				var_10_11:setAnchorPoint(cc.p(0, 0))
				var_10_11:setPosition(cc.p(-130, 65))
				var_10_11:setRotation(-3)
				var_10_5:addChild(var_10_10)
				var_10_5:addChild(var_10_11)
			else
				var_10_5:setVisible(false)
			end
		end

		return var_10_0
	end, function(arg_13_0, arg_13_1)
		print("click ")
	end)

	self.detailViewNode:setPosition(cc.p(4, 0))
	self.plotDetailNode:addChild(self.detailViewNode)
end

function SchoolCinemaLayer:onLoad(arg_14_1)
	self.initconfig = arg_14_1 or {}
	self.scheduler = cc.Director:getInstance():getScheduler()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "SchoolCinemaLayer.json" or "SchoolCinemaLayer.ExportJson")

	self:addChild(self.rootLayer)

	self.titleNode = self.rootLayer:getChildByName("title")
	self.downTitleNode = self.rootLayer:getChildByName("down_title")
	self.mainNode = self.rootLayer:getChildByName("main")
	self.plotNode = self.rootLayer:getChildByName("plot")
	self.plotTitleNode = self.plotNode:getChildByName("title")
	self.plotBgNode = self.plotNode:getChildByName("bg")
	self.plotDetailNode = self.rootLayer:getChildByName("plot_detail")
	self.plotBtn_photo = ccui.ImageView:create("SchoolCinemaLayer/plot/plot3/btn_photo.png", var_0_11)

	self.plotBtn_photo:setTouchEnabled(true)
	self.plotBtn_photo:setPosition(cc.p(520, 880))
	self.plotNode:addChild(self.plotBtn_photo, 99)

	self.btnPlotList = {}

	for iter_14_0 = 1, 6 do
		local var_14_0 = self.mainNode:getChildByName("bg_" .. iter_14_0)

		var_14_0.index = iter_14_0

		var_14_0:loadTexture("mainScenebg/schoolcinema/bg_" .. iter_14_0 .. ".png")

		self.btnPlotList[iter_14_0] = var_14_0

		var_14_0:addTouchEventListener(function(arg_15_0, arg_15_1)
			if arg_15_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.initconfig.index = arg_15_0.index

			self:showPlotPanel(arg_15_0.index)
		end)
	end

	self.curPanelIndex = var_0_0.MAIN

	self.rootLayer:getChildByName("di"):setLocalZOrder(999)

	self.btn_return = self.rootLayer:getChildByName("btn_return")

	self.btn_return:setLocalZOrder(999)
	self.btn_return:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curPanelIndex == var_0_0.MAIN then
			KeyCodeManager:onKeyReleasedCallFunc()
		elseif self.curPanelIndex == var_0_0.PLOT then
			self:closePlotPanel()
		elseif self.curPanelIndex == var_0_0.PLOT_DETAIL then
			self:closePlotDetailPanel()
		elseif self.curPanelIndex == var_0_0.PLOT_DEEP then
			self:closePlotDeepPanel()
		end
	end)
	school_cinema_manager:init(function()
		self:initPanel()
	end)
	self:fullscreen()
	self:registerScriptHandler(function(arg_18_0)
		if arg_18_0 == "exit" then
			if self.cinemaScheduler ~= nil then
				self.scheduler:unscheduleScriptEntry(self.cinemaScheduler)

				self.cinemaScheduler = nil
			end

			school_cinema_manager:clearInfo()
		end
	end)
	AnalyticManager.enterCinema()
end

function SchoolCinemaLayer:closePlotPanel()
	self.initconfig.index = nil

	self.plotNode:setVisible(false)
	self.mainNode:setVisible(true)
	self.titleNode:setVisible(true)
	self.downTitleNode:setVisible(true)

	self.curPanelIndex = var_0_0.MAIN

	if self.listViewNode ~= nil then
		self.listViewNode:removeFromParent()

		self.listViewNode = nil
	end
end

function SchoolCinemaLayer:closePlotDetailPanel()
	self.initconfig.detailIndex = nil

	self.plotNode:setVisible(true)
	self.plotDetailNode:setVisible(false)

	self.curPanelIndex = var_0_0.PLOT

	if self.detailViewNode ~= nil then
		self.detailViewNode:removeFromParent()

		self.detailViewNode = nil
	end
end

function SchoolCinemaLayer:removeNewTitleForServant()
	local var_21_0 = self.plotDetailNode:getChildByName("newTitle")

	if var_21_0 then
		var_21_0:removeFromParent()
	end

	local var_21_2 = self.plotDetailNode:getChildByName("photoTitle")

	if var_21_2 then
		var_21_2:removeFromParent()
	end

	self.plotDetailNode:getChildByName("title"):setVisible(true)
	self.plotDetailNode:getChildByName("title_bg"):setVisible(true)
	self.plotDetailNode:getChildByName("title_en"):setVisible(true)
	self.plotDetailNode:getChildByName("des"):setVisible(true)
	self.plotDetailNode:getChildByName("bracket_top"):setVisible(true)
	self.plotDetailNode:getChildByName("bracket_down"):setVisible(true)
end

function SchoolCinemaLayer:addNewTitleForServant()
	self:removeNewTitleForServant()

	local var_22_0 = ccui.ImageView:create("SchoolCinemaLayer/plot/plot_title4.png", var_0_11)

	var_22_0:setName("newTitle")
	var_22_0:setPosition(cc.p(14, 1048))
	var_22_0:setAnchorPoint(cc.p(0, 0))
	self.plotDetailNode:addChild(var_22_0)
	self.plotDetailNode:getChildByName("title"):setVisible(false)
	self.plotDetailNode:getChildByName("title_bg"):setVisible(false)
	self.plotDetailNode:getChildByName("title_en"):setVisible(false)
	self.plotDetailNode:getChildByName("des"):setVisible(false)
	self.plotDetailNode:getChildByName("bracket_top"):setVisible(false)
	self.plotDetailNode:getChildByName("bracket_down"):setVisible(false)

	var_22_0.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - var_22_0:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	var_22_0:setPositionY(var_22_0.full_posY)
end

function SchoolCinemaLayer:openDeepPanel(arg_23_1)
	self.curPanelIndex = var_0_0.PLOT_DEEP

	if self.deepViewNode == nil then
		self.deepViewNode = self.deepItemNode:getChildByName("item_deep1"):clone()

		self.deepViewNode:setVisible(true)
		self.rootLayer:addChild(self.deepViewNode)
	end

	self.deepViewNode:setVisible(true)
	self.deepViewNode:setContentSize(cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y))

	local var_23_0 = school_cinema_manager:getCinemaInfo(1)[2]

	self.deepViewNode:getChildByName("bg"):loadTexture("mainScenebg/schoolcinema/plot_deep/plot1_2/bg_basic.png")

	local var_23_1 = self.deepViewNode:getChildByName("icon")

	var_23_1:setAnchorPoint(cc.p(0, 1))

	local var_23_2 = self.deepViewNode:getChildByName("mask")

	var_23_2:setContentSize(cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y))
	var_23_2:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		onResumeItemCallback()
	end)
	var_23_2:setVisible(false)

	local var_23_3 = (GameDisplay.height + GameDisplay.fix_y - 1136) / 2
	local var_23_4 = (GameDisplay.height + GameDisplay.fix_y - 1136) / 4

	for iter_23_0 = 1, #var_23_0 do
		local var_23_5 = self.deepViewNode:getChildByName("panel" .. iter_23_0)

		if var_23_5 and iter_23_0 ~= arg_23_1 then
			var_23_5:setVisible(false)
		elseif var_23_5 and iter_23_0 == arg_23_1 then
			var_23_5:setVisible(true)
			var_23_1:loadTexture("mainScenebg/schoolcinema/plot_deep/plot1_2/bg_item" .. iter_23_0 .. ".png")
			var_23_1:setPosition(cc.p(0, 1150 + (GameDisplay.height + GameDisplay.fix_y - 1136) / 2))

			local var_23_6 = var_23_0[iter_23_0].studentList

			function onResumeItemCallback()
				var_23_1:loadTexture("mainScenebg/schoolcinema/plot_deep/plot1_2/bg_item" .. iter_23_0 .. ".png")
				var_23_1:setPosition(cc.p(0, 1150 + var_23_3))

				for iter_25_0 = 1, #var_23_6 do
					local var_25_0 = var_23_5:getChildByName("item" .. iter_25_0)

					var_25_0:stopAllActions()
					var_25_0:setVisible(true)

					if var_25_0.oldPosx and var_25_0.oldPosy then
						var_25_0:runAction((cc.Sequence:create(cc.CallFunc:create(function()
							for iter_26_0, iter_26_1 in pairs((var_25_0:getChildren())) do
								iter_26_1:setVisible(true)
							end
						end), cc.MoveTo:create(0.5, cc.p(var_25_0.oldPosx, var_25_0.oldPosy)))))
					end
				end

				var_23_2:setVisible(false)
				self.btn_return:setVisible(true)
				self.rootLayer:getChildByName("di"):setVisible(true)
			end

			function onBtnItemCallback(arg_27_0)
				var_23_1:loadTexture("mainScenebg/schoolcinema/plot_deep/plot1_2/item" .. arg_23_1 .. "_mask.png")
				var_23_1:setPosition(cc.p(20, 1150 + var_23_3))

				for iter_27_0 = 1, #var_23_6 do
					local var_27_0 = var_23_5:getChildByName("item" .. iter_27_0)

					var_27_0:stopAllActions()

					if iter_27_0 == arg_27_0.index then
						var_27_0:setVisible(true)
						var_27_0:runAction((cc.Sequence:create(cc.CallFunc:create(function()
							for iter_28_0, iter_28_1 in pairs((var_27_0:getChildren())) do
								iter_28_1:setVisible(false)
							end
						end), cc.MoveTo:create(0.5, cc.p(GameDisplay.width / 2 - var_27_0:getContentSize().width / 2, GameDisplay.height / 2 - var_27_0:getContentSize().height / 2)))))
					else
						var_27_0:setVisible(false)
					end
				end

				var_23_2:setVisible(true)

				local var_27_1 = var_23_2:getChildByName("show")

				var_27_1:setTouchEnabled(false)

				local var_27_2 = var_27_1:getChildByName("name")

				var_27_2:setPosition(cc.p(626, 412 + var_23_4 - 110))
				var_27_1:getChildByName("line"):setPosition(cc.p(139, 354 + var_23_4 - 110))

				local var_27_3 = var_27_1:getChildByName("name_en")

				var_27_3:setPosition(cc.p(621, 373 + var_23_4 - 110))
				var_27_2:setString(var_23_6[arg_27_0.index].name)
				var_27_3:setString(var_23_6[arg_27_0.index].nameEn)

				if var_23_2:getChildByName("scrollView") then
					var_23_2:getChildByName("scrollView"):removeFromParent()
				end

				local var_27_4 = var_23_6[arg_27_0.index].words
				local var_27_5 = ccui.ImageView:create("mainScenebg/schoolcinema/plot_deep/plot1_2/text_bg.png")

				var_27_5:setAnchorPoint(cc.p(0, 0))
				var_27_5:setName("bg")
				var_27_1:addChild(var_27_5, -1)

				local var_27_6 = ccui.Text:create(var_27_4, FONT_W5, 20)
				local var_27_7 = var_27_6:getContentSize().height

				var_27_6:ignoreContentAdaptWithSize(false)
				var_27_6:setContentSize(cc.size(600, math.ceil(#var_23_6[arg_27_0.index].words / 120) * 45))

				local var_27_8 = ccui.ListView:create()

				var_27_8:setContentSize(cc.size(600, 172.8 + var_23_4 * 0.8))
				var_27_8:setPosition(cc.p(20, 347 + var_23_4 - 110))
				var_27_8:setName("scrollView")
				var_27_8:setAnchorPoint(cc.p(0, 1))
				var_27_8:setDirection(ccui.ListViewDirection.vertical)
				var_27_8:setTouchEnabled(true)
				var_23_2:addChild(var_27_8)
				var_27_8:pushBackCustomItem(var_27_6)
				self.btn_return:setVisible(false)
				self.rootLayer:getChildByName("di"):setVisible(false)
			end

			for iter_23_1 = 1, #var_23_0[iter_23_0].studentList do
				local var_23_7 = var_23_5:getChildByName("item" .. iter_23_1)

				var_23_7:loadTexture("mainScenebg/schoolcinema/plot_deep/plot1_2/item" .. iter_23_0 .. "_" .. iter_23_1 .. ".png")

				local var_23_8 = var_23_7:getChildByName("name")
				local var_23_9 = var_23_7:getChildByName("line_bg")

				var_23_8:setString(var_23_0[iter_23_0].studentList[iter_23_1].name)
				var_23_9:setTouchEnabled(true)

				var_23_9.index = iter_23_1
				var_23_7.oldPosx, var_23_7.oldPosy = var_23_7:getPosition()

				var_23_9:addTouchEventListener(function(arg_29_0, arg_29_1)
					if arg_29_1 ~= ccui.TouchEventType.ended then
						return
					end

					onBtnItemCallback(arg_29_0)
				end)
			end
		end
	end
end

function SchoolCinemaLayer:closePlotDeepPanel()
	self.curPanelIndex = var_0_0.PLOT_DETAIL

	self.deepViewNode:setVisible(false)
end

function SchoolCinemaLayer:showPlotDetail1Panel(arg_31_1, arg_31_2)
	if arg_31_1 == nil then
		return
	end

	self.initconfig.detailIndex = arg_31_2

	local var_31_0 = school_cinema_manager:getCinemaInfo(arg_31_1)

	self.curPanelIndex = var_0_0.PLOT_DETAIL

	self.plotNode:setVisible(false)
	self.plotDetailNode:getChildByName("bg"):loadTexture(var_0_6)
	self.plotDetailNode:setVisible(true)
	self:removeNewTitleForServant()
	self.plotDetailNode:getChildByName("title_bg"):setVisible(false)
	self.plotDetailNode:getChildByName("title"):setVisible(false)
	self.plotDetailNode:getChildByName("title_en"):setVisible(false)
	self.plotDetailNode:getChildByName("bracket_top"):setVisible(false)
	self.plotDetailNode:getChildByName("bracket_down"):setVisible(false)
	self.plotDetailNode:getChildByName("des"):setVisible(false)

	if self.initconfig.detailIndex == 1 then
		self.itemDetailNode = self:getDetailItemNodeByIndex(4):getChildByName("random")

		local var_31_1 = 640
		local var_31_2 = 1291

		if self.detailViewNode ~= nil then
			self.detailViewNode:removeFromParent()

			self.detailViewNode = nil
		end

		self.detailViewNode = self:getTableView(var_31_0[arg_31_2], 1, function(arg_32_0)
			return var_31_1, var_31_2
		end, cc.size(640, GameDisplay.height - 75), function(arg_33_0, arg_33_1, arg_33_2)
			local var_33_1 = arg_33_0:dequeueCell()

			if var_33_1 == nil then
				var_33_1 = cc.TableViewCell:new()
			end

			local var_33_2 = var_33_1:getChildByName("item")

			if var_33_2 then
				var_33_2:removeFromParent()
			end

			local var_33_4 = self.itemDetailNode:clone()

			var_33_4:setVisible(true)
			var_33_4:setName("item")
			var_33_4:setTouchEnabled(false)
			var_33_4:getChildByName("title3"):setVisible(false)
			var_33_4:setPosition(cc.p(0, 0))
			var_33_1:addChild(var_33_4)
			var_33_4:setContentSize(cc.size(640, 1291))
			self:initRandomPanel(var_33_4, arg_33_2)

			return var_33_1
		end, function(arg_34_0, arg_34_1)
			print("click ")
		end)

		self.detailViewNode:setPosition(cc.p(4, 75))
		self.plotDetailNode:addChild(self.detailViewNode)
	else
		local var_31_4 = 171

		if self:getChildByName("itemDetail") then
			self.itemDetailNode = self:getChildByName("itemDetail")
		else
			self.itemDetailNode = ccui.Layout:create()

			self.itemDetailNode:setContentSize(cc.size(640, var_31_4))
			self.itemDetailNode:setVisible(false)
			self.itemDetailNode:setName("itemDetail")
			self:addChild(self.itemDetailNode)

			local var_31_5 = ccui.Button:create()

			var_31_5:setName("icon")
			var_31_5:setAnchorPoint(cc.p(0, 0))
			var_31_5:setPosition(cc.p(0, 0))
			self.itemDetailNode:addChild(var_31_5)

			local var_31_6 = ccui.Text:create("", FONT_W5, 24)

			var_31_6:setName("title")
			var_31_6:setAnchorPoint(cc.p(0, 0))
			self.itemDetailNode:addChild(var_31_6)

			local var_31_7 = ccui.ImageView:create("SchoolCinemaLayer/plot_detail/plot1/item_mask.png", var_0_11)

			var_31_7:setName("itemmask")
			var_31_7:setAnchorPoint(cc.p(0, 0))
			var_31_7:setPosition(cc.p(0, 13))
			self.itemDetailNode:addChild(var_31_7)
		end

		local var_31_8 = {
			cc.p(400, 70),
			(cc.p(120, 70))
		}
		local var_31_9 = false
		local var_31_10 = 640
		local var_31_11 = var_31_4
		local var_31_12 = #var_31_0[arg_31_2]

		if self.detailViewNode ~= nil then
			self.detailViewNode:removeFromParent()

			self.detailViewNode = nil
		end

		self.detailViewNode = self:getTableView(var_31_0[arg_31_2], #var_31_0[arg_31_2], function(arg_35_0)
			if arg_35_0 == 0 then
				return var_31_10, var_31_11
			elseif arg_35_0 == var_31_12 - 1 then
				return var_31_10, var_31_11 + 80
			else
				return var_31_10, var_31_11
			end
		end, cc.size(640, GameDisplay.height + GameDisplay.fix_y - 80), function(arg_36_0, arg_36_1, arg_36_2)
			local var_36_0 = arg_36_2[arg_36_1 + 1]
			local var_36_1 = arg_36_0:dequeueCell()

			if var_36_1 == nil then
				var_36_1 = cc.TableViewCell:new()
			end

			local var_36_2 = var_36_1:getChildByName("item")

			if var_36_2 then
				var_36_2:removeFromParent()
			end

			local var_36_4 = self.itemDetailNode:clone()

			var_36_4:setVisible(true)
			var_36_4:setName("item")
			var_36_4:setTouchEnabled(false)

			if arg_36_1 + 1 == var_31_12 then
				var_36_4:setPositionY(80)
			else
				var_36_4:setPositionY(0)
			end

			local var_36_5 = var_36_4:getChildByName("icon")

			var_36_5:loadTextures(var_36_0.iconPath, var_36_0.iconPath, var_36_0.iconPath, var_0_11)
			var_36_5:setSwallowTouches(false)

			var_36_5.index = arg_36_1 + 1

			var_36_5:addTouchEventListener(function(arg_37_0, arg_37_1)
				if arg_37_1 ~= ccui.TouchEventType.ended then
					return
				end

				if math.abs(arg_37_0:getTouchBeganPosition().y - arg_37_0:getTouchEndPosition().y) > 30 then
					return
				end

				if var_31_9 == true then
					return
				end

				var_31_9 = true

				self:lateUpdate(function()
					var_31_9 = false
				end)
				self:openDeepPanel(arg_37_0.index)
			end)

			local var_36_6 = var_36_4:getChildByName("title")

			var_36_6:setString(var_36_0.title)
			var_36_6:setPosition(var_31_8[arg_36_1 % 2 + 1])
			var_36_1:addChild(var_36_4)

			return var_36_1
		end, function(arg_39_0, arg_39_1)
			print("click ")
		end)

		self.detailViewNode:setPosition(cc.p(4, 80 - GameDisplay.fix_y))
		self.plotDetailNode:addChild(self.detailViewNode)
		self:loadDeepItemPrefab()
	end
end

function SchoolCinemaLayer:showPlotDetail2Panel(arg_40_1, arg_40_2)
	if arg_40_1 == nil then
		return
	end

	self.initconfig.detailIndex = arg_40_2

	local var_40_0 = school_cinema_manager:getCinemaInfo(arg_40_1)

	self.curPanelIndex = var_0_0.PLOT_DETAIL

	self.plotNode:setVisible(false)
	self.plotDetailNode:setVisible(true)
	self.plotDetailNode:getChildByName("bg"):loadTexture(var_0_6)

	local var_40_1 = self.plotDetailNode:getChildByName("des")

	self.plotDetailNode:getChildByName("title"):setString(var_40_0[arg_40_2].title)
	var_40_1:setString(var_40_0[arg_40_2].des)
	self.plotDetailNode:getChildByName("bracket_down"):setPositionY(self.plotDetailNode:getChildByName("bracket_top"):getPositionY() - var_40_1:getContentSize().height)

	self.itemDetailNode = self:getDetailItemNodeByIndex(2)

	self:removeNewTitleForServant()

	local var_40_2 = self.itemDetailNode:getContentSize().width
	local var_40_3 = self.itemDetailNode:getContentSize().height

	if self.detailViewNode ~= nil then
		self.detailViewNode:removeFromParent()

		self.detailViewNode = nil
	end

	self.detailViewNode = self:getTableView(var_40_0[arg_40_2].list, #var_40_0[arg_40_2].list, function(arg_41_0)
		return var_40_2, var_40_3
	end, cc.size(var_40_2, GameDisplay.height - 70 - var_40_1:getContentSize().height - 50), function(arg_42_0, arg_42_1, arg_42_2)
		local var_42_0 = arg_42_2[arg_42_1 + 1]
		local var_42_1 = arg_42_0:dequeueCell()

		if var_42_1 == nil then
			var_42_1 = cc.TableViewCell:new()
		end

		local var_42_2 = var_42_1:getChildByName("item")

		if var_42_2 == nil then
			var_42_2 = self.itemDetailNode:clone()

			var_42_2:setVisible(true)
			var_42_2:setName("item")
			var_42_1:addChild(var_42_2)
		end

		if var_42_2:getChildByName("bg") then
			var_42_2:getChildByName("bg"):removeFromParent()
		end

		local var_42_3 = ccui.Button:create("SchoolCinemaLayer/plot_detail/plot3/item_bg.png", "SchoolCinemaLayer/plot_detail/plot3/item_bg.png", "SchoolCinemaLayer/plot_detail/plot3/item_bg.png", var_0_11)

		var_42_3:setAnchorPoint(cc.p(0, 0))
		var_42_3:setName("bg")
		var_42_3:setPosition(cc.p(0, 0))
		var_42_2:addChild(var_42_3, -1)

		local var_42_4 = var_42_2:getChildByName("title")
		local var_42_5 = var_42_2:getChildByName("des")
		local var_42_6 = var_42_2:getChildByName("review")
		local var_42_7 = var_42_2:getChildByName("mask")
		local var_42_8 = var_42_7:getChildByName("limit")

		var_42_4:setString(var_42_0.title)
		var_42_4:setPositionY(70)
		var_42_5:setString(var_42_0.des)
		var_42_5:ignoreContentAdaptWithSize(false)
		var_42_5:setContentSize(cc.size(400, 100))
		var_42_3:setSwallowTouches(false)
		var_42_3:addTouchEventListener(function(arg_43_0, arg_43_1)
			if arg_43_1 ~= ccui.TouchEventType.ended or var_42_0.isUnlock == false then
				return
			end

			if math.abs(arg_43_0:getTouchBeganPosition().y - arg_43_0:getTouchEndPosition().y) > 30 then
				return
			end

			require("view.Layer.TalkLayer")
			global_basic_scene:addChild(TalkLayer:create(var_42_0.classification, nil, TALK_TYPE_NORMAL, var_42_0.name), 5)
		end)
		var_42_6:loadTexture(var_42_0.itemPath, var_0_11)
		var_42_6:setScale(0.6)
		var_42_6:setPosition(cc.p(530, 65))
		var_42_2:getChildByName("btn_play"):setPosition(cc.p(530, 65))
		var_42_7:setVisible(var_42_0.isUnlock == false)
		var_42_8:setString(var_42_0.limit)

		return var_42_1
	end, function(arg_44_0, arg_44_1)
		print("click ")
	end)

	self.detailViewNode:setPosition(cc.p(0, 50))
	self.plotDetailNode:addChild(self.detailViewNode)
end

function SchoolCinemaLayer:showPlotDetail3Panel(arg_45_1, arg_45_2)
	if arg_45_1 == nil then
		return
	end

	local var_45_0 = 3

	self.initconfig.detailIndex = arg_45_2

	local var_45_1 = school_cinema_manager:getCinemaInfo(var_45_0)

	self.curPanelIndex = var_0_0.PLOT_DETAIL

	self.plotNode:setVisible(false)
	self.plotDetailNode:setVisible(true)
	self.plotDetailNode:getChildByName("bg"):loadTexture(var_0_6)

	local var_45_2 = self.plotDetailNode:getChildByName("des")

	self.plotDetailNode:getChildByName("title"):setString(var_45_1[arg_45_2].title)
	var_45_2:ignoreContentAdaptWithSize(false)
	var_45_2:setContentSize(cc.size(500, math.ceil(#var_45_1[arg_45_2].des / 20) * 18))
	var_45_2:setString(var_45_1[arg_45_2].des)
	self.plotDetailNode:getChildByName("bracket_down"):setPositionY(self.plotDetailNode:getChildByName("bracket_top"):getPositionY() - var_45_2:getContentSize().height / 2)

	self.itemDetailNode = self:getDetailItemNodeByIndex(2)

	self:removeNewTitleForServant()

	local var_45_3 = self.itemDetailNode:getContentSize().width
	local var_45_4 = self.itemDetailNode:getContentSize().height

	if self.detailViewNode ~= nil then
		self.detailViewNode:removeFromParent()

		self.detailViewNode = nil
	end

	self.detailViewNode = self:getTableView(var_45_1[arg_45_2].list, #var_45_1[arg_45_2].list, function(arg_46_0)
		return var_45_3, var_45_4
	end, cc.size(var_45_3, GameDisplay.height - var_45_2:getContentSize().height - 70), function(arg_47_0, arg_47_1, arg_47_2)
		local var_47_0 = arg_47_1 + 1
		local var_47_1 = arg_47_2[arg_47_1 + 1]
		local var_47_2 = arg_47_0:dequeueCell()

		if var_47_2 == nil then
			var_47_2 = cc.TableViewCell:new()
		end

		local var_47_3 = var_47_2:getChildByName("item")

		if var_47_3 == nil then
			var_47_3 = self.itemDetailNode:clone()

			var_47_3:setVisible(true)
			var_47_3:setName("item")
			var_47_2:addChild(var_47_3)
			var_47_3:setTouchEnabled(false)
		end

		if var_47_3:getChildByName("bg") then
			var_47_3:getChildByName("bg"):removeFromParent()
		end

		if var_47_3:getChildByName("new") then
			var_47_3:getChildByName("new"):removeFromParent()
		end

		local var_47_4 = ccui.Button:create("SchoolCinemaLayer/plot_detail/plot3/item_bg.png", "SchoolCinemaLayer/plot_detail/plot3/item_bg.png", "SchoolCinemaLayer/plot_detail/plot3/item_bg.png", var_0_11)

		var_47_4:setAnchorPoint(cc.p(0, 0))
		var_47_4:setPosition(cc.p(0, 0))
		var_47_4:setName("bg")
		var_47_3:addChild(var_47_4, -1)

		local var_47_5 = var_47_3:getChildByName("title")
		local var_47_6 = var_47_3:getChildByName("des")
		local var_47_7 = var_47_3:getChildByName("review")
		local var_47_8 = var_47_3:getChildByName("mask")
		local var_47_9 = var_47_8:getChildByName("limit")

		var_47_5:setString(var_47_1.title)
		var_47_5:setPositionY(70)
		var_47_6:setString(var_47_1.des)
		var_47_6:ignoreContentAdaptWithSize(false)
		var_47_6:setContentSize(cc.size(400, 100))
		var_47_4:setSwallowTouches(false)
		var_47_4:addTouchEventListener(function(arg_48_0, arg_48_1)
			if arg_48_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_48_0:getTouchBeganPosition().y - arg_48_0:getTouchEndPosition().y) > 30 then
				return
			end

			if var_47_1.isUnlock == false then
				local var_48_0 = ConfirmDialogSprite:create("", L_SCHOOL_CINEMA_TIPS.MODE_LEVEL_LOCK, {
					surecallback = function()
						LayerManager:switchShowLayer("LevelMapLayer")

						isClickTag = false
					end,
					cancelCallback = function()
						isClickTag = false
					end
				}, false, false, function()
					isClickTag = false
				end)

				global_basic_scene:addChild(var_48_0, 99)
				var_48_0:setName("dialog")
			else
				school_cinema_manager:doPlayerStoryPlot({
					unlocklevel = var_47_1.id,
					index = var_45_0,
					dIndex = arg_45_2,
					cIndex = var_47_0
				}, function()
					if var_47_1.pv then
						if DeviceManager.platform == "ios" or DeviceManager.platform == "android" then
							self:playPV("video/" .. var_47_1.pv .. ".mp4")
						else
							global_ShowBlockWords(L_PV_WARNING.Platform_Win32)
						end
					else
						require("view.Layer.TalkLayer")
						global_basic_scene:addChild(TalkLayer:create(var_47_1.classification, nil, TALK_TYPE_NORMAL, var_47_1.name), 5)
					end

					local var_52_0 = var_47_3:getChildByName("new")

					if var_52_0 then
						var_52_0:setVisible(false)
						var_52_0:removeFromParent()
					end

					self:updateMainPanelRedDot(var_45_0)

					if type(self.updatePlotPanelRedDot) == "function" then
						self:updatePlotPanelRedDot()
					end
				end)
			end
		end)
		var_47_7:loadTexture(var_47_1.itemPath, var_0_11)
		var_47_7:setScale(0.6)
		var_47_7:setPosition(cc.p(530, 65))
		var_47_3:getChildByName("btn_play"):setPosition(cc.p(530, 65))
		var_47_8:setVisible(var_47_1.isUnlock == false)
		var_47_9:setString(var_47_1.limit)

		if var_47_1.isNew == true then
			local var_47_10 = ccui.ImageView:create("SchoolCinemaLayer/new.png", var_0_11)

			var_47_10:setName("new")
			var_47_10:setPosition(cc.p(605, 107))
			var_47_3:addChild(var_47_10)
		end

		return var_47_2
	end, function(arg_53_0, arg_53_1)
		print("click ")
	end)

	self.detailViewNode:setPosition(cc.p(0, 0))
	self.plotDetailNode:addChild(self.detailViewNode)
end

function SchoolCinemaLayer.initRandomPanel(arg_54_0, arg_54_1, arg_54_2)
	if arg_54_1 == nil or arg_54_2 == nil then
		return
	end

	local var_54_0 = 6
	local var_54_2

	if #arg_54_2 > 6 then
		var_54_0 = 12
		var_54_2 = "mainScenebg/schoolcinema/plot_detail/plot1/random_bg.png"
	else
		var_54_2 = "mainScenebg/schoolcinema/plot_detail/plot4/random_bg.png"
	end

	arg_54_1:getChildByName("bg"):loadTexture(var_54_2)

	for iter_54_0 = 1, var_54_0 do
		local var_54_3 = (iter_54_0 - 1) % 6 + 1
		local var_54_4 = "SchoolCinemaLayer/plot_detail/plot4/mask" .. (iter_54_0 - 1) % 6 + 1 .. ".png"

		if iter_54_0 >= 2 and arg_54_2[iter_54_0] == nil then
			var_54_4 = "SchoolCinemaLayer/plot_detail/plot4/unknow" .. var_54_3 .. ".png"
		end

		local var_54_5 = arg_54_1:getChildByName("random" .. iter_54_0)

		if var_54_5 == nil then
			var_54_5 = arg_54_1:getChildByName("random" .. var_54_3):clone()

			var_54_5:setPositionY(var_54_5:getPositionY() - 632 - 628)
			var_54_5:setName("random" .. iter_54_0)
			arg_54_1:addChild(var_54_5)
		end

		var_54_5:setTouchEnabled(false)
		var_54_5:setPositionY(var_54_0 == 6 and var_54_5:getPositionY() or var_54_5:getPositionY() + 632)
		var_54_5:getChildByName("chapter"):setVisible(false)

		local var_54_6 = var_54_5:getChildByName("name")
		local var_54_7 = var_54_5:getChildByName("name_bg")

		var_54_6:setAnchorPoint(cc.p(0, 0))
		var_54_7:setAnchorPoint(cc.p(0, 0))
		var_54_6:setPosition(var_0_3[var_54_3].x + 10, var_0_3[var_54_3].y + 10)
		var_54_7:setPosition(var_0_3[var_54_3])

		local var_54_8 = var_54_5:getChildByName("mask")

		if var_54_8 ~= nil then
			var_54_8:removeFromParent()
		end

		local var_54_10 = ccui.Button:create(var_54_4, var_54_4, var_54_4, var_0_11)

		var_54_10:setName("mask")
		var_54_10:setAnchorPoint(cc.p(0, 0))

		local var_54_11 = ccui.Text:create("", FONT_NAME, 18)
		local var_54_12 = ccui.Text:create("", FONT_NAME, 18)

		var_54_10:addChild(var_54_11)
		var_54_10:addChild(var_54_12)
		var_54_5:addChild(var_54_10, 2)

		local var_54_13 = arg_54_2[iter_54_0]

		if arg_54_2[iter_54_0] == nil then
			var_54_6:setVisible(false)
			var_54_7:setVisible(false)
			var_54_10:setVisible(true)
		else
			var_54_6:setString(var_54_13.title)

			local var_54_14

			if config._DEBUG then
				var_54_14 = cc.Sprite:create(var_54_4) or cc.Sprite:createWithSpriteFrameName(var_54_4)
			end

			local var_54_15 = cc.Sprite:create(var_54_13.itemPath)
			local var_54_16 = var_54_5:getChildByName("clip")

			if var_54_16 == nil then
				var_54_16 = cc.ClippingNode:create(var_54_14)

				var_54_16:setName("clip")
				var_54_5:addChild(var_54_16)
			end

			var_54_16:setAlphaThreshold(0.6)
			var_54_16:setAnchorPoint(cc.p(0, 0))
			var_54_16:setPosition(var_0_2[var_54_3])
			var_54_11:setPosition(var_0_4[var_54_3])
			var_54_12:setPosition(var_0_5[var_54_3])
			var_54_16:setScale(0.98)
			var_54_16:addChild(var_54_15)
			var_54_15:setPosition(cc.p(var_54_13.posx, var_54_13.posy))

			local var_54_17 = ccui.Button:create(var_54_4, var_54_4, var_54_4, var_0_11)

			var_54_17:setSwallowTouches(false)
			var_54_17:setAnchorPoint(cc.p(0, 0))
			var_54_17:setOpacity(0)
			var_54_17:setPosition(cc.p(-var_54_10:getContentSize().width / 2, -var_54_10:getContentSize().height / 2))
			var_54_16:addChild(var_54_17)
			var_54_17:addTouchEventListener(function(arg_55_0, arg_55_1)
				if arg_55_1 ~= ccui.TouchEventType.ended then
					return
				end

				if math.abs(arg_55_0:getTouchBeganPosition().y - arg_55_0:getTouchEndPosition().y) > 30 then
					return
				end

				if isClickTag == true then
					return
				end

				isClickTag = true

				print("click")

				if var_54_13.isUnlock == false then
					local var_55_0 = ConfirmDialogSprite:create("", L_SCHOOL_CINEMA_TIPS.DORMITORY1, {
						surecallback = function()
							LayerManager:switchShowLayer("DormitoryLayer")

							isClickTag = false
						end,
						cancelCallback = function()
							isClickTag = false
						end
					}, false, false, function()
						isClickTag = false
					end)

					global_basic_scene:addChild(var_55_0, 99)
					var_55_0:setName("dialog")
				else
					arg_54_0:clickPostCardCallback(var_54_13)
				end

				arg_54_0:lateUpdate(function()
					isClickTag = false
				end)
			end)
			var_54_7:setLocalZOrder(1)
			var_54_6:setLocalZOrder(1)
			var_54_10:setSwallowTouches(false)
			var_54_10:setVisible(var_54_13.isUnlock == false)
			var_54_11:setString(var_54_13.unlockdes1)
			var_54_12:setString(var_54_13.unlockdes2)
		end
	end
end

function SchoolCinemaLayer:showPlotDetail4Panel(arg_60_1, arg_60_2)
	if arg_60_1 == nil then
		return
	end

	self.initconfig.detailIndex = arg_60_2

	local var_60_0 = school_cinema_manager:getCinemaInfo(arg_60_1)

	self.curPanelIndex = var_0_0.PLOT_DETAIL

	self.plotNode:setVisible(false)
	self.plotDetailNode:setVisible(true)
	self.plotDetailNode:getChildByName("bg"):loadTexture(var_0_6)
	self:addNewTitleForServant()

	self.itemDetailNode = self:getDetailItemNodeByIndex(4)

	local var_60_1 = var_60_0[arg_60_2].list
	local var_60_2 = self.itemDetailNode:getContentSize().width
	local var_60_4 = #var_60_0[arg_60_2].list.randomList <= 6 and 710 or 1340
	local var_60_5 = 190 + math.max(#var_60_0[arg_60_2].list.favorList - 1, 0) * 80 + self.itemDetailNode:getChildByName("dream"):getContentSize().height + (#var_60_0[arg_60_2].list.randomList <= 6 and 710 or 1340)

	if self.detailViewNode ~= nil then
		self.detailViewNode:removeFromParent()

		self.detailViewNode = nil
	end

	self.detailViewNode = self:getTableView(var_60_1, 1, function(arg_61_0)
		return var_60_2, var_60_5 + 10
	end, cc.size(var_60_2, GameDisplay.height - 90 - 70), function(arg_62_0, arg_62_1, arg_62_2)
		local var_62_1 = arg_62_2
		local var_62_2 = arg_62_0:dequeueCell()

		if var_62_2 == nil then
			var_62_2 = cc.TableViewCell:new()
		end

		local var_62_3 = var_62_2:getChildByName("item")

		if var_62_3 then
			var_62_3:removeFromParent()
		end

		local var_62_5 = self.itemDetailNode:clone()

		var_62_5:setVisible(true)
		var_62_5:setName("item")
		var_62_5:setTouchEnabled(false)
		var_62_5:setPosition(cc.p(0, 170 + var_60_4 - 710))
		var_62_2:addChild(var_62_5)

		local var_62_6 = var_62_5:getChildByName("favor")
		local var_62_7 = var_62_6:getChildren()

		for iter_62_0 = 1, #var_62_7 do
			var_62_7[iter_62_0]:setPositionY(var_62_7[iter_62_0]:getPositionY() - 80 * math.max(4 - #arg_62_2.favorList, 0))
		end

		local var_62_8 = var_62_5:getChildByName("dream")

		var_62_8:setContentSize(cc.size(640, 135))

		local var_62_9 = var_62_5:getChildByName("random")

		var_62_9:setContentSize(cc.size(640, var_60_4))

		local var_62_10 = false

		for iter_62_1 = 1, 4 do
			local var_62_11 = var_62_6:getChildByName("favor" .. iter_62_1)

			var_62_11:setTouchEnabled(false)

			local var_62_12 = var_62_11:getChildByName("favor_level")
			local var_62_13 = var_62_11:getChildByName("title")
			local var_62_14 = var_62_11:getChildByName("btn_review")
			local var_62_15 = var_62_11:getChildByName("lock")
			local var_62_16 = var_62_15:getChildByName("limit")

			if arg_62_2.favorList[iter_62_1] == nil then
				var_62_11:setVisible(false)
			else
				var_62_12:setString(arg_62_2.favorList[iter_62_1].limitLevel)
				var_62_12:setPosition(cc.p(25, 35))
				var_62_13:setString(arg_62_2.favorList[iter_62_1].title)
				var_62_13:ignoreContentAdaptWithSize(false)
				var_62_13:setContentSize(cc.size(200, 80))
				var_62_13:setAnchorPoint(cc.p(0, 1))
				var_62_13:setPosition(cc.p(120, 120))
				var_62_13:setFontSize(20)
				var_62_16:setAnchorPoint(cc.p(0.5, 0.5))
				var_62_16:setPosition(cc.p(var_62_15:getContentSize().width / 2, var_62_15:getContentSize().height / 2 - 15))
				var_62_16:setString(arg_62_2.favorList[iter_62_1].limit)
				var_62_14:setSwallowTouches(false)
				var_62_14:addTouchEventListener(function(arg_63_0, arg_63_1)
					if arg_63_1 ~= ccui.TouchEventType.ended or arg_62_2.favorList[iter_62_1].isUnlock == false then
						return
					end

					if math.abs(arg_63_0:getTouchBeganPosition().y - arg_63_0:getTouchEndPosition().y) > 30 then
						return
					end

					require("view.Layer.TalkLayer")
					global_basic_scene:addChild(TalkLayer:create(arg_62_2.favorList[iter_62_1].classification, nil, TALK_TYPE_NORMAL), 5)
				end)
				var_62_15:setVisible(arg_62_2.favorList[iter_62_1].isUnlock == false)
				var_62_15:setSwallowTouches(false)
				var_62_15:addTouchEventListener(function(arg_64_0, arg_64_1)
					if arg_64_1 ~= ccui.TouchEventType.ended then
						return
					end

					if math.abs(arg_64_0:getTouchBeganPosition().y - arg_64_0:getTouchEndPosition().y) > 30 then
						return
					end

					if var_62_10 == true then
						return
					end

					var_62_10 = true

					local var_64_0 = ConfirmDialogSprite:create("", L_SCHOOL_CINEMA_TIPS.DORMITORY, {
						surecallback = function()
							var_62_10 = false

							LayerManager:switchShowLayer("DormitoryLayer")
						end,
						cancelCallback = function()
							var_62_10 = false
						end
					}, false, false, function()
						var_62_10 = false
					end)

					global_basic_scene:addChild(var_64_0, 99)
					var_64_0:setName("dialog")
				end)
			end
		end

		local var_62_17 = var_62_8:getChildByName("bg")

		var_62_17:loadTextures(var_0_1[arg_62_2.dreamList.status], var_0_1[arg_62_2.dreamList.status], var_0_1[arg_62_2.dreamList.status], var_0_11)
		var_62_17:setSwallowTouches(false)
		var_62_17:addTouchEventListener(function(arg_68_0, arg_68_1)
			if arg_68_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_68_0:getTouchBeganPosition().y - arg_68_0:getTouchEndPosition().y) > 30 then
				return
			end

			if var_62_1.dreamList.status == 2 then
				local var_68_0 = ConfirmDialogSprite:create("", L_SCHOOL_CINEMA_TIPS.DREAM_SCHOOL, {
					surecallback = function()
						if not level_manager:isPlayerPassLevel(UNLOCK_LEVELTALK) then
							global_ShowBlockWords(L_TALKLEVEL_LOCK)
						else
							LayerManager:switchShowLayer("LevelTalkMapLayer")
						end
					end
				})

				global_basic_scene:addChild(var_68_0, 99)
				var_68_0:setName("dialog")
			elseif var_62_1.dreamList.status == 3 then
				require("view.Layer.TalkLayer")
				global_basic_scene:addChild(TalkLayer:create(var_62_1.dreamList.classification, nil, TALK_TYPE_NORMAL), 5)
			end
		end)

		if arg_62_2.dreamList.status == 2 then
			local var_62_18 = ccui.Text:create(arg_62_2.dreamList.limit, FONT_NAME, 22)

			var_62_18:setPosition(cc.p(var_62_17:getContentSize().width / 2, 30))
			var_62_17:addChild(var_62_18)
		end

		local var_62_19 = var_62_9:getChildByName("title3")

		var_62_19:setPositionY(var_62_19:getPositionY() + var_60_4 - 710)
		self:initRandomPanel(var_62_9, arg_62_2.randomList)

		return var_62_2
	end, function(arg_70_0, arg_70_1)
		print("click ")
	end)

	self.detailViewNode:setPosition(cc.p(0, 70))
	self.plotDetailNode:addChild(self.detailViewNode)
end

function SchoolCinemaLayer:showPlotDetail5Panel(arg_71_1, arg_71_2)
	if arg_71_1 == nil then
		return
	end

	self.initconfig.detailIndex = arg_71_2

	local var_71_0 = school_cinema_manager:getCinemaInfo(arg_71_1)

	self.curPanelIndex = var_0_0.PLOT_DETAIL

	self.plotNode:setVisible(false)
	self.plotDetailNode:setVisible(true)
	self.plotDetailNode:getChildByName("bg"):loadTexture(var_0_6)

	local var_71_1 = self.plotDetailNode:getChildByName("des")

	self.plotDetailNode:getChildByName("title"):setString(var_71_0[arg_71_2].title)
	var_71_1:setString(var_71_0[arg_71_2].des)
	self.plotDetailNode:getChildByName("bracket_down"):setPositionY(self.plotDetailNode:getChildByName("bracket_top"):getPositionY() - var_71_1:getContentSize().height)

	self.itemDetailNode = self:getDetailItemNodeByIndex(2)

	self:removeNewTitleForServant()

	local var_71_2 = self.itemDetailNode:getContentSize().width
	local var_71_3 = self.itemDetailNode:getContentSize().height

	if self.detailViewNode ~= nil then
		self.detailViewNode:removeFromParent()

		self.detailViewNode = nil
	end

	self.detailViewNode = self:getTableView(var_71_0[arg_71_2].list, #var_71_0[arg_71_2].list, function(arg_72_0)
		return var_71_2, var_71_3
	end, cc.size(var_71_2, GameDisplay.height - 70 - var_71_1:getContentSize().height - 50), function(arg_73_0, arg_73_1, arg_73_2)
		local var_73_0 = arg_73_2[arg_73_1 + 1]
		local var_73_1 = arg_73_0:dequeueCell()

		if var_73_1 == nil then
			var_73_1 = cc.TableViewCell:new()
		end

		local var_73_2 = var_73_1:getChildByName("item")

		if var_73_2 == nil then
			var_73_2 = self.itemDetailNode:clone()

			var_73_2:setVisible(true)
			var_73_2:setName("item")
			var_73_1:addChild(var_73_2)
		end

		if var_73_2:getChildByName("bg") then
			var_73_2:getChildByName("bg"):removeFromParent()
		end

		local var_73_3 = ccui.Button:create("SchoolCinemaLayer/plot_detail/plot3/item_bg.png", "SchoolCinemaLayer/plot_detail/plot3/item_bg.png", "SchoolCinemaLayer/plot_detail/plot3/item_bg.png", var_0_11)

		var_73_3:setAnchorPoint(cc.p(0, 0))
		var_73_3:setPosition(cc.p(0, 0))
		var_73_3:setName("bg")
		var_73_2:addChild(var_73_3, -1)

		local var_73_4 = var_73_2:getChildByName("title")
		local var_73_5 = var_73_2:getChildByName("des")
		local var_73_6 = var_73_2:getChildByName("review")
		local var_73_7 = var_73_2:getChildByName("mask")
		local var_73_8 = var_73_7:getChildByName("limit")

		var_73_4:setString(var_73_0.title)
		var_73_4:setPositionY(70)
		var_73_5:setString(var_73_0.des)
		var_73_5:ignoreContentAdaptWithSize(false)
		var_73_5:setContentSize(cc.size(400, 100))
		var_73_3:setSwallowTouches(false)
		var_73_3:addTouchEventListener(function(arg_74_0, arg_74_1)
			if arg_74_1 ~= ccui.TouchEventType.ended or var_73_0.isUnlock == false then
				return
			end

			if math.abs(arg_74_0:getTouchBeganPosition().y - arg_74_0:getTouchEndPosition().y) > 30 then
				return
			end

			require("view.Layer.TalkLayer")
			global_basic_scene:addChild(TalkLayer:create(var_73_0.classification, nil, TALK_TYPE_NORMAL, var_73_0.name), 5)
		end)
		var_73_6:loadTexture(var_73_0.itemPath, var_0_11)
		var_73_6:setScale(0.6)
		var_73_6:setPosition(cc.p(530, 65))
		var_73_2:getChildByName("btn_play"):setPosition(cc.p(530, 65))
		var_73_7:setVisible(var_73_0.isUnlock == false)
		var_73_8:setString(var_73_0.limit)

		return var_73_1
	end, function(arg_75_0, arg_75_1)
		print("click ")
	end)

	self.detailViewNode:setPosition(cc.p(0, 50))
	self.plotDetailNode:addChild(self.detailViewNode)
end

function SchoolCinemaLayer:showPlotDetail6Panel(arg_76_1, arg_76_2)
	if arg_76_1 == nil then
		return
	end

	self.initconfig.detailIndex = arg_76_2

	local var_76_0 = school_cinema_manager:getCinemaInfo(arg_76_1)

	self.curPanelIndex = var_0_0.PLOT_DETAIL

	self.plotNode:setVisible(false)
	self.plotDetailNode:setVisible(true)
	self.plotDetailNode:getChildByName("bg"):loadTexture(var_0_6)

	local var_76_1 = self.plotDetailNode:getChildByName("des")

	self.plotDetailNode:getChildByName("title"):setString(var_76_0[arg_76_2].title)
	var_76_1:setString(var_76_0[arg_76_2].des)
	self.plotDetailNode:getChildByName("bracket_down"):setPositionY(self.plotDetailNode:getChildByName("bracket_top"):getPositionY() - var_76_1:getContentSize().height)

	self.itemDetailNode = self:getDetailItemNodeByIndex(2)

	self:removeNewTitleForServant()

	local var_76_2 = self.itemDetailNode:getContentSize().width
	local var_76_3 = self.itemDetailNode:getContentSize().height

	if self.detailViewNode ~= nil then
		self.detailViewNode:removeFromParent()

		self.detailViewNode = nil
	end

	self.detailViewNode = self:getTableView(var_76_0[arg_76_2].list, #var_76_0[arg_76_2].list, function(arg_77_0)
		return var_76_2, var_76_3
	end, cc.size(var_76_2, GameDisplay.height - 70 - var_76_1:getContentSize().height - 50), function(arg_78_0, arg_78_1, arg_78_2)
		local var_78_0 = arg_78_2[arg_78_1 + 1]
		local var_78_1 = arg_78_0:dequeueCell()

		if var_78_1 == nil then
			var_78_1 = cc.TableViewCell:new()
		end

		local var_78_2 = var_78_1:getChildByName("item")

		if var_78_2 == nil then
			var_78_2 = self.itemDetailNode:clone()

			var_78_2:setVisible(true)
			var_78_2:setName("item")
			var_78_1:addChild(var_78_2)
		end

		if var_78_2:getChildByName("bg") then
			var_78_2:getChildByName("bg"):removeFromParent()
		end

		local var_78_3 = ccui.Button:create("SchoolCinemaLayer/plot_detail/plot3/item_bg.png", "SchoolCinemaLayer/plot_detail/plot3/item_bg.png", "SchoolCinemaLayer/plot_detail/plot3/item_bg.png", var_0_11)

		var_78_3:setAnchorPoint(cc.p(0, 0))
		var_78_3:setPosition(cc.p(0, 0))
		var_78_3:setName("bg")
		var_78_2:addChild(var_78_3, -1)

		local var_78_4 = var_78_2:getChildByName("title")
		local var_78_5 = var_78_2:getChildByName("des")
		local var_78_6 = var_78_2:getChildByName("review")
		local var_78_7 = var_78_2:getChildByName("mask")
		local var_78_8 = var_78_7:getChildByName("limit")

		var_78_4:setString(var_78_0.title)
		var_78_4:setPositionY(70)
		var_78_5:setString(var_78_0.des)
		var_78_5:ignoreContentAdaptWithSize(false)
		var_78_5:setContentSize(cc.size(400, 100))
		var_78_3:setSwallowTouches(false)
		var_78_3:addTouchEventListener(function(arg_79_0, arg_79_1)
			if arg_79_1 ~= ccui.TouchEventType.ended or var_78_0.isUnlock == false then
				return
			end

			if math.abs(arg_79_0:getTouchBeganPosition().y - arg_79_0:getTouchEndPosition().y) > 30 then
				return
			end

			require("view.Layer.TalkLayer")
			global_basic_scene:addChild(TalkLayer:create(var_78_0.classification, nil, TALK_TYPE_NORMAL, var_78_0.name), 5)
		end)
		var_78_6:loadTexture(var_78_0.itemPath, var_0_11)
		var_78_6:setScale(0.6)
		var_78_6:setPosition(cc.p(530, 65))
		var_78_2:getChildByName("btn_play"):setPosition(cc.p(530, 65))
		var_78_7:setVisible(var_78_0.isUnlock == false)
		var_78_8:setString(var_78_0.limit)

		return var_78_1
	end, function(arg_80_0, arg_80_1)
		print("click ")
	end)

	self.detailViewNode:setPosition(cc.p(0, 50))
	self.plotDetailNode:addChild(self.detailViewNode)
end

function SchoolCinemaLayer:showPlotPanel(arg_81_1)
	if arg_81_1 == nil then
		return
	end

	self.plotBtn_photo:setVisible(false)

	if arg_81_1 == 1 then
		self:showPlot1Panel()
	elseif arg_81_1 == 2 then
		self:showPlot6Panel()
	elseif arg_81_1 == 3 then
		self:showPlot3Panel()
	elseif arg_81_1 == 4 then
		self:showPlot4Panel()
	elseif arg_81_1 == 5 then
		self:showPlot2Panel()
	elseif arg_81_1 == 6 then
		self:showPlot5Panel()
	end
end

function SchoolCinemaLayer:showPlot1Panel()
	self.itemNode = self:getItemPlotNodeByIndex(1)
	self.curPanelIndex = var_0_0.PLOT

	self.plotNode:setVisible(true)
	self.plotBgNode:loadTexture(var_0_6)
	self.plotTitleNode:loadTexture(var_0_7[1], var_0_11)
	self.mainNode:setVisible(false)
	self.titleNode:setVisible(false)
	self.downTitleNode:setVisible(false)

	if self.listViewNode ~= nil then
		self.listViewNode:removeFromParent()

		self.listViewNode = nil
	end

	self.listViewNode = self.itemNode:clone()

	self.plotNode:addChild(self.listViewNode)
end

function SchoolCinemaLayer:showPlot2Panel()
	local var_83_0 = 2
	local var_83_1 = school_cinema_manager:getCinemaInfo(2)

	if var_83_1 == nil then
		return
	end

	self.itemNode = ccui.Layout:create()

	self.itemNode:setContentSize(cc.size(634, 200))

	self.curPanelIndex = var_0_0.PLOT

	self.plotNode:setVisible(true)
	self.plotBgNode:loadTexture(var_0_6)
	self.plotTitleNode:loadTexture(var_0_7[2], var_0_11)
	self.mainNode:setVisible(false)
	self.titleNode:setVisible(false)
	self.downTitleNode:setVisible(false)

	local var_83_2 = 1
	local var_83_3 = self.itemNode:getContentSize().width
	local var_83_4 = self.itemNode:getContentSize().height

	if self.listViewNode ~= nil then
		self.listViewNode:removeFromParent()

		self.listViewNode = nil
	end

	self.listViewNode = self:getTableView(var_83_1, math.ceil(#var_83_1 / 1), function(arg_84_0)
		return var_83_3, var_83_4
	end, cc.size(var_83_3, GameDisplay.height - 95 - 75), function(arg_85_0, arg_85_1, arg_85_2)
		local var_85_0 = arg_85_2[arg_85_1 * var_83_2 + 1]
		local var_85_1 = arg_85_0:dequeueCell()

		if var_85_1 == nil then
			var_85_1 = cc.TableViewCell:new()
		end

		local var_85_2 = var_85_1:getChildByName("item")

		if var_85_2 then
			var_85_2:removeFromParent()
		end

		local var_85_4 = ccui.Layout:create()

		var_85_4:setContentSize(cc.size(634, 200))
		var_85_4:setVisible(true)
		var_85_4:setName("item")
		var_85_1:addChild(var_85_4)

		local var_85_5 = ccui.Button:create("mainScenebg/schoolfile/" .. arg_85_2[arg_85_1 * var_83_2 + 1].itemPath .. ".png", "mainScenebg/schoolfile/" .. arg_85_2[arg_85_1 * var_83_2 + 1].itemPath .. ".png", "mainScenebg/schoolfile/" .. arg_85_2[arg_85_1 * var_83_2 + 1].itemPath .. ".png")

		var_85_5:setAnchorPoint(cc.p(0, 0))
		var_85_5:setSwallowTouches(false)

		var_85_5.index = arg_85_1 * var_83_2 + 1

		var_85_5:addTouchEventListener(function(arg_86_0, arg_86_1)
			if arg_86_1 ~= ccui.TouchEventType.ended or var_85_0.isUnlock == false then
				return
			end

			if math.abs(arg_86_0:getTouchBeganPosition().y - arg_86_0:getTouchEndPosition().y) > 30 then
				return
			end

			print("click")
			self:showPlotDetail2Panel(var_83_0, arg_86_0.index)
		end)
		var_85_4:addChild(var_85_5)

		local var_85_6 = ccui.Text:create(arg_85_2[arg_85_1 * var_83_2 + 1].title, FONT_NAME, 22)

		var_85_6:setPosition(cc.p(620, 190))
		var_85_6:setAnchorPoint(cc.p(1, 1))
		var_85_4:addChild(var_85_6)

		return var_85_1
	end, function(arg_87_0, arg_87_1)
		print("click ")
	end)

	self.listViewNode:setPosition(cc.p(4, 75))
	self.plotNode:addChild(self.listViewNode)
end

function SchoolCinemaLayer:showPlot3Panel()
	local var_88_0 = 3
	local var_88_1 = school_cinema_manager:getCinemaInfo(3)

	if var_88_1 == nil then
		return
	end

	self.itemNode = self:getItemPlotNodeByIndex(3)
	self.curPanelIndex = var_0_0.PLOT

	self.plotNode:setVisible(true)
	self.plotBgNode:loadTexture(var_0_6)
	self.plotTitleNode:loadTexture(var_0_7[3], var_0_11)
	self.plotBtn_photo:setVisible(true)
	self.plotBtn_photo:addTouchEventListener(function(arg_89_0, arg_89_1)
		if arg_89_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:onBtnPhotoCallback(var_88_1.photoInfo)
	end)
	self.mainNode:setVisible(false)
	self.titleNode:setVisible(false)
	self.downTitleNode:setVisible(false)

	local var_88_2 = false
	local var_88_3 = 4
	local var_88_4 = self.itemNode:getContentSize().width
	local var_88_5 = self.itemNode:getContentSize().height
	local var_88_6 = math.ceil(#var_88_1 / 4)

	if self.listViewNode ~= nil then
		self.listViewNode:removeFromParent()

		self.listViewNode = nil
	end

	self.listViewNode = self:getTableView(var_88_1, var_88_6, function(arg_90_0)
		if arg_90_0 == 0 then
			return var_88_4, var_88_5
		elseif arg_90_0 == var_88_6 - 1 then
			return var_88_4, var_88_5 + 28 + 65
		else
			return var_88_4, var_88_5 + 28
		end
	end, cc.size(var_88_4, GameDisplay.height - 95 - 75), function(arg_91_0, arg_91_1, arg_91_2)
		local var_91_0 = arg_91_1 * var_88_3 + 1
		local var_91_1 = arg_91_0:dequeueCell()

		if var_91_1 == nil then
			var_91_1 = cc.TableViewCell:new()
		end

		local var_91_2 = var_91_1:getChildByName("item")

		if var_91_2 then
			var_91_2:removeFromParent()
		end

		local var_91_4 = self.itemNode:clone()

		var_91_4:setVisible(true)
		var_91_4:setName("item")

		if arg_91_1 == var_88_6 - 1 then
			var_91_4:setPositionY(55)
		else
			var_91_4:setPositionY(-10)
		end

		var_91_1:setLocalZOrder(100 - arg_91_1)
		var_91_1:addChild(var_91_4)

		for iter_91_0 = var_91_0, var_91_0 + var_88_3 - 1 do
			local var_91_5 = arg_91_2[iter_91_0]
			local var_91_6 = var_91_4:getChildByName("item" .. (iter_91_0 - 1) % var_88_3 + 1)

			if iter_91_0 == 1 then
				var_91_6:getChildByName("line"):setVisible(false)
			end

			if var_91_5 ~= nil then
				var_91_6:setVisible(true)

				local var_91_7 = var_91_6:getChildByName("bg")
				local var_91_8 = var_91_6:getChildByName("chapter")
				local var_91_9 = var_91_6:getChildByName("title")
				local var_91_10 = var_91_6:getChildByName("process")
				local var_91_11 = var_91_6:getChildByName("mask")
				local var_91_12 = var_91_11:getChildByName("limit")
				local var_91_13 = var_91_11:getChildByName("lock")
				local var_91_14 = var_91_6:getChildByName("new")
				local var_91_15 = var_91_6:getChildByName("title_en")

				var_91_7:setSwallowTouches(false)

				var_91_7.index = iter_91_0

				var_91_7:addTouchEventListener(function(arg_92_0, arg_92_1)
					if arg_92_1 ~= ccui.TouchEventType.ended or var_88_2 == true then
						return
					end

					if math.abs(arg_92_0:getTouchBeganPosition().y - arg_92_0:getTouchEndPosition().y) > 30 then
						return
					end

					var_88_2 = true

					if var_91_5.isUnlock == false then
						local var_92_0 = ConfirmDialogSprite:create("", L_SCHOOL_CINEMA_TIPS.MODE_LEVEL_LOCK, {
							surecallback = function()
								LayerManager:switchShowLayer("LevelMapLayer")

								var_88_2 = false
							end,
							cancelCallback = function()
								var_88_2 = false
							end
						}, false, false, function()
							var_88_2 = false
						end)

						global_basic_scene:addChild(var_92_0, 99)
						var_92_0:setName("dialog")
					else
						print("click")
						self:showPlotDetail3Panel(var_88_0, arg_92_0.index)

						function self.updatePlotPanelRedDot()
							var_91_14:setVisible(school_cinema_manager:getCinemaInfo(var_88_0)[arg_92_0.index].isNew == true)
						end

						self:lateUpdate(function()
							var_88_2 = false
						end)
					end
				end)
				var_91_8:loadTexture("mainScenebg/schoolfile/" .. var_91_5.itemPath .. ".png")
				var_91_9:setString(var_91_5.title)
				var_91_15:setString(var_91_5.titleEn)
				var_91_10:setString(var_91_5.process)
				var_91_11:setVisible(var_91_5.isUnlock == false)
				var_91_12:setString(var_91_5.limit)
				var_91_13:setPositionX(var_91_12:getPositionX() + var_91_12:getContentSize().width + 20)
				var_91_14:setVisible(var_91_5.isNew == true)
			else
				var_91_6:setVisible(false)
			end
		end

		return var_91_1
	end, function(arg_98_0, arg_98_1)
		print("click ")
	end)

	self.listViewNode:setPosition(cc.p(0, 75))
	self.plotNode:addChild(self.listViewNode)
end

function SchoolCinemaLayer:showPlot4Panel()
	local var_99_0 = 4
	local var_99_1 = school_cinema_manager:getCinemaInfo(4)

	if var_99_1 == nil then
		return
	end

	self.itemNode = self:getItemPlotNodeByIndex(4)
	self.curPanelIndex = var_0_0.PLOT

	self.plotNode:setVisible(true)
	self.plotBgNode:loadTexture(var_0_6)
	self.plotTitleNode:loadTexture(var_0_7[4], var_0_11)
	self.mainNode:setVisible(false)
	self.titleNode:setVisible(false)
	self.downTitleNode:setVisible(false)

	local var_99_2 = 3
	local var_99_3 = self.itemNode:getContentSize().width
	local var_99_4 = self.itemNode:getContentSize().height

	if self.listViewNode ~= nil then
		self.listViewNode:removeFromParent()

		self.listViewNode = nil
	end

	self.listViewNode = self:getTableView(var_99_1, math.ceil(#var_99_1 / 3), function(arg_100_0)
		return var_99_3, var_99_4 + 30
	end, cc.size(var_99_3, GameDisplay.height - 95 - 75), function(arg_101_0, arg_101_1, arg_101_2)
		local var_101_0 = arg_101_0:dequeueCell()

		if var_101_0 == nil then
			var_101_0 = cc.TableViewCell:new()
		end

		local var_101_1 = var_101_0:getChildByName("item")

		if var_101_1 == nil then
			var_101_1 = self.itemNode:clone()

			var_101_1:setVisible(true)
			var_101_1:setName("item")
			var_101_0:addChild(var_101_1)
		end

		for iter_101_0 = arg_101_1 * var_99_2 + 1, arg_101_1 * var_99_2 + 1 + var_99_2 - 1 do
			local var_101_2 = arg_101_2[iter_101_0]
			local var_101_3 = var_101_1:getChildByName("item" .. (iter_101_0 - 1) % var_99_2 + 1)
			local var_101_4 = var_101_3:getChildByName("mask")

			if var_101_4 then
				var_101_4:removeFromParent()
			end

			if arg_101_2[iter_101_0] ~= nil then
				var_101_3:setVisible(true)

				local var_101_5 = var_101_3:getChildByName("bg")
				local var_101_6 = var_101_3:getChildByName("chapter")
				local var_101_7 = var_101_3:getChildByName("title")

				var_101_5:setSwallowTouches(false)

				var_101_5.index = iter_101_0

				var_101_5:addTouchEventListener(function(arg_102_0, arg_102_1)
					if arg_102_1 ~= ccui.TouchEventType.ended then
						return
					end

					if math.abs(arg_102_0:getTouchBeganPosition().y - arg_102_0:getTouchEndPosition().y) > 30 then
						return
					end

					if var_101_2.isUnlock == false then
						local var_102_0 = ConfirmDialogSprite:create("", L_SCHOOL_CINEMA_TIPS.SERVANT_UNHAVE, {
							surecallback = function()
								LayerManager:switchShowLayer("TwisteggLayer")
							end
						})

						global_basic_scene:addChild(var_102_0, 10)
						var_102_0:setName("dialog")
					else
						print("click")
						self:showPlotDetail4Panel(var_99_0, arg_102_0.index)
					end
				end)
				var_101_6:loadTexture(arg_101_2[iter_101_0].itemPath)
				var_101_7:setString(arg_101_2[iter_101_0].title)
				var_101_6:setPositionX(56)
				var_101_6:setScale(0.8)

				if arg_101_2[iter_101_0].isUnlock ~= true then
					local var_101_8 = ccui.ImageView:create("SchoolCinemaLayer/plot/plot4/lock.png", var_0_11)

					var_101_8:setAnchorPoint(cc.p(0, 0))
					var_101_8:setPositionX(-25)
					var_101_8:setName("mask")
					var_101_3:addChild(var_101_8)
				end
			else
				var_101_3:setVisible(false)
			end
		end

		return var_101_0
	end, function(arg_104_0, arg_104_1)
		print("click ")
	end)

	self.listViewNode:setPosition(cc.p(0, 75))
	self.plotNode:addChild(self.listViewNode)
end

function SchoolCinemaLayer:showPlot5Panel()
	local var_105_0 = 5
	local var_105_1 = school_cinema_manager:getCinemaInfo(5)

	if var_105_1 == nil then
		return
	end

	self.itemNode = ccui.Layout:create()

	self.itemNode:setContentSize(cc.size(634, 200))

	self.curPanelIndex = var_0_0.PLOT

	self.plotNode:setVisible(true)
	self.plotBgNode:loadTexture(var_0_6)
	self.plotTitleNode:loadTexture(var_0_7[5], var_0_11)
	self.mainNode:setVisible(false)
	self.titleNode:setVisible(false)
	self.downTitleNode:setVisible(false)

	local var_105_2 = 1
	local var_105_3 = self.itemNode:getContentSize().width
	local var_105_4 = self.itemNode:getContentSize().height

	if self.listViewNode ~= nil then
		self.listViewNode:removeFromParent()

		self.listViewNode = nil
	end

	self.listViewNode = self:getTableView(var_105_1, math.ceil(#var_105_1 / 1), function(arg_106_0)
		return var_105_3, var_105_4
	end, cc.size(var_105_3, GameDisplay.height - 95 - 75), function(arg_107_0, arg_107_1, arg_107_2)
		local var_107_0 = arg_107_2[arg_107_1 * var_105_2 + 1]
		local var_107_1 = arg_107_0:dequeueCell()

		if var_107_1 == nil then
			var_107_1 = cc.TableViewCell:new()
		end

		local var_107_2 = var_107_1:getChildByName("item")

		if var_107_2 then
			var_107_2:removeFromParent()
		end

		local var_107_4 = ccui.Layout:create()

		var_107_4:setContentSize(cc.size(634, 200))
		var_107_4:setVisible(true)
		var_107_4:setName("item")
		var_107_1:addChild(var_107_4)

		local var_107_5 = ccui.Button:create("mainScenebg/schoolfile/" .. arg_107_2[arg_107_1 * var_105_2 + 1].itemPath .. ".png", "mainScenebg/schoolfile/" .. arg_107_2[arg_107_1 * var_105_2 + 1].itemPath .. ".png", "mainScenebg/schoolfile/" .. arg_107_2[arg_107_1 * var_105_2 + 1].itemPath .. ".png")

		var_107_5:setAnchorPoint(cc.p(0, 0))
		var_107_5:setSwallowTouches(false)

		var_107_5.index = arg_107_1 * var_105_2 + 1

		var_107_5:addTouchEventListener(function(arg_108_0, arg_108_1)
			if arg_108_1 ~= ccui.TouchEventType.ended or var_107_0.isUnlock == false then
				return
			end

			if math.abs(arg_108_0:getTouchBeganPosition().y - arg_108_0:getTouchEndPosition().y) > 30 then
				return
			end

			print("click")
			self:showPlotDetail5Panel(var_105_0, arg_108_0.index)
		end)
		var_107_4:addChild(var_107_5)

		local var_107_6 = ccui.Text:create(arg_107_2[arg_107_1 * var_105_2 + 1].title, FONT_NAME, 22)

		var_107_6:setPosition(cc.p(620, 190))
		var_107_6:setAnchorPoint(cc.p(1, 1))
		var_107_4:addChild(var_107_6)

		return var_107_1
	end, function(arg_109_0, arg_109_1)
		print("click ")
	end)

	self.listViewNode:setPosition(cc.p(4, 75))
	self.plotNode:addChild(self.listViewNode)
end

function SchoolCinemaLayer:showPlot6Panel()
	local var_110_0 = 6
	local var_110_1 = school_cinema_manager:getCinemaInfo(6)

	if var_110_1 == nil then
		return
	end

	self.itemNode = ccui.Layout:create()

	self.itemNode:setContentSize(cc.size(634, 200))

	self.curPanelIndex = var_0_0.PLOT

	self.plotNode:setVisible(true)
	self.plotBgNode:loadTexture(var_0_6)
	self.plotTitleNode:loadTexture(var_0_7[6], var_0_11)
	self.mainNode:setVisible(false)
	self.titleNode:setVisible(false)
	self.downTitleNode:setVisible(false)

	local var_110_2 = 1
	local var_110_3 = self.itemNode:getContentSize().width
	local var_110_4 = self.itemNode:getContentSize().height

	if self.listViewNode ~= nil then
		self.listViewNode:removeFromParent()

		self.listViewNode = nil
	end

	self.listViewNode = self:getTableView(var_110_1, math.ceil(#var_110_1 / 1), function(arg_111_0)
		return var_110_3, var_110_4
	end, cc.size(var_110_3, GameDisplay.height - 95 - 75), function(arg_112_0, arg_112_1, arg_112_2)
		local var_112_0 = arg_112_2[arg_112_1 * var_110_2 + 1]
		local var_112_1 = arg_112_0:dequeueCell()

		if var_112_1 == nil then
			var_112_1 = cc.TableViewCell:new()
		end

		local var_112_2 = var_112_1:getChildByName("item")

		if var_112_2 then
			var_112_2:removeFromParent()
		end

		local var_112_4 = ccui.Layout:create()

		var_112_4:setContentSize(cc.size(634, 200))
		var_112_4:setVisible(true)
		var_112_4:setName("item")
		var_112_1:addChild(var_112_4)

		local var_112_5 = ccui.Button:create("mainScenebg/schoolfile/" .. arg_112_2[arg_112_1 * var_110_2 + 1].itemPath .. ".png", "mainScenebg/schoolfile/" .. arg_112_2[arg_112_1 * var_110_2 + 1].itemPath .. ".png", "mainScenebg/schoolfile/" .. arg_112_2[arg_112_1 * var_110_2 + 1].itemPath .. ".png")

		var_112_5:setAnchorPoint(cc.p(0, 0))
		var_112_5:setSwallowTouches(false)

		var_112_5.index = arg_112_1 * var_110_2 + 1

		var_112_5:addTouchEventListener(function(arg_113_0, arg_113_1)
			if arg_113_1 ~= ccui.TouchEventType.ended or var_112_0.isUnlock == false then
				return
			end

			if math.abs(arg_113_0:getTouchBeganPosition().y - arg_113_0:getTouchEndPosition().y) > 30 then
				return
			end

			print("click")
			self:showPlotDetail6Panel(var_110_0, arg_113_0.index)
		end)
		var_112_4:addChild(var_112_5)

		local var_112_6 = ccui.Text:create(arg_112_2[arg_112_1 * var_110_2 + 1].title, FONT_NAME, 22)

		var_112_6:setPosition(cc.p(620, 190))
		var_112_6:setAnchorPoint(cc.p(1, 1))
		var_112_4:addChild(var_112_6)

		return var_112_1
	end, function(arg_114_0, arg_114_1)
		print("click ")
	end)

	self.listViewNode:setPosition(cc.p(4, 75))
	self.plotNode:addChild(self.listViewNode)
end

function SchoolCinemaLayer.getTableView(arg_115_0, arg_115_1, arg_115_2, arg_115_3, arg_115_4, arg_115_5, arg_115_6)
	local var_115_0 = cc.TableView:create(arg_115_4)

	var_115_0:setVisible(true)
	var_115_0:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	var_115_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_115_0:setDelegate()
	var_115_0:registerScriptHandler(function(arg_116_0)
		return arg_115_2
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	var_115_0:registerScriptHandler(function(arg_117_0)
		arg_115_0:scrollViewDidScroll(arg_117_0)
	end, cc.SCROLLVIEW_SCRIPT_SCROLL)
	var_115_0:registerScriptHandler(function(arg_118_0, arg_118_1)
		arg_115_6(arg_118_0, arg_118_1)
	end, cc.TABLECELL_TOUCHED)
	var_115_0:registerScriptHandler(function(arg_119_0, arg_119_1)
		local var_119_0 = 100
		local var_119_1 = 100

		if type(arg_115_3) == "function" then
			var_119_0, var_119_1 = arg_115_3(arg_119_1)
		end

		return var_119_0, var_119_1
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	var_115_0:registerScriptHandler(function(arg_120_0, arg_120_1)
		return arg_115_5(arg_120_0, arg_120_1, arg_115_1)
	end, cc.TABLECELL_SIZE_AT_INDEX)
	var_115_0:reloadData()
	var_115_0:setAnchorPoint(cc.p(0, 1))

	return var_115_0
end

function SchoolCinemaLayer.scrollViewDidScroll(arg_121_0, arg_121_1)
	return
end

function SchoolCinemaLayer:getItemPlotNodeByIndex(arg_122_1)
	local var_122_0 = ccui.Layout:create()

	if arg_122_1 == 1 then
		var_122_0:setContentSize(cc.size(640, GameDisplay.height + GameDisplay.fix_y))
		var_122_0:setAnchorPoint(cc.p(0, 0))
		var_122_0:setPosition(cc.p(0, 0))

		local var_122_1 = ccui.Button:create("SchoolCinemaLayer/plot/plot1/btn_start.png", "SchoolCinemaLayer/plot/plot1/btn_start.png", "SchoolCinemaLayer/plot/plot1/btn_start.png", var_0_11)
		local var_122_2 = ccui.Button:create("SchoolCinemaLayer/plot/plot1/btn_zuzhi.png", "SchoolCinemaLayer/plot/plot1/btn_zuzhi.png", "SchoolCinemaLayer/plot/plot1/btn_zuzhi.png", var_0_11)

		var_122_0:addChild(var_122_1)
		var_122_0:addChild(var_122_2)
		var_122_1:setPosition(cc.p(310, 780 + (GameDisplay.height + GameDisplay.fix_y - 1136) / 2))
		var_122_2:setPosition(cc.p(310, 290 + (GameDisplay.height + GameDisplay.fix_y - 1136) / 4))
		var_122_1:addTouchEventListener(function(arg_123_0, arg_123_1)
			if arg_123_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:showPlotDetail1Panel(arg_122_1, 1)
		end)
		var_122_2:addTouchEventListener(function(arg_124_0, arg_124_1)
			if arg_124_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:showPlotDetail1Panel(arg_122_1, 2)
		end)
	elseif arg_122_1 == 2 then
		-- block empty
	elseif arg_122_1 == 3 then
		if self.plotItemNode == nil then
			self:loadPlotItemPrefab()
		end

		var_122_0 = self.plotItemNode:getChildByName("item_plot3")
	elseif arg_122_1 == 4 then
		if self.plotItemNode == nil then
			self:loadPlotItemPrefab()
		end

		var_122_0 = self.plotItemNode:getChildByName("item_plot4")
	elseif arg_122_1 == 5 then
		-- block empty
	elseif arg_122_1 == 6 then
		-- block empty
	end

	return var_122_0
end

function SchoolCinemaLayer:clickPostCardCallback(arg_125_1)
	if arg_125_1 == nil then
		return
	end

	local var_125_0 = ccui.Layout:create()

	var_125_0:setTouchEnabled(true)
	var_125_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_125_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_125_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
	var_125_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_125_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_125_0:setBackGroundColorOpacity(180)
	self:addChild(var_125_0, 10)

	local var_125_1 = ccui.Button:create(arg_125_1.itemPath, arg_125_1.itemPath, arg_125_1.itemPath)

	var_125_1:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 + 100))
	var_125_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.3, 1.2), cc.ScaleTo:create(0.1, 1)))
	var_125_0:addChild(var_125_1)

	local var_125_2 = cc.Label:createWithTTF(arg_125_1.des, FONT_DES, 24)

	var_125_2:setMaxLineWidth(var_125_1:getContentSize().width - 30)

	local var_125_3 = var_125_2:getContentSize().height + 10

	if var_125_3 < 100 then
		var_125_3 = 100
	end

	var_125_2:setColor(cc.c3b(53, 61, 83))
	var_125_2:setAnchorPoint(cc.p(0, 1))
	var_125_2:setPosition(cc.p(20, var_125_3))

	local var_125_4 = ccui.Layout:create()

	var_125_4:setTouchEnabled(false)
	var_125_4:setContentSize(cc.size(var_125_1:getContentSize().width, var_125_3))
	var_125_4:setAnchorPoint(cc.p(0.5, 1))
	var_125_4:setPosition(cc.p(var_125_1:getContentSize().width / 2, 0))
	var_125_4:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_125_4:setBackGroundColor(cc.c3b(158, 172, 192))
	var_125_4:setBackGroundColorOpacity(255)
	var_125_1:addChild(var_125_4, 1)
	var_125_4:addChild(var_125_2)
	var_125_1:addTouchEventListener(function(arg_126_0, arg_126_1)
		var_125_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 0.1), cc.CallFunc:create(function()
			if callback then
				callback()
			end
		end), cc.RemoveSelf:create(), cc.CallFunc:create(function()
			self:removeChild(var_125_0)
		end)))
	end)
	var_125_0:addTouchEventListener(function(arg_129_0, arg_129_1)
		var_125_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 0.1), cc.CallFunc:create(function()
			if callback then
				callback()
			end
		end), cc.RemoveSelf:create(), cc.CallFunc:create(function()
			self:removeChild(var_125_0)
		end)))
	end)
end

function SchoolCinemaLayer:lateUpdate(arg_132_1)
	if self.cinemaScheduler ~= nil then
		self.scheduler:unscheduleScriptEntry(self.cinemaScheduler)

		self.cinemaScheduler = nil
	end

	self.cinemaScheduler = self.scheduler:scheduleScriptFunc(function()
		if self.cinemaScheduler ~= nil then
			self.scheduler:unscheduleScriptEntry(self.cinemaScheduler)

			self.cinemaScheduler = nil
		end

		if type(arg_132_1) == "function" then
			arg_132_1()
		end
	end, 0, false)
end

function SchoolCinemaLayer:loadDetailItemPrefab()
	self.detailItemNode = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "SchoolCinemaLayer_detail_item.json" or "SchoolCinemaLayer_detail_item.ExportJson")

	self.rootLayer:addChild(self.detailItemNode, -1)
end

function SchoolCinemaLayer:getDetailItemNodeByIndex(arg_135_1)
	if self.detailItemNode == nil then
		self:loadDetailItemPrefab()
	end

	return arg_135_1 == 1 and self.detailItemNode:getChildByName("item_detail_1") or arg_135_1 == 4 and self.detailItemNode:getChildByName("item_detail_4") or self.detailItemNode:getChildByName("item_detail_2")
end

function SchoolCinemaLayer:loadPlotItemPrefab()
	self.plotItemNode = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "SchoolCinemaLayer_plot_item.json" or "SchoolCinemaLayer_plot_item.ExportJson")

	self.rootLayer:addChild(self.plotItemNode, -1)
end

function SchoolCinemaLayer:loadDeepItemPrefab()
	if self.deepItemNode == nil then
		self.deepItemNode = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "SchoolCinemaLayer_deep_item.json" or "SchoolCinemaLayer_deep_item.ExportJson")

		self.deepItemNode:setVisible(false)
		self.rootLayer:addChild(self.deepItemNode, -1)
	end
end

function SchoolCinemaLayer.playPV(arg_138_0, arg_138_1)
	require("view.Layer.VideoPlayerLayer")

	local audio_manager = require("controller.audio_manager")
	local var_138_1 = audio_manager.music_volume

	audio_manager.music_volume = 0

	audio_manager:setMusicVolume()

	local var_138_2 = VideoPlayerLayer:create(arg_138_1, true)

	global_basic_scene:addChild(var_138_2, ZORDER_TALKLAYER)

	local var_138_3 = false

	local function var_138_4()
		if var_138_3 then
			return
		end

		var_138_3 = true

		var_138_2:runAction(cc.RemoveSelf:create())

		audio_manager.music_volume = var_138_1

		audio_manager:setMusicVolume()
	end

	var_138_2:registerEventHandler(3, var_138_4)
	var_138_2:registerEventHandler(2, var_138_4)
	var_138_2:play()
end
