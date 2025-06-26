-- chunkname: @IQIGame\\UI\\Maze\\MazeBattleVideoElement.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateOnMediaPlayerEvent(mediaPlayer, eventType, errorCode)
		self:OnMediaPlayerEvent(mediaPlayer, eventType, errorCode)
	end

	self.MediaMBCom = self.mediaPlayer:GetComponent(typeof(MediaMB))

	self:AddListeners()
end

function m:AddListeners()
	self.MediaMBCom:AddListener(self.delegateOnMediaPlayerEvent)
end

function m:RemoveListeners()
	self.MediaMBCom:RemoveListener(self.delegateOnMediaPlayerEvent)
end

function m:SetData(storySrc, callback)
	self.finishCallback = callback

	self.MediaMBCom:Rewind(false)
	self.MediaMBCom:OpenVideoFromFile(storySrc, true)

	self.MediaMBCom.Volume = SettingModule.currentMusicVolume
	self.MediaMBCom.Loop = false

	self.MediaMBCom:Play()
end

function m:OnMediaPlayerEvent(mediaPlayer, eventType, errorCode)
	if eventType == RenderHeads.Media.AVProVideo.MediaPlayerEvent.EventType.Error then
		self:PlayFinish()

		return
	end

	if eventType == RenderHeads.Media.AVProVideo.MediaPlayerEvent.EventType.FinishedPlaying then
		self:PlayFinish()
	end
end

function m:PlayFinish()
	if self.finishCallback ~= nil then
		self.finishCallback()

		self.finishCallback = nil
	end

	self:Hide()
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
