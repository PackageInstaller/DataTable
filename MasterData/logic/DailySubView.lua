-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/reward/DailySubView.lua

module("logic.extensions.scuffle.view.reward.DailySubView", package.seeall)

local DailySubView = class("DailySubView", TableViewComponent)

function DailySubView:buildUI(parentGo)
	self.mainGO = parentGo

	DailySubView.super.buildUI(self)
end

function DailySubView:bindEvents()
	DailySubView.super.bindEvents(self)
end

function DailySubView:unbindEvents()
	DailySubView.super.unbindEvents(self)
end

function DailySubView:onEnter()
	DailySubView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.SF_DailyTaskInfoRes, self._onDailyTaskInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.SF_GainDailyTaskRes, self._onGainDailyTaskRes, self)

	self._isFirst = true
	self._curSeasonId = ScuffleController.instance:getCurSeasonId()

	ScuffleAgent.instance:sendSF_DailyTaskInfoReq()
end

function DailySubView:onExit()
	DailySubView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SF_DailyTaskInfoRes, self._onDailyTaskInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.SF_GainDailyTaskRes, self._onGainDailyTaskRes, self)

	self._isFirst = false
end

function DailySubView:show()
	self.mainGO:SetActive(true)
end

function DailySubView:hide()
	self.mainGO:SetActive(false)
end

function DailySubView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "tableview"
	}
end

function DailySubView:_updateCell(view, cell, data)
	local txtTitle = goutil.findChildTextComponent(cell, "txtTitle")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local txtProgress = goutil.findChildTextComponent(cell, "progress/txtProgress")
	local goContent = goutil.findChild(cell, "tableview/viewport/content")
	local goProgress = goutil.findChild(cell, "progress")
	local btnCanGet = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnCanGet")
	local goPass = goutil.findChild(cell, "passed")

	btnCanGet:AddClickListener(function()
		ScuffleController.instance:sendSF_GainDailyTaskReq(data.taskId)
	end)

	local cfg = ScuffleConfig.instance:getTaskCfg(self._curSeasonId, data.taskId)

	if not cfg then
		return
	end

	txtTitle.text = cfg.title
	txtDesc.text = cfg.desc

	local arrProxy = MaterialMgr.setCellListByCfg(cfg.prize, goContent)

	for i, v in ipairs(arrProxy) do
		Framework.TransformUtil.SetLocalScale(v.view.transform, 0.7, 0.7, 0.7)
	end

	local curProgress = data.progress
	local totalProgress = cfg.progress
	local formatStr = curProgress < totalProgress and "<color=#EB4642>%d</color>/%d" or "%d/%d"

	txtProgress.text = string.format(formatStr, curProgress, totalProgress)

	goutil.setActive(goProgress, curProgress < totalProgress and not data.prizeGained)
	goutil.setActive(btnCanGet.gameObject, totalProgress <= curProgress and not data.prizeGained)
	goutil.setActive(goPass, totalProgress <= curProgress and data.prizeGained)
end

function DailySubView:_clearTableview(cell)
	local btnCanGet = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnCanGet")
	local goContent = goutil.findChild(cell, "tableview/viewport/content")

	btnCanGet:RemoveClickListener()
	MaterialMgr.resetAll(goContent)
end

function DailySubView:_onDailyTaskInfoRes()
	if self._isFirst then
		self._isFirst = false

		self:_updateDailyTaskList()
	end
end

function DailySubView:_onGainDailyTaskRes()
	self:_updateDailyTaskList()
end

function DailySubView:_updateDailyTaskList()
	local list = ScuffleModel.instance:getDailyTaskList()

	self:updateListData(list)
end

return DailySubView
