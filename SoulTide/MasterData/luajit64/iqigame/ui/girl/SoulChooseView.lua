-- chunkname: @IQIGame\\UI\\Girl\\SoulChooseView.lua

local SoulChooseView = {
	fromType = 2,
	showList = true,
	soulCount = 0,
	cellDic = {},
	fromEnum = {
		MainUI = 1,
		GirlUI = 2
	}
}

function SoulChooseView.__New(ui)
	local o = Clone(SoulChooseView)

	o:OnInit(ui)

	return o
end

function SoulChooseView:OnInit(uiObj)
	self.goView = uiObj

	LuaCodeInterface.BindOutlet(uiObj, self)
	UGUIUtil.SetText(self.TextBtnHideList, GirlUIApi:GetString("TextBtnHideList"))
	UGUIUtil.SetText(self.TextBtnShowList, GirlUIApi:GetString("TextBtnShowList"))

	self.btnHideList = self.BtnHideList:GetComponent("Button")
	self.btnShowList = self.BtnShowList:GetComponent("Button")
	self.tweenPosition = self.scrollView:GetComponent("TweenPosition")
	self.tweenStart = self.tweenPosition.from
	self.tweenEnd = self.tweenPosition.to
	self.tweenSpeed = self.tweenPosition.duration
	self.chooseInGirl = ChooseInGirl.New()
	self.listScrollComp = self.goList:GetComponent("ScrollAreaList")
	self.scrollViewTrans = self.scrollView:GetComponent("RectTransform")

	function self.listScrollComp.onSelectedCell(cell)
		self:OnClickCell(cell)
	end

	function self.listScrollComp.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function self.delegateBtnHideList()
		self:OnHideList()
	end

	function self.delegateBtnShowList()
		self:OnShowList()
	end

	function self.delegateSoulDataChange(soulCid)
		self:OnSoulDateChange(soulCid)
	end

	function self.delegateOnRed(type)
		self:OnRedNotice(type)
	end

	self:OnAddListeners()
end

function SoulChooseView:UpdateView(soulData)
	self.chooseInGirl:Refresh(soulData)
	self:UpdateList()
end

function SoulChooseView:UpdateList()
	self.soulDataList = SoulModule.GetSortedUnlockSoulDataListOnNewGuide()

	table.sort(self.soulDataList, function(a, b)
		local res = false

		if a.favorLv == b.favorLv then
			if a.favor == b.favor then
				res = a.soulCid < b.soulCid
			else
				res = a.favor > b.favor
			end
		else
			res = a.favorLv > b.favorLv
		end

		return res
	end)

	local count = #self.soulDataList

	self.soulCount = count

	self.listScrollComp:Refresh(count)
	self.BtnHideList:SetActive(self.showList)
	self.BtnShowList:SetActive(not self.showList)
end

function SoulChooseView:Refresh()
	self.listScrollComp:RenderCells()
end

function SoulChooseView:OnAddListeners()
	self.btnShowList.onClick:AddListener(self.delegateBtnShowList)
	self.btnHideList.onClick:AddListener(self.delegateBtnHideList)
	EventDispatcher.AddEventListener(EventID.RedClientNotice, self.delegateOnRed)
	EventDispatcher.AddEventListener(EventID.SoulDataChange, self.delegateSoulDataChange)
end

function SoulChooseView:OnRemoveListeners()
	self.btnShowList.onClick:RemoveListener(self.delegateBtnShowList)
	self.btnHideList.onClick:RemoveListener(self.delegateBtnHideList)
	EventDispatcher.RemoveEventListener(EventID.RedClientNotice, self.delegateOnRed)
	EventDispatcher.RemoveEventListener(EventID.SoulDataChange, self.delegateSoulDataChange)
end

function SoulChooseView:Dispose()
	self:OnRemoveListeners()
end

function SoulChooseView:OnDestroy()
	for i, v in pairs(self.cellDic) do
		v:OnDestroy()
	end

	self:OnRemoveListeners()
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

function SoulChooseView:OnRenderCell(cell)
	local soulData = self.soulDataList[cell.index + 1]

	if soulData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local insID = cell.gameObject:GetInstanceID()
	local headCell = self.cellDic[insID]

	if headCell == nil then
		headCell = GirlChooseCell.New(cell.gameObject, 1)
		self.cellDic[insID] = headCell
	end

	headCell:OnRenderCell(soulData)

	cell.transform.parent.gameObject.name = soulData.soulCid

	if self.fromType == self.fromEnum.MainUI then
		-- block empty
	elseif self.fromType == self.fromEnum.GirlUI then
		self.chooseInGirl:OnRenderCell(headCell)
	end
end

function SoulChooseView:OnClickCell(cell)
	local soulData = self.soulDataList[cell.index + 1]
	local insID = cell.gameObject:GetInstanceID()
	local headCell = self.cellDic[insID]

	if self.fromType == self.fromEnum.MainUI then
		-- block empty
	elseif self.fromType == self.fromEnum.GirlUI and self.chooseInGirl:CheckCanClickCell(soulData) == true then
		self:UnselectedHeadCells()
		self.chooseInGirl:OnClickCell(headCell)
		headCell:OnClickCell(soulData)
	end
end

function SoulChooseView:UnselectedHeadCells()
	for i, v in pairs(self.cellDic) do
		v:OnUnselected()
	end
end

function SoulChooseView:OnRedNotice(type)
	return
end

function SoulChooseView:OnSoulDateChange(soulCid)
	self:UpdateList()
end

function SoulChooseView:OnHideList()
	self.tweenPosition = TweenPosition.Begin(self.scrollView, self.tweenSpeed, self.tweenEnd)
	self.showList = false

	self.BtnHideList:SetActive(self.showList)
	self.BtnShowList:SetActive(not self.showList)
end

function SoulChooseView:OnShowList()
	self.tweenPosition = TweenPosition.Begin(self.scrollView, self.tweenSpeed, self.tweenStart)
	self.showList = true

	self.BtnHideList:SetActive(self.showList)
	self.BtnShowList:SetActive(not self.showList)
end

return SoulChooseView
