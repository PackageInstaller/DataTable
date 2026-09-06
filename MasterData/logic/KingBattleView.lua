-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/view/KingBattleView.lua

module("logic.extensions.kingway.view.KingBattleView", package.seeall)

local KingBattleView = class("KingBattleView", TableViewComponent)

function KingBattleView:ctor()
	KingBattleView.super.ctor(self)

	self.battleCfg = nil
	self.showItemCount = 5
	self.height = 90
	self.rewardGoList = nil
end

function KingBattleView:_onReloadFinish()
	self:OnCellUpdatePosition()
end

function KingBattleView:bindEvents()
	KingBattleView.super.bindEvents(self)
	self.viewCloseBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.KingWay)
		self:close()
	end, self)
	self.viewTipBtn:AddClickListener(function()
		ViewMgr.instance:open(ViewName.RulesView, "kingbattle")
	end, self)
	self.skillBtn:AddClickListener(function()
		UIJumper.instance:pushOneStack(self._viewPresentor.viewName, true, self.battleId)
		BattleFacade.instance:sendPreviewPetBattle(self.battleCfg.petId)
	end, self)
	self.explainBtn:AddClickListener(function()
		PetbookController.instance:openPetinfoView(self.battleCfg.petId)
	end, self)
	self.battleBtn:AddClickListener(function()
		if self.choStageId > self.stageId then
			FloatWordMgr.instance:show("请先通关前面的关卡！")

			return
		end

		if self.choStageId < self.stageId then
			FloatWordMgr.instance:show("此关卡已通关！")

			return
		end

		UIStateManager.instance:push(ViewName.KingWayMission)
	end, self)
	self._tableview:AddOnScrollValueChanged(self.OnCellUpdatePosition, self)
	self._btnRankReward:AddClickListener(self._onClickReward, self)
end

function KingBattleView:unbindEvents()
	KingBattleView.super.unbindEvents(self)
	self.viewCloseBtn:RemoveClickListener()
	self.viewTipBtn:RemoveClickListener()
	self._tableview:UnRegisterAllCallbacks()
	self._btnRankReward:RemoveClickListener()
end

function KingBattleView:buildUI()
	KingBattleView.super.buildUI(self)

	self.backImaGo1 = self:getGo("backImaGo1")
	self.backImaGo2 = self:getGo("backImaGo2")
	self.frontImaGo1 = self:getGo("frontImaGo1")
	self.frontImaGo2 = self:getGo("frontImaGo2")
	self.roleModel = self:getGo("roleModel")

	local upShowGo = self:getGo("upShowGo")

	self.viewCloseBtn = Framework.ButtonAdapter.GetFrom(upShowGo, "viewCloseBtn")
	self.viewTipBtn = Framework.ButtonAdapter.GetFrom(upShowGo, "viewTipBtn")
	self.skillBtn = self:getBtn("skillBtn")
	self.explainBtn = self:getBtn("explainBtn")
	self.passShowTxt = self:getGo("passInfoGo/passShowTxt"):GetComponent("Text")
	self.nameTypeTxt = self:getGo("roleNameInfo/nameTypeTxt"):GetComponent("Text")
	self.nameTypeIma = self:getGo("roleNameInfo/nameTypeIma"):GetComponent("UIImageSpriteChange")
	self.nameShowTxt = self:getGo("roleNameInfo/nameShowTxt"):GetComponent("Text")
	self.passShowTxt.text = ""
	self.nameTypeTxt.text = ""
	self.nameShowTxt.text = ""
	self.battleBtn = self:getBtn("battleBtn")

	if self.rewardGoList == nil or #self.rewardGoList == 0 then
		self.rewardGoList = {
			self:getGo("rewardBgTran/rewardTran1"),
			self:getGo("rewardBgTran/rewardTran2"),
			self:getGo("rewardBgTran/rewardTran3"),
			self:getGo("rewardBgTran/rewardTran4"),
			(self:getGo("rewardBgTran/rewardTran5"))
		}
	end

	self.viewEffPos = self:getGo("viewEffPos")
	self._verifyContainer = self:getGo("verifyContainer")
	self._goReward = self:getGo("reward")
	self._rewardPet = self:getGo("reward/rewardPet")
	self._txtReward = goutil.findChildTextComponent(self.mainGO, "reward/txtReward")
	self._btnRankReward = self:getBtn("btnRankReward")
end

function KingBattleView:onEnterFinished()
	KingBattleView.super.onEnterFinished(self)
end

function KingBattleView:onExitFinished()
	return
end

function KingBattleView:onExit()
	KingBattleView.super.onExit(self)

	self._isInView = nil

	KingWayModel.instance:SetBattlePlayerPrefs()

	self.loader = RoleObjectPool.instance:removeRole(self.loader)

	if self.pmEff then
		UIEffectManager.instance:stopEffect(self.pmEff)
	end

	self.pmEff = nil

	GuideController.instance:setViewVar("kingway_model_get_end", nil)
end

function KingBattleView:destroyUI()
	KingBattleView.super.destroyUI(self)

	self.battleCfg = nil
	self.battleInfo = nil
	self.rewardGoList = nil
	self._isInView = nil
end

function KingBattleView:onEnter()
	KingBattleView.super.onEnter(self)

	self.battleId, self.stageId = KingWayModel.instance:GetKingBattleAndStageId()
	self.battleCfg = KingWayConfig.instance:GetWayBaseCfg(self.battleId)

	if self.battleCfg == nil then
		error("sr_王者之路  KingBattleView:onEnter()    获取配置为空 = " .. self.battleId)

		return
	end

	self._isInView = true

	local isBoss = self.battleId == KingWayModel.instance:GetKingAllBattleCount()

	self.backImaGo1:SetActive(not isBoss)
	self.frontImaGo1:SetActive(not isBoss)
	self.backImaGo2:SetActive(isBoss)
	self.frontImaGo2:SetActive(isBoss)

	self.stageId = self.stageId + 1
	self._curViewDatas = KingWayConfig.instance:GetWayStageCfg(self.battleId)

	self:ShowRoleModel()

	self.choStageId = self.stageId

	self:ChoiseBattleStageShow(self.choStageId, true)
	GuideController.instance:setViewVar("kingway_model_get_end", self.battleId .. "_" .. self.stageId)

	local effPath = "fx_ui_wangzhezhilu/fx_ui_wangzhezhilu_star.prefab"

	self.pmEff = UIEffectManager.instance:playEffect(self, effPath, self.viewEffPos, 0, 0, true, nil, nil, nil, self)

	self.pmEff:setParent(self.viewEffPos.transform)
	self.pmEff:setLocalPos(0, 0, 0)
	self.pmEff:setScale(1)
	PetverifyController.instance:initInstance(GameEnum.VerifyType.KingWay)
	KingWayModel.instance:setVerifyPlanId(self.battleCfg.verifyPlanId)
	KingWayController.instance:CSRequestKingInfo(function()
		if not self._isInView then
			return
		end

		self:_refreshVerify()
	end)
end

function KingBattleView:_refreshVerify()
	if checknumber(self.battleCfg.verifyPlanId) ~= 0 then
		self:_setVerifyContainer()
	end
end

function KingBattleView:ChoiseBattleStageShow(index, isForce)
	if index > self.stageId then
		FloatWordMgr.instance:show("请先通关前面的关卡！")

		return
	end

	if index < self.stageId then
		FloatWordMgr.instance:show("此关卡已通关！")

		return
	end

	if not isForce and index == self.choStageId then
		return
	end

	self.choStageId = index

	self._tableview:ReloadData()

	if self.rewardGoList and #self.rewardGoList > 0 then
		for i = 1, #self.rewardGoList do
			MaterialMgr.resetAll(self.rewardGoList[i])
		end
	end

	local goodsList = KingWayModel.instance:GetWayStageGoods(self.battleId, self.choStageId)

	if goodsList == nil or #goodsList == 0 then
		return
	end

	for i = 1, #goodsList do
		if not string.nilorempty(goodsList[i]) and self.rewardGoList[i] then
			local list = string.split(goodsList[i], ":")

			if list and #list >= 2 then
				local goodsType = checknumber(list[1])
				local goodsId = checknumber(list[2])
				local goodsCount = list[3] and checknumber(list[3]) or 1
				local jlLua = MaterialMgr.setCell(goodsType, goodsId, self.rewardGoList[i])

				GameUtil.setLocalScale(jlLua.view, 0.8, 0.8, 0.8)
				jlLua.binder:setNum(goodsCount)
			end
		end
	end

	local petCfg = CharacterConfig.instance:getPetCo(self.battleCfg.petId)

	if petCfg == nil then
		error("sr_王者之路  KingBattleView:onEnter()    精灵配置为空 = ", self.battleCfg.petId)

		return
	end

	local goods = KingWayModel.instance:GetWayStageGoods(self.battleId, #self._curViewDatas)

	self._txtReward.text = string.format("通关\n第<color=#60ee85>%s</color>层", #self._curViewDatas)

	self._goReward:SetActive(true)
	MaterialMgr.setCellByCfg(goods[1], self._rewardPet)
end

function KingBattleView:ShowRoleModel()
	local petCfg = CharacterConfig.instance:getPetCo(self.battleCfg.petId)

	if petCfg == nil then
		error("sr_王者之路  KingBattleView:onEnter()    精灵配置为空 = ", self.battleCfg.petId)

		return
	end

	self.passShowTxt.text = string.format("通关第<color=#60ee85>%s</color>层挑战，获得精灵<color=#60ee85>%s</color>", #self._curViewDatas, petCfg.name)

	local rare = CharacterConfig.instance:getRareByAwakenLv(petCfg.initAwakenLv, petCfg.raceId)

	self.nameTypeIma:SetState(rare - 1)

	self.nameShowTxt.text = petCfg.name

	local modelOff = CharacterConfig.instance:getModelUIPosAndScale("kingway", self.battleCfg.petId)

	if not modelOff[4] then
		if not modelOff[5] then
			local posy = 0

			if not modelOff[6] then
				local scale = 1

				self.loader = RoleObjectPool.instance:removeRole(self.loader)
				self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, petCfg.faceIds, self.roleModel, scale, nil, nil, modelOff[4], posy)
			end
		end
	end
end

function KingBattleView:_getPath()
	return {
		cellPath = "lunPanItem",
		viewPath = "lunPanSR"
	}
end

function KingBattleView:_cellSize()
	return 330, self.height
end

function KingBattleView:_updateCell(view, cell, data)
	local itemGo = goutil.findChild(cell, "itemGo")
	local choiIconGo = goutil.findChild(itemGo, "choiIconGo")
	local indexTxt = goutil.findChildTextComponent(itemGo, "indexTxt")
	local lineIconGo = goutil.findChild(itemGo, "lineIconGo")
	local lockImaGo = goutil.findChild(itemGo, "lockImaGo")
	local passGo = goutil.findChild(itemGo, "passGo")
	local redpointGo = goutil.findChild(itemGo, "redpointGo")

	lockImaGo:SetActive(data.stageId > self.stageId)
	passGo:SetActive(data.stageId < self.stageId)

	if data.stageId == self.stageId and KingWayModel.instance:GetBattleAndStageRedPoint() then
		redpointGo:SetActive(true)
	else
		redpointGo:SetActive(false)
	end

	if data.stageId == self.choStageId then
		lineIconGo:SetActive(false)
		choiIconGo:SetActive(true)

		indexTxt.text = string.format("<color=#253053><size=30>挑战%s层</size></color>", data.stageId)
	else
		choiIconGo:SetActive(false)
		lineIconGo:SetActive(true)

		indexTxt.text = string.format("<color=#ffffff><size=24>挑战%s层</size></color>", data.stageId)
	end

	GameUtil.asBtn(itemGo):AddClickListener(function()
		self:ChoiseBattleStageShow(data.stageId)
	end, self)
end

function KingBattleView:OnCellUpdatePosition(pos)
	local count = self._tableview:GetVisibleCount()

	for i = 0, count - 1 do
		local cell = self._tableview:GetCellByIndex(i)

		if cell then
			local subGo = goutil.findChild(cell, "itemGo")

			if subGo then
				local conPosY = self:CalculationLocalPosition(self._tableview:GetContent())
				local newX = math.abs(cell.transform.localPosition.y) - conPosY
				local rem = newX - math.floor(newX / (self.height * self.showItemCount)) * (self.height * self.showItemCount)

				if rem < self.height or rem >= self.height * (self.showItemCount - 1) then
					Framework.TransformUtil.SetLocalPos(subGo.transform, 45, 0, 0)
				elseif rem >= self.height and rem < self.height * 2 or rem >= self.height * 3 and rem < self.height * (self.showItemCount - 1) then
					Framework.TransformUtil.SetLocalPos(subGo.transform, 5, 0, 0)
				else
					Framework.TransformUtil.SetLocalPos(subGo.transform, -20, 0, 0)
				end
			end
		end
	end
end

function KingBattleView:CalculationLocalPosition(go)
	if go == nil then
		return 8
	end

	local posY = go.transform.localPosition.y

	if posY < 0 then
		return 8
	end

	if self._curViewDatas == nil or #self._curViewDatas <= self.showItemCount then
		return 8
	end

	local differ = (#self._curViewDatas - self.showItemCount) * self.height

	if differ < posY then
		return differ
	end

	return posY + 8
end

function KingBattleView:_setVerifyContainer()
	self:showTabAt(self._verifyContainer, ViewName.PetverifyentranceView)
end

function KingBattleView:_onClickReward()
	UIStateManager.instance:push(ViewName.KingwayprizeView)
end

return KingBattleView
