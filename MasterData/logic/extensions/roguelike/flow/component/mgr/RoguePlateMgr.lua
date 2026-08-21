-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/mgr/RoguePlateMgr.lua

module("logic.extensions.roguelike.flow.component.mgr.RoguePlateMgr", package.seeall)

local M = class("RoguePlateMgr", IRogueFlowComp)
local kPlateObjType = {
	Bin = 1,
	FBI = 4,
	House = 7,
	Chair = 3,
	Grass = 5,
	Netting = 10,
	Light = 8,
	Statue = 11,
	GuideBoard = 6,
	Tree = 12,
	Car = 2,
	Museum = 9,
	Block = 13
}
local kPlateTypeStr = {
	[kPlateObjType.Bin] = "bin",
	[kPlateObjType.Car] = "car",
	[kPlateObjType.Chair] = "chair",
	[kPlateObjType.FBI] = "fbi",
	[kPlateObjType.Grass] = "grass",
	[kPlateObjType.GuideBoard] = "guideboard",
	[kPlateObjType.House] = "house",
	[kPlateObjType.Light] = "light",
	[kPlateObjType.Museum] = "museum",
	[kPlateObjType.Netting] = "netting",
	[kPlateObjType.Statue] = "statue",
	[kPlateObjType.Tree] = "tree",
	[kPlateObjType.Block] = "block"
}
local kPlateObjCount = {
	[kPlateObjType.Bin] = 2,
	[kPlateObjType.Car] = 3,
	[kPlateObjType.Chair] = 1,
	[kPlateObjType.FBI] = 1,
	[kPlateObjType.Grass] = 3,
	[kPlateObjType.GuideBoard] = 5,
	[kPlateObjType.House] = 2,
	[kPlateObjType.Light] = 1,
	[kPlateObjType.Museum] = 1,
	[kPlateObjType.Netting] = 3,
	[kPlateObjType.Statue] = 4,
	[kPlateObjType.Tree] = 7,
	[kPlateObjType.Block] = 1
}
local kLetterIndex = {
	"a",
	"b",
	"c",
	"d",
	"e",
	"f",
	"g",
	"h",
	"i",
	"j",
	"k"
}
local plateObjPrefix = "common_pt606_new/prefab/%s"
local scenePrefix = "s606_plane_all_%s_%s_p"

function M:onInit()
	self._plateTypeDic = {}

	for k, v in pairs(kPlateTypeStr) do
		self._plateTypeDic[v] = k
	end
end

function M:_onAllResLoaded(loader)
	self._resLoader:clear()
end

function M:_onResLoaded(res)
	if res.IsSuccess then
		res:Retain()

		self._resDict[res.ResPath] = res
	end
end

function M:getRes(resPath)
	return self._resDict[resPath]
end

function M:getAsset(resPath)
	return self:getRes(resPath):GetAsset(nil, nil)
end

function M:getObjPath(typeStr, index)
	local count = kPlateObjCount[self._plateTypeDic[typeStr]]

	if count then
		local randCount = math.random(1, count)

		randCount = index or randCount

		local name = string.format(scenePrefix, typeStr, kLetterIndex[randCount])

		return GameUrl.getScenePrefabUrl(string.format(plateObjPrefix, name))
	end

	return ""
end

function M:generatePlateObj(plate)
	local parent = plate.transform:GetChild(0):GetChild(0)
	local anchorCount = parent.childCount - 2
	local halfCount = math.ceil(anchorCount / 1.3)
	local randCount = math.random(halfCount, math.min(anchorCount, 20))
	local randSequence = self:getRandomIndex(anchorCount, randCount)
	local objs = {}

	for k, v in pairs(randSequence or {}) do
		local child = parent:GetChild(v - 1)

		if child.childCount > 0 then
			local lastChild = child:GetChild(0)
			local childName = lastChild.name
			local plateTypeName = childName

			if string.find(childName, ",") then
				local platys = string.split(childName, ",")

				plateTypeName = platys[math.random(1, #platys)]
			end

			if string.find(plateTypeName, kPlateTypeStr[kPlateObjType.Block]) == nil then
				local plateObj = RogueUnitCompPlateObj.New(lastChild)

				plateObj:loadAsset(plateTypeName)
				table.insert(objs, plateObj)
			end
		end
	end

	return objs
end

function M:getRandomIndex(total, count)
	local sequence = {}
	local randSequence = {}

	for i = 1, total do
		table.insert(sequence, i)
	end

	local endIndex = #sequence

	count = endIndex < count and endIndex or count

	function swap(idx1, idx2)
		local temp = sequence[idx1]

		sequence[idx1] = sequence[idx2]
		sequence[idx2] = temp
	end

	for i = 1, count do
		local temp = math.random(1, endIndex)

		table.insert(randSequence, sequence[temp])
		swap(temp, endIndex)

		endIndex = endIndex - 1
	end

	return randSequence
end

return M
