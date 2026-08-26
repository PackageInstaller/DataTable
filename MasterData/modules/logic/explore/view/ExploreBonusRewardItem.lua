-- chunkname: @modules/logic/explore/view/ExploreBonusRewardItem.lua

module("modules.logic.explore.view.ExploreBonusRewardItem", package.seeall)

local ExploreBonusRewardItem = class("ExploreBonusRewardItem", ListScrollCell)

function ExploreBonusRewardItem:init(go)
	self._num = gohelper.findChildText(go, "label/#txt_num")
	self._lightIcon = gohelper.findChild(go, "label/icon_light")
	self._normalIcon = gohelper.findChild(go, "label/icon_normal")
	self._rewardItem = gohelper.findChild(go, "go_rewarditem")
	self._itemParent = gohelper.findChild(go, "label/icons")
	self._goline = gohelper.findChild(go, "label/line1")
end

function ExploreBonusRewardItem:addEventListeners()
	return
end

function ExploreBonusRewardItem:removeEventListeners()
	return
end

function ExploreBonusRewardItem:onUpdateMO(mo)
	self._num.text = string.format("%02d", self._index)

	local mapCo = lua_explore_scene.configDict[mo.chapterId][mo.episodeId]

	self._isGet = ExploreSimpleModel.instance:getBonusIsGet(mapCo.id, mo.id)

	ZProj.UGUIHelper.SetColorAlpha(self._num, self._isGet and 0.3 or 1)
	gohelper.setActive(self._lightIcon, self._isGet)
	gohelper.setActive(self._normalIcon, not self._isGet)

	local rewards = GameUtil.splitString2(mo.bonus, true)

	self._items = self._items or {}

	gohelper.CreateObjList(self, self._setRewardItem, rewards, self._itemParent, self._rewardItem)
	gohelper.setActive(self._goline, #ExploreTaskModel.instance:getTaskList(0):getList() ~= self._index)
end

function ExploreBonusRewardItem:_setRewardItem(go, data, index)
	self._items[index] = self._items[index] or {}

	local icon = gohelper.findChild(go, "go_icon")
	local hasget = gohelper.findChild(go, "go_receive")

	if not self._items[index].item then
		local itemIcon = IconMgr.instance:getCommonPropItemIcon(icon)

		self._items[index].item = self._items[index].item

		self._items[index].item:setMOValue(data[1], data[2], data[3], nil, true)
		self._items[index].item:setCountFontSize(46)
		self._items[index].item:SetCountBgHeight(31)
		gohelper.setActive(hasget, self._isGet)
	end
end

function ExploreBonusRewardItem:onDestroyView()
	for i = 1, #self._items do
		self._items[i].item:onDestroy()
	end
end

return ExploreBonusRewardItem
