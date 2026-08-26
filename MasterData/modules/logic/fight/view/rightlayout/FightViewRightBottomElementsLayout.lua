-- chunkname: @modules/logic/fight/view/rightlayout/FightViewRightBottomElementsLayout.lua

module("modules.logic.fight.view.rightlayout.FightViewRightBottomElementsLayout", package.seeall)

local FightViewRightBottomElementsLayout = class("FightViewRightBottomElementsLayout", BaseView)

function FightViewRightBottomElementsLayout:onInitView()
	self.goRightBottomRoot = gohelper.findChild(self.viewGO, "root/right_elements/bottom")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightViewRightBottomElementsLayout:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.RightBottomElements_ShowElement, self.showElement, self)
	self.addEventCb(self, FightController.instance, FightEvent.RightBottomElements_HideElement, self.hideElement, self)
end

function FightViewRightBottomElementsLayout:removeEvents()
	return
end

function FightViewRightBottomElementsLayout:_editableInitView()
	self.showElementDict = {}
	self.elementGoDict = self:getUserDataTb_()

	for _, element in pairs(FightRightBottomElementEnum.Elements) do
		local goElement = gohelper.findChild(self.goRightBottomRoot, FightRightBottomElementEnum.ElementsNodeName[element])

		self.elementGoDict[element] = goElement

		gohelper.setAsLastSibling(goElement)
		gohelper.setActive(goElement, false)

		local rectTr = goElement:GetComponent(gohelper.Type_RectTransform)
		local size = FightRightBottomElementEnum.ElementsSizeDict[element]

		recthelper.setSize(rectTr, size.x, size.y)
	end
end

function FightViewRightBottomElementsLayout:getElementContainer(element)
	return self.elementGoDict[element]
end

function FightViewRightBottomElementsLayout:showElement(element)
	self.showElementDict[element] = true

	self:refreshLayout()
end

function FightViewRightBottomElementsLayout:hideElement(element)
	self.showElementDict[element] = nil

	self:refreshLayout()
end

function FightViewRightBottomElementsLayout:refreshLayout()
	for _, element in ipairs(FightRightBottomElementEnum.Priority) do
		local isShow = self.showElementDict[element]

		gohelper.setActive(self.elementGoDict[element], isShow)

		if isShow then
			gohelper.setAsFirstSibling(self.elementGoDict[element])
		end
	end
end

return FightViewRightBottomElementsLayout
