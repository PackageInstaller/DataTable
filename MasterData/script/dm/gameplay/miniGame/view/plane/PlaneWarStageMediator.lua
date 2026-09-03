-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/view/plane/PlaneWarStageMediator.lua

PlaneWarStageMediator = class("PlaneWarStageMediator", PlaneWarBaseMediator, _M)

function PlaneWarStageMediator:initialize()
	super.initialize(self)
end

function PlaneWarStageMediator:dispose()
	super.dispose(self)
end

function PlaneWarStageMediator:userInject()
	return
end

function PlaneWarStageMediator:onRegister()
	super.onRegister(self)

	local view = self:getView()
	local background = cc.Sprite:create("asset/ui/miniplane/bg_miniplane_beijingtu.png")

	background:addTo(view, -1):setName("backgroundBG"):center(view:getContentSize())
end

function PlaneWarStageMediator:bindWidgets()
	return
end

function PlaneWarStageMediator:adjustLayout(targetFrame)
	super.adjustLayout(self, targetFrame)
	self:adaptBackground(self:getView():getChildByName("backgroundBG"))
end

function PlaneWarStageMediator:enterWithData(data)
	super.enterWithData(self, data)
	self:setupTopInfoWidget()
	self:initData(data)
	self:initNodes()
	self:beginGame()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLANEWAR_STAGE_PAUSE, self, self.popPauseView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLANEWAR_GAMEOVER, self, self.gameOver)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLANEWAR_STAGE_CLOSE, self, self.gameOverCloseView)
end

function PlaneWarStageMediator:gameOverCloseView(event)
	self:dismiss()
end

function PlaneWarStageMediator:gameOver(event)
	local stageSystem = self:getInjector():getInstance(StageSystem)
	local stagePointId = self._data.stagePointId
	local config = ConfigReader:getRecordById("StagePoint", stagePointId)

	stageSystem:requestPassMiniGame(config.Map, stagePointId, event:getData(), function(response)
		if response.resCode == GS_SUCCESS then
			local view = self:getInjector():getInstance("PlaneWarStageWinView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {}, {
				star = response.data.stars,
				condText = config.PointGameConfig.starCondition,
				rewards = response.data.spoils
			}, nil))
		else
			self:dismiss()
		end
	end)
end

function PlaneWarStageMediator:popPauseView(event)
	local stagePointId = self._data.stagePointId
	local config = ConfigReader:getRecordById("StagePoint", stagePointId)
	local popupDelegate, outSelf = {}, self

	function popupDelegate:onContinue(dialog)
		outSelf:resume()
	end

	function popupDelegate:onLeave(dialog)
		outSelf:dismiss()
	end

	local data = {
		showStar = true,
		condText = config.PointGameConfig.starCondition
	}
	local pauseView = outSelf:getInjector():getInstance("PlaneWarStagePauseView")

	outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, pauseView, {
		maskOpacity = 156,
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, popupDelegate))
end

function PlaneWarStageMediator:setupTopInfoWidget()
	return
end

function PlaneWarStageMediator:initData(data)
	self._data = data

	super.initData(self, data)
end

function PlaneWarStageMediator:initNodes()
	super.initNodes(self)
end

function PlaneWarStageMediator:beginGame()
	self:runSleepAnim(function()
		self:runGame()
	end)
end

function PlaneWarStageMediator:onClickBack(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:dismiss()
	end
end
