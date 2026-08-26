-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/miniparty/view/MiniPartyInviteFriendItem.lua

module("modules.logic.versionactivity3_4.laplaceforum.miniparty.view.MiniPartyInviteFriendItem", package.seeall)

local MiniPartyInviteFriendItem = class("MiniPartyInviteFriendItem", LuaCompBase)

function MiniPartyInviteFriendItem:init(go)
	self.go = go
	self._goskinbg = gohelper.findChild(self.go, "#go_skinbg")
	self._goplayericon = gohelper.findChild(self.go, "go_playericon")
	self._txtname = gohelper.findChildText(self.go, "txt_name")
	self._txtungroup = gohelper.findChildText(self.go, "txt_name/txt_ungroup")
	self._txtuid = gohelper.findChildText(self.go, "txt_uid")
	self._gostatus = gohelper.findChild(self.go, "status")
	self._txtstatus = gohelper.findChildText(self.go, "status/txt_status")
	self._txtofflinetime = gohelper.findChildText(self.go, "status/txt_offlinetime")
	self._gorole = gohelper.findChild(self.go, "Role")
	self._gorole1 = gohelper.findChild(self.go, "Role/1")
	self._gorole2 = gohelper.findChild(self.go, "Role/2")
	self._gorole3 = gohelper.findChild(self.go, "Role/3")
	self._gobtn = gohelper.findChild(self.go, "Btn")
	self._btnagree = gohelper.findChildButtonWithAudio(self.go, "Btn/btn_agree")
	self._btnreject = gohelper.findChildButtonWithAudio(self.go, "Btn/btn_reject")
	self._btninvite = gohelper.findChildButtonWithAudio(self.go, "Btn/btn_invite")
	self._gogrouped = gohelper.findChild(self.go, "Btn/go_grouped")
	self._gotimeout = gohelper.findChild(self.go, "Btn/go_timeout")
	self._heros = {}
	self._playericon = IconMgr.instance:getCommonPlayerIcon(self._goplayericon)
	self._itemAnim = self.go:GetComponent(typeof(UnityEngine.Animator))

	self:_addEvents()
end

function MiniPartyInviteFriendItem:_addEvents()
	self._btninvite:AddClickListener(self._btninviteOnClick, self)
end

function MiniPartyInviteFriendItem:_removeEvents()
	self._btninvite:RemoveClickListener()
end

function MiniPartyInviteFriendItem:_btninviteOnClick()
	if self._mo.isTeam then
		GameFacade.showToast(ToastEnum.MiniPartyTargetHasGrouped)

		return
	end

	if self._mo.isInvite then
		GameFacade.showToast(ToastEnum.MiniPartyHasSendInvite)

		return
	end

	local actId = VersionActivity3_4Enum.ActivityId.LaplaceMiniParty
	local uid = self._mo.friendUid

	Activity223Rpc.instance:sendAct223InviteRequest(actId, "", uid)
end

function MiniPartyInviteFriendItem:showSwitch()
	gohelper.setActive(self.go, false)
	TaskDispatcher.runDelay(self._startShowSwitch, self, 0.05 * self._index)
end

function MiniPartyInviteFriendItem:_startShowSwitch()
	gohelper.setActive(self.go, true)
	self._itemAnim:Play("switch")
end

function MiniPartyInviteFriendItem:refresh(mo, index)
	gohelper.setActive(self.go, true)

	self._mo = mo
	self._index = index
	self._friendMo = SocialModel.instance:getPlayerMO(self._mo.friendUid)

	self._playericon:onUpdateMO(self._friendMo)
	self._playericon:setShowLevel(true)

	local uidString = tostring(self._mo.friendUid)
	local uidLength = GameUtil.utf8len(uidString)

	self._txtname.text = string.format("%s#%s", self._friendMo.name, (uidLength > 3 or nil) and GameUtil.utf8sub(uidString, uidLength - 2, uidLength))
	self._txtuid.text = string.format(uidString)

	local isOnline = tonumber(self._friendMo.time) == 0

	gohelper.setActive(self._txtstatus, isOnline)
	gohelper.setActive(self._txtofflinetime, not isOnline)

	if not isOnline then
		self._txtofflinetime.text = SocialConfig.instance:getStatusText(self._friendMo.time)
	end

	self._txtstatus.text = luaLang("social_online")

	self:_loadBg()

	local hasTimeOut = false

	gohelper.setActive(self._gotimeout, hasTimeOut)
	gohelper.setActive(self._btnagree.gameObject, false)
	gohelper.setActive(self._btnreject.gameObject, false)
	gohelper.setActive(self._txtungroup.gameObject, not self._mo.isTeam)
	gohelper.setActive(self._gogrouped, self._mo.isTeam)
	gohelper.setActive(self._btninvite.gameObject, not self._mo.isTeam)
	self:_updateRole()
end

function MiniPartyInviteFriendItem:_updateRole()
	if not self._friendMo.infos then
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

function MiniPartyInviteFriendItem:getHeroIcon(index)
	if not self._heros[index] then
		local roleGo = self["_gorole" .. index]
		local go = gohelper.findChild(roleGo, "heroitem")

		self._heros[index] = MonoHelper.addNoUpdateLuaComOnceToGo(go, SocialHeroItem)
	end

	return self._heros[index]
end

function MiniPartyInviteFriendItem:_loadBg()
	if not self._friendMo.bg or self._friendMo.bg == 0 then
		self._hasSkin = false
	else
		self._hasSkin = true

		if not self._lastSkinId or self._lastSkinId ~= self._friendMo.bg then
			self._skinPath = string.format("ui/viewres/social/socialsearchitem_bg_%s.prefab", self._friendMo.bg)

			self:_disposeBg()

			self._loader = MultiAbLoader.New()

			self._loader:addPath(self._skinPath)
			self._loader:startLoad(self._onLoadFinish, self)
		end
	end

	gohelper.setActive(self._goskinbg, self._hasSkin)
end

function MiniPartyInviteFriendItem:_disposeBg()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	if self._goskinEffect then
		gohelper.destroy(self._goskinEffect)

		self._goskinEffect = nil
	end
end

function MiniPartyInviteFriendItem:_onLoadFinish()
	local assetItem = self._loader:getAssetItem(self._skinPath)
	local viewPrefab = assetItem:GetResource(self._skinPath)

	self._goskinEffect = gohelper.clone(viewPrefab, self._goskinbg)
	self._lastSkinId = self._mo.bg
end

function MiniPartyInviteFriendItem:destroy()
	TaskDispatcher.cancelTask(self._startShowSwitch, self)
	self:_disposeBg()
	self:_removeEvents()
end

return MiniPartyInviteFriendItem
