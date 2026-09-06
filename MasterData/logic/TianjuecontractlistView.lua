-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/view/TianjuecontractlistView.lua

module("logic.extensions.contract.view.TianjuecontractlistView", package.seeall)

local TianjuecontractlistView = class("TianjuecontractlistView", ViewComponent)

function TianjuecontractlistView:unbindEvents()
	TianjuecontractlistView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function TianjuecontractlistView:bindEvents()
	TianjuecontractlistView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function TianjuecontractlistView:onExit()
	TianjuecontractlistView.super.onExit(self)
	self.scrollList:dispose()
end

function TianjuecontractlistView:buildUI()
	TianjuecontractlistView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self.tableview = self:getGo("tableview")
	self.cell = self:getGo("cell")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function TianjuecontractlistView:onEnter()
	TianjuecontractlistView.super.onEnter(self)

	local param = checknumber(self:getFirstParam())
	local petMo = MaterialMgr.getModel(MatType.Pet, param)

	self._raceId = petMo and petMo.raceId or param

	self:refreshUI()
end

function TianjuecontractlistView:_updateCell(view, cell, raceId, tag)
	local con = goutil.findChild(cell, "mask/con")
	local txtName = goutil.findChildTextComponent(cell, "txtName")

	self:setModelImg(raceId, con)

	txtName.text = MaterialMgr.getMaterialsName(MatType.Pet, raceId)

	GameUtil.asBtn(con):AddClickListener(function()
		MaterialMgr.openGetSource(MatType.Pet, raceId)
	end)
end

function TianjuecontractlistView:setModelImg(faceId, con)
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(faceId))

	if not modelCo then
		printError("t_model id not exist:" .. faceId)

		return
	end

	uGuiUtil.setSpriteToImage(con.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
end

function TianjuecontractlistView:clearCell(cell)
	local con = goutil.findChild(cell, "mask/con")

	uGuiUtil.clearImage(con)
	GameUtil.asBtn(goutil.findChild(cell, "mask/con")):RemoveClickListener()
end

function TianjuecontractlistView:_onClickClose()
	self:close()
end

function TianjuecontractlistView:refreshUI()
	local summonPetRaceId_kv = ContractConfig.instance:getHeavenAwakenSummonCfgs(self._raceId) or {}
	local summonPetRaceId = table.keys(summonPetRaceId_kv)

	if #summonPetRaceId <= 0 then
		printError("raceId契约列表为0，", self._raceId)
	end

	table.sort(summonPetRaceId, function(a, b)
		return a < b
	end)
	self.scrollList:reloadData(summonPetRaceId)
end

return TianjuecontractlistView
