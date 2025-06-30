-- chunkname: @IQIGame\\Net\\NetOperationsMagicMuseumResponse.lua

function net_operationsMagicMuseum.attackResult(code)
	ActiveMagicWaxMuseumModule.AttackResult()
end

function net_operationsMagicMuseum.notifyMuseumAttackRet(eventId, museumId, win, showList)
	ActiveMagicWaxMuseumModule.NotifyMuseumAttackRet(eventId, museumId, win, showList)
end
