PopShowGirl = class("PopShowGirl", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

require("view.Sprite.ItemSprite")

local item_manager = require("controller.item_manager")
local playermodel = require("model.playermodel")
local core_manager = require("controller.core_manager")
local item_data = require("data.item_data")
local servant_data = require("data.servant_data")
local model_data = require("data.model_data")
local var_0_7 = "role/"

function PopShowGirl.create(arg_2_0, arg_2_1)
	local var_2_0 = PopShowGirl.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

local function var_0_8(arg_3_0)
	local var_3_0, var_3_1 = arg_3_0:match("([^,]+),(.+)")

	return cc.p(checknumber(var_3_0), checknumber(var_3_1))
end

function PopShowGirl:initBg(arg_4_1)
	self.servantid = arg_4_1.servantid
	self.layout = ccui.Layout:create()

	self.layout:setContentSize(cc.size(640, GameDisplay.height))
	self.layout:setAnchorPoint(cc.p(0.5, 0.5))
	self.layout:setBackGroundImage(DATABASEBG)
	self.layout:setPosition(cc.p(320, GameDisplay.height / 2 - GameDisplay.fix_y))
	self.layout:setTouchEnabled(true)
	self:addChild(self.layout)
	self.layout:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.is_more_touch then
			return
		end

		print("@@@@@@removePopLayer@@@@@@")
		LayerManager:removePopLayer(self.__queueindex)
	end)

	self.image_Panel = ccui.Layout:create()

	self.image_Panel:setTouchEnabled(false)
	self.image_Panel:setContentSize(cc.size(640, GameDisplay.height))
	self.image_Panel:setAnchorPoint(cc.p(0.5, 0.5))
	self.image_Panel:setPosition(cc.p(320, self.layout:getContentSize().height / 2))
	self.layout:addChild(self.image_Panel)

	local var_4_0 = ""

	var_4_0 = servant_data[self.servantid] and (arg_4_1.modelid or global_get_servant_skin(self.servantid)) or tostring((not arg_4_1.modelid or nil) and self.servantid)

	local var_4_2 = model_data[var_4_0].role_image
	local var_4_3 = self:getOffset(var_4_0)

	self.Image_Role = ccui.ImageView:create("GUI/image.png", var_0_0)

	self.Image_Role:setTouchEnabled(false)
	self.Image_Role:setAnchorPoint(cc.p(0.5, 0))
	self.Image_Role:setPosition(cc.p(self.layout:getContentSize().width / 2, self.layout:getContentSize().height / 2))
	self.image_Panel:addChild(self.Image_Role, -1)
	self.Image_Role:loadTexture(var_0_7 .. var_4_2 .. ".png")

	self.Image_Role_x = self.Image_Role:getContentSize().width

	self.Image_Role:setPosition(cc.p(var_4_3.x, var_4_3.y + 72))

	self.operator = {
		scale = false,
		move = false
	}
	self.touchPoint = {}
	self.touchPointScale = {}
	self.pos_s = {}
	self.scalerate = 1
	self.min_scale = 1
	self.max_scale = 1.5
	self.lastdis = 0

	if not model_data[var_4_0].is_big_role_image then
		self:Role_Zoom()
	end

	AnalyticManager.click_popshowgirl({
		servantid = self.servantid
	})
end

function PopShowGirl:getOffset(arg_6_1, arg_6_2)
	local var_6_1

	if arg_6_2 then
		var_6_1 = self.displayType == "preview" and cc.p(model_data[arg_6_1].database_offset_x + HIDEGIRLPOS.x, model_data[arg_6_1].database_offset_y + HIDEGIRLPOS.y) or cc.p((model_data[arg_6_1].database_equip_offset_x or 0) + HIDEGIRLPOS.x, nil + HIDEGIRLPOS.y)
	else
		var_6_1 = model_data[arg_6_1].mainmidpos and var_0_8(model_data[arg_6_1].mainmidpos) or cc.p(320, -50)
		offset = model_data[arg_6_1].mainmidoffset and var_0_8(model_data[arg_6_1].mainmidoffset) or cc.p(0, 0)
		var_6_1.x = var_6_1.x + offset.x
		var_6_1.y = var_6_1.y + offset.y
	end

	if model_data[arg_6_1].is_big_role_image == 1 then
		var_6_1.x = 320
		var_6_1.y = -104
	end

	return var_6_1
end

function PopShowGirl:Role_Zoom()
	local var_7_0 = cc.EventListenerTouchAllAtOnce:create()

	var_7_0:registerScriptHandler(function(arg_8_0, arg_8_1)
		return true
	end, cc.Handler.EVENT_TOUCHES_BEGAN)
	var_7_0:registerScriptHandler(function(arg_9_0, arg_9_1)
		if #arg_9_0 == 1 then
			local var_9_0 = arg_9_0[1]:getLocation()
			local var_9_1 = arg_9_0[1]:getPreviousLocation()
			local var_9_2 = arg_9_0[1]:getStartLocation()
			local var_9_3 = self.image_Panel:getPositionX() - (var_9_1.x - var_9_0.x)
			local var_9_4 = self.image_Panel:getPositionY() - (var_9_1.y - var_9_0.y)

			if var_9_3 < 0 then
				var_9_3 = 0
			end

			if var_9_3 > 640 then
				var_9_3 = 640
			end

			if var_9_4 < 0 then
				var_9_4 = 0
			end

			if var_9_4 > GameDisplay.height - GameDisplay.fix_y then
				var_9_4 = GameDisplay.height - GameDisplay.fix_y
			end

			self.image_Panel:setPosition(var_9_3, var_9_4)

			self.lastdis = 0

			if ((var_9_2.x - var_9_0.x)^2 + (var_9_2.y - var_9_0.y)^2)^0.5 > 12 then
				self.is_more_touch = true
			end
		elseif #arg_9_0 == 2 then
			local var_9_5 = arg_9_0[1]:getLocation()
			local var_9_6 = arg_9_0[2]:getLocation()
			local var_9_7 = arg_9_0[1]:getStartLocation()
			local var_9_8 = arg_9_0[2]:getStartLocation()

			print("more touch@@@@@@", dump({
				var_9_5,
				var_9_6,
				var_9_7,
				var_9_8
			}))

			self.scalerate = (((var_9_5.x - var_9_6.x)^2 + (var_9_5.y - var_9_6.y)^2)^0.5 - ((var_9_7.x - var_9_8.x)^2 + (var_9_7.y - var_9_8.y)^2)^0.5 - self.lastdis) / 550 + self.scalerate
			self.lastdis = ((var_9_5.x - var_9_6.x)^2 + (var_9_5.y - var_9_6.y)^2)^0.5 - ((var_9_7.x - var_9_8.x)^2 + (var_9_7.y - var_9_8.y)^2)^0.5

			if self.scalerate < self.min_scale then
				self.scalerate = self.min_scale
			end

			if self.scalerate > self.max_scale then
				self.scalerate = self.max_scale
			end

			self.image_Panel:setScale(self.scalerate)

			self.is_more_touch = true
		end
	end, cc.Handler.EVENT_TOUCHES_MOVED)
	var_7_0:registerScriptHandler(function(arg_10_0, arg_10_1)
		self.is_more_touch = false
		self.lastdis = 0
	end, cc.Handler.EVENT_TOUCHES_ENDED)
	self.image_Panel:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_7_0, self.image_Panel)

	local var_7_1 = cc.EventListenerTouchOneByOne:create()
end

function PopShowGirl:exit()
	LayerManager:removePopLayer(self.__queueindex)
end
