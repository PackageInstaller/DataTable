-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jigsawcollect/view/JigsawcollectsourceView.lua

module("logic.extensions.jigsawcollect.view.JigsawcollectsourceView", package.seeall)

local JigsawcollectsourceView = class("JigsawcollectsourceView", TableViewComponent)

function JigsawcollectsourceView:ctor()
	JigsawcollectsourceView.super.ctor(self)
end

function JigsawcollectsourceView:buildUI()
	JigsawcollectsourceView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._txtChipNum = goutil.findChildTextComponent(self.mainGO, "chip/txtNum")
end

function JigsawcollectsourceView:bindEvents()
	JigsawcollectsourceView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
end

function JigsawcollectsourceView:unbindEvents()
	JigsawcollectsourceView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function JigsawcollectsourceView:destroyUI()
	JigsawcollectsourceView.super.destroyUI(self)
end

function JigsawcollectsourceView:onEnter()
	JigsawcollectsourceView.super.onEnter(self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._tickDailyRefresh, self)
	GlobalDispatcher:addListener(JigsawcollectController.PM_GainJigsawTaskPrizeRes, self._updateView, self)
	GlobalDispatcher:addListener(JigsawcollectController.PM_GetCurJigsawInfoRes, self._updateView, self)
	self:_updateView()
end

function JigsawcollectsourceView:onEnterFinished()
	JigsawcollectsourceView.super.onEnterFinished(self)
end

function JigsawcollectsourceView:onExit()
	JigsawcollectsourceView.super.onExit(self)
	removetimer(self._checkRefeshAct, self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._tickDailyRefresh, self)
	GlobalDispatcher:removeListener(JigsawcollectController.PM_GainJigsawTaskPrizeRes, self._updateView, self)
	GlobalDispatcher:removeListener(JigsawcollectController.PM_GetCurJigsawInfoRes, self._updateView, self)
end

function JigsawcollectsourceView:onExitFinished()
	JigsawcollectsourceView.super.onExitFinished(self)
end

function JigsawcollectsourceView:_onClickbtnClose()
	self:close()
end

function JigsawcollectsourceView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("jigsawcollectsourceview")
end

function JigsawcollectsourceView:_updateView()
	self._actId = JigsawcollectModel.instance:getActId()

	local cfg = JigsawcollectConfig.instance:getJigsawCfg(self._actId)

	if not cfg then
		return
	end

	local stime, etime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.JigsawCollect, self._actId)

	self._actEndTime = etime

	removetimer(self._checkRefeshAct, self)

	if self:_isActInTime() then
		self._refreshTime = self._actEndTime - ServerTime.now()

		settimer(1, self._checkRefeshAct, self, true)
		self:_checkRefeshAct()
	end

	local planCfgs = JigsawcollectConfig.instance:getTaskPlanCfgs(cfg.taskPlan)
	local taskInfos = JigsawcollectModel.instance:getTaskInfos()
	local days = JigsawcollectModel.instance:getActDays()
	local taskInfosKV = {}

	for i, v in ipairs(taskInfos) do
		taskInfosKV[v.taskId] = v
	end

	local cfgs = planCfgs[days]

	if not cfgs then
		printError("没有任务配置 id", self._actId, "days", days)

		return
	end

	local finishList = {}
	local needAchiceList = {}
	local notFinishList = {}

	for i, v in ipairs(cfgs) do
		if taskInfosKV[v.taskId] then
			if JigsawcollectModel.instance:checkTaskProgressRewardDot(self._actId, v.taskId) then
				table.insert(needAchiceList, {
					cfg = v,
					isAchieve = not taskInfosKV[v.taskId],
					taskInfo = taskInfosKV[v.taskId]
				})
			else
				table.insert(notFinishList, {
					cfg = v,
					isAchieve = not taskInfosKV[v.taskId],
					taskInfo = taskInfosKV[v.taskId]
				})
			end
		else
			table.insert(finishList, {
				cfg = v,
				isAchieve = not taskInfosKV[v.taskId],
				taskInfo = taskInfosKV[v.taskId]
			})
		end
	end

	self._curViewDatas = {}

	table.insertto(self._curViewDatas, needAchiceList)
	table.insertto(self._curViewDatas, notFinishList)
	table.insertto(self._curViewDatas, finishList)

	self._txtChipNum.text = JigsawcollectModel.instance:getTotalChipNum() .. "/" .. JigsawcollectModel.instance:getCurrActNeedChipNum()

	self:reloadData()
end

function JigsawcollectsourceView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function JigsawcollectsourceView:_cellSize(view, index)
	return 100, 100
end

function JigsawcollectsourceView:_updateCell(view, cell, data)
	local btnGotoGo = goutil.findChild(cell.gameObject, "btnGoto")
	local btnGoto = GameUtil.asBtn(btnGotoGo)
	local btnAchieveGo = goutil.findChild(cell.gameObject, "btnAchieve")
	local btnAchieve = GameUtil.asBtn(btnAchieveGo)
	local slider = Framework.SliderAdapter.GetFrom(cell.gameObject, "progres")
	local canGoto = not string.nilorempty(data.cfg.jumpTo)

	if not data.isAchieve then
		local canAchiece = data.cfg.progressReq <= data.taskInfo.taskProgress

		goutil.setActive(btnAchieveGo, canAchiece)
		goutil.setActive(btnGotoGo, not canAchiece and canGoto)

		if not self:_isActInTime() or JigsawcollectModel.instance:checkPieceEnough(self._actId) then
			goutil.setActive(btnAchieveGo, false)
			goutil.setActive(btnGotoGo, false)
		end
	else
		goutil.setActive(btnAchieveGo, false)
		goutil.setActive(btnGotoGo, false)
	end

	local txtTask = goutil.findChildTextComponent(cell.gameObject, "txtTask")
	local txtTaskDesc = goutil.findChildTextComponent(cell.gameObject, "txtTaskDesc")
	local txtProgress = goutil.findChildTextComponent(cell.gameObject, "txtProgress")

	txtTask.text = data.cfg.title
	txtTaskDesc.text = data.cfg.desc
	txtProgress.text = data.isAchieve and string.format("%s/%s", data.cfg.progressReq, data.cfg.progressReq) or string.format("%s/%s", data.taskInfo.taskProgress, data.cfg.progressReq)

	slider:SetValue(data.isAchieve and 1 or data.taskInfo.taskProgress / data.cfg.progressReq)
	btnGoto:AddClickListener(function()
		self:close()
		GotoMgr.gotoByString(data.cfg.jumpTo)
	end)
	btnAchieve:AddClickListener(function()
		JigsawAgent.instance:sendPM_GainJigsawTaskPrizeReq(self._actId, data.taskInfo.taskId)
	end)
end

function JigsawcollectsourceView:_clearTableview(cell)
	return
end

function JigsawcollectsourceView:_tickDailyRefresh()
	JigsawAgent.instance:sendPM_GetCurJigsawInfoReq()
end

function JigsawcollectsourceView:_isActInTime()
	return self._actEndTime > ServerTime.now()
end

function JigsawcollectsourceView:_checkRefeshAct()
	if self._actEndTime then
		self._actEndTime = self._actEndTime - 1

		if self._actEndTime <= 0 then
			removetimer(self._checkRefeshAct, self)
			self:reloadData()

			return
		end
	else
		removetimer(self._checkRefeshAct, self)
	end
end

return JigsawcollectsourceView
