-- chunkname: @modules/logic/story/view/StoryBranchOptionSelectItem.lua

module("modules.logic.story.view.StoryBranchOptionSelectItem", package.seeall)

local StoryBranchOptionSelectItem = class("StoryBranchOptionSelectItem")

function StoryBranchOptionSelectItem:init(go)
	self.go = go
	self._anim = self.go:GetComponent(typeof(UnityEngine.Animator))
	self._btnselect = gohelper.findChildButtonWithAudio(self.go, "btnselect")
	self._txtcontentdark = gohelper.findChildText(self.go, "bgdark/txtcontentdark")
	self._imageicon = gohelper.findChildImage(self.go, "bgdark/icon")

	self:_addEvents()
end

function StoryBranchOptionSelectItem:_addEvents()
	StoryController.instance:registerCallback(StoryEvent.OnOptionSelected, self._onSelectOption, self)
	self._btnselect:AddClickListener(self._btnselectOnClick, self)
end

function StoryBranchOptionSelectItem:_removeEvents()
	StoryController.instance:unregisterCallback(StoryEvent.OnOptionSelected, self._onSelectOption, self)
	self._btnselect:RemoveClickListener()
end

function StoryBranchOptionSelectItem:_onSelectOption(param)
	if param and param.index and param.index == self._param.index then
		self:_setOptionSelect()

		return
	end

	self:_setOptionUnselect()
end

function StoryBranchOptionSelectItem:_btnselectOnClick()
	StoryController.instance:dispatchEvent(StoryEvent.OnOptionSelected, self._param)
	TaskDispatcher.runDelay(self._onSelectOptionFinished, self, 0.2)
end

function StoryBranchOptionSelectItem:_setOptionSelect()
	if self._anim then
		self._anim:SetBool("isSelect", true)
	end
end

function StoryBranchOptionSelectItem:_onSelectOptionFinished()
	StoryController.instance:dispatchEvent(StoryEvent.OnOptionSelectFinish, self._param)
end

function StoryBranchOptionSelectItem:_setOptionUnselect()
	if self._anim then
		self._anim:SetBool("isUnselect", true)
	end
end

function StoryBranchOptionSelectItem:showItem(show)
	gohelper.setActive(self.go, show)
end

function StoryBranchOptionSelectItem:getOptionIndex()
	return self._param.index
end

function StoryBranchOptionSelectItem:refresh(param)
	self._param = param

	gohelper.setActive(self.go, true)

	if self._anim then
		self._anim:SetBool("isUnselect", false)
		self._anim:SetBool("isSelect", false)
		self._anim:Play("open", 0, 0)
	end

	self:_refreshItem()
end

function StoryBranchOptionSelectItem:_refreshItem()
	if self._txtcontentdark then
		local isPlayed = self:_isBranchPlayed()
		local txtColor = isPlayed and "#807C7C" or "#EAE7DF"

		self._txtcontentdark.color = GameUtil.parseColor(txtColor)
		self._txtcontentdark.text = tonumber(self._param.name) and luaLang(self._param.name) or self._param.name

		local imgColor = isPlayed and "#807C7C" or "#FFFFFF"

		self._imageicon.color = GameUtil.parseColor(imgColor)
	end
end

function StoryBranchOptionSelectItem:_isBranchPlayed()
	local logs = StoryModel.instance:getLog()

	if LuaUtil.tableContains(logs, self._param.optionCo.followId) then
		return true
	end

	return false
end

function StoryBranchOptionSelectItem:destroy()
	self:_removeEvents()
	TaskDispatcher.cancelTask(self._onSelectOptionFinished, self)
end

return StoryBranchOptionSelectItem
