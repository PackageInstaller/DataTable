-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sharetask/view/ShareTaskView.lua

module("logic.extensions.sharetask.view.ShareTaskView", package.seeall)

local ShareTaskView = class("ShareTaskView", ViewComponent)

function ShareTaskView:ctor()
	ShareTaskView.super.ctor(self)

	self.bossCfg = nil
	self.otherBossId = nil
	self.isHungerTime = false
	self.goodsItemList = nil
end

function ShareTaskView:bindEvents()
	ShareTaskView.super.bindEvents(self)
	self.viewCloseBtn:AddClickListener(self.close, self)
	self.tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "sharetask")
	end, self)
	self.togetherBtn:AddClickListener(function()
		ShareTaskController.instance:CSGetAssistListReq()
	end, self)
	self.fightBtn:AddClickListener(function()
		if self.bossInfo.isFleeBoss then
			FloatWordMgr.instance:show("当前怪物结束！")

			return
		end

		if self.bossInfo.curHp <= 0 then
			FloatWordMgr.instance:show("怪物成功被驱逐！")

			return
		end

		if self.bossInfo.bossChallUse >= self.baseInfo.bossChallHave then
			FloatWordMgr.instance:show("该怪物没有挑战次数！")

			return
		end

		local data = {
			isMyBoss = true,
			isMainView = true,
			bossId = self.bossInfo.bossId,
			isParam = self.bossInfo.isChallenged
		}

		ShareTaskModel.instance:SetBattleBossInfo(data)
		UIStateManager.instance:push(ViewName.ShareMission)
	end, self)
	self.findBtn:AddClickListener(function()
		if self.bossInfo.isFindReward then
			FloatWordMgr.instance:show("当前怪物奖励已领取！")

			return
		end

		ShareTaskController.instance:CSGainDiscoveryRewardReq()
		self.findRedGo:SetActive(false)
		self.lingquGo:SetActive(true)

		if self.jiangliEff then
			UIEffectManager.instance:stopEffect(self.jiangliEff)

			self.jiangliEff = nil
		end
	end, self)
	self.lookBtn:AddClickListener(function()
		ShareTaskController.instance:CSGetOtherBossInfoReq(self.bossInfo.bossId)
	end, self)
	self.shareBtn:AddClickListener(function()
		if self.bossInfo.isFleeBoss then
			FloatWordMgr.instance:show("该怪物已逃离!")

			return
		end

		if self.bossInfo.isKillBoss then
			FloatWordMgr.instance:show("该怪物已被击败!")

			return
		end

		if self.bossInfo.isMaxChall then
			FloatWordMgr.instance:show("该怪物挑战已达上限!")

			return
		end

		UIStateManager.instance:push(ViewName.Share, GameEnum.ShareType.ShareBoss, self.bossInfo.bossId, self.bossInfo.bossTypeId)
	end, self)
	self._btnShareTask:AddClickListener(self._onClickBtnShareTask, self)
end

function ShareTaskView:unbindEvents()
	ShareTaskView.super.unbindEvents(self)
	self.viewCloseBtn:RemoveClickListener()
	self.tipsBtn:RemoveClickListener()
	self.togetherBtn:RemoveClickListener()
	self.fightBtn:RemoveClickListener()
	self.findBtn:RemoveClickListener()
	self.lookBtn:RemoveClickListener()
	self.shareBtn:RemoveClickListener()
	self._btnShareTask:RemoveClickListener()
end

function ShareTaskView:onExit()
	ShareTaskView.super.onExit(self)
	removetimer(self.CalculationSurplusTime, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataShareTaskBossInfo, self.UpdataViewData, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataShareTaskBossSetting, self._onUpdateSettingView, self)

	if self.taoliEff then
		UIEffectManager.instance:stopEffect(self.taoliEff)

		self.taoliEff = nil
	end

	if self.jiangliEff then
		UIEffectManager.instance:stopEffect(self.jiangliEff)

		self.jiangliEff = nil
	end

	if self.timerEff then
		UIEffectManager.instance:stopEffect(self.timerEff)

		self.timerEff = nil
	end
end

function ShareTaskView:destroyUI()
	ShareTaskView.super.destroyUI(self)
	self.petPhoto:clear()

	for _, item in pairs(self.goodsItemList or {}) do
		if item and item.itemGo then
			MaterialMgr.resetAll(item.itemGo)
		end
	end

	self.goodsItemList = nil
	self.isHungerTime = false
end

function ShareTaskView:buildUI()
	ShareTaskView.super.buildUI(self)

	self.viewCloseBtn = self:getBtn("viewCloseBtn")
	self.tipsBtn = self:getBtn("tipsBtn")

	local monsterInfoGo = self:getGo("monsterInfoGo")
	local spriteRawGo = goutil.findChild(monsterInfoGo, "spriteRawIma")

	self.petPhoto = PetPhotoShow.Get(spriteRawGo)
	self.bloodBarSli = goutil.findChild(monsterInfoGo, "bloodBarSli"):GetComponent("Slider")
	self.bloodValueTxt = goutil.findChildTextComponent(monsterInfoGo, "bloodValueTxt")
	self.triggCountTxt = goutil.findChildTextComponent(monsterInfoGo, "triggCountTxt")
	self.bossStageIma = goutil.findChild(monsterInfoGo, "stageIma"):GetComponent("UIImageSpriteChange")
	self.bossNameTxt = goutil.findChildTextComponent(monsterInfoGo, "bossNameTxt")
	self.bossLevelTxt = goutil.findChildTextComponent(monsterInfoGo, "bossLevelTxt")
	self.lookBtn = Framework.ButtonAdapter.GetFrom(monsterInfoGo, "lookBtn")
	self.shareBtn = Framework.ButtonAdapter.GetFrom(monsterInfoGo, "shareBtn")
	self.haveMonsterGo = self:getGo("haveMonsterGo")
	self.titleShowIma = goutil.findChild(self.haveMonsterGo, "titleShowIma"):GetComponent("UIImageSpriteChange")
	self.runTimeGo = goutil.findChild(self.haveMonsterGo, "runTimeGo")
	self.runTimeTxt = goutil.findChildTextComponent(self.runTimeGo, "runTimeTxt")
	self.commonGo = goutil.findChild(self.haveMonsterGo, "commonGo")
	self.hungerGo = goutil.findChild(self.haveMonsterGo, "hungerGo")
	self.hungerTime1 = goutil.findChildTextComponent(self.hungerGo, "hungerTime1")
	self.hungerTime2 = goutil.findChildTextComponent(self.hungerGo, "hungerTime2")
	self.findGoodsGo = goutil.findChild(self.haveMonsterGo, "findGoodsGo")
	self.findBtn = Framework.ButtonAdapter.GetFrom(self.findGoodsGo, "findBtn")
	self.findRedGo = goutil.findChild(self.findGoodsGo, "findBtn/findRedGo")
	self.lingquGo = goutil.findChild(self.findGoodsGo, "lingquGo")
	self.bossNameTxt.text = ""
	self.bossLevelTxt.text = ""
	self.runTimeTxt.text = ""
	self.hungerTime1.text = ""
	self.hungerTime2.text = ""
	self.bloodBarSli.value = 0
	self.bloodValueTxt.text = ""
	self.triggCountTxt.text = ""

	self.commonGo:SetActive(false)
	self.hungerGo:SetActive(false)
	GameUtil.SetActive(self.bossStageIma, false)
	self.findRedGo:SetActive(false)
	self.lingquGo:SetActive(false)

	self.monsterRunGo = self:getGo("monsterRunGo")

	self.monsterRunGo:SetActive(false)

	self.downGoodsGo = self:getGo("downGoodsGo")
	self.allPeopleTxt = goutil.findChildTextComponent(self.downGoodsGo, "allPeopleTxt")
	self.allTimeTxt = goutil.findChildTextComponent(self.downGoodsGo, "allTimeTxt")
	self.diaoluoSR = goutil.findChild(self.downGoodsGo, "diaoluoSR"):GetComponent("UITableview")
	self.jibaiSR = goutil.findChild(self.downGoodsGo, "jibaiSR"):GetComponent("UITableview")
	self.goodsItem = self:getGo("goodsItem")

	self.goodsItem:SetActive(false)

	self.allPeopleTxt.text = ""
	self.allTimeTxt.text = ""
	self.togetherBtn = self:getBtn("togetherBtn")
	self.togetherRedGo = self:getGo("togetherBtn/togetherRedGo")
	self.fightBtn = self:getBtn("fightBtn")
	self.fightCountTxt = goutil.findChildTextComponent(self.mainGO, "fightBtn/fightCountTxt")
	self.fightCountTxt.text = ""

	self.togetherRedGo:SetActive(false)

	self._btnShareTask = self:getBtn("setting/toggle")
	self._shareTaskCheckBox = goutil.findChild(self._btnShareTask.gameObject, "checkbox")

	self.diaoluoSR:RegisterCallback(self.GetDiaoluoCount, self.GetItemSize, self.GetDiaoluoItemAtIndex, self)
	self.jibaiSR:RegisterCallback(self.GetJibaiCount, self.GetItemSize, self.GetJibaiItemAtIndex, self)
end

function ShareTaskView:GetDiaoluoCount()
	if not self.diaoluoDatas then
		return 0
	end

	return #self.diaoluoDatas
end

function ShareTaskView:GetJibaiCount()
	if not self.jibaiDatas then
		return 0
	end

	return #self.jibaiDatas
end

function ShareTaskView:GetItemSize()
	return 90, 90
end

function ShareTaskView:GetDiaoluoItemAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self.goodsItem)

	local data = self.diaoluoDatas[index + 1]

	cell.data = index + 1
	cell.index = index

	self:UpdataDiaoluoItem(view, cell, data)

	return cell
end

function ShareTaskView:GetJibaiItemAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self.goodsItem)

	local data = self.jibaiDatas[index + 1]

	cell.data = index + 1
	cell.index = index

	self:UpdataJibaiItem(view, cell, data)

	return cell
end

function ShareTaskView:UpdataDiaoluoItem(view, cell, data)
	local itemPos = goutil.findChild(cell, "itemPos")
	local stageIma = goutil.findChild(cell, "stageIma"):GetComponent("Image")
	local stageTxt = goutil.findChildTextComponent(cell, "stageTxt")

	MaterialMgr.resetAll(itemPos)

	local proxy = MaterialMgr.setCell(data.itemType, data.itemId, itemPos)

	proxy.binder:setNum(data.count)

	if self.bossInfo.isChallenged then
		GameUtil.SetActive(stageIma, true)
		Framework.ColorUtil.SetImageColor(stageIma, "#F25A25FF")

		stageTxt.text = "<color=#FFFFFFFF>已发放</color>"

		proxy.binder:setGray(false)
	elseif self.bossInfo.isFleeBoss then
		GameUtil.SetActive(stageIma, true)
		Framework.ColorUtil.SetImageColor(stageIma, "#FFFFFFFF")

		stageTxt.text = "<color=#3F3F3FFF>未获得</color>"

		proxy.binder:setGray(true)
	else
		GameUtil.SetActive(stageIma, false)

		stageTxt.text = ""

		proxy.binder:setGray(false)
	end
end

function ShareTaskView:UpdataJibaiItem(view, cell, data)
	local itemPos = goutil.findChild(cell, "itemPos")
	local stageIma = goutil.findChild(cell, "stageIma"):GetComponent("Image")
	local stageTxt = goutil.findChildTextComponent(cell, "stageTxt")

	MaterialMgr.resetAll(itemPos)

	local proxy = MaterialMgr.setCell(data.itemType, data.itemId, itemPos)

	proxy.binder:setNum(data.count)

	if self.bossInfo.isFleeBoss then
		GameUtil.SetActive(stageIma, true)
		Framework.ColorUtil.SetImageColor(stageIma, "#FFFFFFFF")

		stageTxt.text = "<color=#3F3F3FFF>未获得</color>"

		proxy.binder:setGray(true)
	elseif self.bossInfo.isKillBoss then
		GameUtil.SetActive(stageIma, true)
		Framework.ColorUtil.SetImageColor(stageIma, "#F25A25FF")

		stageTxt.text = "<color=#FFFFFFFF>已发放</color>"

		proxy.binder:setGray(false)
	else
		GameUtil.SetActive(stageIma, false)

		stageTxt.text = ""

		proxy.binder:setGray(false)
	end
end

function ShareTaskView:onEnter()
	ShareTaskView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataShareTaskBossInfo, self.UpdataViewData, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataShareTaskBossSetting, self._onUpdateSettingView, self)

	local can = self.findGoodsGo:GetComponent("Canvas")
	local canvas = UGUIToolHelper.FindCanvas(self.mainGO)

	can.sortingOrder = canvas.sortingOrder + 3

	self.petPhoto:clear()

	for _, item in pairs(self.goodsItemList or {}) do
		if item and item.itemGo then
			MaterialMgr.resetAll(item.itemGo)
		end
	end

	self.goodsItemList = self.goodsItemList or {}

	self.togetherRedGo:SetActive(false)

	self.bossInfo = ShareTaskModel.instance:GetMyShareBossInfo()

	if self.bossInfo == nil or not self.bossInfo.isHaveBoss then
		printError("sr-- ShareTaskView:onEnter()    Boss数据 没有Boss信息，按道理说不可能打开这个界面的")

		return
	end

	self:_onUpdateSettingView()
	self:UpdataViewData()

	if self.bossInfo.isFleeBoss or self.bossInfo.isKillBoss then
		return
	end

	ShareTaskController.instance:CSGetMyBossInfoReq()
	ShareTaskController.instance:sendShareTaskStopTriggerInfoReq()
end

function ShareTaskView:_onClickBtnShareTask()
	local flag = ShareTaskController.instance.isStopTrigger

	ShareTaskController.instance:sendGetShareTaskSetting(not flag)
end

function ShareTaskView:_onUpdateSettingView()
	local flag = ShareTaskController.instance.isStopTrigger

	goutil.setActive(self._shareTaskCheckBox, flag)
end

function ShareTaskView:UpdataViewData()
	self.bossInfo = ShareTaskModel.instance:GetMyShareBossInfo()
	self.baseInfo = ShareTaskModel.instance:GetShareTaskBaseInfo()
	self.bossCfg = ShareTaskConfig.instance:GetBossBaseCfg(self.bossInfo.bossTypeId)

	if self.bossCfg == nil then
		printError("sr-- ShareTaskView:UpdataViewData()    Boss配置空 bossTypeId = ", self.bossInfo.bossTypeId)

		return
	end

	self.triggCountTxt.text = self.baseInfo.trigUse > self.baseInfo.trigHave and string.format("触发任务且已挑战次数：%s/%s", self.baseInfo.trigHave, self.baseInfo.trigHave) or string.format("触发任务且已挑战次数：%s/%s", self.baseInfo.trigUse, self.baseInfo.trigHave)
	self.bloodValueTxt.text = self.bossInfo.curHp .. "/" .. self.bossInfo.maxHp
	self.bloodBarSli.value = self.bossInfo.curHp / self.bossInfo.maxHp
	self.bossNameTxt.text = self.bossCfg.name
	self.bossLevelTxt.text = "Lv." .. self.bossCfg.monsterLevel

	local cfg = CharacterConfig.instance:getModelCo(self.bossCfg.monsterId)
	local showLihui = cfg and not string.nilorempty(cfg.bustName)

	self.petPhoto:showPetEffect(self.bossCfg.monsterId, showLihui, self.bossCfg.modelSize)
	self:ShowHaveBossView()

	self.fightCountTxt.text = string.format("剩余挑战：%s/%s", self.baseInfo.bossChallHave - self.bossInfo.bossChallUse, self.baseInfo.bossChallHave)

	if self.bossInfo.bossChallUse >= self.baseInfo.bossChallHave then
		uGuiUtil.setImageGrayStateRecursive(self.fightBtn.gameObject, true)
		uGuiUtil.setTextGrayState(self.fightCountTxt.gameObject, true)
	else
		uGuiUtil.setImageGrayStateRecursive(self.fightBtn.gameObject, false)
		uGuiUtil.setTextGrayState(self.fightCountTxt.gameObject, false)
	end

	self.allPeopleTxt.text = self.bossCfg.memberLimit .. "人次"

	local allTime = ShareTaskConfig.instance:GetBossShowTime()

	self.allTimeTxt.text = allTime / 60 .. "分钟"

	self.togetherRedGo:SetActive(self.baseInfo.helpHave > self.baseInfo.helpUse)
	self:ShowViewAllGoods()
end

function ShareTaskView:ShowHaveBossView()
	removetimer(self.CalculationSurplusTime, self)

	local effPath = "fx_ui_guaiwulaixi/%s.prefab"
	local stageNum = ShareTaskModel.instance:GetMyBossChallengeStage()

	if stageNum < 0 then
		GameUtil.SetActive(self.bossStageIma, false)
	else
		GameUtil.SetActive(self.bossStageIma, true)
		self.bossStageIma:SetState(stageNum)
	end

	if self.bossInfo.isFleeBoss or self.bossInfo.isKillBoss then
		if self.jiangliEff then
			UIEffectManager.instance:stopEffect(self.jiangliEff)

			self.jiangliEff = nil
		end

		if self.timerEff then
			UIEffectManager.instance:stopEffect(self.timerEff)

			self.timerEff = nil
		end

		self.haveMonsterGo:SetActive(false)
		GameUtil.SetActive(self.shareBtn, false)
		self.monsterRunGo:SetActive(true)

		if self.taoliEff == nil then
			self.taoliEff = UIEffectManager.instance:playEffect(self, string.format(effPath, "fx_ui_guaiwulaixi_wenzi"), self.monsterRunGo, 0, 0, true, nil, nil, nil, self)

			self.taoliEff:setParent(self.monsterRunGo.transform)
			self.taoliEff:setLocalPos(0, 120, 0)
			self.taoliEff:setScale(1)
		end

		return
	end

	GameUtil.SetActive(self.shareBtn, self.bossInfo.isChallenged)

	self.isHungerTime = false

	self.monsterRunGo:SetActive(false)
	self.haveMonsterGo:SetActive(true)

	if self.taoliEff then
		UIEffectManager.instance:stopEffect(self.taoliEff)

		self.taoliEff = nil
	end

	if not self.bossInfo.isFindReward then
		self.findRedGo:SetActive(true)
		self.lingquGo:SetActive(false)

		if self.jiangliEff == nil then
			self.jiangliEff = UIEffectManager.instance:playEffect(self, string.format(effPath, "fx_ui_guaiwulaixi_baoxiang"), self.findGoodsGo, 0, 0, true, nil, nil, nil, self)

			self.jiangliEff:setParent(self.findGoodsGo.transform)
			self.jiangliEff:setLocalPos(0, 0, 0)
			self.jiangliEff:setScale(1)
		end
	else
		self.findRedGo:SetActive(false)
		self.lingquGo:SetActive(true)
	end

	if self.timerEff == nil then
		self.timerEff = UIEffectManager.instance:playEffect(self, string.format(effPath, "fx_ui_guaiwulaixi_guaiwutaoli"), self.runTimeGo, 0, 0, true, nil, nil, nil, self)

		self.timerEff:setParent(self.runTimeGo.transform)
		self.timerEff:setLocalPos(0, 2.5, 0)
		self.timerEff:setScale(1)
	end

	self.isHungerTime = self:GetIsHungerTime()

	if self.isHungerTime then
		self.commonGo:SetActive(false)
		self.hungerGo:SetActive(true)
		self.titleShowIma:SetState(1)
		Framework.TransformUtil.SetLocalPos(self.runTimeGo.transform, 0, 60, 0)

		local timeList = ShareTaskConfig.instance:GetBossSpecialTimeList()

		if timeList and timeList[1] then
			if not self.hungerTime1.gameObject.activeSelf then
				self.hungerTime1.gameObject:SetActive(true)
			end

			self.hungerTime1.text = timeList[1].startTime .. "-" .. timeList[1].endTime

			if timeList[2] then
				if not self.hungerTime2.gameObject.activeSelf then
					self.hungerTime2.gameObject:SetActive(true)
				end

				self.hungerTime2.text = timeList[2].startTime .. "-" .. timeList[2].endTime
			else
				self.hungerTime2.gameObject:SetActive(false)
			end
		else
			self.hungerTime1.gameObject:SetActive(false)
		end
	else
		self.hungerGo:SetActive(false)
		self.commonGo:SetActive(true)
		self.titleShowIma:SetState(0)
		Framework.TransformUtil.SetLocalPos(self.runTimeGo.transform, 0, 95, 0)
	end

	local allTime = ShareTaskConfig.instance:GetBossShowTime()

	self.surplusTime = math.ceil(self.bossInfo.startTime / 1000 + allTime - checknumber(ServerTime.now()))

	if self.surplusTime <= 0 then
		self.runTimeTxt.text = "此怪物已结束"

		return
	end

	self:ShowSurplusTime()
	settimer(1, self.CalculationSurplusTime, self, true)
end

function ShareTaskView:ShowViewAllGoods()
	self.diaoluoDatas = ShareTaskModel.instance:ParsingGoodsStr(self.bossCfg.fallReward) or {}

	self.diaoluoSR:ReloadData()

	self.jibaiDatas = ShareTaskModel.instance:ParsingGoodsStr(self.bossCfg.defeatReward) or {}

	self.jibaiSR:ReloadData()

	local mvpList = ShareTaskModel.instance:ParsingGoodsStr(self.bossCfg.MVPReward)

	if mvpList == nil or #mvpList == 0 then
		return
	end

	local isMvpStage = ShareTaskModel.instance:GetBattleBossMVP()

	for i = 1, #mvpList do
		if self.goodsItemList[i] == nil then
			local go = UnityEngine.GameObject.Instantiate(self.goodsItem, self.downGoodsGo.transform)
			local var_25_0 = {
				itemGo = go,
				itemPos = goutil.findChild(go, "itemPos")
			}

			var_25_0.stageIma = goutil.findChild(go, "stageIma"):GetComponent("Image")
			var_25_0.stageTxt = goutil.findChildTextComponent(go, "stageTxt")
			self.goodsItemList[i] = var_25_0

			self.goodsItemList[i].itemGo:SetActive(true)
		end

		MaterialMgr.resetAll(self.goodsItemList[i].itemPos)
		Framework.TransformUtil.SetLocalPos(self.goodsItemList[i].itemGo.transform, 430 + (i - 1) * 100, -20, 0)

		local proxy = MaterialMgr.setCell(mvpList[i].itemType, mvpList[i].itemId, self.goodsItemList[i].itemPos)

		proxy.binder:setNum(mvpList[i].count)

		if isMvpStage == 2 then
			GameUtil.SetActive(self.goodsItemList[i].stageIma, true)
			Framework.ColorUtil.SetImageColor(self.goodsItemList[i].stageIma, "#FFFFFFFF")

			self.goodsItemList[i].stageTxt.text = "<color=#3F3F3FFF>未获得</color>"

			proxy.binder:setGray(true)
		elseif isMvpStage == 1 then
			GameUtil.SetActive(self.goodsItemList[i].stageIma, true)
			Framework.ColorUtil.SetImageColor(self.goodsItemList[i].stageIma, "#F25A25FF")

			self.goodsItemList[i].stageTxt.text = "<color=#FFFFFFFF>已发放</color>"

			proxy.binder:setGray(false)
		else
			GameUtil.SetActive(self.goodsItemList[i].stageIma, false)

			self.goodsItemList[i].stageTxt.text = ""

			proxy.binder:setGray(false)
		end
	end

	mvpList = nil
end

function ShareTaskView:CalculationSurplusTime()
	self.surplusTime = self.surplusTime - 1

	if self.surplusTime == 0 then
		self.runTimeTxt.text = "此怪物已结束"

		FloatWordMgr.instance:show("暗瘾来袭活动结束！")
	end

	if self.surplusTime < 0 then
		removetimer(self.CalculationSurplusTime, self)

		self.runTimeTxt.text = "此怪物已结束"

		self:UpdataViewData()

		return
	end

	self:ShowSurplusTime()

	local hunger = self:GetIsHungerTime()

	if self.isHungerTime ~= hunger then
		self.isHungerTime = hunger

		self:UpdataViewData()
	end
end

function ShareTaskView:ShowSurplusTime()
	local hour = math.floor(self.surplusTime / 3600)
	local min = math.floor((self.surplusTime - hour * 3600) / 60)
	local sec = self.surplusTime - hour * 3600 - min * 60

	self.runTimeTxt.text = hour > 0 and string.format("剩余时间 %s时%s分", hour, min) or string.format("剩余时间 %s分%s秒", min, sec)
end

function ShareTaskView:GetIsHungerTime()
	if self.bossInfo.isFleeBoss or self.bossInfo.isKillBoss then
		return false
	end

	local timeList = ShareTaskConfig.instance:GetBossSpecialTimeList()

	if timeList == nil or #timeList == 0 then
		return false
	end

	local serverTime = ServerTime.nowDate()

	for i = 1, #timeList do
		local startTime = string.format("%s-%s-%sT%s", serverTime.year, serverTime.month, serverTime.day, timeList[i].startTime)
		local endTime = string.format("%s-%s-%sT%s", serverTime.year, serverTime.month, serverTime.day, timeList[i].endTime)
		local isXX = GameUtil.checkIsInTimePeriod(startTime, endTime)

		if isXX then
			return true
		end
	end

	return false
end

return ShareTaskView
