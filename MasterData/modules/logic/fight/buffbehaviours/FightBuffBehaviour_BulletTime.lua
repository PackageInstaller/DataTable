-- chunkname: @modules/logic/fight/buffbehaviours/FightBuffBehaviour_BulletTime.lua

module("modules.logic.fight.buffbehaviours.FightBuffBehaviour_BulletTime", package.seeall)

local FightBuffBehaviour_BulletTime = class("FightBuffBehaviour_BulletTime", FightBuffBehaviourBase)
local bulletItemPath = "ui/viewres/fight/fight_rouge2/fight_rouge2_bulletview.prefab"

function FightBuffBehaviour_BulletTime:onAddBuff(entityId, buffId, buffMo)
	self.root = gohelper.findChild(self.viewGo, "root")

	self:showBulletTime()
end

function FightBuffBehaviour_BulletTime:showBulletTime()
	AudioMgr.instance:trigger(20320606)

	self.loader = MultiAbLoader.New()

	self.loader:addPath(bulletItemPath)
	self.loader:startLoad(self.onLoadFinish, self)
end

function FightBuffBehaviour_BulletTime:onLoadFinish()
	local assetItem = self.loader:getFirstAssetItem()

	if not assetItem then
		logError(" load bullet time failed")

		return
	end

	local prefab = assetItem:GetResource()

	self.effectGo = gohelper.clone(prefab, self.root)

	gohelper.setAsFirstSibling(self.effectGo)

	self.simageMask = gohelper.findChildSingleImage(self.effectGo, "simage_mask")

	self.simageMask:LoadImage("singlebg/fight/rouge2/fight_rouge2_maask1.png")

	self.goAnim = gohelper.findChild(self.effectGo, "guochang")

	gohelper.setActive(self.goAnim, true)

	self.simageMask2 = gohelper.findChildSingleImage(self.effectGo, "guochang/simage_mask2")

	self.simageMask2:LoadImage("singlebg/fight/rouge2/fight_rouge2_maask2.png")

	self.simageDesc2 = gohelper.findChildSingleImage(self.effectGo, "guochang/simage_dec2")

	self.simageDesc2:LoadImage("singlebg/fight/rouge2/fight_rouge2_iconbg.png")

	self.simageIcon = gohelper.findChildSingleImage(self.effectGo, "guochang/#simage_icon")

	self.simageIcon:LoadImage("singlebg/fight/rouge2/fight_rouge2_baseicon_1.png")

	self.simageTitle = gohelper.findChildSingleImage(self.effectGo, "guochang/simage_Title")

	self.simageTitle:LoadImage("singlebg_lang/txt_fight/rouge2/fight_rouge2_title.png")
	TaskDispatcher.runDelay(self.showAnimDone, self, 1)
end

function FightBuffBehaviour_BulletTime:showAnimDone()
	gohelper.setActive(self.goAnim, false)
end

function FightBuffBehaviour_BulletTime:onUpdateBuff(entityId, buffId, buffMo)
	return
end

function FightBuffBehaviour_BulletTime:onRemoveBuff(entityId, buffId, buffMo)
	gohelper.destroy(self.effectGo)
end

function FightBuffBehaviour_BulletTime:clearLoader()
	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end
end

function FightBuffBehaviour_BulletTime:unloadImage(image)
	if image then
		image:UnLoadImage()
	end
end

function FightBuffBehaviour_BulletTime:onDestroy()
	self:unloadImage(self.simageMask)
	self:unloadImage(self.simageMask2)
	self:unloadImage(self.simageTitle)
	self:unloadImage(self.simageDesc2)
	self:unloadImage(self.simageIcon)
	TaskDispatcher.cancelTask(self.showAnimDone, self)
	self:clearLoader()
	FightBuffBehaviour_BulletTime.super.onDestroy(self)
end

return FightBuffBehaviour_BulletTime
