-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattlespoilsofwarView.lua

module("logic.extensions.lotusbattle.view.LotusbattlespoilsofwarView", package.seeall)

local LotusbattlespoilsofwarView = class("LotusbattlespoilsofwarView", ViewComponent)

function LotusbattlespoilsofwarView:ctor()
	LotusbattlespoilsofwarView.super.ctor(self)
end

function LotusbattlespoilsofwarView:unbindEvents()
	LotusbattlespoilsofwarView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._inputComp:RemoveOnValueChanged()
	self._btnClear:RemoveClickListener()
	self._btnSort:RemoveClickListener()
	self._btnSearch:RemoveClickListener()
end

function LotusbattlespoilsofwarView:bindEvents()
	LotusbattlespoilsofwarView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._inputComp:AddOnValueChanged(self._inputValueChanged, self)
	self._btnClear:AddClickListener(self._onClickbtnClear, self)
	self._btnSort:AddClickListener(self._onClickbtnSort, self)
	self._btnSearch:AddClickListener(self._onClickbtnSearch, self)
end

function LotusbattlespoilsofwarView:buildUI()
	LotusbattlespoilsofwarView.super.buildUI(self)

	self._tableviewGo1 = self:getGo("leftcon/tableView")
	self._tablecellGo1 = self:getGo("leftcon/tablecell")
	self._petScrollerList = ScrollerList.create(self._tableviewGo1, self._tablecellGo1, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._nangtablecellGo = self:getGo("rightcon/tablecell")
	self._nangtableviewGo = self:getGo("rightcon/tableview")
	self._nangScrollerList = ScrollerList.create(self._nangtableviewGo, self._nangtablecellGo, GameUtil.handler(self._updateNangCell, self), GameUtil.handler(self._clearNangCell, self))
	self._btnClose = self:getBtn("btnClose")
	self._inputComp = self:getInput("leftcon/InputSearch")
	self._btnClear = self:getBtn("leftcon/btnClear")
	self._btnSort = self:getBtn("leftcon/btnSort")
	self._btnSearch = self:getBtn("leftcon/btnSearch")
	self._emptyGo = self:getGo("leftcon/empty")
	self._txtEmpty = self:getTxt("leftcon/empty/tipsNull")
end

function LotusbattlespoilsofwarView:onExit()
	LotusbattlespoilsofwarView.super.onExit(self)
	self._petScrollerList:dispose()
end

function LotusbattlespoilsofwarView:onEnter()
	LotusbattlespoilsofwarView.super.onEnter(self)

	self._inSlotRaceId = {}
	self._selectNangIndex = 0
	self._creepsId2num = {}

	self._inputComp:SetText("")
	self:_updateUI()
	self:_setEmptyTips()
end

function LotusbattlespoilsofwarView:_onClickbtnClose()
	local activityId = LotusbattleModel.instance:getActivityId()
	local creepIds = {}

	for k, v in pairs(self._nangSlotDatas) do
		if v.creepId > 0 then
			table.insert(creepIds, v.creepId)
		end
	end

	LotusBattleFieldAgent.instance:sendPM_LBFAdjustPackageReq(activityId, creepIds)
	self:close()
end

function LotusbattlespoilsofwarView:_updatePetCell(view, cell, data, tag)
	local imgChangeImg_attr = goutil.findChild(cell.gameObject, "container/cover/layout/Nego_Attr/Img_attr"):GetComponent(ComponentType.UIImageSpriteChange)
	local imgChangeImgC_Job = goutil.findChild(cell.gameObject, "container/cover/layout/Nego_Job/ImgC_Job"):GetComponent(ComponentType.UIImageSpriteChange)
	local imgChangeImgC_Job1 = goutil.findChild(cell.gameObject, "container/cover/layout/Nego_Job1/ImgC_Job"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtNum = goutil.findChildTextComponent(cell.gameObject, "container/cover/txtNum")
	local goCon = goutil.findChild(cell.gameObject, "container/mask/con")
	local btnContainer = Framework.ButtonAdapter.GetFrom(cell.gameObject, "container")
	local creepsCfg = LotusbattleConfig.instance:getCreepsCfg(data.creepId)
	local faceId = creepsCfg.raceId
	local targetValue = LotusbattleController.instance:getAttrIconIndex(creepsCfg.raceId)

	imgChangeImg_attr:SetState(targetValue)

	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(faceId)
	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(faceId)

	imgChangeImgC_Job:SetState(firstJobIdx - 1)
	goutil.setActive(imgChangeImgC_Job1.gameObject, secondJobIdx > 20)

	if secondJobIdx > 20 then
		imgChangeImgC_Job1:SetState(secondJobIdx - 1 - 20)
	end

	local modelCo = CharacterConfig.instance:getModelCo(faceId)

	uGuiUtil.setSpriteToImage(goCon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	local c2n = self._creepsId2num[data.creepId]

	if c2n then
		if not c2n.currNum then
			txtNum.text = data.num

			btnContainer:AddClickListener(function()
				self:_selectPet(data.creepId)
			end)
		end
	end
end

function LotusbattlespoilsofwarView:_clearPetCell(cell)
	local goCon = goutil.findChild(cell.gameObject, "container/mask/con")

	uGuiUtil.clearImage(goCon)
end

function LotusbattlespoilsofwarView:_updateNangCell(view, cell, data, tag)
	local btnAdd = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnAdd")
	local goItemcon = goutil.findChild(cell.gameObject, "itemcon")
	local goLock = goutil.findChild(cell.gameObject, "lock")
	local goSelect = goutil.findChild(cell.gameObject, "select")
	local isEmpty = data.status ~= LotusbattlemainView.NangLockStatus.Lock and data.creepId <= 0
	local isLock = data.status == LotusbattlemainView.NangLockStatus.Lock
	local hasPet = data.status ~= LotusbattlemainView.NangLockStatus.Lock and data.creepId > 0

	MaterialMgr.resetAll(goItemcon)
	goutil.setActive(goLock, isLock)
	goutil.setActive(goItemcon, not isEmpty)
	goutil.setActive(btnAdd.gameObject, isEmpty)
	goutil.setActive(goSelect, self._selectNangIndex == cell.data)

	if hasPet then
		local creepsCfg = LotusbattleConfig.instance:getCreepsCfg(data.creepId)
		local cfgStr = string.format("%s:%s", MatType.Pet, creepsCfg.raceId)
		local proxy = MaterialMgr.setCellByCfg(cfgStr, goItemcon)

		proxy.binder:setAutoTips(false)
		proxy.binder:setCallBack(function()
			self:_selectNang(cell.data)
		end)
	end

	btnAdd:AddClickListener(function()
		if isLock then
			LotusbattleController.instance:tryUnlockNangGrid()

			return
		end

		self:_selectNang(cell.data)
	end)
end

function LotusbattlespoilsofwarView:_selectNang(index)
	local slotData = self._nangSlotDatas[index]

	if self._selectNangIndex <= 0 or self._selectNangIndex ~= index then
		self._selectNangIndex = index
		slotData.creepId = 0

		FloatWordMgr.instance:show("请在左侧选择精灵添加进入该位置")
	elseif slotData.creepId > 0 then
		slotData.creepId = 0
	else
		self._selectNangIndex = 0
	end

	self._nangScrollerList:refresh()
	self:_updatePets()
end

function LotusbattlespoilsofwarView:_clearNangCell(cell)
	local goItemcon = goutil.findChild(cell.gameObject, "itemcon")

	MaterialMgr.resetAll(goItemcon)
end

function LotusbattlespoilsofwarView:_updateUI()
	self:_updateNang()
end

function LotusbattlespoilsofwarView:_updatePets()
	self._creepsId2num = {}

	local list = LotusbattleModel.instance:getPackagePets()

	for i, v in ipairs(list) do
		self._creepsId2num[v.creepId] = {
			oriNum = v.num,
			currNum = v.num
		}
	end

	local packageList = LotusbattleModel.instance:getPackageCreepIds()

	for i, creepId in ipairs(packageList) do
		if not self._creepsId2num[creepId] then
			self._creepsId2num[v.creepId] = {
				currNum = 1,
				oriNum = 1
			}
		end
	end

	local finalList = self:_getFilterPets(list)

	finalList = self:_getModPetsNumByNang(finalList)

	self._petScrollerList:reloadData(finalList)
	goutil.setActive(self._emptyGo, #finalList <= 0)
end

function LotusbattlespoilsofwarView:_getFilterPets(petsStruct)
	local finalList = {}

	if not string.nilorempty(self._searchInputStr) then
		for i, v in ipairs(petsStruct) do
			local creepsCfg = LotusbattleConfig.instance:getCreepsCfg(v.creepId)

			if string.find(creepsCfg.creepsName, self._searchInputStr) then
				table.insert(finalList, v)
			end
		end
	else
		finalList = petsStruct
	end

	return finalList
end

function LotusbattlespoilsofwarView:_getModPetsNumByNang(petsStruct)
	local finalList = {}
	local nangKV = {}

	for i, v in ipairs(self._nangSlotDatas or {}) do
		if v.creepId > 0 then
			nangKV[v.creepId] = true
		end
	end

	for i, v in ipairs(petsStruct) do
		if nangKV[v.creepId] then
			self._creepsId2num[v.creepId].currNum = self._creepsId2num[v.creepId].oriNum - 1
		end

		if self._creepsId2num[v.creepId].currNum > 0 then
			table.insert(finalList, v)
		end
	end

	return finalList
end

function LotusbattlespoilsofwarView:_updateNang()
	self._nangSlotDatas = LotusbattleModel.instance:getNangSlotDatas()

	self._nangScrollerList:reloadData(self._nangSlotDatas)
	self:_updatePets()
end

function LotusbattlespoilsofwarView:_selectPet(creepId)
	local hasSameRaceId = false
	local hasEmptySlot = false
	local creepsCfg = LotusbattleConfig.instance:getCreepsCfg(creepId)

	for k, v in pairs(self._nangSlotDatas) do
		if not hasEmptySlot and v.status ~= LotusbattlemainView.NangLockStatus.Lock and v.creepId <= 0 then
			hasEmptySlot = true
		end

		if v.creepId > 0 then
			local creeps = LotusbattleConfig.instance:getCreepsCfg(v.creepId)

			if creeps.raceId == creepsCfg.raceId then
				hasSameRaceId = true
			end
		end
	end

	if self._selectNangIndex > 0 then
		local slotData = self._nangSlotDatas[self._selectNangIndex]

		if slotData.creepId == creepId then
			FloatWordMgr.instance:show("已在囊位中")

			return
		end

		if slotData.creepId > 0 then
			local creeps = LotusbattleConfig.instance:getCreepsCfg(slotData.creepId)

			if hasSameRaceId and creeps.raceId ~= creepsCfg.raceId then
				FloatWordMgr.instance:show("不能重复放入相同精灵")

				return
			end
		elseif hasSameRaceId then
			FloatWordMgr.instance:show("不能重复放入相同精灵")

			return
		end

		slotData.creepId = creepId

		self._nangScrollerList:refresh()
	else
		if not hasEmptySlot then
			FloatWordMgr.instance:show("先选择要替换的囊物")

			return
		end

		if hasSameRaceId then
			FloatWordMgr.instance:show("不能重复放入相同精灵")

			return
		end

		for k, v in ipairs(self._nangSlotDatas) do
			if v.creepId <= 0 and v.status ~= LotusbattlemainView.NangLockStatus.Lock then
				v.creepId = creepId

				break
			end
		end

		self._nangScrollerList:refresh()
	end

	self:_updatePets()
end

function LotusbattlespoilsofwarView:_inputValueChanged(text)
	if text ~= self._searchInputStr then
		self._searchInputStr = text

		self:_updatePets()
	end
end

function LotusbattlespoilsofwarView:_onClickbtnClear()
	self._inputComp:SetText("")
end

function LotusbattlespoilsofwarView:_onClickbtnSort()
	FloatWordMgr.instance:show("没实现")
end

function LotusbattlespoilsofwarView:_onClickbtnSearch()
	FloatWordMgr.instance:show("没实现")
end

function LotusbattlespoilsofwarView:_setEmptyTips()
	local activityId = LotusbattleModel.instance:getActivityId()
	local modelCfgs = LotusbattleConfig.instance:getModelCfgs(activityId)
	local model1_num = modelCfgs[1].memberNum
	local model2_num = modelCfgs[2].memberNum
	local model1_rank = modelCfgs[1].spoilsRank <= 1 and "第一名" or "前" .. modelCfgs[1].spoilsRank
	local model2_rank = modelCfgs[2].spoilsRank <= 1 and "第一名" or "前" .. modelCfgs[2].spoilsRank

	self._txtEmpty.text = string.format("暂无战利品\n%s人模式%s或%s人模式%s可获得", model1_num, model1_rank, model2_num, model2_rank)
end

return LotusbattlespoilsofwarView
