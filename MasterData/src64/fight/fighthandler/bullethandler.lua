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
		for iter_1_0, iter_1_1 in pairs(arg_1_1.effect) do
			if iter_1_1.object == "self" then
				arg_1_0:playEffect(iter_1_1.name, iter_1_1.ani, iter_1_1.offsetX, iter_1_1.offsetY, iter_1_1.offsetZ)
			end
		end
	end

	if arg_1_1.force then
		for iter_1_2, iter_1_3 in pairs(arg_1_1.force) do
			if iter_1_3.object == "self" then
				arg_1_0:playForce(iter_1_3.distance, arg_1_0:getDirection(), iter_1_3.time, false)
			end
		end
	end

	local var_1_0 = arg_1_2.bulletinfo

	if arg_1_2.msg.skilltype ~= "attack" and arg_1_2.msg.skilltype ~= "xp" then
		arg_1_0:joinCD(arg_1_2.msg.skilltype)
	end

	if var_1_0.movingtype == "locktarget" or var_1_0.movingtype == "locktime" then
		if var_0_0(arg_1_0.target) == "string" then
			local var_1_1 = arg_1_0:getTarget()

			if var_1_1 then
				local var_1_2 = BulletSprite:create(var_1_0, arg_1_2.msg, arg_1_0, arg_1_0.target)

				FightManager.addBullet(var_1_2, var_1_1:getLocalZOrder() + var_1_0.offsetZ + 2)
				var_1_2:run()
			end
		elseif var_0_0(arg_1_0.target) == "table" then
			local var_1_3 = arg_1_0:getTarget()

			if not var_1_3 then
				return
			end

			for iter_1_4, iter_1_5 in pairs(var_1_3) do
				local var_1_4 = BulletSprite:create(var_1_0, arg_1_2.msg, arg_1_0, iter_1_5.index)

				FightManager.addBullet(var_1_4, iter_1_5:getLocalZOrder() + var_1_0.offsetZ + 2)
				var_1_4:run()
			end
		end
	else
		local var_1_5 = BulletSprite:create(var_1_0, arg_1_2.msg, arg_1_0)
		local var_1_6 = arg_1_0:getLocalZOrder() + var_1_0.offsetZ or 0

		FightManager.addBullet(var_1_5, (var_1_0.ontop or nil) and 999)
		var_1_5:run()
	end
end
