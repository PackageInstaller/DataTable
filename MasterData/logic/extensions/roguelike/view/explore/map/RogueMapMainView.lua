-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/map/RogueMapMainView.lua

module("logic.extensions.roguelike.view.explore.map.RogueMapMainView", package.seeall)

local M = class("RogueMapMainView", RogueMapBaseView)

function M:onEnter()
	local allRoleState = RoguelikeModel.instance:getAllRoleState()

	if not allRoleState or not RogueMgr.instance:isInRogue() then
		self:_onQuitSuccess()
		LoadingFacade.instance:hideLoading()

		return
	end

	if self:switchToSecondaryMapCheck() then
		return
	end

	M.super.onEnter(self)

	local openParam = self:getFirstParam()
	local isShowMapName = openParam and openParam[1]

	if isShowMapName == true then
		RogueMgr.instance:getRogueFlow().mapMgr:getMapRole().meshModel:setDirection(UnitSpineDir.Right)
	end
end

function M:onExit()
	M.super.onExit(self)

	if RogueMgr.instance:getRogueFlow() then
		RogueMgr.instance:getRogueFlow().mapMgr:setUIFollowGos(self._mapItems or {}, true)
	end

	removetimer(self.switchToSecondaryMapCheck, self)
end

function M:onEnterFinished()
	M.super.onEnterFinished(self)

	local openParam = self:getFirstParam()
	local isShowMapName = openParam and openParam[1]

	if isShowMapName == true and RogueExploreModel.instance:getIsGaming() then
		self:_onShowMapName()
	else
		self:checkCurOpenView()
		self:setAniGoActive(true)
	end

	if openParam and openParam[2] and not RoguelikeModel.instance:getIsInSecondRoom() then
		openParam[2]()
	end
end

function M:_onRoomRefresh()
	M.super._onRoomRefresh(self)
	self:switchToSecondaryMapCheck()
end

function M:switchToSecondaryMapCheck()
	if RoguelikeModel.instance:getIsInSecondRoom() then
		if GainItemController.instance:getIsShowRogueThreadTips() then
			settimer(0.2, self.switchToSecondaryMapCheck, self, false)
		else
			local sceneId = RoguelikeController.instance:getSceneId(RoguelikeModel.instance:getCurSecondMapId())

			RoguelikeController.instance:enterRunGroupSecondaryScene(sceneId)
			self:close()

			return true
		end
	else
		RoguelikeAgent.instance:delayShowProps()
	end

	return false
end

function M:updateMapByRooms(isEnter)
	RoguelikeUtil.instance:saveCurCoordinate()

	local allRoomMos = RoguelikeModel.instance:getRoomMOs(true)

	self._curMapRoomMos = RoguelikeModel.instance:getCurMapRoomMOs(true)

	if self._curMapId ~= RoguelikeModel.instance:getCurMapId() and not RoguelikeModel.instance:getShowAllMap() then
		for k, v in pairs(self._mapItems) do
			v:onClear()
		end
	end

	if not allRoomMos then
		return
	end

	self._curMapId = RoguelikeModel.instance:getCurMapId()
	self._allRoomMos = allRoomMos

	for i = 0, self._traMapParent.childCount - 1 do
		goutil.setActive(self._traMapParent:GetChild(i).gameObject, false)
	end

	if not RogueMgr.instance:getRogueFlow() then
		return
	end

	RogueMgr.instance:getRogueFlow().mapMgr:updateMapInfo(isEnter)
	RoguelikeController.instance:setDelayEntering(false)

	local sortDatas = {}

	for i = 1, #allRoomMos do
		local item = self._mapItems[i]

		if item == nil then
			local go = Astral.GameObjectUtil.CloneAndSetParent(self._goMapItem, self._traMapParent, nil)

			item = RogueMapClickItem.New(go)

			local point = Astral.GameObjectUtil.CloneAndSetParent(self._goMapPointItem, go.transform, nil)
			local pointItem = Astral.LuaComponentContainer.Add(point, RogueMapPointItem)

			item:setPointItem(pointItem)

			self._mapItems[i] = item
		end

		local mo = allRoomMos[i]
		local data = {}

		data.index = i

		local temp = i

		data.coordinate = mo:getCoordinate()

		table.insert(sortDatas, {
			index = i,
			x = data.coordinate[1],
			y = data.coordinate[2]
		})

		data.icon = mo:getRoomIcon(i)
		data.name = mo:getTypeName()
		data.state = mo:getRoomState(i)
		data.visible = mo:getIsVisible()
		data.isFinish = mo:getIsFinish()
		data.viewPresentor = self._viewPresentor
		data.plateCo = mo:getShapeCo()
		data.mapId = mo:getMapId()
		data.plateParent = self._traMapPlateParent
		data.mo = mo
		data.offset = self:getMapItemOffset(mo:getMapId())

		function data.callback()
			self:onMapItemClick(temp)
		end

		item:updateData(data)

		if i == RoguelikeModel.instance:getCurRoomIndex() and not self._isSpineMoving then
			self._curIndex = i
		end
	end

	table.sort(sortDatas, function(a, b)
		return a.y > b.y
	end)

	for k, v in pairs(sortDatas) do
		local item = self._mapItems[v.index]
		local tra = item:getGo().transform

		tra:SetSiblingIndex(k - 1)
	end

	RogueMgr.instance:getRogueFlow().mapMgr:setUIFollowGos(self._mapItems)

	local size = self._traMapScroller.sizeDelta

	size.x = self:getMaxMapOffset() * 130
	self._traMapScroller.sizeDelta = size
end

function M:moveToTarget(lastIndex, newIndex)
	local curMapId = RoguelikeModel.instance:getCurMapId()

	if self._allRoomMos[newIndex]:getMapId() ~= curMapId then
		printError("不在当前所在地图")

		return
	end

	if lastIndex == newIndex then
		if self._mapItemClickCallback ~= nil then
			self._isSpineMoving = true

			settimer(0.3, self.delayClickItemCallback, self, false)
		end

		return
	end

	local coordinate1 = self._allRoomMos[lastIndex]:getCoordinate()
	local coordinate2 = self._allRoomMos[newIndex]:getCoordinate()
	local offset = RoguelikeModel.instance:getCurMapOffset()

	function canMoveToTarget(indexs)
		for k, v in pairs(indexs) do
			if not self._allRoomMos[v + offset] then
				return false
			end

			if not self._allRoomMos[v + offset]:getIsVisible() then
				return false
			end
		end

		return true
	end

	function getUnClearCount(indexs)
		local count = 0

		for k, v in pairs(indexs) do
			if self._allRoomMos[v + offset] and not self._allRoomMos[v + offset]:getIsClear() then
				count = count + 1
			end
		end

		return count
	end

	function getLastIsNextRoom(indexs)
		local mo = self._allRoomMos[indexs[#indexs] + offset]

		if mo then
			return mo:getIsNextRoom()
		end

		return false
	end

	function getIsFreeRoom(indexs)
		local mo = self._allRoomMos[indexs[#indexs] + offset]

		if mo then
			return mo:getIsFreeMove()
		end

		return false
	end

	RoguelikeUtil.instance:getLineCoordinate(coordinate1, coordinate2, function(indexs)
		if not canMoveToTarget(indexs) then
			FloatWordMgr.instance:show(lang("tip_r_room_cant_reach"))

			return
		end

		local temp = {}

		for k, v in ipairs(indexs) do
			table.insert(temp, v + offset)
		end

		local unVisibleCount = getUnClearCount(indexs)

		function execMove()
			self._curIndex = temp[#indexs]
			self._targetIndex = temp[#indexs]
			self._isSpineMoving = true

			RogueMgr.instance:getRogueFlow().mapMgr:moveToTarget(temp[#indexs], temp, function()
				local roomMo = self._allRoomMos[self._targetIndex]

				RoguelikeAgent.instance:sendMoveRequest(roomMo:getCoordinateStr())
				RoguelikeModel.instance:setCurRoomId(roomMo:getId())
				RoguelikeModel.instance:setCurRoomMo(roomMo)
				settimer(1, self.delayClickItemCallback, self, false)
			end)
		end

		local allRoleSanOne = RoguelikeModel.instance:getRoleSanIsOne()

		if allRoleSanOne and unVisibleCount > 0 and not getIsFreeRoom(indexs) then
			if RoguelikeUtil.instance:getIsGuideScript() then
				local dialog = Dialog.showMessage(lang("tip_title"), lang("理智归0是非常危险的情况，但本次探索暂时没有归0惩罚，请后续注意"))

				dialog:setConfirmListener(function()
					execMove()
				end, self)
			else
				local dialog = Dialog.showMessage(lang("tip_title"), lang("tip_r_move_san_one"))

				dialog:setConfirmListener(function()
					execMove()
				end, self)
			end
		elseif getLastIsNextRoom(indexs) then
			local dialog = Dialog.showMessage(lang("tip_title"), lang("tip_r_move_next_layer"))

			dialog:setConfirmListener(function()
				execMove()
			end, self)
		else
			execMove()
		end
	end)
end

return M
