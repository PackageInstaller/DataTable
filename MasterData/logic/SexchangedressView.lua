-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dress/view/SexchangedressView.lua

module("logic.extensions.dress.view.SexchangedressView", package.seeall)

local SexchangedressView = class("SexchangedressView", ViewComponent)

function SexchangedressView:ctor()
	SexchangedressView.super.ctor(self)
end

function SexchangedressView:buildUI()
	SexchangedressView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._goCell = self:getGo("cell")
	self._goTableview = self:getGo("tableview")
	self._tableView = ScrollerList.create(self._goTableview, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function SexchangedressView:bindEvents()
	SexchangedressView.super.bindEvents(self)
	self._btnSure:AddClickListener(self.close, self)
end

function SexchangedressView:unbindEvents()
	SexchangedressView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function SexchangedressView:destroyUI()
	SexchangedressView.super.destroyUI(self)
end

function SexchangedressView:onEnter()
	SexchangedressView.super.onEnter(self)

	if DressModel.instance:getIsInitData() then
		self:_updateView()
	else
		DressController.instance:sendGetNotoutInfoReq(self._updateView, self)
	end
end

function SexchangedressView:onEnterFinished()
	SexchangedressView.super.onEnterFinished(self)
end

function SexchangedressView:onExit()
	SexchangedressView.super.onExit(self)
	RoleAgent.instance:sendExitGameReq()
end

function SexchangedressView:onExitFinished()
	SexchangedressView.super.onExitFinished(self)
end

function SexchangedressView:_updateView()
	local dataList = DressModel.instance:getCurChangeDresses()
	local showDataList = {}

	for k, v in ipairs(dataList) do
		table.insert(showDataList, v)
	end

	self._tableView:reloadData(showDataList)
end

function SexchangedressView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.item = goutil.findChild(cell.go, "item")
	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.txtTime = goutil.findChildTextComponent(cell.go, "txtTime")

	uGuiUtil.clearImage(cell.item)

	return cell
end

function SexchangedressView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	uGuiUtil.setSpriteToImage(cell.item, uGuiUtil.SpriteType.BigBg, GameUrl.getDressIconUrl(data.dressCfg.icon))

	cell.txtName.text = lang(data.dressCfg.name)
	cell.txtTime.text = data.isOwn and "永久" or data.dayActive .. lang("天")
end

return SexchangedressView
