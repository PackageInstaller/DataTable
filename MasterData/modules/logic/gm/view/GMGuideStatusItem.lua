-- chunkname: @modules/logic/gm/view/GMGuideStatusItem.lua

module("modules.logic.gm.view.GMGuideStatusItem", package.seeall)

local GMGuideStatusItem = class("GMGuideStatusItem", ListScrollCell)

function GMGuideStatusItem:init(go)
	self._guideCO = nil
	self._txtGuideId = gohelper.findChildText(go, "txtGuideId")
	self._txtClientStep = gohelper.findChildText(go, "txtClientStep")
	self._txtServerStep = gohelper.findChildText(go, "txtServerStep")
	self._txtExecStep = gohelper.findChildText(go, "txtExecStep")
	self._txtStatus = gohelper.findChildText(go, "txtStatus")
	self._btnRestart = gohelper.findChildButtonWithAudio(go, "btnRestart")
	self._btnFinish = gohelper.findChildButtonWithAudio(go, "btnFinish")
	self._btnDel = gohelper.findChildButtonWithAudio(go, "btnDel")
	self._clickGuideId = gohelper.getClick(self._txtGuideId.gameObject)

	self._btnRestart:AddClickListener(self._onClickRestart, self)
	self._btnFinish:AddClickListener(self._onClickFinish, self)
	self._btnDel:AddClickListener(self._onClickDel, self)
	self._clickGuideId:AddClickListener(self._onClickGuideId, self)
end

function GMGuideStatusItem:onUpdateMO(mo)
	self._guideId = mo.id
	self._guideCO = mo

	local guideMO = GuideModel.instance:getById(self._guideCO.id)

	self._txtGuideId.text = self._guideCO.id

	if guideMO then
		self._txtClientStep.text = guideMO.clientStepId
		self._txtServerStep.text = guideMO.serverStepId
		self._txtExecStep.text = (guideMO.currGuideId == -1 or guideMO.currGuideId == self._guideCO) and guideMO.currStepId or guideMO.currGuideId .. "_" .. guideMO.currStepId
		self._txtStatus.text = guideMO.serverStepId == -1 and (guideMO.isExceptionFinish and "<color=#FF0000>异常终止</color>" or guideMO.clientStepId == -1 and "<color=#00DD00>已完成</color>" or "<color=#00DD00>前端收尾ing</color>") or guideMO.currGuideId == self._guideCO.id and (ViewMgr.instance:isOpen(ViewName.GuideView) and (GuideViewMgr.instance.guideId == guideMO.currGuideId and GuideViewMgr.instance.stepId == guideMO.currrStepId and "<color=#EA00B3>指引点击ing</color>" or "<color=#EA00B3>执行ing</color>") or "<color=#EA00B3>执行ing</color>") or "<color=#EA00B3>中断重来ing</color>"
	else
		self._txtClientStep.text = ""
		self._txtServerStep.text = ""
		self._txtExecStep.text = ""
		self._txtStatus.text = "<color=#444444>未接取</color>"
	end

	gohelper.setActive(self._btnRestart.gameObject, GMGuideStatusModel.instance.showOpBtn)
	gohelper.setActive(self._btnFinish.gameObject, GMGuideStatusModel.instance.showOpBtn)
	gohelper.setActive(self._btnDel.gameObject, GMGuideStatusModel.instance.showOpBtn)
end

function GMGuideStatusItem:_onClickDel()
	local guideId = self._guideCO.id
	local guideMO = GuideModel.instance:getById(guideId)

	if not guideMO then
		return
	end

	GMRpc.instance:sendGMRequest("delete guide " .. guideId)
	GuideStepController.instance:clearFlow(guideId)
	GuideModel.instance:remove(GuideModel.instance:getById(guideId))
end

function GMGuideStatusItem:_onClickFinish()
	local guideId = self._guideCO.id
	local guideMO = GuideModel.instance:getById(guideId)

	if not guideMO then
		return
	end

	local stepList = GuideConfig.instance:getStepList(guideId)

	for j = #stepList, 1, -1 do
		local stepCO = stepList[j]

		if stepCO.keyStep == 1 then
			GuideRpc.instance:sendFinishGuideRequest(guideId, stepCO.stepId)

			break
		end
	end

	guideMO.isJumpPass = true

	GuideStepController.instance:clearFlow(guideId)
end

function GMGuideStatusItem:_onClickRestart()
	local guideId = self._guideCO.id
	local guideStep = 0
	local guideMO = GuideModel.instance:getById(guideId)

	GuideModel.instance:gmStartGuide(guideId, guideStep)

	if guideMO then
		GuideStepController.instance:clearFlow(guideId)

		guideMO.isJumpPass = false

		GMRpc.instance:sendGMRequest("delete guide " .. guideId)
		GuideRpc.instance:sendFinishGuideRequest(guideId, guideStep)
	elseif guideId then
		GuideController.instance:startGudie(guideId)
	end
end

function GMGuideStatusItem:_onClickGuideId()
	GameFacade.showToast(ToastEnum.IconId, self._guideCO.desc)
	logNormal(self._guideCO.id .. ":" .. self._guideCO.desc)
end

function GMGuideStatusItem:onDestroy()
	self._btnRestart:RemoveClickListener()
	self._btnFinish:RemoveClickListener()
	self._btnDel:RemoveClickListener()
	self._clickGuideId:RemoveClickListener()
end

return GMGuideStatusItem
