-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkPlayer\\AmusementParkPlayerDescribeCell.lua

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

function m:SetData(unlock, storyStr, unlockStr)
	self.Lock:SetActive(not unlock)
	self.UnLock:SetActive(unlock)
	UGUIUtil.SetText(self.TextMsg, unlockStr)

	if PlayerModule.PlayerInfo.baseInfo.pName ~= nil then
		storyStr = string.gsub(storyStr, "{PlayerName}", PlayerModule.PlayerInfo.baseInfo.pName)
	end

	UGUIUtil.SetText(self.TextMsgLock, storyStr)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
