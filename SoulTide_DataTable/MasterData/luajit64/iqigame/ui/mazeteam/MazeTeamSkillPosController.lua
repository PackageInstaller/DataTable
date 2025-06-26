-- chunkname: @IQIGame\\UI\\MazeTeam\\MazeTeamSkillPosController.lua

local m = {
	IsShow = false,
	PositionToggles = {}
}
local prototype = m
local MazeTeamSubPanel = require("IQIGame.UI.MazeTeam.MazeTeamSubPanel")

m = Clone(MazeTeamSubPanel)

m.InitFieldDefaultValues(m, prototype)

local MazeTeamSkillController = require("IQIGame.UI.MazeTeam.MazeTeamSkillController")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:OnInit()
	self.PositionToggles[1] = self.FrontToggle
	self.PositionToggles[2] = self.BackToggle

	for i = 1, #self.PositionToggles do
		self["DelegateOnPosToggleChanged" .. i] = function(isOn)
			self:OnPosToggleChanged(i, isOn)
		end
		self.PositionToggles[i]:GetComponent("ToggleHelperComponent").text = RpgMazeTeamUIApi:GetString("PosToggleText", i)
	end

	self.SkillController = MazeTeamSkillController.New(self.SkillView)
end

function m:OnRootUIOpen()
	return
end

function m:OnRootUIClose()
	self:Save()
end

function m:OnShow(dollPOD)
	self.DollPOD = dollPOD

	for i = 1, #self.PositionToggles do
		local toggleGo = self.PositionToggles[i]

		toggleGo:GetComponent("Toggle").isOn = i == dollPOD.position
	end

	self.SkillController:SetData(dollPOD)
end

function m:OnHide(isDestroy)
	if not isDestroy then
		self:Save()
	end
end

function m:AddListeners()
	self.SkillController:AddListeners()

	for i = 1, #self.PositionToggles do
		local toggleGo = self.PositionToggles[i]

		toggleGo:GetComponent("Toggle").onValueChanged:AddListener(self["DelegateOnPosToggleChanged" .. i])
	end
end

function m:RemoveListeners()
	self.SkillController:RemoveListeners()

	for i = 1, #self.PositionToggles do
		local toggleGo = self.PositionToggles[i]

		toggleGo:GetComponent("Toggle").onValueChanged:RemoveListener(self["DelegateOnPosToggleChanged" .. i])
	end
end

function m:OnPosToggleChanged(index, isOn)
	if isOn then
		EventDispatcher.Dispatch(EventID.MazeRpgMazeUIChangePosition, self.DollPOD.id, index)
	end
end

function m:Save()
	if self.DollPOD == nil then
		return
	end

	if MazeDataModule.PlayerInfo == nil then
		return
	end

	local position = 0

	for i = 1, #self.PositionToggles do
		local toggleGo = self.PositionToggles[i]

		if toggleGo:GetComponent("Toggle").isOn then
			position = i

			break
		end
	end

	if position ~= 0 and position ~= self.DollPOD.position then
		MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_CHANGE_DOLL_POSITION, {
			DollId = self.DollPOD.id,
			Position = position
		})
	end

	self.SkillController:Save()
end

function m:OnDispose()
	self.SkillController:Dispose()
end

return m
