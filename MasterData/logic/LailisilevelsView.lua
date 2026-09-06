-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/view/LailisilevelsView.lua

module("logic.extensions.lailisi.view.LailisilevelsView", package.seeall)

local LailisilevelsView = class("LailisilevelsView", ViewComponent)

function LailisilevelsView:ctor()
	LailisilevelsView.super.ctor(self)

	self._playerItemList = {}
end

function LailisilevelsView:unbindEvents()
	LailisilevelsView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function LailisilevelsView:bindEvents()
	LailisilevelsView.super.bindEvents(self)
	self._btnClose:AddClickListener(function()
		self:close()
	end)
	self._btnTip:AddClickListener(self._onClickTip, self)
end

function LailisilevelsView:onExit()
	LailisilevelsView.super.onExit(self)
	self:_clearRewardList()

	self._curActId = nil

	for _, v in pairs(self._cellList) do
		for _, w in ipairs(v) do
			MaterialMgr.clearIcon(w)
		end
	end

	RoleObjectPool.instance:removeRole(self._roleObj)
end

function LailisilevelsView:buildUI()
	LailisilevelsView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("txtTitle/btnTip")
	self._txtPetScore = self:getTxt("info/txtTotal")
	self._txtTitle = self:getTxt("txtTitle")
	self._desc = self:getTxt("desc/txt")
	self._bubbleTxt = self:getTxt("bubble/txtDesc")
	self._roleConGo = self:getGo("con")
	self._progresscell = self:getGo("info/progress/cell")
	self._tabCell = self:getGo("cell")
	self._teamTable = self:getGo("tableview")
	self._progressSilder = self:getSlider("info/progress/ScrollRect/ViewPort/Content/progressBar")
	self._teamTableContentRectTrans = self:getGo("tableview/Viewport/Content"):GetComponent(goutil.Type_RectTransform)
	self._playerContentRectTrans = self:getGo("info/progress/ScrollRect/ViewPort/Content"):GetComponent(goutil.Type_RectTransform)
	self._playerSliderRectTrans = self._progressSilder.gameObject:GetComponent(goutil.Type_RectTransform)

	local px, py = Framework.TransformUtil.GetAnchoredPos(self._playerSliderRectTrans, 0, 0)

	self._playerSliderStartOffset = py
	self._playerSliderEndOffset = 50
	self._playerWidthSpace = 150
	self._teamList = ScrollerList.create(self._teamTable, self._tabCell, GameUtil.handler(self._setTeamInfo, self), GameUtil.handler(self._clearItemCell, self))
end

function LailisilevelsView:onEnter()
	LailisilevelsView.super.onEnter(self)

	self._cellList = {}

	local params = self:getOpenParam()

	self._curActId = params[1]
	self._actCfg = LailisiConfig.instance:getActivityCfgById(self._curActId)

	self:onRefreshUI()
	self:setRedPoint(self._curActId)
	LailisiController.instance:stopEffect()
	LailisiController.instance:showUIEff(self.mainGO, "fx_ui_xjs_ny.prefab", self)
end

function LailisilevelsView:_setPlayerContentLength(rewardCount)
	local sliderLength = rewardCount * self._playerWidthSpace
	local contentTotalLength = self._playerSliderStartOffset + sliderLength + self._playerSliderEndOffset

	goutil.setWidth(self._playerContentRectTrans, contentTotalLength)
	goutil.setWidth(self._playerSliderRectTrans, sliderLength)
end

function LailisilevelsView:_setPlayerScore(Score)
	local maxScore = LailisiConfig.instance:getPrizeMaxScore(self._curActId)
	local curScore = Score or 0
	local cfgs = LailisiConfig.instance:getProgressCfgById(self._curActId)
	local progress = self:_getSilderValue(curScore, cfgs)

	self._progressSilder:SetValue(progress)

	self._txtPetScore.text = curScore
end

function LailisilevelsView:_getSilderValue(curScore, progressPrizeDatas)
	if progressPrizeDatas then
		if not #progressPrizeDatas then
			local count = 0

			if count == 0 or curScore <= 0 then
				return 0
			end

			local once = 1 / count
			local value = 0

			for i = 1, count do
				if progressPrizeDatas[i] then
					if curScore >= progressPrizeDatas[i].survival then
						value = value + once
					else
						local syc = 0

						if progressPrizeDatas[i - 1] and progressPrizeDatas[i - 1].survival > 0 then
							syc = progressPrizeDatas[i - 1].survival
						end

						local temp = (curScore - syc) * once / (progressPrizeDatas[i].survival - syc)

						value = value + temp

						break
					end
				end
			end

			return value
		end
	end
end

function LailisilevelsView:_initPlayerReward()
	table.clear(self._playerItemList)

	local cfgs = LailisiConfig.instance:getProgressCfgById(self._curActId)
	local count = #cfgs

	self:_setPlayerContentLength(count)

	local posY = 0
	local posX = self._playerSliderStartOffset

	for i, v in ipairs(cfgs) do
		posX = posX + self._playerWidthSpace

		local go = self:_getPlayerRewardGo(v)

		go.name = "playercell" .. i

		goutil.addChildToParent(go, self._playerContentRectTrans.transform)
		Framework.TransformUtil.SetAnchoredPos(go:GetComponent(goutil.Type_RectTransform), posX, posY)
		table.insert(self._playerItemList, go)
	end

	self:initPos(self._playerContentRectTrans)
end

function LailisilevelsView:_getPlayerRewardGo(data)
	local go = goutil.clone(self._progresscell)
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local txtScore = goutil.findChildTextComponent(go, "txtProgress")

	txtDesc.text = data.desc
	txtScore.text = data.survival

	goutil.setActive(go, true)

	return go
end

function LailisilevelsView:_clearRewardList()
	local cfgs = LailisiConfig.instance:getProgressCfgById(self._curActId)
	local count = #cfgs

	for i = 1, count do
		local cell = goutil.findChild(self._playerContentRectTrans, "playercell" .. i)

		goutil.destroy(cell)
	end

	self._playerItemList = {}
end

function LailisilevelsView:onRefreshUI()
	local progressInfo = LailisiModel.instance:getPetProgress(self._curActId)
	local teamInfo = LailisiModel.instance:getpetTeamInfo(self._curActId)

	self:_initPlayerReward()
	self:_setPlayerScore(progressInfo.progress)
	self._teamList:reloadData(teamInfo)

	self._txtTitle.text = self._actCfg.checkpointsName
	self._desc.text = self._actCfg.ruleDescription
	self._bubbleTxt.text = self._actCfg.content

	self:_setRole()
	self:initPos(self._teamTableContentRectTrans)
	LailisiModel.instance:setLastActId(self._curActId)
end

function LailisilevelsView:_setTeamInfo(view, cell, data)
	local formation = goutil.findChild(cell, "formation")
	local pass = goutil.findChild(cell, "pass")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")
	local level = goutil.findChildTextComponent(cell, "level/txtLevel")
	local powerTxt = goutil.findChildComponent(cell, "zdl/imgRecZdl", "UIImgNumeralText")
	local power = goutil.findChild(cell, "zdl")
	local cfg = LailisiConfig.instance:getTeamInfo(self._curActId, data.stageId)
	local isExtremeMode = LailisiConfig.instance:isExtremeMode(self._curActId)

	if isExtremeMode then
		goutil.setActive(power.gameObject, false)
	else
		goutil.setActive(power.gameObject, true)
		powerTxt:SetText(cfg.fightingCapacity)
	end

	txtNum.text = string.format("存活数：%s", data.value)

	pass:SetActive(data.value > 0)

	self._cellList[cell.index] = {}

	for i = 1, 9 do
		local obj = goutil.findChild(formation, string.format("cell_%d/con", i))

		MaterialMgr.resetAll(obj)
		obj.transform.parent.gameObject:SetActive(false)

		self._cellList[cell.index][i] = obj
	end

	local creepInfo = LailisiConfig.instance:getTeamInfo(self._curActId, data.stageId)
	local creepCfgs = LailisiConfig.instance:getPetCreeps(creepInfo.creepsMasterId)

	for i, v in pairs(creepCfgs) do
		local raceId, posId = v.raceId, v.posId
		local obj = self._cellList[cell.index][posId]

		obj.transform.parent.gameObject:SetActive(true)
		MaterialMgr.setIcon(obj, MatType.PET_SKIN, (checknumber(v.faceId) > 0 or nil) and checknumber(v.faceId))

		GameUtil.asBtn(obj).enabled = false
	end

	GameUtil.asBtn(formation):RemoveClickListener()
	GameUtil.asBtn(formation):AddClickListener(function()
		self:_onClickChallenge(data)
	end)
end

function LailisilevelsView:_clearItemCell()
	return
end

function LailisilevelsView:_setRole()
	local skinId = self._actCfg.challengePet

	uGuiUtil.clearImage(self._roleConGo)
	uGuiUtil.setSpriteToImage(self._roleConGo, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/challenge/%s.png", skinId))
end

function LailisilevelsView:setRedPoint(actId)
	local finallyActId = LailisiModel.instance:getFinalActivityId()
	local challengeCfg = LailisiConfig.instance:getChallengeCfg(finallyActId)

	if GameUtil.getUserDayData(challengeCfg.mainView .. actId) == nil then
		GameUtil.saveUserDayData(challengeCfg.mainView .. actId, 1)
	end
end

function LailisilevelsView:initPos(rect)
	if rect.anchoredPosition and LailisiModel.instance:getLastActId() ~= self._curActId then
		rect.anchoredPosition = Vector2.New(0, rect.anchoredPosition.y)
	end
end

function LailisilevelsView:_onClickTip()
	local ruleName = self._actCfg.ruleId

	TipsFacade.instance:openRulesView(ruleName)
end

function LailisilevelsView:_onClickChallenge(data)
	LailisiModel.instance._curActId = self._curActId

	CustomFmtController.instance:showMissionView(LailisiModel.instance:getCustomFmtMo(self._curActId, data.stageId))
end

return LailisilevelsView
