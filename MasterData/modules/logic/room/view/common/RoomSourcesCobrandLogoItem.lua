-- chunkname: @modules/logic/room/view/common/RoomSourcesCobrandLogoItem.lua

module("modules.logic.room.view.common.RoomSourcesCobrandLogoItem", package.seeall)

local RoomSourcesCobrandLogoItem = class("RoomSourcesCobrandLogoItem", ListScrollCellExtend)

function RoomSourcesCobrandLogoItem:onInitView()
	self._imagelogoicon = gohelper.findChildImage(self.viewGO, "logo/#image_logoicon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomSourcesCobrandLogoItem:addEvents()
	return
end

function RoomSourcesCobrandLogoItem:removeEvents()
	return
end

function RoomSourcesCobrandLogoItem:_editableInitView()
	return
end

function RoomSourcesCobrandLogoItem:_editableAddEvents()
	return
end

function RoomSourcesCobrandLogoItem:_editableRemoveEvents()
	return
end

function RoomSourcesCobrandLogoItem:onUpdateMO(mo)
	return
end

function RoomSourcesCobrandLogoItem:onSelect(isSelect)
	return
end

function RoomSourcesCobrandLogoItem:onDestroyView()
	return
end

function RoomSourcesCobrandLogoItem:setSourcesTypeStr(idStr)
	self._sourcesTypeCfg = self:_findSourcesTypeCfg(idStr)
	self._isShow = false

	if self._sourcesTypeCfg then
		self._isShow = true

		UISpriteSetMgr.instance:setRoomSprite(self._imagelogoicon, self._sourcesTypeCfg.bgIcon)
	end

	gohelper.setActive(self.viewGO, self._isShow)
end

function RoomSourcesCobrandLogoItem:getIsShow()
	return self._isShow
end

function RoomSourcesCobrandLogoItem:_findSourcesTypeCfg(idStr)
	if not idStr or string.nilorempty(idStr) then
		return nil
	end

	local idList = string.splitToNumber(idStr, "#")

	if idList == nil or #idList < 1 then
		return nil
	end

	local sourceTypeCfg
	local showType = RoomEnum.SourcesShowType.Cobrand

	for _, id in ipairs(idList) do
		local tcfg = RoomConfig.instance:getSourcesTypeConfig(id)

		if tcfg and tcfg.showType == showType then
			sourceTypeCfg = tcfg

			break
		end
	end

	return sourceTypeCfg
end

return RoomSourcesCobrandLogoItem
