-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/villaintrial/view/VillaintrialEquipView.lua

module("logic.extensions.villaintrial.view.VillaintrialEquipView", package.seeall)

local VillaintrialEquipView = class("VillaintrialEquipView", ViewComponent)

function VillaintrialEquipView:ctor()
	VillaintrialEquipView.super.ctor(self)

	self._curSelected = nil
	self._curPetId = nil
	self._roleObj = {}
end

function VillaintrialEquipView:unbindEvents()
	VillaintrialEquipView.super.unbindEvents(self)
	self._instructionBg:RemoveClickListener()
	self._closeBtn:RemoveClickListener()
	self._btnRules:RemoveClickListener()
end

function VillaintrialEquipView:bindEvents()
	VillaintrialEquipView.super.bindEvents(self)
	self._instructionBg:AddClickListener(function()
		goutil.setActive(self._instructionBg.gameObject, false)
	end)
	self._closeBtn:AddClickListener(function()
		self:close()
	end)
	self._btnRules:AddClickListener(self._onClickbtnRule, self)
end

function VillaintrialEquipView:onExit()
	VillaintrialEquipView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.VillaintrialSpiritLine, self._updateAllInfo, self)
end

function VillaintrialEquipView:buildUI()
	VillaintrialEquipView.super.buildUI(self)

	self._petList = self:getGo("equiplist")
	self._cell = self:getGo("cell")
	self._btnRules = self:getBtn("topleft/btnRules")
	self._closeBtn = self:getBtn("topleft/btn_close")
	self._instructionBg = self:getBtn("instructionBg")
	self._instruction = self:getGo("instructionBg/instruction")
	self._adjustPosition = self._instruction:GetComponent("UIAdjustPosition")
	self._equipList = self:getGo("instructionBg/instruction/equiplist")
	self._equipCell = self:getGo("instructionBg/instruction/cell")
	self._petScrollList = ScrollerList.create(self._petList, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearItemCell, self))

	self._petScrollList:regGetCellSize(function()
		return 250, 720
	end)

	self.__equipScrollList = ScrollerList.create(self._equipList, self._equipCell, GameUtil.handler(self._updateEquipCell, self), GameUtil.handler(self._clearItemCell, self))

	self.__equipScrollList:regGetCellSize(function()
		return 400, 100
	end)
end

function VillaintrialEquipView:onEnter()
	VillaintrialEquipView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.VillaintrialSpiritLine, self._updateAllInfo, self)
	VillaintrialController.instance:sendPM_VillainPetTrialGetSpiritLineInfoReq()
	self:_setEffect()
end

function VillaintrialEquipView:_onClickbtnRule()
	TipsFacade.instance:openRulesView("villaintrialequipview")
end

function VillaintrialEquipView:_updateAllInfo()
	local info = VillaintrialModel.instance:getVillaintrialEquipInfo()

	self._petScrollList:reloadData(info)
end

function VillaintrialEquipView:_updateCell(view, cell, data)
	local spiritLinePlanId = self:_getSpiritLinePlanId(data.petId)
	local cfg = VillaintrialConfig.instance:getSpiritLineCfgs(spiritLinePlanId)
	local info = self:_getPetInfo(data.petId)
	local petIcon = goutil.findChild(cell, "peticon")
	local equipIcon = goutil.findChild(cell, "equipicon")
	local descTxt = goutil.findChildTextComponent(cell, "desctxt")
	local name = goutil.findChildTextComponent(cell, "name")
	local replace = goutil.findChild(cell, "replace")

	GameUtil.asBtn(replace):RemoveClickListener()
	GameUtil.asBtn(replace):AddClickListener(function()
		self:_setTipsPos(cell)

		self._curSelected = data.curSpiritLineId
		self._curPetId = data.petId

		self:_updateEquipList(data.petId)
		goutil.setActive(self._instructionBg.gameObject, true)
	end)

	local skinId = info.raceId
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(skinId))

	if not modelCo then
		printError("sr---- PetTeamsView:_updateCell()   精灵图片为空 petId = ", data.petId, info.raceId)

		return
	end

	uGuiUtil.setSpriteToImage(petIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	uGuiUtil.setSpriteToImage(equipIcon, uGuiUtil.SpriteType.BigBg, string.format("ui/icon/items/%s.png", cfg[data.curSpiritLineId].suitIcon))
	table.insert(self._roleObj, petIcon)
	table.insert(self._roleObj, equipIcon)

	descTxt.text = cfg[data.curSpiritLineId].suitDesc
	name.text = cfg[data.curSpiritLineId].suitName
end

function VillaintrialEquipView:_clearItemCell()
	for k, v in pairs(self._roleObj) do
		uGuiUtil.clearImage(v)
	end

	self._roleObj = {}
end

function VillaintrialEquipView:_updateEquipList(petId)
	local spiritLinePlanId = self:_getSpiritLinePlanId(petId)
	local cfg = VillaintrialConfig.instance:getSpiritLineCfgs(spiritLinePlanId)
	local temp = {}

	for i, v in ipairs(cfg) do
		table.insert(temp, v)
	end

	table.remove(temp, self._curSelected)
	self.__equipScrollList:reloadData(temp)
end

function VillaintrialEquipView:_getSpiritLinePlanId(petId)
	local teamId = VillaintrialModel.instance:getCurTeamId()
	local pets = VillaintrialConfig.instance:getVillainPets(teamId)
	local spiritLinePlanId = 1

	if petId < 1000 then
		spiritLinePlanId = pets[petId].spiritLinePlanId
	else
		local petCfg = VillaintrialConfig.instance:getSsSupportCfgByCSId(petId)

		spiritLinePlanId = petCfg.spiritLinePlanId
	end

	return spiritLinePlanId
end

function VillaintrialEquipView:_getPetInfo(petId)
	local teamId = VillaintrialModel.instance:getCurTeamId()
	local pets = VillaintrialConfig.instance:getVillainPets(teamId)

	return petId < 1000 and pets[petId] or VillaintrialConfig.instance:getSsSupportCfgByCSId(petId)
end

function VillaintrialEquipView:_updateEquipCell(view, cell, data)
	local descTxt = goutil.findChildTextComponent(cell, "desctxt")
	local name = goutil.findChildTextComponent(cell, "txtName")
	local iconBg = goutil.findChild(cell, "iconBg")

	descTxt.text = data.suitDesc
	name.text = data.suitName

	uGuiUtil.setSpriteToImage(iconBg, uGuiUtil.SpriteType.BigBg, string.format("ui/icon/items/%s.png", data.suitIcon))
	table.insert(self._roleObj, iconBg)
	GameUtil.asBtn(cell):RemoveClickListener()
	GameUtil.asBtn(cell):AddClickListener(function()
		goutil.setActive(self._instructionBg.gameObject, false)
		VillaintrialController.instance:sendPM_VillainPetTrialChangeSpiritLineReq(self._curPetId, data.spiritLineId)
		self:_changeSpiritLine(data.spiritLineId)
		FloatWordMgr.instance:show("更换成功")
	end)
end

function VillaintrialEquipView:_changeSpiritLine(spiritLineId)
	local info = VillaintrialModel.instance:getVillaintrialEquipInfo()

	for i, v in ipairs(info) do
		if v.petId == self._curPetId then
			v.curSpiritLineId = spiritLineId
		end
	end

	self._petScrollList:reloadData(info)
end

function VillaintrialEquipView:_setTipsPos(goOrPos)
	local pos
	local sizeDelta = {
		0,
		0
	}

	if goOrPos and goOrPos.gameObject then
		local rect = goOrPos.gameObject:GetComponent("RectTransform")

		if rect ~= nil then
			sizeDelta = {
				rect.sizeDelta.x,
				rect.sizeDelta.y
			}
		end

		pos = goOrPos.gameObject.transform.position

		local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

		pos = uiCamera:WorldToScreenPoint(pos)
	end

	if pos then
		self._adjustPosition:AdjustScreenPosition(pos, sizeDelta[1], sizeDelta[2])
	else
		Framework.TransformUtil.SetLocalPos(self._Nego_Content.transform, 0, 0, 0)
	end
end

function VillaintrialEquipView:_setEffect()
	local level = VillaintrialModel.instance:getCurStageId()

	if GameUtil.getUserDayData("VillaintrialEquipView" .. level) == nil then
		GameUtil.saveUserDayData("VillaintrialEquipView" .. level, 1)
	end
end

return VillaintrialEquipView
