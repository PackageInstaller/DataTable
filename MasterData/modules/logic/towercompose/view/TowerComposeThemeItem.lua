-- chunkname: @modules/logic/towercompose/view/TowerComposeThemeItem.lua

module("modules.logic.towercompose.view.TowerComposeThemeItem", package.seeall)

local TowerComposeThemeItem = class("TowerComposeThemeItem", LuaCompBase)

function TowerComposeThemeItem:ctor(param)
	self.param = param
	self.themeView = param.themeView
	self.themeCo = param.themeCo
	self.themeId = self.themeCo.id
	self.scrollCategory = param.scrollCategory
	self.categoryContent = gohelper.findChild(self.scrollCategory.gameObject, "Viewport/#go_Content")
end

function TowerComposeThemeItem:init(go)
	self:__onInit()

	self.go = go
	self._txttheme = gohelper.findChildText(self.go, "theme/txt_theme")
	self._btnunfold = gohelper.findChildButtonWithAudio(self.go, "theme/btn_unfold")
	self._btnfold = gohelper.findChildButtonWithAudio(self.go, "theme/btn_fold")
	self._goepisodeContent = gohelper.findChild(self.go, "episodeContent")
	self._gonormalEpisodeContent1 = gohelper.findChild(self.go, "episodeContent/go_normalEpisodeContent1")
	self._gonormalEpisodeContent2 = gohelper.findChild(self.go, "episodeContent/go_normalEpisodeContent2")
	self._gofoldNormalTip = gohelper.findChild(self.go, "episodeContent/go_foldNormalTip")
	self._btnfoldTip = gohelper.findChildButtonWithAudio(self.go, "episodeContent/go_foldNormalTip/btn_foldTip")
	self._btnunfoldTip = gohelper.findChildButtonWithAudio(self.go, "episodeContent/go_foldNormalTip/btn_unfoldTip")
	self._goepisodeTip = gohelper.findChild(self.go, "episodeContent/go_episodeTip")
	self._goplaneUnlockTip = gohelper.findChild(self.go, "episodeContent/go_episodeTip/go_planeUnlockTip")
	self._txtplaneUnlockTip = gohelper.findChildText(self.go, "episodeContent/go_episodeTip/go_planeUnlockTip/txt_planeUnlockTip")
	self._gomodUnlockTip = gohelper.findChild(self.go, "episodeContent/go_episodeTip/go_modUnlockTip")
	self._goplaneEpisodeItem = gohelper.findChild(self.go, "episodeContent/go_planeEpisodeItem")
	self._goplaneSelect = gohelper.findChild(self.go, "episodeContent/go_planeEpisodeItem/go_planeSelect")
	self._gofirstPlane = gohelper.findChild(self.go, "episodeContent/go_planeEpisodeItem/plane/go_firstPlane")
	self._gosecondPlane = gohelper.findChild(self.go, "episodeContent/go_planeEpisodeItem/plane/go_secondPlane")
	self._gosecondPlaneLockIcon = gohelper.findChild(self.go, "episodeContent/go_planeEpisodeItem/plane/go_secondPlane/go_lockIcon")
	self._txtplaneName = gohelper.findChildText(self.go, "episodeContent/go_planeEpisodeItem/txt_planeName")
	self._btnplaneEpisode = gohelper.findChildButtonWithAudio(self.go, "episodeContent/go_planeEpisodeItem/btn_planeEpisode")
	self._gothemeReddot = gohelper.findChild(self.go, "theme/go_themeReddot")
	self._goplaneReddot = gohelper.findChild(self.go, "episodeContent/go_planeEpisodeItem/txt_planeName/go_planeReddot")
	self.unfoldThemeState = false
	self.needMoveToCurLayerTween = false
	self.normalEpisodeItemMap = self:getUserDataTb_()
	self.normalEpisodeItemList = self:getUserDataTb_()
	self.themeItemRect = self.go:GetComponent(gohelper.Type_RectTransform)
	self.categoryContentRect = self.categoryContent:GetComponent(gohelper.Type_RectTransform)
	self.goepisodeContentRect = self._goepisodeContent:GetComponent(gohelper.Type_RectTransform)
	self.normalEpisodeContent1Rect = self._gonormalEpisodeContent1:GetComponent(gohelper.Type_RectTransform)
	self.normalEpisodeContent2Rect = self._gonormalEpisodeContent2:GetComponent(gohelper.Type_RectTransform)
end

TowerComposeThemeItem.themeHeight = 80
TowerComposeThemeItem.normalSpace = 10
TowerComposeThemeItem.normalEpisodeHeight = 200
TowerComposeThemeItem.foldNormalTipHeight = 0
TowerComposeThemeItem.planeEpisodeHeight = 200
TowerComposeThemeItem.episodeTipHeight = 50
TowerComposeThemeItem.selectFontSize = 40
TowerComposeThemeItem.unselectFontSize = 28
TowerComposeThemeItem.selectFontPos = Vector2.New(28, 42)
TowerComposeThemeItem.normalFontPos = Vector2.New(8, 42)

function TowerComposeThemeItem:addEventListeners()
	self._btnunfold:AddClickListener(self._btnUnFoldOnClick, self)
	self._btnfold:AddClickListener(self._btnFoldOnClick, self)
	self._btnplaneEpisode:AddClickListener(self._btnPlaneEpisodeOnClick, self)
	TowerComposeController.instance:registerCallback(TowerComposeEvent.FoldTheme, self.onFoldItem, self)
	TowerComposeController.instance:registerCallback(TowerComposeEvent.UnfoldTheme, self.onUnfoldItem, self)
	TowerComposeController.instance:registerCallback(TowerComposeEvent.JumpThemeLayer, self.jumpThemeLayer, self)
	TowerComposeController.instance:registerCallback(TowerComposeEvent.SelectTargetThemeLayer, self.selectTargetThemeLayer, self)
end

function TowerComposeThemeItem:removeEventListeners()
	self._btnunfold:RemoveClickListener()
	self._btnfold:RemoveClickListener()
	self._btnplaneEpisode:RemoveClickListener()
	TowerComposeController.instance:unregisterCallback(TowerComposeEvent.FoldTheme, self.onFoldItem, self)
	TowerComposeController.instance:unregisterCallback(TowerComposeEvent.UnfoldTheme, self.onUnfoldItem, self)
	TowerComposeController.instance:unregisterCallback(TowerComposeEvent.JumpThemeLayer, self.jumpThemeLayer, self)
	TowerComposeController.instance:unregisterCallback(TowerComposeEvent.SelectTargetThemeLayer, self.selectTargetThemeLayer, self)
end

function TowerComposeThemeItem:_btnUnFoldOnClick(isEvent)
	self.themeView:setClickMaskState(true)

	local curUnfoldThemeId = TowerComposeModel.instance:getCurUnfoldThemeId()

	if self.themeId ~= curUnfoldThemeId and curUnfoldThemeId > 0 and not isEvent then
		TowerComposeModel.instance:setCurNeedUnfoldThemeId(self.themeId)
		TowerComposeController.instance:dispatchEvent(TowerComposeEvent.FoldTheme)

		return
	end

	TowerComposeModel.instance:setCurUnfoldThemeId(self.themeId)

	self.unfoldThemeState = true

	self:refreshItemHeight()
	recthelper.setHeight(self.normalEpisodeContent1Rect, self.normalEpisodeContent1Height)
	recthelper.setHeight(self.normalEpisodeContent2Rect, self.normalEpisodeContent2Height)
	self:refreshSelectState()
	self:doUnfoldThemeAnim(true)
	self:refreshFoldState()
end

function TowerComposeThemeItem:_btnFoldOnClick()
	self.themeView:setClickMaskState(true)

	self.unfoldThemeState = false

	TowerComposeModel.instance:setCurUnfoldThemeId(0)
	self:doUnfoldThemeAnim(false)
	self:refreshFoldState()
end

function TowerComposeThemeItem:_btnUnFoldTipOnClick()
	if not self.isMaxPlaneLayerUnlock or not self.unfoldThemeState then
		return
	end

	self.themeView:setClickMaskState(true)
	self:refreshItemHeight()
	recthelper.setHeight(self.normalEpisodeContent1Rect, self.normalEpisodeContent1Height)
	self:doUnfoldNormalTipAnim(true)
	self:refreshFoldState()
end

function TowerComposeThemeItem:_btnFoldTipOnClick()
	if not self.isMaxPlaneLayerUnlock or not self.unfoldThemeState then
		return
	end

	self.themeView:setClickMaskState(true)
	self:moveToTop()
	self:doUnfoldNormalTipAnim(false)
	self:refreshFoldState()
end

function TowerComposeThemeItem:_btnPlaneEpisodeOnClick()
	local curThemeId, curLayerId = TowerComposeModel.instance:getCurThemeIdAndLayer()

	if curThemeId == self.themeId and curLayerId == self.curUnlockPlaneLayerId then
		return
	end

	if self.curUnlockPlaneLayerId > 0 then
		local isChangeTheme = curThemeId ~= self.themeId

		TowerComposeModel.instance:setCurThemeIdAndLayer(self.themeId, self.curUnlockPlaneLayerId)
		self:refreshSelectState()
		TowerComposeController.instance:dispatchEvent(TowerComposeEvent.SelectThemeLayer, isChangeTheme)
		TowerComposeController.instance:dispatchEvent(TowerComposeEvent.SelectPlaneLayerGuide)
		AudioMgr.instance:trigger(AudioEnum.TowerCompose.play_ui_fight_tab_switch)
		AudioMgr.instance:trigger(AudioEnum.TowerCompose.play_ui_fight_full_lit)
	end
end

function TowerComposeThemeItem:_btnNormalEpisodeOnClick(episodeCo)
	self.curSelectLayer = episodeCo.layerId

	local curThemeId, curLayerId = TowerComposeModel.instance:getCurThemeIdAndLayer()

	if curThemeId == self.themeId and curLayerId == self.curSelectLayer then
		return
	end

	TowerComposeModel.instance:setCurThemeIdAndLayer(self.themeId, self.curSelectLayer)
	self:refreshSelectState()
	TowerComposeController.instance:dispatchEvent(TowerComposeEvent.SelectThemeLayer)
	AudioMgr.instance:trigger(AudioEnum.TowerCompose.play_ui_fight_tab_switch)
end

function TowerComposeThemeItem:selectTargetThemeLayer(layerId)
	if layerId == self.curUnlockPlaneLayerId then
		self:_btnPlaneEpisodeOnClick()
	else
		local episodeConfig = TowerComposeConfig.instance:getEpisodeConfig(self.themeId, layerId)

		self:_btnNormalEpisodeOnClick(episodeConfig)
	end
end

function TowerComposeThemeItem:refreshUI()
	self.totalThemeCount = TowerComposeModel.instance:getThemeCount()
	self._txttheme.text = self.themeCo.name
	self.passLayerId = TowerComposeModel.instance:getThemePassLayer(self.themeId)
	self.isMaxPlaneLayerUnlock, self.maxPlaneLayerId = TowerComposeModel.instance:isMaxPlaneLayerUnlock(self.themeId, self.passLayerId)

	gohelper.setActive(self._gofoldNormalTip, false)

	self.curUnlockPlaneLayerId, self.planeLayerIdList = TowerComposeModel.instance:getCurUnlockPlaneLayerId(self.themeId, self.passLayerId)
	self.isFirstPlaneUnlock = self.curUnlockPlaneLayerId > 0 and self.curUnlockPlaneLayerId == self.planeLayerIdList[1]

	gohelper.setActive(self._goplaneEpisodeItem, self.curUnlockPlaneLayerId > 0)
	gohelper.setActive(self._gofirstPlane, true)
	gohelper.setActive(self._gosecondPlane, true)

	if self.curUnlockPlaneLayerId > 0 then
		local planeEpisodeCo = TowerComposeConfig.instance:getEpisodeConfig(self.themeId, self.curUnlockPlaneLayerId)

		self._txtplaneName.text = planeEpisodeCo.name
	end

	self:refreshFoldState()
	self:refreshPlaneEpisodeTip()
	self:refreshNormalEpisodeItem()
	self:refreshItemHeight()
	self:setThemeHeight()
	self:refreshSelectState()
	self:moveToCurLayerPos()
	self:refreshReddot()
end

function TowerComposeThemeItem:refreshFoldState()
	local curUnfoldThemeId = TowerComposeModel.instance:getCurUnfoldThemeId()

	self.curThemeId, self.curLayerId = TowerComposeModel.instance:getCurThemeIdAndLayer()
	self.unfoldThemeState = self.themeId == curUnfoldThemeId

	gohelper.setActive(self._btnfold, self.unfoldThemeState)
	gohelper.setActive(self._btnunfold, not self.unfoldThemeState)
end

function TowerComposeThemeItem:refreshPlaneEpisodeTip()
	local isPassAllEpisode, finalLayer = TowerComposeModel.instance:isAllEpisodeFinish(self.themeId)

	gohelper.setActive(self._goepisodeTip, not isPassAllEpisode)

	if not isPassAllEpisode then
		gohelper.setActive(self._goplaneUnlockTip, not self.isMaxPlaneLayerUnlock and self.passLayerId < self.maxPlaneLayerId)
		gohelper.setActive(self._gomodUnlockTip, self.isMaxPlaneLayerUnlock and finalLayer > self.passLayerId)

		self._txtplaneUnlockTip.text = self.isFirstPlaneUnlock and not self.isMaxPlaneLayerUnlock and luaLang("towercompose_fightPlane2") or luaLang("towercompose_fightPlane1")
	end

	gohelper.setActive(self._gosecondPlaneLockIcon, not self.isMaxPlaneLayerUnlock)
	ZProj.UGUIHelper.SetGrayscale(self._gosecondPlane, not self.isMaxPlaneLayerUnlock)
end

function TowerComposeThemeItem:refreshNormalEpisodeItem()
	if not self.unfoldThemeState then
		return
	end

	self.normalEpisodeItemMap = self:getUserDataTb_()
	self.normalEpisodeItemList = self:getUserDataTb_()

	local allEpisodeConfigList = TowerComposeConfig.instance:getThemeAllEpisodeConfig(self.themeId)
	local passLayerConfig = TowerComposeConfig.instance:getEpisodeConfig(self.themeId, self.passLayerId)

	for _, episodeCo in ipairs(allEpisodeConfigList) do
		if episodeCo.plane == 0 and (self.passLayerId >= episodeCo.layerId or passLayerConfig and passLayerConfig.nextLayerId == episodeCo.layerId or episodeCo.layerId == 1) then
			local normalEpisodeItem = self.themeView:createOrGetPoolEpisodeItem(episodeCo, self._btnNormalEpisodeOnClick, self)

			gohelper.setActive(normalEpisodeItem.go, true)
			gohelper.setActive(normalEpisodeItem.goNormal, passLayerConfig and episodeCo.layerId == passLayerConfig.nextLayerId or self.passLayerId == 0)
			gohelper.setActive(normalEpisodeItem.goFinish, self.passLayerId >= episodeCo.layerId)

			normalEpisodeItem.txtName.text = episodeCo.name

			if self.isMaxPlaneLayerUnlock then
				if episodeCo.layerId > self.maxPlaneLayerId then
					local var_15_0 = self._gonormalEpisodeContent2

					if not self._gonormalEpisodeContent2 then
						var_15_0 = self._gonormalEpisodeContent1

						if not self._gonormalEpisodeContent1 then
							local parentGO = self["_gonormalEpisodeContent" .. episodeCo.stageId]

							normalEpisodeItem.go.transform:SetParent(parentGO.transform, false)
							recthelper.setAnchor(normalEpisodeItem.go.transform, 0, 0)
							ZProj.UGUIHelper.RebuildLayout(parentGO.transform)

							self.normalEpisodeItemMap[episodeCo.layerId] = normalEpisodeItem

							table.insert(self.normalEpisodeItemList, normalEpisodeItem)
						end
					end
				end
			end
		end
	end

	if #self.normalEpisodeItemList > 0 then
		self.themeView:recycleNormalEpisodeItem(#self.normalEpisodeItemList)
	end
end

function TowerComposeThemeItem:refreshItemHeight()
	local normalEpisodeContent1Count = 0
	local normalEpisodeContent2Count = 0
	local normalEpisodeContent3Count = 0

	for _, normalEpisodeItem in pairs(self.normalEpisodeItemMap) do
		if normalEpisodeItem.config.stageId == 1 then
			normalEpisodeContent1Count = normalEpisodeContent1Count + 1
		elseif normalEpisodeItem.config.stageId == 2 then
			normalEpisodeContent2Count = normalEpisodeContent2Count + 1
		elseif normalEpisodeItem.config.stageId == 3 then
			normalEpisodeContent3Count = normalEpisodeContent3Count + 1
		end
	end

	local canShowEpisodeContent2 = normalEpisodeContent2Count > 0 and not self.isMaxPlaneLayerUnlock or normalEpisodeContent3Count > 0

	if normalEpisodeContent3Count > 0 or self.isMaxPlaneLayerUnlock then
		normalEpisodeContent1Count = normalEpisodeContent1Count + normalEpisodeContent2Count
	end

	gohelper.setActive(self._gonormalEpisodeContent2, canShowEpisodeContent2)

	if self.isMaxPlaneLayerUnlock then
		self.normalEpisodeContent1Height = Mathf.Max(0, normalEpisodeContent1Count * TowerComposeThemeItem.normalEpisodeHeight + (normalEpisodeContent1Count - 1) * TowerComposeThemeItem.normalSpace)
		self.normalEpisodeContent2Height = normalEpisodeContent3Count > 0 and Mathf.Max(0, normalEpisodeContent3Count * TowerComposeThemeItem.normalEpisodeHeight + (normalEpisodeContent3Count - 1) * TowerComposeThemeItem.normalSpace) or 0
		self.episodeContentHeight = self.normalEpisodeContent1Height + self.normalEpisodeContent2Height + TowerComposeThemeItem.foldNormalTipHeight + TowerComposeThemeItem.planeEpisodeHeight
	else
		self.normalEpisodeContent1Height = Mathf.Max(0, normalEpisodeContent1Count * TowerComposeThemeItem.normalEpisodeHeight + (normalEpisodeContent1Count - 1) * TowerComposeThemeItem.normalSpace)
		self.normalEpisodeContent2Height = Mathf.Max(0, (canShowEpisodeContent2 or nil) and (normalEpisodeContent2Count * TowerComposeThemeItem.normalEpisodeHeight + (normalEpisodeContent2Count - 1) * TowerComposeThemeItem.normalSpace or 0))
		self.episodeContentHeight = self.normalEpisodeContent1Height + self.normalEpisodeContent2Height + ((self.isFirstPlaneUnlock or nil) and (TowerComposeThemeItem.planeEpisodeHeight or 0))
	end

	local isPassAllEpisode = TowerComposeModel.instance:isAllEpisodeFinish(self.themeId)

	self.episodeContentHeight = self.episodeContentHeight + (isPassAllEpisode and 0 or TowerComposeThemeItem.episodeTipHeight)
	self.totalHeight = TowerComposeThemeItem.themeHeight + self.episodeContentHeight

	if self.unfoldThemeState then
		self.episodeContentHeight = self.episodeContentHeight or 0
	end
end

function TowerComposeThemeItem:setThemeHeight()
	recthelper.setHeight(self.normalEpisodeContent1Rect, self.normalEpisodeContent1Height)
	recthelper.setHeight(self.normalEpisodeContent2Rect, self.normalEpisodeContent2Height)
	recthelper.setHeight(self.themeItemRect, self.episodeContentHeight + TowerComposeThemeItem.themeHeight)
	recthelper.setHeight(self.goepisodeContentRect, self.episodeContentHeight)

	if self.unfoldThemeState then
		recthelper.setHeight(self.categoryContentRect, self.totalHeight + (self.totalThemeCount - 1) * TowerComposeThemeItem.themeHeight)
	end
end

function TowerComposeThemeItem:onFoldItem()
	local curUnfoldThemeId = TowerComposeModel.instance:getCurUnfoldThemeId()

	if self.themeId == curUnfoldThemeId then
		self:moveToTop()
		self:_btnFoldOnClick()
	end
end

function TowerComposeThemeItem:onUnfoldItem(curNeedUnfoldThemeId)
	if self.themeId == curNeedUnfoldThemeId then
		TowerComposeModel.instance:setCurUnfoldThemeId(self.themeId)

		self.unfoldThemeState = true

		self:refreshNormalEpisodeItem()
		self:refreshSelectState()
		self:_btnUnFoldOnClick(true)
	end
end

function TowerComposeThemeItem:doUnfoldThemeAnim(isUnfold)
	self.needMoveToCurLayerTween = isUnfold

	if isUnfold then
		if not TowerComposeThemeItem.themeHeight then
			local curHeight = self.totalHeight

			if isUnfold then
				if not self.totalHeight then
					local targetHeight = TowerComposeThemeItem.themeHeight

					self._foldAnimTweenId = ZProj.TweenHelper.DOTweenFloat(curHeight, targetHeight, Mathf.Abs(self.totalHeight - TowerComposeThemeItem.themeHeight) * 0.0003, self._onUnfoldThemeTweenFrameCallback, self._onUnfoldThemeTweenFinishCallback, self)

					self:refreshNormalEpisodeItem()
				end
			end
		end
	end
end

function TowerComposeThemeItem:_onUnfoldThemeTweenFrameCallback(value)
	recthelper.setHeight(self.themeItemRect, value)
	recthelper.setHeight(self.goepisodeContentRect, value - TowerComposeThemeItem.themeHeight)
	recthelper.setHeight(self.categoryContentRect, value + (self.totalThemeCount - 1) * TowerComposeThemeItem.themeHeight)
	ZProj.UGUIHelper.RebuildLayout(self.categoryContentRect)
end

function TowerComposeThemeItem:_onUnfoldThemeTweenFinishCallback()
	self.themeView:setClickMaskState(false)
	self:refreshUI()

	local curNeedUnfoldThemeId = TowerComposeModel.instance:getCurNeedUnfoldThemeId()

	if curNeedUnfoldThemeId and curNeedUnfoldThemeId > 0 then
		TowerComposeModel.instance:setCurNeedUnfoldThemeId(0)
		TowerComposeController.instance:dispatchEvent(TowerComposeEvent.UnfoldTheme, curNeedUnfoldThemeId)
	end
end

function TowerComposeThemeItem:doUnfoldNormalTipAnim(isUnfold)
	local curHeight = isUnfold and 0 or self.episodeContentHeight

	if isUnfold then
		if not self.episodeContentHeight then
			local targetHeight = TowerComposeThemeItem.foldNormalTipHeight + TowerComposeThemeItem.planeEpisodeHeight

			self._foldTipAnimTweenId = ZProj.TweenHelper.DOTweenFloat(curHeight, targetHeight, (self.episodeContentHeight - TowerComposeThemeItem.foldNormalTipHeight - TowerComposeThemeItem.planeEpisodeHeight) * 0.0003, self._onUnfoldTipTweenFrameCallback, self._onUnfoldTipTweenFinishCallback, self)
		end
	end
end

function TowerComposeThemeItem:_onUnfoldTipTweenFrameCallback(value)
	recthelper.setHeight(self.themeItemRect, value + TowerComposeThemeItem.themeHeight)
	recthelper.setHeight(self.goepisodeContentRect, value)
	recthelper.setHeight(self.normalEpisodeContent1Rect, value - TowerComposeThemeItem.foldNormalTipHeight - TowerComposeThemeItem.planeEpisodeHeight)
	ZProj.UGUIHelper.RebuildLayout(self.categoryContentRect)
end

function TowerComposeThemeItem:_onUnfoldTipTweenFinishCallback()
	self.themeView:setClickMaskState(false)
	self:refreshItemHeight()
	self:setThemeHeight()
end

function TowerComposeThemeItem:moveToTop()
	local curUnfoldThemeId = TowerComposeModel.instance:getCurUnfoldThemeId()
	local categoryContentHeight = recthelper.getHeight(self.categoryContentRect)

	if curUnfoldThemeId > 0 and categoryContentHeight > TowerComposeEnum.scrollCategoryHeight then
		local moveToPos = TowerComposeThemeItem.themeHeight * Mathf.Max(curUnfoldThemeId - 1, 0)

		recthelper.setAnchorY(self.categoryContentRect, moveToPos)
	end
end

function TowerComposeThemeItem:moveToCurLayerPos()
	local curThemeId, curLayerId = TowerComposeModel.instance:getCurThemeIdAndLayer()
	local showLayerId = curLayerId

	for index, planeLayerId in ipairs(self.planeLayerIdList) do
		if planeLayerId < curLayerId then
			showLayerId = curLayerId - index
		end
	end

	local categoryContentHeight = recthelper.getHeight(self.categoryContentRect)

	if curThemeId == self.themeId and categoryContentHeight > TowerComposeEnum.scrollCategoryHeight then
		local moveToPos = TowerComposeThemeItem.themeHeight * Mathf.Max(curThemeId - 1, 0) + Mathf.Max(0, (showLayerId - 1) * TowerComposeThemeItem.normalEpisodeHeight + (showLayerId - 1) * TowerComposeThemeItem.normalSpace)

		if curLayerId == self.curUnlockPlaneLayerId then
			local normalEpisodeItemCount = tabletool.len(self.normalEpisodeItemMap)

			moveToPos = TowerComposeThemeItem.themeHeight * Mathf.Max(curThemeId - 1, 0) + Mathf.Max(0, (normalEpisodeItemCount - 1) * TowerComposeThemeItem.normalEpisodeHeight + (normalEpisodeItemCount - 1) * TowerComposeThemeItem.normalSpace)
		end

		if self.needMoveToCurLayerTween then
			local curCategoryPosY = recthelper.getAnchorY(self.categoryContentRect)

			self._moveToCurLayerTweenId = ZProj.TweenHelper.DOTweenFloat(curCategoryPosY, moveToPos, Mathf.Abs(categoryContentHeight - TowerComposeEnum.scrollCategoryHeight) * 0.0001, self.moveToCurLayerPosTweenFrameCallback, nil, self)
			self.needMoveToCurLayerTween = false
		else
			recthelper.setAnchorY(self.categoryContentRect, moveToPos)
		end

		ZProj.UGUIHelper.RebuildLayout(self.categoryContentRect)
	end
end

function TowerComposeThemeItem:moveToCurLayerPosTweenFrameCallback(value)
	recthelper.setAnchorY(self.categoryContentRect, value)
	ZProj.UGUIHelper.RebuildLayout(self.categoryContentRect)
end

function TowerComposeThemeItem:refreshSelectState()
	local curThemeId, curLayerId = TowerComposeModel.instance:getCurThemeIdAndLayer()

	for _, normalEpisodeItem in pairs(self.normalEpisodeItemMap) do
		local isSelect = curThemeId == self.themeId and curLayerId == normalEpisodeItem.config.layerId

		if isSelect then
			if not TowerComposeThemeItem.selectFontPos then
				local txtNamePos = TowerComposeThemeItem.normalFontPos

				gohelper.setActive(normalEpisodeItem.goSelect, isSelect)

				if isSelect then
					normalEpisodeItem.txtName.fontSize = TowerComposeThemeItem.selectFontSize or TowerComposeThemeItem.unselectFontSize
				end

				recthelper.setAnchor(normalEpisodeItem.txtName.transform, txtNamePos.x, txtNamePos.y)
			end
		end
	end

	local isPlaneSelect = curThemeId == self.themeId and curLayerId == self.curUnlockPlaneLayerId

	gohelper.setActive(self._goplaneSelect, isPlaneSelect)

	if isPlaneSelect then
		self._txtplaneName.fontSize = TowerComposeThemeItem.selectFontSize or TowerComposeThemeItem.unselectFontSize
	end

	if isPlaneSelect then
		if not TowerComposeThemeItem.selectFontPos then
			local txtPlaneNamePos = TowerComposeThemeItem.normalFontPos

			recthelper.setAnchor(self._txtplaneName.transform, txtPlaneNamePos.x, txtPlaneNamePos.y)
		end
	end
end

function TowerComposeThemeItem:jumpThemeLayer(param)
	if param and param.isJump then
		self:refreshFoldState()
		self:refreshNormalEpisodeItem()
		self:refreshItemHeight()
		self:setThemeHeight()

		if param.themeId == self.themeId then
			self:refreshSelectState()
			self:moveToCurLayerPos()
		end
	end
end

function TowerComposeThemeItem:refreshReddot()
	local researchCanShowReddot = TowerComposeTaskModel.instance:canShowReddot(TowerComposeEnum.TaskType.Research, self.themeId)
	local normalCanShowReddot = TowerComposeTaskModel.instance:canShowReddot(TowerComposeEnum.TaskType.Normal)
	local limitCanShowReddot = TowerComposeTaskModel.instance:canShowReddot(TowerComposeEnum.TaskType.LimitTime)

	gohelper.setActive(self._gothemeReddot, self.curUnlockPlaneLayerId > 0 and (researchCanShowReddot or normalCanShowReddot or limitCanShowReddot))
	gohelper.setActive(self._goplaneReddot, self.curUnlockPlaneLayerId > 0 and (researchCanShowReddot or normalCanShowReddot or limitCanShowReddot))
end

function TowerComposeThemeItem:onDestroy()
	if self._foldAnimTweenId then
		ZProj.TweenHelper.KillById(self._foldAnimTweenId)

		self._foldAnimTweenId = nil
	end

	if self._moveToCurLayerTweenId then
		ZProj.TweenHelper.KillById(self._moveToCurLayerTweenId)

		self._moveToCurLayerTweenId = nil
	end
end

return TowerComposeThemeItem
