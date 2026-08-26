-- chunkname: @modules/logic/bossrush/view/v2a9/V2a9_BossRushMainItem.lua

module("modules.logic.bossrush.view.v2a9.V2a9_BossRushMainItem", package.seeall)

local V2a9_BossRushMainItem = class("V2a9_BossRushMainItem", V1a4_BossRushMainItem)

function V2a9_BossRushMainItem:init(go)
	self.viewGO = gohelper.findChild(go, "Root")
	self._btnItemBG = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_ItemBG")
	self._goUnlocked = gohelper.findChild(self.viewGO, "#go_Unlocked")
	self._imageIssxIcon = gohelper.findChildImage(self.viewGO, "#go_Unlocked/Title/#image_IssxIcon")
	self._txtTitle = gohelper.findChildText(self.viewGO, "#go_Unlocked/Title/#txt_Title")
	self._txtTitleEn = gohelper.findChildText(self.viewGO, "#go_Unlocked/Title/#txt_TitleEn")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_Unlocked/#simage_bg")
	self._goSpecialRecord = gohelper.findChild(self.viewGO, "#go_Unlocked/#go_NormalRecord")
	self._txtSpecialRecordNum = gohelper.findChildText(self.viewGO, "#go_Unlocked/#go_NormalRecord/#txt_RecordNum")
	self._goSpecialAssessIcon = gohelper.findChild(self.viewGO, "#go_Unlocked/#go_NormalRecord/#go_AssessIcon")
	self._goNormalRecord = gohelper.findChild(self.viewGO, "#go_Unlocked/#go_SpecialRecord")
	self._txtRecordNum = gohelper.findChildText(self.viewGO, "#go_Unlocked/#go_SpecialRecord/#txt_RecordNum")
	self._goAssessIcon = gohelper.findChild(self.viewGO, "#go_Unlocked/#go_SpecialRecord/#go_AssessIcon")
	self._goLocked = gohelper.findChild(self.viewGO, "#go_Locked")
	self._txtLocked = gohelper.findChildText(self.viewGO, "#go_Locked/#txt_Locked")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "#go_Locked/#txt_LimitTime")
	self._btnLocked = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Locked/#btn_Locked")
	self._simageLocked = gohelper.findChildSingleImage(self.viewGO, "#go_Locked/image_Empty")
	self._goRed = gohelper.findChild(self.viewGO, "#go_Red")
	self._anim = self.viewGO:GetComponent(gohelper.Type_Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a9_BossRushMainItem:addEventListeners()
	self._btnItemBG:AddClickListener(self._btnItemBGOnClick, self)
	self._btnLocked:AddClickListener(self._btnLockedOnClick, self)
end

function V2a9_BossRushMainItem:removeEventListeners()
	self._btnItemBG:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
end

function V2a9_BossRushMainItem:_btnLockedOnClick()
	if not string.nilorempty(self._jumpParam) then
		local canJump, toastId, toastParamList = JumpController.instance:canJumpNew(self._jumpParam)

		if canJump then
			JumpController.instance:jumpByParam(self._jumpParam)
		elseif toastId then
			ToastController.instance:showToast(toastId, toastParamList and unpack(toastParamList))
		end
	end
end

function V2a9_BossRushMainItem:returnPlayAnim(isOpenTween)
	if isOpenTween then
		if self:_getIsNewUnlockStage() then
			self:_playUnlock(true)
			gohelper.setActive(self._goRed, true)

			return
		end
	else
		self:_playIdle()
	end
end

function V2a9_BossRushMainItem:_refresh()
	local mo = self._mo
	local stageCO = mo.stageCO
	local stage = stageCO.stage
	local isOpened = self:_isOpen()
	local issxIconName = BossRushConfig.instance:getIssxIconName(stage)
	local highestPoint = BossRushModel.instance:getHighestPoint(stage)
	local spHighestPoint = V2a9BossRushModel.instance:getHighestPoint(stage)
	local stageName = stageCO.name

	if stage == 1 then
		if not VersionActivity2_9Enum.ActivityId.Dungeon then
			local dungeonActId = VersionActivity2_9Enum.ActivityId.Dungeon2

			self._jumpParam = string.format("%s#%s", JumpEnum.JumpView.ActivityView, dungeonActId)

			UISpriteSetMgr.instance:setCommonSprite(self._imageIssxIcon, issxIconName)
			gohelper.setActive(self._goRecord, isOpened)
			gohelper.setActive(self._goRed, isOpened)

			self._txtRecordNum.text = highestPoint
			self._txtTitle.text = stageName
			self._txtTitleEn.text = stageCO.name_en
			self._txtSpecialRecordNum.text = spHighestPoint

			local color1 = GameUtil.parseColor("#E6AA6A")
			local color2 = GameUtil.parseColor("#808080")

			self._txtRecordNum.color = highestPoint > 0 and color1 or color2
			self._txtSpecialRecordNum.color = spHighestPoint > 0 and color1 or color2

			self._simagebg:LoadImage(BossRushConfig.instance:getBossRushMainItemBossSprite(stage))
			self._assessIcon:setData(stage, highestPoint, false)
			self._spAssessIcon:setData(stage, spHighestPoint, false)

			local lockPath = BossRushConfig.instance:getStageCO(stage).bossRushMainItemBossSprite .. "_locked"

			self._simageLocked:LoadImage(ResUrl.getV1a4BossRushIcon(lockPath))

			if not isOpened then
				local isOnline = BossRushModel.instance:isBossOnline(stage)

				if isOnline then
					local preEpisodeId = self:_getUnlockEpisodeId(stage)
					local actName, episode = V2a9BossRushModel.instance:getUnlockEpisodeDisplay(stage, preEpisodeId)
					local lang = luaLang("bossrush_unlockepisode")

					self._txtLocked.text = GameUtil.getSubPlaceholderLuaLangTwoParam(lang, actName, episode)

					gohelper.setActive(self._txtLimitTime.gameObject, false)
				else
					self._txtLocked.text = ""

					local timeStamp = BossRushModel.instance:getStageOpenServerTime(stage)

					self._txtLimitTime.text = self:getRemainTimeStr2(timeStamp - ServerTime.now())

					gohelper.setActive(self._txtLimitTime.gameObject, true)
				end
			end

			if isOpened then
				gohelper.addUIClickAudio(self._btnItemBG.gameObject, AudioEnum.UI.UI_Activity_open)
			end
		end
	end
end

function V2a9_BossRushMainItem:getRemainTimeStr2(offsetSecond, useEn)
	if useEn then
		if not TimeUtil.DateEnFormat.Day then
			local daySuffix = luaLangUTC("time_day")

			if useEn then
				if not TimeUtil.DateEnFormat.Hour then
					local hourSuffix = luaLangUTC("time_hour2")

					if useEn then
						if not TimeUtil.DateEnFormat.Minute then
							local minuteSuffix = luaLangUTC("time_minute2")

							if not offsetSecond or offsetSecond <= 0 then
								return 0 .. minuteSuffix
							end

							offsetSecond = math.floor(offsetSecond)

							local day = Mathf.Floor(offsetSecond / TimeUtil.OneDaySecond)

							if day > 0 then
								return day .. daySuffix
							end

							local hourSecond = offsetSecond % TimeUtil.OneDaySecond
							local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)

							if hour > 0 then
								return hour .. hourSuffix
							end

							local minuteSecond = hourSecond % TimeUtil.OneHourSecond
							local minute = Mathf.Floor(minuteSecond / TimeUtil.OneMinuteSecond)

							if minute <= 0 then
								minute = "<1"
							end

							return minute .. minuteSuffix
						end
					end
				end
			end
		end
	end
end

function V2a9_BossRushMainItem:_getUnlockEpisodeId(stage)
	local stageLayerInfos = BossRushModel.instance:getStageLayersInfo(stage)

	for _, info in pairs(stageLayerInfos) do
		local episodeCO = BossRushConfig.instance:getDungeonEpisodeCO(stage, info.layer)

		if episodeCO and episodeCO.preEpisode ~= 0 then
			return episodeCO.preEpisode
		end
	end
end

function V2a9_BossRushMainItem:_isOpen()
	local stage = self:_getStage()
	local isOnline = BossRushModel.instance:isBossOnline(stage)

	if not isOnline then
		return false
	end

	return BossRushModel.instance:isBossOpen(stage)
end

function V2a9_BossRushMainItem:_initAssessIcon()
	local viewContainer = ViewMgr.instance:getContainer(ViewName.V1a4_BossRushMainView)
	local itemClass = V1a4_BossRush_AssessIcon
	local iconPath = BossRushEnum.ResPath.v1a4_bossrush_mainview_assessicon
	local name = itemClass.__cname
	local go1 = viewContainer:getResInst(iconPath, self._goAssessIcon, name)

	self._assessIcon = MonoHelper.addNoUpdateLuaComOnceToGo(go1, itemClass)

	self._assessIcon:initData(self, false)

	local go2 = viewContainer:getResInst(iconPath, self._goSpecialAssessIcon, name)

	self._spAssessIcon = MonoHelper.addNoUpdateLuaComOnceToGo(go2, itemClass)

	self._spAssessIcon:initData(self, false)
end

function V2a9_BossRushMainItem:onDestroyView()
	V2a9_BossRushMainItem.super.onDestroyView(self)
	self._simageLocked:UnLoadImage()
end

return V2a9_BossRushMainItem
