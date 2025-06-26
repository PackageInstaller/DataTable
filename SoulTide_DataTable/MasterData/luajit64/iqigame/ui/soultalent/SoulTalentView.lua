-- chunkname: @IQIGame\\UI\\SoulTalent\\SoulTalentView.lua

local SoulTalentView = {
	pointCells = {},
	itemCells = {},
	talentAttCellPool = {},
	chapterAttCellPool = {},
	attSlotPool = {}
}
local SoulTalentPointCell = require("IQIGame.UI.SoulTalent.SoulTalentPointCell")

function SoulTalentView.New(go, mainView)
	local o = Clone(SoulTalentView)

	o:Initialize(go, mainView)

	return o
end

function SoulTalentView:Initialize(go, mainView)
	self.goView = go

	LuaCodeInterface.BindOutlet(go, self)

	self.mainView = mainView
	self.raycaster = self.mainView.UIController:GetComponent("GraphicRaycaster")
	self.groupBg = self.goGroupBg:GetComponent("Image")
	self.tfProgress = self.goProgress:GetComponent("Text")
	self.tfMoney = self.goMoney:GetComponent("Text")
	self.tfCondition = self.goCondition:GetComponent("Text")

	for i = 1, 6 do
		local go = self.goPointParent.transform:Find("Slot_0" .. i).gameObject

		self.pointCells[i] = SoulTalentPointCell.New(go)
	end

	for i = 1, 3 do
		local go = self.goItemCellParent.transform:Find("Item_0" .. i).gameObject

		self.itemCells[i] = ItemCell2.New(go)
	end

	self.talentAttCellPool[1] = self.goTalentAttCell
	self.chapterAttCellPool[1] = self.goChapterAttCell

	for i = 1, 2 do
		self.attSlotPool[i] = self.goAttSlotParent.transform:Find("Point_0" .. i)
	end

	self.btnDetail = self.goBtnDetail:GetComponent("Button")
	self.btnActivateTalent = self.goBtnActivateTalent:GetComponent("Button")
	self.btnActivateChapter = self.goBtnActivateChapter:GetComponent("Button")
	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnGuide = self.goTitleBlock.transform:Find("Button_02"):GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onClickBtnGuideDelegate()
		self:OnClickBtnGuide()
	end

	function self.onClickBtnDetailDelegate()
		self:OnClickBtnDetail()
	end

	function self.onClickBtnActivateTalentDelegate()
		self:OnClickBtnActivateTalent()
	end

	function self.onClickBtnActivateChapterDelegate()
		self:OnClickActivateChapter()
	end

	function self.onActivateTalentSuccessDelegate()
		self:OnActivateTalentSuccess()
	end

	function self.onActivateChapterSuccessDelegate()
		self:OnActivateChapterSuccess()
	end

	function self.onUpdateItemDelegate()
		self:OnUpdateItem()
	end

	self.goBtnActivateTalent.transform:Find("Text"):GetComponent("Text").text = SoulUIApi:GetString("talentViewBtnActivateTalentTxt")
	self.goBtnActivateChapter.transform:Find("Text"):GetComponent("Text").text = SoulUIApi:GetString("talentViewBtnActivateChapterTxt")
	self.goMaxBlock.transform:Find("Text"):GetComponent("Text").text = SoulUIApi:GetString("talentViewMaxDesc")
	self.goBtnClose.transform:Find("Text"):GetComponent("Text").text = SoulUIApi:GetString("Title", 2)
	self.goTitleBlock.transform:Find("Info/Text_01"):GetComponent("Text").text = SoulUIApi:GetString("TitleEng", 2)
	self.goTitleBlock.transform:Find("Info/Text_02"):GetComponent("Text").text = SoulUIApi:GetString("TitleHelp", 2)
	self.goBtnDetail.transform:Find("Text"):GetComponent("Text").text = SoulUIApi:GetString("btnAttDetailTxt")
	self.goProgressTitle:GetComponent("Text").text = SoulUIApi:GetString("talentViewProgressTitle")
end

function SoulTalentView:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SoulTalentView:Open(soulData)
	self.goView:SetActive(true)

	self.soulData = soulData
	self.cfgSoulData = self.soulData:GetCfgSoul()

	self:OnAddListeners()
	self:RefreshDatum()
	self:RefreshMisc()
	self:RefreshPointsBlock()
	self:RefreshTalentDetail()

	if self.effectIdLoop == nil then
		self:PlayEffectLoop()
	end

	self:PlayLineEffect()
end

function SoulTalentView:Close()
	self:OnHide()
	self.goView:SetActive(false)
end

function SoulTalentView:OnHide()
	for i, v in pairs(self.pointCells) do
		v:OnHide()
	end

	self:StopGroupEffectNormal()
	self:StopEffectWaitToActive()
	self:StopGroupEffectUp()
	self:StopEffectLoop()
	self:OnRemoveListeners()
end

function SoulTalentView:OnDestroy()
	for i, v in pairs(self.itemCells) do
		v:OnDestroy()
	end

	for i, v in pairs(self.pointCells) do
		v:OnDestroy()
	end

	self.mainView = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

function SoulTalentView:OnAddListeners()
	self:OnRemoveListeners()
	self.btnActivateTalent.onClick:AddListener(self.onClickBtnActivateTalentDelegate)
	self.btnDetail.onClick:AddListener(self.onClickBtnDetailDelegate)
	self.btnActivateChapter.onClick:AddListener(self.onClickBtnActivateChapterDelegate)
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnGuide.onClick:AddListener(self.onClickBtnGuideDelegate)
	EventDispatcher.AddEventListener(EventID.ActivateTalentSuccess, self.onActivateTalentSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.ActivateGroupSuccess, self.onActivateChapterSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.onUpdateItemDelegate)
end

function SoulTalentView:OnRemoveListeners()
	self.btnActivateTalent.onClick:RemoveListener(self.onClickBtnActivateTalentDelegate)
	self.btnDetail.onClick:RemoveListener(self.onClickBtnDetailDelegate)
	self.btnActivateChapter.onClick:RemoveListener(self.onClickBtnActivateChapterDelegate)
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnGuide.onClick:RemoveListener(self.onClickBtnGuideDelegate)
	EventDispatcher.RemoveEventListener(EventID.ActivateTalentSuccess, self.onActivateTalentSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.ActivateGroupSuccess, self.onActivateChapterSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.onUpdateItemDelegate)
end

function SoulTalentView:OnClickBtnDetail()
	self.mainView.attTipView:Open(self.soulData, 2)
end

function SoulTalentView:OnClickBtnActivateTalent()
	if self.curPointCell ~= nil then
		if self.isActiveTalentCostEnough == false then
			NoticeModule.ShowNotice(21041051)

			return
		end

		if self.isActiveTalentCostMoneyEnough == false then
			NoticeModule.ShowNotice(21041038)

			return
		end

		if self.soulData.lv < self.curPointCell.cfgTalentData.ActivationLv then
			NoticeModule.ShowNoticeNoCallback(21041036)

			return
		end

		SoulModule.ReqActivateTalent(self.soulData.soulCid, self.curPointCell.cfgTalentData.Id)
	end
end

function SoulTalentView:OnClickActivateChapter()
	if self.soulData.lv < self.curCfgGroupData.UnlockLv then
		NoticeModule.ShowNoticeNoCallback(21041036)

		return
	end

	SoulModule.ReqActiveTalentGroup(self.soulData.soulCid, self.curCfgGroupData.Id)
end

function SoulTalentView:OnActivateChapterSuccess()
	self:Open(self.soulData)
end

function SoulTalentView:OnActivateTalentSuccess()
	local activatedCell = self.curPointCell

	self:Open(self.soulData)

	if activatedCell ~= nil then
		activatedCell:OnActivateTalentSuccess()
	end
end

function SoulTalentView:OnUpdateItem()
	self:RefreshTalentDetail()
end

function SoulTalentView:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.SoulTalentUI)
end

function SoulTalentView:OnClickBtnGuide()
	return
end

function SoulTalentView:RefreshDatum()
	for i, v in ipairs(self.cfgSoulData.TalentGroupId) do
		self.curCfgGroupData = CfgSoulTalentGroupTable[v]

		if not SoulModule.CheckTalentGroupIsActivated(self.soulData, v) then
			self.curCfgGroupData = CfgSoulTalentGroupTable[v]

			break
		end
	end

	self.curCfgTalentDatum = {}

	for i, v in pairsCfg(CfgSoulTalentTable) do
		if v.GroupId == self.curCfgGroupData.Id then
			self.curCfgTalentDatum[#self.curCfgTalentDatum + 1] = v
		end
	end

	table.sort(self.curCfgTalentDatum, function(a, b)
		return a.Id < b.Id
	end)

	for i, v in ipairs(self.cfgSoulData.TalentGroupId) do
		if v == self.curCfgGroupData.Id then
			self.curGroupIndex = i

			break
		end
	end
end

function SoulTalentView:RefreshMisc()
	self.goBtnDetail:SetActive(#self.soulData.talentCids > 0)
end

function SoulTalentView:RefreshPointsBlock()
	self.tfProgress.text = SoulUIApi:GetString("talentViewProgress", #self.soulData.talentCids, self.soulData.totalTalentCount)
	self.curPointCell = nil

	for i, v in ipairs(self.pointCells) do
		v:Refresh(self.curCfgTalentDatum[i], self.soulData, self.curGroupIndex)

		if v.curState == 1 then
			self.curPointCell = v
		end
	end

	if self.curPointCell ~= nil then
		-- block empty
	else
		self:StopEffectWaitToActive()
	end
end

function SoulTalentView:RefreshTalentDetail()
	AssetUtil.LoadImage(self, SoulUIApi:GetString("talentViewBgPath", self.curGroupIndex), self.groupBg)

	local curGroupIsLast = true
	local curGroupAllTalentActivated = true

	if self.curCfgGroupData.Id ~= self.cfgSoulData.TalentGroupId[#self.cfgSoulData.TalentGroupId] then
		curGroupIsLast = false
	end

	for i, v in pairs(self.pointCells) do
		if v.curState ~= 2 then
			curGroupAllTalentActivated = false

			break
		end
	end

	self.goMaxBlock:SetActive(false)
	self.goBtnActivateChapter:SetActive(false)
	self.goBtnActivateTalent:SetActive(false)
	self.goChapterAttCell.transform.parent.gameObject:SetActive(false)
	self.goCondition.transform.parent.gameObject:SetActive(false)
	self.goTalentAttCell.transform.parent.gameObject:SetActive(not curGroupAllTalentActivated)
	self.goItemCellParent.transform.parent.gameObject:SetActive(not curGroupAllTalentActivated)
	self.goMoney.transform.parent.gameObject:SetActive(not curGroupAllTalentActivated)

	local curGroupIsActivated = SoulModule.CheckTalentGroupIsActivated(self.soulData, self.curCfgGroupData.Id)

	if curGroupAllTalentActivated then
		self:PlayGroupEffectNormal()

		if curGroupIsLast and curGroupIsActivated then
			self.goMaxBlock:SetActive(true)
		else
			local conditionOk = self.soulData.lv >= self.curCfgGroupData.UnlockLv

			self.goChapterAttCell.transform.parent.gameObject:SetActive(true)

			self.tfCondition.text = SoulUIApi:GetString("talentViewCondition", self.curCfgGroupData.UnlockLv)

			self.goCondition.transform.parent.gameObject:SetActive(not conditionOk)
			self.goBtnActivateChapter:SetActive(true)
			self.goBtnActivateChapter:GetComponent("GrayComponent"):SetGray(not conditionOk)

			local attType = self.curCfgGroupData.AttType
			local attValues = self.curCfgGroupData.AttValue

			for i, v in ipairs(self.chapterAttCellPool) do
				v:SetActive(i <= #attType)
			end

			for i, v in ipairs(attType) do
				local cell = self:GetChapterAttCell(i)
				local tfDesc = cell.transform:Find("Text_01"):GetComponent("Text")

				tfDesc.text = SoulUIApi:GetString("talentViewChapterAttDesc", AttributeModule.GetAttName(v), AttributeModule.GetAttShowValue(v, attValues[i]))
				cell.transform.localPosition = Vector3.New(0, 0, 0)

				cell.transform.parent:SetParent(self.attSlotPool[i], false)
			end
		end
	else
		self.isActiveTalentCostEnough = true
		self.isActiveTalentCostMoneyEnough = true

		local conditionOk = true

		if self.curPointCell ~= nil then
			local cost = self.curPointCell.cfgTalentData.Cost

			for i, v in pairs(cost) do
				if i % 2 ~= 0 then
					local id = v
					local needCount = cost[i + 1]

					if needCount > WarehouseModule.GetItemNumByCfgID(id) then
						if id == Constant.ItemID.MONEY then
							self.isActiveTalentCostMoneyEnough = false

							break
						end

						self.isActiveTalentCostEnough = false

						break
					end
				end
			end

			conditionOk = self.soulData.lv >= self.curPointCell.cfgTalentData.ActivationLv
			self.tfCondition.text = SoulUIApi:GetString("talentViewCondition", self.curPointCell.cfgTalentData.ActivationLv)

			self.goCondition.transform.parent.gameObject:SetActive(not conditionOk)
		end

		self.goBtnActivateTalent:SetActive(true)
		self.goBtnActivateTalent:GetComponent("GrayComponent"):SetGray(not self.isActiveTalentCostEnough or not self.isActiveTalentCostMoneyEnough or not conditionOk)
		self:StopGroupEffectNormal()
	end

	if self.curPointCell ~= nil then
		self:RefreshTalentAtt()
		self:RefreshCostBlock()
	end
end

function SoulTalentView:RefreshTalentAtt()
	local cfgTalentData = self.curPointCell.cfgTalentData
	local validIds = {}
	local validValues = {}

	for i, v in ipairs(cfgTalentData.AttType) do
		if v ~= 0 then
			validIds[#validIds + 1] = v
			validValues[#validValues + 1] = cfgTalentData.AttValue[i]
		end
	end

	for i, v in ipairs(self.talentAttCellPool) do
		v:SetActive(i <= #validIds)
	end

	for i, v in ipairs(validIds) do
		local attName = AttributeModule.GetAttName(v)
		local value = AttributeModule.GetAttShowValue(v, validValues[i])
		local cell = self:GetTalentAttCell(i)

		cell.transform:Find("Text_01"):GetComponent("Text").text = SoulUIApi:GetString("talentViewTalentAttDesc", attName, value)
		cell.transform.localPosition = Vector3.New(0, 0, 0)

		cell.transform.parent:SetParent(self.attSlotPool[i], false)
	end
end

function SoulTalentView:RefreshCostBlock()
	if self.curPointCell == nil then
		return
	end

	local cfgTalentData = self.curPointCell.cfgTalentData
	local ids = {}
	local count = {}
	local moneyId, moneyCount

	for i, v in ipairs(cfgTalentData.Cost) do
		if i % 2 ~= 0 then
			if v ~= 1 then
				ids[#ids + 1] = v
				count[#count + 1] = cfgTalentData.Cost[i + 1]
			else
				moneyId = v
				moneyCount = cfgTalentData.Cost[i + 1]
			end
		end
	end

	for i, v in ipairs(self.itemCells) do
		v:SetActive(i <= #ids)
	end

	for i, v in ipairs(ids) do
		self.itemCells[i]:Refresh(v, count[i])
	end

	self.goMoney.transform.parent.gameObject:SetActive(moneyId ~= nil)

	if moneyCount ~= nil then
		self.tfMoney.text = SoulUIApi:GetString("goMoneyCost", moneyCount, WarehouseModule.GetItemNumByCfgID(1))
	end
end

function SoulTalentView:GetTalentAttCell(index)
	local ret = self.talentAttCellPool[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goTalentAttCell)

		ret.transform:SetParent(self.goTalentAttCell.transform.parent, false)

		self.talentAttCellPool[index] = ret
	end

	ret:SetActive(true)

	return ret
end

function SoulTalentView:GetChapterAttCell(index)
	local ret = self.chapterAttCellPool[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goChapterAttCell)

		ret.transform:SetParent(self.goChapterAttCell.transform.parent, false)

		self.chapterAttCellPool[index] = ret
	end

	ret:SetActive(true)

	return ret
end

function SoulTalentView:PlayGroupEffectNormal()
	self:StopGroupEffectNormal()

	local id = SoulUIApi:GetString("talentGroupEffectNormal")

	self.curEffectIdGroupNormal = GameEntry.Effect:PlayUIMountPointEffect(id, 50000, 0, self.goPointParent, 0)
end

function SoulTalentView:StopGroupEffectNormal()
	if self.curEffectIdGroupNormal ~= nil then
		GameEntry.Effect:StopEffect(self.curEffectIdGroupNormal)
	end
end

function SoulTalentView:PlayEffectWaitToActive(goParent)
	self:StopEffectWaitToActive()

	local id = SoulUIApi:GetString("talentEffectWaitToActive")

	self.curEffectIdWaitToActive = GameEntry.Effect:PlayUIMountPointEffect(id, 50000, 0, goParent, 0)
end

function SoulTalentView:StopEffectWaitToActive()
	if self.curEffectIdWaitToActive ~= nil then
		GameEntry.Effect:StopEffect(self.curEffectIdWaitToActive)
	end
end

function SoulTalentView:PlayEffectLoop()
	self:StopEffectLoop()

	self.effectIdLoop = GameEntry.Effect:PlayUIMountPointEffect(9001143, 50000, 0, self.goEffectLoop, 0)
end

function SoulTalentView:StopEffectLoop()
	if self.effectIdLoop ~= nil then
		GameEntry.Effect:StopEffect(self.effectIdLoop)
	end

	self.effectIdLoop = nil
end

function SoulTalentView:PlayGroupEffectUp()
	self:StopGroupEffectUp()

	local id = SoulUIApi:GetString("talentGroupEffectUp")

	self.curEffectIdGroupUp = GameEntry.Effect:PlayUIMountPointEffect(id, 50000, 0, self.goPointParent, 0)
end

function SoulTalentView:StopGroupEffectUp()
	if self.curEffectIdGroupUp ~= nil then
		GameEntry.Effect:StopEffect(self.curEffectIdGroupUp)
	end
end

function SoulTalentView:PlayLineEffect()
	local maxActivatedIndex_1 = 0
	local maxActivatedIndex_2 = 0
	local allActivated = true

	for i, v in ipairs(self.pointCells) do
		if v.curState == 1 or v.curState == 2 then
			if i == 1 or i == 2 or i == 4 or i == 6 then
				maxActivatedIndex_1 = i
			end

			if i == 1 or i == 3 or i == 5 or i == 6 then
				maxActivatedIndex_2 = i
			end
		end

		if v.curState == 1 or v.curState == 3 then
			allActivated = false
		end
	end

	if allActivated then
		maxActivatedIndex_1 = 7
		maxActivatedIndex_2 = 7
	end

	local progressPoint_1_1 = {
		0.25,
		0.11,
		nil,
		-0.03,
		nil,
		-0.25,
		-0.5
	}
	local progressPoint_1_2 = {
		0.25,
		0.11,
		nil,
		-0.03,
		nil,
		-0.25,
		-0.5
	}
	local progressPoint_2_1 = {
		0.25,
		nil,
		0.04,
		nil,
		-0.13,
		-0.25,
		-0.5
	}
	local progressPoint_2_2 = {
		0.25,
		nil,
		0.04,
		nil,
		-0.13,
		-0.25,
		-0.5
	}

	if progressPoint_1_1[maxActivatedIndex_1] ~= nil then
		local renderer_1 = self.goEffectProgress.transform:Find("Effect/xia01_A"):GetComponent("Renderer")
		local renderer_2 = self.goEffectProgress.transform:Find("Effect/xia01_B"):GetComponent("Renderer")
		local renders = {
			renderer_1,
			renderer_2
		}

		for i, v in pairs(renders) do
			local fieldName = "_mask"
			local progressPoint

			if v == renderer_1 then
				progressPoint = progressPoint_1_1
			elseif v == renderer_2 then
				progressPoint = progressPoint_1_2
			end

			local offset = v.material:GetTextureOffset(fieldName)

			offset.x = progressPoint[maxActivatedIndex_1]

			v.material:SetTextureOffset(fieldName, offset)
		end
	end

	if progressPoint_2_1[maxActivatedIndex_2] ~= nil then
		local renderer_1 = self.goEffectProgress.transform:Find("Effect/xia02_A"):GetComponent("Renderer")
		local renderer_2 = self.goEffectProgress.transform:Find("Effect/xia02_B"):GetComponent("Renderer")
		local renders = {
			renderer_1,
			renderer_2
		}

		for i, v in pairs(renders) do
			local fieldName = "_mask"
			local progressPoint

			if v == renderer_1 then
				progressPoint = progressPoint_2_1
			elseif v == renderer_2 then
				progressPoint = progressPoint_2_2
			end

			local offset = v.material:GetTextureOffset(fieldName)

			offset.x = progressPoint[maxActivatedIndex_2]

			v.material:SetTextureOffset(fieldName, offset)
		end
	end
end

return SoulTalentView
