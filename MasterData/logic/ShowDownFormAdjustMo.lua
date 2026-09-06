-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/data/ShowDownFormAdjustMo.lua

module("logic.extensions.showdown.data.ShowDownFormAdjustMo", package.seeall)

local ShowDownFormAdjustMo = class("ShowDownFormAdjustMo")

function ShowDownFormAdjustMo:ctor()
	self._formDic = {}
	self._userIdList = {}
end

function ShowDownFormAdjustMo:onReset()
	table.clear(self._formDic)
	table.clear(self._userIdList)
end

function ShowDownFormAdjustMo:updateData(value)
	table.clear(self._formDic)
	table.clear(self._userIdList)

	for _, v in ipairs(value) do
		local userId = v.userId

		self._formDic[userId] = ShowDownFormMo.New()

		self._formDic[userId]:updateData(v.formList)
		table.insert(self._userIdList, userId)
	end
end

function ShowDownFormAdjustMo:getForm(userId)
	return self._formDic[userId]
end

function ShowDownFormAdjustMo:getUserIdList()
	return self._userIdList
end

function ShowDownFormAdjustMo:setUserIdList(value)
	self._userIdList = value
end

function ShowDownFormAdjustMo:getIndexInUserId(userId)
	for i = 1, #self._userIdList do
		if self._userIdList[i] == value then
			return i
		end
	end

	return 0
end

return ShowDownFormAdjustMo
