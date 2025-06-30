-- chunkname: @IQIGame\\Module\\CommonActivity\\AmusementPark\\AmusementParkAnswerGame\\AmusementParkAnswerOptionData.lua

local m = {
	isRightOption = false,
	id = 0,
	content = ""
}

function m.New(index, content)
	local o = Clone(m)

	o:Init(index, content)

	return o
end

function m:Init(index, content)
	self.id = index
	self.isRightOption = self.id == 1
	self.content = content
end

return m
