-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/BackpackPropDetailView.lua

module("logic.extensions.backpack.view.BackpackPropDetailView", package.seeall)

local M = class("BackpackPropDetailView", BackpackItemDetailView)

function M:refreshView()
	M.super.refreshView(self)

	local itemData = self._itemData
	local bigType, subType = ItemUtil.getItemTypeByItemId(itemData:getItemId())

	self._txtUse.text = lang("tip_r_equip_use")

	if subType == CommEnum.PropSubType.PowerProp or bigType == GameEnum.ItemTypeEnum.TreasureBox or bigType == GameEnum.ItemTypeEnum.PuzzlePiecesItem then
		goutil.setActive(self._btnUse.gameObject, true)

		if bigType == GameEnum.ItemTypeEnum.PuzzlePiecesItem then
			local count = itemData:getCount()

			if count < itemData:getPuzzleCount() then
				if subType == GameEnum.PuzzlePiecesSubTypeEnum.Echo then
					self._txtUse.text = lang("tip_compound_preview")
				else
					self._txtUse.text = lang("tip_compound")
				end
			else
				self._txtUse.text = lang("tip_compound")
			end
		end
	elseif subType == CommEnum.PropSubType.AirtightTimeProp then
		local isExpired = ItemUtil.isItemOverTime(itemData)
		local inSpTime, inSpNormal, inSpAirtight = AirtightRoomUtil.getSpTimeInfo()

		goutil.setActive(self._btnUse.gameObject, not isExpired and not inSpTime)
	else
		goutil.setActive(self._btnUse.gameObject, itemData:getJumpId() > 0)
	end

	local isUseItemShow = self._btnUse.gameObject.activeSelf

	self:setScrollSize(isUseItemShow)

	if itemData:getRedPointIsUseableGiftBox() then
		local cancelRed = true
		local cfg = itemData:getItemInfo()

		if cfg and cfg.clickNotCacncelRed then
			cancelRed = false
		end

		if cancelRed then
			local itemid = itemData:getUuid()
			local type = ItemUtil.getItemTypeByItemId(itemData:getItemId())

			BackpackAgent.instance:sendremoveRedPointRequest(type, {
				itemid
			})
		end
	end

	goutil.setActive(self._txtUseTips.gameObject, false)

	if not isUseItemShow then
		local itemInfo = BackpackConfig.instance:getConfigByKey(ConfigName.ItemProp, itemData:getItemId())

		if itemInfo and itemInfo.useTips then
			goutil.setActive(self._txtUseTips.gameObject, true)

			self._txtUseTips.text = itemInfo.useTips
		end
	end
end

function M:_onClickUseBtn()
	local itemData = self._itemData
	local bigType, subType = ItemUtil.getItemTypeByItemId(itemData:getItemId())

	if bigType == GameEnum.ItemTypeEnum.PuzzlePiecesItem then
		local count = itemData:getCount()

		if count < itemData:getPuzzleCount() then
			if subType == GameEnum.PuzzlePiecesSubTypeEnum.Echo then
				local param = {}

				param.itemData = ItemUtil.createItemData({
					itemId = itemData:getCompoundTargetId()
				})

				ViewMgr.instance:open(ViewName.EchoCompoundPreview, param)
			else
				FloatWordMgr.instance:show(lang("tip_goods_not_enough"))
			end
		else
			BackpackAgent.instance:sendComposeRequest(itemData:getCompoundSoureceId(), itemData:getCompoundTargetId(), itemData:getComposeCount())
		end
	else
		BackpackUtil.useItem(self._itemData)
	end
end

return M
