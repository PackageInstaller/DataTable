-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/component/ToolTipsBattleBuffView.lua

module("logic.extensions.tooltips.component.ToolTipsBattleBuffView", package.seeall)

local M = class("ToolTipsBattleBuffView", ViewComponent)

function M:getSelfWidth()
	local rectTrSelf = self.mainGO:GetComponent(UIComponentType.RectTransform)

	return rectTrSelf.rect.width
end

function M:getSelfHeight()
	RectTransformUtils.ForceRebuildLayoutImmediate(self._rectTrBuffScroll)

	local heightBuff = self._rectTrBuffRoot.rect.height

	return heightBuff
end

function M:buildUI()
	self._scrollBuff = goutil.findChildComponent(self.mainGO, "buffScrollLoop", UIComponentType.ScrollRect)
	self._rectTrBuffScroll = goutil.findChildComponent(self.mainGO, "buffScrollLoop", UIComponentType.RectTransform)
	self._rectTrBuffRoot = goutil.findChildComponent(self.mainGO, "buffScrollLoop/viewPort/Content", UIComponentType.RectTransform)
	self._buffItemCollection = ViewlibCollection:create(ViewlibResPath.BuffDetailItem1)
	self._enableState = GameObjectEnableState.New(self.mainGO)
end

function M:destroyUI()
	self:_setEvent(false)
	self._buffItemCollection:clear()

	self._buffItemCollection = nil
	self._scrollBuff = nil
	self._rectTrBuffScroll = nil
	self._rectTrBuffRoot = nil
end

function M:onEnter()
	self:_setEvent(true)

	local info = self:getFirstParam()

	self:_updateView(info.unit)
end

function M:onExit()
	self:_setEvent(false)
end

function M:_setEvent(add)
	if add then
		self:registerLocalNotify(EventType.TIPS_ALIGN_CHANGE_EVENT, self.handleTipsAlignChange, self)
	else
		self:unregisterLocalNotify(EventType.TIPS_ALIGN_CHANGE_EVENT, self.handleTipsAlignChange, self)
	end
end

function M:getMainGo()
	return self.mainGO
end

function M:_updateView(unit)
	local buffComp = unit.buff
	local useLoop = table.nums(buffComp:getAllBuff()) > 6

	self._buffItemCollection:clearAllInstance()

	for _, buffMO in pairs(buffComp:getAllBuff()) do
		local buffItem = self._buffItemCollection:createInstance(self._rectTrBuffRoot)

		buffItem:setBuffId(buffMO:getBuffCode())
		buffItem:setRound(buffMO:getRound())

		if buffMO:isLayerBuff() then
			local maxAttribute = BattleEnum.Attribute[buffMO:getMaxLayerProgramming()]
			local maxBuffLayer = unit.property:getAttribute(maxAttribute)

			buffItem:setLayerAndMaxLayer(buffMO:getLayer(), maxBuffLayer)
		else
			buffItem:setLayerAndMaxLayer(0, 0)
		end
	end
end

function M:getBuffCount()
	local using = self._buffItemCollection:getAllInstances()
	local count = 0

	for i, v in pairs(using) do
		count = count + 1
	end

	return count
end

function M:init(go)
	self.mainGO = go

	self:buildUI()
end

function M:updateView(unit)
	if unit then
		local buffComp = unit.buff

		if #buffComp:getAllBuff() > 0 then
			self._enableState:setEnable("count", true)
		else
			self._enableState:setEnable("count", false)
		end

		self:_updateView(unit)
	else
		self._enableState:setEnable("count", false)
	end
end

function M:setVisible(key, visible)
	self._enableState:setEnable(key, visible)
end

function M:handleTipsAlignChange(e, info)
	local alignHor = info.alignHor
	local alignVer = info.alignVer
	local maxHeight = info.maxHeight
	local forceAlign = info.forceAlign
	local isToRight = alignHor == CommEnum.TipsAlignType.Right
	local layoutGroup = self.mainGO:GetComponent(UIComponentType.LayoutGroup)

	if forceAlign then
		layoutGroup.childAlignment = forceAlign
	elseif alignVer == CommEnum.TipsAlignType.Down then
		layoutGroup.childAlignment = isToRight and UnityEngine.TextAnchor.UpperLeft or UnityEngine.TextAnchor.UpperRight
	else
		layoutGroup.childAlignment = isToRight and UnityEngine.TextAnchor.LowerLeft or UnityEngine.TextAnchor.LowerRight
	end

	self:adjustMaxHeight(maxHeight)
	RectTransformUtils.ForceRebuildLayoutImmediate(self.mainGO.transform)
end

function M:adjustMaxHeight(maxHeight)
	RectTransformUtils.ForceRebuildLayoutImmediate(self._rectTrBuffRoot)

	if maxHeight < self._rectTrBuffRoot.rect.height then
		RectTransformUtils.SetHeight(self._rectTrBuffScroll, maxHeight)

		self._scrollBuff.enabled = true
	else
		RectTransformUtils.SetHeight(self._rectTrBuffScroll, self._rectTrBuffRoot.rect.height)

		self._scrollBuff.enabled = false
	end

	self._scrollBuff.verticalNormalizedPosition = 1
end

return M
