-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/util/DifficultyUtil.lua

module("logic.common.util.DifficultyUtil", package.seeall)

function setDifficultyFlag(obj, scoreCo)
	local id = scoreCo.index
	local count = obj.transform.childCount

	for i = 0, count - 1 do
		local childGo = obj.transform:GetChild(i).gameObject

		goutil.setActive(childGo, i == id - 1)
	end
end
