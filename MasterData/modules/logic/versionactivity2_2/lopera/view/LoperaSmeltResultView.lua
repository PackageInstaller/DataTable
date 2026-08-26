-- chunkname: @modules/logic/versionactivity2_2/lopera/view/LoperaSmeltResultView.lua

module("modules.logic.versionactivity2_2.lopera.view.LoperaSmeltResultView", package.seeall)

local LoperaSmeltResultView = class("LoperaSmeltResultView", BaseView)
local actId = VersionActivity2_2Enum.ActivityId.Lopera
local viewStage = {
	Done = 2,
	Smelting = 1
}
local smeltTime = 2

function LoperaSmeltResultView:onInitView()
	self._goStage1 = gohelper.findChild(self.viewGO, "#go_Stage1")
	self._goStage2 = gohelper.findChild(self.viewGO, "#go_Stage2")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Stage2/#btn_Close")
	self._goItem = gohelper.findChild(self.viewGO, "#go_Stage2/#scroll_List/Viewport/Content/#go_Item")
	self._goItemRoot = gohelper.findChild(self.viewGO, "#go_Stage2/#scroll_List/Viewport/Content")

	gohelper.setActive(self._goItem, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LoperaSmeltResultView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self.addEventCb(self, LoperaController.instance, LoperaEvent.GoodItemClick, self._onClickItem, self)
end

function LoperaSmeltResultView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function LoperaSmeltResultView:_editableInitView()
	return
end

function LoperaSmeltResultView:onOpen()
	self:changeViewStage(viewStage.Smelting)
	TaskDispatcher.runDelay(self.changeViewDoneStage, self, smeltTime)
end

function LoperaSmeltResultView:refreshStageView()
	gohelper.setActive(self._goStage1, self._curStage == viewStage.Smelting)
	gohelper.setActive(self._goStage2, self._curStage == viewStage.Done)

	if self._curStage == viewStage.Done then
		self:refreshProductItems()
	end
end

function LoperaSmeltResultView:changeViewDoneStage()
	self:changeViewStage(viewStage.Done)
end

function LoperaSmeltResultView:changeViewStage(stage)
	self._curStage = stage

	self:refreshStageView()
end

function LoperaSmeltResultView:refreshProductItems()
	local productList = {}
	local getItems = Activity168Model.instance:getItemChangeDict()

	if not getItems then
		return
	end

	for itemId, count in pairs(getItems) do
		if count > 0 then
			productList[#productList + 1] = {
				id = itemId,
				num = count
			}
		end
	end

	gohelper.CreateObjList(self, self._createItem, productList, self._goItemRoot, self._goItem, LoperaGoodsItem)
end

function LoperaSmeltResultView:_createItem(itemComp, itemCfg, index)
	local itemId = itemCfg.id
	local cfg = Activity168Config.instance:getGameItemCfg(actId, itemId)

	itemComp:onUpdateData(cfg, itemCfg.num, index)
end

function LoperaSmeltResultView:_onClickItem(index)
	gohelper.setActive(self._tipsGo, true)

	local goodItemGo = gohelper.findChild(self._goItemRoot, index)
	local tipsTrans = self._tipsGo.transform

	tipsTrans:SetParent(goodItemGo.transform, true)
	recthelper.setAnchorX(tipsTrans, 320)
	recthelper.setAnchorY(tipsTrans, -30)
	tipsTrans:SetParent(self.viewGO.transform, true)
	self:_refreshGoodItemTips(index)
end

function LoperaSmeltResultView:onDestroyView()
	return
end

return LoperaSmeltResultView
