-- chunkname: @modules/logic/bossrush/view/FightActionBarPopView.lua

module("modules.logic.bossrush.view.FightActionBarPopView", package.seeall)

local FightActionBarPopView = class("FightActionBarPopView", BaseViewExtended)

function FightActionBarPopView:onInitView()
	self._closeBtn = gohelper.findChildButton(self.viewGO, "#btn_close")
	self._content = gohelper.findChild(self.viewGO, "middle/#go_cardcontent")
	self._itemModel = gohelper.findChild(self.viewGO, "middle/#go_cardcontent/card")
	self._cardItem = gohelper.findChild(self.viewGO, "middle/#go_cardcontent/card/cardItem")
	self._cardRoot = gohelper.findChild(self.viewGO, "middle/#go_cardcontent/card/cardItem/root")
	self._skillName = gohelper.findChildText(self.viewGO, "bottom/skillname")
	self._skillDes = gohelper.findChildText(self.viewGO, "bottom/#scroll_txt/Viewport/Content/skilldesc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightActionBarPopView:addEvents()
	self.addClickCb(self, self._closeBtn, self._onCloseBtn, self)
end

function FightActionBarPopView:removeEvents()
	return
end

function FightActionBarPopView:_editableInitView()
	SkillHelper.addHyperLinkClick(self._skillDes, self.linkClickCallback, self)

	self._skillName.text = ""
	self._skillDes.text = ""
end

function FightActionBarPopView:linkClickCallback(effId)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(effId, Vector2.zero, CommonBuffTipEnum.Pivot.Center)
end

function FightActionBarPopView:_onCloseBtn()
	self:closeThis()
end

function FightActionBarPopView:onRefreshViewParam()
	return
end

function FightActionBarPopView:onOpen()
	self.entityId = self.viewParam.entityId

	local cardPath = "ui/viewres/fight/fightcarditem.prefab"

	self:com_loadAsset(cardPath, self._onLoadFinish)
end

function FightActionBarPopView:_onLoadFinish(loader)
	local tarPrefab = loader:GetResource()
	local obj = gohelper.clone(tarPrefab, self._cardRoot)

	obj.name = "card"
	self._cardObjList = self:getUserDataTb_()
	self._cardCount = 0

	table.insert(self.viewParam.dataList, 1, 0)
	self:com_createObjList(self._onItemShow, self.viewParam.dataList, self._content, self._itemModel)

	for i, v in ipairs(self._cardObjList) do
		local skillId = tonumber(v.name)

		if skillId ~= 0 then
			self:_onCardClick(v)

			break
		end
	end
end

function FightActionBarPopView:_onItemShow(obj, data, index)
	if index <= 1 then
		return
	end

	if self._cardCount >= 6 then
		gohelper.setActive(obj, false)

		return
	end

	gohelper.setActive(obj, true)

	local roundText1 = gohelper.findChildText(obj, "#go_select/#txt_round")
	local roundText2 = gohelper.findChildText(obj, "#go_unselect/#txt_round")

	roundText1.text = FightModel.instance:getCurRoundId() + index - 2
	roundText2.text = FightModel.instance:getCurRoundId() + index - 2

	table.insert(data, 1, 0)
	table.insert(data, 1, 0)
	self:com_createObjList(self._onCardItemShow, data, obj, self._cardItem)

	local select = gohelper.findChild(obj, "#go_select")
	local unSelect = gohelper.findChild(obj, "#go_unselect")

	gohelper.setActive(select, index == 2)
	gohelper.setActive(unSelect, index ~= 2)
end

function FightActionBarPopView:_onCardItemShow(obj, data, index)
	if index <= 2 then
		return
	end

	self._cardCount = self._cardCount + 1

	if self._cardCount > 6 then
		gohelper.setActive(obj, false)

		return
	end

	gohelper.setActive(obj, true)

	local skillId = data.skillId

	obj.name = skillId

	local card = gohelper.findChild(obj, "root/card")
	local empty = gohelper.findChild(obj, "empty")
	local chant = gohelper.findChild(obj, "chant")
	local round = gohelper.findChildText(obj, "chant/round")

	gohelper.setActive(chant, data.isChannelSkill)

	round.text = data.round or 0

	gohelper.setActive(card, skillId ~= 0)
	gohelper.setActive(empty, skillId == 0)

	local class = MonoHelper.addNoUpdateLuaComOnceToGo(card, FightViewCardItem, FightEnum.CardShowType.BossAction)

	if skillId ~= 0 then
		class:updateItem(self.viewParam.entityId, skillId)

		local lvImgComps = class._lvImgComps

		for i, image in ipairs(lvImgComps) do
			SLFramework.UGUI.GuiHelper.SetColor(image, data.isChannelSkill and "#666666" or "#FFFFFF")
		end
	end

	local click = gohelper.getClickWithDefaultAudio(obj)

	self.addClickCb(self, click, self._onCardClick, self, obj)
	table.insert(self._cardObjList, obj)
end

function FightActionBarPopView:_onCardClick(obj)
	local skillId = tonumber(obj.name)

	if skillId == 0 then
		return
	end

	if self._curSelectObj == obj then
		return
	end

	self._curSelectObj = obj

	local skillConfig = lua_skill.configDict[skillId]

	for i, v in ipairs(self._cardObjList) do
		local isBigSkill = FightCardDataHelper.isBigSkill(skillId)

		gohelper.setActive(gohelper.findChild(v, "select"), obj == v and not isBigSkill)
		gohelper.setActive(gohelper.findChild(v, "uniqueSelect"), obj == v and isBigSkill)
	end

	if skillConfig then
		self._skillName.text = skillConfig.name
		self._skillDes.text = SkillHelper.getEntityDescBySkillCo(self.entityId, skillConfig, "#DB945B", "#5C86DA")
	else
		logError("技能表找不到id:" .. skillId)
	end
end

function FightActionBarPopView:onClose()
	return
end

function FightActionBarPopView:onDestroyView()
	return
end

return FightActionBarPopView
