-- chunkname: @modules/logic/versionactivity1_5/sportsnews/controller/SportsNewsController.lua

module("modules.logic.versionactivity1_5.sportsnews.controller.SportsNewsController", package.seeall)

local SportsNewsController = class("SportsNewsController", BaseController)

function SportsNewsController:openSportsNewsMainView(actId)
	SportsNewsModel.instance:setJumpToOrderId(nil)

	actId = actId or VersionActivity1_5Enum.ActivityId.SportsNews

	ViewMgr.instance:openView(ViewName.SportsNewsView, {
		formToMain = true,
		actId = actId
	})
end

SportsNewsController.UI_CLICK_BLOCK_KEY = "SportsNewsBlock"

function SportsNewsController:startBlock()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(SportsNewsController.UI_CLICK_BLOCK_KEY)
end

function SportsNewsController:endBlock()
	UIBlockMgr.instance:endBlock(SportsNewsController.UI_CLICK_BLOCK_KEY)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function SportsNewsController:cantJumpDungeonGetName(jumpId)
	local jumpConfig = JumpConfig.instance:getJumpConfig(jumpId)

	if not jumpConfig then
		return false
	end

	local jumpParam = jumpConfig.param
	local canJump, toastId = JumpController.instance:canJumpNew(jumpParam)

	if canJump then
		return true
	end

	local jumps = string.split(jumpParam, "#")
	local episodeId = tonumber(jumps[#jumps])
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeConfig then
		local cantJumpName = DungeonController.getEpisodeName(episodeConfig)

		return false, ToastEnum.V1a5SportNewsOrderJumpTo, cantJumpName, episodeConfig.name
	end

	return false, toastId
end

function SportsNewsController:jumpToFinishTask(order, callback, callbackObj)
	local canJump, toastId, cantJumpName, jumpName = self:cantJumpDungeonGetName(order.cfg.jumpId)

	if not canJump then
		GameFacade.showToast(toastId, cantJumpName, jumpName)
	else
		local tag = {
			luaLang("p_versionactivity_1_5_enterview_txt_Activity2"),
			order.cfg.name
		}
		local recordFarmItem = {
			special = true,
			desc = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a5_news_order_return_view"), tag),
			checkFunc = order.canFinish,
			checkFuncObj = order,
			openedViewNameList = JumpController.instance:getCurrentOpenedView()
		}

		SportsNewsModel.instance:setJumpToOrderId(order.cfg.id)
		JumpController.instance:jump(order.cfg.jumpId, callback, callbackObj, recordFarmItem)
	end
end

SportsNewsController.instance = SportsNewsController.New()

return SportsNewsController
