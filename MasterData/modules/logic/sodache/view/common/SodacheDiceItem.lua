-- chunkname: @modules/logic/sodache/view/common/SodacheDiceItem.lua

module("modules.logic.sodache.view.common.SodacheDiceItem", package.seeall)

local SodacheDiceItem = class("SodacheDiceItem", LuaCompBase)

function SodacheDiceItem:init(go)
	self.go = go
	self.transform = go.transform
	self.imageFaceList = self:getUserDataTb_()

	for i = 1, 3 do
		self.imageFaceList[i] = gohelper.findChildImage(go, "image_Face" .. tostring(i))
	end

	self.goCount = gohelper.setActive(go, "go_Count")
	self.goCountItem = gohelper.findChild(go, "go_Count/CountItem")
	self.countItemMap = {}

	gohelper.setActive(self.goCountItem, false)
end

function SodacheDiceItem:setData(diceId, colorCnt)
	self.config = lua_sodache_dice.configDict[diceId]

	if not self.config then
		return
	end

	self.faceList = string.splitToNumber(self.config.faceList, "#")

	for i = 1, 3 do
		if self.faceList[i] then
			local resName = string.format("sodache_touzi_%d_%d", self.faceList[i], i)

			UISpriteSetMgr.instance:setSodache2Sprite(self.imageFaceList[i], resName)
		end
	end

	if colorCnt then
		local colorInfo = SodacheConfig.instance:getDiceColorInfo(self.config.id)

		for _, colorId in pairs(SodacheEnum.DiceColor) do
			if colorId ~= SodacheEnum.DiceColor.None then
				local item = self.countItemMap[colorId]

				if not item then
					item = self:getUserDataTb_()
					item.go = gohelper.cloneInPlace(self.goCountItem)

					local imageColor = gohelper.findChildImage(item.go, "image_Color")

					UISpriteSetMgr.instance:setSodache2Sprite(imageColor, "sodache_touzi_" .. tostring(colorId))

					item.txtCount = gohelper.findChildText(item.go, "txt_Count")
					self.countItemMap[colorId] = item
				end

				local count = colorInfo[colorId]

				item.txtCount.text = count

				gohelper.setActive(item.go, count ~= 0)
			end
		end
	end

	gohelper.setActive(self.goCount, colorCnt)
end

return SodacheDiceItem
