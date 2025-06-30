-- chunkname: @IQIGame\\UI\\GirlChoose\\GirlChooseCell.lua

GirlChooseCell = {}

function GirlChooseCell.New(go, type)
	local o = Clone(GirlChooseCell)

	o:Initialize(go, type)

	return o
end

function GirlChooseCell:Initialize(go, type)
	self.View = go

	LuaCodeInterface.BindOutlet(self.View, self)

	local goHead = self.goHeadParent.transform:GetChild(0).gameObject
	local cellView = {}

	LuaCodeInterface.BindOutlet(goHead, cellView)

	self.type = type
	self.goImgSelected = cellView.goCheck
	self.imgSelected = self.goImgSelected:GetComponent("Image")
	goHead:GetComponent("Button").enabled = false
	self.headCell = SoulHeadCell.New(goHead, false, true)

	self.redPoint:SetActive(false)
	self.Oath:SetActive(false)

	function self.delegateUpdateGirUIRedPoint(soulCid)
		self:UpdateRedPoint(soulCid)
	end

	function self.delegateOathSuccess(soulCid)
		self:OnUpdateOath(soulCid)
	end

	EventDispatcher.AddEventListener(EventID.RedGirlChooseCell, self.delegateUpdateGirUIRedPoint)
	EventDispatcher.AddEventListener(EventID.SoulCompleteOathSuccess, self.delegateOathSuccess)
	LuaCodeInterface.ClearOutlet(goHead, cellView)
end

function GirlChooseCell:OnDestroy()
	EventDispatcher.RemoveEventListener(EventID.RedGirlChooseCell, self.delegateUpdateGirUIRedPoint)
	EventDispatcher.RemoveEventListener(EventID.SoulCompleteOathSuccess, self.delegateOathSuccess)
	self.headCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function GirlChooseCell:CheckRed()
	if self.redPoint ~= nil then
		local isMemoryRed = GirlModule.CheckRedMemory(self.soulData.soulCid) and UnlockFunctionModule.IsUnlock(Constant.UnlockType.MEMORY)
		local isNewMemoryRed = MemoryNewModule.CheckRedNewMemory(self.soulData.soulCid) and UnlockFunctionModule.IsUnlock(Constant.UnlockType.NEWSTORY)
		local isDating = DatingModule.DatingSoulIsRed(self.soulData.soulCid) and UnlockFunctionModule.IsUnlock(Constant.UnlockType.DATING)
		local s = " " .. self.soulData.soulCid

		if isMemoryRed then
			s = s .. " 回忆"
		end

		if isNewMemoryRed then
			s = s .. " 新篇"
		end

		if isDating then
			s = s .. " 约会"
		end

		if not isMemoryRed and not isNewMemoryRed and isDating then
			-- block empty
		end

		local show = isMemoryRed or isNewMemoryRed or isDating

		if self.type == 1 then
			self.redPoint:SetActive(show)
		end

		RedModule.SetClientRed(Constant.RedClientType.SoulChooseCellRed, {
			id = self.soulData.soulCid,
			value = show
		})
	end
end

function GirlChooseCell:CheckOath()
	local isActivate = self.soulData.oathActivation

	self.Oath:SetActive(isActivate)

	if self.headCell.ImgOath then
		self.headCell.ImgOath:SetActive(isActivate)
	end

	if self.headCell.ImgNormal then
		self.headCell.ImgNormal:SetActive(not isActivate)
	end
end

function GirlChooseCell:OnRenderCell(soulData)
	self.soulData = soulData

	self.headCell:RefreshView(self.soulData)
	self:CheckRed()
	self:CheckOath()
end

function GirlChooseCell:OnUpdateOath(soulCid)
	if self.soulData ~= nil and self.soulData.soulCid == soulCid then
		self:CheckOath()
	end
end

function GirlChooseCell:UpdateRedPoint(soulCid)
	if self.soulData ~= nil and self.soulData.soulCid == soulCid then
		self:CheckRed()
	end
end

function GirlChooseCell:OnClickCell(soulData)
	self:OnSelected()
end

function GirlChooseCell:OnSelected()
	self.View.transform.localScale = GirlUIApi:GetString("SoulHeadScale", true)

	self.goImgSelected:SetActive(true)
	RedModule.SetClientRed(Constant.RedClientType.SoulChooseCellRed, {
		id = self.soulData.soulCid,
		value = self.redPoint.activeInHierarchy
	})
end

function GirlChooseCell:OnUnselected()
	self.View.transform.localScale = GirlUIApi:GetString("SoulHeadScale", false)

	self.goImgSelected:SetActive(false)
end
