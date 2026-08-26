-- chunkname: @modules/logic/bossrush/view/v3a9/fight/V3a9_BossRush_ExpandBondsGrid.lua

module("modules.logic.bossrush.view.v3a9.fight.V3a9_BossRush_ExpandBondsGrid", package.seeall)

local V3a9_BossRush_ExpandBondsGrid = class("V3a9_BossRush_ExpandBondsGrid", LuaCompBase)

function V3a9_BossRush_ExpandBondsGrid:ctor(param)
	self._isOpenTipView = param and param.isOpenTipView
	self._isShowMaxNum = param and param.isShowMaxNum
	self._isPlayAnim = param and param.isPlayAnim
end

function V3a9_BossRush_ExpandBondsGrid:init(go)
	self.go = go

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9_BossRush_ExpandBondsGrid:addEventListeners()
	return
end

function V3a9_BossRush_ExpandBondsGrid:removeEventListeners()
	return
end

function V3a9_BossRush_ExpandBondsGrid:_editableInitView()
	self._bondGroupItems = self:getUserDataTb_()
end

function V3a9_BossRush_ExpandBondsGrid:onStart()
	return
end

function V3a9_BossRush_ExpandBondsGrid:setItemRes(itemRes, closeRoot)
	self._itemRes = itemRes
	self._closeRoot = closeRoot
end

function V3a9_BossRush_ExpandBondsGrid:setClickCb(clickcb, clickcbobj)
	self._clickcb = clickcb
	self._clickcbobj = clickcbobj
end

function V3a9_BossRush_ExpandBondsGrid:refreshExpandBonds(limitShowCount)
	local list = V3a9_BossRushExpandBondModel.instance:getExpandBondGroupsList()
	local isHas = false

	if list then
		if not #list then
			local count = 0
			local showDict = {}
			local showCount = 0

			for i = 1, count do
				local mo = list[i]
				local activeMo = mo:getCurActiveMo()
				local activeNum = mo:getCurActiveHeroNum()

				if activeNum > 0 then
					if not self._isShowMaxNum then
						local isShow = activeMo ~= nil

						if isShow then
							local groupId = mo:getGroupId()
							local item = self:_getBondGroupsItem(groupId)

							item:onUpdateMO(mo)
							item:setClickCb(self._clickcb, self._clickcbobj, self._closeRoot)

							isHas = true

							item:setSibling(i)

							showCount = showCount + 1
							showDict[groupId] = showCount
						end
					end
				end
			end

			gohelper.setActive(self.go, isHas)

			local _limitShowCount

			if limitShowCount then
				_limitShowCount = showCount <= limitShowCount and limitShowCount or limitShowCount - 1
			end

			for groupId, item in pairs(self._bondGroupItems) do
				local index = showDict[groupId]

				if index and (not _limitShowCount or index <= _limitShowCount) then
					item:onShow(self._isPlayAnim)
				else
					item:hide()
				end
			end

			return showCount
		end
	end
end

function V3a9_BossRush_ExpandBondsGrid:_getBondGroupsItem(groupId)
	local item = self._bondGroupItems[groupId]

	if not item then
		local childGO = gohelper.clone(self._itemRes, self.go, "item_" .. groupId)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, V3a9_BossRush_ExpandBondsItem, self._isOpenTipView)

		item:setParam(self._isShowMaxNum)

		self._bondGroupItems[groupId] = item
	end

	return item
end

function V3a9_BossRush_ExpandBondsGrid:onDestroy()
	return
end

return V3a9_BossRush_ExpandBondsGrid
