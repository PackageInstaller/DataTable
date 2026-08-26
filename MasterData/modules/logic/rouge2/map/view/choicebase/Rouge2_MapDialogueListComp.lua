-- chunkname: @modules/logic/rouge2/map/view/choicebase/Rouge2_MapDialogueListComp.lua

module("modules.logic.rouge2.map.view.choicebase.Rouge2_MapDialogueListComp", package.seeall)

local Rouge2_MapDialogueListComp = class("Rouge2_MapDialogueListComp", LuaCompBase)

function Rouge2_MapDialogueListComp.Get(go, viewName)
	return (MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_MapDialogueListComp, viewName))
end

function Rouge2_MapDialogueListComp:ctor(viewName)
	self._viewName = viewName
end

function Rouge2_MapDialogueListComp:init(go)
	self.go = go
	self._scrollDialogue = gohelper.findChildScrollRect(self.go, "#scroll_Dialogue")
	self._goTalkContent = gohelper.findChild(self.go, "#scroll_Dialogue/Viewport/Content")
	self._goTalkItem = gohelper.findChild(self.go, "#scroll_Dialogue/Viewport/Content/#go_TalkItem")
	self._goDescArrow = gohelper.findChild(self.go, "#go_DescArrow")

	gohelper.setActive(self._goTalkItem, false)
	gohelper.setActive(self._goDescArrow, false)

	self._tranDialgoue = self._scrollDialogue.transform
	self._doneInfoList = {}
	self._freeItemList = self:getUserDataTb_()
	self._useItemList = self:getUserDataTb_()
	self._dialogueNum = 0
	self._viewName2FlowCls = {}
	self._viewName2FlowCls[ViewName.Rouge2_MapChoiceView] = Rouge2_MapStoryDialogueFlow
	self._viewName2FlowCls[ViewName.Rouge2_MapPieceChoiceView] = Rouge2_MapStoryDialogueFlow
	self._viewName2FlowCls[ViewName.Rouge2_MapExploreChoiceView] = Rouge2_MapDialogueBaseFlow
	self._buildFlowCls = self._viewName2FlowCls[self._viewName]

	if not self._buildFlowCls then
		logError(string.format("肉鸽对话流构建方法不存在 viewName = %s", self._viewName))
	end
end

function Rouge2_MapDialogueListComp:addEventListeners()
	self._scrollDialogue:AddOnValueChanged(self.onScrollValueChange, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onUpdateChoiceDialogue, self.onUpdateChoiceDialogue, self)
end

function Rouge2_MapDialogueListComp:removeEventListeners()
	self._scrollDialogue:RemoveOnValueChanged()
end

function Rouge2_MapDialogueListComp:onUpdateChoiceDialogue()
	self._scrollDialogue.verticalNormalizedPosition = Rouge2_MapEnum.ScrollPosition.Bottom
end

function Rouge2_MapDialogueListComp:onScrollValueChange(x, y)
	self:refresArrow()
end

function Rouge2_MapDialogueListComp:showArrow(isShow)
	self._showArrow = isShow

	self:_rebuildLayout()
	self:refresArrow()
end

function Rouge2_MapDialogueListComp:refresArrow()
	if not self._showArrow then
		local isResultShow = self._scrollDialogue.verticalNormalizedPosition > 0.001

		gohelper.setActive(self._goDescArrow, isResultShow)
	end
end

function Rouge2_MapDialogueListComp:play()
	if not self._flow then
		return
	end

	self:showArrow(false)
	self._flow:start(self)
end

function Rouge2_MapDialogueListComp:clear()
	for i = #self._useItemList, 1, -1 do
		local useItem = table.remove(self._useItemList, i)

		useItem:hide()
		table.insert(self._freeItemList, useItem)
	end

	self._dialogueNum = 0

	self:_initFlow()
end

function Rouge2_MapDialogueListComp:addDoneDialougeList(dialogueList, doneCallback, doneCallbackObj)
	self:_addDialogueFlow(dialogueList, Rouge2_MapEnum.DialoguePlayType.Directly, doneCallback, doneCallbackObj)
end

function Rouge2_MapDialogueListComp:addTweenDialogueList(dialogueList, doneCallback, doneCallbackObj)
	self:_addDialogueFlow(dialogueList, Rouge2_MapEnum.DialoguePlayType.Tween, doneCallback, doneCallbackObj)
end

function Rouge2_MapDialogueListComp:_addDialogueFlow(dialogueList, playType, doneCallback, doneCallbackObj)
	local flow = FlowSequence.New()

	if dialogueList then
		if not #dialogueList then
			local dialogueNum = 0

			if dialogueNum > 0 and self._buildFlowCls ~= nil then
				local work = self._buildFlowCls.New(dialogueList, playType)

				flow:addWork(work)
			end

			if doneCallback and doneCallbackObj then
				flow:addWork(FunctionWork.New(doneCallback, doneCallbackObj))
			end

			self._flow:addWork(flow)

			self._dialogueNum = self._dialogueNum + dialogueNum
		end
	end
end

function Rouge2_MapDialogueListComp:_onDialogueDone()
	self:_rebuildLayout()
	Rouge2_MapModel.instance:setPlayingDialogue(false)
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onDialogueFlowDone)
end

function Rouge2_MapDialogueListComp:_getOrCreateDialogueItem()
	if self._freeItemList then
		if not #self._freeItemList then
			local freeItemNum = 0

			if freeItemNum <= 0 then
				if self._useItemList then
					if not #self._useItemList then
						do
							local index = 0

							index = index + 1

							local goDialogueItem = gohelper.cloneInPlace(self._goTalkItem, index)
							local dialogueItem = MonoHelper.addNoUpdateLuaComOnceToGo(goDialogueItem, Rouge2_MapDialogueItem)

							table.insert(self._freeItemList, dialogueItem)
						end

						local dialougeItem = table.remove(self._freeItemList, 1)

						table.insert(self._useItemList, dialougeItem)

						return dialougeItem
					end
				end
			end
		end
	end
end

function Rouge2_MapDialogueListComp:_initFlow()
	self:_destroyFlow()
	self:_rebuildLayout()
	Rouge2_MapModel.instance:setPlayingDialogue(true)

	self._flow = FlowSequence.New()

	self._flow:registerDoneListener(self._onDialogueDone, self)
end

function Rouge2_MapDialogueListComp:_rebuildLayout()
	ZProj.UGUIHelper.RebuildLayout(self._tranDialgoue)

	self._scrollDialogue.verticalNormalizedPosition = Rouge2_MapEnum.ScrollPosition.Bottom

	self:refresArrow()
end

function Rouge2_MapDialogueListComp:getDialogueNum()
	return self._dialogueNum
end

function Rouge2_MapDialogueListComp:hasAnyDialogue()
	return self._dialogueNum and self._dialogueNum > 0
end

function Rouge2_MapDialogueListComp:_destroyFlow()
	if self._flow then
		self._flow:destroy()

		self._flow = nil
	end
end

function Rouge2_MapDialogueListComp:onDestroy()
	self:_destroyFlow()
end

return Rouge2_MapDialogueListComp
