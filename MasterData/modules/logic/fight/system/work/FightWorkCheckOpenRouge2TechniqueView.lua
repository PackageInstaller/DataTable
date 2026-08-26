-- chunkname: @modules/logic/fight/system/work/FightWorkCheckOpenRouge2TechniqueView.lua

module("modules.logic.fight.system.work.FightWorkCheckOpenRouge2TechniqueView", package.seeall)

local FightWorkCheckOpenRouge2TechniqueView = class("FightWorkCheckOpenRouge2TechniqueView", BaseWork)

function FightWorkCheckOpenRouge2TechniqueView:ctor()
	return
end

local Career2TechniqueIdDict = {
	[FightEnum.Rouge2Career.Strings] = 18,
	[FightEnum.Rouge2Career.TubularBell] = 19,
	[FightEnum.Rouge2Career.Cymbal] = 18,
	[FightEnum.Rouge2Career.Slapstick] = 21
}

function FightWorkCheckOpenRouge2TechniqueView:onStart()
	if FightDataHelper.stateMgr.isReplay then
		return self:onDone(true)
	end

	if ViewMgr.instance:isOpen(ViewName.FightQuitTipView) then
		return self:onDone(true)
	end

	if not FightDataHelper.fieldMgr:isRouge2() then
		return self:onDone(true)
	end

	local career = FightHelper.getRouge2Career()

	if not career then
		return self:onDone(true)
	end

	if self:checkRecordedCareer(career) then
		return self:onDone(true)
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self:recordCareer(career)

	local id = Career2TechniqueIdDict[career]

	Rouge2_Controller.instance:openTechniqueView(id)
end

function FightWorkCheckOpenRouge2TechniqueView:checkRecordedCareer(career)
	if not career then
		return false
	end

	local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Rouge2RecordCareer)
	local recordCareer = PlayerPrefsHelper.getString(key)

	if string.nilorempty(recordCareer) then
		return false
	end

	local careerList = string.splitToNumber(recordCareer, ";")

	for i, v in ipairs(careerList) do
		if v == career then
			return true
		end
	end

	return false
end

function FightWorkCheckOpenRouge2TechniqueView:recordCareer(career)
	if not career then
		return
	end

	local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Rouge2RecordCareer)
	local recordCareer = PlayerPrefsHelper.getString(key)

	if string.nilorempty(recordCareer) then
		PlayerPrefsHelper.setString(key, tostring(career))

		return
	end

	local careerList = string.format("%s;%d", recordCareer, career)

	PlayerPrefsHelper.setString(key, careerList)
end

function FightWorkCheckOpenRouge2TechniqueView:_onCloseViewFinish(viewName)
	if viewName == ViewName.FightRouge2TechniqueView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseViewFinish, self)
		self:onDone(true)
	end
end

function FightWorkCheckOpenRouge2TechniqueView:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseViewFinish, self)
end

return FightWorkCheckOpenRouge2TechniqueView
