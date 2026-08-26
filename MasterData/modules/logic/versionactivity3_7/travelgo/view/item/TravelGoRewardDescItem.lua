-- chunkname: @modules/logic/versionactivity3_7/travelgo/view/item/TravelGoRewardDescItem.lua

module("modules.logic.versionactivity3_7.travelgo.view.item.TravelGoRewardDescItem", package.seeall)

local TravelGoRewardDescItem = class("TravelGoRewardDescItem", SimpleListItem)

function TravelGoRewardDescItem:onInit()
	self._gonormal = gohelper.findChild(self.viewGO, "normal")
	self.imagenormalbg = self._gonormal:GetComponent(gohelper.Type_Image)
	self.txtnormal = gohelper.findChildTextMesh(self.viewGO, "normal/text")
	self.imagenormalicon = gohelper.findChildImage(self.viewGO, "normal/#image_Icon")
	self._goskill = gohelper.findChild(self.viewGO, "skill")
	self.imageskillbg = self._goskill:GetComponent(gohelper.Type_Image)
	self.txtskill = gohelper.findChildTextMesh(self.viewGO, "skill/text")
	self.imageskilliconbg = gohelper.findChildImage(self.viewGO, "skill/#image_IconBG")
	self.imageskillicon = gohelper.findChildImage(self.viewGO, "skill/#image_IconBG/#image_Icon")
end

function TravelGoRewardDescItem:onAddListeners()
	return
end

function TravelGoRewardDescItem:onItemShow(data)
	self.reward = data

	local type = self.reward.type
	local isSkill = type == TravelGoEnum.RewardType.Skill

	if isSkill then
		self.txtskill.text = self.reward:getRewardDesc()

		local cfg = self.reward:getSelectSkillCfg()
		local colorStr = TravelGoController.instance:getSkillRareColor(cfg and cfg.rare)
		local color = GameUtil.parseColor(colorStr)

		self.imageskilliconbg.color = color
		self.imageskillbg.color = color

		local icon = self.reward:getRewardIcon()

		if icon then
			gohelper.setActive(self.imageskillicon, true)
			UISpriteSetMgr.instance:setBuffSprite(self.imageskillicon, icon)
		else
			gohelper.setActive(self.imageskillicon, false)
		end
	else
		local icon = self.reward:getRewardIcon()

		if icon then
			gohelper.setActive(self.imagenormalicon, true)
			UISpriteSetMgr.instance:setTravelGoSprite(self.imagenormalicon, icon)
		else
			gohelper.setActive(self.imagenormalicon, false)
		end

		local bkg = self.reward:getRewardBkg()

		UISpriteSetMgr.instance:setTravelGoSprite(self.imagenormalbg, bkg)

		self.txtnormal.text = self.reward:getRewardDesc()
	end

	gohelper.setActive(self._gonormal, not isSkill)
	gohelper.setActive(self._goskill, isSkill)
	gohelper.setActive(self.viewGO, true)
end

return TravelGoRewardDescItem
