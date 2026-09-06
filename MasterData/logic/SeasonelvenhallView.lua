-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonelvenhallView.lua

module("logic.extensions.season.view.SeasonelvenhallView", package.seeall)

local SeasonelvenhallView = class("SeasonelvenhallView", ViewComponent)

function SeasonelvenhallView:ctor()
	SeasonelvenhallView.super.ctor(self)
end

function SeasonelvenhallView:unbindEvents()
	SeasonelvenhallView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	self._inputSearch:RemoveOnValueChanged()
	self._filterButton:RemoveClickListener()
	self._InputC_Search_Clear:RemoveClickListener()

	for i, v in ipairs(self.dropHashList) do
		local go = self.cellList[i]

		DropHandler.Get(go.gameObject):RemoveLuaHandler(v)
	end

	self._btnTip:RemoveClickListener()
end

function SeasonelvenhallView:bindEvents()
	SeasonelvenhallView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	self._inputSearch:AddOnValueChanged(self._OnSearchTextChanged, self)
	self._filterButton:AddClickListener(self._onClickFilter, self)
	self._InputC_Search_Clear:AddClickListener(self.onClearSearchClick, self)
	self._btnTip:AddClickListener(self._onClickTip, self)

	self.dropHashList = {}

	for i, v in ipairs(self.cellList) do
		local dropHash = DropHandler.Get(v.gameObject):AddLuaHandler(function(_go, eventData)
			self:_OnDropLeftCell(_go, eventData, i)
		end)

		table.insert(self.dropHashList, dropHash)
	end
end

function SeasonelvenhallView:buildUI()
	SeasonelvenhallView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.cellList = {}

	for i = 1, 3 do
		local cell = self:getGo("info/pos/cell_" .. i)

		table.insert(self.cellList, cell)
	end

	self._petList = self:getGo("petList")
	self._inputSearch = self:getInput("petList/InputField")
	self._InputC_Search_Clear = self:getBtn("petList/InputField/btnCancel")
	self._filterButton = self:getBtn("petList/btnFliter")
	self.txtRemain = self:getTxt("petList/remain/txt")
	self.dragPetGo = self:getGo("petgo")
	self.dragImageBg = self:getGo("petgo/ImgC_Bg")
	self.dragImage = self:getGo("petgo/ImgC_HeadIcon/con")

	GameUtil.SetActive(self.dragPetGo, false)

	self.empty = self:getGo("petList/empty")
	self.tableviewPet = self:getGo("petList/tableview")
	self.pet = self:getGo("petList/pet")
	self._btnTip = self:getBtn("btnTip")
	self.scrollList = ScrollerList.create(self.tableviewPet, self.pet, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))

	self.scrollList:setDragCallBack("top", GameUtil.handler(self._onDragBegin, self), GameUtil.handler(self._onDragMove, self), GameUtil.handler(self._onDragEnd, self))
end

function SeasonelvenhallView:onExit()
	SeasonelvenhallView.super.onExit(self)

	self.curDrapPetMo = nil

	self.scrollList:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.SeasonHirePetInfo, self.onRefreshUI, self)
end

function SeasonelvenhallView:onEnter()
	SeasonelvenhallView.super.onEnter(self)

	self.curDrapPetMo = nil

	self:onRefreshUI()
	GlobalDispatcher:addListener(GlobalNotify.SeasonHirePetInfo, self.onRefreshUI, self)
	SeasonController.instance:sendGetHirePetInfo()
	GameUtil.SetActive(self._petList, true)
	GameUtil.SetActive(self._btnTip, true)
end

function SeasonelvenhallView:onRefreshUI()
	local list = {}

	if not SeasonPetsModel.instance.petdefineids then
		for i, v in ipairs(SeasonPetsModel.instance.petdefineids) do
			local mo = SeasonPetsModel.instance:createHirePetMo(v)

			if mo then
				mo.petId = v

				table.insert(list, mo)
			end
		end

		self.allData = list

		local total = SeasonPetsModel.instance.maxTimes

		self.txtRemain.text = langPara("剩余可租借次数：%s/%s", SeasonPetsModel.instance.leftTimes, total)

		if not SeasonPetsModel.instance.infos then
			self.hireList = {}

			for i, v in ipairs(SeasonPetsModel.instance.infos) do
				local mo = SeasonPetsModel.instance:createHirePetMo(v.petDefineId)

				if mo then
					mo.petId = v.petDefineId
					self.hireList[v.slotId] = mo
				end
			end

			self:_RefreshPetList()

			for i, cell in ipairs(self.cellList) do
				GameUtil.SetActive(cell, true)
				self:updateCellByOtherInfo(cell, self.hireList[i])
			end
		end
	end
end

function SeasonelvenhallView:clearCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function SeasonelvenhallView:_updateCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")
	local skinId = data.curFaceId
	local proxy = MaterialMgr.setCell(MatType.Pet, skinId, con)

	if proxy then
		proxy.binder:setAutoTips(false)
	end

	local isGray = false

	for _, v in pairs(self.hireList) do
		if skinId == v.curFaceId then
			isGray = true

			break
		end
	end

	GameUtil.SetGray(con, isGray)
	GameUtil.addClickHandler(cell, GameUtil.handler(self.onClickPetCell, self, data, cell))
end

function SeasonelvenhallView:_onDragBegin(eventData, data)
	self:showDragPet(data)
end

function SeasonelvenhallView:_onDragMove(eventData, data)
	self.dragPetGo.transform.position = uGuiUtil.GetTouchWorldPosition()
end

function SeasonelvenhallView:_onDragEnd(eventData, data)
	self:hideDragPet(data)
end

function SeasonelvenhallView:showDragPet(petMo, dropGo)
	self:hideDragPet()
	GameUtil.SetActive(self.dragPetGo, true)

	self.dragPetGo.transform.position = uGuiUtil.GetTouchWorldPosition()

	local rare = CharacterConfig.instance:getRareByAwakenLv(petMo.awakeLevel, petMo.raceId)

	GameUtil.setUIImageSpriteIdx(self.dragImageBg, rare + 1)
	MaterialMgr.setIcon(self.dragImage, MatType.PET_SKIN, petMo.curFaceId)

	self.curDrapPetMo = petMo
end

function SeasonelvenhallView:hideDragPet()
	MaterialMgr.clearIcon(self.dragImage)
	GameUtil.SetActive(self.dragPetGo, false)

	self.curDrapPetMo = nil
end

function SeasonelvenhallView:_OnDropLeftCell(go, eventData, idx)
	if self.curDrapPetMo ~= nil then
		if SeasonPetsModel.instance.leftTimes > 0 then
			local temPetMo = self.curDrapPetMo
			local mo = self.hireList[idx]
			local isRepeat = false

			for i, v in pairs(self.hireList) do
				if temPetMo.curFaceId == v.curFaceId then
					isRepeat = true

					break
				end
			end

			if not isRepeat then
				if mo then
					TipsFacade.instance:openSeasonPopupWindow(lang("tip"), langPara("确认要替换已经租借的%s吗？", mo.name), function()
						self:sendHirePet(idx, temPetMo)
					end)
				else
					TipsFacade.instance:openSeasonPopupWindow(lang("tip"), langPara("确认要租借%s精灵吗？", temPetMo.name), function()
						self:sendHirePet(idx, temPetMo)
					end)
				end
			else
				TipsFacade.instance:openCommonTips(lang("同只精灵只能租借一次"))
			end
		else
			TipsFacade.instance:openCommonTips(lang("你已经没有剩余的可租借次数了"))
		end
	end

	self:hideDragPet()
end

function SeasonelvenhallView:sendHirePet(idx, mo)
	local petDefineId = mo.petId

	SeasonController.instance:sendHirePetByIdx(idx, petDefineId)
end

function SeasonelvenhallView:updateCellByOtherInfo(cell, data)
	local info = goutil.findChild(cell, "info")
	local empty = goutil.findChild(cell, "empty")

	GameUtil.SetActive(info, false)
	GameUtil.SetActive(empty, false)
	GameUtil.rmClickHandler(cell)

	if data then
		GameUtil.SetActive(info, true)

		local pet = goutil.findChild(info, "pet/con")
		local attr = goutil.findChild(info, "attr/con")
		local txtLevel = goutil.findChildTextComponent(info, "txtLevel")
		local job = goutil.findChild(info, "job")
		local job1 = goutil.findChild(info, "job1")
		local txtRemain = goutil.findChildTextComponent(info, "remain/txt")

		txtRemain.text = ""

		local petMo = data
		local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(petMo.curFaceId)
		local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(petMo.curFaceId)

		GameUtil.setUIImageSpriteIdx(job, firstJobIdx - 1)
		GameUtil.SetActive(job1, false)

		if secondJobIdx > 20 then
			GameUtil.SetActive(job1, true)
			GameUtil.setUIImageSpriteIdx(job1, secondJobIdx - 1 - 20)
		end

		local race = PetSkinConfig.instance:getFisrtEleAttrIdx(petMo.curFaceId)

		race = race % 10

		local targetValue = race - 1

		GameUtil.setUIImageSpriteIdx(attr, targetValue)

		local modelCo = CharacterConfig.instance:getModelCo(checknumber(petMo.curFaceId))

		uGuiUtil.setSpriteToImage(pet.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

		txtLevel.text = "Lv." .. petMo.level

		GameUtil.addClickHandler(cell, GameUtil.handler(self.onClickPetCell, self, petMo, cell))

		txtRemain.text = petMo.name

		GameUtil.SetActive(job, false)
		GameUtil.SetActive(job1, false)
	else
		GameUtil.SetActive(empty, true)
	end
end

function SeasonelvenhallView:onClickPetCell(petMo, cell)
	local goOrPos

	CommonTipsMgr.instance:showBuddyHirePetTips(petMo, BuddyhiredetailView.TYPE_HIRE_INFO, goOrPos, nil)
end

function SeasonelvenhallView:updateFilterData(starList, jobList, rareList)
	self:_RefreshPetList()
end

function SeasonelvenhallView:_RefreshPetList(force)
	self._curViewDatas = {}

	for k, v in pairs(self.allData) do
		if self:onFilter(v) then
			self._curViewDatas[#self._curViewDatas + 1] = v
		end
	end

	ArraySort.sortOn(self._curViewDatas, "zdl", ArraySort.DESCENDING)
	self.scrollList:reloadData(self._curViewDatas)
	GameUtil.SetActive(self.empty, #self._curViewDatas == 0)
end

function SeasonelvenhallView:onFilter(petMo)
	local petCo = MaterialMgr.getMatCfg(MatType.Pet, petMo.raceId)
	local isHit = false
	local maxAwaken = CharacterConfig.instance:getMaxAwaken(petMo.raceId)
	local rare = CharacterConfig.instance:getRareByAwakenLv(maxAwaken, petMo.raceId)

	isHit = self:_isMatch(petCo, rare, petMo.curFaceId)

	if not string.nilorempty(self._currSearching) then
		local str = StringUtil.RelpaceEscapeChar(self._currSearching)
		local count = string.find(petCo.name, str)

		if not count then
			return false
		end
	end

	return isHit
end

function SeasonelvenhallView:_isMatch(cfg, rare, skinId)
	return PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_SEASON_HIRE, cfg, rare, skinId)
end

function SeasonelvenhallView:_OnSearchTextChanged()
	local text = self._inputSearch:GetText()

	if text ~= self._currSearching then
		self._currSearching = text

		self:_RefreshPetList()
	end
end

function SeasonelvenhallView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function SeasonelvenhallView:_onClickFilter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._filterButton.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_SEASON_HIRE, pos, sizeDelta, GameUtil.handler(self.updateFilterData, self))
end

function SeasonelvenhallView:onClearSearchClick()
	self._inputSearch.input.text = ""
end

function SeasonelvenhallView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "SpiritHall_rule")
end

return SeasonelvenhallView
