-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/impressionstickers/controller/ImpressionStickersController.lua

module("logic.extensions.impressionstickers.controller.ImpressionStickersController", package.seeall)

local ImpressionStickersController = class("ImpressionStickersController", BaseController)

function ImpressionStickersController:onInit()
	self._tempTargetId = nil

	GameUtil.whenLocalDataInited(function()
		ImpressionStickersModel.instance:loadLocalData()
	end)
end

function ImpressionStickersController:onReset()
	self._cover2025_msg = nil
	self._needFixStickers = nil
end

function ImpressionStickersController:sendPM_ImpressionStickersInfoReq(otherUserId)
	ImpressionStickersAgent.instance:sendPM_ImpressionStickersInfoReq(otherUserId)
end

function ImpressionStickersController:handlePM_ImpressionStickersInfoRes(msg)
	ImpressionStickersModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ImpressionStickersRefresh)
end

function ImpressionStickersController:sendPM_Annuity2025ChangeRankInfoReq()
	if self._cover2025_msg == nil then
		ImpressionStickersAgent.instance:sendPM_Annuity2025ChangeRankInfoReq()
	end
end

function ImpressionStickersController:handlePM_Annuity2025ChangeRankInfoRes(msg)
	local pb = GameUtil.pbToTable(msg)

	self._cover2025_msg = pb or {}
	self._needFixStickers = self._cover2025_msg.needFixStickers

	self:tryShowNextChangeView()
end

function ImpressionStickersController:tryShowNextChangeView()
	if self._needFixStickers then
		while #self._needFixStickers > 0 do
			local pb = table.remove(self._needFixStickers, #self._needFixStickers)

			if not pb.processed then
				local cur = checknumber(pb.impressStickCurRank)
				local gain = checknumber(pb.spaceGainRank)

				if cur > 0 and gain > 0 and cur ~= gain then
					UIStateManager.instance:push(ViewName.Impressionstickers2025changeView, pb)

					break
				end
			end
		end
	end
end

function ImpressionStickersController:sendPM_Annuity2025ChangeRankReq(stickerId, cover)
	ImpressionStickersAgent.instance:sendPM_Annuity2025ChangeRankReq(stickerId, cover)
end

function ImpressionStickersController:handlePM_Annuity2025ChangeRankRes(msg)
	ImpressionStickersModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ImpressionStickersRefresh)
	GlobalDispatcher:dispatch(GlobalNotify.IMPRESSIONSTICKERS_2025_COVER_OK)
end

function ImpressionStickersController:handlePM_ImpressionStickersPinRes(msg)
	ImpressionStickersModel.instance:onPinRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ImpressionStickersPinRes)
end

ImpressionStickersController.instance = ImpressionStickersController.New()

return ImpressionStickersController
