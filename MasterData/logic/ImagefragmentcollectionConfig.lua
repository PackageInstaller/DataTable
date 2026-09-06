-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/imagefragmentcollection/config/ImagefragmentcollectionConfig.lua

module("logic.extensions.imagefragmentcollection.config.ImagefragmentcollectionConfig", package.seeall)

local ImagefragmentcollectionConfig = class("ImagefragmentcollectionConfig", BaseConfig)

function ImagefragmentcollectionConfig:onInit()
	return
end

function ImagefragmentcollectionConfig:getNames()
	return {
		"image_fragment_collection",
		"image_fragment_collection_params",
		"image_fragment_collection_prize",
		"image_fragment_collection_mass_prize",
		"image_fragment_collection_fragment"
	}
end

function ImagefragmentcollectionConfig:handleConfig(name, content)
	if name == "image_fragment_collection" then
		self._image_fragment_collection = content
	elseif name == "image_fragment_collection_params" then
		self._image_fragment_collection_params = content
	elseif name == "image_fragment_collection_prize" then
		self._image_fragment_collection_prize = content
	elseif name == "image_fragment_collection_mass_prize" then
		self._image_fragment_collection_mass_prize = content
	elseif name == "image_fragment_collection_fragment" then
		self._image_fragment_collection_fragment = content
	end
end

function ImagefragmentcollectionConfig:getCollectionCfg(actId)
	return self._image_fragment_collection[actId]
end

function ImagefragmentcollectionConfig:getPrizePlanCfgs(prizePlanId)
	return self._image_fragment_collection_prize[prizePlanId]
end

function ImagefragmentcollectionConfig:getFragmentPlanCfgs(fragmentPlanId)
	return self._image_fragment_collection_fragment[fragmentPlanId]
end

function ImagefragmentcollectionConfig:getMassPrizePlanCfgs(massPrizePlanId)
	return self._image_fragment_collection_mass_prize[massPrizePlanId]
end

function ImagefragmentcollectionConfig:getDayliUnlockFragmentNum()
	return checknumber(self._image_fragment_collection_params.DAILY_UNLOCK_NUM.value)
end

ImagefragmentcollectionConfig.instance = ImagefragmentcollectionConfig.New()

return ImagefragmentcollectionConfig
