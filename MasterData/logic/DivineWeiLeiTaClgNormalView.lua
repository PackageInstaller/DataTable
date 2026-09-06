-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineweileitaclg/view/DivineWeiLeiTaClgNormalView.lua

module("logic.extensions.divineweileitaclg.view.DivineWeiLeiTaClgNormalView", package.seeall)

local DivineWeiLeiTaClgNormalView = class("DivineWeiLeiTaClgNormalView", ViewComponent)

function DivineWeiLeiTaClgNormalView:ctor()
	DivineWeiLeiTaClgNormalView.super.ctor(self)
end

function DivineWeiLeiTaClgNormalView:unbindEvents()
	DivineWeiLeiTaClgNormalView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnScoreTip)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function DivineWeiLeiTaClgNormalView:bindEvents()
	DivineWeiLeiTaClgNormalView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnScoreTip, self._onClickScoreTip, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
end

function DivineWeiLeiTaClgNormalView:buildUI()
	DivineWeiLeiTaClgNormalView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnScoreTip = self:getGo("btnScoreTip")
	self._btnChallenge = self:getGo("btnChallenge")

	local playerRoot = self:getGo("playerRoot")

	self._rewardSliderMo = PlayerSliderMo.New(playerRoot)
	self._con = self:getGo("con")
	self._tableCell = self:getGo("tableCell")
	self._tableView = self:getGo("tableView")
	self._tableList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtDamage = goutil.findChildComponent(self.mainGO, "damage/txtDamage", ComponentType.UIImgNumeralText)
	self._txtScore = self:getTxt("playerRoot/txtScore")
end

function DivineWeiLeiTaClgNormalView:onExit()
	DivineWeiLeiTaClgNormalView.super.onExit(self)

	if self._roleObj then
		RoleObjectPool.instance:removeRole(self._roleObj)

		self._roleObj = nil
	end

	self._tableList:dispose()
end

function DivineWeiLeiTaClgNormalView:onEnter()
	DivineWeiLeiTaClgNormalView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineWeiLeiTaClgNormalRefresh, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_NotifyDivineWeiLeiTaNormalClgFinishRes, self._PM_NotifyDivineWeiLeiTaNormalClgFinishRes, self)

	self._activityId = self:getFirstParam()
	self._activityCfg = DivineWeiLeiTaClgConfig.instance:getActivityCfg(self._activityId)
	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._activityCfg.raceId, self._con)

	DivineWeiLeiTaClgAgent.instance:sendPM_DivineWeiLeiTaClgNormalInfoReq(self._activityId)
	self:_initSlider()
end

function DivineWeiLeiTaClgNormalView:_refreshView()
	local gainPrizeIds = DivineWeiLeiTaClgModel.instance:getGainPrizeIds(self.activityId)
	local prizeCfgs = DivineWeiLeiTaClgConfig.instance:getRewardProgressListCfgs(self._activityId)

	if #gainPrizeIds >= #prizeCfgs then
		self:close()

		return
	end

	self._creepMasterId = DivineWeiLeiTaClgModel.instance:getTodayCreepMasterId(self._activityId)

	if checknumber(self._creepMasterId) > 0 then
		local descCfgs = DivineWeiLeiTaClgConfig.instance:getNormalDesc(self._creepMasterId)

		self._tableList:reloadData(descCfgs)
	else
		self._tableList:reloadData({})
	end

	self._rewardSliderMo:updatePlayerReward()

	local todayMaxDamage = DivineWeiLeiTaClgModel.instance:getTodayMaxDamage(self._activityId)

	self._txtDamage:SetNum(todayMaxDamage)

	self._txtScore.text = DivineWeiLeiTaClgModel.instance:getScore(self._activityId)
end

function DivineWeiLeiTaClgNormalView:_initSlider()
	local sliderParam = {}

	sliderParam.view = self
	sliderParam.prizeCfgs = DivineWeiLeiTaClgConfig.instance:getRewardProgressListCfgs(self._activityId)

	function sliderParam.getPlayerProgress()
		return DivineWeiLeiTaClgModel.instance:getScore(self._activityId)
	end

	function sliderParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.score
	end

	function sliderParam.getPrizeByRewardCfg(rewardCfg)
		return rewardCfg.prize
	end

	function sliderParam.isPlayerRewardCanGet(rewardCfg)
		return DivineWeiLeiTaClgModel.instance:isCanGetProgressReward(rewardCfg.activityId, rewardCfg.prizeId)
	end

	function sliderParam.isPlayerRewardGeted(rewardCfg)
		return DivineWeiLeiTaClgModel.instance:isGetedProgressReward(rewardCfg.activityId, rewardCfg.prizeId)
	end

	function sliderParam.sendGainPlayerPrizeReq(rewardCfg)
		DivineWeiLeiTaClgAgent.instance:sendPM_DivineWeiLeiTaClgGainPrizeReq(self._activityId, rewardCfg.prizeId)
	end

	sliderParam.playerSliderCellClass = DivineWeiLeiTaClgSliderCell

	local isSkipAnimation = true

	self._rewardSliderMo:initParam(sliderParam, isSkipAnimation)
	self._rewardSliderMo:onEnter()
	self._rewardSliderMo:updatePlayerReward()
	self._rewardSliderMo:relocation()
end

function DivineWeiLeiTaClgNormalView:_onClickScoreTip()
	UIStateManager.instance:push(ViewName.DivineWeiLeiTaClgScoreView, self._activityId)
end

function DivineWeiLeiTaClgNormalView:_onClickChallenge()
	local normalGainPrizeIds = DivineWeiLeiTaClgModel.instance:getGainPrizeIds(self._activityId)
	local normalPrizeCfgs = DivineWeiLeiTaClgConfig.instance:getRewardProgressListCfgs(self._activityId)
	local normalClgPass = #normalGainPrizeIds >= #normalPrizeCfgs

	if not normalClgPass then
		local fmtMo = DivineWeiLeiTaClgModel.instance:getNormalFmtMo()

		fmtMo:initParams(self._activityId, self._creepMasterId)
		CustomFmtController.instance:showMissionView(fmtMo)
	else
		FloatWordMgr.instance:show(lang("已获得全部奖励，无需继续挑战"))
	end
end

function DivineWeiLeiTaClgNormalView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")

	MaterialMgr.resetAll(con)
	MaterialMgr.setCell(MatType.Pet, data.raceId, con)

	txtDesc.text = data.desc
end

function DivineWeiLeiTaClgNormalView:_clearCell(cell)
	return
end

function DivineWeiLeiTaClgNormalView:_PM_NotifyDivineWeiLeiTaNormalClgFinishRes()
	DivineWeiLeiTaClgAgent.instance:sendPM_DivineWeiLeiTaClgNormalInfoReq(self._activityId)
end

return DivineWeiLeiTaClgNormalView
