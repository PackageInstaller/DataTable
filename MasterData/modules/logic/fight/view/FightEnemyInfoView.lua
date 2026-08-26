-- chunkname: @modules/logic/fight/view/FightEnemyInfoView.lua

module("modules.logic.fight.view.FightEnemyInfoView", package.seeall)

local FightEnemyInfoView = class("FightEnemyInfoView", BaseView)

function FightEnemyInfoView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightEnemyInfoView:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.GMHideFightView, self._checkHideUI, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnCameraFocusChanged, self._onCameraFocusChanged, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyBattleOpenEnemyInfo, self.OnOpenEnemyInfo, self)
end

function FightEnemyInfoView:removeEvents()
	self.removeEventCb(self, FightController.instance, FightEvent.GMHideFightView, self._checkHideUI, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnCameraFocusChanged, self._onCameraFocusChanged, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyBattleOpenEnemyInfo, self.OnOpenEnemyInfo, self)
end

function FightEnemyInfoView:_editableInitView()
	self.enemyInfoBtn = gohelper.findChildButton(self.viewGO, "root/topLeftContent/enemyinfo/#btn_enemyinfo")
	self.enemyInfoGo = gohelper.findChild(self.viewGO, "root/topLeftContent/enemyinfo/")

	local unLock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightBack)
	local isReplay = FightDataHelper.stateMgr.isReplay

	gohelper.setActive(self.enemyInfoGo, unLock and not isReplay and GMFightShowState.leftMonster)

	if unLock then
		self.enemyInfoBtn:AddClickListener(self.enemyInfoBtnOnClick, self)
	end
end

function FightEnemyInfoView:OnOpenEnemyInfo()
	local unLock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightBack)

	if unLock then
		self:enemyInfoBtnOnClick()
	end
end

function FightEnemyInfoView:_onCameraFocusChanged(isFocus)
	self._isFocus = isFocus
end

function FightEnemyInfoView:_checkHideUI()
	local unLock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightBack)
	local isReplay = FightDataHelper.stateMgr.isReplay

	gohelper.setActive(self.enemyInfoGo, unLock and not isReplay and GMFightShowState.leftMonster)
end

function FightEnemyInfoView:enemyInfoBtnOnClick()
	if FightDataHelper.lockOperateMgr:isLock() then
		return
	end

	if FightDataHelper.stateMgr.isReplay then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidLongPressCard) then
		return
	end

	if FightViewHandCard.blockOperate then
		return
	end

	if GuideModel.instance:isDoingFirstGuide() then
		logNormal("新手第一个指引不能长按查看详情")

		return
	end

	if FightDataHelper.stateMgr:getIsAuto() then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		logNormal("出完牌了不能长按查看详情")

		return
	end

	if self._isFocus then
		logNormal("正在查看怪物详情，不给点")

		return
	end

	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	self.viewContainer:openFightFocusView()
end

function FightEnemyInfoView:onClose()
	self.enemyInfoBtn:RemoveClickListener()
end

return FightEnemyInfoView
