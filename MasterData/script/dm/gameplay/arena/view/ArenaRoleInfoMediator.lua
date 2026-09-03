-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/arena/view/ArenaRoleInfoMediator.lua

ArenaRoleInfoMediator = class("ArenaRoleInfoMediator", DmPopupViewMediator, _M)

ArenaRoleInfoMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ArenaRoleInfoMediator:has("_arenaSystem", {
	is = "r"
}):injectWith("ArenaSystem")
ArenaRoleInfoMediator:has("_systemKeeper", {
	is = "rw"
}):injectWith("SystemKeeper")

local kArenaTimeCoin = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Arena_ItemUse", "content")
local kArenaCoin = CurrencyIdKind.kHonor
local kBtnHandlers = {}

function ArenaRoleInfoMediator:initialize()
	super.initialize(self)
end

function ArenaRoleInfoMediator:dispose()
	super.dispose(self)
end

function ArenaRoleInfoMediator:onRemove()
	super.onRemove(self)
end

function ArenaRoleInfoMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._bagSystem = self._developSystem:getBagSystem()
	self._masterSystem = self._developSystem:getMasterSystem()

	self:bindWidget("bg.battleBtn", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickFight, self)
		}
	})

	local widget = self:bindWidget("bg.quickbattleBtn", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickQuickFight, self)
		}
	})
end

function ArenaRoleInfoMediator:userInject()
	self._heroSystem = self._developSystem:getHeroSystem()
	self._player = self._developSystem:getPlayer()
end

function ArenaRoleInfoMediator:enterWithData(data)
	self._bg = self:getView():getChildByName("bg")
	self._battleBtn = self._bg:getChildByFullName("battleBtn")
	self._quickbattleBtn = self._bg:getChildByFullName("quickbattleBtn")
	self._ticketNode = self._bg:getChildByFullName("ticketNode")

	local unlock, tip = self._systemKeeper:isUnlock("ArenaRush")

	if not unlock then
		self._quickbattleBtn:setVisible(false)
		self._battleBtn:setPositionX(self._battleBtn:getPositionX() + 100)
		self._ticketNode:setPositionX(self._ticketNode:getPositionX() + 100)
	end

	local bgNode = self._bg:getChildByFullName("tipnode")

	bindWidget(self, bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onOkClicked, self)
		},
		title = Strings:get("RANK_PLAYER_VIEW_TITLE"),
		title1 = Strings:get("UITitle_EN_Wanjiaxinxi"),
		bgSize = {
			width = 760,
			height = 511
		},
		offsetForImage_bg3 = {
			diffX = 50,
			diffY = 0
		}
	})

	self._record = data.rival
	self._index = data.index

	self:initRoleInfo()
	self:initTeamInfo()
	self:setupClickEnvs()
end

function ArenaRoleInfoMediator:initRoleInfo()
	local name = self._bg:getChildByFullName("name")
	local combat = self._bg:getChildByFullName("fighting_bg.fighting_number")
	local playerIconBg = self._bg:getChildByName("icon_top")
	local level = self._bg:getChildByName("level")

	self._masterIconBg = self._bg:getChildByFullName("teamInfo.icon_bottom")

	name:setString(self._record:getNickName())
	combat:setString(self._record:getCombat())
	level:setString("Lv." .. self._record:getLevel())

	local headIcon = IconFactory:createPlayerIcon({
		clipType = 1,
		frameStyle = 2,
		id = self._record:getHeadImg(),
		size = playerIconBg:getContentSize()
	})

	headIcon:addTo(playerIconBg):center(playerIconBg:getContentSize())
	headIcon:setScale(1.1)
	level:offset(-4, -2)

	local extraCoin = self._bg:getChildByFullName("extraCoin")
	local node = extraCoin:getChildByFullName("node")
	local coin = IconFactory:createResourcePic({
		id = kArenaCoin
	})

	coin:addTo(node)

	local num = extraCoin:getChildByFullName("num")
	local score = self._record:getExtra()

	num:setString("+" .. score)

	local ticketNode = self._bg:getChildByFullName("ticketNode")
	local node = ticketNode:getChildByFullName("node")
	local coin = IconFactory:createResourcePic({
		id = kArenaTimeCoin
	})

	coin:addTo(node)
	coin:setScale(1.2)

	local num = ticketNode:getChildByFullName("num")

	num:setString("x1")
end

function ArenaRoleInfoMediator:initTeamInfo()
	local master = self._record:getMaster()

	if master then
		local roleModel = self._masterSystem:getMasterLeadStageModel(master[1], self._record:getLeadStageId() or "")
		local info = {
			frameId = "bustframe4_5",
			id = roleModel
		}
		local masterIcon = IconFactory:createRoleIconSpriteNew(info)

		masterIcon:setAnchorPoint(cc.p(0, 0))
		masterIcon:setPosition(cc.p(0, 0))
		self._masterIconBg:addChild(masterIcon)

		local teamBg = self._bg:getChildByFullName("teamInfo")
		local text = teamBg:getChildByName("text")

		text:setTextColor(cc.c4b(164, 164, 164, 33.15))
		text:enableOutline(cc.c4b(255, 255, 255, 255), 2)

		local heros = self._record:getHeroes()

		for k, v in pairs(heros) do
			local petBg = teamBg:getChildByName("pet_" .. k)
			local heroInfo = {
				id = v[1],
				rarity = tonumber(v[5])
			}
			local petNode = IconFactory:createHeroLargeNotRemoveIcon(heroInfo, {
				hideLevel = true,
				hideStar = true,
				hideName = true
			})

			petNode:setScale(0.35)
			petNode:addTo(petBg):center(petBg:getContentSize())
			petNode:setPositionY(petNode:getPositionY() - 5)
		end

		local node = self._bg:getChildByFullName("teamInfo.node_leadStage")

		node:removeAllChildren()

		local icon = IconFactory:createLeadStageIconHor(self._record:getLeadStageId(), self._record:getLeadStageLevel())

		if icon then
			icon:addTo(node)
		end
	end
end

function ArenaRoleInfoMediator:onOkClicked()
	self:close()
end

function ArenaRoleInfoMediator:onClickFight()
	local remainTimes = self._bagSystem:getItemCount(kArenaTimeCoin)

	if remainTimes <= 0 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Error_10001")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	self._arenaSystem:setShowViewAfterBattle("ArenaView")
	AudioEngine:getInstance():playEffect("Se_Click_Battle", false)
	self._arenaSystem:requestBeginBattle(self._index)
	self:close()
end

function ArenaRoleInfoMediator:onClickQuickFight()
	local remainTimes = self._bagSystem:getItemCount(kArenaTimeCoin)

	if remainTimes <= 0 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Error_10001")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	local view = self:getInjector():getInstance("ArenaQuickBattleView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		index = self._index
	}))
	self:close()
end

function ArenaRoleInfoMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local sequence = cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		local battleBtn = self._bg:getChildByName("battleBtn")

		storyDirector:setClickEnv("ArenaRoleInfoMediator.battleBtn", battleBtn, function(sender, eventType)
			self:onClickFight(sender, eventType)
		end)
		storyDirector:notifyWaiting("enter_ArenaRoleInfoMediator")
	end))

	self:getView():runAction(sequence)
end
