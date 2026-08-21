-- chunkname: @IQIGame\\Net\\NetMiniGameResponse.lua

function net_miniGame.notifyStartCardGame(cardCid)
	CardGameModule.StartCardGameInMainCity(cardCid)
end

function net_miniGame.chooseCardResult(code, cardCfgIndex)
	return
end

function net_miniGame.notifyStartTurntable(cid)
	TurntableGameModule.StartGameInMainCity(cid)
end

function net_miniGame.turntableEndResult(code, cardCfgIndex)
	return
end
