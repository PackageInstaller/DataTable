-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/view/feiniyaclothes/FeiNiYaClothesMemoryProfile.lua

module("logic.extensions.spineinterface.view.feiniyaclothes.FeiNiYaClothesMemoryProfile", package.seeall)

local FeiNiYaClothesMemoryProfile = class("FeiNiYaClothesMemoryProfile")

FeiNiYaClothesMemoryProfile.profileId = "FeiNiYaClothes"
FeiNiYaClothesMemoryProfile.version = 2

local PARTS = {
	{
		key = "clothes",
		trackIndex = 2,
		paramId = 1,
		validValues = {
			[0] = true,
			true
		},
		animNames = {
			[1] = "2-1_1"
		}
	},
	{
		key = "shoes",
		trackIndex = 3,
		paramId = 2,
		validValues = {
			[0] = true,
			true,
			true,
			true
		},
		animNames = {
			"2-2_1",
			"2-2_2",
			"2-2_3"
		}
	},
	{
		key = "hair",
		trackIndex = 4,
		paramId = 3,
		validValues = {
			[0] = true,
			true,
			true
		},
		animNames = {
			[1] = "2-3_1",
			[2] = "2-3_2"
		}
	},
	{
		key = "headwear",
		trackIndex = 5,
		paramId = 4,
		validValues = {
			[0] = true,
			true,
			true
		},
		animNames = {
			[1] = "2-4_1",
			[2] = "2-4_2"
		}
	},
	{
		key = "headwearExtra",
		trackIndex = 6,
		paramId = 5,
		validValues = {
			[0] = true,
			true
		},
		animNames = {
			[1] = "2-4_3"
		}
	}
}

function FeiNiYaClothesMemoryProfile:capture(comp)
	if comp == nil or not comp.isSpineReloaded or not comp:isSpineReloaded() then
		return nil
	end

	local snapshot = {
		profileId = self.profileId,
		version = self.version
	}

	for _, part in ipairs(PARTS) do
		snapshot[part.key] = checknumber(comp:getParamValue(MsEnum.ParamMgrType.Public, part.paramId))
	end

	return snapshot
end

function FeiNiYaClothesMemoryProfile:validate(snapshot)
	if type(snapshot) ~= "table" then
		return false
	end

	if snapshot.profileId ~= self.profileId or checknumber(snapshot.version) ~= self.version then
		return false
	end

	for _, part in ipairs(PARTS) do
		local value = checknumber(snapshot[part.key])

		if not part.validValues[value] then
			return false
		end
	end

	return true
end

function FeiNiYaClothesMemoryProfile:restore(comp, snapshot)
	if comp == nil or not self:validate(snapshot) then
		return
	end

	for _, part in ipairs(PARTS) do
		local value = checknumber(snapshot[part.key])

		comp:setParamValue(MsEnum.ParamMgrType.Public, part.paramId, value)

		local animName = part.animNames[value]

		if string.nilorempty(animName) then
			comp:_exitTrackKeep(part.trackIndex)
		else
			comp:_applySpineAnimFinalFrame(animName, part.trackIndex)
		end
	end
end

return FeiNiYaClothesMemoryProfile
