-- chunkname: @modules/logic/survival/view/rewardinherit/survivalrewardselect/SurvivalRewardSelectCell.lua

module("modules.logic.survival.view.rewardinherit.survivalrewardselect.SurvivalRewardSelectCell", package.seeall)

local SurvivalRewardSelectCell = class("SurvivalRewardSelectCell", LuaCompBase)

function SurvivalRewardSelectCell:ctor(viewContainer)
	self.viewContainer = viewContainer
end

function SurvivalRewardSelectCell:init(go)
	self.viewGO = go
	self._gobagitem = gohelper.findChild(self.viewGO, "#go_bagitem")
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")
	self.btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "#btnClick")

	local survivalmapbagitem = self.viewContainer:getSetting().otherRes.survivalmapbagitem
	local obj = self.viewContainer:getResInst(survivalmapbagitem, self._gobagitem)

	self.survivalBagItem = MonoHelper.addNoUpdateLuaComOnceToGo(obj, SurvivalBagItem)
end

function SurvivalRewardSelectCell:addEventListeners()
	self.addClickCb(self, self.btnClick, self.onClickBtnAdd, self)
end

function SurvivalRewardSelectCell:onClickBtnAdd()
	if self.inheritId then
		ViewMgr.instance:openView(ViewName.SurvivalRewardSelectView)
	end
end

function SurvivalRewardSelectCell:setData(data)
	gohelper.setActive(self.viewGO, data ~= nil)

	if not data then
		return
	end

	self.inheritId = data.inheritId
	self.itemId = data.itemId

	if self.itemId then
		gohelper.setActive(self._goempty, false)
		gohelper.setActive(self.survivalBagItem.go, true)

		local mo = SurvivalBagItemMo.New()

		mo:init({
			id = self.itemId,
			count = data.count
		})
		self.survivalBagItem:updateMo(mo, {
			forceShowIcon = true
		})
	elseif self.inheritId > 0 then
		gohelper.setActive(self._goempty, self.inheritId == nil)
		gohelper.setActive(self.survivalBagItem.go, self.inheritId ~= nil)

		if not self.inheritId then
			return
		end

		self.handbookMo = SurvivalRewardInheritModel.instance:getInheritMoByInheritIdId(self.inheritId)
		self.itemMo = self.handbookMo:getSurvivalBagItemMo()

		self.survivalBagItem:updateMo(self.itemMo)
		self.survivalBagItem:setTextName(false)
		self.survivalBagItem:setShowNum(false)
	elseif self.inheritId == -10 then
		gohelper.setActive(self._goempty, true)
		gohelper.setActive(self.survivalBagItem.go, false)
	end
end

return SurvivalRewardSelectCell
