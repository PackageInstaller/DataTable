-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/widgets/RogueMapPointItem.lua

module("logic.extensions.roguelike.view.widgets.RogueMapPointItem", package.seeall)

local M = class("RogueMapPointItem")

function M:ctor(go)
	self._go = go.gameObject
end

function M:Awake()
	self:onInit()
end

function M:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function M:onInit()
	local go = self._go

	self._goLineX = goutil.findChild(go, "x_line")
	self._goLineY = goutil.findChild(go, "y_line")
	self._goNone = goutil.findChild(go, "point/type1")
	self._goType = goutil.findChild(go, "point/type2")
	self._goDi1 = goutil.findChild(go, "point/type2/di1")
	self._goDi2 = goutil.findChild(go, "point/type2/di2")
	self._iconType = goutil.findChild(go, "point/type2/icon")
end

function M:updateData(data)
	local isFinish = data.isFinish

	if not isFinish then
		IconLoader.setSprite(self._iconType, IconType.RunGroup, string.format("rungroup_point/%s", data.icon))
	end

	goutil.setActive(self._goNone, isFinish)
	goutil.setActive(self._goType, not isFinish)
	goutil.setActive(self._goDi1, data.mo:getIsQuestion())
	goutil.setActive(self._goDi2, not data.mo:getIsQuestion())
	self:setActive(false)
end

function M:OnDestroy()
	return
end

return M
