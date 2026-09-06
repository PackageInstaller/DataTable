-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerChooseView.lua

module("logic.extensions.summontower.view.SummontowerChooseView", package.seeall)

local SummontowerChooseView = class("SummontowerChooseView", ViewComponent)

function SummontowerChooseView:buildUI()
	SummontowerChooseView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnStart = self:getBtn("btnStart")
	self._tableview = self:getGo("tableview"):GetComponent(ComponentType.UITableview)
	self._tableCell = self:getGo("cell")

	self._tableCell:SetActive(false)
end

function SummontowerChooseView:bindEvents()
	SummontowerChooseView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnStart:AddClickListener(self._onClickStart, self)
	self._tableview:RegisterCallback(self._numSunmonsInView, nil, self._summonCellAtIndex, self)
end

function SummontowerChooseView:unbindEvents()
	SummontowerChooseView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._tableview:UnRegisterAllCallbacks()
end

function SummontowerChooseView:onEnter()
	SummontowerChooseView.super.onEnter(self)

	self._wishType = nil
	self._gridData = nil

	local openParam = self:getOpenParam()

	if openParam then
		self._wishType = openParam[1]
		self._gridData = openParam[2]
	end

	self._currSelectId = 0
	self._curViewDatas = SummontowerConfig.instance:getSummonPetsCo(SummontowerModel.instance:getPlayerLevel())

	self._tableview:SetOffsetWithoutRefresh(0)
	self._tableview:ReloadData()
	GlobalDispatcher:addListener(GlobalNotify.OnSommonMasterSel, self._onSommonMasterSel, self)
	GlobalDispatcher:addListener(GlobalNotify.OnSommonTowerDoGrid, self._onSommonTowerDoGrid, self)
end

function SummontowerChooseView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.OnSommonTowerDoGrid, self._onSommonTowerDoGrid, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnSommonMasterSel, self._onSommonMasterSel, self)
	SummontowerChooseView.super.onExit(self)

	self._currSelectId = nil
	self._gridData = nil
	self._wishType = nil

	self._tableview:Travel(self._clearCell, self)
end

function SummontowerChooseView:_onClickClose()
	self:close()
end

function SummontowerChooseView:_onClickStart()
	if checknumber(self._currSelectId) == 0 then
		FloatWordMgr.instance:show(lang("text_summon_master_noseltips"))

		return
	end

	local petCo = SummontowerConfig.instance:getPetCo(self._currSelectId)

	TipsFacade.instance:openPopupWindow(lang("tip"), string.format(lang("text_summon_master_seltips"), petCo.creepsName), function()
		if not self._wishType then
			SummontowerController.instance:requestSelectSummonMaster(self._currSelectId)
		else
			SummontowerController.instance:wish1Pet(self._gridData.gridId, self._wishType, self._currSelectId)
		end
	end, function()
		return
	end, lang("confirm"), lang("mail_cancel"))
end

function SummontowerChooseView:_numSunmonsInView(view)
	if not self._curViewDatas then
		return 0
	end

	return #self._curViewDatas
end

function SummontowerChooseView:_summonCellAtIndex(view, idx)
	local petData = self._curViewDatas[idx + 1]
	local cell = self._tableview:DequeueCell()

	cell = cell or self._tableview:AddChild(self._tableCell)

	local gameObject = cell.gameObject
	local selected = goutil.findChild(gameObject, "select")
	local btn = Framework.ButtonAdapter.Get(gameObject)
	local curFaceId = checknumber(petData.faceId)

	if curFaceId == 0 then
		curFaceId = checknumber(petData.raceId)
	end

	self:_fillPetJob(gameObject, petData, curFaceId)
	self:_fillAttrIcon(gameObject, petData, curFaceId)
	self:_fillPetInfo(gameObject, petData, curFaceId)
	self:_fillsummonedPet(gameObject, petData)
	selected:SetActive(self._currSelectId == petData.creepsId)
	btn:RemoveClickListener()
	btn:AddClickListener(function()
		self._currSelectId = petData.creepsId

		self._tableview:Refresh()
	end)

	return cell
end

function SummontowerChooseView:_fillPetInfo(gameObject, petData, curFaceId)
	local petCon = goutil.findChild(gameObject, "pet/con")
	local textName = goutil.findChildTextComponent(gameObject, "txtName")
	local textLevel = goutil.findChildTextComponent(gameObject, "txtLevel")
	local btntip = Framework.ButtonAdapter.GetFrom(gameObject, "btntip")
	local level = petData.lv

	textName.text = petData.creepsName
	textLevel.text = "Lv:" .. tostring(level)

	local modelCo = CharacterConfig.instance:getModelCo(curFaceId)

	uGuiUtil.setSpriteToImage(petCon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	btntip:RemoveClickListener()
	btntip:AddClickListener(function()
		local fightingPower = FightingPowerPetMo.New(petData.raceId, level)

		fightingPower:fromChallengeCreepCo(petData)

		local petMo = {
			contractSkillId = 0,
			raceId = petData.raceId,
			curFaceId = curFaceId,
			level = level,
			name = petData.creepsName,
			_curZdl = fightingPower:getFightingPower(),
			awakenLv = petData.awakenLv
		}

		CommonTipsMgr.instance:showPetTips(petMo)
	end)
end

function SummontowerChooseView:_fillsummonedPet(gameObject, petData)
	local contractPet = goutil.findChild(gameObject, "contractPet")
	local itemPet = goutil.findChild(contractPet, "itemPet")
	local petCo = SummontowerConfig.instance:getPetCo(checknumber(petData.summonedPetId))
	local level = petCo.lv
	local item = MatType.Pet .. ":" .. petCo.raceId .. ":" .. level

	MaterialMgr.resetAll(itemPet)

	local proxy = MaterialMgr.setCellByCfg(item, itemPet)

	if proxy then
		local curFaceId = checknumber(petCo.faceId)

		if curFaceId == 0 then
			curFaceId = checknumber(petCo.raceId)
		end

		proxy.binder:setStars(petCo.awakenLv)
		proxy.binder:setSkin(curFaceId)
		proxy.binder:setAutoTips(false)
		proxy.binder:setCallBack(function()
			local fightingPower = FightingPowerPetMo.New(petCo.raceId, level)

			fightingPower:fromChallengeCreepCo(petCo, cfgs)

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
end

function SummontowerChooseView:_fillPetJob(gameObject, petData, curFaceId)
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

function SummontowerChooseView:_fillAttrIcon(gameObject, petData, curFaceId)
	local attr = goutil.findChild(gameObject, "attr"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtAttr = goutil.findChildTextComponent(gameObject, "txtAttr")
	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(curFaceId)

	race = race % 10

	local targetValue = race - 1

	attr:SetState(targetValue)

	local btnAttr = GameUtil.asBtn(attr.gameObject)

	btnAttr:RemoveClickListener()
	btnAttr:AddClickListener(function()
		CommonTipsMgr.instance:openMaterialTips(self.mainGO, MatType.Race, race)
	end)

	txtAttr.text = petData.raceId == 11001 and "女性召唤师" or SummontowerModel.SummonCareerName[race]
end

function SummontowerChooseView:_clearCell(cell)
	local gameObject = cell.gameObject
	local btn = Framework.ButtonAdapter.Get(gameObject)
	local petCon = goutil.findChild(gameObject, "pet/con")
	local attr = goutil.findChild(gameObject, "attr")
	local btnTip = Framework.ButtonAdapter.GetFrom(gameObject, "btntip")
	local contractPet = goutil.findChild(gameObject, "contractPet/itemPet")
	local job_1 = goutil.findChild(gameObject, "job_1")
	local job_2 = goutil.findChild(gameObject, "job_2")
	local btnJob1 = GameUtil.asBtn(job_1.gameObject)
	local btnJob2 = GameUtil.asBtn(job_2.gameObject)

	uGuiUtil.clearImage(petCon)
	GameUtil.asBtn(attr):RemoveClickListener()
	MaterialMgr.resetAll(contractPet)
	btnJob1:RemoveClickListener()
	btnJob2:RemoveClickListener()
	btnTip:RemoveClickListener()
end

function SummontowerChooseView:_onSommonMasterSel()
	FloatWordMgr.instance:show(lang("text_summon_master_selsuccess"))
	UIStateManager.instance:push(ViewName.SummontowerMainView)
	self:close()
end

function SummontowerChooseView:_onSommonTowerDoGrid()
	FloatWordMgr.instance:show(lang("text_summon_master_selsuccess"))
	UIStateManager.instance:push(ViewName.SummontowerMainView)
	self:close()
end

return SummontowerChooseView
