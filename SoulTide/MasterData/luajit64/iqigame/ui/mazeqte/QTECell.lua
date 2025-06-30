-- chunkname: @IQIGame\\UI\\MazeQTE\\QTECell.lua

local QTECell = {
	interval = 0.1,
	status = {
		Sort = 2,
		NoSort = 1,
		Failure = 4,
		Success = 3
	},
	goSignPool = {}
}

function QTECell.New(view, mainView)
	local obj = Clone(QTECell)

	obj:Init(view, mainView)

	return obj
end

function QTECell:Init(view, mainView)
	self.View = view
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(self.View, self)

	self.timer = Timer.New(function()
		self:OnTimer()
	end, self.interval, -1)

	function self.onClickBtnDelegate()
		self:OnClickBtn()
	end
end

function QTECell:Refresh(index, posIndex, cfgMazeQTEData)
	self.index = index
	self.posIndex = posIndex
	self.cfgMazeQTEData = cfgMazeQTEData
	self.curStatus = self.status.NoSort

	if self.cfgMazeQTEData.QTEType == 2 then
		self.curStatus = self.status.Sort
	end

	self:RefreshMisc()
	self:RefreshCell(self.curStatus)
end

function QTECell:OnHide()
	self:StopEffectSuccess()
	self:StopEffectSuccessLoop()
	self:StopEffectFailure()
	self:StopEffectFailureLoop()
	self:StopEffectTimeProgress()
	self:StopTimer()
	self:SetActive(false)

	self.cfgMazeQTEData = nil
end

function QTECell:OnDestroy()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.mainView = nil
end

function QTECell:RemoveListener()
	for i, v in ipairs(self.goSignPool) do
		if v ~= nil and i <= 2 then
			v:GetComponent("Button").onClick:RemoveListener(self.onClickBtnDelegate)
		end
	end
end

function QTECell:OnClickBtn()
	if self.mainView.isQTEFailure then
		return
	end

	GameEntry.Sound:PlaySound(MazeQTEUIApi:GetString("areaSoundId", self.posIndex), Constant.SoundGroup.UI)

	if self.isTimerRunning then
		if self.curStatus == self.status.NoSort then
			self:RefreshCell(self.status.Success)
		elseif self.curStatus == self.status.Sort then
			if self.mainView:CheckClickSuccessOnSort(self) then
				self:RefreshCell(self.status.Success)
			else
				self:RefreshCell(self.status.Failure)
			end
		end
	else
		self:RefreshCell(self.status.Failure)
	end
end

function QTECell:OnTimer()
	self.timeCounter = self.timeCounter + self.interval

	if self.timeCounter >= self.duration then
		self:RefreshCell(self.status.Failure)
	end
end

function QTECell:OnQTEFailure()
	self:StopTimer()
end

function QTECell:RefreshMisc()
	return
end

function QTECell:RefreshCell(status)
	self:StopEffectTimeProgress()

	self.curStatus = status

	local goSign = self.goSignPool[status]

	if goSign == nil then
		if status == self.status.NoSort then
			goSign = UnityEngine.Object.Instantiate(self.goNoSort)

			goSign:GetComponent("Button").onClick:AddListener(self.onClickBtnDelegate)

			goSign.transform:Find("Text_1"):GetComponent("Text").text = MazeQTEUIApi:GetString("goSignNoSort")
		elseif status == self.status.Sort then
			goSign = UnityEngine.Object.Instantiate(self.goSort)

			goSign:GetComponent("Button").onClick:AddListener(self.onClickBtnDelegate)

			goSign.transform:Find("Text_1"):GetComponent("Text").text = MazeQTEUIApi:GetString("goSignSort", self.index)
		elseif status == self.status.Failure then
			goSign = UnityEngine.Object.Instantiate(self.goFailure)
		elseif status == self.status.Success then
			goSign = UnityEngine.Object.Instantiate(self.goSuccess)
		end

		goSign.transform:SetParent(self.View.transform, false)

		goSign.transform.anchoredPosition = Vector2.New(0, 0)
		self.goSignPool[status] = goSign
	end

	for i, v in pairs(self.goSignPool) do
		if v ~= nil then
			v:SetActive(false)
			v:SetActive(i == status)

			if i == status then
				local tw = v:GetComponent("TweenScale")

				if tw ~= nil then
					tw.enabled = true

					tw:ResetToBeginning()
				end
			end
		end
	end

	self:StopTimer()

	if status == self.status.NoSort or status == self.status.Sort then
		self:StartTimer()
	end

	if status == self.status.Success then
		self:PlayEffectSuccess()
		self:PlayEffectSuccessLoop()
		self.mainView:OnQTECellClickSuccess()
	elseif status == self.status.Failure then
		self:PlayEffectFailure()
		self:PlayEffectFailureLoop()
		self.mainView:OnQTECellClickFailure()
	end
end

function QTECell:StartTimer()
	self.duration = self.cfgMazeQTEData.ButtonTime[self.index]

	if self.curStatus == self.status.NoSort or self.curStatus == self.status.Sort then
		self:PlayEffectTimeProgress()
	end

	self.timeCounter = 0
	self.isTimerRunning = true

	self.timer:Start()
end

function QTECell:StopTimer()
	self.isTimerRunning = false

	self.timer:Stop()
end

function QTECell:SetActive(vs)
	self.View:SetActive(vs)
end

function QTECell:PlayEffectSuccess()
	self:StopEffectSuccess()

	self.effectSuccessId = GameEntry.Effect:PlayUIMountPointEffect(9004003, 50000, 0, self.effectSuccess, self.mainView.canvas.sortingOrder + 4)
end

function QTECell:StopEffectSuccess()
	if self.effectSuccessId ~= nil then
		GameEntry.Effect:StopEffect(self.effectSuccessId)
	end
end

function QTECell:PlayEffectSuccessLoop()
	self:StopEffectSuccessLoop()

	self.effectSuccessLoopId = GameEntry.Effect:PlayUIMountPointEffect(9004001, 50000, 0, self.effectSuccessLoop, self.mainView.canvas.sortingOrder + 2)
end

function QTECell:StopEffectSuccessLoop()
	if self.effectSuccessLoopId ~= nil then
		GameEntry.Effect:StopEffect(self.effectSuccessLoopId)
	end
end

function QTECell:PlayEffectFailure()
	self:StopEffectFailure()

	self.effectFailureId = GameEntry.Effect:PlayUIMountPointEffect(9004004, 50000, 0, self.effectFailed, self.mainView.canvas.sortingOrder + 4)
end

function QTECell:StopEffectFailure()
	if self.effectFailureId ~= nil then
		GameEntry.Effect:StopEffect(self.effectFailureId)
	end
end

function QTECell:PlayEffectFailureLoop()
	self:StopEffectFailureLoop()

	self.effectFailureLoopId = GameEntry.Effect:PlayUIMountPointEffect(9004001, 50000, 0, self.effectFailedLoop, self.mainView.canvas.sortingOrder + 2)
end

function QTECell:StopEffectFailureLoop()
	if self.effectFailureLoopId ~= nil then
		GameEntry.Effect:StopEffect(self.effectFailureLoopId)
	end
end

function QTECell:PlayEffectTimeProgress()
	self:StopEffectTimeProgress()

	local effectId

	if self.duration == 1 then
		effectId = 9001903
	elseif self.duration == 1.5 then
		effectId = 9001904
	elseif self.duration == 2 then
		effectId = 9001905
	elseif self.duration == 2.5 then
		effectId = 9001906
	elseif self.duration == 3 then
		effectId = 9001907
	end

	self.effectTimeProgressId = GameEntry.Effect:PlayUIMountPointEffect(effectId, 50000, 0, self.effectTimeProgress, self.mainView.canvas.sortingOrder + 2)
end

function QTECell:StopEffectTimeProgress()
	if self.effectTimeProgressId ~= nil then
		GameEntry.Effect:StopEffect(self.effectTimeProgressId)
	end
end

function QTECell:SetParent(parent)
	self.View.transform:SetParent(parent, false)
end

function QTECell:CheckIsWorking()
	return self.cfgMazeQTEData ~= nil
end

return QTECell
