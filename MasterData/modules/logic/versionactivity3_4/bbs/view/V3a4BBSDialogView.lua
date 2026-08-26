-- chunkname: @modules/logic/versionactivity3_4/bbs/view/V3a4BBSDialogView.lua

module("modules.logic.versionactivity3_4.bbs.view.V3a4BBSDialogView", package.seeall)

local V3a4BBSDialogView = class("V3a4BBSDialogView", LuaCompBase)

function V3a4BBSDialogView:init(go)
	self._godialogcontainer = go
	self._godialog = gohelper.findChild(go, "#go_dialog")
	self._gocontainer = gohelper.findChild(self._godialog, "container")
	self._simageicon = gohelper.findChildSingleImage(self._godialog, "container/headframe/headicon")
	self._goframe = gohelper.findChild(self._godialog, "container/headframe")
	self._goNormalContent = gohelper.findChild(self._godialog, "container/go_normalcontent")
	self._txtdialog = gohelper.findChildText(self._godialog, "container/go_normalcontent/txt_contentcn")
	self._simagebg = gohelper.findChildSingleImage(self._godialog, "container/simagebg")
	self._canvasGroup = self._gocontainer:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._click = gohelper.getClick(self._godialogcontainer)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a4BBSDialogView:addEventListeners()
	self._click:AddClickListener(self._onClickThis, self)
end

function V3a4BBSDialogView:removeEventListeners()
	self._click:RemoveClickListener()
end

function V3a4BBSDialogView:_onClickThis()
	local step = self._co.step
	local co = self._coList[step + 1]

	if co then
		self._co = co

		self:_playDialogStep()
	else
		V3a4BBSController.instance:dispatchEvent(V3a4BBSEvent.onFinishDialog)
		gohelper.setActive(self._godialogcontainer, false)
	end
end

function V3a4BBSDialogView:_editableInitView()
	self._dialogItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._godialog, FightViewDialogItem, self)
end

function V3a4BBSDialogView:playDialog(id)
	self._coList = V3a4BBSConfig.instance:getBBSDialogCoListById(id)
	self._co = self._coList[1]

	self:_playDialogStep()
end

function V3a4BBSDialogView:_playDialogStep()
	if self._co.delay and self._co.delay > 0 then
		TaskDispatcher.runDelay(self._playDialogItem, self, self._co.delay)
	else
		self:_playDialogItem()
	end
end

function V3a4BBSDialogView:_playDialogItem()
	gohelper.setActive(self._godialogcontainer, true)

	local icon

	self._dialogItem:showDialogContent((not string.nilorempty(self._co.icon) or nil) and ResUrl.getHeadIconSmall(self._co.icon), self._co)

	if self._co.audioId and self._co.audioId ~= 0 then
		self._audioId = self._co.audioId

		local isPlaying = AudioEffectMgr.instance:isPlaying(self._audioId)

		if isPlaying then
			AudioEffectMgr.instance:stopAudio(self._audioId)
		end

		AudioEffectMgr.instance:playAudio(self._audioId)
	end
end

function V3a4BBSDialogView:onDestroy()
	TaskDispatcher.cancelTask(self._playDialogItem, self)
end

return V3a4BBSDialogView
