-- chunkname: @modules/logic/rouge2/map/work/Rouge2_WaitTriggerEndingWork.lua

module("modules.logic.rouge2.map.work.Rouge2_WaitTriggerEndingWork", package.seeall)

local Rouge2_WaitTriggerEndingWork = class("Rouge2_WaitTriggerEndingWork", BaseWork)

function Rouge2_WaitTriggerEndingWork:ctor()
	return
end

function Rouge2_WaitTriggerEndingWork:onStart()
	if not Rouge2_Model.instance:inRouge() then
		self:onDone(false)

		return
	end

	local isMiddle = Rouge2_MapModel.instance:isMiddle()

	if not isMiddle then
		self:onDone(true)

		return
	end

	if Rouge2_MapModel.instance:checkManualCloseHeroGroupView() then
		self:onDone(true)

		return
	end

	local pieceMo = Rouge2_MapModel.instance:getCurPieceMo()

	if pieceMo then
		local endEpisodeId = pieceMo:getEndEpisodeId()
		local isFightFail = pieceMo:isFightFail()

		if endEpisodeId and endEpisodeId ~= 0 and not isFightFail then
			local selectIdList = pieceMo and pieceMo:getSelectIdList()

			if selectIdList then
				if not #selectIdList then
					local selectIdNum = 0
					local lastSelectId = selectIdList and selectIdList[selectIdNum]

					if lastSelectId and lastSelectId ~= 0 then
						Rouge2_MapPieceTriggerHelper.triggerHandle(pieceMo, lastSelectId)
						self:onDone(true)

						return
					end
				end
			end
		end
	end

	self:onDone(true)
end

return Rouge2_WaitTriggerEndingWork
