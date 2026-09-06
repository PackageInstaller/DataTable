-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetAwakeView.lua

module("logic.extensions.bag.view.stack.PetAwakeView", package.seeall)

local PetAwakeView = class("PetAwakeView", ViewComponent)

function PetAwakeView:unbindEvents()
	PetAwakeView.super.unbindEvents(self)
	self._btnTips:RemoveClickListener()
	self._btnDetail:RemoveClickListener()
	self._btnContainer:RemoveClickListener()
	self._btnOneStarUp:RemoveClickListener()
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnAwake)
	GameUtil.rmClickHandler(self.cellL)
	GameUtil.rmClickHandler(self.cellR)
end

function PetAwakeView:bindEvents()
	PetAwakeView.super.bindEvents(self)
	self._btnTips:AddClickListener(self._onClickDetail, self)
	self._btnContainer:AddClickListener(self._onClickDetail, self)
	self._btnOneStarUp:AddClickListener(self._onClickOneStartUp, self)
	self._btnDetail:AddClickListener(self._onClickDetail, self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnAwake, self._onClickUpgrade, self)
	GameUtil.addClickHandler(self.cellL, self._onClickCoin, self)
	GameUtil.addClickHandler(self.cellR, self._onClickPetSource, self)
end

function PetAwakeView:onExit()
	PetAwakeView.super.onExit(self)

	if bigBg then
		bigBg:ClearImage()
	end

	GlobalDispatcher:removeListener(GlobalNotify.OnPetSelect, self._onPetSelected, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialCountChange, self.updateMat, self)
	GlobalDispatcher:removeListener(PetAgent.PM_PetAwakenRes, self.onGetMsg, self)
	removetimer(self._openLvupView, self)

	for _, v in ipairs(self._starEffs) do
		UIEffectManager.instance:stopEffect(v)
	end

	self._starEffs = nil

	for _, v in ipairs(self._ringEffs) do
		UIEffectManager.instance:stopEffect(v)
	end

	self._ringEffs = nil

	if self._loopEff then
		UIEffectManager.instance:stopEffect(self._loopEff)
	end

	self._loopEff = nil

	if self._tweener then
		self._tweener:Kill(false)
	end

	self._tweener = nil
	self._hasShowRingEff = false

	GameUtil.clickEnabled(true, self)
	self:_clearNextEffs()
	self.scrollList:dispose()
end

function PetAwakeView:_clearEff()
	if self._eff then
		UIEffectManager.instance:stopEffect(self._eff)
	end

	self._eff = nil
end

function PetAwakeView:_onPetSelected()
	print("pet selected updateUI")
	self:_updateUINew()
end

function PetAwakeView:buildUI()
	PetAwakeView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "tips/Text")
	self._starsContainer = self:getGo("container/stars").transform
	self._stars = GameUtil.getChildren(self._starsContainer)
	self._ringsContainer = self:getGo("container/rings").transform
	self._rings = {}

	self._ringsContainer:GetChild(0).gameObject:SetActive(false)

	self._btnTips = self:getBtn("tips")
	self._btnContainer = self:getBtn("container")
	self._btnDetail = self:getBtn("btn_detail")
	self._max = self:getGo("max")
	self._imgProgress = goutil.findChildComponent(self.mainGO, "container/imgProgress", goutil.Type_UIImage)
	self._imgChangeProgress = self._imgProgress.gameObject:GetComponent("UIImageSpriteChange")
	self._btnOneStarUp = self:getBtn("btnOneStarUp")
	self._oneName = self:getTxt("btnOneStarUp/txtName")
	self.materialGo = self:getGo("material")
	self.tableview = self:getGo("material/tableview")
	self.emptyGo = self:getGo("material/emptyGo")
	self.cell = self:getGo("material/cell")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self.txtDesc = self:getTxt("material/txtTip")
	self.cellL = self:getGo("material/cost/cellL")
	self.txtCountL = self:getTxt("material/cost/cellL/txtCount")
	self.itemL = self:getGo("material/cost/cellL/item")
	self.txtCountR = self:getTxt("material/cost/cellR/txtCount")
	self.cellR = self:getGo("material/cost/cellR")
	self.itemR = self:getGo("material/cost/cellR/item")
	self.btnAwake = self:getGo("material/cost/btnAwake")
	self.txtAwake = self:getTxt("material/cost/btnAwake/Text")
	self._redPoint = self:getGo("material/cost/btnAwake/red_point")
end

function PetAwakeView:_updateCell(view, cell, data, tag)
	local item = goutil.findChild(cell, "item")
	local tag = goutil.findChild(cell, "tag")
	local btnLess = goutil.findChild(cell, "btnLess")
	local Image = goutil.findChild(cell, "Image")
	local lock = goutil.findChild(cell, "lock")
	local txtNum = goutil.findChildTextComponent(cell, "Image/TxtNum")
	local top = goutil.findChild(cell, "top")

	GameUtil.SetActive(tag, false)
	GameUtil.SetActive(btnLess, false)
	GameUtil.SetActive(Image, false)
	GameUtil.SetActive(lock, false)

	local matType = -1
	local cfgId = -1

	if data.__cname == "BagPetMo" then
		local proxy = MaterialMgr.setCellByData(MatType.Pet, data, item)

		matType = MatType.PetPiece
		cfgId = data.raceId

		if self.selectPets[data.petId] then
			GameUtil.SetActive(btnLess, true)
		end

		if data:checkHasDestroyStarGodPlus() and proxy then
			proxy.binder:setGray(true)
		end

		if data.petId == self._mo.petId then
			if proxy then
				proxy.binder:setGray(true)
				proxy.binder:setLvl(0)
			end
		else
			GameUtil.SetActive(lock, data:isLocked())
		end
	else
		matType = MatType.Item
		cfgId = data.pieceId

		MaterialMgr.setCell(MatType.Item, data.id, item)
		GameUtil.SetActive(Image, true)

		local num = MaterialModel.instance:getMaterialsNumber(MatType.Item, data.id)
		local selectNum = checknumber(self.selectItems[data.id])

		txtNum.text = num == 0 and selectNum .. "/<color=#eb4642>" .. num .. "</color>" or selectNum .. "/" .. num

		if self.selectItems[data.id] and selectNum > 0 then
			GameUtil.SetActive(btnLess, true)
		end
	end

	local myNum = MaterialModel.instance:getMaterialsNumber(matType, cfgId)
	local count, _type, _id, _num = MaterialConfig.instance:getMergeCfgByMatAndId(matType, cfgId)
	local canMerge = count > -1 and count <= myNum

	GameUtil.SetActive(tag, canMerge)
	GameUtil.addClickHandler(top, GameUtil.handler(self.onCellClick, self, data, canMerge, matType, cfgId))
	GameUtil.addClickHandler(btnLess, GameUtil.handler(self.onLessClick, self, data))
end

function PetAwakeView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

function PetAwakeView:onCellClick(data, canMerge, matType, cfgId)
	if canMerge then
		local itemMo = MaterialMgr.getModel(matType, cfgId)

		ItemBagController.instance:openUsePanel(itemMo)
	else
		if data.__cname == "BagPetMo" then
			if data.petId == self._mo.petId then
				MaterialMgr.openGetSource(MatType.Pet, data.raceId)
			else
				if data:checkHasDestroyStarGodPlus() then
					TipsFacade.instance:openCommonTips(lang("该精灵佩戴了专属星神不可当做觉醒材料"))

					return
				end

				if data:isLocked() then
					self:unlockPet(data)
				elseif self.selectPets[data.petId] == nil then
					local total = self._costCfg.needPetNum
					local petNum = self:getSelectPets()

					if petNum < total then
						local evolveCfg = EvolveConfig.instance:getDivineEvolvePlusCfgByNewRaceId(data.raceId)

						if evolveCfg and evolveCfg.evolutionType == 1 then
							local text = DivineEvolvePlusController.instance:getEvolveTip()

							TipsFacade.instance:openPopupWindow(lang("tip"), text, function()
								self.selectPets[data.petId] = data

								self:refreshList()
							end)
						elseif evolveCfg and evolveCfg.evolutionType == 2 then
							local text = SourceTraceController.instance:getEvolveTip()

							TipsFacade.instance:openPopupWindow(lang("tip"), text, function()
								self.selectPets[data.petId] = data

								self:refreshList()
							end)
						else
							self.selectPets[data.petId] = data
						end
					else
						TipsFacade.instance:openCommonTips(lang("觉醒需要的材料数量已经足够不需要再添加材料了"))
					end
				else
					self.selectPets[data.petId] = nil
				end
			end
		elseif self:checkCanUseMat(data) then
			local myNum = MaterialModel.instance:getMaterialsNumber(MatType.Item, data.id)

			if myNum == 0 then
				MaterialMgr.openGetSource(MatType.Item, data.id)
			else
				local num = checknumber(self.selectItems[data.id])

				if num < myNum then
					local total = self._costCfg.needPetNum
					local petNum = self:getSelectPets()

					if petNum < total then
						num = num + 1
						self.selectItems[data.id] = num
					else
						TipsFacade.instance:openCommonTips(lang("觉醒需要的材料数量已经足够不需要再添加材料了"))
					end
				end
			end
		end

		self:refreshList()
	end
end

function PetAwakeView:checkCanUseMat(data)
	if data.race == 0 then
		local name = MaterialMgr.getMaterialsName(MatType.Item, data.id)

		for i, mo in ipairs(self.petList) do
			if self.selectPets[mo.petId] == nil then
				TipsFacade.instance:openTipWindowNoX(lang("tip"), langPara("%s是非常珍贵的材料，你可以先放置所有精灵后再选择放入%s", name, name), function()
					return
				end)

				return false
			end
		end

		for i, v in ipairs(self.raceList) do
			local num = MaterialModel.instance:getMaterialsNumber(MatType.Item, v.id)

			if num < checknumber(self.selectItems[v.id]) then
				local n2 = MaterialMgr.getMaterialsName(MatType.Item, v.id)

				TipsFacade.instance:openTipWindowNoX(lang("tip"), langPara("%s是非常珍贵的材料，你可以先放置所有%s后再选择放入%s", name, n2, name), function()
					return
				end)

				return false
			end
		end
	end

	return true
end

function PetAwakeView:onLessClick(data)
	if data.__cname == "BagPetMo" then
		if self.selectPets[data.petId] == nil then
			local isEvolvePlused = EvolveConfig.instance:getDivineEvolvePlusCfgByNewRaceId(data.raceId)

			if isEvolvePlused then
				local text = DivineEvolvePlusController.instance:getEvolveTip()

				TipsFacade.instance:openPopupWindow(lang("tip"), text, function()
					self.selectPets[data.petId] = data

					self:refreshList()
				end)
			else
				self.selectPets[data.petId] = data
			end
		else
			self.selectPets[data.petId] = nil
		end
	else
		local num = checknumber(self.selectItems[data.id]) - 1

		num = math.max(num, 0)
		self.selectItems[data.id] = num
	end

	self:refreshList()
end

function PetAwakeView:refreshList()
	self:_updateCostCoin()
	self.scrollList:refresh()
end

function PetAwakeView:unlockPet(mo)
	TipsFacade.instance:openPopupWindow(lang("tip"), lang("是否解锁该精灵？"), function()
		local petId = mo.petId

		BagPetsController.instance:changePetLockState(petId, not mo:isLocked(), function(skipTip)
			local locked = mo:isLocked()
			local tip

			if skipTip ~= true then
				FloatWordMgr.instance:show(locked and lang("上锁成功~") or lang("解锁成功~"))
			end

			self:refreshList()
		end)
	end)
end

function PetAwakeView:onEnter()
	PetAwakeView.super.onEnter(self)

	self._costCoinCfg = MaterialMgr.getMatCfg(MatType.Coin, MatType.Coin_Dust)
	self._starEffs = {}
	self._ringEffs = {}

	self:_updateUINew()

	if self.scrollList then
		self.scrollList:MoveCellInView(0)
	end

	GlobalDispatcher:addListener(GlobalNotify.OnPetSelect, self._onPetSelected, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self.updateMat, self)
	GlobalDispatcher:addListener(PetAgent.PM_PetAwakenRes, self.onGetMsg, self)
end

function PetAwakeView:onGetMsg(status, msg)
	if status ~= 0 then
		self:_awakeFail(msg)
	else
		for k, data in pairs(self.selectPets) do
			BagPetsController.instance:setPetIsTop(data.petId, false)
		end

		self:_onAwakeSuccess(msg)
	end
end

function PetAwakeView:updateList(mo)
	local list = {}

	self.petList = {}
	self.raceList = {}
	self.baseList = {}

	local awakenLv = mo.awakenLv
	local petCfg = CharacterConfig.instance:getPetCo(mo.raceId)
	local costCfg = CharacterConfig.instance:getPetAwakenCostCfg(checknumber(petCfg.awakenCostStrategyId), awakenLv + 1)

	if costCfg then
		local raceList, baseList = ItemConfig.instance:getReplaceItemCfgList(mo)

		self.raceList = raceList
		self.baseList = baseList

		for i, v in ipairs(baseList) do
			table.insert(list, v)
		end

		for i, v in ipairs(raceList) do
			table.insert(list, v)
		end

		local upType = costCfg.petCostType
		local pets = BagModel.instance:getBagPets()

		for i, v in ipairs(pets) do
			if v.petId ~= mo.petId and v.awakeLevel == costCfg.needPetAwakenLv then
				local cfg = CharacterConfig.instance:getPetCo(v.raceId)

				if upType == GameEnum.PetStarUpStrategy.RaceId then
					if v.raceId == mo.raceId then
						table.insert(list, v)
						table.insert(self.petList, v)
					end
				elseif upType == GameEnum.PetStarUpStrategy.Attr then
					if PetSkinConfig.instance:checkIsSameFirstEleAttr(v.curFaceId, mo.curFaceId) then
						table.insert(list, v)
						table.insert(self.petList, v)
					end
				elseif upType == GameEnum.PetStarUpStrategy.Job then
					local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(v.curFaceId)

					if PetSkinConfig.instance:checkHasJob(mo.curFaceId, firstJobIdx) then
						table.insert(list, v)
						table.insert(self.petList, v)
					end
				end
			end
		end

		if #self.petList == 0 then
			local tempMo = mo:GetClone()

			tempMo.curFaceId = mo.raceId

			table.insert(list, tempMo)
		end
	end

	self.scrollList:reloadData(list)
	GameUtil.SetActive(self.emptyGo, #list == 0)
end

function PetAwakeView:_updateUINew()
	self._mo = BagPetsController.instance:GetCurPetMo()
	self.selectItems = {}
	self.selectPets = {}

	self:updateList(self._mo)
	MaterialMgr.setCell(MatType.Coin, MatType.Coin_Dust, self.itemL)
	MaterialMgr.setCellByData(MatType.Pet, self._mo, self.itemR)

	local awakenLv = self._mo.awakenLv

	self._curRareCfg = CharacterConfig.instance:getAwakenRareCfg(awakenLv)
	self._petCfg = CharacterConfig.instance:getPetCo(self._mo.raceId)

	self:_updateCostCoin()
	self:_clearNextEffs()
	self:_updateStars()
	self:_updateRings()
	self:_updateTips()
	goutil.setActive(self._redPoint, BagModel.instance:getPetAwakeStatus(self._mo.petId))
	self._btnOneStarUp.gameObject:SetActive(false)
end

function PetAwakeView:_updateCostCoin()
	local awakenLv = self._mo.awakenLv

	self._costCfg = CharacterConfig.instance:getPetAwakenCostCfg(checknumber(self._petCfg.awakenCostStrategyId), awakenLv + 1)
	self._isMaxAwaken = self._costCfg == nil

	goutil.setActive(self._max, self._isMaxAwaken)
	GameUtil.SetActive(self.materialGo, not self._isMaxAwaken)

	if not self._isMaxAwaken then
		local needCoinNum = self._costCfg.needCoinNum

		goutil.setActive(self._costCoin, needCoinNum > 0)

		self.txtCountL.text = needCoinNum

		local curNum = MaterialModel.instance:getMaterialsNumber(MatType.Coin, MatType.Coin_Dust)

		self.txtCountL.text = needCoinNum <= curNum and curNum .. "/" .. needCoinNum or "<color=#eb4642>" .. curNum .. "</color>" .. "/" .. needCoinNum

		local total = self._costCfg.needPetNum
		local petNum = self:getSelectPets()
		local color = "20b376"

		if petNum < total then
			color = "eb4642"
			self.txtCountR.text = "<color=#eb4642>" .. petNum .. "</color>" .. "/" .. total
		else
			self.txtCountR.text = petNum .. "/" .. total
		end

		local petNmae = MaterialMgr.getMaterialsName(MatType.Pet, self._mo.raceId)

		self.txtDesc.text = langPara("请放入<color=#20b376>%s</color>只<color=#20b376>%s</color>(<color=#%s>%s</color>/%s)", total, petNmae, color, petNum, total)
	else
		self.txtCountR.text = "--/--"
		self.txtCountL.text = "--/--"
		self.txtDesc.text = lang("当前精灵觉醒等级已经最高")
	end
end

function PetAwakeView:getSelectPets()
	local petNum = 0

	for i, v in pairs(self.selectPets) do
		petNum = petNum + 1
	end

	for i, v in pairs(self.selectItems) do
		petNum = petNum + v
	end

	return petNum
end

function PetAwakeView:updateMat()
	self:_updateCostCoin()
	self:updateList(self._mo)
end

function PetAwakeView:_updateTips()
	self._txtTips.text = self._curRareCfg.upTitle
	self.txtAwake.text = self._curRareCfg.upBtnText
end

function PetAwakeView:_updateStars()
	for i = 1, #self._stars do
		local star = self._stars[i]
		local isActive = i <= self._curRareCfg.starNum
		local imgStar = goutil.findChild(star, "Image")

		goutil.setActive(imgStar, isActive)
	end

	local url = "fx_ui_shengxing/fx_ui_shengxing_baoshi.prefab"

	self:_updateEffList(url, self._stars, self._starEffs, self._curRareCfg.starNum)

	local nextRareCfg = CharacterConfig.instance:getAwakenRareCfg(self._mo.awakenLv + 1)

	if nextRareCfg and nextRareCfg.starNum ~= self._curRareCfg.starNum then
		print("curStarNum = " .. self._curRareCfg.starNum .. "nextStarNum = " .. nextRareCfg.starNum)

		local star = self._stars[nextRareCfg.starNum]

		self._nextStarEff = self:_checkAndGetEff("fx_ui_shengxing/fx_ui_shengxing_huxi_shuijing.prefab", star)
	end
end

function PetAwakeView:_clearNextEffs()
	if self._nextStarEff then
		UIEffectManager.instance:stopEffect(self._nextStarEff)
	end

	self._nextStarEff = nil

	if self._nextRingEff then
		UIEffectManager.instance:stopEffect(self._nextRingEff)
	end

	self._nextRingEff = nil
end

function PetAwakeView:_updateRings()
	local maxRingNum = self._curRareCfg.totalRingNum
	local activeRingNum = self._curRareCfg.ringNum
	local radius = 165
	local i = 1

	if self._loopEff then
		UIEffectManager.instance:stopEffect(self._loopEff)

		self._loopEff = nil
	end

	if maxRingNum == 0 then
		self._imgProgress.fillAmount = 0
	elseif self._isMaxAwaken then
		local url = "fx_ui_shengxing/fx_ui_shengxing_zuizhong_loop.prefab"

		self._loopEff = self:_playEffect(url, nil, self._starsContainer)
		self._imgProgress.fillAmount = 1
	else
		self._imgProgress.fillAmount = (activeRingNum - 1) / maxRingNum
	end

	if maxRingNum == 1 then
		self._imgChangeProgress:SetState(0)
	elseif maxRingNum == 3 then
		self._imgChangeProgress:SetState(1)
	elseif maxRingNum == 4 then
		self._imgChangeProgress:SetState(2)
	end

	while i <= maxRingNum do
		local ring = self._rings[i]

		if ring == nil then
			local cloneGo = self._ringsContainer.transform:GetChild(0).gameObject

			ring = goutil.cloneAndSetParent(cloneGo, self._ringsContainer.transform, "ring")

			Framework.TransformUtil.SetLocalScale(ring.transform, 1, 1, 1)
			Framework.TransformUtil.SetLocalRotation(ring.transform, 0, 0, 0)

			ring = ring:GetComponent("UIImageSpriteChange")

			table.insert(self._rings, ring)
		end

		local isActive = i <= activeRingNum
		local x, y, z = Framework.TransformUtil.GetLocalPos(ring.transform, 0, 0, 0)
		local rad = (i - 1) / maxRingNum * 2 * math.pi

		Framework.TransformUtil.SetLocalPos(ring.transform, math.sin(rad) * radius, math.cos(rad) * radius, z)

		local imgSpriteChange = ring:GetComponent("UIImageSpriteChange")

		imgSpriteChange:SetState(isActive and 1 or 0)

		i = i + 1

		goutil.setActive(ring.gameObject, true)
	end

	while i <= #self._rings do
		goutil.setActive(self._rings[i].gameObject, false)

		i = i + 1
	end

	local url = "fx_ui_shengxing/fx_ui_shengxing_qiu.prefab"

	self:_updateEffList(url, self._rings, self._ringEffs, activeRingNum)

	if activeRingNum < maxRingNum then
		local ring = self._rings[activeRingNum + 1]

		if ring then
			self._nextRingEff = self:_checkAndGetEff("fx_ui_shengxing/fx_ui_shengxing_huxi_qiu.prefab", ring)
		end
	end
end

function PetAwakeView:_checkAndGetEff(url, parent, effect, effList)
	local eff = effect
	local isCreate = false

	if eff == nil then
		eff = UIEffectManager.instance:playEffect(self, url, parent, 0, 0, true)

		if effList ~= nil then
			table.insert(effList, eff)
		end
	end

	eff:setParent(parent.transform)
	eff:setLocalPos(0, 0, 0)
	eff:setScale(1)
	eff:setLocalEulerAngle(0, 0, 0)

	return eff, isCreate
end

function PetAwakeView:_updateEffList(url, parentList, effList, activeCount)
	for k, v in ipairs(parentList) do
		local eff

		if k <= activeCount then
			local eff, isCreate = self:_checkAndGetEff(url, v, effList[k], effList)
		end
	end

	activeCount = math.max(0, activeCount)

	while activeCount < #effList do
		local tail = #effList
		local eff = effList[tail]

		UIEffectManager.instance:stopEffect(eff)
		table.remove(effList, tail)
	end
end

function PetAwakeView:_updateCountText(curNum, needNum, text)
	text.text = string.format("<color=#%s>%s</color>/%s", (curNum < needNum or nil) and "eb4642", curNum, needNum)
end

function PetAwakeView:_onClickPetMat()
	MaterialMgr.openGetSource(MatType.PetPiece, self._mo.raceId)
end

function PetAwakeView:_onClickUpgrade()
	local isMax = self._mo.awakenLv >= BagModel.instance:getMaxAwakenLv(self._mo.raceId)

	if not isMax then
		local tip = string.format("你背包中已经有1只<color=#eb4642>更高觉醒</color>的<color=#eb4642>%s</color>喔。无需再觉醒！", self._mo.name)

		TipsFacade.instance:openTipWindow("提示", tip, nil, "知道了")
	else
		self:sendMsgToAwake()
	end
end

function PetAwakeView:sendMsgToAwake()
	local items = {}
	local pets = {}

	for k, v in pairs(self.selectItems) do
		local cfg = ItemConfig.instance:getAwakenItemExtCfgById(k)

		if cfg.race == 0 and not self:checkCanUseMat(cfg) then
			return
		end

		for i = 1, v do
			table.insert(items, k)
		end
	end

	for k, v in pairs(self.selectPets) do
		table.insert(pets, k)
	end

	if MaterialModel.instance:getMaterialsNumber(MatType.Coin, MatType.Coin_Dust) < self._costCfg.needCoinNum then
		local name = MaterialMgr.getMaterialsName(MatType.Coin, MatType.Coin_Dust)

		FloatWordMgr.instance:show(langPara("觉醒所需的%s不足", name))
		MaterialMgr.openGetSource(MatType.Coin, MatType.Coin_Dust)
	elseif #pets + #items < self._costCfg.needPetNum then
		local tip = lang("请先选中足够的觉醒所需精灵或者材料")

		FloatWordMgr.instance:show(tip)
	else
		if PasswordLockController.instance:checkNeedOpenVerifyView() then
			return
		end

		self._preMo = self._mo:GetClone()

		GameUtil.clickEnabled(false, self)
		PetAgent.instance:sendPM_PetAwakenReq(self._mo.petId, pets, items)
	end
end

function PetAwakeView:_awakeFail(msg)
	GameUtil.clickEnabled(true, self)
end

function PetAwakeView:_onAwakeSuccess(msg)
	self._changeSetId = msg.changeSetId

	ItemGetController.instance:setTitleType(self._changeSetId, ItemGetController.TITLE_RETURNMAT)

	local preRareCfg = CharacterConfig.instance:getAwakenRareCfg(self._preMo.awakenLv)
	local curRareCfg = CharacterConfig.instance:getAwakenRareCfg(self._mo.awakenLv)

	self._isOpenAwakeLvup = preRareCfg.starNum ~= curRareCfg.starNum

	print("preRareCfg awakenLv = " .. self._preMo.awakenLv .. "ringNum = " .. preRareCfg.ringNum .. " starNum = " .. preRareCfg.starNum)
	print("curRareCfg awakenLv = " .. self._mo.awakenLv .. "ringNum = " .. curRareCfg.ringNum .. " starNum = " .. curRareCfg.starNum)

	if preRareCfg.ringNum >= 0 then
		local startVal = self._imgProgress.fillAmount
		local endVal = startVal + 1 / preRareCfg.totalRingNum

		self._showRingEffVal = endVal - 0.01
		self._hasShowRingEff = false

		if preRareCfg.ringNum + 1 >= preRareCfg.totalRingNum then
			endVal = 1
		end

		local duration = 1.5 * (endVal - startVal)

		self._tweener = TweenUtil.ValueTo(startVal, endVal, duration, function(val)
			self:_onTweenUpdate(val)
		end, function()
			self:_tryPlayStarEff()

			self._tweener = nil
		end, self)
	else
		self:_tryPlayStarEff()
	end
end

function PetAwakeView:_onTweenUpdate(val)
	self._imgProgress.fillAmount = val

	if self._curRareCfg.ringNum >= 0 and val >= self._showRingEffVal and not self._hasShowRingEff then
		self._hasShowRingEff = true

		local url = "fx_ui_shengxing/fx_ui_shengxing_qiu.prefab"
		local ringIdx = self._curRareCfg.ringNum + 1
		local ring = self._rings[ringIdx]

		ring:GetComponent("UIImageSpriteChange"):SetState(1)
		self:_updateEffList(url, self._rings, self._ringEffs, ringIdx)
	end
end

function PetAwakeView:_tryPlayStarEff()
	settimer(0.38, self._openLvupView, self, false)

	if self._isOpenAwakeLvup then
		local starIdx = self._curRareCfg.starNum
		local star = self._stars[self._curRareCfg.starNum]

		if star then
			self._flashEff = UIEffectManager.instance:playEffect(self, "fx_ui_shengxing/fx_ui_shengxing_baoshi_shan.prefab", star, 0, 0)

			self._flashEff:setParent(star.transform)
			self._flashEff:setLocalPos(0, 0, 0)
			self._flashEff:setScale(1)
			self._flashEff:setLocalEulerAngle(0, 0, 0)

			local url = "fx_ui_shengxing/fx_ui_shengxing_baoshi.prefab"

			self:_updateEffList(url, self._stars, self._starEffs, starIdx)

			local imgStar = goutil.findChild(star, "Image")

			goutil.setActive(imgStar, true)
		end
	end

	if self._curRareCfg.ringNum >= 0 then
		local url = "fx_ui_shengxing/fx_ui_shengxing_qiu.prefab"
		local ringIdx = self._curRareCfg.ringNum + 1
		local ring = self._rings[ringIdx]

		if ring then
			ring:GetComponent("UIImageSpriteChange"):SetState(1)
			self:_updateEffList(url, self._rings, self._ringEffs, ringIdx)
		end
	end
end

function PetAwakeView:_openLvupView()
	GameUtil.clickEnabled(true, self)
	removetimer(self._openLvupView, self)
	GlobalDispatcher:dispatch(GlobalNotify.BagPetAttrChanged, true)
	self:_updateUINew()
end

function PetAwakeView:_playEffect(url, effs, parent, i)
	local eff

	if effs then
		eff = effs[i]
	end

	if eff == nil then
		eff = UIEffectManager.instance:playEffect(self, url, parent, 0, 0, true)

		eff:setParent(parent.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1)
		eff:setLocalEulerAngle(0, 0, 0)

		if effs then
			table.insert(effs, eff)
		end
	end

	return eff
end

function PetAwakeView:_onClickClose()
	self:close()
end

function PetAwakeView:_onClickDetail()
	UIStateManager.instance:push(ViewName.PetAwakeListView)
end

function PetAwakeView:_onClickJump()
	if not self._conditionRealReached then
		if self._conditionReached then
			FloatWordMgr.instance:show("不可通过力量水晶的精灵共鸣来达到试炼条件喔。")
		else
			FloatWordMgr.instance:show("请先完成全部试炼条件后，再去进行神启试炼。")
		end

		return
	end

	if self._isMaxAwaken then
		FloatWordMgr.instance:show(lang("该精灵已满觉醒"))
	else
		WisdomAltarModel.instance:setCurPet(self._mo)
		UIStateManager.instance:push(ViewName.WisdomAltarView, self._mo)
	end
end

function PetAwakeView:_updateOneStartUp()
	local mode = WisdomAltarModel.instance:getCurOneMode()
	local wisCo = WisdomAltarConfig.instance:getWisdomaltarCo(mode or 0)

	if not wisCo then
		self._btnOneStarUp.gameObject:SetActive(false)
	else
		self._btnOneStarUp.gameObject:SetActive(true)

		self._oneName.text = wisCo.name
	end
end

function PetAwakeView:_onClickOneStartUp()
	ViewMgr.instance:open(ViewName.WisdomAltarOneView)
end

function PetAwakeView:_onClickCoin()
	local needCoinNum = self._costCfg.needCoinNum
	local curNum = MaterialModel.instance:getMaterialsNumber(MatType.Coin, MatType.Coin_Dust)

	if needCoinNum <= curNum then
		CommonTipsMgr.instance:openMaterialTips(self.cellL.gameObject, MatType.Coin, MatType.Coin_Dust)
	else
		MaterialMgr.openGetSource(MatType.Coin, MatType.Coin_Dust)
	end
end

function PetAwakeView:_onClickPetSource()
	local mo = BagPetsController.instance:GetCurPetMo()

	MaterialMgr.openGetSource(MatType.Pet, mo.raceId)
end

return PetAwakeView
