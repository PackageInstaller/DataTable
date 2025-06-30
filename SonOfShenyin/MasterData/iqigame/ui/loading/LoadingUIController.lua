-- chunkname: @IQIGame\\UI\\Loading\\LoadingUIController.lua

local m = {
	CustomProgress = 0,
	curLoadingSceneId = 0,
	canShowCustomProgress = true,
	SceneProgress = 0,
	PreloadProgressWeight = 0,
	SceneProgressWeight = 0,
	Progress = 0,
	ProgressForUpdateShow = 0,
	canShowSceneProgress = true,
	CustomProgressWeight = 0,
	Count = 0,
	canShowPreloadProgress = true,
	PreloadProgress = 0,
	UpdateElapsedTime = 0,
	progressSpeed = 1
}

function m.New(NotifyRefreshProgressFunc)
	local obj = Clone(m)

	obj:Init(NotifyRefreshProgressFunc)

	return obj
end

function m:Init(NotifyRefreshProgressFunc)
	self.NotifyRefreshProgressFunc = NotifyRefreshProgressFunc

	function self.DelegateOnLoadSceneUpdate(sender, event)
		self:OnLoadSceneUpdate(sender, event)
	end

	function self.DelegateOnPreloadAssetsUpdate(sender, args)
		self:OnPreloadAssetsUpdate(sender, args)
	end

	function self.DelegateOnLuaCustomPreloadUpdate(loadedNum, totalNum)
		self:OnLuaCustomPreloadUpdate(loadedNum, totalNum)
	end

	function self.DelegateOnCustomPreloadUpdate(sender, args)
		self:OnCustomPreloadUpdate(sender, args)
	end
end

function m:Show(curLoadingSceneId, canShowCustomProgress)
	self.curLoadingSceneId = tonumber(curLoadingSceneId)
	self.canShowSceneProgress = true
	self.canShowPreloadProgress = self:CheckCanShowPreloadProgress(self.curLoadingSceneId)
	self.canShowCustomProgress = canShowCustomProgress ~= nil and canShowCustomProgress or self:CheckCanShowCustomProgress(self.curLoadingSceneId)
	self.SceneProgressWeight = (self.canShowPreloadProgress or self.canShowCustomProgress) and 0.1 or 1

	if self.canShowPreloadProgress then
		if self.canShowCustomProgress then
			self.PreloadProgressWeight = 0.4
		else
			self.PreloadProgressWeight = 0.9
		end
	else
		self.PreloadProgressWeight = 0
	end

	if self.canShowCustomProgress then
		if self.canShowPreloadProgress then
			self.CustomProgressWeight = 0.5
		else
			self.CustomProgressWeight = 0.9
		end
	else
		self.CustomProgressWeight = 0
	end

	if self.SceneProgressWeight + self.PreloadProgressWeight + self.CustomProgressWeight ~= 1 then
		local errorMsg = "LoadingNormalUI  ERROR>>>>> 场景id={0}的进度值权重计算错误，请检查逻辑\n"

		errorMsg = errorMsg .. "self.canShowPreloadProgress={1}  self.canShowCustomProgress={2}\n"
		errorMsg = errorMsg .. "self.SceneProgressWeight={3}  self.PreloadProgressWeight={4}  self.CustomProgressWeight={5}\n"

		logError(errorMsg, self.curLoadingSceneId, self.canShowPreloadProgress, self.canShowCustomProgress, self.SceneProgressWeight, self.PreloadProgressWeight, self.CustomProgressWeight)
	end

	self.Count = 0
	self.Progress = 0
	self.SceneProgress = 0
	self.PreloadProgress = 0
	self.CustomProgress = 0
	self.ProgressForUpdateShow = 0

	self:UpdateProgress()
	self:NotifyRefreshProgress()
end

function m:AddListeners()
	GameEntry.LuaEvent:Subscribe(LoadSceneUpdateEventArgs.EventId, self.DelegateOnLoadSceneUpdate)
	GameEntry.LuaEvent:Subscribe(PreloadProgressEventArgs.EventId, self.DelegateOnPreloadAssetsUpdate)
	GameEntry.LuaEvent:Subscribe(LoadSceneCustomPreloadEventArgs.EventId, self.DelegateOnCustomPreloadUpdate)
	EventDispatcher.AddEventListener(EventID.SceneCustomPreloadUpdate, self.DelegateOnLuaCustomPreloadUpdate)
end

function m:RemoveListeners()
	GameEntry.LuaEvent:Unsubscribe(LoadSceneUpdateEventArgs.EventId, self.DelegateOnLoadSceneUpdate)
	GameEntry.LuaEvent:Unsubscribe(PreloadProgressEventArgs.EventId, self.DelegateOnPreloadAssetsUpdate)
	GameEntry.LuaEvent:Unsubscribe(LoadSceneCustomPreloadEventArgs.EventId, self.DelegateOnCustomPreloadUpdate)
	EventDispatcher.RemoveEventListener(EventID.SceneCustomPreloadUpdate, self.DelegateOnLuaCustomPreloadUpdate)
end

function m:OnLoadSceneUpdate(sender, event)
	self.SceneProgress = event.Progress

	if self.SceneProgress > 0.89 then
		self.SceneProgress = 1
	end

	self:UpdateProgress()
end

function m:OnPreloadAssetsUpdate(sender, args)
	self.PreloadProgress = args.Count / args.TotalCount

	self:UpdateProgress()
end

function m:OnLuaCustomPreloadUpdate(loadedNum, totalNum)
	self.CustomProgress = loadedNum / totalNum

	self:UpdateProgress()
end

function m:OnCustomPreloadUpdate(sender, args)
	self.CustomProgress = args.LoadedNum / args.TotalNum

	self:UpdateProgress()
end

function m:OnUpdate(elapseSeconds, realElapseSeconds)
	self.UpdateElapsedTime = self.UpdateElapsedTime + realElapseSeconds

	if self.UpdateElapsedTime >= 0.1 then
		self.UpdateElapsedTime = 0
		self.Count = self.Count + 1
	end

	local progressDelta = math.abs(self.Progress - self.ProgressForUpdateShow)

	if progressDelta <= 0.1 then
		self.progressSpeed = 0.1
	elseif progressDelta <= 0.3 then
		self.progressSpeed = 0.3
	elseif progressDelta <= 0.5 then
		self.progressSpeed = 0.5
	else
		self.progressSpeed = 1.5
	end

	if self.Progress >= 0.95 then
		self.ProgressForUpdateShow = self.Progress
	else
		self.ProgressForUpdateShow = math.clamp(self.ProgressForUpdateShow + self.progressSpeed * elapseSeconds, 0, self.Progress)
	end

	self:NotifyRefreshProgress()
end

function m:UpdateProgress()
	self.Progress = self.SceneProgress * self.SceneProgressWeight + self.PreloadProgress * self.PreloadProgressWeight + self.CustomProgress * self.CustomProgressWeight

	if self.Progress > 0.99 then
		self.Progress = 1
	end
end

function m:NotifyRefreshProgress()
	self.NotifyRefreshProgressFunc(self.ProgressForUpdateShow, self.Count)
end

function m:CheckCanShowPreloadProgress(targetSceneId)
	for _, node in pairs(CfgPreloadTable) do
		if node.SceneID == targetSceneId then
			return true
		end
	end

	return false
end

function m:CheckCanShowCustomProgress(targetSceneId)
	if targetSceneId == SceneID.Battle then
		return true
	end

	return false
end

function m:Dispose()
	return
end

return m
