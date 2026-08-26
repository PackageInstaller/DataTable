-- chunkname: @modules/logic/versionactivity1_5/aizila/view/AiZiLaEpsiodeDetailView.lua

module("modules.logic.versionactivity1_5.aizila.view.AiZiLaEpsiodeDetailView", package.seeall)

local AiZiLaEpsiodeDetailView = class("AiZiLaEpsiodeDetailView", BaseView)

function AiZiLaEpsiodeDetailView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "LevelPanel/#simage_PanelBG")
	self._txtTitleNum = gohelper.findChildText(self.viewGO, "LevelPanel/#txt_TitleNum")
	self._txtTitle = gohelper.findChildText(self.viewGO, "LevelPanel/#txt_Title")
	self._simageLevelPic = gohelper.findChildSingleImage(self.viewGO, "LevelPanel/#simage_LevelPic")
	self._scrollDescr = gohelper.findChildScrollRect(self.viewGO, "LevelPanel/#scroll_Descr")
	self._txtDescr = gohelper.findChildText(self.viewGO, "LevelPanel/#scroll_Descr/Viewport/Content/#txt_Descr")
	self._simagePanelBGMask = gohelper.findChildSingleImage(self.viewGO, "LevelPanel/#simage_PanelBGMask")
	self._scrollrewards = gohelper.findChildScrollRect(self.viewGO, "LevelPanel/Reward/#scroll_rewards")
	self._gorewards = gohelper.findChild(self.viewGO, "LevelPanel/Reward/#scroll_rewards/Viewport/#go_rewards")
	self._btnStart = gohelper.findChildButtonWithAudio(self.viewGO, "LevelPanel/Reward/Btn/#btn_Start")
	self._gotarget = gohelper.findChild(self.viewGO, "LevelPanel/#go_target")
	self._gotargetItem = gohelper.findChild(self.viewGO, "LevelPanel/#go_target/#go_targetItem")
	self._goTargetSelect = gohelper.findChild(self.viewGO, "LevelPanel/#go_target/#go_targetItem/#go_TargetSelect")
	self._txttargetName = gohelper.findChildText(self.viewGO, "LevelPanel/#go_target/#go_targetItem/target/#txt_targetName")
	self._txttergetHeight = gohelper.findChildText(self.viewGO, "LevelPanel/#go_target/#go_targetItem/target/#txt_tergetHeight")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AiZiLaEpsiodeDetailView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnStart:AddClickListener(self._btnStartOnClick, self)
end

function AiZiLaEpsiodeDetailView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnStart:RemoveClickListener()
end

function AiZiLaEpsiodeDetailView:_btncloseOnClick()
	self:closeThis()
end

function AiZiLaEpsiodeDetailView:_btnStartOnClick()
	if self._episodeCfg then
		self:playViewAnimator("go")
		AiZiLaGameController.instance:enterGame(self._episodeCfg.episodeId)
	end
end

function AiZiLaEpsiodeDetailView:_editableInitView()
	self._animator = self.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)
	self._targetTbList = {
		self:_createTargetTB(self._gotargetItem)
	}

	for i = #self._targetTbList + 1, 3 do
		local goclone = gohelper.cloneInPlace(self._gotargetItem)

		table.insert(self._targetTbList, self:_createTargetTB(goclone))
	end

	self._goodsItemGo = self:getResInst(AiZiLaGoodsItem.prefabPath, self.viewGO)

	gohelper.setActive(self._goodsItemGo, false)
end

function AiZiLaEpsiodeDetailView:onUpdateParam()
	return
end

function AiZiLaEpsiodeDetailView:playViewAnimator(animName)
	if self._animator then
		self._animator.enabled = true

		self._animator:Play(animName, 0, 0)
	end
end

function AiZiLaEpsiodeDetailView:onOpen()
	if self.viewContainer then
		NavigateMgr.instance:addEscape(self.viewContainer.viewName, self._btncloseOnClick, self)
	end

	local episodeId = self.viewParam.episodeId
	local actId = self.viewParam.actId

	self._episodeCfg = AiZiLaConfig.instance:getEpisodeCo(actId, episodeId)

	if self._episodeCfg then
		self._simageFullBG:LoadImage(string.format("%s.png", self._episodeCfg.bgPath))
		self._simageLevelPic:LoadImage(string.format("%s.png", self._episodeCfg.picture))

		self._rewardDataList = AiZiLaHelper.getEpisodeReward(self._episodeCfg.showBonus)
	end

	self._rewardDataList = self._rewardDataList or {}

	self:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.ui_wulu_aizila_level_open)
end

function AiZiLaEpsiodeDetailView:onClose()
	return
end

function AiZiLaEpsiodeDetailView:onDestroyView()
	self._simageFullBG:UnLoadImage()
	self._simageLevelPic:UnLoadImage()
end

function AiZiLaEpsiodeDetailView:refreshUI()
	if self._episodeCfg then
		self._txtTitleNum.text = self._episodeCfg.nameen
		self._txtTitle.text = self._episodeCfg.name
		self._txtDescr.text = self._episodeCfg.desc
	end

	gohelper.CreateObjList(self, self._onShowRewardItem, self._rewardDataList, self._gorewards, self._goodsItemGo, AiZiLaGoodsItem)
	self:_refreshTargetTB()
end

function AiZiLaEpsiodeDetailView:_onShowRewardItem(cell_component, data, index)
	cell_component:setShowCount(false)
	cell_component:onUpdateMO(data)
end

function AiZiLaEpsiodeDetailView:_createTargetTB(go)
	local tb = self:getUserDataTb_()

	tb.go = go
	tb._goTargetSelect = gohelper.findChild(go, "#go_TargetSelect")
	tb._txttargetName = gohelper.findChildText(go, "target/#txt_targetName")
	tb._txttergetHeight = gohelper.findChildText(go, "target/#txt_tergetHeight")

	return tb
end

function AiZiLaEpsiodeDetailView:_updateTargetTB(tb, targetId, isSelect)
	if tb.targetId ~= targetId then
		tb.targetId = targetId

		local cfg = AiZiLaConfig.instance:getEpisodeShowTargetCo(tb.targetId)

		gohelper.setActive(tb.go, cfg)

		if cfg then
			tb._txttargetName.text = cfg.name
			tb._txttergetHeight.text = string.format("%sm", cfg.elevation)

			SLFramework.UGUI.GuiHelper.SetColor(tb._txttargetName, cfg.colorStr)
			SLFramework.UGUI.GuiHelper.SetColor(tb._txttergetHeight, cfg.colorStr)
		end
	end
end

function AiZiLaEpsiodeDetailView:_refreshTargetTB()
	if self._episodeCfg then
		local targetIds = string.splitToNumber(self._episodeCfg.showTargets, "|")

		for i = 1, #self._targetTbList do
			local targetTb = self._targetTbList[i]
			local targetId = targetIds and targetIds[i]

			self:_updateTargetTB(targetTb, targetId)
		end
	end
end

return AiZiLaEpsiodeDetailView
