-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/cond/ArcadeSkillCondSpecifyRoom.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.cond.ArcadeSkillCondSpecifyRoom", package.seeall)

local ArcadeSkillCondSpecifyRoom = class("ArcadeSkillCondSpecifyRoom", ArcadeSkillCondBase)

function ArcadeSkillCondSpecifyRoom:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._roomType = params[2]
end

function ArcadeSkillCondSpecifyRoom:onIsCondSuccess()
	local roomId = ArcadeGameModel.instance:getCurRoomId()
	local roomCfg = ArcadeConfig.instance:getRoomCfg(roomId)

	if roomCfg then
		logNormal(string.format("ArcadeSkillCondSpecifyRoom:isCondSuccess() == > 检查特定类型的房间: %s == %s", self._roomType, roomCfg.roomType))

		if self._roomType == roomCfg.roomType then
			return true
		end
	end

	return false
end

return ArcadeSkillCondSpecifyRoom
