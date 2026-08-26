-- chunkname: @modules/logic/fight/view/rightlayout/FightViewRightElementsLayout.lua

module("modules.logic.fight.view.rightlayout.FightViewRightElementsLayout", package.seeall)

local FightViewRightElementsLayout = class("FightViewRightElementsLayout", BaseView)

function FightViewRightElementsLayout:onInitView()
	self.goRightRoot = gohelper.findChild(self.viewGO, "root/right_elements/top")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightViewRightElementsLayout:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.RightElements_ShowElement, self.showElement, self)
	self.addEventCb(self, FightController.instance, FightEvent.RightElements_HideElement, self.hideElement, self)
	self.addEventCb(self, FightController.instance, FightEvent.RightElements_SetElementAtLast, self.setElementAtLast, self)
end

function FightViewRightElementsLayout:removeEvents()
	return
end

function FightViewRightElementsLayout:_editableInitView()
	self.showElementDict = {}
	self.preShowElementDict = {}
	self.tempElementHeightDict = {}
	self.tweenIdList = {}
	self.elementGoDict = self:getUserDataTb_()
	self.elementRectTrDict = self:getUserDataTb_()

	for _, element in pairs(FightRightElementEnum.Elements) do
		local goElement = gohelper.findChild(self.goRightRoot, FightRightElementEnum.ElementsNodeName[element])

		self.elementGoDict[element] = goElement
		self.elementRectTrDict[element] = goElement:GetComponent(gohelper.Type_RectTransform)

		gohelper.setAsLastSibling(goElement)
		gohelper.setActive(goElement, false)

		local size = FightRightElementEnum.ElementsSizeDict[element]

		recthelper.setSize(self.elementRectTrDict[element], size.x, size.y)
	end

	local rootTransform = self.goRightRoot:GetComponent(gohelper.Type_RectTransform)

	self.maxHeight = recthelper.getHeight(rootTransform)
end

function FightViewRightElementsLayout:getElementContainer(element)
	return self.elementGoDict[element]
end

function FightViewRightElementsLayout:showElement(element, height)
	self.showElementDict[element] = true
	self.tempElementHeightDict[element] = height

	self:refreshLayout()
end

function FightViewRightElementsLayout:hideElement(element)
	self.showElementDict[element] = nil
	self.tempElementHeightDict[element] = nil

	self:refreshLayout()
end

function FightViewRightElementsLayout:setElementAtLast(element)
	gohelper.setAsLastSibling(self.elementGoDict[element])
end

function FightViewRightElementsLayout:refreshLayout()
	self:clearTweenId()

	local preUsedAnchorX = 0
	local preUsedAnchorY = 0
	local curColumnMaxWidth = 0
	local columnCount = 0

	for _, element in ipairs(FightRightElementEnum.Priority) do
		local isShow = self.showElementDict[element]

		if isShow then
			gohelper.setActive(self.elementGoDict[element], true)

			local elementWidth = self:getElementWidth(element)
			local elementHeight = self:getElementHeight(element)

			if columnCount < 1 or preUsedAnchorY + elementHeight <= self.maxHeight then
				if curColumnMaxWidth < elementWidth then
					curColumnMaxWidth = elementWidth
				end
			else
				preUsedAnchorX = preUsedAnchorX + curColumnMaxWidth
				preUsedAnchorY = 0
				columnCount = 0
			end

			recthelper.setSize(self.elementRectTrDict[element], elementWidth, elementHeight)

			if self.preShowElementDict[element] then
				local tweenId = ZProj.TweenHelper.DOAnchorPos(self.elementRectTrDict[element], -preUsedAnchorX, -preUsedAnchorY, FightRightElementEnum.AnchorTweenDuration)

				table.insert(self.tweenIdList, tweenId)
			else
				recthelper.setAnchor(self.elementRectTrDict[element], -preUsedAnchorX, -preUsedAnchorY)
			end

			columnCount = columnCount + 1
			preUsedAnchorY = preUsedAnchorY + elementHeight

			gohelper.setAsLastSibling(self.elementGoDict[element])
		else
			gohelper.setActive(self.elementGoDict[element], false)
		end

		self.preShowElementDict[element] = isShow
	end
end

function FightViewRightElementsLayout:getElementHeight(element)
	if self.tempElementHeightDict[element] then
		return self.tempElementHeightDict[element]
	end

	local size = FightRightElementEnum.ElementsSizeDict[element]

	return size.y
end

function FightViewRightElementsLayout:getElementWidth(element)
	local size = FightRightElementEnum.ElementsSizeDict[element]

	return size.x
end

function FightViewRightElementsLayout:clearTweenId()
	for _, tweenId in ipairs(self.tweenIdList) do
		ZProj.TweenHelper.KillById(tweenId)
	end

	tabletool.clear(self.tweenIdList)
end

function FightViewRightElementsLayout:onDestroyView()
	self:clearTweenId()
end

return FightViewRightElementsLayout
