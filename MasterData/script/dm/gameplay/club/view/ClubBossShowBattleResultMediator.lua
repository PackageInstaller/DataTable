-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubBossShowBattleResultMediator.lua

ClubBossShowBattleResultMediator = class("ClubBossShowBattleResultMediator", DmPopupViewMediator)

ClubBossShowBattleResultMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ClubBossShowBattleResultMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")

local kBtnHandlers = {}

function ClubBossShowBattleResultMediator:initialize()
	super.initialize(self)
end

function ClubBossShowBattleResultMediator:dispose()
	super.dispose(self)
end

function ClubBossShowBattleResultMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function ClubBossShowBattleResultMediator:enterWithData(data)
	self._data = data
	self._rewards = self._data.rewards or {}

	self:initWidget()
	self:refreshView()
end

function ClubBossShowBattleResultMediator:initWidget()
	AudioEngine:getInstance():playBackgroundMusic("Mus_Battle_Common_Over")

	self._main = self:getView():getChildByName("content")
	self._wordPanel = self._main:getChildByFullName("word")
	self._winPanel = self._main:getChildByFullName("panel_win")

	GameStyle:setCommonOutlineEffect(self._wordPanel:getChildByName("text"))
end

function ClubBossShowBattleResultMediator:refreshView()
	self._winPanel:setVisible(true)
	self._winPanel:setOpacity(0)

	local player = self._developSystem:getPlayer()
	local levelText = self._main:getChildByFullName("mLevelNum")

	levelText:setString(player:getLevel())

	local config = ConfigReader:getRecordById("LevelConfig", tostring(player:getLevel()))
	local expbar = self._main:getChildByFullName("LoadingBar_3")
	local percent = player:getExp() / config.PlayerExp * 100

	expbar:setPercent(percent)

	local pointName = self._winPanel:getChildByFullName("bossPanel.pointName")
	local hpbar = self._winPanel:getChildByFullName("bossPanel.LoadingBar")
	local rate = self._winPanel:getChildByFullName("bossPanel.rate")
	local anim = cc.MovieClip:create("tiaozhanjieshu_fubenjiesuan")

	anim:addEndCallback(function()
		anim:stop()
	end)
	anim:addTo(self._main:getChildByName("animNode"))
	anim:addCallbackAtFrame(9, function()
		self._wordPanel:fadeIn({
			time = 0.3333333333333333
		})
	end)
	anim:addCallbackAtFrame(17, function()
		self._winPanel:fadeIn({
			time = 0.2
		})
		self:initWinView()
	end)

	local winNode = anim:getChildByFullName("winNode")
	local winAnim = cc.MovieClip:create("shengliz_jingjijiesuan")

	winAnim:addEndCallback(function()
		winAnim:stop()
	end)
	winAnim:addTo(winNode)

	local winPanel = winAnim:getChildByFullName("winTitle")
	local title = ccui.ImageView:create("zyfb_tzjs.png", 1)

	title:addTo(winPanel)

	local viewType = self._clubSystem:getEnterClubBossBattleViewType()
	local team = self._clubSystem:getClubBossTeamInfo()

	self._clubBossInfo = self._developSystem:getPlayer():getClub():getClubBossInfo(viewType)

	local model

	dump(team.pointId, "team.pointId >>>>>>")

	local currentBossPoint = self._clubBossInfo:getBossPointsById(team.pointId)

	if currentBossPoint then
		local currentBlockConfig = currentBossPoint:getBlockConfig()

		if currentBlockConfig ~= nil and currentBlockConfig.PointHead ~= nil then
			model = currentBlockConfig.PointHead
		end

		local pointNameStr = Strings:get("clubBoss_33", {
			name = currentBossPoint:getPointName()
		})

		if currentBlockConfig.Name ~= nil then
			pointNameStr = pointNameStr .. "    " .. Strings:get(currentBlockConfig.Name)
		end

		pointName:setString(pointNameStr)

		if self._data.enemyRatio then
			local rateNum = self._data.enemyRatio * 100

			if rateNum < 1 and rateNum > 0 then
				rateNum = 1
			end

			hpbar:setPercent(rateNum)

			local maxHp = math.floor(currentBossPoint:getBossHp() + 0.5)
			local curHp = math.floor(maxHp * self._data.enemyRatio + 0.5)

			rate:setString(tostring(curHp) .. "/" .. tostring(maxHp))
		end
	end

	if model then
		local roleNode = anim:getChildByName("roleNode")

		model = IconFactory:getSpMvpBattleEndMid(model)

		local mvpSprite = IconFactory:createRoleIconSpriteNew({
			useAnim = true,
			frameId = "bustframe17",
			id = model
		})

		mvpSprite:addTo(roleNode)
		mvpSprite:setScale(0.8)
		mvpSprite:setPosition(cc.p(cc.p(-200, -200)))

		local roleId = ConfigReader:getDataByNameIdAndKey("RoleModel", model, "Hero")
		local heroMvpText = ""

		if roleId then
			heroMvpText = ConfigReader:getDataByNameIdAndKey("HeroBase", roleId, "MVPText")
		end

		if heroMvpText then
			self._wordPanel:setVisible(true)

			local text = self._wordPanel:getChildByName("text")

			text:setString(Strings:get(heroMvpText))

			local image1 = self._wordPanel:getChildByFullName("image1")
			local image2 = self._wordPanel:getChildByFullName("image2")
			local size = text:getContentSize()

			image2:setPosition(cc.p(image1:getPositionX() + size.width - 40, image1:getPositionY() - size.height + 80))
		else
			self._wordPanel:setVisible(false)
		end
	end
end

function ClubBossShowBattleResultMediator:initWinView()
	local rewardNode = self._winPanel:getChildByFullName("rewardNode")

	rewardNode:setScrollBarEnabled(false)
	rewardNode:removeAllItems()

	local i = 0

	local function showReward(rewards)
		if #rewards == 0 then
			return
		end

		local rewardData = table.remove(rewards, 1)

		i = i + 1

		local layout = ccui.Layout:create()

		layout:setContentSize(cc.size(78, 88))

		local icon = IconFactory:createRewardIcon(rewardData, {
			isWidget = true
		})

		icon:addTo(layout):center(layout:getContentSize())
		rewardNode:pushBackCustomItem(layout)
		icon:setScale(1)
		icon:setOpacity(0)

		local scale = cc.ScaleTo:create(0.2, 0.6)
		local fadeIn = cc.FadeIn:create(0.2)
		local spawn = cc.Spawn:create(scale, fadeIn)

		icon:runAction(spawn)
		performWithDelay(self:getView(), function()
			showReward(rewards)
		end, i * 0.05)
	end

	showReward(self._rewards)
end

function ClubBossShowBattleResultMediator:onTouchMaskLayer()
	AudioEngine:getInstance():playEffect("Se_Click_Close_2", false)
	self._clubSystem:clearEnterClubBossBattleMark()

	local data = {}
	local viewType = self._clubSystem:getEnterClubBossBattleViewType()

	dump(viewType, "ClubBossShowBattleResultMediator-viewType")

	if viewType == ClubHallType.kBoss then
		data.goToBoss = true
	end

	if viewType == ClubHallType.kActivityBoss then
		data.goToActivityBoss = true
	end

	self._clubSystem:clearEnterClubBossBattleViewType()
	BattleLoader:popBattleView(self, data, "ClubView", data)
end
