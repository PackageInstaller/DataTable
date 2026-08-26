-- chunkname: @modules/logic/playercard/model/PlayerCardThemeListModel.lua

module("modules.logic.playercard.model.PlayerCardThemeListModel", package.seeall)

local PlayerCardThemeListModel = class("PlayerCardThemeListModel", ListScrollModel)

function PlayerCardThemeListModel:init()
	local moList = {}
	local list = ItemConfig.instance:getItemListBySubType(ItemEnum.SubType.PlayerBg)
	local selectId = PlayerCardModel.instance:getCardInfo():getThemeId()

	for index, itemMO in ipairs(list) do
		local mo = PlayerCardSkinMo.New()

		mo:init(itemMO)
		table.insert(moList, mo)

		if selectId == mo.id then
			PlayerCardModel.instance:setSelectSkinMO(mo)
		end
	end

	local emptymo = PlayerCardSkinMo.New()

	emptymo:setEmpty()
	table.insert(moList, emptymo)
	table.sort(moList, PlayerCardThemeListModel.sort)

	if #moList == 1 or selectId == 0 then
		PlayerCardModel.instance:setSelectSkinMO(emptymo)
	end

	self:setList(moList)
end

function PlayerCardThemeListModel.sort(x, y)
	local xvalue = x:checkIsUse() and 4 or x:isUnLock() and 3 or x:isEmpty() and 2 or 1
	local yvalue = y:checkIsUse() and 4 or y:isUnLock() and 3 or y:isEmpty() and 2 or 1

	if xvalue ~= yvalue then
		return yvalue < xvalue
	else
		return x.id < y.id
	end
end

function PlayerCardThemeListModel:getMoById(skinId)
	local list = self:getList()

	for index, mo in ipairs(list) do
		if skinId == mo.id then
			return mo
		end
	end
end

function PlayerCardThemeListModel:getSelectIndex()
	return self._selectIndex or 1
end

PlayerCardThemeListModel.instance = PlayerCardThemeListModel.New()

return PlayerCardThemeListModel
