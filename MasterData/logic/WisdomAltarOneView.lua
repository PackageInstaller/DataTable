-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wisdomaltar/view/WisdomAltarOneView.lua

module("logic.extensions.wisdomaltar.view.WisdomAltarOneView", package.seeall)

local WisdomAltarOneView = class("WisdomAltarOneView", ViewComponent)

function WisdomAltarOneView:buildUI()
	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")
	self._tableview = self:getGo("listView/ScrollView"):GetComponent("UITableview")
	self._tableCell = self:getGo("listView/Cell")
	self._txtTitle = self:getTxt("txtTitle")
	self._txtTip = self:getTxt("txtTip")
	self._txtMoney = self:getTxt("txtMoney")
	self._matItem = self:getGo("mat")
	self._txtMat = MaterialMgr.findGraphicText(self.mainGO, "mat/Title")
	self._iconMat = self:getGo("mat/Icon")

	self._tableCell:SetActive(false)
end

function WisdomAltarOneView:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
	self._tableview:RegisterCallback(self._numInView, self._cellSizeForIndex, self._cellAtIndex, self)
	self._tableview:RegisterUpdateCellCallback(self._onCellUpdate)
	self._tableview:RegisterReloadFinishCallback(self._onReloadFinish)
end

function WisdomAltarOneView:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._tableview:UnRegisterAllCallbacks()
end

function WisdomAltarOneView:onEnter()
	WisdomAltarOneView.super.onEnter(self)
	self:_updateOneMode()

	self._curViewDatas = WisdomAltarModel.instance:getCurOneModePets()

	self:_sortDatas()
	self._tableview:SetOffsetWithoutRefresh(0)
	self:_updateMoney()
	self._tableview:ReloadData()
	GlobalDispatcher:addListener(PetAgent.PM_BatchPetAwakenRes, self._onBatchPetAwakenRes, self, NotifyPriority.Low)
end

function WisdomAltarOneView:_sortDatas()
	local function sort_func_common(x, y)
		if x == y then
			return false
		end

		return WisdomAltarModel.sortPetsFunc(x.petData, y.petData)
	end

	table.sort(self._curViewDatas, sort_func_common)
end

function WisdomAltarOneView:onExit()
	self._oneMode = nil

	GlobalDispatcher:removeListener(PetAgent.PM_BatchPetAwakenRes, self._onBatchPetAwakenRes, self)
	WisdomAltarOneView.super.onExit(self)
end

function WisdomAltarOneView:onExitFinished()
	WisdomAltarOneView.super.onExitFinished(self)

	self._selextPets = nil

	self._tableview:Travel(function(cell)
		local iconParent = goutil.findChild(cell.gameObject, "Left")

		ItemPet.Remove(iconParent)

		iconParent = goutil.findChild(cell.gameObject, "Right")

		ItemPet.Remove(iconParent)

		iconParent = goutil.findChild(cell.gameObject, "Right")

		ItemPet.Remove(iconParent)

		local btnChoose = Framework.ToggleAdapter.GetFrom(cell.gameObject, "btnChoose")

		btnChoose:RemoveOnValueChanged()

		local middle = goutil.findChild(cell.gameObject, "Middle"):GetComponent(ComponentType.UILayoutSingleLine)
		local childCount = middle.transform.childCount

		for i = 1, childCount do
			local go = middle.transform:GetChild(i - 1).gameObject

			ItemPet.Remove(go)
		end
	end, nil)

	self._isAwaking = nil
end

function WisdomAltarOneView:_updateOneMode()
	self._oneMode = WisdomAltarModel.instance:getCurOneMode()

	local wisCo = WisdomAltarConfig.instance:getWisdomaltarCo(self._oneMode)

	if wisCo then
		self._txtTitle.text = wisCo.name
		self._txtTip.text = wisCo.tips
	end
end

function WisdomAltarOneView:_isInTeam(data)
	return data and FormationNewModel.instance:HasPetAtCurFormation(data.petId)
end

function WisdomAltarOneView:_numInView()
	if not self._curViewDatas then
		return 0
	end

	return #self._curViewDatas
end

function WisdomAltarOneView:_cellSizeForIndex()
	return 510, 110
end

function WisdomAltarOneView:_cellAtIndex(view, idx)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[idx + 1]

	self:_updateCell(view, cell, data)

	return cell
end

function WisdomAltarOneView:_onCellUpdate(view, cell)
	local idx = cell.index
	local data = self._curViewDatas[idx + 1]

	self:_updateCell(view, cell, data)
end

function WisdomAltarOneView:_updateCell(view, cell, data)
	local iconParent = goutil.findChild(cell.gameObject, "Left")
	local component = ItemPet.AddOnce(iconParent)

	component:Init(data.petData)
	component:setSelected(false)
	component:SetInTeam(self:_isInTeam(data.petData))
	self:_fillAwakePetData(cell, data)
	self:_fillMaterials(cell, data)
	self:_fillSelectPet(cell, data)
	component:setGray(false)
end

function WisdomAltarOneView:_fillAwakePetData(cell, data)
	if not data.awakePetData then
		data.awakePetData = BagPetMo.New()

		table.merge(data.awakePetData, data.petData)
		data.awakePetData:setAttrMo()

		data.awakePetData.awakeLevel = data.awakePetData.awakeLevel + 1
		data.awakePetData.awakenLv = data.awakePetData.awakenLv + 1
	end

	local iconParent = goutil.findChild(cell.gameObject, "Right")
	local component = ItemPet.AddOnce(iconParent)

	component:Init(data.awakePetData)
	component:setSelected(false)
	component:SetInTeam(self:_isInTeam(data.awakePetData))
end

function WisdomAltarOneView:_fillSelectPet(cell, data)
	local btnChoose = Framework.ToggleAdapter.GetFrom(cell.gameObject, "btnChoose")

	btnChoose:RemoveOnValueChanged()

	btnChoose.isOn = self:_isPetSelected(data)

	btnChoose:AddOnValueChanged(function(go, isOn)
		self:_selectPet(data, isOn)
		self:_updateMoney()
	end)
end

function WisdomAltarOneView:_fillMaterials(cell, data)
	local middle = goutil.findChild(cell.gameObject, "Middle"):GetComponent(ComponentType.UILayoutSingleLine)
	local childCount = middle.transform.childCount
	local cnt = #data.materials

	while childCount < cnt do
		childCount = childCount + 1

		local child = middle.transform:GetChild(0).gameObject

		UGUIToolHelper.AddChild(middle.gameObject, child)
	end

	for i = 1, cnt do
		local matData = data.materials[i]
		local go = middle.transform:GetChild(i - 1).gameObject

		go:SetActive(true)

		local itemPet = ItemPet.AddOnce(go)

		itemPet:Init(matData)
		itemPet:setSelected(false)
		itemPet:SetInTeam(self:_isInTeam(matData))
	end

	for i = cnt + 1, childCount do
		local go = middle.transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	middle:Layout()
end

function WisdomAltarOneView:_onClickClose()
	self:close()
end

function WisdomAltarOneView:_onClickSure()
	if self._isAwaking then
		return
	end

	self._requestList = self._requestList or {}

	table.clear(self._requestList)

	local materials = self._curViewDatas

	for i = 1, #materials do
		if self:_isPetSelected(materials[i]) then
			table.insert(self._requestList, materials[i])
		end
	end

	if #self._requestList == 0 then
		FloatWordMgr.instance:show("请选择需要升星的精灵")

		return
	end

	local costGold = 0

	for i = 1, #self._requestList do
		costGold = costGold + self._requestList[i].goldCost
	end

	if costGold > MaterialModel.instance:getMaterialsNumber(MatType.Coin, 1) then
		FloatWordMgr.instance:show("金币不足")

		return
	end

	if self._isMatEnough == false then
		FloatWordMgr.instance:show("材料不足")

		return
	end

	self:_sendRequest()
end

function WisdomAltarOneView:_sendRequest()
	local requestList = {}

	for i = 1, #self._requestList do
		local req = PetExtension_pb.PM_AwakenSinglePetReq()

		req.awakenPetId = self._requestList[i].petData.petId

		for j = 1, #self._requestList[i].materials do
			table.insert(req.usedPetIds, self._requestList[i].materials[j].petId)
		end

		table.insert(requestList, req)
	end

	self._isAwaking = true

	PetAgent.instance.instance:sendPM_BatchPetAwakenReq(requestList)
end

function WisdomAltarOneView:_isPetSelected(petData)
	return not self._selextPets or self._selextPets[petData] ~= false
end

function WisdomAltarOneView:_selectPet(petData, isOn)
	self._selextPets = self._selextPets or {}
	self._selextPets[petData] = isOn or false
end

function WisdomAltarOneView:_updateMoney()
	local costMoney = 0
	local materials = self._curViewDatas

	self._isMatEnough = true

	local matMap = {}

	goutil.setActive(self._matItem, false)

	for i = 1, #materials do
		if self:_isPetSelected(materials[i]) then
			costMoney = costMoney + materials[i].goldCost

			local extCostItem = materials[i].extCostItem

			if not string.nilorempty(extCostItem) then
				local arr = string.split(extCostItem, ":")
				local matType = checknumber(arr[1])
				local matId = checknumber(arr[2])
				local matNum = checknumber(arr[3])
				local matKey = matType .. ":" .. matId

				if matMap[matKey] == nil then
					matMap[matKey] = 0
				end

				matMap[matKey] = matMap[matKey] + matNum
			end
		end
	end

	self._txtMoney.text = costMoney
	self._txtMat.text = ""

	local content = "消耗："

	for k, v in pairs(matMap) do
		goutil.setActive(self._matItem, true)

		content = content .. TipsFacade.instance:getContentMatStr(k, 50, -7, true) .. v
	end

	self._txtMat.text = content
end

function WisdomAltarOneView:_onBatchPetAwakenRes(status, msg)
	self._isAwaking = nil

	if status == 0 then
		local changeSetId = msg.changeSetId

		ItemGetController.instance:setTitleType(changeSetId, ItemGetController.TITLE_RETURNMAT)
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)

		local oneMode = self._oneMode

		self:close()
		print("dispatch BatchPetAwakenRes")
		GlobalDispatcher:dispatch(GlobalNotify.PetRedPointUpdate)
		GlobalDispatcher:dispatch(GlobalNotify.BagPetAttrChanged, true)
		GlobalDispatcher:dispatch(GlobalNotify.OnPetSelect)
		ViewMgr.instance:open(ViewName.WisdomAltarOneResView, oneMode, self._requestList, function()
			MaterialController.instance:showChangeSetInTemp(changeSetId)
		end)
	end
end

return WisdomAltarOneView
