-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawCardShowPanel.lua

local ModelTool = require("Entity/ModelTool")
local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local DrawCardConfig = require("DesignerScript/DrawCardConfig")
local ResColor = require("ClientData/ResColor")
local ShareAchievePanel = require("UI/Achieve/ShareAchievePanel")
local HeroCVNamePanel = require("UI/HandBook/HeroCVNamePanel")
local strClassName = "DrawCardShowPanel"
local DrawCardShowPanel = Class(strClassName, UIControls.Panel)
local DrawCardHeroInfoPanel = Class("DrawCardHeroInfoPanel", UIControls.Panel)

function DrawCardHeroInfoPanel:ctor(...)
	self:initUI()
end

function DrawCardHeroInfoPanel:initUI(...)
	self.nameTxt = UIControls.Label(self, self.mPath .. "/TextName")
	self.tipsBtn = UIControls.Button(self, self.mPath .. "/TextName/BtnTips")

	self.tipsBtn:addEventClick(self.onClickTips)

	self.groupIcon = UIControls.Image(self, self.mPath .. "/IconCamp")
	self.groupNameTxt = UIControls.Label(self, self.mPath .. "/IconCamp/TextCamp")
	self.groupLogoTxt = UIControls.Label(self, self.mPath .. "/IconCamp/TextLogo")
	self.careerIcon = UIControls.Image(self, self.mPath .. "/TextJob/IconJob")
	self.btnPanel = UIControls.Panel(self, self.mPath .. "/BtnPanel")
	self.closeBtn = UIControls.Button(self, self.mPath .. "/BtnPanel/BtnClose")

	self.closeBtn:addEventClick(self._onClickClose)

	self.confirmBtn = UIControls.Button(self, self.mPath .. "/BtnPanel/BtnConfirm")
	self.againBtn = UIControls.Button(self, self.mPath .. "/BtnPanel/BtnAgain")

	self.againBtn:addEventClick(self._onClickAgain)

	self.againNumTxt = UIControls.Label(self, self.mPath .. "/BtnPanel/BtnAgain/TextNum")
	self.againBubble = UIControls.Image(self, self.mPath .. "/BtnPanel/BtnAgain/ImgBubble")
	self.againBubbleTxt = UIControls.Label(self, self.mPath .. "/BtnPanel/BtnAgain/ImgBubble/Text")
	self.againCostImg = UIControls.Image(self, self.mPath .. "/BtnPanel/BtnAgain/Icon")
	self.againCostTxt = UIControls.Label(self, self.mPath .. "/BtnPanel/BtnAgain/TextNum")
	self.starAniDict = {}
	self.probabilityNoticePanel = UIControls.Panel(self, self.mPath .. "/BtnPanel/ImgProbability")
	self.probabilityNoticeTxt = UIControls.Label(self, self.mPath .. "/BtnPanel/ImgProbability/TextUp")
	self.panelCVName = HeroCVNamePanel(self, self.mPath .. "/CvPanel")

	if UIControls.checkControlFunc(self, self.mPath .. "/BgSubtitle") then
		self.bgBullet = UIControls.Image(self, self.mPath .. "/BgSubtitle")
		self.txtBullet = UIControls.Label(self, self.mPath .. "/BgSubtitle/Text")
	end
end

function DrawCardHeroInfoPanel:showHighQualityHero(needShow)
	self.needShowExtraUI = needShow

	if needShow then
		self.audioPanel = UIControls.LazyAudioPlayer(self, self.mPath .. "/AudioPanel")
		self.sharePanel = ShareAchievePanel(self, self.mPath .. "/SharePanel")
	end

	if needShow then
		self.careerTxt = UIControls.Label(self, self.mPath .. "/TextJob")
	else
		self.careerTxt = UIControls.Label(self, self.mPath .. "/TextJob/TextJob")
	end
end

local AudioPathDict = {
	[Const.HERO_QUALITY_A] = "Audios/SFX/UI/ui_Heropool_Purplequality.ogg",
	[Const.HERO_QUALITY_S] = "Audios/SFX/UI/ui_Heropool_goldquality.ogg",
	[Const.HERO_QUALITY_SS] = "Audios/SFX/UI/ui_Heropool_goldquality.ogg"
}

function DrawCardHeroInfoPanel:setHeroInfo(hero)
	if not hero then
		return
	end

	if self.needShowExtraUI and self.audioPanel then
		local audioPath = AudioPathDict[hero.quality]

		self.audioPanel:setAudioPath(audioPath or "")
	end

	if self.bgBullet then
		self:setBulletShow(hero)
	end

	if self.starAniDict[hero.star] then
		self:playPanelAni(self.starAniDict[hero.star])
	end

	self.nameTxt:setText(hero.fullName or "")

	if self.needShowExtraUI then
		if not self.heroImg then
			self.heroImg = UIControls.Role(self, self.mPath .. "/MaskHero/ImgHero", 0, 0)
		end

		self.heroImg:showRole(hero.id, UIConst.ROLEIMAGE_SHOWTYPE_DRAW_CARD)

		self.shareVisible = hero.star >= DrawCardConfig.SHOW_SHARE_STAR

		if self.shareVisible then
			if self.mParent.actId and CurAvatar:drawActivityHasShareAward(self.mParent.actId, hero.id) then
				self.sharePanel:setActivityInfo(self.mParent.actId, "drawCardOperateDlg")
			else
				self.sharePanel:setAchieveInfo(Const.ACHIEVE_TYPE_SHARE_STANDARDDRAW, "drawCardOperateDlg")
			end
		end

		self.sharePanel:setShareVisible(self.shareVisible)

		local actObj = CurAvatar:getActivityObj(CurAvatar.drawOpActId)

		if actObj and actObj.actData:checkIsOldRoleUpDraw() then
			self.sharePanel:hideAwardPanel(true)
		end
	end

	local groupIconPath = hero:getGroupLargePath()

	if groupIconPath then
		self.groupIcon:setImage(groupIconPath[1], groupIconPath[2])
	end

	local camp = hero.camp

	self.groupNameTxt:setText(Const.CAMP_CONFIG[camp].name or "")
	self.groupLogoTxt:setText("FULI·" .. (Const.CAMP_CONFIG[camp].en_name or ""))

	local careerIconPath = hero:getCareerPath()

	if careerIconPath then
		self.careerIcon:setImage(careerIconPath[1], careerIconPath[2])
	end

	local career = hero.career

	self.careerTxt:setText(Const.CAREER_CONFIG[career].name or "")
	self.panelCVName:setHero(hero)
end

function DrawCardHeroInfoPanel:setBulletShow(hero)
	self.bgBullet:setVisible(false)

	if not hero then
		return
	end

	local voiceId = ClientUtils.getHeroVoiceIdByType(hero.id, Const.HERO_VOCAL_GET)

	if voiceId then
		local showState, desc = ClientUtils.checkCanShowVoCalBullet(voiceId)

		if showState and desc then
			self.txtBullet:setText(desc)
			self.bgBullet:setVisible(true)
		end
	end
end

function DrawCardHeroInfoPanel:playPanelAni(aniName)
	self:playAnimator(aniName)
end

function DrawCardHeroInfoPanel:onClickTips(...)
	UIManager.getUI("heroTips"):showObj(self.mWindow, self.mParent.selectedHero)
end

function DrawCardHeroInfoPanel:onClickNext(...)
	self.mParent:onClickNext()
end

function DrawCardHeroInfoPanel:setResultBtns(visible, drawType, items, poolInfoCache)
	self.btnPanel:setVisible(visible)

	if visible then
		self.drawType = drawType
		self.drawCount = #items
		self.needItemId = CurAvatar.drawNeedItemId or poolInfoCache.drawNeedItemId
		self.needItemNum = CurAvatar.drawNeedItemNum or poolInfoCache.drawNeedItemNum
		self.poolId = CurAvatar.drawPoolId or poolInfoCache.drawPoolId
		self.groupId = CurAvatar.drawDroup or poolInfoCache.drawDroup
		self.actId = CurAvatar.drawOpActId or poolInfoCache.drawOpActId

		if drawType == Const.DrawTypeStandard or drawType == Const.DrawTypeCustom or drawType == Const.DrawTypeGroup then
			self.confirmBtn:setVisible(false)
			self.closeBtn:setText(Lang.get(30260))

			local poolClientInfo = DrawCardUtils.getPoolClientInfo(self.poolId)

			if poolClientInfo then
				local poolName = poolClientInfo.title or ""

				self.againBubble:setVisible(true)
				self.againBubbleTxt:setText(string.format(Lang.get(30258), poolName))
			end

			local itemEnough, realNeedItem, realNeedNum = DrawCardUtils.checkDrawCost(self.poolId, self.drawCount, true)

			if itemEnough then
				self.againBtn:setVisible(true)
				self.againBtn:setText(string.format(Lang.get(30259), Const.NUMBER_TO_WORD[self.drawCount]))
				self.againNumTxt:setVisible(false)

				self.needItemId = realNeedItem
				self.needItemNum = realNeedNum

				local needItemObj = BaseObject.GetObject(self.needItemId)

				if needItemObj then
					local needItemIconPath = needItemObj:getIconPath()

					self.againCostImg:setVisible(true)
					self.againCostImg:setImage(needItemIconPath[1], needItemIconPath[2])
					self.againCostTxt:setVisible(true)
					self.againCostTxt:setText(realNeedNum)
				else
					self.againCostImg:setVisible(false)
					self.againCostTxt:setVisible(false)
				end
			else
				self.againBtn:setVisible(false)
				self.closeBtn:setFontColor(ResColor.WHITE)
				self.closeBtn:setImage("Atlas/CommonAtlas/BtnAtlas2", "BtnCommonFir01Nml")
			end

			local needProbalityNotice = DrawCardUtils.isNextProbiliatyUp(items)

			self.probabilityNoticePanel:setVisible(needProbalityNotice)

			if needProbalityNotice then
				self.probabilityNoticeTxt:setText(DrawCardUtils.probilityUpText())
			end

			local actObj = CurAvatar:getActivityObj(self.actId)

			if actObj and actObj.actType == Const.ACT_TYPE_DRAW_NEWBIE_UP then
				if actObj.actData:checkCanDrawAgainByPoolId(self.poolId, self.drawCount) then
					self.againBtn:setVisible(true)
				else
					self.againBtn:setVisible(false)
				end
			end
		end
	end
end

function DrawCardHeroInfoPanel:_onClickAgain(...)
	if self.drawType == Const.DrawTypeCustom and not DrawCardUtils.checkOpActCanDraw(self.actId) then
		self:_onClickClose()

		return
	end

	if not DrawCardUtils.checkBag(self.drawCount) then
		return
	end

	local drawCost, moneyId, needMoney = DrawCardUtils.checkDrawCost(self.poolId, self.drawCount)

	if drawCost ~= false then
		if drawCost == Const.DrawCostTypeConsume then
			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(30264), string.format(Lang.get(30263), needMoney), Functor(self._realAgain, self, drawCost), nil, -1)
		else
			self:_realAgain(drawCost)
		end
	end
end

function DrawCardHeroInfoPanel:_realAgain(drawCost)
	if self.drawType ~= Const.DrawTypeCustom then
		DrawCardUtils.realDrawCard(self.drawType, self.drawCount, drawCost, self.needItemId, self.needItemNum, self.poolId, self.groupId)
	else
		DrawCardUtils.realDrawOpActCard(self.actId, self.drawCount, drawCost, self.needItemId, self.needItemNum, self.poolId)
	end
end

function DrawCardHeroInfoPanel:_onClickClose(...)
	CueManager.stopVocal()

	local optDlg = UIManager.getUI("drawCardOperateDlg", nil, false)

	if optDlg then
		optDlg:setVisible(false)
	end

	if self.shareVisible then
		CurAvatar:tryOpenGameEvaluateDlg("DrawCardHeroInfoPanel")
	end
end

function DrawCardShowPanel:ctor(...)
	self:initUI()
end

function DrawCardShowPanel:initUI(...)
	self.highInfoPanel = DrawCardHeroInfoPanel(self, self.mPath .. "/HighInfoPanel")

	self.highInfoPanel:showHighQualityHero(true)

	self.lowInfoPanel = DrawCardHeroInfoPanel(self, self.mPath .. "/LowInfoPanel")

	self.lowInfoPanel:showHighQualityHero(false)

	self.highInfoPanel.starAniDict = {
		nil,
		nil,
		"OpenBoxHighPanelDis",
		"OpenBoxHighPanelDis",
		"OpenBoxHighPanelNml",
		"OpenBoxHighPanelPink"
	}
	self.lowInfoPanel.starAniDict = {
		[2] = "OpenBoxLowPanelNml",
		[1] = "OpenBoxLowPanelDis"
	}
	self.blockBtn = UIControls.Button(self, self.mPath .. "/Block")

	self.blockBtn:addEventClick(self.onClickNext)

	self.optPanelAni = UIControls.UIAni(self, self.mPath)
end

function DrawCardShowPanel:setResults(drawType, items, poolInfo)
	self.modelStage = self.mParent.modelStage

	if not items or #items < 1 then
		self:_endShow()

		return
	end

	self.drawType = drawType
	self.itemList = items
	self.poolInfoCache = poolInfo
	self.actId = CurAvatar.drawOpActId or poolInfo.drawOpActId
	self.isSingle = #items == 1
	self.curShowIndex = 1

	self.blockBtn:setVisible(true)
	self:_showHeroByIndex()
end

function DrawCardShowPanel:_showHeroByIndex()
	if self.curShowIndex > #self.itemList then
		self:_endShow()

		return
	end

	local hero = self.itemList[self.curShowIndex]
	local skipThis = false

	if not self.isSingle then
		skipThis = hero.star <= DrawCardConfig.SKIP_SHOW_START
	end

	if skipThis then
		self:onClickNext()
	else
		self:setHero(hero, hero.star >= DrawCardConfig.SHOW_HIGH_QUALITY_UI)
	end
end

function DrawCardShowPanel:setHero(hero, useHighPanel)
	if not hero then
		return
	end

	if self.notFirstHero then
		self.modelStage:moveCameraLocal(DrawCardConfig.DEFAULT_CAM_POS, DrawCardConfig.DEFAULT_CAM_ROTATE)
	else
		self.notFirstHero = true
	end

	if self.curInfoPanel then
		self.curInfoPanel:setVisible(false)
	end

	self.modelStage:clearQualityLogo()

	if self.showTimeCo then
		coroutine.stop(self.showTimeCo)
	end

	local isSameModel = self.selectedHero ~= nil and self.selectedHero.resData.model == hero.resData.model

	self.selectedHero = hero

	if self.preModelEffId then
		EffectManager:releaseEffect(self.preModelEffId)

		self.preModelEffId = nil
	end

	if isSameModel == false then
		if self.curModelId then
			self.modelStage:delModel(self.curModelId)
		end

		local anchorIndex = 1

		if self.isSingle then
			anchorIndex = 2
		end

		self.needAddBase = true

		local modelId = hero:getShowModelId()
		local baseModelId = hero:getShowBaseModelId()

		self.curModelId = self.modelStage:showHeroByModId(modelId, Const.MODEL_TYPE.ShowStepOne, anchorIndex, Functor(self._onModelLoaded, self, hero, useHighPanel), nil, baseModelId)
	else
		self:_onModelLoaded(hero, useHighPanel, self.curModelId)
	end

	CueManager.stopVocal()
	CueManager.playHeroVocal(hero.id, Const.HERO_VOCAL_GET)
end

function DrawCardShowPanel:_coShowHero(hero, useHighPanel)
	if useHighPanel then
		coroutine.wait(DrawCardConfig.MODEL_FALL_TIME)

		if self:_coPlayCam(hero.id) then
			coroutine.wait(DrawCardConfig.CAM_MOVE_TIME)
		end

		self:_coPlayUIAni(hero, useHighPanel)
	else
		coroutine.wait(DrawCardConfig.MODEL_FALL_TIME)
		self:_coPlayUIAni(hero, useHighPanel)
	end
end

function DrawCardShowPanel:_coPlayCam(heroId)
	local camPos, camRotate, camCue = UIConst.getHeroDrawCameraInfo(heroId)

	if camPos then
		self.modelStage:moveRotateCameraSmooth(camPos, camRotate, DrawCardConfig.SPECIAL_CAM_DURATION)
	end

	self.modelStage:revertPostProcessing()

	if camCue then
		self.modelStage:playPostProcessing(camCue)
	end

	return camPos ~= nil
end

function DrawCardShowPanel:_coPlayUIAni(hero, useHighPanel)
	self.highInfoPanel:setVisible(useHighPanel)
	self.lowInfoPanel:setVisible(not useHighPanel)

	if useHighPanel then
		self.curInfoPanel = self.highInfoPanel

		self.optPanelAni:startAni("OpenBoxHighInfoShow", true)
	else
		self.curInfoPanel = self.lowInfoPanel

		self.optPanelAni:startAni("OpenBoxLowInfoShow", true)
	end

	self.curInfoPanel:setHeroInfo(hero)

	if self.isSingle then
		self.curInfoPanel:setResultBtns(true, self.drawType, self.itemList, self.poolInfoCache)
		CurAvatar:_clearDrawCache()
	else
		self.curInfoPanel:setResultBtns(false)
	end

	self.modelStage:showQualityLogo(hero.star)
end

function DrawCardShowPanel:clear()
	if self.modelStage then
		if self.curModelId then
			self.modelStage:delModel(self.curModelId)

			self.curModelId = nil
		end

		self.modelStage:clearQualityLogo()
	end

	self.selectedHero = nil

	if self.showTimeCo then
		coroutine.stop(self.showTimeCo)
	end

	CueManager.stopVocal()

	if self.preModelEffId then
		EffectManager:releaseEffect(self.preModelEffId)

		self.preModelEffId = nil
	end
end

function DrawCardShowPanel:_onModelLoaded(hero, useHighPanel, modelID)
	self:_modelPlayAnimation(modelID)

	if self.showTimeCo then
		coroutine.stop(self.showTimeCo)
	end

	self.showTimeCo = coroutine.start(self._coShowHero, self, hero, useHighPanel)
end

function DrawCardShowPanel:_modelPlayAnimation(modelID)
	ModelTool.modelPlayAnimation(modelID, "Newshow_idle")

	if self.needAddBase and self.selectedHero then
		ModelTool.addBaseModel(modelID, self.selectedHero.resData.model, 1, Const.HERO_BASE_TYPE.Hero1)

		self.needAddBase = nil
	end

	local model = self.modelStage:getModel(modelID)

	if model and self.selectedHero then
		if self.selectedHero.star == 6 then
			self.preModelEffId = EffectManager:playTransformEffect(model.transform, "Effects/Scene/efx_Scene_carddisplay_pink.prefab", Const.EFFECT_LIFE_MODE.LogicControl)
		elseif self.selectedHero.star == 5 then
			self.preModelEffId = EffectManager:playTransformEffect(model.transform, "Effects/Scene/efx_Scene_carddisplay_orange.prefab", Const.EFFECT_LIFE_MODE.LogicControl)
		elseif self.selectedHero.star == 4 or self.selectedHero.star == 3 then
			self.preModelEffId = EffectManager:playTransformEffect(model.transform, "Effects/Scene/efx_Scene_carddisplay_purple.prefab", Const.EFFECT_LIFE_MODE.LogicControl)
		elseif self.selectedHero.star == 2 then
			self.preModelEffId = EffectManager:playTransformEffect(model.transform, "Effects/Scene/efx_Scene_carddisplay_blue.prefab", Const.EFFECT_LIFE_MODE.LogicControl)
		elseif self.selectedHero.star == 1 then
			self.preModelEffId = EffectManager:playTransformEffect(model.transform, "Effects/Scene/efx_Scene_carddisplay_green.prefab", Const.EFFECT_LIFE_MODE.LogicControl)
		end
	end
end

function DrawCardShowPanel:onClickNext(...)
	if not self.curShowIndex then
		return
	end

	if self.isSingle then
		return
	end

	self.curShowIndex = self.curShowIndex + 1

	self:_showHeroByIndex()
end

function DrawCardShowPanel:onClickSkip(...)
	local showNextHeroIdx
	local herosCount = #self.itemList

	if self.curShowIndex and herosCount > self.curShowIndex then
		for i = self.curShowIndex + 1, herosCount do
			local hero = self.itemList[i]

			if hero.star >= DrawCardConfig.SHOW_SHARE_STAR then
				showNextHeroIdx = i

				break
			end
		end
	end

	if showNextHeroIdx then
		self.curShowIndex = showNextHeroIdx

		self:_showHeroByIndex()
		self.mParent.skipAllBtn:setVisible(true)
	else
		self:_endShow()
	end
end

function DrawCardShowPanel:_endShow(...)
	if self.preModelEffId then
		EffectManager:releaseEffect(self.preModelEffId)

		self.preModelEffId = nil
	end

	self.notFirstHero = nil

	if self.isSingle then
		-- block empty
	else
		self:clear()
		self.optPanelAni:startAni("CloseBoxHighInfoShow", true)
		CurAvatar:showDrawResultDlg(self.drawType, self.itemList)
	end

	self.blockBtn:setVisible(false)
	self.mParent.skipAllBtn:setVisible(false)
end

function DrawCardShowPanel:_yieldClear()
	coroutine.step()
	CurAvatar:showDrawResultDlg(self.drawType, self.itemList)
end

return DrawCardShowPanel
