-- chunkname: @modules/logic/versionactivity2_3/newcultivationgift/view/VersionActivity2_3NewCultivationRewardItem.lua

module("modules.logic.versionactivity2_3.newcultivationgift.view.VersionActivity2_3NewCultivationRewardItem", package.seeall)

local VersionActivity2_3NewCultivationRewardItem = class("VersionActivity2_3NewCultivationRewardItem", RougeSimpleItemBase)

function VersionActivity2_3NewCultivationRewardItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_3NewCultivationRewardItem:addEvents()
	return
end

function VersionActivity2_3NewCultivationRewardItem:removeEvents()
	return
end

function VersionActivity2_3NewCultivationRewardItem:ctor(ctorParam)
	VersionActivity2_3NewCultivationRewardItem.super.ctor(self, ctorParam)
end

function VersionActivity2_3NewCultivationRewardItem:_editableInitView()
	self._itemIcon = IconMgr.instance:getCommonItemIcon(self.viewGO)
end

function VersionActivity2_3NewCultivationRewardItem:setData(mo)
	self._mo = mo

	local itemCo = mo

	self._itemIcon:setInPack(false)
	self._itemIcon:setMOValue(itemCo[1], itemCo[2], itemCo[3])
	self._itemIcon:isShowName(false)
	self._itemIcon:isShowCount(true)
	self._itemIcon:isShowEffect(true)
	self._itemIcon:setRecordFarmItem({
		type = itemCo[1],
		id = itemCo[2],
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = JumpController.instance:getCurrentOpenedView()
	})
end

return VersionActivity2_3NewCultivationRewardItem
