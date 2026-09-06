-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/FuncampRankView.lua

module("logic.extensions.funcamp.view.FuncampRankView", package.seeall)

local FuncampRankView = class("FuncampRankView", ViewComponent)
local CurTab2TabId = {
	1,
	2,
	3
}
local PosNum = 5

function FuncampRankView:ctor()
	FuncampRankView.super.ctor(self)

	self._cacheParams = {}
	self._tabId = 1
end

function FuncampRankView:unbindEvents()
	FuncampRankView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnRank:RemoveClickListener()

	for _, tab in ipairs(self.tabs) do
		GameUtil.rmClickHandler(GameUtil.asBtn(tab))
	end
end

function FuncampRankView:bindEvents()
	FuncampRankView.super.bindEvents(self)
	self._btnClose:AddClickListener(function()
		self:close()
	end)
	self._btnTip:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "funcamprankview")
	end)
	self._btnRank:AddClickListener(function()
		UIStateManager.instance:push(ViewName.FuncampAllRankView)
	end)

	for i, tab in ipairs(self.tabs) do
		GameUtil.addClickHandler(GameUtil.asBtn(tab), GameUtil.handler(self._onClickTab, self, i))
	end
end

function FuncampRankView:onExit()
	FuncampRankView.super.onExit(self)
	self._modelCam.transform:SetParent(self.mainGO.transform)
	GlobalDispatcher:removeListener(GlobalNotify.FunCampRankTop5Res, self._updateRank, self)
	LightMgr.instance:setUseModelLight(false)
	WaitingView.instance:hide(self)
	removetimer(self._closeWatingView, self)
	self._modelCam.transform:SetParent(self.mainGO.transform)
	GlobalModel.instance:visibleSceneHUDs(true)
	LightMgr.instance:setLightForNormalScene()
end

function FuncampRankView:buildUI()
	FuncampRankView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._txtTitle = self:getTxt("leftTop/txtTitle")
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
	self._myRankGo = self:getGo("myRank")
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

function FuncampRankView:_cache()
	self._cacheParams = {
		self._raceId,
		self._tabId
	}
end

function FuncampRankView:onEnter()
	FuncampRankView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.FunCampRankTop5Res, self._updateRank, self)
	LightMgr.instance:setUseModelLight(true)
	LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
	WaitingView.instance:show(nil, self)
	settimer(1, self._closeWatingView, self, false)
	GlobalModel.instance:visibleSceneHUDs(false)
	self._modelCam.transform:SetParent(nil)

	self._bClickClose = false
	self._curActId = FunCampModel.instance:getActivityId()

	local tabConfs = CampGameConfig.instance:getBattleGroup()

	self._tabConfs = {}

	for i = 1, #CurTab2TabId do
		local tabConf = tabConfs[CurTab2TabId[i]]

		table.insert(self._tabConfs, tabConf)

		local tab = self.tabs[i]
		local tabChange = tab:GetComponent(ComponentType.UIImageSpriteChange)

		tabChange:SetState(0)

		goutil.findChildTextComponent(tab, "txt").text = tabConf.name
	end

	for i = 1, PosNum do
		if not self._roles[i] then
			self._avatars[i]:onEnter()
		end
	end

	self:_onClickTab(self._tabId)
end

function FuncampRankView:_updateRank()
	local rankDatas, myRank = FunCampModel.instance:getRankData()

	self._avatarLen = #rankDatas >= 5 and 5 or #rankDatas

	for i = 1, PosNum do
		local rankData = rankDatas[i]
		local role = self._roles[i]

		goutil.setActive(role, true)
		self:_updateOneRole(role, rankData, i)
	end

	myRank = checknumber(myRank)

	local str = ""

	str = myRank > 0 and (myRank < 100 and string.format("%s%s", str, tostring(myRank)) or string.format("%s%s", str, langPara("PetTop5RankView__4", 100))) or string.format("%s%s", str, lang("world_Boss_tip9"))
	self._txtMyRank.text = langPara("我的排名：%s", str)

	goutil.setActive(self._myRankGo, true)

	if FunCampModel.instance:getCampId() ~= self._tabId then
		goutil.setActive(self._myRankGo, false)
	end
end

function FuncampRankView:_onClickTab(index)
	local tab = self.tabs[self._tabId]
	local tabChange = tab:GetComponent(ComponentType.UIImageSpriteChange)

	tabChange:SetState(0)

	self._tabId = index
	tab = self.tabs[self._tabId]
	tabChange = self.tabs[self._tabId]:GetComponent(ComponentType.UIImageSpriteChange)

	tabChange:SetState(1)
	MaterialMgr.resetAll(self._rewardItem)
	FunCampController.instance:sendPM_CB_GetRankInfoReq(self._curActId, index)

	local conf = FunCampConfig.instance:getActivityCfg(self._curActId)

	self._startTime = conf.battleStartTime
	self._endTime = conf.battleEndTime

	local startDate = GameUtil.string2date(conf.battleStartTime)
	local endDate = GameUtil.string2date(conf.battleEndTime)

	self._txtTime.text = langPara("活动时间：%02d.%02d 5:00-%02d.%02d 5:00", startDate.month, startDate.day, endDate.month, endDate.day)
end

function FuncampRankView:_updateOneRole(role, data, rank)
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

	goutil.setActive(timeGo, not isDataEmpty)
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
		txtArea.text = string.nilorempty(data.areaName) and lang("text_none") or data.areaName
		txtTime.text = langPara("阵营个人积分:%s", data.personScore)

		local bInActTime = GameUtil.checkIsInTimePeriod(self._startTime, self._endTime, false)

		goutil.setActive(btnLike.gameObject, bInActTime)

		txtLike.text = StringUtil.numberToString(data.kudosNums)

		self._avatars[rank]:setAvatarActive(true)
		self._avatars[rank]:initAvatar(data)
	end

	GameUtil.rmClickHandler(btnLike)
	GameUtil.addClickHandler(btnLike, function()
		SendFlowerController.instance:openSendFlowerView(data.headInfo)
	end, self)
	GameUtil.rmClickHandler(raycast)
	GameUtil.addClickHandler(raycast, function()
		if not isDataEmpty and not string.nilorempty(data.headInfo.userId) then
			FriendController.instance:showInfoView(checknumber(data.headInfo.userId), raycast)
		end
	end, self)
end

function FuncampRankView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "FuncampRankView")
end

function FuncampRankView:_onClickRank()
	UIStateManager.instance:open(ViewName.FuncampAllRankView)
end

function FuncampRankView:_closeWatingView()
	removetimer(self._closeWatingView, self)
	WaitingView.instance:hide(self)
end

return FuncampRankView
