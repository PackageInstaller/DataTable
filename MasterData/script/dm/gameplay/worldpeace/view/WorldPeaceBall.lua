-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WorldPeaceBall.lua

WorldPeaceBall = class("WorldPeaceBall", WorldPeaceMember)

WorldPeaceBall:has("_type", {
	is = "rw"
})
WorldPeaceBall:has("_hp", {
	is = "rw"
})
WorldPeaceBall:has("_sp", {
	is = "rw"
})
WorldPeaceBall:has("_enemy", {
	is = "rw"
})
WorldPeaceBall:has("_atk", {
	is = "rw"
})
WorldPeaceBall:has("_def", {
	is = "rw"
})
WorldPeaceBall:has("_order", {
	is = "rw"
})
WorldPeaceBall:has("_spCount", {
	is = "rw"
})

local CampFrameRes = {
	"CB_di_hong.png",
	"CB_di_huang.png",
	"CB_di_lan.png"
}
local miniRes = {
	"CB_img_zhenying_hong2.png",
	"CB_img_zhenying_huang2.png",
	"CB_img_zhenying_lan2.png"
}
local frameQuality = {
	{
		[15] = "CB_redquality_2.png",
		[16] = "CB_redquality_2.png",
		[17] = "CB_redquality_1.png",
		[13] = "CB_redquality_3.png",
		[14] = "CB_redquality_2.png"
	},
	{
		[15] = "CB_yellowquality_2.png",
		[16] = "CB_yellowquality_2.png",
		[17] = "CB_yellowquality_1.png",
		[13] = "CB_yellowquality_3.png",
		[14] = "CB_yellowquality_2.png"
	},
	{
		[15] = "CB_bluequality_2.png",
		[16] = "CB_bluequality_2.png",
		[17] = "CB_bluequality_1.png",
		[13] = "CB_bluequality_3.png",
		[14] = "CB_bluequality_2.png"
	},
	[100] = {
		[15] = "CB_quality_2.png",
		[16] = "CB_quality_2.png",
		[17] = "CB_quality_1.png",
		[13] = "CB_quality_3.png",
		[14] = "CB_quality_2.png"
	}
}

function WorldPeaceBall:updateInfo(data)
	self._data = data

	if self._data:getOrder() ~= self._order then
		if self._state == K_WORLD_MEMBER_SATGE.Protecting then
			self:catchUpForProtect(self._rotationRadio)
		end

		self:getDisplayNode():setLocalZOrder(1000 - data:getOrder() + self._enemy:getOrderFactor())
	end

	self._order = data:getOrder()

	self:setSp(data:getSp())

	self._spCount = self._data:getSpCount()

	if not self:getEffectLayer():isVisible() then
		self:updateHp()
	end
end

function WorldPeaceBall:getBollData()
	return self._data
end

function WorldPeaceBall:setSp(sp)
	if self._sp == sp then
		return
	end

	if self._spEffect then
		self._spEffect:removeFromParent()

		self._spEffect = nil
	end

	if sp == 2 and self._data:getIsMyth() then
		self._spEffect = cc.MovieClip:create("speed2_qiuqiuzhandou")

		self._spEffect:addTo(self:getDisplayNode())
	end

	if sp == 3 and self._data:getIsMyth() then
		self._spEffect = cc.MovieClip:create("speed3_qiuqiuzhandou")

		self._spEffect:addTo(self:getDisplayNode())
	end

	self._sp = sp
end

function WorldPeaceBall:initVars()
	self._atk = self._data:getAtk()
	self._isMyth = self._data:getIsMyth()
	self._heroId = self._data:getHeroId()
	self._def = self._data:getDef()

	self:setSp(self._data:getSp() or 1000)

	self._order = self._data:getOrder()
	self._spCount = self._data:getSpCount()
end

function WorldPeaceBall:getUnityType()
	return self._unityType
end

function WorldPeaceBall:initialize(id, type, data, factory)
	super.initialize(self, id, type, data, factory)

	self._type = K_WORLD_MEMBER_TYPE.Member
	self._displayNode = ccui.Widget:create()

	self._displayNode:setVisible(false)

	self._content = cc.CSLoader:createNode("asset/ui/Boll.csb")

	self._content:addTo(self._displayNode)

	self._posname = self._content:getChildByName("posname")

	self._posname:setVisible(false)

	self._nameroot = self._content:getChildByFullName("nameroot")

	self._nameroot:setVisible(false)

	self._namebg = self._content:getChildByFullName("namebg")

	self._namebg:setVisible(false)
	self:initVars()

	self._progress = self._content:getChildByName("progress")
	self._progressBar = self._progress:getChildByName("bar")

	self._progressBar:setPercent(data:getHpr() * 100)

	if self._playMode == K_RENDER_DISPLAYMODE.MULTILEVEL then
		self._progress.neverShow = true
	end

	self._hudun = self._content:getChildByName("hudun")

	self._hudun:setVisible(false)

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

	local index = 1

	if data:getGInfo() then
		index = data:getGInfo().gIndex
	end

	local campFrame = self._content:getChildByName("kuang")

	campFrame:loadTexture(CampFrameRes[index], 1)

	local miniFrame = self._content:getChildByName("mini")

	miniFrame:loadTexture(miniRes[index], 1)

	local frame = self._content:getChildByName("frame")

	if frameQuality[index][data:getRa()] then
		campFrame:loadTexture(frameQuality[index][data:getRa()], 1)
		campFrame:ignoreContentAdaptWithSize(true)
		frame:setVisible(false)

		frame.neverShow = true

		campFrame:setScale(1.1)
	else
		frame:setVisible(true)
	end

	if self:getPlayMode() == K_RENDER_DISPLAYMODE.WORLDBOSS then
		if frameQuality[100][data:getRa()] then
			campFrame:loadTexture(frameQuality[100][data:getRa()], 1)
			campFrame:ignoreContentAdaptWithSize(true)
			frame:setVisible(false)

			frame.neverShow = true

			campFrame:setScale(1.1)
		else
			campFrame:loadTexture(frameQuality[100][13], 1)
			campFrame:ignoreContentAdaptWithSize(true)
			frame:setVisible(false)

			frame.neverShow = true

			campFrame:setScale(1.1)
		end
	end

	local color = {
		"#fd62ff",
		"#ffe26e",
		"#81cdff"
	}
	local heroCfg = ConfigReader:getRecordById("HeroBase", self._heroId)
	local modelId = heroCfg.RoleModel
	local head = ConfigReader:getRecordById("RoleModel", modelId).HeadMain2

	self._nameroot:getChildByName("name"):setString(data:getNickName())
	self._nameroot:getChildByName("name"):setColor(GameStyle:stringToColor(color[index]))

	local icon = self._content:getChildByName("icon")

	reapath = head .. "_wordpeace.png"

	icon:loadTexture(reapath, ccui.TextureResType.plistType)

	local config = PrototypeFactory:getInstance():getHeroPrototype(self._heroId):getConfig()

	self._unityType = config.Party

	local star = data:getSt() or 0

	for i = 1, 5 do
		local n = self._content:getChildByName("star" .. i)

		if self._playMode == K_RENDER_DISPLAYMODE.MULTILEVEL then
			n.neverShow = true
		elseif i <= star then
			self._content:getChildByName("star" .. i):setVisible(true)

			self._content:getChildByName("star" .. i).neverShow = false
		else
			self._content:getChildByName("star" .. i):setVisible(false)

			self._content:getChildByName("star" .. i).neverShow = true
		end
	end

	if self._isMyth and not self._spwanAnim then
		self._spwanAnim = cc.Node:create()

		local spwanAnim = cc.MovieClip:create("chuxian_qiuqiuzhandou")

		spwanAnim:addTo(self._spwanAnim)
		spwanAnim:addEndCallback(function()
			self._assigedNodes[self._spwanAnim] = nil

			self._spwanAnim:removeFromParent()
		end)
		self._spwanAnim:setScale(1.5)
		self._displayNode:setBrightness(0)
		self._spwanAnim:addTo(self._displayNode, 1)

		if self:getPlayMode() == K_RENDER_DISPLAYMODE.ALL then
			-- block empty
		end

		self._ownAnim = cc.Node:create()

		local anim = cc.MovieClip:create("ziji_qiuqiuzhandou")

		anim:addTo(self._ownAnim)
		anim:play()
		self._ownAnim:addTo(self._displayNode, -1)
		self._nameroot:setVisible(true)
	end

	self._actionDefine = WorldPeaceActionFactory:getActionDefine(self._unityType)

	if self._playMode == K_RENDER_DISPLAYMODE.ALL then
		self._nameroot.neverShow = false
	elseif self._playMode == K_RENDER_DISPLAYMODE.MULTILEVEL then
		self._nameroot.neverShow = true
		self._namebg.neverShow = true
	end

	if self._playMode == K_RENDER_DISPLAYMODE.WORLDBOSS then
		self._progress:setOpacity(0)
	end
end

function WorldPeaceBall:setRadio(radio)
	self._Radio = radio
end

function WorldPeaceBall:setOvalDt(dt)
	self._ovalDt = dt
end

function WorldPeaceBall:getRadio(radio)
	return self._Radio or 0
end

function WorldPeaceBall:setScale(scale)
	self._scale = scale

	self._displayNode:setScale(scale)
end

function WorldPeaceBall:getScale()
	return self._scale
end

function WorldPeaceBall:getPosition(position)
	return self._position
end

function WorldPeaceBall:setPosition(position)
	self._position = position

	self._displayNode:setPosition(position)
end

function WorldPeaceBall:resetTrans(position)
	self._displayNode:setScale(self._scale)
	self._displayNode:setPosition(self._position)

	for k, v in pairs(self:getAssigedNodes()) do
		-- block empty
	end
end

function WorldPeaceBall:catchUpForProtect(destRadio)
	self._order = self._data:getOrder()

	self._displayNode:stopAllActions()

	for k, v in pairs(self._assigedNodes) do
		v.node:stopAllActions()
	end

	if self._playMode == K_RENDER_DISPLAYMODE.MULTILEVEL then
		self:setOvalDt(self:getEnemy():getOvalDt() + self:getOrder() * K_Oval_Dt)
	else
		self:setRadio(self:getEnemy():getRotationRadio() + self:getOrder() * -15)
	end

	self:setState(K_WORLD_MEMBER_SATGE.Protect)
end

function WorldPeaceBall:battleBackCatchUpForProtect()
	if self._state ~= K_WORLD_MEMBER_SATGE.Protecting then
		return
	end

	self._order = self._data:getOrder()

	self._displayNode:stopAllActions()

	for k, v in pairs(self._assigedNodes) do
		v.node:stopAllActions()
	end

	self:setOvalDt(self:getEnemy():getOvalDt() + self:getOrder() * K_Oval_Dt)
	self:setState(K_WORLD_MEMBER_SATGE.Protect)
end

function WorldPeaceBall:onProtect()
	if not self._enemy:isVisible() or not self:isVisible() then
		self:setState(K_WORLD_MEMBER_SATGE.Protect)

		return
	end

	if self._playMode == K_RENDER_DISPLAYMODE.ALL and self._isMyth then
		self:getDisplayNode():changeParent(self:getBollLayer())
	end

	if self._collTimeSchedule then
		cancelDelayCall(self._collTimeSchedule)

		self._collTimeSchedule = nil
	end

	if self._attackSchedule then
		cancelDelayCall(self._attackSchedule)

		self._attackSchedule = nil
	end

	self._displayNode:stopAllActions()

	for k, v in pairs(self:getAssigedNodes()) do
		v.node:stopAllActions()
	end

	self:updateHp()
	self:delAction()
	self._hudun:setVisible(self:getOrder() == 1)

	if self._playMode == K_RENDER_DISPLAYMODE.MULTILEVEL and self:getOrder() == 1 and not self._showBig then
		self:setScale(self:getScale() * 1.2)

		self._showBig = true
	end
end

function WorldPeaceBall:dispose()
	if self._collTimeSchedule then
		cancelDelayCall(self._collTimeSchedule)

		self._collTimeSchedule = nil
	end

	if self._attackSchedule then
		cancelDelayCall(self._attackSchedule)

		self._attackSchedule = nil
	end

	if self._order == 1 then
		local dieAnim = cc.MovieClip:create("die_qiuqiuzhushou")

		dieAnim:addTo(self:getEffectLayer())
		dieAnim:setScale(1.4)
		dieAnim:addEndCallback(function()
			dieAnim:removeFromParent()
		end)
		dieAnim:setPosition(self:getPosition())
	end

	self.__showLabel = nil
end

function WorldPeaceBall:createFlyLabel(pos, value)
	local fnt = ccui.TextBMFont:create(math.floor(value) or 0, "asset/font/minigame_font.fnt")

	fnt:setPosition(pos)

	local factor = 1

	if self._playMode == K_RENDER_DISPLAYMODE.MULTILEVEL then
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

function WorldPeaceBall:updateHp()
	self._progressBar:stopAllActions()
	self._progressBar:runAction(PercentTo:create(0.5, self._data:getHpr() * 100))
	self:updateFirstProtect(true)
end

function WorldPeaceBall:onAttack()
	if not self._enemy:isVisible() or not self:isVisible() then
		self:setState(K_WORLD_MEMBER_SATGE.Idle)

		return
	end

	local attackCfg = WorldPeaceActionFactory:getActionDefine(self._unityType).attack

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

				if self._state == K_WORLD_MEMBER_SATGE.Protect or self._state == K_WORLD_MEMBER_SATGE.Protecting then
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
				end

				self:updateHp()
			end,
			endCall = function()
				if self._state == K_WORLD_MEMBER_SATGE.Protect or self._state == K_WORLD_MEMBER_SATGE.Protecting then
					return
				end

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

function WorldPeaceBall:onPrepare()
	if not self._enemy then
		return
	end

	local peaceGame = self._factory:getPaceGame()

	if not self._isMyth then
		self:assigedNodeToMain(self._nameroot, "LabelLayer")
	end

	local isShow = peaceGame:isLabelShowCnt(self._enemy:getId())

	self._content:getChildByName("namebg"):setVisible(isShow)

	self._nameroot.forceHide = not isShow

	if self._playMode == K_RENDER_DISPLAYMODE.ALL then
		self._nameroot.forceHide = false
	end

	local isBollShowCnt = peaceGame:isBollShowCnt(self._enemy:getId())

	if self._containner:getScale() < k_MULTILEVEL0_1 then
		self._displayNode:setVisible(false)
	else
		self._displayNode:setVisible(true)
	end

	self._displayNode.levelHide = not isBollShowCnt

	if self._isMyth then
		self._displayNode:setVisible(true)

		self._displayNode.levelHide = false

		self._content:getChildByName("namebg"):setVisible(true)
	end

	self._collTime = math.random(0, 1000)
	self._collTimeSchedule = delayCallByTime(self._collTime, function()
		self:setState(K_WORLD_MEMBER_SATGE.Idle)
	end)

	self:setState(K_WORLD_MEMBER_SATGE.Preparing)
end

function WorldPeaceBall:onIdle()
	if not self:isVisible() or not self._enemy:isVisible() then
		self:setState(K_WORLD_MEMBER_SATGE.Idle)

		return
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
			self._attackSchedule = delayCallByTime((1000 + self._collTime) / self._sp, function()
				if self._state ~= K_WORLD_MEMBER_SATGE.Protect and self._state ~= K_WORLD_MEMBER_SATGE.Protecting then
					self:setState(K_WORLD_MEMBER_SATGE.Attack)
				end
			end)

			for k, v in pairs(self:getAssigedNodes()) do
				v.node:stopAllActions()
				idleCfg:action(self, 1 / self._sp, v.node)
			end
		end

		self:setState(K_WORLD_MEMBER_SATGE.Idleing)
	end
end

function WorldPeaceBall:update(dt)
	if self:getEnemy() then
		if self:getEnemy():isVisible() then
			self:checkOverView()

			goto label_31_0
		end
	end

	self:getDisplayNode():setVisible(false)

	for k, v in pairs(self:getAssigedNodes() or {}) do
		v.node:setVisible(false)
	end

	if self:getDisplayNode().levelHide then
		self:getDisplayNode():setVisible(false)
	end

	::label_31_0::

	if self._tickDieTimeFunc then
		self._tickDieTimeFunc(dt)
	end
end

function WorldPeaceBall:onDie(args)
	if args then
		if self._collTimeSchedule then
			cancelDelayCall(self._collTimeSchedule)

			self._collTimeSchedule = nil
		end

		if self._attackSchedule then
			cancelDelayCall(self._attackSchedule)

			self._attackSchedule = nil
		end

		self:resetTrans()
		self:getDisplayNode():setGray(true)
		self:getDisplayNode():stopAllActions()

		for k, v in pairs(self:getAssigedNodes()) do
			v.node:stopAllActions()
		end

		local ClubMapRemanisTime = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapRemanisTime", "content")

		self:setState(K_WORLD_MEMBER_SATGE.Dieing)

		local sp = ccui.Text:create("HUIFU", TTF_FONT_FZYH_M, 18)

		setTextWithFontStyle(sp, "FontZWMBText")
		sp:addTo(self:getDisplayNode())
		sp:setLocalZOrder(10)
		sp:setAnchorPoint(cc.p(0.5, 0.5))
		self:assigedNodeToMain(sp, "LabelLayer")
		self:getDisplayNode():setLocalZOrder(-1000)

		if ClubMapRemanisTime then
			if not (ClubMapRemanisTime * 1000) then
				local time = 10000

				time = time / 1000

				function self._tickDieTimeFunc(dt)
					time = time - dt

					if time <= 0 then
						self._tickDieTimeFunc = nil

						if DisposableObject:isDisposed(self) then
							return
						end

						for k, v in pairs(self:getAssigedNodes()) do
							local fadeOut = cc.FadeOut:create(0.2)
							local fadeOut = cc.Spawn:create(cc.ScaleTo:create(0.5, 0), fadeOut)

							v.node:runAction(fadeOut)
						end

						local fadeOut = cc.FadeOut:create(0.2)
						local fadeOut = cc.Spawn:create(cc.ScaleTo:create(0.5, 0), fadeOut)
						local sequence = cc.Sequence:create(fadeOut, cc.CallFunc:create(function()
							args()
						end))

						self:getDisplayNode():runAction(sequence)
					else
						sp:setString(TimeUtil:formatTimeStr(time))
					end
				end
			end
		end
	end
end

function WorldPeaceBall:showMini(isShow)
	for k, v in pairs(self._content:getChildren()) do
		if v:getName() ~= "hudun" then
			v:setVisible(not isShow)

			if v:getName() == "mini" then
				v:setVisible(isShow)
				v:setScale(6)
			end
		end

		if v:getName() == "hudun" then
			v:setVisible(v:isVisible())
		end

		if v.neverShow then
			v:setVisible(false)
		end
	end
end

function WorldPeaceBall:checkOverView()
	if not self._transformDirty then
		return
	end

	self:checkInViewPort()

	if self._factory:getPaceGame():getDisplayMode() == K_RENDER_DISPLAYMODE.MULTILEVEL then
		if self._containner:getScale() < k_MULTILEVEL0_1 then
			if not self._isMyth then
				self:showMini(true)
			end
		elseif self._containner:getScale() < k_MULTILEVEL01 then
			-- block empty
		elseif self._containner:getScale() < k_MULTILEVEL02 then
			-- block empty
		end
	end
end

function WorldPeaceBall:checkInViewPort()
	if not self._transformDirty then
		return
	end

	self:showMini(false)

	local function check(node)
		node:setVisible(true)

		if node.forceHide then
			node:setVisible(false)
		end

		if node.neverShow then
			node:setVisible(false)
		end
	end

	check(self._displayNode)

	for k, v in pairs(self:getAssigedNodes() or {}) do
		check(v.node)
	end

	self._transformDirty = false
end

function WorldPeaceBall:onHit()
	return
end

function WorldPeaceBall:ovalTo()
	self._displayNode:stopAllActions()

	for k, v in pairs(self._assigedNodes) do
		v.node:stopAllActions()
	end

	local x, y = self._enemy:getDisplayNode():getPosition()
	local config = {
		moveClockDir = true,
		key = self._id,
		a = K_Oval_V[1],
		b = K_Oval_V[2],
		centerPos = cc.p(x, y),
		step = function(dt)
			self:setOvalDt(dt)
			self:setPosition(cc.p(self:getDisplayNode():getPosition()))
		end,
		dt = self._ovalDt
	}
	local ovalTo = OvalTo:create(K_Oval_Times, config)
	local action = cc.RepeatForever:create(ovalTo)

	self._displayNode:runAction(action)
	self:setState(K_WORLD_MEMBER_SATGE.Protecting)
	self:getDisplayNode():setVisible(true)

	config.step = nil

	for k, v in pairs(self._assigedNodes) do
		local ovalTo = OvalTo:create(K_Oval_Times, config)
		local action = cc.RepeatForever:create(ovalTo)

		v.node:runAction(action)
	end
end

function WorldPeaceBall:roundTo()
	self._displayNode:stopAllActions()

	for k, v in pairs(self._assigedNodes) do
		v.node:stopAllActions()
	end

	self._displayNode:setVisible(self._order < 22)
	self:setState(K_WORLD_MEMBER_SATGE.Protecting)

	if self._order == 1 then
		self:setPosition(cc.p(350, 295))

		for k, v in pairs(self._assigedNodes) do
			v.node:setPosition(cc.p(350, 295))
			v.node:setScale(0.9)
		end

		self:setScale(0.9)
		self:updateFirstProtect()

		return
	end

	local offsetx = -4

	if self._playMode == K_RENDER_DISPLAYMODE.ALL then
		offsetx = -10
	end

	local roundTo = RoundTo:create(K_Round_Times, 360, self._enemy:getDisplayNode(), 240 * self._enemy:getScale(), self._Radio, function(radio)
		self:setRadio(radio)
		self:setPosition(cc.p(self:getDisplayNode():getPosition()))
	end, cc.p(offsetx, 0))
	local action = cc.RepeatForever:create(roundTo)

	self._displayNode:runAction(action)

	for k, v in pairs(self._assigedNodes) do
		local roundTo = RoundTo:create(K_Round_Times, 360, self._enemy:getDisplayNode(), 240 * self._enemy:getScale(), self._Radio, nil, cc.p(offsetx, 0))
		local action = cc.RepeatForever:create(roundTo)

		v.node:runAction(action)
	end
end

function WorldPeaceBall:delAction()
	if self._playMode == K_RENDER_DISPLAYMODE.MULTILEVEL then
		self:ovalTo()
	else
		self:roundTo()
	end
end

function WorldPeaceBall:updateFirstProtect(showAction)
	if self._playMode ~= K_RENDER_DISPLAYMODE.ALL then
		return
	end

	if self._order ~= 1 then
		return
	end

	if not self._data:getIsProtect() then
		return
	end

	local hpr = self._data:getHpr() or 0

	if not self._firstProtectShow then
		self._firstProtectShow = true

		self._progress:setVisible(false)

		self._barBg2 = ccui.ImageView:create("CB_di_xuedi3.png", 1)

		self._barBg2:addTo(self._displayNode):offset(207, -20)
		self._barBg2:setLocalZOrder(-100)
		self._barBg2:setScale(1.1)

		self._bar2 = self._progressBar:clone()

		self._bar2:addTo(self._displayNode):offset(40, -28.5)
		self._bar2:setLocalZOrder(100)
		self._bar2:setContentSize(cc.size(301, 14))
		self._bar2:setPercent(hpr * 100)

		local txt = cc.Label:createWithTTF("", TTF_FONT_FZYH_M, 18)

		txt:addTo(self._bar2):center(self._bar2:getContentSize())
		setTextWithFontStyle(txt, "FontZWMBText")
		txt:offset(0, 2)
		txt:setString(math.ceil(hpr * 100) .. "%")

		self._hpTxt2 = txt

		local animObj = cc.MovieClip:create("xuetiao_qiuqiuzhandou")

		animObj:addTo(self._bar2)

		self._hpBarAnim2 = animObj

		self._hpBarAnim2:center(self._bar2:getContentSize())
		self._hpBarAnim2:offset(self._bar2:getContentSize().width * (hpr > 0.03 and hpr or 0.03) - self._bar2:getContentSize().width / 2, 0)
		self._hpBarAnim2:setVisible(false)
	end

	local x = self._bar2:getContentSize().width * (hpr > 0.03 and hpr or 0.03)

	if self._preHpr then
		self._hpBarAnim2:setPositionX(x)
	end

	self._preHpr = hpr

	self._hpBarAnim2:stopAllActions()
	self._hpBarAnim2:setVisible(false)

	if showAction then
		self._hpBarAnim2:setVisible(true)
		self._hpBarAnim2:runAction(cc.Sequence:create(cc.MoveTo:create(0.2, cc.p(x, 8)), cc.CallFunc:create(function()
			self._hpBarAnim2:setVisible(false)
		end)))
	end

	self._hpTxt2:setString(math.ceil(hpr * 100) .. "%")
	self._bar2:setPercent(hpr * 100)
end

function WorldPeaceBall:stopActions()
	if self._collTimeSchedule then
		cancelDelayCall(self._collTimeSchedule)

		self._collTimeSchedule = nil
	end

	if self._attackSchedule then
		cancelDelayCall(self._attackSchedule)

		self._attackSchedule = nil
	end

	self._displayNode:stopAllActions()

	for k, v in pairs(self:getAssigedNodes()) do
		v.node:stopAllActions()
	end
end
