-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamireplaceView.lua

module("logic.extensions.hoshigami.view.HoshigamireplaceView", package.seeall)

local HoshigamireplaceView = class("HoshigamireplaceView", ViewComponent)

function HoshigamireplaceView:ctor()
	HoshigamireplaceView.super.ctor(self)
end

function HoshigamireplaceView:buildUI()
	HoshigamireplaceView.super.buildUI(self)

	self._sureBtn = self:getBtn("sureBtn")
	self._cancelBtn = self:getBtn("cancelBtn")
	self._itemConGo = self:getGo("itemCon")
	self._cellGo = self:getGo("itemCon/cell")
	self._itemGroup = ItemGroup.New(self._itemConGo, self._cellGo, nil, nil, true)
end

function HoshigamireplaceView:bindEvents()
	HoshigamireplaceView.super.bindEvents(self)
	self._sureBtn:AddClickListener(self._onClicksureBtn, self)
	self._cancelBtn:AddClickListener(self._onClickcancelBtn, self)
end

function HoshigamireplaceView:unbindEvents()
	HoshigamireplaceView.super.unbindEvents(self)
	self._sureBtn:RemoveClickListener()
	self._cancelBtn:RemoveClickListener()
end

function HoshigamireplaceView:destroyUI()
	HoshigamireplaceView.super.destroyUI(self)
end

function HoshigamireplaceView:onEnter()
	HoshigamireplaceView.super.onEnter(self)

	local params = self:getOpenParam()

	self._inUseIds = params[1]
	self._okCallBack = params[2]

	self:_updateView()
end

function HoshigamireplaceView:onEnterFinished()
	HoshigamireplaceView.super.onEnterFinished(self)
end

function HoshigamireplaceView:onExit()
	HoshigamireplaceView.super.onExit(self)
	self._itemGroup:dispose(function(item)
		local itemCon = goutil.findChild(item.mainGO, "item")
		local petCon = goutil.findChild(item.mainGO, "pet")

		MaterialMgr.resetAll(itemCon)
		MaterialMgr.resetAll(petCon)
	end)
end

function HoshigamireplaceView:onExitFinished()
	HoshigamireplaceView.super.onExitFinished(self)
end

function HoshigamireplaceView:_onClicksureBtn()
	self._okCallBack()
	self:close()
end

function HoshigamireplaceView:_onClickcancelBtn()
	self:close()
end

function HoshigamireplaceView:_updateView()
	self._itemGroup:updateWithMoArray(self._inUseIds, function(item, data)
		local itemCon = goutil.findChild(item.mainGO, "item")
		local petCon = goutil.findChild(item.mainGO, "pet")
		local itemMo = HoshigamiModel.instance:getHoshigamiMo(data.hoshigamiId)
		local petMo = BagPetsController.instance:getPet(data.petId)

		MaterialMgr.setCellByMo(itemMo, itemCon)
		MaterialMgr.setCellByMo(petMo, petCon)
	end)
end

return HoshigamireplaceView
