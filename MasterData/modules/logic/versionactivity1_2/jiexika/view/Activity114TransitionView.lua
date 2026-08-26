-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114TransitionView.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114TransitionView", package.seeall)

local Activity114TransitionView = class("Activity114TransitionView", BaseView)

function Activity114TransitionView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._txtdes = gohelper.findChildTextMesh(self.viewGO, "#txt_des")
	self._btnclose = gohelper.findChildButton(self.viewGO, "#btn_close")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function Activity114TransitionView:addEvents()
	self._btnclose:AddClickListener(self._onClickClose, self)
end

function Activity114TransitionView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function Activity114TransitionView:onOpen()
	local str, _ = ""

	if self.viewParam.transitionId then
		_, str = Activity114Config.instance:getConstValue(Activity114Model.instance.id, self.viewParam.transitionId)
		self.viewParam.transitionId = nil
	elseif self.viewParam.type == Activity114Enum.EventType.Rest then
		_, str = Activity114Config.instance:getConstValue(Activity114Model.instance.id, Activity114Enum.ConstId["Rest" .. self.viewParam.result])
	else
		self.viewParam.answerIds = self.viewParam.answerIds or Activity114Model.instance.serverData.testIds
		_, str = Activity114Config.instance:getAnswerResult(Activity114Model.instance.id, self.viewParam.answerIds[1] or 1, self.viewParam.totalScore)
	end

	self._openDt = UnityEngine.Time.realtimeSinceStartup
	str = string.gsub(str, "▩(%d+)%%s", function(index)
		if index == "1" then
			return Activity114Helper.getNextKeyDayDesc(Activity114Model.instance.serverData.day)
		elseif index == "2" then
			return Activity114Helper.getNextKeyDayLeft(Activity114Model.instance.serverData.day)
		end

		return ""
	end)

	self._simagebg:LoadImage(ResUrl.getAct114Icon("transbg"))

	self._txtdes.text = str

	TaskDispatcher.runDelay(self.closeThis, self, 4)
end

function Activity114TransitionView:_onClickClose()
	if not self._openDt or UnityEngine.Time.realtimeSinceStartup - self._openDt < 1 then
		return
	end

	self._anim.enabled = false

	self:closeThis()
end

function Activity114TransitionView:onClose()
	TaskDispatcher.cancelTask(self.closeThis, self)
end

function Activity114TransitionView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return Activity114TransitionView
