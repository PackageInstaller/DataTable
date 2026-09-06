-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sevendays/view/SevenDaysView.lua

module("logic.extensions.sevendays.view.SevenDaysView", package.seeall)

local SevenDaysView = class("SevenDaysView", TableViewComponent)

function SevenDaysView:ctor()
	SevenDaysView.super.ctor(self)

	self.goodsItemList = nil
	self.daysBtnList = nil
	self.titleBtnList = nil
	self.taskInfoList = nil
	self.clientTypeList = nil
	self.scoreInfoData = nil
	self.registDaysNum = 1
	self.choiseDaysNum = 0
	self.choiseTitleNum = 1
	self.scoreEffList = nil
end

function SevenDaysView:onExitFinished()
	SevenDaysView.super.onExitFinished(self)
end

function SevenDaysView:onEnterFinished()
	SevenDaysView.super.onEnterFinished(self)
end

function SevenDaysView:buildUI()
	SevenDaysView.super.buildUI(self)

	local spriteInfoGo = self:getGo("spriteInfoGo")
	local spriteRawIma = goutil.findChild(spriteInfoGo, "spriteRawIma")

	self.photoEff = PhotoEffect.Get(spriteRawIma)
	self.roleImg = spriteRawIma:GetComponent("RawImage")
	self.roleImg.material = nil
	self.spriteSkillBtn = Framework.ButtonAdapter.GetFrom(spriteInfoGo, "spriteSkillBtn")
	self.spriteExplainBtn = Framework.ButtonAdapter.GetFrom(spriteInfoGo, "spriteExplainBtn")
	self.spriteNameTxt = goutil.findChildTextComponent(spriteInfoGo, "spriteNameTxt")
	self.spriteTimeTxt = goutil.findChildTextComponent(spriteInfoGo, "spriteTimeTxt")

	local upInfoGo = self:getGo("upInfo")

	self.backClickBtn = Framework.ButtonAdapter.GetFrom(upInfoGo, "backClickBtn")
	self.coinAddBtn = Framework.ButtonAdapter.GetFrom(upInfoGo, "coinItem/coinAddBtn")
	self.coinCountTxt = goutil.findChildTextComponent(upInfoGo, "coinItem/coinCountTxt")
	self.diamondAddBtn = Framework.ButtonAdapter.GetFrom(upInfoGo, "diamondItem/diamondAddBtn")
	self.diamondCountTxt = goutil.findChildTextComponent(upInfoGo, "diamondItem/diamondCountTxt")

	local scoreInfoGo = self:getGo("scoreInfoGo")

	self.scoreBarSli = goutil.findChildComponent(scoreInfoGo, "scoreBarSli", "Slider")
	self.goodsShowTran = goutil.findChild(scoreInfoGo, "goodsShowTran").transform
	self.goodsItemGo = goutil.findChild(scoreInfoGo, "goodsItemGo")
	self.nowScoreTxt = goutil.findChildTextComponent(scoreInfoGo, "nowScoreTxt")
	self.scoreBarSli.value = 0

	self.goodsItemGo:SetActive(false)

	local rightInfo = self:getGo("rightInfo")

	self.daysBtnSR = goutil.findChildComponent(rightInfo, "daysBtnSR", "UITableview")
	self.daysGo = goutil.findChild(rightInfo, "daysGo")
	self.titleBtnTran = goutil.findChild(rightInfo, "titleBtnTran").transform
	self.titleGo = goutil.findChild(rightInfo, "titleGo")
	self.titleGo.transform.parent = self.titleBtnTran
	self.nowScoreTxt.text = "0"

	self.daysGo:SetActive(false)
	self.titleGo:SetActive(false)

	self.viewEffPos = self:getGo("viewEffPos")

	self:GetTransformChildGo()

	self._goldBarCon = self:getGo("goldBarCon")
end

function SevenDaysView:bindEvents()
	SevenDaysView.super.bindEvents(self)
	self.backClickBtn:AddClickListener(self.close, self)
	self.coinAddBtn:AddClickListener(function()
		FuncOpenController.instance:openFunc(70)
	end, self)
	self.diamondAddBtn:AddClickListener(function()
		FloatWordMgr.instance:show(ConstString.NotRelease)
		SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickDiamondChargeButton)
	end, self)
end

function SevenDaysView:unbindEvents()
	SevenDaysView.super.unbindEvents(self)
	self.backClickBtn:RemoveClickListener()
	self.coinAddBtn:RemoveClickListener()
	self.diamondAddBtn:RemoveClickListener()
	self.spriteSkillBtn:RemoveClickListener()
	self.spriteExplainBtn:RemoveClickListener()
end

function SevenDaysView:onExit()
	SevenDaysModel.instance:SevenDaysChoisNums(true, self.choiseDaysNum, self.choiseTitleNum)

	if self.pmEff then
		UIEffectManager.instance:stopEffect(self.pmEff)
	end

	self.pmEff = nil

	for _, eff in pairs(self.scoreEffList or {}) do
		if eff then
			UIEffectManager.instance:stopEffect(eff)
		end
	end

	self.scoreEffList = nil

	self.photoEff:clear()
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialCountChange, self.OnMoneyCountChange, self)
	GlobalDispatcher:removeListener("UpdataSevenDaysTask", self.UpdataSevenDaysTask, self)

	self._curViewDatas = nil
	self.taskInfoList = nil
	self.clientTypeList = nil
	self.scoreInfoData = nil
end

function SevenDaysView:destroyUI()
	SevenDaysView.super.destroyUI(self)

	self.pmEff = nil
	self.scoreEffList = nil
	self.taskInfoList = nil
	self.clientTypeList = nil
	self.scoreInfoData = nil
	self.registDaysNum = 1
	self.choiseDaysNum = 0
	self.choiseTitleNum = 1
end

function SevenDaysView:onEnter()
	SevenDayTaskAgent.instance:sendPM_SevenDayTaskGetInfoReq()

	local nums = SevenDaysModel.instance:SevenDaysChoisNums()

	self.choiseDaysNum = nums.daysNum
	self.choiseTitleNum = nums.titlesNum

	local effPath = "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab"

	self.pmEff = UIEffectManager.instance:playEffect(self, effPath, self.viewEffPos, 0, 0, true, nil, nil, nil, self)

	self.pmEff:setParent(self.viewEffPos.transform)
	self.pmEff:setLocalPos(0, 0, 0)
	self.pmEff:setScale(1)
	self:OnMoneyCountChange()

	self.registDaysNum = SevenDaysController.instance:GetRegisteredTimeDay(true)

	if self.registDaysNum > 7 then
		self.registDaysNum = 7
	end

	self:UpdataSevenDaysTask()
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self.OnMoneyCountChange, self)
	GlobalDispatcher:addListener("UpdataSevenDaysTask", self.UpdataSevenDaysTask, self)

	local btn_list = {
		{
			showAdd = false,
			id = GameEnum.GoldType.Diamond
		},
		{
			showAdd = false,
			id = GameEnum.GoldType.Coin
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list)
end

function SevenDaysView:GetTransformChildGo()
	self.daysBtnSR:RegisterCallback(function()
		return 7
	end, self.DaysBtnSize, self.DaysBtnCellAtIndex, self)
	self.daysBtnSR:RegisterUpdateCellCallback(function(view, cell)
		cell.data = cell.index + 1

		self:UpdataDaysBtnCell(cell)
	end)
	self.daysBtnSR:RegisterReloadFinishCallback(function()
		self.daysBtnSR:MoveCellInView(self.choiseDaysNum - 1, false)
	end)

	if self.titleBtnList == nil or #self.titleBtnList == 0 then
		self.titleBtnList = {}
		self.titleGo.name = "titleGo_1"

		self:GetChildGameObjectCom(3, self.titleGo)
	end
end

function SevenDaysView:GetChildGameObjectCom(index, go)
	if go == nil then
		return
	end

	local names = string.split(go.name, "_")
	local num = tonumber(names[2])

	if index == 1 then
		self.goodsItemList[num] = {
			itemGo = go,
			receiveCountTxt = goutil.findChildTextComponent(go, "receiveCountTxt"),
			receiveShowGo = goutil.findChild(go, "receiveShowGo"),
			itemBtnGo = goutil.findChild(go, "itemBtnGo")
		}
	elseif index == 2 then
		local dayTxt = goutil.findChildTextComponent(go, "daysShowTxt")

		dayTxt.text = ""
		self.daysBtnList[num] = {
			itemGo = go,
			daysShowTxt = dayTxt,
			daysLockGo = goutil.findChild(go, "daysLockGo"),
			daysRedPointGo = goutil.findChild(go, "daysRedPointGo")
		}
	elseif index == 3 then
		self.titleBtnList[num] = {
			itemGo = go,
			itemIconSpt = go:GetComponent("UIImageSpriteChange"),
			titleNameTxt = goutil.findChildTextComponent(go, "titleNameTxt"),
			titleRedPointGo = goutil.findChild(go, "titleRedPointGo")
		}
	end
end

function SevenDaysView:OnMoneyCountChange()
	self.coinCountTxt.text = MaterialModel.instance:getMaterialsNumber(MatType.Coin, 1)

	local num = RoleModel.instance:getPayDiamond() + RoleModel.instance:getPresentDiamond()

	self.diamondCountTxt.text = tostring(num)
end

function SevenDaysView:UpdataSevenDaysTask()
	self.registDaysNum = SevenDaysController.instance:GetRegisteredTimeDay()

	if self.registDaysNum > 7 then
		self.registDaysNum = 7
	end

	self:ShowSpriteInfo()
	self:ShowScoreInfo()
	self:ClickOnDaysBtn(self.choiseDaysNum, true)
end

function SevenDaysView:ShowSpriteInfo()
	local goodsInfo = SevenDaysController.instance:GetLastScoreGoods()

	self.spriteNameTxt.text = ""
	self.spriteTimeTxt.text = ""

	if goodsInfo == nil or #goodsInfo <= 1 then
		return
	end

	local goodsType = tonumber(goodsInfo[1])
	local goodsId = tonumber(goodsInfo[2])

	if goodsType ~= MatType.Pet then
		return
	end

	local cfg = MaterialMgr.getMatCfg(goodsType, goodsId)

	if cfg == nil then
		return
	end

	self.spriteNameTxt.text = cfg.name

	self.spriteSkillBtn:AddClickListener(function()
		UIJumper.instance:pushOneStack(self._viewPresentor.viewName, true)
		PetbookController.instance:openPetinfoView(goodsId)
	end, self)
	self.spriteExplainBtn:AddClickListener(function()
		BattleFacade.instance:sendPreviewPetBattle(goodsId)
	end, self)
	self.photoEff:setEffectLoadedCallback(function(go)
		local x, y, scale = 0, 0, 1
		local displayBagOffset = CharactorFacade.instance:getPetBagModelUIPosAndScale(goodsId)

		if displayBagOffset then
			x = displayBagOffset[1] or 0
			y = displayBagOffset[2] or 0
			scale = displayBagOffset[3] or 1
		end

		x = x / 360
		y = y / 360

		GoUtil.PlaySpineAnim(go, "idle", true, true)

		local scaleX, scaleY, scaleZ = Framework.TransformUtil.GetLocalScale(go.transform, 0, 0, 0)

		scaleX = scaleX * scale
		scaleY = scaleY * scale

		Framework.TransformUtil.SetLocalScale(go.transform, scaleX, scaleY, 1)
		Framework.TransformUtil.SetLocalPos(go.transform, x, y, 0)
	end)

	local resCfg = CharacterConfig.instance:getModelCo(checknumber(goodsId))

	self.photoEff:showEffectsFullScreen({
		GameUrl.getSpineUrl(resCfg.resName)
	})
	self.photoEff:setCameraPosition(0.8, 4.1, -1)

	local camera = self.photoEff._photo.producer.rtCamera

	camera.orthographic = true

	Game.ImageUtil.SetRawImageAlpha(self.roleImg, 1)
	self:CalculationSurplusTime()
end

function SevenDaysView:CalculationSurplusTime()
	if not ViewMgr.instance:isOpen(ViewName.SevenDays) then
		return
	end

	local daysNum = SevenDaysController.instance:GetRegisteredTimeDay(true)
	local now = ServerTime.nowDateServerLook()
	local days = SevenDaysModel.instance.sevenDays - daysNum

	if days < 0 or self.spriteTimeTxt == nil then
		self:close()

		return
	end

	local refreshTime = ClockMgr.instance._refreshTime
	local hour = refreshTime - now.hour
	local min = 0

	if refreshTime <= now.hour then
		hour = hour + 24
	end

	if now.min > 0 then
		hour = hour - 1
		min = 60 - now.min
	end

	if days > 0 then
		if min > 0 then
			hour = hour + 1
		end

		self.spriteTimeTxt.text = string.format("%s天%s小时", days, hour)
	elseif hour == 24 then
		self.spriteTimeTxt.text = "即将结束"
	else
		if hour <= 0 and min < 1 then
			self:close()
			TipsFacade.instance:openTipWindow("活动提示", "当前活动已结束！", nil, "确定")

			return
		end

		self.spriteTimeTxt.text = string.format("%s小时%s分", hour, min)
	end

	settimer(1, self.CalculationSurplusTime, self, false)
end

function SevenDaysView:ShowScoreInfo()
	self.scoreEffList = self.scoreEffList or {}
	self.scoreInfoData = SevenDaysController.instance:GetAccumulateScoreData()

	local allScore = 0
	local haveScore = 0
	local count = 0

	if self.scoreInfoData then
		allScore = self.scoreInfoData.allScore
		haveScore = self.scoreInfoData.haveScore
		count = #self.scoreInfoData.scoreList
	end

	self.nowScoreTxt.text = tostring(haveScore)
	self.goodsItemList = self.goodsItemList or {}
	self.scoreBarSli.value = 0

	if count > 0 then
		local allX = 720
		local oneX = allX / count
		local jd = 1
		local scoreList = self.scoreInfoData.scoreList

		for i = 1, count do
			if self.goodsItemList[i] == nil then
				local go = UnityEngine.GameObject.Instantiate(self.goodsItemGo, self.goodsShowTran)

				go.name = "goodsItem_" .. i

				self:GetChildGameObjectCom(1, go)
			end

			local index = i

			self.goodsItemList[i].itemGo:SetActive(true)
			Framework.TransformUtil.SetLocalPos(self.goodsItemList[i].itemGo.transform, i * oneX, 0, 0)

			self.goodsItemList[i].receiveCountTxt.text = tostring(scoreList[i].score)

			local goodsInfo = string.split(scoreList[i].goods, ":")
			local goodsType = tonumber(goodsInfo[1])
			local goodsId = tonumber(goodsInfo[2])
			local subLua = MaterialMgr.setCell(goodsType, goodsId, self.goodsItemList[i].itemGo)

			subLua.binder:setNum(tonumber(goodsInfo[3]))
			GameUtil.setLocalScale(subLua.view, 0.65, 0.65, 0.65)
			Framework.TransformUtil.SetLocalPos(subLua.view.transform, 0, 10, 0)

			if scoreList[i].isReceive then
				if self.scoreEffList[i] then
					UIEffectManager.instance:stopEffect(self.scoreEffList[i])

					self.scoreEffList[i] = nil
				end

				self.goodsItemList[i].receiveShowGo:SetActive(true)
				subLua.binder:setAutoTips(false)
				self.goodsItemList[i].itemBtnGo.transform:SetAsLastSibling()
				uGuiUtil.setImageAlpha(self.goodsItemList[i].itemBtnGo:GetComponent("Image"), 0.2)
				self.goodsItemList[i].receiveShowGo.transform:SetAsLastSibling()

				if jd < i then
					jd = i
				end
			else
				uGuiUtil.setImageAlpha(self.goodsItemList[i].itemBtnGo:GetComponent("Image"), 0)
				self.goodsItemList[i].receiveShowGo:SetActive(false)

				if haveScore >= scoreList[i].score then
					subLua.binder:setAutoTips(false)
					self.goodsItemList[i].itemBtnGo.transform:SetAsLastSibling()

					if jd < i then
						jd = i
					end

					if self.scoreEffList[i] == nil then
						local effPath = "fx_ui_qirirenwu/fx_qirirenwu_kelingqu.prefab"

						self.scoreEffList[i] = UIEffectManager.instance:playEffect(self, effPath, self.goodsItemList[i].itemBtnGo, 0, 0, true, nil, nil, nil, self)

						self.scoreEffList[i]:setParent(self.goodsItemList[i].itemBtnGo.transform)
						self.scoreEffList[i]:setLocalPos(0, 10.8, 0)
						self.scoreEffList[i]:setScale(1)
					end
				else
					if self.scoreEffList[i] then
						UIEffectManager.instance:stopEffect(self.scoreEffList[i])

						self.scoreEffList[i] = nil
					end

					if index == count then
						self.goodsItemList[i].itemBtnGo.transform:SetAsLastSibling()
					else
						self.goodsItemList[i].itemBtnGo.transform:SetAsFirstSibling()
					end
				end
			end

			GameUtil.asBtn(self.goodsItemList[i].itemBtnGo):AddClickListener(function()
				if scoreList[i].isReceive then
					FloatWordMgr.instance:show("已领取！")

					return
				end

				if scoreList[i].score > haveScore then
					if index == count then
						CommonTipsMgr.instance:showMaxLvlPetTips(goodsId)

						return
					end

					FloatWordMgr.instance:show("未达到领取条件！")

					return
				end

				SevenDaysController.instance:CSRequestReceiveScore(index - 1)
			end, self)
		end

		if jd < count then
			local sy = haveScore - scoreList[jd].score
			local yy = scoreList[jd + 1].score - scoreList[jd].score

			self.scoreBarSli.value = jd / count + sy / (count * yy)
		else
			self.scoreBarSli.value = 1
		end
	end

	if count < #self.goodsItemList then
		for i = count + 1, #self.goodsItemList do
			if self.goodsItemList[i] and self.goodsItemList[i].itemGo.activeSelf then
				self.goodsItemList[i].itemGo:SetActive(false)
			end
		end
	end
end

function SevenDaysView:ShowTitleItem()
	self.taskInfoList, self.clientTypeList = SevenDaysController.instance:GetTaskDataByDays(self.choiseDaysNum)

	if self.clientTypeList then
		if not #self.clientTypeList then
			local count = 0

			self.titleBtnList = self.titleBtnList or {}

			if count > 0 then
				for i = 1, count do
					if self.titleBtnList[i] == nil then
						local go = UnityEngine.GameObject.Instantiate(self.titleGo, self.titleBtnTran)

						go.name = "titleGo_" .. i

						self:GetChildGameObjectCom(3, go)
					end

					self.titleBtnList[i].itemGo:SetActive(true)

					if i == self.choiseTitleNum then
						self.titleBtnList[i].itemIconSpt:SetState(1)

						self.titleBtnList[i].titleNameTxt.text = "<color=#FFFFFFFF>" .. self.clientTypeList[i].nameStr .. "</color>"
					else
						self.titleBtnList[i].itemIconSpt:SetState(0)

						self.titleBtnList[i].titleNameTxt.text = "<color=#696969FF>" .. self.clientTypeList[i].nameStr .. "</color>"
					end

					local isRedPoint = SevenDaysController.instance:GetTitleTaskRedPoint(self.clientTypeList[i].dayId, self.clientTypeList[i].clientType)

					self.titleBtnList[i].titleRedPointGo:SetActive(isRedPoint)

					local index = i

					GameUtil.asBtn(self.titleBtnList[i].itemGo):AddClickListener(function()
						self:ClickTitleBtn(index)
					end, self)
				end
			end

			if count < #self.titleBtnList then
				for i = count + 1, #self.titleBtnList do
					if self.titleBtnList[i] and self.titleBtnList[i].itemGo.activeSelf then
						self.titleBtnList[i].itemGo:SetActive(false)
					end
				end
			end
		end
	end
end

function SevenDaysView:ClickTitleBtn(index, isForce)
	if self.choiseTitleNum == index and not isForce then
		return
	end

	if self.titleBtnList and self.titleBtnList[self.choiseTitleNum] then
		self.titleBtnList[self.choiseTitleNum].itemIconSpt:SetState(0)

		if self.clientTypeList[self.choiseTitleNum] then
			if not self.clientTypeList[self.choiseTitleNum].nameStr then
				do
					local nameStr = "其他"

					self.titleBtnList[self.choiseTitleNum].titleNameTxt.text = "<color=#696969FF>" .. nameStr .. "</color>"
				end

				if self.titleBtnList and self.titleBtnList[index] then
					self.titleBtnList[index].itemIconSpt:SetState(1)

					if self.clientTypeList[index] then
						if not self.clientTypeList[index].nameStr then
							local nameStr = "其他"

							self.titleBtnList[index].titleNameTxt.text = "<color=#FFFFFFFF>" .. nameStr .. "</color>"
						end
					end
				end
			end
		end
	end

	self.choiseTitleNum = index
	self._curViewDatas = nil

	if self.clientTypeList and self.clientTypeList[self.choiseTitleNum] then
		local titleInfo = self.clientTypeList[self.choiseTitleNum]

		if titleInfo and self.taskInfoList and self.taskInfoList[titleInfo.clientType] then
			self._curViewDatas = self.taskInfoList[titleInfo.clientType]
		end
	end

	self._tableview:ReloadData()
	self._tableview:MoveCellInView(0, false)
end

function SevenDaysView:_getPath()
	return {
		cellPath = "rightInfo/itemInfoGo",
		viewPath = "rightInfo/itemListSR"
	}
end

function SevenDaysView:_cellSize()
	return 790, 118
end

function SevenDaysView:_updateCell(view, cell, data)
	local infoNameTxt = goutil.findChildTextComponent(cell, "infoNameTxt")
	local infoDesTxt = goutil.findChildTextComponent(cell, "infoDesTxt")
	local cellGo_1 = goutil.findChild(cell, "cellGo_1")
	local cellGo_2 = goutil.findChild(cell, "cellGo_2")
	local infoScoreTxt = goutil.findChildTextComponent(cell, "infoScoreSpt/infoScoreTxt")
	local receiveBtnGo = goutil.findChild(cell, "receiveBtn")
	local receiveSpt = receiveBtnGo:GetComponent("UIImageSpriteChange")
	local receiveTxt = goutil.findChildTextComponent(cell, "receiveBtn/receiveTxt")
	local countShowTxt = goutil.findChildTextComponent(cell, "countShowTxt")
	local receiveGo = goutil.findChild(cell, "receiveGo")

	infoNameTxt.text = data.nameStr
	infoDesTxt.text = data.des
	infoScoreTxt.text = "x" .. data.score

	if data.isReceive then
		receiveTxt.text = ""
		countShowTxt.text = ""

		receiveBtnGo:SetActive(false)
		receiveGo:SetActive(true)
	else
		receiveGo:SetActive(false)

		countShowTxt.text = data.havePro .. "/" .. data.maxPro

		if data.maxPro <= data.havePro then
			receiveBtnGo:SetActive(true)
			receiveSpt:SetState(1)

			receiveTxt.text = "领取"

			Framework.TransformUtil.SetLocalPos(countShowTxt.gameObject.transform, 300, 30, 0)
		elseif string.nilorempty(data.jumpTo) then
			receiveBtnGo:SetActive(false)

			receiveTxt.text = ""

			Framework.TransformUtil.SetLocalPos(countShowTxt.gameObject.transform, 300, 0, 0)
		else
			receiveBtnGo:SetActive(true)
			receiveSpt:SetState(0)

			receiveTxt.text = "前往"

			Framework.TransformUtil.SetLocalPos(countShowTxt.gameObject.transform, 300, 30, 0)
		end
	end

	local list = string.split(data.goods, "#")

	if list and #list > 0 then
		for i = 1, #list do
			local goodsInfo = string.split(list[i], ":")
			local subLua = i == 1 and MaterialMgr.setCell(tonumber(goodsInfo[1]), tonumber(goodsInfo[2]), cellGo_1) or MaterialMgr.setCell(tonumber(goodsInfo[1]), tonumber(goodsInfo[2]), cellGo_2)

			subLua.binder:setNum(tonumber(goodsInfo[3]))
			GameUtil.setLocalScale(subLua.view, 0.8, 0.8, 0.8)
		end
	end

	if data.isReceive then
		return
	end

	GameUtil.asBtn(receiveBtnGo):AddClickListener(function()
		if data.maxPro <= data.havePro then
			SevenDaysController.instance:CSRequestReceiveTask(data.baseId)

			return
		end

		if string.nilorempty(data.jumpTo) then
			FloatWordMgr.instance:show("未满足领取条件！")
		else
			GotoMgr.gotoByString(data.jumpTo)
		end
	end, self)
end

function SevenDaysView:DaysBtnSize()
	return 120, 120
end

function SevenDaysView:DaysBtnCellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self.daysGo)
	cell.data = index + 1
	cell.index = index

	self:UpdataDaysBtnCell(cell)

	return cell
end

function SevenDaysView:UpdataDaysBtnCell(cell)
	local itemSpt = cell.gameObject:GetComponent("Image")
	local daysShowTxt = goutil.findChildTextComponent(cell, "daysShowTxt")
	local daysLockGo = goutil.findChild(cell, "daysLockGo")
	local daysRedPointGo = goutil.findChild(cell, "daysRedPointGo")
	local index = cell.data

	daysShowTxt.text = langPara("第%s天", ConstString.ChineseNumber[index])

	if index == self.choiseDaysNum then
		uGuiUtil.setImageAlpha(itemSpt, 1)

		daysShowTxt.color = Color.New(1, 1, 1, 1)

		if daysLockGo.activeSelf then
			daysLockGo:SetActive(false)
		end

		local isRedPoint = SevenDaysController.instance:GetDyasTaskRedPoint(index)

		daysRedPointGo:SetActive(isRedPoint)
	elseif index > self.registDaysNum then
		uGuiUtil.setImageAlpha(itemSpt, 0.5)

		daysShowTxt.color = Color.New(1, 1, 1, 0.5)

		if not daysLockGo.activeSelf then
			daysLockGo:SetActive(true)
		end

		if daysRedPointGo.activeSelf then
			daysRedPointGo:SetActive(false)
		end
	else
		uGuiUtil.setImageAlpha(itemSpt, 0.5)

		daysShowTxt.color = Color.New(1, 1, 1, 0.5)

		if daysLockGo.activeSelf then
			daysLockGo:SetActive(false)
		end

		local isRedPoint = SevenDaysController.instance:GetDyasTaskRedPoint(index)

		daysRedPointGo:SetActive(isRedPoint)
	end

	GameUtil.asBtn(cell.gameObject):AddClickListener(function()
		if index > self.registDaysNum then
			FloatWordMgr.instance:show("尚未开启！")

			return
		end

		self:ClickOnDaysBtn(index)
	end, self)
end

function SevenDaysView:ClickOnDaysBtn(index, isForce)
	if self.choiseDaysNum == index and not isForce then
		return
	end

	self.choiseDaysNum = index

	self.daysBtnSR:ReloadData()
	self:ShowTitleItem()
	self:ClickTitleBtn(self.choiseTitleNum, true)
end

return SevenDaysView
