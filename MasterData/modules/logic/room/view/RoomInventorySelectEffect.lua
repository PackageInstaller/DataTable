-- chunkname: @modules/logic/room/view/RoomInventorySelectEffect.lua

module("modules.logic.room.view.RoomInventorySelectEffect", package.seeall)

local RoomInventorySelectEffect = class("RoomInventorySelectEffect", BaseView)

function RoomInventorySelectEffect:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomInventorySelectEffect:addEvents()
	return
end

function RoomInventorySelectEffect:removeEvents()
	return
end

function RoomInventorySelectEffect:_editableInitView()
	self._goreclaim = gohelper.findChild(self.viewGO, "go_content/go_count/#reclaim")
	self._gomassif = gohelper.findChild(self.viewGO, "go_content/go_count/#reclaim/reclaim_massif/#massif")
	self._goreclaimtips = gohelper.findChild(self.viewGO, "go_content/#go_reclaimtips")
	self._gomassiftips = gohelper.findChild(self.viewGO, "go_content/#go_reclaimtips/#massiftips")

	gohelper.setActive(self._gomassif, false)
	gohelper.setActive(self._gomassiftips, false)
	gohelper.setActive(self._goreclaimtips, true)

	self._isViewShow = false
	self._isViewShowing = false
	self._nextPlayTipsTime = 0
	self._isFlag = false
	self._massifEffList = {}
	self._massifTipEffList = {}
	self._reclaimEffTab = self:_getUserDataTbEffect(self._goreclaim)
	self._backBlockIds = {}
	self._tipsInfoList = {}
end

function RoomInventorySelectEffect:onOpen()
	self.addEventCb(self, RoomMapController.instance, RoomEvent.BackBlockListDataChanged, self._onBackBlockChanged, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.BackBlockPlayUIAnim, self._onBackBlockPlayUIAnim, self)
end

function RoomInventorySelectEffect:onClose()
	TaskDispatcher.cancelTask(self._delayPlayTipsEffect, self)

	if self._reclaimEffTab then
		self._reclaimEffTab:dispose()
	end

	self._reclaimEffTab = nil

	for i = 1, #self._massifEffList do
		self._massifEffList[i]:dispose()
	end

	self._massifEffList = {}

	for i = 1, #self._massifTipEffList do
		self._massifTipEffList[i]:dispose()
	end

	self._massifTipEffList = {}
end

function RoomInventorySelectEffect:_onBackBlockChanged(blockIds, isFlag, buildingIds)
	tabletool.addValues(self._backBlockIds, blockIds)

	for i = 1, #blockIds do
		local blockCfg = RoomConfig.instance:getBlock(blockIds[i])

		if blockCfg then
			self:_addPackageId(blockCfg.packageId)
		end
	end

	if buildingIds and #buildingIds > 0 then
		for i = 1, #buildingIds do
			self:_addBuildingId(buildingIds[i])
		end
	end

	self:_playEffect()
end

function RoomInventorySelectEffect:_onBackBlockPlayUIAnim()
	self:_playEffect()
end

function RoomInventorySelectEffect:_getIsShow()
	if RoomMapBlockModel.instance:isBackMore() or RoomBuildingController.instance:isBuildingListShow() then
		return false
	end

	return true
end

function RoomInventorySelectEffect:_playEffect()
	self:_playMassifEffect()
	self:_playTipsEffect()
end

function RoomInventorySelectEffect:_addPackageId(packageId)
	local isBlock = true
	local info = self:_getTipsInfo(packageId, isBlock)

	if info then
		info.count = info.count + 1
	else
		local packageCfg = RoomConfig.instance:getBlockPackageConfig(packageId)

		if packageCfg then
			info = {
				count = 1,
				id = packageId,
				isBlock = isBlock,
				name = packageCfg.name,
				rare = packageCfg.rare
			}

			table.insert(self._tipsInfoList, info)
		end
	end
end

function RoomInventorySelectEffect:_addBuildingId(buildingId)
	local isBlock = false
	local info = self:_getTipsInfo(buildingId, isBlock)

	if info then
		info.count = info.count + 1
	else
		local buildingCfg = RoomConfig.instance:getBuildingConfig(buildingId)

		if buildingCfg then
			info = {
				count = 1,
				id = buildingId,
				isBlock = isBlock,
				name = buildingCfg.name,
				rare = buildingCfg.rare
			}

			table.insert(self._tipsInfoList, info)
		end
	end
end

function RoomInventorySelectEffect:_getTipsInfo(id, isBlock)
	local list = self._tipsInfoList

	for i = 1, #list do
		local info = list[i]

		if info.id == id and info.isBlock == isBlock then
			return info
		end
	end
end

function RoomInventorySelectEffect:_getUserDataTbEffect(go)
	local tab = self:getUserDataTb_()

	tab.go = go
	tab.effectTime = 2
	tab.isRunning = false

	function tab:playEffect(delay)
		self.isRunning = true

		TaskDispatcher.cancelTask(self._playEffect, self)
		TaskDispatcher.runDelay(self._playEffect, self, delay or 0)
	end

	function tab:_playEffect()
		gohelper.setActive(self.go, false)
		gohelper.setActive(self.go, true)
		TaskDispatcher.cancelTask(self._stopEffect, self)
		TaskDispatcher.runDelay(self._stopEffect, self, self.effectTime or 1.5)
	end

	function tab:_stopEffect()
		self.isRunning = false

		gohelper.setActive(self.go, false)
	end

	function tab:_clearTask()
		TaskDispatcher.cancelTask(self._playEffect, self)
		TaskDispatcher.cancelTask(self._stopEffect, self)
	end

	function tab:dispose()
		self:_clearTask()
		self:_stopEffect()
	end

	return tab
end

function RoomInventorySelectEffect:_playMassifEffect()
	if not self:_getIsShow() then
		return
	end

	local blockIds = self._backBlockIds

	self._backBlockIds = {}

	local maxCount = math.min(5, #blockIds)

	if maxCount > 0 then
		self._reclaimEffTab.effectTime = 3

		self._reclaimEffTab:playEffect()
	end

	for i = 1, maxCount do
		local effTab = self._massifEffList[i]

		if not effTab then
			local cloneGo = gohelper.cloneInPlace(self._gomassif, "massif" .. i)

			effTab = self:_getUserDataTbEffect(cloneGo)

			table.insert(self._massifEffList, effTab)
		end

		effTab:playEffect(i * 0.06)
	end
end

function RoomInventorySelectEffect:_delayPlayTipsEffect()
	if #self._tipsInfoList > 0 then
		self:_playTipsEffect()
	end
end

function RoomInventorySelectEffect:_playTipsEffect()
	if not self:_getIsShow() then
		return
	end

	local curTime = Time.time
	local infoList = self._tipsInfoList
	local nextDelayTime = 1
	local blockPackageMO = RoomInventoryBlockModel.instance:getCurPackageMO()

	for i = 1, 5 do
		local effTab = self._massifTipEffList[i]

		if not effTab then
			local cloneGo = gohelper.cloneInPlace(self._gomassiftips, "gomassiftips" .. i)

			effTab = self:_getUserDataTbEffect(cloneGo)
			effTab._imagerare = gohelper.findChildImage(cloneGo, "rare")
			effTab._txtname = gohelper.findChildText(cloneGo, "txt_name")
			effTab._txtnum = gohelper.findChildText(cloneGo, "txt_num")
			effTab._goicon = gohelper.findChild(cloneGo, "icon")
			effTab._gobuildingicon = gohelper.findChild(cloneGo, "building_icon")
			effTab.finishTime = 0
			effTab.effectTime = 3.7

			table.insert(self._massifTipEffList, effTab)
		end

		if curTime < effTab.finishTime then
			nextDelayTime = math.min(nextDelayTime, effTab.finishTime - curTime)
		elseif #infoList > 0 then
			local info = infoList[1]

			table.remove(infoList, 1)

			if blockPackageMO then
				::label_22_0::

				local var_22_0 = info.isBlock

				if info.isBlock then
					local isCurPackage = blockPackageMO.id == info.id
					local colorStr = isCurPackage and "#FFFFFF" or "#FFFFFF"

					effTab._txtname.text = isCurPackage and luaLang("room_backblock_curpackage") or info.name
					effTab._txtnum.text = "+" .. info.count
					effTab.finishTime = curTime + effTab.effectTime

					if effTab.isBlock ~= info.isBlock then
						effTab.isBlock = info.isBlock

						gohelper.setActive(effTab._goicon, info.isBlock)
						gohelper.setActive(effTab._gobuildingicon, not info.isBlock)
					end

					if effTab.txtColorStr ~= colorStr then
						effTab.txtColorStr = colorStr

						SLFramework.UGUI.GuiHelper.SetColor(effTab._txtnum, colorStr)
						SLFramework.UGUI.GuiHelper.SetColor(effTab._txtname, colorStr)
					end

					if not RoomBlockPackageEnum.RareIcon[info.rare] then
						local splitName = RoomBlockPackageEnum.RareIcon[1]

						UISpriteSetMgr.instance:setRoomSprite(effTab._imagerare, splitName)
						effTab:playEffect()
						gohelper.setAsLastSibling(effTab.go)
					end
				end
			end
		end

		if #infoList < 1 then
			break
		end
	end

	if #infoList > 0 then
		TaskDispatcher.runDelay(self._delayPlayTipsEffect, self, nextDelayTime)
	end
end

return RoomInventorySelectEffect
