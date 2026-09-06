-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankverify/view/RankVerifyView.lua

module("logic.extensions.rankverify.view.RankVerifyView", package.seeall)

local RankVerifyView = class("RankVerifyView", ViewComponent)

function RankVerifyView:buildUI()
	RankVerifyView.super.buildUI(self)

	self.totalTaskNums = 3
	self.btnClose = self:getBtn("btnClose")
	self.btnTip = self:getBtn("btnTip")
	self.enterCells = {}
	self.prizeCells = {}

	for i = 1, self.totalTaskNums do
		local enterCell = {}

		enterCell.go = self:getGo("enterList/cell_" .. i)
		enterCell.mark = goutil.findChild(enterCell.go, "mark")
		enterCell.btnEnter = goutil.findChild(enterCell.go, "btnEnter")
		enterCell.btnVerify = goutil.findChild(enterCell.go, "btnVerify")
		enterCell.txtDesc = goutil.findChildTextComponent(enterCell.go, "txtDesc")
		enterCell.txtName = goutil.findChildTextComponent(enterCell.btnEnter, "txtName")
		enterCell.cfg = nil
		self.enterCells[i] = enterCell

		local prizeCell = {}

		prizeCell.go = self:getGo("prize_" .. i)
		prizeCell.item = goutil.findChild(prizeCell.go, "item")
		prizeCell.btnGain = goutil.findChild(prizeCell.go, "btngain")
		prizeCell.mark = goutil.findChild(prizeCell.go, "receive")
		prizeCell.eff = nil
		prizeCell.cfg = nil
		self.prizeCells[i] = prizeCell
	end

	self.txtTip = self:getTxt("progress/txtTip")
	self.txtTime = self:getTxt("time/txt")
	self.sldProgress = self:getSlider("progress")
end

function RankVerifyView:onEnter()
	RankVerifyView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.RankVerifyInfoUpdate, self._refreshViewByData, self)

	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.RankVerify)

	self._actId = actCfg and actCfg.activityId

	if self._actId then
		self:_refreshViewByCfg()
		RankVerifyController.instance:getInfo(self._actId)
	end

	local timeStart = GameUtil.string2time(actCfg.startTime)
	local timeEnd = GameUtil.string2time(actCfg.endTime)

	self.txtTime.text = langPara("活动时间：%s5点-%s5点", GameUtil.formatTimeStamp("%y年%m月%d日", timeStart), GameUtil.formatTimeStamp("%y年%m月%d日", timeEnd))
end

function RankVerifyView:onExit()
	RankVerifyView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.RankVerifyInfoUpdate, self._refreshViewByData, self)

	for i = 1, self.totalTaskNums do
		local prizeCell = self.prizeCells[i]

		MaterialMgr.resetAll(prizeCell.item)

		if prizeCell.eff then
			UIEffectManager.instance:stopEffect(prizeCell.eff)
		end
	end
end

function RankVerifyView:bindEvents()
	RankVerifyView.super.bindEvents(self)

	for i = 1, self.totalTaskNums do
		GameUtil.addClickHandler(self.enterCells[i].btnEnter, GameUtil.handler(self._onClickEnter, self, i))
		GameUtil.addClickHandler(self.enterCells[i].btnVerify, GameUtil.handler(self._onClickVerify, self, i))
		GameUtil.addClickHandler(self.prizeCells[i].btnGain, GameUtil.handler(self._onClickGain, self, i))
	end

	self.btnClose:AddClickListener(self.close, self)
	self.btnTip:AddClickListener(self._onClickRule, self)
end

function RankVerifyView:unbindEvents()
	RankVerifyView.super.unbindEvents(self)

	for i = 1, self.totalTaskNums do
		GameUtil.rmClickHandler(self.enterCells[i].btnEnter)
		GameUtil.rmClickHandler(self.enterCells[i].btnVerify)
		GameUtil.rmClickHandler(self.prizeCells[i].btnGain)
	end

	self.btnClose:RemoveClickListener()
	self.btnTip:RemoveClickListener()
end

function RankVerifyView:_refreshViewByCfg()
	local prizeCfgs = RankVerifyConfig.instance:getPrizeCfgs(self._actId)
	local taskCfgs = RankVerifyConfig.instance:getTaskCfgs(self._actId)

	for i = 1, self.totalTaskNums do
		local prizeCell = self.prizeCells[i]

		prizeCell.cfg = prizeCfgs[i]

		if prizeCell.cfg then
			MaterialMgr.resetAll(prizeCell.item)
			MaterialMgr.setCellByCfg(prizeCell.cfg.prize, prizeCell.item)
			goutil.setActive(prizeCell.go, true)
		else
			goutil.setActive(prizeCell.go, false)
		end

		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		prizeCell.eff = UIEffectManager.instance:playEffect(self, effPath, prizeCell.btnGain.transform, 0, 0, true, false, nil, function(target, eff)
			eff.effGo.transform:SetParent(prizeCell.btnGain.transform)
			GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
			GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)
			eff:setClipping(prizeCell.btnGain:GetComponent(goutil.Type_RectTransform))
		end)

		local enterCell = self.enterCells[i]

		enterCell.cfg = taskCfgs[i]

		if enterCell.cfg then
			enterCell.txtDesc.text = enterCell.cfg.taskDesc
			enterCell.txtName.text = enterCell.cfg.enterName

			goutil.setActive(enterCell.go, true)
		else
			goutil.setActive(enterCell.go, false)
		end
	end
end

function RankVerifyView:_refreshViewByData()
	self._curProgress = RankVerifyModel.instance:getCurProgress()

	local prizeNum = 0

	for i = 1, self.totalTaskNums do
		local prizeCell = self.prizeCells[i]
		local isHasGain = RankVerifyModel.instance:getIsHasGainPrize(self._actId, i)
		local curProgressMatch = self._curProgress >= prizeCell.cfg.needProgress

		goutil.setActive(prizeCell.btnGain, not isHasGain and curProgressMatch)

		if curProgressMatch then
			prizeNum = prizeNum + 1
		end

		goutil.setActive(prizeCell.mark, isHasGain)

		local enterCell = self.enterCells[i]
		local isHasVerify = RankVerifyModel.instance:getIsHasVerifyTask(self._actId, i)

		goutil.setActive(enterCell.btnVerify, not isHasVerify)
		goutil.setActive(enterCell.mark, isHasVerify)
	end

	local startProress = self.prizeCells[1].cfg.needProgress
	local sldValue = checknumber(self._curProgress - startProress) / checknumber(self.prizeCells[self.totalTaskNums].cfg.needProgress - startProress)

	self.sldProgress:SetValue(sldValue)

	self.txtTip.text = langPara("进度奖励\n%s/%s", prizeNum, self.totalTaskNums)
end

function RankVerifyView:_onError(status)
	if status == -24705 then
		FloatWordMgr.instance:show(lang("目标未达成！"))
	end
end

function RankVerifyView:_onClickEnter(id)
	local enterCell = self.enterCells[id]

	if enterCell.cfg then
		if not string.nilorempty(enterCell.cfg) then
			GotoMgr.gotoByString(enterCell.cfg)
		end
	end
end

function RankVerifyView:_onClickVerify(id)
	RankVerifyController.instance:verifyTask(self._actId, id)
end

function RankVerifyView:_onClickGain(id)
	RankVerifyController.instance:gainPrize(self._actId, id)
end

function RankVerifyView:_onClickRule()
	UIStateManager.instance:push(ViewName.RulesView, "rankverifyview")
end

return RankVerifyView
