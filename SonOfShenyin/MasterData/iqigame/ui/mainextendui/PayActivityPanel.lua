-- chunkname: @IQIGame\\UI\\MainExtendUI\\PayActivityPanel.lua

local PayActivityPanel = {}

function PayActivityPanel.New(view)
	local obj = Clone(PayActivityPanel)

	obj:Init(view)

	return obj
end

function PayActivityPanel:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.CountParent = self.PayActivityScrollCount

	self:InitData()
	self:InitConfig()

	self.isDrag = false
	self.PASCRectTransform = self.CountParent.transform
	self.scrollList = self.PayActivityScrollArea.gameObject:GetComponent("ScrollAreaListPage")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function self.scrollList.onPageReachedMainPos(page)
		self:OnPageReachedMain(page)
	end

	function self.delegateShowNextPage()
		self:SetData()
	end

	local eventTrigger = UGUIUtil.GetEventTriggerListenerWithNil(self.PayActivityScrollArea.gameObject)

	if eventTrigger then
		eventTrigger.onDrag = eventTrigger.onDrag + function(Pointgo, PointerEventData)
			self:OnDrag(PointerEventData)
		end
		eventTrigger.onEndDrag = eventTrigger.onEndDrag + function(Pointgo, PointerEventData)
			self:OnEndDrag(PointerEventData)
		end
		eventTrigger.onBeginDrag = eventTrigger.onBeginDrag + function(Pointgo, PointerEventData)
			self:onBeginDrag(PointerEventData)
		end
	end
end

function PayActivityPanel:OnOpen()
	self:RefreshList(0)
	self:RunData()
end

function PayActivityPanel:RefreshList(startIndex)
	self.scrollList.startIndex = startIndex

	self.scrollList:Refresh(#self.curConfig)
end

function PayActivityPanel:OnRenderCell(pageCell)
	local goObj = pageCell.gameObject

	goObj:SetActive(true)

	local ActivityImageObj = goObj.transform:Find("Image")
	local index = pageCell.index + 1
	local tragetConfig = self.curConfig[index]
	local bgPath = MainUIExtendApi:GetActivity(tragetConfig.Path)

	AssetUtil.LoadImage(self, bgPath, ActivityImageObj:GetComponent("Image"))

	local button = ActivityImageObj:GetComponent("Button")

	if button == nil then
		logError("Can not find button named : ")
	end

	button.onClick:RemoveAllListeners()
	button.onClick:AddListener(function()
		self:ImageActivityClick(self.curConfig[index].Skip)
	end)
end

function PayActivityPanel:OnPageReachedMain(page)
	self.currentPage = page.index + 1

	if self.OldIndex then
		self.ActivityTable.ItemIndexObjTable[self.OldIndex]:SetActive(false)
	end

	self.ActivityTable.ItemIndexObjTable[self.currentPage]:SetActive(true)

	self.OldIndex = self.currentPage
	self.DoMoveIndex = self.currentPage
end

function PayActivityPanel:onBeginDrag()
	self:TimerClose()

	self.isDrag = true
end

function PayActivityPanel:OnDrag()
	return
end

function PayActivityPanel:OnEndDrag()
	self.isDrag = false

	self:RunData()
end

function PayActivityPanel:ImageActivityClick(Id)
	log("当前打印的Id是：：   " .. Id)
	JumpModule.Jump(Id)
end

function PayActivityPanel:InitData()
	self.TurnToForward = true
	self.curConfig = {}
	self.curConfigid = 1
	self.DoMoveIndex = 1
	self.Offset = 271.5
	self.DOMoveAni = {}
	self.ActivityTable = {
		ItemIndexObjTable = {},
		GridCellSizeXTable = {
			0,
			0,
			95,
			70.5,
			56.2,
			46.4,
			39.5,
			34.3,
			30,
			27
		}
	}
	self.PayActivityBgChangeRoot_Grid = self.PayActivityBgChangeRoot.gameObject:GetComponent("GridLayoutGroup")
end

function PayActivityPanel:InitConfig()
	for i, v in pairsCfg(CfgPayActivityTable) do
		self.curConfig[i] = {}
		self.curConfig[i].Id = v.Id
		self.curConfig[i].Path = v.Path
		self.curConfig[i].Des = v.Des
		self.curConfig[i].Skip = v.Skip
	end

	self.PayActivityBgChangeRoot_Grid.cellSize = Vector2.New(self.ActivityTable.GridCellSizeXTable[#self.curConfig], 4.7)

	for i = 1, #self.curConfig do
		local indexObj = self.PayActivityBgChangeRoot.gameObject.transform:GetChild(i - 1).gameObject

		indexObj:SetActive(true)

		local indexObjRed = indexObj.transform:Find("red").gameObject

		table.insert(self.ActivityTable.ItemIndexObjTable, indexObjRed)
	end
end

function PayActivityPanel:TimerClose()
	if self.timer ~= nil then
		self.timer:Stop()
	end

	self.timer = nil
end

function PayActivityPanel:RunData()
	self:TimerClose()

	self.timer = Timer.New(self.delegateShowNextPage, 3, 0)

	self.timer:Start()
end

function PayActivityPanel:SetData(isRight)
	if self.scrollList.loop == false and self.currentPage == #self.curConfig then
		self.TurnToForward = false
	end

	if self.scrollList.loop == false and self.currentPage == 1 then
		self.TurnToForward = true
	end

	if self.TurnToForward then
		self.scrollList:TurnToForward()
	else
		self.scrollList:TurnToBackward()
	end

	self:RunData()
end

function PayActivityPanel:Close()
	self:TimerClose()
end

function PayActivityPanel:Dispose()
	log(" PayActivityPanel:Dispose()   ")
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.curConfig = nil
	self.curConfigid = nil
end

return PayActivityPanel
