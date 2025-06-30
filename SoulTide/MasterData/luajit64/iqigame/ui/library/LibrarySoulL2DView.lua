-- chunkname: @IQIGame\\UI\\Library\\LibrarySoulL2DView.lua

local LibrarySoulL2DView = {}
local Live2DHarmoniousMask = require("IQIGame.UI.Common.Live2DHarmoniousMask")

function LibrarySoulL2DView.New(go)
	local o = Clone(LibrarySoulL2DView)

	o:Initialize(go)

	return o
end

function LibrarySoulL2DView:Initialize(go)
	self.View = go

	LuaCodeInterface.BindOutlet(go, self)

	self.cvFrame = CvUIFrame.New(self.goCvFrame.transform:GetChild(0).gameObject)
	self.l2dBuilder = self.goTemplate:GetComponent("L2DBuilderSoulHandbook")
	self.live2DHarmoniousMask = Live2DHarmoniousMask.New(self.goTemplate)

	function self.dgtOnSoulChanged(soulCid)
		self:OnSoulChanged(soulCid)
	end

	function self.dgtOnDressWearSuccess(dressCid)
		self:OnDressWearSuccess(dressCid)
	end
end

function LibrarySoulL2DView:Refresh(soulData)
	self.soulData = soulData

	self:RefreshL2D(self.soulData)
	self:AddListeners()
end

function LibrarySoulL2DView:DoAction(actionId)
	self.l2dBuilder:DoAction(actionId)
end

function LibrarySoulL2DView:Dispose()
	self.soulData = nil

	self.cvFrame:Dispose()
	self:RemoveListeners()
end

function LibrarySoulL2DView:OnDestroy()
	self.cvFrame:OnDestroy()
	self.live2DHarmoniousMask:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function LibrarySoulL2DView:AddListeners()
	EventDispatcher.AddEventListener(EventID.SoulChanged, self.dgtOnSoulChanged)
	EventDispatcher.AddEventListener(EventID.DressWearSuccess, self.dgtOnDressWearSuccess)
end

function LibrarySoulL2DView:RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.SoulChanged, self.dgtOnSoulChanged)
	EventDispatcher.RemoveEventListener(EventID.DressWearSuccess, self.dgtOnDressWearSuccess)
end

function LibrarySoulL2DView:OnSoulChanged(soulCid)
	self.soulData = SoulModule.soulDataDic[soulCid]

	self:RefreshL2D(self.soulData)
end

function LibrarySoulL2DView:OnDressWearSuccess(dressCid)
	self:RefreshL2D(self.soulData)
end

function LibrarySoulL2DView:RefreshL2D(soulData)
	if soulData ~= nil then
		local cfgSoulResRow = soulData:GetCfgSoulRes2D()

		self.l2dBuilder.onShowCvUI = self.cvFrame.dgtOnShowCVUI
		self.l2dBuilder.onHideCvUI = self.cvFrame.dgtOnHideCVUI

		SoulModule.BuildL2D(self.l2dBuilder, soulData, soulData:GetCfgDress2D())
		self:SetL2DModelProperty(cfgSoulResRow)
		self.cvFrame:RefreshView(Vector3.New(cfgSoulResRow.BookDialoguePosition[1], cfgSoulResRow.BookDialoguePosition[2], cfgSoulResRow.BookDialoguePosition[3]))
	end
end

function LibrarySoulL2DView:SetL2DModelProperty(cfgSoulResRow)
	self.l2dBuilder:SetModelPositionInImage(cfgSoulResRow.Live2DBookModelPosition[1], cfgSoulResRow.Live2DBookModelPosition[2], cfgSoulResRow.Live2DBookModelPosition[3])
end

function LibrarySoulL2DView:Pause()
	self.l2dBuilder:PauseL2D()
end

function LibrarySoulL2DView:OnResumeL2D()
	self.l2dBuilder:ResumeL2D()
end

return LibrarySoulL2DView
