-- chunkname: @modules/logic/player/view/PlayerChangeBgView.lua

module("modules.logic.player.view.PlayerChangeBgView", package.seeall)

local PlayerChangeBgView = class("PlayerChangeBgView", BaseView)

function PlayerChangeBgView:onInitView()
	self._gobg = gohelper.findChild(self.viewGO, "#go_bgroot")
	self._goRoot = gohelper.findChild(self.viewGO, "root")
	self._goFriend = gohelper.findChild(self.viewGO, "root/#go_topright/#go_friend")
	self._btnFriend = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_topright/btn_friend")
	self._txtname = gohelper.findChildTextMesh(self.viewGO, "root/#go_topright/#go_friend/#go_item1/#txt_name")
	self._txtname2 = gohelper.findChildTextMesh(self.viewGO, "root/#go_topright/#go_friend/#go_item2/#txt_name")
	self._txtonline = gohelper.findChildTextMesh(self.viewGO, "root/#go_topright/#go_friend/#go_item1/#txt_online")
	self._txtLv = gohelper.findChildTextMesh(self.viewGO, "root/#go_topright/#go_friend/#go_item1/headframe/bg/#txt_lv")
	self._txtLv2 = gohelper.findChildTextMesh(self.viewGO, "root/#go_topright/#go_friend/#go_item2/#txt_lv")
	self._simagehead = gohelper.findChildSingleImage(self.viewGO, "root/#go_topright/#go_friend/#go_item1/headframe/#simage_headicon")
	self._simagehead2 = gohelper.findChildSingleImage(self.viewGO, "root/#go_topright/#go_friend/#go_item2/headframe/#simage_headicon")
	self._godefaultbg = gohelper.findChild(self.viewGO, "root/#go_topright/#go_friend/#go_item1/#go_bgdefault")
	self._godefaultbg2 = gohelper.findChild(self.viewGO, "root/#go_topright/#go_friend/#go_item2/#go_bgdefault")
	self._bg1 = gohelper.findChildSingleImage(self.viewGO, "root/#go_topright/#go_friend/bg2")
	self._bg2 = gohelper.findChildSingleImage(self.viewGO, "root/#go_topright/#go_friend/#go_item1/bg2")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PlayerChangeBgView:addEvents()
	self._btnFriend:AddClickListener(self._showHideFriend, self)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, self._onTouchScreen, self)
	PlayerController.instance:registerCallback(PlayerEvent.ChangeBgTab, self.onBgTabIndexChange, self)
	PlayerController.instance:registerCallback(PlayerEvent.ShowHideRoot, self.showHideRoot, self)
end

function PlayerChangeBgView:removeEvents()
	self._btnFriend:RemoveClickListener()
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, self._onTouchScreen, self)
	PlayerController.instance:unregisterCallback(PlayerEvent.ChangeBgTab, self.onBgTabIndexChange, self)
	PlayerController.instance:unregisterCallback(PlayerEvent.ShowHideRoot, self.showHideRoot, self)
end

function PlayerChangeBgView:_editableInitView()
	self._bgComp = MonoHelper.addLuaComOnceToGo(self._gobg, PlayerBgComp)
end

function PlayerChangeBgView:onOpen()
	if not self.viewParam then
		if self.viewParam.bgComp then
			gohelper.destroy(self._gobg)

			self._bgComp = self.viewParam.bgComp

			self._bgComp.go.transform:SetParent(self.viewGO.transform, false)
			self._bgComp.go.transform:SetSiblingIndex(0)
		end

		local info = PlayerModel.instance:getPlayinfo()

		gohelper.setActive(self._goFriend, false)

		if self.viewParam and self.viewParam.itemMo then
			local bgCo = PlayerConfig.instance:getBgCo(self.viewParam.itemMo.id)

			self.viewParam.bgCo = bgCo

			self:onSelectBg(bgCo)
		else
			local data = lua_player_bg.configList
			local selectIndex = 1

			for i = 1, #data do
				if data[i].item == info.bg then
					selectIndex = i

					break
				end
			end

			self.viewParam.bgCo = data[selectIndex]
			self.viewParam.selectIndex = selectIndex
			self._selectIndex = selectIndex

			self:onSelectBg(data[selectIndex])
		end

		ViewMgr.instance:openView(ViewName.PlayerChangeBgListView, self.viewParam)

		self._txtname.text = info.name
		self._txtname2.text = info.name
		self._txtonline.text = luaLang("social_online")
		self._txtLv.text = "Lv." .. info.level
		self._txtLv2.text = formatLuaLang("playerchangebgview_namelv", info.level)

		local portrait = info.portrait

		self._liveHeadIcon = self._liveHeadIcon or IconMgr.instance:getCommonLiveHeadIcon(self._simagehead)

		self._liveHeadIcon:setLiveHead(portrait)

		self._liveHeadIcon2 = self._liveHeadIcon2 or IconMgr.instance:getCommonLiveHeadIcon(self._simagehead2)

		self._liveHeadIcon2:setLiveHead(portrait)
		self._anim:Play("open")
	end
end

function PlayerChangeBgView:onBgTabIndexChange(index)
	if index ~= self._selectIndex then
		gohelper.setActive(self.viewGO, false)
		gohelper.setActive(self.viewGO, true)
		self._anim:Play("switch", 0, 0)
	end

	self._selectIndex = index

	UIBlockMgr.instance:startBlock("PlayerChangeBgView_switch")
	TaskDispatcher.runDelay(self._delayShowBg, self, 0.16)
end

function PlayerChangeBgView:_delayShowBg()
	UIBlockMgr.instance:endBlock("PlayerChangeBgView_switch")
	self:onSelectBg(lua_player_bg.configList[self._selectIndex])
end

function PlayerChangeBgView:onSelectBg(bgCo)
	self._bgComp:showBg(bgCo)

	local isUnlock = true

	if bgCo.item ~= 0 then
		local quantity = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, bgCo.item)

		isUnlock = quantity > 0
	end

	gohelper.setActive(self._godefaultbg, bgCo.item == 0)
	gohelper.setActive(self._godefaultbg2, bgCo.item == 0)

	if bgCo.item ~= 0 then
		self._bg1:LoadImage(string.format("singlebg/playerinfo/%s.png", bgCo.infobg))
		self._bg2:LoadImage(string.format("singlebg/playerinfo/%s.png", bgCo.chatbg))
	end
end

function PlayerChangeBgView:_showHideFriend()
	gohelper.setActive(self._goFriend, not self._goFriend.activeSelf)
end

function PlayerChangeBgView:showHideRoot(isShow)
	if isShow then
		self._anim:Play("open")
	else
		self._anim:Play("close")
	end
end

function PlayerChangeBgView:_onTouchScreen()
	if self._goFriend.activeSelf then
		local trans = self._btnFriend.transform
		local mousePosition = GamepadController.instance:getMousePosition()
		local width = recthelper.getWidth(trans)
		local height = recthelper.getHeight(trans)
		local touchPos = recthelper.screenPosToAnchorPos(mousePosition, trans)

		if touchPos.x >= -width / 2 and touchPos.x <= width / 2 and touchPos.y <= height / 2 and touchPos.y >= -height / 2 then
			return
		end

		gohelper.setActive(self._goFriend, false)
	end
end

function PlayerChangeBgView:onClose()
	UIBlockMgr.instance:endBlock("PlayerChangeBgView_switch")
	self._anim:Play("close")
	ViewMgr.instance:closeView(ViewName.PlayerChangeBgListView)
	self._simagehead:UnLoadImage()
	self._simagehead2:UnLoadImage()
	self._bg1:UnLoadImage()
	self._bg2:UnLoadImage()
end

return PlayerChangeBgView
