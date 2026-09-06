-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerMissionView.lua

module("logic.extensions.summontower.view.SummontowerMissionView", package.seeall)

local SummontowerMissionView = class("SummontowerMissionView", MissionView)

function SummontowerMissionView:buildUI()
	SummontowerMissionView.super.buildUI(self)

	self._viewGo = self._viewPresentor:getResInstance(SummontowerMissionViewPresentor.ViewResPath)

	if self._viewGo then
		self._viewGo.transform:SetParent(self.mainGO.transform.parent)
		GameUtil.expandRectTransform(self._viewGo.transform)
		Framework.TransformUtil.SetLocalPos(self._viewGo.transform, 0, 0, 0)
		Framework.TransformUtil.SetLocalScale(self._viewGo.transform, 1, 1, 1)

		self._btnPassAll = Framework.ButtonAdapter.GetFrom(self._viewGo, "btnPass")

		self._btnPassAll.transform:SetParent(self.mainGO.transform)

		self._txtPassCost = goutil.findChildTextComponent(self._btnPassAll.gameObject, "coinNum")
	end
end

function SummontowerMissionView:onEnter()
	SummontowerFmtModel.instance:checkFormationValid()

	self._isClickPassAll = false

	if not goutil.isNil(self._viewGo) then
		self._viewGo:SetActive(true)
	end

	self:onEnterInherit()

	self._gridData = self._viewPresentor._openParam[1]

	self:_setMaskBlock(false)

	self._fmtChanged = false
	self._loader, self._lastCallBack, self._mdlObj = RoleObjectPool.instance:resetLoader(self._loader, self._lastCallBack, self._mdlObj)

	self._videoButton.gameObject:SetActive(false)
	self:_setMissionCfgInfo()
	self:_onSpClassLoad()
	self:_updatePassCost()
	MissionModel.instance:setForceResetOneKey(true)
	GlobalDispatcher:addListener(GlobalNotify.OnSommonTowerDoGrid, self._onSommonTowerDoGrid, self)
end

function SummontowerMissionView:_updatePassCost()
	if not self._txtPassCost then
		return
	end

	self._txtPassCost.text = "消耗" .. self:_getPassCost() .. "银币"
end

function SummontowerMissionView:_getPassCost()
	local gridData = self._viewPresentor._openParam[1]
	local guardEventCo = SummontowerConfig.instance:getGuardEventCo(gridData.gridEventId)

	return guardEventCo.passCoinCost
end

function SummontowerMissionView:onExit()
	if not goutil.isNil(self._viewGo) then
		self._viewGo:SetActive(false)
	end

	SummontowerMissionView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnSommonTowerDoGrid, self._onSommonTowerDoGrid, self)
end

function SummontowerMissionView:bindEvents()
	SummontowerMissionView.super.bindEvents(self)

	if self._btnPassAll then
		self._btnPassAll:AddClickListener(self._onClickPassAll, self)
	end
end

function SummontowerMissionView:unbindEvents()
	SummontowerMissionView.super.unbindEvents(self)

	if self._btnPassAll then
		self._btnPassAll:RemoveClickListener()
	end
end

function SummontowerMissionView:destroyUI()
	SummontowerMissionView.super.destroyUI(self)

	if not goutil.isNil(self._viewGo) then
		goutil.destroy(self._viewGo)

		self._viewGo = nil
	end
end

function SummontowerMissionView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
	SummontowerFastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey())
	MissionModel.instance:setForceResetOneKey(false)
end

function SummontowerMissionView:_onClickClean()
	printInfo("_onClickClean")
	SummontowerFastFormation.instance:clean()
end

function SummontowerMissionView:_onClickStart()
	if not SummontowerModel.instance:isGameInfoReady() then
		UIStateManager.instance:clear(true)

		return
	end

	local hasOneKey = GameUtil.GetActive(self._btnOneKey)

	if SummontowerFmtModel.instance:isCurFormationEmpty() then
		if hasOneKey then
			TipsFacade.instance:openPopupWindow(lang("tip"), lang("fight_unformation"), function()
				return
			end, function()
				self:_onClickOneKey()
			end, lang("fight_goto_fmt"), lang("一键布阵"))
		else
			TipsFacade.instance:openPopupWindow(lang("tip"), lang("fight_unformation"), function()
				return
			end, nil, lang("fight_goto_fmt"))
		end

		return
	end

	if not self:_checkSummonMasterAndAnimal() then
		FloatWordMgr.instance:show("需同时上阵召唤师和契约精灵")

		return
	end

	if self:_checkFormationPosNumber(function()
		self:_startClg()
	end) then
		return
	end

	self:_startClg()
end

function SummontowerMissionView:_checkSummonMasterAndAnimal()
	local formation = SummontowerFmtModel.instance:getFormation()

	if not formation then
		return false
	end

	local pet_poisition = formation:GetPositions()
	local isSummonMasterIn = false
	local isSummonAnimalIn = false

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			if SummontowerPetsModel.instance:isSummonMasterPet(v) then
				isSummonMasterIn = true
			end

			if SummontowerPetsModel.instance:isSummonedAnimalPet(v) then
				isSummonAnimalIn = true
			end
		end
	end

	return isSummonMasterIn and isSummonAnimalIn
end

function SummontowerMissionView:_checkFormationPosNumber(posLimitCallback)
	local formation = SummontowerFmtModel.instance:getFormation()
	local numPos = formation:getCurExistPetNumber()
	local totalPos = 5
	local petsNum = SummontowerPetsModel.instance:getFmtedPetsCount()

	if totalPos <= petsNum and numPos < totalPos then
		local hasOneKey = GameUtil.GetActive(self._btnOneKey)

		if hasOneKey then
			TipsFacade.instance:openPopupWindow(lang("tip"), string.format(lang("fight_fmt_num"), tostring(totalPos)), posLimitCallback, function()
				self:_onClickOneKey()
			end, lang("确定"), lang("一键布阵"))
		else
			TipsFacade.instance:openPopupWindow(lang("tip"), string.format(lang("fight_fmt_num"), tostring(totalPos)), posLimitCallback)
		end

		return true
	end
end

function SummontowerMissionView:_startClg()
	self:_setMaskBlock(true)
	SummontowerFmtModel.instance:saveCurrFormation()
	self:_startNow()
end

function SummontowerMissionView:_setMissionCfgInfo()
	local titleStr = ""
	local levelStr = "召唤迷域"
	local ruleDesc = "击败敌方所有精灵即可获胜"

	self:_setDescStr(titleStr, levelStr, ruleDesc)
	self:_setTitleName()
end

function SummontowerMissionView:_setBattleResultTxtTitle()
	SummontowerMissionView.super._setBattleResultTxtTitle(self)
	BattleModel.instance:setBattleName(self:_getLevelStr())
end

function SummontowerMissionView:_getSpClassCo()
	return nil
end

function SummontowerMissionView:_enterBattle()
	UIJumper.instance:clear()
	UIJumper.instance:pushOneStack(ViewName.MainUI, true)
	UIJumper.instance:pushOneStack(ViewName.SummontowerStartView, true)
	UIJumper.instance:pushOneStack(ViewName.SummontowerMainView, true)
	SummontowerController.instance:startGuardBattle(self._gridData.gridId)
end

function SummontowerMissionView:_onClickPassAll()
	self._isClickPassAll = false

	local price = self:_getPassCost()
	local gameItemCo = SummontowerConfig.instance:getGameItemCo(SummonTowerItemsModel.ItemType.Coin)
	local content = string.format(lang("txt_summontower_buyguard"), price)

	TipsFacade.instance:openPopupCostMatViewNew(MatType.Item_Fake, gameItemCo.itemId, price, content, function()
		self._isClickPassAll = true

		local posRow, posCol = SummontowerMapModel.instance:getRowAndCol(self._gridData.gridId)

		SummontowerMapModel.instance:setPlayerPos(posRow, posCol)
		SummontowerController.instance:passGuardBattle(self._gridData.gridId)
	end)
end

function SummontowerMissionView:_onSommonTowerDoGrid()
	if self._isClickPassAll then
		FloatWordMgr.instance:show("成功击败守卫！")
		UIStateManager.instance:pop()
	end
end

return SummontowerMissionView
