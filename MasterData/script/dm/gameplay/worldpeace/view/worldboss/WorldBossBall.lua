-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/worldboss/WorldBossBall.lua

WorldBossBall = class("WorldBossBall", WorldPeaceBall)

function WorldBossBall:initialize(id, type, data, factory)
	super.initialize(self, id, type, data, factory)

	if data:getIsMyth() then
		local anim = cc.MovieClip:create("guangmang_shijiebosszhd")

		anim:addTo(self._content)
		anim:setLocalZOrder(100000)
	else
		local anim = cc.MovieClip:create("eff_xia_ruchang")

		anim:addTo(self._content):offset(0, -45)
		anim:setLocalZOrder(100000)
		anim:setScale(1.5)
		anim:addEndCallback(function()
			anim:stop()
			anim:removeFromParent()
		end)
	end
end

function WorldBossBall:setSp(sp)
	if self._sp == sp then
		return
	end

	self._sp = sp
end

function WorldBossBall:setSpCount(spCount)
	if self._spCount == spCount then
		return
	end

	if self._spEffect then
		self._spEffect:removeFromParent()

		self._spEffect = nil
	end

	if spCount == 2 and self._data:getIsMyth() then
		self._spEffect = cc.MovieClip:create("speed2_qiuqiuzhandou")

		self._spEffect:addTo(self:getDisplayNode())
	end

	if spCount == 3 and self._data:getIsMyth() then
		self._spEffect = cc.MovieClip:create("speed3_qiuqiuzhandou")

		self._spEffect:addTo(self:getDisplayNode())
	end

	self._spCount = spCount
end

function WorldBossBall:onIdle()
	if not self:isVisible() or not self._enemy:isVisible() then
		self:setState(K_WORLD_MEMBER_SATGE.Idle)

		return
	end

	if self._attackSchedule then
		cancelDelayCall(self._attackSchedule)

		self._attackSchedule = nil
	end

	if self._isDef then
		self:setState(K_WORLD_MEMBER_SATGE.Protect)
	else
		local idleCfg = WorldPeaceActionFactory:getActionDefine(self._unityType).idle

		if idleCfg.action then
			if tolua.isnull(self:getDisplayNode()) then
				return
			end

			self:getDisplayNode():stopAllActions()
			self:resetTrans()
			idleCfg:action(self, 1 / self._sp)

			self._collTime = self._collTime or 0
			self._attackSchedule = delayCallByTime(2000 / self._sp, function()
				self:setState(K_WORLD_MEMBER_SATGE.Attack)
			end)

			for k, v in pairs(self:getAssigedNodes()) do
				v.node:stopAllActions()
				idleCfg:action(self, 1 / self._sp, v.node)
			end
		end

		self:setState(K_WORLD_MEMBER_SATGE.Idleing)
	end
end

function WorldBossBall:onAttack()
	if not self._enemy:isVisible() or not self:isVisible() then
		self:setState(K_WORLD_MEMBER_SATGE.Idle)

		return
	end

	local attackCfg = WorldPeaceActionFactory:getWorldBossActionDefine(self._unityType).attack

	if attackCfg.action then
		self:getDisplayNode():stopAllActions()

		if tolua.isnull(self:getDisplayNode()) then
			return
		end

		attackCfg:action(self, self._enemy, 1 / self._sp, {
			hitCall = function(wpos)
				if DisposableObject:isDisposed(self) then
					return
				end

				self._enemy:onHit({
					hp = 10,
					unitType = self._unityType,
					actor = self,
					hitflash = attackCfg.hitflash,
					pos = wpos
				})

				if tolua.isnull(self:getDisplayNode()) then
					return
				end

				local effectLayer = self:getEffectLayer()

				if self._isMyth and K_RENDER_DISPLAYMODE.WORLDBOSS ~= self._playMode then
					local reflect = self._enemy:getAtk()
					local pos = cc.p(self:getDisplayNode():getPosition())
					local wpos = cc.p(self:getDisplayNode():getParent():convertToWorldSpace(pos))
					local label = self:createFlyLabel(cc.p(wpos.x + 70, wpos.y + 70), reflect - self:getDef())

					label:addTo(effectLayer)
					label:setScale(self:getScale())

					self._attCount = self._attCount or self._attCount + 1
				end

				self:updateHp()
			end,
			endCall = function()
				self:setState(K_WORLD_MEMBER_SATGE.Idle)
			end
		})

		for k, v in pairs(self:getAssigedNodes()) do
			v.node:stopAllActions()
			attackCfg:action(self, self._enemy, 1 / self._sp, nil, v.node)
		end
	end

	self:setState(K_WORLD_MEMBER_SATGE.Attacking)
end
