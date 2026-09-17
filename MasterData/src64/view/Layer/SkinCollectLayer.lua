SkinCollectLayer = class("SkinCollectLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.ItemSprite")
require("view.Sprite.BottomBtnList")

local item_data = require("data.item_data")
local item_manager = require("controller.item_manager")
local var_0_2 = config._DEBUG and 0 or 1

function SkinCollectLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = SkinCollectLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function SkinCollectLayer:init(arg_3_1)
	self.initconfig = arg_3_1
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2 - GameDisplay.fix_y))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self:addChild(self.rootLayer)

	local var_3_0 = ccui.ImageView:create("mainScenebg/hocruxbg.jpg")

	var_3_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_3_0:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, self.rootLayer:getContentSize().height / 2))
	self.rootLayer:addChild(var_3_0)
	self:initData()
	self:initUI()
	self:updateUI()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			-- block empty
		end
	end)
end

function SkinCollectLayer:initData(...)
	self.skinList = self.initconfig.skinList
end

function SkinCollectLayer:initUI(...)
	self.titleheight = 54
	self.bottomheight = 50
	self.desImg = ccui.ImageView:create("DropItemDisplay/title_skilcollect.png", var_0_2)

	self.desImg:setAnchorPoint(cc.p(0, 0.5))
	self.desImg:setPositionX(10)
	self.desImg:setPositionY(self.rootLayer:getContentSize().height - self.titleheight - self.desImg:getContentSize().height / 2 + 5)
	self.rootLayer:addChild(self.desImg)
	self:initBottomBtnList()

	for iter_6_0, iter_6_1 in pairs(self.skinList) do
		if item_manager:getItemNumber(iter_6_1) > 0 then
			-- block empty
		end
	end

	self.titleheight = self.titleheight + self.desImg:getContentSize().height - 15

	self:createTitle()
end

function SkinCollectLayer:updateUI(...)
	local var_7_0 = cc.size(200 * 0.8, 240 * 0.8)
	local var_7_1 = math.floor(self.rootLayer:getContentSize().width / var_7_0.width)
	local var_7_2 = self.rootLayer:getContentSize().height - var_7_0.height / 2 - self.titleheight

	for iter_7_0, iter_7_1 in pairs(self.skinList) do
		local var_7_3 = ccui.Layout:create()

		var_7_3:setContentSize(var_7_0)
		var_7_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_7_3:setPosition(cc.p(var_7_0.width / 2, var_7_2))
		var_7_3:setScale(0.8)
		self.rootLayer:addChild(var_7_3)

		local var_7_4 = ItemSprite:createNewWithItemId(iter_7_1, nil, nil, item_data[iter_7_1].name)

		var_7_4:setPosition(cc.p(var_7_3:getContentSize().width / 2, var_7_3:getContentSize().height / 2))
		var_7_4:setName("itemsp")
		var_7_3:addChild(var_7_4)

		local var_7_5 = ccui.Button:create("GUI/image.png", "GUI/image.png", "GUI/image.png", var_0_2)

		var_7_5:setSwallowTouches(false)
		var_7_5:setScale9Enabled(true)
		var_7_5:setCapInsets(cc.rect(20, 20, 20, 20))
		var_7_5:setContentSize(var_7_0)
		var_7_5:setAnchorPoint(cc.p(0.5, 0.5))
		var_7_5:setPosition(cc.p(var_7_0.width / 2, var_7_0.height / 2))
		var_7_5:setOpacity(0)
		var_7_3:addChild(var_7_5)

		if item_manager:getItemNumber(iter_7_1) == 0 then
			local var_7_6 = ccui.Layout:create()

			var_7_6:setContentSize(var_7_4:getContentSize())
			var_7_6:setContentSize(cc.size(var_7_4:getContentSize().width + 4, var_7_4:getContentSize().height + 4))
			var_7_6:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
			var_7_6:setBackGroundColor(cc.c3b(0, 0, 0))
			var_7_6:setBackGroundColorOpacity(120)
			var_7_6:setAnchorPoint(cc.p(0.5, 0.5))
			var_7_6:setPositionX(var_7_3:getContentSize().width / 2 - 2)
			var_7_6:setPositionY(var_7_3:getContentSize().height / 2 - 2)
			var_7_3:addChild(var_7_6, 2)

			local var_7_7 = cc.Label:createWithTTF("前往获取", FONT_NAME, 30)

			var_7_7:setPosition(cc.p(var_7_6:getContentSize().width / 2, var_7_6:getContentSize().height / 2 - 56))
			var_7_6:addChild(var_7_7)
		end

		var_7_5:addTouchEventListener(function(arg_8_0, arg_8_1)
			if arg_8_1 ~= ccui.TouchEventType.ended then
				return
			end

			if item_manager:getItemNumber(iter_7_1) == 0 then
				LayerManager:pushInLayer("PopGoGainLayer", {
					item = iter_7_1,
					layer = cc.Layer:create()
				})
			else
				local var_8_0 = {
					itemid = iter_7_1
				}

				var_8_0.layer = cc.Layer:create()

				PopLayer:Item(var_8_0)
			end
		end)

		var_7_2 = self.rootLayer:getContentSize().height - var_7_0.height / 2 - math.floor(iter_7_0 / var_7_1) * var_7_0.height - self.titleheight
	end
end

function SkinCollectLayer:initBottomBtnList()
	self.bottomList = BottomBtnList:create(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)

	self.bottomList:setName("bottomBtn")
	self.rootLayer:addChild(self.bottomList, 10)
end

function SkinCollectLayer:createTitle()
	self.title = TitleSprite:create("public/title/title_activity_collection.png", 2)

	self.title:setPosition(cc.p(0, 1080 + GameDisplay.fix_y * 2))
	self.rootLayer:addChild(self.title, 10)
end

function SkinCollectLayer.exit(arg_12_0)
	LayerManager:removePopLayer()
end

return SkinCollectLayer
