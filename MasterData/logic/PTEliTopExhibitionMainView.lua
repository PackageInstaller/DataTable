-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/PTEliTopExhibitionMainView.lua

module("logic.extensions.peaktournament.view.eliminator.PTEliTopExhibitionMainView", package.seeall)

local PTEliTopExhibitionMainView = class("PTEliTopExhibitionMainView", ViewComponent)

PTEliTopExhibitionMainView.TabTypeAllServer = 1
PTEliTopExhibitionMainView.TabTypeZone = 2

function PTEliTopExhibitionMainView:buildUI()
	PTEliTopExhibitionMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._goldBarCon = goutil.findChild(self.mainGO, "goldBarCon")
	self._modelCam = goutil.findChild(self.mainGO, "modelCam")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "modelCam/bg/time/txt")
	self._roleCell = self:getGo("roleCol/roleCell")
	self._roleView = self:getGo("roleCol/roleView")

	GameUtil.SetActive(self._roleCell, false)

	self._txtBubbleDesc = goutil.findChildTextComponent(self.mainGO, "bubble/txtDesc")
	self._btnExchange = self:getGo("btnExchange")
	self._btnReward = self:getGo("btnReward")
	self._btnBanPet = self:getGo("btnBanPet")
	self._btnFameHall = self:getGo("btnFameHall")
	self._zoneBestPlayer = self:getGo("zoneBest/playerInfo/head")
	self._zoneBestName = self:getTxt("zoneBest/playerInfo/txtName")
	self._zoneBestEmpty = self:getGo("zoneBest/like/empty")
	self._zoneBestLike = self:getGo("zoneBest/like")
	self._btnLike = self:getBtn("zoneBest/like/btnLike")
	self._txtLike = self:getTxt("zoneBest/like/btnLike/Text")
	self._likeRedPoint = self:getGo("zoneBest/like/btnLike/redpoint")
	self._rewardView = self:getScrollRect("zoneBest/like/rewardview")
	self._itemNode = self:getGo("zoneBest/like/rewardview/Viewport/Content/ItemNode")
	self._itemNodeLayout = self._itemNode:GetComponent(ComponentType.UILayoutSingleLine)
	self._reward = self:getGo("zoneBest/like/reawrd")
	self._btnChangeTab = self:getGo("btnChangeTab")
	self._txtTab = self:getTxt("btnChangeTab/txt")
	self._imgSloganGlobal = self:getGo("imgSloganGlobal")
	self._imgSloganZone = self:getGo("imgSloganZone")
	self._imgMVPGlobal = self:getGo("zoneBest/playerInfo/mvpGlobal")
	self._imgMVPZone = self:getGo("zoneBest/playerInfo/mvpZone")
end

function PTEliTopExhibitionMainView:bindEvents()
	PTEliTopExhibitionMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnExchange, self._onClickExchange, self)
	GameUtil.addClickHandler(self._btnReward, self._onClickReward, self)
	GameUtil.addClickHandler(self._btnLike, self._onClickLike, self)
	GameUtil.addClickHandler(self._btnChangeTab, self._onClickChangeTab, self)
	GameUtil.addClickHandler(self._btnBanPet, self._onClickBanPet, self)
	GameUtil.addClickHandler(self._btnFameHall, self._onClickFameHall, self)
end

function PTEliTopExhibitionMainView:unbindEvents()
	PTEliTopExhibitionMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnExchange)
	GameUtil.rmClickHandler(self._btnReward)
	GameUtil.rmClickHandler(self._btnLike)
	GameUtil.rmClickHandler(self._btnChangeTab)
	GameUtil.rmClickHandler(self._btnBanPet)
	GameUtil.rmClickHandler(self._btnFameHall)
end

function PTEliTopExhibitionMainView:onEnter()
	PTEliTopExhibitionMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PeakTournamentKnockoutGetTopViewRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PeakTournamentKudosRes, self._onUpdateKudo, self)

	self._activityId = PeakTournamentController.instance:getCurActivityId()

	if self._activityId <= 0 then
		FloatWordMgr.instance:show(lang("不在活动时间内"))
		self:close()

		return
	end

	local key = PeakTournamentController.instance:getTopOnceRedKey(self._activityId)
	local redId = PeakTournamentConfig.instance:getPtCommonValue("PT_RED_TOP_FIRST")

	PeakTournamentController.instance:saveOnceRedAsPT(key, redId, true)
	RedPointController.instance:regRedPoint(self._likeRedPoint, RedPointModel.ID_PTELITOPEXHIBITIONKUDO)
	self:_setAvatarCameraEnv(true)
	PeakTournamentController.instance:sendPM_PeakTournamentKnockoutGetTopViewReq(self._activityId)

	local startTime, endTime = PeakTournamentController.instance:getStartAndEndTimeStrAsPT(self._activityId, GameEnum.PeakTournamentStep.TopExhibition)

	self._txtTime.text = string.format("结束时间：%s", GameUtil.getFormatTimeByStamp(nil, GameUtil.string2time(endTime)))

	local activityType = PeakTournamentController.instance:getCurActivityType()
	local startStamp, endStamp = ActivityDefineController.instance:getStartTimeAndEndTime(activityType, self._activityId)

	self._bubbleEndStamp = endStamp

	settimer(0.1, self._bubbleTicking, self)

	local goldBarList = PeakTournamentController.instance:getGoldBarList(self._activityId)

	if #goldBarList > 0 then
		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, goldBarList)
	end

	self._tabType = PTEliTopExhibitionMainView.TabTypeAllServer

	local isHave = PeakTournamentController.instance:isTheSeasonHaveBanPetVoteView(self._activityId)

	GameUtil.SetActive(self._btnBanPet, isHave)
end

function PTEliTopExhibitionMainView:onExit()
	PTEliTopExhibitionMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PeakTournamentKnockoutGetTopViewRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PeakTournamentKudosRes, self._onUpdateKudo, self)
	RedPointController.instance:unregRedPoint(RedPointModel.ID_PTELITOPEXHIBITIONKUDO)
	removetimer(self._bubbleTicking, self)
	self:_clearAvatarPool()
	self:_setAvatarCameraEnv(false)
	MaterialMgr.resetAll(self._itemNode)
	HeadItemController.instance:resetHeadCell(self._zoneBestPlayer)
end

function PTEliTopExhibitionMainView:destroyUI()
	PTEliTopExhibitionMainView.super.destroyUI(self)
end

function PTEliTopExhibitionMainView:_onUpdate()
	local views

	if self._tabType == PTEliTopExhibitionMainView.TabTypeZone then
		self._txtTab.text = lang("战区")
		views = PeakTournamentModel.instance:getZonePtKnockoutGetTopView().rankView

		GameUtil.SetActive(self._imgSloganGlobal, false)
		GameUtil.SetActive(self._imgSloganZone, true)
		GameUtil.SetActive(self._imgMVPGlobal, false)
		GameUtil.SetActive(self._imgMVPZone, true)
	else
		self._txtTab.text = lang("全服")
		views = PeakTournamentModel.instance:getGlobalPtKnockoutGetTopView().rankView

		GameUtil.SetActive(self._imgSloganZone, false)
		GameUtil.SetActive(self._imgSloganGlobal, true)
		GameUtil.SetActive(self._imgMVPZone, false)
		GameUtil.SetActive(self._imgMVPGlobal, true)
	end

	local dataList = {}

	for _, view in ipairs(views or {}) do
		dataList[view.rank] = view
	end

	for i = 1, 3 do
		if dataList[i] == nil then
			-- block empty
		end

		self:_updateOneTopRole(dataList[i] or {}, i)
	end

	self:_zoneBestShowInfo()
end

function PTEliTopExhibitionMainView:_updateOneTopRole(rankInfo, index)
	if self._roleGoList == nil then
		self._roleGoList = {}
	end

	local roleGo = self._roleGoList[index]

	if roleGo == nil then
		local parentGo = goutil.findChild(self._roleView, "pos_" .. index)

		roleGo = goutil.cloneAndSetParent(self._roleCell, parentGo.transform)
		self._roleGoList[index] = roleGo
	end

	GameUtil.SetActive(roleGo, true)

	local empty = goutil.findChild(roleGo, "empty")
	local txtOrder = goutil.findChildTextComponent(roleGo, "txtOrder")
	local txtName = goutil.findChildTextComponent(roleGo, "txtName")
	local txtPower = goutil.findChildTextComponent(roleGo, "txtPower")
	local rankimg = goutil.findChild(roleGo, "rankimg")
	local btn = goutil.findChild(roleGo, "btn")
	local avatarRoot = goutil.findChild(self._modelCam, "posList/pos_" .. index)

	GameUtil.rmClickHandler(btn)
	GameUtil.SetActive(rankimg, index <= 3)
	GameUtil.SetActive(txtOrder, index > 3)

	txtOrder.text = tostring(index)

	GameUtil.setUIImageSpriteIdx(rankimg, math.min(index - 1, 2))
	GameUtil.SetActive(empty, rankInfo == nil)

	if rankInfo then
		if rankInfo.gender and rankInfo.clothes then
			self:_showAvatar(avatarRoot, rankInfo.gender, rankInfo.clothes)
		end

		txtPower.text = tostring(rankInfo.zdl)

		local userName = "???"

		if rankInfo.headInfo then
			userName = rankInfo.headInfo.userName

			GameUtil.addClickHandler(btn, function()
				FriendController.instance:showInfoView(rankInfo.headInfo.userId, btn)
			end)
		end

		if rankInfo.areaId then
			userName = PeakTournamentController.instance:getFormatUserName(userName, rankInfo.areaId)
		end

		txtName.text = userName
	else
		self:_hideAvatar(avatarRoot)

		txtPower.text = "0"
		txtName.text = lang("虚位以待")
	end
end

function PTEliTopExhibitionMainView:_showAvatar(parentGo, gender, clothes)
	local avatar = self:_getAvatar(parentGo)

	avatar:updateByMo(self:_getAvatarMo(gender, clothes))
	GameUtil.SetActive(parentGo, true)
end

function PTEliTopExhibitionMainView:_hideAvatar(parentGo)
	GameUtil.SetActive(parentGo, false)
end

function PTEliTopExhibitionMainView:_getAvatar(parentGo)
	if self._avatarPool == nil then
		self._avatarPool = {}
	end

	if self._avatarPool[parentGo] then
		return self._avatarPool[parentGo]
	end

	local avatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)

	avatar.useType = AvatarUseType.Scene

	avatar:setParent(parentGo.transform)
	avatar:setLayer(SceneLayer.UI3D_Value)

	self._avatarPool[parentGo] = avatar

	return avatar
end

function PTEliTopExhibitionMainView:_getAvatarMo(gender, clothes)
	return DressModel.instance:getAvatarMoByGrCosAndMount(gender, clothes, nil)
end

function PTEliTopExhibitionMainView:_clearAvatarPool()
	if self._avatarPool then
		for _, avatar in pairs(self._avatarPool) do
			AvatarsMgrNew.instance:removeAvatar(avatar)
		end

		self._avatarPool = nil
	end
end

function PTEliTopExhibitionMainView:_setAvatarCameraEnv(isOnEnter)
	if isOnEnter then
		goutil.addChildToParent(self._modelCam)
		LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
	else
		goutil.addChildToParent(self._modelCam, self.mainGO)
		LightMgr.instance:setLightForNormalScene()
	end

	LightMgr.instance:setUseModelLight(isOnEnter)
	GlobalModel.instance:visibleSceneHUDs(not isOnEnter)
end

function PTEliTopExhibitionMainView:_bubbleTicking()
	self._timeLeftTemp = self._bubbleEndStamp - ServerTime.now()

	if self._timeLeftTemp > 0 then
		self._txtBubbleDesc.text = langPara("剩余时间：\n%s", GameUtil.FormatTimeSymbol(self._timeLeftTemp))
	else
		TipsFacade.instance:openTipWindowNoX("提示", "当前活动结束", function()
			self:close()
		end, "确定")
	end
end

function PTEliTopExhibitionMainView:_zoneBestShowInfo()
	local ptTopInfo
	local bestInfo = (self._tabType == PTEliTopExhibitionMainView.TabTypeZone and PeakTournamentModel.instance:getZonePtKnockoutGetTopView() or PeakTournamentModel.instance:getGlobalPtKnockoutGetTopView()).areaBestInfo

	self:_onUpdateKudo()

	if bestInfo then
		HeadItemController.instance:resetHeadCell(self._zoneBestPlayer)
		HeadItemController.instance:setHeadCellByInfo(self._zoneBestPlayer, bestInfo.headInfo, true)

		self._zoneBestName.text = bestInfo.headInfo.userName

		GameUtil.SetActive(self._rewardView, true)
		GameUtil.SetActive(self._zoneBestEmpty, false)

		local rank = bestInfo.rank
		local prizeCfg

		for id, cfg in ipairs(self._tabType == PTEliTopExhibitionMainView.TabTypeZone and PeakTournamentConfig.instance:getPtKudosPrizeCfg(self._activityId) or PeakTournamentConfig.instance:getPtSpaceKudosPrizeCfg(self._activityId)) do
			if rank <= cfg.rank then
				self:_updateRewardCell(cfg.prize)

				return
			end
		end
	else
		self._zoneBestName.text = lang("无人上榜")

		HeadItemController.instance:resetHeadCell(self._zoneBestPlayer)
		GameUtil.SetActive(self._rewardView, false)
		GameUtil.SetActive(self._zoneBestEmpty, true)
	end
end

function PTEliTopExhibitionMainView:_onUpdateKudo()
	local state = self:_likeState()

	if state == 3 then
		self._txtLike.text = "点赞"

		uGuiUtil.setImageGrayStateRecursive(self._btnLike, false)
	else
		uGuiUtil.setImageGrayStateRecursive(self._btnLike, true)

		self._txtLike.text = "已点赞"
	end
end

function PTEliTopExhibitionMainView:_likeState()
	local ptTopInfo = self._tabType == PTEliTopExhibitionMainView.TabTypeZone and PeakTournamentModel.instance:getZonePtKnockoutGetTopView() or PeakTournamentModel.instance:getGlobalPtKnockoutGetTopView()
	local likedTotalCount = ptTopInfo.totalKudisTimes
	local likedDailyCount = ptTopInfo.dailyKudosTimes
	local dailyLikeCount = 0
	local totalLikeCount = 0

	if self._tabType == PTEliTopExhibitionMainView.TabTypeZone then
		dailyLikeCount = PeakTournamentConfig.instance:getPtCommonValue("DAILY_KUDOS_COUNT")
		totalLikeCount = PeakTournamentConfig.instance:getPtCommonValue("TOTAL_KUDOS_COUNT")
	else
		dailyLikeCount = PeakTournamentConfig.instance:getPtCommonValue("DAILY_GLOBAL_KUDOS_COUNT")
		totalLikeCount = PeakTournamentConfig.instance:getPtCommonValue("TOTAL_GLOBAL_KUDOS_COUNT")
	end

	if checknumber(likedTotalCount) >= checknumber(totalLikeCount) then
		return 1
	elseif checknumber(likedDailyCount) >= checknumber(dailyLikeCount) then
		return 2
	end

	if ptTopInfo.areaBestInfo then
		return 3
	else
		return 4
	end
end

function PTEliTopExhibitionMainView:_updateRewardCell(cfg)
	local itemArr = string.split(cfg, "#")
	local contentSize = #itemArr * 80

	GameUtil.setWidth(self._rewardView.scrollRect.content, contentSize)

	self._rewardView.scrollRect.horizontalNormalizedPosition = 0

	for _, item in ipairs(itemArr) do
		MaterialMgr.resetAll(self._itemNode)
		MaterialMgr.setCellByCfg(item, self._itemNode, nil, nil, false)
	end

	self._itemNodeLayout:Layout()
end

function PTEliTopExhibitionMainView:_onClickExchange()
	local jumpToStr = PeakTournamentConfig.instance:getPtCommonValue("PT_JUMP_SHOP_KEY")

	if not string.nilorempty(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

function PTEliTopExhibitionMainView:_onClickReward()
	local jumpToStr = PeakTournamentConfig.instance:getPtCommonValue("PT_JUMP_REDPACKET_KEY")

	if not string.nilorempty(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

function PTEliTopExhibitionMainView:_onClickBtnTip()
	local ruleKey = PeakTournamentConfig.instance:getPtCommonValue("PT_SHOW_RULE") or ""

	TipsFacade.instance:openRulesView(ruleKey)
end

function PTEliTopExhibitionMainView:_onClickLike()
	local state = self:_likeState()

	if state == 3 then
		if self._tabType == PTEliTopExhibitionMainView.TabTypeZone then
			PeakTournamentController.instance:sendPM_PeakTournamentKudosReq(self._activityId, false)
		else
			PeakTournamentController.instance:sendPM_PeakTournamentKudosReq(self._activityId, true)
		end
	elseif state == 4 then
		FloatWordMgr.instance:show("无人上榜")
	else
		FloatWordMgr.instance:show("点赞次数已用完")
	end
end

function PTEliTopExhibitionMainView:_onClickChangeTab()
	self._tabType = self._tabType == PTEliTopExhibitionMainView.TabTypeZone and PTEliTopExhibitionMainView.TabTypeAllServer or PTEliTopExhibitionMainView.TabTypeZone

	self:_onUpdate()
end

function PTEliTopExhibitionMainView:_onClickBanPet()
	UIStateManager.instance:push(ViewName.PTEliBanPetView, self._activityId)
end

function PTEliTopExhibitionMainView:_onClickFameHall()
	GotoMgr.gotoByString("func#1137#3")
end

return PTEliTopExhibitionMainView
