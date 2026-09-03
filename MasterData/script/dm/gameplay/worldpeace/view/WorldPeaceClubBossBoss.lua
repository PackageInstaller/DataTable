-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WorldPeaceClubBossBoss.lua

WorldPeaceClubBossBoss = class("WorldPeaceClubBossBoss", WorldPeaceMember)

WorldPeaceClubBossBoss:has("_type", {
	is = "rw"
})
WorldPeaceClubBossBoss:has("_config", {
	is = "rw"
})
WorldPeaceClubBossBoss:has("_hp", {
	is = "rw"
})
WorldPeaceClubBossBoss:has("_speed", {
	is = "rw"
})
WorldPeaceClubBossBoss:has("_enemys", {
	is = "rw"
})
WorldPeaceClubBossBoss:has("_protects", {
	is = "rw"
})
WorldPeaceClubBossBoss:has("_atk", {
	is = "rw"
})

local CampFrame = {
	"CB_di_boss_jin.png",
	"CB_di_boss_yin.png",
	"CB_di_boss_hong.png"
}
local CampBgFrame = {
	"CB_di_boss_huangdi.png",
	"CB_di_boss_heidi.png",
	"CB_di_boss_hongdi.png"
}
local posOffset = {
	{
		cc.p(6.02, -162.35)
	},
	{
		cc.p(-30.51, -162.35),
		cc.p(30.04, -162.35)
	},
	{
		cc.p(-52.51, -162.35),
		cc.p(6.02, -162.35),
		cc.p(66.04, -162.35)
	},
	{
		cc.p(-112.51, -162.35),
		cc.p(-52.51, -162.35),
		cc.p(6.02, -162.35),
		cc.p(66.04, -162.35)
	},
	{
		cc.p(-162.51, -162.35),
		cc.p(-102.51, -162.35),
		cc.p(-52.51, -162.35),
		cc.p(6.02, -162.35),
		cc.p(66.04, -162.35)
	}
}
local posOffset1 = {
	{
		cc.p(-44.980000000000004, -162.35)
	},
	{
		cc.p(-73.51, -162.35),
		cc.p(-12.96, -162.35)
	},
	{
		cc.p(-102.50999999999999, -162.35),
		cc.p(-43.980000000000004, -162.35),
		cc.p(16.040000000000006, -162.35)
	},
	{
		cc.p(-137.51, -162.35),
		cc.p(-77.50999999999999, -162.35),
		cc.p(-18.98, -162.35),
		cc.p(41.040000000000006, -162.35)
	},
	{
		cc.p(-162.51, -162.35),
		cc.p(-106.51, -162.35),
		cc.p(-49, -162.35),
		cc.p(8, -162.35),
		cc.p(66.04, -162.35)
	}
}

function WorldPeaceClubBossBoss:addProtect(bool)
	self._protects[#self._protects + 1] = bool

	local radio = 0

	table.sort(self._protects, function(a, b)
		return a:getOrder() < b:getOrder()
	end)

	for k, v in pairs(self._protects) do
		v:setRadio(radio)
		bool:setState(K_WORLD_MEMBER_SATGE.Protect)
		v:getDisplayNode():setLocalZOrder(-k)

		radio = radio - 15
	end
end

function WorldPeaceClubBossBoss:updateInfo(data)
	local hp = self._data:getHpr()

	if hp then
		self._hpbar:setPercent(hp * 100)
	end

	local hurtMap = data:getGHurtMap() or {}
	local index = 1
	local prepercent = 0

	for k, v in pairs(hurtMap) do
		self._progressGroup[index]:setVisible(true)

		local percent = v / data:getMhp()

		self:setProgress(self._progressGroup[index], percent + prepercent)

		prepercent = percent
		index = index + 1
	end

	if self._hpNum then
		self._hpNum:setString(CurrencySystem:formatCurrencyString(self._data:getCurHp()) .. "/" .. CurrencySystem:formatCurrencyString(self._data:getMaxHp()))
	end
end

function WorldPeaceClubBossBoss:initVars()
	self._config = self._data:getConfig()
	self._atk = self._data:getAtk()
end

function WorldPeaceClubBossBoss:setProgress(node, percent)
	node:setContentSize(cc.size(63, 50 * percent))
end

function WorldPeaceClubBossBoss:getCsb()
	return "asset/ui/ClubBossBoss.csb"
end

function WorldPeaceClubBossBoss:hideNodes()
	self._recoverNode:setVisible(false)
	self._bonusPanel:setVisible(false)
	self._recoverNode:setVisible(false)
	self._recoverNode:setVisible(false)
end

function WorldPeaceClubBossBoss:initialize(id, type, data, factory)
	super.initialize(self, id, type, data, factory)
	self:initVars()

	self._enemys = {}
	self._protects = {}
	self._displayNode = ccui.Widget:create()
	self._content = cc.CSLoader:createNode(self:getCsb())

	self._content:setScale(1)
	self._content:addTo(self._displayNode)

	self._type = K_WORLD_MEMBER_TYPE.Boss
	self._baseColorTrans = self._displayNode:getColorTransform()
	self._gameMode = self._factory:getPaceGame():getDisplayMode()
	self._name = self._content:getChildByName("name")
	self._bossIcon = self._content:getChildByName("icon")
	self._bg = self._content:getChildByName("bg")
	self._di = self._content:getChildByName("di")
	self._progressbg1 = self._content:getChildByName("progressbg")
	self._progressbg2 = self._content:getChildByName("progressbg1")
	self._heart = self._content:getChildByName("heart")
	self._frame = self._content:getChildByName("frame")

	self._progressbg2:setLocalZOrder(2)
	self._progressbg1:setLocalZOrder(2)
	self._heart:setLocalZOrder(2)

	self._hongProgress = self._heart:getChildByName("hong")
	self._huangProgress = self._heart:getChildByName("huang")
	self._lanProgress = self._heart:getChildByName("lan")
	self._zhanling = self._content:getChildByName("zhanling")

	self._zhanling:setLocalZOrder(3)
	self._zhanling:getChildByName("progress"):setVisible(false)
	self._zhanling:setVisible(false)

	if self._frame then
		self._frame:setLocalZOrder(3)
	end

	self._progressbg2:setVisible(self._gameMode == K_RENDER_DISPLAYMODE.MULTILEVEL)
	self._progressbg1:setVisible(self._gameMode ~= K_RENDER_DISPLAYMODE.MULTILEVEL)

	self._hpbar = self._content:getChildByName("bar")

	local hpr = self._data:getHpr()

	if hpr then
		self._hpbar:setPercent(hpr * 100)
	end

	self._hpbar:setLocalZOrder(2)

	if not self._content:getChildByName("playerIcon") then
		local bossIcon = self._content:getChildByName("icon")

		bossIcon:setScale(1.2)

		local stencil = ccui.ImageView:create("asset/stencil/zc_Clubbride_boss1.png")

		bossIcon:setPosition(0, 0)
		bossIcon:removeFromParent()

		sprite = ClippingNodeUtils.getClippingNodeByData({
			stencil = stencil,
			content = bossIcon
		})

		sprite:setPosition(cc.p(0, 0))
		sprite:addTo(self._content)
		sprite:setName("playerIcon")
		sprite:setScale(0.98)
	end

	for k, v in pairs(self._config.BattleClassLimit or {}) do
		self._content:getChildByName("type" .. k):setLocalZOrder(2)
	end

	self._name:setLocalZOrder(2)
	self._content:getChildByName("bg"):setLocalZOrder(1)
	self._content:getChildByName("heart"):setLocalZOrder(1)

	local hurtMap = data:getGHurtMap() or {}

	self._progressGroup = {
		self._hongProgress,
		self._huangProgress,
		self._lanProgress
	}

	for k, v in pairs(self._progressGroup) do
		v:setVisible(false)
	end

	local index = 1
	local prepercent = 0

	for k, v in pairs(hurtMap) do
		self._progressGroup[index]:setVisible(true)

		local percent = v / data:getMhp()

		self:setProgress(self._progressGroup[index], percent + prepercent)

		prepercent = percent
		index = index + 1
	end

	self._hongProgress:setLocalZOrder(3)
	self._huangProgress:setLocalZOrder(2)
	self._lanProgress:setLocalZOrder(1)
	self:refreshView(data)

	self._recoverNode = self._content:getChildByName("recoverNode")
	self._bonusPanel = self._content:getChildByName("bonusPanel")

	self:assigedNodeToMain(self._bonusPanel, "EffectLayer")

	if self._bonusPanel then
		self._bonusPanel:setVisible(false)
		self._bonusPanel:setLocalZOrder(9999)
	end

	self:setHpStage(data)
	self:updateRecover()

	self._hpNum = self._content:getChildByFullName("hpNum")

	if self._hpNum then
		self._hpNum:setLocalZOrder(2)
	end
end

function WorldPeaceClubBossBoss:onClickBonus(sender, eventType)
	if eventType == ccui.TouchEventType.began then
		local targetPos = sender:getParent():convertToWorldSpace(cc.p(sender:getPosition()))

		self._bonusPanel:setPositionX(self._bonusPanel:getParent():convertToNodeSpace(targetPos).x)
		self._bonusPanel:setVisible(true)

		local height = self:refreshInnerAttrPanel()

		self._bonusPanel:setPositionY(self._bonusPanel:getParent():convertToNodeSpace(targetPos).y + 90 + height)
	elseif eventType == ccui.TouchEventType.canceled or eventType == ccui.TouchEventType.ended then
		self._bonusPanel:setVisible(false)
	end
end

function WorldPeaceClubBossBoss:refreshInnerAttrPanel()
	local list = self:getRecoverDesc()

	if #list == 0 then
		self._bonusPanel:setVisible(false)

		return
	end

	local textLabel = self._bonusPanel:getChildByName("text")

	textLabel:setVisible(false)

	local width = 0
	local height = 23
	local posY = 175

	self._bonusPanel:getChildByName("panel"):removeAllChildren()

	for i = 1, #list do
		local text = textLabel:clone()

		text:getVirtualRenderer():setDimensions(400, 0)
		text:setVisible(true)
		text:addTo(self._bonusPanel:getChildByName("panel"))
		text:setTag(12138)
		text:setString(list[i])
		text:setPositionY(posY - (i - 1) * 30)

		width = math.max(width, text:getContentSize().width)
		height = height + 30
	end

	self._bonusPanel:getChildByName("imageBg"):setContentSize(cc.size(width + 40, height))

	return height
end

function WorldPeaceClubBossBoss:updateRecover()
	if not self._recoverNode then
		return
	end

	if not self._data:getCurHp() then
		return
	end

	self._recoverNode:setVisible(false)

	self._recoverTimes = self._data:getBuffCdRecoverTimes()
	self._buffCdBeginTime = self._data:getBuffCdBeginTime()
	self._buffCd = self._recoverNode:getChildByName("cd")

	local cd = self._data:getBuffCd()
	local icon = cd.Icon

	if icon then
		self._recoverNode:getChildByName("di"):loadTexture(icon .. ".png", ccui.TextureResType.plistType)
	end

	local touchPanel = self._recoverNode:getChildByFullName("touchpanel")

	touchPanel:setTouchEnabled(true)
	touchPanel:addTouchEventListener(function(sender, eventType)
		self:onClickBonus(sender, eventType)
	end)

	self._curTime = os.time()

	local function callFunc()
		if self._data:getCurHp() >= self._data:getMaxHp() then
			self._recoverNode:setVisible(false)

			return
		end

		local buffCdBeginTime = self._data:getBuffCdBeginTime()

		if self._buffCdBeginTime ~= buffCdBeginTime then
			self._buffCdBeginTime = buffCdBeginTime
			self._recoverTimes = self._data:getBuffCdRecoverTimes()
		end

		if math.floor(self._recoverTimes) <= 0 then
			self._recoverNode:setVisible(false)

			if cd.Heal and os.time() - self._curTime > 10 then
				self._progressTimer.node3:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(function()
					self._progressTimer.node3:stopAllActions()
					self:runHp()
				end)))

				self._curTime = os.time()
			end
		else
			self._recoverNode:setVisible(true)
			self._buffCd:setString(TimeUtil:formatTime("${H}:${M}:${S}", math.max(self._recoverTimes, 0)))

			self._recoverTimes = self._recoverTimes - 1
		end
	end

	self._recoverNode:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(callFunc))))
end

function WorldPeaceClubBossBoss:setHpStage(data)
	if not data.getHpStage then
		return
	end

	self._hpStage = data:getHpStage()
	self._barBg = self._content:getChildByName("barBg")

	if not self._barBg then
		return
	end

	self._hpStageTxt = self._content:getChildByName("hpStage")

	self._barBg:setLocalZOrder(2)
	self._hpStageTxt:setLocalZOrder(3)
	self._hpbar:setVisible(false)

	local s = self._barBg:getContentSize()
	local barImage = cc.Sprite:createWithSpriteFrameName("CB_di_xuetiao2.png")
	local progressTimer = cc.ProgressTimer:create(barImage)

	progressTimer:setAnchorPoint(0, 0)
	progressTimer:setPosition(0, 0)
	progressTimer:addTo(self._barBg)
	progressTimer:setType(1)
	progressTimer:setMidpoint(cc.p(0, 0))
	progressTimer:setBarChangeRate(cc.p(1, 0))
	progressTimer:setScaleX(s.width / 89)
	progressTimer:setScaleY(s.height / 8)

	self._progressTimer = progressTimer
	self._progressTimer.node1 = cc.Node:create()

	self._progressTimer.node1:addTo(self._progressTimer)

	self._progressTimer.node2 = cc.Node:create()

	self._progressTimer.node2:addTo(self._progressTimer)

	self._progressTimer.node3 = cc.Node:create()

	self._progressTimer.node3:addTo(self._progressTimer)

	self._stageMaxHp = self._hpStage.stageMaxHp

	if not self._data:getCurHp() then
		return
	end

	self._allActionTime = 0.4

	self:runHp()
end

function WorldPeaceClubBossBoss:initHp()
	self._progressTimer.node1:stopAllActions()
	self._progressTimer.node2:stopAllActions()
	self._progressTimer:stopAllActions()

	self._curStageNum = math.ceil(self._data:getCurHp() / self._stageMaxHp)
	self._curStageHp = self._data:getCurHp() % self._stageMaxHp
	self._curStageRate = self._curStageHp / self._stageMaxHp * 100

	self._progressTimer:setPercentage(self._curStageRate == 0 and 100 or self._curStageRate)
	self._hpStageTxt:setString("x" .. self._curStageNum)

	self._tempCurHp = self._data:getCurHp()
end

function WorldPeaceClubBossBoss:runHp()
	self:initHp()

	local function runAction(func)
		local showListData = self:getShowList()
		local stageCount = #showListData

		if stageCount < 1 then
			return
		end

		local actions = self:getShowListAction(showListData, self._allActionTime / stageCount)

		actions[#actions + 1] = cc.CallFunc:create(function()
			local percentage = self._progressTimer:getPercentage()

			self._progressTimer:setPercentage(percentage == 0 and self._curStageNum < 1 and 100 or percentage)

			if self._data:getCurHp() <= 0 then
				self._hpStageTxt:setString("x0")
			end
		end)

		self._progressTimer:runAction(cc.Sequence:create(unpack(actions)))

		self._preStageCount = stageCount
	end

	self:checkActions(0, runAction)
end

function WorldPeaceClubBossBoss:checkHpChange()
	local function func()
		local changeHp = self._tempCurHp - self._data:getCurHp()

		if changeHp > 0 then
			self._progressTimer.node2:stopAllActions()
			self:runHp()
		end
	end

	self._progressTimer.node2:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(func))))
end

function WorldPeaceClubBossBoss:checkActions(delay, func)
	local function callFunc()
		if func then
			func(func)
		end
	end

	self._progressTimer.node1:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(delay), cc.CallFunc:create(callFunc), cc.DelayTime:create(self._allActionTime))))
end

local idx = 1

function WorldPeaceClubBossBoss:getShowListAction(showList, actionTime)
	local actions = {}

	for i = 1, #showList do
		local data = showList[i]

		actions[#actions + 1] = cc.Sequence:create(cc.ProgressFromTo:create(actionTime, data.cur, data.target), cc.CallFunc:create(function()
			if math.floor(data.target) == 0 then
				idx = idx + 1

				self._barBg:loadTexture(idx % 2 == 0 and "CB_di_xuetiao2.png" or "guild_boss_img_xt.png", ccui.TextureResType.plistType)
				self._progressTimer:setSprite(cc.Sprite:createWithSpriteFrameName(idx % 2 == 0 and "guild_boss_img_xt.png" or "CB_di_xuetiao2.png"))

				self._curStageNum = self._curStageNum - 1
				self._curStageNum = math.max(0, self._curStageNum)

				self._hpStageTxt:setString("x" .. self._curStageNum)
				self._barBg:setVisible(self._curStageNum > 1)
			end
		end))
	end

	return actions
end

function WorldPeaceClubBossBoss:getShowList(notReset)
	local changeHp = self._tempCurHp - self._data:getCurHp()

	if changeHp <= 0 then
		self._tempCurHp = self._data:getCurHp()

		return {}
	end

	self._curStageHp = self._progressTimer:getPercentage() * self._stageMaxHp / 100

	local showList = {}

	if changeHp <= self._curStageHp then
		showList[#showList + 1] = {
			cur = self._progressTimer:getPercentage(),
			target = self._progressTimer:getPercentage() - changeHp / self._stageMaxHp * 100,
			hp = changeHp
		}
	else
		while changeHp > 0 do
			if #showList == 0 and self._curStageHp ~= 0 then
				showList[#showList + 1] = {
					target = 0,
					cur = self._progressTimer:getPercentage()
				}
				changeHp = changeHp - self._curStageHp
			else
				changeHp = changeHp - self._stageMaxHp
				showList[#showList + 1] = changeHp < 0 and {
					cur = 100,
					target = 100 - (changeHp + self._stageMaxHp) / self._stageMaxHp * 100
				} or {
					cur = 100,
					target = 0
				}
			end
		end
	end

	self._tempCurHp = self._data:getCurHp()

	return showList
end

function WorldPeaceClubBossBoss:refreshView(data)
	self._occupations = {}

	for k, v in pairs(self._config.BattleClassLimit or {}) do
		self._content:getChildByName("type" .. k):removeAllChildren()

		local occupationImg = IconFactory:getPartyPath(v, "building")
		local occupation = ccui.ImageView:create(occupationImg, 0)

		occupation:setLocalZOrder(2)
		occupation:setScale(0.8)
		occupation:addTo(self._content:getChildByName("type" .. k))

		self._occupations[#self._occupations + 1] = occupation

		occupation:setVisible(true)
		self._content:getChildByName("type" .. k):setLocalZOrder(2)
	end

	dump(self._config.Hero, "Hero____Hero")

	local modelId = IconFactory:getRoleModelByKey("HeroBase", self._config.Hero)
	local icon = IconFactory:getRoleIconPath(modelId)
	local bossIcon = self._content:getChildByName("icon")

	if bossIcon then
		bossIcon:loadTexture(icon, 0)
	end

	local heroCfg = ConfigReader:getRecordById("HeroBase", self._config.Hero)

	self._nameScale = self._name:getScale()

	self._name:setVisible(true)
	self._name:setString(Strings:get(heroCfg.Name))

	local index = self._config.HeroFrame
	local campFrame = self._content:getChildByName("bg")

	campFrame:loadTexture(CampFrame[index], 1)

	local campBgFrame = self._content:getChildByName("di")

	campBgFrame:loadTexture(CampBgFrame[index], 1)
end

function WorldPeaceClubBossBoss:applyColorTransform(args, displaynode)
	local trans = {}

	table.deepcopy(self._baseColorTrans, trans)

	local mults, offsets = trans.mults, trans.offsets

	displaynode:setSaturation(args.saturation or 0)
	displaynode:setContrast(args.contrast or 0)
	displaynode:setColorTransform(ColorTransform(args.r or mults.x, args.g or mults.y, args.b or mults.z, args.a or mults.w, args.o_r or offsets.x, args.o_g or offsets.y, args.o_b or offsets.z, args.o_a or offsets.w))
end

function WorldPeaceClubBossBoss:setRadio(radio)
	self._Radio = radio
end

function WorldPeaceClubBossBoss:setPosition(position)
	self._position = position

	self._displayNode:setPosition(position)
end

function WorldPeaceClubBossBoss:getPosition()
	return self._position
end

function WorldPeaceClubBossBoss:onPrepare()
	self:setState(K_WORLD_MEMBER_SATGE.Idle)
end

function WorldPeaceClubBossBoss:onAttack()
	return
end

function WorldPeaceClubBossBoss:getScale()
	return self._scale
end

function WorldPeaceClubBossBoss:setScale(scale)
	self._scale = scale

	self._displayNode:setScale(scale)
end

function WorldPeaceClubBossBoss:onIdle()
	self:setState(K_WORLD_MEMBER_SATGE.Idleing)
end

function WorldPeaceClubBossBoss:onDie()
	return
end

function WorldPeaceClubBossBoss:createFlyLabel(pos, value)
	local fnt = ccui.TextBMFont:create(value or 0, "asset/font/minigame_font.fnt")

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

function WorldPeaceClubBossBoss:onHit(detail)
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
		hitflash:setScale(detail.actor:getDisplayNode():getScale() * k_EFFECT_SCALE)
		hitflash:addTo(effectLayer)
		hitflash:setPosition(detail.pos)
		hitflash:addEndCallback(function()
			hitflash:removeFromParent()
		end)
		hitflash:setRotation(180 - detail.actor:getRadio())
	end

	if not detail.atk then
		local atk = detail.actor:getAtk()

		atk = atk or 0

		if atk > 0 then
			local label = self:createFlyLabel(detail.pos, atk)

			label:addTo(effectLayer)
			label:setScale(self:getScale())
		end

		if self._isPlayingHit then
			return true
		end

		local displayNode = self._displayNode

		if self._protects[1] then
			displayNode = self._protects[1]:getDisplayNode()
		end

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
			self._isPlayingHit = false
		end))

		if not tolua.isnull(displayNode) then
			displayNode:runAction(action)
		end

		self._isPlayingHit = true
	end
end

function WorldPeaceClubBossBoss:addEnemy(enemy)
	self._enemys[#self._enemys + 1] = enemy
end

function WorldPeaceClubBossBoss:update()
	self:checkOverView()
	self:checkInViewPort()
end

function WorldPeaceClubBossBoss:checkOverView()
	if not self._transformDirty then
		return
	end

	local containner = self._factory:getDisplayStage():getChildByFullName("map"):getInnerContainer()

	if self._factory:getPaceGame():getDisplayMode() == K_RENDER_DISPLAYMODE.MULTILEVEL then
		if containner:getScale() < k_MULTILEVEL01 then
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

function WorldPeaceClubBossBoss:checkInViewPort()
	if not self._transformDirty then
		return
	end

	local containner = self._factory:getDisplayStage():getChildByFullName("map"):getInnerContainer()

	local function check(node)
		local w_pos = cc.p(node:getParent():convertToWorldSpace(cc.p(node:getPosition())))
		local director = cc.Director:getInstance()
		local winSize = director:getWinSize()
		local isin = cc.rectContainsPoint(k_VIEW_PORT, w_pos)

		node:setVisible(isin)

		if node.forceHide then
			node:setVisible(false)
		end
	end

	if containner:getScale() < k_MULTILEVEL01 then
		self._transformDirty = false

		return
	end

	check(self._displayNode)

	for k, v in pairs(self:getAssigedNodes() or {}) do
		check(v.node)
	end

	self._transformDirty = false
end

WorldPeaceStageOneBoss = class("WorldPeaceStageOneBoss", WorldPeaceClubBossBoss)

function WorldPeaceStageOneBoss:refreshView(data)
	self._occupations = {}

	local showCount = math.min(#self._config.Class, 5)

	for k = 1, showCount do
		local type = self._config.Class[k]

		self._content:getChildByName("type" .. k):removeAllChildren()

		local animPath = GameStyle:getHeroOccupationAnim(type)
		local occupation = cc.MovieClip:create(animPath)

		occupation:setScale(0.6)
		occupation:addTo(self._content:getChildByName("type" .. k))

		self._occupations[#self._occupations + 1] = occupation

		occupation:setVisible(true)

		local pos = posOffset1[showCount][k]

		self._content:getChildByName("type" .. k):setPosition(cc.p(pos.x + 50, pos.y))
		self._content:getChildByName("type" .. k):setLocalZOrder(2)
	end

	local modelId = IconFactory:getRoleModelByKey("HeroBase", self._config.Hero)

	dump(modelId, "modelId____modelId")

	local icon = IconFactory:getRoleIconPath(modelId)

	self._bossIcon:loadTexture(icon, 0)

	self._nameScale = self._name:getScale()

	self._name:setVisible(true)
	self._name:setString(Strings:get(self._config.Name))

	if not self._content.bgAnim then
		self._content.bgAnim = cc.MovieClip:create("eff_touxiangkuang_boss_qiuqiulianxian")

		self._content.bgAnim:addTo(self._content)
	end

	local campBgFrame = self._content:getChildByName("di")

	campBgFrame:loadTexture(CampBgFrame[index], 1)
end

function WorldPeaceStageOneBoss:createFlyLabel(pos, value)
	local fnt = ccui.TextBMFont:create(value or 0, "asset/font/minigame_font.fnt")

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

function WorldPeaceStageOneBoss:getCsb()
	return "asset/ui/ClubBossStageTwo.csb"
end

function WorldPeaceStageOneBoss:getRecoverDesc()
	local buffConfig = self._data:getBuffCd()

	return {
		Strings:get("ClubBoss_Tips_06", {
			Time = buffConfig.Time,
			num = tostring(string.format("%02.d", buffConfig.Heal * 100)) .. "%"
		})
	}
end

WorldPeaceStageTwoBoss = class("WorldPeaceStageTwoBoss", WorldPeaceClubBossBoss)

function WorldPeaceStageTwoBoss:refreshView(data)
	self._occupations = {}

	local showCount = math.min(#self._config.Class, 5)

	for k = 1, showCount do
		local type = self._config.Class[k]

		self._content:getChildByName("type" .. k):removeAllChildren()

		local animPath = GameStyle:getHeroOccupationAnim(type)
		local occupation = cc.MovieClip:create(animPath)

		occupation:setScale(0.6)
		occupation:addTo(self._content:getChildByName("type" .. k))

		self._occupations[#self._occupations + 1] = occupation

		occupation:setVisible(true)

		local pos = posOffset1[showCount][k]

		self._content:getChildByName("type" .. k):setPosition(cc.p(pos.x + 50, pos.y))
		self._content:getChildByName("type" .. k):setLocalZOrder(2)
	end

	local modelId = IconFactory:getRoleModelByKey("HeroBase", self._config.Hero)
	local icon = IconFactory:getRoleIconPath(modelId)

	self._bossIcon:loadTexture(icon, 0)

	self._nameScale = self._name:getScale()

	self._name:setVisible(true)
	self._name:setString(Strings:get(self._config.Name))

	local index = self._config.HeroFrame
	local campFrame = self._content:getChildByName("bg")

	campFrame:setVisible(false)

	if not self._content.bgAnim then
		self._content.bgAnim = cc.MovieClip:create("eff_touxiangkuang_boss_qiuqiulianxian")

		self._content.bgAnim:addTo(self._content)
	end

	local campBgFrame = self._content:getChildByName("di")

	campBgFrame:loadTexture(CampBgFrame[index], 1)
end

function WorldPeaceStageTwoBoss:getCsb()
	return "asset/ui/ClubBossStageTwo.csb"
end

function WorldPeaceStageTwoBoss:getRecoverDesc()
	local buffConfig = self._data:getBuffCd()

	return {
		Strings:get("ClubBoss_Tips_07", {
			Time = buffConfig.Time
		})
	}
end

function WorldPeaceStageTwoBoss:createFlyLabel(pos, value)
	value = CurrencySystem:formatCurrencyString(value)

	local fnt = ccui.TextBMFont:create(value or 0, "asset/font/minigame_font.fnt")

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

ClubBossShow = class("ClubBossShow", objectlua.Object)

ClubBossShow:has("_displayNode", {
	is = "rw"
})

function ClubBossShow:getCsb()
	return "asset/ui/ClubBossShow.csb"
end

function ClubBossShow:initialize(id)
	dump(id, "id_____id")

	self._bossId = id
	self._config = ConfigReader:getRecordById("ClubBoss", self._bossId)
	self._displayNode = ccui.Widget:create()
	self._content = cc.CSLoader:createNode(self:getCsb())

	self._content:setScale(1)
	self._content:addTo(self._displayNode)

	if not self._content:getChildByName("playerIcon") then
		local bossIcon = self._content:getChildByName("icon")

		bossIcon:setScale(1.2)

		local stencil = ccui.ImageView:create("asset/stencil/zc_Clubbride_boss1.png")

		bossIcon:setPosition(0, 0)
		bossIcon:removeFromParent()

		sprite = ClippingNodeUtils.getClippingNodeByData({
			stencil = stencil,
			content = bossIcon
		})

		sprite:setPosition(cc.p(0, 0))
		sprite:addTo(self._content)
		sprite:setName("playerIcon")
		sprite:setScale(0.98)
	end

	local modelId = IconFactory:getRoleModelByKey("HeroBase", self._config.Hero)
	local icon = IconFactory:getRoleIconPath(modelId)
	local bossIcon = self._content:getChildByName("icon")

	if bossIcon then
		bossIcon:loadTexture(icon, 0)
	end

	super.initialize(self, id)
end
