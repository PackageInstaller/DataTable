-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityPanelMixin.lua

local ResWebConfig = require("ClientData/ResWebConfig")
local WebView = require("SDK/Plugin/WebView")
local CommonFuncEntryPanel = require("UI/MainMenu/CommonFuncEntryPanel")
local ResOpActivityTemplate = require("ClientData/ResOpActivityTemplate")
local ActivityPanelMixin = {}

function ActivityPanelMixin:onShowActivity(pageData)
	self.clientTemplateData = pageData[1] or {}
	self.actObj = pageData[2]
	self.subConfig = pageData[3]

	if not self.inited then
		self.replaceableCellPath = self.clientTemplateData.src_replace or {}

		if self.initUI then
			self:initUI()
		end

		local replace_resource = self.clientTemplateData.replace_resource or {}

		if not self.disableReplace then
			self:initResource(replace_resource)
		end

		if self.mUIName then
			self:_onVisibleOn()

			if self.onClose then
				local oriCloseFunc = self.onClose

				local function _onCloseFunc(self)
					self:_onVisibleOff()
					oriCloseFunc(self)
				end

				self.onClose = _onCloseFunc
			end
		end

		self.inited = true
	end

	if self._setData then
		self:_setData()
	end

	self:_initCommonUI()
	self:onShow()
end

function ActivityPanelMixin:onShow(isOnPageShow)
	if isOnPageShow then
		if self.actObj and self.actObj:isNewOpened() then
			RPC.opActSetFocus(self.actObj.opId, 1)
		end

		self:_onVisibleOn()

		if self.actObj then
			self.actObj:saveTodayOnceNew()
		end
	end

	if self._onShow then
		self:_onShow(isOnPageShow)
	end
end

function ActivityPanelMixin:onActivityDataRefresh(actObj)
	return
end

function ActivityPanelMixin:_timerOver()
	if self.textTime and self.textTime:isAlive() then
		self.textTime:setText(Lang.get(32785))
	end
end

local ACTIVITY_FREEZE_ENABLE_CONFIG = {
	[Const.ACT_TYPE_NEW_YEAR_DINNER] = true,
	[Const.ACT_TYPE_Hatsune] = true,
	[Const.ACT_TYPE_VALENTINE] = true,
	[Const.ACT_TYPE_SEND_HERO] = true
}

function ActivityPanelMixin:_initCommonUI()
	if not self.actObj then
		return
	end

	if self.textTime then
		local mainColor = self.clientTemplateData.main_color

		if mainColor then
			self.textTime:setColorByRGBA(mainColor[1] / 255, mainColor[2] / 255, mainColor[3] / 255, 1)
		end

		if ACTIVITY_FREEZE_ENABLE_CONFIG[self.actObj.actType] and self.actObj:inOpenState() then
			ClientTimerManager.AddSecondFormatTickUI(self.textTime, self.actObj:getRemainOpenTime(), false, Lang.get(48657), Slot(self._timerOver, self))
		else
			ClientTimerManager.AddSecondFormatTickUI(self.textTime, self.actObj:getRemainOpenTime(), false, Lang.get(48655), Slot(self._timerOver, self))
		end
	end

	if self.textRule then
		if self.actObj.templateData.freeze_rule_desc and self.actObj:inFreeze() then
			self.textRule:setText(self.actObj.templateData.freeze_rule_desc or "")
		else
			self.textRule:setText(self.actObj.templateData.rule_desc or "")
		end
	end

	if self.panelFund then
		local panelFund = ResOpActivityTemplate[self.actObj.actId].panel_fund

		if panelFund then
			self.panelFund:settingFund(panelFund)
		end
	end
end

function ActivityPanelMixin:onClosePanel()
	if self._onClosePanel then
		self:_onClosePanel()
	end
end

function ActivityPanelMixin:onLeavePage()
	self:_onVisibleOff()

	if self._onLeavePage then
		self:_onLeavePage()
	end
end

function ActivityPanelMixin:_onVisibleOn(...)
	if self.openVocalGroupId then
		CueManager.playGroupVocal(self.openVocalGroupId)
	end

	if self.openBgmId then
		CueManager.playUIBGM(self.openBgmId)
	end

	if self.actObj then
		CurAvatar:checkGameAssistant(Const.GAME_ASSISTANT_TRIGGER_TYPE.ActOpen, {
			arg = self.actObj.actType
		}, true)
	end
end

function ActivityPanelMixin:_onVisibleOff(...)
	if self.openVocalGroupId then
		CueManager.stopVocal()
	end

	if self.openBgmId then
		UIManager.checkUIBgm()
	end
end

function ActivityPanelMixin:closeActivityDlg()
	local actUI = UIManager.getUI("activityMainDlg", nil, false)

	if actUI then
		actUI:setVisible(false)
	end
end

function ActivityPanelMixin:receiveWaitActivity(actId)
	self.receiveWaitActId = actId
end

local RawImageType = 1
local LabelType = 2
local ImageType = 3
local WebType = 4
local JumpType = 5
local TipsType = 6
local CellType = 7
local TimeType = 8
local ExtraJumpType = 9
local CellTemplateType = 10
local ImageAtlasType = 11
local ControlVisible = 12
local ItemGridType = 13
local SpecCellType = 14
local ItemTipsType = 15
local ImageColorType = 16
local Live2DType = 17
local AVGType = 18
local MovieType = 19
local OpenVocalType = 20
local MovieListType = 21
local AVGListType = 22
local RandomGridType = 23
local ChangeBGMType = 24
local CustomUIVisible = 25

function ActivityPanelMixin:initResource(replaceResourceList)
	self.replaceableColorPath = self.clientTemplateData.color_replace or {}
	self.replaceableSpecialCellPath = {}
	self.replaceableGrid = {}
	self.jumpIds = {}

	for i, resourceInfo in ipairs(replaceResourceList) do
		local resType = resourceInfo.type
		local resUIPath = resourceInfo.path or ""
		local resValue = resourceInfo.value
		local resSubUI = resourceInfo.sub_ui

		if resSubUI == nil or resSubUI == self.mPrefabKey then
			if resType == ImageType then
				if UIControls.checkControlFunc(self, resUIPath) then
					local uiTarget = UIControls.Image(self, resUIPath)
					local imagePath = utils.splitString(resValue, ";")

					if imagePath and #imagePath == 2 then
						uiTarget:setVisible(true)
						uiTarget:setImage(imagePath[1], imagePath[2])
					else
						uiTarget:setVisible(false)
					end
				end
			elseif resType == ImageAtlasType then
				if self.atlasDict then
					self.atlasDict[resUIPath] = {}

					local imageList = utils.splitString(resValue, ",")

					if imageList then
						for i, imagePathStr in ipairs(imageList) do
							local imagePath = utils.splitString(imagePathStr, ";")

							if imagePath and #imagePath == 2 then
								self.atlasDict[resUIPath][i] = {
									imagePath[1],
									imagePath[2]
								}
							end
						end
					end
				end
			elseif resType == ImageColorType then
				if UIControls.checkControlFunc(self, resUIPath) then
					local uiTarget = UIControls.Image(self, resUIPath)
					local colorList = utils.splitString(resValue, ",")

					if colorList and #colorList >= 3 then
						uiTarget:setColorByRGBA(colorList[1], colorList[2], colorList[3], colorList[4])
					end
				end
			elseif resType == LabelType then
				if UIControls.checkControlFunc(self, resUIPath) then
					local uiTarget = UIControls.Label(self, resUIPath)

					uiTarget:setText(resValue)
				end
			elseif resType == RawImageType then
				if UIControls.checkControlFunc(self, resUIPath) then
					local uiTarget = UIControls.RawImage(self, resUIPath)

					uiTarget:setImage(resValue)
				end
			elseif resType == WebType then
				if UIControls.checkControlFunc(self, resUIPath) then
					local uiTarget = UIControls.Button(self, resUIPath)
					local resWebId = tonumber(resValue) or 0

					if resWebId == 0 then
						uiTarget:setVisible(false)
					else
						uiTarget:setVisible(true)

						local function clickWebBtn(webId)
							if ResWebConfig[webId] and ResWebConfig[webId].web_path then
								local path = ResWebConfig[webId].web_path

								WebView.openWebView(path)
							end
						end

						uiTarget:clearEventClick()
						uiTarget:addEventClick(Slot(clickWebBtn, resWebId))
					end
				end
			elseif resType == JumpType then
				if UIControls.checkControlFunc(self, resUIPath) then
					local uiTarget = UIControls.Button(self, resUIPath)
					local resJumpId = tonumber(resValue) or 0

					if resJumpId == 0 then
						uiTarget:setVisible(false)
					else
						table.insert(self.jumpIds, resJumpId)
						uiTarget:setVisible(true)

						local function clickJumpBtn(jumpId)
							JumpGuideManager.jump(jumpId)
						end

						uiTarget:clearEventClick()
						uiTarget:addEventClick(Slot(clickJumpBtn, resJumpId))
					end
				end
			elseif resType == TipsType then
				if UIControls.checkControlFunc(self, resUIPath) then
					local uiTarget = UIControls.Button(self, resUIPath)
					local resTipsId = tonumber(resValue) or 0

					if resTipsId == 0 then
						uiTarget:setVisible(false)
					else
						uiTarget:setVisible(true)

						local function clickJumpBtn(noticeId)
							local infoDialog = UIManager.getUI("infoNotice", true)

							if infoDialog then
								infoDialog:showSystemInfo(noticeId)
							end
						end

						uiTarget:clearEventClick()
						uiTarget:addEventClick(Slot(clickJumpBtn, resTipsId))
					end
				end
			elseif resType == TimeType then
				local replaceType = tonumber(resUIPath)
				local txt = resValue

				if not self.timeTxt and UIControls.checkControlFuncFunc(self, "TextTime") then
					self.timeTxt = UIControls.Label(self, "TextTime")
				end

				if replaceType == 1 and self.timeTxt then
					self.timeTxt:setText(txt)

					self.timeInited = true
				elseif replaceType == 2 then
					self.timeTxtTitle = txt or ""
				end
			elseif resType == ExtraJumpType then
				if UIControls.checkControlFunc(self, resUIPath) then
					local uiTarget = UIControls.Button(self, resUIPath)
					local resJumpId = tonumber(resValue) or 0

					if resJumpId > 0 then
						local function clickJumpBtn(jumpId)
							JumpGuideManager.jump(jumpId)
						end

						table.insert(self.jumpIds, resJumpId)
						uiTarget:addEventClick(Slot(clickJumpBtn, resJumpId))
					end
				end
			elseif resType == CellTemplateType then
				local cellPath = resUIPath
				local cellTemplateId = tonumber(resValue)

				if cellPath and cellTemplateId then
					if not self.cellTemplateDict then
						self.cellTemplateDict = {}
					end

					self.cellTemplateDict[cellPath] = cellTemplateId
				end
			elseif resType == ControlVisible then
				if UIControls.checkControlFunc(self, resUIPath) then
					local uiTarget = UIControls.Panel(self, resUIPath)
					local isVisible = tonumber(resValue) == 1

					uiTarget:setVisible(isVisible)
				end
			elseif resType == ItemGridType then
				local itemInfo = utils.splitString(resValue, ",")
				local resItemId = tonumber(itemInfo[1]) or 0
				local itemNum = tonumber(itemInfo[2]) or 1
				local uiTarget = self.replaceableGrid[resUIPath]

				if resItemId == 0 then
					if uiTarget then
						uiTarget:setVisible(false)
					end
				else
					local fakeItem = BaseObject.GetObject(resItemId, itemNum)

					if not uiTarget then
						uiTarget = UIControls.getGridChild(fakeItem, self, resUIPath)
						uiTarget.isShowPreviewTips = true
						self.replaceableGrid[resUIPath] = uiTarget
					end

					uiTarget:setVisible(true)
					uiTarget:setObj(fakeItem)
				end
			elseif resType == CellType then
				local cellMountPath = tonumber(resUIPath)
				local cellPath = resValue

				if self.replaceableCellPath then
					self.replaceableCellPath[cellMountPath] = cellPath
				end
			elseif resType == SpecCellType then
				local index = tonumber(resUIPath)
				local cellPath = resValue

				if self.replaceableSpecialCellPath then
					self.replaceableSpecialCellPath[index] = cellPath
				end
			elseif resType == ItemTipsType then
				if UIControls.checkControlFunc(self, resUIPath) then
					local uiTarget = UIControls.Button(self, resUIPath)
					local resJumpId = tonumber(resValue) or 0

					if resJumpId > 0 then
						local function clickJumpBtn(jumpId)
							self.mDisableWays = true

							BaseObject.ShowObjectTips(jumpId, 1, self)
						end

						uiTarget:addEventClick(Slot(clickJumpBtn, resJumpId))
					end
				end
			elseif resType == Live2DType then
				if UIControls.checkControlFunc(self, resUIPath) then
					local uiTarget = UIControls.LazyLivePlayer(self, resUIPath)
					local valueList = utils.splitString(resValue, ";")

					if valueList and #valueList == 2 then
						uiTarget:playLive2DByPath(valueList[1], tonumber(valueList[2]))
					else
						uiTarget:playLive2DByPath(resValue)
					end
				end
			elseif resType == MovieType or resType == AVGType then
				if UIControls.checkControlFunc(self, resUIPath) then
					local uiTarget = UIControls.Button(self, resUIPath)

					uiTarget:setVisible(true)

					local function clickJumpBtn(rType, rValue)
						if rType == AVGType and tonumber(rValue) then
							UIManager.playAVG(tonumber(rValue))
						elseif rType == MovieType then
							UIManager.getUI("sequenceFramePlayer", true):playVideo(rValue, nil, nil, true, true)
						end
					end

					uiTarget:clearEventClick()
					uiTarget:addEventClick(Functor(clickJumpBtn, resType, resValue))
				end
			elseif resType == AVGListType then
				if UIControls.checkControlFunc(self, resUIPath) then
					local uiTarget = UIControls.Button(self, resUIPath)

					uiTarget:setVisible(true)

					local valueList = utils.splitString(resValue, ",")

					if #valueList < 1 then
						return
					end

					local function clickJumpBtn(rType, leftValueList, idx)
						local firstValue = leftValueList[idx]
						local cb

						if idx < #leftValueList then
							cb = Functor(clickJumpBtn, rType, leftValueList, idx + 1)
						end

						if rType == AVGListType and tonumber(firstValue) then
							UIManager.playAVG(tonumber(firstValue), nil, cb)
						end
					end

					uiTarget:clearEventClick()
					uiTarget:addEventClick(Functor(clickJumpBtn, resType, valueList, 1))
				end
			elseif resType == MovieListType then
				if UIControls.checkControlFunc(self, resUIPath) then
					local uiTarget = UIControls.Button(self, resUIPath)

					uiTarget:setVisible(true)

					local valueList = utils.splitString(resValue, ",")

					if #valueList < 1 then
						return
					end

					local function clickJumpBtn(leftValueList)
						UIManager.getUI("sequenceFramePlayer", true):playVideoList(leftValueList, nil, nil, true, true, true)
					end

					uiTarget:clearEventClick()
					uiTarget:addEventClick(Functor(clickJumpBtn, valueList))
				end
			elseif resType == OpenVocalType then
				local groupId = tonumber(resValue)

				if groupId then
					self.openVocalGroupId = groupId
				end
			elseif resType == ChangeBGMType then
				local bgmId = tonumber(resValue)

				if bgmId then
					self.openBgmId = bgmId
				end
			elseif resType == CustomUIVisible then
				local argsList = utils.splitString(resValue, ";")
				local funcName = argsList[1]

				if funcName and ClientUtils[funcName] and UIControls.checkControlFunc(self, resUIPath) then
					ClientUtils[funcName](self, resUIPath, argsList)
				end
			elseif resType == RandomGridType and UIControls.checkControlFunc(self, resUIPath) then
				local randInfo = utils.splitString(resValue, ",")
				local randId = tonumber(randInfo[1]) or 0
				local maxShowNum = tonumber(randInfo[2])
				local uiTarget = self.replaceableGrid[resUIPath]

				uiTarget = uiTarget or {}

				ClientUtils.CreateBonusGrid(self, uiTarget, resUIPath, randId, true, maxShowNum, true)

				self.replaceableGrid[resUIPath] = uiTarget
			end
		end
	end
end

return ActivityPanelMixin
