-- chunkname: @IQIGame\\UI\\GhostGame\\GhostGameBuffItem.lua

local m = {}

function m.New(view, fatherView)
	local obj = Clone(m)

	obj:Init(view, fatherView)

	return obj
end

function m:Init(view, fatherView)
	self.View = view
	self.fatherView = fatherView

	LuaCodeInterface.BindOutlet(self.View, self)

	self.maskCom = self.mask:GetComponent("Image")
end

function m:SetData(buff)
	self:Show()

	self.buffData = buff
	self.maskCom.fillAmount = 1
	self.buffTime = buff.duration

	AssetUtil.LoadImage(self, self.buffData.buffCfg.Icon, self.buffImg:GetComponent("Image"))
end

function m:Update(elapseSeconds, realElapseSeconds)
	if GhostGameModule.IsPause then
		return
	end

	if self.buffTime <= 0 then
		self.fatherView:RecoveryBuffItem(self.buffData.type)

		return
	end

	self.buffTime = self.buffTime - elapseSeconds
	self.maskCom.fillAmount = 1 - self.buffTime / self.buffData.duration
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self.maskCom = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
