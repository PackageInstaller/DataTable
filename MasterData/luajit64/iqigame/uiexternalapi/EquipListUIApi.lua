-- chunkname: @IQIGame\\UIExternalApi\\EquipListUIApi.lua

EquipListUIApi = BaseLangApi:Extend()

function EquipListUIApi:Init()
	self:RegisterApi("goTitle1", self.GetTitle1)
	self:RegisterApi("goBtnSort", self.GetBtnSortTxt)
	self:RegisterApi("goBtnBatchDecompose", self.GetBtnBatchDecomposeTxt)
	self:RegisterApi("goBtnDecompose", self.GetBtnDecomposeTxt)
	self:RegisterApi("goBtnCancel", self.GetBtnCancelTxt)
	self:RegisterApi("goViewTitle", self.GetViewTitle)
	self:RegisterApi("toggleLockTxt", self.GetToggleLockTxt)
	self:RegisterApi("toggleLockCancelTxt", self.GetToggleLockCancelTxt)
	self:RegisterApi("decomposeToggleQuality", self.GetDecomposeToggleQuality)
	self:RegisterApi("decomposeToggleTxt", self.GetDecomposeToggleTxt)
	self:RegisterApi("goSortTxt", self.GetSortTxt)
	self:RegisterApi("goBtnFilterTxt", self.GetBtnFilterTxt)
	self:RegisterApi("goNum", self.GetNum)
	self:RegisterApi("goDesc", self.GetDesc)
	self:RegisterApi("goDesc2", self.GetDesc2)
	self:RegisterApi("goDesc3", self.GetDesc3)
	self:RegisterApi("SignEmptyDesc", self.GetSignEmptyDesc)
	self:RegisterApi("sortViewTitle", self.GetSortViewTitle)
	self:RegisterApi("sortViewSortTitle_1", self.GetSortViewSortTitle_1)
	self:RegisterApi("sortViewSortTitle_2", self.GetSortViewSortTitle_2)
	self:RegisterApi("sortViewBtnSortTxt_1", self.GetSortViewBtnSortTxt_1)
	self:RegisterApi("sortViewBtnSortTxt_2", self.GetSortViewBtnSortTxt_2)
	self:RegisterApi("sortViewBtnCancelTxt", self.GetSortViewBtnCancelTxt)
	self:RegisterApi("sortViewBtnSureTxt", self.GetSortViewBtnSureTxt)
	self:RegisterApi("screenViewSortTitle_1", self.GetScreenViewSortTitle_1)
	self:RegisterApi("screenViewSortTitle_2", self.GetScreenViewSortTitle_2)
	self:RegisterApi("screenViewSortTitle_3", self.GetScreenViewSortTitle_3)
	self:RegisterApi("screenViewEquipStateTxt", self.GetEquipStateTxt)
	self:RegisterApi("screenViewBtnCancelTxt", self.GetScreenViewBtnCancelTxt)
	self:RegisterApi("screenViewBtnSureTxt", self.GetScreenViewBtnSureTxt)
end

function EquipListUIApi:GetScreenViewBtnCancelTxt()
	return self:GetCfgText(2000001)
end

function EquipListUIApi:GetScreenViewBtnSureTxt()
	return self:GetCfgText(1314327)
end

function EquipListUIApi:GetEquipStateTxt(index)
	if index == 1 then
		return self:GetCfgText(1314334)
	elseif index == 2 then
		return self:GetCfgText(1314335)
	end
end

function EquipListUIApi:GetScreenViewSortTitle_3()
	return self:GetCfgText(1211042)
end

function EquipListUIApi:GetScreenViewSortTitle_2()
	return self:GetCfgText(1314336)
end

function EquipListUIApi:GetScreenViewSortTitle_1()
	return self:GetCfgText(1314318)
end

function EquipListUIApi:GetDecomposeToggleQuality()
	return {
		2,
		3,
		4
	}
end

function EquipListUIApi:GetDecomposeToggleTxt(quality)
	if quality == 1 then
		return self:GetCfgText(1314313)
	elseif quality == 2 then
		return "N"
	elseif quality == 3 then
		return "R"
	elseif quality == 4 then
		return "SR"
	elseif quality == 5 then
		return "SSR"
	else
		return ""
	end
end

function EquipListUIApi:GetNum(curCount, totalCount)
	if curCount > 0 then
		return tostring(curCount) .. "/" .. tostring(totalCount)
	else
		return "0" .. "/" .. tostring(totalCount)
	end
end

function EquipListUIApi:GetDesc2()
	return self:GetCfgText(1314293)
end

function EquipListUIApi:GetSignEmptyDesc()
	return self:GetCfgText(1314333)
end

function EquipListUIApi:GetDesc3()
	return self:GetCfgText(1314294)
end

function EquipListUIApi:GetDesc()
	return self:GetCfgText(1314309)
end

function EquipListUIApi:GetSortTxt()
	return self:GetCfgText(1314325)
end

function EquipListUIApi:GetBtnFilterTxt()
	return self:GetCfgText(1314310)
end

function EquipListUIApi:GetSortViewBtnCancelTxt()
	return self:GetCfgText(1314326)
end

function EquipListUIApi:GetSortViewBtnSureTxt()
	return self:GetCfgText(1314327)
end

function EquipListUIApi:GetSortViewBtnSortTxt_1(index)
	if index == 1 then
		return self:GetCfgText(1314318)
	elseif index == 2 then
		return self:GetCfgText(1314319)
	elseif index == 3 then
		return self:GetCfgText(1314320)
	elseif index == 4 then
		return self:GetCfgText(1314290)
	elseif index == 5 then
		return self:GetCfgText(1314291)
	end
end

function EquipListUIApi:GetSortViewBtnSortTxt_2(index)
	if index == 1 then
		return self:GetCfgText(1314328)
	elseif index == 2 then
		return self:GetCfgText(1314329)
	end
end

function EquipListUIApi:GetSortViewSortTitle_1()
	return self:GetCfgText(1314330)
end

function EquipListUIApi:GetSortViewSortTitle_2()
	return self:GetCfgText(1314331)
end

function EquipListUIApi:GetSortViewTitle()
	return self:GetCfgText(1314332)
end

function EquipListUIApi:GetViewTitle()
	return self:GetCfgText(1314301)
end

function EquipListUIApi:GetToggleLockTxt()
	return self:GetCfgText(1314292)
end

function EquipListUIApi:GetToggleLockCancelTxt()
	return self:GetCfgText(1314323)
end

function EquipListUIApi:GetTitle1()
	return self:GetCfgText(1314310)
end

function EquipListUIApi:GetBtnSortTxt(index)
	if index == 0 then
		return self:GetCfgText(1314312)
	elseif index == 1 then
		return "N"
	elseif index == 2 then
		return "N"
	elseif index == 3 then
		return "R"
	elseif index == 4 then
		return "SR"
	elseif index == 5 then
		return "SSR"
	end
end

function EquipListUIApi:GetBtnBatchDecomposeTxt()
	return self:GetCfgText(1314321)
end

function EquipListUIApi:GetBtnDecomposeTxt()
	return self:GetCfgText(1314322)
end

function EquipListUIApi:GetBtnCancelTxt()
	return self:GetCfgText(1314323)
end

EquipListUIApi:Init()
