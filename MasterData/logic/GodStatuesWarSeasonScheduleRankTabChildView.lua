-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarSeasonScheduleRankTabChildView.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarSeasonScheduleRankTabChildView", package.seeall)

local GodStatuesWarSeasonScheduleRankTabChildView = class("GodStatuesWarSeasonScheduleRankTabChildView", ViewComponent)
local FamilyCountInGroup = 4

function GodStatuesWarSeasonScheduleRankTabChildView:buildUI()
	GodStatuesWarSeasonScheduleRankTabChildView.super.buildUI(self)

	self._groupCellTopCol = self:getGo("rankView/scrView/Viewport/Content/topStepCell/groupCell")
	self._topStepCell = self:getGo("rankView/scrView/Viewport/Content/topStepCell")
	self._16To4StepCell = self:getGo("rankView/scrView/Viewport/Content/16To4StepCell")
	self._64to16StepCell = self:getGo("rankView/scrView/Viewport/Content/64to16StepCell")
	self._emptyTopStepCell = self:getGo("rankView/scrView/Viewport/Content/emptyTopStepCell")
	self._empty64to16StepCell = self:getGo("rankView/scrView/Viewport/Content/empty64to16StepCell")
	self._empty16To4StepCell = self:getGo("rankView/scrView/Viewport/Content/empty16To4StepCell")
	self._txtEmptyTopStepCell = self:getTxt("rankView/scrView/Viewport/Content/emptyTopStepCell/oepnTime/txt")
	self._txtEmpty64to16StepCell = self:getTxt("rankView/scrView/Viewport/Content/empty64to16StepCell/oepnTime/txt")
	self._txtEmpty16To4StepCell = self:getTxt("rankView/scrView/Viewport/Content/empty16To4StepCell/oepnTime/txt")
end

function GodStatuesWarSeasonScheduleRankTabChildView:bindEvents()
	GodStatuesWarSeasonScheduleRankTabChildView.super.bindEvents(self)
end

function GodStatuesWarSeasonScheduleRankTabChildView:unbindEvents()
	GodStatuesWarSeasonScheduleRankTabChildView.super.unbindEvents(self)
end

function GodStatuesWarSeasonScheduleRankTabChildView:onEnter()
	GodStatuesWarSeasonScheduleRankTabChildView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])
	self._gswMo = GodStatuesWarController.instance:getGswMo(self._seasonId)

	self.addGEvent(self, GlobalNotify.handlePM_NewFamilyBattleGetSpaceGroupInfoRes, self._onUpdate, self)
	self:_onUpdate()
	GodStatuesWarController.instance:sendPM_NewFamilyBattleGetSpaceGroupInfoReq(self._seasonId)
end

function GodStatuesWarSeasonScheduleRankTabChildView:onExit()
	GodStatuesWarSeasonScheduleRankTabChildView.super.onExit(self)
	self:_onClear()
end

function GodStatuesWarSeasonScheduleRankTabChildView:_onUpdate()
	local msg = self._gswMo:getSpaceGroupInfoMsg()

	self._familySimpleInfos = {}

	if msg then
		for _, v in ipairs(msg.familySimpleInfoList) do
			self._familySimpleInfos[v.familyId] = v
		end
	end

	self._stepInfos = {}

	if msg then
		for _, v in ipairs(msg.stepList) do
			self._stepInfos[v.step] = v
		end
	end

	self._curStep = GodStatuesWarController.instance:getCurStepOfGsw(self._seasonId)
	self._myFamilyId = FamilyModel.instance:getFamilyId()

	self:_onUpdateTopColUI()
	self:_onUpdateGroupColUI()
end

function GodStatuesWarSeasonScheduleRankTabChildView:_onClear()
	return
end

function GodStatuesWarSeasonScheduleRankTabChildView:_onUpdateTopColUI()
	local isInStep = self._curStep >= GswEnum.Steps_Final

	GameUtil.SetActive(self._emptyTopStepCell, not isInStep)
	GameUtil.SetActive(self._topStepCell, isInStep)

	if not isInStep then
		local step = GswEnum.Steps_Final
		local stepData = GodStatuesWarConfig.instance:getNfbStepData(self._seasonId, step)
		local fields = GodStatuesWarController.instance:getStepIntervalTimeFields(self._seasonId, step, GswEnum.StepInterval_FmtPre)
		local date = GameUtil.time2date((fields or nil) and GameUtil.string2time(stepData[fields[1]]))

		self._txtEmptyTopStepCell.text = string.format("%d.%02d.%02d %02d:%02d 开启", date.year, date.month, date.day, date.hour, date.min)
	else
		local stepInfo = self._stepInfos[GswEnum.Steps_Final]

		if stepInfo then
			if not stepInfo.groupList then
				local groupList = {}
				local txtOpenTime = goutil.findChildTextComponent(self._topStepCell, "oepnTime/txt")
				local step = GswEnum.Steps_Final
				local stepData = GodStatuesWarConfig.instance:getNfbStepData(self._seasonId, step)
				local startStepInterval = GodStatuesWarController.instance:getFirstStepInterval(self._seasonId, step)
				local endStepInterval = GodStatuesWarController.instance:getLastStepInterval(self._seasonId, step)
				local startFields = GodStatuesWarController.instance:getStepIntervalTimeFields(self._seasonId, step, GswEnum.StepInterval_FmtPre)
				local endFields = GodStatuesWarController.instance:getStepIntervalTimeFields(self._seasonId, step, GswEnum.StepInterval_Bat)
				local startStamp = startFields and GameUtil.string2time(stepData[startFields[1]]) or 0
				local endStamp = endFields and GameUtil.string2time(stepData[endFields[2]]) or 0
				local startDate = GameUtil.time2date(startStamp)
				local endDate = GameUtil.time2date(endStamp)

				txtOpenTime.text = string.format("比赛时间：%d.%02d.%02d %02d:%02d - %d.%02d.%02d %02d:%02d", startDate.year, startDate.month, startDate.day, startDate.hour, startDate.min, endDate.year, endDate.month, endDate.day, endDate.hour, endDate.min)

				local groupInfo = groupList[1]

				if groupInfo then
					if not groupInfo.familyIds then
						local familyIds = {}

						if groupInfo then
							if not groupInfo.energies then
								for idx = 1, self._groupCellTopCol.transform.childCount do
									local familyId = familyIds[idx]
									local mainGo = self._groupCellTopCol.transform:GetChild(idx - 1).gameObject
									local tagNil = goutil.findChild(mainGo, "tagNil")
									local headCell = goutil.findChild(mainGo, "headCell")
									local icon = goutil.findChild(mainGo, "headCell/mask/icon")
									local imgRank = goutil.findChild(mainGo, "headCell/imgRank")
									local rankGo = goutil.findChild(mainGo, "headCell/rank")
									local txtRank = goutil.findChildTextComponent(mainGo, "headCell/rank/txt")
									local txtFamilyName = goutil.findChildTextComponent(mainGo, "headCell/familyName/txt")
									local txtAreaName = goutil.findChildTextComponent(mainGo, "headCell/areaName/txt")
									local tagMe = goutil.findChild(mainGo, "headCell/tagMe")

									GameUtil.SetActive(tagNil, false)
									GameUtil.SetActive(headCell, false)

									if familyId then
										local info = self._familySimpleInfos[familyId]
										local iconId = info and info.iconId

										txtFamilyName.text = info and info.familyName
										txtAreaName.text = info and info.areaName

										local isHasResult = self._curStep > GswEnum.Steps_Final
										local isTop3 = checknumber(idx) <= 3

										GameUtil.SetActive(imgRank, isHasResult and isTop3)
										GameUtil.SetActive(rankGo, isHasResult and not isTop3)

										if isTop3 then
											GameUtil.setUIImageSpriteIdx(imgRank, idx - 1)
										end

										txtRank.text = idx

										GameUtil.setUIImageSpriteIdx(icon, iconId)
										GameUtil.SetActive(tagMe, familyId == self._myFamilyId)
										GameUtil.SetActive(headCell, true)
									else
										GameUtil.SetActive(tagNil, true)
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function GodStatuesWarSeasonScheduleRankTabChildView:_onUpdateGroupColUI()
	local stepList = {
		GswEnum.Steps_16To4,
		GswEnum.Steps_64To16
	}
	local stepCellGoList = {
		self._16To4StepCell,
		self._64to16StepCell
	}
	local emptyStepCellGoList = {
		self._empty16To4StepCell,
		self._empty64to16StepCell
	}
	local txtEmptyStepCellList = {
		self._txtEmpty16To4StepCell,
		self._txtEmpty64to16StepCell
	}

	for i, step in ipairs(stepList) do
		local stepCellGo = stepCellGoList[i]
		local emptyStepCellGo = emptyStepCellGoList[i]
		local isInStep = step <= self._curStep

		GameUtil.SetActive(emptyStepCellGo, not isInStep)
		GameUtil.SetActive(stepCellGo, isInStep)

		if not isInStep then
			local stepData = GodStatuesWarConfig.instance:getNfbStepData(self._seasonId, step)
			local fields = GodStatuesWarController.instance:getStepIntervalTimeFields(self._seasonId, step, GswEnum.StepInterval_FmtPre)
			local date = GameUtil.time2date((fields or nil) and GameUtil.string2time(stepData[fields[1]]))
			local txtEmptyStepCell = txtEmptyStepCellList[i]

			txtEmptyStepCell.text = string.format("%d%s%d%s%d%s %d:%02d 开启", date.year, lang("mail_year"), date.month, lang("mail_mon"), date.day, lang("mail_day"), date.hour, date.min)
		else
			local stepInfo = self._stepInfos[step]

			if stepInfo then
				if not stepInfo.groupList then
					local groupList = {}
					local groupView = goutil.findChild(stepCellGo, "groupView")
					local txtOpenTime = goutil.findChildTextComponent(stepCellGo, "oepnTime/txt")
					local stepData = GodStatuesWarConfig.instance:getNfbStepData(self._seasonId, step)
					local startFields = GodStatuesWarController.instance:getStepIntervalTimeFields(self._seasonId, step, GswEnum.StepInterval_FmtPre)
					local endFields = GodStatuesWarController.instance:getStepIntervalTimeFields(self._seasonId, step, GswEnum.StepInterval_Bat)
					local startStamp = startFields and GameUtil.string2time(stepData[startFields[1]]) or 0
					local endStamp = endFields and GameUtil.string2time(stepData[endFields[2]]) or 0
					local startDate = GameUtil.time2date(startStamp)
					local endDate = GameUtil.time2date(endStamp)

					txtOpenTime.text = string.format("比赛时间：%d.%02d.%02d %02d:%02d - %d.%02d.%02d %02d:%02d", startDate.year, startDate.month, startDate.day, startDate.hour, startDate.min, endDate.year, endDate.month, endDate.day, endDate.hour, endDate.min)

					for idx = 1, groupView.transform.childCount do
						local groupCellGo = groupView.transform:GetChild(idx - 1).gameObject
						local groupInfo = groupList[idx]

						if groupInfo then
							if not groupInfo.familyIds then
								local familyIds = {}

								if groupInfo then
									if not groupInfo.energies then
										for familyIdx = 1, FamilyCountInGroup do
											local familyId = familyIds[familyIdx]
											local mainGo = groupCellGo.transform:GetChild(familyIdx - 1).gameObject
											local tagNil = goutil.findChild(mainGo, "tagNil")
											local headCell = goutil.findChild(mainGo, "headCell")
											local icon = goutil.findChild(mainGo, "headCell/mask/icon")
											local txtFamilyName = goutil.findChildTextComponent(mainGo, "headCell/familyName/txt")
											local txtAreaName = goutil.findChildTextComponent(mainGo, "headCell/areaName/txt")
											local tagWin = goutil.findChild(mainGo, "headCell/tagWin")
											local tagMe = goutil.findChild(mainGo, "headCell/tagMe")

											GameUtil.SetActive(tagNil, false)
											GameUtil.SetActive(headCell, false)

											if familyId then
												local info = self._familySimpleInfos[familyId]
												local iconId = info and info.iconId

												txtFamilyName.text = info and info.familyName
												txtAreaName.text = info and info.areaName

												GameUtil.setUIImageSpriteIdx(icon, iconId)
												GameUtil.SetActive(headCell, true)
												GameUtil.SetActive(tagMe, familyId == self._myFamilyId)

												local isHasResult = step < self._curStep

												GameUtil.SetActive(tagWin, isHasResult and familyIdx == 1)
											else
												GameUtil.SetActive(tagNil, true)
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

return GodStatuesWarSeasonScheduleRankTabChildView
