-- chunkname: @modules/logic/rouge2/bossbattle/view/Rouge2_BossBattleListItem.lua

module("modules.logic.rouge2.bossbattle.view.Rouge2_BossBattleListItem", package.seeall)

local Rouge2_BossBattleListItem = class("Rouge2_BossBattleListItem", ListScrollCellExtend)

function Rouge2_BossBattleListItem:onInitView()
	self._goRoot = gohelper.findChild(self.viewGO, "#go_Root")
	self._goInfo = gohelper.findChild(self.viewGO, "#go_Root/#go_Info")
	self._simageIcon = gohelper.findChildSingleImage(self.viewGO, "#go_Root/#simage_Icon")
	self._goMaxScore = gohelper.findChild(self.viewGO, "#go_Root/#go_Info/NameBg/#go_MaxScore")
	self._simageMaxScore = gohelper.findChildSingleImage(self.viewGO, "#go_Root/#go_Info/NameBg/#go_MaxScore/#simage_MaxScore")
	self._imageCareer = gohelper.findChildImage(self.viewGO, "#go_Root/#go_Info/NameBg/#image_Career")
	self._txtName = gohelper.findChildText(self.viewGO, "#go_Root/#go_Info/NameBg/#txt_Name")
	self._goReddot = gohelper.findChild(self.viewGO, "#go_Root/#go_Info/NameBg/#go_Reddot")
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#btn_Click", AudioEnum.Rouge2.SwitchBoss)
	self._goReward = gohelper.findChild(self.viewGO, "#go_Root/#go_Info/#go_Reward")
	self._goPosList = gohelper.findChild(self.viewGO, "#go_PosList")
	self._rewardItem = Rouge2_BossBattleBossItemReward.Get(self._goReward)
	self._lineCount = 3

	self:initPositionMap()
end

function Rouge2_BossBattleListItem:addEvents()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function Rouge2_BossBattleListItem:removeEvents()
	self._btnClick:RemoveClickListener()
end

function Rouge2_BossBattleListItem:_btnClickOnClick()
	local bossList = Rouge2_BossBattleListModel.instance:getList()

	Rouge2_ViewHelper.openBossBattleDetailView({
		configList = bossList,
		selectIndex = self._index
	})
end

function Rouge2_BossBattleListItem:onUpdateMO(bossCo)
	self._bossCo = bossCo
	self._bossId = bossCo and bossCo.id
	self._battleInfo = Rouge2_OutsideModel.instance:getBossBattleInfo()
	self._bossInfo = self._battleInfo and self._battleInfo:getBossInfoById(self._bossId)
	self._bossCo = Rouge2_BossBattleConfig.instance:getBossConfig(self._bossId)
	self._episodeCo = Rouge2_BossBattleController.instance:getEpisodeCoByBossId(self._bossId)
	self._monsterCo = Rouge2_BossBattleController.instance:getBossFightConfig(self._bossId)
	self._isPass = self._bossInfo ~= nil

	self._rewardItem:onUpdateMO(self._battleInfo, self._bossCo)
	self:refreshBaseInfo()
	self:updatePosition()
	RedDotController.instance:addRedDot(self._goReddot, RedDotEnum.DotNode.Rouge2BossReward, self._bossId)
end

function Rouge2_BossBattleListItem:refreshBaseInfo()
	gohelper.setActive(self._goMaxScore, self._isPass)

	if self._isPass then
		local maxScore = self._bossInfo and self._bossInfo:getMaxScore() or 0

		Rouge2_IconHelper.setBossAssessIcon(maxScore, self._simageMaxScore)
	end

	if self._episodeCo then
		self._txtName.text = self._episodeCo.name or ""
	end

	self._simageIcon:LoadImage(ResUrl.getRouge2Icon("bossbattle/" .. self._bossCo.bossIcon))

	if self._monsterCo then
		if not self._monsterCo.career then
			local career = ""

			UISpriteSetMgr.instance:setCommonSprite(self._imageCareer, "lssx_" .. career, true)
		end
	end
end

function Rouge2_BossBattleListItem:initPositionMap()
	self._positionMap = self:getUserDataTb_()

	for i = 1, math.huge do
		local goRoot = gohelper.findChild(self._goPosList, "#go_Pos_" .. i)

		if gohelper.isNil(goRoot) then
			return
		end

		self._positionMap[i] = {}

		local tranRoot = goRoot.transform
		local childCount = tranRoot.childCount

		for j = 1, childCount do
			local goSub = tranRoot:GetChild(j - 1).gameObject
			local goResultPath = goSub.name
			local goResult = gohelper.findChild(self.viewGO, goResultPath)

			if not gohelper.isNil(goResult) then
				local tranResult = goResult.transform
				local posX, posY = recthelper.getAnchor(goSub.transform)
				local scaleX, scaleY, scaleZ = transformhelper.getLocalScale(goSub.transform)
				local resultPos = Vector2(posX, posY)
				local resultScale = Vector3(scaleX, scaleY, scaleZ)

				self._positionMap[i][tranResult] = {
					pos = resultPos,
					scale = resultScale
				}
			end
		end
	end
end

function Rouge2_BossBattleListItem:updatePosition()
	local posIndex = self._index % self._lineCount

	posIndex = posIndex ~= 0 and posIndex or self._lineCount

	local subTab = self._positionMap[posIndex]

	if not subTab then
		return
	end

	for tranUpdate, settingInfo in pairs(subTab) do
		local pos = settingInfo.pos
		local scale = settingInfo.scale

		recthelper.setAnchor(tranUpdate, pos.x or 0, pos.y or 0)
		transformhelper.setLocalScale(tranUpdate, scale.x or 1, scale.y or 1, scale.z or 1)
	end
end

function Rouge2_BossBattleListItem:onSelect(isSelect)
	gohelper.setActive(self._goSelect, isSelect)
end

function Rouge2_BossBattleListItem:onDestroyView()
	self._simageIcon:UnLoadImage()
	self._simageMaxScore:UnLoadImage()
end

return Rouge2_BossBattleListItem
