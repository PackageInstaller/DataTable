-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/model/branch/GuideBranchGoFirstStep.lua

module("logic.extensions.guide.model.branch.GuideBranchGoFirstStep", package.seeall)

local GuideBranchGoFirstStep = class("GuideBranchGoFirstStep", GuideBranchBase)

function GuideBranchGoFirstStep:shouldTrigger()
	local branch = GuideModel.instance:getGuideBranch(GuideConst.BRANCH_DRAG_BAIHU)

	if branch == nil or branch:isFinished() then
		if self._currGuide then
			return self._currGuide:shouldTrigger()
		end
	else
		return false
	end
end

function GuideBranchGoFirstStep:onEnterView(viewName)
	if self._currGuide then
		if viewName == "wuShenShouView" then
			local guideCfg = GuideConfig.instance
			local guideId = guideCfg:getBranchStartGuideId(self.branchId)

			print(">>>> 返回开始  白虎2 引导Id", self.branchId, guideId)

			return guideId
		end

		if viewName == "wuShenPrePareView" then
			print(">>>> 返回开始  白虎2 引导Id2sss", self.branchId, 3)

			return 3
		end
	end

	return 0
end

return GuideBranchGoFirstStep
