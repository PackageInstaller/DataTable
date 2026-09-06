-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petintroduction/config/PetIntroductionConfig.lua

module("logic.extensions.firstshow.PetIntroductionConfig", package.seeall)

local PetIntroductionConfig = class("PetIntroductionConfig", BaseConfig)

function PetIntroductionConfig:getNames()
	return {
		"npc_introduction"
	}
end

function PetIntroductionConfig:handleConfig(name, content)
	if name == "npc_introduction" then
		self._npcIntroduction = content
	end
end

function PetIntroductionConfig:getNpcIntrodMoById(id)
	return self._npcIntroduction[id]
end

function PetIntroductionConfig:getNpcIntrodModelPathById(id)
	local npcIntrodCo = self:getNpcIntrodMoById(id)

	return StoryConst.getSpineUrl(npcIntrodCo.asset)
end

PetIntroductionConfig.instance = PetIntroductionConfig.New()

return PetIntroductionConfig
