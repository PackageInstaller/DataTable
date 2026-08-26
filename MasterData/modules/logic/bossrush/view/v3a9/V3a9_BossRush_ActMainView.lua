-- chunkname: @modules/logic/bossrush/view/v3a9/V3a9_BossRush_ActMainView.lua

module("modules.logic.bossrush.view.v3a9.V3a9_BossRush_ActMainView", package.seeall)

local V3a9_BossRush_ActMainView = class("V3a9_BossRush_ActMainView", V3a9_BossRush_MainBaseView)

function V3a9_BossRush_ActMainView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "LimitTime/#txt_LimitTime")
	self._txtTotalScoreNum = gohelper.findChildText(self.viewGO, "Score/TotalScore/#txt_TotalScoreNum")
	self._imagePastbg = gohelper.findChildImage(self.viewGO, "Score/PastScore/#go_Pastbg")
	self._txtPastScore = gohelper.findChildText(self.viewGO, "Score/PastScore/txt_PastScore")
	self._txtPastScoreNum = gohelper.findChildText(self.viewGO, "Score/PastScore/#txt_PastScoreNum")
	self._btnReward = gohelper.findChildButtonWithAudio(self.viewGO, "Score/#btn_Reward")
	self._gohandbook = gohelper.findChild(self.viewGO, "#go_handbook")
	self._btnhandbook = gohelper.findChildButtonWithAudio(self.viewGO, "#go_handbook/#btn_handbook")
	self._goreddot = gohelper.findChild(self.viewGO, "#go_handbook/#go_reddot")
	self._gorankbtn = gohelper.findChild(self.viewGO, "#go_rankbtn")
	self._btnStore = gohelper.findChildButtonWithAudio(self.viewGO, "Store/#btn_Store")
	self._txtStore = gohelper.findChildText(self.viewGO, "Store/#btn_Store/txt_Store")
	self._simageProp = gohelper.findChildSingleImage(self.viewGO, "Store/#btn_Store/#simage_Prop")
	self._txtNum = gohelper.findChildText(self.viewGO, "Store/#btn_Store/#txt_Num")
	self._gohandbookreddot = gohelper.findChild(self.viewGO, "#go_handbook/#go_reddot")
	self._gorewardreddot = gohelper.findChild(self.viewGO, "Score/#btn_Reward/reddot")
	self._animreward = gohelper.findChildComponent(self.viewGO, "Score/#btn_Reward/ani", typeof(UnityEngine.Animator))
	self._btnAchievement = gohelper.findChildButtonWithAudio(self.viewGO, "TopRight/#btn_Achievement")
	self._txtAchievement = gohelper.findChildText(self.viewGO, "TopRight/#txt_Achievement")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9_BossRush_ActMainView:addEvents()
	self._btnReward:AddClickListener(self._btnRewardOnClick, self)
	self.addEventCb(self, V3a9_BossRushController.instance, V3a9_BossRushEvent.OnResetStage, self._onResetStage, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self._refreshRewardReddot, self)
	V3a9_BossRush_ActMainView.super.addEvents(self)
end

function V3a9_BossRush_ActMainView:removeEvents()
	self._btnReward:RemoveClickListener()
	self.removeEventCb(self, V3a9_BossRushController.instance, V3a9_BossRushEvent.OnResetStage, self._onResetStage, self)
	self.removeEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self._refreshRewardReddot, self)
	V3a9_BossRush_ActMainView.super.removeEvents(self)
end

function V3a9_BossRush_ActMainView:_editableInitView()
	V3a9_BossRush_ActMainView.super._editableInitView(self)
	RedDotController.instance:addRedDot(self._gorewardreddot, RedDotEnum.DotNode.V3a9BossRushAct)
	self:_refreshRewardReddot()
end

function V3a9_BossRush_ActMainView:_refreshRewardReddot()
	local animName = "idle"

	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V3a9BossRushAct, 0) then
		animName = "loop"
	end

	if self._animName == animName then
		return
	end

	self._animreward:Play(animName, 0, 0)

	self._animName = animName
end

function V3a9_BossRush_ActMainView:_btnRewardOnClick()
	V3a9_BossRushController.instance:openV3a9BonusView(self:_getActivityId())
end

function V3a9_BossRush_ActMainView:_getActivityId()
	return V3a9_BossRushModel.instance:getActModeActId()
end

function V3a9_BossRush_ActMainView:_refreshLeft()
	local totalScore = V3a9_BossRushModel.instance:getTotalScore(self.actId) or 0
	local heightScore = V3a9_BossRushModel.instance:getHeightScore(self.actId) or 0

	self._txtTotalScoreNum.text = BossRushConfig.instance:getScoreStr(totalScore)
	self._txtPastScoreNum.text = BossRushConfig.instance:getScoreStr(heightScore)

	local effect = V3a9_BossRushModel.instance:getHeightScoreEffect(heightScore)

	if not V3a9BossRushEnum.HeightScoreEffect[effect] then
		local effectParam = V3a9BossRushEnum.HeightScoreEffect[0]
		local isShowEffectBg = not string.nilorempty(effectParam.bg)

		if isShowEffectBg then
			UISpriteSetMgr.instance:setV1a4BossRushSprite(self._imagePastbg, effectParam.bg)
		end

		self._txtPastScoreNum.color = GameUtil.parseColor(effectParam.txtColor)
		self._txtPastScore.color = isShowEffectBg and GameUtil.parseColor("#130D0E") or GameUtil.parseColor("#CDC1BC")

		gohelper.setActive(self._imagePastbg.gameObject, isShowEffectBg)
	end
end

function V3a9_BossRush_ActMainView:_refreshRight()
	local dataList = V3a9_BossRushModel.instance:getStageMos(self.actId)

	self:_initItemList(dataList)
end

function V3a9_BossRush_ActMainView:_onResetStage()
	self:_refreshItems()
	self:_refreshLeft()
end

function V3a9_BossRush_ActMainView:_refreshItems()
	for i, item in ipairs(self._itemList) do
		item:refreshScore()
		item:refreshHero()
	end
end

function V3a9_BossRush_ActMainView:_getItem(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, V3a9_BossRush_ActMainItem, self.viewContainer)
end

return V3a9_BossRush_ActMainView
