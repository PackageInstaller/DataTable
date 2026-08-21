-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/save/AirWorkShopSaveLevelTipsView.lua

module("logic.extensions.airworkshop.flow.defflow.view.save.AirWorkShopSaveLevelTipsView", package.seeall)

local M = class("AirWorkShopSaveLevelTipsView", ViewComponent)

function M:buildUI()
	self._btnClose = self:getBtnByPath("universal_second_tips_common_bg/content/btnClose")
	self._scrollRectGo = self:getGoByPath("allContent/levelScroll")
	self._loopGridView = LoopGridViewHelper.New(self._scrollRectGo)

	self._loopGridView:InitGridView(0, self._updateCell, self)
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:_setEvents(add)
	if add then
		AirWorkDispatcher:addEventListener(AirWorkShopEventType.ON_LEVEL_SAVED_SUCCESS, self._refreshView, self)
	else
		AirWorkDispatcher:removeEventListener(AirWorkShopEventType.ON_LEVEL_SAVED_SUCCESS, self._refreshView, self)
	end
end

function M:onEnter()
	self:_setEvents(true)
	self:_refreshView()
end

function M:onExit()
	self:_setEvents(false)
end

function M:destroyUI()
	return
end

function M:_refreshView()
	self:_getGuanQiaData()
	self:_setData()
end

function M:_getGuanQiaData()
	local maxCount = AirWorkMapModel.instance:getPlanCount()
	local maxUnLockCount = AirWorkMapModel.instance:getCurUnlockPlanCount()
	local levelMOList = {}

	self._moList = {}

	local leveMoDic = AirWorkMapModel.instance:getAllLevelMO()

	for k, levelMO in pairs(leveMoDic) do
		levelMOList[levelMO:getIndex()] = levelMO
	end

	for i = 1, maxCount do
		local mo = {}

		mo.itemIndex = i
		mo.unLock = false
		mo.created = false

		if levelMOList[i] then
			mo.created = true
			mo.data = levelMOList[i]
		end

		table.insert(self._moList, mo)
	end

	for i = 1, maxUnLockCount do
		self._moList[i].unLock = true
	end
end

function M:_setData()
	printWarn("====#self._moList====", #self._moList)

	local itemCount = #self._moList

	self._loopGridView:SetListItemCount(itemCount)
	self._loopGridView:RefreshAllShownItem()
end

function M:_updateCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._loopGridView:NewListViewItem("air_workshop_level_grid_item")
	local itemView = Astral.LuaComponentContainer.Add(item.gameObject, AirWorkSaveItem)
	local mo = self._moList[curIndex]

	itemView:updateData(mo)
	itemView:setClickCallBack(self._onClickCell, self)

	return item
end

function M:_onClickCell(mo)
	local model = AirWorkShopDefMgr.instance:getModel()
	local levelId = model:getLevelId()
	local modifiedMapMO = model:getModiedMapMO()

	if not AirWorkShopDefSceneUtil.checkMapMOLegal(modifiedMapMO) then
		return
	end

	self._mo = mo

	if mo.created then
		self._createAsNew = false

		local info = {}

		info.clickRightCallBackFunc = self._ensureCoverLevel
		info.clickRightCallBackHandler = self
		info.content = lang("tip_airwork_cover_level_ensure")
		info.leftTxt = lang("tip_airwork_cancel")
		info.rightTxt = lang("tip_airwork_ensure")

		ViewMgr.instance:open(ViewName.CommonConfirmTips, info)
	elseif mo.unLock then
		self._createAsNew = true

		self:_trySaveLevel()
	else
		FloatWordMgr.instance:show(lang("tip_airwork_cannot_create_with_locked"))
	end
end

function M:_ensureCoverLevel()
	self:_trySaveLevel()
end

function M:_trySaveLevel()
	local model = AirWorkShopDefMgr.instance:getModel()
	local levelId = model:getLevelId()
	local modifiedMapMO = model:getModiedMapMO()

	if AirWorkShopDefOperateUtil.hasEntityRefresh(modifiedMapMO, levelId) then
		local dialog = Dialog.showMessage(lang("tip_title"), lang("tip_airwork_level_refresh_ensure_tips"))

		dialog:setConfirmListener(self._ensureSaveWithRefreshHeroes, self)
		dialog:setCancelListener(self._ensureSaveLevel, self)
		dialog:setConfirmText(lang("tip_airwork_level_refresh"))
		dialog:setCancelText(lang("tip_airwork_level_not_refresh"))
	else
		self:_ensureSaveLevel()
	end
end

function M:_ensureSaveWithRefreshHeroes()
	local model = AirWorkShopDefMgr.instance:getModel()
	local modifiedMapMO = model:getModiedMapMO()
	local levelId = model:getLevelId()

	AirWorkShopDefOperateUtil.fillNeedRefreshEntitys(modifiedMapMO, levelId)
	self:_ensureSaveLevel()
end

function M:_ensureSaveLevel()
	local model = AirWorkShopDefMgr.instance:getModel()
	local levelId = model:getLevelId()
	local modifiedMapMO = model:getModiedMapMO()

	if self._createAsNew then
		local index = self._mo.itemIndex

		AirWorkShopDefAgent.instance:sendCreateAirMapRequest(modifiedMapMO, index)
	else
		local oldLevelId = self._mo.data:getId()

		AirWorkShopDefAgent.instance:sendModifyAirMapRequest(oldLevelId, modifiedMapMO)
	end

	AirWorkShopDefOperateUtil.captureCamera()
end

function M:_onClickClose()
	self:close()
end

return M
