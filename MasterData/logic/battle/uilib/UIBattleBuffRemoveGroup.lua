-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uilib/UIBattleBuffRemoveGroup.lua

module("logic.battle.uilib.UIBattleBuffRemoveGroup", package.seeall)

local M = class("UIBattleBuffRemoveGroup")
local buffIconHalfHeight = 12

function M:ctor(mainGO)
	self.mainGO = mainGO

	self:buildUI()

	self._buffBubbleQueue = Queue.create()
end

function M:reset()
	self._buffCollection:clear()
	self._buffBubbleQueue:clear()
	self._timeWaiter:clear()

	self._isPlaying = false
end

function M:destroy()
	self:destroyUI()

	self.mainGO = nil
end

function M:buildUI()
	self._buffCollection = BattleReusableCollection.New(BattleBuffIcon)
	self._contentGo = goutil.findChild(self.mainGO, "lay")
	self._timeWaiter = TimeWaiter.New()
	self._isPlaying = false
end

function M:setBuffGroup(buffGroup)
	self._buffGroup = buffGroup
end

function M:addBuffList(buffCodes)
	if not buffCodes or #buffCodes == 0 then
		return
	end

	self._buffBubbleQueue:enqueue(buffCodes)

	if not self._isPlaying then
		self:_playNextAnim()
	end
end

function M:_playNextAnim()
	local buffCodes = self._buffBubbleQueue:dequeue()

	if not buffCodes then
		self._buffCollection:clear()
		goutil.setActive(self.mainGO, false)

		self._isPlaying = false

		return
	end

	self:_playOneAnim(buffCodes)
end

function M:_playOneAnim(buffCodes)
	local x, y, z = TransformUtils.GetPosition(self._buffGroup.mainGO.transform, 0, 0, 0)

	TransformUtils.SetPosition(self.mainGO.transform, self.mainGO.transform.position.x, y, self.mainGO.transform.position.z)

	local anchoredX, anchoredY = Astral.TransformUtil.GetAnchoredPos(self.mainGO.transform, 0, 0)

	Astral.TransformUtil.SetAnchoredPos(self.mainGO.transform, anchoredX, anchoredY + buffIconHalfHeight)
	goutil.setActive(self.mainGO, true)

	self._isPlaying = true

	self._timeWaiter:setTimeScale(BattleTime.timeScale)
	self._timeWaiter:start(0.81, self._playNextAnim, self)
	self._buffCollection:clear()

	for i, code in ipairs(buffCodes) do
		local buffIcon = self._buffCollection:createInstance()
		local buffMO = BuffMO:createInstance()

		buffMO:setCode(code)
		buffMO:setRound(-1)
		buffIcon:setBuffMO(buffMO)
		buffIcon:playDisappearAnim()
		goutil.addChildToParent(buffIcon.mainGO, self._contentGo)
		buffMO:returnSelf()
	end
end

function M:destroyUI()
	self._buffCollection:clear()
	self._buffBubbleQueue:clear()
	self._timeWaiter:clear()

	self._buffCollection = nil
end

return M
