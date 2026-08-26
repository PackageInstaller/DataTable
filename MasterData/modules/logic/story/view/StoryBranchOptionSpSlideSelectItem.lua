-- chunkname: @modules/logic/story/view/StoryBranchOptionSpSlideSelectItem.lua

module("modules.logic.story.view.StoryBranchOptionSpSlideSelectItem", package.seeall)

local StoryBranchOptionSpSlideSelectItem = class("StoryBranchOptionSpSlideSelectItem")

function StoryBranchOptionSpSlideSelectItem:init(rootGo)
	self._goroot = rootGo

	self:_addEvents()
end

function StoryBranchOptionSpSlideSelectItem:_addEvents()
	StoryController.instance:registerCallback(StoryEvent.OnOptionSelected, self._onSelectOption, self)
end

function StoryBranchOptionSpSlideSelectItem:_removeEvents()
	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()

		self._drag = nil
	end

	StoryController.instance:unregisterCallback(StoryEvent.OnOptionSelected, self._onSelectOption, self)
end

function StoryBranchOptionSpSlideSelectItem:_onSelectOption(param)
	if param and param.index and param.index == self._param.index then
		self:_setOptionSelect()

		return
	end

	self:_setOptionUnselect()
end

function StoryBranchOptionSpSlideSelectItem:_btnselectOnClick()
	StoryController.instance:dispatchEvent(StoryEvent.OnOptionSelected, self._param)
	TaskDispatcher.runDelay(self._onSelectOptionFinished, self, 1)
end

function StoryBranchOptionSpSlideSelectItem:setAutoClick()
	self:_btnselectOnClick(0)
end

function StoryBranchOptionSpSlideSelectItem:_setOptionSelect()
	self._anim:Play("click", 0, 0)
end

function StoryBranchOptionSpSlideSelectItem:_onSelectOptionFinished()
	StoryController.instance:dispatchEvent(StoryEvent.OnOptionSelectFinish, self._param)
end

function StoryBranchOptionSpSlideSelectItem:_setOptionUnselect()
	if self._anim then
		self._anim:SetBool("isUnselect", true)
	end
end

function StoryBranchOptionSpSlideSelectItem:showItem(show)
	gohelper.setActive(self.go, show)
end

function StoryBranchOptionSpSlideSelectItem:getOptionIndex()
	return self._param.index
end

local openAnimTime = 0.34

function StoryBranchOptionSpSlideSelectItem:refresh(param)
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

function StoryBranchOptionSpSlideSelectItem:_onSelectItemLoaded()
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

			transformhelper.setLocalPos(self.go.transform, trans[1], trans[2], 0)

			self._scale = trans[3]
			self._imagelinebottom = gohelper.findChildImage(self.go, "image_linebottom")
			self._imagelinetop = gohelper.findChildImage(self.go, "image_linetop")
			self._goeff = gohelper.findChild(self.go, "go_eff")
			self._goguide = gohelper.findChild(self.go, "go_guide")
			self._goslide = gohelper.findChild(self.go, "go_slide")
			self._imagelinebottom.fillAmount = self._scale
			self._imagelinetop.fillAmount = 0

			gohelper.setActive(self._goeff, false)
			TaskDispatcher.runDelay(self._onShowSlideFinished, self, openAnimTime)
			gohelper.setActive(self.go, true)
		end
	end
end

function StoryBranchOptionSpSlideSelectItem:_onShowSlideFinished()
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._goslide)

	self._drag:AddDragBeginListener(self._onSlideBegin, self)
	self._drag:AddDragListener(self._onSliding, self)
	self._drag:AddDragEndListener(self._onSlideEnd, self)
	self:_startLoop()
end

local slideAniTime = 1.333

function StoryBranchOptionSpSlideSelectItem:_startLoop()
	self._imagelinetop.fillAmount = 0

	gohelper.setActive(self._goeff, false)
	TaskDispatcher.cancelTask(self._onShowSlideFinished, self)
	self:_playLoopFollow()
	TaskDispatcher.runRepeat(self._playLoopFollow, self, slideAniTime)
end

local slideStartPosX = -370
local slideEndPosX = 370

function StoryBranchOptionSpSlideSelectItem:_playLoopFollow()
	self._anim.enabled = true

	gohelper.setActive(self._goguide, true)
	self._anim:Play("loop", 0, 0)

	local params = string.split(self._param.name, "|")

	if params[2] then
		local trans = string.splitToNumber(params[2], "#")

		transformhelper.setLocalPos(self.go.transform, params[2][1], params[2][2], 0)

		if not self._scale then
			local width = recthelper.getWidth(self._imagelinetop.transform)

			recthelper.setWidth(self._goslide.transform, self._scale * width)
			recthelper.setAnchorX(self._goslide.transform, 0.5 * (1 - self._scale) * width)

			self._startPosX = slideStartPosX + (1 - self._scale) * (slideEndPosX - slideStartPosX)

			recthelper.setAnchorX(self._goguide.transform, self._startPosX)

			if self._tweenId then
				ZProj.TweenHelper.KillById(self._tweenId)

				self._tweenId = nil
			end

			self._tweenId = ZProj.TweenHelper.DOAnchorPosX(self._goguide.transform, slideEndPosX, slideAniTime)
		end
	end
end

function StoryBranchOptionSpSlideSelectItem:_onSlideBegin(param, pointerEventData)
	gohelper.setActive(self._goeff, true)

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	TaskDispatcher.cancelTask(self._playLoopFollow, self)

	self._anim.enabled = false

	gohelper.setActive(self._goguide, false)
	AudioMgr.instance:trigger(AudioEnum.Story.play_ui_beiai_avgqte_loop)

	self._startClickPosX = pointerEventData.position.x
end

function StoryBranchOptionSpSlideSelectItem:_onSliding(param, pointerEventData)
	local curPosX = pointerEventData.position.x

	self._imagelinetop.fillAmount = (curPosX - self._startClickPosX) / (slideEndPosX - self._startPosX)

	local curEffPosX = slideStartPosX

	if curPosX < self._startClickPosX then
		-- block empty
	else
		curEffPosX = curPosX > slideEndPosX - self._startPosX + self._startClickPosX and slideEndPosX - self._startPosX + self._startClickPosX or slideStartPosX + (curPosX - self._startClickPosX)
	end

	recthelper.setAnchorX(self._goeff.transform, curEffPosX)
end

function StoryBranchOptionSpSlideSelectItem:_onSlideEnd(param, pointerEventData)
	local endDragPosX = pointerEventData.position.x

	AudioMgr.instance:trigger(AudioEnum.Story.stop_ui_beiai_avgqte_loop)

	if endDragPosX - self._startClickPosX > slideEndPosX - self._startPosX then
		AudioMgr.instance:trigger(AudioEnum.Story.play_ui_beiai_avgqte_loopend)
		StoryController.instance:dispatchEvent(StoryEvent.OnOptionSelected, self._param)
		TaskDispatcher.runDelay(self._onSelectOptionFinished, self, 1)
	else
		self:_startLoop()
	end
end

function StoryBranchOptionSpSlideSelectItem:destroy()
	TaskDispatcher.cancelTask(self._onSelectOptionFinished, self)
	TaskDispatcher.cancelTask(self._onShowSlideFinished, self)
	TaskDispatcher.cancelTask(self._playLoopFollow, self)

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	self:_removeEvents()

	if self._prefabLoader then
		self._prefabLoader:dispose()

		self._prefabLoader = nil
	end
end

return StoryBranchOptionSpSlideSelectItem
