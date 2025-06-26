-- chunkname: @IQIGame\\UI\\Activity\\MagicWaxMuseum\\MagicWaxMuseumBossLevelCell.lua

local m = {
	selected = false
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function m:SetData(data, operateEventID)
	self.cfgMagicWaxMuseumListData = data

	UGUIUtil.SetText(self.TextDown, ActivityUIApi:GetString("TextBossLevel", self.cfgMagicWaxMuseumListData.BossLevel))
	UGUIUtil.SetText(self.TextUp, ActivityUIApi:GetString("TextBossLevel", self.cfgMagicWaxMuseumListData.BossLevel))
	UGUIUtil.SetText(self.TextFightNum, ActivityUIApi:GetString("TextFightNum", self.cfgMagicWaxMuseumListData.RecommendPower, 10000))
	UGUIUtil.SetText(self.TextFight, ActivityUIApi:GetString("TextFight"))
	UGUIUtil.SetText(self.TextTagUp, ActivityUIApi:GetString("TextKilled"))
	UGUIUtil.SetText(self.TextTagDown, ActivityUIApi:GetString("TextKilled"))

	local killed = ActiveMagicWaxMuseumModule.GetMagicWaxMuseumBossKillState(operateEventID, self.cfgMagicWaxMuseumListData.Id)

	self.TagDown:SetActive(killed)
	self.TagUp:SetActive(killed)
	self:SetSelect(self.selected)
end

function m:SetSelect(top)
	self.selected = top

	self.Down:SetActive(not self.selected)
	self.Up:SetActive(self.selected)
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
