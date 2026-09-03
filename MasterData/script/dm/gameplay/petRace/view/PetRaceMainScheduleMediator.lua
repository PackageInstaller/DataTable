-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/petRace/view/PetRaceMainScheduleMediator.lua

PetRaceMainScheduleMediator = class("PetRaceMainScheduleMediator", DmAreaViewMediator)

PetRaceMainScheduleMediator:has("_petRaceSystem", {
	is = "r"
}):injectWith("PetRaceSystem")

local bottomClickEventMap = {}

function PetRaceMainScheduleMediator:initialize()
	super.initialize(self)
end

function PetRaceMainScheduleMediator:dispose()
	if self._schedule_cd then
		LuaScheduler:getInstance():unschedule(self._schedule_cd)

		self._schedule_cd = nil
	end

	super.dispose(self)
end

function PetRaceMainScheduleMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(bottomClickEventMap)
end

function PetRaceMainScheduleMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PETRACE_STATE_CHANGE, self, self.updateState)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PETRACE_AUTO_REGIST_CHANGE, self, self.refreshView)
end

function PetRaceMainScheduleMediator:enterWithData()
	AdjustUtils.adjustLayoutUIByRootNode(self:getView())
	self:setupView()
	self:updateState()
	self:updateCD()
	self:mapEventListeners()
end

function PetRaceMainScheduleMediator:setupView()
	self._panel_base = self:getView():getChildByName("Panel_base")
end

function PetRaceMainScheduleMediator:updateState(event)
	self:switchView()
	self:refreshView()
end

function PetRaceMainScheduleMediator:switchView()
	local state
	local isRegist = self._petRaceSystem:isRegist()
	local isFinalMatch = self._petRaceSystem:isFinalMatch()
	local curState = self._petRaceSystem:getCurMatchState()

	state = not isRegist and isFinalMatch and curState == PetRaceEnum.state.matchOver and curState or self._petRaceSystem:getMyMatchState()

	local round = self._petRaceSystem:getRound()
	local scoreMaxRound = self._petRaceSystem:getScoreMaxRound()

	if state == PetRaceEnum.state.regist then
		if self._layer_final then
			self._layer_final:removeFromParent()
		end

		if self._layer_prelim then
			self._layer_prelim:removeFromParent()
		end

		if self._layer_over then
			self._layer_over:removeFromParent()
		end

		self._layer_final = nil
		self._layer_prelim = nil
		self._layer_over = nil

		if not self._layer_beforRegist then
			self:initBeforRegistLayer()
		end
	elseif state == PetRaceEnum.state.matchOver then
		if self._layer_final then
			self._layer_final:removeFromParent()
		end

		if self._layer_prelim then
			self._layer_prelim:removeFromParent()
		end

		if self._layer_beforRegist then
			self._layer_beforRegist:removeFromParent()
		end

		self._layer_final = nil
		self._layer_prelim = nil
		self._layer_beforRegist = nil

		if not self._layer_over then
			self:initOverLayer()
		end
	elseif round <= scoreMaxRound then
		if self._layer_final then
			self._layer_final:removeFromParent()
		end

		if self._layer_over then
			self._layer_over:removeFromParent()
		end

		if self._layer_beforRegist then
			self._layer_beforRegist:removeFromParent()
		end

		self._layer_final = nil
		self._layer_over = nil
		self._layer_beforRegist = nil

		if not self._layer_prelim then
			self:initPrelimLayer()
		end
	else
		if self._layer_prelim then
			self._layer_prelim:removeFromParent()
		end

		if self._layer_over then
			self._layer_over:removeFromParent()
		end

		if self._layer_beforRegist then
			self._layer_beforRegist:removeFromParent()
		end

		self._layer_prelim = nil
		self._layer_over = nil
		self._layer_beforRegist = nil

		if not self._layer_final then
			self:initFinalLayer()
		end
	end
end

function PetRaceMainScheduleMediator:refreshView()
	if self._layer_beforRegist then
		self._layer_beforRegist.mediator:refreshView()
	end

	if self._layer_over then
		self._layer_over.mediator:refreshView()
	end

	if self._layer_prelim then
		self._layer_prelim.mediator:refreshView()
	end

	if self._layer_final then
		self._layer_final.mediator:refreshView()
	end
end

function PetRaceMainScheduleMediator:initBeforRegistLayer()
	self._layer_beforRegist = self:getInjector():getInstance("PetRaceRegistLayer")
	self._layer_beforRegist.mediator = self:getInjector():instantiate("PetRaceRegistLayer", {
		view = self._layer_beforRegist
	})

	self._panel_base:addChild(self._layer_beforRegist)
	self._layer_beforRegist.mediator:createAnim()
end

function PetRaceMainScheduleMediator:initOverLayer()
	self._layer_over = self:getInjector():getInstance("PetRaceOverLayer")
	self._layer_over.mediator = self:getInjector():instantiate("PetRaceOverLayer", {
		view = self._layer_over
	})

	self._panel_base:addChild(self._layer_over)
end

function PetRaceMainScheduleMediator:initPrelimLayer()
	self._layer_prelim = self:getInjector():getInstance("PetRacePrelimLayer")
	self._layer_prelim.mediator = self:getInjector():instantiate("PetRacePrelimLayer", {
		view = self._layer_prelim
	})

	self._panel_base:addChild(self._layer_prelim)
end

function PetRaceMainScheduleMediator:updateCD()
	if self._schedule_cd then
		return
	end

	local mySelf = self

	self._schedule_cd = LuaScheduler:getInstance():schedule(function()
		if mySelf._layer_prelim then
			mySelf._layer_prelim.mediator:updateTime()
		end

		if mySelf._layer_final then
			mySelf._layer_final.mediator:updateTime()
		end
	end, 1, false)

	if mySelf._layer_prelim then
		mySelf._layer_prelim.mediator:updateTime()
	end

	if mySelf._layer_final then
		mySelf._layer_final.mediator:updateTime()
	end
end

function PetRaceMainScheduleMediator:initFinalLayer()
	self._layer_final = self:getInjector():getInstance("PetRaceFinalEightLayer")
	self._layer_final.mediator = self:getInjector():instantiate(PetRaceFinalEightLayer, {
		view = self._layer_final
	})

	self._panel_base:addChild(self._layer_final)
end
