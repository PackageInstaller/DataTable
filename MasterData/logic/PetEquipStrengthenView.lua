-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/PetEquipStrengthenView.lua

module("logic.extensions.equipment.view.PetEquipStrengthenView", package.seeall)

local PetEquipStrengthenView = class("PetEquipStrengthenView", TableViewComponent)

function PetEquipStrengthenView:ctor()
	PetEquipStrengthenView.super.ctor(self)

	self.levelStarList = nil
	self.attrItemList = nil
	self.qhNeedCoin = 0
	self.isMax = false
	self.upgNextExp = 0
	self.wearInfoList = nil
	self.isChoiseIndex = 0
	self.toggleList = nil
	self.toggleNum = 0
	self._quaPlanId = -1
	self.exclMatInfo = nil
	self.exclGridList = nil
end

function PetEquipStrengthenView:bindEvents()
	PetEquipStrengthenView.super.bindEvents(self)
	self.putInBtn:AddClickListener(self.OnClickPutInBtn, self)
	self.strengthenBtn:AddClickListener(self.OnClickStrengthenBtn, self)
	self.recycleBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.EquipRecycle, MatType.Decoration)
	end, self)
	self.backClickBtn:AddClickListener(function()
		self._tableview:Refresh()
		self:close()
	end, self)
	self.slideLeftBtn:AddClickListener(function()
		self:OnClickSlideBtn(true)
	end, self)
	self.slideRightBtn:AddClickListener(function()
		self:OnClickSlideBtn(false)
	end, self)
	self.huanjingBtn:AddClickListener(self.OnClickHuanjingBtn, self)
	self.matReduceBtn:AddClickListener(function()
		self:OnClickExclMatBtn(false)
	end, self)
	self.matGotoBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.EquipRecycle, MatType.Equipment)
	end, self)
end

function PetEquipStrengthenView:unbindEvents()
	PetEquipStrengthenView.super.unbindEvents(self)
	self.putInBtn:RemoveClickListener()
	self.strengthenBtn:RemoveClickListener()
	self.recycleBtn:RemoveClickListener()
	self.backClickBtn:RemoveClickListener()
	self.slideLeftBtn:RemoveClickListener()
	self.slideRightBtn:RemoveClickListener()
	self.huanjingBtn:RemoveClickListener()
	self.matReduceBtn:RemoveClickListener()
	self.matGotoBtn:RemoveClickListener()

	for _, tog in pairs(self.toggleList or {}) do
		if tog and tog.itemTog then
			tog.itemTog:RemoveOnValueChanged()
		end
	end
end

function PetEquipStrengthenView:onExit()
	removetimer(self.SetEquipUpgradePlayEff, self)
	MaterialMgr.resetAll(self.equipItemGo)

	self.equipLua = nil

	if self.upgEff then
		UIEffectManager.instance:stopEffect(self.upgEff)

		self.upgEff = nil
	end

	for _, grid in pairs(self.exclGridList or {}) do
		if grid then
			MaterialMgr.resetAll(grid)
		end
	end

	self.exclMatInfo = nil

	PetEquipModel.instance:SetStrengthenFictitiousExp()
	GlobalDispatcher:removeListener(GlobalNotify.PET_EQUIP_UPGRADE, self.EquipUpgradeInfoUpdata, self)
end

function PetEquipStrengthenView:destroyUI()
	PetEquipStrengthenView.super.destroyUI(self)

	self.infoMo = nil
	self.isPlaying = false
	self.isMax = false
	self.wearInfoList = nil

	for _, go in pairs(self.levelStarList or {}) do
		if go then
			UnityEngine.GameObject.Destroy(go)
		end
	end

	self.levelStarList = nil

	for _, item in pairs(self.attrItemList or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self.attrItemList = nil

	for _, item in pairs(self.toggleList or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self.toggleList = nil
	self.qhNeedCoin = 0
	self.isChoiseIndex = 0
	self.upgNextExp = 0
	self.toggleNum = 0
	self._quaPlanId = -1
	self.exclGridList = nil
end

function PetEquipStrengthenView:buildUI()
	PetEquipStrengthenView.super.buildUI(self)

	local subCanvas = goutil.findChildComponent(self.mainGO, "container", "Canvas")
	local mainCanvas = UGUIToolHelper.FindCanvas(self.mainGO)

	subCanvas.sortingOrder = mainCanvas.sortingOrder + 2
	self.goldBarCon = self:getGo("container/goldBarCon")

	local leftInfoGo = self:getGo("container/leftInfo")

	self.quaChangeSpt = goutil.findChildComponent(leftInfoGo, "quaChangeSpt", "UIImageSpriteChange")
	self.equipItemGo = goutil.findChild(leftInfoGo, "equipItemGo")
	self.starGo = goutil.findChild(leftInfoGo, "starGo")
	self.levelStarTranL = goutil.findChild(leftInfoGo, "levelStarTranL").transform
	self.levelStarTranR = goutil.findChild(leftInfoGo, "levelStarTranR").transform
	self.ImageGo2 = goutil.findChild(leftInfoGo, "ImageGo2")
	self.ImageGo3 = goutil.findChild(leftInfoGo, "ImageGo3")
	self.qhBarSli = goutil.findChildComponent(leftInfoGo, "qhBarSli", "Slider")
	self.qhShowTran = goutil.findChild(leftInfoGo, "qhShowTran").transform
	self.qhItemGo = goutil.findChild(leftInfoGo, "qhItem")
	self.petNameTxt = goutil.findChildTextComponent(leftInfoGo, "petNameTxt")
	self.equipNameTxt = goutil.findChildTextComponent(leftInfoGo, "equipNameTxt")
	self.qhNowTxt = goutil.findChildTextComponent(leftInfoGo, "qhNowTxt")
	self.qhNextTxt = goutil.findChildTextComponent(leftInfoGo, "qhNextTxt")
	self.qhNumTxt = goutil.findChildTextComponent(leftInfoGo, "qhNumTxt")

	self.starGo:SetActive(false)

	self.attrItemList = {
		self:SetGameObjectComponent(self.qhItemGo, 1)
	}

	self.attrItemList[1].itemGo:SetActive(false)

	self.lvupEffGo = goutil.findChild(leftInfoGo, "lvupEffGo")
	self.qhtjsxGo = goutil.findChild(leftInfoGo, "qhtjsxGo")

	self.qhtjsxGo:SetActive(false)

	self.slideLeftBtn = Framework.ButtonAdapter.GetFrom(leftInfoGo, "slideLeftBtn")
	self.slideLeftGo = goutil.findChild(leftInfoGo, "slideLeftBtn/slideLeftGo")
	self.leftRedpointGo = goutil.findChild(leftInfoGo, "slideLeftBtn/slideLeftGo/leftRedpointGo")
	self.slideRightBtn = Framework.ButtonAdapter.GetFrom(leftInfoGo, "slideRightBtn")
	self.slideRightGo = goutil.findChild(leftInfoGo, "slideRightBtn/slideRightGo")
	self.rightRedpointGo = goutil.findChild(leftInfoGo, "slideRightBtn/slideRightGo/rightRedpointGo")
	self.petNameTxt.text = ""

	self.leftRedpointGo:SetActive(false)
	self.rightRedpointGo:SetActive(false)
	self.slideLeftBtn.gameObject:SetActive(false)
	self.slideRightBtn.gameObject:SetActive(false)

	self.desTipsTxt = goutil.findChildTextComponent(self.mainGO, "container/desTipsTxt")
	self.rightInfoGo = self:getGo("container/rightInfo")
	self.noEquipListGo = goutil.findChild(self.rightInfoGo, "noEquipListGo")
	self.noEquipListTxt = goutil.findChildTextComponent(self.noEquipListGo, "noEquipListTxt")
	self.huanjingBtn = Framework.ButtonAdapter.GetFrom(self.noEquipListGo, "huanjingBtn")
	self.filterItemTran = goutil.findChild(self.rightInfoGo, "filterItemTran").transform
	self.filterItem = goutil.findChild(self.rightInfoGo, "filterItem")
	self.notFilterGo = goutil.findChild(self.rightInfoGo, "notFilterGo")
	self.downInfoGo = self:getGo("container/downInfo")
	self.moneyIconSpt = goutil.findChildComponent(self.downInfoGo, "moneyIconSpt", "UIImageSpriteChange")
	self.moneyCountTxt = goutil.findChildTextComponent(self.downInfoGo, "moneyCountTxt")
	self.putInBtn = Framework.ButtonAdapter.GetFrom(self.downInfoGo, "putInBtn")
	self.strengthenBtn = Framework.ButtonAdapter.GetFrom(self.downInfoGo, "strengthenBtn")
	self.recycleBtn = Framework.ButtonAdapter.GetFrom(self.downInfoGo, "recycleBtn")
	self.exclMatInfoGo = self:getGo("container/exclMatInfo")
	self.matGridGo = goutil.findChild(self.exclMatInfoGo, "matGridGo")
	self.matReduceBtn = Framework.ButtonAdapter.GetFrom(self.matGridGo, "matReduceBtn")
	self.noMatItemGo = goutil.findChild(self.exclMatInfoGo, "noMatItemGo")
	self.noMatItemTxt = goutil.findChildTextComponent(self.noMatItemGo, "noMatItemTxt")
	self.matGotoBtn = Framework.ButtonAdapter.GetFrom(self.noMatItemGo, "matGotoBtn")
	self.exclGridList = {
		goutil.findChild(self.exclMatInfoGo, "matGrid_1"),
		goutil.findChild(self.exclMatInfoGo, "matGrid_2"),
		goutil.findChild(self.exclMatInfoGo, "matGrid_3"),
		goutil.findChild(self.exclMatInfoGo, "matGrid_4")
	}

	local upInfoGo = self:getGo("container/upInfo")

	self.backClickBtn = Framework.ButtonAdapter.GetFrom(upInfoGo, "backClickBtn")
	self.titleNameTxt = goutil.findChildTextComponent(upInfoGo, "titleNameTxt")
	self.moneyCountTxt.text = "0"
	self.titleNameTxt.text = ""

	GameUtil.SetActive(self.recycleBtn, false)

	self.noEquipListTxt.text = ""

	GameUtil.SetActive(self.noEquipListGo, false)
	self.filterItem:SetActive(false)
	self.notFilterGo:SetActive(false)
	GameUtil.SetActive(self.matReduceBtn, false)
	self.matGridGo:SetActive(false)

	self.noMatItemTxt.text = ""

	self.noMatItemGo:SetActive(false)
	self.exclMatInfoGo:SetActive(false)
end

function PetEquipStrengthenView:onEnter()
	if self._viewPresentor._openParam == nil or self._viewPresentor._openParam[1] == nil then
		error("sr_装备强化   PetEquipStrengthenView:onEnter()    打开界面未传入装备InfoMo！！！")

		return
	end

	local btnList = {
		{
			showAdd = true,
			id = GameEnum.GoldType.Diamond
		},
		{
			showAdd = true,
			id = GameEnum.GoldType.Coin
		}
	}

	MainUIController.instance:showGlodBar(self.goldBarCon, self._viewPresentor, btnList)

	self.maxOneStrtNum = EquipmentConfig.instance:GetMaxOneStrthNum()
	self.infoMo = self._viewPresentor._openParam[1]
	self.petNameTxt.text = ""
	self.wearInfoList, self.isChoiseIndex = PetEquipModel.instance:getPetStrengthenInfoMos(self.infoMo)

	if self.wearInfoList and #self.wearInfoList > 1 then
		self.slideLeftBtn.gameObject:SetActive(true)
		self.slideRightBtn.gameObject:SetActive(true)
		UnityTweens.TweenPosition.StartTween(self.slideLeftGo, Vector3.New(10, 0, 0), Vector3.New(-15, 0, 0), 0.6, UnityTweens.EaseType.easeInSine)
		UnityTweens.UITweenFade.StartTween(self.slideLeftGo, 1, 0, 0.6, UnityTweens.EaseType.easeInQuad)
		UnityTweens.TweenPosition.StartTween(self.slideRightGo, Vector3.New(-10, 0, 0), Vector3.New(15, 0, 0), 0.6, UnityTweens.EaseType.easeInSine)
		UnityTweens.UITweenFade.StartTween(self.slideRightGo, 1, 0, 0.6, UnityTweens.EaseType.easeInQuad)
	else
		UnityTweens.UITweenFade.StopTween(self.slideLeftGo)
		UnityTweens.TweenPosition.StopTween(self.slideLeftGo)
		UnityTweens.UITweenFade.StopTween(self.slideRightGo)
		UnityTweens.TweenPosition.StopTween(self.slideRightGo)
		self.slideLeftBtn.gameObject:SetActive(false)
		self.slideRightBtn.gameObject:SetActive(false)
	end

	self.equipLua = nil
	self.toggleList = self.toggleList or {}
	self._quaPlanId = -1

	self:ResetAllToggleStage()
	self:InitialViewData()
	GlobalDispatcher:addListener(GlobalNotify.PET_EQUIP_UPGRADE, self.EquipUpgradeInfoUpdata, self)
end

function PetEquipStrengthenView:OnClickSlideBtn(isLeft)
	if self.isChoiseIndex <= 0 or #self.wearInfoList < 1 then
		return
	end

	if isLeft then
		self.isChoiseIndex = self.isChoiseIndex - 1

		if self.isChoiseIndex <= 0 then
			self.isChoiseIndex = #self.wearInfoList
		end
	else
		self.isChoiseIndex = self.isChoiseIndex + 1

		if self.isChoiseIndex > #self.wearInfoList then
			self.isChoiseIndex = 1
		end
	end

	self.infoMo = self.wearInfoList[self.isChoiseIndex]

	if self.infoMo == nil then
		if isLeft then
			self.infoMo = self.wearInfoList[1] or self.wearInfoList[#self.wearInfoList]
		end
	end

	self:ResetAllToggleStage()
	self:InitialViewData()
end

function PetEquipStrengthenView:InitialViewData()
	PetEquipModel.instance:SetStrengthenFictitiousExp()

	if self.upgEff then
		UIEffectManager.instance:stopEffect(self.upgEff)

		self.upgEff = nil
	end

	self.isPlaying = false

	self:UpdataStrengthenMatList()
	self._tableview:MoveCellInView(0, false)
end

function PetEquipStrengthenView:EquipUpgradeInfoUpdata()
	PetEquipModel.instance:SetStrengthenFictitiousExp()
	self:PlayEquipUpgradeEff()
	self:UpdataStrengthenMatList(true)
end

function PetEquipStrengthenView:UpdataStrengthenMatList(isAgain)
	self.exclMatInfo = nil

	self:ForceUpdataLeftInfo()

	if self.infoMo.matType == MatType.Equipment then
		self.moneyCountTxt.text = "0"

		GameUtil.SetActive(self.moneyIconSpt, true)
	elseif self.infoMo.matType == MatType.Decoration then
		self.moneyCountTxt.text = ""

		GameUtil.SetActive(self.moneyIconSpt, false)
	end

	MaterialMgr.resetAll(self.matGridGo)

	for _, grid in pairs(self.exclGridList or {}) do
		if grid then
			MaterialMgr.resetAll(grid)
		end
	end

	self.matLua = nil
	self.choiseStrtNum = 0

	if checknumber(self.infoMo.exclRaceId) > 0 then
		self._curViewDatas = {}

		self:reloadData()
		self.exclMatInfoGo:SetActive(true)

		local matList = EquipmentConfig.instance:GetExclusiveMaterial()

		if matList then
			if not matList[self.infoMo.wearPos] then
				local matInfo
				local haveCount = 0

				if matInfo and checknumber(matInfo.id) > 0 then
					local count = MaterialModel.instance:getMaterialsNumber(MatType.Item, matInfo.id)

					if checknumber(count) > 0 then
						haveCount = count
					end
				end

				if haveCount > 0 then
					self.noMatItemTxt.text = ""

					GameUtil.SetActive(self.matReduceBtn, false)
					self.noMatItemGo:SetActive(false)
					self.matGridGo:SetActive(true)

					self.matLua = MaterialMgr.setCell(MatType.Item, matInfo.id, self.matGridGo)

					self.matLua.binder:setNum(haveCount, 0)
					self.matLua.binder:setAutoTips(false)
					self.matLua.binder:setCallBack(function()
						self:OnClickExclMatBtn(true)
					end)

					self.exclMatInfo = {
						useCount = 0,
						matId = matInfo.id,
						matExp = matInfo.exp,
						allCount = haveCount
					}

					local index = 0
					local tempLua

					for i = 1, #matList do
						if matList[i] and matList[i].id ~= self.infoMo.wearPos then
							index = matList[i].id > self.infoMo.wearPos and i - 1 and i

							if self.exclGridList[index] then
								if not self.exclGridList[index].activeSelf then
									GameUtil.SetActive(self.exclGridList[index], true)
								end

								tempLua = MaterialMgr.setCell(MatType.Item, matList[i].id, self.exclGridList[index])

								tempLua.binder:setNum(0)
								tempLua.binder:setAutoTips(false)
								tempLua.binder:setGray(true)
							end
						end
					end
				else
					for _, grid in pairs((not self.exclGridList or nil) and {}) do
						if grid and grid.activeSelf then
							GameUtil.SetActive(grid, false)
						end
					end

					self.matGridGo:SetActive(false)
					self.noMatItemGo:SetActive(true)

					self.noMatItemTxt.text = lang("text_equip_desc_92")
				end

				self.rightInfoGo:SetActive(false)

				return
			end
		end
	end

	self.exclMatInfoGo:SetActive(false)
	self.rightInfoGo:SetActive(true)

	local togInfo

	if self.toggleList and self.toggleList[self.toggleNum] then
		togInfo = {
			quaNum = self.toggleList[self.toggleNum].quaNum,
			isBase = self.toggleList[self.toggleNum].isBase
		}
	end

	self._curViewDatas = PetEquipController.instance:mergeStrengthenEquipList(togInfo, self.infoMo, true)

	if isAgain and self.toggleNum > 0 and (self._curViewDatas == nil or #self._curViewDatas == 0) then
		self:ResetAllToggleStage()

		togInfo = nil

		if self.toggleList and self.toggleList[self.toggleNum] then
			togInfo = {
				quaNum = self.toggleList[self.toggleNum].quaNum,
				isBase = self.toggleList[self.toggleNum].isBase
			}
		end

		self._curViewDatas = PetEquipController.instance:mergeStrengthenEquipList(togInfo, self.infoMo, true)
	end

	if self.toggleNum <= 0 and (self._curViewDatas == nil or #self._curViewDatas == 0) then
		GameUtil.SetActive(self.noEquipListGo, true)

		if self.infoMo.matType == MatType.Equipment then
			self.noEquipListTxt.text = lang("text_equip_desc_47")

			GameUtil.SetActive(self.huanjingBtn, true)
		elseif self.infoMo.matType == MatType.Decoration then
			self.noEquipListTxt.text = lang("text_equip_desc_49")

			GameUtil.SetActive(self.huanjingBtn, false)
		end
	else
		GameUtil.SetActive(self.noEquipListGo, false)
	end

	self:reloadData()
end

function PetEquipStrengthenView:ResetAllToggleStage()
	self.toggleNum = 0
	self.isReset = true

	if self.toggleList and #self.toggleList > 0 then
		for i = 1, #self.toggleList do
			if self.toggleList[i] and self.toggleList[i].itemGo and self.toggleList[i].itemGo.activeSelf and self.toggleList[i].itemTog.isOn then
				self.toggleList[i].itemTog.isOn = false
			end
		end
	end

	if checknumber(self.infoMo.exclRaceId) > 0 then
		self.isReset = false

		return
	end

	local id, togList = PetEquipModel.instance:GetChoiseQualityPlanId(self.infoMo.matType, true)

	if self._quaPlanId == checknumber(id) then
		self.isReset = false

		return
	end

	self._quaPlanId = checknumber(id)

	if self._quaPlanId <= 0 then
		self.notFilterGo:SetActive(true)

		if self.toggleList and #self.toggleList > 0 then
			for i = 1, #self.toggleList do
				if self.toggleList[i] and self.toggleList[i].itemGo and self.toggleList[i].itemGo.activeSelf then
					if self.toggleList[i].itemTog.isOn then
						self.toggleList[i].itemTog.isOn = false
					end

					self.toggleList[i].itemGo:SetActive(false)
				end
			end
		end
	else
		self.notFilterGo:SetActive(false)

		self.toggleList = self.toggleList or {}

		for i = 1, #togList do
			if self.toggleList[i] == nil or self.toggleList[i].itemGo == nil then
				local item = UnityEngine.GameObject.Instantiate(self.filterItem, self.filterItemTran)

				self.toggleList[i] = self:SetGameObjectComponent(item, 2)
			end

			if self.toggleList[i] and togList[i] then
				self.toggleList[i].itemTog:RemoveOnValueChanged()
				self.toggleList[i].itemGo:SetActive(true)

				self.toggleList[i].itemTog.isOn = false
				self.toggleList[i].itemTxt.text = togList[i].qualityName
				self.toggleList[i].quaNum = togList[i].qualityNum
				self.toggleList[i].isBase = togList[i].isBase

				self.toggleList[i].itemTog:AddOnValueChanged(function(go, isOn)
					self:OnToggleValueChanged(i, isOn)
				end)
			end
		end

		if #togList < #self.toggleList then
			for j = #togList + 1, #self.toggleList do
				if self.toggleList[j] and self.toggleList[j].itemGo and self.toggleList[j].itemGo.activeSelf then
					if self.toggleList[j].itemTog.isOn then
						self.toggleList[j].itemTog.isOn = false
					end

					self.toggleList[j].itemGo:SetActive(false)
				end
			end
		end
	end

	self.isReset = false
end

function PetEquipStrengthenView:OnToggleValueChanged(index, isOn)
	if not isOn then
		if self.toggleNum ~= index then
			return
		end

		self.toggleNum = 0
	else
		if self.isReset then
			self.toggleNum = 0

			return
		end

		local togInfo
		local list = PetEquipController.instance:mergeStrengthenEquipList((self.toggleList and self.toggleList[index] or nil) and {
			quaNum = self.toggleList[index].quaNum,
			isBase = self.toggleList[index].isBase
		}, self.infoMo)

		if list == nil or #list == 0 then
			if self.toggleList and self.toggleList[index] and self.toggleList[index].itemTog then
				self.toggleList[index].itemTog.isOn = false
			end

			FloatWordMgr.instance:show(lang("text_equip_desc_70"))

			return
		end

		if self.toggleList and self.toggleList[self.toggleNum] then
			self.toggleList[self.toggleNum].itemTog.isOn = false
		end

		self.toggleNum = index
	end

	self:InitialViewData()
end

function PetEquipStrengthenView:PlayEquipUpgradeEff()
	if self.isPlaying then
		return
	end

	self.isPlaying = true

	if self.upgEff then
		UIEffectManager.instance:stopEffect(self.upgEff)

		self.upgEff = nil
	end

	local effPath = "fx_ui_jingyanshengji/fx_ui_jingyan_shengji.prefab"

	settimer(0.3, self.SetEquipUpgradePlayEff, self, false)

	self.upgEff = UIEffectManager.instance:playHUDEffect(effPath, self.lvupEffGo, false, nil, nil, function(finishHandlerTarget, eff)
		GoUtil.SetSortingOrder(eff.effGo, UGUIToolHelper.GetNodeCanvansSortingOrder(self.lvupEffGo) + 1)
		Framework.TransformUtil.SetLocalScale(eff.effGo.transform, 1, 1, 1)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
	end, nil, false)
end

function PetEquipStrengthenView:SetEquipUpgradePlayEff()
	self.isPlaying = false
end

function PetEquipStrengthenView:ForceUpdataLeftInfo()
	self.quaChangeSpt:SetState(self.infoMo.qualityBase)

	local _, colorStr = PetEquipController.instance:GetQualityStrByNum(self.infoMo.qualityBase, true)

	self.equipNameTxt.text = string.format("<color=%s>%s</color>", colorStr, self.infoMo.name)

	if self.qhtjsxGo.activeSelf then
		self.qhtjsxGo:SetActive(false)
	end

	self.levelStarList = self.levelStarList or {}

	if self.infoMo.matType == MatType.Equipment then
		self.costDecoRatio = EquipmentConfig.instance:GetCostDecoRatio()
		self.desTipsTxt.text = langPara("text_equip_desc_50", self.costDecoRatio)

		GameUtil.SetActive(self.recycleBtn, false)
		self:UpdataEquipAttrList()
	elseif self.infoMo.matType == MatType.Decoration then
		self.costDecoRatio = DecorationConfig.instance:GetCostDecoRatio()

		MaterialMgr.resetAll(self.equipItemGo)

		self.equipLua = nil
		self.desTipsTxt.text = langPara("text_equip_desc_51", self.costDecoRatio)

		GameUtil.SetActive(self.recycleBtn, true)
		self:UpdataDecorationAttrList()
	end
end

function PetEquipStrengthenView:UpdataEquipAttrList()
	self.titleNameTxt.text = lang("text_equip_desc_52")

	local nowEquipInfo, nextEquipInfo = PetEquipModel.instance:GetEquipNowNextAttrList(self.infoMo)
	local petInfo = BagPetsController.instance:getPet(self.infoMo.equipPetId)
	local isAddAttr = false
	local isExclAttr = false

	if checknumber(self.infoMo.exclRaceId) > 0 then
		isExclAttr = true
	elseif petInfo then
		isAddAttr = PetSkinConfig.instance:checkHasEleAttr(petInfo.curFaceId, self.infoMo.attrType) or AttrMo.checkHasYuanEle(petInfo.curFaceId, self.infoMo.attrType)
	end

	if self.equipLua == nil or self.equipLua.binder:getData().onlyId ~= self.infoMo.onlyId then
		MaterialMgr.resetAll(self.equipItemGo)

		self.equipLua = MaterialMgr.setCellByData(MatType.Equipment, self.infoMo, self.equipItemGo)

		if isAddAttr then
			self.equipLua.binder:SetView(self)
			self.equipLua.binder:PlayAttrTypeEffect()
		else
			self.equipLua.binder:PlayAttrTypeEffect(true)
		end
	end

	self.equipLua.binder:setLvl(nowEquipInfo.starCount)

	self.isMax = nextEquipInfo == nil

	self.ImageGo2:SetActive(not self.isMax)
	self.ImageGo3:SetActive(not self.isMax)
	self:CreatLeftXingxing(nowEquipInfo.starCount, self.isMax)

	local count = 0

	if self.isMax then
		self.qhBarSli.value = 1
		self.qhNumTxt.text = lang("text_equip_desc_53")
		self.qhNowTxt.text = "Lv" .. nowEquipInfo.starCount .. "(MAX)"

		Framework.TransformUtil.SetLocalPos(self.qhNowTxt.gameObject.transform, -37, -36.5, 0)

		self.qhNextTxt.text = ""
		self.upgNextExp = nowEquipInfo.levelExp
	else
		local rightStart = 2

		count = 1 + nextEquipInfo.starCount

		if nowEquipInfo.starCount >= 1 then
			rightStart = nowEquipInfo.starCount + 1
			count = nowEquipInfo.starCount + nextEquipInfo.starCount
		end

		self:CreatRightXingxing(rightStart, count)

		self.upgNextExp = nextEquipInfo.levelExp

		self:CalculationProgress(nowEquipInfo.levelExp, nextEquipInfo.levelExp, nowEquipInfo.starCount, nextEquipInfo.starCount)
	end

	if self.levelStarList and count < #self.levelStarList then
		for i = count + 1, #self.levelStarList do
			if self.levelStarList[i] and self.levelStarList[i].activeSelf then
				self.levelStarList[i]:SetActive(false)
			end
		end
	end

	count = nowEquipInfo.attrList and #nowEquipInfo.attrList or 0

	if isExclAttr then
		count = nowEquipInfo.attrExclList and #nowEquipInfo.attrExclList or 0
	elseif isAddAttr then
		count = nowEquipInfo.attrAddList and #nowEquipInfo.attrAddList or 0
	end

	if self.attrItemList and count < #self.attrItemList then
		for i = count + 1, #self.attrItemList do
			if self.attrItemList[i] and self.attrItemList[i].itemGo.activeSelf then
				self.attrItemList[i].itemGo:SetActive(false)
			end
		end
	end

	if count <= 0 then
		return
	end

	for i = 1, count do
		if self.attrItemList[i] == nil then
			local item = UnityEngine.GameObject.Instantiate(self.qhItemGo, self.qhShowTran)

			self.attrItemList[i] = self:SetGameObjectComponent(item, 1)
		end

		if i == 1 then
			self.attrItemList[i].itemGo.transform:SetParent(self.qhShowTran)
		end

		self.attrItemList[i].itemGo:SetActive(true)

		local num = i - math.floor(i / 2) * 2

		self.attrItemList[i].itemIma:SetState(num)
		self.attrItemList[i].attrIconSpt:SetState(nowEquipInfo.attrList[i].index - 1)

		self.attrItemList[i].qhNameTxt.text = nowEquipInfo.attrList[i].name

		if isExclAttr then
			self.attrItemList[i].qhNowCountTxt.text = tostring(nowEquipInfo.attrExclList[i].extCount)

			if string.find(nowEquipInfo.attrExclList[i].name, lang("text_equip_lv")) then
				self.attrItemList[i].qhNowCountTxt.text = nowEquipInfo.attrExclList[i].extCount * 100 .. "%"
			end
		elseif isAddAttr then
			self.attrItemList[i].qhNowCountTxt.text = tostring(nowEquipInfo.attrAddList[i].extCount)

			if string.find(nowEquipInfo.attrAddList[i].name, lang("text_equip_lv")) then
				self.attrItemList[i].qhNowCountTxt.text = nowEquipInfo.attrAddList[i].extCount * 100 .. "%"
			end
		else
			self.attrItemList[i].qhNowCountTxt.text = tostring(nowEquipInfo.attrList[i].extCount)

			if string.find(nowEquipInfo.attrList[i].name, lang("text_equip_lv")) then
				self.attrItemList[i].qhNowCountTxt.text = nowEquipInfo.attrList[i].extCount * 100 .. "%"
			end
		end

		if self.isMax then
			self.attrItemList[i].ImageGo5:SetActive(false)

			self.attrItemList[i].qhNextCountTxt.text = ""
		else
			self.attrItemList[i].ImageGo5:SetActive(true)

			if isExclAttr then
				self.attrItemList[i].qhNextCountTxt.text = tostring(nextEquipInfo.attrExclList[i].extCount)

				if string.find(nextEquipInfo.attrExclList[i].name, lang("text_equip_lv")) then
					self.attrItemList[i].qhNextCountTxt.text = nextEquipInfo.attrExclList[i].extCount * 100 .. "%"
				end
			elseif isAddAttr then
				self.attrItemList[i].qhNextCountTxt.text = tostring(nextEquipInfo.attrAddList[i].extCount)

				if string.find(nextEquipInfo.attrAddList[i].name, lang("text_equip_lv")) then
					self.attrItemList[i].qhNextCountTxt.text = nextEquipInfo.attrAddList[i].extCount * 100 .. "%"
				end
			else
				self.attrItemList[i].qhNextCountTxt.text = tostring(nextEquipInfo.attrList[i].extCount)

				if string.find(nextEquipInfo.attrList[i].name, lang("text_equip_lv")) then
					self.attrItemList[i].qhNextCountTxt.text = nextEquipInfo.attrList[i].extCount * 100 .. "%"
				end
			end
		end
	end
end

function PetEquipStrengthenView:UpdataDecorationAttrList()
	self.titleNameTxt.text = lang("text_equip_desc_54")

	local subLua = MaterialMgr.setCellByData(MatType.Decoration, self.infoMo, self.equipItemGo)
	local attrInfo = PetEquipModel.instance:GetDecoratNextMainAttrValue(self.infoMo)

	if attrInfo == nil then
		printError("sr---- PetEquipStrengthenView:UpdataDecorationAttrList()    获取饰品下个属性空  onlyId = ", self.infoMo.onlyId)

		return
	end

	if attrInfo.isFuAttr and not self.qhtjsxGo.activeSelf then
		self.qhtjsxGo:SetActive(true)
	end

	self.isMax = attrInfo.isMax

	subLua.binder:setLvl(self.infoMo.starCount)
	self.ImageGo2:SetActive(not self.isMax)
	self.ImageGo3:SetActive(not self.isMax)

	local xxShowCount = self:XingXingShowCount(attrInfo.nowLv)

	self:CreatLeftXingxing(xxShowCount, self.isMax, attrInfo.nowLv)

	local count = 0

	if self.isMax then
		self.qhBarSli.value = 1
		self.qhNumTxt.text = lang("text_equip_desc_53")
		self.qhNowTxt.text = "Lv" .. attrInfo.nextLv .. "(MAX)"

		Framework.TransformUtil.SetLocalPos(self.qhNowTxt.gameObject.transform, -37, -36.5, 0)

		self.qhNextTxt.text = ""
		self.upgNextExp = attrInfo.nowExp
	else
		local rightStart = 2

		count = 1 + xxShowCount + 1

		if attrInfo.nowLv >= 1 then
			rightStart = xxShowCount + 1
			count = xxShowCount + self:XingXingShowCount(attrInfo.nextLv)
		end

		self:CreatRightXingxing(rightStart, count, attrInfo.nextLv)

		self.upgNextExp = attrInfo.nextExp

		self:CalculationProgress(attrInfo.nowExp, attrInfo.nextExp, attrInfo.nowLv, attrInfo.nextLv)
	end

	if self.levelStarList and count < #self.levelStarList then
		for i = count + 1, #self.levelStarList do
			if self.levelStarList[i] and self.levelStarList[i].activeSelf then
				self.levelStarList[i]:SetActive(false)
			end
		end
	end

	local attrCount = #self.infoMo.addAttrs

	if self.attrItemList and attrCount < #self.attrItemList then
		for i = attrCount + 1, #self.attrItemList do
			if self.attrItemList[i] and self.attrItemList[i].itemGo.activeSelf then
				self.attrItemList[i].itemGo:SetActive(false)
			end
		end
	end

	if attrCount <= 0 then
		return
	end

	for i = 1, attrCount do
		if self.attrItemList[i] == nil then
			local item = UnityEngine.GameObject.Instantiate(self.qhItemGo, self.qhShowTran)

			self.attrItemList[i] = self:SetGameObjectComponent(item, 1)
		end

		if i == 1 then
			self.attrItemList[i].itemGo.transform:SetParent(self.qhShowTran)
		end

		local info = self.infoMo.addAttrs[i]

		self.attrItemList[i].itemGo:SetActive(true)

		local num = i - math.floor(i / 2) * 2

		self.attrItemList[i].itemIma:SetState(num)

		local name = GameEnum.AttrTypeName[info.proertyType]
		local index = PetEquipModel.instance:GetChineseAttrIndex(name)

		self.attrItemList[i].attrIconSpt:SetState(index - 1)

		self.attrItemList[i].qhNameTxt.text = name

		local value = checknumber(info.value)

		if i == 1 then
			value = value + attrInfo.addValue
		end

		local isHaveLv = string.find(name, lang("text_equip_lv"))

		if isHaveLv then
			local str = string.format("%.2f", value)

			self.attrItemList[i].qhNowCountTxt.text = checknumber(str) * 100 .. "%"
		else
			self.attrItemList[i].qhNowCountTxt.text = tostring(value)
		end

		if self.isMax or i > 1 then
			self.attrItemList[i].ImageGo5:SetActive(false)

			self.attrItemList[i].qhNextCountTxt.text = ""
		else
			self.attrItemList[i].ImageGo5:SetActive(true)

			value = attrInfo.attrValue

			if i == 1 then
				value = value + checknumber(info.value) + attrInfo.addValue
			end

			if isHaveLv then
				local str = string.format("%.2f", value)

				self.attrItemList[i].qhNextCountTxt.text = checknumber(str) * 100 .. "%"
			else
				self.attrItemList[i].qhNextCountTxt.text = tostring(value)
			end
		end
	end
end

function PetEquipStrengthenView:CreatLeftXingxing(xxNumL, isMax, count)
	if xxNumL <= 0 then
		if self.levelStarList[1] == nil then
			self.levelStarList[1] = UnityEngine.GameObject.Instantiate(self.starGo, self.levelStarTranL)
		else
			self.levelStarList[1].transform:SetParent(self.levelStarTranL)
		end

		self.levelStarList[1]:GetComponent("UIImageSpriteChange"):SetState(3)

		self.levelStarList[1].name = "levelStarGoL"

		self.levelStarList[1]:SetActive(true)

		return
	end

	if isMax then
		return
	end

	for i = 1, xxNumL do
		if self.levelStarList[i] == nil then
			self.levelStarList[i] = UnityEngine.GameObject.Instantiate(self.starGo, self.levelStarTranL)
		else
			self.levelStarList[i].transform:SetParent(self.levelStarTranL)
		end

		local index = 0

		if self.infoMo.matType == MatType.Equipment then
			-- block empty
		elseif self.infoMo.matType == MatType.Decoration then
			count = count or self.infoMo.starCount

			if count > 6 and count <= 12 then
				index = 1
			elseif count > 12 then
				index = 2
			end
		end

		self.levelStarList[i]:GetComponent("UIImageSpriteChange"):SetState(index)

		self.levelStarList[i].name = "levelStarGoL"

		self.levelStarList[i]:SetActive(true)
	end
end

function PetEquipStrengthenView:CreatRightXingxing(xxNumL, xxNumR, count)
	if xxNumR < xxNumL then
		return
	end

	for i = xxNumL, xxNumR do
		if self.levelStarList[i] == nil then
			local go = UnityEngine.GameObject.Instantiate(self.starGo, self.levelStarTranR)

			go:GetComponent("RectTransform").sizeDelta = Vector2.New(35, 35)
			self.levelStarList[i] = go
		else
			self.levelStarList[i].transform:SetParent(self.levelStarTranR)
		end

		local index = 0

		if self.infoMo.matType == MatType.Equipment then
			-- block empty
		elseif self.infoMo.matType == MatType.Decoration then
			count = count or self.infoMo.starCount

			if count > 6 and count <= 12 then
				index = 1
			elseif count > 12 then
				index = 2
			end
		end

		self.levelStarList[i]:GetComponent("UIImageSpriteChange"):SetState(index)

		self.levelStarList[i].name = "levelStarGoR"

		self.levelStarList[i]:SetActive(true)
	end
end

function PetEquipStrengthenView:CalculationProgress(nowExp, nextExp, nowStarCount, nextStarCount)
	local fictExp = PetEquipModel.instance:GetStrengthenFictitiousExp()
	local exp = self.infoMo.haveAllExp + fictExp - nowExp

	exp = exp < 0 and 0 or exp
	self.qhBarSli.value = exp / (nextExp - nowExp)
	self.qhNumTxt.text = exp .. "/" .. nextExp - nowExp
	self.qhNowTxt.text = "Lv" .. nowStarCount

	Framework.TransformUtil.SetLocalPos(self.qhNowTxt.gameObject.transform, -108, -36.5, 0)

	self.qhNextTxt.text = "Lv" .. nextStarCount
end

function PetEquipStrengthenView:SetGameObjectComponent(cell, cellType)
	local cellComInfo = {}

	cellComInfo.itemGo = cell

	if cellType == 1 then
		cellComInfo.itemIma = cell:GetComponent("UIImageColorChange")
		cellComInfo.attrIconSpt = goutil.findChildComponent(cell, "attrIconSpt", "UIImageSpriteChange")
		cellComInfo.ImageGo5 = goutil.findChild(cell, "ImageGo5")
		cellComInfo.qhNameTxt = goutil.findChildTextComponent(cell, "qhNameTxt")
		cellComInfo.qhNowCountTxt = goutil.findChildTextComponent(cell, "qhNowCountTxt")
		cellComInfo.qhNextCountTxt = goutil.findChildTextComponent(cell, "qhNextCountTxt")
	elseif cellType == 2 then
		cellComInfo.itemTog = Framework.ToggleAdapter.GetFrom(cell, "itemTog")
		cellComInfo.itemTxt = goutil.findChildTextComponent(cell, "itemTxt")
	end

	return cellComInfo
end

function PetEquipStrengthenView:XingXingShowCount(count)
	local xxCount = count

	if count > 12 then
		xxCount = count - 12
	elseif count > 6 and count <= 12 then
		xxCount = count - 6
	end

	return xxCount
end

function PetEquipStrengthenView:_getPath()
	return {
		cellPath = "container/rightInfo/itemGridGo",
		viewPath = "container/rightInfo/equipListSR"
	}
end

function PetEquipStrengthenView:_cellSize()
	return 110, 110
end

function PetEquipStrengthenView:_updateCell(view, cell, data)
	local itemSpt = cell:GetComponent(goutil.Type_UIImage)
	local reduceBtnGo = goutil.findChild(cell, "reduceBtn")

	GameUtil.asBtn(reduceBtnGo):RemoveClickListener()
	reduceBtnGo:SetActive(false)
	MaterialMgr.resetAll(cell)

	if data == nil or data.isEmpty then
		itemSpt.enabled = true

		return
	end

	local subLua
	local allNum, useNum = 1, 0

	if data.isEquip then
		local equipInfo = PetEquipModel.instance:GetInfoMoByOnlyId(data.onlyId, self.infoMo.matType)

		if equipInfo then
			subLua = MaterialMgr.setCellByData(self.infoMo.matType, equipInfo, cell)
		end

		if data.countList and #data.countList > 1 then
			allNum = #data.countList
		end

		if data.useCount > 0 then
			useNum = data.useCount
		end
	else
		subLua = MaterialMgr.setCell(MatType.Item, data.baseId, cell)
		allNum = data.count

		if data.useCount > 0 then
			useNum = data.useCount
		end
	end

	if subLua and subLua.binder then
		local index = cell.data

		itemSpt.enabled = false

		if allNum <= 1 then
			subLua.binder:setNum()
		else
			subLua.binder:setNum(allNum, useNum)
		end

		subLua.binder:setAutoTips(false)
		subLua.binder:setSelected(useNum > 0)
		subLua.binder:setCallBack(function()
			self:SetChoiseStrengthen(index, true)
		end)

		if useNum > 0 then
			reduceBtnGo:SetActive(true)
			reduceBtnGo.transform:SetAsLastSibling()
			GameUtil.asBtn(reduceBtnGo):AddClickListener(function()
				self:SetChoiseStrengthen(index, false)
			end, self)
		end
	else
		itemSpt.enabled = true

		MaterialMgr.resetAll(cell)
	end
end

function PetEquipStrengthenView:SetChoiseStrengthen(index, isAdd)
	if self._curViewDatas == nil or self._curViewDatas[index] == nil or self._curViewDatas[index].isEmpty then
		return
	end

	if isAdd then
		if self.isMax then
			FloatWordMgr.instance:show(lang("text_equip_desc_55"))

			return
		end

		self:AddChoiseStrengthen(index)
	elseif self._curViewDatas[index].isEquip then
		if self._curViewDatas[index].countList then
			if self._curViewDatas[index].useCount <= 0 then
				if self.infoMo.matType == MatType.Equipment then
					FloatWordMgr.instance:show(lang("text_equip_desc_9"))
				elseif self.infoMo.matType == MatType.Decoration then
					FloatWordMgr.instance:show(lang("text_equip_desc_57"))
				end

				return
			end

			self._curViewDatas[index].useCount = self._curViewDatas[index].useCount - 1

			if self._curViewDatas[index].useCount <= 0 then
				self._curViewDatas[index].useCount = 0
			end
		else
			if self._curViewDatas[index].useCount <= 0 then
				if self.infoMo.matType == MatType.Equipment then
					FloatWordMgr.instance:show(lang("text_equip_desc_58"))
				elseif self.infoMo.matType == MatType.Decoration then
					FloatWordMgr.instance:show(lang("text_equip_desc_59"))
				end

				return
			end

			self._curViewDatas[index].useCount = 0
		end

		PetEquipModel.instance:SetStrengthenFictitiousExp(-self._curViewDatas[index].allExp * self.costDecoRatio / 100)
	else
		if self._curViewDatas[index].useCount <= 0 then
			FloatWordMgr.instance:show(lang("text_equip_desc_16"))

			return
		end

		self._curViewDatas[index].useCount = self._curViewDatas[index].useCount - 1

		if self._curViewDatas[index].useCount <= 0 then
			self._curViewDatas[index].useCount = 0
		end

		PetEquipModel.instance:SetStrengthenFictitiousExp(-self._curViewDatas[index].allExp)
	end

	self:CalculationNeedCoin()
end

function PetEquipStrengthenView:AddChoiseStrengthen(index, addCount)
	if self._curViewDatas == nil or self._curViewDatas[index] == nil or self._curViewDatas[index].isEmpty then
		return
	end

	addCount = addCount or 1

	if self._curViewDatas[index].isEquip then
		if self.choiseStrtNum >= self.maxOneStrtNum then
			FloatWordMgr.instance:show(lang("text_equip_desc_56"))

			return false
		end

		if self._curViewDatas[index].countList then
			if #self._curViewDatas[index].countList <= self._curViewDatas[index].useCount then
				if self.infoMo.matType == MatType.Equipment then
					FloatWordMgr.instance:show(lang("text_equip_desc_7"))
				elseif self.infoMo.matType == MatType.Decoration then
					FloatWordMgr.instance:show(lang("text_equip_desc_60"))
				end

				return false
			end

			self._curViewDatas[index].useCount = self._curViewDatas[index].useCount + addCount
		else
			if self._curViewDatas[index].useCount > 0 then
				if self.infoMo.matType == MatType.Equipment then
					FloatWordMgr.instance:show(lang("text_equip_desc_61"))
				elseif self.infoMo.matType == MatType.Decoration then
					FloatWordMgr.instance:show(lang("text_equip_desc_62"))
				end

				return false
			end

			self._curViewDatas[index].useCount = addCount
		end

		PetEquipModel.instance:SetStrengthenFictitiousExp(self._curViewDatas[index].allExp * addCount * self.costDecoRatio / 100)

		return true
	end

	if self.choiseStrtNum >= self.maxOneStrtNum and self._curViewDatas[index].useCount <= 0 then
		FloatWordMgr.instance:show(lang("text_equip_desc_56"))

		return false
	end

	if self._curViewDatas[index].count <= self._curViewDatas[index].useCount then
		FloatWordMgr.instance:show(lang("text_equip_desc_14"))

		return false
	end

	self._curViewDatas[index].useCount = self._curViewDatas[index].useCount + addCount

	PetEquipModel.instance:SetStrengthenFictitiousExp(self._curViewDatas[index].allExp * addCount)

	return true
end

function PetEquipStrengthenView:OnClickExclMatBtn(isAdd, count)
	if self.matLua == nil or self.exclMatInfo == nil or checknumber(self.exclMatInfo.allCount) <= 0 then
		return
	end

	count = count or 1

	if isAdd then
		if self.isMax then
			FloatWordMgr.instance:show(lang("text_equip_desc_55"))

			return
		end

		if self.exclMatInfo.useCount >= self.exclMatInfo.allCount then
			FloatWordMgr.instance:show(lang("text_equip_desc_14"))

			return
		end

		self.exclMatInfo.useCount = self.exclMatInfo.useCount + count

		PetEquipModel.instance:SetStrengthenFictitiousExp(self.exclMatInfo.matExp * count)
	else
		if self.exclMatInfo.useCount <= 0 then
			FloatWordMgr.instance:show(lang("text_equip_desc_16"))

			return
		end

		self.exclMatInfo.useCount = self.exclMatInfo.useCount - count

		PetEquipModel.instance:SetStrengthenFictitiousExp(-self.exclMatInfo.matExp * count)
	end

	self.matLua.binder:setNum(self.exclMatInfo.allCount, self.exclMatInfo.useCount)
	self.matLua.binder:setSelected(self.exclMatInfo.useCount > 0)
	GameUtil.SetActive(self.matReduceBtn, self.exclMatInfo.useCount > 0)

	if self.exclMatInfo.useCount > 0 then
		self.matReduceBtn.gameObject.transform:SetAsLastSibling()
	end

	GameUtil.SetActive(self.moneyIconSpt, true)

	self.qhNeedCoin = (self.isMax and self.upgNextExp - self.infoMo.haveAllExp or self.exclMatInfo.useCount * self.exclMatInfo.matExp) * self.infoMo.expCoinRatio
	self.moneyCountTxt.text = tostring(self.qhNeedCoin)

	self:ForceUpdataLeftInfo()
end

function PetEquipStrengthenView:OnClickPutInBtn()
	if self.isMax then
		FloatWordMgr.instance:show(lang("text_equip_desc_63"))

		return
	end

	local fictExp = PetEquipModel.instance:GetStrengthenFictitiousExp()
	local diffExp = self.upgNextExp - self.infoMo.haveAllExp - fictExp

	if diffExp <= 0 then
		local str = string.format("装备baseId = %s， 装备名称name = %s，装备等级starCount = %s， 装备已有经验haveExp = %s， 下一级经验nextExp = %s， 临时存储经验fictExp = %s， ", self.infoMo.baseId, self.infoMo.name, self.infoMo.starCount, self.infoMo.haveAllExp, self.upgNextExp, fictExp)

		printError("sr----  PetEquipStrengthenView:OnClickPutInBtn()    装备强化一键放入 = " .. str)

		return
	end

	if checknumber(self.infoMo.exclRaceId) > 0 then
		if self.matLua == nil or self.exclMatInfo == nil or checknumber(self.exclMatInfo.allCount) <= 0 then
			FloatWordMgr.instance:show(lang("text_equip_desc_64"))

			return
		end

		self:OnClickExclPutInBtn(diffExp)
	else
		if self._curViewDatas == nil or self._curViewDatas[1] == nil or self._curViewDatas[1].isEmpty then
			FloatWordMgr.instance:show(lang("text_equip_desc_64"))

			return
		end

		self:OnClickPutInCommBtn(diffExp)
	end
end

function PetEquipStrengthenView:OnClickPutInCommBtn(diffExp)
	local tempExp = 0
	local maxNum = 7

	if self.infoMo.matType == MatType.Equipment then
		maxNum = EquipmentConfig.instance:GetMaxOneClickNum()
	elseif self.infoMo.matType == MatType.Decoration then
		maxNum = DecorationConfig.instance:GetMaxOneClickNum()
	end

	local isOrange = false

	for i = 1, #self._curViewDatas do
		if not self._curViewDatas[i].isEmpty and tempExp < diffExp and (self.choiseStrtNum < self.maxOneStrtNum or not self._curViewDatas[i].isEquip) then
			if self._curViewDatas[i].isEquip then
				if self._curViewDatas[i].countList then
					if maxNum <= self._curViewDatas[i].quality then
						isOrange = true
					else
						while self._curViewDatas[i].useCount < #self._curViewDatas[i].countList and tempExp < diffExp and self.choiseStrtNum < self.maxOneStrtNum do
							if not self:AddChoiseStrengthen(i, 1) then
								break
							end

							self.choiseStrtNum = self.choiseStrtNum + 1
							tempExp = tempExp + self._curViewDatas[i].allExp * self.costDecoRatio / 100
						end
					end
				elseif self._curViewDatas[i].useCount < 1 then
					if maxNum <= self._curViewDatas[i].quality then
						isOrange = true
					elseif self:AddChoiseStrengthen(i, 1) then
						self.choiseStrtNum = self.choiseStrtNum + 1
						tempExp = tempExp + self._curViewDatas[i].allExp * self.costDecoRatio / 100
					end
				end
			else
				local isAdd = false

				while self._curViewDatas[i].useCount < self._curViewDatas[i].count and tempExp < diffExp do
					if not self:AddChoiseStrengthen(i, 1) then
						break
					end

					isAdd = true
					tempExp = tempExp + self._curViewDatas[i].allExp
				end

				if isAdd then
					self.choiseStrtNum = self.choiseStrtNum + 1
				end
			end
		end
	end

	if isOrange then
		local orangeStr = ""

		if self.infoMo.matType == MatType.Equipment then
			orangeStr = EquipmentConfig.instance:GetMaxOneClickTips()
		elseif self.infoMo.matType == MatType.Decoration then
			orangeStr = DecorationConfig.instance:GetMaxOneClickTips()
		end

		if not string.nilorempty(orangeStr) then
			FloatWordMgr.instance:show(orangeStr)
		end
	elseif tempExp <= 0 then
		FloatWordMgr.instance:show(lang("text_equip_desc_65"))

		return
	end

	self:CalculationNeedCoin()
end

function PetEquipStrengthenView:CalculationNeedCoin()
	self:reloadData()

	self.choiseStrtNum = 0

	if self._curViewDatas == nil or self._curViewDatas[1] == nil or self._curViewDatas[1].isEmpty then
		if self.infoMo.matType == MatType.Equipment then
			self.moneyCountTxt.text = "0"

			GameUtil.SetActive(self.moneyIconSpt, true)
		elseif self.infoMo.matType == MatType.Decoration then
			self.moneyCountTxt.text = ""

			GameUtil.SetActive(self.moneyIconSpt, false)
		end

		return
	end

	self:ForceUpdataLeftInfo()

	local need = 0

	if self.isMax then
		need = self.upgNextExp - self.infoMo.haveAllExp
	else
		for i = 1, #self._curViewDatas do
			if self._curViewDatas[i] and not self._curViewDatas[i].isEmpty then
				need = need + self._curViewDatas[i].useCount * self._curViewDatas[i].allExp

				if self._curViewDatas[i].isEquip then
					self.choiseStrtNum = self.choiseStrtNum + self._curViewDatas[i].useCount
				elseif self._curViewDatas[i].useCount > 0 then
					self.choiseStrtNum = self.choiseStrtNum + 1
				end
			end
		end
	end

	if self.infoMo.matType == MatType.Equipment then
		self.qhNeedCoin = need * self.infoMo.expCoinRatio
		self.moneyCountTxt.text = tostring(self.qhNeedCoin)

		GameUtil.SetActive(self.moneyIconSpt, true)
	elseif self.infoMo.matType == MatType.Decoration then
		self.moneyCountTxt.text = ""

		GameUtil.SetActive(self.moneyIconSpt, false)
	end
end

function PetEquipStrengthenView:OnClickExclPutInBtn(diffExp)
	local tempExp = 0
	local count = 0

	while self.exclMatInfo.useCount < self.exclMatInfo.allCount and tempExp < diffExp do
		count = count + 1
		tempExp = tempExp + self.exclMatInfo.matExp
	end

	if count + self.exclMatInfo.useCount > self.exclMatInfo.allCount then
		count = self.exclMatInfo.allCount - self.exclMatInfo.useCount
	end

	if count <= 0 then
		FloatWordMgr.instance:show(lang("text_equip_desc_65"))

		return
	end

	self:OnClickExclMatBtn(true, count)
end

function PetEquipStrengthenView:OnClickStrengthenBtn()
	local fictExp = PetEquipModel.instance:GetStrengthenFictitiousExp()

	if fictExp <= 0 and self.isMax then
		FloatWordMgr.instance:show(lang("text_equip_desc_55"))

		return
	end

	if checknumber(self.infoMo.exclRaceId) > 0 then
		self:OnClickStthenExclBtn()
	else
		self:OnClickStthenCommBtn()
	end
end

function PetEquipStrengthenView:OnClickStthenCommBtn()
	local isSelect = false
	local allCount = 0
	local equIds = {}
	local matIds = {}
	local desStr = lang("text_equip_desc_66")
	local tipsInfoList = {}
	local maxNum = 5

	if self.infoMo.matType == MatType.Equipment then
		maxNum = EquipmentConfig.instance:GetMaxQualityNum()
	elseif self.infoMo.matType == MatType.Decoration then
		maxNum = DecorationConfig.instance:GetMaxQualityNum()
	end

	if self._curViewDatas and #self._curViewDatas > 0 then
		for i = 1, #self._curViewDatas do
			if self._curViewDatas[i] and not self._curViewDatas[i].isEmpty and self._curViewDatas[i].useCount > 0 then
				if self._curViewDatas[i].isEquip then
					local choNum = 0

					if self._curViewDatas[i].countList then
						for m = 1, self._curViewDatas[i].useCount do
							if self._curViewDatas[i].countList[m] then
								choNum = choNum + 1
								isSelect = true

								local id = self._curViewDatas[i].countList[m]

								table.insert(equIds, id)

								desStr = desStr .. id .. "，"
							end
						end
					else
						choNum = 1
						isSelect = true

						local id = self._curViewDatas[i].onlyId

						table.insert(equIds, id)

						desStr = desStr .. id .. "，"
					end

					allCount = allCount + self._curViewDatas[i].useCount

					if maxNum <= self._curViewDatas[i].quality and choNum > 0 then
						table.insert(tipsInfoList, {
							onlyId = self._curViewDatas[i].onlyId,
							matType = self.infoMo.matType,
							useCount = choNum
						})
					end
				else
					isSelect = true

					table.insert(matIds, {
						id = self._curViewDatas[i].onlyId,
						num = self._curViewDatas[i].useCount
					})

					desStr = desStr .. self._curViewDatas[i].onlyId .. "_" .. self._curViewDatas[i].useCount .. "，"
					allCount = allCount + 1
				end
			end
		end
	end

	if not isSelect then
		FloatWordMgr.instance:show(lang("text_equip_desc_67"))

		return
	end

	if allCount > self.maxOneStrtNum then
		FloatWordMgr.instance:show(lang("text_equip_desc_68"))

		return
	end

	local haveCoin = MaterialModel.instance:getMaterialsNumber(MatType.Coin, 1)

	if haveCoin < self.qhNeedCoin then
		FloatWordMgr.instance:show(lang("text_equip_desc_69"))

		return
	end

	local function callBack()
		if self.infoMo.matType == MatType.Equipment then
			local data = {
				onlyId = self.infoMo.onlyId,
				starCount = self.infoMo.starCount,
				matType = self.infoMo.matType
			}

			PetEquipModel.instance:SetCurrentUpgradeInfo(data)
			PetEquipController.instance:CSStrengthenEquipReq(self.infoMo.onlyId, equIds, matIds)
		elseif self.infoMo.matType == MatType.Decoration then
			local data = {
				decorationId = self.infoMo.onlyId,
				defineId = self.infoMo.baseId,
				exp = self.infoMo.haveAllExp,
				propertyApps = self.infoMo.addAttrs,
				equippedPetId = self.infoMo.equippedPetId
			}
			local info = EquipInfoMo.New(data, MatType.Decoration)

			PetEquipModel.instance:SetCurrentUpgradeInfo(info)
			PetEquipController.instance:CSStrengthenDecorationReq(self.infoMo.onlyId, equIds, matIds)
		end
	end

	if tipsInfoList and #tipsInfoList > 0 then
		UIStateManager.instance:open(ViewName.StrengthenTips, tipsInfoList, callBack)

		return
	end

	callBack()
end

function PetEquipStrengthenView:OnClickStthenExclBtn()
	if self.matLua == nil or self.exclMatInfo == nil or checknumber(self.exclMatInfo.allCount) <= 0 then
		FloatWordMgr.instance:show(lang("text_equip_desc_64"))

		return
	end

	if checknumber(self.exclMatInfo.useCount) <= 0 then
		FloatWordMgr.instance:show(lang("text_equip_desc_67"))

		return
	end

	local haveCoin = MaterialModel.instance:getMaterialsNumber(MatType.Coin, 1)

	if haveCoin < self.qhNeedCoin then
		FloatWordMgr.instance:show(lang("text_equip_desc_69"))

		return
	end

	local data = {
		onlyId = self.infoMo.onlyId,
		starCount = self.infoMo.starCount,
		matType = self.infoMo.matType
	}

	PetEquipModel.instance:SetCurrentUpgradeInfo(data)
	PetEquipController.instance:CSStrengthenEquipReq(self.infoMo.onlyId, {}, {
		{
			id = self.exclMatInfo.matId,
			num = self.exclMatInfo.useCount
		}
	})
end

function PetEquipStrengthenView:OnClickHuanjingBtn()
	if PetEquipModel.instance:OpenEquipHuanjingView() then
		MaterialChallengeController.instance:openChapterView(4)
	end
end

return PetEquipStrengthenView
