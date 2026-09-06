-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petlease/view/PetLeaseView.lua

module("logic.extensions.petlease.view.PetLeaseView", package.seeall)

local PetLeaseView = class("PetLeaseView", TableViewComponent)

function PetLeaseView:ctor()
	PetLeaseView.super.ctor(self)

	self._isOpenHireTab = false
	self._petCellList = nil
	self._petModelList = nil
	self._choiPetList = nil
	self._emptyCount = 0
	self.clickTimer = 0
end

function PetLeaseView:buildUI()
	PetLeaseView.super.buildUI(self)

	self.closeBtn = self:getBtn("closeBtn")
	self.tipsBtn = self:getBtn("tipsBtn")
	self.rentTabBtn = self:getBtn("rentTabBtn")
	self.rentTabGro = self:getGo("rentTabBtn"):GetComponent("UIChangeGroup")
	self.rentRedGo = self:getGo("rentTabBtn/rentRedGo")
	self.hireTabBtn = self:getBtn("hireTabBtn")
	self.hireTabGro = self:getGo("hireTabBtn"):GetComponent("UIChangeGroup")
	self.hireRedGo = self:getGo("hireTabBtn/hireRedGo")

	GameUtil.SetActive(self.rentRedGo, false)
	GameUtil.SetActive(self.hireRedGo, false)

	local allPetsGo = self:getGo("allPetsGo")
	local petCellTran = goutil.findChild(allPetsGo, "petCellTran").transform

	self.petHelpBtn = Framework.ButtonAdapter.GetFrom(allPetsGo, "petHelpBtn")
	self.petHelpTxt = goutil.findChildTextComponent(allPetsGo, "petHelpBtn/petHelpTxt")
	self.helpImaGo = goutil.findChild(allPetsGo, "helpImaGo")
	self.desTxt = goutil.findChildTextComponent(allPetsGo, "desTxt")
	self.timeTxt = goutil.findChildTextComponent(allPetsGo, "timeTxt")
	self.noPetListGo = goutil.findChild(allPetsGo, "noPetListGo")
	self.petHelpTxt.text = ""
	self.desTxt.text = ""
	self.timeTxt.text = ""

	GameUtil.SetActive(self.helpImaGo, false)
	GameUtil.SetActive(self.noPetListGo, false)

	self._petCellList = {}

	for i = 1, 3 do
		local go = petCellTran:GetChild(i - 1)

		if go ~= nil then
			local names = string.split(go.name, "_")
			local var_2_0 = checknumber(names[2])
			local var_2_1 = {
				itemGo = go,
				modelGo = goutil.findChild(go, "modelGo"),
				emptyGo = goutil.findChild(go, "emptyGo"),
				petNameGo = goutil.findChild(go, "petNameGo"),
				petNameTxt = goutil.findChildTextComponent(go, "petNameGo/petNameTxt"),
				petPowerGo = goutil.findChild(go, "petPowerGo")
			}

			var_2_1.powerTxt = goutil.findChild(go, "petPowerGo/powerTxt"):GetComponent(ComponentType.UIImgNumeralText)
			self._petCellList[var_2_0] = var_2_1

			GameUtil.SetActive(self._petCellList[checknumber(names[2])].petNameGo, false)
			GameUtil.SetActive(self._petCellList[checknumber(names[2])].petPowerGo, false)
			GameUtil.SetActive(self._petCellList[checknumber(names[2])].emptyGo, false)
		end
	end
end

function PetLeaseView:bindEvents()
	PetLeaseView.super.bindEvents(self)
	self.closeBtn:AddClickListener(self.close, self)
	self.tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "petlease")
	end, self)
	self.rentTabBtn:AddClickListener(function()
		self:_ClickViewTableBtn(false, false)
	end, self)
	self.hireTabBtn:AddClickListener(function()
		self:_ClickViewTableBtn(true, false)
	end, self)
	self.petHelpBtn:AddClickListener(self._ClickPetHelpBtn, self)

	if self._petCellList and #self._petCellList > 0 then
		for i = 1, #self._petCellList do
			if self._petCellList[i] and self._petCellList[i].itemGo then
				local posNum = i

				GameUtil.asBtn(self._petCellList[i].itemGo):AddClickListener(function()
					self:_ClickPetCellBtn(posNum)
				end)
			end
		end
	end
end

function PetLeaseView:unbindEvents()
	PetLeaseView.super.unbindEvents(self)
	self.closeBtn:RemoveClickListener()
	self.tipsBtn:RemoveClickListener()
	self.rentTabBtn:RemoveClickListener()
	self.hireTabBtn:RemoveClickListener()
	self.petHelpBtn:RemoveClickListener()

	for _, item in pairs(self._petCellList or {}) do
		if item and item.itemGo then
			GameUtil.asBtn(item.itemGo):RemoveClickListener()
		end
	end
end

function PetLeaseView:onExit()
	PetLeaseView.super.onExit(self)
	removetimer(self._CalculationSurplusTime, self)
	GlobalDispatcher:removeListener("UpdataPetLeaseData", self._UpdataViewShowData, self)

	for _, obj in pairs(self._petModelList or {}) do
		if obj and obj.loader and obj.asset then
			RoleObjectPool.instance:removeRole(obj)
		end
	end

	self._petModelList = nil
	self._choiPetList = nil
	self.clickTimer = 0
	self._emptyCount = 0
end

function PetLeaseView:destroyUI()
	PetLeaseView.super.destroyUI(self)

	self._petCellList = nil
end

function PetLeaseView:onEnter()
	PetLeaseView.super.onEnter(self)
	GlobalDispatcher:addListener("UpdataPetLeaseData", self._UpdataViewShowData, self)

	if self._viewPresentor._openParam and self._viewPresentor._openParam[1] then
		local tabIndex = self._viewPresentor._openParam[1]

		self._isOpenHireTab = checknumber(tabIndex) == 2
	else
		self._isOpenHireTab = PetLeaseModel.instance._isOpenHireTab
	end

	self._commonCfgs = PetLeaseConfig.instance:GetCommonCfgs()

	self:_UpdataViewShowData()
	PetLeaseController.instance:CSRequestRentPetsInfo()
end

function PetLeaseView:_UpdataViewShowData()
	GameUtil.SetActive(self.hireRedGo, PetLeaseModel.instance:GetMyHirePetsRedPoint())
	GameUtil.SetActive(self.rentRedGo, PetLeaseModel.instance:GetMyRentPetsRedPoint())
	self:_ClickViewTableBtn(self._isOpenHireTab, true)
end

function PetLeaseView:_ClickViewTableBtn(isHire, isForce)
	if not isForce and self._isOpenHireTab == isHire then
		return
	end

	removetimer(self._CalculationSurplusTime, self)

	self.timeTxt.text = ""
	self._isOpenHireTab = isHire

	local posCount = 1

	self._petInfoList = {}
	self._curViewDatas = {}

	if self._isOpenHireTab then
		self.petHelpTxt.text = "租借精灵"

		self.rentTabGro:SetState(0)
		self.hireTabGro:SetState(1)

		local data = PetLeaseModel.instance:GetMyHirePetsInfo()

		self.endTime = data and checknumber(data.expireTime) or 0

		if checknumber(self.endTime) > 0 then
			self.endTime = self.endTime / 1000
		end

		self.desTxt.text = lang("pet_hire_tips")
		posCount = self._commonCfgs.hirePosCount

		if data and data.petInfoList then
			self._petInfoList = data.petInfoList
		end

		self._curViewDatas = PetLeaseModel.instance:GetMyHirePetsList()

		settimer(1, self._CalculationSurplusTime, self, true)
	else
		self.petHelpTxt.text = "出租精灵"

		self.rentTabGro:SetState(1)
		self.hireTabGro:SetState(0)

		self.desTxt.text = lang("pet_rent_tips")
		posCount = self._commonCfgs.rentPosCount
		self._petInfoList = PetLeaseModel.instance:GetMyRentPetsInfo()
		self._curViewDatas = PetLeaseModel.instance:GetMyRentPetsList()
	end

	self._choiPetList = {}
	self._emptyCount = 0

	for i = 1, posCount do
		if self._petInfoList[i] == nil or self._petInfoList[i].info == nil then
			self._emptyCount = self._emptyCount + 1
		end
	end

	for _, obj in pairs(self._petModelList or {}) do
		if obj and obj.loader and obj.asset then
			RoleObjectPool.instance:removeRole(obj)
		end
	end

	if self._curViewDatas and #self._curViewDatas > 0 then
		GameUtil.SetActive(self.noPetListGo, false)
		GameUtil.SetActive(self.petHelpBtn, self._emptyCount > 0)
	else
		GameUtil.SetActive(self.noPetListGo, true)
		GameUtil.SetActive(self.petHelpBtn, false)
	end

	GameUtil.SetActive(self.helpImaGo, self._emptyCount <= 0)
	self._tableview:ReloadData()

	self._petModelList = {}

	if self._petCellList and #self._petCellList > 0 then
		for i = 1, #self._petCellList do
			if self._petCellList[i] and self._petCellList[i].itemGo then
				if i <= posCount then
					if self._petInfoList[i] then
						GameUtil.SetActive(self._petCellList[i].emptyGo, false)

						local loader = self:_ShowRoleModelInfo(i, self._petInfoList[i].info.raceId, self._petCellList[i].modelGo)

						if loader then
							self._petModelList[i] = loader
						end

						GameUtil.SetActive(self._petCellList[i].petNameGo, true)
						GameUtil.SetActive(self._petCellList[i].petPowerGo, true)

						if string.nilorempty(self._petInfoList[i].info.name) then
							local petCfg = MaterialMgr.getMatCfg(MatType.Pet, self._petInfoList[i].info.raceId)

							if petCfg then
								self._petCellList[i].petNameTxt.text = petCfg.name or "精灵"
							end
						else
							self._petCellList[i].petNameTxt.text = self._petInfoList[i].info.name
						end

						self._petCellList[i].powerTxt:SetNum(self._petInfoList[i].power)
					else
						self._petCellList[i].petNameTxt.text = ""

						self._petCellList[i].powerTxt:SetNum(0)
						GameUtil.SetActive(self._petCellList[i].petNameGo, false)
						GameUtil.SetActive(self._petCellList[i].petPowerGo, false)
						GameUtil.SetActive(self._petCellList[i].emptyGo, true)
					end
				else
					GameUtil.SetActive(self._petCellList[i].itemGo, false)
				end
			end
		end
	end
end

function PetLeaseView:_CalculationSurplusTime()
	local supTime = checknumber(self.endTime) - ServerTime.nowServerLook()

	if supTime <= 0 then
		self.timeTxt.text = ""

		return
	end

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(supTime)

	self.timeTxt.text = day > 0 and string.format("重置倒计时： %s天%s时%s分", day, hour, min) or string.format("重置倒计时： %s时%s分%s秒", hour, min, sec)
end

function PetLeaseView:_PreventTooFastClick()
	if checknumber(self.clickTimer) <= 0 then
		self.clickTimer = ServerTime.now()
	else
		local now = ServerTime.now()

		if now - self.clickTimer < 2 then
			return
		end

		self.clickTimer = now
	end

	return true
end

function PetLeaseView:_ShowRoleModelInfo(posNum, petId, modelGo)
	if self._petModelList and self._petModelList[posNum] then
		RoleObjectPool.instance:removeRole(self._petModelList[posNum])

		self._petModelList[posNum] = nil
	end

	if checknumber(petId) <= 0 or checknumber(posNum) <= 0 or modelGo == nil then
		return
	end

	local petCfg = CharacterConfig.instance:getPetCo(petId)

	if petCfg == nil then
		printError("sr---PetLeaseView:_ShowRoleModelInfo()    精灵配置为空 = " .. petId)

		return
	end

	return RoleObjectPool.instance:addRoleToParent(loader, petCfg.faceIds, modelGo, scale, function(go)
		if go ~= nil then
			local modelCfg = CharactorFacade.instance:getHandbookLihuiModelUIPosAndScale(petCfg.faceIds)

			if not modelCfg[3] then
				Framework.TransformUtil.SetLocalPos(go.transform, 0, 0, 0)
				Framework.TransformUtil.SetLocalScale(go.transform, modelCfg[3] * 0.25, modelCfg[3] * 0.25, modelCfg[3] * 0.25)
			end
		end
	end)
end

function PetLeaseView:_ClickPetHelpBtn()
	if self._emptyCount < 0 then
		FloatWordMgr.instance:show("槽位已满，不可再操作！")

		return
	end

	local list = {}

	for _, mo in pairs(self._choiPetList or {}) do
		if mo and mo.info then
			table.insert(list, mo)
		end
	end

	if #list == 0 then
		FloatWordMgr.instance:show("请选择精灵！！")

		return
	end

	if self._isOpenHireTab then
		if not self._commonCfgs.hirePosCount then
			local posCount = self._commonCfgs.rentPosCount
			local reqList = {}
			local index = 0
			local names = {}

			for i = 1, posCount do
				if self._petInfoList[i] == nil or self._petInfoList[i].info == nil then
					index = index + 1

					if list and list[index] then
						if self._isOpenHireTab then
							local petCfg = MaterialMgr.getMatCfg(MatType.Pet, list[index].info.raceId)

							if petCfg and not string.nilorempty(petCfg.name) then
								table.insert(names, petCfg.name)
							end

							table.insert(reqList, {
								slotId = i,
								leaseUserId = list[index].info.userId,
								leasePetId = list[index].info.petId
							})
						else
							table.insert(reqList, {
								slotId = i,
								petId = list[index].info.petId
							})
						end
					end
				end
			end

			if reqList == nil or #reqList == 0 then
				printError("sr--- PetLeaseView:_ClickPetHelpBtn()  选择租借or出租精灵有问题！")

				return
			end

			if self._isOpenHireTab then
				local str = #names > 0 and table.concat(names, "、") or "精灵"
				local desStr = langPara("pet_hire_sure", str)

				TipsFacade.instance:openPopupWindow("租借提示", desStr, function()
					PetLeaseController.instance:CSRequestHireUserPet(reqList)
				end, nil, "确定", "取消", UnityEngine.TextAnchor.MiddleCenter)
			else
				PetLeaseController:CSRequestRentMyPet(reqList)
			end
		end
	end
end

function PetLeaseView:_ClickPetCellBtn(posNum)
	if self._isOpenHireTab then
		return
	end

	if self._petInfoList == nil or self._petInfoList[posNum] == nil then
		return
	end

	local petMo = self._petInfoList[posNum]
	local desStr = string.format("是否将已出租的精灵<color=#eb4642>%s</color>撤回？", petMo.info.name)

	TipsFacade.instance:openPopupWindow("租借提示", desStr, function()
		PetLeaseController.instance:CSRequestTakeOffRentMyPet(posNum)
	end, nil, "确定", "取消", UnityEngine.TextAnchor.MiddleCenter)
end

function PetLeaseView:_CreateRewardItems(allCount, redList)
	if #redList > 1 then
		table.sort(redList, function(a, b)
			return a.needCount < b.needCount
		end)
	end

	self._rewardItemList = self._rewardItemList or {}
	self.progressTxt.text = self.useCount .. "/" .. allCount

	local index = 0
	local oncW = 882 / #redList

	for i = 1, #redList do
		if self._rewardItemList[i] == nil then
			self._rewardItemList[i] = {}

			local go = goutil.cloneAndSetParent(self.rewardItem, self.allRewardTran)

			self._rewardItemList[i].itemGo = go
			self._rewardItemList[i].smallImaGo = goutil.findChild(go, "smallImaGo")
			self._rewardItemList[i].bigImaGo = goutil.findChild(go, "bigImaGo")
			self._rewardItemList[i].progTxt = goutil.findChildTextComponent(go, "progTxt")
			self._rewardItemList[i].nameTxt = goutil.findChildTextComponent(go, "nameTxt")

			go:SetActive(true)
		end

		if i == #redList then
			Framework.TransformUtil.SetLocalPos(self._rewardItemList[i].itemGo.transform, oncW * i - 448, 0, 0)
			self._rewardItemList[i].smallImaGo:SetActive(false)
			self._rewardItemList[i].bigImaGo:SetActive(true)
			uGuiUtil.setSpriteToImage(self._rewardItemList[i].bigImaGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(redList[i].icon))
		else
			Framework.TransformUtil.SetLocalPos(self._rewardItemList[i].itemGo.transform, oncW * i - 441, 0, 0)
			self._rewardItemList[i].bigImaGo:SetActive(false)
			self._rewardItemList[i].smallImaGo:SetActive(true)
			uGuiUtil.setSpriteToImage(self._rewardItemList[i].smallImaGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(redList[i].icon))
		end

		self._rewardItemList[i].progTxt.text = tostring(redList[i].needCount)
		self._rewardItemList[i].nameTxt.text = redList[i].name

		if redList[i].needCount <= self.useCount and index < i then
			index = i
		end
	end

	if self.useCount <= 0 then
		self.progressSld.value = 0

		return
	end

	if index >= #redList then
		self.progressSld.value = 1

		return
	end

	local offVaule = redList[index + 1].needCount
	local offCount = self.useCount

	if redList[index] then
		offVaule = offVaule - redList[index].needCount
		offCount = offCount - redList[index].needCount
	end

	self.progressSld.value = 1 / #redList * index + offCount * (1 / #redList) / offVaule
end

function PetLeaseView:_getPath()
	return {
		cellPath = "allPetsGo/petItem",
		viewPath = "allPetsGo/petItemSR"
	}
end

function PetLeaseView:_cellSize()
	return 234, 92
end

function PetLeaseView:_updateCell(view, cell, data)
	local petGo = goutil.findChild(cell, "petGo")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local powerTxt = goutil.findChildTextComponent(cell, "powerTxt")
	local selectGo = goutil.findChild(cell, "selectGo")

	GameUtil.asBtn(cell):RemoveClickListener()
	MaterialMgr.resetAll(petGo)

	local hwLua = MaterialMgr.setCell(MatType.Pet, data.info.raceId, petGo)

	hwLua.binder:setNum(1)
	hwLua.binder:setLvl(data.info.level)

	if string.nilorempty(data.info.name) then
		local petCfg = MaterialMgr.getMatCfg(MatType.Pet, data.info.raceId)

		if petCfg then
			nameTxt.text = petCfg.name or "精灵"
		end
	else
		nameTxt.text = data.info.name
	end

	powerTxt.text = tostring(data.power)

	local isChois = false

	if self._choiPetList and self._choiPetList[data.info.petId] then
		GameUtil.SetActive(selectGo, true)

		isChois = true
	else
		GameUtil.SetActive(selectGo, false)

		isChois = false
	end

	GameUtil.asBtn(cell):AddClickListener(function()
		self:_OnClickPetItemBtn(data, isChois)
	end, self)
end

function PetLeaseView:_OnClickPetItemBtn(petMo, isCho)
	if petMo == nil or petMo.info == nil then
		return
	end

	local petId = petMo.info.petId

	self._choiPetList = self._choiPetList or {}

	if isCho and self._choiPetList[petId] then
		self._choiPetList[petId] = nil
		self._emptyCount = self._emptyCount + 1
	else
		if self._emptyCount <= 0 then
			if self._isOpenHireTab then
				FloatWordMgr.instance:show("租用精灵已满！！")
			else
				FloatWordMgr.instance:show("出租精灵已满！！")
			end

			return
		end

		self._emptyCount = self._emptyCount - 1
		self._choiPetList[petId] = petMo
	end

	self._tableview:ReloadData()
end

return PetLeaseView
