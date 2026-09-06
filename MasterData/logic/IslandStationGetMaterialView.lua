-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/islandstation/view/IslandStationGetMaterialView.lua

module("logic.extensions.islandstation.view.IslandStationGetMaterialView", package.seeall)

local IslandStationGetMaterialView = class("IslandStationGetMaterialView", ViewComponent)

function IslandStationGetMaterialView:ctor()
	IslandStationGetMaterialView.super.ctor(self)
end

function IslandStationGetMaterialView:unbindEvents()
	IslandStationGetMaterialView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnBossChallenge)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnGame)
end

function IslandStationGetMaterialView:bindEvents()
	IslandStationGetMaterialView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnBossChallenge, self._onClickBtnBossChallenge, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickBtnChallenge, self)
	GameUtil.addClickHandler(self._btnGame, self._onClickBtnGame, self)
end

function IslandStationGetMaterialView:buildUI()
	IslandStationGetMaterialView.super.buildUI(self)

	self._btnChallengeName = self:getGo("btnChallenge/txt")
	self._btnChallengeName2 = self:getGo("btnChallenge/txt2")
	self._btnGameName = self:getGo("btnGame/txt")
	self._btnGameName2 = self:getGo("btnGame/txt2")
	self._btnClose = self:getGo("btnClose")
	self._game = self:getGo("game")
	self._gameCon = self:getGo("game/con")
	self._txtLeftTime = self:getTxt("game/gameTime/txtLeftTime")
	self._btnBossChallenge = self:getGo("challenge/btnChallenge")
	self._btnChallenge = self:getGo("btnChallenge")
	self._btnGame = self:getGo("btnGame")
	self._btnGameImgChangeComp = self._btnGame:GetComponent("UIImageSpriteChange")
	self._btnChallengeImgChangeComp = self._btnChallenge:GetComponent("UIImageSpriteChange")
	self._txtBubbleDesc = self:getTxt("challenge/bubble/txtDesc")
	self._challenge = self:getGo("challenge")
	self._challengeCon = self:getGo("challenge/con")
	self._txtHighHurt = self:getTxt("challenge/highHurt/txtHurt")
	self._txtTotalHurt = self:getTxt("challenge/totalHurt/txtHurt")
	self._tableviewReward = self:getGo("challenge/scorollReward/tableview")
	self._rewardcell = self:getGo("challenge/scorollReward/rewardcell")
	self._scrollListReward = ScrollerList.create(self._tableviewReward, self._rewardcell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._progressSlider = self:getSlider("challenge/scorollReward/tableview/viewport/content/progressSlider")
	self._tablecellGame = self:getGo("game/tableviewGame/tablecell")
	self._tableviewGame = self:getGo("game/tableviewGame")
	self._scrollListGame = ScrollerList.create(self._tableviewGame, self._tablecellGame, GameUtil.handler(self._updateGameCell, self), GameUtil.handler(self._clearGameCell, self))
end

function IslandStationGetMaterialView:onExit()
	IslandStationGetMaterialView.super.onExit(self)

	if self._gameRole then
		self._gameRole = RoleObjectPool.instance:removeRole(self._gameRole)
		self._gameRole = nil
	end

	if self._challengeRole then
		self._challengeRole = RoleObjectPool.instance:removeRole(self._challengeRole)
		self._challengeRole = nil
	end

	for cell, scroll in pairs(self._gameScrollDic) do
		scroll:dispose()
	end
end

function IslandStationGetMaterialView:onEnter()
	IslandStationGetMaterialView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_IslandStationGetBossInfoRes, self._onBossUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_IslandStationStartGameRes, self._onStartGameRes, self)
	self.addGEvent(self, GlobalNotify.PM_IslandStationEndGameRes, self._onEndGameRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._openBossView = params[2]
	self._actCfg = IslandStationConfig.instance:getActCfg(self._activityId)
	self._gameCfg = IslandStationConfig.instance:getSmallGameCfg(self._activityId)
	self._rewardCfg = IslandStationConfig.instance:getDamagePrizeCfg(self._activityId)
	self._info = IslandStationModel.instance:getInfo(self._activityId)
	self._gameScrollDic = {}
	self._tabImgChangeCompList = {
		self._btnGameImgChangeComp,
		self._btnChallengeImgChangeComp
	}
	self._stageId = 0

	self:_onSetUI()
	IslandStationController.instance:sendPM_IslandStationGetBossInfoReq(self._activityId)

	if self._openBossView then
		self:_onClickBtnChallenge()
	else
		self:_onClickBtnGame()
	end
end

function IslandStationGetMaterialView:_onSetUI()
	local skinId = self._actCfg.skinId

	self._gameRole = RoleObjectPool.instance:addRoleToParent(self._gameRole, skinId, self._gameCon, nil, nil, true, nil, nil)
	skinId = self._actCfg.bossSkinId
	self._challengeRole = RoleObjectPool.instance:addRoleToParent(self._challengeRole, self._actCfg.bossSkinId, self._challengeCon, nil, nil, true, nil, nil)

	self._scrollListGame:reloadData(self._gameCfg)

	self._txtLeftTime.text = string.format("今日剩余游戏次数：%d/%d", self._actCfg.dailyGameTimes - checknumber(self._info.todayGameTimes), self._actCfg.dailyGameTimes)

	GameUtil.SetActive(self._game, true)
	GameUtil.SetActive(self._challenge, false)
end

function IslandStationGetMaterialView:_onBossUpdate()
	self:_updateBossData()
	self:_updateBossUI()
end

function IslandStationGetMaterialView:_updateBossData()
	self._bossInfo = IslandStationModel.instance:getBossInfo(self._activityId)
end

function IslandStationGetMaterialView:_updateBossUI()
	self._txtTotalHurt.text = string.format("累计伤害\n%d", checknumber(self._bossInfo.totalDamage))
	self._txtHighHurt.text = string.format("今日最高伤害\n%d", checknumber(self._bossInfo.todayMaxDamage))

	self._scrollListReward:reloadData(self._rewardCfg)

	local list = IslandStationConfig.instance:getDamagePrizeCfg(self._activityId)
	local scoreList = {}

	for i, v in ipairs(list) do
		table.insert(scoreList, checknumber(v.progress))
	end

	self._scrollListReward:updateUnderSlider(self._progressSlider, checknumber(self._bossInfo.totalDamage), scoreList)
end

function IslandStationGetMaterialView:_updateGameCell(view, cell, data)
	local btnChallenge = goutil.findChild(cell, "btnChallenge")
	local txtName = goutil.findChildTextComponent(cell, "btnChallenge/txtName")
	local tableview = goutil.findChild(cell, "tableview")
	local tablecell = goutil.findChild(cell, "tableview/tablecell")
	local scroller = ScrollerList.create(tableview, tablecell, GameUtil.handler(self._updateGameRewardCell, self), GameUtil.handler(self._clearGameRewardCell, self))

	scroller:dragNotifyParent()

	txtName.text = data.name

	GameUtil.addClickHandler(btnChallenge, function()
		self._stageId = data.gameStageId

		IslandStationController.instance:sendPM_IslandStationStartGameReq(self._activityId, data.gameStageId)
	end, self)

	local groupCfgList = IslandStationController.instance:getSmallGameRewardList(self._activityId, data.gameStageId)

	scroller:reloadData(groupCfgList)

	self._gameScrollDic[cell] = scroller
end

function IslandStationGetMaterialView:_clearGameCell(cell)
	local btnChallenge = goutil.findChild(cell, "btnChallenge")

	if self._gameScrollDic[cell] then
		self._gameScrollDic[cell]:dispose()
	end

	GameUtil.rmClickHandler(btnChallenge)
end

function IslandStationGetMaterialView:_updateRewardCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local geted = goutil.findChild(cell, "geted")
	local btnDesc = goutil.findChild(cell, "btnDesc")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")

	txtScore.text = MmUtil.formatNumber(checknumber(data.progress), MmUtil.Units_CN, 1)

	GameUtil.SetActive(geted, checknumber(self._bossInfo.totalDamage) >= checknumber(data.progress))
	MaterialMgr.setCellByCfg(data.materialStr, item)
	GameUtil.addClickHandler(btnDesc, function()
		TipsFacade.instance:openItemSourceView(data.materialStr)
	end, self)
end

function IslandStationGetMaterialView:_clearRewardCell(cell)
	local btnDesc = goutil.findChild(cell, "btnDesc")
	local item = goutil.findChild(cell, "item")

	GameUtil.rmClickHandler(btnDesc)
	MaterialMgr.resetAll(item)
end

function IslandStationGetMaterialView:_updateGameRewardCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local type, id, num = MaterialMgr.getMatParams(data.materialStr)
	local materalStr = string.format("%d:%d:%d", type, id, data.count)

	MaterialMgr.setCellByCfg(materalStr, item)
end

function IslandStationGetMaterialView:_clearGameRewardCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

function IslandStationGetMaterialView:_onClickBtnBossChallenge()
	IslandStationController.instance:enterBattleClg(self._activityId)
	GlobalDispatcher:dispatch(GlobalNotify.IslandStationFightBossBegin)
	self:close()
end

function IslandStationGetMaterialView:_onClickBtnChallenge()
	GameUtil.SetActive(self._game, false)
	GameUtil.SetActive(self._challenge, true)
	self._btnChallengeImgChangeComp:SetState(0)
	self._btnGameImgChangeComp:SetState(1)
	GameUtil.SetActive(self._btnChallengeName, true)
	GameUtil.SetActive(self._btnChallengeName2, false)
	GameUtil.SetActive(self._btnGameName, false)
	GameUtil.SetActive(self._btnGameName2, true)
end

function IslandStationGetMaterialView:_onClickBtnGame()
	GameUtil.SetActive(self._game, true)
	GameUtil.SetActive(self._challenge, false)
	self._btnChallengeImgChangeComp:SetState(1)
	self._btnGameImgChangeComp:SetState(0)
	GameUtil.SetActive(self._btnChallengeName, false)
	GameUtil.SetActive(self._btnChallengeName2, true)
	GameUtil.SetActive(self._btnGameName, true)
	GameUtil.SetActive(self._btnGameName2, false)
end

function IslandStationGetMaterialView:_onStartGameRes()
	local smallGameCfg = IslandStationConfig.instance:getSmallGameCfgById(self._activityId, self._stageId)

	UIStateManager.instance:push(ViewName.IslandStationGameView, self._activityId, self._stageId, smallGameCfg.difficultId)
end

function IslandStationGetMaterialView:_onEndGameRes()
	self._info = IslandStationModel.instance:getInfo(self._activityId)
	self._txtLeftTime.text = string.format("今日剩余游戏次数：%d/%d", self._actCfg.dailyGameTimes - checknumber(self._info.todayGameTimes), self._actCfg.dailyGameTimes)
end

return IslandStationGetMaterialView
