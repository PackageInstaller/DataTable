-- chunkname: @/tmp/or_script/lua_compile/cocos/framework/extends/SpriteEx.lua

local Sprite = cc.Sprite

function Sprite:playAnimationOnce(animation, args)
	local actions = {}

	if not args.showDelay then
		if args.showDelay then
			self:setVisible(false)

			actions[#actions + 1] = cc.DelayTime:create(args.showDelay)
			actions[#actions + 1] = cc.Show:create()
		end

		if not args.delay then
			local delay = 0

			if delay > 0 then
				actions[#actions + 1] = cc.DelayTime:create(delay)
			end

			actions[#actions + 1] = cc.Animate:create(animation)

			if args.removeSelf then
				actions[#actions + 1] = cc.RemoveSelf:create()
			end

			if args.onComplete then
				actions[#actions + 1] = cc.CallFunc:create(args.onComplete)
			end

			local action = #actions > 1 and cc.Sequence:create(actions) or actions[1]

			self:runAction(action)

			return action
		end
	end
end

function Sprite:playAnimationForever(animation)
	local animate = cc.Animate:create(animation)
	local action = cc.RepeatForever:create(animate)

	self:runAction(action)

	return action
end
