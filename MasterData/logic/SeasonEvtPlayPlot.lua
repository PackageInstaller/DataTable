-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/evt/impl/SeasonEvtPlayPlot.lua

module("logic.extensions.season.model.evt.impl.SeasonEvtPlayPlot", package.seeall)

local SeasonEvtPlayPlot = class("SeasonEvtPlayPlot", SeasonEvtBase)

function SeasonEvtPlayPlot:handleSeasonInfoUpdate()
	local seasonId = SeasonModel.instance:getSeasonId()
	local seasonInfoData = SeasonModel.instance:getSeasonInfoData(seasonId)

	if seasonInfoData and seasonInfoData.nowFragmentNum == seasonInfoData.maxFragmentNum then
		GlobalDispatcher:removeListener(GlobalNotify.SeasonInfoUpdate, self.handleSeasonInfoUpdate, self)
		UIStateManager.instance:push(ViewName.SeasonPaintView, seasonId, true)
	end
end

function SeasonEvtPlayPlot:_doServer(evtType, params, evtConfig, evtDetailConfig, msg)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	self:applyDestroy()

	if checknumber(evtDetailConfig.fragmentId) > 0 then
		local seasonId = SeasonModel.instance:getSeasonId()

		SeasonModel.instance:addFragment(seasonId, evtDetailConfig.fragmentId)
	end

	UIStateManager.instance:push(ViewName.SeasonStoryGridShowView, {
		zoomTargetName = "btnPaint",
		strDesc = evtDetailConfig.desc,
		strTitle = langPara("剧情地块(%s,%s)", params.toGridX, params.toGridY),
		strSure = lang("confirm"),
		strPrize = evtDetailConfig.prize,
		evtDetailConfig = evtDetailConfig,
		evtConfig = evtConfig,
		animCallback = function()
			self:showPrize(msg)
			GlobalDispatcher:removeListener(GlobalNotify.SeasonInfoUpdate, self.handleSeasonInfoUpdate, self)
			GlobalDispatcher:addListener(GlobalNotify.SeasonInfoUpdate, self.handleSeasonInfoUpdate, self)

			local seasonId = SeasonModel.instance:getSeasonId()

			SeasonController.instance:sendGetSeasonInfo(seasonId)
		end
	})
end

return SeasonEvtPlayPlot
