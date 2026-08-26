-- chunkname: @modules/logic/story/view/btns/StoryStrategyBtn.lua

module("modules.logic.story.view.btns.StoryStrategyBtn", package.seeall)

local StoryStrategyBtn = class("StoryStrategyBtn", UserDataDispose)

function StoryStrategyBtn:ctor(go)
	self.go = go
	self._btnClick = gohelper.findButtonWithAudio(go)

	self._btnClick:AddClickListener(self._onClickBtn, self)
	gohelper.setActive(self.go, false)

	self._btnType = StoryEnum.StrategyBtnType.CmdPost
end

function StoryStrategyBtn:_onClickBtn()
	StoryModel.instance:setStoryAuto(false)

	if self._btnType == StoryEnum.StrategyBtnType.CmdPost then
		CommandStationController.instance:openCommandStationMapDisplayView(self._param)
	end
end

function StoryStrategyBtn:setParam(param)
	self._param = param
end

function StoryStrategyBtn:setBtnType(type)
	self._btnType = type
end

function StoryStrategyBtn:showBtn()
	gohelper.setActive(self.go, true)
end

function StoryStrategyBtn:hideBtn()
	gohelper.setActive(self.go, false)
end

function StoryStrategyBtn:destroy()
	self._btnClick:RemoveClickListener()
end

return StoryStrategyBtn
