-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/dreamHouse/model/DreamHouseMap.lua

DreamHouseMap = class("DreamHouseMap", objectlua.Object)

DreamHouseMap:has("_mapId", {
	is = "rw"
})
DreamHouseMap:has("_mapConfig", {
	is = "rw"
})
DreamHouseMap:has("_pointIds", {
	is = "rw"
})
DreamHouseMap:has("_points", {
	is = "rw"
})
DreamHouseMap:has("_isUnLock", {
	is = "rw"
})

local kPointImgTab = {
	{
		"dreamHouse_btn_guanqia1.png",
		"dreamHouse_img_guanqia1.png",
		"fire_btn_fbgq_bh.png"
	},
	{
		"dreamHouse_btn_guanqia2.png",
		"dreamHouse_img_guanqia2.png",
		"fire_btn_fbgq_kn.png"
	},
	{
		"dreamHouse_btn_guanqia3.png",
		"dreamHouse_img_guanqia3.png",
		"fire_btn_fbgq_pt.png"
	}
}

function DreamHouseMap:initialize(mapId)
	super.initialize(self)

	self._mapId = mapId
	self._mapConfig = ConfigReader:requireRecordById("DreamHouseMap", self._mapId)
	self._pointIds = self._mapConfig.PointId
	self._points = {}

	for i = 1, 3 do
		self._points[self._pointIds[i]] = DreamHousePoint:new(self._pointIds[i])

		self._points[self._pointIds[i]]:setInfoDiSrc(kPointImgTab[i][2])
		self._points[self._pointIds[i]]:setBattleDiSrc(kPointImgTab[i][1])
		self._points[self._pointIds[i]]:setBtnDiSrc(kPointImgTab[i][3])
	end

	self._isUnLock = false
end

function DreamHouseMap:synchronize(data)
	if data and data.maps then
		self._isUnLock = true

		for k, v in pairs(data.maps) do
			if self._points[k] then
				self._points[k]:synchronize(v)
				self._points[k]:setIsUnLock(true)
			end
		end
	end
end

function DreamHouseMap:delete(data)
	if data and data.maps then
		for k, v in pairs(data.maps) do
			self._points[k]:delete(v)
		end
	end
end

function DreamHouseMap:isLock()
	return not self._isUnLock
end

function DreamHouseMap:isPass()
	for _, v in pairs(self._points) do
		if not v:isPass() then
			return false
		end
	end

	return true
end

function DreamHouseMap:isFullStarPass()
	for _, v in pairs(self._points) do
		if not v:isPerfectPass() then
			return false
		end
	end

	return true
end

function DreamHouseMap:getPointById(id)
	return self._points[id]
end

function DreamHouseMap:getLastPointName()
	local pointData

	for i = #self._pointIds, 1, -1 do
		local pointId = self._pointIds[i]

		pointData = self._points[pointId]

		if self._points[pointId]:getIsUnLock() then
			local battleIds = pointData:getBattleIds()

			for j = #battleIds, 1, -1 do
				local battleData = pointData:getBattleById(battleIds[j])

				if battleData then
					return pointData:getPointName() .. "-" .. pointData:getBattleNameById(battleIds[j])
				end
			end
		end
	end

	return Strings:get("DreamHouse_Main_UI06")
end

function DreamHouseMap:getLastPointName2()
	local pointData

	for i = #self._pointIds, 1, -1 do
		local pointId = self._pointIds[i]

		pointData = self._points[pointId]

		if self._points[pointId]:getIsUnLock() then
			local battleIds = pointData:getBattleIds()

			for j = #battleIds, 1, -1 do
				local battleData = pointData:getBattleById(battleIds[j])

				if battleData then
					return pointData:getPointName() .. "-" .. pointData:getBattleNumWorldById(battleIds[j])
				end
			end
		end
	end

	return Strings:get("DreamHouse_Main_UI06")
end

function DreamHouseMap:getOpenPointIdx()
	if self:isPass() then
		for i = 1, 3 do
			local id = self._pointIds[i]

			if not self._points[id]:isPerfectPass() then
				return i
			end
		end
	else
		for i = 1, 3 do
			local id = self._pointIds[i]

			if not self._points[id]:isPass() then
				return i
			end
		end
	end

	return 1
end
