-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newbreakformation/view/NewbreakformationpetbuffselectView.lua

module("logic.extensions.newbreakformation.view.NewbreakformationpetbuffselectView", package.seeall)

local NewbreakformationpetbuffselectView = class("NewbreakformationpetbuffselectView", ViewComponent)

function NewbreakformationpetbuffselectView:ctor()
	NewbreakformationpetbuffselectView.super.ctor(self)
end

function NewbreakformationpetbuffselectView:unbindEvents()
	NewbreakformationpetbuffselectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSelect)
	self._btnAdd1:RemoveClickListener()
	self._btnAdd2:RemoveClickListener()
end

function NewbreakformationpetbuffselectView:bindEvents()
	NewbreakformationpetbuffselectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnSelect, self._onClickSelect, self)
	self._btnAdd1:AddClickListener(self._onClickbtnAdd1, self)
	self._btnAdd2:AddClickListener(self._onClickbtnAdd2, self)
end

function NewbreakformationpetbuffselectView:buildUI()
	NewbreakformationpetbuffselectView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSelect = self:getGo("btnSelect")
	self._allBuffTableView = self:getGo("allTableview")
	self._buffCell = self:getGo("buffCell")
	self._txtSelectCount = self:getTxt("txtSelectCount")
	self._allBuffTableList = ScrollerList.create(self._allBuffTableView, self._buffCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearAllCell, self))
	self._btnAdd1 = self:getBtn("item1/btnAdd")
	self._btnAdd2 = self:getBtn("item2/btnAdd")
	self._itemconGo1 = self:getGo("item1/itemcon")
	self._itemconGo2 = self:getGo("item2/itemcon")
	self._itemGo2 = self:getGo("item2")
end

function NewbreakformationpetbuffselectView:onExit()
	NewbreakformationpetbuffselectView.super.onExit(self)
	MaterialMgr.resetAll(self._itemconGo1)
	MaterialMgr.resetAll(self._itemconGo2)

	self._petMos = nil
end

function NewbreakformationpetbuffselectView:onEnter()
	NewbreakformationpetbuffselectView.super.onEnter(self)

	local params = self:getOpenParam()

	self._seasonId = params[1]
	self._tabId = params[2]
	self._periodId = params[3]
	self._stageId = params[4]
	self._petRaceId1 = 0
	self._petRaceId2 = 0

	local tabCfg = NewBreakFormationConfig.instance:getTabCfg(self._seasonId, self._tabId)
	local periodCfg = NewBreakFormationConfig.instance:getPeriodCfg(tabCfg.periodPlanId, self._periodId)

	self._stageCfg = NewBreakFormationConfig.instance:getStageCfg(periodCfg.stagePlanId, self._stageId)
	self._selectPetBuffCount = self._stageCfg.selectPetBuffCount

	goutil.setActive(self._itemGo2, self._selectPetBuffCount > 1)
	self:_refreshView()
end

function NewbreakformationpetbuffselectView:_updateCell(view, cell, cfg, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "buffCon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local btnSelect = goutil.findChild(go, "btn")
	local selectGo = goutil.findChild(go, "selectGo")
	local iconGo = goutil.findChild(go, "iconbg/icon")
	local btnTips = Framework.ButtonAdapter.Get(goutil.findChild(go, "btnTips"))

	uGuiUtil.clearImage(con)
	uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, cfg.buffResName)

	txtDesc.text = cfg.buffDesc
	txtName.text = cfg.name

	GameUtil.SetActive(selectGo, cfg.raceId == self._petRaceId1 or cfg.raceId == self._petRaceId2)
	uGuiUtil.clearImage(iconGo)

	local modelCo = CharacterConfig.instance:getModelCo(cfg.raceId)

	uGuiUtil.setSpriteToImage(iconGo, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
	btnTips:AddClickListener(function()
		CommonTipsMgr.instance:openMaterialTips(btnTips.gameObject, MatType.Pet, cfg.raceId)
	end)
end

function NewbreakformationpetbuffselectView:_clearAllCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "buffCon")
	local iconGo = goutil.findChild(go, "iconbg/icon")

	uGuiUtil.clearImage(con)
	uGuiUtil.clearImage(iconGo)
end

function NewbreakformationpetbuffselectView:_onClickClose()
	NewBreakFormationModel.instance:setPetBuffMap(self._tabId, self._stageId, self._petRaceId1, self._petRaceId2)
	GlobalDispatcher:dispatch(GlobalNotify.NewBreakFormationeSelectBuff)
	self:close()
end

function NewbreakformationpetbuffselectView:_onClickSelect()
	NewBreakFormationModel.instance:setPetBuffMap(self._tabId, self._stageId, self._petRaceId1, self._petRaceId2)
	GlobalDispatcher:dispatch(GlobalNotify.NewBreakFormationeSelectBuff)
	self:close()
end

function NewbreakformationpetbuffselectView:_refreshView()
	local stageInfo = NewBreakFormationModel.instance:getStageInfo(self._seasonId, self._tabId, self._periodId, self._stageId)
	local allBuffCfgs = NewBreakFormationConfig.instance:getPetBuffCfgs(self._stageCfg.petBuffPlan)

	self._buffMap = NewBreakFormationModel.instance:getBuffMap(self._tabId)

	if self._buffMap then
		if self._buffMap and self._stageCfg.petBuffPlan > 0 then
			if self._petRaceId1 <= 0 then
				self._petRaceId1 = checknumber(self._buffMap.petRaceId1)
			end

			if self._petRaceId2 <= 0 then
				self._petRaceId2 = checknumber(self._buffMap.petRaceId2)
			end
		end

		self._allBuffTableList:reloadData(allBuffCfgs)

		local count = 0

		if self._petRaceId1 > 0 then
			count = count + 1
		end

		if self._petRaceId2 > 0 then
			count = count + 1
		end

		MaterialMgr.resetAll(self._itemconGo1)
		MaterialMgr.resetAll(self._itemconGo2)

		if self._petRaceId1 > 0 then
			MaterialMgr.setCellByCfg(string.format("%s:%s", MatType.Pet, self._petRaceId1), self._itemconGo1)
		end

		if self._petRaceId2 > 0 then
			MaterialMgr.setCellByCfg(string.format("%s:%s", MatType.Pet, self._petRaceId2), self._itemconGo2)
		end

		self._txtSelectCount.text = langPara("%d/%s", count, self._selectPetBuffCount)
	end
end

function NewbreakformationpetbuffselectView:_onClickbtnAdd1()
	if self:_selectBuffCount() >= self._selectPetBuffCount and self._petRaceId1 <= 0 then
		FloatWordMgr.instance:show("增益达上限")

		return
	end

	self:_createPetMos()

	local function filterFunc(pet)
		return pet.raceId ~= self._petRaceId1 and pet.raceId ~= self._petRaceId2
	end

	local function submitFunc(petId)
		local petMo = BagModel.instance:getPet(petId)

		if not petMo then
			return
		end

		self._petRaceId1 = petMo.raceId

		self:_refreshView()
	end

	PetSelectController.instance:OpenView(true, "请选择一只精灵", filterFunc, submitFunc, nil, nil, nil, self._petMos, true, nil, "您未获得指定精灵，请获得后再试")
end

function NewbreakformationpetbuffselectView:_onClickbtnAdd2()
	if self:_selectBuffCount() >= self._selectPetBuffCount and self._petRaceId2 <= 0 then
		FloatWordMgr.instance:show("增益达上限")

		return
	end

	self:_createPetMos()

	local function filterFunc(pet)
		return pet.raceId ~= self._petRaceId1 and pet.raceId ~= self._petRaceId2
	end

	local function submitFunc(petId)
		local petMo = BagModel.instance:getPet(petId)

		if not petMo then
			return
		end

		self._petRaceId2 = petMo.raceId

		self:_refreshView()
	end

	PetSelectController.instance:OpenView(true, "请选择一只精灵", filterFunc, submitFunc, nil, nil, nil, self._petMos, true, nil, "您未获得指定精灵，请获得后再试")
end

function NewbreakformationpetbuffselectView:_createPetMos()
	if self._petBuffPlan ~= self._stageCfg.petBuffPlan then
		self._petBuffPlan = self._stageCfg.petBuffPlan
		self._petMos = nil
	end

	if self._petMos then
		return self._petMos
	end

	self._petMos = {}

	local petBuffCfgs = NewBreakFormationConfig.instance:getPetBuffCfgs(self._petBuffPlan)

	for k, v in pairs(petBuffCfgs) do
		local petId = BagModel.instance:getMaxZdlPetIdByRaceId(v.raceId)

		if petId then
			local petMo = BagPetsController.instance:getPet(petId)

			table.insert(self._petMos, petMo)
		end
	end
end

function NewbreakformationpetbuffselectView:_selectBuffCount()
	return (checknumber(self._petRaceId1) > 0 and 1 or 0) + (checknumber(self._petRaceId2) > 0 and 1 or 0)
end

return NewbreakformationpetbuffselectView
