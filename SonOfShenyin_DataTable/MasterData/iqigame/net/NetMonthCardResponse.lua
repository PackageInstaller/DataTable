-- chunkname: @IQIGame\\Net\\NetMonthCardResponse.lua

function net_monthCard.receiveMonthCardAwardResult(code, itemShowPODS)
	MonthCardModule.ReceiveMonthCardAwardResult(itemShowPODS)
end

function net_monthCard.notifyMonthCardAward(itemShowPODS)
	MonthCardModule.notifyMonthCardAward(itemShowPODS)
end

function net_monthCard.notifyMonthCard(monthCardPOD)
	MonthCardModule.notifyMonthCard(monthCardPOD)
end
