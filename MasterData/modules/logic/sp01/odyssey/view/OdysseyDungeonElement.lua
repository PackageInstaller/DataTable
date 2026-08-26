-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyDungeonElement.lua

module("modules.logic.sp01.odyssey.view.OdysseyDungeonElement", package.seeall)

local OdysseyDungeonElement = class("OdysseyDungeonElement", LuaCompBase)
local BOX_COLLIDER_SIZE = Vector2(150, 150)

function OdysseyDungeonElement:ctor(param)
	self.config = param[1]
	self.sceneElements = param[2]
	self.type = self.config.type
end

function OdysseyDungeonElement:init(go)
	self.go = go
	self.trans = self.go.transform
	self.itemRootMap = self:getUserDataTb_()

	for type, root in pairs(OdysseyEnum.ElementTypeRoot) do
		self.itemRootMap[type] = {}
		self.itemRootMap[type].go = gohelper.findChild(self.go, root .. "Item")
		self.itemRootMap[type].anim = self.itemRootMap[type].go:GetComponent(gohelper.Type_Animator)
		self.itemRootMap[type].mainTaskFrame = gohelper.findChild(self.itemRootMap[type].go, "image_effframe1")
		self.itemRootMap[type].goldFrame = gohelper.findChild(self.itemRootMap[type].go, "image_bg1")
		self.itemRootMap[type].silverFrame = gohelper.findChild(self.itemRootMap[type].go, "image_bg2")
		self.itemRootMap[type].goldFrameEffect = gohelper.findChild(self.itemRootMap[type].go, "vx_gold")
		self.itemRootMap[type].silverFrameEffect = gohelper.findChild(self.itemRootMap[type].go, "vx_sliver")
		self.itemRootMap[type].goldArrow = gohelper.findChild(self.itemRootMap[type].go, "image_arrow1")
		self.itemRootMap[type].silverArrow = gohelper.findChild(self.itemRootMap[type].go, "image_arrow2")
	end

	self.imageDialogHero = gohelper.findChildSingleImage(self.go, "dialogItem/#image_dialogHero")
	self.imageOptionIcon = gohelper.findChildImage(self.go, "optionItem/#image_optionIcon")
	self.imageFightIcon = gohelper.findChildImage(self.go, "fightItem/#image_fightIcon")
	self.imageFightGlowIcon = gohelper.findChildImage(self.go, "fightItem/#image_fightIcon/#image_fightIcon_glow")
	self.goFightConquer = gohelper.findChild(self.go, "fightItem/#go_conquer")
	self.goFightReward = gohelper.findChild(self.go, "fightItem/#go_rewardtips")

	self.addBoxColliderListener(self.go, self.onClickDown, self)
	self:updateInfo()
end

function OdysseyDungeonElement.addBoxColliderListener(go, callback, callbackTarget)
	gohelper.addBoxCollider2D(go, BOX_COLLIDER_SIZE)

	local clickListener = ZProj.BoxColliderClickListener.Get(go)

	clickListener:SetIgnoreUI(true)
	clickListener:AddClickListener(callback, callbackTarget)
end

function OdysseyDungeonElement:onClickDown()
	self.sceneElements:onElementClickDown(self)
end

function OdysseyDungeonElement:updateInfo()
	local pos = string.splitToNumber(self.config.pos, "#")

	transformhelper.setLocalPos(self.go.transform, pos[1] or 0, pos[2] or 0, pos[3] or 0)

	for type, item in pairs(self.itemRootMap) do
		gohelper.setActive(item.go, type == self.type)
		gohelper.setActive(item.goldFrame, self.config.iconFrame == OdysseyEnum.IconFrameType.Gold)
		gohelper.setActive(item.goldFrameEffect, self.config.iconFrame == OdysseyEnum.IconFrameType.Gold)
		gohelper.setActive(item.goldArrow, self.config.iconFrame == OdysseyEnum.IconFrameType.Gold)
		gohelper.setActive(item.silverFrame, self.config.iconFrame == OdysseyEnum.IconFrameType.Silver)
		gohelper.setActive(item.silverFrameEffect, self.config.iconFrame == OdysseyEnum.IconFrameType.Silver)
		gohelper.setActive(item.silverArrow, self.config.iconFrame == OdysseyEnum.IconFrameType.Silver)
		gohelper.setActive(item.mainTaskFrame, self.config.main == OdysseyEnum.DungeonMainElement)
	end

	local posParam = string.splitToNumber(self.config.pos, "#")

	transformhelper.setLocalPos(self.trans, posParam[1], posParam[2], posParam[3])

	if self.type == OdysseyEnum.ElementType.Option then
		UISpriteSetMgr.instance:setSp01OdysseyDungeonElementSprite(self.imageOptionIcon, self.config.icon)
	elseif self.type == OdysseyEnum.ElementType.Dialog then
		self.imageDialogHero:LoadImage(ResUrl.getRoomHeadIcon(self.config.icon))
	elseif self.type == OdysseyEnum.ElementType.Fight then
		local fightElementConfig = OdysseyConfig.instance:getElementFightConfig(self.config.id)

		gohelper.setActive(self.goFightConquer, fightElementConfig.type == OdysseyEnum.FightType.Conquer)

		local episodeConfig = DungeonConfig.instance:getEpisodeCO(fightElementConfig.episodeId)
		local rewardCo = lua_bonus.configDict[episodeConfig.firstBonus]

		gohelper.setActive(self.goFightReward, episodeConfig.firstBonus > 0 and rewardCo and not string.nilorempty(rewardCo.fixBonus))
		UISpriteSetMgr.instance:setSp01OdysseyDungeonElementSprite(self.imageFightIcon, self.config.icon)
		UISpriteSetMgr.instance:setSp01OdysseyDungeonElementSprite(self.imageFightGlowIcon, self.config.icon)
	end
end

function OdysseyDungeonElement:needShowArrow()
	return self.config.needFollow == OdysseyEnum.DungeonElementNeedFollow
end

function OdysseyDungeonElement:playShowOrHideAnim(show)
	if self.showState == show then
		return
	end

	self.showState = show

	self.itemRootMap[self.type].anim:Play(show and "open" or "close", 0, 0)
	self.itemRootMap[self.type].anim:Update(0)

	if not show then
		AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_fade_away)
	end
end

function OdysseyDungeonElement:playAnim(animName)
	self.itemRootMap[self.type].anim:Play(animName, 0, 0)
	self.itemRootMap[self.type].anim:Update(0)

	if animName == OdysseyEnum.ElementAnimName.Tips then
		AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_hint)
	end
end

function OdysseyDungeonElement:onDestroy()
	self.imageDialogHero:UnLoadImage()
end

return OdysseyDungeonElement
