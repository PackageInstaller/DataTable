-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/model/branch/GuideBranchCatchPet.lua

module("logic.extensions.guide.model.branch.GuideBranchCatchPet", package.seeall)

local GuideBranchCatchPet = class("GuideBranchCatchPet", GuideBranchBase)

function GuideBranchCatchPet:shouldTrigger()
	if self._currGuide then
		local petId = BattleFacade.instance:getCatchPetId()

		if not petId or petId == 0 then
			printInfo("shouldTrigger ================== 2")

			return
		end

		if not BattleFacade.instance:hasBattleItemsNum() then
			printInfo("shouldTrigger ================== 3")

			return
		end
	end

	printInfo("shouldTrigger ================== 1")

	return GuideBranchCatchPet.super.shouldTrigger(self)
end

function GuideBranchCatchPet:startGuide()
	GuideBranchCatchPet.super.startGuide(self)

	if self:isGuiding() then
		BattleFacade.instance:setBattlePause(true)
	end
end

function GuideBranchCatchPet:finishGuide()
	GuideBranchCatchPet.super.finishGuide(self)
	BattleFacade.instance:setBattlePause(false)
end

return GuideBranchCatchPet
