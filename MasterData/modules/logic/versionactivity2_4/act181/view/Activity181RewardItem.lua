-- chunkname: @modules/logic/versionactivity2_4/act181/view/Activity181RewardItem.lua

module("modules.logic.versionactivity2_4.act181.view.Activity181RewardItem", package.seeall)

local Activity181RewardItem = class("Activity181RewardItem", ListScrollCellExtend)

function Activity181RewardItem:init(go)
	self.go = go
	self._goHaveGet = gohelper.findChild(go, "#go_haveGet")

	gohelper.setActive(go, false)

	self._itemIcon = IconMgr.instance:getCommonItemIcon(go)

	gohelper.setAsLastSibling(self._goHaveGet)
end

function Activity181RewardItem:setEnable(active)
	gohelper.setActive(self.go, active)
end

function Activity181RewardItem:onUpdateMO(type, id, quantity, haveGet)
	self._itemIcon:setInPack(false)
	self._itemIcon:setMOValue(type, id, quantity)
	self._itemIcon:isShowName(false)
	self._itemIcon:isShowCount(true)
	self._itemIcon:isShowEffect(true)
	self._itemIcon:setGetMask(haveGet)
	self._itemIcon:setRecordFarmItem({
		type = type,
		id = id,
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = JumpController.instance:getCurrentOpenedView()
	})
	gohelper.setActive(self._goHaveGet, haveGet)
end

return Activity181RewardItem
