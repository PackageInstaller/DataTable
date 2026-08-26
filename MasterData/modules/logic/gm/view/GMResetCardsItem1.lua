-- chunkname: @modules/logic/gm/view/GMResetCardsItem1.lua

module("modules.logic.gm.view.GMResetCardsItem1", package.seeall)

local GMResetCardsItem1 = class("GMResetCardsItem1", ListScrollCell)

function GMResetCardsItem1:init(go)
	self.go = go
	self._mo = nil
	self._itemClick = SLFramework.UGUI.UIClickListener.Get(go)

	self._itemClick:AddClickListener(self._onClickItem, self)

	self._canvasGroup = gohelper.onceAddComponent(go, gohelper.Type_CanvasGroup)
end

function GMResetCardsItem1:onUpdateMO(mo)
	if not self._cardItem then
		local container = self._view.viewContainer

		self._cardGO = container:getResInst(container:getSetting().otherRes[1], gohelper.findChild(self.go, "card"), "card")
		self._cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._cardGO, FightViewCardItem)

		gohelper.setActive(gohelper.findChild(self._cardItem.go, "Image"), true)
		gohelper.setActive(self._cardItem._txt, true)
		transformhelper.transformhelper.setLocalScale(self._cardGO.transform, 0.8, 0.8, 0.8)
	end

	self._mo = mo

	if not mo.newEntityId then
		local entityId = mo.oldEntityId

		if not mo.newSkillId then
			local skillId = mo.oldSkillId

			self._cardItem:updateItem(entityId, skillId)

			self._canvasGroup.alpha = mo.newSkillId and 1 or 0.5

			local skillCO = lua_skill.configDict[skillId]

			if skillCO then
				self._cardItem._txt.text = skillCO.name or "nil"
			end
		end
	end
end

function GMResetCardsItem1:_onClickItem()
	self._mo.newSkillId = nil
	self._mo.newEntityId = nil
	self._canvasGroup.alpha = 0.5

	local model1 = GMResetCardsModel.instance:getModel1()

	model1:onModelUpdate()
end

function GMResetCardsItem1:onDestroy()
	if self._itemClick then
		self._itemClick:RemoveClickListener()

		self._itemClick = nil
	end
end

return GMResetCardsItem1
