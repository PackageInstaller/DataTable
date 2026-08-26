-- chunkname: @modules/logic/turnback/view/turnback4/Turnback4BeginnerView.lua

module("modules.logic.turnback.view.turnback4.Turnback4BeginnerView", package.seeall)

local Turnback4BeginnerView = class("Turnback4BeginnerView", Turnback3BeginnerView)

function Turnback4BeginnerView:_editableInitView()
	self._turnbackSubViewDict = {
		[TurnbackEnum.ActivityId.Turnback4SignInView] = ViewName.Turnback4SignInView,
		[TurnbackEnum.ActivityId.Turnback4BPView] = ViewName.Turnback3BpView,
		[TurnbackEnum.ActivityId.Turnback4DoubleView] = ViewName.Turnback4DoubleView,
		[TurnbackEnum.ActivityId.Turnback4StoreView] = ViewName.Turnback3StoreView,
		[TurnbackEnum.ActivityId.Turnback4ProgressView] = ViewName.Turnback4ProgressView,
		[TurnbackEnum.ActivityId.Turnback4ReviewView] = ViewName.TurnbackReviewView,
		[TurnbackEnum.ActivityId.Turnback4RewardView] = ViewName.Turnback4RewardView
	}
	self._turnbackInfoMo = TurnbackModel.instance:getCurTurnbackMo()
end

function Turnback4BeginnerView:_hasTurnback4RewardView()
	if not self._turnbackInfoMo then
		return
	end

	local resourceReturn = self._turnbackInfoMo:getReturnRewardInfo()

	if not resourceReturn or not resourceReturn.open then
		return
	end

	local config = TurnbackConfig.instance:getTurnbackCo(TurnbackModel.instance:getCurTurnbackId())
	local resourceReturnCondition = config.resourceReturnCondition
	local leaveDays = self._turnbackInfoMo:getLeaveDay()

	if not string.nilorempty(resourceReturnCondition) then
		local day = string.gsub(resourceReturnCondition, "LossDays>=", "")

		if not string.nilorempty(day) and leaveDays >= tonumber(day) then
			return true
		end
	end
end

function Turnback4BeginnerView:refreshView()
	self.allActivityTab = TurnbackConfig.instance:getAllTurnbackSubModules(self.turnbackId)

	if self.allActivityTab == nil or GameUtil.getTabLen(self.allActivityTab) == 0 then
		self:closeThis()
	end

	self.allActivityTab = TurnbackModel.instance:removeUnExitCategory(self.allActivityTab)
	self.subViewTab = {}

	for index, v in pairs(self.allActivityTab) do
		if v ~= TurnbackEnum.ActivityId.Turnback4RewardView or self:_hasTurnback4RewardView() then
			local o = {}

			o.id = v
			o.order = index
			o.config = TurnbackConfig.instance:getTurnbackSubModuleCo(v)

			table.insert(self.subViewTab, o)
		end
	end

	TurnbackBeginnerCategoryListModel.instance:setOpenViewTime()
	TurnbackBeginnerCategoryListModel.instance:setCategoryList(self.subViewTab)
	self:openSubView()
	self:_refreshRemainTime()
end

return Turnback4BeginnerView
