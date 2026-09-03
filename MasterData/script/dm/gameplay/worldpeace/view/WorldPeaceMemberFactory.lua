-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WorldPeaceMemberFactory.lua

WorldPeaceMemberFactory = class("WorldPeaceMemberFactory", objectlua.Object)

WorldPeaceMemberFactory:has("_membersPool", {
	is = "rw"
})
WorldPeaceMemberFactory:has("_allPointOccupation", {
	is = "rw"
})
WorldPeaceMemberFactory:has("_allPointOccupation1", {
	is = "rw"
})
WorldPeaceMemberFactory:has("_displayStage", {
	is = "rw"
})
WorldPeaceMemberFactory:has("_paceGame", {
	is = "rw"
})
WorldPeaceMemberFactory:has("_creaters", {
	is = "rw"
})
WorldPeaceMemberFactory:has("_randomPosRadius", {
	is = "rw"
})
WorldPeaceMemberFactory:has("_randomPosRadius1", {
	is = "rw"
})
WorldPeaceMemberFactory:has("_randomPosConfig", {
	is = "rw"
})
WorldPeaceMemberFactory:has("_bossProtectRadios", {
	is = "rw"
})

function WorldPeaceMemberFactory:initialize(game, creaters)
	self._creaters = creaters
	self._randomPosRadio = 90
	self._paceGame = game
	self._randomPosRadius = {
		300,
		350,
		400,
		450,
		500
	}
	self._randomPosRadius1 = {
		200,
		250,
		300,
		350,
		400
	}
	self._bossProtectRadios = {}
	self._randomPosConfig = {
		{
			maxnum = 60,
			radio = 10
		},
		{
			maxnum = 50,
			radio = 8
		},
		{
			maxnum = 100,
			radio = 7
		},
		{
			maxnum = 200,
			radio = 3
		},
		{
			maxnum = 800,
			radio = 2
		}
	}
	self._mythBollFixPosCfg = {
		{
			lenth = 280,
			radio = 30
		},
		{
			lenth = 280,
			radio = -30
		},
		{
			lenth = 280,
			radio = 150
		},
		{
			lenth = 280,
			radio = 210
		},
		{
			lenth = 280,
			radio = 0
		},
		{
			lenth = 280,
			radio = 180
		}
	}
	self._mythOccupation = {}
	self._membersPool = {}
	self._allPointOccupation = {}
	self._allPointOccupation1 = {}
	self._objectPoll = {}
	self._randomCfg = {
		{
			0,
			25
		},
		{
			75,
			100
		},
		{
			25,
			50
		},
		{
			50,
			75
		}
	}
end

function WorldPeaceMemberFactory:createMemberById(id, type, data, gameEvn)
	local instance = type == K_WORLD_MEMBER_TYPE.Member and (self._creaters and self._creaters.ballCreater and self._creaters.ballCreater:new(id, type, data, self) or WorldPeaceBall:new(id, type, data, self)) or self._creaters and self._creaters.bossCreater and self._creaters.bossCreater:new(id, type, data, self) or WorldPeaceBoss:new(id, type, data, self)

	self._membersPool[id] = instance

	return instance
end

function WorldPeaceMemberFactory:getObjectFromPoll()
	for k, v in pairs(self._objectPoll) do
		if v.__referenceCtn == 1 then
			v.__referenceCtn = v.__referenceCtn + 1

			return v
		end
	end

	local displayNode = ccui.Widget:create()
	local obj = cc.CSLoader:createNode("asset/ui/Boll.csb")

	obj:addTo(displayNode)
	obj:setName("content")
	displayNode:retain()

	displayNode.__referenceCtn = displayNode.__referenceCtn or 1
	displayNode.__referenceCtn = displayNode.__referenceCtn + 1
	self._objectPoll[#self._objectPoll + 1] = displayNode

	return displayNode
end

function WorldPeaceMemberFactory:releseToPoll(obj)
	obj:stopAllActions()
	obj:setVisible(false)

	if obj.__referenceCtn then
		obj.__referenceCtn = obj.__referenceCtn - 1 or 0
	end

	self._objectPoll[#self._objectPoll + 1] = obj

	return obj
end

function WorldPeaceMemberFactory:getMemberById(id)
	return self._membersPool[id]
end

function WorldPeaceMemberFactory:getBossProtectRadios(bossId)
	self._bossProtectRadios[bossId] = self._bossProtectRadios[bossId] or {}
	self._bossProtectRadios[bossId] = self._bossProtectRadios[bossId] + 15

	return self._bossProtectRadios[bossId]
end

function WorldPeaceMemberFactory:assigedNodeToMain(node, layerName)
	local scale = 1
	local _node = node

	while _node:getParent() do
		scale = scale * _node:getParent():getScale()
		_node = _node:getParent()
	end

	local pos = node:getParent():convertToWorldSpace(cc.p(node:getPosition()))
	local targetLayer = self:getDisplayStage():getChildByFullName("map"):getInnerContainer()

	targetLayer = targetLayer:getChildByName(layerName)

	node:setPosition(targetLayer:convertToNodeSpace(cc.p(pos)))
	node:changeParent(targetLayer)
	node:setScale(scale)

	return node
end

function WorldPeaceMemberFactory:randomDefAroudBossPos(boss)
	if self._paceGame:getDisplayMode() == K_RENDER_DISPLAYMODE.MULTILEVEL then
		return self:randomDefAroudBossPos1(boss)
	end

	local radio = math.random(0, 360)
	local raidoLenth = 100
	local radian = math.pi / 180 * radio
	local offsetY = math.sin(radian) * raidoLenth * boss:getDisplayNode():getScale()
	local offsetX = math.cos(radian) * raidoLenth * boss:getDisplayNode():getScale()
	local pos = cc.p(boss:getDisplayNode():getPositionX() + offsetX, boss:getDisplayNode():getPositionY() + offsetY)

	return {
		radio = 0,
		pos = cc.p(-2000, -2000)
	}
end

function WorldPeaceMemberFactory:randomDefAroudBossPos1(boss)
	return {
		radio = 0,
		pos = cc.p(-2000, -2000)
	}
end

function WorldPeaceMemberFactory:checkFunc(posData, map, boss)
	local radio = posData.radio
	local distance = posData.distance
	local radian = math.angle2radian(radio)
	local sin = math.sin(radian)
	local cos = math.cos(radian)

	if sin >= -1 and sin <= -0.5 then
		if cos >= 0 then
			radio = radio + 60
		end

		if cos < 0 then
			radio = radio - 60
		end

		local radian = math.angle2radian(radio)
		local offsetY = math.sin(radian) * distance * boss:getDisplayNode():getScale()
		local offsetX = math.cos(radian) * distance * boss:getDisplayNode():getScale()

		posData.pos = cc.p(boss:getDisplayNode():getPositionX() + offsetX, boss:getDisplayNode():getPositionY() + offsetY)
		posData.radio = radio
	end

	if sin >= 0.5 and sin <= 1 then
		if cos >= 0 then
			radio = radio - 60
		end

		if cos < 0 then
			radio = radio + 60
		end

		local radian = math.angle2radian(radio)
		local offsetY = math.sin(radian) * distance * boss:getDisplayNode():getScale()
		local offsetX = math.cos(radian) * distance * boss:getDisplayNode():getScale()

		posData.pos = cc.p(boss:getDisplayNode():getPositionX() + offsetX, boss:getDisplayNode():getPositionY() + offsetY)
		posData.radio = radio
	end

	for _, v_ in pairs(map) do
		for k, v in pairs(v_) do
			local eganDistance = math.floor(cc.pGetDistance(posData.pos, v.pos))

			if math.abs(eganDistance) < 50 then
				local radian = math.pi / 180 * posData.radio
				local offsetY = math.sin(radian) * 10
				local offsetX = math.cos(radian) * 10
				local factor = 1

				posData.distance = posData.distance + 10
				posData.pos.x = posData.pos.x + offsetX * factor
				posData.pos.y = posData.pos.y + offsetY * factor

				return self:checkFunc(posData, map, boss)
			end
		end
	end

	return posData
end

function WorldPeaceMemberFactory:randomAroudBossPos(boss, teamkey)
	if self._paceGame:getDisplayMode() == K_RENDER_DISPLAYMODE.MULTILEVEL then
		return self:randomAroudBossPos1(boss, teamkey)
	end

	local id = boss:getId()

	self._allPointOccupation[id] = self._allPointOccupation[id] or {}

	for k, v in pairs(self._randomPosRadius) do
		self._allPointOccupation[id][v] = self._allPointOccupation[id][v] or {}
	end

	local index = 1
	local randomPos
	local scale = boss:getDisplayNode():getScale()
	local x = boss:getDisplayNode():getPositionX()
	local y = boss:getDisplayNode():getPositionY()

	while self._randomPosRadius[index] do
		local raidoLenth = self._randomPosRadius[index]
		local radiocfg = self._randomPosConfig[index]
		local maxnum = radiocfg.maxnum
		local radio = radiocfg.radio

		if #self._allPointOccupation[id][raidoLenth] > 0 then
			local cachenum = #self._allPointOccupation[id][raidoLenth]

			if cachenum < maxnum then
				radio = (cachenum + 1) * radio
				radio = radio + math.random(0, 1) * radio / 3

				local radian = math.pi / 180 * radio
				local length = raidoLenth + raidoLenth * (0.5 - math.random(0, 1)) * 0.1
				local offsetY = math.sin(radian) * length * scale
				local offsetX = math.cos(radian) * length * scale
				local pos = cc.p(x + offsetX, y + offsetY)
				local posData = {
					pos = pos,
					radio = radio,
					teamkey = teamkey,
					distance = raidoLenth
				}

				if self._paceGame:getDisplayMode() ~= K_RENDER_DISPLAYMODE.MULTILEVEL then
					posData = self:checkFunc(posData, self._allPointOccupation[id], boss)
				end

				self._allPointOccupation[id][raidoLenth][cachenum + 1] = posData
				randomPos = posData

				break
			end
		else
			local radian = math.pi / 180 * radio
			local offsetY = math.sin(radian) * raidoLenth * scale
			local offsetX = math.cos(radian) * raidoLenth * scale
			local pos = cc.p(x + offsetX, y + offsetY)
			local posData = {
				pos = pos,
				radio = radio,
				teamkey = teamkey,
				distance = raidoLenth
			}

			if self._paceGame:getDisplayMode() ~= K_RENDER_DISPLAYMODE.MULTILEVEL then
				posData = self:checkFunc(posData, self._allPointOccupation[id], boss)
			end

			self._allPointOccupation[id][raidoLenth][1] = posData
			randomPos = posData

			break
		end

		index = index + 1
	end

	return randomPos
end

function WorldPeaceMemberFactory:randomMthClubBossPos(boss, teamkey, boll)
	local id = boss:getId()

	self._mythOccupation[id] = self._mythOccupation[id] or {}

	local num = table.nums(self._mythOccupation[id])

	if num < #self._mythBollFixPosCfg then
		local posCfg = self._mythBollFixPosCfg[num + 1]
		local scale = boss:getDisplayNode():getScale()

		radio = posCfg.radio + math.random(0, 3) * posCfg.radio / 4

		local isYuancheng = false
		local radian = math.pi / 180 * radio
		local length = posCfg.lenth + posCfg.lenth * (0.5 - math.random(0, 1)) * 0.1
		local var_12_0

		if isYuancheng then
			length = length + 40
			var_12_0 = boss:getDisplayNode()
		end

		local offsetY = math.sin(radian) * length * var_12_0:getScale()
		local offsetX = math.cos(radian) * length * boss:getDisplayNode():getScale()
		local pos = cc.p(boss:getDisplayNode():getPositionX() + offsetX, boss:getDisplayNode():getPositionY() + offsetY)

		self._mythOccupation[id][teamkey] = {
			pos = pos,
			radio = radio,
			teamkey = teamkey
		}
	end

	return self._mythOccupation[id][teamkey]
end

function WorldPeaceMemberFactory:randomMthBossPos(boss, teamkey, boll)
	if self._paceGame:getDisplayMode() == K_RENDER_DISPLAYMODE.MULTILEVEL then
		return self:randomMthBossPos1(boss, teamkey, boll)
	end

	local id = boss:getId()

	self._mythOccupation[id] = self._mythOccupation[id] or {}

	local num = table.nums(self._mythOccupation[id])

	if num < #self._mythBollFixPosCfg then
		local posCfg = self._mythBollFixPosCfg[num + 1]
		local scale = boss:getDisplayNode():getScale()

		radio = posCfg.radio + math.random(0, 3) * posCfg.radio / 4

		local isYuancheng = true

		if boll and boll:getUnityType() then
			for k, v in pairs({
				"WNSXJ",
				"DWH",
				"XD"
			}) do
				if v == boll:getUnityType() then
					isYuancheng = false

					break
				end
			end
		end

		local radian = math.pi / 180 * radio
		local length = posCfg.lenth + posCfg.lenth * (0.5 - math.random(0, 1)) * 0.1

		if isYuancheng then
			length = length + 40
		end

		local var_13_0

		if self._paceGame:getDisplayMode() == K_RENDER_DISPLAYMODE.MULTILEVEL then
			length = length - 50
			var_13_0 = boss:getDisplayNode()
		end

		local offsetY = math.sin(radian) * length * var_13_0:getScale()
		local offsetX = math.cos(radian) * length * boss:getDisplayNode():getScale()
		local pos = cc.p(boss:getDisplayNode():getPositionX() + offsetX, boss:getDisplayNode():getPositionY() + offsetY)

		self._mythOccupation[id][teamkey] = {
			pos = pos,
			radio = radio,
			teamkey = teamkey
		}
	end

	return self._mythOccupation[id][teamkey]
end

function WorldPeaceMemberFactory:destoryMemberById(id)
	if self._membersPool[id] then
		for k, v in pairs(self._membersPool[id]:getAssigedNodes()) do
			v.node:stopAllActions()
			v.node:removeFromParent(true)
		end

		local assigedNodes = self._membersPool[id]:getAssigedNodes()

		assigedNodes = {}

		local enemy = self._membersPool[id]._enemy

		if enemy and enemy:getType() == K_WORLD_MEMBER_TYPE.Boss then
			for k, v in pairs(enemy:getProtects()) do
				if v:getId() == self._membersPool[id]:getId() then
					table.remove(enemy:getProtects(), k)
				end
			end
		end

		self._membersPool[id]:getDisplayNode():stopAllActions()
		self._membersPool[id]:getDisplayNode():removeFromParent(true)
		self._membersPool[id]:dispose()

		self._membersPool[id] = nil

		for k, v in pairs(self._allPointOccupation) do
			for k_, v_ in pairs(v) do
				for k__, v__ in pairs(v_) do
					if v__.teamkey == id then
						table.remove(self._allPointOccupation[k][k_], k__)
					end
				end
			end
		end

		for k, v in pairs(self._mythOccupation) do
			for k_, v_ in pairs(v) do
				if v_.teamkey == id then
					self._mythOccupation[k][v_.teamkey] = nil
				end
			end
		end

		for k, v in pairs(self._allPointOccupation1) do
			for k_, v_ in pairs(v) do
				if v_.teamkey == id then
					self._allPointOccupation1[k][v_.teamkey] = nil
				end
			end
		end
	end
end

function WorldPeaceMemberFactory:markMemberDieing(id)
	if self._membersPool[id] and self._membersPool[id]:getState() ~= K_WORLD_MEMBER_SATGE.Dieing and self._membersPool[id]:getState() ~= K_WORLD_MEMBER_SATGE.Died then
		self._membersPool[id]:setState(K_WORLD_MEMBER_SATGE.Died, function()
			self:destoryMemberById(id)
		end)
	end
end

function WorldPeaceMemberFactory:ShowSimpleDisplay()
	local inner = self._displayStage:getChildByFullName("map"):getInnerContainer()

	inner:getChildByName("EffectLayer"):setVisible(false)
	inner:getChildByName("UnderLayer"):setVisible(false)
end

function WorldPeaceMemberFactory:ShowMidSimpleDisplay()
	local inner = self._displayStage:getChildByFullName("map"):getInnerContainer()

	inner:getChildByName("EffectLayer"):setVisible(false)
	inner:getChildByName("UnderLayer"):setVisible(false)
end

function WorldPeaceMemberFactory:ShowAllDisplay()
	local inner = self._displayStage:getChildByFullName("map"):getInnerContainer()

	inner:getChildByName("EffectLayer"):setVisible(true)
	inner:getChildByName("UnderLayer"):setVisible(true)
end

function WorldPeaceMemberFactory:markMemeberTransFormDirty()
	for k, member in pairs(self._membersPool) do
		member:setTransformDirty(true)
	end
end

function WorldPeaceMemberFactory:step(dt)
	for k, v in pairs(self._membersPool or {}) do
		v:step(dt)
	end
end

function WorldPeaceMemberFactory:getRanderGroupNode(id)
	return self.groupNode
end

function WorldPeaceMemberFactory:createRanderGroupNode(id)
	return self.groupNode
end

ClubBossMemberFactory = class("ClubBossMemberFactory", WorldPeaceMemberFactory)

function ClubBossMemberFactory:initialize(game, creaters)
	super.initialize(self, game, creaters)
end

function WorldPeaceMemberFactory:getOvalPos(pos, dt, a, b)
	local a = a or K_Oval_V1[1]
	local b = b or K_Oval_V1[2]
	local x = a * math.cos(4 * K_MATH_PIOVER2 * dt)
	local y = b * math.sin(4 * K_MATH_PIOVER2 * dt)

	return cc.pAdd(pos, cc.p(x, y))
end

function WorldPeaceMemberFactory:randomMthBossPos1(boss, teamkey, boll)
	local id = boss:getId()

	self._mythOccupation[id] = self._mythOccupation[id] or {}

	local num = table.nums(self._mythOccupation[id])
	local cfg = self._randomCfg[num % #self._randomCfg + 1]
	local dt = math.random(cfg[1], cfg[2]) / 100
	local pos = self:getOvalPos(cc.p(boss:getDisplayNode():getPosition()), dt)

	self._mythOccupation[id][teamkey] = {
		pos = pos,
		radio = 360 * dt,
		teamkey = teamkey
	}

	return self._mythOccupation[id][teamkey]
end

function WorldPeaceMemberFactory:randomAroudBossPos1(boss, teamkey)
	local id = boss:getId()

	self._allPointOccupation1[id] = self._allPointOccupation1[id] or {}

	local num = table.nums(self._allPointOccupation1[id])
	local cfg = self._randomCfg[num % #self._randomCfg + 1]
	local dt = math.random(cfg[1], cfg[2]) / 100
	local pos = self:getOvalPos(cc.p(boss:getDisplayNode():getPosition()), dt)

	self._allPointOccupation1[id][teamkey] = {
		pos = pos,
		radio = 360 * dt,
		teamkey = teamkey
	}

	return self._allPointOccupation1[id][teamkey]
end
