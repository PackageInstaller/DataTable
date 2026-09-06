-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/data/ShowDownFormMo.lua

module("logic.extensions.showdown.data.ShowDownFormMo", package.seeall)

local ShowDownFormMo = class("ShowDownFormMo")

function ShowDownFormMo:ctor()
	self._simpleForm = nil
	self._buffId = 0
	self._petIdList = {}
end

function ShowDownFormMo:onReset()
	self._simpleForm = nil
	self._buffId = 0

	table.clear(self._petIdList)
end

function ShowDownFormMo:updateData(value)
	self._simpleForm = GameUtil.pbToTable(value.formation)
	self._buffId = value.buffId

	table.clear(self._petIdList)

	if self._simpleForm then
		for i, petId in ipairs(self._simpleForm.pos) do
			if petId > 0 then
				table.insert(self._petIdList, petId)
			end
		end
	end
end

function ShowDownFormMo:getSimpleForm()
	return self._simpleForm
end

function ShowDownFormMo:isEmptyForm()
	local result = true

	if self._simpleForm then
		for i, v in pairs(self._simpleForm.pos) do
			if checknumber(v) > 0 then
				result = false

				break
			end
		end
	end

	return result
end

function ShowDownFormMo:getBuffId()
	return self._buffId
end

function ShowDownFormMo:getPetIdList()
	return self._petIdList
end

return ShowDownFormMo
