-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideUIObjectBase.lua

module("logic.extensions.guide.view.GuideUIObjectBase", package.seeall)

local GuideUIObjectBase = class("GuideUIObjectBase", ViewComponent)

function GuideUIObjectBase:onEnterFinished()
	self._currGuideBranch = GuideModel.instance:getCurrGuideBranch()
	self._currGuide = self._currGuideBranch:getGuide()
end

function GuideUIObjectBase:onExitFinished()
	self:_clearGuideWidget()
	self:_onDisableVerticalLayoutGroup(true)

	self._currGuideBranch = nil
	self._currGuide = nil
end

function GuideUIObjectBase:_handleGuideWIdgrt()
	self._saveWidget = self:_getGuideWidget()

	if self._saveWidget then
		self._saveWidget:SetActive(true)

		self._saveParent = self._saveWidget.transform.parent
		self._saveSiblingIndex = self._saveWidget.transform:GetSiblingIndex()

		self._saveWidget.transform:SetParent(self.mainGO.transform)

		self._saveCanvas = self._saveWidget:GetComponent("Canvas")

		if self._saveCanvas then
			self._saveCanvasOrder = self._saveCanvas.sortingOrder
			self._saveCanvas.sortingOrder = 5000
		end

		self._saveButton = self._saveWidget:GetComponent("Framework.ButtonAdapter")

		if self._saveButton then
			self._saveTarget = self._saveButton:GetLuaTarget()
			self._saveCallback = self._saveButton:GetLuaHandle()

			self._saveButton:RemoveClickListener()
			self._saveButton:AddClickListener(self._onClickButton, self)

			return
		end

		if self._saveWidget:GetComponent("PointerClickHandler") then
			self._clickHandler = PointerClickHandler.Get(self._saveWidget):AddLuaHandlerToTop(function()
				self:_onClickButton()
			end)
		end
	end
end

function GuideUIObjectBase:_handleGuideWIdgrtAll()
	self._saveWidget = self:_getGuideWidget()

	if not self._saveWidget then
		return nil
	end

	self._saveWidget:SetActive(true)

	self._saveParent = self._saveWidget.transform.parent
	self._saveSiblingIndex = self._saveWidget.transform:GetSiblingIndex()

	self._saveWidget.transform:SetParent(self.mainGO.transform)

	if self:_checkBtn(self._saveWidget) then
		return nil
	end

	if self:_checkPointer(self._saveWidget) then
		return nil
	end

	local tableView = self._saveWidget:GetComponent("UITableviewForLua")

	tableView = tableView or self._saveWidget:GetComponent("UITableGrid")

	if tableView then
		local go = self:_getObjectInTableView(tableView)
		local trs = go.transform
		local count = trs.childCount

		for i = count, 1, -1 do
			local child = trs:GetChild(i - 1)

			if self:_checkPointer(child) then
				dump(child)

				return nil
			end

			if self:_checkBtn(child) then
				dump(child)

				return nil
			end
		end
	end
end

function GuideUIObjectBase:_checkPointer(go)
	if go:GetComponent("PointerClickHandler") then
		self._clickHandler = PointerClickHandler.Get(go):AddLuaHandlerToTop(function()
			self:_onClickButton()
		end)

		return self._clickHandler
	end

	return nil
end

function GuideUIObjectBase:_checkBtn(go)
	self._saveButton = go:GetComponent("Framework.ButtonAdapter")

	if self._saveButton then
		print(">>>>>>>>>>  找到按钮", self._saveButton.name)

		self._saveTarget = self._saveButton:GetLuaTarget()
		self._saveCallback = self._saveButton:GetLuaHandle()

		self._saveButton:RemoveClickListener()
		self._saveButton:AddClickListener(self._onClickButton, self)
	end

	return self._saveButton
end

function GuideUIObjectBase:_clearGuideWidget()
	print(">>>>>>>>>>>归还11 self._saveCallback", self._saveCallback, self._saveWidget)

	if self._saveWidget then
		self._saveWidget.transform:SetParent(self._saveParent)
		self._saveWidget.transform:SetSiblingIndex(self._saveSiblingIndex)
	end

	if self._saveButton and self._saveCallback then
		self._saveButton:GetComponent("Framework.ButtonAdapter"):AddClickListener(self._saveCallback, self._saveTarget)
		print(">>>>>>>>>>>归还22 self._saveCallback", self._saveCallback)
	end

	if self._saveWidget and self._clickHandler then
		PointerClickHandler.Get(self._saveWidget):AddRemoveLuaHandler(self._clickHandler)

		self._clickHandler = nil
	end

	if self._saveCanvas and self._saveCanvasOrder then
		self._saveCanvas.sortingOrder = self._saveCanvasOrder
	end

	if self._parentLayout then
		self._parentLayout.manual = self._parentLayoutManual
	end

	self._saveCanvas = nil
	self._saveCanvasOrder = nil
	self._saveCallback = nil
	self._saveParent = nil
	self._saveTarget = nil
	self._saveWidget = nil
	self._saveSiblingIndex = nil
	self._parentLayout = nil
	self._parentLayoutManual = nil

	if self._saveTableview and self._saveTableviewReloadFinish then
		self._saveTableview:RegisterReloadFinishCallback(self._saveTableviewReloadFinish, self._saveTableviewTarget)
	end

	self._saveTableview = nil
	self._saveTableviewTarget = nil
	self._saveTableviewReloadFinish = nil
end

function GuideUIObjectBase:_getGuideWidget()
	local guideBranch = self._currGuideBranch
	local guide = guideBranch:getGuide()

	if not guide then
		return
	end

	local presentorName = guide:getGuideView()
	local uiNode = guide:getUINode()
	local uiWidget = guide:getUIWidget()

	if not uiNode or #uiNode == 0 then
		return
	end

	if not presentorName or #presentorName == 0 then
		return
	end

	if not uiWidget or #uiWidget == 0 then
		return
	end

	if not ViewMgr.instance:isOpen(presentorName) then
		return
	end

	return self:_getWidget(presentorName, uiNode, uiWidget)
end

function GuideUIObjectBase:_getWidget(presentorName, uiNode, uiWidget)
	if not ViewMgr.instance:isOpen(presentorName) then
		return
	end

	local presentor = ViewMgr.instance._views[presentorName]

	for i = 1, #presentor._views do
		if string.find(presentor._views[i].mainGO.name, uiNode) then
			local go = GameUtil.findChildEx(presentor._views[i].mainGO, uiWidget)

			if go then
				return go
			end
		end
	end
end

function GuideUIObjectBase:_getWidgetNeedHandler(uiNode, uiWidget, idx)
	local presentorName = self._currGuide:getGuideView()
	local go = self:_getWidget(presentorName, uiNode, uiWidget)

	if go then
		go = self:_handleWidget(go, idx)

		if go then
			return go
		end
	end
end

function GuideUIObjectBase:_getWidgetIngoreHandler(uiNode, uiWidget)
	local presentorName = self._currGuide:getGuideView()

	return self:_getWidget(presentorName, uiNode, uiWidget)
end

function GuideUIObjectBase:_getWidgetCenterPosition(go)
	local rectTrans = go:GetComponent("RectTransform")

	if rectTrans then
		local pivot = rectTrans.pivot
		local sizeDelta = rectTrans.sizeDelta
		local pivotX = pivot.x - 0.5
		local pivotY = pivot.y - 0.5
		local localPosX, localPosY, localPosZ = Framework.TransformUtil.GetLocalPos(rectTrans, nil, nil, nil)

		Framework.TransformUtil.SetLocalPos(rectTrans, localPosX - sizeDelta.x * pivotX, localPosY - sizeDelta.y * pivotY, localPosZ)

		local x, y, z = Framework.TransformUtil.GetPos(rectTrans, nil, nil, nil)

		Framework.TransformUtil.SetLocalPos(rectTrans, localPosX, localPosY, localPosZ)

		return x, y, z
	end
end

function GuideUIObjectBase:_handleWidget(widget, idx)
	local tableView = widget:GetComponent("UITableviewForLua")

	if tableView then
		local go = self:_getObjectInTableView(tableView, idx)

		if go then
			return go
		else
			self._saveTableview = tableView
			self._saveTableviewTarget = self._saveTableview:GetReloadFinishTarget()
			self._saveTableviewReloadFinish = self._saveTableview:GetReloadFinishLuaHandle()

			self._saveTableview:RegisterReloadFinishCallback(self._onTableviewReloadFinish, self)
		end
	else
		self._parentLayout = UGUIToolHelper.FindUILayout(widget)

		if self._parentLayout then
			self._parentLayoutManual = self._parentLayout.manual
			self._parentLayout.manual = true
		end

		return widget
	end
end

function GuideUIObjectBase:_getObjectInTableView(tableView, idx)
	local _idx = idx or 0

	if tableView.isReady then
		tableView:MoveCellInView(_idx, false)

		local cell = tableView:GetCellAtIndex(_idx)

		if cell then
			return cell.gameObject
		end
	end
end

function GuideUIObjectBase:_onHandleTableviewObjectFinish(tableView)
	return
end

function GuideUIObjectBase:_onTableviewReloadFinish(tableView)
	if self._saveTableview == tableView then
		self._saveTableview:RegisterReloadFinishCallback(self._saveTableviewReloadFinish, self._saveTableviewTarget)

		if self._saveTableviewReloadFinish then
			self._saveTableviewReloadFinish(self._saveTableviewTarget)
		end

		self._saveTableviewReloadFinish = nil
		self._saveTableviewTarget = nil

		self:_onHandleTableviewObjectFinish(self._saveTableview)
	end
end

function GuideUIObjectBase:_onClickButton()
	local saveCallback = self._saveCallback
	local saveTarget = self._saveTarget

	GuideController.instance:finishGuide()

	if saveCallback then
		self._saveCallback(saveTarget)
	end
end

function GuideUIObjectBase:_onHighLightLayer(center, radius, silderTime)
	self._silderTime = silderTime or 1
	self._radius = radius
	self._center = center
	self._maxRadius = 1000
	self._timeCount = 0

	local guideBranch = self._currGuideBranch
	local guide = guideBranch:getGuide()

	if not guide then
		return
	end

	local presentorName = guide:getGuideView()

	if not ViewMgr.instance:isOpen(presentorName) then
		return
	end

	local material = self.mainGO:GetComponent(typeof(UnityEngine.UI.Image)).material

	if material then
		material:SetFloat("_Silder", self._maxRadius)
	end

	settimer(0, self._onSilerChange, self)
end

function GuideUIObjectBase:_onSilerChange(value)
	self._timeCount = self._timeCount + Time.deltaTime

	if self._timeCount > self._silderTime then
		removetimer(self._onSilerChange, self)

		return nil
	end

	local radius = self._maxRadius - self._timeCount / self._silderTime * (self._maxRadius - self._radius)
	local material = self.mainGO:GetComponent(typeof(UnityEngine.UI.Image)).material

	if material then
		material:SetFloat("_Silder", radius)

		if self._center then
			material:SetVector("_Center", Vector4.New(self._center.x, self._center.y, self._center.z, 0))
		end
	end
end

function GuideUIObjectBase:_onDisableVerticalLayoutGroup(visible)
	local guideBranch = self._currGuideBranch
	local guide = guideBranch:getGuide()

	if not guide then
		return
	end

	local uiNode = guide:getUINode()
	local presentorName = guide:getGuideView()
	local presentor = ViewMgr.instance._views[presentorName]

	if presentor then
		for i = 1, #presentor._views do
			if string.find(presentor._views[i].mainGO.name, uiNode) then
				local vertical = presentor._views[i].mainGO:GetComponent("VerticalLayoutGroup")

				if vertical then
					printInfo("_onDisableVerticalLayoutGroup ======================== ")

					vertical.enabled = visible
				end

				local _sizeFitter = presentor._views[i].mainGO:GetComponent("ContentSizeFitter")

				if _sizeFitter then
					_sizeFitter.enabled = visible
				end

				return
			end
		end
	end
end

return GuideUIObjectBase
