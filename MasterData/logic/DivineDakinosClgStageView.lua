-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedakinosclg/view/DivineDakinosClgStageView.lua

module("logic.extensions.divinedakinosclg.view.DivineDakinosClgStageView", package.seeall)

local DivineDakinosClgStageView = class("DivineDakinosClgStageView", ViewComponent)

function DivineDakinosClgStageView:ctor()
	DivineDakinosClgStageView.super.ctor(self)
end

function DivineDakinosClgStageView:unbindEvents()
	DivineDakinosClgStageView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function DivineDakinosClgStageView:bindEvents()
	DivineDakinosClgStageView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function DivineDakinosClgStageView:buildUI()
	DivineDakinosClgStageView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._txtTips = self:getTxt("tipsCol/txt")
	self._conPrize = self:getGo("prize/con")
	self._gainPrize = self:getGo("prize/gain")

	local cellStage = self:getGo("stage/cell")
	local tabStage = self:getGo("stage/tableview")

	self._tableviewStage = ScrollerList.create(tabStage, cellStage, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
end

function DivineDakinosClgStageView:onExit()
	DivineDakinosClgStageView.super.onExit(self)
	self._tableviewStage:dispose()
	MaterialMgr.resetAll(self._conPrize)
end

function DivineDakinosClgStageView:onEnter()
	DivineDakinosClgStageView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._phaseId = checknumber(params[2])

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	self.addGEvent(self, GlobalNotify.DivineDakinosClgGetInfo, self._updateUIByInfo, self)
	DivineDakinosClgController.instance:sendPM_DivineDakinosClgGetInfoReq(self._activityId)
end

function DivineDakinosClgStageView:_updateUIByCfg()
	self._actCfg = DivineDakinosClgConfig.instance:getActCfg(self._activityId)
	self._phaseCfg = DivineDakinosClgConfig.instance:getPhaseCfg(self._activityId, self._phaseId)
	self._stageCfgs = DivineDakinosClgConfig.instance:getStageCfgs(self._phaseCfg.stagePlanId)
	self._txtTips.text = self._actCfg.stageRule

	MaterialMgr.setCellByCfg(self._phaseCfg.prize, self._conPrize)
end

function DivineDakinosClgStageView:_updateUIByInfo()
	local info = DivineDakinosClgModel.instance:getPhaseInfo(self._activityId, self._phaseId)

	goutil.setActive(self._gainPrize, info.gainPrize)

	self._saveCountMap = {}

	for i, stageInfo in ipairs(info.stageIdAndSaveCount) do
		self._saveCountMap[stageInfo.left] = stageInfo.right
	end

	self._tableviewStage:reloadData(self._stageCfgs)
end

function DivineDakinosClgStageView:_updateStageCell(view, cellGo, data)
	self:_clearStageCell(cellGo)

	local btnFight = goutil.findChild(cellGo, "btnFight")

	GameUtil.addClickHandler(btnFight, GameUtil.handler(self._onClickFight, self, data))

	local saveCount = checknumber(self._saveCountMap[data.stageId])
	local needSaveCount = checknumber(data.needSaveCount)
	local txtTips = goutil.findChildTextComponent(cellGo, "tips/txt")
	local cfg = DivineDakinosClgConfig.instance:getActCfg(self._activityId) or {}

	if not cfg.lockDesc then
		local lockDesc = ""

		txtTips.text = string.format("已拯救%s/%s名%s", saveCount, needSaveCount, lockDesc)

		local passGo = goutil.findChild(cellGo, "pass")

		goutil.setActive(passGo, needSaveCount <= saveCount)

		local creepCfgs = DivineDakinosClgConfig.instance:getCreepCfgs(data.creepsMasterId)
		local fmtView = goutil.findChild(cellGo, "fmt/fmtView")

		for _, cfg in pairs(creepCfgs) do
			local posId = cfg.posId

			if posId < 1 or posId > 9 then
				-- block empty
			else
				local fmtCellGo = fmtView.transform:GetChild(posId - 1)

				if fmtCellGo then
					local fmtIcon = goutil.findChild(fmtCellGo, "icon")
					local skinId = checknumber(cfg.faceId)

					if skinId == 0 then
						skinId = cfg.raceId
					end

					MaterialMgr.setCell(MatType.Pet, skinId, fmtIcon)
				end
			end
		end
	end
end

function DivineDakinosClgStageView:_clearStageCell(cellGo)
	local btnFight = goutil.findChild(cellGo, "btnFight")

	GameUtil.rmClickHandler(btnFight)

	local fmtView = goutil.findChild(cellGo, "fmt/fmtView")

	for posId = 1, fmtView.transform.childCount do
		local fmtCellGo = fmtView.transform:GetChild(posId - 1)
		local fmtIcon = goutil.findChild(fmtCellGo, "icon")

		MaterialMgr.resetAll(fmtIcon)
	end
end

function DivineDakinosClgStageView:_onClickFight(data)
	local saveCount = checknumber(self._saveCountMap[data.stageId])
	local needSaveCount = checknumber(data.needSaveCount)

	if needSaveCount <= saveCount then
		FloatWordMgr.instance:show(lang("已通关"))

		return
	end

	local fmtMo = DivineDakinosClgModel.instance:getFmtMo()

	fmtMo:initParams(self._activityId, self._phaseId, data.stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

return DivineDakinosClgStageView
