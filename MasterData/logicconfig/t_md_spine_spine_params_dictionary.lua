-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_md_spine_spine_params_dictionary.lua

module("logicconfig.config.t_md_spine_spine_params_dictionary", package.seeall)

local title = {
	memberType = 4,
	spineParamDicId = 1,
	dataType = 5,
	paramType = 2,
	paramName = 3
}
local dataList = {
	{
		"PathPosition",
		"Spine.PathConstraint",
		"Position",
		"property",
		"float"
	},
	{
		"BoneX",
		"Spine.Bone",
		"X",
		"property",
		"float"
	},
	{
		"BoneY",
		"Spine.Bone",
		"Y",
		"property",
		"float"
	},
	{
		"BoneScaleX",
		"Spine.Bone",
		"ScaleX",
		"property",
		"float"
	},
	{
		"BoneScaleY",
		"Spine.Bone",
		"ScaleY",
		"property",
		"float"
	},
	{
		"BoneRotation",
		"Spine.Bone",
		"Rotation",
		"property",
		"float"
	}
}
local t_md_spine_spine_params_dictionary = {
	PathPosition = dataList[1],
	BoneX = dataList[2],
	BoneY = dataList[3],
	BoneScaleX = dataList[4],
	BoneScaleY = dataList[5],
	BoneRotation = dataList[6]
}

t_md_spine_spine_params_dictionary.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_md_spine_spine_params_dictionary
