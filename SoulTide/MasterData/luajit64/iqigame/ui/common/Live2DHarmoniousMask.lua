-- chunkname: @IQIGame\\UI\\Common\\Live2DHarmoniousMask.lua

local m = {}

function m.New(Live2dNode)
	local obj = Clone(m)

	obj:Init(Live2dNode)

	return obj
end

function m:Init(node)
	self.Live2dNode = node

	function self.DelegateChangeLive2DHarmoniousMask()
		self:OnChangeLive2DHarmoniousMask()
	end

	function self.DelegateChangeResourcesEvent()
		self:OnChangeResourcesEvent()
	end

	self:AddListener()
end

function m:AddListener()
	GameEntry.LuaEvent:Subscribe(LoadL2DSuccessEventArgs.EventId, self.DelegateChangeLive2DHarmoniousMask)
	EventDispatcher.AddEventListener(EventID.ChangeHarmoniousResourcesEvent, self.DelegateChangeResourcesEvent)
end

function m:RemoveListener()
	GameEntry.LuaEvent:Unsubscribe(LoadL2DSuccessEventArgs.EventId, self.DelegateChangeLive2DHarmoniousMask)
	EventDispatcher.RemoveEventListener(EventID.ChangeHarmoniousResourcesEvent, self.DelegateChangeResourcesEvent)
end

function m:OnChangeResourcesEvent()
	self:RefreshNode()
end

function m:OnChangeLive2DHarmoniousMask(sender, args)
	self:RefreshNode()
end

function m:RefreshNode()
	if self.Live2dNode and not LuaCodeInterface.GameObjIsDestroy(self.Live2dNode) then
		local modelContainer = self.Live2dNode.transform:Find("L2DFrame/live2DRawImage/live2DCamera/modelContainer")

		if modelContainer then
			local soul = modelContainer:GetChild(0)

			if soul then
				local harmoniousMask = soul:Find("HarmoniousMask")

				if harmoniousMask then
					local isShow = SettingModule.harmoniousResources == 0

					harmoniousMask.gameObject:SetActive(isShow)
				end
			end
		end
	end
end

function m:Dispose()
	self:RemoveListener()
end

return m
