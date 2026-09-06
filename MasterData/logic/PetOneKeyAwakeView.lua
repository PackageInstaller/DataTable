-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetOneKeyAwakeView.lua

module("logic.extensions.bag.view.stack.PetOneKeyAwakeView", package.seeall)

local PetOneKeyAwakeView = class("PetOneKeyAwakeView", ViewComponent)

function PetOneKeyAwakeView:buildUI()
	PetOneKeyAwakeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnOneKey = self:getGo("btnOneKey")
	self._btnReset = self:getGo("btnReset")
	self._btnReturn = self:getGo("btnReturn")
	self._btnUseSoul = self:getGo("useSoul/btnSelect")
	self._markUseSoul = goutil.findChild(self._btnUseSoul, "mark")
	self._goCell = self:getGo("cell")
	self._goTableView = self:getGo("tableView")
	self._tableView = ScrollerList.create(self._goTableView, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._itemPosCost = self:getGo("costDust/itemPos")
	self._txtNumCost = self:getTxt("costDust/txtNum")

	local arr = string.split(GameEnum.GoldType.PixieDust, ":")

	self._dustType = checknumber(arr[1])
	self._dustId = checknumber(arr[2])
	self._userDataKey = "ONE_KEY_ALLOW_COST_SOUL"
end

function PetOneKeyAwakeView:bindEvents()
	PetOneKeyAwakeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	GameUtil.addClickHandler(self._btnUseSoul, self._onClickUseSoul, self)
	GameUtil.addClickHandler(self._btnReturn, self._onClickReturn, self)
end

function PetOneKeyAwakeView:unbindEvents()
	PetOneKeyAwakeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnOneKey)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnUseSoul)
	GameUtil.rmClickHandler(self._btnReturn)
end

function PetOneKeyAwakeView:onEnter()
	PetOneKeyAwakeView.super.onEnter(self)

	self._cellPool = {}

	goutil.setActive(self._markUseSoul, checknumber(GameUtil.getUserData(self._userDataKey)) > 0)
	self:_createDataList()
	self:_refreshCalculatePublicCost()
	self._tableView:reloadData(self._curDataList)
	self._tableView:MoveCellToBegin(0)
	MaterialMgr.setCell(self._dustType, self._dustId, self._itemPosCost)
	GlobalDispatcher:addListener(GlobalNotify.PetOneKeyAwakeSuccess, self._onAwakeSuc, self)
	GlobalDispatcher:addListener(GlobalNotify.PetOneKeyAwakeFail, self._onAwakeFail, self)
end

function PetOneKeyAwakeView:onExit()
	PetOneKeyAwakeView.super.onExit(self)
	self._tableView:dispose()
	MaterialMgr.resetAll(self._itemPosCost)
	GameUtil.GetActive(self._markUseSoul)
	GameUtil.saveUserData(self._userDataKey, GameUtil.GetActive(self._markUseSoul) and 1 or 0)
	GlobalDispatcher:removeListener(GlobalNotify.PetOneKeyAwakeSuccess, self._onAwakeSuc, self)
	GlobalDispatcher:removeListener(GlobalNotify.PetOneKeyAwakeFail, self._onAwakeFail, self)
end

function PetOneKeyAwakeView:_onClickOneKey()
	local curAwakeDataList = {}

	for _, data in ipairs(self._curDataList) do
		if data.tryAwakeLv ~= data.awakenLv then
			table.insert(curAwakeDataList, data)
		end
	end

	if #curAwakeDataList == 0 then
		FloatWordMgr.instance:show("当前未选中精灵的觉醒等级")

		return
	end

	if self._curCostDustNum > self._curDustNum then
		return FloatWordMgr.instance:show("当前觉醒材料不足")
	end

	for i, v in pairs(self._publicCostHash) do
		if v.curCost > v.costLimit then
			return FloatWordMgr.instance:show("当前觉醒材料不足")
		end
	end

	if not self:_checkPasswordLockPass(curAwakeDataList) then
		return
	end

	self._compareList = {}

	local costList = {}
	local dataList = {}

	for _, data in ipairs(curAwakeDataList) do
		local info = PetExtension_pb.PM_OneKeyAwakenPetInfo()

		if data.mo then
			table.insert(self._compareList, data.mo:GetClone())
		end

		info.awakenPetId = data.petId
		info.targetAwakenLv = data.tryAwakeLv

		local costNum, costDustNum = BagModel.instance:getPetAwakeTotalCost(data.mo, data.tryAwakeLv)

		for k, costData in ipairs(data.costDatas) do
			if costNum > 0 then
				if costData.isSelect then
					if costData.type == MatType.Item then
						for i = 1, costData.curCostNum do
							if costNum > 0 then
								info.usedItemIds:append(costData.id)

								costNum = costNum - 1

								table.insert(costList, MaterialMgr.createSerName(costData.type, costData.id, 1))
							else
								break
							end
						end
					elseif costData.type == MatType.Pet then
						info.usedPetIds:append(costData.id)

						costNum = costNum - 1
					end
				end
			else
				break
			end
		end

		table.insert(dataList, info)
	end

	local combineList = MaterialMgr.combineItemsToList(costList) or {}
	local content = ""
	local arr = {}

	for i, itemStr in ipairs(combineList) do
		table.insert(arr, MaterialMgr.getContentMatStr(itemStr, 90, -15, MaterialMgr.ICON_TYPE_MATID))
	end

	content = langPara("本次觉醒消耗以下物品：\n%s\n是否确认此操作", table.concat(arr, ""))

	if #costList == 0 then
		TipsFacade.instance:openPopupWindow(lang("tip"), lang("是否确认此操作"), function()
			PetAgent.instance:sendPM_OneKeyPetAwakenReq(dataList)
		end, nil, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
	else
		local combineList = MaterialMgr.combineItemsToList(costList) or {}
		local arr = {}

		for i, itemStr in ipairs(combineList) do
			table.insert(arr, MaterialMgr.getContentMatStr(itemStr, 75, -5, MaterialMgr.ICON_TYPE_MATID))
		end

		TipsFacade.instance:openPopupWindow(lang("tip"), langPara("本次觉醒消耗以下物品：\n%s\n是否确认此操作", table.concat(arr, "")), function()
			PetAgent.instance:sendPM_OneKeyPetAwakenReq(dataList)
		end, nil, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
	end
end

function PetOneKeyAwakeView:_onClickReset()
	for _, v in pairs(self._publicCostHash) do
		v.curTryCostHash = {}
	end

	for i, v in ipairs(self._curDataList) do
		self:_autoSelectCost(v, 0)
	end

	self._tableView:reloadData(self._curDataList)
	self:_refreshCalculatePublicCost()
end

function PetOneKeyAwakeView:_onClickUseSoul()
	local isCurUse = not GameUtil.GetActive(self._markUseSoul)

	goutil.setActive(self._markUseSoul, isCurUse)
	self:_setCurAwakeMaxLv()
	self._tableView:reloadData(self._curDataList)
	self:_refreshCalculatePublicCost()
end

function PetOneKeyAwakeView:_setCurAwakeMaxLv()
	for _, v in pairs(self._publicCostHash) do
		v.curTryCostHash = {}
	end

	for _, v in ipairs(self._curDataList) do
		local needNum = v.awakenLvMax - v.awakenLv
		local num = 0

		for i, costData in ipairs(v.costDatas) do
			if costData.type == MatType.Item and not costData.isSSR and costData.race ~= 0 then
				local costLimit = self:_getCurCostItemLimitNum(costData)

				if needNum <= costLimit then
					num = needNum

					break
				else
					needNum = needNum - costLimit
					num = num + costLimit
				end
			elseif costData.type ~= MatType.Item and needNum > 0 then
				needNum = needNum - 1
				num = num + 1
			end
		end

		self:_autoSelectCost(v, num + v.awakenLv)
	end
end

function PetOneKeyAwakeView:_createDataList()
	self._curDataList = {}
	self._publicCostHash = {}

	local params = self:getOpenParam()

	if not params[1] then
		self._curPetMoList = params[2] or {}

		for _, mo in ipairs(params[1]) do
			local data = self:_createDataByMo(mo)

			table.insert(self._curDataList, data)
		end

		self._curDustNum = MaterialModel.instance:getMaterialsNumber(self._dustType, self._dustId)

		for i, data in ipairs(self._curDataList) do
			self:_refreshAwakeLvMax(data)
		end

		self:_setCurAwakeMaxLv()
	end
end

function PetOneKeyAwakeView:_createDataByMo(mo)
	local data = {}

	data.mo = mo
	data.petId = mo.petId
	data.awakenLv = mo.awakenLv
	data.existLockPet = false
	data.tryAwakeLv = 6
	data.costDustNum = 0
	data.costDatas = {}

	local replaceItemCfgs = ItemConfig.instance:getAllReplaceItemCfgList(mo)

	for _, cfg in ipairs(replaceItemCfgs) do
		local costData = {}

		costData.isSelect = false
		costData.type = MatType.Item
		costData.id = cfg.id
		costData.awakePetId = data.petId
		costData.curCostNum = 0
		costData.race = cfg.race

		if cfg.initRares and table.indexof(cfg.initRares, GameEnum.PetRare.SSR) then
			costData.isSSR = true
		end

		if cfg.race == 0 then
			costData.costOrder = not string.nilorempty(cfg.attr) and 3 or 4

			local publicCostData = self._publicCostHash[costData.id]

			publicCostData = publicCostData or {
				costLimit = MaterialModel.instance:getMaterialsNumber(MatType.Item, costData.id),
				curTryCostHash = {}
			}
			self._publicCostHash[costData.id] = publicCostData
		else
			costData.costOrder = 1
		end

		table.insert(data.costDatas, costData)
	end

	local petMos = BagModel.instance:getPetsByRaceId(mo.raceId)

	for _, petMo in ipairs(petMos) do
		if petMo.petId ~= mo.petId then
			local costData = {}

			costData.type = MatType.Pet
			costData.id = petMo.petId
			costData.awakePetId = mo.petId
			costData.mo = petMo
			costData.isSelect = false
			costData.costOrder = 2

			table.insert(data.costDatas, costData)
		end
	end

	table.sort(data.costDatas, function(a, b)
		if a.costOrder == b.costOrder then
			return a.id < b.id
		end

		return a.costOrder < b.costOrder
	end)

	return data
end

function PetOneKeyAwakeView:_refreshAwakeLvMax(data)
	if not data then
		return
	end

	data.existLockPet = false

	local count = 0

	for i, costData in ipairs(data.costDatas) do
		if costData.type == MatType.Item then
			if not GameUtil.GetActive(self._markUseSoul) and costData.isSSR then
				-- block empty
			elseif data.existLockPet and costData.isSSR then
				-- block empty
			else
				count = count + self:_getCurCostItemLimitNum(costData)
			end
		elseif not costData.mo:isLocked() then
			count = count + 1
		else
			data.existLockPet = true
		end
	end

	data.awakenLvMax = BagModel.instance:getPetAwakeMaxLvByCost(data.mo, count)
end

function PetOneKeyAwakeView:_getCurCostItemLimitNum(costData)
	if costData.type ~= MatType.Item then
		return 0
	end

	local publicCostData = self._publicCostHash[costData.id]

	if publicCostData then
		local totalLimit = MaterialModel.instance:getMaterialsNumber(MatType.Item, costData.id)

		for k, v in pairs(publicCostData.curTryCostHash) do
			if k ~= costData.awakePetId then
				totalLimit = totalLimit - v
			end
		end

		return totalLimit
	else
		return MaterialModel.instance:getMaterialsNumber(MatType.Item, costData.id)
	end
end

function PetOneKeyAwakeView:_autoSelectCost(data, tryAwakeLv)
	if not data then
		return
	end

	self:_refreshAwakeLvMax(data)

	local petMo = data.mo
	local tryAwakeLv = Mathf.Clamp(tryAwakeLv, data.awakenLv, data.awakenLvMax)

	data.tryAwakeLv = tryAwakeLv

	local costNum, costDustNum = BagModel.instance:getPetAwakeTotalCost(petMo, tryAwakeLv)

	data.costDustNum = costDustNum

	local useCnt = 0

	for _, costData in ipairs(data.costDatas) do
		if costNum > 0 then
			if costData.type == MatType.Item then
				if costData.isSSR and not GameUtil.GetActive(self._markUseSoul) then
					costData.isSelect = false
					costData.curCostNum = 0
				else
					local costLimit = self:_getCurCostItemLimitNum(costData)

					if costLimit > 0 then
						costData.isSelect = true

						if costNum <= costLimit then
							costData.curCostNum = costNum
							costNum = 0
						else
							costNum = costNum - costLimit
							costData.curCostNum = costLimit
						end

						useCnt = useCnt + costData.curCostNum

						local publicCostData = self._publicCostHash[costData.id]

						if publicCostData then
							publicCostData.curTryCostHash[costData.awakePetId] = costData.curCostNum
						end
					end
				end
			elseif costData.mo:isLocked() then
				costData.isSelect = false
			else
				costData.isSelect = true
				costNum = costNum - 1
				useCnt = useCnt + 1
			end
		else
			costData.isSelect = false

			if costData.type == MatType.Item then
				costData.curCostNum = 0

				local publicCostData = self._publicCostHash[costData.id]

				if publicCostData then
					publicCostData.curTryCostHash[costData.awakePetId] = 0
				end
			end
		end
	end

	data.tryAwakeLv = BagModel.instance:getPetAwakeMaxLvByCost(data.mo, useCnt)
end

function PetOneKeyAwakeView:_onCurSelectCostNumChange(data)
	if not data then
		return
	end

	local curSelectCount = self:_getSelectCostCount(data)
	local awakenLv = BagModel.instance:getPetAwakeMaxLvByCost(data.mo, curSelectCount)

	self:_autoSelectCost(data, awakenLv)
end

function PetOneKeyAwakeView:_getSelectCostCount(data)
	local count = 0

	if not data then
		return count
	end

	for _, v in ipairs(data.costDatas) do
		if v.isSelect then
			count = v.type == MatType.Item and count + v.curCostNum or count + 1
		end
	end

	return count
end

function PetOneKeyAwakeView:_refreshCalculatePublicCost()
	self._curCostDustNum = 0

	for _, v in pairs(self._publicCostHash) do
		v.curCost = 0
	end

	for _, v in ipairs(self._curDataList) do
		self._curCostDustNum = self._curCostDustNum + v.costDustNum

		for k, data in ipairs(v.costDatas) do
			if data.type == MatType.Item then
				local publicCost = self._publicCostHash[data.id]

				if publicCost then
					publicCost.curCost = publicCost.curCost + data.curCostNum
				end
			end
		end
	end

	local showStr = self._curCostDustNum > self._curDustNum and langPara("<color=#FF0000FF>%s</color>", self._curCostDustNum) or self._curCostDustNum

	self._txtNumCost.text = langPara("%s/%s", showStr, self._curDustNum)
end

function PetOneKeyAwakeView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)
	local itemLayout = goutil.findChild(goCell, "starLv"):GetComponent(ComponentType.UILayoutSingleLine)

	GameUtil.addClickHandler(cell.btnMs, GameUtil.handler(self._onClickAdjust, self, -1, cell, data))
	GameUtil.addClickHandler(cell.btnAdd, GameUtil.handler(self._onClickAdjust, self, 1, cell, data))

	for i = 1, data.awakenLv do
		goutil.setActive(cell.stars[i], true)
	end

	MaterialMgr.setCellByMo(data.mo, cell.posPet)
	cell.slider:SetValue(data.tryAwakeLv)

	cell.txtSlider.text = data.tryAwakeLv

	cell.tableview:reloadData(data.costDatas)
	itemLayout:Layout()
end

function PetOneKeyAwakeView:_clearCell(goCell)
	local cell = self._cellPool[goCell]

	if cell == nil then
		cell = {
			go = goCell
		}
		cell.posPet = goutil.findChild(cell.go, "posPet")
		cell.adjust = goutil.findChild(cell.go, "adjust")
		cell.slider = Framework.SliderAdapter.GetFrom(cell.adjust, "slider")
		cell.txtSlider = goutil.findChildTextComponent(cell.slider.gameObject, "Handle Slide Area/Handle/txt")
		cell.btnMs = goutil.findChild(cell.adjust, "btnMs")
		cell.btnAdd = goutil.findChild(cell.adjust, "btnAdd")
		cell.stars = {}

		for i = 1, 6 do
			cell.stars[i] = goutil.findChild(cell.go, "starLv/star_" .. i)
		end

		local subCell = goutil.findChild(cell.go, "subCell")
		local subTableView = goutil.findChild(cell.go, "subTableview")

		cell.tableview = ScrollerList.create(subTableView, subCell, GameUtil.handler(self._updateSubCell, self), GameUtil.handler(self._clearSubCell, self))
		self._cellPool[goCell] = cell
	end

	for _, star in ipairs(cell.stars) do
		goutil.setActive(star, false)
	end

	cell.slider:RemoveOnValueChanged()
	GameUtil.rmClickHandler(cell.btnMs)
	GameUtil.rmClickHandler(cell.btnAdd)
	MaterialMgr.resetAll(cell.posPet)
	cell.tableview:dispose()

	return cell
end

function PetOneKeyAwakeView:_updateSubCell(view, goCell, data)
	local cell = self:_clearSubCell(goCell)

	if data.type == MatType.Item then
		local curCostLimit = self:_getCurCostItemLimitNum(data)
		local proxy = MaterialMgr.setCell(MatType.Item, data.id, cell.item)

		proxy:setGray(curCostLimit == 0)
		goutil.setActive(cell.num, true)

		cell.txtNum.text = langPara("%s/%s", data.curCostNum, curCostLimit)
	else
		MaterialMgr.setCellByMo(data.mo, cell.item)
		goutil.setActive(cell.lock, data.mo:isLocked())
	end

	goutil.setActive(cell.mark, data.isSelect)
	GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickSelect, self, data))
end

function PetOneKeyAwakeView:_clearSubCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.item = goutil.findChild(cell.go, "item")
	cell.num = goutil.findChild(cell.go, "num")
	cell.txtNum = goutil.findChildTextComponent(cell.num, "txt")
	cell.lock = goutil.findChild(cell.go, "lock")

	goutil.setActive(cell.lock, false)

	cell.btn = goutil.findChild(cell.go, "btn")
	cell.mark = goutil.findChild(cell.go, "mark")

	goutil.setActive(cell.mark, false)
	goutil.setActive(cell.lock, false)
	goutil.setActive(cell.num, false)
	GameUtil.rmClickHandler(cell.btn)
	MaterialMgr.resetAll(cell.item)

	return cell
end

function PetOneKeyAwakeView:_onSliderValueChange(num, cell, data, useSoul)
	if num and cell and data then
		if num < data.awakenLv then
			FloatWordMgr.instance:show("不能小于当前觉醒等级哦~")
			cell.slider:SetValue(data.awakenLv)

			return
		elseif num > data.awakenLv and data.existLockPet then
			FloatWordMgr.instance:show("请先解锁同名精灵")
			cell.slider:SetValue(data.tryAwakeLv)

			return
		end

		self:_autoSelectCost(data, num, useSoul)

		for _, v in ipairs(self._curDataList) do
			self:_refreshAwakeLvMax(v)
		end

		self._tableView:reloadData(self._curDataList)
		self:_refreshCalculatePublicCost()
	end
end

function PetOneKeyAwakeView:_onClickAdjust(num, cell, data)
	local useSoul = GameUtil.GetActive(self._markUseSoul)

	if num and cell and data then
		self:_onSliderValueChange(data.tryAwakeLv + num, cell, data, useSoul)
	end
end

function PetOneKeyAwakeView:_onClickSelect(data)
	if data.type == MatType.Item then
		if self:_getCurCostItemLimitNum(data) <= 0 then
			data.isSelect = false

			return
		end

		if data.isSSR then
			if GameUtil.GetActive(self._markUseSoul) then
				if data.isSelect then
					data.isSelect = false
					data.curCostNum = 0
				else
					data.isSelect = true
					data.curCostNum = 1
				end
			else
				FloatWordMgr.instance:show("当前未选择消耗传说魂 请手动操作")

				return
			end
		end
	else
		if data.mo:isLocked() then
			TipsFacade.instance:openPopupWindow(lang("tip"), lang("是否解锁该精灵？"), function()
				local petId = data.mo.petId

				BagPetsController.instance:changePetLockState(petId, not data.mo:isLocked(), function(skipTip)
					local locked = data.mo:isLocked()
					local tip = locked and lang("上锁成功~") or lang("解锁成功~")

					if not skipTip then
						FloatWordMgr.instance:show(tip)
					end

					self:_refreshAwakeLvMax(self:_getDataByPetId(data.awakePetId))
					self._tableView:reloadData(self._curDataList)
				end)
			end)
		end

		return
	end

	self:_onCurSelectCostNumChange(self:_getDataByPetId(data.awakePetId))
	self._tableView:reloadData(self._curDataList)
end

function PetOneKeyAwakeView:_getDataByPetId(petId)
	if not self._curDataList or not petId then
		return
	end

	for _, data in ipairs(self._curDataList) do
		if data.petId == petId then
			return data
		end
	end
end

function PetOneKeyAwakeView:_onAwakeSuc()
	FloatWordMgr.instance:show("觉醒成功")

	if self._compareList and #self._compareList > 0 then
		UIStateManager.instance:push(ViewName.PetAwakeStrengthView, self._compareList)
	end

	self:close()
end

function PetOneKeyAwakeView:_onAwakeFail(status)
	return
end

function PetOneKeyAwakeView:_onClickReturn()
	UIStateManager.instance:push(ViewName.PetAwakeSelectView, self._curPetMoList)
	self:close()
end

function PetOneKeyAwakeView:_onClickClose()
	if self._curPetMoList and #self._curPetMoList >= BagModel.ONE_KEY_AWAKE_LIMIT_COUNT then
		UIStateManager.instance:push(ViewName.PetAwakeSelectView, self._curPetMoList)
	end

	self:close()
end

function PetOneKeyAwakeView:_checkPasswordLockPass(list)
	if #list > 0 then
		local isHit = false

		for i, v in ipairs(list) do
			local rare = CharacterConfig.instance:getInitRare(v.mo.raceId)

			if rare >= GameEnum.PetRare.R then
				isHit = true

				break
			end
		end

		if isHit and PasswordLockController.instance:checkNeedOpenVerifyView() then
			return false
		end
	end

	return true
end

return PetOneKeyAwakeView
