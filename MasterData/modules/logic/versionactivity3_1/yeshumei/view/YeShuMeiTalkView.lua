-- chunkname: @modules/logic/versionactivity3_1/yeshumei/view/YeShuMeiTalkView.lua

module("modules.logic.versionactivity3_1.yeshumei.view.YeShuMeiTalkView", package.seeall)

local YeShuMeiTalkView = class("YeShuMeiTalkView", BaseView)

function YeShuMeiTalkView:onInitView()
	self._godialog = gohelper.findChild(self.viewGO, "#go_dialog")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_dialog/#btn_close")
	self._rootTrans = gohelper.findChild(self.viewGO, "#go_dialog/root").transform
	self._desc = gohelper.findChildTextMesh(self.viewGO, "#go_dialog/root/Scroll View/Viewport/Content/txt_talk")
	self._headIcon = gohelper.findChildSingleImage(self.viewGO, "#go_dialog/root/Head/#simage_Head")
	self._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(self._desc.gameObject, FixTmpBreakLine)
end

function YeShuMeiTalkView:addEvents()
	self._btnclose:AddClickListener(self._onClickNext, self)
	self.addEventCb(self, PuzzleMazeDrawController.instance, PuzzleEvent.OnStartDialog, self._onStartDialog, self)
end

function YeShuMeiTalkView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function YeShuMeiTalkView:onOpen()
	return
end

function YeShuMeiTalkView:_onStartDialog(params)
	self._steps = params and params.co
	self._dialogPosX = params and params.dialogPosX
	self._dialogPosY = params and params.dialogPosY
	self._stepIndex = 0

	gohelper.setActive(self._godialog, true)
	self:_setDialogPosition()
	self:_nextStep()
end

function YeShuMeiTalkView:_setDialogPosition()
	recthelper.setAnchor(self._rootTrans, self._dialogPosX or 0, self._dialogPosY or 0)
end

function YeShuMeiTalkView:_onClickNext()
	local totalLen = #self._charArr

	if totalLen > 5 and self._curShowCount < 5 then
		return
	end

	if totalLen == self._curShowCount then
		self:_nextStep()
	else
		self._curShowCount = totalLen - 1

		self:_showNextChar()
		TaskDispatcher.cancelTask(self._showNextChar, self)
	end
end

function YeShuMeiTalkView:_nextStep()
	self._stepIndex = self._stepIndex + 1

	local curStepCo = self._steps[self._stepIndex]

	if not curStepCo then
		self:onDialogFinished()

		return
	end

	self._curShowCount = 0
	self._charArr = GameUtil.getUCharArrWithoutRichTxt(curStepCo.content)

	if not string.nilorempty(curStepCo.icon) then
		self._curHeadIcon = curStepCo.icon
	end

	if self._curHeadIcon then
		self._headIcon:LoadImage(ResUrl.getHeadIconSmall(self._curHeadIcon))
	end

	if #self._charArr <= 1 then
		self._desc.text = ""

		recthelper.setHeight(self._rootTrans, 111)

		return
	end

	TaskDispatcher.runRepeat(self._showNextChar, self, 0.05, #self._charArr - 1)
	self:_showNextChar()
end

function YeShuMeiTalkView:_showNextChar()
	self._curShowCount = self._curShowCount + 1
	self._desc.text = table.concat(self._charArr, "", 1, self._curShowCount)

	local preferredHeight = self._desc.preferredHeight

	self._fixTmpBreakLine:refreshTmpContent(self._desc)
	recthelper.setHeight(self._rootTrans, math.max(111, preferredHeight + 40))
end

function YeShuMeiTalkView:onDialogFinished()
	TaskDispatcher.cancelTask(self._showNextChar, self)
	gohelper.setActive(self._godialog, false)
	PuzzleMazeDrawController.instance:dispatchEvent(PuzzleEvent.OnFinishDialog)
end

function YeShuMeiTalkView:onClose()
	self._headIcon:UnLoadImage()
	TaskDispatcher.cancelTask(self._showNextChar, self)
end

return YeShuMeiTalkView
