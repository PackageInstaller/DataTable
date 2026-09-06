-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originzhengli/view/OriginZhengliBuffView.lua

module("logic.extensions.originzhengli.view.OriginZhengliBuffView", package.seeall)

local OriginZhengliBuffView = class("OriginZhengliBuffView", ViewComponent)

function OriginZhengliBuffView:ctor()
	OriginZhengliBuffView.super.ctor(self)
end

function OriginZhengliBuffView:unbindEvents()
	OriginZhengliBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSelect)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnClose)

	for i, cell in ipairs(self._curShowBuffInfoCells) do
		GameUtil.rmClickHandler(cell.btnSelect)
	end
end

function OriginZhengliBuffView:bindEvents()
	OriginZhengliBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSelect, self._onClickBtnSelect, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickBtnCancel, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)

	for i, cell in ipairs(self._curShowBuffInfoCells) do
		GameUtil.addClickHandler(cell.btnSelect, function()
			self:_onSelectBuff(i)
		end, self)
	end
end

function OriginZhengliBuffView:buildUI()
	OriginZhengliBuffView.super.buildUI(self)

	self._btnSelect = self:getGo("selectShow/btnSelect")
	self._btnCancel = self:getGo("selectShow/btnCancel")
	self._btnClose = self:getGo("btnClose")
	self._selectShow = self:getGo("selectShow")
	self._txtCost = self:getTxt("selectShow/txtCost")
	self._curShowBuffInfoCells = {}

	for i = 1, 2 do
		local cell = {}

		cell.go = self:getGo("select" .. i)
		cell.txtDesc = goutil.findChildTextComponent(cell.go, "txtDesc")
		cell.markSelect = goutil.findChild(cell.go, "curselect")
		cell.showTypeList = {}

		for j = 1, 2 do
			local type = goutil.findChild(cell.go, "type" .. j)

			if type then
				table.insert(cell.showTypeList, type)
			end
		end

		cell.btnSelect = goutil.findChild(cell.go, "btn")

		table.insert(self._curShowBuffInfoCells, cell)
	end
end

function OriginZhengliBuffView:onExit()
	OriginZhengliBuffView.super.onExit(self)
end

function OriginZhengliBuffView:onEnter()
	OriginZhengliBuffView.super.onEnter(self)

	self._curSelectBuffId = 0

	local param = self:getOpenParam()

	if param then
		self._activityId = checknumber(param[1])
		self._stageId = checknumber(param[2])
		self._isOpenFromStage = checkbool(param[3])
		self._curSelectBuffId = checknumber(param[4]) or 0
	end

	if self._activityId <= 0 then
		self._activityId = OriginZhengliController.instance:getDefaultActivityId() or 0
	end

	if self._stageId <= 0 then
		self._stageId = 1
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
end

function OriginZhengliBuffView:_updateUIByCfg()
	self._stageCfg = OriginZhengliConfig.instance:getStageCfgById(self._activityId, self._stageId)
	self._showBuffCfgs = {}

	if self._stageCfg then
		if not self._stageCfg.canActivateBuff then
			for i, buffId in ipairs(self._stageCfg.canActivateBuff) do
				local buffCfg = OriginZhengliConfig.instance:getBuffCfgById(self._activityId, buffId)

				if buffCfg then
					table.insert(self._showBuffCfgs, buffCfg)
				end
			end
		end
	end

	for i, cell in ipairs(self._curShowBuffInfoCells) do
		local buffCfg = self._showBuffCfgs[i]

		if buffCfg then
			cell.go:SetActive(true)

			cell.txtDesc.text = buffCfg.buffDesc or ""

			for j, type in ipairs(cell.showTypeList) do
				if j == buffCfg.buffType then
					goutil.setActive(type, true)
				else
					goutil.setActive(type, false)
				end
			end
		else
			cell.go:SetActive(false)
		end
	end
end

function OriginZhengliBuffView:_updateUIByInfo()
	self._curRemainPoints = OriginZhengliModel.instance:getRemainPoints(self._activityId)
	self._canSelect = false
	self._activateBuffId = 0

	local stageInfo = OriginZhengliModel.instance:getStageInfoById(self._activityId, self._stageId)

	if stageInfo then
		if not stageInfo.activateBuff then
			local activateBuff = 0

			self._canSelect = activateBuff == 0
			self._activateBuffId = activateBuff
		end
	end

	self:_updateTips()
	goutil.setActive(self._selectShow, self._canSelect)

	for i, cell in ipairs(self._curShowBuffInfoCells) do
		goutil.setActive(cell.btnSelect, self._canSelect)
	end

	if self._canSelect and self._curSelectBuffId == 0 then
		self:_onSelectBuff(1)
	end
end

function OriginZhengliBuffView:_updateTips()
	self._curCostPoints = 0

	if self._canSelect then
		for i, cell in ipairs(self._curShowBuffInfoCells) do
			local cfg = self._showBuffCfgs[i]

			goutil.setActive(cell.markSelect, false)

			if cfg then
				goutil.setActive(cell.markSelect, cfg.buffId == self._curSelectBuffId)
			end
		end

		local buffCfg = OriginZhengliConfig.instance:getBuffCfgById(self._activityId, self._curSelectBuffId)

		if buffCfg then
			self._curCostPoints = buffCfg.activateNeedPoints or 0
		end
	else
		for i, cell in ipairs(self._curShowBuffInfoCells) do
			local cfg = self._showBuffCfgs[i]

			goutil.setActive(cell.markSelect, false)

			if cfg then
				goutil.setActive(cell.markSelect, cfg.buffId == self._activateBuffId)
			end
		end
	end

	if self._curCostPoints > self._curRemainPoints then
		if not GameEnum.ColorConst.Red then
			local addColor = GameEnum.ColorConst.Green

			self._txtCost.text = langPara("消耗：<color=%s>%s</color>/%s", addColor, self._curCostPoints, self._curRemainPoints)

			local isGray = self._curCostPoints > self._curRemainPoints or not self._canSelect

			GameUtil.SetGray(self._btnSelect, isGray)
		end
	end
end

function OriginZhengliBuffView:_onClickBtnSelect()
	if not self._canSelect then
		return
	end

	if self._curCostPoints > self._curRemainPoints then
		TipsFacade.instance:openCommonTips(lang("所需轮回点数不足，不可选择"))

		return
	end

	if self._isOpenFromStage then
		OriginZhengliController.instance:showMissionView(self._activityId, self._stageId, self._curSelectBuffId)
		self:close()
	else
		GlobalDispatcher:dispatch(GlobalNotify.ChangeOriginZhengliBuffId, self._curSelectBuffId)
		self:close()
	end
end

function OriginZhengliBuffView:_onClickBtnCancel()
	if not self._canSelect then
		return
	end

	if self._isOpenFromStage then
		OriginZhengliController.instance:showMissionView(self._activityId, self._stageId, 0)
		self:close()
	else
		GlobalDispatcher:dispatch(GlobalNotify.ChangeOriginZhengliBuffId, 0)
		self:close()
	end
end

function OriginZhengliBuffView:_onSelectBuff(index)
	if not self._canSelect then
		return
	end

	local buffId = 0
	local cfg = self._showBuffCfgs[index]

	if cfg then
		buffId = cfg.buffId or 0
	end

	self._curSelectBuffId = self._curSelectBuffId == 0 and buffId or buffId == self._curSelectBuffId and 0 or buffId

	self:_updateTips()
end

return OriginZhengliBuffView
