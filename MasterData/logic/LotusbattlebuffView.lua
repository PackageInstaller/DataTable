-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattlebuffView.lua

module("logic.extensions.lotusbattle.view.LotusbattlebuffView", package.seeall)

local LotusbattlebuffView = class("LotusbattlebuffView", TableViewComponent)

function LotusbattlebuffView:ctor()
	LotusbattlebuffView.super.ctor(self)
end

function LotusbattlebuffView:unbindEvents()
	LotusbattlebuffView.super.unbindEvents(self)
	self._btnGet:RemoveClickListener()
end

function LotusbattlebuffView:bindEvents()
	LotusbattlebuffView.super.bindEvents(self)
	self._btnGet:AddClickListener(self._onClickbtnGet, self)
end

function LotusbattlebuffView:buildUI()
	LotusbattlebuffView.super.buildUI(self)

	self._btnGet = self:getBtn("btnGet")
	self._txtBtnSure = self:getTxt("btnGet/Text")
	self._singleLine = self:getGo("cellcon"):GetComponent(ComponentType.UILayoutSingleLine)
	self._ContentTr = self:getGo("tableview/Viewport/Content").transform
end

function LotusbattlebuffView:onExit()
	LotusbattlebuffView.super.onExit(self)
	removetimer(self._tick, self)
end

function LotusbattlebuffView:onEnter()
	LotusbattlebuffView.super.onEnter(self)

	self._activityId = LotusbattleModel.instance:getActivityId()

	if self._activityId <= 0 then
		self:close()

		return
	end

	local params = self:getOpenParam()

	self._isSelectInitBuff = params[2]
	self._buffCfgs = self:_getBuffCfgs()
	self._currBuffId = self._buffCfgs[1].buffId
	self._curViewDatas = self._buffCfgs

	self:reloadData()

	self._tickTime = LotusbattleConfig.instance:getStageTime(self._activityId, "selectBuffTime")
	self._targetTickTime = ServerTime.now() + self._tickTime - 1

	settimer(1, self._tick, self, true)
	self:_tick()
end

function LotusbattlebuffView:_getBuffCfgs()
	local params = self:getOpenParam()
	local buffIds = params[1]
	local modelId = LotusbattleModel.instance:getModelId()
	local modelCfg = LotusbattleConfig.instance:getModelCfg(self._activityId, modelId)
	local cfgs = {}
	local isUseBuffIds = {}

	for i, buffId in ipairs(buffIds) do
		if buffId > 0 and not isUseBuffIds[buffId] then
			local cfg = LotusbattleConfig.instance:getBuffCfg(modelCfg.buffPlanId, buffId)

			table.insert(cfgs, cfg)

			isUseBuffIds[buffId] = true
		end
	end

	return cfgs
end

function LotusbattlebuffView:_onClickbtnGet()
	if self._currBuffId <= 0 then
		FloatWordMgr.instance:show("先选择Buff")

		return
	end

	if self._isSelectInitBuff then
		LotusBattleFieldAgent.instance:sendPM_LBFSelectInitialBuffReq(self._currBuffId)
	else
		LotusBattleFieldAgent.instance:sendPM_LBFSelectBattleBuffReq(self._currBuffId)
	end

	self:close()
end

function LotusbattlebuffView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function LotusbattlebuffView:_updateCell(view, cell, buffCfg)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local goBuffIcon = goutil.findChild(cell.gameObject, "BuffIcon")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local goSelect = goutil.findChild(cell.gameObject, "select")

	txtName.text = buffCfg.name
	txtDesc.text = buffCfg.buffDesc

	local spriteName = GameUrl.getExpEventUrl(buffCfg.iconPath)

	uGuiUtil.setSpriteToImage(goBuffIcon, nil, spriteName)
	goutil.setActive(goSelect, self._currBuffId == buffCfg.buffId)
	btn:AddClickListener(function()
		if self._currBuffId == buffCfg.buffId then
			return
		end

		self._currBuffId = buffCfg.buffId

		self:reloadData()
	end)
end

function LotusbattlebuffView:_clearTableview(cell)
	local goBuffIcon = goutil.findChild(cell.gameObject, "BuffIcon")

	uGuiUtil.clearImage(goBuffIcon)
end

function LotusbattlebuffView:_tick()
	local leftTime = self._targetTickTime - ServerTime.now()

	self._txtBtnSure.text = string.format("确定(%ss)", leftTime)

	if leftTime <= 0 then
		if self._isSelectInitBuff then
			LotusBattleFieldAgent.instance:sendPM_LBFSelectInitialBuffReq(self._currBuffId)
		else
			LotusBattleFieldAgent.instance:sendPM_LBFSelectBattleBuffReq(self._currBuffId)
		end

		self:close()
	end
end

function LotusbattlebuffView:_onReloadFinish()
	if self._curViewDatas and #self._curViewDatas <= 3 then
		for i = self._ContentTr.childCount, 1, -1 do
			self._ContentTr:GetChild(i - 1):SetParent(self._singleLine.gameObject.transform)
		end

		self._singleLine:Layout()
	end
end

return LotusbattlebuffView
