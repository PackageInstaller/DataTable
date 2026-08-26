-- chunkname: @modules/common/others/openmultiview/OpenMultiView.lua

module("modules.common.others.openmultiview.OpenMultiView", package.seeall)

local OpenMultiView = {}

function OpenMultiView.openView(openViewParamList)
	local flow = FlowSequence.New()

	for i, openViewParam in ipairs(openViewParamList) do
		local work = OpenViewWork.New(openViewParam)

		flow:addWork(work)
	end

	flow:start()
end

return OpenMultiView
