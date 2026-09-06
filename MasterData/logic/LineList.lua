-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rolerelationship/view/LineList.lua

module("logic.extensions.rolerelationship.view.LineList", package.seeall)

local LineList = class("LineList")

function LineList:ctor()
	self._lineCol = nil
	self._lineGo = nil
	self._linePool = nil
	self._lineList = {}
	self._objList = {}
end

function LineList.create(lineCol, lineGo)
	if lineCol == nil then
		printError("传入的“lineCol”实例为空")

		return nil
	end

	if lineGo == nil then
		printError("传入的“lineGo”实例为空")

		return nil
	end

	local instance = LineList.New()

	instance:_init(lineCol, lineGo)

	return instance
end

function LineList:showLine(posA, posB, key, fixLength)
	if self._lineList[key] then
		self:hideLine(key)
	end

	local go = self:_getLine()

	self._lineList[key] = go

	self:_setLine(posA, posB, go, fixLength)
end

function LineList:hideLine(key)
	local go = self._lineList[key]

	if go then
		self._lineList[key] = nil

		GameUtil.SetActive(go, false)
		table.insert(self._objList, go)
	end
end

function LineList:getLineGo(key)
	return self._lineList[key]
end

function LineList:_init(lineCol, lineGo)
	self._lineCol = lineCol
	self._lineGo = lineGo

	GameUtil.SetActive(self._lineGo, false)

	self._linePool = goutil.findChild(self._lineCol, "linePool")

	if not self._linePool then
		self._linePool = goutil.create("linePool")

		goutil.addChildToParent(self._linePool, self._lineCol)
		GameUtil.setLocalPos(self._linePool, 0, 0, 0)
	end

	local childList = GameUtil.getChildren(self._linePool)

	for _, go in ipairs(childList) do
		table.insert(self._objList, go)
	end
end

function LineList:_getLine()
	return table.remove(self._objList) or goutil.cloneAndSetParent(self._lineGo, self._linePool.transform)
end

function LineList:_setLine(posA, posB, go, fixLength)
	local x = math.abs(posA[1] - posB[1])
	local y = math.abs(posA[2] - posB[2])
	local distance = math.sqrt(x^2 + y^2)
	local angle = math.round(math.asin(y / distance) / math.pi * 180)

	if posB[1] >= posA[1] and posB[2] >= posA[2] then
		-- block empty
	elseif posB[1] <= posA[1] and posB[2] >= posA[2] then
		angle = 180 - angle
	elseif posB[1] <= posA[1] and posB[2] <= posA[2] then
		angle = 180 + angle
	elseif posB[1] >= posA[1] and posB[2] <= posA[2] then
		angle = 360 - angle
	end

	local linePosX, linePosY = posA[1], posA[2]

	distance = distance + checknumber(fixLength)

	if checknumber(fixLength) < 0 then
		local vec = Vector3.New(posB[1] - posA[1], posB[2] - posA[2], 0)
		local dir = Vector3.Normalize(vec) * fixLength / 2

		linePosX = linePosX - dir.x
		linePosY = linePosY - dir.y
	end

	GameUtil.setWidth(go, distance)
	GameUtil.setLocalRotation(go, 0, 0, angle)
	GameUtil.setLocalPos(go, linePosX, linePosY, 0)
	GameUtil.SetActive(go, true)
end

return LineList
