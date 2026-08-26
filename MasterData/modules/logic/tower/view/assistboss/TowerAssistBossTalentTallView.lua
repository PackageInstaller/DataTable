-- chunkname: @modules/logic/tower/view/assistboss/TowerAssistBossTalentTallView.lua

module("modules.logic.tower.view.assistboss.TowerAssistBossTalentTallView", package.seeall)

local TowerAssistBossTalentTallView = class("TowerAssistBossTalentTallView", BaseView)

function TowerAssistBossTalentTallView:onInitView()
	self.goEmpty = gohelper.findChild(self.viewGO, "#go_Empty")
	self.goScroll = gohelper.findChild(self.viewGO, "#scroll_Descr")
	self.goItem = gohelper.findChild(self.viewGO, "#scroll_Descr/Viewport/Content/#go_Item")

	gohelper.setActive(self.goItem, false)

	self.items = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerAssistBossTalentTallView:addEvents()
	return
end

function TowerAssistBossTalentTallView:removeEvents()
	return
end

function TowerAssistBossTalentTallView:_editableInitView()
	return
end

function TowerAssistBossTalentTallView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function TowerAssistBossTalentTallView:onOpen()
	self:refreshParam()
	self:refreshView()
end

function TowerAssistBossTalentTallView:refreshParam()
	self.bossId = self.viewParam.bossId
	self.bossMo = TowerAssistBossModel.instance:getBoss(self.bossId)
	self.talentTree = self.bossMo:getTalentTree()
end

function TowerAssistBossTalentTallView:refreshView()
	self:refreshList()
end

function TowerAssistBossTalentTallView:refreshList()
	local list = self.talentTree:getActiveTalentList()
	local talentCount = #list
	local isEmpty = talentCount == 0

	gohelper.setActive(self.goScroll, not isEmpty)
	gohelper.setActive(self.goEmpty, isEmpty)

	if not isEmpty then
		local itemCount = #self.items
		local runCount = math.max(itemCount, talentCount)

		for i = 1, runCount do
			local item = self:getItem(i)

			item:onUpdateMO(list[i])
		end
	end
end

function TowerAssistBossTalentTallView:getItem(index)
	if not self.items[index] then
		local go = gohelper.cloneInPlace(self.goItem, tostring(index))

		self.items[index] = MonoHelper.addNoUpdateLuaComOnceToGo(go, TowerAssistBossTalentTallItem)
	end

	return self.items[index]
end

function TowerAssistBossTalentTallView:onClose()
	return
end

function TowerAssistBossTalentTallView:onDestroyView()
	return
end

return TowerAssistBossTalentTallView
