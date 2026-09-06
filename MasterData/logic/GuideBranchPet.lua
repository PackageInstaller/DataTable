-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/model/branch/GuideBranchPet.lua

module("logic.extensions.guide.model.branch.GuideBranchPet", package.seeall)

local GuideBranchPet = class("GuideBranchPet", GuideBranchBase)

function GuideBranchPet:shouldTrigger()
	if self._currGuide then
		local guideId = self._currGuide:getGuideId()

		if guideId == 430 and not GuideController.instance.isBagPetDetailsShow then
			return
		end

		if guideId == 1700 then
			return
		end
	end

	return GuideBranchPet.super.shouldTrigger(self)
end

function GuideBranchPet:onExitView(viewName)
	if self._currGuide and viewName == ViewName.BagPets then
		local guideId = self._currGuide:getGuideId()

		if guideId == 440 then
			return 430
		end

		if guideId == 1710 or guide == 1720 or guide == 1730 then
			return 1700
		end
	end

	return 0
end

function GuideBranchPet:onEnterView(viewName)
	if self._currGuide then
		GlobalDispatcher:dispatch(GlobalNotify.BagPetsStopAnimator)

		if viewName == ViewName.BagPets then
			local guideId = self._currGuide:getGuideId()

			if guideId == 440 or guideId == 430 then
				return 430
			end

			if guideId == 1710 or guide == 1720 or guide == 1730 then
				return 1700
			end
		end
	end

	return 0
end

return GuideBranchPet
