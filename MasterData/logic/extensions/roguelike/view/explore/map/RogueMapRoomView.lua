-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/map/RogueMapRoomView.lua

module("logic.extensions.roguelike.view.explore.map.RogueMapRoomView", package.seeall)

local M = class("RogueMapRoomView", RogueMapBaseView)

function M:onEnter()
	local allRoleState = RoguelikeModel.instance:getAllRoleState()

	if not allRoleState or not RogueMgr.instance:isInRogue() then
		self:_onQuitSuccess()
		LoadingFacade.instance:hideLoading()

		return
	end

	local mapMgr = RogueMgr.instance:getMapMgr()

	if mapMgr then
		mapMgr:switchToSecondScene(true)
	end

	M.super.onEnter(self)

	local isShowMapName = self:getFirstParam()

	if isShowMapName == true then
		RogueMgr.instance:getRogueFlow().mapMgr:getMapRole().meshModel:setDirection(UnitSpineDir.Right)
	end
end

function M:onEnterFinished()
	M.super.onEnterFinished(self)

	local isShowMapName = self:getFirstParam()

	if isShowMapName == true then
		self:_onShowMapName()
	else
		self:checkCurOpenView()
		self:setAniGoActive(true)
	end
end

function M:onExit()
	M.super.onExit(self)

	local mapMgr = RogueMgr.instance:getMapMgr()

	if mapMgr then
		mapMgr:switchToSecondScene(false)
	end

	if RogueMgr.instance:getRogueFlow() then
		RogueMgr.instance:getRogueFlow().mapMgr:setUI2FollowGos(self._mapItems or {}, true)
	end

	self._isExit = false
end

function M:_onRoomRefresh()
	if self._isExit then
		return
	end

	if not RoguelikeModel.instance:getIsInSecondRoom() then
		RoguelikeController.instance:exitRunGroupSecondSceneFlow()

		self._isExit = true

		self:close()

		return
	end

	M.super._onRoomRefresh(self)
end

function M:updateMapByRooms(isEnter)
	RoguelikeUtil.instance:saveCurCoordinate2()

	local allRoomMos = RoguelikeModel.instance:getRoom2MOs()

	self._curMapRoomMos = RoguelikeModel.instance:getCurMapRoomMOs()

	if self._curMapId ~= RoguelikeModel.instance:getCurSecondMapId() and not RoguelikeModel.instance:getShowAllMap() then
		for k, v in pairs(self._mapItems) do
			v:onClear()
		end
	end

	self._curMapId = RoguelikeModel.instance:getCurSecondMapId()
	self._allRoomMos = allRoomMos

	for i = 0, self._traMapParent.childCount - 1 do
		goutil.setActive(self._traMapParent:GetChild(i).gameObject, false)
	end

	if self._isSpineMoving then
		-- block empty
	end

	RogueMgr.instance:getRogueFlow().mapMgr:updateSecondMapInfo(self, isEnter)

	local hadCurRoom = false
	local firstRoomIndex = false
	local firstItem

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

		if mo:getRoomType() == RoguelikeExtension_pb.RoomType.INIT then
			firstRoomIndex = i
			firstItem = item
		end

		if i == RoguelikeModel.instance:getCurRoom2Index() and not self._isSpineMoving then
			self._curIndex = i
			hadCurRoom = true
		end
	end

	firstItem = firstItem or self._mapItems[1]

	RogueMgr.instance:getRogueFlow().mapMgr:setUI2FollowGos(self._mapItems)

	if not hadCurRoom and not self._isSpineMoving then
		self._curIndex = firstRoomIndex
	end

	local size = self._traMapScroller.sizeDelta

	size.x = self:getMaxMapOffset() * 130
	self._traMapScroller.sizeDelta = size
end

function M:moveToTarget(lastIndex, newIndex)
	local curMapId = RoguelikeModel.instance:getCurSecondMapId()

	if self._allRoomMos[newIndex]:getMapId() ~= curMapId then
		printError("不在当前所在地图")

		return
	end

	if lastIndex == newIndex then
		if self._mapItemClickCallback ~= nil then
			self._isSpineMoving = true

			settimer(0.3, self.delayClickItemCallback, self, false)
		end

		print("点击同一处")

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

	RoguelikeUtil.instance:getLineCoordinate2(coordinate1, coordinate2, function(indexs)
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

			local effectIds = {}
			local reduceSanCount = 0

			if unVisibleCount > 0 and not getIsFreeRoom(indexs) then
				-- block empty
			end

			RogueMgr.instance:getRogueFlow().mapMgr:moveToTarget(temp[#indexs], temp, function()
				local roomMo = self._allRoomMos[self._targetIndex]

				RoguelikeAgent.instance:sendMoveRequest(roomMo:getCoordinateStr())
				RoguelikeModel.instance:setCurRoomId(roomMo:getId())
				RoguelikeModel.instance:setCurRoomMo(roomMo)
				settimer(1, self.delayClickItemCallback, self, false)
			end, true)
		end

		local allRoleSanOne = RoguelikeModel.instance:getRoleSanIsOne()

		if allRoleSanOne and unVisibleCount > 0 and not getIsFreeRoom(indexs) then
			local dialog = Dialog.showMessage(lang("tip_title"), lang("tip_r_move_san_one"))

			dialog:setConfirmListener(function()
				execMove()
			end, self)
		else
			execMove()
		end
	end)
end

return M
