-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/view/WaterdarktowerpasstipView.lua

module("logic.extensions.waterdraktower.view.WaterdarktowerpasstipView", package.seeall)

local WaterdarktowerpasstipView = class("WaterdarktowerpasstipView", ViewComponent)

function WaterdarktowerpasstipView:ctor()
	WaterdarktowerpasstipView.super.ctor(self)
end

function WaterdarktowerpasstipView:buildUI()
	WaterdarktowerpasstipView.super.buildUI(self)

	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "txtDesc")
	self._itemGo = self:getGo("itemcon/item")
	self._itemconGo = self:getGo("itemcon")
	self._itemGroup = ItemGroup.New(self._itemconGo, self._itemGo, nil, nil, true)
	self._btnClose2 = self:getBtn("btnClose2")
	self._btnClose1 = self:getBtn("btnClose1")
end

function WaterdarktowerpasstipView:bindEvents()
	WaterdarktowerpasstipView.super.bindEvents(self)
	self._btnClose2:AddClickListener(self._onClickbtnClose2, self)
	self._btnClose1:AddClickListener(self._onClickbtnClose1, self)
end

function WaterdarktowerpasstipView:unbindEvents()
	WaterdarktowerpasstipView.super.unbindEvents(self)
	self._btnClose2:RemoveClickListener()
	self._btnClose1:RemoveClickListener()
end

function WaterdarktowerpasstipView:destroyUI()
	WaterdarktowerpasstipView.super.destroyUI(self)
end

function WaterdarktowerpasstipView:onEnter()
	WaterdarktowerpasstipView.super.onEnter(self)

	self._passRankData = WaterdraktowerController.instance:getPassRankData()

	WaterdraktowerController.instance:resetPassRankData()
	self:_updateUI()
end

function WaterdarktowerpasstipView:onEnterFinished()
	WaterdarktowerpasstipView.super.onEnterFinished(self)
end

function WaterdarktowerpasstipView:onExit()
	WaterdarktowerpasstipView.super.onExit(self)
	WaterdraktowerController.instance:resetPassRankData()
	self._itemGroup:dispose(function(item)
		MaterialMgr.resetAll(item.mainGO)
	end)
end

function WaterdarktowerpasstipView:onExitFinished()
	WaterdarktowerpasstipView.super.onExitFinished(self)
end

function WaterdarktowerpasstipView:_onClickbtnClose2()
	self:close()
end

function WaterdarktowerpasstipView:_onClickbtnClose1()
	self:close()
end

function WaterdarktowerpasstipView:_updateUI()
	if self._passRankData then
		self._txtDesc.text = string.format("你是第%s名通关本层的玩家，并获得冰灵王和湮灭圣龙的密切关注！请再接再厉！", self._passRankData.rank)

		local items = MaterialController.instance:getTempItemsByChangeSetId(self._passRankData.changeSetId)

		self._itemGroup:updateWithMoArray(items, function(item, mo)
			MaterialMgr.setCellByMo(mo, item.mainGO)
		end)
	end
end

return WaterdarktowerpasstipView
