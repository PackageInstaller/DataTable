-- chunkname: @modules/logic/autochess/main/model/rpcmo/AutoChessMo.lua

module("modules.logic.autochess.main.model.rpcmo.AutoChessMo", package.seeall)

local AutoChessMo = pureTable("AutoChessMo")

function AutoChessMo:init(data)
	self.uid = tonumber(data.uid)
	self.id = data.id
	self.star = data.star
	self.exp = data.exp
	self.maxExpLimit = data.maxExpLimit
	self.teamType = data.teamType
	self.status = data.status
	self.battle = tonumber(data.battle)
	self.hp = tonumber(data.hp)
	self.skillContainer = GameUtil.rpcInfoToMo(data.skillContainer, AutoChessSkillContainerMo)
	self.buffContainer = GameUtil.rpcInfoToMo(data.buffContainer, AutoChessBuffContainerMo)
	self.durability = data.durability
	self.cd = data.cd
	self.replaceSkillChessIds = data.replaceSkillChessIds

	if self.id ~= 0 then
		self.config = AutoChessConfig.instance:getChessCfg(self.id, self.star)
	end
end

function AutoChessMo:updateCd(value)
	self.cd = tonumber(value)
end

function AutoChessMo:updateChessIds(effectString)
	self.replaceSkillChessIds = string.splitToNumber(effectString, "#")
end

function AutoChessMo:initEmpty()
	self.uid = 0
	self.id = 0
	self.star = 0
end

return AutoChessMo
