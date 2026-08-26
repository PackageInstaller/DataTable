-- chunkname: @modules/logic/social/view/SocialFriendItem.lua

module("modules.logic.social.view.SocialFriendItem", package.seeall)

local SocialFriendItem = class("SocialFriendItem", ListScrollCellExtend)

function SocialFriendItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._goskinbg = gohelper.findChild(self.viewGO, "#go_skinbg")
	self._gobg = gohelper.findChild(self.viewGO, "#go_normal/#go_bg")
	self._imagegobg = gohelper.findChildImage(self.viewGO, "#go_normal/#go_bg")
	self._gobgselect = gohelper.findChild(self.viewGO, "#go_normal/#go_bgselect")
	self._imagegoselectbg = gohelper.findChildImage(self.viewGO, "#go_normal/#go_bgselect")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._goplayericon = gohelper.findChild(self.viewGO, "#go_playericon")
	self._txtname = gohelper.findChildText(self.viewGO, "name/#txt_name")
	self._txtnameoffline = gohelper.findChildText(self.viewGO, "name/#txt_nameoffline")
	self._txtstatus = gohelper.findChildText(self.viewGO, "status/#txt_status")
	self._txtofflinetime = gohelper.findChildText(self.viewGO, "status/#txt_offlinetime")
	self._friendreddot = gohelper.findChild(self.viewGO, "#go_friendreddot")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_arrow")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SocialFriendItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function SocialFriendItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function SocialFriendItem:_btnclickOnClick()
	SocialModel.instance:setSelectFriend(self._mo.userId)
end

function SocialFriendItem:_editableInitView()
	self._playericon = IconMgr.instance:getCommonPlayerIcon(self._goplayericon)

	self.addEventCb(self, SocialController.instance, SocialEvent.SelectFriend, self._onFriendSelect, self)
	self.addEventCb(self, SocialController.instance, SocialEvent.FriendDescChange, self.updateName, self)
end

function SocialFriendItem:_refreshUI()
	self._playericon:onUpdateMO(self._mo)
	self._playericon:setShowLevel(true)

	local isSelect = self:_isSelectFriend()

	self._playericon:isSelectInFriend(isSelect)

	if RedDotModel.instance:getDotInfo(RedDotEnum.DotNode.FriendInfoDetail, tonumber(self._mo.userId)) then
		RedDotController.instance:addRedDot(self._friendreddot, RedDotEnum.DotNode.FriendInfoDetail, tonumber(self._mo.userId))
	end

	gohelper.setActive(self._txtstatus.gameObject, tonumber(self._mo.time) == 0)
	gohelper.setActive(self._txtofflinetime.gameObject, tonumber(self._mo.time) ~= 0)
	gohelper.setActive(self._txtname.gameObject, tonumber(self._mo.time) == 0)
	gohelper.setActive(self._txtnameoffline.gameObject, tonumber(self._mo.time) ~= 0)
	self._playericon:setPlayerIconGray(tonumber(self._mo.time) ~= 0)

	if tonumber(self._mo.time) ~= 0 then
		self._txtofflinetime.text = SocialConfig.instance:getStatusText(self._mo.time)
	end

	self:updateName()

	self._txtstatus.text = luaLang("social_online")

	self:_loadBg(self._mo.bg)
	self:_onFriendSelect()
end

function SocialFriendItem:_loadBg(skinId)
	if not skinId or skinId == 0 then
		self._hasSkin = false
	else
		self._hasSkin = true

		if not self.lastskinId or self.lastskinId ~= skinId then
			self._skinPath = string.format("ui/viewres/social/socialfrienditem_bg_%s.prefab", skinId)

			self:_disposeBg()

			self._loader = MultiAbLoader.New()

			self._loader:addPath(self._skinPath)
			self._loader:startLoad(self._onLoadFinish, self)
		end
	end

	gohelper.setActive(self._gonormal, not self._hasSkin)
	gohelper.setActive(self._goskinbg, self._hasSkin)
end

function SocialFriendItem:_disposeBg()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	if self._goskinEffect then
		gohelper.destroy(self._goskinEffect)

		self._goskinEffect = nil
	end
end

function SocialFriendItem:_onLoadFinish()
	local assetItem = self._loader:getAssetItem(self._skinPath)
	local viewPrefab = assetItem:GetResource(self._skinPath)

	self._goskinEffect = gohelper.clone(viewPrefab, self._goskinbg)
	self.lastskinId = self._mo.bg
end

function SocialFriendItem:setBgState(gobg)
	local online = gohelper.findChild(gobg, "online")
	local offline = gohelper.findChild(gobg, "offline")

	if not self._isplaycard then
		local isSelect = self:_isSelectFriend()

		gohelper.setActive(offline, not isSelect)
		gohelper.setActive(online, isSelect)
	else
		gohelper.setActive(offline, false)
		gohelper.setActive(online, true)
	end
end

function SocialFriendItem:selectSkin(skinid)
	self._isplaycard = true

	self:_loadBg(skinid)
end

function SocialFriendItem:updateName(id)
	if id and id ~= self._mo.id then
		return
	end

	if self._mo then
		if not self._mo.name then
			local name = ""

			if self:_isSelectFriend() then
				if not string.nilorempty(self._mo.desc) then
					self._txtname.text = "<size=32><color=#c66030>" .. name .. "<color=#5c574d>(" .. self._mo.desc .. ")"
					self._txtnameoffline.text = "<size=32><color=#c66030>" .. name .. "<color=#5c574d>(" .. self._mo.desc .. ")"
				else
					self._txtname.text = "<size=38><color=#c66030>" .. name
					self._txtnameoffline.text = "<size=38><color=#222222>" .. name
				end

				self._txtstatus.text = "<color=#56A165>" .. self._txtstatus.text
			else
				if not string.nilorempty(self._mo.desc) then
					self._txtname.text = "<size=32><color=#404040>" .. name .. "<color=#5c574d>(" .. self._mo.desc .. ")"
					self._txtnameoffline.text = "<size=32><color=#222222>" .. name .. "<color=#5c574d>(" .. self._mo.desc .. ")"
				else
					self._txtname.text = "<size=38><color=#404040>" .. name
					self._txtnameoffline.text = "<size=38><color=#222222>" .. name
				end

				self._txtstatus.text = "<color=#4E7656>" .. self._txtstatus.text
			end
		end
	end
end

function SocialFriendItem:onUpdateMO(mo)
	self._mo = mo

	self:_refreshUI()
end

local ColorSelect = Color.New(1, 1, 1, 1)
local ColorUnSelect = Color.New(1, 1, 1, 0.7)

function SocialFriendItem:_onFriendSelect()
	local selectFriend = SocialModel.instance:getSelectFriend()
	local isSelect = self._mo.userId == selectFriend

	gohelper.setActive(self._gobg, not isSelect)
	gohelper.setActive(self._gobgselect, isSelect)
	gohelper.setActive(self._goarrow, isSelect)
	self._playericon:isSelectInFriend(self:_isSelectFriend())
	self:updateName()
	self:setBgState(self._goskinEffect)
end

function SocialFriendItem:_isSelectFriend()
	local selectFriend = SocialModel.instance:getSelectFriend()

	if self._mo.userId == selectFriend then
		return true
	end

	return false
end

function SocialFriendItem:onDestroy()
	if self._playericon then
		self._playericon:onDestroy()

		self._playericon = nil
	end

	self.removeEventCb(self, SocialController.instance, SocialEvent.SelectFriend, self._onFriendSelect, self)
	self.removeEventCb(self, SocialController.instance, SocialEvent.FriendDescChange, self.updateName, self)
end

return SocialFriendItem
