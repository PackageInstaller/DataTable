-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerProtagonistHaloView.lua

module("logic.extensions.summontower.view.SummontowerProtagonistHaloView", package.seeall)

local SummontowerProtagonistHaloView = class("SummontowerProtagonistHaloView", ViewComponent)

function SummontowerProtagonistHaloView:buildUI()
	SummontowerProtagonistHaloView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._haloNodes = {}

	for i = 1, 2 do
		local node = self:getGo("halo_" .. i)

		self._haloNodes[i] = {}
		self._haloNodes[i].go = node
		self._haloNodes[i].itemNode = goutil.findChild(node, "item")
		self._haloNodes[i].itemIcon = goutil.findChild(node, "item/icon")
		self._haloNodes[i].itemNum = goutil.findChildTextComponent(node, "item/TxtNum")
		self._haloNodes[i].txtName = goutil.findChildTextComponent(node, "txtName")
		self._haloNodes[i].txtDesc = goutil.findChildTextComponent(node, "txtDesc")
		self._haloNodes[i].txtTip = goutil.findChildTextComponent(node, "txtTip")
	end
end

function SummontowerProtagonistHaloView:bindEvents()
	SummontowerProtagonistHaloView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function SummontowerProtagonistHaloView:unbindEvents()
	SummontowerProtagonistHaloView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function SummontowerProtagonistHaloView:onEnter()
	SummontowerProtagonistHaloView.super.onEnter(self)
	self:_refreshView()
end

function SummontowerProtagonistHaloView:_refreshView()
	self:_refreshZhishouhuajiao(self._haloNodes[1])
	self:_refreshYanshuodashi(self._haloNodes[2])
end

function SummontowerProtagonistHaloView:_refreshZhishouhuajiao(node)
	local attrUnit = 3
	local attrBigUnit = 20
	local numItem = SummonTowerItemsModel.instance:getItemsNum(SummonTowerItemsModel.ItemType.GamePlan)
	local value = self:_allAttrUpValue(numItem, attrUnit, attrBigUnit)

	node.txtName.text = lang("txt_summontower_protagonisthalo_zhishouhuajiao")
	node.txtDesc.text = string.format(lang(lang("txt_summontower_eff_zhanshudaquan_all")), value)
	node.txtTip.text = string.format(lang(lang("txt_summontower_eff_zhanshudaquan")), attrUnit, attrBigUnit)
	node.itemNum.text = tostring(numItem)

	local itemCo = SummontowerConfig.instance:getGameItemCo(SummonTowerItemsModel.ItemType.GamePlan)

	MaterialMgr.setIcon(node.itemIcon, MatType.Item_Fake, itemCo.itemId)
end

function SummontowerProtagonistHaloView:_allAttrUpValue(numItem, attrUnit, attrBigUnit)
	local num = 5
	local bigUnitCount = math.floor(numItem / num)
	local unitCount = numItem - bigUnitCount * num

	return unitCount * attrUnit + bigUnitCount * attrBigUnit
end

function SummontowerProtagonistHaloView:_refreshYanshuodashi(node)
	local guardNode = SummontowerMapModel.instance:getOneGuardNode()
	local baseRate, rateStep = 20, 2

	if guardNode then
		local evtCo = SummontowerConfig.instance:getGuardEventCo(guardNode.gridEventId)

		if evtCo then
			baseRate = evtCo.gainPetBasePercent
			rateStep = evtCo.bookProvidePercent
		end
	end

	local numItem = SummonTowerItemsModel.instance:getItemsNum(SummonTowerItemsModel.ItemType.SpeechBook)

	node.txtName.text = lang("txt_summontower_protagonisthalo_yanshuodashi")
	node.txtDesc.text = string.format(lang(lang("txt_summontower_eff_yanjiangzhishu_all")), baseRate + numItem * rateStep)
	node.txtTip.text = string.format(lang(lang("txt_summontower_eff_yanjiangzhishu")), rateStep)
	node.itemNum.text = tostring(numItem)

	local itemCo = SummontowerConfig.instance:getGameItemCo(SummonTowerItemsModel.ItemType.SpeechBook)

	MaterialMgr.setIcon(node.itemIcon, MatType.Item_Fake, itemCo.itemId)
end

function SummontowerProtagonistHaloView:onExit()
	SummontowerProtagonistHaloView.super.onExit(self)

	for i = 1, #self._haloNodes do
		MaterialMgr.clearIcon(self._haloNodes[i].itemIcon)
	end
end

function SummontowerProtagonistHaloView:_onClickClose()
	self:close()
end

return SummontowerProtagonistHaloView
