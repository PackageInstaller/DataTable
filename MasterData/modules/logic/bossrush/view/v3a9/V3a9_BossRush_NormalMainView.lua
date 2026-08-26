-- chunkname: @modules/logic/bossrush/view/v3a9/V3a9_BossRush_NormalMainView.lua

module("modules.logic.bossrush.view.v3a9.V3a9_BossRush_NormalMainView", package.seeall)

local V3a9_BossRush_NormalMainView = class("V3a9_BossRush_NormalMainView", V3a9_BossRush_MainBaseView)

function V3a9_BossRush_NormalMainView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "LimitTime/#txt_LimitTime")
	self._scrollRewards = gohelper.findChildScrollRect(self.viewGO, "Rewards/#scroll_Rewards")
	self._goRewards = gohelper.findChild(self.viewGO, "Rewards/#scroll_Rewards/Viewport/#go_Rewards")
	self._btnStore = gohelper.findChildButtonWithAudio(self.viewGO, "Store/#btn_Store")
	self._simageProp = gohelper.findChildImage(self.viewGO, "Store/#btn_Store/#simage_Prop")
	self._txtNum = gohelper.findChildText(self.viewGO, "Store/#btn_Store/#txt_Num")
	self._scrollChapterList = gohelper.findChildScrollRect(self.viewGO, "#scroll_ChapterList")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_ChapterList/Viewport/#go_Content")
	self._btnAchievement = gohelper.findChildButtonWithAudio(self.viewGO, "TopRight/#btn_Achievement")
	self._txtAchievement = gohelper.findChildText(self.viewGO, "TopRight/#txt_Achievement")
	self._gotopRight = gohelper.findChild(self.viewGO, "TopRight")
	self._goStoreTip = gohelper.findChild(self.viewGO, "Store/image_Tips")
	self._txtStore = gohelper.findChildText(self.viewGO, "Store/#btn_Store/txt_Store")
	self._txtActDesc = gohelper.findChildText(self.viewGO, "txtDescr")
	self._gorank = gohelper.findChild(self.viewGO, "#go_rankbtn")
	self._gohandbook = gohelper.findChild(self.viewGO, "#go_handbook")
	self._btnhandbook = gohelper.findChildButtonWithAudio(self.viewGO, "#go_handbook/#btn_handbook")
	self._gohandbookreddot = gohelper.findChild(self.viewGO, "#go_handbook/#go_reddot")
	self._gorank = gohelper.findChild(self.viewGO, "#go_rankbtn")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9_BossRush_NormalMainView:addEvents()
	self._btnhandbook:AddClickListener(self._btnhandbookOnClick, self)
	V3a9_BossRush_NormalMainView.super.addEvents(self)
end

function V3a9_BossRush_NormalMainView:removeEvents()
	self._btnAchievement:RemoveClickListener()
	self._btnhandbook:RemoveClickListener()
	V3a9_BossRush_NormalMainView.super.removeEvents(self)
end

function V3a9_BossRush_NormalMainView:_btnhandbookOnClick()
	BossRushController.instance:openV3a2HankBookView()
end

function V3a9_BossRush_NormalMainView:_editableInitView()
	V3a9_BossRush_NormalMainView.super._editableInitView(self)
	self:_initRankBtn()

	self._txtAchievement.text = luaLang("achievement_name")

	RedDotController.instance:addRedDot(self._gohandbookreddot, RedDotEnum.DotNode.BossRushHankBookBossMainView)
end

function V3a9_BossRush_NormalMainView:_initRankBtn()
	local itemClass = V3a2_BossRush_RankBtn
	local go = self.viewContainer:getResInst(BossRushEnum.ResPath.v3a2_bossrush_rankbtn, self._gorank, itemClass.__cname)

	self._rankBtn = MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)

	self._rankBtn:refreshUI()
end

return V3a9_BossRush_NormalMainView
