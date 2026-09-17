BackGroundLayer = class("BackGroundLayer", function()
	return cc.Layer:create()
end)

local BackGroundSpine = require("view.Sprite.BackGroundSpine")
local BackGroundImage = require("view.Sprite.BackGroundImage")

require("view.Layer.BGL2dLayer")

local background_data = require("data.background_data")
local item_data = require("data.item_data")

local function var_0_4(arg_2_0)
	local var_2_0, var_2_1 = arg_2_0:match("([^,]+),(.+)")

	return cc.p(checknumber(var_2_0), checknumber(var_2_1))
end

local var_0_5 = 320
local var_0_6 = 568
local var_0_7 = 0.5
local var_0_8 = 0.5
local var_0_9 = 1

function BackGroundLayer.create(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = BackGroundLayer.new()

	var_3_0:init(arg_3_1, arg_3_2)

	return var_3_0
end

local function var_0_11(arg_4_0)
	if not arg_4_0 then
		return false
	end

	return background_data[arg_4_0].origin ~= nil
end

function BackGroundLayer:init(arg_5_1, arg_5_2, arg_5_3)
	self.showtype = arg_5_2 or var_0_9
	self._isnotlive2 = arg_5_3

	if self.showtype == var_0_9 or var_0_11(arg_5_1) then
		self.backGroundid = arg_5_1

		if background_data[self.backGroundid].background_spine then
			self:initSpine()
		end

		if background_data[self.backGroundid].background_live2d and self._isnotlive2 ~= true then
			self:initLive2D()
		end

		if background_data[self.backGroundid].background_image then
			self:initImage()
		end

		self:setOffset()
	else
		self.backGroundid = 6300007

		self:initImage()
		self:setOffset()
	end
end

function BackGroundLayer.initLive2D(arg_6_0)
	return
end

function BackGroundLayer:update(arg_7_1, arg_7_2)
	self.showtype = arg_7_2

	if self.showtype == var_0_9 or var_0_11(arg_7_1) then
		if self.backGroundid == arg_7_1 then
			return
		end

		self.backGroundid = arg_7_1

		if background_data[self.backGroundid].background_spine then
			self:updateSpine()
			self:deleteImage()
			self:deleteLive2d()
		end

		if background_data[self.backGroundid].background_image then
			self:updateImage()
			self:deleteSpine()
			self:deleteLive2d()
		end

		self:setOffset()
	else
		if self.backGroundid == 6300007 then
			return
		end

		self:deleteSpine()
		self:deleteLive2d()

		self.backGroundid = 6300007

		self:updateImage()
	end
end

function BackGroundLayer:updateImage()
	if not self.BackGroundImage then
		self:initImage()
	else
		self.BackGroundImage:reset(self.backGroundid)
	end
end

function BackGroundLayer:updateSpine()
	if not self.BackGroundSpine then
		self:initSpine()
	else
		self.BackGroundSpine:reset(self.backGroundid)
	end
end

function BackGroundLayer.updateBGLive2d(arg_10_0)
	return
end

function BackGroundLayer:initImage()
	self.BackGroundImage = BackGroundImage:create(self.backGroundid)

	self.BackGroundImage:setName("BackGroundImage")
	self.BackGroundImage:setAnchorPoint(cc.p(var_0_7, var_0_8))
	self:addChild(self.BackGroundImage)
end

function BackGroundLayer:initSpine()
	self.BackGroundSpine = BackGroundSpine:create(self.backGroundid, true)

	self.BackGroundSpine:setName("BackGroundSpine")
	self.BackGroundSpine:setAnchorPoint(cc.p(var_0_7, var_0_8))
	self:addChild(self.BackGroundSpine)
end

function BackGroundLayer:delete()
	self.backGroundid = nil

	self:deleteImage()
	self:deleteSpine()
	self:deleteLive2d()
end

function BackGroundLayer:deleteImage()
	if not self.BackGroundImage then
		return
	end

	self:removeChild(self.BackGroundImage)

	self.BackGroundImage = nil
end

function BackGroundLayer:deleteSpine()
	if not self.BackGroundSpine then
		return
	end

	self:removeChild(self.BackGroundSpine)

	self.BackGroundSpine = nil
end

function BackGroundLayer:deleteLive2d()
	if not self.live2d then
		return
	end

	self.live2d:runAction(cc.RemoveSelf:create())

	self.live2d = nil
end

function BackGroundLayer:setOffset()
	if self.BackGroundImage then
		local var_17_0 = background_data[self.backGroundid].mainmidpos and var_0_4(background_data[self.backGroundid].mainmidpos) or cc.p(var_0_5, var_0_6)
		local var_17_1 = background_data[self.backGroundid].mainmidoffset and var_0_4(background_data[self.backGroundid].mainmidoffset) or cc.p(0, 0)

		self.BackGroundImage:setPosition(cc.p(var_17_0.x + var_17_1.x, var_17_0.y + var_17_1.y))
	elseif self.BackGroundSpine then
		local var_17_2 = background_data[self.backGroundid].spinemainmidpos and var_0_4(background_data[self.backGroundid].spinemainmidpos) or cc.p(var_0_5, var_0_6)
		local var_17_3 = background_data[self.backGroundid].spinemainmidoffset and var_0_4(background_data[self.backGroundid].spinemainmidoffset) or cc.p(0, 0)

		self.BackGroundSpine:setPosition(cc.p(var_17_2.x + var_17_3.x, var_17_2.y + var_17_3.y))
	end
end

return BackGroundLayer
