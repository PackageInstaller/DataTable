-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineisaacclg/view/DivineisaacclgextView.lua

module("logic.extensions.divineisaacclg.view.DivineisaacclgextView", package.seeall)

local DivineisaacclgextView = class("DivineisaacclgextView", ViewComponent)

function DivineisaacclgextView:ctor()
	DivineisaacclgextView.super.ctor(self)
end

function DivineisaacclgextView:unbindEvents()
	DivineisaacclgextView.super.unbindEvents(self)
	self._btnFold:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function DivineisaacclgextView:bindEvents()
	DivineisaacclgextView.super.bindEvents(self)
	self._btnFold:AddClickListener(self._onClickbtnFold, self)
	self._btnCancel:AddClickListener(self._onClickbtnCancel, self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function DivineisaacclgextView:buildUI()
	DivineisaacclgextView.super.buildUI(self)

	self._tablecellGo = self:getGo("mask/root/tablecell")
	self._tableviewGo = self:getGo("mask/root/tableview")
	self._btnFold = self:getBtn("mask/root/btnFold")
	self._btnCancel = self:getBtn("mask/root/btnCancel")
	self._btnSure = self:getBtn("mask/root/btnSure")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._rootGo = self:getGo("mask/root")
	self._imgFoldGo = self:getGo("mask/root/btnFold/imgFold")
end

function DivineisaacclgextView:onExit()
	DivineisaacclgextView.super.onExit(self)
	self._scrollerList:dispose()
end

function DivineisaacclgextView:onEnter()
	DivineisaacclgextView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()
	self._isFold = false
	self._puppetCfgs = DivineisaacclgConfig.instance:getPuppetCfgs(self._fmtMo._activityId, self._fmtMo._phaseId)
	self._usePuppets_kv = DivineisaacclgModel.instance:getUsePuppets(self._fmtMo._activityId, self._fmtMo._phaseId)

	self:_modifyPuppetsNum()
	self:_updateUI()
end

function DivineisaacclgextView:_onClickbtnFold()
	self._isFold = not self._isFold

	self:_updateFoldState(self._isFold)
	self._scrollerList:refresh()
end

function DivineisaacclgextView:_onClickbtnCancel()
	self._usePuppets_kv = {}

	DivineisaacclgModel.instance:setUsePuppets(self._fmtMo._activityId, self._fmtMo._phaseId, self._usePuppets_kv)

	local list = table.values(self._usePuppets_kv)

	self._fmtMo:setUsePupPets(list)
	self._scrollerList:refresh()
end

function DivineisaacclgextView:_onClickbtnSure()
	local list = table.values(self._usePuppets_kv)

	self._fmtMo:setUsePupPets(list)
	self:_onClickbtnFold()
end

function DivineisaacclgextView:_updateUI()
	self:_updateFoldState(self._isFold)
	self._scrollerList:reloadData(self._puppetCfgs)
end

function DivineisaacclgextView:_updateCell(view, cell, data, tag)
	local btnAdd = Framework.ButtonAdapter.GetFrom(cell.gameObject, "batchroot/btnAdd")
	local btnMs = Framework.ButtonAdapter.GetFrom(cell.gameObject, "batchroot/btnMs")
	local goIcon = goutil.findChild(cell.gameObject, "icon")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtNum = goutil.findChildTextComponent(cell.gameObject, "txtNum")
	local txtUseNum = goutil.findChildTextComponent(cell.gameObject, "batchroot/txtUseNum")
	local puppetNum = DivineisaacclgModel.instance:getPuppetNum(self._fmtMo._activityId, data.puppetId)

	txtDesc.text = data.buffDesc
	txtNum.text = string.format("拥有 X%s", puppetNum)

	btnAdd:AddClickListener(function()
		self:_onSelectPuppet(data.puppetId, true)
	end)
	btnMs:AddClickListener(function()
		self:_onSelectPuppet(data.puppetId, false)
	end)

	local pData = self._usePuppets_kv[data.puppetId]

	if pData then
		txtUseNum.text = pData.num or 0
	end

	local puppetCfg = DivineisaacclgConfig.instance:getClientPuppetCfg(data.puppetId)

	uGuiUtil.setSpriteToImage(goIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(puppetCfg.iconName))
end

function DivineisaacclgextView:_onSelectPuppet(puppetId, isAdd)
	local data = self._usePuppets_kv[puppetId]

	if not data then
		data = {
			num = 0,
			puppetId = puppetId
		}
		self._usePuppets_kv[puppetId] = data
	end

	local addNum = isAdd and 1 or -1
	local maxNum = DivineisaacclgModel.instance:getPuppetNum(self._fmtMo._activityId, puppetId)

	if isAdd and maxNum < data.num + addNum then
		FloatWordMgr.instance:show("已超可选择最大数量")

		return
	end

	data.num = data.num + addNum
	data.num = Mathf.Clamp(data.num, 0, maxNum)

	DivineisaacclgModel.instance:setUsePuppets(self._fmtMo._activityId, self._fmtMo._phaseId, self._usePuppets_kv)

	local list = table.values(self._usePuppets_kv)

	self._fmtMo:setUsePupPets(list)
	self._scrollerList:refresh()
end

function DivineisaacclgextView:_clearCell(cell)
	local goIcon = goutil.findChild(cell.gameObject, "icon")

	uGuiUtil.clearImage(goIcon)
end

function DivineisaacclgextView:_updateFoldState(fold)
	local posx = fold and 579 or 0

	Framework.TransformUtil.SetAnchoredPos(self._rootGo.transform, posx, 0)
	Framework.TransformUtil.SetLocalScale(self._imgFoldGo.transform, fold and -1 or 1, 1, 1)
end

function DivineisaacclgextView:_modifyPuppetsNum()
	for k, v in pairs(self._usePuppets_kv) do
		local maxNum = DivineisaacclgModel.instance:getPuppetNum(self._fmtMo._activityId, v.puppetId)

		if maxNum < v.num then
			v.num = maxNum
		end
	end

	DivineisaacclgModel.instance:setUsePuppets(self._fmtMo._activityId, self._fmtMo._phaseId, self._usePuppets_kv)

	local list = table.values(self._usePuppets_kv)

	self._fmtMo:setUsePupPets(list)
end

return DivineisaacclgextView
