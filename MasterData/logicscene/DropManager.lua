-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/drop/DropManager.lua

module("logicscene.scene.drop.DropManager", package.seeall)

local DropManager = class("DropManager")

function DropManager:ctor()
	return
end

function DropManager:setResCopyType(resCopyType)
	self:clear()

	self._resCopyType = resCopyType
end

function DropManager:getDropItemPath(resCopyType)
	if not resCopyType then
		return
	end

	return DropBase.dropItemsPath[resCopyType]
end

function DropManager:drop(unit, num)
	if num == 0 then
		return
	end

	local dropNum = num - self._lastDropNum
	local dropUnit = 1

	if self._resCopyType == GameEnum.ResCopyType.Exp then
		dropUnit = 0.5
	elseif self._resCopyType == GameEnum.ResCopyType.Coin then
		dropUnit = 1000
	end

	dropNum = math.ceil(dropNum / dropUnit)

	if dropNum == 0 then
		return
	end

	self._lastDropNum = num

	for i = 1, dropNum do
		local drop = DropBase.New(self._resCopyType)

		drop:start(unit)

		self._drops = self._drops or {}

		table.insert(self._drops, drop)
	end
end

function DropManager:onDropFinished()
	if self._drops and #self._drops > 50 then
		self._drops[1]:clear()
		table.remove(self._drops, 1)
	end
end

function DropManager:clear()
	if self._drops then
		for i = 1, #self._drops do
			self._drops[i]:clear()
		end
	end

	self._lastDropNum = 0
	self._drops = nil
end

DropManager.instance = DropManager.New()

return DropManager
