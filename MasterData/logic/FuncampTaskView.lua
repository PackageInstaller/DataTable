-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/FuncampTaskView.lua

module("logic.extensions.funcamp.view.FuncampTaskView", package.seeall)

local FuncampTaskView = class("FuncampTaskView", ViewComponent)

function FuncampTaskView:ctor()
	FuncampTaskView.super.ctor(self)

	self._rewardScrollList = {}
end

function FuncampTaskView:unbindEvents()
	FuncampTaskView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function FuncampTaskView:bindEvents()
	FuncampTaskView.super.bindEvents(self)
	self._closeBtn:AddClickListener(function()
		self:close()
	end, self)
end

function FuncampTaskView:onExit()
	FuncampTaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FunCampTaskRes, self._setTaskInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.FunCampGetTaskRes, self._refreshTaskInfo, self)

	self._rewardScrollList = {}
end

function FuncampTaskView:buildUI()
	FuncampTaskView.super.buildUI(self)

	self._goldBarCon = self:getGo("goldBarCon")
	self._tableCell = self:getGo("rightScrollGo/taskItem")
	self._tableList = self:getGo("rightScrollGo/taskItemSR")
	self._closeBtn = self:getBtn("closeBtn")
	self._tableScroll = ScrollerList.create(self._tableList, self._tableCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function FuncampTaskView:onEnter()
	FuncampTaskView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.FunCampTaskRes, self._setTaskInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.FunCampGetTaskRes, self._refreshTaskInfo, self)

	self._curActId = FunCampModel.instance:getActivityId()

	self:_refreshTaskInfo()
	self:_setCurrency()
end

function FuncampTaskView:_updateTabCell(view, cell, data)
	local jumpBtnGo = goutil.findChild(cell, "jumpBtn")
	local receiveBtnGo = goutil.findChild(cell, "receiveBtn")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local descTxt = goutil.findChildTextComponent(cell, "descTxt")
	local progerTxt = goutil.findChildTextComponent(cell, "progerTxt")
	local finishGo = goutil.findChild(cell, "finishGo")
	local RewardTable = goutil.findChild(cell, "tableview")
	local RewardCell = goutil.findChild(cell, "cell")
	local list = data.cfg.prize .. "#" .. MatType.Item_Fake .. ":1214:" .. data.cfg.score

	list = MaterialMgr.changeItemStrArr(list)

	local rewardScroll

	self._rewardScrollList[cell] = self._rewardScrollList[cell] or ScrollerList.create(RewardTable, RewardCell, GameUtil.handler(self._updateRewardTabCell, self), GameUtil.handler(self._clearRewardTabCell, self))

	self._rewardScrollList[cell]:reloadData(list)
	GameUtil.asBtn(jumpBtnGo):RemoveClickListener()
	GameUtil.asBtn(receiveBtnGo):RemoveClickListener()

	nameTxt.text = data.cfg.taskTitle
	descTxt.text = data.cfg.taskDesc

	if data.stage == 1 then
		progerTxt.text = ""

		GameUtil.SetActive(finishGo, false)
		GameUtil.SetActive(jumpBtnGo, false)
		GameUtil.SetActive(receiveBtnGo, true)
		GameUtil.asBtn(receiveBtnGo):AddClickListener(function()
			FunCampAgent.instance:sendPM_CB_GainTaskPrizeReq(data.cfg.taskId)
		end, self)
	elseif data.stage == 3 then
		progerTxt.text = ""

		GameUtil.SetActive(jumpBtnGo, false)
		GameUtil.SetActive(receiveBtnGo, false)
		GameUtil.SetActive(finishGo, true)
	else
		progerTxt.text = data.progress .. "/" .. data.cfg.maxProgress

		GameUtil.SetActive(receiveBtnGo, false)
		GameUtil.SetActive(finishGo, false)
		GameUtil.SetActive(jumpBtnGo, true)
		GameUtil.asBtn(jumpBtnGo):AddClickListener(function()
			if not string.nilorempty(data.cfg.jumpTo) then
				GotoMgr.gotoByString(data.cfg.jumpTo)
			end

			if data.cfg.viewId > 0 then
				FunCampAgent.instance:sendPM_CB_ViewReq(data.cfg.viewId)
			end
		end, self)
	end
end

function FuncampTaskView:_clearTabCell(cell)
	return
end

function FuncampTaskView:_refreshTaskInfo()
	FunCampAgent.instance:sendPM_CB_GetTaskInfoReq()
end

function FuncampTaskView:_setTaskInfo()
	local data = FunCampModel.instance:getTaskCfgList()

	self._tableScroll:reloadData(data)
end

function FuncampTaskView:_setCurrency()
	local currency = CampGameConfig.instance:getParams("CURRENCY")
	local infos = string.split(currency, "#")
	local objList = {}

	for i, v in ipairs(infos) do
		local param = {
			showAdd = true,
			id = v
		}

		table.insert(objList, param)
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
end

function FuncampTaskView:_updateRewardTabCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function FuncampTaskView:_clearRewardTabCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

return FuncampTaskView
