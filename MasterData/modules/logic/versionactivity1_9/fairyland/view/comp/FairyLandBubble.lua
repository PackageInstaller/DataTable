-- chunkname: @modules/logic/versionactivity1_9/fairyland/view/comp/FairyLandBubble.lua

module("modules.logic.versionactivity1_9.fairyland.view.comp.FairyLandBubble", package.seeall)

local FairyLandBubble = class("FairyLandBubble", UserDataDispose)

function FairyLandBubble:init(dialogView)
	self:__onInit()

	self.dialogView = dialogView
	self._go = gohelper.findChild(dialogView.dialogGO, "#go_Dialog")
	self.btnDialogClick = gohelper.findChildButtonWithAudio(self._go, "#go_Click")
	self.goBubbleLeft = gohelper.findChild(self._go, "#go_BubbleLeft")
	self.goBubbleRight = gohelper.findChild(self._go, "#go_BubbleRight")

	gohelper.setActive(self.goBubbleLeft, false)
	gohelper.setActive(self.goBubbleRight, false)
	self.addClickCb(self, self.btnDialogClick, self.onClickDialog, self)

	self.bubbleItems = {}
end

function FairyLandBubble:onClickDialog()
	if not self.dialogId then
		return
	end

	if self.isPlaying then
		self:showDialogText()
	elseif self.canNext then
		self:playNextStep()
	end
end

function FairyLandBubble:startDialog(param)
	self.dialogId = param.dialogId
	self.leftElement = param.leftElement
	self.rightElement = param.rightElement
	self.noTweenText = param.noTween

	gohelper.setActive(self._go, true)
	self:selectOption(0)
end

function FairyLandBubble:selectOption(sectionId)
	self.sectionId = sectionId
	self.step = 0
	self.sectionConfig = FairyLandConfig.instance:getDialogConfig(self.dialogId, self.sectionId)

	if self.sectionConfig then
		self:playNextStep()
	else
		self:finished()
	end
end

function FairyLandBubble:playNextStep()
	self.step = self.step + 1

	local stepConfig = self.sectionConfig[self.step]

	if not stepConfig then
		self:finished()

		return
	end

	self.canNext = false

	TaskDispatcher.cancelTask(self._delayFlag, self)
	TaskDispatcher.runDelay(self._delayFlag, self, 1)
	self:playStep(stepConfig, true)
end

function FairyLandBubble:playStep(stepConfig, tween)
	local item = stepConfig.elementId == 1 and self:getLeftItem() or self:getRightItem()

	self.isPlaying = true

	local hasNext = self.sectionConfig[self.step + 1] ~= nil

	if stepConfig.elementId == 1 then
		if not self.leftElement then
			local targetElement = self.rightElement

			if targetElement then
				targetElement:playDialog()
			end

			item:setTargetGO(targetElement and targetElement.imgChessRoot)

			if tween then
				self:playAudio(stepConfig.audioId)
			end

			if self.noTweenText then
				tween = false
			end

			item:showBubble(stepConfig.content, tween, hasNext)

			local otherItem = stepConfig.elementId == 1 and self:getRightItem() or self:getLeftItem()

			if otherItem then
				otherItem:hide()
			end
		end
	end
end

function FairyLandBubble:_delayFlag()
	self.canNext = true
end

function FairyLandBubble:showDialogText()
	local stepConfig = self.sectionConfig[self.step]

	if not stepConfig then
		self:finished()

		return
	end

	self:playStep(stepConfig)
end

function FairyLandBubble:onTextPlayFinish()
	self.isPlaying = false
end

function FairyLandBubble:finished()
	self.dialogId = nil
	self.isPlaying = false

	self.dialogView:finished()
end

function FairyLandBubble:getLeftItem()
	if not self.leftItem then
		self.leftItem = FairyLandBubbleTalkItem.New()

		self.leftItem:init(self.goBubbleLeft, self)
	end

	return self.leftItem
end

function FairyLandBubble:getRightItem()
	if not self.rightItem then
		self.rightItem = FairyLandBubbleTalkItem.New()

		self.rightItem:init(self.goBubbleRight, self)
	end

	return self.rightItem
end

function FairyLandBubble:hide()
	TaskDispatcher.cancelTask(self._delayFlag, self)
	self:stopAudio()
	gohelper.setActive(self._go, false)

	if self.leftItem then
		self.leftItem:hide()
	end

	if self.rightItem then
		self.rightItem:hide()
	end
end

function FairyLandBubble:playAudio(audioId)
	self:stopAudio()

	if audioId and audioId > 0 then
		self.playingId = AudioMgr.instance:trigger(audioId)
	end
end

function FairyLandBubble:stopAudio()
	if self.playingId then
		AudioMgr.instance:stopPlayingID(self.playingId)

		self.playingId = nil
	end
end

function FairyLandBubble:dispose()
	TaskDispatcher.cancelTask(self._delayFlag, self)
	self:stopAudio()

	if self.leftItem then
		self.leftItem:dispose()
	end

	if self.rightItem then
		self.rightItem:dispose()
	end

	self:__onDispose()
end

return FairyLandBubble
