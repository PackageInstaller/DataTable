-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RoguePropSelectView.lua

module("logic.extensions.roguelike.view.explore.RoguePropSelectView", package.seeall)

local PropItem = class("PropItem")

function PropItem:ctor(go)
	self._go = go
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "btnAdd"))
	self._txtName = goutil.findChildTextComponent(go, "Text1")
end

function PropItem:bindEvents()
	self._btnClick:AddClickListener(self.onClick, self)
end

function PropItem:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function PropItem:onClick()
	if self._callback then
		self._callback()
	end
end

function PropItem:updateData(data)
	self._txtName.text = data.text
	self._callback = data.callback

	goutil.setActive(self._go, true)
end

local M = class("RoguePropSelectView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._propItems = {}
end

function M:buildUI()
	self._txtPropCount = self:getText("prop_attribute_use_tips_-1880191789")
	self._traPropItemParent = self:getGo("prop_attribute_use_tips_-809850337").transform
	self._goLiPai = goutil.findChild(self.mainGO, "run_group_lipai_item")
end

function M:destroyUI()
	return
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self._selectCallback = self:getFirstParam()
	self._roleProp = self:getOpenParam()[2]

	self:initPropItems()
	self:initLiPai()

	for k, v in pairs(self._propItems) do
		v:bindEvents()
	end
end

function M:initLiPai()
	local item = RogueRoleLiPaiItem.New(self._goLiPai)
	local data = {}

	data.roleId = self._roleProp and self._roleProp:getRoleId() or 0

	item:updateData(data)
end

function M:onExit()
	for k, v in pairs(self._propItems) do
		v:unbindEvents()
	end
end

function M:initPropItems()
	for i = 1, 6 do
		local item = self._propItems[i]

		if item == nil then
			local go = self._traPropItemParent:GetChild(i - 1).gameObject

			item = PropItem.New(go)
			self._propItems[i] = item
		end

		local data = {}
		local index = i
		local map = RoguelikeConst.PROP_LANG_MAP[i]
		local text = map.name .. self._roleProp:getPropertyLevel(i)

		data.text = text

		function data.callback()
			self:onPropItemClick(index)
		end

		item:updateData(data)
	end
end

function M:onPropItemClick(index)
	if self._selectCallback ~= nil then
		self._selectCallback(index - 1)
	end

	self:close()
end

return M
