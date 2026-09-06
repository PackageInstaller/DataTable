-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itemget/controller/ItemGetController.lua

module("logic.extensions.itemget.controller.ItemGetController", package.seeall)

local ItemGetController = class("ItemGetController", BaseController)

ItemGetController.TITLE_PRIZE = 0
ItemGetController.TITLE_BUY_SUC = 1
ItemGetController.TITLE_EXCHANGE_SUC = 2
ItemGetController.TITLE_XIAOSHI = 3
ItemGetController.TITLE_RETURNMAT = 4
ItemGetController.TITLE_REVERT = 5
ItemGetController.TITLE_DOUBLE = 6
ItemGetController.TITLE_SURPRISE = 7

function ItemGetController:ctor()
	self._isItemFlyShow = false
	self._isItemSetShowing = false
	self._isItemEffectFly = false
	self._itemGetFlys = {}
end

function ItemGetController:onInit()
	print("ItemGetController onInit")

	self._itemgetSets = Array.New()
	self._ItemEffectFlys = Array.New()
	self._itemGetFlys = {}
	self._mixItems = {}
end

function ItemGetController:onReset()
	if self._itemGetFlys then
		self._itemGetFlys = {}
	end

	if self._itemgetSets then
		self._itemgetSets:Clear()
	end

	if self._ItemEffectFlys:Clear() then
		self._ItemEffectFlys:Clear()
	end
end

function ItemGetController:getTitleType(ci)
	self.titleTypeList = self.titleTypeList or {}

	return checknumber(self.titleTypeList[ci])
end

function ItemGetController:setTitleType(ci, type)
	if checknumber(ci) > 0 then
		self.titleTypeList = self.titleTypeList or {}
		self.titleTypeList[ci] = type
	end
end

function ItemGetController:showItemFlys(mo)
	local obj

	if mo then
		local gMo = MaterialMgr.getModel(mo.materialType, mo.id)
		local name = MaterialMgr.getMaterialsName(mo.materialType, gMo:getDefineId())
		local mcfg = MaterialMgr.getMatCfg(mo.materialType, gMo:getDefineId())
		local color = MaterialMgr.getGoodsColor(mo.materialType, gMo:getDefineId())

		obj = {
			mo = mo,
			mcfg = mcfg,
			name = name,
			color = color
		}
	end

	table.insert(self._itemGetFlys, obj)
	GlobalDispatcher:dispatch(GlobalNotify.ShowItemFly)
end

function ItemGetController:popUpItemFly()
	if not self._itemGetFlys then
		return
	end

	local data = self._itemGetFlys[1]

	if data then
		table.remove(self._itemGetFlys, 1)
	end

	return data
end

function ItemGetController:addShowItem(item)
	self._itemgetSets:PushBack(item)
end

function ItemGetController:tryShowNextItem()
	if not self._itemgetSets:IsEmpty() then
		self:showNextItem()
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMaterialPopEnd, MatType.Item)
	end
end

function ItemGetController:getItemSets()
	return self._itemgetSets
end

function ItemGetController:showNextItem()
	if SceneMgr.instance.isGogingToEnterBattleScene then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.ItemGet) then
		return
	end

	if not self._itemgetSets:IsEmpty() then
		local popData = self._itemgetSets:PopFront()

		UIStateManager.instance:open(ViewName.ItemGet, popData)
	end
end

function ItemGetController:closeItemFly()
	self._isItemFlyShow = false

	self:showItemFlys()
end

function ItemGetController:onOpenFly(obj)
	GlobalDispatcher:dispatch(GlobalNotify.AddItemFlyData, obj)
end

function ItemGetController:onAddHightItemShow(id)
	self._ItemEffectFlys:PushBack(id)
end

function ItemGetController:onStartShowHightShow()
	return
end

function ItemGetController:addMixItems(item)
	if #self._mixItems < 1 then
		table.insert(self._mixItems, item)
	end
end

function ItemGetController:tryShowNexMixItems()
	if #self._mixItems > 0 then
		local item = table.remove(self._mixItems, 1)

		ItemBagController.instance:openUsePanel(item)
	end
end

ItemGetController.instance = ItemGetController.New()

return ItemGetController
