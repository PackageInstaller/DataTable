-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WordPeaceGame.lua

WordPeaceGame = class("WordPeaceGame", objectlua.Object)

WordPeaceGame:has("_actionFactory", {
	is = "rw"
})
WordPeaceGame:has("_memberFactory", {
	is = "rw"
})
WordPeaceGame:has("_displayStage", {
	is = "rw"
})
WordPeaceGame:has("_displayMode", {
	is = "rw"
})
WordPeaceGame:has("_labelCaptain", {
	is = "rw"
})
WordPeaceGame:has("_handLogic", {
	is = "rw"
})
WordPeaceGame:has("_protectRadio", {
	is = "rw"
})

function WordPeaceGame:initialize(creaters)
	self._actionFactory = WorldPeaceActionFactory:new(self)
	self._memberFactory = WorldPeaceMemberFactory:new(self, creaters)
	self._creatememberQueue = {}
	self._addToQueueCommond = {}
	self._labelCaptain = 10
	self._bollCaptain = 100
	self._protectLabelCaptain = 10
	self._protectRadio = 0
	self._tickTime = 0
	self._syncCreate = coroutine.create(function()
		repeat
			local costtime = os.clock()

			for k, v in pairs(self._creatememberQueue) do
				local args = v
				local boss = args.boss
				local scale = args.scale
				local isDef = args.isDef
				local bolldata = args.bolldata
				local isShadow = args.isShadow
				local clearFunc = args.clearFunc
				local isMyth = bolldata:getIsMyth()
				local trueKey = args.trueKey
				local fixPos = args.posInfo
				local isAtk = args.isAtk

				if k_IGNOR_VIEWPORT_LOAD or boss:isVisible() then
					local boll_key = bolldata:getTeamKey()

					if isShadow then
						boll_key = trueKey
					end

					local boll = self._memberFactory:getMemberById(boll_key)

					if boll then
						boll:updateInfo(bolldata)
					else
						boll = self:createBoll(bolldata, boll_key)

						local posInfo

						if isDef then
							posInfo = self._memberFactory:randomDefAroudBossPos(boss)
						elseif isMyth then
							posInfo = self._memberFactory:randomMthBossPos(boss, bolldata:getTeamKey(), boll)
						elseif isShadow then
							posInfo = fixPos and fixPos or self._memberFactory:randomAroudBossPos(boss, boll_key)

							boll:getDisplayNode():setLocalZOrder(-1)
						else
							posInfo = self._memberFactory:randomAroudBossPos(boss, boll_key)
						end

						boll:setDistance(posInfo.distance)
						boll:setPosition(posInfo.pos)
						boll:setRadio(posInfo.radio)
						boll:setEnemy(boss)
						boss:addEnemy(boll)

						if bolldata:getScaleOffset() and self._displayMode ~= K_RENDER_DISPLAYMODE.MULTILEVEL then
							boll:setScale(scale + bolldata:getScaleOffset())
						else
							boll:setScale(scale)
						end

						boll:setTransformDirty(true)

						if isDef then
							boss:addProtect(boll)
						end

						if isShadow then
							boll:setState(K_WORLD_MEMBER_SATGE.Died, function()
								clearFunc()
							end)
						end

						if isDef then
							boll:getDisplayNode():setLocalZOrder(1000 - bolldata:getOrder() + boss:getOrderFactor())
						end

						if isAtk then
							boll:getDisplayNode():setLocalZOrder(isMyth and 1000 + boss:getOrderFactor() or boss:getOrderFactor())
						end
					end

					if k >= #self._creatememberQueue then
						-- block empty
					end

					table.remove(self._creatememberQueue, k)
				end

				if os.clock() - costtime > 0.03333333333333333 then
					costtime = os.clock()

					coroutine.yield("unfinish")
				end
			end

			coroutine.yield("finish")
		until false
	end)
end

function WordPeaceGame:getProtectLabelCaptain()
	return self._protectLabelCaptain
end

function WordPeaceGame:isLabelShowCnt(bossId)
	self._labelCaptainGroup = self._labelCaptainGroup or {}
	self._labelCaptainGroup[bossId] = self._labelCaptainGroup[bossId] or self._labelCaptain
	self._labelCaptainGroup[bossId] = self._labelCaptainGroup[bossId] - 1

	return self._labelCaptainGroup[bossId] >= 0
end

function WordPeaceGame:isBollShowCnt(bossId)
	self._bollCaptainGroup = self._bollCaptainGroup or {}
	self._bollCaptainGroup[bossId] = self._bollCaptainGroup[bossId] or self._bollCaptain
	self._bollCaptainGroup[bossId] = self._bollCaptainGroup[bossId] - 1

	return self._bollCaptainGroup[bossId] >= 0
end

function WordPeaceGame:pause()
	self._pause = true
end

function WordPeaceGame:resume()
	self._pause = false
end

function WordPeaceGame:step(dt)
	if not self._pause then
		local gameMode = self:getDisplayMode()

		if gameMode == K_RENDER_DISPLAYMODE.MULTILEVEL then
			self._tickTime = self._tickTime + dt

			if self._memberFactory and self._tickTime > 0.2 then
				self._memberFactory:step(self._tickTime)

				self._tickTime = 0
			end
		elseif self._memberFactory then
			self._memberFactory:step(dt)
		end

		self:addToSyncQuequeStep()
		coroutine.resume(self._syncCreate)
	end
end

function WordPeaceGame:addToSyncQuequeStep()
	if #self._addToQueueCommond > 0 then
		table.sort(self._addToQueueCommond, function(a, b)
			return a.loadOrder > b.loadOrder
		end)

		for i = 1, 1000 do
			v = table.remove(self._addToQueueCommond, 1)

			if v then
				self._creatememberQueue[#self._creatememberQueue + 1] = v
			end
		end
	end
end

function WordPeaceGame:setDisplayStage(stage)
	self._displayStage = stage:getChildByFullName("map"):getInnerContainer()

	self._memberFactory:setDisplayStage(stage)
end

function WordPeaceGame:getLayer(layerName)
	return self:getDisplayStage():getChildByName(layerName)
end

function WordPeaceGame:createBoss(bossData, pos)
	local boss = self._memberFactory:createMemberById(bossData:getId(), K_WORLD_MEMBER_TYPE.Boss, bossData)

	boss:setPosition(pos)

	if not boss:getDisplayNode():getPositionY() then
		self:getLayer("BossLayer"):addChild(boss:getDisplayNode())
		boss:setState(K_WORLD_MEMBER_SATGE.Prepare)

		return boss
	end
end

function WordPeaceGame:createBoll(bolldata, key)
	local boll = self._memberFactory:createMemberById(key or bolldata:getTeamKey(), K_WORLD_MEMBER_TYPE.Member, bolldata)

	self:getLayer("BollLayer"):addChild(boll:getDisplayNode())
	boll:setState(K_WORLD_MEMBER_SATGE.Prepare)

	return boll
end

function WordPeaceGame:addBollForBossRightNow(args)
	local boss = args.boss
	local bolldata = args.bolldata
	local isMyth = bolldata:getIsMyth()

	if boss then
		local boll = self._memberFactory:getMemberById(bolldata:getTeamKey())

		if boll then
			boll:updateInfo(bolldata)
		else
			local boll = self._memberFactory:createMemberById(bolldata:getTeamKey(), K_WORLD_MEMBER_TYPE.Member, bolldata)

			self._memberFactory:getMembersPool()[bolldata:getTeamKey()] = boll

			local targetLayer = self._displayStage:getParent():getParent()
			local wordPos = self._handLogic:getHandCardPos()[bolldata:getTeamKey()]
			local nPos = targetLayer:convertToNodeSpace(wordPos)
			local wordTarPos = boss:getDisplayNode():getParent():convertToWorldSpace(cc.p(boss:getDisplayNode():getPosition()))
			local nPosTar = targetLayer:convertToNodeSpace(wordTarPos)
			local radio = math.abs(nPos.y - nPosTar.y) / math.abs(nPos.x - nPosTar.x)
			local radio = math.atan(radio) * 180 / math.pi

			radio = radio * (nPos.x - nPosTar.x > 0 and -1 or 1)
			radio = radio + (nPos.x - nPosTar.x > 0 and 0 or 180)

			targetLayer:addChild(boll:getDisplayNode())
			boll:getDisplayNode():setLocalZOrder(100)
			boll:setPosition(nPos)
			boll:setRadio(radio)
			boll:setEnemy(boss)
			boss:addEnemy(boll)
			boll:setScale(0.8)
			boll:setTransformDirty(true)
		end
	end
end

function WordPeaceGame:addBollForBoss(bossId, bollData, scale, isAtk)
	local boss = self._memberFactory:getMemberById(bossId)
	local scale = scale or 1
	local pos = boss:getPosition()

	if boss then
		self._addToQueueCommond[#self._addToQueueCommond + 1] = isAtk and {
			isAtk = true,
			loadOrder = 100000,
			boss = boss,
			scale = scale,
			bolldata = bollData
		} or {
			loadOrder = 100000,
			isDef = true,
			boss = boss,
			scale = scale,
			bolldata = bollData
		}
	end
end

function WordPeaceGame:addBollForClubBossStageTwo(bossId, bollData, scale, isAtk)
	local boss = self._memberFactory:getMemberById(bossId)
	local scale = scale or 1

	if boss then
		self._addToQueueCommond[#self._addToQueueCommond + 1] = isAtk and {
			isAtk = true,
			loadOrder = 100000,
			boss = boss,
			scale = scale,
			bolldata = bollData
		} or {
			loadOrder = 100000,
			isDef = true,
			boss = boss,
			scale = scale,
			bolldata = bollData
		}
	end

	for k, v in pairs(self._addToQueueCommond) do
		self:addStageTwoBoll(v)

		if k == #self._addToQueueCommond then
			self:getMemberFactory():markMemeberTransFormDirty()
		end

		table.remove(self._creatememberQueue, k)
	end
end

function WordPeaceGame:addStageTwoBoll(args)
	local boss = args.boss
	local scale = args.scale
	local isDef = args.isDef
	local bolldata = args.bolldata
	local posInfo = bolldata:getPosInfo()
	local boll = self:createBoll(bolldata)

	if not posInfo then
		if isDef then
			posInfo = self._memberFactory:randomDefAroudBossPos(boss)

			boss:addProtect(boll)
		else
			posInfo = self._memberFactory:randomAroudBossPos(boss)
		end
	end

	boll:setDistance(posInfo.distance)
	boll:setPosition(posInfo.pos)
	boll:setRadio(posInfo.radio)
	boll:setEnemy(boss)
	boss:addEnemy(boll)
	boll:setScale(scale)
end

function WordPeaceGame:addStageOneBoll(args)
	local boss = args.boss
	local scale = args.scale
	local isDef = args.isDef
	local bolldata = args.bolldata
	local posInfo = bolldata:getPosInfo()
	local boll = self:createBoll(bolldata)

	if not posInfo then
		if isDef then
			posInfo = self._memberFactory:randomDefAroudBossPos(boss)

			boss:addProtect(boll)
		else
			posInfo = self._memberFactory:randomMthClubBossPos(boss, boll:getData():getTeamKey(), boll)
		end
	end

	if posInfo then
		boll:setDistance(posInfo.distance)
		boll:setPosition(posInfo.pos)
		boll:setRadio(posInfo.radio)
		boll:setEnemy(boss)
		boss:addEnemy(boll)
		boll:setScale(scale)
	end
end

function WordPeaceGame:addBollForClubBossStageOne(bossId, bollData, scale, isAtk)
	local boss = self._memberFactory:getMemberById(bossId)
	local scale = scale or 1
	local pos = boss:getPosition()

	if boss then
		self._addToQueueCommond[#self._addToQueueCommond + 1] = isAtk and {
			isAtk = true,
			loadOrder = 100000,
			boss = boss,
			scale = scale,
			bolldata = bollData
		} or {
			loadOrder = 100000,
			isDef = true,
			boss = boss,
			scale = scale,
			bolldata = bollData
		}
	end

	for k, v in pairs(self._addToQueueCommond) do
		self:addStageOneBoll(v)

		if k == #self._creatememberQueue then
			self:getMemberFactory():markMemeberTransFormDirty()
		end

		table.remove(self._creatememberQueue, k)
	end
end

function WordPeaceGame:createBattleFieldByBoss(bossdata, pos, scaleInfo)
	local scale = scaleInfo or {
		1,
		1
	}
	local bossIns = self._memberFactory:getMemberById(bossdata:getId())

	if bossIns then
		bossIns:updateInfo(bossdata)
	else
		bossIns = self:createBoss(bossdata, pos)
	end

	bossIns:setScale(scale[1])

	local index = 0

	for k, v in pairs(bossdata:getDTeams()) do
		local boll = self._memberFactory:getMemberById(v:getTeamKey())

		if boll then
			if boll:getData():getIsProtect() == false then
				local posInfo = self._memberFactory:randomDefAroudBossPos(bossIns)

				boll:stopActions()
				boll:setState(K_WORLD_MEMBER_SATGE.Idle)
				boll:setPosition(posInfo.pos)
				boll:setRadio(posInfo.radio)
				boll:setEnemy(bossIns)
				bossIns:addEnemy(boll)
				boll:setScale(boll:getScale())
				boll:setOrder(1)
				bossIns:addProtect(boll)
			end

			boll:updateInfo(v)
		else
			self._addToQueueCommond[#self._addToQueueCommond + 1] = {
				isDef = true,
				boss = bossIns,
				scale = scale[2],
				bolldata = v,
				loadOrder = 1000 - v:getOrder()
			}
			index = index + 1
		end
	end

	for k, v in pairs(bossdata:getATeams()) do
		local boll = self._memberFactory:getMemberById(v:getTeamKey())

		if boll then
			boll:updateInfo(v)
		else
			local fixPos = self._displayMode == K_RENDER_DISPLAYMODE.ALL or self._displayMode == K_RENDER_DISPLAYMODE.WORLDBOSS

			if fixPos and v:getIsMyth() then
				self:addBollForBossRightNow({
					isAtk = true,
					loadOrder = 10000,
					boss = bossIns,
					scale = scale[2],
					bolldata = v
				})
			else
				self._addToQueueCommond[#self._addToQueueCommond + 1] = {
					isAtk = true,
					loadOrder = 0,
					boss = bossIns,
					scale = scale[2],
					bolldata = v
				}
			end
		end
	end

	return bossIns
end

function WordPeaceGame:clearBattleField()
	for k, v in pairs(self._memberFactory:getMembersPool()) do
		self._memberFactory:destoryMemberById(k)
	end
end

function WordPeaceGame:createBattleFieldByClubBossTwo(bossdata, pos, scaleInfo)
	self._addToQueueCommond = {}

	local scale = scaleInfo or {
		1,
		1
	}
	local bossIns = self._memberFactory:getMemberById(bossdata:getId())

	if bossIns then
		bossIns:updateInfo(bossdata)
	else
		bossIns = self:createBoss(bossdata, pos)
	end

	bossIns:setScale(scale[1])

	for k, v in pairs(bossdata:getATeams()) do
		local boll = self._memberFactory:getMemberById(v:getTeamKey())

		if boll then
			boll:updateInfo(v)
			boll:setState(K_WORLD_MEMBER_SATGE.Idle)
		else
			self._addToQueueCommond[#self._addToQueueCommond + 1] = {
				isAtk = true,
				loadOrder = 0,
				boss = bossIns,
				scale = scale[2],
				bolldata = v
			}
		end
	end

	return bossIns
end

function WordPeaceGame:createBattleFieldByClubBoss(bossdata, pos, scaleInfo)
	self._addToQueueCommond = {}

	local scale = scaleInfo or {
		1,
		1
	}
	local bossIns = self._memberFactory:getMemberById(bossdata:getId())

	if bossIns then
		bossIns:updateInfo(bossdata)
	else
		bossIns = self:createBoss(bossdata, pos)
	end

	bossIns:setScale(scale[1])

	for k, v in pairs(bossdata:getATeams()) do
		if v._curHp == 0 and v._isMyth ~= true then
			self:getMemberFactory():destoryMemberById(k)
		end
	end

	for k, v in pairs(bossdata:getATeams()) do
		local boll = self._memberFactory:getMemberById(v:getTeamKey())

		if boll then
			boll:updateInfo(v)

			if boll:getState() == K_WORLD_MEMBER_SATGE.Idle then
				boll:setState(K_WORLD_MEMBER_SATGE.Idle)
			end
		elseif v._curHp > 0 then
			self._addToQueueCommond[#self._addToQueueCommond + 1] = {
				isAtk = true,
				loadOrder = 0,
				boss = bossIns,
				scale = scale[2],
				bolldata = v
			}
		end
	end

	return bossIns
end

function WordPeaceGame:createBattleShadows(dieQueques, targetbossId)
	for k, v in pairs(dieQueques or {}) do
		local bossId = v.bossId

		if targetbossId and bossId == targetbossId or not targetbossId then
			local bolldata = v.bolldata
			local bossIns = self._memberFactory:getMemberById(bossId)
			local boll = self._memberFactory:getMemberById(k)
			local oldBoll = self._memberFactory:getMemberById(bolldata:getTeamKey())

			if not boll then
				local posInfo

				self._addToQueueCommond[#self._addToQueueCommond + 1] = {
					isShadow = true,
					loadOrder = 0,
					boss = bossIns,
					scale = targetbossId and 0.7 or 0.3,
					bolldata = bolldata,
					trueKey = k,
					posInfo = (oldBoll or nil) and {
						distance = oldBoll:getDistance(),
						pos = oldBoll:getPosition(),
						radio = oldBoll:getRadio()
					},
					clearFunc = function()
						self._memberFactory:destoryMemberById(k)
					end
				}
			end
		end
	end
end

function WordPeaceGame:clearQueueCommond()
	self._addToQueueCommond = {}
	self._creatememberQueue = {}
end

function WordPeaceGame:createBattleFields(bossList)
	self._addToQueueCommond = {}
	self._creatememberQueue = {}

	local list = {}

	for k, v in pairs(bossList) do
		list[#list + 1] = v
	end

	table.sort(list, function(a, b)
		return a:getConfig().HeroPosition[2] > b:getConfig().HeroPosition[2]
	end)

	for i, v in ipairs(list) do
		local function func()
			local pos = cc.p(v:getConfig().HeroPosition[1], v:getConfig().HeroPosition[2])
			local scale = K_CAMP_BOSS_SCALE[v:getConfig().HeroFrame]

			v.orderFactor = i * 10000

			self:createBattleFieldByBoss(v, pos, {
				scale,
				0.5
			})
		end

		func()
	end
end

function WordPeaceGame:changeNextWorldBoss(bossdata)
	local bossIns = self._memberFactory:getMemberById(bossdata:getId())

	bossIns:changeNextBoss()
end

function WordPeaceGame:resumeBallProtectsAction()
	local bosses = self:getMemberFactory():getMembersPool()

	for k_, v_ in pairs(bosses) do
		if v_:getType() == K_WORLD_MEMBER_TYPE.Boss then
			local protect = v_:getProtects()

			for index, value in ipairs(protect) do
				value:battleBackCatchUpForProtect()
			end
		end
	end
end

return WordPeaceGame
