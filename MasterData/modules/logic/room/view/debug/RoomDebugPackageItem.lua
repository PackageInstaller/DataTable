-- chunkname: @modules/logic/room/view/debug/RoomDebugPackageItem.lua

module("modules.logic.room.view.debug.RoomDebugPackageItem", package.seeall)

local RoomDebugPackageItem = class("RoomDebugPackageItem", ListScrollCellExtend)

function RoomDebugPackageItem:onInitView()
	self._txtdefineid = gohelper.findChildText(self.viewGO, "#txt_defineid")
	self._txtpackageorder = gohelper.findChildText(self.viewGO, "#txt_packageorder")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._simagebirthhero = gohelper.findChildSingleImage(self.viewGO, "#simage_birthhero")
	self._icon = gohelper.onceAddComponent(gohelper.findChild(self.viewGO, "icon"), gohelper.Type_RawImage)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomDebugPackageItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function RoomDebugPackageItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function RoomDebugPackageItem:_btnclickOnClick()
	local leftControl = UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl)
	local leftShift = UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift)
	local selectBlockId = RoomDebugPackageListModel.instance:getSelect()
	local blockMO = RoomMapBlockModel.instance:getFullBlockMOById(self._mo.id)

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.C) then
		RoomDebugController.instance:debugSetPackageId(self._mo.id, 0)
	elseif not leftControl then
		if not leftShift then
			RoomDebugPackageListModel.instance:setSelect(self._mo.id)

			if blockMO then
				local pos = HexMath.hexToPosition(blockMO.hexPoint, RoomBlockEnum.BlockSize)

				self._scene.camera:tweenCamera({
					focusX = pos.x,
					focusY = pos.y
				})
			end
		else
			RoomDebugController.instance:debugSetMainRes(self._mo.id)
		end
	elseif not selectBlockId or selectBlockId == self._mo.id then
		RoomDebugController.instance:debugSetPackageOrder(self._mo.id)
	else
		RoomDebugPackageListModel.instance:clearSelect()
		RoomDebugController.instance:exchangeOrder(selectBlockId, self._mo.id)
	end
end

function RoomDebugPackageItem:_editableInitView()
	self._scene = GameSceneMgr.instance:getCurScene()
	self._isSelect = false

	gohelper.addUIClickAudio(self._btnclick.gameObject, AudioEnum.UI.UI_Common_Click)
end

function RoomDebugPackageItem:_refreshUI()
	self._txtdefineid.text = "地块id:" .. self._mo.id
	self._txtpackageorder.text = string.format("序号: %s", self._mo.packageOrder)
	self._txtname.text = RoomHelper.getBlockPrefabName(self._mo.config.prefabPath)

	self:_refreshCharacter(self._mo.id)
end

function RoomDebugPackageItem:onUpdateMO(mo)
	gohelper.setActive(self._goselect, self._isSelect)

	self._mo = mo

	self:_refreshUI()
	self:_refreshBlock(mo and mo.blockId)
end

function RoomDebugPackageItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)

	self._isSelect = isSelect
end

function RoomDebugPackageItem:_refreshBlock(blockId)
	local scene = GameSceneMgr.instance:getCurScene()
	local oldBlockId = self._lastOldBlockId

	self._lastOldBlockId = blockId

	if oldBlockId then
		scene.inventorymgr:removeBlockEntity(oldBlockId)
	end

	gohelper.setActive(self._icon, blockId and true or false)

	if blockId then
		scene.inventorymgr:addBlockEntity(blockId)

		local index = scene.inventorymgr:getIndexById(blockId)

		OrthCameraRTMgr.instance:setRawImageUvRect(self._icon, index)
	end
end

function RoomDebugPackageItem:onDestroy()
	self._simagebirthhero:UnLoadImage()
	self:_refreshBlock(nil)
end

function RoomDebugPackageItem:_refreshCharacter(blockId)
	local blockCfg = RoomConfig.instance:getSpecialBlockConfig(blockId)

	gohelper.setActive(self._simagebirthhero.gameObject, blockCfg ~= nil)

	if not blockCfg then
		return
	end

	local heroCfg = HeroConfig.instance:getHeroCO(blockCfg.heroId)

	if not heroCfg then
		return
	end

	local skinConfig = SkinConfig.instance:getSkinCo(heroCfg.skinId)

	if not skinConfig then
		return
	end

	self._simagebirthhero:LoadImage(ResUrl.getHeadIconSmall(skinConfig.headIcon))
end

return RoomDebugPackageItem
