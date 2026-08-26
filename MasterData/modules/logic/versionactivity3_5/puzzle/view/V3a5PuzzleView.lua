-- chunkname: @modules/logic/versionactivity3_5/puzzle/view/V3a5PuzzleView.lua

module("modules.logic.versionactivity3_5.puzzle.view.V3a5PuzzleView", package.seeall)

local V3a5PuzzleView = class("V3a5PuzzleView", BaseView)

function V3a5PuzzleView:onInitView()
	self._goBox = gohelper.findChild(self.viewGO, "#go_Box")
	self._goimageBox = gohelper.findChild(self.viewGO, "#go_Box/image_BoxBG")
	self._goLightBox = gohelper.findChild(self.viewGO, "#go_Box/image_BoxLight")
	self._goNormalBox = gohelper.findChild(self.viewGO, "#go_Box/image_Box")
	self._clickBox = gohelper.getClick(self._goimageBox)
	self._goIcons = gohelper.findChild(self.viewGO, "#go_Icons")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a5PuzzleView:addEvents()
	self._clickBox:AddClickListener(self.onClickBox, self)
end

function V3a5PuzzleView:removeEvents()
	self._clickBox:RemoveClickListener()
end

function V3a5PuzzleView:onClickBox()
	if self._isClickBox or not self._canClickBox then
		return
	end

	self._isClickBox = true

	self:_onIconItemClick(self._correctIconIndex)
end

function V3a5PuzzleView:_editableInitView()
	gohelper.setActive(self._goLightBox, false)
	gohelper.setActive(self._goNormalBox, true)

	self._correctIconIndex = V3a5PuzzleConfig.instance:getConstValue(V3a5PuzzleEnum.ConstId.CorrectIconIndex)
	self._clickErrorTimes = V3a5PuzzleConfig.instance:getConstValue(V3a5PuzzleEnum.ConstId.ClickErrorTimes)
	self._iconItem = self:getUserDataTb_()

	for i = 1, V3a5PuzzleEnum.IconCount do
		local item = self:getUserDataTb_()

		item.go = gohelper.findChild(self._goIcons, "Image_Icon" .. i)
		item.btn = gohelper.getClickWithAudio(item.go)

		item.btn:AddClickListener(self._onIconItemClick, self, i)

		item.canvasgroup = gohelper.onceAddComponent(item.go, typeof(UnityEngine.CanvasGroup))
		item.animator = item.go:GetComponent(typeof(UnityEngine.Animator))
		self._iconItem[i] = item
	end

	self._dialogView = self.viewContainer:getPuzzleDialogView()
end

function V3a5PuzzleView:_onIconItemClick(index)
	if self._clickIndex then
		return
	end

	local dialogGroupId

	self._errorTimes = self._errorTimes + 1

	if self._correctIconIndex == index then
		dialogGroupId = self._isClickBox and 4 or 1
	elseif self._errorTimes >= self._clickErrorTimes then
		dialogGroupId = 3

		if not self._canClickBox then
			gohelper.setActive(self._goLightBox, true)
			gohelper.setActive(self._goNormalBox, false)

			self._canClickBox = true
		end
	else
		dialogGroupId = self._errorTimes == 1 and 2 or 3
	end

	self._dialogView:startDialog(dialogGroupId)

	self._clickIndex = index

	local isCorrenct = self._correctIconIndex == index

	if dialogGroupId ~= 4 then
		for i, item in ipairs(self._iconItem) do
			local aniName = index == i and "click" or isCorrenct and "close" or "error"

			item.animator:Play(aniName, 0, 0)
		end

		AudioMgr.instance:trigger(AudioEnum3_5.Puzzle.play_ui_gudu_input_right)
	end
end

function V3a5PuzzleView:onOpen()
	self._errorTimes = 0
	self._isClickBox = false
	self._clickIndex = nil
	self._canClickBox = nil
	self._storyId = self.viewParam.storyId

	AudioMgr.instance:trigger(AudioEnum3_5.Puzzle.play_ui_molu_sky_open)
	self._dialogView:startDialog(6)
end

function V3a5PuzzleView:finishDialog(dialogGroupId)
	if self._correctIconIndex == self._clickIndex then
		if dialogGroupId == 4 then
			self._dialogView:startDialog(5)

			for i, item in ipairs(self._iconItem) do
				local aniName = self._correctIconIndex == i and "click" or "close"

				item.animator:Play(aniName, 0, 0)
			end

			return
		else
			self:_playNextStory()
		end
	end

	self._clickIndex = nil
end

function V3a5PuzzleView:_playNextStory()
	TaskDispatcher.runDelay(self.closeThis, self, 1)
	V3a5PuzzleController.instance:playNextStory(self._storyId, self.viewName, self.closeThis, self)
end

function V3a5PuzzleView:onClose()
	for _, item in ipairs(self._iconItem) do
		item.btn:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(self.closeThis, self)
end

function V3a5PuzzleView:onDestroyView()
	return
end

return V3a5PuzzleView
