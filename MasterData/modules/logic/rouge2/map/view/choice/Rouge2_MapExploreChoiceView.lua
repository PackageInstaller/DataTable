-- chunkname: @modules/logic/rouge2/map/view/choice/Rouge2_MapExploreChoiceView.lua

module("modules.logic.rouge2.map.view.choice.Rouge2_MapExploreChoiceView", package.seeall)

local Rouge2_MapExploreChoiceView = class("Rouge2_MapExploreChoiceView", Rouge2_MapChoiceView)

function Rouge2_MapExploreChoiceView:onInitView()
	Rouge2_MapExploreChoiceView.super.onInitView(self)

	self._godialogueblock = gohelper.findChild(self.viewGO, "Right/#go_dialogueblock")
end

function Rouge2_MapExploreChoiceView:initChoiceTemplate()
	self._gochoicecontainer = gohelper.findChild(self.viewGO, "Right/#go_choicecontainer")
	self.goChoiceItem = self.viewContainer:getResInst(Rouge2_Enum.ResPath.MapExploreChoiceItem, self._gochoicecontainer)

	gohelper.setActive(self.goChoiceItem, false)
end

function Rouge2_MapExploreChoiceView:updateItem(item, index, choiceId)
	item:update(choiceId, self.nodeMo, index)
end

function Rouge2_MapExploreChoiceView:refreshChoice()
	gohelper.setActive(self.goRight, true)
	gohelper.setActive(self.goLeft, true)

	local choiceIdList = self.nodeMo.eventMo:getChoiceIdList()

	if not choiceIdList then
		logError("choiceIdList is nil, curNode : " .. tostring(self.nodeMo))

		return
	end

	Rouge2_MapHelper.loadItemWithCustomUpdateFunc(self.goChoiceItem, Rouge2_MapExploreChoiceItem, choiceIdList, self.choiceItemList, self.updateItem, self)
end

function Rouge2_MapExploreChoiceView:changeState(state)
	Rouge2_MapExploreChoiceView.super.changeState(self, state)

	if state == Rouge2_MapEnum.ChoiceViewState.Finish then
		gohelper.setActive(self._godialogueblock, true)
	end
end

return Rouge2_MapExploreChoiceView
