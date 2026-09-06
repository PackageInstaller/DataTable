-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/timedpointracemode/TimedPointRaceModeSettlementView.lua

module("logic.extensions.timelimitedchallenge.view.timedpointracemode.TimedPointRaceModeSettlementView", package.seeall)

local TimedPointRaceModeSettlementView = class("TimedPointRaceModeSettlementView", ViewComponent)

function TimedPointRaceModeSettlementView:bindEvents()
	TimedPointRaceModeSettlementView.super.bindEvents(self)
	self.btnOK:AddClickListener(self.close, self)
end

function TimedPointRaceModeSettlementView:unbindEvents()
	TimedPointRaceModeSettlementView.super.unbindEvents(self)
	self.btnOK:RemoveClickListener()
end

function TimedPointRaceModeSettlementView:buildUI()
	TimedPointRaceModeSettlementView.super.buildUI(self)

	self.btnOK = self:getBtn("bg/bg_3/btnOk")
	self.txtTitle = self:getTxt("bg/bg_3/txtTitle")
	self.curDamage = self:getGo("bg/curDamage")
	self.txtCurDamage = goutil.findChildTextComponent(self.curDamage, "Text")
	self.totalScore = self:getGo("bg/totalScore")
	self.txtTotalScore = goutil.findChildTextComponent(self.totalScore, "Text")
	self.txtTipContentFail = self:getTxt("bg/tipContentFail")
	self.txtTipContent = self:getTxt("bg/tipContent")
	self.txtTip = self:getTxt("bg/tipContent/tip")
	self._showTips = {
		lang("")
	}
end

function TimedPointRaceModeSettlementView:onEnter()
	TimedPointRaceModeSettlementView.super.onEnter(self)
	goutil.setActive(self.curDamage, false)
	goutil.setActive(self.totalScore, false)
	goutil.setActive(self.txtTipContentFail.gameObject, false)
	goutil.setActive(self.txtTipContent.gameObject, false)

	local params = self:getOpenParam()

	self._challengeId = params[1]
	self._buffChallengeCfg = params[2]
	self._commonCfg = TimedPointRaceModeConfig.instance:getCommonCfg(self._challengeId)
	self._curChallengeCfg = TimeLimitedConfig.instance:getCfgById(self._challengeId)
	self._curInfo = TimedPointRaceModeModel.instance:getInfo(self._challengeId)

	if self._curInfo then
		if self._buffChallengeCfg then
			if BattleModel.instance.battleResult == GameEnum.BattleResult.Failed then
				self.txtTitle.text = langPara("战斗失败")

				goutil.setActive(self.txtTipContentFail.gameObject, true)
			else
				self.txtTitle.text = langPara("战斗胜利")
				self.txtTipContent.text = self._showTips[self._buffChallengeCfg.enterViewType] or ""

				local showTip = langPara("获得积分减少<color=#eb4642>%s%%</color>", math.abs(self._buffChallengeCfg.scoreEffect / 100))
				local buffId = self._buffChallengeCfg.buffId
				local buffCfg = TimedPointRaceModeConfig.instance:getBuffCfgs(buffId)

				if buffCfg then
					if not buffCfg.buffDes then
						local showDesc = ""

						self.txtTip.text = langPara("%s\n%s", showDesc, showTip)

						goutil.setActive(self.txtTipContent.gameObject, true)
					end
				end
			end
		else
			self.txtTitle.text = langPara("战斗结束")

			goutil.setActive(self.curDamage, true)

			self.txtCurDamage.text = self._curInfo.lastDamage

			goutil.setActive(self.totalScore, true)

			self.txtTotalScore.text = self._curInfo.lastScore
		end
	else
		self:close()
	end
end

function TimedPointRaceModeSettlementView:onExit()
	TimedPointRaceModeSettlementView.super.onExit(self)

	if self._curChallengeCfg then
		UIJumper.instance:pushOneStack(self._curChallengeCfg.viewName, true)
	end

	BattleController.instance:endBattle()
end

return TimedPointRaceModeSettlementView
