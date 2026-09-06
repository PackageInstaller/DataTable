-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesswaken/view/GoddessWakenTaskViewPresentor.lua

module("logic.extensions.goddesswaken.view.GoddessWakenTaskViewPresentor", package.seeall)

local GoddessWakenTaskViewPresentor = class("GoddessWakenTaskViewPresentor", ViewPresentor)

function GoddessWakenTaskViewPresentor:ctor()
	GoddessWakenTaskViewPresentor.super.ctor(self)
end

function GoddessWakenTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GoddessWakenTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesswaken/goddesswakentaskview.prefab"
	}
end

function GoddessWakenTaskViewPresentor:buildViews()
	return {
		GoddessWakenTaskView.New()
	}
end

function GoddessWakenTaskViewPresentor:getTempResources()
	local goddessId = self:getFirstParam()
	local petPlanId = GoddessWakenModel.instance:getPetPlanId()
	local cfg = GoddessWakenConfig.instance:getUICfg(petPlanId, goddessId)
	local result = {}

	if cfg then
		local path = string.format("ui/bigbg/goddesswaken/%s.png", cfg.taskBgName)

		table.insert(result, path)
	end

	return result
end

return GoddessWakenTaskViewPresentor
