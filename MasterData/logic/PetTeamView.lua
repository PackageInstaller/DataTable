-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/PetTeamView.lua

module("logic.extensions.handbook.view.PetTeamView", package.seeall)

local PetTeamView = class("PetTeamView", TableViewComponent)

function PetTeamView:ctor()
	PetTeamView.super.ctor(self)
end

function PetTeamView:buildUI()
	PetTeamView.super.buildUI(self)

	self._closeButton = self:getBtn("topleft/btnClose")
	self._btnHome = self:getBtn("topleft/btnHome")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "txtDesc")
	self.itemavatar = goutil.findChild(self.mainGO, "avatars/itemavatar")
	self._normalMat = goutil.findChild(self.mainGO, "avatars/normalMat"):GetComponent(goutil.Type_UIImage)
	self._grayMat = goutil.findChild(self.mainGO, "avatars/grayMat"):GetComponent(goutil.Type_UIImage)
	self._script = self.itemavatar:GetComponent("TestRecordPos")
	self.avatars = {}

	for i = 1, 8 do
		local pet = {}

		pet.go = goutil.findChild(self.mainGO, "avatars/itemavatar/pet_" .. i)
		pet.imgIcon = goutil.findChildComponent(pet.go, "mask/imgIcon", "Image")

		local starGo = goutil.findChild(pet.go, "stars")

		pet.posScript = starGo:GetComponent("TestRecordPos")
		pet.starItem = PetStarItem.New(starGo, true)
		pet.starGo = starGo
		pet.btn = Framework.ButtonAdapter.Get(pet.go)

		table.insert(self.avatars, pet)
	end

	self._progresses = {}

	local progresses = goutil.findChild(self.mainGO, "progresses")

	for i = 1, 2 do
		local progress = {}
		local go = goutil.findChild(progresses, "prog_" .. i)

		progress.mainGO = go
		go = goutil.findChild(go, "container")
		progress.sliderProgress = goutil.findChildComponent(go, "sliderProgress", "Slider")
		progress.txtProgress = goutil.findChildComponent(go, "txtProgress", "Text")
		progress.txtName = goutil.findChildTextComponent(go, "txtName")
		progress.itemPoint = goutil.findChild(go, "itemPoint")
		progress.btn = Framework.ButtonAdapter.Get(go)
		progress.btnClick = goutil.findChild(go, "btnClick")

		goutil.setActive(progress.btnClick, false)

		progress.received = goutil.findChild(go, "received")
		progress.redPoint = goutil.findChild(go, "redPoint")

		table.insert(self._progresses, progress)
	end

	self._txtAttribute = {}
	self._txtTips = {}
	self._txtConditions = {}

	for i = 1, 3 do
		self._txtAttribute[i] = goutil.findChildTextComponent(self.mainGO, "imgTip/attribute" .. i)
		self._txtTips[i] = goutil.findChildTextComponent(self.mainGO, "CollectionCondition/tip" .. i)
		self._txtConditions[i] = goutil.findChildTextComponent(self.mainGO, "CollectionCondition/txtCondition" .. i)
	end

	self._goCollectionCondition = goutil.findChild(self.mainGO, "CollectionCondition")
	self._btnTip = self:getBtn("btnTip")
	self._goCloseTip = goutil.findChild(self.mainGO, "btnCloseTip")
	self._customInput = UICustomInput.Get(self._goCollectionCondition)

	goutil.setActive(self._goCollectionCondition, false)
	goutil.setActive(self._goCloseTip, false)

	self._attrTick = {}
	self._conditionTick = {}

	for i = 1, 3 do
		self._attrTick[i] = goutil.findChild(self.mainGO, "imgTip/attribute" .. i .. "/tick")
		self._conditionTick[i] = goutil.findChild(self.mainGO, "CollectionCondition/tip" .. i .. "/tick")
	end
end

function PetTeamView:destroyUI()
	PetTeamView.super.destroyUI(self)
end

function PetTeamView:onExitFinished()
	PetTeamView.super.onExitFinished(self)
end

function PetTeamView:onEnterFinished()
	PetTeamView.super.onEnterFinished(self)
	self:_updateUI()
end

function PetTeamView:unbindEvents()
	PetTeamView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._customInput:RemoveListener()
end

function PetTeamView:bindEvents()
	PetTeamView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnTip:AddClickListener(self._onClickTips, self)
	self._customInput:AddListener(self._onCollectionInputCallback, self)
end

function PetTeamView:onExit()
	PetTeamView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.RedPointUpdate, self._updateRedPoints, self)
end

function PetTeamView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function PetTeamView:_updateRedPoints(redPointId)
	if redPointId == RedPointModel.ID_PETTEAMS then
		print("petteamview updateRedPoints")
		self:reloadData()
	end
end

function PetTeamView:_updateCell(view, cell, data)
	local container = goutil.findChild(cell.gameObject, "container")
	local selected = goutil.findChild(container, "selected")
	local txtName = goutil.findChildTextComponent(container, "txtName")
	local redPoint = goutil.findChild(container, "redPoint")
	local btn = Framework.ButtonAdapter.Get(container)

	btn:AddClickListener(function()
		self:_onClickTab(data)
	end)

	local isSelected = self._mo == data

	goutil.setActive(selected, isSelected)

	local color = isSelected and "554F47" or "ffffff"

	txtName.text = string.format("<color=#%s>%s</color>", color, data.teamName)

	goutil.setActive(redPoint, HandbookModel.instance:getTeamPrizeIsRedById(data.teamId))
end

function PetTeamView:onEnter()
	PetTeamView.super.onEnter(self)

	self._mo = nil
	self._curViewDatas = HandbookConfig.instance:getCfgs()
	self.selectMountId = HandbookModel.instance:getSelectTabId()
	self._mo = self._curViewDatas[self.selectMountId]

	HandbookController.instance:checkDataAndCall(self._updateUI, self)
	GlobalDispatcher:addListener(GlobalNotify.RedPointUpdate, self._updateRedPoints, self)
end

function PetTeamView:_updateUI()
	self:_updateTeamUI()
	self:reloadData()
end

function PetTeamView:_onReloadFinish()
	return
end

function PetTeamView:_onClickClose()
	HandbookModel.instance:setSelectTabId(nil)

	for k, v in pairs(self.avatars) do
		local bigBg = v.imgIcon:GetComponent("ImageBigBG")

		if bigBg then
			bigBg:ClearImage()
		end
	end

	for k, v in pairs(self._progresses) do
		MaterialMgr.resetAll(v)
	end

	self:close()
end

function PetTeamView:_setItemView(idx, raceId)
	local pet = self.avatars[idx]
	local collectNum = 0
	local awakenNum = 0

	if pet then
		local modelCo = CharacterConfig.instance:getModelCo(raceId)

		uGuiUtil.setSpriteToImage(pet.imgIcon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))

		local hasPet = HandbookModel.instance:isHasPet(raceId)

		if hasPet then
			pet.imgIcon.material = self._normalMat.material
			collectNum = collectNum + 1
		else
			pet.imgIcon.material = self._grayMat.material
		end

		pet.btn:AddClickListener(function()
			self:_petClick(hasPet, raceId)
		end)

		local curLv = HandbookModel.instance:getAwakenNum(raceId)

		goutil.setActive(pet.starGo, curLv > 0)
		pet.starItem:updateStar(curLv)

		local starNum = CharacterConfig.instance:getAwakenRareCfg(curLv).starNum

		pet.posScript:LoadPlan((starNum - 1) % 6)

		awakenNum = awakenNum + curLv
	end

	return collectNum, awakenNum
end

function PetTeamView:_updateTeamUI()
	if self._mo == nil then
		return
	end

	self._txtTitle.text = self._mo.teamName
	self._txtDesc.text = self._mo.storyNote or "这是三主宠团队的描述"

	local collectNum = 0
	local listAwakenNum = {}
	local i = 1

	self._script:LoadPlan(checknumber(self._mo.teamId) - 1)

	for idx, raceId in ipairs(self._mo.needRaceIds) do
		local ret1, ret2 = self:_setItemView(idx, raceId)

		collectNum = collectNum + ret1

		table.insert(listAwakenNum, ret2)
	end

	for j = 1, 2 do
		goutil.setActive(self._progresses[j].mainGO, false)
	end

	local strAttribute_collect = ""
	local strCondition_collect = ""

	i = 0

	local color
	local prizes = HandbookConfig.instance:getTeamPrize(self._mo.teamId)
	local awakenPrizes = {}

	if prizes then
		for _, prize in pairs(prizes) do
			local initLevel = CharacterConfig.instance:getPetCo(self._mo.needRaceIds[1]).initAwakenLv
			local type = checknumber(prize.awakenLevel) > 0 and "awaken" or "collect"

			if type == "collect" then
				local pid = prize.prizeId
				local num = prize.progress
				local isReceived = HandbookModel.instance:getPrizeReceived(self._mo.teamId, pid)
				local progress = self._progresses[1]

				goutil.setActive(progress.mainGO, true)

				color = num <= collectNum and "000000" or "ff0000"
				progress.txtProgress.text = string.format("<color=#%s>%s</color>/%s", color, collectNum, num)
				progress.txtName.text = "成员收集数达到：" .. num

				if num > 0 then
					progress.sliderProgress.value = collectNum / num or 1
				end

				local canReceive = not isReceived and num <= collectNum

				goutil.setActive(progress.redPoint, canReceive)
				goutil.setActive(progress.btnClick, canReceive)
				goutil.setActive(progress.received, isReceived)
				progress.btn:AddClickListener(function()
					self:_receiveCollectPrize(num, prize)
				end)
				MaterialMgr.setCellByCfg(prize.prize, progress.itemPoint)

				local arr = GameUtil.propToList({
					prize.propertyApp
				})

				if num <= collectNum then
					strAttribute_collect = strAttribute_collect .. "<color=#11A568FF>·"
					strCondition_collect = strCondition_collect .. "<color=#11A568FF>·"

					for i = 1, #arr do
						strAttribute_collect = strAttribute_collect .. arr[i].name .. "+" .. self:__checkValue(arr[i].value)
						strCondition_collect = strCondition_collect .. arr[i].name .. "+" .. self:__checkValue(arr[i].value)

						if i ~= #arr then
							strAttribute_collect = strAttribute_collect .. ","
							strCondition_collect = strCondition_collect .. ","
						end
					end

					strAttribute_collect = strAttribute_collect .. "</color>\n"
					strCondition_collect = strCondition_collect .. "</color>\n"

					goutil.setActive(self._attrTick[1], true)
					goutil.setActive(self._conditionTick[1], true)
				else
					strAttribute_collect = strAttribute_collect .. "·"

					for i = 1, #arr do
						strAttribute_collect = strAttribute_collect .. arr[i].name .. "+" .. self:__checkValue(arr[i].value)

						if i ~= #arr then
							strAttribute_collect = strAttribute_collect .. ","
						end
					end

					strAttribute_collect = strAttribute_collect .. "\n"
					strCondition_collect = strCondition_collect .. "·"

					for i = 1, #arr do
						strCondition_collect = strCondition_collect .. arr[i].name .. "+" .. self:__checkValue(arr[i].value)

						if i ~= #arr then
							strCondition_collect = strCondition_collect .. ","
						end
					end

					strCondition_collect = strCondition_collect .. "\n"

					goutil.setActive(self._attrTick[1], false)
					goutil.setActive(self._conditionTick[1], false)
				end
			elseif type == "awaken" then
				table.insert(awakenPrizes, prize)
			end
		end
	end

	self._txtAttribute[1].text = strAttribute_collect
	self._txtTips[1].text = strCondition_collect

	table.sort(awakenPrizes, function(a, b)
		return a.progress < b.progress
	end)

	local awakenNoshow = true

	if awakenPrizes then
		for i = 1, #awakenPrizes do
			local strAttribute_awake = ""
			local strCondition_awake = ""
			local pid = awakenPrizes[i].prizeId
			local isReceived = HandbookModel.instance:getPrizeReceived(self._mo.teamId, pid)
			local level = awakenPrizes[i].awakenLevel
			local num = awakenPrizes[i].progress
			local awakenNum = 0

			for k, v in ipairs(listAwakenNum) do
				if level <= v then
					awakenNum = awakenNum + 1
				end
			end

			if (not isReceived or i == #awakenPrizes) and awakenNoshow then
				local progress = self._progresses[2]

				goutil.setActive(progress.mainGO, true)

				progress.txtName.text = "星级均达到：" .. CharacterConfig.instance:getAwakenRareCfg(level).name

				if num > 0 then
					progress.sliderProgress.value = awakenNum / num or 1
				end

				color = num <= awakenNum and "000000" or "ff0000"
				progress.txtProgress.text = string.format("<color=#%s>%s</color>/%s", color, awakenNum, num)

				local canReceive = not isReceived and num <= awakenNum

				goutil.setActive(progress.redPoint, canReceive)
				goutil.setActive(progress.btnClick, canReceive)
				goutil.setActive(progress.received, isReceived)
				progress.btn:AddClickListener(function()
					self:_receiveAwakenPrize(num, awakenPrizes[i])
				end)
				MaterialMgr.setCellByCfg(awakenPrizes[i].prize, progress.itemPoint)

				awakenNoshow = false
			end

			local arr = GameUtil.propToList({
				awakenPrizes[i].propertyApp
			})

			self._txtConditions[1 + i].text = "星级均达到" .. CharacterConfig.instance:getAwakenRareCfg(level).name .. "完成激活" .. "\n"

			if num <= awakenNum then
				strAttribute_awake = strAttribute_awake .. "<color=#11A568FF>·"
				strCondition_awake = strCondition_awake .. "<color=#11A568FF>·"

				for i = 1, #arr do
					strAttribute_awake = strAttribute_awake .. arr[i].name .. "+" .. self:__checkValue(arr[i].value)
					strCondition_awake = strCondition_awake .. arr[i].name .. "+" .. self:__checkValue(arr[i].value)

					if i ~= #arr then
						strAttribute_awake = strAttribute_awake .. ","
						strCondition_awake = strCondition_awake .. ","
					end
				end

				strAttribute_awake = strAttribute_awake .. "</color>\n"
				strCondition_awake = strCondition_awake .. "</color>\n"

				goutil.setActive(self._attrTick[1 + i], true)
				goutil.setActive(self._conditionTick[1 + i], true)
			else
				strAttribute_awake = strAttribute_awake .. "·"

				for i = 1, #arr do
					strAttribute_awake = strAttribute_awake .. arr[i].name .. "+" .. self:__checkValue(arr[i].value)

					if i ~= #arr then
						strAttribute_awake = strAttribute_awake .. ","
					end
				end

				strAttribute_awake = strAttribute_awake .. "\n"
				strCondition_awake = strCondition_awake .. "·"

				for i = 1, #arr do
					strCondition_awake = strCondition_awake .. arr[i].name .. "+" .. self:__checkValue(arr[i].value)

					if i ~= #arr then
						strCondition_awake = strCondition_awake .. ","
					end
				end

				strCondition_awake = strCondition_awake .. "\n"

				goutil.setActive(self._attrTick[1 + i], false)
				goutil.setActive(self._conditionTick[1 + i], false)
			end

			self._txtAttribute[1 + i].text = strAttribute_awake
			self._txtTips[1 + i].text = strCondition_awake
		end
	end
end

function PetTeamView:__checkValue(value)
	if value < 1 then
		return GameUtil.getMillesimalStr(value * 1000)
	else
		return value
	end
end

function PetTeamView:_onClickTab(data)
	if self._mo ~= data then
		self:_clearCurSelected()

		self._mo = data

		HandbookModel.instance:setSelectTabId(data.teamId)
		self:_updateCellByData(data)
		self:_updateTeamUI()
	end
end

function PetTeamView:_clearCurSelected()
	local mo = self._mo

	self._mo = nil

	if mo ~= nil then
		self:_updateCellByData(mo)
	end
end

function PetTeamView:_updateCellByData(data)
	for k, v in ipairs(self._curViewDatas) do
		if v == data then
			self._tableview:UpdateCellAtIndex(k - 1)
		end
	end
end

function PetTeamView:_petClick(isHasPet, raceId)
	if isHasPet then
		local arrAllPets = BagModel.instance:getBagPets()
		local maxLevel = 1
		local mo

		for k, v in pairs(arrAllPets) do
			if v.raceId == raceId and maxLevel <= v.awakenLv then
				mo = v
				maxLevel = v.awakenLv
			end
		end

		if mo then
			BagPetsController.instance:openBagPetView(mo.petId)
		else
			FloatWordMgr.instance:show("该精灵不在背包中，无法转跳哦")
		end
	else
		local petInfo = CharacterConfig.instance:getPetInfoCo(raceId)

		FloatWordMgr.instance:show("未曾获得过" .. petInfo.name)
	end
end

function PetTeamView:_receiveCollectPrize(collectNum, cfg)
	local pid = cfg.prizeId

	PetManualAgent.instance:sendGainPetManualTeamPrizeReq(self._mo.teamId, pid, function(msg)
		HandbookModel.instance:setPrizeReceived(self._mo.teamId, pid)
		FloatWordMgr.instance:show("领取成功")
		self:_updateUI()
	end)
end

function PetTeamView:_receiveAwakenPrize(awakenLv, cfg)
	local pid = cfg.prizeId

	PetManualAgent.instance:sendGainPetManualTeamPrizeReq(self._mo.teamId, pid, function(msg)
		HandbookModel.instance:setPrizeReceived(self._mo.teamId, pid)
		FloatWordMgr.instance:show("领取成功")
		self:_updateUI()
	end)
end

function PetTeamView:_onClickTips()
	goutil.setActive(self._goCollectionCondition, true)
end

function PetTeamView:_onCollectionInputCallback(hover)
	if not hover then
		goutil.setActive(self._goCollectionCondition, false)
	end
end

return PetTeamView
