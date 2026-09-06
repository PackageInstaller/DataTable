-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/view/item/ItemChatNormal.lua

module("logic.extensions.chat.view.item.ItemChatNormal", package.seeall)

local ItemChatNormal = class("ItemChatNormal")
local anchorLB = Vector2.New(0, 0)
local anchorRB = Vector2.New(1, 0)
local anchorLU = Vector2.New(0, 1)
local anchorRU = Vector2.New(1, 1)

function ItemChatNormal:ctor(target, tag)
	self._target = target
	self._spriteAnim = {}
	self._lastClickTimeMs = 0
	self._doubleClickInterval = 0.25

	self:buildUIWithTag(tag)
end

function ItemChatNormal:setEffectClip(view, clipping)
	self._view = view
	self._clipping = clipping
end

function ItemChatNormal:buildUIWithTag(tag)
	self._tag = tag

	if tag == 1 then
		self:_buildHeadIcon()
		self:_buildTextContent()
	elseif tag == 2 then
		self:_buildHeadIcon()
		self:_buildTextContent()
	elseif tag == 6 then
		self:_buildHeadIcon()
		self:_buildTextContent()
	elseif tag == 3 then
		self:_buildTextContent()
	end
end

function ItemChatNormal:_buildTextContent()
	self._btnMsgGo = goutil.findChild(self._target, "container/ImgC_ContentBg")
	self._txtEffect = goutil.findChild(self._target, "container/effect")

	if self._btnMsgGo then
		GameUtil.addClickHandler(self._btnMsgGo, self._onClickMsg, self)

		self._TxtC_Content = goutil.findChildTextComponent(self._btnMsgGo, "TxtC_Content")
		self._graphic = self._btnMsgGo:GetComponent(typeof(UnityEngine.UI.Graphic))
		self._uiChangeGroup = self._btnMsgGo:GetComponent(typeof(UIChangeGroup))
		self._contentSizeFitter = self._btnMsgGo:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter))
		self._rectTrans = self._btnMsgGo:GetComponent(typeof(UnityEngine.RectTransform))
		self._layoutGroup = self._btnMsgGo:GetComponent(typeof(UnityEngine.UI.LayoutGroup))

		local padding = self._layoutGroup.padding

		if self._layoutGroup then
			self._horizontalOffset = padding.left + padding.right or 0
		end
	else
		printError("取到self._btnMsgGo为空")
	end

	self._image00 = goutil.findChild(self._target, "container/ImgC_ContentBg/image00")
	self._image01 = goutil.findChild(self._target, "container/ImgC_ContentBg/image01")
	self._image10 = goutil.findChild(self._target, "container/ImgC_ContentBg/image10")
	self._image11 = goutil.findChild(self._target, "container/ImgC_ContentBg/image11")
	self._imageEffect00 = goutil.findChild(self._target, "container/ImgC_ContentBg/imageEffect00")
	self._imageEffect01 = goutil.findChild(self._target, "container/ImgC_ContentBg/imageEffect01")
	self._imageEffect10 = goutil.findChild(self._target, "container/ImgC_ContentBg/imageEffect10")
	self._imageEffect11 = goutil.findChild(self._target, "container/ImgC_ContentBg/imageEffect11")
	self._bubbleGo = goutil.findChild(self._target, "bubble")

	if self._bubbleGo then
		self._btnCopy = Framework.ButtonAdapter.GetFrom(self._target, "bubble/btnCopy")

		self._btnCopy:AddClickListener(self._onClickBtnCopy, self)

		self._customInput = UICustomInput.Get(self._bubbleGo)

		self._customInput:AddListener(self._onCustomInputCallback, self)

		self._longPress = goutil.findChild(self._target, "container/ImgC_ContentBg"):GetComponent(ComponentType.UILongPressed)

		self._longPress:AddListener(self._onLongPressCopy, self)
	end
end

function ItemChatNormal:_buildHeadIcon()
	self._TxtC_Name = goutil.findChildTextComponent(self._target, "TxtC_Name")
	self._returnGo = goutil.findChild(self._target, "Nego_Icon/returnGo")
	self.headIcon = goutil.findChild(self._target, "Nego_Icon/ImgC_Icon")
	self._btnIcon = Framework.ButtonAdapter.GetFrom(self._target, "Nego_Icon")

	if self._btnIcon then
		self._btnIcon:AddClickListener(self._onClickIcon, self)
	end

	self.areaGo = goutil.findChild(self._target, "TxtC_Name/area")
	self.txtAarea = goutil.findChildTextComponent(self._target, "TxtC_Name/area/txt")
end

function ItemChatNormal:_onClickMsg()
	if not self._mo:isSystemMsg() then
		local nowMs = UnityEngine.Time.realtimeSinceStartup * 1000

		if nowMs - self._lastClickTimeMs <= self._doubleClickInterval * 1000 then
			self._lastClickTimeMs = 0

			removetimer(self._onSingleClickMsg, self)
			self:_onDoubleClickMsg()

			return
		end

		self._lastClickTimeMs = nowMs

		settimer(self._doubleClickInterval, self._onSingleClickMsg, self, false)
	else
		self:_onSingleClickMsg()
	end
end

function ItemChatNormal:_onDoubleClickMsg()
	if self._mo:isSystemMsg() then
		return
	end

	if self._TxtC_Content then
		local txt = self._txtContent

		if not string.nilorempty(txt) then
			local res = Clipboard.copy(txt)

			if res then
				local str = string.format("您已成功复制:%s", txt)

				FloatWordMgr.instance:show(str)
			end
		end
	end
end

function ItemChatNormal:_onSingleClickMsg()
	local tpId = self._mo:getTpId()
	local petId = self._mo:getParam("petId")
	local legendClgId = self._mo:getParam("legendClgId")
	local tabId = self._mo:getParam("tabId")
	local senderId = self._mo._senderId
	local sof = self._mo:getParam("sof", false)
	local bossId = self._mo:getParam("bossId")
	local userId = self._mo:getParam("userId")
	local recordId = self._mo:getParam("recordId")
	local FTPTag = self._mo:getParam("FTP")
	local zoo = self._mo:getParam("Zoo")
	local taskId = self._mo:getParam("taskId")
	local familyId = self._mo:getParam("familyId")
	local chunkPlanId = self._mo:getParam("chunkPlanId")
	local chunkId = self._mo:getParam("chunkId")

	if ViewMgr.instance:isOpen(ViewName.PkroomView) and tpId ~= 63 then
		FloatWordMgr.instance:show("当前在房间内,无法查看消息")

		return
	end

	if BattleController.instance:isBattling() then
		FloatWordMgr.instance:show("战斗中，不能跳转")

		return
	end

	if tpId == 33 then
		local winTimes = self._mo:getParam("winTimes")
		local score = self._mo:getParam("score")
		local winState = self._mo:getParam("winState")
		local iconType = self._mo:getParam("iconType")
		local userName = self._mo:getParam("userName", false)

		FirePowerContestController.instance:showResultView({
			isShare = true,
			winTimes = winTimes,
			score = score,
			winState = winState,
			iconType = iconType,
			userName = userName,
			userId = senderId
		})
	elseif tpId == 43 then
		local battleId = self._mo:getParam("battleId", false)

		BountyPKCompeteController.instance:replayFight(battleId, 2)
	elseif tpId == 46 then
		local activityId = BirthdayWishesController.instance:getActivityId()

		if activityId > 0 then
			local gotoStr = BirthdayWishesConfig.instance:getGotoStr(activityId) or ""

			GotoMgr.gotoByString(BirthdayWishesConfig.instance:getGotoStr(activityId))
		end
	elseif tpId == 48 then
		FamilyController.instance:openFamilyRedpackPopup(self._mo:getParam("redpackId"))
	elseif tpId == 51 then
		UIStateManager.instance:push(ViewName.RomanticGiftsView)
	elseif tpId == 52 then
		-- block empty
	elseif tpId == 53 or tpId == 54 or tpId == 55 or tpId == 56 then
		UIStateManager.instance:push(ViewName.GroupRedpackGrabView)
	elseif tpId == 58 then
		local goodsId = self._mo:getParam("goodsId")
		local reduceUserId = self._mo:getParam("reduceUserId")

		if checknumber(RoleModel.instance:getUserId()) == reduceUserId then
			UIStateManager.instance:push(ViewName.BargainView)
		else
			UIStateManager.instance:open(ViewName.BargainRedpackView, goodsId, reduceUserId)
		end
	elseif tpId == 59 then
		local masterUniqueId = self._mo:getParam("masterUniqueId")

		if self._mo:getIsMe() then
			UIStateManager.instance:push(ViewName.GuardCityMainView)
		else
			UIJumper.instance:pushOneStack(ViewName.GuardCityMainView, true)
			UIStateManager.instance:push(ViewName.GuardCityHelpView, true, checknumber(self._mo:getSenderId()), checknumber(masterUniqueId))
		end
	elseif tpId == 60 then
		local actId = self._mo:getParam("gtactId")
		local code = self._mo:getParam("code", false)

		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.GoldendTen, actId) then
			UIStateManager.instance:push(ViewName.GoldendTenMainView, actId, code)
		end
	elseif tpId == 62 then
		UIStateManager.instance:push(ViewName.LotusbattlerankresultshareView, self._mo)
	elseif tpId == 63 then
		local teamId = self._mo:getParam("teamId", false)
		local teamCode = self._mo:getParam("teamCode", false)

		TraincampqiecuoController.instance:tryJoinRoom(teamId, teamCode)
	elseif tpId == 64 then
		local periodId = self._mo:getParam("periodId")
		local viewType = self._mo:getParam("viewType")
		local fmtId = self._mo:getParam("fmtId")

		MasterFormController.instance:openMasterFormViewByFmtId(periodId, viewType, fmtId)
	elseif tpId == 65 then
		local activityId = self._mo:getParam("activityId", true)
		local teamId = self._mo:getParam("teamId", true)
		local teamScore = self._mo:getParam("teamScore", true)
		local teamName = self._mo:getParam("teamName", false)
		local number = self._mo:getParam("number", true)
		local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId)
		local isCaptain = checknumber(RoleModel.instance:getUserId()) == teamId

		if not isInTime then
			FloatWordMgr.instance:show("活动已过期~")

			return
		end

		WeeklyGroupController.instance:sendGetInfoRes()

		local func = function()
			local isInTeam = WeeklyGroupController.instance:isInTeam(teamId)

			if isCaptain or isInTeam then
				FloatWordMgr.instance:show("您已入队~")
				UIStateManager.instance:open(ViewName.WeeklyGroupMainView)

				return
			else
				local tips = string.format("您当前即将加入的<color=#eb4642>%s</color>的队伍\n总积分为<color=#eb4642>%d</color>,当前还有<color=#eb4642>%d</color>个空位\n是否确认加入？", teamName, teamScore, number)

				local function sureChange()
					WeeklyGroupController.instance:sendPM_WeeklyGroupJoinTeamReq(activityId, teamId)
					UIStateManager.instance:open(ViewName.WeeklyGroupMainView)
				end

				TipsFacade.instance:openTipWindow(lang("text_tong_tips"), tips, sureChange, "确定", UnityEngine.TextAnchor.MiddleCenter)
			end

			removetimer(func, self)
		end

		settimer(0.3, func, self, false)
	elseif tpId == 66 then
		SeasonController.instance:sendAddTeamByChatMsg(self._mo:getSenderId())
	elseif tpId == 68 then
		local activityId = self._mo:getParam("activityId", true)

		if not self._mo:getIsMe() then
			GiftBoxController.instance:handleGainLuckByChat(activityId, self._mo:getSenderId())
		end
	elseif tpId == 76 then
		local teamId = self._mo:getParam("teamId", true)
		local groupId = self._mo:getParam("groupId", true)
		local teamCode = self._mo:getParam("teamCode", false)

		if not self._mo:getIsMe() then
			FormTeamController.instance:getJoinTeamByChat(teamId, groupId, teamCode)
		end
	elseif tpId == 95 then
		local goodsId = self._mo:getParam("goodsId")
		local reduceUserId = self._mo:getParam("reduceUserId")
		local activityId = self._mo:getParam("activityId")

		if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
			FloatWordMgr.instance:show("活动已过期~")

			return
		end

		if checknumber(RoleModel.instance:getUserId()) == checknumber(reduceUserId) then
			UIStateManager.instance:push(ViewName.PinDaoDaoView, activityId)
		else
			UIStateManager.instance:open(ViewName.PinDaoDaoRedpackView, activityId, goodsId, reduceUserId)
		end
	elseif petId > 0 then
		ChatAgent.instance:sendPM_GetOtherUserPetReq(senderId, sof, function(msg)
			local petMo = BagPetMo.New()

			petMo:initBaseView(msg.petView)

			if PetskinController.instance:isClientNotShowIfNotForever(petMo.curFaceId) then
				petMo.curFaceId = petMo.raceId
				petMo.name = MaterialMgr.getMaterialsName(MatType.Pet, petMo.raceId)
			end

			UIStateManager.instance:open(ViewName.PetDetail, petMo)
		end)
	elseif legendClgId > 0 then
		local cfg = LegendConfig.instance:getLegendChallengeCfg(legendClgId)

		UIStateManager.instance:open(ViewName.PetIntroductionView, cfg.raceId)
	elseif tabId > 0 then
		ChatAgent.instance:sendPM_GetOtherUserFormReq(senderId, sof, function(msg)
			ArenaModel.instance:setOtherPlayerForm(msg.form)
			UIStateManager.instance:open(ViewName.ArenaDefFmtView, 1, "xx阵型", 0, true)
		end)
	elseif bossId > 0 then
		if SceneMgr.instance.isGogingToEnterBattleScene then
			FloatWordMgr.instance:show("该状态不可进行此操作!")

			return
		end

		local openId = ShareTaskConfig.instance:GetFuncOpenId()

		if not FuncOpenController:checkFuncIdOrShowLockTips(openId) then
			return
		end

		if ShareTaskModel.instance:IsHelpFriendChallBossId(bossId) then
			FloatWordMgr.instance:show("此怪物您已助战过!")

			return
		end

		local userName = self._mo:getSenderName()

		ShareTaskController.instance:CSGetOtherBossInfoReq(bossId, ViewName.BossProgress, userName)
	elseif userId > 0 and recordId > 0 then
		if NewChatController.instance:GetIsOnBattle() then
			FloatWordMgr.instance:show("您正在战斗中，不可以打开他人分享的切磋战报哟~")

			return
		end

		local myHeadInfo = {
			userName = self._mo:getSenderName(),
			headIconId = self._mo:getHeadIconId(),
			headFrameId = self._mo:getHeadFrameId(),
			vipLv = self._mo.vipLv
		}

		TraincampqiecuoModel.instance:setTempLeftHeadInfo(myHeadInfo)
		TrainCampQieCuoAgent.instance:sendPM_TC_GetShareBattleResultReq(userId, recordId)
	elseif FTPTag > 0 then
		local fId = self._mo:getParam("FID")
		local periodId = self._mo:getParam("PID")
		local bossId = self._mo:getParam("BID")
		local tpType = self._mo:getParam("TPT")

		FamilyController.instance:getMyFamilyInfoReq(function()
			FamilyteamplayController.instance:clickChatItemOpenView(fId, periodId, bossId, tpType)
		end, nil)
	elseif zoo > 0 then
		ZooController.instance:sendPM_ZooShowSharedAnimalReq(senderId, self._mo:getParam("id"))
	elseif taskId > 0 then
		local userId = self._mo:getSenderId()

		if userId == RoleModel.instance:getUserId() then
			UIStateManager.instance:push(ViewName.RecallInvite, {
				taskId = taskId
			}, true)

			return
		end

		if not RecallTaskModel.instance:isCanReceiveRecallTask(taskId, userId, true) then
			return
		end

		RecallTaskController.instance:csGetTaskInviteInfoReq(userId, taskId, true)
	elseif familyId > 0 then
		FamilyHonorController.instance:openFamilyMedalgetChatMedals(familyId, self._mo:getParam("sof", false))
	elseif chunkPlanId > 0 and chunkId > 0 then
		local isIn = ElementSparkSceneController.instance:isInScene()

		if not isIn then
			FloatWordMgr.instance:show("进入龙蛋争夺战活动才能跳转到该坐标")

			return
		end

		if SceneMgr.instance.isGogingToEnterBattleScene then
			FloatWordMgr.instance:show("战斗中，无法跳转")

			return
		end

		UIStateManager.instance:popByName(ViewName.chat)
		ElementSparkSceneController.instance:moveChunkToCenterAndLocation(chunkId)
	elseif tpId >= 69 and tpId <= 73 then
		local fId = self._mo:getParam("fid")
		local fn = self._mo:getParam("fn", false)

		FamilyController.instance:sendSearchFamilyReq(fn, fId, true, true)
	elseif tpId == 74 then
		local obj = {
			activityId = self._mo:getParam("a"),
			teamId = self._mo:getParam("t"),
			inviteCode = self._mo:getParam("c", false),
			minPlayerLevel = self._mo:getParam("pl"),
			maxPlayerLevel = self._mo:getParam("pr"),
			petNum = self._mo:getParam("o")
		}

		ShowDownController.instance:joinTeamFromChat(obj)
	elseif tpId == 77 then
		local activityId = self._mo:getParam("activityId", true)
		local targetUserId = self._mo:getParam("targetUserId")
		local id = self._mo:getParam("id")

		AoqiGodController.instance:popHelpItemWin(activityId, targetUserId, id)
	elseif tpId == 79 or tpId == 81 or tpId == 82 or tpId == 83 or tpId == 84 then
		local activityId = self._mo:getParam("aid", true)
		local defineId = self._mo:getParam("did", true)
		local redPackId = self._mo:getParam("rid", true)
		local faceId = self._mo:getParam("gf", true)

		UIStateManager.instance:push(ViewName.GoddessCompetitionRedpackPopupView, activityId, defineId, redPackId, faceId)
	elseif tpId == 80 then
		local activityId = self._mo:getParam("activityId", true)
		local inviteCode = self._mo:getParam("inviteCode", false)

		SaintKnightRegressController.instance:openInviteView(activityId, inviteCode)
	elseif tpId == 85 then
		local activityId = self._mo:getParam("activityId", true)
		local shareCode = self._mo:getParam("shareCode", false)
		local sendChatTime = self._mo:getParam("sendChatTime", true)
		local intervalDay = GameUtil.getDaysByTimestamp(sendChatTime, ServerTime.now()) - 1

		if intervalDay <= 0 then
			local isFriend = true

			UIStateManager.instance:push(ViewName.AnniversaryMarketSoldView, activityId, isFriend, shareCode)
		else
			FloatWordMgr.instance:show("集市码已过期")
		end
	elseif tpId == 86 then
		local activityId = self._mo:getParam("activityId", true)
		local otherUserId = self._mo:getParam("otherUserId", true)
		local positionId = self._mo:getParam("positionId", true)
		local helpId = self._mo:getParam("helpId", true)

		LuyngardeController.instance:getChapter3ExploreHelpInfo(activityId, otherUserId, positionId, helpId)
	elseif tpId == 87 then
		local activityId = self._mo:getParam("activityId", true)
		local matchKey = self._mo:getParam("matchKey", true)
		local targetToyId = self._mo:getParam("targetToyId", true)

		TianYanMatchController.instance:matchFromBuddy(activityId, self._mo:getSenderId(), matchKey, targetToyId)
	elseif tpId == 88 then
		local activityId = self._mo:getParam("activityId", true)

		TianYanMatchController.instance:jumpToActivityView(activityId)
	elseif tpId == 89 then
		local activityId = self._mo:getParam("activityId", true)
		local otherUserId = self._mo:getParam("otherUserId", true)
		local positionId = self._mo:getParam("positionId", true)
		local helpId = self._mo:getParam("helpId", true)

		LiYangKingController.instance:getChapter3ExploreHelpInfo(activityId, otherUserId, positionId, helpId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.ON_CLICK_ITEM_CHAT, tpId, self._mo)
end

function ItemChatNormal:SetActive(isActive)
	self._target:SetActive(isActive)
end

function ItemChatNormal:Refresh(data, viewName, timer)
	removetimer(self._onSingleClickMsg, self)

	self._lastClickTimeMs = 0

	self:SetActive(true)

	self._mo = data

	local isMe = self._mo:getIsMe()
	local content = data:getContent()
	local bubbleId = 1

	GameUtil.SetActive(self.areaGo, false)
	goutil.setActive(self._bubbleGo, false)

	if isMe then
		-- block empty
	elseif not string.nilorempty(data.areaName) then
		GameUtil.SetActive(self.areaGo, true)

		self.txtAarea.text = data.areaName
	end

	local chatColorCfgs = ChatConfig.instance:getChatColorCfgs()

	for _, v in ipairs(chatColorCfgs) do
		local replaceColor

		if viewName == ViewName.chat then
			replaceColor = isMe and v.chatMyColor or v.chatOtherColor
		elseif viewName == ViewName.Friend then
			replaceColor = isMe and v.friendMyColor or v.friendOtherColor
		end

		if not string.nilorempty(replaceColor) then
			content = string.gsub(content, v.mainColor, replaceColor)
		end
	end

	local maxWidth = 342

	if data._channel == GameEnum.ChatChannel.System then
		maxWidth = 480
	end

	if self._effect then
		UIEffectManager.instance:stopEffect(self._effect)

		self._effect = nil
	end

	if self._TxtC_Content and self._contentSizeFitter then
		NewChatFacade.instance:setChatText(self._TxtC_Content, content, maxWidth, self._contentSizeFitter, self._rectTrans, checknumber(self._horizontalOffset))
	end

	self._txtContent = content

	if self._TxtC_Name then
		self._TxtC_Name.text = data:getSenderName()
	end

	if self._returnGo then
		local isShow = false
		local endTime = data:getRegressEndTime()

		if endTime > 0 then
			local nowtime = checknumber(timer) > 0 and timer or ServerTime.nowServerLook()

			if nowtime < endTime then
				isShow = true
			end
		end

		self._returnGo:SetActive(isShow)
	end

	if self.headIcon then
		if isMe then
			HeadItemController.instance:setMyHeadCell(self.headIcon)
		elseif checknumber(data:getHeadIconId()) > 0 and checknumber(data:getHeadFrameId()) > 0 then
			HeadItemController.instance:setHeadCell(self.headIcon, data:getHeadIconId(), data:getHeadFrameId(), data.vipLv)
		else
			HeadItemController.instance:resetHeadCell(self.headIcon)
		end
	end

	if self._graphic then
		self._graphic.raycastTarget = self._mo:hasParams() or self._mo:getTpId() and self._mo:getTpId() > 0
	end

	local vipState = VipModel.instance:getIsAbleToChatWithVipFrame(nil, data.vipLv)

	GameUtil.SetActive(self._image00, false)
	GameUtil.SetActive(self._image01, false)
	GameUtil.SetActive(self._image10, false)
	GameUtil.SetActive(self._image11, false)
	MaterialMgr.clearIcon(self._image00)
	MaterialMgr.clearIcon(self._image01)
	MaterialMgr.clearIcon(self._image10)
	MaterialMgr.clearIcon(self._image11)
	GameUtil.SetActive(self._imageEffect00, false)
	GameUtil.SetActive(self._imageEffect01, false)
	GameUtil.SetActive(self._imageEffect10, false)
	GameUtil.SetActive(self._imageEffect11, false)

	for k, v in pairs(self._spriteAnim) do
		v:dispose()
	end

	table.clear(self._spriteAnim)
	GameUtil.setAnchoredPos(self._btnMsgGo, 0, 0)

	if self._uiChangeGroup then
		if isMe then
			bubbleId = NewChatModel.instance:getChatBubbleId()
		elseif data:getChannel() == 0 then
			local friendMo = FriendModel.instance:getFriendMo(data._senderId)

			if friendMo then
				bubbleId = friendMo:getValue("bubbleId")
			end
		elseif checknumber(data.bubbleId) > 0 then
			bubbleId = data.bubbleId
		end

		bubbleId = checknumber(bubbleId)

		if bubbleId <= 0 then
			bubbleId = 1
		end

		self._uiChangeGroup:SetState(bubbleId - 1)

		local cfg = ChatConfig.instance:getChatBubbleCfgById(bubbleId)

		if cfg then
			if isMe then
				GameUtil.setAnchoredPos(self._btnMsgGo, checknumber(cfg.offsetX), checknumber(cfg.offsetY))
			else
				GameUtil.setAnchoredPos(self._btnMsgGo, -checknumber(cfg.offsetX), checknumber(cfg.offsetY))
			end

			self:_setIcon(self._image00, cfg.img_00, self._imageEffect00, cfg.frameAnim_00)
			self:_setIcon(self._image01, cfg.img_01, self._imageEffect01, cfg.frameAnim_01)
			self:_setIcon(self._image10, cfg.img_10, self._imageEffect10, cfg.frameAnim_10)
			self:_setIcon(self._image11, cfg.img_11, self._imageEffect11, cfg.frameAnim_11)

			if self._TxtC_Content then
				if cfg.colorful == true then
					self._TxtC_Content.text = NewChatFacade.changeColorContent(content)
					self._TxtC_Content.color = Framework.ColorUtil.ParseColor(cfg.color)
				else
					self._TxtC_Content.color = Framework.ColorUtil.ParseColor(cfg.color)
				end
			end
		end
	end
end

function ItemChatNormal:_setIcon(icon, url, imageGo, resName)
	if not string.nilorempty(resName) and imageGo then
		local altasPrefabUrl = GameUrl.getFrameAnimAltasUrl(resName)

		self._spriteAnim[altasPrefabUrl] = ImageSpriteAnimComponent.New(imageGo)

		self._spriteAnim[altasPrefabUrl]:setFps(10)
		self._spriteAnim[altasPrefabUrl]:loadAtlasRes(altasPrefabUrl)

		return
	end

	if not string.nilorempty(url) then
		GameUtil.SetActive(icon, true)
		uGuiUtil.setSpriteToImage(icon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("chat", url), function(w, h)
			icon.gameObject:GetComponent("Image"):SetNativeSize()

			icon.gameObject:GetComponent("Image").raycastTarget = false
		end)
	end
end

function ItemChatNormal:_adjustContent(isMe, bubbleId)
	if self._layoutGroup then
		if bubbleId == 8 then
			self._layoutGroup.padding.left = 43
			self._layoutGroup.padding.right = 69

			if self._vipImg then
				local transformImg = self._vipImg.transform

				transformImg.anchorMin = anchorRB
				transformImg.anchorMax = anchorRU

				Framework.TransformUtil.SetAnchoredPos(self._vipImg.transform, -76, 8.5)
			end
		else
			self._layoutGroup.padding.left = 70
			self._layoutGroup.padding.right = 39

			if self._vipImg then
				local transformImg = self._vipImg.transform

				transformImg.anchorMin = anchorLB
				transformImg.anchorMax = anchorLU

				Framework.TransformUtil.SetAnchoredPos(self._vipImg.transform, 0, 8.5)
			end
		end
	end
end

function ItemChatNormal:_onClickIcon()
	local userId = self._mo:getSenderId()

	if self._TxtC_Content then
		FriendController.instance:showInfoView(userId, self._btnIcon, nil, self._txtContent)
	end
end

function ItemChatNormal:_onCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self._bubbleGo, false)
	end
end

function ItemChatNormal:_onLongPressCopy()
	if self._mo:isSystemMsg() then
		return
	end

	GameUtil.SetActive(self._bubbleGo, true)
end

function ItemChatNormal:_onClickBtnCopy()
	GameUtil.SetActive(self._bubbleGo, false)

	if self._mo then
		local txt = self._mo:getContent()

		if not string.nilorempty(txt) then
			Clipboard.copy(txt)
		end
	end
end

function ItemChatNormal:_onClear()
	if self._effect then
		UIEffectManager.instance:stopEffect(self._effect)

		self._effect = nil
	end

	for k, v in pairs(self._spriteAnim) do
		v:dispose()
	end

	table.clear(self._spriteAnim)
	removetimer(self._onSingleClickMsg, self)
end

return ItemChatNormal
