-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/unit/component/room/UnitCompShelterRoomBillBoard.lua

module("logic.extensions.house.scene.unit.component.room.UnitCompShelterRoomBillBoard", package.seeall)

local M = class("UnitCompShelterRoomBillBoard", UnitComponentBase)

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._resLoader = nil
	self._waitForInitAndShow = false
end

function M:onInit()
	self._resLoader = MultiResLoader.New()
	self._waitForInitAndShow = false
	self._resRootName = nil
end

function M:onLateInit()
	return
end

function M:onReuse()
	return
end

function M:onReset()
	self:onRoomResUnload()
end

function M:onDestroy()
	self:onReset()

	self._resLoader = nil
	self._resRootName = nil
end

function M:onRoomResLoaded()
	local subRoomTyp = self._unit.model:getSubRoomType()
	local cfgProtomerInfo = ContainmentConfig.instance:getProtomerInfoByShelterRoomTyp(subRoomTyp)

	if cfgProtomerInfo then
		self:_buildView(cfgProtomerInfo)
		self:initView(cfgProtomerInfo)
		self:_setEvents(true)
	end

	self._roomResLoaded = true

	self:_tryResponseGetBillBoardScreenPos()
end

function M:onRoomResUnload()
	self._resLoader:clear()
	self:_unbuildView()

	self._waitForInitAndShow = false
	self._roomResLoaded = false
end

function M:_setEvents(isOn)
	if isOn then
		GlobalDispatcher:addEventListener(EventType.HOUSE_HOLD_BILLBOARD_CHANGE, self._onHouseHoldBillBoardChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.HOUSE_HOLD_BILLBOARD_CHANGE, self._onHouseHoldBillBoardChange, self)
	end
end

function M:_buildView(cfgProtomerInfo)
	if cfgProtomerInfo == nil then
		return
	end

	local roomGO = self._unit.resLoader:getRoomGO()
	local billBoardPath = cfgProtomerInfo.billboardpath

	for index, value in ipairs(billBoardPath or {}) do
		local path = string.format("trigger/%s", value)
		local tmpTr = goutil.findChild(roomGO, path)

		if tmpTr then
			self:_buildBillBoardUI(tmpTr.gameObject, index)
		else
			printError(string.format("原体[%d]收容室资源[%d],场景无法找到节点 %s", cfgProtomerInfo.id, self._unit.model:getSubRoomType(), path))
		end
	end
end

function M:_buildBillBoardUI(go, index)
	if not self._billBoardGroup then
		self._billBoardGroup = {}
	end

	local tmpMatSetter = MaterialSetter.Get(go)

	tmpMatSetter:SetGameObject(go)

	self._billBoardGroup[index] = tmpMatSetter
end

function M:_getBillBoardMatSetter(index)
	local setter

	if self._billBoardGroup and self._billBoardGroup[index] then
		setter = self._billBoardGroup[index]
	end

	return setter
end

function M:_unbuildView()
	self._billBoardGroup = nil
end

function M:getCanShowBillBoard()
	return self._canShowBillBoard
end

function M:setCanShowBillBoard(canshow)
	self._canShowBillBoard = canshow
end

function M:initView(cfgProtomerInfo)
	local billBoardPath = cfgProtomerInfo.billboardpath

	self:setCanShowBillBoard(billBoardPath and #billBoardPath > 0)

	if self:getCanShowBillBoard() then
		local protomerId = cfgProtomerInfo.id
		local toloadList = {}

		for i = 1, ContainmentEnum.billBoardCount do
			table.insert(toloadList, self:_getBillBoardResPath(protomerId, i))
		end

		self._resLoader:setResPaths(toloadList)
		self._resLoader:load(self._onAllAdditionalLoaded, self._onAdditionalLoaded, self)
	end
end

function M:_getBillBoardResPath(protomerId, billBoadId)
	if not self._resRootName then
		local cfg = ContainmentConfig.instance:getConfigByKey(ConfigName.HouseHoldProtomer, protomerId)
		local resCO = HouseConfig.instance:getRoomCOByType(HouseEnum.RoomType.Shelter, cfg.shelterRoomType)
		local sceneResStrs = string.split(resCO.resPath, "#")

		self._resRootName = sceneResStrs[2]
	end

	return GameUrl.getSceneRoomBillboardIcon(self._resRootName, protomerId, billBoadId)
end

function M:_onAllAdditionalLoaded(loader)
	self._resLoader:clear()
	self:_updateBillBoard()
end

function M:_onAdditionalLoaded(res)
	if not self._resDict then
		self._resDict = {}
	end

	if res.IsSuccess then
		res:Retain()

		self._resDict[res.ResPath] = res
	end
end

function M:getBillBoardRes(protomerId, billBoardId)
	local path = self:_getBillBoardResPath(protomerId, billBoardId)

	if self._resDict and self._resDict[path] then
		return self._resDict[path]:GetAsset(nil, nil)
	end

	return nil
end

function M:_onHouseHoldBillBoardChange()
	self:_updateBillBoard()
end

function M:_updateBillBoard()
	local subRoomTyp = self._unit.model:getSubRoomType()
	local protomerInfo = ProtomerModel.instance:getProtomerInfoByShelterRoomTyp(subRoomTyp)
	local billBoardLst
	local len = 0

	if protomerInfo then
		billBoardLst = protomerInfo:getBillBoardActiveTable()
		len = billBoardLst and #billBoardLst or 0
	end

	local billBoardMaxCount = ContainmentConfig.instance:getConstByKey("BillboardCount")

	for i = 1, billBoardMaxCount do
		local billBoardSetter = self:_getBillBoardMatSetter(i)

		if billBoardSetter then
			local show = i <= len

			if not self:getCanShowBillBoard() then
				show = false
			end

			if show then
				local index = 32 - billBoardLst[i] + 1
				local texture = self:getBillBoardRes(protomerInfo:getProtomerId(), index)

				if texture then
					billBoardSetter:SetTexture(UnityEngine.Shader.PropertyToID("_BaseMap"), texture)
				end
			end

			goutil.setActive(billBoardSetter.gameObject, show)
		end
	end
end

function M:tryGetBillBoardScreenPos(callBackFunc, callBackHandler)
	if self._roomResLoaded then
		self._getBillBoardReq = nil

		if callBackHandler and callBackFunc then
			callBackFunc(callBackHandler, self:getBillBoardScreenPos())
		end
	else
		self._getBillBoardReq = {
			func = callBackFunc,
			handler = callBackHandler
		}
	end
end

function M:_tryResponseGetBillBoardScreenPos()
	if self._getBillBoardReq then
		local func = self._getBillBoardReq.func
		local handler = self._getBillBoardReq.handler

		if func and handler then
			func(handler, self:getBillBoardScreenPos())
		end
	end

	self._getBillBoardReq = nil
end

function M:getBillBoardScreenPos()
	local returnPos
	local trans = self:_getBillBoardMatSetter(1)

	if trans then
		trans = trans.transform

		local theCamera = CameraTargetMgr.instance:getMainCameraTarget():getCamera()
		local worldPos = Vector3.New(Astral.TransformUtil.GetPos(trans, 0, 0, 0))

		returnPos = theCamera:WorldToScreenPoint(worldPos)
	end

	return returnPos
end

return M
