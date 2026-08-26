-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/step/Va3ChessStepCreateObject.lua

module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepCreateObject", package.seeall)

local Va3ChessStepCreateObject = class("Va3ChessStepCreateObject", Va3ChessStepBase)

function Va3ChessStepCreateObject:start()
	local objId = self.originData.id

	Va3ChessGameModel.instance:removeObjectById(objId)
	Va3ChessGameController.instance:deleteInteractObj(objId)

	local actId = Va3ChessGameModel.instance:getActId()
	local mo = Va3ChessGameModel.instance:addObject(actId, self.originData)

	mo:setHaveBornEff(true)
	Va3ChessGameController.instance:addInteractObj(mo)
	logNormal("create object finish !" .. tostring(mo.id))

	local intactCfg = Va3ChessConfig.instance:getInteractObjectCo(actId, objId)

	if intactCfg and intactCfg.createAudioId and intactCfg.createAudioId ~= 0 then
		AudioMgr.instance:trigger(intactCfg.createAudioId)
	end

	self:finish()
end

return Va3ChessStepCreateObject
