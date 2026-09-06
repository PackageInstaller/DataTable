-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/model/branch/GuideBranchPetEgg.lua

module("logic.extensions.guide.model.branch.GuideBranchPetEgg", package.seeall)

local GuideBranchPetEgg = class("GuideBranchPetEgg", GuideBranchBase)

function GuideBranchPetEgg:shouldTrigger()
	if self._currGuide then
		local guideId = self._currGuide:getGuideId()

		if guideId == 320 then
			if not self:_hasEggHatchedOk() then
				return
			end
		elseif guideId == 300 or guideId == 310 then
			local materials = MaterialFacade.instance:getMaterialInfoByType(MatType.Egg)

			dump(materials)

			if not materials or #materials == 0 then
				return
			end
		end
	end

	return GuideBranchPetEgg.super.shouldTrigger(self)
end

function GuideBranchPetEgg:setGuide(guideId)
	GuideBranchPetEgg.super.setGuide(self, guideId)

	if guideId == 320 then
		removetimer(self._tickEggHatchedOk, self)

		if not self:_hasEggHatchedOk() then
			settimer(0.2, self._tickEggHatchedOk, self)
		end
	else
		removetimer(self._tickEggHatchedOk, self)
	end
end

function GuideBranchPetEgg:forceToInView(viewName)
	if self._currGuide and viewName == "petegg" then
		local guideId = self._currGuide:getGuideId()

		if guideId ~= 320 and self:_hasEggHatchedOk() then
			return 320
		end
	end

	return 0
end

function GuideBranchPetEgg:_hasEggHatchedOk()
	if PetEggModel.instance:isHatcherEmpty(1) then
		return
	end

	local infos = PetEggModel.instance:getHatchInfos()

	if not infos or not infos[1] then
		return
	end

	local info = infos[1]
	local hatchOutTime = info.hatchOutTime / 1000 - ServerTime.now() <= 0

	if not hatchOutTime then
		return nil
	end

	return true
end

function GuideBranchPetEgg:_tickEggHatchedOk()
	if self:_hasEggHatchedOk() then
		removetimer(self._tickEggHatchedOk, self)
		GuideController.instance:onHatchEggInfoBack()
	end
end

return GuideBranchPetEgg
