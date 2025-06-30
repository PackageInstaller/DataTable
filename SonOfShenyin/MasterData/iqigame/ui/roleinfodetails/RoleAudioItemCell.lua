-- chunkname: @IQIGame\\UI\\RoleInfoDetails\\RoleAudioItemCell.lua

local m = {}

function m.New(view, mainView)
	local obj = Clone(m)

	obj:Init(view, mainView)

	return obj
end

function m:Init(view, mainView)
	self.View = view
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(self.View, self)
	self:InitDelegate()
	self:AddListeners()
end

function m:InitDelegate()
	function self.delegateOnClickButtonPlay()
		self:OnClickButtonPlay()
	end
end

function m:AddListeners()
	self.buttonPlay:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonPlay)
end

function m:RemoveListeners()
	self.buttonPlay:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonPlay)
	self:RemovePlaySoundListen()
end

function m:SetData(data, heroCid)
	self.cfgData = data

	self:RemovePlaySoundListen()
	self:SetProgress(1)
	LuaUtility.SetText(self.soundText, self.cfgData.CVName)
	LuaUtility.SetText(self.lockText, ConditionModule.GetDesc(self.cfgData.Condition[1]))
	LuaUtility.SetGameObjectShow(self.UnLockParent, ConditionModule.CheckMultipleAllIsPass(ConditionModule.CheckMultiple(self.cfgData.Condition)))
	LuaUtility.SetGameObjectShow(self.LockParent, not ConditionModule.CheckMultipleAllIsPass(ConditionModule.CheckMultiple(self.cfgData.Condition)))
	self:HidePlayFlag()
end

function m:SetProgress(value)
	LuaUtility.SetImageFillAmount(self.PlayParogress, value)
end

function m:OnClickButtonPlay()
	if not ConditionModule.CheckMultipleAllIsPass(ConditionModule.CheckMultiple(self.cfgData.Condition)) then
		return
	end

	self.mainView:StopLastSound()
	self.mainView:ResetLastSoundItem()

	self.mainView.lastSoundSerialID = LuaUtility.PlaySoundWithID(self.cfgData.CVSoundId)
	self.mainView.lastSoundItem = self
	self.mainView.lastSoundId = self.cfgData.CVSoundId

	self.mainView:ShowSoundText(self.cfgData.CVName)
	self:ShowPlayFlag()
end

function m:RemovePlaySoundListen()
	if self.playSoundDelegate then
		EventDispatcher.RemoveEventListener(EventID.RolePlaySoundEvent, self.playSoundDelegate)

		self.playSoundDelegate = nil
	end
end

function m:ShowPlayFlag()
	LuaUtility.SetGameObjectShow(self.PlayParent, true)
	LuaUtility.SetGameObjectShow(self.imagePlay, false)
end

function m:HidePlayFlag()
	LuaUtility.SetGameObjectShow(self.PlayParent, false)
	LuaUtility.SetGameObjectShow(self.imagePlay, true)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
