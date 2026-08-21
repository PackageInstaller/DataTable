-- chunkname: @IQIGame\\UI\\HomeLandPlant\\HomeLandPlantDragCell.lua

local m = {}
local HomeLandPlantTimeCell = require("IQIGame.UI.HomeLand.HomeLandPlantTimeCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	local timeCellObj = self.View.transform:Find("PlantTimeMould").gameObject

	self.timeCellBtn = timeCellObj:GetComponent("Button")
	self.timeCell = HomeLandPlantTimeCell.New(timeCellObj, true)

	function self.delegateOnBtnTimeCell()
		self:OnBtnTimeCell()
	end

	self:AddListener()
end

function m:SetDecorateCid(cid)
	self:ShowTimeCell(true)

	self.decorateCid = cid

	self.timeCell:UpdateView(self.decorateCid)

	self.View.transform:GetChild(0).gameObject.name = tostring(cid)
end

function m:AddListener()
	self.timeCellBtn.onClick:AddListener(self.delegateOnBtnTimeCell)
end

function m:RemoveListener()
	self.timeCellBtn.onClick:RemoveListener(self.delegateOnBtnTimeCell)
end

function m:OnBtnTimeCell()
	if self.clickTimeCellBack then
		self.clickTimeCellBack(self.decorateCid)
	end
end

function m:ShowTimeCell(top)
	self.timeCell.View:SetActive(top)
end

function m:Dispose()
	self:RemoveListener()
	self.timeCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
