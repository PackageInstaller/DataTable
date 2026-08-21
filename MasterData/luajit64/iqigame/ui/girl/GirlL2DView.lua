-- chunkname: @IQIGame\\UI\\Girl\\GirlL2DView.lua

GirlL2DView = {}

local Live2DHarmoniousMask = require("IQIGame.UI.Common.Live2DHarmoniousMask")

function GirlL2DView.New(go)
	local o = Clone(GirlL2DView)

	o:Initialize(go)

	return o
end

function GirlL2DView:Initialize(go)
	self.View = go

	LuaCodeInterface.BindOutlet(go, self)

	self.cvFrame = CvUIFrame.New(self.goCvFrame.transform:GetChild(0).gameObject, Constant.UIControllerName.GirlUI)
	self.l2dBuilder = self.goTemplate:GetComponent("L2DBuilderGirl")
	self.live2DHarmoniousMask = Live2DHarmoniousMask.New(self.goTemplate)

	function self.dgtOnSoulChanged(soulCid)
		self:OnSoulChanged(soulCid)
	end

	function self.dgtOnDressWearSuccess(dressCid)
		self:OnDressWearSuccess(dressCid)
	end
end

function GirlL2DView:Refresh(soulData)
	self.soulData = soulData

	self:RefreshL2D(self.soulData)
	self:AddListeners()
end

function GirlL2DView:Pause()
	self.l2dBuilder:PauseL2D()
end

function GirlL2DView:Dispose()
	self.soulData = nil

	self.cvFrame:Dispose()
	self.live2DHarmoniousMask:Dispose()
	self:RemoveListeners()
end

function GirlL2DView:OnDestroy()
	self.cvFrame:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function GirlL2DView:AddListeners()
	EventDispatcher.AddEventListener(EventID.SoulChanged, self.dgtOnSoulChanged)
	EventDispatcher.AddEventListener(EventID.DressWearSuccess, self.dgtOnDressWearSuccess)
end

function GirlL2DView:RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.SoulChanged, self.dgtOnSoulChanged)
	EventDispatcher.RemoveEventListener(EventID.DressWearSuccess, self.dgtOnDressWearSuccess)
end

function GirlL2DView:OnSoulChanged(soulCid)
	self.soulData = SoulModule.soulDataDic[soulCid]

	self:RefreshL2D(self.soulData)
end

function GirlL2DView:OnDressWearSuccess(dressCid)
	self:RefreshL2D(self.soulData)
end

function GirlL2DView:OnResumeL2D()
	self.l2dBuilder:ResumeL2D()
end

function GirlL2DView:RefreshL2D(soulData)
	if soulData ~= nil then
		local cfgSoulResRow = soulData:GetCfgSoulRes2D()

		self.l2dBuilder.onShowCvUI = self.cvFrame.dgtOnShowCVUI
		self.l2dBuilder.onHideCvUI = self.cvFrame.dgtOnHideCVUI

		SoulModule.BuildL2D(self.l2dBuilder, soulData, soulData:GetCfgDress2D())
		self:SetL2DModelProperty(cfgSoulResRow)
		self.cvFrame:RefreshView(Vector3.New(cfgSoulResRow.GirlDialoguePosition[1], cfgSoulResRow.GirlDialoguePosition[2], cfgSoulResRow.GirlDialoguePosition[3]))
	end
end

function GirlL2DView:SetL2DModelProperty(cfgSoulResRow)
	self.l2dBuilder:SetModelPositionInImage(cfgSoulResRow.Live2DGirlUIModelPosition[1], cfgSoulResRow.Live2DGirlUIModelPosition[2], cfgSoulResRow.Live2DGirlUIModelPosition[3])
end
