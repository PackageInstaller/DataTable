-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/rank/PetTop5RankView.lua

module("logic.extensions.handbook.view.rank.PetTop5RankView", package.seeall)

local PetTop5RankView = class("PetTop5RankView", ViewComponent)
local CurTab2TabId = {
	3,
	4,
	5,
	6
}
local PosNum = 5
local EffectPath = "20220701/paihangbang/fx_ui_llspaihang_jiemian.prefab"

function PetTop5RankView:ctor()
	PetTop5RankView.super.ctor(self)

	self._cacheParams = {}
end

function PetTop5RankView:unbindEvents()
	PetTop5RankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnGoto)
	GameUtil.rmClickHandler(self._btnGainPet)

	for _, tab in ipairs(self.tabs) do
		GameUtil.rmClickHandler(GameUtil.asBtn(tab))
	end

	GameUtil.rmClickHandler(GameUtil.asBtn(self._canGet))
end

function PetTop5RankView:bindEvents()
	PetTop5RankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnGoto, self._onClickGoto, self)
	GameUtil.addClickHandler(self._btnGainPet, self._onClickGainPet, self)

	for i, tab in ipairs(self.tabs) do
		GameUtil.addClickHandler(GameUtil.asBtn(tab), GameUtil.handler(self._onClickTab, self, i))
	end

	GameUtil.addClickHandler(GameUtil.asBtn(self._canGet), self._onClickReward, self)
end

function PetTop5RankView:buildUI()
	PetTop5RankView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtTitle = self:getTxt("leftTop/txtTitle")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self.tabs = {}

	for i = 1, #CurTab2TabId do
		table.insert(self.tabs, self:getGo(string.format("btns/btn_%d", i)))
	end

	self._roleCell = self:getGo("role")
	self._pos = {}

	for i = 1, PosNum do
		table.insert(self._pos, self:getGo(string.format("Pos/p%d", i)).transform.position)
	end

	self._btnGoto = self:getBtn("btnGoto")
	self._btnGotoGo = self:getGo("btnGoto")
	self._btnGainPet = self:getBtn("btnGainPet")
	self._btnGainPetGo = self:getGo("btnGainPet")
	self._txtMyRank = self:getTxt("myRank/txt")
	self._btnRank = self:getBtn("btnRank")
	self._bubble = self:getGo("bubble")
	self._reward = self:getGo("bubble/reward")
	self._txtBubble = self:getTxt("bubble/txtDesc")
	self._receive = self:getGo("bubble/reward/receive")
	self._container = self:getGo("container")
	self._txtTime = self:getTxt("time/txt")
	self._modelCam = self:getGo("modelCam")
	self._canGet = goutil.findChild(self._reward, "canGet")
	self._rewardItem = goutil.findChild(self._reward, "item")
	self._effectGo = self:getGo("effect")
	self._roles = {}
	self._avatars = {}
	self._impressionStickerRoot = self:getGo("impressionStickerRoot")

	goutil.setActive(self._roleCell, false)

	for i = 1, PosNum do
		local pos = self._pos[i]
		local role = goutil.cloneAndSetParent(self._roleCell, self._container.transform)

		self._roles[i] = role
		role.name = "role" .. i
		self._avatars[i] = PetTop5RankAvatar.AddOnce(role)

		goutil.setActive(role, false)
		GameUtil.setPos(role, pos.x, pos.y, pos.z)
	end
end

function PetTop5RankView:onExit()
	PetTop5RankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.HandBookPowerCheckRank, self._updateRank, self)
	PowerCheckController.instance:unregisterLocalNotify(PowerCheckController.RoleResLoadFinish, self._roleResLoadFinish, self)
	PetManualAgent.instance:removeHandler(PetManualAgent.GainRankPrizeRes, self._gainRankPrizeHandler)
	PetManualAgent.instance:removeHandler(PetManualAgent.RaceRankKudosRes, self._gainKudoHandler)
	LightMgr.instance:setUseModelLight(false)
	WaitingView.instance:hide(self)
	removetimer(self._closeWatingView, self)
	self._modelCam.transform:SetParent(self.mainGO.transform)
	GlobalModel.instance:visibleSceneHUDs(true)
	LightMgr.instance:setLightForNormalScene()

	for i = 1, PosNum do
		if self._roles[i] then
			local btnLike = goutil.findChildButtonComponent(self._roles[i], "btnLike")

			GameUtil.rmClickHandler(btnLike)

			local raycast = goutil.findChild(self._roles[i], "raycast")

			GameUtil.rmClickHandler(raycast)
			self._avatars[i]:onExit()
		end
	end

	MaterialMgr.resetAll(self._rewardItem)
	self:_clearEffect()
	self:_removeBgEffect()

	if not self._bClickClose then
		self:_cache()
	end
end

function PetTop5RankView:_cache()
	self._cacheParams = {
		self._raceId,
		self._tabId
	}
end

function PetTop5RankView:onEnter()
	PetTop5RankView.super.onEnter(self)

	self._bClickClose = false

	GlobalDispatcher:addListener(GlobalNotify.HandBookPowerCheckRank, self._updateRank, self)
	PowerCheckController.instance:registerLocalNotify(PowerCheckController.RoleResLoadFinish, self._roleResLoadFinish, self)

	self._gainRankPrizeHandler = PetManualAgent.instance:addHandler(PetManualAgent.GainRankPrizeRes, self._updateRankPrizeState, self)
	self._gainKudoHandler = PetManualAgent.instance:addHandler(PetManualAgent.RaceRankKudosRes, self._onGainKudo, self)

	LightMgr.instance:setUseModelLight(true)
	LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
	WaitingView.instance:show(nil, self)
	settimer(1, self._closeWatingView, self, false)
	GlobalModel.instance:visibleSceneHUDs(false)
	self._modelCam.transform:SetParent(nil)

	local tabConfs = HandbookConfig.instance:getPetRankTabConfs()

	self._tabConfs = {}

	for i = 1, #CurTab2TabId do
		local tabConf = tabConfs[CurTab2TabId[i]]

		table.insert(self._tabConfs, tabConf)

		local tab = self.tabs[i]
		local tabChange = tab:GetComponent(ComponentType.UIImageSpriteChange)

		tabChange:SetState(0)

		goutil.findChildTextComponent(tab, "txt").text = tabConf.name
	end

	local params = self:getOpenParam() or {}

	self._raceId = self._cacheParams[1] or checknumber(params[1])
	self._tabId = self._cacheParams[2] or MathUtil.clamp(checknumber(params[2]), 1, #self._tabConfs)
	self._cacheParams = {}

	local configT = HandbookConfig.instance:getPetRankConfByRaceId(self._raceId)

	if not configT or not configT.hasGainRank then
		FloatWordMgr.instance:show(lang("找不到精灵排行榜配置"))
		self:close()

		return
	end

	PetRankModel.instance:saveTopRaceIdOnceRed(self._raceId)

	for i = 1, PosNum do
		if not self._roles[i] then
			self._avatars[i]:onEnter()
		end
	end

	self:_onClickTab(self._tabId)

	local petConf = CharacterConfig.instance:getPetCo(self._raceId)

	if petConf then
		local array = string.split(petConf.name, "·")
		local simpleName = array[2]

		if string.nilorempty(simpleName) then
			simpleName = array[1]
		end

		self._txtTitle.text = langPara("PetTop5RankView__3", simpleName)
	else
		self._txtTitle.text = ""
	end

	self:_playBgEffect()
end

function PetTop5RankView:_playBgEffect()
	self:_removeBgEffect()

	local uiEffect = UIEffectManager.instance:playEffect(self, EffectPath, self._effectGo.transform, 0, 0, true, false)

	uiEffect:setParent(self._effectGo.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	self._uiEffect = uiEffect
end

function PetTop5RankView:_removeBgEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

function PetTop5RankView:_roleResLoadFinish()
	if self._avatarLen then
		self._avatarLen = self._avatarLen - 1

		if self._avatarLen <= 0 then
			WaitingView.instance:hide(self)

			self._avatarLen = false
		end
	else
		WaitingView.instance:hide(self)
	end
end

function PetTop5RankView:_closeWatingView()
	removetimer(self._closeWatingView, self)
	WaitingView.instance:hide(self)
end

function PetTop5RankView:_updateRank()
	local tabConf = self._tabConfs[self._tabId]
	local rankDatas, myRank, bHasGainPrize = PetRankModel.instance:getRankData(tabConf.rankType)

	self._avatarLen = #rankDatas

	for i = 1, PosNum do
		local rankData = rankDatas[i]
		local role = self._roles[i]

		goutil.setActive(role, true)
		self:_updateOneRole(role, rankData, i)
	end

	myRank = checknumber(myRank)

	local str = ""

	if myRank > 0 then
		local rankRange = checknumber(tabConf.rankRange)

		str = (rankRange <= 0 or myRank < rankRange) and string.format("%s%s", str, tostring(myRank)) or string.format("%s%s", str, langPara("PetTop5RankView__4", rankRange))
	else
		str = string.format("%s%s", str, lang("world_Boss_tip9"))
	end

	self._txtMyRank.text = langPara("我的排名：%s", str)

	self:_updateRankPrizeState()
end

function PetTop5RankView:_updateRankPrizeState()
	local tabConf = self._tabConfs[self._tabId]
	local _, myRank, bHasGainPrize, rankSize = PetRankModel.instance:getRankData(tabConf.rankType)
	local rankConf = HandbookConfig.instance:getPetRankConfByRaceId(self._raceId) or {}
	local showPrizeConf = HandbookConfig.instance:getPetRankPrizeConf(rankConf.id, tabConf.rankType, myRank, rankSize)
	local isShowReward = false
	local isOpen = showPrizeConf ~= nil and not string.nilorempty(showPrizeConf.prize)

	goutil.setActive(self._canGet, isOpen)
	MaterialMgr.resetAll(self._rewardItem)

	if isOpen then
		local bCanGainPrize = not bHasGainPrize and myRank > 0 and myRank >= showPrizeConf.rankRange[1] and myRank <= showPrizeConf.rankRange[2]

		goutil.setActive(self._receive, bHasGainPrize)

		local prize = string.split(showPrizeConf.prize, "#")[1]

		if myRank <= 0 and showPrizeConf.hideIfNotReach then
			prize = HandbookConfig.instance:getPetRankClientCommon("default_reward_icon")
		end

		if not string.nilorempty(prize) then
			isShowReward = not bHasGainPrize

			MaterialMgr.setCellByCfg(prize, self._rewardItem)

			self._txtBubble.text = langPara("PetTop5RankView__2", showPrizeConf.rankRange[2])
		end

		if bCanGainPrize then
			self:_playEffect()
		else
			self:_clearEffect()
		end
	end

	goutil.setActive(self._bubble, isShowReward)
end

function PetTop5RankView:_updateOneRole(role, data, rank)
	local empty = goutil.findChild(role, "empty")
	local raycast = goutil.findChild(role, "raycast")
	local isDataEmpty = data == nil
	local imgRank = goutil.findChildComponent(role, "imgRank", ComponentType.UIImageSpriteChange)
	local txtRank = goutil.findChildTextComponent(role, "imgRank/txt")
	local btnLike = goutil.findChildButtonComponent(role, "btnLike")
	local txtLike = goutil.findChildTextComponent(role, "btnLike/txtNum")
	local txtArea = goutil.findChildTextComponent(role, "txtInfo")
	local txtPower = goutil.findChildTextComponent(role, "power/txtPower")
	local txtTime = goutil.findChildTextComponent(role, "time/txt")
	local txtName = goutil.findChildTextComponent(role, "txtName")
	local timeGo = goutil.findChild(role, "time")
	local powerGo = goutil.findChild(role, "power")

	goutil.setActive(timeGo, false)
	goutil.setActive(powerGo, false)
	goutil.setActive(empty, isDataEmpty)
	imgRank:SetState(MathUtil.clamp(rank - 1, 0, 3))

	txtRank.text = rank > 3 and tostring(rank) or ""

	if isDataEmpty then
		txtName.text = ""
		txtArea.text = ""
		txtPower.text = "0"
		txtTime.text = ""

		goutil.setActive(btnLike.gameObject, false)

		txtLike.text = "0"

		self._avatars[rank]:setAvatarActive(false)
	else
		txtName.text = data.headInfo.userName
		txtArea.text = string.nilorempty(data.param) and lang("text_none") or data.param
		txtPower.text = tostring(data.zdl or 0)

		local time = GameUtil.time2date(checknumber(data.time / 1000))

		txtTime.text = langPara("PetTop5RankView__1", time.year, time.month, time.day, time.hour, time.min, time.sec)

		local bInActTime = GameUtil.checkIsInTimePeriod(self._startTime, self._endTime, false)

		goutil.setActive(btnLike.gameObject, bInActTime)

		txtLike.text = StringUtil.numberToString(data.kudosNums)

		self._avatars[rank]:setAvatarActive(true)
		self._avatars[rank]:initAvatar(data)
	end

	GameUtil.rmClickHandler(btnLike)
	GameUtil.addClickHandler(btnLike, function()
		if not isDataEmpty and not string.nilorempty(data.headInfo.userId) then
			local tabConf = self._tabConfs[self._tabId]

			self._gainKudoData = data

			PetRankModel.instance:kudos(tabConf.rankType, self._raceId, checknumber(data.headInfo.userId))
		end
	end, self)
	GameUtil.rmClickHandler(raycast)
	GameUtil.addClickHandler(raycast, function()
		if not isDataEmpty and not string.nilorempty(data.headInfo.userId) then
			FriendController.instance:showInfoView(checknumber(data.headInfo.userId), raycast)
		end
	end, self)
end

function PetTop5RankView:_onGainKudo()
	if self._gainKudoData then
		self._gainKudoData.kudosNums = self._gainKudoData.kudosNums + 1

		self:_updateRank()
	end
end

function PetTop5RankView:_playEffect()
	self:_clearEffect()

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, self._canGet.transform, 0, 0, true, nil, nil, function(view, uiEff)
		uiEff:setClipping(self._canGet.transform)
	end)

	uiEffect:setParent(self._canGet.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._rewardEffect = uiEffect
end

function PetTop5RankView:_clearEffect()
	if self._rewardEffect then
		UIEffectManager.instance:stopEffect(self._rewardEffect)

		self._rewardEffect = nil
	end
end

function PetTop5RankView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "pettoprank_rule")
end

function PetTop5RankView:_onClickRank()
	local tabId = CurTab2TabId[self._tabId]

	UIStateManager.instance:push(ViewName.PetRankView, tabId, self._raceId, false)
end

function PetTop5RankView:_onClickGoto()
	local bagPetId = BagModel.instance:getMaxZdlPetIdByRaceId(self._raceId)

	if bagPetId and bagPetId > 0 then
		UIStateManager.instance:push(ViewName.PowercheckView, bagPetId)
	else
		FloatWordMgr.instance:show(langPara("PetTop5RankView__5"))
	end
end

function PetTop5RankView:_onClickGainPet()
	if self._raceId > 0 then
		MaterialMgr.openGetSource(MatType.PetPiece, self._raceId)
	end
end

function PetTop5RankView:_onClickTab(index)
	local tab = self.tabs[self._tabId]
	local tabChange = tab:GetComponent(ComponentType.UIImageSpriteChange)

	tabChange:SetState(0)

	self._tabId = index
	tab = self.tabs[self._tabId]
	tabChange = self.tabs[self._tabId]:GetComponent(ComponentType.UIImageSpriteChange)

	tabChange:SetState(1)

	local tabConf = self._tabConfs[self._tabId]

	MaterialMgr.resetAll(self._rewardItem)

	if tabConf and self._raceId then
		PetRankModel.instance:queryRank(tabConf.rankType, self._raceId, 5, true)
	end

	local conf = HandbookConfig.instance:getPetRankConfByRaceId(self._raceId)

	self._startTime = conf.startTime
	self._endTime = conf.endTime

	local startDate = GameUtil.string2date(conf.startTime)
	local endDate = GameUtil.string2date(conf.endTime)

	self._txtTime.text = langPara("展示时间：%02d.%02d 5:00-%02d.%02d 5:00", startDate.month, startDate.day, endDate.month, endDate.day)

	local bGainRank = tabConf.rankType == PetRankModel.RankType_5 or tabConf.rankType == PetRankModel.RankType_6

	goutil.setActive(self._btnGainPetGo, bGainRank)
	goutil.setActive(self._btnGotoGo, not bGainRank)

	local viewMgr = ViewMgr.instance

	if viewMgr:isOpen(ViewName.ImpressionStickerPopBubbleView) then
		viewMgr:close(ViewName.ImpressionStickerPopBubbleView)
	end

	local rankConf = HandbookConfig.instance:getPetRankConfByRaceId(self._raceId)
	local hasImpressionStickerCfg = HandbookConfig.instance:getHasImpressionStickerCfg(rankConf.id)

	if hasImpressionStickerCfg and hasImpressionStickerCfg.rankType == tabConf.rankType then
		viewMgr:openAt(self._impressionStickerRoot, ViewName.ImpressionStickerPopBubbleView, self._viewPresentor, self._raceId, rankConf.id, tabConf.rankType)
	end
end

function PetTop5RankView:_onClickReward()
	local tabConf = self._tabConfs[self._tabId]
	local _, myRank, bHasGainPrize, rankSize = PetRankModel.instance:getRankData(tabConf.rankType)
	local rankConf = HandbookConfig.instance:getPetRankConfByRaceId(self._raceId)
	local showPrizeConf = HandbookConfig.instance:getPetRankPrizeConf(rankConf.id, tabConf.rankType, myRank, rankSize)

	if myRank <= 0 then
		if self._raceId then
			UIStateManager.instance:push(ViewName.PetRankPrizeView, self._raceId, tabConf.rankType)
		end
	elseif showPrizeConf then
		local bCanGainPrize = not bHasGainPrize and myRank > 0 and myRank >= showPrizeConf.rankRange[1] and myRank <= showPrizeConf.rankRange[2]

		if bCanGainPrize then
			PetRankModel.instance:gainReward(tabConf.rankType, self._raceId)
		end
	end
end

function PetTop5RankView:_onClickClose()
	self._bClickClose = true

	self:close()
end

return PetTop5RankView
