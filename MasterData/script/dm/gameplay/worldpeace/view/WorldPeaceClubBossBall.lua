-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WorldPeaceClubBossBall.lua

WorldPeaceClubBossBall = class("WorldPeaceClubBossBall", WorldPeaceMember)

WorldPeaceClubBossBall:has("_type", {
	is = "rw"
})
WorldPeaceClubBossBall:has("_hp", {
	is = "rw"
})
WorldPeaceClubBossBall:has("_sp", {
	is = "rw"
})
WorldPeaceClubBossBall:has("_enemy", {
	is = "rw"
})
WorldPeaceClubBossBall:has("_atk", {
	is = "rw"
})
WorldPeaceClubBossBall:has("_def", {
	is = "rw"
})
WorldPeaceClubBossBall:has("_order", {
	is = "rw"
})
WorldPeaceClubBossBall:has("_distance", {
	is = "rw"
})

local CampFrameRes = {
	"CB_di_hong.png",
	"CB_di_huang.png",
	"CB_di_lan.png"
}
local CampFrameBG = {
	"CB_di_touxianghong.png",
	"CB_di_touxianglhuang.png",
	"CB_di_touxianglan.png"
}

function WorldPeaceClubBossBall:updateInfo(data)
	self._progress:setVisible(data:getHpr() ~= 0)

	local progress = self._progress:getChildByName("bar")

	progress:setPercent(data:getHpr() * 100)
	progress:setVisible(data:getHpr() ~= 0)
	self:refreshHeadView(data)
	self:setBuffAnim(data, 1)
end

function WorldPeaceClubBossBall:initVars()
	self._atk = self._data:getAtk()
	self._sp = self._data:getSp() or 1000
	self._def = self._data:getDef()
	self._order = self._data:getOrder()
end

function WorldPeaceClubBossBall:initialize(id, type, data, factory)
	self._distance = 0
	self._collTime = math.random(0, 1000)

	super.initialize(self, id, type, data, factory)
	self:initVars()

	self._type = K_WORLD_MEMBER_TYPE.Member
	self._displayNode = ccui.Widget:create()

	self._displayNode:setVisible(false)

	self._content = cc.CSLoader:createNode("asset/ui/ClubBossBoll.csb")

	self._content:addTo(self._displayNode)

	self._progress = self._content:getChildByName("progress")

	local progress = self._progress:getChildByName("bar")

	progress:setPercent(data:getHpr() * 100)
	progress:setVisible(data:getHpr() ~= 0)

	self._containner = self._factory:getDisplayStage():getChildByFullName("map"):getInnerContainer()

	local director = cc.Director:getInstance()

	self._winSize = director:getWinSize()
	self._multilevelMembers = {}
	self._multilevelMembers[#self._multilevelMembers + 1] = self._progress
	self._atkEffectProp = 1

	if self:getPlayMode() == K_RENDER_DISPLAYMODE.MULTILEVEL then
		for k, v in pairs(self._multilevelMembers) do
			v:setVisible(false)
		end

		self._atkEffectProp = k_BOLLEFFECT_PROP
	end

	if self._data:getHeroId() then
		local config = PrototypeFactory:getInstance():getHeroPrototype(self._data:getHeroId()):getConfig()

		self._unityType = config.Party
	else
		self._unityType = "DWH"

		self:refreshUnityType()
	end

	self._displayNode:setLocalZOrder(self._data:getIsMyth() and 1 or 0)

	self._actionDefine = WorldPeaceActionFactory:getActionDefine(self._unityType)

	self:refreshView(data)
end

function WorldPeaceClubBossBall:refreshUnityType()
	local types = {
		"WNSXJ",
		"SSZS",
		"BSNCT",
		"MNJH",
		"XD",
		"DWH"
	}

	self._unityType = types[math.random(1, #types)]
end

function WorldPeaceClubBossBall:refreshHeadView(data)
	local icon = self._content:getChildByName("icon")
	local heroCfg = ConfigReader:getRecordById("HeroBase", self._data:getHeroId())

	if not heroCfg then
		icon:setVisible(false)

		return
	end

	local modelId = heroCfg.RoleModel
	local head = ConfigReader:getRecordById("RoleModel", modelId).HeadMain2

	if icon.reapath and icon.reapath == reapath then
		return
	end

	reapath = head .. "_wordpeace.png"

	if not createImageSprite(reapath) then
		reapath = "battlepic_BEr_wordpeace.png"
	end

	icon:loadTexture(reapath, ccui.TextureResType.plistType)

	icon.reapath = reapath

	if not icon:isVisible() then
		icon:setVisible(true)
		icon:setOpacity(0)
		icon:runAction(cc.FadeIn:create(0.06))
	end

	if self._data:getIsMyth() and not self._ownAnim then
		self._ownAnim = cc.Node:create()

		local anim = cc.MovieClip:create("eff_touxiangkuang2_qiuqiulianxian")

		anim:addTo(self._ownAnim)
		anim:setScale(0.9)
		anim:play()
		self._ownAnim:addTo(self._displayNode, -1)
	end
end

function WorldPeaceClubBossBall:refreshView(data)
	self._nameroot = self._content:getChildByFullName("nameroot")

	self._nameroot:setVisible(false)

	local index = data:getGInfo().gIndex
	local campFrame = self._content:getChildByName("kuang")

	campFrame:loadTexture(CampFrameRes[index], 1)
	self:refreshHeadView(data)
	self._nameroot:getChildByName("name"):setString(self._id)
end

function WorldPeaceClubBossBall:setRadio(radio)
	self._Radio = radio
end

function WorldPeaceClubBossBall:getRadio(radio)
	return self._Radio
end

function WorldPeaceClubBossBall:setScale(scale)
	self._scale = scale

	self._displayNode:setScale(scale)
end

function WorldPeaceClubBossBall:getScale()
	return self._scale
end

function WorldPeaceClubBossBall:setPosition(position)
	self._position = position

	self._displayNode:setPosition(position)
end

function WorldPeaceClubBossBall:resetTrans(position)
	self._displayNode:setScale(self._scale)
	self._displayNode:setPosition(self._position)

	for k, v in pairs(self:getAssigedNodes()) do
		v.node:setPosition(v.pos)
	end
end

function WorldPeaceClubBossBall:onProtect()
	if not self._enemy:isVisible() or not self:isVisible() then
		self:setState(K_WORLD_MEMBER_SATGE.Protect)

		return
	end

	self._displayNode:stopAllActions()

	local roundTo = RoundTo:create(K_Round_Times, 360, self._enemy:getDisplayNode(), 210 * self._enemy:getScale(), self._Radio)
	local action = cc.RepeatForever:create(roundTo)

	self._displayNode:runAction(action)
	self:setState(K_WORLD_MEMBER_SATGE.Protecting)
	self._nameroot:setVisible(true)
end

function WorldPeaceClubBossBall:dispose()
	print("dispose")

	if self._collTimeSchedule then
		cancelDelayCall(self._collTimeSchedule)

		self._collTimeSchedule = nil
	end

	if self._attackSchedule then
		cancelDelayCall(self._attackSchedule)

		self._attackSchedule = nil
	end

	if self._lineAnim and self._lineAnim.animIndex ~= animIndex then
		self._lineAnim:removeFromParent(true)

		self._lineAnim = nil
		self._line = nil
	end
end

function WorldPeaceClubBossBall:createFlyLabel(pos, value)
	local fnt = ccui.TextBMFont:create(CurrencySystem:formatCurrencyString(value) or 0, "asset/font/minigame_font.fnt")

	fnt:setPosition(pos)

	local factor = 1

	if self._gameMode == K_RENDER_DISPLAYMODE.MULTILEVEL then
		factor = 0.5
	end

	local scaleTo1 = cc.ScaleTo:create(0.03333333333333333, 1 * factor)
	local scaleTo2 = cc.ScaleTo:create(0.06666666666666668, 1.5 * factor)
	local scaleTo3 = cc.ScaleTo:create(0.06666666666666665, 1 * factor)
	local actions1 = cc.Sequence:create(scaleTo1, scaleTo2, scaleTo3)
	local moveBy1 = cc.MoveBy:create(0.3333333333333333, cc.p(0, 0))
	local moveBy2 = cc.MoveBy:create(0.16666666666666669, cc.p(0, -40))
	local actions2 = cc.Sequence:create(moveBy1, moveBy2)
	local actions = cc.Spawn:create(actions1, actions2)

	fnt:runAction(cc.Sequence:create(actions, cc.CallFunc:create(function()
		fnt:removeFromParent()
	end)))

	return fnt
end

function WorldPeaceClubBossBall:getAtk()
	return self._atk
end

function WorldPeaceClubBossBall:onPrepare()
	local peaceGame = self._factory:getPaceGame()

	self:assigedNodeToMain(self._nameroot, "LabelLayer")

	if self._enemy then
		local isShow = peaceGame:isLabelShowCnt(self._enemy:getId())

		self._content:getChildByName("namebg"):setVisible(isShow)

		self._nameroot.forceHide = not isShow

		local isBollShowCnt = peaceGame:isBollShowCnt(self._enemy:getId())

		self._displayNode:setVisible(isBollShowCnt)

		self._displayNode.levelHide = not isBollShowCnt
	end

	self._collTimeSchedule = delayCallByTime(self._collTime, function()
		self:setState(K_WORLD_MEMBER_SATGE.Idle)
	end)

	self:setState(K_WORLD_MEMBER_SATGE.Preparing)
end

function WorldPeaceClubBossBall:stopAllActions()
	self:getDisplayNode():stopAllActions()

	for k, v in pairs(self:getAssigedNodes()) do
		v.node:stopAllActions()
	end

	self:resetTrans()
end

function WorldPeaceClubBossBall:refreshCollTime()
	self._collTime = math.random(0, 100) * 10
end

function WorldPeaceClubBossBall:onIdle()
	if not self:isVisible() or not self._enemy:isVisible() then
		self:setState(K_WORLD_MEMBER_SATGE.Idle)

		return
	end

	self:stopAllActions()

	if self._isDef then
		self:setState(K_WORLD_MEMBER_SATGE.Protect)
	else
		local idleCfg = WorldPeaceActionFactory:getActionDefine(self._unityType).idle

		if idleCfg.action then
			if tolua.isnull(self:getDisplayNode()) then
				return
			end

			self:stopAllActions()
			idleCfg:action(self, 1 / self._sp)

			self._attackSchedule = delayCallByTime((1000 + self._collTime) / self._sp, function()
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

function WorldPeaceClubBossBall:update()
	if self:getEnemy() then
		if self:getEnemy():isVisible() then
			self:checkOverView()

			for k, v in pairs(self:getAssigedNodes() or {}) do
				v.node:setOpacity(self:getDisplayNode():getOpacity())
			end

			goto label_24_0
		end
	end

	self:getDisplayNode():setVisible(false)

	for k, v in pairs(self:getAssigedNodes() or {}) do
		v.node:setVisible(false)
	end

	if self:getDisplayNode().levelHide then
		self:getDisplayNode():setVisible(false)
	end

	::label_24_0::
end

function WorldPeaceClubBossBall:onDie(args)
	if args then
		self._factory:destoryMemberById(self._id)
	end
end

function WorldPeaceClubBossBall:checkOverView()
	if not self._transformDirty then
		return
	end

	if self._factory:getPaceGame():getDisplayMode() == K_RENDER_DISPLAYMODE.MULTILEVEL then
		if self._containner:getScale() < k_MULTILEVEL01 then
			self:getDisplayNode():setVisible(true)

			for k, v in pairs(self:getAssigedNodes() or {}) do
				v.node:setVisible(false)
			end

			if self:getDisplayNode().levelHide then
				self:getDisplayNode():setVisible(false)

				self._transformDirty = false
			end
		elseif self._containner:getScale() < k_MULTILEVEL02 then
			self:getDisplayNode():setVisible(true)

			for k, v in pairs(self:getAssigedNodes() or {}) do
				v.node:setVisible(false)
			end

			self:checkInViewPort()
		else
			self:getDisplayNode():setVisible(true)

			for k, v in pairs(self:getAssigedNodes() or {}) do
				v.node:setVisible(true)

				if v.node.forceHide then
					v.node:setVisible(false)
				end
			end

			self:checkInViewPort()
		end
	else
		self:getDisplayNode():setVisible(true)

		for k, v in pairs(self:getAssigedNodes()) do
			v.node:setVisible(true)

			if v.node.forceHide then
				v.node:setVisible(false)
			end
		end
	end
end

function WorldPeaceClubBossBall:checkInViewPort()
	if not self._transformDirty then
		return
	end

	local function check(node)
		local w_pos = cc.p(node:getParent():convertToWorldSpace(cc.p(node:getPosition())))
		local isin = cc.rectContainsPoint(k_VIEW_PORT, w_pos)

		node:setVisible(isin)

		if node.forceHide then
			node:setVisible(false)
		end
	end

	check(self._displayNode)

	for k, v in pairs(self:getAssigedNodes() or {}) do
		check(v.node)
	end

	self._transformDirty = false
end

function WorldPeaceClubBossBall:onDie()
	return
end

function WorldPeaceClubBossBall:onHit()
	return
end

function WorldPeaceClubBossBall:removeBuff()
	if self._buffEffect then
		self._buffEffect:removeFromParent()

		self._buffEffect = nil
	end
end

function WorldPeaceClubBossBall:createBuff()
	if not self._buffEffect then
		self._buffEffect = cc.MovieClip:create("speed3_qiuqiuzhandou")

		self._buffEffect:addTo(self:getDisplayNode())
	end
end

function WorldPeaceClubBossBall:setBuffAnim(data, stage)
	local buff = data:getBuff()

	if buff.c == 0 and stage == buff.s then
		local st = "buffSt_" .. buff.c .. stage

		if self._buffSt ~= st then
			self:createBuff()

			self._buffSt = st
		end
	else
		self:removeBuff()

		self._buffSt = nil
	end
end

WorldPeaceClubBossStageOneBall = class("WorldPeaceClubBossStageOneBall", WorldPeaceClubBossBall)

function WorldPeaceClubBossStageOneBall:initialize(id, type, data, factory)
	super.initialize(self, id, type, data, factory)
end

function WorldPeaceClubBossStageOneBall:refreshView(data)
	self._nameroot = self._content:getChildByFullName("nameroot")

	self._nameroot:setVisible(false)

	local index = math.random(1, 3)
	local campFrame = self._content:getChildByName("kuang")

	campFrame:loadTexture(CampFrameRes[index], 1)

	local campBg = self._content:getChildByName("namebg")

	campBg:loadTexture(CampFrameBG[index], 1)

	if data:getNickName() then
		self._nameroot:getChildByName("name"):setString(data:getNickName())
	end
end

function WorldPeaceClubBossStageOneBall:onIdle()
	if not self:isVisible() or not self._enemy:isVisible() then
		self:setState(K_WORLD_MEMBER_SATGE.Idle)

		return
	end

	self:stopAllActions()

	if self._isDef then
		self:setState(K_WORLD_MEMBER_SATGE.Protect)
	else
		local idleCfg = WorldPeaceActionFactory:getActionDefine(self._unityType).idle

		if idleCfg.action then
			if tolua.isnull(self:getDisplayNode()) then
				return
			end

			idleCfg:action(self, 1 / self._sp)

			local atkList = self:getData():getAtkList()

			if #atkList > 0 then
				self:refreshCollTime()

				self._attackSchedule = delayCallByTime(4 + self._collTime, function()
					self:setState(K_WORLD_MEMBER_SATGE.Attack)
				end)
			end

			for k, v in pairs(self:getAssigedNodes()) do
				idleCfg:action(self, 1 / self._sp, v.node)
			end
		end

		self:setState(K_WORLD_MEMBER_SATGE.Idleing)
	end
end

function WorldPeaceClubBossStageOneBall:onAttack(index)
	index = index or 1

	if not self._enemy:isVisible() or not self:isVisible() then
		self:setState(K_WORLD_MEMBER_SATGE.Idle)

		return
	end

	local speed = 1 / self._sp
	local hp = self._atk
	local atkList = self:getData():getAtkList()

	if atkList and atkList[index] then
		hp = atkList[index].hurt
		speed = 1 / #atkList

		table.remove(atkList, index)
	end

	if self:getData().getPreviewSp then
		speed = self:getData():getPreviewSp()
	end

	self:stopAllActions()
	self:refreshUnityType()
	self:refreshLine(self._enemy)

	local attackCfg = WorldPeaceActionFactory:getActionDefine(self._unityType).attack

	if attackCfg.action then
		if tolua.isnull(self:getDisplayNode()) then
			return
		end

		attackCfg:action(self, self._enemy, speed, {
			hitCall = function(wpos)
				if DisposableObject:isDisposed(self) then
					return
				end

				self._enemy:onHit({
					hp = hp,
					unitType = self._unityType,
					actor = self,
					hitflash = attackCfg.hitflash,
					pos = wpos,
					atk = hp
				})

				local effectLayer = self:getEffectLayer()

				if self._data:getIsMyth() then
					local reflect = self._enemy:getData():getAtk()

					if atkList and atkList[index] then
						reflect = atkList[index].i
					end

					if reflect then
						local pos = cc.p(self:getDisplayNode():getPosition())
						local wpos = cc.p(self:getDisplayNode():getParent():convertToWorldSpace(pos))
						local label = self:createFlyLabel(cc.p(wpos.x + 30, wpos.y + 30), reflect)

						label:addTo(effectLayer)
						label:setScale(self:getScale())
					end
				end
			end,
			endCall = function()
				self:stopAllActions()

				if atkList and #atkList > index then
					self:onAttack(index + 1)
				else
					self:setState(K_WORLD_MEMBER_SATGE.Idle)
				end
			end
		})

		for k, v in pairs(self:getAssigedNodes()) do
			attackCfg:action(self, self._enemy, speed, nil, v.node)
		end
	end

	self:setState(K_WORLD_MEMBER_SATGE.Attacking)
end

function WorldPeaceClubBossStageOneBall:refreshLine(target, speed)
	speed = speed or 0.5

	if not self:getData():getAtkTimes() then
		local atkTimes = 1

		if target:getData():getAtkTimes() then
			local teamKey = self:getData():getTeamKey()

			atkTimes = target:getData():getAtkTimes()[teamKey]
		end

		atkTimes = atkTimes or 1

		local animIndex = 1
		local timesList = ConfigReader:getRecordById("ConfigValue", "ClubBoss_Wire").content

		for i = #timesList, 1, -1 do
			if atkTimes >= timesList[i] then
				animIndex = i + 1

				break
			end
		end

		animIndex = math.min(animIndex, #timesList)

		if self._lineAnim then
			-- block empty
		end

		if self._lineAnim and self._lineAnim.animIndex ~= animIndex then
			self._lineAnim:removeFromParent(true)

			self._lineAnim = nil
			self._line = nil
		end

		if not self._lineAnim then
			-- block empty
		end

		if self._lineAnim then
			self._lineAnim.animIndex = animIndex
		end
	end
end

WorldPeaceClubBossStageTwoBall = class("WorldPeaceClubBossStageTwoBall", WorldPeaceClubBossBall)

WorldPeaceClubBossStageTwoBall:has("_atkTimes", {
	is = "rw"
})
WorldPeaceClubBossStageTwoBall:has("_owner", {
	is = "rw"
})

function WorldPeaceClubBossStageTwoBall:initialize(id, type, data, factory)
	self._atkTimes = 0

	super.initialize(self, id, type, data, factory)

	local animPath = data:getOwner() and "eff_touxiangkuang2_qiuqiulianxian" or "eff_touxiangkuang1_qiuqiulianxian"
	local scale = data:getOwner() and 0.8 or 1

	if not self._bgAnim then
		self._bgAnim = cc.MovieClip:create(animPath)

		local effectLayer = self:getEffectLayer()
		local effectLayer = self:getUnderLayer()

		self._bgAnim:addTo(self._content)
		self._bgAnim:setScale(scale)

		self._bgAnim.initScale = scale
	end
end

function WorldPeaceClubBossStageTwoBall:refreshView(data)
	self._progress:setVisible(false)

	self._nameroot = self._content:getChildByFullName("nameroot")

	self._nameroot:setVisible(false)

	local index = math.random(1, 3)
	local campFrame = self._content:getChildByName("kuang")

	campFrame:loadTexture(CampFrameRes[index], 1)

	local campBg = self._content:getChildByName("namebg")

	campBg:loadTexture(CampFrameBG[index], 1)

	if data:getNickName() then
		self._nameroot:getChildByName("name"):setString(data:getNickName())
	end

	self:refreshHeadView(data)
end

function WorldPeaceClubBossStageTwoBall:onIdle()
	if self._bgAnim and not self._bgAnim.initPos then
		self:assigedNodeToMain(self._bgAnim, "UnderLayer")

		self._bgAnim.initPos = true

		local scale = self:getData():getOwner() and 0.5 or 0.54

		self._bgAnim:setScale(0.54)
	end

	if not self:isVisible() or not self._enemy:isVisible() then
		self:setState(K_WORLD_MEMBER_SATGE.Idle)

		return
	end

	if self._isDef then
		self:setState(K_WORLD_MEMBER_SATGE.Protect)
	else
		local idleCfg = WorldPeaceActionFactory:getActionDefine("CLUBBOSSSTAGETWO").idle

		if idleCfg.action then
			if tolua.isnull(self:getDisplayNode()) then
				return
			end

			self:getDisplayNode():stopAllActions()
			self:resetTrans()
			idleCfg:action(self, self._enemy, 1 / self._sp)

			local atkList = self:getData():getAtkList()

			if #atkList > 0 then
				self:refreshCollTime()

				self._attackSchedule = delayCallByTime((1000 + self._collTime) / self._sp, function()
					self:setState(K_WORLD_MEMBER_SATGE.Attack)
				end)
			end

			for k, v in pairs(self:getAssigedNodes()) do
				v.node:stopAllActions()
				idleCfg:action(self, self._enemy, 1 / self._sp)
			end
		end

		self:setState(K_WORLD_MEMBER_SATGE.Idleing)
	end
end

function WorldPeaceClubBossStageTwoBall:onAttack(index)
	index = index or 1

	if not self._enemy:isVisible() or not self:isVisible() then
		self:setState(K_WORLD_MEMBER_SATGE.Idle)

		return
	end

	local speed = 1 / self._sp
	local atkList = self:getData():getAtkList()

	if atkList and atkList[index] then
		speed = 1 / #atkList

		table.remove(atkList, index)
	end

	local attackCfg = WorldPeaceActionFactory:getActionDefine("CLUBBOSSSTAGETWO").attack

	if attackCfg.action then
		self:getDisplayNode():stopAllActions()

		if tolua.isnull(self:getDisplayNode()) then
			return
		end

		attackCfg:action(self, self._enemy, speed, {
			hitCall = function(wpos)
				if DisposableObject:isDisposed(self) then
					return
				end

				self._enemy:onHit({
					hp = 0,
					atk = 0,
					unitType = self._unityType,
					actor = self,
					hitflash = attackCfg.hitflash,
					pos = wpos
				})
			end,
			endCall = function()
				if atkList and #atkList > index then
					self:onAttack(index + 1)
				else
					self:setState(K_WORLD_MEMBER_SATGE.Idle)
				end
			end
		})
	end

	self:setState(K_WORLD_MEMBER_SATGE.Attacking)
end

local animList = {
	"eff_xian_1_qiuqiulianxian",
	"eff_xian_2_qiuqiulianxian",
	"eff_xian_3_qiuqiulianxian",
	"eff_xian_4_qiuqiulianxian",
	"eff_xian_5_qiuqiulianxian"
}
local animSoundId = {
	"Se_Effect_Goth_C&M_Arrest1",
	"Se_Effect_Goth_C&M_Arrest2",
	"Se_Effect_Goth_C&M_Arrest3",
	"Se_Effect_Goth_C&M_Arrest4",
	"Se_Effect_Goth_C&M_Arrest5"
}

function WorldPeaceClubBossStageTwoBall:refreshLine(target, speed)
	speed = speed or 0.5

	if not self:getData():getAtkTimes() then
		local atkTimes = 1

		if target:getData():getAtkTimes() then
			local teamKey = self:getData():getTeamKey()

			atkTimes = target:getData():getAtkTimes()[teamKey]
		end

		atkTimes = atkTimes or 1

		local animIndex = 1
		local timesList = ConfigReader:getRecordById("ConfigValue", "ClubBoss_Wire").content

		for i = #timesList, 1, -1 do
			if atkTimes >= timesList[i] then
				animIndex = i + 1

				break
			end
		end

		animIndex = math.min(animIndex, #timesList)

		if self._lineAnim then
			-- block empty
		end

		if self._lineAnim and self._lineAnim.animIndex ~= animIndex then
			self._lineAnim:removeFromParent(true)

			self._lineAnim = nil
			self._line = nil
		end

		if not self._lineAnim then
			local clippingLayout = ccui.Layout:create()

			self._lineAnim = clippingLayout

			self._lineAnim:atExit(function()
				self:stopEffect()
			end)
			clippingLayout:setAnchorPoint(cc.p(0, 0.5))
			clippingLayout:setClippingEnabled(true)
			clippingLayout:setContentSize(cc.size(400, 10))
			clippingLayout:setOpacity(self:getDisplayNode():getOpacity())

			self._lineEffect = AudioEngine:getInstance():playEffect(animSoundId[animIndex])

			local anim = cc.MovieClip:create(animList[animIndex])

			if self._lineAnimName and self._lineAnimName ~= animList[animIndex] then
				-- block empty
			end

			self._lineAnimName = animList[animIndex]
			self._line = anim

			anim:addTo(clippingLayout):offset(0, clippingLayout:getContentSize().height / 2)

			local effectLayer = self:getEffectLayer()
			local effectLayer = self:getUnderLayer()

			clippingLayout:addTo(effectLayer)

			local distance = self:getDistance() or 200
			local radio = self:getRadio() or 100
			local target_w = target:getDisplayNode():getParent():convertToWorldSpace(cc.p(target:getDisplayNode():getPosition()))
			local target_n = cc.p(effectLayer:convertToNodeSpace(target_w))

			clippingLayout:setPosition(cc.p(target_n))
			clippingLayout:setRotation(360 - radio)

			local size = cc.size(distance, 10)

			clippingLayout:setContentSize(size)
			anim:offset(self:getDistance(), 0)
			anim:runAction(cc.MoveBy:create(speed, cc.p(-distance, 0)))
		end

		if self._lineAnim then
			self._lineAnim.animIndex = animIndex
		end
	end
end

function WorldPeaceClubBossStageTwoBall:stopEffect()
	if self._lineEffect then
		AudioEngine:getInstance():stopEffect(self._lineEffect)

		self._lineEffect = nil
	end
end

function WorldPeaceClubBossStageTwoBall:updateInfo(data)
	self._progress:setVisible(false)

	local progress = self._progress:getChildByName("bar")

	progress:setVisible(false)
	self:setBuffAnim(data, 2)
end

local animPointList = {
	"eff_shandian_1_qiuqiulianxian",
	"eff_shandian_2_qiuqiulianxian",
	"eff_shandian_3_qiuqiulianxian",
	"eff_shandian_4_qiuqiulianxian",
	"eff_shandian_5_qiuqiulianxian"
}

function WorldPeaceClubBossStageTwoBall:onAttacking(target, factor)
	factor = factor or 1

	if not self:getData():getAtkTimes() then
		local atkTimes = 1

		if target:getData():getAtkTimes() then
			local teamKey = self:getData():getTeamKey()

			atkTimes = target:getData():getAtkTimes()[teamKey]
		end

		atkTimes = atkTimes or 1

		local animIndex = 1
		local timesList = ConfigReader:getRecordById("ConfigValue", "ClubBoss_Wire").content

		for i = #timesList, 1, -1 do
			if atkTimes >= timesList[i] then
				animIndex = i + 1

				break
			end
		end

		animIndex = math.min(animIndex, #timesList)
		speed = 1 * factor

		local effectLayer = self:getEffectLayer()
		local effectLayer = self:getUnderLayer()
		local anim = cc.MovieClip:create(animPointList[animIndex])
		local target_w = target:getDisplayNode():getParent():convertToWorldSpace(cc.p(target:getDisplayNode():getPosition()))
		local target_n = cc.p(effectLayer:convertToNodeSpace(target_w))

		anim:setPosition(cc.p(target_n))
		anim:addTo(effectLayer)

		local target_w = self:getDisplayNode():getParent():convertToWorldSpace(cc.p(self:getDisplayNode():getPosition()))
		local target_n = cc.p(effectLayer:convertToNodeSpace(target_w))
		local action = cc.Sequence:create(cc.MoveTo:create(speed, cc.p(target_n.x, target_n.y)), cc.CallFunc:create(function()
			anim:removeFromParent(true)
		end))

		anim:runAction(action)
	end
end
