-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0PickAssistItem.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0PickAssistItem", package.seeall)

local Season123_2_0PickAssistItem = class("Season123_2_0PickAssistItem", ListScrollCellExtend)

function Season123_2_0PickAssistItem:onInitView()
	self._heroGOParent = gohelper.findChild(self.viewGO, "heroInfo/hero")
	self._btnHeroDetail = gohelper.findChildButtonWithAudio(self.viewGO, "heroInfo/tag/btn_detail")
	self._goplayericon = gohelper.findChild(self.viewGO, "playerInfo/#go_playericon")
	self._txtplayerName = gohelper.findChildText(self.viewGO, "playerInfo/#txt_playerName")
	self._goFriend = gohelper.findChild(self.viewGO, "playerInfo/#go_friends")
	self.goSelected = gohelper.findChild(self.viewGO, "#go_selected")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_2_0PickAssistItem:addEvents()
	self._btnHeroDetail:AddClickListener(self._onHeroDetailClick, self)
end

function Season123_2_0PickAssistItem:removeEvents()
	self._btnHeroDetail:RemoveClickListener()
end

function Season123_2_0PickAssistItem:_onHeroItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	local isSelect = Season123PickAssistListModel.instance:isHeroSelected(self._mo)

	Season123PickAssistController.instance:setHeroSelect(self._mo, not isSelect)
end

function Season123_2_0PickAssistItem:_onHeroDetailClick()
	CharacterBackpackCardListModel.instance:clearCardList()
	CharacterController.instance:openCharacterView(self._mo.heroMO)
end

function Season123_2_0PickAssistItem:_editableInitView()
	self._playericon = IconMgr.instance:getCommonPlayerIcon(self._goplayericon)

	self._playericon:setEnableClick(false)
	self._playericon:setShowLevel(true)
	self._playericon:setPos("_golevel", 0, -36)
	self._playericon:setPos("_txtlevel", -25, -4)

	local imgLevelBg = self._playericon:getLevelBg()

	UISpriteSetMgr.instance:setSeason123Sprite(imgLevelBg, "v1a7_season_img_namebg", true)

	self._heroItem = IconMgr.instance:getCommonHeroItem(self._heroGOParent)

	self._heroItem:addClickListener(self._onHeroItemClick, self)
	self:initHeroItem()
end

function Season123_2_0PickAssistItem:initHeroItem()
	local heroItemAnimator = self._heroItem.go:GetComponent(typeof(UnityEngine.Animator))

	if heroItemAnimator then
		heroItemAnimator.enabled = false
	end

	self._heroItem:setStyle_SeasonPickAssist()
	self._heroItem:_setTranScale("_rankObj", 0.2, 0.2)
	self._heroItem:setSelect(false)
	self._heroItem:isShowSeasonMask(true)
end

function Season123_2_0PickAssistItem:onUpdateMO(mo)
	self._mo = mo

	local playerInfo = self._mo:getPlayerInfo()

	self._playericon:onUpdateMO(playerInfo)

	self._txtplayerName.text = playerInfo.name

	local isFriend = SocialModel.instance:isMyFriendByUserId(playerInfo.userId)

	gohelper.setActive(self._goFriend, isFriend)

	local heroMO = self._mo.heroMO

	self._heroItem:onUpdateMO(heroMO)
	self._heroItem:setNewShow(false)

	local balanceLv
	local assistHeroMO = self._mo.assistMO

	if assistHeroMO then
		local tmpLv = assistHeroMO.level
		local tmpBalanceLv = assistHeroMO.balanceLevel

		if tmpBalanceLv and tmpLv ~= tmpBalanceLv then
			balanceLv = tmpBalanceLv
		end
	end

	if balanceLv then
		self._heroItem:setBalanceLv(balanceLv)
	end

	local isSelect = Season123PickAssistListModel.instance:isHeroSelected(self._mo)

	self:setSelected(isSelect)
end

function Season123_2_0PickAssistItem:setSelected(isSelected)
	gohelper.setActive(self.goSelected, isSelected)
end

function Season123_2_0PickAssistItem:onDestroy()
	if self._heroItem then
		self._heroItem:onDestroy()

		self._heroItem = nil
	end
end

function Season123_2_0PickAssistItem:getAnimator()
	return self._animator
end

return Season123_2_0PickAssistItem
