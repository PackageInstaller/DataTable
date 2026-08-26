-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDungeonMapSelectItem.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDungeonMapSelectItem", package.seeall)

local AtomicDungeonMapSelectItem = class("AtomicDungeonMapSelectItem", LuaCompBase)

function AtomicDungeonMapSelectItem:ctor(param)
	self.config = param[1]
	self.mapSelectView = param[2]
end

function AtomicDungeonMapSelectItem:init(go)
	self.go = go
	self.trans = self.go.transform
	self.goUnlock = gohelper.findChild(go, "go_unlock")
	self.txtMapName = gohelper.findChildText(go, "go_unlock/bg/txt_mapName")
	self.goExplore = gohelper.findChild(go, "go_unlock/explore")
	self.txtExplore = gohelper.findChildText(go, "go_unlock/explore/txt_explore")
	self.goFinish = gohelper.findChild(go, "go_unlock/finish")
	self.goLock = gohelper.findChild(go, "go_lock")

	gohelper.setLayer(self.go, UnityLayer.Scene)
end

function AtomicDungeonMapSelectItem:addEventListeners()
	return
end

function AtomicDungeonMapSelectItem:removeEventListeners()
	return
end

function AtomicDungeonMapSelectItem:updateInfo()
	self.txtMapName.text = self.config.mapName

	local curMapId = AtomicDungeonModel.instance:getMapIdByArenaMapId(self.config.id)

	self.mapMo = AtomicDungeonModel.instance:getMapInfo(curMapId)

	local curFinishCount, needFinishCount, curMapIndex = AtomicDungeonModel.instance:getCurArenaMapProgress(self.config.id)
	local isPolygonUnlock = AtomicDungeonModel.instance:checkPolygonUnlock(curMapId)
	local isMapFinish = false

	if isPolygonUnlock then
		isMapFinish = AtomicDungeonModel.instance:checkCanShowPolygon(curMapId)
		self.txtExplore.text = canShowPolygon and luaLang("partygame_game19_finish") or luaLang("sp02_atomic_polygon_doing")
	else
		self.txtExplore.text = GameUtil.getSubPlaceholderLuaLangThreeParam(luaLang("sp02_atomic_map_progress"), GameUtil.getRomanNums(curMapIndex), curFinishCount, needFinishCount)
	end

	gohelper.setActive(self.goUnlock, self.mapMo)
	gohelper.setActive(self.goLock, not self.mapMo)
	gohelper.setActive(self.goExplore, not isMapFinish)
	gohelper.setActive(self.goFinish, isMapFinish)
end

function AtomicDungeonMapSelectItem:onDestroy()
	return
end

return AtomicDungeonMapSelectItem
