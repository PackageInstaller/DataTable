-- chunkname: @modules/common/global/screen/GameScreenTouch.lua

module("modules.common.global.screen.GameScreenTouch", package.seeall)

local GameScreenTouch = class("GameScreenTouch")
local GCInterval = 120

function GameScreenTouch:ctor()
	self._prefabTb = {}
	self._effectItemTb = {}
	self._globalTouchGO = gohelper.create2d(ViewMgr.instance:getUILayer(UILayerName.Top), "GlobalTouch")
	self._globalTouch = TouchEventMgrHepler.getTouchEventMgr(self._globalTouchGO)

	self._globalTouch:SetIgnoreUI(true)
	self._globalTouch:SetOnlyTouch(true)
	self._globalTouch:SetOnTouchDownCb(self._onTouchDownCb, self)
	self._globalTouch:SetOnTouchUp(self._onTouchUpCb, self)

	self._gamepadModel = SDKNativeUtil.isGamePad()

	self:_loadEffect()
	TaskDispatcher.runRepeat(self._onTick, self, 5)
	GameStateMgr.instance:registerCallback(GameStateEvent.onApplicationPause, self._onApplicationPause, self)
end

function GameScreenTouch:playTouchEffect(pos)
	self:_playTouchEffect(pos)
end

function GameScreenTouch:_onTick()
	local now = Time.realtimeSinceStartup

	if self._lastTime and now - self._lastTime > GCInterval then
		self._lastTime = now

		if GameGlobalMgr.instance:isBanGC() then
			logNormal("GameScreenTouch DelayFullGC ban gc")

			return
		end

		GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 1, self)
	end
end

function GameScreenTouch:_onApplicationPause(isFront)
	if isFront then
		self._lastTime = Time.realtimeSinceStartup
	end
end

function GameScreenTouch:_onTouchDownCb()
	GameStateMgr.instance:dispatchEvent(GameStateEvent.OnTouchScreen)

	if self._gamepadModel == false and GMFightShowState.screenTouchEffect then
		self._lastTime = Time.realtimeSinceStartup

		self:_playTouchEffect()
	end
end

function GameScreenTouch:_onTouchUpCb()
	GameStateMgr.instance:dispatchEvent(GameStateEvent.OnTouchScreenUp)
end

function GameScreenTouch:_loadEffect()
	self._maxNum = 7
	self._effectNum = 4
	self._effectIndex = self._maxNum
	self._effectUrl = self:_getClickResPath()
	self._effectLoader = MultiAbLoader.New()

	self._effectLoader:addPath(self._effectUrl)
	self._effectLoader:startLoad(self._createEffect, self)
end

function GameScreenTouch:refreshEffect()
	local prefabName = self:getCurUseUIPrefabName()

	self:_recycleEffects(prefabName)

	if not self._prefabTb[prefabName] then
		self:_loadEffect()

		return
	end

	self._effectPrefab = self._prefabTb[prefabName]
	self._effectItemTb[prefabName] = self._effectItemTb[prefabName] or {}
end

function GameScreenTouch:_recycleEffects(ignoreName)
	for name, tb in pairs(self._effectItemTb) do
		if name ~= ignoreName then
			for _, effect in pairs(tb) do
				self:_recycleEffect(effect.go)
			end
		end
	end
end

function GameScreenTouch:_getClickResPath()
	return (string.format(ClickUISwitchEnum.ClickUIPath, self:getCurUseUIPrefabName()))
end

function GameScreenTouch:getCurUseUIPrefabName()
	if SurvivalMapHelper.instance:isInSurvivalScene() then
		return "laplace_click"
	end

	local co = ClickUISwitchModel.instance:getCurUseUICo()

	if not co or string.nilorempty(co.effect) then
		return ClickUISwitchEnum.DefaultClickUIPrefabName
	end

	return co.effect
end

function GameScreenTouch:_createEffect(effectLoader)
	local path = self:_getClickResPath()
	local assetItem = effectLoader:getAssetItem(path)
	local prefab = assetItem:GetResource(path)

	self._effectPrefab = prefab

	for i = 1, self._effectNum do
		self:_create(self._effectPrefab)
	end

	local name = self:getCurUseUIPrefabName()

	self._prefabTb[name] = prefab
end

function GameScreenTouch:_create(effectGO)
	local item = {}
	local effectItem = gohelper.clone(effectGO, self._globalTouchGO)

	item.go = effectItem

	function item.recycleFunc()
		self:_recycleEffect(effectItem)
	end

	local image = gohelper.findChildImage(effectItem, "image")
	local material = image.material

	image.material = UnityEngine.Object.Instantiate(material)

	local materialPropsCtrl = effectItem:GetComponent(typeof(ZProj.MaterialPropsCtrl))

	if materialPropsCtrl then
		materialPropsCtrl.mas:Clear()
		materialPropsCtrl.mas:Add(image.material)
	end

	gohelper.setActive(effectItem, false)

	local prefabName = self:getCurUseUIPrefabName()

	self._effectItemTb[prefabName] = self._effectItemTb[prefabName] or {}

	table.insert(self._effectItemTb[prefabName], item)

	return item
end

function GameScreenTouch:_getEffect()
	local prefabName = self:getCurUseUIPrefabName()
	local effecttb = self._effectItemTb[prefabName]

	if effecttb then
		for i = 1, #effecttb do
			if effecttb[i].go.activeInHierarchy == false then
				self._effectIndex = i

				return effecttb[i]
			end
		end

		if #effecttb < self._maxNum then
			if not self._prefabTb[prefabName] then
				return
			end

			return self:_create(self._prefabTb[prefabName])
		else
			self._effectIndex = (self._effectIndex + 1) % self._maxNum

			if self._effectIndex <= 0 then
				self._effectIndex = self._maxNum
			end

			self:_recycleEffect(effecttb[self._effectIndex].go)

			return effecttb[self._effectIndex]
		end
	else
		self:refreshEffect()
	end
end

function GameScreenTouch:_playTouchEffect(pos)
	if not self:_canShowEffect() then
		return
	end

	local effectGO = self:_getEffect()

	if effectGO then
		local effectAnim = effectGO.go:GetComponent(typeof(UnityEngine.Animation))
		local mousePos = pos or UnityEngine.Input.mousePosition

		mousePos = recthelper.screenPosToAnchorPos(mousePos, self._globalTouchGO.transform)

		recthelper.setAnchor(effectGO.go.transform, mousePos.x, mousePos.y)
		effectAnim:Stop()
		gohelper.setActive(effectGO.go, true)
		effectAnim:Play()
		TaskDispatcher.runDelay(effectGO.recycleFunc, self, 0.7)
	end
end

function GameScreenTouch:_recycleEffect(effectGO)
	local effectAnim = effectGO:GetComponent(typeof(UnityEngine.Animation))

	gohelper.setActive(effectGO, false)
	effectAnim:Stop()
	recthelper.setAnchor(effectGO.transform, 0, 0)
end

function GameScreenTouch:_canShowEffect()
	local viewNameList = ViewMgr.instance:getOpenViewNameList()

	if viewNameList[#viewNameList] == ViewName.DungeonView and DungeonModel.instance:getDungeonStoryState() or viewNameList[#viewNameList] == ViewName.FightView and FightModel.instance:getClickEnemyState() or viewNameList[#viewNameList] == ViewName.StoryFrontView and StoryModel.instance:isVersionActivityPV() then
		return false
	end

	return true
end

return GameScreenTouch
