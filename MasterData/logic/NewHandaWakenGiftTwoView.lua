-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewHandaWakenGiftTwoView.lua

module("logic.extensions.newhandwelfare.view.NewHandaWakenGiftTwoView", package.seeall)

local NewHandaWakenGiftTwoView = class("NewHandaWakenGiftTwoView", ViewComponent)
local PetCfg = {
	{
		skinId = 10027,
		funcId = 108,
		jumpTo = "ui#bonus#excellentclass"
	},
	{
		skinId = 10324,
		funcId = 186,
		jumpTo = "ui#bonus#dragonfullawake"
	}
}

function NewHandaWakenGiftTwoView:buildUI()
	NewHandaWakenGiftTwoView.super.buildUI(self)

	self._leftPetInfo = self:getGo("leftPetInfo")
	self._rightPetInfo = self:getGo("rightPetInfo")
	self._petCells = {}

	for _, go in ipairs({
		self._leftPetInfo,
		self._rightPetInfo
	}) do
		local cell = {}

		cell._btnGo = goutil.findChild(go, "btnGo")
		cell._pointRare = goutil.findChild(go, "pointRare")
		cell._btnSkill = goutil.findChild(go, "btnSkill")
		cell._btnIntroduce = goutil.findChild(go, "btnIntroduce")
		cell._txtPetNameInInfo = goutil.findChildTextComponent(go, "txtName")

		table.insert(self._petCells, cell)
	end
end

function NewHandaWakenGiftTwoView:bindEvents()
	NewHandaWakenGiftTwoView.super.bindEvents(self)

	for index, cell in ipairs(self._petCells) do
		GameUtil.addClickHandler(cell._btnSkill, GameUtil.handler(self._onClickBtnSkill, self, index))
		GameUtil.addClickHandler(cell._btnIntroduce, GameUtil.handler(self._onClickBtnIntroduce, self, index))
		GameUtil.addClickHandler(cell._btnGo, GameUtil.handler(self._onClickBtnGo, self, index))
	end
end

function NewHandaWakenGiftTwoView:unbindEvents()
	NewHandaWakenGiftTwoView.super.unbindEvents(self)

	for _, cell in ipairs(self._petCells) do
		GameUtil.rmClickHandler(cell._btnSkill)
		GameUtil.rmClickHandler(cell._btnIntroduce)
		GameUtil.rmClickHandler(cell._btnGo)
	end
end

function NewHandaWakenGiftTwoView:onEnter()
	NewHandaWakenGiftTwoView.super.onEnter(self)

	for index, cell in ipairs(self._petCells) do
		local skinId = self:_getSkinId(index)

		if skinId > 0 then
			MaterialMgr.setCell(MatType.Rare, skinId, cell._pointRare)
		end
	end
end

function NewHandaWakenGiftTwoView:onExit()
	NewHandaWakenGiftTwoView.super.onExit(self)

	for _, cell in ipairs(self._petCells) do
		MaterialMgr.resetAll(cell._pointRare)
	end
end

function NewHandaWakenGiftTwoView:_onClickBtnSkill(index)
	local raceId = self:_getRaceId(index)
	local skinId = self:_getSkinId(index)

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function NewHandaWakenGiftTwoView:_onClickBtnIntroduce(index)
	PetbookController.instance:openPetinfoView(self:_getRaceId(index))
end

function NewHandaWakenGiftTwoView:_onClickBtnGo(index)
	local funcId = self:_getFuncId(index)

	if funcId > 0 and not FuncOpenModel.instance:getFuncIsOpen(funcId) then
		FloatWordMgr.instance:show(FuncOpenModel.instance:getFuncLockDescription(funcId))

		return
	end

	local jumpTo = self:_getJumpTo(index)

	if not string.nilorempty(jumpTo) then
		GotoMgr.gotoByString(jumpTo)

		if not ViewSetting.instance:isFullScreen(self._viewPresentor.viewName) then
			self:close()
		end
	end
end

function NewHandaWakenGiftTwoView:_getRaceId(index)
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId(index))
end

function NewHandaWakenGiftTwoView:_getSkinId(index)
	return PetCfg[index] and PetCfg[index].skinId
end

function NewHandaWakenGiftTwoView:_getFuncId(index)
	return PetCfg[index] and PetCfg[index].funcId
end

function NewHandaWakenGiftTwoView:_getJumpTo(index)
	return PetCfg[index] and PetCfg[index].jumpTo
end

return NewHandaWakenGiftTwoView
