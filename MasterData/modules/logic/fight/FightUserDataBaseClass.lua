-- chunkname: @modules/logic/fight/FightUserDataBaseClass.lua

module("modules.logic.fight.FightUserDataBaseClass", package.seeall)

local FightUserDataBaseClass = class("FightUserDataBaseClass", UserDataDispose)

function FightUserDataBaseClass:init()
	self:__onInit()
end

function FightUserDataBaseClass:dispose()
	self:__onDispose()
end

return FightUserDataBaseClass
