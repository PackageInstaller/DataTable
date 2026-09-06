-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/EquipRecycleView.lua

module("logic.extensions.equipment.view.EquipRecycleView", package.seeall)

local EquipRecycleView = class("EquipRecycleView", ViewComponent)

function EquipRecycleView:ctor()
	EquipRecycleView.super.ctor(self)

	self._entranceItemList = nil
	self._curLeftDatas = nil
	self._curRightDatas = nil
	self._matItemList = nil
	self._togItemList = nil
	self._getMatNumList = nil
	self._isChooAll = true
	self._isChooType = nil
	self._exclItemList = nil
	self._getExclList = nil
	self._shqiItemList = nil
end

function EquipRecycleView:bindEvents()
	EquipRecycleView.super.bindEvents(self)
	self.closeBtn:AddClickListener(self.close, self)
	self.tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "equipfactory")
	end, self)
	self.decompseBtn:AddClickListener(self.OnClickDecompseBtn, self)
	self.setQualityBtn:AddClickListener(function()
		if not FuncOpenController.instance:checkFuncIdOrShowLockTips(660) then
			return
		end

		if PetEquipModel.instance.equipRecycleQua == nil or PetEquipModel.instance.equipRecycleQua == -1 then
			FloatWordMgr.instance:show("还未解锁")

			return
		end

		UIStateManager.instance:push(ViewName.EquipRecycleQuality)
	end, self)
	self.decoTog:AddOnValueChanged(function(go, isOn)
		self._isChooAll = not isOn
	end)
end

function EquipRecycleView:unbindEvents()
	EquipRecycleView.super.unbindEvents(self)
	self.closeBtn:RemoveClickListener()
	self.tipsBtn:RemoveClickListener()
	self.decompseBtn:RemoveClickListener()
	self.setQualityBtn:RemoveClickListener()
	self.decoTog:RemoveOnValueChanged()

	for _, tog in pairs(self._togItemList or {}) do
		if tog and tog.itemTog then
			tog.itemTog:RemoveOnValueChanged()
		end
	end
end

function EquipRecycleView:onExit()
	EquipRecycleView.super.onExit(self)
	GlobalDispatcher:removeListener("UpdataEquipRecycleShow", self.UpdataEquipRecycleShow, self)

	self._curLeftDatas = nil
	self._curRightDatas = nil

	for _, item in pairs(self._matItemList or {}) do
		if item then
			MaterialMgr.resetAll(item)
		end
	end

	for _, item in pairs(self._exclItemList or {}) do
		if item then
			MaterialMgr.resetAll(item)
		end
	end

	for _, item in pairs(self._shqiItemList or {}) do
		if item then
			MaterialMgr.resetAll(item)
		end
	end

	self._getMatNumList = nil
	self._getExclList = nil
end

function EquipRecycleView:destroyUI()
	EquipRecycleView.super.destroyUI(self)

	for _, item in pairs(self._togItemList or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self._matItemList = nil
	self._exclItemList = nil
	self._togItemList = nil
	self._isChooAll = true
	self._isChooType = nil
	self._shqiItemList = nil
end

function EquipRecycleView:buildUI()
	EquipRecycleView.super.buildUI(self)

	self.closeBtn = self:getBtn("closeBtn")
	self.tipsBtn = self:getBtn("tipsBtn")

	local leftInfoGo = self:getGo("leftInfoGo")

	self.leftTitleTxt1 = goutil.findChildTextComponent(leftInfoGo, "leftTitleTxt1")
	self._matItemList = {
		goutil.findChild(leftInfoGo, "matItemsGo/matItem_1"),
		goutil.findChild(leftInfoGo, "matItemsGo/matItem_2"),
		goutil.findChild(leftInfoGo, "matItemsGo/matItem_3"),
		goutil.findChild(leftInfoGo, "matItemsGo/matItem_4")
	}
	self._exclItemList = {
		goutil.findChild(leftInfoGo, "matItemsGo/exclItem_1"),
		goutil.findChild(leftInfoGo, "matItemsGo/exclItem_2"),
		goutil.findChild(leftInfoGo, "matItemsGo/exclItem_3"),
		goutil.findChild(leftInfoGo, "matItemsGo/exclItem_4")
	}
	self._shqiItemList = {
		goutil.findChild(leftInfoGo, "matItemsGo/shqiItem_1"),
		goutil.findChild(leftInfoGo, "matItemsGo/shqiItem_2")
	}
	self.leftListSR = goutil.findChild(leftInfoGo, "leftListSR"):GetComponent("UITableview")
	self.leftGo = goutil.findChild(leftInfoGo, "leftGo")

	self.leftGo:SetActive(false)

	self.decompseBtn = Framework.ButtonAdapter.GetFrom(leftInfoGo, "decompseBtn")
	self.setQualityBtn = Framework.ButtonAdapter.GetFrom(leftInfoGo, "setQualityBtn")
	self.decoTogGo = goutil.findChild(leftInfoGo, "decoTogGo")
	self.decoTog = Framework.ToggleAdapter.GetFrom(self.decoTogGo, "decoTog")
	self.leftTitleTxt1.text = ""

	self.decoTogGo:SetActive(false)

	self.filterItemTran = self:getGo("filterItemTran").transform
	self.filterItem = self:getGo("filterItem")

	self.filterItem:SetActive(false)

	self.rightListSR = self:getGo("rightListSR"):GetComponent("UITableview")
	self.rightGo = self:getGo("rightGo")

	self.rightGo:SetActive(false)

	self.notFilterGo = self:getGo("notFilterGo")

	self.notFilterGo:SetActive(false)
	self:_RegistCallbacks()
end

function EquipRecycleView:_RegistCallbacks()
	self.leftListSR:RegisterCallback(self._LeftInView, function()
		return 100, 100
	end, self._LeftAtIndex, self)
	self.leftListSR:RegisterUpdateCellCallback(self._OnLeftCellUpdate)
	self.rightListSR:RegisterCallback(self._RightInView, function()
		return 100, 100
	end, self._RightAtIndex, self)
	self.rightListSR:RegisterUpdateCellCallback(self._OnRightCellUpdate)
end

function EquipRecycleView:_LeftInView()
	if not self._curLeftDatas then
		return 0
	end

	return #self._curLeftDatas
end

function EquipRecycleView:_LeftAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self.leftGo)

	local data = self._curLeftDatas[index + 1]

	cell.data = index + 1
	cell.index = index

	self:_UpdateLeftCell(view, cell, data)

	return cell
end

function EquipRecycleView:_OnLeftCellUpdate(view, cell)
	local index = cell.index
	local data = self._curLeftDatas[index + 1]

	cell.data = index + 1

	self:_UpdateLeftCell(view, cell, data)
end

function EquipRecycleView:_RightInView()
	if not self._curRightDatas then
		return 0
	end

	return #self._curRightDatas
end

function EquipRecycleView:_RightAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self.rightGo)

	local data = self._curRightDatas[index + 1]

	cell.data = index + 1
	cell.index = index

	self:_UpdateRightCell(view, cell, data)

	return cell
end

function EquipRecycleView:_OnRightCellUpdate(view, cell)
	local index = cell.index
	local data = self._curRightDatas[index + 1]

	cell.data = index + 1

	self:_UpdateRightCell(view, cell, data)
end

function EquipRecycleView:onEnter()
	EquipRecycleView.super.onEnter(self)
	self.decoTogGo:SetActive(false)

	self._isChooAll = true

	GlobalDispatcher:addListener("UpdataEquipRecycleShow", self.UpdataEquipRecycleShow, self)

	self._isChooType = MatType.Equipment

	if self:getFirstParam() then
		self._isChooType = self:getFirstParam()
	end

	local sttMatList = {}

	self._getExclList = {}

	if self._isChooType == MatType.Equipment then
		sttMatList = EquipmentConfig.instance:GetStrengtheningMaterial()

		local exclList = EquipmentConfig.instance:GetExclusiveMaterial()

		for i = 1, #self._exclItemList do
			if exclList[i] then
				self._getExclList[i] = {
					getNum = 0,
					matId = exclList[i].id,
					matExp = exclList[i].exp
				}

				if not self._exclItemList[i].activeSelf then
					self._exclItemList[i]:SetActive(true)
				end
			elseif self._exclItemList[i].activeSelf then
				self._exclItemList[i]:SetActive(false)
			end
		end
	elseif self._isChooType == MatType.Decoration then
		self.decoTogGo:SetActive(true)

		self.decoTog.isOn = true
		sttMatList = DecorationConfig.instance:GetStrengtheningMaterial()
	end

	self.isReset = true

	if #sttMatList > 1 then
		table.sort(sttMatList, function(a, b)
			return a.matId < b.matId
		end)
	end

	self._getMatNumList = {}

	for i = 1, #self._matItemList do
		if sttMatList[i] then
			self._getMatNumList[i] = {
				getNum = 0,
				matId = sttMatList[i].matId,
				matExp = sttMatList[i].matExp
			}

			if not self._matItemList[i].activeSelf then
				self._matItemList[i]:SetActive(true)
			end
		elseif self._matItemList[i].activeSelf then
			self._matItemList[i]:SetActive(false)
		end
	end

	self._maxOneNum = EquipmentConfig.instance:GetMaxOneStrthNum()

	self:UpdataEquipRecycleShow()
end

function EquipRecycleView:UpdataEquipRecycleShow()
	self._curRightDatas = {}

	if self._isChooType == MatType.Equipment then
		self._curRightDatas = PetEquipModel.instance:GetRecycleEquipList(true)
	elseif self._isChooType == MatType.Decoration then
		self._curRightDatas = PetEquipModel.instance:GetRecycleDecorationList(true)
	end

	self:setShenqiRefundMp()
	self.rightListSR:ReloadData()

	self._choNowNum = 0
	self.leftTitleTxt1.text = langPara("text_equip_desc_10", self._choNowNum, self._maxOneNum)
	self._curLeftDatas = {}

	for i = 1, 12 do
		table.insert(self._curLeftDatas, {
			isEmpty = true
		})
	end

	self.leftListSR:ReloadData()

	for i = 1, #self._matItemList do
		if self._matItemList[i] and self._getMatNumList[i] then
			self._getMatNumList[i].getNum = 0

			self:UpdataMaterialsNum(i)
		end
	end

	for i = 1, #self._exclItemList do
		if self._exclItemList[i] and self._getExclList[i] then
			self._getExclList[i].getNum = 0

			self:UpdataExclusiveNum(i)
		end
	end

	self:ResetAllToggleStage()
end

function EquipRecycleView:UpdataMaterialsNum(index)
	if self._getMatNumList == nil or self._getMatNumList[index] == nil then
		return
	end

	if self._matItemList == nil or self._matItemList[index] == nil then
		return
	end

	local info = self._getMatNumList[index]

	MaterialMgr.resetAll(self._matItemList[index])

	if info.getNum <= 0 then
		GameUtil.SetActive(self._matItemList[index], false)

		return
	end

	GameUtil.SetActive(self._matItemList[index], true)

	local subLua = MaterialMgr.setCell(MatType.Item, info.matId, self._matItemList[index])

	subLua.binder:setNum(info.getNum)
	subLua.binder:setAutoTips(true)
end

function EquipRecycleView:UpdataExclusiveNum(index)
	if self._getExclList == nil or self._getExclList[index] == nil then
		return
	end

	if self._exclItemList == nil or self._exclItemList[index] == nil then
		return
	end

	local info = self._getExclList[index]

	MaterialMgr.resetAll(self._exclItemList[index])

	if info.getNum <= 0 then
		GameUtil.SetActive(self._exclItemList[index], false)

		return
	end

	GameUtil.SetActive(self._exclItemList[index], true)

	local subLua = MaterialMgr.setCell(MatType.Item, info.matId, self._exclItemList[index])

	subLua.binder:setNum(info.getNum)
	subLua.binder:setAutoTips(true)
end

function EquipRecycleView:setShenqiRefundMp(list)
	for i = 1, #self._shqiItemList do
		MaterialMgr.resetAll(self._shqiItemList[i])

		if self._shqiItemList[i].activeSelf then
			self._shqiItemList[i]:SetActive(false)
		end
	end

	if list == nil or #list == 0 then
		return
	end

	local targetList = MaterialMgr.combineItemsToList(list)

	if #targetList == 0 then
		return
	end

	for i = 1, #self._shqiItemList do
		self._shqiItemList[i]:SetActive(true)

		if targetList[i] then
			local subLua = MaterialMgr.setCellByCfg(targetList[i], self._shqiItemList[i])

			subLua.binder:setAutoTips(true)
		end
	end
end

function EquipRecycleView:OnToggleValueChanged(index, isOn)
	if self.isReset or self._choiTogList[index] == isOn then
		return
	end

	if isOn then
		local isHave = self:_IsHaveQualityEquips(index)

		if not isHave and self._togItemList[index].itemTog.isOn then
			self._togItemList[index].itemTog.isOn = false

			return
		end
	end

	self._choiTogList[index] = isOn

	self:UpdataToggleEquipsShow(index, isOn)
end

function EquipRecycleView:ResetAllToggleStage()
	self.isReset = true
	self._choiTogList = {}

	if self._togItemList and #self._togItemList > 0 then
		for i = 1, #self._togItemList do
			if self._togItemList[i] and self._togItemList[i].itemGo and self._togItemList[i].itemGo.activeSelf and self._togItemList[i].itemTog.isOn then
				self._togItemList[i].itemTog.isOn = false
			end
		end
	end

	local _, togList = PetEquipModel.instance:GetChoiseQualityPlanId(self._isChooType, false)

	if togList == nil or #togList == 0 then
		self.notFilterGo:SetActive(true)

		if self._togItemList and #self._togItemList > 0 then
			for i = 1, #self._togItemList do
				if self._togItemList[i] and self._togItemList[i].itemGo and self._togItemList[i].itemGo.activeSelf then
					if self._togItemList[i].itemTog.isOn then
						self._togItemList[i].itemTog.isOn = false
					end

					self._togItemList[i].itemGo:SetActive(false)
				end
			end
		end
	else
		self.notFilterGo:SetActive(false)

		self._togItemList = self._togItemList or {}

		for i = 1, #togList do
			if self._togItemList[i] == nil or self._togItemList[i].itemGo == nil then
				local item = UnityEngine.GameObject.Instantiate(self.filterItem, self.filterItemTran)

				self._togItemList[i] = {
					itemGo = item,
					itemTog = Framework.ToggleAdapter.GetFrom(item, "itemTog"),
					itemTxt = goutil.findChildTextComponent(item, "itemTxt")
				}
			end

			if self._togItemList[i] and togList[i] then
				self._togItemList[i].itemTog:RemoveOnValueChanged()
				self._togItemList[i].itemGo:SetActive(true)

				self._togItemList[i].itemTog.isOn = false
				self._togItemList[i].itemTxt.text = togList[i].qualityName
				self._togItemList[i].quaNum = togList[i].qualityNum
				self._togItemList[i].isBase = togList[i].isBase

				self._togItemList[i].itemTog:AddOnValueChanged(function(go, isOn)
					self:OnToggleValueChanged(i, isOn)
				end)
			end
		end

		if #togList < #self._togItemList then
			for j = #togList + 1, #self._togItemList do
				if self._togItemList[j] and self._togItemList[j].itemGo and self._togItemList[j].itemGo.activeSelf then
					if self._togItemList[j].itemTog.isOn then
						self._togItemList[j].itemTog.isOn = false
					end

					self._togItemList[j].itemGo:SetActive(false)
				end
			end
		end
	end

	self.isReset = false
end

function EquipRecycleView:UpdataToggleEquipsShow(tog, isAdd)
	if self._curRightDatas == nil or #self._curRightDatas == 0 then
		return
	end

	local togIndex = -99

	if self._togItemList and self._togItemList[tog] and self._togItemList[tog].quaNum >= 0 then
		togIndex = self._togItemList[tog].quaNum
	end

	local allExp = 0

	self._choNowNum = 0

	local tempList = {}
	local leftList = {}
	local exclNumList = {
		0,
		0,
		0,
		0
	}
	local shqiTempList = {}

	for i = 1, #self._curRightDatas do
		if not self._curRightDatas[i].isEmpty then
			if togIndex >= 0 and (self._togItemList[tog].isBase and togIndex == self._curRightDatas[i].infoMo.qualityBase or not self._togItemList[tog].isBase and togIndex == self._curRightDatas[i].infoMo.quality) then
				if self._curRightDatas[i].countList then
					if isAdd then
						local use = self._curRightDatas[i].useCount

						self._curRightDatas[i].useCount = 0

						local data = {
							useCount = 0,
							infoMo = self._curRightDatas[i].infoMo,
							countList = {}
						}

						while (use > 0 or self._choNowNum < self._maxOneNum) and self._curRightDatas[i].useCount < #self._curRightDatas[i].countList do
							self._curRightDatas[i].useCount = self._curRightDatas[i].useCount + 1

							if use > 0 then
								use = use - 1
							elseif self._choNowNum < self._maxOneNum then
								table.insert(tempList, self._curRightDatas[i].infoMo.onlyId)
							end

							allExp = allExp + self._curRightDatas[i].infoMo.equalExp + self._curRightDatas[i].infoMo.haveAllExp

							if self._curRightDatas[i].infoMo:isAttrOrExclEquip() then
								if checknumber(self._curRightDatas[i].infoMo.exclRaceId) > 0 then
									exclNumList[self._curRightDatas[i].infoMo.wearPos] = checknumber(exclNumList[self._curRightDatas[i].infoMo.wearPos]) + self._curRightDatas[i].infoMo.exclMatNum
								elseif not string.nilorempty(self._curRightDatas[i].infoMo.attrType) and self._curRightDatas[i].infoMo.attrType ~= "无" then
									exclNumList[self._curRightDatas[i].infoMo.wearPos] = checknumber(exclNumList[self._curRightDatas[i].infoMo.wearPos]) + self._curRightDatas[i].infoMo.attrMatNum
								end
							end

							self._choNowNum = self._choNowNum + 1
							data.useCount = self._curRightDatas[i].useCount

							table.insert(data.countList, self._curRightDatas[i].countList[data.useCount])

							if self._curRightDatas[i].infoMo:isEquipArtifact() then
								local list = EquipmentConfig.instance:getThroneRefundCfg(self._curRightDatas[i].infoMo.baseId)

								if list and #list > 0 then
									table.insertto(shqiTempList, list)
								end
							end
						end

						if data.useCount > 0 then
							table.insert(leftList, data)
						end
					else
						self._curRightDatas[i].useCount = 0
					end
				elseif isAdd then
					if self._curRightDatas[i].useCount > 0 or self._choNowNum < self._maxOneNum then
						self._choNowNum = self._choNowNum + 1
						allExp = allExp + self._curRightDatas[i].infoMo.equalExp + self._curRightDatas[i].infoMo.haveAllExp

						if self._curRightDatas[i].infoMo:isAttrOrExclEquip() then
							if checknumber(self._curRightDatas[i].infoMo.exclRaceId) > 0 then
								exclNumList[self._curRightDatas[i].infoMo.wearPos] = checknumber(exclNumList[self._curRightDatas[i].infoMo.wearPos]) + self._curRightDatas[i].infoMo.exclMatNum
							elseif not string.nilorempty(self._curRightDatas[i].infoMo.attrType) and self._curRightDatas[i].infoMo.attrType ~= "无" then
								exclNumList[self._curRightDatas[i].infoMo.wearPos] = checknumber(exclNumList[self._curRightDatas[i].infoMo.wearPos]) + self._curRightDatas[i].infoMo.attrMatNum
							end
						end

						self._curRightDatas[i].useCount = 1

						table.insert(leftList, {
							useCount = 1,
							infoMo = self._curRightDatas[i].infoMo
						})

						if self._choNowNum < self._maxOneNum then
							table.insert(tempList, self._curRightDatas[i].infoMo.onlyId)
						end

						if self._curRightDatas[i].infoMo:isEquipArtifact() then
							local list = EquipmentConfig.instance:getThroneRefundCfg(self._curRightDatas[i].infoMo.baseId)

							if list and #list > 0 then
								table.insertto(shqiTempList, list)
							end
						end
					end
				else
					self._curRightDatas[i].useCount = 0
				end
			elseif self._curRightDatas[i].useCount > 0 then
				if self._curRightDatas[i].countList then
					local temp = {
						infoMo = self._curRightDatas[i].infoMo,
						countList = {},
						useCount = self._curRightDatas[i].useCount
					}

					for j = 1, self._curRightDatas[i].useCount do
						self._choNowNum = self._choNowNum + 1
						allExp = allExp + self._curRightDatas[i].infoMo.equalExp + self._curRightDatas[i].infoMo.haveAllExp

						if self._curRightDatas[i].infoMo:isAttrOrExclEquip() then
							if checknumber(self._curRightDatas[i].infoMo.exclRaceId) > 0 then
								exclNumList[self._curRightDatas[i].infoMo.wearPos] = checknumber(exclNumList[self._curRightDatas[i].infoMo.wearPos]) + self._curRightDatas[i].infoMo.exclMatNum
							elseif not string.nilorempty(self._curRightDatas[i].infoMo.attrType) and self._curRightDatas[i].infoMo.attrType ~= "无" then
								exclNumList[self._curRightDatas[i].infoMo.wearPos] = checknumber(exclNumList[self._curRightDatas[i].infoMo.wearPos]) + self._curRightDatas[i].infoMo.attrMatNum
							end
						end

						table.insert(temp.countList, self._curRightDatas[i].countList[j])

						if self._curRightDatas[i].infoMo:isEquipArtifact() then
							local list = EquipmentConfig.instance:getThroneRefundCfg(self._curRightDatas[i].infoMo.baseId)

							if list and #list > 0 then
								table.insertto(shqiTempList, list)
							end
						end
					end

					table.insert(leftList, temp)
				else
					self._choNowNum = self._choNowNum + 1
					allExp = allExp + self._curRightDatas[i].infoMo.equalExp + self._curRightDatas[i].infoMo.haveAllExp

					if self._curRightDatas[i].infoMo:isAttrOrExclEquip() then
						if checknumber(self._curRightDatas[i].infoMo.exclRaceId) > 0 then
							exclNumList[self._curRightDatas[i].infoMo.wearPos] = checknumber(exclNumList[self._curRightDatas[i].infoMo.wearPos]) + self._curRightDatas[i].infoMo.exclMatNum
						elseif not string.nilorempty(self._curRightDatas[i].infoMo.attrType) and self._curRightDatas[i].infoMo.attrType ~= "无" then
							exclNumList[self._curRightDatas[i].infoMo.wearPos] = checknumber(exclNumList[self._curRightDatas[i].infoMo.wearPos]) + self._curRightDatas[i].infoMo.attrMatNum
						end
					end

					table.insert(leftList, {
						useCount = 1,
						infoMo = self._curRightDatas[i].infoMo
					})

					if self._curRightDatas[i].infoMo:isEquipArtifact() then
						local list = EquipmentConfig.instance:getThroneRefundCfg(self._curRightDatas[i].infoMo.baseId)

						if list and #list > 0 then
							table.insertto(shqiTempList, list)
						end
					end
				end
			end
		end
	end

	self.rightListSR:ReloadData()

	if self._choNowNum > self._maxOneNum and #tempList > 0 then
		local count = self._choNowNum - self._maxOneNum

		for i = #tempList, 1, -1 do
			local exp = self:RemoveRedundantData(tempList[i], leftList, exclNumList)

			allExp = allExp - exp
			count = count - 1

			if count <= 0 then
				break
			end
		end
	end

	self.rightListSR:ReloadData()

	self._curLeftDatas = {}

	local tempCount = 0

	for i = 1, #leftList do
		if leftList[i] and leftList[i].useCount > 0 then
			tempCount = tempCount + 1
			self._curLeftDatas[tempCount] = leftList[i]
		end
	end

	for i = tempCount + 1, 12 do
		self._curLeftDatas[i] = {
			isEmpty = true
		}
	end

	self.leftListSR:ReloadData()

	self.leftTitleTxt1.text = langPara("text_equip_desc_10", self._choNowNum, self._maxOneNum)

	local tempExp = 0
	local ratio = 100

	if self._isChooType == MatType.Equipment then
		ratio = EquipmentConfig.instance:GetCostDecoRatio()
	elseif self._isChooType == MatType.Decoration then
		ratio = DecorationConfig.instance:GetCostDecoRatio()
	end

	allExp = allExp * ratio / 100

	for i = #self._getMatNumList, 1, -1 do
		local count = 0

		if tempExp < allExp then
			count = i == 1 and math.ceil((allExp - tempExp) / self._getMatNumList[i].matExp) or math.floor((allExp - tempExp) / self._getMatNumList[i].matExp)
		end

		self._getMatNumList[i].getNum = count
		tempExp = tempExp + count * self._getMatNumList[i].matExp

		self:UpdataMaterialsNum(i)
	end

	for i = 1, #self._getExclList do
		if self._getExclList[i] and self._getExclList[i] then
			self._getExclList[i].getNum = checknumber(exclNumList[i])

			self:UpdataExclusiveNum(i)
		end
	end

	self:setShenqiRefundMp(shqiTempList)
end

function EquipRecycleView:RemoveRedundantData(onlyId, leftList, exclNumList)
	local exp = 0

	if checknumber(onlyId) <= 0 then
		return exp
	end

	if self._curRightDatas == nil or #self._curRightDatas == 0 then
		return exp
	end

	for i = 1, #self._curRightDatas do
		if self._curRightDatas[i] and not self._curRightDatas[i].isEmpty and self._curRightDatas[i].infoMo.onlyId == onlyId then
			self._curRightDatas[i].useCount = self._curRightDatas[i].useCount - 1
			self._choNowNum = self._choNowNum - 1

			if self._curRightDatas[i].infoMo:isAttrOrExclEquip() then
				exp = self._curRightDatas[i].infoMo.haveAllExp

				if checknumber(self._curRightDatas[i].infoMo.exclRaceId) > 0 then
					exclNumList[self._curRightDatas[i].infoMo.wearPos] = checknumber(exclNumList[self._curRightDatas[i].infoMo.wearPos]) - self._curRightDatas[i].exclMatNum
				elseif not string.nilorempty(self._curRightDatas[i].infoMo.attrType) and self._curRightDatas[i].infoMo.attrType ~= "无" then
					exclNumList[self._curRightDatas[i].infoMo.wearPos] = checknumber(exclNumList[self._curRightDatas[i].infoMo.wearPos]) - self._curRightDatas[i].infoMo.attrMatNum
				end
			else
				exp = self._curRightDatas[i].infoMo.equalExp + self._curRightDatas[i].infoMo.haveAllExp
			end

			if self._curRightDatas[i].useCount < 0 then
				self._curRightDatas[i].useCount = 0
			end

			break
		end
	end

	if leftList == nil or #leftList == 0 then
		return exp
	end

	for i = 1, #leftList do
		if leftList[i] and not leftList[i].isEmpty and leftList[i].onlyId == onlyId then
			leftList[i].useCount = leftList[i].useCount - 1

			if leftList[i].useCount < 0 then
				leftList[i].useCount = 0
			end

			if leftList[i].countList and #leftList[i].countList > 0 then
				table.remove(leftList[i].countList)
			end

			return exp
		end
	end

	return 0
end

function EquipRecycleView:OnClickDecompseBtn()
	if self._curRightDatas == nil or #self._curRightDatas == 0 or self._curRightDatas[1].isEmpty then
		FloatWordMgr.instance:show(lang("text_equip_desc_11"))

		return
	end

	if self._curLeftDatas == nil or #self._curLeftDatas == 0 or self._curLeftDatas[1].isEmpty then
		FloatWordMgr.instance:show(lang("text_equip_desc_12"))

		return
	end

	local onlyIds = {}
	local tipsInfoList = {}
	local maxNum = 4

	if self._isChooType == MatType.Equipment then
		maxNum = EquipmentConfig.instance:GetMaxQualityNum()
	elseif self._isChooType == MatType.Decoration then
		maxNum = DecorationConfig.instance:GetMaxQualityNum()
	end

	for i = 1, #self._curLeftDatas do
		if self._curLeftDatas[i] and not self._curLeftDatas[i].isEmpty then
			local choNum = 1

			if self._curLeftDatas[i].countList then
				choNum = #self._curLeftDatas[i].countList

				if #self._curLeftDatas[i].countList ~= self._curLeftDatas[i].useCount then
					choNum = self._curLeftDatas[i].useCount
				end

				for j = 1, choNum do
					table.insert(onlyIds, self._curLeftDatas[i].countList[j])
				end
			else
				table.insert(onlyIds, self._curLeftDatas[i].infoMo.onlyId)
			end

			if maxNum <= self._curLeftDatas[i].infoMo.quality then
				table.insert(tipsInfoList, {
					onlyId = self._curLeftDatas[i].infoMo.onlyId,
					matType = MatType.Equipment,
					useCount = choNum
				})
			end
		end
	end

	if not self:_checkPasswordLockPass(tipsInfoList) then
		return
	end

	local function callBack()
		if self._isChooType == MatType.Equipment then
			PetEquipController.instance:CSDecompseEquipmentReq(onlyIds)
		elseif self._isChooType == MatType.Decoration then
			PetEquipController.instance:CSDecompseDecorationReq(onlyIds)
		end
	end

	if tipsInfoList and #tipsInfoList > 0 then
		UIStateManager.instance:open(ViewName.StrengthenTips, tipsInfoList, callBack, lang("text_equip_analysis_tips"))

		return
	end

	callBack()
end

function EquipRecycleView:_UpdateLeftCell(view, cell, data)
	local equipPos = goutil.findChild(cell, "equipPos")
	local reduceBtnGo = goutil.findChild(cell, "reduceBtn")

	MaterialMgr.resetAll(equipPos)
	GameUtil.asBtn(reduceBtnGo):RemoveClickListener()

	if data.isEmpty then
		GameUtil.SetActive(reduceBtnGo, false)

		return
	end

	GameUtil.SetActive(reduceBtnGo, true)

	local equipInfo = PetEquipModel.instance:GetInfoMoByOnlyId(data.infoMo.onlyId, self._isChooType)

	if equipInfo then
		local subLua = MaterialMgr.setCellByData(self._isChooType, equipInfo, equipPos)

		subLua.binder:setNum(data.useCount)
		subLua.binder:setAutoTips(true)
	end

	GameUtil.asBtn(reduceBtnGo):AddClickListener(function()
		self:OnClickLeftItemBtn(cell.data)
	end)
end

function EquipRecycleView:OnClickLeftItemBtn(index)
	if self._curLeftDatas == nil or #self._curLeftDatas == 0 then
		return
	end

	if self._curLeftDatas[index] == nil or self._curLeftDatas[index].isEmpty then
		return
	end

	self._curRightDatas = self._curRightDatas or {}

	local info = self._curLeftDatas[index]

	if info == nil or checknumber(info.useCount) <= 0 then
		return
	end

	local haveIndex = 0

	for i = 1, #self._curRightDatas do
		if self._curRightDatas[i] and not self._curRightDatas[i].isEmpty and self._curRightDatas[i].infoMo.onlyId == info.infoMo.onlyId then
			haveIndex = i

			break
		end
	end

	if haveIndex <= 0 or self._curRightDatas[haveIndex] == nil or self._curRightDatas[haveIndex].useCount <= 0 then
		printError("sr--- EquipRecycleView:_ReturnEquipRight()    为什么会空，查查看！！")

		return
	end

	if info.countList then
		self._curRightDatas[haveIndex].useCount = self._curRightDatas[haveIndex].useCount - 1

		if self._curRightDatas[haveIndex].useCount < 0 then
			self._curRightDatas[haveIndex].useCount = 0
		end
	else
		self._curRightDatas[haveIndex].useCount = 0
	end

	self:UpdataToggleEquipsShow()
end

function EquipRecycleView:_UpdateRightCell(view, cell, data)
	local equipPos = goutil.findChild(cell, "equipPos")
	local equipBtnGo = goutil.findChild(cell, "equipBtnGo")
	local reduceBtnGo = goutil.findChild(cell, "reduceBtn")

	GameUtil.asBtn(equipBtnGo):RemoveClickListener()
	GameUtil.asBtn(reduceBtnGo):RemoveClickListener()
	MaterialMgr.resetAll(equipPos)

	if data.isEmpty then
		GameUtil.SetActive(reduceBtnGo, false)

		return
	end

	subLua = nil

	local equipInfo = PetEquipModel.instance:GetInfoMoByOnlyId(data.infoMo.onlyId, self._isChooType)

	if equipInfo then
		local subLua = MaterialMgr.setCellByData(self._isChooType, equipInfo, equipPos)
		local allNum, useNum = 1, data.useCount

		if data.countList and #data.countList > 1 then
			allNum = #data.countList
		end

		if allNum <= 1 then
			subLua.binder:setNum()
		else
			subLua.binder:setNum(allNum, useNum)
		end

		subLua.binder:setAutoTips(false)
		subLua.binder:setSelected(useNum > 0)
		GameUtil.SetActive(reduceBtnGo, useNum > 0)
		GameUtil.asBtn(reduceBtnGo):AddClickListener(function()
			self:OnClickRightItemBtn(cell.data, false)
		end, self)
		GameUtil.asBtn(equipBtnGo):AddClickListener(function()
			self:OnClickRightItemBtn(cell.data, true)
		end, self)
	end
end

function EquipRecycleView:OnClickRightItemBtn(index, isAdd)
	if self._curRightDatas == nil or self._curRightDatas[index] == nil then
		return
	end

	if isAdd then
		if ((self._curRightDatas[index].countList and #self._curRightDatas[index].countList > 1 or nil) and #self._curRightDatas[index].countList) <= self._curRightDatas[index].useCount then
			FloatWordMgr.instance:show(lang("text_equip_desc_14"))

			return
		end

		if self._choNowNum >= self._maxOneNum then
			FloatWordMgr.instance:show(lang("text_equip_desc_15"))

			return
		end

		self._curRightDatas[index].useCount = self._curRightDatas[index].useCount + 1
	else
		if self._curRightDatas[index].useCount <= 0 then
			FloatWordMgr.instance:show(lang("text_equip_desc_16"))

			return
		end

		self._curRightDatas[index].useCount = self._curRightDatas[index].useCount - 1
	end

	self:UpdataToggleEquipsShow()
end

function EquipRecycleView:_IsHaveQualityEquips(index)
	if self._choNowNum >= self._maxOneNum then
		FloatWordMgr.instance:show(lang("text_equip_desc_17"))

		return
	end

	local togIndex = -99

	if self._togItemList and self._togItemList[index] and self._togItemList[index].quaNum >= 0 then
		togIndex = self._togItemList[index].quaNum
	end

	if togIndex >= 4 and self._togItemList[index].isBase or togIndex >= 8 and not self._togItemList[index].isBase then
		FloatWordMgr.instance:show(lang("text_equip_desc_18"))

		return false
	end

	if self._curRightDatas == nil or #self._curRightDatas == 0 then
		FloatWordMgr.instance:show(lang("text_equip_desc_19"))

		return false
	end

	local isHave = false

	for i = 1, #self._curRightDatas do
		if self._curRightDatas[i] and not self._curRightDatas[i].isEmpty and (togIndex == self._curRightDatas[i].infoMo.qualityBase and self._togItemList[index].isBase or togIndex == self._curRightDatas[i].infoMo.quality and not self._togItemList[index].isBase) and (self._isChooAll or not self._isChooAll and self._curRightDatas[i].infoMo.haveAllExp <= 0) then
			isHave = true

			break
		end
	end

	if not isHave then
		FloatWordMgr.instance:show(lang("text_equip_desc_13"))

		return false
	end

	return true
end

function EquipRecycleView:_checkPasswordLockPass(list)
	if #list > 0 and PasswordLockController.instance:checkNeedOpenVerifyView() then
		return false
	end

	return true
end

return EquipRecycleView
