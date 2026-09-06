-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/loading/view/component/LoadingCompAutoRandomTips.lua

module(..., package.seeall)

local LoadingCompAutoRandomTips = class("LoadingCompAutoRandomTips", LoadingCompBase)

function LoadingCompAutoRandomTips:onInit()
	self.Internal = 6
	self._pastTime = 0
	self._type = LoadingTipsEnum.None
end

function LoadingCompAutoRandomTips:onReset()
	return
end

function LoadingCompAutoRandomTips:onBuildView(mainGO)
	return
end

function LoadingCompAutoRandomTips:setLoadingTipsType(tipsType)
	self._type = tipsType

	if LoadingTipsEnum.isValid(self._type) then
		self:_randomNextTips()
	else
		self:_setTimerOn(false)
	end
end

function LoadingCompAutoRandomTips:onEnter()
	self._pastTime = 0
end

function LoadingCompAutoRandomTips:onExit()
	self:_setTimerOn(false)
end

function LoadingCompAutoRandomTips:_onClickNextTips()
	self._animation:Play(self.AnmationName)
end

function LoadingCompAutoRandomTips:_onAnimationListener(intParam)
	if intParam > 0 then
		self:_randomNextTips()
	end
end

function LoadingCompAutoRandomTips:_onTimer()
	self._pastTime = self._pastTime + Time.deltaTime

	if self._pastTime >= self.Internal then
		self._pastTime = 0

		self:_onClickNextTips()
	end
end

function LoadingCompAutoRandomTips:_randomNextTips()
	if not LoadingTipsEnum.isValid(self._type) then
		return
	end

	local tipsCO = LoadingTipsAndPicsModel.instance:getNextTipsCO()

	self._loading:setLoadingTips(lang(tipsCO.des))

	self._pastTime = 0
end

function LoadingCompAutoRandomTips:_setTimerOn(isOn)
	if isOn then
		Scheduler.removeListener(self._onTimer, self)
		Scheduler.addListener(0, self._onTimer, self, true)
	else
		Scheduler.removeListener(self._onTimer, self)
	end
end

return LoadingCompAutoRandomTips
