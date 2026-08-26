-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114DiceView.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114DiceView", package.seeall)

local Activity114DiceView = class("Activity114DiceView", BaseView)

function Activity114DiceView:onInitView()
	self._txtneedNum = gohelper.findChildText(self.viewGO, "throw/#txt_needNum")
	self._txtdiceNum1 = gohelper.findChildText(self.viewGO, "dice1/#txt_diceNum")
	self._txtdiceNum2 = gohelper.findChildText(self.viewGO, "dice2/#txt_diceNum")
	self._imageresult = gohelper.findChildImage(self.viewGO, "throw/#image_result")
	self._txtdotip = gohelper.findChildText(self.viewGO, "#go_doing/#txt_dotip")
	self._gosucc = gohelper.findChild(self.viewGO, "#go_succ")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._godoing = gohelper.findChild(self.viewGO, "#go_doing")
	self._btnclose = gohelper.findChildClickWithAudio(self.viewGO, "#btn_close")
	self._gogreaterIcon = gohelper.findChild(self.viewGO, "throw/#go_greaterIcon")
	self._goequalIcon = gohelper.findChild(self.viewGO, "throw/#go_equalIcon")
	self._golessIcon = gohelper.findChild(self.viewGO, "throw/#go_lessIcon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity114DiceView:addEvents()
	self._btnclose:AddClickListener(self.onCloseClick, self)
end

function Activity114DiceView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function Activity114DiceView:onOpen()
	StoryController.instance:dispatchEvent(StoryEvent.HideDialog)

	self._txtdotip.text = luaLang("versionactivity_1_2_114diceview_doing")
	self.isDone = false
	self._txtneedNum.text = self.viewParam.realVerify

	gohelper.setActive(self._imageresult.gameObject, false)
	recthelper.setAnchorX(self._txtdotip.transform, 17.1)
	TaskDispatcher.runRepeat(self.everyFrame, self, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_dice)
	gohelper.setActive(self._godoing, true)
	gohelper.setActive(self._gosucc, false)
	gohelper.setActive(self._gofail, false)
	gohelper.setActive(self._golessIcon, false)
	gohelper.setActive(self._goequalIcon, false)
	gohelper.setActive(self._gogreaterIcon, false)
	TaskDispatcher.runDelay(self.onDone, self, 2)
end

function Activity114DiceView:everyFrame()
	self._txtdiceNum1.text = math.random(1, 6)
	self._txtdiceNum2.text = math.random(1, 6)
end

function Activity114DiceView:onDone()
	TaskDispatcher.cancelTask(self.everyFrame, self)
	TaskDispatcher.cancelTask(self.onDone, self)

	local result = self.viewParam.diceResult

	self._txtdiceNum1.text = result[1]
	self._txtdiceNum2.text = result[2]

	recthelper.setAnchorX(self._txtdotip.transform, 1.3)

	self._txtdotip.text = luaLang("versionactivity_1_2_114diceview_finish")

	TaskDispatcher.runDelay(self.showResult, self, 0)
end

function Activity114DiceView:showResult()
	self.isDone = true

	local needNum = self.viewParam.realVerify
	local result = self.viewParam.diceResult
	local isSucc = self.viewParam.result == Activity114Enum.Result.Success

	if isSucc then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_win)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_lose)
	end

	gohelper.setActive(self._imageresult.gameObject, true)
	gohelper.setActive(self._godoing, false)
	gohelper.setActive(self._gosucc, isSucc)
	gohelper.setActive(self._gofail, not isSucc)

	local resultValue = result[1] + result[2]
	local resultImgName = (isSucc and "succ_" or "img_") .. resultValue

	gohelper.setActive(self._golessIcon, resultValue < needNum)
	gohelper.setActive(self._goequalIcon, resultValue == needNum)
	gohelper.setActive(self._gogreaterIcon, needNum < resultValue)
	UISpriteSetMgr.instance:setVersionActivity114Sprite(self._imageresult, resultImgName, true)
end

function Activity114DiceView:onCloseClick()
	if self:isRunning() then
		return
	end

	self:closeThis()
end

function Activity114DiceView:onClose()
	TaskDispatcher.cancelTask(self.showResult, self)
	TaskDispatcher.cancelTask(self.onDone, self)
end

function Activity114DiceView:isRunning()
	return not self.isDone
end

function Activity114DiceView:onDestroyView()
	TaskDispatcher.cancelTask(self.everyFrame, self)
end

return Activity114DiceView
