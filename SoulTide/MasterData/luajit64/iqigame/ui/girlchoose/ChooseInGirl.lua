-- chunkname: @IQIGame\\UI\\GirlChoose\\ChooseInGirl.lua

ChooseInGirl = {}

function ChooseInGirl.New()
	local o = Clone(ChooseInGirl)

	return o
end

function ChooseInGirl:Refresh(soulData)
	self.curSoulData = soulData
end

function ChooseInGirl:Dispose()
	self.curSoulData = nil
end

function ChooseInGirl:OnRenderCell(headCell)
	self:RefreshCellState(headCell)
end

function ChooseInGirl:OnClickCell(headCell)
	self.curSoulData = headCell.soulData

	local soulCid = self.curSoulData.soulCid

	EventDispatcher.Dispatch(EventID.SoulChanged, soulCid)
end

function ChooseInGirl:RefreshCellState(headCell)
	if headCell.soulData.soulCid == self.curSoulData.soulCid then
		headCell:OnSelected()
	else
		headCell:OnUnselected()
	end
end

function ChooseInGirl:CheckCanClickCell(soulData)
	return self.curSoulData.soulCid ~= soulData.soulCid
end
