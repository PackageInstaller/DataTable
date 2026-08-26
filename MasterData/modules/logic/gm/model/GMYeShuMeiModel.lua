-- chunkname: @modules/logic/gm/model/GMYeShuMeiModel.lua

module("modules.logic.gm.model.GMYeShuMeiModel", package.seeall)

local GMYeShuMeiModel = class("GMYeShuMeiModel", BaseModel)

function GMYeShuMeiModel:onInit()
	return
end

function GMYeShuMeiModel:reInit()
	self:clearData()
end

function GMYeShuMeiModel:getAllLevelData()
	self._allLevelData = YeShuMeiConfig.instance:getYeShuMeiLevelData()
end

function GMYeShuMeiModel:setCurLevelId(levelId)
	self:getAllLevelData()

	self._copyData = tabletool.copy(self._allLevelData)

	local levelData

	for id, data in pairs(self._copyData) do
		if id == levelId then
			levelData = data

			break
		end
	end

	if levelData == nil then
		self._curLevelData = YeShuMeiLevelMo.New(levelId)
		self._copyData[levelId] = self._curLevelData
	else
		self._curLevelData = levelData
	end

	return self._curLevelData
end

function GMYeShuMeiModel:getCurLevelData()
	return self._curLevelData
end

function GMYeShuMeiModel:addPoint()
	if self._curLevelData == nil then
		return
	end

	local id = 0

	if self._curLevelData.points == nil then
		self._curLevelData.points = {}
	else
		for i = 1, #self._curLevelData.points do
			local data = self._curLevelData.points[i]

			if id < data.id then
				id = data.id
			end
		end

		id = id + 1
	end

	local pointData = {}

	pointData = id == 1 and GMYeShuMeiPointMo.New(3, id) or GMYeShuMeiPointMo.New(1, id)

	table.insert(self._curLevelData.points, pointData)

	return pointData
end

function GMYeShuMeiModel:deletePoint(id)
	if self._curLevelData == nil then
		return
	end

	if self._curLevelData.points == nil then
		return
	end

	for i = 1, #self._curLevelData.points do
		local pointData = self._curLevelData.points[i]

		if pointData.id == id then
			table.remove(self._curLevelData.points, i)

			break
		end
	end
end

function GMYeShuMeiModel:addLines()
	local id = 0

	if self._curLevelData.lines == nil then
		self._curLevelData.lines = {}
	else
		for i = 1, #self._curLevelData.lines do
			local data = self._curLevelData.lines[i]

			if id < data.id then
				id = data.id
			end
		end

		id = id + 1
	end

	local lineData = YeShuMeiLineMo.New(id)

	table.insert(self._curLevelData.lines, lineData)

	return lineData
end

function GMYeShuMeiModel:deleteLines(id)
	if self._curLevelData == nil then
		return
	end

	if self._curLevelData.lines == nil then
		return
	end

	for i = 1, #self._curLevelData.lines do
		local lineData = self._curLevelData.lines[i]

		if lineData.id == id then
			table.remove(self._curLevelData.lines, i)

			break
		end
	end
end

function GMYeShuMeiModel:checkLineExist(PointIdA, PointIdB)
	for _, linemo in ipairs(self._curLevelData.lines) do
		if linemo:havePoint(PointIdA, PointIdB) then
			return true
		end
	end

	return false
end

function GMYeShuMeiModel:addOrders(str)
	if self._curLevelData == nil then
		return
	end

	if self._curLevelData.orders == nil then
		self._curLevelData.orders = {}
	end

	if not tabletool.indexOf(self._curLevelData.orders, str) then
		table.insert(self._curLevelData.orders, str)

		return true
	end

	return false
end

function GMYeShuMeiModel:deleteOrders(str)
	if self._curLevelData == nil then
		return
	end

	if self._curLevelData.orders == nil then
		return
	end

	for index, value in ipairs(self._curLevelData.orders) do
		if value == str then
			table.remove(self._curLevelData.orders, index)

			break
		end
	end
end

function GMYeShuMeiModel:setCurLevelOrder(str)
	if self._curLevelData == nil then
		return
	end

	if self._curLevelData.orders == nil then
		return
	end

	self._curLevelOrder = str
end

function GMYeShuMeiModel:getCurLevelOrder()
	return self._curLevelOrder
end

function GMYeShuMeiModel:saveAndExport()
	if self._copyData == nil then
		return
	end

	for _, levelData in pairs(self._copyData) do
		local replaceLineIds = {}

		if levelData.lines ~= nil then
			local lineMap = {}

			for i = 1, #levelData.lines do
				local line = levelData.lines[i]
				local key1 = line._beginPointId .. "_" .. line._endPointId
				local key2 = line._endPointId .. "_" .. line._beginPointId

				if lineMap[key1] == nil or lineMap[key2] == nil then
					lineMap[key1] = line
					lineMap[key2] = line
				else
					if replaceLineIds[key1] == nil then
						replaceLineIds[key1] = {}
					end

					table.insert(replaceLineIds[key1], line.id)
				end
			end
		end

		for _, lineIds in pairs(replaceLineIds) do
			if #lineIds > 0 then
				for i = 1, #lineIds do
					local lineId = lineIds[i]

					if levelData.lines == nil then
						break
					end

					for j = 1, #levelData.lines do
						local line = levelData.lines[j]

						if line.id == lineId then
							table.remove(levelData.lines, j)

							break
						end
					end
				end
			end
		end

		if levelData.lines ~= nil then
			local count = #levelData.lines

			for i = count, -1 do
				local data = levelData.lines[i]
				local pointId1 = data._beginPointId
				local pointId2 = data._endPointId
				local havePoint1 = false
				local havePoint2 = false

				for j = 1, #levelData.points do
					local point = levelData.points[j]

					if pointId1 and point.id == pointId1 then
						havePoint1 = true
					end

					if pointId2 and point.id == pointId2 then
						havePoint2 = true
					end
				end

				if pointId1 == nil or pointId2 == nil or not havePoint2 or not havePoint1 then
					table.remove(levelData.lines, i)
				end
			end
		end

		if levelData.orders ~= nil then
			for index, order in ipairs(levelData.orders) do
				if string.nilorempty(order) then
					table.remove(levelData.orders, index)
				end
			end
		end
	end

	local str = ""

	str = "return { \n"

	for _, levelData in pairs(self._copyData) do
		str = str .. "{" .. levelData:getStr() .. "},\n"
	end

	str = str .. "}\n"

	local path = "Assets/ZProj/Scripts/Lua/modules/configs/yeshumei/" .. YeShuMeiConfig.instance._ActivityDataName .. ".lua"

	logNormal("GMYeShuMeiModel:saveAndExport:", str)
	logNormal("GMYeShuMeiModel:saveAndExport Path: ", path)
	logError("保存成功~")

	local fileHelper = SLFramework.FileHelper

	fileHelper.EnsureDirForFile(path)
	fileHelper.WriteTextToPath(path, str)
end

function GMYeShuMeiModel:clearData()
	if self._curLevelData and #self._curLevelData.points > 0 then
		for index, value in ipairs(self._curLevelData.points) do
			value = nil
		end
	end

	self._copyData = nil
	self._curLevelData = nil
end

GMYeShuMeiModel.instance = GMYeShuMeiModel.New()

return GMYeShuMeiModel
