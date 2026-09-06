-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/judgmentdragonclg/view/JudgmentDragonClgStageView.lua

module("logic.extensions.judgmentdragonclg.view.JudgmentDragonClgStageView", package.seeall)

local JudgmentDragonClgStageView = class("JudgmentDragonClgStageView", ViewComponent)

function JudgmentDragonClgStageView:ctor()
	JudgmentDragonClgStageView.super.ctor(self)
end

function JudgmentDragonClgStageView:buildUI()
	JudgmentDragonClgStageView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")

	local tabScrView = self:getGo("tabCol/scrView")
	local tabScrCell = self:getGo("tabCol/scrCell")

	self._tabScrollerList = ScrollerList.create(tabScrView, tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))

	local fmtScrView = self:getGo("fmtCol/scrView")
	local fmtScrCell = self:getGo("fmtCol/scrCell")

	self._fmtScrollerList = ScrollerList.create(fmtScrView, fmtScrCell, GameUtil.handler(self._updateFmtCell, self), GameUtil.handler(self._clearFmtCell, self))
	self._txtTips = self:getTxt("tips/scrView/Viewport/Content")
	self._phasePrize = self:getGo("tips/prize")
	self._btnBuff = self:getGo("tabCol/btnBuff")
end

function JudgmentDragonClgStageView:bindEvents()
	JudgmentDragonClgStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClikBtnTip, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClikBtnBuff, self)
end

function JudgmentDragonClgStageView:unbindEvents()
	JudgmentDragonClgStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnBuff)
end

function JudgmentDragonClgStageView:onEnter()
	JudgmentDragonClgStageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = JudgmentDragonClgController.instance:getActivityType()

	local isInTime = JudgmentDragonClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._clgMo = JudgmentDragonClgController.instance:getClgMo(self._activityId)
	self._actData = JudgmentDragonClgConfig.instance:getActData(self._activityId)
	self._curTabIdx = self._curTabIdx or 0

	self.addGEvent(self, GlobalNotify.HandlePM_JudgmentDragonClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_JudgmentDragonClgResetRes, self._onUpdate, self)
	JudgmentDragonClgController.instance:sendPM_JudgmentDragonClgGetInfoReq(self._activityId)
end

function JudgmentDragonClgStageView:onExit()
	JudgmentDragonClgStageView.super.onExit(self)
	self:_onClearTabCol()
	self:_onClearFmtCol()
end

function JudgmentDragonClgStageView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function JudgmentDragonClgStageView:_onUpdateData()
	self._tabInfoList = {}

	local cfg = JudgmentDragonClgConfig.instance:getPhaseCfg(self._activityId)

	if cfg then
		for index, data in ipairs(cfg) do
			local info = {}

			info.index = index
			info.phaseId = data.phaseId

			table.insert(self._tabInfoList, info)
		end
	end

	local isNeedUpdateTabIdx = false

	isNeedUpdateTabIdx = isNeedUpdateTabIdx or self._curTabIdx <= 0

	if not isNeedUpdateTabIdx then
		local info = self:_getCurTabInfo()

		if info then
			if not info.phaseId then
				local phaseId = 0

				isNeedUpdateTabIdx = self._clgMo:isPassPhase(phaseId)
			end
		end
	end

	if isNeedUpdateTabIdx then
		for _, info in ipairs(self._tabInfoList) do
			local phaseId = info.phaseId

			if self._clgMo:isUnlockPhase(phaseId) then
				self._curTabIdx = info.index

				if not self._clgMo:isPassPhase(phaseId) then
					break
				end
			end
		end
	end
end

function JudgmentDragonClgStageView:_getCurTabInfo()
	return self._tabInfoList[self._curTabIdx]
end

function JudgmentDragonClgStageView:_onUpdateUI()
	self:_onUpdateTabColUI()
	self:_onUpdateFmtColUI()
end

function JudgmentDragonClgStageView:_onUpdateTabColUI()
	self._tabScrollerList:reloadData(self._tabInfoList)
end

function JudgmentDragonClgStageView:_onClearTabCol()
	self._tabScrollerList:dispose()
end

function JudgmentDragonClgStageView:_updateTabCell(view, cell, info, tag)
	local phaseId = info.phaseId
	local data = JudgmentDragonClgConfig.instance:getPhaseData(self._activityId, phaseId)
	local isUnlockPhase = self._clgMo:isUnlockPhase(phaseId)
	local isPassPhase = self._clgMo:isPassPhase(phaseId)
	local mainGo = cell.gameObject
	local txtStage = goutil.findChildTextComponent(mainGo, "txtStage")
	local imgLock = goutil.findChild(mainGo, "imgLock")
	local imgPass = goutil.findChild(mainGo, "imgPass")

	if self._strTxtStage == nil then
		self._strTxtStage = txtStage.text
	end

	txtStage.text = string.format(self._strTxtStage, phaseId)

	GameUtil.SetActive(imgPass, isPassPhase)
	GameUtil.SetActive(imgLock, not isUnlockPhase)
	GameUtil.addClickHandler(cell, GameUtil.handler(self._clickTabCell, self, info))
end

function JudgmentDragonClgStageView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function JudgmentDragonClgStageView:_clickTabCell(info)
	local result = JudgmentDragonClgController.instance:getTryResultAndTipsEnterPhase(true, self._activityId, info.phaseId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	self._curTabIdx = info.index

	self:_onUpdateUI()
end

function JudgmentDragonClgStageView:_onUpdateFmtColUI()
	local tabInfo = self:_getCurTabInfo()

	if tabInfo then
		if not tabInfo.phaseId then
			local phaseId = 0
			local phaseData = JudgmentDragonClgConfig.instance:getPhaseData(self._activityId, phaseId)
			local index = 0
			local cfg = JudgmentDragonClgConfig.instance:getStageCfg(self._activityId, phaseId) or {}

			for idx, data in ipairs(cfg) do
				index = idx - 1

				if not self._clgMo:isPassStage(phaseId, data.stageId) then
					break
				end
			end

			self._fmtScrollerList:reloadData(cfg)
			self._fmtScrollerList:MoveCellToCenter(index)

			if phaseData then
				self._txtTips.text = phaseData.ruleDesc or ""
			end

			if phaseData and not string.nilorempty(phaseData.prize) then
				local arr = string.split(phaseData.prize, "#")

				MaterialMgr.setCellByCfg(arr[1], self._phasePrize)
			else
				MaterialMgr.resetAll(self._phasePrize)
			end

			if phaseData then
				if not phaseData.terrainPlanId then
					local terrainPlanId = 0

					GameUtil.SetActive(self._btnBuff, terrainPlanId > 0)
				end
			end
		end
	end
end

function JudgmentDragonClgStageView:_onClearFmtCol()
	self._fmtScrollerList:dispose()
	MaterialMgr.resetAll(self._phasePrize)
end

function JudgmentDragonClgStageView:_updateFmtCell(view, cell, data, tag)
	local tabInfo = self:_getCurTabInfo()

	if tabInfo then
		if not tabInfo.phaseId then
			local phaseId = 0
			local stageId = data.stageId
			local isPass = self._clgMo:isPassStage(phaseId, stageId)
			local creepsMasterId = data.creepsMasterId
			local monsterData = JudgmentDragonClgConfig.instance:getMonsterData(creepsMasterId)
			local creepsCfg = JudgmentDragonClgConfig.instance:getCreepsCfg(creepsMasterId)
			local mainGo = cell.gameObject
			local btnEnter = goutil.findChild(mainGo, "btnEnter")
			local btnReset = goutil.findChild(mainGo, "btnReset")
			local fmt = goutil.findChild(mainGo, "fmt")
			local fmtView = goutil.findChild(mainGo, "fmt/fmtView")
			local imgPass = goutil.findChild(mainGo, "fmt/imgPass")
			local petScrView = goutil.findChild(mainGo, "petScrView")
			local petScrCell = goutil.findChild(mainGo, "petScrCell")
			local imgPetEmpty = goutil.findChild(mainGo, "imgPetEmpty")

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
			GameUtil.SetActive(btnEnter, not isPass)
			GameUtil.SetActive(btnReset, isPass)

			local raceIds = self._clgMo:getLockRaceIdsInStage(phaseId, stageId)

			if petScrView and petScrCell then
				self._petScrollListDic = self._petScrollListDic or {}

				if not self._petScrollListDic[mainGo] then
					local scrollList = ScrollerList.create(petScrView, petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

					self._petScrollListDic[mainGo] = scrollList

					scrollList:reloadData(raceIds)
				end
			end

			GameUtil.SetActive(imgPetEmpty, #raceIds <= 0)
			GameUtil.addClickHandler(btnEnter, function()
				if isPass then
					FloatWordMgr.instance:show("已通关")

					return
				end

				JudgmentDragonClgController.instance:enterBattle(self._activityId, phaseId, stageId)
			end, self)
			GameUtil.addClickHandler(btnReset, function()
				if not isPass then
					FloatWordMgr.instance:show("未通关")

					return
				end

				if self._clgMo:isPassPhase(phaseId) then
					FloatWordMgr.instance:show("本层已通关，无需重置")

					return
				end

				local tipsContent = "是否确认重置关卡？"

				local function okFunc()
					JudgmentDragonClgController.instance:sendPM_JudgmentDragonClgResetReq(self._activityId, phaseId, stageId)
				end

				TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
			end, self)
		end
	end
end

function JudgmentDragonClgStageView:_clearFmtCell(cell)
	local mainGo = cell.gameObject
	local fmtView = goutil.findChild(mainGo, "fmt/fmtView")
	local btnEnter = goutil.findChild(mainGo, "btnEnter")
	local btnReset = goutil.findChild(mainGo, "btnReset")

	for posId = 1, fmtView.transform.childCount do
		local go = fmtView.transform:GetChild(posId - 1)
		local icon = goutil.findChild(go, "icon")

		MaterialMgr.resetAll(icon)
	end

	if self._petScrollListDic then
		if self._petScrollListDic then
			self._petScrollListDic:dispose()

			self._petScrollListDic[mainGo] = nil
		end

		GameUtil.rmClickHandler(btnEnter)
		GameUtil.rmClickHandler(btnReset)
	end
end

function JudgmentDragonClgStageView:_updatePetCell(view, cell, raceId, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	GameUtil.SetActive(item, false)
	MaterialMgr.setIcon(item, MatType.Pet, raceId, function()
		GameUtil.SetActive(item, true)
	end, self)
	GameUtil.addClickHandler(mainGo, function()
		local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, 1, 1, raceId)

		CommonTipsMgr.instance:showPetTips(tmpMo, true)
	end, self)
end

function JudgmentDragonClgStageView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.clearIcon(item)
	GameUtil.rmClickHandler(mainGo)
end

function JudgmentDragonClgStageView:_onClikBtnTip()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function JudgmentDragonClgStageView:_onClikBtnBuff()
	local tabInfo = self:_getCurTabInfo()

	if tabInfo then
		if not tabInfo.phaseId then
			local phaseId = 0

			UIStateManager.instance:push(ViewName.JudgmentDragonClgStageResultView, self._activityId, phaseId)
		end
	end
end

return JudgmentDragonClgStageView
