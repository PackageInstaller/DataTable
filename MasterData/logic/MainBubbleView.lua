-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/MainBubbleView.lua

module("logic.extensions.mainui.view.MainBubbleView", package.seeall)

local MainBubbleView = class("MainBubbleView", ViewComponent)

function MainBubbleView:buildUI()
	local go = self:getResInstance(MainViewPresentor.Url_MainBubbleView)

	self._mainName = go.name

	goutil.addChildToParent(go, self.mainGO)
	Framework.TransformUtil.SetLocalPos(go.transform, 0, 0, 0)
	go.transform:SetAsLastSibling()

	local path = self._mainName .. "/"

	self._bubbleNode = self:getGo(path .. "bubbleNode")
	self._rewardGo = self:getGo(path .. "bubbleNode/reward")
	self._txtDesc = self:getGo(path .. "bubbleNode/txtDesc"):GetComponent(goutil.Type_UIText)
end

function MainBubbleView:unbindEvents()
	return
end

function MainBubbleView:bindEvents()
	return
end

function MainBubbleView:onEnter()
	settimer(0.1, self._onTimer, self, false)
end

function MainBubbleView:_onTimer()
	removetimer(self._onTimer, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdateMainViewSwitchBtnState, self._updateState, self)
	self:_updateState(self:_getSwitchBtnState())
end

function MainBubbleView:onExit()
	removetimer(self._onTimer, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateMainViewSwitchBtnState, self._updateState, self)
	self:_removeReward()
end

function MainBubbleView:_updateState(isSwitchOpen)
	local isShow = false

	if not isSwitchOpen then
		goutil.setActive(self._bubbleNode, isShow)

		return
	end

	self:_removeReward()

	local cfgs = CopyConfig.instance:getRewardStrategyDataList()
	local isOpen = FuncOpenModel.instance:getFuncIsOpen(47)

	if not isOpen then
		goutil.setActive(self._bubbleNode, isShow)

		return
	end

	for i, v in ipairs(cfgs) do
		if v.rewardShow then
			local chapterId = v.rewardShow[1]
			local stageId = v.rewardShow[2]
			local isPerfect = PlotCopyModel.instance:isChapterPerfectPassed(chapterId)

			if not isPerfect then
				MaterialMgr.setCellByCfg(v.reward, self._rewardGo)

				isShow = true

				local stageNumStr = "完美通关\n"
				local cfgStage = CopyConfig.instance:getStageById(chapterId, stageId)

				if cfgStage then
					local str = string.match(cfgStage.stageName, "%d+-%d+")

					if str then
						stageNumStr = stageNumStr .. str
					end
				end

				self._txtDesc.text = stageNumStr

				break
			end
		end
	end

	goutil.setActive(self._bubbleNode, isShow)
end

function MainBubbleView:_removeReward()
	MaterialMgr.resetAll(self._rewardGo)
end

function MainBubbleView:_onClickClose()
	self:close()
end

function MainBubbleView:_getSwitchBtnState()
	local view = self._viewPresentor:getViewByName("MainActivityView")

	return (view:isBtnSwitchOpen())
end

return MainBubbleView
