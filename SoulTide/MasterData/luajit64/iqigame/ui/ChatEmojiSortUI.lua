-- chunkname: @IQIGame\\UI\\ChatEmojiSortUI.lua

local ChatEmojiSortUI = {
	listCellPool = {},
	listCellWorking = {},
	fixedPosYList = {}
}

ChatEmojiSortUI = Base:Extend("ChatEmojiSortUI", "IQIGame.Onigao.UI.ChatEmojiSortUI", ChatEmojiSortUI)

local EmoCell = require("IQIGame.UI.ChatEmojiSort.EmoCell")

function ChatEmojiSortUI:OnInit()
	self:Initialize()
end

function ChatEmojiSortUI:GetPreloadAssetPaths()
	return nil
end

function ChatEmojiSortUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ChatEmojiSortUI:IsManualShowOnOpen(userData)
	return false
end

function ChatEmojiSortUI:GetBGM(userData)
	return nil
end

function ChatEmojiSortUI:OnOpen(userData)
	self:Refresh(userData)
end

function ChatEmojiSortUI:OnClose(userData)
	self:OnHide()
end

function ChatEmojiSortUI:OnPause()
	return
end

function ChatEmojiSortUI:OnResume()
	return
end

function ChatEmojiSortUI:OnCover()
	return
end

function ChatEmojiSortUI:OnReveal()
	return
end

function ChatEmojiSortUI:OnRefocus(userData)
	return
end

function ChatEmojiSortUI:OnUpdate(elapseSeconds, realElapseSeconds)
	for i, v in pairs(self.listCellWorking) do
		v:OnUpdate()
	end
end

function ChatEmojiSortUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ChatEmojiSortUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ChatEmojiSortUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ChatEmojiSortUI:Initialize()
	self.list = self.goList:GetComponent("ScrollRect")
	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnDefault = self.goBtnDefault:GetComponent("Button")
	self.btnSure = self.goBtnSure:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onClickBtnDefaultDelegate()
		self:OnClickBtnDefault()
	end

	function self.onClickBtnSureDelegate()
		self:OnClickBtnSure()
	end

	self.goBtnDefault.transform:Find("Text"):GetComponent("Text").text = ChatUIApi:GetString("Emo_BtnDefaultTxt")
	self.goBtnSure.transform:Find("Text"):GetComponent("Text").text = ChatUIApi:GetString("Emo_BtnSureTxt")
	self.goTitle:GetComponent("Text").text = ChatUIApi:GetString("Emo_Title")
end

function ChatEmojiSortUI:Refresh(userData)
	self.listDatum = {}
	self.fixedPosYList = {}
	self.listDatum = ChatModule.GetEmoGroupSortDatum()
	self.halfCellHeight = self.goEmoCell.transform.sizeDelta.y / 2
	self.limitYTop = -self.halfCellHeight
	self.limitYBottom = math.max(self.list.viewport.rect.y + self.halfCellHeight, -self.goEmoCell.transform.sizeDelta.y * #self.listDatum + self.halfCellHeight)

	self:RefreshList()
end

function ChatEmojiSortUI:OnHide()
	for i, v in pairs(self.listCellPool) do
		v:OnHide()
	end
end

function ChatEmojiSortUI:OnDestroy()
	for i, v in pairs(self.listCellPool) do
		v:OnDestroy()
	end
end

function ChatEmojiSortUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnDefault.onClick:AddListener(self.onClickBtnDefaultDelegate)
	self.btnSure.onClick:AddListener(self.onClickBtnSureDelegate)
end

function ChatEmojiSortUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnDefault.onClick:RemoveListener(self.onClickBtnDefaultDelegate)
	self.btnSure.onClick:RemoveListener(self.onClickBtnSureDelegate)
end

function ChatEmojiSortUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function ChatEmojiSortUI:OnClickBtnDefault()
	self.listDatum = ChatModule.GetEmoGroupDefaultDatum()

	self:RefreshList()
end

function ChatEmojiSortUI:OnClickBtnSure()
	local cells = {}

	for i, v in pairs(self.listCellWorking) do
		cells[#cells + 1] = v
	end

	table.sort(cells, function(a, b)
		return a.posIndex < b.posIndex
	end)

	local datum = {}

	for i, v in ipairs(cells) do
		datum[#datum + 1] = v.cfgEmoGroupData
	end

	ChatModule.SaveEmoGroupSortDatum(datum)
	UIModule.CloseSelf(self)
end

function ChatEmojiSortUI:OnEmoCellBeginDrag(cell, deltaY)
	for i, v in pairs(self.listCellPool) do
		if v ~= cell then
			v:SetUIDragEnable(false)
		end
	end

	if #self.fixedPosYList == 0 then
		for i, v in ipairs(self.listCellWorking) do
			self.fixedPosYList[i] = v:GetY()
		end
	end
end

function ChatEmojiSortUI:OnEmoCellDrag(cell, deltaY)
	self:AdjustTargetPosY(cell, deltaY)
	self:CheckAndTryToMove(cell, deltaY)
end

function ChatEmojiSortUI:OnEmoCellEndDrag(cell)
	for i, v in pairs(self.listCellPool) do
		v:SetUIDragEnable(true)
	end

	cell:StartAutoMove(cell.posIndex)

	for i, v in pairs(self.listCellWorking) do
		v:RefreshNum()
	end
end

function ChatEmojiSortUI:AdjustTargetPosY(cell, deltaY)
	if deltaY > 0 then
		for i = #self.fixedPosYList, 1, -1 do
			if self.fixedPosYList[i] + self.halfCellHeight >= cell:GetY() then
				self.targetPosY = self.fixedPosYList[i]
				self.targetPosYIndex = i

				break
			end
		end
	elseif deltaY < 0 then
		for i = 1, #self.fixedPosYList do
			if self.fixedPosYList[i] - self.halfCellHeight <= cell:GetY() then
				self.targetPosY = self.fixedPosYList[i]
				self.targetPosYIndex = i

				break
			end
		end
	end
end

function ChatEmojiSortUI:CheckAndTryToMove(cell, deltaY)
	if deltaY > 0 and cell:GetY() >= self.targetPosY - self.halfCellHeight or deltaY < 0 and cell:GetY() <= self.targetPosY + self.halfCellHeight then
		local tempCells = {}

		for i, v in pairs(self.listCellWorking) do
			if v ~= cell then
				if deltaY > 0 then
					if v.posIndex < cell.posIndex and v.posIndex >= self.targetPosYIndex then
						tempCells[#tempCells + 1] = v
					end
				elseif deltaY < 0 and v.posIndex > cell.posIndex and v.posIndex <= self.targetPosYIndex then
					tempCells[#tempCells + 1] = v
				end
			end
		end

		if deltaY > 0 then
			table.sort(tempCells, function(a, b)
				return a.posIndex < b.posIndex
			end)

			for i, v in ipairs(tempCells) do
				v:StartAutoMove(self.targetPosYIndex + i)
			end
		else
			table.sort(tempCells, function(a, b)
				return a.posIndex > b.posIndex
			end)

			for i, v in ipairs(tempCells) do
				v:StartAutoMove(self.targetPosYIndex - i)
			end
		end

		cell.posIndex = self.targetPosYIndex
	end
end

function ChatEmojiSortUI:RefreshList()
	self.listCellWorking = {}

	for i, v in pairs(self.listCellPool) do
		v:SetActive(false)
	end

	for i, v in ipairs(self.listDatum) do
		local cell = self:GetEmoCell(i)

		cell:Refresh(i, v)

		self.listCellWorking[i] = cell
	end
end

function ChatEmojiSortUI:GetEmoCell(index)
	local ret = self.listCellPool[index]

	if ret == nil then
		local goClone = self.goEmoCell

		if index > 1 then
			goClone = UnityEngine.Object.Instantiate(self.goEmoCell)
		end

		goClone.transform:SetParent(self.goCellRoot.transform, false)

		ret = EmoCell.New(goClone, self)
		self.listCellPool[index] = ret
	end

	ret.View:SetActive(true)

	return ret
end

return ChatEmojiSortUI
