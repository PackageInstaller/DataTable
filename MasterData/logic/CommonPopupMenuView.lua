-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/popupmenu/view/CommonPopupMenuView.lua

module("logic.extensions.common.popupmenu.view.CommonPopupMenuView", package.seeall)

local CommonPopupMenuView = class("CommonPopupMenuView", TipsViewBase)

function CommonPopupMenuView:ctor()
	CommonPopupMenuView.super.ctor(self)

	self._cb = nil
	self._ignoreTop = false
end

function CommonPopupMenuView:buildUI()
	CommonPopupMenuView.super.buildUI(self)

	self._item = self:getGo("item_popup")

	self._item:SetActive(false)

	self._items = {}
end

function CommonPopupMenuView:destroyUI()
	CommonPopupMenuView.super.destroyUI(self)

	self._item = nil
	self._cb = nil
	self._items = {}
end

function CommonPopupMenuView:onEnter()
	CommonPopupMenuView.super.onEnter(self)

	self.mainGO.transform.position = self._viewPresentor:getOpenParam()[1]

	local names = self._viewPresentor:getOpenParam()[2]
	local isStartBottom = self._viewPresentor:getOpenParam()[5]

	self.mainGO:GetComponent("RectTransform").pivot = isStartBottom and Vector2.New(0.5, 0) or Vector2.New(0.5, 1)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mainGO:GetComponent("RectTransform"))

	for i = #names + 1, #self._items do
		self._items[i].go:SetActive(false)
	end

	for i, v in ipairs(names) do
		local item = self._items[i]

		if not item then
			item = {}
			item.go = UGUIToolHelper.AddChild(self.mainGO, self._item)
		end

		item.handler = PointerClickHandler.Get(item.go):AddLuaHandler(function()
			CommonPopupMenuFacade.instance:_ClickPopup(v.value)

			if not v.gray then
				self:close()
			end
		end)
		self._items[i] = item

		item.go:SetActive(true)

		if v.gray then
			goutil.findChild(item.go, "TxtC_Name/ImgLock"):SetActive(true)
		else
			goutil.findChild(item.go, "TxtC_Name/ImgLock"):SetActive(false)
		end

		goutil.findChild(item.go, "TxtC_Name"):GetComponent("Text").text = v.name
		item.go.gameObject.name = string.format("item_popup_%d", i)
	end

	self._ignoreTop = self._viewPresentor:getOpenParam()[3]

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mainGO:GetComponent("RectTransform"))
end

function CommonPopupMenuView:onDisableSizeFitter()
	self.mainGO:GetComponent("ContentSizeFitter").enabled = false
end

function CommonPopupMenuView:onEnterFinished()
	CommonPopupMenuView.super.onEnterFinished(self)
end

function CommonPopupMenuView:onExit()
	CommonPopupMenuView.super.onExit(self)

	for i, v in ipairs(self._items) do
		local item = self._items[i]

		if item.handler then
			PointerClickHandler.Get(item.go):RemoveLuaHandler(item.handler)

			item.handler = nil
		end
	end
end

function CommonPopupMenuView:onExitFinished()
	CommonPopupMenuView.super.onExitFinished(self)
end

function CommonPopupMenuView:close()
	CommonPopupMenuFacade.instance:_CloseView()
	CommonPopupMenuView.super.close(self)
end

function CommonPopupMenuView:_onCustomInputCallback(hover)
	CommonPopupMenuView.super._onCustomInputCallback(self, hover)

	if GuideModel.instance:isGuiding() then
		return nil
	end

	if not hover and self._ignoreTop then
		CommonPopupMenuFacade.instance:_CloseView()
		self:close()

		return
	end

	if not hover and self:_isOnTop() then
		CommonPopupMenuFacade.instance:_CloseView()
	end
end

return CommonPopupMenuView
