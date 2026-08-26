-- chunkname: @modules/logic/versionactivity3_2/dungeon/view/map/VersionActivity3_2DungeonMapElementItem.lua

module("modules.logic.versionactivity3_2.dungeon.view.map.VersionActivity3_2DungeonMapElementItem", package.seeall)

local VersionActivity3_2DungeonMapElementItem = class("VersionActivity3_2DungeonMapElementItem", ListScrollCellExtend)

function VersionActivity3_2DungeonMapElementItem:onInitView()
	self._gojianbao = gohelper.findChild(self.viewGO, "#go_jianbao")
	self._goqianyishi = gohelper.findChild(self.viewGO, "#go_qianyishi")
	self._gounfinish = gohelper.findChild(self.viewGO, "#go_qianyishi/#go_unfinish")
	self._gofinished = gohelper.findChild(self.viewGO, "#go_qianyishi/#go_finished")
	self._imagefill = gohelper.findChildImage(self.viewGO, "#go_qianyishi/#go_finished/progress/#image_fill")
	self._txtactivitydesc = gohelper.findChildText(self.viewGO, "#go_qianyishi/#go_finished/progress/#txt_activitydesc")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity3_2DungeonMapElementItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function VersionActivity3_2DungeonMapElementItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function VersionActivity3_2DungeonMapElementItem:_btnclickOnClick()
	return
end

function VersionActivity3_2DungeonMapElementItem:_editableInitView()
	return
end

function VersionActivity3_2DungeonMapElementItem:_editableAddEvents()
	return
end

function VersionActivity3_2DungeonMapElementItem:_editableRemoveEvents()
	return
end

function VersionActivity3_2DungeonMapElementItem:onUpdateMO(mo)
	return
end

function VersionActivity3_2DungeonMapElementItem:onSelect(isSelect)
	return
end

function VersionActivity3_2DungeonMapElementItem:onDestroyView()
	return
end

function VersionActivity3_2DungeonMapElementItem:_addFollower(go, config, index)
	local episodeId = config.id
	local extraConfig = lua_v3a2_chapter_map.configDict[episodeId]
	local uiFollower = gohelper.onceAddComponent(go, typeof(ZProj.UIFollower))
	local name = string.format("%s_%s", config.type, config.id)
	local entity = self:getSceneNode(name)

	if extraConfig then
		if not extraConfig.position then
			local eventCoordinate = {}

			if not eventCoordinate[1] then
				local posX = 0

				if not eventCoordinate[2] then
					local posY = 0

					transformhelper.setLocalPos(entity.transform, posX, posY, 0)

					local mainCamera = CameraMgr.instance:getMainCamera()
					local uiCamera = CameraMgr.instance:getUICamera()
					local plane = ViewMgr.instance:getUIRoot().transform

					uiFollower:Set(mainCamera, uiCamera, plane, entity.transform, 0, 0, 0, 0, 0)
					uiFollower:SetEnable(true)
					uiFollower:ForceUpdate()
				end
			end
		end
	end
end

return VersionActivity3_2DungeonMapElementItem
