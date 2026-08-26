-- chunkname: @modules/logic/story/view/StoryBranchView.lua

module("modules.logic.story.view.StoryBranchView", package.seeall)

local StoryBranchView = class("StoryBranchView", BaseView)

function StoryBranchView:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._golist = gohelper.findChild(self.viewGO, "#go_normal/Viewport/#go_list")
	self._gonormalitem = gohelper.findChild(self.viewGO, "#go_normal/Viewport/#go_list/#go_normalitem")
	self._gosp = gohelper.findChild(self.viewGO, "#go_sp")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoryBranchView:addEvents()
	return
end

function StoryBranchView:removeEvents()
	return
end

function StoryBranchView:_editableInitView()
	StoryModel.instance:enableClick(false)

	self._items = self:getUserDataTb_()
	self._itemCount = 0
	self._finishedSelectViewCount = 0

	gohelper.setActive(self._gonormalitem, false)
	self:_addSelfEvents()
end

function StoryBranchView:_addSelfEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.ReOpenWhileOpen, self._onReOpenView, self)
	self.addEventCb(self, StoryController.instance, StoryEvent.OnOptionSelected, self._onSelectOption, self)
	self.addEventCb(self, StoryController.instance, StoryEvent.OnOptionSelectFinish, self._onFinishSelectOption, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyStoryDialogSelect, self._onStoryDialogSelect, self)
end

function StoryBranchView:_removeSelfEvents()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.ReOpenWhileOpen, self._onReOpenView, self)
	self.removeEventCb(self, StoryController.instance, StoryEvent.OnOptionSelected, self._onSelectOption, self)
	self.removeEventCb(self, StoryController.instance, StoryEvent.OnOptionSelectFinish, self._onFinishSelectOption, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyStoryDialogSelect, self._onStoryDialogSelect, self)
end

function StoryBranchView:_onReOpenView(viewName, viewParam)
	if viewName ~= self.viewName then
		return
	end

	self.viewParam = viewParam

	self:_refresh()
end

function StoryBranchView:_onSelectOption(param)
	TaskDispatcher.cancelTask(self._autoSelectSpItem, self)

	local log = {}

	log.stepId = param.stepId
	log.index = param.index

	StoryModel.instance:addLog(log)
end

function StoryBranchView:_onFinishSelectOption(param)
	if param then
		if param.optionCo.type == StoryEnum.OptionType.ContinueAsk then
			local stepId = tonumber(param.optionCo.feedbackValue)

			if stepId then
				StoryController.instance:playStep(stepId)
				StoryController.instance:playStepChoose(stepId)
			else
				logError("please set option stepId")
			end
		elseif param.optionCo.type == StoryEnum.OptionType.EndAsk then
			local stepId = tonumber(param.optionCo.feedbackValue)

			if stepId then
				StoryController.instance:playStep(stepId)
				self:closeThis()
			else
				logError("please set option stepId")
			end
		else
			StoryController.instance:playStep(param.id)
			self:closeThis()
		end
	else
		self:closeThis()
	end
end

function StoryBranchView:_onStoryDialogSelect(index)
	if self._keyTrigger and self._keyTrigger[index] then
		self:onKeySelect(self._keyTrigger[index])
	end
end

function StoryBranchView:onKeySelect(index)
	if self._items then
		for i, v in ipairs(self._items) do
			if i == index then
				v:_btnselectOnClick()
			end
		end
	end
end

local spOptionAutoSelectTime = 5

function StoryBranchView:onOpen()
	local autoSelectTime = spOptionAutoSelectTime
	local hasSp = false

	for i, v in ipairs(self.viewParam) do
		if v.optionCo then
			local isSpType = StoryModel.instance:isSpOptionType(v.optionCo.type)

			if isSpType then
				hasSp = true

				local params = string.split(v.name, "|")

				if params[2] then
					local trans = string.splitToNumber(params[2], "#")
					local autoTime = trans[4] and tonumber(trans[4]) or spOptionAutoSelectTime

					autoSelectTime = autoSelectTime == spOptionAutoSelectTime and autoTime or autoSelectTime
					autoSelectTime = autoSelectTime < autoTime and autoSelectTime or autoTime
				end
			end
		end
	end

	if hasSp then
		TaskDispatcher.runDelay(self._autoSelectSpItem, self, autoSelectTime)
	end

	self._spItems = {}

	self:_refresh()
end

function StoryBranchView:onOpenFinish()
	PostProcessingMgr.instance:setIgnoreUIBlur(true)
end

function StoryBranchView:_autoSelectSpItem()
	if not self._spItems or #self._spItems <= 0 then
		return
	end

	local index = math.random(1, #self._spItems)

	self._spItems[index]:setAutoClick()
end

function StoryBranchView:_refresh()
	self:_refreshOptionSelectItems()
	self:_refreshKeyTip()
end

function StoryBranchView:_refreshOptionSelectItems()
	self._spItems = {}

	local optionTabs = {}

	for _, v in ipairs(self.viewParam) do
		if v.optionCo then
			if v.optionCo.type == StoryEnum.OptionType.EndAsk then
				local hasPlayed = false
				local logs = StoryModel.instance:getLog()

				for _, option in pairs(self.viewParam) do
					if option.optionCo and LuaUtil.tableContains(logs, option.optionCo.followId) then
						hasPlayed = true
					end
				end

				if hasPlayed then
					table.insert(optionTabs, v)
				end
			else
				table.insert(optionTabs, v)
			end
		end
	end

	if #optionTabs > #self._items then
		for i = #optionTabs + 1, #self._items do
			self._items[i]:showItem(false)
		end
	end

	for i, v in ipairs(optionTabs) do
		if not self._items[i] then
			if v.optionCo and v.optionCo.type == StoryEnum.OptionType.SpClick then
				self._items[i] = StoryBranchOptionSpClickSelectItem.New()

				self._items[i]:init(self._gosp)
				table.insert(self._spItems, self._items[i])
			elseif v.optionCo and v.optionCo.type == StoryEnum.OptionType.SpSlide then
				self._items[i] = StoryBranchOptionSpSlideSelectItem.New()

				self._items[i]:init(self._gosp)
				table.insert(self._spItems, self._items[i])
			elseif v.optionCo and v.optionCo.type == StoryEnum.OptionType.SpLongClick then
				self._items[i] = StoryBranchOptionSpLongClickSelectItem.New()

				self._items[i]:init(self._gosp)
				table.insert(self._spItems, self._items[i])
			else
				self._items[i] = StoryBranchOptionSelectItem.New()

				local go = gohelper.cloneInPlace(self._gonormalitem)

				self._items[i]:init(go)
			end
		end

		self._items[i]:showItem(true)
		self._items[i]:refresh(v)
	end

	self._itemCount = #self._items
end

function StoryBranchView:_refreshKeyTip()
	self._keyTrigger = {}

	if not self._items then
		return
	end

	local index = 1

	for i, v in ipairs(self._items) do
		if v and v.go and v.go.activeSelf then
			local keytips = gohelper.findChild(v.go, "bgdark/go_pcbtn")

			if keytips then
				PCInputController.instance:showkeyTips(keytips, 0, 0, "Alpha" .. index)
			end

			self._keyTrigger[index] = i
			index = index + 1
		end
	end
end

function StoryBranchView:onClose()
	PostProcessingMgr.instance:setIgnoreUIBlur(false)
end

function StoryBranchView:onDestroyView()
	TaskDispatcher.cancelTask(self._refresh, self)
	StoryModel.instance:enableClick(true)
	TaskDispatcher.cancelTask(self._autoSelectSpItem, self)

	if self._items then
		for _, v in pairs(self._items) do
			v:destroy()
		end

		self._items = nil
	end
end

return StoryBranchView
