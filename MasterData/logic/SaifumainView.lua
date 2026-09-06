-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/SaifumainView.lua

module("logic.extensions.infinitefuture.view.SaifumainView", package.seeall)

local SaifumainView = class("SaifumainView", InfinitefutureView)

function SaifumainView:_onClickTab(index)
	if index == 1 then
		self:showTabAt(self._container, ViewName.SaifuchallengeView)
	elseif index == 2 then
		self:showTabAt(self._container, ViewName.SaifulotteryView)
	elseif index == 3 then
		printError("没有处理")
	end

	for i = 1, 3 do
		self._tabs[i].selected:SetActive(i == index)
	end

	InfinitefutureView.PageIndex = index
end

function SaifumainView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "saifu_rule")
end

function SaifumainView:setIds()
	InfinitefutureModel.instance.curActId = 123012
	InfinitefutureModel.instance.curPetId = 11008
end

return SaifumainView
