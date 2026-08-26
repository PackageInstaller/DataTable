-- chunkname: @modules/logic/sodache/view/inside/comp/SodacheCardDetailSettlePart.lua

module("modules.logic.sodache.view.inside.comp.SodacheCardDetailSettlePart", package.seeall)

local SodacheCardDetailSettlePart = class("SodacheCardDetailSettlePart", SodacheCardDetailUseItemPart)

function SodacheCardDetailSettlePart:onInitView()
	self._inputCount = gohelper.findChildTextMeshInputField(self.viewGO, "Right/#go_Bottom/#go_Count/valuebg/#input_Count")
	self._btnMin = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_Bottom/#go_Count/#btn_Min")
	self._btnSub = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_Bottom/#go_Count/#btn_Sub")
	self._btnAdd = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_Bottom/#go_Count/#btn_Add")
	self._btnMax = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_Bottom/#go_Count/#btn_Max")
	self._txttitle = gohelper.findChildTextMesh(self.viewGO, "Right/#go_Bottom/cost/titletxt")
	self._txtnum = gohelper.findChildTextMesh(self.viewGO, "Right/#go_Bottom/cost/#txt_num")

	SodacheCardDetailSettlePart.super.onInitView(self)
end

function SodacheCardDetailSettlePart:addEvents()
	self._btnMin:AddClickListener(self._btnMinOnClick, self)
	self._btnSub:AddClickListener(self._btnSubOnClick, self)
	self._btnAdd:AddClickListener(self._btnAddOnClick, self)
	self._btnMax:AddClickListener(self._btnMaxOnClick, self)
	self._inputCount:AddOnEndEdit(self._onInputChange, self)
	SodacheCardDetailSettlePart.super.addEvents(self)
end

function SodacheCardDetailSettlePart:removeEvents()
	self._btnMin:RemoveClickListener()
	self._btnSub:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
	self._btnMax:RemoveClickListener()
	self._inputCount:RemoveOnEndEdit()
	SodacheCardDetailSettlePart.super.removeEvents(self)
end

function SodacheCardDetailSettlePart:onOpen()
	self.selectMo = self.viewParam.selectMo
	self.cardMo = self.viewParam.cardMo
	self.nowNum = 1

	gohelper.setActive(self._gobottom, true)
	gohelper.setActive(self._gocount, true)
	gohelper.setActive(self._gocost, true)

	self._txttitle.text = self.selectMo.isUseCost and luaLang("sodache_takeview_costcount") or luaLang("sodache_takeview_cardcount")
	self._txtdesc.text = self.viewParam.isAdd and luaLang("sodache_carddetailview_btnadd") or luaLang("sodache_carddetailview_btnsub")

	self:refreshCountText()
end

function SodacheCardDetailSettlePart:_onClickBtn()
	if self.viewParam.isAdd then
		self.selectMo:addSelectItem(self.cardMo.serverMo.configId, self.nowNum)
	else
		self.selectMo:addUnselectItem(self.cardMo.serverMo.configId, self.nowNum)
	end

	SodacheController.instance:dispatchEvent(SodacheEvent.OnClickGoodsItem)
	self:closeThis()
end

function SodacheCardDetailSettlePart:_btnMinOnClick()
	self:setCount(1)
end

function SodacheCardDetailSettlePart:_btnSubOnClick()
	self:setCount(self.nowNum - 1)
end

function SodacheCardDetailSettlePart:_btnAddOnClick()
	self:setCount(self.nowNum + 1)
end

function SodacheCardDetailSettlePart:_btnMaxOnClick()
	self:setCount(self:getMaxCount())
end

function SodacheCardDetailSettlePart:getMaxCount()
	if self.viewParam.isAdd then
		return self.selectMo:getItemSelectMaxCount(self.cardMo.serverMo.configId)
	else
		return self.cardMo.serverMo.count
	end
end

function SodacheCardDetailSettlePart:setCount(count)
	local newCount = Mathf.Clamp(count, 1, self:getMaxCount())

	if newCount == self.nowNum then
		return
	end

	self.nowNum = newCount

	self._inputCount:SetText(tostring(newCount))
	self:refreshCountText()
end

function SodacheCardDetailSettlePart:_onInputChange()
	local count = tonumber(self._inputCount:GetText()) or 1

	self:setCount(count)
end

function SodacheCardDetailSettlePart:refreshCountText()
	if self.selectMo.isUseCost then
		if not self.selectMo.selectCost then
			local cur = self.selectMo.selectCount

			if self.selectMo.isUseCost then
				if not self.selectMo.selectTotalCost then
					local total = self.selectMo.selectTotalCount
					local add = self.nowNum

					if self.selectMo.isUseCost then
						add = add * self.cardMo.serverMo.itemCo.cost
					end

					if not self.viewParam.isAdd then
						add = -add
					end

					self._txtnum.text = string.format("%d/%d", cur + add, total)
				end
			end
		end
	end
end

return SodacheCardDetailSettlePart
