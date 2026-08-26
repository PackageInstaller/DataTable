-- chunkname: @modules/logic/fight/view/FightEnemyActionCardItem.lua

module("modules.logic.fight.view.FightEnemyActionCardItem", package.seeall)

local FightEnemyActionCardItem = class("FightEnemyActionCardItem", UserDataDispose)

function FightEnemyActionCardItem.get(go, cardMo)
	local item = FightEnemyActionCardItem.New()

	item:init(go, cardMo)

	return item
end

function FightEnemyActionCardItem:init(go, cardMo)
	self:__onInit()

	self.goCard = go
	self.tr = go.transform
	self.cardMo = cardMo
	self.skillId = cardMo.skillId
	self.entityId = cardMo.uid
	self.entityMo = FightDataHelper.entityMgr:getById(self.entityId)
	self.skillCo = lua_skill.configDict[self.skillId]
	self.skillCardLv = FightCardDataHelper.getSkillLv(self.entityId, self.skillId)
	self.lvGoList = self:getUserDataTb_()
	self.lvImgIconList = self:getUserDataTb_()
	self.lvImgCompList = self:getUserDataTb_()
	self.starItemCanvasList = self:getUserDataTb_()

	for i = 0, 4 do
		local lvGO = gohelper.findChild(self.goCard, "lv" .. i)
		local lvIcon = gohelper.findChildSingleImage(lvGO, "imgIcon")
		local lvImgComp = gohelper.findChildImage(lvGO, "imgIcon")

		gohelper.setActive(lvGO, true)

		self.lvGoList[i] = lvGO
		self.lvImgIconList[i] = lvIcon
		self.lvImgCompList[i] = lvImgComp
	end

	self.goTag = gohelper.findChild(self.goCard, "tag")
	self.tagPosLevelDic = {}

	for i = 0, 4 do
		local x, y = recthelper.getAnchor(gohelper.findChild(self.goCard, "tag/pos" .. i).transform)

		self.tagPosLevelDic[i] = {
			x,
			y
		}
	end

	self.tagRootTr = gohelper.findChild(self.goCard, "tag/tag").transform
	self.tagIcon = gohelper.findChildSingleImage(self.goCard, "tag/tag/tagIcon")
	self.starGo = gohelper.findChild(self.goCard, "star")
	self.starCanvas = gohelper.onceAddComponent(self.starGo, typeof(UnityEngine.CanvasGroup))
	self.innerStartGoList = self:getUserDataTb_()
	self.innerStartCanvasList = self:getUserDataTb_()

	for i = 1, FightEnum.MaxSkillCardLv do
		local starObj = gohelper.findChild(self.goCard, "star/star" .. i)

		table.insert(self.innerStartGoList, starObj)
		table.insert(self.innerStartCanvasList, gohelper.onceAddComponent(starObj, typeof(UnityEngine.CanvasGroup)))
	end

	self:hideOther()
end

function FightEnemyActionCardItem:hideOther()
	local cardAni = gohelper.onceAddComponent(self.goCard, typeof(UnityEngine.Animator))

	if cardAni then
		cardAni.enabled = false
	end

	local count = self.tr.childCount

	for index = 1, count do
		local child = self.tr:GetChild(index - 1)

		gohelper.setActive(child.gameObject, false)
	end
end

function FightEnemyActionCardItem:refreshCard()
	for level, lvGO in pairs(self.lvGoList) do
		gohelper.setActive(lvGO, true)
		gohelper.setActiveCanvasGroup(lvGO, self.skillCardLv == level)
	end

	local targetIconUrl = ResUrl.getSkillIcon(self.skillCo.icon)

	for level, img in pairs(self.lvImgIconList) do
		if gohelper.isNil(self.lvImgCompList[level].sprite) then
			img:UnLoadImage()
		elseif img.curImageUrl ~= targetIconUrl then
			img:UnLoadImage()
		end

		img:LoadImage(targetIconUrl)
	end

	local showStar = self.skillCardLv < FightEnum.UniqueSkillCardLv and self.skillCardLv > 0

	gohelper.setActive(self.starGo, showStar)

	self.starCanvas.alpha = 1

	for i, startGO in ipairs(self.innerStartGoList) do
		gohelper.setActive(startGO, i == self.skillCardLv)

		if self.innerStartCanvasList[i] then
			self.innerStartCanvasList[i].alpha = 1
		end
	end

	gohelper.setActive(self.goTag, true)
	self.tagIcon:LoadImage(ResUrl.getAttributeIcon("attribute_" .. self.skillCo.showTag))

	local showTagPos = self.tagPosLevelDic[self.skillCardLv]

	if showTagPos then
		recthelper.setAnchor(self.tagRootTr, showTagPos[1], showTagPos[2])
	end

	gohelper.setActive(self.tagIcon.gameObject, self.skillCardLv < FightEnum.UniqueSkillCardLv)
end

function FightEnemyActionCardItem:refreshSelect(select)
	self.select = select
end

function FightEnemyActionCardItem:destroy()
	for _, img in pairs(self.lvImgIconList) do
		img:UnLoadImage()
	end

	self.tagIcon:UnLoadImage()
	self:__onDispose()
end

return FightEnemyActionCardItem
