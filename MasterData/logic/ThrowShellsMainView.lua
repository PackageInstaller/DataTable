-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throwshells/view/ThrowShellsMainView.lua

module("logic.extensions.throwshells.view.ThrowShellsMainView", package.seeall)

local ThrowShellsMainView = class("ThrowShellsMainView", TableViewComponent)

function ThrowShellsMainView:ctor()
	ThrowShellsMainView.super.ctor(self)
end

function ThrowShellsMainView:buildUI()
	ThrowShellsMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnChall = self:getBtn("btnChall")
	self._txtTime = self:getTxt("time/txtTime")
	self._txtRemain = self:getTxt("remain/txtRemain")
	self._btnAddTime = self:getBtn("remain/btnAdd")
	self._btnRule = self:getBtn("btnTip")
	self._goRole1 = self:getGo("role1")
	self._goRole2 = self:getGo("role2")
	self._goRole3 = self:getGo("role3")
end

function ThrowShellsMainView:bindEvents()
	ThrowShellsMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnChall:AddClickListener(self._clickChall, self)
	self._btnAddTime:AddClickListener(self._buyTime, self)
	self._btnRule:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "throwshellsrule")
	end, self)
end

function ThrowShellsMainView:unbindEvents()
	ThrowShellsMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnChall:RemoveClickListener()
	self._btnAddTime:RemoveClickListener()
	self._btnRule:RemoveClickListener()
end

function ThrowShellsMainView:onEnter()
	ThrowShellsMainView.super.onEnter(self)

	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.ThrowShells)

	if actCfg == nil then
		FloatWordMgr.instance:show("当前活动未开启")
		self:close()

		return
	end

	self.activityId = actCfg.activityId

	ThrowShellsModel.instance:setActId(actCfg.activityId)

	self._actCfg = ThrowShellsConfig.instance:getActCfg(self.activityId)
	self._gameId = self._actCfg.gameId
	self._buyTimesPlan = self._actCfg.buyTimesPlan

	if ThrowShellsModel.instance:getHasLoadData() then
		self:_refresh()
	else
		ThrowingGameAgent.instance:sendPM_ThrowingGameGetInfoReq(self.activityId)
		ThrowShellsModel.instance:setHasLoadData(true)
	end

	GlobalDispatcher:addListener(GlobalNotify.ThrowShellsGetInfo, self._refresh, self)
	GlobalDispatcher:addListener(GlobalNotify.ThrowShellsGameStart, self._onStartGameRes, self)
	GlobalDispatcher:addListener(GlobalNotify.ThrowShellsBuyTime, self._refreshBuyTimes, self)

	self.startTime, self.endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.ThrowShells, self.activityId)

	self:_timer()
	settimer(1, self._timer, self, true)

	self._role2 = RoleObjectPool.instance:addRoleToParent(self._role2, 10020, self._goRole2, 0.18)
	self._role3 = RoleObjectPool.instance:addRoleToParent(self._role3, 10362, self._goRole3, 0.24)

	local url = {
		"character/xinxiya_xiaoren/xinxiya_xiaoren-ui_p.prefab"
	}

	self._mainActorEff = UIEffectManager.instance:playEffect(self.view, url, self._goRole1, 0, 0, true, nil, nil, self._onEffectLoaded, self)

	self._tableview:RegisterReloadFinishCallback(self._onReloadFinish, self)
end

function ThrowShellsMainView:onExit()
	ThrowShellsMainView.super.onExit(self)

	self._selectId = nil

	removetimer(self._timer, self)
	GlobalDispatcher:removeListener(GlobalNotify.ThrowShellsGetInfo, self._refresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.ThrowShellsGameStart, self._onStartGameRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.ThrowShellsBuyTime, self._refreshBuyTimes, self)
	RoleObjectPool.instance:removeRole(self._role2)
	RoleObjectPool.instance:removeRole(self._role3)

	if self._mainActorEff then
		UIEffectManager.instance:stopEffect(self._mainActorEff)

		self._mainActorEff = nil
	end

	self._sg = nil
end

function ThrowShellsMainView:_getPath()
	return {
		cellPath = "level/cell",
		viewPath = "level/tableview"
	}
end

function ThrowShellsMainView:_clickChall()
	local useTime = ThrowShellsModel.instance:getUseTimes()
	local buyTime = ThrowShellsModel.instance:getBuyTimes()
	local normalTime = checknumber(ThrowShellsConfig.instance:getCommonCfg("FREE_GAME_TIMES"))
	local curTimes = normalTime - useTime + buyTime
	local barrierId = ThrowShellsModel.instance:getBarrierId()

	if barrierId > self._selectId then
		self:_startGame()
	elseif curTimes > 0 then
		self:_startGame()
	else
		FloatWordMgr.instance:show("游戏次数不足")
	end
end

function ThrowShellsMainView:_timer()
	local leftTime = self.endTime - ServerTime.now()

	if leftTime > 0 then
		self._txtTime.text = string.format("剩余时间:%s", GameUtil.FormatTimeWordsNoSec(leftTime))
	else
		FloatWordMgr.instance:show("当前活动结束")
		self:close()
	end
end

function ThrowShellsMainView:_refresh()
	self:_refreshBuyTimes()

	local gameCfgList = ThrowShellsConfig.instance:getGameCfgList(self._gameId)

	self._curViewDatas = gameCfgList

	local barrierId = ThrowShellsModel.instance:getBarrierId()

	self._maxGameNum = #gameCfgList
	self._selectId = math.min(self._maxGameNum, barrierId)

	self:reloadData()
end

function ThrowShellsMainView:_refreshBuyTimes()
	local useTime = ThrowShellsModel.instance:getUseTimes()
	local buyTime = ThrowShellsModel.instance:getBuyTimes()
	local normalTime = checknumber(ThrowShellsConfig.instance:getCommonCfg("FREE_GAME_TIMES"))
	local curTimes = normalTime - useTime + buyTime

	self._txtRemain.text = langPara("次数：%s/%s", curTimes, normalTime)
end

function ThrowShellsMainView:_cellSize(view, index)
	return 208, 88
end

function ThrowShellsMainView:_updateCell(view, cell, data)
	local txtLevel = goutil.findChildTextComponent(cell.gameObject, "mirror/txtLevel")
	local pass = goutil.findChild(cell, "mirror/pass")
	local head = goutil.findChild(cell, "mirror/head")
	local btnSelect = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnSelect")
	local mirror = goutil.findChild(cell, "mirror")
	local arrow = goutil.findChild(cell, "arrow")
	local dots = goutil.findChild(cell, "dots")
	local scale = cell.index % 2 == 0 and 1 or -1

	Framework.TransformUtil.SetLocalScale(cell.transform, scale, 1, 1)
	Framework.TransformUtil.SetLocalScale(mirror.transform, scale, 1, 1)

	txtLevel.text = langPara("第%s关", data.stageId)

	local barrierId = ThrowShellsModel.instance:getBarrierId()

	goutil.setActive(pass, barrierId > data.stageId)
	goutil.setActive(arrow, data.stageId == barrierId)
	goutil.setActive(head, data.stageId == self._selectId)
	goutil.setActive(dots, self._maxGameNum ~= data.stageId)
	btnSelect:AddClickListener(function()
		if data.stageId <= barrierId then
			self._selectId = data.stageId

			self._tableview:Refresh()
		else
			FloatWordMgr.instance:show("你还没有到达此关哦~")
		end
	end)
end

function ThrowShellsMainView:_clearTableview(cell)
	local btnSelect = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnSelect")

	btnSelect:RemoveClickListener()
end

function ThrowShellsMainView:_startGame()
	local barrierId = ThrowShellsModel.instance:getBarrierId()

	if barrierId > self._selectId then
		self:_onStartGameRes()
	else
		local clientKey = ServerTime.nowServerLook()

		ThrowShellsModel.instance:setClientKey(clientKey)

		local actId = ThrowShellsModel.instance:getActId()

		ThrowingGameAgent.instance:sendPM_ThrowingGameStartGameReq(actId, barrierId, clientKey)
	end
end

function ThrowShellsMainView:_onStartGameRes()
	local gameCfg = ThrowShellsConfig.instance:getGameCfg(self._gameId, self._selectId)

	UIStateManager.instance:push(ViewName.ThrowShellsGameView, gameCfg)
end

function ThrowShellsMainView:_buyTime()
	local buyCfg = ThrowShellsConfig.instance:getBuyCfg(self._buyTimesPlan)
	local buyCfgList = {}

	for k, v in pairs(buyCfg) do
		table.insert(buyCfgList, v)
	end

	table.sort(buyCfgList, function(a, b)
		return a.times < b.times
	end)

	local buyTime = ThrowShellsModel.instance:getBuyTimes()

	if buyTime < #buyCfgList then
		local price = string.split(buyCfgList[buyTime + 1].cost, ":")[3]
		local str = langPara("是否消耗%s钻石购买一次游戏次数？", price)

		TipsFacade.instance:openPopupWindow("提示", str, function()
			ThrowingGameAgent.instance:sendPM_ThrowingGameBuyTimesReq(self.activityId)
		end, function()
			return
		end, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
	else
		FloatWordMgr.instance:show("购买次数已达上限")
	end
end

function ThrowShellsMainView:_onEffectLoaded(uiEffect)
	uiEffect:setParent(self._goRole1.transform)
	uiEffect:setScale(0.16)
	uiEffect:setLocalPos()

	self._sg = uiEffect.effGo:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))
	self._effLoaded = true

	RoleObjectPool.instance:playAnimation(self._goRole1, "idle1", true, nil, true)
end

function ThrowShellsMainView:_onReloadFinish()
	if checknumber(self._selectId) > 0 then
		self._tableview:MoveCellToCebter(self._selectId)
	end
end

return ThrowShellsMainView
