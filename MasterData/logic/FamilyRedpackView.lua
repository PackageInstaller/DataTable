-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyRedpackView.lua

module("logic.extensions.family.view.FamilyRedpackView", package.seeall)

local FamilyRedpackView = class("FamilyRedpackView", ViewComponent)

function FamilyRedpackView:ctor()
	FamilyRedpackView.super.ctor(self)

	self._tabItemList = nil
	self._curTabIndex = nil
	self._curFamilyDatas = nil
	self._curOwnDatas = nil
	self._curRedpackId = nil
end

function FamilyRedpackView:bindEvents()
	FamilyRedpackView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "familyredpack")
	end, self)
	self._recordBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.FamilyRedpackRecord)
	end, self)

	if self._tabItemList[1] and self._tabItemList[1].itemGo then
		GameUtil.asBtn(self._tabItemList[1].itemGo):AddClickListener(function()
			self:_onClickRedpackTabBtn(FamilyController.RedpackTab.FamilyTab)
		end, self)
	end

	if self._tabItemList[2] and self._tabItemList[2].itemGo then
		GameUtil.asBtn(self._tabItemList[2].itemGo):AddClickListener(function()
			self:_onClickRedpackTabBtn(FamilyController.RedpackTab.TaskTab)
		end, self)
	end
end

function FamilyRedpackView:unbindEvents()
	FamilyRedpackView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._recordBtn:RemoveClickListener()

	for _, item in pairs(self._tabItemList or {}) do
		if item and item.itemGo then
			GameUtil.asBtn(item.itemGo):RemoveClickListener()
		end
	end
end

function FamilyRedpackView:buildUI()
	FamilyRedpackView.super.buildUI(self)

	self._closeBtn = self:getBtn("topInfoGo/closeBtn")
	self._tipsBtn = self:getBtn("topInfoGo/tipsBtn")
	self._goldBarCon = self:getGo("goldBarCon")

	local tabGroupTran = self:getGo("tabGroupTran").transform

	self._tabItemList = {}

	for i = 1, tabGroupTran.childCount do
		local go = tabGroupTran:GetChild(i - 1).gameObject
		local names = string.split(go.name, "_")

		self._tabItemList[tonumber(names[2])] = {
			itemGo = go,
			itemUIcg = go:GetComponent("UIChangeGroup"),
			itemTxt = goutil.findChildTextComponent(go, "nameTxt"),
			btnRedGo = goutil.findChild(go, "btnRedGo"),
			tagGo = goutil.findChild(go, "tagGo"),
			tagTxt = goutil.findChildTextComponent(go, "tagGo/tagTxt")
		}
	end

	self._familyItemSR = self:getGo("familyItemSR"):GetComponent("UITableview")
	self._familyItem = self:getGo("familyItem")

	self._familyItem:SetActive(false)

	self._ownItemSR = self:getGo("ownItemSR"):GetComponent("UITableview")
	self._ownItem = self:getGo("ownItem")

	self._ownItem:SetActive(false)

	self._emptyGo = self:getGo("emptyGo")
	self._emptyTxt = goutil.findChildTextComponent(self._emptyGo, "emptyTxt")
	self._srDescTxt = self:getTxt("srDescTxt")
	self._recordBtn = self:getBtn("recordBtn")
	self._redPointGo = self:getGo("recordBtn/redPointGo")

	GameUtil.SetActive(self._emptyGo, false)
	self._familyItemSR:RegisterCallback(self._familyInView, function()
		return 242, 356
	end, self._familyAtIndex, self)
	self._familyItemSR:RegisterUpdateCellCallback(self._onFamilyCellUpdate)
	self._ownItemSR:RegisterCallback(self._ownInView, function()
		return 90, 90
	end, self._ownAtIndex, self)
	self._ownItemSR:RegisterUpdateCellCallback(self._onOwnCellUpdate)
end

function FamilyRedpackView:_familyInView()
	if not self._curFamilyDatas then
		return 0
	end

	return #self._curFamilyDatas
end

function FamilyRedpackView:_familyAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._familyItem)

	local data = self._curFamilyDatas[index + 1]

	cell.data = index + 1
	cell.index = index

	self:_updateFamilyCell(view, cell, data)

	return cell
end

function FamilyRedpackView:_onFamilyCellUpdate(view, cell)
	local index = cell.index
	local data = self._curFamilyDatas[index + 1]

	cell.data = index + 1

	self:_updateFamilyCell(view, cell, data)
end

function FamilyRedpackView:_ownInView()
	if not self._curOwnDatas then
		return 0
	end

	return #self._curOwnDatas
end

function FamilyRedpackView:_ownAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._ownItem)

	local data = self._curOwnDatas[index + 1]

	cell.data = index + 1
	cell.index = index

	self:_updateOwnCell(view, cell, data)

	return cell
end

function FamilyRedpackView:_onOwnCellUpdate(view, cell)
	local index = cell.index
	local data = self._curOwnDatas[index + 1]

	cell.data = index + 1

	self:_updateOwnCell(view, cell, data)
end

function FamilyRedpackView:onExit()
	FamilyRedpackView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.Family_UpdataTaskRedpackInfo, self._updataTaskInfoShow, self)
	GlobalDispatcher:removeListener(GlobalNotify.Family_UpdataFamilyRedpackInfo, self._updataFamilyInfoShow, self)
	GlobalDispatcher:removeListener(GlobalNotify.Family_GainFamilyRedpackInfo, self._updataFamilyInfoShow, self)
	GlobalDispatcher:removeListener(GlobalNotify.Family_SetFamilyRedpackId, self._setFamilyRedpackId, self)
	GlobalDispatcher:removeListener(GlobalNotify.RedPointUpdate, self._updateRedPoint, self)

	if self._mainEff then
		UIEffectManager.instance:stopEffect(self._mainEff)
	end

	self._mainEff = nil
	self._curTabIndex = nil
	self._curFamilyDatas = nil
	self._curOwnDatas = nil
	self._curRedpackId = nil
end

function FamilyRedpackView:destroyUI()
	FamilyRedpackView.super.destroyUI(self)

	self._tabItemList = nil
end

function FamilyRedpackView:onEnter()
	FamilyRedpackView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.Family_UpdataTaskRedpackInfo, self._updataTaskInfoShow, self)
	GlobalDispatcher:addListener(GlobalNotify.Family_UpdataFamilyRedpackInfo, self._updataFamilyInfoShow, self)
	GlobalDispatcher:addListener(GlobalNotify.Family_GainFamilyRedpackInfo, self._updataFamilyInfoShow, self)
	GlobalDispatcher:addListener(GlobalNotify.Family_SetFamilyRedpackId, self._setFamilyRedpackId, self)
	GlobalDispatcher:addListener(GlobalNotify.RedPointUpdate, self._updateRedPoint, self)

	self._curTabIndex = FamilyController.instance:getRedpackViewTab()

	local openParam = self:getOpenParam()

	if openParam and checknumber(openParam[1]) > 1 then
		self._curTabIndex = checknumber(openParam[1])
	end

	if openParam then
		self:_setFamilyRedpackId(openParam[2])
	end

	self:_initViewShow()

	self._needGX = FamilyConfig.instance:getRedpackCommonValue("USER_CONTRIBUTION_LIMIT", true)

	FamilyController.instance:csGetFamilyRedPacketGetTaskInfoReq()
end

function FamilyRedpackView:_initViewShow()
	self._srDescTxt.text = lang("text_family_desc_4")

	GameUtil.SetActive(self._emptyGo, true)

	self._emptyTxt.text = ""

	GameUtil.SetActive(self._redPointGo, false)
	GameUtil.SetActive(self._familyItemSR, false)
	GameUtil.SetActive(self._ownItemSR, false)

	self._mainEff = UIEffectManager.instance:playEffect(self, "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab", self.mainGO, 0, 0, true, false, nil, self._onLoadFinished, self)

	local btnsList = {
		{
			showAdd = false,
			id = GameEnum.GoldType.FamilyCoin
		},
		{
			showAdd = false,
			id = GameEnum.GoldType.Diamond
		},
		{
			showAdd = false,
			id = GameEnum.GoldType.Coin
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btnsList)
end

function FamilyRedpackView:_updataTaskInfoShow()
	self:_onClickRedpackTabBtn(self._curTabIndex, true)
	self:_updateRedPoint()
end

function FamilyRedpackView:_setFamilyRedpackId(redpackId)
	if checknumber(self._curRedpackId) <= 0 or checknumber(redpackId) > 0 then
		self._curRedpackId = checknumber(redpackId)
	end
end

function FamilyRedpackView:_updataFamilyInfoShow()
	self:_updataItemListSR(FamilyController.RedpackTab.FamilyTab)
end

function FamilyRedpackView:_updateRedPoint()
	local isRed = RedPointModel.instance:isActive(423)

	GameUtil.SetActive(self._tabItemList[FamilyController.RedpackTab.FamilyTab].btnRedGo, isRed)

	isRed = RedPointModel.instance:isActive(405)

	GameUtil.SetActive(self._tabItemList[FamilyController.RedpackTab.TaskTab].btnRedGo, isRed)
end

function FamilyRedpackView:_onClickRedpackTabBtn(index, isForce)
	if self._curTabIndex == index and not isForce then
		return
	end

	if index == FamilyController.RedpackTab.FamilyTab then
		FamilyController.instance:csGetFamilyRedPacketGetListReq()
	else
		self:_updataItemListSR(index)
	end
end

function FamilyRedpackView:_updataItemListSR(index)
	self._curTabIndex = index

	local redId
	local redpackData = FamilyModel.instance:getFaimlyRedpackData()
	local familyInfo = FamilyModel.instance:getMyFamilyInfo()

	if familyInfo then
		self._haveGX = familyInfo.totalContribution or 0
	end

	if self._curTabIndex == FamilyController.RedpackTab.FamilyTab then
		redId = 423

		self._tabItemList[FamilyController.RedpackTab.FamilyTab].itemUIcg:SetState(1)
		self._tabItemList[FamilyController.RedpackTab.TaskTab].itemUIcg:SetState(0)
		GameUtil.SetActive(self._ownItemSR, false)
		GameUtil.SetActive(self._familyItemSR, true)

		self._curFamilyDatas = redpackData.redList or {}
		self._redTimes = redpackData.redTimes or {}

		if #self._curFamilyDatas == 0 then
			GameUtil.SetActive(self._emptyGo, true)

			self._emptyTxt.text = lang("text_family_desc_4")
		else
			GameUtil.SetActive(self._emptyGo, false)
		end

		if #self._curFamilyDatas > 1 then
			local isLimitTable = self:_getRedPackGainLimit(redpackData)

			table.sort(self._curFamilyDatas, function(a, b)
				local n1 = a.canGain and not isLimitTable[a.packetType] and 1 or 0
				local n2 = b.canGain and not isLimitTable[b.packetType] and 1 or 0

				if n1 == n2 then
					local dataA = FamilyConfig.instance:getRedpackTypeCfg(a.packetType)
					local dataB = FamilyConfig.instance:getRedpackTypeCfg(b.packetType)

					if dataA then
						if not dataA.num then
							local k1 = 0

							if dataB then
								if not dataB.num then
									local k2 = 0

									if k1 == k2 then
										return a.expire < b.expire
									end

									return k2 < k1
								end
							end
						end
					end
				end

				return n2 < n1
			end)
		end

		self._srDescTxt.text = langPara("text_family_desc_5", self._needGX, FamilyModel.instance:getCurrentRedpackCount())

		self._familyItemSR:ReloadData()

		local redInfo = self:_getRedpackListHaveInfo()

		if redInfo then
			UIStateManager.instance:push(ViewName.FamilyRedpackPopup, redInfo.packetId)
		end
	elseif self._curTabIndex == FamilyController.RedpackTab.TaskTab then
		redId = 405
		self._curTabIndex = nil

		self._tabItemList[FamilyController.RedpackTab.FamilyTab].itemUIcg:SetState(0)
		self._tabItemList[FamilyController.RedpackTab.TaskTab].itemUIcg:SetState(1)
		GameUtil.SetActive(self._familyItemSR, false)
		GameUtil.SetActive(self._ownItemSR, true)

		local count = 0

		self._curOwnDatas, count = FamilyModel.instance:getOpenRedpackTaskCfgs()

		if #self._curOwnDatas == 0 then
			GameUtil.SetActive(self._emptyGo, true)

			self._emptyTxt.text = lang("text_family_desc_6")
		else
			GameUtil.SetActive(self._emptyGo, false)
		end

		self._srDescTxt.text = langPara("text_family_desc_7", self._needGX, count)

		self._ownItemSR:ReloadData()
	end

	FamilyController.instance:setRedpackViewTab(self._curTabIndex)

	if self._tabItemList[self._curTabIndex] and redId then
		GameUtil.SetActive(self._tabItemList[self._curTabIndex].btnRedGo, RedPointModel.instance:isActive(redId))
	end

	self._curRedpackId = nil
end

function FamilyRedpackView:_getRedpackListHaveInfo()
	if self._curFamilyDatas == nil or #self._curFamilyDatas == 0 then
		return nil
	end

	if checknumber(self._curRedpackId) <= 0 then
		return nil
	end

	for i = 1, #self._curFamilyDatas do
		if self._curFamilyDatas[i] and checknumber(self._curFamilyDatas[i].packetId) == self._curRedpackId then
			return self._curFamilyDatas[i]
		end
	end

	return nil
end

function FamilyRedpackView:_updateFamilyCell(view, cell, data)
	local messageGo = goutil.findChild(cell, "messageGo")
	local messageIsc = messageGo:GetComponent("UIImageSpriteChange")
	local mHeadGo = goutil.findChild(messageGo, "headGo")
	local mNameTxt = goutil.findChildTextComponent(messageGo, "nameGo/nameTxt")
	local mGetIconGo = goutil.findChild(messageGo, "getGo/getIconGo")
	local mGetTxt = goutil.findChildTextComponent(messageGo, "getGo/getTxt")
	local unopenGo = goutil.findChild(cell, "unopenGo")
	local unopenIsc = unopenGo:GetComponent("UIImageSpriteChange")
	local uHeadGo = goutil.findChild(unopenGo, "headGo")
	local uNameTxt = goutil.findChildTextComponent(unopenGo, "nameGo/nameTxt")
	local uGetIconGo = goutil.findChild(unopenGo, "getGo/getIconGo")
	local uGetTxt = goutil.findChildTextComponent(unopenGo, "getGo/getTxt")

	GameUtil.asBtn(cell):RemoveClickListener()
	MaterialMgr.resetAll(mHeadGo)
	MaterialMgr.resetAll(uHeadGo)
	MaterialMgr.resetAll(mGetIconGo)
	MaterialMgr.resetAll(uGetIconGo)

	local typeCfg = FamilyConfig.instance:getRedpackTypeCfg(data.packetType)

	if not data.canGain then
		GameUtil.SetActive(unopenGo, false)
		GameUtil.SetActive(messageGo, true)
		messageIsc:SetState(data.packetType - 1)
		HeadItemController.instance:setHeadCellByInfo(mHeadGo, data.headInfo)

		mNameTxt.text = data.headInfo.userName

		MaterialMgr.updateItemByStr(mGetIconGo, typeCfg.prize)

		mGetTxt.text = tostring(typeCfg.num)
	else
		GameUtil.SetActive(messageGo, false)
		GameUtil.SetActive(unopenGo, true)
		unopenIsc:SetState(data.packetType - 1)
		HeadItemController.instance:setHeadCellByInfo(uHeadGo, data.headInfo)

		uNameTxt.text = data.headInfo.userName

		MaterialMgr.updateItemByStr(uGetIconGo, typeCfg.prize)

		uGetTxt.text = tostring(typeCfg.num)
	end

	GameUtil.asBtn(cell):AddClickListener(function()
		if self._haveGX < self._needGX then
			FloatWordMgr.instance:show(langPara("text_family_desc_8", self._needGX))

			return
		end

		UIStateManager.instance:push(ViewName.FamilyRedpackPopup, data.packetId)
	end)
end

function FamilyRedpackView:_updateOwnCell(view, cell, data)
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local descTxt = goutil.findChildTextComponent(cell, "descTxt")
	local timeTxt = goutil.findChildTextComponent(cell, "timeTxt")
	local limitTxt = goutil.findChildTextComponent(cell, "limitTxt")
	local redIconIsc = goutil.findChild(cell, "redIconIsc"):GetComponent("UIImageSpriteChange")
	local costIconGo = goutil.findChild(cell, "costGo/costIconGo")
	local costTxt = goutil.findChildTextComponent(cell, "costGo/costTxt")
	local progTxt = goutil.findChildTextComponent(cell, "progTxt")
	local clickBtnGo = goutil.findChild(cell, "clickBtn")
	local clickBtnIsc = clickBtnGo:GetComponent("UIImageSpriteChange")
	local clickTxt = goutil.findChildTextComponent(clickBtnGo, "clickTxt")
	local receiveGo = goutil.findChild(cell, "receiveGo")

	GameUtil.asBtn(clickBtnGo):RemoveClickListener()
	MaterialMgr.resetAll(costIconGo)

	nameTxt.text = data.cfg.taskTitle
	descTxt.text = data.cfg.taskDesc

	local startDate, endDate = GameUtil.string2date(data.cfg.startTime), GameUtil.string2date(data.cfg.endTime)

	timeTxt.text = string.format("%s-%s-%s -- %s-%s-%s\n周期：%s1次", startDate.year, startDate.month, startDate.day, endDate.year, endDate.month, endDate.day, self:_getTaskCycleShow(data.cfg.periodType))

	local typeCfg = FamilyConfig.instance:getRedpackTypeCfg(data.cfg.packetType)

	limitTxt.text = langPara("text_family_desc_9", typeCfg.people)

	redIconIsc:SetState(data.cfg.packetType - 1)
	MaterialMgr.updateItemByStr(costIconGo, typeCfg.prize)

	costTxt.text = tostring(typeCfg.num)

	if data.stage == 3 then
		progTxt.text = ""

		GameUtil.SetActive(clickBtnGo, false)
		GameUtil.SetActive(receiveGo, true)

		return
	end

	GameUtil.SetActive(receiveGo, false)
	GameUtil.SetActive(clickBtnGo, true)

	progTxt.text = string.format("任务进度：%s/%s", math.min(checknumber(data.info.curProgress), data.cfg.maxProgress), data.cfg.maxProgress)

	if data.stage == 1 then
		clickBtnIsc:SetState(1)

		clickTxt.text = lang("text_family_desc_10")
	elseif data.stage == 2 then
		clickBtnIsc:SetState(0)

		clickTxt.text = lang("goto")
	end

	GameUtil.asBtn(clickBtnGo):AddClickListener(function()
		if data.stage == 3 then
			return
		end

		if ServerTime.now() >= checknumber(data.info.expiredTime) / 1000 then
			FloatWordMgr.instance:show(lang("text_family_desc_11"))

			return
		end

		if data.stage == 1 then
			if self._haveGX < self._needGX then
				FloatWordMgr.instance:show(langPara("text_family_desc_8", self._needGX))
			else
				FamilyController.instance:csGetFamilyRedPacketSendRedPacketReq(data.cfg.taskId)
			end

			return
		end

		GotoMgr.gotoByString(data.cfg.jumpTo)
	end)
end

function FamilyRedpackView:_getTaskCycleShow(str)
	if string.nilorempty(str) then
		return lang("text_family_desc_12")
	end

	if str == "daily" then
		return lang("text_family_desc_13")
	end

	if str == "weekly" then
		return lang("text_family_desc_14")
	end

	return lang("text_family_desc_12")
end

function FamilyRedpackView:_getRedPackGainLimit(redpackData)
	local limitTable = {}
	local allCfgs = FamilyConfig.instance:getAllRedpackTypeCfgs()

	if not redpackData.redTimes then
		local redTimes = {}

		for i = 1, #allCfgs do
			local gainTime = checknumber(redTimes[allCfgs[i].packetType])

			limitTable[allCfgs[i].packetType] = gainTime >= allCfgs[i].dailyLimit
		end

		return limitTable
	end
end

return FamilyRedpackView
