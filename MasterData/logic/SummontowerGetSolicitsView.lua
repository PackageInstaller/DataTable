-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerGetSolicitsView.lua

module("logic.extensions.summontower.view.SummontowerGetSolicitsView", package.seeall)

local SummontowerGetSolicitsView = class("SummontowerGetSolicitsView", ViewComponent)

function SummontowerGetSolicitsView:buildUI()
	SummontowerGetSolicitsView.super.buildUI(self)

	self._btnClose = self:getBtn("btnCancel")
	self._cells = {}
	self._cells[1] = self:getGo("numberGroup/cell")
	self._txtTip = self:getTxt("txtTip")
end

function SummontowerGetSolicitsView:bindEvents()
	SummontowerGetSolicitsView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function SummontowerGetSolicitsView:unbindEvents()
	SummontowerGetSolicitsView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function SummontowerGetSolicitsView:onEnter()
	SummontowerGetSolicitsView.super.onEnter(self)

	self._gridData = self:getFirstParam()
	self._petList = self._gridData.extInfo

	self:_refreshPetsView()
end

function SummontowerGetSolicitsView:_refreshPetsView()
	self._txtTip.text = string.format("见证你强大的实力，有%d只精灵表达加入你队伍的意愿，请你选择1只成为你的队员吧！", #self._petList)

	local cnt = #self._petList

	while cnt > #self._cells do
		table.insert(self._cells, UGUIToolHelper.AddChild(self._cells[1].transform.parent.gameObject, self._cells[1]))
	end

	for i = 1, cnt do
		local go = self._cells[i]

		go:SetActive(true)

		local petId = self._petList[i]
		local petCo = SummontowerConfig.instance:getPetCo(petId)
		local curFaceId = checknumber(petCo.faceId)

		if curFaceId == 0 then
			curFaceId = checknumber(petCo.raceId)
		end

		self:_fillPetInfo(petCo, curFaceId, go)
		self:_fillPetJob(petCo, curFaceId, go)
		self:_fillAttrIcon(petCo, curFaceId, go)

		local btnSelect = Framework.ButtonAdapter.GetFrom(go, "btnSelect")

		btnSelect:RemoveClickListener()
		btnSelect:AddClickListener(function()
			self:_swapPet(petId)
		end)
	end

	for i = cnt + 1, #self._cells do
		local go = self._cells[i]

		go:SetActive(false)
	end
end

function SummontowerGetSolicitsView:_fillPetInfo(petCo, curFaceId, gameObject)
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

function SummontowerGetSolicitsView:_fillPetJob(petCo, curFaceId, gameObject)
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

function SummontowerGetSolicitsView:_fillAttrIcon(petCo, curFaceId, gameObject)
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

function SummontowerGetSolicitsView:onExit()
	SummontowerGetSolicitsView.super.onExit(self)

	for i = 1, #self._cells do
		local gameObject = self._cells[i]
		local petCon = goutil.findChild(gameObject, "pet/con")
		local attr = goutil.findChild(gameObject, "attr")
		local job_1 = goutil.findChild(gameObject, "job_1")
		local job_2 = goutil.findChild(gameObject, "job_2")
		local btnJob1 = GameUtil.asBtn(job_1)
		local btnJob2 = GameUtil.asBtn(job_2)
		local btnSelect = Framework.ButtonAdapter.GetFrom(gameObject, "btnSelect")
		local btn = Framework.UIClickTrigger.Get(gameObject)

		btn:RemoveClickListener()
		btnJob1:RemoveClickListener()
		btnJob2:RemoveClickListener()
		btnSelect:RemoveClickListener()
		uGuiUtil.clearImage(petCon)
		GameUtil.asBtn(attr):RemoveClickListener()
	end
end

function SummontowerGetSolicitsView:_onClickClose()
	TipsFacade.instance:openPopupWindow(lang("tip"), "确定不选择任何1只精灵成为你的队员吗？", function()
		local gridId = self._gridData.gridId

		self:close()
		SummontowerController.instance:giveupSwapPet(gridId)
	end, function()
		return
	end, "确定", "取消")
end

function SummontowerGetSolicitsView:_swapPet(creepsId)
	local petCo = SummontowerConfig.instance:getPetCo(creepsId)

	TipsFacade.instance:openPopupWindow(lang("tip"), string.format(SummontowerConfig.instance:getParamsString("PET_NUM_LIMIT_TIP1"), petCo.lv, petCo.creepsName), function()
		if SummontowerPetsModel.instance:isPetNumMax() then
			SummontowerController.instance:openSelectSwapPetView(function(petId)
				local gridId = self._gridData.gridId

				self:close()
				SummontowerController.instance:swapPet(gridId, creepsId, petId)
			end)
		else
			local gridId = self._gridData.gridId

			self:close()
			SummontowerController.instance:swapPet(gridId, creepsId, 0)
		end
	end, function()
		return
	end, "确定", "取消")
end

return SummontowerGetSolicitsView
