-- chunkname: @modules/logic/playercard/view/PlayerCardSkinPreView.lua

module("modules.logic.playercard.view.PlayerCardSkinPreView", package.seeall)

local PlayerCardSkinPreView = class("PlayerCardSkinPreView", LuaCompBase)

function PlayerCardSkinPreView:init(go)
	self.viewGO = go
	self._isopen = false

	self:onInitView()
	self:addEvents()
	self:initView()
end

function PlayerCardSkinPreView:onInitView()
	self._btndetail = gohelper.findChildButton(self.viewGO, "#btn_detail")
	self._gosocialfrienditemnode = gohelper.findChild(self.viewGO, "#btn_detail/#go_socialfrienditem")
	self._gochat = gohelper.findChild(self.viewGO, "#go_chat")
	self._btnclose = gohelper.findChildButton(self.viewGO, "#go_chat/#btn_close")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_chat/#simage_chatbg")
	self._gobg = gohelper.findChild(self.viewGO, "#go_chat/#simage_chatbg")
	self._goSkinbg = gohelper.findChild(self.viewGO, "#go_chat/#go_skinbg")

	gohelper.setActive(self._gochat, self._isopen)
end

function PlayerCardSkinPreView:addEvents()
	self.addClickCb(self, self._btndetail, self.onClickDetail, self)
	self.addClickCb(self, self._btnclose, self.onClickDetail, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.SwitchTheme, self.onSwitchView, self)
end

function PlayerCardSkinPreView:removeEvents()
	self.removeClickCb(self, self._btndetail, self.onClickDetail, self)
	self.removeClickCb(self, self._btnclose, self.onClickDetail, self)
	self.removeEventCb(self, PlayerCardController.instance, PlayerCardEvent.SwitchTheme, self.onSwitchView, self)
end

function PlayerCardSkinPreView:onClickDetail()
	self._isopen = not self._isopen

	gohelper.setActive(self._gochat, self._isopen)
end

function PlayerCardSkinPreView:initView()
	if self.viewParam then
		self._skinId = self.viewParam or PlayerCardModel.instance:getPlayerCardSkinId()
		self._itemPath = "ui/viewres/social/socialfrienditem.prefab"
		self._loader = MultiAbLoader.New()

		if self._skinId and self._skinId ~= 0 then
			self._hasSkin = true
			self._skinPath = string.format("ui/viewres/player/playercard/playercardskinpreview_%s.prefab", self._skinId)

			self._loader:addPath(self._skinPath)
		else
			self._hasSkin = false
		end

		gohelper.setActive(self._goSkinbg, self._hasSkin)
		gohelper.setActive(self._gobg, not self._hasSkin)
		self._loader:addPath(self._itemPath)
		self._loader:startLoad(self._onLoadFinish, self)

		self._selectMo = PlayerCardModel.instance:getSelectSkinMO()
	end
end

function PlayerCardSkinPreView:switchSkin(skinid)
	gohelper.destroy(self._goskinEffect)

	self._switchskinloader = MultiAbLoader.New()

	if skinid and skinid ~= 0 then
		self._hasSkin = true
		self._skinPath = string.format("ui/viewres/player/playercard/playercardskinpreview_%s.prefab", skinid)

		self._loader:addPath(self._skinPath)
	else
		self._hasSkin = false
	end

	gohelper.setActive(self._gobg, not self._hasSkin)
	gohelper.setActive(self._goSkinbg, self._hasSkin)
	gohelper.setActive(self._gosocialfrienditem, false)
	self._switchskinloader:addPath(self._skinPath)
	self._switchskinloader:startLoad(self._onLoadSkinFinish, self)
end

function PlayerCardSkinPreView:_onLoadSkinFinish()
	local skinAssetItem = self._switchskinloader:getAssetItem(self._skinPath)
	local skinPrefab = skinAssetItem:GetResource(self._skinPath)

	self._goskinEffect = gohelper.clone(skinPrefab, self._goSkinbg)

	gohelper.setActive(self._gosocialfrienditem, true)
end

function PlayerCardSkinPreView:updateBg()
	local bgPath = "img_chat_bg.png"

	self._simagebg:LoadImage(ResUrl.getSocialIcon(bgPath))
end

function PlayerCardSkinPreView:updateItem()
	self._socialfrienditemcls:selectSkin(self._selectMo.id)
end

function PlayerCardSkinPreView:_onLoadFinish()
	if self._hasSkin then
		local skinAssetItem = self._loader:getAssetItem(self._skinPath)
		local skinPrefab = skinAssetItem:GetResource(self._skinPath)

		self._goskinEffect = gohelper.clone(skinPrefab, self._goSkinbg)
	end

	local assetItem = self._loader:getAssetItem(self._itemPath)
	local viewPrefab = assetItem:GetResource(self._itemPath)

	self._gosocialfrienditem = gohelper.clone(viewPrefab, self._gosocialfrienditemnode)
	self._socialfrienditemcls = MonoHelper.addNoUpdateLuaComOnceToGo(self._gosocialfrienditem, SocialFriendItem)

	local selfInfo = PlayerModel.instance:getPlayinfo()
	local mo = {
		time = 0,
		userId = selfInfo.userId,
		name = selfInfo.name,
		level = selfInfo.level,
		portrait = selfInfo.portrait
	}

	if self.viewParam then
		if not self.viewParam.skinId then
			local skinId = PlayerCardModel.instance:getPlayerCardSkinId()

			self._socialfrienditemcls:onUpdateMO(mo)
			self._socialfrienditemcls:selectSkin(skinId)
		end
	end
end

function PlayerCardSkinPreView:onSwitchView(newSkinId)
	self._selectMo = PlayerCardModel.instance:getSelectSkinMO()

	if self._selectMo.id ~= 0 then
		gohelper.setActive(self._goSkinbg, true)
		gohelper.setActive(self._gobg, false)

		if self._selectMo.id ~= self._skinId then
			self._skinId = self._selectMo.id

			self:switchSkin(self._skinId)
			self._socialfrienditemcls:selectSkin(self._skinId)
		end
	else
		gohelper.setActive(self._goSkinbg, false)
		gohelper.setActive(self._gobg, true)
		self._socialfrienditemcls:selectSkin(self._selectMo.id)

		self._skinId = self._selectMo.id
	end
end

function PlayerCardSkinPreView:onHide()
	if self.viewParam then
		if not self.viewParam.skinId then
			local skinId = PlayerCardModel.instance:getPlayerCardSkinId()

			if self._skinId ~= skinId then
				self:switchSkin(skinId)

				self._skinId = skinId
			end

			self._socialfrienditemcls:selectSkin(skinId)
		end
	end
end

function PlayerCardSkinPreView:onDestroy()
	self:removeEvents()

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	if self._socialfrienditemcls then
		self._socialfrienditemcls:onDestroy()

		self._socialfrienditemcls = nil
	end

	gohelper.destroy(self._gosocialfrienditem)
end

return PlayerCardSkinPreView
