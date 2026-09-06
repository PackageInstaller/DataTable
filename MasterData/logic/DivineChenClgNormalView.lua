-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinechenclg/view/DivineChenClgNormalView.lua

module("logic.extensions.divinechenclg.view.DivineChenClgNormalView", package.seeall)

local DivineChenClgNormalView = class("DivineChenClgNormalView", ViewComponent)

function DivineChenClgNormalView:ctor()
	DivineChenClgNormalView.super.ctor(self)
end

function DivineChenClgNormalView:unbindEvents()
	DivineChenClgNormalView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DivineChenClgNormalView:bindEvents()
	DivineChenClgNormalView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DivineChenClgNormalView:buildUI()
	DivineChenClgNormalView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtBuffDesc = self:getTxt("tipsCol/txtBuffDesc")
	self._petItem = self:getGo("petItem")

	local tableviewGo = self:getGo("stage/tableview")
	local cellGo = self:getGo("stage/cell")

	self._tableview = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._slider = self:getGo("prize/slider")
	self._prizeList = self:getGo("prize/prizeList")
	self._conPrize = self:getGo("prize/con")
	self._sliderPrize = self:getSlider("prize/slider")
	self._txtNum = self:getTxt("prize/txtNum")
end

function DivineChenClgNormalView:onExit()
	DivineChenClgNormalView.super.onExit(self)
	self._tableview:dispose()

	self._subTabs = {}

	for i, cell in pairs(self._prizeConList) do
		GameUtil.rmClickHandler(cell.btn)

		if self._cellEffects and self._cellEffects[cell.go] then
			UIEffectManager.instance:stopEffect(self._cellEffects[cell.go])

			self._cellEffects[cell.go] = nil
		end
	end
end

function DivineChenClgNormalView:onEnter()
	DivineChenClgNormalView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())
	self._subTabs = {}

	self:_updateUIByCfg()
	self.addGEvent(self, GlobalNotify.DivineChenClgGetNormalInfoRes, self._updateUIByNormalInfo, self)
	self.addGEvent(self, GlobalNotify.DivineChenClgNormalGainPrize, self._updatePrizes, self)
	self.addGEvent(self, GlobalNotify.DivineChenClgNormalResetStageRes, self._updateStages, self)
	DivineChenClgController.instance:getNormalInfo(self._activityId)
end

function DivineChenClgNormalView:_updateUIByCfg()
	self._actCfg = DivineChenClgConfig.instance:getActCfg(self._activityId)
	self._normalPrizeCfgs = DivineChenClgConfig.instance:getNormalPrizeCfgs(self._activityId)
	self._normalStageCfgs = DivineChenClgConfig.instance:getNormalStageCfgsById(self._activityId)
	self._lastNorPrizeCfg = self._normalPrizeCfgs[#self._normalPrizeCfgs]

	local actType = ActivityDefineController.instance:getActTypeByActId(self._activityId)
	local startTimeStamp, endTimeStamp = ActivityDefineController.instance:getStartTimeAndEndTime(actType, self._activityId)
	local timeNow = ServerTime.now()
	local day = Mathf.Ceil((timeNow - startTimeStamp) / 86400) % #self._normalStageCfgs

	if day == 0 then
		day = #self._normalStageCfgs
	end

	self._curStageCfg = self._normalStageCfgs[day]
	self._curBuffCfg = DivineChenClgConfig.instance:getNormalBuffCfg(self._activityId, self._curStageCfg.buffId)
	self._curMasterIds = self._curStageCfg.creepsMasterId
	self._txtBuffDesc.text = self._curBuffCfg.buffDesc

	goutil.setActive(self._conPrize, false)
	goutil.clearChildren(self._prizeList)

	local sldStepLength = checknumber(500 / #self._normalPrizeCfgs)

	self._prizeConList = {}

	for i, cfg in ipairs(self._normalPrizeCfgs) do
		local cell = {}
		local name = "con_" .. i
		local go = goutil.findChild(self._prizeList, name)

		go = go or goutil.cloneAndSetParent(self._conPrize, self._prizeList.transform, name)
		cell.go = go
		cell.item = goutil.findChild(cell.go, "cell")
		cell.btn = goutil.findChild(cell.go, "btn")
		cell.txt = goutil.findChildTextComponent(cell.go, "txt")
		cell.txt.text = cfg.stageNum
		cell.gain = goutil.findChild(cell.go, "gain")
		cell.cfg = cfg

		GameUtil.setAnchoredPos(go, 0, sldStepLength * i)
		goutil.setActive(cell.go, true)
		MaterialMgr.setCellByCfg(cfg.prize, cell.item)
		GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickGainPrize, self, cfg))

		self._prizeConList[i] = cell
	end
end

function DivineChenClgNormalView:_updateUIByNormalInfo()
	self:_updateStages()
	self:_updatePrizes()
end

function DivineChenClgNormalView:_updatePrizes()
	local normalInfo = DivineChenClgModel.instance:getNormalInfoByActId(self._activityId)

	if normalInfo then
		if not normalInfo.gainedPrizeIds then
			local gainedPrizeIds = {}

			if normalInfo then
				if not normalInfo.historyPassNum then
					local historyPassNum = 0
					local stepValue = checknumber(1 / #self._normalPrizeCfgs)
					local curSldValue = 0
					local isNeedCal = true
					local lastNum = 0
					local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

					for i, cell in pairs(self._prizeConList) do
						local cfg = cell.cfg
						local isGain = table.keyof(gainedPrizeIds, i)

						goutil.setActive(cell.gain, isGain)

						local isAbleGain = historyPassNum >= cfg.stageNum and not isGain

						goutil.setActive(cell.btn, isAbleGain)

						if isNeedCal then
							if historyPassNum >= cfg.stageNum then
								curSldValue = curSldValue + stepValue
							else
								isNeedCal = false
								curSldValue = curSldValue + (historyPassNum - lastNum) / (cfg.stageNum - lastNum) * stepValue
							end
						end

						if self._cellEffects and self._cellEffects[cell.go] then
							UIEffectManager.instance:stopEffect(self._cellEffects[cell.go])

							self._cellEffects[cell.go] = nil
						end

						if isAbleGain then
							local uiEffect = UIEffectManager.instance:playEffect(self, effPath, cell.btn.transform, 0, 0, true, false, nil, function(target, eff)
								eff:setClipping(cell.btn.transform)
							end)

							uiEffect:setParent(cell.btn.transform)
							uiEffect:setLocalPos(0, 0, 0)
							uiEffect:setScaleXYZ(0.96, 1, 0.87)

							self._cellEffects = self._cellEffects or {}
							self._cellEffects[cell.go] = uiEffect
						end

						lastNum = cfg.stageNum
					end

					self._sliderPrize:SetValue(curSldValue)

					self._txtNum.text = historyPassNum
				end
			end
		end
	end
end

function DivineChenClgNormalView:_updateStages()
	local normalInfo = DivineChenClgModel.instance:getNormalInfoByActId(self._activityId)

	self._curStageDataList = {}

	for i, creepsMasterId in ipairs(self._curMasterIds) do
		local data = {}

		data.info = nil
		data.stageId = i
		data.creepsMasterId = creepsMasterId
		self._curStageDataList[i] = data
	end

	self._isNormalPass = false

	if normalInfo then
		if not normalInfo.passStages then
			for i, info in ipairs(normalInfo.passStages) do
				local data = self._curStageDataList[info.stageId]

				if data then
					data.info = info
				else
					printError("关卡数据空配置：" .. info.stageId)
				end
			end

			local passNum = normalInfo.historyPassNum

			self._isNormalPass = passNum >= self._lastNorPrizeCfg.stageNum
		end
	end

	self._tableview:reloadData(self._curStageDataList)
end

function DivineChenClgNormalView:_updateCell(view, cell, data)
	local btnEnter = goutil.findChild(cell.gameObject, "btnEnter")
	local btnReset = goutil.findChild(cell.gameObject, "btnReset")
	local emptyTips = goutil.findChild(cell.gameObject, "tips/emptyTips")
	local pass = goutil.findChild(cell.gameObject, "pass")
	local info = data.info
	local creepsMasterId = data.creepsMasterId

	goutil.setActive(btnEnter, not info)
	goutil.setActive(btnReset, info)
	goutil.setActive(pass, info)

	if self._isNormalPass then
		goutil.setActive(btnEnter, false)
		goutil.setActive(btnReset, false)
	end

	local fmtView = goutil.findChild(cell.gameObject, "fmt/fmtView")

	for posId = 1, fmtView.transform.childCount do
		local fmtCellGo = fmtView.transform:GetChild(posId - 1)
		local fmtIcon = goutil.findChild(fmtCellGo, "icon")

		MaterialMgr.resetAll(fmtIcon)
	end

	local creepCfgs = DivineChenClgConfig.instance:getCreepCfgs(creepsMasterId)

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

	GameUtil.addClickHandler(btnEnter, GameUtil.handler(self._onClickEnter, self, data))
	GameUtil.addClickHandler(btnReset, GameUtil.handler(self._onClickReset, self, data))

	if info then
		if not info.lockedPetIds then
			local lockedPetIds = {}

			goutil.setActive(emptyTips, #lockedPetIds <= 0)

			local subTab = self._subTabs[cell.gameObject]

			if not subTab then
				local petCom = goutil.findChild(cell.gameObject, "tips/Scrollerview")

				subTab = ScrollerList.create(petCom, self._petItem, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

				subTab:setCenterMode(true)

				self._subTabs[cell.gameObject] = subTab
			end

			subTab:reloadData(lockedPetIds)
			subTab:MoveCellToBegin(0)
		end
	end
end

function DivineChenClgNormalView:_clearCell(cell)
	local fmtView = goutil.findChild(cell.gameObject, "fmt/fmtView")

	for posId = 1, fmtView.transform.childCount do
		local fmtCellGo = fmtView.transform:GetChild(posId - 1)
		local fmtIcon = goutil.findChild(fmtCellGo, "icon")

		MaterialMgr.resetAll(fmtIcon)
	end

	local btnEnter = goutil.findChild(cell.gameObject, "btnEnter")
	local btnReset = goutil.findChild(cell.gameObject, "btnReset")

	GameUtil.rmClickHandler(btnEnter)
	GameUtil.rmClickHandler(btnReset)

	local subTab = self._subTabs[cell.gameObject]

	if subTab then
		subTab:dispose()
	end
end

function DivineChenClgNormalView:_updatePetCell(view, cell, data)
	local petCfg = DivineChenClgConfig.instance:getSupportPetCfg(self._activityId, data)
	local petStr = string.format("%s:%s:%s:1", MatType.Pet, petCfg.raceId, petCfg.lv)

	MaterialMgr.setCellByCfg(petStr, cell.gameObject)
end

function DivineChenClgNormalView:_clearPetCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function DivineChenClgNormalView:_onClickEnter(data)
	DivineChenClgController.instance:openNormalMissionView(self._activityId, data.stageId, data.creepsMasterId)
end

function DivineChenClgNormalView:_onClickReset(data)
	TipsFacade.instance:openPopupWindow("提示", "是否重置该关卡?", function()
		DivineChenClgController.instance:normalResetStage(self._activityId, data.stageId)
	end)
end

function DivineChenClgNormalView:_onClickGainPrize(cfg)
	DivineChenClgController.instance:normalGainPrize(self._activityId, cfg.prizeId)
end

return DivineChenClgNormalView
