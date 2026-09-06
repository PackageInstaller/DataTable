-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/model/battleMo/MiracleHeroRoundMo.lua

module("logic.extensions.miraclehero.model.battleMo.MiracleHeroRoundMo", package.seeall)

local MiracleHeroRoundMo = class("MiracleHeroRoundMo")

function MiracleHeroRoundMo:ctor()
	self.battleId = 0
	self.teamId = 0
	self.roundIndex = 0
	self.isInit = false
	self.skillMo = nil
end

return MiracleHeroRoundMo
