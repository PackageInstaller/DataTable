-- chunkname: @IQIGame\\UI\\Setting\\SettingHeadCell.lua

local m = {
	isCurrentSetting = false
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.playerHeadCell = PlayerHeadUI.New(self.PlayerHead)
end

function m:SetData(data)
	self.headData = data

	self.playerHeadCell:SetData(self.headData.cfgID, PlayerModule.PlayerInfo.baseInfo.pLv)
	self.Lock:SetActive(not self.headData.isLock)

	local playerHeadData = SettingModule.GetPlayHeadData(PlayerModule.PlayerInfo.baseInfo.headIcon)

	self.isCurrentSetting = playerHeadData.cfgID == self.headData.cfgID

	self.Tag:SetActive(self.isCurrentSetting)

	local timeLimit = self.headData:GetTimeLimit()

	self.DateTag:SetActive(timeLimit > 0 and timeLimit > PlayerModule.GetServerTime())
end

function m:Select(choose)
	self.Choose:SetActive(choose)
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
