-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicRewardToastItem.lua

module("modules.logic.sp02.dungeonmap.view.AtomicRewardToastItem", package.seeall)

local AtomicRewardToastItem = class("AtomicRewardToastItem", AtomicToastBaseItem)

function AtomicRewardToastItem:ctor(param)
	self.toastView = param.toastView
end

function AtomicRewardToastItem:init(go)
	AtomicRewardToastItem.super.init(self, go)

	self.simageIcon = gohelper.findChildSingleImage(self.go, "pos/simage_icon")
	self.imageQuality = gohelper.findChildImage(self.go, "pos/image_quality")
	self.txtName = gohelper.findChildText(self.go, "pos/txt_name")
end

function AtomicRewardToastItem:refreshUI(materialDataMo)
	local config, icon = ItemModel.instance:getItemConfigAndIcon(materialDataMo.materilType, materialDataMo.materilId)

	if not config then
		logError("道具配置不存在，请检查：" .. materialDataMo.materilId)
	end

	self.txtName.text = config.name

	self.simageIcon:LoadImage(icon)
end

function AtomicRewardToastItem:_delay()
	AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.RecycleRewardToast, self)
end

function AtomicRewardToastItem:setInitPosX()
	recthelper.setAnchorX(self.trans, -self.width)
end

function AtomicRewardToastItem:onDestroy()
	AtomicRewardToastItem.super.onDestroy(self)
	self.simageIcon:UnLoadImage()
	self:clearAllTask()
end

return AtomicRewardToastItem
