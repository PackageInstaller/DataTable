-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WorldPeaceActionFactory.lua

WorldPeaceActionFactory = class("WorldPeaceActionFactory")

function WorldPeaceActionFactory.class:getActionDefine(type)
	local function create_common_idle(cfg, actor, factor)
		local actor = actor:getDisplayNode()
		local pos = cc.p(actor:getPosition())
		local scale = actor:getScale()
		local scaleTo1 = cc.ScaleTo:create(0.03333333333333333 * factor, scale * 1)
		local scaleTo2 = cc.ScaleTo:create(0.4 * factor, scale * 1.05)
		local scaleTo3 = cc.ScaleTo:create(0.033333333333333326 * factor, scale * 1.05)
		local scaleTo4 = cc.ScaleTo:create(0.6 * factor, scale * 1)
		local action = cc.Sequence:create(scaleTo1, scaleTo2, scaleTo3, scaleTo4)

		return (cc.RepeatForever:create(action))
	end

	local actions = {
		CLUBBOSSSTAGETWO = {
			idle = {
				effect = "",
				action = function(cfg, actor, target, factor)
					actor:refreshLine(target)
				end
			},
			attack = {
				action = function(cfg, actor, target, factor, callback)
					if callback and callback.hitCall then
						local target_w = target:getDisplayNode():getParent():convertToWorldSpace(cc.p(target:getDisplayNode():getPosition()))
						local target_n = cc.p(actor:getDisplayNode():getParent():convertToNodeSpace(target_w))

						callback.hitCall(cc.p(target_n.x + 0, target_n.y + 0))
					end

					if callback and callback.endCall then
						actor:resetTrans()
						callback.endCall()
					end

					actor:onAttacking(target, 1)
					actor:refreshLine(target)
				end
			}
		},
		SIMPLE = {
			idle = {
				effect = "",
				action = function(cfg, actor, factor, animNode)
					if animNode then
						animNode:runAction(create_common_idle(cfg, actor, factor))
					else
						actor:getDisplayNode():runAction(create_common_idle(cfg, actor, factor))
					end
				end
			},
			attack = {
				action = function(cfg, actor, target, factor, callback, animNode)
					local raido = actor._Radio

					if not actor:getDisplayNode():isVisible() then
						if callback and callback.endCall then
							local delay = cc.DelayTime:create(3)
							local action = cc.Sequence:create(delay, cc.CallFunc:create(function()
								callback.endCall(action)
							end))

							actor:resetTrans()
							actor:getDisplayNode():runAction(action)
						end

						return
					end

					animNode:setScale(1)

					local effectLayer = actor:getEffectLayer()
					local org_w = actor:getDisplayNode():getParent():convertToWorldSpace(cc.p(actor:getDisplayNode():getPosition()))
					local target_w = target:getDisplayNode():getParent():convertToWorldSpace(cc.p(target:getDisplayNode():getPosition()))
					local target_n = cc.p(actor:getDisplayNode():getParent():convertToNodeSpace(target_w))
					local pos = cc.p(actor:getPosition())
					local scale = actor:getScale()
					local actor = actor:getDisplayNode()
					local scaleTo1 = cc.ScaleTo:create(0.03333333333333333 * factor, scale * 1)
					local scaleTo2 = cc.ScaleTo:create(0.13333333333333333 * factor, scale * 1.27)
					local scaleTo3 = cc.ScaleTo:create(0.2666666666666667 * factor, scale * 1.27)
					local scaleTo4 = cc.ScaleTo:create(0.033333333333333326 * factor, scale * 1.27)
					local scaleTo5 = cc.ScaleTo:create(0.3666666666666667 * factor, scale * 1)
					local action1 = cc.Sequence:create(scaleTo1, scaleTo2, scaleTo3, scaleTo4, scaleTo5)
					local fixLength = 27
					local offsetY = fixLength * math.sin(math.angle2radian(raido))
					local offsetX = fixLength * math.cos(math.angle2radian(raido))
					local moveTo1 = cc.MoveTo:create(0.16666666666666666 * factor, pos)
					local moveTo2 = cc.MoveBy:create(0.2666666666666667 * factor, cc.p(offsetX, offsetY))
					local fixLength = 100 * target:getScale()
					local offsetY = fixLength * math.sin(math.angle2radian(raido))
					local offsetX = fixLength * math.cos(math.angle2radian(raido))
					local moveTo3 = cc.MoveTo:create(0.033333333333333326 * factor, cc.p(target_n.x + offsetX, target_n.y + offsetY))
					local hitAnim = cc.CallFunc:create(function()
						if tolua.isnull(actor) then
							return
						end

						if not effectLayer:isVisible() then
							return
						end

						if not actor:isVisible() then
							if callback and callback.endCall then
								callback.endCall()
							end

							return
						end

						local org_n = cc.p(effectLayer:convertToNodeSpace(org_w))
						local target_n = cc.p(effectLayer:convertToNodeSpace(target_w))

						if callback and callback.hitCall then
							callback.hitCall(cc.p(target_n.x + offsetX, target_n.y + offsetY))
						end
					end)
					local fixLength = 37
					local offsetY = fixLength * math.sin(math.angle2radian(raido))
					local offsetX = fixLength * math.cos(math.angle2radian(raido))
					local moveTo4 = cc.MoveBy:create(0.033333333333333326 * factor, cc.p(offsetX, offsetY))
					local moveTo5 = cc.MoveTo:create(0.33333333333333337 * factor, pos)
					local action2 = cc.Sequence:create(moveTo1, moveTo2, moveTo3, hitAnim, moveTo4, moveTo5)
					local action = cc.Spawn:create(action1, action2)
					local action = cc.Sequence:create(action, cc.CallFunc:create(function()
						if callback and callback.endCall then
							callback.endCall()
						end
					end))

					if animNode then
						if not tolua.isnull(animNode) then
							animNode:runAction(action)
						end
					else
						actor:runAction(action)
					end
				end
			}
		},
		WNSXJ = {
			idle = {
				effect = "",
				action = function(cfg, actor, factor, animNode)
					if animNode then
						animNode:runAction(create_common_idle(cfg, actor, factor))
					else
						actor:getDisplayNode():runAction(create_common_idle(cfg, actor, factor))
					end
				end
			},
			attack = {
				flash = "02daoguang_qiuqiuzhandou",
				hitflash = "02beiji_qiuqiuzhandou",
				action = function(cfg, actor, target, factor, callback, animNode)
					if not actor:getDisplayNode():isVisible() then
						if callback and callback.endCall then
							local delay = cc.DelayTime:create(3)
							local action = cc.Sequence:create(delay, cc.CallFunc:create(function()
								callback.endCall(action)
							end))

							actor:resetTrans()
							actor:getDisplayNode():runAction(action)
						end

						return
					end

					local atkEffectProp = actor:getAtkEffectProp()
					local raido = actor._Radio
					local effectLayer = actor:getEffectLayer()
					local org_w = actor:getDisplayNode():getParent():convertToWorldSpace(cc.p(actor:getDisplayNode():getPosition()))
					local target_w = target:getDisplayNode():getParent():convertToWorldSpace(cc.p(target:getDisplayNode():getPosition()))
					local target_n = cc.p(actor:getDisplayNode():getParent():convertToNodeSpace(target_w))
					local pos = cc.p(actor:getPosition())
					local scale = actor:getScale()
					local actor = actor:getDisplayNode()
					local scaleTo1 = cc.ScaleTo:create(0.03333333333333333 * factor, scale * 1)
					local scaleTo2 = cc.ScaleTo:create(0.13333333333333333 * factor, scale * 1.27)
					local scaleTo3 = cc.ScaleTo:create(0.2666666666666667 * factor, scale * 1.27)
					local scaleTo4 = cc.ScaleTo:create(0.033333333333333326 * factor, scale * 1.27)
					local scaleTo5 = cc.ScaleTo:create(0.3666666666666667 * factor, scale * 1)
					local action1 = cc.Sequence:create(scaleTo1, scaleTo2, scaleTo3, scaleTo4, scaleTo5)
					local fixLength = 27
					local offsetY = fixLength * math.sin(math.angle2radian(raido))
					local offsetX = fixLength * math.cos(math.angle2radian(raido))
					local moveTo1 = cc.MoveTo:create(0.16666666666666666 * factor, pos)
					local moveTo2 = cc.MoveBy:create(0.2666666666666667 * factor, cc.p(offsetX, offsetY))
					local fixLength = 100 * target:getScale()
					local offsetY = fixLength * math.sin(math.angle2radian(raido))
					local offsetX = fixLength * math.cos(math.angle2radian(raido))
					local moveTo3 = cc.MoveTo:create(0.033333333333333326 * factor, cc.p(target_n.x + offsetX, target_n.y + offsetY))
					local hitAnim = cc.CallFunc:create(function()
						if tolua.isnull(actor) then
							return
						end

						if not effectLayer:isVisible() then
							return
						end

						if not actor:isVisible() then
							return
						end

						local prop = math.random(0, 10) / 10

						if prop > atkEffectProp then
							return
						end

						local org_w = actor:getParent():convertToWorldSpace(cc.p(actor:getPosition()))
						local hitAciton = cc.MovieClip:create(cfg.flash)

						hitAciton:addTo(effectLayer)
						hitAciton:setRotation(180 - raido)
						hitAciton:setScale(actor:getScale() * k_EFFECT_SCALE)

						local raidoReal = (180 - raido) % 360

						if raidoReal > 90 and raidoReal < 270 then
							hitAciton:setScaleY(-actor:getScale() * k_EFFECT_SCALE)
						else
							hitAciton:setScaleY(actor:getScale() * k_EFFECT_SCALE)
						end

						local org_n = cc.p(effectLayer:convertToNodeSpace(org_w))
						local target_n = cc.p(effectLayer:convertToNodeSpace(target_w))
						local fixLength = 100 * target:getScale()
						local offsetY = fixLength * math.sin(math.angle2radian(raido))
						local offsetX = fixLength * math.cos(math.angle2radian(raido))

						hitAciton:setPosition(cc.p(target_n.x + offsetX, target_n.y + offsetY))
						hitAciton:play()
						hitAciton:addEndCallback(function()
							hitAciton:removeFromParent()
						end)
						hitAciton:addCallbackAtFrame(5, function()
							if callback and callback.hitCall then
								callback.hitCall(cc.p(target_n.x + offsetX, target_n.y + offsetY))
							end
						end)
					end)
					local fixLength = 37
					local offsetY = fixLength * math.sin(math.angle2radian(raido))
					local offsetX = fixLength * math.cos(math.angle2radian(raido))
					local moveTo4 = cc.MoveBy:create(0.033333333333333326 * factor, cc.p(offsetX, offsetY))
					local moveTo5 = cc.MoveTo:create(0.33333333333333337 * factor, pos)
					local action2 = cc.Sequence:create(moveTo1, moveTo2, moveTo3, (animNode or nil) and cc.CallFunc:create(function()
						return
					end), moveTo4, moveTo5)
					local action = cc.Spawn:create(action1, action2)
					local action = cc.Sequence:create(action, cc.CallFunc:create(function()
						if callback and callback.endCall then
							callback.endCall()
						end
					end))

					if animNode then
						if not tolua.isnull(animNode) then
							animNode:runAction(action)
						end
					else
						actor:runAction(action)
					end
				end
			}
		},
		DWH = {
			idle = {
				effect = "",
				action = function(cfg, actor, factor, animNode)
					if animNode then
						animNode:runAction(create_common_idle(cfg, actor, factor))
					else
						actor:getDisplayNode():runAction(create_common_idle(cfg, actor, factor))
					end
				end
			},
			attack = {
				flash = "03xue_qiuqiuzhandou",
				hitflash = "03beiji_qiuqiuzhandou",
				action = function(cfg, actor, target, factor, callback, animNode)
					if not actor:getDisplayNode():isVisible() then
						if callback and callback.endCall then
							local delay = cc.DelayTime:create(3)
							local action = cc.Sequence:create(delay, cc.CallFunc:create(function()
								callback.endCall(action)
							end))

							actor:resetTrans()
							actor:getDisplayNode():runAction(action)
						end

						return
					end

					local raido = actor._Radio
					local atkEffectProp = actor:getAtkEffectProp()
					local effectLayer = actor:getEffectLayer()
					local org_w = actor:getDisplayNode():getParent():convertToWorldSpace(cc.p(actor:getDisplayNode():getPosition()))
					local target_w = target:getDisplayNode():getParent():convertToWorldSpace(cc.p(target:getDisplayNode():getPosition()))
					local target_n = cc.p(actor:getDisplayNode():getParent():convertToNodeSpace(target_w))
					local pos = cc.p(actor:getPosition())
					local scale = actor:getScale()
					local actor = actor:getDisplayNode()
					local scaleTo1 = cc.ScaleTo:create(0.03333333333333333 * factor, scale * 1)
					local scaleTo2 = cc.ScaleTo:create(0.13333333333333333 * factor, scale * 1.27)
					local scaleTo3 = cc.ScaleTo:create(0.2666666666666667 * factor, scale * 1.27)
					local scaleTo4 = cc.ScaleTo:create(0.033333333333333326 * factor, scale * 1.27)
					local scaleTo5 = cc.ScaleTo:create(0.3666666666666667 * factor, scale * 1)
					local action1 = cc.Sequence:create(scaleTo1, scaleTo2, scaleTo3, scaleTo4, scaleTo5)
					local fixLength = 27
					local offsetY = fixLength * math.sin(math.angle2radian(raido))
					local offsetX = fixLength * math.cos(math.angle2radian(raido))
					local moveTo1 = cc.MoveTo:create(0.16666666666666666 * factor, pos)
					local moveTo2 = cc.MoveBy:create(0.2666666666666667 * factor, cc.p(offsetX, offsetY))
					local fixLength = 100 * target:getScale()
					local offsetY = fixLength * math.sin(math.angle2radian(raido))
					local offsetX = fixLength * math.cos(math.angle2radian(raido))
					local moveTo3 = cc.MoveTo:create(0.033333333333333326 * factor, cc.p(target_n.x + offsetX, target_n.y + offsetY))
					local hitAnim = cc.CallFunc:create(function()
						if tolua.isnull(actor) then
							return
						end

						if not effectLayer:isVisible() then
							return
						end

						if not actor:isVisible() then
							return
						end

						local prop = math.random(0, 10) / 10

						if prop > atkEffectProp then
							return
						end

						local org_w = actor:getParent():convertToWorldSpace(cc.p(actor:getPosition()))
						local hitAciton = cc.MovieClip:create(cfg.flash)

						hitAciton:addTo(effectLayer)
						hitAciton:setRotation(180 - raido)
						hitAciton:setScale(actor:getScale() * k_EFFECT_SCALE)

						local raidoReal = (180 - raido) % 360

						if raidoReal > 90 and raidoReal < 270 then
							hitAciton:setScaleY(-actor:getScale() * k_EFFECT_SCALE)
						else
							hitAciton:setScaleY(actor:getScale() * k_EFFECT_SCALE)
						end

						local org_n = cc.p(effectLayer:convertToNodeSpace(org_w))
						local target_n = cc.p(effectLayer:convertToNodeSpace(target_w))
						local fixLength = 100 * target:getScale()
						local offsetY = fixLength * math.sin(math.angle2radian(raido))
						local offsetX = fixLength * math.cos(math.angle2radian(raido))

						hitAciton:setPosition(cc.p(target_n.x + offsetX, target_n.y + offsetY))
						hitAciton:play()
						hitAciton:addEndCallback(function()
							hitAciton:removeFromParent()
						end)
						hitAciton:addCallbackAtFrame(5, function()
							if callback and callback.hitCall then
								callback.hitCall(cc.p(target_n.x + offsetX, target_n.y + offsetY))
							end
						end)
					end)
					local fixLength = 37
					local offsetY = fixLength * math.sin(math.angle2radian(raido))
					local offsetX = fixLength * math.cos(math.angle2radian(raido))
					local moveTo4 = cc.MoveBy:create(0.033333333333333326 * factor, cc.p(offsetX, offsetY))
					local moveTo5 = cc.MoveTo:create(0.33333333333333337 * factor, pos)
					local action2 = cc.Sequence:create(moveTo1, moveTo2, moveTo3, (animNode or nil) and cc.CallFunc:create(function()
						return
					end), moveTo4, moveTo5)
					local action = cc.Spawn:create(action1, action2)
					local action = cc.Sequence:create(action, cc.CallFunc:create(function()
						if callback and callback.endCall then
							callback.endCall()
						end
					end))

					if animNode then
						if not tolua.isnull(animNode) then
							animNode:runAction(action)
						end
					else
						actor:runAction(action)
					end
				end
			}
		},
		XD = {
			idle = {
				effect = "",
				action = function(cfg, actor, factor, animNode)
					if animNode then
						animNode:runAction(create_common_idle(cfg, actor, factor))
					else
						actor:getDisplayNode():runAction(create_common_idle(cfg, actor, factor))
					end
				end
			},
			attack = {
				flash = "zhuji_qiuqiuzhandou",
				hitflash = "01beiji_qiuqiuzhandou",
				action = function(cfg, actor, target, factor, callback, animNode)
					if not actor:getDisplayNode():isVisible() then
						if callback and callback.endCall then
							local delay = cc.DelayTime:create(3)
							local action = cc.Sequence:create(delay, cc.CallFunc:create(function()
								callback.endCall(action)
							end))

							actor:resetTrans()
							actor:getDisplayNode():runAction(action)
						end

						return
					end

					local raido = actor._Radio
					local atkEffectProp = actor:getAtkEffectProp()
					local effectLayer = actor:getEffectLayer()
					local org_w = actor:getDisplayNode():getParent():convertToWorldSpace(cc.p(actor:getDisplayNode():getPosition()))
					local target_w = target:getDisplayNode():getParent():convertToWorldSpace(cc.p(target:getDisplayNode():getPosition()))
					local target_n = cc.p(actor:getDisplayNode():getParent():convertToNodeSpace(target_w))
					local pos = cc.p(actor:getPosition())
					local scale = actor:getScale()
					local actor = actor:getDisplayNode()
					local scaleTo1 = cc.ScaleTo:create(0.03333333333333333 * factor, scale * 1)
					local scaleTo2 = cc.ScaleTo:create(0.13333333333333333 * factor, scale * 1.27)
					local scaleTo3 = cc.ScaleTo:create(0.2666666666666667 * factor, scale * 1.27)
					local scaleTo4 = cc.ScaleTo:create(0.033333333333333326 * factor, scale * 1.27)
					local scaleTo5 = cc.ScaleTo:create(0.3666666666666667 * factor, scale * 1)
					local action1 = cc.Sequence:create(scaleTo1, scaleTo2, scaleTo3, scaleTo4, scaleTo5)
					local fixLength = 27
					local offsetY = fixLength * math.sin(math.angle2radian(raido))
					local offsetX = fixLength * math.cos(math.angle2radian(raido))
					local moveTo1 = cc.MoveTo:create(0.16666666666666666 * factor, pos)
					local moveTo2 = cc.MoveBy:create(0.2666666666666667 * factor, cc.p(offsetX, offsetY))
					local fixLength = 100 * target:getScale()
					local offsetY = fixLength * math.sin(math.angle2radian(raido))
					local offsetX = fixLength * math.cos(math.angle2radian(raido))
					local moveTo3 = cc.MoveTo:create(0.033333333333333326 * factor, cc.p(target_n.x + offsetX, target_n.y + offsetY))
					local hitAnim = cc.CallFunc:create(function()
						if tolua.isnull(actor) then
							return
						end

						if not effectLayer:isVisible() then
							return
						end

						if not actor:isVisible() then
							return
						end

						local prop = math.random(0, 10) / 10

						if prop > atkEffectProp then
							return
						end

						local org_w = actor:getParent():convertToWorldSpace(cc.p(actor:getPosition()))
						local hitAciton = cc.MovieClip:create(cfg.flash)

						hitAciton:addTo(effectLayer)
						hitAciton:setRotation(180 - raido)
						hitAciton:setScale(actor:getScale() * k_EFFECT_SCALE)

						local org_n = cc.p(effectLayer:convertToNodeSpace(org_w))
						local target_n = cc.p(effectLayer:convertToNodeSpace(target_w))
						local fixLength = 100 * target:getScale()
						local offsetY = fixLength * math.sin(math.angle2radian(raido))
						local offsetX = fixLength * math.cos(math.angle2radian(raido))

						hitAciton:setPosition(cc.p(target_n.x + offsetX, target_n.y + offsetY))
						hitAciton:play()
						hitAciton:addEndCallback(function()
							hitAciton:removeFromParent()
						end)
						hitAciton:addCallbackAtFrame(5, function()
							if callback and callback.hitCall then
								callback.hitCall(cc.p(target_n.x + offsetX, target_n.y + offsetY))
							end
						end)
					end)
					local fixLength = 37
					local offsetY = fixLength * math.sin(math.angle2radian(raido))
					local offsetX = fixLength * math.cos(math.angle2radian(raido))
					local moveTo4 = cc.MoveBy:create(0.033333333333333326 * factor, cc.p(offsetX, offsetY))
					local moveTo5 = cc.MoveTo:create(0.33333333333333337 * factor, pos)
					local action2 = cc.Sequence:create(moveTo1, moveTo2, moveTo3, (animNode or nil) and cc.CallFunc:create(function()
						return
					end), moveTo4, moveTo5)
					local action = cc.Spawn:create(action1, action2)
					local action = cc.Sequence:create(action, cc.CallFunc:create(function()
						if callback and callback.endCall then
							callback.endCall()
						end
					end))

					if animNode then
						if not tolua.isnull(animNode) then
							animNode:runAction(action)
						end
					else
						actor:runAction(action)
					end
				end
			}
		},
		MNJH = {
			idle = {
				effect = "",
				action = function(cfg, actor, factor, animNode)
					if animNode then
						animNode:runAction(create_common_idle(cfg, actor, factor))
					else
						actor:getDisplayNode():runAction(create_common_idle(cfg, actor, factor))
					end
				end
			},
			attack = {
				flash = "05beiji_qiuqiuzhandou",
				hitflash = "05yuansu_qiuqiuzhandou",
				xuliflash = "05xiuli_qiuqiuzhandou",
				action = function(cfg, actor, target, factor, callback, animNode)
					if not actor:getDisplayNode():isVisible() then
						if callback and callback.endCall then
							local delay = cc.DelayTime:create(3)
							local action = cc.Sequence:create(delay, cc.CallFunc:create(function()
								callback.endCall(action)
							end))

							actor:resetTrans()
							actor:getDisplayNode():runAction(action)
						end

						return
					end

					local raido = actor._Radio
					local atkEffectProp = actor:getAtkEffectProp()
					local effectLayer = actor:getEffectLayer()
					local underLayer = actor:getUnderLayer()
					local org_w = actor:getDisplayNode():getParent():convertToWorldSpace(cc.p(actor:getDisplayNode():getPosition()))
					local target_w = target:getDisplayNode():getParent():convertToWorldSpace(cc.p(target:getDisplayNode():getPosition()))
					local target_n = cc.p(actor:getDisplayNode():getParent():convertToNodeSpace(target_w))
					local pos = cc.p(actor:getPosition())
					local scale = actor:getScale()
					local actor = actor:getDisplayNode()
					local scaleTo1 = cc.ScaleTo:create(0.03333333333333333 * factor, scale * 1)
					local scaleTo2 = cc.ScaleTo:create(0.13333333333333333 * factor, scale * 1.27)
					local scaleTo3 = cc.ScaleTo:create(0.43333333333333335 * factor, scale * 1.42)
					local scaleTo4 = cc.ScaleTo:create(0.2333333333333334 * factor, scale * 0.9)
					local scaleTo5 = cc.ScaleTo:create(0.5 * factor, scale * 1)
					local hitAnim = cc.CallFunc:create(function()
						if tolua.isnull(actor) then
							return
						end

						if not effectLayer:isVisible() then
							return
						end

						if not actor:isVisible() then
							return
						end

						local prop = math.random(0, 10) / 10

						if prop > atkEffectProp then
							return
						end

						local hitAciton = cc.MovieClip:create(cfg.flash)

						hitAciton:addTo(effectLayer)
						hitAciton:setRotation(180 - raido)
						hitAciton:setScale(actor:getScale() * k_EFFECT_SCALE)

						local org_w = actor:getParent():convertToWorldSpace(cc.p(actor:getPosition()))
						local org_n = cc.p(effectLayer:convertToNodeSpace(org_w))
						local target_n = cc.p(effectLayer:convertToNodeSpace(target_w))
						local fixLength = -80
						local offsetY = fixLength * math.sin(math.angle2radian(raido))
						local offsetX = fixLength * math.cos(math.angle2radian(raido))

						hitAciton:setPosition(cc.p(org_n.x + offsetX, org_n.y + offsetY))

						local fixLength = -150 * target:getScale()
						local offsetY = fixLength * math.sin(math.angle2radian(raido))
						local offsetX = fixLength * math.cos(math.angle2radian(raido))
						local moveTo5 = cc.MoveTo:create(0.16666666666666666 * factor, cc.p(target_n.x - offsetX, target_n.y - offsetY))

						hitAciton:runAction(moveTo5)
						hitAciton:play()
						hitAciton:addEndCallback(function()
							hitAciton:removeFromParent()
						end)
						hitAciton:addCallbackAtFrame(1, function()
							if callback and callback.hitCall then
								callback.hitCall(cc.p(target_n.x - offsetX, target_n.y - offsetY))
							end
						end)
					end)
					local action1 = cc.Sequence:create(scaleTo1, scaleTo2, scaleTo3, (animNode or nil) and cc.CallFunc:create(function()
						return
					end), scaleTo4, scaleTo5)
					local moveTo0 = cc.MoveBy:create(0.16666666666666666 * factor, cc.p(0, 0))
					local moveTo1 = cc.MoveBy:create(0.033333333333333354 * factor, cc.p(-8, 0))
					local moveTo2 = cc.MoveBy:create(0.06666666666666665 * factor, cc.p(8, 0))
					local moveTo3 = cc.MoveBy:create(0.033333333333333326 * factor, cc.p(0, -5))
					local moveTo4 = cc.MoveBy:create(0.033333333333333326 * factor, cc.p(0, 5))
					local moveTo5 = cc.MoveBy:create(0.033333333333333326 * factor, cc.p(-3, 0))
					local moveTo6 = cc.MoveBy:create(0.03333333333333338 * factor, cc.p(3, 0))
					local action2 = cc.Sequence:create(moveTo1, moveTo2, moveTo3, moveTo4, moveTo5, moveTo6)
					local action = cc.Spawn:create(action1, action2)
					local action = cc.Sequence:create(action, cc.CallFunc:create(function()
						if callback and callback.endCall then
							callback.endCall()
						end
					end))

					if animNode then
						if not tolua.isnull(animNode) then
							animNode:runAction(action)
						end
					else
						if not tolua.isnull(xuliAciton) then
							local xuliAciton = cc.MovieClip:create(cfg.xuliflash)

							xuliAciton:addTo(underLayer)
							xuliAciton:setScale(actor:getScale() * k_XULI_EFFECT_SCALE)

							local org_n = cc.p(underLayer:convertToNodeSpace(org_w))

							xuliAciton:setPosition(cc.p(org_n.x, org_n.y))
							xuliAciton:addEndCallback(function()
								xuliAciton:removeFromParent()
							end)
							xuliAciton:runAction(action)
						end

						actor:runAction(action)
					end
				end
			}
		},
		BSNCT = {
			idle = {
				effect = "",
				action = function(cfg, actor, factor, animNode)
					if animNode then
						animNode:runAction(create_common_idle(cfg, actor, factor))
					else
						actor:getDisplayNode():runAction(create_common_idle(cfg, actor, factor))
					end
				end
			},
			attack = {
				flash = "06jian_qiuqiuzhandou",
				xuliflash = "06xuli_qiuqiuzhandou",
				action = function(cfg, actor, target, factor, callback, animNode)
					if not actor:getDisplayNode():isVisible() then
						if callback and callback.endCall then
							local delay = cc.DelayTime:create(3)
							local action = cc.Sequence:create(delay, cc.CallFunc:create(function()
								callback.endCall(action)
							end))

							actor:resetTrans()
							actor:getDisplayNode():runAction(action)
						end

						return
					end

					local raido = actor._Radio
					local atkEffectProp = actor:getAtkEffectProp()
					local effectLayer = actor:getEffectLayer()
					local underLayer = actor:getUnderLayer()
					local org_w = actor:getDisplayNode():getParent():convertToWorldSpace(cc.p(actor:getDisplayNode():getPosition()))
					local target_w = target:getDisplayNode():getParent():convertToWorldSpace(cc.p(target:getDisplayNode():getPosition()))
					local target_n = cc.p(actor:getDisplayNode():getParent():convertToNodeSpace(target_w))
					local pos = cc.p(actor:getPosition())
					local scale = actor:getScale()
					local actor = actor:getDisplayNode()
					local scaleTo1 = cc.ScaleTo:create(0.03333333333333333 * factor, scale * 1)
					local scaleTo2 = cc.ScaleTo:create(0.13333333333333333 * factor, scale * 1.27)
					local scaleTo3 = cc.ScaleTo:create(0.43333333333333335 * factor, scale * 1.42)
					local scaleTo4 = cc.ScaleTo:create(0.2333333333333334 * factor, scale * 0.9)
					local scaleTo5 = cc.ScaleTo:create(0.5 * factor, scale * 1)
					local hitAnim = cc.CallFunc:create(function()
						if tolua.isnull(actor) then
							return
						end

						if not effectLayer:isVisible() then
							return
						end

						if not actor:isVisible() then
							return
						end

						local prop = math.random(0, 10) / 10

						if prop > atkEffectProp then
							return
						end

						local hitAciton = cc.MovieClip:create(cfg.flash)

						hitAciton:addTo(effectLayer)
						hitAciton:setRotation(180 - raido)
						hitAciton:setScale(actor:getScale() * k_EFFECT_SCALE)

						local org_w = actor:getParent():convertToWorldSpace(cc.p(actor:getPosition()))
						local org_n = cc.p(effectLayer:convertToNodeSpace(org_w))
						local target_n = cc.p(effectLayer:convertToNodeSpace(target_w))
						local fixLength = -250
						local offsetY = fixLength * math.sin(math.angle2radian(raido))
						local offsetX = fixLength * math.cos(math.angle2radian(raido))

						hitAciton:setPosition(cc.p(org_n.x + offsetX, org_n.y + offsetY))

						local fixLength = -80 * target:getScale()
						local offsetY = fixLength * math.sin(math.angle2radian(raido))
						local offsetX = fixLength * math.cos(math.angle2radian(raido))
						local moveTo5 = cc.MoveTo:create(0.16666666666666666 * factor, cc.p(target_n.x - offsetX, target_n.y - offsetY))

						hitAciton:runAction(moveTo5)
						hitAciton:play()
						hitAciton:addEndCallback(function()
							hitAciton:removeFromParent()
						end)
						hitAciton:addCallbackAtFrame(1, function()
							if callback and callback.hitCall then
								callback.hitCall(cc.p(target_n.x - offsetX, target_n.y - offsetY))
							end
						end)
					end)
					local action1 = cc.Sequence:create(scaleTo1, scaleTo2, scaleTo3, (animNode or nil) and cc.CallFunc:create(function()
						return
					end), scaleTo4, scaleTo5)
					local moveTo0 = cc.MoveBy:create(0.16666666666666666 * factor, cc.p(0, 0))
					local moveTo1 = cc.MoveBy:create(0.033333333333333354 * factor, cc.p(-8, 0))
					local moveTo2 = cc.MoveBy:create(0.06666666666666665 * factor, cc.p(8, 0))
					local moveTo3 = cc.MoveBy:create(0.033333333333333326 * factor, cc.p(0, -5))
					local moveTo4 = cc.MoveBy:create(0.033333333333333326 * factor, cc.p(0, 5))
					local moveTo5 = cc.MoveBy:create(0.033333333333333326 * factor, cc.p(-3, 0))
					local moveTo6 = cc.MoveBy:create(0.03333333333333338 * factor, cc.p(3, 0))
					local action2 = cc.Sequence:create(moveTo1, moveTo2, moveTo3, moveTo4, moveTo5, moveTo6)
					local action = cc.Spawn:create(action1, action2)
					local action = cc.Sequence:create(action, cc.CallFunc:create(function()
						if callback and callback.endCall then
							callback.endCall()
						end
					end))

					if animNode then
						if not tolua.isnull(animNode) then
							animNode:runAction(action)
						end
					else
						if not tolua.isnull(xuliAciton) then
							local xuliAciton = cc.MovieClip:create(cfg.xuliflash)

							xuliAciton:addTo(underLayer)
							xuliAciton:setScale(actor:getScale() * k_XULI_EFFECT_SCALE)

							local org_n = cc.p(underLayer:convertToNodeSpace(org_w))

							xuliAciton:setPosition(cc.p(org_n.x, org_n.y))
							xuliAciton:addEndCallback(function()
								xuliAciton:removeFromParent()
							end)
							xuliAciton:runAction(action)
						end

						actor:runAction(action)
					end
				end
			}
		},
		SSZS = {
			idle = {
				effect = "",
				action = function(cfg, actor, factor, animNode)
					if animNode then
						animNode:runAction(create_common_idle(cfg, actor, factor))
					else
						actor:getDisplayNode():runAction(create_common_idle(cfg, actor, factor))
					end
				end
			},
			attack = {
				flash = "mofa_qiuqiuzhandou",
				hitflash = "04beiji_qiuqiuzhandou",
				xuliflash = "04xiuli_qiuqiuzhandou",
				action = function(cfg, actor, target, factor, callback, animNode)
					if not actor:getDisplayNode():isVisible() then
						if callback and callback.endCall then
							local delay = cc.DelayTime:create(3)
							local action = cc.Sequence:create(delay, cc.CallFunc:create(function()
								callback.endCall(action)
							end))

							actor:resetTrans()
							actor:getDisplayNode():runAction(action)
						end

						return
					end

					local raido = actor._Radio
					local atkEffectProp = actor:getAtkEffectProp()
					local effectLayer = actor:getEffectLayer()
					local underLayer = actor:getUnderLayer()
					local org_w = actor:getDisplayNode():getParent():convertToWorldSpace(cc.p(actor:getDisplayNode():getPosition()))
					local target_w = target:getDisplayNode():getParent():convertToWorldSpace(cc.p(target:getDisplayNode():getPosition()))
					local target_n = cc.p(actor:getDisplayNode():getParent():convertToNodeSpace(target_w))
					local pos = cc.p(actor:getPosition())
					local scale = actor:getScale()
					local actor = actor:getDisplayNode()
					local scaleTo1 = cc.ScaleTo:create(0.03333333333333333 * factor, scale * 1)
					local scaleTo2 = cc.ScaleTo:create(0.13333333333333333 * factor, scale * 1.27)
					local scaleTo3 = cc.ScaleTo:create(0.43333333333333335 * factor, scale * 1.42)
					local scaleTo4 = cc.ScaleTo:create(0.2333333333333334 * factor, scale * 0.9)
					local scaleTo5 = cc.ScaleTo:create(0.5 * factor, scale * 1)
					local hitAnim = cc.CallFunc:create(function()
						if tolua.isnull(actor) then
							return
						end

						if not effectLayer:isVisible() then
							return
						end

						if not actor:isVisible() then
							return
						end

						local prop = math.random(0, 10) / 10

						if prop > atkEffectProp then
							return
						end

						local hitAciton = cc.MovieClip:create(cfg.flash)

						hitAciton:addTo(effectLayer)
						hitAciton:setRotation(180 - raido)
						hitAciton:setScale(actor:getScale() * k_EFFECT_SCALE)

						local org_w = actor:getParent():convertToWorldSpace(cc.p(actor:getPosition()))
						local org_n = cc.p(effectLayer:convertToNodeSpace(org_w))
						local target_n = cc.p(effectLayer:convertToNodeSpace(target_w))
						local fixLength = 0
						local offsetY = fixLength * math.sin(math.angle2radian(raido))
						local offsetX = fixLength * math.cos(math.angle2radian(raido))

						hitAciton:setPosition(cc.p(org_n.x + offsetX, org_n.y + offsetY))

						local fixLength = -150 * target:getScale()
						local offsetY = fixLength * math.sin(math.angle2radian(raido))
						local offsetX = fixLength * math.cos(math.angle2radian(raido))
						local moveTo5 = cc.MoveTo:create(0.16666666666666666 * factor, cc.p(target_n.x - offsetX, target_n.y - offsetY))

						hitAciton:runAction(moveTo5)
						hitAciton:play()
						hitAciton:addEndCallback(function()
							hitAciton:removeFromParent()
						end)
						hitAciton:addCallbackAtFrame(5, function()
							if callback and callback.hitCall then
								callback.hitCall(cc.p(target_n.x - offsetX, target_n.y - offsetY))
							end
						end)
					end)
					local action1 = cc.Sequence:create(scaleTo1, scaleTo2, scaleTo3, (animNode or nil) and cc.CallFunc:create(function()
						return
					end), scaleTo4, scaleTo5)
					local moveTo0 = cc.MoveBy:create(0.16666666666666666 * factor, cc.p(0, 0))
					local moveTo1 = cc.MoveBy:create(0.033333333333333354 * factor, cc.p(-8, 0))
					local moveTo2 = cc.MoveBy:create(0.06666666666666665 * factor, cc.p(8, 0))
					local moveTo3 = cc.MoveBy:create(0.033333333333333326 * factor, cc.p(0, -5))
					local moveTo4 = cc.MoveBy:create(0.033333333333333326 * factor, cc.p(0, 5))
					local moveTo5 = cc.MoveBy:create(0.033333333333333326 * factor, cc.p(-3, 0))
					local moveTo6 = cc.MoveBy:create(0.03333333333333338 * factor, cc.p(3, 0))
					local action2 = cc.Sequence:create(moveTo1, moveTo2, moveTo3, moveTo4, moveTo5, moveTo6)
					local action = cc.Spawn:create(action1, action2)
					local action = cc.Sequence:create(action, cc.CallFunc:create(function()
						if callback and callback.endCall then
							callback.endCall()
						end
					end))

					if animNode then
						if not tolua.isnull(animNode) then
							animNode:runAction(action)
						end
					else
						if not tolua.isnull(xuliAciton) then
							local xuliAciton = cc.MovieClip:create(cfg.xuliflash)

							xuliAciton:addTo(underLayer)
							xuliAciton:setScale(actor:getScale() * k_XULI_EFFECT_SCALE)

							local org_n = cc.p(underLayer:convertToNodeSpace(org_w))

							xuliAciton:setPosition(cc.p(org_n.x, org_n.y))
							xuliAciton:addEndCallback(function()
								xuliAciton:removeFromParent()
							end)
							xuliAciton:runAction(action)
						end

						actor:runAction(action)
					end
				end
			}
		}
	}

	return actions[type]
end

function WorldPeaceActionFactory.class:getWorldBossActionDefine(type)
	local function create_common_idle(cfg, actor, factor)
		local actor = actor:getDisplayNode()
		local pos = cc.p(actor:getPosition())
		local scale = actor:getScale()
		local scaleTo1 = cc.ScaleTo:create(0.03333333333333333 * factor, scale * 1)
		local scaleTo2 = cc.ScaleTo:create(0.4 * factor, scale * 1.05)
		local scaleTo3 = cc.ScaleTo:create(0.033333333333333326 * factor, scale * 1.05)
		local scaleTo4 = cc.ScaleTo:create(0.6 * factor, scale * 1)
		local action = cc.Sequence:create(scaleTo1, scaleTo2, scaleTo3, scaleTo4)

		return (cc.RepeatForever:create(action))
	end

	local actions = {
		CLUBBOSSSTAGETWO = {
			idle = {
				effect = "",
				action = function(cfg, actor, target, factor)
					actor:refreshLine(target)
				end
			},
			attack = {
				action = function(cfg, actor, target, factor, callback)
					if callback and callback.hitCall then
						local target_w = target:getDisplayNode():getParent():convertToWorldSpace(cc.p(target:getDisplayNode():getPosition()))
						local target_n = cc.p(actor:getDisplayNode():getParent():convertToNodeSpace(target_w))

						callback.hitCall(cc.p(target_n.x + 0, target_n.y + 0))
					end

					if callback and callback.endCall then
						actor:resetTrans()
						callback.endCall()
					end

					actor:onAttacking(target, 1)
					actor:refreshLine(target)
				end
			}
		},
		SIMPLE = {
			idle = {
				effect = "",
				action = function(cfg, actor, factor, animNode)
					if animNode then
						animNode:runAction(create_common_idle(cfg, actor, factor))
					else
						actor:getDisplayNode():runAction(create_common_idle(cfg, actor, factor))
					end
				end
			},
			attack = {
				action = function(cfg, actor, target, factor, callback, animNode)
					local raido = actor._Radio

					if not actor:getDisplayNode():isVisible() then
						if callback and callback.endCall then
							local delay = cc.DelayTime:create(3)
							local action = cc.Sequence:create(delay, cc.CallFunc:create(function()
								callback.endCall(action)
							end))

							actor:resetTrans()
							actor:getDisplayNode():runAction(action)
						end

						return
					end

					animNode:setScale(1)

					local effectLayer = actor:getEffectLayer()
					local org_w = actor:getDisplayNode():getParent():convertToWorldSpace(cc.p(actor:getDisplayNode():getPosition()))
					local target_w = target:getDisplayNode():getParent():convertToWorldSpace(cc.p(target:getDisplayNode():getPosition()))
					local target_n = cc.p(actor:getDisplayNode():getParent():convertToNodeSpace(target_w))
					local pos = cc.p(actor:getPosition())
					local scale = actor:getScale()
					local actor = actor:getDisplayNode()
					local scaleTo1 = cc.ScaleTo:create(0.03333333333333333 * factor, scale * 1)
					local scaleTo2 = cc.ScaleTo:create(0.13333333333333333 * factor, scale * 1.27)
					local scaleTo3 = cc.ScaleTo:create(0.2666666666666667 * factor, scale * 1.27)
					local scaleTo4 = cc.ScaleTo:create(0.16666666666666663 * factor, scale * 1.27)
					local scaleTo5 = cc.ScaleTo:create(0.4 * factor, scale * 1)
					local action1 = cc.Sequence:create(scaleTo1, scaleTo2, scaleTo3, scaleTo4, scaleTo5)
					local fixLength = 27
					local offsetY = fixLength * math.sin(math.angle2radian(raido))
					local offsetX = fixLength * math.cos(math.angle2radian(raido))
					local moveTo1 = cc.MoveTo:create(0.16666666666666666 * factor, pos)
					local moveTo2 = cc.MoveBy:create(0.2666666666666667 * factor, cc.p(offsetX, offsetY))
					local fixLength = 100 * target:getScale()
					local offsetY = fixLength * math.sin(math.angle2radian(raido))
					local offsetX = fixLength * math.cos(math.angle2radian(raido))
					local moveTo3 = cc.MoveTo:create(0.033333333333333326 * factor, cc.p(target_n.x + offsetX, target_n.y + offsetY))
					local hitAnim = cc.CallFunc:create(function()
						if tolua.isnull(actor) then
							return
						end

						if not effectLayer:isVisible() then
							return
						end

						if not actor:isVisible() then
							if callback and callback.endCall then
								callback.endCall()
							end

							return
						end

						local org_n = cc.p(effectLayer:convertToNodeSpace(org_w))
						local target_n = cc.p(effectLayer:convertToNodeSpace(target_w))

						if callback and callback.hitCall then
							callback.hitCall(cc.p(target_n.x + offsetX, target_n.y + offsetY))
						end
					end)
					local fixLength = 37
					local offsetY = fixLength * math.sin(math.angle2radian(raido))
					local offsetX = fixLength * math.cos(math.angle2radian(raido))
					local moveTo4 = cc.MoveBy:create(0.1333333333333333 * factor, cc.p(offsetX, offsetY))
					local moveTo5 = cc.MoveTo:create(0.4 * factor, pos)
					local action2 = cc.Sequence:create(moveTo1, moveTo2, moveTo3, hitAnim, moveTo4, moveTo5)
					local action = cc.Spawn:create(action1, action2)
					local action = cc.Sequence:create(action, cc.CallFunc:create(function()
						if callback and callback.endCall then
							callback.endCall()
						end
					end))

					if animNode then
						if not tolua.isnull(animNode) then
							animNode:runAction(action)
						end
					else
						actor:runAction(action)
					end
				end
			}
		},
		WNSXJ = {
			idle = {
				effect = "",
				action = function(cfg, actor, factor, animNode)
					if animNode then
						animNode:runAction(create_common_idle(cfg, actor, factor))
					else
						actor:getDisplayNode():runAction(create_common_idle(cfg, actor, factor))
					end
				end
			},
			attack = {
				flash = "02daoguang_qiuqiuzhandou",
				hitflash = "02beiji_qiuqiuzhandou",
				action = function(cfg, actor, target, factor, callback, animNode)
					if not actor:getDisplayNode():isVisible() then
						if callback and callback.endCall then
							local delay = cc.DelayTime:create(3)
							local action = cc.Sequence:create(delay, cc.CallFunc:create(function()
								callback.endCall(action)
							end))

							actor:resetTrans()
							actor:getDisplayNode():runAction(action)
						end

						return
					end

					local atkEffectProp = actor:getAtkEffectProp()
					local raido = actor._Radio
					local effectLayer = actor:getEffectLayer()
					local org_w = actor:getDisplayNode():getParent():convertToWorldSpace(cc.p(actor:getDisplayNode():getPosition()))
					local target_w = target:getDisplayNode():getParent():convertToWorldSpace(cc.p(target:getDisplayNode():getPosition()))
					local target_n = cc.p(actor:getDisplayNode():getParent():convertToNodeSpace(target_w))
					local pos = cc.p(actor:getPosition())
					local scale = actor:getScale()
					local actor = actor:getDisplayNode()
					local scaleTo1 = cc.ScaleTo:create(0.03333333333333333 * factor, scale * 1)
					local scaleTo2 = cc.ScaleTo:create(0.13333333333333333 * factor, scale * 1.27)
					local scaleTo3 = cc.ScaleTo:create(0.2666666666666667 * factor, scale * 1.27)
					local scaleTo4 = cc.ScaleTo:create(0.16666666666666663 * factor, scale * 1.27)
					local scaleTo5 = cc.ScaleTo:create(0.4 * factor, scale * 1)
					local action1 = cc.Sequence:create(scaleTo1, scaleTo2, scaleTo3, scaleTo4, scaleTo5)
					local fixLength = 27
					local offsetY = fixLength * math.sin(math.angle2radian(raido))
					local offsetX = fixLength * math.cos(math.angle2radian(raido))
					local moveTo1 = cc.MoveTo:create(0.16666666666666666 * factor, pos)
					local moveTo2 = cc.MoveBy:create(0.2666666666666667 * factor, cc.p(offsetX, offsetY))
					local fixLength = 220 * target:getScale()
					local offsetY = fixLength * math.sin(math.angle2radian(raido))
					local offsetX = fixLength * math.cos(math.angle2radian(raido))
					local moveTo3 = cc.MoveTo:create(0.033333333333333326 * factor, cc.p(target_n.x + offsetX, target_n.y + offsetY))
					local hitAnim = cc.CallFunc:create(function()
						if tolua.isnull(actor) then
							return
						end

						if not effectLayer:isVisible() then
							return
						end

						if not actor:isVisible() then
							return
						end

						local prop = math.random(0, 10) / 10

						if prop > atkEffectProp then
							return
						end

						local org_w = actor:getParent():convertToWorldSpace(cc.p(actor:getPosition()))
						local hitAciton = cc.MovieClip:create(cfg.flash)

						hitAciton:addTo(effectLayer)
						hitAciton:setRotation(180 - raido)
						hitAciton:setScale(actor:getScale() * k_EFFECT_SCALE)

						local raidoReal = (180 - raido) % 360

						if raidoReal > 90 and raidoReal < 270 then
							hitAciton:setScaleY(-actor:getScale() * k_EFFECT_SCALE)
						else
							hitAciton:setScaleY(actor:getScale() * k_EFFECT_SCALE)
						end

						local org_n = cc.p(effectLayer:convertToNodeSpace(org_w))
						local target_n = cc.p(effectLayer:convertToNodeSpace(target_w))
						local fixLength = 220 * target:getScale()
						local offsetY = fixLength * math.sin(math.angle2radian(raido))
						local offsetX = fixLength * math.cos(math.angle2radian(raido))

						hitAciton:setPosition(cc.p(target_n.x + offsetX, target_n.y + offsetY))
						hitAciton:play()
						hitAciton:addEndCallback(function()
							hitAciton:removeFromParent()
						end)
						hitAciton:addCallbackAtFrame(5, function()
							if callback and callback.hitCall then
								callback.hitCall(cc.p(target_n.x + offsetX, target_n.y + offsetY))
							end

							local anim = cc.MovieClip:create("beiji_shijiebosszhd")

							anim:addTo(effectLayer)
							anim:setRotation(-raido)
							anim:addEndCallback(function()
								anim:removeFromParent()
							end)

							local fixLength = -230 * target:getScale()
							local offsetY = fixLength * math.sin(math.angle2radian(raido))
							local offsetX = fixLength * math.cos(math.angle2radian(raido))

							anim:setPosition(cc.p(target_n.x - offsetX, target_n.y - offsetY))
						end)
					end)
					local fixLength = 37
					local offsetY = fixLength * math.sin(math.angle2radian(raido))
					local offsetX = fixLength * math.cos(math.angle2radian(raido))
					local moveTo4 = cc.MoveBy:create(0.1333333333333333 * factor, cc.p(offsetX, offsetY))
					local moveTo5 = cc.MoveTo:create(0.4 * factor, pos)
					local action2 = cc.Sequence:create(moveTo1, moveTo2, moveTo3, (animNode or nil) and cc.CallFunc:create(function()
						return
					end), moveTo4, moveTo5)
					local action = cc.Spawn:create(action1, action2)
					local action = cc.Sequence:create(action, cc.CallFunc:create(function()
						if callback and callback.endCall then
							callback.endCall()
						end
					end))

					if animNode then
						if not tolua.isnull(animNode) then
							animNode:runAction(action)
						end
					else
						actor:runAction(action)
					end
				end
			}
		},
		DWH = {
			idle = {
				effect = "",
				action = function(cfg, actor, factor, animNode)
					if animNode then
						animNode:runAction(create_common_idle(cfg, actor, factor))
					else
						actor:getDisplayNode():runAction(create_common_idle(cfg, actor, factor))
					end
				end
			},
			attack = {
				flash = "03xue_qiuqiuzhandou",
				hitflash = "03beiji_qiuqiuzhandou",
				action = function(cfg, actor, target, factor, callback, animNode)
					if not actor:getDisplayNode():isVisible() then
						if callback and callback.endCall then
							local delay = cc.DelayTime:create(3)
							local action = cc.Sequence:create(delay, cc.CallFunc:create(function()
								callback.endCall(action)
							end))

							actor:resetTrans()
							actor:getDisplayNode():runAction(action)
						end

						return
					end

					local raido = actor._Radio
					local atkEffectProp = actor:getAtkEffectProp()
					local effectLayer = actor:getEffectLayer()
					local org_w = actor:getDisplayNode():getParent():convertToWorldSpace(cc.p(actor:getDisplayNode():getPosition()))
					local target_w = target:getDisplayNode():getParent():convertToWorldSpace(cc.p(target:getDisplayNode():getPosition()))
					local target_n = cc.p(actor:getDisplayNode():getParent():convertToNodeSpace(target_w))
					local pos = cc.p(actor:getPosition())
					local scale = actor:getScale()
					local actor = actor:getDisplayNode()
					local scaleTo1 = cc.ScaleTo:create(0.03333333333333333 * factor, scale * 1)
					local scaleTo2 = cc.ScaleTo:create(0.13333333333333333 * factor, scale * 1.27)
					local scaleTo3 = cc.ScaleTo:create(0.2666666666666667 * factor, scale * 1.27)
					local scaleTo4 = cc.ScaleTo:create(0.16666666666666663 * factor, scale * 1.27)
					local scaleTo5 = cc.ScaleTo:create(0.4 * factor, scale * 1)
					local action1 = cc.Sequence:create(scaleTo1, scaleTo2, scaleTo3, scaleTo4, scaleTo5)
					local fixLength = 27
					local offsetY = fixLength * math.sin(math.angle2radian(raido))
					local offsetX = fixLength * math.cos(math.angle2radian(raido))
					local moveTo1 = cc.MoveTo:create(0.16666666666666666 * factor, pos)
					local moveTo2 = cc.MoveBy:create(0.2666666666666667 * factor, cc.p(offsetX, offsetY))
					local fixLength = 230 * target:getScale()
					local offsetY = fixLength * math.sin(math.angle2radian(raido))
					local offsetX = fixLength * math.cos(math.angle2radian(raido))
					local moveTo3 = cc.MoveTo:create(0.033333333333333326 * factor, cc.p(target_n.x + offsetX, target_n.y + offsetY))
					local hitAnim = cc.CallFunc:create(function()
						if tolua.isnull(actor) then
							return
						end

						if not effectLayer:isVisible() then
							return
						end

						if not actor:isVisible() then
							return
						end

						local prop = math.random(0, 10) / 10

						if prop > atkEffectProp then
							return
						end

						local org_w = actor:getParent():convertToWorldSpace(cc.p(actor:getPosition()))
						local hitAciton = cc.MovieClip:create(cfg.flash)

						hitAciton:addTo(effectLayer)
						hitAciton:setRotation(180 - raido)
						hitAciton:setScale(actor:getScale() * k_EFFECT_SCALE)

						local raidoReal = (180 - raido) % 360

						if raidoReal > 90 and raidoReal < 270 then
							hitAciton:setScaleY(-actor:getScale() * k_EFFECT_SCALE)
						else
							hitAciton:setScaleY(actor:getScale() * k_EFFECT_SCALE)
						end

						local org_n = cc.p(effectLayer:convertToNodeSpace(org_w))
						local target_n = cc.p(effectLayer:convertToNodeSpace(target_w))
						local fixLength = 230 * target:getScale()
						local offsetY = fixLength * math.sin(math.angle2radian(raido))
						local offsetX = fixLength * math.cos(math.angle2radian(raido))

						hitAciton:setPosition(cc.p(target_n.x + offsetX, target_n.y + offsetY))
						hitAciton:play()
						hitAciton:addEndCallback(function()
							hitAciton:removeFromParent()
						end)
						hitAciton:addCallbackAtFrame(5, function()
							if callback and callback.hitCall then
								callback.hitCall(cc.p(target_n.x + offsetX, target_n.y + offsetY))
							end

							local anim = cc.MovieClip:create("beiji_shijiebosszhd")

							anim:addTo(effectLayer)
							anim:setRotation(-raido)
							anim:addEndCallback(function()
								anim:removeFromParent()
							end)

							local fixLength = -240 * target:getScale()
							local offsetY = fixLength * math.sin(math.angle2radian(raido))
							local offsetX = fixLength * math.cos(math.angle2radian(raido))

							anim:setPosition(cc.p(target_n.x - offsetX, target_n.y - offsetY))
						end)
					end)
					local fixLength = 37
					local offsetY = fixLength * math.sin(math.angle2radian(raido))
					local offsetX = fixLength * math.cos(math.angle2radian(raido))
					local moveTo4 = cc.MoveBy:create(0.1333333333333333 * factor, cc.p(offsetX, offsetY))
					local moveTo5 = cc.MoveTo:create(0.4 * factor, pos)
					local action2 = cc.Sequence:create(moveTo1, moveTo2, moveTo3, (animNode or nil) and cc.CallFunc:create(function()
						return
					end), moveTo4, moveTo5)
					local action = cc.Spawn:create(action1, action2)
					local action = cc.Sequence:create(action, cc.CallFunc:create(function()
						if callback and callback.endCall then
							callback.endCall()
						end
					end))

					if animNode then
						if not tolua.isnull(animNode) then
							animNode:runAction(action)
						end
					else
						actor:runAction(action)
					end
				end
			}
		},
		XD = {
			idle = {
				effect = "",
				action = function(cfg, actor, factor, animNode)
					if animNode then
						animNode:runAction(create_common_idle(cfg, actor, factor))
					else
						actor:getDisplayNode():runAction(create_common_idle(cfg, actor, factor))
					end
				end
			},
			attack = {
				flash = "zhuji_qiuqiuzhandou",
				hitflash = "01beiji_qiuqiuzhandou",
				action = function(cfg, actor, target, factor, callback, animNode)
					if not actor:getDisplayNode():isVisible() then
						if callback and callback.endCall then
							local delay = cc.DelayTime:create(3)
							local action = cc.Sequence:create(delay, cc.CallFunc:create(function()
								callback.endCall(action)
							end))

							actor:resetTrans()
							actor:getDisplayNode():runAction(action)
						end

						return
					end

					local raido = actor._Radio
					local atkEffectProp = actor:getAtkEffectProp()
					local effectLayer = actor:getEffectLayer()
					local org_w = actor:getDisplayNode():getParent():convertToWorldSpace(cc.p(actor:getDisplayNode():getPosition()))
					local target_w = target:getDisplayNode():getParent():convertToWorldSpace(cc.p(target:getDisplayNode():getPosition()))
					local target_n = cc.p(actor:getDisplayNode():getParent():convertToNodeSpace(target_w))
					local pos = cc.p(actor:getPosition())
					local scale = actor:getScale()
					local actor = actor:getDisplayNode()
					local scaleTo1 = cc.ScaleTo:create(0.03333333333333333 * factor, scale * 1)
					local scaleTo2 = cc.ScaleTo:create(0.13333333333333333 * factor, scale * 1.27)
					local scaleTo3 = cc.ScaleTo:create(0.2666666666666667 * factor, scale * 1.27)
					local scaleTo4 = cc.ScaleTo:create(0.16666666666666663 * factor, scale * 1.27)
					local scaleTo5 = cc.ScaleTo:create(0.4 * factor, scale * 1)
					local action1 = cc.Sequence:create(scaleTo1, scaleTo2, scaleTo3, scaleTo4, scaleTo5)
					local fixLength = 27
					local offsetY = fixLength * math.sin(math.angle2radian(raido))
					local offsetX = fixLength * math.cos(math.angle2radian(raido))
					local moveTo1 = cc.MoveTo:create(0.16666666666666666 * factor, pos)
					local moveTo2 = cc.MoveBy:create(0.2666666666666667 * factor, cc.p(offsetX, offsetY))
					local fixLength = 220 * target:getScale()
					local offsetY = fixLength * math.sin(math.angle2radian(raido))
					local offsetX = fixLength * math.cos(math.angle2radian(raido))
					local moveTo3 = cc.MoveTo:create(0.033333333333333326 * factor, cc.p(target_n.x + offsetX, target_n.y + offsetY))
					local hitAnim = cc.CallFunc:create(function()
						if tolua.isnull(actor) then
							return
						end

						if not effectLayer:isVisible() then
							return
						end

						if not actor:isVisible() then
							return
						end

						local prop = math.random(0, 10) / 10

						if prop > atkEffectProp then
							return
						end

						local org_w = actor:getParent():convertToWorldSpace(cc.p(actor:getPosition()))
						local hitAciton = cc.MovieClip:create(cfg.flash)

						hitAciton:addTo(effectLayer)
						hitAciton:setRotation(180 - raido)
						hitAciton:setScale(actor:getScale() * k_EFFECT_SCALE)

						local org_n = cc.p(effectLayer:convertToNodeSpace(org_w))
						local target_n = cc.p(effectLayer:convertToNodeSpace(target_w))
						local fixLength = 220 * target:getScale()
						local offsetY = fixLength * math.sin(math.angle2radian(raido))
						local offsetX = fixLength * math.cos(math.angle2radian(raido))

						hitAciton:setPosition(cc.p(target_n.x + offsetX, target_n.y + offsetY))
						hitAciton:play()
						hitAciton:addEndCallback(function()
							hitAciton:removeFromParent()
						end)
						hitAciton:addCallbackAtFrame(5, function()
							if callback and callback.hitCall then
								callback.hitCall(cc.p(target_n.x + offsetX, target_n.y + offsetY))
							end

							local anim = cc.MovieClip:create("beiji_shijiebosszhd")

							anim:addTo(effectLayer)
							anim:setRotation(-raido)
							anim:addEndCallback(function()
								anim:removeFromParent()
							end)

							local fixLength = -230 * target:getScale()
							local offsetY = fixLength * math.sin(math.angle2radian(raido))
							local offsetX = fixLength * math.cos(math.angle2radian(raido))

							anim:setPosition(cc.p(target_n.x - offsetX, target_n.y - offsetY))
						end)
					end)
					local fixLength = 37
					local offsetY = fixLength * math.sin(math.angle2radian(raido))
					local offsetX = fixLength * math.cos(math.angle2radian(raido))
					local moveTo4 = cc.MoveBy:create(0.1333333333333333 * factor, cc.p(offsetX, offsetY))
					local moveTo5 = cc.MoveTo:create(0.4 * factor, pos)
					local action2 = cc.Sequence:create(moveTo1, moveTo2, moveTo3, (animNode or nil) and cc.CallFunc:create(function()
						return
					end), moveTo4, moveTo5)
					local action = cc.Spawn:create(action1, action2)
					local action = cc.Sequence:create(action, cc.CallFunc:create(function()
						if callback and callback.endCall then
							callback.endCall()
						end
					end))

					if animNode then
						if not tolua.isnull(animNode) then
							animNode:runAction(action)
						end
					else
						actor:runAction(action)
					end
				end
			}
		},
		MNJH = {
			idle = {
				effect = "",
				action = function(cfg, actor, factor, animNode)
					if animNode then
						animNode:runAction(create_common_idle(cfg, actor, factor))
					else
						actor:getDisplayNode():runAction(create_common_idle(cfg, actor, factor))
					end
				end
			},
			attack = {
				flash = "05beiji_qiuqiuzhandou",
				hitflash = "05yuansu_qiuqiuzhandou",
				xuliflash = "05xiuli_qiuqiuzhandou",
				action = function(cfg, actor, target, factor, callback, animNode)
					if not actor:getDisplayNode():isVisible() then
						if callback and callback.endCall then
							local delay = cc.DelayTime:create(3)
							local action = cc.Sequence:create(delay, cc.CallFunc:create(function()
								callback.endCall(action)
							end))

							actor:resetTrans()
							actor:getDisplayNode():runAction(action)
						end

						return
					end

					local raido = actor._Radio
					local atkEffectProp = actor:getAtkEffectProp()
					local effectLayer = actor:getEffectLayer()
					local underLayer = actor:getUnderLayer()
					local org_w = actor:getDisplayNode():getParent():convertToWorldSpace(cc.p(actor:getDisplayNode():getPosition()))
					local target_w = target:getDisplayNode():getParent():convertToWorldSpace(cc.p(target:getDisplayNode():getPosition()))
					local target_n = cc.p(actor:getDisplayNode():getParent():convertToNodeSpace(target_w))
					local pos = cc.p(actor:getPosition())
					local scale = actor:getScale()
					local actor = actor:getDisplayNode()
					local scaleTo1 = cc.ScaleTo:create(0.03333333333333333 * factor, scale * 1)
					local scaleTo2 = cc.ScaleTo:create(0.13333333333333333 * factor, scale * 1.27)
					local scaleTo3 = cc.ScaleTo:create(0.2666666666666667 * factor, scale * 1.42)
					local scaleTo4 = cc.ScaleTo:create(0.16666666666666663 * factor, scale * 0.9)
					local scaleTo5 = cc.ScaleTo:create(0.4 * factor, scale * 1)
					local hitAnim = cc.CallFunc:create(function()
						if tolua.isnull(actor) then
							return
						end

						if not effectLayer:isVisible() then
							return
						end

						if not actor:isVisible() then
							return
						end

						local prop = math.random(0, 10) / 10

						if prop > atkEffectProp then
							return
						end

						local hitAciton = cc.MovieClip:create(cfg.flash)

						hitAciton:addTo(effectLayer)
						hitAciton:setRotation(180 - raido)
						hitAciton:setScale(actor:getScale() * k_EFFECT_SCALE)

						local org_w = actor:getParent():convertToWorldSpace(cc.p(actor:getPosition()))
						local org_n = cc.p(effectLayer:convertToNodeSpace(org_w))
						local target_n = cc.p(effectLayer:convertToNodeSpace(target_w))
						local fixLength = -80
						local offsetY = fixLength * math.sin(math.angle2radian(raido))
						local offsetX = fixLength * math.cos(math.angle2radian(raido))

						hitAciton:setPosition(cc.p(org_n.x + offsetX, org_n.y + offsetY))

						local fixLength = -220 * target:getScale()
						local offsetY = fixLength * math.sin(math.angle2radian(raido))
						local offsetX = fixLength * math.cos(math.angle2radian(raido))
						local moveTo5 = cc.MoveTo:create(0.16666666666666666 * factor, cc.p(target_n.x - offsetX, target_n.y - offsetY))

						hitAciton:runAction(moveTo5)
						hitAciton:play()
						hitAciton:addEndCallback(function()
							hitAciton:removeFromParent()
						end)
						hitAciton:addCallbackAtFrame(5, function()
							local anim = cc.MovieClip:create("beiji_shijiebosszhd")

							anim:addTo(effectLayer)
							anim:setRotation(-raido)
							anim:addEndCallback(function()
								anim:removeFromParent()
							end)

							local fixLength = -230 * target:getScale()
							local offsetY = fixLength * math.sin(math.angle2radian(raido))
							local offsetX = fixLength * math.cos(math.angle2radian(raido))

							anim:setPosition(cc.p(target_n.x - offsetX, target_n.y - offsetY))
						end)
						hitAciton:addCallbackAtFrame(1, function()
							if callback and callback.hitCall then
								callback.hitCall(cc.p(target_n.x - offsetX, target_n.y - offsetY))
							end
						end)
					end)
					local action1 = cc.Sequence:create(scaleTo1, scaleTo2, scaleTo3, (animNode or nil) and cc.CallFunc:create(function()
						return
					end), scaleTo4, scaleTo5)
					local moveTo0 = cc.MoveBy:create(0.16666666666666666 * factor, cc.p(0, 0))
					local moveTo1 = cc.MoveBy:create(0.033333333333333354 * factor, cc.p(-8, 0))
					local moveTo2 = cc.MoveBy:create(0.06666666666666665 * factor, cc.p(8, 0))
					local moveTo3 = cc.MoveBy:create(0.033333333333333326 * factor, cc.p(0, -5))
					local moveTo4 = cc.MoveBy:create(0.033333333333333326 * factor, cc.p(0, 5))
					local moveTo5 = cc.MoveBy:create(0.033333333333333326 * factor, cc.p(-3, 0))
					local moveTo6 = cc.MoveBy:create(0.03333333333333338 * factor, cc.p(3, 0))
					local action2 = cc.Sequence:create(moveTo1, moveTo2, moveTo3, moveTo4, moveTo5, moveTo6)
					local action = cc.Spawn:create(action1, action2)
					local action = cc.Sequence:create(action, cc.CallFunc:create(function()
						if callback and callback.endCall then
							callback.endCall()
						end
					end))

					if animNode then
						if not tolua.isnull(animNode) then
							animNode:runAction(action)
						end
					else
						if not tolua.isnull(xuliAciton) then
							local xuliAciton = cc.MovieClip:create(cfg.xuliflash)

							xuliAciton:addTo(underLayer)
							xuliAciton:setScale(actor:getScale() * k_XULI_EFFECT_SCALE)

							local org_n = cc.p(underLayer:convertToNodeSpace(org_w))

							xuliAciton:setPosition(cc.p(org_n.x, org_n.y))
							xuliAciton:addEndCallback(function()
								xuliAciton:removeFromParent()
							end)
							xuliAciton:runAction(action)
						end

						actor:runAction(action)
					end
				end
			}
		},
		BSNCT = {
			idle = {
				effect = "",
				action = function(cfg, actor, factor, animNode)
					if animNode then
						animNode:runAction(create_common_idle(cfg, actor, factor))
					else
						actor:getDisplayNode():runAction(create_common_idle(cfg, actor, factor))
					end
				end
			},
			attack = {
				flash = "06jian_qiuqiuzhandou",
				xuliflash = "06xuli_qiuqiuzhandou",
				action = function(cfg, actor, target, factor, callback, animNode)
					if not actor:getDisplayNode():isVisible() then
						if callback and callback.endCall then
							local delay = cc.DelayTime:create(3)
							local action = cc.Sequence:create(delay, cc.CallFunc:create(function()
								callback.endCall(action)
							end))

							actor:resetTrans()
							actor:getDisplayNode():runAction(action)
						end

						return
					end

					local raido = actor._Radio
					local atkEffectProp = actor:getAtkEffectProp()
					local effectLayer = actor:getEffectLayer()
					local underLayer = actor:getUnderLayer()
					local org_w = actor:getDisplayNode():getParent():convertToWorldSpace(cc.p(actor:getDisplayNode():getPosition()))
					local target_w = target:getDisplayNode():getParent():convertToWorldSpace(cc.p(target:getDisplayNode():getPosition()))
					local target_n = cc.p(actor:getDisplayNode():getParent():convertToNodeSpace(target_w))
					local pos = cc.p(actor:getPosition())
					local scale = actor:getScale()
					local actor = actor:getDisplayNode()
					local scaleTo1 = cc.ScaleTo:create(0.03333333333333333 * factor, scale * 1)
					local scaleTo2 = cc.ScaleTo:create(0.13333333333333333 * factor, scale * 1.27)
					local scaleTo3 = cc.ScaleTo:create(0.30000000000000004 * factor, scale * 1.42)
					local scaleTo4 = cc.ScaleTo:create(0.1333333333333333 * factor, scale * 0.9)
					local scaleTo5 = cc.ScaleTo:create(0.4 * factor, scale * 1)
					local hitAnim = cc.CallFunc:create(function()
						if tolua.isnull(actor) then
							return
						end

						if not effectLayer:isVisible() then
							return
						end

						if not actor:isVisible() then
							return
						end

						local prop = math.random(0, 10) / 10

						if prop > atkEffectProp then
							return
						end

						local hitAciton = cc.MovieClip:create(cfg.flash)

						hitAciton:addTo(effectLayer)
						hitAciton:setRotation(180 - raido)
						hitAciton:setScale(actor:getScale() * k_EFFECT_SCALE)

						local org_w = actor:getParent():convertToWorldSpace(cc.p(actor:getPosition()))
						local org_n = cc.p(effectLayer:convertToNodeSpace(org_w))
						local target_n = cc.p(effectLayer:convertToNodeSpace(target_w))
						local fixLength = -250
						local offsetY = fixLength * math.sin(math.angle2radian(raido))
						local offsetX = fixLength * math.cos(math.angle2radian(raido))

						hitAciton:setPosition(cc.p(org_n.x + offsetX, org_n.y + offsetY))

						local fixLength = -180 * target:getScale()
						local offsetY = fixLength * math.sin(math.angle2radian(raido))
						local offsetX = fixLength * math.cos(math.angle2radian(raido))
						local moveTo5 = cc.MoveTo:create(0.16666666666666666 * factor, cc.p(target_n.x - offsetX, target_n.y - offsetY))

						hitAciton:runAction(moveTo5)
						hitAciton:play()
						hitAciton:addEndCallback(function()
							hitAciton:removeFromParent()
						end)
						hitAciton:addCallbackAtFrame(1, function()
							if callback and callback.hitCall then
								callback.hitCall(cc.p(target_n.x - offsetX, target_n.y - offsetY))
							end

							local anim = cc.MovieClip:create("beiji_shijiebosszhd")

							anim:addTo(effectLayer)
							anim:setRotation(-raido)
							anim:addEndCallback(function()
								anim:removeFromParent()
							end)

							local fixLength = -230 * target:getScale()
							local offsetY = fixLength * math.sin(math.angle2radian(raido))
							local offsetX = fixLength * math.cos(math.angle2radian(raido))

							anim:setPosition(cc.p(target_n.x - offsetX, target_n.y - offsetY))
						end)
					end)
					local action1 = cc.Sequence:create(scaleTo1, scaleTo2, scaleTo3, (animNode or nil) and cc.CallFunc:create(function()
						return
					end), scaleTo4, scaleTo5)
					local moveTo0 = cc.MoveBy:create(0.16666666666666666 * factor, cc.p(0, 0))
					local moveTo1 = cc.MoveBy:create(0.033333333333333354 * factor, cc.p(-8, 0))
					local moveTo2 = cc.MoveBy:create(0.06666666666666665 * factor, cc.p(8, 0))
					local moveTo3 = cc.MoveBy:create(0.033333333333333326 * factor, cc.p(0, -5))
					local moveTo4 = cc.MoveBy:create(0.033333333333333326 * factor, cc.p(0, 5))
					local moveTo5 = cc.MoveBy:create(0.033333333333333326 * factor, cc.p(-3, 0))
					local moveTo6 = cc.MoveBy:create(0.03333333333333338 * factor, cc.p(3, 0))
					local action2 = cc.Sequence:create(moveTo1, moveTo2, moveTo3, moveTo4, moveTo5, moveTo6)
					local action = cc.Spawn:create(action1, action2)
					local action = cc.Sequence:create(action, cc.CallFunc:create(function()
						if callback and callback.endCall then
							callback.endCall()
						end
					end))

					if animNode then
						if not tolua.isnull(animNode) then
							animNode:runAction(action)
						end
					else
						if not tolua.isnull(xuliAciton) then
							local xuliAciton = cc.MovieClip:create(cfg.xuliflash)

							xuliAciton:addTo(underLayer)
							xuliAciton:setScale(actor:getScale() * k_XULI_EFFECT_SCALE)

							local org_n = cc.p(underLayer:convertToNodeSpace(org_w))

							xuliAciton:setPosition(cc.p(org_n.x, org_n.y))
							xuliAciton:addEndCallback(function()
								xuliAciton:removeFromParent()
							end)
							xuliAciton:runAction(action)
						end

						actor:runAction(action)
					end
				end
			}
		},
		SSZS = {
			idle = {
				effect = "",
				action = function(cfg, actor, factor, animNode)
					if animNode then
						animNode:runAction(create_common_idle(cfg, actor, factor))
					else
						actor:getDisplayNode():runAction(create_common_idle(cfg, actor, factor))
					end
				end
			},
			attack = {
				flash = "mofa_qiuqiuzhandou",
				hitflash = "04beiji_qiuqiuzhandou",
				xuliflash = "04xiuli_qiuqiuzhandou",
				action = function(cfg, actor, target, factor, callback, animNode)
					if not actor:getDisplayNode():isVisible() then
						if callback and callback.endCall then
							local delay = cc.DelayTime:create(3)
							local action = cc.Sequence:create(delay, cc.CallFunc:create(function()
								callback.endCall(action)
							end))

							actor:resetTrans()
							actor:getDisplayNode():runAction(action)
						end

						return
					end

					local raido = actor._Radio
					local atkEffectProp = actor:getAtkEffectProp()
					local effectLayer = actor:getEffectLayer()
					local underLayer = actor:getUnderLayer()
					local org_w = actor:getDisplayNode():getParent():convertToWorldSpace(cc.p(actor:getDisplayNode():getPosition()))
					local target_w = target:getDisplayNode():getParent():convertToWorldSpace(cc.p(target:getDisplayNode():getPosition()))
					local target_n = cc.p(actor:getDisplayNode():getParent():convertToNodeSpace(target_w))
					local pos = cc.p(actor:getPosition())
					local scale = actor:getScale()
					local actor = actor:getDisplayNode()
					local scaleTo1 = cc.ScaleTo:create(0.03333333333333333 * factor, scale * 1)
					local scaleTo2 = cc.ScaleTo:create(0.13333333333333333 * factor, scale * 1.27)
					local scaleTo3 = cc.ScaleTo:create(0.30000000000000004 * factor, scale * 1.42)
					local scaleTo4 = cc.ScaleTo:create(0.1333333333333333 * factor, scale * 0.9)
					local scaleTo5 = cc.ScaleTo:create(0.4 * factor, scale * 1)
					local hitAnim = cc.CallFunc:create(function()
						if tolua.isnull(actor) then
							return
						end

						if not effectLayer:isVisible() then
							return
						end

						if not actor:isVisible() then
							return
						end

						local prop = math.random(0, 10) / 10

						if prop > atkEffectProp then
							return
						end

						local hitAciton = cc.MovieClip:create(cfg.flash)

						hitAciton:addTo(effectLayer)
						hitAciton:setRotation(180 - raido)
						hitAciton:setScale(actor:getScale() * k_EFFECT_SCALE)

						local org_w = actor:getParent():convertToWorldSpace(cc.p(actor:getPosition()))
						local org_n = cc.p(effectLayer:convertToNodeSpace(org_w))
						local target_n = cc.p(effectLayer:convertToNodeSpace(target_w))
						local fixLength = 0
						local offsetY = fixLength * math.sin(math.angle2radian(raido))
						local offsetX = fixLength * math.cos(math.angle2radian(raido))

						hitAciton:setPosition(cc.p(org_n.x + offsetX, org_n.y + offsetY))

						local fixLength = -200 * target:getScale()
						local offsetY = fixLength * math.sin(math.angle2radian(raido))
						local offsetX = fixLength * math.cos(math.angle2radian(raido))
						local moveTo5 = cc.MoveTo:create(0.16666666666666666 * factor, cc.p(target_n.x - offsetX, target_n.y - offsetY))

						hitAciton:runAction(moveTo5)
						hitAciton:play()
						hitAciton:addEndCallback(function()
							hitAciton:removeFromParent()
						end)
						hitAciton:addCallbackAtFrame(5, function()
							if callback and callback.hitCall then
								callback.hitCall(cc.p(target_n.x - offsetX, target_n.y - offsetY))
							end

							local anim = cc.MovieClip:create("beiji_shijiebosszhd")

							anim:addTo(effectLayer)
							anim:setRotation(-raido)
							anim:addEndCallback(function()
								anim:removeFromParent()
							end)

							local fixLength = -230 * target:getScale()
							local offsetY = fixLength * math.sin(math.angle2radian(raido))
							local offsetX = fixLength * math.cos(math.angle2radian(raido))

							anim:setPosition(cc.p(target_n.x - offsetX, target_n.y - offsetY))
						end)
					end)
					local action1 = cc.Sequence:create(scaleTo1, scaleTo2, scaleTo3, (animNode or nil) and cc.CallFunc:create(function()
						return
					end), scaleTo4, scaleTo5)
					local moveTo0 = cc.MoveBy:create(0.16666666666666666 * factor, cc.p(0, 0))
					local moveTo1 = cc.MoveBy:create(0.033333333333333354 * factor, cc.p(-8, 0))
					local moveTo2 = cc.MoveBy:create(0.06666666666666665 * factor, cc.p(8, 0))
					local moveTo3 = cc.MoveBy:create(0.033333333333333326 * factor, cc.p(0, -5))
					local moveTo4 = cc.MoveBy:create(0.033333333333333326 * factor, cc.p(0, 5))
					local moveTo5 = cc.MoveBy:create(0.033333333333333326 * factor, cc.p(-3, 0))
					local moveTo6 = cc.MoveBy:create(0.03333333333333338 * factor, cc.p(3, 0))
					local action2 = cc.Sequence:create(moveTo1, moveTo2, moveTo3, moveTo4, moveTo5, moveTo6)
					local action = cc.Spawn:create(action1, action2)
					local action = cc.Sequence:create(action, cc.CallFunc:create(function()
						if callback and callback.endCall then
							callback.endCall()
						end
					end))

					if animNode then
						if not tolua.isnull(animNode) then
							animNode:runAction(action)
						end
					else
						if not tolua.isnull(xuliAciton) then
							local xuliAciton = cc.MovieClip:create(cfg.xuliflash)

							xuliAciton:addTo(underLayer)
							xuliAciton:setScale(actor:getScale() * k_XULI_EFFECT_SCALE)

							local org_n = cc.p(underLayer:convertToNodeSpace(org_w))

							xuliAciton:setPosition(cc.p(org_n.x, org_n.y))
							xuliAciton:addEndCallback(function()
								xuliAciton:removeFromParent()
							end)
							xuliAciton:runAction(action)
						end

						actor:runAction(action)
					end
				end
			}
		}
	}

	return actions[type]
end

function WorldPeaceActionFactory.class:idle01(actor, factor)
	local pos = cc.p(actor:getPosition())
	local scale = actor:getScale()

	return (cc.RepeatForever:create(cc.Sequence:create(cc.ScaleTo:create(0.1 * factor, scale * 0.9), cc.ScaleTo:create(0.1 * factor, scale * 1))))
end

function WorldPeaceActionFactory.class:attakAction01(actor, factor, targetPos, hitCall)
	local pos = cc.p(actor:getPosition())
	local scale = actor:getScale()
	local scaleTo = cc.ScaleTo:create(0.2 * factor, scale * 1.2)
	local moveTo = cc.MoveTo:create(0.2 * factor, targetPos)
	local goahead = cc.Sequence:create(scaleTo, moveTo)
	local scaleTo = cc.ScaleTo:create(0.2 * factor, scale)
	local moveTo = cc.MoveTo:create(0.2 * factor, pos)
	local goaback = cc.Spawn:create(scaleTo, moveTo)

	return cc.Sequence:create(goahead, cc.CallFunc:create(hitCall), goaback)
end

function WorldPeaceActionFactory.class:attakAction02(actor, factor, targetPos, hitCall)
	local pos = cc.p(actor:getPosition())
	local scale = actor:getScale()
	local scaleTo = cc.ScaleTo:create(0.2 * factor, scale * 1.2)
	local moveTo = cc.MoveTo:create(0.2 * factor, targetPos)
	local goahead = cc.Sequence:create(scaleTo, moveTo)
	local scaleTo = cc.ScaleTo:create(0.2 * factor, scale)
	local moveTo = cc.MoveTo:create(0.2 * factor, pos)
	local goaback = cc.Spawn:create(scaleTo, moveTo)

	return cc.Sequence:create(goahead, cc.CallFunc:create(hitCall), goaback)
end

return WorldPeaceActionFactory
