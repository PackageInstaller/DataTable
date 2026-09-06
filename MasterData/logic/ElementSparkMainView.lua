-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkMainView.lua

module("logic.extensions.elementspark.view.ElementSparkMainView", package.seeall)

local ElementSparkMainView = class("ElementSparkMainView", ViewComponent)

function ElementSparkMainView:ctor()
	ElementSparkMainView.super.ctor(self)
end

function ElementSparkMainView:unbindEvents()
	ElementSparkMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnMap)
	GameUtil.rmClickHandler(self._btnTag)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnTeam)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	self._btnRetreat:RemoveListener()
	self._btnAttack:RemoveListener()
	self._btnDefend:RemoveListener()
	self._btnTagCancel:RemoveClickListener()
	self._btnTagReplace:RemoveClickListener()
	self._btnOpRetreat:RemoveClickListener()
	self._btnOpDefend:RemoveClickListener()
	self._btnOpAttack:RemoveClickListener()
	self._btnChat:RemoveClickListener()
end

function ElementSparkMainView:bindEvents()
	ElementSparkMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnMap, self._onClickMap, self)
	GameUtil.addClickHandler(self._btnTag, self._onClickTag, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickTask, self)
	GameUtil.addClickHandler(self._btnTeam, self._onClickTeam, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	self._btnRetreat:AddListener(self._onClickbtnRetreat, self)
	self._btnAttack:AddListener(self._onClickbtnAttack, self)
	self._btnDefend:AddListener(self._onClickbtnDefend, self)
	self._btnTagCancel:AddClickListener(self._onClickbtnTagCancel, self)
	self._btnTagReplace:AddClickListener(self._onClickbtnTagReplace, self)
	self._btnOpRetreat:AddClickListener(self._onClickbtnOpRetreat, self)
	self._btnOpDefend:AddClickListener(self._onClickbtnOpDefend, self)
	self._btnOpAttack:AddClickListener(self._onClickbtnOpAttack, self)
	self._btnChat:AddClickListener(self._onClickBtnChat, self)
end

function ElementSparkMainView:buildUI()
	ElementSparkMainView.super.buildUI(self)

	self._txtTime = self:getTxt("info/txtTime")
	self._txtCamp = self:getTxt("info/txtCamp")
	self._txtFireCamp = self:getTxt("info/txtFireCamp")
	self._txtScore = self:getTxt("info/txtScore")
	self._txtContribute = self:getTxt("info/txtContribute")
	self._txtShopScore = self:getTxt("info/txtShopScore")
	self._txtOrder = self:getTxt("info/order/txtOrder")
	self._txtRestTime = self:getTxt("info/restTime/time/txtTime")
	self._restTime = self:getGo("info/restTime")
	self._taskRd = self:getGo("btnTask/redpoint")
	self._resourceRd = self:getGo("btnInfo/redpoint")
	self._tagAction = self:getGo("tagAction")
	self._btnMap = self:getBtn("btnMap")
	self._btnTag = self:getBtn("btnTag")
	self._btnShop = self:getBtn("btnShop")
	self._btnTask = self:getBtn("btnTask")
	self._btnTeam = self:getBtn("btnTeam")
	self._btnInfo = self:getBtn("btnInfo")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnRetreat = self:getBtn("tagAction/btnRetreatcon/btnRetreat"):GetComponent("UILongPressed")
	self._btnAttack = self:getBtn("tagAction/btnAttackcon/btnAttack"):GetComponent("UILongPressed")
	self._btnDefend = self:getBtn("tagAction/btnDefendcon/btnDefend"):GetComponent("UILongPressed")
	self._txtTagNum = self:getTxt("btnTag/num/txt")
	self._tagopGo = self:getGo("tagop")
	self._btnTagCancel = self:getBtn("tagop/btnTagCancel")
	self._btnTagReplace = self:getBtn("tagop/btnTagReplace")
	self._tagOpBtnIconChange = self:getGo("tagop/btn"):GetComponent(ComponentType.UIImageSpriteChange)
	self._btnOpRetreat = self:getBtn("tagop/tagAction/btnRetreatcon/btnRetreat")
	self._btnOpDefend = self:getBtn("tagop/tagAction/btnDefendcon/btnDefend")
	self._btnOpAttack = self:getBtn("tagop/tagAction/btnAttackcon/btnAttack")
	self._txtOpBtn = self:getTxt("tagop/btn/txt")
	self._tagOpActionGo = self:getGo("tagop/tagAction")
	self._btnChat = self:getBtn("Nego_Chat")
end

function ElementSparkMainView:onExit()
	ElementSparkMainView.super.onExit(self)
	removetimer(self._countDown, self)
	removetimer(self._update, self)
	RedPointController.instance:unregRedPoint(self._taskRd)
end

function ElementSparkMainView:onEnter()
	ElementSparkMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.EleSparkGetInfoRes, self._refresh, self)
	self.addGEvent(self, GlobalNotify.ElementSparkTagChange, self._refresh, self)
	self.addGEvent(self, GlobalNotify.EleSparkGetCampInfoRes, self._refreshCamp, self)
	self.addGEvent(self, GlobalNotify.ElementSparkClickChunkWithTag, self._onDropTagIntoChunk, self)
	self.addGEvent(self, GlobalNotify.ElementReplaceSparkTag, self._onElementReplaceSparkTag, self)
	self.addGEvent(self, GlobalNotify.EleSparkGainResourceRes, self._hideResourceRd, self)

	self._activityId = ElementSparkController.instance:getActivityId()
	self._showTagAction = false
	self._isTouchedDown = false
	self._tagType = -1
	self._chunkScale = self._chunkMinSale

	local actCfg = ElementSparkConfig.instance:getActivityCfgById(self._activityId)

	self._txtRestTime.text = ElementSparkController.instance:restTimeDesc()

	GameUtil.SetActive(self._btnTag.gameObject, false)
	GameUtil.SetActive(self._tagAction, false)

	self._tagBtnGameObject = nil

	settimer(0, self._update, self, true)
	self:_refresh()
	self:_refreshCamp()
	self:_visibleTagop(false)

	local taskPlanCfg = EventTaskSummaryConfig.instance:getPlanCfg(self._activityId)

	if taskPlanCfg then
		RedPointController.instance:regRedPoint(self._taskRd, taskPlanCfg.redPointId)
	else
		printError("yh运营-活动任务缺配置 ", self._activityId)
	end

	self:_playFirstGetInfo()
end

function ElementSparkMainView:_refresh()
	if not ElementSparkController.instance:isResultTime() then
		settimer(1, self._countDown, self, true)
	else
		removetimer(self._countDown, self)

		self._txtTime.text = "剩余战斗时间：战斗已结束"
	end

	self._info = ElementSparkModel.instance:getInfo()
	self._petShopScore = ElementSparkModel.instance:getPetShopScore()

	local campName = ElementSparkController.instance:getMyCampName()
	local sparkBelongId = ElementSparkController.instance:getSparkBelongCampId()
	local sparkCamp = "无"

	if sparkBelongId > 0 then
		sparkCamp = ElementSparkConfig.instance:getCampCfgById(self._activityId, sparkBelongId).name
	end

	self._txtCamp.text = string.format("我的阵营：%s", campName)
	self._txtFireCamp.text = string.format("火种归属：%s", sparkCamp)
	self._txtScore.text = string.format("阵营积分：%d", checknumber(self._info.campScore))
	self._txtContribute.text = string.format("个人积分：%d", checknumber(self._info.personScore))
	self._txtShopScore.text = string.format("酒馆积分：%d", checknumber(self._petShopScore))
	self._txtTagNum.text = string.format("%s/%s", ElementSparkModel.instance:getTagUseNum(), ElementSparkConfig.instance:getCommonCfgByKey("TAG_NUM"))
	self._txtOrder.text = ElementSparkModel.instance:getLastestCommand()

	self:_refreshRd()
end

function ElementSparkMainView:_refreshRd()
	if not ElementSparkController.instance:isResultTime() then
		local isCanGain = ElementSparkController.instance:isCanGainResource()

		GameUtil.SetActive(self._resourceRd, isCanGain)
	else
		GameUtil.SetActive(self._resourceRd, false)
	end
end

function ElementSparkMainView:_hideResourceRd()
	GameUtil.SetActive(self._resourceRd, false)
end

function ElementSparkMainView:_onPopeDistributeTip(view)
	if view.viewName == ViewName.PopupImageRuleView then
		local fristInBattle = ElementSparkController.instance:isFristInBattle()

		if fristInBattle then
			self:_openDistributeTip()
		end
	end
end

function ElementSparkMainView:_refreshCamp()
	local isCommander = ElementSparkController.instance:isCommander()

	GameUtil.SetActive(self._btnTag.gameObject, isCommander)
	GameUtil.SetActive(self._tagAction, self._showTagAction)
end

function ElementSparkMainView:_countDown()
	local isRestTime, cutDownTime = ElementSparkController.instance:isRestTime()
	local time = cutDownTime - ServerTime.nowServerLook()
	local hour, min, sec = GameUtil.getTimeHHMMSS(time)

	GameUtil.SetActive(self._restTime, isRestTime)

	self._txtTime.text = string.format("剩余%s时间：%02d:%02d:%02d", isRestTime and "休战" or "战斗", hour, min, sec)
end

function ElementSparkMainView:_onClickMap()
	UIStateManager.instance:push(ViewName.ElementsparkmapView)
	self:_visibleTagop(false)
end

function ElementSparkMainView:_onClickTag()
	if ElementSparkController.instance:checkResultTime() then
		return
	end

	self._showTagAction = not self._showTagAction

	GameUtil.SetActive(self._tagAction, self._showTagAction)
end

function ElementSparkMainView:_onClickShop()
	GotoMgr.gotoByString(ElementSparkConfig.instance:getActivityCfgById(self._activityId).jumpTo)
end

function ElementSparkMainView:_onClickTask()
	UIStateManager.instance:push(ViewName.ElementSparkTaskMainView)
end

function ElementSparkMainView:_onClickTeam()
	if ElementSparkController.instance:checkResultTime() then
		return
	end

	UIStateManager.instance:push(ViewName.ElementSparkSetTeamView)
end

function ElementSparkMainView:_onClickInfo()
	UIStateManager.instance:push(ViewName.ElementSparkInfoView, 1)
end

function ElementSparkMainView:_onClickbtnRetreat(isUp)
	self:_onLongPressTag(isUp, GameEnum.ElementSparkTagType.Retreat)
end

function ElementSparkMainView:_onClickbtnAttack(isUp)
	self:_onLongPressTag(isUp, GameEnum.ElementSparkTagType.Attack)
end

function ElementSparkMainView:_onClickbtnDefend(isUp)
	self:_onLongPressTag(isUp, GameEnum.ElementSparkTagType.Defend)
end

function ElementSparkMainView:_onLongPressTag(isUp, tagType)
	if not self._isTouchedDown and isUp then
		self:_visibleTagop(false)

		return
	end

	if self._isTouchedDown and isUp then
		self:_onTouchUp()

		return
	end

	local isOk = self:_checkTagEnough()

	if not isOk then
		FloatWordMgr.instance:show("标记次数不足")

		return
	end

	local followCom = self._tagopGo:GetComponent(ComponentType.UIFollowTarget)

	followCom.enabled = false
	followCom.target = nil

	ElementSparkModel.instance:setTagMode(true)

	self._isTouchedDown = true
	self._tagType = tagType

	self:_initNodeInStartLongPressDrag()
end

function ElementSparkMainView:_initNodeInStartLongPressDrag()
	self:_onlyShowCurrSelectTag()
	self._tagOpBtnIconChange:SetState(self._tagType - 1)

	self._txtOpBtn.text = ConstString.ElementSparkTagTypeName[self._tagType]

	self:_onTouchMove()
	goutil.setActive(self._tagopGo, true)
end

function ElementSparkMainView:_onlyShowCurrSelectTag()
	goutil.setActive(self._btnTagReplace.gameObject, false)
	goutil.setActive(self._btnTagCancel.gameObject, false)
	goutil.setActive(self._tagOpActionGo, false)
	goutil.setActive(self._tagOpBtnIconChange.gameObject, true)
end

function ElementSparkMainView:_checkTagEnough()
	local use = ElementSparkModel.instance:getTagUseNum()
	local total = ElementSparkConfig.instance:getCommonCfgByKey("TAG_NUM", true)

	return use < total
end

function ElementSparkMainView:_update()
	if self._isTouchedDown then
		self:_onTouchMove()
	end
end

function ElementSparkMainView:_onDropTagIntoChunk(unit)
	self:_visibleTagop(false)

	local tagInfo = ElementSparkModel.instance:getTagInfo(unit.chunkId)

	if tagInfo and tagInfo.signId > 0 then
		FloatWordMgr.instance:show("当前地块已有标记")

		return
	end

	local planId = ElementSparkController.instance:getMapPlanId()
	local chunkCfg = ElementSparkConfig.instance:getMapChunkCfgById(planId, unit.chunkId)

	if chunkCfg.chunkType == GameEnum.ElementSparkChunkType.Blank then
		FloatWordMgr.instance:show("路障不可标记")

		return
	end

	ElementSparkController.instance:sendPM_EleSparkAddTagReq(self._activityId, unit.chunkId, self._tagType)
end

function ElementSparkMainView:_onClickbtnTagCancel()
	self:_visibleTagop(false)

	local followCom = self._tagopGo:GetComponent(ComponentType.UIFollowTarget)

	followCom.enabled = false
	followCom.target = nil

	ElementSparkController.instance:sendPM_EleSparkModifyTagReq(self._activityId, self._tagId, -1, self._chunkId)
end

function ElementSparkMainView:_onClickbtnTagReplace()
	goutil.setActive(self._tagOpActionGo, true)
end

function ElementSparkMainView:_onTouchUp()
	self._isTouchedDown = nil

	local cameraTarget = CameraTargetMgr.instance:getMainCameraTarget()

	if not cameraTarget then
		return
	end

	local mousePos = UGUIToolHelper.GetTouchPosition()
	local ray = cameraTarget:getCamera():ScreenPointToRay(mousePos)
	local isHit, hitResult = UnityEngine.Physics.Raycast(ray, nil)
	local parent

	if hitResult then
		local name = hitResult.collider.gameObject.name
		local idx = string.find(name, UnitTag.TilingSceneElem)

		if idx then
			local eleInsId = tonumber(string.sub(name, string.len(UnitTag.TilingSceneElem) + 2))

			ElementSparkSceneController.instance:onSelectUnitId(eleInsId)
			ElementSparkModel.instance:setTagMode(false)

			return
		end
	end

	self:_visibleTagop(false)
	ElementSparkModel.instance:setTagMode(false)
end

function ElementSparkMainView:_onTouchMove()
	local screenPos = UGUIToolHelper.GetTouchPosition()
	local pos = goutil.screenToLocalPos(screenPos, self._tagopGo.transform.parent.transform)

	Framework.TransformUtil.SetAnchoredPos(self._tagopGo.transform, pos.x, pos.y)
end

function ElementSparkMainView:_onClickbtnOpRetreat()
	self:_changeTagSign(GameEnum.ElementSparkTagType.Retreat)
end

function ElementSparkMainView:_onClickbtnOpDefend()
	self:_changeTagSign(GameEnum.ElementSparkTagType.Defend)
end

function ElementSparkMainView:_onClickbtnOpAttack()
	self:_changeTagSign(GameEnum.ElementSparkTagType.Attack)
end

function ElementSparkMainView:_changeTagSign(newSignId)
	self:_visibleTagop(false)
	ElementSparkController.instance:sendPM_EleSparkModifyTagReq(self._activityId, self._tagId, newSignId, self._chunkId)
end

function ElementSparkMainView:_onElementReplaceSparkTag(chunkId, insId, signId)
	self._tagId = ElementSparkController.instance:getTagId(chunkId, signId)
	self._chunkId = chunkId

	local unit = SceneMgr.instance:getCurScene().unitFactory:getUnit(UnitTag.TilingSceneElem, insId)

	if unit then
		local followCom = self._tagopGo:GetComponent(ComponentType.UIFollowTarget)

		followCom = followCom or self._tagopGo:AddComponent(ComponentType.UIFollowTarget)
		followCom.uiCamera = GlobalModel.instance.uiCamera
		followCom.gameCamera = GlobalModel.instance.mainCamera
		followCom.target = unit.go.transform
		followCom.canvas = GlobalModel.instance.uiCanvas
		followCom.enabled = true

		followCom:LateUpdate()
		self:_visibleTagop(true)
		self:_onlyShowOpBtn()
	end
end

function ElementSparkMainView:_onlyShowOpBtn()
	goutil.setActive(self._tagOpBtnIconChange.gameObject, false)
	goutil.setActive(self._tagOpActionGo, false)
	goutil.setActive(self._btnTagCancel.gameObject, true)
	goutil.setActive(self._btnTagReplace.gameObject, true)
end

function ElementSparkMainView:_visibleTagop(visible)
	if not visible then
		Framework.TransformUtil.SetLocalPos(self._tagopGo.transform, 10000, 0, 0)

		local followCom = self._tagopGo:GetComponent(ComponentType.UIFollowTarget)

		if followCom then
			followCom.enabled = false
			followCom.target = nil
		end
	end
end

function ElementSparkMainView:_onClickBtnChat()
	if FuncOpenController.instance:checkFuncIdOrShowLockTips(55) then
		UIStateManager.instance:push(ViewName.chat, GameEnum.ChatChannel.ElementSpark)
	end
end

function ElementSparkMainView:_playFirstGetInfo()
	local fristInBattle = ElementSparkController.instance:isFristInBattle()

	if not fristInBattle then
		return
	end

	local isIn = UIStateManager.instance:isInStack(ViewName.PopupImageRuleView)

	if isIn then
		self.addGEvent(self, GlobalNotify.OnViewClose, self._onPopeDistributeTip, self)
	else
		self:_openDistributeTip()
	end
end

function ElementSparkMainView:_openDistributeTip()
	if ElementSparkModel.instance:getStageType() ~= GameEnum.ElementSparkStageType.Battle then
		return
	end

	local campId = ElementSparkModel.instance:getMyCampId()

	if campId <= 0 then
		return
	end

	UIStateManager.instance:push(ViewName.ElementSparkDistributeTipView)
end

function ElementSparkMainView:_onClickClose()
	local sceneType = SceneMgr.instance:getCurSceneType()

	if sceneType ~= SceneType.ElementSpark then
		self:close()
	else
		ElementSparkSceneController.instance:levevScene()
	end
end

function ElementSparkMainView:_onClickTip()
	TipsFacade.instance:openRulesView("ElemenstSpark_rule")
end

return ElementSparkMainView
