-- chunkname: @modules/logic/versionactivity4_0/deleike/view/DeleikeGameScene.lua

module("modules.logic.versionactivity4_0.deleike.view.DeleikeGameScene", package.seeall)

local DeleikeGameScene = class("DeleikeGameScene", BaseView)

function DeleikeGameScene:onInitView()
	self._goJoystick = gohelper.findChild(self.viewGO, "#go_Joystick")

	local go = ViewMgr.instance:getUILayer("POPUP_SECOND")

	self.goSceneRoot = self:getResInst(DeleikeEnum.GameScenePath, go, "DeleikeGameScene")
	self.anim = gohelper.findComponentAnim(self.goSceneRoot)
	self.goScene = gohelper.findChild(self.goSceneRoot, "#go_Scene")
end

function DeleikeGameScene:_onResetGame()
	self.anim:Play("open", 0, 0)
	self:buildMap()
end

function DeleikeGameScene:onOpen()
	self.addEventCb(self, DeleikeController.instance, DeleikeEvent.ResetGame, self._onResetGame, self)
	DeleikeGameMgr.instance:initScene(self.goScene)
	self:buildMap()
end

function DeleikeGameScene:buildMap()
	AudioMgr.instance:trigger(AudioEnum4_0.Deleike.game_start)
	DeleikeGameMgr.instance:clearScene()

	local mapCfg = DeleikeGameMgr.instance.mapCfg

	DeleikeGameMgr.instance:addBgTile(0, 0, Vector2.zero)

	for _, w in ipairs(mapCfg.walls) do
		if w.type == "anchor" then
			if not DeleikeEnum.TileType.Anchor then
				local tileType = DeleikeEnum.TileType.Normal
				local ix = math.floor(w.x + 0.5)
				local iy = math.floor(w.y + 0.5)

				DeleikeGameMgr.instance:addPolygonTile(tileType, ix, iy, DeleikeHelper.GridToWorld(ix, iy))
			end
		end
	end

	for _, endpoint in ipairs(mapCfg.triggers) do
		local type = endpoint.type
		local ix = math.floor(endpoint.x + 0.5)
		local iy = math.floor(endpoint.y + 0.5)

		DeleikeGameMgr.instance:addTriggerPoint(type, ix, iy, DeleikeHelper.GridToWorld(ix, iy))
	end

	local spawnPos = DeleikeHelper.GridToWorld(mapCfg.spawn.x, mapCfg.spawn.y)

	DeleikeGameMgr.instance:createPlayer(spawnPos, self._goJoystick)
end

function DeleikeGameScene:onDestroyView()
	DeleikeGameMgr.instance:dispose()
	gohelper.destroy(self.goSceneRoot)
end

return DeleikeGameScene
