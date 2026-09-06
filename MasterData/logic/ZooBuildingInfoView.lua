-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooBuildingInfoView.lua

module("logic.extensions.zoo.view.ZooBuildingInfoView", package.seeall)

local ZooBuildingInfoView = class("ZooBuildingInfoView", ViewComponent)

function ZooBuildingInfoView:buildUI()
	ZooBuildingInfoView.super.buildUI(self)

	self._closeBtn = self:getBtn("btnClose")
	self._buildingName = self:getTxt("buildingName")
	self._buildingDesc = self:getTxt("buildingDesc")
	self._tableview = self:getGo("lvNode/view"):GetComponent(typeof(UITableview))
	self._tableItem = self:getGo("lvNode/item")
	self._buildingIcon = self:getGo("icon")

	self._tableItem:SetActive(false)

	local lvTxt = self:getTxt("lvNode/level")
	local effectTxt = self:getTxt("lvNode/effect")

	lvTxt.text = lang("tip_level")
	effectTxt.text = lang("text_effect")
end

function ZooBuildingInfoView:bindEvents()
	ZooBuildingInfoView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self._onClickClose, self)
	self._tableview:RegisterCallback(self._numItemsInView, self._itemCellSizeForIndex, self._itemCellAtIndex, self)
end

function ZooBuildingInfoView:unbindEvents()
	ZooBuildingInfoView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tableview:UnRegisterAllCallbacks()
end

function ZooBuildingInfoView:onEnter()
	ZooBuildingInfoView.super.onEnter(self)

	self._buildingMo = self:getFirstParam()
	self._buildingName.text = self._buildingMo:getBuildingName()
	self._buildingDesc.text = self._buildingMo:getBuildingInfo()
	self._lvInstructions = self._buildingMo:getBuildingLvInstructions()

	self._tableview:SetOffsetWithoutRefresh(0)
	self._tableview:ReloadData()
	uGuiUtil.setSpriteToImage(self._buildingIcon, uGuiUtil.LoaderType_BigBg, self._buildingMo:getBuildingIcon())
end

function ZooBuildingInfoView:onExit()
	uGuiUtil.clearImage(self._buildingIcon)
	ZooBuildingInfoView.super.onExit(self)
end

function ZooBuildingInfoView:_numItemsInView()
	if not self._lvInstructions then
		return 0
	end

	return #self._lvInstructions
end

function ZooBuildingInfoView:_itemCellSizeForIndex()
	return 800, 40
end

function ZooBuildingInfoView:_itemCellAtIndex(view, idx)
	local cell = self._tableview:DequeueCell()

	cell = cell or self._tableview:AddChild(self._tableItem)

	local instruction = self._lvInstructions[idx + 1]
	local textLv = goutil.findChildTextComponent(cell.gameObject, "lv")
	local textEff = goutil.findChildTextComponent(cell.gameObject, "eff")

	textLv.text = tostring(instruction.level)
	textEff.text = tostring(instruction.instruction)

	return cell
end

function ZooBuildingInfoView:_onClickClose()
	self:close()
end

return ZooBuildingInfoView
