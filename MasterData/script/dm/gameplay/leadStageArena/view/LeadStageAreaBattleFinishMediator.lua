-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/leadStageArena/view/LeadStageAreaBattleFinishMediator.lua

LeadStageAreaBattleFinishMediator = class("LeadStageAreaBattleFinishMediator", DmPopupViewMediator, _M)

LeadStageAreaBattleFinishMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
LeadStageAreaBattleFinishMediator:has("_leadStageArenaSystem", {
	is = "r"
}):injectWith("LeadStageArenaSystem")

local kBtnHandlers = {
	mTouchLayout = "onTouchLayout"
}

function LeadStageAreaBattleFinishMediator:initialize()
	super.initialize(self)
end

function LeadStageAreaBattleFinishMediator:dispose()
	super.dispose(self)
end

function LeadStageAreaBattleFinishMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function LeadStageAreaBattleFinishMediator:enterWithData(data)
	self._canClose = false
	self._data = data
	self._nums = table.nums(self._data.fightRecordMap)

	self:setupView()
	self:initTopTitle()
end

function LeadStageAreaBattleFinishMediator:setupView()
	local bg = self:getView():getChildByName("bgPanel")
	local bgAnim = cc.MovieClip:create("bg_youxichuanzhandoujiesuan")

	bgAnim:addTo(bg)
	bgAnim:center(bg:getContentSize())
	bgAnim:gotoAndStop(0)

	self._bgAnim = bgAnim

	local bottom = self:getView():getChildByName("bottom")

	bottom:setVisible(false)

	local renderItem = self:getView():getChildByName("item_temp")
	local orgPosX, orgPosY = renderItem:getPosition()

	renderItem:setVisible(false)

	self._battleCtn = 0

	local sortData = {}

	for k, v in pairs(self._data.fightRecordMap) do
		sortData[#sortData + 1] = v
		v.index = tonumber(k)
	end

	table.sort(sortData, function(a, b)
		return a.index < b.index
	end)

	for k, v in pairs(sortData) do
		local item = renderItem:clone()

		item:setVisible(true)
		item:addTo(self:getView())
		item:setPosition(cc.p(orgPosX, orgPosY))

		orgPosY = orgPosY - renderItem:getContentSize().height

		if self._data.isQuickBattle then
			self:refreshQuickItem(item, k, v)
		else
			self:refreshItem(item, k, v)
		end

		self._battleCtn = self._battleCtn + 1
	end

	if self._battleCtn >= 3 then
		self._battleFinish = true
	else
		self._canClose = true
	end

	local leftRank = self:getView():getChildByFullName("title.left.rank")
	local rightRank = self:getView():getChildByFullName("title.right.rank")

	if self._data.isQuickBattle then
		self._oldWinTimes = 0
		self._oldLoseTimes = 0

		leftRank:loadTexture(string.format("stageArena_shuzi_lan%d.png", 0), ccui.TextureResType.plistType)
		rightRank:loadTexture(string.format("stageArena_shuzi_hon%d.png", 0), ccui.TextureResType.plistType)
		performWithDelay(self:getView(), function()
			self:refreshTopTitle(self._data.winTimes, self._data.loseTimes)
		end, 0.5)
	else
		local nums = self._nums - 1
		local wintimes = 0
		local losetimes = 0
		local rid = self._developSystem:getPlayer():getRid()

		for i = 1, nums do
			local v = sortData[i]

			if rid == v.winRid then
				wintimes = wintimes + 1
			else
				losetimes = losetimes + 1
			end
		end

		self._oldWinTimes = wintimes
		self._oldLoseTimes = losetimes

		leftRank:loadTexture(string.format("stageArena_shuzi_lan%d.png", wintimes), ccui.TextureResType.plistType)
		rightRank:loadTexture(string.format("stageArena_shuzi_hon%d.png", losetimes), ccui.TextureResType.plistType)
	end

	local player = self._developSystem:getPlayer()
	local leftName = self:getView():getChildByFullName("title.left.name")

	leftName:setString(player:getNickName())

	local leftCombat = self:getView():getChildByFullName("title.left.combat")

	leftCombat:setString(player:getMaxCombat())

	local rightName = self:getView():getChildByFullName("title.right.name")

	rightName:setString(self._data.rivalNickname)

	local rightCombat = self:getView():getChildByFullName("title.right.combat")

	rightCombat:setString(self._data.rivalCombat)

	local headIcon, oldIcon = IconFactory:createPlayerIcon({
		frameStyle = 1,
		clipType = 1,
		level = 1,
		id = player:getHeadId(),
		size = cc.size(93, 94),
		headFrameId = player:getCurHeadFrame()
	})
	local leftHead = self:getView():getChildByFullName("title.left.head")

	headIcon:setPosition(cc.p(50, 50))
	oldIcon:setScale(0.5)
	headIcon:addTo(leftHead)
	headIcon:center(leftHead:getContentSize())

	local headIcon, oldIcon = IconFactory:createPlayerIcon({
		frameStyle = 1,
		clipType = 1,
		level = 1,
		id = self._data.rivalHeadImage,
		size = cc.size(93, 94),
		headFrameId = self._data.rivalHeadFrame
	})
	local rightHead = self:getView():getChildByFullName("title.right.head")

	headIcon:setPosition(cc.p(50, 50))
	oldIcon:setScale(0.5)
	headIcon:addTo(rightHead)
	headIcon:center(rightHead:getContentSize())

	self._isWin = self._data.winTimes > self._data.loseTimes
end

function LeadStageAreaBattleFinishMediator:refreshQuickItem(item, k, itemdata)
	local animName = "item_youxichuanzhandoujiesuan"
	local bgAnim = cc.MovieClip:create(animName)

	bgAnim:addTo(self:getView())
	bgAnim:setPosition(item:getPosition())

	local animItem = bgAnim:getChildByName("item")

	item:changeParent(animItem)
	item:center(animItem:getContentSize())
	item:offset(-3, -10)

	local win_right = item:getChildByName("win_right")
	local win_left = item:getChildByName("win_left")

	win_left:setString(Strings:get("StageArena_Victory"))
	win_right:setString(Strings:get("StageArena_Victory"))
	win_right:setVisible(false)
	win_left:setVisible(false)

	if k == 1 then
		self._bgAnim:gotoAndPlay(20)
		self._bgAnim:addCallbackAtFrame(23, function()
			self._bgAnim:stop()
		end)
		self._bgAnim:setPlaySpeed(3)
	end

	bgAnim:gotoAndStop(0)

	if self._playIndex then
		self._playIndex = self._playIndex + 1 or 1
	end

	if self._data.isQuickBattle then
		performWithDelay(self:getView(), function()
			bgAnim:gotoAndPlay(0)
		end, 0.25 * (k - 1))
	end

	bgAnim:addCallbackAtFrame(8, function()
		AudioEngine:getInstance():playEffect("Se_Effect_BYYYC_Record", false)
	end)
	bgAnim:addCallbackAtFrame(12, function()
		bgAnim:stop()

		local winAnim = cc.MovieClip:create("win_youxichuanzhandoujiesuan")

		winAnim:gotoAndStop(7)

		local rid = self._developSystem:getPlayer():getRid()

		winAnim:addTo(item)

		if rid == itemdata.winRid then
			winAnim:setPosition(win_left:getPosition())
			winAnim:offset(50, -10)
		else
			winAnim:setPosition(win_right:getPosition())
			winAnim:offset(0, -7)
		end

		self._playIndex = self._playIndex - 1

		if self._playIndex <= 0 then
			if self._battleFinish then
				self:refreshBottom()
			else
				performWithDelay(self:getView(), function()
					self:delayCallClose()
				end, 3)
			end
		end
	end)
	self:initRoleShow(item, itemdata)
end

function LeadStageAreaBattleFinishMediator:refreshItem(item, k, itemdata)
	local bgAnim = cc.MovieClip:create((k == 3 or nil) and "item2_youxichuanzhandoujiesuan")

	bgAnim:addTo(self:getView())
	bgAnim:setPosition(item:getPosition())

	local animItem = bgAnim:getChildByName("item")

	item:changeParent(animItem)
	item:center(animItem:getContentSize())
	item:offset(-3, -10)

	if k == 3 then
		local itemclone = item:clone()
		local animItem = bgAnim:getChildByName("item2")

		itemclone:addTo(animItem)
		itemclone:center(animItem:getContentSize())
		itemclone:offset(-3, -10)
	end

	local win_right = item:getChildByName("win_right")
	local win_left = item:getChildByName("win_left")
	local live_cnt = item:getChildByName("livecount")

	win_left:setString(Strings:get("StageArena_Victory"))
	win_right:setString(Strings:get("StageArena_Victory"))
	win_right:setVisible(false)
	win_left:setVisible(false)
	bgAnim:gotoAndStop(0)

	if self._playIndex then
		self._playIndex = self._playIndex + 1 or 1
	end

	if k < self._nums then
		bgAnim:gotoAndStop(20)
		AudioEngine:getInstance():playEffect("Se_Effect_BYYYC_Record", false)

		local winAnim = cc.MovieClip:create("win_youxichuanzhandoujiesuan")

		winAnim:gotoAndStop(10)

		local rid = self._developSystem:getPlayer():getRid()

		winAnim:addTo(item)

		if rid == itemdata.winRid then
			winAnim:setPosition(win_left:getPosition())
			winAnim:offset(50, -10)
		else
			winAnim:setPosition(win_right:getPosition())
			winAnim:offset(0, -7)
		end

		self._playIndex = self._playIndex - 1

		if self._playIndex <= 0 then
			if self._battleFinish then
				self:refreshBottom()
			else
				performWithDelay(self:getView(), function()
					self:delayCallClose()
				end, 3)
			end
		end
	else
		bgAnim:gotoAndPlay(0)
		bgAnim:addCallbackAtFrame(8, function()
			AudioEngine:getInstance():playEffect("Se_Effect_BYYYC_Record", false)
		end)
		bgAnim:addCallbackAtFrame(20, function()
			bgAnim:stop()

			local winAnim = cc.MovieClip:create("win_youxichuanzhandoujiesuan")

			winAnim:setPlaySpeed(2)
			winAnim:addCallbackAtFrame(7, function()
				winAnim:stop()

				if self._data.isQuickBattle then
					-- block empty
				else
					self:refreshTopTitle(self._data.winTimes, self._data.loseTimes)
				end
			end)
			self._bgAnim:gotoAndPlay(20)
			self._bgAnim:addCallbackAtFrame(23, function()
				self._bgAnim:stop()
			end)
			self._bgAnim:setPlaySpeed(3)

			local rid = self._developSystem:getPlayer():getRid()

			winAnim:addTo(item)

			if rid == itemdata.winRid then
				winAnim:setPosition(win_left:getPosition())
				winAnim:offset(50, -10)
			else
				winAnim:setPosition(win_right:getPosition())
				winAnim:offset(0, -7)
			end

			self._playIndex = self._playIndex - 1

			if self._playIndex <= 0 then
				if self._battleFinish then
					self:refreshBottom()
				else
					performWithDelay(self:getView(), function()
						self:delayCallClose()
					end, 3)
				end
			end
		end)
	end

	self:initRoleShow(item, itemdata)
end

function LeadStageAreaBattleFinishMediator:initRoleShow(item, itemdata)
	local win_right = item:getChildByName("win_right")
	local win_left = item:getChildByName("win_left")
	local live_cnt = item:getChildByName("livecount")
	local roundnum = item:getChildByName("roundnum")

	win_right:setVisible(false)
	win_left:setVisible(false)

	local clip = item:getChildByName("clip")
	local masterSystem = self._developSystem:getMasterSystem()
	local roleModel = masterSystem:getMasterLeadStageModel(itemdata.masterId, (not itemdata.leadId or nil) and "")
	local sprite = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe6_1",
		id = roleModel
	})
	local heroIcon = clip:getChildByName("icon_1")

	heroIcon:addChild(sprite)
	sprite:center(heroIcon:getContentSize())
	sprite:offset(0, -50)

	local roleModel = masterSystem:getMasterLeadStageModel(itemdata.rivalMasterId, itemdata.rivalLeadId or "")
	local sprite = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe6_1",
		id = roleModel
	})
	local heroIcon = clip:getChildByName("icon_2")

	heroIcon:addChild(sprite)
	sprite:center(heroIcon:getContentSize())
	sprite:offset(50, -50)

	local liveStr = Strings:get("StageArena_PartyUI23", {
		num = itemdata.aliveHero
	})

	live_cnt:setString(liveStr)

	local cntDis = {
		"StageArena_PartyUI20",
		"StageArena_PartyUI21",
		"StageArena_PartyUI22"
	}

	roundnum:setString(Strings:get(cntDis[k]))

	if itemdata.leadId and itemdata.leadId ~= "" then
		local icon = IconFactory:createLeadStageIconVer(itemdata.leadId, itemdata.leadLv, {
			needBg = 0
		})
		local stageIcon = clip:getChildByName("stage_1")

		stageIcon:addChild(icon)
		icon:center(stageIcon:getContentSize())
		icon:setScale(0.85)
		icon:offset(0, 7)
	end

	if itemdata.rivalLeadId and itemdata.rivalLeadId ~= "" then
		local icon = IconFactory:createLeadStageIconVer(itemdata.rivalLeadId, itemdata.rivalLeadLv, {
			needBg = 0
		})
		local stageIcon = clip:getChildByName("stage_2")

		stageIcon:addChild(icon)
		icon:center(stageIcon:getContentSize())
		icon:setScale(0.85)
		icon:offset(0, 7)
	end
end

function LeadStageAreaBattleFinishMediator:initTopTitle()
	if self._data.isQuickBattle or self._nums == 1 then
		local titleView = self:getView():getChildByName("title")
		local orgY = titleView:getPositionY()

		titleView:setPositionY(titleView:getPositionY() - 50)
		titleView:setOpacity(0)
		titleView:setVisible(true)

		local action = cc.Sequence:create(cc.Spawn:create(cc.MoveTo:create(0.16, cc.p(titleView:getPositionX(), orgY)), cc.FadeIn:create(0.2)), cc.CallFunc:create(function()
			return
		end))

		titleView:runAction(action)
	end

	if self._data.isQuickBattle then
		self:refreshTitle()
	else
		performWithDelay(self:getView(), function()
			self:refreshTitle()
		end, 1)
	end
end

function LeadStageAreaBattleFinishMediator:refreshTopTitle(winTimes, loseTimes)
	local leftNode = self:getView():getChildByFullName("title.left")
	local rightNode = self:getView():getChildByFullName("title.right")
	local leftRank = self:getView():getChildByFullName("title.left.rank")
	local rightRank = self:getView():getChildByFullName("title.right.rank")

	if self._oldWinTimes ~= winTimes then
		leftRank:setVisible(false)

		local scoreAnim = cc.MovieClip:create("lan1_shuafen_youxichuanzhandoujiesuan")

		scoreAnim:addEndCallback(function()
			scoreAnim:stop()
		end)
		scoreAnim:addTo(leftNode)
		scoreAnim:setPosition(leftRank:getPosition())

		local mc_num = scoreAnim:getChildByFullName("mc_num1")
		local img = ccui.ImageView:create(string.format("stageArena_shuzi_lan%d.png", winTimes), ccui.TextureResType.plistType)

		img:addTo(mc_num):posite(0, 0)

		local mc_num = scoreAnim:getChildByFullName("mc_num2")
		local img = ccui.ImageView:create(string.format("stageArena_shuzi_lan%d.png", winTimes), ccui.TextureResType.plistType)

		img:addTo(mc_num):posite(0, 0)
	end

	if self._oldLoseTimes ~= loseTimes then
		rightRank:setVisible(false)

		local scoreAnim = cc.MovieClip:create("hong1_shuafen_youxichuanzhandoujiesuan")

		scoreAnim:addEndCallback(function()
			scoreAnim:stop()
		end)
		scoreAnim:addTo(rightNode)
		scoreAnim:setPosition(rightRank:getPosition())

		local mc_num = scoreAnim:getChildByFullName("mc_num1")
		local img = ccui.ImageView:create(string.format("stageArena_shuzi_hon%d.png", loseTimes), ccui.TextureResType.plistType)

		img:addTo(mc_num):posite(0, 0)

		local mc_num = scoreAnim:getChildByFullName("mc_num2")
		local img = ccui.ImageView:create(string.format("stageArena_shuzi_hon%d.png", loseTimes), ccui.TextureResType.plistType)

		img:addTo(mc_num):posite(0, 0)
	end
end

function LeadStageAreaBattleFinishMediator:refreshBottom()
	local bottomView = self:getView():getChildByName("bottom")
	local orgY = bottomView:getPositionY()

	bottomView:setPositionY(bottomView:getPositionY() - 50)
	bottomView:setOpacity(0)
	bottomView:setVisible(true)

	local action = cc.Sequence:create(cc.Spawn:create(cc.MoveTo:create(0.1, cc.p(bottomView:getPositionX(), orgY)), cc.FadeIn:create(0.1)), cc.CallFunc:create(function()
		self._canClose = true
	end))

	bottomView:runAction(action)

	local baseNum = bottomView:getChildByName("num")
	local extraNum = bottomView:getChildByName("num_extra")
	local rankNum = bottomView:getChildByName("ranknum")
	local up = bottomView:getChildByName("up")
	local addWinPer = 0

	if self._isWin then
		self._leadStageArena = self._leadStageArenaSystem:getLeadStageArena()

		local config = self._leadStageArena:getConfig()

		if config then
			if not config.SeasonRule.config then
				local value = {
					0,
					0
				}

				for k, v in pairs(self._data.fightRecordMap) do
					addWinPer = addWinPer + math.min(v.aliveHero * value[1], value[2])
				end
			end
		end
	end

	baseNum:setString(self._data.baseWinCoin)
	extraNum:setString(" +" .. addWinPer * 100 .. "%")
	rankNum:setString(self._data.increase)

	if self._data.increase >= 0 then
		up:loadTexture("zyfb_bg_ts.png", 1)
	else
		up:loadTexture("zyfb_bg_xj.png", 1)
	end
end

function LeadStageAreaBattleFinishMediator:refreshTitle()
	if table.nums(self._data.fightRecordMap) < 3 then
		return
	end

	local insertNode = self:getView():getChildByName("titlewin")

	if self._isWin then
		local winAnim = cc.MovieClip:create("title_youxichuanzhandoujiesuan")

		winAnim:addEndCallback(function()
			winAnim:stop()
		end)
		winAnim:addTo(insertNode)
		AudioEngine:getInstance():playEffect("Mus_Battle_Common_Win", false)
	else
		local failAnim = cc.MovieClip:create("shibaiz_jingjijiesuan")

		failAnim:addEndCallback(function()
			failAnim:stop()
		end)
		failAnim:setPositionY(-40)

		local losePanel = failAnim:getChildByFullName("loseTitle")
		local title = ccui.ImageView:create("zhandou_txt_fail.png", ccui.TextureResType.plistType)

		title:addTo(losePanel)
		failAnim:addTo(insertNode)
		failAnim:offset(0, -130)
		AudioEngine:getInstance():playEffect("Mus_Battle_Common_Lose", false)
	end
end

function LeadStageAreaBattleFinishMediator:delayCallClose()
	self:onTouchLayout(nil, ccui.TouchEventType.ended)
end

function LeadStageAreaBattleFinishMediator:onTouchLayout(sender, eventType)
	if eventType ~= ccui.TouchEventType.ended then
		return
	end

	if self._isClose then
		return
	end

	if not self._canClose then
		return
	end

	self:close()
	AudioEngine:getInstance():playEffect("Se_Click_Close_1", false)

	self._isClose = true

	if not self._battleFinish then
		BattleLoader:popBattleView(self)

		if self._data.reportMode then
			if self._data.playNextReport and self._data.playNextReportSender then
				self._data.playNextReport(self._data.playNextReportSender)
			end
		else
			self._leadStageArena = self._leadStageArenaSystem:getLeadStageArena()

			local rivalData = self._leadStageArena:getRival()

			self._leadStageArenaSystem:requestBeginBattle(rivalData.rivalId)
		end
	else
		if not self._data.isWatch then
			self._leadStageArenaSystem:setOldCoinAdd(self._data.baseWinCoin + self._data.extraWinCoin)
		end

		BattleLoader:popBattleView(self, {
			viewName = "LeadStageArenaMainView"
		})
	end
end
