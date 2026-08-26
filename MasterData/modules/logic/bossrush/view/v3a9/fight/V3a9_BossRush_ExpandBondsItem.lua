-- chunkname: @modules/logic/bossrush/view/v3a9/fight/V3a9_BossRush_ExpandBondsItem.lua

module("modules.logic.bossrush.view.v3a9.fight.V3a9_BossRush_ExpandBondsItem", package.seeall)

local V3a9_BossRush_ExpandBondsItem = class("V3a9_BossRush_ExpandBondsItem", ListScrollCellExtend)

function V3a9_BossRush_ExpandBondsItem:ctor(isOpenTipView)
	self._isOpenTipView = isOpenTipView
end

function V3a9_BossRush_ExpandBondsItem:onInitView()
	self._imageBondBG = gohelper.findChildImage(self.viewGO, "root/#image_BondBG")
	self._imageicon = gohelper.findChildImage(self.viewGO, "root/#image_icon")
	self._txtBondsNum = gohelper.findChildText(self.viewGO, "root/#txt_BondsNum")
	self._goselect = gohelper.findChild(self.viewGO, "root/#go_select")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9_BossRush_ExpandBondsItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self.addEventCb(self, V3a9_BossRushController.instance, V3a9_BossRushEvent.onRefreshAddBondGroupId, self._onRefreshAddBondGroupId, self)
	self.addEventCb(self, V3a9_BossRushController.instance, V3a9_BossRushEvent.onClickExpandBonds, self._onClickExpandBonds, self)
end

function V3a9_BossRush_ExpandBondsItem:removeEvents()
	self._btnclick:RemoveClickListener()
	self.removeEventCb(self, V3a9_BossRushController.instance, V3a9_BossRushEvent.onRefreshAddBondGroupId, self._onRefreshAddBondGroupId, self)
	self.removeEventCb(self, V3a9_BossRushController.instance, V3a9_BossRushEvent.onClickExpandBonds, self._onClickExpandBonds, self)
end

function V3a9_BossRush_ExpandBondsItem:_btnclickOnClick()
	if self._clickcb then
		self._clickcb(self._clickcbobj, self._mo:getGroupId())
	end

	if self._isOpenTipView then
		local param = {
			groupId = self._mo:getGroupId(),
			closeRoot = self._closeRoot
		}

		ViewMgr.instance:openView(ViewName.V3a9_BossRush_ExpandBondsTipView, param)
		V3a9_BossRushController.instance:dispatchEvent(V3a9_BossRushEvent.onClickExpandBonds, self._mo:getGroupId())
	end
end

function V3a9_BossRush_ExpandBondsItem:_onClickExpandBonds(groupId)
	gohelper.setActive(self._goselect, groupId and groupId == self._mo:getGroupId())
end

function V3a9_BossRush_ExpandBondsItem:_editableInitView()
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO.gameObject)

	local goGuality = gohelper.findChild(self.viewGO, "root/#Guality")

	gohelper.setActive(goGuality, true)

	self._bgVXs = self:getUserDataTb_()

	for i = 1, 4 do
		local go = gohelper.findChild(goGuality, i)

		gohelper.setActive(go, false)

		self._bgVXs[i] = go
	end

	gohelper.setActive(self._goselect, false)
end

function V3a9_BossRush_ExpandBondsItem:_editableAddEvents()
	return
end

function V3a9_BossRush_ExpandBondsItem:_editableRemoveEvents()
	return
end

function V3a9_BossRush_ExpandBondsItem:_onRefreshAddBondGroupId()
	self:refresh()
end

function V3a9_BossRush_ExpandBondsItem:onUpdateMO(mo)
	self._mo = mo

	self:refresh()
end

function V3a9_BossRush_ExpandBondsItem:getNum()
	local curActiveNum, maxNum = self._mo:getCurActiveHeroNum()

	return curActiveNum, maxNum
end

function V3a9_BossRush_ExpandBondsItem:setClickCb(clickcb, clickcbobj, closeRoot)
	self._clickcb = clickcb
	self._clickcbobj = clickcbobj
	self._closeRoot = closeRoot
end

function V3a9_BossRush_ExpandBondsItem:setParam(isShowMaxNum)
	self._isShowMaxNum = isShowMaxNum
end

function V3a9_BossRush_ExpandBondsItem:onShow(isPlayAnim)
	gohelper.setActive(self.viewGO, true)

	if self._triggerType and isPlayAnim and self.viewGO.activeInHierarchy then
		self:playAnim(self._triggerType)

		local audioId = V3a9BossRushEnum.ExpandBondsTriggerAudio[self._triggerType]

		if audioId then
			AudioMgr.instance:trigger(audioId)
		end
	end
end

function V3a9_BossRush_ExpandBondsItem:hide()
	gohelper.setActive(self.viewGO, false)

	self._triggerType = nil
	self._curNum = nil
end

function V3a9_BossRush_ExpandBondsItem:setSibling(sibling)
	gohelper.setSibling(self.viewGO, sibling)
end

function V3a9_BossRush_ExpandBondsItem:refresh()
	local curActiveMo = self._mo:getCurActiveMo()
	local curActiveNum, maxNum = self:getNum()
	local lang = luaLang("v3a9_bossrush_expandbonds_activenum")

	if self._isShowMaxNum then
		self._txtBondsNum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(lang, curActiveNum, maxNum)
	end

	local curCo = curActiveMo and curActiveMo:getConfig()

	self._triggerType = nil

	if self._curNum then
		if self._curNum ~= curActiveNum then
			self._triggerType = V3a9BossRushEnum.ExpandBondsTriggerType.switch
		end
	else
		self._triggerType = V3a9BossRushEnum.ExpandBondsTriggerType.open
	end

	self._curNum = curActiveNum

	if curCo then
		if not curCo.backingIcon then
			local bgIndex = "0"

			bgIndex = tonumber(bgIndex)

			local bg = V3a9BossRushEnum.ExpandBondsBgRes[bgIndex]

			for i, go in pairs(self._bgVXs) do
				gohelper.setActive(go, bgIndex == i)
			end

			if not string.nilorempty(bg) then
				UISpriteSetMgr.instance:setV1a4BossRushSprite(self._imageBondBG, bg)
			end

			local icon = self._mo:getIcon()

			if not string.nilorempty(icon) then
				UISpriteSetMgr.instance:setV1a4BossRushSprite(self._imageicon, icon)
			end
		end
	end
end

function V3a9_BossRush_ExpandBondsItem:playAnim(animName)
	self._animatorPlayer:Play(animName, self._playFinish, self)
end

function V3a9_BossRush_ExpandBondsItem:_playFinish()
	return
end

function V3a9_BossRush_ExpandBondsItem:onDestroyView()
	return
end

return V3a9_BossRush_ExpandBondsItem
