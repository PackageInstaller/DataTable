-- chunkname: @modules/logic/rouge/view/RougeDifficultyItemSelected.lua

module("modules.logic.rouge.view.RougeDifficultyItemSelected", package.seeall)

local RougeDifficultyItemSelected = class("RougeDifficultyItemSelected", RougeDifficultyItem_Base)

function RougeDifficultyItemSelected:onInitView()
	self._goFrame1 = gohelper.findChild(self.viewGO, "frame/#go_Frame1")
	self._goFrame2 = gohelper.findChild(self.viewGO, "frame/#go_Frame2")
	self._goFrame3 = gohelper.findChild(self.viewGO, "frame/#go_Frame3")
	self._goBg1 = gohelper.findChild(self.viewGO, "bg/#go_Bg1")
	self._goBg2 = gohelper.findChild(self.viewGO, "bg/#go_Bg2")
	self._goBg3 = gohelper.findChild(self.viewGO, "bg/#go_Bg3")
	self._txtnum1 = gohelper.findChildText(self.viewGO, "num/#txt_num1")
	self._txtnum2 = gohelper.findChildText(self.viewGO, "num/#txt_num2")
	self._txtnum3 = gohelper.findChildText(self.viewGO, "num/#txt_num3")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._txten = gohelper.findChildText(self.viewGO, "#txt_name/#txt_en")
	self._txtenemy = gohelper.findChildText(self.viewGO, "enemy/#txt_enemy")
	self._enemyGo1 = gohelper.findChild(self.viewGO, "enemy/#go_1")
	self._enemyGo2 = gohelper.findChild(self.viewGO, "enemy/#go_2")
	self._enemyGo3 = gohelper.findChild(self.viewGO, "enemy/#go_3")
	self._scoreGo1 = gohelper.findChild(self.viewGO, "score/#go_1")
	self._scoreGo2 = gohelper.findChild(self.viewGO, "score/#go_2")
	self._scoreGo3 = gohelper.findChild(self.viewGO, "score/#go_3")
	self._txtscore = gohelper.findChildText(self.viewGO, "score/#txt_score")
	self._btnTipsIcon = gohelper.findChildButtonWithAudio(self.viewGO, "layout/#btn_TipsIcon")
	self._btnBalance = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_balance")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "#scroll_desc")
	self._txtScrollDesc = gohelper.findChildText(self.viewGO, "#scroll_desc/viewport/content/#txt_ScrollDesc")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_arrow")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeDifficultyItemSelected:addEvents()
	self._btnTipsIcon:AddClickListener(self._btnTipsIconOnClick, self)
	self._btnBalance:AddClickListener(self._btnBalanceOnClick, self)
end

function RougeDifficultyItemSelected:removeEvents()
	self._btnTipsIcon:RemoveClickListener()
	self._btnBalance:RemoveClickListener()
end

function RougeDifficultyItemSelected:_btnTipsIconOnClick()
	local mo = self._mo
	local difficultyCO = mo.difficultyCO
	local difficulty = difficultyCO.difficulty

	self:dispatchEvent(RougeEvent.RougeDifficultyView_btnTipsIconOnClick, difficulty)
end

function RougeDifficultyItemSelected:_btnBalanceOnClick()
	local mo = self._mo
	local difficultyCO = mo.difficultyCO
	local difficulty = difficultyCO.difficulty

	self:dispatchEvent(RougeEvent.RougeDifficultyView_btnBalanceOnClick, difficulty)
end

function RougeDifficultyItemSelected:_editableInitView()
	RougeDifficultyItem_Base._editableInitView(self)

	self._btnBalanceGo = self._btnBalance.gameObject
	self._btnTipsIconGo = self._btnTipsIcon.gameObject
	self._goFrameList = self:getUserDataTb_()

	self:_fillUserDataTb("_goFrame", self._goFrameList)

	self._goEnemyTxtBgList = self:getUserDataTb_()

	self:_fillUserDataTb("_enemyGo", self._goEnemyTxtBgList)

	self._goScoreTxtBgList = self:getUserDataTb_()

	self:_fillUserDataTb("_scoreGo", self._goScoreTxtBgList)

	self._scrolldescLimitScrollRectCmp = self._scrolldesc.gameObject:GetComponent(gohelper.Type_LimitedScrollRect)

	self:_onSetScrollParentGameObject(self._scrolldescLimitScrollRectCmp)
	self:_setActiveBalance(false)
	self:_setActiveOverview(false)
end

function RougeDifficultyItemSelected:onDestroyView()
	RougeDifficultyItem_Base.onDestroyView(self)
end

function RougeDifficultyItemSelected:setData(mo)
	RougeDifficultyItem_Base.setData(self, mo)

	local staticData = self:staticData()
	local geniusBranchStartViewInfo = staticData.geniusBranchStartViewInfo
	local difficultyCO = mo.difficultyCO
	local difficulty = difficultyCO.difficulty
	local balanceLevel = difficultyCO.balanceLevel
	local styleIndex = RougeConfig1.instance:getRougeDifficultyViewStyleIndex(difficulty)
	local cfg = RougeOutsideModel.instance:config()
	local dtScoreReward1 = cfg:getDifficultyCOStartViewDeltaValue(difficulty, RougeEnum.StartViewEnum.point)

	if not geniusBranchStartViewInfo[RougeEnum.StartViewEnum.point] then
		local dtScoreReward2 = 0
		local dtScoreReward = dtScoreReward1 + dtScoreReward2

		self._txtenemy.text = difficulty
		self._txtscore.text = tostring(difficultyCO.scoreReward + dtScoreReward) .. "%"
		self._txtScrollDesc.text = difficultyCO.desc

		self:_activeStyle(self._goFrameList, styleIndex)
		self:_activeStyle(self._goEnemyTxtBgList, styleIndex)
		self:_activeStyle(self._goScoreTxtBgList, styleIndex)
		self:_setActiveBalance(not string.nilorempty(balanceLevel))

		local c = self:baseViewContainer()

		if c then
			self:_setActiveOverview(#c:getSumDescIndexList(difficulty) > 0)
		end
	end
end

function RougeDifficultyItemSelected:_activeStyle(styleGoList, activeStyleIndex)
	for _, go in ipairs(styleGoList) do
		gohelper.setActive(go, false)
	end

	gohelper.setActive(styleGoList[activeStyleIndex], true)
end

function RougeDifficultyItemSelected:_setActiveBalance(isActive)
	gohelper.setActive(self._btnBalanceGo, isActive)
end

function RougeDifficultyItemSelected:_setActiveOverview(isActive)
	gohelper.setActive(self._btnTipsIconGo, isActive)
end

return RougeDifficultyItemSelected
