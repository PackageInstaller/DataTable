TitleSprite = class("TitleSprite", function()
	return ccui.Layout:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local var_0_1 = "public/panelbg/top_bg.png"
local var_0_2 = 1
local var_0_3 = 2

function TitleSprite.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = TitleSprite.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3)

	return var_2_0
end

function TitleSprite:init(arg_3_1, arg_3_2, arg_3_3)
	self:setContentSize(cc.size(640, 56))
	self:setBackGroundImage(arg_3_3 or var_0_1, var_0_0)
	self:setTouchEnabled(true)

	arg_3_2 = arg_3_2 or var_0_2
	self.titletype = arg_3_2

	if arg_3_2 == var_0_2 then
		self.title = cc.Label:createWithTTF(arg_3_1, "fonts/newkj.ttf", 30)

		self.title:setAnchorPoint(cc.p(0, 0.5))
		self.title:setPosition(cc.p(10, 28))

		if arg_3_1 ~= L_ITEM_CONFIG_NAME.ITEMPANEL_TYPE_MEDAL then
			self:addChild(self.title)
		end
	elseif arg_3_2 == var_0_3 then
		self.title = ccui.ImageView:create(arg_3_1, var_0_0)

		self.title:setName("title")
		self.title:setAnchorPoint(cc.p(0, 0.5))
		self.title:setPosition(cc.p(0, 28))
		self:addChild(self.title)
	end
end

function TitleSprite:updateinfo(arg_4_1)
	if self.titletype == var_0_2 then
		self.title:setString(arg_4_1)
	elseif self.titletype == var_0_3 then
		self.title:loadTexture(arg_4_1, var_0_0)
	end
end
