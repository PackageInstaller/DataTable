-- chunkname: @IQIGame\\UI\\SoulLevelUp\\SoulLevelView.lua

local SoulLevelView = {
	maxSoulLv = 0,
	cells = {}
}
local SoulLevelUpItemCell = require("IQIGame.UI.SoulLevelUp.SoulLevelUpItemCell")

function SoulLevelView.New(view, mainView)
	local obj = Clone(SoulLevelView)

	obj:Init(view, mainView)

	return obj
end

function SoulLevelView:Init(view, mainView)
	self.View = view
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfAddExp = self.goAddExp:GetComponent("Text")
	self.tfMaxLv = self.goMaxLv:GetComponent("Text")
	self.tfExpPercent = self.goExpPercent:GetComponent("Text")
	self.tfExpProgress = self.goExpProgress:GetComponent("Text")
	self.imgLv10 = self.goImgLv10:GetComponent("Image")
	self.imgLv1 = self.goImgLv1:GetComponent("Image")
	self.btnUp = self.goBtnUp:GetComponent("Button")
	self.btnMax = self.goBtnMax:GetComponent("Button")
	self.btnClear = self.goBtnClear:GetComponent("Button")
	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnGuide = self.goTitleBlock.transform:Find("Button_02"):GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onClickBtnGuideDelegate()
		self:OnClickBtnGuide()
	end

	function self.onClickBtnMaxDelegate()
		self:OnClickBtnMax()
	end

	function self.onClickBtnClearDelegate()
		self:OnClickBtnClear()
	end

	function self.onClickBtnUpDelegate()
		self:OnClickBtnUp()
	end

	function self.onSoulExpAddSuccessDelegate()
		self:OnSoulExpAddSuccess()
	end

	function self.onUpdateItemDelegate()
		self:OnUpdateItem()
	end

	for i = 1, 4 do
		local go = self.goItemCellParent.transform:Find("Slot_mould_" .. i).gameObject

		self.cells[i] = SoulLevelUpItemCell.New(go)
	end

	for i, v in pairsCfg(CfgSoulLevelTable) do
		if v.NextEXP == 0 then
			self.maxSoulLv = v.Id

			break
		end
	end

	self.goBtnUp.transform:Find("Text_01"):GetComponent("Text").text = SoulUIApi:GetString("UpViewUpBtnTxt")
	self.goBtnUp.transform:Find("Text_02"):GetComponent("Text").text = SoulUIApi:GetString("UpViewBtnTxtEng")
	self.goBtnMax.transform:Find("Text"):GetComponent("Text").text = SoulUIApi:GetString("UpViewLvBtnMaxTxt")
	self.goBtnClear.transform:Find("Text"):GetComponent("Text").text = SoulUIApi:GetString("UpViewLvBtnClearTxt")
	self.goBtnClose.transform:Find("Text"):GetComponent("Text").text = SoulUIApi:GetString("Title", 1)
	self.goTitleBlock.transform:Find("Info/Text_01"):GetComponent("Text").text = SoulUIApi:GetString("TitleEng", 1)
	self.goTitleBlock.transform:Find("Info/Text_02"):GetComponent("Text").text = SoulUIApi:GetString("TitleHelp", 1)
	self.goLvTitle:GetComponent("Text").text = SoulUIApi:GetString("UpViewLvTitle")
	self.progressSpeed = SoulUIApi:GetString("UpViewProgressSpeed")
end

function SoulLevelView:Open(soulData)
	self.soulData = soulData
	self.isLocking = false

	self.View:SetActive(true)
	self.goLvInfoBlock:SetActive(true)

	self.tfMaxLv.text = SoulUIApi:GetString("maxLv", SoulModule.GetMaxSoulLv())

	self:StopProgressAnim()
	self:RefreshCells()
	self:RefreshOnExp(0)
	self:AddListeners()
end

function SoulLevelView:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.startProgressAnim then
		if self.toChangeProgress_1 < self.progressDelta_1 then
			self.toChangeProgress_1 = self.toChangeProgress_1 + self.progressSpeed
			self.toChangeProgress_1 = math.min(self.toChangeProgress_1, self.progressDelta_1)

			self:SetProgress(self.toChangeProgress_1)
		end

		if self.toChangeProgress_1 == self.progressDelta_1 then
			self:SetProgress(0)

			if self.toChangeProgress_2 < self.progressDelta_2 then
				self.toChangeProgress_2 = self.toChangeProgress_2 + self.progressSpeed
				self.toChangeProgress_2 = math.min(self.toChangeProgress_2, self.progressDelta_2)

				self:SetProgress(self.toChangeProgress_2)
			end

			if self.toChangeProgress_2 == self.progressDelta_2 then
				if self.isLocking then
					LuaCodeInterface.SetEventSystemEnabled("SoulLevelUp", true)
				end

				self.isLocking = false

				self:StopProgressAnim()

				if SoulModule.lastUpSoulLv ~= self.soulData.lv then
					UIModule.Open(Constant.UIControllerName.SoulLevelUpTipUI, Constant.UILayer.UI, {
						self.soulData,
						SoulModule.lastUpSoulAtts
					})
				end
			end
		end
	end
end

function SoulLevelView:Close()
	self:OnHide()
	self.goLvInfoBlock:SetActive(false)
	self.View:SetActive(false)
end

function SoulLevelView:OnHide()
	if self.isLocking then
		LuaCodeInterface.SetEventSystemEnabled("SoulLevelUp", true)
	end

	self.isLocking = false

	for i, v in pairs(self.cells) do
		v:OnHide()
	end

	self:RemoveListeners()
	self:StopProgressAnim()
end

function SoulLevelView:OnDestroy()
	self.mainView = nil

	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.cells) do
		v:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function SoulLevelView:AddListeners()
	self:RemoveListeners()
	self.btnUp.onClick:AddListener(self.onClickBtnUpDelegate)
	self.btnMax.onClick:AddListener(self.onClickBtnMaxDelegate)
	self.btnClear.onClick:AddListener(self.onClickBtnClearDelegate)
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnGuide.onClick:AddListener(self.onClickBtnGuideDelegate)
	EventDispatcher.AddEventListener(EventID.SoulExpAddSuccess, self.onSoulExpAddSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.onUpdateItemDelegate)
end

function SoulLevelView:RemoveListeners()
	self.btnUp.onClick:RemoveListener(self.onClickBtnUpDelegate)
	self.btnMax.onClick:RemoveListener(self.onClickBtnMaxDelegate)
	self.btnClear.onClick:RemoveListener(self.onClickBtnClearDelegate)
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnGuide.onClick:RemoveListener(self.onClickBtnGuideDelegate)
	EventDispatcher.RemoveEventListener(EventID.SoulExpAddSuccess, self.onSoulExpAddSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.onUpdateItemDelegate)
end

function SoulLevelView:OnClickBtnUp()
	if self.soulData.lv >= SoulModule.GetMaxSoulLv() then
		NoticeModule.ShowNotice(21041039)

		return
	end

	local selected = false

	for i, v in pairs(self.cells) do
		if v.selectedNum > 0 then
			selected = true

			break
		end
	end

	if selected == false then
		NoticeModule.ShowNoticeNoCallback(21041027)

		return
	end

	local id2CountDic = {}

	for i, v in pairs(self.cells) do
		if v.selectedNum > 0 then
			id2CountDic[v.cfgItemData.Id] = v.selectedNum
		end
	end

	SoulModule.ReqAddExp(self.soulData.soulCid, id2CountDic)
end

function SoulLevelView:OnSelectItemChange(cell)
	local addExp = 0

	for i, v in pairs(self.cells) do
		addExp = addExp + v.selectedNum * v.exp
	end

	self:RefreshOnExp(addExp)
end

function SoulLevelView:OnSoulExpAddSuccess()
	if self.progressDelta_1 > 0 or self.progressDelta_2 > 0 then
		self:StartProgressAnim()
	end

	self:RefreshCells()
	self:RefreshOnExp(0, true)
end

function SoulLevelView:OnClickBtnMax()
	if self.canUpLv >= self.maxSoulLv then
		NoticeModule.ShowNoticeNoCallback(21041039)

		return
	end

	local cfgData = CfgSoulLevelTable[self.canUpLv]

	if PlayerModule.PlayerInfo.baseInfo.pLv < cfgData.NeedPlayerLv then
		NoticeModule.ShowNoticeNoCallback(21041040)

		return
	end

	for i = 4, 1, -1 do
		local cell = self.cells[i]

		for i = 1, cell.realOwnNum do
			if self.canUpLv >= self.maxSoulLv then
				break
			end

			local cfgData = CfgSoulLevelTable[self.canUpLv]

			if PlayerModule.PlayerInfo.baseInfo.pLv < cfgData.NeedPlayerLv then
				break
			end

			local ret = cell:DoClickBtnAdd(false)

			if not ret then
				break
			end

			local addExp = 0

			for i, v in pairs(self.cells) do
				addExp = addExp + v.selectedNum * v.exp
			end

			self.canUpLv = SoulModule.GetCanUpLv(self.soulData.lv, self.maxSoulLv, addExp + self.soulData.exp)
		end
	end

	self:OnSelectItemChange()
end

function SoulLevelView:OnClickBtnClear()
	for i, v in pairs(self.cells) do
		v:OnClickBtnReduce(true)
	end

	self:OnSelectItemChange()
end

function SoulLevelView:OnUpdateItem()
	self:RefreshCells()
end

function SoulLevelView:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.SoulLevelUpUI)
end

function SoulLevelView:OnClickBtnGuide()
	return
end

function SoulLevelView:RefreshCells()
	for i = 1, 4 do
		self.cells[i]:Refresh(i, self)
	end
end

function SoulLevelView:RefreshOnExp(addExp, needAnim)
	self.canUpLv = SoulModule.GetCanUpLv(self.soulData.lv, self.maxSoulLv, addExp + self.soulData.exp)

	self.goImgLv10:SetActive(self.canUpLv > 9)

	if self.canUpLv > 9 then
		AssetUtil.LoadImage(self, SoulUIApi:GetString("imgLvPath", math.floor(self.canUpLv / 10)), self.imgLv10)
	end

	AssetUtil.LoadImage(self, SoulUIApi:GetString("imgLvPath", self.canUpLv % 10), self.imgLv1)
	self.goAddExp:SetActive(addExp ~= 0)

	self.tfAddExp.enabled = addExp ~= 0
	self.tfAddExp.text = SoulUIApi:GetString("UpViewAddExp", addExp)

	self:RefreshPreviewInfo(addExp, self.canUpLv, needAnim)
end

function SoulLevelView:RefreshPreviewInfo(addExp, curLv, needAnim)
	local totalExpNextNeed = 0

	for i = 1, curLv do
		totalExpNextNeed = totalExpNextNeed + CfgSoulLevelTable[i].NextEXP
	end

	local totalExpNowAdd = 0

	for i = 1, self.soulData.lv - 1 do
		totalExpNowAdd = totalExpNowAdd + CfgSoulLevelTable[i].NextEXP
	end

	totalExpNowAdd = totalExpNowAdd + self.soulData.exp + addExp

	local curExp = CfgSoulLevelTable[curLv].NextEXP - (totalExpNextNeed - totalExpNowAdd)
	local needExp = CfgSoulLevelTable[curLv].NextEXP

	self.tfExpPercent.text = SoulUIApi:GetString("UpViewProgressPercent", curExp, needExp)
	self.tfExpProgress.text = SoulUIApi:GetString("UpViewProgressDesc", curExp, needExp)
	self.previewCurExp = curExp
	self.previewNeedExp = needExp

	if not needAnim then
		self.progressDelta_1 = 0
		self.progressDelta_2 = self.previewCurExp / self.previewNeedExp
		self.progressDelta_2 = math.min(self.progressDelta_2, 1)

		if curLv > self.soulData.lv then
			self.progressDelta_1 = 1
		end

		self:SetProgress(self.previewCurExp / self.previewNeedExp)
	end
end

function SoulLevelView:GetReachNextLvCostItemCount(itemExp)
	local deltaExp = self.previewNeedExp - self.previewCurExp
	local count = math.ceil(deltaExp / itemExp)

	return count
end

function SoulLevelView:StartProgressAnim()
	self.startProgressAnim = true
	self.toChangeProgress_1 = 0
	self.toChangeProgress_2 = 0

	if not self.isLocking then
		LuaCodeInterface.SetEventSystemEnabled("SoulLevelUp", false)
	end

	self.isLocking = true
end

function SoulLevelView:StopProgressAnim()
	self.startProgressAnim = false
end

function SoulLevelView:SetProgress(progress)
	local renderer = self.goEffectPreviewExp:GetComponent("Renderer")
	local offset = renderer.material:GetTextureOffset("_mask02")
	local y = 0.42 - 0.42 * progress

	y = math.max(0, y)
	offset.y = y

	renderer.material:SetTextureOffset("_mask02", offset)

	renderer = self.goEffectPreviewExp2:GetComponent("Renderer")
	offset = renderer.material:GetTextureOffset("_mask02")
	y = 0.41 - 0.42 * progress
	y = math.max(0, y)
	offset.y = y

	renderer.material:SetTextureOffset("_mask02", offset)
end

return SoulLevelView
