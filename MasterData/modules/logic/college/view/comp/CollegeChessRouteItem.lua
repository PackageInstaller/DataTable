-- chunkname: @modules/logic/college/view/comp/CollegeChessRouteItem.lua

module("modules.logic.college.view.comp.CollegeChessRouteItem", package.seeall)

local CollegeChessRouteItem = class("CollegeChessRouteItem", LuaCompBase)

function CollegeChessRouteItem:init(go)
	self.go = go

	local anim = go:GetComponent(typeof(UnityEngine.Animation))

	if not anim then
		return
	end

	self._anim = anim

	local clip = anim.clip

	if not clip then
		return
	end

	anim.enabled = false
	self._clip = clip
	self._clipLen = clip.length

	local chessRoot = gohelper.findChild(go, "qizi_item/position")

	self._chessGo = chessRoot

	GameObjectLiveEventComp.Create(chessRoot)

	self._loader = PrefabInstantiate.Create(chessRoot)
end

function CollegeChessRouteItem:addEventListeners()
	GameObjectLiveMgr.instance:registerCallback(GameObjectLiveEvent.OnEnable, self.onChessEnable, self)
end

function CollegeChessRouteItem:removeEventListeners()
	GameObjectLiveMgr.instance:unregisterCallback(GameObjectLiveEvent.OnEnable, self.onChessEnable, self)
end

function CollegeChessRouteItem:onChessEnable(go)
	if go ~= self._chessGo then
		return
	end

	self:playPathAnim()
end

function CollegeChessRouteItem:updateData(all, pool, index, min, max, moveStateChangeCallback, moveStateChangeCallobj)
	self._all = all
	self._pool = pool
	self._index = index
	self._min = min
	self._max = max
	self._isMove = false

	self:beginMove()
end

function CollegeChessRouteItem:beginMove()
	if not self._clipLen then
		return
	end

	if #self._pool == 0 then
		tabletool.addValues(self._pool, self._all)
	end

	local path = table.remove(self._pool)

	if not path then
		return
	end

	self._loader:startLoad(path, self.playPathAnim, self)
	self._clip:SampleAnimation(self.go, 0)

	self._curMoveTime = 0

	TaskDispatcher.runRepeat(self._onMove, self, 0)
end

function CollegeChessRouteItem:playPathAnim()
	if not self._loader then
		return
	end

	local go = self._loader:getInstGO()

	if not go then
		return
	end

	local anim = gohelper.findComponentAnim(go)

	if not anim then
		return
	end

	anim:Play("path")
end

function CollegeChessRouteItem:_onMove()
	self._curMoveTime = self._curMoveTime + UnityEngine.Time.deltaTime

	self._clip:SampleAnimation(self.go, self._curMoveTime)

	if self._curMoveTime > self._clipLen then
		self:setIsMove(false)
		self._loader:dispose()

		local interval = math.random() * (self._max - self._min) + self._min

		TaskDispatcher.runDelay(self.beginMove, self, interval)
		TaskDispatcher.cancelTask(self._onMove, self)
	else
		self:setIsMove(self:isActiveAndInScreen())
	end
end

function CollegeChessRouteItem:isActiveAndInScreen()
	if CollegeModel.instance.curSceneType ~= CollegeEnum.SceneType.City then
		return false
	end

	if not self._chessGo.activeInHierarchy then
		return false
	end

	local camera = CameraMgr.instance:getMainCamera()
	local screenPos = camera:WorldToScreenPoint(self._chessGo.transform.position)

	return screenPos.z > 0 and screenPos.x > 0 and screenPos.x < UnityEngine.Screen.width and screenPos.y > 0 and screenPos.y < UnityEngine.Screen.height
end

function CollegeChessRouteItem:setIsMove(isMove)
	if isMove ~= self._isMove then
		self._isMove = isMove
	end
end

function CollegeChessRouteItem:onDestroy()
	TaskDispatcher.cancelTask(self._onMove, self)
	TaskDispatcher.cancelTask(self.beginMove, self)
end

return CollegeChessRouteItem
