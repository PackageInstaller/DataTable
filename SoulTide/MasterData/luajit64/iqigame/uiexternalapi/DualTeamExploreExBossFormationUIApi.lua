-- chunkname: @IQIGame\\UIExternalApi\\DualTeamExploreExBossFormationUIApi.lua

DualTeamExploreExBossFormationUIApi = BaseLangApi:Extend()

function DualTeamExploreExBossFormationUIApi:Init()
	self:RegisterApi("TextFormation", self.GetTextFormation)
end

function DualTeamExploreExBossFormationUIApi:GetTextFormation()
	return self:GetCfgText(1213201)
end

DualTeamExploreExBossFormationUIApi:Init()
