-- chunkname: @modules/logic/versionactivity3_3/arcade/view/hall/ArcadeHallInteractiveUIMgr.lua

module("modules.logic.versionactivity3_3.arcade.view.hall.ArcadeHallInteractiveUIMgr", package.seeall)

local ArcadeHallInteractiveUIMgr = class("ArcadeHallInteractiveUIMgr", ArcadeBaseSceneComp)

function ArcadeHallInteractiveUIMgr:onInit()
	self._gobuildingui = gohelper.findChild(self._scene.viewGO, "#go_buildingui")

	local name = gohelper.findChild(self._scene.viewGO, "#go_buildingui/name")
	local talk = gohelper.findChild(self._scene.viewGO, "#go_buildingui/talk")

	self._uiRoot = self:getUserDataTb_()
	self._uiRoot[ArcadeHallEnum.ShowUI.UIName] = name
	self._uiRoot[ArcadeHallEnum.ShowUI.UITalk] = talk

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeHallInteractiveUIMgr:_editableInitView()
	self:_onLoadUI()
end

function ArcadeHallInteractiveUIMgr:onOpen()
	self:refreshUIAnchor()
end

function ArcadeHallInteractiveUIMgr:_onLoadUI()
	local reslist = {}

	for _, param in pairs(ArcadeHallEnum.ShowUIParam) do
		table.insert(reslist, param.res)
	end

	self._scene.loader:loadResList(reslist, self._onLoadFinishUI, self)
end

function ArcadeHallInteractiveUIMgr:_onLoadFinishUI()
	self._interactiveMOs = self._scene:getInteractiveMOs()
	self._uiItems = {}

	for i, mo in pairs(self._interactiveMOs) do
		local infoUIList = mo:getShowInfoUI()

		if infoUIList then
			for _, type in ipairs(infoUIList) do
				local infoUIParam = ArcadeHallEnum.ShowUIParam[type]
				local res = self._scene.loader:getResource(infoUIParam.res)
				local go = gohelper.clone(res, self._uiRoot[type], i)
				local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, infoUIParam.comp)

				item:onUpdateMO(mo)

				self._uiItems[i] = self._uiItems[i] or {}
				self._uiItems[i][type] = item
			end
		end
	end

	self:refreshUIAnchor()
end

function ArcadeHallInteractiveUIMgr:refreshUIAnchor()
	for i, mo in pairs(self._interactiveMOs) do
		local infoUIList = mo:getShowInfoUI()
		local interactiveParam = ArcadeHallEnum.HallInteractiveParams[i]

		if infoUIList then
			for _, type in ipairs(infoUIList) do
				local item = self._uiItems[i][type]

				if item then
					local x, y = mo:getCenterPos()
					local worldPos = self._scene:onTransformPoint(x, y)
					local rectPos = self:worldPosToAnchorPos(worldPos)

					if rectPos then
						if interactiveParam.NameUIOffset then
							if not interactiveParam.NameUIOffset.x then
								local offsetX = 0

								if interactiveParam.NameUIOffset then
									if not interactiveParam.NameUIOffset.y then
										local offsetY = 0

										recthelper.setAnchor(item.viewGO.transform, rectPos.x + offsetX, rectPos.y + offsetY)
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function ArcadeHallInteractiveUIMgr:getUIItem(buildingId, type)
	return self._uiItems and self._uiItems[buildingId] and self._uiItems[buildingId][type]
end

function ArcadeHallInteractiveUIMgr:worldPosToAnchorPos(worldPos)
	local camera = CameraMgr.instance:getMainCamera()

	if not worldPos then
		return
	end

	return (recthelper.worldPosToAnchorPos(worldPos, self._gobuildingui.transform, nil, camera))
end

return ArcadeHallInteractiveUIMgr
