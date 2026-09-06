-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powercrystal/view/PowerCrystalDownView.lua

module("logic.extensions.powercrystal.view.PowerCrystalDownView", package.seeall)

local PowerCrystalDownView = class("PowerCrystalDownView", ViewComponent)

function PowerCrystalDownView:ctor()
	PowerCrystalDownView.super.ctor(self)
end

function PowerCrystalDownView:destroyUI()
	PowerCrystalDownView.super.destroyUI(self)
end

function PowerCrystalDownView:onExitFinished()
	PowerCrystalDownView.super.onExitFinished(self)
end

function PowerCrystalDownView:onEnterFinished()
	PowerCrystalDownView.super.onEnterFinished(self)
end

function PowerCrystalDownView:unbindEvents()
	PowerCrystalDownView.super.unbindEvents(self)
	self._btnCancel:RemoveClickListener()
	self._btnOk:RemoveClickListener()
end

function PowerCrystalDownView:bindEvents()
	PowerCrystalDownView.super.bindEvents(self)
	self._btnCancel:AddClickListener(self._onCancelClick, self)
	self._btnOk:AddClickListener(self._onOkClick, self)
end

function PowerCrystalDownView:onExit()
	PowerCrystalDownView.super.onExit(self)
end

function PowerCrystalDownView:buildUI()
	PowerCrystalDownView.super.buildUI(self)

	self._btnCancel = self:getBtn("btnCancel")
	self._btnOk = self:getBtn("btnOk")
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "txtTips")
	self._txtCurrName = goutil.findChildTextComponent(self.mainGO, "upCon/left/txtName")
	self._txtNextName = goutil.findChildTextComponent(self.mainGO, "upCon/right/txtName")
	self._itemConLeft = self:getGo("upCon/left/headCon")
	self._itemConRight = self:getGo("upCon/right/headCon")
	self._cell = self:getGo("upCon/cell")
	self.leftheadConQua = self:getGo("upCon/left/headConQua"):GetComponent("UIImageSpriteChange")
	self.rightheadConQua = self:getGo("upCon/right/headConQua"):GetComponent("UIImageSpriteChange")
	self._txtTips.text = "离开力量之核的精灵等级和天赋等级将被还原\n" .. PowerCrystalConfig.instance:getSlotMaxCoolTimeStr() .. "后槽位可以重新添加精灵"
end

function PowerCrystalDownView:onEnter()
	PowerCrystalDownView.super.onEnter(self)

	self.slotId = self:getFirstParam()

	self:_updateUI()
end

function PowerCrystalDownView:_onCancelClick()
	self:close()
end

function PowerCrystalDownView:_onOkClick()
	local info = PowerCrystalModel.instance:getSlotInfo(self.slotId)

	if info then
		PowerCrystalController.instance:sendPM_PowerCrystalTakeOutOfSlotReq(self.slotId)
	end

	self:close()
end

function PowerCrystalDownView:_updateUI()
	local info = PowerCrystalModel.instance:getSlotInfo(self.slotId)

	if info then
		local data = BagPetsFacade.instance:getPetInfo(info.petId)

		if data then
			self:setRaceId(data.raceId)
			self.leftheadConQua:SetState(data.rare)
			self.rightheadConQua:SetState(data.rare)
		end

		self._txtCurrName.text = info.curLv .. "级\n" .. CharacterConfig.instance:getTalentName(data.raceId, info.curTalent)
		self._txtNextName.text = info.originalLv .. "级\n" .. CharacterConfig.instance:getTalentName(data.raceId, info.originalTalent)
	end
end

function PowerCrystalDownView:setRaceId(rid)
	local cfg = CharacterConfig.instance:getPetCo(rid)

	if not cfg then
		printError("t_pet id not exist:" .. rid)

		return
	end

	local modelCo = CharacterConfig.instance:getModelCo(checknumber(cfg.faceIds))

	if not modelCo then
		printError("t_model id not exist:" .. cfg.faceIds)

		return
	end

	uGuiUtil.setSpriteToImage(self._itemConLeft, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
	uGuiUtil.setSpriteToImage(self._itemConRight, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
end

return PowerCrystalDownView
