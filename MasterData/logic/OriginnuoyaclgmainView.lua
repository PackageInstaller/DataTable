-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originnuoya/view/OriginnuoyaclgmainView.lua

module("logic.extensions.originnuoya.view.OriginnuoyaclgmainView", package.seeall)

local OriginnuoyaclgmainView = class("OriginnuoyaclgmainView", DivineDakinosClgMainView)

function OriginnuoyaclgmainView:_onOpenClgStageView(stageId)
	UIStateManager.instance:push(ViewName.OriginnuoyaclgstageView, self._activityId, stageId)
end

function OriginnuoyaclgmainView:_updateUIByInfo()
	local pb = DivineDakinosClgModel.instance:getInfo(self._activityId) or {}
	local phaseInfoMap = {}

	for i, info in ipairs(pb.phaseList or {}) do
		phaseInfoMap[info.phaseId] = info
	end

	local cfg = DivineDakinosClgConfig.instance:getActCfg(self._activityId) or {}

	if not cfg.lockDesc then
		local lockDesc = ""

		for i, v in ipairs(self._stageList) do
			local info = phaseInfoMap[i]

			goutil.setActive(v.pass, false)

			local saveNum = 0

			if info then
				goutil.setActive(v.pass, info.gainPrize)

				for k, saveInfo in ipairs(info.stageIdAndSaveCount) do
					saveNum = saveNum + saveInfo.right
				end
			end

			v.txtSaveNum.text = string.format("已获得 %s %s", saveNum, lockDesc)
		end
	end
end

return OriginnuoyaclgmainView
