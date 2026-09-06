-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonPassPortView.lua

module("logic.extensions.season.view.SeasonPassPortView", package.seeall)

local SeasonPassPortView = class("SeasonPassPortView", ViewComponent)

function SeasonPassPortView:ctor()
	SeasonPassPortView.super.ctor(self)

	self._viewData = nil
	self._clickTimer = 0
	self._bgChangeTime = 0
	self._isDown = false
	self._changeTime = 6
end

function SeasonPassPortView:bindEvents()
	SeasonPassPortView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnRuleExtra, self._onClickRuleExtra, self)
	GameUtil.addClickHandler(self._btnFind, self._onClickFind, self)
	GameUtil.addClickHandler(self._btnBuyLevel, self._onClickBuyLevel, self)
	GameUtil.addClickHandler(self._btnBuyPassport, self._onClickBuyPassport, self)
	GameUtil.addClickHandler(self._btnReceive, self._onClickReceive, self)
	GameUtil.addClickHandler(self._btnPet_1, self._onClickPet_1, self)
	GameUtil.addClickHandler(self._btnPet_2, self._onClickPet_2, self)
	GameUtil.addClickHandler(self._btnLock, self._onClickBuyPassport, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkillExplainBtn, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	self._longPress:AddListener(function(tar, isUp)
		self:_onLongPress(tar, isUp)
	end, self)
end

function SeasonPassPortView:unbindEvents()
	SeasonPassPortView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnFind)
	GameUtil.rmClickHandler(self._btnBuyLevel)
	GameUtil.rmClickHandler(self._btnBuyPassport)
	GameUtil.rmClickHandler(self._btnReceive)
	GameUtil.rmClickHandler(self._btnPet_1)
	GameUtil.rmClickHandler(self._btnPet_2)
	GameUtil.rmClickHandler(self._btnLock)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnOneKey)
	GameUtil.rmClickHandler(self._btnInfo)
	self._longPress:RemoveListener()
	self:_rmExtraClickHandler()
end

function SeasonPassPortView:buildUI()
	SeasonPassPortView.super.buildUI(self)

	self._effect = self:getGo("effect")
	self._goMid = self:getGo("mid")
	self._goTable = goutil.findChild(self._goMid, "tableview")
	self._goCell = goutil.findChild(self._goMid, "tablecell")
	self._extraPart = goutil.findChild(self._goMid, "extraPart")
	self._tableView = ScrollerList.create(self._goTable, {
		self._goCell,
		self._extraPart
	}, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tableView:regGetTagByIdx(GameUtil.handler(self.getTagByData, self))
	self._tableView:regGetCellSize(GameUtil.handler(self.getCellSize, self))

	self._txtTip = self:getTxt("txtTip")
	self._objBtnLock = self:getGo("mid/LeftBottom/iconBottom/btnLock")
	self._btnLock = self:getBtn("mid/LeftBottom/iconBottom/btnLock")
	self._sldProgress = self:getSlider("mid/sldProgress")
	self._txtValue = self:getTxt("mid/sldProgress/txtValue")
	self._txtLevel = self:getTxt("mid/txtProgress")
	self._btnFind = self:getBtn("mid/btnFind")
	self._btnBuyLevel = self:getBtn("mid/btnBuyLevel")
	self._goBtnBuyLevel = self:getGo("mid/btnBuyLevel")
	self._btnOneKey = self:getGo("btnOneKey")
	self._rpOneKey = goutil.findChild(self._btnOneKey, "imgredpoint")
	self._boBtnBuyPassport = self:getGo("btnBuyPassport")
	self._btnBuyPassport = self:getBtn("btnBuyPassport")
	self._petInfo = self:getGo("petInfo")
	self._pet = goutil.findChild(self._petInfo, "pet")
	self._role = goutil.findChild(self._petInfo, "role")
	self._petInfoTip = self:getGo("petInfo/tip")
	self._txtDesc = self:getTxt("petInfo/tip/txtDesc")
	self._btnReceive = self:getBtn("petInfo/tip/btnReceive")
	self._btnReceiveText = self:getTxt("petInfo/tip/btnReceive/Text")
	self._btnPet_1 = self:getBtn("petInfo/btnPet_1")
	self._btnPet_2 = self:getBtn("petInfo/btnPet_2")
	self._changeTab_1 = self._btnPet_1.gameObject:GetComponent(typeof(UIChangeGroup))
	self._changeTab_2 = self._btnPet_2.gameObject:GetComponent(typeof(UIChangeGroup))
	self._goBtnSkill = self:getGo("petInfo/btnSkill")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._goName = self:getGo("petInfo/name")
	self._txtName = self:getTxt("petInfo/name/txtName")
	self._rarePoint = self:getGo("petInfo/name/imgRare")
	self._goQuality = self:getGo("petInfo/name/imgSkinQuality")
	self._goBtnInfo = self:getGo("petInfo/name/btnInfo")
	self._btnInfo = self:getBtn("petInfo/name/btnInfo")
	self._longPress = self:getGo("petInfo/pet/longPress"):GetComponent("UILongPressed")
	self._btnFindRP = self:getGo("mid/btnFind/redpoint")
	self._btnOneKeyRP = self:getGo("btnOneKey/imgredpoint")
	self._btnReceiveRP = self:getGo("petInfo/tip/btnReceive/redpoint")
	self._viewRectTr = self:getGo("mid/tableview/Viewport"):GetComponent(goutil.Type_RectTransform)

	goutil.setActive(self._goQuality, false)
end

function SeasonPassPortView:onEnter()
	SeasonPassPortView.super.onEnter(self)

	self._proEffList = {}
	self._model = SeasonPassPortModel.instance

	GlobalDispatcher:addListener(GlobalNotify.SeasonPassPortUpdate, self._refreshView, self)

	self._isDown = false

	self._sldProgress:SetValue(0)

	self._txtLevel.text = "0级 0/0"

	goutil.setActive(self._extraPart, false)
	goutil.setActive(self._objBtnLock, true)
	settimer(1, self.updateTimer, self)

	self._viewData = self._model:GetSeasonPassPortViewData()

	if self._viewData then
		self:_refreshView(self._viewData)
	end
end

function SeasonPassPortView:onExit()
	SeasonPassPortView.super.onExit(self)
	self._tableView:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.SeasonPassPortUpdate, self._refreshView, self)
	removetimer(self.updateTimer, self)
	MaterialMgr.resetAll(self._rarePoint)

	self._model = nil

	self:_setViewEffect(false)
	self:_unLoadBigBg(self._pet)
	self:_unLoadRole()
end

function SeasonPassPortView:_refreshView(data)
	if not data then
		return
	end

	self._viewData = data

	self._tableView:reloadData(data.rewardData)

	self._txtLevel.text = data.nowUnlockLevel

	local energy = ""

	if data.nowUnlockLevel < data.maxLevel then
		energy = "(" .. data.nowEnergy - data.nowLvEnerg .. "/" .. data.nextLvEnerg - data.nowLvEnerg .. ")"

		self._sldProgress:SetValue((data.nowEnergy - data.nowLvEnerg) / (data.nextLvEnerg - data.nowLvEnerg))
	else
		self._sldProgress:SetValue(1)

		energy = "(已满级)溢出：" .. self._viewData.overflowEnergy
	end

	self._txtValue.text = energy
	self._txtTip.text = data.seasonTxt

	local txtCol = data.nowUnlockLevel >= data.maxLevel and "<color=#70E554FF>" or "<color=#D14043FF>"
	local desc = "1.勇者战令等级：" .. txtCol .. data.nowUnlockLevel .. "</color>/" .. data.maxLevel

	txtCol = data.finishChallenge and "<color=#70E554FF>" or "<color=#D14043FF>"
	desc = desc .. "\n2.完成最终挑战：" .. txtCol .. (data.finishChallenge and 1 or 0) .. "</color>/1"
	self._txtDesc.text = desc

	goutil.setActive(self._objBtnLock, not data.hasPay)
	goutil.setActive(self._boBtnBuyPassport, not data.hasPay)
	goutil.setActive(self._goName, data.raceId ~= 0 or data.skinId ~= 0)
	goutil.setActive(self._goBtnSkill, data.raceId ~= 0 or data.skinId ~= 0)

	self._btnReceiveText.text = data.hasgainfinalprize and "已领取" or data.baseCfg.rewardBtnDesc

	if self._viewData.raceId ~= 0 then
		self:_changeShowTab(1)
	else
		self:_changeShowTab(2)
	end

	self:_refreshRedDot()

	local idx = 0

	for i, v in ipairs(data.rewardData) do
		if v.id and v.id <= data.nowUnlockLevel and (not v.freeisReceive or data.hasPay and not v.payedisReceive) then
			idx = i

			break
		end
	end

	if idx == 0 and data.nowUnlockLevel >= data.maxLevel then
		idx = #data.rewardData
	end

	if idx > 0 then
		self._tableView:MoveCellInView(idx - 1, false)
	end

	self:_checkSetBtnBuyLevelGray()
end

function SeasonPassPortView:_updateCell(view, goCell, data, tag)
	if tag == 1 then
		local cell = self:_clearCell(goCell)

		cell.txtProgrss.text = data.id

		if not string.nilorempty(data.freeReward) then
			local reward = data.freeReward
			local item = cell.itemList[1]

			self:_setRewardItem(item, reward, data, data.freeisReceive, false)
		end

		local superRewardsCount = 0

		if not string.nilorempty(data.payedReward) then
			local rewards = string.split(data.payedReward, "#")
			local reward_1 = rewards[1]
			local item_1 = cell.itemList[2]

			goutil.setActive(item_1.go, reward_1)

			if reward_1 then
				superRewardsCount = 1

				self:_setRewardItem(item_1, reward_1, data, data.payedisReceive, true)
			end

			local reward_2 = rewards[2]
			local item_2 = cell.itemList[3]

			goutil.setActive(item_2.go, reward_2)

			if reward_2 then
				superRewardsCount = 2

				self:_setRewardItem(item_2, reward_2, data, data.payedisReceive, true)
			end
		end

		cell.itemsLayout.layoutOption = superRewardsCount == 2 and UILayoutSingleLine.LayoutOption.VerticalCenter or UILayoutSingleLine.LayoutOption.TopDown

		cell.itemsLayout:Layout()
	elseif tag == 2 then
		self:_rmExtraClickHandler()

		self._btnGetExtra = goutil.findChildButtonComponent(goCell, "btnGet")
		self._btnRuleExtra = goutil.findChildButtonComponent(goCell, "btnRule")

		GameUtil.addClickHandler(self._btnGetExtra, GameUtil.handler(self._onClickGetExtra, self, goCell))
		GameUtil.addClickHandler(self._btnRuleExtra, self._onClickRuleExtra, self)

		local txtProgressExtra = goutil.findChildTextComponent(goCell, "txtProgress")

		txtProgressExtra.text = self._viewData.overflowEnergy .. "/" .. self._viewData.baseCfg.lotteryEnergy
	end
end

function SeasonPassPortView:_setRewardItem(item, reward, data, isReceive, isSuper)
	local proxy = MaterialMgr.setCellByCfg(reward, item.item)
	local isUnlock = data.id <= self._viewData.nowUnlockLevel and not isReceive

	if isSuper then
		isUnlock = isUnlock and self._viewData.hasPay
	end

	goutil.setActive(item.recieve, not isUnlock)
	goutil.setActive(item.imgPassed, isReceive)

	if isUnlock then
		goutil.setActive(item.rp, true)
		proxy:setAutoTips(false)
		proxy:setCallBack(function()
			SeasonModeWarOrderController.instance:sendSeasonPassGetReward(isSuper, data.id)
		end)
	end

	self:_setItemEffect(isUnlock, item.go, item.item)
end

function SeasonPassPortView:_setItemEffect(isShow, mainGo, effGo)
	UIEffectManager.instance:stopEffect(self._proEffList[mainGo])

	self._proEffList[mainGo] = nil

	if isShow then
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		local function func(_, eff)
			eff:setParent(effGo.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)
			eff:setClipping(self._viewRectTr)
		end

		self._proEffList[mainGo] = UIEffectManager.instance:playEffect(self, effPath, effGo, 0, 0, true, false, nil, func, nil)
	end
end

function SeasonPassPortView:_checkSetBtnBuyLevelGray()
	local isGray = not GameUtil.checkTimeStr(self._viewData.baseCfg.sellTime)

	GameUtil.SetGray(self._goBtnBuyLevel, isGray)
end

function SeasonPassPortView:_rmExtraClickHandler()
	if self._btnGetExtra then
		GameUtil.rmClickHandler(self._btnGetExtra)

		self._btnGetExtra = nil
	end

	if self._btnRuleExtra then
		GameUtil.rmClickHandler(self._btnRuleExtra)

		self._btnRuleExtra = nil
	end
end

function SeasonPassPortView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.txtProgrss = goutil.findChildTextComponent(cell.go, "txtProgress")

	local goLayout = goutil.findChild(cell.go, "layout")

	if goLayout then
		cell.itemsLayout = goLayout:GetComponent(ComponentType.UILayoutSingleLine)
	end

	cell.itemList = {}

	for i = 1, 3 do
		local itemcell = {}

		itemcell.go = i == 1 and goutil.findChild(cell.go, "item_" .. i) or goutil.findChild(cell.go, "layout/item_" .. i)

		if not itemcell.go then
			return cell
		end

		itemcell.rp = goutil.findChild(itemcell.go, "redPoint")
		itemcell.recieve = goutil.findChild(itemcell.go, "recieve")
		itemcell.imgPassed = goutil.findChild(itemcell.recieve, "imgPassed")
		itemcell.item = goutil.findChild(itemcell.go, "cellPoint")

		MaterialMgr.resetAll(itemcell.item)
		goutil.setActive(itemcell.recieve, false)
		goutil.setActive(itemcell.rp, false)

		cell.itemList[i] = itemcell

		UIEffectManager.instance:stopEffect(self._proEffList[itemcell.go])

		self._proEffList[itemcell.go] = nil
	end

	return cell
end

function SeasonPassPortView:getTagByData(data, idx)
	return data.isLast and 2 or 1
end

function SeasonPassPortView:getCellSize(view, idx)
	if self._viewData.rewardData[idx + 1].isLast then
		return 216, 432
	end

	return 124, 432
end

function SeasonPassPortView:updateTimer()
	if self._isDown then
		self._bgChangeTime = 0
	end

	if self._viewData.raceId == 0 or self._viewData.skinId == 0 then
		removetimer(self.updateTimer, self)

		return
	end

	if self._bgChangeTime >= self._changeTime then
		self:_changeShowTab(self._nowSlectBgIndex == 1 and 2 or 1)
	else
		self._bgChangeTime = self._bgChangeTime + 1
	end
end

function SeasonPassPortView:_changeShowTab(index)
	self._bgChangeTime = 0
	self._nowSlectBgIndex = index

	MaterialMgr.resetAll(self._rarePoint)
	GameUtil.SetActive(self._goQuality, false)
	GameUtil.SetActive(self._goBtnInfo, false)
	GameUtil.SetActive(self._btnPet_1, false)
	GameUtil.SetActive(self._btnPet_2, false)

	if index == 2 then
		if self._viewData.skinId ~= 0 then
			local cfg = PetSkinConfig.instance:getPetSkinCfg(self._viewData.skinId)

			if cfg.quality > 0 then
				GameUtil.setUIImageSpriteIdx(self._goQuality, cfg.quality)
				GameUtil.SetActive(self._goQuality, true)
			end

			self._txtName.text = cfg.skinName
		else
			self._txtName.text = self._viewData.baseCfg.showTabNameB
		end

		if self._viewData.raceId ~= 0 then
			GameUtil.SetActive(self._btnPet_1, true)
		end

		self:_setViewEffect(false)
	else
		if self._viewData.raceId ~= 0 then
			self._txtName.text = self._viewData.raceName

			local cfg = PetSkinConfig.instance:getPetSkinCfg(self._viewData.raceId)

			if cfg then
				local petCo = CharacterConfig.instance:getPetCo(self._viewData.raceId)
				local rare = CharacterConfig.instance:getRareByAwakenLv(petCo.initAwakenLv, self._viewData.raceId)
				local proxy = MaterialMgr.setCell(MatType.Rare, cfg.raceId, self._rarePoint)

				proxy.binder:setRare(rare)
				GameUtil.SetActive(self._goBtnInfo, true)
			end
		else
			self._txtName.text = self._viewData.baseCfg.showTabNameA
		end

		if self._viewData.skinId ~= 0 then
			GameUtil.SetActive(self._btnPet_2, true)
		end

		self:_setViewEffect(true)
	end

	local bgPathList = {
		self._viewData.baseCfg.textureNameA,
		self._viewData.baseCfg.textureNameB
	}
	local bgPath = bgPathList[index]

	if not string.nilorempty(bgPath) then
		local path = "ui/bigbg/season/" .. bgPath

		self:_loadBigBg(self._pet, path, false)
	else
		self:_unLoadBigBg(self._pet)
	end

	if not self._viewData.baseCfg.showSkinIdList then
		local showSkinIdList = {}
		local skinId = checknumber(showSkinIdList[index])

		if skinId > 0 then
			if not self._viewData.baseCfg.rolePosLists then
				if not self._viewData.baseCfg.rolePosLists[index] then
					local pos = {}

					if not pos[3] then
						local x, y, scale = checknumber(pos[1]), checknumber(pos[2]), 1

						if not pos[4] then
							local scaleX = scale

							self:_loadRole(skinId, self._role, x, y, scale, scaleX)
						end
					end
				end
			end
		else
			self:_unLoadRole()
		end

		GameUtil.SetActive(self._petInfoTip, self._viewData.raceId ~= 0 and index == 1 or self._viewData.raceId == 0 and index == 2)
		self._changeTab_1:SetState(index == 1 and 1 or 0)
		self._changeTab_2:SetState(index == 2 and 1 or 0)
	end
end

function SeasonPassPortView:_refreshRedDot()
	goutil.setActive(self._btnFindRP, self._model:canFindEnergy())
	goutil.setActive(self._btnOneKeyRP, self._model:canReceiveOneKey())
	goutil.setActive(self._btnReceiveRP, self._model:canReceiveFinalReward())
end

function SeasonPassPortView:_setViewEffect(isShow)
	UIEffectManager.instance:stopEffect(self._viewEff)

	self._viewEff = nil

	if isShow then
		local effPath = "20221028/nizhanmiling/fx_ui_nizhanmiling.prefab"

		local function func(_, eff)
			eff:setParent(self._effect.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)
			eff:setClipping(self._viewRectTr)
		end

		self._viewEff = UIEffectManager.instance:playEffect(self, effPath, self._effect, 0, 0, true, false, nil, func, nil)
	end
end

function SeasonPassPortView:_loadRole(skinId, rootParent, x, y, scale, sclaeX)
	self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, skinId, rootParent, scale, nil, true, 0, 0)

	GameUtil.setLocalPos(rootParent, x, y)
	GameUtil.setLocalScale(rootParent, sclaeX, scale, scale)
end

function SeasonPassPortView:_unLoadRole()
	self._loader = RoleObjectPool.instance:removeRole(self._loader)
end

function SeasonPassPortView:_loadBigBg(bgGo, path, isSetNativeSize)
	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("%s.png", path)

		local function func()
			if isSetNativeSize then
				bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		self:_unLoadBigBg(bgGo)
	end
end

function SeasonPassPortView:_unLoadBigBg(bgGo)
	uGuiUtil.clearImage(bgGo)
end

function SeasonPassPortView:_onClickGetExtra(item)
	if self._viewData then
		if self._viewData.overflowEnergy >= self._viewData.baseCfg.lotteryEnergy then
			SeasonModeWarOrderController.instance:sendSeasonPassPortLuckDraw()
		else
			CommonTipsMgr.instance:openTipsByConfStr(item, self._viewData.baseCfg.lotteryPrize)
		end
	end
end

function SeasonPassPortView:_onClickRuleExtra()
	UIStateManager.instance:open(ViewName.RulesView, "seasonpassportextra_rule")
end

function SeasonPassPortView:_onClickFind()
	if self._viewData then
		local data = self._model:getSeasonFindEnergyPopViewData()

		if data then
			UIStateManager.instance:push(ViewName.SeasonFindEnergyPopView, data)
		end
	end
end

function SeasonPassPortView:_onClickBuyLevel()
	if self._viewData then
		if not GameUtil.checkTimeStr(self._viewData.baseCfg.sellTime) then
			local time = string.split(self._viewData.baseCfg.sellTime, "|")

			if time[2] then
				local onlyTime = string.split(time[2], ",")
				local startTime = GameUtil.string2date(onlyTime[1])

				FloatWordMgr.instance:show(langPara("%d.%d开启, 可花费神钻最多购买10级", startTime.month, startTime.day))
			else
				FloatWordMgr.instance:show("11.18开启, 可花费神钻最多购买10级")
			end

			return
		end

		local data = self._model:getSeasonPassBuyLevelPopViewData()

		if data then
			if data.useBuyLevel >= data.maxBuyLevel then
				FloatWordMgr.instance:show("已经达到最大购买等级次数, 无法再购买等级")
			elseif data.nowLevel >= data.maxLevel then
				FloatWordMgr.instance:show("已经达到最大等级, 无法再购买等级")
			else
				UIStateManager.instance:push(ViewName.SeasonPassBuyLevelPopView, data)
			end
		end
	end
end

function SeasonPassPortView:_onClickBuyPassport()
	if self._viewData then
		if self._viewData.hasPay then
			FloatWordMgr.instance:show("已经购买过进阶战令了")
		else
			local data = self._model:getSeasonPassPortBuyViewData()

			if data then
				UIStateManager.instance:push(ViewName.SeasonPassPortBuyView, data)
			end
		end
	end
end

function SeasonPassPortView:_onClickReceive()
	if self._viewData then
		if self._viewData.isKillBoss and self._viewData.nowUnlockLevel >= self._viewData.maxLevel then
			if not self._viewData.hasgainfinalprize then
				SeasonModeWarOrderController.instance:sendSeasonPassPortReceiveFinalPrize()
			else
				FloatWordMgr.instance:show("已经领取奖励了")
			end
		else
			FloatWordMgr.instance:show("条件未满足, 无法领取")
		end
	end
end

function SeasonPassPortView:_onClickPet_1()
	if self._nowSlectBgIndex == 1 then
		self:_changeShowTab(2)
	else
		self:_changeShowTab(1)
	end
end

function SeasonPassPortView:_onClickPet_2()
	if self._nowSlectBgIndex == 1 then
		self:_changeShowTab(2)
	else
		self:_changeShowTab(1)
	end
end

function SeasonPassPortView:PreventTooFastClick(isTips)
	if self._clickTimer == 0 then
		self._clickTimer = ServerTime.now()
	else
		local now = ServerTime.now()

		if now - self._clickTimer < 2 then
			return
		end

		self._clickTimer = now
	end

	return true
end

function SeasonPassPortView:_onClickSkillExplainBtn()
	if self._viewData then
		if not self:PreventTooFastClick(true) then
			return
		end

		if self._nowSlectBgIndex == 1 then
			if self._viewData.raceId == 0 then
				return
			end

			PetbookController.instance:previewBattle(self._viewData.raceId, nil)
		elseif self._viewData.raceId == 0 then
			local cfg = PetSkinConfig.instance:getPetSkinCfg(self._viewData.skinId)

			if cfg then
				PetbookController.instance:previewBattle(cfg.raceId, self._viewData.skinId)
			else
				return
			end
		else
			PetbookController.instance:previewBattle(self._viewData.raceId, self._viewData.skinId)
		end
	end
end

function SeasonPassPortView:_onClickOneKey()
	if self._model:canReceiveOneKey() then
		SeasonModeWarOrderController.instance:sendSeasonPassOneKeyGetReward()
	else
		FloatWordMgr.instance:show("当前无可领取奖励")
	end
end

function SeasonPassPortView:_onClickInfo()
	PetbookController.instance:openPetinfoView(self._viewData.raceId)
end

function SeasonPassPortView:_onLongPress(tar, isUp)
	self._bgChangeTime = 0
	self._isDown = not isUp
end

return SeasonPassPortView
