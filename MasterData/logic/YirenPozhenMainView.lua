-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yirenpozhen/view/YirenPozhenMainView.lua

module("logic.extensions.yirenpozhen.view.YirenPozhenMainView", package.seeall)

local YirenPozhenMainView = class("YirenPozhenMainView", ViewComponent)

function YirenPozhenMainView:ctor()
	YirenPozhenMainView.super.ctor(self)
end

function YirenPozhenMainView:buildUI()
	YirenPozhenMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnRank = self:getBtn("btnRank")
	self._btnRule = self:getBtn("btnRule")
	self._btnChall = self:getBtn("btnChall")
	self._cells = {}

	for i = 1, 8 do
		local obj = {}

		obj.go = self:getGo("guaxiang/cell_" .. i)
		obj.txtName = goutil.findChildTextComponent(obj.go, "txtName")
		obj.lock = goutil.findChild(obj.go, "lock")
		obj.select = goutil.findChild(obj.go, "select")
		obj.btn = self:getBtn("guaxiang/cell_" .. i .. "/btnClick")
		obj.Image = goutil.findChild(obj.go, "Image")

		table.insert(self._cells, obj)
	end

	self._txtStageName = self:getTxt("stages/txtName")
	self._slider = self:getGo("reward/slider"):GetComponent("Slider")
	self._rewardCell = {}

	for i = 1, 8 do
		local obj = {}

		obj.go = self:getGo("reward/cell_" .. i)
		obj.item = goutil.findChild(obj.go, "item")
		obj.pass = goutil.findChild(obj.go, "receivedGo")

		table.insert(self._rewardCell, obj)
	end

	self._txtTime = self:getTxt("time/txtTime")
end

function YirenPozhenMainView:bindEvents()
	YirenPozhenMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnRank:AddClickListener(self._clickRank, self)
	self._btnRule:AddClickListener(self._clickHelp, self)
	self._btnChall:AddClickListener(self._clickChall, self)

	for i = 1, 8 do
		self._cells[i].btn:AddClickListener(function()
			self:_clickCell(i)
		end, self)
	end
end

function YirenPozhenMainView:unbindEvents()
	YirenPozhenMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnRule:RemoveClickListener()
	self._btnChall:RemoveClickListener()

	for i = 1, 8 do
		self._cells[i].btn:RemoveClickListener()
	end
end

function YirenPozhenMainView:destroyUI()
	YirenPozhenMainView.super.destroyUI(self)
end

function YirenPozhenMainView:onEnter()
	YirenPozhenMainView.super.onEnter(self)

	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.Hexagram)

	if actCfg == nil then
		FloatWordMgr.instance:show("当前活动未开启")
		self:close()

		return
	end

	self.activityId = actCfg.activityId
	self._diagramsId = YirenPozhenModel.instance:getDiagramsId()
	self._diaCfgs = YirenPozhenConfig.instance:getDiagramsCfgList()

	GlobalDispatcher:addListener(GlobalNotify.HexagramGetInfo, self._refresh, self)
	YirenPozhenController.instance:getInfo()

	self.startTime, self.endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.Hexagram, self.activityId)

	self:_timer()
	settimer(1, self._timer, self, true)
end

function YirenPozhenMainView:onEnterFinished()
	YirenPozhenMainView.super.onEnterFinished(self)
end

function YirenPozhenMainView:onExit()
	YirenPozhenMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.HexagramGetInfo, self._refresh, self)

	for i = 1, 8 do
		MaterialMgr.resetAll(self._rewardCell[i].item)
	end

	removetimer(self._timer, self)
end

function YirenPozhenMainView:onExitFinished()
	YirenPozhenMainView.super.onExitFinished(self)
end

function YirenPozhenMainView:_refresh()
	local passStageId = YirenPozhenModel.instance:getPassStageId()

	if self._diagramsId == nil then
		self._diagramsId = 1

		for k, v in ipairs(self._diaCfgs) do
			if self:_diagramPassUnlock(k) and self:_diagramTimeUnlock(k) then
				self._diagramsId = v.diagramsId

				YirenPozhenModel.instance:setDiagramsId(v.diagramsId)
			else
				break
			end
		end
	end

	for i = 1, 8 do
		local obj = self._cells[i]

		goutil.setActive(obj.select, self._diagramsId == i)

		local unlock = self:_diagramTimeUnlock(i) and self:_diagramPassUnlock(i)

		goutil.setActive(obj.lock, not unlock)
		goutil.setActive(obj.Image, unlock)

		obj.txtName.text = self._diaCfgs[i].name
	end

	local stageCfg = passStageId >= #self._diaCfgs and YirenPozhenConfig.instance:getStageCfg(passStageId) or YirenPozhenConfig.instance:getStageCfg(passStageId + 1)

	self._slider.value = passStageId / #YirenPozhenConfig.instance:getStageList()

	for i = 1, 8 do
		local pass = self:_diagramPass(i)

		goutil.setActive(self._rewardCell[i].pass, pass)

		local proxy = MaterialMgr.setCellByCfg(self._diaCfgs[i].prize, self._rewardCell[i].item)

		if proxy then
			proxy.binder:setEffStatus(not pass)
		end
	end
end

function YirenPozhenMainView:_clickHelp()
	UIStateManager.instance:push(ViewName.RulesView, "HexagramMainRule")
end

function YirenPozhenMainView:_clickCell(id)
	local diaCfg = self._diaCfgs[id]

	if not self:_diagramTimeUnlock(id) then
		local startStamp = GameUtil.string2time(diaCfg.startTime)
		local openDate = GameUtil.time2date(startStamp)
		local openMon, openDay = openDate.month, openDate.day

		FloatWordMgr.instance:show(langPara("%s.%s 5:00开启", openMon, openDay))

		return
	end

	if not self:_diagramPassUnlock(id) then
		local temp = self._diaCfgs[id - 1]

		if temp then
			FloatWordMgr.instance:show(langPara("请通关【%s卦】全部破阵关卡！", temp.name))
		else
			FloatWordMgr.instance:show(lang("当前关卡未解锁"))
		end

		return
	end

	self._diagramsId = id

	YirenPozhenModel.instance:setDiagramsId(id)
	self:_refresh()
end

function YirenPozhenMainView:_clickChall()
	UIStateManager.instance:push(ViewName.YirenPozhenPopupView, self._diagramsId)
end

function YirenPozhenMainView:_diagramTimeUnlock(id)
	local diaCfg = self._diaCfgs[id]
	local startStamp = GameUtil.string2time(diaCfg.startTime)

	return startStamp <= ServerTime.now()
end

function YirenPozhenMainView:_diagramPassUnlock(id)
	local passStageId = YirenPozhenModel.instance:getPassStageId()

	return passStageId >= (id - 1) * 3
end

function YirenPozhenMainView:_diagramPass(id)
	local passStageId = YirenPozhenModel.instance:getPassStageId()

	return passStageId >= id * 3
end

function YirenPozhenMainView:_timer()
	local leftTime = self.endTime - ServerTime.now()

	if leftTime > 0 then
		self._txtTime.text = string.format("剩余时间:%s", GameUtil.FormatTimeWordsNoSec(leftTime))
	else
		FloatWordMgr.instance:show("当前活动结束")
		self:close()
	end
end

function YirenPozhenMainView:_clickRank()
	UIStateManager.instance:push(ViewName.YirenPozhenRankView)
end

return YirenPozhenMainView
