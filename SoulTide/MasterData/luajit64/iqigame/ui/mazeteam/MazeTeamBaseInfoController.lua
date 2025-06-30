-- chunkname: @IQIGame\\UI\\MazeTeam\\MazeTeamBaseInfoController.lua

local m = {
	IsShow = false
}
local prototype = m
local MazeTeamSubPanel = require("IQIGame.UI.MazeTeam.MazeTeamSubPanel")

m = Clone(MazeTeamSubPanel)

m.InitFieldDefaultValues(m, prototype)

local MazeTeamAttrSpeController = require("IQIGame.UI.MazeTeam.MazeTeamAttrSpeController")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:OnInit()
	self.AttrSpeController = MazeTeamAttrSpeController.New(self.AttrView)
end

function m:OnRootUIOpen()
	return
end

function m:OnRootUIClose()
	return
end

function m:OnShow(dollPOD)
	self.AttrSpeController:SetData(dollPOD)

	local exp = dollPOD.exp
	local cfgSoulLevelData = CfgSoulLevelTable[dollPOD.lv]
	local maxExp = cfgSoulLevelData.NextEXP

	self.ExpBar:GetComponent("Image").fillAmount = exp / maxExp

	UGUIUtil.SetText(self.ExpText, RpgMazeTeamUIApi:GetString("ExpText", exp, maxExp))

	local soulData = MazeDataModule.GetSoulData(dollPOD.soulCid)

	self.Star:GetComponent("SimpleStarComponent"):UpdateView(5, soulData:GetCfgSoulQuality().Quality)
end

function m:OnHide(isDestroy)
	return
end

function m:AddListeners()
	self.AttrSpeController:AddListeners()
end

function m:RemoveListeners()
	self.AttrSpeController:RemoveListeners()
end

function m:OnDispose()
	self.AttrSpeController:Dispose()
end

return m
