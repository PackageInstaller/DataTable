-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeFilterView.lua

module("logic.extensions.holystripe.view.HolyStripeFilterView", package.seeall)

local HolyStripeFilterView = class("HolyStripeFilterView", ViewComponent)

function HolyStripeFilterView:ctor()
	HolyStripeFilterView.super.ctor(self)
end

function HolyStripeFilterView:unbindEvents()
	HolyStripeFilterView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSuit)
	self._customInput:RemoveListener()

	for i, v in ipairs(self._btnGroup) do
		v:RemoveClickListener()
	end

	self._btnAll:RemoveClickListener()

	for i, btnAtrr in pairs(self._btnMap) do
		GameUtil.rmClickHandler(btnAtrr)
	end

	if self._statusBtnMap then
		for i, btnStatus in pairs(self._statusBtnMap) do
			GameUtil.rmClickHandler(btnStatus)
		end
	end
end

function HolyStripeFilterView:bindEvents()
	HolyStripeFilterView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSuit, self._onClickSuitBtn, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)

	for i, v in ipairs(self._btnGroup) do
		v:AddClickListener(function()
			self:_onClickPosBtn(i)
		end)
	end

	self._btnAll:AddClickListener(function()
		self:_onClickPosBtn(nil)
	end)
end

function HolyStripeFilterView:buildUI()
	HolyStripeFilterView.super.buildUI(self)

	self._content = self:getGo("content")
	self._adjustPosition = self._content:GetComponent("UIAdjustPosition")
	self._suitFilter = self:getGo("content/SuitFilter")
	self._suitTabCon = self:getGo("content/SuitFilter/tabCon")
	self._txtSuitSelect = self:getGo("content/SuitFilter/btn/text"):GetComponent("Text")
	self._btnSuit = self:getGo("content/SuitFilter/btn")
	self._posFilter = self:getGo("content/PosFilter")
	self._customInput = UICustomInput.Get(self._content)
	self._btnAll = self:getBtn("content/PosFilter/btnAll")
	self._btnPos_1 = self:getBtn("content/PosFilter/btnPos_1")
	self._btnPos_2 = self:getBtn("content/PosFilter/btnPos_2")
	self._btnPos_3 = self:getBtn("content/PosFilter/btnPos_3")
	self._btnPos_4 = self:getBtn("content/PosFilter/btnPos_4")
	self._btnPos_5 = self:getBtn("content/PosFilter/btnPos_5")
	self._uiChangeAll = goutil.findChildComponent(self.mainGO, "content/PosFilter/btnAll", "UIChangeGroup")
	self._uiChange_1 = goutil.findChildComponent(self.mainGO, "content/PosFilter/btnPos_1", "UIChangeGroup")
	self._uiChange_2 = goutil.findChildComponent(self.mainGO, "content/PosFilter/btnPos_2", "UIChangeGroup")
	self._uiChange_3 = goutil.findChildComponent(self.mainGO, "content/PosFilter/btnPos_3", "UIChangeGroup")
	self._uiChange_4 = goutil.findChildComponent(self.mainGO, "content/PosFilter/btnPos_4", "UIChangeGroup")
	self._uiChange_5 = goutil.findChildComponent(self.mainGO, "content/PosFilter/btnPos_5", "UIChangeGroup")
	self._btnGroup = {
		self._btnPos_1,
		self._btnPos_2,
		self._btnPos_3,
		self._btnPos_4,
		self._btnPos_5
	}
	self._uiChangeGroup = {
		self._uiChange_1,
		self._uiChange_2,
		self._uiChange_3,
		self._uiChange_4,
		self._uiChange_5
	}
	self._attrFilter = self:getGo("content/AttrFilter")
	self._statusFilter = self:getGo("content/StatusFilter")
end

function HolyStripeFilterView:onExit()
	HolyStripeFilterView.super.onExit(self)
	goutil.clearChildren(self._attrFilter)
	goutil.clearChildren(self._statusFilter)
end

function HolyStripeFilterView:onEnter()
	HolyStripeFilterView.super.onEnter(self)
	self.addGEvent(self, HolyStripeController.On_Select_FilterSuit, self._onSelectFilterSuit, self)

	self._params = self:getFirstParam()
	self._selectList = self._params.selectList or {}
	self._suitFilterId = nil
	self._attrFilterList = HolyStripeConfig.instance:getFilterList()

	self:_initAttrFilterUI()
	self:_initStatusFilterUI()
	self:_refreshSuitFilterSelect()
	self:_refreshPosFilterSelect()
	self:_refreshAttrFilterSelect()
	self:_refreshStatusFilterSelect()
end

function HolyStripeFilterView:_onSelectFilterSuit(filterId)
	local key = GameEnum.HolyStripeSelectType.Suit

	self._selectList[key] = filterId

	self:_refreshSuitFilterSelect()
	GlobalDispatcher:dispatch(HolyStripeController.On_Select_FilterType, self._selectList, false)
end

function HolyStripeFilterView:_refreshSuitFilterSelect()
	local key = GameEnum.HolyStripeSelectType.Suit

	if self._selectList[key] then
		local suitFilterInfo = HolyStripeConfig.instance:getSuitInfo(self._selectList[key])

		self._txtSuitSelect.text = suitFilterInfo.name
	else
		self._txtSuitSelect.text = "选中所有灵纹"
	end
end

function HolyStripeFilterView:_onClickSuitBtn()
	local key = GameEnum.HolyStripeSelectType.Suit

	self:showTabAt(self._suitTabCon, ViewName.HolyStripeSuitFilterView, self._selectList[key])
end

function HolyStripeFilterView:_refreshPosFilterSelect()
	local key = GameEnum.HolyStripeSelectType.Pos

	if self._selectList[key] then
		self._uiChangeAll:SetState(0)

		for i, v in ipairs(self._uiChangeGroup) do
			if self._selectList[key] == i then
				v:SetState(1)
			else
				v:SetState(0)
			end
		end
	else
		self._uiChangeAll:SetState(1)

		for i, v in ipairs(self._uiChangeGroup) do
			v:SetState(0)
		end
	end
end

function HolyStripeFilterView:_onClickPosBtn(index)
	local key = GameEnum.HolyStripeSelectType.Pos

	self._selectList[key] = index

	self:_refreshPosFilterSelect()
	GlobalDispatcher:dispatch(HolyStripeController.On_Select_FilterType, self._selectList, false)
end

function HolyStripeFilterView:_initAttrFilterUI()
	self._attrFilterList = HolyStripeConfig.instance:getFilterList()
	self._btnMap = {}
	self._uiChangeMap = {}

	local sourceGameObject = self:getGo("content/btnAttr")

	for i, attr in ipairs(self._attrFilterList) do
		local btnAtrr = goutil.cloneAndSetParent(sourceGameObject, self._attrFilter.transform, "btnAttr_" .. attr.value)
		local txt = goutil.findChildTextComponent(btnAtrr, "txt")

		goutil.setActive(btnAtrr, true)

		txt.text = GameEnum.HolyStripeAttrTypeName[attr.value]

		local uiChange = btnAtrr:GetComponent("UIChangeGroup")

		GameUtil.addClickHandler(btnAtrr, GameUtil.handler(self._onClickAttrBtn, self, attr.value))

		self._btnMap[attr.value] = btnAtrr
		self._uiChangeMap[attr.value] = uiChange
	end
end

function HolyStripeFilterView:_initStatusFilterUI()
	self._statusFilterList = HolyStripeConfig.instance:getStatusFilterList()
	self._statusBtnMap = {}
	self._statusUiChangeMap = {}

	local sourceGameObject = self:getGo("content/btnStatus")

	goutil.setActive(sourceGameObject, false)

	for i, statusInfo in ipairs(self._statusFilterList) do
		local btnStatus = goutil.cloneAndSetParent(sourceGameObject, self._statusFilter.transform, "btnStatus_" .. statusInfo.id)
		local txt = goutil.findChildTextComponent(btnStatus, "txt")

		goutil.setActive(btnStatus, true)

		txt.text = statusInfo.value

		local uiChange = btnStatus:GetComponent("UIChangeGroup")

		GameUtil.addClickHandler(btnStatus, GameUtil.handler(self._onClickStatusBtn, self, statusInfo.id))

		self._statusBtnMap[statusInfo.id] = btnStatus
		self._statusUiChangeMap[statusInfo.id] = uiChange
	end
end

function HolyStripeFilterView:_onClickAttrBtn(attrType)
	local key = GameEnum.HolyStripeSelectType.AttrType
	local isCancel = false

	if TableUtil.isTableEmpty(self._selectList[key]) then
		self._selectList[key] = {}
	end

	for i, v in ipairs(self._selectList[key]) do
		if v == attrType then
			isCancel = true

			break
		end
	end

	if isCancel then
		table.removebyvalue(self._selectList[key], attrType)
	else
		if #self._selectList[key] >= 5 then
			FloatWordMgr.instance:show("已达最大属性筛选上限，请移除部分筛选属性后再试。")

			return
		end

		table.insert(self._selectList[key], attrType)
	end

	GlobalDispatcher:dispatch(HolyStripeController.On_Select_FilterType, self._selectList, false)
	self:_refreshAttrFilterSelect()
end

function HolyStripeFilterView:_onClickStatusBtn(statusType)
	local key = GameEnum.HolyStripeSelectType.Status
	local isCancel = false

	if TableUtil.isTableEmpty(self._selectList[key]) then
		self._selectList[key] = {}
	end

	for i, v in ipairs(self._selectList[key]) do
		if v == statusType then
			isCancel = true

			break
		end
	end

	if isCancel then
		table.removebyvalue(self._selectList[key], statusType)
	else
		table.insert(self._selectList[key], statusType)
	end

	GlobalDispatcher:dispatch(HolyStripeController.On_Select_FilterType, self._selectList, false)
	self:_refreshStatusFilterSelect()
end

function HolyStripeFilterView:_refreshAttrFilterSelect()
	local key = GameEnum.HolyStripeSelectType.AttrType

	for i, v in pairs(self._uiChangeMap) do
		v:SetState(0)
	end

	if self._selectList[key] then
		for _, attrType in ipairs(self._selectList[key]) do
			if self._uiChangeMap[attrType] then
				self._uiChangeMap[attrType]:SetState(1)
			end
		end
	end
end

function HolyStripeFilterView:_refreshStatusFilterSelect()
	local key = GameEnum.HolyStripeSelectType.Status

	for i, v in pairs(self._statusUiChangeMap) do
		v:SetState(0)
	end

	if self._selectList[key] then
		for _, statusType in ipairs(self._selectList[key]) do
			if self._statusUiChangeMap[statusType] then
				self._statusUiChangeMap[statusType]:SetState(1)
			end
		end
	end
end

function HolyStripeFilterView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

function HolyStripeFilterView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function HolyStripeFilterView:_adjustView()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._params.itemGo)

	self.pos = pos
	self.sizeDelta = sizeDelta

	if pos then
		Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 1, 1, 1)
		self._adjustPosition:AdjustScreenPosition(self.pos, self.sizeDelta[1], self.sizeDelta[2])
	else
		Framework.TransformUtil.SetLocalPos(self._content.transform, 0, 0, 0)
	end
end

return HolyStripeFilterView
