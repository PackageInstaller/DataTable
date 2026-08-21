-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/model/multiplayer/BattleUserInfoMO.lua

module("logic.battle.battleflow.component.model.multiplayer.BattleUserInfoMO", package.seeall)

local BattleUserInfoMO = class("BattleUserInfoMO", AbstractGlobalReusable)

function BattleUserInfoMO:createFromMemberNO(memberNO)
	local userInfoMO = BattleUserInfoMO:createInstance()

	userInfoMO.userId = memberNO.userId
	userInfoMO.nickname = memberNO.nickname
	userInfoMO.displayHeroCode = memberNO.displayHero
	userInfoMO.displayHeroSkinCode = memberNO.displayHeroSkin

	return userInfoMO
end

function BattleUserInfoMO:ctor()
	self:reset()
end

function BattleUserInfoMO:reset()
	self.userId = false
	self.teamId = false
	self.nickname = false
	self.displayHeroCode = false
	self.displayHeroSkinCode = false
end

function BattleUserInfoMO:destroy()
	self:reset()
end

function BattleUserInfoMO:getIconName()
	if self.displayHeroSkinCode > 0 then
		local skinCO = HeroSkinConfig.instance:getInfo(self.displayHeroSkinCode)

		return skinCO.icon
	end

	local characterCO = CharacterConfig.instance:getCfgInfoByID(self.displayHeroCode)

	return characterCO.icon
end

return BattleUserInfoMO
