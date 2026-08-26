-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/factory/VersionActivity1_8FactoryCompositeView.lua

module("modules.logic.versionactivity1_8.dungeon.view.factory.VersionActivity1_8FactoryCompositeView", package.seeall)

local VersionActivity1_8FactoryCompositeView = class("VersionActivity1_8FactoryCompositeView", BaseView)
local MIN_COMPOSITE_COUNT = 1

function VersionActivity1_8FactoryCompositeView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	local leftlayout = gohelper.findChild(self.viewGO, "left/layout")

	self._translayout1 = leftlayout.gameObject
	self._txtitemname1 = gohelper.findChildText(self.viewGO, "left/layout/#txt_leftproductname")
	self._txtitemnum1 = gohelper.findChildText(self.viewGO, "left/layout/#txt_leftproductnum")
	self._simageitemicon1 = gohelper.findChildSingleImage(self.viewGO, "left/leftproduct_icon")

	local rightlayout = gohelper.findChild(self.viewGO, "right/layout")

	self._translayout2 = rightlayout.gameObject
	self._txtitemname2 = gohelper.findChildText(self.viewGO, "right/layout/#txt_rightproductname")
	self._txtitemnum2 = gohelper.findChildText(self.viewGO, "right/layout/#txt_rightproductnum")
	self._simageitemicon2 = gohelper.findChildSingleImage(self.viewGO, "right/rightproduct_icon")
	self._inputvalue = gohelper.findChildTextMeshInputField(self.viewGO, "#go_composite/valuebg/#input_value")
	self._btnmin = gohelper.findChildButtonWithAudio(self.viewGO, "#go_composite/#btn_min")
	self._btnsub = gohelper.findChildButtonWithAudio(self.viewGO, "#go_composite/#btn_sub")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_composite/#btn_add")
	self._btnmax = gohelper.findChildButtonWithAudio(self.viewGO, "#go_composite/#btn_max")
	self._btncomposite = gohelper.findChildButtonWithAudio(self.viewGO, "#go_composite/#btn_composite")
	self._simagecosticon1 = gohelper.findChildImage(self.viewGO, "#go_composite/cost/#simage_costicon")
	self._txtoriginalCost = gohelper.findChildText(self.viewGO, "#go_composite/cost/#txt_originalCost")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_8FactoryCompositeView:addEvents()
	self._btnclose:AddClickListener(self._btncloseClick, self)
	self._btnmin:AddClickListener(self._btnminOnClick, self)
	self._btnsub:AddClickListener(self._btnsubOnClick, self)
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
	self._btnmax:AddClickListener(self._btnmaxOnClick, self)
	self._btncomposite:AddClickListener(self._btncompositeOnClick, self)
	self._inputvalue:AddOnValueChanged(self.onCompositeCountValueChange, self)
end

function VersionActivity1_8FactoryCompositeView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnmin:RemoveClickListener()
	self._btnsub:RemoveClickListener()
	self._btnadd:RemoveClickListener()
	self._btnmax:RemoveClickListener()
	self._btncomposite:RemoveClickListener()
	self._inputvalue:RemoveOnValueChanged()
end

function VersionActivity1_8FactoryCompositeView:_btncloseClick()
	self:closeThis()
end

function VersionActivity1_8FactoryCompositeView:_btnminOnClick()
	self:changeCompositeCount(MIN_COMPOSITE_COUNT)
end

function VersionActivity1_8FactoryCompositeView:_btnsubOnClick()
	self:changeCompositeCount(self.compositeCount - 1)
end

function VersionActivity1_8FactoryCompositeView:_btnaddOnClick()
	self:changeCompositeCount(self.compositeCount + 1)
end

function VersionActivity1_8FactoryCompositeView:_btnmaxOnClick()
	local maxCompositeCount = self:getMaxCompositeCount()

	self:changeCompositeCount(maxCompositeCount)
end

function VersionActivity1_8FactoryCompositeView:_btncompositeOnClick()
	local costCount = self.compositeCount * self.costPerComposite

	Activity157Controller.instance:factoryComposite(self.compositeCount, costCount, self.closeThis, self)
end

function VersionActivity1_8FactoryCompositeView:onCompositeCountValueChange(value)
	local count = tonumber(value)

	if not count then
		return
	end

	self:changeCompositeCount(count, true)
end

function VersionActivity1_8FactoryCompositeView:_editableInitView()
	self.actId = Activity157Model.instance:getActId()

	local itemList = Activity157Config.instance:getAct157CompositeFormula(self.actId)
	local isFirst = true

	for i, item in ipairs(itemList) do
		if isFirst then
			self.costItemType = item.materilType
			self.costItemId = item.materilId
			self.costPerComposite = item.quantity or 0
			isFirst = false
		else
			self.targetPerComposite = item.quantity or 0
		end

		local config, icon = ItemModel.instance:getItemConfigAndIcon(item.materilType, item.materilId)
		local nameComp = "_txtitemname" .. i

		if self[nameComp] then
			self[nameComp].text = config.name
		end

		local iconComp = "_simageitemicon" .. i

		if self[iconComp] then
			self[iconComp]:LoadImage(icon)
		end

		local costComp = "_simagecosticon" .. i

		if self[costComp] then
			UISpriteSetMgr.instance:setCurrencyItemSprite(self[costComp], config.icon .. "_1")
		end
	end
end

function VersionActivity1_8FactoryCompositeView:onUpdateParam()
	return
end

function VersionActivity1_8FactoryCompositeView:onOpen()
	local defaultCount = MIN_COMPOSITE_COUNT
	local beRepairedComponentId = Activity157Model.instance:getLastWillBeRepairedComponent()

	if beRepairedComponentId then
		local type, id, needQuantity = Activity157Config.instance:getComponentUnlockCondition(self.actId, beRepairedComponentId)
		local itemQuantity = ItemModel.instance:getItemQuantity(type, id)
		local diff = needQuantity - itemQuantity

		if diff > 0 then
			local maxCompositeCount = self:getMaxCompositeCount()

			defaultCount = maxCompositeCount < diff and maxCompositeCount or diff
		end
	end

	self:changeCompositeCount(defaultCount)
end

function VersionActivity1_8FactoryCompositeView:getMaxCompositeCount()
	local itemQuantity = ItemModel.instance:getItemQuantity(self.costItemType, self.costItemId)

	return (itemQuantity or nil) and math.floor(itemQuantity / self.costPerComposite)
end

function VersionActivity1_8FactoryCompositeView:changeCompositeCount(count, isIgnoreNotify)
	local maxCompositeCount = self:getMaxCompositeCount()

	if maxCompositeCount < count then
		count = maxCompositeCount
	end

	if count < MIN_COMPOSITE_COUNT then
		count = MIN_COMPOSITE_COUNT
	end

	self.compositeCount = count

	if isIgnoreNotify then
		self._inputvalue:SetTextWithoutNotify(tostring(count))
	else
		self._inputvalue:SetText(count)
	end

	self:refreshUI()
end

function VersionActivity1_8FactoryCompositeView:refreshUI()
	local costCount = self.compositeCount * self.costPerComposite
	local targetPerComposite = self.compositeCount * self.targetPerComposite

	self._txtitemnum1.text = luaLang("multiple") .. costCount
	self._txtitemnum2.text = luaLang("multiple") .. targetPerComposite

	ZProj.UGUIHelper.RebuildLayout(self._translayout1.transform)
	ZProj.UGUIHelper.RebuildLayout(self._translayout2.transform)

	local itemQuantity = ItemModel.instance:getItemQuantity(self.costItemType, self.costItemId)

	self:showOriginalCostTxt(costCount, itemQuantity)
end

function VersionActivity1_8FactoryCompositeView:showOriginalCostTxt(costCount, maxCount)
	self._txtoriginalCost.text = string.format("<color=#E07E25>%s</color>/%s", costCount, maxCount)
end

function VersionActivity1_8FactoryCompositeView:onClose()
	return
end

function VersionActivity1_8FactoryCompositeView:onDestroyView()
	self._simageitemicon1:UnLoadImage()
	self._simageitemicon2:UnLoadImage()
end

return VersionActivity1_8FactoryCompositeView
