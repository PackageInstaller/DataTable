-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkDetail\\AmusementParkDetailEventRender.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(eventData)
	local str = getTimeText(tonumber(eventData.date / 1000))

	UGUIUtil.SetText(self.TextTime, str)

	local resultStr = ""
	local showReward = ""
	local showItem = {}
	local cfgEventControlData = CfgAmusementParkEventControlTable[eventData.eventCfgId]
	local code = ""

	if eventData.achievement then
		resultStr = cfgEventControlData.DefensiveVictory
		showItem = cfgEventControlData.Reward
		code = "+"
	else
		resultStr = CfgAmusementParkEventControlTable[eventData.eventCfgId].DefensiveFailure
		showItem = cfgEventControlData.Punish
		code = "-"
	end

	for i = 1, #showItem, 2 do
		local id = showItem[i]
		local num = showItem[i + 1]

		showReward = showReward .. CfgItemTable[id].Name .. code .. num
	end

	UGUIUtil.SetText(self.TextContent, AmusementParkDetailUIApi:GetString("TextContent", resultStr, showReward, eventData.achievement, eventData.value))
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
