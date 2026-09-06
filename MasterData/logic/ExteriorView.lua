-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/ExteriorView.lua

module("logic.extensions.roleinfo.view.ExteriorView", package.seeall)

local ExteriorView = class("ExteriorView", ViewComponent)

function ExteriorView:ctor()
	ExteriorView.super.ctor(self)
end

function ExteriorView:unbindEvents()
	ExteriorView.super.unbindEvents(self)

	for i, v in ipairs(self._btnFiters) do
		GameUtil.rmClickHandler(v.btn)
	end

	GameUtil.rmClickHandler(self._btnVisible)
	GameUtil.rmClickHandler(self._btnUse)
	self._btnShow:RemoveClickListener()
end

function ExteriorView:bindEvents()
	ExteriorView.super.bindEvents(self)

	for i, v in ipairs(self._btnFiters) do
		GameUtil.addClickHandler(v.btn, GameUtil.handler(self._onClickRefreshInfo, self, i))
	end

	GameUtil.addClickHandler(self._btnVisible, self._onClickVisible, self)
	GameUtil.addClickHandler(self._btnUse, self._onClickUse, self)
	self._btnShow:AddClickListener(self._onClickbtnShow, self)
end

function ExteriorView:buildUI()
	ExteriorView.super.buildUI(self)

	self._previewImg = self:getGo("preview/img")
	self._btnVisible = self:getBtn("info/state/btnVisible")
	self._btnUse = self:getBtn("info/state/btnUse")
	self._txtOwn = self:getTxt("own/txt")
	self._txtUse = self:getTxt("info/state/btnUse/txt")
	self._visibleSelect = self:getGo("info/state/btnVisible/select")
	self._btnFiters = {}

	for i = 1, 5 do
		local data = {}

		data.btn = self:getBtn("fiters/tableview/viewport/content/btn_" .. i)
		data.select = self:getGo("fiters/tableview/viewport/content/btn_" .. i .. "/imgSelect")

		table.insert(self._btnFiters, data)
	end

	self._tableViewGo = self:getGo("info/anims/tableview")
	self._cellGo = self:getGo("info/anims/cell")
	self._tableview = ScrollerList.create(self._tableViewGo, self._cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._spinePos = self:getGo("preview/spinePos")
	self._spineBg = self:getGo("preview/spineBg")
	self._btnShow = self:getBtn("btnShow")
	self._con = self:getGo("displayGo/con")
	self._preview = self:getGo("preview")
end

function ExteriorView:onExit()
	ExteriorView.super.onExit(self)
	UIStateManager.instance:popByName(ViewName.playerInfo)
	self:showTabAt(self._con, "")

	self._cfgs = nil
	self._selectId = 1
	self._selectCell = nil

	self._tableview:dispose()
	uGuiUtil.clearImage(self._previewImg)

	if self._loaderSpine then
		self._loaderSpine:clear()
	end

	uGuiUtil.clearImage(self._spineBg)
end

function ExteriorView:onEnter()
	ExteriorView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.LoadAllUniquePropsRes, self._refresh, self)
	self.addGEvent(self, GlobalNotify.UseUniquePropRes, self._refreshState, self)
	self.addGEvent(self, GlobalNotify.NotifyUniquePropChangeRes, self._refreshState, self)

	self._cfgs = nil
	self._selectId = ExteriorController.instance:getCurrExteriorSelectId() or 1
	self._selectCell = nil

	for i, v in ipairs(self._btnFiters) do
		GameUtil.SetActive(v.select, i == self._selectId)
	end

	BattleStartAnimController.instance:sendPM_LoadAllUniquePropsReq()
end

function ExteriorView:_refresh()
	self:_onClickRefreshInfo(self._selectId)
end

function ExteriorView:_updateData()
	local data = {}
	local index = 1
	local hasCount = 1

	if self._selectId == 1 then
		self._matType = MatType.OpeningEffect
		self._cfgs = BattleStartAnimConfig.instance:getOpeningEffectCfgList()

		local tem = {}

		for i, v in ipairs(self._cfgs) do
			if checknumber(v.notOnline) == 0 then
				table.insert(tem, v)
			end
		end

		self._cfgs = tem
		self._isSeeSelf = BattleStartAnimController.instance:isSeeSelfBattleStartAnim()

		GameUtil.SetActive(self._visibleSelect, self._isSeeSelf)
	elseif self._selectId == 2 then
		self._matType = MatType.HomePageBg
		self._cfgs = BattleStartAnimConfig.instance:getHomePageBgCfgList()
	elseif self._selectId == 3 then
		self._matType = MatType.PlayerMessageSkin
		self._cfgs = BattleStartAnimConfig.instance:getPlayerMessageSkinCfg()
	elseif self._selectId == 4 then
		self._matType = MatType.BattleBackgroundSkin
		self._cfgs = BattleStartAnimConfig.instance:getBattleBackgroundSkinCfgs()
		self._isSeeSelf = BattleStartAnimController.instance:isSeeSelfBattleBg()

		GameUtil.SetActive(self._visibleSelect, self._isSeeSelf)
	elseif self._selectId == 5 then
		self._matType = MatType.BattleUserInterfaceSkin
		self._cfgs = BattleStartAnimConfig.instance:getBattleUISkinCfgs()
	end

	for i, v in ipairs(self._cfgs) do
		local cellInfo = {}

		cellInfo.id = i
		cellInfo.cfg = v
		cellInfo.state = BattleStartAnimModel.instance:getState(self._matType, v.id)
		cellInfo.isSelected = cellInfo.state == BattleStartAnimModel.Using

		if cellInfo.isSelected == BattleStartAnimModel.Using then
			index = i
		end

		if cellInfo.state == BattleStartAnimModel.Unuse then
			hasCount = hasCount + 1
		end

		table.insert(data, cellInfo)
	end

	table.sort(data, function(a, b)
		if a.state ~= b.state then
			return a.state > b.state
		end

		if a.cfg.sortValue and b.cfg.sortValue then
			return a.cfg.sortValue > b.cfg.sortValue
		end
	end)

	self._selectCell = data[index]

	self._tableview:reloadData(data)
	self:_onClickCell(self._selectCell)

	self._txtOwn.text = string.format("<color=20b376>%s</color>/%s", hasCount, #self._cfgs)
end

function ExteriorView:_refreshState()
	self:_updateData()

	self._txtUse.text = BattleStartAnimModel.BtnText[self._selectCell.state]
end

function ExteriorView:_updateCell(view, cell, data)
	local img = goutil.findChild(cell, "img")
	local imgQuality = goutil.findChild(cell, "imgQuality")
	local lock = goutil.findChild(cell, "lock")
	local using = goutil.findChild(cell, "using")
	local select = goutil.findChild(cell, "select")
	local time = goutil.findChild(cell, "time")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtTime = goutil.findChildTextComponent(time, "txt")

	GameUtil.SetActive(select, data.isSelected)
	GameUtil.SetActive(lock, data.state == BattleStartAnimModel.Lock)
	GameUtil.SetActive(using, data.state == BattleStartAnimModel.Using)
	GameUtil.SetActive(time, data.state ~= BattleStartAnimModel.Using)

	txtName.text = data.cfg.name

	uGuiUtil.setSpriteToImage(img, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("playerinfobg", data.cfg.icon))
	uGuiUtil.setSpriteToImage(imgQuality, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("playerinfobg", data.cfg.qualityIcon))
	GameUtil.addClickHandler(cell.gameObject, GameUtil.handler(self._onClickCell, self, data))
end

function ExteriorView:_clearCell(cell)
	local img = goutil.findChild(cell, "img")
	local imgQuality = goutil.findChild(cell, "imgQuality")

	uGuiUtil.clearImage(img)
	uGuiUtil.clearImage(imgQuality)
end

function ExteriorView:_onClickRefreshInfo(id)
	if id < 3 then
		local key = ViewName.ExteriorView .. "_" .. id
		local isPoped = BattleStartAnimController.instance:isOpenExteriorRule(key)

		if not isPoped then
			BattleStartAnimController.instance:openExteriorRulePopView(key, id)
		end
	end

	GameUtil.SetActive(self._btnFiters[self._selectId].select, false)

	self._selectId = id

	ExteriorController.instance:setCurrExteriorSelectId(id)
	GameUtil.SetActive(self._btnFiters[self._selectId].select, true)

	local showVisible = self._selectId == 1 or self._selectId == 4

	GameUtil.SetActive(self._btnVisible.gameObject, showVisible)

	if showVisible then
		GameUtil.setAnchoredPos(self._btnUse.gameObject, 135, -56)
	else
		GameUtil.setAnchoredPos(self._btnUse.gameObject, 0, -56)
	end

	self:_updateData()
	self:_checkBtnShowState()
end

function ExteriorView:_onClickCell(data)
	self._selectCell = data

	local cfg = data.cfg

	self:showTabAt(self._con, "")
	GameUtil.SetActive(self._preview, false)

	if self._selectId == 3 then
		GameUtil.setAnchoredPos(self._con, 0, 0)

		RoleModel.instance.curCardInfo = clone(RoleModel.instance.myCardInfo)
		RoleModel.instance.curCardInfo.playerMessageSkinId = cfg.id

		self:showTabAt(self._con, ViewName.OtherCardInfoStackView)
	elseif self._selectId == 2 then
		GameUtil.setAnchoredPos(self._con, -284, 319)

		local headInfo = RoleModel.instance:getHeadInfo()
		local pb = BuddyExtension_pb.BuddySimpleNO()

		pb.headInfo.userId = headInfo.userId
		pb.headInfo.userName = headInfo.userName
		pb.headInfo.headIconId = headInfo.headIconId
		pb.headInfo.headFrameId = headInfo.headFrameId
		pb.headInfo.vipLv = headInfo.vipLv
		pb.headInfo.playerLv = headInfo.playerLv
		pb.homePageBackgroundId = cfg.id

		self:showTabAt(self._con, ViewName.PlayerInfoOnlyShowView, pb, 2)
	else
		GameUtil.SetActive(self._preview, true)

		if cfg then
			GameUtil.SetActive(self._spinePos, false)
			GameUtil.SetActive(self._spineBg, false)

			if self._loaderSpine then
				self._loaderSpine:clear()
			end

			if self._selectId == 2 and cfg.isSpine > 0 then
				GameUtil.SetActive(self._spinePos, true)
				GameUtil.SetActive(self._spineBg, true)

				if not cfg.previewPos then
					local pos = {}

					GameUtil.setAnchoredPos(self._spinePos, pos[1] or 0, pos[2] or 0)

					local path = GameUrl.getViewSpineUIUrl(cfg.spinePath)

					self._loaderSpine = PrefabLoader.Get(self._spinePos)

					self._loaderSpine:load(path, nil, self, true)
					uGuiUtil.setSpriteToImage(self._spineBg, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("playerinfobg", cfg.mainIcon1))
				end
			end

			uGuiUtil.setSpriteToImage(self._previewImg, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("playerinfobg", cfg.previewIcon))
		end
	end

	local curViewDatas = self._tableview:getData()

	for i, v in ipairs(curViewDatas) do
		v.isSelected = self._selectCell.id == v.id
	end

	self._txtUse.text = BattleStartAnimModel.BtnText[self._selectCell.state]

	self._tableview:refresh()
	self:_setPreviewSize()
	self:_checkBtnShowState()
end

function ExteriorView:_setPreviewSize()
	if self._selectId == 1 then
		GameUtil.setWidth(self._previewImg, 1040)
		GameUtil.setHeight(self._previewImg, 584)
	elseif self._selectId == 2 then
		GameUtil.setWidth(self._previewImg, 548)
		GameUtil.setHeight(self._previewImg, 612)
	else
		GameUtil.setWidth(self._previewImg, 620)
		GameUtil.setHeight(self._previewImg, 692)
	end
end

function ExteriorView:_onClickVisible()
	if self._selectId == 4 then
		GameUtil.SetActive(self._visibleSelect, not self._isSeeSelf)
		BattleStartAnimController.instance:saveKeyWordSeeSelfBattleBg(not self._isSeeSelf)

		self._isSeeSelf = not self._isSeeSelf

		return
	end

	GameUtil.SetActive(self._visibleSelect, not self._isSeeSelf)
	BattleStartAnimController.instance:saveKeyWordSeeSelf(not self._isSeeSelf)

	self._isSeeSelf = not self._isSeeSelf
end

function ExteriorView:_onClickUse()
	if self._selectCell then
		local state = self._selectCell.state

		if state == BattleStartAnimModel.Lock then
			MaterialMgr.openGetSource(self._matType, self._selectCell.cfg.id)
		elseif state == BattleStartAnimModel.Unuse then
			UniquePropAgent.instance:sendPM_UseUniquePropReq(self._matType, self._selectCell.cfg.id)
		elseif state == BattleStartAnimModel.Using then
			FloatWordMgr.instance:show(lang("exteriorview_6"))
		end
	end
end

function ExteriorView:_onClickbtnShow()
	if not self._selectCell then
		return
	end

	if self._selectId == 1 then
		UIJumper.instance:saveCurStack()
		BattleFacade.instance:sendPreviewPetBattleWithIds(10143, nil, self._selectCell.id)
	elseif self._selectId == 4 then
		UIJumper.instance:saveCurStack()
		BattleFacade.instance:sendPreviewPetBattleWithIds(10143, nil, nil, self._selectCell.id)
	end
end

function ExteriorView:_checkBtnShowState()
	goutil.setActive(self._btnShow.gameObject, (self._selectId == 1 or self._selectId == 4) and self._selectCell and self._selectCell.id ~= 1)
end

return ExteriorView
