-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tcpanduola/PanduolamainView.lua

module("logic.extensions.timelimitedchallenge.view.tcpanduola.PanduolamainView", package.seeall)

local PanduolamainView = class("PanduolamainView", TimeLimitedMainView)

function PanduolamainView:ctor()
	PanduolamainView.super.ctor(self)

	self._challengeId = 2
end

function PanduolamainView:buildUI()
	PanduolamainView.super.buildUI(self)

	self._btnRandom = self:getGo("buff/btnRandom")
	self._btnOpen = self:getGo("buff/btnOpen")
	self._txtCoin = goutil.findChildTextComponent(self._btnRandom, "txtMoney")
	self._imgCoin = goutil.findChild(self._txtCoin.gameObject, "icon")
	self._goSuccess = self:getGo("goSucess")
	self._btnReward = self:getBtn("btnReward")
	self._tipReward = self:getGo("tipReward")
	self._pointRewardItem = goutil.findChild(self._tipReward, "pointItem")
	self._txtTipReward = goutil.findChildTextComponent(self._tipReward, "txtTip")
end

function PanduolamainView:_onClickReward()
	UIStateManager.instance:open(ViewName.TLCRewardView, self._info)
end

function PanduolamainView:bindEvents()
	PanduolamainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnRandom, self._onClickRandom, self)
	GameUtil.addClickHandler(self._btnOpen, self._onClickRandom, self)
	self._btnReward:AddClickListener(self._onClickReward, self)
end

function PanduolamainView:unbindEvents()
	PanduolamainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnRandom)
	GameUtil.rmClickHandler(self._btnOpen)
	self._btnReward:RemoveClickListener()
end

function PanduolamainView:_setEffectUrls()
	self._effPaths = {
		{
			goPath = "btnStart",
			path = "fx_ui_xianshitiaozhan/fx_ui_panduolaxianshitiaozhan_anniu.prefab"
		},
		{
			goPath = "",
			path = "fx_ui_xianshitiaozhan/fx_ui_panduolaxianshitiaozhan_fenwei.prefab"
		},
		{
			goPath = "imgSlogan",
			path = "fx_ui_xianshitiaozhan/fx_ui_panduolaxianshitiaozhan_saoguang.prefab"
		}
	}
end

function PanduolamainView:onEnter()
	PanduolamainView.super.onEnter(self)
	TimedChallengeAccumulateAgent.instance:sendPM_TimedChallengeAccumulateInfoReq(self._challengeId, self._onFightInfoRes, self)
end

function PanduolamainView:onExit()
	PanduolamainView.super.onExit(self)
end

function PanduolamainView:_onFightInfoRes(msg)
	TLChallengeModel.instance:setFightInfo(self._challengeId, msg)
	self:_updateUI()
end

function PanduolamainView:_updateUI()
	self._info = TLChallengeModel.instance:getFightInfo(self._challengeId)

	local totalDamage = self._info.totalDamage
	local fightCfg = TimeLimitedConfig.instance:getAccumulateFightCfg(self._challengeId)

	if VipModel.instance:getCurVipLv() < 1 then
		if not fightCfg.normalDailyTimes then
			local maxDailyTimes = fightCfg.vipDailyTimes

			self._leftChallengeCount = maxDailyTimes - self._info.hasFightTimes
			self._leftChallengeCount = math.max(0, self._leftChallengeCount)
			self._txtLeftChallengeCount.text = string.format("今天剩余次数：  <color=#4FEA91FF>%s</color>/%s", self._leftChallengeCount, maxDailyTimes)

			self:_updateBuffUI()

			self._coinType, self._coinId, self._coinNum = unpack(string.splitToNumber(fightCfg.reGainBuffCost, ":"))

			print(self._coinType, self._coinId, self._coinNum)

			local cfg = MaterialMgr.getMatCfg(self._coinType, self._coinId)

			uGuiUtil.setSpriteToImage(self._imgCoin, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(cfg.icon))

			if self._coinNum > 0 then
				self._txtCoin.text = self._coinNum or "免费"
			end

			self._isSuccess = totalDamage >= self._info.maxProgress

			goutil.setActive(self._goSuccess, self._isSuccess)

			self._vipAddTimes = fightCfg.vipDailyTimes - fightCfg.normalDailyTimes
			self._txtVip.text = string.format("VIP1用户每天额外多<color=#4FEA91FF>%s</color>次", self._vipAddTimes)
			self._txtStart.text = self._leftChallengeCount > 0 and "进入\n挑战" or "明日\n再来"

			local cfgs = TimeLimitedConfig.instance:getAccumulateProgressCfgs(self._challengeId)
			local cfg = cfgs[#cfgs]
			local firstPrize = unpack(string.split(cfg.prize))

			MaterialMgr.setCellByCfg(firstPrize, self._pointRewardItem)

			self._txtTipReward.text = string.format("累积伤害\n%s万", self._info.maxProgress / 10000)

			self._tipReward.gameObject:SetActive(self._info.totalDamage < self._info.maxProgress)

			local petRankThreshold = fightCfg.petRankThreshold

			self._tipRank.gameObject:SetActive(petRankThreshold > self._info.petRankSize)

			self._txtTipRank.text = string.format("前%s名\n可获得", petRankThreshold)

			MaterialMgr.setCellByCfg(fightCfg.petRankPrize, self._pointRankItem)
		end
	end
end

function PanduolamainView:_updateBuffUI()
	local buffId = self._info.validBuffId

	self._hasBuff = checknumber(buffId) > 0

	self._btnOpen:SetActive(not self._hasBuff)
	self._btnRandom:SetActive(self._hasBuff)
	self._buffCell:updateWithPanduolaBuffId(buffId)
	self._buffCell:setActive(self._hasBuff)
	self._txtNull:SetActive(not self._hasBuff)
end

function PanduolamainView:_onClickBuffTips()
	UIStateManager.instance:push(ViewName.TimelimitedeffectpreView, self._challengeId)
end

function PanduolamainView:_onClickRandom()
	if self._isSuccess then
		FloatWordMgr.instance:show("已经通关，无需重抽")
	else
		TLChallengeController.instance:getRandomBuff(self._updateBuffUI, self)
	end
end

function PanduolamainView:_onStartBuff()
	self:_updateBuffUI()
	self:_onClickStart()
end

function PanduolamainView:_onClickStart()
	if self._isSuccess then
		FloatWordMgr.instance:show("已经通关，无需挑战")

		return
	end

	if self._leftChallengeCount < 1 then
		FloatWordMgr.instance:show("今天的挑战次数已经用完了")

		return
	end

	if self._hasBuff ~= true then
		TLChallengeController.instance:getRandomBuff(self._onStartBuff, self)

		return
	end

	local cur, fisrt = PetverifyController.instance:getCurrPlanBuff(planId)
	local monsterCfg = TimeLimitedConfig.instance:getAccumulateMonsterCfg(self._challengeId)
	local creepCfg = TimeLimitedConfig.instance:getAccumulateCreeps(monsterCfg.creepsMasterId)

	TLChallengeController.instance:openMissionView(self._challengeId, monsterCfg, creepCfg, false, true)
end

function PanduolamainView:_onClickRank()
	UIStateManager.instance:push(ViewName.TLChallengerankView, GameEnum.RankType.PANDUOLA_RANK)
end

return PanduolamainView
