-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/miniparty/view/MiniPartyGroupItem.lua

module("modules.logic.versionactivity3_4.laplaceforum.miniparty.view.MiniPartyGroupItem", package.seeall)

local MiniPartyGroupItem = class("MiniPartyGroupItem", LuaCompBase)

function MiniPartyGroupItem:init(go)
	self.go = go
	self._gohas = gohelper.findChild(self.go, "has")
	self._gonormal = gohelper.findChild(self.go, "has/go_normal")
	self._gobg = gohelper.findChild(self.go, "has/go_normal/go_bg")
	self._gobgselect = gohelper.findChild(self.go, "has/go_normal/go_bgselect")
	self._goskinbg = gohelper.findChild(self.go, "has/go_skinbg")
	self._gofriendreddot = gohelper.findChild(self.go, "has/go_friendreddot")
	self._txtchenghao = gohelper.findChildText(self.go, "has/chenghao/txt_chenghao")
	self._txtstatus = gohelper.findChildText(self.go, "has/status/txt_status")
	self._txtofflinetime = gohelper.findChildText(self.go, "has/status/txt_offlinetime")
	self._txtname = gohelper.findChildText(self.go, "has/name/txt_name")
	self._txtnameoffline = gohelper.findChildText(self.go, "has/name/txt_nameoffline")
	self._goplayericon = gohelper.findChild(self.go, "has/go_playericon")
	self._goempty = gohelper.findChild(self.go, "empty")
	self._btnclick = gohelper.findChildButtonWithAudio(self.go, "empty")
	self._playericon = IconMgr.instance:getCommonPlayerIcon(self._goplayericon)
	self._itemAnim = self.go:GetComponent(typeof(UnityEngine.Animator))
	self._hasGrouped = MiniPartyModel.instance:hasGrouped()

	self:_addEvents()
end

function MiniPartyGroupItem:_addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function MiniPartyGroupItem:_removeEvents()
	self._btnclick:RemoveClickListener()
end

function MiniPartyGroupItem:_btnclickOnClick()
	local hasGrouped = MiniPartyModel.instance:hasGrouped()

	if hasGrouped then
		return
	end

	LaplaceForumController.instance:openLaplaceMiniPartyInviteView()
end

function MiniPartyGroupItem:refresh(index)
	self._index = index

	if self._index == 1 then
		self:_refreshSelf()
	elseif self._index == 2 then
		self:_refreshTeammate()
	else
		gohelper.setActive(self.go, false)
	end
end

function MiniPartyGroupItem:_refreshSelf()
	self._itemAnim:Play("idle")
	gohelper.setActive(self.go, true)

	local playerInfo = PlayerModel.instance:getPlayinfo()

	self._playericon:setEnableClick()
	self._playericon:onUpdateMO(playerInfo)
	self._playericon:setShowLevel(true)

	local uidString = tostring(playerInfo.userId)
	local uidLength = GameUtil.utf8len(uidString)

	self._txtname.text = string.format("%s#%s", playerInfo.name, (uidLength > 3 or nil) and GameUtil.utf8sub(uidString, uidLength - 2, uidLength))

	gohelper.setActive(self._txtstatus.gameObject, false)
	gohelper.setActive(self._txtofflinetime.gameObject, false)
end

function MiniPartyGroupItem:_refreshTeammate()
	gohelper.setActive(self.go, true)

	local hasGrouped = MiniPartyModel.instance:hasGrouped()

	if hasGrouped then
		if self._hasGrouped then
			self._itemAnim:Play("idle")
		else
			self._itemAnim:Play("switch", 0, 0)
		end
	elseif self._hasGrouped then
		self._itemAnim:Play("switch2", 0, 0)
	else
		self._itemAnim:Play("idle2")
	end

	self._hasGrouped = hasGrouped

	gohelper.setActive(self._goempty, not hasGrouped)
	gohelper.setActive(self._gohas, hasGrouped)

	if hasGrouped then
		local teammateInfo = MiniPartyModel.instance:getTeammateInfo()
		local playerMo = teammateInfo

		self._playericon:onUpdateMO(playerMo)
		self._playericon:setShowLevel(true)

		local uidString = tostring(teammateInfo.userId)
		local uidLength = GameUtil.utf8len(uidString)

		self._txtname.text = string.format("%s#%s", teammateInfo.name, (uidLength > 3 or nil) and GameUtil.utf8sub(uidString, uidLength - 2, uidLength))

		local isOnline = teammateInfo.isOnline

		gohelper.setActive(self._txtstatus, isOnline)
		gohelper.setActive(self._txtofflinetime, not isOnline)

		if not isOnline then
			self._txtofflinetime.text = SocialConfig.instance:getStatusText(1000 * teammateInfo.datetime)
		end

		self._txtstatus.text = luaLang("social_online")
	end
end

function MiniPartyGroupItem:destroy()
	self:_removeEvents()
end

return MiniPartyGroupItem
