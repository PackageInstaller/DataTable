-- chunkname: @modules/logic/explore/view/ExploreInteractOptionView.lua

module("modules.logic.explore.view.ExploreInteractOptionView", package.seeall)

local ExploreInteractOptionView = class("ExploreInteractOptionView", BaseView)

function ExploreInteractOptionView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gochoicelist = gohelper.findChild(self.viewGO, "#go_choicelist")
	self._gochoiceitem = gohelper.findChild(self.viewGO, "#go_choicelist/#go_choiceitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ExploreInteractOptionView:addEvents()
	self.addClickCb(self, self._btnclose, self.closeThis, self)
end

function ExploreInteractOptionView:removeEvents()
	self:removeClickCb(self._btnclose)
end

function ExploreInteractOptionView:_editableInitView()
	gohelper.setActive(self._gochoiceitem, false)
end

function ExploreInteractOptionView:onOpen()
	local interactOptions = self.viewParam

	self.optionsBtn = self:getUserDataTb_()

	for i = 1, #interactOptions do
		local go = gohelper.cloneInPlace(self._gochoiceitem, "choiceitem")

		gohelper.setActive(go, true)

		local txt = gohelper.findChildTextMesh(go, "info")

		txt.text = interactOptions[i].optionTxt
		self.optionsBtn[i] = gohelper.findChildButtonWithAudio(go, "click")

		self.optionsBtn[i]:AddClickListener(self.optionClick, self, interactOptions[i])
	end
end

function ExploreInteractOptionView:optionClick(optionMO)
	self:closeThis()
	optionMO.optionCallBack(optionMO.optionCallObj, optionMO.unit, optionMO.isClient)
end

function ExploreInteractOptionView:onDestroyView()
	for i = 1, #self.optionsBtn do
		self.optionsBtn[i]:RemoveClickListener()
	end

	gohelper.destroyAllChildren(self._gochoicelist)
end

return ExploreInteractOptionView
