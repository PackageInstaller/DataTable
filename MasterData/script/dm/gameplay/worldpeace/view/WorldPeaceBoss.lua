-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WorldPeaceBoss.lua

WorldPeaceBoss = class("WorldPeaceBoss", WorldPeaceMember)

WorldPeaceBoss:has("_type", {
	is = "rw"
})
WorldPeaceBoss:has("_config", {
	is = "rw"
})
WorldPeaceBoss:has("_hp", {
	is = "rw"
})
WorldPeaceBoss:has("_speed", {
	is = "rw"
})
WorldPeaceBoss:has("_enemys", {
	is = "rw"
})
WorldPeaceBoss:has("_protects", {
	is = "rw"
})
WorldPeaceBoss:has("_atk", {
	is = "rw"
})
WorldPeaceBoss:has("_rotationRadio", {
	is = "rw"
})
WorldPeaceBoss:has("_ovalDt", {
	is = "rw"
})
WorldPeaceBoss:has("_orderFactor", {
	is = "rw"
})

local CampBgRes = {
	{
		"CB_di_boss_Red3.png",
		"CB_di_boss_Red2.png",
		"CB_di_boss_Red1.png"
	},
	{
		"CB_di_boss_Yellow3.png",
		"CB_di_boss_Yellow2.png",
		"CB_di_boss_Yellow1.png"
	},
	{
		"CB_di_boss_blue3.png",
		"CB_di_boss_blue2.png",
		"CB_di_boss_blue1.png"
	},
	[0] = {
		"CB_di_boss_3.png",
		"CB_di_boss_2.png",
		"CB_di_boss_1.png"
	}
}
local CampBuildRes = {
	{
		"CB_di_boss_Red3_1.png",
		"CB_di_boss_Red2_1.png",
		"CB_di_boss_Red1_1.png"
	},
	{
		"CB_di_boss_Yellow3_1.png",
		"CB_di_boss_Yellow2_1.png",
		"CB_di_boss_Yellow1_1.png"
	},
	{
		"CB_di_boss_blue3_1.png",
		"CB_di_boss_blue2_1.png",
		"CB_di_boss_blue1_1.png"
	},
	[0] = {
		"CB_di_boss_3_1.png",
		"CB_di_boss_2_1.png",
		"CB_di_boss_1_1.png"
	}
}
local CampGridRes = {
	"CB_sc9_dige_red.png",
	"CB_sc9_dige_yellow.png",
	"CB_sc9_dige_blue.png"
}
local CampGridDefaultRes = {
	[0] = "CB_sc9_dige_hei.png",
	"CB_sc9_dige_bai.png"
}
local posOffset = {
	{
		cc.p(6.02, -162.35)
	},
	{
		cc.p(-40.510000000000005, -162.35),
		cc.p(20.04, -162.35)
	},
	{
		cc.p(-67.50999999999999, -162.35),
		cc.p(-8.98, -162.35),
		cc.p(51.040000000000006, -162.35)
	}
}
local TagInfos = {
	"CB_ico_jingong2.png",
	"CB_ico_jihuo2.png",
	"CB_ico_fangyu2.png",
	"CB_ico_zhiyuan2.png"
}
local progressAnimRes = {
	"hong_quandaotiao",
	"huang_quandaotiao",
	"lan_quandaotiao"
}

function WorldPeaceBoss:addProtect(bool)
	self._protects[#self._protects + 1] = bool

	table.sort(self._protects, function(a, b)
		return a:getOrder() < b:getOrder()
	end)
	bool:setRadio(bool:getOrder() * -15 + (self._rotationRadio or 0))
	bool:setState(K_WORLD_MEMBER_SATGE.Protect)
	bool:getDisplayNode():setLocalZOrder(1000 - bool:getOrder())
	bool:setOvalDt(bool:getOrder() * K_Oval_Dt + (self._ovalDt or 0))

	self._isPlayingHit = false
end

function WorldPeaceBoss:updateHp(_hpr)
	if not _hpr then
		::label_3_0::

		local hpr = self._data:getHpr()

		self._preHpr = hpr

		self._hpbar:stopAllActions()
		self._hpbar:runAction(PercentTo:create(0.2, hpr * 100))

		if _hpr then
			local x = self._hpbar:getContentSize().width * (hpr > 0.03 and hpr or 0.03)

			if self._preHpr then
				self._hpBarAnim:setPositionX(x)
			end

			self._hpBarAnim:stopAllActions()

			local posY = self._hpBarAnim:getPositionY()

			self._hpBarAnim:setVisible(true)
			self._hpBarAnim:runAction(cc.Sequence:create(cc.MoveTo:create(0.2, cc.p(x, posY)), cc.CallFunc:create(function()
				self._hpBarAnim:setVisible(false)
			end)))
		end
	end
end

function WorldPeaceBoss:updateInfo(data)
	if data:getHpr() then
		self:updateHp()
	end

	local hurtMap = data:getGHurtMap()
	local index = 1
	local prepercent = 0

	if table.nums(hurtMap) == 0 then
		for k, v in pairs(self._progressGroup) do
			self:setProgress(v, 0)
		end
	end

	local tags = self._content:getChildByName("tags")

	if data:getTag() then
		tags:setVisible(true)
		tags:loadTexture(TagInfos[tonumber(data:getTag())], 1)
		tags:stopAllActions()
		tags:setPosition(tags.pos)
		tags:runAction(cc.RepeatForever:create(SuspensionAction:create(tags, 0.5)))
	else
		tags:setVisible(false)
	end

	local order = 10

	for k, v in pairs(hurtMap) do
		for k_, v_ in pairs(data:getGroupName()) do
			if v_.gId == k then
				index = v_.gIndex
			end
		end

		self._progressGroup[index]:setVisible(true)

		local percent = v / data:getMhp()

		order = order - 1

		self:setProgress(self._progressGroup[index], percent + prepercent, 0.5, order)

		prepercent = percent
	end

	local heroCfg = ConfigReader:getRecordById("HeroBase", self._config.Hero)
	local ownInfo = data:getCamp()
	local tempOwnInfo = data:getOwnCamp()

	GameStyle:setDarken(self._playerIcon, false)
	GameStyle:setDarken(self._buildFrame, false)
	self._content:getChildByName("countdown"):setVisible(false)
	self._content:getChildByName("countdown"):setLocalZOrder(5)

	local campFrame = self._content:getChildByName("bg")

	if campFrame then
		campFrame:setLocalZOrder(4)
	end

	local color = {
		"#fd62ff",
		"#ffe26e",
		"#81cdff"
	}

	if ownInfo then
		for k_, v_ in pairs(data:getGroupName()) do
			if v_.gId == ownInfo and tempOwnInfo == "" and self._ownInfo ~= ownInfo then
				self._ownInfo = ownInfo

				local function callback()
					self:playOwnAnim(v_.gIndex, function()
						if self._gameMode == K_RENDER_DISPLAYMODE.MULTILEVEL then
							-- block empty
						end
					end, function()
						self._name:setString(v_.gName .. "`" .. Strings:get(heroCfg.Name) .. ".Lv " .. data:getLv())

						if self._gameMode == K_RENDER_DISPLAYMODE.MULTILEVEL then
							self._name:setString(Strings:get(heroCfg.Name) .. ".Lv " .. data:getLv())
						end

						if campFrame then
							campFrame:loadTexture(CampBgRes[v_.gIndex][self._config.HeroFrame], 1)
						end

						if self._buildFrame then
							self._buildFrame:loadTexture(CampBuildRes[v_.gIndex][self._config.HeroFrame], 1)
						end

						if self._grid then
							self._grid:loadTexture(CampGridRes[v_.gIndex], 1)
						end

						self:setProgress(self._progressGroup[v_.gIndex], 0, 1)
					end)
				end

				local param = {
					bossName = Strings:get(heroCfg.Name),
					level = data:getLv(),
					campName = v_.gName,
					color = color[v_.gIndex],
					clubIcon = v_.gIcon,
					bossId = self:getId(),
					gIndex = v_.gIndex,
					ownCamp = self._tempOwnInfo,
					callback = callback
				}
				local system = DmGame:getInstance()._injector:getInstance("DevelopSystem")

				system:dispatch(Event:new(EVT_CLUBBOSS_END_ZHANEND_REFRESH, param))

				if self._gameMode == K_RENDER_DISPLAYMODE.MULTILEVEL then
					callback()
				end
			end
		end
	end

	self._scaleImg:setVisible(false)
	self._content:getChildByName("countdown"):stopAllActions()

	if tempOwnInfo then
		for k_, v_ in pairs(data:getGroupName()) do
			if v_.gId == tempOwnInfo then
				local function transCallBack()
					self._name:setString(Strings:get(heroCfg.Name) .. ".Lv " .. data:getLv())
					GameStyle:setDarken(self._playerIcon, true)
					GameStyle:setDarken(self._buildFrame, true)
					self._content:getChildByName("countdown"):setVisible(true)

					local ost = data:getOst()
					local clubMapCaptureTime = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapCaptureTime", "content")
					local clubMapCaptureCfg = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubCaptureAccel", "content")

					self._content:getChildByName("countdown"):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
						self._scaleImg:setVisible(true)

						local romotTime = DmGame:getInstance()._injector:getInstance("GameServerAgent"):remoteTimestamp()

						self._content:getChildByFullName("countdown.cnt"):setString(Strings:get("ClubMapBoss_Defend", {
							num = #self._protects
						}))

						if 1 * self._config.OccupyTime - (romotTime - ost / 1000) < 0 then
							self._content:getChildByName("countdown"):stopAllActions()

							return
						end

						local speed = 1

						for k, v in pairs(clubMapCaptureCfg or {}) do
							if v < #self._protects then
								speed = k

								break
							end
						end

						speed = speed > 3 and 3 or speed

						local progress = (romotTime - ost / 1000) / (1 * self._config.OccupyTime) * 100

						self._content:getChildByFullName("countdown.percent"):setString(math.floor(progress) .. "/100")

						local countdown = self._content:getChildByName("countdown")

						for k, v in pairs(self._progressAnim) do
							v:setVisible(false)
						end

						self._progressAnim[v_.gIndex]:setVisible(true)
						self._progressAnim[v_.gIndex]:gotoAndStop(math.floor(progress))
					end), cc.DelayTime:create(1))))
					self:setProgress(self._progressGroup[v_.gIndex], 1)

					local textName = self._content:getChildByFullName("countdown.Text_1")

					textName:setString("")

					local loadtips = textName:getChildByName("loadtips")

					loadtips:setString(Strings:get("ClubMapBoss_Capture1", {
						fontName = TTF_FONT_FZYH_M,
						camp = v_.gName,
						color = color[v_.gIndex]
					}))
					self._content:getChildByName("countdown"):setVisible(true)
				end

				if self._tempOwnInfo ~= tempOwnInfo then
					if not self._tempOwnTransAnim then
						local function callback()
							self:playTeamOwnAnim(v_.gIndex, function()
								return
							end, function()
								return
							end)

							self._tempOwnInfo = tempOwnInfo
							self._tempOwnTransAnim = nil
						end

						local param = {
							bossName = Strings:get(heroCfg.Name),
							level = data:getLv(),
							campName = v_.gName,
							color = color[v_.gIndex],
							clubIcon = v_.gIcon,
							bossId = self:getId(),
							callback = callback
						}
						local system = DmGame:getInstance()._injector:getInstance("DevelopSystem")

						system:dispatch(Event:new(EVT_CLUBBOSS_START_ZHANLING_REFRESH, param))

						self._tempOwnTransAnim = true

						if self._gameMode == K_RENDER_DISPLAYMODE.MULTILEVEL then
							callback()
						end
					end
				else
					transCallBack()
				end

				if v_.gId == ownInfo then
					-- block empty
				end
			end
		end
	end

	if self._gameMode ~= K_RENDER_DISPLAYMODE.MULTILEVEL then
		-- block empty
	end
end

function WorldPeaceBoss:playTeamOwnAnim(campIndex, callBack, transCall)
	local animName = {
		"zhanlinghong_qiuqiuzhanling",
		"zhanlinghuang_qiuqiuzhanling",
		"zhanlinglan_qiuqiuzhanling"
	}
	local anim = cc.MovieClip:create(animName[campIndex])

	anim:addTo(self:getDisplayNode(), 10)
	anim:play()
	anim:offset(-10, -5)
	anim:addEndCallback(function()
		callBack()
		anim:removeFromParent()
	end)
	anim:addCallbackAtFrame(35, function()
		transCall()
	end)
end

function WorldPeaceBoss:playOwnAnim(campIndex, callBack, transCall)
	self:setProgress(self._progressGroup[campIndex], 1)

	local scaleTo1 = cc.ScaleTo:create(0.03333333333333333, 1)
	local scaleTo2 = cc.ScaleTo:create(0.16666666666666669, 1.4)
	local scaleTo3 = cc.ScaleTo:create(0.16666666666666663, 0.9)
	local scaleTo4 = cc.ScaleTo:create(0.26666666666666666, 1.2)
	local scaleTo5 = cc.ScaleTo:create(0.09999999999999998, 1)
	local scaleTo6 = cc.ScaleTo:create(0.20000000000000007, 0.72)
	local scaleTo7 = cc.ScaleTo:create(0.09999999999999998, 1.6)
	local scaleTo8 = cc.ScaleTo:create(0.033333333333333326, 1)
	local actionMid = cc.CallFunc:create(function()
		return
	end)
	local animName = {
		"hong_qiuqiuzhanling",
		"huang_qiuqiuzhanling",
		"lan_qiuqiuzhanling"
	}
	local actionEnd = cc.CallFunc:create(function()
		local anim = cc.MovieClip:create(animName[campIndex])

		anim:addTo(self:getDisplayNode(), 10)
		anim:play()
		anim:offset(-10, -5)
		anim:addEndCallback(function()
			callBack()
			anim:removeFromParent()
		end)
		anim:addCallbackAtFrame(50, function()
			transCall()
		end)
	end)
	local actions1 = cc.Sequence:create(scaleTo1, scaleTo2, scaleTo3, scaleTo4, scaleTo5, scaleTo6, scaleTo7, scaleTo8, actionMid, actionEnd)

	self._heart:runAction(actions1)

	local scaleTo1 = cc.ScaleTo:create(0.03333333333333333, 1)
	local scaleTo2 = cc.ScaleTo:create(0.16666666666666669, 1.4)
	local scaleTo3 = cc.ScaleTo:create(0.16666666666666663, 0.9)
	local scaleTo4 = cc.ScaleTo:create(0.26666666666666666, 1.2)
	local scaleTo5 = cc.ScaleTo:create(0.09999999999999998, 1)
	local scaleTo6 = cc.ScaleTo:create(0.20000000000000007, 0.72)
	local scaleTo7 = cc.ScaleTo:create(0.09999999999999998, 1.6)
	local scaleTo8 = cc.ScaleTo:create(0.033333333333333326, 1)
	local actions1 = cc.Sequence:create(scaleTo1, scaleTo2, scaleTo3, scaleTo4, scaleTo5, scaleTo6, scaleTo7, scaleTo8)

	self._frame:runAction(actions1)
end

function WorldPeaceBoss:initVars()
	self._config = self._data:getConfig()
	self._atk = self._data:getAtk()
end

function WorldPeaceBoss:setProgress(node, percent, duration, order)
	if duration and duration > 0 then
		node:stopAllActions()
		node:runAction(ContentSizeTo:create(duration or 0.2, cc.size(73, 61 * percent)))
	else
		node:setContentSize(cc.size(73, 61 * percent))
	end

	if order then
		node:setLocalZOrder(order)
	end
end

function WorldPeaceBoss:initialize(id, bossType, data, factory)
	super.initialize(self, id, bossType, data, factory)
	self:initVars()

	self._orderFactor = data.orderFactor
	self._enemys = {}
	self._protects = {}
	self._displayNode = ccui.Widget:create()
	self._gameMode = self._factory:getPaceGame():getDisplayMode()

	local csbRes = "asset/ui/Boss.csb"

	if self._gameMode == K_RENDER_DISPLAYMODE.MULTILEVEL then
		csbRes = "asset/ui/Boss_word.csb"
	elseif self._gameMode == K_RENDER_DISPLAYMODE.WORLDBOSS then
		csbRes = "asset/ui/WordBossBoss.csb"
	end

	self._content = cc.CSLoader:createNode(csbRes)

	self._content:setScale(1)
	self._content:addTo(self._displayNode)
	self._content:setName("content")

	self._content.id = self._id
	self._type = K_WORLD_MEMBER_TYPE.Boss

	if self._gameMode == K_RENDER_DISPLAYMODE.MULTILEVEL then
		self._content:getChildByFullName("touchpanel"):setSwallowTouches(false)
		self._content:getChildByFullName("countdown"):offset(30, -32)
	else
		self._content:getChildByFullName("countdown"):offset(0, -35)
	end

	local scaleImg = ccui.Scale9Sprite:createWithSpriteFrameName("CB_pvp_battle_bg.png")

	self._scaleImg = scaleImg

	self._scaleImg:setVisible(false)
	scaleImg:setAnchorPoint(0.5, 0.5)
	scaleImg:setOpacity(120)
	scaleImg:setCapInsets(cc.rect(5, 5, 5, 5))
	scaleImg:setContentSize(cc.size(238, 50))
	scaleImg:addTo(self._content, 1)

	if self._gameMode == K_RENDER_DISPLAYMODE.MULTILEVEL then
		scaleImg:offset(-12, -4)
	else
		scaleImg:offset(-45, 45)
	end

	self._rotationNode = cc.Node:create()

	self._rotationNode:addTo(self._displayNode)

	self._rotationRadio = 0

	local roundTo = RoundTo:create(K_Round_Times, 360, self._content, 250, self._rotationRadio, function(radio)
		self._rotationRadio = radio
	end)
	local action = cc.RepeatForever:create(roundTo)

	self._rotationNode:runAction(action)

	self._ovalNode = cc.Node:create()

	self._ovalNode:addTo(self._displayNode)

	self._ovalDt = 0

	local random = math.random(1, 10) / 10
	local config = {
		key = "OvalNode",
		zOrder1 = 100,
		moveClockDir = true,
		zOrder2 = 99,
		dt = 0,
		a = K_Oval_V[1],
		b = K_Oval_V[2],
		centerPos = cc.p(0, 0),
		step = function(dt)
			self._ovalDt = dt + random
		end
	}
	local ovalTo = OvalTo:create(K_Oval_Times, config)
	local action = cc.RepeatForever:create(ovalTo)

	self._ovalNode:runAction(action)

	self._baseColorTrans = self._displayNode:getColorTransform()

	local tags = self._content:getChildByName("tags")

	tags:setVisible(false)

	tags.pos = cc.p(tags:getPosition())

	tags:setLocalZOrder(10)

	if data:getTag() then
		tags:setVisible(true)
		tags:loadTexture(TagInfos[tonumber(data:getTag())], 1)
		tags:stopAllActions()
		tags:setPosition(tags.pos)
		tags:runAction(cc.RepeatForever:create(SuspensionAction:create(tags, 0.5)))
	else
		tags:setVisible(false)
	end

	local heroId = self._config.Hero

	if type(self._config.Hero) == "table" then
		local index = (self._data:getIndex() + 1) % #self._config.Hero

		if index == 0 then
			index = #self._config.Hero
		end

		heroId = self._config.Hero[index]
	end

	local modelId = IconFactory:getRoleModelByKey("HeroBase", heroId)
	local heroCfg = ConfigReader:getRecordById("HeroBase", heroId)
	local bossIcon = self._content:getChildByName("icon")

	if bossIcon then
		bossIcon:ignoreContentAdaptWithSize(true)
	end

	if self._gameMode ~= K_RENDER_DISPLAYMODE.MULTILEVEL then
		self._occupations = {}

		if self._config.BattleClassLimit then
			for k, v in pairs(self._config.BattleClassLimit) do
				self._content:getChildByName("type" .. k):removeAllChildren()

				local occupationImg = IconFactory:getPartyPath(v, "building")
				local occupation = ccui.ImageView:create(occupationImg, 0)

				occupation:setLocalZOrder(2)
				occupation:setScale(1.3)
				occupation:addTo(self._content:getChildByName("type" .. k)):offset(0, -5)

				self._occupations[#self._occupations + 1] = occupation

				occupation:setVisible(true)

				local pos = posOffset[#self._config.BattleClassLimit][k]

				if self._gameMode ~= K_RENDER_DISPLAYMODE.MULTILEVEL then
					self._content:getChildByName("type" .. k):setPosition(pos)
					self._content:getChildByName("type" .. k):setLocalZOrder(2)
				end
			end
		end
	end

	self._name = self._content:getChildByName("name")
	self._progressbg2 = self._content:getChildByName("progressbg1")

	self._name:setLocalZOrder(6)

	self._heart = self._content:getChildByName("heart")
	self._frame = self._content:getChildByName("frame")

	self._heart:setLocalZOrder(2)
	self._frame:setLocalZOrder(10)
	self._progressbg2:setLocalZOrder(5)

	self._hpbar = self._content:getChildByName("bar")

	self._hpbar:setLocalZOrder(5)

	self._wudi = self._content:getChildByName("wudi")

	if self._wudi then
		self._wudi:setLocalZOrder(5)
		self._wudi:setVisible(false)
	end

	self._hongProgress = self._heart:getChildByName("hong")
	self._huangProgress = self._heart:getChildByName("huang")
	self._lanProgress = self._heart:getChildByName("lan")

	self._hongProgress:setContentSize(cc.size(73, 0))
	self._huangProgress:setContentSize(cc.size(73, 0))
	self._lanProgress:setContentSize(cc.size(73, 0))

	self._grid = self._content:getChildByName("grid")

	if self._grid then
		self._grid:loadTexture(CampGridDefaultRes[tonumber(self._config.Color)], 1)
	end

	if self._config.HeroFrame then
		self:setScale(K_CAMP_BOSS_SCALE[self._config.HeroFrame])
	end

	local hurtMap = data:getGHurtMap()

	self._progressGroup = {
		self._hongProgress,
		self._huangProgress,
		self._lanProgress
	}

	for k, v in pairs(self._progressGroup) do
		v:setVisible(true)
	end

	local index = 1
	local prepercent = 0
	local order = 10

	for k, v in pairs(hurtMap or {}) do
		for k_, v_ in pairs(data:getGroupName()) do
			if v_.gId == k then
				index = v_.gIndex
			end
		end

		self._progressGroup[index]:setVisible(true)

		local percent = v / data:getMhp()

		order = order - 1

		self:setProgress(self._progressGroup[index], percent + prepercent, nil, order)

		prepercent = percent
	end

	self._nameScale = self._name:getScale()

	self._name:setVisible(true)
	self._name:setString(Strings:get(heroCfg.Name) .. ".Lv:" .. data:getLv())

	local index = self._config.HeroFrame
	local campFrame = self._content:getChildByName("bg")

	if campFrame then
		campFrame:loadTexture(CampBgRes[0][index], 1)
		campFrame:setLocalZOrder(4)
	end

	self._buildFrame = self._content:getChildByName("build")

	if self._buildFrame then
		self._buildFrame:ignoreContentAdaptWithSize(true)
		self._buildFrame:loadTexture(CampBuildRes[0][index], 1)
	end

	if self._data:getHpr() then
		local hpr = self._data._hpr

		self._hpbar:setPercent(hpr * 100)

		local animObj = cc.MovieClip:create("xuetiao_qiuqiuzhandou")

		animObj:addTo(self._hpbar)

		self._hpBarAnim = animObj

		self._hpBarAnim:center(self._hpbar:getContentSize())
		self._hpBarAnim:offset(self._hpbar:getContentSize().width * (hpr > 0.03 and hpr or 0.03) - self._hpbar:getContentSize().width / 2, 0)
		self._hpBarAnim:setVisible(false)
	end

	self._playerIcon = self._content:getChildByName("playerIcon")

	if not self._playerIcon then
		local sprite

		if self._gameMode == K_RENDER_DISPLAYMODE.MULTILEVEL then
			local bossIcon = IconFactory:createAsyncRoleIconSpriteNew({
				id = modelId
			})
			local stencil = ccui.ImageView:create("asset/stencil/zc_Clubbride_boss.png", 0)

			bossIcon:setScale(2)
			bossIcon:setPosition(0, 0)
			bossIcon:removeFromParent()

			sprite = ClippingNodeUtils.getClippingNodeByData({
				stencil = stencil,
				content = bossIcon
			})

			sprite:setPosition(cc.p(0, 0))
			sprite:addTo(self._content)
			sprite:setName("playerIcon")
			sprite:setScale(0.41)
			sprite:offset(-75, 40)
			sprite:setOpacity(0)
			sprite:fadeTo({
				time = 0.5,
				opacity = 255
			})
		else
			local bossIcon = self._content:getChildByName("icon")

			if bossIcon then
				bossIcon:setVisible(false)
			end

			sprite = IconFactory:createAsyncRoleIconSpriteNew({
				useAnim = false,
				frameId = "bustframe29",
				id = modelId
			})

			sprite:setPosition(cc.p(0, 0))
			sprite:addTo(self._content)
			sprite:setName("playerIcon")
			sprite:offset(-10, -5)
			sprite:setScale(0.93)
			sprite:setOpacity(0)
			sprite:fadeTo({
				time = 0.5,
				opacity = 255
			})
		end

		self._playerIcon = sprite
	end

	local Image_2 = self._content:getChildByName("Image_2")

	if Image_2 then
		Image_2:setLocalZOrder(1)
		Image_2:setVisible(true)
	end

	if self._gameMode ~= K_RENDER_DISPLAYMODE.MULTILEVEL and self._config.BattleClassLimit then
		for k, v in pairs(self._config.BattleClassLimit) do
			self._content:getChildByName("type" .. k):setLocalZOrder(2)
		end
	end

	self._content:getChildByName("heart"):setLocalZOrder(5)

	local ownInfo = data:getCamp()
	local tempOwnInfo = data:getOwnCamp()

	self._ownInfo = ownInfo
	self._tempOwnInfo = tempOwnInfo

	GameStyle:setDarken(self._playerIcon, false)
	GameStyle:setDarken(self._buildFrame, false)
	self._content:getChildByName("countdown"):setVisible(false)
	self._content:getChildByName("countdown"):setLocalZOrder(4)
	self._content:getChildByFullName("countdown.percent"):setLocalZOrder(1)

	local richText = ccui.RichText:createWithXML("", {})

	richText:addTo(self._content:getChildByFullName("countdown.Text_1"))
	richText:setAnchorPoint(cc.p(0, 0.5))
	richText:setName("loadtips")
	richText:setPosition(-163, -17)

	if self._gameMode == K_RENDER_DISPLAYMODE.MULTILEVEL then
		richText:setPosition(-160, -17)
	end

	self._progressAnim = {}

	for k, v in pairs(progressAnimRes) do
		anim = cc.MovieClip:create(v)

		anim:addTo(self._content:getChildByName("countdown")):offset(-1, -20)
		anim:gotoAndStop(1)

		self._progressAnim[k] = anim

		anim:setVisible(false)
	end

	self._content:getChildByFullName("countdown.percent"):offset(0, -20)

	if ownInfo then
		for k_, v_ in pairs(data:getGroupName()) do
			if v_.gId == ownInfo then
				if tempOwnInfo == "" then
					self._name:setString(v_.gName .. "`" .. Strings:get(heroCfg.Name) .. ".Lv " .. data:getLv())

					if self._gameMode == K_RENDER_DISPLAYMODE.MULTILEVEL then
						self._name:setString(Strings:get(heroCfg.Name) .. ".Lv " .. data:getLv())
					end
				end

				if campFrame then
					campFrame:loadTexture(CampBgRes[v_.gIndex][self._config.HeroFrame], 1)
				end

				if self._buildFrame then
					self._buildFrame:loadTexture(CampBuildRes[v_.gIndex][self._config.HeroFrame], 1)
				end

				if self._grid then
					self._grid:loadTexture(CampGridRes[v_.gIndex], 1)
				end

				if self._config.HeroFrame then
					self:setScale(K_CAMP_BOSS_SCALE[self._config.HeroFrame])
				end
			end
		end
	end

	self._scaleImg:setVisible(false)
	self._content:getChildByName("countdown"):stopAllActions()

	if tempOwnInfo then
		for k_, v_ in pairs(data:getGroupName()) do
			if v_.gId == tempOwnInfo then
				self._name:setString(Strings:get(heroCfg.Name) .. ".Lv " .. data:getLv())
				GameStyle:setDarken(self._playerIcon, true)
				GameStyle:setDarken(self._buildFrame, true)
				self._content:getChildByName("countdown"):setVisible(true)

				local ost = data:getOst()
				local clubMapCaptureTime = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapCaptureTime", "content")
				local clubMapCaptureCfg = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubCaptureAccel", "content")

				self._content:getChildByName("countdown"):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
					self._scaleImg:setVisible(true)
					self._content:getChildByFullName("countdown.cnt"):setString(Strings:get("ClubMapBoss_Defend", {
						num = #self._protects
					}))

					local romotTime = DmGame:getInstance()._injector:getInstance("GameServerAgent"):remoteTimestamp()
					local speed = 1

					for k, v in pairs(clubMapCaptureCfg or {}) do
						if v < #self._protects then
							speed = k + 1

							break
						end
					end

					speed = speed > 3 and 3 or speed

					local progress = (romotTime - ost / 1000) / (1 * self._config.OccupyTime) * 100

					self._content:getChildByFullName("countdown.percent"):setString(math.floor(progress) .. "/100")

					for k, v in pairs(self._progressAnim) do
						v:setVisible(false)
					end

					self._progressAnim[v_.gIndex]:setVisible(true)
					self._progressAnim[v_.gIndex]:gotoAndStop(math.floor(progress))
				end), cc.DelayTime:create(1))))
			end
		end
	end

	if self._gameMode == K_RENDER_DISPLAYMODE.MULTILEVEL then
		self._name:setVisible(true)
	end

	self._actionDefine = WorldPeaceActionFactory:getActionDefine("SIMPLE")

	self:barAction()
	self:updateFirstProtect()
end

function WorldPeaceBoss:barAction(args, displaynode)
	if self._gameMode ~= K_RENDER_DISPLAYMODE.ALL and self._gameMode ~= K_RENDER_DISPLAYMODE.WORLDBOSS then
		return
	end

	local txt = cc.Label:createWithTTF("", TTF_FONT_FZYH_M, 18)

	txt:addTo(self._hpbar):center(self._hpbar:getContentSize())
	setTextWithFontStyle(txt, "FontZWMBText")
	txt:offset(0, 2)

	local index = 0

	txt:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
		index = index + 1

		local m = self._data:getMhp() or 0
		local r = self._data:getHpr() or 0

		if self._protects[1] then
			txt:setString(Strings:get("ClubMapBoss_invincible"))
		elseif index % 2 == 0 then
			txt:setString(math.ceil(math.min(m, r * m)) .. "/" .. m)
		else
			txt:setString(math.ceil(r * 100) .. "%")
		end
	end), cc.DelayTime:create(2))))

	self._hpTxt = txt
end

function WorldPeaceBoss:applyColorTransform(args, displaynode)
	local trans = {}

	table.deepcopy(self._baseColorTrans, trans)

	local mults, offsets = trans.mults, trans.offsets

	displaynode:setSaturation(args.saturation or 0)
	displaynode:setContrast(args.contrast or 0)
	displaynode:setColorTransform(ColorTransform(args.r or mults.x, args.g or mults.y, args.b or mults.z, args.a or mults.w, args.o_r or offsets.x, args.o_g or offsets.y, args.o_b or offsets.z, args.o_a or offsets.w))
end

function WorldPeaceBoss:setRadio(radio)
	self._Radio = radio
end

function WorldPeaceBoss:setPosition(position)
	self._position = position

	self._displayNode:setPosition(position)
end

function WorldPeaceBoss:getPosition()
	return self._position
end

function WorldPeaceBoss:onPrepare()
	if self._gameMode == K_RENDER_DISPLAYMODE.MULTILEVEL then
		-- block empty
	end

	self:setState(K_WORLD_MEMBER_SATGE.Idle)
end

function WorldPeaceBoss:onAttack()
	return
end

function WorldPeaceBoss:getScale()
	return self._scale
end

function WorldPeaceBoss:setScale(scale)
	self._scale = scale

	self._displayNode:setScale(scale)

	if self._grid then
		self._grid:setScale(1 / scale)
	end
end

function WorldPeaceBoss:onIdle()
	local function createAction(node)
		factor = 2

		local scale = node:getScale()
		local scaleTo1 = cc.ScaleTo:create(0.03333333333333333 * factor, scale * 1)
		local scaleTo2 = cc.ScaleTo:create(0.4 * factor, scale * 0.97)
		local scaleTo3 = cc.ScaleTo:create(0.033333333333333326 * factor, scale * 0.97)
		local scaleTo4 = cc.ScaleTo:create(0.6 * factor, scale * 1)
		local action = cc.Sequence:create(scaleTo1, scaleTo2, scaleTo3, scaleTo4)
		local action = cc.RepeatForever:create(action)

		node:runAction(action)
	end

	if self._gameMode == K_RENDER_DISPLAYMODE.ALL then
		createAction(self._playerIcon)
	end

	self:setState(K_WORLD_MEMBER_SATGE.Idleing)
end

function WorldPeaceBoss:onDie()
	return
end

function WorldPeaceBoss:createFlyLabel(pos, value)
	local fnt = ccui.TextBMFont:create(math.floor(value or 999999) or 0, "asset/font/minigame_font.fnt")

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

function WorldPeaceBoss:onHit(detail)
	if not self:isVisible() then
		return
	end

	local effectLayer = self:getEffectLayer()

	if detail.hitflash then
		if tolua.isnull(detail.actor:getDisplayNode()) then
			return
		end

		local hitflash = cc.MovieClip:create(detail.hitflash)

		hitflash:play()

		if self._gameMode == K_RENDER_DISPLAYMODE.WORLDBOSS then
			if detail.actor._isMyth then
				local label = self:createFlyLabel(detail.pos, detail.actor:getAtk())

				label:addTo(effectLayer)
				label:setScale(self:getScale())
			end
		end

		local var_43_0

		do
			do
				local label = self:createFlyLabel(detail.pos, detail.actor:getAtk())

				label:addTo(effectLayer)
				label:setScale(self:getScale())
			end

			var_43_0 = detail.actor:getDisplayNode()
		end

		hitflash:setScale(var_43_0:getScale() * k_EFFECT_SCALE)
		hitflash:addTo(effectLayer)
		hitflash:setPosition(detail.pos)
		hitflash:addEndCallback(function()
			hitflash:removeFromParent()
		end)
		hitflash:setRotation(180 - detail.actor:getRadio())
	end

	if self._isPlayingHit then
		return true
	end

	local displayNodes = {
		self:getDisplayNode()
	}

	if self._protects[1] then
		displayNodes = {
			self._protects[1]:getDisplayNode()
		}

		if DisposableObject:isDisposed(self._protects[1]) then
			return
		end

		if tolua.isnull(self._protects[1]:getDisplayNode()) then
			return
		end

		local targetNode = self._protects[1]:getDisplayNode()

		if not targetNode.hurtAnim then
			local hurtAnim = cc.MovieClip:create("shouji_qiuqiuzhushou")

			hurtAnim:addTo(targetNode)
			hurtAnim:setScale(1.4)
			hurtAnim:addEndCallback(function()
				hurtAnim:setVisible(false)
			end)
			hurtAnim:setVisible(true)

			targetNode.hurtAnim = hurtAnim
		end

		targetNode.hurtAnim:setVisible(true)
		targetNode.hurtAnim:gotoAndPlay(1)
		self._protects[1]:updateHp()
	end

	for k, v in pairs(displayNodes) do
		local displayNode = v
		local moveTo0 = cc.MoveBy:create(0.03333333333333333, cc.p(0, 0))
		local hit1 = cc.CallFunc:create(function()
			self:applyColorTransform({
				o_r = 150
			}, displayNode)
		end)
		local moveTo1 = cc.MoveBy:create(0.06666666666666667, cc.p(-5, 0))
		local hit2 = cc.CallFunc:create(function()
			self:applyColorTransform({
				o_r = 75
			}, displayNode)
		end)
		local moveTo2 = cc.MoveBy:create(0.03333333333333334, cc.p(5, 0))
		local hit3 = cc.CallFunc:create(function()
			self:applyColorTransform({
				o_r = 0
			}, displayNode)
		end)
		local moveTo3 = cc.MoveBy:create(0.033333333333333326, cc.p(0, -2))
		local moveTo4 = cc.MoveBy:create(0.033333333333333326, cc.p(0, 2))
		local moveTo5 = cc.MoveBy:create(0.033333333333333354, cc.p(0, 0))
		local action = cc.Sequence:create(hit1, moveTo0, moveTo1, hit2, moveTo2, hit3, moveTo3, moveTo4, moveTo5)
		local action = cc.Sequence:create(action, cc.CallFunc:create(function()
			return
		end))

		delayCallByTime(0.2, function()
			self._isPlayingHit = false
		end)

		if not tolua.isnull(displayNode) then
			displayNode:runAction(action)
		end
	end

	self._isPlayingHit = true

	if self._gameMode ~= K_RENDER_DISPLAYMODE.WORLDBOSS and not self._protects[1] then
		local m = self._data:getMhp() or 0
		local hp = detail.actor:getAtk() - self._data:getDef()

		self._preHpr = self._preHpr or self._data:getHpr()

		local hpr = self._preHpr - hp / m * 0.7

		if hpr < 0 then
			hpr = 0
		end

		hpr = hpr > 1 and 1 or hpr

		self._data:setHpr(hpr)
		self:updateHp(hpr)

		if self._hpTxt then
			self._hpTxt:setString(math.ceil(math.min(m, hpr * m)) .. "/" .. m)
		end
	end
end

function WorldPeaceBoss:addEnemy(enemy)
	self._enemys[#self._enemys + 1] = enemy
end

function WorldPeaceBoss:update()
	self:checkOverView()
	self:checkInViewPort()
end

function WorldPeaceBoss:checkOverView()
	if not self._transformDirty then
		return
	end

	local containner = self._factory:getDisplayStage():getChildByFullName("map"):getInnerContainer()

	if self._factory:getPaceGame():getDisplayMode() == K_RENDER_DISPLAYMODE.MULTILEVEL then
		if containner:getScale() < k_MULTILEVEL0_1 then
			self:getDisplayNode():setVisible(true)

			for k, v in pairs(self:getAssigedNodes() or {}) do
				v.node:setVisible(false)
			end

			for k, v in pairs(self._mutilevelNodes) do
				v:setVisible(false)
			end
		elseif containner:getScale() < k_MULTILEVEL01 then
			self:getDisplayNode():setVisible(true)

			for k, v in pairs(self:getAssigedNodes() or {}) do
				v.node:setVisible(false)
			end
		elseif containner:getScale() < k_MULTILEVEL02 then
			self:getDisplayNode():setVisible(true)

			for k, v in pairs(self:getAssigedNodes() or {}) do
				v.node:setVisible(false)
			end
		else
			self:getDisplayNode():setVisible(true)

			for k, v in pairs(self:getAssigedNodes() or {}) do
				v.node:setVisible(true)

				if v.node.forceHide then
					v.node:setVisible(false)
				end
			end
		end
	else
		self:getDisplayNode():setVisible(true)
	end
end

function WorldPeaceBoss:checkInViewPort()
	if not self._transformDirty then
		return
	end

	local containner = self._factory:getDisplayStage():getChildByFullName("map"):getInnerContainer()

	local function check(node)
		node:setVisible(true)

		if node.forceHide then
			node:setVisible(false)
		end
	end

	if containner:getScale() < k_MULTILEVEL0_1 then
		self._transformDirty = false

		return
	end

	check(self._displayNode)

	for k, v in pairs(self:getAssigedNodes() or {}) do
		v.node:setVisible(self._displayNode:isVisible())
	end

	for k, v in pairs(self._mutilevelNodes) do
		v:setVisible(self._displayNode:isVisible())
	end

	self._transformDirty = false
end

function WorldPeaceBoss:updateFirstProtect()
	if self._gameMode ~= K_RENDER_DISPLAYMODE.ALL then
		return
	end

	if not self._progressAction then
		self._progressAction = true

		self._progressbg2:runAction(cc.RepeatForever:create(DelayAction:create(function()
			local st = not not self._protects[1]

			self._wudi:setVisible(st)
		end, 0.1)))
	end
end
