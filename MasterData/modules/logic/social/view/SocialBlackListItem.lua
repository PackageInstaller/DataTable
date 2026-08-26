-- chunkname: @modules/logic/social/view/SocialBlackListItem.lua

module("modules.logic.social.view.SocialBlackListItem", package.seeall)

local SocialBlackListItem = class("SocialBlackListItem", ListScrollCellExtend)

function SocialBlackListItem:onInitView()
	self._goplayericon = gohelper.findChild(self.viewGO, "#go_playericon")
	self._goskinbg = gohelper.findChild(self.viewGO, "#go_skinbg")
	self._imagebg = gohelper.findChildImage(self.viewGO, "bg")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._txtstatus = gohelper.findChildText(self.viewGO, "status/#txt_status")
	self._txtofflinetime = gohelper.findChildText(self.viewGO, "status/#txt_offlinetime")
	self._btnremove = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_remove")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SocialBlackListItem:addEvents()
	self._btnremove:AddClickListener(self._btnremoveOnClick, self)
end

function SocialBlackListItem:removeEvents()
	self._btnremove:RemoveClickListener()
end

function SocialBlackListItem:_btnremoveOnClick()
	FriendRpc.instance:sendRemoveBlacklistRequest(self._mo.userId)
end

function SocialBlackListItem:_editableInitView()
	self._playericon = IconMgr.instance:getCommonPlayerIcon(self._goplayericon)
end

function SocialBlackListItem:_refreshUI()
	self._playericon:onUpdateMO(self._mo)
	self._playericon:setShowLevel(true)

	self._txtname.text = self._mo.name

	gohelper.setActive(self._txtstatus.gameObject, tonumber(self._mo.time) == 0)
	gohelper.setActive(self._txtofflinetime.gameObject, tonumber(self._mo.time) ~= 0)

	if tonumber(self._mo.time) ~= 0 then
		self._txtofflinetime.text = SocialConfig.instance:getStatusText(self._mo.time)
	end

	self._txtstatus.text = luaLang("social_online")

	self:_loadBg()
end

function SocialBlackListItem:_loadBg()
	if not self._mo.bg or self._mo.bg == 0 then
		self._hasSkin = false
	else
		self._hasSkin = true

		if not self.lastskinId or self.lastskinId ~= self._mo.bg then
			self._skinPath = string.format("ui/viewres/social/socialblacklistitem_bg_%s.prefab", self._mo.bg)

			self:_disposeBg()

			self._loader = MultiAbLoader.New()

			self._loader:addPath(self._skinPath)
			self._loader:startLoad(self._onLoadFinish, self)
		end
	end

	gohelper.setActive(self._imagebg.gameObject, not self._hasSkin)
	gohelper.setActive(self._goskinbg, self._hasSkin)
end

function SocialBlackListItem:_disposeBg()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	if self._goskinEffect then
		gohelper.destroy(self._goskinEffect)

		self._goskinEffect = nil
	end
end

function SocialBlackListItem:_onLoadFinish()
	local assetItem = self._loader:getAssetItem(self._skinPath)
	local viewPrefab = assetItem:GetResource(self._skinPath)

	self._goskinEffect = gohelper.clone(viewPrefab, self._goskinbg)
	self.lastskinId = self._mo.bg
end

function SocialBlackListItem:onUpdateMO(mo)
	self._mo = mo

	self:_refreshUI()
end

function SocialBlackListItem:onDestroy()
	return
end

return SocialBlackListItem
