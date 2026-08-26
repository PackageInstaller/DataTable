-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/view/ZhiXinQuanErTalkView.lua

module("modules.logic.versionactivity2_3.zhixinquaner.view.ZhiXinQuanErTalkView", package.seeall)

local ZhiXinQuanErTalkView = class("ZhiXinQuanErTalkView", BaseView)

function ZhiXinQuanErTalkView:onInitView()
	self._godialog = gohelper.findChild(self.viewGO, "#go_dialog")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_dialog/#btn_close")
	self._rootTrans = gohelper.findChild(self.viewGO, "#go_dialog/root").transform
	self._desc = gohelper.findChildTextMesh(self.viewGO, "#go_dialog/root/Scroll View/Viewport/Content/txt_talk")
	self._headIcon = gohelper.findChildSingleImage(self.viewGO, "#go_dialog/root/Head/#simage_Head")
	self._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(self._desc.gameObject, FixTmpBreakLine)
end

function ZhiXinQuanErTalkView:addEvents()
	self._btnclose:AddClickListener(self._onClickNext, self)
	self.addEventCb(self, PuzzleMazeDrawController.instance, PuzzleEvent.OnStartDialog, self._onStartDialog, self)
end

function ZhiXinQuanErTalkView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function ZhiXinQuanErTalkView:onOpen()
	return
end

function ZhiXinQuanErTalkView:_onStartDialog(params)
	self._steps = params and params.co
	self._dialogPosX = params and params.dialogPosX
	self._dialogPosY = params and params.dialogPosY
	self._stepIndex = 0

	gohelper.setActive(self._godialog, true)
	self:_setDialogPosition()
	self:_nextStep()
end

function ZhiXinQuanErTalkView:_setDialogPosition()
	recthelper.setAnchor(self._rootTrans, self._dialogPosX or 0, self._dialogPosY or 0)
end

function ZhiXinQuanErTalkView:_onClickNext()
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

function ZhiXinQuanErTalkView:_nextStep()
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

function ZhiXinQuanErTalkView:_showNextChar()
	self._curShowCount = self._curShowCount + 1
	self._desc.text = table.concat(self._charArr, "", 1, self._curShowCount)

	local preferredHeight = self._desc.preferredHeight

	self._fixTmpBreakLine:refreshTmpContent(self._desc)
	recthelper.setHeight(self._rootTrans, math.max(111, preferredHeight + 40))
end

function ZhiXinQuanErTalkView:onDialogFinished()
	TaskDispatcher.cancelTask(self._showNextChar, self)
	gohelper.setActive(self._godialog, false)
	PuzzleMazeDrawController.instance:dispatchEvent(PuzzleEvent.OnFinishDialog)
end

function ZhiXinQuanErTalkView:onClose()
	self._headIcon:UnLoadImage()
	TaskDispatcher.cancelTask(self._showNextChar, self)
end

return ZhiXinQuanErTalkView
