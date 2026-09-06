-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FamilyNestTowerView.lua

module("logic.extensions.newfamily.view.war.FamilyNestTowerView", package.seeall)

local FamilyNestTowerView = class("FamilyNestTowerView", ViewComponent)

function FamilyNestTowerView:ctor()
	FamilyNestTowerView.super.ctor(self)

	self._conditionItemList = nil
	self._awardItmeList = nil
end

function FamilyNestTowerView:bindEvents()
	FamilyNestTowerView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._challengeBtn:AddClickListener(self._onClickChallengeBtn, self)
end

function FamilyNestTowerView:unbindEvents()
	FamilyNestTowerView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._challengeBtn:RemoveClickListener()
end

function FamilyNestTowerView:onExit()
	FamilyNestTowerView.super.onExit(self)

	for _, item in pairs(self._conditionItemList or {}) do
		if item and item.itemPos then
			MaterialMgr.resetAll(item.itemPos)
		end
	end

	for _, item in pairs(self._awardItmeList or {}) do
		if item then
			MaterialMgr.resetAll(item)
		end
	end

	uGuiUtil.clearImage(self._nestIconGo)
end

function FamilyNestTowerView:destroyUI()
	FamilyNestTowerView.super.destroyUI(self)

	self._conditionItemList = nil
	self._awardItmeList = nil
end

function FamilyNestTowerView:buildUI()
	FamilyNestTowerView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._nameTxt = goutil.findChildTextComponent(self.mainGO, "nameGo/nameTxt")
	self._conditionItemList = {}

	local itemGo = self:getGo("conditionGo_1")

	self._conditionItemList[1] = {
		itemGo = itemGo,
		itemTxt = goutil.findChildTextComponent(itemGo, "conditionTxt"),
		itemPos = goutil.findChild(itemGo, "conditionPos")
	}
	itemGo = self:getGo("conditionGo_2")
	self._conditionItemList[2] = {
		itemGo = itemGo,
		itemTxt = goutil.findChildTextComponent(itemGo, "conditionTxt"),
		itemPos = goutil.findChild(itemGo, "conditionPos")
	}
	itemGo = self:getGo("conditionGo_3")
	self._conditionItemList[3] = {
		itemGo = itemGo,
		itemTxt = goutil.findChildTextComponent(itemGo, "conditionTxt"),
		itemPos = goutil.findChild(itemGo, "conditionPos")
	}
	self._awardItmeList = {
		self:getGo("awardItem_1"),
		self:getGo("awardItem_2"),
		self:getGo("awardItem_3"),
		self:getGo("awardItem_4"),
		self:getGo("awardItem_5"),
		self:getGo("awardItem_6"),
		self:getGo("awardItem_7")
	}
	self._challengeBtn = self:getBtn("challengeBtn")
	self._challengeTxt = goutil.findChildTextComponent(self.mainGO, "challengeTxt")
	self._nestIconGo = self:getGo("nestBgGo/nestIcon")
	self._nameTxt.text = ""
	self._conditionItemList[1].itemTxt.text = ""
	self._conditionItemList[2].itemTxt.text = ""
	self._conditionItemList[3].itemTxt.text = ""
	self._challengeTxt.text = ""
end

function FamilyNestTowerView:onEnter()
	FamilyNestTowerView.super.onEnter(self)

	local params = self:getFirstParam()

	if params == nil or checknumber(params.planId) <= 0 or checknumber(params.nestId) <= 0 then
		printError("sr---家族战   FamilyNestTowerView:onEnter()    参数有误~")
		self:close()

		return
	end

	self._nestCfg = FamilyWarConfig.instance:getFamilyBattleNestCfgs(params.planId, params.nestId)

	if self._nestCfg == nil then
		return
	end

	self._nameTxt.text = self._nestCfg.name

	local conCfgs = FamilyWarConfig.instance:getFamilyNestConditionCfgs(self._nestCfg.nestConditionPlanId)

	for i = 1, #self._conditionItemList do
		if conCfgs and conCfgs[i] and not string.nilorempty(conCfgs[i].prize_client) then
			GameUtil.SetActive(self._conditionItemList[i].itemGo, true)

			self._conditionItemList[i].itemTxt.text = conCfgs[i].desc

			MaterialMgr.setCellByCfg(conCfgs[i].prize_client, self._conditionItemList[i].itemPos)
		else
			GameUtil.SetActive(self._conditionItemList[i].itemGo, false)
		end
	end

	uGuiUtil.setSpriteToImage(self._nestIconGo, uGuiUtil.SpriteType.BigBg, GameUrl.getTaskUrl(self._nestCfg.icon))

	local baseInfo = FamilyWarModel.instance:getFamilyWarBaseInfo()
	local nCount = checknumber(FamilyWarConfig.instance:getFamilyWarCommonParam("NEST_ATTACK_TIMES_LIMIT"))

	haveCount = math.max(nCount - baseInfo.nestAttackTimes, 0)
	self._challengeTxt.text = "剩余挑战次数：" .. haveCount .. "/" .. nCount

	local prizes = string.split(self._nestCfg.prize_client, "#")

	if prizes == nil or #prizes == 0 then
		return
	end

	for i = 1, #prizes do
		if self._awardItmeList and self._awardItmeList[i] then
			MaterialMgr.setCellByCfg(prizes[i], self._awardItmeList[i])
		end
	end
end

function FamilyNestTowerView:_onClickChallengeBtn()
	local baseInfo = FamilyWarModel.instance:getFamilyWarBaseInfo()
	local nCount = checknumber(FamilyWarConfig.instance:getFamilyWarCommonParam("NEST_ATTACK_TIMES_LIMIT"))

	if nCount <= baseInfo.nestAttackTimes then
		FloatWordMgr.instance:show("挑战次数不足！")

		return
	end

	local fsType, cfg = FamilyWarModel.instance:getFamilyWarFuncStage()

	if fsType == FamilyWarController.FuncStageType.None or fsType == FamilyWarController.FuncStageType.Apply or fsType == FamilyWarController.FuncStageType.ApplyEnd then
		FloatWordMgr.instance:show("当前阶段不可操作！")

		return
	end

	if fsType == FamilyWarController.FuncStageType.Formation or fsType == FamilyWarController.FuncStageType.Adjustment or fsType == FamilyWarController.FuncStageType.FormationEnd or fsType == FamilyWarController.FuncStageType.AdjustmentEnd then
		FloatWordMgr.instance:show("当前不是战斗阶段！")

		return
	end

	if fsType == FamilyWarController.FuncStageType.Battle then
		local masterPlanId = FamilyWarModel.instance:getFamilyNestMonsterPlanId(self._nestCfg.nestId)

		if masterPlanId <= 0 then
			FamilyWarController.instance:csRequestFamilyBattleGetNestInfoReq(self._nestCfg.nestId)
			self:close()

			return
		end

		local cfg = FamilyWarConfig.instance:getFamilyNestEnemyCfg(self._nestCfg.nestMonsterPlanId, masterPlanId)

		if cfg == nil or cfg.creepsMasterId == 0 then
			return
		end

		UIStateManager.instance:push(ViewName.FWPNMission, {
			isNest = true,
			enemyId = cfg.creepsMasterId,
			tempId = self._nestCfg.nestId,
			name = self._nestCfg.name
		})
		self:close()

		return
	end

	FloatWordMgr.instance:show("当前阶段不可操作！")
end

return FamilyNestTowerView
