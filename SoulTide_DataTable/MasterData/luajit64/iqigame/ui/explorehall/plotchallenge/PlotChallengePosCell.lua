-- chunkname: @IQIGame\\UI\\ExploreHall\\PlotChallenge\\PlotChallengePosCell.lua

local m = {
	pointIndex = 0
}
local PlotChangePosStateCell = require("IQIGame.UI.ExploreHall.PlotChallenge.PlotChangePosStateCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.plotStateView = PlotChangePosStateCell.New(self.PlotNode)
	self.fightStateView = PlotChangePosStateCell.New(self.FightNode)

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetCfgData(data, pos)
	self.cfgData = data
	self.pos = pos
end

function m:UpdateView(state)
	self.state = state

	self.plotStateView:UpdateSate(state)
	self.fightStateView:UpdateSate(state)
	self.View.transform.parent.gameObject:SetActive(self.state ~= 0)

	if self.cfgData.Type == 1 then
		self.fightStateView:Hide()
		self.plotStateView:Show()
		self.plotStateView:SetCfgData(self.cfgData)
	elseif self.cfgData.Type == 2 then
		self.plotStateView:Hide()
		self.fightStateView:Show()
		self.fightStateView:SetCfgData(self.cfgData)
	end

	if self.pos == 1 then
		self.Lines:SetActive(false)
	else
		self.Lines:SetActive(true)
	end
end

function m:PlayLineEffect()
	if self.pos == 1 then
		self:UpdateView(1)
	else
		if self.timer then
			self.timer:Stop()

			self.timer = nil
		end

		self:SetLinesDefault()

		self.pointIndex = 0
		self.timer = Timer.New(function()
			self:ShowPoint()
		end, 0.1, -1)

		self.timer:Start()
	end
end

function m:SetLinesDefault()
	self.Lines:SetActive(true)
	self.fightStateView:Hide()
	self.plotStateView:Hide()
	self.View.transform.parent.gameObject:SetActive(true)

	for i = 0, self.Lines.transform.childCount - 1 do
		self.Lines.transform:GetChild(i).gameObject:SetActive(false)
	end
end

function m:ShowPoint()
	self.Lines.transform:GetChild(self.pointIndex).gameObject:SetActive(true)

	self.pointIndex = self.pointIndex + 1

	if self.pointIndex >= self.Lines.transform.childCount then
		self.timer:Stop()
		self:UpdateView(1)
	end
end

function m:Dispose()
	self:RemoveListener()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
