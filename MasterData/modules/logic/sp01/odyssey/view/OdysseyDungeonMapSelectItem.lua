-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyDungeonMapSelectItem.lua

module("modules.logic.sp01.odyssey.view.OdysseyDungeonMapSelectItem", package.seeall)

local OdysseyDungeonMapSelectItem = class("OdysseyDungeonMapSelectItem", LuaCompBase)
local BOX_COLLIDER_SIZE = Vector2(200, 200)

function OdysseyDungeonMapSelectItem:ctor(param)
	self.config = param[1]
	self.mapSelectView = param[2]
end

function OdysseyDungeonMapSelectItem:init(go)
	self.go = go
	self.trans = self.go.transform
	self.goSelect = gohelper.findChild(self.go, "go_select")
	self.txtName = gohelper.findChildText(self.go, "name/txt_name")
	self.goMercenary = gohelper.findChild(self.go, "go_mercenary")
	self.goMercenaryItem = gohelper.findChild(self.go, "go_mercenary/go_mercenaryItem")
	self.goHeroItem = gohelper.findChild(self.go, "go_heroItem")
	self.goMainTask = gohelper.findChild(self.go, "go_mainTask")
	self.goMainTaskEffect = gohelper.findChild(self.go, "go_mainTask/icon/glow2")
	self.goLock = gohelper.findChild(self.go, "go_lock")
	self.goInfo = gohelper.findChild(self.go, "go_info")
	self.txtExplore = gohelper.findChildText(self.go, "go_info/txt_explore")
	self.txtLevel = gohelper.findChildText(self.go, "go_info/txt_level")
	self.goReddot = gohelper.findChild(self.go, "go_reddot")

	self.addBoxColliderListener(self.go, self.onClickDown, self)
	gohelper.setActive(self.goSelect, false)
	gohelper.setActive(self.goMainTaskEffect, false)
end

function OdysseyDungeonMapSelectItem.addBoxColliderListener(go, callback, callbackTarget)
	local clickListener = ZProj.BoxColliderClickListener.Get(go)

	clickListener:SetIgnoreUI(true)
	clickListener:AddClickListener(callback, callbackTarget)
end

function OdysseyDungeonMapSelectItem:onClickDown()
	self.mapSelectView:onMapItemClickDown(self)
end

function OdysseyDungeonMapSelectItem:addEvents()
	OdysseyDungeonController.instance:registerCallback(OdysseyEvent.OnUpdateElementPush, self.updateInfo, self)
end

function OdysseyDungeonMapSelectItem:removeEvents()
	OdysseyDungeonController.instance:unregisterCallback(OdysseyEvent.OnUpdateElementPush, self.updateInfo, self)
end

function OdysseyDungeonMapSelectItem:updateInfo()
	self.txtName.text = self.config.mapName
	self.curInMapId = OdysseyDungeonModel.instance:getHeroInMapId()

	gohelper.setActive(self.goHeroItem, self.curInMapId == self.config.id)

	self.mapInfoMo = OdysseyDungeonModel.instance:getMapInfo(self.config.id)

	if self.mapInfoMo then
		self.txtExplore.text = string.format("%s%%", math.floor(self.mapInfoMo.exploreValue / 10))

		local recommendLevelList = string.splitToNumber(self.config.recommendLevel, "#")

		self.txtLevel.text = string.format("%s-%s", recommendLevelList[1], recommendLevelList[2])
	end

	local mainTaskMapCo, mainTaskElementCo = OdysseyDungeonModel.instance:getCurMainElement()

	self.canShowMainTask = mainTaskElementCo and mainTaskElementCo.mapId == self.config.id

	gohelper.setActive(self.goMainTask, self.canShowMainTask)
	gohelper.setActive(self.goLock, not self.mapInfoMo)
	gohelper.setActive(self.goInfo, self.mapInfoMo)

	local mercenaryEleMoList = OdysseyDungeonModel.instance:getMercenaryElementsByMap(self.config.id)

	gohelper.setActive(self.goMercenary, #mercenaryEleMoList > 0)

	if #mercenaryEleMoList > 0 then
		gohelper.CreateObjList(self, self.onMercenaryItemShow, mercenaryEleMoList, self.goMercenary, self.goMercenaryItem)
	end
end

function OdysseyDungeonMapSelectItem:onMercenaryItemShow(obj, data, index)
	gohelper.setActive(obj, data)
end

function OdysseyDungeonMapSelectItem:setSelectState(state)
	gohelper.setActive(self.goSelect, state)
	gohelper.setActive(self.goMainTaskEffect, false)
end

function OdysseyDungeonMapSelectItem:playMainTaskEffect()
	gohelper.setActive(self.goMainTaskEffect, false)
	gohelper.setActive(self.goMainTaskEffect, true)
end

function OdysseyDungeonMapSelectItem:refreshReddotShowState()
	local isNewUnlock = OdysseyDungeonModel.instance:checkHasNewUnlock(OdysseyEnum.LocalSaveKey.MapNew, {
		self.config.id
	})

	gohelper.setActive(self.goReddot, isNewUnlock and self.mapInfoMo)
end

function OdysseyDungeonMapSelectItem:onDestroy()
	return
end

return OdysseyDungeonMapSelectItem
