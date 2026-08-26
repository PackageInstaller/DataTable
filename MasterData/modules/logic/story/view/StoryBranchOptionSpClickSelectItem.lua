-- chunkname: @modules/logic/story/view/StoryBranchOptionSpClickSelectItem.lua

module("modules.logic.story.view.StoryBranchOptionSpClickSelectItem", package.seeall)

local StoryBranchOptionSpClickSelectItem = class("StoryBranchOptionSpClickSelectItem")

function StoryBranchOptionSpClickSelectItem:init(rootGo)
	self._goroot = rootGo

	self:_addEvents()
end

function StoryBranchOptionSpClickSelectItem:_addEvents()
	StoryController.instance:registerCallback(StoryEvent.OnOptionSelected, self._onSelectOption, self)
end

function StoryBranchOptionSpClickSelectItem:_removeEvents()
	if self._btnselect then
		self._btnselect:RemoveClickListener()
	end

	StoryController.instance:unregisterCallback(StoryEvent.OnOptionSelected, self._onSelectOption, self)
end

function StoryBranchOptionSpClickSelectItem:_onSelectOption(param)
	if param and param.index and param.index == self._param.index then
		self:_setOptionSelect()

		return
	end

	self:_setOptionUnselect()
end

function StoryBranchOptionSpClickSelectItem:_btnselectOnClick()
	StoryController.instance:dispatchEvent(StoryEvent.OnOptionSelected, self._param)
	TaskDispatcher.runDelay(self._onSelectOptionFinished, self, 0.5)
end

function StoryBranchOptionSpClickSelectItem:setAutoClick()
	self:_btnselectOnClick(0)
end

function StoryBranchOptionSpClickSelectItem:_setOptionSelect()
	if self._anim then
		self._anim:SetBool("isSelect", true)
	end
end

function StoryBranchOptionSpClickSelectItem:_onSelectOptionFinished()
	StoryController.instance:dispatchEvent(StoryEvent.OnOptionSelectFinish, self._param)
end

function StoryBranchOptionSpClickSelectItem:_setOptionUnselect()
	if self._anim then
		self._anim:SetBool("isUnselect", true)
	end
end

function StoryBranchOptionSpClickSelectItem:showItem(show)
	gohelper.setActive(self.go, show)
end

function StoryBranchOptionSpClickSelectItem:getOptionIndex()
	return self._param.index
end

function StoryBranchOptionSpClickSelectItem:refresh(param)
	self._param = param

	local params = string.split(self._param.name, "|")

	if not params[1] then
		local prefabName = ""
		local prefabPath = ResUrl.getStoryPrefabOptionRes(prefabName)

		if self._prefabPath and self._prefabPath == prefabPath then
			return
		end

		self._prefabPath = prefabPath
		self._prefabLoader = MultiAbLoader.New()

		self._prefabLoader:addPath(self._prefabPath)
		self._prefabLoader:startLoad(self._onSelectItemLoaded, self)
	end
end

function StoryBranchOptionSpClickSelectItem:_onSelectItemLoaded()
	local params = string.split(self._param.name, "|")

	if params[2] then
		local trans = string.splitToNumber(params[2], "#")

		if params[3] then
			local isLang = tonumber(params[3]) == 1
			local audioId = params[4] and tonumber(params[4]) or 0

			if audioId > 0 then
				AudioMgr.instance:trigger(audioId)
			end

			local prefab = self._prefabLoader:getAssetItem(self._prefabPath):GetResource(self._prefabPath)
			local go = gohelper.clone(prefab, self._goroot)

			if isLang then
				local txtType = GameLanguageMgr.instance:getLanguageTypeStoryIndex()
				local lanName = LanguageEnum.LanguageStoryType2Key[txtType]

				self.go = gohelper.findChild(go, lanName)
			else
				self.go = go
			end

			self._anim = self.go:GetComponent(typeof(UnityEngine.Animator))
			self._btnselect = gohelper.findChildButtonWithAudio(self.go, "btn_click")

			self._btnselect:AddClickListener(self._btnselectOnClick, self)
			transformhelper.setLocalPos(self.go.transform, trans[1], trans[2], 0)
			transformhelper.setLocalScale(self.go.transform, trans[3], trans[3], 1)
			gohelper.setActive(self.go, true)
		end
	end
end

function StoryBranchOptionSpClickSelectItem:destroy()
	TaskDispatcher.cancelTask(self._onSelectOptionFinished, self)
	self:_removeEvents()

	if self._prefabLoader then
		self._prefabLoader:dispose()

		self._prefabLoader = nil
	end
end

return StoryBranchOptionSpClickSelectItem
