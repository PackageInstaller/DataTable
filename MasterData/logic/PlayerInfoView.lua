-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playeinfo/view/PlayerInfoView.lua

module("logic.extensions.playeinfo.view.PlayerInfoView", package.seeall)

local PlayerInfoView = class("PlayerInfoView", ViewComponent)

function PlayerInfoView:ctor()
	PlayerInfoView.super.ctor(self)
end

function PlayerInfoView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._Btn_Private:AddClickListener(self._onClickPrivate, self)
	self._Btn_Info:AddClickListener(self._onClickInfo, self)
	self._Btn_AddFriend:AddClickListener(self._onClickAddFriend, self)
	self._Btn_DeleteFriend:AddClickListener(self._onClickDeleteFriend, self)
	self._Btn_AddBlacklist:AddClickListener(self._onClickAddBlacklist, self)
	self._Btn_RemoveBlacklist:AddClickListener(self._onClickRemoveBlacklist, self)
	self._Btn_Report:AddClickListener(self._onClickReport, self)
	self._Btn_Pk:AddClickListener(self._onClickPk, self)

	if self._Btn_Zoo then
		self._Btn_Zoo:AddClickListener(self._onClickZoo, self)
	end

	if self._Btn_Sendflower then
		self._Btn_Sendflower:AddClickListener(self._onClickSendFlower, self)
	end
end

function PlayerInfoView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._Btn_Private:RemoveClickListener()
	self._Btn_Info:RemoveClickListener()
	self._Btn_AddFriend:RemoveClickListener()
	self._Btn_DeleteFriend:RemoveClickListener()
	self._Btn_AddBlacklist:RemoveClickListener()
	self._Btn_RemoveBlacklist:RemoveClickListener()
	self._Btn_Report:RemoveClickListener()
	self._Btn_Pk:RemoveClickListener()

	if self._Btn_Zoo then
		self._Btn_Zoo:RemoveClickListener()
	end

	if self._Btn_Sendflower then
		self._Btn_Sendflower:RemoveClickListener()
	end

	GameUtil.rmClickHandler(self._Btn_Tutor)
end

function PlayerInfoView:buildUI()
	local Nego_Bottom = self:getGo("Nego_Content/Nego_Bottom")
	local Nego_Info = self:getGo("Nego_Content/Nego_Top/Nego_Info")

	self._closeButton = self:getBtn("Close")
	self._Btn_Private = Framework.ButtonAdapter.GetFrom(Nego_Bottom, "Btn_Private")
	self._Btn_Info = Framework.ButtonAdapter.GetFrom(Nego_Bottom, "Btn_Info")
	self._Btn_AddFriend = Framework.ButtonAdapter.GetFrom(Nego_Bottom, "Btn_AddFriend")
	self._Btn_DeleteFriend = Framework.ButtonAdapter.GetFrom(Nego_Bottom, "Btn_DeleteFriend")
	self._Btn_AddBlacklist = Framework.ButtonAdapter.GetFrom(Nego_Bottom, "Btn_AddBlacklist")
	self._Btn_RemoveBlacklist = Framework.ButtonAdapter.GetFrom(Nego_Bottom, "Btn_RemoveBlacklist")
	self._Btn_Report = Framework.ButtonAdapter.GetFrom(Nego_Bottom, "Btn_Report")
	self._Btn_Pk = Framework.ButtonAdapter.GetFrom(Nego_Bottom, "Btn_Pk")
	self._Btn_Zoo = Framework.ButtonAdapter.GetFrom(Nego_Bottom, "Btn_Zoo")
	self._Btn_Sendflower = Framework.ButtonAdapter.GetFrom(Nego_Bottom, "Btn_Sendflower")
	self._Btn_Tutor = Framework.ButtonAdapter.GetFrom(Nego_Bottom, "Btn_Tutor")
	self._txt_Btn_Tutor = goutil.findChildTextComponent(Nego_Bottom, "Btn_Tutor/Text")
	self._imgZdl = self:getGo("Nego_Content/Nego_Top/Nego_Info/ImgZdl/img"):GetComponent(ComponentType.Image)
	self._TxtC_Name = goutil.findChildComponent(Nego_Info, "TxtC_Name", "Text")
	self._TxtC_Zdl = goutil.findChildComponent(Nego_Info, "ImgZdl/TxtZdl", "Text")
	self._TxtC_League = goutil.findChildComponent(Nego_Info, "TxtC_League", "Text")
	self._imageChange = self:getGo("Nego_Content/Nego_Top/Nego_Icon/ImgC_Icon")
	self._adjustPosition = goutil.findChildComponent(self.mainGO, "Nego_Content", "UIAdjustPosition")
	self._Nego_ContentImg = self:getGo("Nego_Content"):GetComponent(goutil.Type_UIImage)
	self._bg = self:getGo("Nego_Content/bg")
	self._imgBtns = {}
	self._imgBtnTexts = {}
	self._txtList = {}

	local trs = Nego_Bottom.transform
	local count = trs.childCount

	for i = 1, count do
		local child = trs:GetChild(i - 1)

		table.insert(self._imgBtns, child.gameObject)

		local txt = goutil.findChildTextComponent(child.gameObject, "Text")

		table.insert(self._txtList, txt.text)
		table.insert(self._imgBtnTexts, txt)
	end
end

function PlayerInfoView:destroyUI()
	return
end

function PlayerInfoView:onEnter()
	local params = self:getOpenParam()

	self._mo = params[1]
	self._groupType = params[2]
	self._clickGo = params[3]

	local id = checknumber(self._mo.homePageBackgroundId)

	if id == 0 then
		id = 1
	end

	self._bgCfg = BattleStartAnimConfig.instance:getHomePageBgCfg(id)

	self:_refresh()
	GameUtil.SetActive(self._Btn_Report, type(params[5]) == "string" and not string.nilorempty(params[5]))

	local isShield = params[4]

	if isShield then
		self._Btn_Private.gameObject:SetActive(false)
		self._Btn_AddFriend.gameObject:SetActive(false)
		self._Btn_DeleteFriend.gameObject:SetActive(false)
		GameUtil.SetActive(self._Btn_AddBlacklist, false)
		GameUtil.SetActive(self._Btn_RemoveBlacklist, false)
		GameUtil.SetActive(self._Btn_Tutor, false)
	end

	self:_updateHomePageBg()
end

function PlayerInfoView:onEnterFinished()
	return
end

function PlayerInfoView:onExit()
	HeadItemController.instance:resetHeadCell(self._imageChange)

	if self._loaderSpine then
		self._loaderSpine:clear()
	end
end

function PlayerInfoView:onExitFinished()
	return
end

function PlayerInfoView:_refresh()
	if self._bgCfg then
		local nameTxtColor = self._bgCfg.nameTxtColor

		nameTxtColor = string.nilorempty(self._bgCfg) and "#FFFFFF" or self._bgCfg
		self._TxtC_Name.text = string.format("<color=#%s>%s</color>", self._bgCfg, self._mo.headInfo.userName)

		if self._bgCfg then
			local zdlTxtColor = self._bgCfg.zdlTxtColor

			zdlTxtColor = string.nilorempty(zdlTxtColor) and "#FFFFFF" or zdlTxtColor

			local rgbTable = GameUtil.getColorByHexColor(zdlTxtColor)

			self._TxtC_Zdl.text = string.format("<color=#%s>%s</color>", zdlTxtColor, self._mo.maxZdl)

			Game.ImageUtil.SetColorRGBA(self._imgZdl, rgbTable.r, rgbTable.g, rgbTable.b, rgbTable.a)
			HeadItemController.instance:setHeadCellByInfo(self._imageChange, self._mo.headInfo)
			self:_setBtnStates()
		end
	end
end

function PlayerInfoView:_setBtnStates()
	local group = self._groupType
	local isFriend = group == GameEnum.FriendGroup.Friend
	local isBlack = group == GameEnum.FriendGroup.Blacklist

	self._Btn_Info.gameObject:SetActive(not isBlack)
	self._Btn_Info.gameObject:SetActive(true)
	self._Btn_AddFriend.gameObject:SetActive(not isFriend and not isBlack)
	GameUtil.SetActive(self._Btn_Zoo, false)
	self._Btn_DeleteFriend.gameObject:SetActive(isFriend)
	self._Btn_AddBlacklist.gameObject:SetActive(not isBlack)
	self._Btn_RemoveBlacklist.gameObject:SetActive(isBlack)

	local tutorStr = ""
	local identityType = 0
	local identityState = TutorSystemModel.instance:getMyIdentityState()

	if not isBlack and not FriendModel.instance:isTutorRelByFriend(self._mo.headInfo.userId) then
		if identityState == GameEnum.IdentityState.Recruiting then
			tutorStr = "收徒"
			identityType = 2
		elseif identityState == GameEnum.IdentityState.TeaQuals then
			tutorStr = "收徒"
			identityType = 2
		elseif identityState == GameEnum.IdentityState.StuQuals then
			tutorStr = "拜师"
			identityType = 1
		end
	end

	self._txt_Btn_Tutor.text = tutorStr

	GameUtil.SetActive(self._Btn_Tutor, not string.nilorempty(tutorStr))
	GameUtil.addClickHandler(self._Btn_Tutor, GameUtil.handler(self._onClickBtnTutor, self, identityType))

	local allowStrangerChat = self._mo.allowStrangerChat

	self._Btn_Private.gameObject:SetActive(isFriend or allowStrangerChat)
end

function PlayerInfoView:_onClickPrivate()
	if self:_checkInBattleOrAnswerQuestion() then
		return
	end

	if self:_checkIsInBattle() then
		return
	end

	if not ViewMgr.instance:isOpen(ViewName.Friend) then
		if self._groupType ~= GameEnum.FriendGroup.Friend then
			FriendController.instance:AddStrangerFromChat(self._mo)
			FriendController.instance:setSelectedGroup(GameEnum.FriendGroup.Stranger)
		else
			FriendController.instance:setSelectedGroup(GameEnum.FriendGroup.Friend)
		end
	end

	local preId = FriendController.instance:getCurSelectedId()

	FriendController.instance:setCurSelctedId(self._mo.headInfo.userId)
	FriendController.instance:localNotify("SelectedIdChange", preId)

	if self._groupType ~= GameEnum.FriendGroup.Friend then
		local flag = RoleModel.instance:getSettingSwitchIsOpen(GameEnum.PlayerSettingSwitchBitPos.ALLOW_STRANGER_CHAT)

		if not flag then
			FloatWordMgr.instance:show("自己尚未开启陌生人消息设置")

			return
		end

		local allowStrangerChat = self._mo.allowStrangerChat

		if not allowStrangerChat then
			FloatWordMgr.instance:show("该玩家尚未开启接收陌生人消息设置")

			return
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.PlayerInfoJumpToOtherView)
	self:close()
	ViewAutoShowController.instance:saveCurModalView()
	FriendController.instance:OpenFriendView(self._mo.headInfo.userId)
end

function PlayerInfoView:_checkIsInBattle()
	if BattleController.instance:isBattling() == true then
		FloatWordMgr.instance:show("战斗中不能跳转")

		return true
	else
		return false
	end
end

function PlayerInfoView:_onClickInfo()
	if self:_checkInBattleOrAnswerQuestion() then
		return
	end

	if not self:_checkIsInBattle() then
		self:close()
		RoleController.instance:openCardByUserId(self._mo.headInfo.userId)
		GlobalDispatcher:dispatch(GlobalNotify.PlayerInfoJumpToOtherView)
	end
end

function PlayerInfoView:_onClickAddFriend()
	FriendController.instance:addFriend(self._mo.headInfo.userId)
	self:close()
end

function PlayerInfoView:_onClickDeleteFriend()
	self:close()
	FriendController.instance:DeleteFriend(self._mo.headInfo.userId)
end

function PlayerInfoView:_onClickAddBlacklist()
	TipsFacade.instance:openPopupWindow(lang("加入黑名单"), string.format("是否把%s加入黑名单，拉黑后自动解除好友关系？", self._mo.headInfo.userName), function()
		FriendController.instance:AddBlacklistByMo(self._mo)
		self:close()
	end, function()
		return
	end)
end

function PlayerInfoView:_onClickRemoveBlacklist()
	FriendController.instance:RemoveBlacklist(self._mo.headInfo.userId)
	self:close()
end

function PlayerInfoView:_onClickReport()
	local openParam = self:getOpenParam()

	self:close()
	UIStateManager.instance:push(ViewName.ReportView, self._mo.headInfo.userName, self._mo.headInfo.userId, openParam[5])
end

function PlayerInfoView:_onClickClose()
	self:close()
end

function PlayerInfoView:_onClickPk()
	if self:_checkInBattleOrAnswerQuestion() then
		return
	end

	self:close()
	TraincampqiecuoController.instance:sendInvitation(self._mo.headInfo)
	GlobalDispatcher:dispatch(GlobalNotify.PlayerInfoJumpToOtherView)
end

function PlayerInfoView:_onClickZoo()
	if self:_checkInBattleOrAnswerQuestion() then
		return
	end

	ZooSceneController.instance:enterFriendZoo(self._mo.headInfo.userId)
	self:close()
	UIStateManager.instance:popByName(ViewName.Friend)
	GlobalDispatcher:dispatch(GlobalNotify.PlayerInfoJumpToOtherView)
end

function PlayerInfoView:_onClickSendFlower()
	if self:_checkInBattleOrAnswerQuestion() then
		return
	end

	SendFlowerController.instance:openSendFlowerView(self._mo.headInfo)
	self:close()
	GlobalDispatcher:dispatch(GlobalNotify.PlayerInfoJumpToOtherView)
end

function PlayerInfoView:_onClickBtnTutor(identityType)
	if identityType ~= 1 and identityType ~= 2 then
		return
	end

	TutorSystemController.instance:sendTutorSendRequestReq(identityType, self._mo.headInfo.userId)
	self:close()
end

function PlayerInfoView:_checkInBattleOrAnswerQuestion()
	if SceneMgr.instance.isGogingToEnterBattleScene or AnswerSceneController.instance:isAnsweringQuestion() then
		FloatWordMgr.instance:show("该状态不可进行此操作!")

		return true
	end

	return false
end

function PlayerInfoView:_updateHomePageBg()
	printInfo("test PlayerInfoView:_updateHomePageBg", self._mo.homePageBackgroundId)

	if self._bgCfg == nil then
		return
	end

	local cfg = self._bgCfg

	goutil.setActive(self._bg, false)

	if not string.nilorempty(cfg.mainIcon1) then
		if cfg.isSpine > 0 then
			if not cfg.spinePos then
				GameUtil.setAnchoredPos(self._bg, cfg.spinePos[1] or 0, cfg.spinePos[2] or 0)
				goutil.setActive(self._bg, true)

				local path = GameUrl.getViewSpineUIUrl(cfg.spinePath)

				self._loaderSpine = PrefabLoader.Get(self._bg)

				self._loaderSpine:load(path, nil, self, true)
			end
		end

		uGuiUtil.setSpriteToImage(self._Nego_ContentImg.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("playerinfobg", cfg.mainIcon1))
	end

	for i, v in ipairs(self._imgBtns) do
		self._imgBtnTexts[i].text = string.format("<color=#%s>%s</color>", cfg.btnTxtColor, self._txtList[i])

		uGuiUtil.setSpriteToImage(v, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("playerinfobg", cfg.mainIcon2))
	end
end

return PlayerInfoView
