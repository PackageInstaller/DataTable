-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/monument/MonumentUtil.lua

module("logic.extensions.playerinfo.view.monument.MonumentUtil", package.seeall)

local materials = {
	"ma_syndrome_card_item_copy_add_1",
	"ma_syndrome_card_item_copy_add_2",
	"ma_syndrome_card_item_copy_add_3"
}
local matLoader = MultiResLoader.New()
local isDone = false

function isLoaded()
	return isDone
end

function getMaterial(index)
	local resPath = GameUrl.getMonumentMaterial(materials[index])

	return matLoader:getResource(resPath):GetMainAsset()
end

function loadMaterials()
	for i, v in ipairs(materials) do
		local url = GameUrl.getMonumentMaterial(v)

		matLoader:addResPath(url)
	end

	matLoader:load(onMaterialsLoaded, false, self)
end

function onMaterialsLoaded()
	if matLoader:isAllSuccess() then
		isDone = true
	end
end

function clear()
	matLoader:clear()

	isDone = false
end
