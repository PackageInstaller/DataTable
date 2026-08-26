-- chunkname: @modules/logic/versionactivity2_4/warmup/view/V2a4_WarmUpDialogueItemBase_LR.lua

module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUpDialogueItemBase_LR", package.seeall)

local V2a4_WarmUpDialogueItemBase_LR = class("V2a4_WarmUpDialogueItemBase_LR", V2a4_WarmUpDialogueItemBase)
local csAnimatorPlayer = SLFramework.AnimatorPlayer

function V2a4_WarmUpDialogueItemBase_LR:ctor(...)
	V2a4_WarmUpDialogueItemBase_LR.super.ctor(self, ...)
end

function V2a4_WarmUpDialogueItemBase_LR:_editableInitView()
	V2a4_WarmUpDialogueItemBase_LR.super._editableInitView(self)

	self._bgGo = gohelper.findChild(self.viewGO, "content_bg")
	self._bgTrans = self._bgGo.transform
	self._txtGo = self._txtcontent.gameObject
	self._txtTrans = self._txtGo.transform
	self._oriTxtWidth = recthelper.getWidth(self._txtTrans)
	self._oriTxtHeight = recthelper.getHeight(self._txtTrans)
	self._oriBgWidth = recthelper.getWidth(self._bgTrans)
	self._oriBgHeight = recthelper.getHeight(self._bgTrans)
	self._animPlayer = csAnimatorPlayer.Get(self.viewGO)

	self:setActive_loading(false)
end

function V2a4_WarmUpDialogueItemBase_LR:setActive_loading(isActive)
	gohelper.setActive(self._goloading, isActive)
end

function V2a4_WarmUpDialogueItemBase_LR:setData(mo)
	V2a4_WarmUpDialogueItemBase_LR.super.setData(self, mo)
	self:_openAnim()

	local dialogCO = mo.dialogCO
	local str = V2a4_WarmUpConfig.instance:getDialogDesc(dialogCO)

	self:setText(str)
	self:typing(str)
end

function V2a4_WarmUpDialogueItemBase_LR:onFlush()
	if self._isFlushed then
		return
	end

	self._isFlushed = true

	TaskDispatcher.cancelTask(self.onFlush, self)
	FrameTimerController.onDestroyViewMember(self, "_fTimerLoading")
	self:setActive_loading(false)
	self:setActive_Txt(true)

	if self:isReadyStepEnd() then
		self:stepEnd()
	end
end

function V2a4_WarmUpDialogueItemBase_LR:_typingStartDelayTimer()
	TaskDispatcher.runDelay(self.onFlush, self, V2a4_WarmUpConfig.instance:getSentenceInBetweenSec())
end

function V2a4_WarmUpDialogueItemBase_LR:_typingStartFrameTimer(str)
	local frameCount = math.random(1, GameUtil.clamp(#str, 60, 120) * V2a4_WarmUpConfig.instance:getSentenceInBetweenSec())

	FrameTimerController.onDestroyViewMember(self, "_fTimerLoading")

	self._fTimerLoading = FrameTimerController.instance:register(function()
		if not gohelper.isNil(self._txtGo) then
			self:onFlush()
		end
	end, frameCount, 1)

	self._fTimerLoading:Start()
end

local kTypingWidth = 155

function V2a4_WarmUpDialogueItemBase_LR:typing(str)
	recthelper.setSize(self._bgTrans, kTypingWidth, self._oriBgHeight)
	self:addContentItem(self._oriBgHeight)
	self:setActive_loading(true)
	self:_typingStartDelayTimer()
end

function V2a4_WarmUpDialogueItemBase_LR:onDestroyView()
	TaskDispatcher.cancelTask(self.onFlush, self)
	GameUtil.onDestroyViewMember(self, "_tmpFadeInWithScroll")
	FrameTimerController.onDestroyViewMember(self, "_fTimerLoading")
	V2a4_WarmUpDialogueItemBase_LR.super.onDestroyView(self)
end

function V2a4_WarmUpDialogueItemBase_LR:onRefreshLineInfo()
	local curTxtWidth = self:preferredWidthTxt()
	local curTxtHeight = self:preferredHeightTxt()
	local curBgWidth = self._oriBgWidth
	local curBgHeight = self._oriBgHeight

	if curTxtWidth <= self._oriTxtWidth then
		curBgWidth = curBgWidth + (curTxtWidth - self._oriTxtWidth)
	else
		curTxtWidth = self._oriTxtWidth
		curBgHeight = curBgHeight + (curTxtHeight - self._oriTxtHeight)
	end

	self._curTxtWidth = curTxtWidth
	self._curTxtHeight = curTxtHeight
	self._curBgWidth = curBgWidth
	self._curBgHeight = curBgHeight

	if self._isFlushed then
		self:stepEnd()
	end
end

function V2a4_WarmUpDialogueItemBase_LR:stepEnd()
	recthelper.setSize(self._txtTrans, self._curTxtWidth, self._curTxtHeight)
	recthelper.setSize(self._bgTrans, self._curBgWidth, self._curBgHeight)
	self:addContentItem(self._curBgHeight)
	V2a4_WarmUpDialogueItemBase_LR.super.stepEnd(self)
end

function V2a4_WarmUpDialogueItemBase_LR:setGray(isGray)
	self:grayscale(isGray, self._txtGo, self._bgGo)
end

function V2a4_WarmUpDialogueItemBase_LR:_openAnim(cb, cbObj)
	self._animPlayer:Play(UIAnimationName.Open, cb, cbObj)
end

return V2a4_WarmUpDialogueItemBase_LR
