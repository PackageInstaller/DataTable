-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingmengmeng/view/KingmmLevelView.lua

module("logic.extensions.kingmengmeng.view.KingmmLevelView", package.seeall)

local KingmmLevelView = class("KingmmLevelView", ViewComponent)

function KingmmLevelView:ctor()
	KingmmLevelView.super.ctor(self)
end

function KingmmLevelView:buildUI()
	KingmmLevelView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnReset = self:getBtn("btnReset")
	self._txtTitle = self:getTxt("leftTop/txtTitle")
	self._txtNum = self:getTxt("img/txtNum")
	self._txtDesc = self:getTxt("txtDesc")
	self._cellGo = self:getGo("cell")
	self.scrollerGo = self:getGo("tableview")
	self.scrollList = ScrollerList.create(self.scrollerGo, self._cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function KingmmLevelView:bindEvents()
	KingmmLevelView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnReset:AddClickListener(self._onClickReset, self)
end

function KingmmLevelView:unbindEvents()
	KingmmLevelView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnReset:RemoveClickListener()
end

function KingmmLevelView:onEnter()
	KingmmLevelView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.KMMChallengeResetGuardStageRes, self._onResetGuardStageRes, self)

	local param = self:getOpenParam()

	self._activityId = param[1]
	self._challengeType = param[2]
	self._stageId = param[3]
	self._activityType = KingmmController.instance:getActivityType()

	local isInTime = KingmmController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	self:_initTitle()
	self:_updateTxtNum()
	self:_initTableview()
	goutil.setActive(self._btnReset.gameObject, self._challengeType == KingmmModel.GuardChallenge)
end

function KingmmLevelView:onExit()
	KingmmLevelView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.KMMChallengeResetGuardStageRes, self._onResetGuardStageRes, self)
end

function KingmmLevelView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, self._viewPresentor.viewName .. "_rule")
end

function KingmmLevelView:_onClickReset()
	if not self:_checkPassAoqiGodProcessResult() then
		return
	end

	if self._challengeType == KingmmModel.GuardChallenge then
		local text = "是否将所有关卡重置为未挑战状态，解锁被锁定的精灵？"

		local function okFunc()
			KingmmAgent.instance:sendPM_KMMChallengeResetGuardStageReq(self._activityId)
		end

		TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc)
	end
end

function KingmmLevelView:_onResetGuardStageRes()
	self:_updateTxtNum()
	self:_initTableview()
end

function KingmmLevelView:_initTitle()
	self._txtTitle.text = KingmmController.instance:getLevelTitle(self._challengeType)
	self._txtDesc.text = KingmmController.instance:getChallengeBuffDesc(self._challengeType)
end

function KingmmLevelView:_updateTxtNum()
	if self._challengeType == KingmmModel.ElementChallenge then
		local maxElementCount = #KingmmConfig.instance:getElementCfgList(self._activityId)
		local curElementPassNum = KingmmModel.instance:getPassElementNum()

		self._txtNum.text = string.format("已通关：%d/%d", curElementPassNum, maxElementCount)
	else
		local maxGuardCount = #KingmmConfig.instance:getGuardCfgList(self._activityId)
		local curGuardPassNum = KingmmModel.instance:getPassGuardNum()

		self._txtNum.text = string.format("已通关：%d/%d", curGuardPassNum, maxGuardCount)
	end
end

function KingmmLevelView:_updateCell(view, cell, data, tag)
	local icon = goutil.findChild(cell, "icon")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local passGo = goutil.findChild(cell, "pass")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local btnPass = Framework.ButtonAdapter.GetFrom(cell.gameObject, "pass")

	txtName.text = data.buffName
	txtDesc.text = data.buffDesc

	local isPass = false

	isPass = self._challengeType == KingmmModel.ElementChallenge and KingmmModel.instance:isPassElementStage(data.stageId) or KingmmModel.instance:isPassGuardStage(data.stageId)

	goutil.setActive(passGo, isPass)
	goutil.setActive(btn.gameObject, not isPass)

	local modelCo = CharacterConfig.instance:getModelCo(data.raceId)

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	btn:AddClickListener(function()
		if not self:_checkPassAoqiGodProcessResult() then
			return
		end

		KingmmController.instance:openExtremeMissionView(self._activityId, self._challengeType, data.stageId, data.creepsMasterId)
	end)
	btnPass:AddClickListener(function()
		FloatWordMgr.instance:show("已通关")
	end)
end

function KingmmLevelView:clearCell(cell)
	local icon = goutil.findChild(cell, "icon")

	uGuiUtil.clearImage(icon)
end

function KingmmLevelView:_initTableview()
	if self._challengeType == KingmmModel.ElementChallenge then
		local var_17_0 = KingmmConfig.instance:getElementCfgList(self._activityId)

		if not var_17_0 then
			var_17_0 = KingmmConfig.instance:getGuardCfgList(self._activityId)

			local list = var_17_0

			self.scrollList:reloadData(list)
		end
	end
end

function KingmmLevelView:_checkPassAoqiGodProcessResult()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return false
		end
	end

	return true
end

return KingmmLevelView
