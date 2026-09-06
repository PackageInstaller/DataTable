-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/famehallvote/view/FameHallVoteView.lua

module("logic.extensions.famehallvote.view.FameHallVoteView", package.seeall)

local FameHallVoteView = class("FameHallVoteView", ViewComponent)

function FameHallVoteView:ctor()
	FameHallVoteView.super.ctor(self)
end

function FameHallVoteView:unbindEvents()
	FameHallVoteView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function FameHallVoteView:bindEvents()
	FameHallVoteView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function FameHallVoteView:buildUI()
	FameHallVoteView.super.buildUI(self)

	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtVoteLeftNum = self:getTxt("voteTime/txtVoteLeftNum")
	self._tablecellVote = self:getGo("tableviewVote/tablecellVote")
	self._tableviewVote = self:getGo("tableviewVote")
	self._scrollListVote = ScrollerList.create(self._tableviewVote, self._tablecellVote, GameUtil.handler(self._updateCellVote, self), GameUtil.handler(self._clearCellVote, self))
	self._rewardcell = self:getGo("scorollReward/rewardcell")
	self._scorollReward = self:getGo("scorollReward/tableview")
	self._scrollListReward = ScrollerList.create(self._scorollReward, self._rewardcell, GameUtil.handler(self._updateCellReward, self), GameUtil.handler(self._clearCellReward, self))
	self._clip = self:getGo("scorollReward/clip")
	self._txtTotal = self:getTxt("total/txtTotal")
	self._progressSlider = self:getSlider("scorollReward/tableview/viewport/content/progressSlider")
end

function FameHallVoteView:onExit()
	FameHallVoteView.super.onExit(self)
	self._scrollListVote:dispose()
	self._scrollListReward:dispose()

	for k, v in pairs(self._descScrollMap) do
		v:dispose()
	end
end

function FameHallVoteView:onEnter()
	FameHallVoteView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_FameHallVoteGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_FameHallVoteRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_FameHallVoteGainPrizeRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		self._activityId = 541001
	end

	if self._txtOpenTime then
		self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	self._actCfg = FameHallVoteConfig.instance:getActCfg(self._activityId)
	self._playerTitleCfg = FameHallVoteConfig.instance:getPlayerTitleCfg(self._activityId)
	self._rewardCfg = FameHallVoteConfig.instance:getProgressPrizeCfg(self._activityId)
	self._randomPLayerIdList = FameHallVoteConfig.instance:getPlayerIdRandomList(self._activityId)
	self._descScrollMap = {}

	FameHallVoteController.instance:sendPM_FameHallVoteGetInfoReq(self._activityId)
end

function FameHallVoteView:_onUpdate()
	self._info = FameHallVoteModel.instance:getInfo(self._activityId)
	self._playerInfoMap = FameHallVoteModel.instance:getPlayerInfoMap(self._activityId)

	local dailyVotePlayers = self._info.dailyVotePlayers
	local scoreList = {}

	for i, v in ipairs(self._rewardCfg) do
		table.insert(scoreList, v.needScore)
	end

	self._txtVoteLeftNum.text = string.format("今日剩余点赞次数：%d", self._actCfg.dailyVoteTimes - #dailyVotePlayers)
	self._txtTotal.text = self._info.progress

	self._scrollListVote:reloadData(self._randomPLayerIdList)
	self._scrollListReward:reloadData(self._rewardCfg)
	self._scrollListReward:updateUnderSlider(self._progressSlider, self._info.progress, scoreList)
end

function FameHallVoteView:_updateCellVote(view, cell, data)
	local playerId = data
	local playerInfo = self._playerInfoMap[playerId]
	local headInfo = playerInfo.headInfo
	local voteCount = playerInfo.voteCount
	local player = goutil.findChild(cell, "player")
	local btnSend = goutil.findChild(cell, "btnSend")
	local tableviewFame = goutil.findChild(cell, "tableviewFame")
	local tablecellFame = goutil.findChild(cell, "tableviewFame/tablecell")

	if self._descScrollMap[cell] == nil then
		self._descScrollMap[cell] = ScrollerList.create(tableviewFame, tablecellFame, GameUtil.handler(self._updateCellDesc, self), GameUtil.handler(self._clearCellDesc, self))
	end

	local scrollFame = self._descScrollMap[cell]
	local txtPlayerInfo = goutil.findChildTextComponent(cell, "txtPlayerInfo")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")
	local honorDescList = FameHallVoteController.instance:getHonorDescList(self._activityId, playerId)

	txtNum.text = voteCount
	txtPlayerInfo.text = string.format("%d-%s", checknumber(headInfo.areaId), headInfo.userName)

	scrollFame:reloadData(honorDescList)
	scrollFame:dragNotifyParent()
	scrollFame:setCenterMode(true)
	HeadItemController.instance:setHeadCellByInfo(player, headInfo, true)
	GameUtil.addClickHandler(btnSend, function()
		if table.indexof(self._info.dailyVotePlayers, playerId) then
			FloatWordMgr.instance:show("今日已投票过该玩家")

			return
		end

		FameHallVoteController.instance:sendPM_FameHallVoteReq(self._activityId, playerId)
	end, self)
end

function FameHallVoteView:_clearCellVote(cell)
	local player = goutil.findChild(cell, "player")
	local btnSend = goutil.findChild(cell, "btnSend")
	local scrollFame = self._descScrollMap[cell]

	HeadItemController.instance:resetHeadCell(player)
	GameUtil.rmClickHandler(btnSend)

	if scrollFame then
		scrollFame:dispose()
	end
end

local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

function FameHallVoteView:_updateCellReward(view, cell, data)
	local effect = goutil.findChild(cell, "effect")
	local btnGet = goutil.findChild(cell, "btnGet")
	local geted = goutil.findChild(cell, "geted")
	local item = goutil.findChild(cell, "item")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local hasGeted = table.indexof(self._info.gainPrizeIds, data.prizeId)
	local canGet = self._info.progress >= data.progress

	txtScore.text = data.progress

	self:stopViewEffectUniGo(effect)

	if canGet and not hasGeted then
		self:playViewEffectUniGo(effPath, effect, self._clip.transform, true, nil, nil)
	end

	GameUtil.SetActive(btnGet, canGet and not hasGeted)
	GameUtil.SetActive(geted, hasGeted)
	MaterialMgr.setCellByCfg(data.prize, item)
	GameUtil.addClickHandler(btnGet, function()
		FameHallVoteController.instance:sendPM_FameHallVoteGainPrizeReq(self._activityId, data.prizeId)
	end, self)
end

function FameHallVoteView:_clearCellReward(cell)
	local item = goutil.findChild(cell, "item")
	local btnGet = goutil.findChild(cell, "btnGet")
	local effect = goutil.findChild(cell, "effect")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)
	self:stopViewEffectUniGo(effect)
end

function FameHallVoteView:_updateCellDesc(view, cell, data)
	local txtFame = goutil.findChildTextComponent(cell, "txtFame")

	txtFame.text = data
end

function FameHallVoteView:_clearCellDesc(cell)
	return
end

function FameHallVoteView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

return FameHallVoteView
