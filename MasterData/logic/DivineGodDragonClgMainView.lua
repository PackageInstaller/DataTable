-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinegoddragonclg/view/DivineGodDragonClgMainView.lua

module("logic.extensions.divinegoddragonclg.view.DivineGodDragonClgMainView", package.seeall)

local DivineGodDragonClgMainView = class("DivineGodDragonClgMainView", ViewComponent)

function DivineGodDragonClgMainView:ctor()
	DivineGodDragonClgMainView.super.ctor(self)
end

function DivineGodDragonClgMainView:unbindEvents()
	DivineGodDragonClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
end

function DivineGodDragonClgMainView:bindEvents()
	DivineGodDragonClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
end

function DivineGodDragonClgMainView:buildUI()
	DivineGodDragonClgMainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._txtTime = self:getTxt("time/txtTime")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._txtBuff = self:getTxt("buff/txtBuff")
	self._btnRank = self:getGo("btnRank")

	local playerRoot = self:getGo("playerRoot")

	self._rewardSliderMo = PlayerSliderMo.New(playerRoot)
	self._txtKillNum = self:getTxt("playerRoot/txtTotal")
end

function DivineGodDragonClgMainView:onExit()
	DivineGodDragonClgMainView.super.onExit(self)
	removetimer(self._onClock, self)
end

function DivineGodDragonClgMainView:onEnter()
	DivineGodDragonClgMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DivineGodDragonClgInfoRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_DivineGodDragonGainPrizeRes, self._refreshView, self)

	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._activityId = self:getFirstParam() or DivineGodDragonClgModel.instance:getCurrActId()
	self._activityCfg = DivineGodDragonClgConfig.instance:getActivityCfg(self._activityId)

	self:initSlider()
	DivineGodDragonClgAgent.instance:sendPM_DivineGodDragonClgInfoReq(self._activityId)

	local timeCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.DivineGodDragonClg, self._activityId)

	self._activityStartTime = GameUtil.string2time(timeCfg.startTime)
	self._activityEndTime = GameUtil.string2time(timeCfg.endTime)

	self:_onClock()
	settimer(1, self._onClock, self, true)
end

function DivineGodDragonClgMainView:_refreshView()
	local stageCfgs = DivineGodDragonClgConfig.instance:getStageCfgs(self._activityId)

	self._tableList:reloadData(stageCfgs)
	self._rewardSliderMo:updatePlayerReward()

	local day = GameUtil.getDaysByTimestamp(self._activityStartTime, ServerTime.now())
	local buffCfgs = DivineGodDragonClgConfig.instance:getBuffCfgs(self._activityId)

	day = day % #buffCfgs

	if day == 0 then
		day = #buffCfgs
	end

	local buffCfg = DivineGodDragonClgConfig.instance:getBuffCfg(self._activityId, day)

	self._txtBuff.text = buffCfg and buffCfg.buffDesc or lang("当前时间不存在buff")
	self._txtKillNum.text = DivineGodDragonClgModel.instance:getKillNum(self._activityId)
end

function DivineGodDragonClgMainView:initSlider()
	local sliderParam = {}

	sliderParam.view = self
	sliderParam.prizeCfgs = DivineGodDragonClgConfig.instance:getRewardProgressListCfgs(self._activityId)

	function sliderParam.getPlayerProgress()
		return DivineGodDragonClgModel.instance:getKillNum(self._activityId)
	end

	function sliderParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.killNum
	end

	function sliderParam.getPrizeByRewardCfg(rewardCfg)
		return rewardCfg.prize
	end

	function sliderParam.isPlayerRewardCanGet(rewardCfg)
		return DivineGodDragonClgModel.instance:isCanGetProgressReward(rewardCfg.activityId, rewardCfg.prizeId)
	end

	function sliderParam.isPlayerRewardGeted(rewardCfg)
		return DivineGodDragonClgModel.instance:isGetedProgressReward(rewardCfg.activityId, rewardCfg.prizeId)
	end

	function sliderParam.sendGainPlayerPrizeReq(rewardCfg)
		DivineGodDragonClgAgent.instance:sendPM_DivineGodDragonGainPrizeReq(self._activityId, rewardCfg.prizeId)
	end

	local isSkipAnimation = true

	self._rewardSliderMo:initParam(sliderParam, isSkipAnimation)
	self._rewardSliderMo:onEnter()
	self._rewardSliderMo:updatePlayerReward()
	self._rewardSliderMo:relocation()
end

function DivineGodDragonClgMainView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local bgChange = goutil.findChildComponent(go, "bg", "UIImageSpriteChange")

	txtName.text = data.name
	txtDesc.text = langPara("击杀数：%d", DivineGodDragonClgModel.instance:getStageKillNum(self._activityId, data.stageId))

	bgChange:ChangeSprite(data.bgRes)
	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		self:_onClickStage(data.stageId)
	end, self)
end

function DivineGodDragonClgMainView:_clearCell(cell)
	local go = cell.gameObject
	local petIcon = goutil.findChild(go, "petIcon")

	uGuiUtil.clearImage(petIcon)
end

function DivineGodDragonClgMainView:_onClickTip()
	TipsFacade.instance:openRulesView("divine_god_dragon_challenge")
end

function DivineGodDragonClgMainView:_onClickStage(stageId)
	local fmtMo = DivineGodDragonClgModel.instance:getFmtMo()

	fmtMo:initParams(self._activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function DivineGodDragonClgMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.DivineGodDragonClgRankView, self._activityId)
end

function DivineGodDragonClgMainView:_onClock()
	local lackTime = self._activityEndTime - ServerTime.now()

	self._txtTime.text = langPara("剩余：%s", GameUtil.FormatTimeWordsNoSec(lackTime))
end

return DivineGodDragonClgMainView
