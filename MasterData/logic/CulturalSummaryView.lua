-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/cultural/CulturalSummaryView.lua

module("logic.extensions.operationsummary.view.cultural.CulturalSummaryView", package.seeall)

local CulturalSummaryView = class("CulturalSummaryView", ActivityGrandSummaryView)

function CulturalSummaryView:_getSumActivityId()
	local key = self._viewPresentor.viewName
	local data = OperationSummaryConfig.instance:getSummaryStartUpData(key)

	if data == nil then
		printError(string.format("key错误,无法读到正确配置.( key = %s )", key))

		return
	end

	return data.activityId
end

function CulturalSummaryView:buildUI()
	CulturalSummaryView.super.buildUI(self)

	self._btnShowCol = goutil.findChild(self.mainGO, "btnShowCol")
	self._btnChange = goutil.findChild(self.mainGO, "btnChange")
	self._btnPV = goutil.findChild(self.mainGO, "btnPV")
	self._btnPVRedpoint = goutil.findChild(self.mainGO, "btnPV/redpoint")
	self._boardEff = goutil.findChild(self.mainGO, "boardEff")
	self._tweenPool = {}
end

function CulturalSummaryView:bindEvents()
	CulturalSummaryView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnChange, self._onClickBtnChange, self)
	GameUtil.addClickHandler(self._btnPV, self._onClickBtnPv, self)
end

function CulturalSummaryView:unbindEvents()
	CulturalSummaryView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnChange)
	GameUtil.rmClickHandler(self._btnPV)
end

function CulturalSummaryView:onEnter()
	CulturalSummaryView.super.onEnter(self)

	self._pvOnceRed = "o3"

	RedPointController.instance:regRedPoint(self._btnPVRedpoint, self._pvOnceRed)
end

function CulturalSummaryView:onEnterFinished()
	CulturalSummaryView.super.onEnterFinished(self)

	local effParent = self._boardEff
	local pathName = "20220902/yuejumianban/fx_ui_yuejumianban"

	UIEffectManager.instance:stopEffect(self._bgEff)

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._bgEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function CulturalSummaryView:onExit()
	CulturalSummaryView.super.onExit(self)
	self:clearShowAnim()
	self:clearBtnShowCol()
	UIEffectManager.instance:stopEffect(self._bgEff)

	self._bgEff = nil

	RedPointController.instance:unregRedPoint(self._btnPVRedpoint)
end

function CulturalSummaryView:onUpdateUI()
	CulturalSummaryView.super.onUpdateUI(self)
	self:updateBtnShowCol()
end

function CulturalSummaryView:CreatActivity()
	if self._cellListPool == nil then
		self._cellListPool = {}

		for _, data in pairs(self.cfg_task_items) do
			if string.nilorempty(data.cellName) then
				printError("该活动不允许cellName为空")

				break
			end

			local cell = self:createActCell(data)
			local key = data.cellName

			self._cellListPool[key] = self._cellListPool[key] or {}

			table.insert(self._cellListPool[key], cell)
		end
	end

	self._animClipsPool = self._animClipsPool or {}

	for key, cellList in pairs(self._cellListPool) do
		local infoList = {}

		for _, cell in ipairs(cellList) do
			local info = {
				cell = cell,
				isInShowTime = GameUtil.getTimePeriodType(cell.data.startTime, cell.data.endTime) == GameUtil.inTimePeriod
			}

			table.insert(infoList, info)
		end

		table.sort(infoList, function(a, b)
			return a.cell.data.id < b.cell.data.id
		end)

		if self._animClipsPool then
			if not self._animClipsPool[key] then
				local oldAnimClips = {}
				local var_11_1 = {
					infoList = infoList
				}

				var_11_1.showType = oldAnimClips.showType or false
				var_11_1.isNeedAnim = oldAnimClips.isNeedAnim or false

				if oldAnimClips.showType then
					var_11_1.curIdx = #infoList or 1
				end

				self._animClipsPool[key] = var_11_1
			end
		end
	end
end

function CulturalSummaryView:getPoolKey(cellName)
	return cellName .. "_cell"
end

function CulturalSummaryView:updateActivity()
	for key, animClips in pairs(self._animClipsPool) do
		for _, info in ipairs(animClips.infoList) do
			local cell = info.cell

			self:updateActivityCell(cell)
			GameUtil.SetActive(cell.mainGo, info.isInShowTime and animClips.showType)
		end
	end
end

function CulturalSummaryView:updateBtnShowCol()
	local parent = self._btnShowCol.transform

	for idx = 1, parent.childCount do
		local mainGo = parent:GetChild(idx - 1)
		local redPoint = goutil.findChild(mainGo, "redpoint")

		GameUtil.SetActive(redPoint, false)
		RedPointController.instance:unregRedPoint(redPoint)

		local redIdList = {}

		for key, cellList in pairs(self._cellListPool) do
			for _, cell in ipairs(cellList) do
				local isSameName = self:getPoolKey(mainGo.name) == cell.data.cellName
				local isUnlcok = OpSummaryController.instance:isUnlockAsTab(cell.data.id)

				if isSameName and isUnlcok then
					if not string.nilorempty(cell.data.redpointId) then
						for _, redId in ipairs(string.split(cell.data.redpointId or "", "#")) do
							table.insert(redIdList, redId)
						end
					end

					table.insert(redIdList, OpSummaryController.instance:getRedIdAsTabNew(cell.data.id))
				end
			end
		end

		RedPointController.instance:regRedPoint(redPoint, unpack(redIdList))

		local taskCfg = OperationSummaryConfig.instance:getTaskDetailsCfg(self._activityId)

		for key, cellList in pairs(self._cellListPool) do
			for _, cell in ipairs(cellList) do
				local isSameName = self:getPoolKey(mainGo.name) == cell.data.cellName

				if isSameName then
					for _, taskData in pairs(taskCfg) do
						if cell.data.showType ~= 0 and cell.data.showType == taskData.showType and OpSummaryController.instance:isUnlockAsTab(cell.data.id) and OpSummaryController.instance:isCanGetPrizeAsTask(taskData.id) then
							RedPointController.instance:unregRedPoint(cell.redPoint)
							GameUtil.SetActive(redPoint, true)

							break
						end
					end
				end
			end
		end

		GameUtil.addClickHandler(mainGo, GameUtil.handler(self.onClickBtnShow, self, mainGo))
	end
end

function CulturalSummaryView:clearBtnShowCol()
	local parent = self._btnShowCol.transform

	for idx = 1, parent.childCount do
		local mainGo = parent:GetChild(idx - 1)
		local redPoint = goutil.findChild(mainGo, "redpoint")

		RedPointController.instance:unregRedPoint(redPoint)
		GameUtil.rmClickHandler(mainGo)
	end
end

function CulturalSummaryView:onClickBtnShow(go)
	local key = self:getPoolKey(go.name)

	if self._animClipsPool[key] == nil then
		return
	end

	if self._animClipsPool[key].isNeedAnim == true then
		return
	end

	self._animClipsPool[key].isNeedAnim = true

	self:playeCellsShowAnim()
end

function CulturalSummaryView:playeCellsShowAnim()
	removetimer(self.updateTime, self)
	settimer(0.1, self.updateTime, self, true)
end

function CulturalSummaryView:updateTime()
	local doNum = 0

	for key, animClips in pairs(self._animClipsPool) do
		if animClips.isNeedAnim then
			local curIdx = animClips.curIdx
			local len = #animClips.infoList
			local delta = animClips.showType and -1 or 1
			local endIdx = animClips.showType and 1 or len

			for i = curIdx, endIdx, delta do
				if animClips.infoList[i].isInShowTime then
					curIdx = i

					break
				end
			end

			local cell = animClips.infoList[curIdx].cell

			if cell then
				doNum = doNum + 1

				if animClips.showType == false then
					local function callBack()
						GameUtil.setLocalScale(cell.mainGo, 1, 1, 1)
					end

					self:doScaleAnim(cell.mainGo, 1.2, callBack)
					GameUtil.SetActive(cell.mainGo, true)
				else
					local function callBack()
						GameUtil.SetActive(cell.mainGo, false)
						GameUtil.setLocalScale(cell.mainGo, 1, 1, 1)
					end

					self:doScaleAnim(cell.mainGo, 0.8, callBack)
				end

				if len < curIdx + delta or curIdx + delta < 1 then
					self._animClipsPool[key].curIdx = curIdx
					self._animClipsPool[key].isNeedAnim = false
					self._animClipsPool[key].showType = not self._animClipsPool[key].showType
				else
					self._animClipsPool[key].curIdx = Mathf.Clamp(curIdx + delta, 1, len)
				end
			end
		end
	end

	if doNum == 0 then
		removetimer(self.updateTime, self)

		return
	end
end

function CulturalSummaryView:doScaleAnim(go, scale, callBack)
	self:clearAnimByGo(go)

	self._tweenPool[go] = go.transform:DOScale(Vector3.New(scale, scale, scale), 0.2):SetEase(DG.Tweening.Ease.InQuad):SetLoops(2, DG.Tweening.LoopType.Yoyo):OnComplete(callBack)
end

function CulturalSummaryView:clearAnimByGo(go)
	if self._tweenPool[go] then
		self._tweenPool[go]:Kill(true)
	end
end

function CulturalSummaryView:clearShowAnim()
	removetimer(self.updateTime, self)

	for key, animClips in pairs(self._animClipsPool) do
		self._animClipsPool[key].isNeedAnim = false
	end

	for _, cellList in pairs(self._cellListPool) do
		for _, cell in ipairs(cellList) do
			self:clearAnimByGo(cell.mainGo)
		end
	end
end

function CulturalSummaryView:_onClickBtnChange()
	SurveyController.instance:reportBehavior("201145")
	GotoMgr.gotoByString("func#191#17#17055")
end

function CulturalSummaryView:_onClickBtnPv()
	RedPointController.instance:saveUserOnceRedPoint(self._pvOnceRed, true)
	UIStateManager.instance:push(ViewName.ActivityOP220701VedioView, "cg_0_0")
end

return CulturalSummaryView
