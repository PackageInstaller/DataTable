-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newsummonpetobtain/view/NewSummonPetObtainMainView.lua

module("logic.extensions.newsummonpetobtain.view.NewSummonPetObtainMainView", package.seeall)

local NewSummonPetObtainMainView = class("NewSummonPetObtainMainView", ViewComponent)

function NewSummonPetObtainMainView:buildUI()
	NewSummonPetObtainMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnIntroduce")
	self._btnRank = goutil.findChild(self.mainGO, "btnRank")
	self._redBtnRank = goutil.findChild(self.mainGO, "btnRank/redPoint")
	self._btnLottery = goutil.findChild(self.mainGO, "btnLottery")
	self._redBtnLottery = goutil.findChild(self.mainGO, "btnLottery/redPoint")
	self._challengeButtomView = goutil.findChild(self.mainGO, "challengeButtom")
	self._btnMusic = goutil.findChild(self.mainGO, "btnMusic/btn")
	self._redBtnMusic = goutil.findChild(self.mainGO, "btnMusic/btn/redPoint")
	self._btnChallenge = goutil.findChild(self.mainGO, "btnChallenge/btn")
	self._redBtnChallenge = goutil.findChild(self.mainGO, "btnChallenge/btn/redPoint")
	self._ScrollRect = goutil.findChild(self.mainGO, "sliderCol/ScrollRect")
	self._progressBar = goutil.findChild(self.mainGO, "sliderCol/ScrollRect/ViewPort/Content/progressBar")
	self._content = goutil.findChild(self.mainGO, "sliderCol/ScrollRect/ViewPort/Content")
	self._gridView = goutil.findChild(self.mainGO, "sliderCol/ScrollRect/ViewPort/Content/gridView")
	self._gridCell = goutil.findChild(self.mainGO, "sliderCol/ScrollRect/ViewPort/Content/gridCell")
	self._txtTotalDesc = goutil.findChildTextComponent(self.mainGO, "sliderCol/totalCol/txtTotalDesc")

	local exParams = {
		Content = self._content,
		cellGroup = self._gridView,
		progressBar = self._progressBar
	}

	self._progressList = ProgressList.create(self._ScrollRect, self._gridCell, GameUtil.handler(self._updateProgressGrid, self), GameUtil.handler(self._clearProgressCell, self), exParams)
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._con = goutil.findChild(self.mainGO, "con")

	GameUtil.SetActive(self._redBtnLottery, false)
	GameUtil.SetActive(self._redBtnChallenge, false)

	self._gridEffList = {}
	self._bgEff = nil
end

function NewSummonPetObtainMainView:bindEvents()
	NewSummonPetObtainMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnLottery, self._onClickBtnLottery, self)
	GameUtil.addClickHandler(self._btnMusic, self._onClickBtnMusic, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickBtnChallenge, self)
end

function NewSummonPetObtainMainView:unbindEvents()
	NewSummonPetObtainMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnLottery)
	GameUtil.rmClickHandler(self._btnMusic)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function NewSummonPetObtainMainView:_getActivityId()
	return NewSummonPetObtainController.instance:getBeiduoActivityId()
end

function NewSummonPetObtainMainView:onEnter()
	NewSummonPetObtainMainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = self:_getActivityId()
	end

	if self._activityId == 0 then
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.NewSummonPetObtainGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.NewSummonPetObtainGainPrizeRes, self._sendInfoReq, self)
	self:_sendInfoReq()
end

function NewSummonPetObtainMainView:onExit()
	NewSummonPetObtainMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.NewSummonPetObtainGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.NewSummonPetObtainGainPrizeRes, self._sendInfoReq, self)
	RedPointController.instance:unregRedPoint(self._redBtnRank)
	RedPointController.instance:unregRedPoint(self._redBtnMusic)

	if self._bgEff then
		UIEffectManager.instance:stopEffect(self._bgEff)

		self._bgEff = nil
	end

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
end

function NewSummonPetObtainMainView:_sendInfoReq()
	NewSummonPetObtainController.instance:sendPM_NewSummonPetObtainGetInfoReq(self._activityId)
end

function NewSummonPetObtainMainView:_setOpenTime()
	local startStamp, endStamp = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.PET_OBTAIN, self._activityId)

	if self._txtOpenTime then
		self._txtOpenTime.text = "活动时间：" .. GameUtil.getFormatTimeByStamp(startStamp, endStamp)
	end
end

function NewSummonPetObtainMainView:_onSetUI()
	local redIdAsRank = NewSummonPetObtainConfig.instance:getNspoCommonValue(self._activityId, "NSOP_PET_TOP_RANK_RED")

	if not string.nilorempty(redIdAsRank) then
		RedPointController.instance:regRedPoint(self._redBtnRank, redIdAsRank)
	end

	local redIdAsMusicPlay = NewSummonPetObtainConfig.instance:getNspoMusicCanPlayRedId(self._activityId)
	local redIdAsMusicPrize = NewSummonPetObtainConfig.instance:getNspoMusicPrizeRedId(self._activityId)
	local redIdList = {}

	for _, redId in ipairs({
		redIdAsMusicPlay,
		redIdAsMusicPrize
	}) do
		if not string.nilorempty(redId) then
			table.insert(redIdList, redId)
		end
	end

	if #redIdList > 0 then
		RedPointController.instance:regRedPoint(self._redBtnMusic, unpack(redIdList))
	end

	self:_setOpenTime()

	local effParent = self.mainGO
	local pathName = "20221104/beiduo_jm/fx_ui_beiduo_jm1"

	UIEffectManager.instance:stopEffect(self._bgEff)

	if self:_isNeedBgEff() and effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._bgEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end

	if self:_isNeedSpine() then
		local skinId = self:_getSkinId()

		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)
	end

	local raceId = self:_getRaceId()

	if raceId > 0 then
		MaterialMgr.setCell(MatType.Rare, raceId, self._pointRare)
	end
end

function NewSummonPetObtainMainView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function NewSummonPetObtainMainView:_onUpdateData()
	return
end

function NewSummonPetObtainMainView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateSliderCol()
end

function NewSummonPetObtainMainView:_onUpdatePlaneUI()
	return
end

function NewSummonPetObtainMainView:_onUpdateSliderCol()
	local prizeCfg = NewSummonPetObtainConfig.instance:getNspoPrizeCfgById(self._activityId)
	local curProgress = NewSummonPetObtainModel.instance:getCurScoreInProgress()
	local maxProgress = NewSummonPetObtainController.instance:getMaxNeedScoreInProgress(self._activityId)

	self._txtTotalDesc.text = maxProgress <= curProgress and "已满" or curProgress

	self._progressList:reloadDataList(prizeCfg)
	self._progressList:updateCell()

	local proList = {}

	for _, data in ipairs(prizeCfg) do
		table.insert(proList, data.needScore)
	end

	self._progressList:updateProgressByList(proList, curProgress)

	local index = 0

	for idx, data in ipairs(prizeCfg) do
		if NewSummonPetObtainController.instance:isCanGetPrizeInProgress(data.prizeId) then
			index = idx

			break
		end
	end

	if index ~= 0 then
		self._progressList:rollToIdx(index)
	else
		self._progressList:rollToIdxNewest(proList, curProgress)
	end
end

function NewSummonPetObtainMainView:_updateProgressGrid(go, data, idx)
	local mainGo = go
	local item = goutil.findChild(mainGo, "item/itemcell")
	local receivedGo = goutil.findChild(mainGo, "receivedGo")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local txtNum = goutil.findChildTextComponent(mainGo, "txtNum")
	local effectParent = goutil.findChild(mainGo, "effect")
	local isHasGain = NewSummonPetObtainController.instance:isHasGainPrizeInProgress(data.prizeId)
	local isCanGet = NewSummonPetObtainController.instance:isCanGetPrizeInProgress(data.prizeId)

	if not string.nilorempty(data.prize) then
		MaterialMgr.setCellByCfg(data.prize, item)
	else
		MaterialMgr.resetAll(item)
	end

	if txtNum then
		txtNum.text = data.needScore
	end

	GameUtil.SetActive(receivedGo, isHasGain)
	GameUtil.SetActive(btnGet, isCanGet)
	UIEffectManager.instance:stopEffect(self._gridEffList[mainGo])

	self._gridEffList[mainGo] = nil

	if isCanGet == true then
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		local function func(_, eff)
			eff:setScrollRectClipping(self._ScrollRect:GetComponent(ComponentType.ScrollRect))
			eff:setParent(effectParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)
		end

		self._gridEffList[mainGo] = UIEffectManager.instance:playEffect(self, effPath, effectParent, 0, 0, true, false, nil, func, nil)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickGridCell, self, data))
end

function NewSummonPetObtainMainView:_clearProgressCell(go, data, idx)
	local mainGo = go
	local item = goutil.findChild(mainGo, "item/itemcell")
	local btnGet = goutil.findChild(mainGo, "btnGet")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)

	if self._gridEffList[mainGo] then
		UIEffectManager.instance:stopEffect(self._gridEffList[mainGo])

		self._gridEffList[mainGo] = nil
	end
end

function NewSummonPetObtainMainView:_onClickGridCell(data)
	if NewSummonPetObtainController.instance:isHasGainPrizeInProgress(data.prizeId) then
		FloatWordMgr.instance:show("您已领奖")

		return
	end

	if not NewSummonPetObtainController.instance:isEnoughPrizeInProgress(data.prizeId) then
		FloatWordMgr.instance:show("未满足领奖要求")

		return
	end

	NewSummonPetObtainController.instance:sendPM_NewSummonPetObtainGainPrizeReq(self._activityId, data.prizeId)
end

function NewSummonPetObtainMainView:_getSkinId()
	return NewSummonPetObtainConfig.instance:getNspoPetSkinId(self._activityId)
end

function NewSummonPetObtainMainView:_getRaceId()
	local skinData = PetSkinConfig.instance:getPetSkinCfg(self:_getSkinId())

	return (skinData or nil) and (skinData.raceId or 0)
end

function NewSummonPetObtainMainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	PetbookController.instance:previewBattle(raceId, skinId)
end

function NewSummonPetObtainMainView:_onClickBtnIntroduce()
	local raceId = self:_getRaceId()

	PetbookController.instance:openPetinfoView(raceId)
end

function NewSummonPetObtainMainView:_onClickBtnRank()
	local jumpToStr = NewSummonPetObtainConfig.instance:getNspoCommonValue(self._activityId, "NSOP_JUMP_PET_TOP_RANK")

	GotoMgr.gotoByString(jumpToStr)
end

function NewSummonPetObtainMainView:_onClickBtnLottery()
	local jumpToStr = NewSummonPetObtainConfig.instance:getNspoCommonValue(self._activityId, "NSOP_JUMP_SHOP_KEY")

	GotoMgr.gotoByString(jumpToStr)
end

function NewSummonPetObtainMainView:_onClickBtnMusic()
	UIStateManager.instance:push(ViewName.NsopPlayMusicMainView)
end

function NewSummonPetObtainMainView:_onClickBtnChallenge()
	UIStateManager.instance:push(ViewName.NsopMagicChallengeMainView)
end

function NewSummonPetObtainMainView:_onClickBtnTip()
	local key = NewSummonPetObtainConfig.instance:getNspoCommonValue(self._activityId, "NSOP_MAIN_RULE_KEY")

	TipsFacade.instance:openRulesView(key)
end

function NewSummonPetObtainMainView:_isNeedBgEff()
	return true
end

function NewSummonPetObtainMainView:_isNeedSpine()
	return true
end

return NewSummonPetObtainMainView
