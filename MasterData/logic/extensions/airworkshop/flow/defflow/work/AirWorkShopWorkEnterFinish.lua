-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/work/AirWorkShopWorkEnterFinish.lua

module("logic.extensions.airworkshop.flow.defflow.work.AirWorkShopWorkEnterFinish", package.seeall)

local M = class("AirWorkShopWorkEnterFinish", WorkBase)

function M:onEnter(context)
	local model = context.model

	if AirWorkShopDefOperateUtil.hasEntityRefresh(model:getModiedMapMO(), model:getLevelId()) then
		local function func()
			AirWorkShopDefOperateUtil.fillNeedRefreshEntitys(model:getModiedMapMO(), model:getLevelId())
		end

		local dialog = Dialog.showMessage(lang("tip_title"), "是否需要将关卡中的角色数据同步到最新?")

		dialog:setConfirmListener(func)
		dialog:setConfirmText("全部更新")
		dialog:setCancelText("保留旧数据")
	end

	self:onDone(WorkResult.Succeed)
end

function M:onExit(isInterrupt)
	return
end

return M
