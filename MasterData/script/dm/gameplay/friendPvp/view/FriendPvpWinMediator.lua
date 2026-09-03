-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/friendPvp/view/FriendPvpWinMediator.lua

FriendPvpWinMediator = class("FriendPvpWinMediator", DmPopupViewMediator, _M)

FriendPvpWinMediator:has("_friendPvpSystem", {
	is = "r"
}):injectWith("FriendPvpSystem")
FriendPvpWinMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {}
local pos = {
	{
		cc.p(463, 30)
	},
	{
		cc.p(383, 30),
		cc.p(553, 30)
	},
	{
		cc.p(293, 30),
		cc.p(463, 30),
		cc.p(633, 30)
	},
	{
		cc.p(213, 30),
		cc.p(383, 30),
		cc.p(553, 30),
		cc.p(723, 30)
	},
	{
		cc.p(123, 30),
		cc.p(293, 30),
		cc.p(463, 30),
		cc.p(633, 30),
		cc.p(803, 30)
	}
}

function FriendPvpWinMediator:initialize()
	super.initialize(self)
end

function FriendPvpWinMediator:dispose()
	if self._timeScheduler then
		LuaScheduler:getInstance():unschedule(self._timeScheduler)

		self._timeScheduler = nil
	end

	super.dispose(self)
end

function FriendPvpWinMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("bg.button_panel.button_exit", OneLevelMainButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickBack, self)
		}
	})
end

function FriendPvpWinMediator:enterWithData(data)
	self._result = data.result
	self._playerInfos = data.playerInfo
	self._type = data.type
	self._rewards = data.rewards

	self:initWigetInfo()
	self:setupView()
end

function FriendPvpWinMediator:initWigetInfo()
	local bg = self:getView():getChildByName("bg")
	local winerBg = bg:getChildByName("own_win")

	self._heroPanel = winerBg:getChildByFullName("heroPanel")
	self._winerName = bg:getChildByFullName("node_1.action_node_1.winer_name")
	self._winerIconBg = bg:getChildByFullName("node_1.action_node_1.winer_icon_bg.icon_bg")
	self._loserName = bg:getChildByFullName("node_2.action_node_2.winer_name")
	self._loserIconBg = bg:getChildByFullName("node_2.action_node_2.winer_icon_bg.icon_bg")

	local winTitle = bg:getChildByFullName("node_1.action_node_1.winTitle")
	local winAnim = cc.MovieClip:create("shengliz_jingjijiesuan")

	winAnim:addTo(winTitle)
	winAnim:addEndCallback(function()
		winAnim:stop()
	end)

	local winPanel = winAnim:getChildByFullName("winTitle")
	local title = ccui.ImageView:create("zhandou_txt_win.png", ccui.TextureResType.plistType)

	title:addTo(winPanel)

	local loseTitle = bg:getChildByFullName("node_2.action_node_2.loseTitle")
	local loseAnim = cc.MovieClip:create("shibaiz_jingjijiesuan")

	loseAnim:addTo(loseTitle)
	loseAnim:addEndCallback(function()
		loseAnim:stop()
	end)

	local losePanel = loseAnim:getChildByFullName("loseTitle")
	local title = ccui.ImageView:create("zhandou_txt_fail.png", ccui.TextureResType.plistType)

	title:addTo(losePanel)
	CommonUtils.runActionEffectByRootNode(bg, "PvPVictoryEffect")
end

function FriendPvpWinMediator:setupView()
	local winnerId = self._result.winner

	self._winnerId = winnerId

	local winnerInfo, loserInfo

	for k, v in pairs(self._playerInfos) do
		if k == winnerId then
			winnerInfo = v
		else
			loserInfo = v
		end
	end

	self._winerName:setString(winnerInfo.nickName)
	self._loserName:setString(loserInfo.nickName)

	local winnerHeadIcon = IconFactory:createPlayerIcon({
		clipType = 2,
		id = winnerInfo.headImage,
		size = cc.size(110, 110)
	})

	winnerHeadIcon:addTo(self._winerIconBg):center(self._winerIconBg:getContentSize())

	local lostHeadIcon = IconFactory:createPlayerIcon({
		clipType = 2,
		id = loserInfo.headImage,
		size = cc.size(110, 110)
	})

	lostHeadIcon:addTo(self._loserIconBg):center(self._loserIconBg:getContentSize())

	local winnerMasterId = winnerInfo.master[1]
	local masterSystem = self._developSystem:getMasterSystem()
	local masterData = masterSystem:getMasterById(winnerMasterId)

	model = masterData:getModel()

	self:createMvpHeros(model)
end

function FriendPvpWinMediator:createMvpHeros(defMasterModel)
	self._heroPanel:removeAllChildren()

	local role = self._result.summary
	local playersInfo

	if role then
		playersInfo = role.players
	end

	local heroes = {}
	local master = {}

	if playersInfo and playersInfo[self._winnerId] then
		local unitSummary = playersInfo[self._winnerId].unitSummary

		for key, value in pairs(unitSummary) do
			local num = 0

			if value.type == "hero" then
				if value.cure then
					num = num + value.cure
				end

				if value.damage then
					num = num + value.damage
				end

				local type = ConfigReader:getDataByNameIdAndKey("RoleModel", value.model, "Type")

				if num ~= 0 and type == RoleModelType.kHero then
					heroes[#heroes + 1] = {
						model = value.model,
						num = num
					}
				end
			elseif value.type == "master" then
				master[#master + 1] = {
					model = value.model
				}
			end
		end

		table.sort(heroes, function(a, b)
			return a.num > b.num
		end)
	else
		master[#master + 1] = {
			model = defMasterModel
		}
	end

	if #heroes == 0 then
		local heroAnim = RoleFactory:createHeroAnimation(master[1].model)

		heroAnim:setAnchorPoint(cc.p(0.5, 0))
		heroAnim:addTo(self._heroPanel)
		heroAnim:setScale(0.75)
		heroAnim:setPosition(pos[1][1])

		if master[1].model == "Model_LFKLFTe_DGun" then
			heroAnim:setScale(0.35)
			heroAnim:offset(-270, 40)
		end
	else
		local showHeroNum = math.min(#heroes, 5)

		for i = 1, showHeroNum do
			local heroAnim, jsonPath = RoleFactory:createHeroAnimation(heroes[i].model)

			heroAnim:setAnchorPoint(cc.p(0.5, 0))
			heroAnim:addTo(self._heroPanel)
			heroAnim:setScale(0.75)
			heroAnim:setOpacity(0)
			heroAnim:setTag(i)

			local position = pos[showHeroNum][i]

			heroAnim:setPosition(cc.p(position.x - 30, position.y))

			local moveto = cc.MoveTo:create(0.2, cc.p(position.x, position.y))
			local spawn = cc.Spawn:create(cc.FadeIn:create(0.2), moveto)
			local seq = cc.Sequence:create(cc.DelayTime:create((showHeroNum - i) * 0.1), spawn)

			heroAnim:runAction(seq)
		end
	end
end

function FriendPvpWinMediator:updateCDTimeScheduler()
	if self._timeScheduler == nil then
		self._timeScheduler = LuaScheduler:getInstance():schedule(function()
			self:doClose()
		end, 10, false)
	end
end

function FriendPvpWinMediator:doClose()
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

function FriendPvpWinMediator:onClickBack(sender, eventType)
	self:doClose()
end
