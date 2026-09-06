-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraidersceneView.lua

module("logic.extensions.treasureraider.view.TreasureraidersceneView", package.seeall)

local TreasureraidersceneView = class("TreasureraidersceneView", ViewComponent)

function TreasureraidersceneView:ctor()
	TreasureraidersceneView.super.ctor(self)
end

function TreasureraidersceneView:unbindEvents()
	TreasureraidersceneView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnEdit)
	GameUtil.rmClickHandler(self._btnRandomDice)
	GameUtil.rmClickHandler(self._btnFixDice)
	GameUtil.rmClickHandler(self._btnAttack)
	GameUtil.rmClickHandler(self._blockGo)
	GameUtil.rmClickHandler(self._btnExchange)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnSetOffendFormation)
	GameUtil.rmClickHandler(self._btnAbandon)
	GameUtil.rmClickHandler(self._btnAttackRecord)
	GameUtil.rmClickHandler(self._btnProduceRecord)
	GameUtil.rmClickHandler(self._btnSwitchAngle)
	GameUtil.rmClickHandler(self._btnFixDiceTip)
	GameUtil.rmClickHandler(self._btnRandomDiceTip)
	GameUtil.rmClickHandler(self._revengeGo)
	self._btnRandomDiceTipCustomInput:RemoveListener()
	self._btnFixDiceTipCustomInput:RemoveListener()
	self._btnRevengeCustomInput:RemoveListener()
	self._btnPassPort:RemoveClickListener()
end

function TreasureraidersceneView:bindEvents()
	TreasureraidersceneView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnEdit, self._onClickEdit, self)
	GameUtil.addClickHandler(self._btnRandomDice, self._onClickRandomDice, self)
	GameUtil.addClickHandler(self._btnFixDice, self._onClickFixDice, self)
	GameUtil.addClickHandler(self._btnAttack, self._onClickAttack, self)
	GameUtil.addClickHandler(self._blockGo, self._onClickBlock, self)
	GameUtil.addClickHandler(self._btnExchange, self._onClickExchange, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickIntroduce, self)
	GameUtil.addClickHandler(self._btnSetOffendFormation, self._onClickSetOffendFormation, self)
	GameUtil.addClickHandler(self._btnAbandon, self._onClickAbandon, self)
	GameUtil.addClickHandler(self._btnAttackRecord, self._onClickAttackRecord, self)
	GameUtil.addClickHandler(self._btnProduceRecord, self._onClickProduceRecord, self)
	GameUtil.addClickHandler(self._btnSwitchAngle, self._onClickSwitchAngle, self)
	GameUtil.addClickHandler(self._btnFixDiceTip, self._onClickFixDiceTip, self)
	GameUtil.addClickHandler(self._btnRandomDiceTip, self._onClickRandomDiceTip, self)
	GameUtil.addClickHandler(self._revengeGo, self._onClickRevenge, self)
	self._btnRandomDiceTipCustomInput:AddListener(self._onRandomDiceTipInputChanged, self)
	self._btnFixDiceTipCustomInput:AddListener(self._onFixDiceTipInputChanged, self)
	self._btnRevengeCustomInput:AddListener(self._onRevengeTipInputChanged, self)
	self._btnPassPort:AddClickListener(self._onClickbtnPassPort, self)
end

function TreasureraidersceneView:buildUI()
	TreasureraidersceneView.super.buildUI(self)

	self._btnClose = self:getGo("lefttop/btn_back")
	self._btnTip = self:getGo("lefttop/btn_tip")
	self._opInfo = self:getGo("lefttop/opInfo")
	self._opHead = self:getGo("lefttop/opInfo/Head")
	self._txtOpPower = self:getTxt("lefttop/opInfo/Power/txtPower")
	self._txtOpName = self:getTxt("lefttop/opInfo/txtName")
	self._txtOpLevel = self:getTxt("lefttop/opInfo/txtLevel")
	self._gridOpContainer = self:getGo("gridOpContainer")
	self._blockGo = self:getGo("block")
	self._diceHandler = TRDiceHandler.New()

	self._diceHandler:initFromGo(self:getGo("partSaiZi"), 2)

	self._mainEffectGo = self:getGo("effect")
	self._btnExchange = self:getGo("leftbottom/btnExchange")
	self._btnRank = self:getGo("leftbottom/btnRank")
	self._btnIntroduce = self:getGo("leftbottom/btnIntroduce")
	self._btnEdit = self:getGo("rightbottom/btnEdit")
	self._btnRandomDice = self:getGo("rightbottom/btnRandomDice")
	self._btnFixDice = self:getGo("rightbottom/btnFixDice")
	self._btnAttack = self:getGo("rightbottom/btnAttack")
	self._btnSetOffendFormation = self:getGo("rightbottom/btnSetOffendFormation")
	self._btnAbandon = self:getGo("rightbottom/btnAbandon")
	self._btnRandomDiceRed = self:getGo("rightbottom/btnRandomDice/imgRed")
	self._btnFixDiceRed = self:getGo("rightbottom/btnFixDice/imgRed")
	self._btnAttackRed = self:getGo("rightbottom/btnAttack/redpoint")
	self._btnEditRed = self:getGo("rightbottom/btnEdit/redpoint")
	self._txtRemainEditTime = self:getTxt("rightbottom/btnEdit/txtRemainEditTime")
	self._txtRemainAttackTime = self:getTxt("rightbottom/btnAttack/txtRemainAttackTime")
	self._txtRandomDiceHave = self:getTxt("rightbottom/btnRandomDice/txtDiceHave")
	self._txtFixDiceHave = self:getTxt("rightbottom/btnFixDice/txtDiceHave")
	self._btnRandomDiceTip = self:getGo("rightbottom/btnRandomDiceTip")
	self._tipRandomDice = self:getGo("rightbottom/tipRandomDice")
	self._txtRandomDiceLimit = self:getTxt("rightbottom/tipRandomDice/txtDiceLimit")
	self._btnRandomDiceTipCustomInput = UICustomInput.Get(self._btnRandomDiceTip.gameObject)
	self._btnFixDiceTip = self:getGo("rightbottom/btnFixDiceTip")
	self._tipFixDice = self:getGo("rightbottom/tipFixDice")
	self._txtFixDiceLimit = self:getTxt("rightbottom/tipFixDice/txtDiceLimit")
	self._btnFixDiceTipCustomInput = UICustomInput.Get(self._btnFixDiceTip.gameObject)
	self._btnAttackRecord = self:getGo("righttop/btnAttackRecord")
	self._btnProduceRecord = self:getGo("righttop/btnProduceRecord")
	self._btnSwitchAngle = self:getGo("righttop/btnSwitchAngle")
	self._revengeGo = self:getGo("righttop/revenge")
	self._rewardGo = self:getGo("righttop/reward")
	self._tipRevenge = self:getGo("righttop/tipRevenge")
	self._btnRevengeCustomInput = UICustomInput.Get(self._revengeGo.gameObject)
	self._txtTipRevenge = self:getTxt("righttop/tipRevenge/txt")
	self._btnAttackRecordRed = self:getGo("righttop/btnAttackRecord/redpoint")

	local rewardTableView = self:getGo("righttop/reward/tableview")
	local rewardCell = self:getGo("righttop/reward/item")

	self._rewardList = ScrollerList.create(rewardTableView, rewardCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._btnPassPort = self:getBtn("leftbottom/btnPassPort")
	self._goldConGo = self:getGo("goldCon")
	self._goldCellGo = self:getGo("goldCell")
	self._itemGroup = ItemGroup.New(self._goldConGo, self._goldCellGo, nil, nil, true, self._clearItem, self)
	self._layout = self._goldConGo:GetComponent(ComponentType.UILayoutSingleLine)
	self._redpointGo = self:getGo("leftbottom/btnPassPort/redpoint")
end

function TreasureraidersceneView:onExit()
	TreasureraidersceneView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.TreasureRaiderPlayDice, self._onPlayDice, self)
	GlobalDispatcher:removeListener(GlobalNotify.TreasureRaiderPlayerClientGridUpdated, self._onPlayerClientGridUpdated, self)
	GlobalDispatcher:removeListener(GlobalNotify.TreasureRaiderMyMapInfoUpdated, self._updateSceneOwner, self)
	GlobalDispatcher:removeListener(GlobalNotify.TreasureRaiderMyPlayerMoInfoUpdated, self._invalidateUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.TreasureRaiderReloadScene, self._updateSceneOwner, self)
	GlobalDispatcher:removeListener(GlobalNotify.TreasureRaiderEnterSceneDone, self._initBuildingResourceTimer, self)
	GlobalDispatcher:removeListener(GlobalNotify.TreasureRaiderServerActionDone, self._invalidateSwitchAngleBtn, self)
	TreasureRaiderModel.instance:removeProduceTimer()
	self._diceHandler:dispose()
	self._rewardList:dispose()
	self._itemGroup:dispose()
	removetimer(self._updateTimer, self)
	HeadItemController.instance:resetHeadCell(self._opHead)
	RedPointController.instance.unregRedPoint(self._btnAttackRecordRed)
	self:_removeMainEffect()
	RedPointController.instance:unregRedPoint(self._redpointGo)
end

function TreasureraidersceneView:onEnter()
	TreasureraidersceneView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderPlayDice, self._onPlayDice, self)
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderPlayerClientGridUpdated, self._onPlayerClientGridUpdated, self)
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderMyMapInfoUpdated, self._updateSceneOwner, self)
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderMyPlayerMoInfoUpdated, self._invalidateUI, self)
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderReloadScene, self._updateSceneOwner, self)
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderEnterSceneDone, self._initBuildingResourceTimer, self)
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderServerActionDone, self._invalidateSwitchAngleBtn, self)
	self.addGEvent(self, GlobalNotify.TreasureRaiderBuildingUpgrade, self._updateRates, self)
	self.addGEvent(self, GlobalNotify.TreasureRaiderSingleBuildingUpdated, self._updateRates, self)
	GameUtil.SetActive(self._tipRandomDice, false)
	GameUtil.SetActive(self._tipFixDice, false)
	GameUtil.SetActive(self._tipRevenge, false)
	self:_updateSceneOwner()
	settimer(0.3, self._updateTimer, self)

	self._newbeeViewValue = -1
	TreasureRaiderModel.instance.isMoving = false

	local activityConfig = TreasureRaiderConfig.instance:getActivityConfig()

	self:_updateRates()

	self._txtTipRevenge.text = langPara("本次掠夺资源，资源收益+%s%%", checknumber(activityConfig.revengeAddition) / 100)

	TreasureRaiderController.instance:startTickCheckRedDot()
	RedPointController.instance:regRedPoint(self._redpointGo, 573)
end

function TreasureraidersceneView:onEnterFinished()
	TreasureraidersceneView.super.onEnterFinished(self)
	self:_addMainEffect()
end

function TreasureraidersceneView:_removeMainEffect()
	if self._mainEffect then
		UIEffectManager.instance:stopEffect(self._mainEffect)

		self._mainEffect = nil
	end
end

function TreasureraidersceneView:_addMainEffect()
	self:_removeMainEffect()

	local effectPath = "20221223/duobaoqibing/fx_ui_duobaoqibing.prefab"
	local eff = UIEffectManager.instance:playEffect(self, effectPath, self._mainEffectGo.transform, 0, 0, true)

	eff:setParent(self._mainEffectGo.transform)
	eff:setScale(1)
	eff:setLocalPos(0, 0, 0)

	self._mainEffect = eff
end

function TreasureraidersceneView:_initBuildingResourceTimer()
	TreasureRaiderModel.instance:initCheckProduceTimer()
end

function TreasureraidersceneView:_onPlayerClientGridUpdated(userId)
	if userId == self._myPlayerMo.userId then
		self:_invalidateBlock()
		self:_checkNewbee()
		self:_checkShowFixBuildingDescView()
		self:_invalidateSwitchAngleBtn()
	end
end

function TreasureraidersceneView:_checkShowFixBuildingDescView()
	if self._isMyScene and TreasureRaiderModel.instance.isMoving and self._myPlayerMo:isClientServerSameGrid() then
		TreasureRaiderModel.instance.isMoving = false

		local array = TreasureRaiderSceneModel.instance:getCurGridNeighbourBuildingSlot(self._myPlayerMo.serverGridId, true)

		for i, v in ipairs(array) do
			local id = v[3]
			local isFixBuilding = TreasureRaiderConfig.instance:isGridDisableToEdit(id)

			if isFixBuilding then
				local gridX, gridY = TreasureRaiderSceneModel.instance:id2Grid(id)
				local posX, posY = TreasureRaiderSceneModel.instance:grid2Pos(gridX, gridY)

				TRPopMenuController.instance:handle(TRPopMenuController.Op_View, posX, posY, gridX, gridY, id)

				return
			end
		end
	end
end

function TreasureraidersceneView:_checkNewbee()
	if self._myPlayerMo:isClientServerSameGrid() and self._newbeeViewValue ~= 1 then
		self._newbeeViewValue = 1

		GuideController.instance:setViewVar("treasureraider_move_end", self._newbeeViewValue)
	end
end

function TreasureraidersceneView:_updateOpInfo()
	GameUtil.SetActive(self._opInfo, not self._isMyScene)

	if not self._isMyScene then
		local opPlayerMo = self._sceneMo.opPlayerMo

		self._opHead = self:getGo("lefttop/opInfo/Head")

		local proxy = HeadItemController.instance:setHeadCellByInfo(self._opHead, opPlayerMo.playerInfo)

		if proxy then
			local function func()
				RoleController.instance:openCardByUserId(opPlayerMo.userId)
			end

			proxy:setCallBack(func)
		end

		self._txtOpPower.text = tostring(opPlayerMo.zdl)
		self._txtOpName.text = opPlayerMo.userName
		self._txtOpLevel.text = langPara("大本营等级：%s", opPlayerMo.mainCampLevel)
	end
end

function TreasureraidersceneView:_updateSceneOwner()
	self._sceneMo = TreasureRaiderModel.instance:getCurSceneMo()
	self._isMyScene = self._sceneMo.ownerId == LoginModel.instance.userId
	self._myPlayerMo = self._sceneMo.myPlayerMo

	self._rewardList:reloadData({})
	self._rewardList:refresh()
	self:_invalidateUI()
	self:_invalidateBlock()
	TreasureRaiderController.instance:showAttackPrize()
end

function TreasureraidersceneView:_invalidateSwitchAngleBtn()
	GameUtil.SetActive(self._btnSwitchAngle, not self._sceneMo.actionDone and self._myPlayerMo.clientGridId == self._myPlayerMo.serverGridId)
end

function TreasureraidersceneView:_invalidateUI()
	GameUtil.SetActive(self._btnEdit, self._isMyScene)
	GameUtil.SetActive(self._btnAttack, self._isMyScene)
	GameUtil.SetActive(self._btnFixDiceTip, self._isMyScene)
	GameUtil.SetActive(self._btnRandomDiceTip, self._isMyScene)
	GameUtil.SetActive(self._btnSetOffendFormation, self._isMyScene)
	GameUtil.SetActive(self._btnAbandon, not self._isMyScene)
	GameUtil.SetActive(self._btnAttackRecord, self._isMyScene)
	GameUtil.SetActive(self._btnProduceRecord, self._isMyScene)
	GameUtil.SetActive(self._rewardGo, not self._isMyScene)

	local isRevenge = not self._isMyScene and self._myPlayerMo.isRevenge

	GameUtil.SetActive(self._revengeGo, isRevenge)

	if isRevenge then
		GameUtil.setLocalPos(self._btnSwitchAngle, -157, -335)
	else
		GameUtil.setLocalPos(self._btnSwitchAngle, -60, -319)
	end

	GameUtil.SetActive(self._btnRandomDiceRed, self._myPlayerMo:getRandomDiceCountRemain() > 0)
	GameUtil.SetActive(self._btnFixDiceRed, self._myPlayerMo:getFixDiceCountRemain() > 0)
	GameUtil.SetActive(self._btnAttackRed, self._myPlayerMo:getAttackCountRemain() > 0 and not self._myPlayerMo:isAttackCountReachMax() and self._myPlayerMo.mainCampLevel > 1)
	GameUtil.SetActive(self._btnEditRed, self._myPlayerMo:getEditCountRemain() > 0)
	GameUtil.SetActive(self._btnAttackRecordRed, false)

	if self._isMyScene then
		RedPointController.instance.unregRedPoint(self._btnAttackRecordRed)
		RedPointController.instance:regRedPoint(self._btnAttackRecordRed, RedPointModel.ID_TREASURE_DEFENDNEW)
	end

	self._txtRemainEditTime.text = langPara("每日次数：%d", self._myPlayerMo:getEditCountRemain())
	self._txtRemainAttackTime.text = langPara("发动入侵\n（次数：%d）", self._myPlayerMo:getAttackCountRemain())
	self._txtFixDiceHave.text = langPara("固定骰子\n（%d/%d）", self._myPlayerMo:getFixDiceCountRemain(), self._myPlayerMo:getFixDiceCountMax())
	self._txtRandomDiceHave.text = langPara("普通骰子\n（%d/%d）", self._myPlayerMo:getRandomDiceCountRemain(), self._myPlayerMo:getRandomDiceCountMax())

	self:_updateTimer()
	self:_updatePrize()
	self:_updateOpInfo()
	self:_invalidateSwitchAngleBtn()
end

function TreasureraidersceneView:_invalidateBlock()
	GameUtil.SetActive(self._blockGo, not self._myPlayerMo:isClientServerSameGrid())
end

function TreasureraidersceneView:_updateTimer()
	if self._myPlayerMo then
		if self._myPlayerMo:getRandomDiceCountRemain() >= self._myPlayerMo:getRandomDiceCountMax() then
			self._txtRandomDiceLimit.text = lang("已满")
		else
			local sec = self._myPlayerMo:getRandomDiceCd()
			local secStr = GameUtil.FormatTimeSymbol(sec, true)

			self._txtRandomDiceLimit.text = langPara("%s恢复一次", secStr)
		end
	else
		self._txtRandomDiceLimit.text = ""
	end

	self._txtRandomDiceHave.text = langPara("普通骰子\n（%d/%d）", self._myPlayerMo:getRandomDiceCountRemain(), self._myPlayerMo:getRandomDiceCountMax())
end

function TreasureraidersceneView:_updatePrize()
	self._rewardList:reloadData(self._myPlayerMo:getAttackPrize())
	self._rewardList:refresh()
end

function TreasureraidersceneView:_onPlayDice(value, isRandom)
	local type = isRandom and 1 or 2

	self._diceHandler:play({
		autoHideSelfSec = 1,
		value = value,
		useSaiZiId = type,
		doneCallback = function()
			if self._isMyScene then
				TreasureRaiderModel.instance.isMoving = true
			end

			GlobalDispatcher:dispatch(GlobalNotify.TreasureApplyMovePlayer)
		end,
		thisArg = self
	})
end

function TreasureraidersceneView:_updateRewardCell(view, goCell, data)
	MaterialMgr.resetAll(goCell.gameObject)

	local proxy = MaterialMgr.setCellByCfg(data, goCell.gameObject)

	if proxy then
		local _, _, num = MaterialMgr.getMatParams(data or "")

		proxy:setNumStr(StringUtil.numberToString(num or 0))
	end
end

function TreasureraidersceneView:_clearRewardCell(goCell)
	MaterialMgr.resetAll(goCell.gameObject)
end

function TreasureraidersceneView:_showResult()
	local prize = self._myPlayerMo:getAttackPrize()

	UIStateManager.instance:push(ViewName.TreasureraideattackresoultView, prize)
end

function TreasureraidersceneView:_onClickTip()
	TipsFacade.instance:openRulesView("treasureraidersceneview_rules")
end

function TreasureraidersceneView:_onClickClose()
	if self._isMyScene then
		TreasureRaiderController.instance:leaveScene()
	else
		self:_onClickAbandon()
	end
end

function TreasureraidersceneView:_onClickAbandon()
	TipsFacade.instance:openPopupWindow(lang("tip"), lang("是否离开领地，请把握好机会~\n（离开将扣除1次入侵次数）"), function()
		self:_showResult()
		TreasureRaiderModel.instance:clearCurSceneMo()
		TREnterSceneSequenceController.instance:onReset()
		TREnterSceneSequenceController.instance:enterScene()
	end, nil, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
end

function TreasureraidersceneView:_onClickEdit()
	if self._myPlayerMo:getEditCountRemain() <= 0 then
		FloatWordMgr.instance:show(lang("今日编辑次数已用完"))

		return
	end

	ViewMgr.instance:close(ViewName.TreasuresceneoperateView)
	UIStateManager.instance:push(ViewName.TreasureraidereditView)
end

function TreasureraidersceneView:_onClickRandomDice()
	if self._myPlayerMo:getRandomDiceCountRemain() <= 0 then
		FloatWordMgr.instance:show(lang("当前已无骰子数量"))

		return
	end

	if self._sceneMo:isCanDoActionIgnoreViewBuilding() then
		TipsFacade.instance:openPopupWindow(lang("tip"), lang("还有未操作的建筑，是否放弃操作并继续?"), function()
			TreasureRaiderController.instance:tryRandomMove()
		end)
	else
		TreasureRaiderController.instance:tryRandomMove()
	end
end

function TreasureraidersceneView:_onClickFixDice()
	if self._myPlayerMo:getFixDiceCountRemain() <= 0 then
		FloatWordMgr.instance:show(lang("当前已无骰子数量"))

		return
	end

	if self._sceneMo:isCanDoActionIgnoreViewBuilding() then
		TipsFacade.instance:openPopupWindow(lang("tip"), lang("还有未操作的建筑，是否放弃操作并继续?"), function()
			UIStateManager.instance:push(ViewName.TreasureraiderdiceView)
		end)
	else
		UIStateManager.instance:push(ViewName.TreasureraiderdiceView)
	end
end

function TreasureraidersceneView:_onClickAttack()
	if self._myPlayerMo:getAttackCountRemain() <= 0 then
		FloatWordMgr.instance:show(lang("暂无入侵次数"))

		return
	end

	if self._myPlayerMo:isAttackCountReachMax() then
		FloatWordMgr.instance:show(lang("已达到入侵次数上限"))

		return
	end

	if self._myPlayerMo.mainCampLevel <= 1 then
		FloatWordMgr.instance:show(lang("大本营等级到达2才能入侵"))

		return
	end

	local formationData = TreasureRaiderModel.instance.myPlayerMo:getAttackFormationData()
	local formationMo = FormationMO.New()

	formationMo:SetData(formationData)

	if formationMo:isEmpty() then
		FloatWordMgr.instance:show(lang("请先前往布置队伍"))
		self:_onClickSetOffendFormation()

		return
	end

	if self._sceneMo:isCanDoActionIgnoreViewBuilding() then
		TipsFacade.instance:openPopupWindow(lang("tip"), lang("还有未操作的建筑，是否放弃操作并继续?"), function()
			TreasureRaiderController.instance:reqAttackMatch()
		end)
	else
		TreasureRaiderController.instance:reqAttackMatch()
	end
end

function TreasureraidersceneView:_onClickBlock()
	if not self._myPlayerMo:isClientServerSameGrid() then
		FloatWordMgr.instance:show(lang("待动画播放完毕"))

		return
	end
end

function TreasureraidersceneView:_onClickIntroduce()
	UIStateManager.instance:push(ViewName.TreasureraiderintroduceView)
end

function TreasureraidersceneView:_onClickRank()
	local activityId = TreasureRaiderConfig.instance:getActivityId()

	UIStateManager.instance:push(ViewName.TreasureraiderrankView, activityId)
end

function TreasureraidersceneView:_onClickExchange()
	local activityType = TreasureRaiderConfig.instance:getCommonValue("ShopActivityType", true)
	local activityId = TreasureRaiderConfig.instance:getCommonValue("ShopActivityId", true)

	if activityType and activityId then
		GotoMgr.gotoByString(string.format("func#191#%s#%s", activityType, activityId))
	end
end

function TreasureraidersceneView:_onClickSetOffendFormation()
	local activityId = TreasureRaiderConfig.instance:getActivityId()
	local formationData = TreasureRaiderModel.instance.myPlayerMo:getAttackFormationData()
	local customFmtMo = TRAttackFmtMo.New()

	customFmtMo:initParams(activityId, formationData)
	CustomFmtController.instance:showMissionFormationView(customFmtMo)
end

function TreasureraidersceneView:_onClickAttackRecord()
	local activityId = TreasureRaiderConfig.instance:getActivityId()

	UIStateManager.instance:push(ViewName.TreasureraideattackrecordView, activityId)
end

function TreasureraidersceneView:_onClickProduceRecord()
	local activityId = TreasureRaiderConfig.instance:getActivityId()

	UIStateManager.instance:push(ViewName.TreasureraideawardrecordView, activityId)
end

function TreasureraidersceneView:_onClickSwitchAngle()
	GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderSwitchAngle)
end

function TreasureraidersceneView:_onRandomDiceTipInputChanged(isHover)
	if isHover == false then
		GameUtil.SetActive(self._tipRandomDice, false)
	end
end

function TreasureraidersceneView:_onFixDiceTipInputChanged(isHover)
	if isHover == false then
		GameUtil.SetActive(self._tipFixDice, false)
	end
end

function TreasureraidersceneView:_onClickFixDiceTip()
	GameUtil.SetActive(self._tipFixDice, true)
end

function TreasureraidersceneView:_onClickRandomDiceTip()
	GameUtil.SetActive(self._tipRandomDice, true)
end

function TreasureraidersceneView:_onRevengeTipInputChanged(isHover)
	if isHover == false then
		GameUtil.SetActive(self._tipRevenge, false)
	end
end

function TreasureraidersceneView:_onClickRevenge()
	GameUtil.SetActive(self._tipRevenge, true)
end

function TreasureraidersceneView:_onClickbtnPassPort()
	UIStateManager.instance:push(ViewName.PassportwpdbqbView, 19)
end

function TreasureraidersceneView:_updateRates()
	local rates = TreasureRaiderController.instance:getProduceRates()

	self._itemGroup:updateWithMoArray(rates, function(item, data)
		local txtC_Num = goutil.findChildTextComponent(item.mainGO, "TxtC_Num")
		local ImgC_Icon = goutil.findChild(item.mainGO, "ImgC_Icon")
		local arr = string.split(data.itemKey, ":")
		local matType, cfgId = checknumber(arr[1]), checknumber(arr[2])

		MaterialMgr.setIcon(ImgC_Icon, matType, cfgId)

		txtC_Num.text = data.rateDesc
	end)
	self._layout:Layout()
end

function TreasureraidersceneView:_clearItem(item)
	local ImgC_Icon = goutil.findChild(item.mainGO, "ImgC_Icon")

	MaterialMgr.resetAll(ImgC_Icon)
end

return TreasureraidersceneView
