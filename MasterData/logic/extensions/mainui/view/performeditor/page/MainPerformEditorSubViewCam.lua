-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/performeditor/page/MainPerformEditorSubViewCam.lua

module("logic.extensions.mainui.view.performeditor.page.MainPerformEditorSubViewCam", package.seeall)

local M = class("MainPerformEditorSubViewCam")

M.PageType = {
	CamID = 1,
	CharacterSys = 2
}

function M:ctor(mainGo)
	self.mainGO = mainGo
end

function M:init(viewRegistry)
	self._viewRegistry = viewRegistry

	self:buildUI()
	self:bindEvents()

	self._isInit = true
end

function M:Awake()
	return
end

function M:OnEnable()
	if not self._isInit then
		return
	end
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:getMainGo()
	return self.mainGO
end

function M:getRegistry()
	return self._viewRegistry
end

function M:buildUI()
	local registry = self:getRegistry()

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self)
	self._toggleTabControl:setTabCheckFunc(function(index)
		return self:_subTabCheckFunc(index)
	end)

	local tabRoot = registry:findUIElement("main_perform_editor_view_1634516501", UIComponentType.RectTransform)

	for i = 0, tabRoot.childCount - 1 do
		self._toggleTabControl:addToggleTab(tabRoot:GetChild(i):GetComponent(UIComponentType.SpaceXToggle))
	end

	self._panelGoLst = {
		[M.PageType.CamID] = {
			go = registry:findUIElement("main_perform_editor_view_2012621546"),
			view = Astral.SimpleLuaComponentContainer.Add(registry:findUIElement("main_perform_editor_view_2012621546"), MainPerformEditorCamCodeComp)
		},
		[M.PageType.CharacterSys] = {
			go = registry:findUIElement("main_perform_editor_view_1937658088"),
			view = Astral.SimpleLuaComponentContainer.Add(registry:findUIElement("main_perform_editor_view_1937658088"), MainPerformEditorCamCharacterSysComp)
		}
	}
end

function M:getView(pageType)
	local comp = self._panelGoLst[pageType]

	if comp then
		return comp.view
	end

	return nil
end

function M:destroyUI()
	for _, comp in pairs(self._panelGoLst) do
		comp.view:onExit()
	end

	self:setHandler(nil)

	self.mainGO = nil
	self._viewRegistry = nil

	self._toggleTabControl:destroy()

	self._toggleTabControl = nil
	self._panelGoLst = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getHandler()
	return self._handler
end

function M:onEnter()
	self:setEvent(true)
	self._toggleTabControl:selectTab(1)
end

function M:onExit()
	self:setEvent(false)

	for _, comp in pairs(self._panelGoLst) do
		comp.view:onExit()
	end

	self._activeIndex = nil
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

function M:getActiveSubPageDirty()
	return false
end

function M:_subTabCheckFunc(index)
	local activeIndex = self:getActiveIndex()

	if activeIndex and activeIndex == index then
		return true
	end

	local view = self:getView(activeIndex)

	if view and view.IsDataDirty then
		local isDataDirty = view:IsDataDirty()

		if isDataDirty then
			return false
		end
	end

	return true
end

function M:getActiveIndex()
	return self._activeIndex
end

function M:setPage(index, ...)
	local activeIndex = self:getActiveIndex()

	if activeIndex and activeIndex == index then
		return
	end

	local lastViewIndex = self._activeIndex

	self._activeIndex = index

	for _type, comp in pairs(self._panelGoLst) do
		goutil.setActive(comp.go, _type == self:getActiveIndex())
	end

	if lastViewIndex then
		local view = self:getView(lastViewIndex)

		view:onExit()
	end

	self:getView(self._activeIndex):onEnter()
end

return M
