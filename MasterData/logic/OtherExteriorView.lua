-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/OtherExteriorView.lua

module("logic.extensions.roleinfo.view.OtherExteriorView", package.seeall)

local OtherExteriorView = class("OtherExteriorView", ViewComponent)

function OtherExteriorView:ctor()
	OtherExteriorView.super.ctor(self)
end

function OtherExteriorView:unbindEvents()
	OtherExteriorView.super.unbindEvents(self)

	for i, v in ipairs(self._btnFiters) do
		GameUtil.rmClickHandler(v.btn)
	end
end

function OtherExteriorView:bindEvents()
	OtherExteriorView.super.bindEvents(self)

	for i, v in ipairs(self._btnFiters) do
		GameUtil.addClickHandler(v.btn, GameUtil.handler(self._onClickRefreshInfo, self, i))
	end
end

function OtherExteriorView:buildUI()
	OtherExteriorView.super.buildUI(self)

	self._previewImg = self:getGo("preview/img")
	self._txtOwn = self:getTxt("own/txt")
	self._btnFiters = {}

	for i = 1, 5 do
		local data = {}

		data.btn = self:getBtn("fiters/tableview/viewport/content/btn_" .. i)
		data.select = goutil.findChild(data.btn.gameObject, "imgSelect")

		table.insert(self._btnFiters, data)
	end

	self._tableViewGo = self:getGo("info/anims/tableview")
	self._cellGo = self:getGo("info/anims/cell")
	self._tableview = ScrollerList.create(self._tableViewGo, self._cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._con = self:getGo("displayGo/con")
	self._preview = self:getGo("preview")
end

function OtherExteriorView:onExit()
	OtherExteriorView.super.onExit(self)
	UIStateManager.instance:popByName(ViewName.playerInfo)
	self:showTabAt(self._con, "")

	self._cfgs = nil
	self._selectId = 1
	self._selectCell = nil

	self._tableview:dispose()
	uGuiUtil.clearImage(self._previewImg)
end

function OtherExteriorView:onEnter()
	OtherExteriorView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.GetOtherUniquePropsRes, self._updateData, self)

	self._userId = self:getFirstParam()
	self._matType = MatType.OpeningEffect
	self._selectId = 1
	self._selectCell = nil

	for i, v in ipairs(self._btnFiters) do
		GameUtil.SetActive(v.select, i == self._selectId)
	end

	self:_refreshInfo()
end

function OtherExteriorView:_refreshInfo()
	if self._selectId == 1 then
		self._matType = MatType.OpeningEffect
		self._cfgs = BattleStartAnimConfig.instance:getOpeningEffectCfgList()
	elseif self._selectId == 2 then
		self._matType = MatType.HomePageBg
		self._cfgs = BattleStartAnimConfig.instance:getHomePageBgCfgList()

		GameUtil.SetActive(self._visibleSelect, self._isSeeSelf)
	elseif self._selectId == 3 then
		self._matType = MatType.PlayerMessageSkin
		self._cfgs = BattleStartAnimConfig.instance:getPlayerMessageSkinCfg()
	elseif self._selectId == 4 then
		self._matType = MatType.BattleBackgroundSkin
		self._cfgs = BattleStartAnimConfig.instance:getBattleBackgroundSkinCfgs()
	elseif self._selectId == 5 then
		self._matType = MatType.BattleUserInterfaceSkin
		self._cfgs = BattleStartAnimConfig.instance:getBattleUISkinCfgs()
	end

	BattleStartAnimController.instance:sendPM_GetOtherUniquePropsReq(self._matType, self._userId)
end

function OtherExteriorView:_updateData()
	local data = {}
	local index = 1
	local hasCount = 0
	local firstItem

	for i, v in ipairs(self._cfgs) do
		local cellInfo = {}

		cellInfo.id = i
		cellInfo.cfg = v
		cellInfo.state = BattleStartAnimModel.instance:getOtherState(self._matType, v.id)
		cellInfo.isSelected = cellInfo.state == BattleStartAnimModel.Using

		if cellInfo.state ~= BattleStartAnimModel.Lock then
			table.insert(data, cellInfo)
		end

		if cellInfo.state >= BattleStartAnimModel.Unuse then
			hasCount = hasCount + 1
		end

		if i == 1 then
			firstItem = cellInfo
		end
	end

	if hasCount == 0 then
		hasCount = 1
		curCount = 1
		firstItem.state = BattleStartAnimModel.Using
		firstItem.isSelect = true
		index = 1

		if #list == 0 then
			table.insert(data, firstItem)
		end
	end

	self._selectCell = data[index]

	self._tableview:reloadData(data)
	self:_onClickCell(self._selectCell)

	self._txtOwn.text = string.format("<color=20b376>%s</color>/%s", hasCount, #self._cfgs)
end

function OtherExteriorView:_updateCell(view, cell, data)
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

function OtherExteriorView:_clearCell(cell)
	local img = goutil.findChild(cell, "img")
	local imgQuality = goutil.findChild(cell, "imgQuality")

	uGuiUtil.clearImage(img)
	uGuiUtil.clearImage(imgQuality)
end

function OtherExteriorView:_onClickRefreshInfo(id)
	GameUtil.SetActive(self._btnFiters[self._selectId].select, false)

	self._selectId = id

	GameUtil.SetActive(self._btnFiters[self._selectId].select, true)
	self:_refreshInfo()
end

function OtherExteriorView:_onClickCell(data)
	self._selectCell = data

	local cfg = data.cfg

	self:showTabAt(self._con, "")
	GameUtil.SetActive(self._preview, false)

	if self._selectId == 3 then
		GameUtil.setAnchoredPos(self._con, 0, 0)

		if RoleModel.instance.curCardInfo then
			RoleModel.instance.curCardInfo.playerMessageSkinId = cfg.id

			self:showTabAt(self._con, ViewName.OtherCardInfoStackView)
		end
	elseif self._selectId == 2 then
		GameUtil.setAnchoredPos(self._con, -284, 319)

		local headInfo = RoleModel.instance:getHeadInfo()
		local pb = BuddyExtension_pb.BuddySimpleNO()

		if RoleModel.instance.curCardInfo then
			pb.headInfo.userId = RoleModel.instance.curCardInfo.userId
			pb.headInfo.userName = RoleModel.instance.curCardInfo.userName
			pb.headInfo.headIconId = RoleModel.instance.curCardInfo.headIconId
			pb.headInfo.headFrameId = RoleModel.instance.curCardInfo.headFrameId
		else
			pb.headInfo.userId = "9999"
			pb.headInfo.userName = "PlayerName"
			pb.headInfo.headIconId = headInfo.headIconId
			pb.headInfo.headFrameId = headInfo.headFrameId
		end

		pb.headInfo.vipLv = 1
		pb.headInfo.playerLv = 1
		pb.homePageBackgroundId = cfg.id

		self:showTabAt(self._con, ViewName.PlayerInfoOnlyShowView, pb, 2, self._con)
	else
		GameUtil.setAnchoredPos(self._con, 0, 0)
		GameUtil.SetActive(self._preview, true)

		if cfg then
			uGuiUtil.setSpriteToImage(self._previewImg, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("playerinfobg", cfg.previewIcon), function()
				self._previewImg:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end)
		end
	end

	local curViewDatas = self._tableview:getData()

	for i, v in ipairs(curViewDatas) do
		v.isSelected = self._selectCell.id == v.id
	end

	self._tableview:refresh()
end

return OtherExteriorView
