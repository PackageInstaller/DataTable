-- chunkname: @IQIGame\\UI\\RoleInfoDetails\\RoleAudioView.lua

local m = {
	Items = {},
	voicesList = {}
}
local RoleAudioItemCell = require("IQIGame.UI.RoleInfoDetails.RoleAudioItemCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:InitComponent()
	self:InitDelegate()
	self:AddListeners()
end

function m:InitComponent()
	self.wrapContent = self.ItemContent:GetComponent("ScrollAreaList")
	self.graphicColorChange = self.buttonInteract:GetComponent("GraphicColorChange")
end

function m:InitDelegate()
	function self.wrapContent.onRenderCell(cell)
		self:OnRenderItem(cell)
	end

	function self.delegateOnClickButtonInteract()
		self:OnClickButtonInteract()
	end

	function self.delegateOnClickButtonFight()
		self:OnClickButtonFight()
	end

	function self.OnSoundPlaySuccessEvent(sender, PlaySoundSuccessEventArgs)
		self:OnSoundPlaySuccess(sender, PlaySoundSuccessEventArgs)
	end
end

function m:AddListeners()
	self.buttonInteract:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonInteract)
	self.buttonFight:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonFight)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.PlaySoundSuccessEventArgs.EventId, self.OnSoundPlaySuccessEvent)
end

function m:RemoveListeners()
	self.buttonInteract:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonInteract)
	self.buttonFight:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonFight)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.PlaySoundSuccessEventArgs.EventId, self.OnSoundPlaySuccessEvent)
end

function m:OnClickButtonInteract()
	if self.currentShowVoiceType and self.currentShowVoiceType == Constant.HeroSoundType.Interact then
		return
	end

	self.voicesList = RoleInfoDetailsModule.GetHeroVoicesWithType(self.heroCid, Constant.HeroSoundType.Interact)

	self.wrapContent:Refresh(#self.voicesList)
	LuaUtility.SetGameObjectShow(self.interactOn, true)
	LuaUtility.SetGameObjectShow(self.fightOn, false)
	self.graphicColorChange:EnablePreset(1)
	self:StopUpdate()
	self:StopLastSound()
end

function m:OnClickButtonFight()
	if self.currentShowVoiceType and self.currentShowVoiceType == Constant.HeroSoundType.Fight then
		return
	end

	self.voicesList = RoleInfoDetailsModule.GetHeroVoicesWithType(self.heroCid, Constant.HeroSoundType.Fight)

	self.wrapContent:Refresh(#self.voicesList)
	LuaUtility.SetGameObjectShow(self.interactOn, false)
	LuaUtility.SetGameObjectShow(self.fightOn, true)
	self.graphicColorChange:EnablePreset(0)
	self:StopUpdate()
	self:StopLastSound()
end

function m:SetData(heroCid)
	self.heroCid = heroCid

	self:HideSoundText()
	self:OnClickButtonInteract()
end

function m:OnRenderItem(cell)
	local ItemData = self.voicesList[cell.index + 1]
	local item = self.Items[cell.gameObject]

	if item == nil then
		item = RoleAudioItemCell.New(cell.gameObject, self)
		self.Items[cell.gameObject] = item
	end

	item:SetData(ItemData, self.heroCid)
end

function m:OnSoundPlaySuccess(sender, playSoundSuccessEventArgs)
	if playSoundSuccessEventArgs.SerialId == self.lastSoundSerialID then
		if self.soundUpdate then
			self.soundUpdate:Stop()

			self.soundUpdate = nil
			self.currentUpdateSoundAgent = nil
		end

		self.currentUpdateSoundAgent = {}
		self.currentUpdateSoundAgent.agentHelper = playSoundSuccessEventArgs.soundAgentHelper
		self.currentUpdateSoundAgent.SerialId = playSoundSuccessEventArgs.SerialId
		self.soundUpdate = FrameTimer.New(function()
			if not self.currentUpdateSoundAgent then
				return
			end

			if self.currentUpdateSoundAgent.SerialId ~= self.lastSoundSerialID then
				return
			end

			local helper = self.currentUpdateSoundAgent.agentHelper

			if not self.lastSoundItem then
				return
			end

			if not self.lastSoundId then
				return
			end

			if self.lastSoundId ~= self.lastSoundItem.cfgData.CVSoundId then
				return
			end

			self.lastSoundItem:SetProgress(helper.Time / helper.Length)

			if helper.Time > helper.Length or helper.Time == helper.Length and helper.Time == 0 then
				self:StopUpdate()

				return
			end
		end, 1, -1)

		self.soundUpdate:Start()
	end
end

function m:StopUpdate()
	if self.soundUpdate then
		self.soundUpdate:Stop()

		self.soundUpdate = nil
		self.currentUpdateSoundAgent = nil
	end

	self:ResetLastSoundItem()
end

function m:ResetLastSoundItem()
	if self.lastSoundItem then
		self.lastSoundItem:SetProgress(1)
		self.lastSoundItem:HidePlayFlag()
		self:HideSoundText()
	end
end

function m:ShowSoundText(str)
	LuaUtility.SetGameObjectShow(self.RoleWordItem, true)
	LuaUtility.SetText(self.wordText, str)
end

function m:HideSoundText()
	LuaUtility.SetGameObjectShow(self.RoleWordItem, false)
end

function m:StopLastSound()
	if self.lastSoundSerialID then
		LuaUtility.StopSoundWithSerialId(self.lastSoundSerialID)
	end
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)

	self.currentShowVoiceType = nil

	if self.lastSoundSerialID then
		LuaUtility.StopSoundWithSerialId(self.lastSoundSerialID)
	end

	self.lastSoundSerialID = nil
	self.lastSoundId = nil

	if self.lastSoundItem then
		self.lastSoundItem:HidePlayFlag()
	end

	self.lastSoundItem = nil

	self:StopUpdate()
	CVModule.StopCV()
end

function m:Dispose()
	self:StopUpdate()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	for _, v in pairs(self.Items) do
		v:Dispose()
	end

	self.Items = {}

	if self.currentUpdateSoundAgent then
		self.currentUpdateSoundAgent.agentHelper = nil
		self.currentUpdateSoundAgent.SerialId = nil
		self.currentUpdateSoundAgent = {}
	end

	self.View = nil
	self.wrapContent = nil
	self.graphicColorChange = nil
end

return m
