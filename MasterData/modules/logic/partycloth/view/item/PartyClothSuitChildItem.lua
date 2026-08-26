-- chunkname: @modules/logic/partycloth/view/item/PartyClothSuitChildItem.lua

module("modules.logic.partycloth.view.item.PartyClothSuitChildItem", package.seeall)

local PartyClothSuitChildItem = class("PartyClothSuitChildItem", LuaCompBase)

function PartyClothSuitChildItem:init(go)
	self.go = go
	self.imageQuality = gohelper.findChildImage(go, "quality")
	self.simageIcon = gohelper.findChildSingleImage(go, "icon")
	self.goLock = gohelper.findChild(go, "lock")
	self.goWear = gohelper.findChild(go, "wear")
end

function PartyClothSuitChildItem:setData(config)
	self.config = config

	self.simageIcon:LoadImage(ResUrl.getV3a4PartySingleBg(self.config.image, "cloth"))
	UISpriteSetMgr.instance:setV3a4LaplaceSprite(self.imageQuality, "partycloth_quality" .. tostring(self.config.rare))

	local mo = PartyClothModel.instance:getClothMo(self.config.clothId, true)

	gohelper.setActive(self.goLock, not mo)
	self:refreshWear()
end

function PartyClothSuitChildItem:refreshWear()
	if not self.config then
		return
	end

	local clothIdMap = PartyClothModel.instance:getWearClothIdMap()
	local isWear = clothIdMap[self.config.partId] == self.config.clothId

	gohelper.setActive(self.goWear, isWear)
end

return PartyClothSuitChildItem
