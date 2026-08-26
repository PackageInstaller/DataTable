-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDungeonDataBaseToastItem.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDungeonDataBaseToastItem", package.seeall)

local AtomicDungeonDataBaseToastItem = class("AtomicDungeonDataBaseToastItem", AtomicToastBaseItem)

function AtomicDungeonDataBaseToastItem:ctor(param)
	self.toastView = param.toastView
end

function AtomicDungeonDataBaseToastItem:init(go)
	AtomicDungeonDataBaseToastItem.super.init(self, go)

	self.imageIcon = gohelper.findChildImage(self.go, "image_icon")
	self.txtTips = gohelper.findChildText(self.go, "txt_tips")
end

function AtomicDungeonDataBaseToastItem:refreshUI(dataBaseCo)
	self.txtTips.text = dataBaseCo.unlockTips
end

function AtomicDungeonDataBaseToastItem:_delay()
	AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.RecycleDataBaseToast, self)
end

function AtomicDungeonDataBaseToastItem:setInitPosX()
	recthelper.setAnchorX(self.trans, self.width)
end

function AtomicDungeonDataBaseToastItem:onDestroy()
	AtomicDungeonDataBaseToastItem.super.onDestroy(self)
	self:clearAllTask()
end

return AtomicDungeonDataBaseToastItem
