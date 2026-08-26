-- chunkname: @modules/logic/pickassist/view/PickAssistItem.lua

module("modules.logic.pickassist.view.PickAssistItem", package.seeall)

local PickAssistItem = class("PickAssistItem", ListScrollCellExtend)

function PickAssistItem:onInitView()
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

function PickAssistItem:addEvents()
	self._btnHeroDetail:AddClickListener(self._onHeroDetailClick, self)
end

function PickAssistItem:removeEvents()
	self._btnHeroDetail:RemoveClickListener()
end

function PickAssistItem:_onHeroItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if not self:_checkClick() then
		return
	end

	local isSelect = PickAssistListModel.instance:isHeroSelected(self._mo)

	PickAssistController.instance:setHeroSelect(self._mo, not isSelect)
end

function PickAssistItem:_checkClick()
	return true
end

function PickAssistItem:_onHeroDetailClick()
	CharacterBackpackCardListModel.instance:clearCardList()
	CharacterController.instance:openCharacterView(self._mo.heroMO)
end

function PickAssistItem:_editableInitView()
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

function PickAssistItem:initHeroItem()
	local heroItemAnimator = self._heroItem.go:GetComponent(typeof(UnityEngine.Animator))

	if heroItemAnimator then
		heroItemAnimator.enabled = false
	end

	self._heroItem:setStyle_RougePickAssist()
	self._heroItem:setSelect(false)
	self._heroItem:isShowSeasonMask(true)
end

function PickAssistItem:onUpdateMO(mo)
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

	local isSelect = PickAssistListModel.instance:isHeroSelected(self._mo)

	self:setSelected(isSelect)
end

function PickAssistItem:setSelected(isSelected)
	gohelper.setActive(self.goSelected, isSelected)
end

function PickAssistItem:onDestroy()
	if self._heroItem then
		self._heroItem:onDestroy()

		self._heroItem = nil
	end
end

function PickAssistItem:getAnimator()
	return self._animator
end

return PickAssistItem
