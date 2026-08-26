-- chunkname: @modules/logic/social/view/SocialRequestItem.lua

module("modules.logic.social.view.SocialRequestItem", package.seeall)

local SocialRequestItem = class("SocialRequestItem", ListScrollCellExtend)

function SocialRequestItem:onInitView()
	self._goplayericon = gohelper.findChild(self.viewGO, "#go_playericon")
	self._goskinbg = gohelper.findChild(self.viewGO, "#go_skinbg")
	self._imagebg = gohelper.findChildImage(self.viewGO, "image_ItemBG")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._txtstatus = gohelper.findChildText(self.viewGO, "status/#txt_status")
	self._txtofflinetime = gohelper.findChildText(self.viewGO, "status/#txt_offlinetime")
	self._goofflinebg = gohelper.findChild(self.viewGO, "status/bg")
	self._txtuid = gohelper.findChildText(self.viewGO, "#txt_uid")
	self._btnagree = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_agree")
	self._btnreject = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reject")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SocialRequestItem:addEvents()
	self._btnagree:AddClickListener(self._btnagreeOnClick, self)
	self._btnreject:AddClickListener(self._btnrejectOnClick, self)
end

function SocialRequestItem:removeEvents()
	self._btnagree:RemoveClickListener()
	self._btnreject:RemoveClickListener()
end

function SocialRequestItem:_btnagreeOnClick()
	if SocialModel.instance:getFriendsCount() >= SocialConfig.instance:getMaxFriendsCount() then
		GameFacade.showToast(ToastEnum.SocialRequest1)

		return
	end

	if SocialModel.instance:isMyBlackListByUserId(self._mo.userId) then
		GameFacade.showToast(ToastEnum.SocialRequest2)

		return
	end

	FriendRpc.instance:sendHandleApplyRequest(self._mo.userId, true)
end

function SocialRequestItem:_btnrejectOnClick()
	FriendRpc.instance:sendHandleApplyRequest(self._mo.userId, false)
end

function SocialRequestItem:_editableInitView()
	self._heros = {}
	self._heroParents = self:getUserDataTb_()

	for i = 1, 3 do
		self._heroParents[i] = gohelper.findChild(self.viewGO, "Role/" .. i)
	end

	self._playericon = IconMgr.instance:getCommonPlayerIcon(self._goplayericon)
end

function SocialRequestItem:_refreshUI()
	self._playericon:onUpdateMO(self._mo)
	self._playericon:setShowLevel(true)

	self._txtname.text = self._mo.name
	self._txtuid.text = tostring(self._mo.userId)
	self._txtstatus.text = SocialConfig.instance:getRequestTimeText(self._mo.time)

	gohelper.setActive(self._goofflinebg, false)
	self:_loadBg()
end

function SocialRequestItem:_loadBg()
	if not self._mo.bg or self._mo.bg == 0 then
		self._hasSkin = false
	else
		self._hasSkin = true

		if not self.lastskinId or self.lastskinId ~= self._mo.bg then
			self._skinPath = string.format("ui/viewres/social/socialrequestitem_bg_%s.prefab", self._mo.bg)

			self:_disposeBg()

			self._loader = MultiAbLoader.New()

			self._loader:addPath(self._skinPath)
			self._loader:startLoad(self._onLoadFinish, self)
		end
	end

	gohelper.setActive(self._imagebg.gameObject, not self._hasSkin)
	gohelper.setActive(self._goskinbg, self._hasSkin)
end

function SocialRequestItem:_disposeBg()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	if self._goskinEffect then
		gohelper.destroy(self._goskinEffect)

		self._goskinEffect = nil
	end
end

function SocialRequestItem:_onLoadFinish()
	local assetItem = self._loader:getAssetItem(self._skinPath)
	local viewPrefab = assetItem:GetResource(self._skinPath)

	self._goskinEffect = gohelper.clone(viewPrefab, self._goskinbg)
	self.lastskinId = self._mo.bg
end

function SocialRequestItem:onUpdateMO(mo)
	self._mo = mo

	self:_refreshUI()

	if not mo.infos then
		local heroList = {}
		local count = #heroList

		for i = 1, 3 do
			local item = self:getHeroIcon(i)

			if i <= count then
				item:updateMo(heroList[i])
			else
				item:setActive(false)
			end
		end
	end
end

function SocialRequestItem:getHeroIcon(index)
	if not self._heros[index] then
		local go = self._view:getResInst("ui/viewres/social/socialheroitem.prefab", self._heroParents[index], "HeroItem")

		self._heros[index] = MonoHelper.addNoUpdateLuaComOnceToGo(go, SocialHeroItem)
	end

	return self._heros[index]
end

function SocialRequestItem:onDestroy()
	return
end

return SocialRequestItem
