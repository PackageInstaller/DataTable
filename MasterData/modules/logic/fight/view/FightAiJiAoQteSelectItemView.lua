-- chunkname: @modules/logic/fight/view/FightAiJiAoQteSelectItemView.lua

module("modules.logic.fight.view.FightAiJiAoQteSelectItemView", package.seeall)

local FightAiJiAoQteSelectItemView = class("FightAiJiAoQteSelectItemView", FightBaseView)

function FightAiJiAoQteSelectItemView:onInitView()
	self.hpSlider = gohelper.findChildSlider(self.viewGO, "#slider_hp")
	self.shieldSlider = gohelper.findChildSlider(self.viewGO, "#slider_hp/#slider_hudun")
	self.roleIcon = gohelper.findChildSingleImage(self.viewGO, "#simage_icon")
	self.restrain = gohelper.findChild(self.viewGO, "restrain")
	self.restrainAni = gohelper.findChildComponent(self.viewGO, "restrain/restrain", gohelper.Type_Animator)
	self.actRoot = gohelper.findChild(self.viewGO, "actLayout")
	self.actItemObj = gohelper.findChild(self.viewGO, "actLayout/act")
	self.goSelect = gohelper.findChild(self.viewGO, "go_select")
	self.click = gohelper.findChildClick(self.viewGO, "click")
end

function FightAiJiAoQteSelectItemView:addEvents()
	self:com_registClick(self.click, self.onClick)
end

function FightAiJiAoQteSelectItemView:onClick()
	self.PARENT_VIEW:onSelectItem(self.toId)
end

function FightAiJiAoQteSelectItemView:onConstructor(fromId, toId)
	self.fromId = fromId
	self.toId = toId
end

function FightAiJiAoQteSelectItemView:showSelect(toId)
	gohelper.setActive(self.goSelect, toId == self.toId)
end

function FightAiJiAoQteSelectItemView:onOpen()
	local entityMO = FightDataHelper.entityMgr:getById(self.toId)
	local skinConfig = FightConfig.instance:getSkinCO(entityMO.skin)

	self.roleIcon:LoadImage(entityMO:isEnemySide() and ResUrl.monsterHeadIcon(skinConfig.headIcon) or ResUrl.getHeadIconSmall(skinConfig.retangleIcon))

	local curHp = entityMO.currentHp
	local curShield = entityMO.shieldValue
	local hpFillAmount, shieldFillAmount = FightNameUI.getHpFillAmount(curHp, curShield, entityMO.id)

	self.hpSlider:SetValue(hpFillAmount)
	self.shieldSlider:SetValue(shieldFillAmount)

	local fromEntityData = FightDataHelper.entityMgr:getById(self.fromId)
	local restrainValue = FightConfig.instance:getRestrain(fromEntityData.career, entityMO.career) or 1000

	if restrainValue > 1000 then
		gohelper.setActive(self.restrain, true)
		self.restrainAni:Play("fight_restrain_all_in", 0, 0)
		self.restrainAni:Update(0)
	else
		gohelper.setActive(self.restrain, false)
	end

	local roundData = FightDataHelper.roundMgr:getRoundData()
	local playCardList = roundData:getEntityAIUseCardMOList(self.toId)

	self:com_createObjList(self.onActItemShow, playCardList, self.actRoot, self.actItemObj)
end

function FightAiJiAoQteSelectItemView:onActItemShow(obj, cardInfo, index)
	local itemView = self:com_openSubView(FightNameUIOperationItem, obj)

	itemView:refreshItemData(cardInfo)
	gohelper.setActive(gohelper.findChild(obj, "round"), false)
end

function FightAiJiAoQteSelectItemView:onClose()
	return
end

function FightAiJiAoQteSelectItemView:onDestroyView()
	return
end

return FightAiJiAoQteSelectItemView
