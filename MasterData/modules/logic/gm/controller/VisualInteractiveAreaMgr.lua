-- chunkname: @modules/logic/gm/controller/VisualInteractiveAreaMgr.lua

module("modules.logic.gm.controller.VisualInteractiveAreaMgr", package.seeall)

local VisualInteractiveAreaMgr = class("VisualInteractiveAreaMgr")

VisualInteractiveAreaMgr.maskItemPath = "ui/viewres/gm/visualmaskitem.prefab"
VisualInteractiveAreaMgr.textSizeItemPath = "ui/viewres/gm/textsizeitem.prefab"
VisualInteractiveAreaMgr.LoadStatus = {
	Loaded = 3,
	LoadFail = 4,
	Loading = 2,
	None = 1
}
VisualInteractiveAreaMgr.needCheckComponentList = {
	SLFramework.UGUI.ButtonWrap,
	SLFramework.UGUI.UIClickListener,
	SLFramework.UGUI.UILongPressListener
}
VisualInteractiveAreaMgr.CloneMaskGoName = "cloneMaskItem"
VisualInteractiveAreaMgr.TextSizeGoName = "textSizeItem"
VisualInteractiveAreaMgr.MaxStackLevel = 50

local blueColor = Color.blue

blueColor.a = 0.5

local redColor = Color.red

redColor.a = 0.5

local TextColor = {
	Normal = blueColor,
	Min = redColor
}
local TextSize = 28

function VisualInteractiveAreaMgr:init()
	self:loadMaskItem()
	self:createPool()

	self.viewName2MaskGoListDict = {}
	self.viewName2TextSizeGoListDict = {}
	self.listSourceFunc = LuaListScrollView.onUpdateFinish
	self.tableViewSourceFunc = TabViewGroup._finishCallback
end

function VisualInteractiveAreaMgr:loadMaskItem()
	self.loadStatus = VisualInteractiveAreaMgr.LoadStatus.Loading
	self.loader = MultiAbLoader.New()

	self.loader:addPath(VisualInteractiveAreaMgr.maskItemPath)
	self.loader:addPath(VisualInteractiveAreaMgr.textSizeItemPath)
	self.loader:setLoadFailCallback(self.onLoadFail, self)
	self.loader:startLoad(self._onLoadCallback, self)
end

function VisualInteractiveAreaMgr:_onLoadCallback()
	local maskAssetItem = self.loader:getAssetItem(VisualInteractiveAreaMgr.maskItemPath)
	local textSizeItem = self.loader:getAssetItem(VisualInteractiveAreaMgr.textSizeItemPath)

	self.maskItemGo = gohelper.clone(maskAssetItem:GetResource(VisualInteractiveAreaMgr.maskItemPath), ViewMgr.instance:getUIRoot())
	self.textSizeItemGo = gohelper.clone(textSizeItem:GetResource(VisualInteractiveAreaMgr.maskItemPath), ViewMgr.instance:getUIRoot())

	gohelper.setActive(self.maskItemGo, false)
	gohelper.setActive(self.textSizeItemGo, false)

	self.loadStatus = VisualInteractiveAreaMgr.LoadStatus.Loaded

	if self.needDelayShowMask then
		self:showAllViewMaskGo()
	end
end

function VisualInteractiveAreaMgr:onLoadFail()
	self.maskItemGo = nil
	self.textSizeItemGo = nil
	self.loadStatus = VisualInteractiveAreaMgr.LoadStatus.LoadFail

	logError("load fail ...")
end

function VisualInteractiveAreaMgr:createPool()
	self.maskGoPool = {}
	self.textSizeGoPool = {}
	self.poolGO = gohelper.create2d(ViewMgr.instance:getUIRoot(), "maskPool")
	self.poolTr = self.poolGO.transform

	gohelper.setActive(self.poolGO, false)
end

function VisualInteractiveAreaMgr:beforeStart()
	function LuaListScrollView.onUpdateFinish(scrollView)
		self.listSourceFunc(scrollView)
		self:showMaskGoByGo(scrollView._csListScroll.gameObject, scrollView.viewName)
		self:showTextSizeByGo(scrollView._csListScroll.gameObject, scrollView.viewName)
	end

	function TabViewGroup._finishCallback(tabView, loader)
		self.tableViewSourceFunc(tabView, loader)
		self:showMaskGoByGo(tabView.viewGO, tabView.viewName)
		self:showTextSizeByGo(tabView.viewGO, tabView.viewName)
	end
end

function VisualInteractiveAreaMgr:beforeStop()
	LuaListScrollView.onUpdateFinish = self.listSourceFunc
	TabViewGroup._finishCallback = self.tableViewSourceFunc
end

function VisualInteractiveAreaMgr:tryStart()
	self.visualInteractive = GMController.instance:getVisualInteractive()
	self.textSizeActive = GMController.instance:getTextSizeActive()

	if not self.visualInteractive and not self.textSizeActive then
		self:stop()

		return
	end

	self:beforeStart()

	if self.loadStatus ~= VisualInteractiveAreaMgr.LoadStatus.Loaded then
		self.needDelayShowMask = true
	else
		self:showAllViewMaskGo()
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self.onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self.onCloseView, self)
	TaskDispatcher.runRepeat(self.tickRefresh, self, 1)
end

function VisualInteractiveAreaMgr:tickRefresh()
	self:showAllViewMaskGo()
end

function VisualInteractiveAreaMgr:stop()
	self:beforeStop()
	TaskDispatcher.cancelTask(self.tickRefresh, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self.onOpenView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self.onCloseView, self)

	local viewNameList = ViewMgr.instance:getOpenViewNameList()

	for _, viewName in ipairs(viewNameList) do
		self:recycleMaskGoByViewName(viewName)
		self:recycleTextSizeGoByViewName(viewName)
	end
end

function VisualInteractiveAreaMgr:onOpenView(viewName)
	self:showMaskGoByViewName(viewName)
	self:showTextSizeGoByViewName(viewName)
end

function VisualInteractiveAreaMgr:onCloseView(viewName)
	self:recycleMaskGoByViewName(viewName)
	self:recycleTextSizeGoByViewName(viewName)
end

function VisualInteractiveAreaMgr:showAllViewMaskGo()
	local viewNameList = ViewMgr.instance:getOpenViewNameList()

	for _, viewName in ipairs(viewNameList) do
		if not self.viewName2MaskGoListDict[viewName] then
			self:showMaskGoByViewName(viewName)
			self:showTextSizeGoByViewName(viewName)
		end
	end
end

function VisualInteractiveAreaMgr:showMaskGoByViewName(viewName)
	local viewContainer = ViewMgr.instance:getContainer(viewName)

	self:showMaskGoByGo(viewContainer.viewGO, viewName)
end

function VisualInteractiveAreaMgr:showTextSizeGoByViewName(viewName)
	local viewContainer = ViewMgr.instance:getContainer(viewName)

	self:showTextSizeByGo(viewContainer.viewGO, viewName)
end

function VisualInteractiveAreaMgr:showTextSizeByGo(go, viewName, level)
	if not self.textSizeActive then
		return
	end

	if go.name == VisualInteractiveAreaMgr.TextSizeGoName then
		return
	end

	level = level or 1

	if level > VisualInteractiveAreaMgr.MaxStackLevel then
		logError("stack overflow ...")

		return
	end

	if not go or not go.transform then
		logError("go not be null")

		return
	end

	self.viewName2TextSizeGoListDict[viewName] = self.viewName2TextSizeGoListDict[viewName] or {}
	self.currentViewNameTextGoList = self.viewName2TextSizeGoListDict[viewName]

	local transform = go.transform

	for i = 1, transform.childCount do
		self:showTextSizeByGo(transform:GetChild(i - 1).gameObject, viewName, level + 1)
	end

	local text = go:GetComponent(gohelper.Type_Text) or go:GetComponent(gohelper.Type_TextMesh)

	if text then
		self:addTextSizeItemGo(go, text.fontSize, text.font)
	end
end

function VisualInteractiveAreaMgr:showMaskGoByGo(go, viewName, isClickChild, level)
	if not self.visualInteractive then
		return
	end

	level = level or 1

	if level > VisualInteractiveAreaMgr.MaxStackLevel then
		logError("stack overflow ...")

		return
	end

	if not go or not go.transform then
		logError("go not be null")

		return
	end

	self.viewName2MaskGoListDict[viewName] = self.viewName2MaskGoListDict[viewName] or {}
	self.currentViewNameMaskList = self.viewName2MaskGoListDict[viewName]

	self:addMaskGo(go, isClickChild)

	isClickChild = isClickChild or self:checkNeedAddMask(go, isClickChild)

	local transform = go.transform

	for i = 1, transform.childCount do
		self:showMaskGoByGo(transform:GetChild(i - 1).gameObject, viewName, isClickChild, level + 1)
	end
end

function VisualInteractiveAreaMgr:addMaskGo(go, isClickChild)
	if self:checkNeedAddMask(go, isClickChild) then
		local maskGo = self:addMaskItemGo(go)

		if maskGo then
			table.insert(self.currentViewNameMaskList, maskGo)
		end
	end
end

function VisualInteractiveAreaMgr:checkNeedAddMask(go, isClickChild)
	if not self.visualInteractive then
		return false
	end

	if isClickChild then
		local graphicCom = go:GetComponent(gohelper.Type_Graphic)

		if graphicCom and graphicCom.raycastTarget then
			return true
		else
			return false
		end
	end

	for _, commClass in ipairs(VisualInteractiveAreaMgr.needCheckComponentList) do
		if go:GetComponent(typeof(commClass)) then
			return true
		end
	end

	return false
end

function VisualInteractiveAreaMgr:addMaskItemGo(parentGo)
	if gohelper.findChild(parentGo, VisualInteractiveAreaMgr.CloneMaskGoName) then
		return nil
	end

	local maskGo = table.remove(self.maskGoPool)

	maskGo = maskGo or gohelper.clone(self.maskItemGo, parentGo, VisualInteractiveAreaMgr.CloneMaskGoName)

	maskGo.transform:SetParent(parentGo.transform)

	maskGo.transform.offsetMax = Vector2.zero
	maskGo.transform.offsetMin = Vector2.zero

	transformhelper.setLocalRotation(maskGo.transform, 0, 0, 0)
	transformhelper.setLocalScale(maskGo.transform, 1, 1, 1)

	local txtSize = gohelper.findChildText(maskGo, "txt_size")

	if txtSize then
		txtSize.text = string.format("%.1f*%.1f", recthelper.getWidth(maskGo.transform), recthelper.getHeight(maskGo.transform))
	end

	gohelper.setActive(maskGo, true)

	return maskGo
end

function VisualInteractiveAreaMgr:addTextSizeItemGo(parentGo, fontSize, font)
	local textSizeGo = gohelper.findChild(parentGo, VisualInteractiveAreaMgr.TextSizeGoName)

	if not textSizeGo then
		textSizeGo = table.remove(self.textSizeGoPool) or gohelper.clone(self.textSizeItemGo, parentGo, VisualInteractiveAreaMgr.TextSizeGoName)

		table.insert(self.currentViewNameTextGoList, textSizeGo)
		textSizeGo.transform:SetParent(parentGo.transform)

		textSizeGo.transform.offsetMax = Vector2.zero
		textSizeGo.transform.offsetMin = Vector2.zero

		transformhelper.setLocalRotation(textSizeGo.transform, 0, 0, 0)
		transformhelper.setLocalScale(textSizeGo.transform, 1, 1, 1)
	end

	local txtSize = gohelper.findChildText(textSizeGo, "txt_size")

	if txtSize then
		txtSize.text = tostring(fontSize)
	end

	local image = textSizeGo:GetComponent(gohelper.Type_Image)
	local isHwzs = font and string.find(font.name, "hwzs")

	image.color = isHwzs and fontSize < TextSize and TextColor.Min or TextColor.Normal

	gohelper.setActive(textSizeGo, true)

	return textSizeGo
end

function VisualInteractiveAreaMgr:recycleMaskGoByViewName(viewName)
	local viewNameMaskGoList = self.viewName2MaskGoListDict[viewName]

	if viewNameMaskGoList then
		for _, maskGo in ipairs(viewNameMaskGoList) do
			if not gohelper.isNil(maskGo) then
				maskGo.transform:SetParent(self.poolTr)
				table.insert(self.maskGoPool, maskGo)
			end
		end

		tabletool.clear(viewNameMaskGoList)

		self.viewName2MaskGoListDict[viewName] = nil
	end
end

function VisualInteractiveAreaMgr:recycleTextSizeGoByViewName(viewName)
	local viewNameTextSizeGoList = self.viewName2TextSizeGoListDict[viewName]

	if viewNameTextSizeGoList then
		for _, textSizeGo in ipairs(viewNameTextSizeGoList) do
			if not gohelper.isNil(textSizeGo) then
				textSizeGo.transform:SetParent(self.poolTr)
				table.insert(self.textSizeGoPool, textSizeGo)
			end
		end

		tabletool.clear(viewNameTextSizeGoList)

		self.viewName2TextSizeGoListDict[viewName] = nil
	end
end

function VisualInteractiveAreaMgr:dispose()
	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	self:stop()
	tabletool.clear(self.textSizeGoPool)
	tabletool.clear(self.maskGoPool)

	self.maskGoPool = nil
	self.textSizeGoPool = nil

	gohelper.destroy(self.maskItemGo)

	self.maskItemGo = nil

	gohelper.destroy(self.textSizeItemGo)

	self.textSizeItemGo = nil

	gohelper.destroy(self.poolGO)

	self.poolGO = nil
end

return VisualInteractiveAreaMgr
