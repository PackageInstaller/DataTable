-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGameNpcTalkView.lua

local m = {
	messageIndex = 1
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateNpcOpen()
		self:OnNpcOpen()
	end

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function m:StartTalk()
	self:ClearTimer()
	self.ChatNode:SetActive(false)

	if self.messageIndex <= #self.cfgPlaceGameWordData.ChatWord then
		local str = self.cfgPlaceGameWordData.ChatWord[self.messageIndex]

		UGUIUtil.SetText(self.TextChat, str)
		self.ChatNode:SetActive(str ~= nil and str ~= "")

		self.timerTalk = Timer.New(function()
			self.messageIndex = self.messageIndex + 1

			self:StartTalk()
		end, 4)

		self.timerTalk:Start()
	else
		self:Close()
	end
end

function m:Open()
	self.View:SetActive(true)
	self.ChatNode:SetActive(false)

	local randomIndex = math.random(1, #PlaceGameModule.cfgPlaceGameWorldDataList)

	self.messageIndex = 1
	self.cfgPlaceGameWordData = PlaceGameModule.cfgPlaceGameWorldDataList[randomIndex]

	self:StartTalk()
end

function m:ClearTimer()
	if self.timerTalk then
		self.timerTalk:Stop()
	end

	self.timerTalk = nil
end

function m:Close()
	self.View:SetActive(false)
	self:ClearTimer()
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	self:ClearTimer()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
