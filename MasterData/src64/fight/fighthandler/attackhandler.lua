local var_0_0 = type
local audio_manager = require("controller.audio_manager")
local FightUIElementsManager = require("fight.FightUIElementsManager")

return function(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_1.sound then
		if var_0_0(arg_1_1.sound) == "string" then
			audio_manager:playFightEffect(arg_1_1.sound, nil, FightManager.getBossSpeedUp())
		elseif var_0_0(arg_1_1.sound) == "table" then
			audio_manager:playFightEffect(arg_1_1.sound[1], arg_1_1.sound[2], FightManager.getBossSpeedUp())
		end
	end

	if arg_1_1.shake then
		FightUIElementsManager.getCamera().shake(arg_1_1.shake, arg_1_1.shake.period, arg_1_1.shake.time)
	end

	if arg_1_1.effect then
		arg_1_2.effect = {}

		local var_1_0 = arg_1_0:getRelativeDir(arg_1_2.assigned_target)

		for iter_1_0, iter_1_1 in pairs(arg_1_1.effect) do
			if iter_1_1.object == "self" then
				arg_1_0:playEffect(iter_1_1.name, iter_1_1.ani, iter_1_1.offsetX, iter_1_1.offsetY, iter_1_1.offsetZ)
			else
				table.insert(arg_1_2.effect, {
					name = iter_1_1.name,
					ani = iter_1_1.ani,
					offsetX = iter_1_1.offsetX,
					offsetY = iter_1_1.offsetY,
					offsetZ = iter_1_1.offsetZ,
					direction = var_1_0
				})
			end
		end
	end

	if arg_1_1.force then
		arg_1_2.force = {}

		for iter_1_2, iter_1_3 in pairs(arg_1_1.force) do
			if iter_1_3.object == "self" then
				arg_1_0:playForce(iter_1_3.distance, arg_1_0:getDirection(), iter_1_3.time, false)
			else
				table.insert(arg_1_2.force, {
					distance = iter_1_3.distance,
					time = iter_1_3.time,
					shutdown = iter_1_3.shutdown
				})
			end
		end
	end

	if arg_1_1.forceY then
		if arg_1_1.forceY[1] then
			arg_1_2.forceY = {}

			for iter_1_4, iter_1_5 in ipairs(arg_1_1.forceY) do
				table.insert(arg_1_2.forceY, {
					distance = iter_1_5.distance,
					time = iter_1_5.time,
					speed = iter_1_5.speed,
					shutdown = iter_1_5.shutdown
				})
			end
		else
			arg_1_2.forceY = {
				{
					distance = arg_1_1.forceY.distance,
					time = arg_1_1.forceY.time,
					speed = arg_1_1.forceY.speed,
					shutdown = arg_1_1.forceY.shutdown
				}
			}
		end
	end

	if arg_1_1.behitted then
		arg_1_2.behitted = arg_1_1.behitted
	end

	arg_1_2.id = arg_1_1.id

	if arg_1_2.id and arg_1_2.msg.skilltype ~= "attack" and arg_1_2.msg.skilltype ~= "xp" then
		arg_1_0:joinCD(arg_1_2.msg.skilltype)
	end

	FightManager.runSkill(arg_1_0, arg_1_2)
end
