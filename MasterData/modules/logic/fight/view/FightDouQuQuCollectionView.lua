-- chunkname: @modules/logic/fight/view/FightDouQuQuCollectionView.lua

module("modules.logic.fight.view.FightDouQuQuCollectionView", package.seeall)

local FightDouQuQuCollectionView = class("FightDouQuQuCollectionView", FightBaseView)

function FightDouQuQuCollectionView:onInitView()
	self.collectionObjList = {}
	self.simage_iconList = {}
	self.img_rareList = {}

	for i = 1, 2 do
		table.insert(self.collectionObjList, gohelper.findChild(self.viewGO, "root/collection" .. i))
		table.insert(self.simage_iconList, gohelper.findChildSingleImage(self.viewGO, "root/collection" .. i .. "/simage_Icon"))
		table.insert(self.img_rareList, gohelper.findChildImage(self.viewGO, "root/collection" .. i .. "/image_Rare"))
	end
end

function FightDouQuQuCollectionView:addEvents()
	return
end

function FightDouQuQuCollectionView:onConstructor(entityMO)
	self.entityMO = entityMO
end

function FightDouQuQuCollectionView:refreshEntityMO(entityMO)
	self.entityMO = entityMO

	if self.viewGO then
		self:refreshCollection()
	end
end

function FightDouQuQuCollectionView:onOpen()
	self.customData = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191]

	self:refreshCollection()
end

function FightDouQuQuCollectionView:refreshCollection()
	if self.entityMO.side == FightEnum.EntitySide.MySide then
		if not self.customData.teamAHeroInfo then
			local data = self.customData.teamBHeroInfo
			local collectionList = {}

			for k, v in pairs(data) do
				if tonumber(k) == self.entityMO.modelId then
					local arr = string.splitToNumber(v, "#")

					for i = 2, #arr do
						local itemId = tonumber(arr[i])

						if itemId ~= 0 then
							table.insert(collectionList, itemId)
						end
					end

					break
				end
			end

			if #collectionList == 0 then
				gohelper.setActive(self.viewGO, false)

				return
			end

			gohelper.setActive(self.viewGO, true)

			for i = 1, #self.collectionObjList do
				local obj = self.collectionObjList[i]
				local itemId = collectionList[i]

				if itemId then
					gohelper.setActive(obj, true)

					local config = Activity191Config.instance:getCollectionCo(itemId)

					UISpriteSetMgr.instance:setAct174Sprite(self.img_rareList[i], "act174_propitembg_" .. config.rare)
					self.simage_iconList[i]:LoadImage(ResUrl.getRougeSingleBgCollection(config.icon))

					local click = gohelper.getClickWithDefaultAudio(obj)

					self:com_registClick(click, self.onItemClick, itemId)
				else
					gohelper.setActive(obj, false)
				end
			end
		end
	end
end

function FightDouQuQuCollectionView:onItemClick(itemId)
	local enhance = false

	for i, v in ipairs(self.customData.updateCollectionIds) do
		if v == itemId then
			enhance = true

			break
		end
	end

	local param = {
		itemId = itemId,
		enhance = enhance
	}

	Activity191Controller.instance:openCollectionTipView(param)
end

return FightDouQuQuCollectionView
