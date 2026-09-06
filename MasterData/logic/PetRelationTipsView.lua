-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petrelation/view/PetRelationTipsView.lua

module("logic.extensions.petrelation.view.PetRelationTipsView", package.seeall)

local PetRelationTipsView = class("PetRelationTipsView", ViewComponent)

function PetRelationTipsView:ctor()
	PetRelationTipsView.super.ctor(self)
end

function PetRelationTipsView:buildUI()
	PetRelationTipsView.super.buildUI(self)

	self._clickMask = goutil.findChild(self.mainGO, "clickMask")
	self._contView = goutil.findChild(self.mainGO, "contCol/contView")
	self._contCell = goutil.findChild(self.mainGO, "contCol/contCell")

	GameUtil.SetActive(self._contCell, false)
end

function PetRelationTipsView:bindEvents()
	PetRelationTipsView.super.bindEvents(self)
	GameUtil.addClickHandler(self._clickMask, self.close, self)
end

function PetRelationTipsView:unbindEvents()
	PetRelationTipsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._clickMask)
end

function PetRelationTipsView:destroyUI()
	PetRelationTipsView.super.destroyUI(self)
end

function PetRelationTipsView:onEnter()
	PetRelationTipsView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._contDataList = params[1]
	self._contCount = #self._contDataList

	for _, data in ipairs(self._contDataList) do
		data.txtCont = data.txtCont or ""
	end

	self:_onUpdateUI()
end

function PetRelationTipsView:onExit()
	PetRelationTipsView.super.onExit(self)
end

function PetRelationTipsView:_onUpdateUI()
	self:_onUpdateContCol()
end

function PetRelationTipsView:_onUpdateContCol()
	local childList = GameUtil.getChildren(self._contView)

	for idx, go in ipairs(childList) do
		if idx > self._contCount then
			GameUtil.SetActive(go, false)
		end
	end

	for idx = 1, self._contCount do
		if not childList[idx] then
			local cell = goutil.cloneAndSetParent(self._contCell, self._contView.transform)
			local data = self._contDataList[idx]

			self:_updateContCell(cell, data, idx)
			GameUtil.SetActive(cell, true)
		end
	end
end

function PetRelationTipsView:_updateContCell(cell, data, idx)
	local mainGo = cell.gameObject
	local txtCont = goutil.findChildTextComponent(mainGo, "txtCont")

	txtCont.text = data.txtCont
end

function PetRelationTipsView:_clearContCells()
	local childList = GameUtil.getChildren(self._petView)

	for idx, go in ipairs(childList) do
		-- block empty
	end
end

return PetRelationTipsView
