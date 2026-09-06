-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayshopsortpetskinPart.lua

module("logic.extensions.payshop.view.PayshopsortpetskinPart", package.seeall)

local PayshopsortpetskinPart = class("PayshopsortpetskinPart", ViewComponent)

function PayshopsortpetskinPart:unbindEvents()
	PayshopsortpetskinPart.super.unbindEvents(self)
	self._btnOpenDown:RemoveClickListener()
	self._btnNotGet:RemoveClickListener()
end

function PayshopsortpetskinPart:bindEvents()
	PayshopsortpetskinPart.super.bindEvents(self)
	self._btnOpenDown:AddClickListener(self._onClickbtnOpenDown, self)
	self._btnNotGet:AddClickListener(self._onClickbtnNotGet, self)
end

function PayshopsortpetskinPart:buildUI()
	PayshopsortpetskinPart.super.buildUI(self)

	self._btnOpenDown = self:getBtn("norSortRoot/btnOpenDown")
	self._btnNotGet = self:getBtn("btnNotGet")
	self._btnOpenDownTr = self:getGo("norSortRoot/btnOpenDown").transform
	self._downitemGo = self:getGo("norSortRoot/downitem")
	self._downPanleGo = self:getGo("norSortRoot/downPanle")
	self._itemGroup = ItemGroup.New(self._downPanleGo, self._downitemGo, nil, nil, true)
	self._txtNotGet = self:getTxt("btnNotGet/txt")
	self._notGetSelectGo = self:getGo("btnNotGet/select")
	self._txtPanelDesc = self:getTxt("norSortRoot/txtDesc")
end

function PayshopsortpetskinPart:onExit()
	PayshopsortpetskinPart.super.onExit(self)
end

function PayshopsortpetskinPart:onEnter()
	PayshopsortpetskinPart.super.onEnter(self)

	self._jumpInTag = self:getFirstParam()
	self._selectId = PayShopModel.instance:getSkinSortId(self._jumpInTag)
	self._lastSelectId = GameEnum.PayshopSkinSortType.OnlineTime
	self._downPanelIsOpen = false

	local cfgs = PayShopConfig.instance:getSkinSortCfgs()

	self._panelCfgs = {}

	for i, v in ipairs(cfgs) do
		if v.id == GameEnum.PayshopSkinSortType.NotGet then
			self:_setNotGetDesc(v)
		else
			table.insert(self._panelCfgs, v)
		end
	end

	table.sort(self._panelCfgs, function(a, b)
		return a.rank < b.rank
	end)
	self:_selectSortId(self._selectId, true)
	self:_setDownPanelActive()
end

function PayshopsortpetskinPart:_onClickbtnOpenDown()
	self._downPanelIsOpen = not self._downPanelIsOpen

	self:_setDownPanelActive()
end

function PayshopsortpetskinPart:_onClickbtnNotGet()
	if self._selectId == GameEnum.PayshopSkinSortType.NotGet then
		self:_selectSortId(self._lastSelectId)
	else
		self:_selectSortId(GameEnum.PayshopSkinSortType.NotGet)
	end
end

function PayshopsortpetskinPart:_updateView()
	goutil.setActive(self._notGetSelectGo, self._selectId == GameEnum.PayshopSkinSortType.NotGet)
	self._itemGroup:updateWithMoArray(self._panelCfgs, function(item, cfg)
		local btn = Framework.ButtonAdapter.Get(item.mainGO)
		local goSelect = goutil.findChild(item.mainGO, "select")
		local txtDesc = goutil.findChildTextComponent(item.mainGO, "txtDesc")

		txtDesc.text = cfg.desc

		goutil.setActive(goSelect, self._selectId == cfg.id)
		btn:AddClickListener(function()
			self:_selectSortId(cfg.id)
		end)
	end)
end

function PayshopsortpetskinPart:_setNotGetDesc(cfg)
	self._txtNotGet.text = cfg.desc
end

function PayshopsortpetskinPart:_selectSortId(id, force)
	if self._selectId == id and not force then
		return
	end

	if self._selectId ~= id then
		self._lastSelectId = self._selectId
	end

	PayShopModel.instance:recordSkinSortId(self._jumpInTag, id)

	self._selectId = id

	if id ~= GameEnum.PayshopSkinSortType.NotGet then
		local cfg = PayShopConfig.instance:getSkinSortCfg(id)

		self._txtPanelDesc.text = cfg.desc
	end

	GlobalDispatcher:dispatch(GlobalNotify.PayShopSkinSortId, self._selectId)
	self:_updateView()
end

function PayshopsortpetskinPart:_setDownPanelActive()
	goutil.setActive(self._downPanleGo, self._downPanelIsOpen)
	Framework.TransformUtil.SetLocalScale(self._btnOpenDownTr, 1, self._downPanelIsOpen and -1 or 1, 1)
end

return PayshopsortpetskinPart
