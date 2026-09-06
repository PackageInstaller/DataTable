-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/FormationPopupMenuView.lua

module("logic.extensions.common.popupmenu.view.FormationPopupMenuView", package.seeall)

local FormationPopupMenuView = class("FormationPopupMenuView", TipsViewBase)

function FormationPopupMenuView:ctor()
	FormationPopupMenuView.super.ctor(self)

	self._cb = nil
	self._ignoreTop = false
	self._editStates = {
		[0] = {
			btnName = "编辑阵型名",
			state = 0
		},
		{
			btnName = "完成编辑",
			state = 1
		}
	}
	self._exitIndex = 0
end

function FormationPopupMenuView:buildUI()
	FormationPopupMenuView.super.buildUI(self)

	self._item = self:getGo("popupmenu/item_popup")

	self._item:SetActive(false)

	self._btnEdit = self:getBtn("popupmenu/btnEdit")
	self._txtEdit = self:getGo("popupmenu/btnEdit/Text"):GetComponent(goutil.Type_UIText)
	self._btnBg = self:getBtn("bg")
	self._items = {}
end

function FormationPopupMenuView:destroyUI()
	FormationPopupMenuView.super.destroyUI(self)

	self._item = nil
	self._cb = nil
	self._items = {}
end

function FormationPopupMenuView:bindEvents()
	self._btnEdit:AddClickListener(self._onBtnEditClick, self)
	self._btnBg:AddClickListener(self._onBtnEditClick, self)
end

function FormationPopupMenuView:unbindEvents()
	self._btnEdit:RemoveClickListener()
	self._btnBg:RemoveClickListener()
end

function FormationPopupMenuView:onEnter()
	FormationPopupMenuView.super.onEnter(self)

	self._commonItems = {}
	self._editState = self._editStates[0]
	self._txtEdit.text = self._editState.btnName

	self:_resetExitIndex()

	self.mainGO.transform.position = self._viewPresentor:getOpenParam()[1]
	self._popupParentGo = self:getGo("popupmenu")

	local names = self._viewPresentor:getOpenParam()[2]
	local isStartBottom = self._viewPresentor:getOpenParam()[5]
	local teamId = self._viewPresentor:getOpenParam()[6]

	self._popupParentGo:GetComponent("RectTransform").pivot = isStartBottom and Vector2.New(0.5, 0) or Vector2.New(0.5, 1)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._popupParentGo:GetComponent("RectTransform"))

	for i = #names + 1, #self._items do
		self._items[i].go:SetActive(false)
	end

	for i, v in ipairs(names) do
		local item = self._items[i]

		if not item then
			item = {}
			item.go = UGUIToolHelper.AddChild(self._popupParentGo, self._item)
		end

		item.handler = PointerClickHandler.Get(item.go):AddLuaHandler(function()
			CommonPopupMenuFacade.instance:_ClickPopup(v.value)

			if not v.gray then
				self:close()
			end
		end)
		self._items[i] = item

		item.go:SetActive(true)

		self._commonItems[i] = FormationPopupMenuItem.New()

		self._commonItems[i]:init(item.go, i, v.value)

		local imgChange = item.go:GetComponent(typeof(UIImageSpriteChange))

		imgChange:ChangeStateNow(i == teamId and 1 or 0)
		self._commonItems[i]:setImgLock(v.gray)
		self._commonItems[i]:setInputName(v.name)

		local inputComp = self._commonItems[i]:getInput()
		local color = i == teamId and Color.New(1, 1, 1, 1) or Color.New(0.3058823529411765, 0.35294117647058826, 0.4, 1)

		inputComp.textComponent.color = color
		inputComp.textComponent.color = color
	end

	self._btnEdit.transform:SetAsLastSibling()

	self._ignoreTop = self._viewPresentor:getOpenParam()[3]

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._popupParentGo:GetComponent("RectTransform"))
end

function FormationPopupMenuView:onDisableSizeFitter()
	self._popupParentGo:GetComponent("ContentSizeFitter").enabled = false
end

function FormationPopupMenuView:onEnterFinished()
	FormationPopupMenuView.super.onEnterFinished(self)
end

function FormationPopupMenuView:onExit()
	FormationPopupMenuView.super.onExit(self)

	for i = 1, #self._commonItems do
		self._commonItems[i]:destroy()

		self._commonItems[i] = nil
	end

	for i, v in ipairs(self._items) do
		local item = self._items[i]

		if item.handler then
			PointerClickHandler.Get(item.go):RemoveLuaHandler(item.handler)

			item.handler = nil
		end
	end
end

function FormationPopupMenuView:onExitFinished()
	FormationPopupMenuView.super.onExitFinished(self)
end

function FormationPopupMenuView:close()
	CommonPopupMenuFacade.instance:_CloseView()
	FormationPopupMenuView.super.close(self)
end

function FormationPopupMenuView:_onCustomInputCallback(hover)
	FormationPopupMenuView.super._onCustomInputCallback(self, hover)

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

function FormationPopupMenuView:_onBtnEditClick()
	local curState = self._editState.state

	for k, v in pairs(self._commonItems) do
		v:setState(curState == 0 and 1 or 0)
	end

	if curState == 0 then
		self._editState = self._editStates[1]

		self:_setExitIndex(1)
	else
		self._editState = self._editStates[0]

		self:_setExitIndex(0)
	end

	self._txtEdit.text = self._editState.btnName
end

function FormationPopupMenuView:_resetExitIndex()
	self._exitIndex = 0

	self._btnBg.gameObject:SetActive(false)
end

function FormationPopupMenuView:_setExitIndex(setNumber)
	self._exitIndex = setNumber

	self._btnBg.gameObject:SetActive(setNumber == 1)
end

return FormationPopupMenuView
