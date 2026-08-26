-- chunkname: @modules/logic/room/view/RoomInventorySelectItem.lua

module("modules.logic.room.view.RoomInventorySelectItem", package.seeall)

local RoomInventorySelectItem = class("RoomInventorySelectItem", ListScrollCellExtend)

function RoomInventorySelectItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomInventorySelectItem:addEvents()
	self._btnItem:AddClickListener(self._onBtnItemClick, self)
	self.addEventCb(self, RoomWaterReformController.instance, RoomEvent.OnGetBlockReformPermanentInfo, self._onGetReformPermanentInfo, self)
end

function RoomInventorySelectItem:removeEvents()
	self._btnItem:RemoveClickListener()
	self.removeEventCb(self, RoomWaterReformController.instance, RoomEvent.OnGetBlockReformPermanentInfo, self._onGetReformPermanentInfo, self)
end

function RoomInventorySelectItem:_editableAddEvents()
	RoomMapController.instance:registerCallback(RoomEvent.BackBlockListDataChanged, self._onBackBlockChanged, self)
	RoomMapController.instance:registerCallback(RoomEvent.BackBlockPlayUIAnim, self._onPlayAnim, self)
end

function RoomInventorySelectItem:_editableRemoveEvents()
	RoomMapController.instance:unregisterCallback(RoomEvent.BackBlockListDataChanged, self._onBackBlockChanged, self)
	RoomMapController.instance:unregisterCallback(RoomEvent.BackBlockPlayUIAnim, self._onPlayAnim, self)
end

function RoomInventorySelectItem:_editableInitView()
	self._rtIndex = OrthCameraRTMgr.instance:getNewIndex()
	self._goselect = gohelper.findChild(self.viewGO, "go_select")
	self._goempty = gohelper.findChild(self.viewGO, "go_empty")
	self._goicon = gohelper.findChild(self.viewGO, "go_icon")
	self._gobirthicon = gohelper.findChild(self.viewGO, "go_birthicon")
	self._simagebirthhero = gohelper.findChildSingleImage(self.viewGO, "go_birthicon/simage_birthhero")
	self._goonbirthdayicon = gohelper.findChild(self.viewGO, "go_birthicon/#image_onbirthday")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._btnItem = gohelper.findChildButtonWithAudio(self.viewGO, "go_icon")
	self._rawImageIcon = gohelper.onceAddComponent(self._goicon, gohelper.Type_RawImage)

	OrthCameraRTMgr.instance:setRawImageUvRect(self._rawImageIcon, self._rtIndex)

	local colorStr = "#BFB5A3"

	SLFramework.UGUI.GuiHelper.SetColor(self._rawImageIcon, colorStr)

	self._scene = GameSceneMgr.instance:getCurScene()

	gohelper.setActive(self._goempty, false)

	self._backBlockIds = {}
end

function RoomInventorySelectItem:_onBackBlockChanged(blockIds, isHasCurPackage, buildingIds, minBlockIndex)
	if isHasCurPackage then
		if self:_IsShow() then
			self:_playBackBlockAnim(blockIds, false, minBlockIndex)
		else
			tabletool.addValues(self._backBlockIds, blockIds)
		end
	end
end

function RoomInventorySelectItem:_onPlayAnim()
	if self:_IsShow() and #self._backBlockIds > 0 then
		local blockIds = self._backBlockIds

		self._backBlockIds = {}

		self:_playBackBlockAnim(blockIds, true)
	end
end

function RoomInventorySelectItem:_playBackBlockAnim(blockIds, isBackMore, minIndex)
	blockIds = blockIds or {}

	if self._blockMO then
		local isNew = tabletool.indexOf(blockIds, self._blockMO.id)
		local animName

		if isBackMore then
			if isNew then
				animName = "dikuai03"
			end
		elseif isNew then
			animName = "dikuai01"
		elseif (minIndex and self._index or nil) and minIndex < self._index then
			animName = "dikuai02"
		end

		if not animName then
			return
		end

		self._animator:Play(animName, 0, 0)
	end
end

function RoomInventorySelectItem:_IsShow()
	if RoomMapBlockModel.instance:isBackMore() or RoomBuildingController.instance:isBuildingListShow() then
		return false
	end

	return true
end

function RoomInventorySelectItem:_onBtnItemClick()
	if not self._blockMO then
		return
	end

	local blockId = self._blockMO.id

	RoomShowBlockListModel.instance:setSelect(blockId)

	local tscene = self._scene
	local curStateName = tscene.fsm:getCurStateName()

	if RoomHelper.isFSMState(RoomEnum.FSMEditState.PlaceConfirm) then
		local tempBlockMO = RoomMapBlockModel.instance:getTempBlockMO()
		local pos = HexMath.hexToPosition(tempBlockMO.hexPoint, RoomBlockEnum.BlockSize)
		local tempBlockId = tempBlockMO.id

		if tempBlockId == blockId then
			if RoomHelper.isOutCameraFocusCenter(pos) then
				if not tscene.camera:isTweening() then
					tscene.camera:tweenCamera({
						focusX = pos.x,
						focusY = pos.y
					})
				end
			else
				GameFacade.showToast(ToastEnum.RoomInventorySelect)
			end
		else
			tscene.fsm:triggerEvent(RoomSceneEvent.TryPlaceBlock, {
				hexPoint = tempBlockMO.hexPoint
			})
		end
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.SelectBlock)
end

function RoomInventorySelectItem:_onGetReformPermanentInfo()
	local blockMO = self:getBlockMO()

	if not blockMO then
		return
	end

	local inventoryEntity = self._scene.inventorymgr:getBlockEntity(blockMO.id, SceneTag.RoomInventoryBlock)

	RoomBlockHelper.refreshBlockEntity({
		inventoryEntity
	}, "refreshBlock")
end

function RoomInventorySelectItem:_refreshBlock(blockId, oldBlockId)
	if oldBlockId then
		self._scene.inventorymgr:removeBlockEntity(oldBlockId)
	end

	if blockId then
		self._scene.inventorymgr:addBlockEntity(blockId)

		local index = self._scene.inventorymgr:getIndexById(blockId)

		OrthCameraRTMgr.instance:setRawImageUvRect(self._rawImageIcon, index)
	end
end

function RoomInventorySelectItem:getBlockMO()
	return self._blockMO
end

function RoomInventorySelectItem:onUpdateMO(mo)
	if self._blockMO then
		local blockId = mo and mo.id

		self._blockMO = mo

		self:_refreshBlock(blockId, self._blockMO)

		if self._blockMO then
			local isBirthdayBlock = self._blockMO.packageId == RoomBlockPackageEnum.ID.RoleBirthday

			gohelper.setActive(self._gobirthicon, isBirthdayBlock)

			if isBirthdayBlock then
				self:_refreshCharacter(blockId)
			end

			RoomMapController.instance:getNextBlockReformPermanentInfo(self._index)
		end
	end
end

function RoomInventorySelectItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)
end

function RoomInventorySelectItem:onDestroyView()
	if self._blockMO then
		self._scene.inventorymgr:removeBlockEntity(self._blockMO.id)
	end

	if self._rawImageIcon then
		self._rawImageIcon.texture = nil
	end

	self._simagebirthhero:UnLoadImage()
end

function RoomInventorySelectItem:_refreshCharacter(blockId)
	local blockCfg = RoomConfig.instance:getSpecialBlockConfig(blockId)

	if not blockCfg then
		return
	end

	local isOnBirthday = RoomCharacterModel.instance:isOnBirthday(blockCfg.heroId)

	gohelper.setActive(self._goonbirthdayicon, isOnBirthday)

	local skinId = self:_findSkinIdByHeroId(blockCfg.heroId)

	if not skinId then
		return
	end

	local skinConfig = SkinConfig.instance:getSkinCo(skinId)

	self._simagebirthhero:LoadImage(ResUrl.getHeadIconSmall(skinConfig.headIcon))
end

function RoomInventorySelectItem:_findSkinIdByHeroId(heroId)
	local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(heroId)

	if roomCharacterMO then
		return roomCharacterMO.skinId
	end

	local heroCfg = HeroConfig.instance:getHeroCO(heroId)

	return (heroCfg or nil) and (heroCfg.skinId or nil)
end

return RoomInventorySelectItem
