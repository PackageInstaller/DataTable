-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoodetailsView.lua

module("logic.extensions.zoo.view.ZoodetailsView", package.seeall)

local ZoodetailsView = class("ZoodetailsView", ViewComponent)

function ZoodetailsView:buildUI()
	ZoodetailsView.super.buildUI(self)

	self._closeBtn = self:getBtn("close")
	self._icon = self:getGo("bg/icon")
	self._animal = self:getGo("bg/animal")
	self._name = goutil.findChildTextComponent(self.mainGO, "bg/name")
	self._geneCell = self:getGo("bg/item_gene")
	self._normalEmpty = self:getGo("bg/normal/empty")
	self._normalView = ScrollerList.create(self:getGo("bg/normal/sc"), self._geneCell, GameUtil.handler(self._updateCell, self))

	self._normalView:regGetCellSize(GameUtil.handler(function(view, index)
		return 100, 30
	end, self))

	self._specialEmpty = self:getGo("bg/special/empty")
	self._specialView = ScrollerList.create(self:getGo("bg/special/sc"), self._geneCell, GameUtil.handler(self._updateCell, self))

	self._specialView:regGetCellSize(GameUtil.handler(function(view, index)
		return 100, 30
	end, self))

	self._title = goutil.findChildTextComponent(self.mainGO, "bg/img/title")
	self._titleIcon = self:getGo("bg/img")
end

function ZoodetailsView:bindEvents()
	ZoodetailsView.super.bindEvents(self)
	self._closeBtn:AddClickListener(function()
		CommonTipsMgr.instance:closeAllTips()
		self:close()
	end, self)
end

function ZoodetailsView:unbindEvents()
	ZoodetailsView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function ZoodetailsView:onEnter()
	ZoodetailsView.super.onEnter(self)

	local openParam = self:getOpenParam()
	local mo = openParam[1]

	if openParam[2] == ZooController.ANIMALTYPE then
		goutil.setActive(self._icon, false)
		goutil.setActive(self._animal, true)

		self._title.text = string.format(lang("petzoo_petdetail_mathctimes"), mo.restMatchTimes)
		self._animalShow, self._avatar = mo:showAnimalAvatar(self._animal, 256, 256, 0.69, 0.55)
	elseif openParam[2] == ZooController.EGGTYPE then
		self._title.text = lang("petzoo_petdetail_eggstips")

		goutil.setActive(self._icon, true)
		goutil.setActive(self._animal, false)
		uGuiUtil.setSpriteToImage(self._icon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(mo.icon))
	end

	self._name.text = mo.name

	mo:refreshNormalGeneView(self._normalView)
	mo:refreshSpecialGeneView(self._specialView)
	goutil.setActive(self._normalEmpty, #mo.showGeneArray == 0)
end

function ZoodetailsView:onExit()
	ZoodetailsView.super.onExit(self)
	self._normalView:dispose()
	self._specialView:dispose()

	if self._animalShow then
		self._animalShow:clear()
		self._avatar:destroy()

		self._animalShow = nil
		self._avatar = nil
	end

	uGuiUtil.clearImage(self._icon)
end

function ZoodetailsView:_updateCell(view, cell, data)
	local component = ItemGene.AddOnce(cell.gameObject)

	component:setData(data)
end

return ZoodetailsView
