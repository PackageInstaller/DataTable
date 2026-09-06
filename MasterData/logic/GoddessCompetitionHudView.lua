-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/GoddessCompetitionHudView.lua

module("logic.extensions.operationsummary.view.GoddessCompetitionHudView", package.seeall)

local GoddessCompetitionHudView = class("GoddessCompetitionHudView", ActivityGrandSummaryView)

function GoddessCompetitionHudView:ctor()
	GoddessCompetitionHudView.super.ctor(self)
end

function GoddessCompetitionHudView:unbindEvents()
	GoddessCompetitionHudView.super.unbindEvents(self)
end

function GoddessCompetitionHudView:bindEvents()
	GoddessCompetitionHudView.super.bindEvents(self)
end

function GoddessCompetitionHudView:buildUI()
	GoddessCompetitionHudView.super.buildUI(self)

	self._cardList = {}

	for i = 1, 4 do
		local cell = {}

		cell.go = self:getGo("cardlist/petCell_" .. i)
		cell.txtName = goutil.findChildTextComponent(cell.go, "bottom/txtName")
		cell.txtNum = goutil.findChildTextComponent(cell.go, "bottom/txtNum")
		cell.petIcon1 = goutil.findChild(cell.go, "mask/petIcon1")
		cell.petIcon2 = goutil.findChild(cell.go, "mask/petIcon2")
		self._cardList[i] = cell
	end

	self._tableviewGo = self:getGo("progress/tableview")
	self._tablecellGo = self:getGo("progress/tablecell")
	self._progressList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateProgressCell, self), self._clearProgressCell)
	self._progressSlider = self:getSlider("progress/tableview/viewport/content/progressSlider")
end

function GoddessCompetitionHudView:onExit()
	GoddessCompetitionHudView.super.onExit(self)

	for i, cell in ipairs(self._cardList) do
		uGuiUtil.clearImage(cell.petIcon1)
		uGuiUtil.clearImage(cell.petIcon2)
	end

	removetimer(self._switchGoddess, self)
	self._progressList:dispose()
end

function GoddessCompetitionHudView:onEnter()
	GoddessCompetitionHudView.super.onEnter(self)

	self._activityId = GoddessCompetitionController.instance:getActivityId()

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	GoddessCompetitionController.instance:getInfo(self._activityId)
	self.addGEvent(self, GlobalNotify.GoddessCompetitionGetBaseInfoRes, self._updateUIByInfo, self)
	self:_setProgress()
end

function GoddessCompetitionHudView:_getSumActivityId()
	return 17185
end

function GoddessCompetitionHudView:_setProgress()
	local timeSldCfgs = GoddessCompetitionConfig.instance:getStepCfgs(self._activityId)
	local len = #timeSldCfgs
	local nowTime = ServerTime.now()
	local curProgress = 0

	for i = len, 1, -1 do
		local cfg = timeSldCfgs[i]
		local startTime = GameUtil.string2time(cfg.openTime)

		if startTime <= nowTime then
			curProgress = i - 1

			break
		end
	end

	curProgress = math.max(0, curProgress)

	local progressValue = curProgress / (len - 1)

	self._progressList:reloadData(timeSldCfgs)
	self._progressSlider:SetValue(progressValue)
end

function GoddessCompetitionHudView:_updateProgressCell(view, cell, timeSldCfg)
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "desc/txtDesc")
	local txtTime = goutil.findChildTextComponent(cell.gameObject, "txtTime")
	local openDate = GameUtil.string2date(timeSldCfg.openTime)

	txtDesc.text = timeSldCfg.hudDesc
	txtTime.text = string.format("%d.%d", openDate.month, openDate.day)
end

function GoddessCompetitionHudView:_clearProgressCell(cell)
	return
end

function GoddessCompetitionHudView:_updateUIByInfo()
	removetimer(self._switchGoddess, self)

	local baseInfo = GoddessCompetitionModel.instance:getBaseInfo(self._activityId)

	GoddessCompetitionModel.instance:setCurActId(self._activityId)

	local curStepId = baseInfo.curStepId
	local goddessInfos = GoddessCompetitionModel.instance:getCurGoddessList(curStepId)

	self._curGoddessInfos = {}

	for _, info in ipairs(goddessInfos) do
		table.insert(self._curGoddessInfos, info)
	end

	table.sort(self._curGoddessInfos, function(a, b)
		if a.popularity == b.popularity then
			return checknumber(a.timestamp) < checknumber(b.timestamp)
		else
			return a.popularity > b.popularity
		end
	end)

	self._curShowId = 0

	for _, cell in ipairs(self._cardList) do
		self:_switchGoddess()
	end

	local stepType = GoddessCompetitionConfig.instance:getStepTypeByStepId(self._activityId, curStepId)

	if stepType ~= GoddessCompetitionController.instance.Step_finals then
		settimer(4, self._switchGoddess, self, true)
	end
end

function GoddessCompetitionHudView:_switchGoddess()
	self._curShowId = self._curShowId + 1

	local cardId = self._curShowId % #self._cardList

	if cardId == 0 then
		cardId = #self._cardList
	end

	local cardCell = self._cardList[cardId]
	local showCardSubId = Mathf.Floor(self._curShowId / #self._cardList) % 2
	local infoId = self._curShowId % #self._curGoddessInfos

	if infoId == 0 then
		infoId = #self._curGoddessInfos
	end

	local info = self._curGoddessInfos[infoId]
	local petIcon = cardCell.petIcon1
	local petIconLast = cardCell.petIcon2

	if showCardSubId == 0 then
		petIcon = cardCell.petIcon2
		petIconLast = cardCell.petIcon1
	end

	local petIconFaceComp1 = UnityTweens.UITweenFade.StartTween(petIcon.gameObject, 0, 1, 1)
	local petIconFaceComp2 = UnityTweens.UITweenFade.StartTween(petIconLast.gameObject, 1, 0, 1)

	petIconFaceComp1.autoDestroy = true
	petIconFaceComp2.autoDestroy = true

	petIcon.transform:SetAsFirstSibling()

	local faceId = checknumber(info.faceId)
	local modelCo = CharacterConfig.instance:getModelCo(faceId)

	if modelCo == nil then
		printError(string.format("精灵faceId缺失模型配置:%s", faceId))
		uGuiUtil.clearImage(petIcon)
	else
		uGuiUtil.setSpriteToImage(petIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	end

	cardCell.txtName.text = PetSkinConfig.instance:getPetSkinName(faceId)
	cardCell.txtNum.text = langPara("当前票数：%s", info.popularity)
end

return GoddessCompetitionHudView
