-- chunkname: @modules/logic/versionactivity3_6/puzzle/view/V3a6PuzzleView.lua

module("modules.logic.versionactivity3_6.puzzle.view.V3a6PuzzleView", package.seeall)

local V3a6PuzzleView = class("V3a6PuzzleView", BaseView)

function V3a6PuzzleView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageProgress1 = gohelper.findChildSingleImage(self.viewGO, "Dec/#simage_Progress1")
	self._simageProgress2 = gohelper.findChildSingleImage(self.viewGO, "Dec/#simage_Progress2")
	self._simageProgress3 = gohelper.findChildSingleImage(self.viewGO, "Dec/#simage_Progress3")
	self._simageprop = gohelper.findChildSingleImage(self.viewGO, "#simage_prop")
	self._goInputLight = gohelper.findChild(self.viewGO, "Input/#go_InputLight")
	self._goCharsVX = gohelper.findChild(self.viewGO, "Chars/#go_CharsVX")
	self._gocontentroot = gohelper.findChild(self.viewGO, "#go_contentroot")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._gotouch = gohelper.findChild(self.viewGO, "#simage_prop/touch")
	self._gotip = gohelper.findChild(self.viewGO, "txt_tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6PuzzleView:addEvents()
	return
end

function V3a6PuzzleView:removeEvents()
	return
end

local CharSprite = {
	T = "avg_spelling_t",
	Z = "avg_spelling_z",
	U2 = "avg_spelling_u2",
	U1 = "avg_spelling_u1",
	N = "avg_spelling_n",
	F = "avg_spelling_f",
	K = "avg_spelling_k"
}
local lightPos = -240
local gridDis = 79

function V3a6PuzzleView:_editableInitView()
	local touchRect = self._gotouch.transform.rect

	self._targetRange = {
		minX = touchRect.x,
		minY = touchRect.y,
		maxX = touchRect.x + touchRect.width,
		maxY = touchRect.y + touchRect.height
	}
	self._charItems = self:getUserDataTb_()

	for char, _ in pairs(CharSprite) do
		local item = self:getUserDataTb_()

		item.go = gohelper.findChild(self.viewGO, "Chars/Char_" .. char)
		item.vx = gohelper.clone(self._goCharsVX, item.go)
		item.vxRight = gohelper.findChild(item.vx, "right")
		item.vxError = gohelper.findChild(item.vx, "error")
		item.drag = SLFramework.UGUI.UIDragListener.Get(item.go)
		item.click = SLFramework.UGUI.UIClickListener.Get(item.go)

		item.drag:AddDragBeginListener(self._onDragBegin, self, char)
		item.drag:AddDragListener(self._onDrag, self, char)
		item.drag:AddDragEndListener(self._onDragEnd, self, char)
		item.click:AddClickListener(self._onClick, self, char)

		function item.delayErrorVx()
			gohelper.setActive(item.vx, false)
			gohelper.setActive(item.vxRight, false)
			gohelper.setActive(item.vxError, false)
		end

		local x, y = recthelper.getAnchor(item.go.transform)

		item.orignAnchor = {
			x = x,
			y = y
		}

		gohelper.setActive(item.vx, false)

		self._charItems[char] = item
	end

	self._inputCharItems = self:getUserDataTb_()
	self._finishCharItems = self:getUserDataTb_()

	for i = 1, 7 do
		local item = self:getUserDataTb_()

		item.icon = gohelper.findChildImage(self.viewGO, "Input/Chars/Char" .. i)
		item.go = item.icon.gameObject

		gohelper.setActive(item.go, false)

		self._inputCharItems[i] = item
		self._finishCharItems[i] = gohelper.findChildImage(self.viewGO, "Input/Chars_finish/Char" .. i)
	end

	self._isSuccessChar = {}
	self._correctInput = V3a5PuzzleConfig.instance:getConstValue(V3a5PuzzleEnum.ConstId.V3a6_InputChar, true)
	self._inputIndex = 0
	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self:_checkNextChar()
	self:_hideLight()
end

function V3a6PuzzleView:_onDragBegin(param, pointerEventData)
	AudioMgr.instance:trigger(AudioEnum3_6.Puzzle.play_ui_mingdi_gsn_anzhu)

	if not param then
		return
	end

	if self._isSuccessChar[param] then
		return
	end

	local item = self._charItems[param]

	if not item then
		return
	end

	self._isDraging = true

	self:_refreshLight()
end

function V3a6PuzzleView:_onDrag(param, pointerEventData)
	if not param then
		return
	end

	if self._isSuccessChar[param] then
		return
	end

	local item = self._charItems[param]

	if not item then
		return
	end

	local isIn = self:_isInTouch(item)

	gohelper.setActive(self._goInputLight, isIn)

	local _dragPos = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), self.viewGO.transform)

	recthelper.setAnchor(item.go.transform, _dragPos.x, _dragPos.y)
end

function V3a6PuzzleView:_onDragEnd(param, pointerEventData)
	self._isDraging = false

	if not param then
		return
	end

	if self._isSuccessChar[param] then
		return
	end

	local item = self._charItems[param]

	if not item then
		return
	end

	local isIn = self:_isInTouch(item)

	if isIn and self:_isCorrect(param) then
		self:_successPutIn(param)
	else
		self:_failPutIn(param, isIn)
	end

	self:_hideLight()
end

function V3a6PuzzleView:_isInTouch(item)
	local anchoredPosition = item.go.transform.anchoredPosition

	if anchoredPosition.x >= self._targetRange.minX and anchoredPosition.x <= self._targetRange.maxX and anchoredPosition.y >= self._targetRange.minY and anchoredPosition.y <= self._targetRange.maxY then
		return true
	end
end

function V3a6PuzzleView:_isCorrect(char)
	local index = self._inputIndex + 1
	local correctChar = string.sub(self._correctInput, index, index)

	if correctChar == "U" then
		return char == "U1" or char == "U2"
	end

	return char == correctChar
end

function V3a6PuzzleView:_successPutIn(char)
	self._isSuccessChar[char] = true
	self._inputIndex = self._inputIndex + 1

	local inputItem = self._inputCharItems[self._inputIndex]

	gohelper.setActive(inputItem.go, true)
	gohelper.setActive(self._charItems[char].go, false)

	local icon = CharSprite[char]

	UISpriteSetMgr.instance:setAVGSpellingSprite(inputItem.icon, icon)
	UISpriteSetMgr.instance:setAVGSpellingSprite(self._finishCharItems[self._inputIndex], icon)

	local isAll = self._inputIndex >= #self._correctInput
	local animName = "get"

	if isAll then
		animName = "finish"

		AudioMgr.instance:trigger(AudioEnum3_6.Puzzle.play_ui_mingdi_ysm_mubiao)
		self:_allCorrectInput()
	else
		self:_checkNextChar()
	end

	self._viewAnim:Play(animName, 0, 0)
	AudioMgr.instance:trigger(AudioEnum3_6.Puzzle.play_ui_mingdi_gsn_fang)
end

function V3a6PuzzleView:_onClick(char)
	if self._isDraging then
		return
	end

	if self:_isCorrect(char) then
		self:_successPutIn(char)
	else
		self:_failPutIn(char, true)
	end
end

function V3a6PuzzleView:_checkNextChar()
	for char, item in pairs(self._charItems) do
		if (not self._isSuccessChar[char] and self:_isCorrect(char) or nil) and true then
			TaskDispatcher.cancelTask(item.delayErrorVx, item)
			gohelper.setActive(item.vxError, false)
			gohelper.setActive(item.vx, true)
			gohelper.setActive(item.vxRight, true)
		else
			gohelper.setActive(item.vx, false)
		end
	end
end

function V3a6PuzzleView:_refreshLight()
	recthelper.setAnchorX(self._goInputLight.transform, lightPos + self._inputIndex * gridDis)
	gohelper.setActive(self._goInputLight, self._inputIndex < #self._correctInput)
end

function V3a6PuzzleView:_hideLight()
	gohelper.setActive(self._goInputLight, false)
end

function V3a6PuzzleView:_failPutIn(char, isPutIn)
	local item = self._charItems[char]
	local nowAnchor = item.go.transform.anchoredPosition
	local anchor = item.orignAnchor
	local time = Vector2.Distance(nowAnchor, Vector2(anchor.x, anchor.y)) * 0.001

	time = Mathf.Clamp(time, 0.5, 1)

	if isPutIn then
		TaskDispatcher.cancelTask(item.delayErrorVx, item)
		gohelper.setActive(item.vxRight, false)
		gohelper.setActive(item.vx, true)
		gohelper.setActive(item.vxError, true)
		TaskDispatcher.runDelay(item.delayErrorVx, item, 1.5)
	end

	item.tweenId = ZProj.TweenHelper.DOAnchorPos(item.go.transform, anchor.x, anchor.y, time)

	AudioMgr.instance:trigger(AudioEnum3_6.Puzzle.play_ui_diqiu_put)
end

function V3a6PuzzleView:_allCorrectInput()
	gohelper.setActive(self._gotip, false)
	TaskDispatcher.runDelay(self._checkPlayNextStory, self, 2)
end

function V3a6PuzzleView:_checkPlayNextStory()
	TaskDispatcher.runDelay(self.closeThis, self, 1)
	V3a5PuzzleController.instance:playNextStory(self._storyId, self.viewName, self.closeThis, self)
end

function V3a6PuzzleView:onUpdateParam()
	return
end

function V3a6PuzzleView:onOpen()
	gohelper.setActive(self._gotip, true)

	self._storyId = self.viewParam.storyId
end

function V3a6PuzzleView:startDialog(groupId)
	self.viewContainer:startDialog(groupId)
end

function V3a6PuzzleView:_showDialog(isShow)
	return
end

function V3a6PuzzleView:onClose()
	return
end

function V3a6PuzzleView:onDestroyView()
	for _, item in pairs(self._charItems) do
		item.drag:RemoveDragBeginListener()
		item.drag:RemoveDragListener()
		item.drag:RemoveDragEndListener()
		item.click:RemoveClickListener()
		TaskDispatcher.cancelTask(item.delayErrorVx, item)

		if item.tweenId then
			ZProj.TweenHelper.KillById(item.tweenId)

			item.tweenId = nil
		end
	end
end

return V3a6PuzzleView
