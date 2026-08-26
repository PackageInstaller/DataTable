-- chunkname: @modules/logic/rouge2/map/view/dice/Rouge2_MapDiceViewContainer.lua

module("modules.logic.rouge2.map.view.dice.Rouge2_MapDiceViewContainer", package.seeall)

local Rouge2_MapDiceViewContainer = class("Rouge2_MapDiceViewContainer", BaseViewContainer)

function Rouge2_MapDiceViewContainer:buildViews()
	local views = {}

	self._mainView = Rouge2_MapDiceView.New()
	self._rollView = Rouge2_MapDiceReRollView.New()

	table.insert(views, self._mainView)
	table.insert(views, self._rollView)
	table.insert(views, Rouge2_MapDiceAnimView.New())
	table.insert(views, Rouge2_MapDiceChoiceView.New())
	table.insert(views, Rouge2_MapCoinView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_lefttop"))

	return views
end

function Rouge2_MapDiceViewContainer:playOpenTransition()
	self:startViewOpenBlock()

	local animator = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	animator:Play("open", self.onPlayOpenTransitionFinish, self)
end

function Rouge2_MapDiceViewContainer:playCloseTransition()
	self:startViewCloseBlock()

	local animator = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	animator:Play("close", self.onPlayCloseTransitionFinish, self)
end

function Rouge2_MapDiceViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			false,
			false,
			true
		})

		self.navigateView:setOverrideHelp(self.overrideHelperBtn, self)

		return {
			self.navigateView
		}
	end
end

function Rouge2_MapDiceViewContainer:overrideHelperBtn()
	Rouge2_Controller.instance:openTechniqueView(Rouge2_MapEnum.TechniqueId.DiceView)
end

function Rouge2_MapDiceViewContainer:endAttrCheck()
	if not Rouge2_MapAttrCheckHelper.isAttrCheckInteract() then
		self:closeThis()

		return
	end

	self._endCheckCbId = Rouge2_Rpc.instance:sendRouge2EndCheckRequest(self._onEndCheckCallback, self)
end

function Rouge2_MapDiceViewContainer:_onEndCheckCallback(_, resultCode)
	if resultCode ~= 0 then
		return
	end

	self:closeThis()
end

function Rouge2_MapDiceViewContainer:onContainerClose()
	if self._endCheckCbId then
		Rouge2_Rpc.instance:removeCallbackById(self._endCheckCbId)

		self._endCheckCbId = nil
	end
end

function Rouge2_MapDiceViewContainer:getMainView()
	return self._mainView
end

function Rouge2_MapDiceViewContainer:getRollView()
	return self._rollView
end

return Rouge2_MapDiceViewContainer
