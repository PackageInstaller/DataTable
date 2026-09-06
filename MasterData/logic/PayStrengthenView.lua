-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/paystrengthen/view/PayStrengthenView.lua

module("logic.extensions.paystrengthen.view.PayStrengthenView", package.seeall)

local PayStrengthenView = class("PayStrengthenView", ViewComponent)
local emptyList = {}
local idListAll = {
	PayStrengthenModel.LEVEL,
	PayStrengthenModel.STARGOD,
	PayStrengthenModel.AWAKELEVEL,
	PayStrengthenModel.SKILLLEVEL,
	PayStrengthenModel.EQUIPMENT,
	PayStrengthenModel.SELECTSTARGOD
}
local idListLimit = {
	PayStrengthenModel.LEVEL,
	PayStrengthenModel.STARGOD,
	PayStrengthenModel.AWAKELEVEL,
	PayStrengthenModel.SKILLLEVEL,
	PayStrengthenModel.EQUIPMENT
}

function PayStrengthenView:ctor()
	PayStrengthenView.super.ctor(self)
end

function PayStrengthenView:buildUI()
	PayStrengthenView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._panel2 = self:getGo("panel2")
	self._btnAdd = self:getBtn("panel2/pet/btnAdd")
	self._btnChange = self:getBtn("panel2/pet/btnChange")
	self._txtTime2 = self:getTxt("panel2/txtTime")
	self._txtAddGo = self:getGo("panel2/pet/txtAdd")
	self._txtAdd = self:getTxt("panel2/pet/txtAdd")

	local con = self:getGo("img/mask/con")

	self._petPhoto = PetPhotoShow.Get(con)
	self._petParent = self:getGo("img/mask/petCon")
	self._btnStrengthen = self:getBtn("panel2/btnStrengthen")
	self._tableview2 = self:getGo("panel2/tableview2")

	local cellList = {}

	for i = 1, 6 do
		local cell = self:getGo("panel2/tableview2/tableCell_" .. i)

		table.insert(cellList, cell)
	end

	self._scrollList = ScrollerList.create(self._tableview2, cellList, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:regGetTagByIdx(function(data)
		return data
	end)
end

function PayStrengthenView:bindEvents()
	PayStrengthenView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnAdd:AddClickListener(self._onClickAdd, self)
	self._btnChange:AddClickListener(self._onClickChange, self)
	self._btnStrengthen:AddClickListener(self._onClickStrengthen, self)
end

function PayStrengthenView:unbindEvents()
	PayStrengthenView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
	self._btnChange:RemoveClickListener()
	self._btnStrengthen:RemoveClickListener()
end

function PayStrengthenView:onEnter()
	PayStrengthenView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.BagPetAttrChanged, self._onPetDataUpdated, self)
	GlobalDispatcher:addListener(GlobalNotify.onActivityPayStrengthenInfoRes, self._onActivityPayStrengthenInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.onNotifyCommonPayStrengthenSucRes, self._onCommonBuySuccessRes, self)
	GlobalDispatcher:addListener(GlobalNotify.onNotifyActivityPayStrengthenSucRes, self._onActivityBuySuccessRes, self)
	GlobalDispatcher:addListener(GlobalNotify.PayStrengthenSelectStarGodSuc, self._onSelectStarGodSuc, self)

	self._cellMap = {}
	self._selectStarGodList = {}
	self._curSelectPetId = PayStrengthenModel.instance:getCurSelectPetId()
	self._idList = {
		PayStrengthenModel.LEVEL,
		PayStrengthenModel.STARGOD,
		PayStrengthenModel.AWAKELEVEL,
		PayStrengthenModel.SKILLLEVEL,
		PayStrengthenModel.EQUIPMENT,
		PayStrengthenModel.SELECTSTARGOD
	}

	self:_updateActivityCfg()
	self:_updateView()
	self:_setTxtAdd()
	settimer(1, self._onSecond, self)

	if self._activityCfg then
		if self._activityType == GameEnum.ActivityType.PAY_STRENGTHEN then
			PayStrengthenAgent.instance:sendPM_ActivityPayStrengthenInfoReq(self._activityCfg.activityId)
		elseif self._activityType == GameEnum.ActivityType.PAY_STRENGTHEN_EXT then
			PayStrengthenAgent.instance:sendPM_CommonStrengthenTimesLimitInfoReq(self._activityCfg.activityId)
		end
	end
end

function PayStrengthenView:onExit()
	PayStrengthenView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.BagPetAttrChanged, self._onPetDataUpdated, self)
	GlobalDispatcher:removeListener(GlobalNotify.onActivityPayStrengthenInfoRes, self._onActivityPayStrengthenInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.onNotifyCommonPayStrengthenSucRes, self._onCommonBuySuccessRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.onNotifyActivityPayStrengthenSucRes, self._onActivityBuySuccessRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.PayStrengthenSelectStarGodSuc, self._onSelectStarGodSuc, self)
	removetimer(self._onSecond, self)
	self._scrollList:dispose()
	self:_resetBuyCellList()
	self:_resetRoleModel()

	if self._matList then
		for k, v in pairs(self._matList) do
			goutil.destroy(v)

			self._matList[k] = nil
		end
	end
end

function PayStrengthenView:_updateActivityCfg()
	self._activityType = GameEnum.ActivityType.PAY_STRENGTHEN
	self._activityCfg = ActivityDefineController.instance:getActivityCfgByType(self._activityType)

	if self._activityCfg == nil then
		self._activityType = GameEnum.ActivityType.PAY_STRENGTHEN_EXT
		self._activityCfg = ActivityDefineController.instance:getActivityCfgByType(self._activityType)
	end

	if self._activityCfg == nil then
		self._activityType = nil
	end
end

function PayStrengthenView:_onSecond()
	self:_updateTime()
end

function PayStrengthenView:_onClickClose()
	self:close()
	PayStrengthenModel.instance:setCurSelectPetId(nil)
end

function PayStrengthenView:_onClickAdd()
	self:_changeSelectPet()
end

function PayStrengthenView:_onClickChange()
	self:_changeSelectPet()
end

function PayStrengthenView:_onClickStrengthen()
	if self._curSelectPetId and self._curSelectPetId > 0 then
		ViewAutoShowController.instance:saveCurModalView()
		BagPetsController.instance:openBagPetView(self._curSelectPetId, 1)
	else
		FloatWordMgr.instance:show("请先选择精灵")
	end
end

function PayStrengthenView:_onActivityPayStrengthenInfoRes()
	self:_updateCellsInfo()
end

function PayStrengthenView:_onCommonBuySuccessRes(type, param)
	printInfo("test 常驻购买成功 type = ", type, "petId = ", param)
	self:_updateCellsInfo()
end

function PayStrengthenView:_onActivityBuySuccessRes(type, param)
	printInfo("test 活动购买成功 type = ", type, "petId = ", param)
	self:_updateCellsInfo()
end

function PayStrengthenView:_onSelectStarGodSuc(list)
	self._selectStarGodList = list

	self:_updateCellsInfo()
end

function PayStrengthenView:_onPetDataUpdated(oldPet, newPet)
	printInfo("test _onPetDataUpdated")

	if self._curSelectPetId == oldPet.petId then
		TipsFacade.instance:openCommonTips(lang("精灵升级成功"))
		UIStateManager.instance:open(ViewName.PetUp, GameEnum.PetUpType.PetUpgrade, newPet, oldPet)
	end
end

function PayStrengthenView:_changeSelectPet()
	local title = DirectPurchaseConfig.instance:getDirectUpValueByKey(self._activityId, "t_direct_key5")

	local function filterFunc(petMo)
		local rare = CharacterConfig.instance:getInitRare(petMo.raceId)

		return (rare == GameEnum.PetRare.SR or rare == GameEnum.PetRare.SSR or nil) and true
	end

	local function onSeletCallBack(petIds, petIdList)
		if petIdList and #petIdList > 0 then
			self:_updateSelectPetShow(petIdList[1])
		end
	end

	local params = {
		onlyoneOrCount = true,
		showbagpetRaceName = true,
		title = title,
		filterFunc = filterFunc,
		submitFunc = onSeletCallBack
	}

	PetSelectController.instance:OpenViewWithParams(params)
end

function PayStrengthenView:_updateSelectPetShow(petId)
	local bagPetMo = BagModel.instance:getPet(petId)

	if bagPetMo and not goutil.isNil(self._btnAdd) and not goutil.isNil(self._btnChange) and not goutil.isNil(self._txtAddGo) then
		self._btnAdd.gameObject:SetActive(false)
		self._btnChange.gameObject:SetActive(true)
		self._txtAddGo.gameObject:SetActive(false)
		self:_showRoleModel(bagPetMo.curFaceId)
		self:_setCurSelectPet(petId)
	end
end

function PayStrengthenView:_showRoleModel(curFaceId)
	if goutil.isNil(self._petParent) then
		return
	end

	local offset = CharactorFacade.instance:getDirectPurchaseUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	local displayBagOffset = CharactorFacade.instance:getCommonLiHuiUIPosAndScale(curFaceId)

	if not displayBagOffset[3] then
		local x, y, scale = checknumber(displayBagOffset[1]), checknumber(displayBagOffset[2]), 1

		self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._petParent, displayBagOffset[3], function(go)
			if self._matList == nil then
				self._matList = {}
			end

			local list = go:GetComponentsInChildren(typeof(Spine.Unity.SkeletonGraphic), true)
			local idx = 1

			for i = 0, list.Length - 1 do
				local skeletonGraphic = list[i]
				local mat = self._matList[idx]

				if mat == nil then
					mat = UnityEngine.Material.New(Framework.ShaderCache.Find("Spine/SkeletonGraphic (Premultiply Alpha)"))
					self._matList[idx] = mat
					idx = idx + 1
				end

				mat.mainTexture = skeletonGraphic.material.mainTexture
				skeletonGraphic.material = mat
			end
		end, true, x, y)
	end
end

function PayStrengthenView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function PayStrengthenView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local cellView = self._cellMap[data]

	if data == PayStrengthenModel.EQUIPMENT then
		if cellView == nil then
			cellView = LongNvItemsCell.New(data)
			self._cellMap[data] = cellView
		end
	elseif data == PayStrengthenModel.SELECTSTARGOD then
		if cellView == nil then
			cellView = StarGodSelectCell.New(data)
			self._cellMap[data] = cellView
		end
	elseif cellView == nil then
		cellView = LongNvLevelCell.New(data)
		self._cellMap[data] = cellView
	end

	cellView:buildUI(go)
	cellView:bindEvents()
	cellView:init(data, self._activityId, self._activityType)
	cellView:setPetInfo(self._curSelectPetId)

	if data == PayStrengthenModel.SELECTSTARGOD then
		cellView:updateItemList(self._selectStarGodList or emptyList)
	end
end

function PayStrengthenView:_clearCell(cell)
	local idx = cell.index
	local list = self._scrollList:getData()

	if list then
		local data = list[idx + 1]
		local cellView = self._cellMap[data]

		if cellView then
			cellView:unbindEvents()
			cellView:onExit()
		end
	end
end

function PayStrengthenView:_setCurSelectPet(petId)
	self._curSelectPetId = petId

	PayStrengthenModel.instance:setCurSelectPetId(self._curSelectPetId)
	self:_refreshScrollList()
end

function PayStrengthenView:_updateCellsInfo()
	self:_refreshScrollList()
end

function PayStrengthenView:_setTxtAdd()
	self._txtAdd.text = DirectPurchaseConfig.instance:getDirectUpValueByKey(self._activityId, "t_direct_key4")
end

function PayStrengthenView:_updateTime()
	local leftTime = 0

	if self._activityId and self._activityId > 0 then
		local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)

		leftTime = endTime - ServerTime.now()
		leftTime = leftTime >= 0 and leftTime or 0
	else
		leftTime = 0
	end

	self._txtTime2.text = "剩余时间：" .. GameUtil.FormatTimeSymbol(leftTime)
end

function PayStrengthenView:_activeTimeShow(isActive)
	if self._txtTime2.gameObject.activeSelf ~= isActive then
		goutil.setActive(self._txtTime2.gameObject, isActive)
	end
end

function PayStrengthenView:_updateView()
	if self._activityCfg then
		self._activityId = self._activityCfg.activityId

		printInfo("test 活动id =", self._activityId)
		self:_updatePanel2()
		self:_updateTime()
		self:_activeTimeShow(true)
	else
		printInfo("test 不在活动时间内 PayStrengthenView")

		self._activityId = nil

		self:_updatePanel2()
		self:_activeTimeShow(false)
	end
end

function PayStrengthenView:_updatePanel2()
	self._panel2:SetActive(true)
	self:_initPetShow()
	self:_refreshScrollList()
end

function PayStrengthenView:_refreshScrollList()
	local petId = PayStrengthenModel.instance:getCurSelectPetId()
	local bagPetMo = BagModel.instance:getPet(petId)
	local cfg = bagPetMo and PayStrengthenConfig.instance:getRacePCfg(bagPetMo.raceId) or nil

	if cfg then
		self._scrollList:reloadData(idListAll)
	else
		self._scrollList:reloadData(idListLimit)
	end
end

function PayStrengthenView:_resetBuyCellList()
	return
end

function PayStrengthenView:_initPetShow()
	local petId = PayStrengthenModel.instance:getCurSelectPetId()

	printInfo("test 当前petId", petId)

	if petId and petId > 0 then
		self:_updateSelectPetShow(petId)
	else
		self:_setCurSelectPet(nil)
		self:_resetRoleModel()
		self._btnAdd.gameObject:SetActive(true)
		self._btnChange.gameObject:SetActive(false)
		self._txtAddGo.gameObject:SetActive(true)
	end
end

return PayStrengthenView
