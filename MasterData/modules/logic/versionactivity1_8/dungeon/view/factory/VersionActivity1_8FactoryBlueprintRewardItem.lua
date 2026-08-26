-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/factory/VersionActivity1_8FactoryBlueprintRewardItem.lua

module("modules.logic.versionactivity1_8.dungeon.view.factory.VersionActivity1_8FactoryBlueprintRewardItem", package.seeall)

local VersionActivity1_8FactoryBlueprintRewardItem = class("VersionActivity1_8FactoryBlueprintRewardItem", UserDataDispose)

function VersionActivity1_8FactoryBlueprintRewardItem:ctor(go, componentId, progressPointGo)
	self:__onInit()

	self.go = go
	self.trans = go.transform
	self.componentId = componentId

	if progressPointGo then
		self.progressPointLightGo = gohelper.findChild(progressPointGo, "light")
	end

	self.actId = Activity157Model.instance:getActId()

	local rewardDataList = {}
	local strReward = Activity157Config.instance:getComponentReward(self.actId, self.componentId)

	if not string.nilorempty(strReward) then
		rewardDataList = GameUtil.splitString2(strReward, true)
	end

	self._rewardItemList = {}

	for i, rewardData in ipairs(rewardDataList) do
		local rewardGo = gohelper.findChild(self.go, "reward" .. i)

		if rewardGo then
			local item = self:getUserDataTb_()
			local type = rewardData[1]
			local id = rewardData[2]

			item.gohasget = gohelper.findChild(rewardGo, "#go_hasget")

			local itemConfig, icon = ItemModel.instance:getItemConfigAndIcon(type, id)

			if type == MaterialEnum.MaterialType.Building then
				local buildingLevel = Activity157Config.instance:getComponentBonusBuildingLevel(self.actId, self.componentId)
				local cfg = RoomConfig.instance:getLevelGroupConfig(id, buildingLevel)

				if cfg then
					icon = ResUrl.getRoomBuildingPropIcon(cfg.icon)
				end
			end

			item.simagereward = gohelper.findChildSingleImage(rewardGo, "#simage_reward")

			if icon then
				item.simagereward:LoadImage(icon)
			end

			local bgRare = gohelper.findChildImage(rewardGo, "bg")

			if bgRare then
				local rare = itemConfig.rare

				UISpriteSetMgr.instance:setV1a8FactorySprite(bgRare, "v1a8_dungeon_factory_rewardbg" .. rare)
			end

			local txtrewardcount = gohelper.findChildText(rewardGo, "#txt_rewardcount")

			txtrewardcount.text = luaLang("multiple") .. rewardData[3]

			table.insert(self._rewardItemList, item)
		end
	end

	local rewardDataCount = #rewardDataList
	local rewardGoCount = self.trans.childCount

	if rewardDataCount < rewardGoCount then
		for i = rewardDataCount + 1, rewardGoCount do
			local rewardTrans = self.trans:GetChild(i - 1)

			gohelper.setActive(rewardTrans.gameObject, false)
		end
	end
end

function VersionActivity1_8FactoryBlueprintRewardItem:refresh(isPlayAnim)
	local isRepairedComponent = Activity157Model.instance:isRepairComponent(self.componentId)
	local hasGet = Activity157Model.instance:hasComponentGotReward(self.componentId)

	for _, rewardItem in ipairs(self._rewardItemList) do
		local hasGetGo = rewardItem.gohasget

		gohelper.setActive(hasGetGo, hasGet)

		if isPlayAnim and isRepairedComponent and not hasGet then
			self:playHasGetAnim(hasGetGo)
		end
	end

	gohelper.setActive(self.progressPointLightGo, hasGet)
end

function VersionActivity1_8FactoryBlueprintRewardItem:playHasGetAnim(hasGetGo)
	gohelper.setActive(hasGetGo, true)

	local animator = hasGetGo:GetComponent(typeof(UnityEngine.Animator))

	animator:Play("go_hasget_in")
end

function VersionActivity1_8FactoryBlueprintRewardItem:destroy()
	for _, item in pairs(self._rewardItemList) do
		item.simagereward:UnLoadImage()
	end

	self:__onDispose()
end

return VersionActivity1_8FactoryBlueprintRewardItem
