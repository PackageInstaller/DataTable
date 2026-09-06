-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/model/battleMo/MiracleHeroTeamMo.lua

module("logic.extensions.miraclehero.model.battleMo.MiracleHeroTeamMo", package.seeall)

local MiracleHeroTeamMo = class("MiracleHeroTeamMo")

function MiracleHeroTeamMo:ctor()
	self.teamId = 0
	self.pos = {}
	self.supportPet = 0
	self.allSpeed = 0
	self.actionPet = {}
end

function MiracleHeroTeamMo:initData()
	self:checkSpeed()
end

function MiracleHeroTeamMo:checkSpeed()
	self.allSpeed = 0
	self.actionPet = {}

	for i, v in pairs(self.pos) do
		local petMo = MiracleHeroUnitMgr.instance:getPet(v)

		table.insert(self.actionPet, v)

		self.allSpeed = self.allSpeed + petMo.speed
	end

	table.sort(self.actionPet, function(a, b)
		local petMoA = MiracleHeroUnitMgr.instance:getPet(a)
		local petMoB = MiracleHeroUnitMgr.instance:getPet(a)

		return petMoA.speed > petMoB.speed
	end)
end

function MiracleHeroTeamMo:getSurvalPetNum()
	local num = 0

	for i, v in pairs(self.pos) do
		if MiracleHeroUnitMgr.instance:isPetSurvival(v) == true then
			num = num + 1
		end
	end

	return num
end

return MiracleHeroTeamMo
