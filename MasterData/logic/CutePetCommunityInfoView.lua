-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/community/CutePetCommunityInfoView.lua

module("logic.extensions.cutepet.view.CutePetCommunityInfoView", package.seeall)

local CutePetCommunityInfoView = class("CutePetCommunityInfoView", ViewComponent)

function CutePetCommunityInfoView:ctor()
	CutePetCommunityInfoView.super.ctor(self)
end

function CutePetCommunityInfoView:unbindEvents()
	CutePetCommunityInfoView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnPrivate)
	GameUtil.rmClickHandler(self._btnAddFriend)
	GameUtil.rmClickHandler(self._btnClose)
	self._btnInvite:RemoveClickListener()
end

function CutePetCommunityInfoView:bindEvents()
	CutePetCommunityInfoView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnPrivate, self._onClickPrivate, self)
	GameUtil.addClickHandler(self._btnAddFriend, self._onClickAddFriend, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	self._btnInvite:AddClickListener(self._onClickbtnInvite, self)
end

function CutePetCommunityInfoView:buildUI()
	CutePetCommunityInfoView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._headIcon = self:getGo("imgHeadIcon")
	self._txtName = self:getTxt("txtName")
	self._imgPetType = goutil.findChildComponent(self.mainGO, "petInfo/imgType", "UIImageSpriteChange")
	self._txtPetName = self:getTxt("petInfo/txtName")
	self._con = self:getGo("con")
	self._txtTime = self:getTxt("txtTime")
	self._txtNeedType = self:getTxt("txtNeedType")
	self._imgNeedType = goutil.findChildComponent(self.mainGO, "txtNeedType/imgType", "UIImageSpriteChange")
	self._btnPrivate = self:getGo("btnPrivate")
	self._btnAddFriend = self:getGo("btnAddFriend")
	self._petCon = self:getGo("con")
	self._btnInvite = self:getBtn("btnInvite")
end

function CutePetCommunityInfoView:onExit()
	CutePetCommunityInfoView.super.onExit(self)
	CutePetModelMgr.instance:popViewWithModel(self._viewPresentor.viewName)
end

function CutePetCommunityInfoView:onEnter()
	CutePetCommunityInfoView.super.onEnter(self)
	self:addGEvent(GlobalNotify.PlayerInfoJumpToOtherView, self.close)

	local params = self:getOpenParam()

	self._playerMo = params[1]
	self._groupType = params[2]
	self._data = params[3]

	local raceCfg = CutePetConfig.instance:getCutePetById(self._data.cutePetRaceId)

	self._imgPetType:SetState(raceCfg.type - 1)

	self._txtPetName.text = raceCfg.name
	self._txtTime.text = langPara("%d次", self._data.travelCountNeeds)

	if checknumber(self._data.cutePetTypeNeeds) > 0 then
		local typeCfg = CutePetConfig.instance:getPetTypeCfg(self._data.cutePetTypeNeeds)

		GameUtil.SetActive(self._imgNeedType, true)
		self._imgNeedType:SetState(self._data.cutePetTypeNeeds - 1)

		self._txtNeedType.text = typeCfg.name
	else
		GameUtil.SetActive(self._imgNeedType, false)

		self._txtNeedType.text = "无"
	end

	local proxy = HeadItemController.instance:setHeadCellByInfo(self._headIcon, self._playerMo.headInfo)

	if proxy then
		proxy:setCallBack(function()
			if self._playerMo.headInfo.userId then
				self:onHeadClick(self._playerMo.headInfo.userId, self._headIcon)
			end
		end)
	end

	self._txtName.text = self._playerMo.headInfo.userName

	GameUtil.SetActive(self._btnAddFriend, self._groupType ~= GameEnum.FriendGroup.Friend)
	GameUtil.SetActive(self._btnInvite, self._groupType == GameEnum.FriendGroup.Friend)
	CutePetModelMgr.instance:pushViewWithModel(self._petCon, self._viewPresentor.viewName, 1, 1, 180)
	CutePetModelMgr.instance:resetModel(1, raceCfg.modelId)
	CutePetModelMgr.instance:setOffset(1, CutePetConfig.instance:getPetOffsetInDefaultView(self._data.cutePetRaceId))
end

function CutePetCommunityInfoView:_onClickPrivate()
	if not ViewMgr.instance:isOpen(ViewName.Friend) then
		if self._groupType ~= GameEnum.FriendGroup.Friend then
			FriendController.instance:AddStrangerFromChat(self._playerMo)
			FriendController.instance:setSelectedGroup(GameEnum.FriendGroup.Stranger)
		else
			FriendController.instance:setSelectedGroup(GameEnum.FriendGroup.Friend)
		end
	end

	local preId = FriendController.instance:getCurSelectedId()

	self:close()
	FriendController.instance:setCurSelctedId(self._playerMo.headInfo.userId)
	FriendController.instance:localNotify("SelectedIdChange", preId)
	FriendController.instance:OpenFriendView(self._playerMo.headInfo.userId)
end

function CutePetCommunityInfoView:_onClickAddFriend()
	FriendController.instance:addFriend(self._playerMo.headInfo.userId)
end

function CutePetCommunityInfoView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

function CutePetCommunityInfoView:_onClickbtnInvite()
	UIStateManager.instance:push(ViewName.CutepettravelteamView, self._playerMo.headInfo.userId)
	self:close()
end

return CutePetCommunityInfoView
