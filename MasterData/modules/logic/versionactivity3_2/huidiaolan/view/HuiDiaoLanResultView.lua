-- chunkname: @modules/logic/versionactivity3_2/huidiaolan/view/HuiDiaoLanResultView.lua

module("modules.logic.versionactivity3_2.huidiaolan.view.HuiDiaoLanResultView", package.seeall)

local HuiDiaoLanResultView = class("HuiDiaoLanResultView", BaseView)

function HuiDiaoLanResultView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._goBoard = gohelper.findChild(self.viewGO, "#go_Board")
	self._txtremainNum = gohelper.findChildText(self.viewGO, "#go_Board/Remain/#txt_remainNum")
	self._scrolldiamond = gohelper.findChildScrollRect(self.viewGO, "#go_Board/#scroll_diamond")
	self._godiamondContent = gohelper.findChild(self.viewGO, "#go_Board/#scroll_diamond/Viewport/#go_diamondContent")
	self._godiamondGroup = gohelper.findChild(self.viewGO, "#go_Board/#scroll_diamond/Viewport/#go_diamondContent/#go_diamondGroup")
	self._godiamondItem = gohelper.findChild(self.viewGO, "#go_Board/#scroll_diamond/Viewport/#go_diamondContent/#go_diamondGroup/#go_diamondItem")
	self._gotargets = gohelper.findChild(self.viewGO, "#go_targets")
	self._gotargetItem = gohelper.findChild(self.viewGO, "#go_targets/#go_targetitem")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._btnquitgame = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btns/#btn_quitgame")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btns/#btn_restart")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HuiDiaoLanResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnquitgame:AddClickListener(self._btnquitgameOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
end

function HuiDiaoLanResultView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnquitgame:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
end

HuiDiaoLanResultView.DiamondItemShowTime = 0.03

function HuiDiaoLanResultView:_btncloseOnClick()
	ViewMgr.instance:closeView(ViewName.HuiDiaoLanGameView, false, true)
	self:closeThis()
end

function HuiDiaoLanResultView:_btnquitgameOnClick()
	ViewMgr.instance:closeView(ViewName.HuiDiaoLanGameView, false, true)
	self:closeThis()
end

function HuiDiaoLanResultView:_btnrestartOnClick()
	HuiDiaoLanGameController.instance:dispatchEvent(HuiDiaoLanEvent.ResetGame)
	self:closeThis()
end

function HuiDiaoLanResultView:_editableInitView()
	self.diamondGroupItemMap = self:getUserDataTb_()
	self.diamondItemMap = self:getUserDataTb_()

	gohelper.setActive(self._godiamondGroup, false)
	gohelper.setActive(self._godiamondItem, false)
	gohelper.setActive(self._gotargets, false)

	self.targetDesc = gohelper.findChildText(self._gotargetItem, "txt_taskdesc")
	self.targetItemFinish = gohelper.findChild(self._gotargetItem, "result/go_finish")
	self.targetItemUnFinish = gohelper.findChild(self._gotargetItem, "result/go_unfinish")
end

function HuiDiaoLanResultView:onUpdateParam()
	return
end

function HuiDiaoLanResultView:onOpen()
	self.gameInfoData = HuiDiaoLanGameModel.instance:getGameInfoData()
	self.curDiamondCount = self.viewParam.curDiamondCount
	self.isSpEpisode = self.gameInfoData.isSpEpisode
	self.isWin = self.viewParam.isWin or self.isSpEpisode
	self.winTargetNum = self.gameInfoData.targetNum

	self:refreshUI()

	local curEpisodeId = HuiDiaoLanModel.instance:getCurEpisodeId()

	HuiDiaoLanGameModel.instance:setWinState(curEpisodeId, self.isWin)

	if self.isWin then
		AudioMgr.instance:trigger(AudioEnum3_2.HuiDiaoLan.play_ui_shengyan_hdl_win1)
	else
		AudioMgr.instance:trigger(AudioEnum3_2.HuiDiaoLan.play_ui_shengyan_hdl_fail)
	end
end

function HuiDiaoLanResultView:refreshUI()
	gohelper.setActive(self._gosuccess, self.isWin and not self.isSpEpisode)
	gohelper.setActive(self._gofail, not self.isWin and not self.isSpEpisode)
	gohelper.setActive(self._goBoard, self.isSpEpisode)
	gohelper.setActive(self._btnquitgame.gameObject, not self.isWin)
	gohelper.setActive(self._btnrestart.gameObject, not self.isWin)

	if self.isSpEpisode then
		self:showDiamond()
	else
		self:refreshTarget()
	end
end

function HuiDiaoLanResultView:showDiamond()
	local rowDiamondCount = 7

	self._txtremainNum.text = self.curDiamondCount
	self._scrolldiamond.verticalNormalizedPosition = 1
	self.diamondGroupCount = Mathf.Ceil(self.curDiamondCount / rowDiamondCount)

	for i = 1, self.diamondGroupCount do
		local diamondGroupItemMap = self.diamondGroupItemMap[i]

		if not diamondGroupItemMap then
			diamondGroupItemMap = {
				go = gohelper.clone(self._godiamondGroup, self._godiamondContent, "groupItem" .. i)
			}
			diamondGroupItemMap.horizontalLayoutGroup = diamondGroupItemMap.go:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
			self.diamondGroupItemMap[i] = diamondGroupItemMap
		end

		diamondGroupItemMap.horizontalLayoutGroup.padding.left = i % 2 == 0 and 50 or 0

		if rowDiamondCount < self.curDiamondCount then
			diamondGroupItemMap.horizontalLayoutGroup.childAlignment = UnityEngine.TextAnchor.MiddleLeft or UnityEngine.TextAnchor.MiddleCenter
		end

		gohelper.setActive(diamondGroupItemMap.go, true)
	end

	for index = 1, self.curDiamondCount do
		local diamondItemMap = self.diamondItemMap[index]

		if not diamondItemMap then
			diamondItemMap = {
				groupItem = self.diamondGroupItemMap[Mathf.Ceil(index / rowDiamondCount)]
			}
			diamondItemMap.go = gohelper.clone(self._godiamondItem, diamondItemMap.groupItem.go, "diamondItem" .. index)
			diamondItemMap.comp = MonoHelper.addNoUpdateLuaComOnceToGo(diamondItemMap.go, HuiDiaoLanResultDiamondItem, {
				index = index
			})
			self.diamondItemMap[index] = diamondItemMap
		end
	end
end

function HuiDiaoLanResultView:onOpenFinish()
	self:showDiamondAnim()
end

function HuiDiaoLanResultView:showDiamondAnim()
	for index = 1, self.curDiamondCount do
		local diamondItemMap = self.diamondItemMap[index]

		if diamondItemMap then
			diamondItemMap.comp:showAnim(HuiDiaoLanResultView.DiamondItemShowTime * index)
		end
	end

	if self.curDiamondCount > 0 and self.isSpEpisode then
		AudioMgr.instance:trigger(AudioEnum3_2.HuiDiaoLan.play_ui_shengyan_hdl_win2)
	end

	TaskDispatcher.runDelay(self.showScrollTween, self, 0.9)
end

function HuiDiaoLanResultView:showScrollTween()
	local allShowTitem = HuiDiaoLanResultView.DiamondItemShowTime * self.curDiamondCount

	self.scrollTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, allShowTitem, self.setDiamondScrollPos, self.setDiamondScrollPosDone, self)
end

function HuiDiaoLanResultView:setDiamondScrollPos(value)
	self._scrolldiamond.verticalNormalizedPosition = value
end

function HuiDiaoLanResultView:setDiamondScrollPosDone()
	self._scrolldiamond.verticalNormalizedPosition = 0
end

function HuiDiaoLanResultView:refreshTarget()
	gohelper.setActive(self._gotargets, true)
	gohelper.setActive(self._gotargetItem, true)
	gohelper.setActive(self.targetItemFinish, self.isWin)
	gohelper.setActive(self.targetItemUnFinish, not self.isWin)

	self.targetDesc.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("huidiaolan_win_target"), self.curDiamondCount, self.winTargetNum)
end

function HuiDiaoLanResultView:onClose()
	TaskDispatcher.cancelTask(self.showScrollTween, self)

	if self.scrollTweenId then
		ZProj.TweenHelper.KillById(self.scrollTweenId)

		self.scrollTweenId = nil
	end

	for index = 1, self.curDiamondCount do
		local diamondItemMap = self.diamondItemMap[index]

		if diamondItemMap then
			diamondItemMap.comp:stopAnim()
		end
	end
end

function HuiDiaoLanResultView:onDestroyView()
	return
end

return HuiDiaoLanResultView
