-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/friendPvp/view/FriendPvpLoseMediator.lua

FriendPvpLoseMediator = class("FriendPvpLoseMediator", DmPopupViewMediator, _M)

FriendPvpLoseMediator:has("_friendPvpSystem", {
	is = "r"
}):injectWith("FriendPvpSystem")
FriendPvpLoseMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	mTouchLayout = "onTouchLayout",
	["content.mRecruitBtn"] = "onClickRecruit",
	["content.mSkillBtn"] = "onClickSkill",
	["content.mEquipBtn"] = "onClickEquip"
}

function FriendPvpLoseMediator:initialize()
	super.initialize(self)
end

function FriendPvpLoseMediator:dispose()
	if self._timeScheduler then
		LuaScheduler:getInstance():unschedule(self._timeScheduler)

		self._timeScheduler = nil
	end

	super.dispose(self)
end

function FriendPvpLoseMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function FriendPvpLoseMediator:enterWithData(data)
	self._result = data.result
	self._playerInfos = data.playerInfo
	self._type = data.type
	self._rewards = data.rewards

	self:initWidget()
	self:refreshView()
end

function FriendPvpLoseMediator:initWidget()
	self._bg = self:getView():getChildByName("content")
	self._title = self._bg:getChildByName("title")
	self._tips = self._bg:getChildByName("tips")
	self._skillBtn = self._bg:getChildByName("mSkillBtn")
	self._equipBtn = self._bg:getChildByName("mEquipBtn")
	self._recruitBtn = self._bg:getChildByName("mRecruitBtn")
	self._wordPanel = self._bg:getChildByName("word")

	local tip = Strings:get("Battle_Failed4")

	self._tips:getChildByName("Text_55"):setString(tip)
end

function FriendPvpLoseMediator:refreshView()
	local anim = cc.MovieClip:create("shibai_zhandoujiesuan")
	local bgPanel = self._bg:getChildByName("heroAndBgPanel")

	anim:addCallbackAtFrame(45, function()
		anim:stop()
	end)
	anim:addTo(bgPanel):center(bgPanel:getContentSize())

	local svpSpritePanel = anim:getChildByName("heroSprite")

	self._title:runAction(cc.FadeIn:create(0.75))
	self:initSvpRole()
	svpSpritePanel:addChild(self._svpSprite)
	self._svpSprite:setPosition(cc.p(-200, -200))
	anim:gotoAndPlay(1)

	local posX1, posY1 = self._skillBtn:getPosition()
	local posX2, posY2 = self._equipBtn:getPosition()
	local posX3, posY3 = self._recruitBtn:getPosition()

	self._skillBtn:setPositionX(posX1 + 120)
	self._skillBtn:setOpacity(0)
	self._equipBtn:setPositionX(posX2 + 120)
	self._equipBtn:setOpacity(0)
	self._recruitBtn:setPositionX(posX3 + 120)
	self._recruitBtn:setOpacity(0)

	local action1 = cc.Spawn:create(cc.MoveTo:create(0.5, cc.p(posX1, posY1)), cc.FadeIn:create(0.4))
	local action2 = cc.Spawn:create(cc.MoveTo:create(0.5, cc.p(posX2, posY2)), cc.FadeIn:create(0.4))
	local action3 = cc.Spawn:create(cc.MoveTo:create(0.5, cc.p(posX3, posY3)), cc.FadeIn:create(0.4))

	self._skillBtn:runAction(action1)
	self._equipBtn:runAction(action2)
	self._recruitBtn:runAction(action3)
	self._tips:runAction(cc.FadeIn:create(0.6))
end

function FriendPvpLoseMediator:initSvpRole()
	local winnerId = self._result.winner

	self._winnerId = winnerId

	local loserInfo

	for k, v in pairs(self._playerInfos) do
		if k ~= winnerId then
			loserInfo = v

			break
		end
	end

	local loserMasterId = loserInfo.master[1]
	local role = self._result.summary
	local playersInfo

	if role then
		playersInfo = role.players
	end

	local masterSystem = self._developSystem:getMasterSystem()
	local masterData = masterSystem:getMasterById(loserMasterId)

	model = masterData:getModel()

	if playersInfo and playersInfo[loserInfo.id] then
		local mvpPoint = 0

		for k, v in pairs(playersInfo[loserInfo.id].unitSummary) do
			local roleType = ConfigReader:getDataByNameIdAndKey("RoleModel", v.model, "Type")

			if roleType == RoleModelType.kHero then
				local unitMvpPoint = 0
				local _unitDmg = v.damage

				if _unitDmg then
					unitMvpPoint = unitMvpPoint + _unitDmg
				end

				local _unitCure = v.cure

				if _unitCure then
					unitMvpPoint = unitMvpPoint + _unitCure
				end

				if mvpPoint < unitMvpPoint then
					mvpPoint = unitMvpPoint
					model = v.model
				end
			end
		end
	end

	model = IconFactory:getSpMvpBattleEndMid(model)
	self._svpSprite = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe17",
		id = model
	})
end

function FriendPvpLoseMediator:updateCDTimeScheduler()
	if self._timeScheduler == nil then
		self._timeScheduler = LuaScheduler:getInstance():schedule(function()
			self:doClose()
		end, 10, false)
	end
end

function FriendPvpLoseMediator:doClose()
	local friendPvp = self._friendPvpSystem:getFriendPvp()
	local hostId = friendPvp:getHostId()

	if hostId ~= nil then
		self:dispatch(Event:new(PVP_FINISH_WINNER, {
			winnerId = self._winnerId
		}))
		BattleLoader:popBattleView()
	else
		BattleLoader:popBattleView(self, {
			viewName = "homeView",
			userdata = {}
		})
	end
end

function FriendPvpLoseMediator:leaveWithData()
	self:onTouchLayout()
end

function FriendPvpLoseMediator:onTouchLayout(sender, eventType)
	self:doClose()
end

function FriendPvpLoseMediator:onClickSkill()
	local function func()
		local friendPvp = self._friendPvpSystem:getFriendPvp()
		local hostId = friendPvp:getHostId()

		self._friendPvpSystem:requestLeaveRoom(hostId)
		self:dispatch(Event:new(PVP_FINISH_WINNER, {
			winnerId = self._winnerId
		}))

		local data = {}

		data.viewName = "homeView"

		BattleLoader:popBattleView(self, data)

		local dispatcher = DmGame:getInstance()

		dispatcher:dispatch(ViewEvent:new(EVT_PUSH_VIEW, dispatcher:getInjector():getInstance("MasterMainView")))
	end

	self:leaveCheckPopView(func)
end

function FriendPvpLoseMediator:onClickRecruit()
	local function func()
		local friendPvp = self._friendPvpSystem:getFriendPvp()
		local hostId = friendPvp:getHostId()

		self._friendPvpSystem:requestLeaveRoom(hostId)
		self:dispatch(Event:new(PVP_FINISH_WINNER, {
			winnerId = self._winnerId
		}))

		local data = {}

		data.viewName = "homeView"

		BattleLoader:popBattleView(self, data)

		local dispatcher = DmGame:getInstance()

		dispatcher:dispatch(ViewEvent:new(EVT_PUSH_VIEW, dispatcher:getInjector():getInstance("RecruitView")))
	end

	self:leaveCheckPopView(func)
end

function FriendPvpLoseMediator:onClickEquip()
	local function func()
		local friendPvp = self._friendPvpSystem:getFriendPvp()
		local hostId = friendPvp:getHostId()

		self._friendPvpSystem:requestLeaveRoom(hostId)
		self:dispatch(Event:new(PVP_FINISH_WINNER, {
			winnerId = self._winnerId
		}))

		local data = {}

		data.viewName = "homeView"

		BattleLoader:popBattleView(self, data)

		local dispatcher = DmGame:getInstance()

		dispatcher:dispatch(ViewEvent:new(EVT_PUSH_VIEW, dispatcher:getInjector():getInstance("HeroShowListView")))
	end

	self:leaveCheckPopView(func)
end

function FriendPvpLoseMediator:leaveCheckPopView(ensureCallBack)
	local delegate = __associated_delegate__(self)({
		willClose = function(self, popUpMediator, data)
			if data.response == "ok" and ensureCallBack then
				ensureCallBack()
			end
		end
	})
	local data = {
		title = Strings:get("Tip_Remind"),
		content = Strings:get("Friend_Pvp_LeaveEnsure_Tips"),
		sureBtn = {},
		cancelBtn = {}
	}
	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end
