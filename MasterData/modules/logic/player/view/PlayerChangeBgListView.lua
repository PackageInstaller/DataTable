-- chunkname: @modules/logic/player/view/PlayerChangeBgListView.lua

module("modules.logic.player.view.PlayerChangeBgListView", package.seeall)

local PlayerChangeBgListView = class("PlayerChangeBgListView", BaseView)

function PlayerChangeBgListView:onInitView()
	self._goRoot = gohelper.findChild(self.viewGO, "root")
	self._btnHide = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_bottom/#btn_hide")
	self._gobottom = gohelper.findChild(self.viewGO, "root/#go_bottom")
	self._goitem = gohelper.findChild(self.viewGO, "root/#go_bottom/bottom/#scroll_bg/Viewport/Content/#go_item")
	self._goitemparent = self._goitem.transform.parent.gameObject
	self._golock = gohelper.findChild(self.viewGO, "root/#go_bottom/bottom/#go_lock")
	self._gocur = gohelper.findChild(self.viewGO, "root/#go_bottom/bottom/#go_curbg")
	self._btnChange = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_bottom/bottom/#btn_change")
	self._txtbgname = gohelper.findChildTextMesh(self.viewGO, "root/#go_bottom/top/namebg/#txt_bgName")
	self._txtbgdesc = gohelper.findChildTextMesh(self.viewGO, "root/#go_bottom/top/#txt_bgdesc")
	self._gobglock = gohelper.findChild(self.viewGO, "root/#go_bottom/top/#go_lock")
	self._txtbglock = gohelper.findChildTextMesh(self.viewGO, "root/#go_bottom/top/#go_lock/#txt_lock")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function PlayerChangeBgListView:addEvents()
	self._btnHide:AddClickListener(self._hideRoot, self)
	self._btnChange:AddClickListener(self._changeBg, self)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, self._onTouchScreen, self)
	PlayerController.instance:registerCallback(PlayerEvent.ChangeBgTab, self.onBgTabIndexChange, self)
	PlayerController.instance:registerCallback(PlayerEvent.ChangePlayerinfo, self._onPlayerInfoChange, self)
end

function PlayerChangeBgListView:removeEvents()
	self._btnHide:RemoveClickListener()
	self._btnChange:RemoveClickListener()
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, self._onTouchScreen, self)
	PlayerController.instance:unregisterCallback(PlayerEvent.ChangeBgTab, self.onBgTabIndexChange, self)
	PlayerController.instance:unregisterCallback(PlayerEvent.ChangePlayerinfo, self._onPlayerInfoChange, self)
end

function PlayerChangeBgListView:onOpen()
	PostProcessingMgr.instance:setBlurWeight(1)

	if self.viewParam and self.viewParam.itemMo then
		recthelper.setAnchorY(self._gobottom.transform, -109)
		self:onSelectBg(self.viewParam.bgCo)
	else
		recthelper.setAnchorY(self._gobottom.transform, 202)

		local data = lua_player_bg.configList
		local selectIndex = self.viewParam.selectIndex

		self._selectIndex = selectIndex

		self:onSelectBg(data[selectIndex])
		gohelper.CreateObjList(self, self._createItem, data, self._goitemparent, self._goitem, PlayerChangeBgItem)
		self:updateApplyStatus()
	end

	self:playOpenAnim()
end

function PlayerChangeBgListView:updateApplyStatus()
	if self.viewParam and self.viewParam.itemMo then
		return
	end

	local nowSelectData = lua_player_bg.configList[self._selectIndex]

	if not nowSelectData then
		return
	end

	local isUnlock = true
	local info = PlayerModel.instance:getPlayinfo()

	if nowSelectData.item ~= 0 then
		local quantity = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, nowSelectData.item)

		isUnlock = quantity > 0
	end

	gohelper.setActive(self._golock, not isUnlock)
	gohelper.setActive(self._gocur, isUnlock and info.bg == nowSelectData.item)
	gohelper.setActive(self._btnChange, isUnlock and info.bg ~= nowSelectData.item)
end

function PlayerChangeBgListView:onBgTabIndexChange(index)
	self._selectIndex = index

	self:onSelectBg(lua_player_bg.configList[index])
	self:updateApplyStatus()
end

function PlayerChangeBgListView:_onPlayerInfoChange()
	self:updateApplyStatus()
end

function PlayerChangeBgListView:_changeBg()
	local nowSelectData = lua_player_bg.configList[self._selectIndex]

	if not nowSelectData then
		return
	end

	PlayerRpc.instance:sendSetPlayerBgRequest(nowSelectData.item)
end

function PlayerChangeBgListView:_createItem(obj, data, index)
	obj:initMo(data, index, self._selectIndex)
end

function PlayerChangeBgListView:onSelectBg(bgCo)
	local isUnlock = true

	if bgCo.item ~= 0 then
		local quantity = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, bgCo.item)

		isUnlock = quantity > 0
	end

	self._txtbgname.text = bgCo.name

	if isUnlock then
		self._txtbgdesc.text = bgCo.desc

		gohelper.setActive(self._gobglock, false)
	else
		self._txtbgdesc.text = ""
		self._txtbglock.text = bgCo.lockdesc

		gohelper.setActive(self._gobglock, true)
	end
end

function PlayerChangeBgListView:playOpenAnim()
	if self.viewParam and self.viewParam.itemMo then
		self._anim:Play("up")
	else
		self._anim:Play("open")
	end
end

function PlayerChangeBgListView:playCloseAnim()
	if self.viewParam and self.viewParam.itemMo then
		self._anim:Play("down")
	else
		self._anim:Play("close")
	end
end

function PlayerChangeBgListView:_hideRoot()
	self._isHide = true

	self:playCloseAnim()
	PlayerController.instance:dispatchEvent(PlayerEvent.ShowHideRoot, false)
end

function PlayerChangeBgListView:_delayEndBlock()
	UIBlockMgr.instance:endBlock("PlayerChangeBgListView_ShowRoot")
end

function PlayerChangeBgListView:onClose()
	TaskDispatcher.cancelTask(self._delayEndBlock, self)
	UIBlockMgr.instance:endBlock("PlayerChangeBgListView_ShowRoot")
end

function PlayerChangeBgListView:_onTouchScreen()
	if self._isHide then
		TaskDispatcher.runDelay(self._delayEndBlock, self, 0.33)
		UIBlockMgr.instance:startBlock("PlayerChangeBgListView_ShowRoot")
		self:playOpenAnim()
		PlayerController.instance:dispatchEvent(PlayerEvent.ShowHideRoot, true)
	end

	self._isHide = false
end

return PlayerChangeBgListView
