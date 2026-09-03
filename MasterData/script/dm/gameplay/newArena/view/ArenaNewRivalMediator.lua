-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/newArena/view/ArenaNewRivalMediator.lua

ArenaNewRivalMediator = class("ArenaNewRivalMediator", DmPopupViewMediator, _M)

ArenaNewRivalMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ArenaNewRivalMediator:has("_systemKeeper", {
	is = "rw"
}):injectWith("SystemKeeper")
ArenaNewRivalMediator:has("_arenaNewSystem", {
	is = "r"
}):injectWith("ArenaNewSystem")

local kBtnHandlers = {
	["main.back"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onOkClicked"
	}
}

function ArenaNewRivalMediator:initialize()
	super.initialize(self)
end

function ArenaNewRivalMediator:dispose()
	super.dispose(self)
end

function ArenaNewRivalMediator:onRemove()
	super.onRemove(self)
end

function ArenaNewRivalMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._masterSystem = self._developSystem:getMasterSystem()
	self._bagSystem = self._developSystem:getBagSystem()
end

function ArenaNewRivalMediator:enterWithData(data)
	self._record = data
	self._index = data.index
	self._main = self:getView():getChildByFullName("main")
	self._starBg = self:getView():getChildByFullName("starBg")

	local actBtn = self._main:getChildByFullName("actBtn")

	actBtn:setVisible(self._index and self._index > 0)
	actBtn:addClickEventListener(function()
		self:onClickFight()
	end)
	self:initRoleInfo()
	self:initTeamInfo()
end

function ArenaNewRivalMediator:initRoleInfo()
	self._bg = self._main:getChildByFullName("Panel_info")

	local name = self._bg:getChildByFullName("desc")
	local combat = self._bg:getChildByFullName("text_combat")
	local playerIconBg = self._bg:getChildByName("Panel_44")
	local level = self._bg:getChildByName("text_lv")

	name:setString(self._record:getNickName())
	combat:setString(self._record:getCombat())
	level:setString(Strings:get("Common_LV_Text") .. self._record:getLevel())

	local headIcon, oldIcon = IconFactory:createPlayerIcon({
		clipType = 4,
		id = self._record:getHeadImg(),
		size = cc.size(93, 94),
		headFrameId = self._record:getHeadFrame()
	})

	headIcon:addTo(playerIconBg):center(playerIconBg:getContentSize())
	headIcon:setScale(0.8)
	oldIcon:setScale(0.5)
end

function ArenaNewRivalMediator:initTeamInfo()
	self._masterIconBg = self._bg:getChildByFullName("Panel_role")

	local master = self._record:getMaster()

	if master then
		local roleModel = self._masterSystem:getMasterLeadStageModel(master[1], self._record:getLeadStageId() or "")
		local info = {
			frameId = "bustframe6_1",
			id = roleModel
		}
		local masterIcon = IconFactory:createRoleIconSpriteNew(info)

		masterIcon:setAnchorPoint(cc.p(0, 0))
		masterIcon:setPosition(cc.p(0, -50))
		self._masterIconBg:addChild(masterIcon)

		local teamBg = self._bg:getChildByFullName("Panel_hero")
		local heros = self._record:getHeroes()

		for k, v in ipairs(heros) do
			local heroInfo = {
				id = v[1],
				rarity = tonumber(v[5]),
				star = tonumber(v[3]),
				awakenLevel = tonumber(v[7]),
				level = tonumber(v[2]),
				identityAwakenLevel = tonumber(v[8])
			}
			local petNode = IconFactory:createHeroLargeIcon(heroInfo, {
				hideLevel = true,
				hideStarBg = true,
				hideName = true
			})

			petNode:setScale(0.5)

			local xindex = k % 5 == 0 and 5 or k % 5
			local x = xindex * 100 - 36
			local y = k <= 5 and 140 or 40

			petNode:setPosition(cc.p(x, y))
			petNode:addTo(teamBg)
		end

		local node = self._bg:getChildByFullName("node_leadStage")

		node:removeAllChildren()

		local icon = IconFactory:createLeadStageIconHor(self._record:getLeadStageId(), self._record:getLeadStageLevel())

		if icon then
			icon:setScale(1.2)
			icon:addTo(node)
		end
	end
end

function ArenaNewRivalMediator:onOkClicked()
	self:close()
end

function ArenaNewRivalMediator:onClickFight()
	local remainTimes = self._developSystem:getPlayer():getChessArena().challengeTime.value

	if remainTimes <= 0 then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:buyChallageNum()

		return
	end

	local view = self:getInjector():getInstance("ArenaNewTeamView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		stageType = StageTeamType.CHESS_ARENA_ATK,
		rivalIndex = self._index
	}))
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self:close()
end

local diamondCost = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClassArena_BuyTimesCost", "content")

function ArenaNewRivalMediator:buyChallageNum()
	local data = {
		isRich = true,
		title = Strings:get("Tip_Remind"),
		title1 = Strings:get("UITitle_EN_Tishi"),
		content = Strings:get("ClassArena_UI41", {
			num = diamondCost,
			fontName = TTF_FONT_FZYH_M
		}),
		sureBtn = {},
		cancelBtn = {}
	}
	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" then
			outSelf:onclickOk()
		end
	end

	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function ArenaNewRivalMediator:onclickOk()
	local hasnum = self._bagSystem:getItemCount(CurrencyIdKind.kDiamond)
	local canBuy = hasnum >= diamondCost

	if canBuy then
		-- block empty
	else
		local outSelf, delegate = self, {}

		function delegate:willClose(popupMediator, data)
			if data.response == "ok" then
				outSelf._shopSystem:tryEnter({
					shopId = "Shop_Mall"
				})
			elseif data.response == "cancel" then
				-- block empty
			elseif data.response == "close" then
				-- block empty
			end
		end

		local data = {
			title1 = "Tips",
			title = Strings:get("Tip_Remind"),
			content = Strings:get("CooperateBoss_DimondTip"),
			sureBtn = {},
			cancelBtn = {}
		}
		local view = self:getInjector():getInstance("AlertView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data, delegate))
	end
end
