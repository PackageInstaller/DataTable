-- chunkname: @modules/logic/gm/view/GMResetCardsItem2.lua

module("modules.logic.gm.view.GMResetCardsItem2", package.seeall)

local GMResetCardsItem2 = class("GMResetCardsItem2", ListScrollCell)

function GMResetCardsItem2:init(go)
	self.go = go
	self._mo = nil
	self._itemClick = SLFramework.UGUI.UIClickListener.Get(go)

	self._itemClick:AddClickListener(self._onClickItem, self)
end

function GMResetCardsItem2:onUpdateMO(mo)
	if not self._cardItem then
		local container = self._view.viewContainer

		self._cardGO = container:getResInst(container:getSetting().otherRes[1], gohelper.findChild(self.go, "card"), "card")
		self._cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._cardGO, FightViewCardItem)

		gohelper.setActive(gohelper.findChild(self._cardItem.go, "Image"), true)
		gohelper.setActive(self._cardItem._txt, true)
		transformhelper.transformhelper.setLocalScale(self._cardGO.transform, 0.8, 0.8, 0.8)
	end

	self._mo = mo

	local skillId = mo.skillId

	self._cardItem:updateItem(mo.entityId, skillId)

	local skillCO = lua_skill.configDict[skillId]

	if skillCO then
		self._cardItem._txt.text = skillCO.name or "nil"
	end
end

function GMResetCardsItem2:_onClickItem()
	local model1 = GMResetCardsModel.instance:getModel1()

	for _, one in ipairs(model1:getList()) do
		if not one.newSkillId then
			one.newEntityId = self._mo.entityId
			one.newSkillId = self._mo.skillId

			model1:onModelUpdate()

			return
		end
	end

	GameFacade.showToast(ToastEnum.IconId, "cards full")
end

function GMResetCardsItem2:onDestroy()
	if self._itemClick then
		self._itemClick:RemoveClickListener()

		self._itemClick = nil
	end
end

return GMResetCardsItem2
