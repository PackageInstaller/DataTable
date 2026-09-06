-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/viewlib/usualviews/ItemFilterExt.lua

module("logiccommon.common.viewlib.usualviews.ItemFilterExt", package.seeall)

local ItemFilterExt = class("ItemFilterExt", ItemFilter)

function ItemFilterExt:ctor(go, startIndex, endIndex, isIncompatible, preName, selectedName)
	ItemFilterExt.super.ctor(self, go, startIndex, endIndex, isIncompatible, preName, selectedName)
end

function ItemFilterExt:unbindEvents()
	ItemFilterExt.super.unbindEvents(self)

	self.activeList = nil
	self.clickAbleList = nil
end

function ItemFilterExt:initActiveList(list)
	self.activeList = list

	for k, v in pairs(self._filters) do
		if self.activeList ~= nil then
			GameUtil.SetActive(v.mainGO, self.activeList[k])
		else
			GameUtil.SetActive(v.mainGO, true)
		end
	end
end

function ItemFilterExt:initClickAble(list)
	self.clickAbleList = list

	for k, v in pairs(self._filters) do
		local lockGo = goutil.findChild(v.mainGO, "imgLock")

		if list ~= nil then
			GameUtil.SetActive(lockGo, not list[k])
		else
			GameUtil.SetActive(lockGo, false)
		end
	end
end

function ItemFilterExt:_onClickFilter(i)
	if self.clickAbleList ~= nil and self.clickAbleList[i] == true then
		local isChecked = self:getIsChecked(i)

		self:setSelectedActive(i, not isChecked)

		if self._isIncompatible then
			for index = self._startIndex, self._endIndex do
				if i ~= index then
					self:setSelectedActive(index, false)
				end
			end
		end

		GameUtil.callBack(self._handle, self._handleTarget)
	end
end

return ItemFilterExt
