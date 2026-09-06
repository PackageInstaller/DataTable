-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nvdi/view/NvdimainView.lua

module("logic.extensions.nvdi.view.NvdimainView", package.seeall)

local NvdimainView = class("NvdimainView", ViewComponent)

function NvdimainView:buildUI()
	NvdimainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnIntroduce")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._con = goutil.findChild(self.mainGO, "con")
	self._jumpBtnCol = goutil.findChild(self.mainGO, "jumpBtnCol")
	self._jumpBtnCol_btnJump1 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1")
	self._jumpBtnCol_btnJump1_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1/redPoint")
	self._jumpBtnCol_btnJump2 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2")
	self._jumpBtnCol_btnJump2_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2/redPoint")
	self._jumpBtnCol_btnJump3 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3")
	self._jumpBtnCol_btnJump3_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3/redPoint")
	self._clgBtnCol = goutil.findChild(self.mainGO, "clgBtnCol")
	self._clgBtnCol_btnClg1 = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1")
	self._clgBtnCol_btnClg1_btn = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/btn")
	self._clgBtnCol_btnClg1_redPoint = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/btn/redPoint")
	self._clgBtnCol_btnClg1_imgPass = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/btn/imgPass")
	self._clgBtnCol_btnClg1_bubble = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/bubble")
	self._clgBtnCol_btnClg1_bubble_itemcell = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/bubble/itemcell")
	self._clgBtnCol_btnClg1_bubble_imgHasGain = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/bubble/imgHasGain")
	self._clgBtnCol_btnClg1_bubble_txt = goutil.findChildTextComponent(self.mainGO, "clgBtnCol/btnClg1/bubble/txt")
	self._clgBtnCol_btnClg2 = goutil.findChild(self.mainGO, "clgBtnCol/btnClg2")
	self._clgBtnCol_btnClg2_btn = goutil.findChild(self.mainGO, "clgBtnCol/btnClg2/btn")
	self._clgBtnCol_btnClg2_redPoint = goutil.findChild(self.mainGO, "clgBtnCol/btnClg2/btn/redPoint")
	self._clgBtnCol_btnClg2_imgPass = goutil.findChild(self.mainGO, "clgBtnCol/btnClg2/btn/imgPass")
	self._effectGo1 = self:getGo("clgBtnCol/btnClg1/bubble/effect")

	self:_recordGoDefaultActive(self._jumpBtnCol)
	self:_recordGoDefaultActive(self._clgBtnCol_btnClg2)
	self:_recordGoDefaultActive(self._clgBtnCol_btnClg1_bubble)
end

function NvdimainView:_recordGoDefaultActive(go)
	self._goDefaultActives = self._goDefaultActives or {}
	self._goDefaultActives[go] = GameUtil.GetActive(go)
end

function NvdimainView:_isActiveInDefault(go)
	self._goDefaultActives = self._goDefaultActives or {}

	return self._goDefaultActives[go]
end

function NvdimainView:_refreshDefaultActive(go)
	GameUtil.SetActive(go, self:_isActiveInDefault(go))
end

function NvdimainView:bindEvents()
	NvdimainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))
	GameUtil.addClickHandler(self._clgBtnCol_btnClg1_btn, self._onClickBtnClg1, self)
	GameUtil.addClickHandler(self._clgBtnCol_btnClg2_btn, self._onClickBtnClg2, self)
end

function NvdimainView:unbindEvents()
	NvdimainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump3)
	GameUtil.rmClickHandler(self._clgBtnCol_btnClg1_btn)
	GameUtil.rmClickHandler(self._clgBtnCol_btnClg2_btn)
end

function NvdimainView:onExit()
	NvdimainView.super.onExit(self)
	RoleObjectPool.instance:removeRole(self._role)

	self._role = nil

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._clgBtnCol_btnClg1_bubble_itemcell)

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end
end

function NvdimainView:onEnter()
	NvdimainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = NvdiChallengeController.instance:getActivityId()
	end

	self._activityType = NvdiChallengeController.instance:getActivityType()

	local isInTime = NvdiChallengeController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._actCfg = NvdiChallengeConfig.instance:getActivityCfgById(self._activityId) or {}

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.NVDI_CHALLENGE_INFO_UPDATE, self._onUpdateUI, self)
	NvdiChallengeController.instance:sendGetInfo(self._activityId)
end

function NvdimainView:_onSetUI()
	if self._isAoqiGodProcessType then
		GameUtil.SetActive(self._jumpBtnCol, false)
		GameUtil.SetActive(self._clgBtnCol_btnClg2, false)
		GameUtil.SetActive(self._clgBtnCol_btnClg1_bubble, false)
	else
		self:_refreshDefaultActive(self._jumpBtnCol)
		self:_refreshDefaultActive(self._clgBtnCol_btnClg2)
		self:_refreshDefaultActive(self._clgBtnCol_btnClg1_bubble)
	end

	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)

	self:_updateExtBubble()
end

function NvdimainView:_onUpdateUI()
	self._info = NvdiChallengeModel.instance:getInfo(self._activityId) or {}

	if not self._info.normalClgProgressPrizeGainedBitId then
		local prizeList = {}
		local isPassExt = NvdiChallengeModel.instance:isPassAllOfExtStage(self._activityId)
		local isPassNor = NvdiChallengeModel.instance:hasGainAllNormalClgPrize(self._activityId)
		local isGetExt = checkbool(self._info.hasGainExtremeClgPrize)

		GameUtil.SetActive(self._clgBtnCol_btnClg1_imgPass, isPassExt)
		GameUtil.SetActive(self._clgBtnCol_btnClg1_bubble_imgHasGain, isGetExt)
		GameUtil.SetActive(self._clgBtnCol_btnClg2_imgPass, isPassNor)

		local isCanGetNor = false
		local progressCfgs = NvdiChallengeConfig.instance:getProgressCfgById(self._activityId) or {}

		for i, v in ipairs(progressCfgs) do
			if self._info.normalClgProgress >= v.progress and table.indexof(prizeList, v.dataBitId) == false then
				isCanGetNor = true

				break
			end
		end

		GameUtil.SetActive(self._clgBtnCol_btnClg1_redPoint, isPassExt and not isGetExt)
		GameUtil.SetActive(self._clgBtnCol_btnClg2_redPoint, not isPassNor and isCanGetNor)
		self:_updateExtBubble()
	end
end

function NvdimainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function NvdimainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function NvdimainView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self._actCfg.skinId)
end

function NvdimainView:_getSkinId()
	return checknumber(self._actCfg.skinId)
end

function NvdimainView:_onClickBtnJump(key)
	if self._isAoqiGodProcessType then
		return
	end

	local jumpToStr = self._actCfg[key]

	GotoMgr.gotoByString(jumpToStr)
end

function NvdimainView:_onClickBtnClg1()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	local isPassExt = NvdiChallengeModel.instance:isPassAllOfExtStage(self._activityId)

	if isPassExt then
		TipsFacade.instance:openCommonTips("已经全部通关~")
	else
		UIStateManager.instance:push(ViewName.NvdichallengemaxView, self._activityId)
	end
end

function NvdimainView:_onClickBtnClg2()
	if self._isAoqiGodProcessType then
		return
	end

	local isPassNor = NvdiChallengeModel.instance:hasGainAllNormalClgPrize(self._activityId)

	if isPassNor then
		TipsFacade.instance:openCommonTips("已经全部通关")
	else
		UIStateManager.instance:push(ViewName.NvdichallengenormalView, self._activityId)
	end
end

function NvdimainView:_onClickBtnTip()
	local key = self._actCfg.mainRuleKey

	TipsFacade.instance:openRulesView(key)
end

function NvdimainView:_updateExtBubble()
	local proxy = MaterialMgr.setCellByCfg(self._actCfg.extremeClgPrize, self._clgBtnCol_btnClg1_bubble_itemcell)
	local matName = MaterialMgr.getMaterialsNameByCfg(self._actCfg.extremeClgPrize)

	self._clgBtnCol_btnClg1_bubble_txt.text = string.format("通关获得%s", matName)

	local isGainExt = NvdiChallengeModel.instance:isHasGainExtremeClgPrize(self._activityId)
	local isCanGain = not isGainExt and NvdiChallengeModel.instance:isPassAllOfExtStage(self._activityId)

	proxy.binder:setAutoTips(not isCanGain)

	if isCanGain then
		proxy.binder:setCallBack(function()
			NvdiChallengeController.instance:sendGetExtPrize(self._activityId)
		end)
	else
		proxy.binder:setCallBack(nil)
	end

	goutil.setActive(self._effectGo1, isCanGain)

	if isCanGain then
		self:_playExtPrizeEffect()
	end
end

function NvdimainView:_playExtPrizeEffect()
	if self._effectHandler then
		return
	end

	local effName = "fx_ui_tequan/fx_ui_tequan_kuang.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo1.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1.4)
end

return NvdimainView
