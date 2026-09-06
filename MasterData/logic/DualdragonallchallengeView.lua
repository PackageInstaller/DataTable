-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dualdragonchallenge/view/DualdragonallchallengeView.lua

module("logic.extensions.dualdragonchallenge.view.DualdragonallchallengeView", package.seeall)

local DualdragonallchallengeView = class("DualdragonallchallengeView", ViewComponent)

function DualdragonallchallengeView:ctor()
	DualdragonallchallengeView.super.ctor(self)
end

function DualdragonallchallengeView:unbindEvents()
	DualdragonallchallengeView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btnAddTime:RemoveClickListener()
end

function DualdragonallchallengeView:bindEvents()
	DualdragonallchallengeView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
	self._btnAddTime:AddClickListener(self._onClickbtnAddTime, self)
end

function DualdragonallchallengeView:buildUI()
	DualdragonallchallengeView.super.buildUI(self)

	self._formationGo = self:getGo("formation")
	self._cFormation = CFormation.New(self._formationGo)
	self._goldBarGo = self:getGo("goldBar")
	self._roleconGo = self:getGo("rolecon")
	self._txtBuffDesc = self:getTxt("leftcon/buff/txtBuffDesc")
	self._txtSlider = self:getTxt("leftcon/txtSlider")
	self._txtName = self:getTxt("leftcon/txtName")
	self._hpSlider = self:getSlider("leftcon/slider")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnSure = self:getBtn("rightcon/btnSure")
	self._btnAddTime = self:getBtn("rightcon/btnAddTime")
	self._txtLeftTime = self:getTxt("rightcon/txtLeftTime")
	self._txtTime = self:getTxt("openTime/txtTime")
	self._rewardItemGo = self:getGo("leftcon/reward/rewardItem")
	self._pettableviewGo = self:getGo("leftcon/buff/tableview")
	self._petCellGo = self:getGo("leftcon/buff/petCell")
	self._rewardTableviewGo = self:getGo("leftcon/reward/tableview")
	self._petScrollerList = ScrollerList.create(self._pettableviewGo, self._petCellGo, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._rewardScrollerList = ScrollerList.create(self._rewardTableviewGo, self._rewardItemGo, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._redpointGo = self:getGo("rightcon/btnSure/redpoint")
end

function DualdragonallchallengeView:onExit()
	DualdragonallchallengeView.super.onExit(self)
	GlobalDispatcher:removeListener(DualDragonChallengeAgent.DualDragonChallengeGetInfoRes, self._updateUI, self)
	GlobalDispatcher:removeListener(DualDragonChallengeAgent.DragonBuyUniversalChallengeTimes, self._setLeftTime, self)

	if self._roleObj then
		RoleObjectPool.instance:removeRole(self._roleObj)

		self._roleObj = nil
	end

	self._petScrollerList:dispose()
	self._rewardScrollerList:dispose()
	RedPointController.instance:unregRedPoint(self._redpointGo, RedPointModel.ID_DUALDRAGON_UNIVERSAL)
end

function DualdragonallchallengeView:onEnter()
	DualdragonallchallengeView.super.onEnter(self)
	GlobalDispatcher:addListener(DualDragonChallengeAgent.DualDragonChallengeGetInfoRes, self._updateUI, self)
	GlobalDispatcher:addListener(DualDragonChallengeAgent.DragonBuyUniversalChallengeTimes, self._setLeftTime, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	RedPointController.instance:regRedPoint(self._redpointGo, RedPointModel.ID_DUALDRAGON_UNIVERSAL)
	self:_updateUI()

	local goldBarStr = DualdragonchallengeConfig.instance:getGoldBarStr()

	self:_setTopGoldBar(self._goldBarGo, goldBarStr)
	self:_setBuffDesc()
	self:_setReward()
	self:_setActTime()
	DualDragonChallengeAgent.instance:sendPM_DualDragonChallengeGetInfoReq(self._activityId)
end

function DualdragonallchallengeView:_onClickbtnClose()
	self:close()
end

function DualdragonallchallengeView:_onClickbtnTip()
	local actData = DualdragonchallengeConfig.instance:getActData(self._activityId)

	TipsFacade.instance:openRulesView(actData.ruleKeyUniversal)
end

function DualdragonallchallengeView:_onClickbtnSure()
	local leftTime = DualdragonchallengeModel.instance:getUniversalLeftTime()

	if leftTime <= 0 then
		FloatWordMgr.instance:show("没有挑战次数")

		return
	end

	DualdragonchallengeController.instance:enterUniversalMission(self._activityId, self._creepsMasterId)
end

function DualdragonallchallengeView:_onClickbtnAddTime()
	local leftTime = DualdragonchallengeModel.instance:getUniversalLeftTime()

	if leftTime > 0 then
		FloatWordMgr.instance:show("还有挑战次数，请先使用完挑战次数")

		return
	end

	local leftBuyTime = DualdragonchallengeModel.instance:getUniversalLeftBuyTime()

	if leftBuyTime <= 0 then
		FloatWordMgr.instance:show("已无可购买次数")

		return
	end

	local price = DualdragonchallengeConfig.instance:getUniversalBuyTimePrice(self._activityId)
	local matType, matId, matNum = MaterialMgr.getMatParams(price)
	local matName = MaterialMgr.getMaterialsName(matType, matId)
	local content = string.format("是否消耗%s*%s额外购买挑战次数？", matName, matNum)

	local function successCallBack()
		DualDragonChallengeAgent.instance:sendPM_DualDragonBuyUniversalChallengeTimesReq(self._activityId)
	end

	TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, successCallBack)
end

function DualdragonallchallengeView:_updateUI()
	self._creepsMasterId = DualdragonchallengeModel.instance:getUniversalCreepsMasterId()

	if self._creepsMasterId <= 0 then
		return
	end

	self:_setFormation()
	self:_setRole()
	self:_setBossName()
	self:_setBossHp()
	self:_setLeftTime()
end

function DualdragonallchallengeView:_setBuffDesc()
	local stime, etime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.DualDragon, self._activityId)
	local nowTime = ServerTime.now()
	local days = math.ceil((nowTime - stime) / 86400)
	local buffId = DualdragonchallengeConfig.instance:getUniversalBuffId(self._activityId, days)
	local buffCfg = DualdragonchallengeConfig.instance:getBuffCfg(buffId)

	self._txtBuffDesc.text = buffCfg.des

	self:_setTodayPets(days)
end

function DualdragonallchallengeView:_setFormation()
	self._cFormationMo = self._cFormationMo or CFormationMo.New()

	local creepCfgs = DualdragonchallengeConfig.instance:getCreepCfgs(self._creepsMasterId)

	for i, v in ipairs(creepCfgs) do
		self._cFormationMo:setRaceId(v.posId, v.raceId)
	end

	self._cFormation:onEnter(self._cFormationMo)
end

function DualdragonallchallengeView:_setRole()
	local skinId = DualdragonchallengeConfig.instance:getUniversalRaceId(self._activityId, self._creepsMasterId)
	local displayBagOffset = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)
	local x, y, scale = 0, 0, 1

	if displayBagOffset then
		x = checknumber(displayBagOffset[1])
		y = checknumber(displayBagOffset[2])
		scale = displayBagOffset[3] or 1
	end

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, skinId, self._roleconGo, scale, nil, true, x, y)
end

function DualdragonallchallengeView:_setBossName()
	local skinId = DualdragonchallengeConfig.instance:getUniversalRaceId(self._activityId, self._creepsMasterId)

	self._txtName.text = PetSkinConfig.instance:getPetSkinName(skinId)
end

function DualdragonallchallengeView:_setBossHp()
	local leftHp = DualdragonchallengeModel.instance:getUniversalBossLeftHp()
	local creepCfgs = DualdragonchallengeConfig.instance:getCreepCfgs(self._creepsMasterId)
	local list = {}

	for i, v in ipairs(creepCfgs) do
		if not string.nilorempty(v.extproperties) then
			local attrs = string.split(v.extproperties, "#")
			local attrValues
			local temp = {}

			for i = 1, #attrs do
				local attrName, attrVal = FightingPowerFormula.instance:getAttrNameValue(attrs[i])

				temp[attrName] = attrVal
			end

			AttrMo.addSameAttrs(temp, list)
		end
	end

	if not list[GameEnum.AttrTypeName[GameEnum.AttrType.Hp]] then
		self._txtSlider.text = string.format("%s/%s", leftHp, list[GameEnum.AttrTypeName[GameEnum.AttrType.Hp]])

		self._hpSlider:SetValue(leftHp / list[GameEnum.AttrTypeName[GameEnum.AttrType.Hp]])
	end
end

function DualdragonallchallengeView:_setLeftTime()
	local leftTime = DualdragonchallengeModel.instance:getUniversalLeftTime()

	self._txtLeftTime.text = string.format("今日剩余挑战次数：%s", leftTime)
end

function DualdragonallchallengeView:_setActTime()
	self._txtTime.text = GameUtil.getActTimeDesc(GameEnum.ActivityType.DualDragon, self._activityId)
end

function DualdragonallchallengeView:_setTodayPets(days)
	local raceIds = DualdragonchallengeConfig.instance:getUniversalTodayPets(self._activityId, days)

	self._petScrollerList:reloadData(raceIds)
end

function DualdragonallchallengeView:_updatePetCell(view, cell, raceId, tag)
	raceId = checknumber(raceId)

	local proxy = MaterialMgr.setCell(MatType.Pet, raceId, cell.gameObject)
end

function DualdragonallchallengeView:_clearPetCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function DualdragonallchallengeView:_setReward()
	local rewardList = DualdragonchallengeConfig.instance:getUniversalRewardList(self._activityId)

	self._rewardScrollerList:reloadData(rewardList)
end

function DualdragonallchallengeView:_updateRewardCell(view, cell, cfgStr, tag)
	MaterialMgr.setCellByCfg(cfgStr, cell.gameObject)
end

function DualdragonallchallengeView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

return DualdragonallchallengeView
