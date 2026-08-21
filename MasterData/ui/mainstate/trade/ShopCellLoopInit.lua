-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\ShopCellLoopInit.lua

local SkinShopCellMixin = require("UI/MainState/Trade/SkinShopCellMixin")
local ShopCellMixin = require("UI/MainState/Trade/ShopCellMixin")
local RearHouseShopCellMixin = require("UI/RearHouse/RearHouseShopCellMixin")
local ShopCellLoop = Class("ShopCellLoop", UIControls.ScrollViewLoopCell)

MixinClass(ShopCellLoop, ShopCellMixin, true)

function ShopCellLoop:ctor()
	self:ctorMixin(true, true)

	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onCellClick)
end

function ShopCellLoop:onCellClick(sender)
	if self.mEventClick ~= nil then
		self.mEventClick(self.item)
	end
end

UIConst.ShopCellLoop = ShopCellLoop

local SkinShopCellLoop = Class("SkinShopCellLoop", UIControls.ScrollViewLoopCell)

MixinClass(SkinShopCellLoop, SkinShopCellMixin, true)

function SkinShopCellLoop:ctor()
	self:ctorMixin(true)

	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onCellClick)
end

function SkinShopCellLoop:onCellClick(sender)
	if self.mEventClick ~= nil then
		self.mEventClick(self.item)
	end
end

UIConst.SkinShopCellLoop = SkinShopCellLoop

local RearHouseShopCellLoop = Class("RearHouseShopCellLoop", UIControls.ScrollViewLoopCell)

MixinClass(RearHouseShopCellLoop, RearHouseShopCellMixin, true)

function RearHouseShopCellLoop:ctor()
	self:ctorMixin(true, true)

	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onCellClick)
end

function RearHouseShopCellLoop:onCellClick(sender)
	if self.mEventClick ~= nil then
		self.mEventClick(self.item)
	end
end

local ActivityShopCellLoop = Class("ActivityShopCellLoop", UIControls.ScrollViewLoopCell)

MixinClass(ActivityShopCellLoop, ShopCellMixin, true)

function ActivityShopCellLoop:ctor()
	self:ctorMixin(true, true)

	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onCellClick)

	self.iconNewGet = UIControls.Panel(self, "IconNewOpen")
end

function ActivityShopCellLoop:onCellClick(sender)
	if self.mEventClick ~= nil then
		self.mEventClick(self.item)
	end
end

function ActivityShopCellLoop:_setData()
	if not self.item:isSoldOut() and not self.item:isLocked() then
		local qualityPath = UIConst.COMMON_QUALITY_CONFIG[self.item.object.quality]

		if qualityPath then
			self.imgQuality:setImage(qualityPath[1], qualityPath[2])
		end
	else
		self.imgQuality:setImage("Atlas/CommonAtlas/GridAtlas/GridAtlas", "BgIconGreyDis")
	end
end

UIConst.ActivityShopCellLoop = ActivityShopCellLoop

local ActivityShopCellChild = Class("ActivityShopCellChild", UIControls.Child)

MixinClass(ActivityShopCellChild, ShopCellMixin, true)

function ActivityShopCellChild:ctor()
	self:ctorMixin(false)

	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onCellClick)
end

function ActivityShopCellChild:onCellClick(sender)
	if self.mEventClick ~= nil then
		self.mEventClick(self.item)
	end
end

function ActivityShopCellChild:_setData()
	if not self.item:isSoldOut() and not self.item:isLocked() then
		local qualityPath = UIConst.COMMON_QUALITY_CONFIG[self.item.object.quality]

		if qualityPath then
			self.imgQuality:setImage(qualityPath[1], qualityPath[2])
		end
	else
		self.imgQuality:setImage("Atlas/CommonAtlas/GridAtlas/GridAtlas", "BgIconGreyDis")
	end
end

UIConst.ActivityShopCellChild = ActivityShopCellChild
UIConst.RearHouseShopCellLoop = RearHouseShopCellLoop
