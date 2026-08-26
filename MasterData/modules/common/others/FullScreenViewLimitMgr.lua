-- chunkname: @modules/common/others/FullScreenViewLimitMgr.lua

module("modules.common.others.FullScreenViewLimitMgr", package.seeall)

local FullScreenViewLimitMgr = class("FullScreenViewLimitMgr")

FullScreenViewLimitMgr.enableLimit = true
FullScreenViewLimitMgr.limitCount = 5

function FullScreenViewLimitMgr:ctor()
	return
end

function FullScreenViewLimitMgr:init()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenFullViewFinish, self._onOpenFullView, self)
end

function FullScreenViewLimitMgr:_onOpenFullView(viewName)
	if not FullScreenViewLimitMgr.enableLimit then
		return
	end

	local count = 0
	local openViewNameList = ViewMgr.instance:getOpenViewNameList()

	for i = #openViewNameList, 1, -1 do
		if ViewMgr.instance:isFull(openViewNameList[i]) then
			if count >= FullScreenViewLimitMgr.limitCount then
				logNormal("全屏界面数量超出限制, 关闭界面: " .. openViewNameList[i])
				ViewMgr.instance:closeView(openViewNameList[i])
			end

			count = count + 1
		end
	end
end

FullScreenViewLimitMgr.instance = FullScreenViewLimitMgr.New()

return FullScreenViewLimitMgr
