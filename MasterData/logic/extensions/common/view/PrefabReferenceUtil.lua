-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/PrefabReferenceUtil.lua

module("logic.extensions.common.view.PrefabReferenceUtil", package.seeall)

local PrefabReferenceUtil = {}

function PrefabReferenceUtil.createCurrencyCostLuaCell(emptyGo)
	local go = PrefabReferenceUtil._instancePrefab(emptyGo)
	local cell = go and Astral.LuaComponentContainer.Add(go, CurrencyCostItem)

	return cell
end

function PrefabReferenceUtil._instancePrefab(parentGo)
	local prefabRefClass = parentGo:GetComponent(typeof(PrefabReference))

	if prefabRefClass then
		local instranceGo = prefabRefClass:InstancePrefab()

		return instranceGo
	end
end

return PrefabReferenceUtil
