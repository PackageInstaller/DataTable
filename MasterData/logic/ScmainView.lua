-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/ScmainView.lua

module("logic.extensions.scenariocopy.view.ScmainView", package.seeall)

local ScmainView = class("ScmainView", ViewComponent)

function ScmainView:ctor()
	ScmainView.super.ctor(self)
end

function ScmainView:buildUI()
	ScmainView.super.buildUI(self)

	self._tableGo = self:getGo("tableview")
	self._itemGo = self:getGo("tablecell")
	self._btnBg = self:getBtn("canvas180/bg2")
	self._effect = self:getGo("effect")
	self._btnEeffectGO = self:getGo("trial/effect")
	self._btnClose = self:getBtn("topleft/btnClose")
	self._cells = {}

	for i = 1, 4 do
		table.insert(self._cells, self:getGo("tablecell_" .. i))
	end

	self._btnTrial = self:getBtn("trial/btnTrial")
	self._trialRedPoint = self:getGo("trial/btnTrial/redPoint")
	self._btnGetPrize = self:getBtn("prize/btnClick")
	self._txtGetPrize = self:getTxt("prize/btnClick/Text")
	self._prizeRedPoint = self:getGo("prize/redPoint")
	self._iconPrize = self:getGo("prize/prize/icon")
	self._iconBuff = self:getGo("prize/buff/icon")
	self._txtIcon = self:getTxt("prize/buff/txtIcon")
end

function ScmainView:bindEvents()
	ScmainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTrial:AddClickListener(self._onClickTrial, self)
	self._btnGetPrize:AddClickListener(self._onClickGetPrize, self)
end

function ScmainView:unbindEvents()
	ScmainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTrial:RemoveClickListener()
	self._btnGetPrize:RemoveClickListener()
end

function ScmainView:destroyUI()
	ScmainView.super.destroyUI(self)

	for i = 1, 4 do
		local btnClick = goutil.findChildButtonComponent(self._cells[i], "container")

		GameUtil.asBtn(btnClick):RemoveClickListener()
	end
end

function ScmainView:onEnter()
	ScmainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.RedPointUpdate, self._refreshRedPoint, self)
	GlobalDispatcher:addListener(GlobalNotify.ScmainDailyRefresh, self.dailyRefresh, self)

	if not ScenariocopyModel.instance:refreshActIdandPlotId() then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("活动已结束"), GameUtil.handler(self.close, self))

		return
	end

	local actId = ScenariocopyModel.instance:getActivityId()
	local scCfg = ScenariocopyConfig.instance:getActCfg(actId)
	local actCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.OperationPlot, actId)
	local leftDay = scCfg.leftDayTip
	local energy = scCfg.energy

	if not string.nilorempty(leftDay) then
		local key = "yyfb_leftday_tip"
		local leftDayStamp = GameUtil.string2time(leftDay)
		local hasShowToday = checkbool(GameUtil.getUserDayData(key))
		local curTime = ServerTime.now()

		if leftDayStamp <= ServerTime.now() and hasShowToday == false and curTime < GameUtil.string2time(actCfg.endTime) then
			local timeTab = GameUtil.string2date(actCfg.endTime)
			local endStr = langPara("%s月%s日 %02d:%02d:%02d", timeTab.month, timeTab.day, timeTab.hour, timeTab.min, timeTab.sec)
			local matCfg = MaterialMgr.getMatCfgByStr(energy)

			TipsFacade.instance:openTipWindowNoX("温馨提示", langPara("%s将于%s过期，\n请及时体验本期活动剧情", matCfg.name, endStr), function()
				GameUtil.saveUserDayData(key, true)
			end, "知道了", UnityEngine.TextAnchor.MiddleCenter)
		end
	end

	self._selectStoryId = ScenariocopyModel.instance:getTypeId()

	local planId = ScenariocopyModel.instance:getPlotId()

	self.chapterCfg = ScenariocopyConfig.instance:getStoryCfgs(planId)
	self._chapterList = {}

	for k, v in pairs(self.chapterCfg) do
		table.insert(self._chapterList, v)
	end

	table.sort(self._chapterList, function(a, b)
		return a.typeId < b.typeId
	end)

	local storyIdExist = ScenariocopyModel.instance:getTypeId()

	self._selectStoryId = storyIdExist and storyIdExist or self._chapterList[1].typeId

	self:_refreshTab()
	self:_showEffect()
	self:_refreshTrial()
	self:_refreshRedPoint()
end

function ScmainView:onEnterFinished()
	ScmainView.super.onEnterFinished(self)
end

function ScmainView:onExit()
	ScmainView.super.onExit(self)

	if self._centerEffect then
		UIEffectManager.instance:stopEffect(self._centerEffect)

		self._centerEffect = nil
	end

	if self._btnEffect then
		UIEffectManager.instance:stopEffect(self._btnEffect)

		self._btnEffect = nil
	end

	GlobalDispatcher:removeListener(GlobalNotify.RedPointUpdate, self._refreshRedPoint, self)
	GlobalDispatcher:removeListener(GlobalNotify.ScmainDailyRefresh, self.dailyRefresh, self)
	MaterialMgr.resetAll(self._iconPrize)
	uGuiUtil.clearImage(self._iconBuff)
end

function ScmainView:onExitFinished()
	ScmainView.super.onExitFinished(self)
end

function ScmainView:_refreshTrial()
	local trialId = ScenariocopyModel.instance:getTrialId()
	local trialCfg = ScenariocopyConfig.instance:getTrialCfg(trialId)
	local cfgs = ScenariocopyConfig.instance:getBuffCfg(trialCfg.buffPlanId)
	local level = ScenariocopyModel.instance:getBuffLevel()
	local buffCfg = cfgs[level]

	if buffCfg == nil then
		buffCfg = cfgs[1]
	end

	local proxy = MaterialMgr.setCellByCfg(buffCfg.showPrize, self._iconPrize)

	proxy.binder:setBgActive(false)

	local tempStr = string.split(buffCfg.selfBuff, ":")
	local buffId = tempStr[1]
	local buffIcon = BattleConfig.instance:getBuffCo(checknumber(buffId))

	uGuiUtil.setSpriteToImage(self._iconBuff, GameUrl.getExpEventUrl(buffIcon.icon))

	self._txtIcon.text = buffCfg.des
end

function ScmainView:_refreshRedPoint()
	for i = 1, 4 do
		local cell = self._cells[i]
		local data = self._chapterList[i]

		if data then
			local redPoint = goutil.findChild(cell, "container/redPoint")
			local isUnLock = ScenariocopyController.instance:getStoryIfUnlockAndText(data.typeId)
			local isRed = ScenariocopyController.instance:getStoryRedPoint(data.typeId) == 1

			redPoint.gameObject:SetActive(isRed and isUnLock)
		end
	end

	local trialId = ScenariocopyModel.instance:getTrialId()
	local isRed = ScenariocopyController.instance:getTrialedPoint(trialId) == 1

	goutil.setActive(self._trialRedPoint, isRed)

	local hasGet = ScenariocopyModel.instance:getHasGainBuffPrize()

	goutil.setActive(self._prizeRedPoint, not hasGet)
	GameUtil.SetGray(self._btnGetPrize.gameObject, hasGet)

	self._txtGetPrize.text = hasGet and "已领取" or "领取祝福"
end

function ScmainView:_refreshTab()
	for i = 1, 4 do
		if i > #self._chapterList then
			goutil.setActive(self._cells[i], false)
		else
			goutil.setActive(self._cells[i], true)
			self:_updateCell(nil, self._cells[i], self._chapterList[i], i)
		end
	end
end

function ScmainView:_refreshBigBg()
	return
end

function ScmainView:_showEffect()
	if self._centerEffect then
		UIEffectManager.instance:stopEffect(self._centerEffect)

		self._centerEffect = nil
	end

	local path = "fx_ui_zhaohuanshidalu/fx_ui_jiemian_zhaohuanshidalu.prefab"

	self._centerEffect = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, nil, nil, function(finishHandlerTarget, eff)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
	end)

	self._centerEffect:setParent(self._effect.transform)
	self._centerEffect:setScale(1)

	self._centerEffect.hideEffWhileNotOnTop = true

	if self._btnEffect then
		UIEffectManager.instance:stopEffect(self._btnEffect)

		self._btnEffect = nil
	end

	local path = "fx_ui_zhaohuanshidalu/fx_ui_anniu_zhanhuanshidalu.prefab"

	self._btnEffect = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, nil, nil, function(finishHandlerTarget, eff)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
	end)

	self._btnEffect:setParent(self._btnEeffectGO.transform)
	self._btnEffect:setScale(1)

	self._btnEffect.hideEffWhileNotOnTop = true
end

function ScmainView:_updateCell(view, cell, data, index)
	local selectGo = goutil.findChild(cell, "container/selected")
	local lockGo = goutil.findChild(cell, "container/lock")
	local btnClick = goutil.findChildButtonComponent(cell, "container")
	local txtName = goutil.findChildTextComponent(cell, "container/txtName")
	local redPoint = goutil.findChild(cell, "container/redPoint")
	local sprite = goutil.findChild(cell, "container/icon")
	local txtLock = goutil.findChildTextComponent(cell, "container/lock/txtLock")

	selectGo.gameObject:SetActive(data.typeId == self._selectStoryId)

	txtName.text = data.storyName

	local isUnLock, txtTip = ScenariocopyController.instance:getStoryIfUnlockAndText(data.typeId)

	txtLock.text = langPara(txtTip)

	lockGo.gameObject:SetActive(not isUnLock)
	redPoint.gameObject:SetActive(isRed and isUnLock)

	local isRed = ScenariocopyController.instance:getStoryRedPoint(data.typeId) == 1

	GameUtil.asBtn(btnClick):AddClickListener(function()
		self:_switchTab(cell, data, index)
	end)

	if not string.nilorempty(data.btnBg) then
		uGuiUtil.setSpriteToImage(sprite, uGuiUtil.SpriteType.BigBg, GameUrl.getScenarioCopyUrl(data.btnBg))
	end
end

function ScmainView:_switchTab(cell, data, index)
	self._selectStoryId = data.typeId

	local condition, txtTip = ScenariocopyController.instance:getStoryIfUnlockAndText(self._selectStoryId)

	if condition == true then
		self:_onClickEnter()
	else
		FloatWordMgr.instance:show(txtTip)
	end
end

function ScmainView:_clearCell(cell)
	local sprite = goutil.findChild(cell, "container")

	uGuiUtil.clearImage(sprite)
end

function ScmainView:_onClickEnter()
	ScenariocopyController.instance:setStoryRedPoint(self._selectStoryId, 2)

	local target = {
		typeId = self._selectStoryId
	}

	ScenariocopyController.instance:openSclevelsView(target)
end

function ScmainView:_onClickTrial()
	ScenariocopyController.instance:openTrialView()
end

function ScmainView:_onClickGetPrize()
	local actId = ScenariocopyModel.instance:getActivityId()

	OperationPlotAgent.instance:sendPM_OperationPlotGainBuffPrizeReq(actId, function(msg)
		MaterialFacade.instance:popAndShowChangeSetItems(msg.changeSetId)
		ScenariocopyModel.instance:setHasGainBuffPrize(true)

		local trialId = ScenariocopyModel.instance:getTrialId()
		local trialCfg = ScenariocopyConfig.instance:getTrialCfg(trialId)
		local curLevel = ScenariocopyModel.instance:getBuffLevel()
		local cfgs = ScenariocopyConfig.instance:getBuffCfg(trialCfg.buffPlanId)
		local maxLevel = table.nums(cfgs)

		if curLevel < maxLevel then
			ScenariocopyModel.instance:setBuffLevel(curLevel + 1)
		end

		self:_refreshRedPoint()
	end)
end

function ScmainView:dailyRefresh()
	if ScenariocopyModel.instance:refreshActIdandPlotId() then
		self:_refreshTrial()
		self:_refreshRedPoint()
	else
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("活动已结束"), GameUtil.handler(self.close, self))
	end
end

return ScmainView
