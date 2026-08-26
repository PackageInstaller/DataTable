-- chunkname: @modules/logic/versionactivity3_3/arcade/model/game/entity/ArcadeGamePWDValidatorMO.lua

module("modules.logic.versionactivity3_3.arcade.model.game.entity.ArcadeGamePWDValidatorMO", package.seeall)

local ArcadeGamePWDValidatorMO = class("ArcadeGamePWDValidatorMO", ArcadeGameBaseInteractiveMO)

function ArcadeGamePWDValidatorMO:onCtor(extraParam)
	self:clearPassword()
end

function ArcadeGamePWDValidatorMO:addPasswordNum(number)
	self._passwordList[#self._passwordList + 1] = number
end

function ArcadeGamePWDValidatorMO:getCurPasswordCount()
	return #self._passwordList
end

function ArcadeGamePWDValidatorMO:getPassword()
	return (table.concat(self._passwordList))
end

function ArcadeGamePWDValidatorMO:clearPassword()
	self._passwordList = {}
end

return ArcadeGamePWDValidatorMO
