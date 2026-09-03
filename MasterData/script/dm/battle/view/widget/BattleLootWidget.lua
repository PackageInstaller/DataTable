-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/BattleLootWidget.lua

require("dm.battle.view.BattleLoot")

local kRetract = -24.5
local kItemMap = {
	box = {
		scale = 0.4,
		res = "exp_ziyuandiaoluo",
		advance = 90,
		offset = cc.p(0, 0)
	},
	gold = {
		scale = 0.45,
		res = "jinbi_ziyuandiaoluo",
		advance = 90,
		offset = cc.p(0, 0)
	},
	crystal = {
		scale = 0.45,
		res = "yuanshi_ziyuandiaoluo",
		advance = 90,
		offset = cc.p(0, 0)
	}
}

BattleLootWidget = class("BattleLootWidget", BaseWidget)

function BattleLootWidget:initialize(view)
	super.initialize(self, view)
	self:setupView()
end

function BattleLootWidget:dispose()
	super.dispose(self)
end

function BattleLootWidget:setupView()
	local view = self:getView()

	self._boxUI = self:createLootSummaryUI(kItemMap.box, view:getChildByName("box"), view:getChildByFullName("box.text"))
	self._goldUI = self:createLootSummaryUI(kItemMap.gold, view:getChildByName("gold"), view:getChildByFullName("gold.text"))
	self._crystalUI = self:createLootSummaryUI(kItemMap.crystal, view:getChildByName("crystal"), view:getChildByFullName("crystal.text"))
	self._bg = view:getChildByFullName("bg")
	self._visibleItems = {}

	view:setVisible(false)
	self._boxUI:setVisible(false)
	self._goldUI:setVisible(false)
end

function BattleLootWidget:createLootSummaryUI(config, item, label)
	local iconAnim = cc.MovieClip:create(config.res)

	iconAnim:addTo(item)
	iconAnim:setScale(config.scale)
	iconAnim:setPosition(config.offset)
	iconAnim:gotoAndStop(1)
	label:setString("0")

	local obj = {
		_count = 0,
		_advance = config.advance,
		_icon = iconAnim,
		_label = label
	}

	function obj:setCount(count)
		if self._count == count then
			return
		end

		self._count = count

		self._label:setString(tostring(count))
	end

	function obj:getCount()
		return self._count
	end

	function obj:setVisible(visible)
		item:setVisible(visible)
	end

	function obj:isVisible()
		return item:isVisible()
	end

	function obj:setPosition(pos)
		return
	end

	function obj:getAdvance()
		return self._advance
	end

	function obj:getIconGeom()
		local icon = self._icon
		local x, y = icon:getPosition()
		local sx, sy = icon:getScaleX(), icon:getScaleY()
		local trans = icon:getParent():getNodeToWorldAffineTransform()

		return {
			x = x * trans.a + y * trans.c + trans.tx,
			y = x * trans.b + y * trans.d + trans.ty,
			sx = sx * trans.a,
			sy = sy * trans.d
		}
	end

	return obj
end

function BattleLootWidget:getLootUIOfType(type)
	if type == "gold" then
		return self._goldUI
	elseif type == "crystal" then
		return self._crystalUI
	end

	return self._boxUI
end

function BattleLootWidget:getBattleLoot(type, autoCreate)
	local key = tostring(type)

	if self._battleLoots == nil then
		self._battleLoots = {}
	end

	local lootItem = self._battleLoots[key]

	if lootItem == nil and autoCreate then
		lootItem = BattleLoot:new(type)
		self._battleLoots[key] = lootItem
	end

	return lootItem
end

function BattleLootWidget:updateUIVisible(lootUI)
	if lootUI:isVisible() then
		return
	end

	local view = self:getView()

	view:setVisible(true)
	lootUI:setVisible(true)

	self._visibleItems[#self._visibleItems + 1] = lootUI

	self:recompose()
end

function BattleLootWidget:recompose()
	local curWidth = kRetract

	for i, item in ipairs(self._visibleItems) do
		item:setPosition(cc.p(curWidth, 0))

		curWidth = curWidth + item:getAdvance()
	end
end

function BattleLootWidget:collectAllLoots(scheduler, delaySeconds)
	return
end

function BattleLootWidget:dropLoot(scheduler, groundLayer, dropPoint, item)
	local count = item.count
	local unit = item.unit
	local type = item.type
	local key = tostring(type)
	local lootItem = BattleLoot:new(type)

	local function landCallback(itemDrop)
		local lootUI = self:getLootUIOfType(type)

		self:updateUIVisible(lootUI)

		local iconGeom = lootUI:getIconGeom()

		local function collectCallback()
			lootUI:setCount(lootUI:getCount() + (unit or 1))
		end

		lootItem:beCollectedOne(scheduler, itemDrop, iconGeom, nil, collectCallback)
	end

	lootItem:splashItems(scheduler, groundLayer, dropPoint, count, unit, landCallback)
end
