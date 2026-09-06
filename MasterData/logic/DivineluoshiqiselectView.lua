-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhood/view/copy/DivineluoshiqiselectView.lua

module("logic.extensions.xiunuobrotherhood.view.copy.DivineluoshiqiselectView", package.seeall)

local DivineluoshiqiselectView = class("DivineluoshiqiselectView", XiuNuoBrotherhoodSelectView)

function DivineluoshiqiselectView:ctor()
	self._gameViewName = ViewName.DivineluoshiqigameView
end

function DivineluoshiqiselectView:_onClickStart(stageId)
	local maxLevel = XiuNuoBrotherhoodModel.instance:getMaxPassStage()

	if stageId > maxLevel + 1 then
		FloatWordMgr.instance:show(lang("请通关前面的关卡"))
	elseif stageId == maxLevel + 1 then
		local isOpen = XiuNuoBrotherhoodModel.instance:getStageOpen(stageId)

		if isOpen == true then
			UIStateManager.instance:push(self._gameViewName, self._activityId, stageId, self._cfg.gameId)
			self:close()
		else
			local openTime = XiuNuoBrotherhoodModel.instance:getStageOpenTime(stageId)
			local date = GameUtil.time2date(openTime)

			FloatWordMgr.instance:show(langPara("该关卡暂未开放，开放时间为%02d.%02d %02d:%02d", date.month, date.day, date.hour, date.min))
		end
	elseif stageId <= maxLevel then
		FloatWordMgr.instance:show(lang("已通过"))
	end
end

return DivineluoshiqiselectView
