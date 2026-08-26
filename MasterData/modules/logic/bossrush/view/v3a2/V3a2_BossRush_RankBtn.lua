-- chunkname: @modules/logic/bossrush/view/v3a2/V3a2_BossRush_RankBtn.lua

module("modules.logic.bossrush.view.v3a2.V3a2_BossRush_RankBtn", package.seeall)

local V3a2_BossRush_RankBtn = class("V3a2_BossRush_RankBtn", LuaCompBase)

function V3a2_BossRush_RankBtn:onInitView()
	self._simageProp = gohelper.findChildSingleImage(self.viewGO, "#simage_Prop")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._imageIcon = gohelper.findChildImage(self.viewGO, "rank")
	self._imageSliderFG = gohelper.findChildImage(self.viewGO, "rank/#image_SliderFG")
	self._txtrank = gohelper.findChildText(self.viewGO, "rank/#txt_rank")
	self._goreddot = gohelper.findChild(self.viewGO, "#go_reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a2_BossRush_RankBtn:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function V3a2_BossRush_RankBtn:removeEvents()
	self._btnclick:RemoveClickListener()
end

function V3a2_BossRush_RankBtn:_btnclickOnClick()
	BossRushController.instance:openV3a2RankView()
end

function V3a2_BossRush_RankBtn:init(go)
	self.viewGO = go

	self:onInitView()
end

function V3a2_BossRush_RankBtn:addEventListeners()
	self:addEvents()
end

function V3a2_BossRush_RankBtn:removeEventListeners()
	self:removeEvents()
end

function V3a2_BossRush_RankBtn:_editableInitView()
	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.BossRushRankBonus)
end

function V3a2_BossRush_RankBtn:onDestroy()
	ZProj.TweenHelper.KillByObj(self._imageSliderFG)
end

function V3a2_BossRush_RankBtn:refreshUI()
	local rank = V3a2_BossRushModel.instance:getRank()

	self._txtrank.text = rank
	self._imageSliderFG.fillAmount = self:_getFillAmount()

	UISpriteSetMgr.instance:setV1a4BossRushSprite(self._imageIcon, V3a2_BossRushModel.instance:getRankLevelBg(rank))
end

function V3a2_BossRush_RankBtn:_getFillAmount()
	local exp, needExp = V3a2_BossRushModel.instance:getRankExpProgress()

	return (Mathf.Clamp01(exp / needExp))
end

function V3a2_BossRush_RankBtn:playAnim()
	ZProj.TweenHelper.KillByObj(self._imageSliderFG)

	local fillAmount = self:_getFillAmount()
	local rank = V3a2_BossRushModel.instance:getRank()

	self._txtrank.text = rank

	UISpriteSetMgr.instance:setV1a4BossRushSprite(self._imageIcon, V3a2_BossRushModel.instance:getRankLevelBg(rank))

	if self._imageSliderFG.fillAmount == fillAmount then
		return
	end

	if fillAmount > self._imageSliderFG.fillAmount then
		ZProj.TweenHelper.DOFillAmount(self._imageSliderFG, fillAmount, 0.3, nil, nil, nil, EaseType.Linear)
	else
		self._imageSliderFG.fillAmount = fillAmount
	end
end

return V3a2_BossRush_RankBtn
