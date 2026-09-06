-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lightking/LightKingRankView.lua

module("logic.extensions.timelimitedchallenge.view.lightking.LightKingRankView", package.seeall)

local LightKingRankView = class("LightKingRankView", TableViewComponent)

function LightKingRankView:_getPath()
	return {
		cellPath = "right/cell",
		viewPath = "right/rankScrollRect"
	}
end

function LightKingRankView:unbindEvents()
	LightKingRankView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function LightKingRankView:bindEvents()
	LightKingRankView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
end

function LightKingRankView:onExit()
	LightKingRankView.super.onExit(self)
end

function LightKingRankView:buildUI()
	LightKingRankView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._txtTitle = self:getTxt("title/txtTitle")
	self._goEmpty = self:getGo("right/goEmpty")
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._txtTip = self:getTxt("right/myRank/txtTip")
	self._txtSubTitle = self:getTxt("right/subTitle/txtTime")
end

function LightKingRankView:onEnter()
	LightKingRankView.super.onEnter(self)

	local challengeId = checknumber(self:getFirstParam())

	if challengeId == 0 then
		challengeId = LightKingModel.instance:getChallengeId()
		self._txtTitle.text = "极限挑战排行榜"
		self._txtSubTitle.text = "通关时间"
		self._txtTip.text = lang("1.最先通关极限挑战前5999名玩家，可获得专属头像框。\n2.根据通关时间先后进行排名，在精灵背包中展示光明王到聊天频道显示对应名次。")
	end

	local cfg = TimeLimitedConfig.instance:getCfgById(challengeId)

	if challengeId ~= LightKingModel.instance:getChallengeId() then
		self._txtTitle.text = "排行榜"
		self._txtSubTitle.text = "获得时间"
		self._txtTip.text = ""

		if not string.nilorempty(cfg.rankDesc) then
			self._txtTip.text = cfg.rankDesc
		elseif not string.nilorempty(cfg.desc) then
			self._txtTip.text = cfg.desc
		end
	end

	TimedChallengeAgent.instance:sendPM_TimedChallengeGetPetRankReq(challengeId, self._onPetRankRes, self)
end

function LightKingRankView:_onPetRankRes(msg)
	self._curViewDatas = msg.infoList or {}

	local myRank = checknumber(msg.myRank)

	self._txtMyRank.text = myRank > 0 and myRank or lang("未上榜")

	self._goEmpty:SetActive(#self._curViewDatas == 0)
	self:reloadData()
end

function LightKingRankView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local imgRank = goutil.findChildComponent(go, "imgRank", typeof(UIImageSpriteChange))
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtFamily = goutil.findChildTextComponent(go, "txtFamily")
	local txtDesc = goutil.findChildTextComponent(go, "txtTime")
	local btnHead = goutil.findChild(go, "btnHead")

	txtName.text = data.headInfo.userName

	HeadItemController.instance:setHeadCellByInfo(imgIcon, data.headInfo)

	txtRank.text = data.rank
	txtFamily.text = not string.nilorempty(data.familyName) and data.familyName or lang("无")

	local rank = checknumber(data.rank)
	local isTop3 = rank <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end

	if data.headInfo.userId then
		GameUtil.addClickHandler(btnHead, GameUtil.handler(self.onHeadClick, self, data.headInfo.userId, btnHead))
	end

	local time = GameUtil.time2date(checknumber(data.gainTime) / 1000)

	txtDesc.text = langPara("%d月%d日 %02d:%02d:%02d", time.month, time.day, time.hour, time.min, time.sec)
end

function LightKingRankView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

return LightKingRankView
