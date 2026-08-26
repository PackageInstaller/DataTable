-- chunkname: @modules/logic/fight/view/FightBossPassiveTipsView.lua

module("modules.logic.fight.view.FightBossPassiveTipsView", package.seeall)

local FightBossPassiveTipsView = class("FightBossPassiveTipsView", FightBaseView)

function FightBossPassiveTipsView:onInitView()
	self.tipObj = gohelper.findChild(self.viewGO, "root/tips/#go_bufftip")
	self.objContent = gohelper.findChild(self.viewGO, "root/tips/#go_bufftip/#scroll_buff/viewport/content")
	self.objItem = gohelper.findChild(self.viewGO, "root/tips/#go_bufftip/#scroll_buff/viewport/content/#go_buffitem")
	self.contectBg = gohelper.findChildImage(self.viewGO, "root/tips/#go_bufftip/#scroll_buff/viewport/content/contentbg")
end

function FightBossPassiveTipsView:addEvents()
	self:com_registFightEvent(FightEvent.OnPassiveSkillClick, self.onPassiveSkillClick)

	self.buffTipClick = gohelper.getClickWithDefaultAudio(self.tipObj)

	self:com_registClick(self.buffTipClick, self.onClickBuffTip)
end

function FightBossPassiveTipsView:removeEvents()
	return
end

function FightBossPassiveTipsView:onClickBuffTip()
	gohelper.setActive(self.tipObj, false)
end

function FightBossPassiveTipsView:onPassiveSkillClick(bossSkillInfos, skillIconTransform, offsetX, offsetY, entityId)
	gohelper.setActive(self.tipObj, true)

	self.entityId = entityId

	self.itemList:setDataList(bossSkillInfos)

	local startPosY = -62
	local viewHeight = 0

	for _, item in ipairs(self.itemList) do
		recthelper.setAnchor(item.viewGO.transform, 280, startPosY)

		startPosY = startPosY - item.viewHeight
		viewHeight = viewHeight + item.viewHeight
	end

	local bgHeight = viewHeight > 800 and 800 or viewHeight

	recthelper.setHeight(self.contectBg.transform, bgHeight + 50)
	recthelper.setHeight(self.objContent.transform, viewHeight)
	recthelper.setAnchorY(self.objContent.transform, 0)
end

function FightBossPassiveTipsView:onOpen()
	self.itemList = self:com_registViewItemList(self.objItem, FightBossPassiveTipsItemView, self.objContent)
end

function FightBossPassiveTipsView:onClose()
	return
end

function FightBossPassiveTipsView:onDestroyView()
	return
end

return FightBossPassiveTipsView
