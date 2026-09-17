local var_0_0 = {}
local var_0_1
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}
local var_0_5 = {}
local var_0_6 = {}

function var_0_0:attachCharacter()
	self:attachUIindex(#var_0_2 + 1)

	var_0_2[#var_0_2 + 1] = self
end

function var_0_0.detachCharacter(arg_2_0)
	var_0_2[arg_2_0] = nil
end

function var_0_0:attachBullet()
	self:attachUIindex(#var_0_3 + 1)

	var_0_3[#var_0_3 + 1] = {
		lock = false,
		pause = false,
		bullet = self
	}

	return #var_0_3 + 1
end

function var_0_0.detachBullet(arg_4_0)
	var_0_3[arg_4_0] = nil
end

function var_0_0.attachFightCamera(arg_5_0)
	var_0_1 = arg_5_0
end

function var_0_0.getUICharacters()
	return var_0_2
end

function var_0_0.getUIBullets()
	return var_0_3
end

function var_0_0.getCamera()
	return var_0_1
end

function var_0_0.attachPlayerItem(arg_9_0, arg_9_1)
	var_0_4[arg_9_0] = arg_9_1
end

function var_0_0.detachPlayerItem(arg_10_0)
	var_0_4[arg_10_0] = nil
end

function var_0_0.detachAllPlayerItems()
	var_0_4 = {}
end

function var_0_0.getPlayerItem(arg_12_0)
	return var_0_4[arg_12_0]
end

function var_0_0.getPlayerItems()
	return var_0_4
end

function var_0_0.attachBuffPanel(arg_14_0, arg_14_1)
	var_0_5[arg_14_0] = arg_14_1
end

function var_0_0.detachBuffPanel(arg_15_0)
	var_0_5[arg_15_0] = nil
end

function var_0_0.detachAllBuffPanels()
	var_0_5 = {}
end

function var_0_0.getBuffPanel(arg_17_0)
	return var_0_5[arg_17_0]
end

function var_0_0.attachHorcruxPanel(arg_18_0, arg_18_1)
	var_0_6[arg_18_1] = arg_18_0
end

function var_0_0.detachHorcruxPanel()
	var_0_6 = {}
end

function var_0_0.getHorcruxSP(arg_20_0, arg_20_1)
	return var_0_6[arg_20_0]:getChildByName("horcrux" .. arg_20_1)
end

return var_0_0
