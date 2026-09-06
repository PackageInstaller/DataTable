-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldcup/view/WorldCupTopThreeView.lua

module("logic.extensions.worldcup.view.WorldCupTopThreeView", package.seeall)

local WorldCupTopThreeView = class("WorldCupTopThreeView", ViewComponent)

function WorldCupTopThreeView:ctor()
	WorldCupTopThreeView.super.ctor(self)
end

function WorldCupTopThreeView:unbindEvents()
	WorldCupTopThreeView.super.unbindEvents(self)

	for i, v in ipairs(self._topInfo) do
		GameUtil.rmClickHandler(v.btnChange_1)
		GameUtil.rmClickHandler(v.btnChange_2)
	end

	GameUtil.rmClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.rmClickHandler(self._btnCancel, self.close, self)
	GameUtil.rmClickHandler(self._btnClose, self.close, self)
end

function WorldCupTopThreeView:bindEvents()
	WorldCupTopThreeView.super.bindEvents(self)

	for i, v in ipairs(self._topInfo) do
		GameUtil.addClickHandler(v.btnChange_1, function()
			self:_onClickChange(i)
		end)
		GameUtil.addClickHandler(v.btnChange_2, function()
			self:_onClickChange(i)
		end)
	end

	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function WorldCupTopThreeView:buildUI()
	WorldCupTopThreeView.super.buildUI(self)

	self._slider = self:getSlider("prizeTableview/viewport/content/slider")
	self._prizeTablecell = self:getGo("prizeTableview/prizeTablecell")
	self._prizeTableview = self:getGo("prizeTableview")
	self._prizeTableList = ScrollerList.create(self._prizeTableview, self._prizeTablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._topInfo = {}

	for i = 1, 3 do
		local topInfo = {}

		topInfo.go = self:getGo("topInfo_" .. i)
		topInfo.btnChange_1 = goutil.findChild(topInfo.go, "btnChange")
		topInfo.showInfo = goutil.findChild(topInfo.go, "showInfo")
		topInfo.btnChange_2 = goutil.findChild(topInfo.go, "showInfo/btnChange")
		topInfo.txtName = goutil.findChildTextComponent(topInfo.go, "name/txt")
		topInfo.sucGo = goutil.findChild(topInfo.go, "topSuc")
		topInfo.icon = goutil.findChild(topInfo.go, "showInfo/icon")
		self._topInfo[i] = topInfo
	end

	self._txtTime = self:getTxt("time/txtTime")
	self._txtWin = self:getTxt("txtWin")
	self._btnCancel = self:getGo("btnCancel")
	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
end

function WorldCupTopThreeView:onExit()
	WorldCupTopThreeView.super.onExit(self)
end

function WorldCupTopThreeView:onEnter()
	WorldCupTopThreeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.WorldCupTopThreeSelect, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_WorldCupGuessTopThreeReq, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_WorldCupGainTopThreePrizeReq, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())
	self._actCfg = WorldCupConfig.instance:getActivityCfg(self._activityId)

	local actDefineCfg = ActivityDefineConfig.instance:getCfgByActivitYId(self._activityId)
	local startDate = GameUtil.string2date(actDefineCfg.startTime)
	local endDate = GameUtil.string2date(self._actCfg.guessTopEndTime)

	self._txtTime.text = langPara("应援时间：%d.%02d.%02d %02d:%02d - %d.%02d.%02d %02d:%02d", startDate.year, startDate.month, startDate.day, startDate.hour, startDate.min, endDate.year, endDate.month, endDate.day, endDate.hour, endDate.min)
	self._curSelect = {}

	self:_initSelect()
	self:_refreshView()
end

function WorldCupTopThreeView:_initSelect()
	local guessInfo = WorldCupModel.instance:getTopGuessInfo(self._activityId)

	for i, v in ipairs(self._topInfo) do
		self._curSelect[i] = 0
	end

	self._curSelect[1] = guessInfo.championTeamId or -1
	self._curSelect[2] = guessInfo.runnerUpTeamId or -1
	self._curSelect[3] = guessInfo.thirdPlaceTeamId or -1

	local isCanGet, currectCount
	local var_9_0, var_9_1, var_9_2 = WorldCupController.instance:isCanGetGuessTopThree(self._activityId)

	self._currectMap = var_9_2
	isCanGet = var_9_0
	self._txtWin.text = var_9_1
end

function WorldCupTopThreeView:_refreshView()
	local topGuessCfgs = WorldCupConfig.instance:getTopGuessCfg(self._activityId)
	local cfgList = {}

	for i, v in pairs(topGuessCfgs) do
		table.insert(cfgList, v)
	end

	table.sort(cfgList, function(a, b)
		return a.rightNum < b.rightNum
	end)

	self._curValue = 1

	self._prizeTableList:reloadData(cfgList)

	local scoreList = {}

	for i, v in ipairs(cfgList) do
		table.insert(scoreList, v.rightNum)
	end

	self._prizeTableList:updateUnderSlider(self._slider, self._curValue, scoreList)

	for i = 1, 3 do
		self:_updateTopInfo(i)
	end
end

function WorldCupTopThreeView:_updateTopInfo(index)
	local topInfo = self._topInfo[index]
	local teamId = checknumber(self._curSelect[index])
	local teamCfg = WorldCupConfig.instance:getTeamCfg(self._activityId, teamId)

	GameUtil.SetActive(topInfo.showInfo, teamCfg ~= nil)
	GameUtil.SetActive(topInfo.btnChange_1, teamCfg == nil)

	if teamCfg then
		uGuiUtil.setSpriteToImage(topInfo.icon, nil, GameUrl.getShiJieBeiJingCaiIconUrl(teamCfg.res))

		topInfo.txtName.text = WorldCupController.instance:getTeamName(teamCfg)
	else
		uGuiUtil.clearImage(topInfo.icon)

		topInfo.txtName.text = lang("点击选择球队")
	end

	GameUtil.SetActive(topInfo.sucGo, self._currectMap and self._currectMap[index] == true or false)
end

function WorldCupTopThreeView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local gain = goutil.findChild(go, "gain")
	local btnGet = goutil.findChild(go, "btnGet")
	local effect = goutil.findChild(go, "effect")

	MaterialMgr.setCellByCfg(data.prize, con)

	local guessInfo = WorldCupModel.instance:getTopGuessInfo(self._activityId)
	local isCanGet, count = WorldCupController.instance:isCanGetGuessTopThree(self._activityId)

	GameUtil.SetActive(gain, guessInfo.gainedPrize == true and count >= data.rightNum)

	if isCanGet == true and count >= data.rightNum then
		self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effect, self._prizeTableview, true, 0, 0, nil, GameUtil.handler(function(target, eff)
			eff:setScale(1)
		end))
	else
		self:stopViewEffectUniGo(effect)
	end

	GameUtil.SetActive(btnGet, isCanGet)
	GameUtil.addClickHandler(btnGet, function()
		self:_onClickGet()
	end)
end

function WorldCupTopThreeView:_clearCell(cell)
	local go = cell.gameObject
	local effect = goutil.findChild(go, "effect")

	self:stopViewEffectUniGo(effect)
	MaterialMgr.resetAll(go)
end

function WorldCupTopThreeView:_onClickChange(index)
	UIStateManager.instance:push(ViewName.WorldCupSelectTeamView, self._activityId, index, self._curSelect)
end

function WorldCupTopThreeView:_onClickGet()
	local startGainPrizeTime = GameUtil.string2time(self._actCfg.guessTopGainPrizeTime)

	if startGainPrizeTime > ServerTime.now() then
		FloatWordMgr.instance:show(lang("未到领取时间"))

		return
	end

	local isCanGet, count = WorldCupController.instance:isCanGetGuessTopThree(self._activityId)

	if isCanGet == false and count > 0 then
		FloatWordMgr.instance:show(lang("已领取"))
	end

	if isCanGet == false and count == 0 then
		FloatWordMgr.instance:show(lang("无可领取奖励"))
	end

	if isCanGet == true then
		WorldCupAgent.instance:sendPM_WorldCupGainTopThreePrizeReq(self._activityId)
	end
end

function WorldCupTopThreeView:_onClickSure()
	if not self._curSelect[1] then
		if not self._curSelect[2] then
			local runnerUpTeamId = -1

			if not self._curSelect[3] then
				local thirdPlaceTeamId = -1
				local endTime = GameUtil.string2time(self._actCfg.guessTopEndTime)

				if endTime < ServerTime.now() then
					FloatWordMgr.instance:show(lang("已过应援时间"))

					return
				end

				WorldCupAgent.instance:sendPM_WorldCupGuessTopThreeReq(self._activityId, self._curSelect[1], runnerUpTeamId, thirdPlaceTeamId)
				FloatWordMgr.instance:show(lang("已成功设置应援队伍"))
			end
		end
	end
end

return WorldCupTopThreeView
