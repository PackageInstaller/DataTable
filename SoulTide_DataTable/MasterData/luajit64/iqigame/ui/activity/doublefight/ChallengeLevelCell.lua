-- chunkname: @IQIGame\\UI\\Activity\\DoubleFight\\ChallengeLevelCell.lua

local m = {
	isUnlock = false
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:SetSelect(false)
end

function m:SetDate(data, index, isUnlock, operateEventID)
	self.cfgDoubleFightGlobal = data
	self.index = index
	self.operateEventID = operateEventID
	self.cfgID = self.cfgDoubleFightGlobal.FightList[self.index]
	self.isUnlock = isUnlock

	self.nodeLock:SetActive(not self.isUnlock)
	UGUIUtil.SetText(self.TextUp, ActivityUIApi:GetString("InvasionTextUp", self.index))
	UGUIUtil.SetText(self.TextDown, ActivityUIApi:GetString("InvasionTextDown", self.index))
	UGUIUtil.SetText(self.TextLock, ActivityUIApi:GetString("InvasionTextLock", self.index, self.cfgDoubleFightGlobal.UnlockScore[self.index]))

	local isRed = ActiveDoubleFightModule.CheckDoubleFightListRedPoint(self.operateEventID, self.cfgID)

	self.RedPoint:SetActive(isRed)
end

function m:SetSelect(top)
	if self.isUnlock then
		self.nodeDown:SetActive(not top)
		self.nodeUp:SetActive(top)
	end
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
