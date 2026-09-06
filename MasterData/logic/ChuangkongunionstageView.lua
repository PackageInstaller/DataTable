-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangkongunion/view/ChuangkongunionstageView.lua

module("logic.extensions.chuangkongunion.view.ChuangkongunionstageView", package.seeall)

local ChuangkongunionstageView = class("ChuangkongunionstageView", ViewComponent)

ChuangkongunionstageView.TYPE_TRIAL = 1
ChuangkongunionstageView.TYPE_TASK = 2

function ChuangkongunionstageView:ctor()
	ChuangkongunionstageView.super.ctor(self)
end

function ChuangkongunionstageView:unbindEvents()
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnSweep)
	ChuangkongunionstageView.super.unbindEvents(self)
end

function ChuangkongunionstageView:bindEvents()
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
	GameUtil.addClickHandler(self._btnSweep, self._onClickSweep, self)
	ChuangkongunionstageView.super.bindEvents(self)
end

function ChuangkongunionstageView:buildUI()
	ChuangkongunionstageView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtTitle = self:getTxt("txtTitle")
	self._txtDesc = self:getTxt("desc/txtDesc")
	self._txtCondition = self:getTxt("condition/txtDesc")
	self._txtConditionTitle = self:getTxt("condition/txt")
	self._btnStart = self:getGo("btnStart")
	self._btnSweep = self:getGo("btnSweep")
	self._bgBlur = self:getGo("blurBg"):GetComponent(typeof(UnityEngine.UI.RawImage))
	self._tableGo = self:getGo("normalPrize/tableview")
	self._tableCell = self:getGo("normalPrize/tablecell")
	self._tableview = ScrollerList.create(self._tableGo, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tableCell:SetActive(false)
end

function ChuangkongunionstageView:_updateCell(view, cell, data)
	local icon = goutil.findChild(cell, "icon")

	MaterialMgr.setCellByCfg(data, icon)
end

function ChuangkongunionstageView:_clearCell(cell)
	local icon = goutil.findChild(cell, "icon")

	MaterialMgr.resetAll(icon)
end

function ChuangkongunionstageView:onExit()
	ChuangkongunionstageView.super.onExit(self)
end

function ChuangkongunionstageView:onEnter()
	ChuangkongunionstageView.super.onEnter(self)

	local params = self:getOpenParam()

	self.type = checknumber(params[1])

	if self.type == ChuangkongunionstageView.TYPE_TRIAL then
		self.taskId = checknumber(params[2])
		self.stage = checknumber(params[3])
	else
		self.taskId = checknumber(params[2])
	end

	self:_setBlurBg()
	self:updateUI()
end

function ChuangkongunionstageView:_setBlurBg()
	self._bgBlur:Release()
	self._bgBlur:Capture()
	StaticBluredHook.instance:start(self.mainGO)
	self._bgBlur:AddCaptureFinishListener(self._onCaptureScreenFinish, self)
end

function ChuangkongunionstageView:_onCaptureScreenFinish()
	StaticBluredHook.instance:stop()
end

function ChuangkongunionstageView:_onClickStart()
	self:close()

	if self.type == ChuangkongunionstageView.TYPE_TRIAL then
		local cfg = ChuangkongunionConfig.instance:getBreachFormStageById(self.taskId)[self.stage]

		ChuangkongunionController.instance:openChuangkongMission(cfg, ChuangkongunionModel.instance:getActId())
	else
		local cfg = ChuangkongunionConfig.instance:getTaskCfg(ChuangkongunionModel.instance:getActId())[self.taskId]

		if cfg then
			GotoMgr.gotoByString(cfg.jumpto)
		end
	end
end

function ChuangkongunionstageView:_onClickSweep()
	self:close()

	if self.type == ChuangkongunionstageView.TYPE_TRIAL then
		return
	end

	local taskId = self.taskId
	local cfg = ChuangkongunionConfig.instance:getTaskCfg(ChuangkongunionModel.instance:getActId())[taskId]
	local sweepCost = cfg.sweepCost
	local type, id, num = MaterialMgr.getMatParams(sweepCost)
	local name = MaterialMgr.getMaterialsName(type, id)
	local content = string.format("是否花费%d%s一键扫荡当前关卡", num, name)

	if cfg.taskType == 1 then
		content = content .. "\n" .. "当前最高伤害：" .. ChuangkongunionModel.instance:getEverMaxDamage(taskId)
	end

	TipsFacade.instance:openPopupCostMatViewNew(type, id, num, content, function()
		ChuangkongunionController.instance:sweepTask(taskId)
	end, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
end

function ChuangkongunionstageView:updateUI()
	local cfg
	local canSweep = false

	if self.type == ChuangkongunionstageView.TYPE_TRIAL then
		cfg = ChuangkongunionConfig.instance:getBreachFormStageById(self.taskId)[self.stage]
	else
		cfg = ChuangkongunionConfig.instance:getTaskCfg(ChuangkongunionModel.instance:getActId())[self.taskId]
		canSweep = ChuangkongunionModel.instance:canSweepTask(self.taskId)
	end

	local vector = GameUtil.getAnchoredPos(self._btnStart)

	if canSweep then
		goutil.setActive(self._btnSweep, true)
		GameUtil.setAnchoredPos(self._btnStart, -160, vector.y)
	else
		goutil.setActive(self._btnSweep, false)
		GameUtil.setAnchoredPos(self._btnStart, -210, vector.y)
	end

	self._txtTitle.text = cfg.title or self.taskId .. "-" .. self.stage
	self._txtDesc.text = cfg.desc
	self._txtCondition.text = cfg.condition
	self._txtConditionTitle.text = "通关条件"

	if self.type == ChuangkongunionstageView.TYPE_TASK and cfg.taskType == 1 then
		self._txtConditionTitle.text = "最高伤害"
		self._txtCondition.text = "当前最高伤害：" .. ChuangkongunionModel.instance:getEverMaxDamage(self.taskId)
	end

	local prize = string.split(cfg.prize or cfg.winPrize, "#")

	self._tableview:reloadData(prize)
end

return ChuangkongunionstageView
