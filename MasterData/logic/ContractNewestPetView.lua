-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/view/ContractNewestPetView.lua

module("logic.extensions.contract.view.ContractNewestPetView", package.seeall)

local ContractNewestPetView = class("ContractNewestPetView", ViewComponent)

function ContractNewestPetView:ctor()
	ContractNewestPetView.super.ctor(self)
end

function ContractNewestPetView:buildUI()
	ContractNewestPetView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnLeft = self:getBtn("btn_left")
	self._btnRight = self:getBtn("btn_right")
	self._btnToget = self:getBtn("btnToget")
	self._btnVideo = self:getBtn("btnVideo")
	self._btnZoom = self:getBtn("btnZoom")
	self._btnDrawing = self:getBtn("btnDrawing")
	self.commentBtn = self:getBtn("commentBtn")
	self._btnVoice = self:getBtn("btnVoice")
	self._imgJob = goutil.findChildComponent(self.mainGO, "job/icon", "UIImageSpriteChange")
	self._imgJob1 = goutil.findChildComponent(self.mainGO, "job1/icon", "UIImageSpriteChange")
	self._imgAttr = goutil.findChildComponent(self.mainGO, "attr/icon", "UIImageSpriteChange")
	self._Job = goutil.findChild(self.mainGO, "job")
	self._Job1 = goutil.findChild(self.mainGO, "job1")
	self._Attr = goutil.findChild(self.mainGO, "attr")
	self._txtPower = goutil.findChildComponent(self.mainGO, "power/txt_power", "Text")
	self._goToget = self:getGo("btnToget")
	self._switchOn = goutil.findChild(self._btnDrawing.gameObject, "on")
	self._switchOff = goutil.findChild(self._btnDrawing.gameObject, "off")
	self.txt_name = goutil.findChildTextComponent(self.mainGO, "name/txt_name")
	self._rarePoint = self:getGo("name/rare")
	self._bubble = self:getGo("mask/role/bubble")
	self.txtEvname = goutil.findChildTextComponent(self.mainGO, "cv/txtEvname")
	self._gocvName = goutil.findChild(self.mainGO, "cv")
	self._goVoice = goutil.findChild(self.mainGO, "btnVoice")
	self._Container = self:getGo("container")
	self._customInput = UICustomInput.Get(self._Container)

	local dragContent = self:getGo("mask/role/dragContent")
	local rawImg = goutil.findChild(dragContent, "role_image_1")

	self._rawImgDrag = RawImageDrag.New(dragContent, rawImg)

	self._rawImgDrag:setUpdateCallback(self._updateCell, self)
	self._rawImgDrag:setClickCallback(self._onClickCell, self)

	self._txtPage = self:getTxt("txtPage")
	self.skillicon = self:getGo("info/skill/skillicon")
	self.txtSkillName = self:getTxt("info/skill/txtName")
	self.txtSkillDesc = self:getTxt("info/skill/txtDesc")
	self.tableview = self:getGo("info/contract/tableview")
	self.cell = self:getGo("info/contract/cell")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
end

function ContractNewestPetView:bindEvents()
	ContractNewestPetView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnLeft:AddClickListener(function()
		self:_onClickSwitchPet(true)
	end, self)
	self._btnRight:AddClickListener(function()
		self:_onClickSwitchPet(false)
	end, self)
	self._btnToget:AddClickListener(self._onClickToGet, self)
	self._btnVideo:AddClickListener(self._onClickVideo, self)
	self._btnZoom:AddClickListener(self._onClickZoom, self)
	self._btnDrawing:AddClickListener(self._onClickSwitchDrawing, self)
	self.commentBtn:AddClickListener(function()
		UIStateManager.instance:open(ViewName.PetComment, self.raceId)
	end, self)
	self._btnVoice:AddClickListener(self._onClickVoice, self)
	self._customInput:AddListener(self._onCloseCVviewCallback, self)
end

function ContractNewestPetView:unbindEvents()
	ContractNewestPetView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnToget:RemoveClickListener()
	self._btnVideo:RemoveClickListener()
	self._btnZoom:RemoveClickListener()
	self._btnDrawing:RemoveClickListener()
	self.commentBtn:RemoveClickListener()
	self._btnVoice:RemoveClickListener()
	self._customInput:RemoveListener()
end

function ContractNewestPetView:onEnter()
	ContractNewestPetView.super.onEnter(self)

	self._petPhotoShows = {}
	self.petCvViewOnShow = false
	self._isLihui = true

	ContractNewestPetModel.instance:getPetDatas()

	self._curIndex = ContractNewestPetModel.instance:getSelectedPetIndex()
	self.raceId = ContractNewestPetModel.instance:getSelectedPetId()

	self:centerOnIndex(self._curIndex, false)
end

function ContractNewestPetView:onExit()
	ContractNewestPetView.super.onExit(self)
	PetCvController.instance:turnOffCurCv(false)
	MaterialMgr.resetAll(self._rarePoint)

	for _, v in ipairs(self._petPhotoShows) do
		v:destroy()
	end

	self._petPhotoShows = nil
	self._curPetPhotoShow = nil

	self:_resetContractInfo()
	self.scrollList:dispose()
end

function ContractNewestPetView:_onClickClose()
	self:close()
end

function ContractNewestPetView:_onClickSwitchPet(isLeft)
	if self._isTweening then
		return
	end

	if isLeft then
		if not (self._curIndex - 1) then
			local temp = self._curIndex + 1
			local len = ContractNewestPetModel.instance:getPetListLen()

			if temp < 1 or len < temp then
				return
			end

			self.raceId = ContractNewestPetModel.instance:getIndexPet(temp).raceId

			self:centerOnIndex(temp, true, isLeft)
		end
	end
end

function ContractNewestPetView:centerOnIndex(idx, isSpring, isLeft)
	idx = checknumber(idx)

	local len = ContractNewestPetModel.instance:getPetListLen()

	if idx >= 1 and idx <= len then
		self._rawImgDrag:setMaxNum(len)
		self._rawImgDrag:centerOnIndex(idx, isSpring, isLeft)
	end

	self:_refresh()
end

function ContractNewestPetView:_refresh()
	self._curIndex = self._curIndex or 1
	self.raceId = ContractNewestPetModel.instance:getIndexPet(self._curIndex).raceId

	goutil.setActive(self._switchOn, self._isLihui)
	goutil.setActive(self._switchOff, not self._isLihui)
	GameUtil.SetActive(self._btnDrawing, CharacterConfig.instance:CheckHasTowAsset(self.raceId))

	local cfg = PetSkinConfig.instance:getPetSkinCfg(self.raceId)

	if cfg then
		self:refreshJob(cfg)

		self.txt_name.text = cfg.name

		local petCo = CharacterConfig.instance:getPetCo(self.raceId)
		local rare = GameEnum.PetRare.N

		rare = CharacterConfig.instance:getRareByAwakenLv(petCo.initAwakenLv, self.raceId)

		local proxy = MaterialMgr.setCell(MatType.Rare, cfg.raceId, self._rarePoint)

		proxy.binder:setRare(rare)
		self:_refreshContractInfo(cfg)
	end

	local maxMo = FightingPowerFormula.instance:getRealMaxFightingPowerPetMo(self.raceId)

	self._txtPower.text = maxMo:getFightingPower()

	local cvName = PetSkinConfig.instance:getSkinCvName(self.raceId)
	local cvIsExist = not string.nilorempty(cvName)

	if cvIsExist then
		self.txtEvname.text = "CV." .. cvName

		goutil.setActive(self._gocvName, true)
		goutil.setActive(self._goVoice, true)
	else
		goutil.setActive(self._gocvName, false)
		goutil.setActive(self._goVoice, false)
	end

	local unproved = HandbookConfig.instance:getPetDetailsCfgById(self.raceId).unproved == 1

	goutil.setActive(self._goToget, not unproved)
	self:_updateSwitchBtnStatus()
	self:_refreshTabView()
	self:_showContractPetList(self.raceId)
end

function ContractNewestPetView:_updateSwitchBtnStatus()
	local len = ContractNewestPetModel.instance:getPetListLen()

	goutil.setActive(self._btnLeft.gameObject, self._curIndex > 1)
	goutil.setActive(self._btnRight.gameObject, len > self._curIndex)

	self._txtPage.text = string.format("(%d/%d)", self._curIndex, len)
end

function ContractNewestPetView:_refreshTabView()
	if self.petCvViewOnShow then
		self:showTabAt(self._Container, ViewName.PetcvView, ContractNewestPetModel.instance:getSelectedPetId())
	else
		self:showTabAt(self._Container, "")
	end
end

function ContractNewestPetView:refreshJob(cfg)
	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(cfg.raceId)

	self._imgJob:SetState(firstJobIdx - 1)

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(cfg.raceId)

	race = math.fmod(race, 10)

	local targetValue = race - 1

	self._imgAttr:SetState(targetValue)
	GameUtil.asBtn(self._Attr):RemoveClickListener()
	GameUtil.asBtn(self._Attr):AddClickListener(function()
		CommonTipsMgr.instance:openMaterialTips(self._Attr, MatType.Race, race)
	end)
	GameUtil.asBtn(self._Job):RemoveClickListener()
	GameUtil.asBtn(self._Job):AddClickListener(function()
		local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(cfg.raceId)

		CommonTipsMgr.instance:openMaterialTips(self._Job, MatType.Job, firstJobIdx)
	end)
	goutil.setActive(self._imgJob1.transform.parent.gameObject, false)
	goutil.setActive(self._imgJob.transform.parent.gameObject, true)

	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(cfg.raceId)

	if secondJobIdx > 20 then
		goutil.setActive(self._imgJob1.transform.parent.gameObject, true)
		self._imgJob1:SetState(secondJobIdx - 1 - 20)
		GameUtil.asBtn(self._Job1):RemoveClickListener()
		GameUtil.asBtn(self._Job1):AddClickListener(function()
			CommonTipsMgr.instance:openMaterialTips(self._Job1, MatType.Job, secondJobIdx)
		end)
	end
end

function ContractNewestPetView:_onClickToGet()
	MaterialMgr.openGetSource(MatType.PetPiece, self.raceId)
end

function ContractNewestPetView:_onClickVideo()
	PetbookController.instance:previewBattle(self.raceId)
end

function ContractNewestPetView:_onClickZoom()
	UIStateManager.instance:push(ViewName.PetDrawing, self.raceId)
end

function ContractNewestPetView:_onClickSwitchDrawing()
	self._isLihui = not self._isLihui

	self:centerOnIndex(self._curIndex, false)
end

function ContractNewestPetView:_onClickVoice()
	self.petCvViewOnShow = true

	self:_refresh()
end

function ContractNewestPetView:_updateCell(idx, cell)
	if idx ~= self._curIndex then
		self._curIndex = idx

		self:_refresh()
		PetCvController.instance:turnOffCurCv()
	end

	self.raceId = ContractNewestPetModel.instance:getIndexPet(self._curIndex).raceId

	local petPhotoShow = PetPhotoShow.Get(cell.gameObject)

	ContractNewestPetModel.instance:setSelectedPet(self.raceId)
	petPhotoShow:showPetEffect(self.raceId, self._isLihui, 4, "handbook")

	self._curPetPhotoShow = petPhotoShow

	table.insert(self._petPhotoShows, petPhotoShow)
end

function ContractNewestPetView:_onClickCell()
	local pos = self._bubble.transform.position

	PetCvController.instance:playPetCv(self.raceId, nil, true, pos)

	if self._curPetPhotoShow then
		self._curPetPhotoShow:playShowAnim()
	end
end

function ContractNewestPetView:_onCloseCVviewCallback(hover)
	if not hover and self.petCvViewOnShow then
		self.petCvViewOnShow = false

		AudioVoicePlayer.instance:playVoiceByEvt(nil)
		self:_refresh()
	end
end

function ContractNewestPetView:_refreshContractInfo(petCfg)
	self:_resetContractInfo()

	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(petCfg.raceId)

	if checknumber(petSkinCfg.summonSkillId) > 0 then
		MaterialMgr.setCell(MatType.Skill, petSkinCfg.summonSkillId, self.skillicon)

		self.txtSkillName.text = ""
		self.txtSkillDesc.text = ""

		local cfg = MaterialMgr.getMatCfg(MatType.Skill, petSkinCfg.summonSkillId)

		if cfg then
			self.txtSkillName.text = cfg.name
			self.txtSkillDesc.text = cfg.desc
		end
	else
		self.txtSkillName.text = ""
		self.txtSkillDesc.text = ""

		MaterialMgr.resetAll(self.skillicon)
	end
end

function ContractNewestPetView:_resetContractInfo()
	self.txtSkillName.text = ""
	self.txtSkillDesc.text = ""

	MaterialMgr.resetAll(self.skillicon)
end

function ContractNewestPetView:_showContractPetList(raceId)
	local summonList = ContractConfig.instance:getSummonBySummonMasterId(raceId)
	local list = {}

	for i, v in ipairs(summonList) do
		local cfgContract = ContractConfig.instance:getGroupCfg(raceId, v.summonRaceId)

		if cfgContract then
			local element = {}

			element.masterId = raceId
			element.summonId = v.summonRaceId
			element.cfg = cfgContract

			table.insert(list, element)
		end
	end

	self.scrollList:reloadData(list)
	self.scrollList:getView():MoveCellInView(0, false)
end

function ContractNewestPetView:_updatePetCell(view, cell, data, tag)
	local icon = goutil.findChild(cell, "icon")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local imgNew = goutil.findChild(cell, "imgNew")

	MaterialMgr.setCell(MatType.Pet, data.summonId, icon)

	txtName.text = MaterialMgr.getMaterialsName(MatType.Pet, data.summonId)

	goutil.setActive(imgNew, checknumber(data.cfg.isNewTwo) == 1)
end

function ContractNewestPetView:_clearPetCell(cell)
	local icon = goutil.findChild(cell, "icon")

	MaterialMgr.resetAll(icon)
end

return ContractNewestPetView
