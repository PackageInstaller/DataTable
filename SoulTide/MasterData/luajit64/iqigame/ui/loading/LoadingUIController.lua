-- chunkname: @IQIGame\\UI\\Loading\\LoadingUIController.lua

local m = {
	CustomProgress = 0,
	LoadCustom = false,
	Count = 0,
	SceneProgress = 0,
	UpdateElapsedTime = 0,
	PreloadProgress = 0,
	Progress = 0
}

function m.New(view, loadCustom, setProgressTextFunc)
	local obj = Clone(m)

	obj:Init(view, loadCustom, setProgressTextFunc)

	return obj
end

function m:Init(view, loadCustom, setProgressTextFunc)
	self.View = view
	self.LoadCustom = loadCustom
	self.SetProgressTextFunc = setProgressTextFunc

	LuaCodeInterface.BindOutlet(self.View, self)

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

function m:Show(backgroundSprite, tipText)
	self.Background:GetComponent("Image").sprite = LuaCodeInterface.ToSprite(backgroundSprite)

	UGUIUtil.SetText(self.TipText, tipText)

	self.Count = 0
	self.Progress = 0
	self.SceneProgress = 0
	self.PreloadProgress = 0
	self.CustomProgress = 0

	self:ShowProgress()
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

		self:ShowProgress()
	end
end

function m:UpdateProgress()
	if not self.LoadCustom then
		self.Progress = self.SceneProgress * 0.1 + self.PreloadProgress * 0.9
	else
		self.Progress = self.SceneProgress * 0.1 + self.PreloadProgress * 0.4 + self.CustomProgress * 0.5
	end
end

function m:ShowProgress()
	self.SetProgressTextFunc(self.LoadingLabel, self.ProgressText, self.Count, self.Progress)

	if self.ProgressBar ~= nil then
		self.ProgressBar:GetComponent("Image").fillAmount = self.Progress
	end
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
