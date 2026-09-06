-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerMembersView.lua

module("logic.extensions.summontower.view.SummontowerMembersView", package.seeall)

local SummontowerMembersView = class("SummontowerMembersView", ViewComponent)

function SummontowerMembersView:buildUI()
	SummontowerMembersView.super.buildUI(self)

	self._btnClose = Framework.UIClickTrigger.Get(self:getGo("bg"))
	self._cells = {}
	self._cells[1] = self:getGo("numberGroup/cell")
	self._petList = self:getGo("petList")
	self._petCell = self:getGo("numberGroup/cell")
	self._petScrollView = ScrollerList.create(self._petList, self._petCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function SummontowerMembersView:bindEvents()
	SummontowerMembersView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function SummontowerMembersView:unbindEvents()
	SummontowerMembersView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function SummontowerMembersView:onEnter()
	SummontowerMembersView.super.onEnter(self)
	self:_refreshPetsView()
end

function SummontowerMembersView:_updateTabCell(view, cell, data)
	local petCo = SummontowerConfig.instance:getPetCo(data.creepsId)
	local curFaceId = checknumber(petCo.faceId)

	if curFaceId == 0 then
		curFaceId = checknumber(petCo.raceId)
	end

	self:_fillPetInfo(petCo, curFaceId, cell.gameObject)
	self:_fillPetJob(petCo, curFaceId, cell.gameObject)
	self:_fillAttrIcon(petCo, curFaceId, cell.gameObject)
end

function SummontowerMembersView:_clearTabCell(cell)
	local petCon = goutil.findChild(cell, "pet/con")
	local attr = goutil.findChild(cell, "attr")
	local job_1 = goutil.findChild(cell, "job_1")
	local job_2 = goutil.findChild(cell, "job_2")
	local btnJob1 = GameUtil.asBtn(job_1)
	local btnJob2 = GameUtil.asBtn(job_2)
	local btn = Framework.UIClickTrigger.Get(cell)

	btn:RemoveClickListener()
	btnJob1:RemoveClickListener()
	btnJob2:RemoveClickListener()
	uGuiUtil.clearImage(petCon)
	GameUtil.asBtn(attr):RemoveClickListener()
end

function SummontowerMembersView:_refreshPetsView()
	local allPets = SummontowerPetsModel.instance:getAllPetCfgList() or {}

	self._petScrollView:reloadData(allPets)
end

function SummontowerMembersView:_fillPetInfo(petCo, curFaceId, gameObject)
	local petCon = goutil.findChild(gameObject, "pet/con")
	local textName = goutil.findChildTextComponent(gameObject, "txtName")
	local textLevel = goutil.findChildTextComponent(gameObject, "txtLevel")
	local level = petCo.lv

	textName.text = petCo.creepsName
	textLevel.text = "Lv:" .. tostring(level)

	local modelCo = CharacterConfig.instance:getModelCo(curFaceId)

	uGuiUtil.setSpriteToImage(petCon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	local btn = Framework.UIClickTrigger.Get(gameObject)

	btn:RemoveClickListener()
	btn:AddClickListener(function()
		local fightingPower = FightingPowerPetMo.New(petCo.raceId, level)

		fightingPower:fromChallengeCreepCo(petCo)

		local petMo = {
			contractSkillId = 0,
			raceId = petCo.raceId,
			curFaceId = curFaceId,
			level = level,
			name = petCo.creepsName,
			_curZdl = fightingPower:getFightingPower(),
			awakenLv = petCo.awakenLv
		}

		CommonTipsMgr.instance:showPetTips(petMo)
	end)
end

function SummontowerMembersView:_fillPetJob(petCo, curFaceId, gameObject)
	local job_1 = goutil.findChild(gameObject, "job_1"):GetComponent(ComponentType.UIImageSpriteChange)
	local job_2 = goutil.findChild(gameObject, "job_2"):GetComponent(ComponentType.UIImageSpriteChange)
	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(curFaceId)

	job_1:SetState(firstJobIdx - 1)

	local btnJob1 = GameUtil.asBtn(job_1.gameObject)

	btnJob1:RemoveClickListener()
	btnJob1:AddClickListener(function()
		CommonTipsMgr.instance:openMaterialTips(job_1, MatType.Job, firstJobIdx)
	end)
	GameUtil.SetActive(job_2, false)

	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(curFaceId)

	if secondJobIdx > 20 then
		GameUtil.SetActive(job_2, true)
		job_2:SetState(secondJobIdx - 1 - 20)

		local btnJob2 = GameUtil.asBtn(job_2.gameObject)

		btnJob2:RemoveClickListener()
		btnJob2:AddClickListener(function()
			CommonTipsMgr.instance:openMaterialTips(self.mainGO, MatType.Job, secondJobIdx)
		end)
	end
end

function SummontowerMembersView:_fillAttrIcon(petCo, curFaceId, gameObject)
	local attr = goutil.findChild(gameObject, "attr"):GetComponent(ComponentType.UIImageSpriteChange)
	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(curFaceId)

	race = race % 10

	local targetValue = race - 1

	attr:SetState(targetValue)

	local btnAttr = GameUtil.asBtn(attr.gameObject)

	btnAttr:RemoveClickListener()
	btnAttr:AddClickListener(function()
		CommonTipsMgr.instance:openMaterialTips(self.mainGO, MatType.Race, race)
	end)
end

function SummontowerMembersView:onExit()
	SummontowerMembersView.super.onExit(self)
end

function SummontowerMembersView:_onClickClose()
	self:close()
end

return SummontowerMembersView
