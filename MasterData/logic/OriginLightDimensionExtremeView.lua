-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlightdimension/view/OriginLightDimensionExtremeView.lua

module("logic.extensions.originlightdimension.view.OriginLightDimensionExtremeView", package.seeall)

local OriginLightDimensionExtremeView = class("OriginLightDimensionExtremeView", ViewComponent)

function OriginLightDimensionExtremeView:ctor()
	OriginLightDimensionExtremeView.super.ctor(self)
end

function OriginLightDimensionExtremeView:unbindEvents()
	OriginLightDimensionExtremeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRest)
end

function OriginLightDimensionExtremeView:bindEvents()
	OriginLightDimensionExtremeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
end

function OriginLightDimensionExtremeView:buildUI()
	OriginLightDimensionExtremeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnReset = self:getGo("btnReset")
	self._buffTableView = self:getGo("info/buffTableView")
	self._buffTableCell = self:getGo("info/buffTableView/buffTableCell")
	self._buffTableList = ScrollerList.create(self._buffTableView, self._buffTableCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
	self._lockTableView = self:getGo("info/lockTableView")
	self._petCon = self:getGo("info/petCon")
	self._lockTableList = ScrollerList.create(self._lockTableView, self._petCon, GameUtil.handler(self._updateLockCell, self), GameUtil.handler(self._clearLockCell, self))
	self._txtEmptyLock = self:getGo("info/txtEmptyLock")
	self._stageCells = self:getGo("stageCells")
	self._stageCell = self:getGo("stageCells/stageCell")
	self._stagePosRecord = self._stageCells:GetComponent(ComponentType.TestRecordPos)
	self._txtLastBuff = self:getTxt("info/lastResultInfo/txtLastBuff")
	self._txtReset = self:getTxt("btnReset/txt")
end

function OriginLightDimensionExtremeView:onExit()
	OriginLightDimensionExtremeView.super.onExit(self)
	GameUtil.clearCells(self._stageCells, self._clearStageCell, self, false)
end

function OriginLightDimensionExtremeView:onEnter()
	OriginLightDimensionExtremeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginLightDimensionGetInfoRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_OriginLightDimensionSubmitExClgResultRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_OriginLightDimensionNotifyExtremeClgRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_OriginLightDimensionResetExtremeRes, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())

	OriginLightDimensionController.instance:tryShowTempPrize()

	self._curSelect = 1

	local stageCfgs = OriginLightDimensionConfig.instance:getExtremeStageCfgs(self._activityId)

	for i, v in ipairs(stageCfgs) do
		local stageInfo = OriginLightDimensionModel.instance:getExtremeStageInfo(self._activityId, i)

		if stageInfo == nil then
			self._curSelect = i

			break
		end
	end

	self:_refreshView()
end

function OriginLightDimensionExtremeView:_refreshView()
	local buffCfgs = OriginLightDimensionConfig.instance:getExtremeBuffCfgs(self._activityId)

	self._buffList = {}

	for i, v in pairs(buffCfgs) do
		table.insert(self._buffList, {
			cfg = v,
			index = i
		})
	end

	table.sort(self._buffList, function(a, b)
		return a.cfg.buffId < b.cfg.buffId
	end)

	for i, v in ipairs(self._buffList) do
		v.index = i
	end

	self._buffTableList:reloadData(self._buffList)

	local stageCfgs = OriginLightDimensionConfig.instance:getExtremeStageCfgs(self._activityId)

	GameUtil.updateCellsList(self._stageCells, self._stageCell, stageCfgs, self._updateStageCell, self)
	self._stagePosRecord:LoadPlan(0)

	local lastBuffId = OriginLightDimensionModel.instance:getLastBuff(self._activityId)
	local lastBuffCfg = OriginLightDimensionConfig.instance:getExtremeBuffCfg(self._activityId, lastBuffId)

	self._txtLastBuff.text = lastBuffCfg and lastBuffCfg.name or lang("暂无")

	local stageInfo = OriginLightDimensionModel.instance:getExtremeStageInfo(self._activityId, self._curSelect)
	local isPass = stageInfo ~= nil

	self._txtReset.text = not isPass and lang("进入挑战") or lang("重置关卡")

	if stageInfo then
		if not stageInfo.lockRaceId then
			local lockPetList = {}

			self._lockTableList:reloadData(lockPetList)
			GameUtil.SetActive(self._txtEmptyLock, #lockPetList == 0)
		end
	end
end

function OriginLightDimensionExtremeView:_updateBuffCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtType = goutil.findChildTextComponent(go, "txtType")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local bgChange = goutil.findChildComponent(go, "bg", ComponentType.UIImageColorChange)

	bgChange:SetState(data.index % 2 == 0 and 1 or 0)

	txtType.text = data.cfg.name
	txtDesc.text = data.cfg.desc
end

function OriginLightDimensionExtremeView:_clearBuffCell(cell)
	return
end

function OriginLightDimensionExtremeView:_updateLockCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCell(MatType.Pet, data, go)
end

function OriginLightDimensionExtremeView:_clearLockCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function OriginLightDimensionExtremeView:_updateStageCell(cell, data, index)
	local go = cell.gameObject
	local petIcon = goutil.findChild(go, "petIcon")
	local txtTarget = goutil.findChildTextComponent(go, "target/txtTarget")
	local passGo = goutil.findChild(go, "pass")
	local bgColorChange = goutil.findChildComponent(passGo, "bg", ComponentType.UIImageColorChange)
	local txtBuff = goutil.findChildTextComponent(passGo, "txtBuff")
	local selectGo = goutil.findChild(go, "select")
	local creepCfg = OriginLightDimensionConfig.instance:getCreepsCfg(data.creepsMasterId)
	local raceId = creepCfg[1].raceId

	MaterialMgr.setIcon(petIcon, MatType.Pet, raceId)

	txtTarget.text = langPara("目标次数：%d", data.activateCount)

	local stageInfo = OriginLightDimensionModel.instance:getExtremeStageInfo(self._activityId, data.stageId)
	local isPass = stageInfo ~= nil

	GameUtil.SetActive(passGo, isPass)

	if isPass then
		local buffCfg = OriginLightDimensionConfig.instance:getExtremeBuffCfg(self._activityId, stageInfo.buffId)

		txtBuff.text = buffCfg.name

		local index = 1

		for i, v in ipairs(self._buffList) do
			if stageInfo.buffId == v.cfg.buffId then
				index = v.index
			end
		end

		bgColorChange:SetState(index - 1)
	end

	GameUtil.rmClickHandler(go)
	GameUtil.addClickHandler(go, function()
		self:_onClickStage(data)
	end)
	GameUtil.SetActive(selectGo, self._curSelect == data.stageId)
end

function OriginLightDimensionExtremeView:_clearStageCell(cell)
	local go = cell.gameObject
	local petIcon = goutil.findChild(go, "petIcon")

	MaterialMgr.resetAll(petIcon)
	GameUtil.rmClickHandler(go)
end

function OriginLightDimensionExtremeView:_onClickReset()
	local stageInfo = OriginLightDimensionModel.instance:getExtremeStageInfo(self._activityId, self._curSelect)
	local isPass = stageInfo ~= nil

	if not isPass then
		OriginLightDimensionController.instance:openExtremeMissionView(self._activityId, self._curSelect)
	else
		TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否重置当前关卡？"), function()
			OriginLightDimensionAgent.instance:sendPM_OriginLightDimensionResetExtremeReq(self._activityId, self._curSelect)
		end)
	end
end

function OriginLightDimensionExtremeView:_onClickStage(stageCfg)
	self._curSelect = stageCfg.stageId

	self:_refreshView()
end

return OriginLightDimensionExtremeView
