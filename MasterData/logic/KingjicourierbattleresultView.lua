-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingjichallenge/view/KingjicourierbattleresultView.lua

module("logic.extensions.kingjichallenge.view.KingjicourierbattleresultView", package.seeall)

local KingjicourierbattleresultView = class("KingjicourierbattleresultView", ViewComponent)

function KingjicourierbattleresultView:ctor()
	KingjicourierbattleresultView.super.ctor(self)
end

function KingjicourierbattleresultView:buildUI()
	KingjicourierbattleresultView.super.buildUI(self)

	self._txtTotalDamage = goutil.findChildTextComponent(self.mainGO, "totalDamage/Text")
	self._txtCurDamage = goutil.findChildTextComponent(self.mainGO, "curDamage/Text")
	self._btnOk = self:getBtn("btnOk")
	self._txtTitlecurDamage = self:getTxt("curDamage/txtTitle")
	self._txtTitletotalDamage = self:getTxt("totalDamage/txtTitle")
end

function KingjicourierbattleresultView:bindEvents()
	KingjicourierbattleresultView.super.bindEvents(self)
	self._btnOk:AddClickListener(self._onClickbtnOk, self)
end

function KingjicourierbattleresultView:unbindEvents()
	KingjicourierbattleresultView.super.unbindEvents(self)
	self._btnOk:RemoveClickListener()
end

function KingjicourierbattleresultView:onExit()
	KingjichallengeController.instance:setCurrChallengeCourierStageId(nil)
end

function KingjicourierbattleresultView:onEnter()
	KingjicourierbattleresultView.super.onEnter(self)

	self._lastDamageInfo = KingjichallengeController.instance:getCourierLastDamageInfo()
	self._currDamageInfo = KingjichallengeController.instance:getCourierCurrDamageInfo() or self._lastDamageInfo

	self:_updateView()
end

function KingjicourierbattleresultView:_onClickbtnOk()
	self:close()
end

function KingjicourierbattleresultView:_updateView()
	self._txtCurDamage.text = self._currDamageInfo.damage - self._lastDamageInfo.damage
	self._txtTotalDamage.text = self._currDamageInfo.bossCurHp

	self:_setDesc()
end

function KingjicourierbattleresultView:_setDesc()
	local activityId = KingjichallengeModel.instance:getActivityId()
	local cfg = KingjichallengeConfig.instance:getCourierStageCfg(activityId, self._lastDamageInfo.stageId)

	if cfg then
		self._txtTitlecurDamage.text = string.format("本次对%s造成的伤害", cfg.stageName)
		self._txtTitletotalDamage.text = string.format("%s剩余血量", cfg.stageName)
	end
end

return KingjicourierbattleresultView
