-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/GoddessgamehudView.lua

module("logic.extensions.operationsummary.view.GoddessgamehudView", package.seeall)

local GoddessgamehudView = class("GoddessgamehudView", ActivityGrandSummaryView)

GoddessgamehudView.EnterStoryKey = "GoddessgamehudView.EnterStoryKey"

function GoddessgamehudView:ctor()
	GoddessgamehudView.super.ctor(self)

	self._changeTime = 4
end

function GoddessgamehudView:unbindEvents()
	GoddessgamehudView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function GoddessgamehudView:bindEvents()
	GoddessgamehudView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)

	self._effectGo = self:getGo("effect")
	self._petTransformGo = self:getGo("petTransform")
	self._petCellGo = self:getGo("petCell")
	self._txtTime = self:getTxt("openTime/txtTime")
	self._petTransformRecord = self:getGo("petTransform"):GetComponent(typeof(TestRecordPos))
end

function GoddessgamehudView:buildUI()
	GoddessgamehudView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._tableviewGo = self:getGo("progress/tableview")
	self._tablecellGo = self:getGo("progress/tablecell")
	self._progressList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateProgressCell, self), self._clearProgressCell)
	self._progressSlider = self:getSlider("progress/tableview/viewport/content/progressSlider")
	self._redpackTipsCon = self:getGo("redpackTips")
end

function GoddessgamehudView:onExit()
	GoddessgamehudView.super.onExit(self)

	if self._itemGroup then
		self._itemGroup:dispose(function(item)
			local petIcon1 = goutil.findChild(item.mainGO, "mask/petIcon1")
			local petIcon2 = goutil.findChild(item.mainGO, "mask/petIcon2")

			uGuiUtil.clearImage(petIcon1)
			uGuiUtil.clearImage(petIcon2)
		end)
	end

	GlobalDispatcher:removeListener(GlobalNotify.GoddessContestGetInfo, self._GoddessContestGetInfo, self)
	removetimer(self._changeImage, self)
end

function GoddessgamehudView:_getSumActivityId()
	return 17106
end

function GoddessgamehudView:onEnter()
	GoddessgamehudView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.GoddessContestGetInfo, self._GoddessContestGetInfo, self)

	local goddessActId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.Goddess_Contest)

	GoddessContestController.instance:getInfo(goddessActId)

	self._timeSldCfgs = GoddessContestConfig.instance:getTimeSldCfgsByActId(goddessActId)
	self._fanGroupCfgs = GoddessContestConfig.instance:getFanGroupCfgsByActId(goddessActId)
	self._currShowInfos = {}
	self._currChangeIndex = 4

	settimer(self._changeTime, self._changeImage, self, true)
	self:_setProgress()
	self:_updateCards()
	self:_setActTime()
	self:_changeImage()
	self:_playEnterStory()
	GroupRedpackController.instance:setCurrContainer(self._redpackTipsCon, self._viewPresentor.viewName)
end

function GoddessgamehudView:_onClickbtnClose()
	self:close()
end

function GoddessgamehudView:_setActTime()
	local stime, etime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.Summary, self.activityId)
	local sdate = GameUtil.time2date(stime)
	local edate = GameUtil.time2date(etime)

	self._txtTime.text = string.format("活动时间：%s.%s %s:00 - %s.%s %s:00", sdate.month, sdate.day, sdate.hour, edate.month, edate.day, edate.hour)
end

function GoddessgamehudView:_updateCards(datas)
	self._itemGroup = self._itemGroup or ItemGroup.New(self._petTransformGo, self._petCellGo, nil, nil, true)

	local mos = datas or {}

	self._itemGroup:updateWithMoArray(mos, function(item, data)
		self:_updateOneCard(item, data)
	end)
	self._petTransformRecord:LoadPlan(0)
end

function GoddessgamehudView:_updateOneCard(item, showInfo)
	local petIcon1 = goutil.findChild(item.mainGO, "mask/petIcon1"):GetComponent(goutil.Type_UIImage)
	local petIcon2 = goutil.findChild(item.mainGO, "mask/petIcon2"):GetComponent(goutil.Type_UIImage)
	local txtName = goutil.findChildTextComponent(item.mainGO, "name/txtName")
	local txtNum = goutil.findChildTextComponent(item.mainGO, "voteNum/txtNum")
	local iconChange = goutil.findChild(item.mainGO, "title/icon"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtTitle = goutil.findChildTextComponent(item.mainGO, "title/txtTitle")

	iconChange:SetState(item.index - 1)

	txtTitle.text = self._fanGroupCfgs[showInfo.fansGroupId].hudWord

	local isChange = showInfo.isChange

	if isChange then
		local petIconFaceComp1 = UnityTweens.UITweenFade.StartTween(petIcon1.gameObject, 0, 1, 1)
		local petIconFaceComp2 = UnityTweens.UITweenFade.StartTween(petIcon2.gameObject, 1, 0, 1)

		petIconFaceComp1.autoDestroy = true
		petIconFaceComp2.autoDestroy = true

		uGuiUtil.setSpriteToImage(petIcon2.gameObject, nil, showInfo.lastResName)
		uGuiUtil.setSpriteToImage(petIcon1.gameObject, nil, showInfo.currResName)
	else
		uGuiUtil.clearImage(petIcon2.gameObject)
		uGuiUtil.setSpriteToImage(petIcon1.gameObject, nil, showInfo.currResName)
	end

	txtName.text = showInfo.name
	txtNum.text = string.format("当前人气值:%s", showInfo.popularityValue)
end

function GoddessgamehudView:_GoddessContestGetInfo()
	self:_changeImage()
end

function GoddessgamehudView:_changeImage()
	local groupInfos = GoddessContestModel.instance:getGroupInfos()

	if not groupInfos or #groupInfos <= 0 then
		return
	end

	self._currChangeIndex = self._currChangeIndex + 1

	if self._currChangeIndex > 4 then
		self._currChangeIndex = 1
	end

	local groupInfo = groupInfos[self._currChangeIndex]

	if not groupInfo then
		return
	end

	local showInfos = {}

	for i = 1, 4 do
		local groupInfo = groupInfos[i]
		local showInfo = self._currShowInfos[i]

		if not showInfo then
			showInfo = {
				lastResName = "",
				popularityValue = 0,
				name = "",
				isChange = false,
				faceId = 0,
				fansGroupId = 0,
				currResName = "",
				faceId = groupInfo.voteDataList[1].faceId,
				popularityValue = groupInfo.voteDataList[1].popularityValue
			}

			local petCo = CharacterConfig.instance:getModelCo(showInfo.faceId)

			showInfo.currResName = GameUrl.getBigbgFolderUrl("pet", petCo.cardName)
			showInfo.name = PetSkinConfig.instance:getPetSkinName(showInfo.faceId)
		end

		showInfo.fansGroupId = groupInfo.groupId
		showInfo.isChange = false

		local lastFaceId = showInfo.faceId

		if i == self._currChangeIndex then
			local hitIndex = 0

			if lastFaceId > 0 then
				for i, info in ipairs(groupInfo.voteDataList) do
					if info.faceId == lastFaceId then
						hitIndex = i

						break
					end
				end
			end

			local currFaceId = 0

			if not groupInfo.voteDataList[hitIndex + 1] then
				if groupInfo.voteDataList[hitIndex + 1] then
					showInfo.popularityValue = groupInfo.voteDataList[hitIndex + 1].popularityValue
					showInfo.faceId = groupInfo.voteDataList[hitIndex + 1].faceId
					currFaceId = groupInfo.voteDataList[hitIndex + 1].faceId
				end

				showInfo.isChange = currFaceId ~= lastFaceId

				if showInfo.isChange then
					local petCo = CharacterConfig.instance:getModelCo(lastFaceId)

					showInfo.lastResName = GameUrl.getBigbgFolderUrl("pet", petCo.cardName)
				end

				local petCo = CharacterConfig.instance:getModelCo(currFaceId)

				showInfo.currResName = GameUrl.getBigbgFolderUrl("pet", petCo.cardName)
				showInfo.name = PetSkinConfig.instance:getPetSkinName(currFaceId)
			end
		end

		self._currShowInfos[i] = showInfo

		table.insert(showInfos, showInfo)
	end

	self:_updateCards(showInfos)
end

function GoddessgamehudView:_setProgress()
	local len = #self._timeSldCfgs
	local nowTime = ServerTime.now()
	local curProgress = 0

	for i = len, 1, -1 do
		local cfg = self._timeSldCfgs[i]
		local startTime = GameUtil.string2time(cfg.startTime)

		if startTime <= nowTime then
			curProgress = i - 1

			break
		end
	end

	curProgress = math.max(0, curProgress)

	local progressValue = curProgress / (len - 1)

	self._progressList:reloadData(self._timeSldCfgs)
	self._progressSlider:SetValue(progressValue)
end

function GoddessgamehudView:_updateProgressCell(view, cell, timeSldCfg)
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "desc/txtDesc")
	local txtTime = goutil.findChildTextComponent(cell.gameObject, "txtTime")

	txtDesc.text = timeSldCfg.hudDesc
	txtTime.text = timeSldCfg.showTime
end

function GoddessgamehudView:_clearProgressCell(cell)
	return
end

function GoddessgamehudView:_playEnterStory()
	local storyId = OperationSummaryConfig.instance:getStoryIdByActivityId(self:_getSumActivityId())

	if storyId <= 0 then
		return
	end

	local isPlay = GameUtil.getUserData(GoddessgamehudView.EnterStoryKey)

	if isPlay then
		return
	end

	GameUtil.saveUserData(GoddessgamehudView.EnterStoryKey, true)
	GlobalDispatcher:dispatch(GlobalNotify.StartStory, storyId)
end

return GoddessgamehudView
