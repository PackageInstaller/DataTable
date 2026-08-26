-- chunkname: @modules/logic/versionactivity3_2/dungeon/view/map/VersionActivity3_2DungeonFragmentInfoView.lua

module("modules.logic.versionactivity3_2.dungeon.view.map.VersionActivity3_2DungeonFragmentInfoView", package.seeall)

local VersionActivity3_2DungeonFragmentInfoView = class("VersionActivity3_2DungeonFragmentInfoView", DungeonFragmentInfoView)

function VersionActivity3_2DungeonFragmentInfoView:_loadImageCallback()
	gohelper.onceAddComponent(self._simagefragmenticon.gameObject, gohelper.Type_Image):SetNativeSize()
	transformhelper.setLocalScale(self._simagefragmenticon.transform, 1.6, 1.6, 1)
end

function VersionActivity3_2DungeonFragmentInfoView:_loadFragmentIcon(config)
	local elementId = config.id
	local elementConfig = lua_chapter_map_element.configDict[elementId]

	if elementConfig and elementConfig.type == DungeonEnum.ElementType.V3a2Note then
		self._simagefragmenticon:LoadImage(string.format("singlebg/v3a2_dungeon_singlebg/%s.png", config.res), self._loadImageCallback, self)

		return
	end

	if not string.nilorempty(config.res) then
		self._simagefragmenticon:LoadImage(ResUrl.getDungeonFragmentIcon(config.res))
	end
end

return VersionActivity3_2DungeonFragmentInfoView
