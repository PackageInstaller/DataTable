return function(arg_1_0)
	arg_1_0._lock = false
	arg_1_0._wining = false

	arg_1_0:removeCarriedConf()
	arg_1_0:removeRushingForward()
	arg_1_0:finishForce()
	arg_1_0:setState(STATE_SEARCHING)
end
