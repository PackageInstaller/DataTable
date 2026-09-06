-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownFormationExView.lua

module("logic.extensions.showdown.view.dream.ShowDownFormationExView", package.seeall)

local ShowDownFormationExView = class("ShowDownFormationExView", ViewComponent)

function ShowDownFormationExView:ctor()
	ShowDownFormationExView.super.ctor(self)
end

function ShowDownFormationExView:buildUI()
	ShowDownFormationExView.super.buildUI(self)

	self._btnShop = goutil.findChild(self.mainGO, "btnShop")
	self._btnResetShop = goutil.findChild(self.mainGO, "btnResetShop")
	self._count = goutil.findChild(self.mainGO, "count")
	self._txtCount = goutil.findChildTextComponent(self.mainGO, "count/txt")
	self._buffCell = goutil.findChild(self.mainGO, "buffCell")
	self._buffIcon = goutil.findChild(self.mainGO, "buffCell/icon")
	self._buffName = goutil.findChild(self.mainGO, "buffCell/name")
	self._txtBuffName = goutil.findChildTextComponent(self.mainGO, "buffCell/name/txt")
	self._bubble = goutil.findChild(self.mainGO, "bubble")
	self._txtBubble = goutil.findChildTextComponent(self.mainGO, "bubble/txt")
	self._emptyTips = goutil.findChild(self.mainGO, "emptyTips")

	GameUtil.SetActive(self._emptyTips, false)
end

function ShowDownFormationExView:bindEvents()
	ShowDownFormationExView.super.bindEvents(self)
	GameUtil.addClickHandler(self._buffCell, self._onClickBuffCell, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
	GameUtil.addClickHandler(self._btnResetShop, self._onClickBtnResetShop, self)
end

function ShowDownFormationExView:unbindEvents()
	ShowDownFormationExView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnResetShop)
end

function ShowDownFormationExView:destroyUI()
	ShowDownFormationExView.super.destroyUI(self)
end

function ShowDownFormationExView:onEnter()
	ShowDownFormationExView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._customFmtMo = params[1]
	self._activityId = self._customFmtMo:getActivityId()
	self._roundId = self._customFmtMo:getRoundId()
	self._activityType = ShowDownController.instance:getActivityType()

	ShowDownController.instance:enterInStepMgr(self._activityId)

	self._actData = ShowDownConfig.instance:getActData(self._activityId)
	self._isCanSelectBuff = ShowDownController.instance:isCanSelectBuffInRound(self._activityId, self._roundId)

	self.addGEvent(self, GlobalNotify.ShowDownStepChange, self._handleShowDownStepChange, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_ResetPetsAndFormRes, self._handlePM_ShowDown_ResetPetsAndFormRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetQualifyMainInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.ShowDownFormationBuffUpdate, self._onUpdateBuffColUI, self)
	self:_onUpdate()
end

function ShowDownFormationExView:onExit()
	ShowDownFormationExView.super.onExit(self)
	ShowDownController.instance:exitInStepMgr(self._activityId)
	self:_onClearBuffColUI()
end

function ShowDownFormationExView:_handleShowDownStepChange()
	local curStepId = ShowDownController.instance:getCurStepId(self._activityId)
	local curRoundId = ShowDownController.instance:getRoundIdByStep(self._activityId, curStepId)

	if curRoundId == self._roundId then
		self:_onUpdate()
	else
		local text = "比赛阶段已发生变化"

		local function func()
			self:_onUpdate()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)
	end
end

function ShowDownFormationExView:_handlePM_ShowDown_ResetPetsAndFormRes()
	self._customFmtMo:_updateFmt()
	self:_onUpdate()
	FloatWordMgr.instance:show("重设成功")
end

function ShowDownFormationExView:_onUpdate()
	local leftReset = ShowDownController.instance:getLeftResetTimesInPetShop(self._activityId, self._roundId)
	local maxReset = ShowDownController.instance:getMaxResetTimesInPetShop(self._activityId, self._roundId)
	local leftRefresh = ShowDownController.instance:getLeftRefreshTimesInPetShop(self._activityId, self._roundId)
	local isHasConfirm = ShowDownController.instance:isHasConfirmInPetShop(self._activityId, self._roundId)
	local petList = ShowDownController.instance:getBagPetListInPetShop(self._activityId, self._roundId)

	self._isFirstDraw = #petList <= 0
	self._txtCount.text = leftReset > 0 and string.format("%s/%s", leftReset, maxReset) or string.format("<color=#eb4624>%s</color>/%s", leftReset, maxReset)

	GameUtil.SetActive(self._btnShop, self._isFirstDraw or leftRefresh > 0 and not isHasConfirm)
	GameUtil.SetActive(self._btnResetShop, not GameUtil.GetActive(self._btnShop))
	GameUtil.SetActive(self._count, GameUtil.GetActive(self._btnResetShop))

	if self._isFirstDraw or not isHasConfirm then
		ShowDownController.instance:enterShowDownPetShop(self._activityId, self._roundId)
	end

	if self._isCanSelectBuff then
		GameUtil.SetActive(self._buffCell, true)
		GameUtil.SetActive(self._bubble, true)
		self:_onUpdateBuffColUI()
	else
		GameUtil.SetActive(self._buffCell, false)
		GameUtil.SetActive(self._bubble, false)
		self:_onClearBuffColUI()
	end
end

function ShowDownFormationExView:_getCurBuffId()
	return self._customFmtMo:getCurBuffId()
end

function ShowDownFormationExView:_setCurBuffId(value)
	self._customFmtMo:setCurBuffId(value)
end

function ShowDownFormationExView:_onUpdateBuffColUI()
	local cfg = ShowDownConfig.instance:getBuffCfg(self._activityId, self._roundId)
	local buffId = self:_getCurBuffId()
	local buffData = ShowDownConfig.instance:getBuffData(self._activityId, self._roundId, buffId)
	local path = ShowDownController.instance:getBuffIconPath(self._activityId, self._roundId, buffId)
	local bgGo = self._buffIcon

	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg

		local function func()
			return
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, path, func)
	else
		uGuiUtil.clearImage(bgGo)
	end

	if buffData then
		self._txtBuffName.text = buffData.name
		self._txtBubble.text = buffData.desc

		GameUtil.SetActive(self._buffName, true)
		GameUtil.SetActive(self._bubble, true)
		GameUtil.SetActive(self._emptyTips, false)
	else
		GameUtil.SetActive(self._buffName, false)
		GameUtil.SetActive(self._bubble, false)
		GameUtil.SetActive(self._emptyTips, true)
	end
end

function ShowDownFormationExView:_onClearBuffColUI()
	uGuiUtil.clearImage(self._buffIcon)
end

function ShowDownFormationExView:_onClickBuffCell()
	UIStateManager.instance:push(ViewName.ShowDownBuffSelectView, self._customFmtMo)
end

function ShowDownFormationExView:_onClickBtnShop()
	local isHasConfirm = ShowDownController.instance:isHasConfirmInPetShop(self._activityId, self._roundId)

	if self._isFirstDraw or not isHasConfirm then
		ShowDownController.instance:enterShowDownPetShop(self._activityId, self._roundId)
	end
end

function ShowDownFormationExView:_onClickBtnResetShop()
	local cur = ShowDownController.instance:getCurResetTimesInPetShop(self._activityId, self._roundId)
	local max = ShowDownController.instance:getMaxResetTimesInPetShop(self._activityId, self._roundId)
	local left = ShowDownController.instance:getLeftResetTimesInPetShop(self._activityId, self._roundId)

	if left <= 0 then
		FloatWordMgr.instance:show("已达到重新配置阵容上限")
	else
		local next = cur + 1
		local matStr = ShowDownController.instance:getCostInRefreshTimesInPetShop(self._activityId, self._roundId, next)

		if not string.nilorempty(matStr) then
			local matType, matId, matNum = MaterialMgr.getMatParams(matStr)
			local matName = MaterialMgr.getMaterialsName(matType, matId)
			local tipsContent = string.format("本次重设需要消耗[<color=#20b376>%s</color>]x%s，是否继续？", matName, matNum)

			local function okFunc()
				ShowDownController.instance:sendPM_ShowDown_ResetPetsAndFormReq(self._activityId, self._roundId, matStr)
			end

			TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
		else
			printError(string.format("缺失消耗道具配置( l擂台赛.xlsx | export_购买重选次数方案| activityId = %s | roundId = %s | next = %s )", self._activityId, self._roundId, next))
		end
	end
end

return ShowDownFormationExView
