-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/miniparty/view/MiniPartyInviteCheckItem.lua

module("modules.logic.versionactivity3_4.laplaceforum.miniparty.view.MiniPartyInviteCheckItem", package.seeall)

local MiniPartyInviteCheckItem = class("MiniPartyInviteCheckItem", LuaCompBase)

function MiniPartyInviteCheckItem:init(go)
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
	self._actId = VersionActivity3_4Enum.ActivityId.LaplaceMiniParty

	self:_addEvents()
end

function MiniPartyInviteCheckItem:_addEvents()
	self._btnagree:AddClickListener(self._btnagreeOnClick, self)
	self._btnreject:AddClickListener(self._btnrejectOnClick, self)
	MiniPartyController.instance:registerCallback(MiniPartyEvent.InviteFriendAgreeBack, self._onTargetUserGrouped, self)
end

function MiniPartyInviteCheckItem:_removeEvents()
	self._btnagree:RemoveClickListener()
	self._btnreject:RemoveClickListener()
	MiniPartyController.instance:unregisterCallback(MiniPartyEvent.InviteFriendAgreeBack, self._onTargetUserGrouped, self)
end

function MiniPartyInviteCheckItem:_onTargetUserGrouped(userId, isAgree)
	if isAgree or self._mo.friendInfo.userId ~= userId then
		return
	end

	gohelper.setActive(self._btnagree.gameObject, false)
	gohelper.setActive(self._btnreject.gameObject, false)
	gohelper.setActive(self._gotimeout, true)
end

function MiniPartyInviteCheckItem:_btnagreeOnClick()
	Activity223Rpc.instance:sendAct223HandleInviteRequest(self._actId, self._mo.friendInfo.userId, true)
end

function MiniPartyInviteCheckItem:_btnrejectOnClick()
	Activity223Rpc.instance:sendAct223HandleInviteRequest(self._actId, self._mo.friendInfo.userId, false)
end

function MiniPartyInviteCheckItem:showSwitch()
	gohelper.setActive(self.go, false)
	TaskDispatcher.runDelay(self._startShowSwitch, self, 0.05 * self._index)
end

function MiniPartyInviteCheckItem:_startShowSwitch()
	gohelper.setActive(self.go, true)
	self._itemAnim:Play("switch")
end

function MiniPartyInviteCheckItem:refresh(mo, index)
	gohelper.setActive(self.go, true)

	self._mo = mo
	self._index = index
	self._playerMo = self._mo.friendInfo

	self._playericon:onUpdateMO(self._playerMo)
	self._playericon:setShowLevel(true)

	local uidString = tostring(self._mo.friendInfo.userId)
	local uidLength = GameUtil.utf8len(uidString)

	self._txtname.text = string.format("%s#%s", self._mo.friendInfo.name, (uidLength > 3 or nil) and GameUtil.utf8sub(uidString, uidLength - 2, uidLength))
	self._txtuid.text = string.format(uidString)

	local isOnline = tonumber(self._mo.friendInfo.time) == 0

	gohelper.setActive(self._txtstatus, isOnline)
	gohelper.setActive(self._txtofflinetime, not isOnline)

	if not isOnline then
		self._txtofflinetime.text = SocialConfig.instance:getStatusText(self._mo.friendInfo.time)
	end

	self._txtstatus.text = luaLang("social_online")

	self:_loadBg()
	gohelper.setActive(self._gotimeout, false)
	gohelper.setActive(self._btnagree.gameObject, true)
	gohelper.setActive(self._btnreject.gameObject, true)
	gohelper.setActive(self._txtungroup.gameObject, false)
	gohelper.setActive(self._btninvite.gameObject, false)
	gohelper.setActive(self._gogrouped, false)
	self:_updateRole()
end

function MiniPartyInviteCheckItem:_updateRole()
	if not self._playerMo.infos then
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

function MiniPartyInviteCheckItem:getHeroIcon(index)
	if not self._heros[index] then
		local roleGo = self["_gorole" .. index]
		local go = gohelper.findChild(roleGo, "heroitem")

		self._heros[index] = MonoHelper.addNoUpdateLuaComOnceToGo(go, SocialHeroItem)
	end

	return self._heros[index]
end

function MiniPartyInviteCheckItem:_loadBg()
	if not self._playerMo.bg or self._playerMo.bg == 0 then
		self._hasSkin = false
	else
		self._hasSkin = true

		if not self._lastSkinId or self._lastSkinId ~= self._playerMo.bg then
			self._skinPath = string.format("ui/viewres/social/socialsearchitem_bg_%s.prefab", self._playerMo.bg)

			self:_disposeBg()

			self._loader = MultiAbLoader.New()

			self._loader:addPath(self._skinPath)
			self._loader:startLoad(self._onLoadFinish, self)
		end
	end

	gohelper.setActive(self._goskinbg, self._hasSkin)
end

function MiniPartyInviteCheckItem:_disposeBg()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	if self._goskinEffect then
		gohelper.destroy(self._goskinEffect)

		self._goskinEffect = nil
	end
end

function MiniPartyInviteCheckItem:_onLoadFinish()
	local assetItem = self._loader:getAssetItem(self._skinPath)
	local viewPrefab = assetItem:GetResource(self._skinPath)

	self._goskinEffect = gohelper.clone(viewPrefab, self._goskinbg)
	self._lastSkinId = self._mo.friendInfo.bg
end

function MiniPartyInviteCheckItem:destroy()
	TaskDispatcher.cancelTask(self._startShowSwitch, self)
	self:_disposeBg()
	self:_removeEvents()
end

return MiniPartyInviteCheckItem
