-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballBuildItem.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballBuildItem", package.seeall)

local PinballBuildItem = class("PinballBuildItem", LuaCompBase)

function PinballBuildItem:init(go)
	self.go = go
	self._goselect = gohelper.findChild(go, "#go_select")
	self._imageicon = gohelper.findChildSingleImage(go, "#image_icon")
	self._godone = gohelper.findChild(go, "#go_done")
	self._golock = gohelper.findChild(go, "#go_lock")
	self._txtname = gohelper.findChildTextMesh(go, "#txt_name")
end

function PinballBuildItem:initData(data, index)
	self._data = data
	self._index = index
	self._txtname.text = self._data.name

	gohelper.setActive(self._golock, self:isLock())
	gohelper.setActive(self._godone, self:isDone())
end

function PinballBuildItem:isDone()
	local nowNum = PinballModel.instance:getBuildingNum(self._data.id)

	if nowNum >= self._data.limit then
		return true
	end

	return false
end

function PinballBuildItem:isLock(isToast)
	local condition = self._data.condition

	if string.nilorempty(condition) then
		return false
	end

	local dict = GameUtil.splitString2(condition, true)

	for _, arr in pairs(dict) do
		local type = arr[1]

		if type == PinballEnum.ConditionType.Talent then
			local talentId = arr[2]

			if not PinballModel.instance:getTalentMo(talentId) then
				if isToast then
					local talentCo = lua_activity178_talent.configDict[VersionActivity2_4Enum.ActivityId.Pinball][talentId]

					GameFacade.showToast(ToastEnum.Act178TalentCondition, talentCo.name)
				end

				return true
			end
		elseif type == PinballEnum.ConditionType.Score then
			local value = arr[2]

			if value > PinballModel.instance.maxProsperity then
				if isToast then
					local lv = PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, value)

					GameFacade.showToast(ToastEnum.Act178ScoreCondition, lv)
				end

				return true
			end
		end
	end

	return false
end

function PinballBuildItem:setSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)

	local isDone = self:isDone()
	local stage = 1

	if not isDone and not isSelect then
		stage = 1
	elseif isDone and not isSelect then
		stage = 2
	elseif isDone and isSelect then
		stage = 3
	elseif not isDone and isSelect then
		stage = 4
	end

	local icon = self._data.icon

	self._imageicon:LoadImage(string.format("singlebg/v2a4_tutushizi_singlebg/building/%s_%s.png", icon, stage))
end

return PinballBuildItem
