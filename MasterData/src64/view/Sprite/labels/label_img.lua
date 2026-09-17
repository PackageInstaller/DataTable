return function(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if not arg_1_1.src then
		return
	end

	if not cc.FileUtils:getInstance():isFileExist(arg_1_1.src) then
		if not cc.SpriteFrameCache:getInstance():getSpriteFrameByName(arg_1_1.src) then
			return
		end
	end

	local var_1_0 = arg_1_0:getSprite(arg_1_1.src)

	if not var_1_0 then
		arg_1_0:printf("<img> - create sprite failde")

		return
	end

	if arg_1_1.scale then
		var_1_0:setScale(arg_1_1.scale)
	end

	if arg_1_1.rotate then
		var_1_0:setRotation(arg_1_1.rotate)
	end

	if arg_1_1.visible ~= nil then
		var_1_0:setVisible(arg_1_1.visible)
	end

	return {
		var_1_0
	}
end
