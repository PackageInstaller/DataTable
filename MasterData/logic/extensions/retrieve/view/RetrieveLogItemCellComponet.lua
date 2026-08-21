-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/view/RetrieveLogItemCellComponet.lua

module("logic.extensions.retrieve.view.RetrieveLogItemCellComponet", package.seeall)

local ButtonAdapter = Astral.ButtonAdapter
local M = class("RetrieveLogItemCellComponet", CellBaseComponent)

function M:ctor(cell)
	M.super.ctor(self, cell)

	self._timeText = nil
	self._nameTxt = nil
end

function M:onInit()
	local registry = self._cell:getViewElementsRegistry()

	self._timeText = registry:findUIElement("retrieve_log_item_-888779877", UIComponentType.Text)
	self._nameTxt = registry:findUIElement("retrieve_log_item_1622218812", UIComponentType.Text)
	self._typeTxt = registry:findUIElement("retrieve_log_item_1859257840", UIComponentType.Text)
end

function M:updateData(data)
	local log = data.log

	if data.type == RetrieveEnum.LotterySimpleType.Card then
		self._typeTxt.text = lang("tip_role")

		local characterCO = CharacterConfig.instance:getCfgInfoByID(log.itemCode)
		local heroInfoCO = PastInfoConfig.instance:getCharacterInfo(log.itemCode)

		self._nameTxt.text = heroInfoCO.name

		TextUtils.SetColor(self._nameTxt, CommEnum.LotteryCardQualityColor[characterCO.quality])
	else
		self._typeTxt.text = lang("t_echo")

		local itemCO = BackpackConfig.instance:getItemInfoByItemId(log.itemCode)

		if itemCO then
			self._nameTxt.text = itemCO.name

			TextUtils.SetColor(self._nameTxt, CommEnum.LotteryCardQualityColor[itemCO.quality])
		end
	end

	self._timeText.text = TimeUtil.instance:stampToDateStr(log.time)
end

function M:onDestroy()
	M.super.onDestroy(self)
end

return M
