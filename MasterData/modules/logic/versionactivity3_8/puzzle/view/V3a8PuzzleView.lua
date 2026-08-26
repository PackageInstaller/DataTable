-- chunkname: @modules/logic/versionactivity3_8/puzzle/view/V3a8PuzzleView.lua

module("modules.logic.versionactivity3_8.puzzle.view.V3a8PuzzleView", package.seeall)

local V3a8PuzzleView = class("V3a8PuzzleView", BaseView)

function V3a8PuzzleView:onInitView()
	self._btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Reset")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._gohand = gohelper.findChild(self.viewGO, "#go_hand")
	self._goComplete = gohelper.findChild(self.viewGO, "#go_Complete")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a8PuzzleView:addEvents()
	self._btnReset:AddClickListener(self._btnResetOnClick, self)
	self.addEventCb(self, GuideController.instance, GuideEvent.StartGuideStep, self._onStartGuideStep, self)
end

function V3a8PuzzleView:removeEvents()
	self._btnReset:RemoveClickListener()
	self.removeEventCb(self, GuideController.instance, GuideEvent.StartGuideStep, self._onStartGuideStep, self)
end

function V3a8PuzzleView:_btnResetOnClick()
	if self._gameSuccess then
		return
	end

	if self._isPlayingAudioSlot then
		ToastController.instance:showToast(ToastEnum.V3a8PuzzlePlayAudioTip)

		return
	end

	self:_reallyPlaySlotsAudio(0)
end

function V3a8PuzzleView:_onStartGuideStep(guideId, stepId)
	if guideId == 38300 and stepId == 3 then
		gohelper.setActive(self._gohand, true)
	end
end

local ItemCount = 6
local GameType = {
	Game2 = 2,
	Game1 = 1
}

function V3a8PuzzleView:_editableInitView()
	self._slotItems = self:getUserDataTb_()
	self._stoneItems = self:getUserDataTb_()

	local slotroot = gohelper.findChild(self.viewGO, "Slot")
	local stoneroot = gohelper.findChild(self.viewGO, "Stone")
	local delayTimesConstValue = V3a5PuzzleConfig.instance:getConstValue(V3a5PuzzleEnum.ConstId.V3a8_PlaySlotItemAudioDelayTime, true)
	local delayTimes = string.splitToNumber(delayTimesConstValue, "|")
	local audioIdsConstValue = V3a5PuzzleConfig.instance:getConstValue(V3a5PuzzleEnum.ConstId.V3a8_AudioIds, true)
	local audioIds = string.splitToNumber(audioIdsConstValue, "|")

	self._playSlotAudioTime = self:_getConstValue(V3a5PuzzleEnum.ConstId.V3a8_PlaySlotAudioTime)
	self._goRepeat = gohelper.findChild(self.viewGO, "vx_order")

	gohelper.setActive(self._goRepeat, true)

	self._itemParams = {}

	for i = 1, ItemCount do
		local slotItem = self:_getSlotItem(i, slotroot)

		self._slotItems[i] = slotItem
		slotItem.audioId = audioIds[i]
		slotItem.audioTime = 1.2
		slotItem.delayTime = delayTimes[i] or 0.2
		self._stoneItems[i] = self:_getStoneItem(i, stoneroot)
	end

	gohelper.setActive(self._gohand, false)

	local gobg = gohelper.findChild(self.viewGO, "Image_Base")

	self._bgAnim = gobg:GetComponent(typeof(UnityEngine.Animator))
	self._txtTitleDesc = gohelper.findChildText(self.viewGO, "Target/txt_TargetDescr")

	gohelper.setActive(self._goComplete, false)
end

function V3a8PuzzleView:_onClickSlotItem(slotItem)
	slotItem.playRepeat()
	self:_reallyPlaySlotsAudio()
end

function V3a8PuzzleView:_getSlotItem(i, slotroot)
	local slotItem = self:getUserDataTb_()

	slotItem.go = gohelper.findChild(slotroot, "Slot_" .. i)
	slotItem.golight = gohelper.findChild(slotItem.go, "Slot")
	slotItem.goVx = gohelper.findChild(slotItem.go, "vx_ring")
	slotItem.goStoneRoot = gohelper.findChild(slotItem.go, "stone")
	slotItem.index = i

	local goSlot = gohelper.findChild(slotItem.go, "Image_Groove")

	slotItem.btnClick = gohelper.getClick(goSlot)

	slotItem.btnClick:AddClickListener(self._onClickSlotItem, self, slotItem)

	slotItem.animPlayer = slotItem.go:GetComponent(typeof(UnityEngine.Animator))

	local x, y = recthelper.getAnchor(slotItem.go.transform)
	local width = recthelper.getWidth(slotItem.go.transform)
	local height = recthelper.getHeight(slotItem.go.transform)

	slotItem.left = x - width * 0.5
	slotItem.right = x + width * 0.5
	slotItem.bottom = y - height * 0.5
	slotItem.top = y + height * 0.5
	slotItem.orignAnchor = Vector2(x, y)
	slotItem.stoneIndex = 0

	function slotItem.stopAudio()
		slotItem.playAudioId = nil
	end

	function slotItem.playAnim(aniName)
		if slotItem.playAniName ~= aniName then
			slotItem.animPlayer:Play(aniName, 0, 0)

			slotItem.playAniName = aniName
		end
	end

	function slotItem.playLightAnim(isLight)
		if isLight then
			slotItem.playAnim("loop1")

			slotItem.playLightAudio = slotItem.playLightAudio or AudioMgr.instance:trigger(AudioEnum3_8.Puzzle.play_ui_shiji_slot_light)
		else
			slotItem.playAnim("idle")

			slotItem.playLightAudio = nil
		end
	end

	function slotItem.refreshSlot()
		slotItem.playAnim(slotItem.stoneIndex == slotItem.index and "loop2" or "close")
	end

	function slotItem.playRepeat()
		if not slotItem.animRepeat then
			local goRepeat = gohelper.findChild(self._goRepeat, "vx_ring_" .. i)

			slotItem.animRepeat = goRepeat:GetComponent(typeof(UnityEngine.Animator))
		end

		gohelper.setActive(slotItem.animRepeat.gameObject, true)

		if slotItem.animRepeat then
			TaskDispatcher.runDelay(slotItem.cancelPlayRepeat, slotItem, slotItem.audioTime)
		end

		slotItem.playAudioId = AudioMgr.instance:trigger(slotItem.audioId)
	end

	function slotItem.cancelPlayRepeat()
		if slotItem.animRepeat then
			gohelper.setActive(slotItem.animRepeat.gameObject, false)
		end
	end

	return slotItem
end

function V3a8PuzzleView:_getStoneItem(i, stoneroot)
	local stoneItem = self:getUserDataTb_()

	stoneItem.go = gohelper.findChild(stoneroot, "Stone_" .. i)
	stoneItem.goRipple = gohelper.findChild(stoneItem.go, "Stone_Ripple")
	stoneItem.drag = SLFramework.UGUI.UIDragListener.Get(stoneItem.go)
	stoneItem.click = SLFramework.UGUI.UIClickListener.Get(stoneItem.go)

	stoneItem.drag:AddDragBeginListener(self._onDragBegin, self, stoneItem)
	stoneItem.drag:AddDragListener(self._onDrag, self, stoneItem)
	stoneItem.drag:AddDragEndListener(self._onDragEnd, self, stoneItem)
	stoneItem.click:AddClickListener(self._onClick, self, stoneItem)

	stoneItem.index = i
	stoneItem.isSuccess = false

	local x, y = recthelper.getAnchor(stoneItem.go.transform)

	stoneItem.orignAnchor = Vector2(x, y)
	stoneItem.width = recthelper.getWidth(stoneItem.go.transform)
	stoneItem.height = recthelper.getHeight(stoneItem.go.transform)
	stoneItem.anim = stoneItem.go:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(stoneItem.goRipple, false)

	function stoneItem.returnPosFunc()
		local nowAnchor = stoneItem.go.transform.anchoredPosition
		local anchor = stoneItem.orignAnchor
		local time = Vector2.Distance(Vector2(nowAnchor.x, nowAnchor.y), Vector2(anchor.x, anchor.y)) * 0.001

		time = Mathf.Clamp(time, 0.5, 1)
		stoneItem.tweenId = ZProj.TweenHelper.DOAnchorPos(stoneItem.go.transform, anchor.x, anchor.y, time)
	end

	function stoneItem.stopClickAnim()
		stoneItem.playAnim("unselect")
	end

	function stoneItem.playErrorAnim()
		stoneItem.playAnim("error")
	end

	function stoneItem.playAnim(aniName)
		stoneItem.anim:Play(aniName, 0, 0)
	end

	return stoneItem
end

function V3a8PuzzleView:_getNearSlot(item, isCheck)
	for i, slotItem in pairs(self._slotItems) do
		if not slotItem.stoneIndex or slotItem.stoneIndex == 0 then
			local isNearSlot = self:_isNearSlot(item, slotItem)

			if self._gameType == GameType.Game1 then
				if isNearSlot then
					return slotItem
				end
			elseif isNearSlot and (not isCheck or slotItem.index == item.index) then
				return slotItem
			end
		end
	end
end

function V3a8PuzzleView:_onDragBegin(item, pointerEventData)
	gohelper.setActive(self._gohand, false)

	if not item or item.isSuccess then
		return
	end

	if item.tweenId then
		ZProj.TweenHelper.KillById(item.tweenId)

		item.tweenId = nil
	end

	item.playAnim("select")

	item.isDraging = true
	self._selectItem = item

	AudioMgr.instance:trigger(AudioEnum3_8.Puzzle.play_ui_qiutu_stele_put)
end

function V3a8PuzzleView:_onDrag(item, pointerEventData)
	if not item or item.isSuccess then
		return
	end

	self._selectItem = item

	local nearSlot = self:_getNearSlot(item, true)

	for i, slotItem in pairs(self._slotItems) do
		if slotItem.stoneIndex ~= slotItem.index then
			local isLight = nearSlot and nearSlot.index == slotItem.index

			slotItem.playLightAnim(isLight)
		end
	end

	local _dragPos = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), self.viewGO.transform)

	recthelper.setAnchor(item.go.transform, _dragPos.x, _dragPos.y)
end

function V3a8PuzzleView:_onDragEnd(item, pointerEventData)
	if item.isSuccess then
		return
	end

	item.isDraging = false

	item.playAnim("unselect")
	self:_checkSuccessPutIn(item)

	if not self._gameSuccess then
		self:_reallyPlaySlotsAudio()
	end
end

function V3a8PuzzleView:_isNearSlot(item, slotItem)
	if slotItem and item then
		local x, y = recthelper.getAnchor(item.go.transform)
		local itemleft = x - item.width * 0.5
		local itemright = x + item.width * 0.5
		local itembottom = y - item.height * 0.5
		local itemtop = y + item.height * 0.5

		if itemright < slotItem.left or itemleft > slotItem.right or itembottom > slotItem.top or itemtop < slotItem.bottom then
			return false
		else
			return true
		end
	end
end

function V3a8PuzzleView:_onClick(item)
	if item.isDraging then
		return
	end

	if item.isSuccess then
		item.playAnim("error")
		AudioMgr.instance:trigger(AudioEnum3_8.Puzzle.play_ui_shiji_stone_shake_short)

		if self._gameType == GameType.Game1 then
			local dialogConstId = 381004

			if not self._isPlayedDialogs[dialogConstId] then
				self._isPlayedDialogs[dialogConstId] = true

				self:_playDialogByConst(dialogConstId)
			end
		end

		return
	end

	item.playAnim("click")
	self:_reallyPlaySlotsAudio()

	local slotItem = self._slotItems[item.index]

	slotItem.playAudioId = AudioMgr.instance:trigger(slotItem.audioId)

	TaskDispatcher.cancelTask(item.stopClickAnim, item)
	TaskDispatcher.runDelay(item.stopClickAnim, item, 1)
end

function V3a8PuzzleView:_checkSuccessPutIn(item)
	local slotItem = self:_getNearSlot(item, true)

	if slotItem then
		self:_successPutIn(item, slotItem)
	else
		self:_failPutIn(item, slotItem)
	end
end

function V3a8PuzzleView:_successPutIn(item, slotItem)
	if not item or not slotItem then
		return
	end

	item.isSuccess = true
	slotItem.stoneIndex = item.index

	slotItem.refreshSlot()
	gohelper.addChildPosStay(slotItem.goStoneRoot, item.go)

	local nowAnchor = item.go.transform.anchoredPosition
	local anchor = Vector2.zero
	local time = Vector2.Distance(nowAnchor, Vector2(anchor.x, anchor.y)) * 0.001

	item.tweenId = ZProj.TweenHelper.DOAnchorPos(item.go.transform, 0, 0, time)

	gohelper.setAsFirstSibling(item.go)
	self:_checkAllSuccessPutIn()

	if self._gameType == GameType.Game1 then
		local dialogConstId

		if self._isPlayedDialogs[381002] and self._isPlayedDialogs[381003] and not self._isPlayedDialogs[381004] then
			dialogConstId = 381004
			self._isPlayedDialogs[381004] = true
		end

		if item.index == slotItem.index then
			if not self._isPlayedDialogs[381002] then
				dialogConstId = 381002
				self._isPlayedDialogs[381002] = true
			end
		else
			item.playAnim("error")
			AudioMgr.instance:trigger(AudioEnum3_8.Puzzle.play_ui_shiji_stone_shake_short)
			AudioMgr.instance:trigger(AudioEnum3_8.Puzzle.play_ui_mistakes)

			if not self._isPlayedDialogs[381003] then
				dialogConstId = 381003
				self._isPlayedDialogs[381003] = true
			end
		end

		if dialogConstId then
			self:_playDialogByConst(dialogConstId)
		end
	end

	if item.index == slotItem.index then
		slotItem.playAudioId = AudioMgr.instance:trigger(slotItem.audioId)
	end

	AudioMgr.instance:trigger(AudioEnum3_8.Puzzle.play_ui_qiutu_organ_sink)
end

function V3a8PuzzleView:_failPutIn(item, slotItem)
	gohelper.setActive(item.goRipple, false)

	local nearSlot = self:_getNearSlot(item)

	if nearSlot then
		item.playAnim("error")
		AudioMgr.instance:trigger(AudioEnum3_8.Puzzle.play_ui_shiji_stone_shake_short)
		TaskDispatcher.runDelay(item.returnPosFunc, item, 0.5)
	else
		item:returnPosFunc()
	end
end

function V3a8PuzzleView:_checkAllSuccessPutIn()
	for _, item in pairs(self._stoneItems) do
		if not item.isSuccess then
			return false
		end
	end

	if self._gameType == GameType.Game1 then
		for i, item in pairs(self._stoneItems) do
			item:playErrorAnim()
			TaskDispatcher.runRepeat(item.playErrorAnim, item, 0.35)
		end

		AudioMgr.instance:trigger(AudioEnum3_8.Puzzle.play_ui_shiji_stone_shake_long)
	end

	if self._gameType == GameType.Game1 then
		TaskDispatcher.runDelay(self._checkPlayNextStory, self, 2)
	else
		TaskDispatcher.runDelay(self._playSuccessDialog, self, 9)
		AudioMgr.instance:trigger(AudioEnum3_8.Puzzle.play_ui_shiji_stone_music)
	end

	TaskDispatcher.runDelay(self._onFinish, self, 0.5)

	self._gameSuccess = true

	AudioMgr.instance:trigger(AudioEnum3_8.Puzzle.play_ui_shiji_place_success)
	AudioMgr.instance:trigger(AudioEnum3_8.Puzzle.play_ui_lushang_level_complete)

	return true
end

function V3a8PuzzleView:_playSuccessDialog()
	local dialogConstId = 382002

	self:_playDialogByConst(dialogConstId)
end

function V3a8PuzzleView:_onFinish()
	self._bgAnim:Play("finish", 0, 0)
	gohelper.setActive(self._goComplete, true)

	for i, item in pairs(self._slotItems) do
		item.cancelPlayRepeat()
	end
end

function V3a8PuzzleView:onUpdateParam()
	return
end

function V3a8PuzzleView:_getConstValue(const)
	return V3a5PuzzleConfig.instance:getConstValue(const)
end

function V3a8PuzzleView:_playDialogByConst(constId)
	local value = self:_getConstValue(constId)

	self:startDialog(value)
end

function V3a8PuzzleView:onOpen()
	self._storyId = self.viewParam.storyId
	self._gameType = self:_getGameType()
	self._isPlayingAudioSlot = false
	self._isPlayedDialogs = {}

	local lang = self._gameType == GameType.Game1 and "v3a8_puzzleview_txt_title1" or "v3a8_puzzleview_txt_title2"

	self._txtTitleDesc.text = luaLang(lang)
	self._stoneambAudioId = AudioMgr.instance:trigger(AudioEnum3_8.Puzzle.play_ui_shiji_stoneamb_loop)
end

function V3a8PuzzleView:_getGameType()
	local constValue1 = self:_getConstValue(V3a5PuzzleEnum.ConstId.V3a8_PreStoryId_1)

	if constValue1 == self._storyId then
		return GameType.Game1
	end

	local constValue2 = self:_getConstValue(V3a5PuzzleEnum.ConstId.V3a8_PreStoryId_2)

	if constValue2 == self._storyId then
		return GameType.Game2
	end

	return GameType.Game1
end

function V3a8PuzzleView:_reallyPlaySlotsAudio(time)
	time = time or self._playSlotAudioTime

	self:_cancelPlaySlotAudio()

	if time == 0 then
		self:_playSlotsAudio()
	else
		TaskDispatcher.runDelay(self._playSlotsAudio, self, time)
	end
end

function V3a8PuzzleView:_playSlotsAudio()
	self._playAudioSlotIndex = 1
	self._isPlayingAudioSlot = true

	self:_playSlotItemAudio()
end

function V3a8PuzzleView:_playSlotItemAudio()
	local slotItem = self._slotItems[self._playAudioSlotIndex]

	if not slotItem then
		self._isPlayingAudioSlot = false

		self:_reallyPlaySlotsAudio()

		return
	end

	slotItem.playRepeat()
	TaskDispatcher.cancelTask(slotItem.stopAudio, slotItem)
	TaskDispatcher.runDelay(slotItem.stopAudio, slotItem, slotItem.audioTime)

	self._playAudioSlotIndex = self._playAudioSlotIndex + 1

	TaskDispatcher.cancelTask(self._playSlotItemAudio, self)
	TaskDispatcher.runDelay(self._playSlotItemAudio, self, slotItem.delayTime)
end

function V3a8PuzzleView:_checkPlayNextStory()
	TaskDispatcher.runDelay(self.closeThis, self, 1)
	V3a5PuzzleController.instance:playNextStoryByPreStoryId(self._storyId, self.viewParam.episodeId, self.viewParam.afterStory, self.viewName, self.closeThis, self)
end

function V3a8PuzzleView:_checkAfterStory()
	if self.viewParam.afterStory and self.viewParam.afterStory > 0 then
		-- block empty
	end

	self.closeThis()
end

function V3a8PuzzleView:startDialog(groupId)
	self.viewContainer:startDialog(groupId)
	self:_cancelPlaySlotAudio()
end

function V3a8PuzzleView:initDialogFinish()
	self:_playDialogByConst((self._gameType == GameType.Game2 or nil) and 382001)
end

function V3a8PuzzleView:finishDialog(groupId)
	if groupId == 382002 then
		self:_checkPlayNextStory()
	elseif groupId == 381001 then
		self:_reallyPlaySlotsAudio(0)
	else
		self:_reallyPlaySlotsAudio()
	end
end

function V3a8PuzzleView:_showDialog(isShow)
	return
end

function V3a8PuzzleView:onClose()
	if self._stoneambAudioId then
		AudioMgr.instance:stopPlayingID(self._stoneambAudioId)

		self._stoneambAudioId = nil
	end

	AudioMgr.instance:trigger(AudioEnum3_8.Puzzle.stop_ui_shiji_stoneamb_loop)
end

function V3a8PuzzleView:_cancelPlaySlotAudio()
	TaskDispatcher.cancelTask(self._playSlotItemAudio, self)
	TaskDispatcher.cancelTask(self._playSlotsAudio, self)

	self._isPlayingAudioSlot = false
end

function V3a8PuzzleView:onDestroyView()
	for _, item in pairs(self._stoneItems) do
		item.drag:RemoveDragBeginListener()
		item.drag:RemoveDragListener()
		item.drag:RemoveDragEndListener()
		item.click:RemoveClickListener()

		if item.tweenId then
			ZProj.TweenHelper.KillById(item.tweenId)

			item.tweenId = nil
		end

		TaskDispatcher.cancelTask(item.playErrorAnim, item)
		TaskDispatcher.cancelTask(item.returnPosFunc, item)
		TaskDispatcher.cancelTask(item.stopClickAnim, item)
	end

	TaskDispatcher.cancelTask(self._checkPlayNextStory, self)

	for i, item in pairs(self._slotItems) do
		TaskDispatcher.cancelTask(item.stopAudio, item)
		TaskDispatcher.cancelTask(item.cancelPlayRepeat, item)
		item.btnClick:RemoveClickListener()

		if item.playAudioId then
			AudioMgr.instance:stopPlayingID(item.playAudioId)
		end

		item.playAudioId = nil
	end

	TaskDispatcher.cancelTask(self._playSlotItemAudio, self)
	TaskDispatcher.cancelTask(self._playSlotsAudio, self)
	TaskDispatcher.cancelTask(self._onFinish, self)
	TaskDispatcher.cancelTask(self._playSuccessDialog, self)

	self._isPlayingAudioSlot = false
end

return V3a8PuzzleView
