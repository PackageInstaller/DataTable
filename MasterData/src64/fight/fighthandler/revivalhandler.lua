return function(arg_1_0)
	local var_1_0 = math.min(arg_1_0._revivaling, arg_1_0:getAttribute("hp"))

	arg_1_0:setAttribute("curhp", var_1_0)
	arg_1_0.hpbar:getChildByName("hpbar"):resetCurHp(var_1_0)

	if arg_1_0.charactertype == "player" then
		arg_1_0.hpbar:setVisible(not FightManager.isNormalFight() or FightManager.isFightingBoss())
	else
		arg_1_0.hpbar:setVisible(true)
	end

	arg_1_0:showBuffEffect()

	arg_1_0._revivaling = nil

	arg_1_0.statuspool:setStatus("invincible", false)
	arg_1_0.statuspool:setStatus("invincible_count", 0)

	if FightManager.FightStatus == FIGHTSTATUS_FIGHTING then
		arg_1_0:cleanBuffOnRevival()
		arg_1_0:setStatus(STATUS_FIGHTING)
		arg_1_0.logic:reset()
		arg_1_0:triggerStatus("onRevival")
	else
		arg_1_0:finishFight()
		arg_1_0:setStatus(STATUS_SEARCHING)
	end
end
