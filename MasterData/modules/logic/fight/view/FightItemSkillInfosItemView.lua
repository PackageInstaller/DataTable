-- chunkname: @modules/logic/fight/view/FightItemSkillInfosItemView.lua

module("modules.logic.fight.view.FightItemSkillInfosItemView", package.seeall)

local FightItemSkillInfosItemView = class("FightItemSkillInfosItemView", FightBaseView)

function FightItemSkillInfosItemView:onInitView()
	self.transform = self.viewGO.transform
	self.iconImg = gohelper.findChildImage(self.viewGO, "#image_icon")
	self.select = gohelper.findChild(self.viewGO, "#go_select")
	self.cd = gohelper.findChild(self.viewGO, "#go_cd")
	self.cdText = gohelper.findChildText(self.viewGO, "#go_cd/#txt_cd")
	self.lock = gohelper.findChild(self.viewGO, "#go_lock")

	gohelper.setActive(self.lock, false)

	self.textNum = gohelper.findChildText(self.viewGO, "num/#txt_num")
	self.click = gohelper.findChildClick(self.viewGO, "#btn_click")
end

function FightItemSkillInfosItemView:addEvents()
	self.tweenComp = self:addComponent(FightTweenComponent)

	self:com_registClick(self.click, self.onClick)
end

function FightItemSkillInfosItemView:removeEvents()
	return
end

function FightItemSkillInfosItemView:onClick()
	self.PARENT_VIEW:onItemClick(self.data, self.index)
end

function FightItemSkillInfosItemView:onConstructor(data, index)
	self.data = data
	self.index = index
end

function FightItemSkillInfosItemView:onSelect(isSelected)
	gohelper.setActive(self.select, isSelected)

	local duration = 0.35
	local ease = EaseType.OutQuart

	if isSelected then
		local localPos = self.transform.parent.localPosition
		local direction = localPos.normalized
		local offsetX = 0

		if direction.x < 0 then
			offsetX = -20
		elseif direction.x > 0 then
			offsetX = 20
		end

		local offsetY = 0

		if direction.y < 0 then
			offsetY = -20
		elseif direction.y > 0 then
			offsetY = 20
		end

		self.tweenComp:DOAnchorPos(self.transform, offsetX, offsetY, duration, nil, nil, nil, ease)
	else
		self.tweenComp:DOAnchorPos(self.transform, 0, 0, duration, nil, nil, nil, ease)
	end
end

function FightItemSkillInfosItemView:onOpen()
	local icon = AssassinConfig.instance:getAssassinItemIcon(self.data.itemId)

	UISpriteSetMgr.instance:setSp01AssassinSprite(self.iconImg, icon .. "_1")

	if self.data.count > 0 then
		if not self.data.count then
			self.textNum.text = string.format("<#dc5640>%d</color>", self.data.count)

			gohelper.setActive(self.cd, self.data.cd > 0)

			self.cdText.text = self.data.cd
		end
	end
end

return FightItemSkillInfosItemView
