-- chunkname: @modules/logic/fight/view/FightQteView.lua

module("modules.logic.fight.view.FightQteView", package.seeall)

local FightQteView = class("FightQteView", FightBaseView)

function FightQteView.blockEsc()
	logNormal("blockEsc")
end

local MaxPointCount = 12
local ShowPointCount = 10

function FightQteView:onInitView()
	self.viewAnimator = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.goRoot = gohelper.findChild(self.viewGO, "root")
	self.goTotal = gohelper.findChild(self.viewGO, "root/#go_total")
	self.totalAnimator = self.goTotal:GetComponent(gohelper.Type_Animator)
	self.txtTotal = gohelper.findChildText(self.goTotal, "#txt_total")
	self.txtTotalAdd = gohelper.findChildText(self.goTotal, "#txt_total_add")
	self.goFirst = gohelper.findChild(self.viewGO, "root/first_stage")

	self:initEntityPos()
	self:initPointList()

	self.goBtnRoot = gohelper.findChild(self.viewGO, "root/btns")
	self.btnBack = gohelper.findChildButtonWithAudio(self.goBtnRoot, "btnBack")
	self.btnSpeed = gohelper.findChildButtonWithAudio(self.goBtnRoot, "btnSpeed")
	self.imageSpeed = gohelper.findChildImage(self.goBtnRoot, "btnSpeed/image")
	self.txtSpeed = gohelper.findChildText(self.goBtnRoot, "btnSpeed/Text")
	self.btnAuto = gohelper.findChild(self.goBtnRoot, "btnAuto")
	self.speedAnimator = self.btnSpeed:GetComponent(gohelper.Type_Animator)
	self.entityItemDict = {}
	self.goSecond = gohelper.findChild(self.viewGO, "root/second_stage")
	self.goUniqueBtn = gohelper.findChild(self.goSecond, "uniqueBtn")
	self.goUniqueClick = gohelper.findChildClick(self.goUniqueBtn, "click")
	self.goUniquePos = gohelper.findChild(self.goUniqueBtn, "pos")
	self.uniqueAnimator = self.goUniqueBtn:GetComponent(gohelper.Type_Animator)

	NavigateMgr.instance:addEscape(self.viewName, self.blockEsc)

	self.preEnergy = 0
	self.preTotal = 0
end

function FightQteView:initEntityPos()
	self.entityPosDict = {}
	self.goEntityRoot = gohelper.findChild(self.goFirst, "#go_qte")

	for i = 1, 5 do
		local posList = self:getUserDataTb_()

		self.entityPosDict[i] = posList

		local go = gohelper.findChild(self.goEntityRoot, i)

		gohelper.setActive(go, true)

		for j = 1, i do
			local posGo = gohelper.findChild(go, "pos_" .. j)

			table.insert(posList, posGo)
		end
	end
end

function FightQteView:initPointList()
	self.pointItemList = {}

	local goPoint = gohelper.findChild(self.goFirst, "#go_point")

	self.goPointItem = gohelper.findChild(goPoint, "#go_pointitem")

	gohelper.setActive(self.goPointItem, false)

	for i = 1, MaxPointCount do
		local pointItem = self:getUserDataTb_()

		pointItem.go = gohelper.findChild(goPoint, "pos_" .. i)
		pointItem.goPointItem = gohelper.clone(self.goPointItem, pointItem.go)
		pointItem.animator = pointItem.goPointItem:GetComponent(gohelper.Type_Animator)

		gohelper.setActive(pointItem.goPointItem, true)

		local rectTr = pointItem.goPointItem:GetComponent(gohelper.Type_RectTransform)

		recthelper.setAnchor(rectTr, 0, 0)

		pointItem.imageLight = gohelper.findChildImage(pointItem.goPointItem, "light")

		table.insert(self.pointItemList, pointItem)
	end
end

function FightQteView:addEvents()
	self.goUniqueClick:AddClickListener(self.onClickUniqueBtn, self)
	self.btnBack:AddClickListener(self.onClickBack, self)
	self.btnSpeed:AddClickListener(self.onClickSpeed, self)
	self.addEventCb(self, FightController.instance, FightEvent.QTE_OnUpdate, self.onQTEUpdate, self)
	self.addEventCb(self, FightController.instance, FightEvent.QTE_EnterSecond, self.onQTEEnterSecond, self)
	self.addEventCb(self, FightController.instance, FightEvent.QTE_TotalDamageChange, self.onQTETotalDamageChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.QTE_AfterUseQteSkill, self.onQTEAfterUseQteSkill, self)
	self.addEventCb(self, FightController.instance, FightEvent.SetIsShowUI, self.onSetIsShowUI, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnHideQteTotal, self.onHideQteTotal, self)
	self.addEventCb(self, FightController.instance, FightEvent.QTE_BeforeSendUseSkillRpc, self.onBeforeSendUseSkillRpc, self)
end

function FightQteView:onBeforeSendUseSkillRpc()
	local status = self.qteInfo:getStatus()

	if status ~= FightEnum.QTEStage.QTE_SECOND then
		return
	end

	local uniqueEntityMo = self:getUniqueEntityMo()
	local animName = uniqueEntityMo and uniqueEntityMo.skin == 315503 and "click_skin1" or "click"

	AudioMgr.instance:trigger(400037)

	self.uniqueAnimator.speed = FightModel.instance:getSpeed()

	self.uniqueAnimator:Play(animName, 0, 0)
end

function FightQteView:onClickBack()
	if FightDataMgr.instance.stateMgr:isPlayingEnd() then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightBack) then
		local desc, param = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.FightBack)

		GameFacade.showToast(desc, param)

		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidAutoFight) then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightMoveCard) then
		return
	end

	local inDistribute = FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DistributeCard)

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.Enter) or inDistribute then
		local guideList = GuideModel.instance:getDoingGuideIdList()

		if guideList and #guideList > 0 then
			return
		end
	end

	GameSceneMgr.instance:getCurScene().camera:enablePostProcessSmooth(false)
	ViewMgr.instance:openView(ViewName.FightQuitTipView)
end

function FightQteView:onClickSpeed()
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidSpeed) then
		return
	end

	local newSpeed = FightModel.instance:addSpeed()
	local key = PlayerPrefsKey.FightSpeed .. PlayerModel.instance:getPlayinfo().userId

	PlayerPrefsHelper.setNumber(key, newSpeed)
	FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	self:updateSpeed()
end

function FightQteView:updateSpeed()
	local speed = FightModel.instance:getUserSpeed()
	local speedShow = Mathf.Clamp(speed, 1, FightModel.instance:getMaxSpeed())

	UISpriteSetMgr.instance:setFightSprite(self.imageSpeed, "btn_x" .. speedShow, true)

	self.txtSpeed.text = string.format("X%d", speedShow)

	local play_name = speed == 1 and "idle" or "click"

	self.speedAnimator:Play(play_name)
end

function FightQteView:onHideQteTotal()
	self:refreshTotal()
end

function FightQteView:onSetIsShowUI(isVisible)
	gohelper.setActive(self.goBtnRoot, isVisible)

	self.showUI = isVisible

	self:activeTotal()
end

function FightQteView:activeTotal()
	local show = self.preTotal > 0 and self.showUI

	if isDebugBuild then
		show = show and not GMController.instance.hideQteTotal
	end

	gohelper.setActive(self.goTotal, show)
end

function FightQteView:onQTEAfterUseQteSkill()
	self:refreshTotal()
end

function FightQteView:onQTETotalDamageChange(value)
	self:updateTotalTxt(value, true)
	self.totalAnimator:Play("add", 0, 0)
end

function FightQteView:onClickUniqueBtn()
	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return
	end

	local status = self.qteInfo:getStatus()

	if status ~= FightEnum.QTEStage.QTE_SECOND then
		return
	end

	local uniqueEntityMo = self:getUniqueEntityMo()

	if not uniqueEntityMo then
		logError("没有人有终结技")

		return
	end

	local curSelectEntityId = FightDataHelper.operationDataMgr.curSelectEntityId

	FightRpc.instance:sendUseQTESkillRequest(uniqueEntityMo.uid, curSelectEntityId)
end

function FightQteView:onQTEEnterSecond()
	self:refreshUI()
	self.viewAnimator:Play("switch", 0, 0)
end

function FightQteView:onQTEUpdate()
	self:refreshUI()
	self:playViewAnim()
end

function FightQteView:onOpen()
	self.qteMgr = FightDataHelper.qteDataMgr
	self.qteInfo = self.qteMgr:getQteInfo()

	self:com_openSubView(FightAutoBtnView, self.btnAuto)
	self:updateSpeed()
	self:refreshUI()
	self:playViewAnim()
	self:refreshTotal()
end

function FightQteView:playViewAnim()
	local curStatus = self.qteInfo:getStatus()
	local animName = curStatus == FightEnum.QTEStage.QTE_FIRST and "first_stage" or "second_stage"

	self.viewAnimator:Play(animName, 0, 1)
end

function FightQteView:refreshUI()
	local curStatus = self.qteInfo:getStatus()

	gohelper.setActive(self.goFirst, curStatus == FightEnum.QTEStage.QTE_FIRST)
	gohelper.setActive(self.goSecond, curStatus == FightEnum.QTEStage.QTE_SECOND)

	if curStatus == FightEnum.QTEStage.QTE_FIRST then
		self:refreshEnergy()
		self:refreshEntity()
	elseif curStatus == FightEnum.QTEStage.QTE_SECOND then
		self:refreshUniqueBtn()
	end
end

function FightQteView:refreshTotal()
	local roundData = FightDataHelper.roundMgr:getRoundData()

	self:updateTotalTxt(roundData:getQteTotal())
end

function FightQteView:killTween()
	if self.damageTweenId then
		ZProj.TweenHelper.KillById(self.damageTweenId)

		self.damageTweenId = nil
	end
end

FightQteView.TweenDuration = 0.5

function FightQteView:updateTotalTxt(txt, tween)
	self.preTotal = txt

	self:activeTotal()
	self:killTween()

	self.targetValue = txt

	if tween then
		local var_23_0 = tonumber(self.txtTotal.text) or 0
	else
		self:_updateDamage(txt)
	end
end

function FightQteView:_updateDamage(value)
	value = math.floor(value)
	self.txtTotal.text = value
	self.txtTotalAdd.text = value
end

function FightQteView:_onTweenDone()
	self:_updateDamage(self.targetValue)
end

local EnergyChangeStatus = {
	Reduce = 1,
	Add = 2,
	Equal = 3
}

function FightQteView:refreshEnergy()
	local curEnergy = self.qteInfo:getCurEnergy()
	local energyList = self.qteInfo:getEnergyList()
	local status = EnergyChangeStatus.Equal

	status = self.preEnergy == curEnergy and EnergyChangeStatus.Equal or curEnergy > self.preEnergy and EnergyChangeStatus.Add or EnergyChangeStatus.Reduce

	for i, pointItem in ipairs(self.pointItemList) do
		if i <= ShowPointCount then
			gohelper.setActive(pointItem.go, true)

			if status == EnergyChangeStatus.Equal then
				local animName = i <= curEnergy and "light" or "empty"

				pointItem.animator:Play(animName, 0, 1)
			elseif status == EnergyChangeStatus.Add then
				if i <= self.preEnergy then
					pointItem.animator:Play("light", 0, 1)
				elseif i <= curEnergy then
					pointItem.animator:Play("light_open", 0, 0)
				else
					pointItem.animator:Play("empty", 0, 1)
				end
			elseif status == EnergyChangeStatus.Reduce then
				if i <= curEnergy then
					pointItem.animator:Play("light", 0, 1)
				elseif i <= self.preEnergy then
					pointItem.animator:Play("use", 0, 0)
				else
					pointItem.animator:Play("empty", 0, 1)
				end
			end

			local type = energyList[i]

			if type then
				local image = FightQteEntityItemHelper.getCostTypeImage(type)

				UISpriteSetMgr.instance:setFightSprite(pointItem.imageLight, image)
			end
		else
			gohelper.setActive(pointItem.go, false)
		end
	end

	self.preEnergy = curEnergy
end

function FightQteView:refreshEntity()
	self.entityList = self.entityList or {}

	tabletool.clear(self.entityList)
	FightDataHelper.entityMgr:getMyNormalList(self.entityList)

	local entityCount = 0

	for _, mo in ipairs(self.entityList) do
		local entityMo = mo

		if entityMo:isQteEntity() then
			entityCount = entityCount + 1

			local entityItem = self.entityItemDict[entityMo.uid]

			if not entityItem then
				entityItem = FightQteEntityItemHelper.createEntityItem(entityMo, FightQteEntityItemBase.UseType.QTEBtn)

				entityItem:setParent(self.goEntityRoot)
				entityItem:startLoad()

				self.entityItemDict[entityMo.uid] = entityItem
			end

			entityItem:setIndex(entityCount)
			entityItem:refreshUI()
		end
	end

	local posList = self.entityPosDict[entityCount]

	if not posList then
		logError("布局不存在 .. " .. tostring(entityCount))

		return
	end

	for _, entityItem in pairs(self.entityItemDict) do
		local parentGo = posList[entityItem:getIndex()]

		if parentGo then
			entityItem:setParent(parentGo)
		end
	end
end

function FightQteView:refreshUniqueBtn()
	if self.uniqueEntityItem then
		self.uniqueEntityItem:refreshUI()
	else
		local entityMo = self:getUniqueEntityMo()

		if not entityMo then
			logError("未找到有终结技能的实体")

			return
		end

		self.uniqueEntityItem = FightQteEntityItemHelper.createEntityItem(entityMo, FightQteEntityItemBase.UseType.QTEUnique)

		self.uniqueEntityItem:setParent(self.goUniquePos)
		self.uniqueEntityItem:startLoad()
	end
end

function FightQteView:getUniqueEntityMo()
	self.entityList = self.entityList or {}

	tabletool.clear(self.entityList)
	FightDataHelper.entityMgr:getMyNormalList(self.entityList)

	for _, mo in ipairs(self.entityList) do
		local entityMo = mo

		if entityMo:isQteEntity() then
			local groupCo = entityMo:getQteGroupCo()

			if groupCo and groupCo.endId ~= 0 then
				return entityMo
			end
		end
	end
end

function FightQteView:onClose()
	return
end

function FightQteView:onDestroyView()
	if self.goUniqueClick then
		self.goUniqueClick:RemoveClickListener()
	end

	if self.btnBack then
		self.btnBack:RemoveClickListener()
	end

	if self.btnSpeed then
		self.btnSpeed:RemoveClickListener()
	end

	for _, entityItem in pairs(self.entityItemDict) do
		entityItem:dispose()
	end

	tabletool.clear(self.entityItemDict)

	if self.entityList then
		tabletool.clear(self.entityList)
	end

	if self.uniqueEntityItem then
		self.uniqueEntityItem:dispose()

		self.uniqueEntityItem = nil
	end

	self:killTween()
end

return FightQteView
