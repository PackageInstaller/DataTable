-- chunkname: @modules/logic/social/view/SocialSearchItem.lua

module("modules.logic.social.view.SocialSearchItem", package.seeall)

local SocialSearchItem = class("SocialSearchItem", ListScrollCellExtend)

function SocialSearchItem:onInitView()
	self._goplayericon = gohelper.findChild(self.viewGO, "#go_playericon")
	self._goskinbg = gohelper.findChild(self.viewGO, "#go_skinbg")
	self._imagebg = gohelper.findChildImage(self.viewGO, "image_ItemBG")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._txtuid = gohelper.findChildText(self.viewGO, "#txt_uid")
	self._txtstatus = gohelper.findChildText(self.viewGO, "status/#txt_status")
	self._txtofflinetime = gohelper.findChildText(self.viewGO, "status/#txt_offlinetime")
	self._goofflinebg = gohelper.findChild(self.viewGO, "status/bg")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_add")
	self._gosent = gohelper.findChild(self.viewGO, "#go_sent")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._anim.keepAnimatorStateOnDisable = true

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SocialSearchItem:addEvents()
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
end

function SocialSearchItem:removeEvents()
	self._btnadd:RemoveClickListener()
end

function SocialSearchItem:_btnaddOnClick()
	SocialController.instance:AddFriend(self._mo.userId, self._addCallback, self)
end

function SocialSearchItem:_addCallback(cmd, resultCode, msg)
	if resultCode == 0 or resultCode == -310 then
		self._mo:setAddedFriend()
		gohelper.setActive(self._btnadd.gameObject, false)
		gohelper.setActive(self._gosent, true)
	end
end

function SocialSearchItem:_editableInitView()
	self._heros = {}
	self._heroParents = self:getUserDataTb_()

	for i = 1, 3 do
		self._heroParents[i] = gohelper.findChild(self.viewGO, "Role/" .. i)
	end

	gohelper.addUIClickAudio(self._btnadd.gameObject, AudioEnum.UI.UI_Common_Click)

	self._playericon = IconMgr.instance:getCommonPlayerIcon(self._goplayericon)
end

function SocialSearchItem:_refreshUI()
	self._playericon:onUpdateMO(self._mo)
	self._playericon:setShowLevel(true)

	local uidString = tostring(self._mo.userId)
	local uidLength = GameUtil.utf8len(uidString)

	self._txtname.text = string.format("%s#%s", self._mo.name, (uidLength > 3 or nil) and GameUtil.utf8sub(uidString, uidLength - 2, uidLength))
	self._txtuid.text = string.format(uidString)

	local isAdded = self._mo:isSendAddFriend()
	local isOnline = tonumber(self._mo.time) == 0

	gohelper.setActive(self._btnadd, not isAdded)
	gohelper.setActive(self._gosent, isAdded)
	gohelper.setActive(self._txtstatus, isOnline)
	gohelper.setActive(self._txtofflinetime, not isOnline)

	if not isOnline then
		self._txtofflinetime.text = SocialConfig.instance:getStatusText(self._mo.time)
	end

	gohelper.setActive(self._goofflinebg, not isOnline)

	self._txtstatus.text = luaLang("social_online")

	self:_loadBg()
end

function SocialSearchItem:_loadBg()
	if not self._mo.bg or self._mo.bg == 0 then
		self._hasSkin = false
	else
		self._hasSkin = true

		if not self.lastskinId or self.lastskinId ~= self._mo.bg then
			self._skinPath = string.format("ui/viewres/social/socialsearchitem_bg_%s.prefab", self._mo.bg)

			self:_disposeBg()

			self._loader = MultiAbLoader.New()

			self._loader:addPath(self._skinPath)
			self._loader:startLoad(self._onLoadFinish, self)
		end
	end

	gohelper.setActive(self._imagebg.gameObject, not self._hasSkin)
	gohelper.setActive(self._goskinbg, self._hasSkin)
end

function SocialSearchItem:_disposeBg()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	if self._goskinEffect then
		gohelper.destroy(self._goskinEffect)

		self._goskinEffect = nil
	end
end

function SocialSearchItem:_onLoadFinish()
	local assetItem = self._loader:getAssetItem(self._skinPath)
	local viewPrefab = assetItem:GetResource(self._skinPath)

	self._goskinEffect = gohelper.clone(viewPrefab, self._goskinbg)
	self.lastskinId = self._mo.bg
end

function SocialSearchItem:onUpdateMO(mo)
	local timeSpan = UnityEngine.Time.realtimeSinceStartup - SocialModel.instance.playSearchItemAnimDt

	TaskDispatcher.cancelTask(self._delayPlaySwtich, self)
	gohelper.setActive(self.viewGO, true)

	local time = timeSpan - (self._index - 1) * 0.1

	if time >= 0.5 then
		self._anim:Play("open", 0, 1)
	elseif time < 0 then
		gohelper.setActive(self.viewGO, false)
		TaskDispatcher.runDelay(self._delayPlaySwtich, self, -time)
	else
		self._anim:Play("switch", 0, time)
	end

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

function SocialSearchItem:_delayPlaySwtich()
	gohelper.setActive(self.viewGO, true)
	self._anim:Play("switch", 0, 0)
	self._anim:Update(0)
end

function SocialSearchItem:getHeroIcon(index)
	if not self._heros[index] then
		local go = self._view:getResInst("ui/viewres/social/socialheroitem.prefab", self._heroParents[index], "HeroItem")

		self._heros[index] = MonoHelper.addNoUpdateLuaComOnceToGo(go, SocialHeroItem)
	end

	return self._heros[index]
end

function SocialSearchItem:onDestroy()
	TaskDispatcher.cancelTask(self._delayPlaySwtich, self)
end

return SocialSearchItem
