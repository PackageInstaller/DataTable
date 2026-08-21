-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/element/UnitCompMainSceneElementFireworks.lua

module("logic.extensions.mainui.scene.element.UnitCompMainSceneElementFireworks", package.seeall)

local M = class("UnitCompMainSceneElementFireworks", UnitCompMainSceneElementBase)
local ResTyp = {
	Blue = 1,
	Red = 2
}
local CheckInterVal = 5

function M:ctor(mainGo)
	M.super.ctor(self, mainGo)

	self._resLoader = nil
	self._resDict = nil
	self._resPath = {
		[ResTyp.Blue] = "effect3d/prefab/scene/comm/sx-s001_yanhua_blue_fx.prefab",
		[ResTyp.Red] = "effect3d/prefab/scene/comm/sx-s001_yanhua_red_fx.prefab"
	}
end

function M:Awake()
	M.super.Awake(self)
	self:_loadRes()
end

function M:OnEnable()
	M.super.OnEnable(self)
	self:setEvent(true)
	self:_startTimerShow(true)
end

function M:OnDisable()
	M.super.OnDisable(self)
	self:setEvent(false)
	self:_startTimerShow(false)

	self._stepNum = nil

	for keyStr, valInt in pairs(ResTyp) do
		local go = self:getInst(valInt)

		if go then
			goutil.setActive(go, false)
		end
	end
end

function M:OnDestroy()
	M.super.OnDestroy(self)
	self:setEvent(false)
	self:_startTimerShow(false)

	for _resTyp, go in pairs(self._resDict or {}) do
		goutil.destroy(go)
	end

	self._resDict = nil

	self._resLoader:clear()

	self._resLoader = nil
end

function M:_initComponents()
	return
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_SYSTEM_OPEN, self._handleOnSystemOpen, self)
		GlobalDispatcher:addEventListener(EventType.FW_CLOCK_TICKHOUR, self._handleClockTickHour, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_SYSTEM_OPEN, self._handleOnSystemOpen, self)
		GlobalDispatcher:removeEventListener(EventType.FW_CLOCK_TICKHOUR, self._handleClockTickHour, self)
	end
end

function M:_handleOnSystemOpen(e)
	return
end

function M:_handleClockTickHour(e)
	return
end

function M:checkShow()
	if not self:getIsShow() then
		return
	end

	for keyStr, valInt in pairs(ResTyp) do
		local go = self:getInst(valInt)

		if go then
			goutil.setActive(go, false)
		end
	end

	if not self._stepNum or self._stepNum <= 0 then
		local _randomNum = math.random(1, 100)

		self._playFireWorksNum = _randomNum >= 50 and math.random(1, 3) or 0
		self._stepNum = self._playFireWorksNum + 3
	end

	if self._playFireWorksNum > 0 then
		local inAirtightTime = AirtightRoomController.instance:getIsInAirtightTime(nil, nil, nil, false)
		local showResTyp = inAirtightTime and ResTyp.Red or ResTyp.Blue

		for keyStr, valInt in pairs(ResTyp) do
			local go = self:getInst(valInt)
			local show = valInt == showResTyp

			if go then
				goutil.setActive(go, show)
			end
		end

		self._playFireWorksNum = self._playFireWorksNum - 1
	end

	self._stepNum = self._stepNum - 1
end

function M:_startTimerShow(start)
	removetimer(self._timerShowFireworks, self)

	if start then
		settimer(CheckInterVal, self._timerShowFireworks, self, true)
	end
end

function M:_timerShowFireworks()
	self:checkShow()
end

function M:_loadRes()
	self._resLoader = MultiResLoader.New()

	self._resLoader:setResPaths(self._resPath)
	self._resLoader:load(self._onAllLoaded, self._onLoaded, self)
end

function M:getInst(resType)
	if self._resDict then
		return self._resDict[resType]
	end

	return nil
end

function M:_onAllLoaded(loader)
	self._resLoader:clear()
	self:checkShow()
end

function M:_onLoaded(res)
	if not self._resDict then
		self._resDict = {}
	end

	if res.IsSuccess then
		res:Retain()

		local _resType = table.indexof(self._resPath, res.ResPath)

		if not self._resDict[_resType] then
			local inst = goutil.cloneAndSetParent(res:GetAsset(nil, nil), self:getMainGO().transform)

			goutil.setActive(inst.gameObject, false)

			self._resDict[_resType] = inst
		end
	end
end

return M
