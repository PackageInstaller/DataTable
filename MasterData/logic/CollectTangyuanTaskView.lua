-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collecttangyuan/view/CollectTangyuanTaskView.lua

module("logic.extensions.collecttangyuan.view.CollectTangyuanTaskView", package.seeall)

local CollectTangyuanTaskView = class("CollectTangyuanTaskView", TableViewComponent)

function CollectTangyuanTaskView:ctor()
	CollectTangyuanTaskView.super.ctor(self)
end

function CollectTangyuanTaskView:unbindEvents()
	CollectTangyuanTaskView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function CollectTangyuanTaskView:bindEvents()
	CollectTangyuanTaskView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function CollectTangyuanTaskView:buildUI()
	CollectTangyuanTaskView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
end

function CollectTangyuanTaskView:onEnter()
	CollectTangyuanTaskView.super.onEnter(self)

	self._curParams = CollectTangyuanModel.instance:getTaskInfo()

	self:_onUpdateTaskData()
end

function CollectTangyuanTaskView:_onUpdateTaskData()
	local allCfgs = CollectTangyuanConfig.instance:getCollectTangyuanTasks(self._curParams.planId)
	local taskInfos = self._curParams.taskInfos

	self._curViewDatas = {}

	for _, v in pairs(allCfgs or {}) do
		local data = {
			state = 2,
			cfg = v
		}

		if v and taskInfos and taskInfos[v.taskId] then
			if taskInfos[v.taskId].gainedPrize then
				data.state = 3
			elseif taskInfos[v.taskId].curProgress >= v.maxProgress then
				data.state = 1
			end
		end

		table.insert(self._curViewDatas, data)
	end

	if #self._curViewDatas > 1 then
		table.sort(self._curViewDatas, function(a, b)
			if a.state == b.state then
				return a.cfg.taskId < b.cfg.taskId
			end

			return a.state < b.state
		end)
	end

	self:reloadData()
end

function CollectTangyuanTaskView:_getPath()
	return {
		cellPath = "viewBgGo/taskItem",
		viewPath = "viewBgGo/taskListSR"
	}
end

function CollectTangyuanTaskView:_updateCell(view, cell, data)
	local gotoBtnGo = goutil.findChild(cell, "gotoBtn")
	local gotoBtnIsc = gotoBtnGo:GetComponent("UIImageSpriteChange")
	local gotoTxt = goutil.findChildTextComponent(gotoBtnGo, "gotoTxt")
	local receiveGo = goutil.findChild(cell, "receiveGo")
	local goodsPos = goutil.findChild(cell, "goodsPos")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local descTxt = goutil.findChildTextComponent(cell, "descTxt")
	local progTxt = goutil.findChildTextComponent(cell, "progTxt")

	GameUtil.asBtn(gotoBtnGo):RemoveClickListener()
	MaterialMgr.resetAll(goodsPos)

	nameTxt.text = data.cfg.taskTitle
	descTxt.text = data.cfg.taskDesc
	progTxt.text = string.format("%s/%s", math.min((self._curParams.taskInfos and self._curParams.taskInfos[data.cfg.taskId] or nil) and checknumber(self._curParams.taskInfos[data.cfg.taskId].curProgress), data.cfg.maxProgress), data.cfg.maxProgress)

	MaterialMgr.setCellByCfg(data.cfg.prize, goodsPos)

	if data.state == 3 then
		GameUtil.SetActive(gotoBtnGo, false)
		GameUtil.SetActive(receiveGo, true)

		return
	end

	GameUtil.SetActive(receiveGo, false)
	GameUtil.SetActive(gotoBtnGo, true)

	if data.state == 1 then
		gotoBtnIsc:SetState(1)

		gotoTxt.text = "领取"
	else
		gotoBtnIsc:SetState(0)

		gotoTxt.text = string.nilorempty(data.cfg.jumpTo) and "未完成" or "前往"
	end

	GameUtil.asBtn(gotoBtnGo):AddClickListener(function()
		if data.state == 1 then
			YuanXiaoKingsExchangeAgent.instance:sendPM_KingsExchangeTaskGainReq(self._curParams.activityId, data.cfg.taskId)
			self:close()
		else
			if string.nilorempty(data.cfg.jumpTo) then
				FloatWordMgr.instance:show("当前任务还未完成！")

				return
			end

			ViewAutoShowController.instance:saveCurModalView()
			GotoMgr.gotoByString(data.cfg.jumpTo)
		end
	end, self)
end

return CollectTangyuanTaskView
