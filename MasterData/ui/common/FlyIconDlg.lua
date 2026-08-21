-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\FlyIconDlg.lua

local strClassName = "FlyIconDlg"
local FlyIconDlg = Class(strClassName, UIControls.Window)
local FlyIconPoolType = typeof(Framework.UI.FlyIconPool)

function FlyIconDlg:ctor(...)
	self:initUI()
end

function FlyIconDlg:initUI(...)
	local moneyPoolTransform = self:getController().transform:Find("MoneyIconPool")

	self.splitPool = moneyPoolTransform:GetComponent(FlyIconPoolType)

	if self.splitPool then
		self.splitPool:Init(UIConst.FLY_ITEM_TYPE_ICON)
		self.splitPool:SetEndCallback(Slot(self._onAllSplitEnd, self))
	end

	local itemPoolTransform = self:getController().transform:Find("ItemIconPool")

	self.commonPool = itemPoolTransform:GetComponent(FlyIconPoolType)

	if self.commonPool then
		self.commonPool:Init(UIConst.FLY_ITEM_TYPE_ICON)
		self.commonPool:SetEndCallback(Slot(self._onAllItemEnd, self))
	end

	local effectPoolTransform = self:getController().transform:Find("EffectPool")

	self.effectPool = effectPoolTransform:GetComponent(FlyIconPoolType)

	if self.effectPool then
		self.effectPool:Init(UIConst.FLY_ITEM_TYPE_EFFECT)
		self.effectPool:SetEndCallback(Slot(self._onEffectEnd, self))
	end
end

function FlyIconDlg:addEndCallBack(cb)
	self.endCB = cb
end

function FlyIconDlg:setFlyType(needSplit)
	if needSplit > 1 then
		self.currentPool = self.splitPool

		self.splitPool:SetSplitNum(needSplit)

		self.allSplitEnd = nil
	else
		self.currentPool = self.commonPool
		self.allItemEnd = nil
	end
end

function FlyIconDlg:setFlyData(iconPath, spriteName, startWorldPos, endWorldPos, needSplit, scale)
	self:setFlyType(needSplit)

	local data = {
		startPos = startWorldPos,
		endPos = endWorldPos,
		iconPath = iconPath,
		spriteName = spriteName,
		scale = tostring(scale or 1)
	}

	self.currentPool:ShowFlyItem(data)
end

function FlyIconDlg:setFlyEffectData(startWorldPos, endWorldPos, effectPath, scale)
	local data = {
		startPos = startWorldPos,
		endPos = endWorldPos,
		effectPath = effectPath or "",
		scale = tostring(scale or 1)
	}

	self.effectPool:ShowFlyItem(data)
end

function FlyIconDlg:_onAllSplitEnd(...)
	self.allSplitEnd = true

	if self.allSplitEnd and self.allItemEnd then
		self:_onAllEnd()
	end

	self:_tryCallBack()
end

function FlyIconDlg:_onAllItemEnd(...)
	self.allItemEnd = true

	if self.allSplitEnd and self.allItemEnd then
		self:_onAllEnd()
	end

	self:_tryCallBack()
end

function FlyIconDlg:_onAllEnd()
	self:setVisible(false)
	self:_tryCallBack()
end

function FlyIconDlg:_onEffectEnd()
	self:setVisible(false)
	self:_tryCallBack()
end

function FlyIconDlg:_tryCallBack()
	if self.endCB then
		self.endCB()

		self.endCB = nil
	end
end

return FlyIconDlg
