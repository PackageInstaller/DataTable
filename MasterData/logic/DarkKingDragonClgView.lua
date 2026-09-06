-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedarkkingdragonclg/view/DarkKingDragonClgView.lua

module("logic.extensions.divinedarkkingdragonclg.view.DarkKingDragonClgView", package.seeall)

local DarkKingDragonClgView = class("DarkKingDragonClgView", ViewComponent)

function DarkKingDragonClgView:ctor()
	DarkKingDragonClgView.super.ctor(self)
end

function DarkKingDragonClgView:unbindEvents()
	DarkKingDragonClgView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnPrizeShow)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnShowMore)
	GameUtil.rmClickHandler(self._btnEnter)

	for _, cell in ipairs(self._phaseCelllist) do
		GameUtil.rmClickHandler(cell.btnSpace)
	end
end

function DarkKingDragonClgView:bindEvents()
	DarkKingDragonClgView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnPrizeShow, self._onClickShowPrize, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	GameUtil.addClickHandler(self._btnShowMore, self._onClickShowMore, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickEnter, self)

	for i, cell in ipairs(self._phaseCelllist) do
		GameUtil.addClickHandler(cell.btnSpace, GameUtil.handler(self._onClickSpace, self, i))
	end
end

function DarkKingDragonClgView:buildUI()
	DarkKingDragonClgView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnPrizeShow = self:getGo("btnPrizeShow")
	self._btnReset = self:getGo("btnReset")
	self._goBuff = self:getGo("lastPhase/buff")
	self._txtBuff = self:getTxt("lastPhase/buff/txt")
	self._btnShowMore = self:getGo("lastPhase/btnShowMore")
	self._btnEnter = self:getGo("lastPhase/btnEnter")
	self._phaseCelllist = {}

	for i = 1, 3 do
		local cell = {}

		cell.go = self:getGo("roots/root" .. i)
		cell.line = goutil.findChild(cell.go, "line")
		cell.lock = goutil.findChild(cell.go, "lock")
		cell.btnSpace = goutil.findChild(cell.go, "btnSpace")
		cell.select = goutil.findChild(cell.go, "select")
		cell.container = goutil.findChild(cell.go, "container")
		cell.cellcopy = goutil.findChild(cell.go, "cellcopy")
		cell.majorAxis = 0
		cell.minorAxis = 0
		cell.curAngle = 0
		cell.rotateCellList = {}
		self._phaseCelllist[i] = cell
	end
end

function DarkKingDragonClgView:onExit()
	DarkKingDragonClgView.super.onExit(self)

	for i, cell in ipairs(self._phaseCelllist) do
		for _, rotatecell in ipairs(cell.rotateCellList) do
			GameUtil.rmClickHandler(rotatecell.btn)
		end

		goutil.clearChildren(cell.container)

		cell.rotateCellList = {}
	end

	self:resetAllEff()
	removetimer(self._playBuffEffect, self)
	removetimer(self._onRotate, self)
end

function DarkKingDragonClgView:onEnter()
	DarkKingDragonClgView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DivineDarkKingDragonClgInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_DivineDarkKingDragonClgResetRes, self._updateUIByInfo, self)

	self._playEffId = 0
	self._playEffList = {}
	self._activityId = 526001

	local params = self:getOpenParam()

	if params then
		self._activityId = checknumber(params[1])
	end

	if self._lastClickPhaseId == nil then
		self._lastClickPhaseId = 0
	end

	if self._lastClickStageId == nil then
		self._lastClickStageId = 0
	end

	self:_updateUIByCfg()
	DivineDarkKingDragonClgController.instance:getInfo(self._activityId)
	DivineDarkKingDragonClgController.instance:showCI()

	self._isPlayAni = false
end

function DarkKingDragonClgView:_updateUIByCfg()
	self._actCfg = DivineDarkKingDragonClgConfig.instance:getActCfgById(self._activityId)
	self._phaseCfgs = DivineDarkKingDragonClgConfig.instance:getPhaseCfgsByActId(self._activityId) or {}
	self._stageMaps = DivineDarkKingDragonClgConfig.instance:getStageMapsByActivityId(self._activityId) or {}

	for i, cell in ipairs(self._phaseCelllist) do
		local phaseCfg = self._phaseCfgs[i]

		if phaseCfg then
			cell.majorAxis = phaseCfg.majorAxis or 200
			cell.minorAxis = phaseCfg.minorAxis or 100
			cell.curAngle = 0

			for _, rotatecell in ipairs(cell.rotateCellList) do
				GameUtil.rmClickHandler(rotatecell.btn)
			end

			goutil.clearChildren(cell.container)

			cell.rotateCellList = {}

			if not self._stageMaps[i] then
				local stageCfgs = {}

				for j, stageCfg in ipairs(stageCfgs) do
					local rotatecell = {}

					rotatecell.cfg = stageCfg
					rotatecell.go = goutil.cloneAndSetParent(cell.cellcopy, cell.container.transform, "cell_" .. i .. "_" .. j)
					rotatecell.btn = goutil.findChild(rotatecell.go, "btn")
					rotatecell.select = goutil.findChild(rotatecell.go, "select")
					rotatecell.txtAngle = goutil.findChildTextComponent(rotatecell.go, "select/angle/txt")

					GameUtil.addClickHandler(rotatecell.btn, GameUtil.handler(self._onClickStage, self, i, j))
					goutil.setActive(rotatecell.go, true)
					table.insert(cell.rotateCellList, rotatecell)
				end

				goutil.setActive(cell.cellcopy, false)
			end
		end
	end
end

function DarkKingDragonClgView:_updateUIByInfo()
	self._curBuffNum = DivineDarkKingDragonClgModel.instance:getCurBuffNum(self._activityId)
	self._phaseInfoMap = DivineDarkKingDragonClgModel.instance:getPhaseInfo(self._activityId) or {}
	self._txtBuff.text = string.format("x %d", self._curBuffNum)
	self._curClgPhaseId = 0
	self._curResetPhaseId = 0

	for phaseId, cfg in ipairs(self._phaseCfgs) do
		local info = DivineDarkKingDragonClgModel.instance:getPhaseInfo(self._activityId, phaseId)

		if info then
			if not info.info.stages then
				local stages = {}
				local stageCfgs = DivineDarkKingDragonClgConfig.instance:getStageCfgsByPhaseId(self._activityId, phaseId) or {}

				if #stageCfgs > 0 and #stageCfgs > #stages then
					self._curClgPhaseId = phaseId

					if #stages <= 0 then
						self._curResetPhaseId = phaseId - 1

						break
					end

					self._curResetPhaseId = phaseId

					break
				end
			end
		end
	end

	local curPhaseInfo = DivineDarkKingDragonClgModel.instance:getPhaseInfo(self._activityId, self._curClgPhaseId)

	self._queuelist = {}
	self._sortList = {}

	if self._curClgPhaseId ~= #self._phaseCfgs and curPhaseInfo then
		if not curPhaseInfo.info.stages then
			do
				local stages = {}

				for _, stageInfo in ipairs(curPhaseInfo.info.stages) do
					table.insert(self._sortList, stageInfo)
				end

				ArraySort.sortOn(self._sortList, {
					function(a)
						return a.finishOrder
					end
				}, {
					ArraySort.NUMERIC
				})

				local curAngle = 0

				for _, stageInfo in ipairs(self._sortList) do
					local queueInfo = {}

					queueInfo.stageInfo = stageInfo
					curAngle = curAngle + DivineDarkKingDragonClgConfig.instance:getAngleByPhaseIdAndNum(self._activityId, self._curClgPhaseId, stageInfo.num)
					queueInfo.curAngle = curAngle

					table.insert(self._queuelist, queueInfo)
				end
			end

			if DivineDarkKingDragonClgController.instance:getNeedPlayAni() then
				self:forceUpdateUI()
				self:_playRotateAnimation()
				DivineDarkKingDragonClgController.instance:resetNeedPlayAni()

				goto label_8_0
			end
		end
	end

	self:forceUpdateUI()

	::label_8_0::
end

function DarkKingDragonClgView:_updateRotatePos(phaseId, angle)
	local cell = self._phaseCelllist[phaseId]

	if not cell then
		return
	end

	local rotateCellList = cell.rotateCellList

	if not cell.majorAxis then
		local majorAxis = 200

		if not cell.minorAxis then
			local minorAxis = 100
			local curAngle = -180 + checknumber(angle)
			local cosb = Mathf.Cos(0)
			local sinb = Mathf.Sin(0)

			for j, rotatecell in ipairs(rotateCellList) do
				local stageCfg = rotatecell.cfg

				if stageCfg then
					if not stageCfg.baseAngle then
						local baseAngle = 0
						local hudu = checknumber((baseAngle + curAngle) / 180) * math.pi
						local cosa = Mathf.Cos(hudu)
						local sina = Mathf.Sin(hudu)
						local posX = majorAxis * cosa * cosb + minorAxis * sina * sinb
						local posY = -majorAxis * cosa * sinb + minorAxis * sina * cosb

						rotatecell.txtAngle.text = string.format("%d°", 360 - (baseAngle + angle) % 360)

						GameUtil.setLocalPos(rotatecell.go, posX, -posY, 0)
					end
				end
			end
		end
	end
end

function DarkKingDragonClgView:_getCurPhaseRotateAngle()
	if #self._queuelist > 0 then
		return self._queuelist[#self._queuelist].curAngle
	end

	return 0
end

function DarkKingDragonClgView:forceUpdateUI()
	for i, cell in ipairs(self._phaseCelllist) do
		local rotateCellList = cell.rotateCellList
		local lock = cell.lock
		local line = cell.line
		local cellGo = cell.go
		local btnSpace = cell.btnSpace
		local select = cell.select

		goutil.setActive(select, false)
		goutil.setActive(line, false)
		goutil.setActive(lock, false)
		GameUtil.SetGray(btnSpace, true)

		for _, rotatecell in ipairs(rotateCellList) do
			goutil.setActive(rotatecell.select, false)
			goutil.setActive(rotatecell.btn, false)
		end

		if i == self._curClgPhaseId then
			goutil.setActive(line, true)
			cellGo.transform:SetAsLastSibling()

			local curPhaseInfo = DivineDarkKingDragonClgModel.instance:getPhaseInfo(self._activityId, self._curClgPhaseId)

			if curPhaseInfo then
				if not curPhaseInfo.lockRaceIds then
					do
						local rackIds = {}
						local phasecfg = self._phaseCfgs[i]

						if not phasecfg.lockNum then
							local lockNum = 0

							goutil.setActive(lock, lockNum > #rackIds)
							GameUtil.SetGray(btnSpace, lockNum > #rackIds)
						end
					end

					local angle = self:_getCurPhaseRotateAngle()

					self:_updateRotatePos(self._curClgPhaseId, angle)

					for _, rotatecell in ipairs(rotateCellList) do
						GameUtil.SetGray(rotatecell.btn, false)

						local stageInfo = DivineDarkKingDragonClgModel.instance:getStageInfo(self._activityId, i, rotatecell.cfg.stageId)

						if stageInfo then
							goutil.setActive(rotatecell.btn, false)
						else
							goutil.setActive(rotatecell.btn, true)
						end
					end
				end
			end
		elseif i > self._curClgPhaseId then
			for _, rotatecell in ipairs(rotateCellList) do
				goutil.setActive(rotatecell.btn, true)
				GameUtil.SetGray(rotatecell.btn, true)
			end

			goutil.setActive(lock, true)
			GameUtil.SetGray(btnSpace, true)
			self:_updateRotatePos(i, 0)
		end
	end

	goutil.setActive(self._goBuff, true)
	self:_updateStarSelect()
end

function DarkKingDragonClgView:_updateStarSelect()
	for i, cell in ipairs(self._phaseCelllist) do
		local rotateCellList = cell.rotateCellList

		for _, rotatecell in ipairs(rotateCellList) do
			goutil.setActive(rotatecell.select, false)

			if self._curClgPhaseId == i and rotatecell.cfg.stageId == self._lastClickStageId and i == self._lastClickPhaseId then
				local stageInfo = DivineDarkKingDragonClgModel.instance:getStageInfo(self._activityId, i, rotatecell.cfg.stageId)

				if not stageInfo then
					goutil.setActive(rotatecell.select, true)
				end
			end
		end
	end
end

function DarkKingDragonClgView:_playRotateAnimation()
	removetimer(self._onRotate, self)

	if #self._queuelist <= 0 then
		self:forceUpdateUI()

		return
	end

	goutil.setActive(self._goBuff, false)

	self._isPlayAni = true
	self._startAngle = 0

	if #self._queuelist > 1 then
		self._startAngle = self._queuelist[#self._queuelist - 1].curAngle
	end

	self._targetAngle = self._queuelist[#self._queuelist].curAngle

	settimer(0.02, self._onRotate, self, true)
end

function DarkKingDragonClgView:_onRotate()
	local phaseCell = self._phaseCelllist[self._curClgPhaseId]
	local rotateCellList = phaseCell.rotateCellList

	self._startAngle = self._startAngle + 1

	if self._startAngle > self._targetAngle then
		self._startAngle = self._targetAngle
	end

	self:_updateRotatePos(self._curClgPhaseId, self._startAngle)

	if GameUtil.GetActive(phaseCell.lock) then
		for _, rotatecell in ipairs(rotateCellList) do
			local stageInfo = DivineDarkKingDragonClgModel.instance:getStageInfo(self._activityId, self._curClgPhaseId, rotatecell.cfg.stageId)

			if not stageInfo then
				local checkAngle = self._startAngle + rotatecell.cfg.baseAngle

				if checkAngle % 360 == 0 then
					self:_playLaunchEffect(self._curClgPhaseId)
				end
			end
		end
	end

	if self._startAngle >= self._targetAngle then
		removetimer(self._onRotate, self)

		self._isPlayAni = false

		self:forceUpdateUI()
	end
end

function DarkKingDragonClgView:_onClickReset()
	if self._curResetPhaseId > 0 then
		local tips = string.format("是否重置%s数据?", self._phaseCfgs[self._curResetPhaseId].phaseName)

		TipsFacade.instance:openPopupWindow("提示", tips, function()
			DivineDarkKingDragonClgController.instance:resetClg(self._activityId, self._curResetPhaseId)
		end)
	elseif self._curClgPhaseId == 0 then
		local tips = string.format("已通关全部关卡，是否重置所有数据?", self._phaseCfgs[#self._phaseCfgs].phaseName)

		TipsFacade.instance:openPopupWindow("提示", tips, function()
			DivineDarkKingDragonClgController.instance:resetClg(self._activityId, 1)
		end)
	else
		TipsFacade.instance:openCommonTips("当前无挑战数据，不需要重置")
	end
end

function DarkKingDragonClgView:_onClickEnter()
	if self._isPlayAni then
		return
	end

	if self:_canEnterChapter(#self._phaseCfgs) then
		DivineDarkKingDragonClgController.instance:showMissionView(self._activityId, #self._phaseCfgs, 1)
	end
end

function DarkKingDragonClgView:_onClickTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function DarkKingDragonClgView:_onClickShowMore()
	UIStateManager.instance:push(ViewName.DarkKingDragonBuffView, self._activityId)
end

function DarkKingDragonClgView:_onClickShowPrize()
	UIStateManager.instance:push(ViewName.DarkKingDragonPrizeView, self._activityId)
end

function DarkKingDragonClgView:_onClickSpace(phaseId)
	UIStateManager.instance:push(ViewName.DarkKingDragonSpaceView, self._activityId, phaseId)
end

function DarkKingDragonClgView:_canEnterChapter(phaseId)
	if phaseId <= self._curClgPhaseId then
		return true
	end

	if self._curClgPhaseId == 0 then
		TipsFacade.instance:openCommonTips("已全通关，无需再挑战")

		return false
	end

	TipsFacade.instance:openCommonTips("请先通关外环星轨")

	return false
end

function DarkKingDragonClgView:_onClickStage(phaseId, stageId)
	if not self._isPlayAni and phaseId == self._curClgPhaseId then
		self._lastClickPhaseId = phaseId
		self._lastClickStageId = stageId

		self:_updateStarSelect()
	end

	if self:_canEnterChapter(phaseId) then
		DivineDarkKingDragonClgController.instance:showMissionView(self._activityId, phaseId, stageId)
	end
end

LaunchEffPathList = {
	"20251024/xinghuanchongneng/fx_ui_xinghuan_huang.prefab",
	"20251024/xinghuanchongneng/fx_ui_xinghuan_red.prefab",
	"20251024/xinghuanchongneng/fx_ui_xinghuan_zi.prefab",
	"20251024/xinghuanchongneng/fx_ui_xinghuan_xin.prefab"
}

function DarkKingDragonClgView:_playLaunchEffect(phaseId)
	if phaseId < 1 or phaseId > 3 then
		return
	end

	self._playEffId = self._playEffId + 1

	local playId = self._playEffId
	local effPath = LaunchEffPathList[phaseId]

	local function loadedHandler(handlerTarget, eff)
		eff:setParent(self.mainGO.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1, 1, 1)

		eff.hideEffWhileNotOnTop = true
	end

	local function onComplete()
		self:resetEff(playId)
	end

	self._playEffList[playId] = UIEffectManager.instance:playEffect(self, effPath, self.mainGO.transform, 0, 0, false, false, onComplete, loadedHandler, self)

	settimer(0.2 * (4 - phaseId), self._playBuffEffect, self, false)
end

function DarkKingDragonClgView:_playBuffEffect()
	self._playEffId = self._playEffId + 1

	local playId = self._playEffId
	local effPath = LaunchEffPathList[4]

	local function loadedHandler(handlerTarget, eff)
		eff:setParent(self.mainGO.transform)
		eff:setLocalPos(120, -30, 0)
		eff:setScale(1, 1, 1)

		eff.hideEffWhileNotOnTop = true
	end

	local function onComplete()
		self:resetEff(playId)
	end

	self._playEffList[playId] = UIEffectManager.instance:playEffect(self, effPath, self.mainGO.transform, 0, 0, false, false, onComplete, loadedHandler, self)
end

function DarkKingDragonClgView:resetEff(playEffId)
	self._playEffList = self._playEffList or {}

	local eff = self._playEffList[playEffId]

	if eff then
		UIEffectManager.instance:stopEffect(eff)

		self._playEffList[playEffId] = nil
	end
end

function DarkKingDragonClgView:resetAllEff()
	if self._playEffList then
		for k, v in pairs(self._playEffList) do
			if v then
				UIEffectManager.instance:stopEffect(v)
			end
		end

		self._playEffList = {}
	end
end

return DarkKingDragonClgView
