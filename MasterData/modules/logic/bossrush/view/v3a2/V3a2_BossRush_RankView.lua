-- chunkname: @modules/logic/bossrush/view/v3a2/V3a2_BossRush_RankView.lua

module("modules.logic.bossrush.view.v3a2.V3a2_BossRush_RankView", package.seeall)

local V3a2_BossRush_RankView = class("V3a2_BossRush_RankView", BaseView)

function V3a2_BossRush_RankView:onInitView()
	self._simagefull = gohelper.findChildSingleImage(self.viewGO, "#simage_full")
	self._goinfo = gohelper.findChild(self.viewGO, "#go_info")
	self._txtDescr = gohelper.findChildText(self.viewGO, "#go_info/#txt_Descr")
	self._scrollprogress = gohelper.findChildScrollRect(self.viewGO, "#scroll_progress")
	self._btnLv = gohelper.findChildButtonWithAudio(self.viewGO, "Lv")
	self._imageSliderFG = gohelper.findChildImage(self.viewGO, "Lv/#image_SliderFG")
	self._txtrank = gohelper.findChildText(self.viewGO, "Lv/#txt_rank")
	self._goTips = gohelper.findChild(self.viewGO, "Lv/#go_Tips")
	self._txtTips = gohelper.findChildText(self.viewGO, "Lv/#go_Tips/#txt_Tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a2_BossRush_RankView:addEvents()
	self._btnLv:AddClickListener(self._btnLVOnClick, self)
end

function V3a2_BossRush_RankView:removeEvents()
	self._btnLv:RemoveClickListener()
end

function V3a2_BossRush_RankView:_btnLVOnClick()
	self:_showLvTxt(not self._isShowLvTxt)
end

function V3a2_BossRush_RankView:_editableInitView()
	self._levels = self:getUserDataTb_()

	for i = 1, 5 do
		local item = self:getUserDataTb_()
		local go = gohelper.findChild(self.viewGO, "Lv/leve" .. i)

		item.go = go
		item.simgLv = gohelper.findChildSingleImage(go, "Lv")
		self._levels[i] = item

		local icon = "v3a2_bossrush_rank_lvbg" .. i

		item.simgLv:LoadImage(ResUrl.getBossRushRankSinglebg(icon))
	end
end

function V3a2_BossRush_RankView:onUpdateParam()
	return
end

function V3a2_BossRush_RankView:onOpen()
	V3a2_BossRush_RankListModel.instance:setMoList()
	self:refreshUI()

	local exp, needExp = V3a2_BossRushModel.instance:getRankExpProgress()

	self._txtTips.text = string.format("%s/%s", exp, needExp)

	self:_showLvTxt(false)
end

function V3a2_BossRush_RankView:_showLvTxt(isShow)
	gohelper.setActive(self._goTips, isShow)

	self._isShowLvTxt = isShow
end

V3a2_BossRush_RankView.UI_CLICK_BLOCK_KEY = "V3a2_BossRush_RankView_UI_CLICK_BLOCK_KEY"

function V3a2_BossRush_RankView:_claimBonusCb()
	self:refreshUI()
	UIBlockMgr.instance:endBlock(V3a2_BossRush_RankView.UI_CLICK_BLOCK_KEY)
end

function V3a2_BossRush_RankView:claimRankBonus()
	if V3a2_BossRushModel.instance:isCanClaimRankBonus() then
		UIBlockMgr.instance:startBlock(V3a2_BossRush_RankView.UI_CLICK_BLOCK_KEY)

		local actId = BossRushConfig.instance:getActivityId()

		BossRushRpc.instance:sendAct128GetMilestoneBonusRequest(actId, self._claimBonusCb, self)
	end
end

function V3a2_BossRush_RankView:refreshUI()
	local moList = V3a2_BossRush_RankListModel.instance:getList()
	local content = self._scrollprogress.content

	if not self._res then
		local resPath = self.viewContainer:getSetting().otherRes[1]

		self._res = self.viewContainer:getRes(resPath)
	end

	gohelper.CreateObjList(self, self._createItemCB, moList, content.gameObject, self._res, V3a2_BossRush_RankBonus)

	local rank = V3a2_BossRushModel.instance:getRank()

	self._txtrank.text = rank

	local exp, needExp = V3a2_BossRushModel.instance:getRankExpProgress()

	self._imageSliderFG.fillAmount = Mathf.Clamp01(exp / needExp)

	local spLevelBg = V3a2_BossRushModel.instance:getRankSpLevelBg(rank)

	for i, item in pairs(self._levels) do
		gohelper.setActive(item.go, i == spLevelBg)
	end

	if moList and #moList > 0 then
		local firstCanGetBouns = V3a2_BossRush_RankListModel.instance:getFirstCanGetBouns()

		self._scrollprogress.horizontalNormalizedPosition = firstCanGetBouns / #moList
	end
end

function V3a2_BossRush_RankView:_createItemCB(obj, data, index)
	obj:onUpdateMO(data, self)
end

function V3a2_BossRush_RankView:onClose()
	return
end

function V3a2_BossRush_RankView:onDestroyView()
	for _, item in pairs(self._levels) do
		item.simgLv:UnLoadImage()
	end
end

return V3a2_BossRush_RankView
