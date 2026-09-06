-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefeiyin/view/DivinefeiyinchallengegameView.lua

module("logic.extensions.divinefeiyin.view.DivinefeiyinchallengegameView", package.seeall)

local DivinefeiyinchallengegameView = class("DivinefeiyinchallengegameView", SunWuKongChallengeGameView)

function DivinefeiyinchallengegameView:unbindEvents()
	DivinefeiyinchallengegameView.super.unbindEvents(self)
end

function DivinefeiyinchallengegameView:bindEvents()
	DivinefeiyinchallengegameView.super.bindEvents(self)
end

function DivinefeiyinchallengegameView:buildUI()
	DivinefeiyinchallengegameView.super.buildUI(self)

	self._passPrize = self:getGo("ScrollView/Viewport/Content/passPrize")
	self._received = self:getGo("ScrollView/Viewport/Content/passPrize/received")
	self._con = self:getGo("ScrollView/Viewport/Content/passPrize/con")
	self._btnReceive = self:getGo("ScrollView/Viewport/Content/passPrize/btnReceive")
end

function DivinefeiyinchallengegameView:onExit()
	DivinefeiyinchallengegameView.super.onExit(self)
	MaterialMgr.resetAll(self._con)
end

function DivinefeiyinchallengegameView:refreshView()
	DivinefeiyinchallengegameView.super.refreshView(self)

	local curLevelPos = GameUtil.getAnchoredPos(self._pointsGo[#self._stageCfgList].mainGO)

	GameUtil.setAnchoredPos(self._passPrize, curLevelPos.x, curLevelPos.y)

	local cfg = self._stageCfgList[#self._stageCfgList]

	MaterialMgr.setCellByCfg(cfg.passStagePrize, self._con)
	GameUtil.SetActive(self._received, false)
	GameUtil.SetActive(self._btnReceive, false)
end

function DivinefeiyinchallengegameView:_updatePointBg(cell, index)
	local go = cell.mainGO
	local txtLevel = goutil.findChildTextComponent(go, "txtLevel")
	local levelIndex = self._levelPathGos[index + self._targetStartPointIndex - 1].index
	local targetPos = GameUtil.getAnchoredPos(self._pointsGo[levelIndex].mainGO)

	GameUtil.setAnchoredPos(go, targetPos.x, targetPos.y)

	txtLevel.text = levelIndex

	local lock = goutil.findChild(go, "lock")
	local txtLimit = goutil.findChildTextComponent(go, "lock/txtLimit")

	GameUtil.SetActive(lock, false)

	local cfg = self._stageCfgList[levelIndex]

	if cfg and not string.nilorempty(cfg.openTime) then
		local now = ServerTime.now()
		local time = GameUtil.string2time(cfg.openTime)

		if now < time then
			GameUtil.SetActive(lock, true)

			txtLimit.text = langPara("%s开启", GameUtil.formatTimeStamp("%m.%d", time))
		end
	end
end

function DivinefeiyinchallengegameView:_onClickLevel(levelIndex)
	local cfg = self._stageCfgList[levelIndex]
	local isPass = SunWuKongChallengeModel.instance:isPassNomalStage(self._activityId, levelIndex)

	if isPass == true then
		if ((cfg and checknumber(cfg.hiddenTaskId) > 0 or nil) and not SunWuKongChallengeModel.instance:isPassHiddenStage(self._activityId, levelIndex)) == true then
			self:_openHidenView(levelIndex)
		else
			return
		end
	else
		if not string.nilorempty(cfg.openTime) then
			local now = ServerTime.now()
			local time = GameUtil.string2time(cfg.openTime)

			if now < time then
				FloatWordMgr.instance:show(langPara("%s开启", GameUtil.formatTimeStamp("%Y.%m.%d %H:%M", time)))

				return
			end
		end

		if levelIndex == SunWuKongChallengeModel.instance:getCurStageId(self._activityId) then
			self:_openChallengeNormalView(levelIndex)
		else
			FloatWordMgr.instance:show(lang("请先通关前面的关卡"))
		end
	end
end

function DivinefeiyinchallengegameView:_getTipsViewName()
	return ViewName.DivinefeiyinchallengetipsView
end

function DivinefeiyinchallengegameView:_initPointPlan()
	self._pointPlanId = 0
end

function DivinefeiyinchallengegameView:_onClickCimelia()
	UIStateManager.instance:push(ViewName.DivinefeiyinchallengecimeliaView, self._activityId)
end

function DivinefeiyinchallengegameView:_openChallengeNormalView(levelIndex)
	UIStateManager.instance:push(ViewName.DivinefeiyinchallengenomalView, self._activityId, levelIndex)
end

function DivinefeiyinchallengegameView:_openHidenView(levelIndex)
	UIStateManager.instance:push(ViewName.DivinefeiyinchallengehidenView, self._activityId, levelIndex)
end

return DivinefeiyinchallengegameView
