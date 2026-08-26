-- chunkname: @modules/logic/handbook/view/HandbookSkinSuitDetailView2_3.lua

module("modules.logic.handbook.view.HandbookSkinSuitDetailView2_3", package.seeall)

local HandbookSkinSuitDetailView2_3 = class("HandbookSkinSuitDetailView2_3", HandbookSkinSuitDetailViewBase)

function HandbookSkinSuitDetailView2_3:onOpen()
	HandbookSkinSuitDetailViewBase.onOpen(self)

	self._viewMatCtrl = self.viewGO:GetComponent(typeof(ZProj.MaterialPropsCtrl))

	if not self._isSuitSwitch and self._viewMatCtrl then
		self._viewMatCtrl.vector_02 = Vector4.New(1, 1, 0.18, 0)
	end

	self._scroll.horizontalNormalizedPosition = 0
end

local locationValue = {
	0,
	0.5,
	1
}
local descNum = 3
local handlerWidth = 231
local handlerAdsorptionMax = 0.05
local handlerAdsorptionMin = 0.01

function HandbookSkinSuitDetailView2_3:onInitView()
	HandbookSkinSuitDetailView2_3.super.onInitView(self)

	self._locationItemList = self:getUserDataTb_()

	for index, value in ipairs(locationValue) do
		local btnClick = gohelper.findChildButton(self.viewGO, "#go_scroll/Btn/#btn_point0" .. tostring(index))
		local param = {}

		param.index = index
		param.value = value
		param.target = self

		btnClick:AddClickListener(self.onClickBtnLocation, param)
		table.insert(self._locationItemList, btnClick)
	end

	self._txtDescList = self:getUserDataTb_()

	for i = 1, descNum do
		local txtDesc = gohelper.findChildText(self.viewGO, "#go_scroll/Viewport/#go_storyStages/#txt_Descr" .. HandbookSkinSuitDetailView2_3.getIndexNum(i))

		table.insert(self._txtDescList, txtDesc)
	end

	require("tolua.reflection")
	tolua.loadassembly("UnityEngine.UI")

	local _scrollbarType = System.Type.GetType("UnityEngine.UI.Scrollbar, UnityEngine.UI")

	self._handleSizeProp = tolua.getproperty(_scrollbarType, "size")
	self.scrollBar = gohelper.findChildComponent(self.viewGO, "#go_scroll/Scrollbar Horizontal", _scrollbarType)
	self.scrollBarRect = gohelper.findChildComponent(self.viewGO, "#go_scroll/Scrollbar Horizontal/Sliding Area", gohelper.Type_RectTransform)
	self.scrollBarHandlerRect = gohelper.findChildComponent(self.viewGO, "#go_scroll/Scrollbar Horizontal/Sliding Area/Handle", gohelper.Type_RectTransform)
	self.lateUpdateHandle = LateUpdateBeat:CreateListener(self._onFrameLateUpdate, self)

	LateUpdateBeat:AddListener(self.lateUpdateHandle)

	self.scrollRect = gohelper.findChildScrollRect(self.viewGO, "#go_scroll")

	self.scrollRect:AddOnValueChanged(self._onScrollValueChanged, self)

	local handleGO = gohelper.findChild(self.viewGO, "#go_scroll/Scrollbar Horizontal")

	self._dragListener = SLFramework.UGUI.UIDragListener.Get(handleGO)
	self._clickListener = SLFramework.UGUI.UIClickListener.Get(handleGO)

	self._dragListener:AddDragBeginListener(self._onDragBegin, self)
	self._dragListener:AddDragEndListener(self._onDragEnd, self)
	self._clickListener:AddClickListener(self._onClick, self)

	self._isDrag = false
end

function HandbookSkinSuitDetailView2_3:_onDragBegin()
	self._isDrag = true

	logNormal("_onDragBegin")
end

function HandbookSkinSuitDetailView2_3:_onDragEnd()
	self._isDrag = false

	logNormal("_onDragEnd")
	self:snapToNearest()
end

function HandbookSkinSuitDetailView2_3:_onClick()
	if not self._isDrag then
		self:snapToNearest()
		logNormal("_onDragEnd")
	end
end

function HandbookSkinSuitDetailView2_3:snapToNearest()
	local scroll = self._scroll
	local value = scroll.horizontalNormalizedPosition

	for _, nearValue in ipairs(locationValue) do
		local offset = math.abs(value - nearValue)

		if offset <= handlerAdsorptionMin then
			logNormal("有靠近的节点 结束吸附检测")

			return
		elseif offset <= handlerAdsorptionMax then
			logNormal("吸附 value: " .. tostring(nearValue))
			self:locationScroll(nearValue)

			return
		end
	end

	logNormal("结束吸附检测")
end

function HandbookSkinSuitDetailView2_3.getIndexNum(num)
	if num == 1 then
		return ""
	end

	return tostring(num)
end

function HandbookSkinSuitDetailView2_3:_onFrameLateUpdate()
	self:SetFixedHandleSize(self.scrollBar, handlerWidth)
end

function HandbookSkinSuitDetailView2_3:_onScrollValueChanged()
	self:SetFixedHandleSize(self.scrollBar, handlerWidth)
end

function HandbookSkinSuitDetailView2_3:SetFixedHandleSize(scrollbar, handleSize)
	local totalWidth = self.scrollBarRect.rect.width
	local size = handleSize / totalWidth

	if size > 0 then
		self._handleSizeProp:Set(scrollbar, size, nil)
	end
end

function HandbookSkinSuitDetailView2_3:_refreshDesc()
	if not string.nilorempty(self._skinSuitCfg.des) then
		local descList = string.split(self._skinSuitCfg.des, "|")

		for index, desc in ipairs(descList) do
			local txtDesc = self._txtDescList[index]

			if txtDesc then
				txtDesc.text = desc
			end
		end
	end
end

function HandbookSkinSuitDetailView2_3.onClickBtnLocation(param)
	local target = param.target
	local value = param.value

	target:locationScroll(value)
end

function HandbookSkinSuitDetailView2_3:locationScroll(value)
	if self._isDrag then
		return
	end

	local scroll = self._scroll

	scroll.horizontalNormalizedPosition = value

	logNormal("scroll.horizontalNormalizedPosition " .. tostring(scroll.horizontalNormalizedPosition))
end

function HandbookSkinSuitDetailView2_3:onDestroyView()
	HandbookSkinSuitDetailView2_3.super.onDestroyView(self)

	if self._locationItemList and next(self._locationItemList) then
		for _, item in ipairs(self._locationItemList) do
			item:RemoveClickListener()
		end

		tabletool.clear(self._locationItemList)

		self._locationItemList = nil
	end

	if self._txtDescList and next(self._txtDescList) then
		tabletool.clear(self._txtDescList)

		self._txtDescList = nil
	end

	if self.lateUpdateHandle then
		LateUpdateBeat:RemoveListener(self.lateUpdateHandle)

		self.lateUpdateHandle = nil
	end

	self.scrollRect:RemoveOnValueChanged()
	self._dragListener:RemoveDragBeginListener()
	self._dragListener:RemoveDragEndListener()
	self._clickListener:RemoveClickListener()
end

return HandbookSkinSuitDetailView2_3
