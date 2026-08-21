-- chunkname: @IQIGame\\UI\\DualTeamExplore\\DualTeamBossChallenge\\DualTeamBossRankFormationCell.lua

local m = {}
local MultiFunctionFormationPanel = require("IQIGame.UI.FormationUI.MultiFunctionFormationPanel")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TextFormation, DualTeamExploreExBossFormationUIApi:GetString("TextFormation"))

	self.rankFormationView = MultiFunctionFormationPanel.New(self.Formation)

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(cfgBoss, prefabList)
	local path = UIGlobalApi.GetImagePath(cfgBoss.RankHeadIcon)

	AssetUtil.LoadImage(self, path, self.HeadIcon:GetComponent("Image"))
	self.rankFormationView:SetData(prefabList)
	UGUIUtil.SetText(self.TextPower, tostring(self.rankFormationView:GetPower()))
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	self.rankFormationView:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
