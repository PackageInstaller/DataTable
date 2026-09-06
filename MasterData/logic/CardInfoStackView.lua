-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/stack/CardInfoStackView.lua

module("logic.extensions.roleinfo.view.stack.CardInfoStackView", package.seeall)

local CardInfoStackView = class("CardInfoStackView", OtherCardInfoView)

function CardInfoStackView:ctor()
	CardInfoStackView.super.ctor(self)
end

function CardInfoStackView:bindEvents()
	CardInfoStackView.super.bindEvents(self)
	self.btnEditName:AddClickListener(self.onEditName, self)
	self.btnHead:AddClickListener(self.onHeadClick, self)
	self.btnEditHead:AddClickListener(self.onHeadClick, self)
	self._badgeBtn:AddClickListener(self._onClickBadge, self)
	self._petTitleBtn:AddClickListener(self._onClickPetTitle, self)

	for i, value in ipairs(self._showBadgeList) do
		local btn = goutil.findChild(value, "btn")

		GameUtil.addClickHandler(btn, GameUtil.handler(self.onClickBadgeItem, self, i))
	end

	for i, value in ipairs(self._showPetTitleList) do
		local btn = goutil.findChild(value, "btn")

		GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickPetTitleIcon, self, i))
	end
end

function CardInfoStackView:unbindEvents()
	CardInfoStackView.super.unbindEvents(self)
	self.btnEditName:RemoveClickListener()
	self.btnEditHead:RemoveClickListener()
	self._badgeBtn:RemoveClickListener()
	self._petTitleBtn:RemoveClickListener()
	self.btnHead:RemoveClickListener()

	for i, value in ipairs(self._showBadgeList) do
		local btn = goutil.findChild(value, "btn")

		GameUtil.rmClickHandler(btn)
	end

	for i, value in ipairs(self._showPetTitleList) do
		local btn = goutil.findChild(value, "btn")

		GameUtil.rmClickHandler(btn)
	end
end

function CardInfoStackView:buildUI()
	CardInfoStackView.super.buildUI(self)

	self._badgeRedpoint = self:getGo("ScrollView/Viewport/Content/Nego_Badge/txtBadgeNum/btn/redpoint")
end

function CardInfoStackView:destroyUI()
	CardInfoStackView.super.destroyUI(self)
end

function CardInfoStackView:onEnter()
	CardInfoStackView.super.onEnter(self)
	RedPointController.instance:regRedPoint(self._badgeRedpoint, RedPointModel.ID_BADGE_COMPOSE)
end

function CardInfoStackView:initData()
	self.curMo = RoleModel.instance:getCardInfoMo(self:_getCardBelong())

	local petCfg = CharacterConfig.instance:getPetCfg()

	self._allPetBookNum = 0

	for _, cfg in ipairs(petCfg) do
		if PetbookModel.instance:getIsHandBookPet(cfg) then
			self._allPetBookNum = self._allPetBookNum + 1
		end
	end

	GlobalDispatcher:addListener(BadgeController.CHANGEBADGE, self._changeBadge, self)
	GlobalDispatcher:addListener(GlobalNotify.ON_HEAD_ITEM_CHANGE, self.refreshHead, self)
	GlobalDispatcher:addListener(GlobalNotify.UserCardPetTitleChange, self._updatePetTitle, self)
	self:_updateExteriorUI()
	self:_initColorData()
end

function CardInfoStackView:onEnterFinished()
	CardInfoStackView.super.onEnterFinished(self)
end

function CardInfoStackView:onExit()
	CardInfoStackView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._badgeRedpoint)
	GlobalDispatcher:removeListener(BadgeController.CHANGEBADGE, self._changeBadge, self)
	GlobalDispatcher:removeListener(GlobalNotify.ON_HEAD_ITEM_CHANGE, self.refreshHead, self)
	GlobalDispatcher:removeListener(GlobalNotify.UserCardPetTitleChange, self._updatePetTitle, self)
end

function CardInfoStackView:onExitFinished()
	CardInfoStackView.super.onExitFinished(self)
end

function CardInfoStackView:_updateExteriorUI()
	local cfg = ExteriorController.instance:getExteriorCfg()

	self._messageSkinId = cfg.id

	GameUtil.SetActive(self._bg, self._messageSkinId <= 1)
	GameUtil.SetActive(self._skin, self._messageSkinId > 1)

	if cfg and self._messageSkinId > 1 then
		uGuiUtil.setSpriteToImage(self._skin, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("exterior", cfg.bg), function(obj)
			local img = obj[1]:GetComponent(goutil.Type_UIImage)

			img.raycastTarget = false
		end, {
			self._skin
		})
	end
end

function CardInfoStackView:onEditName()
	local v = FriendConfig.instance:getCommonValue("NO_RENAME_PERIOD")
	local times = string.split(v, "#")

	if #times == 2 and GameUtil.checkIsInTimePeriod(times[1], times[2]) then
		FloatWordMgr.instance:show("本功能正在进行技术维护，具体开放时间请留意公告！")

		return
	end

	RoleController.instance:showRenameView()
end

function CardInfoStackView:onEditTitle()
	FloatWordMgr.instance:show(ConstString.NotRelease)
end

function CardInfoStackView:onEditHead()
	FloatWordMgr.instance:show(ConstString.NotRelease)
end

function CardInfoStackView:refresh()
	CardInfoStackView.super.refresh(self)
	BadgeController.instance:getBadgeInfo(function()
		self._readyBadgeInfo = true
	end)
end

function CardInfoStackView:_getCardBelong()
	return RoleModel.CardBelong.My
end

function CardInfoStackView:_onClickBadge()
	UIStateManager.instance:push(ViewName.BadgeShowView)
end

function CardInfoStackView:_onClickPetTitle()
	UIStateManager.instance:push(ViewName.PetTitleOverView)
end

function CardInfoStackView:onClickBadgeItem(index)
	if self._readyBadgeInfo then
		UIStateManager.instance:push(ViewName.BadgeshowselectView, index)
	end
end

function CardInfoStackView:_onClickPetTitleIcon(index)
	local petTitles = self.curMo.petTitles

	if petTitles then
		UIStateManager.instance:push(ViewName.PetTitleCardSelectView, petTitles, index, function(petTitlesT)
			RoleController.instance:reqCardPetTitleChange(petTitlesT)
		end)
	end
end

function CardInfoStackView:onHeadClick()
	UIStateManager.instance:push(ViewName.HeadsetView)
end

return CardInfoStackView
