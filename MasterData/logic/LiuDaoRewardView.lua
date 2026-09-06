-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liudao/view/LiuDaoRewardView.lua

module("logic.extensions.liudao.view.LiuDaoRewardView", package.seeall)

local LiuDaoRewardView = class("LiuDaoRewardView", ViewComponent)

function LiuDaoRewardView:ctor()
	LiuDaoRewardView.super.ctor(self)
end

function LiuDaoRewardView:buildUI()
	LiuDaoRewardView.super.buildUI(self)

	self._btnClose = self:getBtn("btnclose")

	local playerRoot = self:getGo("playerRoot")

	self._rewardSliderMo = PlayerSliderMo.New(playerRoot)
	self._tableView = self:getGo("taskScrollerview")
	self._tableCell = self:getGo("taskScrollercell")
	self._itemScrollercell = self:getGo("itemScrollercell")
	self._scrollerList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._itemScrollListDic = {}
	self._txtScore = self:getTxt("playerRoot/txtTotal")
	self._btnLingshen = self:getBtn("btnLingshen")
	self._btnLunhua = self:getBtn("btnLunhua")
	self._btnYuansushi = self:getBtn("btnYuansushi")
	self._effectLingshenGo = self:getGo("effectLingshen")
	self._effectLunhuaGo = self:getGo("effectLunhua")
	self._effectYuansushiGo = self:getGo("effectYuansushi")
end

function LiuDaoRewardView:bindEvents()
	LiuDaoRewardView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnLingshen, self._onClickLingshen, self)
	GameUtil.addClickHandler(self._btnLunhua, self._onClickLunhua, self)
	GameUtil.addClickHandler(self._btnYuansushi, self._onClickYuansushi, self)
end

function LiuDaoRewardView:unbindEvents()
	LiuDaoRewardView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnLingshen)
	GameUtil.rmClickHandler(self._btnLunhua)
	GameUtil.rmClickHandler(self._btnYuansushi)
end

function LiuDaoRewardView:onEnter()
	LiuDaoRewardView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.LiuDaoGetTaskInfoRes, self._refreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.LiuDaoGainProgressPrizeRes, self._PM_LiuDaoGainProgressPrizeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.LiuDaoGainTaskPrizeRes, self._PM_LiuDaoGainTaskPrizeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.ItemGetViewDoClosed, self._progressEffectShow, self)

	self._activityId = self:getFirstParam()
	self._activityCfg = LiuDaoConfig.instance:getActivityCfg(self._activityId)

	self:initSlider()
	LiuDaoController.instance:sendPM_LiuDaoGetTaskInfoReq(self._activityId)
end

function LiuDaoRewardView:onExit()
	LiuDaoRewardView.super.onExit(self)
	LiuDaoController.instance:sendPM_LiuDaoGetInfoReq(self._activityId)
	self._rewardSliderMo:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.LiuDaoGetTaskInfoRes, self._refreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.LiuDaoGainProgressPrizeRes, self._PM_LiuDaoGainProgressPrizeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.LiuDaoGainTaskPrizeRes, self._PM_LiuDaoGainTaskPrizeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.ItemGetViewDoClosed, self._progressEffectShow, self)

	if self._effectLingshen then
		UIEffectManager.instance:stopEffect(self._effectLingshen)
	end

	if self._effectLunhua then
		UIEffectManager.instance:stopEffect(self._effectLunhua)
	end

	if self._effectYuansushi then
		UIEffectManager.instance:stopEffect(self._effectYuansushi)
	end
end

function LiuDaoRewardView:_refreshUI()
	self._weekIndex = LiuDaoModel.instance:getWeekIndex()

	local gainTaskPrizeIds = LiuDaoModel.instance:gainTaskPrizeIds()
	local taskInfo = LiuDaoModel.instance:getTaskInfo()
	local dataList = {}
	local doneList = {}

	for i, v in ipairs(taskInfo) do
		if gainTaskPrizeIds[i] then
			table.insert(doneList, v)
		else
			table.insert(dataList, v)
		end
	end

	for i = 1, #doneList do
		if #doneList > 0 then
			table.insert(dataList, doneList[1])
			table.remove(doneList, 1)
		end
	end

	self._scrollerList:reloadData(dataList)
	self._rewardSliderMo:updatePlayerReward()

	if self._txtScore then
		self._txtScore.text = langPara("%d", LiuDaoModel.instance:getTaskScore())
	end
end

function LiuDaoRewardView:initSlider()
	local sliderParam = {}

	sliderParam.view = self
	sliderParam.prizeCfgs = LiuDaoConfig.instance:getRewardProgressListCfgs(self._activityId)

	function sliderParam.getPlayerProgress()
		return LiuDaoModel.instance:getTaskScore()
	end

	function sliderParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.needScore
	end

	function sliderParam.getPrizeByRewardCfg(rewardCfg)
		return rewardCfg.prize
	end

	function sliderParam.isPlayerRewardCanGet(rewardCfg)
		return LiuDaoModel.instance:isCanGetProgressReward(rewardCfg.activityId, rewardCfg.id)
	end

	function sliderParam.isPlayerRewardGeted(rewardCfg)
		return LiuDaoModel.instance:isGetedProgressReward(rewardCfg.activityId, rewardCfg.id)
	end

	function sliderParam.sendGainPlayerPrizeReq(rewardCfg)
		LiuDaoAgent.instance:sendPM_LiuDaoGainProgressPrizeReq(self._activityId, rewardCfg.id)

		self._gettingProgress = rewardCfg.id
	end

	local isSkipAnimation = true

	self._rewardSliderMo:initParam(sliderParam, isSkipAnimation)
	self._rewardSliderMo:onEnter()
	self._rewardSliderMo:updatePlayerReward()
	self._rewardSliderMo:relocation()
end

function LiuDaoRewardView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local notDoneGo = goutil.findChild(go, "notDoneGo")
	local receivedGo = goutil.findChild(go, "receivedGo")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local txtTitle = goutil.findChildTextComponent(go, "txtTitle")
	local btnReceive = GameUtil.asBtn(goutil.findChild(go, "btnReceive"))
	local txtScore = goutil.findChildTextComponent(go, "txtTitle/txtProg")
	local itemScrollerview = goutil.findChild(go, "itemScrollerview")
	local txtProgress = goutil.findChildTextComponent(go, "txtProgress")
	local taskCfg = LiuDaoConfig.instance:getTaskInfo(self._activityId, self._weekIndex, data.taskId)

	txtTitle.text = taskCfg.taskTitle
	txtDesc.text = taskCfg.desc
	txtProgress.text = langPara("%d/%d", data.progress, taskCfg.maxProgress)

	if data.progress < taskCfg.maxProgress then
		GameUtil.SetActive(btnReceive, false)
		GameUtil.SetActive(notDoneGo, true)
		GameUtil.SetActive(receivedGo, false)
	else
		GameUtil.SetActive(notDoneGo, false)

		if data.hasGain then
			GameUtil.SetActive(btnReceive, false)
			GameUtil.SetActive(receivedGo, true)
		else
			GameUtil.SetActive(btnReceive, true)
			GameUtil.SetActive(receivedGo, false)
		end
	end

	local prizeStrArr = string.split(taskCfg.prize, "#")
	local prizeList = {}

	for i, v in ipairs(prizeStrArr) do
		local matType, id, matNum

		matType, id, matNum = MaterialMgr.getMatParams(v)

		if matType == MatType.ACTIVITY_ITEM and id == self._activityCfg.activityItemId then
			txtScore.text = matNum
		else
			table.insert(prizeList, {
				isBuff = false,
				prizeStr = v
			})
		end
	end

	if taskCfg.buffId > 0 then
		table.insert(prizeList, {
			isBuff = true,
			buffId = taskCfg.buffId
		})
	end

	if not self._itemScrollListDic[go] then
		local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

		self._itemScrollListDic[go] = itemScrollList

		itemScrollList:reloadData(prizeList)
		itemScrollList:dragNotifyParent()
		GameUtil.rmClickHandler(btnReceive)
		GameUtil.addClickHandler(btnReceive, function()
			LiuDaoAgent.instance:sendPM_LiuDaoGainTaskPrizeReq(self._activityId, data.taskId)
		end, self)
	end
end

function LiuDaoRewardView:_clearCell(cell)
	local go = cell.gameObject
	local btnReceive = GameUtil.asBtn(goutil.findChild(go, "btnReceive"))
	local itemScrollList = self._itemScrollListDic[go]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end

	GameUtil.rmClickHandler(btnReceive)
end

function LiuDaoRewardView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	uGuiUtil.clearImage(go)
	MaterialMgr.resetAll(go)

	if data.isBuff == true then
		local buffCfg = LiuDaoConfig.instance:getBuffCfg(data.buffId)

		uGuiUtil.setSpriteToImage(go, nil, GameUrl.getExpEventUrl(buffCfg.buffResName))

		local btn = GameUtil.asBtn(go)

		btn:AddClickListener(function()
			self:_onClickBuff(data.buffId)
		end, self)
	else
		MaterialMgr.setCellByCfg(data.prizeStr, go)
	end
end

function LiuDaoRewardView:_clearItemCell(cell)
	local go = cell.gameObject
	local btn = GameUtil.asBtn(go)

	if btn ~= nil then
		btn:RemoveClickListener()
	end

	uGuiUtil.clearImage(go)
	MaterialMgr.resetAll(go)
end

function LiuDaoRewardView:_onClickLingshen()
	local needScore = LiuDaoConfig.instance:getUnlockPage(self._activityId, 1)

	if needScore <= LiuDaoModel.instance:getTaskScore() then
		UIStateManager.instance:push(ViewName.LiuDaoLingsShenView)
	else
		FloatWordMgr.instance:show(langPara("活跃度达到%d解锁", needScore))
	end
end

function LiuDaoRewardView:_onClickLunhua()
	local needScore = LiuDaoConfig.instance:getUnlockPage(self._activityId, 2)

	if needScore <= LiuDaoModel.instance:getTaskScore() then
		UIStateManager.instance:push(ViewName.LiuDaoLunHuaView)
	else
		FloatWordMgr.instance:show(langPara("活跃度达到%d解锁", needScore))
	end
end

function LiuDaoRewardView:_onClickYuansushi()
	local needScore = LiuDaoConfig.instance:getUnlockPage(self._activityId, 3)

	if needScore <= LiuDaoModel.instance:getTaskScore() then
		UIStateManager.instance:push(ViewName.LiuDaoYuanSuShiView)
	else
		FloatWordMgr.instance:show(langPara("活跃度达到%d解锁", needScore))
	end
end

function LiuDaoRewardView:_onClickBuff(buffId)
	local cfg = LiuDaoConfig.instance:getBuffCfg(buffId)

	TipsFacade.instance:openCommonTips(cfg.buffDes)
end

function LiuDaoRewardView:_PM_LiuDaoGainProgressPrizeRes()
	LiuDaoController.instance:sendPM_LiuDaoGetTaskInfoReq(self._activityId)
end

function LiuDaoRewardView:_PM_LiuDaoGainTaskPrizeRes()
	LiuDaoController.instance:sendPM_LiuDaoGetTaskInfoReq(self._activityId)
	LiuDaoModel.instance:saveGetBuff()
end

function LiuDaoRewardView:_progressEffectShow()
	local cfg = LiuDaoConfig.instance:getRewardProgressCfg(self._activityId, self._gettingProgress)
	local effectUnlockPath = "20220930/liudaolunhua/fx_ui_ldlh_jiesuo.prefab"

	if cfg and cfg.unlockPage then
		for i, v in ipairs(cfg.unlockPage) do
			if v == 3 then
				self._effectLingshen = UIEffectManager.instance:playEffect(self, effectUnlockPath, nil, 0, 0, false)

				self._effectLingshen:setParent(self._effectLingshenGo.transform)
				self._effectLingshen:setScale(1)
				self._effectLingshen:setLocalPos(0)
			elseif v == 2 then
				self._effectLunhua = UIEffectManager.instance:playEffect(self, effectUnlockPath, nil, 0, 0, false)

				self._effectLunhua:setParent(self._effectLunhuaGo.transform)
				self._effectLunhua:setScale(1)
				self._effectLunhua:setLocalPos(0)
			elseif v == 1 then
				self._effectYuansushi = UIEffectManager.instance:playEffect(self, effectUnlockPath, nil, 0, 0, false)

				self._effectYuansushi:setParent(self._effectYuansushiGo.transform)
				self._effectYuansushi:setScale(1)
				self._effectYuansushi:setLocalPos(0)
			end
		end
	end

	self._gettingProgress = 0
end

return LiuDaoRewardView
