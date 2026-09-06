-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/view/ContractListView.lua

module("logic.extensions.contract.view.ContractListView", package.seeall)

local ContractListView = class("ContractListView", ViewComponent)

function ContractListView:ctor()
	ContractListView.super.ctor(self)
end

function ContractListView:destroyUI()
	ContractListView.super.destroyUI(self)
end

function ContractListView:onExitFinished()
	ContractListView.super.onExitFinished(self)
end

function ContractListView:onEnterFinished()
	ContractListView.super.onEnterFinished(self)
end

function ContractListView:unbindEvents()
	ContractListView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function ContractListView:bindEvents()
	ContractListView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function ContractListView:onExit()
	ContractListView.super.onExit(self)
	self.scrollList:dispose()
end

function ContractListView:buildUI()
	ContractListView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self.tableview = self:getGo("tableview")
	self.cell = self:getGo("cell")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))

	self.scrollList:setCenterMode(true)
end

function ContractListView:onEnter()
	ContractListView.super.onEnter(self)

	self._petMo = self:getFirstParam()

	self.addGEvent(self, GlobalNotify.BagPetChanged, self.refreshUI, self)
	self:refreshUI()
end

function ContractListView:_updateCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "mask/con")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtLevel = goutil.findChildTextComponent(cell, "txtLevel")
	local sign = goutil.findChild(cell, "sign")
	local Img_attr = goutil.findChild(cell, "Img_attr")
	local btnContract = goutil.findChild(cell, "btnContract")
	local skillicon = goutil.findChild(cell, "btnContract/icon")
	local txtSkillName = goutil.findChildTextComponent(cell, "btnContract/txt")

	self:setModelImg(data.raceId, con)
	GameUtil.SetActive(sign, false)

	txtName.text = MaterialMgr.getMaterialsName(MatType.Pet, data.raceId)
	txtSkillName.text = ""

	MaterialMgr.resetAll(skillicon)

	local skillId = checknumber(data.contractSkillId)

	if skillId > 0 then
		local skillCfg = BattleConfig.instance:getSkillCo(skillId, data.curFaceId)
		local proxy = MaterialMgr.setCell(MatType.Skill, skillId, skillicon)

		if proxy then
			proxy:setAutoTips(false)
		end

		txtSkillName.text = skillCfg.name
	end

	txtLevel.text = data.level .. "级"

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(data.curFaceId)

	race = math.fmod(race, 10)

	local targetValue = race - 1

	GameUtil.setUIImageSpriteIdx(Img_attr, targetValue)
	GameUtil.addClickHandler(con, function()
		MaterialMgr.openGetSource(MatType.Pet, data.raceId)
	end)
	GameUtil.addClickHandler(btnContract, function()
		UIStateManager.instance:push(ViewName.ContractskillpopView, data)
	end)
end

function ContractListView:setModelImg(faceId, con)
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(faceId))

	if not modelCo then
		printError("t_model id not exist:" .. faceId)

		return
	end

	uGuiUtil.setSpriteToImage(con.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
end

function ContractListView:clearCell(cell)
	local con = goutil.findChild(cell, "mask/con")
	local skillicon = goutil.findChild(cell, "btnContract/icon")

	uGuiUtil.clearImage(con)
	GameUtil.asBtn(goutil.findChild(cell, "mask/con")):RemoveClickListener()
	MaterialMgr.resetAll(skillicon)
end

function ContractListView:_onClickClose()
	self:close()
end

function ContractListView:refreshUI()
	local list = {}
	local limitLv = checknumber(ContractConfig.instance:getConstValueByKey("SUMMONED_PET_MIN_LVL"))
	local map = ContractConfig.instance:getMasterGroupCfgList(self._petMo.raceId) or {}
	local bagPetMos = BagModel.instance:getBagPets()

	for i, mo in ipairs(bagPetMos) do
		if map[mo.raceId] and limitLv <= mo.level and not mo:isBorrowPet() and mo.isMyPackPet then
			table.insert(list, mo)
		end
	end

	self.scrollList:reloadData(list)
end

return ContractListView
