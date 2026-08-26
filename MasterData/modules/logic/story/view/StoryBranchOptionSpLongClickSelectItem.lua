-- chunkname: @modules/logic/story/view/StoryBranchOptionSpLongClickSelectItem.lua

module("modules.logic.story.view.StoryBranchOptionSpLongClickSelectItem", package.seeall)

local StoryBranchOptionSpLongClickSelectItem = class("StoryBranchOptionSpLongClickSelectItem")

function StoryBranchOptionSpLongClickSelectItem:init(rootGo)
	self._goroot = rootGo

	self:_addEvents()
end

function StoryBranchOptionSpLongClickSelectItem:_addEvents()
	StoryController.instance:registerCallback(StoryEvent.OnOptionSelected, self._onSelectOption, self)
end

function StoryBranchOptionSpLongClickSelectItem:_removeEvents()
	if self._btnselect then
		self._btnselect:RemoveLongPressListener()
	end

	if self._btnUp then
		self._btnUp:RemoveClickListener()
	end

	StoryController.instance:unregisterCallback(StoryEvent.OnOptionSelected, self._onSelectOption, self)
end

function StoryBranchOptionSpLongClickSelectItem:_onSelectOption(param)
	if param and param.index and param.index == self._param.index then
		self:_setOptionSelect()

		return
	end

	self:_setOptionUnselect()
end

local guideFillTime = 2

function StoryBranchOptionSpLongClickSelectItem:_onLongClick()
	if not self._startTime then
		self:_startFill()

		self._startTime = ServerTime.now()
	else
		local curTime = ServerTime.now()

		if curTime - self._startTime > guideFillTime then
			if self._btnselect then
				self._btnselect:RemoveLongPressListener()
			end

			if self._btnUp then
				self._btnUp:RemoveClickListener()
			end

			if self._tweenId then
				ZProj.TweenHelper.KillById(self._tweenId)

				self._tweenId = nil
			end

			self._anim.enabled = true

			StoryController.instance:dispatchEvent(StoryEvent.OnOptionSelected, self._param)
			TaskDispatcher.runDelay(self._onSelectOptionFinished, self, 1.33)
		end
	end
end

function StoryBranchOptionSpLongClickSelectItem:_startFill()
	self._anim.enabled = false

	gohelper.setActive(self._goguide, false)
	gohelper.setActive(self._goeff, false)

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, guideFillTime, self._updateFill, nil, self)
end

function StoryBranchOptionSpLongClickSelectItem:_updateFill(value)
	self._imagetop.fillAmount = value
end

function StoryBranchOptionSpLongClickSelectItem:setAutoClick()
	self:_onLongClick(0)
end

function StoryBranchOptionSpLongClickSelectItem:_setOptionSelect()
	self._anim:Play("click", 0, 0)
end

function StoryBranchOptionSpLongClickSelectItem:_onSelectOptionFinished()
	StoryController.instance:dispatchEvent(StoryEvent.OnOptionSelectFinish, self._param)
end

function StoryBranchOptionSpLongClickSelectItem:_setOptionUnselect()
	if self._anim then
		self._anim:SetBool("isUnselect", true)
	end
end

function StoryBranchOptionSpLongClickSelectItem:showItem(show)
	gohelper.setActive(self.go, show)
end

function StoryBranchOptionSpLongClickSelectItem:getOptionIndex()
	return self._param.index
end

function StoryBranchOptionSpLongClickSelectItem:refresh(param)
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

local openAnimTime = 0.34

function StoryBranchOptionSpLongClickSelectItem:_onSelectItemLoaded()
	local params = string.split(self._param.name, "|")

	if params[2] then
		local trans = string.splitToNumber(params[2], "#")

		if params[3] then
			local isLang = tonumber(params[3]) == 1
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
			self._imagebottom = gohelper.findChildImage(self.go, "image_bottom")
			self._imagetop = gohelper.findChildImage(self.go, "image_top")
			self._goeff = gohelper.findChild(self.go, "go_eff")
			self._goguide = gohelper.findChild(self.go, "go_guide")
			self._clickGo = gohelper.findChild(self.go, "btn_longclick")

			transformhelper.setLocalPos(self.go.transform, trans[1], trans[2], 0)
			transformhelper.setLocalScale(self.go.transform, trans[3], trans[3], 1)
			gohelper.setActive(self.go, true)
			TaskDispatcher.runDelay(self._onShowLongFinished, self, openAnimTime)
		end
	end
end

function StoryBranchOptionSpLongClickSelectItem:_onShowLongFinished()
	self._btnselect = SLFramework.UGUI.UILongPressListener.Get(self._clickGo)

	self._btnselect:SetLongPressTime({
		0,
		0.02
	})
	self._btnselect:AddLongPressListener(self._onLongClick, self)

	self._btnUp = gohelper.getClick(self._clickGo)

	self._btnUp:AddClickListener(self._onBtnUpClick, self)
	self:_startLoop()
end

function StoryBranchOptionSpLongClickSelectItem:_onBtnUpClick()
	self:_startLoop()
end

function StoryBranchOptionSpLongClickSelectItem:_startLoop()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	self._startTime = nil
	self._imagetop.fillAmount = 0

	TaskDispatcher.cancelTask(self._onShowLongFinished, self)

	self._anim.enabled = true

	gohelper.setActive(self._goguide, true)
	gohelper.setActive(self._goeff, true)
	self._anim:Play("loop", 0, 0)
end

function StoryBranchOptionSpLongClickSelectItem:destroy()
	TaskDispatcher.cancelTask(self._onSelectOptionFinished, self)
	TaskDispatcher.cancelTask(self._onShowLongFinished, self)
	self:_removeEvents()

	if self._prefabLoader then
		self._prefabLoader:dispose()

		self._prefabLoader = nil
	end

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

return StoryBranchOptionSpLongClickSelectItem
