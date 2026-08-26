-- chunkname: @modules/logic/sodache/view/inside/comp/SodacheDialogueItem.lua

module("modules.logic.sodache.view.inside.comp.SodacheDialogueItem", package.seeall)

local SodacheDialogueItem = class("SodacheDialogueItem", LuaCompBase)

function SodacheDialogueItem:init(go)
	gohelper.setActive(go, true)

	self.go = go

	self:initView()
end

function SodacheDialogueItem:initView()
	return
end

function SodacheDialogueItem:show(data, height)
	gohelper.setActive(self.go, true)
	gohelper.setAsLastSibling(self.go)
	self:initData(data, height)
end

function SodacheDialogueItem:hide()
	gohelper.setActive(self.go, false)
end

function SodacheDialogueItem:initData(data, height)
	self.data = data

	if height then
		recthelper.setAnchorY(self.go.transform, -height)
	end

	self:onInitData(data)
	self:calculateHeight()
end

function SodacheDialogueItem:onInitData(data)
	return
end

function SodacheDialogueItem:getHeight()
	return self.height
end

return SodacheDialogueItem
