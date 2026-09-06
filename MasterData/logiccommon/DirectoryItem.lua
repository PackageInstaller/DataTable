-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/viewlib/usualviews/DirectoryItem.lua

module("logiccommon.common.viewlib.usualviews.DirectoryItem", package.seeall)

local DirectoryItem = class("DirectoryItem")
local LuaComponentContainer = Framework.LuaComponentContainer

function DirectoryItem:ctor(go)
	self.mainGO = go
	self._root = {}
	self._leaf = {}

	self:_initCell(self._root, goutil.findChild(self.mainGO, "rootCell"))
	self:_initCell(self._leaf, goutil.findChild(self.mainGO, "leafCell"))
end

function DirectoryItem:_initCell(t, go)
	t.mainGO = go
	t.imgSelected = goutil.findChild(go, "imgSelected")
	t.txtName = goutil.findChildComponent(go, "txtName", "Text")
	t.btn = Framework.ButtonAdapter.Get(go)
	t.outline = t.txtName:GetComponent("Outline")
	t.redPoint = goutil.findChild(go, "imgRedPoint")
	t.txtColorChange = t.txtName:GetComponent("UITextColorChange")
end

function DirectoryItem:setSelected(isSelected)
	return
end

function DirectoryItem.AddOnce(go)
	local component = LuaComponentContainer.Get(go, DirectoryItem)

	component = component or LuaComponentContainer.Add(go, DirectoryItem)

	return component
end

function DirectoryItem:onSetMo(name, isSelected, root, leaf)
	local isRoot = leaf == 0

	goutil.setActive(self._root.mainGO, isRoot)
	goutil.setActive(self._leaf.mainGO, not isRoot)

	if isRoot then
		if not self._root then
			local t = self._leaf

			goutil.setActive(t.imgSelected, isSelected)

			t.txtName.text = name

			t.btn:RemoveClickListener()
			t.btn:AddClickListener(function()
				GlobalDispatcher:dispatch(GlobalNotify.ClickDirectoryItem, root, leaf)
			end)
			t.txtColorChange:SetState(isSelected and 0 or 1)
			goutil.setActive(t.redPoint, AchievementModel.instance:getIsRed(root - 1, leaf))
		end
	end
end

return DirectoryItem
