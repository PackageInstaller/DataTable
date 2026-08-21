-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/BackpackeEchoCardPackDetailView.lua

module("logic.extensions.backpack.view.BackpackeEchoCardPackDetailView", package.seeall)

local M = class("BackpackeEchoCardPackDetailView", BackpackItemDetailView)

function M:refreshView()
	M.super.refreshView(self)

	local itemData = self._itemData

	goutil.setActive(self._btnUse.gameObject, true)

	local isUseItemShow = self._btnUse.gameObject.activeSelf

	self:setScrollSize(isUseItemShow)
	goutil.setActive(self._txtUseTips.gameObject, false)

	if not isUseItemShow then
		local itemInfo = BackpackConfig.instance:getConfigByKey(ConfigName.ItemProp, itemData:getItemId())

		if itemInfo and itemInfo.useTips then
			goutil.setActive(self._txtUseTips.gameObject, true)

			self._txtUseTips.text = itemInfo.useTips
		end
	end

	if itemData:getRedPointIsNew() then
		local itemid = itemData:getUuid()
		local type = GameEnum.ItemTypeEnum.PropItemType

		BackpackAgent.instance:sendremoveRedPointRequest(type, {
			itemid
		})
	end
end

function M:_onClickUseBtn()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleCarryEcho, true) then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.EchoCardUnpackView) then
		return
	end

	ViewMgr.instance:open(ViewName.EchoCardPackView, EchoCardPackController.ViewType.Use, self._itemData)
end

return M
