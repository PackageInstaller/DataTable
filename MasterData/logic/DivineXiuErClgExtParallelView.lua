-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiuerclg/view/DivineXiuErClgExtParallelView.lua

module("logic.extensions.divinexiuerclg.view.DivineXiuErClgExtParallelView", package.seeall)

local DivineXiuErClgExtParallelView = class("DivineXiuErClgExtParallelView", ViewComponent)

function DivineXiuErClgExtParallelView:buildUI()
	DivineXiuErClgExtParallelView.super.buildUI(self)

	self._txtTips = goutil.findChildTextComponent(self.mainGO, "txtTips")

	local fmtScrollerview = goutil.findChild(self.mainGO, "fmtCol/fmtScrollerview")
	local fmtScrollercell = goutil.findChild(self.mainGO, "fmtCol/fmtScrollercell")

	self._fmtScrollList = ScrollerList.create(fmtScrollerview, fmtScrollercell, GameUtil.handler(self._updateFmtCell, self), GameUtil.handler(self._clearFmtCell, self))
end

function DivineXiuErClgExtParallelView:bindEvents()
	DivineXiuErClgExtParallelView.super.bindEvents(self)
end

function DivineXiuErClgExtParallelView:unbindEvents()
	DivineXiuErClgExtParallelView.super.unbindEvents(self)
end

function DivineXiuErClgExtParallelView:onEnter()
	DivineXiuErClgExtParallelView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._tierId = checknumber(params[2])
	self._parallelId = checknumber(params[3])
	self._activityType = DivineXiuErClgController.instance:getActivityType()

	local isInTime = DivineXiuErClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		printError(string.format("活动不在开启期限内( activityId = %d )", self._activityId))
		self:close()

		return
	end

	if self._tierId <= 0 then
		printError(string.format("传入参数有误( tierId = %d )", self._tierId))
		self:close()

		return
	end

	if self._parallelId <= 0 then
		printError(string.format("传入参数有误( parallelId = %d )", self._parallelId))
		self:close()

		return
	end

	self._tierData = DivineXiuErClgConfig.instance:getDxecExtTierData(self._activityId, self._tierId)
	self._parallelData = DivineXiuErClgConfig.instance:getDxecExtTierParalleData(self._parallelId)

	self.addGEvent(self, GlobalNotify.handlePM_DivineXiuErClgGetInfoRes, self._onUpdate, self)
	self:_onSetUI()
	self:_onUpdate()
end

function DivineXiuErClgExtParallelView:onExit()
	DivineXiuErClgExtParallelView.super.onExit(self)
	self:_onClear()
end

function DivineXiuErClgExtParallelView:_onSetUI()
	self._txtTips.text = self._parallelData.ruleDesc
end

function DivineXiuErClgExtParallelView:_onUpdate()
	self:_onUpdateFmtColUI()
end

function DivineXiuErClgExtParallelView:_onClear()
	self:_onClearFmtColUI()
end

function DivineXiuErClgExtParallelView:_onUpdateFmtColUI()
	local idList = {}
	local cfg = DivineXiuErClgConfig.instance:getDxecExtStageCfg(self._activityId, self._tierId)

	if cfg then
		for _, data in ipairs(cfg) do
			table.insert(idList, data.dataBitId)
		end
	end

	self._fmtScrollList:reloadData(idList)

	local cellIdx = 0

	for idx, dataBitId in ipairs(idList) do
		local result, tips = DivineXiuErClgController.instance:getTryFightExtClgResultAndTips(self._activityId, self._tierId, dataBitId)

		if result == GameEnum.ResultCode.Success then
			cellIdx = idx - 1

			break
		end
	end

	self._fmtScrollList:MoveCellInView(cellIdx, true)
end

function DivineXiuErClgExtParallelView:_onClearFmtColUI()
	self._fmtScrollList:dispose()
end

function DivineXiuErClgExtParallelView:_updateFmtCell(view, cell, dataBitId, tag)
	local isPass = DivineXiuErClgController.instance:isPassTierStageOfExt(self._activityId, self._tierId, dataBitId)
	local stageData = DivineXiuErClgConfig.instance:getDxecExtStageData(self._activityId, self._tierId, dataBitId)
	local creepsMasterId = stageData.creepsMasterId
	local masterData = DivineXiuErClgConfig.instance:getDxecCreepsMasterData(creepsMasterId)
	local creepsCfg = DivineXiuErClgConfig.instance:getDxecCreepsCfg(creepsMasterId)
	local mainGo = cell.gameObject
	local btnEnter = goutil.findChild(mainGo, "btnEnter")
	local txtCond = goutil.findChildTextComponent(mainGo, "txtCond")
	local fmt = goutil.findChild(mainGo, "fmt")
	local fmtView = goutil.findChild(mainGo, "fmt/fmtView")
	local imgPass = goutil.findChild(mainGo, "fmt/imgPass")

	for posId = 1, fmtView.transform.childCount do
		local go = fmtView.transform:GetChild(posId - 1)
		local icon = goutil.findChild(go, "icon")
		local creepsData

		for _, cData in ipairs(creepsCfg) do
			if cData.posId == posId then
				creepsData = cData

				break
			end
		end

		if creepsData then
			local skinId = checknumber(creepsData.faceId)

			if skinId == 0 then
				skinId = creepsData.raceId
			end

			local proxy = MaterialMgr.setCell(MatType.Pet, skinId, icon)

			if proxy then
				local raceId = creepsData.raceId
				local level = creepsData.lv
				local awakenLv = 1

				proxy.binder:setClickCallBack(function()
					local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, level, awakenLv, skinId)

					CommonTipsMgr.instance:showPetTips(tmpMo, true)
				end)
			end
		else
			MaterialMgr.resetAll(icon)
		end
	end

	GameUtil.SetActive(imgPass, isPass)
	GameUtil.SetGray(btnEnter, isPass)

	txtCond.text = masterData.WinDesc

	GameUtil.addClickHandler(btnEnter, GameUtil.handler(self._onClickFmtCellBtnEnter, self, dataBitId))
end

function DivineXiuErClgExtParallelView:_clearFmtCell(mainGo)
	local fmtView = goutil.findChild(mainGo, "fmt/fmtView")
	local btnEnter = goutil.findChild(mainGo, "btnEnter")

	for posId = 1, fmtView.transform.childCount do
		local go = fmtView.transform:GetChild(posId - 1)
		local icon = goutil.findChild(go, "icon")

		MaterialMgr.resetAll(icon)
	end

	GameUtil.rmClickHandler(btnEnter)
end

function DivineXiuErClgExtParallelView:_onClickFmtCellBtnEnter(dataBitId)
	local result, tips = DivineXiuErClgController.instance:getTryFightExtClgResultAndTips(self._activityId, self._tierId, dataBitId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIJumper.instance:clear()
	UIJumper.instance:pushOneStack(ViewName.DivineXiuErClgMainView, nil)
	UIJumper.instance:pushOneStack(ViewName.DivineXiuErClgExtView, nil, self._activityId)
	DivineXiuErClgController.instance:enterBattleOfExtClg(self._activityId, self._tierId, dataBitId)
end

return DivineXiuErClgExtParallelView
