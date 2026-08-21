-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/map/RoguePropBtnItem.lua

module("logic.extensions.roguelike.view.explore.map.RoguePropBtnItem", package.seeall)

local M = class("RoguePropBtnItem")

function M:ctor(container)
	self:setEvent(true)

	local go = container.gameObject

	self._go = go
	self._onClickCallback = nil
	self._btnClick = UIComponentType.ButtonAdapter(go)

	self._btnClick:AddClickListener(self.onItemClick, self)

	self._txtPropCount = goutil.findChildTextComponent(go, "txtNum")

	self:updateData()
end

function M:setClickCallback(callback)
	self._onClickCallback = callback
end

function M:updateData()
	local allProp = RoguelikeModel.instance:getAllPropNOs()

	self._txtPropCount.text = string.format("%d", #allProp)
end

function M:onItemClick()
	if self._onClickCallback then
		self._onClickCallback()
	end
end

function M:setEvent(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(EventType.ROGUE_REFRESH_PROP, self._onPropRefresh, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_REFRESH_PROP, self._onPropRefresh, self)
	end
end

function M:_onPropRefresh()
	self:updateData()
end

function M:OnDestroy()
	self._onClickCallback = nil

	if self._btnClick then
		self._btnClick:RemoveClickListener()

		self._btnClick = nil
	end

	self:setEvent(false)
end

return M
