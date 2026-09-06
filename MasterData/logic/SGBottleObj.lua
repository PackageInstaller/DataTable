-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarycake/view/spheregame/SGBottleObj.lua

module("logic.extensions.anniversarycake.view.spheregame.SGBottleObj", package.seeall)

local SGBottleObj = class("SGBottleObj")

function SGBottleObj:ctor()
	self._sgchildObj = {}
	self._maxChildCount = 4
end

function SGBottleObj:buildUI(go)
	self.mainGO = go
	self._node = goutil.findChild(self.mainGO, "node")
	self._btnBottle = Framework.ButtonAdapter.Get(self._node)
	self._posGoList = {}

	for i = 1, self._maxChildCount do
		self._posGoList[i] = goutil.findChild(self.mainGO, "node/pos" .. i)
	end

	self._topGo = goutil.findChild(self.mainGO, "node/top")
end

function SGBottleObj:onEnter()
	self._btnBottle:AddClickListener(self._onClickBottle, self)
	table.clear(self._sgchildObj)
end

function SGBottleObj:onExit()
	self._btnBottle:RemoveClickListener()
	table.clear(self._sgchildObj)
end

function SGBottleObj:_onClickBottle()
	GlobalDispatcher:dispatch(GlobalNotify.onSGClickBottle, self)
end

function SGBottleObj:getGo()
	return self.mainGO
end

function SGBottleObj:isSameColorOrNil()
	local count = #self._sgchildObj

	if count == 0 then
		return true
	end

	if count == self._maxChildCount then
		local color = {}

		for i, v in ipairs(self._sgchildObj) do
			local index = v:getColorIndex()

			color[index] = not color[index] and 1 or color[index] + 1

			if color[index] == self._maxChildCount then
				return true
			end
		end
	end

	return false
end

function SGBottleObj:addObj(childObj, colorIndex)
	local isSuccess = false

	if not self:isMax() then
		if colorIndex then
			childObj:setColorIndex(colorIndex)
		end

		table.insert(self._sgchildObj, childObj)

		local childGo = childObj:getGo()

		childGo.transform:SetParent(self._node.transform, true)

		isSuccess = true

		return true
	end

	return isSuccess
end

function SGBottleObj:removeObj()
	if #self._sgchildObj > 0 then
		return (table.remove(self._sgchildObj, #self._sgchildObj))
	end
end

function SGBottleObj:removeTopObj()
	local index = #self._sgchildObj

	if index > 0 then
		return table.remove(self._sgchildObj, index)
	end
end

function SGBottleObj:updateChildPos()
	for i, v in ipairs(self._sgchildObj) do
		if self._posGoList[i] then
			local childGo = v:getGo()
			local position = self._posGoList[i].transform.position

			GameUtil.setPos(childGo, position.x, position.y, position.z)
		end
	end
end

function SGBottleObj:isEmpty()
	return #self._sgchildObj == 0
end

function SGBottleObj:isMax()
	return #self._sgchildObj == self._maxChildCount
end

function SGBottleObj:getTopColorIndex()
	local count = #self._sgchildObj

	if count > 0 then
		return self._sgchildObj[count]:getColorIndex()
	else
		return 0
	end
end

function SGBottleObj:getTopPosition()
	return self._topGo.transform.position
end

function SGBottleObj:moveChildToTop()
	if not self:isEmpty() then
		local childObj = self._sgchildObj[#self._sgchildObj]

		childObj:moveTo(self:getTopPosition())
	end
end

function SGBottleObj:moveChildToBottom()
	if not self:isEmpty() then
		local index = #self._sgchildObj
		local childObj = self._sgchildObj[index]
		local targetPos = self._posGoList[index].transform.position

		childObj:moveTo(targetPos)
	end
end

function SGBottleObj:moveToTopAndBottom()
	if self:isEmpty() then
		return
	end

	local pos1 = self:getTopPosition()
	local pos2 = self._posGoList[#self._sgchildObj].transform.position
	local index = #self._sgchildObj
	local childObj = self._sgchildObj[index]

	childObj:moveToPositions(pos1, pos2)
end

function SGBottleObj:moveChildToAnother(sgBottleObj)
	if not sgBottleObj then
		return
	end

	local childObj = self:removeTopObj()

	if childObj then
		local isSuccess = sgBottleObj:addObj(childObj)

		sgBottleObj:moveToTopAndBottom()
	end
end

return SGBottleObj
