local level_manager = require("controller.level_manager")
local playermodel = require("model.playermodel")
local patrol_manager = require("controller.patrol_manager")
local item_data = require("data.item_data")
local var_0_4 = config._DEBUG and 0 or 1
local var_0_5 = "Activities/activity"
local var_0_6 = "public/box/"
local var_0_8 = {
	{
		STAR_POSY = 75,
		STAR_X = 25,
		STAR_START_POSX = 55,
		NAME_POS = cc.p(60, 56),
		CURTAG_POS = cc.p(60, 77),
		BILINGNODE_POS = cc.p(110, -2)
	},
	[186] = {
		STAR_POSY = 75,
		STAR_X = 25,
		STAR_START_POSX = 55,
		NAME_POS = cc.p(140, 56),
		CURTAG_POS = cc.p(60, 77),
		BILINGNODE_POS = cc.p(110, -2)
	},
	[227] = {
		STAR_POSY = 75,
		STAR_X = 25,
		STAR_START_POSX = 55,
		NAME_POS = cc.p(65, 45),
		CURTAG_POS = cc.p(60, 77),
		BILINGNODE_POS = cc.p(110, -2)
	},
	[230] = {
		STAR_POSY = 75,
		STAR_X = 25,
		STAR_START_POSX = 55,
		NAME_POS = cc.p(75, 27),
		CURTAG_POS = cc.p(60, 77),
		BILINGNODE_POS = cc.p(110, -2)
	},
	[257] = {
		STAR_POSY = 75,
		STAR_X = 25,
		STAR_START_POSX = 55,
		NAME_POS = cc.p(75, 27),
		CURTAG_POS = cc.p(60, 77),
		BILINGNODE_POS = cc.p(110, -2)
	},
	[286] = {
		STAR_POSY = 75,
		STAR_X = 25,
		STAR_START_POSX = 55,
		NAME_POS = cc.p(50, 27),
		CURTAG_POS = cc.p(60, 77),
		BILINGNODE_POS = cc.p(110, -2)
	},
	[300] = {
		STAR_POSY = 75,
		STAR_X = 25,
		STAR_START_POSX = 55,
		NAME_POS = cc.p(50, 35),
		CURTAG_POS = cc.p(60, 77),
		BILINGNODE_POS = cc.p(110, -2)
	},
	[304] = {
		STAR_POSY = 75,
		STAR_X = 25,
		STAR_START_POSX = 55,
		NAME_POS = cc.p(50, 35),
		CURTAG_POS = cc.p(60, 77),
		BILINGNODE_POS = cc.p(110, -2)
	},
	[312] = {
		STAR_POSY = 75,
		STAR_X = 25,
		STAR_START_POSX = 55,
		NAME_POS = cc.p(50, 35),
		CURTAG_POS = cc.p(60, 77),
		BILINGNODE_POS = cc.p(110, -2)
	},
	[315] = {
		STAR_POSY = 75,
		STAR_X = 25,
		STAR_START_POSX = 55,
		NAME_POS = cc.p(80, 44),
		CURTAG_POS = cc.p(60, 77),
		BILINGNODE_POS = cc.p(110, -2)
	},
	[333] = {
		STAR_POSY = 75,
		STAR_X = 25,
		STAR_START_POSX = 55,
		NAME_POS = cc.p(80, 44),
		CURTAG_POS = cc.p(60, 77),
		BILINGNODE_POS = cc.p(110, -2)
	},
	[334] = {
		STAR_POSY = 75,
		STAR_X = 25,
		STAR_START_POSX = 55,
		NAME_POS = cc.p(60, 38),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -2)
	},
	[405] = {
		STAR_POSY = 110,
		STAR_X = 25,
		STAR_START_POSX = 70,
		NAME_POS = cc.p(140, 86),
		CURTAG_POS = cc.p(60, 77),
		BILINGNODE_POS = cc.p(110, -2)
	},
	[428] = {
		STAR_POSY = 87,
		STAR_X = 25,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(70, 60),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52)
	},
	[430] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 15,
		NAME_POS = cc.p(80, 40),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52)
	},
	[441] = {
		STAR_POSY = 70,
		STAR_X = 30,
		STAR_START_POSX = 15,
		NAME_POS = cc.p(80, 30),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52)
	},
	[457] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(70, 50),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52)
	},
	[463] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(70, 50),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52)
	},
	[479] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(70, 50),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52)
	},
	[481] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(70, 50),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52)
	},
	[492] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(70, 50),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(0, 0, 0)
	},
	[500] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(255, 255, 255)
	},
	[507] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(255, 255, 255)
	},
	[508] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(100, 72),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(255, 255, 255)
	},
	[512] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(100, 72),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(255, 255, 255)
	},
	[511] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(255, 255, 255)
	},
	[521] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(255, 255, 255)
	},
	[526] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(255, 255, 255)
	},
	[527] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(255, 255, 255)
	},
	[522] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(255, 255, 255)
	},
	[529] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(255, 255, 255)
	},
	[530] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(255, 255, 255)
	},
	[534] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(255, 255, 255)
	},
	[537] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(255, 255, 255)
	},
	[545] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(255, 255, 255)
	},
	[562] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(255, 255, 255)
	},
	[574] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(255, 255, 255)
	},
	[576] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(255, 255, 255)
	},
	[584] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(0, 0, 0)
	},
	[591] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(0, 0, 0)
	},
	[589] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(0, 0, 0)
	},
	[593] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(0, 0, 0)
	},
	[703] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(0, 0, 0)
	},
	[707] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(0, 0, 0)
	},
	[714] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(70, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(255, 255, 255)
	},
	[713] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(0, 0, 0)
	},
	[717] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(255, 255, 255)
	},
	[721] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(255, 255, 255)
	},
	[720] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(255, 255, 255)
	},
	[722] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(0, 0, 0)
	},
	[755] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(0, 0, 0)
	},
	[761] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(0, 0, 0)
	},
	[773] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(0, 0, 0)
	},
	[767] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(0, 0, 0)
	},
	[775] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(55, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(0, 0, 0)
	},
	[855] = {
		STAR_POSY = 80,
		STAR_X = 30,
		STAR_START_POSX = 10,
		NAME_POS = cc.p(70, 42),
		CURTAG_POS = cc.p(50, 32),
		BILINGNODE_POS = cc.p(110, -52),
		NAME_COLOR = cc.c3b(0, 0, 0)
	}
}

ChapterSpriteActivityLevel = class("ChapterSpriteActivityLevel", function()
	return ccui.Button:create(nil, nil, nil, var_0_4)
end)

function ChapterSpriteActivityLevel.create(arg_2_0, arg_2_1)
	local var_2_0 = ChapterSpriteActivityLevel.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ChapterSpriteActivityLevel:init(arg_3_1)
	self:setContentSize(cc.size(220, 92))

	self.initcitytype = arg_3_1.initcitytype
	self.resourcePath = var_0_5 .. self.initcitytype .. "/levelmap/"

	local var_3_0 = var_0_8[self.initcitytype] or var_0_8[1]
	local var_3_1 = var_3_0.NAME_POS
	local var_3_2 = cc.p(220 / 2 + 120, 92 / 2 + 25)
	local var_3_3 = cc.p(220 / 2 + 120, 92 / 2 + 25)
	local var_3_4 = var_3_0.NAME_COLOR or cc.c3b(255, 255, 255)

	self:setPressedActionEnabled(true)
	self:setAnchorPoint(cc.p(0.5, 0))

	local var_3_5 = ACTIVITY_LEVEL_FONT_PATH[self.initcitytype] or ACTIVITY_LEVEL_FONT_PATH.Default
	local var_3_6 = var_3_5.path
	local var_3_7 = var_3_5.size or 20
	local var_3_8 = ccui.Text:create()

	var_3_8:setFontName(var_3_6)
	var_3_8:setFontSize(var_3_7)
	var_3_8:setColor(var_3_4)
	var_3_8:setAnchorPoint(cc.p(0, 0.5))
	var_3_8:setPosition(var_3_1)
	var_3_8:setName("name")
	self:addChild(var_3_8)

	local var_3_9 = ccui.ImageView:create(self.resourcePath .. "frame_drop.png", var_0_4)

	var_3_9:setPosition(var_3_2)
	var_3_9:setName("drop")
	self:addChild(var_3_9)

	local var_3_10 = ccui.ImageView:create(self.resourcePath .. "img_unknow_drop.png", var_0_4)

	var_3_10:setPosition(var_3_2)
	var_3_10:setName("dropimg")
	var_3_9:addChild(var_3_10)

	local var_3_11 = ccui.Button:create(var_0_6 .. "1.png", var_0_6 .. "1.png", var_0_6 .. "1.png", var_0_4)

	var_3_11:setVisible(false)
	var_3_11:setScale(var_3_10:getContentSize().width / var_3_11:getContentSize().width)
	var_3_11:setPosition(var_3_3)
	var_3_11:setName("item")
	self:addChild(var_3_11)

	local var_3_12 = ccui.Button:create(nil, nil, nil)

	var_3_12:setScale(var_3_11:getContentSize().width / var_3_12:getContentSize().width)
	var_3_12:setPosition(var_3_3)
	var_3_12:setName("icon")
	var_3_11:addChild(var_3_12)

	local var_3_13 = ccui.ImageView:create(self.resourcePath .. "img_curtag.png", var_0_4)

	var_3_13:setAnchorPoint(cc.p(0.5, 0))
	var_3_13:setPosition(var_3_0.CURTAG_POS)
	var_3_13:setVisible(false)
	var_3_13:setName("curtag")
	self:addChild(var_3_13)

	function var_3_13.runFadeAction(...)
		var_3_13:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(2, 255), cc.FadeTo:create(2, 128))))
	end

	local var_3_14 = ccui.ImageView:create(self.resourcePath .. "levelItem_select.png", var_0_4)

	var_3_14:setAnchorPoint(cc.p(0.5, 0))
	var_3_14:setPosition(var_3_0.BILINGNODE_POS)
	var_3_14:setVisible(false)
	var_3_14:setName("biling")
	self:addChild(var_3_14, -1)

	local var_3_15 = ccui.ImageView:create(self.resourcePath .. "img_tag_can_patrol.png", var_0_4)

	var_3_15:setAnchorPoint(cc.p(0, 0))
	var_3_15:setPosition((cc.p(35, 80)))
	var_3_15:setVisible(false)
	var_3_15:setName("newtag")
	self:addChild(var_3_15)

	local var_3_16 = ccui.ImageView:create(self.resourcePath .. "img_tagcomplete.png", var_0_4)

	var_3_16:setAnchorPoint(cc.p(0, 0))
	var_3_16:setPosition((cc.p(35, 80)))
	var_3_16:setVisible(false)
	var_3_16:setName("completetag")
	self:addChild(var_3_16)

	local var_3_17 = cc.Label:createWithTTF("00:00", FONT_DES, 25)

	var_3_17:setAnchorPoint(cc.p(0, 0))
	var_3_17:setPosition((cc.p(35, 80)))
	var_3_17:setName("timer")
	self:addChild(var_3_17)

	for iter_3_0 = 1, LEVEL_STARS_NUM do
		local var_3_18 = ccui.ImageView:create("", var_0_4)

		var_3_18:setName("star" .. iter_3_0)
		var_3_18:setPosition(var_3_0.STAR_START_POSX + (iter_3_0 - 1) * var_3_0.STAR_X, var_3_0.STAR_POSY)
		self:addChild(var_3_18)
	end
end

function ChapterSpriteActivityLevel:_setSwallowTouches(arg_5_1)
	self:setSwallowTouches(arg_5_1)
	ccui.Helper:seekWidgetByName(self, "item"):setSwallowTouches(arg_5_1)
end

function ChapterSpriteActivityLevel:_addTouchEventListener(arg_6_1)
	self:addTouchEventListener(arg_6_1)
	self:getChildByName("item"):getChildByName("icon"):addTouchEventListener(function(arg_7_0, arg_7_1)
		if type(arg_6_1) == "function" then
			arg_6_1()
		end
	end)
end

local var_0_9 = {
	"easy",
	"hard",
	"hell",
	"nightmare"
}

function ChapterSpriteActivityLevel:update(arg_8_1)
	local var_8_0 = arg_8_1.curdifficuty or 1
	local var_8_1 = arg_8_1.chapter
	local var_8_2 = level_manager:getModeByDifficulty(arg_8_1.curcity, var_8_0)

	if level_manager:getChapterStrongholdLv(var_8_2, arg_8_1.chapter) ~= 1 and var_8_1 % 2 == 1 then
		-- block empty
	end

	local var_8_4 = not level_manager:isLevelModeUnlocked(var_8_2) and self.resourcePath .. "levelItem_lock.png" or level_manager:isChapterModeUnlocked(var_8_2, var_8_1) and self.resourcePath .. "levelItem" .. "_" .. var_0_9[var_8_0] .. ".png" or self.resourcePath .. "levelItem_lock.png"

	self:loadTextures(var_8_4, var_8_4, var_8_4, var_0_4)
	self:getChildByName("name"):setString(level_manager:getChapterName(var_8_2, var_8_1))
	self:getChildByName("drop"):setVisible(false)
	self:getChildByName("newtag"):setVisible(false)
	self:getChildByName("completetag"):setVisible(false)
	self:getChildByName("timer"):setVisible(false)
	self:getChildByName("item"):setVisible(false)

	local var_8_5 = level_manager:getChapterStarsState(var_8_2, var_8_1)

	for iter_8_0 = 1, LEVEL_STARS_NUM do
		local var_8_6 = self:getChildByName("star" .. iter_8_0)

		if var_8_5[iter_8_0] then
			var_8_6:loadTexture(self.resourcePath .. "star_icon.png", var_0_4)
		else
			var_8_6:loadTexture(self.resourcePath .. "star_gray.png", var_0_4)
		end
	end

	self:getChildByName("item"):getChildByName("icon").chapter = self.chapter
end

function ChapterSpriteActivityLevel:updateTimer(arg_9_1)
	self:getChildByName("timer"):setString(arg_9_1)
end
